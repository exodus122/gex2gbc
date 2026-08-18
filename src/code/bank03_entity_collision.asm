; ==================================================================
; ENTITY COLLISION
;
; Gex against everything else - enemies, remotes, platforms, tv buttons.
; Entity-against-entity collision does not exist; only the player is ever
; tested, which is why every routine here talks about "the player" implicitly.
;
; Two levels of dispatch:
;
;   COLLISION_TYPE (entity field $16) picks a handler out of
;   .data_03_4c9b_EntityCollisionJumpTable. This is a property of the entity
;   *instance*, so the same entity type can behave differently per level
;
;   ENTITY_INTERACT_* flags (.data_03_522e_EntityInteractionFlagsTable, keyed
;   by entity type) say which kinds of contact are possible at all
;
; Almost every handler opens with call_03_519b_Entity_CheckPlayerInteraction,
; which does the box test once and reports back not just "did we touch" but
; *how*: 0 touch, 1 attack, 2 stomp. The handler then switches on that. Reading
; a handler is mostly a matter of reading its three cases.
;
; Platforms are the exception - they do not use the shared test at all, because
; they care about which side Gex approached from and how fast. They live at the
; bottom of the file and write wD74D_Player_EntityStoodOnLo /
; wD74E_Player_PushedStationaryPlatformLo / wD74F_Player_PushedMovingPlatformLo,
; which is what makes Entities_UpdateAll run them before Gex the next frame.
;
; Note that collision runs from inside the sprite builder, not from the update
; loop - Entity_BuildSprites tail-calls EntityCollision_Dispatch. An entity
; that is not drawn is therefore never tested, which is the cheap way this game
; culls offscreen collision.
; ==================================================================

call_03_4c76_EntityCollision_Dispatch:
; Entry point for all entity–player collision. Returns immediately if Gex isn't drawn (wD743=0) or
; if the entity's SPRITE_FLAG_ON_SCREEN is clear (offscreen entities cannot be touched). Otherwise reads the collision type
; from the entity's data, indexes into .data_03_4c9b_EntityCollisionJumpTable, and jumps to the appropriate handler
    ld   A, [wD743_Player_UpdateFlag]
    and  A, A
    ret  Z                                             ; return if [D743] is 0
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    bit  SPRITE_FLAG_ON_SCREEN_BIT, [HL]
    ret  Z
    xor  A, $1e
    ld   L, A
    ld   E, [HL]
    inc  L
    ld   D, [HL]
    inc  L
    ld   L, [HL]
    res  7, L
    ld   H, $00
    add  HL, HL
    ld   BC, .data_03_4c9b_EntityCollisionJumpTable
    add  HL, BC
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    jp   HL
.data_03_4c9b_EntityCollisionJumpTable:
; 37-entry pointer table, one handler address per collision type
    dw   .jr_03_4ce5_CollisionHandler_None ; COLLISION_TYPE_NONE
    dw   .jr_03_4ce6_CollisionHandler_Collectible ; COLLISION_TYPE_COLLECTIBLE
    dw   .jr_03_4d33_CollisionHandler_ExtraLife ; COLLISION_TYPE_EXTRA_LIFE
    dw   call_03_52c5_CollisionHandler_StationaryPlatform ; COLLISION_TYPE_STATIONARY_PLATFORM
    dw   call_03_536f_CollisionHandler_MovingPlatform ; COLLISION_TYPE_MOVING_PLATFORM
    dw   call_03_5304_CollisionHandler_OneWayPlatform ; COLLISION_TYPE_ONE_WAY_PLATFORM
    dw   .jr_03_4dbc_CollisionHandler_GenericEnemy ; COLLISION_TYPE_GENERIC_ENEMY
    dw   .jr_03_4d3f_CollisionHandler_SilverRemote ; COLLISION_TYPE_SILVER_REMOTE
    dw   .jr_03_4d56_CollisionHandler_GoldRemote ; COLLISION_TYPE_GOLD_REMOTE
    dw   .jr_03_4d82_CollisionHandler_TouchDamage ; COLLISION_TYPE_TOUCH_DAMAGE
    dw   .jr_03_4d8c_CollisionHandler_Lantern ; COLLISION_TYPE_LANTERN
    dw   .jr_03_4d9a_CollisionHandler_Zombie ; COLLISION_TYPE_ZOMBIE
    dw   .jr_03_4dc8_CollisionHandler_GhostHead ; COLLISION_TYPE_GHOST_HEAD
    dw   .jr_03_4dd4_CollisionHandler_Ghost ; COLLISION_TYPE_GHOST
    dw   .jr_03_4df4_CollisionHandler_ZombieHead ; COLLISION_TYPE_ZOMBIE_HEAD
    dw   .jr_03_4e20_CollisionHandler_FallingHazard ; COLLISION_TYPE_FALLING_HAZARD
    dw   .jr_03_4e7f_CollisionHandler_Hunter ; COLLISION_TYPE_HUNTER
    dw   .jr_03_4eb4_CollisionHandler_Mushroom ; COLLISION_TYPE_MUSHROOM
    dw   .jr_03_4ec6_CollisionHandler_None2 ; COLLISION_TYPE_NONE_2
    dw   .jr_03_4ec7_CollisionHandler_MultiProjectile ; COLLISION_TYPE_MULTI_PROJECTILE
    dw   .jr_03_4f14_CollisionHandler_Jar ; COLLISION_TYPE_JAR
    dw   .jr_03_4f20_CollisionHandler_Ninja ; COLLISION_TYPE_NINJA
    dw   .jr_03_4fc7_CollisionHandler_HangingBlade ; COLLISION_TYPE_HANGING_BLADE
    dw   .jr_03_4fcf_CollisionHandler_LaunchPad ; COLLISION_TYPE_LAUNCH_PAD
    dw   .jr_03_4fd9_CollisionHandler_SamuraiBody ; COLLISION_TYPE_SAMURAI_BODY
    dw   .jr_03_5035_CollisionHandler_SamuraiHead ; COLLISION_TYPE_SAMURAI_HEAD
    dw   .jr_03_5049_CollisionHandler_Geyser ; COLLISION_TYPE_GEYSER
    dw   .jr_03_505d_CollisionHandler_Triceratops ; COLLISION_TYPE_TRICERATOPS
    dw   .jr_03_50ac_CollisionHandler_Gear ; COLLISION_TYPE_GEAR
    dw   .jr_03_50c5_CollisionHandler_ElectricBall ; COLLISION_TYPE_ELECTRIC_BALL
    dw   .jr_03_50d6_CollisionHandler_GunProjectile ; COLLISION_TYPE_GUN_PROJECTILE
    dw   .jr_03_50e7_CollisionHandler_Rocket ; COLLISION_TYPE_ROCKET
    dw   .jr_03_5109_CollisionHandler_Cannon ; COLLISION_TYPE_CANNON
    dw   .jr_03_5129_CollisionHandler_PoweredWalkway ; COLLISION_TYPE_POWERED_WALKWAY
    dw   .jr_03_514e_CollisionHandler_PowerUp ; COLLISION_TYPE_POWER_UP
    dw   .jr_03_5163_CollisionHandler_DragonProjectile ; COLLISION_TYPE_DRAGON_PROJECTILE
    dw   .jr_03_516d_CollisionHandler_Rez ; COLLISION_TYPE_REZ
