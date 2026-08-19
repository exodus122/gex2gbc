; ==================================================================
; PLAYER ACTIONS
;
; Gex is entity slot 0, so he runs through the same action machinery as every
; other entity: wD201_Player_ActionId names the current action and
; wD202_Player_ActionFunc holds the update function that
; call_02_4939_Player_UpdateMain calls once per frame. The table below is what
; call_02_7102_Entity_SetAction reads to populate both, plus the animation
; script that drives wD208_Player_SpriteID.
;
; Nothing changes the action directly. Code calls
; call_02_4ccd_Player_RequestAction, which parks the new id in
; wD745_Player_QueuedAction, and Player_UpdateMain applies it at the top of the
; next frame. That indirection is what lets a death or damage action refuse to
; be overwritten by whatever the player is holding on the d-pad - see the
; transition flags table at .data_02_4cf5.
;
; An action function is called every frame it is active, and finds out where it
; is in its own lifetime from two flags on the entity:
;   ACTION_STATE_IS_FIRST_FRAME (wD209) - run one-time setup
;   SPRITE_FLAG_ANIM_ENDED           (wD20A) - the animation just played its last
;                                         frame, so hand off to the next action
; ==================================================================

data_02_4120_EntityActions_Gex:
; Gex's action table - the ENTITY_GEX row of data_02_4000_EntityActionJumpTable, so
; it has exactly the same 4-byte row format as every enemy's table: the update
; function, then the action data block that drives the animation.
;
; Unlike the enemy tables this one is a full $80 bytes with no gaps and no
; terminator - action ids run $00-$1F and PLAYER_ACTION_MASK ($1F) is applied
; before every lookup, so an id can never leave the table.
;
; The row number IS the PLAYER_ACTION_* id, and two more tables in
; bank02_update_player.asm are indexed by that same number and have to stay in
; step with it: .data_02_4cf5_ActionTransitionFlagsTable (which requests win) and
; data_02_4d15_ActionInputTransitionTable (which inputs lead where)
    dw   call_02_41a0_PlayerAction_Spawn, data_02_755c                  ; $00 PLAYER_ACTION_SPAWN
    dw   call_02_41ad_PlayerAction_IntroWarp, data_02_756d              ; $01 PLAYER_ACTION_INTRO_WARP
    dw   call_02_41b7_PlayerAction_Stand, data_02_7573                  ; $02 PLAYER_ACTION_STAND
    dw   call_02_422b_PlayerAction_IdleAnimation, data_02_757c          ; $03 PLAYER_ACTION_IDLE_ANIMATION
    dw   call_02_422c_PlayerAction_Walk, data_02_7582                   ; $04 PLAYER_ACTION_WALK
    dw   call_02_4248_PlayerAction_Run, data_02_758f                    ; $05 PLAYER_ACTION_RUN
    dw   call_02_425a_PlayerAction_SkidDecel, data_02_759c              ; $06 PLAYER_ACTION_SKID
    dw   call_02_426b_PlayerAction_Teeter, data_02_75a4                 ; $07 PLAYER_ACTION_TEETER
    dw   call_02_4270_PlayerAction_Crouch, data_02_75ad                 ; $08 PLAYER_ACTION_CROUCH
    dw   call_02_4275_PlayerAction_Jump, data_02_75b3                   ; $09 PLAYER_ACTION_JUMP
    dw   call_02_42ac_PlayerAction_DoubleJump, data_02_75bb             ; $0A PLAYER_ACTION_DOUBLE_JUMP
    dw   call_02_42e0_PlayerAction_None, data_02_75c1                   ; $0B PLAYER_ACTION_NONE
    dw   call_02_42e1_PlayerAction_KarateKick, data_02_75c7             ; $0C PLAYER_ACTION_KARATE_KICK
    dw   call_02_42f7_PlayerAction_TailSpin, data_02_75ce               ; $0D PLAYER_ACTION_TAIL_SPIN
    dw   call_02_434d_PlayerAction_EatFly, data_02_75d9                 ; $0E PLAYER_ACTION_EAT_FLY
    dw   call_02_435b_PlayerAction_TakeDamage, data_02_75df             ; $0F PLAYER_ACTION_TAKE_DAMAGE
    dw   call_02_4371_PlayerAction_Death, data_02_75e9                  ; $10 PLAYER_ACTION_DEATH
    dw   call_02_437b_PlayerAction_DeathSetUpWarp, data_02_75f2         ; $11 PLAYER_ACTION_DEATH_SET_UP_WARP
    dw   call_02_43a7_PlayerAction_EnterTV, data_02_75f9                ; $12 PLAYER_ACTION_ENTER_TV
    dw   call_02_43c6_PlayerAction_EnterTVAlt, data_02_75f9             ; $13 PLAYER_ACTION_ENTER_TV_ALT
    dw   call_02_43e5_PlayerAction_ExitTV, data_02_7608                 ; $14 PLAYER_ACTION_EXIT_TV
    dw   call_02_43f6_PlayerAction_StandingPush, data_02_7617           ; $15 PLAYER_ACTION_STANDING_PUSH
    dw   call_02_4407_PlayerAction_WalkingPush, data_02_761d            ; $16 PLAYER_ACTION_WALKING_PUSH
    dw   call_02_4418_PlayerAction_Freefall, data_02_762a               ; $17 PLAYER_ACTION_FREEFALL
    dw   call_02_4443_PlayerAction_StopImmediate, data_02_7633          ; $18 PLAYER_ACTION_STOP_IMMEDIATE
    dw   call_02_4448_PlayerAction_Collapse, data_02_7639               ; $19 PLAYER_ACTION_COLLAPSE
    dw   call_02_4459_PlayerAction_EnterDoor, data_02_7647              ; $1A PLAYER_ACTION_ENTER_DOOR
    dw   call_02_447e_PlayerAction_LeaveDoor, data_02_7658              ; $1B PLAYER_ACTION_LEAVE_DOOR
    dw   call_02_4483_PlayerAction_HitBounce, data_02_7665              ; $1C PLAYER_ACTION_HIT_BOUNCE
    dw   call_02_44af_PlayerAction_Climb, data_02_766d                  ; $1D PLAYER_ACTION_CLIMB
    dw   call_02_481b_PlayerAction_GoldRemoteWarp, data_02_7673         ; $1E PLAYER_ACTION_GOLD_REMOTE_WARP
    dw   call_02_4828_PlayerAction_RidingRocket, data_02_7684           ; $1F PLAYER_ACTION_RIDING_ROCKET

call_02_41a0_PlayerAction_Spawn:
; On first frame (bit 5 of wD209 set): plays spawn SFX
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_41ac
    ld   C, SFX_GEX_SPAWN
    call call_00_112f_QueueSFX
.jr_02_41ac:
    ret

call_02_41ad_PlayerAction_IntroWarp:
; The one-frame action Gex passes through as a level starts. Outside the Media
; Dimension hub (level id 0) it kicks off FlyPowerup_StartEntry, which flies the
; held power-up fly onto the HUD; in the hub the fly is not shown, so the call is
; skipped. It then calls Entity_RequestQueuedAction, which fires the action the
; data block parked in wD209 straight away instead of waiting for the animation to
; end - data_02_756d names PLAYER_ACTION_STAND - so this action lasts one frame
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    call NZ, call_00_0634_FlyPowerup_StartEntry
    jp   call_02_70f1_Entity_RequestQueuedAction

call_02_41b7_PlayerAction_Stand:
; On first frame: sets B-lock flag (bit 6 of wD759), zeroes X speed and Y velocity, and loads the
; idle timer. The clamp against $32 below is dead code - Player_GetIdleTimerLength always
; returns PLAYER_IDLE_TIMER_LENGTH ($7D), which is already above the floor, so the branch is
; always taken. It looks like the length was once derived from something variable.
; Each frame: checks the floor tile type. A TILE_TYPE_TEETER_LEFT tile while facing left, or a
; TILE_TYPE_TEETER_RIGHT tile while facing right, means Gex is at an edge he must not walk off,
; so it requests PLAYER_ACTION_TEETER. Otherwise the idle timer counts down and
; PLAYER_ACTION_IDLE_ANIMATION starts when it expires
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_41da
    ld   HL, wD759_ButtonBlockingFlags
    set  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]
    xor  A, A
    ld   [wD75D_PlayerXSpeedPrev], A
    ld   [wD760_PlayerYVelocity], A
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    call call_02_4dd8_Player_GetIdleTimerLength
    cp   A, $32                                        ; always NC - see header
    jr   NC, .jr_02_41d7
    ld   A, $32                                        ; unreachable
