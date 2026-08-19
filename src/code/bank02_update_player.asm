; ==================================================================
; PLAYER UPDATE
;
; call_02_4939_Player_UpdateMain is the whole of Gex's per-frame update, called
; once from the main loop. The order it does things in matters, because each
; step consumes what the previous one produced:
;
;   1. read the pad (or the demo stream) and filter it through
;      wD759_ButtonBlockingFlags into wD75A_Player_EffectiveInputs. Everything
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
; TILE_TYPE_SPRING_LOW/HIGH always spring, while TILE_TYPE_POWERED_SPRING_LOW/HIGH only spring
; while the circuit power-up timer is still running, and play a sound when they do
    ld   A, [wD758_JumpVelocityOverride]
    and  A, A
    ret  NZ
    ld   A, [wD765_TileTypeBehindGexsLowerBody]
    cp   A, TILE_TYPE_POWERED_SPRING_LOW
    jr   Z, .jr_02_4876
    cp   A, TILE_TYPE_POWERED_SPRING_HIGH
    jr   Z, .jr_02_4885
    cp   A, TILE_TYPE_SPRING_LOW
    jr   Z, .jr_02_4870
    cp   A, TILE_TYPE_SPRING_HIGH
    jr   Z, .jr_02_4873
.jr_02_486e:
    ld   A, C
    ret
.jr_02_4870:
    ld   A, PLAYER_SPRING_VELOCITY_LOW
    ret
.jr_02_4873:
    ld   A, PLAYER_SPRING_VELOCITY_HIGH
    ret
.jr_02_4876:
    ld   HL, wD751_Player_CircuitPowerUpTimerLo
    ld   A, [HL+]
    or   A, [HL]
    jr   Z, .jr_02_486e
    ld   C, SFX_GEX_JUMP_UNK
    call call_00_112f_QueueSFX
    ld   A, PLAYER_SPRING_VELOCITY_LOW
    ret
.jr_02_4885:
    ld   HL, wD751_Player_CircuitPowerUpTimerLo
    ld   A, [HL+]
    or   A, [HL]
    jr   Z, .jr_02_486e
    ld   C, SFX_GEX_JUMP_UNK
    call call_00_112f_QueueSFX
    ld   A, PLAYER_SPRING_VELOCITY_HIGH
    ret

call_02_4894_Player_CheckWarpReady:
; Reads bit 2 of wD20A (animation-end flag) and returns it in A. Zero flag set if not ready,
; nonzero if warp should fire. Used as a gate in door/TV warp actions
    ld   a,[wD20A_Player_SpriteFlags]
    and  a,SPRITE_FLAG_ANIM_ENDED
    ret

call_02_489a_Player_SetLandingAction:
; Picks the action to land in and is shared by the jump, double jump and the
; landing path of ApplyYVelocity. Blocks B until release so that a held button
; cannot immediately re-jump, then chooses from the d-pad and the speed Gex
; carried into the landing: nothing held lands in Stand, a held direction lands
; in Run if he was already at running speed and Walk otherwise
    ld   HL, wD759_ButtonBlockingFlags
    set  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]
    ld   C, PLAYER_ACTION_STAND
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT
    jr   Z, .jr_02_48b3
    ld   C, PLAYER_ACTION_RUN
    ld   A, [wD75E_PlayerXSpeed]
    cp   A, $02
    jr   NC, .jr_02_48b3
    ld   C, PLAYER_ACTION_WALK
.jr_02_48b3:
    ld   A, C
    jp   call_02_4ccd_Player_RequestAction

call_02_48b7_Player_SpawnOpeningDoorEntity:
; Looks up the current level ID in .data_02_491a_LevelSpecificEntityIdTable to get an entity ID
; (0 = no entity for this level). Scans the entity slot table at $D220 for a free slot (value $FF),
; initializes it with the entity ID, clears two entity fields, then copies the player's X/Y position
; (snapped to $E0 boundary, with a $0F offset and $10 Y flag) into the slot's position fields.
; Calls Entity_SetAction and Entity_ClearSlotCounter. Used to spawn a level-specific companion/effect
; entity tied to the player's position
    push AF
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    ld   DE, .data_02_491a_LevelSpecificEntityIdTable
    add  HL, DE
    ld   A, [HL]
    and  A, A
    jr   NZ, .jr_02_48c8
    pop  AF
    ret
