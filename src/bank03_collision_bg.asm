; This file handles gex's collision with background walls, floors, ceilings, etc.

INCBIN "./data/bg_collision_data.bin"

entry_03_4900_UpdateCollision:
    ld   HL, wD585_CollisionFlags                                     ;; 03:4900 $21 $85 $d5
    ld   A, [HL]                                       ;; 03:4903 $7e
    ld   [HL], $00                                     ;; 03:4904 $36 $00
    ld   [wD584_CollisionFlagsPrev], A                                    ;; 03:4906 $ea $84 $d5
    ld   A, [wD201_PlayerObject_ActionId]                                    ;; 03:4909 $fa $01 $d2
    and  A, PlayerAction_unk_1f                                        ;; 03:490c $e6 $1f
    cp   A, PlayerAction_unk_1f                                        ;; 03:490e $fe $1f
    jr   NZ, call_03_4915_ProcessCollision                                ;; 03:4910 $20 $03
    set  7, [HL]                                       ;; 03:4912 $cb $fe
    ret                                                ;; 03:4914 $c9

call_03_4915_ProcessCollision:
    ld   A, [wD74D]                                    ;; 03:4915 $fa $4d $d7
    and  A, A                                          ;; 03:4918 $a7
    jr   Z, .jr_03_491d                                ;; 03:4919 $28 $02
    set  7, [HL]                                       ;; 03:491b $cb $fe ; set 0x80
.jr_03_491d:
    ld   A, [wD746_PlayerClimbingState]                                    ;; 03:491d $fa $46 $d7
    cp   A, $ff                                        ;; 03:4920 $fe $ff
    jp   NZ, call_03_4ac4_ProcessClimbCollision        ; 03:4922 $c2 $c4 $4a ; if climb state byte is not ff, run alternate collision func
    ld   A, [wD760_PlayerYVelocity]                                    ;; 03:4925 $fa $60 $d7
    sub  A, $02                                        ;; 03:4928 $d6 $02
    bit  7, A                                          ;; 03:492a $cb $7f
    jr   Z, .jr_03_4934                                ;; 03:492c $28 $06
    cp   A, $c0                                        ;; 03:492e $fe $c0
    jr   NC, .jr_03_4934                               ;; 03:4930 $30 $02
    ld   A, $c0                                        ;; 03:4932 $3e $c0
.jr_03_4934:
    sra  A                                             ;; 03:4934 $cb $2f
    sra  A                                             ;; 03:4936 $cb $2f
    sra  A                                             ;; 03:4938 $cb $2f
    sra  A                                             ;; 03:493a $cb $2f
    ld   [wD75F_PlayerYVelocityRelated], A                                    ;; 03:493c $ea $5f $d7
    call call_03_4ab3                                  ;; 03:493f $cd $b3 $4a
    jp   Z, .jp_03_4a05                                ;; 03:4942 $ca $05 $4a
    ld   E, A                                          ;; 03:4945 $5f
    bit  7, E                                          ;; 03:4946 $cb $7b
    jr   Z, .jr_03_4954                                ;; 03:4948 $28 $0a
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:494a $fa $0e $d2
    and  A, $07                                        ;; 03:494d $e6 $07
    add  A, E                                          ;; 03:494f $83
    ld   C, $ff                                        ;; 03:4950 $0e $ff
    jr   .jr_03_495c                                   ;; 03:4952 $18 $08
.jr_03_4954:
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4954 $fa $0e $d2
    and  A, $07                                        ;; 03:4957 $e6 $07
    add  A, E                                          ;; 03:4959 $83
    ld   C, $01                                        ;; 03:495a $0e $01
