"""
bgb_memory.py - Hooks into BGB emulator process and reads Game Boy RAM

BGB does NOT expose a flat 64KB memory image. Different GB memory regions
are stored at different Windows process addresses:

  ROM  (0x0000-0x7FFF) → rom_base  + gb_address        (confirmed)
  WRAM (0xC000-0xDFFF) → wram_base + (gb_address-0xC000) (confirmed)
  VRAM (0x8000-0x9FFF) → vram_base + (gb_address-0x8000) (scan at runtime)
"""

import ctypes
import ctypes.wintypes
import struct
import sys
import random

PROCESS_VM_READ         = 0x0010
PROCESS_VM_WRITE        = 0x0020
PROCESS_QUERY_INFORMATION = 0x0400
TH32CS_SNAPPROCESS      = 0x00000002
MEM_COMMIT              = 0x1000
PAGE_READWRITE          = 0x04
PAGE_EXECUTE_READWRITE  = 0x40


class PROCESSENTRY32(ctypes.Structure):
    _fields_ = [
        ("dwSize",              ctypes.wintypes.DWORD),
        ("cntUsage",            ctypes.wintypes.DWORD),
        ("th32ProcessID",       ctypes.wintypes.DWORD),
        ("th32DefaultHeapID",   ctypes.POINTER(ctypes.c_ulong)),
        ("th32ModuleID",        ctypes.wintypes.DWORD),
        ("cntThreads",          ctypes.wintypes.DWORD),
        ("th32ParentProcessID", ctypes.wintypes.DWORD),
        ("pcPriClassBase",      ctypes.c_long),
        ("dwFlags",             ctypes.wintypes.DWORD),
        ("szExeFile",           ctypes.c_char * 260),
    ]


class MEMORY_BASIC_INFORMATION(ctypes.Structure):
    _fields_ = [
        ("BaseAddress",       ctypes.c_void_p),
        ("AllocationBase",    ctypes.c_void_p),
        ("AllocationProtect", ctypes.wintypes.DWORD),
        ("RegionSize",        ctypes.c_size_t),
        ("State",             ctypes.wintypes.DWORD),
        ("Protect",           ctypes.wintypes.DWORD),
        ("Type",              ctypes.wintypes.DWORD),
    ]


