; ==================================================================
; PLAYER SPAWN POSITIONS
;
; Where the player is put down when a map is (re)loaded. Called once, from
; bank00_home.asm, right before the blockmap is drawn and the entities are spawned.
;
; Everything in this bank is in BLOCK coordinates - the same grid the blockmap is
; laid out in, 128 x 128 blocks per level (a $4000 byte blockmap indexed
; y * 128 + x). One block is SPAWN_UNITS_PER_BLOCK units of player world position,
; so converting a table entry to a position is block * $20 plus a small offset,
; and recovering a block from a position is a shift the other way.
;
; Three tables, one per way of arriving somewhere:
;
;   .data_0b_4ff2_LevelDoorLists         walked into a door within the level
;   .data_0b_5401_MediaDimensionSpawnPoints  came back out of a TV into the hub
;   .data_0b_543f_LevelCheckpointSpawns  started the level, or died and respawned
;
; The three cases use different Y offsets ($10, $30, $10) and different X offsets
; ($20, $20, $10), which is the only reason the conversion is written out three
; times instead of once.
; ==================================================================

call_0b_4efe_Player_SetSpawnPosition:
; Positions the player for the map about to be loaded, then scrolls the camera to
; match. Picks one of three sources, in priority order:
;
;   1. WARP_FLAG_ENTERED_DOOR set - the player walked into a door. The flag is
;      cleared, the player's current position is converted back to a block, and that
;      block is looked up in this level's door list to find where the door leads.
;      Note the X conversion subtracts DOOR_MATCH_X_BIAS first while Y does not, so
;      the match is taken from a point half a block left of the player's origin;
;      a door therefore triggers from a slightly different spot than its own block
;      would suggest.
;      If no record matches, the routine RETURNS WITHOUT MOVING THE PLAYER - the
;      door silently does nothing rather than warping anywhere wrong.
;   2. level 0 - back in the Media Dimension. wD628_MediaDimensionRespawnPoint says
;      which TV was just exited; that indexes the hub spawn table.
;   3. anything else - a level start or a checkpoint respawn, from
;      .data_0b_543f_LevelCheckpointSpawns at level * 8 + checkpoint * 2.
;
; All three end in the same jump to call_00_13a6_BgMap_UpdateWindowFromPlayerPos,
; which is what makes the camera follow rather than tearing on the first frame
    ld   HL, wD621_WarpFlags
    ld   A, [HL]
    and  A, WARP_FLAG_ENTERED_DOOR
    jr   Z, .jr_0b_4f70_NotADoor
    ld   A, [HL]
    and  A, $ff ^ WARP_FLAG_ENTERED_DOOR
    ld   [HL], A
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, -DOOR_MATCH_X_BIAS
    add  HL, DE
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   C, H                                          ; C = block X: (x - bias) * 8 >> 8
    ld   HL, wD210_Player_YPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   B, H                                          ; B = block Y, no bias
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_0b_4ff2_LevelDoorLists
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, DOOR_RECORD_SIZE - 1                      ; the first byte is already consumed
.jr_0b_4f33_SearchDoors:
    ld   A, [HL+]
    cp   A, SPAWN_LIST_END
    ret  Z                                             ; end of list: leave the player where they are
    cp   A, C
    jr   NZ, .jr_0b_4f3e_NextDoor
    ld   A, [HL]
    cp   A, B
    jr   Z, .jr_0b_4f41_DoorFound
.jr_0b_4f3e_NextDoor:
    add  HL, DE
    jr   .jr_0b_4f33_SearchDoors
.jr_0b_4f41_DoorFound:
    inc  HL
    ld   C, [HL]
    inc  HL
    ld   B, [HL]
    ld   L, C
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, SPAWN_DOOR_X_OFFSET
    add  HL, DE
    ld   A, L
    ld   [wD20E_Player_XPositionLo], A
    ld   A, H
    ld   [wD20F_Player_XPositionHi], A
    ld   L, B
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, SPAWN_DOOR_Y_OFFSET
    add  HL, DE
    ld   A, L
    ld   [wD210_Player_YPositionLo], A
    ld   A, H
    ld   [wD211_Player_YPositionHi], A
    jp   call_00_13a6_BgMap_UpdateWindowFromPlayerPos
