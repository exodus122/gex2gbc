call_02_489a_Player_SetLandingAction:
; Called on landing. Sets bit 6 of wD759. Chooses action ID: default 2 (light landing); 
; if directional input ($30) is held and X speed ≥ 2, uses 5 (running landing); 
; if directional input but speed < 2, uses 4 (soft landing). Jumps to Player_RequestAction
    ld   HL, wD759                                     ;; 02:489a $21 $59 $d7
    set  6, [HL]                                       ;; 02:489d $cb $f6
    ld   C, $02                                        ;; 02:489f $0e $02
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:48a1 $fa $5a $d7
    and  A, $30                                        ;; 02:48a4 $e6 $30
    jr   Z, .jr_02_48b3                                ;; 02:48a6 $28 $0b
    ld   C, $05                                        ;; 02:48a8 $0e $05
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:48aa $fa $5e $d7
    cp   A, $02                                        ;; 02:48ad $fe $02
    jr   NC, .jr_02_48b3                               ;; 02:48af $30 $02
    ld   C, $04                                        ;; 02:48b1 $0e $04
.jr_02_48b3:
    ld   A, C                                          ;; 02:48b3 $79
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:48b4 $c3 $cd $4c

call_02_48b7_Player_SpawnLevelSpecificDoor:
; Looks up the current level ID in .data_02_491a_LevelSpecificEntityIdTable to get an entity ID (0 = no entity for this level). 
; Scans the entity slot table at $D220 for a free slot (value $FF), initializes it with the entity ID, 
; clears two entity fields, then copies the player's X/Y position (snapped to $E0 boundary, with a 
; $0F offset and $10 Y flag) into the slot's position fields. Calls Entity_SetAction and Entity_ClearSlotCounter. 
; Used to spawn a level-specific companion/effect entity tied to the player's position
    push AF                                            ;; 02:48b7 $f5
    ld   HL, wD624_CurrentLevelId                                     ;; 02:48b8 $21 $24 $d6
    ld   L, [HL]                                       ;; 02:48bb $6e
    ld   H, $00                                        ;; 02:48bc $26 $00
    ld   DE, .data_02_491a_LevelSpecificEntityIdTable                              ;; 02:48be $11 $1a $49
    add  HL, DE                                        ;; 02:48c1 $19
    ld   A, [HL]                                       ;; 02:48c2 $7e
    and  A, A                                          ;; 02:48c3 $a7
    jr   NZ, .jr_02_48c8                               ;; 02:48c4 $20 $02
    pop  AF                                            ;; 02:48c6 $f1
    ret                                                ;; 02:48c7 $c9
.jr_02_48c8:
    ld   C, A                                          ;; 02:48c8 $4f
    ld   H, $d2                                        ;; 02:48c9 $26 $d2
    ld   L, $20                                        ;; 02:48cb $2e $20
.jr_02_48cd:
    ld   A, [HL]                                       ;; 02:48cd $7e
    cp   A, $ff                                        ;; 02:48ce $fe $ff
    jr   Z, .jr_02_48d8                                ;; 02:48d0 $28 $06
    ld   A, L                                          ;; 02:48d2 $7d
    add  A, $20                                        ;; 02:48d3 $c6 $20
    ld   L, A                                          ;; 02:48d5 $6f
    jr   NZ, .jr_02_48cd                               ;; 02:48d6 $20 $f5
.jr_02_48d8:
    ld   A, L                                          ;; 02:48d8 $7d
    ld   [wD300_CurrentEntityAddrLo], A                                    ;; 02:48d9 $ea $00 $d3
    or   A, $00                                        ;; 02:48dc $f6 $00
    ld   L, A                                          ;; 02:48de $6f
    ld   H, $d2                                        ;; 02:48df $26 $d2
    ld   [HL], C                                       ;; 02:48e1 $71
    ld   A, L                                          ;; 02:48e2 $7d
    xor  A, $16                                        ;; 02:48e3 $ee $16
    ld   L, A                                          ;; 02:48e5 $6f
    ld   [HL], $00                                     ;; 02:48e6 $36 $00
    ld   A, L                                          ;; 02:48e8 $7d
    xor  A, $1b                                        ;; 02:48e9 $ee $1b
    ld   L, A                                          ;; 02:48eb $6f
    ld   [HL], $00                                     ;; 02:48ec $36 $00
    ld   A, L                                          ;; 02:48ee $7d
    xor  A, $03                                        ;; 02:48ef $ee $03
    ld   L, A                                          ;; 02:48f1 $6f
    ld   DE, wD20E_PlayerXPosition                                     ;; 02:48f2 $11 $0e $d2
    ld   A, [DE]                                       ;; 02:48f5 $1a
    add  A, $0f                                        ;; 02:48f6 $c6 $0f
    ld   C, A                                          ;; 02:48f8 $4f
    inc  DE                                            ;; 02:48f9 $13
    ld   A, [DE]                                       ;; 02:48fa $1a
    adc  A, $00                                        ;; 02:48fb $ce $00
    ld   B, A                                          ;; 02:48fd $47
    inc  DE                                            ;; 02:48fe $13
    ld   A, C                                          ;; 02:48ff $79
    and  A, $e0                                        ;; 02:4900 $e6 $e0
    ld   [HL+], A                                      ;; 02:4902 $22
    ld   A, B                                          ;; 02:4903 $78
    ld   [HL+], A                                      ;; 02:4904 $22
    ld   A, [DE]                                       ;; 02:4905 $1a
    and  A, $e0                                        ;; 02:4906 $e6 $e0
    or   A, $10                                        ;; 02:4908 $f6 $10
    ld   [HL+], A                                      ;; 02:490a $22
    inc  DE                                            ;; 02:490b $13
    ld   A, [DE]                                       ;; 02:490c $1a
    ld   [HL], A                                       ;; 02:490d $77
    pop  AF                                            ;; 02:490e $f1
    call call_02_7102_Entity_SetAction                                  ;; 02:490f $cd $02 $71
    call call_00_34d8_Entity_ClearSlotCounter                                  ;; 02:4912 $cd $d8 $34
    xor  A, A                                          ;; 02:4915 $af
    ld   [wD300_CurrentEntityAddrLo], A                                    ;; 02:4916 $ea $00 $d3
    ret                                                ;; 02:4919 $c9
.data_02_491a_LevelSpecificEntityIdTable:
; 31-byte table indexed by level ID. Non-zero entries ($18) indicate which levels spawn a special 
; entity via call_02_48b7. Entries $18 appear at indices 2, 3, 11, 16, 25
    db   $00, $00, ENTITY_SCREAM_TV_DOOR_OPENING, ENTITY_SCREAM_TV_DOOR_OPENING, $00, $00, $00, $00        ;; 02:491a ????????
    db   $00, $00, $00, ENTITY_SCREAM_TV_DOOR_OPENING, $00, $00, $00, $00        ;; 02:4922 ????????
    db   ENTITY_SCREAM_TV_DOOR_OPENING, $00, $00, $00, $00, $00, $00, $00        ;; 02:492a ????????
    db   $00, ENTITY_SCREAM_TV_DOOR_OPENING, $00, $00, $00, $00, $00             ;; 02:4932 ???????

