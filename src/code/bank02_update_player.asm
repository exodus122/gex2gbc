; ==================================================================
; PLAYER UPDATE
;
; call_02_4939_Player_UpdateMain is the whole of Gex's per-frame update, called
; once from the main loop. The order it does things in matters, because each
; step consumes what the previous one produced:
;
;   1. read the pad (or the demo stream) and filter it through
;      wD759_ButtonBlockingFlags into wD75A_CurrentInputsAlt. Everything
;      downstream reads wD75A, never the raw pad
;   2. Player_UpdateFacing turns held directions into a facing and ramps the
;      walk speed
;   3. background collision (bank 3) refreshes the four tile-type probes and
;      wD585_CollisionFlags
;   4. Player_ApplyYVelocity applies gravity and detects the landing frame
;   5. Player_CheckTileInteractions turns tiles and buttons into a queued
;      action
;   6. the queued action is committed, then the current action's function runs
;   7. Player_ApplyXMovement finally moves him horizontally
;   8. bookkeeping: clear the one-frame flags, tick the animation, scroll the
;      map window, check for liquid, build the sprite, tick the power-up timers
;
; Note that steps 2, 4 and 7 all bail out immediately unless
; wD746_Player_ClimbingState is CLIMB_STATE_NOT_CLIMBING - while climbing,
; PlayerAction_Climb in bank02_player_actions.asm owns Gex's movement entirely
; ==================================================================

call_02_4856_Player_GetJumpVelocity:
; Works out how hard Gex leaves the ground. The caller passes the velocity it wants in C
; (PLAYER_JUMP_VELOCITY or PLAYER_DOUBLE_JUMP_VELOCITY) and gets back the velocity to
; actually use in A, which is usually just C again.
; Two things can override it. First wD758_JumpVelocityOverride: if an entity touched Gex
; this frame and asked for a specific launch speed (the geyser, the bouncy mushroom) that
; value wins outright and is returned as-is. Otherwise the floor tile decides -
; TILE_TYPE_SPRING_LOW/HIGH always spring, while TILE_TYPE_TRAMPOLINE_LOW/HIGH only spring
; while the circuit power-up timer is still running, and play a sound when they do
    ld   A, [wD758_JumpVelocityOverride]                                    ;; 02:4856 $fa $58 $d7
    and  A, A                                          ;; 02:4859 $a7
    ret  NZ                                            ;; 02:485a $c0
    ld   A, [wD765_TileTypeBehindGexsLowerBody]                                    ;; 02:485b $fa $65 $d7
    cp   A, TILE_TYPE_TRAMPOLINE_LOW                   ;; 02:485e $fe $f0
    jr   Z, .jr_02_4876                                ;; 02:4860 $28 $14
    cp   A, TILE_TYPE_TRAMPOLINE_HIGH                  ;; 02:4862 $fe $f1
    jr   Z, .jr_02_4885                                ;; 02:4864 $28 $1f
    cp   A, TILE_TYPE_SPRING_LOW                       ;; 02:4866 $fe $ce
    jr   Z, .jr_02_4870                                ;; 02:4868 $28 $06
    cp   A, TILE_TYPE_SPRING_HIGH                      ;; 02:486a $fe $cf
    jr   Z, .jr_02_4873                                ;; 02:486c $28 $05
.jr_02_486e:
    ld   A, C                                          ;; 02:486e $79
    ret                                                ;; 02:486f $c9
.jr_02_4870:
    ld   A, PLAYER_SPRING_VELOCITY_LOW                 ;; 02:4870 $3e $4c
    ret                                                ;; 02:4872 $c9
.jr_02_4873:
    ld   A, PLAYER_SPRING_VELOCITY_HIGH                ;; 02:4873 $3e $60
    ret                                                ;; 02:4875 $c9
.jr_02_4876:
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 02:4876 $21 $51 $d7
    ld   A, [HL+]                                      ;; 02:4879 $2a
    or   A, [HL]                                       ;; 02:487a $b6
    jr   Z, .jr_02_486e                                ;; 02:487b $28 $f1
    ld   C, SFX_GEX_JUMP_UNK                                        ;; 02:487d $0e $2a
    call call_00_112f_QueueSFX                                  ;; 02:487f $cd $2f $11
    ld   A, PLAYER_SPRING_VELOCITY_LOW                 ;; 02:4882 $3e $4c
    ret                                                ;; 02:4884 $c9
.jr_02_4885:
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 02:4885 $21 $51 $d7
    ld   A, [HL+]                                      ;; 02:4888 $2a
    or   A, [HL]                                       ;; 02:4889 $b6
    jr   Z, .jr_02_486e                                ;; 02:488a $28 $e2
    ld   C, SFX_GEX_JUMP_UNK                                        ;; 02:488c $0e $2a
    call call_00_112f_QueueSFX                                  ;; 02:488e $cd $2f $11
    ld   A, PLAYER_SPRING_VELOCITY_HIGH                ;; 02:4891 $3e $60
    ret                                                ;; 02:4893 $c9

call_02_4894_Player_CheckWarpReady:
; Reads bit 2 of wD20A (animation-end flag) and returns it in A. Zero flag set if not ready, 
; nonzero if warp should fire. Used as a gate in door/TV warp actions
    ld   a,[wD20A_Player_UnkFlags2]
    and  a,SPRITE_FLAG_ANIM_ENDED
    ret

call_02_489a_Player_SetLandingAction:
; Picks the action to land in and is shared by the jump, double jump and the
; landing path of ApplyYVelocity. Blocks B until release so that a held button
; cannot immediately re-jump, then chooses from the d-pad and the speed Gex
; carried into the landing: nothing held lands in Stand, a held direction lands
; in Run if he was already at running speed and Walk otherwise
    ld   HL, wD759_ButtonBlockingFlags                                     ;; 02:489a $21 $59 $d7
    set  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]           ;; 02:489d $cb $f6
    ld   C, PLAYER_ACTION_STAND                                        ;; 02:489f $0e $02
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:48a1 $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT                                        ;; 02:48a4 $e6 $30
    jr   Z, .jr_02_48b3                                ;; 02:48a6 $28 $0b
    ld   C, PLAYER_ACTION_RUN                                        ;; 02:48a8 $0e $05
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:48aa $fa $5e $d7
    cp   A, $02                                        ;; 02:48ad $fe $02
    jr   NC, .jr_02_48b3                               ;; 02:48af $30 $02
    ld   C, PLAYER_ACTION_WALK                                        ;; 02:48b1 $0e $04
.jr_02_48b3:
    ld   A, C                                          ;; 02:48b3 $79
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:48b4 $c3 $cd $4c

