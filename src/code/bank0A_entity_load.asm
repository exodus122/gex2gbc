; ==================================================================
; ENTITY SPAWNING
;
; Every level has a flat list of entity records, one per placed object. The
; lists are the .bin blobs below; the code walks them.
;
; Spawning is spread out rather than done at level start: Entities_UpdateAll
; calls EntitySpawn_SpawnNextFromList exactly once per frame, so at most one
; entity appears per frame and the cursor loops the list forever. An entry
; whose room is not currently on screen is skipped and simply reconsidered the
; next time round. That is the whole streaming system - there is no separate
; "is this entity due to appear" pass.
;
; Two tables decide what a spawned entity becomes:
;   the list entry        where it is, how big its room is, and up to three
;                         free parameter bytes
;   data_0a_75fd_EntityAttributeTable   everything that depends only on the
;                         entity *type* - size, collision type, graphics
;
; Re-spawning is prevented by wD000_EntityFlags, indexed by the entry's
; position in the list. Once an entity has been placed its flag is set, and it
; will not be placed again until the flag is cleared - which is what makes a
; defeated enemy stay defeated while you are still in the room.
; ==================================================================

call_0a_4000_EntityList_LoadForCurrentLevel:
; Points the spawn cursor at the start of the current level's entity list.
; Also called mid-level by SpawnNextFromList when it hits the list terminator,
; which is what makes the walk cyclic rather than one-shot
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
    ld   [wD338_EntityLoadingFlag], A                                    ;; 0a:4015 $ea $38 $d3
    ret                                                ;; 0a:4018 $c9
.data_0a_4019:
    dw   .data_MediaDimension_entity_list         ; MAP_MEDIA_DIMENSION
    dw   .data_OutOfToon_entity_list              ; MAP_TOON_TV_OUT_OF_TOON
    dw   .data_Smellraiser_entity_list            ; MAP_SCREAM_TV_SMELLRAISER
    dw   .data_Frankensteinfeld_entity_list       ; MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .data_wwwdotcomcom_entity_list           ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .data_MaoTseTongue_entity_list           ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .data_Pangaea90210_entity_list           ; MAP_UNUSED_06
    dw   .data_Pangaea90210_entity_list           ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .data_FineTooning_entity_list            ; MAP_TOON_TV_FINE_TOONING
    dw   .data_ThisOldCave_entity_list            ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .data_HoneyIShrunkTheGecko_entity_list   ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .data_Poltergex_entity_list              ; MAP_SCREAM_TV_POLTERGEX
    dw   .data_SamuraiNightFever_entity_list      ; MAP_UNUSED_0C
    dw   .data_SamuraiNightFever_entity_list      ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .data_NoWeddingsAndAFuneral_entity_list  ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .data_ThursdayThe12th_entity_list        ; MAP_UNUSED_0F
    dw   .data_ThursdayThe12th_entity_list        ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_11
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_12
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_13
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_14
    dw   .data_LizardInAChinaShop_entity_list     ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .data_BuggedOut_entity_list              ; MAP_REZOPOLIS_BUGGED_OUT
    dw   .data_ChipsAndDips_entity_list           ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .data_LavaDabbaDoo_entity_list           ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .data_TexasChainsawManicure_entity_list  ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .data_MazedAndConfused_entity_list       ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_1B
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_1C
    dw   .data_MediaDimension_entity_list         ; MAP_UNUSED_1D
    dw   .data_ChannelZ_entity_list               ; MAP_BOSS_TV_CHANNEL_Z
.data_MediaDimension_entity_list:                             ;; 0a:4057
    INCBIN "data/maps/media_dimension/entity_list_media_dimension.bin"
.data_OutOfToon_entity_list:                             ;; 0a:4488
    INCBIN "data/maps/toon_tv/entity_list_out_of_toon.bin"
.data_Smellraiser_entity_list:                             ;; 0a:48c9
    INCBIN "data/maps/scream_tv/entity_list_smellraiser.bin"
.data_Frankensteinfeld_entity_list:                             ;; 0a:4aba
    INCBIN "data/maps/scream_tv/entity_list_frankensteinfeld.bin"
.data_wwwdotcomcom_entity_list:                             ;; 0a:4ddb
    INCBIN "data/maps/circuit_central/entity_list_wwwdotcomcom.bin"
.data_MaoTseTongue_entity_list:                             ;; 0a:51ec
    INCBIN "data/maps/kung_fu_theater/entity_list_mao_tse_tongue.bin"