.jr_02_41d7:
    ld   [wD75B_IdleTimer], A
.jr_02_41da:
    ld   A, [wD767_FloorTileType]
    cp   A, TILE_TYPE_TEETER_LEFT
    jr   Z, .jr_02_41ee
    cp   A, TILE_TYPE_TEETER_RIGHT
    jr   NZ, .jr_02_41fa
    ld   A, [wD20D_Player_FacingFlags]
    cp   A, FACING_RIGHT
    jr   NZ, .jr_02_41fa
    jr   .jr_02_41f5
.jr_02_41ee:
    ld   A, [wD20D_Player_FacingFlags]
    cp   A, FACING_LEFT
    jr   NZ, .jr_02_41fa
.jr_02_41f5:
    ld   A, PLAYER_ACTION_TEETER
    jp   call_02_4ccd_Player_RequestAction
.jr_02_41fa:
    ld   HL, wD75B_IdleTimer
    dec  [HL]
    ret  NZ
    ld   A, PLAYER_ACTION_IDLE_ANIMATION
    jp   call_02_4ccd_Player_RequestAction

call_02_4204_Player_CheckWallPush:
; Decides whether Gex should switch to a pushing animation, and is called by every ground
; action that can push something. The caller passes its own action id in C as the fallback,
; so if nothing is being pushed this ends up requesting the action that is already running,
; which Player_RequestAction discards.
; If wD74E_Player_PushedStationaryPlatformLo names an entity, holding left or right selects
; PLAYER_ACTION_WALKING_PUSH. If no entity is being pushed, BGCOLL_WALL_BIT in
; wD585_CollisionFlags (he ran into a wall this frame) selects PLAYER_ACTION_STANDING_PUSH.
; Note the entity branch tests the d-pad twice and writes PLAYER_ACTION_STANDING_PUSH in
; between; the second test can never fail, so that intermediate write is dead
    ld   A, [wD74E_Player_PushedStationaryPlatformLo]
    and  A, A
    jr   NZ, .jr_02_4215
    ld   HL, wD585_CollisionFlags
    bit  BGCOLL_WALL_BIT, [HL]
    jr   Z, .jr_02_4227
    ld   C, PLAYER_ACTION_STANDING_PUSH
    jr   .jr_02_4227
.jr_02_4215:
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT
    jr   Z, .jr_02_4227
    ld   C, PLAYER_ACTION_STANDING_PUSH
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT
    jr   Z, .jr_02_4227
    ld   C, PLAYER_ACTION_WALKING_PUSH
.jr_02_4227:
    ld   A, C
    jp   call_02_4ccd_Player_RequestAction

call_02_422b_PlayerAction_IdleAnimation:
; No update logic - the action exists purely so that the animation script at
; data_02_757c (Gex tapping his foot, flicking his tongue) plays. Stand hands
; over to it once wD75B_IdleTimer runs out, and the input transition table
; sends any input straight back to Stand
    ret

call_02_422c_PlayerAction_Walk:
; On first frame: drops X speed to PLAYER_XSPEED_WALK. Every frame it offers Walk as the
; fallback to Player_CheckWallPush, then checks the animation-ended flag: once the walk
; cycle has played all the way through, Gex accelerates into PLAYER_ACTION_RUN. So the
; walk is really a wind-up - hold a direction long enough for one full cycle and he runs
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_4238
    ld   A, PLAYER_XSPEED_WALK
    ld   [wD75E_PlayerXSpeed], A
.jr_02_4238:
    ld   C, PLAYER_ACTION_WALK
    call call_02_4204_Player_CheckWallPush
    ld   A, [wD20A_Player_SpriteFlags]
    and  A, SPRITE_FLAG_ANIM_ENDED
    ld   A, PLAYER_ACTION_RUN
    call NZ, call_02_4ccd_Player_RequestAction
    ret

call_02_4248_PlayerAction_Run:
; On first frame: raises X speed to PLAYER_XSPEED_RUN. Otherwise just offers Run as the
; fallback action to Player_CheckWallPush. There is no exit condition here - leaving the
; run is driven entirely by the input transition table entry for PLAYER_ACTION_RUN
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_4254
    ld   A, PLAYER_XSPEED_RUN
    ld   [wD75E_PlayerXSpeed], A
.jr_02_4254:
    ld   C, PLAYER_ACTION_RUN
    call call_02_4204_Player_CheckWallPush
    ret

call_02_425a_PlayerAction_SkidDecel:
; Decelerates X speed from 2 to 0 over the animation duration using the
; sprite frame counter: speed = max(0, 2 − (frame+1)>>1)
    ld   A, [wD207_Player_SpriteCounter]
    inc  A
    srl  A
    ld   C, A
    ld   A, PLAYER_XSPEED_RUN
    sub  A, C
    jr   NC, .jr_02_4267
    xor  A, A
.jr_02_4267:
    ld   [wD75E_PlayerXSpeed], A
    ret

call_02_426b_PlayerAction_Teeter:
; Gex windmilling at the edge of a platform. Requested by Stand when the floor tile
; under him is a TILE_TYPE_TEETER_* facing the drop. All it does is hold him still -
; the animation loops on its own and .transitions_Teeter lets him walk or jump out of
; it. He can still be walked off the edge, so the teeter is a warning rather than a
; barrier - and since that list has no entry for an empty d-pad, letting go of the
; controls leaves him wobbling there indefinitely
    xor a
    ld [wD75E_PlayerXSpeed], a
    ret

call_02_4270_PlayerAction_Crouch:
; Holds Gex still for as long as down is held. The action has no logic of its own -
; .transitions_Crouch returns him to Stand the moment the d-pad reads empty, and
; sends him to Jump or TailSpin from B or A. data_02_75ad is a single frame, so the
; crouch is a pose rather than an animation
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    ret

call_02_4275_PlayerAction_Jump:
; On the first frame it asks Player_GetJumpVelocity for the launch speed, offering
; PLAYER_JUMP_VELOCITY in C - the helper hands that straight back unless an entity
; asked for a specific launch this frame or Gex is standing on a spring tile. The
; result goes into both wD760 (the live velocity, which gravity eats away at) and
; wD762, which Player_ApplyYVelocity clears when he touches down and so doubles as
; the "still airborne" flag. It then blocks B until release, plays the jump sound
; and nudges X speed to at least 1 so a standing jump still drifts forward.
; Every later frame does nothing until wD762 clears. On the landing frame a B press
; buys a double jump - and because B was blocked until release, that has to be a
; fresh press. Otherwise Player_SetLandingAction picks Stand, Walk or Run.
; A landing hard enough to matter never reaches here: Player_ApplyYVelocity itself
; requests the landing or PLAYER_ACTION_COLLAPSE from the fall distance
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_429a
    ld   C, PLAYER_JUMP_VELOCITY
    call call_02_4856_Player_GetJumpVelocity
    ld   [wD760_PlayerYVelocity], A
    ld   [wD762_PlayerInitialYVelocity], A
    call call_02_4a3a_Player_LockBPress
    ld   C, SFX_GEX_JUMP
    call call_00_112f_QueueSFX
    ld   A, [wD75E_PlayerXSpeed]
    and  A, A
    jr   NZ, .jr_02_429a
    ld   A, $01
    ld   [wD75E_PlayerXSpeed], A
.jr_02_429a:
    ld   A, [wD762_PlayerInitialYVelocity]
    and  A, A
    ret  NZ
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_B
    ld   A, PLAYER_ACTION_DOUBLE_JUMP
    jp   NZ, call_02_4ccd_Player_RequestAction
    jp   call_02_489a_Player_SetLandingAction