call_02_48b7_Player_SpawnOpeningDoorEntity:
; Looks up the current level ID in .data_02_491a_LevelSpecificEntityIdTable to get an entity ID 
; (0 = no entity for this level). Scans the entity slot table at $D220 for a free slot (value $FF), 
; initializes it with the entity ID, clears two entity fields, then copies the player's X/Y position 
; (snapped to $E0 boundary, with a $0F offset and $10 Y flag) into the slot's position fields. 
; Calls Entity_SetAction and Entity_ClearSlotCounter. Used to spawn a level-specific companion/effect 
; entity tied to the player's position
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
    ld   DE, wD20E_Player_XPositionLo                                     ;; 02:48f2 $11 $0e $d2
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
    call call_00_34d8_Entity_ResetEntityListIndex                                  ;; 02:4912 $cd $d8 $34
    xor  A, A                                          ;; 02:4915 $af
    ld   [wD300_CurrentEntityAddrLo], A                                    ;; 02:4916 $ea $00 $d3
    ret                                                ;; 02:4919 $c9
.data_02_491a_LevelSpecificEntityIdTable:
; 31-byte table indexed by level ID. Non-zero entries ($18) indicate which levels spawn a special 
; entity via call_02_48b7. Entries $18 appear at indices 2, 3, 11, 16, 25
    db   $00                             ; MAP_MEDIA_DIMENSION
    db   $00                             ; MAP_TOON_TV_OUT_OF_TOON
    db   ENTITY_SCREAM_TV_DOOR_OPENING   ; MAP_SCREAM_TV_SMELLRAISER
    db   ENTITY_SCREAM_TV_DOOR_OPENING   ; MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $00                             ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $00                             ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $00                             ; MAP_UNUSED_06
    db   $00                             ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $00                             ; MAP_TOON_TV_FINE_TOONING
    db   $00                             ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $00                             ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   ENTITY_SCREAM_TV_DOOR_OPENING   ; MAP_SCREAM_TV_POLTERGEX
    db   $00                             ; MAP_UNUSED_0C
    db   $00                             ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $00                             ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $00                             ; MAP_UNUSED_0F
    db   ENTITY_SCREAM_TV_DOOR_OPENING   ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $00                             ; MAP_UNUSED_11
    db   $00                             ; MAP_UNUSED_12
    db   $00                             ; MAP_UNUSED_13
    db   $00                             ; MAP_UNUSED_14
    db   $00                             ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $00                             ; MAP_REZOPOLIS_BUGGED_OUT
    db   $00                             ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $00                             ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   ENTITY_SCREAM_TV_DOOR_OPENING   ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $00                             ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $00                             ; MAP_UNUSED_1B
    db   $00                             ; MAP_UNUSED_1C
    db   $00                             ; MAP_UNUSED_1D
    db   $00                             ; MAP_BOSS_TV_CHANNEL_Z

call_02_4939_Player_UpdateMain:
; The per-frame player update - see the file header for the ordering and why it matters.
;
; Input comes from one of two places. In demo mode the pad is replayed from a run-length
; encoded stream at wD61B_DemoInputsPointer: each record is (frame count, input byte), and
; a count of $FF ends the demo and drops back to the title screen. Otherwise it is just the
; live pad from wD59F_CurrentInputs. Either way it is filtered through
; wD759_ButtonBlockingFlags and the result written to wD75A_CurrentInputsAlt.
;
; The queued action is committed here rather than inside Player_RequestAction, which is what
; guarantees an action change always takes effect on a frame boundary. Committing one also
; resets the climb state and climb flags, so any action change cancels a climb.
;
; The tail end is per-frame bookkeeping: wD758_JumpVelocityOverride and the two one-frame
; entity flags are cleared here (they are set by collision earlier in the same frame and must
; not survive into the next), wD76A_PlayerXPositionBlock is recomputed as world X >> 5, and
; the three power-up countdowns are ticked. Note the last of those three falls through into
; Player_DecrementPowerupTimer instead of calling it, so the ret at the end of that routine
; is what returns from the whole update
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
    ; A button: swallow presses until the player physically lets go
    ld   HL, wD759_ButtonBlockingFlags                                     ;; 02:496a $21 $59 $d7
    bit  BTN_BLOCK_A_BIT, [HL]                         ;; 02:496d $cb $46
    jr   Z, .jr_02_4979                                ;; 02:496f $28 $08
    bit  PADF_A_BIT, E                                          ;; 02:4971 $cb $43
    jr   NZ, .jr_02_4977                               ;; 02:4973 $20 $02
    res  BTN_BLOCK_A_BIT, [HL]                         ;; 02:4975 $cb $86 ; released, so stop blocking
.jr_02_4977:
    res  PADF_A_BIT, C                                          ;; 02:4977 $cb $81
.jr_02_4979:
    ; B button, same idea. Releasing B here clears the whole high nibble,
    ; dropping the rising-edge flags below along with this one
    bit  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]           ;; 02:4979 $cb $76
    jr   Z, .jr_02_4989                                ;; 02:497b $28 $0c
    bit  PADF_B_BIT, E                                          ;; 02:497d $cb $4b
    jr   NZ, .jr_02_4985                               ;; 02:497f $20 $04
    ld   A, [HL]                                       ;; 02:4981 $7e
    and  A, $0f                                        ;; 02:4982 $e6 $0f
    ld   [HL], A                                       ;; 02:4984 $77
.jr_02_4985:
    res  PADF_B_BIT, C                                          ;; 02:4985 $cb $89
    jr   .jr_02_49a4                                   ;; 02:4987 $18 $1b
.jr_02_4989:
    ; Otherwise B may be blocked only while Gex is still travelling upward.
    ; This is what stops a held B from auto-firing the double jump: B is
    ; suppressed during the rise, but if the player lets go mid-rise the latch
    ; below remembers it and lets the next press through
    bit  BTN_BLOCK_B_WHILE_RISING_BIT, [HL]            ;; 02:4989 $cb $7e
    jr   Z, .jr_02_49a4                                ;; 02:498b $28 $17
    res  PADF_B_BIT, C                                          ;; 02:498d $cb $89
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:498f $fa $60 $d7
    bit  7, A                                          ;; 02:4992 $cb $7f
    jr   Z, .jr_02_49a4                                ;; 02:4994 $28 $0e
    bit  PADF_B_BIT, E                                          ;; 02:4996 $cb $4b
    jr   NZ, .jr_02_499e                               ;; 02:4998 $20 $04
    set  BTN_BLOCK_B_REPRESS_LATCH_BIT, [HL]           ;; 02:499a $cb $e6 ; B was released during the rise
    jr   .jr_02_49a4                                   ;; 02:499c $18 $06
.jr_02_499e:
    bit  BTN_BLOCK_B_REPRESS_LATCH_BIT, [HL]           ;; 02:499e $cb $66
    jr   Z, .jr_02_49a4                                ;; 02:49a0 $28 $02
    set  PADF_B_BIT, C                                          ;; 02:49a2 $cb $c9 ; genuine new press, let it through
.jr_02_49a4:
    ld   HL, wD75A_CurrentInputsAlt                                     ;; 02:49a4 $21 $5a $d7
    ld   [HL], C                                       ;; 02:49a7 $71
    ld   HL, wD750_Player_DamageCooldownTimer                                     ;; 02:49a8 $21 $50 $d7
    ld   A, [HL]                                       ;; 02:49ab $7e
    and  A, A                                          ;; 02:49ac $a7
    jr   Z, .jr_02_49b0                                ;; 02:49ad $28 $01
    dec  [HL]                                          ;; 02:49af $35