.data_Pangaea90210_entity_list:                             ;; 0a:54ed
    INCBIN "data/maps/prehistory_channel/entity_list_pangaea_90210.bin"
.data_FineTooning_entity_list:                             ;; 0a:57ee
    INCBIN "data/maps/toon_tv/entity_list_fine_tooning.bin"
.data_ThisOldCave_entity_list:                             ;; 0a:5c8f
    INCBIN "data/maps/prehistory_channel/entity_list_this_old_cave.bin"
.data_HoneyIShrunkTheGecko_entity_list:                             ;; 0a:5e20
    INCBIN "data/maps/circuit_central/entity_list_honey_i_shrunk_the_gecko.bin"
.data_Poltergex_entity_list:                             ;; 0a:6331
    INCBIN "data/maps/scream_tv/entity_list_poltergex.bin"
.data_SamuraiNightFever_entity_list:                             ;; 0a:6692
    INCBIN "data/maps/kung_fu_theater/entity_list_samurai_night_fever.bin"
.data_NoWeddingsAndAFuneral_entity_list:                             ;; 0a:6a43
    INCBIN "data/maps/rezopolis/entity_list_no_weddings_and_a_funeral.bin"
.data_ThursdayThe12th_entity_list:                             ;; 0a:6c84
    INCBIN "data/maps/scream_tv/entity_list_thursday_the_12th.bin"
.data_LizardInAChinaShop_entity_list:                             ;; 0a:6d45
    INCBIN "data/maps/kung_fu_theater/entity_list_lizard_in_a_china_shop.bin"
.data_BuggedOut_entity_list:                             ;; 0a:6dc6
    INCBIN "data/maps/rezopolis/entity_list_bugged_out.bin"
.data_ChipsAndDips_entity_list:                             ;; 0a:6df7
    INCBIN "data/maps/circuit_central/entity_list_chips_and_dips.bin"
.data_LavaDabbaDoo_entity_list:                             ;; 0a:6e78
    INCBIN "data/maps/prehistory_channel/entity_list_lava_dabba_doo.bin"
.data_TexasChainsawManicure_entity_list:                             ;; 0a:7149
    INCBIN "data/maps/scream_tv/entity_list_texas_chainsaw_manicure.bin"
.data_MazedAndConfused_entity_list:                             ;; 0a:734a
    INCBIN "data/maps/rezopolis/entity_list_mazed_and_confused.bin"
.data_ChannelZ_entity_list:                             ;; 0a:751b
    INCBIN "data/maps/channel_z/entity_list_channel_z.bin"

data_0a_75fc:
; Byte 0 of ENTITY_GEX's record. The spawn code indexes from *here*, not from the label
; below, so every record is 8 bytes starting at data_0a_75fc + id*8 - which is why the Gex
; row below is one byte short and every later row appears shifted by one
    db   $00                                           ;; 0a:75fc ?
