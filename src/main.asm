; Disassembly of "Gex - Enter the Gecko (USA, Europe).gbc"

INCLUDE "constants/hardware.inc"
INCLUDE "constants/constants.asm"
INCLUDE "constants/memory.asm"
INCLUDE "code/macros/macros.asm"

SECTION "bank00", ROM0[$0000]
INCLUDE "code/bank00_home.asm"

SECTION "bank01", ROMX[$4000], BANK[$01]
INCLUDE "code/menus/bank01_menu_load.asm"
INCLUDE "code/menus/bank01_menu_script.asm"
INCLUDE "code/menus/bank01_text_render.asm"
INCLUDE "code/menus/bank01_menu_sprites.asm"
INCLUDE "code/menus/bank01_password.asm"
INCLUDE "code/menus/bank01_menu_tables.asm"
INCLUDE "code/menus/bank01_menu_scripts.asm"
INCLUDE "code/menus/bank01_sprite_scripts.asm"
INCLUDE "code/menus/bank01_text.asm"
INCLUDE "code/menus/bank01_menu_gfx.asm"

SECTION "bank02", ROMX[$4000], BANK[$02]
INCLUDE "code/bank02_update_entities.asm"

SECTION "bank03", ROMX[$4000], BANK[$03]
INCLUDE "code/bank03_bg_collision.asm"
INCLUDE "code/bank03_entity_collision.asm"
INCLUDE "code/bank03_oam_build.asm"
INCLUDE "code/bank03_particle_sprites.asm"
INCLUDE "code/bank03_hud_tiles.asm"
INCLUDE "code/bank03_vram_write.asm"
INCLUDE "code/bank03_map_tile_anim.asm"

SECTION "bank04", ROMX[$4000], BANK[$04]
    ; $4000  4x4 tiles - PLAYER_ACTION_WALK, PLAYER_ACTION_NONE
    INCBIN ".gfx/entity_sprites/player/image_player_walk_none_004_4000.bin"
    ; $4100  28x4 tiles - PLAYER_ACTION_WALK
    INCBIN ".gfx/entity_sprites/player/image_player_walk_004_4100.bin"
    ; $4800  4x4 tiles - PLAYER_ACTION_CLIMB via .data_02_472e_ClimbStopSprites
    INCBIN ".gfx/entity_sprites/player/image_player_climb_corner_004_4800.bin"
    ; $4900  4x4 tiles - PLAYER_ACTION_IDLE_ANIMATION, PLAYER_ACTION_EAT_FLY
    INCBIN ".gfx/entity_sprites/player/image_player_idle_animation_eat_fly_004_4900.bin"
    ; $4a00  32x4 tiles - PLAYER_ACTION_RUN
    INCBIN ".gfx/entity_sprites/player/image_player_run_004_4a00.bin"
    ; $5200  8x4 tiles - no player action names these frames
    INCBIN ".gfx/entity_sprites/player/image_player_unused_004_5200.bin"
    ; $5400  4x4 tiles - PLAYER_ACTION_INTRO_WARP, PLAYER_ACTION_STAND
    INCBIN ".gfx/entity_sprites/player/image_player_intro_warp_stand_004_5400.bin"
    ; $5500  12x4 tiles - PLAYER_ACTION_STAND
    INCBIN ".gfx/entity_sprites/player/image_player_stand_004_5500.bin"
    ; $5800  12x4 tiles - PLAYER_ACTION_SKID
    INCBIN ".gfx/entity_sprites/player/image_player_skid_004_5800.bin"
    ; $5b00  4x4 tiles - PLAYER_ACTION_DOUBLE_JUMP
    INCBIN ".gfx/entity_sprites/player/image_player_double_jump_004_5b00.bin"
    ; $5c00  4x4 tiles - PLAYER_ACTION_TAKE_DAMAGE, PLAYER_ACTION_STOP_IMMEDIATE, PLAYER_ACTION_COLLAPSE
    INCBIN ".gfx/entity_sprites/player/image_player_take_damage_stop_immediate_and_1_more_004_5c00.bin"
    ; $5d00  4x4 tiles - PLAYER_ACTION_CROUCH
    INCBIN ".gfx/entity_sprites/player/image_player_crouch_004_5d00.bin"
    ; $5e00  16x4 tiles - PLAYER_ACTION_FREEFALL
    INCBIN ".gfx/entity_sprites/player/image_player_freefall_004_5e00.bin"
    ; $6200  24x4 tiles - PLAYER_ACTION_TAIL_SPIN
    INCBIN ".gfx/entity_sprites/player/image_player_tail_spin_004_6200.bin"
    ; $6800  28x4 tiles - PLAYER_ACTION_ENTER_TV, PLAYER_ACTION_ENTER_TV_ALT
    INCBIN ".gfx/entity_sprites/player/image_player_enter_tv_enter_tv_alt_004_6800.bin"
    ; $6f00  12x4 tiles - PLAYER_ACTION_ENTER_TV, PLAYER_ACTION_ENTER_TV_ALT, PLAYER_ACTION_EXIT_TV
    INCBIN ".gfx/entity_sprites/player/image_player_enter_tv_enter_tv_alt_and_1_more_004_6f00.bin"
    ; $7200  16x4 tiles - PLAYER_ACTION_TEETER
    INCBIN ".gfx/entity_sprites/player/image_player_teeter_004_7200.bin"
    ; $7600  20x4 tiles - PLAYER_ACTION_COLLAPSE
    INCBIN ".gfx/entity_sprites/player/image_player_collapse_004_7600.bin"
    ; $7b00  4x4 tiles - PLAYER_ACTION_DEATH_SET_UP_WARP
    INCBIN ".gfx/entity_sprites/player/image_player_death_set_up_warp_004_7b00.bin"
    ; $7c00  4x4 tiles - PLAYER_ACTION_ENTER_DOOR
    INCBIN ".gfx/entity_sprites/player/image_player_enter_door_004_7c00.bin"
    ; $7d00  12x4 tiles - no player action names these frames
    INCBIN ".gfx/entity_sprites/player/image_player_unused_004_7d00.bin"