.jr_03_495c:
    push DE                                            ;; 03:495c $d5
    ld   A, E                                          ;; 03:495d $7b
    ld   HL, wD20E_PlayerXPosition                                     ;; 03:495e $21 $0e $d2
    add  A, [HL]                                       ;; 03:4961 $86
    add  A, C                                          ;; 03:4962 $81
    ld   C, A                                          ;; 03:4963 $4f
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4964 $fa $10 $d2
    sub  A, $10                                        ;; 03:4967 $d6 $10
    ld   HL, wD75F_PlayerYVelocityRelated                                     ;; 03:4969 $21 $5f $d7
    sub  A, [HL]                                       ;; 03:496c $96
    and  A, $f8                                        ;; 03:496d $e6 $f8
    ld   L, A                                          ;; 03:496f $6f
    ld   H, $32                                        ;; 03:4970 $26 $32
    add  HL, HL                                        ;; 03:4972 $29
    add  HL, HL                                        ;; 03:4973 $29
    ld   A, C                                          ;; 03:4974 $79
    rrca                                               ;; 03:4975 $0f
    rrca                                               ;; 03:4976 $0f
    rrca                                               ;; 03:4977 $0f
    and  A, $1f                                        ;; 03:4978 $e6 $1f
    or   A, L                                          ;; 03:497a $b5
    ld   L, A                                          ;; 03:497b $6f
    ld   D, $48                                        ;; 03:497c $16 $48
    ld   C, $00                                        ;; 03:497e $0e $00
    ld   B, $04                                        ;; 03:4980 $06 $04
.jr_03_4982:
    ld   E, [HL]                                       ;; 03:4982 $5e
    ld   A, [DE]                                       ;; 03:4983 $1a
    or   A, C                                          ;; 03:4984 $b1
    ld   C, A                                          ;; 03:4985 $4f
    ld   A, L                                          ;; 03:4986 $7d
    add  A, $20                                        ;; 03:4987 $c6 $20
    ld   L, A                                          ;; 03:4989 $6f
    ld   A, H                                          ;; 03:498a $7c
    adc  A, $00                                        ;; 03:498b $ce $00
    res  2, A                                          ;; 03:498d $cb $97
    ld   H, A                                          ;; 03:498f $67
    dec  B                                             ;; 03:4990 $05
    jr   NZ, .jr_03_4982                               ;; 03:4991 $20 $ef
    pop  DE                                            ;; 03:4993 $d1
    bit  0, C                                          ;; 03:4994 $cb $41
    jr   Z, .jr_03_49bd                                ;; 03:4996 $28 $25
    ld   A, $01                                        ;; 03:4998 $3e $01
    ld   [wD74C], A                                    ;; 03:499a $ea $4c $d7
    ld   HL, wD20E_PlayerXPosition                                     ;; 03:499d $21 $0e $d2
    bit  7, E                                          ;; 03:49a0 $cb $7b
    jr   NZ, .jr_03_49ab                               ;; 03:49a2 $20 $07
    ld   A, $07                                        ;; 03:49a4 $3e $07
    sub  A, [HL]                                       ;; 03:49a6 $96
    and  A, $07                                        ;; 03:49a7 $e6 $07
    jr   .jr_03_49b0                                   ;; 03:49a9 $18 $05
.jr_03_49ab:
    ld   A, [HL]                                       ;; 03:49ab $7e
    and  A, $07                                        ;; 03:49ac $e6 $07
    cpl                                                ;; 03:49ae $2f
    inc  A                                             ;; 03:49af $3c
.jr_03_49b0:
    xor  A, A                                          ;; 03:49b0 $af
    ld   [wD75C], A                                    ;; 03:49b1 $ea $5c $d7
    xor  A, A                                          ;; 03:49b4 $af
    ld   [wD75D_PlayerXSpeedPrev], A                                    ;; 03:49b5 $ea $5d $d7
    ld   HL, wD585_CollisionFlags                                     ;; 03:49b8 $21 $85 $d5
    set  6, [HL]                                       ;; 03:49bb $cb $f6
.jr_03_49bd:
    ld   HL, wD585_CollisionFlags                                     ;; 03:49bd $21 $85 $d5
    bit  7, [HL]                                       ;; 03:49c0 $cb $7e
    jr   NZ, .jp_03_4a05                               ;; 03:49c2 $20 $41
    call call_03_4ab3                                  ;; 03:49c4 $cd $b3 $4a
    jr   Z, .jp_03_4a05                                ;; 03:49c7 $28 $3c
    bit  7, A                                          ;; 03:49c9 $cb $7f
    jr   NZ, .jr_03_49e2                               ;; 03:49cb $20 $15
    ld   B, $00                                        ;; 03:49cd $06 $00
    ld   C, $01                                        ;; 03:49cf $0e $01
