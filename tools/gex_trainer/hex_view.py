"""
hex_view.py - Live hex dump viewer for GB memory regions.
Shows 16 bytes per row with ASCII sidebar, highlights changed bytes in red.

Performance approach: build the entire display as one big string, insert it
once, then apply colour tags only to visible rows. Avoids per-byte insert
calls and the broken virtual-scroll placeholder approach.
"""

import tkinter as tk
from tkinter import ttk

C_BG      = "#0D1117"
C_ADDR    = "#58A6FF"
C_HEX     = "#E6EDF3"
C_ASCII   = "#7EE787"
C_CHANGED = "#FF6B6B"
C_ZERO    = "#30363D"
C_HEADER  = "#00FF88"

BYTES_PER_ROW = 16
FONT          = ("Courier New", 9)
OVERSCAN      = 6   # extra rows to tag above/below visible area


class HexView(tk.Frame):

    def __init__(self, parent, **kw):
        super().__init__(parent, bg=C_BG, **kw)
        self._base_addr  = 0xC000
        self._data       = None
        self._prev_data  = None
        self._total_rows = 0
        self._last_tagged_range = (-1, -1)
        self._build_ui()

    # ── Build UI ──────────────────────────────────────────────────────────────

    def _build_ui(self):
        header = tk.Frame(self, bg=C_BG)
        header.pack(fill=tk.X, padx=8, pady=(8, 4))
        tk.Label(header, text="MEMORY VIEWER", font=("Courier New", 11, "bold"),
                 fg=C_HEADER, bg=C_BG).pack(side=tk.LEFT)

        self._region_var = tk.StringVar(value="WRAM  0xC000")
        sel = ttk.Combobox(header, textvariable=self._region_var, width=14, font=FONT,
                           values=["ROM   0x0000","VRAM  0x8000","XRAM  0xA000",
                                   "WRAM  0xC000","OAM   0xFE00",
                                   "IO    0xFF00","HRAM  0xFF80"])
        sel.pack(side=tk.RIGHT)
        sel.bind("<<ComboboxSelected>>", self._on_region_change)

        col_hdr = tk.Frame(self, bg="#161B22")
        col_hdr.pack(fill=tk.X, padx=8)
        tk.Label(col_hdr,
                 text="  ADDR  " + " ".join(f"{i:02X}" for i in range(16)) + "  ASCII",
                 font=FONT, fg=C_ADDR, bg="#161B22", anchor="w").pack(fill=tk.X)

        txt_frame = tk.Frame(self, bg=C_BG)
        txt_frame.pack(fill=tk.BOTH, expand=True, padx=8, pady=(0, 8))

        self._text = tk.Text(txt_frame, font=FONT, bg=C_BG, fg=C_HEX,
                             state=tk.DISABLED, wrap=tk.NONE, cursor="arrow",
                             borderwidth=0, highlightthickness=0)
        vsb = tk.Scrollbar(txt_frame, orient=tk.VERTICAL,  command=self._text.yview)
        hsb = tk.Scrollbar(txt_frame, orient=tk.HORIZONTAL, command=self._text.xview)
        self._text.configure(yscrollcommand=self._on_yscroll, xscrollcommand=hsb.set)
        self._vsb = vsb

        vsb.pack(side=tk.RIGHT, fill=tk.Y)
        hsb.pack(side=tk.BOTTOM, fill=tk.X)
        self._text.pack(fill=tk.BOTH, expand=True)

        self._text.tag_config("addr",    foreground=C_ADDR)
        self._text.tag_config("zero",    foreground=C_ZERO)
        self._text.tag_config("changed", foreground=C_CHANGED)
        self._text.tag_config("ascii",   foreground=C_ASCII)

        self._text.bind("<MouseWheel>", self._on_mousewheel)
        self._text.bind("<Button-4>",   self._on_mousewheel)
        self._text.bind("<Button-5>",   self._on_mousewheel)

    # ── Public API ────────────────────────────────────────────────────────────

    def update_data(self, data, base_addr=None):
        if base_addr is not None:
            self._base_addr = base_addr
        changed = (data != self._data)
        self._prev_data = self._data
        self._data      = data
        if data:
            self._total_rows = (len(data) + BYTES_PER_ROW - 1) // BYTES_PER_ROW
        if changed:
            self._full_redraw()
        else:
            # Data same — just re-tag visible rows (handles scroll-into-view)
            self._tag_visible()

    def get_selected_region_addr(self):  return self._base_addr
    def get_selected_region_size(self):
        return {0x0000:0x4000,0x8000:0x2000,0xA000:0x2000,
                0xC000:0x2000,0xFE00:0x00A0,
                0xFF00:0x0080,0xFF80:0x0080}.get(self._base_addr, 0x100)

    def set_no_data(self, msg="Waiting for data..."):
        t = self._text
        t.configure(state=tk.NORMAL)
        t.delete("1.0", tk.END)
        t.insert(tk.END, f"\n  {msg}", "addr")
        t.configure(state=tk.DISABLED)

    # ── Internal ──────────────────────────────────────────────────────────────

    def _on_region_change(self, _=None):
        self._base_addr = {"ROM   0x0000":0x0000,"VRAM  0x8000":0x8000,
                           "XRAM  0xA000":0xA000,"WRAM  0xC000":0xC000,
                           "OAM   0xFE00":0xFE00,"IO    0xFF00":0xFF00,
                           "HRAM  0xFF80":0xFF80
                           }.get(self._region_var.get(), 0xC000)

    def _on_yscroll(self, *args):
        self._vsb.set(*args)
        self._tag_visible()

    def _on_mousewheel(self, event):
        delta = getattr(event, "delta", 0)
        if event.num == 4 or delta > 0:
            self._text.yview_scroll(-3, "units")
        else:
            self._text.yview_scroll(3, "units")
        self._tag_visible()
        return "break"

    def _visible_row_range(self):
        if not self._total_rows:
            return 0, 0
        top, bot = self._text.yview()
        first = max(0, int(top * self._total_rows) - OVERSCAN)
        last  = min(self._total_rows, int(bot * self._total_rows) + 1 + OVERSCAN)
        return first, last

    def _full_redraw(self):
        """Rebuild entire text content as plain monochrome, then colour visible rows."""
        if not self._data:
            return
        t = self._text
        scroll_pos = t.yview()[0]

        # Build entire text in one shot — no tags yet, just raw text
        lines = []
        for row_idx in range(self._total_rows):
            rs   = row_idx * BYTES_PER_ROW
            row  = self._data[rs: rs + BYTES_PER_ROW]
            addr = self._base_addr + rs
            hex_part   = " ".join(f"{b:02X}" for b in row)
            pad        = "   " * (BYTES_PER_ROW - len(row))
            ascii_part = "".join(chr(b) if 0x20 <= b <= 0x7E else "." for b in row)
            lines.append(f"  {addr:04X}  {hex_part}{pad}  {ascii_part}")

        t.configure(state=tk.NORMAL)
        t.delete("1.0", tk.END)
        t.insert("1.0", "\n".join(lines))
        t.configure(state=tk.DISABLED)
        t.yview_moveto(scroll_pos)

        self._last_tagged_range = (-1, -1)
        self._tag_visible()

    def _tag_visible(self):
        """Apply colour tags to currently visible rows only."""
        if not self._data:
            return
        first, last = self._visible_row_range()
        if (first, last) == self._last_tagged_range:
            return
        self._last_tagged_range = (first, last)

        t   = self._text
        bpr = BYTES_PER_ROW
        t.configure(state=tk.NORMAL)

        for row_idx in range(first, last):
            rs   = row_idx * BYTES_PER_ROW
            row  = self._data[rs: rs + bpr]
            if not row:
                continue

            line_no = row_idx + 1   # tk.Text lines are 1-based

            # Clear all tags on this line first
            for tag in ("addr", "zero", "changed", "ascii"):
                t.tag_remove(tag, f"{line_no}.0", f"{line_no}.end")

            # Address: columns 0-7  ("  XXXX  " = 8 chars)
            t.tag_add("addr", f"{line_no}.0", f"{line_no}.8")

            # Hex bytes: each byte = 3 chars ("HH "), starting at col 8
            col = 8
            for i, byte in enumerate(row):
                prev = (self._prev_data[rs + i]
                        if self._prev_data and rs + i < len(self._prev_data)
                        else byte)
                tag = "changed" if byte != prev else ("zero" if byte == 0 else None)
                if tag:
                    t.tag_add(tag, f"{line_no}.{col}", f"{line_no}.{col+2}")
                col += 3

            # ASCII sidebar: starts after hex + padding + 2-space separator
            hex_cols  = bpr * 3          # "HH " × 16 = 48 chars
            asc_start = 8 + hex_cols + 2
            asc_end   = asc_start + len(row)
            t.tag_add("ascii", f"{line_no}.{asc_start}", f"{line_no}.{asc_end}")

        t.configure(state=tk.DISABLED)