call_02_4939_Player_UpdateMain:
; Master per-frame player update. Handles demo mode input replay (advances through run-length encoded 
; input stream wD61B, loads current input byte into wD620; if stream ends, clears demo mode flag). 
; For live play reads wD59F. Processes input through wD759 button-lock flags: bit 0 suppresses A button until 
; released; bit 6 suppresses B button (jump) unless already held; bit 7 suppresses jump during upward Y velocity, 
; with a bit-4 latch for re-press tracking. Writes filtered input to wD75A. Decrements wD750 timer if nonzero. 
; Calls: Player_UpdateFacing, bg collision update, Player_ApplyYVelocity, bg tile cache, Player_CheckTileInteractions, 
; then dispatches wD745 pending action change (resets climb state to $FF, clears wD74B), calls the current action 
; function pointer at wD202, Player_ApplyXMovement, clears wD758, computes wD76A (block X = world X >> 5 high byte), 
; clears two entity flags in wD209/wD20A, ticks action frame counter, updates map window, checks water/conveyor tiles, 
; builds body sprites, and decrements three 16-bit timers at wD751, wD755, wD753
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 02:4939 $fa $1e $d6
    and  A, A                                          ;; 02:493c $a7
    jr   Z, .jr_02_4965                                ;; 02:493d $28 $26
    ld   HL, wD61F_DemoRelatedCounter                                     ;; 02:493f $21 $1f $d6
    dec  [HL]                                          ;; 02:4942 $35
    jr   NZ, .jr_02_495c                               ;; 02:4943 $20 $17
    ld   HL, wD61B_DemoInputsPointer                                     ;; 02:4945 $21 $1b $d6
    ld   E, [HL]                                       ;; 02:4948 $5e
    inc  HL                                            ;; 02:4949 $23
    ld   D, [HL]                                       ;; 02:494a $56
    ld   A, [DE]                                       ;; 02:494b $1a
    cp   A, $ff                                        ;; 02:494c $fe $ff
    jr   Z, .jr_02_4961                                ;; 02:494e $28 $11
    ld   [wD61F_DemoRelatedCounter], A                                    ;; 02:4950 $ea $1f $d6
    inc  DE                                            ;; 02:4953 $13
    ld   A, [DE]                                       ;; 02:4954 $1a
    ld   [wD620_DemoInputs], A                         ;; 02:4955 $ea $20 $d6
    inc  DE                                            ;; 02:4958 $13
    ld   [HL], D                                       ;; 02:4959 $72
    dec  HL                                            ;; 02:495a $2b
    ld   [HL], E                                       ;; 02:495b $73
.jr_02_495c:
    ld   A, [wD620_DemoInputs]                                    ;; 02:495c $fa $20 $d6
    jr   .jr_02_4968                                   ;; 02:495f $18 $07
.jr_02_4961:
    ld   [wD61E_DemoModeEnabled], A                                    ;; 02:4961 $ea $1e $d6
    ret                                                ;; 02:4964 $c9
.jr_02_4965:
    ld   A, [wD59F_CurrentInputs]                                    ;; 02:4965 $fa $9f $d5
.jr_02_4968:
    ld   C, A                                          ;; 02:4968 $4f
    ld   E, A                                          ;; 02:4969 $5f
    ld   HL, wD759                                     ;; 02:496a $21 $59 $d7
    bit  0, [HL]                                       ;; 02:496d $cb $46
    jr   Z, .jr_02_4979                                ;; 02:496f $28 $08
    bit  0, E                                          ;; 02:4971 $cb $43
    jr   NZ, .jr_02_4977                               ;; 02:4973 $20 $02
    res  0, [HL]                                       ;; 02:4975 $cb $86
.jr_02_4977:
    res  0, C                                          ;; 02:4977 $cb $81
.jr_02_4979:
    bit  6, [HL]                                       ;; 02:4979 $cb $76
    jr   Z, .jr_02_4989                                ;; 02:497b $28 $0c
    bit  1, E                                          ;; 02:497d $cb $4b
    jr   NZ, .jr_02_4985                               ;; 02:497f $20 $04
    ld   A, [HL]                                       ;; 02:4981 $7e
    and  A, $0f                                        ;; 02:4982 $e6 $0f
    ld   [HL], A                                       ;; 02:4984 $77
.jr_02_4985:
    res  1, C                                          ;; 02:4985 $cb $89
    jr   .jr_02_49a4                                   ;; 02:4987 $18 $1b
.jr_02_4989:
    bit  7, [HL]                                       ;; 02:4989 $cb $7e
    jr   Z, .jr_02_49a4                                ;; 02:498b $28 $17
    res  1, C                                          ;; 02:498d $cb $89
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:498f $fa $60 $d7
    bit  7, A                                          ;; 02:4992 $cb $7f
    jr   Z, .jr_02_49a4                                ;; 02:4994 $28 $0e
    bit  1, E                                          ;; 02:4996 $cb $4b
    jr   NZ, .jr_02_499e                               ;; 02:4998 $20 $04
    set  4, [HL]                                       ;; 02:499a $cb $e6
    jr   .jr_02_49a4                                   ;; 02:499c $18 $06
.jr_02_499e:
    bit  4, [HL]                                       ;; 02:499e $cb $66
    jr   Z, .jr_02_49a4                                ;; 02:49a0 $28 $02
    set  1, C                                          ;; 02:49a2 $cb $c9
.jr_02_49a4:
    ld   HL, wD75A_CurrentInputsAlt                                     ;; 02:49a4 $21 $5a $d7
    ld   [HL], C                                       ;; 02:49a7 $71
    ld   HL, wD750                                     ;; 02:49a8 $21 $50 $d7
    ld   A, [HL]                                       ;; 02:49ab $7e
    and  A, A                                          ;; 02:49ac $a7
    jr   Z, .jr_02_49b0                                ;; 02:49ad $28 $01
    dec  [HL]                                          ;; 02:49af $35
.jr_02_49b0:
    call call_02_4a45_Player_UpdateFacing                                  ;; 02:49b0 $cd $45 $4a
    farcall call_03_4900_BgCollision_Update
    call call_02_4b78_Player_ApplyYVelocity                                  ;; 02:49be $cd $78 $4b
    farcall call_03_4c0a_BgCollision_CacheAdjacentTiles
    call call_02_4c4f_Player_CheckTileInteractions                                  ;; 02:49cc $cd $4f $4c
    ld   HL, wD745                                     ;; 02:49cf $21 $45 $d7
    ld   A, [HL]                                       ;; 02:49d2 $7e
    ld   [HL], $ff                                     ;; 02:49d3 $36 $ff
    cp   A, $ff                                        ;; 02:49d5 $fe $ff
    jr   Z, .jr_02_49e6                                ;; 02:49d7 $28 $0d
    call call_02_7102_Entity_SetAction                                  ;; 02:49d9 $cd $02 $71
    ld   A, $ff                                        ;; 02:49dc $3e $ff
    ld   [wD746_PlayerClimbingState], A                                    ;; 02:49de $ea $46 $d7
    ld   A, $00                                        ;; 02:49e1 $3e $00
    ld   [wD74B], A                                    ;; 02:49e3 $ea $4b $d7
