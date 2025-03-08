; Disassembly of "Gex - Enter the Gecko (USA, Europe).gbc"

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"
INCLUDE "memory.asm"

INCLUDE "bank00.asm"
INCLUDE "bank01.asm"
INCLUDE "bank02.asm"
INCLUDE "bank03.asm"

SECTION "bank04", ROMX[$4000], BANK[$04]
image_004_4000.bin:
    INCBIN ".gfx/spritesheets/image_004_4000.bin"
image_004_6000.bin:
    INCBIN ".gfx/spritesheets/image_004_6000.bin"

SECTION "bank05", ROMX[$4000], BANK[$05]
image_005_4000.bin:
    INCBIN ".gfx/spritesheets/image_005_4000.bin"
image_005_6000.bin:
    INCBIN ".gfx/spritesheets/image_005_6000.bin"

SECTION "bank06", ROMX[$4000], BANK[$06]
image_006_4000.bin:
    INCBIN ".gfx/spritesheets/image_006_4000.bin"
image_006_6000.bin:
    INCBIN ".gfx/spritesheets/image_006_6000.bin"

SECTION "bank07", ROMX[$4000], BANK[$07]
image_007_4000.bin:
    INCBIN ".gfx/spritesheets/image_007_4000.bin"

INCLUDE "bank08.asm"
INCLUDE "bank09.asm"
INCLUDE "bank0A.asm"
INCLUDE "bank0B.asm"
INCLUDE "bank0C.asm"
INCLUDE "bank0D.asm"
INCLUDE "bank0E.asm"
INCLUDE "bank0F.asm"
INCLUDE "bank10.asm"

SECTION "bank11", ROMX[$4000], BANK[$11]
image_011_4000.bin:
    INCBIN ".gfx/spritesheets/image_011_4000.bin"

SECTION "bank12", ROMX[$4000], BANK[$12]
image_012_4000.bin:
    INCBIN ".gfx/spritesheets/image_012_4000.bin"
image_012_6000.bin:
    INCBIN ".gfx/spritesheets/image_012_6000.bin"

INCLUDE "bank13.asm"

SECTION "bank14", ROMX[$4000], BANK[$14]
image_014_4000.bin:
    INCBIN ".gfx/tilesets/image_014_4000.bin"

SECTION "bank15", ROMX[$4000], BANK[$15]
SECTION "bank16", ROMX[$4000], BANK[$16]
SECTION "bank17", ROMX[$4000], BANK[$17]

SECTION "bank18", ROMX[$4000], BANK[$18]
image_018_4000.bin:
    INCBIN ".gfx/spritesheets/image_018_4000.bin"
image_018_6000.bin:
    INCBIN ".gfx/spritesheets/image_018_6000.bin"

SECTION "bank19", ROMX[$4000], BANK[$19]
image_019_4000.bin:
    INCBIN ".gfx/spritesheets/image_019_4000.bin"
image_019_6000.bin:
    INCBIN ".gfx/spritesheets/image_019_6000.bin"

SECTION "bank1a", ROMX[$4000], BANK[$1a]
image_01a_4000.bin:
    INCBIN ".gfx/spritesheets/image_01a_4000.bin"
image_01a_6000.bin:
    INCBIN ".gfx/spritesheets/image_01a_6000.bin"

SECTION "bank1b", ROMX[$4000], BANK[$1b]
image_01b_4000.bin:
    INCBIN ".gfx/spritesheets/image_01b_4000.bin"
image_01b_6000.bin:
    INCBIN ".gfx/spritesheets/image_01b_6000.bin"

SECTION "bank1c", ROMX[$4000], BANK[$1c]
image_01c_4000.bin:
    INCBIN ".gfx/spritesheets/image_01c_4000.bin"
image_01c_6000.bin:
    INCBIN ".gfx/spritesheets/image_01c_6000.bin"

INCLUDE "bank1D.asm"
INCLUDE "bank1E.asm"
INCLUDE "bank1F.asm"
SECTION "bank20", ROMX[$4000], BANK[$20]
INCLUDE "bank21.asm"
INCLUDE "bank22.asm"
INCLUDE "bank23.asm"
INCLUDE "bank24.asm"

SECTION "bank25", ROMX[$4000], BANK[$25]
map_circuit_central_bank25.bin:
    INCBIN "maps/map_circuit_central_bank25.bin"

SECTION "bank26", ROMX[$4000], BANK[$26]
image_026_4000.bin:
    INCBIN ".gfx/tilesets/image_026_4000.bin"

SECTION "bank27", ROMX[$4000], BANK[$27]
channel_map_data_unknown_bank27.bin:
    INCBIN "maps/channel_map_data_unknown_bank27.bin"

