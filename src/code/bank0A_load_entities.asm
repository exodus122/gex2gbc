;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; This file handles loading entities (other than Gex).
; It contains a list of entities to load on each level.

call_0a_4000_EntityList_LoadForCurrentLevel:
; Indexes into a level→entity-list pointer table using wD624_CurrentLevelId, 
; writes the resulting pointer into wD336/wD337 (the "current entity to load" cursor), 
; and sets wD338=1 to signal that loading should begin
    ld   HL, wD624_CurrentLevelId                                     ;; 0a:4000 $21 $24 $d6
    ld   L, [HL]                                       ;; 0a:4003 $6e ; L = current level
    ld   H, $00                                        ;; 0a:4004 $26 $00
    add  HL, HL                                        ;; 0a:4006 $29 ; multiply by 2?
    ld   DE, .data_0a_4019                             ;; 0a:4007 $11 $19 $40
    add  HL, DE                                        ;; 0a:400a $19
    ld   A, [HL+]                                      ;; 0a:400b $2a
    ld   [wD336_CurrentEntityToLoadPtr], A                                    ;; 0a:400c $ea $36 $d3
    ld   A, [HL+]                                      ;; 0a:400f $2a
    ld   [wD337_CurrentEntityToLoadPtr], A                                    ;; 0a:4010 $ea $37 $d3
    ld   A, $01                                        ;; 0a:4013 $3e $01
    ld   [wD338], A                                    ;; 0a:4015 $ea $38 $d3
    ret                                                ;; 0a:4018 $c9
.data_0a_4019:
    dw   .data_MediaDimension_entity_list
    dw   .data_OutOfToon_entity_list
    dw   .data_Smellraiser_entity_list
    dw   .data_Frankensteinfeld_entity_list
    dw   .data_wwwdotcomcom_entity_list
    dw   .data_MaoTseTongue_entity_list
    dw   .data_Pangaea90210_entity_list
    dw   .data_Pangaea90210_entity_list
    dw   .data_FineTooning_entity_list
    dw   .data_ThisOldCave_entity_list
    dw   .data_HoneyIShrunkTheGecko_entity_list
    dw   .data_Poltergex_entity_list
    dw   .data_SamuraiNightFever_entity_list
    dw   .data_SamuraiNightFever_entity_list
    dw   .data_NoWeddingsAndAFuneral_entity_list
    dw   .data_ThursdayThe12th_entity_list
    dw   .data_ThursdayThe12th_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_LizardInAChinaShop_entity_list
    dw   .data_BuggedOut_entity_list
    dw   .data_ChipsAndDips_entity_list
    dw   .data_LavaDabbaDoo_entity_list
    dw   .data_TexasChainsawManicure_entity_list
    dw   .data_MazedAndConfused_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_MediaDimension_entity_list
    dw   .data_ChannelZ_entity_list
.data_MediaDimension_entity_list:                             ;; 0a:4057
    INCLUDE "data/maps/media_dimension/entity_list_media_dimension.asm"
.data_OutOfToon_entity_list:                             ;; 0a:4488
    INCLUDE "data/maps/toon_tv/entity_list_out_of_toon.asm"
.data_Smellraiser_entity_list:                             ;; 0a:48c9
    INCLUDE "data/maps/scream_tv/entity_list_smellraiser.asm"
.data_Frankensteinfeld_entity_list:                             ;; 0a:4aba
    INCLUDE "data/maps/scream_tv/entity_list_frankensteinfeld.asm"
.data_wwwdotcomcom_entity_list:                             ;; 0a:4ddb
    INCLUDE "data/maps/circuit_central/entity_list_wwwdotcomcom.asm"
.data_MaoTseTongue_entity_list:                             ;; 0a:51ec
    INCLUDE "data/maps/kung_fu_theater/entity_list_mao_tse_tongue.asm"
.data_Pangaea90210_entity_list:                             ;; 0a:54ed
    INCLUDE "data/maps/prehistory_channel/entity_list_pangaea_90210.asm"
.data_FineTooning_entity_list:                             ;; 0a:57ee
    INCLUDE "data/maps/toon_tv/entity_list_fine_tooning.asm"
.data_ThisOldCave_entity_list:                             ;; 0a:5c8f
    INCLUDE "data/maps/prehistory_channel/entity_list_this_old_cave.asm"
.data_HoneyIShrunkTheGecko_entity_list:                             ;; 0a:5e20
    INCLUDE "data/maps/circuit_central/entity_list_honey_i_shrunk_the_gecko.asm"
.data_Poltergex_entity_list:                             ;; 0a:6331
    INCLUDE "data/maps/scream_tv/entity_list_poltergex.asm"
.data_SamuraiNightFever_entity_list:                             ;; 0a:6692
    INCLUDE "data/maps/kung_fu_theater/entity_list_samurai_night_fever.asm"
.data_NoWeddingsAndAFuneral_entity_list:                             ;; 0a:6a43
    INCLUDE "data/maps/rezopolis/entity_list_no_weddings_and_a_funeral.asm"
.data_ThursdayThe12th_entity_list:                             ;; 0a:6c84
    INCLUDE "data/maps/scream_tv/entity_list_thursday_the_12th.asm"
.data_LizardInAChinaShop_entity_list:                             ;; 0a:6d45
    INCLUDE "data/maps/kung_fu_theater/entity_list_lizard_in_a_china_shop.asm"
.data_BuggedOut_entity_list:                             ;; 0a:6dc6
    INCLUDE "data/maps/rezopolis/entity_list_bugged_out.asm"
.data_ChipsAndDips_entity_list:                             ;; 0a:6df7
    INCLUDE "data/maps/circuit_central/entity_list_chips_and_dips.asm"
.data_LavaDabbaDoo_entity_list:                             ;; 0a:6e78
    INCLUDE "data/maps/prehistory_channel/entity_list_lava_dabba_doo.asm"
.data_TexasChainsawManicure_entity_list:                             ;; 0a:7149
    INCLUDE "data/maps/scream_tv/entity_list_texas_chainsaw_manicure.asm"
.data_MazedAndConfused_entity_list:                             ;; 0a:734a
    INCLUDE "data/maps/rezopolis/entity_list_mazed_and_confused.asm"
.data_ChannelZ_entity_list:                             ;; 0a:751b
    INCLUDE "data/maps/channel_z/entity_list_channel_z.asm"

data_0a_75fc:
    db   $00                                           ;; 0a:75fc ?