SECTION "bank05", ROMX[$4000], BANK[$05]
    ; $4000  4x4 tiles - PLAYER_ACTION_CLIMB via .data_02_454f_BackgroundClimbSpriteBaseByDirection, PLAYER_ACTION_RIDING_ROCKET
    INCBIN ".gfx/entity_sprites/player/image_player_climb_background_riding_rocket_005_4000.bin"
    ; $4100  92x4 tiles - PLAYER_ACTION_CLIMB via .data_02_454f_BackgroundClimbSpriteBaseByDirection
    INCBIN ".gfx/entity_sprites/player/image_player_climb_background_005_4100.bin"
    ; $5800  32x4 tiles - PLAYER_ACTION_CLIMB via CLIMB_TAIL_SPIN_SPRITE_BASE ($58)
    INCBIN ".gfx/entity_sprites/player/image_player_climb_background_spin_005_5800.bin"
    ; $6000  4x4 tiles - PLAYER_ACTION_CLIMB via .data_02_461e_WallClimbSpriteBaseByDirection, PLAYER_ACTION_CLIMB via .data_02_4757_ClimbStopExitState byte +3
    INCBIN ".gfx/entity_sprites/player/image_player_climb_wall_climb_corner_exit_005_6000.bin"
    ; $6100  28x4 tiles - PLAYER_ACTION_CLIMB via .data_02_461e_WallClimbSpriteBaseByDirection
    INCBIN ".gfx/entity_sprites/player/image_player_climb_wall_005_6100.bin"
    ; $6800  4x4 tiles - PLAYER_ACTION_CLIMB via .data_02_461e_WallClimbSpriteBaseByDirection, PLAYER_ACTION_CLIMB via .data_02_4757_ClimbStopExitState byte +3
    INCBIN ".gfx/entity_sprites/player/image_player_climb_wall_climb_corner_exit_005_6800.bin"
    ; $6900  28x4 tiles - PLAYER_ACTION_CLIMB via .data_02_461e_WallClimbSpriteBaseByDirection
    INCBIN ".gfx/entity_sprites/player/image_player_climb_wall_005_6900.bin"
    ; $7000  64x4 tiles - PLAYER_ACTION_CLIMB via .data_02_465f_WallTailSpinSpriteBaseByDirection
    INCBIN ".gfx/entity_sprites/player/image_player_climb_wall_spin_005_7000.bin"

