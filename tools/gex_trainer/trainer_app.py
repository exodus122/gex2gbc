"""
trainer_app.py - Main window and polling loop for the Gex Trainer.
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
from watches_view import WatchesView

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
        self.root.title("Gex Trainer  //  Game Boy Memory Visualizer")
        self.root.configure(bg=C_BG)
        self.root.minsize(900, 600)
        self.root.geometry("1200x750")
        
        # Always use real reader on Windows; simulation only on non-Windows
        self._sim_mode = sys.platform != "win32"
        self._reader = SimulatedBGBMemoryReader() if self._sim_mode else BGBMemoryReader()

        self._profile = None
        self._rom_title = "—"
        self._connected = False
        self._paused = False

        self._build_ui()
        self._try_connect()
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)

    def _on_close(self):
        self._watches_view._save()
        self.root.destroy()

    # ── UI Construction ───────────────────────────────────────────────────────

    def _build_ui(self):
        # ── Title bar ────────────────────────────────────────────────────────
        title_bar = tk.Frame(self.root, bg=C_PANEL, height=42)
        title_bar.pack(fill=tk.X, side=tk.TOP)
        title_bar.pack_propagate(False)

        tk.Label(title_bar, text="◈  Gex TRAINER",
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

        # Tab 4: Watches
        self._watches_view = WatchesView(nb)
        nb.add(self._watches_view, text="  WATCHES  ")

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

        # Player is slot 0 — pull coords for status bar
        player_ent = next((e for e in entities if e["slot"] == 0), None)

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

        # ── Watches ───────────────────────────────────────────────────────────
        self._watches_view.poll(r)

        # ── Status bar ────────────────────────────────────────────────────────
        if player_ent:
            px, py = player_ent["xpos"], player_ent["ypos"]
            coord_str = f"px({px},{py}) tile({px//16},{py//16})"
        else:
            coord_str = "—"
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
            self._collision_view.update_viewport(scx, scy)
        else:
            self._collision_view.update_viewport(None, None)
        