data_0a_75fd_EntityAttributeTable:
; The per-entity-type template applied to a slot when it spawns. 8 bytes per entity id:
;
;   +0  spawn parameter mask (see below)
;   +1  ENTITY_FIELD_WIDTH
;   +2  ENTITY_FIELD_HEIGHT
;   +3  ENTITY_FIELD_COLLISION_TYPE
;   +4  graphics set id, queued through call_02_7211_EntityGfxQueue_Enqueue ($00 = none)
;   +5  GBC palette id
;   +6  unused
;   +7  unused
;
; Bytes +4/+5 are the same pair as data_02_743c_EntityGfxAndPaletteTable - that table is
; consulted when entities are already live, this one when they spawn.
;
; The mask is the interesting field. A level's entity list carries three free parameter
; bytes per entry (ENTITY_SPAWN_PARAMETER*_OFFSET), and the mask decides which of the eight
; entity fields $18..$1F they land in - bit 7 for $18 through bit 0 for $1F. Any field whose
; bit is clear is zeroed instead. That is how one spawn record format configures a moving
; platform's velocity and a timer-driven hazard's countdown without either knowing about the
; other. See SPAWN_PARAM_TO_* in constants.asm; $70 - route the three parameters to
; TIMER_2 / MISC_PARAM / UNK_1B ($19/$1A/$1B) - is by far the most common value.
;
; ENTITY_TV_BUTTON and ENTITY_RED_REMOTE both use $70, and those three bytes are
; exactly what call_00_3899_Entity_CheckRemoteTotalsUnlock reads back as the
; mission / hidden / bonus remote requirements. So a hub TV's unlock condition is
; three numbers in the level's entity list, not anything in code
    db   $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00                  ; ENTITY_GEX
    db   $00, $2c, $10, COLLISION_TYPE_COLLECTIBLE, $00, $01, $00, $00      ; ENTITY_COLLECTIBLE_SPAWN
    db   $00, $08, $08, COLLISION_TYPE_EXTRA_LIFE, $00, $02, $00, $00       ; ENTITY_UNK_02
    db   $70, $08, $08, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_PLATFORM, $00, $06, $00, $00    ; ENTITY_TV_BUTTON
    db   $70, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00             ; ENTITY_RED_REMOTE
    db   $00, $10, $10, COLLISION_TYPE_SILVER_REMOTE, $00, $07, $00, $00    ; ENTITY_SILVER_REMOTE
    db   $00, $10, $10, COLLISION_TYPE_GOLD_REMOTE, $00, $07, $00, $00      ; ENTITY_GOLD_REMOTE
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00             ; ENTITY_ENEMY_DEFEATED
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00             ; ENTITY_UNK_08
    db   $40, $10, $10, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_PLATFORM, $01, $05, $00, $00  ; ENTITY_SCREAM_TV_FALLING_PLATFORM
    db   $70, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $01, $04, $00, $00    ; ENTITY_SCREAM_TV_MOVING_PLATFORM
    db   $00, $10, $10, COLLISION_TYPE_STATIONARY_PLATFORM, $24, $05, $00, $00 ; ENTITY_SCREAM_TV_PUSH_BLOCK
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_SCREAM_TV_PUMPKIN
    db   $28, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_SCREAM_TV_FRANKIE
    db   $40, $08, $10, COLLISION_TYPE_GENERIC_ENEMY, $33, $07, $00, $00    ; ENTITY_SCREAM_TV_HEAD_GHOST
    db   $00, $10, $10, COLLISION_TYPE_GHOST_HEAD, $00, $06, $00, $00       ; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_SCREAM_TV_FLOATING_SKULL
    db   $00, $04, $04, COLLISION_TYPE_MULTI_PROJECTILE, $00, $06, $00, $00 ; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    db   $00, $0c, $10, COLLISION_TYPE_ZOMBIE, $00, $07, $00, $00           ; ENTITY_SCREAM_TV_ZOMBIE
    db   $00, $10, $10, COLLISION_TYPE_ZOMBIE_HEAD, $00, $06, $00, $00      ; ENTITY_SCREAM_TV_ZOMBIE_HEAD
    db   $40, $08, $08, COLLISION_TYPE_TOUCH_DAMAGE, $01, $03, $00, $00     ; ENTITY_SCREAM_TV_FALLING_AXE
    db   $00, $20, $40, COLLISION_TYPE_LANTERN, $02, $05, $00, $00          ; ENTITY_SCREAM_TV_LANTERN
    db   $00, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_SCREAM_TV_BAT
    db   $50, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $24, $05, $00, $00    ; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00             ; ENTITY_SCREAM_TV_DOOR_OPENING
    db   $10, $0c, $10, COLLISION_TYPE_GHOST, $00, $07, $00, $00            ; ENTITY_SCREAM_TV_GHOST
    db   $50, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $01, $05, $00, $00    ; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    db   $00, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $01, $04, $00, $00    ; ENTITY_SCREAM_TV_VANISHING_PLATFORM
    db   $50, $12, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $01, $04, $00, $00    ; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    db   $00, $10, $10, COLLISION_TYPE_FALLING_HAZARD, $03, $07, $00, $00   ; ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    db   $00, $10, $08, COLLISION_TYPE_TOUCH_DAMAGE, $05, $07, $00, $00     ; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    db   $00, $08, $08, COLLISION_TYPE_TOUCH_DAMAGE, $04, $07, $00, $00     ; ENTITY_TOON_TV_MOVING_BEAR_TRAP
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $0f, $07, $00, $00    ; ENTITY_TOON_TV_BUMBLEBEE
    db   $88, $0c, $10, COLLISION_TYPE_FALLING_HAZARD, $07, $07, $00, $00   ; ENTITY_TOON_TV_BOWLING_BALL
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $06, $07, $00, $00    ; ENTITY_TOON_TV_CACTUS
    db   $00, $10, $10, COLLISION_TYPE_FALLING_HAZARD, $0e, $05, $00, $00   ; ENTITY_TOON_TV_DOMINO
    db   $00, $0c, $0a, COLLISION_TYPE_GENERIC_ENEMY, $0d, $05, $00, $00    ; ENTITY_TOON_TV_SHARK
    db   $00, $10, $10, COLLISION_TYPE_NONE, $08, $07, $00, $00             ; ENTITY_TOON_TV_FLOWER
    db   $00, $0a, $10, COLLISION_TYPE_HUNTER, $00, $07, $00, $00           ; ENTITY_TOON_TV_HUNTER
    db   $00, $0c, $08, COLLISION_TYPE_MUSHROOM, $0b, $05, $00, $00         ; ENTITY_TOON_TV_MUSHROOM
    db   $00, $04, $08, COLLISION_TYPE_NONE, $23, $05, $00, $00             ; ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    db   $00, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $09, $07, $00, $00    ; ENTITY_TOON_TV_LIZARD
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_TOON_TV_HAPPY_FACE
    db   $70, $08, $10, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_PLATFORM, $10, $05, $00, $00    ; ENTITY_TOON_TV_VANISHING_BLOCK
    db   $70, $08, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $10, $05, $00, $00    ; ENTITY_TOON_TV_MOVING_BLOCK
    db   $70, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $0a, $04, $00, $00    ; ENTITY_TOON_TV_MOVING_LOG
    db   $00, $10, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $0c, $05, $00, $00    ; ENTITY_TOON_TV_STATIONARY_LOG
    db   $00, $0a, $08, COLLISION_TYPE_FALLING_HAZARD, $00, $06, $00, $00   ; ENTITY_TOON_TV_FLOWER_HAMMER
    db   $00, $10, $10, COLLISION_TYPE_TOUCH_DAMAGE, $0a, $06, $00, $00     ; ENTITY_TOON_TV_HUNTER_BULLET
    db   $00, $04, $08, COLLISION_TYPE_ROCKET, $34, $05, $00, $00           ; ENTITY_TOON_TV_ROCKET
    db   $00, $0c, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_PRE_HISTORY_FAST_DINOSAUR
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_PRE_HISTORY_DRAGONFLY
    db   $00, $08, $08, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_PRE_HISTORY_EGG
    db   $00, $08, $20, COLLISION_TYPE_GEYSER, $25, $07, $00, $00           ; ENTITY_UNK_35
    db   $00, $10, $10, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_PLATFORM, $11, $05, $00, $00    ; ENTITY_UNK_36
    db   $00, $04, $06, COLLISION_TYPE_TOUCH_DAMAGE, $12, $05, $00, $00     ; ENTITY_PRE_HISTORY_FALLING_LAVA
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $20, $04, $00, $00    ; ENTITY_PRE_HISTORY_LAVA_RAFT
    db   $70, $0c, $0b, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $20, $04, $00, $00    ; ENTITY_PRE_HISTORY_MOVING_PLATFORM
    db   $00, $10, $0c, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $20, $04, $00, $00    ; ENTITY_UNK_3A
    db   $00, $0c, $10, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $20, $04, $00, $00    ; ENTITY_UNK_3B
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_PRE_HISTORY_PTEROSAUR
    db   $00, $0c, $10, COLLISION_TYPE_FALLING_HAZARD, $13, $07, $00, $00   ; ENTITY_UNK_3D
    db   $40, $0c, $10, COLLISION_TYPE_FALLING_HAZARD, $13, $07, $00, $00   ; ENTITY_PRE_HISTORY_FALLING_BOULDER
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00             ; ENTITY_UNK_3F
    db   $00, $08, $08, COLLISION_TYPE_GENERIC_ENEMY, $1e, $07, $00, $00    ; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    db   $00, $08, $08, COLLISION_TYPE_GENERIC_ENEMY, $1e, $07, $00, $00    ; ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    db   $00, $08, $0c, COLLISION_TYPE_GENERIC_ENEMY, $1e, $07, $00, $00    ; ENTITY_PRE_HISTORY_ANT
    db   $00, $0c, $08, COLLISION_TYPE_GENERIC_ENEMY, $14, $05, $00, $00    ; ENTITY_PRE_HISTORY_FIRE_PLANT
    db   $00, $04, $04, COLLISION_TYPE_MULTI_PROJECTILE, $00, $04, $00, $00 ; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    db   $00, $08, $10, COLLISION_TYPE_GEYSER, $21, $07, $00, $00           ; ENTITY_PRE_HISTORY_GEYSER
    db   $00, $10, $0c, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $20, $04, $00, $00    ; ENTITY_UNK_46
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_PRE_HISTORY_DINOSAUR
    db   $00, $10, $10, COLLISION_TYPE_TRICERATOPS, $22, $07, $00, $00      ; ENTITY_PRE_HISTORY_TRICERATOPS
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00             ; ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00             ; ENTITY_UNK_4A
    db   $00, $10, $08, COLLISION_TYPE_HANGING_BLADE, $1a, $05, $00, $00    ; ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    db   $00, $10, $08, COLLISION_TYPE_CANNON, $18, $06, $00, $00           ; ENTITY_KUNG_FU_THEATER_CANNON
    db   $00, $08, $08, COLLISION_TYPE_NONE, $18, $06, $00, $00             ; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_KUNG_FU_THEATER_DRAGONFLY
    db   $70, $08, $08, COLLISION_TYPE_TOUCH_DAMAGE, $19, $07, $00, $00     ; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    db   $00, $0c, $0c, COLLISION_TYPE_TOUCH_DAMAGE, $00, $07, $00, $00     ; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    db   $00, $08, $0c, COLLISION_TYPE_TOUCH_DAMAGE, $1f, $07, $00, $00     ; ENTITY_UNK_51
    db   $00, $08, $08, COLLISION_TYPE_DRAGON_PROJECTILE, $19, $07, $00, $00 ; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    db   $40, $0a, $10, COLLISION_TYPE_NINJA, $18, $07, $00, $00            ; ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    db   $40, $0a, $10, COLLISION_TYPE_NINJA, $18, $07, $00, $00            ; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    db   $00, $0c, $10, COLLISION_TYPE_SAMURAI_BODY, $18, $07, $00, $00     ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    db   $00, $06, $06, COLLISION_TYPE_NONE, $00, $06, $00, $00             ; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    db   $00, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $17, $07, $00, $00    ; ENTITY_KUNG_FU_THEATER_LIZARD
    db   $00, $04, $04, COLLISION_TYPE_TOUCH_DAMAGE, $18, $06, $00, $00     ; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    db   $00, $10, $04, COLLISION_TYPE_TOUCH_DAMAGE, $1d, $04, $00, $00     ; ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    db   $00, $0c, $10, COLLISION_TYPE_JAR, $15, $04, $00, $00              ; ENTITY_KUNG_FU_THEATER_TALL_JAR
    db   $00, $0c, $10, COLLISION_TYPE_JAR, $16, $04, $00, $00              ; ENTITY_KUNG_FU_THEATER_JAR
    db   $00, $18, $08, COLLISION_TYPE_TOUCH_DAMAGE, $1b, $07, $00, $00     ; ENTITY_UNK_5C
    db   $00, $08, $20, COLLISION_TYPE_TOUCH_DAMAGE, $1b, $07, $00, $00     ; ENTITY_UNK_5D
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $1d, $04, $00, $00    ; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $1d, $04, $00, $00    ; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    db   $00, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $1c, $04, $00, $00    ; ENTITY_UNK_60
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $1c, $04, $00, $00    ; ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    db   $00, $10, $08, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_PLATFORM, $1c, $04, $00, $00   ; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $04, $00, $00             ; ENTITY_UNK_63
    db   $00, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $26, $04, $00, $00    ; ENTITY_UNK_64
    db   $70, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $26, $04, $00, $00    ; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    db   $70, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $26, $04, $00, $00    ; ENTITY_REZOPOLIS_MOVING_PLATFORM
    db   $00, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $26, $04, $00, $00    ; ENTITY_REZOPOLIS_RED_PLATFORM
    db   $00, $0c, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $26, $04, $00, $00    ; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    db   $00, $0c, $04, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $29, $05, $00, $00    ; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    db   $00, $0c, $08, COLLISION_TYPE_GEAR, $2a, $07, $00, $00             ; ENTITY_REZOPOLIS_TAILSPIN_GEAR
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00             ; ENTITY_UNK_6B
    db   $00, $08, $10, COLLISION_TYPE_TOUCH_DAMAGE, $27, $05, $00, $00     ; ENTITY_UNK_6C
    db   $00, $08, $20, COLLISION_TYPE_TOUCH_DAMAGE, $27, $05, $00, $00     ; ENTITY_UNK_6D
    db   $00, $10, $10, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_REZOPOLIS_GREEN_MONSTER
    db   $00, $00, $00, COLLISION_TYPE_NONE, $2b, $05, $00, $00             ; ENTITY_UNK_6F
    db   $00, $00, $00, COLLISION_TYPE_NONE, $2b, $05, $00, $00             ; ENTITY_UNK_70
    db   $40, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_REZOPOLIS_PINCER
    db   $00, $04, $10, COLLISION_TYPE_TOUCH_DAMAGE, $28, $07, $00, $00     ; ENTITY_REZOPOLIS_FLAMETHROWER
    db   $40, $10, $08, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_REZOPOLIS_UFO
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $38, $05, $00, $00    ; ENTITY_REZOPOLIS_ANT
    db   $40, $00, $00, COLLISION_TYPE_NONE, $00, $06, $00, $00             ; ENTITY_REZOPOLIS_ANT_SPAWNER
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $2c, $07, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_ANT
    db   $00, $08, $10, COLLISION_TYPE_GENERIC_ENEMY, $2d, $05, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    db   $60, $08, $08, COLLISION_TYPE_POWER_UP, $2e, $05, $00, $00         ; ENTITY_CIRCUIT_CENTRAL_POWER_UP
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $00, $00, $00             ; ENTITY_UNK_79
    db   $00, $0c, $08, COLLISION_TYPE_GENERIC_ENEMY, $2f, $07, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    db   $00, $00, $00, COLLISION_TYPE_NONE, $2f, $06, $00, $00             ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    db   $70, $08, $08, COLLISION_TYPE_ELECTRIC_BALL, $30, $05, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    db   $40, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $31, $04, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $31, $04, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    db   $00, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $31, $04, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    db   $00, $0c, $0c, COLLISION_TYPE_GENERIC_ENEMY, $00, $07, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    db   $40, $10, $10, COLLISION_TYPE_POWERED_WALKWAY, $00, $07, $00, $00  ; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    db   $40, $10, $08, COLLISION_TYPE_ONE_WAY_PLATFORM | COLLISION_TYPE_PLATFORM, $00, $07, $00, $00    ; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    db   $60, $08, $08, COLLISION_TYPE_NONE, $32, $05, $00, $00             ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    db   $60, $08, $08, COLLISION_TYPE_NONE, $32, $05, $00, $00             ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    db   $60, $08, $08, COLLISION_TYPE_NONE, $32, $05, $00, $00             ; ENTITY_CHANNEL_Z_GUN_PROJECTILE
    db   $10, $10, $10, COLLISION_TYPE_REZ, $00, $07, $00, $00              ; ENTITY_CHANNEL_Z_REZ
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $32, $04, $00, $00    ; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1
    db   $00, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $32, $04, $00, $00    ; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2
    db   $00, $08, $08, COLLISION_TYPE_NONE, $32, $06, $00, $00             ; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    db   $00, $08, $08, COLLISION_TYPE_TOUCH_DAMAGE, $32, $03, $00, $00     ; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    db   $00, $10, $10, COLLISION_TYPE_NONE, $37, $05, $00, $00             ; ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    db   $40, $08, $08, COLLISION_TYPE_STATIONARY_PLATFORM | COLLISION_TYPE_PLATFORM, $39, $04, $00, $00    ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    db   $00, $10, $10, COLLISION_TYPE_NONE, $00, $07, $00, $00             ; ENTITY_CHANNEL_Z_REZ_PORTAL
    db   $00, $00, $00, COLLISION_TYPE_NONE, $00, $07, $00, $00             ; ENTITY_UNK_8E
    db   $70, $10, $08, COLLISION_TYPE_MOVING_PLATFORM | COLLISION_TYPE_PLATFORM, $35, $05, $00, $00    ; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

