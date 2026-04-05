"""
sprite_view.py - OAM / sprite list viewer.
Shows all 40 GB OAM entries with their Y, X, tile, and flags bytes.
Highlights sprites that are on-screen (Y between 16-160, X between 8-168).
"""

import tkinter as tk
from tkinter import ttk

C_BG      = "#0D1117"
C_HEADER  = "#00FF88"
C_ON      = "#7EE787"   # on-screen sprite
C_OFF     = "#30363D"   # off-screen / hidden
C_SEL     = "#1F6FEB"
C_TEXT    = "#C9D1D9"
FONT      = ("Courier New", 9)

OAM_ENTRY_SIZE = 4   # bytes: Y, X, tile, flags


class SpriteView(tk.Frame):
    """Table listing all 40 OAM sprite entries from GB memory."""

    def __init__(self, parent, **kw):
        super().__init__(parent, bg=C_BG, **kw)
        self._oam_data = None
        self._build_ui()

    def _build_ui(self):
        header = tk.Frame(self, bg=C_BG)
        header.pack(fill=tk.X, padx=8, pady=(8, 4))

        tk.Label(header, text="SPRITE TABLE  (OAM 0xFE00–0xFE9F)",
                 font=("Courier New", 11, "bold"),
                 fg=C_HEADER, bg=C_BG).pack(side=tk.LEFT)

        self._count_var = tk.StringVar(value="0 visible")
        tk.Label(header, textvariable=self._count_var, font=FONT,
                 fg="#667788", bg=C_BG).pack(side=tk.RIGHT)

        # Treeview
        cols = ("#", "Y", "X", "Tile", "Flags", "Visible", "Flip")
        self._tree = ttk.Treeview(self, columns=cols, show="headings",
                                  height=20, selectmode="browse")

        col_widths = [30, 50, 50, 50, 60, 65, 80]
        for col, w in zip(cols, col_widths):
            self._tree.heading(col, text=col)
            self._tree.column(col, width=w, anchor="center", stretch=False)

        vsb = ttk.Scrollbar(self, orient=tk.VERTICAL,
                            command=self._tree.yview)
        self._tree.configure(yscrollcommand=vsb.set)

        vsb.pack(side=tk.RIGHT, fill=tk.Y, padx=(0, 8), pady=(0, 8))
        self._tree.pack(fill=tk.BOTH, expand=True, padx=(8, 0), pady=(0, 8))

        # Styles
        style = ttk.Style()
        style.theme_use("clam")
        style.configure("Treeview",
                        background=C_BG, foreground=C_TEXT,
                        fieldbackground=C_BG, font=FONT, rowheight=18)
        style.configure("Treeview.Heading",
                        background="#161B22", foreground=C_HEADER,
                        font=("Courier New", 9, "bold"))
        self._tree.tag_configure("on",  foreground=C_ON)
        self._tree.tag_configure("off", foreground=C_OFF)

    # ── Public API ────────────────────────────────────────────────────────────

    def update_oam(self, oam_bytes):
        """
        oam_bytes: 160 bytes (40 sprites × 4 bytes each)
        """
        if not oam_bytes or len(oam_bytes) < 160:
            return

        self._tree.delete(*self._tree.get_children())
        visible = 0

        for i in range(40):
            offset = i * OAM_ENTRY_SIZE
            sy, sx, tile, flags = oam_bytes[offset:offset + 4]

            # A sprite is visible if Y is 16–159 (accounts for 8px off-screen border)
            on_screen = 16 <= sy <= 159 and 8 <= sx <= 167
            if on_screen:
                visible += 1

            flip_h = "H" if flags & 0x20 else ""
            flip_v = "V" if flags & 0x40 else ""
            flip = flip_h + flip_v or "-"

            tag = "on" if on_screen else "off"
            self._tree.insert("", tk.END, tags=(tag,), values=(
                i,
                sy - 16 if on_screen else f"{sy} (off)",
                sx - 8  if on_screen else f"{sx} (off)",
                f"${tile:02X}",
                f"${flags:02X}",
                "✓" if on_screen else "✗",
                flip,
            ))

        self._count_var.set(f"{visible}/40 visible")

    def set_no_data(self, msg="Waiting for data..."):
        self._tree.delete(*self._tree.get_children())
        self._count_var.set(msg)
