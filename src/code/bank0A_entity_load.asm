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
; position in the list. The test below is "and A / ret NZ", so any non-zero
; value blocks placement: ENTITY_LIST_FLAG_PLACED while the entity is live, and
; ENTITY_LIST_FLAG_NEVER_AGAIN once it has been defeated or collected.
; call_00_3910_Entity_ClearSlot clears the first back to ABSENT when a slot is
; recycled but refuses to touch the second, which is what makes a defeated enemy
; stay defeated while you are still in the room.
; ==================================================================

call_0a_4000_EntityList_LoadForCurrentLevel:
; Points the spawn cursor at the start of the current level's entity list.
; Also called mid-level by SpawnNextFromList when it hits the list terminator,
; which is what makes the walk cyclic rather than one-shot
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]                                       ; L = current level
    ld   H, $00
    add  HL, HL                                        ; multiply by 2?
    ld   DE, .data_0a_4019
    add  HL, DE
    ld   A, [HL+]
    ld   [wD336_CurrentEntityToLoadPtr], A
    ld   A, [HL+]
    ld   [wD337_CurrentEntityToLoadPtr], A
    ld   A, $01
    ld   [wD338_EntityLoadingFlag], A
    ret
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
.data_MediaDimension_entity_list:
    INCBIN "data/maps/media_dimension/entity_list_media_dimension.bin"
.data_OutOfToon_entity_list:
    INCBIN "data/maps/toon_tv/entity_list_out_of_toon.bin"
.data_Smellraiser_entity_list:
    INCBIN "data/maps/scream_tv/entity_list_smellraiser.bin"
.data_Frankensteinfeld_entity_list:
    INCBIN "data/maps/scream_tv/entity_list_frankensteinfeld.bin"
.data_wwwdotcomcom_entity_list:
    INCBIN "data/maps/circuit_central/entity_list_wwwdotcomcom.bin"
.data_MaoTseTongue_entity_list:
    INCBIN "data/maps/kung_fu_theater/entity_list_mao_tse_tongue.bin"
.data_Pangaea90210_entity_list:
    INCBIN "data/maps/prehistory_channel/entity_list_pangaea_90210.bin"
.data_FineTooning_entity_list:
    INCBIN "data/maps/toon_tv/entity_list_fine_tooning.bin"
.data_ThisOldCave_entity_list:
    INCBIN "data/maps/prehistory_channel/entity_list_this_old_cave.bin"
.data_HoneyIShrunkTheGecko_entity_list:
    INCBIN "data/maps/circuit_central/entity_list_honey_i_shrunk_the_gecko.bin"
.data_Poltergex_entity_list:
    INCBIN "data/maps/scream_tv/entity_list_poltergex.bin"
.data_SamuraiNightFever_entity_list:
    INCBIN "data/maps/kung_fu_theater/entity_list_samurai_night_fever.bin"
.data_NoWeddingsAndAFuneral_entity_list:
    INCBIN "data/maps/rezopolis/entity_list_no_weddings_and_a_funeral.bin"
.data_ThursdayThe12th_entity_list:
    INCBIN "data/maps/scream_tv/entity_list_thursday_the_12th.bin"
.data_LizardInAChinaShop_entity_list:
    INCBIN "data/maps/kung_fu_theater/entity_list_lizard_in_a_china_shop.bin"
.data_BuggedOut_entity_list:
    INCBIN "data/maps/rezopolis/entity_list_bugged_out.bin"
.data_ChipsAndDips_entity_list:
    INCBIN "data/maps/circuit_central/entity_list_chips_and_dips.bin"
.data_LavaDabbaDoo_entity_list:
    INCBIN "data/maps/prehistory_channel/entity_list_lava_dabba_doo.bin"
.data_TexasChainsawManicure_entity_list:
    INCBIN "data/maps/scream_tv/entity_list_texas_chainsaw_manicure.bin"