call_0a_7a7c_EntitySpawn_SpawnNextFromList:
; Tries to place one entity, and is called once per frame. Bails out early and harmlessly in
; several ordinary situations, so most calls do nothing:
;
;   no free slot            all 7 NPC slots are occupied
;   list terminator ($FF)   rewind to the start of the list and stop for this frame
;   flag already set        this entry has been placed before, skip it
;   room not on screen      Entity_CheckIfOnScreen rejects it; the entry stays pending
;
; Note the cursor advances *before* those last two checks, so a rejected entry is not retried
; immediately - it comes back around on the next pass through the list.
;
; When an entry does survive, the slot is built from both sources: position and room bounds
; come from the list entry, while size, collision type, graphics and palette come from the
; type's record in data_0a_75fd_EntityAttributeTable. The record's mask byte decides where
; the entry's three free parameter bytes are stored. Finally facing is zeroed, action 0 is
; set, the tiles are queued and on GBC the palette is loaded
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
    ld   [wD339_SpawningSlotIndex], A                                    ;; 0a:7a93 $ea $39 $d3
    ld   HL, wD336_CurrentEntityToLoadPtr                                     ;; 0a:7a96 $21 $36 $d3
    ld   E, [HL]                                       ;; 0a:7a99 $5e
    inc  HL                                            ;; 0a:7a9a $23
    ld   D, [HL]                                       ;; 0a:7a9b $56
    ld   A, [DE]                                       ;; 0a:7a9c $1a ; load first byte from data
    cp   A, $ff                                        ;; 0a:7a9d $fe $ff
    jp   Z, call_0a_4000_EntityList_LoadForCurrentLevel                                 ;; 0a:7a9f $ca $00 $40
    ld   [wD33B_SpawningEntityId], A                                    ;; 0a:7aa2 $ea $3b $d3 ; first byte from data
    ld   HL, ENTITY_SPAWN_RECORD_SIZE                  ;; 0a:7aa5 $21 $10 $00
    add  HL, DE                                        ;; 0a:7aa8 $19
    ld   A, L                                          ;; 0a:7aa9 $7d
    ld   [wD336_CurrentEntityToLoadPtr], A                                    ;; 0a:7aaa $ea $36 $d3
    ld   A, H                                          ;; 0a:7aad $7c
    ld   [wD337_CurrentEntityToLoadPtr], A                                    ;; 0a:7aae $ea $37 $d3 ; load 2 bytes 0x10 after first
    ld   HL, wD338_EntityLoadingFlag                                     ;; 0a:7ab1 $21 $38 $d3 
    ld   C, [HL]                                       ;; 0a:7ab4 $4e 
    inc  [HL]                                          ;; 0a:7ab5 $34
    ld   B, $d0                                        ;; 0a:7ab6 $06 $d0
    ld   A, [BC]                                       ;; 0a:7ab8 $0a
    and  A, A                                          ;; 0a:7ab9 $a7
    ret  NZ                                            ;; 0a:7aba $c0
    ld   A, C                                          ;; 0a:7abb $79
    ld   [wD33A_SpawningListIndex], A                                    ;; 0a:7abc $ea $3a $d3
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
    ld   HL, wD339_SpawningSlotIndex                                     ;; 0a:7ad4 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7ad7 $6e
    ld   H, $00                                        ;; 0a:7ad8 $26 $00
    add  HL, HL                                        ;; 0a:7ada $29
    add  HL, HL                                        ;; 0a:7adb $29
    ld   BC, wD309_EntityBoundingBoxXMax               ;; 0a:7adc $01 $09 $d3 ; this is where bounding box is set
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
    FARCALL call_00_350c_Entity_CheckIfOnScreen
    pop  DE                                            ;; 0a:7af8 $d1
    ret  C                                             ;; 0a:7af9 $d8
    push DE                                            ;; 0a:7afa $d5
    LOAD_OBJ_FIELD_TO_DE_ALT ENTITY_FIELD_ENTITY_ID
    ld   A, [wD33B_SpawningEntityId]                                    ;; 0a:7b03 $fa $3b $d3
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
    ; Distribute the spawn record's parameter bytes. B is the type's SPAWN_PARAM_TO_* mask
    ; and HL walks the entry's parameter bytes; DE walks entity fields $18..$1F. Each field
    ; is zeroed first, then overwritten only if its mask bit is set - so HL advances once per
    ; set bit, not once per field
    ld   A, [BC]                                       ;; 0a:7b1b $0a
    inc  BC                                            ;; 0a:7b1c $03
    push BC                                            ;; 0a:7b1d $c5
    ld   B, A                                          ;; 0a:7b1e $47
    ld   C, $08                                        ;; 0a:7b1f $0e $08 ; fields $18..$1F