.jr_02_49e6:
    ld   HL, wD202_PlayerEntity_ActionFunc                                     ;; 02:49e6 $21 $02 $d2
    ld   A, [HL+]                                      ;; 02:49e9 $2a
    ld   H, [HL]                                       ;; 02:49ea $66
    ld   L, A                                          ;; 02:49eb $6f
    call call_00_10bd_JumpHL                                  ;; 02:49ec $cd $bd $10
    call call_02_4a77_Player_ApplyXMovement                                  ;; 02:49ef $cd $77 $4a
    xor  A, A                                          ;; 02:49f2 $af
    ld   [wD758], A                                    ;; 02:49f3 $ea $58 $d7
    ld   HL, wD20E_PlayerXPosition                                     ;; 02:49f6 $21 $0e $d2
    ld   A, [HL+]                                      ;; 02:49f9 $2a
    ld   H, [HL]                                       ;; 02:49fa $66
    ld   L, A                                          ;; 02:49fb $6f
    add  HL, HL                                        ;; 02:49fc $29
    add  HL, HL                                        ;; 02:49fd $29
    add  HL, HL                                        ;; 02:49fe $29
    ld   A, H                                          ;; 02:49ff $7c
    ld   [wD76A_PlayerXPositionBlock], A                                    ;; 02:4a00 $ea $6a $d7
    ld   HL, wD209                                     ;; 02:4a03 $21 $09 $d2
    res  5, [HL]                                       ;; 02:4a06 $cb $ae
    ld   HL, wD20A                                     ;; 02:4a08 $21 $0a $d2
    res  6, [HL]                                       ;; 02:4a0b $cb $b6
    call call_02_6fda_Entity_TickAction                                  ;; 02:4a0d $cd $da $6f
    call call_02_715a_MapWindow_Update                                  ;; 02:4a10 $cd $5a $71
    call call_02_4c28_Player_CheckConveyorWaterTiles                                  ;; 02:4a13 $cd $28 $4c
    farcall call_03_5ca8_Player_BuildBodySprites
    ld   HL, wD751                                     ;; 02:4a21 $21 $51 $d7
    call call_02_4a30_Player_DecrementTimer16                                  ;; 02:4a24 $cd $30 $4a
    ld   HL, wD755                                     ;; 02:4a27 $21 $55 $d7
    call call_02_4a30_Player_DecrementTimer16                                  ;; 02:4a2a $cd $30 $4a
    ld   HL, wD753                                     ;; 02:4a2d $21 $53 $d7

call_02_4a30_Player_DecrementTimer16:
; Decrements a 16-bit timer at HL (little-endian). Returns immediately if already zero
    ld   A, [HL+]                                      ;; 02:4a30 $2a
    ld   D, [HL]                                       ;; 02:4a31 $56
    ld   E, A                                          ;; 02:4a32 $5f
    or   A, D                                          ;; 02:4a33 $b2
    ret  Z                                             ;; 02:4a34 $c8
    dec  DE                                            ;; 02:4a35 $1b
    ld   [HL], D                                       ;; 02:4a36 $72
    dec  HL                                            ;; 02:4a37 $2b
    ld   [HL], E                                       ;; 02:4a38 $73
    ret                                                ;; 02:4a39 $c9

call_02_4a3a_Player_SetWallJumpFlag:
; Preserves low nibble of wD759, sets bit 7. Used to mark that Gex is in a wall-jump eligible state
    ld   A, [wD759]                                    ;; 02:4a3a $fa $59 $d7
    and  A, $0f                                        ;; 02:4a3d $e6 $0f
    or   A, $80                                        ;; 02:4a3f $f6 $80
    ld   [wD759], A                                    ;; 02:4a41 $ea $59 $d7
    ret                                                ;; 02:4a44 $c9

call_02_4a45_Player_UpdateFacing:
; Only runs if not climbing ($FF). Reads directional input bits $30 from wD75A: bit 4 = right, else left (C=$20). 
; Writes the new facing to wD20D. If facing changed, resets wD75D (X speed accumulator) to 0 and returns. 
; If facing unchanged, ramps wD75D up toward wD75E (max X speed), incrementing by 1 per frame
    ld   A, [wD746_PlayerClimbingState]                                    ;; 02:4a45 $fa $46 $d7
    cp   A, $ff                                        ;; 02:4a48 $fe $ff
    ret  NZ                                            ;; 02:4a4a $c0
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4a4b $fa $5a $d7
    and  A, $30                                        ;; 02:4a4e $e6 $30
    jr   Z, .jr_02_4a62                                ;; 02:4a50 $28 $10
    ld   C, $00                                        ;; 02:4a52 $0e $00
    and  A, $10                                        ;; 02:4a54 $e6 $10
    jr   NZ, .jr_02_4a5a                               ;; 02:4a56 $20 $02
    ld   C, $20                                        ;; 02:4a58 $0e $20
.jr_02_4a5a:
    ld   HL, wD20D_PlayerFacingAngle                                     ;; 02:4a5a $21 $0d $d2
    ld   A, [HL]                                       ;; 02:4a5d $7e
    ld   [HL], C                                       ;; 02:4a5e $71
    cp   A, C                                          ;; 02:4a5f $b9
    jr   Z, .jr_02_4a67                                ;; 02:4a60 $28 $05
.jr_02_4a62:
    xor  A, A                                          ;; 02:4a62 $af
    ld   [wD75D_PlayerXSpeedPrev], A                                    ;; 02:4a63 $ea $5d $d7
    ret                                                ;; 02:4a66 $c9
.jr_02_4a67:
    ld   A, [wD75D_PlayerXSpeedPrev]                                    ;; 02:4a67 $fa $5d $d7
    ld   HL, wD75E_PlayerXSpeed                                     ;; 02:4a6a $21 $5e $d7
    cp   A, [HL]                                       ;; 02:4a6d $be
    jr   C, .jr_02_4a72                                ;; 02:4a6e $38 $02
    ld   A, [HL]                                       ;; 02:4a70 $7e
    dec  A                                             ;; 02:4a71 $3d
.jr_02_4a72:
    inc  A                                             ;; 02:4a72 $3c
    ld   [wD75D_PlayerXSpeedPrev], A                                    ;; 02:4a73 $ea $5d $d7
    ret                                                ;; 02:4a76 $c9

