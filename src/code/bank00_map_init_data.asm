; ==================================================================
; PER-MAP DESCRIPTOR ACCESSORS
;
; Everything the engine needs to know about a map - which banks its data lives in,
; which tileset and palette it uses, where its text is - comes from one 16-byte
; record per map in .data_00_2ebf_MapData, and every accessor below is the same
; shape: call MapData_GetRecordAddr, add a MAPDATA_* offset, read.
;
; All of them read wD624_CurrentLevelId implicitly, so there is no "which map"
; argument anywhere - callers that want another map's data set wD624, call, and put
; it back. call_01_48df_MenuCmd_SetTotalsPageText and
; call_00_4349_LoadEnteringMenu both do exactly that.
; ==================================================================

call_00_2e3a_MapData_GetTVPaletteId:
; A = palette id for this map's tv screen, an index into .data_0b_5d62.
; The `ld DE,$00 / add HL,DE` is a no-op kept for symmetry with its neighbours
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e3a $cd $b0 $2e
    ld   DE, MAPDATA_TV_PALETTE_ID                     ;; 00:2e3d $11 $00 $00
    add  HL, DE                                        ;; 00:2e40 $19
    ld   A, [HL]                                       ;; 00:2e41 $7e
    ret                                                ;; 00:2e42 $c9

call_00_2e43_MapData_GetRemoteProgressId:
; A = this map's row in the remote/mission progress tables. Several maps share a
; row, which is how levels with the same mission structure share status strings -
; see call_00_4969_MenuCmd_SetMissionStatusText
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e43 $cd $b0 $2e
    ld   DE, MAPDATA_REMOTE_PROGRESS_ID                ;; 00:2e46 $11 $01 $00
    add  HL, DE                                        ;; 00:2e49 $19
    ld   A, [HL]                                       ;; 00:2e4a $7e
    ret                                                ;; 00:2e4b $c9

call_00_2e4c_MapData_GetLevelNameText:
; HL = pointer to this map's NAME string.
;
; The record holds a pointer to a text BLOCK, which is itself a list of string
; pointers; entry 0 is the level name. Only caller is
; call_01_4734_MenuCmd_SetLevelText
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e4c $cd $b0 $2e
    ld   DE, MAPDATA_TEXT_BLOCK_PTR                    ;; 00:2e4f $11 $02 $00
    add  HL, DE                                        ;; 00:2e52 $19
    ld   E, [HL]                                       ;; 00:2e53 $5e
    inc  HL                                            ;; 00:2e54 $23
    ld   D, [HL]                                       ;; 00:2e55 $56
    ld   HL, $00                                       ;; 00:2e56 $21 $00 $00 ; entry 0 of the block
    add  HL, DE                                        ;; 00:2e59 $19
    ld   E, [HL]                                       ;; 00:2e5a $5e
    inc  HL                                            ;; 00:2e5b $23
    ld   H, [HL]                                       ;; 00:2e5c $66
    ld   L, E                                          ;; 00:2e5d $6b
    ret                                                ;; 00:2e5e $c9

call_00_2e5f_MapData_GetMissionText:
; HL = pointer to mission A's description string. Same text block as the level name
; above, but indexed past it: block + MAPDATA_TEXT_MISSION_BASE + A*2, so mission 0
; is entry 1.
;
; Callers are call_01_473a_MenuCmd_SetMissionText and the mission select screen,
; both of which pass a mission index in A
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e5f $cd $b0 $2e
    ld   DE, MAPDATA_TEXT_BLOCK_PTR                    ;; 00:2e62 $11 $02 $00
    add  HL, DE                                        ;; 00:2e65 $19
    ld   E, [HL]                                       ;; 00:2e66 $5e
    inc  HL                                            ;; 00:2e67 $23
    ld   D, [HL]                                       ;; 00:2e68 $56 ; DE = the text block
    ld   HL, MAPDATA_TEXT_MISSION_BASE                 ;; 00:2e69 $21 $02 $00
    add  HL, DE                                        ;; 00:2e6c $19
    add  A, A                                          ;; 00:2e6d $87 ; A*2 for a pointer index
    ld   E, A                                          ;; 00:2e6e $5f
    ld   D, $00                                        ;; 00:2e6f $16 $00
    add  HL, DE                                        ;; 00:2e71 $19
    ld   E, [HL]                                       ;; 00:2e72 $5e
    inc  HL                                            ;; 00:2e73 $23
    ld   H, [HL]                                       ;; 00:2e74 $66
    ld   L, E                                          ;; 00:2e75 $6b
    ret                                                ;; 00:2e76 $c9

