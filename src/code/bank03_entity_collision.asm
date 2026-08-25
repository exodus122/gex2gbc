; ==================================================================
; ENTITY COLLISION
;
; Gex against everything else - enemies, remotes, platforms, tv buttons.
; Entity-against-entity collision does not exist; only the player is ever
; tested, which is why every routine here talks about "the player" implicitly.
;
; Two levels of dispatch:
;
;   COLLISION_TYPE (ENTITY_FIELD_COLLISION_TYPE, $16) picks a handler out of
;   .data_03_4c9b_EntityCollisionJumpTable. It is a property of the entity
;   *instance*: bank0A gives each entity type a default when it spawns, and a
;   handful of actions in bank 2 rewrite it mid-life through
;   call_00_3825_Entity_SetCollisionType, so the same entity can be inert on one
;   frame and lethal on the next
;
;   ENTITY_INTERACT_* flags (.data_03_522e_EntityInteractionFlagsTable, keyed by
;   entity TYPE rather than by collision type) say whether an attack or a stomp
;   is possible at all
;
; Almost every handler opens with call_03_519b_Entity_CheckPlayerInteraction,
; which does the box test once and reports back not just "did we touch" but
; *how*: PLAYER_TOUCHED_ENTITY, PLAYER_ATTACKED_ENTITY or PLAYER_STOMPED_ENTITY.
; The handler then switches on that. Reading a handler is mostly a matter of
; reading its three cases.
;
; Every handler is entered with the entity's collision box already in DE -
; E = ENTITY_FIELD_COLLISION_WIDTH, D = ENTITY_FIELD_COLLISION_HEIGHT - loaded by
; the dispatcher on its way past. Both are HALF extents: every test in this file
; is symmetric about ENTITY_FIELD_SCREEN_X / ENTITY_FIELD_SCREEN_Y and doubles
; them with `sla` to get the full span. Handlers that roll their own hitbox (the
; ninja's sword, the triceratops' horn) push DE first, because they need L free.
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
; Entry point for all entity-player collision, tail-called by Entity_BuildSprites.
;
; Two early outs. Nothing happens while Gex is not being updated
; (wD743_Player_UpdateFlag = 0), and an entity whose SPRITE_FLAG_ON_SCREEN is
; clear is never tested - offscreen entities cannot be touched.
;
; Then it walks the instance with XOR/INC on L rather than reloading the base
; each time: $0A -> $14 (width) -> $15 (height) -> $16 (collision type), picking
; the collision box up into E and D on the way past.
;
; `res 7, L` strips COLLISION_TYPE_PLATFORM ($80) back off the type before it is
; used as an index. bank0A stores that bit OR'd into the type byte of everything
; Gex can stand on, and this table has no row for it. The bit is not meant for
; this routine at all - call_02_4a77_Player_ApplyXMovement reads it straight off
; the field to tell a hard stop (a tv button he shoves into) from a soft one.
;
; DE survives the `jp HL`, so every handler starts with E = half width and
; D = half height
    ld   A, [wD743_Player_UpdateFlag]
    and  A, A
    ret  Z                                             ; Gex is not live this frame
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    bit  SPRITE_FLAG_ON_SCREEN_BIT, [HL]
    ret  Z
    xor  A, $1e                                        ; $0A -> $14 COLLISION_WIDTH
    ld   L, A
    ld   E, [HL]                                       ; E = half width
    inc  L                                             ; $15 COLLISION_HEIGHT
    ld   D, [HL]                                       ; D = half height
    inc  L                                             ; $16 COLLISION_TYPE
    ld   L, [HL]
    res  7, L                                          ; drop COLLISION_TYPE_PLATFORM
    ld   H, $00
    add  HL, HL                                        ; two bytes per entry
    ld   BC, .data_03_4c9b_EntityCollisionJumpTable
    add  HL, BC
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    jp   HL
.data_03_4c9b_EntityCollisionJumpTable:
; One handler address per COLLISION_TYPE_*, in value order. Two rows are dead:
; nothing in the game ever carries COLLISION_TYPE_NONE_2 or
; COLLISION_TYPE_LAUNCH_PAD - neither appears in bank0A's type table nor in any
; call_00_3825_Entity_SetCollisionType call
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
    dw   .jr_03_4ec6_CollisionHandler_None2 ; COLLISION_TYPE_NONE_2 (never assigned)
    dw   .jr_03_4ec7_CollisionHandler_MultiProjectile ; COLLISION_TYPE_MULTI_PROJECTILE
    dw   .jr_03_4f14_CollisionHandler_Jar ; COLLISION_TYPE_JAR
    dw   .jr_03_4f20_CollisionHandler_Ninja ; COLLISION_TYPE_NINJA
    dw   .jr_03_4fc7_CollisionHandler_HangingBlade ; COLLISION_TYPE_HANGING_BLADE
    dw   .jr_03_4fcf_CollisionHandler_LaunchPad ; COLLISION_TYPE_LAUNCH_PAD (never assigned)
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
; The default for anything Gex cannot interact with, and what
; call_00_3985_Entity_ParticleBurstInit writes over a defeated enemy so its death
; effect can neither hit nor be hit
    ret
.jr_03_4ce6_CollisionHandler_Collectible:
; ENTITY_COLLECTIBLE_SPAWN. One entity stands in for up to ENTITY_PARTICLE_COUNT
; separate pickups: its particle buffer holds their offsets, and the sprite
; builder draws them out of the same records.
;
; The shared box test is only a cheap reject here - it says Gex is somewhere in
; the cluster, not which item he reached - so on a hit this re-tests every live
; record on its own. PARTICLE_VISIBLE_BIT is the "still there" flag; a record
; whose bit is clear has already been eaten.
;
; Each per-record test is an 8 wide by 16 tall window around the entity's screen
; position offset by that record's PARTICLE_FIELD_YOFFSET and
; PARTICLE_FIELD_XOFFSET. The first match clears the record's visible bit and
; tail-calls Player_ObtainedCollectible, so two overlapping items cannot be taken
; on the same frame
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  NC
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ld   C, [HL]                                       ; C = entity screen X
    inc  L
    ld   B, [HL]                                       ; B = entity screen Y
    call call_00_39f5_Entity_GetParticlesPtr           ; DE = this entity's particle buffer
    ld   L, E
    ld   H, D
    ld   A, ENTITY_PARTICLE_COUNT
.jr_03_4cfc:
    push AF
    push BC
    push HL
    ld   A, [HL+]                                      ; PARTICLE_FIELD_FLAGS
    bit  PARTICLE_VISIBLE_BIT, A
    jr   Z, .jr_03_4d20                                ; already collected
    inc  HL                                            ; -> PARTICLE_FIELD_YOFFSET
    ld   A, [HL+]
    add  A, B
    ld   B, A                                          ; B = this item's screen Y
    ld   A, [wD213_Player_ScreenYPosition]
    sub  A, B
    add  A, $08
    cp   A, $10                                        ; 16 tall
    jr   NC, .jr_03_4d20
    inc  HL                                            ; -> PARTICLE_FIELD_XOFFSET
    ld   A, [HL+]
    add  A, C
    ld   C, A                                          ; C = this item's screen X
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, C
    add  A, $04
    cp   A, $08                                        ; 8 wide
    jr   C, .jr_03_4d2b
.jr_03_4d20:
    pop  HL
    ld   BC, ENTITY_PARTICLE_RECORD_SIZE
    add  HL, BC
    pop  BC
    pop  AF
    dec  A
    jr   NZ, .jr_03_4cfc
    ret
.jr_03_4d2b:
    pop  HL                                            ; HL = the matching record
    res  PARTICLE_VISIBLE_BIT, [HL]                    ; take it out of the cluster
    pop  BC
    pop  AF
    jp   call_00_06ec_Player_ObtainedCollectible
