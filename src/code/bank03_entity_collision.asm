; This file handles gex's collision with objects (enemies, tv switches, remotes, etc.)

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
    dw   .jr_03_4ce5_CollisionHandler_None
    dw   .jr_03_4ce6                                 ;; 03:4c9d pP
    dw   .jr_03_4d33                                      ;; 03:4c9f ??
    dw   call_03_52c5                                  ;; 03:4ca1 pP
    dw   call_03_536f                                  ;; 03:4ca3 pP
    dw   call_03_5304                                      ;; 03:4ca5 ??
    dw   .jr_03_4dbc                                 ;; 03:4ca7 pP
    dw   .jr_03_4d3f
    dw   .jr_03_4d56
    dw   .jr_03_4d82
    dw   .jr_03_4d8c        ;; 03:4ca9 ????????
    dw   .jr_03_4d9a
    dw   .jr_03_4dc8
    dw   .jr_03_4dd4
    dw   .jr_03_4df4        ;; 03:4cb1 ????????
    dw   .jr_03_4e20                                 ;; 03:4cb9 pP
    dw   .jr_03_4e7f                                      ;; 03:4cbb ??
    dw   .jr_03_4eb4                                 ;; 03:4cbd pP
    dw   .jr_03_4ec6
    dw   .jr_03_4ec7
    dw   .jr_03_4f14
    dw   .jr_03_4f20        ;; 03:4cbf ????????
    dw   .jr_03_4fc7
    dw   .jr_03_4fcf
    dw   .jr_03_4fd9                  ;; 03:4cc7 ??????
    dw   .jr_03_5035
    dw   .jr_03_5049
    dw   .jr_03_505d
    dw   .jr_03_50ac        ;; 03:4ccd ????????
    dw   .jr_03_50c5
    dw   .jr_03_50d6
    dw   .jr_03_50e7
    dw   .jr_03_5109        ;; 03:4cd5 ????????
    dw   .jr_03_5129
    dw   .jr_03_514e
    dw   .jr_03_5163
    dw   .jr_03_516d        ;; 03:4cdd ????????
.jr_03_4ce5_CollisionHandler_None:
    ret        	;; 03:4ce5 $c9
.jr_03_4ce6:
    call call_03_519b                                  ;; 03:4ce6 $cd $9b $51
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
.jr_03_4d33:
    db   $cd, $9b, $51, $d0, $cd, $31, $39, $3e        ;; 03:4d33 ????????
    db   $04, $c3, $47, $06
.jr_03_4d3f:
	db   $cd, $9b, $51, $d0        ;; 03:4d3b ????????
    db   $fa, $4c, $d6, $f6, $10, $ea, $4c, $d6        ;; 03:4d43 ????????
    db   $0e, $03, $cd, $2f, $11, $cd, $31, $39        ;; 03:4d4b ????????
    db   $c3, $3c, $39
.jr_03_4d56:
	db   $fa, $21, $d6, $e6, $10        ;; 03:4d53 ????????
    db   $c0, $cd, $9b, $51, $d0, $21, $24, $d6        ;; 03:4d5b ????????
    db   $6e, $26, $00, $11, $29, $d6, $19, $7e        ;; 03:4d63 ????????
    db   $f6, $20, $77, $cd, $31, $39, $cd, $3c        ;; 03:4d6b ????????
    db   $39, $3e, $1e, $ea, $9d, $d5, $3e, $02        ;; 03:4d73 ????????
    db   $21, $cd, $4c, $cd, $78, $10, $c9
.jr_03_4d82:
	db   $cd        ;; 03:4d7b ????????
    db   $9b, $51, $d0, $fe, $00, $cc, $be, $52        ;; 03:4d83 ????????
    db   $c9
.jr_03_4d8c:
	db   $3e, $01, $ea, $57, $d7, $cd, $9b        ;; 03:4d8b ????????
    db   $51, $d0, $af, $ea, $57, $d7, $c9
