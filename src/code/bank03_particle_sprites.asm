; ==================================================================
; PARTICLE SPRITE LIST BUILDERS
;
; Six routines, one per effect, and all six are the same routine with a different
; expression in the middle. Each turns this entity's particle buffer - the simulation
; that call_00_3b8d_Entity_TickParticles advances - into its sprite list, the OAM
; records that .jp_03_6451_Entity_BuildSprites_SpriteList later copies to shadow OAM.
; Nothing here touches OAM directly.
;
; call_00_3a0a_Entity_GetSpriteListAndParticles sets up both pointers at once: HL on
; the particles, DE on the sprite list. Each then walks all ENTITY_PARTICLE_COUNT
; particles, skipping dead ones, and emits one four-byte record per live particle:
;
;   Y     -(PARTICLE_FIELD_YOFFSET) - 8      offset grows upward, OAM Y grows down
;   X     PARTICLE_FIELD_XOFFSET - 4         centres an 8-wide sprite on the particle
;   tile  the per-effect expression
;   attr  a per-effect literal - the CGB palette is how the six are told apart
;
; The count byte is written last: DE is pushed on entry pointing at it, and the live
; count in C is stored there at the end. The routine returns Z when nothing was drawn,
; which is what an effect's action handler uses to know the burst has finished.
;
; The three lines that make each one different are the flag bit tested, the tile
; expression and the attribute byte:
;
;   SkullFire       bit 0   frame counter, $2C/$2E     attr $04
;   Collectible     bit 7   fixed $7E                  attr $01
;   BoulderDebris   bit 0   height, $44-$4E            attr $07
;   DefeatBurst     bit 0   height, $60/$62/$64        attr $01
;   FirePlant       bit 0   frame counter, $58/$5A     attr $04
;   JarShards       bit 0   height bit 1, $5C/$5E      attr $04
;
; Note that two of them read the particle's HEIGHT to choose a tile, not its age or an
; animation frame - debris that has been thrown further up is drawn as a different
; sprite, so a burst looks graded rather than uniform
; ==================================================================

call_03_6549_Particles_BuildSpriteList_SkullFire:
; The fireball trail the Scream TV floating skull spits. The tile alternates on
; wD73B_VBlankFrameCounter rather than on anything about the particle, so every flame
; in the trail flickers in step - which is what makes it read as one flame rather than
; eight sparks
    call call_00_3a0a_Entity_GetSpriteListAndParticles
    push de                                            ; the count byte, filled in at the end
    inc  de
    ld   c,$00                                         ; live particles emitted
    ld   b,$08                                         ; ENTITY_PARTICLE_COUNT
.jr_03_6552:
    bit  PARTICLE_ALIVE_BIT,[hl]
    jr   z,.jr_03_657d
    ldi  a,[hl]                                        ; +0 flags
    ldi  a,[hl]                                        ; +1 Y velocity
    ldi  a,[hl]                                        ; +2 Y offset
    cpl
    inc  a
    sub  a,$08                                         ; OAM Y = -offset - 8
    ld   [de],a
    inc  de
    ldi  a,[hl]                                        ; +3 X speed
    ldi  a,[hl]                                        ; +4 X offset
    sub  a,$04                                         ; OAM X = offset - 4
    ld   [de],a
    inc  de
    ld   a,[wD73B_VBlankFrameCounter]
    rrca
    rrca
    and  a,$02                                         ; two frames, four frames each
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

call_03_6584_Particles_BuildSpriteList_Collectible:
; The collectibles an ENTITY_COLLECTIBLE_SPAWN scatters, drawn as tile $7E - the same
; tile the HUD counter and call_03_6499_Collectible_BuildSprites use, so a dropped
; collectible and a placed one are the same picture.
;
; THIS IS THE ONE THAT TESTS BIT 7. Every other builder here, and
; Entity_TickParticles itself, use PARTICLE_ALIVE_BIT. The gap between the two is a
; deliberate state: once a particle has landed, TickParticles stops moving it but this
; still draws it, which is exactly what a settled pickup lying on the floor is. See
; call_02_51b7_EntityAction_CollectibleSpawn_Update, which from then on is only a
; lifetime counter
    call call_00_3a0a_Entity_GetSpriteListAndParticles                                  ;; 03:6584 $cd $0a $3a
    push DE                                            ;; 03:6587 $d5
    inc  DE                                            ;; 03:6588 $13
    ld   C, $00                                        ;; 03:6589 $0e $00
    ld   B, $08                                        ;; 03:658b $06 $08
.jr_03_658d:
    bit  7, [HL]                                       ;; 03:658d $cb $7e ; drawn, not alive
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

call_03_65b8_Particles_BuildSpriteList_BoulderDebris:
; The chips a Pre-History falling boulder throws off when it lands. Six tiles,
; $44 to $4E, chosen by the particle's own HEIGHT - min(YOFFSET >> 4, 5) * 2 - so a
; chip that was thrown further up is drawn as a different sprite and the spray comes
; out graded rather than uniform.
;
; THE X BIAS IS LOST HERE. Compare the read order against every other builder:
; this one does `ld a, [hl+]` / `sub $04` / `ld a, [hl+]` / `ld [de], a`, so the $04
; is subtracted from PARTICLE_FIELD_XSPEED and then A is immediately reloaded with
; PARTICLE_FIELD_XOFFSET before the store. The two instructions are the right way
; round in the other five ($2A $2A $D6 $04 rather than $2A $D6 $04 $2A). The result is
; that boulder debris sits four pixels right of where the same particle would be drawn
; by any other effect - which is small enough to have gone unnoticed
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
    ldi  a,[hl]                                        ; +3 X speed
    sub  a,$04                                         ; the centring bias, applied to
    ldi  a,[hl]                                        ; +4 X offset, which discards it
    ld   [de],a
    inc  de
    pop  af                                            ; the Y offset again
    swap a
    and  a,$0F                                         ; height in 16-pixel steps
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

call_03_65f9_Particles_BuildSpriteList_DefeatBurst:
; The puff every beaten enemy turns into - ENTITY_ENEMY_DEFEATED, and by far the most
; often drawn effect in the game. Three tiles, $60 to $64, graded by particle height
; the same way the boulder debris is, but clamped at 2 instead of 5 so the spray is
; coarser and cheaper.
;
; Its X handling is the correct version of the boulder's: both reads happen before the
; subtract, so the centring bias survives
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

call_03_663a_Particles_BuildSpriteList_FirePlant:
; The spray the Pre-History fire plant spits. Instruction for instruction the same as
; the skull fire above with $58 in place of $2C, so both flames flicker on the global
; frame counter and both sit on CGB palette 4 - the two effects share a palette as
; well as a routine
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

call_03_6675_Particles_BuildSpriteList_JarShards:
; The pieces a Kung Fu Theater jar breaks into. Two tiles, $5C and $5E, picked by
; bit 1 of the particle's Y offset rather than by a timer or a clamped height - so a
; shard swaps sprite every two pixels it rises or falls, and the shards tumble out of
; step with each other because each is at its own height. The cheapest of the six
; tile expressions and the liveliest looking
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
