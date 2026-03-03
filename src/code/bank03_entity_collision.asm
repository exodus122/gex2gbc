; This file handles gex's collision with entities [enemies, tv switches, remotes, etc.]

call_03_4c76_UpdateEntityCollision_Dispatch:
    ld   A, [wD743_DrawGexFlag]                                    ;; 03:4c76 $fa $43 $d7
    and  A, A                                          ;; 03:4c79 $a7
    ret  Z                                             ;; 03:4c7a $c8 ; return if [D743] is 0
    ld   H, $d2                                        ;; 03:4c7b $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:4c7d $fa $00 $d3
    or   A, $0a                                        ;; 03:4c80 $f6 $0a
    ld   L, A                                          ;; 03:4c82 $6f
    bit  5, [HL]                                       ;; 03:4c83 $cb $6e
    ret  Z                                             ;; 03:4c85 $c8
    xor  A, $1e                                        ;; 03:4c86 $ee $1e
    ld   L, A                                          ;; 03:4c88 $6f
    ld   E, [HL]                                       ;; 03:4c89 $5e
    inc  L                                             ;; 03:4c8a $2c
    ld   D, [HL]                                       ;; 03:4c8b $56
    inc  L                                             ;; 03:4c8c $2c
    ld   L, [HL]                                       ;; 03:4c8d $6e
    res  7, L                                          ;; 03:4c8e $cb $bd
    ld   H, $00                                        ;; 03:4c90 $26 $00
    add  HL, HL                                        ;; 03:4c92 $29
    ld   BC, .data_03_4c9b_EntityCollisionJumpTable    ;; 03:4c93 $01 $9b $4c
    add  HL, BC                                        ;; 03:4c96 $09
    ld   A, [HL+]                                      ;; 03:4c97 $2a
    ld   H, [HL]                                       ;; 03:4c98 $66
    ld   L, A                                          ;; 03:4c99 $6f
    jp   HL                                            ;; 03:4c9a $e9
.data_03_4c9b_EntityCollisionJumpTable:               ;; 03:4c9b pP ; jump table
    dw   .jr_03_4ce5_CollisionHandler_None ; COLLISION_TYPE_NONE
    dw   .jr_03_4ce6_CollisionHandler_Collectible ; COLLISION_TYPE_COLLECTIBLE
    dw   .jr_03_4d33_CollisionHandler_UNK_02 ; COLLISION_TYPE_UNK_02
    dw   call_03_52c5_CollisionHandler_StationaryPlatform ; COLLISION_TYPE_STATIONARY_PLATFORM
    dw   call_03_536f_CollisionHandler_MovingPlatform ; COLLISION_TYPE_MOVING_PLATFORM
    dw   call_03_5304_CollisionHandler_UNK_05 ; COLLISION_TYPE_UNK_05
    dw   .jr_03_4dbc_CollisionHandler_GenericEnemy ; COLLISION_TYPE_GENERIC_ENEMY
    dw   .jr_03_4d3f_CollisionHandler_SilverRemote ; COLLISION_TYPE_SILVER_REMOTE
    dw   .jr_03_4d56_CollisionHandler_GoldRemote ; COLLISION_TYPE_GOLD_REMOTE
    dw   .jr_03_4d82_CollisionHandler_UNK_09 ; COLLISION_TYPE_UNK_09
    dw   .jr_03_4d8c_CollisionHandler_Lantern ; COLLISION_TYPE_LANTERN
    dw   .jr_03_4d9a_CollisionHandler_Zombie ; COLLISION_TYPE_ZOMBIE
    dw   .jr_03_4dc8_CollisionHandler_GhostHead ; COLLISION_TYPE_GHOST_HEAD
    dw   .jr_03_4dd4_CollisionHandler_Ghost ; COLLISION_TYPE_GHOST
    dw   .jr_03_4df4_CollisionHandler_ZombieHead ; COLLISION_TYPE_ZOMBIE_HEAD
    dw   .jr_03_4e20_CollisionHandler_FallingObject ; COLLISION_TYPE_FALLING_OBJECT
    dw   .jr_03_4e7f_CollisionHandler_Hunter ; COLLISION_TYPE_HUNTER
    dw   .jr_03_4eb4_CollisionHandler_Mushroom ; COLLISION_TYPE_MUSHROOM
    dw   .jr_03_4ec6_CollisionHandler_UNK_12 ; COLLISION_TYPE_UNK_12
    dw   .jr_03_4ec7_CollisionHandler_Projectile ; COLLISION_TYPE_PROJECTILE
    dw   .jr_03_4f14_CollisionHandler_Jar ; COLLISION_TYPE_JAR
    dw   .jr_03_4f20_CollisionHandler_Ninja ; COLLISION_TYPE_NINJA
    dw   .jr_03_4fc7_CollisionHandler_HangingBlade ; COLLISION_TYPE_HANGING_BLADE
    dw   .jr_03_4fcf_CollisionHandler_UNK_17 ; COLLISION_TYPE_UNK_17
    dw   .jr_03_4fd9_CollisionHandler_SamuraiBody ; COLLISION_TYPE_SAMURAI_BODY
    dw   .jr_03_5035_CollisionHandler_UNK_19 ; COLLISION_TYPE_UNK_19
    dw   .jr_03_5049_CollisionHandler_Geyser ; COLLISION_TYPE_GEYSER
    dw   .jr_03_505d_CollisionHandler_Triceratops ; COLLISION_TYPE_TRICERATOPS
    dw   .jr_03_50ac_CollisionHandler_Gear ; COLLISION_TYPE_GEAR
    dw   .jr_03_50c5_CollisionHandler_ElectricBall ; COLLISION_TYPE_ELECTRIC_BALL
    dw   .jr_03_50d6_CollisionHandler_UNK_1E ; COLLISION_TYPE_UNK_1E
    dw   .jr_03_50e7_CollisionHandler_Rocket ; COLLISION_TYPE_ROCKET
    dw   .jr_03_5109_CollisionHandler_Cannon ; COLLISION_TYPE_CANNON
    dw   .jr_03_5129_CollisionHandler_PoweredWalkway ; COLLISION_TYPE_POWERED_WALKWAY
    dw   .jr_03_514e_CollisionHandler_PowerUp ; COLLISION_TYPE_POWER_UP
    dw   .jr_03_5163_CollisionHandler_DragonProjectile ; COLLISION_TYPE_DRAGON_PROJECTILE
    dw   .jr_03_516d_CollisionHandler_Rez ; COLLISION_TYPE_REZ