.jr_03_4d9a:
	db   $cd        ;; 03:4d93 ????????
    db   $9b, $51, $d0, $fe, $00, $20, $03, $c3        ;; 03:4d9b ????????
    db   $be, $52, $26, $d2, $fa, $00, $d3, $f6        ;; 03:4da3 ????????
    db   $17, $6f, $cb, $46, $c0, $cb, $c6, $2c        ;; 03:4dab ????????
    db   $36, $3c, $2c, $2c, $7e, $a7, $c8, $35        ;; 03:4db3 ????????
    db   $c9                                           ;; 03:4dbb ?
.jr_03_4dbc:
    call call_03_519b                                  ;; 03:4dbc $cd $9b $51
    ret  NC                                            ;; 03:4dbf $d0
    cp   A, $00                                        ;; 03:4dc0 $fe $00
    jp   Z, call_03_52be                               ;; 03:4dc2 $ca $be $52
    jp   call_00_3985                                  ;; 03:4dc5 $c3 $85 $39
.jr_03_4dc8:
    db   $cd, $9b, $51, $d0, $fe, $00, $cc, $be        ;; 03:4dc8 ????????
    db   $52, $c3, $31, $39
.jr_03_4dd4:
	db   $cd, $9b, $51, $d0        ;; 03:4dd0 ????????
    db   $21, $57, $d7, $34, $35, $28, $06, $fe        ;; 03:4dd8 ????????
    db   $00, $ca, $be, $52, $c9, $fe, $01, $c2        ;; 03:4de0 ????????
    db   $be, $52, $26, $d2, $fa, $00, $d3, $b5        ;; 03:4de8 ????????
    db   $6f, $cb, $c6, $c9
.jr_03_4df4:
	db   $cd, $9b, $51, $d0        ;; 03:4df0 ????????
    db   $fe, $00, $ca, $be, $52, $fa, $00, $d3        ;; 03:4df8 ????????
    db   $f5, $26, $d2, $3e, $20, $6f, $7e, $fe        ;; 03:4e00 ????????
    db   $12, $28, $07, $7d, $c6, $20, $20, $f5        ;; 03:4e08 ????????
    db   $18, $07, $7d, $ea, $00, $d3, $cd, $85        ;; 03:4e10 ????????
    db   $39, $f1, $ea, $00, $d3, $c3, $31, $39        ;; 03:4e18 ????????
.jr_03_4e20:
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
    call call_00_075b                                  ;; 03:4e65 $cd $5b $07
    ret  NZ                                            ;; 03:4e68 $c0
    call call_03_52be                                  ;; 03:4e69 $cd $be $52
    ld   A, $77                                        ;; 03:4e6c $3e $77
    ld   [wD750], A                                    ;; 03:4e6e $ea $50 $d7
    ld   A, $19                                        ;; 03:4e71 $3e $19
    ld   [wD59D_ReturnBank], A                                    ;; 03:4e73 $ea $9d $d5
    ld   A, Bank02                                        ;; 03:4e76 $3e $02
    ld   HL, call_02_4ccd                             ;; 03:4e78 $21 $cd $4c
    call call_00_1078_FarCall                                  ;; 03:4e7b $cd $78 $10
    ret                                                ;; 03:4e7e $c9
.jr_03_4e7f:
    db   $26, $d2, $fa, $00, $d3, $f6, $17, $6f        ;; 03:4e7f ????????
    db   $cb, $46, $c0, $cd, $9b, $51, $d0, $fe        ;; 03:4e87 ????????
    db   $00, $ca, $be, $52, $cd, $17, $38, $28        ;; 03:4e8f ????????
    db   $0b, $26, $d2, $fa, $00, $d3, $f6, $17        ;; 03:4e97 ????????
    db   $6f, $cb, $c6, $c9, $cd, $85, $39, $21        ;; 03:4e9f ????????
    db   $73, $d7, $34, $7e, $fe, $02, $c0, $21        ;; 03:4ea7 ????????
    db   $99, $d7, $36, $02, $c9                       ;; 03:4eaf ?????