.jr_03_49d1:
    push AF                                            ;; 03:49d1 $f5
    push BC                                            ;; 03:49d2 $c5
    call call_03_4bd4                                  ;; 03:49d3 $cd $d4 $4b
    pop  BC                                            ;; 03:49d6 $c1
    and  A, A                                          ;; 03:49d7 $a7
    jr   Z, .jr_03_49db                                ;; 03:49d8 $28 $01
    dec  B                                             ;; 03:49da $05
.jr_03_49db:
    inc  C                                             ;; 03:49db $0c
    pop  AF                                            ;; 03:49dc $f1
    dec  A                                             ;; 03:49dd $3d
    jr   NZ, .jr_03_49d1                               ;; 03:49de $20 $f1
    jr   .jr_03_49f5                                   ;; 03:49e0 $18 $13
.jr_03_49e2:
    ld   B, $00                                        ;; 03:49e2 $06 $00
    ld   C, $ff                                        ;; 03:49e4 $0e $ff
.jr_03_49e6:
    push AF                                            ;; 03:49e6 $f5
    push BC                                            ;; 03:49e7 $c5
    call call_03_4bd4                                  ;; 03:49e8 $cd $d4 $4b
    pop  BC                                            ;; 03:49eb $c1
    and  A, A                                          ;; 03:49ec $a7
    jr   Z, .jr_03_49f0                                ;; 03:49ed $28 $01
    dec  B                                             ;; 03:49ef $05
.jr_03_49f0:
    dec  C                                             ;; 03:49f0 $0d
    pop  AF                                            ;; 03:49f1 $f1
    inc  A                                             ;; 03:49f2 $3c
    jr   NZ, .jr_03_49e6                               ;; 03:49f3 $20 $f1
.jr_03_49f5:
    ld   A, B                                          ;; 03:49f5 $78
    cpl                                                ;; 03:49f6 $2f
    inc  A                                             ;; 03:49f7 $3c
    ld   HL, wD585_CollisionFlags                                     ;; 03:49f8 $21 $85 $d5
    or   A, [HL]                                       ;; 03:49fb $b6
    ld   [HL], A                                       ;; 03:49fc $77
    and  A, $0f                                        ;; 03:49fd $e6 $0f
    jr   Z, .jp_03_4a05                                ;; 03:49ff $28 $04
    set  7, [HL]                                       ;; 03:4a01 $cb $fe
    jr   .jp_03_4a05                                   ;; 03:4a03 $18 $00
.jp_03_4a05:
    xor  A, A                                          ;; 03:4a05 $af
    ld   [wD761_PlayerFallingFlag], A                                    ;; 03:4a06 $ea $61 $d7
    ld   HL, wD585_CollisionFlags                                     ;; 03:4a09 $21 $85 $d5
    bit  7, [HL]                                       ;; 03:4a0c $cb $7e
    ret  NZ                                            ;; 03:4a0e $c0
    ld   A, [wD760_PlayerYVelocity]                                    ;; 03:4a0f $fa $60 $d7
    and  A, A                                          ;; 03:4a12 $a7
    jr   Z, .jr_03_4a19                                ;; 03:4a13 $28 $04
    bit  7, A                                          ;; 03:4a15 $cb $7f
    jr   Z, .jr_03_4a7c                                ;; 03:4a17 $28 $63