.jr_02_49b0:
    call call_02_4a45_Player_UpdateFacing                                  ;; 02:49b0 $cd $45 $4a
    FARCALL call_03_4900_BgCollision_Update
    call call_02_4b78_Player_ApplyYVelocity                                  ;; 02:49be $cd $78 $4b
    FARCALL call_03_4c0a_BgCollision_CacheNearbyTileTypes
    call call_02_4c4f_Player_CheckTileInteractions                                  ;; 02:49cc $cd $4f $4c
    ld   HL, wD745_Player_QueuedAction                                     ;; 02:49cf $21 $45 $d7
    ld   A, [HL]                                       ;; 02:49d2 $7e
    ld   [HL], PLAYER_ACTION_NONE_PENDING                                     ;; 02:49d3 $36 $ff
    cp   A, PLAYER_ACTION_NONE_PENDING                                        ;; 02:49d5 $fe $ff
    jr   Z, .jr_02_49e6                                ;; 02:49d7 $28 $0d
    call call_02_7102_Entity_SetAction                                  ;; 02:49d9 $cd $02 $71
    ld   A, CLIMB_STATE_NOT_CLIMBING                   ;; 02:49dc $3e $ff
    ld   [wD746_Player_ClimbingState], A                                    ;; 02:49de $ea $46 $d7
    ld   A, $00                                        ;; 02:49e1 $3e $00
    ld   [wD74B_Player_ClimbingFlags], A                                    ;; 02:49e3 $ea $4b $d7
.jr_02_49e6:
    ld   HL, wD202_Player_ActionFunc                                     ;; 02:49e6 $21 $02 $d2
    ld   A, [HL+]                                      ;; 02:49e9 $2a
    ld   H, [HL]                                       ;; 02:49ea $66
    ld   L, A                                          ;; 02:49eb $6f
    call call_00_10bd_JumpHL                                  ;; 02:49ec $cd $bd $10
    call call_02_4a77_Player_ApplyXMovement                                  ;; 02:49ef $cd $77 $4a
    xor  A, A                                          ;; 02:49f2 $af
    ld   [wD758_JumpVelocityOverride], A                                    ;; 02:49f3 $ea $58 $d7
    ld   HL, wD20E_Player_XPositionLo                                     ;; 02:49f6 $21 $0e $d2
    ld   A, [HL+]                                      ;; 02:49f9 $2a
    ld   H, [HL]                                       ;; 02:49fa $66
    ld   L, A                                          ;; 02:49fb $6f
    add  HL, HL                                        ;; 02:49fc $29
    add  HL, HL                                        ;; 02:49fd $29
    add  HL, HL                                        ;; 02:49fe $29
    ld   A, H                                          ;; 02:49ff $7c
    ld   [wD76A_PlayerXPositionBlock], A                                    ;; 02:4a00 $ea $6a $d7
    ld   HL, wD209_Player_ActionState                                     ;; 02:4a03 $21 $09 $d2
    res  ACTION_STATE_IS_FIRST_FRAME_BIT, [HL]                                       ;; 02:4a06 $cb $ae
    ld   HL, wD20A_Player_UnkFlags2                                     ;; 02:4a08 $21 $0a $d2
    res  6, [HL]                                       ;; 02:4a0b $cb $b6
    call call_02_6fda_Entity_TickAction                                  ;; 02:4a0d $cd $da $6f
    call call_02_715a_MapWindow_Update                                  ;; 02:4a10 $cd $5a $71
    call call_02_4c28_Player_CheckLavaAndWaterTiles                                  ;; 02:4a13 $cd $28 $4c
    FARCALL call_03_5ca8_Entity_BuildPlayerSprites
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 02:4a21 $21 $51 $d7
    call call_02_4a30_Player_DecrementPowerupTimer                                  ;; 02:4a24 $cd $30 $4a
    ld   HL, wD755_FlyPowerup2_TimerLo                                     ;; 02:4a27 $21 $55 $d7
    call call_02_4a30_Player_DecrementPowerupTimer                                  ;; 02:4a2a $cd $30 $4a
    ld   HL, wD753_FlyPowerup1_TimerLo                                     ;; 02:4a2d $21 $53 $d7

call_02_4a30_Player_DecrementPowerupTimer:
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

call_02_4a3a_Player_LockBPress:
; Arms BTN_BLOCK_B_WHILE_RISING and clears the other three block flags, so B is ignored for
; as long as Gex is still going up. Called at the start of a jump and a double jump - it is
; what makes the double jump require a fresh press rather than a held button
    ld   A, [wD759_ButtonBlockingFlags]                                    ;; 02:4a3a $fa $59 $d7
    and  A, $0f                                        ;; 02:4a3d $e6 $0f
    or   A, BTN_BLOCK_B_WHILE_RISING                   ;; 02:4a3f $f6 $80
    ld   [wD759_ButtonBlockingFlags], A                                    ;; 02:4a41 $ea $59 $d7
    ret                                                ;; 02:4a44 $c9

call_02_4a45_Player_UpdateFacing:
; Turns held directions into a facing, and ramps Gex up to speed.
; wD75E_PlayerXSpeed is the target speed the current action wants (walk or run);
; wD75D_PlayerXSpeedPrev is the speed actually in use, and this is what nudges it one step
; per frame toward the target. Turning around, or letting go of the d-pad entirely, resets
; it to zero - so Gex always accelerates from a standstill after a direction change rather
; than snapping to full speed. Does nothing while climbing
    ld   A, [wD746_Player_ClimbingState]                                    ;; 02:4a45 $fa $46 $d7
    cp   A, CLIMB_STATE_NOT_CLIMBING                   ;; 02:4a48 $fe $ff
    ret  NZ                                            ;; 02:4a4a $c0
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4a4b $fa $5a $d7
    and  A, PADF_RIGHT | PADF_LEFT                                        ;; 02:4a4e $e6 $30
    jr   Z, .jr_02_4a62                                ;; 02:4a50 $28 $10
    ld   C, $00                                        ;; 02:4a52 $0e $00
    and  A, $10                                        ;; 02:4a54 $e6 $10
    jr   NZ, .jr_02_4a5a                               ;; 02:4a56 $20 $02
    ld   C, $20                                        ;; 02:4a58 $0e $20