.jr_03_4eb4:
    call call_03_519b                                  ;; 03:4eb4 $cd $9b $51
    ret  NC                                            ;; 03:4eb7 $d0
    cp   A, $00                                        ;; 03:4eb8 $fe $00
    ret  Z                                             ;; 03:4eba $c8
    ld   H, $d2                                        ;; 03:4ebb $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:4ebd $fa $00 $d3
    or   A, $17                                        ;; 03:4ec0 $f6 $17
    ld   L, A                                          ;; 03:4ec2 $6f
    set  0, [HL]                                       ;; 03:4ec3 $cb $c6
    ret                                                ;; 03:4ec5 $c9
.jr_03_4ec6:
    db   $c9
.jr_03_4ec7:
	db   $26, $d2, $fa, $00, $d3, $f6, $12        ;; 03:4ec6 ????????
    db   $6f, $2a, $c6, $04, $4f, $7e, $c6, $08        ;; 03:4ece ????????
    db   $47, $cd, $f5, $39, $6b, $62, $3e, $08        ;; 03:4ed6 ????????
    db   $f5, $c5, $e5, $2a, $cb, $47, $28, $1d        ;; 03:4ede ????????
    db   $23, $78, $96, $23, $47, $fa, $13, $d2        ;; 03:4ee6 ????????
    db   $90, $c6, $06, $fe, $0c, $30, $0e, $23        ;; 03:4eee ????????
    db   $2a, $81, $4f, $fa, $12, $d2, $91, $c6        ;; 03:4ef6 ????????
    db   $04, $fe, $08, $38, $0b, $e1, $01, $05        ;; 03:4efe ????????
    db   $00, $09, $c1, $f1, $3d, $20, $d1, $c9        ;; 03:4f06 ????????
    db   $e1, $c1, $f1, $c3, $be, $52
.jr_03_4f14:
	db   $cd, $9b        ;; 03:4f0e ????????
    db   $51, $d0, $fe, $01, $c0, $0e, $01, $c3        ;; 03:4f16 ????????
    db   $02, $38
.jr_03_4f20:
	db   $d5, $26, $d2, $fa, $00, $d3        ;; 03:4f1e ????????
    db   $f6, $01, $6f, $7e, $e6, $1f, $fe, $00        ;; 03:4f26 ????????
    db   $28, $3f, $fe, $02, $28, $3b, $fe, $03        ;; 03:4f2e ????????
    db   $28, $0b, $e5, $7d, $ee, $06, $6f, $7e        ;; 03:4f36 ????????
    db   $e1, $fe, $02, $38, $2c, $7d, $ee, $13        ;; 03:4f3e ????????
    db   $6f, $5e, $2c, $4e, $ee, $1f, $6f, $7b        ;; 03:4f46 ????????
    db   $c6, $10, $cb, $6e, $28, $02, $d6, $20        ;; 03:4f4e ????????
    db   $5f, $fa, $13, $d2, $91, $c6, $10, $fe        ;; 03:4f56 ????????
    db   $20, $30, $0e, $fa, $12, $d2, $93, $c6        ;; 03:4f5e ????????
    db   $06, $fe, $0c, $30, $04, $d1, $c3, $be        ;; 03:4f66 ????????
    db   $52, $d1, $cd, $9b, $51, $d0, $fe, $00        ;; 03:4f6e ????????
    db   $ca, $be, $52, $26, $d2, $fa, $00, $d3        ;; 03:4f76 ????????
    db   $f6, $19, $6f, $7e, $a7, $28, $02, $35        ;; 03:4f7e ????????
    db   $c9, $fa, $00, $d3, $07, $07, $07, $5f        ;; 03:4f86 ????????
    db   $16, $00, $21, $01, $d3, $19, $4e, $21        ;; 03:4f8e ????????
    db   $bd, $4f, $11, $03, $00, $fa, $24, $d6        ;; 03:4f96 ????????
    db   $be, $20, $06, $23, $79, $be, $28, $0a        ;; 03:4f9e ????????
    db   $2b, $19, $7e, $fe, $ff, $20, $ee, $c3        ;; 03:4fa6 ????????
    db   $85, $39, $23, $6e, $26, $00, $11, $8b        ;; 03:4fae ????????
    db   $d7, $19, $36, $02, $c3, $85, $39, $0d        ;; 03:4fb6 ????????
    db   $07, $08, $05, $05, $00, $05, $06, $08        ;; 03:4fbe ????????
    db   $ff