.jr_03_4d33_CollisionHandler_ExtraLife:
; ENTITY_UNK_02, the only user. Any contact frees the slot and hands Gex a
; FLY_POWERUP_EXTRA_LIFE - hardcoded, there is no per-instance parameter.
;
; Note what Player_SwapFlyPowerup does with that argument: it becomes the fly he
; is now HOLDING, and it is the fly being displaced whose effect fires. So this
; entity does not grant a life on the spot; it arms one that is paid out when the
; next fly replaces it
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    call call_00_3931_Entity_DeactivateSelf
    ld   a,FLY_POWERUP_EXTRA_LIFE
    jp   call_00_0647_Player_SwapFlyPowerup
.jr_03_4d3f_CollisionHandler_SilverRemote:
; ENTITY_SILVER_REMOTE - the hidden remote physically placed in a level. Any
; contact sets bit 4 of wD64C_CurrentLevel_HiddenRemoteFlags, plays
; SFX_SILVER_REMOTE, frees the slot and marks the list entry
; ENTITY_LIST_FLAG_NEVER_AGAIN so it does not come back if you walk away and
; return. wD64C is OR'd into wD629_RemoteProgressFlags when the level ends.
;
; Bit 4 is REMOTE_GOLD_BIT, not REMOTE_SILVER_BIT, despite the entity's name -
; the bit constants and the entity constants disagree about which hidden remote
; is which. Bit 3 (REMOTE_SILVER_BIT) is the OTHER hidden remote, awarded by
; call_00_06ec_Player_ObtainedCollectible for collecting flies, and nothing here
; touches it
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   a,[wD64C_CurrentLevel_HiddenRemoteFlags]
    or   a,$10                                         ; 1 << REMOTE_GOLD_BIT
    ld   [wD64C_CurrentLevel_HiddenRemoteFlags],a
    ld   c,SFX_SILVER_REMOTE
    call call_00_112f_QueueSFX
    call call_00_3931_Entity_DeactivateSelf
    jp   call_00_393c_Entity_MarkNeverRespawn
.jr_03_4d56_CollisionHandler_GoldRemote:
; ENTITY_GOLD_REMOTE - the prize at the end of a bonus level, which
; call_02_5297_EntityAction_GoldRemote_Gbc keeps hidden until the collectible
; quota has been met.
;
; It refuses to trigger once WARP_TIME_UP is set, so a remote reached on the
; buzzer of a timed bonus level does not count.
;
; On contact it sets bit 5 - REMOTE_BONUS_MASK, "collectible-quota mission
; completed" - in this level's byte of wD629_RemoteProgressFlags, frees the slot,
; marks the list entry ENTITY_LIST_FLAG_NEVER_AGAIN, and requests
; PLAYER_ACTION_GOLD_REMOTE_WARP, which is what actually ends the level. Unlike
; the silver remote it writes wD629 directly rather than the wD64C snapshot
    ld   a,[wD621_WarpFlags]
    and  a,WARP_TIME_UP
    ret  nz
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD624_CurrentLevelId
    ld   l,[hl]
    ld   h,$00
    ld   de,wD629_RemoteProgressFlags
    add  hl,de                                         ; this level's progress byte
    ld   a,[hl]
    or   a,REMOTE_BONUS_MASK
    ld   [hl],a
    call call_00_3931_Entity_DeactivateSelf
    call call_00_393c_Entity_MarkNeverRespawn
    ld   a,PLAYER_ACTION_GOLD_REMOTE_WARP
    FARCALL call_02_4ccd_Player_RequestAction
    ret
.jr_03_4d82_CollisionHandler_TouchDamage:
; The plain hazard: touching it hurts, hitting it does nothing. Used by the
; falling axe, the hunter's bullet, both dragon segments, the ninja's shuriken
; and the spiky log, among others.
;
; Every entity that reaches here is ENTITY_INTERACT_TOUCH only, so
; CheckPlayerInteraction can never return anything but PLAYER_TOUCHED_ENTITY and
; the `cp` below is always true - it costs nothing and keeps the shape of the
; other handlers
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    call z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ret
.jr_03_4d8c_CollisionHandler_Lantern:
; ENTITY_SCREAM_TV_LANTERN. This handler damages and collects nothing - it is the
; only writer of wD757_LanternLitFlag, and it rebuilds the flag from scratch every
; frame rather than latching it: raise it on entry, drop it again if Gex is
; overlapping the lantern.
;
; So the flag means "a lantern is loaded and Gex is not standing at it", which is
; exactly when the lantern draws its lit sprite. Douse it by standing there and
; the ghost stops chasing and becomes attackable - see
; .jr_03_4dd4_CollisionHandler_Ghost and the ghost's actions in bank 2
    ld   a,$01
    ld   [wD757_LanternLitFlag],a
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    xor  a
    ld   [wD757_LanternLitFlag],a                      ; Gex is at the lantern
    ret
.jr_03_4d9a_CollisionHandler_Zombie:
; ENTITY_SCREAM_TV_ZOMBIE. Touch hurts. An attack or a stomp sets MISC_FLAGS bit
; 0, which call_02_5480_EntityAction_Zombie_Walk reads as "Gex just hit me" - it
; pops the head off and switches to its stagger action - and loads $3C frames
; into MISC_TIMER_1 for that stagger to run out on.
;
; Bit 0 also gates re-entry here, so the whole stagger is invulnerability frames.
;
; The `dec [hl]` at the end takes one off MISC_PARAM, the zombie's hit counter.
; It can never reach zero, because the walk action rewrites MISC_PARAM to $02 on
; every single frame - hitting the body only ever staggers it. The kill is scored
; by .jr_03_4df4_CollisionHandler_ZombieHead instead
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jr   nz,.jr_03_4DA5
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_4DA5:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    ret  nz                                            ; still staggering - ignore
    set  MISC_FLAGS_BIT_0,[hl]
    inc  l                                             ; $18 MISC_TIMER_1
    ld   [hl],$3C                                      ; one second of stagger
    inc  l                                             ; $19 MISC_TIMER_2
    inc  l                                             ; $1A MISC_PARAM - hit counter
    ld   a,[hl]
    and  a
    ret  z
    dec  [hl]
    ret
.jr_03_4dbc_CollisionHandler_GenericEnemy:
; The ordinary "one hit and it dies" enemy - dragonflies, the head ghost, the
; kung fu theatre dragonfly. Touch hurts; an attack or a stomp turns this entity
; into its own death burst through call_00_3985_Entity_ParticleBurstInit, which
; also marks the list entry so it stays dead
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  NC
    cp   A, PLAYER_TOUCHED_ENTITY
    jp   Z, call_03_52be_Entity_DamagePlayerIfVulnerable
    jp   call_00_3985_Entity_ParticleBurstInit
.jr_03_4dc8_CollisionHandler_GhostHead:
; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD, the head the head-ghost throws.
;
; Contact of ANY kind removes it - the `jp` sits outside the `call z`, so being
; walked into is as fatal to the head as being whipped. Only the touch case also
; hurts Gex. It frees the slot without marking the list entry, because the head
; is a child entity the parent respawns
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    call z,call_03_52be_Entity_DamagePlayerIfVulnerable
    jp   call_00_3931_Entity_DeactivateSelf
