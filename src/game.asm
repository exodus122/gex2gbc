; Disassembly of "Gex - Enter the Gecko (USA, Europe).gbc"

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"
INCLUDE "memory.asm"

INCLUDE "bank00_home.asm"
INCLUDE "bank01_menus.asm"
INCLUDE "bank02_update_objects.asm"
INCLUDE "bank03_misc.asm"

INCLUDE "bank04_07_gex_sprites.asm"

SECTION "bank08", ROMX[$4000], BANK[$08]
image_title_screen_008_0.bin:
    INCBIN ".gfx/splash/image_title_screen_008_0.bin"
image_008_0_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_title_screen_008_0_palette_ids.bin"
image_title_screen_008_1.bin:
    INCBIN ".gfx/splash/image_title_screen_008_1.bin"
image_008_1_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_title_screen_008_1_palette_ids.bin"
image_title_options_008_2.bin:
    INCBIN ".gfx/splash/image_title_options_008_2.bin"
image_filler_008_3.bin:
    INCBIN ".gfx/splash/image_gex_008_3.bin"

SECTION "bank09", ROMX[$4000], BANK[$09]
image_009_4000.bin:
    INCBIN ".gfx/image_009_4000.bin"

INCLUDE "bank0A_load_objects.asm"
INCLUDE "bank0B_collectibles_spawns_palettes.asm"

SECTION "bank0c", ROMX[$4000], BANK[$0c]
image_audio_menu_00c_0.bin:
    INCBIN ".gfx/splash/image_audio_menu_00c_0.bin"
image_audio_menu_00c_0_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_audio_menu_00c_0_palette_ids.bin"
image_audio_options00c_1.bin:
    INCBIN ".gfx/splash/image_audio_options_00c_1.bin"
image_great_job_0c_2.bin:
    INCBIN ".gfx/splash/image_great_job_00c_2.bin"
image_great_job_00c_2_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_great_job_00c_2_palette_ids.bin"

SECTION "bank0d", ROMX[$4000], BANK[$0d]
image_00d_00.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_00.bin"
image_00d_00_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_00_palette_ids.bin"
image_00d_01.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_01.bin"
image_00d_01_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_01_palette_ids.bin"
image_00d_02.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_02.bin"
image_00d_02_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_02_palette_ids.bin"
image_00d_03.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_03.bin"
image_00d_03_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_03_palette_ids.bin"
image_00d_04.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_04.bin"
image_00d_04_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_04_palette_ids.bin"
image_00d_05.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_05.bin"
image_00d_05_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_05_palette_ids.bin"
image_00d_06.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_06.bin"
image_00d_06_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_06_palette_ids.bin"
image_00d_07.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_07.bin"
image_00d_07_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_07_palette_ids.bin"
image_00d_08.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_08.bin"
image_00d_08_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_08_palette_ids.bin"
image_00d_09.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_09.bin"
image_00d_09_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_09_palette_ids.bin"
image_blank_tv_00d_10.bin:
    INCBIN ".gfx/special_tilesets/rezopolis/image_00d_10.bin"
image_00d_10_palette_ids.bin:
    INCBIN "gfx/special_tilesets/rezopolis/palette_ids/image_00d_10_palette_ids.bin"
image_00d_11.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_11.bin"
image_00d_11_palette_ids.bin:
    INCBIN "gfx/special_tilesets/circuit_central/palette_ids/image_00d_11_palette_ids.bin"
image_00d_12.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_12.bin"
image_00d_12_palette_ids.bin:
    INCBIN "gfx/special_tilesets/circuit_central/palette_ids/image_00d_12_palette_ids.bin"
image_00d_13.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_13.bin"
image_00d_13_palette_ids.bin:
    INCBIN "gfx/special_tilesets/circuit_central/palette_ids/image_00d_13_palette_ids.bin"
image_00d_14.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_14.bin"
image_00d_14_palette_ids.bin:
    INCBIN "gfx/special_tilesets/circuit_central/palette_ids/image_00d_14_palette_ids.bin"
image_00d_15.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_15.bin"
image_00d_15_palette_ids.bin:
    INCBIN "gfx/special_tilesets/circuit_central/palette_ids/image_00d_15_palette_ids.bin"
image_00d_16.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_16.bin"
image_00d_16_palette_ids.bin:
    INCBIN "gfx/special_tilesets/circuit_central/palette_ids/image_00d_16_palette_ids.bin"
image_00d_17.bin:
    INCBIN ".gfx/special_tilesets/circuit_central/image_00d_17.bin"