.jr_02_4a5a:
    ld   HL, wD20D_Player_FacingFlags                                     ;; 02:4a5a $21 $0d $d2
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
; The horizontal move for the frame, and the most involved routine in the file.
;
; The delta is Gex's own speed (wD75D_PlayerXSpeedPrev, negated if facing left) plus
; wD75C_PlayerXDeltaExtra, which is whatever the world is doing to him - a moving platform
; carrying him, a powered walkway, or a slope correction from bank 3. Zero total means
; nothing to do.
;
; If the low nibble of wD585_CollisionFlags is set he is on a slope, and an equal upward Y
; nudge is applied first so that walking up an incline does not clip him into it.
;
; The rest is the platform push logic, mirrored for the two directions. With nothing being
; pushed the delta just goes onto wD20E/wD20F. If wD74E_Player_PushedStationaryPlatformLo
; names an entity, that entity's constraint field decides what happens: bit 7 means a hard
; stop, where Gex's world X is pinned to the entity's own saved position once his screen X
; passes the threshold, and clear means a soft limit, where he still moves but the entity's
; offset is subtracted out. This is what lets Gex shove a tv button across the floor and
; stay glued to it rather than walking through it
    ld   A, [wD746_Player_ClimbingState]                                    ;; 02:4a77 $fa $46 $d7
    cp   A, CLIMB_STATE_NOT_CLIMBING                   ;; 02:4a7a $fe $ff
    ret  NZ                                            ;; 02:4a7c $c0
    ld   A, [wD75D_PlayerXSpeedPrev]                                    ;; 02:4a7d $fa $5d $d7
    ld   HL, wD20D_Player_FacingFlags                                     ;; 02:4a80 $21 $0d $d2
    bit  FACING_LEFT_BIT, [HL]                         ;; 02:4a83 $cb $6e
    jr   Z, .jr_02_4a89                                ;; 02:4a85 $28 $02
    cpl                                                ;; 02:4a87 $2f
    inc  A                                             ;; 02:4a88 $3c
.jr_02_4a89:
    ld   HL, wD75C_PlayerXDeltaExtra                                     ;; 02:4a89 $21 $5c $d7
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
    ld   A, [wD74E_Player_PushedStationaryPlatformLo]                                    ;; 02:4aaa $fa $4e $d7
    and  A, A                                          ;; 02:4aad $a7
    jr   NZ, .jr_02_4ac0                               ;; 02:4aae $20 $10
    ld   A, [wD74F_Player_PushedMovingPlatformLo]                                    ;; 02:4ab0 $fa $4f $d7
    and  A, A                                          ;; 02:4ab3 $a7
    ret  NZ                                            ;; 02:4ab4 $c0
.jr_02_4ab5:
    ld   HL, wD20E_Player_XPositionLo                                     ;; 02:4ab5 $21 $0e $d2
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
    ld   A, [wD212_Player_ScreenXPosition]                                    ;; 02:4acd $fa $12 $d2
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
    ld   [wD20E_Player_XPositionLo], A                                    ;; 02:4ade $ea $0e $d2
    ld   A, [HL]                                       ;; 02:4ae1 $7e
    adc  A, $00                                        ;; 02:4ae2 $ce $00
    ld   [wD20F_Player_XPositionHi], A                                    ;; 02:4ae4 $ea $0f $d2
    ret                                                ;; 02:4ae7 $c9
.jr_02_4ae8:
    push HL                                            ;; 02:4ae8 $e5
    ld   HL, wD20E_Player_XPositionLo                                     ;; 02:4ae9 $21 $0e $d2
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
    ld   A, [wD212_Player_ScreenXPosition]                                    ;; 02:4afa $fa $12 $d2
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
    ld   A, [wD74E_Player_PushedStationaryPlatformLo]                                    ;; 02:4b10 $fa $4e $d7
    and  A, A                                          ;; 02:4b13 $a7
    jr   NZ, .jr_02_4b26                               ;; 02:4b14 $20 $10
    ld   A, [wD74F_Player_PushedMovingPlatformLo]                                    ;; 02:4b16 $fa $4f $d7
    and  A, A                                          ;; 02:4b19 $a7
    ret  NZ                                            ;; 02:4b1a $c0
.jr_02_4b1b:
    ld   HL, wD20E_Player_XPositionLo                                     ;; 02:4b1b $21 $0e $d2
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
    ld   A, [wD212_Player_ScreenXPosition]                                    ;; 02:4b33 $fa $12 $d2
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
    ld   [wD20E_Player_XPositionLo], A                                    ;; 02:4b45 $ea $0e $d2
    ld   A, [HL]                                       ;; 02:4b48 $7e
    sbc  A, $00                                        ;; 02:4b49 $de $00
    ld   [wD20F_Player_XPositionHi], A                                    ;; 02:4b4b $ea $0f $d2
    ret                                                ;; 02:4b4e $c9
.jr_02_4b4f:
    push HL                                            ;; 02:4b4f $e5
    ld   HL, wD20E_Player_XPositionLo                                     ;; 02:4b50 $21 $0e $d2
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
    ld   A, [wD212_Player_ScreenXPosition]                                    ;; 02:4b61 $fa $12 $d2
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
; Gravity and landing. Y velocity is signed with positive meaning upward, so "still rising"
; and "falling or stopped" are just the sign bit.
;
; While rising it subtracts PLAYER_GRAVITY_PER_FRAME each frame, clamped at
; PLAYER_MAX_FALL_VELOCITY. Once it is pinned at that clamp it also ticks
; wD763_FallDistanceCounter, so that counter measures time spent at terminal velocity rather
; than total airtime. The velocity is then converted into a whole-pixel delta by negating and
; swapping nibbles - the low nibble becomes the pixel count and bit 3 of it carries the sign.
;
; The landing path keys off wD761, the measured gap to the floor below. A nonzero gap means
; there is still room to fall, so it either closes the gap in one step or keeps falling
; normally depending on whether that gap is smaller than the current velocity. A gap of zero
; is the landing frame: velocity is zeroed and the accumulated fall distance decides the
; outcome. Short falls land silently, medium ones go through Player_SetLandingAction, and
; anything at or past FALL_DISTANCE_HARD_LANDING drops Gex into PLAYER_ACTION_COLLAPSE.
;
; The last case is walking off a ledge - not grounded now, grounded last frame - which starts
; PLAYER_ACTION_FREEFALL so he gets the falling animation instead of a walk cycle in mid-air
    ld   A, [wD746_Player_ClimbingState]                                    ;; 02:4b78 $fa $46 $d7
    cp   A, CLIMB_STATE_NOT_CLIMBING                   ;; 02:4b7b $fe $ff
    ret  NZ                                            ;; 02:4b7d $c0
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:4b7e $fa $60 $d7
    bit  7, A                                          ;; 02:4b81 $cb $7f
    jr   NZ, .jr_02_4bbc_NegativeOr0Velocity                               ;; 02:4b83 $20 $37
    and  A, A                                          ;; 02:4b85 $a7
    jr   Z, .jr_02_4bbc_NegativeOr0Velocity                                ;; 02:4b86 $28 $34
    xor  A, A                                          ;; 02:4b88 $af
    ld   [wD763_FallDistanceCounter], A                                    ;; 02:4b89 $ea $63 $d7