.jr_03_4dd4_CollisionHandler_Ghost:
; ENTITY_SCREAM_TV_GHOST. Whether the ghost can be hit at all depends on
; wD757_LanternLitFlag: while a lantern is lit the ghost is chasing and
; untouchable, and every contact - attack, stomp or touch - just hurts Gex. Only
; once he has doused the lantern (flag clear) does an attack register.
;
; The `inc [hl]` / `dec [hl]` pair is a zero test that leaves A alone, since A
; still holds the interaction type.
;
; QUIRK: the "I was hit" bit is not written to this entity's own MISC_FLAGS. L is
; still $57, left over from `ld hl, wD757_LanternLitFlag`, so `or l` sets bit 6 of
; the slot base as well as the field offset: the write lands on field $17 of slot
; (own slot | 2). call_02_55f1_EntityAction_Ghost_Dormant, which is supposed to
; read this bit back, has the mirror image of the same bug and reads $D2F1
; instead. Both are faithful to the ROM - see 03:4DE5 and 02:55F1
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD757_LanternLitFlag
    inc  [hl]
    dec  [hl]                                          ; test without clobbering A
    jr   z,.jr_03_4DE5
    cp   a,PLAYER_TOUCHED_ENTITY                       ; lantern lit - untouchable
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ret
.jr_03_4DE5:
    cp   a,PLAYER_ATTACKED_ENTITY
    jp   nz,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   h,HIGH(wD200_EntityMemory)
    ld   a,[wD300_CurrentEntityAddrLo]
    or   l                                             ; L is $57, not a field offset
    ld   l,a
    set  0,[hl]                                        ; intended: own MISC_FLAGS bit 0
    ret
.jr_03_4df4_CollisionHandler_ZombieHead:
; ENTITY_SCREAM_TV_ZOMBIE_HEAD, the head the zombie drops when it is first hit.
; Touch hurts.
;
; An attack or a stomp kills the zombie the head came from, not just the head: it
; sweeps the NPC slots for an ENTITY_SCREAM_TV_ZOMBIE, and if one is loaded it
; points wD300_CurrentEntityAddrLo at that slot for the length of one
; ParticleBurstInit call, so the burst - and the never-respawn mark - land on the
; body. wD300 is saved and restored around the swap. The head itself is freed
; either way
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   a,[wD300_CurrentEntityAddrLo]
    push af
    ld   h,HIGH(wD200_EntityMemory)
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_03_4E05:
    ld   l,a
    ld   a,[hl]                                        ; ENTITY_FIELD_ENTITY_ID
    cp   a,ENTITY_SCREAM_TV_ZOMBIE
    jr   z,.jr_03_4E12
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_03_4E05                                ; wraps to $00 past the last slot
    jr   .jr_03_4E19                                   ; no body loaded
.jr_03_4E12:
    ld   a,l
    ld   [wD300_CurrentEntityAddrLo],a                 ; act as the zombie for one call
    call call_00_3985_Entity_ParticleBurstInit
.jr_03_4E19:
    pop  af
    ld   [wD300_CurrentEntityAddrLo],a
    jp   call_00_3931_Entity_DeactivateSelf
.jr_03_4e20_CollisionHandler_FallingHazard:
; The crusher: the pre-history falling boulder, and the first half of the kung fu
; theatre hanging blade. Unlike everything else here it works in WORLD space, not
; screen space, and it ignores the shared box test entirely.
;
; Only armed while the entity is moving downward (ENTITY_FIELD_Y_VELOCITY
; negative). Then:
;   horizontally, a 16-bit test that Gex is within the collision half width
;   vertically, Gex's world Y must be 1 to 12 pixels ABOVE the entity's world Y
;     plus its half height plus $10 - i.e. just under its leading edge
;
; A hit that gets past Player_IsInvincible costs damage, arms the full
; PLAYER_DAMAGE_COOLDOWN_LENGTH of flicker, and forces PLAYER_ACTION_COLLAPSE -
; the same squashed animation a long fall produces
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    bit  7, [HL]
    ret  Z                                             ; not falling - harmless
    xor  A, $10                                        ; $1E -> $0E WORLD_X
    ld   L, A
    ld   A, [wD20E_Player_XPositionLo]
    sub  A, [HL]
    ld   C, A
    inc  HL
    ld   A, [wD20F_Player_XPositionHi]
    sbc  A, [HL]
    ld   B, A                                          ; BC = playerX - entityX
    ld   A, C
    add  A, E
    ld   C, A
    ld   A, B
    adc  A, $00
    ld   B, A                                          ; BC += half width
    sla  E                                             ; E = full width
    ld   A, C
    sub  A, E
    ld   A, B
    sbc  A, $00
    ret  NC                                            ; outside the column
    inc  L                                             ; $10 WORLD_Y
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A                                          ; HL = entity world Y
    ld   E, D
    ld   D, $00
    add  HL, DE                                        ; + half height
    ld   DE, $10
    add  HL, DE                                        ; + $10
    ld   A, [wD210_Player_YPositionLo]
    sub  A, L
    ld   L, A
    ld   A, [wD211_Player_YPositionHi]
    sbc  A, H
    ret  NC                                            ; Gex is below the edge
    cp   A, $ff
    ret  NZ                                            ; more than 256 above it
    ld   A, L
    cp   A, $f4
    ret  C                                             ; more than 12 above it
    call call_00_075b_Player_IsInvincible
    ret  NZ
    call call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   A, PLAYER_DAMAGE_COOLDOWN_LENGTH
    ld   [wD750_Player_DamageCooldownTimer], A
    ld   A, PLAYER_ACTION_COLLAPSE
    FARCALL call_02_4ccd_Player_RequestAction
    ret
.jr_03_4e7f_CollisionHandler_Hunter:
; ENTITY_TOON_TV_HUNTER, which takes three hits. MISC_TIMER_1 is the hit counter -
; the patrol action loads it with 3 on the hunter's first frame - and MISC_FLAGS
; bit 0 is the "knocked down" latch.
;
; While bit 0 is set nothing registers at all, so the four-action knockdown chain
; in bank 2 doubles as invulnerability frames; Hunter_GetUp clears it.
;
; Touch hurts. An attack or a stomp takes one off the counter: above zero it just
; raises bit 0 and lets the hunter fall over, and at zero it bursts him instead
; and bumps wD773_HuntersDefeatedCount. The second hunter beaten in a level writes
; $02 into wD799_BlockPatch_SlotTable14, triggering that tile region and opening
; the way onward
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    ret  nz                                            ; already down - invulnerable
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    call call_00_3817_Entity_DecrementMiscTimer        ; one hit off the counter
    jr   z,.jr_03_4EA3
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]                         ; knock him down
    ret
.jr_03_4EA3:
    call call_00_3985_Entity_ParticleBurstInit
    ld   hl,wD773_HuntersDefeatedCount
    inc  [hl]
    ld   a,[hl]
    cp   a,$02
    ret  nz
    ld   hl,wD799_BlockPatch_SlotTable14
    ld   [hl],$02                                      ; trigger the block patch
    ret
.jr_03_4eb4_CollisionHandler_Mushroom:
; ENTITY_TOON_TV_MUSHROOM, which is ENTITY_INTERACT_ATTACK | ENTITY_INTERACT_STOMP
; and so cannot hurt Gex. Walking into it does nothing; hitting it raises
; MISC_FLAGS bit 0, which is all call_02_5a28_EntityAction_Mushroom_Update is
; waiting for - it pops out a prize and bumps wD774_MushroomsDestroyedCount
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_4ec6_CollisionHandler_None2:
; Dead row - no entity type is ever given COLLISION_TYPE_NONE_2
    ret
.jr_03_4ec7_CollisionHandler_MultiProjectile:
; The floating skull's spray and the fire plant's, both of which put several shots
; in the air out of one entity slot. Like the collectible handler this walks the
; entity's particle buffer, but it does NOT run the shared box test first - every
; live record is tested from cold, with no cheap reject.
;
; Two more differences from the collectible loop: liveness is PARTICLE_ALIVE_BIT
; rather than PARTICLE_VISIBLE_BIT, and the Y offset is SUBTRACTED from the base
; instead of added, because these particles travel upward from the muzzle. The
; window is 8 wide by 12 tall, biased $04 across and $08 down from the entity's
; own screen position.
;
; The first match damages Gex and returns; the rest of the spray is not examined
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ldi  a,[hl]
    add  a,$04
    ld   c,a                                           ; C = screen X + 4
    ld   a,[hl]
    add  a,$08
    ld   b,a                                           ; B = screen Y + 8
    call call_00_39f5_Entity_GetParticlesPtr
    ld   l,e
    ld   h,d
    ld   a,ENTITY_PARTICLE_COUNT