.data_MazedAndConfused_entity_list:
    INCBIN "data/maps/rezopolis/entity_list_mazed_and_confused.bin"
.data_ChannelZ_entity_list:
    INCBIN "data/maps/channel_z/entity_list_channel_z.bin"

data_0a_75fc:
; Byte 0 of ENTITY_GEX's record. The spawn code indexes from *here*, not from the label
; below, so every record is 8 bytes starting at data_0a_75fc + id*8 - which is why the Gex
; row below is one byte short and every later row appears shifted by one
    db   $00
data_0a_75fd_EntityAttributeTable:
; The per-entity-type template applied to a slot when it spawns. 144 records, 8 bytes per
; entity id:
;
;   +0  spawn parameter mask (see below)
;   +1  ENTITY_FIELD_COLLISION_WIDTH
;   +2  ENTITY_FIELD_COLLISION_HEIGHT
;   +3  ENTITY_FIELD_COLLISION_TYPE
;   +4  graphics set id, queued through call_02_7211_EntityGfxQueue_Enqueue ($00 = none)
;   +5  GBC palette id, loaded through call_0b_5f57_Entity_LoadGBCPalette
;   +6  never read
;   +7  never read
;
; TWO READERS, AT TWO DIFFERENT BASES. The spawn-parameter pass indexes from
; data_0a_75fc and takes byte +0. The attribute copy that follows it indexes from
; data_0a_75fd - one byte higher - and walks +1 through +5 in order: three bytes straight
; into the slot's collision fields, then the graphics id, then the palette. Nothing ever
; reads past +5, and bytes +6 and +7 are $00 in all 144 records.
;
; Bytes +4/+5 are the same pair as data_02_743c_EntityGfxAndPaletteTable, which serves
; entities that are already live where this one serves them at spawn. The two agree on
; all 144 entity ids, so neither can be edited on its own.
;
; THE MASK is the interesting field. A level's entity list carries three free parameter
; bytes per entry (ENTITY_SPAWN_PARAMETER*_OFFSET), and the mask decides which of the eight
; entity fields $18..$1F they land in - bit 7 for $18 through bit 0 for $1F. Any field whose
; bit is clear is zeroed instead, and the parameter cursor only advances on a set bit, so
; the mask's population count is also how many of the three bytes the type consumes. That is
; how one spawn record format configures a moving platform's velocity and a timer-driven
; hazard's countdown without either knowing about the other.
;
; Eight mask values occur, spelled with SPAWN_PARAM_TO_* from constants.asm:
;
;   $00  101 types  no parameters - the three bytes in the entity list are ignored
;   $70   18 types  TIMER_2 | MISC_PARAM | MISC_PARAM_HI - all three general-purpose slots
;   $40   13 types  TIMER_2
;   $60    4 types  TIMER_2 | MISC_PARAM
;   $50    3 types  TIMER_2 | MISC_PARAM_HI
;   $10    2 types  MISC_PARAM_HI
;   $28    1 type   MISC_PARAM | XVEL
;   $88    1 type   MISC_TIMER | XVEL
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
    ld   H, $d2
    ld   A, $20
.jr_0a_7a80:
    ld   L, A                                          ; L = 0x20
    ld   A, [HL]                                       ; load from $d2xx, start at $d220
    cp   A, $ff                                        ; if loaded value is ff, then jump
    jr   Z, .jr_0a_7a8c
    ld   A, L
    add  A, $20
    jr   NZ, .jr_0a_7a80
    ret