SECTION "bank0e", ROMX[$4000], BANK[$0e]
image_00e_00.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_00.bin"
image_00e_00_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_00_palette_ids.bin"
image_00e_01.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_01.bin"
image_00e_01_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_01_palette_ids.bin"
image_00e_02.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_02.bin"
image_00e_02_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_02_palette_ids.bin"
image_00e_03.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_03.bin"
image_00e_03_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_03_palette_ids.bin"
image_00e_04.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_04.bin"
image_00e_04_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_04_palette_ids.bin"
image_00e_05.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_05.bin"
image_00e_05_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_05_palette_ids.bin"
image_00e_06.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_06.bin"
image_00e_06_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_06_palette_ids.bin"
image_00e_07.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_07.bin"
image_00e_07_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_07_palette_ids.bin"
image_00e_08.bin:
    INCBIN ".gfx/special_tilesets/toon_tv/image_00e_08.bin"
image_00e_08_palette_ids.bin:
    INCBIN "gfx/special_tilesets/toon_tv/palette_ids/image_00e_08_palette_ids.bin"
image_00e_09.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_09.bin"
image_00e_09_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_09_palette_ids.bin"
image_00e_10.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_10.bin"
image_00e_10_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_10_palette_ids.bin"
image_00e_11.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_11.bin"
image_00e_11_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_11_palette_ids.bin"
image_00e_12.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_12.bin"
image_00e_12_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_12_palette_ids.bin"
image_00e_13.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_13.bin"
image_00e_13_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_13_palette_ids.bin"
image_00e_14.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_14.bin"
image_00e_14_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_14_palette_ids.bin"
image_00e_15.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_15.bin"
image_00e_15_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_15_palette_ids.bin"
image_00e_16.bin:
    INCBIN ".gfx/special_tilesets/prehistory_channel/image_00e_16.bin"
image_00e_16_palette_ids.bin:
    INCBIN "gfx/special_tilesets/prehistory_channel/palette_ids/image_00e_16_palette_ids.bin"
image_00e_17.bin:
    INCBIN ".gfx/special_tilesets/channel_z/image_00e_17.bin"
image_00e_17_palette_ids.bin:
    INCBIN "gfx/special_tilesets/channel_z/palette_ids/image_00e_17_palette_ids.bin"
image_00e_18.bin:
    INCBIN ".gfx/special_tilesets/image_00e_18.bin"

SECTION "bank0f", ROMX[$4000], BANK[$0f]
image_00f_00.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_00.bin"
image_00f_00_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_00_palette_ids.bin"
image_00f_01.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_01.bin"
image_00f_01_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_01_palette_ids.bin"
image_00f_02.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_02.bin"
image_00f_02_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_02_palette_ids.bin"
image_00f_03.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_03.bin"
image_00f_03_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_03_palette_ids.bin"
image_00f_04.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_04.bin"
image_00f_04_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_04_palette_ids.bin"
image_00f_05.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_05.bin"
image_00f_05_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_05_palette_ids.bin"
image_00f_06.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_06.bin"
image_00f_06_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_06_palette_ids.bin"
image_00f_07.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_07.bin"
image_00f_07_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_07_palette_ids.bin"
image_00f_08.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_08.bin"
image_00f_08_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_08_palette_ids.bin"
image_00f_09.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_09.bin"
image_00f_09_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_09_palette_ids.bin"
image_00f_10.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_10.bin"
image_00f_10_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_10_palette_ids.bin"
image_00f_11.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_11.bin"
image_00f_11_palette_ids.bin:
    INCBIN "gfx/special_tilesets/scream_tv/palette_ids/image_00f_11_palette_ids.bin"
image_00f_12.bin:
    INCBIN ".gfx/special_tilesets/scream_tv/image_00f_12.bin"

SECTION "bank10", ROMX[$4000], BANK[$10]
image_010_00.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_00.bin"
image_010_00_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_00_palette_ids.bin"
image_010_01.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_01.bin"
image_010_01_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_01_palette_ids.bin"
image_010_02.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_02.bin"
image_010_02_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_02_palette_ids.bin"
image_010_03.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_03.bin"
image_010_03_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_03_palette_ids.bin"
image_010_04.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_04.bin"
image_010_04_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_04_palette_ids.bin"
image_010_05.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_05.bin"
image_010_05_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_05_palette_ids.bin"
image_010_06.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_06.bin"
image_010_06_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_06_palette_ids.bin"
image_010_07.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_07.bin"
image_010_07_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_07_palette_ids.bin"
image_010_08.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_08.bin"
image_010_08_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_08_palette_ids.bin"
image_010_09.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_09.bin"
image_010_09_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_09_palette_ids.bin"
image_010_10.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_10.bin"
image_010_10_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_10_palette_ids.bin"
image_010_11.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_11.bin"
image_010_11_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_11_palette_ids.bin"
image_010_12.bin:
    INCBIN ".gfx/special_tilesets/kung_fu_theater/image_010_12.bin"