data_0a_75fd_EntityAttributeTable:
; 8-byte records for every entity type (indexed by entity ID × 8). 
; Fields are: flags byte, width, height, collision type, animation type index, action count/max, and two zero bytes. 
; Used during spawn to initialize the new entity slot's physical properties
    db   $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00      ; 0a:75fd ???????  ; ENTITY_GEX
    db   $00, $2c, $10, COLLISION_TYPE_COLLECTIBLE, $00, $01, $00, $00 ; 0a:7604 ???????? ; ENTITY_COLLECTIBLE_SPAWN
    db   $00, $08, $08, COLLISION_TYPE_UNK_02, $00, $02, $00, $00 ; 0a:760c ???????. ; ENTITY_UNK_02
    db   $70, $08, $08, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $00, $06, $00, $00 ; 0a:7614 ....w??. ; ENTITY_TV_BUTTON
    db   $70, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00 ; 0a:761c ....w??? ; ENTITY_RED_REMOTE
    db   $00, $10, $10, COLLISION_TYPE_SILVER_REMOTE, $00, $07, $00, $00 ; 0a:7624 ???????? ; ENTITY_SILVER_REMOTE
    db   $00, $10, $10, COLLISION_TYPE_GOLD_REMOTE, $00, $07, $00, $00 ; 0a:762c ???????? ; ENTITY_GOLD_REMOTE
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00 ; 0a:7634 ???????? ; ENTITY_ENEMY_DEFEATED
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00 ; 0a:763c ???????? ; ENTITY_UNK_08
    db   $40, $10, $10, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $01, $05, $00, $00 ; 0a:7644 ???????. ; ENTITY_SCREAM_TV_FALLING_PLATFORM
    db   $70, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $01, $04, $00, $00 ; 0a:764c ...ww??? ; ENTITY_SCREAM_TV_MOVING_PLATFORM
    db   $00, $10, $10, COLLISION_TYPE_STATIONARY_PLATFORM, $24, $05, $00, $00 ; 0a:7654 ???????. ; ENTITY_SCREAM_TV_PUSH_BLOCK
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:765c ....w??? ; ENTITY_SCREAM_TV_PUMPKIN
    db   $28, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:7664 ???????? ; ENTITY_SCREAM_TV_FRANKIE
    db   $40, $08, $10, COLLISION_TYPE_GENERIC_ENEMY, $33, $07, $00, $00 ; 0a:766c ???????? ; ENTITY_SCREAM_TV_HEAD_GHOST
    db   $00, $10, $10, COLLISION_TYPE_GHOST_HEAD, $00, $06, $00, $00 ; 0a:7674 ???????? ; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:767c ???????? ; ENTITY_SCREAM_TV_FLOATING_SKULL
    db   $00, $04, $04, COLLISION_TYPE_PROJECTILE, $00, $06, $00, $00 ; 0a:7684 ???????? ; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    db   $00, $0c, $10, COLLISION_TYPE_ZOMBIE, $00, $07, $00, $00 ; 0a:768c ???????? ; ENTITY_SCREAM_TV_ZOMBIE
    db   $00, $10, $10, COLLISION_TYPE_ZOMBIE_HEAD, $00, $06, $00, $00 ; 0a:7694 ???????? ; ENTITY_SCREAM_TV_ZOMBIE_HEAD
    db   $40, $08, $08, COLLISION_TYPE_UNK_09, $01, $03, $00, $00 ; 0a:769c ???????? ; ENTITY_SCREAM_TV_FALLING_AXE
    db   $00, $20, $40, COLLISION_TYPE_LANTERN, $02, $05, $00, $00 ; 0a:76a4 ???????? ; ENTITY_SCREAM_TV_LANTERN
    db   $00, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:76ac ???????? ; ENTITY_SCREAM_TV_BAT
    db   $50, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $24, $05, $00, $00 ; 0a:76b4 ???????? ; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00 ; 0a:76bc ???????? ; ENTITY_SCREAM_TV_DOOR_OPENING
    db   $10, $0c, $10, COLLISION_TYPE_GHOST, $00, $07, $00, $00 ; 0a:76c4 ???????? ; ENTITY_SCREAM_TV_GHOST
    db   $50, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $01, $05, $00, $00 ; 0a:76cc ???????? ; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    db   $00, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $01, $04, $00, $00 ; 0a:76d4 ???????? ; ENTITY_SCREAM_TV_VANISHING_PLATFORM
    db   $50, $12, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $01, $04, $00, $00 ; 0a:76dc ???????. ; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    db   $00, $10, $10, COLLISION_TYPE_FALLING_OBJECT, $03, $07, $00, $00 ; 0a:76e4 .w.ww??? ; ENTITY_TOON_TV_HARD_HEAD_AREA_OBJECT
    db   $00, $10, $08, COLLISION_TYPE_UNK_09, $05, $07, $00, $00 ; 0a:76ec ???????? ; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    db   $00, $08, $08, COLLISION_TYPE_UNK_09, $04, $07, $00, $00 ; 0a:76f4 ???????. ; ENTITY_TOON_TV_MOVING_BEAR_TRAP
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $0f, $07, $00, $00 ; 0a:76fc ...ww??? ; ENTITY_TOON_TV_BUMBLEBEE
    db   $88, $0c, $10, COLLISION_TYPE_FALLING_OBJECT, $07, $07, $00, $00 ; 0a:7704 ???????. ; ENTITY_TOON_TV_BOWLING_BALL
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $06, $07, $00, $00 ; 0a:770c ...ww??? ; ENTITY_TOON_TV_CACTUS
    db   $00, $10, $10, COLLISION_TYPE_FALLING_OBJECT, $0e, $05, $00, $00 ; 0a:7714 ???????. ; ENTITY_TOON_TV_DOMINO
    db   $00, $0c, $0a, COLLISION_TYPE_GENERIC_ENEMY, $0d, $05, $00, $00 ; 0a:771c ...ww??. ; ENTITY_TOON_TV_SHARK
    db   $00, $10, $10, COLLISION_TYPE_NONE, $08, $07, $00, $00 ; 0a:7724 ...ww??? ; ENTITY_TOON_TV_FLOWER
    db   $00, $0a, $10, COLLISION_TYPE_HUNTER, $00, $07, $00, $00 ; 0a:772c ???????. ; ENTITY_TOON_TV_HUNTER
    db   $00, $0c, $08, COLLISION_TYPE_MUSHROOM, $0b, $05, $00, $00 ; 0a:7734 ...ww??? ; ENTITY_TOON_TV_MUSHROOM
    db   $00, $04, $08, COLLISION_TYPE_NONE, $23, $05, $00, $00 ; 0a:773c ...ww??? ; ENTITY_UNK_28
    db   $00, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $09, $07, $00, $00 ; 0a:7744 ???????. ; ENTITY_TOON_TV_LIZARD
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:774c ....w??? ; ENTITY_TOON_TV_HAPPY_FACE
    db   $70, $08, $10, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $10, $05, $00, $00 ; 0a:7754 ???????? ; ENTITY_TOON_TV_VANISHING_BLOCK
    db   $70, $08, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $10, $05, $00, $00 ; 0a:775c ???????. ; ENTITY_TOON_TV_MOVING_BLOCK
    db   $70, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $0a, $04, $00, $00 ; 0a:7764 ...ww??. ; ENTITY_TOON_TV_MOVING_LOG
    db   $00, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $0c, $05, $00, $00 ; 0a:776c ...ww??? ; ENTITY_TOON_TV_STATIONARY_LOG
    db   $00, $0a, $08, COLLISION_TYPE_FALLING_OBJECT, $00, $06, $00, $00 ; 0a:7774 .w..w??? ; ENTITY_TOON_TV_FLOWER_HAMMER
    db   $00, $10, $10, COLLISION_TYPE_UNK_09, $0a, $06, $00, $00 ; 0a:777c ???????? ; ENTITY_TOON_TV_HUNTER_BULLET
    db   $00, $04, $08, COLLISION_TYPE_ROCKET, $34, $05, $00, $00 ; 0a:7784 ???????? ; ENTITY_TOON_TV_ROCKET
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:778c ???????? ; ENTITY_PRE_HISTORY_FAST_DINOSAUR
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:7794 ???????? ; ENTITY_PRE_HISTORY_DRAGONFLY
    db   $00, $08, $08, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:779c ???????? ; ENTITY_PRE_HISTORY_EGG
    db   $00, $08, $20, COLLISION_TYPE_GEYSER, $25, $07, $00, $00 ; 0a:77a4 ???????? ; ENTITY_UNK_35
    db   $00, $10, $10, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $11, $05, $00, $00 ; 0a:77ac ???????? ; ENTITY_UNK_36
    db   $00, $04, $06, COLLISION_TYPE_UNK_09, $12, $05, $00, $00 ; 0a:77b4 ???????? ; ENTITY_PRE_HISTORY_FALLING_LAVA
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $20, $04, $00, $00 ; 0a:77bc ???????? ; ENTITY_PRE_HISTORY_LAVA_RAFT
    db   $70, $0c, $0b, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $20, $04, $00, $00 ; 0a:77c4 ???????? ; ENTITY_PRE_HISTORY_MOVING_PLATFORM
    db   $00, $10, $0c, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $20, $04, $00, $00 ; 0a:77cc ???????? ; ENTITY_UNK_3A
    db   $00, $0c, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $20, $04, $00, $00 ; 0a:77d4 ???????? ; ENTITY_UNK_3B
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:77dc ???????? ; ENTITY_PRE_HISTORY_PTEROSAUR
    db   $00, $0c, $10, COLLISION_TYPE_FALLING_OBJECT, $13, $07, $00, $00 ; 0a:77e4 ???????? ; ENTITY_UNK_3D
    db   $40, $0c, $10, COLLISION_TYPE_FALLING_OBJECT, $13, $07, $00, $00 ; 0a:77ec ???????? ; ENTITY_PRE_HISTORY_FALLING_BOULDER
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00 ; 0a:77f4 ???????? ; ENTITY_UNK_3F
    db   $00, $08, $08, COLLISION_TYPE_GENERIC_ENEMY, $1e, $07, $00, $00 ; 0a:77fc ???????? ; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    db   $00, $08, $08, COLLISION_TYPE_GENERIC_ENEMY, $1e, $07, $00, $00 ; 0a:7804 ???????? ; ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    db   $00, $08, $0c, COLLISION_TYPE_GENERIC_ENEMY, $1e, $07, $00, $00 ; 0a:780c ???????? ; ENTITY_PRE_HISTORY_ANT
    db   $00, $0c, $08, COLLISION_TYPE_GENERIC_ENEMY, $14, $05, $00, $00 ; 0a:7814 ???????? ; ENTITY_PRE_HISTORY_FIRE_PLANT
    db   $00, $04, $04, COLLISION_TYPE_PROJECTILE, $00, $04, $00, $00 ; 0a:781c ???????? ; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    db   $00, $08, $10, COLLISION_TYPE_GEYSER, $21, $07, $00, $00 ; 0a:7824 ???????? ; ENTITY_PRE_HISTORY_GEYSER
    db   $00, $10, $0c, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $20, $04, $00, $00 ; 0a:782c ???????? ; ENTITY_UNK_46
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:7834 ???????? ; ENTITY_PRE_HISTORY_DINOSAUR
    db   $00, $10, $10, COLLISION_TYPE_TRICERATOPS, $22, $07, $00, $00 ; 0a:783c ???????? ; ENTITY_PRE_HISTORY_TRICERATOPS
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00 ; 0a:7844 ???????? ; ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00 ; 0a:784c ???????? ; ENTITY_UNK_4A
    db   $00, $10, $08, COLLISION_TYPE_HANGING_BLADE, $1a, $05, $00, $00 ; 0a:7854 ???????? ; ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    db   $00, $10, $08, COLLISION_TYPE_CANNON, $18, $06, $00, $00 ; 0a:785c ???????? ; ENTITY_KUNG_FU_THEATER_CANNON
    db   $00, $08, $08, COLLISION_TYPE_NONE, $18, $06, $00, $00 ; 0a:7864 ???????? ; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:786c ???????? ; ENTITY_KUNG_FU_THEATER_DRAGONFLY
    db   $70, $08, $08, COLLISION_TYPE_UNK_09, $19, $07, $00, $00 ; 0a:7874 ???????? ; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    db   $00, $0c, $0c, COLLISION_TYPE_UNK_09, $00, $07, $00, $00 ; 0a:787c ???????? ; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    db   $00, $08, $0c, COLLISION_TYPE_UNK_09, $1f, $07, $00, $00 ; 0a:7884 ???????? ; ENTITY_UNK_51
    db   $00, $08, $08, COLLISION_TYPE_DRAGON_PROJECTILE, $19, $07, $00, $00 ; 0a:788c ???????? ; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    db   $40, $0a, $10, COLLISION_TYPE_NINJA, $18, $07, $00, $00 ; 0a:7894 ???????? ; ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    db   $40, $0a, $10, COLLISION_TYPE_NINJA, $18, $07, $00, $00 ; 0a:789c ???????? ; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    db   $00, $0c, $10, COLLISION_TYPE_SAMURAI_BODY, $18, $07, $00, $00 ; 0a:78a4 ???????? ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    db   $00, $06, $06, COLLISION_TYPE_NONE, $00, $06, $00, $00 ; 0a:78ac ???????? ; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    db   $00, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $17, $07, $00, $00 ; 0a:78b4 ???????? ; ENTITY_KUNG_FU_THEATER_LIZARD
    db   $00, $04, $04, COLLISION_TYPE_UNK_09, $18, $06, $00, $00 ; 0a:78bc ???????? ; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    db   $00, $10, $04, COLLISION_TYPE_UNK_09, $1d, $04, $00, $00 ; 0a:78c4 ???????? ; ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    db   $00, $0c, $10, COLLISION_TYPE_JAR, $15, $04, $00, $00 ; 0a:78cc ???????? ; ENTITY_KUNG_FU_THEATER_TALL_JAR
    db   $00, $0c, $10, COLLISION_TYPE_JAR, $16, $04, $00, $00 ; 0a:78d4 ???????? ; ENTITY_KUNG_FU_THEATER_JAR
    db   $00, $18, $08, COLLISION_TYPE_UNK_09, $1b, $07, $00, $00 ; 0a:78dc ???????? ; ENTITY_UNK_5C
    db   $00, $08, $20, COLLISION_TYPE_UNK_09, $1b, $07, $00, $00 ; 0a:78e4 ???????? ; ENTITY_UNK_5D
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $1d, $04, $00, $00 ; 0a:78ec ???????? ; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $1d, $04, $00, $00 ; 0a:78f4 ???????? ; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    db   $00, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $1c, $04, $00, $00 ; 0a:78fc ???????? ; ENTITY_UNK_60
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $1c, $04, $00, $00 ; 0a:7904 ???????? ; ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    db   $00, $10, $08, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $1c, $04, $00, $00 ; 0a:790c ???????? ; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $04, $00, $00 ; 0a:7914 ???????? ; ENTITY_UNK_63
    db   $00, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $26, $04, $00, $00 ; 0a:791c ???????? ; ENTITY_UNK_64
    db   $70, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $26, $04, $00, $00 ; 0a:7924 ???????? ; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    db   $70, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $26, $04, $00, $00 ; 0a:792c ???????? ; ENTITY_REZOPOLIS_MOVING_PLATFORM
    db   $00, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $26, $04, $00, $00 ; 0a:7934 ???????? ; ENTITY_REZOPOLIS_RED_PLATFORM
    db   $00, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $26, $04, $00, $00 ; 0a:793c ???????? ; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    db   $00, $0c, $04, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $29, $05, $00, $00 ; 0a:7944 ???????? ; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    db   $00, $0c, $08, COLLISION_TYPE_GEAR, $2a, $07, $00, $00 ; 0a:794c ???????? ; ENTITY_REZOPOLIS_TAILSPIN_GEAR
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00 ; 0a:7954 ???????? ; ENTITY_UNK_6B
    db   $00, $08, $10, COLLISION_TYPE_UNK_09, $27, $05, $00, $00 ; 0a:795c ???????? ; ENTITY_UNK_6C
    db   $00, $08, $20, COLLISION_TYPE_UNK_09, $27, $05, $00, $00 ; 0a:7964 ???????? ; ENTITY_UNK_6D
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:796c ???????? ; ENTITY_REZOPOLIS_GREEN_MONSTER
    db   $00, $00, $00, COLLISION_TYPE_NONE, $2b, $05, $00, $00 ; 0a:7974 ???????? ; ENTITY_UNK_6F
    db   $00, $00, $00, COLLISION_TYPE_NONE, $2b, $05, $00, $00 ; 0a:797c ???????? ; ENTITY_UNK_70
    db   $40, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:7984 ???????? ; ENTITY_REZOPOLIS_PINCER
    db   $00, $04, $10, COLLISION_TYPE_UNK_09, $28, $07, $00, $00 ; 0a:798c ???????? ; ENTITY_REZOPOLIS_FLAMETHROWER
    db   $40, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:7994 ???????? ; ENTITY_REZOPOLIS_UFO
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $38, $05, $00, $00 ; 0a:799c ???????? ; ENTITY_REZOPOLIS_ANT
    db   $40, $00, $00, COLLISION_TYPE_NONE, $00, $06, $00, $00 ; 0a:79a4 ???????? ; ENTITY_REZOPOLIS_ANT_SPAWNER
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $2c, $07, $00, $00 ; 0a:79ac ???????? ; ENTITY_CIRCUIT_CENTRAL_ANT
    db   $00, $08, $10, COLLISION_TYPE_GENERIC_ENEMY, $2d, $05, $00, $00 ; 0a:79b4 ???????? ; ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    db   $60, $08, $08, COLLISION_TYPE_POWER_UP, $2e, $05, $00, $00 ; 0a:79bc ???????? ; ENTITY_CIRCUIT_CENTRAL_POWER_UP
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00 ; 0a:79c4 ???????? ; ENTITY_UNK_79
    db   $00, $0c, $08, COLLISION_TYPE_GENERIC_ENEMY, $2f, $07, $00, $00 ; 0a:79cc ???????? ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    db   $00, $00, $00, COLLISION_TYPE_NONE, $2f, $06, $00, $00 ; 0a:79d4 ???????? ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    db   $70, $08, $08, COLLISION_TYPE_ELECTRIC_BALL, $30, $05, $00, $00 ; 0a:79dc ???????? ; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    db   $40, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $31, $04, $00, $00 ; 0a:79e4 ???????? ; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $31, $04, $00, $00 ; 0a:79ec ???????? ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    db   $00, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $31, $04, $00, $00 ; 0a:79f4 ???????? ; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00 ; 0a:79fc ???????? ; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    db   $40, $10, $10, COLLISION_TYPE_POWERED_WALKWAY, $00, $07, $00, $00 ; 0a:7a04 ???????? ; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    db   $40, $10, $08, COLLISION_TYPE_UNK_05 | COLLISION_TYPE_UNK_PLATFORM_FLAG, $00, $07, $00, $00 ; 0a:7a0c ???????? ; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    db   $60, $08, $08, COLLISION_TYPE_NONE, $32, $05, $00, $00 ; 0a:7a14 ???????? ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    db   $60, $08, $08, COLLISION_TYPE_NONE, $32, $05, $00, $00 ; 0a:7a1c ???????? ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    db   $60, $08, $08, COLLISION_TYPE_NONE, $32, $05, $00, $00 ; 0a:7a24 ???????? ; ENTITY_CHANNEL_Z_GUN_PROJECTILE
    db   $10, $10, $10, COLLISION_TYPE_REZ, $00, $07, $00, $00 ; 0a:7a2c ???????? ; ENTITY_CHANNEL_Z_REZ
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $32, $04, $00, $00 ; 0a:7a34 ???????? ; ENTITY_UNK_87
    db   $00, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $32, $04, $00, $00 ; 0a:7a3c ???????? ; ENTITY_UNK_88
    db   $00, $08, $08, COLLISION_TYPE_NONE, $32, $06, $00, $00 ; 0a:7a44 ???????? ; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    db   $00, $08, $08, COLLISION_TYPE_UNK_09, $32, $03, $00, $00 ; 0a:7a4c ???????? ; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    db   $00, $10, $10, COLLISION_TYPE_NONE, $37, $05, $00, $00 ; 0a:7a54 ???????? ; ENTITY_UNK_8B
    db   $40, $08, $08, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $39, $04, $00, $00 ; 0a:7a5c ???????? ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    db   $00, $10, $10, COLLISION_TYPE_NONE, $00, $07, $00, $00 ; 0a:7a64 ???????? ; ENTITY_UNK_8D
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00 ; 0a:7a6c ???????. ; ENTITY_UNK_8E
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_UNK_PLATFORM_FLAG, $35, $05, $00, $00 ; 0a:7a74 ...ww?? ; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

