; MBC1
DEF MBC1SRamEnable      EQU $0001
DEF MBC1RomBank         EQU $2001
DEF MBC1SRamBank        EQU $4001
DEF MBC1SRamBankingMode EQU $6001

; ROM Banks
DEF BANK_00      EQU $00
DEF BANK_01      EQU $01
DEF BANK_02      EQU $02
DEF BANK_03      EQU $03
DEF BANK_04      EQU $04
DEF BANK_05      EQU $05
DEF BANK_06      EQU $06
DEF BANK_07      EQU $07
DEF BANK_08      EQU $08
DEF BANK_09      EQU $09
DEF BANK_0A      EQU $0A
DEF BANK_0B      EQU $0B
DEF BANK_0C      EQU $0C
DEF BANK_0D      EQU $0D
DEF BANK_0E      EQU $0E
DEF BANK_0F      EQU $0F
DEF BANK_10      EQU $10
DEF BANK_11      EQU $11
DEF BANK_12      EQU $12
DEF BANK_13      EQU $13
DEF BANK_14      EQU $14
DEF BANK_15      EQU $15
DEF BANK_16      EQU $16
DEF BANK_17      EQU $17
DEF BANK_18      EQU $18
DEF BANK_19      EQU $19
DEF BANK_1A      EQU $1A
DEF BANK_1B      EQU $1B
DEF BANK_1C      EQU $1C
DEF BANK_1D      EQU $1D
DEF BANK_1E      EQU $1E
DEF BANK_1F      EQU $1F
DEF BANK_20      EQU $20
DEF BANK_21      EQU $21
DEF BANK_22      EQU $22
DEF BANK_23      EQU $23
DEF BANK_24      EQU $24
DEF BANK_25      EQU $25
DEF BANK_26      EQU $26
DEF BANK_27      EQU $27
DEF BANK_28      EQU $28
DEF BANK_29      EQU $29
DEF BANK_2A      EQU $2A
DEF BANK_2B      EQU $2B
DEF BANK_2C      EQU $2C
DEF BANK_2D      EQU $2D
DEF BANK_2E      EQU $2E
DEF BANK_2F      EQU $2F
DEF BANK_30      EQU $30
DEF BANK_31      EQU $31
DEF BANK_32      EQU $32
DEF BANK_33      EQU $33
DEF BANK_34      EQU $34
DEF BANK_35      EQU $35
DEF BANK_36      EQU $36
DEF BANK_37      EQU $37
DEF BANK_38      EQU $38
DEF BANK_39      EQU $39
DEF BANK_3A      EQU $3A
DEF BANK_3B      EQU $3B
DEF BANK_3C      EQU $3C
DEF BANK_3D      EQU $3D
DEF BANK_3E      EQU $3E
DEF BANK_3F      EQU $3F

; Inputs
;DEF Input_A        EQU $01
;DEF Input_B        EQU $02
;DEF Input_Select   EQU $04
;DEF Input_Start    EQU $08
;DEF Input_Right    EQU $10
;DEF Input_Left     EQU $20
;DEF Input_Up       EQU $40
;DEF Input_Down     EQU $80

; Menu Types
DEF MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION   EQU $00
DEF MENU_TYPE_EXIT_GAME                   EQU $01
DEF MENU_TYPE_PAUSED_IN_LEVEL             EQU $02
DEF MENU_TYPE_EXIT_TO_MAP                 EQU $03
DEF MENU_TYPE_GAME_OVER_TOTALS            EQU $04
DEF MENU_TYPE_VIEW_TOTALS                 EQU $05
DEF MENU_TYPE_VIEW_PASSWORD               EQU $06
DEF MENU_TYPE_TITLE_OPTIONS               EQU $07
DEF MENU_TYPE_ENTERING_LEVEL_NAME         EQU $08
DEF MENU_TYPE_MISSION_SELECT_1_OPTION     EQU $09
DEF MENU_TYPE_MISSION_SELECT_2_OPTIONS    EQU $0A
DEF MENU_TYPE_MISSION_SELECT_3_OPTIONS    EQU $0B
DEF MENU_TYPE_GAME_OVER                   EQU $0C
DEF MENU_TYPE_BLACK_SCREEN                EQU $0D
DEF MENU_TYPE_CONGRATULATIONS             EQU $0E
DEF MENU_TYPE_ENTER_PASSWORD              EQU $0F
DEF MENU_TYPE_TITLE_SCREEN                EQU $10
DEF MENU_TYPE_AUDIO_OPTIONS_UNUSED        EQU $11
DEF MENU_TYPE_CREDITS_GREAT_JOB           EQU $12
DEF MENU_TYPE_TITLE_CRAVE                 EQU $13
DEF MENU_TYPE_TITLE_SPLASH                EQU $14
DEF MENU_TYPE_ENTERED_INVALID_PASSWORD    EQU $15
DEF MENU_TYPE_TITLE_DAVID                 EQU $16
DEF MENU_TYPE_CREDITS_1                   EQU $17
DEF MENU_TYPE_CREDITS_2                   EQU $18
DEF MENU_TYPE_CREDITS_3                   EQU $19
DEF MENU_TYPE_CREDITS_4                   EQU $1A
DEF MENU_TYPE_TIME_UP                     EQU $1B