SECTION "bank06", ROMX[$4000], BANK[$06]
    ; $4000  16x4 tiles - no player action names these frames
    INCBIN ".gfx/entity_sprites/player/image_player_unused_006_4000.bin"
    ; $4400  16x4 tiles - PLAYER_ACTION_WALKING_PUSH
    INCBIN ".gfx/entity_sprites/player/image_player_walking_push_006_4400.bin"
    ; $4800  4x4 tiles - PLAYER_ACTION_STANDING_PUSH, PLAYER_ACTION_WALKING_PUSH
    INCBIN ".gfx/entity_sprites/player/image_player_standing_push_walking_push_006_4800.bin"
    ; $4900  12x4 tiles - PLAYER_ACTION_WALKING_PUSH
    INCBIN ".gfx/entity_sprites/player/image_player_walking_push_006_4900.bin"
    ; $4c00  16x4 tiles - PLAYER_ACTION_TAKE_DAMAGE
    INCBIN ".gfx/entity_sprites/player/image_player_take_damage_006_4c00.bin"
    ; $5000  12x4 tiles - PLAYER_ACTION_DEATH
    INCBIN ".gfx/entity_sprites/player/image_player_death_006_5000.bin"
    ; $5300  12x4 tiles - PLAYER_ACTION_JUMP, PLAYER_ACTION_HIT_BOUNCE
    INCBIN ".gfx/entity_sprites/player/image_player_jump_hit_bounce_006_5300.bin"
    ; $5600  4x4 tiles - PLAYER_ACTION_DEATH
    INCBIN ".gfx/entity_sprites/player/image_player_death_006_5600.bin"
    ; $5700  32x4 tiles - PLAYER_ACTION_CLIMB via .data_02_454f_BackgroundClimbSpriteBaseByDirection
    INCBIN ".gfx/entity_sprites/player/image_player_climb_background_006_5700.bin"
    ; $5f00  48x4 tiles - PLAYER_ACTION_SPAWN, PLAYER_ACTION_GOLD_REMOTE_WARP
    INCBIN ".gfx/entity_sprites/player/image_player_spawn_gold_remote_warp_006_5f00.bin"
    ; $6b00  4x4 tiles - PLAYER_ACTION_DEATH_SET_UP_WARP
    INCBIN ".gfx/entity_sprites/player/image_player_death_set_up_warp_006_6b00.bin"
    ; $6c00  8x4 tiles - PLAYER_ACTION_KARATE_KICK
    INCBIN ".gfx/entity_sprites/player/image_player_karate_kick_006_6c00.bin"
    ; $6e00  32x4 tiles - PLAYER_ACTION_ENTER_DOOR
    INCBIN ".gfx/entity_sprites/player/image_player_enter_door_006_6e00.bin"
    ; $7600  24x4 tiles - PLAYER_ACTION_LEAVE_DOOR
    INCBIN ".gfx/entity_sprites/player/image_player_leave_door_006_7600.bin"
    ; $7c00  16x4 tiles - no player action names these frames
    INCBIN ".gfx/entity_sprites/player/image_player_unused_006_7c00.bin"

