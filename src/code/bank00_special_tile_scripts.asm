
call_00_1f46_SpecialTile_OnPlayerAttack:
; Entry point called each frame during TailSpin when the tile under Gex is interactive (type < $C0, inverted in C). 
; Guards: returns if wD77D_OverrideSequenceStepsRemaining nonzero (sequence already running), 
; wD77B_OverrideVRAMWritePending nonzero, or wD76B_Player_IsAttacking zero. Clears wD76B. Converts player X and Y 
; world positions to block coordinates (world_pos × 8, high byte) and stores preliminary values to wD782/wD783. 
; Uses inverted tile type C × 2 as index into data_00_1ff6_SpecialTileScriptTable — returns if null. 
; Falls into SpecialTile_RunScript
    ld   A, [wD77D_OverrideSequenceStepsRemaining]                                    ;; 00:1f46 $fa $7d $d7
    and  A, A                                          ;; 00:1f49 $a7
    ret  NZ                                            ;; 00:1f4a $c0
    ld   A, [wD77B_OverrideVRAMWritePending]                                    ;; 00:1f4b $fa $7b $d7
    and  A, A                                          ;; 00:1f4e $a7
    ret  NZ                                            ;; 00:1f4f $c0
    ld   A, [wD76B_Player_IsAttacking]                                    ;; 00:1f50 $fa $6b $d7
    and  A, A                                          ;; 00:1f53 $a7
    ret  Z                                             ;; 00:1f54 $c8
    xor  A, A                                          ;; 00:1f55 $af
    ld   [wD76B_Player_IsAttacking], A                                    ;; 00:1f56 $ea $6b $d7
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:1f59 $21 $0e $d2
    ld   A, [HL+]                                      ;; 00:1f5c $2a
    ld   H, [HL]                                       ;; 00:1f5d $66
    ld   L, A                                          ;; 00:1f5e $6f
    add  HL, HL                                        ;; 00:1f5f $29
    add  HL, HL                                        ;; 00:1f60 $29
    add  HL, HL                                        ;; 00:1f61 $29
    ld   A, H                                          ;; 00:1f62 $7c
    ld   [wD782_OverrideTargetBlockX], A                                    ;; 00:1f63 $ea $82 $d7
    ld   HL, wD210_PlayerYPosition                                     ;; 00:1f66 $21 $10 $d2
    ld   A, [HL+]                                      ;; 00:1f69 $2a
    ld   H, [HL]                                       ;; 00:1f6a $66
    ld   L, A                                          ;; 00:1f6b $6f
    add  HL, HL                                        ;; 00:1f6c $29
    add  HL, HL                                        ;; 00:1f6d $29
    add  HL, HL                                        ;; 00:1f6e $29
    ld   A, H                                          ;; 00:1f6f $7c
    ld   [wD783_OverrideTargetBlockY], A                                    ;; 00:1f70 $ea $83 $d7
    ld   L, C                                          ;; 00:1f73 $69
    ld   H, $00                                        ;; 00:1f74 $26 $00
    add  HL, HL                                        ;; 00:1f76 $29
    ld   DE, data_00_1ff6_SpecialTileScriptTable                                     ;; 00:1f77 $11 $f6 $1f
    add  HL, DE                                        ;; 00:1f7a $19
    ld   A, [HL+]                                      ;; 00:1f7b $2a
    ld   H, [HL]                                       ;; 00:1f7c $66
    ld   L, A                                          ;; 00:1f7d $6f
    or   A, H                                          ;; 00:1f7e $b4
    ret  Z                                             ;; 00:1f7f $c8
