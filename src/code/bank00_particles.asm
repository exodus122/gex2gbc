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
    ld   C, $01
    call call_00_37e7_Entity_SetOamAttrBase
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_COLLISION_TYPE
    ld   [HL], $00
    ld   A, L
    xor  A, $16
    ld   L, A
    ld   [HL], $07
    ld   A, L
    xor  A, $17
    ld   L, A
    ld   [HL], $00
    ld   A, L
    xor  A, $1a
    ld   L, A
    ld   [HL], $00
    ld   C, PARTICLE_PATTERN_BURST
    call call_00_3a23_Entity_StartParticleEffect
    call call_00_393c_Entity_MarkNeverRespawn
    xor  A, A
    FARCALL call_02_7102_Entity_SetAction
    ld   C, SFX_ENEMY_DEFEATED
    call call_00_112f_QueueSFX
    ret

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
;                SPRITE_FLAG_EMBEDDED_SPRITE_DATA on the entity is what selects that path.
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
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   DE, data_00_39c0_EntityEffectBuffers
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ret

call_00_39f5_Entity_GetParticlesPtr:
; DE = this entity's particle buffer - ENTITY_PARTICLE_COUNT records of
; ENTITY_PARTICLE_RECORD_SIZE. Identical to the routine above apart from starting the
; table lookup two bytes further in, which lands on the particle word of the pair
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   DE, data_00_39c2_EntityParticleBuffers
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ret

call_00_3a0a_Entity_GetSpriteListAndParticles:
; DE = sprite list, HL = particles. Both in one lookup, because the two words sit
; next to each other in the table.
;
; This is the entry point every per-effect sprite builder uses, and the register
; assignment matches how they all work: read a particle from HL, write an OAM record
; to DE. They typically `push DE` first so they can come back at the end and store the
; sprite count into the first byte
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   DE, data_00_39c0_EntityEffectBuffers
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ret

call_00_3a23_Entity_StartParticleEffect:
; Arms this entity's particle swarm. C selects a PARTICLE_PATTERN_* from
; .data_00_3a67_ParticlePatterns, and the whole pattern - every particle's starting
; position and velocity - is copied into the entity's particle buffer.
;
; Three things happen, and the order matters:
;   1. the sprite list's count byte is zeroed, so nothing is drawn until
;      call_00_3b8d_Entity_TickParticles has run and a builder has filled it in
;   2. the ROM pattern is copied over the particle buffer wholesale
;   3. SPRITE_FLAG_EMBEDDED_SPRITE_DATA is set, switching this entity to the sprite path that
;      reads the list rather than a shared animation table
;
; After this the entity's action handler just calls Entity_TickParticles each frame and
; ends the effect when it returns zero
    ld   L, C
    ld   H, $00
    add  HL, HL
    ld   DE, .data_00_3a67_ParticlePatterns
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   BC, data_00_39c0_EntityEffectBuffers
    add  HL, BC
    ld   C, [HL]
    inc  HL
    ld   B, [HL]
    inc  HL
    xor  A, A
    ld   [BC], A
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   B, ENTITY_PARTICLE_COUNT
.jr_00_3a4a: ; one ENTITY_PARTICLE_RECORD_SIZE record per iteration, unrolled
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    dec  B
    jr   NZ, .jr_00_3a4a
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    set  SPRITE_FLAG_EMBEDDED_SPRITE_DATA_BIT, [HL]
    ret
.data_00_3a67_ParticlePatterns:
    dw   .data_00_3a75_Pattern_Empty
    dw   .data_00_3a9d_Pattern_Burst
    dw   .data_00_3ac5_Pattern_BurstSmall
    dw   .data_00_3aed_Pattern_Unused
    dw   .data_00_3b15_Pattern_FallingBoulder
    dw   .data_00_3b3d_Pattern_JarBurst
    dw   .data_00_3b65_Pattern_MultiProjectile
.data_00_3a75_Pattern_Empty:
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
.data_00_3a9d_Pattern_Burst:
    db   $81, $40, $00, $04, $01, $81, $30, $00
    db   $03, $01, $81, $20, $00, $02, $01, $81
    db   $18, $00, $01, $01, $81, $40, $00, $04
    db   $ff, $81, $30, $00, $03, $ff, $81, $20
    db   $00, $02, $ff, $81, $18, $00, $01, $ff
.data_00_3ac5_Pattern_BurstSmall:
    db   $81, $24, $00, $00, $00, $81, $20, $00
    db   $06, $01, $81, $20, $00, $06, $ff, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
.data_00_3aed_Pattern_Unused:
    db   $81, $24, $00, $00, $00, $81, $20, $00
    db   $06, $01, $81, $20, $00, $06, $ff, $81
    db   $1c, $00, $0e, $01, $81, $1c, $00, $0e
    db   $ff, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
.data_00_3b15_Pattern_FallingBoulder:
    db   $01, $30, $10, $0c, $fb, $01, $20, $10
    db   $04, $ff, $01, $38, $10, $04, $05, $01
    db   $2e, $00, $0e, $fb, $01, $2c, $00, $06
    db   $01, $01, $26, $00, $0d, $05, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
.data_00_3b3d_Pattern_JarBurst:
    db   $01, $28, $10, $09, $f3, $01, $1a, $10
    db   $01, $fc, $01, $2e, $10, $02, $06, $01
    db   $26, $00, $0b, $f6, $01, $24, $00, $03
    db   $05, $01, $21, $00, $0a, $03, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
.data_00_3b65_Pattern_MultiProjectile:
    db   $81, $40, $0c, $0c, $01, $81, $30, $0c
    db   $09, $01, $81, $20, $0c, $06, $01, $81
    db   $18, $0c, $03, $01, $81, $40, $0c, $0c
    db   $ff, $81, $30, $0c, $09, $ff, $81, $20
    db   $0c, $06, $ff, $81, $18, $0c, $03, $ff

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
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   DE, data_00_39c2_EntityParticleBuffers
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    push HL
    ld   B, $08
.jr_00_3ba4:
    push HL
    bit  0, [HL]
    jr   Z, .jr_00_3bd9
    inc  HL
    ld   A, [HL]
    cp   A, $c0
    jr   Z, .jr_00_3bb0
    dec  [HL]
.jr_00_3bb0:
    ld   A, [HL+]
    sra  A
    sra  A
    sra  A
    sra  A
    add  A, [HL]
    bit  7, A
    jr   Z, .jr_00_3bbf
    xor  A, A
.jr_00_3bbf:
    ld   [HL+], A
    and  A, A
    jr   Z, .jr_00_3bd9
    ld   A, [HL]
    and  A, $0f
    swap A
    add  A, [HL]
    ld   [HL], A
    jr   NC, .jr_00_3bd7
    inc  HL
    ld   A, $01
    bit  7, [HL]
    jr   Z, .jr_00_3bd5
    ld   A, $ff
.jr_00_3bd5:
    add  A, [HL]
    ld   [HL], A
.jr_00_3bd7:
    ld   A, $01
.jr_00_3bd9:
    pop  HL
    or   A, $fe
    and  A, [HL]
    ld   [HL], A
    ld   DE, $05
    add  HL, DE
    dec  B
    jr   NZ, .jr_00_3ba4
    pop  HL
    ld   DE, $05
    ld   B, $08
    xor  A, A
.jr_00_3bec:
    or   A, [HL]
    add  HL, DE
    dec  B
    jr   NZ, .jr_00_3bec
    and  A, $01
    ret