call_02_4a77_Player_ApplyXMovement:
; Only runs if not climbing. Takes wD75D (previous X speed), negates if facing left, adds wD75C sub-pixel 
; accumulator. Returns if zero. If collision flags low nibble is set (wall hit), applies an equal Y nudge 
; (upward, B=$FF) before the X move. Then applies the X delta: if moving left, calls the left-push path; 
; if moving right, calls the right-push path. Both paths check wD74E/wD74F (scroll lock flags): 
; if both clear, applies delta directly to wD20E/wD20F. If wD74E is set, reads the entity's scroll 
; constraint field (bit 7 = hard lock or soft lock), compares player screen X (wD212) to the constraint 
; threshold, and either clamps to the saved world X or applies the delta with the constraint offset 
; subtracted/added
    ld   A, [wD746_PlayerClimbingState]                                    ;; 02:4a77 $fa $46 $d7
    cp   A, $ff                                        ;; 02:4a7a $fe $ff
    ret  NZ                                            ;; 02:4a7c $c0
    ld   A, [wD75D_PlayerXSpeedPrev]                                    ;; 02:4a7d $fa $5d $d7
    ld   HL, wD20D_PlayerFacingAngle                                     ;; 02:4a80 $21 $0d $d2
    bit  5, [HL]                                       ;; 02:4a83 $cb $6e
    jr   Z, .jr_02_4a89                                ;; 02:4a85 $28 $02
    cpl                                                ;; 02:4a87 $2f
    inc  A                                             ;; 02:4a88 $3c
.jr_02_4a89:
    ld   HL, wD75C                                     ;; 02:4a89 $21 $5c $d7
    add  A, [HL]                                       ;; 02:4a8c $86
    ret  Z                                             ;; 02:4a8d $c8
    push AF                                            ;; 02:4a8e $f5
    ld   A, [wD585_CollisionFlags]                                    ;; 02:4a8f $fa $85 $d5
    and  A, $0f                                        ;; 02:4a92 $e6 $0f
    jr   Z, .jr_02_4a9e                                ;; 02:4a94 $28 $08
    cpl                                                ;; 02:4a96 $2f
    inc  A                                             ;; 02:4a97 $3c
    ld   C, A                                          ;; 02:4a98 $4f
    ld   B, $ff                                        ;; 02:4a99 $06 $ff
    call call_02_4c19_Player_AddToYPosition                                  ;; 02:4a9b $cd $19 $4c
.jr_02_4a9e:
    pop  AF                                            ;; 02:4a9e $f1
    ld   C, A                                          ;; 02:4a9f $4f
    bit  7, A                                          ;; 02:4aa0 $cb $7f
    jr   Z, .jr_02_4b10                                ;; 02:4aa2 $28 $6c
    cpl                                                ;; 02:4aa4 $2f
    inc  A                                             ;; 02:4aa5 $3c
    ld   C, A                                          ;; 02:4aa6 $4f
    jp   .jp_02_4aaa                                   ;; 02:4aa7 $c3 $aa $4a
.jp_02_4aaa:
    ld   A, [wD74E]                                    ;; 02:4aaa $fa $4e $d7
    and  A, A                                          ;; 02:4aad $a7
    jr   NZ, .jr_02_4ac0                               ;; 02:4aae $20 $10
    ld   A, [wD74F]                                    ;; 02:4ab0 $fa $4f $d7
    and  A, A                                          ;; 02:4ab3 $a7
    ret  NZ                                            ;; 02:4ab4 $c0
.jr_02_4ab5:
    ld   HL, wD20E_PlayerXPosition                                     ;; 02:4ab5 $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4ab8 $7e
    sub  A, C                                          ;; 02:4ab9 $91
    ld   [HL+], A                                      ;; 02:4aba $22
    ld   A, [HL]                                       ;; 02:4abb $7e
    sbc  A, $00                                        ;; 02:4abc $de $00
    ld   [HL], A                                       ;; 02:4abe $77
    ret                                                ;; 02:4abf $c9
.jr_02_4ac0:
    or   A, $16                                        ;; 02:4ac0 $f6 $16
    ld   L, A                                          ;; 02:4ac2 $6f
    ld   H, $d2                                        ;; 02:4ac3 $26 $d2
    bit  7, [HL]                                       ;; 02:4ac5 $cb $7e
    jr   Z, .jr_02_4ae8                                ;; 02:4ac7 $28 $1f
    ld   A, L                                          ;; 02:4ac9 $7d
    xor  A, $04                                        ;; 02:4aca $ee $04
    ld   L, A                                          ;; 02:4acc $6f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 02:4acd $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4ad0 $be
    jr   C, .jr_02_4ab5                                ;; 02:4ad1 $38 $e2
    ld   A, L                                          ;; 02:4ad3 $7d
    xor  A, $06                                        ;; 02:4ad4 $ee $06
    ld   L, A                                          ;; 02:4ad6 $6f
    ld   D, [HL]                                       ;; 02:4ad7 $56
    ld   A, L                                          ;; 02:4ad8 $7d
    xor  A, $1a                                        ;; 02:4ad9 $ee $1a
    ld   L, A                                          ;; 02:4adb $6f
    ld   A, [HL+]                                      ;; 02:4adc $2a
    add  A, D                                          ;; 02:4add $82
    ld   [wD20E_PlayerXPosition], A                                    ;; 02:4ade $ea $0e $d2
    ld   A, [HL]                                       ;; 02:4ae1 $7e
    adc  A, $00                                        ;; 02:4ae2 $ce $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 02:4ae4 $ea $0f $d2
    ret                                                ;; 02:4ae7 $c9
.jr_02_4ae8:
    push HL                                            ;; 02:4ae8 $e5
    ld   HL, wD20E_PlayerXPosition                                     ;; 02:4ae9 $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4aec $7e
    sub  A, C                                          ;; 02:4aed $91
    ld   [HL+], A                                      ;; 02:4aee $22
    ld   C, A                                          ;; 02:4aef $4f
    ld   A, [HL]                                       ;; 02:4af0 $7e
    sbc  A, $00                                        ;; 02:4af1 $de $00
    ld   [HL], A                                       ;; 02:4af3 $77
    ld   B, A                                          ;; 02:4af4 $47
    pop  HL                                            ;; 02:4af5 $e1
    ld   A, L                                          ;; 02:4af6 $7d
    xor  A, $04                                        ;; 02:4af7 $ee $04
    ld   L, A                                          ;; 02:4af9 $6f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 02:4afa $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4afd $be
    ret  C                                             ;; 02:4afe $d8
    ld   A, L                                          ;; 02:4aff $7d
    xor  A, $06                                        ;; 02:4b00 $ee $06
    ld   L, A                                          ;; 02:4b02 $6f
    ld   D, [HL]                                       ;; 02:4b03 $56
    ld   A, L                                          ;; 02:4b04 $7d
    xor  A, $1a                                        ;; 02:4b05 $ee $1a
    ld   L, A                                          ;; 02:4b07 $6f
    ld   A, C                                          ;; 02:4b08 $79
    sub  A, D                                          ;; 02:4b09 $92
    ld   [HL+], A                                      ;; 02:4b0a $22
    ld   A, B                                          ;; 02:4b0b $78
    sbc  A, $00                                        ;; 02:4b0c $de $00
    ld   [HL], A                                       ;; 02:4b0e $77
    ret                                                ;; 02:4b0f $c9