.jr_0b_4f70_NotADoor:
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    jr   NZ, .jr_0b_4faf_LevelSpawn
    ld   HL, wD628_MediaDimensionRespawnPoint
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_0b_5401_MediaDimensionSpawnPoints
    add  HL, DE
    ld   C, [HL]
    inc  HL
    ld   B, [HL]
    ld   L, C
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, SPAWN_HUB_X_OFFSET
    add  HL, DE
    ld   A, L
    ld   [wD20E_Player_XPositionLo], A
    ld   A, H
    ld   [wD20F_Player_XPositionHi], A
    ld   L, B
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, SPAWN_HUB_Y_OFFSET
    add  HL, DE
    ld   A, L
    ld   [wD210_Player_YPositionLo], A
    ld   A, H
    ld   [wD211_Player_YPositionHi], A
    jp   call_00_13a6_BgMap_UpdateWindowFromPlayerPos
.jr_0b_4faf_LevelSpawn:
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, [wD618_CheckpointSpawnId]
    add  A, A
    ld   E, A
    ld   D, $00
    add  HL, DE
    ld   DE, .data_0b_543f_LevelCheckpointSpawns
    add  HL, DE
    ld   C, [HL]
    inc  HL
    ld   B, [HL]
    ld   L, C
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, SPAWN_LEVEL_X_OFFSET
    add  HL, DE
    ld   A, L
    ld   [wD20E_Player_XPositionLo], A
    ld   A, H
    ld   [wD20F_Player_XPositionHi], A
    ld   L, B
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, SPAWN_LEVEL_Y_OFFSET
    add  HL, DE
    ld   A, L
    ld   [wD210_Player_YPositionLo], A
    ld   A, H
    ld   [wD211_Player_YPositionHi], A
    jp   call_00_13a6_BgMap_UpdateWindowFromPlayerPos
.data_0b_4ff2_LevelDoorLists:
; One pointer per level to that level's door list. Levels with no doors of their own
; point at the Media Dimension list, which is harmless because a door only fires when
; the player is standing on its exact block - and those levels have no block that
; matches. Four real levels do this (This Old Cave, Lizard in a China Shop, Bugged Out,
; Chips and Dips) alongside the ten unused slots
    dw   .data_0b_5030_Doors_MediaDimension                     ; $00 MAP_MEDIA_DIMENSION
    dw   .data_0b_5051_Doors_OutOfToon                          ; $01 MAP_TOON_TV_OUT_OF_TOON
    dw   .data_0b_5066_Doors_Smellraiser                        ; $02 MAP_SCREAM_TV_SMELLRAISER
    dw   .data_0b_5097_Doors_Frankensteinfeld                   ; $03 MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .data_0b_50e0_Doors_WwwDotcomCom                       ; $04 MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .data_0b_5111_Doors_MaoTseTongue                       ; $05 MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .data_0b_5030_Doors_MediaDimension                     ; $06 MAP_UNUSED_06
    dw   .data_0b_5182_Doors_Pangaea90210                       ; $07 MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .data_0b_519b_Doors_FineTooning                        ; $08 MAP_TOON_TV_FINE_TOONING
    dw   .data_0b_5030_Doors_MediaDimension                     ; $09 MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .data_0b_51ac_Doors_HoneyIShrunkTheGecko               ; $0a MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .data_0b_51ed_Doors_Poltergex                          ; $0b MAP_SCREAM_TV_POLTERGEX
    dw   .data_0b_5030_Doors_MediaDimension                     ; $0c MAP_UNUSED_0C
    dw   .data_0b_5266_Doors_SamuraiNightFever                  ; $0d MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .data_0b_5293_Doors_NoWeddingsAndAFuneral              ; $0e MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .data_0b_5030_Doors_MediaDimension                     ; $0f MAP_UNUSED_0F
    dw   .data_0b_52d4_Doors_ThursdayThe12th                    ; $10 MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .data_0b_5030_Doors_MediaDimension                     ; $11 MAP_UNUSED_11
    dw   .data_0b_5030_Doors_MediaDimension                     ; $12 MAP_UNUSED_12
    dw   .data_0b_5030_Doors_MediaDimension                     ; $13 MAP_UNUSED_13
    dw   .data_0b_5030_Doors_MediaDimension                     ; $14 MAP_UNUSED_14
    dw   .data_0b_5030_Doors_MediaDimension                     ; $15 MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .data_0b_5030_Doors_MediaDimension                     ; $16 MAP_REZOPOLIS_BUGGED_OUT
    dw   .data_0b_5030_Doors_MediaDimension                     ; $17 MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .data_0b_5389_Doors_LavaDabbaDoo                       ; $18 MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .data_0b_53c2_Doors_TexasChainsawManicure              ; $19 MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .data_0b_53f3_Doors_MazedAndConfused                   ; $1a MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .data_0b_5030_Doors_MediaDimension                     ; $1b MAP_UNUSED_1B
    dw   .data_0b_5030_Doors_MediaDimension                     ; $1c MAP_UNUSED_1C
    dw   .data_0b_5030_Doors_MediaDimension                     ; $1d MAP_UNUSED_1D
    dw   .data_0b_53fc_Doors_ChannelZ                           ; $1e MAP_BOSS_TV_CHANNEL_Z