call_00_2e77_MapData_GetBlockmapBank:
; A = ROM bank holding this map's blockmap - the grid of block ids. Not the tilemap:
; that is built from this a strip at a time as the camera scrolls
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e77 $cd $b0 $2e
    ld   DE, MAPDATA_BLOCKMAP_BANK                          ;; 00:2e7a $11 $04 $00
    add  HL, DE                                        ;; 00:2e7d $19
    ld   A, [HL]                                       ;; 00:2e7e $7e
    ret                                                ;; 00:2e7f $c9

call_00_2e80_MapData_GetAltBlocksetBank:
; A = ROM bank holding the alt-blockset flag plane for this map - a grid the same
; shape as the tilemap, one byte per metatile. The byte is shared between up to eight
; maps; call_00_2e93_MapData_GetAltBlocksetMask says which bit is this one's
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e80 $cd $b0 $2e
    ld   DE, MAPDATA_ALT_BLOCKSET_BANK                 ;; 00:2e83 $11 $05 $00
    add  HL, DE                                        ;; 00:2e86 $19
    ld   A, [HL]                                       ;; 00:2e87 $7e
    ret                                                ;; 00:2e88 $c9

call_00_2e89_MapData_GetBlocksetAndCollisionBank:
; A = ROM bank holding both the blockset (metatile definitions) and the collision
; table for this map - the two live together, which is why one accessor covers both
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e89 $cd $b0 $2e
    ld   DE, MAPDATA_BLOCKSET_COLLISION_BANK           ;; 00:2e8c $11 $06 $00
    add  HL, DE                                        ;; 00:2e8f $19
    ld   A, [HL]                                       ;; 00:2e90 $7e
    ret                                                ;; 00:2e91 $c9
    ret                                                ;; 00:2e92 $c9 ; unreachable - a stray second ret

call_00_2e93_MapData_GetAltBlocksetMask:
; A = this map's bit within the flag plane named by call_00_2e80_MapData_GetAltBlocksetBank.
; Stored to wD6FE_BgMap_AltBlocksetMask and ANDed over six bytes at a time by
; call_00_1e3c_BgMap_MaskAltBlocksetFlags. $00 for a map that never uses the alt blockset
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e93 $cd $b0 $2e
    ld   DE, MAPDATA_ALT_BLOCKSET_MASK                 ;; 00:2e96 $11 $08 $00
    add  HL, DE                                        ;; 00:2e99 $19
    ld   A, [HL]                                       ;; 00:2e9a $7e
    ret                                                ;; 00:2e9b $c9

call_00_2e9c_MapData_GetTilesetBank:
; A = ROM bank holding this map's tileset graphics
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2e9c $cd $b0 $2e
    ld   DE, MAPDATA_TILESET_BANK                      ;; 00:2e9f $11 $09 $00
    add  HL, DE                                        ;; 00:2ea2 $19
    ld   A, [HL]                                       ;; 00:2ea3 $7e
    ret                                                ;; 00:2ea4 $c9

call_00_2ea5_MapData_GetTilesetBankOffset:
; DE = offset of the tileset within its bank. The only accessor besides the text
; pair that returns a word rather than a byte
    call call_00_2eb0_MapData_GetRecordAddr                                  ;; 00:2ea5 $cd $b0 $2e
    ld   DE, MAPDATA_TILESET_OFFSET                    ;; 00:2ea8 $11 $0a $00
    add  HL, DE                                        ;; 00:2eab $19
    ld   E, [HL]                                       ;; 00:2eac $5e
    inc  HL                                            ;; 00:2ead $23
    ld   D, [HL]                                       ;; 00:2eae $56
    ret                                                ;; 00:2eaf $c9