.jr_03_4EDE:
    push af
    push bc
    push hl
    ldi  a,[hl]                                        ; PARTICLE_FIELD_FLAGS
    bit  PARTICLE_ALIVE_BIT,a
    jr   z,.jr_03_4F03
    inc  hl                                            ; -> PARTICLE_FIELD_YOFFSET
    ld   a,b
    sub  [hl]
    inc  hl
    ld   b,a                                           ; B = this shot's screen Y
    ld   a,[wD213_Player_ScreenYPosition]
    sub  b
    add  a,$06
    cp   a,$0C                                         ; 12 tall
    jr   nc,.jr_03_4F03
    inc  hl                                            ; -> PARTICLE_FIELD_XOFFSET
    ldi  a,[hl]
    add  c
    ld   c,a                                           ; C = this shot's screen X
    ld   a,[wD212_Player_ScreenXPosition]
    sub  c
    add  a,$04
    cp   a,$08                                         ; 8 wide
    jr   c,.jr_03_4F0E
.jr_03_4F03:
    pop  hl
    ld   bc,ENTITY_PARTICLE_RECORD_SIZE
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
; The two kung fu theatre jars, which are ENTITY_INTERACT_ATTACK only - they
; cannot be stomped and they cannot hurt Gex. A tail whip writes 1 into
; MISC_TIMER_1, and call_02_635d_EntityAction_Jar_Intact does nothing but wait for
; that byte to go non-zero before shattering
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_ATTACKED_ENTITY
    ret  nz
    ld   c,$01
    jp   call_00_3802_Entity_SetMiscTimer
.jr_03_4f20_CollisionHandler_Ninja:
; Both kung fu theatre ninjas. Two hitboxes, tested in order.
;
; FIRST the sword, which the shared box test knows nothing about. It exists only
; in the slash action ($01) past frame 2 of the animation, and in the jumping
; ninja's leap ($03), where it is live from the first frame - actions $00 (the
; decision tree) and $02 (throw) have none. The box is 12 wide by 32 tall, centred
; $10 pixels in front of the ninja and mirrored when FACING_LEFT is set. Landing
; in it damages Gex directly, without going near the shared test.
;
; OTHERWISE the ordinary test. Touch hurts. An attack or a stomp first spends a
; hit off MISC_TIMER_2, the ninja's extra-hits count, which comes from the level
; entity list through SPAWN_PARAM_TO_TIMER_2 - every placed ninja in the shipped
; levels has it at 0, so in practice they die on the first hit.
;
; The last thing a dying ninja does is look itself up in .data_03_4fbd: three
; specific (level, entity list entry) pairs open a block patch slot when that one
; ninja is beaten. Everything else just bursts
    push de                                            ; keep the collision box
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,ENTITY_ACTION_MASK
    cp   a,$00                                         ; ground / decision tree
    jr   z,.jr_03_4F6F
    cp   a,$02                                         ; throwing a shuriken
    jr   z,.jr_03_4F6F
    cp   a,$03                                         ; leaping - sword always out
    jr   z,.jr_03_4F43
    push hl
    ld   a,l
    xor  a,$06                                         ; $01 -> $07 ANIM_FRAME_INDEX
    ld   l,a
    ld   a,[hl]
    pop  hl
    cp   a,$02
    jr   c,.jr_03_4F6F                                 ; swing has not landed yet
.jr_03_4F43:
    ld   a,l
    xor  a,$13                                         ; $01 -> $12 SCREEN_X
    ld   l,a
    ld   e,[hl]
    inc  l                                             ; $13 SCREEN_Y
    ld   c,[hl]
    xor  a,$1F                                         ; $12 -> $0D FACING_FLAGS
    ld   l,a
    ld   a,e
    add  a,$10                                         ; sword reaches $10 ahead
    bit  FACING_LEFT_BIT,[hl]
    jr   z,.jr_03_4F56
    sub  a,$20                                         ; mirrored
.jr_03_4F56:
    ld   e,a                                           ; E = sword centre X
    ld   a,[wD213_Player_ScreenYPosition]
    sub  c
    add  a,$10
    cp   a,$20                                         ; 32 tall
    jr   nc,.jr_03_4F6F
    ld   a,[wD212_Player_ScreenXPosition]
    sub  e
    add  a,$06
    cp   a,$0C                                         ; 12 wide
    jr   nc,.jr_03_4F6F
    pop  de
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_4F6F:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[hl]
    and  a
    jr   z,.jr_03_4F87
    dec  [hl]                                          ; soak one hit
    ret
.jr_03_4F87:
    ld   a,[wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca                                               ; slot base / $20 = slot index
    ld   e,a
    ld   d,$00
    ld   hl,wD301_EntityListIndexesForCurrentEntities
    add  hl,de
    ld   c,[hl]                                        ; C = list entry number (1-based)
    ld   hl,.data_03_4fbd
    ld   de,$0003
.jr_03_4F9B:
    ld   a,[wD624_CurrentLevelId]
    cp   [hl]
    jr   nz,.jr_03_4FA7
    inc  hl
    ld   a,c
    cp   [hl]
    jr   z,.jr_03_4FB0                                 ; this exact ninja
    dec  hl
.jr_03_4FA7:
    add  hl,de                                         ; next row
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_03_4F9B
    jp   call_00_3985_Entity_ParticleBurstInit         ; an ordinary ninja
.jr_03_4FB0:
    inc  hl                                            ; third byte = slot index
    ld   l,[hl]
    ld   h,$00
    ld   de,wD78B_BlockPatch_SlotTable
    add  hl,de
    ld   [hl],$02                                      ; trigger that block patch
    jp   call_00_3985_Entity_ParticleBurstInit
.data_03_4fbd:
; (level id, entity list entry, block patch slot) triples, $FF terminated. Three
; named ninjas are gates: beating that one ninja in that one level opens the block
; patch slot named in the third column
    db   $0d, $07, $08, $05, $05, $00, $05, $06
    db   $08, $ff
.jr_03_4fc7_CollisionHandler_HangingBlade:
; ENTITY_KUNG_FU_THEATER_HANGING_BLADE. Both halves of a blade that swings down:
; the falling-hazard crush test while it is descending, then plain touch damage
; regardless. DE is saved across the first call because the crush handler
; destroys it
    push de
    call .jr_03_4e20_CollisionHandler_FallingHazard
    pop  de
    jp   .jr_03_4d82_CollisionHandler_TouchDamage
.jr_03_4fcf_CollisionHandler_LaunchPad:
; Dead row - nothing in the game carries COLLISION_TYPE_LAUNCH_PAD.
;
; Had it shipped it would do nothing but overwrite the jump velocity, with the
; largest value in the game: compare PLAYER_JUMP_VELOCITY $2A and the geyser's
; $50. No damage and no state change, so touching it would simply throw Gex upward
; the next time he left the ground
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   a,PLAYER_LAUNCH_PAD_VELOCITY
    ld   [wD758_JumpVelocityOverride],a
    ret
.jr_03_4fd9_CollisionHandler_SamuraiBody:
; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY, and structurally the ninja handler again
; with different numbers. The sword is live only in the slash action ($01) past
; frame 2, and its box is 8 wide by 32 tall centred $0E in front, mirrored on
; FACING_LEFT.
;
; The ordinary path is simpler than the ninja's: touch hurts, and any hit just
; raises MISC_FLAGS bit 0. The body needs no hit counter because it does not die
; here - losing its head is what kills it, and
; call_02_624c_EntityAction_SamuraiBody_Walk is what launches the head off when it
; sees this bit
    push de
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,ENTITY_ACTION_MASK
    cp   a,$01                                         ; slashing?
    jr   nz,.jr_03_5020
    push hl
    ld   a,l
    xor  a,$06                                         ; $01 -> $07 ANIM_FRAME_INDEX
    ld   l,a
    ld   a,[hl]
    pop  hl
    cp   a,$02
    jr   c,.jr_03_5020                                 ; swing has not landed yet
    ld   a,l
    xor  a,$13                                         ; $01 -> $12 SCREEN_X
    ld   l,a
    ld   e,[hl]
    inc  l                                             ; $13 SCREEN_Y
    ld   c,[hl]
    xor  a,$1F                                         ; $12 -> $0D FACING_FLAGS
    ld   l,a
    ld   a,e
    add  a,$0E                                         ; sword reaches $0E ahead
    bit  FACING_LEFT_BIT,[hl]
    jr   z,.jr_03_5007
    sub  a,$1C                                         ; mirrored
.jr_03_5007:
    ld   e,a                                           ; E = sword centre X
    ld   a,[wD213_Player_ScreenYPosition]
    sub  c
    add  a,$10
    cp   a,$20                                         ; 32 tall
    jr   nc,.jr_03_5020
    ld   a,[wD212_Player_ScreenXPosition]
    sub  e
    add  a,$04
    cp   a,$08                                         ; 8 wide
    jr   nc,.jr_03_5020
    pop  de
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_5020:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]                         ; drop the head
    ret
