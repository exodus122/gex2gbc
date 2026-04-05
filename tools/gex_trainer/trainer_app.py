"""
trainer_app.py - Main window and polling loop for the BGB Trainer.
"""

import sys
import tkinter as tk
from tkinter import ttk, messagebox
import threading
import time

from bgb_memory import BGBMemoryReader, SimulatedBGBMemoryReader
from game_maps import detect_game
from collision_view import CollisionMapView
from hex_view import HexView
from sprite_view import SpriteView

POLL_INTERVAL_MS = 150    # how often to refresh memory (~7 fps)

C_BG     = "#0D1117"
C_PANEL  = "#161B22"
C_BORDER = "#21262D"
C_GREEN  = "#00FF88"
C_RED    = "#FF4444"
C_YELLOW = "#FFD700"
C_TEXT   = "#C9D1D9"
C_DIM    = "#667788"


class TrainerApp:
    """Root application - builds the main window and drives the polling loop."""

    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("BGB Trainer  //  Game Boy Memory Visualizer")
        self.root.configure(bg=C_BG)
        self.root.minsize(900, 600)
        self.root.geometry("1200x750")
        
        self._scx_var = tk.StringVar(value="0")
        self._scy_var = tk.StringVar(value="0")

        # Always use real reader on Windows; simulation only on non-Windows
        self._sim_mode = sys.platform != "win32"
        self._reader = SimulatedBGBMemoryReader() if self._sim_mode else BGBMemoryReader()

        self._profile = None
        self._rom_title = "—"
        self._connected = False
        self._paused = False

        self._build_ui()
        self._try_connect()

    # ── UI Construction ───────────────────────────────────────────────────────

    def _build_ui(self):
        # ── Title bar ────────────────────────────────────────────────────────
        title_bar = tk.Frame(self.root, bg=C_PANEL, height=42)
        title_bar.pack(fill=tk.X, side=tk.TOP)
        title_bar.pack_propagate(False)

        tk.Label(title_bar, text="◈  BGB TRAINER",
                 font=("Courier New", 13, "bold"),
                 fg=C_GREEN, bg=C_PANEL).pack(side=tk.LEFT, padx=12, pady=8)

        # ROM name label
        self._rom_label = tk.Label(title_bar, text="No ROM",
                                   font=("Courier New", 10),
                                   fg=C_YELLOW, bg=C_PANEL)
        self._rom_label.pack(side=tk.LEFT, padx=(0, 16))

        # Status indicator
        self._status_dot = tk.Label(title_bar, text="●",
                                    font=("Courier New", 14),
                                    fg=C_RED, bg=C_PANEL)
        self._status_dot.pack(side=tk.LEFT)
        self._status_label = tk.Label(title_bar, text="Disconnected",
                                      font=("Courier New", 9),
                                      fg=C_DIM, bg=C_PANEL)
        self._status_label.pack(side=tk.LEFT, padx=4)

        # Toolbar buttons
        btn_style = dict(font=("Courier New", 9, "bold"), relief=tk.FLAT,
                         padx=10, pady=4, cursor="hand2")

        self._connect_btn = tk.Button(
            title_bar, text="⟳  CONNECT",
            bg="#1F6FEB", fg="white",
            activebackground="#388BFD", activeforeground="white",
            command=self._try_connect, **btn_style)
        self._connect_btn.pack(side=tk.RIGHT, padx=8, pady=6)

        self._paste_btn = tk.Button(
            title_bar, text="📋  PASTE WRAM",
            bg="#2D3B2D", fg="#88CC88",
            activebackground="#3D4B3D", activeforeground="#AAEAAA",
            command=self._paste_wram_dialog, **btn_style)
        self._paste_btn.pack(side=tk.RIGHT, padx=(0, 4), pady=6)

        self._pause_btn = tk.Button(
            title_bar, text="⏸  PAUSE",
            bg="#21262D", fg=C_TEXT,
            activebackground="#30363D", activeforeground=C_TEXT,
            command=self._toggle_pause, **btn_style)
        self._pause_btn.pack(side=tk.RIGHT, padx=(0, 4), pady=6)

        # Refresh rate label
        self._fps_var = tk.StringVar(value="— fps")
        tk.Label(title_bar, textvariable=self._fps_var,
                 font=("Courier New", 8), fg=C_DIM, bg=C_PANEL).pack(
            side=tk.RIGHT, padx=8)

        # ── Separator ────────────────────────────────────────────────────────
        tk.Frame(self.root, bg=C_BORDER, height=1).pack(fill=tk.X)

        # ── Main notebook (tabs) ─────────────────────────────────────────────
        style = ttk.Style()
        style.theme_use("clam")
        style.configure("TNotebook",
                        background=C_BG, borderwidth=0)
        style.configure("TNotebook.Tab",
                        background=C_PANEL, foreground=C_DIM,
                        font=("Courier New", 10, "bold"),
                        padding=(14, 6))
        style.map("TNotebook.Tab",
                  background=[("selected", C_BG)],
                  foreground=[("selected", C_GREEN)])

        nb = ttk.Notebook(self.root)
        nb.pack(fill=tk.BOTH, expand=True)

        # Tab 1: Collision map
        self._collision_view = CollisionMapView(nb)
        nb.add(self._collision_view, text="  COLLISION MAP  ")

        # Tab 2: Hex viewer
        self._hex_view = HexView(nb)
        nb.add(self._hex_view, text="  HEX VIEWER  ")

        # Tab 3: Sprite table
        self._sprite_view = SpriteView(nb)
        nb.add(self._sprite_view, text="  SPRITES / OAM  ")

        # Tab 4: Player info
        self._info_tab = tk.Frame(nb, bg=C_BG)
        nb.add(self._info_tab, text="  PLAYER INFO  ")
        self._build_info_tab()

        self._nb = nb

        # ── Status bar ───────────────────────────────────────────────────────
        tk.Frame(self.root, bg=C_BORDER, height=1).pack(fill=tk.X)
        status_bar = tk.Frame(self.root, bg=C_PANEL, height=24)
        status_bar.pack(fill=tk.X, side=tk.BOTTOM)
        status_bar.pack_propagate(False)

        self._status_bar_var = tk.StringVar(value="Ready")
        tk.Label(status_bar, textvariable=self._status_bar_var,
                 font=("Courier New", 8), fg=C_DIM, bg=C_PANEL,
                 anchor="w").pack(fill=tk.X, padx=8)

    def _build_info_tab(self):
        f = self._info_tab
        pad = dict(padx=20, pady=8, sticky="w")

        tk.Label(f, text="PLAYER STATE", font=("Courier New", 13, "bold"),
                 fg=C_GREEN, bg=C_BG).grid(row=0, column=0, columnspan=4,
                 padx=20, pady=(16, 4), sticky="w")

        fields = [
            ("Map X",      "_px_var"),
            ("Map Y",      "_py_var"),
            ("Facing",     "_facing_var"),
            ("Map ID",     "_mapid_var"),
            ("HP",         "_hp_var"),
            ("Max HP",     "_maxhp_var"),
            ("Money",      "_money_var"),
            ("Steps",      "_steps_var"),
            ("SCX (Scroll X)", "_scx_var"), # Added
            ("SCY (Scroll Y)", "_scy_var"), # Added
        ]
        self._px_var = self._py_var = self._facing_var = self._mapid_var = None
        self._hp_var = self._maxhp_var = self._money_var = self._steps_var = None

        for i, (label, attr) in enumerate(fields):
            row, col = divmod(i, 2)
            var = tk.StringVar(value="—")
            setattr(self, attr, var)
            tk.Label(f, text=label + ":", font=("Courier New", 10),
                     fg=C_DIM, bg=C_BG).grid(row=row + 1, column=col * 2,
                     padx=(20, 4), pady=6, sticky="e")
            tk.Label(f, textvariable=var, font=("Courier New", 10, "bold"),
                     fg=C_TEXT, bg=C_BG, width=14, anchor="w").grid(
                row=row + 1, column=col * 2 + 1,
                padx=(0, 20), pady=6, sticky="w")

        # Raw WRAM addresses info box
        info_text = (
            "Gex memory addresses:\n"
            #"  wXCoord    = 0xD361    wYCoord   = 0xD362\n"
            #"  wCurMap    = 0xD35E    wFacing   = 0xC109\n"
            #"  wPartyHP   = 0xD16C    wMoney    = 0xD347\n"
            #"  wStepCount = 0xD35A    wTileMap  = 0xC6E8\n\n"
            "These addresses are game-specific.\n"
            "Edit game_maps.py to add your own game's memory layout."
        )
        tk.Label(f, text=info_text, font=("Courier New", 9),
                 fg=C_DIM, bg=C_BG, justify=tk.LEFT,
                 relief=tk.FLAT).grid(row=6, column=0, columnspan=4,
                 padx=20, pady=(16, 0), sticky="w")

    # ── Connection ────────────────────────────────────────────────────────────

    def _try_connect(self):
        self._set_status("Connecting…", C_YELLOW)
        self._status_bar_var.set("Scanning for BGB process…")
        ok, msg = self._reader.connect()
        self._status_bar_var.set(msg)
        if ok:
            self._connected = True
            label = "Simulation" if self._sim_mode else "Connected"
            color = C_YELLOW if self._sim_mode else C_GREEN
            self._set_status(label, color)
            self._detect_game()
            self._schedule_poll()
        else:
            self._connected = False
            self._set_status("Disconnected", C_RED)

    def _paste_wram_dialog(self):
        dialog = tk.Toplevel(self.root)
        dialog.title("Paste WRAM Bytes")
        dialog.configure(bg=C_BG)
        dialog.geometry("560x300")
        dialog.resizable(False, False)
        dialog.transient(self.root)
        dialog.grab_set()

        tk.Label(dialog, text="Paste WRAM bytes from BGB memory viewer",
                 font=("Courier New", 11, "bold"), fg=C_GREEN, bg=C_BG
                 ).pack(pady=(16, 4), padx=16, anchor="w")
        tk.Label(dialog,
                 text=("In BGB: right-click -> Other -> Memory viewer -> address C000\n"
                       "Select ~32 bytes, copy as hex and paste below.\n"
                       "Spaces, colons and newlines are stripped automatically."),
                 font=("Courier New", 8), fg=C_DIM, bg=C_BG, justify=tk.LEFT
                 ).pack(padx=16, pady=(0, 8), anchor="w")

        txt = tk.Text(dialog, height=4, font=("Courier New", 10),
                      bg=C_PANEL, fg=C_TEXT, insertbackground=C_TEXT,
                      relief=tk.FLAT, bd=4)
        txt.pack(fill=tk.X, padx=16, pady=(0, 6))
        txt.focus_set()

        status_var = tk.StringVar(value="")
        tk.Label(dialog, textvariable=status_var,
                 font=("Courier New", 9), fg=C_RED, bg=C_BG
                 ).pack(padx=16, anchor="w")

        def do_connect():
            hex_str = txt.get("1.0", tk.END).strip()
            if not hex_str:
                status_var.set("Paste some hex bytes first.")
                return
            ok, msg = self._reader.connect_with_wram_hint(hex_str)
            if ok:
                self._connected = True
                self._set_status("Connected", C_GREEN)
                self._status_bar_var.set(msg)
                self._detect_game()
                self._schedule_poll()
                dialog.destroy()
            else:
                status_var.set(msg)

        btn_f = tk.Frame(dialog, bg=C_BG)
        btn_f.pack(pady=8)
        tk.Button(btn_f, text="Connect", font=("Courier New", 10, "bold"),
                  bg="#1F6FEB", fg="white", relief=tk.FLAT,
                  padx=16, pady=6, cursor="hand2",
                  command=do_connect).pack(side=tk.LEFT, padx=8)
        tk.Button(btn_f, text="Cancel", font=("Courier New", 10),
                  bg=C_PANEL, fg=C_DIM, relief=tk.FLAT,
                  padx=16, pady=6, cursor="hand2",
                  command=dialog.destroy).pack(side=tk.LEFT)
        dialog.bind("<Return>", lambda e: do_connect())

    def _detect_game(self):
        header = self._reader.read_gb(0x0100, 0x50)
        self._profile, self._rom_title = detect_game(header)
        self._rom_label.configure(
            text=f"[{self._rom_title}]  —  {self._profile['name']}"
        )

    def _set_status(self, text, color):
        self._status_dot.configure(fg=color)
        self._status_label.configure(text=text)

    def _toggle_pause(self):
        self._paused = not self._paused
        if self._paused:
            self._pause_btn.configure(text="▶  RESUME", bg="#2D6A2D")
            self._status_bar_var.set("Paused — memory polling suspended")
        else:
            self._pause_btn.configure(text="⏸  PAUSE", bg="#21262D")
            self._status_bar_var.set("Running")
            self._schedule_poll()

    # ── Polling loop ──────────────────────────────────────────────────────────

    def _schedule_poll(self):
        self.root.after(POLL_INTERVAL_MS, self._poll)

    _last_poll = 0.0

    def _poll(self):
        if self._paused or not self._connected:
            return

        t0 = time.perf_counter()

        try:
            self._refresh_all()
        except Exception as e:
            self._status_bar_var.set(f"Poll error: {e}")

        elapsed = time.perf_counter() - t0
        fps = 1.0 / max(elapsed, 0.001)
        self._fps_var.set(f"{fps:.0f} fps")

        # Re-schedule
        if not self._paused:
            self._schedule_poll()

    def _refresh_all(self):
        profile = self._profile
        if not profile:
            return

        r = self._reader

        # ── Collision map ─────────────────────────────────────────────────────
        map_addr   = profile.get("map_data", 0x9800)
        map_w      = profile.get("map_width", 20)
        map_h      = profile.get("map_height", 18)
        map_bytes  = r.read_gb(map_addr, map_w * map_h)

        # ── Entity buffer (D200-D2FF, 8 × 0x20 bytes) ───────────────────────
        from collision_view import parse_entities, ENTITY_BUFFER_ADDR, ENTITY_COUNT, ENTITY_SIZE
        entity_raw = r.read_gb(ENTITY_BUFFER_ADDR, ENTITY_COUNT * ENTITY_SIZE)
        entities   = parse_entities(entity_raw) if entity_raw else []

        # Player is slot 0 — pull coords for info tab display
        player_ent = next((e for e in entities if e["slot"] == 0), None)
        px = player_ent["xpos"] if player_ent else 0
        py = player_ent["ypos"] if player_ent else 0
        coord_16bit = profile.get("coord_16bit", False)
        map_px = px // 16 if coord_16bit else px
        map_py = py // 16 if coord_16bit else py

        if map_bytes:
            self._collision_view.update_map(map_bytes, profile, entities)
        else:
            self._collision_view.set_no_data("Could not read map data")

        # ── Hex viewer ────────────────────────────────────────────────────────
        hex_addr = self._hex_view.get_selected_region_addr()
        hex_size = self._hex_view.get_selected_region_size()
        hex_data = r.read_gb(hex_addr, hex_size)
        if hex_data:
            self._hex_view.update_data(hex_data, hex_addr)
        else:
            self._hex_view.set_no_data()

        # ── OAM / sprites ─────────────────────────────────────────────────────
        oam = r.read_oam()
        if oam:
            self._sprite_view.update_oam(oam)

        # Show raw coords (pixel if 16-bit, tile if 8-bit) + tile position
        if coord_16bit:
            self._px_var.set(f"{px}px  (tile {map_px})")
            self._py_var.set(f"{py}px  (tile {map_py})")
        else:
            self._px_var.set(str(px))
            self._py_var.set(str(py))
        facing_map = {0: "Down", 4: "Up", 8: "Left", 0x0C: "Right"}
        facing_addr = profile.get("facing")
        facing_raw = r.read_byte(facing_addr) if facing_addr else None
        self._facing_var.set(facing_map.get(facing_raw, f"0x{facing_raw:02X}" if facing_raw is not None else "—"))

        map_id_addr = profile.get("map_id")
        map_id = r.read_byte(map_id_addr) if map_id_addr else None
        self._mapid_var.set(f"0x{map_id:02X}" if map_id is not None else "—")

        hp_addr    = profile.get("hp")
        maxhp_addr = profile.get("max_hp")
        hp    = r.read_word(hp_addr)    if hp_addr    else None
        maxhp = r.read_word(maxhp_addr) if maxhp_addr else None
        self._hp_var.set(str(hp)    if hp    is not None else "—")
        self._maxhp_var.set(str(maxhp) if maxhp is not None else "—")

        money_addr = profile.get("money")
        if money_addr:
            money_data = r.read_gb(money_addr, 3)
            if money_data:
                self._money_var.set(f"₽{int(money_data.hex(), 16):,}")
            else:
                self._money_var.set("—")
        else:
            self._money_var.set("—")

        steps_addr = profile.get("steps")
        steps = r.read_word(steps_addr) if steps_addr else None
        self._steps_var.set(f"{steps:,}" if steps is not None else "—")

        coord_str = f"px({px},{py}) tile({map_px},{map_py})" if coord_16bit else f"tile({px},{py})"
        mode_str = "SIMULATION" if self._sim_mode else "LIVE"
        self._status_bar_var.set(
            f"Player {coord_str}  |  {self._profile['name']}  |  {mode_str}"
        )
        
        # ── Viewport (SCX/SCY) ────────────────────────────────────────────────
        scx_addr = profile.get("scx")
        scy_addr = profile.get("scy")
        if scx_addr and scy_addr:
            scx = r.read_byte(scx_addr) or 0
            scy = r.read_byte(scy_addr) or 0
            self._scx_var.set(str(scx))
            self._scy_var.set(str(scy))
            self._collision_view.update_viewport(scx, scy)
        else:
            self._collision_view.update_viewport(None, None)
        