call_00_1f80_SpecialTile_RunScript:
; Also called directly by the mission preview cutscene system. Reads a callback function pointer (DE) 
; and a step count byte from the script. If count is zero: skips override setup, jumps straight to 
; calling DE (fire-and-forget). If nonzero: stores count to wD77D (sequence length), next byte 
; to wD787 (timer reload), reads X/Y block offset into E/D, reads width/height into wD784/wD785, 
; stores remaining script pointer to wD780/wD781. Computes the VRAM tilemap address for the override 
; rectangle from player Y (low byte masked $E0) shifted left 2 and D × 32, combined with player X low 
; byte + E × 32 masked to $1C → stored to wD77E/wD77F. Recalculates wD782/wD783 as player block 
; coords + D/E offset (the final target block coordinates for collision lookup). 
; Zeroes wD786_OverrideStepTimer. Pops and conditionally calls DE if nonzero
    ld   E, [HL]                                       ;; 00:1f80 $5e
    inc  HL                                            ;; 00:1f81 $23
    ld   D, [HL]                                       ;; 00:1f82 $56
    inc  HL                                            ;; 00:1f83 $23
    push DE                                            ;; 00:1f84 $d5
    ld   A, [HL+]                                      ;; 00:1f85 $2a
    and  A, A                                          ;; 00:1f86 $a7
    jr   Z, .jr_00_1fef                                ;; 00:1f87 $28 $66
    ld   [wD77D_OverrideSequenceStepsRemaining], A                                    ;; 00:1f89 $ea $7d $d7
    ld   A, [HL+]                                      ;; 00:1f8c $2a
    ld   [wD787_OverrideStepTimerReload], A                                    ;; 00:1f8d $ea $87 $d7
    ld   E, [HL]                                       ;; 00:1f90 $5e
    inc  HL                                            ;; 00:1f91 $23
    ld   D, [HL]                                       ;; 00:1f92 $56
    inc  HL                                            ;; 00:1f93 $23
    ld   A, [HL+]                                      ;; 00:1f94 $2a
    ld   [wD784_OverrideWidth], A                                    ;; 00:1f95 $ea $84 $d7
    ld   A, [HL+]                                      ;; 00:1f98 $2a
    ld   [wD785_OverrideHeight], A                                    ;; 00:1f99 $ea $85 $d7
    ld   A, L                                          ;; 00:1f9c $7d
    ld   [wD780_OverrideDataPtrLo], A                                    ;; 00:1f9d $ea $80 $d7
    ld   A, H                                          ;; 00:1fa0 $7c
    ld   [wD781_OverrideDataPtrHi], A                                    ;; 00:1fa1 $ea $81 $d7
    ld   A, D                                          ;; 00:1fa4 $7a
    add  A, A                                          ;; 00:1fa5 $87
    add  A, A                                          ;; 00:1fa6 $87
    add  A, A                                          ;; 00:1fa7 $87
    add  A, A                                          ;; 00:1fa8 $87
    add  A, A                                          ;; 00:1fa9 $87
    ld   HL, wD210_PlayerYPosition                                     ;; 00:1faa $21 $10 $d2
    add  A, [HL]                                       ;; 00:1fad $86
    and  A, $e0                                        ;; 00:1fae $e6 $e0
    ld   L, A                                          ;; 00:1fb0 $6f
    ld   H, $00                                        ;; 00:1fb1 $26 $00
    add  HL, HL                                        ;; 00:1fb3 $29
    add  HL, HL                                        ;; 00:1fb4 $29
    ld   A, E                                          ;; 00:1fb5 $7b
    add  A, A                                          ;; 00:1fb6 $87
    add  A, A                                          ;; 00:1fb7 $87
    add  A, A                                          ;; 00:1fb8 $87
    add  A, A                                          ;; 00:1fb9 $87
    add  A, A                                          ;; 00:1fba $87
    ld   C, A                                          ;; 00:1fbb $4f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:1fbc $fa $0e $d2
    add  A, C                                          ;; 00:1fbf $81
    rrca                                               ;; 00:1fc0 $0f
    rrca                                               ;; 00:1fc1 $0f
    rrca                                               ;; 00:1fc2 $0f
    and  A, $1c                                        ;; 00:1fc3 $e6 $1c
    or   A, L                                          ;; 00:1fc5 $b5
    ld   [wD77E_OverrideTilemapAddrLo], A                                    ;; 00:1fc6 $ea $7e $d7
    ld   A, H                                          ;; 00:1fc9 $7c
    add  A, $c0                                        ;; 00:1fca $c6 $c0
    ld   [wD77F_OverrideTilemapAddrHi], A                                    ;; 00:1fcc $ea $7f $d7
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:1fcf $21 $0e $d2
    ld   A, [HL+]                                      ;; 00:1fd2 $2a
    ld   H, [HL]                                       ;; 00:1fd3 $66
    ld   L, A                                          ;; 00:1fd4 $6f
    add  HL, HL                                        ;; 00:1fd5 $29
    add  HL, HL                                        ;; 00:1fd6 $29
    add  HL, HL                                        ;; 00:1fd7 $29
    ld   A, H                                          ;; 00:1fd8 $7c
    add  A, E                                          ;; 00:1fd9 $83
    ld   [wD782_OverrideTargetBlockX], A                                    ;; 00:1fda $ea $82 $d7
    ld   HL, wD210_PlayerYPosition                                     ;; 00:1fdd $21 $10 $d2
    ld   A, [HL+]                                      ;; 00:1fe0 $2a
    ld   H, [HL]                                       ;; 00:1fe1 $66
    ld   L, A                                          ;; 00:1fe2 $6f
    add  HL, HL                                        ;; 00:1fe3 $29
    add  HL, HL                                        ;; 00:1fe4 $29
    add  HL, HL                                        ;; 00:1fe5 $29
    ld   A, H                                          ;; 00:1fe6 $7c
    add  A, D                                          ;; 00:1fe7 $82
    ld   [wD783_OverrideTargetBlockY], A                                    ;; 00:1fe8 $ea $83 $d7
    xor  A, A                                          ;; 00:1feb $af
    ld   [wD786_OverrideStepTimer], A                                    ;; 00:1fec $ea $86 $d7