.jr_03_4a19:
    ld   B, $00                                        ;; 03:4a19 $06 $00
    call call_03_4ab3                                  ;; 03:4a1b $cd $b3 $4a
    ld   C, A                                          ;; 03:4a1e $4f
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4a1f $fa $10 $d2
    add  A, $10                                        ;; 03:4a22 $c6 $10
    add  A, B                                          ;; 03:4a24 $80
    ld   B, A                                          ;; 03:4a25 $47
    and  A, $f8                                        ;; 03:4a26 $e6 $f8
    ld   L, A                                          ;; 03:4a28 $6f
    ld   H, $32                                        ;; 03:4a29 $26 $32
    add  HL, HL                                        ;; 03:4a2b $29
    add  HL, HL                                        ;; 03:4a2c $29
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4a2d $fa $0e $d2
    add  A, C                                          ;; 03:4a30 $81
    ld   C, A                                          ;; 03:4a31 $4f
    rrca                                               ;; 03:4a32 $0f
    rrca                                               ;; 03:4a33 $0f
    rrca                                               ;; 03:4a34 $0f
    and  A, $1f                                        ;; 03:4a35 $e6 $1f
    or   A, L                                          ;; 03:4a37 $b5
    ld   L, A                                          ;; 03:4a38 $6f
    ld   A, [HL]                                       ;; 03:4a39 $7e ; load tile collision type from wC800_CurrentCollisionData
    ld   DE, $20                                       ;; 03:4a3a $11 $20 $00
    add  HL, DE                                        ;; 03:4a3d $19
    res  2, H                                          ;; 03:4a3e $cb $94
    ld   E, A                                          ;; 03:4a40 $5f
    ld   D, [HL]                                       ;; 03:4a41 $56
    ld   A, C                                          ;; 03:4a42 $79
    and  A, $07                                        ;; 03:4a43 $e6 $07
    add  A, $ab                                        ;; 03:4a45 $c6 $ab
    ld   L, A                                          ;; 03:4a47 $6f
    ld   A, $00                                        ;; 03:4a48 $3e $00
    adc  A, $4a                                        ;; 03:4a4a $ce $4a
    ld   H, A                                          ;; 03:4a4c $67
    ld   C, [HL]                                       ;; 03:4a4d $4e
    ld   A, B                                          ;; 03:4a4e $78
    and  A, $07                                        ;; 03:4a4f $e6 $07
    add  A, $40                                        ;; 03:4a51 $c6 $40
    ld   H, A                                          ;; 03:4a53 $67
    ld   L, E                                          ;; 03:4a54 $6b
    ld   B, $00                                        ;; 03:4a55 $06 $00
.jr_03_4a57:
    ld   A, [HL]                                       ;; 03:4a57 $7e
    and  A, C                                          ;; 03:4a58 $a1
    jr   NZ, .jr_03_4a6e                               ;; 03:4a59 $20 $13
    inc  H                                             ;; 03:4a5b $24
    ld   A, H                                          ;; 03:4a5c $7c
    cp   A, $48                                        ;; 03:4a5d $fe $48
    jr   NZ, .jr_03_4a64                               ;; 03:4a5f $20 $03
    ld   H, $40                                        ;; 03:4a61 $26 $40
    ld   L, D                                          ;; 03:4a63 $6a
.jr_03_4a64:
    inc  B                                             ;; 03:4a64 $04
    ld   A, B                                          ;; 03:4a65 $78
    cp   A, $05                                        ;; 03:4a66 $fe $05
    jr   NZ, .jr_03_4a57                               ;; 03:4a68 $20 $ed
    ld   A, $04                                        ;; 03:4a6a $3e $04
    jr   .jr_03_4a74                                   ;; 03:4a6c $18 $06
.jr_03_4a6e:
    ld   HL, wD585_CollisionFlags                                     ;; 03:4a6e $21 $85 $d5
    set  7, [HL]                                       ;; 03:4a71 $cb $fe
    ld   A, B                                          ;; 03:4a73 $78
.jr_03_4a74:
    swap A                                             ;; 03:4a74 $cb $37
    cpl                                                ;; 03:4a76 $2f
    inc  A                                             ;; 03:4a77 $3c
    ld   [wD761_PlayerFallingFlag], A                                    ;; 03:4a78 $ea $61 $d7
    ret                                                ;; 03:4a7b $c9
.jr_03_4a7c:
    call call_03_4ab3                                  ;; 03:4a7c $cd $b3 $4a
    ld   C, A                                          ;; 03:4a7f $4f
    ld   A, [wD760_PlayerYVelocity]                                    ;; 03:4a80 $fa $60 $d7
    swap A                                             ;; 03:4a83 $cb $37
    and  A, $0f                                        ;; 03:4a85 $e6 $0f
    add  A, $11                                        ;; 03:4a87 $c6 $11
    ld   B, A                                          ;; 03:4a89 $47
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4a8a $fa $10 $d2
    sub  A, B                                          ;; 03:4a8d $90
    and  A, $f8                                        ;; 03:4a8e $e6 $f8
    ld   L, A                                          ;; 03:4a90 $6f
    ld   H, $32                                        ;; 03:4a91 $26 $32
    add  HL, HL                                        ;; 03:4a93 $29
    add  HL, HL                                        ;; 03:4a94 $29
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4a95 $fa $0e $d2
    add  A, C                                          ;; 03:4a98 $81
    rrca                                               ;; 03:4a99 $0f
    rrca                                               ;; 03:4a9a $0f
    rrca                                               ;; 03:4a9b $0f
    and  A, $1f                                        ;; 03:4a9c $e6 $1f
    or   A, L                                          ;; 03:4a9e $b5
    ld   L, A                                          ;; 03:4a9f $6f
    ld   L, [HL]                                       ;; 03:4aa0 $6e
    ld   H, $48                                        ;; 03:4aa1 $26 $48
    bit  1, [HL]                                       ;; 03:4aa3 $cb $4e
    ret  Z                                             ;; 03:4aa5 $c8
    xor  A, A                                          ;; 03:4aa6 $af
    ld   [wD760_PlayerYVelocity], A                                    ;; 03:4aa7 $ea $60 $d7
    ret                                                ;; 03:4aaa $c9
    db   $80, $40, $20, $10, $08, $04, $02, $01        ;; 03:4aab ........