.jr_02_4b10:
    ld   A, [wD74E]                                    ;; 02:4b10 $fa $4e $d7
    and  A, A                                          ;; 02:4b13 $a7
    jr   NZ, .jr_02_4b26                               ;; 02:4b14 $20 $10
    ld   A, [wD74F]                                    ;; 02:4b16 $fa $4f $d7
    and  A, A                                          ;; 02:4b19 $a7
    ret  NZ                                            ;; 02:4b1a $c0
.jr_02_4b1b:
    ld   HL, wD20E_PlayerXPosition                                     ;; 02:4b1b $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4b1e $7e
    add  A, C                                          ;; 02:4b1f $81
    ld   [HL+], A                                      ;; 02:4b20 $22
    ld   A, [HL]                                       ;; 02:4b21 $7e
    adc  A, $00                                        ;; 02:4b22 $ce $00
    ld   [HL], A                                       ;; 02:4b24 $77
    ret                                                ;; 02:4b25 $c9
.jr_02_4b26:
    or   A, $16                                        ;; 02:4b26 $f6 $16
    ld   L, A                                          ;; 02:4b28 $6f
    ld   H, $d2                                        ;; 02:4b29 $26 $d2
    bit  7, [HL]                                       ;; 02:4b2b $cb $7e
    jr   Z, .jr_02_4b4f                                ;; 02:4b2d $28 $20
    ld   A, L                                          ;; 02:4b2f $7d
    xor  A, $04                                        ;; 02:4b30 $ee $04
    ld   L, A                                          ;; 02:4b32 $6f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 02:4b33 $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4b36 $be
    jr   NC, .jr_02_4b1b                               ;; 02:4b37 $30 $e2
    ld   A, L                                          ;; 02:4b39 $7d
    xor  A, $06                                        ;; 02:4b3a $ee $06
    ld   L, A                                          ;; 02:4b3c $6f
    ld   D, [HL]                                       ;; 02:4b3d $56
    inc  D                                             ;; 02:4b3e $14
    ld   A, L                                          ;; 02:4b3f $7d
    xor  A, $1a                                        ;; 02:4b40 $ee $1a
    ld   L, A                                          ;; 02:4b42 $6f
    ld   A, [HL+]                                      ;; 02:4b43 $2a
    sub  A, D                                          ;; 02:4b44 $92
    ld   [wD20E_PlayerXPosition], A                                    ;; 02:4b45 $ea $0e $d2
    ld   A, [HL]                                       ;; 02:4b48 $7e
    sbc  A, $00                                        ;; 02:4b49 $de $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 02:4b4b $ea $0f $d2
    ret                                                ;; 02:4b4e $c9
.jr_02_4b4f:
    push HL                                            ;; 02:4b4f $e5
    ld   HL, wD20E_PlayerXPosition                                     ;; 02:4b50 $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4b53 $7e
    add  A, C                                          ;; 02:4b54 $81
    ld   [HL+], A                                      ;; 02:4b55 $22
    ld   C, A                                          ;; 02:4b56 $4f
    ld   A, [HL]                                       ;; 02:4b57 $7e
    adc  A, $00                                        ;; 02:4b58 $ce $00
    ld   [HL], A                                       ;; 02:4b5a $77
    ld   B, A                                          ;; 02:4b5b $47
    pop  HL                                            ;; 02:4b5c $e1
    ld   A, L                                          ;; 02:4b5d $7d
    xor  A, $04                                        ;; 02:4b5e $ee $04
    ld   L, A                                          ;; 02:4b60 $6f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 02:4b61 $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4b64 $be
    ret  NC                                            ;; 02:4b65 $d0
    ld   A, L                                          ;; 02:4b66 $7d
    xor  A, $06                                        ;; 02:4b67 $ee $06
    ld   L, A                                          ;; 02:4b69 $6f
    ld   D, [HL]                                       ;; 02:4b6a $56
    inc  D                                             ;; 02:4b6b $14
    ld   A, L                                          ;; 02:4b6c $7d
    xor  A, $1a                                        ;; 02:4b6d $ee $1a
    ld   L, A                                          ;; 02:4b6f $6f
    ld   A, C                                          ;; 02:4b70 $79
    add  A, D                                          ;; 02:4b71 $82
    ld   [HL+], A                                      ;; 02:4b72 $22
    ld   A, B                                          ;; 02:4b73 $78
    adc  A, $00                                        ;; 02:4b74 $ce $00
    ld   [HL], A                                       ;; 02:4b76 $77
    ret                                                ;; 02:4b77 $c9

call_02_4b78_Player_ApplyYVelocity:
; Only runs if not climbing. If Y velocity is positive (falling) or zero, skips to landing check. 
; If falling (velocity > 0): clears wD763 (fall distance counter), then applies gravity: 
; subtracts 2 from Y velocity, clamps to $C0 (max fall speed); while falling, increments wD763 
; (capped at $7F→$80). Converts velocity to a pixel delta (negate, swap nibbles, low 4 bits = pixel count, 
; bit 3 = sign for larger values), calls UpdatePlayerYPosition. Landing check: if bit 7 of collision 
; flags is set (on ground): reads wD761 (floor snap distance). If nonzero: if previous frame was also 
; grounded or snap distance ≥ current velocity, applies snap; otherwise continues falling. 
; If wD761 = 0 (exactly on floor): zeroes Y velocity, reads fall distance wD763. 
; If < 8: clears wD762 (jump velocity). 
; If 8–$0F: calls Player_SetLandingAction (light/run landing). 
; If ≥ $10: sets action $19 (hard landing). 
; If not grounded this frame but was last frame (just walked off edge): if fall distance < $10, 
; sets action $17 (stumble/fall start), then continues applying gravity
    ld   A, [wD746_PlayerClimbingState]                                    ;; 02:4b78 $fa $46 $d7
    cp   A, $ff                                        ;; 02:4b7b $fe $ff
    ret  NZ                                            ;; 02:4b7d $c0
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:4b7e $fa $60 $d7
    bit  7, A                                          ;; 02:4b81 $cb $7f
    jr   NZ, .jr_02_4bbc                               ;; 02:4b83 $20 $37
    and  A, A                                          ;; 02:4b85 $a7
    jr   Z, .jr_02_4bbc                                ;; 02:4b86 $28 $34
    xor  A, A                                          ;; 02:4b88 $af
    ld   [wD763_PlayerMovementFlags], A                                    ;; 02:4b89 $ea $63 $d7