; Music
DEF MUSIC_KUNG_FU_THEATER                 EQU $00
DEF MUSIC_CIRCUIT_CENTRAL                 EQU $01
DEF MUSIC_PREHISTORY_CHANNEL              EQU $02
DEF MUSIC_REZOPOLIS                       EQU $03
DEF MUSIC_UNK_04                          EQU $04
DEF MUSIC_SCREAM_TV                       EQU $05
DEF MUSIC_TOON_TV                         EQU $06
DEF MUSIC_MEDIA_DIMENSION                 EQU $07

; Maps
DEF MAP_MEDIA_DIMENSION                           EQU $00
DEF MAP_TOON_TV_OUT_OF_TOON                       EQU $01
DEF MAP_SCREAM_TV_SMELLRAISER                     EQU $02
DEF MAP_SCREAM_TV_FRANKENSTEINFELD                EQU $03
DEF MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM              EQU $04
DEF MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE            EQU $05
DEF MAP_UNUSED_04                                 EQU $06
DEF MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210         EQU $07
DEF MAP_TOON_TV_FINE_TOONING                      EQU $08
DEF MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE         EQU $09
DEF MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO  EQU $0A
DEF MAP_SCREAM_TV_POLTERGEX                       EQU $0B
DEF MAP_UNUSED_0C                                 EQU $0C
DEF MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER       EQU $0D
DEF MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL       EQU $0E
DEF MAP_UNUSED_0F                                 EQU $0F
DEF MAP_SCREAM_TV_THURSDAY_THE_12TH               EQU $10
DEF MAP_UNUSED_11                                 EQU $11
DEF MAP_UNUSED_12                                 EQU $12
DEF MAP_UNUSED_13                                 EQU $13
DEF MAP_UNUSED_14                                 EQU $14
DEF MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP    EQU $15
DEF MAP_REZOPOLIS_BUGGED_OUT                      EQU $16
DEF MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS            EQU $17
DEF MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO        EQU $18
DEF MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE         EQU $19
DEF MAP_REZOPOLIS_MAZED_AND_CONFUSED              EQU $1A
DEF MAP_UNUSED_1B                                 EQU $1B
DEF MAP_UNUSED_1C                                 EQU $1C
DEF MAP_UNUSED_1D                                 EQU $1D
DEF MAP_BOSS_TV_CHANNEL_Z                         EQU $1E