.jr_00_1fef:
    pop  HL                                            ;; 00:1fef $e1
    ld   A, L                                          ;; 00:1ff0 $7d
    or   A, H                                          ;; 00:1ff1 $b4
    call NZ, call_00_10bd_JumpHL                              ;; 00:1ff2 $c4 $bd $10
    ret                                                ;; 00:1ff5 $c9
data_00_1ff6_SpecialTileScriptTable:
; Sparse pointer table of 64 entries (indexed by inverted tile type × 2). Null entries ($0000) mean 
; the tile is non-interactive when attacked. Non-null entries point to tile-specific override scripts. 
; Populated indices cover: breakable blocks (0–1, mirrored at 96–103), checkpoint TVs (2–5 and mirrors), 
; Scream TV clone spawners (6, 10), multi-stage breakables/crates (7–9), springs (15), Circuit Central 
; switches (32), Kung Fu Theater / Circuit Central door switches (50), rotating doors (96–97)
;
; Script record format (used by SpecialTile_RunScript): [callback_ptr(2), step_count(1), timer_reload(1), 
; x_offset(1), y_offset(1), width(1), height(1), tile_data...]. Step count = 0 means fire-and-forget 
; (callback only, no sequence). The tile data that follows is consumed by BgMap_TickOverrideSequence 
; step-by-step, 2 bytes per cell per step.
    dw   data_00_2074_SpecialTileScript_CheckpointTV_Left
    dw   data_00_20d3_SpecialTileScript_FlyTV2_1
    dw   data_00_20ff_SpecialTileScript_FlyTV_Health1
    dw   data_00_211c_SpecialTileScript_FlyTV1_1
    dw   data_00_2139_SpecialTileScript_FlyTV_Life1
    dw   data_00_2156
    dw   data_00_21ae
    dw   data_00_21c2
    dw   data_00_21e4
    dw   data_00_2206
    dw   data_00_216e
    dw   $0000, $0000, $0000, $0000
    dw   data_00_20eb_SpecialTileScript_FlyTV2_3
    dw   $0000, $0000, $0000, $0000
    dw   $0000, $0000, $0000, $0000
    dw   $0000, $0000, $0000, $0000
    dw   $0000, $0000, $0000, $0000
    dw   data_00_2217
    dw   $0000, $0000, $0000, $0000
    dw   $0000, $0000, $0000, $0000
    dw   $0000, $0000, $0000, $0000
    dw   $0000, $0000, $0000, $0000, $0000
    dw   data_00_2266_SpecialTileScript_KungFu_DoorSwitch
    dw   $0000, $0000, $0000, $0000, $0000
    dw   data_00_22e7_SpecialTileScript_Cannon_FaceLeft
    dw   data_00_22c9_SpecialTileScript_Cannon_FaceRight
    dw   data_00_2080_SpecialTileScript_CheckpointTV_Right
    dw   data_00_20df_SpecialTileScript_FlyTV2_2
    dw   data_00_210b_SpecialTileScript_FlyTV_Health2
    dw   data_00_2128_SpecialTileScript_FlyTV1_2
    dw   data_00_2145_SpecialTileScript_FlyTV_Life2