image_010_12_palette_ids.bin:
    INCBIN "gfx/special_tilesets/kung_fu_theater/palette_ids/image_010_12_palette_ids.bin"

SECTION "bank11", ROMX[$4000], BANK[$11]
image_011_4000.bin:
    INCBIN ".gfx/object_sprites/image_011_4000.bin"

SECTION "bank12", ROMX[$4000], BANK[$12]
image_012_4000.bin:
    INCBIN ".gfx/object_sprites/image_012_4000.bin"
image_012_6000.bin:
    INCBIN ".gfx/object_sprites/image_012_6000.bin"

SECTION "bank13", ROMX[$4000], BANK[$13]
image_013_00.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_00.bin"
image_013_00_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_00_palette_ids.bin"
image_013_01.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_01.bin"
image_013_01_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_01_palette_ids.bin"
image_013_02.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_02.bin"
image_013_02_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_02_palette_ids.bin"
image_013_03.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_03.bin"
image_013_03_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_03_palette_ids.bin"
image_013_04.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_04.bin"
image_013_04_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_04_palette_ids.bin"
image_013_05.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_05.bin"
image_013_05_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_05_palette_ids.bin"
image_013_06.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_06.bin"
image_013_06_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_06_palette_ids.bin"
image_013_07.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_07.bin"
image_013_07_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_07_palette_ids.bin"
image_013_08.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_08.bin"
image_013_08_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_08_palette_ids.bin"
image_013_09.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_09.bin"
image_013_09_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_09_palette_ids.bin"
image_013_10.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_10.bin"
image_013_10_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_10_palette_ids.bin"
image_013_11.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_11.bin"
image_013_11_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_11_palette_ids.bin"
image_013_12.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_12.bin"
image_013_12_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_12_palette_ids.bin"
image_013_13.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_13.bin"
image_013_13_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_13_palette_ids.bin"
image_013_14.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_14.bin"
image_013_14_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_14_palette_ids.bin"
image_013_15.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_15.bin"
image_013_15_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_15_palette_ids.bin"
image_013_16.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_16.bin"
image_013_16_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_16_palette_ids.bin"
image_013_17.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_17.bin"
image_013_17_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_17_palette_ids.bin"
image_013_18.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_18.bin"
image_013_18_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_18_palette_ids.bin"
image_013_19.bin:
    INCBIN ".gfx/special_tilesets/media_dimension/image_013_19.bin"
image_013_19_palette_ids.bin:
    INCBIN "gfx/special_tilesets/media_dimension/palette_ids/image_013_19_palette_ids.bin"

SECTION "bank14", ROMX[$4000], BANK[$14]
image_014_4000.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4000.bin"
image_014_4100.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4100.bin"
image_014_4200.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4200.bin"
image_014_4300.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4300.bin"
image_014_4400.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4400.bin"
image_014_4500.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4500.bin"
image_014_4600.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4600.bin"
image_014_4700.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4700.bin"
image_014_4800.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4800.bin"
image_014_4900.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4900.bin"
image_014_4a00.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4a00.bin"
image_014_4b00.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4b00.bin"
image_014_4c00.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4c00.bin"
image_014_4d00.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4d00.bin"
image_014_4e00.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4e00.bin"
image_014_4f00.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_4f00.bin"
image_014_5000.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5000.bin"
image_014_5100.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5100.bin"
image_014_5200.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5200.bin"
image_014_5300.bin:
    INCBIN ".gfx/misc_sprites/level_names/image_014_5300.bin"

SECTION "bank15", ROMX[$4000], BANK[$15]

SECTION "bank16", ROMX[$4000], BANK[$16]

SECTION "bank17", ROMX[$4000], BANK[$17]

SECTION "bank18", ROMX[$4000], BANK[$18]
image_018_4000.bin:
    INCBIN ".gfx/object_sprites/image_018_4000.bin"
image_018_6000.bin:
    INCBIN ".gfx/object_sprites/image_018_6000.bin"

SECTION "bank19", ROMX[$4000], BANK[$19]
image_019_4000.bin:
    INCBIN ".gfx/object_sprites/image_019_4000.bin"
image_019_6000.bin:
    INCBIN ".gfx/object_sprites/image_019_6000.bin"

SECTION "bank1a", ROMX[$4000], BANK[$1a]
image_01a_4000.bin:
    INCBIN ".gfx/object_sprites/image_01a_4000.bin"
image_01a_6000.bin:
    INCBIN ".gfx/object_sprites/image_01a_6000.bin"

SECTION "bank1b", ROMX[$4000], BANK[$1b]
image_01b_4000.bin:
    INCBIN ".gfx/object_sprites/image_01b_4000.bin"