.jr_03_4fc7:
    db   $d5, $cd, $20, $4e, $d1, $c3, $82        ;; 03:4fc6 ????????
    db   $4d
.jr_03_4fcf:
	db   $cd, $9b, $51, $d0, $3e, $7f, $ea        ;; 03:4fce ????????
    db   $58, $d7, $c9
.jr_03_4fd9:
	db   $d5, $26, $d2, $fa, $00        ;; 03:4fd6 ????????
    db   $d3, $f6, $01, $6f, $7e, $e6, $1f, $fe        ;; 03:4fde ????????
    db   $01, $20, $37, $e5, $7d, $ee, $06, $6f        ;; 03:4fe6 ????????
    db   $7e, $e1, $fe, $02, $38, $2c, $7d, $ee        ;; 03:4fee ????????
    db   $13, $6f, $5e, $2c, $4e, $ee, $1f, $6f        ;; 03:4ff6 ????????
    db   $7b, $c6, $0e, $cb, $6e, $28, $02, $d6        ;; 03:4ffe ????????
    db   $1c, $5f, $fa, $13, $d2, $91, $c6, $10        ;; 03:5006 ????????
    db   $fe, $20, $30, $0e, $fa, $12, $d2, $93        ;; 03:500e ????????
    db   $c6, $04, $fe, $08, $30, $04, $d1, $c3        ;; 03:5016 ????????
    db   $be, $52, $d1, $cd, $9b, $51, $d0, $fe        ;; 03:501e ????????
    db   $00, $ca, $be, $52, $26, $d2, $fa, $00        ;; 03:5026 ????????
    db   $d3, $f6, $17, $6f, $cb, $c6, $c9
.jr_03_5035:
	db   $cd        ;; 03:502e ????????
    db   $9b, $51, $d0, $fe, $00, $ca, $be, $52        ;; 03:5036 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $17, $6f        ;; 03:503e ????????
    db   $cb, $c6, $c9
.jr_03_5049:
	db   $26, $d2, $fa, $00, $d3        ;; 03:5046 ????????
    db   $f6, $01, $6f, $7e, $e6, $1f, $fe, $01        ;; 03:504e ????????
    db   $c0, $3e, $50, $ea, $58, $d7, $c9
.jr_03_505d:
	db   $d5        ;; 03:5056 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $12, $6f        ;; 03:505e ????????
    db   $5e, $2c, $4e, $ee, $1f, $6f, $7b, $c6        ;; 03:5066 ????????
    db   $14, $cb, $6e, $28, $02, $d6, $28, $5f        ;; 03:506e ????????
    db   $fa, $13, $d2, $91, $c6, $06, $fe, $0c        ;; 03:5076 ????????
    db   $30, $0e, $fa, $12, $d2, $93, $c6, $06        ;; 03:507e ????????
    db   $fe, $0c, $30, $04, $d1, $c3, $be, $52        ;; 03:5086 ????????
    db   $d1, $cd, $9b, $51, $d0, $fe, $00, $ca        ;; 03:508e ????????
    db   $be, $52, $26, $d2, $3e, $20, $6f, $7e        ;; 03:5096 ????????
    db   $fe, $49, $20, $02, $36, $ff, $7d, $c6        ;; 03:509e ????????
    db   $20, $20, $f3, $c3, $85, $39
.jr_03_50ac:
	db   $cd, $9b        ;; 03:50a6 ????????
    db   $51, $f5, $26, $d2, $fa, $00, $d3, $f6        ;; 03:50ae ????????
    db   $17, $6f, $f1, $30, $07, $fe, $01, $20        ;; 03:50b6 ????????
    db   $03, $cb, $c6, $c9, $cb, $86, $c9
