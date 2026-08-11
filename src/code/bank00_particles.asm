call_00_3951_Entity_SpawnEffectAtPlayer:
; This is the front door to the particle system for effects that have no
; enemy to be born from. It finds an empty entity slot, parks it on top of the
; player, and hands it to call_00_3985_Entity_ParticleBurstInit, which turns it
; into a PARTICLE_PATTERN_BURST just as it would for a dying enemy.
;
; Scans slots $D220, $D240 ... $D2E0 - the seven NPC slots; $D200 is the player -
; for one whose ENTITY_FIELD_ENTITY_ID is ENTITY_ID_NONE. If all seven are busy
; it returns having done nothing, so the effect is droppable under load.
;
; Into that slot it copies four bytes starting at wD20E_Player_XPositionLo: the
; player's 16-bit X then 16-bit Y. Position only - the particles carry their own
; motion in their records, so the host entity never moves.
;
; call_00_34d8_Entity_ResetEntityListIndex then stamps list index $00 on the slot,
; which is the "did not come from the level's entity list" marker; without it the
; slot would inherit whatever entry the previous occupant belonged to and
; ParticleBurstInit's respawn-blocking write would land on an innocent enemy.
;
; wD300_CurrentEntityAddrLo is saved and restored around the call, because every
; helper it uses operates on "the current entity"
    ld   h,HIGH(wD220_OtherLoadedEntities)
    ld   a,LOW(wD220_OtherLoadedEntities)
.jr_02_3955:
    ld   l,a
    ld   a,[hl]
    cp   a,$FF
    jr   z,.jr_02_3961
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_3955
    ret  
.jr_02_3961:
    ld   a,[wD300_CurrentEntityAddrLo]
    push af
    ld   a,l
    ld   [wD300_CurrentEntityAddrLo],a
    or   a,$0E
    ld   l,a
    ld   de,wD20E_Player_XPositionLo
    ld   a,[de]
    ldi  [hl],a
    inc  de
    ld   a,[de]
    ldi  [hl],a
    inc  de
    ld   a,[de]
    ldi  [hl],a
    inc  de
    ld   a,[de]
    ld   [hl],a
    call call_00_34d8_Entity_ResetEntityListIndex
    call call_00_3985_Entity_ParticleBurstInit
    pop  af
    ld   [wD300_CurrentEntityAddrLo],a
    ret  