.jr_03_4ce5_CollisionHandler_None:
    ret        	
.jr_03_4ce6_CollisionHandler_Collectible:
; Checks overlap; if hit, iterates up to 8 sub-hitbox records from the secondary data pointer.
; Each record has a bit-7 active flag, Y offset, and X offset; checks if player screen position
; falls within an 8×16-pixel window around each sub-hitbox. On match, clears the record's active
; bit and calls call_00_06ec_Player_ObtainedCollectible (collect item/score)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  NC
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ld   C, [HL]
    inc  L
    ld   B, [HL]
    call call_00_39f5_Entity_GetParticlesPtr
    ld   L, E
    ld   H, D
    ld   A, $08
.jr_03_4cfc:
    push AF
    push BC
    push HL
    ld   A, [HL+]
    bit  7, A
    jr   Z, .jr_03_4d20
    inc  HL
    ld   A, [HL+]
    add  A, B
    ld   B, A
    ld   A, [wD213_Player_ScreenYPosition]
    sub  A, B
    add  A, $08
    cp   A, $10
    jr   NC, .jr_03_4d20
    inc  HL
    ld   A, [HL+]
    add  A, C
    ld   C, A
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, C
    add  A, $04
    cp   A, $08
    jr   C, .jr_03_4d2b
.jr_03_4d20:
    pop  HL
    ld   BC, $05
    add  HL, BC
    pop  BC
    pop  AF
    dec  A
    jr   NZ, .jr_03_4cfc
    ret
.jr_03_4d2b:
    pop  HL
    res  7, [HL]
    pop  BC
    pop  AF
    jp   call_00_06ec_Player_ObtainedCollectible
.jr_03_4d33_CollisionHandler_ExtraLife:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    call call_00_3931_Entity_DeactivateSelf
    ld   a,$04
    jp   call_00_0647_Player_SetUpOrEatFlyPowerup
.jr_03_4d3f_CollisionHandler_SilverRemote:
; Overlap check; sets bit 4 of wD64C_CurrentLevel_HiddenRemoteFlags (silver remote collected
; flag), plays SFX_SILVER_REMOTE, frees the entity slot, then marks the list entry
; ENTITY_LIST_FLAG_NEVER_AGAIN so the remote does not come back if you walk away and return
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   a,[wD64C_CurrentLevel_HiddenRemoteFlags]
    or   a,$10
    ld   [wD64C_CurrentLevel_HiddenRemoteFlags],a
    ld   c,SFX_SILVER_REMOTE
    call call_00_112f_QueueSFX
    call call_00_3931_Entity_DeactivateSelf
    jp   call_00_393c_Entity_MarkNeverRespawn
.jr_03_4d56_CollisionHandler_GoldRemote:
; Guards against double-collection (checks wD621_WarpFlags bit 4). On overlap, sets bit 5 in the
; level's wD629 remote progress flag byte, frees the entity slot, marks the list entry
; ENTITY_LIST_FLAG_NEVER_AGAIN, then requests PLAYER_ACTION_GOLD_REMOTE_WARP on the player
    ld   a,[wD621_WarpFlags]
    and  a,$10
    ret  nz
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD624_CurrentLevelId
    ld   l,[hl]
    ld   h,$00
    ld   de,wD629_RemoteProgressFlags
    add  hl,de
    ld   a,[hl]
    or   a,$20
    ld   [hl],a
    call call_00_3931_Entity_DeactivateSelf
    call call_00_393c_Entity_MarkNeverRespawn
    ld   a,PLAYER_ACTION_GOLD_REMOTE_WARP
    FARCALL call_02_4ccd_Player_RequestAction
    ret
.jr_03_4d82_CollisionHandler_TouchDamage:
; Overlap check; A=$00 → damage player; otherwise no effect (hazard that can be survived by attacking)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    call z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ret
.jr_03_4d8c_CollisionHandler_Lantern:
; Sets wD757=1 before the overlap check (enabling lantern-light mode for the ghost handler),
; clears it back to 0 on hit — essentially a "player is standing near a lit lantern" proximity flag toggle
    ld   a,$01
    ld   [wD757_LanternLitFlag],a
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    xor  a
    ld   [wD757_LanternLitFlag],a
    ret
.jr_03_4d9a_CollisionHandler_Zombie:
; Touch → damage player. On attack/stomp: checks MISC_FLAGS bit 0 (already hit flag);
; if not set, sets it, loads a $3C countdown into MISC_TIMER, and decrements a counter —
; the zombie has a stagger/death delay before fully dying
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jr   nz,.jr_03_4DA5
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_4DA5:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    ret  nz
    set  MISC_FLAGS_BIT_0,[hl]
    inc  l
    ld   [hl],$3C
    inc  l
    inc  l
    ld   a,[hl]
    and  a
    ret  z
    dec  [hl]
    ret
.jr_03_4dbc_CollisionHandler_GenericEnemy:
; Overlap check;
; A=$00 (touch) → damage player;
; A=$01 or $02 (attack/stomp) → spawn defeat particle via Entity_SpawnProjectileInit
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  NC
    cp   A, $00
    jp   Z, call_03_52be_Entity_DamagePlayerIfVulnerable
    jp   call_00_3985_Entity_ParticleBurstInit
.jr_03_4dc8_CollisionHandler_GhostHead:
; Touch → damage player; attack/stomp → also kills entity (ghost head has no "survive attack" behavior)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    call z,call_03_52be_Entity_DamagePlayerIfVulnerable
    jp   call_00_3931_Entity_DeactivateSelf