.jr_02_48c8:
    ld   C, A
    ld   H, $d2
    ld   L, $20
.jr_02_48cd:
    ld   A, [HL]
    cp   A, $ff
    jr   Z, .jr_02_48d8
    ld   A, L
    add  A, $20
    ld   L, A
    jr   NZ, .jr_02_48cd
.jr_02_48d8:
    ld   A, L
    ld   [wD300_CurrentEntityAddrLo], A
    or   A, $00
    ld   L, A
    ld   H, $d2
    ld   [HL], C
    ld   A, L
    xor  A, $16
    ld   L, A
    ld   [HL], $00
    ld   A, L
    xor  A, $1b
    ld   L, A
    ld   [HL], $00
    ld   A, L
    xor  A, $03
    ld   L, A
    ld   DE, wD20E_Player_XPositionLo
    ld   A, [DE]
    add  A, $0f
    ld   C, A
    inc  DE
    ld   A, [DE]
    adc  A, $00
    ld   B, A
    inc  DE
    ld   A, C
    and  A, $e0
    ld   [HL+], A
    ld   A, B
    ld   [HL+], A
    ld   A, [DE]
    and  A, $e0
    or   A, $10
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL], A
    pop  AF
    call call_02_7102_Entity_SetAction
    call call_00_34d8_Entity_ResetEntityListIndex
    xor  A, A
    ld   [wD300_CurrentEntityAddrLo], A
    ret
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
; live pad from wD59F_RawInputs. Either way it is filtered through
; wD759_ButtonBlockingFlags and the result written to wD75A_Player_EffectiveInputs.
;
; The queued action is committed here rather than inside Player_RequestAction, which is what
; guarantees an action change always takes effect on a frame boundary. Committing one also
; resets the climb state and climb flags, so any action change cancels a climb.
;
; The tail end is per-frame bookkeeping: wD758_JumpVelocityOverride and the two one-frame
; entity flags are cleared here (they are set by collision earlier in the same frame and must
; not survive into the next), wD76A_Player_BlockX is recomputed as world X >> 5, and
; the three power-up countdowns are ticked. Note the last of those three falls through into
; Player_DecrementPowerupTimer instead of calling it, so the ret at the end of that routine
; is what returns from the whole update
    ld   A, [wD61E_DemoModeEnabled]
    and  A, A
    jr   Z, .jr_02_4965
    ld   HL, wD61F_Demo_FramesUntilNextInput
    dec  [HL]
    jr   NZ, .jr_02_495c
    ld   HL, wD61B_DemoInputsPointer
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   A, [DE]
    cp   A, $ff
    jr   Z, .jr_02_4961
    ld   [wD61F_Demo_FramesUntilNextInput], A
    inc  DE
    ld   A, [DE]
    ld   [wD620_DemoInputs], A
    inc  DE
    ld   [HL], D
    dec  HL
    ld   [HL], E
.jr_02_495c:
    ld   A, [wD620_DemoInputs]
    jr   .jr_02_4968
.jr_02_4961:
    ld   [wD61E_DemoModeEnabled], A
    ret
.jr_02_4965:
    ld   A, [wD59F_RawInputs]
.jr_02_4968:
    ld   C, A
    ld   E, A
    ; A button: swallow presses until the player physically lets go
    ld   HL, wD759_ButtonBlockingFlags
    bit  BTN_BLOCK_A_BIT, [HL]
    jr   Z, .jr_02_4979
    bit  PADF_A_BIT, E
    jr   NZ, .jr_02_4977
    res  BTN_BLOCK_A_BIT, [HL]                         ; released, so stop blocking
.jr_02_4977:
    res  PADF_A_BIT, C