.jr_02_4b8c:
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:4b8c $fa $60 $d7
    sub  A, PLAYER_GRAVITY_PER_FRAME                   ;; 02:4b8f $d6 $02
    bit  7, A                                          ;; 02:4b91 $cb $7f
    jr   Z, .jr_02_4ba4                                ;; 02:4b93 $28 $0f
    cp   A, PLAYER_MAX_FALL_VELOCITY                   ;; 02:4b95 $fe $c0
    jr   NC, .jr_02_4ba4                               ;; 02:4b97 $30 $0b
    ; at terminal velocity, so start counting how long the fall has lasted.
    ; cp $7f / adc $00 is a saturating increment - it stops dead at $80
    ld   HL, wD763_FallDistanceCounter                                     ;; 02:4b99 $21 $63 $d7
    ld   A, [HL]                                       ;; 02:4b9c $7e
    cp   A, $7f                                        ;; 02:4b9d $fe $7f
    adc  A, $00                                        ;; 02:4b9f $ce $00
    ld   [HL], A                                       ;; 02:4ba1 $77
    ld   A, PLAYER_MAX_FALL_VELOCITY                   ;; 02:4ba2 $3e $c0
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
.jr_02_4bbc_NegativeOr0Velocity:
    ld   A, [wD585_CollisionFlags]                                    ;; 02:4bbc $fa $85 $d5
    and  A, $80                                        ;; 02:4bbf $e6 $80
    jr   Z, .jr_02_4bd8_NotGrounded                                ;; 02:4bc1 $28 $15
    ld   A, [wD761_PlayerBonkCeilingDownwardsVelocity]                                    ;; 02:4bc3 $fa $61 $d7
    and  A, A                                          ;; 02:4bc6 $a7
    jr   Z, .jr_02_4bed                                ;; 02:4bc7 $28 $24
    ld   HL, wD584_CollisionFlagsPrev                                     ;; 02:4bc9 $21 $84 $d5
    bit  7, [HL]                                       ;; 02:4bcc $cb $7e
    jr   NZ, .jr_02_4ba4                               ;; 02:4bce $20 $d4
    ld   HL, wD760_PlayerYVelocity                                     ;; 02:4bd0 $21 $60 $d7
    cp   A, [HL]                                       ;; 02:4bd3 $be
    jr   NC, .jr_02_4ba4                               ;; 02:4bd4 $30 $ce
    jr   .jr_02_4b8c                                   ;; 02:4bd6 $18 $b4
.jr_02_4bd8_NotGrounded:
    ld   A, [wD584_CollisionFlagsPrev]                                    ;; 02:4bd8 $fa $84 $d5
    and  A, $80                                        ;; 02:4bdb $e6 $80
    jr   NZ, .jr_02_4be6                               ;; 02:4bdd $20 $07
    ld   A, [wD763_FallDistanceCounter]                                    ;; 02:4bdf $fa $63 $d7
    cp   A, FALL_DISTANCE_HARD_LANDING                 ;; 02:4be2 $fe $10
    jr   C, .jr_02_4b8c                                ;; 02:4be4 $38 $a6
.jr_02_4be6:
    ld   A, PLAYER_ACTION_FREEFALL                                        ;; 02:4be6 $3e $17
    call call_02_4ccd_Player_RequestAction                                  ;; 02:4be8 $cd $cd $4c
    jr   .jr_02_4b8c                                   ;; 02:4beb $18 $9f
.jr_02_4bed:
    xor  A, A                                          ;; 02:4bed $af
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4bee $ea $60 $d7
    ld   HL, wD763_FallDistanceCounter                                     ;; 02:4bf1 $21 $63 $d7
    ld   A, [HL]                                       ;; 02:4bf4 $7e
    ld   [HL], $00                                     ;; 02:4bf5 $36 $00
    cp   A, FALL_DISTANCE_LANDING_ANIM                 ;; 02:4bf7 $fe $08
    jr   NC, .jr_02_4c00                               ;; 02:4bf9 $30 $05
    xor  A, A                                          ;; 02:4bfb $af
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:4bfc $ea $62 $d7
    ret                                                ;; 02:4bff $c9
.jr_02_4c00:
    cp   A, FALL_DISTANCE_HARD_LANDING                 ;; 02:4c00 $fe $10
    jp   C, call_02_489a_Player_SetLandingAction                                 ;; 02:4c02 $da $9a $48
    ld   A, PLAYER_ACTION_COLLAPSE                                        ;; 02:4c05 $3e $19
    jp   call_02_4ccd_Player_RequestAction                                  ;; 02:4c07 $c3 $cd $4c

call_02_4c0a_Player_AddToXPosition:
; Adds signed 16-bit (C, B) to wD20E/wD20F (player world X)
    ld   A, [wD20E_Player_XPositionLo]                                    ;; 02:4c0a $fa $0e $d2
    add  A, C                                          ;; 02:4c0d $81
    ld   [wD20E_Player_XPositionLo], A                                    ;; 02:4c0e $ea $0e $d2
    ld   A, [wD20F_Player_XPositionHi]                                    ;; 02:4c11 $fa $0f $d2
    adc  A, B                                          ;; 02:4c14 $88
    ld   [wD20F_Player_XPositionHi], A                                    ;; 02:4c15 $ea $0f $d2
    ret                                                ;; 02:4c18 $c9

call_02_4c19_Player_AddToYPosition:
; Adds signed 16-bit (C, B) to wD210/wD211 (player world Y)
    ld   A, [wD210_Player_YPositionLo]                                    ;; 02:4c19 $fa $10 $d2
    add  A, C                                          ;; 02:4c1c $81
    ld   [wD210_Player_YPositionLo], A                                    ;; 02:4c1d $ea $10 $d2
    ld   A, [wD211_Player_YPositionHi]                                    ;; 02:4c20 $fa $11 $d2
    adc  A, B                                          ;; 02:4c23 $88
    ld   [wD211_Player_YPositionHi], A                                    ;; 02:4c24 $ea $11 $d2
    ret                                                ;; 02:4c27 $c9

call_02_4c28_Player_CheckLavaAndWaterTiles:
; Runs once per frame to answer two separate questions about liquid.
; First, is Gex standing in it at all: either the tile behind his body or the tile under his
; feet being TILE_TYPE_WATER, or the tile behind his body being TILE_TYPE_LAVA, counts. The
; answer goes into wD74A_Player_InWaterOrLava, which the sprite builder uses to swap in the
; wading frames. Note the flag is stored inverted - $00 means yes, $80 means no - because it
; is produced by xoring $80 over the fall-through value.
; Second, is he actually in lava, in which case he takes the hit: PLAYER_ACTION_HIT_BOUNCE is
; requested, which is the same recoil used when an enemy hits him. Water alone is harmless
    ld   A, [wD765_TileTypeBehindGexsLowerBody]                                    ;; 02:4c28 $fa $65 $d7
    sub  A, TILE_TYPE_WATER                            ;; 02:4c2b $d6 $25
    jr   Z, .jr_02_4c3f                                ;; 02:4c2d $28 $10
    ld   A, [wD767_FloorTileType]                                    ;; 02:4c2f $fa $67 $d7
    sub  A, TILE_TYPE_WATER                            ;; 02:4c32 $d6 $25
    jr   Z, .jr_02_4c3f                                ;; 02:4c34 $28 $09
    ld   A, [wD765_TileTypeBehindGexsLowerBody]                                    ;; 02:4c36 $fa $65 $d7
    sub  A, TILE_TYPE_LAVA                             ;; 02:4c39 $d6 $24
    jr   Z, .jr_02_4c3f                                ;; 02:4c3b $28 $02
    ld   A, $80                                        ;; 02:4c3d $3e $80 ; not in liquid