data_00_2074_SpecialTileScript_CheckpointTV_Left:
; Script for left-facing checkpoint tv. Step count=1, timer=0, offset=(0,0), 1×1. 
; Tile data: $2A, $02 then $FA, $01. Callback = Checkpoint_WriteSpawnId. 
; On hit: plays the one-step break animation then calls the checkpoint lookup
    dw   call_00_208c_Checkpoint_WriteSpawnId
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $fa, $01
data_00_2080_SpecialTileScript_CheckpointTV_Right:
; Same as above but right-facing variant. Tile data ends with $EA, $01 instead. Same callback
    dw   call_00_208c_Checkpoint_WriteSpawnId
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $ea, $01
call_00_208c_Checkpoint_WriteSpawnId:
; Searches .data_00_20b6_CheckpointBlockCoordTable for a record matching 
; current level ID + wD782_OverrideTargetBlockX + wD783_OverrideTargetBlockY. 
; On match: writes the record's 4th byte (checkpoint ID) to wD618_CheckpointSpawnId. 
; Records are 4 bytes each: [level_id, block_x, block_y, checkpoint_id], $FF-terminated
    ld   hl,wD782_OverrideTargetBlockX
    ld   c,[hl]
    ld   hl,wD783_OverrideTargetBlockY
    ld   b,[hl]
    ld   hl,.data_00_20b6_CheckpointBlockCoordTable
    ld   de,$0004
.jr_00_209a:
    push hl
    ld   a,[wD624_CurrentLevelId]
    cp   [hl]
    jr   nz,.jr_00_20ae
    inc  hl
    ldi  a,[hl]
    cp   c
    jr   nz,.jr_00_20ae
    ldi  a,[hl]
    cp   b
    jr   nz,.jr_00_20ae
    ld   a,[hl]
    ld   [wD618_CheckpointSpawnId],a
.jr_00_20ae:
    pop  hl
    add  hl,de
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_00_209a
    ret  
.data_00_20b6_CheckpointBlockCoordTable:
; $FF-terminated table of 4-byte records: [level_id, block_x, block_y, checkpoint_id]. 
; Maps specific breakable checkpoint block positions to their spawn IDs. 
; Contains 8 entries covering various levels
    db   $01, $26, $3a, $01
    db   $02, $4b, $0a, $01
    db   $05, $10, $15, $01
    db   $0a, $4d, $34, $01
    db   $08, $37, $56, $01
    db   $09, $3f, $70, $01
    db   $18, $0e, $34, $01
    db   $ff