call_03_4ab3:
    ld   A, [wD75D_PlayerXSpeedPrev]                                    ;; 03:4ab3 $fa $5d $d7
    ld   HL, wD20D_PlayerFacingAngle                                     ;; 03:4ab6 $21 $0d $d2
    bit  5, [HL]                                       ;; 03:4ab9 $cb $6e
    jr   Z, .jr_03_4abf                                ;; 03:4abb $28 $02 ; jump if not facing left
    cpl                                                ;; 03:4abd $2f
    inc  A                                             ;; 03:4abe $3c
.jr_03_4abf:
    ld   HL, wD75C                                     ;; 03:4abf $21 $5c $d7
    add  A, [HL]                                       ;; 03:4ac2 $86
    ret                                                ;; 03:4ac3 $c9

call_03_4ac4_ProcessClimbCollision:
    ld   HL, wD585_CollisionFlags                                     ;; 03:4ac4 $21 $85 $d5
    set  7, [HL]                                       ;; 03:4ac7 $cb $fe
    ld   A, [wD746_PlayerClimbingState]                                    ;; 03:4ac9 $fa $46 $d7
    cp   A, $06                                        ;; 03:4acc $fe $06
    ret  NC                                            ;; 03:4ace $d0
    ld   HL, wD746_PlayerClimbingState                                     ;; 03:4acf $21 $46 $d7
    ld   A, [HL]                                       ;; 03:4ad2 $7e
    add  A, A                                          ;; 03:4ad3 $87
    ld   HL, wD20D_PlayerFacingAngle                                     ;; 03:4ad4 $21 $0d $d2
    bit  5, [HL]                                       ;; 03:4ad7 $cb $6e
    jr   Z, .jr_03_4adc                                ;; 03:4ad9 $28 $01
    inc  A                                             ;; 03:4adb $3c
.jr_03_4adc:
    ld   L, A                                          ;; 03:4adc $6f
    ld   H, $00                                        ;; 03:4add $26 $00
    add  HL, HL                                        ;; 03:4adf $29
    ld   DE, .data_03_4b66                             ;; 03:4ae0 $11 $66 $4b
    add  HL, DE                                        ;; 03:4ae3 $19
    ld   A, [HL+]                                      ;; 03:4ae4 $2a
    ld   H, [HL]                                       ;; 03:4ae5 $66
    ld   L, A                                          ;; 03:4ae6 $6f
    ld   A, [wD75A_CurrentInputs]                                    ;; 03:4ae7 $fa $5a $d7
    and  A, [HL]                                       ;; 03:4aea $a6
    ret  Z                                             ;; 03:4aeb $c8
    inc  HL                                            ;; 03:4aec $23
    ld   B, [HL]                                       ;; 03:4aed $46
    inc  HL                                            ;; 03:4aee $23
    ld   E, [HL]                                       ;; 03:4aef $5e
    inc  HL                                            ;; 03:4af0 $23
    ld   D, [HL]                                       ;; 03:4af1 $56
    inc  HL                                            ;; 03:4af2 $23
.jr_03_4af3:
    cp   A, [HL]                                       ;; 03:4af3 $be
    jr   Z, .jr_03_4b03                                ;; 03:4af4 $28 $0d
    add  HL, DE                                        ;; 03:4af6 $19
    dec  B                                             ;; 03:4af7 $05
    jr   NZ, .jr_03_4af3                               ;; 03:4af8 $20 $f9