SECTION "bank28", ROMX[$4000], BANK[$28]
map_unknown_bank28.bin:
    INCBIN "maps/map_unknown_bank28.bin"

SECTION "bank29", ROMX[$4000], BANK[$29]
map_unknown_bank29.bin:
    INCBIN "maps/map_unknown_bank29.bin"

SECTION "bank2a", ROMX[$4000], BANK[$2a]
map_unknown_bank2a.bin:
    INCBIN "maps/map_unknown_bank2a.bin"

SECTION "bank2b", ROMX[$4000], BANK[$2b]
map_circuit_central_bank2b.bin:
    INCBIN "maps/map_circuit_central_bank2b.bin"

SECTION "bank2c", ROMX[$4000], BANK[$2c]
map_kung_fu_tv_bank2c.bin:
    INCBIN "maps/map_kung_fu_tv_bank2c.bin"

SECTION "bank2d", ROMX[$4000], BANK[$2d]
map_kung_fu_tv_bank2d.bin:
    INCBIN "maps/map_kung_fu_tv_bank2d.bin"

SECTION "bank2e", ROMX[$4000], BANK[$2e]
map_pre_history_channel_bank2e.bin:
    INCBIN "maps/map_pre_history_channel_bank2e.bin"

SECTION "bank2f", ROMX[$4000], BANK[$2f]
map_pre_history_channel_bank2f.bin:
    INCBIN "maps/map_pre_history_channel_bank2f.bin"

SECTION "bank30", ROMX[$4000], BANK[$30]
map_media_dimension_bank30.bin:
    INCBIN "maps/map_media_dimension_bank30.bin"

SECTION "bank31", ROMX[$4000], BANK[$31]
map_toon_tv_bank31.bin:
    INCBIN "maps/map_toon_tv_bank31.bin"

SECTION "bank32", ROMX[$4000], BANK[$32]
map_scream_tv_bank32.bin:
    INCBIN "maps/map_scream_tv_bank32.bin"

SECTION "bank33", ROMX[$4000], BANK[$33]
map_scream_tv_bank33.bin:
    INCBIN "maps/map_scream_tv_bank33.bin"

SECTION "bank34", ROMX[$4000], BANK[$34]
object_map_data_bank34.bin:
    INCBIN "maps/object_map_data_bank34.bin"

SECTION "bank35", ROMX[$4000], BANK[$35]
object_map_data_bank35.bin:
    INCBIN "maps/object_map_data_bank35.bin"

SECTION "bank36", ROMX[$4000], BANK[$36]
image_036_4000.bin:
    INCBIN ".gfx/tilesets/image_036_4000.bin"
image_036_5000.bin:
    INCBIN ".gfx/tilesets/image_036_5000.bin"
image_036_6000.bin:
    INCBIN ".gfx/tilesets/image_036_6000.bin"
image_036_7000.bin:
    INCBIN ".gfx/tilesets/image_036_7000.bin"

SECTION "bank37", ROMX[$4000], BANK[$37]
image_037_4000.bin:
    INCBIN ".gfx/tilesets/image_037_4000.bin"
image_037_5000.bin:
    INCBIN ".gfx/tilesets/image_037_5000.bin"
image_037_6000.bin:
    INCBIN ".gfx/tilesets/image_037_6000.bin"

SECTION "bank38", ROMX[$4000], BANK[$38]
channel_map_data_media_dimension_bank38.bin:
    INCBIN "maps/channel_map_data_media_dimension_bank38.bin"

SECTION "bank39", ROMX[$4000], BANK[$39]
channel_map_data_toon_tv_bank39.bin:
    INCBIN "maps/channel_map_data_toon_tv_bank39.bin"

SECTION "bank3A", ROMX[$4000], BANK[$3a]
channel_map_data_scream_tv_bank3a.bin:
    INCBIN "maps/channel_map_data_scream_tv_bank3a.bin"

SECTION "bank3B", ROMX[$4000], BANK[$3b]
channel_map_data_circuit_central_bank3b.bin:
    INCBIN "maps/channel_map_data_circuit_central_bank3b.bin"

SECTION "bank3C", ROMX[$4000], BANK[$3c]
channel_map_data_kung_fu_tv_bank3c.bin:
    INCBIN "maps/channel_map_data_kung_fu_tv_bank3c.bin"

INCLUDE "bank3D.asm"

SECTION "bank3E", ROMX[$4000], BANK[$3e]
channel_map_data_pre_history_channel_bank3e.bin:
    INCBIN "maps/channel_map_data_pre_history_channel_bank3e.bin"

SECTION "bank3F", ROMX[$4000], BANK[$3f]
channel_map_data_unknown_bank3f.bin:
    INCBIN "maps/channel_map_data_unknown_bank3f.bin"