.jr_02_4b8c:
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:4b8c $fa $60 $d7
    sub  A, $02                                        ;; 02:4b8f $d6 $02
    bit  7, A                                          ;; 02:4b91 $cb $7f
    jr   Z, .jr_02_4ba4                                ;; 02:4b93 $28 $0f
    cp   A, $c0                                        ;; 02:4b95 $fe $c0
    jr   NC, .jr_02_4ba4                               ;; 02:4b97 $30 $0b
    ld   HL, wD763_PlayerMovementFlags                                     ;; 02:4b99 $21 $63 $d7
    ld   A, [HL]                                       ;; 02:4b9c $7e
    cp   A, $7f                                        ;; 02:4b9d $fe $7f
    adc  A, $00                                        ;; 02:4b9f $ce $00
    ld   [HL], A                                       ;; 02:4ba1 $77
    ld   A, $c0                                        ;; 02:4ba2 $3e $c0
.jr_02_4ba4:
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4ba4 $ea $60 $d7
    cpl                                                ;; 02:4ba7 $2f
    inc  A                                             ;; 02:4ba8 $3c
    swap A                                             ;; 02:4ba9 $cb $37
    and  A, $0f                                        ;; 02:4bab $e6 $0f
    ld   C, A                                          ;; 02:4bad $4f
    ld   B, $00                                        ;; 02:4bae $06 $00
    bit  3, A                                          ;; 02:4bb0 $cb $5f
    jp   Z, call_02_4c19_Player_AddToYPosition                               ;; 02:4bb2 $ca $19 $4c
    or   A, $f0                                        ;; 02:4bb5 $f6 $f0
    ld   C, A                                          ;; 02:4bb7 $4f
    dec  B                                             ;; 02:4bb8 $05
    jp   call_02_4c19_Player_AddToYPosition                                  ;; 02:4bb9 $c3 $19 $4c
.jr_02_4bbc:
    ld   A, [wD585_CollisionFlags]                                    ;; 02:4bbc $fa $85 $d5
    and  A, $80                                        ;; 02:4bbf $e6 $80
    jr   Z, .jr_02_4bd8                                ;; 02:4bc1 $28 $15
    ld   A, [wD761_PlayerFallingFlag]                                    ;; 02:4bc3 $fa $61 $d7
    and  A, A                                          ;; 02:4bc6 $a7
    jr   Z, .jr_02_4bed                                ;; 02:4bc7 $28 $24
    ld   HL, wD584_CollisionFlagsPrev                                     ;; 02:4bc9 $21 $84 $d5
    bit  7, [HL]                                       ;; 02:4bcc $cb $7e
    jr   NZ, .jr_02_4ba4                               ;; 02:4bce $20 $d4
    ld   HL, wD760_PlayerYVelocity                                     ;; 02:4bd0 $21 $60 $d7
    cp   A, [HL]                                       ;; 02:4bd3 $be
    jr   NC, .jr_02_4ba4                               ;; 02:4bd4 $30 $ce
    jr   .jr_02_4b8c                                   ;; 02:4bd6 $18 $b4
.jr_02_4bd8:
    ld   A, [wD584_CollisionFlagsPrev]                                    ;; 02:4bd8 $fa $84 $d5
    and  A, $80                                        ;; 02:4bdb $e6 $80
    jr   NZ, .jr_02_4be6                               ;; 02:4bdd $20 $07
    ld   A, [wD763_PlayerMovementFlags]                                    ;; 02:4bdf $fa $63 $d7
    cp   A, $10                                        ;; 02:4be2 $fe $10
    jr   C, .jr_02_4b8c                                ;; 02:4be4 $38 $a6
.jr_02_4be6:
    ld   A, $17                                        ;; 02:4be6 $3e $17
    call call_02_4ccd_Player_RequestAction                                  ;; 02:4be8 $cd $cd $4c
    jr   .jr_02_4b8c                                   ;; 02:4beb $18 $9f
.jr_02_4bed:
    xor  A, A                                          ;; 02:4bed $af
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4bee $ea $60 $d7
    ld   HL, wD763_PlayerMovementFlags                                     ;; 02:4bf1 $21 $63 $d7
    ld   A, [HL]                                       ;; 02:4bf4 $7e
    ld   [HL], $00                                     ;; 02:4bf5 $36 $00
    cp   A, $08                                        ;; 02:4bf7 $fe $08
    jr   NC, .jr_02_4c00                               ;; 02:4bf9 $30 $05
    xor  A, A                                          ;; 02:4bfb $af
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:4bfc $ea $62 $d7
    ret                                                ;; 02:4bff $c9
.jr_02_4c00:
    cp   A, $10                                        ;; 02:4c00 $fe $10
    jp   C, call_02_489a_Player_SetLandingAction                                 ;; 02:4c02 $da $9a $48
    ld   A, $19                                        ;; 02:4c05 $3e $19
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:4c07 $c3 $cd $4c

call_02_4c0a_Player_AddToXPosition:
; Adds signed 16-bit (C, B) to wD20E/wD20F (player world X)
    ld   A, [wD20E_PlayerXPosition]                                    ;; 02:4c0a $fa $0e $d2
    add  A, C                                          ;; 02:4c0d $81
    ld   [wD20E_PlayerXPosition], A                                    ;; 02:4c0e $ea $0e $d2
    ld   A, [wD20F_PlayerXPosition]                                    ;; 02:4c11 $fa $0f $d2
    adc  A, B                                          ;; 02:4c14 $88
    ld   [wD20F_PlayerXPosition], A                                    ;; 02:4c15 $ea $0f $d2
    ret                                                ;; 02:4c18 $c9

call_02_4c19_Player_AddToYPosition:
; Adds signed 16-bit (C, B) to wD210/wD211 (player world Y)
    ld   A, [wD210_PlayerYPosition]                                    ;; 02:4c19 $fa $10 $d2
    add  A, C                                          ;; 02:4c1c $81
    ld   [wD210_PlayerYPosition], A                                    ;; 02:4c1d $ea $10 $d2
    ld   A, [wD211_PlayerYPosition]                                    ;; 02:4c20 $fa $11 $d2
    adc  A, B                                          ;; 02:4c23 $88
    ld   [wD211_PlayerYPosition], A                                    ;; 02:4c24 $ea $11 $d2
    ret                                                ;; 02:4c27 $c9

call_02_4c28_Player_CheckConveyorWaterTiles:
; Checks tile types cached in wD765/wD767 against $25 (conveyor?) and $24 (water?). 
; If any match, sets wD74A = 0 (flag active), otherwise $80 (inactive). 
; If wD765 = $24 specifically, triggers action $1C (enter water)
    ld   A, [wD765_TileTypeBehindGexsBody]                                    ;; 02:4c28 $fa $65 $d7
    sub  A, $25                                        ;; 02:4c2b $d6 $25
    jr   Z, .jr_02_4c3f                                ;; 02:4c2d $28 $10
    ld   A, [wD767_FloorTileType]                                    ;; 02:4c2f $fa $67 $d7
    sub  A, $25                                        ;; 02:4c32 $d6 $25
    jr   Z, .jr_02_4c3f                                ;; 02:4c34 $28 $09
    ld   A, [wD765_TileTypeBehindGexsBody]                                    ;; 02:4c36 $fa $65 $d7
    sub  A, $24                                        ;; 02:4c39 $d6 $24
    jr   Z, .jr_02_4c3f                                ;; 02:4c3b $28 $02
    ld   A, $80                                        ;; 02:4c3d $3e $80