SECTION "bank07", ROMX[$4000], BANK[$07]
    ; $4000  8x4 tiles - PLAYER_ACTION_LEAVE_DOOR
    INCBIN ".gfx/entity_sprites/player/image_player_leave_door_007_4000.bin"
    ; $4200  24x4 tiles - PLAYER_ACTION_CLIMB via .data_02_4689_BackgroundDismountSprites
    INCBIN ".gfx/entity_sprites/player/image_player_climb_background_drop_007_4200.bin"
    ; $4800  8x4 tiles - PLAYER_ACTION_CLIMB via .data_02_46b1_WallDismountSprites
    INCBIN ".gfx/entity_sprites/player/image_player_climb_wall_drop_007_4800.bin"
    ; $4a00  28x4 tiles - PLAYER_ACTION_CLIMB via .data_02_472e_ClimbStopSprites
    INCBIN ".gfx/entity_sprites/player/image_player_climb_corner_007_4a00.bin"
    ; $5100  28x4 tiles - PLAYER_ACTION_EXIT_TV
    INCBIN ".gfx/entity_sprites/player/image_player_exit_tv_007_5100.bin"
    ; $5800  32x4 tiles - no player action names these frames
    INCBIN ".gfx/entity_sprites/player/image_player_unused_007_5800.bin"

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
    ; $4000  8x2 tiles - ENTITY_UNK_64, ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM, ENTITY_REZOPOLIS_MOVING_PLATFORM, ENTITY_REZOPOLIS_RED_PLATFORM, ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_26_unk_64_and_4_more_011_4000.bin"
    ; $4100  4x4 tiles - ENTITY_UNK_6C, ENTITY_UNK_6D
    INCBIN ".gfx/entity_sprites/queued/image_gfx_27_unk_6c_unk_6d_011_4100.bin"
    ; $4200  8x4 tiles - ENTITY_REZOPOLIS_FLAMETHROWER
    INCBIN ".gfx/entity_sprites/queued/image_gfx_28_rezopolis_flamethrower_011_4200.bin"
    ; $4400  8x2 tiles - ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_29_rezopolis_tailspin_platform_011_4400.bin"
    ; $4500  16x2 tiles - ENTITY_REZOPOLIS_TAILSPIN_GEAR
    INCBIN ".gfx/entity_sprites/queued/image_gfx_2a_rezopolis_tailspin_gear_011_4500.bin"
    ; $4700  4x4 tiles - ENTITY_UNK_6F, ENTITY_UNK_70
    INCBIN ".gfx/entity_sprites/queued/image_gfx_2b_unk_6f_unk_70_011_4700.bin"
    ; $4800  16x2 tiles - ENTITY_REZOPOLIS_ANT, ENTITY_CIRCUIT_CENTRAL_ANT
    INCBIN ".gfx/entity_sprites/queued/image_gfx_2c_38_rezopolis_ant_circuit_central_ant_011_4800.bin"
    ; $4a00  4x4 tiles - ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    INCBIN ".gfx/entity_sprites/queued/image_gfx_2d_circuit_central_capacitor_011_4a00.bin"
    ; $4b00  8x2 tiles - ENTITY_CIRCUIT_CENTRAL_POWER_UP
    INCBIN ".gfx/entity_sprites/queued/image_gfx_2e_circuit_central_power_up_011_4b00.bin"
    ; $4c00  16x2 tiles - ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT, ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    INCBIN ".gfx/entity_sprites/queued/image_gfx_2f_circuit_central_little_robot_and_1_more_011_4c00.bin"
    ; $4e00  8x2 tiles - ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    INCBIN ".gfx/entity_sprites/queued/image_gfx_30_circuit_central_electric_ball_011_4e00.bin"
    ; $4f00  8x2 tiles - ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM, ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM, ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_31_circuit_central_moving_platform_and_2_more_011_4f00.bin"
    ; $5000  16x2 tiles - ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE, ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2, ENTITY_CHANNEL_Z_GUN_PROJECTILE, ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1, ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2, ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE, ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    INCBIN ".gfx/entity_sprites/queued/image_gfx_32_channel_z_arced_gun_projectile_and_6_more_011_5000.bin"
    ; $5200  8x4 tiles - ENTITY_SCREAM_TV_HEAD_GHOST
    INCBIN ".gfx/entity_sprites/queued/image_gfx_33_scream_tv_head_ghost_011_5200.bin"
    ; $5400  8x4 tiles - ENTITY_TOON_TV_ROCKET
    INCBIN ".gfx/entity_sprites/queued/image_gfx_34_toon_tv_rocket_011_5400.bin"
    ; $5600  8x2 tiles - ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_35_media_dimension_moving_platform_011_5600.bin"
    ; $5700  4x4 tiles - no entity selects this graphics id
    INCBIN ".gfx/entity_sprites/queued/image_gfx_36_unused_011_5700.bin"
    ; $5800  8x2 tiles - ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    INCBIN ".gfx/entity_sprites/queued/image_gfx_37_final_battle_button_projectile_011_5800.bin"
    ; $5900  8x2 tiles - ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    INCBIN ".gfx/entity_sprites/queued/image_gfx_39_channel_z_final_battle_button_011_5900.bin"
    ; $5a00  24x4 tiles - not named by any descriptor
    INCBIN ".gfx/entity_sprites/queued/image_unused_011_5a00.bin"