.jr_0a_7b21:
    xor  A, A                                          ;; 0a:7b21 $af
    ld   [DE], A                                       ;; 0a:7b22 $12
    bit  7, B                                          ;; 0a:7b23 $cb $78
    jr   Z, .jr_0a_7b29                                ;; 0a:7b25 $28 $02
    ld   A, [HL+]                                      ;; 0a:7b27 $2a
    ld   [DE], A                                       ;; 0a:7b28 $12
.jr_0a_7b29:
    inc  E                                             ;; 0a:7b29 $1c
    sla  B                                             ;; 0a:7b2a $cb $20 ; next mask bit
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
    ld   HL, wD339_SpawningSlotIndex                                     ;; 0a:7b46 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7b49 $6e
    ld   H, $00                                        ;; 0a:7b4a $26 $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities                                     ;; 0a:7b4c $11 $01 $d3
    add  HL, DE                                        ;; 0a:7b4f $19
    ld   A, [wD33A_SpawningListIndex]                                    ;; 0a:7b50 $fa $3a $d3
    ld   [HL], A                                       ;; 0a:7b53 $77
    ld   L, A                                          ;; 0a:7b54 $6f
    ld   H, $d0                                        ;; 0a:7b55 $26 $d0
    ld   [HL], $01                                     ;; 0a:7b57 $36 $01
    xor  A, A                                          ;; 0a:7b59 $af
    FARCALL call_02_7102_Entity_SetAction
    ld   HL, wD339_SpawningSlotIndex                                     ;; 0a:7b65 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7b68 $6e
    ld   H, $00                                        ;; 0a:7b69 $26 $00
    add  HL, HL                                        ;; 0a:7b6b $29
    add  HL, HL                                        ;; 0a:7b6c $29
    ld   DE, data_00_39c0_EntityEffectBuffers                                     ;; 0a:7b6d $11 $c0 $39
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
    FARCALL call_02_7211_EntityGfxQueue_Enqueue