.jr_03_4ce5_CollisionHandler_None:
    ret        	;; 03:4ce5 $c9
.jr_03_4ce6_CollisionHandler_Collectible:
    call call_03_519b_Entity_CheckPlayerInteraction                                  ;; 03:4ce6 $cd $9b $51
    ret  NC                                            ;; 03:4ce9 $d0
    ld   H, $d2                                        ;; 03:4cea $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:4cec $fa $00 $d3
    or   A, $12                                        ;; 03:4cef $f6 $12
    ld   L, A                                          ;; 03:4cf1 $6f
    ld   C, [HL]                                       ;; 03:4cf2 $4e
    inc  L                                             ;; 03:4cf3 $2c
    ld   B, [HL]                                       ;; 03:4cf4 $46
    call call_00_39f5                                  ;; 03:4cf5 $cd $f5 $39
    ld   L, E                                          ;; 03:4cf8 $6b
    ld   H, D                                          ;; 03:4cf9 $62
    ld   A, $08                                        ;; 03:4cfa $3e $08
.jr_03_4cfc:
    push AF                                            ;; 03:4cfc $f5
    push BC                                            ;; 03:4cfd $c5
    push HL                                            ;; 03:4cfe $e5
    ld   A, [HL+]                                      ;; 03:4cff $2a
    bit  7, A                                          ;; 03:4d00 $cb $7f
    jr   Z, .jr_03_4d20                                ;; 03:4d02 $28 $1c
    inc  HL                                            ;; 03:4d04 $23
    ld   A, [HL+]                                      ;; 03:4d05 $2a
    add  A, B                                          ;; 03:4d06 $80
    ld   B, A                                          ;; 03:4d07 $47
    ld   A, [wD213_PlayerScreenYPosition]                                    ;; 03:4d08 $fa $13 $d2
    sub  A, B                                          ;; 03:4d0b $90
    add  A, $08                                        ;; 03:4d0c $c6 $08
    cp   A, $10                                        ;; 03:4d0e $fe $10
    jr   NC, .jr_03_4d20                               ;; 03:4d10 $30 $0e
    inc  HL                                            ;; 03:4d12 $23
    ld   A, [HL+]                                      ;; 03:4d13 $2a
    add  A, C                                          ;; 03:4d14 $81
    ld   C, A                                          ;; 03:4d15 $4f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:4d16 $fa $12 $d2
    sub  A, C                                          ;; 03:4d19 $91
    add  A, $04                                        ;; 03:4d1a $c6 $04
    cp   A, $08                                        ;; 03:4d1c $fe $08
    jr   C, .jr_03_4d2b                                ;; 03:4d1e $38 $0b
.jr_03_4d20:
    pop  HL                                            ;; 03:4d20 $e1
    ld   BC, $05                                       ;; 03:4d21 $01 $05 $00
    add  HL, BC                                        ;; 03:4d24 $09
    pop  BC                                            ;; 03:4d25 $c1
    pop  AF                                            ;; 03:4d26 $f1
    dec  A                                             ;; 03:4d27 $3d
    jr   NZ, .jr_03_4cfc                               ;; 03:4d28 $20 $d2
    ret                                                ;; 03:4d2a $c9
.jr_03_4d2b:
    pop  HL                                            ;; 03:4d2b $e1
    res  7, [HL]                                       ;; 03:4d2c $cb $be
    pop  BC                                            ;; 03:4d2e $c1
    pop  AF                                            ;; 03:4d2f $f1
    jp   call_00_06ec                                  ;; 03:4d30 $c3 $ec $06
.jr_03_4d33_CollisionHandler_UNK_02:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    call call_00_3931
    ld   a,$04
    jp   call_00_0647
.jr_03_4d3f_CollisionHandler_SilverRemote:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   a,[wD64C]
    or   a,$10
    ld   [wD64C],a
    ld   c,$03
    call call_00_112f
    call call_00_3931
    jp   call_00_393c
.jr_03_4d56_CollisionHandler_GoldRemote:
    ld   a,[wD621]
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
    call call_00_3931
    call call_00_393c
    ld   a,$1E
    farcall call_02_4ccd
    ret  
.jr_03_4d82_CollisionHandler_UNK_09:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    call z,call_03_52be_Entity_CheckForDamagePlayer
    ret  
.jr_03_4d8c_CollisionHandler_Lantern:
    ld   a,$01
    ld   [wD757],a
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    xor  a
    ld   [wD757],a
    ret  
.jr_03_4d9a_CollisionHandler_Zombie:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jr   nz,.jr_03_4DA5
    jp   call_03_52be_Entity_CheckForDamagePlayer
.jr_03_4DA5:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    ret  nz
    set  0,[hl]
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
    call call_03_519b_Entity_CheckPlayerInteraction                                  ;; 03:4dbc $cd $9b $51
    ret  NC                                            ;; 03:4dbf $d0
    cp   A, $00                                        ;; 03:4dc0 $fe $00
    jp   Z, call_03_52be_Entity_CheckForDamagePlayer                               ;; 03:4dc2 $ca $be $52
    jp   call_00_3985                                  ;; 03:4dc5 $c3 $85 $39
.jr_03_4dc8_CollisionHandler_GhostHead:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    call z,call_03_52be_Entity_CheckForDamagePlayer
    jp   call_00_3931
.jr_03_4dd4_CollisionHandler_Ghost:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD757
    inc  [hl]
    dec  [hl]
    jr   z,.jr_03_4DE5
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
    ret  
.jr_03_4DE5:
    cp   a,$01
    jp   nz,call_03_52be_Entity_CheckForDamagePlayer
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   l
    ld   l,a
    set  0,[hl]
    ret  