; Door lists. Each is a run of DOOR_RECORD_SIZE-byte records -
;   from block X, from block Y, to block X, to block Y
; - ending in SPAWN_LIST_END. The search is linear and takes the first match, but no
; list has two records with the same source block, so the order never matters.
;
; A record is one-directional. Most come in pairs, a record and its exact reverse,
; which is what makes a door walkable both ways: 202 of the 240 records in this bank
; pair up. The "#n <-> #m" comments name each record's partner; the ones marked
; one-way have no return trip and drop the player somewhere they cannot walk back
; from. Thursday the 12th is the extreme case - 35 of its 45 doors are one-way, which
; is how a level whose mission is "find the items in the given time" is built as a
; maze out of nothing but door records.

.data_0b_5030_Doors_MediaDimension:
; MediaDimension - 8 door(s)
    ;    from        to
    db   $25, $0e,  $07, $17                                    ; #0 <-> #4
    db   $1b, $17,  $07, $24                                    ; #1 <-> #5
    db   $2f, $17,  $07, $4d                                    ; #2 <-> #6
    db   $43, $17,  $27, $3a                                    ; #3 <-> #7
    db   $07, $17,  $25, $0e                                    ; #4 <-> #0
    db   $07, $24,  $1b, $17                                    ; #5 <-> #1
    db   $07, $4d,  $2f, $17                                    ; #6 <-> #2
    db   $27, $3a,  $43, $17                                    ; #7 <-> #3
    db   SPAWN_LIST_END

.data_0b_5051_Doors_OutOfToon:
; OutOfToon - 5 door(s), 1 one-way
    ;    from        to
    db   $41, $03,  $03, $28                                    ; #0 <-> #3
    db   $6a, $1d,  $03, $3c                                    ; #1 <-> #4
    db   $49, $36,  $52, $3e                                    ; #2 one-way
    db   $03, $28,  $41, $03                                    ; #3 <-> #0
    db   $03, $3c,  $6a, $1d                                    ; #4 <-> #1
    db   SPAWN_LIST_END

.data_0b_5066_Doors_Smellraiser:
; Smellraiser - 12 door(s)
    ;    from        to
    db   $19, $07,  $23, $09                                    ; #0 <-> #6
    db   $34, $06,  $3f, $06                                    ; #1 <-> #7
    db   $47, $02,  $02, $12                                    ; #2 <-> #8
    db   $2d, $10,  $37, $15                                    ; #3 <-> #9
    db   $3a, $0f,  $02, $1b                                    ; #4 <-> #10
    db   $3e, $0f,  $28, $21                                    ; #5 <-> #11
    db   $23, $09,  $19, $07                                    ; #6 <-> #0
    db   $3f, $06,  $34, $06                                    ; #7 <-> #1
    db   $02, $12,  $47, $02                                    ; #8 <-> #2
    db   $37, $15,  $2d, $10                                    ; #9 <-> #3
    db   $02, $1b,  $3a, $0f                                    ; #10 <-> #4
    db   $28, $21,  $3e, $0f                                    ; #11 <-> #5
    db   SPAWN_LIST_END

.data_0b_5097_Doors_Frankensteinfeld:
; Frankensteinfeld - 18 door(s)
    ;    from        to
    db   $16, $33,  $1d, $31                                    ; #0 <-> #9
    db   $23, $31,  $2e, $30                                    ; #1 <-> #10
    db   $27, $31,  $24, $62                                    ; #2 <-> #11
    db   $43, $2a,  $4d, $2d                                    ; #3 <-> #12
    db   $4c, $32,  $02, $42                                    ; #4 <-> #13
    db   $50, $2b,  $0a, $3b                                    ; #5 <-> #14
    db   $1e, $41,  $08, $57                                    ; #6 <-> #15
    db   $71, $28,  $12, $3f                                    ; #7 <-> #16
    db   $76, $46,  $28, $3f                                    ; #8 <-> #17
    db   $1d, $31,  $16, $33                                    ; #9 <-> #0
    db   $2e, $30,  $23, $31                                    ; #10 <-> #1
    db   $24, $62,  $27, $31                                    ; #11 <-> #2
    db   $4d, $2d,  $43, $2a                                    ; #12 <-> #3
    db   $02, $42,  $4c, $32                                    ; #13 <-> #4
    db   $0a, $3b,  $50, $2b                                    ; #14 <-> #5
    db   $08, $57,  $1e, $41                                    ; #15 <-> #6
    db   $12, $3f,  $71, $28                                    ; #16 <-> #7
    db   $28, $3f,  $76, $46                                    ; #17 <-> #8
    db   SPAWN_LIST_END