.jr_02_4c3f:
    xor  A, $80                                        ;; 02:4c3f $ee $80
    ld   [wD74A_Player_InWaterOrLava], A                                    ;; 02:4c41 $ea $4a $d7
    ld   A, [wD765_TileTypeBehindGexsLowerBody]                                    ;; 02:4c44 $fa $65 $d7
    cp   A, TILE_TYPE_LAVA                             ;; 02:4c47 $fe $24
    ld   A, PLAYER_ACTION_HIT_BOUNCE                                        ;; 02:4c49 $3e $1c
    call Z, call_02_4ccd_Player_RequestAction                               ;; 02:4c4b $cc $cd $4c
    ret                                                ;; 02:4c4e $c9

call_02_4c4f_Player_CheckTileInteractions:
; The bridge between the world and the action machine, in three passes.
;
; 1. Instant-kill tiles. Skipped if Gex is already in one of the two death actions, otherwise
;    TILE_TYPE_INSTANT_KILL under either of his two body probes jumps straight to Player_Die.
;
; 2. Up-press interactions. Only while UP is held, and in priority order: a door tile enters
;    the door, TILE_TYPE_CLIMBABLE_BACKGROUND starts a climb, and the two directional wall
;    tiles start a climb only if Gex is already facing into the wall. Whichever tile matched
;    is stashed in wD769_ClimbSurfaceTileType so PlayerAction_Climb can tell background from
;    wall when it picks its starting sub-state.
;
; 3. Everything else falls through to the generic input transition table. The current action
;    id indexes data_02_4d15_ActionInputTransitionTable to get a list of (input, action)
;    pairs, which is scanned for an entry matching the filtered input in
;    wD75A_CurrentInputsAlt. $FE matches any nonzero input and $FF ends the list. This is
;    what makes each action define its own controls - pressing B means "jump" while standing
;    and nothing at all while dying, without either action containing that logic
    ld   A, [wD201_Player_ActionId]                                    ;; 02:4c4f $fa $01 $d2
    cp   A, PLAYER_ACTION_DEATH                                        ;; 02:4c52 $fe $10
    jr   Z, .jr_02_4c6a                                ;; 02:4c54 $28 $14
    cp   A, PLAYER_ACTION_DEATH_SET_UP_WARP                                        ;; 02:4c56 $fe $11
    jr   Z, .jr_02_4c6a                                ;; 02:4c58 $28 $10
    ld   A, [wD764_TileTypeBehindGexsUpperBody]                                    ;; 02:4c5a $fa $64 $d7
    cp   A, TILE_TYPE_INSTANT_KILL                     ;; 02:4c5d $fe $23
    jp   Z, call_00_0696_Player_Die                                 ;; 02:4c5f $ca $96 $06
    ld   A, [wD765_TileTypeBehindGexsLowerBody]                                    ;; 02:4c62 $fa $65 $d7
    cp   A, TILE_TYPE_INSTANT_KILL                     ;; 02:4c65 $fe $23
    jp   Z, call_00_0696_Player_Die                                 ;; 02:4c67 $ca $96 $06
.jr_02_4c6a:
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 02:4c6a $fa $5a $d7
    and  A, PADF_UP                                        ;; 02:4c6d $e6 $40
    jr   Z, .jr_02_4ca6                                ;; 02:4c6f $28 $35
    ld   A, [wD764_TileTypeBehindGexsUpperBody]                                    ;; 02:4c71 $fa $64 $d7
    cp   A, TILE_TYPE_DOOR                             ;; 02:4c74 $fe $22
    ld   A, PLAYER_ACTION_ENTER_DOOR                                        ;; 02:4c76 $3e $1a
    jr   Z, call_02_4ccd_Player_RequestAction                               ;; 02:4c78 $28 $53
    ld   A, [wD764_TileTypeBehindGexsUpperBody]                                    ;; 02:4c7a $fa $64 $d7
    ld   [wD769_ClimbSurfaceTileType], A                                    ;; 02:4c7d $ea $69 $d7
    cp   A, TILE_TYPE_CLIMBABLE_BACKGROUND             ;; 02:4c80 $fe $26
    jr   Z, .jr_02_4ca2                                ;; 02:4c82 $28 $1e
    ld   A, [wD766_TileTypeBehindGexsFace]                                    ;; 02:4c84 $fa $66 $d7
    ld   [wD769_ClimbSurfaceTileType], A                                    ;; 02:4c87 $ea $69 $d7
    cp   A, TILE_TYPE_CLIMBABLE_WALL_FACING_LEFT       ;; 02:4c8a $fe $2c
    jr   Z, .jr_02_4c9b                                ;; 02:4c8c $28 $0d
    cp   A, TILE_TYPE_CLIMBABLE_WALL_FACING_RIGHT      ;; 02:4c8e $fe $2d
    jr   NZ, .jr_02_4ca6                               ;; 02:4c90 $20 $14
    ld   A, [wD20D_Player_FacingFlags]                                    ;; 02:4c92 $fa $0d $d2
    cp   A, FACING_RIGHT                               ;; 02:4c95 $fe $00
    jr   NZ, .jr_02_4ca6                               ;; 02:4c97 $20 $0d
    jr   .jr_02_4ca2                                   ;; 02:4c99 $18 $07
.jr_02_4c9b:
    ld   A, [wD20D_Player_FacingFlags]                                    ;; 02:4c9b $fa $0d $d2
    cp   A, FACING_LEFT                                ;; 02:4c9e $fe $20
    jr   NZ, .jr_02_4ca6                               ;; 02:4ca0 $20 $04
.jr_02_4ca2:
    ld   A, PLAYER_ACTION_CLIMB                                        ;; 02:4ca2 $3e $1d
    jr   call_02_4ccd_Player_RequestAction                                  ;; 02:4ca4 $18 $27