.jr_02_4979:
    ; B button, same idea. Releasing B here clears the whole high nibble,
    ; dropping the rising-edge flags below along with this one
    bit  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]
    jr   Z, .jr_02_4989
    bit  PADF_B_BIT, E
    jr   NZ, .jr_02_4985
    ld   A, [HL]
    and  A, $0f
    ld   [HL], A
.jr_02_4985:
    res  PADF_B_BIT, C
    jr   .jr_02_49a4
.jr_02_4989:
    ; Otherwise B may be blocked only while Gex is still travelling upward.
    ; This is what stops a held B from auto-firing the double jump: B is
    ; suppressed during the rise, but if the player lets go mid-rise the latch
    ; below remembers it and lets the next press through
    bit  BTN_BLOCK_B_WHILE_RISING_BIT, [HL]
    jr   Z, .jr_02_49a4
    res  PADF_B_BIT, C
    ld   A, [wD760_PlayerYVelocity]
    bit  7, A
    jr   Z, .jr_02_49a4
    bit  PADF_B_BIT, E
    jr   NZ, .jr_02_499e
    set  BTN_BLOCK_B_REPRESS_LATCH_BIT, [HL]           ; B was released during the rise
    jr   .jr_02_49a4
.jr_02_499e:
    bit  BTN_BLOCK_B_REPRESS_LATCH_BIT, [HL]
    jr   Z, .jr_02_49a4
    set  PADF_B_BIT, C                                          ; genuine new press, let it through
.jr_02_49a4:
    ld   HL, wD75A_Player_EffectiveInputs
    ld   [HL], C
    ld   HL, wD750_Player_DamageCooldownTimer
    ld   A, [HL]
    and  A, A
    jr   Z, .jr_02_49b0
    dec  [HL]
.jr_02_49b0:
    call call_02_4a45_Player_UpdateFacing
    FARCALL call_03_4900_BgCollision_Update
    call call_02_4b78_Player_ApplyYVelocity
    FARCALL call_03_4c0a_BgCollision_CacheNearbyTileTypes
    call call_02_4c4f_Player_CheckTileInteractions
    ld   HL, wD745_Player_QueuedAction
    ld   A, [HL]
    ld   [HL], PLAYER_ACTION_NONE_PENDING
    cp   A, PLAYER_ACTION_NONE_PENDING
    jr   Z, .jr_02_49e6
    call call_02_7102_Entity_SetAction
    ld   A, CLIMB_STATE_NOT_CLIMBING
    ld   [wD746_Player_ClimbingState], A
    ld   A, $00
    ld   [wD74B_Player_ClimbingFlags], A
.jr_02_49e6:
    ld   HL, wD202_Player_ActionFunc
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    call call_00_10bd_JumpHL
    call call_02_4a77_Player_ApplyXMovement
    xor  A, A
    ld   [wD758_JumpVelocityOverride], A
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD76A_Player_BlockX], A
    ld   HL, wD209_Player_ActionState
    res  ACTION_STATE_IS_FIRST_FRAME_BIT, [HL]
    ld   HL, wD20A_Player_SpriteFlags
    res  SPRITE_FLAG_ID_CHANGED_BIT, [HL]
    call call_02_6fda_Entity_TickAction
    call call_02_715a_MapWindow_Update
    call call_02_4c28_Player_CheckLavaAndWaterTiles
    FARCALL call_03_5ca8_Player_BuildSprites
    ld   HL, wD751_Player_CircuitPowerUpTimerLo
    call call_02_4a30_Player_DecrementPowerupTimer
    ld   HL, wD755_FlyPowerup2_TimerLo
    call call_02_4a30_Player_DecrementPowerupTimer
    ld   HL, wD753_FlyPowerup1_TimerLo

call_02_4a30_Player_DecrementPowerupTimer:
; Decrements a 16-bit timer at HL (little-endian). Returns immediately if already zero
    ld   A, [HL+]
    ld   D, [HL]
    ld   E, A
    or   A, D
    ret  Z
    dec  DE
    ld   [HL], D
    dec  HL
    ld   [HL], E
    ret