call_0a_7a7c_EntitySpawn_SpawnNextFromList:
; Scans $D220–D3E0 (step $20) for a free slot (ID=FF); reads the next entry from the entity list pointer, 
; checks if the list is exhausted (restarts via call_0a_4000 if $FF terminator hit), 
; increments the list cursor by $10, looks up the corresponding D0xx flags entry and skips if 
; already occupied, writes X/Y position and room bounds, calls Entity_CheckIfPlayerInRoomBounds and 
; aborts if out of range, then fully initializes the slot: writes entity ID, copies the entity-type 
; attribute record (flags, width, height, collision type etc.) from data_0a_75fd_EntityAttributeTable using a bitmask from 
; the entity table, loads animation type, sets action 0, optionally calls a sound/init farCall
    ld   H, $d2                                        ;; 0a:7a7c $26 $d2
    ld   A, $20                                        ;; 0a:7a7e $3e $20
.jr_0a_7a80:
    ld   L, A                                          ;; 0a:7a80 $6f ; L = 0x20
    ld   A, [HL]                                       ;; 0a:7a81 $7e ; load from $d2xx, start at $d220
    cp   A, $ff                                        ;; 0a:7a82 $fe $ff ; if loaded value is ff, then jump
    jr   Z, .jr_0a_7a8c                                ;; 0a:7a84 $28 $06
    ld   A, L                                          ;; 0a:7a86 $7d
    add  A, $20                                        ;; 0a:7a87 $c6 $20
    jr   NZ, .jr_0a_7a80                               ;; 0a:7a89 $20 $f5
    ret                                                ;; 0a:7a8b $c9