; ENTITYs
DEF ENTITY_GEX                              EQU $00
DEF ENTITY_COLLECTIBLE_SPAWN                EQU $01
DEF ENTITY_UNK_02                           EQU $02 ; not in level ENTITY lists. may be unused
DEF ENTITY_TV_BUTTON                        EQU $03
DEF ENTITY_RED_REMOTE                       EQU $04
DEF ENTITY_SILVER_REMOTE                    EQU $05 ; hidden remote
DEF ENTITY_GOLD_REMOTE                      EQU $06
DEF ENTITY_ENEMY_DEFEATED                   EQU $07
DEF ENTITY_UNK_08                           EQU $08 ; not in level ENTITY lists. may be unused
DEF ENTITY_SCREAM_TV_FALLING_PLATFORM       EQU $09
DEF ENTITY_SCREAM_TV_MOVING_PLATFORM        EQU $0A
DEF ENTITY_SCREAM_TV_PUSH_BLOCK             EQU $0B ; in poltergex, push the block to cause platform to appear
DEF ENTITY_SCREAM_TV_PUMPKIN                EQU $0C
DEF ENTITY_SCREAM_TV_FRANKIE                EQU $0D
DEF ENTITY_SCREAM_TV_HEAD_GHOST             EQU $0E
DEF ENTITY_SCREAM_TV_HEAD_GHOST_HEAD        EQU $0F
DEF ENTITY_SCREAM_TV_FLOATING_SKULL         EQU $10
DEF ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE EQU $11
DEF ENTITY_SCREAM_TV_ZOMBIE                 EQU $12
DEF ENTITY_SCREAM_TV_ZOMBIE_HEAD            EQU $13
DEF ENTITY_SCREAM_TV_FALLING_AXE            EQU $14
DEF ENTITY_SCREAM_TV_LANTERN                EQU $15
DEF ENTITY_SCREAM_TV_BAT                    EQU $16
DEF ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM EQU $17
DEF ENTITY_SCREAM_TV_DOOR_OPENING           EQU $18
DEF ENTITY_SCREAM_TV_GHOST                  EQU $19
DEF ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY   EQU $1A
DEF ENTITY_SCREAM_TV_VANISHING_PLATFORM     EQU $1B
DEF ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR     EQU $1C
DEF ENTITY_TOON_TV_HARD_HEAD_AREA_ENTITY    EQU $1D
DEF ENTITY_TOON_TV_STATIONARY_BEAR_TRAP     EQU $1E
DEF ENTITY_TOON_TV_MOVING_BEAR_TRAP         EQU $1F
DEF ENTITY_TOON_TV_BUMBLEBEE                EQU $20
DEF ENTITY_TOON_TV_FALLING_BOWLING_BALL     EQU $21
DEF ENTITY_TOON_TV_CACTUS                    EQU $22
DEF ENTITY_TOON_TV_DOMINO                    EQU $23
DEF ENTITY_TOON_TV_SHARK                     EQU $24
DEF ENTITY_TOON_TV_FLOWER                    EQU $25
DEF ENTITY_TOON_TV_HUNTER                    EQU $26
DEF ENTITY_TOON_TV_MUSHROOM                  EQU $27
DEF ENTITY_UNK_28                            EQU $28 ; not in level ENTITY lists. may be unused
DEF ENTITY_TOON_TV_LIZARD                    EQU $29
DEF ENTITY_TOON_TV_HAPPY_FACE                EQU $2A
DEF ENTITY_TOON_TV_VANISHING_BLOCK           EQU $2B
DEF ENTITY_TOON_TV_MOVING_BLOCK              EQU $2C
DEF ENTITY_TOON_TV_MOVING_LOG_PLATFORM       EQU $2D
DEF ENTITY_TOON_TV_STATIONARY_LOG_PLATFORM   EQU $2E
DEF ENTITY_TOON_TV_FLOWER_HAMMER_ATTACK      EQU $2F
DEF ENTITY_TOON_TV_HUNTER_BULLET             EQU $30
DEF ENTITY_TOON_TV_ROCKET                    EQU $31
DEF ENTITY_PRE_HISTORY_FAST_DINOSAUR         EQU $32 ; in pangaea 90210 above the happy face on map
DEF ENTITY_PRE_HISTORY_DRAGONFLY             EQU $33
DEF ENTITY_PRE_HISTORY_EGG                   EQU $34
DEF ENTITY_UNK_35                            EQU $35 ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_36                            EQU $36 ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_FALLING_LAVA          EQU $37
DEF ENTITY_PRE_HISTORY_LAVA_RAFT             EQU $38
DEF ENTITY_PRE_HISTORY_MOVING_PLATFORM       EQU $39
DEF ENTITY_UNK_3A                            EQU $3A ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_3B                            EQU $3B ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_PTEROSAUR             EQU $3C
DEF ENTITY_UNK_3D                            EQU $3D ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_FALLING_BOULDER       EQU $3E
DEF ENTITY_UNK_3F                            EQU $3F ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL     EQU $40 ; lava dabba doo on the climbable background
DEF ENTITY_PRE_HISTORY_BEETLE_VERTICAL       EQU $41
DEF ENTITY_PRE_HISTORY_ANT                   EQU $42 ; lava dabba doo at the beginning
DEF ENTITY_PRE_HISTORY_FIRE_PLANT            EQU $43
DEF ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES EQU $44
DEF ENTITY_PRE_HISTORY_GEYSER                EQU $45
DEF ENTITY_UNK_46                            EQU $46 ; not in level ENTITY lists. may be unused
DEF ENTITY_PRE_HISTORY_DINOSAUR              EQU $47
DEF ENTITY_PRE_HISTORY_TRICERATOPS           EQU $48
DEF ENTITY_PRE_HISTORY_TRICERATOPS_HORN      EQU $49
DEF ENTITY_UNK_4A                            EQU $4A ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_HANGING_BLADE     EQU $4B
DEF ENTITY_KUNG_FU_THEATER_CANNON            EQU $4C
DEF ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE EQU $4D
DEF ENTITY_KUNG_FU_THEATER_DRAGONFLY         EQU $4E
DEF ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT EQU $4F
DEF ENTITY_KUNG_FU_THEATER_DRAGON_HEAD       EQU $50
DEF ENTITY_UNK_51                            EQU $51 ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE EQU $52
DEF ENTITY_KUNG_FU_THEATER_WALKING_NINJA     EQU $53
DEF ENTITY_KUNG_FU_THEATER_JUMPING_NINJA     EQU $54
DEF ENTITY_KUNG_FU_THEATER_SAMURAI_BODY      EQU $55
DEF ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD      EQU $56
DEF ENTITY_KUNG_FU_THEATER_LIZARD            EQU $57
DEF ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE  EQU $58 ; jumping ninja throws projectiles, but not walking ninja
DEF ENTITY_KUNG_FU_THEATER_SPIKY_LOG         EQU $59
DEF ENTITY_KUNG_FU_THEATER_TALL_JAR          EQU $5A
DEF ENTITY_KUNG_FU_THEATER_JAR               EQU $5B
DEF ENTITY_UNK_5C                            EQU $5C ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_5D                            EQU $5D ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM EQU $5E
DEF ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM   EQU $5F
DEF ENTITY_UNK_60                            EQU $60 ; not in level ENTITY lists. may be unused
DEF ENTITY_KUNG_FU_THEATER_MOVING_RAFT       EQU $61
DEF ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT   EQU $62
DEF ENTITY_UNK_63                            EQU $63 ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_64                            EQU $64 ; not in level ENTITY lists. may be unused
DEF ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM EQU $65 ; at the start of no weddings
DEF ENTITY_REZOPOLIS_MOVING_PLATFORM         EQU $66 ; small, yellow, and black
DEF ENTITY_REZOPOLIS_RED_PLATFORM            EQU $67 ; no weddings
DEF ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  EQU $68 ; no weddings
DEF ENTITY_REZOPOLIS_TAILSPIN_PLATFORM       EQU $69
DEF ENTITY_REZOPOLIS_TAILSPIN_GEAR           EQU $6A
DEF ENTITY_UNK_6B                            EQU $6B ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_6C                            EQU $6C ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_6D                            EQU $6D ; not in level ENTITY lists. may be unused
DEF ENTITY_REZOPOLIS_GREEN_MONSTER           EQU $6E
DEF ENTITY_UNK_6F                            EQU $6F ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_70                            EQU $70 ; not in level ENTITY lists. may be unused
DEF ENTITY_REZOPOLIS_PINCER                  EQU $71
DEF ENTITY_REZOPOLIS_FLAMETHROWER            EQU $72
DEF ENTITY_REZOPOLIS_UFO                     EQU $73
DEF ENTITY_REZOPOLIS_ANT                     EQU $74 ; bugged out, spawned by hitting the gear
DEF ENTITY_REZOPOLIS_ANT_SPAWNER             EQU $75 ; bugged out
DEF ENTITY_CIRCUIT_CENTRAL_ANT               EQU $76
DEF ENTITY_CIRCUIT_CENTRAL_CAPACITOR         EQU $77
DEF ENTITY_CIRCUIT_CENTRAL_POWER_UP          EQU $78
DEF ENTITY_UNK_79                            EQU $79 ; not in level ENTITY lists. may be unused
DEF ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT      EQU $7A
DEF ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR EQU $7B
DEF ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL     EQU $7C
DEF ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM   EQU $7D
DEF ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM   EQU $7E
DEF ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM EQU $7F
DEF ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT      EQU $80
DEF ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY   EQU $81
DEF ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR EQU $82
DEF ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE    EQU $83
DEF ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2   EQU $84
DEF ENTITY_CHANNEL_Z_GUN_PROJECTILE          EQU $85
DEF ENTITY_CHANNEL_Z_REZ                     EQU $86
DEF ENTITY_UNK_87                            EQU $87 ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_88                            EQU $88 ; not in level ENTITY lists. may be unused
DEF ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE      EQU $89
DEF ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION EQU $8A
DEF ENTITY_UNK_8B                            EQU $8B ; not in level ENTITY lists. may be unused
DEF ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON     EQU $8C
DEF ENTITY_UNK_8D                            EQU $8D ; not in level ENTITY lists. may be unused
DEF ENTITY_UNK_8E                            EQU $8E ; not in level ENTITY lists. may be unused
DEF ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM   EQU $8F
DEF ENTITY_LIST_TERMINATOR                   EQU $FF