SECTION "bank12", ROMX[$4000], BANK[$12]
    ; $4000  8x2 tiles - ENTITY_SCREAM_TV_FALLING_PLATFORM, ENTITY_SCREAM_TV_MOVING_PLATFORM, ENTITY_SCREAM_TV_FALLING_AXE, ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY, ENTITY_SCREAM_TV_VANISHING_PLATFORM, ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    INCBIN ".gfx/entity_sprites/queued/image_gfx_01_scream_tv_falling_platform_and_5_more_012_4000.bin"
    ; $4100  4x4 tiles - ENTITY_SCREAM_TV_LANTERN
    INCBIN ".gfx/entity_sprites/queued/image_gfx_02_scream_tv_lantern_012_4100.bin"
    ; $4200  8x2 tiles - ENTITY_SCREAM_TV_PUSH_BLOCK, ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_24_scream_tv_push_block_and_1_more_012_4200.bin"
    ; $4300  16x4 tiles - ENTITY_TOON_TV_BOWLING_BALL
    INCBIN ".gfx/entity_sprites/queued/image_gfx_07_toon_tv_bowling_ball_012_4300.bin"
    ; $4700  16x4 tiles - ENTITY_TOON_TV_FLOWER
    INCBIN ".gfx/entity_sprites/queued/image_gfx_08_toon_tv_flower_012_4700.bin"
    ; $4b00  12x4 tiles - ENTITY_TOON_TV_CACTUS
    INCBIN ".gfx/entity_sprites/queued/image_gfx_06_toon_tv_cactus_012_4b00.bin"
    ; $4e00  24x2 tiles - ENTITY_TOON_TV_LIZARD
    INCBIN ".gfx/entity_sprites/queued/image_gfx_09_toon_tv_lizard_012_4e00.bin"
    ; $5100  8x4 tiles - ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    INCBIN ".gfx/entity_sprites/queued/image_gfx_03_toon_tv_hard_head_area_hazard_012_5100.bin"
    ; $5300  8x4 tiles - ENTITY_TOON_TV_MOVING_BEAR_TRAP
    INCBIN ".gfx/entity_sprites/queued/image_gfx_04_toon_tv_moving_bear_trap_012_5300.bin"
    ; $5500  16x2 tiles - ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    INCBIN ".gfx/entity_sprites/queued/image_gfx_05_toon_tv_stationary_bear_trap_012_5500.bin"
    ; $5700  8x4 tiles - ENTITY_TOON_TV_BUMBLEBEE
    INCBIN ".gfx/entity_sprites/queued/image_gfx_0f_toon_tv_bumblebee_012_5700.bin"
    ; $5900  4x4 tiles - ENTITY_TOON_TV_DOMINO
    INCBIN ".gfx/entity_sprites/queued/image_gfx_0e_toon_tv_domino_012_5900.bin"
    ; $5a00  8x2 tiles - ENTITY_TOON_TV_SHARK
    INCBIN ".gfx/entity_sprites/queued/image_gfx_0d_toon_tv_shark_012_5a00.bin"
    ; $5b00  8x2 tiles - ENTITY_TOON_TV_MUSHROOM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_0b_toon_tv_mushroom_012_5b00.bin"
    ; $5c00  8x2 tiles - ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    INCBIN ".gfx/entity_sprites/queued/image_gfx_23_toon_tv_mushroom_projectile_012_5c00.bin"
    ; $5d00  8x2 tiles - ENTITY_TOON_TV_MOVING_LOG, ENTITY_TOON_TV_HUNTER_BULLET
    INCBIN ".gfx/entity_sprites/queued/image_gfx_0a_toon_tv_moving_log_toon_tv_hunter_bullet_012_5d00.bin"
    ; $5e00  8x2 tiles - ENTITY_TOON_TV_STATIONARY_LOG
    INCBIN ".gfx/entity_sprites/queued/image_gfx_0c_toon_tv_stationary_log_012_5e00.bin"
    ; $5f00  8x2 tiles - ENTITY_TOON_TV_VANISHING_BLOCK, ENTITY_TOON_TV_MOVING_BLOCK
    INCBIN ".gfx/entity_sprites/queued/image_gfx_10_toon_tv_vanishing_block_toon_tv_moving_block_012_5f00.bin"
    ; $6000  8x2 tiles - ENTITY_UNK_36
    INCBIN ".gfx/entity_sprites/queued/image_gfx_11_unk_36_012_6000.bin"
    ; $6100  8x2 tiles - ENTITY_PRE_HISTORY_FALLING_LAVA
    INCBIN ".gfx/entity_sprites/queued/image_gfx_12_pre_history_falling_lava_012_6100.bin"
    ; $6200  8x2 tiles - ENTITY_PRE_HISTORY_LAVA_RAFT, ENTITY_PRE_HISTORY_MOVING_PLATFORM, ENTITY_UNK_3A, ENTITY_UNK_3B, ENTITY_UNK_46
    INCBIN ".gfx/entity_sprites/queued/image_gfx_20_pre_history_lava_raft_and_4_more_012_6200.bin"
    ; $6300  12x4 tiles - ENTITY_UNK_3D, ENTITY_PRE_HISTORY_FALLING_BOULDER
    INCBIN ".gfx/entity_sprites/queued/image_gfx_13_unk_3d_pre_history_falling_boulder_012_6300.bin"
    ; $6600  16x2 tiles - ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL, ENTITY_PRE_HISTORY_BEETLE_VERTICAL, ENTITY_PRE_HISTORY_ANT
    INCBIN ".gfx/entity_sprites/queued/image_gfx_1e_pre_history_beetle_horizontal_and_2_more_012_6600.bin"
    ; $6800  12x4 tiles - ENTITY_PRE_HISTORY_GEYSER
    INCBIN ".gfx/entity_sprites/queued/image_gfx_21_pre_history_geyser_012_6800.bin"
    ; $6b00  12x4 tiles - ENTITY_UNK_35
    INCBIN ".gfx/entity_sprites/queued/image_gfx_25_unk_35_012_6b00.bin"
    ; $6e00  16x2 tiles - ENTITY_PRE_HISTORY_FIRE_PLANT
    INCBIN ".gfx/entity_sprites/queued/image_gfx_14_pre_history_fire_plant_012_6e00.bin"
    ; $7000  8x2 tiles - ENTITY_PRE_HISTORY_TRICERATOPS
    INCBIN ".gfx/entity_sprites/queued/image_gfx_22_pre_history_triceratops_012_7000.bin"
    ; $7100  4x4 tiles - ENTITY_KUNG_FU_THEATER_TALL_JAR
    INCBIN ".gfx/entity_sprites/queued/image_gfx_15_kung_fu_theater_tall_jar_012_7100.bin"
    ; $7200  4x4 tiles - ENTITY_KUNG_FU_THEATER_JAR
    INCBIN ".gfx/entity_sprites/queued/image_gfx_16_kung_fu_theater_jar_012_7200.bin"
    ; $7300  24x2 tiles - ENTITY_KUNG_FU_THEATER_LIZARD
    INCBIN ".gfx/entity_sprites/queued/image_gfx_17_kung_fu_theater_lizard_012_7300.bin"
    ; $7600  8x2 tiles - ENTITY_KUNG_FU_THEATER_CANNON, ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE, ENTITY_KUNG_FU_THEATER_WALKING_NINJA, ENTITY_KUNG_FU_THEATER_JUMPING_NINJA, ENTITY_KUNG_FU_THEATER_SAMURAI_BODY, ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    INCBIN ".gfx/entity_sprites/queued/image_gfx_18_kung_fu_theater_cannon_and_5_more_012_7600.bin"
    ; $7700  8x2 tiles - ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT, ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    INCBIN ".gfx/entity_sprites/queued/image_gfx_19_kung_fu_theater_dragon_body_segment_and_1_more_012_7700.bin"
    ; $7800  4x4 tiles - ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    INCBIN ".gfx/entity_sprites/queued/image_gfx_1a_kung_fu_theater_hanging_blade_012_7800.bin"
    ; $7900  4x4 tiles - ENTITY_UNK_5C, ENTITY_UNK_5D  (shapes disagree on height: [2, 4], using 4)
    INCBIN ".gfx/entity_sprites/queued/image_gfx_1b_unk_5c_unk_5d_012_7900.bin"
    ; $7a00  8x2 tiles - ENTITY_UNK_60, ENTITY_KUNG_FU_THEATER_MOVING_RAFT, ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    INCBIN ".gfx/entity_sprites/queued/image_gfx_1c_unk_60_kung_fu_theater_moving_raft_and_1_more_012_7a00.bin"
    ; $7b00  8x2 tiles - ENTITY_KUNG_FU_THEATER_SPIKY_LOG, ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM, ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    INCBIN ".gfx/entity_sprites/queued/image_gfx_1d_kung_fu_theater_spiky_log_and_2_more_012_7b00.bin"
    ; $7c00  8x4 tiles - ENTITY_UNK_51
    INCBIN ".gfx/entity_sprites/queued/image_gfx_1f_unk_51_012_7c00.bin"
    ; $7e00  8x4 tiles - not named by any descriptor
    INCBIN ".gfx/entity_sprites/queued/image_unused_012_7e00.bin"

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
    ; $4000  32x4 tiles - ENTITY_RED_REMOTE
    INCBIN ".gfx/entity_sprites/streamed/image_red_remote_018_4000.bin"
    ; $4800  24x4 tiles - ENTITY_RED_REMOTE, ENTITY_SILVER_REMOTE, ENTITY_GOLD_REMOTE
    INCBIN ".gfx/entity_sprites/streamed/image_red_remote_silver_remote_and_1_more_018_4800.bin"
    ; $4e00  8x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_018_4e00.bin"
    ; $5000  32x4 tiles - ENTITY_GOLD_REMOTE
    INCBIN ".gfx/entity_sprites/streamed/image_gold_remote_018_5000.bin"
    ; $5800  56x4 tiles - ENTITY_KUNG_FU_THEATER_WALKING_NINJA, ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    INCBIN ".gfx/entity_sprites/streamed/image_kung_fu_theater_walking_ninja_and_1_more_018_5800.bin"
    ; $6600  4x4 tiles - ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    INCBIN ".gfx/entity_sprites/streamed/image_kung_fu_theater_jumping_ninja_018_6600.bin"
    ; $6700  48x4 tiles - ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    INCBIN ".gfx/entity_sprites/streamed/image_kung_fu_theater_samurai_body_018_6700.bin"
    ; $7300  4x4 tiles - ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    INCBIN ".gfx/entity_sprites/streamed/image_kung_fu_theater_dragon_head_018_7300.bin"
    ; $7400  32x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_018_7400.bin"
    ; $7c00  16x4 tiles - ENTITY_SCREAM_TV_DOOR_OPENING
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_door_opening_018_7c00.bin"