.jr_0a_7a8c: ; jump here if the value was 0xff. so basically it is looping through 7 sets of 32 bytes looking for a free slot (ff)
    ld   A, L                                          ;; 0a:7a8c $7d
    ld   [wD300_CurrentEntityAddrLo], A                                    ;; 0a:7a8d $ea $00 $d3 ; so d300 is the address of the ff byte it found
    rlca                                               ;; 0a:7a90 $07
    rlca                                               ;; 0a:7a91 $07
    rlca                                               ;; 0a:7a92 $07 so now a is the slot number, where slot 1 is dd20, and slot 3 is dd60
    ld   [wD339], A                                    ;; 0a:7a93 $ea $39 $d3
    ld   HL, wD336_CurrentEntityToLoadPtr                                     ;; 0a:7a96 $21 $36 $d3
    ld   E, [HL]                                       ;; 0a:7a99 $5e
    inc  HL                                            ;; 0a:7a9a $23
    ld   D, [HL]                                       ;; 0a:7a9b $56
    ld   A, [DE]                                       ;; 0a:7a9c $1a ; load first byte from data
    cp   A, $ff                                        ;; 0a:7a9d $fe $ff
    jp   Z, call_0a_4000_EntityList_LoadForCurrentLevel                                 ;; 0a:7a9f $ca $00 $40
    ld   [wD33B], A                                    ;; 0a:7aa2 $ea $3b $d3 ; first byte from data
    ld   HL, $10                                       ;; 0a:7aa5 $21 $10 $00
    add  HL, DE                                        ;; 0a:7aa8 $19
    ld   A, L                                          ;; 0a:7aa9 $7d
    ld   [wD336_CurrentEntityToLoadPtr], A                                    ;; 0a:7aaa $ea $36 $d3
    ld   A, H                                          ;; 0a:7aad $7c
    ld   [wD337_CurrentEntityToLoadPtr], A                                    ;; 0a:7aae $ea $37 $d3 ; load 2 bytes 0x10 after first
    ld   HL, wD338                                     ;; 0a:7ab1 $21 $38 $d3 
    ld   C, [HL]                                       ;; 0a:7ab4 $4e 
    inc  [HL]                                          ;; 0a:7ab5 $34
    ld   B, $d0                                        ;; 0a:7ab6 $06 $d0
    ld   A, [BC]                                       ;; 0a:7ab8 $0a
    and  A, A                                          ;; 0a:7ab9 $a7
    ret  NZ                                            ;; 0a:7aba $c0
    ld   A, C                                          ;; 0a:7abb $79
    ld   [wD33A], A                                    ;; 0a:7abc $ea $3a $d3
    inc  DE                                            ;; 0a:7abf $13
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_XPOS
    ld   A, [DE]                                       ;; 0a:7ac8 $1a
    ld   [HL+], A                                      ;; 0a:7ac9 $22 ; this is where the x and y coords of the entity are read and written
    inc  DE                                            ;; 0a:7aca $13
    ld   A, [DE]                                       ;; 0a:7acb $1a
    ld   [HL+], A                                      ;; 0a:7acc $22
    inc  DE                                            ;; 0a:7acd $13
    ld   A, [DE]                                       ;; 0a:7ace $1a
    ld   [HL+], A                                      ;; 0a:7acf $22
    inc  DE                                            ;; 0a:7ad0 $13
    ld   A, [DE]                                       ;; 0a:7ad1 $1a
    ld   [HL], A                                       ;; 0a:7ad2 $77
    inc  DE                                            ;; 0a:7ad3 $13
    ld   HL, wD339                                     ;; 0a:7ad4 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7ad7 $6e
    ld   H, $00                                        ;; 0a:7ad8 $26 $00
    add  HL, HL                                        ;; 0a:7ada $29
    add  HL, HL                                        ;; 0a:7adb $29
    ld   BC, wD309                                     ;; 0a:7adc $01 $09 $d3
    add  HL, BC                                        ;; 0a:7adf $09
    ld   A, [DE]                                       ;; 0a:7ae0 $1a
    ld   [HL+], A                                      ;; 0a:7ae1 $22
    inc  DE                                            ;; 0a:7ae2 $13
    ld   A, [DE]                                       ;; 0a:7ae3 $1a
    ld   [HL+], A                                      ;; 0a:7ae4 $22
    inc  DE                                            ;; 0a:7ae5 $13
    ld   A, [DE]                                       ;; 0a:7ae6 $1a
    ld   [HL+], A                                      ;; 0a:7ae7 $22
    inc  DE                                            ;; 0a:7ae8 $13
    ld   A, [DE]                                       ;; 0a:7ae9 $1a
    ld   [HL+], A                                      ;; 0a:7aea $22
    inc  DE                                            ;; 0a:7aeb $13
    push DE                                            ;; 0a:7aec $d5
    farcall call_00_350c_Entity_CheckIfPlayerInRoomBounds
    pop  DE                                            ;; 0a:7af8 $d1
    ret  C                                             ;; 0a:7af9 $d8
    push DE                                            ;; 0a:7afa $d5
    LOAD_OBJ_FIELD_TO_DE_ALT ENTITY_FIELD_ENTITY_ID
    ld   A, [wD33B]                                    ;; 0a:7b03 $fa $3b $d3
    ld   [DE], A                                       ;; 0a:7b06 $12
    ld   L, A                                          ;; 0a:7b07 $6f
    ld   H, $00                                        ;; 0a:7b08 $26 $00
    add  HL, HL                                        ;; 0a:7b0a $29
    add  HL, HL                                        ;; 0a:7b0b $29
    add  HL, HL                                        ;; 0a:7b0c $29
    ld   BC, data_0a_75fc                             ;; 0a:7b0d $01 $fc $75
    add  HL, BC                                        ;; 0a:7b10 $09
    ld   C, L                                          ;; 0a:7b11 $4d
    ld   B, H                                          ;; 0a:7b12 $44
    pop  HL                                            ;; 0a:7b13 $e1
    ld   A, E                                          ;; 0a:7b14 $7b
    xor  A, $17                                        ;; 0a:7b15 $ee $17
    ld   E, A                                          ;; 0a:7b17 $5f
    xor  A, A                                          ;; 0a:7b18 $af
    ld   [DE], A                                       ;; 0a:7b19 $12
    inc  E                                             ;; 0a:7b1a $1c
    ld   A, [BC]                                       ;; 0a:7b1b $0a
    inc  BC                                            ;; 0a:7b1c $03
    push BC                                            ;; 0a:7b1d $c5
    ld   B, A                                          ;; 0a:7b1e $47
    ld   C, $08                                        ;; 0a:7b1f $0e $08