class BGBMemoryReader:
    BGB_PROCESS_NAME = b"bgb.exe"

    NINTENDO_LOGO = bytes([
        0xCE,0xED,0x66,0x66,0xCC,0x0D,0x00,0x0B,
        0x03,0x73,0x00,0x83,0x00,0x0C,0x00,0x0D,
    ])

    # Unique bytes at GB 0xC020 for Gex: Enter the Gecko GBC.
    # WRAM_SIG_OFF is the offset of these bytes from GB 0xC000.
    WRAM_SIG     = bytes.fromhex("68696A6B00000007000603000701020707")
    WRAM_SIG_OFF = 0x20

    # VRAM at GB 0x8000: tile 0 (16 zero bytes) + tile 1 header (confirmed)
    # vram_base = scan_hit_addr - 0x8000
    VRAM_SIG = bytes(16) + bytes([
        0x10,0x00,0x38,0x10, 0x28,0x10,0x28,0x10,
        0x38,0x10,0x28,0x10, 0x2C,0x18,0x13,0x0C,
    ])

    def __init__(self):
        self.pid       = None
        self.handle    = None
        self.rom_base  = None
        self.wram_base = None  # process_addr(GB X) = wram_base + X
        self.vram_base = None  # process_addr(GB X) = vram_base + X
        self.io_base   = None  # process addr of GB 0xFF00 (BGB internal, NOT flat)
        self._k32 = ctypes.windll.kernel32 if sys.platform == "win32" else None

    @property
    def connected(self):
        return self.handle is not None and self.wram_base is not None

    # ── Connection ────────────────────────────────────────────────────────────

    def find_bgb_pid(self):
        if not self._k32:
            return None
        snap = self._k32.CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
        if snap == ctypes.wintypes.HANDLE(-1).value:
            return None
        entry = PROCESSENTRY32()
        entry.dwSize = ctypes.sizeof(PROCESSENTRY32)
        try:
            if not self._k32.Process32First(snap, ctypes.byref(entry)):
                return None
            while True:
                if entry.szExeFile.lower() == self.BGB_PROCESS_NAME:
                    return entry.th32ProcessID
                if not self._k32.Process32Next(snap, ctypes.byref(entry)):
                    break
        finally:
            self._k32.CloseHandle(snap)
        return None

    def connect(self):
        if sys.platform != "win32":
            return False, "BGB is Windows-only. Running in simulation mode."

        self.pid = self.find_bgb_pid()
        if not self.pid:
            return False, "BGB not found. Start BGB and load a ROM."

        self.handle = self._k32.OpenProcess(
            PROCESS_VM_READ | PROCESS_VM_WRITE | PROCESS_QUERY_INFORMATION, False, self.pid)
        if not self.handle:
            return False, f"Can't open BGB (PID {self.pid}). Run as Administrator."

        # Verify or refresh ROM base
        if not self._verify_rom():
            self.rom_base = self._scan_rom()

        # Verify or refresh WRAM base
        if not self._verify_wram():
            self.wram_base = self._scan_wram()

        if self.wram_base is None:
            self._k32.CloseHandle(self.handle)
            self.handle = None
            return False, "Could not locate WRAM in BGB. Is Gex loaded and running?"

        # VRAM — best effort
        if not self._verify_vram():
            self.vram_base = self._scan_vram()

        vram_info = f", VRAM=0x{self.vram_base:X}" if self.vram_base else " (VRAM not found)"
        return True, (
            f"Connected PID={self.pid}  "
            f"ROM=0x{self.rom_base:X}  "
            f"WRAM_BASE=0x{self.wram_base:X}"
            f"{vram_info}"
        )

    def connect_with_wram_hint(self, wram_hex: str):
        """
        Connect using a paste of WRAM bytes (hex string from BGB memory viewer).
        The hex string should be the first 32+ bytes starting at GB 0xC000.
        Example: "646566670000000000000000..." (copy from BGB memory viewer)
        """
        # Strip spaces, newlines, common separators
        clean = wram_hex.replace(' ', '').replace('\n', '').replace(':', '').replace('-', '').upper()
        # Remove any "C000:" style address prefixes
        import re
        clean = re.sub(r'[0-9A-F]{4}:', '', clean)
        clean = re.sub(r'[^0-9A-Fa-f]', '', clean)
        if len(clean) < 16:
            return False, "Need at least 8 bytes (16 hex chars) of WRAM data."
        try:
            needle = bytes.fromhex(clean[:64])  # use first 32 bytes max
        except ValueError as e:
            return False, f"Invalid hex: {e}"

        self._wram_hint = needle

        # Open process if not already open
        if not self.handle:
            self.pid = self.find_bgb_pid()
            if not self.pid:
                return False, "BGB not found."
            self.handle = self._k32.OpenProcess(
                PROCESS_VM_READ | PROCESS_VM_WRITE | PROCESS_QUERY_INFORMATION, False, self.pid)
            if not self.handle:
                return False, f"Can't open BGB (PID {self.pid})."

        if not self._verify_rom():
            self.rom_base = self._scan_rom()

        self.wram_base = self.scan_wram_for_bytes(needle, 0)
        if self.wram_base is None:
            return False, "WRAM bytes not found in BGB process. Make sure BGB is running with the game loaded and paste fresh bytes."

        if not self._verify_vram():
            self.vram_base = self._scan_vram()

        return True, f"Connected via WRAM hint. PID={self.pid} WRAM_BASE=0x{self.wram_base:X}"

    def disconnect(self):
        if self.handle and self._k32:
            self._k32.CloseHandle(self.handle)
        self.handle = None
        self.pid = None

    # ── Base verification ─────────────────────────────────────────────────────

    def _verify_rom(self):
        if not self.rom_base:
            return False
        d = self._read_raw(self.rom_base + 0x104, len(self.NINTENDO_LOGO))
        return d == self.NINTENDO_LOGO

    def _verify_wram(self):
        if not self.wram_base:
            return False
        d = self._read_raw(self.wram_base + 0xC000 + self.WRAM_SIG_OFF, len(self.WRAM_SIG))
        return d is not None and d == self.WRAM_SIG

    def _verify_vram(self):
        if not self.vram_base:
            return False
        d = self._read_raw(self.vram_base + 0x8000, len(self.VRAM_SIG))
        return d is not None and d == self.VRAM_SIG



    # ── Scanning ──────────────────────────────────────────────────────────────

    _ALL_R = {PAGE_READWRITE, PAGE_EXECUTE_READWRITE, 0x02, 0x20, 0x10}

    def _iter_regions(self, max_size=32*1024*1024):
        mbi = MEMORY_BASIC_INFORMATION()
        addr = 0
        while True:
            if not self._k32.VirtualQueryEx(
                    self.handle, ctypes.c_void_p(addr),
                    ctypes.byref(mbi), ctypes.sizeof(mbi)):
                break
            base = mbi.BaseAddress or 0
            size = mbi.RegionSize
            if (mbi.State == MEM_COMMIT and mbi.Protect in self._ALL_R
                    and 0x1000 <= size <= max_size):
                yield base, size
            nxt = base + size
            if nxt <= addr:
                break
            addr = nxt

    def _scan_rom(self):
        VALID_CT = set(range(0x20)) | {0x20,0xFC,0xFD,0xFE,0xFF}
        cands = []
        for base, size in self._iter_regions():
            chunk = 65536
            for off in range(0, size, chunk):
                data = self._read_raw(base+off, min(chunk, size-off))
                if not data:
                    continue
                idx = data.find(self.NINTENDO_LOGO)
                if idx == -1:
                    continue
                gb_base = base + off + idx - 0x104
                hdr = self._read_raw(gb_base + 0x100, 0x50)
                if not hdr or len(hdr) < 0x50:
                    continue
                score = (2 if hdr[0x47] in VALID_CT else 0)
                score += sum(1 for b in hdr[0x34:0x44] if 0x20 <= b <= 0x7E or b == 0)
                cands.append((gb_base, score))
        if not cands:
            return None
        cands.sort(key=lambda c: c[1], reverse=True)
        return cands[0][0]

    def scan_wram_for_bytes(self, needle: bytes, needle_gb_offset: int = 0):
        """
        Scan process memory for needle, which starts at GB address 0xC000 + needle_gb_offset.
        The live copy has GB 0xC000 page-aligned (c000_proc & 0xFFF == 0).
        Returns wram_base = proc_addr_of_GB_0, or None.
        """
        if not needle or len(needle) < 4:
            return None
        candidates = []
        for base, size in self._iter_regions():
            chunk = 65536
            for off in range(0, size, chunk):
                data = self._read_raw(base + off, min(chunk + len(needle), size - off))
                if not data:
                    continue
                idx = 0
                while True:
                    idx = data.find(needle, idx)
                    if idx == -1:
                        break
                    hit   = base + off + idx        # proc addr of GB 0xC000 + needle_gb_offset
                    c000  = hit - needle_gb_offset  # proc addr of GB 0xC000
                    if c000 & 0xFFF == 0:
                        gb_base = c000 - 0xC000
                        d = self._read_raw(gb_base + 0xD000, 64)
                        if d:
                            candidates.append(gb_base)
                    idx += len(needle)

        if not candidates:
            return None
        return min(candidates)

    def _scan_wram(self):
        # Use the built-in Gex signature (offset 0x20 from C000) for auto-connect
        return self.scan_wram_for_bytes(self.WRAM_SIG, self.WRAM_SIG_OFF)

    def _scan_vram(self):
        """Returns vram_base such that process_addr(GB X) = vram_base + X."""
        hits = []
        for base, size in self._iter_regions(64*1024*1024):
            if base > 0x70000000:   # skip DLLs
                continue
            chunk = 65536
            for off in range(0, size, chunk):
                data = self._read_raw(base+off, min(chunk+len(self.VRAM_SIG), size-off))
                if not data:
                    continue
                idx = data.find(self.VRAM_SIG)
                if idx != -1:
                    hit = base + off + idx   # process addr of GB 0x8000
                    hits.append(hit - 0x8000)
        if not hits:
            return None
        # Prefer the candidate closest to WRAM base (same memory arena)
        if self.wram_base:
            hits.sort(key=lambda b: abs((b + 0x8000) - (self.wram_base + 0xC000)))
        return hits[0]

    # ── Low-level read ────────────────────────────────────────────────────────

    def _read_raw(self, address, size):
        if not self.handle or size <= 0:
            return None
        buf = ctypes.create_string_buffer(size)
        n = ctypes.c_size_t(0)
        ok = self._k32.ReadProcessMemory(
            self.handle, ctypes.c_void_p(address), buf, size, ctypes.byref(n))
        if ok and n.value == size:
            return bytes(buf)
        if n.value > 0:
            return bytes(buf)[:n.value]
        return None

    # ── GB address router ─────────────────────────────────────────────────────

    def read_gb(self, gb_address, size):
        """
        Read bytes from GB address space, routing to correct BGB region:
          0x0000-0x7FFF → ROM
          0x8000-0x9FFF → VRAM
          0xA000-0xBFFF → ExtRAM (not mapped, returns zeros)
          0xC000-0xDFFF → WRAM
          0xE000-0xFDFF → WRAM echo
          0xFE00+       → not mapped, returns zeros
        """
        if not self.connected or size <= 0:
            return None
        if gb_address + size > 0x10000:
            size = 0x10000 - gb_address

        result = bytearray(size)
        pos = 0
        while pos < size:
            addr = gb_address + pos
            rem  = size - pos

            if addr < 0x8000:                          # ROM
                chunk = min(rem, 0x8000 - addr)
                data  = self._read_raw(self.rom_base + addr, chunk) if self.rom_base else None

            elif addr < 0xA000:                        # VRAM (flat: wram_base + addr)
                chunk = min(rem, 0xA000 - addr)
                data  = self._read_raw(self.wram_base + addr, chunk)

            elif addr < 0xC000:                        # ExtRAM (flat: wram_base + addr)
                chunk = min(rem, 0xC000 - addr)
                data  = self._read_raw(self.wram_base + addr, chunk) or bytes(chunk)

            elif addr < 0xE000:                        # WRAM
                chunk = min(rem, 0xE000 - addr)
                data  = self._read_raw(self.wram_base + addr, chunk)

            elif addr < 0xFE00:                        # Echo RAM (mirrors WRAM)
                chunk = min(rem, 0xFE00 - addr)
                data  = self._read_raw(self.wram_base + addr - 0x2000, chunk)
            
            elif addr < 0xFF00:                        # OAM (FE00-FEFF)
                chunk = min(rem, 0xFF00 - addr)
                if self.wram_base:
                    data = self._read_raw(self.wram_base + 0x7E00 + (addr - 0xFE00), chunk)
                else:
                    data = bytes(chunk)

            elif addr < 0xFF80:                        # IO (FF00-FF7F)
                chunk = min(rem, 0xFF80 - addr)
                if self.io_base:
                    data = self._read_raw(self.io_base + (addr - 0xFF00), chunk)
                else:
                    data = bytes(chunk)
                    
            else:                                      # HRAM (FF80-FFFF)
                chunk = min(rem, 0x10000 - addr)
                if self.wram_base:
                    data = self._read_raw(self.wram_base + 0x7F80 + (addr - 0xFF80), chunk)
                else:
                    data = bytes(chunk)
                    
            if data is None:
                return None
            result[pos:pos + len(data)] = data[:rem]
            pos += chunk

        return bytes(result)

    # ── Convenience helpers ───────────────────────────────────────────────────

    def read_byte(self, gb_address):
        d = self.read_gb(gb_address, 1)
        return d[0] if d else None

    def read_word(self, gb_address):
        d = self.read_gb(gb_address, 2)
        return struct.unpack_from("<H", d)[0] if d else None

    def write_byte(self, gb_address, value):
        """Write a single byte to GB WRAM address space."""
        if not self.wram_base or not (0xC000 <= gb_address < 0xE000):
            return False
        proc_addr = self.wram_base + gb_address
        buf = ctypes.create_string_buffer(bytes([value & 0xFF]))
        n = ctypes.c_size_t(0)
        ok = self._k32.WriteProcessMemory(
            self.handle, ctypes.c_void_p(proc_addr), buf, 1, ctypes.byref(n))
        return bool(ok and n.value == 1)

    def write_word(self, gb_address, value):
        """Write a 16-bit little-endian word to GB WRAM address space."""
        if not self.wram_base or not (0xC000 <= gb_address < 0xDFFF):
            return False
        proc_addr = self.wram_base + gb_address
        buf = ctypes.create_string_buffer(struct.pack("<H", value & 0xFFFF))
        n = ctypes.c_size_t(0)
        ok = self._k32.WriteProcessMemory(
            self.handle, ctypes.c_void_p(proc_addr), buf, 2, ctypes.byref(n))
        return bool(ok and n.value == 2)

    def read_all_wram(self):
        return self.read_gb(0xC000, 0x2000)

    def read_vram(self):
        return self.read_gb(0x8000, 0x2000)

    def read_oam(self):
        return self.read_gb(0xFE00, 0xA0)

    def read_rom_header(self):
        return self.read_gb(0x0100, 0x50)

    def dump_region_info(self):
        def fmt(v): return f"0x{v:X}" if v else "unknown"
        return (
            f"ROM={fmt(self.rom_base)}  "
            f"WRAM_BASE={fmt(self.wram_base)}  "
            f"VRAM_BASE={fmt(self.vram_base)}"
        )

    def read_absolute_byte(self, address):
        """Read a single byte from a raw Windows process address."""
        if not self.handle or address is None:
            return 0
        
        # Define types to prevent crashes on 64-bit systems
        self._k32.ReadProcessMemory.argtypes = [
            ctypes.wintypes.HANDLE, ctypes.c_void_p, ctypes.c_void_p, 
            ctypes.c_size_t, ctypes.POINTER(ctypes.c_size_t)
        ]
        
        buf = ctypes.create_string_buffer(1)
        n = ctypes.c_size_t(0)
        
        # Use c_void_p to safely wrap the high-memory address
        ok = self._k32.ReadProcessMemory(
            self.handle, ctypes.c_void_p(address), buf, 1, ctypes.byref(n)
        )
        return struct.unpack("B", buf.raw)[0] if (ok and n.value == 1) else 0

    def read_absolute_word(self, address):
        """Reads 2 bytes (little-endian) from a raw Windows process address."""
        # Use self.handle (NOT self.h_proc)
        if not self.handle or address is None: 
            return 0
            
        self._k32.ReadProcessMemory.argtypes = [
            ctypes.wintypes.HANDLE, ctypes.c_void_p, ctypes.c_void_p, 
            ctypes.c_size_t, ctypes.POINTER(ctypes.c_size_t)
        ]
        
        buf = ctypes.create_string_buffer(2)
        n = ctypes.c_size_t(0)
        
        ok = self._k32.ReadProcessMemory(
            self.handle, ctypes.c_void_p(address), buf, 2, ctypes.byref(n)
        )
        
        if ok and n.value == 2:
            return struct.unpack("<H", buf.raw)[0]
        return 0

