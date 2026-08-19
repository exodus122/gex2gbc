; Disassembly of "Gex - Enter the Gecko (USA, Europe).gbc"

INCLUDE "constants/hardware.inc"
INCLUDE "constants/constants.asm"
INCLUDE "constants/memory.asm"
INCLUDE "code/macros/macros.asm"

SECTION "bank00", ROM0[$0000]
INCLUDE "code/bank00_home.asm"

SECTION "bank01", ROMX[$4000], BANK[$01]
INCLUDE "code/bank01_menus.asm"

SECTION "bank02", ROMX[$4000], BANK[$02]
INCLUDE "code/bank02_update_entities.asm"

SECTION "bank03", ROMX[$4000], BANK[$03]
INCLUDE "code/bank03_bg_collision.asm"
INCLUDE "code/bank03_entity_collision.asm"
INCLUDE "code/bank03_oam_build.asm"
INCLUDE "code/bank03_particle_sprites.asm"
INCLUDE "code/bank03_hud_tiles.asm"
INCLUDE "code/bank03_vram_write.asm"
INCLUDE "code/bank03_animated_tiles.asm"

SECTION "bank04", ROMX[$4000], BANK[$04]
    INCBIN ".gfx/entity_sprites/image_004_4000.bin"
    INCBIN ".gfx/entity_sprites/image_004_6000.bin"

SECTION "bank05", ROMX[$4000], BANK[$05]
    INCBIN ".gfx/entity_sprites/image_005_4000.bin"
    INCBIN ".gfx/entity_sprites/image_005_6000.bin"

SECTION "bank06", ROMX[$4000], BANK[$06]
    INCBIN ".gfx/entity_sprites/image_006_4000.bin"
    INCBIN ".gfx/entity_sprites/image_006_6000.bin"

SECTION "bank07", ROMX[$4000], BANK[$07]
    INCBIN ".gfx/entity_sprites/image_007_4000.bin"

SECTION "bank08", ROMX[$4000], BANK[$08]
image_title_screen_008_0:
    INCBIN ".gfx/menus/image_title_screen_008_0.bin"
    INCBIN "gfx/menus/palette_ids/image_title_screen_008_0_palette_ids.bin"
image_title_screen_008_1:
    INCBIN ".gfx/menus/image_title_screen_008_1.bin"
    INCBIN "gfx/menus/palette_ids/image_title_screen_008_1_palette_ids.bin"
    INCBIN ".gfx/menus/image_title_options_008_2.bin"
    INCBIN ".gfx/menus/image_gex_008_3.bin"

SECTION "bank09", ROMX[$4000], BANK[$09]
image_009_4000:
    INCBIN ".gfx/secondary_tilesets/image_009_4000.bin"
    INCBIN "gfx/secondary_tilesets/image_009_4000_data.bin"

SECTION "bank0a", ROMX[$4000], BANK[$0a]
INCLUDE "code/bank0A_entity_load.asm"

SECTION "bank0b", ROMX[$4000], BANK[$0b]
INCLUDE "code/bank0B_collectible_load.asm"
INCLUDE "code/bank0B_map_spawns.asm"
INCLUDE "code/bank0B_palettes.asm"

SECTION "bank0c", ROMX[$4000], BANK[$0c]
image_audio_menu_00c_0:
    INCBIN ".gfx/menus/image_audio_menu_00c_0.bin"
    INCBIN "gfx/menus/palette_ids/image_audio_menu_00c_0_palette_ids.bin"
    INCBIN ".gfx/menus/image_audio_options_00c_1.bin"
image_great_job_0c_2:
    INCBIN ".gfx/menus/image_great_job_00c_2.bin"
    INCBIN "gfx/menus/palette_ids/image_great_job_00c_2_palette_ids.bin"

SECTION "bank0d", ROMX[$4000], BANK[$0d]
rezopolis_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_00.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_00_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/animation_data/image_00d_00_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_01.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_01_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_02.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_02_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/animation_data/image_00d_02_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_03.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_03_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_04.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_04_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/animation_data/image_00d_04_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_05.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_05_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_06.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_06_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/animation_data/image_00d_06_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_07.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_07_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_08.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_08_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_09.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_09_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/animation_data/image_00d_09_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/rezopolis/image_00d_10.bin"
    INCBIN "gfx/secondary_tilesets/rezopolis/palette_ids/image_00d_10_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
circuit_central_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_11.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/palette_ids/image_00d_11_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/animation_data/image_00d_11_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_12.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/palette_ids/image_00d_12_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_13.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/palette_ids/image_00d_13_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_14.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/palette_ids/image_00d_14_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/animation_data/image_00d_14_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_15.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/palette_ids/image_00d_15_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_16.bin"
    INCBIN "gfx/secondary_tilesets/circuit_central/palette_ids/image_00d_16_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/circuit_central/image_00d_17.bin"