.jr_0a_7b21:
    xor  A, A                                          ;; 0a:7b21 $af
    ld   [DE], A                                       ;; 0a:7b22 $12
    bit  7, B                                          ;; 0a:7b23 $cb $78
    jr   Z, .jr_0a_7b29                                ;; 0a:7b25 $28 $02
    ld   A, [HL+]                                      ;; 0a:7b27 $2a
    ld   [DE], A                                       ;; 0a:7b28 $12
.jr_0a_7b29:
    inc  E                                             ;; 0a:7b29 $1c
    sla  B                                             ;; 0a:7b2a $cb $20
    dec  C                                             ;; 0a:7b2c $0d
    jr   NZ, .jr_0a_7b21                               ;; 0a:7b2d $20 $f2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 0a:7b2f $fa $00 $d3
    or   A, $14                                        ;; 0a:7b32 $f6 $14
    ld   E, A                                          ;; 0a:7b34 $5f
    pop  HL                                            ;; 0a:7b35 $e1
    ld   A, [HL+]                                      ;; 0a:7b36 $2a
    ld   [DE], A                                       ;; 0a:7b37 $12
    inc  E                                             ;; 0a:7b38 $1c
    ld   A, [HL+]                                      ;; 0a:7b39 $2a
    ld   [DE], A                                       ;; 0a:7b3a $12
    inc  E                                             ;; 0a:7b3b $1c
    ld   A, [HL+]                                      ;; 0a:7b3c $2a
    ld   [DE], A                                       ;; 0a:7b3d $12
    push HL                                            ;; 0a:7b3e $e5
    ld   A, E                                          ;; 0a:7b3f $7b
    xor  A, $1b                                        ;; 0a:7b40 $ee $1b
    ld   E, A                                          ;; 0a:7b42 $5f
    ld   A, $00                                        ;; 0a:7b43 $3e $00
    ld   [DE], A                                       ;; 0a:7b45 $12 ; sets instance+0x0D facing angle to 0 by default
    ld   HL, wD339                                     ;; 0a:7b46 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7b49 $6e
    ld   H, $00                                        ;; 0a:7b4a $26 $00
    ld   DE, wD301                                     ;; 0a:7b4c $11 $01 $d3
    add  HL, DE                                        ;; 0a:7b4f $19
    ld   A, [wD33A]                                    ;; 0a:7b50 $fa $3a $d3
    ld   [HL], A                                       ;; 0a:7b53 $77
    ld   L, A                                          ;; 0a:7b54 $6f
    ld   H, $d0                                        ;; 0a:7b55 $26 $d0
    ld   [HL], $01                                     ;; 0a:7b57 $36 $01
    xor  A, A                                          ;; 0a:7b59 $af
    farcall call_02_7102_Entity_SetAction
    ld   HL, wD339                                     ;; 0a:7b65 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7b68 $6e
    ld   H, $00                                        ;; 0a:7b69 $26 $00
    add  HL, HL                                        ;; 0a:7b6b $29
    add  HL, HL                                        ;; 0a:7b6c $29
    ld   DE, data_00_39c0                                     ;; 0a:7b6d $11 $c0 $39
    add  HL, DE                                        ;; 0a:7b70 $19
    ld   A, [HL+]                                      ;; 0a:7b71 $2a
    ld   H, [HL]                                       ;; 0a:7b72 $66
    ld   L, A                                          ;; 0a:7b73 $6f
    ld   [HL], $00                                     ;; 0a:7b74 $36 $00
    pop  HL                                            ;; 0a:7b76 $e1
    ld   A, [HL+]                                      ;; 0a:7b77 $2a
    push HL                                            ;; 0a:7b78 $e5
    and  A, A                                          ;; 0a:7b79 $a7
    jr   Z, .jr_0a_7b87                                ;; 0a:7b7a $28 $0b
    farcall call_02_7211_SoundQueue_Enqueue