call_02_4a3a_Player_LockBPress:
; Arms BTN_BLOCK_B_WHILE_RISING and clears the other three block flags, so B is ignored for
; as long as Gex is still going up. Called at the start of a jump and a double jump - it is
; what makes the double jump require a fresh press rather than a held button
    ld   A, [wD759_ButtonBlockingFlags]
    and  A, $0f
    or   A, BTN_BLOCK_B_WHILE_RISING
    ld   [wD759_ButtonBlockingFlags], A
    ret

call_02_4a45_Player_UpdateFacing:
; Turns held directions into a facing, and ramps Gex up to speed.
; wD75E_PlayerXSpeed is the target speed the current action wants (walk or run);
; wD75D_PlayerXSpeedPrev is the speed actually in use, and this is what nudges it one step
; per frame toward the target. Turning around, or letting go of the d-pad entirely, resets
; it to zero - so Gex always accelerates from a standstill after a direction change rather
; than snapping to full speed. Does nothing while climbing
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_NOT_CLIMBING
    ret  NZ
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT
    jr   Z, .jr_02_4a62
    ld   C, $00
    and  A, $10
    jr   NZ, .jr_02_4a5a
    ld   C, $20
.jr_02_4a5a:
    ld   HL, wD20D_Player_FacingFlags
    ld   A, [HL]
    ld   [HL], C
    cp   A, C
    jr   Z, .jr_02_4a67
.jr_02_4a62:
    xor  A, A
    ld   [wD75D_PlayerXSpeedPrev], A
    ret
.jr_02_4a67:
    ld   A, [wD75D_PlayerXSpeedPrev]
    ld   HL, wD75E_PlayerXSpeed
    cp   A, [HL]
    jr   C, .jr_02_4a72
    ld   A, [HL]
    dec  A
.jr_02_4a72:
    inc  A
    ld   [wD75D_PlayerXSpeedPrev], A
    ret

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
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_NOT_CLIMBING
    ret  NZ
    ld   A, [wD75D_PlayerXSpeedPrev]
    ld   HL, wD20D_Player_FacingFlags
    bit  FACING_LEFT_BIT, [HL]
    jr   Z, .jr_02_4a89
    cpl
    inc  A
.jr_02_4a89:
    ld   HL, wD75C_PlayerXDeltaExtra
    add  A, [HL]
    ret  Z
    push AF
    ld   A, [wD585_CollisionFlags]
    and  A, $0f
    jr   Z, .jr_02_4a9e
    cpl
    inc  A
    ld   C, A
    ld   B, $ff
    call call_02_4c19_Player_AddToYPosition
.jr_02_4a9e:
    pop  AF
    ld   C, A
    bit  7, A
    jr   Z, .jr_02_4b10
    cpl
    inc  A
    ld   C, A
    jp   .jp_02_4aaa
.jp_02_4aaa:
    ld   A, [wD74E_Player_PushedStationaryPlatformLo]
    and  A, A
    jr   NZ, .jr_02_4ac0
    ld   A, [wD74F_Player_PushedMovingPlatformLo]
    and  A, A
    ret  NZ
.jr_02_4ab5:
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL]
    sub  A, C
    ld   [HL+], A
    ld   A, [HL]
    sbc  A, $00
    ld   [HL], A
    ret
.jr_02_4ac0:
    or   A, $16
    ld   L, A
    ld   H, $d2
    bit  7, [HL]
    jr   Z, .jr_02_4ae8
    ld   A, L
    xor  A, $04
    ld   L, A
    ld   A, [wD212_Player_ScreenXPosition]
    cp   A, [HL]
    jr   C, .jr_02_4ab5
    ld   A, L
    xor  A, $06
    ld   L, A
    ld   D, [HL]
    ld   A, L
    xor  A, $1a
    ld   L, A
    ld   A, [HL+]
    add  A, D
    ld   [wD20E_Player_XPositionLo], A
    ld   A, [HL]
    adc  A, $00
    ld   [wD20F_Player_XPositionHi], A
    ret