SECTION "bank19", ROMX[$4000], BANK[$19]
    ; $4000  4x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_019_4000.bin"
    ; $4100  20x4 tiles - ENTITY_TOON_TV_HAPPY_FACE
    INCBIN ".gfx/entity_sprites/streamed/image_toon_tv_happy_face_019_4100.bin"
    ; $4600  80x4 tiles - ENTITY_TOON_TV_HUNTER
    INCBIN ".gfx/entity_sprites/streamed/image_toon_tv_hunter_019_4600.bin"
    ; $5a00  16x4 tiles - ENTITY_UNK_08, ENTITY_TOON_TV_HUNTER
    INCBIN ".gfx/entity_sprites/streamed/image_unk_08_toon_tv_hunter_019_5a00.bin"
    ; $5e00  4x4 tiles - ENTITY_TOON_TV_HUNTER
    INCBIN ".gfx/entity_sprites/streamed/image_toon_tv_hunter_019_5e00.bin"
    ; $5f00  24x4 tiles - ENTITY_KUNG_FU_THEATER_DRAGONFLY
    INCBIN ".gfx/entity_sprites/streamed/image_kung_fu_theater_dragonfly_019_5f00.bin"
    ; $6500  32x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_019_6500.bin"
    ; $6d00  24x4 tiles - ENTITY_PRE_HISTORY_EGG
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_egg_019_6d00.bin"
    ; $7300  4x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_019_7300.bin"
    ; $7400  24x4 tiles - ENTITY_PRE_HISTORY_EGG
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_egg_019_7400.bin"
    ; $7a00  16x4 tiles - ENTITY_SCREAM_TV_BAT
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_bat_019_7a00.bin"
    ; $7e00  8x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_019_7e00.bin"