.jr_03_5035_CollisionHandler_SamuraiHead:
; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD once it has been launched off the body -
; call_02_62fc_EntityAction_SamuraiHead_Launched is what gives the head this
; collision type. Touch hurts; any hit raises MISC_FLAGS bit 0, and the head's own
; action turns that into the burst that also kills the body
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_5049_CollisionHandler_Geyser:
; The pre-history geyser and ENTITY_UNK_35. Like the launch pad it does no damage
; and no state change - it only overwrites wD758_JumpVelocityOverride, and
; call_02_4939_Player_UpdateMain clears that again at the end of the frame.
;
; It runs NO overlap test at all: reaching this handler already means the geyser
; is on screen, so an erupting geyser anywhere in view launches Gex on his next
; jump wherever he happens to be standing
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,ENTITY_ACTION_MASK
    cp   a,$01                                         ; erupting
    ret  nz
    ld   a,PLAYER_GEYSER_VELOCITY
    ld   [wD758_JumpVelocityOverride],a
    ret
.jr_03_505d_CollisionHandler_Triceratops:
; ENTITY_PRE_HISTORY_TRICERATOPS. The horn is checked first, as its own 12 by 12
; box centred $14 in front of the body and mirrored on FACING_LEFT; being in it
; damages Gex directly.
;
; Otherwise the ordinary test: touch hurts, and a hit bursts the body. Before it
; does, it sweeps the NPC slots and writes ENTITY_ID_NONE over every
; ENTITY_PRE_HISTORY_TRICERATOPS_HORN it finds, so the separate horn entity does
; not outlive the animal. The sweep does not stop at the first match, and it does
; not go through Entity_ClearSlot, so the horn's list entry is left as it was
    push de
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ld   e,[hl]
    inc  l                                             ; $13 SCREEN_Y
    ld   c,[hl]
    xor  a,$1F                                         ; $12 -> $0D FACING_FLAGS
    ld   l,a
    ld   a,e
    add  a,$14                                         ; horn reaches $14 ahead
    bit  FACING_LEFT_BIT,[hl]
    jr   z,.jr_03_5075
    sub  a,$28                                         ; mirrored
.jr_03_5075:
    ld   e,a                                           ; E = horn centre X
    ld   a,[wD213_Player_ScreenYPosition]
    sub  c
    add  a,$06
    cp   a,$0C                                         ; 12 tall
    jr   nc,.jr_03_508E
    ld   a,[wD212_Player_ScreenXPosition]
    sub  e
    add  a,$06
    cp   a,$0C                                         ; 12 wide
    jr   nc,.jr_03_508E
    pop  de
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_508E:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   h,HIGH(wD200_EntityMemory)
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_03_509C:
    ld   l,a
    ld   a,[hl]                                        ; ENTITY_FIELD_ENTITY_ID
    cp   a,ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    jr   nz,.jr_03_50A4
    ld   [hl],ENTITY_ID_NONE                           ; free the horn's slot
.jr_03_50A4:
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_03_509C
    jp   call_00_3985_Entity_ParticleBurstInit
.jr_03_50ac_CollisionHandler_Gear:
; ENTITY_REZOPOLIS_TAILSPIN_GEAR, which is ENTITY_INTERACT_ATTACK only.
;
; This is the one handler that acts on a MISS as well as a hit: MISC_FLAGS bit 0
; is set only while Gex is overlapping the gear AND tail spinning, and cleared on
; every other frame. It is a live "he is on it right now" signal rather than a
; latch, which is what lets call_02_65e2_TailSpinGear_SelectSpeed ramp the gear up
; while he holds it and spin back down the moment he stops
    call call_03_519b_Entity_CheckPlayerInteraction
    push af
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    pop  af
    jr   nc,.jr_03_50C2                                ; no overlap
    cp   a,PLAYER_ATTACKED_ENTITY
    jr   nz,.jr_03_50C2                                ; overlapping but not spinning
    set  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_50C2:
    res  MISC_FLAGS_BIT_0,[hl]
    ret
.jr_03_50c5_CollisionHandler_ElectricBall:
; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL. Action $00 is
; call_02_6786_EntityAction_ElectricBall_WaitForCue, where the ball is parked and
; drawn SPRITE_FLAG_INVISIBLE, so it is harmless there. In action $01, flying its
; route, it falls through to plain touch damage
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,ENTITY_ACTION_MASK
    cp   a,$00                                         ; waiting, and invisible
    jp   nz,.jr_03_4d82_CollisionHandler_TouchDamage
    ret
.jr_03_50d6_CollisionHandler_GunProjectile:
; The channel Z gun shots, once call_02_6bcd_GunProjectile_Fire has given them
; this collision type. Hitting Gex both hurts him and raises MISC_FLAGS bit 7,
; which the shot's own action reads as "I have been spent" and turns into its
; explosion
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_7,[hl]
    jp   call_03_52be_Entity_DamagePlayerIfVulnerable
.jr_03_50e7_CollisionHandler_Rocket:
; ENTITY_TOON_TV_ROCKET, the ride at the end of the channel. Walking into it is
; not enough: the wD755_FlyPowerup2_TimerLo/Hi pair has to be running, so Gex must
; be carrying the second shield fly before the rocket will take him. With that
; satisfied it raises MISC_FLAGS bit 7 - the ignition signal
; call_02_5be2_EntityAction_Rocket_Idle waits for - and puts Gex into
; PLAYER_ACTION_RIDING_ROCKET, which is what keeps him aboard
    ld   hl,wD755_FlyPowerup2_TimerLo
    ldi  a,[hl]
    or   [hl]
    ret  z                                             ; no shield fly, no ride
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_7,[hl]                         ; ignite
    ld   a,PLAYER_ACTION_RIDING_ROCKET
    FARCALL call_02_4ccd_Player_RequestAction
    ret
