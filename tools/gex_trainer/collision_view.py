"""
collision_view.py - Renders the GB collision map using a tile image.

Tileset: collision_tileset.png (same folder as this script)
  256 tiles, 16 per row, each 8×8 px. Displayed at 16×16 (2× scale).
Map data: C800–CC00 (0x400 bytes = 32×32 tiles).
"""

import tkinter as tk
import os, struct

SRC_TILE   = 8
DST_TILE   = 16
TILES_WIDE = 16
SCALE      = DST_TILE // SRC_TILE   # 2 — GB pixels → canvas pixels
VP_W, VP_H = 160, 144               # GB viewport size in pixels
SCREEN_CENTER_X = 0x58              # screen_x value when player is centred
SCREEN_CENTER_Y = 0x58

C_BG       = "#0D1117"
C_PLAYER   = "#FFE64D"
C_PLAYER_B = "#CC9900"
C_NPC      = "#E0E0E0"
C_ENTITY   = "#44AAFF"
C_ENTITY_B = "#2266AA"
C_ENTITY_SEL = "#FF8800"

# Fallback colours (used when PNG missing)
_FALLBACK = {
    0x02: "black", 0x08: "black", 0x09: "black",
    0x00: "blue",  0x01: "blue",  0x04: "blue",  0x06: "blue", 0x0A: "blue", 0x0B: "blue",
    0x03: "orange",0x07: "orange",
    0x05: "red",   0x22: "brown", 0x23: "pink",  0x24: "#FF5C00",
    0x25: "cyan",  0x26: "lime",
}
def _fallback_color(t):
    if 0x0C <= t <= 0x0F: return "red"
    if 0x2C <= t <= 0x2E: return "green"
    if t >= 0x2F:         return "white"
    return _FALLBACK.get(t, "purple")


# ── Entity struct offsets ────────────────────────────────────────────────────

ENTITY_SIZE         = 0x20
ENTITY_BUFFER_ADDR  = 0xD200
ENTITY_COUNT        = 8

E_ENTITY_ID         = 0x00
E_ACTION_ID         = 0x01
E_ACTION_FUNC       = 0x02   # 2 bytes
E_SPRITE_ID         = 0x08
E_ACTION_STATE      = 0x09
E_UNK_0A            = 0x0A
E_FACING            = 0x0D
E_XPOS              = 0x0E   # 2 bytes, world pixel X
E_YPOS              = 0x10   # 2 bytes, world pixel Y
E_XPOS_ON_SCREEN    = 0x12   # 1 byte
E_YPOS_ON_SCREEN    = 0x13   # 1 byte
E_WIDTH             = 0x14   # 1 byte
E_HEIGHT            = 0x15   # 1 byte
E_COLLISION_TYPE    = 0x16
E_MISC_FLAGS        = 0x17
E_MISC_TIMER        = 0x18
E_TIMER_2           = 0x19
E_OTHER_FLAGS       = 0x1A
E_XVEL              = 0x1C   # 1 byte
E_XVEL_RELATED      = 0x1D
E_YVEL              = 0x1E   # 1 byte

ENTITY_ID_EMPTY     = 0xFF


def parse_entities(raw):
    """Parse 0x100 bytes of entity buffer → list of dicts (skips empty slots)."""
    entities = []
    for i in range(ENTITY_COUNT):
        off = i * ENTITY_SIZE
        if off + ENTITY_SIZE > len(raw):
            break
        e = raw[off:off + ENTITY_SIZE]
        if e[E_ENTITY_ID] == ENTITY_ID_EMPTY or (e[E_ENTITY_ID] != 0 and e[E_UNK_0A] & 0x20 == 0):
            continue
        entities.append({
            "slot":         i,
            "entity_id":    e[E_ENTITY_ID],
            "action_id":    e[E_ACTION_ID],
            "action_func":  struct.unpack_from("<H", e, E_ACTION_FUNC)[0],
            "sprite_id":    e[E_SPRITE_ID],
            "action_state": e[E_ACTION_STATE],
            "facing":       e[E_FACING],
            "unk0a":        e[E_UNK_0A],
            "xpos":         struct.unpack_from("<H", e, E_XPOS)[0],
            "ypos":         struct.unpack_from("<H", e, E_YPOS)[0],
            "screen_x":     e[E_XPOS_ON_SCREEN],
            "screen_y":     e[E_YPOS_ON_SCREEN],
            "width":        e[E_WIDTH],
            "height":       e[E_HEIGHT],
            "collision":    e[E_COLLISION_TYPE],
            "misc_flags":   e[E_MISC_FLAGS],
            "misc_timer":   e[E_MISC_TIMER],
            "timer_2":      e[E_TIMER_2],
            "other_flags":  e[E_OTHER_FLAGS],
            "xvel":         e[E_XVEL],
            "yvel":         e[E_YVEL],
        })
    return entities