.jr_03_4afa:
    ld   A, [wD75A_CurrentInputs]                                    ;; 03:4afa $fa $5a $d7
    and  A, $0f                                        ;; 03:4afd $e6 $0f
    ld   [wD75A_CurrentInputs], A                                    ;; 03:4aff $ea $5a $d7
    ret                                                ;; 03:4b02 $c9
.jr_03_4b03:
    inc  HL                                            ;; 03:4b03 $23
    ld   A, [HL+]                                      ;; 03:4b04 $2a
    ld   C, A                                          ;; 03:4b05 $4f
    ld   A, [HL+]                                      ;; 03:4b06 $2a
    ld   B, A                                          ;; 03:4b07 $47
    push HL                                            ;; 03:4b08 $e5
    call call_03_4c5a                                  ;; 03:4b09 $cd $5a $4c
    pop  HL                                            ;; 03:4b0c $e1
    bit  6, B                                          ;; 03:4b0d $cb $70
    jr   Z, .jr_03_4b2b                                ;; 03:4b0f $28 $1a
    ld   A, [wD75A_CurrentInputs]                                    ;; 03:4b11 $fa $5a $d7
    cp   A, $80                                        ;; 03:4b14 $fe $80
    jr   NZ, .jr_03_4afa                               ;; 03:4b16 $20 $e2
    ld   A, [wD746_PlayerClimbingState]                                    ;; 03:4b18 $fa $46 $d7
    cp   A, $02                                        ;; 03:4b1b $fe $02
    ld   A, $06                                        ;; 03:4b1d $3e $06
    jr   C, .jr_03_4b23                                ;; 03:4b1f $38 $02
    ld   A, $07                                        ;; 03:4b21 $3e $07
.jr_03_4b23:
    ld   [wD746_PlayerClimbingState], A                                    ;; 03:4b23 $ea $46 $d7
    xor  A, A                                          ;; 03:4b26 $af
    ld   [wD747], A                                    ;; 03:4b27 $ea $47 $d7
    ret                                                ;; 03:4b2a $c9
.jr_03_4b2b:
    ld   A, [HL+]                                      ;; 03:4b2b $2a
    ld   C, A                                          ;; 03:4b2c $4f
    ld   A, [HL+]                                      ;; 03:4b2d $2a
    ld   B, A                                          ;; 03:4b2e $47
    call call_03_4c5a                                  ;; 03:4b2f $cd $5a $4c
    bit  7, B                                          ;; 03:4b32 $cb $78
    jr   NZ, .jr_03_4b4a                               ;; 03:4b34 $20 $14
    ld   A, [wD746_PlayerClimbingState]                                    ;; 03:4b36 $fa $46 $d7
    cp   A, $02                                        ;; 03:4b39 $fe $02
    jr   C, .jr_03_4afa                                ;; 03:4b3b $38 $bd
    ld   A, [wD75A_CurrentInputs]                                    ;; 03:4b3d $fa $5a $d7
    and  A, $40                                        ;; 03:4b40 $e6 $40
    jr   Z, .jr_03_4afa                                ;; 03:4b42 $28 $b6
    ld   A, $08                                        ;; 03:4b44 $3e $08
    ld   [wD746_PlayerClimbingState], A                                    ;; 03:4b46 $ea $46 $d7
    ret                                                ;; 03:4b49 $c9
.jr_03_4b4a:
    ld   A, [wD746_PlayerClimbingState]                                    ;; 03:4b4a $fa $46 $d7
    cp   A, $02                                        ;; 03:4b4d $fe $02
    ret  C                                             ;; 03:4b4f $d8
    ld   A, C                                          ;; 03:4b50 $79
    cp   A, $30                                        ;; 03:4b51 $fe $30
    ret  C                                             ;; 03:4b53 $d8
    cp   A, $34                                        ;; 03:4b54 $fe $34
    ret  NC                                            ;; 03:4b56 $d0
    sub  A, $30                                        ;; 03:4b57 $d6 $30
    ld   [wD749], A                                    ;; 03:4b59 $ea $49 $d7
    ld   A, $09                                        ;; 03:4b5c $3e $09
    ld   [wD746_PlayerClimbingState], A                                    ;; 03:4b5e $ea $46 $d7
    xor  A, A                                          ;; 03:4b61 $af
    ld   [wD747], A                                    ;; 03:4b62 $ea $47 $d7
    ret                                                ;; 03:4b65 $c9