.jr_03_4df4_CollisionHandler_ZombieHead:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
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
    call call_00_3985
.jr_03_4E19:
    pop  af
    ld   [wD300_CurrentEntityAddrLo],a
    jp   call_00_3931
.jr_03_4e20_CollisionHandler_FallingObject:
    ld   H, $d2                                        ;; 03:4e20 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:4e22 $fa $00 $d3
    or   A, $1e                                        ;; 03:4e25 $f6 $1e
    ld   L, A                                          ;; 03:4e27 $6f
    bit  7, [HL]                                       ;; 03:4e28 $cb $7e
    ret  Z                                             ;; 03:4e2a $c8
    xor  A, $10                                        ;; 03:4e2b $ee $10
    ld   L, A                                          ;; 03:4e2d $6f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4e2e $fa $0e $d2
    sub  A, [HL]                                       ;; 03:4e31 $96
    ld   C, A                                          ;; 03:4e32 $4f
    inc  HL                                            ;; 03:4e33 $23
    ld   A, [wD20F_PlayerXPosition]                                    ;; 03:4e34 $fa $0f $d2
    sbc  A, [HL]                                       ;; 03:4e37 $9e
    ld   B, A                                          ;; 03:4e38 $47
    ld   A, C                                          ;; 03:4e39 $79
    add  A, E                                          ;; 03:4e3a $83
    ld   C, A                                          ;; 03:4e3b $4f
    ld   A, B                                          ;; 03:4e3c $78
    adc  A, $00                                        ;; 03:4e3d $ce $00
    ld   B, A                                          ;; 03:4e3f $47
    sla  E                                             ;; 03:4e40 $cb $23
    ld   A, C                                          ;; 03:4e42 $79
    sub  A, E                                          ;; 03:4e43 $93
    ld   A, B                                          ;; 03:4e44 $78
    sbc  A, $00                                        ;; 03:4e45 $de $00
    ret  NC                                            ;; 03:4e47 $d0
    inc  L                                             ;; 03:4e48 $2c
    ld   A, [HL+]                                      ;; 03:4e49 $2a
    ld   H, [HL]                                       ;; 03:4e4a $66
    ld   L, A                                          ;; 03:4e4b $6f
    ld   E, D                                          ;; 03:4e4c $5a
    ld   D, $00                                        ;; 03:4e4d $16 $00
    add  HL, DE                                        ;; 03:4e4f $19
    ld   DE, $10                                       ;; 03:4e50 $11 $10 $00
    add  HL, DE                                        ;; 03:4e53 $19
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4e54 $fa $10 $d2
    sub  A, L                                          ;; 03:4e57 $95
    ld   L, A                                          ;; 03:4e58 $6f
    ld   A, [wD211_PlayerYPosition]                                    ;; 03:4e59 $fa $11 $d2
    sbc  A, H                                          ;; 03:4e5c $9c
    ret  NC                                            ;; 03:4e5d $d0
    cp   A, $ff                                        ;; 03:4e5e $fe $ff
    ret  NZ                                            ;; 03:4e60 $c0
    ld   A, L                                          ;; 03:4e61 $7d
    cp   A, $f4                                        ;; 03:4e62 $fe $f4
    ret  C                                             ;; 03:4e64 $d8
    call call_00_075b_Player_CanBeDamaged                                  ;; 03:4e65 $cd $5b $07
    ret  NZ                                            ;; 03:4e68 $c0
    call call_03_52be_Entity_CheckForDamagePlayer                                  ;; 03:4e69 $cd $be $52
    ld   A, $77                                        ;; 03:4e6c $3e $77
    ld   [wD750], A                                    ;; 03:4e6e $ea $50 $d7
    ld   A, $19                                        ;; 03:4e71 $3e $19
    farcall call_02_4ccd
    ret                                                ;; 03:4e7e $c9
.jr_03_4e7f_CollisionHandler_Hunter:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    ret  nz
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
    call call_00_3817
    jr   z,.jr_03_4EA3
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  0,[hl]
    ret  
.jr_03_4EA3:
    call call_00_3985
    ld   hl,wD773
    inc  [hl]
    ld   a,[hl]
    cp   a,$02
    ret  nz
    ld   hl,wD799
    ld   [hl],$02
    ret  
.jr_03_4eb4_CollisionHandler_Mushroom:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    ret  z
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  0,[hl]
    ret  
.jr_03_4ec6_CollisionHandler_UNK_12:
    ret  
.jr_03_4ec7_CollisionHandler_Projectile:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$12
    ld   l,a
    ldi  a,[hl]
    add  a,$04
    ld   c,a
    ld   a,[hl]
    add  a,$08
    ld   b,a
    call call_00_39f5
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
    ld   a,[wD213_PlayerScreenYPosition]
    sub  b
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_4F03
    inc  hl
    ldi  a,[hl]
    add  c
    ld   c,a
    ld   a,[wD212_PlayerScreenXPosition]
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
    jp   call_03_52be_Entity_CheckForDamagePlayer
.jr_03_4f14_CollisionHandler_Jar:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$01
    ret  nz
    ld   c,$01
    jp   call_00_3802
.jr_03_4f20_CollisionHandler_Ninja:
    push de
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    ld   l,a
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
    ld   a,[wD213_PlayerScreenYPosition]
    sub  c
    add  a,$10
    cp   a,$20
    jr   nc,.jr_03_4F6F
    ld   a,[wD212_PlayerScreenXPosition]
    sub  e
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_4F6F
    pop  de
    jp   call_03_52be_Entity_CheckForDamagePlayer
.jr_03_4F6F:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
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
    ld   hl,wD301
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
    jp   call_00_3985
.jr_03_4FB0:
    inc  hl
    ld   l,[hl]
    ld   h,$00
    ld   de,wD78B
    add  hl,de
    ld   [hl],$02
    jp   call_00_3985
.data_03_4fbd:
    db   $0d, $07, $08, $05, $05, $00, $05, $06
    db   $08, $ff
.jr_03_4fc7_CollisionHandler_HangingBlade:
    push de
    call .jr_03_4e20_CollisionHandler_FallingObject
    pop  de
    jp   .jr_03_4d82_CollisionHandler_UNK_09