image_01b_6000.bin:
    INCBIN ".gfx/object_sprites/image_01b_6000.bin"

SECTION "bank1c", ROMX[$4000], BANK[$1c]
image_01c_4000.bin:
    INCBIN ".gfx/object_sprites/image_01c_4000.bin"
image_01c_6000.bin:
    INCBIN ".gfx/object_sprites/image_01c_6000.bin"

SECTION "bank1d", ROMX[$4000], BANK[$1d]
image_credits2_01d_0.bin:
    INCBIN ".gfx/splash/image_credits2_01d_0.bin"
image_credits2_01d_0_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_credits2_01d_0_palette_ids.bin"
image_credits3_01d_1.bin:
    INCBIN ".gfx/splash/image_credits3_01d_1.bin"
image_credits3_01d_1_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_credits3_01d_1_palette_ids.bin"

SECTION "bank1e", ROMX[$4000], BANK[$1e]
image_david_01e_0.bin:
    INCBIN ".gfx/splash/image_david_01e_0.bin"
image_david_01e_0_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_david_01e_0_palette_ids.bin"
image_credits1_01e_1.bin:
    INCBIN ".gfx/splash/image_credits1_01e_1.bin"
image_credits1_01e_1_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_credits1_01e_1_palette_ids.bin"

SECTION "bank1f", ROMX[$4000], BANK[$1f]
image_crave_01f_0.bin:
    INCBIN ".gfx/splash/image_crave_01f_0.bin"
image_crave_01f_0_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_crave_01f_0_palette_ids.bin"
image_splash_01f_1.bin:
    INCBIN ".gfx/splash/image_splash_01f_1.bin"
image_splash_01f_1_palette_ids.bin:
    INCBIN "gfx/splash/palette_ids/image_splash_01f_1_palette_ids.bin"

SECTION "bank20", ROMX[$4000], BANK[$20]

INCLUDE "audio_engine/bank21_audio1.asm"
INCLUDE "audio_engine/bank22_audio2.asm"
INCLUDE "audio_engine/bank23_audio3.asm"
INCLUDE "audio_engine/bank24_audio4.asm"

SECTION "bank25", ROMX[$4000], BANK[$25]
map_circuit_central3.bin:
    INCBIN "maps/circuit_central/map_circuit_central3.bin"

SECTION "bank26", ROMX[$4000], BANK[$26]
tileset_channel_z.bin:
    INCBIN ".gfx/tilesets/tileset_channel_z.bin"

SECTION "bank27", ROMX[$4000], BANK[$27]
blockset_data_channel_z.bin:
    INCBIN "maps/channel_z/blockset_data_channel_z.bin"

SECTION "bank28", ROMX[$4000], BANK[$28]
map_channel_z.bin:
    INCBIN "maps/channel_z/map_channel_z.bin"

SECTION "bank29", ROMX[$4000], BANK[$29]
map_rezopolis.bin:
    INCBIN "maps/rezopolis/map_rezopolis.bin"

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
blockset_override_data_bank34.bin:
    INCBIN "maps/blockset_override_data_bank34.bin"

SECTION "bank35", ROMX[$4000], BANK[$35]
blockset_override_data_bank35.bin:
    INCBIN "maps/blockset_override_data_bank35.bin"

SECTION "bank36", ROMX[$4000], BANK[$36]
tileset_media_dimension.bin:
    INCBIN ".gfx/tilesets/tileset_media_dimension.bin"
tileset_toon_tv.bin:
    INCBIN ".gfx/tilesets/tileset_toon_tv.bin"
tileset_scream_tv.bin:
    INCBIN ".gfx/tilesets/tileset_scream_tv.bin"
tileset_circuit_central.bin:
    INCBIN ".gfx/tilesets/tileset_circuit_central.bin"

SECTION "bank37", ROMX[$4000], BANK[$37]
tileset_kung_fu_theater.bin:
    INCBIN ".gfx/tilesets/tileset_kung_fu_theater.bin"
image_037_5000.bin:
    INCBIN ".gfx/tilesets/tileset_prehistory_channel.bin"
image_037_6000.bin:
    INCBIN ".gfx/tilesets/tileset_rezopolis.bin"

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
image_credits4_03d_0.bin:
    INCBIN ".gfx/splash/image_credits4_03d_0.bin"

SECTION "bank3E", ROMX[$4000], BANK[$3e]
blockset_data_prehistory_channel.bin:
    INCBIN "maps/prehistory_channel/blockset_data_prehistory_channel.bin"

SECTION "bank3F", ROMX[$4000], BANK[$3f]
blockset_data_rezopolis.bin:
    INCBIN "maps/rezopolis/blockset_data_rezopolis.bin"