.data_0b_50e0_Doors_WwwDotcomCom:
; WwwDotcomCom - 12 door(s)
    ;    from        to
    db   $0b, $06,  $2b, $09                                    ; #0 <-> #6
    db   $13, $07,  $1d, $21                                    ; #1 <-> #7
    db   $7c, $0a,  $04, $42                                    ; #2 <-> #8
    db   $7c, $21,  $1d, $2f                                    ; #3 <-> #9
    db   $65, $2f,  $1c, $43                                    ; #4 <-> #10
    db   $3d, $41,  $46, $42                                    ; #5 <-> #11
    db   $2b, $09,  $0b, $06                                    ; #6 <-> #0
    db   $1d, $21,  $13, $07                                    ; #7 <-> #1
    db   $04, $42,  $7c, $0a                                    ; #8 <-> #2
    db   $1d, $2f,  $7c, $21                                    ; #9 <-> #3
    db   $1c, $43,  $65, $2f                                    ; #10 <-> #4
    db   $46, $42,  $3d, $41                                    ; #11 <-> #5
    db   SPAWN_LIST_END

.data_0b_5111_Doors_MaoTseTongue:
; MaoTseTongue - 28 door(s)
    ;    from        to
    db   $09, $1d,  $2b, $06                                    ; #0 <-> #14
    db   $40, $05,  $09, $19                                    ; #1 <-> #15
    db   $16, $19,  $48, $05                                    ; #2 <-> #16
    db   $4d, $05,  $40, $12                                    ; #3 <-> #17
    db   $52, $0e,  $09, $15                                    ; #4 <-> #18
    db   $19, $15,  $5f, $1f                                    ; #5 <-> #19
    db   $68, $10,  $09, $0d                                    ; #6 <-> #20
    db   $18, $11,  $07, $35                                    ; #7 <-> #21
    db   $07, $2a,  $2b, $2c                                    ; #8 <-> #22
    db   $19, $1d,  $28, $35                                    ; #9 <-> #23
    db   $2c, $35,  $35, $28                                    ; #10 <-> #24
    db   $35, $22,  $39, $3a                                    ; #11 <-> #25
    db   $4b, $34,  $5e, $35                                    ; #12 <-> #26
    db   $6a, $35,  $5c, $45                                    ; #13 <-> #27
    db   $2b, $06,  $09, $1d                                    ; #14 <-> #0
    db   $09, $19,  $40, $05                                    ; #15 <-> #1
    db   $48, $05,  $16, $19                                    ; #16 <-> #2
    db   $40, $12,  $4d, $05                                    ; #17 <-> #3
    db   $09, $15,  $52, $0e                                    ; #18 <-> #4
    db   $5f, $1f,  $19, $15                                    ; #19 <-> #5
    db   $09, $0d,  $68, $10                                    ; #20 <-> #6
    db   $07, $35,  $18, $11                                    ; #21 <-> #7
    db   $2b, $2c,  $07, $2a                                    ; #22 <-> #8
    db   $28, $35,  $19, $1d                                    ; #23 <-> #9
    db   $35, $28,  $2c, $35                                    ; #24 <-> #10
    db   $39, $3a,  $35, $22                                    ; #25 <-> #11
    db   $5e, $35,  $4b, $34                                    ; #26 <-> #12
    db   $5c, $45,  $6a, $35                                    ; #27 <-> #13
    db   SPAWN_LIST_END

.data_0b_5182_Doors_Pangaea90210:
; Pangaea90210 - 6 door(s)
    ;    from        to
    db   $57, $03,  $5a, $3b                                    ; #0 <-> #1
    db   $5a, $3b,  $57, $03                                    ; #1 <-> #0
    db   $7c, $03,  $03, $37                                    ; #2 <-> #4
    db   $7b, $12,  $03, $46                                    ; #3 <-> #5
    db   $03, $37,  $7c, $03                                    ; #4 <-> #2
    db   $03, $46,  $7b, $12                                    ; #5 <-> #3
    db   SPAWN_LIST_END