call_02_42ac_PlayerAction_DoubleJump:
; The same shape as Jump but with PLAYER_DOUBLE_JUMP_VELOCITY, which is why the
; second hop goes higher than the first. It reuses Player_GetJumpVelocity, so a
; double jump off a spring gets the spring's velocity too.
; The difference is at the end: instead of requesting a further action when he lands
; with B pressed, it jumps back to its own first-frame code at .jr_02_42b3 and
; launches again without ever leaving the action. So this handler, not a chain of
; requests, is what lets Gex bounce indefinitely by tapping B on each landing
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_42d1
.jr_02_42b3:
    ld   C, PLAYER_DOUBLE_JUMP_VELOCITY
    call call_02_4856_Player_GetJumpVelocity
    ld   [wD760_PlayerYVelocity], A
    ld   [wD762_PlayerInitialYVelocity], A
    call call_02_4a3a_Player_LockBPress
    ld   C, SFX_GEX_DOUBLE_JUMP
    call call_00_112f_QueueSFX
    ld   A, [wD75E_PlayerXSpeed]
    and  A, A
    jr   NZ, .jr_02_42d1
    ld   A, $01
    ld   [wD75E_PlayerXSpeed], A
.jr_02_42d1:
    ld   A, [wD762_PlayerInitialYVelocity]
    and  A, A
    ret  NZ
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_B
    jr   NZ, .jr_02_42b3
    jp   call_02_489a_Player_SetLandingAction

call_02_42e0_PlayerAction_None:
; A hole in the action table. Nothing in any bank ever requests PLAYER_ACTION_NONE,
; and everything about it is a dead end if something did: the handler is a bare ret,
; its input transition list at .transitions_None0B is empty, and its animation block
; data_02_75c1 is one frame with no pending action - so Gex would stand on sprite $00
; forever with the controls doing nothing. It exists to keep the ids either side of
; it at their expected values
    ret

call_02_42e1_PlayerAction_KarateKick:
; On first frame: sets wD74C_Player_KarateKickTimer = $30 (duration timer).
; Each frame: decrements wD74C_Player_KarateKickTimer; when it reaches zero, requests Stand
    ld a, [wD209_Player_ActionState]
    and a,ACTION_STATE_IS_FIRST_FRAME
    jr z, .jr_02_42ed
    ld a, PLAYER_KARATE_KICK_LENGTH
    ld [wD74C_Player_KarateKickTimer], a
.jr_02_42ed:
    ld hl, wD74C_Player_KarateKickTimer
    dec [hl]
    ret nz
    ld a, PLAYER_ACTION_STAND
    jp call_02_4ccd_Player_RequestAction

call_02_42f7_PlayerAction_TailSpin:
; The tail whip, Gex's only attack. On the first frame it locks the A button until release
; (so holding A cannot chain whips), raises wD76B_Player_IsAttacking - which is what makes
; entity collision treat him as dangerous this frame rather than vulnerable - and nudges him
; to at least walking speed so the whip carries him forward.
; Every frame it re-reads the tile behind him and, if that tile is TILE_TYPE_INTERACTIVE_MIN
; or above (crates, switches, cages), runs the tile hit script. The comparison is done on
; the complement of the tile type, so the test reads as "cp $40" - see the constants.
; When the animation ends it clears the attacking flag, re-locks B, and picks the next action
; from the ground state: airborne means PLAYER_ACTION_FREEFALL, on the ground it is Stand,
; Walk or Run depending on whether a direction is held and how fast he was already moving
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_4313
    ld   HL, wD759_ButtonBlockingFlags
    set  BTN_BLOCK_A_BIT, [HL]
    ld   A, $01
    ld   [wD76B_Player_IsAttacking], A
    ld   A, [wD75E_PlayerXSpeed]
    and  A, A
    jr   NZ, .jr_02_4313
    ld   A, $01
    ld   [wD75E_PlayerXSpeed], A
.jr_02_4313:
    ld   A, [wD764_TileTypeBehindGexsUpperBody]
    cpl
    ld   C, A
    cp   A, TILE_TYPE_INTERACTIVE_MIN_CPL
    call C, call_00_1f46_TileHit_OnPlayerAttack
    ld   A, [wD20A_Player_SpriteFlags]
    and  A, SPRITE_FLAG_ANIM_ENDED
    ret  Z
    xor  A, A
    ld   [wD76B_Player_IsAttacking], A
    ld   HL, wD759_ButtonBlockingFlags
    set  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]
    ld   C, PLAYER_ACTION_FREEFALL
    ld   HL, wD585_CollisionFlags
    bit  BGCOLL_NO_COLLISION_BIT, [HL]                 ; set = grounded
    jr   Z, .jr_02_4349
    ld   C, PLAYER_ACTION_STAND
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT
    jr   Z, .jr_02_4349
    ld   C, PLAYER_ACTION_RUN
    ld   A, [wD75E_PlayerXSpeed]
    cp   A, $02
    jr   NC, .jr_02_4349
    ld   C, PLAYER_ACTION_WALK
.jr_02_4349:
    ld   A, C
    jp   call_02_4ccd_Player_RequestAction

call_02_434d_PlayerAction_EatFly:
; Gex swallowing a fly power-up. Holds him still and, on the first frame only, calls
; call_00_0647_Player_SetUpOrEatFlyPowerup with A = 0 to apply the power-up itself.
; The action ends when its animation runs out and the transition table sends him back to Stand
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    ret  z
    xor  a
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup

call_02_435b_PlayerAction_TakeDamage:
; Gex flinching. It does not take the hit - call_00_06bf_DealDamageToPlayer has
; already done that before requesting this - it just plays the hurt sound, holds him
; still, and reloads the invincibility timer every frame so the whole flinch is
; covered rather than only its first frame. data_02_75df returns him to Stand
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_4367
    ld   c,SFX_GEX_HURT
    call call_00_112f_QueueSFX
.jr_02_4367:
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   a,PLAYER_DAMAGE_COOLDOWN_LENGTH
    ld   [wD750_Player_DamageCooldownTimer],a
    ret

call_02_4371_PlayerAction_Death:
; The first half of dying, requested by call_00_0696_Player_Die once health hits
; zero. It only holds Gex still and keeps him invulnerable; data_02_75e9 plays the
; collapse and then hands him to PLAYER_ACTION_DEATH_SET_UP_WARP, which does the
; actual work of fading out and asking for the respawn
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    ld   A, PLAYER_DAMAGE_COOLDOWN_LENGTH
    ld   [wD750_Player_DamageCooldownTimer], A
    ret

call_02_437b_PlayerAction_DeathSetUpWarp:
; The second half of dying, reached from PLAYER_ACTION_DEATH when its animation
; ends. On the first frame it stops Gex, starts FadeToBlack - whose mask leaves OBP1
; alone, so the world darkens around him while he stays visible - and plays the
; death jingle. It holds the damage cooldown topped up the whole time so nothing can
; hit him again mid-death.
; When its own animation ends it points wD744_Player_SpawnAction at
; PLAYER_ACTION_SPAWN and raises WARP_DIED, which is what the main loop watches for
; to reload the level at the last checkpoint
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_438e
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    call call_00_0f5d_FadeToBlack
    ld   C, SFX_GEX_DEATH
    call call_00_112f_QueueSFX
.jr_02_438e:
    ld   A, PLAYER_DAMAGE_COOLDOWN_LENGTH
    ld   [wD750_Player_DamageCooldownTimer], A
    ld   A, [wD20A_Player_SpriteFlags]
    and  A, SPRITE_FLAG_ANIM_ENDED
    ret  Z
    ld   A, PLAYER_ACTION_SPAWN
    ld   [wD744_Player_SpawnAction], A
    ld   A, [wD621_WarpFlags]
    or   A, WARP_DIED
    ld   [wD621_WarpFlags], A
    ret

; ------------------------------------------------------------------
; ENTER_TV AND ENTER_TV_ALT
;
; Two action ids for one behaviour. Both play the spawn sound, hold Gex still and
; raise WARP_ENTERED_TV when the animation ends, both use the same animation block
; (data_02_75f9) and both have the same row in the transition flags table, so
; nothing downstream can tell them apart. Only the callers do:
;
;   ENTER_TV     ($12) the hub's television buttons, and only inside the hub, where
;                the button also records which television Gex will come back out of
;   ENTER_TV_ALT ($13) everything else - the same buttons outside the hub (a level's
;                exit pad) and the portal Rez leaves behind when he dies
;
; The two encode the flag test differently ($43a7 uses bit, $43c6 uses ld+and) but
; assemble to the same effect
; ------------------------------------------------------------------

call_02_43a7_PlayerAction_EnterTV:
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_43b3
    ld   C, SFX_GEX_SPAWN
    call call_00_112f_QueueSFX