data_00_20d3_SpecialTileScript_FlyTV2_1:
    dw   call_00_20fa_HitFlyTV_Type2
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $fa, $01
data_00_20df_SpecialTileScript_FlyTV2_2:
    dw   call_00_20fa_HitFlyTV_Type2
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $ea, $01
data_00_20eb_SpecialTileScript_FlyTV2_3:
    dw   call_00_20fa_HitFlyTV_Type2
    db   $02, $28, $00, $00, $01, $01
    db   $28, $02, $fa, $01, $08, $9f, $01
call_00_20fa_HitFlyTV_Type2:
    ld   a,$02
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup

data_00_20ff_SpecialTileScript_FlyTV_Health1:
    dw   call_00_2117_HitFlyTV_RestoreHealth
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $fa, $01
data_00_210b_SpecialTileScript_FlyTV_Health2:
    dw   call_00_2117_HitFlyTV_RestoreHealth
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $ea, $01
call_00_2117_HitFlyTV_RestoreHealth:
    ld   a,$03
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup

data_00_211c_SpecialTileScript_FlyTV1_1:
    dw   call_00_2134_HitFlyTV_Type1
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $fa, $01
data_00_2128_SpecialTileScript_FlyTV1_2:
    dw   call_00_2134_HitFlyTV_Type1
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $ea, $01
call_00_2134_HitFlyTV_Type1:
    ld   a,$01
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup

data_00_2139_SpecialTileScript_FlyTV_Life1:
    dw   call_00_2151_HitFlyTV_ExtraLife
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $fa, $01
data_00_2145_SpecialTileScript_FlyTV_Life2:
    dw   call_00_2151_HitFlyTV_ExtraLife
    db   $01, $00, $00, $00, $01, $01
    db   $2a, $02, $ea, $01
call_00_2151_HitFlyTV_ExtraLife:
    ld   a,$04
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup

data_00_2156:
    dw   call_00_2186
    db   $03, $3c, $00, $ff, $01, $02        ;; 00:2156 ????????
    db   $23, $22, $00, $00, $e2, $01, $08, $d9        ;; 00:215e ????????
    db   $01, $da, $01, $08, $00, $00, $e2, $01        ;; 00:2166 ????????
data_00_216e:
    dw   call_00_2186
    db   $03, $3c, $00, $00, $01, $02        ;; 00:216e ????????
    db   $23, $22, $00, $00, $e2, $01, $08, $d9        ;; 00:2176 ????????
    db   $01, $da, $01, $08, $00, $00, $e2, $01        ;; 00:217e ????????
call_00_2186:
    ld   hl,wD772
    inc  [hl]
    ld   c,$05
    ld   de,wD799_OverrideSlotTable14
    ld   a,[wD624_CurrentLevelId]
    cp   a,MAP_SCREAM_TV_SMELLRAISER
    jr   z,.jr_00_219b
    ld   c,$08
    ld   de,wD79A_OverrideSlotTable15
.jr_00_219b:
    ld   a,c
    cp   [hl]
    jr   nz,.jr_00_21a2
    ld   a,$02
    ld   [de],a
.jr_00_21a2:
    FARCALL call_00_3951_Entity_SpawnPlayerClone
    ret  

data_00_21ae:
    dw   call_00_21bc
    db   $01, $00, $ff, $00, $02, $01, $2c, $26, $c9, $01, $ca, $01
call_00_21bc:
    ld   hl,wD78B_OverrideSlotTable
    ld   [hl],$02
    ret  

data_00_21c2:
    db   $00, $00, $05, $08        ;; 00:21be ????????
    db   $ff, $00, $02, $01, $2a, $25, $d3, $01        ;; 00:21c6 ????????
    db   $d4, $01, $08, $d1, $01, $d2, $01, $08        ;; 00:21ce ????????
    db   $cf, $01, $d0, $01, $08, $cd, $01, $ce        ;; 00:21d6 ????????
    db   $01, $0c, $cb, $01, $cc, $01