.data_0b_519b_Doors_FineTooning:
; FineTooning - 4 door(s)
    ;    from        to
    db   $17, $44,  $4a, $7d                                    ; #0 <-> #1
    db   $4a, $7d,  $17, $44                                    ; #1 <-> #0
    db   $31, $4b,  $3f, $65                                    ; #2 <-> #3
    db   $3f, $65,  $31, $4b                                    ; #3 <-> #2
    db   SPAWN_LIST_END

.data_0b_51ac_Doors_HoneyIShrunkTheGecko:
; HoneyIShrunkTheGecko - 16 door(s)
    ;    from        to
    db   $04, $0e,  $26, $1b                                    ; #0 <-> #8
    db   $36, $0e,  $4f, $34                                    ; #1 <-> #9
    db   $4f, $2f,  $41, $34                                    ; #2 <-> #10
    db   $43, $27,  $64, $21                                    ; #3 <-> #11
    db   $47, $21,  $0d, $6c                                    ; #4 <-> #12
    db   $58, $11,  $62, $13                                    ; #5 <-> #13
    db   $79, $25,  $04, $41                                    ; #6 <-> #14
    db   $63, $41,  $69, $51                                    ; #7 <-> #15
    db   $26, $1b,  $04, $0e                                    ; #8 <-> #0
    db   $4f, $34,  $36, $0e                                    ; #9 <-> #1
    db   $41, $34,  $4f, $2f                                    ; #10 <-> #2
    db   $64, $21,  $43, $27                                    ; #11 <-> #3
    db   $0d, $6c,  $47, $21                                    ; #12 <-> #4
    db   $62, $13,  $58, $11                                    ; #13 <-> #5
    db   $04, $41,  $79, $25                                    ; #14 <-> #6
    db   $69, $51,  $63, $41                                    ; #15 <-> #7
    db   SPAWN_LIST_END

.data_0b_51ed_Doors_Poltergex:
; Poltergex - 30 door(s)
    ;    from        to
    db   $59, $35,  $03, $4d                                    ; #0 <-> #15
    db   $09, $49,  $3c, $4c                                    ; #1 <-> #16
    db   $11, $4d,  $02, $3f                                    ; #2 <-> #17
    db   $28, $3e,  $4e, $47                                    ; #3 <-> #18
    db   $03, $3b,  $46, $42                                    ; #4 <-> #19
    db   $46, $3c,  $37, $35                                    ; #5 <-> #20
    db   $54, $47,  $31, $58                                    ; #6 <-> #21
    db   $56, $4c,  $37, $66                                    ; #7 <-> #22
    db   $59, $29,  $0e, $53                                    ; #8 <-> #23
    db   $2a, $54,  $03, $54                                    ; #9 <-> #24
    db   $47, $4a,  $16, $54                                    ; #10 <-> #25
    db   $55, $42,  $35, $3f                                    ; #11 <-> #26
    db   $57, $3c,  $35, $3c                                    ; #12 <-> #27
    db   $02, $2d,  $4c, $29                                    ; #13 <-> #28
    db   $02, $31,  $4c, $35                                    ; #14 <-> #29
    db   $03, $4d,  $59, $35                                    ; #15 <-> #0
    db   $3c, $4c,  $09, $49                                    ; #16 <-> #1
    db   $02, $3f,  $11, $4d                                    ; #17 <-> #2
    db   $4e, $47,  $28, $3e                                    ; #18 <-> #3
    db   $46, $42,  $03, $3b                                    ; #19 <-> #4
    db   $37, $35,  $46, $3c                                    ; #20 <-> #5
    db   $31, $58,  $54, $47                                    ; #21 <-> #6
    db   $37, $66,  $56, $4c                                    ; #22 <-> #7
    db   $0e, $53,  $59, $29                                    ; #23 <-> #8
    db   $03, $54,  $2a, $54                                    ; #24 <-> #9
    db   $16, $54,  $47, $4a                                    ; #25 <-> #10
    db   $35, $3f,  $55, $42                                    ; #26 <-> #11
    db   $35, $3c,  $57, $3c                                    ; #27 <-> #12
    db   $4c, $29,  $02, $2d                                    ; #28 <-> #13
    db   $4c, $35,  $02, $31                                    ; #29 <-> #14
    db   SPAWN_LIST_END