.jr_0a_7b87:
    pop  HL                                            ;; 0a:7b87 $e1
    ld   A, [wD59E_OnGBCFlag]                                    ;; 0a:7b88 $fa $9e $d5
    and  A, A                                          ;; 0a:7b8b $a7
    ret  Z                                             ;; 0a:7b8c $c8
    ld   C, [HL]                                       ;; 0a:7b8d $4e
    FARCALL call_0b_5f57_Entity_LoadGBCPalette
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
    FARCALL call_02_7211_EntityGfxQueue_Enqueue
.jr_0a_7c43:
    pop  HL                                            ;; 0a:7c43 $e1
    ld   A, [wD59E_OnGBCFlag]                                    ;; 0a:7c44 $fa $9e $d5
    and  A, A                                          ;; 0a:7c47 $a7
    jr   Z, .jr_0a_7c56                                ;; 0a:7c48 $28 $0c
    ld   C, [HL]                                       ;; 0a:7c4a $4e
    FARCALL call_0b_5f57_Entity_LoadGBCPalette
.jr_0a_7c56:
    call call_00_34d8_Entity_ResetEntityListIndex                                  ;; 0a:7c56 $cd $d8 $34
    xor  A, A                                          ;; 0a:7c59 $af
    FARCALL call_02_7102_Entity_SetAction
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
    ld   DE, wD309_EntityBoundingBoxXMax                                     ;; 0a:7c73 $11 $09 $d3
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
    ld   BC, wD309_EntityBoundingBoxXMax                                     ;; 0a:7c82 $01 $09 $d3
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
    EntityChildSpawnData ENTITY_SCREAM_TV_HEAD_GHOST_HEAD,             $0006, -$000E
    EntityChildSpawnData ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE,   $0000, $000C
    EntityChildSpawnData ENTITY_SCREAM_TV_ZOMBIE_HEAD,                 $0000, -$0012
    EntityChildSpawnData ENTITY_TOON_TV_FLOWER_HAMMER,                -$000B, -$0004
    EntityChildSpawnData ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE,      $0008, $0000
    EntityChildSpawnData ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD,          $0000, -$0018
    EntityChildSpawnData ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES,    $0000, $0008
    EntityChildSpawnData ENTITY_PRE_HISTORY_TRICERATOPS_HORN,          $0014, $0000
    EntityChildSpawnData ENTITY_TOON_TV_MUSHROOM_PROJECTILE,           $0000, -$0008
    EntityChildSpawnData ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR,     $0000, $0010
    EntityChildSpawnData ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION,    $0000, $0000
    EntityChildSpawnData ENTITY_TOON_TV_HUNTER_BULLET,                 $0010, $0000
    EntityChildSpawnData ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE,     $0000, $0000
    EntityChildSpawnData ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE,     $0014, $0000
    EntityChildSpawnData ENTITY_REZOPOLIS_ANT,                         $0000, $0008
    EntityChildSpawnData ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE,        $004C, -$0098
    EntityChildSpawnData ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE,       -$004C, -$0098
    EntityChildSpawnData ENTITY_CHANNEL_Z_REZ_PORTAL,                  $0000, $0000