SECTION "bank1a", ROMX[$4000], BANK[$1a]
    ; $4000  24x4 tiles - ENTITY_PRE_HISTORY_DRAGONFLY
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_dragonfly_01a_4000.bin"
    ; $4600  24x4 tiles - ENTITY_PRE_HISTORY_PTEROSAUR
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_pterosaur_01a_4600.bin"
    ; $4c00  32x4 tiles - ENTITY_PRE_HISTORY_DINOSAUR
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_dinosaur_01a_4c00.bin"
    ; $5400  24x4 tiles - ENTITY_PRE_HISTORY_TRICERATOPS
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_triceratops_01a_5400.bin"
    ; $5a00  20x4 tiles - ENTITY_SCREAM_TV_PUMPKIN
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_pumpkin_01a_5a00.bin"
    ; $5f00  12x4 tiles - ENTITY_SCREAM_TV_FRANKIE
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_frankie_01a_5f00.bin"
    ; $6200  36x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01a_6200.bin"
    ; $6b00  8x4 tiles - ENTITY_SCREAM_TV_GHOST
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_ghost_01a_6b00.bin"
    ; $6d00  8x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01a_6d00.bin"
    ; $6f00  20x4 tiles - ENTITY_SCREAM_TV_GHOST
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_ghost_01a_6f00.bin"
    ; $7400  12x4 tiles - ENTITY_SCREAM_TV_FLOATING_SKULL
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_floating_skull_01a_7400.bin"
    ; $7700  24x4 tiles - ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    INCBIN ".gfx/entity_sprites/streamed/image_circuit_central_walker_robot_01a_7700.bin"
    ; $7d00  12x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01a_7d00.bin"