.data_0b_5266_Doors_SamuraiNightFever:
; SamuraiNightFever - 11 door(s), 1 one-way
    ;    from        to
    db   $0b, $0c,  $68, $22                                    ; #0 <-> #4
    db   $69, $05,  $09, $1e                                    ; #1 <-> #5
    db   $13, $0c,  $07, $31                                    ; #2 <-> #6
    db   $17, $0c,  $03, $48                                    ; #3 <-> #7
    db   $68, $22,  $0b, $0c                                    ; #4 <-> #0
    db   $09, $1e,  $69, $05                                    ; #5 <-> #1
    db   $07, $31,  $13, $0c                                    ; #6 <-> #2
    db   $03, $48,  $17, $0c                                    ; #7 <-> #3
    db   $63, $11,  $39, $0a                                    ; #8 one-way
    db   $1a, $46,  $31, $54                                    ; #9 <-> #10
    db   $31, $54,  $1a, $46                                    ; #10 <-> #9
    db   SPAWN_LIST_END

.data_0b_5293_Doors_NoWeddingsAndAFuneral:
; NoWeddingsAndAFuneral - 16 door(s)
    ;    from        to
    db   $14, $07,  $1b, $07                                    ; #0 <-> #8
    db   $26, $07,  $0b, $28                                    ; #1 <-> #9
    db   $0b, $15,  $06, $2f                                    ; #2 <-> #10
    db   $0e, $2f,  $05, $5a                                    ; #3 <-> #11
    db   $29, $53,  $05, $64                                    ; #4 <-> #12
    db   $1d, $64,  $2c, $5e                                    ; #5 <-> #13
    db   $31, $51,  $42, $56                                    ; #6 <-> #14
    db   $56, $52,  $42, $60                                    ; #7 <-> #15
    db   $1b, $07,  $14, $07                                    ; #8 <-> #0
    db   $0b, $28,  $26, $07                                    ; #9 <-> #1
    db   $06, $2f,  $0b, $15                                    ; #10 <-> #2
    db   $05, $5a,  $0e, $2f                                    ; #11 <-> #3
    db   $05, $64,  $29, $53                                    ; #12 <-> #4
    db   $2c, $5e,  $1d, $64                                    ; #13 <-> #5
    db   $42, $56,  $31, $51                                    ; #14 <-> #6
    db   $42, $60,  $56, $52                                    ; #15 <-> #7
    db   SPAWN_LIST_END

.data_0b_52d4_Doors_ThursdayThe12th:
; ThursdayThe12th - 45 door(s), 35 one-way
    ;    from        to
    db   $6a, $2e,  $6d, $66                                    ; #0 <-> #42
    db   $6f, $2e,  $65, $34                                    ; #1 one-way
    db   $74, $2e,  $6f, $2e                                    ; #2 one-way
    db   $65, $31,  $65, $34                                    ; #3 one-way
    db   $6a, $31,  $74, $31                                    ; #4 <-> #5
    db   $74, $31,  $6a, $31                                    ; #5 <-> #4
    db   $65, $34,  $74, $2e                                    ; #6 one-way
    db   $6f, $34,  $71, $5c                                    ; #7 <-> #44
    db   $74, $34,  $65, $34                                    ; #8 one-way
    db   $65, $37,  $6a, $31                                    ; #9 one-way
    db   $6a, $37,  $65, $34                                    ; #10 one-way
    db   $6f, $37,  $74, $34                                    ; #11 one-way
    db   $74, $37,  $65, $3a                                    ; #12 one-way
    db   $65, $3a,  $6f, $37                                    ; #13 one-way
    db   $6a, $3a,  $74, $37                                    ; #14 one-way
    db   $74, $3a,  $65, $5c                                    ; #15 <-> #43
    db   $65, $3e,  $6a, $3a                                    ; #16 one-way
    db   $6a, $3e,  $74, $3e                                    ; #17 one-way
    db   $6f, $3e,  $65, $3a                                    ; #18 one-way
    db   $74, $3e,  $6f, $3e                                    ; #19 one-way
    db   $65, $41,  $6f, $44                                    ; #20 <-> #24
    db   $6f, $41,  $65, $3e                                    ; #21 one-way
    db   $65, $44,  $6d, $44                                    ; #22 one-way
    db   $6d, $44,  $6f, $48                                    ; #23 one-way
    db   $6f, $44,  $65, $41                                    ; #24 <-> #20
    db   $74, $44,  $65, $44                                    ; #25 one-way
    db   $6f, $48,  $74, $44                                    ; #26 one-way
    db   $74, $48,  $6f, $4b                                    ; #27 one-way
    db   $65, $4b,  $6f, $48                                    ; #28 one-way
    db   $6a, $4b,  $74, $4b                                    ; #29 one-way
    db   $6f, $4b,  $6d, $44                                    ; #30 one-way
    db   $74, $4b,  $6a, $4e                                    ; #31 one-way
    db   $65, $4e,  $74, $52                                    ; #32 one-way
    db   $6a, $4e,  $65, $4e                                    ; #33 one-way
    db   $74, $4e,  $6f, $4b                                    ; #34 one-way
    db   $65, $52,  $6f, $52                                    ; #35 one-way
    db   $6f, $52,  $6f, $55                                    ; #36 one-way
    db   $74, $52,  $6a, $4e                                    ; #37 one-way
    db   $65, $55,  $74, $55                                    ; #38 one-way
    db   $6a, $55,  $65, $52                                    ; #39 one-way
    db   $6f, $55,  $74, $55                                    ; #40 one-way
    db   $74, $55,  $6a, $55                                    ; #41 one-way
    db   $6d, $66,  $6a, $2e                                    ; #42 <-> #0
    db   $65, $5c,  $74, $3a                                    ; #43 <-> #15
    db   $71, $5c,  $6f, $34                                    ; #44 <-> #7
    db   SPAWN_LIST_END