.jr_03_50c5:
	db   $26        ;; 03:50be ????????
    db   $d2, $fa, $00, $d3, $f6, $01, $6f, $7e        ;; 03:50c6 ????????
    db   $e6, $1f, $fe, $00, $c2, $82, $4d, $c9        ;; 03:50ce ????????
.jr_03_50d6:
    db   $cd, $9b, $51, $d0, $26, $d2, $fa, $00        ;; 03:50d6 ????????
    db   $d3, $f6, $17, $6f, $cb, $fe, $c3, $be        ;; 03:50de ????????
    db   $52
.jr_03_50e7:
	db   $21, $55, $d7, $2a, $b6, $c8, $cd        ;; 03:50e6 ????????
    db   $9b, $51, $d0, $26, $d2, $fa, $00, $d3        ;; 03:50ee ????????
    db   $f6, $17, $6f, $cb, $fe, $3e, $1f, $ea        ;; 03:50f6 ????????
    db   $9d, $d5, $3e, $02, $21, $cd, $4c, $cd        ;; 03:50fe ????????
    db   $78, $10, $c9
.jr_03_5109:
	db   $26, $d2, $3e, $20, $6f        ;; 03:5106 ????????
    db   $7e, $fe, $4d, $c8, $7d, $c6, $20, $20        ;; 03:510e ????????
    db   $f6, $cd, $9b, $51, $d0, $fe, $02, $c0        ;; 03:5116 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $17, $6f        ;; 03:511e ????????
    db   $cb, $fe, $c9
.jr_03_5129:
	db   $cd, $9b, $51, $d0, $21        ;; 03:5126 ????????
    db   $51, $d7, $2a, $b6, $c8, $26, $d2, $fa        ;; 03:512e ????????
    db   $00, $d3, $f6, $19, $6f, $6e, $2d, $26        ;; 03:5136 ????????
    db   $00, $11, $a3, $d5, $19, $7e, $36, $06        ;; 03:513e ????????
    db   $a7, $c0, $0e, $2b, $cd, $2f, $11, $c9        ;; 03:5146 ????????
.jr_03_514e:
    db   $cd, $9b, $51, $d0, $26, $d2, $fa, $00        ;; 03:514e ????????
    db   $d3, $f6, $19, $6f, $2a, $ea, $51, $d7        ;; 03:5156 ????????
    db   $7e, $ea, $52, $d7, $c9
.jr_03_5163:
	db   $cd, $9b, $51        ;; 03:515e ????????
    db   $d0, $cd, $be, $52, $c3, $10, $39
.jr_03_516d:
	db   $26        ;; 03:5166 ????????
    db   $d2, $fa, $00, $d3, $f6, $01, $6f, $7e        ;; 03:516e ????????
    db   $e6, $1f, $fe, $04, $c8, $30, $17, $cd        ;; 03:5176 ????????
    db   $9b, $51, $d0, $fe, $00, $ca, $be, $52        ;; 03:517e ????????
    db   $3e, $04, $ea, $9d, $d5, $3e, $02, $21        ;; 03:5186 ????????
    db   $02, $71, $cd, $78, $10, $c9, $fe, $09        ;; 03:518e ????????
    db   $c8, $fe, $0a, $c8, $c9                       ;; 03:5196 ?????