.jr_03_4fcf_CollisionHandler_UNK_17:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   a,$7F
    ld   [wD758],a
    ret  
.jr_03_4fd9_CollisionHandler_SamuraiBody:
    push de
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    ld   l,a
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
    ld   a,[wD213_PlayerScreenYPosition]
    sub  c
    add  a,$10
    cp   a,$20
    jr   nc,.jr_03_5020
    ld   a,[wD212_PlayerScreenXPosition]
    sub  e
    add  a,$04
    cp   a,$08
    jr   nc,.jr_03_5020
    pop  de
    jp   call_03_52be_Entity_CheckForDamagePlayer
.jr_03_5020:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  0,[hl]
    ret  
.jr_03_5035_CollisionHandler_UNK_19:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  0,[hl]
    ret  
.jr_03_5049_CollisionHandler_Geyser:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$01
    ret  nz
    ld   a,$50
    ld   [wD758],a
    ret  
.jr_03_505d_CollisionHandler_Triceratops:
    push de
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$12
    ld   l,a
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
    ld   a,[wD213_PlayerScreenYPosition]
    sub  c
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_508E
    ld   a,[wD212_PlayerScreenXPosition]
    sub  e
    add  a,$06
    cp   a,$0C
    jr   nc,.jr_03_508E
    pop  de
    jp   call_03_52be_Entity_CheckForDamagePlayer
.jr_03_508E:
    pop  de
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
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
    jp   call_00_3985
.jr_03_50ac_CollisionHandler_Gear:
    call call_03_519b_Entity_CheckPlayerInteraction
    push af
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    pop  af
    jr   nc,.jr_03_50C2
    cp   a,$01
    jr   nz,.jr_03_50C2
    set  0,[hl]
    ret  
.jr_03_50C2:
    res  0,[hl]
    ret  
.jr_03_50c5_CollisionHandler_ElectricBall:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$00
    jp   nz,.jr_03_4d82_CollisionHandler_UNK_09
    ret  
.jr_03_50d6_CollisionHandler_UNK_1E:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  7,[hl]
    jp   call_03_52be_Entity_CheckForDamagePlayer
.jr_03_50e7_CollisionHandler_Rocket:
    ld   hl,wD755
    ldi  a,[hl]
    or   [hl]
    ret  z
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  7,[hl]
    ld   a,$1F
    farcall call_02_4ccd
    ret  
.jr_03_5109_CollisionHandler_Cannon:
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
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  7,[hl]
    ret  
.jr_03_5129_CollisionHandler_PoweredWalkway:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   hl,wD751
    ldi  a,[hl]
    or   [hl]
    ret  z
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   l,[hl]
    dec  l
    ld   h,$00
    ld   de,wD5A3
    add  hl,de
    ld   a,[hl]
    ld   [hl],$06
    and  a
    ret  nz
    ld   c,$2B
    call call_00_112f
    ret  
.jr_03_514e_CollisionHandler_PowerUp:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ldi  a,[hl]
    ld   [wD751],a
    ld   a,[hl]
    ld   [wD752],a
    ret  
.jr_03_5163_CollisionHandler_DragonProjectile:
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    call call_03_52be_Entity_CheckForDamagePlayer
    jp   call_00_3910
.jr_03_516d_CollisionHandler_Rez:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$04
    ret  z
    jr   nc,.jr_03_5194
    call call_03_519b_Entity_CheckPlayerInteraction
    ret  nc
    cp   a,$00
    jp   z,call_03_52be_Entity_CheckForDamagePlayer
    ld   a,$04
    farcall call_02_7102_SetEntityAction
    ret  
.jr_03_5194:
    cp   a,$09
    ret  z
    cp   a,$0A
    ret  z
    ret  

call_03_519b_Entity_CheckPlayerInteraction:
    ld   H, $d2                                        ;; 03:519b $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:519d $fa $00 $d3
    or   A, $00                                        ;; 03:51a0 $f6 $00
    ld   L, A                                          ;; 03:51a2 $6f
    ld   L, [HL]                                       ;; 03:51a3 $6e
    ld   H, $00                                        ;; 03:51a4 $26 $00
    ld   BC, .data_03_522e                             ;; 03:51a6 $01 $2e $52
    add  HL, BC                                        ;; 03:51a9 $09
    ld   B, [HL]                                       ;; 03:51aa $46
    ld   H, $d2                                        ;; 03:51ab $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:51ad $fa $00 $d3
    or   A, $13                                        ;; 03:51b0 $f6 $13
    ld   L, A                                          ;; 03:51b2 $6f
    ld   A, E                                          ;; 03:51b3 $7b
    add  A, $08                                        ;; 03:51b4 $c6 $08
    ld   E, A                                          ;; 03:51b6 $5f
    ld   A, [wD213_PlayerScreenYPosition]                                    ;; 03:51b7 $fa $13 $d2
    sub  A, [HL]                                       ;; 03:51ba $96
    add  A, D                                          ;; 03:51bb $82
    sla  D                                             ;; 03:51bc $cb $22
    cp   A, D                                          ;; 03:51be $ba
    ret  NC                                            ;; 03:51bf $d0
    dec  L                                             ;; 03:51c0 $2d
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:51c1 $fa $12 $d2
    sub  A, [HL]                                       ;; 03:51c4 $96
    add  A, E                                          ;; 03:51c5 $83
    sla  E                                             ;; 03:51c6 $cb $23
    cp   A, E                                          ;; 03:51c8 $bb
    ret  NC                                            ;; 03:51c9 $d0
    ld   C, A                                          ;; 03:51ca $4f
    ld   HL, wD753                                     ;; 03:51cb $21 $53 $d7
    ld   A, [HL+]                                      ;; 03:51ce $2a
    or   A, [HL]                                       ;; 03:51cf $b6
    jr   NZ, .jr_03_51f5                               ;; 03:51d0 $20 $23
    ld   HL, wD755                                     ;; 03:51d2 $21 $55 $d7
    ld   A, [HL+]                                      ;; 03:51d5 $2a
    or   A, [HL]                                       ;; 03:51d6 $b6
    jr   NZ, .jr_03_51f5                               ;; 03:51d7 $20 $1c
    bit  1, B                                          ;; 03:51d9 $cb $48
    jr   Z, .jr_03_51fa                                ;; 03:51db $28 $1d
    ld   A, [wD201_PlayerEntity_ActionId]                                    ;; 03:51dd $fa $01 $d2
    and  A, $1f                                        ;; 03:51e0 $e6 $1f
    cp   A, $0d                                        ;; 03:51e2 $fe $0d
    jr   Z, .jr_03_51f5                                ;; 03:51e4 $28 $0f
    cp   A, $0c                                        ;; 03:51e6 $fe $0c
    jr   Z, .jr_03_51f5                                ;; 03:51e8 $28 $0b
    ld   A, [wD746_PlayerClimbingState]                                    ;; 03:51ea $fa $46 $d7
    cp   A, $01                                        ;; 03:51ed $fe $01
    jr   Z, .jr_03_51f5                                ;; 03:51ef $28 $04
    cp   A, $03                                        ;; 03:51f1 $fe $03
    jr   NZ, .jr_03_51fa                               ;; 03:51f3 $20 $05