.jr_0a_7a8c: ; jump here if the value was 0xff. so basically it is looping through 7 sets of 32 bytes looking for a free slot (ff)
    ld   A, L
    ld   [wD300_CurrentEntityAddrLo], A                                    ; so d300 is the address of the ff byte it found
    rlca
    rlca
    rlca
    ld   [wD339_SpawningSlotIndex], A
    ld   HL, wD336_CurrentEntityToLoadPtr
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   A, [DE]                                       ; load first byte from data
    cp   A, $ff
    jp   Z, call_0a_4000_EntityList_LoadForCurrentLevel
    ld   [wD33B_SpawningEntityId], A                                    ; first byte from data
    ld   HL, ENTITY_SPAWN_RECORD_SIZE
    add  HL, DE
    ld   A, L
    ld   [wD336_CurrentEntityToLoadPtr], A
    ld   A, H
    ld   [wD337_CurrentEntityToLoadPtr], A                                    ; load 2 bytes 0x10 after first
    ld   HL, wD338_EntityLoadingFlag
    ld   C, [HL]
    inc  [HL]
    ld   B, $d0
    ld   A, [BC]
    and  A, A
    ret  NZ
    ld   A, C
    ld   [wD33A_SpawningListIndex], A
    inc  DE
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   A, [DE]
    ld   [HL+], A                                      ; this is where the x and y coords of the entity are read and written
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL], A
    inc  DE
    ld   HL, wD339_SpawningSlotIndex
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   BC, wD309_EntityBoundingBoxXMax               ; this is where bounding box is set
    add  HL, BC
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    push DE
    FARCALL call_00_350c_Entity_CheckIfOnScreen
    pop  DE
    ret  C
    push DE
    LOAD_OBJ_FIELD_TO_DE_ALT ENTITY_FIELD_ENTITY_ID
    ld   A, [wD33B_SpawningEntityId]
    ld   [DE], A
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   BC, data_0a_75fc
    add  HL, BC
    ld   C, L
    ld   B, H
    pop  HL
    ld   A, E
    xor  A, $17
    ld   E, A
    xor  A, A
    ld   [DE], A
    inc  E
    ; Distribute the spawn record's parameter bytes. B is the type's SPAWN_PARAM_TO_* mask
    ; and HL walks the entry's parameter bytes; DE walks entity fields $18..$1F. Each field
    ; is zeroed first, then overwritten only if its mask bit is set - so HL advances once per
    ; set bit, not once per field
    ld   A, [BC]
    inc  BC
    push BC
    ld   B, A
    ld   C, $08                                        ; fields $18..$1F
.jr_0a_7b21:
    xor  A, A
    ld   [DE], A
    bit  7, B
    jr   Z, .jr_0a_7b29
    ld   A, [HL+]
    ld   [DE], A
.jr_0a_7b29:
    inc  E
    sla  B                                             ; next mask bit
    dec  C
    jr   NZ, .jr_0a_7b21
    ld   A, [wD300_CurrentEntityAddrLo]
    or   A, $14
    ld   E, A
    pop  HL
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    push HL
    ld   A, E
    xor  A, $1b
    ld   E, A
    ld   A, $00
    ld   [DE], A                                       ; sets instance+0x0D facing angle to 0 by default
    ld   HL, wD339_SpawningSlotIndex
    ld   L, [HL]
    ld   H, $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   A, [wD33A_SpawningListIndex]
    ld   [HL], A
    ld   L, A
    ld   H, HIGH(wD000_EntityFlags)
    ld   [HL], ENTITY_LIST_FLAG_PLACED
    xor  A, A
    FARCALL call_02_7102_Entity_SetAction
    ld   HL, wD339_SpawningSlotIndex
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   DE, data_00_39c0_EntityEffectBuffers
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   [HL], $00
    pop  HL
    ld   A, [HL+]
    push HL
    and  A, A
    jr   Z, .jr_0a_7b87
    FARCALL call_02_7211_EntityGfxQueue_Enqueue
.jr_0a_7b87:
    pop  HL
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ret  Z
    ld   C, [HL]
    FARCALL call_0b_5f57_Entity_LoadGBCPalette
    ret

