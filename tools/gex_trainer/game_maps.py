"""
game_maps.py - Memory map definitions for known Game Boy games.

Each profile key corresponds to the ROM title string (bytes 0x0134-0x0143).

Standard keys:
  name          str    Display name
  color         str    Hex colour for UI accents
  player_x      int    GB address of player X coordinate
  player_y      int    GB address of player Y coordinate
  coord_16bit   bool   True = read_word (16-bit LE), False = read_byte
  map_data      int    GB address of collision/tile map
  map_width     int    Map width in tiles
  map_height    int    Map height in tiles

Player-info tab keys (all GB addresses, read via read_byte/read_word/read_gb):
  facing        int    GB address of facing direction byte
                       Expected values: {0:"Down", 4:"Up", 8:"Left", 0x0C:"Right"}
  map_id        int    GB address of current map/room ID byte
  hp            int    GB address of current HP (16-bit word)
  max_hp        int    GB address of max HP (16-bit word)
  money         int    GB address of money (3 bytes BCD)
  steps         int    GB address of step counter (16-bit word)

NPC/sprite keys:
  sprites_addr  int    GB address of NPC struct array
  sprite_count  int    Number of NPC entries
  sprite_stride int    Bytes per NPC entry
  sprite_x_off  int    Byte offset of X within each entry
  sprite_y_off  int    Byte offset of Y within each entry
"""

GAME_PROFILES = {

    # ── Gex: Enter the Gecko (GBC) ───────────────────────────────────────────
    "GEX GECKO": {
        "name":         "Gex: Enter the Gecko",
        "color":        "#44AA44",

        # Player position is read from entity slot 0 (D200-D21F)

        # Collision/tile map
        "map_data":     0xC800,
        "map_width":    32,
        "map_height":   32,

        # Player info tab
        "facing":       0xC109,       # 0=Down 4=Up 8=Left 0x0C=Right
        "map_id":       0xD35E,
        "hp":           0xD16C,
        "max_hp":       0xD18D,
        "money":        0xD347,       # 3-byte BCD
        "steps":        0xD35A,

        # Scroll registers — GB addresses in WRAM
        "scx":          0xD5A1,
        "scy":          0xD5A2,
    },

    # ── Generic / Unknown ─────────────────────────────────────────────────────
    "__default__": {
        "name":         "Unknown ROM",
        "color":        "#888888",
        "coord_16bit":  False,
        "map_data":     0xC800,
        "map_width":    32,
        "map_height":   32,
        "facing":       None,
        "map_id":       None,
        "hp":           None,
        "max_hp":       None,
        "money":        None,
        "steps":        None,
        "scx":          None,
        "scy":          None,
    },
}


def detect_game(rom_header_bytes):
    """
    Given 0x50 bytes starting at 0x0100, extract the ROM title and
    return the matching game profile (or __default__).
    """
    if not rom_header_bytes or len(rom_header_bytes) < 0x44:
        return GAME_PROFILES["__default__"], "Unknown"

    title_bytes = rom_header_bytes[0x34:0x44]
    title = title_bytes.decode("ascii", errors="replace").rstrip("\x00").strip()

    for key, profile in GAME_PROFILES.items():
        if key == "__default__":
            continue
        if title.startswith(key) or key in title:
            return profile, title

    return GAME_PROFILES["__default__"], title