.jr_03_51f5:
    ld   A, $ff                                        ;; 03:51f5 $3e $ff
    add  A, $02                                        ;; 03:51f7 $c6 $02
    ret                                                ;; 03:51f9 $c9
.jr_03_51fa:
    srl  E                                             ;; 03:51fa $cb $3b
    ld   A, C                                          ;; 03:51fc $79
    sub  A, E                                          ;; 03:51fd $93
    jr   NC, .jr_03_5202                               ;; 03:51fe $30 $02
    cpl                                                ;; 03:5200 $2f
    inc  A                                             ;; 03:5201 $3c
.jr_03_5202:
    ld   C, A                                          ;; 03:5202 $4f
    ld   A, E                                          ;; 03:5203 $7b
    sub  A, $08                                        ;; 03:5204 $d6 $08
    ld   E, A                                          ;; 03:5206 $5f
    ld   A, C                                          ;; 03:5207 $79
    cp   A, E                                          ;; 03:5208 $bb
    ret  NC                                            ;; 03:5209 $d0
    bit  2, B                                          ;; 03:520a $cb $50
    jr   Z, .jr_03_5229                                ;; 03:520c $28 $1b
    ld   A, [wD201_PlayerEntity_ActionId]                                    ;; 03:520e $fa $01 $d2
    and  A, $1f                                        ;; 03:5211 $e6 $1f
    cp   A, $09                                        ;; 03:5213 $fe $09
    jr   Z, .jr_03_521b                                ;; 03:5215 $28 $04
    cp   A, $0a                                        ;; 03:5217 $fe $0a
    jr   NZ, .jr_03_5229                               ;; 03:5219 $20 $0e
.jr_03_521b:
    ld   HL, wD760_PlayerYVelocity                                     ;; 03:521b $21 $60 $d7
    bit  7, [HL]                                       ;; 03:521e $cb $7e
    jr   Z, .jr_03_5229                                ;; 03:5220 $28 $07
    ld   [HL], $2a                                     ;; 03:5222 $36 $2a
    ld   A, $ff                                        ;; 03:5224 $3e $ff
    add  A, $03                                        ;; 03:5226 $c6 $03
    ret                                                ;; 03:5228 $c9
.jr_03_5229:
    ld   A, $ff                                        ;; 03:5229 $3e $ff
    add  A, $01                                        ;; 03:522b $c6 $01
    ret                                                ;; 03:522d $c9