.jr_02_4c3f:
    xor  A, $80                                        ;; 02:4c3f $ee $80
    ld   [wD74A], A                                    ;; 02:4c41 $ea $4a $d7
    ld   A, [wD765_TileTypeBehindGexsBody]                                    ;; 02:4c44 $fa $65 $d7
    cp   A, $24                                        ;; 02:4c47 $fe $24
    ld   A, $1c                                        ;; 02:4c49 $3e $1c
    call Z, call_02_4ccd_Player_RequestAction                               ;; 02:4c4b $cc $cd $4c
    ret                                                ;; 02:4c4e $c9

call_02_4c4f_Player_CheckTileInteractions:
; Checks for kill tiles and climb entry. If action is $10 or $11 (already dying/dead), skips kill check. 
; Otherwise if wD764 or wD765 = $23 (instant-kill tile), jumps to call_00_0696 (player death). 
; Then if down/crouch input (bit 6 of wD75A) is pressed: checks wD764 for tile $22 → action $1A (enter door); 
; tile $26 → action $1D (enter climb); checks wD766 (face tile) for $2C/$2D (directional ladder entry, 
; facing-direction validated) → action $1D. If none of those, looks up current action ID in data_02_4d15_ActionInputTransitionTable 
; for an input→action transition table, scans it for matching input (with $FE = "any nonzero" wildcard), 
; and calls Player_RequestAction with the found action
    ld   A, [wD201_PlayerEntity_ActionId]                                    ;; 02:4c4f $fa $01 $d2
    cp   A, $10                                        ;; 02:4c52 $fe $10
    jr   Z, .jr_02_4c6a                                ;; 02:4c54 $28 $14
    cp   A, $11                                        ;; 02:4c56 $fe $11
    jr   Z, .jr_02_4c6a                                ;; 02:4c58 $28 $10
    ld   A, [wD764_TileTypeBehindGexsBody]                                    ;; 02:4c5a $fa $64 $d7
    cp   A, $23                                        ;; 02:4c5d $fe $23
    jp   Z, call_00_0696                                 ;; 02:4c5f $ca $96 $06
    ld   A, [wD765_TileTypeBehindGexsBody]                                    ;; 02:4c62 $fa $65 $d7
    cp   A, $23                                        ;; 02:4c65 $fe $23
    jp   Z, call_00_0696                                 ;; 02:4c67 $ca $96 $06
.jr_02_4c6a:
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4c6a $fa $5a $d7
    and  A, $40                                        ;; 02:4c6d $e6 $40
    jr   Z, .jr_02_4ca6                                ;; 02:4c6f $28 $35
    ld   A, [wD764_TileTypeBehindGexsBody]                                    ;; 02:4c71 $fa $64 $d7
    cp   A, $22                                        ;; 02:4c74 $fe $22
    ld   A, $1a                                        ;; 02:4c76 $3e $1a
    jr   Z, call_02_4ccd_Player_RequestAction                               ;; 02:4c78 $28 $53
    ld   A, [wD764_TileTypeBehindGexsBody]                                    ;; 02:4c7a $fa $64 $d7
    ld   [wD769], A                                    ;; 02:4c7d $ea $69 $d7
    cp   A, $26                                        ;; 02:4c80 $fe $26
    jr   Z, .jr_02_4ca2                                ;; 02:4c82 $28 $1e
    ld   A, [wD766_TileTypeBehindGexsFace]                                    ;; 02:4c84 $fa $66 $d7
    ld   [wD769], A                                    ;; 02:4c87 $ea $69 $d7
    cp   A, $2c                                        ;; 02:4c8a $fe $2c
    jr   Z, .jr_02_4c9b                                ;; 02:4c8c $28 $0d
    cp   A, $2d                                        ;; 02:4c8e $fe $2d
    jr   NZ, .jr_02_4ca6                               ;; 02:4c90 $20 $14
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 02:4c92 $fa $0d $d2
    cp   A, $00                                        ;; 02:4c95 $fe $00
    jr   NZ, .jr_02_4ca6                               ;; 02:4c97 $20 $0d
    jr   .jr_02_4ca2                                   ;; 02:4c99 $18 $07
.jr_02_4c9b:
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 02:4c9b $fa $0d $d2
    cp   A, $20                                        ;; 02:4c9e $fe $20
    jr   NZ, .jr_02_4ca6                               ;; 02:4ca0 $20 $04
.jr_02_4ca2:
    ld   A, $1d                                        ;; 02:4ca2 $3e $1d
    jr   call_02_4ccd_Player_RequestAction                                  ;; 02:4ca4 $18 $27
.jr_02_4ca6:
    ld   HL, wD201_PlayerEntity_ActionId                                     ;; 02:4ca6 $21 $01 $d2
    ld   L, [HL]                                       ;; 02:4ca9 $6e
    ld   H, $00                                        ;; 02:4caa $26 $00
    add  HL, HL                                        ;; 02:4cac $29
    ld   DE, data_02_4d15_ActionInputTransitionTable                              ;; 02:4cad $11 $15 $4d
    add  HL, DE                                        ;; 02:4cb0 $19
    ld   A, [HL+]                                      ;; 02:4cb1 $2a
    ld   H, [HL]                                       ;; 02:4cb2 $66
    ld   L, A                                          ;; 02:4cb3 $6f
    or   A, H                                          ;; 02:4cb4 $b4
    ret  Z                                             ;; 02:4cb5 $c8
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4cb6 $fa $5a $d7
    ld   C, A                                          ;; 02:4cb9 $4f
.jr_02_4cba:
    ld   A, [HL+]                                      ;; 02:4cba $2a
    cp   A, $ff                                        ;; 02:4cbb $fe $ff
    ret  Z                                             ;; 02:4cbd $c8
    cp   A, $fe                                        ;; 02:4cbe $fe $fe
    jr   NZ, .jr_02_4cc6                               ;; 02:4cc0 $20 $04
    inc  C                                             ;; 02:4cc2 $0c
    dec  C                                             ;; 02:4cc3 $0d
    jr   NZ, .jr_02_4ccc                               ;; 02:4cc4 $20 $06
.jr_02_4cc6:
    cp   A, C                                          ;; 02:4cc6 $b9
    jr   Z, .jr_02_4ccc                                ;; 02:4cc7 $28 $03
    inc  HL                                            ;; 02:4cc9 $23
    jr   .jr_02_4cba                                   ;; 02:4cca $18 $ee