.jr_03_5109_CollisionHandler_Cannon:
; ENTITY_KUNG_FU_THEATER_CANNON, which is ENTITY_INTERACT_STOMP only - it can
; neither hurt Gex nor be whipped.
;
; It refuses to fire while its previous shot is still in the air, which it checks
; by sweeping the NPC slots for an ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE.
; Otherwise a stomp raises MISC_FLAGS bit 7 and the cannon's action spawns the
; shot
    ld   h,HIGH(wD200_EntityMemory)
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_03_510D:
    ld   l,a
    ld   a,[hl]                                        ; ENTITY_FIELD_ENTITY_ID
    cp   a,ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    ret  z                                             ; a shot is already out
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_03_510D
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_STOMPED_ENTITY
    ret  nz
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_7,[hl]                         ; fire
    ret
.jr_03_5129_CollisionHandler_PoweredWalkway:
; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY, and the only producer of conveyor power
; in the game.
;
; Standing on the walkway does nothing unless Gex's Circuit Central power-up is
; still running (wD751_Player_CircuitPowerUpTimerLo/Hi non-zero). With it running,
; MISC_TIMER_2 - the belt number this walkway serves, a 1-based spawn parameter -
; indexes wD5A3_ConveyorPowerTimer1 and that slot is recharged to $06. The sound
; only plays on the transition from empty, so holding the walkway down keeps the
; belt fed silently
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD751_Player_CircuitPowerUpTimerLo
    ldi  a,[hl]
    or   [hl]
    ret  z                                             ; power-up has run out
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   l,[hl]
    dec  l                                             ; belt number is 1-based
    ld   h,$00
    ld   de,wD5A3_ConveyorPowerTimer1
    add  hl,de
    ld   a,[hl]
    ld   [hl],$06                                      ; recharge the belt
    and  a
    ret  nz                                            ; it was already running
    ld   c,SFX_POWERED_WALKWAY
    call call_00_112f_QueueSFX
    ret
.jr_03_514e_CollisionHandler_PowerUp:
; ENTITY_CIRCUIT_CENTRAL_POWER_UP. Copies the entity's MISC_TIMER_2 and MISC_PARAM
; - a 16-bit duration supplied per instance by the level's entity list through
; SPAWN_PARAM_TO_TIMER_2 | SPAWN_PARAM_TO_MISC_PARAM - into
; wD751_Player_CircuitPowerUpTimerLo/Hi, starting the countdown that the powered
; walkway and the powered platform both test.
;
; It neither frees the slot nor marks the list entry, so the power-up is still
; there afterwards and simply re-arms the timer on every frame of contact
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ldi  a,[hl]
    ld   [wD751_Player_CircuitPowerUpTimerLo],a
    ld   a,[hl]                                        ; $1A MISC_PARAM
    ld   [wD752_Player_CircuitPowerUpTimerHi],a
    ret
.jr_03_5163_CollisionHandler_DragonProjectile:
; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE. Any contact hurts and consumes the
; shot. It uses Entity_ClearSlot rather than Entity_DeactivateSelf, so the list
; entry goes back to ENTITY_LIST_FLAG_ABSENT and the dragon is free to breathe
; again
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    call call_03_52be_Entity_DamagePlayerIfVulnerable
    jp   call_00_3910_Entity_ClearSlot
.jr_03_516d_CollisionHandler_Rez:
; ENTITY_CHANNEL_Z_REZ, the final boss. Which of his eleven actions he is in
; decides everything:
;
;   $00-$03  intro, chase, recover - touch hurts, and an attack puts him into
;            action $04
;   $04      Rez_Hit, the reaction to that attack - no collision at all, which is
;            his invulnerability window
;   $05-$0A  untouchable. The second half of the fight is scored by slamming the
;            buttons rather than by attacking him, so the handler ignores him
;
; The `cp $09` / `cp $0A` pair below is redundant: every path out of .jr_03_5194
; returns anyway, so testing for those two actions changes nothing
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,ENTITY_ACTION_MASK
    cp   a,$04
    ret  z                                             ; recovering from a hit
    jr   nc,.jr_03_5194                                ; $05 and up - untouchable
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,PLAYER_TOUCHED_ENTITY
    jp   z,call_03_52be_Entity_DamagePlayerIfVulnerable
    ld   a,$04                                         ; Rez_Hit
    FARCALL call_02_7102_Entity_SetAction
    ret
.jr_03_5194:
    cp   a,$09                                         ; button hit - no effect
    ret  z
    cp   a,$0A                                         ; unused action - no effect
    ret  z
    ret

call_03_519b_Entity_CheckPlayerInteraction:
; The shared box test, called by nearly every handler as its first act. Entered
; with E = collision half width and D = collision half height; both are consumed.
;
; Returns carry clear when there is no contact. On contact it returns carry set
; and, in A, *how* Gex made it - which is what lets one handler treat being walked
; into and being jumped on as completely different events:
;
;   PLAYER_TOUCHED_ENTITY   ($00) he ran into it
;   PLAYER_ATTACKED_ENTITY  ($01) he was tail spinning or karate kicking
;   PLAYER_STOMPED_ENTITY   ($02) he landed on it from above
;
; The order of the tests matters as much as the tests themselves:
;
;   1. A LOOSE box first: |dy| < half height, and |dx| < half width + 8, the 8
;      being Gex's own half width. Failing this is the only "no contact" answer.
;   2. INVINCIBILITY. If either fly shield timer is running the answer is
;      immediately ATTACK, whatever the entity's flags say and whatever Gex is
;      doing - a shield fly kills on contact, and at the loose box's range.
;   3. ATTACK, if ENTITY_INTERACT_ATTACK is set and Gex is in
;      PLAYER_ACTION_TAIL_SPIN, PLAYER_ACTION_KARATE_KICK, or one of the two
;      climbing tail spins. Note CLIMB_STATE_ALT_WALL_TAIL_SPIN ($05) is not in
;      the list, so a tail spin on an alt wall does not connect.
;   4. A TIGHT box, reached only when no attack registered: |dx| < half width,
;      with Gex's 8 pixels taken back off. An attack therefore has 8 pixels more
;      reach on each side than a touch or a stomp does.
;   5. STOMP, if ENTITY_INTERACT_STOMP is set, Gex is in PLAYER_ACTION_JUMP or
;      PLAYER_ACTION_DOUBLE_JUMP, and his Y velocity is downward. This is also
;      where the bounce happens - it rewrites wD760_PlayerYVelocity to
;      PLAYER_JUMP_VELOCITY itself, so no handler has to.
;   6. Otherwise TOUCH.
;
; ENTITY_INTERACT_TOUCH (bit 0) is never tested, here or anywhere else - it is
; documentation only. An entity without it still gets PLAYER_TOUCHED_ENTITY
; reported; whether that hurts is up to its handler.
;
; The odd `ld A,$FF / add A,n` endings load the result and set carry in two
; instructions, at the cost of the operand reading one higher than the value
; actually returned
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ENTITY_ID
    ld   L, [HL]
    ld   H, $00
    ld   BC, .data_03_522e_EntityInteractionFlagsTable
    add  HL, BC
    ld   B, [HL]                                       ; B = ENTITY_INTERACT_* flags
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_Y
    ld   A, E
    add  A, $08
    ld   E, A                                          ; E = half width + Gex's 8
    ld   A, [wD213_Player_ScreenYPosition]
    sub  A, [HL]
    add  A, D
    sla  D
    cp   A, D
    ret  NC                                            ; outside vertically
    dec  L                                             ; $12 SCREEN_X
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, [HL]
    add  A, E
    sla  E
    cp   A, E
    ret  NC                                            ; outside the loose box
    ld   C, A                                          ; C = dx + half width + 8
    ld   HL, wD753_FlyPowerup1_TimerLo
    ld   A, [HL+]
    or   A, [HL]
    jr   NZ, .jr_03_51f5                               ; shield fly - counts as an attack
    ld   HL, wD755_FlyPowerup2_TimerLo
    ld   A, [HL+]
    or   A, [HL]
    jr   NZ, .jr_03_51f5
    bit  ENTITY_INTERACT_ATTACK_BIT, B
    jr   Z, .jr_03_51fa
    ld   A, [wD201_Player_ActionId]
    and  A, PLAYER_ACTION_MASK
    cp   A, PLAYER_ACTION_TAIL_SPIN
    jr   Z, .jr_03_51f5
    cp   A, PLAYER_ACTION_KARATE_KICK
    jr   Z, .jr_03_51f5
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_BACKGROUND_TAIL_SPIN
    jr   Z, .jr_03_51f5
    cp   A, CLIMB_STATE_WALL_TAIL_SPIN
    jr   NZ, .jr_03_51fa