.data_03_522e:
    db   $00 ; ENTITY_GEX
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_COLLECTIBLE_SPAWN
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_02
    db   $00 ; ENTITY_TV_BUTTON
    db   $00 ; ENTITY_RED_REMOTE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_SILVER_REMOTE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_GOLD_REMOTE
    db   $00 ; ENTITY_ENEMY_DEFEATED
    db   $00 ; ENTITY_UNK_08
    db   $00 ; ENTITY_SCREAM_TV_FALLING_PLATFORM
    db   $00 ; ENTITY_SCREAM_TV_MOVING_PLATFORM
    db   $00 ; ENTITY_SCREAM_TV_PUSH_BLOCK
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_PUMPKIN
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_FRANKIE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_SCREAM_TV_HEAD_GHOST
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_FLOATING_SKULL
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_ZOMBIE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_ZOMBIE_HEAD
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_SCREAM_TV_FALLING_AXE
    db   $00 ; ENTITY_SCREAM_TV_LANTERN
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_SCREAM_TV_BAT
    db   $00 ; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    db   $00 ; ENTITY_SCREAM_TV_DOOR_OPENING
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_SCREAM_TV_GHOST
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    db   $00 ; ENTITY_SCREAM_TV_VANISHING_PLATFORM
    db   $00 ; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_HARD_HEAD_AREA_OBJECT
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_MOVING_BEAR_TRAP
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_BUMBLEBEE
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_BOWLING_BALL
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_CACTUS
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_DOMINO
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_SHARK
    db   $00 ; ENTITY_TOON_TV_FLOWER
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_HUNTER
    db   PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_MUSHROOM
    db   $00 ; ENTITY_UNK_28
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_LIZARD
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_TOON_TV_HAPPY_FACE
    db   $00 ; ENTITY_TOON_TV_VANISHING_BLOCK
    db   $00 ; ENTITY_TOON_TV_MOVING_BLOCK
    db   $00 ; ENTITY_TOON_TV_MOVING_LOG
    db   $00 ; ENTITY_TOON_TV_STATIONARY_LOG
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_FLOWER_HAMMER
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_HUNTER_BULLET
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_TOON_TV_ROCKET
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_FAST_DINOSAUR
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_DRAGONFLY
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_EGG
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_35
    db   $00 ; ENTITY_UNK_36
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_PRE_HISTORY_FALLING_LAVA
    db   $00 ; ENTITY_PRE_HISTORY_LAVA_RAFT
    db   $00 ; ENTITY_PRE_HISTORY_MOVING_PLATFORM
    db   $00 ; ENTITY_UNK_3A
    db   $00 ; ENTITY_UNK_3B
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_PTEROSAUR
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_3D
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_PRE_HISTORY_FALLING_BOULDER
    db   $00 ; ENTITY_UNK_3F
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_ANT
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_FIRE_PLANT
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_PRE_HISTORY_GEYSER
    db   $00 ; ENTITY_UNK_46
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_DINOSAUR
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_PRE_HISTORY_TRICERATOPS
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_4A
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    db   PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_CANNON
    db   $00 ; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_DRAGONFLY
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_51
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_KUNG_FU_THEATER_LIZARD
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    db   PLAYER_CAN_ATTACK_ENTITY ; ENTITY_KUNG_FU_THEATER_TALL_JAR
    db   PLAYER_CAN_ATTACK_ENTITY ; ENTITY_KUNG_FU_THEATER_JAR
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_5C
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_5D
    db   $00 ; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    db   $00 ; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    db   $00 ; ENTITY_UNK_60
    db   $00 ; ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    db   $00 ; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    db   $00 ; ENTITY_UNK_63
    db   $00 ; ENTITY_UNK_64
    db   $00 ; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    db   $00 ; ENTITY_REZOPOLIS_MOVING_PLATFORM
    db   $00 ; ENTITY_REZOPOLIS_RED_PLATFORM
    db   $00 ; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    db   $00 ; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    db   PLAYER_CAN_ATTACK_ENTITY ; ENTITY_REZOPOLIS_TAILSPIN_GEAR
    db   $00 ; ENTITY_UNK_6B
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_6C
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_6D
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_REZOPOLIS_GREEN_MONSTER
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_6F
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_UNK_70
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_REZOPOLIS_PINCER
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_REZOPOLIS_FLAMETHROWER
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_REZOPOLIS_UFO
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_REZOPOLIS_ANT
    db   $00 ; ENTITY_REZOPOLIS_ANT_SPAWNER
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_CIRCUIT_CENTRAL_ANT
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CIRCUIT_CENTRAL_POWER_UP
    db   $00 ; ENTITY_UNK_79
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    db   $00 ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    db   $00 ; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    db   $00 ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    db   $00 ; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY | PLAYER_CAN_STOMP_ENTITY ; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    db   $00 ; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CHANNEL_Z_GUN_PROJECTILE
    db   PLAYER_CAN_TOUCH_ENTITY | PLAYER_CAN_ATTACK_ENTITY ; ENTITY_CHANNEL_Z_REZ
    db   $00 ; ENTITY_UNK_87
    db   $00 ; ENTITY_UNK_88
    db   $00 ; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    db   PLAYER_CAN_TOUCH_ENTITY ; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    db   $00 ; ENTITY_UNK_8B
    db   $00 ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    db   $00 ; ENTITY_UNK_8D
    db   $00 ; ENTITY_UNK_8E
    db   $00 ; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

call_03_52be_Entity_CheckForDamagePlayer:
    call call_00_075b_Player_CanBeDamaged                                  ;; 03:52be $cd $5b $07
    call Z, call_00_06bf_DealDamageToPlayer                               ;; 03:52c1 $cc $bf $06
    ret                                                ;; 03:52c4 $c9

call_03_52c5_CollisionHandler_StationaryPlatform:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:52c5 $fa $00 $d3
    or   A, $13                                        ;; 03:52c8 $f6 $13
    ld   L, A                                          ;; 03:52ca $6f
    ld   H, $d2                                        ;; 03:52cb $26 $d2
    ld   A, [wD213_PlayerScreenYPosition]                                    ;; 03:52cd $fa $13 $d2
    add  A, $0f                                        ;; 03:52d0 $c6 $0f
    cp   A, [HL]                                       ;; 03:52d2 $be
    jr   C, call_03_5314_StationaryPlatformCollisionHelper2                                ;; 03:52d3 $38 $3f
    sub  A, $1f                                        ;; 03:52d5 $d6 $1f
    ld   C, A                                          ;; 03:52d7 $4f
    ld   A, [HL]                                       ;; 03:52d8 $7e
    add  A, D                                          ;; 03:52d9 $82
    dec  A                                             ;; 03:52da $3d
    cp   A, C                                          ;; 03:52db $b9
    jr   C, jr_03_534d                                ;; 03:52dc $38 $6f
    dec  L                                             ;; 03:52de $2d
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:52df $fa $12 $d2
    sub  A, [HL]                                       ;; 03:52e2 $96
    add  A, E                                          ;; 03:52e3 $83
    bit  7, A                                          ;; 03:52e4 $cb $7f
    jr   NZ, .jr_03_52f8                               ;; 03:52e6 $20 $10
    sla  E                                             ;; 03:52e8 $cb $23
    sub  A, E                                          ;; 03:52ea $93
    jr   C, jr_03_534d                                ;; 03:52eb $38 $60
    ld   HL, wD75D_PlayerXSpeedPrev                                     ;; 03:52ed $21 $5d $d7
    cp   A, [HL]                                       ;; 03:52f0 $be
    jr   C, call_03_5360_StationaryPlatformCollisionHelper                                ;; 03:52f1 $38 $6d
    or   A, [HL]                                       ;; 03:52f3 $b6
    jr   Z, call_03_5360_StationaryPlatformCollisionHelper                                ;; 03:52f4 $28 $6a
    jr   jr_03_534d                                   ;; 03:52f6 $18 $55
.jr_03_52f8:
    cpl                                                ;; 03:52f8 $2f
    ld   HL, wD75D_PlayerXSpeedPrev                                     ;; 03:52f9 $21 $5d $d7
    cp   A, [HL]                                       ;; 03:52fc $be
    jr   C, call_03_5360_StationaryPlatformCollisionHelper                                ;; 03:52fd $38 $61
    or   A, [HL]                                       ;; 03:52ff $b6
    jr   Z, call_03_5360_StationaryPlatformCollisionHelper                                ;; 03:5300 $28 $5e
    jr   jr_03_534d                                   ;; 03:5302 $18 $49

