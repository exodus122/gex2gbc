call_03_5b5b_HUD_BuildSprites:
; Builds the OAM entries for the player HUD/status display (health hearts etc.) into wCC80_ShadowOAM_HudSprites. 
; Selects one of 5 different 3-byte data layouts depending on game state: level 0 uses .data_03_5beb, 
; other levels use .data_03_5bd3, demo mode uses a specific layout, and if a special condition 
; (wD623_CollectibleMode set, wD770_LevelTimer_SecondsBCD/wD771_LevelTimer_FrameCounter in range) uses .data_03_5c1b (a "low health" or special display variant). 
; Writes 8 four-byte OAM entries to wCC80_ShadowOAM_HudSprites. Each table record is three
; bytes - X, TILE, ATTRIBUTES - and the Y byte comes from C, shared by all eight. The old
; comment called the record (palette, tile, bank), which is wrong on all three counts.
;
; That shared Y is wD688_FlyAnimationPosition, so the whole HUD row slides vertically with
; the fly popup: call_00_05c7_FlyPowerup_Update walking that byte between $88 and $A0 is
; what animates the status bar on and off screen. In levels other than the hub C is forced
; to $88 instead, which parks the row at its resting height.
;
; If wD687_FlyAnimationState bit 7 is set, jumps to .jp_03_5c33_HUD_BuildSprites_HealthBased
; (health-based tile select path)
    ld   A, [wD688_FlyAnimationPosition]                                    ;; 03:5b5b $fa $88 $d6
    ld   C, A                                          ;; 03:5b5e $4f
    ld   DE, .data_03_5beb                             ;; 03:5b5f $11 $eb $5b
    ld   A, [wD624_CurrentLevelId]                                    ;; 03:5b62 $fa $24 $d6
    and  A, A                                          ;; 03:5b65 $a7
    jr   Z, .jr_03_5ba7                                ;; 03:5b66 $28 $3f
    ld   C, $88                                        ;; 03:5b68 $0e $88
    ld   DE, .data_03_5bd3                             ;; 03:5b6a $11 $d3 $5b
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 03:5b6d $fa $1e $d6
    and  A, A                                          ;; 03:5b70 $a7
    jr   NZ, .jr_03_5ba7                               ;; 03:5b71 $20 $34
    ld   A, [wD623_CollectibleMode]                                    ;; 03:5b73 $fa $23 $d6
    and  A, A                                          ;; 03:5b76 $a7
    jr   Z, .jr_03_5b98                                ;; 03:5b77 $28 $1f
    ld   DE, .data_03_5c03                             ;; 03:5b79 $11 $03 $5c
    ld   A, [wD76F_LevelTimer_Minutes]                                    ;; 03:5b7c $fa $6f $d7
    and  A, A                                          ;; 03:5b7f $a7
    jr   NZ, .jr_03_5ba7                               ;; 03:5b80 $20 $25
    ld   A, [wD770_LevelTimer_SecondsBCD]                                    ;; 03:5b82 $fa $70 $d7
    and  A, A                                          ;; 03:5b85 $a7
    jr   Z, .jr_03_5ba7                                ;; 03:5b86 $28 $1f
    and  A, $f0                                        ;; 03:5b88 $e6 $f0
    jr   NZ, .jr_03_5ba7                               ;; 03:5b8a $20 $1b
    ld   A, [wD771_LevelTimer_FrameCounter]                                    ;; 03:5b8c $fa $71 $d7
    cp   A, $0f                                        ;; 03:5b8f $fe $0f
    jr   NC, .jr_03_5ba7                               ;; 03:5b91 $30 $14
    ld   DE, .data_03_5c1b                             ;; 03:5b93 $11 $1b $5c
    jr   .jr_03_5ba7                                   ;; 03:5b96 $18 $0f
.jr_03_5b98:
    ld   A, [wD687_FlyAnimationState]                                    ;; 03:5b98 $fa $87 $d6
    and  A, $80                                        ;; 03:5b9b $e6 $80
    jp   NZ, .jp_03_5c33_HUD_BuildSprites_HealthBased                               ;; 03:5b9d $c2 $33 $5c
    ld   A, [wD688_FlyAnimationPosition]                                    ;; 03:5ba0 $fa $88 $d6
    ld   C, A                                          ;; 03:5ba3 $4f
    ld   DE, .data_03_5bbb                             ;; 03:5ba4 $11 $bb $5b
.jr_03_5ba7:
    ld   HL, wCC80_ShadowOAM_HudSprites                                     ;; 03:5ba7 $21 $80 $cc
    ld   B, $08                                        ;; 03:5baa $06 $08
.jr_03_5bac:
    ld   A, C                                          ;; 03:5bac $79
    ld   [HL+], A                                      ;; 03:5bad $22
    ld   A, [DE]                                       ;; 03:5bae $1a
    inc  DE                                            ;; 03:5baf $13
    ld   [HL+], A                                      ;; 03:5bb0 $22
    ld   A, [DE]                                       ;; 03:5bb1 $1a
    inc  DE                                            ;; 03:5bb2 $13
    ld   [HL+], A                                      ;; 03:5bb3 $22
    ld   A, [DE]                                       ;; 03:5bb4 $1a
    ld   [HL+], A                                      ;; 03:5bb5 $22
    inc  DE                                            ;; 03:5bb6 $13
    dec  B                                             ;; 03:5bb7 $05
    jr   NZ, .jr_03_5bac                               ;; 03:5bb8 $20 $f2
    ret                                                ;; 03:5bba $c9
.data_03_5bbb:
    db   $32, $70, $10, $3a, $72, $10, $43, $74        ;; 03:5bbb ........
    db   $10, $49, $76, $10, $4f, $78, $10, $67        ;; 03:5bc3 ........
    db   $7e, $11, $70, $7a, $10, $76, $7c, $10        ;; 03:5bcb ........
.data_03_5bd3:
    db   $38, $68, $10, $40, $6a, $10, $48, $6c        ;; 03:5bd3 ????????
    db   $10, $50, $6e, $10, $58, $70, $10, $60        ;; 03:5bdb ????????
    db   $72, $10, $68, $74, $10, $70, $76, $10        ;; 03:5be3 ????????
.data_03_5beb:
    db   $38, $60, $10, $40, $62, $10, $48, $64        ;; 03:5beb ........
    db   $10, $50, $66, $10, $58, $68, $10, $60        ;; 03:5bf3 ........
    db   $6a, $10, $68, $6c, $10, $70, $6e, $10        ;; 03:5bfb ........
.data_03_5c03:
    db   $18, $74, $10, $20, $68, $10, $28, $76        ;; 03:5c03 ????????
    db   $10, $30, $78, $10, $80, $7e, $11, $88        ;; 03:5c0b ????????
    db   $7a, $10, $90, $7c, $10, $00, $70, $10        ;; 03:5c13 ????????
.data_03_5c1b:
    db   $00, $74, $10, $00, $68, $10, $00, $76        ;; 03:5c1b ????????
    db   $10, $00, $78, $10, $80, $7e, $11, $88        ;; 03:5c23 ????????
    db   $7a, $10, $90, $7c, $10, $00, $70, $10        ;; 03:5c2b ????????
.jp_03_5c33_HUD_BuildSprites_HealthBased:
; Alternate HUD builder path: uses wD741 (player health) as an index into a lookup table 
; (health × 16 + $58) to select which tile pair to use, then writes 8 OAM entries with 
; those tiles at fixed palette $CC using wD688_FlyAnimationPosition
    ld   A, [wD741_Player_Health]                                    ;; 03:5c33 $fa $41 $d7
    swap A                                             ;; 03:5c36 $cb $37
    add  A, $58                                        ;; 03:5c38 $c6 $58
    ld   E, A                                          ;; 03:5c3a $5f
    ld   A, $00                                        ;; 03:5c3b $3e $00
    adc  A, $5c                                        ;; 03:5c3d $ce $5c
    ld   D, A                                          ;; 03:5c3f $57
    ld   A, [wD688_FlyAnimationPosition]                                    ;; 03:5c40 $fa $88 $d6
    ld   C, A                                          ;; 03:5c43 $4f
    ld   HL, wCC80_ShadowOAM_HudSprites                                     ;; 03:5c44 $21 $80 $cc
    ld   B, $08                                        ;; 03:5c47 $06 $08
.jr_03_5c49:
    ld   A, C                                          ;; 03:5c49 $79
    ld   [HL+], A                                      ;; 03:5c4a $22
    ld   A, [DE]                                       ;; 03:5c4b $1a
    ld   [HL+], A                                      ;; 03:5c4c $22
    inc  DE                                            ;; 03:5c4d $13
    ld   A, [DE]                                       ;; 03:5c4e $1a
    ld   [HL+], A                                      ;; 03:5c4f $22
    inc  DE                                            ;; 03:5c50 $13
    ld   A, $10                                        ;; 03:5c51 $3e $10
    ld   [HL+], A                                      ;; 03:5c53 $22
    dec  B                                             ;; 03:5c54 $05
    jr   NZ, .jr_03_5c49                               ;; 03:5c55 $20 $f2
    ret                                                ;; 03:5c57 $c9
    db   $2c, $6c, $34, $6e, $44, $6c, $4c, $6e        ;; 03:5c58 ????????
    db   $5c, $6c, $64, $6e, $74, $6c, $7c, $6e        ;; 03:5c60 ????????
    db   $2c, $68, $34, $6a, $44, $6c, $4c, $6e        ;; 03:5c68 ........
    db   $5c, $6c, $64, $6e, $74, $6c, $7c, $6e        ;; 03:5c70 ........
    db   $2c, $68, $34, $6a, $44, $68, $4c, $6a        ;; 03:5c78 ........
    db   $5c, $6c, $64, $6e, $74, $6c, $7c, $6e        ;; 03:5c80 ........
    db   $2c, $68, $34, $6a, $44, $68, $4c, $6a        ;; 03:5c88 ........
    db   $5c, $68, $64, $6a, $74, $6c, $7c, $6e        ;; 03:5c90 ........
    db   $2c, $68, $34, $6a, $44, $68, $4c, $6a        ;; 03:5c98 ........
    db   $5c, $68, $64, $6a, $74, $68, $7c, $6a        ;; 03:5ca0 ........