.data_0b_5389_Doors_LavaDabbaDoo:
; LavaDabbaDoo - 14 door(s)
    ;    from        to
    db   $03, $0e,  $02, $1f                                    ; #0 <-> #1
    db   $02, $1f,  $03, $0e                                    ; #1 <-> #0
    db   $0b, $0e,  $1b, $1f                                    ; #2 <-> #3
    db   $1b, $1f,  $0b, $0e                                    ; #3 <-> #2
    db   $15, $0f,  $34, $14                                    ; #4 <-> #5
    db   $34, $14,  $15, $0f                                    ; #5 <-> #4
    db   $57, $07,  $03, $2d                                    ; #6 <-> #7
    db   $03, $2d,  $57, $07                                    ; #7 <-> #6
    db   $0e, $1d,  $16, $2a                                    ; #8 <-> #9
    db   $16, $2a,  $0e, $1d                                    ; #9 <-> #8
    db   $26, $1f,  $3b, $2e                                    ; #10 <-> #11
    db   $3b, $2e,  $26, $1f                                    ; #11 <-> #10
    db   $27, $2e,  $04, $35                                    ; #12 <-> #13
    db   $04, $35,  $27, $2e                                    ; #13 <-> #12
    db   SPAWN_LIST_END

.data_0b_53c2_Doors_TexasChainsawManicure:
; TexasChainsawManicure - 12 door(s)
    ;    from        to
    db   $03, $03,  $18, $0f                                    ; #0 <-> #6
    db   $25, $04,  $2c, $0a                                    ; #1 <-> #7
    db   $3e, $04,  $58, $09                                    ; #2 <-> #8
    db   $44, $03,  $61, $07                                    ; #3 <-> #9
    db   $51, $04,  $02, $19                                    ; #4 <-> #10
    db   $02, $15,  $1d, $1c                                    ; #5 <-> #11
    db   $18, $0f,  $03, $03                                    ; #6 <-> #0
    db   $2c, $0a,  $25, $04                                    ; #7 <-> #1
    db   $58, $09,  $3e, $04                                    ; #8 <-> #2
    db   $61, $07,  $44, $03                                    ; #9 <-> #3
    db   $02, $19,  $51, $04                                    ; #10 <-> #4
    db   $1d, $1c,  $02, $15                                    ; #11 <-> #5
    db   SPAWN_LIST_END

.data_0b_53f3_Doors_MazedAndConfused:
; MazedAndConfused - 2 door(s)
    ;    from        to
    db   $1d, $2d,  $5a, $0a                                    ; #0 <-> #1
    db   $5a, $0a,  $1d, $2d                                    ; #1 <-> #0
    db   SPAWN_LIST_END

.data_0b_53fc_Doors_ChannelZ:
; ChannelZ - 1 door(s), 1 one-way
    ;    from        to
    db   $62, $7d,  $70, $7d                                    ; #0 one-way
    db   SPAWN_LIST_END