call_00_2eb0_MapData_GetRecordAddr:
; HL = base of the current map's 16-byte record. Four `add HL,HL` shifts multiply
; the level id by MAPDATA_RECORD_SIZE, which is why the record is padded to 16
; bytes when only 11 are used
    ld   HL, wD624_CurrentLevelId                                     ;; 00:2eb0 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:2eb3 $6e
    ld   H, $00                                        ;; 00:2eb4 $26 $00
    add  HL, HL                                        ;; 00:2eb6 $29
    add  HL, HL                                        ;; 00:2eb7 $29
    add  HL, HL                                        ;; 00:2eb8 $29
    add  HL, HL                                        ;; 00:2eb9 $29
    ld   DE, .data_00_2ebf_MapData                                     ;; 00:2eba $11 $bf $2e
    add  HL, DE                                        ;; 00:2ebd $19
    ret                                                ;; 00:2ebe $c9 ; HL is now the pointer to the level data
.data_00_2ebf_MapData:
; One MAPDATA_RECORD_SIZE ($10) byte record per map, 31 of them, indexed by
; wD624_CurrentLevelId. See the MAPDATA_* constants for the field offsets:
;
;   $00       MAPDATA_TV_PALETTE_ID            index into .data_0b_5d62
;   $01       MAPDATA_REMOTE_PROGRESS_ID       row in the mission status tables
;   $02-$03   MAPDATA_TEXT_BLOCK_PTR           -> list of string pointers; entry 0
;                                              is the level name, 1..n the missions
;   $04       MAPDATA_BLOCKMAP_BANK            grid of block ids = the layout
;   $05       MAPDATA_ALT_BLOCKSET_BANK        flag plane, shared by up to 8 maps
;   $06       MAPDATA_BLOCKSET_COLLISION_BANK  what each block id expands to, plus
;                                              the collision table - one bank each
;   $07                                        unused, always $00
;   $08       MAPDATA_ALT_BLOCKSET_MASK        this map's bit in that plane
;   $09       MAPDATA_TILESET_BANK
;   $0A-$0B   MAPDATA_TILESET_OFFSET           address within that bank; several
;                                              tilesets share a bank $1000 apart
;   $0C-$0F                                    unused, always $00
;
; The bank fields are written as BANK(label) and the tileset offset as the label
; itself, so the records follow main.asm automatically if a section is ever moved.
; Every one still assembles to the byte it used to hold
;
; Five of the sixteen bytes are dead. The record is padded to a power of two so
; call_00_2eb0_MapData_GetRecordAddr can index it with four `add HL,HL` shifts
; instead of a multiply - 80 bytes of ROM spent to avoid a multiply routine
    ; $00 MAP_MEDIA_DIMENSION
    db   $00, $06
    dw   data_01_5f88
    db   BANK(blockmap_media_dimension), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_MEDIA_DIMENSION, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $01 MAP_TOON_TV_OUT_OF_TOON
    db   $07, $00
    dw   data_01_5fa7
    db   BANK(blockmap_toon_tv), BANK(alt_blockset_flags1), BANK(blockset_collision_toon_tv)
    db   $00, ALT_BLOCKSET_TOON_TV, BANK(tileset_toon_tv)
    dw   tileset_toon_tv
    db   $00, $00, $00, $00

    ; $02 MAP_SCREAM_TV_SMELLRAISER
    db   $06, $00
    dw   data_01_6007
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_scream_tv)
    db   $00, ALT_BLOCKSET_SCREAM_TV1, BANK(tileset_scream_tv)
    dw   tileset_scream_tv
    db   $00, $00, $00, $00

    ; $03 MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $06, $00
    dw   data_01_606a
    db   BANK(blockmap_scream_tv2), BANK(alt_blockset_flags1), BANK(blockset_collision_scream_tv)
    db   $00, ALT_BLOCKSET_SCREAM_TV2, BANK(tileset_scream_tv)
    dw   tileset_scream_tv
    db   $00, $00, $00, $00

    ; $04 MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $01, $01
    dw   data_01_60ca
    db   BANK(blockmap_circuit_central3), BANK(alt_blockset_flags2), BANK(blockset_collision_circuit_central)
    db   $00, ALT_BLOCKSET_CIRCUIT_CENTRAL3, BANK(tileset_circuit_central)
    dw   tileset_circuit_central
    db   $00, $00, $00, $00

    ; $05 MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $02, $01
    dw   data_01_611b
    db   BANK(blockmap_kung_fu_theater2), BANK(alt_blockset_flags1), BANK(blockset_collision_kung_fu_theater)
    db   $00, ALT_BLOCKSET_KUNG_FU_THEATER2, BANK(tileset_kung_fu_theater)
    dw   tileset_kung_fu_theater
    db   $00, $00, $00, $00

    ; $06 MAP_UNUSED_06
    db   $05, $06
    dw   data_01_615f
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $07 MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $03, $01
    dw   data_01_616b
    db   BANK(blockmap_prehistory_channel1), BANK(alt_blockset_flags1), BANK(blockset_collision_prehistory_channel)
    db   $00, ALT_BLOCKSET_PREHISTORY_CHANNEL1, BANK(tileset_prehistory_channel)
    dw   tileset_prehistory_channel
    db   $00, $00, $00, $00

    ; $08 MAP_TOON_TV_FINE_TOONING
    db   $07, $01
    dw   data_01_61ac
    db   BANK(blockmap_toon_tv), BANK(alt_blockset_flags1), BANK(blockset_collision_toon_tv)
    db   $00, ALT_BLOCKSET_TOON_TV, BANK(tileset_toon_tv)
    dw   tileset_toon_tv
    db   $00, $00, $00, $00

    ; $09 MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $03, $00
    dw   data_01_61e2
    db   BANK(blockmap_prehistory_channel2), BANK(alt_blockset_flags1), BANK(blockset_collision_prehistory_channel)
    db   $00, ALT_BLOCKSET_PREHISTORY_CHANNEL2, BANK(tileset_prehistory_channel)
    dw   tileset_prehistory_channel
    db   $00, $00, $00, $00

    ; $0a MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   $01, $00
    dw   data_01_623d
    db   BANK(blockmap_circuit_central1), BANK(alt_blockset_flags2), BANK(blockset_collision_circuit_central)
    db   $00, ALT_BLOCKSET_CIRCUIT_CENTRAL1, BANK(tileset_circuit_central)
    dw   tileset_circuit_central
    db   $00, $00, $00, $00

    ; $0b MAP_SCREAM_TV_POLTERGEX
    db   $06, $00
    dw   data_01_629b
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_scream_tv)
    db   $00, ALT_BLOCKSET_SCREAM_TV1, BANK(tileset_scream_tv)
    dw   tileset_scream_tv
    db   $00, $00, $00, $00

    ; $0c MAP_UNUSED_0C
    db   $05, $06
    dw   data_01_62fa
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $0d MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $02, $00
    dw   data_01_6306
    db   BANK(blockmap_kung_fu_theater1), BANK(alt_blockset_flags1), BANK(blockset_collision_kung_fu_theater)
    db   $00, ALT_BLOCKSET_KUNG_FU_THEATER1, BANK(tileset_kung_fu_theater)
    dw   tileset_kung_fu_theater
    db   $00, $00, $00, $00

    ; $0e MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $04, $02
    dw   data_01_6372
    db   BANK(blockmap_rezopolis), BANK(alt_blockset_flags2), BANK(blockset_collision_rezopolis)
    db   $00, ALT_BLOCKSET_REZOPOLIS, BANK(tileset_rezopolis)
    dw   tileset_rezopolis
    db   $00, $00, $00, $00

    ; $0f MAP_UNUSED_0F
    db   $08, $06
    dw   data_01_63b4
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $10 MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $08, $05
    dw   data_01_63c0
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_scream_tv)
    db   $00, ALT_BLOCKSET_SCREAM_TV1, BANK(tileset_scream_tv)
    dw   tileset_scream_tv
    db   $00, $00, $00, $00

    ; $11 MAP_UNUSED_11
    db   $08, $06
    dw   data_01_63fd
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $12 MAP_UNUSED_12
    db   $08, $06
    dw   data_01_6409
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $13 MAP_UNUSED_13
    db   $08, $06
    dw   data_01_6415
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_rezopolis)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $14 MAP_UNUSED_14
    db   $08, $06
    dw   data_01_6421
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $15 MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $08, $05
    dw   data_01_642d
    db   BANK(blockmap_kung_fu_theater1), BANK(alt_blockset_flags1), BANK(blockset_collision_kung_fu_theater)
    db   $00, ALT_BLOCKSET_KUNG_FU_THEATER1, BANK(tileset_kung_fu_theater)
    dw   tileset_kung_fu_theater
    db   $00, $00, $00, $00

    ; $16 MAP_REZOPOLIS_BUGGED_OUT
    db   $08, $05
    dw   data_01_646f
    db   BANK(blockmap_rezopolis), BANK(alt_blockset_flags2), BANK(blockset_collision_rezopolis)
    db   $00, ALT_BLOCKSET_REZOPOLIS, BANK(tileset_rezopolis)
    dw   tileset_rezopolis
    db   $00, $00, $00, $00

    ; $17 MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $08, $05
    dw   data_01_64a5
    db   BANK(blockmap_circuit_central2), BANK(alt_blockset_flags2), BANK(blockset_collision_circuit_central)
    db   $00, ALT_BLOCKSET_CIRCUIT_CENTRAL2, BANK(tileset_circuit_central)
    dw   tileset_circuit_central
    db   $00, $00, $00, $00

    ; $18 MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   $03, $04
    dw   data_01_64df
    db   BANK(blockmap_prehistory_channel2), BANK(alt_blockset_flags1), BANK(blockset_collision_prehistory_channel)
    db   $00, ALT_BLOCKSET_PREHISTORY_CHANNEL2, BANK(tileset_prehistory_channel)
    dw   tileset_prehistory_channel
    db   $00, $00, $00, $00

    ; $19 MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $06, $04
    dw   data_01_6512
    db   BANK(blockmap_scream_tv2), BANK(alt_blockset_flags1), BANK(blockset_collision_scream_tv)
    db   $00, ALT_BLOCKSET_SCREAM_TV2, BANK(tileset_scream_tv)
    dw   tileset_scream_tv
    db   $00, $00, $00, $00

    ; $1a MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $04, $03
    dw   data_01_6550
    db   BANK(blockmap_rezopolis), BANK(alt_blockset_flags2), BANK(blockset_collision_rezopolis)
    db   $00, ALT_BLOCKSET_REZOPOLIS, BANK(tileset_rezopolis)
    dw   tileset_rezopolis
    db   $00, $00, $00, $00

    ; $1b MAP_UNUSED_1B
    db   $0a, $06
    dw   data_01_65a7
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $1c MAP_UNUSED_1C
    db   $0a, $06
    dw   data_01_65b3
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $1d MAP_UNUSED_1D
    db   $0a, $06
    dw   data_01_65bf
    db   BANK(blockmap_scream_tv1), BANK(alt_blockset_flags1), BANK(blockset_collision_media_dimension)
    db   $00, ALT_BLOCKSET_NONE, BANK(tileset_media_dimension)
    dw   tileset_media_dimension
    db   $00, $00, $00, $00

    ; $1e MAP_BOSS_TV_CHANNEL_Z
    db   $0a, $05
    dw   data_01_65cb
    db   BANK(blockmap_channel_z), BANK(alt_blockset_flags2), BANK(blockset_collision_channel_z)
    db   $00, ALT_BLOCKSET_CHANNEL_Z, BANK(tileset_channel_z)
    dw   tileset_channel_z
    db   $00, $00, $00, $00