call_03_519b:
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
    ld   A, [wD201_PlayerObject_ActionId]                                    ;; 03:51dd $fa $01 $d2
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
    ld   A, [wD201_PlayerObject_ActionId]                                    ;; 03:520e $fa $01 $d2
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
    db   $00, $03, $01, $00, $00, $03, $03, $00        ;; 03:522e ?.??????
    db   $00, $00, $00, $00, $07, $07, $03, $07        ;; 03:5236 ????.???
    db   $07, $01, $07, $07, $01, $00, $07, $00        ;; 03:523e ????????
    db   $00, $03, $03, $00, $00, $01, $01, $01        ;; 03:5246 ????????
    db   $07, $01, $05, $01, $07, $00, $07, $06        ;; 03:524e ????.??.
    db   $00, $07, $07, $00, $00, $00, $00, $01        ;; 03:5256 ??.?????
    db   $01, $01, $07, $07, $07, $01, $00, $01        ;; 03:525e ????????
    db   $00, $00, $00, $00, $07, $01, $01, $00        ;; 03:5266 ????????
    db   $07, $07, $07, $07, $01, $01, $00, $07        ;; 03:526e ????????
    db   $07, $01, $01, $01, $04, $00, $07, $01        ;; 03:5276 ????????
    db   $01, $01, $01, $07, $07, $07, $07, $07        ;; 03:527e ????????
    db   $01, $01, $02, $02, $01, $01, $00, $00        ;; 03:5286 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 03:528e ????????
    db   $00, $00, $02, $00, $01, $01, $07, $01        ;; 03:5296 ????????
    db   $01, $07, $01, $07, $07, $00, $07, $07        ;; 03:529e ????????
    db   $01, $00, $07, $00, $01, $00, $00, $00        ;; 03:52a6 ????????
    db   $07, $01, $00, $01, $01, $01, $03, $00        ;; 03:52ae ????????
    db   $00, $00, $01, $00, $00, $00, $00, $00        ;; 03:52b6 ????????

call_03_52be:
    call call_00_075b                                  ;; 03:52be $cd $5b $07
    call Z, call_00_06bf_DealDamageToPlayer                               ;; 03:52c1 $cc $bf $06
    ret                                                ;; 03:52c4 $c9

call_03_52c5:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:52c5 $fa $00 $d3
    or   A, $13                                        ;; 03:52c8 $f6 $13
    ld   L, A                                          ;; 03:52ca $6f
    ld   H, $d2                                        ;; 03:52cb $26 $d2
    ld   A, [wD213_PlayerScreenYPosition]                                    ;; 03:52cd $fa $13 $d2
    add  A, $0f                                        ;; 03:52d0 $c6 $0f
    cp   A, [HL]                                       ;; 03:52d2 $be
    jr   C, call_03_5314                                ;; 03:52d3 $38 $3f
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
    jr   C, call_03_5360                                ;; 03:52f1 $38 $6d
    or   A, [HL]                                       ;; 03:52f3 $b6
    jr   Z, call_03_5360                                ;; 03:52f4 $28 $6a
    jr   jr_03_534d                                   ;; 03:52f6 $18 $55
.jr_03_52f8:
    cpl                                                ;; 03:52f8 $2f
    ld   HL, wD75D_PlayerXSpeedPrev                                     ;; 03:52f9 $21 $5d $d7
    cp   A, [HL]                                       ;; 03:52fc $be
    jr   C, call_03_5360                                ;; 03:52fd $38 $61
    or   A, [HL]                                       ;; 03:52ff $b6
    jr   Z, call_03_5360                                ;; 03:5300 $28 $5e
    jr   jr_03_534d                                   ;; 03:5302 $18 $49

call_03_5304:
    db   $fa, $00, $d3, $f6, $13, $6f, $26, $d2        ;; 03:5304 ????????
    db   $fa, $13, $d2, $c6, $0f, $be, $30, $39        ;; 03:530c ????????

call_03_5314:
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

call_03_5360:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 03:5360 $fa $00 $d3
    ld   HL, wD74D                                     ;; 03:5363 $21 $4d $d7
    cp   A, [HL]                                       ;; 03:5366 $be
    jr   NZ, .jr_03_536b                               ;; 03:5367 $20 $02
    ld   [HL], $00                                     ;; 03:5369 $36 $00
.jr_03_536b:
    ld   [wD74E], A                                    ;; 03:536b $ea $4e $d7
    ret                                                ;; 03:536e $c9

call_03_536f:
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
    call call_03_5427                                  ;; 03:5398 $cd $27 $54
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
    call call_03_5427                                  ;; 03:53aa $cd $27 $54
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

call_03_5427:
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