.jr_02_43b3:
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    ld   HL, wD20A_Player_SpriteFlags
    bit  SPRITE_FLAG_ANIM_ENDED_BIT, [HL]
    ret  Z
    ld   A, [wD621_WarpFlags]
    or   A, WARP_ENTERED_TV
    ld   [wD621_WarpFlags], A
    ret

call_02_43c6_PlayerAction_EnterTVAlt:
; See the note above call_02_43a7_PlayerAction_EnterTV - same behaviour, different
; callers
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_43D2
    ld   c,SFX_GEX_SPAWN
    call call_00_112f_QueueSFX
.jr_02_43D2:
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   a,[wD20A_Player_SpriteFlags]
    and  a,SPRITE_FLAG_ANIM_ENDED
    ret  z
    ld   a,[wD621_WarpFlags]
    or   a,WARP_ENTERED_TV
    ld   [wD621_WarpFlags],a
    ret

call_02_43e5_PlayerAction_ExitTV:
; The other side of the warp - Gex stepping out of a television. Plays the spawn
; sound once and holds him still; data_02_7608 carries a pending PLAYER_ACTION_STAND
; so he drops into standing when the animation ends. Requested by the level loader
; in bank 0 and by the level-select menu in bank 1, never by anything in this file
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_43f1
    ld   C, SFX_GEX_SPAWN
    call call_00_112f_QueueSFX
.jr_02_43f1:
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    ret

call_02_43f6_PlayerAction_StandingPush:
; Gex leaning into a wall he cannot move. On the first frame it drops him to
; walking speed, then every frame it re-runs Player_CheckWallPush with
; PLAYER_ACTION_STAND as the fallback - so the moment the wall contact stops and no
; entity is being pushed, he falls back to standing
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_4402
    ld   a,PLAYER_XSPEED_WALK
    ld   [wD75E_PlayerXSpeed],a
.jr_02_4402:
    ld   c,PLAYER_ACTION_STAND
    jp   call_02_4204_Player_CheckWallPush

call_02_4407_PlayerAction_WalkingPush:
; Byte for byte the same as StandingPush above - the only difference is which
; animation block the table pairs it with. This is the one Gex uses when he is
; actually shoving something along (the crates and hub television buttons named by
; wD74E_Player_PushedStationaryPlatformLo), so he walks rather than strains in place
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_4413
    ld   A, PLAYER_XSPEED_WALK
    ld   [wD75E_PlayerXSpeed], A
.jr_02_4413:
    ld   C, PLAYER_ACTION_STAND
    jp   call_02_4204_Player_CheckWallPush

call_02_4418_PlayerAction_Freefall:
; Gex falling without having jumped - walking off a ledge, letting go of a climb, a
; platform vanishing under him. The first frame writes 1 to wD762 by hand, because
; nothing launched him and the flag has to say "airborne" for the wait below to work,
; and gives him a minimum X speed so he does not drop straight down.
; Player_ApplyYVelocity clears wD762 when he touches down, and he lands in Walk if a
; direction is held or Stand if not. Unlike Jump this offers no double jump, so
; walking off a ledge really is a commitment
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_442f
    ld   A, $01
    ld   [wD762_PlayerInitialYVelocity], A
    ld   A, [wD75E_PlayerXSpeed]
    and  A, A
    jr   NZ, .jr_02_442f
    ld   A, $01
    ld   [wD75E_PlayerXSpeed], A
.jr_02_442f:
    ld   A, [wD762_PlayerInitialYVelocity]
    and  A, A
    ret  NZ
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT
    ld   A, PLAYER_ACTION_WALK
    jp   NZ, call_02_4ccd_Player_RequestAction
    ld   A, PLAYER_ACTION_STAND
    jp   call_02_4ccd_Player_RequestAction

call_02_4443_PlayerAction_StopImmediate:
; Stops Gex dead and lets data_02_7633 hand him straight back to Stand when its one
; frame is up. Like PLAYER_ACTION_NONE nothing requests it - the only difference is
; that this one would at least recover if anything did
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ret

call_02_4448_PlayerAction_Collapse:
; Gex flattened. Requested from two places: Player_ApplyYVelocity when the fall
; distance reaches FALL_DISTANCE_HARD_LANDING, and COLLISION_TYPE_FALLING_HAZARD in
; bank 3 when something drops on his head. It plays the thud and pins him in place;
; data_02_7639 runs nine frames of him picking himself up and then hands him to Stand
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_4454
    ld   C, SFX_GEX_COLLAPSE
    call call_00_112f_QueueSFX
.jr_02_4454:
    xor  A, A
    ld   [wD75E_PlayerXSpeed], A
    ret

call_02_4459_PlayerAction_EnterDoor:
; On the first frame it calls Player_SpawnOpeningDoorEntity, which drops the level's
; own door entity (the table there is per level) at Gex's position so the door is
; seen to open. He is held still until the animation ends, and then the warp fires:
; WARP_ENTERED_DOOR tells the main loop to move him, wD744_Player_SpawnAction is set
; so he comes out of the far door with PLAYER_ACTION_LEAVE_DOOR, and every entity
; slot is cleared because the room he is arriving in will repopulate them
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_4465
    ld   a,$00
    call call_02_48b7_Player_SpawnOpeningDoorEntity
.jr_02_4465:
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    call call_02_4894_Player_CheckWarpReady
    ret  z
    ld   a,[wD621_WarpFlags]
    or   a,WARP_ENTERED_DOOR
    ld   [wD621_WarpFlags],a
    ld   a,PLAYER_ACTION_LEAVE_DOOR
    ld   [wD744_Player_SpawnAction],a
    call call_00_38f0_Entity_ClearAllSlots
    ret

call_02_447e_PlayerAction_LeaveDoor:
; Gex stepping out of the far side of a door. wD744_Player_SpawnAction is set to this
; by EnterDoor, so it is the action he is spawned into when the new room loads. It
; only holds him still; data_02_7658 plays him emerging and hands him to Stand.
; The entity loader in bank02_update_entities.asm tests wD744 for this same value as
; it repopulates the room, and spawns the matching open-door entity when it matches -
; which is how the door Gex comes out of is already open behind him
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ret

call_02_4483_PlayerAction_HitBounce:
; The recoil from touching something that hurts. On the first frame it plays the hit sound,
; takes a hit point off via DealDamageToPlayer, and launches Gex upward at
; PLAYER_HIT_BOUNCE_VELOCITY - noticeably harder than a normal jump, which is what makes a
; hit knock him clear of whatever he touched. Once the arc finishes he returns to Stand.
; Despite the name this is also the lava reaction: call_02_4c28_Player_CheckLavaAndWaterTiles
; requests it whenever the tile behind Gex is TILE_TYPE_LAVA
    ld   a,[wD209_Player_ActionState]
    and  a,ACTION_STATE_IS_FIRST_FRAME
    jr   z,.jr_02_44A5
    ld   c,SFX_GEX_HIT_BOUNCE
    call call_00_112f_QueueSFX
    call call_00_06bf_DealDamageToPlayer
    ld   a,PLAYER_HIT_BOUNCE_VELOCITY
    ld   [wD760_PlayerYVelocity],a
    ld   [wD762_PlayerInitialYVelocity],a
    ld   a,[wD75E_PlayerXSpeed]
    and  a
    jr   nz,.jr_02_44A5
    ld   a,$01
    ld   [wD75E_PlayerXSpeed],a
.jr_02_44A5:
    ld   a,[wD762_PlayerInitialYVelocity]
    and  a
    ret  nz
    ld   a,PLAYER_ACTION_STAND
    jp   call_02_4ccd_Player_RequestAction