call_0a_7b9a_EntitySpawn_SpawnChildEntity:
; Finds a free NPC slot, then copies position fields from the calling entity into the new slot
; (preserving the parent's wD300 address around the operation), applies a signed X or Y offset
; from .data_0a_7c92_EntityChildSpawnData based on child entity type (add or subtract depending
; on a direction flag), copies collision/size attributes from data_0a_75fd_EntityAttributeTable, calls the init farCall,
; clears the slot counter, sets action 0, and copies room bounds from the parent's slot into the child's slot
    ld   D, $d2
    ld   A, $20
.jr_0a_7b9e:
    ld   E, A
    ld   A, [DE]
    cp   A, $ff
    jr   Z, .jr_0a_7baa
    ld   A, E
    add  A, $20
    jr   NZ, .jr_0a_7b9e
    ret
.jr_0a_7baa:
    ld   HL, wD300_CurrentEntityAddrLo
    ld   A, [HL]
    ld   [HL], E
    push AF
    ld   H, $d2
    or   A, $0e
    ld   L, A
    ld   D, H
    ld   A, E
    or   A, $0e
    ld   E, A
    push BC
    ld   B, H
    xor  A, $16
    ld   C, A
.jr_0a_7bbf:
    ld   A, [HL+]
    ld   [DE], A
    ld   [BC], A
    inc  E
    inc  C
    ld   A, L
    and  A, $1f
    cp   A, $12
    jr   NZ, .jr_0a_7bbf
    xor  A, A
    ld   [BC], A
    inc  C
    ld   [BC], A
    inc  C
    ld   [BC], A
    inc  C
    ld   [BC], A
    pop  BC
    ld   A, L
    xor  A, $1f
    ld   L, A
    ld   A, E
    xor  A, $1f
    ld   E, A
    ld   A, [HL]
    ld   [DE], A
    push AF
    ld   L, C
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   BC, .data_0a_7c92_EntityChildSpawnData
    add  HL, BC
    ld   A, E
    xor  A, $0d
    ld   E, A
    ld   A, [HL+]
    ld   [DE], A
    ld   C, A
    ld   A, E
    xor  A, $0e
    ld   E, A
    pop  AF
    cp   A, $00
    jr   NZ, .jr_0a_7c05
    ld   A, [DE]
    add  A, [HL]
    ld   [DE], A
    inc  HL
    inc  DE
    ld   A, [DE]
    adc  A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
    jr   .jr_0a_7c0f
.jr_0a_7c05:
    ld   A, [DE]
    sub  A, [HL]
    ld   [DE], A
    inc  HL
    inc  DE
    ld   A, [DE]
    sbc  A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
.jr_0a_7c0f:
    ld   A, [DE]
    add  A, [HL]
    ld   [DE], A
    inc  HL
    inc  DE
    ld   A, [DE]
    adc  A, [HL]
    ld   [DE], A
    ld   A, E
    xor  A, $05
    ld   E, A
    ld   L, C
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   BC, data_0a_75fd_EntityAttributeTable
    add  HL, BC
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    ld   A, E
    xor  A, $08
    ld   E, A
    xor  A, A
    ld   [DE], A
    ld   A, [HL+]
    push HL
    and  A, A
    jr   Z, .jr_0a_7c43
    FARCALL call_02_7211_EntityGfxQueue_Enqueue
.jr_0a_7c43:
    pop  HL
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jr   Z, .jr_0a_7c56
    ld   C, [HL]
    FARCALL call_0b_5f57_Entity_LoadGBCPalette
.jr_0a_7c56:
    call call_00_34d8_Entity_ResetEntityListIndex
    xor  A, A
    FARCALL call_02_7102_Entity_SetAction
    pop  AF
    ld   HL, wD300_CurrentEntityAddrLo
    ld   C, [HL]
    ld   [HL], A
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   DE, wD309_EntityBoundingBoxXMax
    add  HL, DE
    ld   E, L
    ld   D, H
    ld   A, C
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   BC, wD309_EntityBoundingBoxXMax
    add  HL, BC
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL], A
    ret
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