.data_03_4b66:
    dw   .data_03_4b7e, .data_03_4b7e, .data_03_4b7e, .data_03_4b7e     ;; 03:4b66 pP
    dw   .data_03_4baa, .data_03_4bb8, .data_03_4baa, .data_03_4bb8,
    dw   .data_03_4bc6, .data_03_4bc6, .data_03_4bc6, .data_03_4bc6
.data_03_4b7e:
    db   $f0, $08                                      ;; 03:4b7e ?.
    dw   $0005                                         ;; 03:4b80 wW
    db   $40, $00, $ef, $00, $ff, $80, $00, $10        ;; 03:4b82 ?....?..
    db   $00, $01, $20, $f7, $00, $ff, $00, $10        ;; 03:4b8a ..?....?
    db   $09, $00, $01, $00, $60, $f7, $ef, $ff        ;; 03:4b92 ....?...
    db   $ff, $a0, $f7, $10, $ff, $01, $50, $09        ;; 03:4b9a .?....?.
    db   $ef, $01, $ff, $90, $09, $10, $01, $01        ;; 03:4ba2 ...?....
.data_03_4baa:
    db   $c0, $02, $05, $00, $40, $00, $ef, $09        ;; 03:4baa ????????
    db   $ff, $80, $00, $10, $09, $01
.data_03_4bb8:
    db   $c0, $02        ;; 03:4bb2 ????????
    db   $05, $00, $40, $00, $ef, $f7, $ff, $80        ;; 03:4bba ????????
    db   $00, $10, $f7, $01
.data_03_4bc6:
    db   $30, $02, $05, $00        ;; 03:4bc2 ????????
    db   $20, $f7, $f7, $ff, $f7, $10, $09, $f7        ;; 03:4bca ????????
    db   $01, $f7                                      ;; 03:4bd2 ??

call_03_4bd4:
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4bd4 $fa $10 $d2
    add  A, $0f                                        ;; 03:4bd7 $c6 $0f
    add  A, B                                          ;; 03:4bd9 $80
    ld   B, A                                          ;; 03:4bda $47
    and  A, $f8                                        ;; 03:4bdb $e6 $f8
    ld   L, A                                          ;; 03:4bdd $6f
    ld   H, $32                                        ;; 03:4bde $26 $32
    add  HL, HL                                        ;; 03:4be0 $29
    add  HL, HL                                        ;; 03:4be1 $29
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4be2 $fa $0e $d2
    add  A, C                                          ;; 03:4be5 $81
    ld   C, A                                          ;; 03:4be6 $4f
    rrca                                               ;; 03:4be7 $0f
    rrca                                               ;; 03:4be8 $0f
    rrca                                               ;; 03:4be9 $0f
    and  A, $1f                                        ;; 03:4bea $e6 $1f
    or   A, L                                          ;; 03:4bec $b5
    ld   L, A                                          ;; 03:4bed $6f
    ld   E, [HL]                                       ;; 03:4bee $5e
    ld   A, B                                          ;; 03:4bef $78
    and  A, $07                                        ;; 03:4bf0 $e6 $07
    add  A, $40                                        ;; 03:4bf2 $c6 $40
    ld   D, A                                          ;; 03:4bf4 $57
    ld   A, C                                          ;; 03:4bf5 $79
    and  A, $07                                        ;; 03:4bf6 $e6 $07
    ld   L, A                                          ;; 03:4bf8 $6f
    ld   H, $00                                        ;; 03:4bf9 $26 $00
    ld   BC, .data_03_4c02                             ;; 03:4bfb $01 $02 $4c
    add  HL, BC                                        ;; 03:4bfe $09
    ld   A, [DE]                                       ;; 03:4bff $1a
    and  A, [HL]                                       ;; 03:4c00 $a6
    ret                                                ;; 03:4c01 $c9
.data_03_4c02:
    db   $80, $40, $20, $10, $08, $04, $02, $01        ;; 03:4c02 ????????