call_02_44af_PlayerAction_Climb:
; Climbing is a single action with its own state machine, because Gex climbs two different
; kinds of surface (chain-link background and sheer wall) and can tail spin on either.
; On the first frame it locks B, zeroes the climb counter, X speed, Y velocity and floor
; distance, and picks the starting sub-state from the tile that triggered the climb:
; TILE_TYPE_CLIMBABLE_BACKGROUND gives CLIMB_STATE_BACKGROUND, anything else (the two
; directional wall tiles) gives CLIMB_STATE_WALL.
; Every frame after that it just dispatches through .data_02_44e5 on wD746. Note that
; setting wD746 to anything other than CLIMB_STATE_NOT_CLIMBING is also what switches off
; gravity and normal walking over in bank02_update_player.asm, so this handler owns Gex's
; movement completely until it hands back with a Player_RequestAction
    ld   A, [wD209_Player_ActionState]
    and  A, ACTION_STATE_IS_FIRST_FRAME
    jr   Z, .jr_02_44d6
    ld   HL, wD759_ButtonBlockingFlags
    set  BTN_BLOCK_B_UNTIL_RELEASE_BIT, [HL]
    xor  A, A
    ld   [wD747_Player_ClimbAnimCounter], A
    ld   [wD75E_PlayerXSpeed], A
    ld   [wD760_PlayerYVelocity], A
    ld   [wD761_Player_FloorSnapVelocity], A
    ld   A, [wD769_ClimbSurfaceTileType]
    cp   A, TILE_TYPE_CLIMBABLE_BACKGROUND
    ld   A, CLIMB_STATE_BACKGROUND
    jr   Z, .jr_02_44d3
    ld   A, CLIMB_STATE_WALL
.jr_02_44d3:
    ld   [wD746_Player_ClimbingState], A
.jr_02_44d6:
    ld   HL, wD746_Player_ClimbingState
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_02_44e5
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    jp   HL
.data_02_44e5:
; indexed by wD746_Player_ClimbingState - see CLIMB_STATE_* in constants.asm
    dw   .jp_02_44f9_PlayerClimbAction_Background          ; $00 CLIMB_STATE_BACKGROUND
    dw   .jp_02_455f_PlayerClimbAction_BackgroundTailSpin  ; $01 CLIMB_STATE_BACKGROUND_TAIL_SPIN
    dw   .jp_02_45b0_PlayerClimbAction_Wall                ; $02 CLIMB_STATE_WALL
    dw   .jp_02_4626_PlayerClimbAction_WallTailSpin        ; $03 CLIMB_STATE_WALL_TAIL_SPIN
    dw   .jp_02_45b0_PlayerClimbAction_Wall                ; $04 CLIMB_STATE_ALT_WALL - duplicate entry
    dw   .jp_02_4626_PlayerClimbAction_WallTailSpin        ; $05 CLIMB_STATE_ALT_WALL_TAIL_SPIN - duplicate entry
    dw   .jp_02_4667_PlayerClimbAction_BackgroundBottom    ; $06 CLIMB_STATE_BACKGROUND_BOTTOM
    dw   .jp_02_468f_PlayerClimbAction_WallBottom          ; $07 CLIMB_STATE_WALL_BOTTOM
    dw   .jp_02_46b3_PlayerClimbAction_WallTop             ; $08 CLIMB_STATE_WALL_TOP
    dw   .jp_02_46b8_PlayerClimbAction_Stop                ; $09 CLIMB_STATE_STOP

.jp_02_44f9_PlayerClimbAction_Background:
; Gex on a chain-link fence or similar climbable background, free to move in all
; eight directions.
; PlayerBackgroundClimb_GetDirection does the moving and hands back which way he
; went; everything here is presentation. The direction picks his facing and the
; alternate-frame flag out of .data_02_4557_BackgroundClimbSpriteFlagsByDirection and
; a sprite base out of .data_02_454f_BackgroundClimbSpriteBaseByDirection, and the
; climb counter supplies the frame within that set - one step of the animation every
; four frames, cycling through eight. Because the animation block for
; PLAYER_ACTION_CLIMB (data_02_766d) has its frame timer set to $FF the normal
; animation ticker never runs, so writing wD208 here is the only thing drawing him.
; B drops him into a Freefall, A starts a tail spin, and if no direction is held the
; sprite work is skipped entirely so he simply hangs on the frame he was last on
    call call_02_4777_PlayerBackgroundClimb_GetDirection
    cp   A, CLIMB_DIR_NONE
    jr   Z, .jr_02_4531
    ld   [wD748_Player_ClimbDirectionIndex], A
    ld   E, A
    ld   D, $00
    ld   HL, .data_02_4557_BackgroundClimbSpriteFlagsByDirection
    add  HL, DE
    ld   A, [HL]
    and  A, FACING_LEFT
    ld   [wD20D_Player_FacingFlags], A
    ld   A, [HL]
    and  A, CLIMB_FLAG_ALT_FRAMES
    ld   [wD74B_Player_ClimbingFlags], A
    ld   HL, .data_02_454f_BackgroundClimbSpriteBaseByDirection
    add  HL, DE
    ld   C, [HL]
    ld   HL, wD747_Player_ClimbAnimCounter
    inc  [HL]
    ld   A, [HL]
    rrca
    rrca
    and  A, $07
    add  A, C
    ld   HL, wD208_Player_SpriteID
    cp   A, [HL]
    jr   Z, .jr_02_4531
    ld   [HL], A
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX, [HL]
.jr_02_4531:
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_B
    jr   Z, .jr_02_453d
    ld   A, PLAYER_ACTION_FREEFALL
    call call_02_4ccd_Player_RequestAction
.jr_02_453d:
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_A
    jr   Z, .jr_02_454e
    ld   A, CLIMB_STATE_BACKGROUND_TAIL_SPIN
    ld   [wD746_Player_ClimbingState], A
    xor  A, A
    ld   [wD747_Player_ClimbAnimCounter], A
    ret
.jr_02_454e:
    ret
.data_02_454f_BackgroundClimbSpriteBaseByDirection:
; First sprite id of the eight-frame climb loop for each CLIMB_DIR_*. Only four
; distinct sets exist because opposite directions share one - up and down both use
; $40, left and right both use $48, and the two diagonals of each slash share $50
; and $97. The pair below is what tells them apart on screen
    db   $40, $50, $48, $97, $40, $50, $48, $97
.data_02_4557_BackgroundClimbSpriteFlagsByDirection:
; How that shared frame set is oriented, per CLIMB_DIR_*:
;   $20 FACING_LEFT           -> mirrored frame set (bit 5 of wD20D)
;   $40 CLIMB_FLAG_ALT_FRAMES -> the other climb frame set (bit 6 of wD74B)
; CLIMB_DIR_UP through CLIMB_DIR_DOWN_RIGHT take neither and CLIMB_DIR_DOWN through
; CLIMB_DIR_UP_LEFT take both, so each direction and the one opposite it (index XOR
; $04) share a frame set and differ only by the two flips
    db   $00, $00, $00, $00, $60, $60, $60, $60

.jp_02_455f_PlayerClimbAction_BackgroundTailSpin:
; The tail whip performed while hanging on the fence. He still climbs - the same
; direction routine runs - but the per-direction frame sets are dropped for one
; eight-frame rotation at $58-$5F, drawn with no flips at all so the spin reads the
; same whichever way he is heading.
; The direction instead becomes a starting phase, via
; .data_02_45a8_ClimbTailSpinPhaseByDirection, so the whip begins pointing the way
; he is climbing rather than always from the same angle.
; CLIMB_TAIL_SPIN_LENGTH frames later it drops back to CLIMB_STATE_BACKGROUND. There
; is no early exit: releasing A does not end the spin.
; Unlike the plain climb this does not skip its sprite work when no direction is
; held, so the spin keeps turning even standing still on the fence
    call call_02_4777_PlayerBackgroundClimb_GetDirection
    cp   a,CLIMB_DIR_NONE
    jr   z,.jr_02_4569
    ld   [wD748_Player_ClimbDirectionIndex],a
.jr_02_4569:
    ld   hl,wD747_Player_ClimbAnimCounter
    inc  [hl]
    ld   a,[hl]
    rrca
    rrca
    and  a,$07
    ld   c,a
    ld   hl,wD748_Player_ClimbDirectionIndex
    ld   l,[hl]
    ld   h,$00
    ld   de,.data_02_45a8_ClimbTailSpinPhaseByDirection
    add  hl,de
    ld   a,[hl]
    add  c
    and  a,$07
    add  a,CLIMB_TAIL_SPIN_SPRITE_BASE
    ld   hl,wD208_Player_SpriteID
    cp   [hl]
    ret  z
    ld   [hl],a
    ld   a,$00
    ld   [wD20D_Player_FacingFlags],a
    ld   a,$00
    ld   [wD74B_Player_ClimbingFlags],a
    ld   hl,wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX,[hl]
    ld   a,[wD747_Player_ClimbAnimCounter]
    cp   a,CLIMB_TAIL_SPIN_LENGTH
    ret  c
    ld   a,CLIMB_STATE_BACKGROUND
    ld   [wD746_Player_ClimbingState],a
    xor  a
    ld   [wD747_Player_ClimbAnimCounter],a
    ret
