; ==================================================================
; MAP SPAWN POSITIONS
;
; Where the player is put down when a map is (re)loaded - the entry step of a map
; load rather than anything the player does. Called once, from bank00_home.asm,
; right before the blockmap is drawn and the entities are spawned.
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

call_0b_4efe_Map_SetSpawnPosition:
; Positions the player for the map about to be loaded, then scrolls the camera to
; match. Picks one of three sources, in priority order:
;
;   1. WARP_ENTERED_DOOR set - the player walked into a door. The flag is
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
;
; @bug - the door-match probe is asymmetric between the axes. Converting Gex's
; position back to a block, the X conversion subtracts DOOR_MATCH_X_BIAS first and
; the Y conversion subtracts nothing, so the point matched against the door list is
; half a block to the LEFT of his origin while being exactly on it vertically. A
; door therefore triggers from a spot offset from the block it is actually placed
; in, and the two axes disagree about where "he is standing here" means.
    ld   HL, wD621_WarpFlags
    ld   A, [HL]
    and  A, WARP_ENTERED_DOOR
    jr   Z, .jr_0b_4f70_NotADoor
    ld   A, [HL]
    and  A, $ff ^ WARP_ENTERED_DOOR
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

; Door lists, one per level. The records live in the .bin files under
; src/data/maps/*/doors_*.bin and the INCLUDEd .asm is generated from them by
; tools/render_map_asm.py - including the "<-> #n" / "one-way" note on each record,
; which is computed from the table rather than authored. The record layout and the
; prose describing it are in tools/map_formats.json; `make maps-docs` refreshes these.
.data_0b_5030_Doors_MediaDimension:
    INCLUDE "data/maps/media_dimension/doors_media_dimension.asm"

.data_0b_5051_Doors_OutOfToon:
    INCLUDE "data/maps/toon_tv/doors_out_of_toon.asm"

.data_0b_5066_Doors_Smellraiser:
    INCLUDE "data/maps/scream_tv/doors_smellraiser.asm"

.data_0b_5097_Doors_Frankensteinfeld:
    INCLUDE "data/maps/scream_tv/doors_frankensteinfeld.asm"

.data_0b_50e0_Doors_WwwDotcomCom:
    INCLUDE "data/maps/circuit_central/doors_wwwdotcomcom.asm"

.data_0b_5111_Doors_MaoTseTongue:
    INCLUDE "data/maps/kung_fu_theater/doors_mao_tse_tongue.asm"

.data_0b_5182_Doors_Pangaea90210:
    INCLUDE "data/maps/prehistory_channel/doors_pangaea_90210.asm"

.data_0b_519b_Doors_FineTooning:
    INCLUDE "data/maps/toon_tv/doors_fine_tooning.asm"

.data_0b_51ac_Doors_HoneyIShrunkTheGecko:
    INCLUDE "data/maps/circuit_central/doors_honey_i_shrunk_the_gecko.asm"

.data_0b_51ed_Doors_Poltergex:
    INCLUDE "data/maps/scream_tv/doors_poltergex.asm"

.data_0b_5266_Doors_SamuraiNightFever:
    INCLUDE "data/maps/kung_fu_theater/doors_samurai_night_fever.asm"

.data_0b_5293_Doors_NoWeddingsAndAFuneral:
    INCLUDE "data/maps/rezopolis/doors_no_weddings_and_a_funeral.asm"

.data_0b_52d4_Doors_ThursdayThe12th:
    INCLUDE "data/maps/scream_tv/doors_thursday_the_12th.asm"

.data_0b_5389_Doors_LavaDabbaDoo:
    INCLUDE "data/maps/prehistory_channel/doors_lava_dabba_doo.asm"

.data_0b_53c2_Doors_TexasChainsawManicure:
    INCLUDE "data/maps/scream_tv/doors_texas_chainsaw_manicure.asm"

.data_0b_53f3_Doors_MazedAndConfused:
    INCLUDE "data/maps/rezopolis/doors_mazed_and_confused.asm"

.data_0b_53fc_Doors_ChannelZ:
    INCLUDE "data/maps/channel_z/doors_channel_z.asm"

.data_0b_5401_MediaDimensionSpawnPoints:
    INCLUDE "data/maps/hub_spawn_points.asm"

.data_0b_543f_LevelCheckpointSpawns:
    INCLUDE "data/maps/level_checkpoint_spawns.asm"