call_03_5304_CollisionHandler_UNK_05:
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$13
    ld   l,a
    ld   h,$D2
    ld   a,[wD213_PlayerScreenYPosition]
    add  a,$0F
    cp   [hl]
    jr   nc,jr_03_534d

call_03_5314_StationaryPlatformCollisionHelper2:
    ld   C, A                                          ;; 03:5314 $4f
    dec  L                                             ;; 03:5315 $2d
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:5316 $fa $12 $d2
    sub  A, [HL]                                       ;; 03:5319 $96
    add  A, E                                          ;; 03:531a $83
    sla  E                                             ;; 03:531b $cb $23
    cp   A, E                                          ;; 03:531d $bb
    jr   NC, jr_03_534d                               ;; 03:531e $30 $2d
    inc  L                                             ;; 03:5320 $2c
    inc  C                                             ;; 03:5321 $0c
    ld   A, [HL]                                       ;; 03:5322 $7e
    sub  A, C                                          ;; 03:5323 $91
    ld   C, A                                          ;; 03:5324 $4f
    cp   A, $80                                        ;; 03:5325 $fe $80
    jr   NC, jr_03_534d                               ;; 03:5327 $30 $24
    ld   A, [wD760_PlayerYVelocity]                                    ;; 03:5329 $fa $60 $d7
    sra  A                                             ;; 03:532c $cb $2f
    sra  A                                             ;; 03:532e $cb $2f
    sra  A                                             ;; 03:5330 $cb $2f
    sra  A                                             ;; 03:5332 $cb $2f
    add  A, C                                          ;; 03:5334 $81
    bit  7, A                                          ;; 03:5335 $cb $7f
    jr   NZ, .jr_03_533f                               ;; 03:5337 $20 $06
    cp   A, $02                                        ;; 03:5339 $fe $02
    jr   C, .jr_03_533f                                ;; 03:533b $38 $02
    jr   jr_03_534d                                   ;; 03:533d $18 $0e
.jr_03_533f:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:533f $fa $00 $d3
    ld   [wD74D], A                                    ;; 03:5342 $ea $4d $d7
    ld   HL, wD74E                                     ;; 03:5345 $21 $4e $d7
    cp   A, [HL]                                       ;; 03:5348 $be
    ret  NZ                                            ;; 03:5349 $c0
    ld   [HL], $00                                     ;; 03:534a $36 $00
    ret                                                ;; 03:534c $c9
jr_03_534d:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:534d $fa $00 $d3
    ld   HL, wD74D                                     ;; 03:5350 $21 $4d $d7
    cp   A, [HL]                                       ;; 03:5353 $be
    jr   NZ, .jr_03_5358                               ;; 03:5354 $20 $02
    ld   [HL], $00                                     ;; 03:5356 $36 $00
.jr_03_5358:
    ld   HL, wD74E                                     ;; 03:5358 $21 $4e $d7
    cp   A, [HL]                                       ;; 03:535b $be
    ret  NZ                                            ;; 03:535c $c0
    ld   [HL], $00                                     ;; 03:535d $36 $00
    ret                                                ;; 03:535f $c9

call_03_5360_StationaryPlatformCollisionHelper:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:5360 $fa $00 $d3
    ld   HL, wD74D                                     ;; 03:5363 $21 $4d $d7
    cp   A, [HL]                                       ;; 03:5366 $be
    jr   NZ, .jr_03_536b                               ;; 03:5367 $20 $02
    ld   [HL], $00                                     ;; 03:5369 $36 $00
.jr_03_536b:
    ld   [wD74E], A                                    ;; 03:536b $ea $4e $d7
    ret                                                ;; 03:536e $c9

call_03_536f_CollisionHandler_MovingPlatform:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:536f $fa $00 $d3
    or   A, $13                                        ;; 03:5372 $f6 $13
    ld   L, A                                          ;; 03:5374 $6f
    ld   H, $d2                                        ;; 03:5375 $26 $d2
    ld   A, [wD213_PlayerScreenYPosition]                                    ;; 03:5377 $fa $13 $d2
    add  A, $0f                                        ;; 03:537a $c6 $0f
    cp   A, [HL]                                       ;; 03:537c $be
    jr   C, .jr_03_53ba                                ;; 03:537d $38 $3b
    sub  A, $1f                                        ;; 03:537f $d6 $1f
    ld   C, A                                          ;; 03:5381 $4f
    ld   A, [HL]                                       ;; 03:5382 $7e
    add  A, D                                          ;; 03:5383 $82
    dec  A                                             ;; 03:5384 $3d
    cp   A, C                                          ;; 03:5385 $b9
    jr   C, .jr_03_5405                                ;; 03:5386 $38 $7d
    dec  L                                             ;; 03:5388 $2d
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:5389 $fa $12 $d2
    sub  A, [HL]                                       ;; 03:538c $96
    add  A, E                                          ;; 03:538d $83
    bit  7, A                                          ;; 03:538e $cb $7f
    jr   NZ, .jr_03_53a8                               ;; 03:5390 $20 $16
    sla  E                                             ;; 03:5392 $cb $23
    sub  A, E                                          ;; 03:5394 $93
    jr   C, .jr_03_5405                                ;; 03:5395 $38 $6e
    ld   C, A                                          ;; 03:5397 $4f
    call call_03_5427_MovingPlatformCollisionHelper                                  ;; 03:5398 $cd $27 $54
    ld   A, C                                          ;; 03:539b $79
    sub  A, B                                          ;; 03:539c $90
    add  A, E                                          ;; 03:539d $83
    add  A, D                                          ;; 03:539e $82
    bit  7, A                                          ;; 03:539f $cb $7f
    jr   NZ, .jr_03_5418                               ;; 03:53a1 $20 $75
    and  A, A                                          ;; 03:53a3 $a7
    jr   Z, .jr_03_5418                                ;; 03:53a4 $28 $72
    jr   .jr_03_5405                                   ;; 03:53a6 $18 $5d