.jr_02_4ccc:
    ld   A, [HL+]                                      ;; 02:4ccc $2a

call_02_4ccd_Player_RequestAction:
; Sets a pending action change. Compares requested action A against current wD201 — returns if same. 
; Looks up the requested action in .data_02_4cf5_ActionTransitionFlagsTable (32-byte flags table). 
; Bit 0 set = "instant" (always allowed, stores directly to wD745). 
; Bit 0 clear: checks bit 7 of wD745 — if set (action already pending), reads the pending action's flags instead of current; 
; bit 1 of that = "locked" (can't be overridden), returns without storing. Otherwise stores new action to wD745
    ld   HL, wD201_PlayerEntity_ActionId                                     ;; 02:4ccd $21 $01 $d2
    cp   A, [HL]                                       ;; 02:4cd0 $be
    ret  Z                                             ;; 02:4cd1 $c8
    ld   L, A                                          ;; 02:4cd2 $6f
    ld   H, $00                                        ;; 02:4cd3 $26 $00
    ld   DE, .data_02_4cf5_ActionTransitionFlagsTable                             ;; 02:4cd5 $11 $f5 $4c
    add  HL, DE                                        ;; 02:4cd8 $19
    bit  0, [HL]                                       ;; 02:4cd9 $cb $46
    jr   NZ, .jr_02_4cf1                               ;; 02:4cdb $20 $14
    ld   HL, wD745                                     ;; 02:4cdd $21 $45 $d7
    bit  7, [HL]                                       ;; 02:4ce0 $cb $7e
    jr   Z, .jr_02_4ce7                                ;; 02:4ce2 $28 $03
    ld   HL, wD201_PlayerEntity_ActionId                                     ;; 02:4ce4 $21 $01 $d2
.jr_02_4ce7:
    ld   L, [HL]                                       ;; 02:4ce7 $6e
    ld   H, $00                                        ;; 02:4ce8 $26 $00
    ld   DE, .data_02_4cf5_ActionTransitionFlagsTable                             ;; 02:4cea $11 $f5 $4c
    add  HL, DE                                        ;; 02:4ced $19
    bit  1, [HL]                                       ;; 02:4cee $cb $4e
    ret  NZ                                            ;; 02:4cf0 $c0
.jr_02_4cf1:
    ld   [wD745], A                                    ;; 02:4cf1 $ea $45 $d7
    ret                                                ;; 02:4cf4 $c9
.data_02_4cf5_ActionTransitionFlagsTable:
; 32-byte table, one entry per action ID. Bit 0 = instant transition (bypasses lock check). 
; Bit 1 = transition-locked (cannot be overridden once queued). 
; Actions 
; $0F = instant; 
; $10–$13 = instant+locked (death/hurt states); 
; $14 = instant only
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4cf5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $01        ;; 02:4cfd ????????
    db   $03, $03, $03, $03, $01, $00, $00, $00        ;; 02:4d05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4d0d ????????

data_02_4d15_ActionInputTransitionTable:
; 32-entry pointer table (one per action ID), pointing to input→action lists used by call_02_4c4f. 
; Each list is pairs of (input byte, action ID) terminated by $FF. $FE = wildcard (any nonzero input). 
; Null pointers = no transitions for that action. Covers idle, walk, run, jump, tail-whip, 
; wall-slide, and other states
    dw   .data_02_4d55, $0000, .data_02_4d58, .data_02_4d58        ;; 02:4d15 ........
    dw   .data_02_4d65, .data_02_4d78, .data_02_4d8b, .data_02_4d92        ;; 02:4d1d ......??
    dw   .data_02_4d9b, .data_02_4da2, .data_02_4da9, .data_02_4db0        ;; 02:4d25 ......??
    dw   .data_02_4db1, .data_02_4db2, .data_02_4db3, $0000        ;; 02:4d2d ??..????
    dw   $0000, $0000, $0000, $0000        ;; 02:4d35 ......??
    dw   $0000, .data_02_4db4, .data_02_4dc5, $0000        ;; 02:4d3d ..??....
    dw   $0000, $0000, $0000, $0000        ;; 02:4d45 ??..????
    dw   $0000, $0000, $0000, $0000        ;; 02:4d4d ??..????
.data_02_4d55:
    db   $fe, $01, $ff
.data_02_4d58:
    db   $02, $09, $01, $0d, $80        ;; 02:4d55 .w..w.w.
    db   $08, $04, $0e, $10, $04, $20, $04, $ff        ;; 02:4d5d w.?.w.w.
.data_02_4d65:
    db   $12, $09, $22, $09, $11, $0d, $21, $0d        ;; 02:4d65 .w.w.?.w
    db   $90, $08, $a0, $08, $14, $0e, $24, $0e        ;; 02:4d6d .?.?.?.?
    db   $00, $02, $ff
.data_02_4d78:
    db   $12, $09, $22, $09, $11        ;; 02:4d75 .w..w.w.
    db   $0d, $21, $0d, $92, $0c, $a2, $0c, $80        ;; 02:4d7d w.w.?.?.
    db   $06, $40, $06, $00, $06, $ff
.data_02_4d8b:
    db   $10, $04        ;; 02:4d85 ?.?.w..?
    db   $20, $04, $fe, $02, $ff
.data_02_4d92:
    db   $02, $09, $04        ;; 02:4d8d .w.w.???
    db   $0e, $10, $04, $20, $04, $ff
.data_02_4d9b:
    db   $02, $09        ;; 02:4d95 ??????.?
    db   $01, $0d, $00, $02, $ff
.data_02_4da2:
    db   $01, $0d, $11        ;; 02:4d9d .?.w..w.
    db   $0d, $21, $0d, $ff
.data_02_4da9:
    db   $01, $0d, $11, $0d        ;; 02:4da5 w.?..?.?
    db   $21, $0d, $ff
.data_02_4db0:
    db   $ff
.data_02_4db1:
    db   $ff
.data_02_4db2:
    db   $ff
.data_02_4db3:
    db   $ff
.data_02_4db4:
    db   $12        ;; 02:4dad .w.??.??
    db   $09, $22, $09, $11, $0d, $21, $0d, $90        ;; 02:4db5 ????????
    db   $08, $a0, $08, $14, $0e, $24, $0e, $ff        ;; 02:4dbd ????????
.data_02_4dc5:
    db   $12, $09, $22, $09, $11, $0d, $21, $0d        ;; 02:4dc5 .w.?.?.?
    db   $90, $08, $a0, $08, $14, $0e, $24, $0e        ;; 02:4dcd .?.?.?.?
    db   $00, $02, $ff                                 ;; 02:4dd5 .?.

call_02_4dd8_Player_GetMaxHealth:
; Returns $7D (125) in A — the player's maximum health value
    ld   A, $7d                                        ;; 02:4dd8 $3e $7d
    ret                                                ;; 02:4dda $c9