.jr_02_4ae8:
    push HL
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL]
    sub  A, C
    ld   [HL+], A
    ld   C, A
    ld   A, [HL]
    sbc  A, $00
    ld   [HL], A
    ld   B, A
    pop  HL
    ld   A, L
    xor  A, $04
    ld   L, A
    ld   A, [wD212_Player_ScreenXPosition]
    cp   A, [HL]
    ret  C
    ld   A, L
    xor  A, $06
    ld   L, A
    ld   D, [HL]
    ld   A, L
    xor  A, $1a
    ld   L, A
    ld   A, C
    sub  A, D
    ld   [HL+], A
    ld   A, B
    sbc  A, $00
    ld   [HL], A
    ret
.jr_02_4b10:
    ld   A, [wD74E_Player_PushedStationaryPlatformLo]
    and  A, A
    jr   NZ, .jr_02_4b26
    ld   A, [wD74F_Player_PushedMovingPlatformLo]
    and  A, A
    ret  NZ
.jr_02_4b1b:
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL]
    add  A, C
    ld   [HL+], A
    ld   A, [HL]
    adc  A, $00
    ld   [HL], A
    ret
.jr_02_4b26:
    or   A, $16
    ld   L, A
    ld   H, $d2
    bit  7, [HL]
    jr   Z, .jr_02_4b4f
    ld   A, L
    xor  A, $04
    ld   L, A
    ld   A, [wD212_Player_ScreenXPosition]
    cp   A, [HL]
    jr   NC, .jr_02_4b1b
    ld   A, L
    xor  A, $06
    ld   L, A
    ld   D, [HL]
    inc  D
    ld   A, L
    xor  A, $1a
    ld   L, A
    ld   A, [HL+]
    sub  A, D
    ld   [wD20E_Player_XPositionLo], A
    ld   A, [HL]
    sbc  A, $00
    ld   [wD20F_Player_XPositionHi], A
    ret
.jr_02_4b4f:
    push HL
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL]
    add  A, C
    ld   [HL+], A
    ld   C, A
    ld   A, [HL]
    adc  A, $00
    ld   [HL], A
    ld   B, A
    pop  HL
    ld   A, L
    xor  A, $04
    ld   L, A
    ld   A, [wD212_Player_ScreenXPosition]
    cp   A, [HL]
    ret  NC
    ld   A, L
    xor  A, $06
    ld   L, A
    ld   D, [HL]
    inc  D
    ld   A, L
    xor  A, $1a
    ld   L, A
    ld   A, C
    add  A, D
    ld   [HL+], A
    ld   A, B
    adc  A, $00
    ld   [HL], A
    ret

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
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_NOT_CLIMBING
    ret  NZ
    ld   A, [wD760_PlayerYVelocity]
    bit  7, A
    jr   NZ, .jr_02_4bbc_NegativeOr0Velocity
    and  A, A
    jr   Z, .jr_02_4bbc_NegativeOr0Velocity
    xor  A, A
    ld   [wD763_FallDistanceCounter], A
.jr_02_4b8c:
    ld   A, [wD760_PlayerYVelocity]
    sub  A, PLAYER_GRAVITY_PER_FRAME
    bit  7, A
    jr   Z, .jr_02_4ba4
    cp   A, PLAYER_MAX_FALL_VELOCITY
    jr   NC, .jr_02_4ba4
    ; at terminal velocity, so start counting how long the fall has lasted.
    ; cp $7f / adc $00 is a saturating increment - it stops dead at $80
    ld   HL, wD763_FallDistanceCounter
    ld   A, [HL]
    cp   A, $7f
    adc  A, $00
    ld   [HL], A
    ld   A, PLAYER_MAX_FALL_VELOCITY
.jr_02_4ba4:
    ld   [wD760_PlayerYVelocity], A
    cpl
    inc  A
    swap A
    and  A, $0f
    ld   C, A
    ld   B, $00
    bit  3, A
    jp   Z, call_02_4c19_Player_AddToYPosition
    or   A, $f0
    ld   C, A
    dec  B
    jp   call_02_4c19_Player_AddToYPosition