call_00_3985_Entity_ParticleBurstInit:
; This is the particle system's constructor, and the only routine that ever
; starts PARTICLE_PATTERN_BURST. It rewrites the current entity in place into the
; burst effect, so the caller decides which entity dies:
;
;   - from call_00_3951_Entity_SpawnEffectAtPlayer the entity is a blank slot that
;     was just claimed, and the burst is a standalone puff at the player
;   - from the ~13 sites in bank02_entity_actions.asm and bank03_entity_collision.asm
;     the entity is a defeated enemy, which becomes its own death burst
;
; In order it sets: OAM attribute base $01 (CGB OBJ palette 1, the burst's palette),
; ENTITY_FIELD_COLLISION_TYPE = $00 so the effect can neither hit nor be hit,
; ENTITY_FIELD_ENTITY_ID = $07 - the write that claims the slot, since ENTITY_ID_NONE
; means free - then MISC_FLAGS and FACING_FLAGS cleared, PARTICLE_PATTERN_BURST
; started via call_00_3a23_Entity_StartParticleEffect, the list entry marked
; never-respawn, action 0, and SFX_ENEMY_DEFEATED queued. The sound is queued
; unconditionally, which is why the player-side puff also sounds like a kill.
;
; The field walk is a chain of XORs on L rather than fresh loads, and it is
; CUMULATIVE: starting from $16, `xor $16` lands on $00, then `xor $17` on $17,
; then `xor $1a` on $17 xor $1a = $0D. So the last write is FACING_FLAGS ($0D),
; not MISC_PARAM ($1A) as the operand suggests at a glance
    ld   C, $01                                        ;; 00:3985 $0e $01
    call call_00_37e7_Entity_SetOamAttrBase                                  ;; 00:3987 $cd $e7 $37
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_COLLISION_TYPE
    ld   [HL], $00                                     ;; 00:3992 $36 $00
    ld   A, L                                          ;; 00:3994 $7d
    xor  A, $16                                        ;; 00:3995 $ee $16
    ld   L, A                                          ;; 00:3997 $6f
    ld   [HL], $07                                     ;; 00:3998 $36 $07
    ld   A, L                                          ;; 00:399a $7d
    xor  A, $17                                        ;; 00:399b $ee $17
    ld   L, A                                          ;; 00:399d $6f
    ld   [HL], $00                                     ;; 00:399e $36 $00
    ld   A, L                                          ;; 00:39a0 $7d
    xor  A, $1a                                        ;; 00:39a1 $ee $1a
    ld   L, A                                          ;; 00:39a3 $6f
    ld   [HL], $00                                     ;; 00:39a4 $36 $00
    ld   C, PARTICLE_PATTERN_BURST                     ;; 00:39a6 $0e $01
    call call_00_3a23_Entity_StartParticleEffect                                  ;; 00:39a8 $cd $23 $3a
    call call_00_393c_Entity_MarkNeverRespawn                                  ;; 00:39ab $cd $3c $39
    xor  A, A                                          ;; 00:39ae $af
    FARCALL call_02_7102_Entity_SetAction
    ld   C, SFX_ENEMY_DEFEATED                                        ;; 00:39ba $0e $17
    call call_00_112f_QueueSFX                                  ;; 00:39bc $cd $2f $11
    ret                                                ;; 00:39bf $c9

; ==================================================================
; ENTITY PARTICLE EFFECTS
;
; Some entities are not one sprite but a little swarm - a smashed jar's shards, the
; sparkle when a collectible is taken, a boulder breaking up. Those all run on one
; shared mechanism, and these buffers are its state.
;
; Every entity SLOT (0-7) owns two fixed WRAM blocks:
;
;   PARTICLES    ENTITY_PARTICLES_SIZE bytes = ENTITY_PARTICLE_COUNT records of
;                ENTITY_PARTICLE_RECORD_SIZE. The simulation: each record is one
;                particle's position and velocity. Started from a ROM pattern by
;                call_00_3a23_Entity_StartParticleEffect, advanced once a frame by
;                call_00_3b8d_Entity_TickParticles, and read by the per-effect sprite
;                builders in bank 3 - and by the entity collision code, which gives
;                each particle its own hitbox so individual shards can hit the player.
;
;   SPRITE LIST  ENTITY_SPRITE_LIST_SIZE bytes = a count followed by up to
;                ENTITY_PARTICLE_COUNT OAM records of ENTITY_SPRITE_RECORD_SIZE
;                (Y, X, tile, attributes). The OUTPUT: a sprite builder walks the
;                particles and writes this, then the generic embedded-data path at
;                .jp_03_6451_Entity_BuildSprites_SpriteList copies it into shadow OAM.
;                SPRITE_FLAG_EMBEDDED_DATA on the entity is what selects that path.
;
; So the two blocks are the two halves of one pipeline - simulation in, sprites out -
; which is all the old "primary data" and "secondary data" names were distinguishing.
; ==================================================================

; The two blocks for all 8 slots, interleaved as (sprite list, particles) pairs so one
; index reaches both. data_00_39c2_EntityParticleBuffers is not a separate table: it is
; this one plus 2, which is how the particle-only accessor skips the sprite list word
data_00_39c0_EntityEffectBuffers:
    dw   wD33C_Entity_SpriteList0
data_00_39c2_EntityParticleBuffers:
    dw   wD444_Entity_Particles0, wD35D_Entity_SpriteList1, wD46C_Entity_Particles1
    dw   wD37E_Entity_SpriteList2, wD494_Entity_Particles2, wD39F_Entity_SpriteList3, wD4BC_Entity_Particles3
    dw   wD3C0_Entity_SpriteList4, wD4E4_Entity_Particles4, wD3E1_Entity_SpriteList5, wD50C_Entity_Particles5
    dw   wD402_Entity_SpriteList6, wD534_Entity_Particles6, wD423_Entity_SpriteList7, wD55C_Entity_Particles7

call_00_39e0_Entity_GetSpriteListPtr:
; DE = this entity's sprite list buffer - the count byte, followed by up to
; ENTITY_PARTICLE_COUNT OAM records that the embedded-data sprite path will draw.
;
; The slot number is recovered from wD300_CurrentEntityAddrLo rather than stored: the
; three `rlca` rotate the entity struct's address bits down so that (addr >> 5) & 7
; falls out, which works because the 8 entity structs are $20 bytes apart. The same
; five instructions open all four routines here
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:39e0 $fa $00 $d3
    rlca                                               ;; 00:39e3 $07
    rlca                                               ;; 00:39e4 $07
    rlca                                               ;; 00:39e5 $07
    and  A, $07                                        ;; 00:39e6 $e6 $07
    ld   L, A                                          ;; 00:39e8 $6f
    ld   H, $00                                        ;; 00:39e9 $26 $00
    add  HL, HL                                        ;; 00:39eb $29
    add  HL, HL                                        ;; 00:39ec $29
    ld   DE, data_00_39c0_EntityEffectBuffers                                     ;; 00:39ed $11 $c0 $39
    add  HL, DE                                        ;; 00:39f0 $19
    ld   E, [HL]                                       ;; 00:39f1 $5e
    inc  HL                                            ;; 00:39f2 $23
    ld   D, [HL]                                       ;; 00:39f3 $56
    ret                                                ;; 00:39f4 $c9

call_00_39f5_Entity_GetParticlesPtr:
; DE = this entity's particle buffer - ENTITY_PARTICLE_COUNT records of
; ENTITY_PARTICLE_RECORD_SIZE. Identical to the routine above apart from starting the
; table lookup two bytes further in, which lands on the particle word of the pair
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:39f5 $fa $00 $d3
    rlca                                               ;; 00:39f8 $07
    rlca                                               ;; 00:39f9 $07
    rlca                                               ;; 00:39fa $07
    and  A, $07                                        ;; 00:39fb $e6 $07
    ld   L, A                                          ;; 00:39fd $6f
    ld   H, $00                                        ;; 00:39fe $26 $00
    add  HL, HL                                        ;; 00:3a00 $29
    add  HL, HL                                        ;; 00:3a01 $29
    ld   DE, data_00_39c2_EntityParticleBuffers                                     ;; 00:3a02 $11 $c2 $39
    add  HL, DE                                        ;; 00:3a05 $19
    ld   E, [HL]                                       ;; 00:3a06 $5e
    inc  HL                                            ;; 00:3a07 $23
    ld   D, [HL]                                       ;; 00:3a08 $56
    ret                                                ;; 00:3a09 $c9

call_00_3a0a_Entity_GetSpriteListAndParticles:
; DE = sprite list, HL = particles. Both in one lookup, because the two words sit
; next to each other in the table.
;
; This is the entry point every per-effect sprite builder uses, and the register
; assignment matches how they all work: read a particle from HL, write an OAM record
; to DE. They typically `push DE` first so they can come back at the end and store the
; sprite count into the first byte
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3a0a $fa $00 $d3
    rlca                                               ;; 00:3a0d $07
    rlca                                               ;; 00:3a0e $07
    rlca                                               ;; 00:3a0f $07
    and  A, $07                                        ;; 00:3a10 $e6 $07
    ld   L, A                                          ;; 00:3a12 $6f
    ld   H, $00                                        ;; 00:3a13 $26 $00
    add  HL, HL                                        ;; 00:3a15 $29
    add  HL, HL                                        ;; 00:3a16 $29
    ld   DE, data_00_39c0_EntityEffectBuffers                                     ;; 00:3a17 $11 $c0 $39
    add  HL, DE                                        ;; 00:3a1a $19
    ld   E, [HL]                                       ;; 00:3a1b $5e
    inc  HL                                            ;; 00:3a1c $23
    ld   D, [HL]                                       ;; 00:3a1d $56
    inc  HL                                            ;; 00:3a1e $23
    ld   A, [HL+]                                      ;; 00:3a1f $2a
    ld   H, [HL]                                       ;; 00:3a20 $66
    ld   L, A                                          ;; 00:3a21 $6f
    ret                                                ;; 00:3a22 $c9

call_00_3a23_Entity_StartParticleEffect:
; Arms this entity's particle swarm. C selects a PARTICLE_PATTERN_* from
; .data_00_3a67_ParticlePatterns, and the whole pattern - every particle's starting
; position and velocity - is copied into the entity's particle buffer.
;
; Three things happen, and the order matters:
;   1. the sprite list's count byte is zeroed, so nothing is drawn until
;      call_00_3b8d_Entity_TickParticles has run and a builder has filled it in
;   2. the ROM pattern is copied over the particle buffer wholesale
;   3. SPRITE_FLAG_EMBEDDED_DATA is set, switching this entity to the sprite path that
;      reads the list rather than a shared animation table
;
; After this the entity's action handler just calls Entity_TickParticles each frame and
; ends the effect when it returns zero
    ld   L, C                                          ;; 00:3a23 $69
    ld   H, $00                                        ;; 00:3a24 $26 $00
    add  HL, HL                                        ;; 00:3a26 $29
    ld   DE, .data_00_3a67_ParticlePatterns                                     ;; 00:3a27 $11 $67 $3a
    add  HL, DE                                        ;; 00:3a2a $19
    ld   E, [HL]                                       ;; 00:3a2b $5e
    inc  HL                                            ;; 00:3a2c $23
    ld   D, [HL]                                       ;; 00:3a2d $56
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3a2e $fa $00 $d3
    rlca                                               ;; 00:3a31 $07
    rlca                                               ;; 00:3a32 $07
    rlca                                               ;; 00:3a33 $07
    and  A, $07                                        ;; 00:3a34 $e6 $07
    ld   L, A                                          ;; 00:3a36 $6f
    ld   H, $00                                        ;; 00:3a37 $26 $00
    add  HL, HL                                        ;; 00:3a39 $29
    add  HL, HL                                        ;; 00:3a3a $29
    ld   BC, data_00_39c0_EntityEffectBuffers                                     ;; 00:3a3b $01 $c0 $39
    add  HL, BC                                        ;; 00:3a3e $09
    ld   C, [HL]                                       ;; 00:3a3f $4e
    inc  HL                                            ;; 00:3a40 $23
    ld   B, [HL]                                       ;; 00:3a41 $46
    inc  HL                                            ;; 00:3a42 $23
    xor  A, A                                          ;; 00:3a43 $af
    ld   [BC], A                                       ;; 00:3a44 $02
    ld   A, [HL+]                                      ;; 00:3a45 $2a
    ld   H, [HL]                                       ;; 00:3a46 $66
    ld   L, A                                          ;; 00:3a47 $6f
    ld   B, ENTITY_PARTICLE_COUNT                      ;; 00:3a48 $06 $08
.jr_00_3a4a: ; one ENTITY_PARTICLE_RECORD_SIZE record per iteration, unrolled
    ld   A, [DE]                                       ;; 00:3a4a $1a
    ld   [HL+], A                                      ;; 00:3a4b $22
    inc  DE                                            ;; 00:3a4c $13
    ld   A, [DE]                                       ;; 00:3a4d $1a
    ld   [HL+], A                                      ;; 00:3a4e $22
    inc  DE                                            ;; 00:3a4f $13
    ld   A, [DE]                                       ;; 00:3a50 $1a
    ld   [HL+], A                                      ;; 00:3a51 $22
    inc  DE                                            ;; 00:3a52 $13
    ld   A, [DE]                                       ;; 00:3a53 $1a
    ld   [HL+], A                                      ;; 00:3a54 $22
    inc  DE                                            ;; 00:3a55 $13
    ld   A, [DE]                                       ;; 00:3a56 $1a
    ld   [HL+], A                                      ;; 00:3a57 $22
    inc  DE                                            ;; 00:3a58 $13
    dec  B                                             ;; 00:3a59 $05
    jr   NZ, .jr_00_3a4a                               ;; 00:3a5a $20 $ee
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    set  SPRITE_FLAG_EMBEDDED_DATA_BIT, [HL]                                       ;; 00:3a64 $cb $c6
    ret                                                ;; 00:3a66 $c9
.data_00_3a67_ParticlePatterns:
    dw   .data_00_3a75_Pattern_Empty                                 ;; 00:3a67 ??
    dw   .data_00_3a9d_Pattern_Burst                                 ;; 00:3a69 pP
    dw   .data_00_3ac5_Pattern_BurstSmall                                 ;; 00:3a6b pP
    dw   .data_00_3aed_Pattern_Unused
    dw   .data_00_3b15_Pattern_FallingBoulder
    dw   .data_00_3b3d_Pattern_JarBurst
    dw   .data_00_3b65_Pattern_MultiProjectile
.data_00_3a75_Pattern_Empty:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a75 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a7d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a85 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a8d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a95 ????????
.data_00_3a9d_Pattern_Burst:
    db   $81, $40, $00, $04, $01, $81, $30, $00        ;; 00:3a9d ........
    db   $03, $01, $81, $20, $00, $02, $01, $81        ;; 00:3aa5 ........
    db   $18, $00, $01, $01, $81, $40, $00, $04        ;; 00:3aad ........
    db   $ff, $81, $30, $00, $03, $ff, $81, $20        ;; 00:3ab5 ........
    db   $00, $02, $ff, $81, $18, $00, $01, $ff        ;; 00:3abd ........
.data_00_3ac5_Pattern_BurstSmall:
    db   $81, $24, $00, $00, $00, $81, $20, $00        ;; 00:3ac5 ........
    db   $06, $01, $81, $20, $00, $06, $ff, $00        ;; 00:3acd ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3ad5 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3add ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3ae5 ........
.data_00_3aed_Pattern_Unused:
    db   $81, $24, $00, $00, $00, $81, $20, $00        ;; 00:3aed ????????
    db   $06, $01, $81, $20, $00, $06, $ff, $81        ;; 00:3af5 ????????
    db   $1c, $00, $0e, $01, $81, $1c, $00, $0e        ;; 00:3afd ????????
    db   $ff, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b0d ????????
.data_00_3b15_Pattern_FallingBoulder:
    db   $01, $30, $10, $0c, $fb, $01, $20, $10        ;; 00:3b15 ????????
    db   $04, $ff, $01, $38, $10, $04, $05, $01        ;; 00:3b1d ????????
    db   $2e, $00, $0e, $fb, $01, $2c, $00, $06        ;; 00:3b25 ????????
    db   $01, $01, $26, $00, $0d, $05, $00, $00        ;; 00:3b2d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b35 ????????
.data_00_3b3d_Pattern_JarBurst:
    db   $01, $28, $10, $09, $f3, $01, $1a, $10        ;; 00:3b3d ????????
    db   $01, $fc, $01, $2e, $10, $02, $06, $01        ;; 00:3b45 ????????
    db   $26, $00, $0b, $f6, $01, $24, $00, $03        ;; 00:3b4d ????????
    db   $05, $01, $21, $00, $0a, $03, $00, $00        ;; 00:3b55 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b5d ????????
.data_00_3b65_Pattern_MultiProjectile:
    db   $81, $40, $0c, $0c, $01, $81, $30, $0c        ;; 00:3b65 ????????
    db   $09, $01, $81, $20, $0c, $06, $01, $81        ;; 00:3b6d ????????
    db   $18, $0c, $03, $01, $81, $40, $0c, $0c        ;; 00:3b75 ????????
    db   $ff, $81, $30, $0c, $09, $ff, $81, $20        ;; 00:3b7d ????????
    db   $0c, $06, $ff, $81, $18, $0c, $03, $ff        ;; 00:3b85 ????????

call_00_3b8d_Entity_TickParticles:
; Advances every live particle in this entity's buffer by one frame, and returns
; nonzero while any of them is still going - which is how the effect's action handler
; knows when to clear the slot.
;
; Each particle is a tiny ballistic simulation, and the record layout follows from
; what this loop does to it:
;
;   +0  PARTICLE_FIELD_FLAGS      bit 0 alive. Sprite builders and collision test
;                                 different bits of this byte per effect - some read
;                                 bit 7 instead, so treat it as per-effect flags
;   +1  PARTICLE_FIELD_YVELOCITY  signed, decremented once a frame - this is gravity.
;                                 Floored at PARTICLE_YVELOCITY_MIN so a long-lived
;                                 particle cannot accelerate forever
;   +2  PARTICLE_FIELD_YOFFSET    height above the entity. Grows by YVELOCITY >> 4
;                                 each frame and is CLAMPED AT ZERO - hitting zero is
;                                 what ends the particle, so a particle dies when it
;                                 falls back to the height it launched from
;   +3  PARTICLE_FIELD_XSPEED     horizontal speed as a fraction: the low nibble is
;                                 added to the whole byte each frame, and the carry out
;                                 is what steps the offset
;   +4  PARTICLE_FIELD_XOFFSET    signed horizontal offset, stepped by +1 or -1 per
;                                 carry with the direction taken from its own sign bit
;
; Vertical is whole pixels with a velocity, horizontal is a sub-pixel accumulator with
; no velocity - the asymmetry is why a burst arcs but never changes direction
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3b8d $fa $00 $d3
    rlca                                               ;; 00:3b90 $07
    rlca                                               ;; 00:3b91 $07
    rlca                                               ;; 00:3b92 $07
    and  A, $07                                        ;; 00:3b93 $e6 $07
    ld   L, A                                          ;; 00:3b95 $6f
    ld   H, $00                                        ;; 00:3b96 $26 $00
    add  HL, HL                                        ;; 00:3b98 $29
    add  HL, HL                                        ;; 00:3b99 $29
    ld   DE, data_00_39c2_EntityParticleBuffers                                     ;; 00:3b9a $11 $c2 $39
    add  HL, DE                                        ;; 00:3b9d $19
    ld   A, [HL+]                                      ;; 00:3b9e $2a
    ld   H, [HL]                                       ;; 00:3b9f $66
    ld   L, A                                          ;; 00:3ba0 $6f
    push HL                                            ;; 00:3ba1 $e5
    ld   B, $08                                        ;; 00:3ba2 $06 $08
.jr_00_3ba4:
    push HL                                            ;; 00:3ba4 $e5
    bit  0, [HL]                                       ;; 00:3ba5 $cb $46
    jr   Z, .jr_00_3bd9                                ;; 00:3ba7 $28 $30
    inc  HL                                            ;; 00:3ba9 $23
    ld   A, [HL]                                       ;; 00:3baa $7e
    cp   A, $c0                                        ;; 00:3bab $fe $c0
    jr   Z, .jr_00_3bb0                                ;; 00:3bad $28 $01
    dec  [HL]                                          ;; 00:3baf $35
.jr_00_3bb0:
    ld   A, [HL+]                                      ;; 00:3bb0 $2a
    sra  A                                             ;; 00:3bb1 $cb $2f
    sra  A                                             ;; 00:3bb3 $cb $2f
    sra  A                                             ;; 00:3bb5 $cb $2f
    sra  A                                             ;; 00:3bb7 $cb $2f
    add  A, [HL]                                       ;; 00:3bb9 $86
    bit  7, A                                          ;; 00:3bba $cb $7f
    jr   Z, .jr_00_3bbf                                ;; 00:3bbc $28 $01
    xor  A, A                                          ;; 00:3bbe $af
.jr_00_3bbf:
    ld   [HL+], A                                      ;; 00:3bbf $22
    and  A, A                                          ;; 00:3bc0 $a7
    jr   Z, .jr_00_3bd9                                ;; 00:3bc1 $28 $16
    ld   A, [HL]                                       ;; 00:3bc3 $7e
    and  A, $0f                                        ;; 00:3bc4 $e6 $0f
    swap A                                             ;; 00:3bc6 $cb $37
    add  A, [HL]                                       ;; 00:3bc8 $86
    ld   [HL], A                                       ;; 00:3bc9 $77
    jr   NC, .jr_00_3bd7                               ;; 00:3bca $30 $0b
    inc  HL                                            ;; 00:3bcc $23
    ld   A, $01                                        ;; 00:3bcd $3e $01
    bit  7, [HL]                                       ;; 00:3bcf $cb $7e
    jr   Z, .jr_00_3bd5                                ;; 00:3bd1 $28 $02
    ld   A, $ff                                        ;; 00:3bd3 $3e $ff
.jr_00_3bd5:
    add  A, [HL]                                       ;; 00:3bd5 $86
    ld   [HL], A                                       ;; 00:3bd6 $77
.jr_00_3bd7:
    ld   A, $01                                        ;; 00:3bd7 $3e $01
.jr_00_3bd9:
    pop  HL                                            ;; 00:3bd9 $e1
    or   A, $fe                                        ;; 00:3bda $f6 $fe
    and  A, [HL]                                       ;; 00:3bdc $a6
    ld   [HL], A                                       ;; 00:3bdd $77
    ld   DE, $05                                       ;; 00:3bde $11 $05 $00
    add  HL, DE                                        ;; 00:3be1 $19
    dec  B                                             ;; 00:3be2 $05
    jr   NZ, .jr_00_3ba4                               ;; 00:3be3 $20 $bf
    pop  HL                                            ;; 00:3be5 $e1
    ld   DE, $05                                       ;; 00:3be6 $11 $05 $00
    ld   B, $08                                        ;; 00:3be9 $06 $08
    xor  A, A                                          ;; 00:3beb $af
.jr_00_3bec:
    or   A, [HL]                                       ;; 00:3bec $b6
    add  HL, DE                                        ;; 00:3bed $19
    dec  B                                             ;; 00:3bee $05
    jr   NZ, .jr_00_3bec                               ;; 00:3bef $20 $fb
    and  A, $01                                        ;; 00:3bf1 $e6 $01
    ret                                                ;; 00:3bf3 $c9