data_00_21e4:
    db   $00, $00        ;; 00:21de ????????
    db   $05, $08, $00, $00, $02, $01, $2a, $25        ;; 00:21e6 ????????
    db   $d3, $01, $d4, $01, $08, $d1, $01, $d2        ;; 00:21ee ????????
    db   $01, $08, $cf, $01, $d0, $01, $08, $cd        ;; 00:21f6 ????????
    db   $01, $ce, $01, $0c, $cb, $01, $cc, $01        ;; 00:21fe ????????

data_00_2206:
    dw   call_00_2211
    db   $01, $00, $00, $00, $01, $01, $0a, $c7, $01
call_00_2211:
    ld   hl,wD78B_OverrideSlotTable
    ld   [hl],$02
    ret  

data_00_2217:
    dw   call_00_2225
    db   $01, $08, $00, $ff, $01, $02, $28, $1b, $f8, $01, $f9, $01
call_00_2225:    
    ld   hl,wD782_OverrideTargetBlockX
    ld   c,[hl]
    ld   hl,wD783_OverrideTargetBlockY
    ld   b,[hl]
    ld   hl,.data_00_2253
    ld   e,$00
.jr_00_2232:
    ldi  a,[hl]
    cp   c
    jr   nz,.jr_00_223a
    ld   a,[hl]
    cp   b
    jr   z,.jr_00_2242
.jr_00_223a:
    inc  hl
    inc  e
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_00_2232
    ret  
.jr_00_2242:
    ld   d,$00
    ld   hl,wD78B_OverrideSlotTable
    add  hl,de
    ld   a,[hl]
    and  a
    ret  nz
    ld   [hl],$01
    ld   a,e
    cp   a,$06
    ret  nz
    inc  [hl]
    ret  
.data_00_2253:
    db   $25, $59, $2a
    db   $59, $2f, $59, $47, $51, $54, $55, $5a        ;; 00:2256 ????????
    db   $55, $29, $4a, $39, $64, $10, $47, $ff        ;; 00:225e ????????

data_00_2266_SpecialTileScript_KungFu_DoorSwitch:
; Kung Fu Theater door switch. Step count=1, timer=0, x=$00, y=$08, 1×2. 
; Tiles $F8,$01/$F9,$01. Callback = DoorSwitch_UpdateState
    dw   call_00_2274_DoorSwitch_UpdateState
    db   $00, $08, $00, $00, $01, $01
    db   $28, $1b, $f8, $01, $f9, $01
call_00_2274_DoorSwitch_UpdateState:
    ld   hl,wD782_OverrideTargetBlockX
    ld   c,[hl]
    ld   hl,wD783_OverrideTargetBlockY
    ld   b,[hl]
    ld   hl,.data_00_22a7_MaoTseTongue_DoorSwitchCoordTable
    ld   a,[wD624_CurrentLevelId]
    cp   a,MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    jr   z,.jr_00_2289
    ld   hl,.data_00_22b8_Other_DoorSwitchCoordTable
.jr_00_2289:
    ld   e,$00
.jr_00_228b:
    ldi  a,[hl]
    cp   c
    jr   nz,.jr_00_2293
    ld   a,[hl]
    cp   b
    jr   z,.jr_00_229b
.jr_00_2293:
    inc  hl
    inc  e
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_00_228b
    ret  
.jr_00_229b:
    ld   d,$00
    ld   hl,wD78B_OverrideSlotTable
    add  hl,de
    ld   a,[hl]
    and  a
    ret  nz
    ld   [hl],$02
    ret  
.data_00_22a7_MaoTseTongue_DoorSwitchCoordTable:
    db   $00, $00, $4c, $3a, $4b, $05, $44, $36,
    db   $00, $00, $32, $04, $5a, $30, $48, $0e, $ff