SECTION "bank0e", ROMX[$4000], BANK[$0e]
toon_tv_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_00.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_00_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_01.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_01_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_02.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_02_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_03.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_03_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_04.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_04_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_05.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_05_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_06.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_06_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_07.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_07_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/toon_tv/image_00e_08.bin"
    INCBIN "gfx/secondary_tilesets/toon_tv/palette_ids/image_00e_08_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
prehistory_channel_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_09.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_09_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_10.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_10_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_11.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_11_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_12.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_12_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_13.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_13_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/animation_data/image_00e_13_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_14.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_14_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_15.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_15_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_16.bin"
    INCBIN "gfx/secondary_tilesets/prehistory_channel/palette_ids/image_00e_16_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
channel_z_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/channel_z/image_00e_17.bin"
    INCBIN "gfx/secondary_tilesets/channel_z/palette_ids/image_00e_17_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
lava_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/prehistory_channel/image_00e_18.bin"

SECTION "bank0f", ROMX[$4000], BANK[$0f]
scream_tv_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_00.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_00_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_01.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_01_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_02.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_02_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_03.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_03_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_04.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_04_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_05.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_05_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_06.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_06_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/animation_data/image_00f_06_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_07.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_07_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_08.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_08_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_09.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_09_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_10.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_10_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/animation_data/image_00f_10_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_11.bin"
    INCBIN "gfx/secondary_tilesets/scream_tv/palette_ids/image_00f_11_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/scream_tv/image_00f_12.bin"

SECTION "bank10", ROMX[$4000], BANK[$10]
kung_fu_theater_secondary_tilesets:
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_00.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_00_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_01.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_01_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_02.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_02_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_03.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_03_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_04.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_04_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_05.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_05_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_06.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_06_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_07.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_07_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_08.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_08_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_09.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_09_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/animation_data/image_010_09_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_10.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_10_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_11.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_11_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/kung_fu_theater/image_010_12.bin"
    INCBIN "gfx/secondary_tilesets/kung_fu_theater/palette_ids/image_010_12_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"

SECTION "bank11", ROMX[$4000], BANK[$11]
    INCBIN ".gfx/entity_sprites/image_011_4000.bin"

SECTION "bank12", ROMX[$4000], BANK[$12]
    INCBIN ".gfx/entity_sprites/image_012_4000.bin"
    INCBIN ".gfx/entity_sprites/image_012_6000.bin"

SECTION "bank13", ROMX[$4000], BANK[$13]
media_dimension_secondary_tilesets:
image_013_00_scream_tv_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_00_scream_tv_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_00_scream_tv_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_01.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_01_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_02.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_02_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_03.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_03_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_04.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_04_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_05.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_05_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_06.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_06_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_07.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_07_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_08.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_08_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_09.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_09_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_10.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_10_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_11.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_11_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_12.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_12_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_13_toon_tv_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_13_toon_tv_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_13_toon_tv_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_14_prehistory_channel_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_14_prehistory_channel_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_14_prehistory_channel_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_15_circuit_central_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_15_circuit_central_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_15_circuit_central_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_16_kung_fu_theater_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_16_kung_fu_theater_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_16_kung_fu_theater_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_17_channel_z_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_17_channel_z_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_17_channel_z_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_18_rezopolis_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_18_rezopolis_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_18_rezopolis_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"
image_013_19_bonus_tv_screen:
    INCBIN ".gfx/secondary_tilesets/media_dimension/image_013_19_bonus_tv_screen.bin"
    INCBIN "gfx/secondary_tilesets/media_dimension/palette_ids/image_013_19_bonus_tv_screen_palette_ids.bin"
    INCBIN "gfx/secondary_tilesets/empty_animation_data.bin"

SECTION "bank14", ROMX[$4000], BANK[$14]
image_014_4000:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4000.bin"
image_014_4100:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4100.bin"
image_014_4200:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4200.bin"
image_014_4300:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4300.bin"
image_014_4400:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4400.bin"
image_014_4500:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4500.bin"
image_014_4600:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4600.bin"
image_014_4700:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4700.bin"
image_014_4800:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4800.bin"
image_014_4900:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4900.bin"
image_014_4a00:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4a00.bin"
image_014_4b00:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4b00.bin"
image_014_4c00:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4c00.bin"
image_014_4d00:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4d00.bin"
image_014_4e00:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4e00.bin"
image_014_4f00:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4f00.bin"
image_014_5000:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5000.bin"
image_014_5100:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5100.bin"
image_014_5200:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5200.bin"
image_014_5300:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5300.bin"