.jr_03_4dd4_CollisionHandler_Ghost:
; Checks wD757_LanternLitFlag (lantern light flag): if zero, touch → damage;
; attack/stomp → sets bit 0 of entity's D2xx slot (signals the ghost entity it was lit).
; If lantern is on, attack/stomp sets the D2xx hit flag directly without damage
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD757_LanternLitFlag
    inc  [hl]
    dec  [hl]
    jr   z,.jr_03_4DE5
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ret
.jr_03_4DE5:
    cp   a,$01
    jp   nz,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   l
    ld   l,a
    set  0,[hl]
    ret
.jr_03_4df4_CollisionHandler_ZombieHead:
; Touch → damage player. Attack/stomp: scans all slots for an active Zombie (ID=$12);
; if found, spawns a particle on it via Entity_SpawnProjectileInit. Then kills this head entity
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   a,[wD300_CurrentEntityAddrLo]
    push af
    ld   h,$D2
    ld   a,$20
.jr_03_4E05:
    ld   l,a
    ld   a,[hl]
    cp   a,$12
    jr   z,.jr_03_4E12
    ld   a,l
    add  a,$20
    jr   nz,.jr_03_4E05
    jr   .jr_03_4E19
.jr_03_4E12:
    ld   a,l
    ld   [wD300_CurrentEntityAddrLo],a
    call call_00_3985_Entity_ParticleBurstInit
.jr_03_4E19:
    pop  af
    ld   [wD300_CurrentEntityAddrLo],a
    jp   call_00_3931_Entity_DeactivateSelf
.jr_03_4e20_CollisionHandler_FallingHazard:
; Only active when Y velocity is negative (entity is moving downward; bit 7 set).
; Computes horizontal overlap against entity width E. If in range, computes vertical overlap
; using the entity's action data pointer + height + $10 offset; checks against wD211/wD210 (world Y).
; If all checks pass and player is vulnerable, damages and sets wD750_Player_DamageCooldownTimer=$77 then triggers
; player action $19 (crushed animation)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    bit  7, [HL]
    ret  Z
    xor  A, $10
    ld   L, A
    ld   A, [wD20E_Player_XPositionLo]
    sub  A, [HL]
    ld   C, A
    inc  HL
    ld   A, [wD20F_Player_XPositionHi]
    sbc  A, [HL]
    ld   B, A
    ld   A, C
    add  A, E
    ld   C, A
    ld   A, B
    adc  A, $00
    ld   B, A
    sla  E
    ld   A, C
    sub  A, E
    ld   A, B
    sbc  A, $00
    ret  NC
    inc  L
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   E, D
    ld   D, $00
    add  HL, DE
    ld   DE, $10
    add  HL, DE
    ld   A, [wD210_Player_YPositionLo]
    sub  A, L
    ld   L, A
    ld   A, [wD211_Player_YPositionHi]
    sbc  A, H
    ret  NC
    cp   A, $ff
    ret  NZ
    ld   A, L
    cp   A, $f4
    ret  C
    call call_00_075b_Player_CanBeDamaged
    ret  NZ
    call call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   A, $77
    ld   [wD750_Player_DamageCooldownTimer], A
    ld   A, PLAYER_ACTION_COLLAPSE
    FARCALL call_02_4ccd_Player_RequestAction
    ret
.jr_03_4e7f_CollisionHandler_Hunter:
; Checks MISC_FLAGS bit 0 first (already shooting, skip). Touch → damage player.
; Attack/stomp: decrements MISC_TIMER timer; if not zero, sets the "shooting" bit and returns.
; When timer hits zero, spawns a projectile, increments wD773_HuntersDefeatedCount (hunter shot count),
; and if count reaches 2 sets wD799_BlockPatch_SlotTable14=$02 (likely triggers a level flag)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    ret  nz
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    call call_00_3817_Entity_DecrementMiscTimer
    jr   z,.jr_03_4EA3
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_4EA3:
    call call_00_3985_Entity_ParticleBurstInit
    ld   hl,wD773_HuntersDefeatedCount
    inc  [hl]
    ld   a,[hl]
    cp   a,$02
    ret  nz
    ld   hl,wD799_BlockPatch_SlotTable14
    ld   [hl],$02
    ret
.jr_03_4eb4_CollisionHandler_Mushroom:
; Overlap check; touch → no effect (returns Z).
; Attack/stomp → sets MISC_FLAGS bit 0 (marks mushroom as pressed/activated)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_4ec6_CollisionHandler_None2:
    ret
.jr_03_4ec7_CollisionHandler_MultiProjectile:
; Like the collectible handler, iterates 8 sub-hitboxes from the secondary data pointer.
; For each active record, checks a 12×8-pixel window at screen position;
; on hit, damages player directly (no death check bypass)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ldi  a,[hl]
    add  a,$04
    ld   c,a
    ld   a,[hl]
    add  a,$08
    ld   b,a
    call call_00_39f5_Entity_GetParticlesPtr
    ld   l,e
    ld   h,d
    ld   a,$08
.jr_03_4EDE:
    push af
    push bc
    push hl
    ldi  a,[hl]
    bit  0,a
    jr   z,.jr_03_4F03
    inc  hl
    ld   a,b
    sub  [hl]
    inc  hl
    ld   b,a
    ld   a,[wD213_Player_ScreenYPosition]
    sub  b
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_4F03
    inc  hl
    ldi  a,[hl]
    add  c
    ld   c,a
    ld   a,[wD212_Player_ScreenXPosition]
    sub  c
    add  a,$04
    cp   a,$08
    jr   c,.jr_03_4F0E
.jr_03_4F03:
    pop  hl
    ld   bc,$0005
    add  hl,bc
    pop  bc
    pop  af
    dec  a
    jr   nz,.jr_03_4EDE
    ret
.jr_03_4F0E:
    pop  hl
    pop  bc
    pop  af
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_4f14_CollisionHandler_Jar:
; Overlap check; only reacts to A=$01 (attack, not stomp);
; calls Entity_SetMiscTimer with C=1 — arms a break timer on the jar
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$01
    ret  nz
    ld   c,$01
    jp   call_00_3802_Entity_SetMiscTimer
.jr_03_4f20_CollisionHandler_Ninja:
; Two-phase handler. First checks if the ninja's sword hitbox (derived from action ID, frame counter,
; and screen position adjusted for facing) overlaps the player — if so, damages directly without going
; through standard overlap. Otherwise falls through to standard overlap: touch → damage;
; attack/stomp → checks TIMER_2 parry counter; if >0 decrements and returns; if 0,
; checks a hardcoded level/slot table (.data_03_4fbd) for a special unlock flag to set, then spawns defeat particle
    push de
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,$1F
    cp   a,$00
    jr   z,.jr_03_4F6F
    cp   a,$02
    jr   z,.jr_03_4F6F
    cp   a,$03
    jr   z,.jr_03_4F43
    push hl
    ld   a,l
    xor  a,$06
    ld   l,a
    ld   a,[hl]
    pop  hl
    cp   a,$02
    jr   c,.jr_03_4F6F