.data_02_45a8_ClimbTailSpinPhaseByDirection:
; Starting phase of the eight-frame spin, indexed by CLIMB_DIR_*. Each entry is
; (8 - direction) & 7, so adding it and masking to 3 bits rotates the sequence
; backwards by the direction index - frame 0 of the spin lines up with whichever way
; he is climbing
    db   $00, $07, $06, $05, $04, $03, $02, $01

.jp_02_45b0_PlayerClimbAction_Wall:
; Gex on a sheer wall, where the only choices are up and down. Structurally the same
; as the background climb, with one difference that matters: the three lookups here
; treat $FF as "leave this alone" rather than as a value to store.
; That is doing real work. Both reachable rows of
; .data_02_460e_WallClimbFacingByDirection hold $FF, so climbing a wall never
; rewrites his facing - which is the point, since the wall is on one particular side
; of him and turning him round would put him inside it. Only the alternate-frame
; flag varies, and it is what flips the artwork between climbing up and climbing
; down the same wall.
; B drops him off into a Freefall, A starts the wall tail spin
    call call_02_47d5_PlayerWallClimb_GetDirection
    cp   a,CLIMB_DIR_NONE
    jr   z,.jr_02_45F0
    ld   [wD748_Player_ClimbDirectionIndex],a
    ld   e,a
    ld   d,$00
    ld   hl, .data_02_460e_WallClimbFacingByDirection
    add  hl,de
    ld   a,[hl]
    cp   a,$FF                                         ; $FF = keep the current facing
    jr   z,.jr_02_45C9
    ld   [wD20D_Player_FacingFlags],a
.jr_02_45C9:
    ld   hl, .data_02_4616_WallClimbSpriteFlagsByDirection
    add  hl,de
    ld   a,[hl]
    cp   a,$FF                                         ; $FF = keep the current flags
    jr   z,.jr_02_45D5
    ld   [wD74B_Player_ClimbingFlags],a
.jr_02_45D5:
    ld   hl, .data_02_461e_WallClimbSpriteBaseByDirection
    add  hl,de
    ld   c,[hl]
    ld   hl,wD747_Player_ClimbAnimCounter
    inc  [hl]
    ld   a,[hl]
    rrca
    rrca
    and  a,$07
    add  c
    ld   hl,wD208_Player_SpriteID
    cp   [hl]
    jr   z,.jr_02_45F0
    ld   [hl],a
    ld   hl,wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX,[hl]
.jr_02_45F0:
    ld   a,[wD75A_Player_EffectiveInputs]
    and  a,PADF_B
    jr   z,.jr_02_45FC
    ld   a,PLAYER_ACTION_FREEFALL
    call call_02_4ccd_Player_RequestAction
.jr_02_45FC:
    ld   a,[wD75A_Player_EffectiveInputs]
    and  a,PADF_A
    jr   z,.jr_02_460D
    ld   a,CLIMB_STATE_WALL_TAIL_SPIN
    ld   [wD746_Player_ClimbingState],a
    xor  a
    ld   [wD747_Player_ClimbAnimCounter],a
    ret
.jr_02_460D:
    ret
; The three wall-climb tables are eight entries wide, indexed by CLIMB_DIR_*, but
; call_02_47d5_PlayerWallClimb_GetDirection can only ever return CLIMB_DIR_UP ($00)
; or CLIMB_DIR_DOWN ($04). The other six rows are unreachable, and the shape they
; describe - $68 frames and a FACING_LEFT for the sideways directions - looks like
; the remains of a wall climb that let him move around a corner under player control,
; which the CLIMB_STATE_STOP handler below now does automatically instead

.data_02_460e_WallClimbFacingByDirection:
; $FF means leave wD20D_Player_FacingFlags as it is. Both reachable rows are $FF
    db   $ff, $00, $00, $00, $ff, $20, $20, $20
.data_02_4616_WallClimbSpriteFlagsByDirection:
; wD74B_Player_ClimbingFlags: CLIMB_FLAG_ALT_FRAMES ($40) picks the second climb
; frame set. Climbing up ($00) is unflagged, climbing down ($04) sets it
    db   $00, $00, $00, $40, $40, $40, $00, $00
.data_02_461e_WallClimbSpriteBaseByDirection:
; First sprite id of the eight-frame loop. Both reachable rows are $60, so up and
; down share the artwork and are told apart by the flag above alone
    db   $60, $60, $68, $60, $60, $60, $68, $60

.jp_02_4626_PlayerClimbAction_WallTailSpin:
; The wall counterpart of the background tail spin, and simpler than it: the spin
; frames come out of .data_02_465f_WallTailSpinSpriteBaseByDirection with no phase
; offset, and both reachable directions give the same base, so the whip always turns
; through $70-$77 from the same starting angle.
; It leaves wD20D and wD74B untouched, so he keeps whatever facing and frame set the
; plain wall climb left him with. After CLIMB_TAIL_SPIN_LENGTH frames it returns to
; CLIMB_STATE_WALL
    call call_02_47d5_PlayerWallClimb_GetDirection
    cp   a,CLIMB_DIR_NONE
    jr   z,.jr_02_4630
    ld   [wD748_Player_ClimbDirectionIndex],a
.jr_02_4630:
    ld   hl,wD747_Player_ClimbAnimCounter
    inc  [hl]
    ld   a,[hl]
    rrca
    rrca
    and  a,$07
    ld   hl,wD748_Player_ClimbDirectionIndex
    ld   l,[hl]
    ld   h,$00
    ld   de, .data_02_465f_WallTailSpinSpriteBaseByDirection
    add  hl,de
    add  [hl]
    ld   hl,wD208_Player_SpriteID
    cp   [hl]
    ret  z
    ld   [hl],a
    ld   hl,wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX,[hl]
    ld   a,[wD747_Player_ClimbAnimCounter]
    cp   a,CLIMB_TAIL_SPIN_LENGTH
    ret  c
    ld   a,CLIMB_STATE_WALL
    ld   [wD746_Player_ClimbingState],a
    xor  a
    ld   [wD747_Player_ClimbAnimCounter],a
    ret
.data_02_465f_WallTailSpinSpriteBaseByDirection:
; First of the eight spin frames, indexed by CLIMB_DIR_*. Only rows $00 and $04 are
; reachable and both give WALL_TAIL_SPIN_SPRITE_BASE; the $78 rows belong to the same
; abandoned sideways wall movement as the tables above, and the $00 rows are filler
    db   WALL_TAIL_SPIN_SPRITE_BASE, $00, $78, $00, WALL_TAIL_SPIN_SPRITE_BASE, $00, $78, $00

.jp_02_4667_PlayerClimbAction_BackgroundBottom:
; Gex letting go at the foot of a chain-link fence. Entered by the bank 3 climb
; collision handler, not from here, when he presses down and the square below is not
; climbable - so this is purely the animation of him dropping off, six frames held
; four frames each. He does not move; the counter simply runs out and hands him to
; Stand, at which point normal gravity resumes and sets him on the floor.
; It clears CLIMB_FLAG_ALT_FRAMES every frame so the dismount is always drawn from
; the primary frame set regardless of which way he was climbing
    ld   A, $00
    ld   [wD74B_Player_ClimbingFlags], A
    ld   HL, wD747_Player_ClimbAnimCounter
    ld   A, [HL]
    cp   A, $18
    jr   Z, .jr_02_4684
    inc  [HL]
    srl  A
    srl  A
    ld   L, A
    ld   H, $00
    ld   DE, .data_02_4689_BackgroundDismountSprites
    add  HL, DE
    ld   A, [HL]
    jp   call_02_480f_Player_UpdateSpriteIfChanged
.jr_02_4684:
    ld   A, PLAYER_ACTION_STAND
    jp   call_02_4ccd_Player_RequestAction
.data_02_4689_BackgroundDismountSprites:
; Indexed by wD747_Player_ClimbAnimCounter >> 2. Six entries for a counter that runs
; 0 to $17, so the table is exactly used up as the counter reaches $18
    db   $c2, $c3, $c4, $c5, $c6, $c7