.data_0b_5401_MediaDimensionSpawnPoints:
; Where the player lands when they step back out of a TV into the hub, in blocks.
; Indexed by wD628_MediaDimensionRespawnPoint, which bank02 computes as
; (TV entity list index - 1) / 2 when a TV is entered - and that works out to a LEVEL ID:
; the table has one entry per level, and its empty entries are exactly the ten
; MAP_UNUSED_* slots. So each level effectively records where its own TV stands in the
; hub, and the player is put back in front of whichever TV they came out of
    db   $25, $0d                                               ; $00
    db   $05, $0b                                               ; $01
    db   $36, $0b                                               ; $02
    db   $11, $16                                               ; $03
    db   $39, $16                                               ; $04
    db   $25, $16                                               ; $05
    db   $00, $00                                               ; $06  (unused)
    db   $1e, $23                                               ; $07
    db   $32, $23                                               ; $08
    db   $24, $46                                               ; $09
    db   $1a, $46                                               ; $0a
    db   $10, $46                                               ; $0b
    db   $00, $00                                               ; $0c  (unused)
    db   $11, $31                                               ; $0d
    db   $3e, $31                                               ; $0e
    db   $00, $00                                               ; $0f  (unused)
    db   $1a, $0d                                               ; $10
    db   $00, $00                                               ; $11  (unused)
    db   $00, $00                                               ; $12  (unused)
    db   $00, $00                                               ; $13  (unused)
    db   $00, $00                                               ; $14  (unused)
    db   $26, $1e                                               ; $15
    db   $18, $4c                                               ; $16
    db   $1c, $31                                               ; $17
    db   $1a, $04                                               ; $18
    db   $11, $04                                               ; $19
    db   $23, $04                                               ; $1a
    db   $00, $00                                               ; $1b  (unused)
    db   $00, $00                                               ; $1c  (unused)
    db   $00, $00                                               ; $1d  (unused)
    db   $48, $31                                               ; $1e

.data_0b_543f_LevelCheckpointSpawns:
; CHECKPOINTS_PER_LEVEL block coordinates per level, indexed by
; levelId * 8 + wD618_CheckpointSpawnId * 2. Checkpoint 0 is where the level starts; the
; rest are set by call_00_208c_Checkpoint_WriteSpawnId when the player smashes a
; checkpoint TV block.
;
; Only 20 of the 31 levels define a start at all, only 7 of those define a checkpoint 1,
; and NO level uses checkpoint 2 or 3 - so the whole upper half of every record is dead
; weight, and 194 of the 248 bytes here are zero
    ; $00 MAP_MEDIA_DIMENSION
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $01 MAP_TOON_TV_OUT_OF_TOON
    db   $2f, $0b,  $26, $3a,  $00, $00,  $00, $00
    ; $02 MAP_SCREAM_TV_SMELLRAISER
    db   $03, $0a,  $4b, $0a,  $00, $00,  $00, $00
    ; $03 MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $0b, $31,  $00, $00,  $00, $00,  $00, $00
    ; $04 MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $1a, $15,  $00, $00,  $00, $00,  $00, $00
    ; $05 MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $0f, $1d,  $10, $15,  $00, $00,  $00, $00
    ; $06 MAP_UNUSED_06
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $07 MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $04, $13,  $00, $00,  $00, $00,  $00, $00
    ; $08 MAP_TOON_TV_FINE_TOONING
    db   $04, $6a,  $37, $56,  $00, $00,  $00, $00
    ; $09 MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $04, $73,  $3f, $70,  $00, $00,  $00, $00
    ; $0a MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   $0d, $34,  $4d, $34,  $00, $00,  $00, $00
    ; $0b MAP_SCREAM_TV_POLTERGEX
    db   $15, $31,  $00, $00,  $00, $00,  $00, $00
    ; $0c MAP_UNUSED_0C
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $0d MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $1e, $0c,  $00, $00,  $00, $00,  $00, $00
    ; $0e MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $04, $05,  $00, $00,  $00, $00,  $00, $00
    ; $0f MAP_UNUSED_0F
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $10 MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $6d, $55,  $00, $00,  $00, $00,  $00, $00
    ; $11 MAP_UNUSED_11
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $12 MAP_UNUSED_12
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $13 MAP_UNUSED_13
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $14 MAP_UNUSED_14
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $15 MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $50, $66,  $00, $00,  $00, $00,  $00, $00
    ; $16 MAP_REZOPOLIS_BUGGED_OUT
    db   $1c, $75,  $00, $00,  $00, $00,  $00, $00
    ; $17 MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $05, $46,  $00, $00,  $00, $00,  $00, $00
    ; $18 MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   $07, $14,  $0e, $34,  $00, $00,  $00, $00
    ; $19 MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $05, $0c,  $00, $00,  $00, $00,  $00, $00
    ; $1a MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $7b, $1a,  $00, $00,  $00, $00,  $00, $00
    ; $1b MAP_UNUSED_1B
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $1c MAP_UNUSED_1C
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $1d MAP_UNUSED_1D
    db   $00, $00,  $00, $00,  $00, $00,  $00, $00
    ; $1e MAP_BOSS_TV_CHANNEL_Z
    db   $06, $7c,  $00, $00,  $00, $00,  $00, $00