.jr_03_51f5:
    ld   A, $ff
    add  A, $02                                        ; PLAYER_ATTACKED_ENTITY, carry set
    ret
.jr_03_51fa:
    srl  E                                             ; back to half width + 8
    ld   A, C
    sub  A, E
    jr   NC, .jr_03_5202
    cpl
    inc  A
.jr_03_5202:
    ld   C, A                                          ; C = |dx|
    ld   A, E
    sub  A, $08
    ld   E, A                                          ; E = half width again
    ld   A, C
    cp   A, E
    ret  NC                                            ; outside the tight box
    bit  ENTITY_INTERACT_STOMP_BIT, B
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
    jr   Z, .jr_03_5229                                ; still rising - not a stomp
    ld   [HL], PLAYER_JUMP_VELOCITY                    ; bounce off it
    ld   A, $ff
    add  A, $03                                        ; PLAYER_STOMPED_ENTITY, carry set
    ret
.jr_03_5229:
    ld   A, $ff
    add  A, $01                                        ; PLAYER_TOUCHED_ENTITY, carry set
    ret
.data_03_522e_EntityInteractionFlagsTable:
; One flags byte per entity TYPE, in ENTITY_* order, saying which kinds of contact
; that type reacts to. Read only by call_03_519b_Entity_CheckPlayerInteraction:
;   bit 0 ($01) ENTITY_INTERACT_TOUCH  - never tested; documentation only
;   bit 1 ($02) ENTITY_INTERACT_ATTACK - a tail spin or karate kick connects
;   bit 2 ($04) ENTITY_INTERACT_STOMP  - landing on it connects, and bounces Gex
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
; The wrapper every damaging handler goes through: deal a hit unless
; Player_IsInvincible says otherwise (it returns NZ when Gex cannot be hurt).
;
; Player_TakeDamage repeats the same test as its own first instruction, so the
; guard here is strictly redundant - but it is also how the handlers that need
; the answer for themselves get it without inspecting three timers each
    call call_00_075b_Player_IsInvincible
    call Z, call_00_06bf_Player_TakeDamage
    ret

; ==================================================================
; PLATFORMS
;
; Everything below here bypasses call_03_519b_Entity_CheckPlayerInteraction. A
; platform does not "hit" Gex, it either carries him or blocks him, and which of
; those it is depends on the side he arrived from and how fast he was going.
;
; Between them the three handlers maintain Gex's platform links:
;   wD74D_Player_EntityStoodOnLo               the platform under his feet
;   wD74E_Player_PushedStationaryPlatformLo    a stationary one he is shoving
;   wD74F_Player_PushedMovingPlatformLo        a moving one he is shoving
;
; Each holds the low byte of an entity's slot address, and $00 means none.
; call_02_6eba_Entities_UpdateAll reads them to run those entities BEFORE Gex on
; the next frame, and call_02_4a77_Player_ApplyXMovement reads the pushed ones to
; constrain his walk. Every path through these routines ends by either claiming
; or releasing the links, so a platform that has scrolled out of contact clears
; itself.
;
; The vertical convention here is not the one the shared box test uses: these
; compare Gex's FEET (screen Y + $0F) against the platform's
; ENTITY_FIELD_SCREEN_Y, treating that as the top surface, and use
; ENTITY_FIELD_COLLISION_HEIGHT as the drop to its underside.
; ==================================================================

call_03_52c5_CollisionHandler_StationaryPlatform:
; Tv buttons, the scream tv falling platform, and everything else that holds
; still. Gex's feet decide which half of the routine runs:
;
;   feet above the platform top  -> Platform_LandingCheck, shared with the
;                                   one-way platform below
;   otherwise                    -> the side-push test that follows
;
; The push test first rejects anything sitting entirely above him, then works out
; which side he is on and how far outside the platform's full width he is. He
; counts as pushing only when that gap is smaller than this frame's walking step
; (wD75D_Player_XSpeedCurrent), or when both are zero and he is already flush
; against it. Standing still next to a platform therefore still counts as pushing
; it, while overlapping it does not - an overlap falls through to
; Platform_ClearPlayerInteraction
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_SCREEN_Y
    ld   A, [wD213_Player_ScreenYPosition]
    add  A, $0f                                        ; A = Gex's feet
    cp   A, [HL]
    jr   C, call_03_5314_Platform_LandingCheck         ; feet are above the top
    sub  A, $1f                                        ; A = Gex's head - $10
    ld   C, A
    ld   A, [HL]
    add  A, D                                          ; platform underside
    dec  A
    cp   A, C
    jr   C, call_03_534d_Platform_ClearPlayerInteraction ; entirely above him
    dec  L                                             ; $12 SCREEN_X
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, [HL]
    add  A, E                                          ; dx + half width
    bit  7, A
    jr   NZ, .jr_03_52f8                               ; Gex is off the left edge
    sla  E                                             ; full width
    sub  A, E                                          ; gap past the right edge
    jr   C, call_03_534d_Platform_ClearPlayerInteraction ; overlapping, not pushing
    ld   HL, wD75D_Player_XSpeedCurrent
    cp   A, [HL]
    jr   C, call_03_5360_Platform_SetPushInteraction   ; he would step into it
    or   A, [HL]
    jr   Z, call_03_5360_Platform_SetPushInteraction   ; flush, and standing still
    jr   call_03_534d_Platform_ClearPlayerInteraction
.jr_03_52f8:
    cpl                                                ; gap past the left edge
    ld   HL, wD75D_Player_XSpeedCurrent
    cp   A, [HL]
    jr   C, call_03_5360_Platform_SetPushInteraction
    or   A, [HL]
    jr   Z, call_03_5360_Platform_SetPushInteraction
    jr   call_03_534d_Platform_ClearPlayerInteraction

call_03_5304_CollisionHandler_OneWayPlatform:
; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR. The stationary platform with the
; side-push half removed: land on it from above and it carries you, approach from
; anywhere else and it is not there at all
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_SCREEN_Y
    ld   a,[wD213_Player_ScreenYPosition]
    add  a,$0F                                         ; Gex's feet
    cp   [hl]
    jr   nc,call_03_534d_Platform_ClearPlayerInteraction ; not above it
call_03_5314_Platform_LandingCheck:
; The shared "did he land on it" test. Entered with A = Gex's feet, HL pointing at
; the platform's ENTITY_FIELD_SCREEN_Y, and DE still holding the collision box.
;
; Horizontally he has to be inside the full width. Vertically it measures C, the
; gap between his feet and the platform top, and rejects a gap of $80 or more -
; that is a negative gap, meaning the top is already above his feet and he is
; inside or below the platform.
;
; The landing itself is predictive rather than positional: it adds this frame's
; fall step (Y velocity / 16, negative going down) to the gap. A negative sum
; means he would pass through the surface before the next frame, and a sum under
; $02 means he is within a pixel of it - either one counts as standing on it.
;
; On a landing it claims wD74D and releases wD74E if this same platform was being
; pushed, so Gex is never recorded as shoving something he is standing on
    ld   C, A
    dec  L                                             ; $12 SCREEN_X
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, [HL]
    add  A, E
    sla  E                                             ; full width
    cp   A, E
    jr   NC, call_03_534d_Platform_ClearPlayerInteraction
    inc  L                                             ; $13 SCREEN_Y
    inc  C
    ld   A, [HL]
    sub  A, C
    ld   C, A                                          ; C = gap under his feet
    cp   A, $80
    jr   NC, call_03_534d_Platform_ClearPlayerInteraction ; he is already below it
    ld   A, [wD760_PlayerYVelocity]
    sra  A
    sra  A
    sra  A
    sra  A                                             ; this frame's fall step
    add  A, C
    bit  7, A
    jr   NZ, .jr_03_533f                               ; would fall through it
    cp   A, $02
    jr   C, .jr_03_533f                                ; already resting on it
    jr   call_03_534d_Platform_ClearPlayerInteraction