.jr_03_53a8:
    cpl                                                ;; 03:53a8 $2f
    ld   C, A                                          ;; 03:53a9 $4f
    call call_03_5427_MovingPlatformCollisionHelper                                  ;; 03:53aa $cd $27 $54
    ld   A, C                                          ;; 03:53ad $79
    add  A, B                                          ;; 03:53ae $80
    sub  A, E                                          ;; 03:53af $93
    sub  A, D                                          ;; 03:53b0 $92
    bit  7, A                                          ;; 03:53b1 $cb $7f
    jr   NZ, .jr_03_5418                               ;; 03:53b3 $20 $63
    and  A, A                                          ;; 03:53b5 $a7
    jr   Z, .jr_03_5418                                ;; 03:53b6 $28 $60
    jr   .jr_03_5405                                   ;; 03:53b8 $18 $4b
.jr_03_53ba:
    ld   C, A                                          ;; 03:53ba $4f
    dec  L                                             ;; 03:53bb $2d
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:53bc $fa $12 $d2
    sub  A, [HL]                                       ;; 03:53bf $96
    add  A, E                                          ;; 03:53c0 $83
    sla  E                                             ;; 03:53c1 $cb $23
    cp   A, E                                          ;; 03:53c3 $bb
    jr   NC, .jr_03_5405                               ;; 03:53c4 $30 $3f
    inc  L                                             ;; 03:53c6 $2c
    inc  C                                             ;; 03:53c7 $0c
    ld   A, [HL]                                       ;; 03:53c8 $7e
    sub  A, C                                          ;; 03:53c9 $91
    ld   C, A                                          ;; 03:53ca $4f
    cp   A, $80                                        ;; 03:53cb $fe $80
    jr   NC, .jr_03_5405                               ;; 03:53cd $30 $36
    ld   A, [wD760_PlayerYVelocity]                                    ;; 03:53cf $fa $60 $d7
    sra  A                                             ;; 03:53d2 $cb $2f
    sra  A                                             ;; 03:53d4 $cb $2f
    sra  A                                             ;; 03:53d6 $cb $2f
    sra  A                                             ;; 03:53d8 $cb $2f
    add  A, C                                          ;; 03:53da $81
    ld   C, A                                          ;; 03:53db $4f
    ld   A, L                                          ;; 03:53dc $7d
    xor  A, $0d                                        ;; 03:53dd $ee $0d
    ld   L, A                                          ;; 03:53df $6f
    ld   E, [HL]                                       ;; 03:53e0 $5e
    ld   E, $10                                        ;; 03:53e1 $1e $10
    sra  E                                             ;; 03:53e3 $cb $2b
    sra  E                                             ;; 03:53e5 $cb $2b
    sra  E                                             ;; 03:53e7 $cb $2b
    sra  E                                             ;; 03:53e9 $cb $2b
    ld   A, C                                          ;; 03:53eb $79
    sub  A, E                                          ;; 03:53ec $93
    bit  7, A                                          ;; 03:53ed $cb $7f
    jr   NZ, .jr_03_53f7                               ;; 03:53ef $20 $06
    cp   A, $02                                        ;; 03:53f1 $fe $02
    jr   C, .jr_03_53f7                                ;; 03:53f3 $38 $02
    jr   .jr_03_5405                                   ;; 03:53f5 $18 $0e
.jr_03_53f7:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:53f7 $fa $00 $d3
    ld   [wD74D], A                                    ;; 03:53fa $ea $4d $d7
    ld   HL, wD74F                                     ;; 03:53fd $21 $4f $d7
    cp   A, [HL]                                       ;; 03:5400 $be
    ret  NZ                                            ;; 03:5401 $c0
    ld   [HL], $00                                     ;; 03:5402 $36 $00
    ret                                                ;; 03:5404 $c9
.jr_03_5405:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:5405 $fa $00 $d3
    ld   HL, wD74D                                     ;; 03:5408 $21 $4d $d7
    cp   A, [HL]                                       ;; 03:540b $be
    jr   NZ, .jr_03_5410                               ;; 03:540c $20 $02
    ld   [HL], $00                                     ;; 03:540e $36 $00
.jr_03_5410:
    ld   HL, wD74F                                     ;; 03:5410 $21 $4f $d7
    cp   A, [HL]                                       ;; 03:5413 $be
    ret  NZ                                            ;; 03:5414 $c0
    ld   [HL], $00                                     ;; 03:5415 $36 $00
    ret                                                ;; 03:5417 $c9
.jr_03_5418:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:5418 $fa $00 $d3
    ld   HL, wD74D                                     ;; 03:541b $21 $4d $d7
    cp   A, [HL]                                       ;; 03:541e $be
    jr   NZ, .jr_03_5423                               ;; 03:541f $20 $02
    ld   [HL], $00                                     ;; 03:5421 $36 $00
.jr_03_5423:
    ld   [wD74F], A                                    ;; 03:5423 $ea $4f $d7
    ret                                                ;; 03:5426 $c9

call_03_5427_MovingPlatformCollisionHelper:
    ld   A, L                                          ;; 03:5427 $7d
    xor  A, $0e                                        ;; 03:5428 $ee $0e
    ld   L, A                                          ;; 03:542a $6f
    ld   B, [HL]                                       ;; 03:542b $46
    sra  B                                             ;; 03:542c $cb $28
    sra  B                                             ;; 03:542e $cb $28
    sra  B                                             ;; 03:5430 $cb $28
    sra  B                                             ;; 03:5432 $cb $28
    ld   A, [wD75C]                                    ;; 03:5434 $fa $5c $d7
    ld   D, A                                          ;; 03:5437 $57
    ld   A, [wD75D_PlayerXSpeedPrev]                                    ;; 03:5438 $fa $5d $d7
    ld   E, A                                          ;; 03:543b $5f
    ld   HL, wD20D_PlayerFacingAngle                                     ;; 03:543c $21 $0d $d2
    bit  5, [HL]                                       ;; 03:543f $cb $6e
    ret  Z                                             ;; 03:5441 $c8
    cpl                                                ;; 03:5442 $2f
    inc  A                                             ;; 03:5443 $3c
    ld   E, A                                          ;; 03:5444 $5f
    ret                                                ;; 03:5445 $c9