SECTION "bank15", ROMX[$4000], BANK[$15]

SECTION "bank16", ROMX[$4000], BANK[$16]

SECTION "bank17", ROMX[$4000], BANK[$17]

SECTION "bank18", ROMX[$4000], BANK[$18]
    INCBIN ".gfx/entity_sprites/image_018_4000.bin"
    INCBIN ".gfx/entity_sprites/image_018_6000.bin"

SECTION "bank19", ROMX[$4000], BANK[$19]
    INCBIN ".gfx/entity_sprites/image_019_4000.bin"
    INCBIN ".gfx/entity_sprites/image_019_6000.bin"

SECTION "bank1a", ROMX[$4000], BANK[$1a]
    INCBIN ".gfx/entity_sprites/image_01a_4000.bin"
    INCBIN ".gfx/entity_sprites/image_01a_6000.bin"

SECTION "bank1b", ROMX[$4000], BANK[$1b]
    INCBIN ".gfx/entity_sprites/image_01b_4000.bin"
    INCBIN ".gfx/entity_sprites/image_01b_6000.bin"

SECTION "bank1c", ROMX[$4000], BANK[$1c]
    INCBIN ".gfx/entity_sprites/image_01c_4000.bin"
    INCBIN ".gfx/entity_sprites/image_01c_6000.bin"

SECTION "bank1d", ROMX[$4000], BANK[$1d]
image_credits2_01d_0:
    INCBIN ".gfx/menus/image_credits2_01d_0.bin"
    INCBIN "gfx/menus/palette_ids/image_credits2_01d_0_palette_ids.bin"
image_credits3_01d_1:
    INCBIN ".gfx/menus/image_credits3_01d_1.bin"
    INCBIN "gfx/menus/palette_ids/image_credits3_01d_1_palette_ids.bin"

SECTION "bank1e", ROMX[$4000], BANK[$1e]
image_david_01e_0:
    INCBIN ".gfx/menus/image_david_01e_0.bin"
    INCBIN "gfx/menus/palette_ids/image_david_01e_0_palette_ids.bin"
image_credits1_01e_1:
    INCBIN ".gfx/menus/image_credits1_01e_1.bin"
    INCBIN "gfx/menus/palette_ids/image_credits1_01e_1_palette_ids.bin"

SECTION "bank1f", ROMX[$4000], BANK[$1f]
image_crave_01f_0:
    INCBIN ".gfx/menus/image_crave_01f_0.bin"
    INCBIN "gfx/menus/palette_ids/image_crave_01f_0_palette_ids.bin"
image_splash_01f_1:
    INCBIN ".gfx/menus/image_splash_01f_1.bin"
    INCBIN "gfx/menus/palette_ids/image_splash_01f_1_palette_ids.bin"

SECTION "bank20", ROMX[$4000], BANK[$20]

INCLUDE "code/audio/bank21_audio1.asm"
INCLUDE "code/audio/bank22_audio2.asm"
INCLUDE "code/audio/bank23_audio3.asm"
INCLUDE "code/audio/bank24_audio4.asm"

SECTION "bank25", ROMX[$4000], BANK[$25]
blockmap_circuit_central3:
    INCBIN "data/maps/circuit_central/blockmap_circuit_central3.bin"

SECTION "bank26", ROMX[$4000], BANK[$26]
tileset_channel_z:
    INCBIN ".gfx/tilesets/tileset_channel_z.bin"

SECTION "bank27", ROMX[$4000], BANK[$27]
blockset_collision_channel_z:
    INCBIN "data/maps/channel_z/blockset_collision_channel_z.bin"

SECTION "bank28", ROMX[$4000], BANK[$28]
blockmap_channel_z:
    INCBIN "data/maps/channel_z/blockmap_channel_z.bin"

SECTION "bank29", ROMX[$4000], BANK[$29]
blockmap_rezopolis:
    INCBIN "data/maps/rezopolis/blockmap_rezopolis.bin"

SECTION "bank2a", ROMX[$4000], BANK[$2a]
blockmap_circuit_central1:
    INCBIN "data/maps/circuit_central/blockmap_circuit_central1.bin"

SECTION "bank2b", ROMX[$4000], BANK[$2b]
blockmap_circuit_central2:
    INCBIN "data/maps/circuit_central/blockmap_circuit_central2.bin"

SECTION "bank2c", ROMX[$4000], BANK[$2c]
blockmap_kung_fu_theater1:
    INCBIN "data/maps/kung_fu_theater/blockmap_kung_fu_theater1.bin"