# ── Simulation mode ───────────────────────────────────────────────────────────

class SimulatedBGBMemoryReader(BGBMemoryReader):

    def __init__(self):
        super().__init__()
        self._sim_time = 0
        self._build_fake_memory()

    def _build_fake_memory(self):
        self._mem = bytearray(0x10000)
        logo = bytes([
            0xCE,0xED,0x66,0x66,0xCC,0x0D,0x00,0x0B,
            0x03,0x73,0x00,0x83,0x00,0x0C,0x00,0x0D,
            0x00,0x08,0x11,0x1F,0x88,0x89,0x00,0x0E,
            0xDC,0xCC,0x6E,0xE6,0xDD,0xDD,0xD9,0x99,
            0xBB,0xBB,0x67,0x63,0x6E,0x0E,0xEC,0xCC,
            0xDD,0xDC,0x99,0x9F,0xBB,0xB9,0x33,0x3E,
        ])
        self._mem[0x0104:0x0104+len(logo)] = logo
        self._mem[0x0134:0x0143] = b"GEX GECKO      \x00"
        self._mem[0x0147] = 0x19
        self._build_fake_map()
        self._update_player_pos(5, 4)

    def _build_fake_map(self, seed=42):
        random.seed(seed)
        w, h = 20, 18
        MAP = 0xC800
        for y in range(h):
            for x in range(w):
                if x==0 or y==0 or x==w-1 or y==h-1: t=1
                elif random.random()<0.15: t=1
                elif random.random()<0.1:  t=3
                elif 8<=x<=11 and 6<=y<=9: t=2
                else: t=0
                self._mem[MAP + y*w + x] = t
        self._mem[0xC7F0]=w; self._mem[0xC7F1]=h
        self._map_w=w; self._map_h=h; self._map_addr=MAP

    def _update_player_pos(self, x, y):
        self._mem[0xC100] = x & 0xFF
        self._mem[0xC101] = (x>>8) & 0xFF
        self._mem[0xC102] = y & 0xFF
        self._mem[0xC103] = (y>>8) & 0xFF

    def connect(self):
        self.rom_base=0; self.wram_base=0; self.vram_base=0
        return True, "Simulation mode — BGB not running or not on Windows."

    def disconnect(self):
        self.wram_base = None

    @property
    def connected(self):
        return self.wram_base is not None

    def read_gb(self, gb_address, size):
        self._sim_time += 1
        if self._sim_time % 30 == 0:
            px = self._mem[0xC100]|(self._mem[0xC101]<<8)
            py = self._mem[0xC102]|(self._mem[0xC103]<<8)
            dx,dy = random.choice([(1,0),(-1,0),(0,1),(0,-1)])
            nx,ny = px+dx, py+dy
            if (1<=nx<self._map_w-1 and 1<=ny<self._map_h-1
                    and self._mem[self._map_addr+ny*self._map_w+nx]!=1):
                self._update_player_pos(nx,ny)
        if gb_address+size > len(self._mem):
            size = len(self._mem)-gb_address
        return bytes(self._mem[gb_address:gb_address+size])

    def read_byte(self, a): return self._mem[a] if a<len(self._mem) else None
    def read_word(self, a):
        if a+1 < len(self._mem):
            return struct.unpack_from("<H", self._mem, a)[0]
        return None
    def write_byte(self, a, v):
        if a < len(self._mem): self._mem[a] = v & 0xFF; return True
        return False
    def write_word(self, a, v):
        if a+1 < len(self._mem):
            struct.pack_into("<H", self._mem, a, v & 0xFFFF); return True
        return False
    def dump_region_info(self): return "Simulation mode."