.jp_02_468f_PlayerClimbAction_WallBottom:
; The same thing at the foot of a wall, in a quarter of the frames - two sprites over
; eight frames rather than six over twenty-four. Reaching the bottom of a wall is
; meant to read as him simply letting go, where sliding off a fence gets a proper
; climb-down
    ld   a,$00
    ld   [wD74B_Player_ClimbingFlags],a
    ld   hl,wD747_Player_ClimbAnimCounter
    ld   a,[hl]
    cp   a,$08
    jr   z,.jr_02_46AC
    inc  [hl]
    srl  a
    srl  a
    ld   l,a
    ld   h,$00
    ld   de, .data_02_46b1_WallDismountSprites
    add  hl,de
    ld   a,[hl]
    jp   call_02_480f_Player_UpdateSpriteIfChanged
.jr_02_46AC:
    ld   a,PLAYER_ACTION_STAND
    jp   call_02_4ccd_Player_RequestAction
.data_02_46b1_WallDismountSprites:
; Indexed by wD747_Player_ClimbAnimCounter >> 2, counter running 0 to $07
    db   $c8, $c9

.jp_02_46b3_PlayerClimbAction_WallTop:
; Reaching the top of a wall. There is no pull-up animation - the bank 3 climb
; handler sets this state the frame the surface above him stops being climbable, and
; all it does is request PLAYER_ACTION_JUMP, which both clears the climbing state and
; throws him over the lip in one go
    ld   a,PLAYER_ACTION_JUMP
    jp   call_02_4ccd_Player_RequestAction

.jp_02_46b8_PlayerClimbAction_Stop:
; Gex working his way round a corner of a climbable surface. Bank 3's climb handler
; puts him in this state when the tile he is holding onto is one of the four
; TILE_TYPE_CLIMB_STOP_ENTRY_* stoppers, and stores tile id minus $30 in
; wD749_Player_ClimbingDirection - so the level designer picks which corner it is by
; choosing which of the four tiles to place.
; From then until the transition completes this handler owns him entirely: bank 3
; leaves any climb state of CLIMB_STATE_BACKGROUND_BOTTOM or above alone, and no
; input is read here at all.
;
; Each step nudges him one pixel diagonally out of
; .data_02_4737_ClimbStopStepDeltas, advances the sprite through
; .data_02_472e_ClimbStopSprites, and on the seventeenth step reads a four-byte row
; from .data_02_4757_ClimbStopExitState that drops him back into a normal wall climb
; on the new face. Direction and facing together choose the row, which is what makes
; one stopper tile work for a climber arriving from either side.
;
; Only directions $02 and $03 have real rows. Directions $00 and $01 - tiles $30 and
; $31 - are all zeroes, which would leave him motionless for the whole transition and
; then hand him CLIMB_STATE_BACKGROUND with sprite $00, so those two tiles look
; unfinished rather than merely unused.
;
; The pacing is the odd part. The gate below only lets a step through on one frame in
; 32, so seventeen steps take 544 gameplay frames - about nine seconds of Gex sliding
; a pixel at a time with no way to interrupt. Every comparable animation in this file
; runs on the raw frame counter. `and $01` would give a 34-frame corner turn, which
; is what the nine-frame sprite list is drawn for, and $01 differs from $1F by one
; bit - so this reads as a mistyped mask rather than a design decision. Not something
; the disassembly can settle either way; the code is as written
    ld   a,[wD73C_GameplayFrameCounter]
    and  a,$1F                                         ; one step per 32 frames - see above
    ret  nz
    ld   a,[wD749_Player_ClimbingDirection]
    add  a
    add  a
    ld   hl,wD20D_Player_FacingFlags
    bit  FACING_LEFT_BIT,[hl]
    jr   z,.jr_02_46CC
    add  a,$02
.jr_02_46CC:
    add  a                                             ; (direction * 2 + facing) * 4
    ld   l,a
    ld   h,$00
    ld   de, .data_02_4737_ClimbStopStepDeltas
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]                                        ; BC = X delta
    inc  hl
    push bc
    ld   c,[hl]
    inc  hl
    ld   b,[hl]                                        ; BC = Y delta
    call call_02_4c19_Player_AddToYPosition
    pop  bc
    call call_02_4c0a_Player_AddToXPosition
    ld   a,[wD747_Player_ClimbAnimCounter]
    srl  a
    ld   l,a
    ld   h,$00
    ld   de, .data_02_472e_ClimbStopSprites
    add  hl,de
    ld   a,[hl]
    call call_02_480f_Player_UpdateSpriteIfChanged
    ld   a,$00
    ld   [wD74B_Player_ClimbingFlags],a
    ld   hl,wD747_Player_ClimbAnimCounter
    inc  [hl]
    ld   a,[hl]
    cp   a,$11                                         ; seventeen steps and it is done
    ret  nz
    ld   [hl],$00
    ld   a,[wD749_Player_ClimbingDirection]
    add  a
    add  a
    add  a
    ld   hl,wD20D_Player_FacingFlags
    bit  FACING_LEFT_BIT,[hl]
    jr   z,.jr_02_4711
    add  a,$04                                         ; (direction * 2 + facing) * 4
.jr_02_4711:
    ld   l,a
    ld   h,$00
    ld   de, .data_02_4757_ClimbStopExitState
    add  hl,de
    ldi  a,[hl]
    ld   [wD746_Player_ClimbingState],a
    ldi  a,[hl]
    ld   [wD20D_Player_FacingFlags],a
    ldi  a,[hl]
    ld   [wD74B_Player_ClimbingFlags],a
    ldi  a,[hl]
    ld   [wD208_Player_SpriteID],a
    ld   hl,wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX,[hl]
    ret
.data_02_472e_ClimbStopSprites:
; Indexed by wD747_Player_ClimbAnimCounter >> 1, so each of the nine entries is held
; for two steps of the transition. The last is repeated to cover the odd
; seventeenth step; the first, $08, is a normal standing frame rather than one of
; the $CA-$D0 corner frames, so the turn starts from an upright pose
    db   $08, $ca, $cb, $cc, $cd, $ce, $cf, $d0, $d0

.data_02_4737_ClimbStopStepDeltas:
; Eight four-byte rows - signed 16-bit X delta then signed 16-bit Y delta - indexed
; by (wD749_Player_ClimbingDirection * 2 + facing left) * 4. Applied once per step,
; seventeen times, so the row is also the overall direction he travels.
;
; The four rows for directions $00 and $01 are all zeroes; the four live ones are the
; four diagonals, chosen so that whichever corner he met and whichever way he was
; facing, he ends up on the adjacent face of it
    db   $00, $00, $00, $00        ; dir $00, facing right - no movement
    db   $00, $00, $00, $00        ; dir $00, facing left  - no movement
    db   $00, $00, $00, $00        ; dir $01, facing right - no movement
    db   $00, $00, $00, $00        ; dir $01, facing left  - no movement
    db   $01, $00, $01, $00        ; dir $02, facing right - down and right
    db   $ff, $ff, $ff, $ff        ; dir $02, facing left  - up and left
    db   $01, $00, $ff, $ff        ; dir $03, facing right - up and right
    db   $ff, $ff, $01, $00        ; dir $03, facing left  - down and left

.data_02_4757_ClimbStopExitState:
; The state to land in once the seventeen steps are done, same eight-row indexing as
; the deltas above: new wD746_Player_ClimbingState, new wD20D_Player_FacingFlags, new
; wD74B_Player_ClimbingFlags, new wD208_Player_SpriteID.
;
; Every live row hands him to a wall climb - CLIMB_STATE_WALL or its alias
; CLIMB_STATE_ALT_WALL, which share a handler - with the alternate-frame flag cleared
; and a sprite seeded so he is not left mid-corner for a frame.
; Two details give away that this once meant more than it does now. The $68 seeds
; belong to the sideways wall frames that .data_02_461e_WallClimbSpriteBaseByDirection
; can no longer reach, so the wall handler replaces them with $60 the first frame a
; direction is held; and the $02/$04 split is the only lasting trace of which corner
; he came round, which the handler then ignores
    db   $00, $00, $00, $00                                     ; dir $00, right - unfinished
    db   $00, $00, $00, $00                                     ; dir $00, left  - unfinished
    db   $00, $00, $00, $00                                     ; dir $01, right - unfinished
    db   $00, $00, $00, $00                                     ; dir $01, left  - unfinished
    db   CLIMB_STATE_ALT_WALL, FACING_RIGHT, $00, $68           ; dir $02, right
    db   CLIMB_STATE_WALL,     FACING_RIGHT, $00, $60           ; dir $02, left
    db   CLIMB_STATE_WALL,     FACING_LEFT,  $00, $60           ; dir $03, right
    db   CLIMB_STATE_ALT_WALL, FACING_LEFT,  $00, $68           ; dir $03, left