SECTION "bank2d", ROMX[$4000], BANK[$2d]
blockmap_kung_fu_theater2:
    INCBIN "data/maps/kung_fu_theater/blockmap_kung_fu_theater2.bin"

SECTION "bank2e", ROMX[$4000], BANK[$2e]
blockmap_prehistory_channel1:
    INCBIN "data/maps/prehistory_channel/blockmap_prehistory_channel1.bin"

SECTION "bank2f", ROMX[$4000], BANK[$2f]
blockmap_prehistory_channel2:
    INCBIN "data/maps/prehistory_channel/blockmap_prehistory_channel2.bin"

SECTION "bank30", ROMX[$4000], BANK[$30]
blockmap_media_dimension:
    INCBIN "data/maps/media_dimension/blockmap_media_dimension.bin"

SECTION "bank31", ROMX[$4000], BANK[$31]
blockmap_toon_tv:
    INCBIN "data/maps/toon_tv/blockmap_toon_tv.bin"

SECTION "bank32", ROMX[$4000], BANK[$32]
blockmap_scream_tv1:
    INCBIN "data/maps/scream_tv/blockmap_scream_tv1.bin"

SECTION "bank33", ROMX[$4000], BANK[$33]
blockmap_scream_tv2:
    INCBIN "data/maps/scream_tv/blockmap_scream_tv2.bin"

; Alt-blockset flag planes. One byte per metatile, laid out like the tilemaps in
; banks $28-$33 and read alongside them; each bit belongs to a different map, picked
; out by that map's MAPDATA_ALT_BLOCKSET_MASK. Bank $34 covers the maps in banks
; $2C-$33, bank $35 the maps in $28-$2B.
SECTION "bank34", ROMX[$4000], BANK[$34]
alt_blockset_flags1:
    INCBIN "data/maps/alt_blockset_flags1.bin"

SECTION "bank35", ROMX[$4000], BANK[$35]
alt_blockset_flags2:
    INCBIN "data/maps/alt_blockset_flags2.bin"

SECTION "bank36", ROMX[$4000], BANK[$36]
tileset_media_dimension:
    INCBIN ".gfx/tilesets/tileset_media_dimension.bin"
tileset_toon_tv:
    INCBIN ".gfx/tilesets/tileset_toon_tv.bin"
tileset_scream_tv:
    INCBIN ".gfx/tilesets/tileset_scream_tv.bin"
tileset_circuit_central:
    INCBIN ".gfx/tilesets/tileset_circuit_central.bin"

SECTION "bank37", ROMX[$4000], BANK[$37]
tileset_kung_fu_theater:
    INCBIN ".gfx/tilesets/tileset_kung_fu_theater.bin"
tileset_prehistory_channel:
    INCBIN ".gfx/tilesets/tileset_prehistory_channel.bin"
tileset_rezopolis:
    INCBIN ".gfx/tilesets/tileset_rezopolis.bin"

SECTION "bank38", ROMX[$4000], BANK[$38]
blockset_collision_media_dimension:
    INCBIN "data/maps/media_dimension/blockset_collision_media_dimension.bin"

SECTION "bank39", ROMX[$4000], BANK[$39]
blockset_collision_toon_tv:
    INCBIN "data/maps/toon_tv/blockset_collision_toon_tv.bin"

SECTION "bank3A", ROMX[$4000], BANK[$3a]
blockset_collision_scream_tv:
    INCBIN "data/maps/scream_tv/blockset_collision_scream_tv.bin"

SECTION "bank3B", ROMX[$4000], BANK[$3b]
blockset_collision_circuit_central:
    INCBIN "data/maps/circuit_central/blockset_collision_circuit_central.bin"

SECTION "bank3C", ROMX[$4000], BANK[$3c]
blockset_collision_kung_fu_theater:
    INCBIN "data/maps/kung_fu_theater/blockset_collision_kung_fu_theater.bin"

SECTION "bank3d", ROMX[$4000], BANK[$3d]
image_credits4_03d_0:
    INCBIN ".gfx/menus/image_credits4_03d_0.bin"
    INCBIN "gfx/menus/palette_ids/image_credits4_03d_0_palette_ids.bin"

SECTION "bank3E", ROMX[$4000], BANK[$3e]
blockset_collision_prehistory_channel:
    INCBIN "data/maps/prehistory_channel/blockset_collision_prehistory_channel.bin"

SECTION "bank3F", ROMX[$4000], BANK[$3f]
blockset_collision_rezopolis:
    INCBIN "data/maps/rezopolis/blockset_collision_rezopolis.bin"