.jr_02_4ca6:
    ld   HL, wD201_Player_ActionId                                     ;; 02:4ca6 $21 $01 $d2
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
; The only way anything changes Gex's action. Nothing writes wD201_Player_ActionId directly -
; the request is parked in wD745_Player_QueuedAction and Player_UpdateMain commits it at the
; top of the next frame.
;
; Requesting the action that is already running is a no-op, which is what lets the per-frame
; actions call this unconditionally with their own id as a fallback.
;
; Otherwise .data_02_4cf5_ActionTransitionFlagsTable decides whether the request is allowed.
; An action flagged "instant" is written through no matter what. Anything else has to get
; past the action already holding the slot: if one is queued its flags are checked, and if
; that one is flagged "locked" the new request is silently dropped. That is the mechanism
; that stops a player mashing the d-pad from cancelling out of the death or damage
; animations - those four actions are the ones marked locked
    ld   HL, wD201_Player_ActionId                                     ;; 02:4ccd $21 $01 $d2
    cp   A, [HL]                                       ;; 02:4cd0 $be
    ret  Z                                             ;; 02:4cd1 $c8
    ld   L, A                                          ;; 02:4cd2 $6f
    ld   H, $00                                        ;; 02:4cd3 $26 $00
    ld   DE, .data_02_4cf5_ActionTransitionFlagsTable                             ;; 02:4cd5 $11 $f5 $4c
    add  HL, DE                                        ;; 02:4cd8 $19
    bit  0, [HL]                                       ;; 02:4cd9 $cb $46
    jr   NZ, .jr_02_4cf1                               ;; 02:4cdb $20 $14
    ld   HL, wD745_Player_QueuedAction                                     ;; 02:4cdd $21 $45 $d7
    bit  7, [HL]                                       ;; 02:4ce0 $cb $7e
    jr   Z, .jr_02_4ce7                                ;; 02:4ce2 $28 $03
    ld   HL, wD201_Player_ActionId                                     ;; 02:4ce4 $21 $01 $d2
.jr_02_4ce7:
    ld   L, [HL]                                       ;; 02:4ce7 $6e
    ld   H, $00                                        ;; 02:4ce8 $26 $00
    ld   DE, .data_02_4cf5_ActionTransitionFlagsTable                             ;; 02:4cea $11 $f5 $4c
    add  HL, DE                                        ;; 02:4ced $19
    bit  1, [HL]                                       ;; 02:4cee $cb $4e
    ret  NZ                                            ;; 02:4cf0 $c0
.jr_02_4cf1:
    ld   [wD745_Player_QueuedAction], A                                    ;; 02:4cf1 $ea $45 $d7
    ret                                                ;; 02:4cf4 $c9
.data_02_4cf5_ActionTransitionFlagsTable:
; One byte per action id.
;   bit 0 ($01) = instant - this request always wins
;   bit 1 ($02) = locked  - once queued, nothing else can replace it
; Only six actions are flagged at all. PLAYER_ACTION_TAKE_DAMAGE ($0F) and
; PLAYER_ACTION_EXIT_TV ($14) are instant but interruptible; the four death and tv-entry
; actions ($10-$13) are instant and locked, so once Gex starts dying or warping out nothing
; the player does can pull him back out of it
    db   $00    ; $00 PLAYER_ACTION_SPAWN
    db   $00    ; $01 PLAYER_ACTION_INTRO_WARP
    db   $00    ; $02 PLAYER_ACTION_STAND
    db   $00    ; $03 PLAYER_ACTION_IDLE_ANIMATION
    db   $00    ; $04 PLAYER_ACTION_WALK
    db   $00    ; $05 PLAYER_ACTION_RUN
    db   $00    ; $06 PLAYER_ACTION_SKID
    db   $00    ; $07 PLAYER_ACTION_STOP_ON_CERTAIN_FLOOR
    db   $00    ; $08 PLAYER_ACTION_CROUCH
    db   $00    ; $09 PLAYER_ACTION_JUMP
    db   $00    ; $0A PLAYER_ACTION_DOUBLE_JUMP
    db   $00    ; $0B PLAYER_ACTION_NONE
    db   $00    ; $0C PLAYER_ACTION_KARATE_KICK
    db   $00    ; $0D PLAYER_ACTION_TAIL_SPIN
    db   $00    ; $0E PLAYER_ACTION_EAT_FLY
    db   $01    ; $0F PLAYER_ACTION_TAKE_DAMAGE
    db   $03    ; $10 PLAYER_ACTION_DEATH
    db   $03    ; $11 PLAYER_ACTION_DEATH_SET_UP_WARP
    db   $03    ; $12 PLAYER_ACTION_ENTER_TV
    db   $03    ; $13 PLAYER_ACTION_ENTER_TV_ALT
    db   $01    ; $14 PLAYER_ACTION_EXIT_TV
    db   $00    ; $15 PLAYER_ACTION_STANDING_PUSH
    db   $00    ; $16 PLAYER_ACTION_WALKING_PUSH
    db   $00    ; $17 PLAYER_ACTION_FREEFALL
    db   $00    ; $18 PLAYER_ACTION_STOP_IMMEDIATE
    db   $00    ; $19 PLAYER_ACTION_COLLAPSE
    db   $00    ; $1A PLAYER_ACTION_ENTER_DOOR
    db   $00    ; $1B PLAYER_ACTION_LEAVE_DOOR
    db   $00    ; $1C PLAYER_ACTION_HIT_BOUNCE
    db   $00    ; $1D PLAYER_ACTION_CLIMB
    db   $00    ; $1E PLAYER_ACTION_GOLD_REMOTE_WARP
    db   $00    ; $1F PLAYER_ACTION_RIDING_ROCKET

data_02_4d15_ActionInputTransitionTable:
; This is Gex's control scheme, as data. One pointer per action id; each list is pairs of
; (input byte, action id) ending in ACTION_INPUT_END, scanned by
; call_02_4c4f_Player_CheckTileInteractions against the filtered pad in
; wD75A_CurrentInputsAlt.
;
; The match is on the whole input byte, not on individual bits, which is why every direction
; combination is spelled out separately - $12 (right + B) and $22 (left + B) are two entries
; even though both mean "jump". ACTION_INPUT_ANY matches any nonzero input, and an input of
; $00 matches only an empty d-pad, which is how actions detect the player letting go.
;
; A null pointer means the action ignores input entirely. That is how the death, damage and
; tv actions become uninterruptible - not by checking anything, but by simply having no
; transitions to offer
    dw   .transitions_Spawn            ; $00 PLAYER_ACTION_SPAWN
    dw   $0000                         ; $01 PLAYER_ACTION_INTRO_WARP
    dw   .transitions_Stand            ; $02 PLAYER_ACTION_STAND
    dw   .transitions_Stand            ; $03 PLAYER_ACTION_IDLE_ANIMATION
    dw   .transitions_Walk             ; $04 PLAYER_ACTION_WALK
    dw   .transitions_Run              ; $05 PLAYER_ACTION_RUN
    dw   .transitions_Skid             ; $06 PLAYER_ACTION_SKID
    dw   .transitions_StopOnFloor      ; $07 PLAYER_ACTION_STOP_ON_CERTAIN_FLOOR
    dw   .transitions_Crouch           ; $08 PLAYER_ACTION_CROUCH
    dw   .transitions_Jump             ; $09 PLAYER_ACTION_JUMP
    dw   .transitions_DoubleJump       ; $0A PLAYER_ACTION_DOUBLE_JUMP
    dw   .transitions_None0B           ; $0B PLAYER_ACTION_NONE
    dw   .transitions_KarateKick       ; $0C PLAYER_ACTION_KARATE_KICK
    dw   .transitions_TailSpin         ; $0D PLAYER_ACTION_TAIL_SPIN
    dw   .transitions_EatFly           ; $0E PLAYER_ACTION_EAT_FLY
    dw   $0000                         ; $0F PLAYER_ACTION_TAKE_DAMAGE
    dw   $0000                         ; $10 PLAYER_ACTION_DEATH
    dw   $0000                         ; $11 PLAYER_ACTION_DEATH_SET_UP_WARP
    dw   $0000                         ; $12 PLAYER_ACTION_ENTER_TV
    dw   $0000                         ; $13 PLAYER_ACTION_ENTER_TV_ALT
    dw   $0000                         ; $14 PLAYER_ACTION_EXIT_TV
    dw   .transitions_StandingPush     ; $15 PLAYER_ACTION_STANDING_PUSH
    dw   .transitions_WalkingPush      ; $16 PLAYER_ACTION_WALKING_PUSH
    dw   $0000                         ; $17 PLAYER_ACTION_FREEFALL
    dw   $0000                         ; $18 PLAYER_ACTION_STOP_IMMEDIATE
    dw   $0000                         ; $19 PLAYER_ACTION_COLLAPSE
    dw   $0000                         ; $1A PLAYER_ACTION_ENTER_DOOR
    dw   $0000                         ; $1B PLAYER_ACTION_LEAVE_DOOR
    dw   $0000                         ; $1C PLAYER_ACTION_HIT_BOUNCE
    dw   $0000                         ; $1D PLAYER_ACTION_CLIMB
    dw   $0000                         ; $1E PLAYER_ACTION_GOLD_REMOTE_WARP
    dw   $0000                         ; $1F PLAYER_ACTION_RIDING_ROCKET