SECTION "bank1b", ROMX[$4000], BANK[$1b]
    ; $4000  24x4 tiles - ENTITY_REZOPOLIS_UFO
    INCBIN ".gfx/entity_sprites/streamed/image_rezopolis_ufo_01b_4000.bin"
    ; $4600  4x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01b_4600.bin"
    ; $4700  12x4 tiles - ENTITY_REZOPOLIS_UFO
    INCBIN ".gfx/entity_sprites/streamed/image_rezopolis_ufo_01b_4700.bin"
    ; $4a00  48x4 tiles - ENTITY_REZOPOLIS_GREEN_MONSTER
    INCBIN ".gfx/entity_sprites/streamed/image_rezopolis_green_monster_01b_4a00.bin"
    ; $5600  16x4 tiles - ENTITY_REZOPOLIS_PINCER
    INCBIN ".gfx/entity_sprites/streamed/image_rezopolis_pincer_01b_5600.bin"
    ; $5a00  32x4 tiles - ENTITY_PRE_HISTORY_FAST_DINOSAUR
    INCBIN ".gfx/entity_sprites/streamed/image_pre_history_fast_dinosaur_01b_5a00.bin"
    ; $6200  20x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01b_6200.bin"
    ; $6700  24x4 tiles - ENTITY_SCREAM_TV_ZOMBIE
    INCBIN ".gfx/entity_sprites/streamed/image_scream_tv_zombie_01b_6700.bin"
    ; $6d00  60x4 tiles - ENTITY_CHANNEL_Z_REZ_PORTAL
    INCBIN ".gfx/entity_sprites/streamed/image_channel_z_rez_portal_01b_6d00.bin"
    ; $7c00  16x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01b_7c00.bin"

SECTION "bank1c", ROMX[$4000], BANK[$1c]
    ; $4000  96x4 tiles - ENTITY_CHANNEL_Z_REZ
    INCBIN ".gfx/entity_sprites/streamed/image_channel_z_rez_01c_4000.bin"
    ; $5800  120x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01c_5800.bin"
    ; $7600  28x4 tiles - ENTITY_CHANNEL_Z_REZ
    INCBIN ".gfx/entity_sprites/streamed/image_channel_z_rez_01c_7600.bin"
    ; $7d00  12x4 tiles - no entity streams these pages
    INCBIN ".gfx/entity_sprites/streamed/image_unused_01c_7d00.bin"

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
