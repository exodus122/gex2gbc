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

SECTION "bank09", ROMX[$4000], BANK[$09]
image_009_4000.bin:
    INCBIN ".gfx/tilesets/image_009_4000.bin"

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
    INCBIN ".gfx/spritesheets/image_014_4000.bin"
image_014_5000.bin:
    INCBIN ".gfx/spritesheets/image_014_5000.bin"

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

SECTION "bank1d", ROMX[$4000], BANK[$1d]
image_01d_4000.bin:
    INCBIN ".gfx/credits/image_01d_4000.bin"
image_01d_5600.bin:
    INCBIN ".gfx/credits/image_01d_5600.bin"

SECTION "bank1e", ROMX[$4000], BANK[$1e]
image_01e_4000.bin:
    INCBIN ".gfx/splash/image_01e_4000.bin"
image_01e_5600.bin:
    INCBIN ".gfx/credits/image_01e_5600.bin"

SECTION "bank1f", ROMX[$4000], BANK[$1f]
image_01f_4000.bin:
    INCBIN ".gfx/splash/image_01f_4000.bin"
image_01f_5900.bin:
    INCBIN ".gfx/splash/image_01f_5900.bin"

SECTION "bank20", ROMX[$4000], BANK[$20]

INCLUDE "bank21.asm"
INCLUDE "bank22.asm"
INCLUDE "bank23.asm"
INCLUDE "bank24.asm"

SECTION "bank25", ROMX[$4000], BANK[$25]
map_circuit_central3.bin:
    INCBIN "maps/circuit_central/map_circuit_central3.bin"

SECTION "bank26", ROMX[$4000], BANK[$26]
image_026_4000.bin:
    INCBIN ".gfx/tilesets/image_026_4000.bin"

SECTION "bank27", ROMX[$4000], BANK[$27]
blockset_data_channel_z.bin:
    INCBIN "maps/channel_z/blockset_data_channel_z.bin"

SECTION "bank28", ROMX[$4000], BANK[$28]
map_channel_z.bin:
    INCBIN "maps/channel_z/map_channel_z.bin"

SECTION "bank29", ROMX[$4000], BANK[$29]
map_rezopolis1.bin:
    INCBIN "maps/rezopolis/map_rezopolis1.bin"

SECTION "bank2a", ROMX[$4000], BANK[$2a]
map_circuit_central1.bin:
    INCBIN "maps/circuit_central/map_circuit_central1.bin"

SECTION "bank2b", ROMX[$4000], BANK[$2b]
map_circuit_central2.bin:
    INCBIN "maps/circuit_central/map_circuit_central2.bin"

SECTION "bank2c", ROMX[$4000], BANK[$2c]
map_kung_fu_theater1.bin:
    INCBIN "maps/kung_fu_theater/map_kung_fu_theater1.bin"

SECTION "bank2d", ROMX[$4000], BANK[$2d]
map_kung_fu_theater2.bin:
    INCBIN "maps/kung_fu_theater/map_kung_fu_theater2.bin"

SECTION "bank2e", ROMX[$4000], BANK[$2e]
map_prehistory_channel1.bin:
    INCBIN "maps/prehistory_channel/map_prehistory_channel1.bin"

SECTION "bank2f", ROMX[$4000], BANK[$2f]
map_prehistory_channel2.bin:
    INCBIN "maps/prehistory_channel/map_prehistory_channel2.bin"

SECTION "bank30", ROMX[$4000], BANK[$30]
map_media_dimension.bin:
    INCBIN "maps/media_dimension/map_media_dimension.bin"

SECTION "bank31", ROMX[$4000], BANK[$31]
map_toon_tv.bin:
    INCBIN "maps/toon_tv/map_toon_tv.bin"

SECTION "bank32", ROMX[$4000], BANK[$32]
map_scream_tv1.bin:
    INCBIN "maps/scream_tv/map_scream_tv1.bin"

SECTION "bank33", ROMX[$4000], BANK[$33]
map_scream_tv2.bin:
    INCBIN "maps/scream_tv/map_scream_tv2.bin"

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
blockset_data_media_dimension.bin:
    INCBIN "maps/media_dimension/blockset_data_media_dimension.bin"

SECTION "bank39", ROMX[$4000], BANK[$39]
blockset_data_toon_tv.bin:
    INCBIN "maps/toon_tv/blockset_data_toon_tv.bin"

SECTION "bank3A", ROMX[$4000], BANK[$3a]
blockset_data_scream_tv.bin:
    INCBIN "maps/scream_tv/blockset_data_scream_tv.bin"

SECTION "bank3B", ROMX[$4000], BANK[$3b]
blockset_data_circuit_central.bin:
    INCBIN "maps/circuit_central/blockset_data_circuit_central.bin"

SECTION "bank3C", ROMX[$4000], BANK[$3c]
blockset_data_kung_fu_theater.bin:
    INCBIN "maps/kung_fu_theater/blockset_data_kung_fu_theater.bin"

SECTION "bank3d", ROMX[$4000], BANK[$3d]
image_03d_4000.bin:
    INCBIN ".gfx/credits/image_03d_4000.bin"

SECTION "bank3E", ROMX[$4000], BANK[$3e]
blockset_data_prehistory_channel.bin:
    INCBIN "maps/prehistory_channel/blockset_data_prehistory_channel.bin"

SECTION "bank3F", ROMX[$4000], BANK[$3f]
blockset_data_rezopolis.bin:
    INCBIN "maps/rezopolis/blockset_data_rezopolis.bin"