.transitions_Spawn:
    db   ACTION_INPUT_ANY,             PLAYER_ACTION_INTRO_WARP  ; any key skips the spawn
    db   ACTION_INPUT_END

.transitions_Stand:
    db   PADF_B,                       PLAYER_ACTION_JUMP
    db   PADF_A,                       PLAYER_ACTION_TAIL_SPIN
    db   PADF_DOWN,                    PLAYER_ACTION_CROUCH
    db   PADF_SELECT,                  PLAYER_ACTION_EAT_FLY
    db   PADF_RIGHT,                   PLAYER_ACTION_WALK
    db   PADF_LEFT,                    PLAYER_ACTION_WALK
    db   ACTION_INPUT_END

.transitions_Walk:
    db   PADF_RIGHT | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_LEFT  | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_RIGHT | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_LEFT  | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_RIGHT | PADF_DOWN,       PLAYER_ACTION_CROUCH
    db   PADF_LEFT  | PADF_DOWN,       PLAYER_ACTION_CROUCH
    db   PADF_RIGHT | PADF_SELECT,     PLAYER_ACTION_EAT_FLY
    db   PADF_LEFT  | PADF_SELECT,     PLAYER_ACTION_EAT_FLY
    db   $00,                          PLAYER_ACTION_STAND       ; let go and he stops
    db   ACTION_INPUT_END

.transitions_Run:
; the karate kick is only reachable from a run - down + B while sprinting
    db   PADF_RIGHT | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_LEFT  | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_RIGHT | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_LEFT  | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_RIGHT | PADF_DOWN | PADF_B, PLAYER_ACTION_KARATE_KICK
    db   PADF_LEFT  | PADF_DOWN | PADF_B, PLAYER_ACTION_KARATE_KICK
    db   PADF_DOWN,                    PLAYER_ACTION_SKID
    db   PADF_UP,                      PLAYER_ACTION_SKID
    db   $00,                          PLAYER_ACTION_SKID        ; let go and he skids to a halt
    db   ACTION_INPUT_END

.transitions_Skid:
    db   PADF_RIGHT,                   PLAYER_ACTION_WALK
    db   PADF_LEFT,                    PLAYER_ACTION_WALK
    db   ACTION_INPUT_ANY,             PLAYER_ACTION_STAND
    db   ACTION_INPUT_END

.transitions_StopOnFloor:
    db   PADF_B,                       PLAYER_ACTION_JUMP
    db   PADF_SELECT,                  PLAYER_ACTION_EAT_FLY
    db   PADF_RIGHT,                   PLAYER_ACTION_WALK
    db   PADF_LEFT,                    PLAYER_ACTION_WALK
    db   ACTION_INPUT_END

.transitions_Crouch:
    db   PADF_B,                       PLAYER_ACTION_JUMP
    db   PADF_A,                       PLAYER_ACTION_TAIL_SPIN
    db   $00,                          PLAYER_ACTION_STAND
    db   ACTION_INPUT_END

.transitions_Jump:
; mid-air, A is the only thing that does anything - B is handled by the jump action itself
    db   PADF_A,                       PLAYER_ACTION_TAIL_SPIN
    db   PADF_RIGHT | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_LEFT  | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   ACTION_INPUT_END

.transitions_DoubleJump:
    db   PADF_A,                       PLAYER_ACTION_TAIL_SPIN
    db   PADF_RIGHT | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_LEFT  | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   ACTION_INPUT_END

; these four actions run to completion and are only left when their animation ends
.transitions_None0B:
    db   ACTION_INPUT_END
.transitions_KarateKick:
    db   ACTION_INPUT_END
.transitions_TailSpin:
    db   ACTION_INPUT_END
.transitions_EatFly:
    db   ACTION_INPUT_END

.transitions_StandingPush:
; identical to Walk except there is no "$00 means stop", so releasing the d-pad while shoving
; a wall leaves Gex in the push until something else moves him
    db   PADF_RIGHT | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_LEFT  | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_RIGHT | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_LEFT  | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_RIGHT | PADF_DOWN,       PLAYER_ACTION_CROUCH
    db   PADF_LEFT  | PADF_DOWN,       PLAYER_ACTION_CROUCH
    db   PADF_RIGHT | PADF_SELECT,     PLAYER_ACTION_EAT_FLY
    db   PADF_LEFT  | PADF_SELECT,     PLAYER_ACTION_EAT_FLY
    db   ACTION_INPUT_END

.transitions_WalkingPush:
    db   PADF_RIGHT | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_LEFT  | PADF_B,          PLAYER_ACTION_JUMP
    db   PADF_RIGHT | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_LEFT  | PADF_A,          PLAYER_ACTION_TAIL_SPIN
    db   PADF_RIGHT | PADF_DOWN,       PLAYER_ACTION_CROUCH
    db   PADF_LEFT  | PADF_DOWN,       PLAYER_ACTION_CROUCH
    db   PADF_RIGHT | PADF_SELECT,     PLAYER_ACTION_EAT_FLY
    db   PADF_LEFT  | PADF_SELECT,     PLAYER_ACTION_EAT_FLY
    db   $00,                          PLAYER_ACTION_STAND
    db   ACTION_INPUT_END

call_02_4dd8_Player_GetIdleTimerLength:
; Returns the number of frames Gex stands still before the idle animation
; starts. It is a plain constant, which makes the clamp at its only call site
; (call_02_41b7_PlayerAction_Stand) dead code
    ld   A, PLAYER_IDLE_TIMER_LENGTH                   ;; 02:4dd8 $3e $7d
    ret                                                ;; 02:4dda $c9