; Entity Instance Struct - these are copied from gex3 and are not all verified
DEF ENTITY_FIELD_ENTITY_ID                  EQU $00
DEF ENTITY_FIELD_ACTION_ID                  EQU $01
DEF ENTITY_FIELD_ACTION_FUNC                EQU $02
DEF ENTITY_FIELD_SPRITE_FLAGS2              EQU $04
DEF ENTITY_FIELD_GRAPHICS_FLAGS             EQU $05
DEF ENTITY_FIELD_SPRITE_FRAME_COUNTER_MAX   EQU $06 ; how many frames to use this sprite
DEF ENTITY_FIELD_SPRITE_FRAME_COUNTER       EQU $07 ; counter for the above
DEF ENTITY_FIELD_SPRITE_COUNTER_MAX         EQU $08 ; total sprite frames for current action
DEF ENTITY_FIELD_SPRITE_COUNTER             EQU $09 ; counter for above
DEF ENTITY_FIELD_SPRITE_ID                  EQU $0A ; current sprite id
DEF ENTITY_FIELD_SPRITE_IDS_PTR             EQU $0B ; ptr to sprite data (in entity_animation_data.asm)
DEF ENTITY_FIELD_FACING_DIRECTION           EQU $0D
DEF ENTITY_FIELD_XPOS                       EQU $0E
DEF ENTITY_FIELD_YPOS                       EQU $10
DEF ENTITY_FIELD_WIDTH                      EQU $12 ; set to [1] into data_00_3258
DEF ENTITY_FIELD_HEIGHT                     EQU $13 ; set to [2] into data_00_3258
DEF ENTITY_FIELD_COLLISION_TYPE             EQU $14 ; set to [3] into data_00_3258
DEF ENTITY_FIELD_COOLDOWN_TIMER             EQU $15 ; defaults to 0, but might get set to $3c (same value as gex's cooldown timer)
DEF ENTITY_FIELD_DAMAGE_STATE               EQU $16 ; stores current health or other damage states
DEF ENTITY_FIELD_SPRITE_BANK                EQU $17
DEF ENTITY_FIELD_UNK18                      EQU $18 ; seems unused
DEF ENTITY_FIELD_MISC_FLAGS                 EQU $19 ; only used by moving platforms, skating elf health, and sec bot?
                                                    ; initially set to data_00_3258[entity_id*8][5]
DEF ENTITY_FIELD_MISC_TIMER                 EQU $1A ; timer which can be used for various purposes
DEF ENTITY_FIELD_XVEL                       EQU $1B
DEF ENTITY_FIELD_XVEL_RELATED               EQU $1C ; used with XVEL to calculate X delta
DEF ENTITY_FIELD_YVEL                       EQU $1D
DEF ENTITY_FIELD_UNK1E                      EQU $1E ; seems unused, likely would have been used for Y velocity delta
DEF ENTITY_FIELD_PARENT                     EQU $1F ; stores entity list index of this entity's parent (used for projectiles, flies)

; Player vs Entity interactions
DEF PLAYER_TOUCHED_ENTITY    EQU $00
DEF PLAYER_ATTACKED_ENTITY   EQU $01
DEF PLAYER_STOMPED_ENTITY    EQU $02

DEF PLAYER_CAN_TOUCH_ENTITY  EQU $01
DEF PLAYER_CAN_ATTACK_ENTITY EQU $02
DEF PLAYER_CAN_STOMP_ENTITY  EQU $04

; Player Action Ids
DEF PLAYER_ACTION_SPAWN_IN_LEVEL             EQU $00
DEF PLAYER_ACTION_UNK_01                     EQU $01
DEF PLAYER_ACTION_STAND                      EQU $02
DEF PLAYER_ACTION_IDLE_TONGUE_FLICK          EQU $03
DEF PLAYER_ACTION_WALK                       EQU $04
DEF PLAYER_ACTION_RUN                        EQU $05
DEF PLAYER_ACTION_UNK_06                     EQU $06
DEF PLAYER_ACTION_UNK_07                     EQU $07
DEF PLAYER_ACTION_CROUCH                     EQU $08
DEF PLAYER_ACTION_JUMP                       EQU $09
DEF PLAYER_ACTION_DOUBLE_JUMP                EQU $0A
DEF PLAYER_ACTION_UNK_0B                     EQU $0B
DEF PLAYER_ACTION_KARATE_KICK                EQU $0C
DEF PLAYER_ACTION_TAILSPIN                   EQU $0D
DEF PLAYER_ACTION_MANUAL_TONGUE_FLICK        EQU $0E
DEF PLAYER_ACTION_DAMAGED                    EQU $0F
DEF PLAYER_ACTION_DYING                      EQU $10
DEF PLAYER_ACTION_DEAD                       EQU $11
DEF PLAYER_ACTION_ENTER_TV                   EQU $12
DEF PLAYER_ACTION_UNK_13                     EQU $13
DEF PLAYER_ACTION_EXIT_TV                    EQU $14
DEF PLAYER_ACTION_PUSH_BG_WALL               EQU $15
DEF PLAYER_ACTION_PUSH_ENTITY_WALL           EQU $16 ; such as tv button
DEF PLAYER_ACTION_FREEFALL                   EQU $17
DEF PLAYER_ACTION_UNK_18                     EQU $18
DEF PLAYER_ACTION_COLLAPSE                   EQU $19 ; crushed / large fall
DEF PLAYER_ACTION_ENTER_DOOR                 EQU $1A
DEF PLAYER_ACTION_UNK_1B                     EQU $1B
DEF PLAYER_ACTION_UNK_1C                     EQU $1C
DEF PLAYER_ACTION_CLIMB                      EQU $1D ; climbing wall or background
DEF PLAYER_ACTION_UNK_1E                     EQU $1E
DEF PLAYER_ACTION_UNK_1F                     EQU $1F ; disables collision updating?

; Entity Collision Types
DEF COLLISION_TYPE_NONE                       EQU $00
DEF COLLISION_TYPE_COLLECTIBLE                EQU $01
DEF COLLISION_TYPE_UNK_02                     EQU $02
DEF COLLISION_TYPE_UNK_03                     EQU $03
DEF COLLISION_TYPE_UNK_04                     EQU $04
DEF COLLISION_TYPE_UNK_05                     EQU $05
DEF COLLISION_TYPE_GENERIC_ENEMY              EQU $06
DEF COLLISION_TYPE_SILVER_REMOTE              EQU $07
DEF COLLISION_TYPE_GOLD_REMOTE                EQU $08
DEF COLLISION_TYPE_UNK_09                     EQU $09
DEF COLLISION_TYPE_LANTERN                    EQU $0A
DEF COLLISION_TYPE_ZOMBIE                     EQU $0B
DEF COLLISION_TYPE_GHOST_HEAD                 EQU $0C
DEF COLLISION_TYPE_GHOST                      EQU $0D
DEF COLLISION_TYPE_ZOMBIE_HEAD                EQU $0E
DEF COLLISION_TYPE_FALLING_OBJECT             EQU $0F
DEF COLLISION_TYPE_HUNTER                     EQU $10
DEF COLLISION_TYPE_MUSHROOM                   EQU $11
DEF COLLISION_TYPE_PROJECTILE                 EQU $13
DEF COLLISION_TYPE_JAR                        EQU $14
DEF COLLISION_TYPE_NINJA                      EQU $15
DEF COLLISION_TYPE_HANGING_BLADE              EQU $16
DEF COLLISION_TYPE_SAMURAI_BODY               EQU $18
DEF COLLISION_TYPE_GEYSER                     EQU $1A
DEF COLLISION_TYPE_TRICERATOPS                EQU $1B
DEF COLLISION_TYPE_GEAR                       EQU $1C
DEF COLLISION_TYPE_ELECTRIC_BALL              EQU $1D
DEF COLLISION_TYPE_ROCKET                     EQU $1F
DEF COLLISION_TYPE_CANNON                     EQU $20
DEF COLLISION_TYPE_POWERED_WALKWAY            EQU $21
DEF COLLISION_TYPE_POWER_UP                   EQU $22
DEF COLLISION_TYPE_DRAGON_PROJECTILE          EQU $23
DEF COLLISION_TYPE_REZ                        EQU $24
DEF COLLISION_TYPE_UNK_PLATFORM_FLAG          EQU $80

; Text
DEF TextTerminator        EQU $80