entry_03_4c0a_UpdateTilesTouchingPlayer:
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4c0a $fa $10 $d2
    and  A, $f8                                        ;; 03:4c0d $e6 $f8
    ld   L, A                                          ;; 03:4c0f $6f
    ld   H, $32                                        ;; 03:4c10 $26 $32
    add  HL, HL                                        ;; 03:4c12 $29
    add  HL, HL                                        ;; 03:4c13 $29
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4c14 $fa $0e $d2
    rrca                                               ;; 03:4c17 $0f
    rrca                                               ;; 03:4c18 $0f
    rrca                                               ;; 03:4c19 $0f
    and  A, $1f                                        ;; 03:4c1a $e6 $1f
    or   A, L                                          ;; 03:4c1c $b5
    ld   L, A                                          ;; 03:4c1d $6f
    ld   A, [HL]                                       ;; 03:4c1e $7e
    ld   [wD764_TileTypeBehindGexsBody], A                                    ;; 03:4c1f $ea $64 $d7
    ld   DE, $20                                       ;; 03:4c22 $11 $20 $00
    add  HL, DE                                        ;; 03:4c25 $19
    res  2, H                                          ;; 03:4c26 $cb $94
    ld   A, [HL]                                       ;; 03:4c28 $7e
    ld   [wD765_TileTypeBehindGexsBody], A             ;; 03:4c29 $ea $65 $d7
    add  HL, DE                                        ;; 03:4c2c $19
    res  2, H                                          ;; 03:4c2d $cb $94
    ld   A, [HL]                                       ;; 03:4c2f $7e ; load tile collision type from wC800_CurrentCollisionData
    ld   [wD767_FloorTileType], A                      ;; 03:4c30 $ea $67 $d7
    ld   C, $09                                        ;; 03:4c33 $0e $09
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 03:4c35 $fa $0d $d2
    cp   A, $00                                        ;; 03:4c38 $fe $00
    jr   Z, .jr_03_4c3e                                ;; 03:4c3a $28 $02
    ld   C, $f7                                        ;; 03:4c3c $0e $f7
.jr_03_4c3e:
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4c3e $fa $10 $d2
    sub  A, $08                                        ;; 03:4c41 $d6 $08
    and  A, $f8                                        ;; 03:4c43 $e6 $f8
    ld   L, A                                          ;; 03:4c45 $6f
    ld   H, $32                                        ;; 03:4c46 $26 $32
    add  HL, HL                                        ;; 03:4c48 $29
    add  HL, HL                                        ;; 03:4c49 $29
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4c4a $fa $0e $d2
    add  A, C                                          ;; 03:4c4d $81
    rrca                                               ;; 03:4c4e $0f
    rrca                                               ;; 03:4c4f $0f
    rrca                                               ;; 03:4c50 $0f
    and  A, $1f                                        ;; 03:4c51 $e6 $1f
    or   A, L                                          ;; 03:4c53 $b5
    ld   L, A                                          ;; 03:4c54 $6f
    ld   A, [HL]                                       ;; 03:4c55 $7e
    ld   [wD766_TileTypeBehindGexsFace], A                                    ;; 03:4c56 $ea $66 $d7
    ret                                                ;; 03:4c59 $c9

call_03_4c5a:
    ld   A, [wD210_PlayerYPosition]                                    ;; 03:4c5a $fa $10 $d2
    add  A, B                                          ;; 03:4c5d $80
    and  A, $f8                                        ;; 03:4c5e $e6 $f8
    ld   L, A                                          ;; 03:4c60 $6f
    ld   H, $32                                        ;; 03:4c61 $26 $32
    add  HL, HL                                        ;; 03:4c63 $29
    add  HL, HL                                        ;; 03:4c64 $29
    ld   A, [wD20E_PlayerXPosition]                                    ;; 03:4c65 $fa $0e $d2
    add  A, C                                          ;; 03:4c68 $81
    rrca                                               ;; 03:4c69 $0f
    rrca                                               ;; 03:4c6a $0f
    rrca                                               ;; 03:4c6b $0f
    and  A, $1f                                        ;; 03:4c6c $e6 $1f
    or   A, L                                          ;; 03:4c6e $b5
    ld   L, A                                          ;; 03:4c6f $6f
    ld   C, [HL]                                       ;; 03:4c70 $4e
    ld   B, $48                                        ;; 03:4c71 $06 $48
    ld   A, [BC]                                       ;; 03:4c73 $0a
    ld   B, A                                          ;; 03:4c74 $47
    ret                                                ;; 03:4c75 $c9