.jr_02_4bbc_NegativeOr0Velocity:
    ld   A, [wD585_CollisionFlags]
    and  A, $80
    jr   Z, .jr_02_4bd8_NotGrounded
    ld   A, [wD761_Player_FloorSnapVelocity]
    and  A, A
    jr   Z, .jr_02_4bed
    ld   HL, wD584_CollisionFlagsPrev
    bit  7, [HL]
    jr   NZ, .jr_02_4ba4
    ld   HL, wD760_PlayerYVelocity
    cp   A, [HL]
    jr   NC, .jr_02_4ba4
    jr   .jr_02_4b8c
.jr_02_4bd8_NotGrounded:
    ld   A, [wD584_CollisionFlagsPrev]
    and  A, $80
    jr   NZ, .jr_02_4be6
    ld   A, [wD763_FallDistanceCounter]
    cp   A, FALL_DISTANCE_HARD_LANDING
    jr   C, .jr_02_4b8c
.jr_02_4be6:
    ld   A, PLAYER_ACTION_FREEFALL
    call call_02_4ccd_Player_RequestAction
    jr   .jr_02_4b8c
.jr_02_4bed:
    xor  A, A
    ld   [wD760_PlayerYVelocity], A
    ld   HL, wD763_FallDistanceCounter
    ld   A, [HL]
    ld   [HL], $00
    cp   A, FALL_DISTANCE_LANDING_ANIM
    jr   NC, .jr_02_4c00
    xor  A, A
    ld   [wD762_PlayerInitialYVelocity], A
    ret
.jr_02_4c00:
    cp   A, FALL_DISTANCE_HARD_LANDING
    jp   C, call_02_489a_Player_SetLandingAction
    ld   A, PLAYER_ACTION_COLLAPSE
    jp   call_02_4ccd_Player_RequestAction

call_02_4c0a_Player_AddToXPosition:
; Adds signed 16-bit (C, B) to wD20E/wD20F (player world X)
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    ld   [wD20E_Player_XPositionLo], A
    ld   A, [wD20F_Player_XPositionHi]
    adc  A, B
    ld   [wD20F_Player_XPositionHi], A
    ret

call_02_4c19_Player_AddToYPosition:
; Adds signed 16-bit (C, B) to wD210/wD211 (player world Y)
    ld   A, [wD210_Player_YPositionLo]
    add  A, C
    ld   [wD210_Player_YPositionLo], A
    ld   A, [wD211_Player_YPositionHi]
    adc  A, B
    ld   [wD211_Player_YPositionHi], A
    ret

call_02_4c28_Player_CheckLavaAndWaterTiles:
; Runs once per frame to answer two separate questions about liquid.
; First, is Gex standing in it at all: either the tile behind his body or the tile under his
; feet being TILE_TYPE_WATER, or the tile behind his body being TILE_TYPE_LAVA, counts. The
; answer goes into wD74A_Player_InWaterOrLava, which the sprite builder uses to swap in the
; wading frames. Note the flag is stored inverted - $00 means yes, $80 means no - because it
; is produced by xoring $80 over the fall-through value.
; Second, is he actually in lava, in which case he takes the hit: PLAYER_ACTION_HIT_BOUNCE is
; requested, which is the same recoil used when an enemy hits him. Water alone is harmless
    ld   A, [wD765_TileTypeBehindGexsLowerBody]
    sub  A, TILE_TYPE_WATER
    jr   Z, .jr_02_4c3f
    ld   A, [wD767_FloorTileType]
    sub  A, TILE_TYPE_WATER
    jr   Z, .jr_02_4c3f
    ld   A, [wD765_TileTypeBehindGexsLowerBody]
    sub  A, TILE_TYPE_LAVA
    jr   Z, .jr_02_4c3f
    ld   A, $80                                        ; not in liquid