# ── PNG loader ────────────────────────────────────────────────────────────────

def _read_png_pixels(path):
    import zlib
    with open(path, "rb") as f:
        sig = f.read(8)
        if sig != b'\x89PNG\r\n\x1a\n':
            raise ValueError("Not a PNG file")
        idat = b""
        width = height = bit_depth = color_type = 0
        while True:
            length_bytes = f.read(4)
            if len(length_bytes) < 4: break
            length = struct.unpack(">I", length_bytes)[0]
            chunk_type = f.read(4)
            data = f.read(length)
            f.read(4)
            if chunk_type == b"IHDR":
                width, height = struct.unpack(">II", data[:8])
                bit_depth  = data[8]
                color_type = data[9]
            elif chunk_type == b"IDAT":
                idat += data
            elif chunk_type == b"IEND":
                break

    if bit_depth != 8:
        raise ValueError(f"Unsupported bit depth {bit_depth}")
    if color_type not in (2, 6):
        raise ValueError(f"Unsupported color type {color_type}")

    channels = 3 if color_type == 2 else 4
    raw = zlib.decompress(idat)
    pixels = []

    def paeth(a, b, c):
        p = a + b - c
        pa, pb, pc = abs(p-a), abs(p-b), abs(p-c)
        if pa <= pb and pa <= pc: return a
        if pb <= pc:              return b
        return c

    prev_row = bytes(width * channels)
    pos = 0
    for y in range(height):
        filt = raw[pos]; pos += 1
        row_raw = list(raw[pos: pos + width * channels]); pos += width * channels
        if filt == 0:   row = row_raw
        elif filt == 1:
            row = list(row_raw)
            for i in range(channels, len(row)):
                row[i] = (row[i] + row[i - channels]) & 0xFF
        elif filt == 2: row = [(row_raw[i] + prev_row[i]) & 0xFF for i in range(len(row_raw))]
        elif filt == 3:
            row = list(row_raw)
            for i in range(len(row)):
                a = row[i - channels] if i >= channels else 0
                row[i] = (row[i] + (a + prev_row[i]) // 2) & 0xFF
        elif filt == 4:
            row = list(row_raw)
            for i in range(len(row)):
                a = row[i - channels] if i >= channels else 0
                b = prev_row[i]
                c = prev_row[i - channels] if i >= channels else 0
                row[i] = (row[i] + paeth(a, b, c)) & 0xFF
        else: row = row_raw
        for x in range(width):
            base = x * channels
            pixels.append((row[base], row[base+1], row[base+2]))
        prev_row = bytes(row)
    return width, height, pixels


def _load_tileset(path):
    try:
        pw, ph, pixels = _read_png_pixels(path)
    except Exception as e:
        print(f"[collision_view] could not load tileset '{path}': {e}")
        return None
    scale = DST_TILE // SRC_TILE
    tiles = []
    for tile_id in range(256):
        tx0 = (tile_id % TILES_WIDE) * SRC_TILE
        ty0 = (tile_id // TILES_WIDE) * SRC_TILE
        header = f"P6\n{DST_TILE} {DST_TILE}\n255\n".encode()
        body = bytearray()
        for dy in range(DST_TILE):
            sy = ty0 + dy // scale
            for dx in range(DST_TILE):
                sx = tx0 + dx // scale
                r, g, b = pixels[sy * pw + sx]
                body += bytes([r, g, b])
        tiles.append(tk.PhotoImage(data=header + bytes(body)))
    return tiles


# ── Widget ────────────────────────────────────────────────────────────────────

class CollisionMapView(tk.Frame):

    def __init__(self, parent, **kw):
        super().__init__(parent, bg=C_BG, **kw)
        self._profile     = None
        self._map_data    = None
        self._entities    = []       # list of parsed entity dicts
        self._selected_slot = None   # currently selected entity slot index
        self._scx         = None
        self._scy         = None
        self._tiles       = None
        self._map_img     = None
        self._show_entities = tk.BooleanVar(value=True)
        self._build_ui()
        self._load_tiles()

    def _load_tiles(self):
        here = os.path.dirname(os.path.abspath(__file__))
        path = os.path.join(here, "collision_tileset.png")
        self._tiles = _load_tileset(path)
        if self._tiles:
            print(f"[collision_view] tileset loaded ({len(self._tiles)} tiles)")
        else:
            print("[collision_view] using colour-square fallback")

    def _build_ui(self):
        # ── Header row ────────────────────────────────────────────────────────
        header = tk.Frame(self, bg=C_BG)
        header.pack(fill=tk.X, padx=8, pady=(8, 4))
        tk.Label(header, text="COLLISION MAP", font=("Courier New", 11, "bold"),
                 fg="#00FF88", bg=C_BG).pack(side=tk.LEFT)

        tk.Checkbutton(header, text="Entities", variable=self._show_entities,
                       font=("Courier New", 9), fg="#AABBCC", bg=C_BG,
                       selectcolor=C_BG, activebackground=C_BG,
                       command=self._redraw_overlays).pack(side=tk.RIGHT, padx=4)

        self._info_var = tk.StringVar(value="No data")
        tk.Label(header, textvariable=self._info_var, font=("Courier New", 9),
                 fg="#667788", bg=C_BG).pack(side=tk.RIGHT)

        # ── Legend ────────────────────────────────────────────────────────────
        legend = tk.Frame(self, bg=C_BG)
        legend.pack(fill=tk.X, padx=8, pady=(0, 4))
        for color, label in [
            ("black","Floor"),("blue","Wall"),("orange","Ceiling"),("red","Wall+Ceil"),
            ("cyan","Water"),("#FF5C00","Lava"),("pink","Kill"),("lime","Climb"),
            (C_PLAYER,"Player"),(C_ENTITY,"Entity"),
        ]:
            tk.Frame(legend, bg=color, width=12, height=12).pack(side=tk.LEFT, padx=(0,2))
            tk.Label(legend, text=label, font=("Courier New", 8),
                     fg="#99AABB", bg=C_BG).pack(side=tk.LEFT, padx=(0,6))

        # ── Main area: canvas + entity panel ──────────────────────────────────
        main = tk.Frame(self, bg=C_BG)
        main.pack(fill=tk.BOTH, expand=True, padx=8, pady=(0, 8))

        canvas_frame = tk.Frame(main, bg=C_BG)
        canvas_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        self._canvas = tk.Canvas(canvas_frame, bg=C_BG, highlightthickness=0)
        vbar = tk.Scrollbar(canvas_frame, orient=tk.VERTICAL,   command=self._canvas.yview)
        hbar = tk.Scrollbar(canvas_frame, orient=tk.HORIZONTAL, command=self._canvas.xview)
        self._canvas.configure(yscrollcommand=vbar.set, xscrollcommand=hbar.set)
        vbar.pack(side=tk.RIGHT,  fill=tk.Y)
        hbar.pack(side=tk.BOTTOM, fill=tk.X)
        self._canvas.pack(fill=tk.BOTH, expand=True)
        self._canvas.bind("<MouseWheel>", self._on_mousewheel)
        self._canvas.bind("<Button-4>",   self._on_mousewheel)
        self._canvas.bind("<Button-5>",   self._on_mousewheel)
        self._canvas.bind("<Button-1>",   self._on_canvas_click)

        # ── Entity detail panel ───────────────────────────────────────────────
        panel = tk.Frame(main, bg="#0D1117", width=200)
        panel.pack(side=tk.RIGHT, fill=tk.Y, padx=(6, 0))
        panel.pack_propagate(False)

        tk.Label(panel, text="ENTITY", font=("Courier New", 10, "bold"),
                 fg="#00FF88", bg=C_BG).pack(anchor="w", padx=8, pady=(8, 4))

        self._entity_text = tk.Text(panel, font=("Courier New", 8),
                                    bg="#161B22", fg="#C9D1D9",
                                    state=tk.DISABLED, wrap=tk.NONE,
                                    borderwidth=0, highlightthickness=0,
                                    width=24)
        self._entity_text.pack(fill=tk.BOTH, expand=True, padx=4, pady=(0, 8))

    def _on_mousewheel(self, event):
        delta = getattr(event, "delta", 0)
        self._canvas.yview_scroll(-3 if (event.num == 4 or delta > 0) else 3, "units")

    def _on_canvas_click(self, event):
        """Select entity whose hitbox was clicked."""
        if not self._show_entities.get() or not self._entities:
            return
        # Convert canvas coords (accounting for scroll)
        cx = self._canvas.canvasx(event.x)
        cy = self._canvas.canvasy(event.y)

        MAP_PX = self._profile.get("map_width", 32) * DST_TILE if self._profile else 512
        hit = None
        for ent in self._entities:
            x0, y0, x1, y1 = self._entity_canvas_rect(ent, MAP_PX)
            if x0 <= cx <= x1 and y0 <= cy <= y1:
                hit = ent
                break

        if hit:
            self._selected_slot = hit["slot"]
            self._show_entity_detail(hit)
            self._redraw_overlays()

    def _entity_screen_to_canvas(self, screen_x, screen_y, MAP_PX):
        """Convert entity screen coords to canvas coords with wrapping."""
        if self._scx is None or self._scy is None:
            return None, None
        cx = ((self._scx + screen_x - 8) * SCALE) % MAP_PX
        cy = ((self._scy + screen_y - 16) * SCALE) % MAP_PX
        return cx, cy

    def _entity_canvas_rect(self, ent, MAP_PX):
        """Return (x0,y0,x1,y1) canvas rect for an entity's hitbox."""
        cx, cy = self._entity_screen_to_canvas(ent["screen_x"], ent["screen_y"], MAP_PX)
        if cx is None:
            return 0, 0, 0, 0
        w = ent["width"]  * SCALE
        h = ent["height"] * SCALE
        return cx - w, cy, cx + w, cy + h

    def _show_entity_detail(self, ent):
        def signed_byte(byte_val):
            return (byte_val + 128) % 256 - 128
        
        facing_map = {0: "Down", 4: "Up", 8: "Left", 0x0C: "Right"}
        lines = [
            f"Slot:    {ent['slot']}",
            f"ID:      0x{ent['entity_id']:02X}",
            f"Action:  0x{ent['action_id']:02X}",
            f"Func:    0x{ent['action_func']:04X}",
            f"Sprite:  0x{ent['sprite_id']:02X}",
            f"Facing: {facing_map.get(ent['facing'], f'0x{ent['facing']:02X}')}",
            f"",
            f"XPos:    {ent['xpos']} (0x{ent['xpos']:04X})",
            f"YPos:    {ent['ypos']} (0x{ent['ypos']:04X})",
            f"ScrX:    {ent['screen_x']}",
            f"ScrY:    {ent['screen_y']}",
            f"W×H:     {ent['width']}×{ent['height']}",
            f"",
            f"XVel:    {signed_byte(ent['xvel'])}",
            f"YVel:    {signed_byte(ent['yvel'])}",
            f"",
            f"Collis:  0x{ent['collision']:02X}",
            f"MiscFlg: 0b{ent['misc_flags']:08b}",
            f"AState:  0b{ent['action_state']:08b}",
            f"Timer1:  {ent['misc_timer']}",
            f"Timer2:  {ent['timer_2']}",
        ]
        t = self._entity_text
        t.configure(state=tk.NORMAL)
        t.delete("1.0", tk.END)
        t.insert("1.0", "\n".join(lines))
        t.configure(state=tk.DISABLED)

    # ── Public API ────────────────────────────────────────────────────────────

    def update_map(self, map_bytes, profile, entities):
        map_changed = (map_bytes != self._map_data)
        self._map_data  = map_bytes
        self._profile   = profile
        self._entities  = entities

        # Keep selected entity detail up to date
        if self._selected_slot is not None:
            sel = next((e for e in entities if e["slot"] == self._selected_slot), None)
            if sel:
                self._show_entity_detail(sel)

        if map_changed:
            self._redraw()
        else:
            self._redraw_overlays()

    def set_no_data(self, message="Waiting for BGB..."):
        self._canvas.delete("all")
        w = self._canvas.winfo_width()  or 400
        h = self._canvas.winfo_height() or 300
        self._canvas.create_text(w//2, h//2, text=message,
                                  font=("Courier New", 12), fill="#445566")
        self._info_var.set(message)

    # ── Drawing ───────────────────────────────────────────────────────────────

    def _redraw(self):
        if not self._map_data or not self._profile:
            return
        W = self._profile.get("map_width",  32)
        H = self._profile.get("map_height", 32)
        if self._tiles:
            self._redraw_tiled(W, H)
        else:
            self._redraw_fallback(W, H)
        n_ent = len(self._entities)
        self._info_var.set(f"{W}×{H} tiles  |  {n_ent} entities  |  {len(self._map_data)} bytes")

    def _redraw_tiled(self, W, H):
        S     = DST_TILE
        img_w = W * S
        img_h = H * S
        header = f"P6\n{img_w} {img_h}\n255\n".encode()

        if not hasattr(self, "_tile_rows"):
            self._tile_rows = []
            for img in self._tiles:
                rows = []
                for dy in range(S):
                    row = bytearray()
                    for dx in range(S):
                        rgb = img.get(dx, dy)
                        row += bytes(rgb[:3])
                    rows.append(row)
                self._tile_rows.append(rows)

        body = bytearray()
        for ty in range(H):
            tile_row_bufs = [bytearray() for _ in range(S)]
            for tx in range(W):
                idx  = ty * W + tx
                tid  = min(self._map_data[idx] if idx < len(self._map_data) else 0, 255)
                trows = self._tile_rows[tid]
                for dy in range(S):
                    tile_row_bufs[dy] += trows[dy]
            for buf in tile_row_bufs:
                body += buf

        self._map_img = tk.PhotoImage(data=header + bytes(body))
        self._canvas.delete("all")
        self._canvas.create_image(0, 0, image=self._map_img, anchor="nw")
        self._canvas.configure(scrollregion=(0, 0, img_w, img_h))
        self._redraw_overlays()

    def _redraw_fallback(self, W, H):
        S = DST_TILE
        self._canvas.delete("all")
        for ty in range(H):
            for tx in range(W):
                idx  = ty * W + tx
                tile = self._map_data[idx] if idx < len(self._map_data) else 0
                x1, y1 = tx*S, ty*S
                self._canvas.create_rectangle(x1, y1, x1+S, y1+S,
                                               fill=_fallback_color(tile), outline="", width=0)
        self._canvas.configure(scrollregion=(0, 0, W*S, H*S))
        self._redraw_overlays()

    def _redraw_overlays(self):
        self._canvas.delete("overlays")
        self._canvas.delete("viewport")

        if not self._profile:
            return

        W     = self._profile.get("map_width",  32)
        S     = DST_TILE
        MAP_PX = W * S

        # ── Viewport rectangle ────────────────────────────────────────────────
        if self._scx is not None and self._scy is not None:
            self._draw_viewport_rect(self._scx, self._scy, MAP_PX)

        if not self._show_entities.get():
            return

        # ── Entities ──────────────────────────────────────────────────────────
        player_ent = None
        for ent in self._entities:
            is_player  = (ent["slot"] == 0)
            is_selected = (ent["slot"] == self._selected_slot)

            '''if is_player:
                player_ent = ent
                continue   # draw player last (on top)'''

            if self._scx is None:
                continue

            x0, y0, x1, y1 = self._entity_canvas_rect(ent, MAP_PX)
            if is_player:
                y0 = y0 + 8
                y1 = y1 + 8
            color  = C_ENTITY_SEL if is_selected else C_ENTITY
            border = C_ENTITY_SEL if is_selected else C_ENTITY_B
            self._canvas.create_rectangle(
                x0, y0, x1, y1,
                outline=border, fill=color, stipple="gray25",
                width=2, tags="overlays")
            self._canvas.create_text(
                x0 + 2, y0 + 2,
                text=f"{ent['entity_id']:02X}", anchor="nw",
                font=("Courier New", 7), fill="cyan", tags="overlays")

        # ── Player (slot 0) ───────────────────────────────────────────────────
        '''if player_ent and self._scx is not None:
            sx, sy = player_ent["screen_x"], player_ent["screen_y"]
            cx = ((self._scx + sx) * SCALE) % MAP_PX
            cy = ((self._scy + sy) * SCALE) % MAP_PX

            # Diamond at hitbox top-left
            r = S // 2 - 2
            self._canvas.create_polygon(
                cx, cy-r, cx+r, cy, cx, cy+r, cx-r, cy,
                fill=C_PLAYER, outline=C_PLAYER_B, width=2, tags="overlays")'''

    def update_viewport(self, scx, scy):
        self._scx = scx
        self._scy = scy
        self._redraw_overlays()

    def _draw_viewport_rect(self, scx, scy, MAP_PX):
        x0, y0 = scx * SCALE, scy * SCALE
        x1, y1 = x0 + VP_W * SCALE, y0 + VP_H * SCALE

        C_VP  = "#FF00FF"
        C_VP2 = "#FF88FF"

        def seg(ax0, ay0, ax1, ay1, color):
            rx0 = max(0, ax0); ry0 = max(0, ay0)
            rx1 = min(MAP_PX, ax1); ry1 = min(MAP_PX, ay1)
            if rx0 < rx1 and ry0 < ry1:
                self._canvas.create_rectangle(rx0, ry0, rx1, ry1,
                    outline=color, width=3, fill="", tags="viewport")

        wrap_x = x1 > MAP_PX
        wrap_y = y1 > MAP_PX
        seg(x0, y0, x1, y1, C_VP)
        if wrap_x: seg(0, y0, x1 - MAP_PX, y1, C_VP2)
        if wrap_y: seg(x0, 0, x1, y1 - MAP_PX, C_VP2)
        if wrap_x and wrap_y: seg(0, 0, x1 - MAP_PX, y1 - MAP_PX, C_VP2)