.jr_03_4F43:
    ld   a,l
    xor  a,$13
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   c,[hl]
    xor  a,$1F
    ld   l,a
    ld   a,e
    add  a,$10
    bit  5,[hl]
    jr   z,.jr_03_4F56
    sub  a,$20
.jr_03_4F56:
    ld   e,a
    ld   a,[wD213_Player_ScreenYPosition]
    sub  c
    add  a,$10
    cp   a,$20
    jr   nc,.jr_03_4F6F
    ld   a,[wD212_Player_ScreenXPosition]
    sub  e
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_4F6F
    pop  de
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_4F6F:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[hl]
    and  a
    jr   z,.jr_03_4F87
    dec  [hl]
    ret
.jr_03_4F87:
    ld   a,[wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    ld   e,a
    ld   d,$00
    ld   hl,wD301_EntityListIndexesForCurrentEntities
    add  hl,de
    ld   c,[hl]
    ld   hl,.data_03_4fbd
    ld   de,$0003
.jr_03_4F9B:
    ld   a,[wD624_CurrentLevelId]
    cp   [hl]
    jr   nz,.jr_03_4FA7
    inc  hl
    ld   a,c
    cp   [hl]
    jr   z,.jr_03_4FB0
    dec  hl
.jr_03_4FA7:
    add  hl,de
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_03_4F9B
    jp   call_00_3985_Entity_ParticleBurstInit
.jr_03_4FB0:
    inc  hl
    ld   l,[hl]
    ld   h,$00
    ld   de,wD78B_BlockPatch_SlotTable
    add  hl,de
    ld   [hl],$02
    jp   call_00_3985_Entity_ParticleBurstInit
.data_03_4fbd:
    db   $0d, $07, $08, $05, $05, $00, $05, $06
    db   $08, $ff
.jr_03_4fc7_CollisionHandler_HangingBlade:
; Chains: first runs the FallingHazard handler, then unconditionally runs the touch damage handler
    push de
    call .jr_03_4e20_CollisionHandler_FallingHazard
    pop  de
    jp   .jr_03_4d82_CollisionHandler_TouchDamage
.jr_03_4fcf_CollisionHandler_LaunchPad:
; Does nothing except overwrite the jump velocity, with the largest value in the game -
; compare PLAYER_JUMP_VELOCITY $2A, the geyser's $50. No damage and no state change, so
; touching this just throws Gex upward the next time he leaves the ground
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   a,PLAYER_LAUNCH_PAD_VELOCITY
    ld   [wD758_JumpVelocityOverride],a
    ret
.jr_03_4fd9_CollisionHandler_SamuraiBody:
; Nearly identical to Ninja: if action is $01 (attacking) and frame is ≥2, checks sword hitbox overlap
; directly → damages player. Otherwise standard overlap: touch → damage; stomp/attack → sets MISC_FLAGS bit 0
    push de
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,$1F
    cp   a,$01
    jr   nz,.jr_03_5020
    push hl
    ld   a,l
    xor  a,$06
    ld   l,a
    ld   a,[hl]
    pop  hl
    cp   a,$02
    jr   c,.jr_03_5020
    ld   a,l
    xor  a,$13
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   c,[hl]
    xor  a,$1F
    ld   l,a
    ld   a,e
    add  a,$0E
    bit  5,[hl]
    jr   z,.jr_03_5007
    sub  a,$1C
.jr_03_5007:
    ld   e,a
    ld   a,[wD213_Player_ScreenYPosition]
    sub  c
    add  a,$10
    cp   a,$20
    jr   nc,.jr_03_5020
    ld   a,[wD212_Player_ScreenXPosition]
    sub  e
    add  a,$04
    cp   a,$08
    jr   nc,.jr_03_5020
    pop  de
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_5020:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_5035_CollisionHandler_SamuraiHead:
; Touch → damage player; attack/stomp → sets MISC_FLAGS bit 0 (generic "was hit" flag shared by several enemies)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_5049_CollisionHandler_Geyser:
; Only reacts while the geyser is mid-eruption. Like the launch pad it does no damage and
; runs no overlap test at all - standing anywhere in the geyser's slot while it erupts is
; enough to be thrown upward
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,PLAYER_ACTION_MASK
    cp   a,$01                                         ; erupting
    ret  nz
    ld   a,PLAYER_GEYSER_VELOCITY
    ld   [wD758_JumpVelocityOverride],a
    ret
.jr_03_505d_CollisionHandler_Triceratops:
; Checks the horn hitbox first (X offset adjusted for facing direction), within a 12×12 window —
; if player is in horn range, damages directly. Otherwise standard overlap: touch → damage;
; attack/stomp → scans all slots for TRICERATOPS_HORN entity (ID=$49) and kills it, then spawns defeat particle
    push de
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ld   e,[hl]
    inc  l
    ld   c,[hl]
    xor  a,$1F
    ld   l,a
    ld   a,e
    add  a,$14
    bit  5,[hl]
    jr   z,.jr_03_5075
    sub  a,$28
.jr_03_5075:
    ld   e,a
    ld   a,[wD213_Player_ScreenYPosition]
    sub  c
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_508E
    ld   a,[wD212_Player_ScreenXPosition]
    sub  e
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_508E
    pop  de
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_508E:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   h,$D2
    ld   a,$20
.jr_03_509C:
    ld   l,a
    ld   a,[hl]
    cp   a,$49
    jr   nz,.jr_03_50A4
    ld   [hl],$FF
.jr_03_50A4:
    ld   a,l
    add  a,$20
    jr   nz,.jr_03_509C
    jp   call_00_3985_Entity_ParticleBurstInit
.jr_03_50ac_CollisionHandler_Gear:
; Overlap check with result saved. If overlapping AND stomp (A=$01), sets MISC_FLAGS bit 0 (gear activated).
; If not overlapping or not stomp, clears MISC_FLAGS bit 0 (gear released) — models a pressure-activated gear/button
    call call_03_519b_Entity_CheckPlayerInteraction
    push af
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    pop  af
    jr   nc,.jr_03_50C2
    cp   a,$01
    jr   nz,.jr_03_50C2
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_50C2:
    res  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_50c5_CollisionHandler_ElectricBall:
; Only dangerous in action $00 (charged state); otherwise falls through to touch damage handler
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,$1F
    cp   a,$00
    jp   nz,.jr_03_4d82_CollisionHandler_TouchDamage
    ret
.jr_03_50d6_CollisionHandler_GunProjectile:
; Overlap check; sets MISC_FLAGS bit 7 and damages player
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_7,[hl]
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_50e7_CollisionHandler_Rocket:
; Checks wD755_FlyPowerup2_TimerLo/wD756_FlyPowerup2_TimerHi (speed registers) are non-zero (rocket is moving). Overlap check;
; sets MISC_FLAGS bit 7, then triggers player action $1F (rocket ride/capture)
    ld   hl,wD755_FlyPowerup2_TimerLo
    ldi  a,[hl]
    or   [hl]
    ret  z
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_7,[hl]
    ld   a,PLAYER_ACTION_RIDING_ROCKET
    FARCALL call_02_4ccd_Player_RequestAction
    ret
.jr_03_5109_CollisionHandler_Cannon:
; Scans all slots for an active cannon projectile (ID=$4D); if one exists, returns (already firing).
; Otherwise standard overlap; A=$02 (stomp only) sets MISC_FLAGS bit 7 (fire the cannon)
    ld   h,$D2
    ld   a,$20
.jr_03_510D:
    ld   l,a
    ld   a,[hl]
    cp   a,$4D
    ret  z
    ld   a,l
    add  a,$20
    jr   nz,.jr_03_510D
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$02
    ret  nz
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_7,[hl]
    ret
.jr_03_5129_CollisionHandler_PoweredWalkway:
; Overlap check; if wD751_Player_CircuitPowerUpTimerLo/wD752_Player_CircuitPowerUpTimerHi are non-zero (walkway is powered), reads TIMER_2 as an index
; into wD5A3_ConveyorState1 conveyor state table, writes $06 to that slot; if the previous value was 0,
; plays SFX $2B (activation sound)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD751_Player_CircuitPowerUpTimerLo
    ldi  a,[hl]
    or   [hl]
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   l,[hl]
    dec  l
    ld   h,$00
    ld   de,wD5A3_ConveyorState1
    add  hl,de
    ld   a,[hl]
    ld   [hl],$06
    and  a
    ret  nz
    ld   c,SFX_POWERED_WALKWAY
    call call_00_112f_QueueSFX
    ret
.jr_03_514e_CollisionHandler_PowerUp:
; Overlap check; on hit, copies ENTITY_FIELD_MISC_TIMER_2 and the following byte into
; wD751_Player_CircuitPowerUpTimerLo/wD752_Player_CircuitPowerUpTimerHi (power-up type/value registers)
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ldi  a,[hl]
    ld   [wD751_Player_CircuitPowerUpTimerLo],a
    ld   a,[hl]
    ld   [wD752_Player_CircuitPowerUpTimerHi],a
    ret
.jr_03_5163_CollisionHandler_DragonProjectile:
; Standard overlap; always damages player if hit, then despawns the projectile slot entirely
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    call call_03_52be_Entity_DamagePlayerIfVulnerable
    jp   call_00_3910_Entity_ClearSlot
.jr_03_516d_CollisionHandler_Rez:
; Guards specific action IDs:
; action $04 → no collision (defeated state);
; actions $09/$0A → no collision (special states).
; Below $04: touch → damage;
; attack → transitions Rez to action $04 (defeat).
; Above $04 (but not $09/$0A): falls through silently
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,$1F
    cp   a,$04
    ret  z
    jr   nc,.jr_03_5194
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   a,$04
    FARCALL call_02_7102_Entity_SetAction
    ret
.jr_03_5194:
    cp   a,$09
    ret  z
    cp   a,$0A
    ret  z
    ret

call_03_519b_Entity_CheckPlayerInteraction:
; The shared AABB overlap test, called by nearly every handler as its first act.
;
; Returns carry clear when there is no overlap. On an overlap it returns carry set and, in A,
; *how* the player made contact - which is what lets one handler treat being walked into and
; being jumped on as completely different events:
;
;   A = 0  touch    the player ran into it
;   A = 1  attack   the player was tail whipping
;   A = 2  stomp    the player landed on it from above
;
; Whether each of those is even possible per entity type comes from
; .data_03_522e_EntityInteractionFlagsTable (ENTITY_INTERACT_*), so an enemy that cannot be
; stomped simply never returns 2 and its handler needs no special case.
;
; The stomp path is the interesting one: it requires the stomp flag, the player to be in
; PLAYER_ACTION_JUMP or PLAYER_ACTION_DOUBLE_JUMP, *and* his Y velocity to be downward. When
; all three hold it rewrites wD760_PlayerYVelocity to PLAYER_JUMP_VELOCITY before returning,
; so the bounce happens here rather than in any handler.
;
; Note the odd "ld A,$FF / add A,n" endings - that is a two-instruction way of loading the
; result and setting carry at the same time
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ENTITY_ID
    ld   L, [HL]
    ld   H, $00
    ld   BC, .data_03_522e_EntityInteractionFlagsTable
    add  HL, BC
    ld   B, [HL]
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_Y
    ld   A, E
    add  A, $08
    ld   E, A
    ld   A, [wD213_Player_ScreenYPosition]
    sub  A, [HL]
    add  A, D
    sla  D
    cp   A, D
    ret  NC
    dec  L
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, [HL]
    add  A, E
    sla  E
    cp   A, E
    ret  NC
    ld   C, A
    ld   HL, wD753_FlyPowerup1_TimerLo
    ld   A, [HL+]
    or   A, [HL]
    jr   NZ, .jr_03_51f5
    ld   HL, wD755_FlyPowerup2_TimerLo
    ld   A, [HL+]
    or   A, [HL]
    jr   NZ, .jr_03_51f5
    bit  1, B
    jr   Z, .jr_03_51fa
    ld   A, [wD201_Player_ActionId]
    and  A, PLAYER_ACTION_MASK
    cp   A, PLAYER_ACTION_TAIL_SPIN
    jr   Z, .jr_03_51f5
    cp   A, PLAYER_ACTION_KARATE_KICK
    jr   Z, .jr_03_51f5
    ld   A, [wD746_Player_ClimbingState]
    cp   A, $01
    jr   Z, .jr_03_51f5
    cp   A, $03
    jr   NZ, .jr_03_51fa
.jr_03_51f5:
    ld   A, $ff
    add  A, $02
    ret
.jr_03_51fa:
    srl  E
    ld   A, C
    sub  A, E
    jr   NC, .jr_03_5202
    cpl
    inc  A
.jr_03_5202:
    ld   C, A
    ld   A, E
    sub  A, $08
    ld   E, A
    ld   A, C
    cp   A, E
    ret  NC
    bit  2, B
    jr   Z, .jr_03_5229
    ld   A, [wD201_Player_ActionId]
    and  A, PLAYER_ACTION_MASK
    cp   A, PLAYER_ACTION_JUMP
    jr   Z, .jr_03_521b
    cp   A, PLAYER_ACTION_DOUBLE_JUMP
    jr   NZ, .jr_03_5229
.jr_03_521b:
    ld   HL, wD760_PlayerYVelocity
    bit  7, [HL]
    jr   Z, .jr_03_5229
    ld   [HL], $2a
    ld   A, $ff
    add  A, $03
    ret
.jr_03_5229:
    ld   A, $ff
    add  A, $01
    ret
.data_03_522e_EntityInteractionFlagsTable:
; One flags byte per entity type, saying which kinds of contact that entity reacts to:
;   bit 0 ($01) ENTITY_INTERACT_TOUCH  - running into it does something
;   bit 1 ($02) ENTITY_INTERACT_ATTACK - the tail whip kills it
;   bit 2 ($04) ENTITY_INTERACT_STOMP  - landing on it kills it, and bounces Gex
    db   ENTITY_INTERACT_NONE ; ENTITY_GEX
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_COLLECTIBLE_SPAWN
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_02
    db   ENTITY_INTERACT_NONE ; ENTITY_TV_BUTTON
    db   ENTITY_INTERACT_NONE ; ENTITY_RED_REMOTE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_SILVER_REMOTE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_GOLD_REMOTE
    db   ENTITY_INTERACT_NONE ; ENTITY_ENEMY_DEFEATED
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_08
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_FALLING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_PUSH_BLOCK
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_PUMPKIN
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_FRANKIE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_SCREAM_TV_HEAD_GHOST
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_FLOATING_SKULL
    db   ENTITY_INTERACT_TOUCH ; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_ZOMBIE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_ZOMBIE_HEAD
    db   ENTITY_INTERACT_TOUCH ; ENTITY_SCREAM_TV_FALLING_AXE
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_LANTERN
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_SCREAM_TV_BAT
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_DOOR_OPENING
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_SCREAM_TV_GHOST
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_VANISHING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_MOVING_BEAR_TRAP
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_BUMBLEBEE
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_BOWLING_BALL
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_CACTUS
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_DOMINO
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_SHARK
    db   ENTITY_INTERACT_NONE ; ENTITY_TOON_TV_FLOWER
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_HUNTER
    db   ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_MUSHROOM
    db   ENTITY_INTERACT_NONE ; ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_LIZARD
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_TOON_TV_HAPPY_FACE
    db   ENTITY_INTERACT_NONE ; ENTITY_TOON_TV_VANISHING_BLOCK
    db   ENTITY_INTERACT_NONE ; ENTITY_TOON_TV_MOVING_BLOCK
    db   ENTITY_INTERACT_NONE ; ENTITY_TOON_TV_MOVING_LOG
    db   ENTITY_INTERACT_NONE ; ENTITY_TOON_TV_STATIONARY_LOG
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_FLOWER_HAMMER
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_HUNTER_BULLET
    db   ENTITY_INTERACT_TOUCH ; ENTITY_TOON_TV_ROCKET
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_FAST_DINOSAUR
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_DRAGONFLY
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_EGG
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_35
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_36
    db   ENTITY_INTERACT_TOUCH ; ENTITY_PRE_HISTORY_FALLING_LAVA
    db   ENTITY_INTERACT_NONE ; ENTITY_PRE_HISTORY_LAVA_RAFT
    db   ENTITY_INTERACT_NONE ; ENTITY_PRE_HISTORY_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_3A
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_3B
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_PTEROSAUR
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_3D
    db   ENTITY_INTERACT_TOUCH ; ENTITY_PRE_HISTORY_FALLING_BOULDER
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_3F
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_ANT
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_FIRE_PLANT
    db   ENTITY_INTERACT_TOUCH ; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    db   ENTITY_INTERACT_TOUCH ; ENTITY_PRE_HISTORY_GEYSER
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_46
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_DINOSAUR
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_PRE_HISTORY_TRICERATOPS
    db   ENTITY_INTERACT_TOUCH ; ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_4A
    db   ENTITY_INTERACT_TOUCH ; ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    db   ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_CANNON
    db   ENTITY_INTERACT_NONE ; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_DRAGONFLY
    db   ENTITY_INTERACT_TOUCH ; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    db   ENTITY_INTERACT_TOUCH ; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_51
    db   ENTITY_INTERACT_TOUCH ; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_KUNG_FU_THEATER_LIZARD
    db   ENTITY_INTERACT_TOUCH ; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    db   ENTITY_INTERACT_TOUCH ; ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    db   ENTITY_INTERACT_ATTACK ; ENTITY_KUNG_FU_THEATER_TALL_JAR
    db   ENTITY_INTERACT_ATTACK ; ENTITY_KUNG_FU_THEATER_JAR
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_5C
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_5D
    db   ENTITY_INTERACT_NONE ; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_60
    db   ENTITY_INTERACT_NONE ; ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    db   ENTITY_INTERACT_NONE ; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_63
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_64
    db   ENTITY_INTERACT_NONE ; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_REZOPOLIS_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_REZOPOLIS_RED_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    db   ENTITY_INTERACT_ATTACK ; ENTITY_REZOPOLIS_TAILSPIN_GEAR
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_6B
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_6C
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_6D
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_REZOPOLIS_GREEN_MONSTER
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_6F
    db   ENTITY_INTERACT_TOUCH ; ENTITY_UNK_70
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_REZOPOLIS_PINCER
    db   ENTITY_INTERACT_TOUCH ; ENTITY_REZOPOLIS_FLAMETHROWER
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_REZOPOLIS_UFO
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_REZOPOLIS_ANT
    db   ENTITY_INTERACT_NONE ; ENTITY_REZOPOLIS_ANT_SPAWNER
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_CIRCUIT_CENTRAL_ANT
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CIRCUIT_CENTRAL_POWER_UP
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_79
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    db   ENTITY_INTERACT_NONE ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    db   ENTITY_INTERACT_NONE ; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    db   ENTITY_INTERACT_NONE ; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP ; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    db   ENTITY_INTERACT_NONE ; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CHANNEL_Z_GUN_PROJECTILE
    db   ENTITY_INTERACT_TOUCH | ENTITY_INTERACT_ATTACK ; ENTITY_CHANNEL_Z_REZ
    db   ENTITY_INTERACT_NONE ; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1
    db   ENTITY_INTERACT_NONE ; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2
    db   ENTITY_INTERACT_NONE ; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    db   ENTITY_INTERACT_TOUCH ; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    db   ENTITY_INTERACT_NONE ; ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    db   ENTITY_INTERACT_NONE ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    db   ENTITY_INTERACT_NONE ; ENTITY_CHANNEL_Z_REZ_PORTAL
    db   ENTITY_INTERACT_NONE ; ENTITY_UNK_8E
    db   ENTITY_INTERACT_NONE ; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

call_03_52be_Entity_DamagePlayerIfVulnerable:
; Calls Player_CanBeDamaged; if Z (player is vulnerable), calls DealDamageToPlayer.
; Simple two-instruction wrapper used by every damaging handler
    call call_00_075b_Player_CanBeDamaged
    call Z, call_00_06bf_DealDamageToPlayer
    ret

call_03_52c5_CollisionHandler_StationaryPlatform:
; Full top-surface landing check. Compares player bottom (Y+$0F) against platform Y
; to determine approach direction. For top-landing: checks X overlap, then compares
; horizontal approach speed against wD75D (prev X speed) to filter out wall sliding;
; if valid landing, writes entity address to wD74D (player's current platform) and
; manages wD74E_Player_PushedStationaryPlatformLo (secondary platform slot).
; For side/bottom hits: clears platform tracking vars
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_SCREEN_Y
    ld   A, [wD213_Player_ScreenYPosition]
    add  A, $0f
    cp   A, [HL]
    jr   C, call_03_5314_Platform_LandingCheck
    sub  A, $1f
    ld   C, A
    ld   A, [HL]
    add  A, D
    dec  A
    cp   A, C
    jr   C, call_03_534d_StationaryPlatform_ClearPlayerInteraction
    dec  L
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, [HL]
    add  A, E
    bit  7, A
    jr   NZ, .jr_03_52f8
    sla  E
    sub  A, E
    jr   C, call_03_534d_StationaryPlatform_ClearPlayerInteraction
    ld   HL, wD75D_PlayerXSpeedPrev
    cp   A, [HL]
    jr   C, call_03_5360_StationaryPlatform_SetPushInteraction
    or   A, [HL]
    jr   Z, call_03_5360_StationaryPlatform_SetPushInteraction
    jr   call_03_534d_StationaryPlatform_ClearPlayerInteraction
.jr_03_52f8:
    cpl
    ld   HL, wD75D_PlayerXSpeedPrev
    cp   A, [HL]
    jr   C, call_03_5360_StationaryPlatform_SetPushInteraction
    or   A, [HL]
    jr   Z, call_03_5360_StationaryPlatform_SetPushInteraction
    jr   call_03_534d_StationaryPlatform_ClearPlayerInteraction

call_03_5304_CollisionHandler_OneWayPlatform:
; Simplified platform — only handles the "approaching from above" path (player Y+$0F < platform Y),
; then falls through into Platform_LandingCheck. Effectively a one-way/pass-through platform
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_SCREEN_Y
    ld   a,[wD213_Player_ScreenYPosition]
    add  a,$0F
    cp   [hl]
    jr   nc,call_03_534d_StationaryPlatform_ClearPlayerInteraction
call_03_5314_Platform_LandingCheck:
; Shared landing sub-routine: checks X overlap against full width (2×E), then computes the
; penetration depth C = platformY − (playerY+$0F+1); if depth ≥ $80 (too deep, tunneled through)
; rejects. Compares Y velocity/16 against depth to decide if landing is valid; if so, writes
; entity to wD74D, clears wD74E_Player_PushedStationaryPlatformLo if it matches
    ld   C, A
    dec  L
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, [HL]
    add  A, E
    sla  E
    cp   A, E
    jr   NC, call_03_534d_StationaryPlatform_ClearPlayerInteraction
    inc  L
    inc  C
    ld   A, [HL]
    sub  A, C
    ld   C, A
    cp   A, $80
    jr   NC, call_03_534d_StationaryPlatform_ClearPlayerInteraction
    ld   A, [wD760_PlayerYVelocity]
    sra  A
    sra  A
    sra  A
    sra  A
    add  A, C
    bit  7, A
    jr   NZ, .jr_03_533f
    cp   A, $02
    jr   C, .jr_03_533f
    jr   call_03_534d_StationaryPlatform_ClearPlayerInteraction
.jr_03_533f:
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   [wD74D_Player_EntityStoodOnLo], A
    ld   HL, wD74E_Player_PushedStationaryPlatformLo
    cp   A, [HL]
    ret  NZ
    ld   [HL], $00
    ret

call_03_534d_StationaryPlatform_ClearPlayerInteraction:
; Called when platform overlap is definitely false; clears both wD74D and wD74E_Player_PushedStationaryPlatformLo
; if they currently reference this entity
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   NZ, .jr_03_5358
    ld   [HL], $00
.jr_03_5358:
    ld   HL, wD74E_Player_PushedStationaryPlatformLo
    cp   A, [HL]
    ret  NZ
    ld   [HL], $00
    ret

call_03_5360_StationaryPlatform_SetPushInteraction:
; Clears wD74D if it currently points to this entity (player left primary platform),
; then writes entity address to wD74E_Player_PushedStationaryPlatformLo (secondary/adjacent platform tracking)
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   NZ, .jr_03_536b
    ld   [HL], $00
.jr_03_536b:
    ld   [wD74E_Player_PushedStationaryPlatformLo], A
    ret

call_03_536f_CollisionHandler_MovingPlatform:
; Summary: This function essentially uses the player's screen xy position, and platform's screen xy position,
; to determine if the platform is stood on (wD74D_Player_EntityStoodOnLo)
; or pushing the player (Player_PushedMovingPlatformLo).
;
; Same structure as stationary platform but additionally reads ENTITY_FIELD_X_VELOCITY,
; right-shifts 4×, stores in B, then calls MovingPlatformCollisionHelper to get a corrected
; relative X speed accounting for platform motion. Landing validity is then checked against
; (relativeX − B + E + D) instead of raw speed. On landing writes to wD74D_Player_EntityStoodOnLo
; /Player_PushedMovingPlatformLo (moving platform uses Player_PushedMovingPlatformLo instead of
; wD74E_Player_PushedStationaryPlatformLo); on miss clears both
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_SCREEN_Y
    ld   A, [wD213_Player_ScreenYPosition]
    add  A, $0f
    cp   A, [HL]
    jr   C, .jr_03_53ba_PlayerIsAbovePlatformOnScreen  ; jump if PlayerScreenY+0xF is above PlatformScreenY
    sub  A, $1f                                        ; A = PlayerScreenY - 0x10
    ld   C, A                                          ; C = PlayerScreenY - 0x10
    ld   A, [HL]                                       ; A = PlayerScreenY
    add  A, D                                          ; A = PlayerScreenY + PlatformHeight
    dec  A                                             ; A = PlayerScreenY + PlatformHeight - 1
    cp   A, C
    jr   C, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
    dec  L                                             ; HL = ENTITY_FIELD_SCREEN_X (PlatformScreenX)
    ld   A, [wD212_Player_ScreenXPosition]             ; A = PlayerScreenX
    sub  A, [HL]                                       ; A = PlayerScreenX - PlatformScreenX
    add  A, E                                          ; A = PlayerScreenX + PlatformWidth
    bit  7, A                                          ; jump if player is on left side of platform
    jr   NZ, .jr_03_53a8_PlayerIsLeftOfPlatform
    sla  E
    sub  A, E
    jr   C, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
    ld   C, A
    call call_03_5427_MovingPlatform_GetRelativeXSpeed
    ld   A, C
    sub  A, B
    add  A, E
    add  A, D
    bit  7, A
    jr   NZ, .jr_03_5418_PlayerIsBeingPushedByThisPlatform
    and  A, A
    jr   Z, .jr_03_5418_PlayerIsBeingPushedByThisPlatform
    jr   .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
.jr_03_53a8_PlayerIsLeftOfPlatform:
    cpl                                                ; A = BITNOT A (flip all bits)
    ld   C, A                                          ; C = BITNOT(PlayerScreenX + PlatformWidth)
    call call_03_5427_MovingPlatform_GetRelativeXSpeed ; B = PlatformXVel, E = PlayerPrevXVel
    ld   A, C                                          ; A = BITNOT(PlayerScreenX + PlatformWidth)
    add  A, B                                          ; A += PlatformXVel / 16
    sub  A, E                                          ; A -= PlayerPrevXVel
    sub  A, D                                          ; A -= wD75C_PlayerXDeltaExtra
    bit  7, A
    jr   NZ, .jr_03_5418_PlayerIsBeingPushedByThisPlatform  ; jump if distance between player and platform is 0 or negative
    and  A, A
    jr   Z, .jr_03_5418_PlayerIsBeingPushedByThisPlatform
    jr   .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
.jr_03_53ba_PlayerIsAbovePlatformOnScreen:
    ld   C, A                                          ; C = PlayerScreenY + 0xF
    dec  L                                             ; HL = ENTITY_FIELD_SCREEN_X
    ld   A, [wD212_Player_ScreenXPosition]             ; A = PlayerScreenX
    sub  A, [HL]                                       ; A = PlayerScreenX - PlatformScreenX
    add  A, E                                          ; DE is platform height and width (0810 usually)
    sla  E                                             ; E = 2*width
    cp   A, E
    jr   NC, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform     ; jump if player is not in x range of platform
    inc  L                                             ; HL = ENTITY_FIELD_SCREEN_Y
    inc  C                                             ; C = PlayerScreenY + 0x10
    ld   A, [HL]                                       ; A = PlatformScreenY
    sub  A, C                                          ; A = PlatformScreenY - (PlayerScreenY + 0x10)
    ld   C, A                                          ; C = A
    cp   A, $80                                        ; jump if player below platform?
    jr   NC, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
    ld   A, [wD760_PlayerYVelocity]
    sra  A
    sra  A
    sra  A
    sra  A
    add  A, C
    ld   C, A
    ld   A, L
    xor  A, $0d
    ld   L, A
    ld   E, [HL]
    ld   E, $10
    sra  E
    sra  E
    sra  E
    sra  E
    ld   A, C
    sub  A, E
    bit  7, A
    jr   NZ, .jr_03_53f7_PlayerIsOnThisPlatform
    cp   A, $02
    jr   C, .jr_03_53f7_PlayerIsOnThisPlatform
    jr   .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
.jr_03_53f7_PlayerIsOnThisPlatform:
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   [wD74D_Player_EntityStoodOnLo], A
    ld   HL, wD74F_Player_PushedMovingPlatformLo
    cp   A, [HL]
    ret  NZ
    ld   [HL], $00
    ret
.jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform:
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   NZ, .jr_03_5410_PlayerIsOnADifferentPlatform
    ld   [HL], $00
.jr_03_5410_PlayerIsOnADifferentPlatform:
    ld   HL, wD74F_Player_PushedMovingPlatformLo
    cp   A, [HL]
    ret  NZ
    ld   [HL], $00
    ret
.jr_03_5418_PlayerIsBeingPushedByThisPlatform:
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   NZ, .jr_03_5423_PlayerIsOnADifferentPlatform
    ld   [HL], $00
.jr_03_5423_PlayerIsOnADifferentPlatform:
    ld   [wD74F_Player_PushedMovingPlatformLo], A
    ret

call_03_5427_MovingPlatform_GetRelativeXSpeed:
; Reads the platform's X velocity, shifts right 4× into B (pixel speed).
; Loads wD75C_PlayerXDeltaExtra/wD75D (player X delta and prev speed) into D/E. Checks bit 5 of player facing angle;
; if set (facing left), negates A and stores into E. Returns B=platform pixel speed, D=player X delta,
; E=adjusted player speed for relative motion comparison
    ld   A, L
    xor  A, $0e
    ld   L, A
    ld   B, [HL]                                       ; B = ENTITY_FIELD_X_VELOCITY (10)
    sra  B
    sra  B
    sra  B
    sra  B
    ld   A, [wD75C_PlayerXDeltaExtra]
    ld   D, A                                          ; D = wD75C_PlayerXDeltaExtra
    ld   A, [wD75D_PlayerXSpeedPrev]
    ld   E, A                                          ; E = wD75D_PlayerXSpeedPrev
    ld   HL, wD20D_Player_FacingFlags
    bit  5, [HL]
    ret  Z
    cpl
    inc  A
    ld   E, A
    ret