call_03_5ca8_Entity_BuildPlayerSprites:
; Main Gex sprite builder. Reads wD586_PlayerGfxVramPage (base sprite state index), adjusts by +2 if facing 
; left (bit 5 of wD20D), +4 if climbing (bit 6 of wD74B_Player_ClimbingFlags). Uses this to index .data_03_5d6f 
; via call_00_07b9_GetPointerFromTable to get the frame pointer. Computes player screen X/Y from world position 
; minus map scroll origin (wD6ED/wD6EF) plus offsets ($08/$10), stores into wD212/wD213. 
; Checks action ID for $11 (special state), invincibility flags (wD755_FlyPowerup2_TimerLo/wD753_FlyPowerup1_TimerLo/wD751_Player_CircuitPowerUpTimerLo), 
; and wD73B_VBlankFrameCounter bit 3 — if any special condition is active, substitutes .data_03_5e7f 
; (invincible/stunned sprite). Writes up to 8 OAM entries into wCC00_ShadowOAM, each as (Y+B, X+C, tile+wD73A_Entity_TileIdBase, attr
    ld   A, [wD586_PlayerGfxVramPage]                                    ;; 03:5ca8 $fa $86 $d5
    ld   HL, wD20D_Player_FacingFlags                                     ;; 03:5cab $21 $0d $d2
    bit  5, [HL]                                       ;; 03:5cae $cb $6e
    jr   Z, .jr_03_5cb4                                ;; 03:5cb0 $28 $02
    add  A, $02                                        ;; 03:5cb2 $c6 $02
.jr_03_5cb4:
    ld   HL, wD74B_Player_ClimbingFlags                                     ;; 03:5cb4 $21 $4b $d7
    bit  6, [HL]                                       ;; 03:5cb7 $cb $76
    jr   Z, .jr_03_5cbd                                ;; 03:5cb9 $28 $02
    add  A, $04                                        ;; 03:5cbb $c6 $04
.jr_03_5cbd:
    ld   DE, .data_03_5d6f_GexSpriteFramePointerTable                             ;; 03:5cbd $11 $6f $5d
    call call_00_07b9_GetPointerFromTable                                  ;; 03:5cc0 $cd $b9 $07
    ld   A, [wD6ED_BgMap_ScrollX]                                    ;; 03:5cc3 $fa $ed $d6
    ld   C, A                                          ;; 03:5cc6 $4f
    ld   A, [wD20E_Player_XPositionLo]                                    ;; 03:5cc7 $fa $0e $d2
    sub  A, C                                          ;; 03:5cca $91
    add  A, $08                                        ;; 03:5ccb $c6 $08
    ld   C, A                                          ;; 03:5ccd $4f
    ld   [wD212_Player_ScreenXPosition], A                                    ;; 03:5cce $ea $12 $d2
    ld   A, [wD6EF_BgMap_ScrollY]                                    ;; 03:5cd1 $fa $ef $d6
    ld   B, A                                          ;; 03:5cd4 $47
    ld   A, [wD210_Player_YPositionLo]                                    ;; 03:5cd5 $fa $10 $d2
    sub  A, B                                          ;; 03:5cd8 $90
    add  A, $10                                        ;; 03:5cd9 $c6 $10
    ld   B, A                                          ;; 03:5cdb $47
    ld   [wD213_Player_ScreenYPosition], A                                    ;; 03:5cdc $ea $13 $d2
    ld   A, [wD201_Player_ActionId]                                    ;; 03:5cdf $fa $01 $d2
    and  A, PLAYER_ACTION_MASK                                        ;; 03:5ce2 $e6 $1f
    cp   A, PLAYER_ACTION_DEATH_SET_UP_WARP                                        ;; 03:5ce4 $fe $11
    jr   Z, .jr_03_5d11                                ;; 03:5ce6 $28 $29
    ld   A, [wD750_Player_DamageCooldownTimer]                                    ;; 03:5ce8 $fa $50 $d7
    and  A, $08                                        ;; 03:5ceb $e6 $08
    jr   NZ, .jr_03_5d0b                               ;; 03:5ced $20 $1c
    ld   A, [wD59E_OnGBCFlag]                                    ;; 03:5cef $fa $9e $d5
    and  A, A                                          ;; 03:5cf2 $a7
    jr   NZ, .jr_03_5d11                               ;; 03:5cf3 $20 $1c
    push HL                                            ;; 03:5cf5 $e5
    ld   A, [wD755_FlyPowerup2_TimerLo]                                    ;; 03:5cf6 $fa $55 $d7
    ld   HL, wD753_FlyPowerup1_TimerLo                                     ;; 03:5cf9 $21 $53 $d7
    or   A, [HL]                                       ;; 03:5cfc $b6
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 03:5cfd $21 $51 $d7
    or   A, [HL]                                       ;; 03:5d00 $b6
    pop  HL                                            ;; 03:5d01 $e1
    jr   Z, .jr_03_5d11                                ;; 03:5d02 $28 $0d
    ld   A, [wD73B_VBlankFrameCounter]                                    ;; 03:5d04 $fa $3b $d7
    and  A, $08                                        ;; 03:5d07 $e6 $08
    jr   Z, .jr_03_5d11                                ;; 03:5d09 $28 $06
.jr_03_5d0b:
    ld   HL, .data_03_5e7f_SpriteData_Invincible                             ;; 03:5d0b $21 $7f $5e
    ld   BC, $00                                       ;; 03:5d0e $01 $00 $00
.jr_03_5d11:
    ld   DE, wCC00_ShadowOAM                                     ;; 03:5d11 $11 $00 $cc
    ld   A, $08                                        ;; 03:5d14 $3e $08
.jr_03_5d16:
    push AF                                            ;; 03:5d16 $f5
    ld   A, [HL+]                                      ;; 03:5d17 $2a
    add  A, B                                          ;; 03:5d18 $80
    ld   [DE], A                                       ;; 03:5d19 $12
    inc  E                                             ;; 03:5d1a $1c
    ld   A, [HL+]                                      ;; 03:5d1b $2a
    add  A, C                                          ;; 03:5d1c $81
    ld   [DE], A                                       ;; 03:5d1d $12
    inc  E                                             ;; 03:5d1e $1c
    ld   A, [HL+]                                      ;; 03:5d1f $2a
    ld   [DE], A                                       ;; 03:5d20 $12
    inc  E                                             ;; 03:5d21 $1c
    ld   A, [wD74A_Player_InWaterOrLava]                                    ;; 03:5d22 $fa $4a $d7
    or   A, [HL]                                       ;; 03:5d25 $b6
    ld   [DE], A                                       ;; 03:5d26 $12
    inc  HL                                            ;; 03:5d27 $23
    inc  E                                             ;; 03:5d28 $1c
    pop  AF                                            ;; 03:5d29 $f1
    dec  A                                             ;; 03:5d2a $3d
    jr   NZ, .jr_03_5d16                               ;; 03:5d2b $20 $e9
    ld   A, [wD742_Player_CurrentFly]                                    ;; 03:5d2d $fa $42 $d7
    and  A, A                                          ;; 03:5d30 $a7
    ret  Z                                             ;; 03:5d31 $c8
    ld   A, [wD212_Player_ScreenXPosition]                                    ;; 03:5d32 $fa $12 $d2
    ld   [wD76C_PlayerScreenXPosition_Copy], A                                    ;; 03:5d35 $ea $6c $d7
    ld   A, [wD213_Player_ScreenYPosition]                                    ;; 03:5d38 $fa $13 $d2
    sub  A, $20                                        ;; 03:5d3b $d6 $20
    ld   [wD76D_PlayerScreenYPosition_CopyMinus20], A                                    ;; 03:5d3d $ea $6d $d7
    ld   HL, wD739_Entity_OamWriteOffset                                     ;; 03:5d40 $21 $39 $d7
    ld   E, [HL]                                       ;; 03:5d43 $5e
    ld   A, E                                          ;; 03:5d44 $7b
    add  A, $04                                        ;; 03:5d45 $c6 $04
    ld   [HL], A                                       ;; 03:5d47 $77
    ld   D, $cc                                        ;; 03:5d48 $16 $cc
    ld   HL, wD76E                                     ;; 03:5d4a $21 $6e $d7
    inc  [HL]                                          ;; 03:5d4d $34
    ld   A, [HL]                                       ;; 03:5d4e $7e
    rrca                                               ;; 03:5d4f $0f
    and  A, $0f                                        ;; 03:5d50 $e6 $0f
    add  A, A                                          ;; 03:5d52 $87
    ld   L, A                                          ;; 03:5d53 $6f
    ld   H, $00                                        ;; 03:5d54 $26 $00
    ld   BC, .data_03_5e9f_FlyParticleOffsetTable                             ;; 03:5d56 $01 $9f $5e
    add  HL, BC                                        ;; 03:5d59 $09
    ld   A, [wD76D_PlayerScreenYPosition_CopyMinus20]                                    ;; 03:5d5a $fa $6d $d7
    add  A, [HL]                                       ;; 03:5d5d $86
    ld   [DE], A                                       ;; 03:5d5e $12
    inc  E                                             ;; 03:5d5f $1c
    inc  HL                                            ;; 03:5d60 $23
    ld   A, [wD76C_PlayerScreenXPosition_Copy]                                    ;; 03:5d61 $fa $6c $d7
    add  A, [HL]                                       ;; 03:5d64 $86
    ld   [DE], A                                       ;; 03:5d65 $12
    inc  E                                             ;; 03:5d66 $1c
    ld   A, $66                                        ;; 03:5d67 $3e $66
    ld   [DE], A                                       ;; 03:5d69 $12
    inc  E                                             ;; 03:5d6a $1c
    ld   A, $02                                        ;; 03:5d6b $3e $02
    ld   [DE], A                                       ;; 03:5d6d $12
    ret                                                ;; 03:5d6e $c9
.data_03_5d6f_GexSpriteFramePointerTable:
; 8 pointer pairs (16 entries) pointing into the large Gex-specific sprite layout data blocks 
; that follow. Indexed by a combined state value (facing × 4 + climbing/action modifier). 
; Each pointer leads to a block of 4-byte sprite records
    db   $7f, $5d, $9f, $5d, $bf, $5d, $df, $5d        ;; 03:5d6f ........
    db   $ff, $5d, $1f, $5e, $3f, $5e, $5f, $5e        ;; 03:5d77 ????....
    db   $f0, $f0, $10, $10, $f0, $f8, $14, $10        ;; 03:5d7f ...?...?
    db   $f0, $00, $18, $10, $f0, $08, $1c, $10        ;; 03:5d87 ...?...?
    db   $00, $f0, $12, $10, $00, $f8, $16, $10        ;; 03:5d8f ...?...?
    db   $00, $00, $1a, $10, $00, $08, $1e, $10        ;; 03:5d97 ...?...?
    db   $f0, $f0, $00, $10, $f0, $f8, $04, $10        ;; 03:5d9f ...?...?
    db   $f0, $00, $08, $10, $f0, $08, $0c, $10        ;; 03:5da7 ...?...?
    db   $00, $f0, $02, $10, $00, $f8, $06, $10        ;; 03:5daf ...?...?
    db   $00, $00, $0a, $10, $00, $08, $0e, $10        ;; 03:5db7 ...?...?
    db   $f0, $08, $10, $30, $f0, $00, $14, $30        ;; 03:5dbf ...?...?
    db   $f0, $f8, $18, $30, $f0, $f0, $1c, $30        ;; 03:5dc7 ...?...?
    db   $00, $08, $12, $30, $00, $00, $16, $30        ;; 03:5dcf ...?...?
    db   $00, $f8, $1a, $30, $00, $f0, $1e, $30        ;; 03:5dd7 ...?...?
    db   $f0, $08, $00, $30, $f0, $00, $04, $30        ;; 03:5ddf ...?...?
    db   $f0, $f8, $08, $30, $f0, $f0, $0c, $30        ;; 03:5de7 ...?...?
    db   $00, $08, $02, $30, $00, $00, $06, $30        ;; 03:5def ...?...?
    db   $00, $f8, $0a, $30, $00, $f0, $0e, $30        ;; 03:5df7 ...?...?
    db   $00, $f0, $10, $50, $00, $f8, $14, $50        ;; 03:5dff ????????
    db   $00, $00, $18, $50, $00, $08, $1c, $50        ;; 03:5e07 ????????
    db   $f0, $f0, $12, $50, $f0, $f8, $16, $50        ;; 03:5e0f ????????
    db   $f0, $00, $1a, $50, $f0, $08, $1e, $50        ;; 03:5e17 ????????
    db   $00, $f0, $00, $50, $00, $f8, $04, $50        ;; 03:5e1f ????????
    db   $00, $00, $08, $50, $00, $08, $0c, $50        ;; 03:5e27 ????????
    db   $f0, $f0, $02, $50, $f0, $f8, $06, $50        ;; 03:5e2f ????????
    db   $f0, $00, $0a, $50, $f0, $08, $0e, $50        ;; 03:5e37 ????????
    db   $00, $08, $10, $70, $00, $00, $14, $70        ;; 03:5e3f ...?...?
    db   $00, $f8, $18, $70, $00, $f0, $1c, $70        ;; 03:5e47 ...?...?
    db   $f0, $08, $12, $70, $f0, $00, $16, $70        ;; 03:5e4f ...?...?
    db   $f0, $f8, $1a, $70, $f0, $f0, $1e, $70        ;; 03:5e57 ...?...?
    db   $00, $08, $00, $70, $00, $00, $04, $70        ;; 03:5e5f ...?...?
    db   $00, $f8, $08, $70, $00, $f0, $0c, $70        ;; 03:5e67 ...?...?
    db   $f0, $08, $02, $70, $f0, $00, $06, $70        ;; 03:5e6f ...?...?
    db   $f0, $f8, $0a, $70, $f0, $f0, $0e, $70        ;; 03:5e77 ...?...?
.data_03_5e7f_SpriteData_Invincible:
; 8 identical 4-byte records all pointing to tile $7E (a flashing/invincibility sprite), 
; used to replace normal sprite output while player is invincible/stunned
    db   $00, $00, $7e, $10, $00, $00, $7e, $10        ;; 03:5e7f ...?...?
    db   $00, $00, $7e, $10, $00, $00, $7e, $10        ;; 03:5e87 ...?...?
    db   $00, $00, $7e, $10, $00, $00, $7e, $10        ;; 03:5e8f ...?...?
    db   $00, $00, $7e, $10, $00, $00, $7e, $10        ;; 03:5e97 ...?...?
.data_03_5e9f_FlyParticleOffsetTable:
; 16 pairs of signed (Y, X) offsets for the fly/firefly particle effect that orbits above 
; Gex when he has the fly power-up. Forms a circular path sampled via a counter
    db   $00, $fe, $fe, $fc, $fc, $fe, $fc, $00        ;; 03:5e9f ????????
    db   $fa, $02, $fc, $04, $fe, $02, $00, $04        ;; 03:5ea7 ????????
    db   $00, $02, $fe, $00, $fe, $fe, $fc, $fc        ;; 03:5eaf ????????
    db   $fa, $fa, $fc, $f8, $fe, $fa, $00, $fc        ;; 03:5eb7 ????????
    
call_03_5ebf_Entity_BuildSprites:
; Draws one entity, and decides on the way whether it should still exist.
;
; The OAM attribute byte is built first: a per-slot base from wD32D_Entity_OamAttrBase (a CGB
; OBJ palette number) OR'd with the entity's own FACING_FLAGS, kept in wD335_Entity_OamAttr for
; the sprite writers further down.
;
; Then two nested tests on the entity's position relative to the scroll origin, which are
; easy to misread because they are 16-bit compares done as high-byte-then-low:
;
;   the outer box is generous - X from -$28 to $B7, Y from -$10 to $EF. Outside it the
;   entity is not merely hidden, it is a candidate for removal: Entity_CheckIfOnScreen gets
;   the final say and Entity_ClearSlot frees the slot if it agrees. This is how offscreen
;   enemies get recycled
;
;   the inner box is the genuinely visible one, X $08..$A7 and Y $10..$9F once the OAM bias
;   is added. Only that sets SPRITE_FLAG_ON_SCREEN, which other systems read to decide whether an
;   entity can be interacted with
;
; Note the entity is drawn either way - failing the inner test only clears the flag. Which of
; the five sprite paths runs is then decided by the SPRITE_FLAG_* bits; see the struct notes in
; constants.asm
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:5ebf $fa $00 $d3
    rlca                                               ;; 03:5ec2 $07
    rlca                                               ;; 03:5ec3 $07
    rlca                                               ;; 03:5ec4 $07
    and  A, $07                                        ;; 03:5ec5 $e6 $07
    ld   L, A                                          ;; 03:5ec7 $6f
    ld   H, $00                                        ;; 03:5ec8 $26 $00
    ld   DE, wD32D_Entity_OamAttrBase                                     ;; 03:5eca $11 $2d $d3
    add  HL, DE                                        ;; 03:5ecd $19
    ld   E, [HL]                                       ;; 03:5ece $5e
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   A, [HL]                                       ;; 03:5ed7 $7e
    or   A, E                                          ;; 03:5ed8 $b3
    ld   [wD335_Entity_OamAttr], A                                    ;; 03:5ed9 $ea $35 $d3
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_SPRITE_FLAGS
    ld   A, [DE]                                       ;; 03:5ee4 $1a
    res  SPRITE_FLAG_ON_SCREEN_BIT, A                                          ;; 03:5ee5 $cb $af
    ld   [DE], A                                       ;; 03:5ee7 $12
    ld   A, E                                          ;; 03:5ee8 $7b
    xor  A, $04                                        ;; 03:5ee9 $ee $04
    ld   E, A                                          ;; 03:5eeb $5f
    ld   HL, wD6ED_BgMap_ScrollX                                     ;; 03:5eec $21 $ed $d6
    ld   A, [DE]                                       ;; 03:5eef $1a
    sub  A, [HL]                                       ;; 03:5ef0 $96
    ld   C, A                                          ;; 03:5ef1 $4f
    inc  HL                                            ;; 03:5ef2 $23
    inc  DE                                            ;; 03:5ef3 $13
    ld   A, [DE]                                       ;; 03:5ef4 $1a
    sbc  A, [HL]                                       ;; 03:5ef5 $9e
    jr   C, .jr_03_5f02                                ;; 03:5ef6 $38 $0a
    and  A, A                                          ;; 03:5ef8 $a7
    jr   NZ, .jr_03_5f2b                               ;; 03:5ef9 $20 $30
    ld   A, C                                          ;; 03:5efb $79
    cp   A, $b8                                        ;; 03:5efc $fe $b8
    jr   C, .jr_03_5f0b                                ;; 03:5efe $38 $0b
    jr   .jr_03_5f2b                                   ;; 03:5f00 $18 $29
.jr_03_5f02:
    cp   A, $ff                                        ;; 03:5f02 $fe $ff
    jr   NZ, .jr_03_5f2b                               ;; 03:5f04 $20 $25
    ld   A, C                                          ;; 03:5f06 $79
    cp   A, $d8                                        ;; 03:5f07 $fe $d8
    jr   C, .jr_03_5f2b                                ;; 03:5f09 $38 $20
.jr_03_5f0b:
    inc  E                                             ;; 03:5f0b $1c
    ld   HL, wD6EF_BgMap_ScrollY                                     ;; 03:5f0c $21 $ef $d6
    ld   A, [DE]                                       ;; 03:5f0f $1a
    sub  A, [HL]                                       ;; 03:5f10 $96
    ld   B, A                                          ;; 03:5f11 $47
    inc  HL                                            ;; 03:5f12 $23
    inc  DE                                            ;; 03:5f13 $13
    ld   A, [DE]                                       ;; 03:5f14 $1a
    sbc  A, [HL]                                       ;; 03:5f15 $9e
    jr   C, .jr_03_5f22                                ;; 03:5f16 $38 $0a
    and  A, A                                          ;; 03:5f18 $a7
    jr   NZ, .jr_03_5f2b                               ;; 03:5f19 $20 $10
    ld   A, B                                          ;; 03:5f1b $78
    cp   A, $f0                                        ;; 03:5f1c $fe $f0
    jr   NC, .jr_03_5f2b                               ;; 03:5f1e $30 $0b
    jr   .jr_03_5f32                                   ;; 03:5f20 $18 $10
.jr_03_5f22:
    cp   A, $ff                                        ;; 03:5f22 $fe $ff
    jr   NZ, .jr_03_5f2b                               ;; 03:5f24 $20 $05
    ld   A, B                                          ;; 03:5f26 $78
    cp   A, $f0                                        ;; 03:5f27 $fe $f0
    jr   NC, .jr_03_5f32                               ;; 03:5f29 $30 $07
.jr_03_5f2b:
    call call_00_350c_Entity_CheckIfOnScreen                                  ;; 03:5f2b $cd $0c $35
    call C, call_00_3910_Entity_ClearSlot                               ;; 03:5f2e $dc $10 $39
    ret                                                ;; 03:5f31 $c9
.jr_03_5f32:
    inc  E                                             ;; 03:5f32 $1c
    ld   A, C                                          ;; 03:5f33 $79
    add  A, $08                                        ;; 03:5f34 $c6 $08
    ld   C, A                                          ;; 03:5f36 $4f
    ld   [DE], A                                       ;; 03:5f37 $12 ; updates entity instance + 0x12
    inc  E                                             ;; 03:5f38 $1c
    ld   A, B                                          ;; 03:5f39 $78
    add  A, $10                                        ;; 03:5f3a $c6 $10
    ld   B, A                                          ;; 03:5f3c $47
    ld   [DE], A                                       ;; 03:5f3d $12 ; updates entity instance + 0x13
    ld   A, E                                          ;; 03:5f3e $7b
    xor  A, $19                                        ;; 03:5f3f $ee $19
    ld   E, A                                          ;; 03:5f41 $5f
    ld   A, C                                          ;; 03:5f42 $79
    cp   A, $08                                        ;; 03:5f43 $fe $08
    jr   C, .jr_03_5f58_Entity_WriteSpritesAndDispatch                                ;; 03:5f45 $38 $11
    cp   A, $a8                                        ;; 03:5f47 $fe $a8
    jr   NC, .jr_03_5f58_Entity_WriteSpritesAndDispatch                               ;; 03:5f49 $30 $0d
    ld   A, B                                          ;; 03:5f4b $78
    cp   A, $10                                        ;; 03:5f4c $fe $10
    jr   C, .jr_03_5f58_Entity_WriteSpritesAndDispatch                                ;; 03:5f4e $38 $08
    cp   A, $a0                                        ;; 03:5f50 $fe $a0
    jr   NC, .jr_03_5f58_Entity_WriteSpritesAndDispatch                               ;; 03:5f52 $30 $04
    ld   A, [DE]                                       ;; 03:5f54 $1a
    set  SPRITE_FLAG_ON_SCREEN_BIT, A                       ;; 03:5f55 $cb $ef
    ld   [DE], A                                       ;; 03:5f57 $12
.jr_03_5f58_Entity_WriteSpritesAndDispatch:
; Shared tail used by multiple sprite paths: checks on-screen flag, writes N OAM entries from 
; HL into wCC OAM buffer at wD739_Entity_OamWriteOffset offset (capped at $A0), each entry: (Y+B, X+C, tile+wD73A_Entity_TileIdBase, attr
    ld   A, [DE]                                       ;; 03:5f58 $1a
    bit  SPRITE_FLAG_INVISIBLE_BIT, A                      ;; 03:5f59 $cb $5f
    jp   NZ, call_03_4c76_EntityCollision_Dispatch                                ;; 03:5f5b $c2 $76 $4c
    bit  SPRITE_FLAG_EMBEDDED_DATA_BIT, A                ;; 03:5f5e $cb $47
    jp   NZ, .jp_03_6451_Entity_BuildSprites_SpriteList                               ;; 03:5f60 $c2 $51 $64
    bit  SPRITE_FLAG_STREAMS_OWN_GFX_BIT, A                 ;; 03:5f63 $cb $7f
    jr   NZ, .jr_03_5fcb_Entity_BuildSprites_FacingBased                               ;; 03:5f65 $20 $64
    bit  SPRITE_FLAG_LAYOUT_BY_ACTION_BIT, A                ;; 03:5f67 $cb $67
    jp   NZ, .jp_03_602e_Entity_BuildSprites_ActionIndexed                               ;; 03:5f69 $c2 $2e $60
    ld   A, E                                          ;; 03:5f6c $7b
    xor  A, $07                                        ;; 03:5f6d $ee $07
    ld   E, A                                          ;; 03:5f6f $5f
    ld   A, [DE]                                       ;; 03:5f70 $1a
    swap A                                             ;; 03:5f71 $cb $37
    ld   HL, wD587_EntityGfxVramPage                                     ;; 03:5f73 $21 $87 $d5
    or   A, [HL]                                       ;; 03:5f76 $b6
    push AF                                            ;; 03:5f77 $f5
    ld   A, E                                          ;; 03:5f78 $7b
    xor  A, $0d                                        ;; 03:5f79 $ee $0d
    ld   E, A                                          ;; 03:5f7b $5f
    ld   A, [DE]                                       ;; 03:5f7c $1a
    ld   L, A                                          ;; 03:5f7d $6f
    ld   H, $00                                        ;; 03:5f7e $26 $00
    add  HL, HL                                        ;; 03:5f80 $29
    ld   DE, data_03_5447_EntitySpriteMetaTable                              ;; 03:5f81 $11 $47 $54
    add  HL, DE                                        ;; 03:5f84 $19
    ld   A, [HL-]                                      ;; 03:5f85 $3a
    ld   [wD73A_Entity_TileIdBase], A                                    ;; 03:5f86 $ea $3a $d7
    pop  AF                                            ;; 03:5f89 $f1
    bit  7, [HL]                                       ;; 03:5f8a $cb $7e
    jr   Z, .jr_03_5f96                                ;; 03:5f8c $28 $08
    ld   A, [HL]                                       ;; 03:5f8e $7e
    sub  A, $80                                        ;; 03:5f8f $d6 $80
    ld   DE, data_03_5a8a_SpriteFrameTable_Alt                              ;; 03:5f91 $11 $8a $5a
    jr   .jr_03_5f9a                                   ;; 03:5f94 $18 $04
.jr_03_5f96:
    add  A, [HL]                                       ;; 03:5f96 $86
    ld   DE, data_03_5566_SpriteFrameTable_Main                              ;; 03:5f97 $11 $66 $55
.jr_03_5f9a:
    call call_00_07b9_GetPointerFromTable                                  ;; 03:5f9a $cd $b9 $07
    ld   A, [wD739_Entity_OamWriteOffset]                                    ;; 03:5f9d $fa $39 $d7
    ld   E, A                                          ;; 03:5fa0 $5f
    ld   D, $cc                                        ;; 03:5fa1 $16 $cc
    ld   A, [HL+]                                      ;; 03:5fa3 $2a
.jr_03_5fa4:
    push AF                                            ;; 03:5fa4 $f5
    ld   A, E                                          ;; 03:5fa5 $7b
    cp   A, $a0                                        ;; 03:5fa6 $fe $a0
    jr   NC, .jr_03_5fc0                               ;; 03:5fa8 $30 $16
    ld   A, [HL+]                                      ;; 03:5faa $2a
    add  A, B                                          ;; 03:5fab $80
    ld   [DE], A                                       ;; 03:5fac $12
    inc  E                                             ;; 03:5fad $1c
    ld   A, [HL+]                                      ;; 03:5fae $2a
    add  A, C                                          ;; 03:5faf $81
    ld   [DE], A                                       ;; 03:5fb0 $12
    inc  E                                             ;; 03:5fb1 $1c
    ld   A, [wD73A_Entity_TileIdBase]                                    ;; 03:5fb2 $fa $3a $d7
    add  A, [HL]                                       ;; 03:5fb5 $86
    ld   [DE], A                                       ;; 03:5fb6 $12
    inc  HL                                            ;; 03:5fb7 $23
    inc  E                                             ;; 03:5fb8 $1c
    ld   A, [wD335_Entity_OamAttr]                                    ;; 03:5fb9 $fa $35 $d3
    or   A, [HL]                                       ;; 03:5fbc $b6
    ld   [DE], A                                       ;; 03:5fbd $12
    inc  HL                                            ;; 03:5fbe $23
    inc  E                                             ;; 03:5fbf $1c
.jr_03_5fc0:
    pop  AF                                            ;; 03:5fc0 $f1
    dec  A                                             ;; 03:5fc1 $3d
    jr   NZ, .jr_03_5fa4                               ;; 03:5fc2 $20 $e0
    ld   A, E                                          ;; 03:5fc4 $7b
    ld   [wD739_Entity_OamWriteOffset], A                                    ;; 03:5fc5 $ea $39 $d7
    jp   call_03_4c76_EntityCollision_Dispatch                                    ;; 03:5fc8 $c3 $76 $4c
.jr_03_5fcb_Entity_BuildSprites_FacingBased:
; Sprite path for entities with SPRITE_FLAG_STREAMS_OWN_GFX set. Reads FACING_FLAGS directly
; (instead of SPRITE_FLAGS) for the palette/flip byte, swaps nibbles and ORs with wD587_EntityGfxVramPage,
; then proceeds identically to the standard path: looks up sprite count and frame data 
; from data_03_5447/data_03_5566/data_03_5a8a, writes OAM entries
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_FACING_FLAGS
    ld   A, [DE]                                       ;; 03:5fd3 $1a
    swap A                                             ;; 03:5fd4 $cb $37
    ld   HL, wD587_EntityGfxVramPage                                     ;; 03:5fd6 $21 $87 $d5
    or   A, [HL]                                       ;; 03:5fd9 $b6
    push AF                                            ;; 03:5fda $f5
    ld   A, E                                          ;; 03:5fdb $7b
    xor  A, $0d                                        ;; 03:5fdc $ee $0d
    ld   E, A                                          ;; 03:5fde $5f
    ld   A, [DE]                                       ;; 03:5fdf $1a
    ld   L, A                                          ;; 03:5fe0 $6f
    ld   H, $00                                        ;; 03:5fe1 $26 $00
    add  HL, HL                                        ;; 03:5fe3 $29
    ld   DE, data_03_5447_EntitySpriteMetaTable                              ;; 03:5fe4 $11 $47 $54
    add  HL, DE                                        ;; 03:5fe7 $19
    ld   A, [HL-]                                      ;; 03:5fe8 $3a
    ld   [wD73A_Entity_TileIdBase], A                                    ;; 03:5fe9 $ea $3a $d7
    pop  AF                                            ;; 03:5fec $f1
    bit  7, [HL]                                       ;; 03:5fed $cb $7e
    jr   Z, .jr_03_5ff9                                ;; 03:5fef $28 $08
    ld   A, [HL]                                       ;; 03:5ff1 $7e
    sub  A, $80                                        ;; 03:5ff2 $d6 $80
    ld   DE, data_03_5a8a_SpriteFrameTable_Alt                              ;; 03:5ff4 $11 $8a $5a
    jr   .jr_03_5ffd                                   ;; 03:5ff7 $18 $04
.jr_03_5ff9:
    add  A, [HL]                                       ;; 03:5ff9 $86
    ld   DE, data_03_5566_SpriteFrameTable_Main                              ;; 03:5ffa $11 $66 $55
.jr_03_5ffd:
    call call_00_07b9_GetPointerFromTable                                  ;; 03:5ffd $cd $b9 $07
    ld   A, [wD739_Entity_OamWriteOffset]                                    ;; 03:6000 $fa $39 $d7
    ld   E, A                                          ;; 03:6003 $5f
    ld   D, $cc                                        ;; 03:6004 $16 $cc
    ld   A, [HL+]                                      ;; 03:6006 $2a
.jr_03_6007:
    push AF                                            ;; 03:6007 $f5
    ld   A, E                                          ;; 03:6008 $7b
    cp   A, $a0                                        ;; 03:6009 $fe $a0
    jr   NC, .jr_03_6023                               ;; 03:600b $30 $16
    ld   A, [HL+]                                      ;; 03:600d $2a
    add  A, B                                          ;; 03:600e $80
    ld   [DE], A                                       ;; 03:600f $12
    inc  E                                             ;; 03:6010 $1c
    ld   A, [HL+]                                      ;; 03:6011 $2a
    add  A, C                                          ;; 03:6012 $81
    ld   [DE], A                                       ;; 03:6013 $12
    inc  E                                             ;; 03:6014 $1c
    ld   A, [wD73A_Entity_TileIdBase]                                    ;; 03:6015 $fa $3a $d7
    add  A, [HL]                                       ;; 03:6018 $86
    ld   [DE], A                                       ;; 03:6019 $12
    inc  HL                                            ;; 03:601a $23
    inc  E                                             ;; 03:601b $1c
    ld   A, [wD335_Entity_OamAttr]                                    ;; 03:601c $fa $35 $d3
    or   A, [HL]                                       ;; 03:601f $b6
    ld   [DE], A                                       ;; 03:6020 $12
    inc  HL                                            ;; 03:6021 $23
    inc  E                                             ;; 03:6022 $1c
.jr_03_6023:
    pop  AF                                            ;; 03:6023 $f1
    dec  A                                             ;; 03:6024 $3d
    jr   NZ, .jr_03_6007                               ;; 03:6025 $20 $e0
    ld   A, E                                          ;; 03:6027 $7b
    ld   [wD739_Entity_OamWriteOffset], A                                    ;; 03:6028 $ea $39 $d7
    jp   call_03_4c76_EntityCollision_Dispatch                                    ;; 03:602b $c3 $76 $4c
.jp_03_602e_Entity_BuildSprites_ActionIndexed:
; Sprite path for entities with SPRITE_FLAG_LAYOUT_BY_ACTION set. Reads SPRITE_ID directly, uses it
; as a base index into data_03_5446 (adjusted by ACTION_ID direction), double-indexes 
; through .data_03_608e pointer table to get a variable-length sprite layout block. 
; Writes OAM entries from that block. Used for entities whose sprite layout changes 
; based on current action rather than animation frame
    push BC                                            ;; 03:602e $c5
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_SPRITE_ID
    ld   A, [DE]                                       ;; 03:6037 $1a
    ld   [wD73A_Entity_TileIdBase], A                                    ;; 03:6038 $ea $3a $d7
    ld   A, E                                          ;; 03:603b $7b
    xor  A, $08                                        ;; 03:603c $ee $08
    ld   E, A                                          ;; 03:603e $5f
    ld   A, [DE]                                       ;; 03:603f $1a
    ld   L, A                                          ;; 03:6040 $6f
    ld   H, $00                                        ;; 03:6041 $26 $00
    add  HL, HL                                        ;; 03:6043 $29
    ld   BC, data_03_5446_SpriteCountTable                              ;; 03:6044 $01 $46 $54
    add  HL, BC                                        ;; 03:6047 $09
    ld   A, E                                          ;; 03:6048 $7b
    xor  A, $0d                                        ;; 03:6049 $ee $0d
    ld   E, A                                          ;; 03:604b $5f
    ld   A, [DE]                                       ;; 03:604c $1a
    sub  A, $00                                        ;; 03:604d $d6 $00
    jr   Z, .jr_03_6053                                ;; 03:604f $28 $02
    ld   A, $01                                        ;; 03:6051 $3e $01
.jr_03_6053:
    add  A, [HL]                                       ;; 03:6053 $86
    ld   L, A                                          ;; 03:6054 $6f
    ld   H, $00                                        ;; 03:6055 $26 $00
    add  HL, HL                                        ;; 03:6057 $29
    ld   DE, .data_03_608e_EntitySpriteLayoutPointerTable                             ;; 03:6058 $11 $8e $60
    add  HL, DE                                        ;; 03:605b $19
    ld   A, [HL+]                                      ;; 03:605c $2a
    ld   H, [HL]                                       ;; 03:605d $66
    ld   L, A                                          ;; 03:605e $6f
    pop  BC                                            ;; 03:605f $c1
    ld   A, [wD739_Entity_OamWriteOffset]                                    ;; 03:6060 $fa $39 $d7
    ld   E, A                                          ;; 03:6063 $5f
    ld   D, $cc                                        ;; 03:6064 $16 $cc
    ld   A, [HL+]                                      ;; 03:6066 $2a
.jr_03_6067:
    push AF                                            ;; 03:6067 $f5
    ld   A, E                                          ;; 03:6068 $7b
    cp   A, $a0                                        ;; 03:6069 $fe $a0
    jr   NC, .jr_03_6083                               ;; 03:606b $30 $16
    ld   A, [HL+]                                      ;; 03:606d $2a
    add  A, B                                          ;; 03:606e $80
    ld   [DE], A                                       ;; 03:606f $12
    inc  E                                             ;; 03:6070 $1c
    ld   A, [HL+]                                      ;; 03:6071 $2a
    add  A, C                                          ;; 03:6072 $81
    ld   [DE], A                                       ;; 03:6073 $12
    inc  E                                             ;; 03:6074 $1c
    ld   A, [wD73A_Entity_TileIdBase]                                    ;; 03:6075 $fa $3a $d7
    add  A, [HL]                                       ;; 03:6078 $86
    ld   [DE], A                                       ;; 03:6079 $12
    inc  HL                                            ;; 03:607a $23
    inc  E                                             ;; 03:607b $1c
    ld   A, [wD335_Entity_OamAttr]                                    ;; 03:607c $fa $35 $d3
    or   A, [HL]                                       ;; 03:607f $b6
    ld   [DE], A                                       ;; 03:6080 $12
    inc  HL                                            ;; 03:6081 $23
    inc  E                                             ;; 03:6082 $1c
.jr_03_6083:
    pop  AF                                            ;; 03:6083 $f1
    dec  A                                             ;; 03:6084 $3d
    jr   NZ, .jr_03_6067                               ;; 03:6085 $20 $e0
    ld   A, E                                          ;; 03:6087 $7b
    ld   [wD739_Entity_OamWriteOffset], A                                    ;; 03:6088 $ea $39 $d7
    jp   call_03_4c76_EntityCollision_Dispatch                                    ;; 03:608b $c3 $76 $4c
.data_03_608e_EntitySpriteLayoutPointerTable:
; 58-entry pointer table, one entry per multi-tile entity sprite variant. Each pointer 
; leads to a variable-length sprite record block (first byte = tile count, then N×4-byte 
; records of signed Y offset, signed X offset, tile base, attribute). Covers all entity 
; types and their directional/size variants
    dw   .data_03_6102
    dw   .data_03_610b
    dw   .data_03_6114
    dw   .data_03_6125
    dw   .data_03_6136
    dw   .data_03_614f
    dw   .data_03_6168
    dw   .data_03_6189
    dw   .data_03_61aa
    dw   .data_03_61af
    dw   .data_03_61b4
    dw   .data_03_61bd
    dw   .data_03_61c6
    dw   .data_03_61d3
    dw   .data_03_61e0
    dw   .data_03_61f1
    dw   .data_03_6202
    dw   .data_03_6207
    dw   .data_03_620c
    dw   .data_03_6215
    dw   .data_03_621e
    dw   .data_03_622b
    dw   .data_03_6238
    dw   .data_03_6249
    dw   .data_03_625a
    dw   .data_03_625f
    dw   .data_03_6264
    dw   .data_03_626d
    dw   .data_03_6276
    dw   .data_03_6283
    dw   .data_03_6290
    dw   .data_03_62a1
    dw   .data_03_62b2
    dw   .data_03_62b7
    dw   .data_03_62bc
    dw   .data_03_62c5
    dw   .data_03_62ce
    dw   .data_03_62db
    dw   .data_03_62e8
    dw   .data_03_62f9
    dw   .data_03_630a
    dw   .data_03_630a
    dw   .data_03_632b
    dw   .data_03_6338
    dw   .data_03_6345
    dw   .data_03_6356
    dw   .data_03_6367
    dw   .data_03_6367
    dw   .data_03_6388
    dw   .data_03_6391
    dw   .data_03_639a
    dw   .data_03_63ab
    dw   .data_03_63bc
    dw   .data_03_63d5
    dw   .data_03_63ee
    dw   .data_03_640f
    dw   .data_03_6430
    dw   .data_03_6430
.data_03_6102:
    db   $02, $f0, $fc, $00, $00, $00, $fc, $02
    db   $00
.data_03_610b:
    db   $02, $f0, $fc, $00, $20, $00, $fc, $02
    db   $20
.data_03_6114:
    db   $04, $f0, $f8, $00, $00, $f0, $00, $04
    db   $00, $00, $f8, $02, $00, $00, $00, $06
    db   $00
.data_03_6125:
    db   $04, $f0, $00, $00, $20, $f0, $f8, $04
    db   $20, $00, $00, $02, $20, $00, $f8, $06
    db   $20
.data_03_6136:
    db   $06, $f0, $f4, $00, $00, $f0, $fc, $04
    db   $00, $f0, $04, $08, $00, $00, $f4, $02
    db   $00, $00, $fc, $06, $00, $00, $04, $0a
    db   $00
.data_03_614f:
    db   $06, $f0, $04, $00, $20, $f0, $fc, $04
    db   $20, $f0, $f4, $08, $20, $00, $04, $02
    db   $20, $00, $fc, $06, $20, $00, $f4, $0a
    db   $20
.data_03_6168:
    db   $08, $f0, $f0, $00, $00, $f0, $f8, $04
    db   $00, $f0, $00, $08, $00, $f0, $08, $0c
    db   $00, $00, $f0, $02, $00, $00, $f8, $06
    db   $00, $00, $00, $0a, $00, $00, $08, $0e
    db   $00
.data_03_6189:
    db   $08, $f0, $08, $00, $20, $f0, $00, $04
    db   $20, $f0, $f8, $08, $20, $f0, $f0, $0c
    db   $20, $00, $08, $02, $20, $00, $00, $06
    db   $20, $00, $f8, $0a, $20, $00, $f0, $0e
    db   $20
.data_03_61aa:
    db   $01, $f8, $fc, $00, $00
.data_03_61af:
    db   $01, $f8, $fc, $00, $20
.data_03_61b4:
    db   $02, $f8, $f8, $00, $00, $f8, $00, $02
    db   $00
.data_03_61bd:
    db   $02, $f8, $00, $00, $20, $f8, $f8, $02
    db   $20
.data_03_61c6:
    db   $03, $f8, $f4, $00, $00, $f8, $fc, $02
    db   $00, $f8, $04, $04, $00
.data_03_61d3:
    db   $03, $f8, $04, $00, $20, $f8, $fc, $02
    db   $20, $f8, $f4, $04, $20
.data_03_61e0:
    db   $04, $f8, $f0, $00, $00, $f8, $f8, $02
    db   $00, $f8, $00, $04, $00, $f8, $08, $06
    db   $00
.data_03_61f1:
    db   $04, $f8, $08, $00, $20, $f8, $00, $02
    db   $20, $f8, $f8, $04, $20, $f8, $f0, $06
    db   $20
.data_03_6202:
    db   $01, $f8, $fc, $00, $00
.data_03_6207:
    db   $01, $f8, $fc, $00, $20
.data_03_620c:
    db   $02, $f8, $f8, $00, $00, $f8, $00, $00
    db   $20
.data_03_6215:
    db   $02, $f8, $00, $00, $20, $f8, $f8, $00
    db   $00
.data_03_621e:
    db   $03, $f8, $f4, $00, $00, $f8, $fc, $02
    db   $00, $f8, $04, $00, $20
.data_03_622b:
    db   $03, $f8, $04, $00, $20, $f8, $fc, $02
    db   $20, $f8, $f4, $00, $00
.data_03_6238:
    db   $04, $f8, $f0, $00, $00, $f8, $f8, $02
    db   $00, $f8, $00, $02, $20, $f8, $08, $00
    db   $20
.data_03_6249:
    db   $04, $f8, $08, $00, $20, $f8, $00, $02
    db   $20, $f8, $f8, $02, $00, $f8, $f0, $00
    db   $00
.data_03_625a:
    db   $01, $00, $fc, $00, $00
.data_03_625f:
    db   $01, $00, $fc, $00, $20
.data_03_6264:
    db   $02, $00, $f8, $00, $00, $00, $00, $02
    db   $00
.data_03_626d:
    db   $02, $00, $00, $00, $20, $00, $f8, $02
    db   $20
.data_03_6276:
    db   $03, $00, $f4, $00, $00, $00, $fc, $02
    db   $00, $00, $04, $04, $00
.data_03_6283:
    db   $03, $00, $04, $00, $20, $00, $fc, $02
    db   $20, $00, $f4, $04, $20
.data_03_6290:
    db   $04, $00, $f0, $00, $00, $00, $f8, $02
    db   $00, $00, $00, $04, $00, $00, $08, $06
    db   $00
.data_03_62a1:
    db   $04, $00, $08, $00, $20, $00, $00, $02
    db   $20, $00, $f8, $04, $20, $00, $f0, $06
    db   $20
.data_03_62b2:
    db   $01, $00, $fc, $00, $00
.data_03_62b7:
    db   $01, $00, $fc, $00, $20
.data_03_62bc:
    db   $02, $00, $f8, $00, $00, $00, $00, $00
    db   $20
.data_03_62c5:
    db   $02, $00, $00, $00, $20, $00, $f8, $00
    db   $00
.data_03_62ce:
    db   $03, $00, $f4, $00, $00, $00, $fc, $02
    db   $00, $00, $04, $00, $20
.data_03_62db:
    db   $03, $00, $04, $00, $20, $00, $fc, $02
    db   $20, $00, $f4, $00, $00
.data_03_62e8:
    db   $04, $00, $f0, $00, $00, $00, $f8, $02
    db   $00, $00, $00, $02, $20, $00, $08, $00
    db   $20
.data_03_62f9:
    db   $04, $00, $08, $00, $20, $00, $00, $02
    db   $20, $00, $f8, $02, $00, $00, $f0, $00
    db   $00
.data_03_630a:
    db   $08, $b8, $fc, $00, $00, $c8, $fc, $02
    db   $00, $d8, $fc, $04, $00, $e8, $fc, $06
    db   $00, $f8, $f0, $08, $00, $f8, $f8, $0a
    db   $00, $f8, $00, $0c, $00, $f8, $08, $0e
    db   $00
.data_03_632b:
    db   $03, $f8, $00, $00, $00, $f8, $08, $02
    db   $00, $f8, $10, $04, $00
.data_03_6338:
    db   $03, $f8, $f8, $00, $20, $f8, $f0, $02
    db   $20, $f8, $e8, $04, $20
.data_03_6345:
    db   $04, $00, $f8, $00, $00, $00, $00, $00
    db   $00, $10, $f8, $02, $00, $10, $00, $02
    db   $00
.data_03_6356:
    db   $04, $f0, $f8, $00, $40, $f0, $00, $00
    db   $40, $e0, $f8, $02, $40, $e0, $00, $02
    db   $40
.data_03_6367:
    db   $08, $00, $e0, $00, $00, $00, $e8, $02
    db   $00, $00, $f0, $02, $00, $00, $f8, $02
    db   $00, $00, $00, $02, $20, $00, $08, $02
    db   $20, $00, $10, $02, $20, $00, $18, $00
    db   $20
.data_03_6388:
    db   $02, $f0, $fc, $00, $00, $00, $fc, $02
    db   $00
.data_03_6391:
    db   $02, $f0, $fc, $00, $20, $00, $fc, $02
    db   $20
.data_03_639a:
    db   $04, $f0, $f8, $00, $00, $f0, $00, $00
    db   $20, $00, $f8, $02, $00, $00, $00, $02
    db   $20
.data_03_63ab:
    db   $04, $f0, $00, $00, $20, $f0, $f8, $00
    db   $00, $00, $00, $02, $20, $00, $f8, $02
    db   $00
.data_03_63bc:
    db   $06, $f0, $f4, $00, $00, $f0, $fc, $04
    db   $00, $f0, $04, $00, $20, $00, $f4, $02
    db   $00, $00, $fc, $06, $00, $00, $04, $02
    db   $20
.data_03_63d5:
    db   $06, $f0, $04, $00, $20, $f0, $fc, $04
    db   $20, $f0, $f4, $00, $00, $00, $04, $02
    db   $20, $00, $fc, $06, $20, $00, $f4, $02
    db   $00
.data_03_63ee:
    db   $08, $f0, $f0, $00, $00, $f0, $f8, $04
    db   $00, $f0, $00, $04, $20, $f0, $08, $00
    db   $20, $00, $f0, $02, $00, $00, $f8, $06
    db   $00, $00, $00, $06, $20, $00, $08, $02
    db   $20
.data_03_640f:
    db   $08, $f0, $08, $00, $20, $f0, $00, $04
    db   $20, $f0, $f8, $04, $00, $f0, $f0, $00
    db   $00, $00, $08, $02, $20, $00, $00, $06
    db   $20, $00, $f8, $06, $00, $00, $f0, $02
    db   $00
.data_03_6430:
    db   $08, $e0, $f8, $00, $00, $e0, $00, $04
    db   $00, $f0, $f8, $02, $00, $f0, $00, $06
    db   $00, $00, $f8, $08, $00, $00, $00, $0c
    db   $00, $10, $f8, $0a, $00, $10, $00, $0e
    db   $00
.jp_03_6451_Entity_BuildSprites_SpriteList:
; The generic draw for SPRITE_FLAG_EMBEDDED_DATA entities: copy the sprite list that a
; per-effect builder already filled in straight into shadow OAM.
;
; call_00_39e0_Entity_GetSpriteListPtr gives the buffer. The first byte is the sprite
; count, and a count of zero means the effect has nothing on screen this frame - it
; falls through to collision dispatch rather than drawing. Each following record is
; ENTITY_SPRITE_RECORD_SIZE bytes: Y offset, X offset, tile, attributes, with B and C
; added to the offsets to place them relative to the entity.
;
; So the particle builders never touch OAM themselves; they only produce the list, and
; this is the one place it is drawn
    call call_00_39e0_Entity_GetSpriteListPtr                                  ;; 03:6451 $cd $e0 $39
    ld   L, E                                          ;; 03:6454 $6b
    ld   H, D                                          ;; 03:6455 $62
    ld   A, [wD739_Entity_OamWriteOffset]                                    ;; 03:6456 $fa $39 $d7
    ld   E, A                                          ;; 03:6459 $5f
    ld   D, $cc                                        ;; 03:645a $16 $cc
    ld   A, [HL+]                                      ;; 03:645c $2a
    and  A, A                                          ;; 03:645d $a7
    jp   Z, call_03_4c76_EntityCollision_Dispatch                                 ;; 03:645e $ca $76 $4c
.jr_03_6461:
    push AF                                            ;; 03:6461 $f5
    ld   A, E                                          ;; 03:6462 $7b
    cp   A, $a0                                        ;; 03:6463 $fe $a0
    jr   NC, .jr_03_6479                               ;; 03:6465 $30 $12
    ld   A, [HL+]                                      ;; 03:6467 $2a
    add  A, B                                          ;; 03:6468 $80
    ld   [DE], A                                       ;; 03:6469 $12
    inc  E                                             ;; 03:646a $1c
    ld   A, [HL+]                                      ;; 03:646b $2a
    add  A, C                                          ;; 03:646c $81
    ld   [DE], A                                       ;; 03:646d $12
    inc  E                                             ;; 03:646e $1c
    ld   A, [HL+]                                      ;; 03:646f $2a
    ld   [DE], A                                       ;; 03:6470 $12
    inc  E                                             ;; 03:6471 $1c
    ld   A, [wD335_Entity_OamAttr]                                    ;; 03:6472 $fa $35 $d3
    or   A, [HL]                                       ;; 03:6475 $b6
    ld   [DE], A                                       ;; 03:6476 $12
    inc  HL                                            ;; 03:6477 $23
    inc  E                                             ;; 03:6478 $1c
.jr_03_6479:
    pop  AF                                            ;; 03:6479 $f1
    dec  A                                             ;; 03:647a $3d
    jr   NZ, .jr_03_6461                               ;; 03:647b $20 $e4
    ld   A, E                                          ;; 03:647d $7b
    ld   [wD739_Entity_OamWriteOffset], A                                    ;; 03:647e $ea $39 $d7
    jp   call_03_4c76_EntityCollision_Dispatch                                    ;; 03:6481 $c3 $76 $4c

call_03_6484_OAM_ClearUnusedEntries:
; Clears all OAM entries from wD739_Entity_OamWriteOffset (current write cursor) up to $5F (end of NPC OAM region) 
; by writing $00 to every Y byte (stride 4). Effectively hides any sprite slots not written this frame
    ld   A, $5f                                        ;; 03:6484 $3e $5f
    ld   HL, wD739_Entity_OamWriteOffset                                     ;; 03:6486 $21 $39 $d7
    ld   L, [HL]                                       ;; 03:6489 $6e
    cp   A, L                                          ;; 03:648a $bd
    ret  C                                             ;; 03:648b $d8
    ld   H, $cc                                        ;; 03:648c $26 $cc
    ld   DE, $04                                       ;; 03:648e $11 $04 $00
    ld   C, $00                                        ;; 03:6491 $0e $00
.jr_03_6493:
    ld   [HL], C                                       ;; 03:6493 $71
    add  HL, DE                                        ;; 03:6494 $19
    cp   A, L                                          ;; 03:6495 $bd
    jr   NC, .jr_03_6493                               ;; 03:6496 $30 $fb
    ret                                                ;; 03:6498 $c9

call_03_6499_Collectible_BuildSprites:
; Builds OAM entries for collectible sub-hitbox sparkle/coin sprites into wCC60_ShadowOAM_CollectibleSprites. 
; Reads map scroll position (wD6ED/wD6EF), computes sub-pixel offsets into wD64D/wD64E. 
; Reads collectible slot data from wC4xx/wC5xx (two parallel arrays of X and Y positions). 
; For each active slot: computes screen position, writes tile 7E with attribute $01 (a sparkle tile). 
; If Gex is drawn and the player overlaps the 18×36 collection window, marks the slot as 
; collected (FF) and calls call_00_06ec_Player_ObtainedCollectible (collect/score). Clears remaining OAM entries after 
; the last active collectible
    ld   HL, wD6ED_BgMap_ScrollX                                     ;; 03:6499 $21 $ed $d6
    ld   A, [HL]                                       ;; 03:649c $7e
    and  A, $0f                                        ;; 03:649d $e6 $0f
    ld   C, A                                          ;; 03:649f $4f
    ld   A, $0c                                        ;; 03:64a0 $3e $0c
    sub  A, C                                          ;; 03:64a2 $91
    ld   [wD64D], A                                    ;; 03:64a3 $ea $4d $d6
    ld   A, [HL+]                                      ;; 03:64a6 $2a
    swap A                                             ;; 03:64a7 $cb $37
    and  A, $0f                                        ;; 03:64a9 $e6 $0f
    ld   C, A                                          ;; 03:64ab $4f
    ld   A, [HL+]                                      ;; 03:64ac $2a
    swap A                                             ;; 03:64ad $cb $37
    or   A, C                                          ;; 03:64af $b1
    ld   C, A                                          ;; 03:64b0 $4f
    ld   B, $c7                                        ;; 03:64b1 $06 $c7
    ld   A, [BC]                                       ;; 03:64b3 $0a
    and  A, A                                          ;; 03:64b4 $a7
    ret  Z                                             ;; 03:64b5 $c8
    push AF                                            ;; 03:64b6 $f5
    dec  B                                             ;; 03:64b7 $05
    ld   A, [BC]                                       ;; 03:64b8 $0a
    ld   E, A                                          ;; 03:64b9 $5f
    ld   HL, wD6EF_BgMap_ScrollY                                     ;; 03:64ba $21 $ef $d6
    ld   A, [HL]                                       ;; 03:64bd $7e
    and  A, $0f                                        ;; 03:64be $e6 $0f
    ld   B, A                                          ;; 03:64c0 $47
    ld   A, $10                                        ;; 03:64c1 $3e $10
    sub  A, B                                          ;; 03:64c3 $90
    ld   [wD64E], A                                    ;; 03:64c4 $ea $4e $d6
    ld   A, [HL+]                                      ;; 03:64c7 $2a
    swap A                                             ;; 03:64c8 $cb $37
    and  A, $0f                                        ;; 03:64ca $e6 $0f
    ld   B, A                                          ;; 03:64cc $47
    ld   A, [HL+]                                      ;; 03:64cd $2a
    swap A                                             ;; 03:64ce $cb $37
    or   A, B                                          ;; 03:64d0 $b0
    ld   B, A                                          ;; 03:64d1 $47
    ld   HL, wCC60_ShadowOAM_CollectibleSprites                                     ;; 03:64d2 $21 $60 $cc
    pop  AF                                            ;; 03:64d5 $f1
.jr_03_64d6:
    push AF                                            ;; 03:64d6 $f5
    push BC                                            ;; 03:64d7 $c5
    ld   D, $c5                                        ;; 03:64d8 $16 $c5
    ld   A, [DE]                                       ;; 03:64da $1a
    sub  A, B                                          ;; 03:64db $90
    cp   A, $0a                                        ;; 03:64dc $fe $0a
    jr   NC, .jr_03_653d                               ;; 03:64de $30 $5d
    swap A                                             ;; 03:64e0 $cb $37
    ld   B, A                                          ;; 03:64e2 $47
    ld   A, [wD64E]                                    ;; 03:64e3 $fa $4e $d6
    add  A, B                                          ;; 03:64e6 $80
    ld   B, A                                          ;; 03:64e7 $47
    ld   [HL+], A                                      ;; 03:64e8 $22
    ld   D, $c4                                        ;; 03:64e9 $16 $c4
    ld   A, [DE]                                       ;; 03:64eb $1a
    sub  A, C                                          ;; 03:64ec $91
    swap A                                             ;; 03:64ed $cb $37
    ld   C, A                                          ;; 03:64ef $4f
    ld   A, [wD64D]                                    ;; 03:64f0 $fa $4d $d6
    add  A, C                                          ;; 03:64f3 $81
    ld   C, A                                          ;; 03:64f4 $4f
    ld   [HL+], A                                      ;; 03:64f5 $22
    inc  E                                             ;; 03:64f6 $1c
    ld   [HL], $7e                                     ;; 03:64f7 $36 $7e
    inc  L                                             ;; 03:64f9 $2c
    ld   [HL], $01                                     ;; 03:64fa $36 $01
    inc  L                                             ;; 03:64fc $2c
    ld   A, [wD743_Player_UpdateFlag]                                    ;; 03:64fd $fa $43 $d7
    and  A, A                                          ;; 03:6500 $a7
    jr   Z, .jr_03_6524                                ;; 03:6501 $28 $21
    ld   A, [wD212_Player_ScreenXPosition]                                    ;; 03:6503 $fa $12 $d2
    sub  A, C                                          ;; 03:6506 $91
    add  A, $05                                        ;; 03:6507 $c6 $05
    cp   A, $12                                        ;; 03:6509 $fe $12
    jr   NC, .jr_03_6524                               ;; 03:650b $30 $17
    ld   A, [wD213_Player_ScreenYPosition]                                    ;; 03:650d $fa $13 $d2
    sub  A, B                                          ;; 03:6510 $90
    add  A, $0a                                        ;; 03:6511 $c6 $0a
    cp   A, $24                                        ;; 03:6513 $fe $24
    jr   NC, .jr_03_6524                               ;; 03:6515 $30 $0d
    push HL                                            ;; 03:6517 $e5
    push DE                                            ;; 03:6518 $d5
    ld   D, $c5                                        ;; 03:6519 $16 $c5
    dec  E                                             ;; 03:651b $1d
    ld   A, $ff                                        ;; 03:651c $3e $ff
    ld   [DE], A                                       ;; 03:651e $12
    call call_00_06ec_Player_ObtainedCollectible                                  ;; 03:651f $cd $ec $06
    pop  DE                                            ;; 03:6522 $d1
    pop  HL                                            ;; 03:6523 $e1
.jr_03_6524:
    bit  7, L                                          ;; 03:6524 $cb $7d
    jr   Z, .jr_03_652a                                ;; 03:6526 $28 $02
    ld   L, $80                                        ;; 03:6528 $2e $80
.jr_03_652a:
    pop  BC                                            ;; 03:652a $c1
    pop  AF                                            ;; 03:652b $f1
    dec  A                                             ;; 03:652c $3d
    jr   NZ, .jr_03_64d6                               ;; 03:652d $20 $a7
    bit  7, L                                          ;; 03:652f $cb $7d
    ret  NZ                                            ;; 03:6531 $c0
    ld   DE, $04                                       ;; 03:6532 $11 $04 $00
    xor  A, A                                          ;; 03:6535 $af
.jr_03_6536:
    ld   [HL], A                                       ;; 03:6536 $77
    add  HL, DE                                        ;; 03:6537 $19
    bit  7, L                                          ;; 03:6538 $cb $7d
    jr   Z, .jr_03_6536                                ;; 03:653a $28 $fa
    ret                                                ;; 03:653c $c9
.jr_03_653d:
    inc  E                                             ;; 03:653d $1c
    jr   .jr_03_652a                                   ;; 03:653e $18 $ea

call_03_6540_Oam_FinishFrame:
; Closes out the frame's OAM pass, after the entity builders have already filled the
; NPC region: collectible sprites, then the HUD row, then blank every slot the frame
; did not use.
;
; Only the middle step is HUD, and it does not build all the sprites - it finishes a
; list the entity code started
    call call_03_6499_Collectible_BuildSprites                                  ;; 03:6540 $cd $99 $64
    call call_03_5b5b_HUD_BuildSprites                                  ;; 03:6543 $cd $5b $5b
    jp   call_03_6484_OAM_ClearUnusedEntries                                    ;; 03:6546 $c3 $84 $64

call_03_6549_Entity_BuildSprites_FloatingSkullProjectile:
; Active flag = bit 0. Tile = (wD73B_VBlankFrameCounter >> 2) & 2 + $2C (alternates between $2C/$2E 
; based on a global timer bit — a two-frame animation). Attribute = $04
    call call_00_3a0a_Entity_GetSpriteListAndParticles
    push de
    inc  de
    ld   c,$00
    ld   b,$08
.jr_03_6552:
    bit  0,[hl]
    jr   z,.jr_03_657d
    ldi  a,[hl]
    ldi  a,[hl]
    ldi  a,[hl]
    cpl  
    inc  a
    sub  a,$08
    ld   [de],a
    inc  de
    ldi  a,[hl]
    ldi  a,[hl]
    sub  a,$04
    ld   [de],a
    inc  de
    ld   a,[wD73B_VBlankFrameCounter]
    rrca 
    rrca 
    and  a,$02
    add  a,$2C
    ld   [de],a
    inc  de
    ld   a,$04
    ld   [de],a
    inc  de
    inc  c
.jr_03_6575:
    dec  b
    jr   nz,.jr_03_6552
    pop  hl
    ld   [hl],c
    ld   a,c
    and  a
    ret  
.jr_03_657d:
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    jr   .jr_03_6575

call_03_6584_Entity_BuildSprites_CollectibleSpawn:
; Active flag = bit 7. Tile = fixed $7E (blank/flash tile), attribute = $01. 
; Used for invincibility flash or generic item-collected sparkle effects
    call call_00_3a0a_Entity_GetSpriteListAndParticles                                  ;; 03:6584 $cd $0a $3a
    push DE                                            ;; 03:6587 $d5
    inc  DE                                            ;; 03:6588 $13
    ld   C, $00                                        ;; 03:6589 $0e $00
    ld   B, $08                                        ;; 03:658b $06 $08
.jr_03_658d:
    bit  7, [HL]                                       ;; 03:658d $cb $7e
    jr   Z, .jr_03_65b1                                ;; 03:658f $28 $20
    ld   A, [HL+]                                      ;; 03:6591 $2a
    ld   A, [HL+]                                      ;; 03:6592 $2a
    ld   A, [HL+]                                      ;; 03:6593 $2a
    cpl                                                ;; 03:6594 $2f
    inc  A                                             ;; 03:6595 $3c
    sub  A, $08                                        ;; 03:6596 $d6 $08
    ld   [DE], A                                       ;; 03:6598 $12
    inc  DE                                            ;; 03:6599 $13
    ld   A, [HL+]                                      ;; 03:659a $2a
    ld   A, [HL+]                                      ;; 03:659b $2a
    sub  A, $04                                        ;; 03:659c $d6 $04
    ld   [DE], A                                       ;; 03:659e $12
    inc  DE                                            ;; 03:659f $13
    ld   A, $7e                                        ;; 03:65a0 $3e $7e
    ld   [DE], A                                       ;; 03:65a2 $12
    inc  DE                                            ;; 03:65a3 $13
    ld   A, $01                                        ;; 03:65a4 $3e $01
    ld   [DE], A                                       ;; 03:65a6 $12
    inc  DE                                            ;; 03:65a7 $13
    inc  C                                             ;; 03:65a8 $0c
.jr_03_65a9:
    dec  B                                             ;; 03:65a9 $05
    jr   NZ, .jr_03_658d                               ;; 03:65aa $20 $e1
    pop  HL                                            ;; 03:65ac $e1
    ld   [HL], C                                       ;; 03:65ad $71
    ld   A, C                                          ;; 03:65ae $79
    and  A, A                                          ;; 03:65af $a7
    ret                                                ;; 03:65b0 $c9
.jr_03_65b1:
    inc  HL                                            ;; 03:65b1 $23
    inc  HL                                            ;; 03:65b2 $23
    inc  HL                                            ;; 03:65b3 $23
    inc  HL                                            ;; 03:65b4 $23
    inc  HL                                            ;; 03:65b5 $23
    jr   .jr_03_65a9                                   ;; 03:65b6 $18 $f1

call_03_65b8_Entity_BuildSprites_FallingBoulder:
; Active flag = bit 0. Tile base = (SPRITE_ID_high_nibble clamped to 5) * 2 + $44. 
; Attribute = $07. Selects one of 6 tile pairs based on sprite ID nibble
    call call_00_3a0a_Entity_GetSpriteListAndParticles
    push de
    inc  de
    ld   c,$00
    ld   b,$08
.jr_03_65c1:
    bit  0,[hl]
    jr   z,.jr_03_65f2
    ldi  a,[hl]
    ldi  a,[hl]
    ldi  a,[hl]
    push af
    cpl  
    inc  a
    sub  a,$08
    ld   [de],a
    inc  de
    ldi  a,[hl]
    sub  a,$04
    ldi  a,[hl]
    ld   [de],a
    inc  de
    pop  af
    swap a
    and  a,$0F
    cp   a,$06
    jr   c,.jr_03_65e0
    ld   a,$05
.jr_03_65e0:
    add  a
    add  a,$44
    ld   [de],a
    inc  de
    ld   a,$07
    ld   [de],a
    inc  de
    inc  c
.jr_03_65ea:
    dec  b
    jr   nz,.jr_03_65c1
    pop  hl
    ld   [hl],c
    ld   a,c
    and  a
    ret  
.jr_03_65f2:
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    jr   .jr_03_65ea

call_03_65f9_Entity_BuildSprites_ParticleBurst:
; Active flag = bit 0. Tile base = (SPRITE_ID_high_nibble clamped to 2) * 2 + $60. 
; Attribute = $01. Selects one of 3 tile pairs
    call call_00_3a0a_Entity_GetSpriteListAndParticles                                  ;; 03:65f9 $cd $0a $3a
    push DE                                            ;; 03:65fc $d5
    inc  DE                                            ;; 03:65fd $13
    ld   C, $00                                        ;; 03:65fe $0e $00
    ld   B, $08                                        ;; 03:6600 $06 $08
.jr_03_6602:
    bit  0, [HL]                                       ;; 03:6602 $cb $46
    jr   Z, .jr_03_6633                                ;; 03:6604 $28 $2d
    ld   A, [HL+]                                      ;; 03:6606 $2a
    ld   A, [HL+]                                      ;; 03:6607 $2a
    ld   A, [HL+]                                      ;; 03:6608 $2a
    push AF                                            ;; 03:6609 $f5
    cpl                                                ;; 03:660a $2f
    inc  A                                             ;; 03:660b $3c
    sub  A, $08                                        ;; 03:660c $d6 $08
    ld   [DE], A                                       ;; 03:660e $12
    inc  DE                                            ;; 03:660f $13
    ld   A, [HL+]                                      ;; 03:6610 $2a
    ld   A, [HL+]                                      ;; 03:6611 $2a
    sub  A, $04                                        ;; 03:6612 $d6 $04
    ld   [DE], A                                       ;; 03:6614 $12
    inc  DE                                            ;; 03:6615 $13
    pop  AF                                            ;; 03:6616 $f1
    swap A                                             ;; 03:6617 $cb $37
    and  A, $0f                                        ;; 03:6619 $e6 $0f
    cp   A, $03                                        ;; 03:661b $fe $03
    jr   C, .jr_03_6621                                ;; 03:661d $38 $02
    ld   A, $02                                        ;; 03:661f $3e $02
.jr_03_6621:
    add  A, A                                          ;; 03:6621 $87
    add  A, $60                                        ;; 03:6622 $c6 $60
    ld   [DE], A                                       ;; 03:6624 $12
    inc  DE                                            ;; 03:6625 $13
    ld   A, $01                                        ;; 03:6626 $3e $01
    ld   [DE], A                                       ;; 03:6628 $12
    inc  DE                                            ;; 03:6629 $13
    inc  C                                             ;; 03:662a $0c
.jr_03_662b:
    dec  B                                             ;; 03:662b $05
    jr   NZ, .jr_03_6602                               ;; 03:662c $20 $d4
    pop  HL                                            ;; 03:662e $e1
    ld   [HL], C                                       ;; 03:662f $71
    ld   A, C                                          ;; 03:6630 $79
    and  A, A                                          ;; 03:6631 $a7
    ret                                                ;; 03:6632 $c9
.jr_03_6633:
    inc  HL                                            ;; 03:6633 $23
    inc  HL                                            ;; 03:6634 $23
    inc  HL                                            ;; 03:6635 $23
    inc  HL                                            ;; 03:6636 $23
    inc  HL                                            ;; 03:6637 $23
    jr   .jr_03_662b                                   ;; 03:6638 $18 $f1

call_03_663a_Entity_BuildSprites_FirePlantProjectiles:
; Identical to above but tile base = $58 instead of $2C. 
    call call_00_3a0a_Entity_GetSpriteListAndParticles
    push de
    inc  de
    ld   c,$00
    ld   b,$08
.jr_03_6643:
    bit  0,[hl]
    jr   z,.jr_03_666e
    ldi  a,[hl]
    ldi  a,[hl]
    ldi  a,[hl]
    cpl  
    inc  a
    sub  a,$08
    ld   [de],a
    inc  de
    ldi  a,[hl]
    ldi  a,[hl]
    sub  a,$04
    ld   [de],a
    inc  de
    ld   a,[wD73B_VBlankFrameCounter]
    rrca 
    rrca 
    and  a,$02
    add  a,$58
    ld   [de],a
    inc  de
    ld   a,$04
    ld   [de],a
    inc  de
    inc  c
.jr_03_6666:
    dec  b
    jr   nz,.jr_03_6643
    pop  hl
    ld   [hl],c
    ld   a,c
    and  a
    ret  
.jr_03_666e:
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    jr   .jr_03_6666

call_03_6675_Entity_BuildSprites_Jar:
; Like above but tile selection uses (bit 7 of SPRITE_ID >> 6) & 2 + $5C. 
    call call_00_3a0a_Entity_GetSpriteListAndParticles
    push de
    inc  de
    ld   c,$00
    ld   b,$08
.jr_03_667e:
    bit  0,[hl]
    jr   z,.jr_03_66a7
    ldi  a,[hl]
    ldi  a,[hl]
    ldi  a,[hl]
    push af
    cpl  
    inc  a
    sub  a,$08
    ld   [de],a
    inc  de
    ldi  a,[hl]
    ldi  a,[hl]
    sub  a,$04
    ld   [de],a
    inc  de
    pop  af
    rrca 
    and  a,$02
    add  a,$5C
    ld   [de],a
    inc  de
    ld   a,$04
    ld   [de],a
    inc  de
    inc  c
.jr_03_669f:
    dec  b
    jr   nz,.jr_03_667e
    pop  hl
    ld   [hl],c
    ld   a,c
    and  a
    ret  
.jr_03_66a7:
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    jr   .jr_03_669f