call_02_4777_PlayerBackgroundClimb_GetDirection:
; Moves Gex one pixel along the chain-link and reports which way he went. It reads
; the whole d-pad at once and looks the byte up in
; .data_02_47a5_BackgroundClimbDirectionTable, so diagonals are their own entries
; rather than a combination - which is why the search is an exact `cp`, not a mask
; test, and why pressing three directions at once matches nothing and he stays put.
; A match applies that row's X and Y deltas straight to his world position;
; returns the row's CLIMB_DIR_* index in A, or CLIMB_DIR_NONE if nothing matched.
;
; The bg_collision climb handler in bank 3 has already stripped any direction that
; would take him off the climbable surface out of wD75A, so the deltas here can be
; applied unconditionally - no bounds test of its own
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_RIGHT | PADF_LEFT | PADF_UP | PADF_DOWN
    jr   Z, .jr_02_478d
    ld   HL, .data_02_47a5_BackgroundClimbDirectionTable
    ld   DE, CLIMB_DIR_RECORD_SIZE
    ld   B, $08                                        ; all eight rows
.jr_02_4786:
    cp   A, [HL]
    jr   Z, .jr_02_4790
    add  HL, DE
    dec  B
    jr   NZ, .jr_02_4786
.jr_02_478d:
    ld   A, CLIMB_DIR_NONE
    ret
.jr_02_4790:
    inc  HL
    ld   A, [HL+]                                      ; direction index
    push AF                                            ; held for the return value
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   B, A                                          ; BC = X delta
    push BC
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   B, A                                          ; BC = Y delta
    call call_02_4c19_Player_AddToYPosition
    pop  BC
    call call_02_4c0a_Player_AddToXPosition
    pop  AF
    ret
.data_02_47a5_BackgroundClimbDirectionTable:
; Eight CLIMB_DIR_RECORD_SIZE-byte rows, searched by exact match on the d-pad byte:
;   +0      the d-pad byte this row answers to
;   +1      the CLIMB_DIR_* index it means
;   +2, +3  signed 16-bit X delta to apply
;   +4, +5  signed 16-bit Y delta to apply
; Every row moves exactly one pixel, so a diagonal covers 1 px on each axis and is
; the faster way up a chain-link fence
    db   PADF_UP,                CLIMB_DIR_UP,         $00, $00, $ff, $ff
    db   PADF_DOWN,              CLIMB_DIR_DOWN,       $00, $00, $01, $00
    db   PADF_LEFT,              CLIMB_DIR_LEFT,       $ff, $ff, $00, $00
    db   PADF_RIGHT,             CLIMB_DIR_RIGHT,      $01, $00, $00, $00
    db   PADF_UP | PADF_LEFT,    CLIMB_DIR_UP_LEFT,    $ff, $ff, $ff, $ff
    db   PADF_DOWN | PADF_LEFT,  CLIMB_DIR_DOWN_LEFT,  $ff, $ff, $01, $00
    db   PADF_UP | PADF_RIGHT,   CLIMB_DIR_UP_RIGHT,   $01, $00, $ff, $ff
    db   PADF_DOWN | PADF_RIGHT, CLIMB_DIR_DOWN_RIGHT, $01, $00, $01, $00

call_02_47d5_PlayerWallClimb_GetDirection:
; The wall version of the routine above, in the same record format, but a wall gives
; him nowhere to go sideways so the mask is Up/Down only and the table is two rows.
; Note the mask drops left and right before the search, so pressing up and right
; together still matches the plain-up row - on a wall a diagonal is just its
; vertical part, where on the chain-link it is a direction of its own
    ld   a,[wD75A_Player_EffectiveInputs]
    and  a,PADF_UP | PADF_DOWN
    jr   z,.jr_02_47EB
    ld   hl, .data_02_4803_WallClimbDirectionTable
    ld   de,CLIMB_DIR_RECORD_SIZE
    ld   b,$02
.jr_02_47E4:
    cp   [hl]
    jr   z,.jr_02_47EE
    add  hl,de
    dec  b
    jr   nz,.jr_02_47E4
.jr_02_47EB:
    ld   a,CLIMB_DIR_NONE
    ret
.jr_02_47EE:
    inc  hl
    ldi  a,[hl]
    push af
    ldi  a,[hl]
    ld   c,a
    ldi  a,[hl]
    ld   b,a
    push bc
    ldi  a,[hl]
    ld   c,a
    ldi  a,[hl]
    ld   b,a
    call call_02_4c19_Player_AddToYPosition
    pop  bc
    call call_02_4c0a_Player_AddToXPosition
    pop  af
    ret
.data_02_4803_WallClimbDirectionTable:
; Same row format as .data_02_47a5_BackgroundClimbDirectionTable, and the same two
; rows out of it - so a wall climb is one pixel per frame, exactly like the fence
    db   PADF_UP,   CLIMB_DIR_UP,   $00, $00, $ff, $ff
    db   PADF_DOWN, CLIMB_DIR_DOWN, $00, $00, $01, $00

call_02_480f_Player_UpdateSpriteIfChanged:
; Writes A to wD208_Player_SpriteID and raises GFX_XFER_PLAYER_GFX, but only if the
; sprite actually changed - Gex's frames are streamed into VRAM one at a time, so
; requesting the transfer every frame would waste the hblank budget on a redraw of
; the frame already there. The climb handlers each open-code this same test inline;
; only the three dismount states call the shared copy
    ld   HL, wD208_Player_SpriteID
    cp   A, [HL]
    ret  Z
    ld   [HL], A
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX, [HL]
    ret

call_02_481b_PlayerAction_GoldRemoteWarp:
; Requested by the entity collision handler in bank 3 the moment Gex touches the
; gold remote. It runs the celebration animation (data_02_7673, the spawn frames
; played backwards) and raises WARP_ENTERED_TV when that finishes, so collecting the
; gold remote pulls him out of the level exactly as a television would.
; Unusually for a warp action, its transition flags row is $00 - see
; .data_02_4cf5_ActionTransitionFlagsTable - so this one is NOT locked and a death
; on the same frame can still override it
    call call_02_4894_Player_CheckWarpReady
    ret  z
    ld   a,[wD621_WarpFlags]
    or   a,WARP_ENTERED_TV
    ld   [wD621_WarpFlags],a
    ret

call_02_4828_PlayerAction_RidingRocket:
; Gex clinging to the Toon TV rocket. Rather than give him a velocity, this pins his
; Y to the rocket's every frame: it walks slots 1-7 looking for ENTITY_TOON_TV_ROCKET
; and copies that entity's ENTITY_FIELD_WORLD_Y straight into wD210/wD211. X is left
; alone but his speed is zeroed, and bank 3 skips background collision entirely for
; this action, so the rocket can carry him through geometry.
; If the rocket is gone the loop falls out at the slot-7 wrap and the action does
; nothing, which leaves Gex frozen where he was.
; The ride ends by height, not by time: shifting Y left three places puts Y >> 5 in
; H, so `cp $55` is the test "has he climbed above world Y $0AA0 yet". Once he has,
; the action becomes a plain jump and normal physics take over again
    xor  a
    ld   [wD75E_PlayerXSpeed],a
    ld   h,HIGH(wD220_OtherLoadedEntities)
    ld   a,$20
.jr_02_4830:
    ld   l,a
    ld   a,[hl]
    cp   a,ENTITY_TOON_TV_ROCKET
    jr   z,.jr_02_483C
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_4830                                ; wrapped past slot 7 - no rocket
    ret
.jr_02_483C:
    ld   a,l
    or   a,ENTITY_FIELD_WORLD_Y
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    ld   [wD210_Player_YPositionLo],a
    ld   a,h
    ld   [wD211_Player_YPositionHi],a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   a,$55
    ret  nc
    ld   a,PLAYER_ACTION_JUMP
    jp   call_02_4ccd_Player_RequestAction