.data_00_22b8_Other_DoorSwitchCoordTable:
    db   $5e, $0d, $43, $1f, $4f, $1f, $05, $0f
    db   $75, $04, $51, $1e, $73, $2d, $6e, $2d, $ff

data_00_22c9_SpecialTileScript_Cannon_FaceRight:
; Right-rotating cannon. Step count=3, timer=$06, offset=(0,0), 2×1. 
; Tiles: $B9/$BA → $BB/$BC → $BD/$BE ($28 timer, $2C stride).
    dw   call_00_22e1_Cannon_FaceRight
    db   $03, $06, $00, $00, $02, $01
    db   $28, $2c, $b9, $01, $ba
    db   $01, $08, $bb, $01, $bc, $01, $08, $bd, $01, $be, $01
call_00_22e1_Cannon_FaceRight:
; Writes $20 to wD615_Cannon_FacingDirection. Sets rotating cannon to right state
    ld   a,$20
    ld   [wD615_Cannon_FacingDirection],a
    ret  

data_00_22e7_SpecialTileScript_Cannon_FaceLeft:
; Left-rotating cannon. Reverse tile sequence: $BB/$BC → $B9/$BA → $B7/$B8.
    dw   call_00_22ff_Cannon_FaceLeft
    db   $03, $06, $00, $00, $02, $01
    db   $28, $2c, $bb, $01, $bc
    db   $01, $08, $b9, $01, $ba, $01, $08, $b7, $01, $b8, $01
call_00_22ff_Cannon_FaceLeft:
; Writes $00 to wD615_Cannon_FacingDirection. Sets rotating cannon to left state
    ld   a,$00
    ld   [wD615_Cannon_FacingDirection],a
    ret  

call_00_2305_OverrideSlotTable_Tick:
; Scans all 16 wD78B_OverrideSlotTable slots. For each slot with value ≥ 2: increments it. 
; If the increment wraps to zero (overflowed from $FF): decrements back to $FF, checks wD77D 
; and wD77B (if either nonzero, a sequence is busy — returns without triggering). Otherwise 
; sets the slot to $01, re-arming it for the next attack. Slots with value 0 or 1 are skipped. 
; This drives the per-frame countdown for triggered tiles (state $02 = just triggered, counts 
; up to $FF = expired, then re-arms to $01 = active/waiting)
    ld   HL, wD78B_OverrideSlotTable                                     ;; 00:2305 $21 $8b $d7
    ld   B, $00                                        ;; 00:2308 $06 $00
    ld   C, $00                                        ;; 00:230a $0e $00
.jr_00_230c:
    ld   A, [HL]                                       ;; 00:230c $7e
    cp   A, $02                                        ;; 00:230d $fe $02
    jr   C, .jr_00_2314                                ;; 00:230f $38 $03
    inc  [HL]                                          ;; 00:2311 $34
    jr   Z, .jr_00_231c                                ;; 00:2312 $28 $08
.jr_00_2314:
    inc  HL                                            ;; 00:2314 $23
    inc  C                                             ;; 00:2315 $0c
    ld   A, C                                          ;; 00:2316 $79
    cp   A, $10                                        ;; 00:2317 $fe $10
    jr   NZ, .jr_00_230c                               ;; 00:2319 $20 $f1
    ret                                                ;; 00:231b $c9
.jr_00_231c:
    dec  [HL]                                          ;; 00:231c $35
    ld   A, [wD77D_OverrideSequenceStepsRemaining]                                    ;; 00:231d $fa $7d $d7
    and  A, A                                          ;; 00:2320 $a7
    ret  NZ                                            ;; 00:2321 $c0
    ld   A, [wD77B_OverrideVRAMWritePending]                                    ;; 00:2322 $fa $7b $d7
    and  A, A                                          ;; 00:2325 $a7
    ret  NZ                                            ;; 00:2326 $c0
    ld   [HL], $01                                     ;; 00:2327 $36 $01