.jr_02_4c3f:
    xor  A, $80
    ld   [wD74A_Player_InWaterOrLava], A
    ld   A, [wD765_TileTypeBehindGexsLowerBody]
    cp   A, TILE_TYPE_LAVA
    ld   A, PLAYER_ACTION_HIT_BOUNCE
    call Z, call_02_4ccd_Player_RequestAction
    ret

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
;    wD75A_Player_EffectiveInputs. $FE matches any nonzero input and $FF ends the list. This is
;    what makes each action define its own controls - pressing B means "jump" while standing
;    and nothing at all while dying, without either action containing that logic
    ld   A, [wD201_Player_ActionId]
    cp   A, PLAYER_ACTION_DEATH
    jr   Z, .jr_02_4c6a
    cp   A, PLAYER_ACTION_DEATH_SET_UP_WARP
    jr   Z, .jr_02_4c6a
    ld   A, [wD764_TileTypeBehindGexsUpperBody]
    cp   A, TILE_TYPE_INSTANT_KILL
    jp   Z, call_00_0696_Player_Die
    ld   A, [wD765_TileTypeBehindGexsLowerBody]
    cp   A, TILE_TYPE_INSTANT_KILL
    jp   Z, call_00_0696_Player_Die
.jr_02_4c6a:
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_UP
    jr   Z, .jr_02_4ca6
    ld   A, [wD764_TileTypeBehindGexsUpperBody]
    cp   A, TILE_TYPE_DOOR
    ld   A, PLAYER_ACTION_ENTER_DOOR
    jr   Z, call_02_4ccd_Player_RequestAction
    ld   A, [wD764_TileTypeBehindGexsUpperBody]
    ld   [wD769_ClimbSurfaceTileType], A
    cp   A, TILE_TYPE_CLIMBABLE_BACKGROUND
    jr   Z, .jr_02_4ca2
    ld   A, [wD766_TileTypeBehindGexsFace]
    ld   [wD769_ClimbSurfaceTileType], A
    cp   A, TILE_TYPE_CLIMBABLE_WALL_FACING_LEFT
    jr   Z, .jr_02_4c9b
    cp   A, TILE_TYPE_CLIMBABLE_WALL_FACING_RIGHT
    jr   NZ, .jr_02_4ca6
    ld   A, [wD20D_Player_FacingFlags]
    cp   A, FACING_RIGHT
    jr   NZ, .jr_02_4ca6
    jr   .jr_02_4ca2
.jr_02_4c9b:
    ld   A, [wD20D_Player_FacingFlags]
    cp   A, FACING_LEFT
    jr   NZ, .jr_02_4ca6
.jr_02_4ca2:
    ld   A, PLAYER_ACTION_CLIMB
    jr   call_02_4ccd_Player_RequestAction
.jr_02_4ca6:
    ld   HL, wD201_Player_ActionId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, data_02_4d15_ActionInputTransitionTable
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    or   A, H
    ret  Z
    ld   A, [wD75A_Player_EffectiveInputs]
    ld   C, A
.jr_02_4cba:
    ld   A, [HL+]
    cp   A, $ff
    ret  Z
    cp   A, $fe
    jr   NZ, .jr_02_4cc6
    inc  C
    dec  C
    jr   NZ, .jr_02_4ccc
.jr_02_4cc6:
    cp   A, C
    jr   Z, .jr_02_4ccc
    inc  HL
    jr   .jr_02_4cba
.jr_02_4ccc:
    ld   A, [HL+]

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
    ld   HL, wD201_Player_ActionId
    cp   A, [HL]
    ret  Z
    ld   L, A
    ld   H, $00
    ld   DE, .data_02_4cf5_ActionTransitionFlagsTable
    add  HL, DE
    bit  0, [HL]
    jr   NZ, .jr_02_4cf1
    ld   HL, wD745_Player_QueuedAction
    bit  7, [HL]
    jr   Z, .jr_02_4ce7
    ld   HL, wD201_Player_ActionId
.jr_02_4ce7:
    ld   L, [HL]
    ld   H, $00
    ld   DE, .data_02_4cf5_ActionTransitionFlagsTable
    add  HL, DE
    bit  1, [HL]
    ret  NZ
.jr_02_4cf1:
    ld   [wD745_Player_QueuedAction], A
    ret
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
    db   $00    ; $07 PLAYER_ACTION_TEETER
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
; wD75A_Player_EffectiveInputs.
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
    dw   .transitions_Teeter           ; $07 PLAYER_ACTION_TEETER
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

.transitions_Teeter:
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
    ld   A, PLAYER_IDLE_TIMER_LENGTH
    ret