.jr_0a_7b87:
    pop  HL                                            ;; 0a:7b87 $e1
    ld   A, [wD59E]                                    ;; 0a:7b88 $fa $9e $d5
    and  A, A                                          ;; 0a:7b8b $a7
    ret  Z                                             ;; 0a:7b8c $c8
    ld   C, [HL]                                       ;; 0a:7b8d $4e
    farcall call_0b_5f57
    ret                                                ;; 0a:7b99 $c9

call_0a_7b9a_EntitySpawn_SpawnChildEntity:
; Finds a free NPC slot, then copies position fields from the calling entity into the new slot 
; (preserving the parent's wD300 address around the operation), applies a signed X or Y offset 
; from .data_0a_7c92_EntityChildSpawnData based on child entity type (add or subtract depending 
; on a direction flag), copies collision/size attributes from data_0a_75fd_EntityAttributeTable, calls the init farCall, 
; clears the slot counter, sets action 0, and copies room bounds from the parent's slot into the child's slot
    ld   D, $d2                                        ;; 0a:7b9a $16 $d2
    ld   A, $20                                        ;; 0a:7b9c $3e $20
.jr_0a_7b9e:
    ld   E, A                                          ;; 0a:7b9e $5f
    ld   A, [DE]                                       ;; 0a:7b9f $1a
    cp   A, $ff                                        ;; 0a:7ba0 $fe $ff
    jr   Z, .jr_0a_7baa                                ;; 0a:7ba2 $28 $06
    ld   A, E                                          ;; 0a:7ba4 $7b
    add  A, $20                                        ;; 0a:7ba5 $c6 $20
    jr   NZ, .jr_0a_7b9e                               ;; 0a:7ba7 $20 $f5
    ret                                                ;; 0a:7ba9 $c9
.jr_0a_7baa:
    ld   HL, wD300_CurrentEntityAddrLo                                     ;; 0a:7baa $21 $00 $d3
    ld   A, [HL]                                       ;; 0a:7bad $7e
    ld   [HL], E                                       ;; 0a:7bae $73
    push AF                                            ;; 0a:7baf $f5
    ld   H, $d2                                        ;; 0a:7bb0 $26 $d2
    or   A, $0e                                        ;; 0a:7bb2 $f6 $0e
    ld   L, A                                          ;; 0a:7bb4 $6f
    ld   D, H                                          ;; 0a:7bb5 $54
    ld   A, E                                          ;; 0a:7bb6 $7b
    or   A, $0e                                        ;; 0a:7bb7 $f6 $0e
    ld   E, A                                          ;; 0a:7bb9 $5f
    push BC                                            ;; 0a:7bba $c5
    ld   B, H                                          ;; 0a:7bbb $44
    xor  A, $16                                        ;; 0a:7bbc $ee $16
    ld   C, A                                          ;; 0a:7bbe $4f
.jr_0a_7bbf:
    ld   A, [HL+]                                      ;; 0a:7bbf $2a
    ld   [DE], A                                       ;; 0a:7bc0 $12
    ld   [BC], A                                       ;; 0a:7bc1 $02
    inc  E                                             ;; 0a:7bc2 $1c
    inc  C                                             ;; 0a:7bc3 $0c
    ld   A, L                                          ;; 0a:7bc4 $7d
    and  A, $1f                                        ;; 0a:7bc5 $e6 $1f
    cp   A, $12                                        ;; 0a:7bc7 $fe $12
    jr   NZ, .jr_0a_7bbf                               ;; 0a:7bc9 $20 $f4
    xor  A, A                                          ;; 0a:7bcb $af
    ld   [BC], A                                       ;; 0a:7bcc $02
    inc  C                                             ;; 0a:7bcd $0c
    ld   [BC], A                                       ;; 0a:7bce $02
    inc  C                                             ;; 0a:7bcf $0c
    ld   [BC], A                                       ;; 0a:7bd0 $02
    inc  C                                             ;; 0a:7bd1 $0c
    ld   [BC], A                                       ;; 0a:7bd2 $02
    pop  BC                                            ;; 0a:7bd3 $c1
    ld   A, L                                          ;; 0a:7bd4 $7d
    xor  A, $1f                                        ;; 0a:7bd5 $ee $1f
    ld   L, A                                          ;; 0a:7bd7 $6f
    ld   A, E                                          ;; 0a:7bd8 $7b
    xor  A, $1f                                        ;; 0a:7bd9 $ee $1f
    ld   E, A                                          ;; 0a:7bdb $5f
    ld   A, [HL]                                       ;; 0a:7bdc $7e
    ld   [DE], A                                       ;; 0a:7bdd $12
    push AF                                            ;; 0a:7bde $f5
    ld   L, C                                          ;; 0a:7bdf $69
    ld   H, $00                                        ;; 0a:7be0 $26 $00
    add  HL, HL                                        ;; 0a:7be2 $29
    add  HL, HL                                        ;; 0a:7be3 $29
    add  HL, HL                                        ;; 0a:7be4 $29
    ld   BC, .data_0a_7c92_EntityChildSpawnData                             ;; 0a:7be5 $01 $92 $7c
    add  HL, BC                                        ;; 0a:7be8 $09
    ld   A, E                                          ;; 0a:7be9 $7b
    xor  A, $0d                                        ;; 0a:7bea $ee $0d
    ld   E, A                                          ;; 0a:7bec $5f
    ld   A, [HL+]                                      ;; 0a:7bed $2a
    ld   [DE], A                                       ;; 0a:7bee $12
    ld   C, A                                          ;; 0a:7bef $4f
    ld   A, E                                          ;; 0a:7bf0 $7b
    xor  A, $0e                                        ;; 0a:7bf1 $ee $0e
    ld   E, A                                          ;; 0a:7bf3 $5f
    pop  AF                                            ;; 0a:7bf4 $f1
    cp   A, $00                                        ;; 0a:7bf5 $fe $00
    jr   NZ, .jr_0a_7c05                               ;; 0a:7bf7 $20 $0c
    ld   A, [DE]                                       ;; 0a:7bf9 $1a
    add  A, [HL]                                       ;; 0a:7bfa $86
    ld   [DE], A                                       ;; 0a:7bfb $12
    inc  HL                                            ;; 0a:7bfc $23
    inc  DE                                            ;; 0a:7bfd $13
    ld   A, [DE]                                       ;; 0a:7bfe $1a
    adc  A, [HL]                                       ;; 0a:7bff $8e
    ld   [DE], A                                       ;; 0a:7c00 $12
    inc  HL                                            ;; 0a:7c01 $23
    inc  E                                             ;; 0a:7c02 $1c
    jr   .jr_0a_7c0f                                   ;; 0a:7c03 $18 $0a
.jr_0a_7c05:
    ld   A, [DE]                                       ;; 0a:7c05 $1a
    sub  A, [HL]                                       ;; 0a:7c06 $96
    ld   [DE], A                                       ;; 0a:7c07 $12
    inc  HL                                            ;; 0a:7c08 $23
    inc  DE                                            ;; 0a:7c09 $13
    ld   A, [DE]                                       ;; 0a:7c0a $1a
    sbc  A, [HL]                                       ;; 0a:7c0b $9e
    ld   [DE], A                                       ;; 0a:7c0c $12
    inc  HL                                            ;; 0a:7c0d $23
    inc  E                                             ;; 0a:7c0e $1c
.jr_0a_7c0f:
    ld   A, [DE]                                       ;; 0a:7c0f $1a
    add  A, [HL]                                       ;; 0a:7c10 $86
    ld   [DE], A                                       ;; 0a:7c11 $12
    inc  HL                                            ;; 0a:7c12 $23
    inc  DE                                            ;; 0a:7c13 $13
    ld   A, [DE]                                       ;; 0a:7c14 $1a
    adc  A, [HL]                                       ;; 0a:7c15 $8e
    ld   [DE], A                                       ;; 0a:7c16 $12
    ld   A, E                                          ;; 0a:7c17 $7b
    xor  A, $05                                        ;; 0a:7c18 $ee $05
    ld   E, A                                          ;; 0a:7c1a $5f
    ld   L, C                                          ;; 0a:7c1b $69
    ld   H, $00                                        ;; 0a:7c1c $26 $00
    add  HL, HL                                        ;; 0a:7c1e $29
    add  HL, HL                                        ;; 0a:7c1f $29
    add  HL, HL                                        ;; 0a:7c20 $29
    ld   BC, data_0a_75fd_EntityAttributeTable                             ;; 0a:7c21 $01 $fd $75
    add  HL, BC                                        ;; 0a:7c24 $09
    ld   A, [HL+]                                      ;; 0a:7c25 $2a
    ld   [DE], A                                       ;; 0a:7c26 $12
    inc  E                                             ;; 0a:7c27 $1c
    ld   A, [HL+]                                      ;; 0a:7c28 $2a
    ld   [DE], A                                       ;; 0a:7c29 $12
    inc  E                                             ;; 0a:7c2a $1c
    ld   A, [HL+]                                      ;; 0a:7c2b $2a
    ld   [DE], A                                       ;; 0a:7c2c $12
    ld   A, E                                          ;; 0a:7c2d $7b
    xor  A, $08                                        ;; 0a:7c2e $ee $08
    ld   E, A                                          ;; 0a:7c30 $5f
    xor  A, A                                          ;; 0a:7c31 $af
    ld   [DE], A                                       ;; 0a:7c32 $12
    ld   A, [HL+]                                      ;; 0a:7c33 $2a
    push HL                                            ;; 0a:7c34 $e5
    and  A, A                                          ;; 0a:7c35 $a7
    jr   Z, .jr_0a_7c43                                ;; 0a:7c36 $28 $0b
    farcall call_02_7211_SoundQueue_Enqueue
.jr_0a_7c43:
    pop  HL                                            ;; 0a:7c43 $e1
    ld   A, [wD59E]                                    ;; 0a:7c44 $fa $9e $d5
    and  A, A                                          ;; 0a:7c47 $a7
    jr   Z, .jr_0a_7c56                                ;; 0a:7c48 $28 $0c
    ld   C, [HL]                                       ;; 0a:7c4a $4e
    farcall call_0b_5f57
.jr_0a_7c56:
    call call_00_34d8_Entity_ClearSlotCounter                                  ;; 0a:7c56 $cd $d8 $34
    xor  A, A                                          ;; 0a:7c59 $af
    farcall call_02_7102_Entity_SetAction
    pop  AF                                            ;; 0a:7c65 $f1
    ld   HL, wD300_CurrentEntityAddrLo                                     ;; 0a:7c66 $21 $00 $d3
    ld   C, [HL]                                       ;; 0a:7c69 $4e
    ld   [HL], A                                       ;; 0a:7c6a $77
    rrca                                               ;; 0a:7c6b $0f
    rrca                                               ;; 0a:7c6c $0f
    rrca                                               ;; 0a:7c6d $0f
    and  A, $1c                                        ;; 0a:7c6e $e6 $1c
    ld   L, A                                          ;; 0a:7c70 $6f
    ld   H, $00                                        ;; 0a:7c71 $26 $00
    ld   DE, wD309                                     ;; 0a:7c73 $11 $09 $d3
    add  HL, DE                                        ;; 0a:7c76 $19
    ld   E, L                                          ;; 0a:7c77 $5d
    ld   D, H                                          ;; 0a:7c78 $54
    ld   A, C                                          ;; 0a:7c79 $79
    rrca                                               ;; 0a:7c7a $0f
    rrca                                               ;; 0a:7c7b $0f
    rrca                                               ;; 0a:7c7c $0f
    and  A, $1c                                        ;; 0a:7c7d $e6 $1c
    ld   L, A                                          ;; 0a:7c7f $6f
    ld   H, $00                                        ;; 0a:7c80 $26 $00
    ld   BC, wD309                                     ;; 0a:7c82 $01 $09 $d3
    add  HL, BC                                        ;; 0a:7c85 $09
    ld   A, [DE]                                       ;; 0a:7c86 $1a
    ld   [HL+], A                                      ;; 0a:7c87 $22
    inc  DE                                            ;; 0a:7c88 $13
    ld   A, [DE]                                       ;; 0a:7c89 $1a
    ld   [HL+], A                                      ;; 0a:7c8a $22
    inc  DE                                            ;; 0a:7c8b $13
    ld   A, [DE]                                       ;; 0a:7c8c $1a
    ld   [HL+], A                                      ;; 0a:7c8d $22
    inc  DE                                            ;; 0a:7c8e $13
    ld   A, [DE]                                       ;; 0a:7c8f $1a
    ld   [HL], A                                       ;; 0a:7c90 $77
    ret                                                ;; 0a:7c91 $c9
.data_0a_7c92_EntityChildSpawnData:
; 8-byte records (child entity ID + signed 16-bit X offset + signed 16-bit Y offset + padding) 
; defining where each spawnable child appears relative to its parent.
    db   ENTITY_SCREAM_TV_HEAD_GHOST_HEAD, $06, $00, $f2, $ff, $00, $00, $00        ;; 0a:7c92 ????????
    db   ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE, $00, $00, $0c, $00, $00, $00, $00        ;; 0a:7c9a ????????
    db   ENTITY_SCREAM_TV_ZOMBIE_HEAD, $00, $00, $ee, $ff, $00, $00, $00        ;; 0a:7ca2 ????????
    db   ENTITY_TOON_TV_FLOWER_HAMMER, $f5, $ff, $fc, $ff, $00, $00, $00        ;; 0a:7caa w???????
    db   ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE, $08, $00, $00, $00, $00, $00, $00        ;; 0a:7cb2 ????????
    db   ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD, $00, $00, $e8, $ff, $00, $00, $00        ;; 0a:7cba ????????
    db   ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES, $00, $00, $08, $00, $00, $00, $00        ;; 0a:7cc2 ????????
    db   ENTITY_PRE_HISTORY_TRICERATOPS_HORN, $14, $00, $00, $00, $00, $00, $00        ;; 0a:7cca ????????
    db   ENTITY_UNK_28, $00, $00, $f8, $ff, $00, $00, $00        ;; 0a:7cd2 w???????
    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR, $00, $00, $10, $00, $00, $00, $00        ;; 0a:7cda ????????
    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ce2 ????????
    db   ENTITY_TOON_TV_HUNTER_BULLET, $10, $00, $00, $00, $00, $00, $00        ;; 0a:7cea ????????
    db   ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7cf2 ????????
    db   ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE, $14, $00, $00, $00, $00, $00, $00        ;; 0a:7cfa ????????
    db   ENTITY_REZOPOLIS_ANT, $00, $00, $08, $00, $00, $00, $00        ;; 0a:7d02 ????????
    db   ENTITY_UNK_8B, $4c, $00, $68, $ff, $00, $00, $00        ;; 0a:7d0a ????????
    db   ENTITY_UNK_8B, $b4, $ff, $68, $ff, $00, $00, $00        ;; 0a:7d12 ????????
    db   ENTITY_UNK_8D, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7d1a ?