.jr_03_533f:
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   [wD74D_Player_EntityStoodOnLo], A
    ld   HL, wD74E_Player_PushedStationaryPlatformLo
    cp   A, [HL]
    ret  NZ
    ld   [HL], $00                                     ; not pushing what he stands on
    ret

call_03_534d_Platform_ClearPlayerInteraction:
; No contact with this platform. Releases both stationary links, but only if they
; still name THIS entity - another platform may legitimately own them
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

call_03_5360_Platform_SetPushInteraction:
; Gex is walking into the side of this platform. Releases wD74D if he was standing
; on this same one, then claims wD74E - the link
; call_02_4a77_Player_ApplyXMovement uses to stop him walking through it, or to
; drag it along with him
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   NZ, .jr_03_536b
    ld   [HL], $00
.jr_03_536b:
    ld   [wD74E_Player_PushedStationaryPlatformLo], A
    ret

call_03_536f_CollisionHandler_MovingPlatform:
; The same two-branch shape as the stationary platform - land on top, or be pushed
; from the side - but with its own copies of both halves rather than sharing them,
; and writing wD74F_Player_PushedMovingPlatformLo where the stationary one writes
; wD74E.
;
; The real difference is that a moving platform closes the gap itself, so the side
; test cannot simply compare a distance against Gex's own speed. It calls
; call_03_5427_MovingPlatform_GetRelativeXSpeed to get the platform's step in B
; and Gex's in D and E, and asks whether the two together close the gap this
; frame.
;
; The landing half has a leftover in it: it loads the platform's
; ENTITY_FIELD_Y_VELOCITY into E and then immediately overwrites E with $10, so
; the landing tolerance is a constant 1 pixel and the platform's own vertical
; speed is not part of the test at all - see .jr_03_53ba below
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_SCREEN_Y
    ld   A, [wD213_Player_ScreenYPosition]
    add  A, $0f
    cp   A, [HL]
    jr   C, .jr_03_53ba_PlayerIsAbovePlatformOnScreen  ; jump if PlayerScreenY+0xF is above PlatformScreenY
    sub  A, $1f                                        ; A = PlayerScreenY - 0x10
    ld   C, A                                          ; C = PlayerScreenY - 0x10
    ld   A, [HL]                                       ; A = PlatformScreenY
    add  A, D                                          ; A = PlatformScreenY + PlatformHeight
    dec  A                                             ; A = PlatformScreenY + PlatformHeight - 1
    cp   A, C
    jr   C, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform ; platform is entirely above him
    dec  L                                             ; HL = ENTITY_FIELD_SCREEN_X (PlatformScreenX)
    ld   A, [wD212_Player_ScreenXPosition]             ; A = PlayerScreenX
    sub  A, [HL]                                       ; A = PlayerScreenX - PlatformScreenX
    add  A, E                                          ; A += PlatformWidth
    bit  7, A                                          ; jump if player is on left side of platform
    jr   NZ, .jr_03_53a8_PlayerIsLeftOfPlatform
    sla  E                                             ; E = 2*width
    sub  A, E                                          ; A = gap past the right edge
    jr   C, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform ; overlapping, not pushing
    ld   C, A
    call call_03_5427_MovingPlatform_GetRelativeXSpeed ; B = PlatformXVel/16, D/E = player's step
    ld   A, C                                          ; A = gap past the right edge
    sub  A, B                                          ; A -= PlatformXVel / 16
    add  A, E                                          ; A += PlayerXSpeed
    add  A, D                                          ; A += wD75C_PlayerXDeltaExtra
    bit  7, A
    jr   NZ, .jr_03_5418_PlayerIsBeingPushedByThisPlatform ; the gap closes this frame
    and  A, A
    jr   Z, .jr_03_5418_PlayerIsBeingPushedByThisPlatform  ; closes exactly
    jr   .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
.jr_03_53a8_PlayerIsLeftOfPlatform:
    cpl                                                ; A = BITNOT A (gap past the left edge)
    ld   C, A                                          ; C = BITNOT(PlayerScreenX - PlatformScreenX + PlatformWidth)
    call call_03_5427_MovingPlatform_GetRelativeXSpeed ; B = PlatformXVel/16, E = PlayerXSpeed, D = extra
    ld   A, C                                          ; A = gap past the left edge
    add  A, B                                          ; A += PlatformXVel / 16
    sub  A, E                                          ; A -= PlayerXSpeed
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
    ld   C, A                                          ; C = the gap under his feet
    cp   A, $80                                        ; $80 and up is a negative gap - he is below the top
    jr   NC, .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
    ld   A, [wD760_PlayerYVelocity]
    sra  A
    sra  A
    sra  A
    sra  A                                             ; this frame's fall step
    add  A, C
    ld   C, A
    ld   A, L
    xor  A, $0d                                        ; $13 -> $1E Y_VELOCITY
    ld   L, A
    ld   E, [HL]                                       ; dead load - overwritten below
    ld   E, $10
    sra  E
    sra  E
    sra  E
    sra  E                                             ; E = 1, a fixed tolerance
    ld   A, C
    sub  A, E
    bit  7, A
    jr   NZ, .jr_03_53f7_PlayerIsOnThisPlatform        ; would fall through it
    cp   A, $02
    jr   C, .jr_03_53f7_PlayerIsOnThisPlatform         ; already resting on it
    jr   .jr_03_5405_PlayerIsNotOnOrBeingPushedByThisPlatform
.jr_03_53f7_PlayerIsOnThisPlatform:
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   [wD74D_Player_EntityStoodOnLo], A
    ld   HL, wD74F_Player_PushedMovingPlatformLo
    cp   A, [HL]
    ret  NZ
    ld   [HL], $00                                     ; not pushing what he stands on
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
; Gathers the three numbers the moving platform's side test needs. Called with L
; pointing at ENTITY_FIELD_SCREEN_X, and it walks from there to X_VELOCITY.
;
;   B = the platform's ENTITY_FIELD_X_VELOCITY >> 4, its whole-pixel step
;   D = wD75C_PlayerXDeltaExtra, whatever else is carrying or shoving Gex
;   E = wD75D_Player_XSpeedCurrent, his own walking step, NEGATED when he is
;       facing left so that the caller can combine both sides of the closing
;       speed without caring about direction
    ld   A, L
    xor  A, $0e                                        ; $12 -> $1C X_VELOCITY
    ld   L, A
    ld   B, [HL]
    sra  B
    sra  B
    sra  B
    sra  B                                             ; B = whole pixels per frame
    ld   A, [wD75C_PlayerXDeltaExtra]
    ld   D, A                                          ; D = wD75C_PlayerXDeltaExtra
    ld   A, [wD75D_Player_XSpeedCurrent]
    ld   E, A                                          ; E = wD75D_Player_XSpeedCurrent
    ld   HL, wD20D_Player_FacingFlags
    bit  FACING_LEFT_BIT, [HL]
    ret  Z
    cpl
    inc  A
    ld   E, A                                          ; negated when facing left
    ret
