;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; Note: All of the code in this file is identical in banks 0x21, 0x22, 0x23, and 0x24. This is a duplicated 
; audio engine. The data that follows the code is different and contains different songs or sound effects.

SECTION "bank21", ROMX[$4000], BANK[$21]
entry_21_4000:
    ld   HL, data_21_4460                              ;; 21:4000 $21 $60 $44
    ld   A, L                                          ;; 21:4003 $7d
    ld   [wDFAE], A                                    ;; 21:4004 $ea $ae $df
    ld   A, H                                          ;; 21:4007 $7c
    ld   [wDFAF], A                                    ;; 21:4008 $ea $af $df
    xor  A, A                                          ;; 21:400b $af
    ld   [wDFC2], A                                    ;; 21:400c $ea $c2 $df
    ld   [wDFC1], A                                    ;; 21:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 21:4012 $e0 $25
    ld   [wDFB8], A                                    ;; 21:4014 $ea $b8 $df
    ld   [wDFB9], A                                    ;; 21:4017 $ea $b9 $df
    ld   [wDFBA], A                                    ;; 21:401a $ea $ba $df
    ld   [wDFBB], A                                    ;; 21:401d $ea $bb $df
    ld   [wDFBC], A                                    ;; 21:4020 $ea $bc $df
    ld   [wDFCF], A                                    ;; 21:4023 $ea $cf $df
    ld   [wDFCB], A                                    ;; 21:4026 $ea $cb $df
    ld   [wDFCC], A                                    ;; 21:4029 $ea $cc $df
    ld   [wDFCD], A                                    ;; 21:402c $ea $cd $df
    ld   [wDFCE], A                                    ;; 21:402f $ea $ce $df
    ld   HL, wDFD2                                     ;; 21:4032 $21 $d2 $df
    ld   C, $14                                        ;; 21:4035 $0e $14
    xor  A, A                                          ;; 21:4037 $af
jr_21_4038:
    ld   [HL+], A                                      ;; 21:4038 $22
    dec  C                                             ;; 21:4039 $0d
    jr   NZ, jr_21_4038                                ;; 21:403a $20 $fc
    ld   HL, wDFE6                                     ;; 21:403c $21 $e6 $df
    ld   C, $10                                        ;; 21:403f $0e $10
    xor  A, A                                          ;; 21:4041 $af
.jr_21_4042:
    ld   [HL+], A                                      ;; 21:4042 $22
    dec  C                                             ;; 21:4043 $0d
    jr   NZ, .jr_21_4042                               ;; 21:4044 $20 $fc
    ret                                                ;; 21:4046 $c9

call_21_4047:
    ld   [wDFD0], A                                    ;; 21:4047 $ea $d0 $df
    ld   A, $01                                        ;; 21:404a $3e $01
    ld   [wDFD1], A                                    ;; 21:404c $ea $d1 $df
    ld   A, [wDFD0]                                    ;; 21:404f $fa $d0 $df
    sla  A                                             ;; 21:4052 $cb $27
    ld   E, A                                          ;; 21:4054 $5f
    sla  A                                             ;; 21:4055 $cb $27
    ld   C, A                                          ;; 21:4057 $4f
    sla  A                                             ;; 21:4058 $cb $27
    add  A, E                                          ;; 21:405a $83
    ld   DE, data_21_439e                              ;; 21:405b $11 $9e $43
    add  A, E                                          ;; 21:405e $83
    ld   E, A                                          ;; 21:405f $5f
    jr   NC, .jr_21_4063                               ;; 21:4060 $30 $01
    inc  D                                             ;; 21:4062 $14
.jr_21_4063:
    ld   HL, wDFD2                                     ;; 21:4063 $21 $d2 $df
    ld   A, [wDFD0]                                    ;; 21:4066 $fa $d0 $df
    add  A, C                                          ;; 21:4069 $81
    add  A, L                                          ;; 21:406a $85
    ld   L, A                                          ;; 21:406b $6f
    jr   NC, .jr_21_406f                               ;; 21:406c $30 $01
    inc  H                                             ;; 21:406e $24
.jr_21_406f:
    ld   B, $ff                                        ;; 21:406f $06 $ff
.jr_21_4071:
    ld   A, [DE]                                       ;; 21:4071 $1a
    and  A, A                                          ;; 21:4072 $a7
    jr   Z, .jr_21_407f                                ;; 21:4073 $28 $0a
    inc  DE                                            ;; 21:4075 $13
    ld   C, A                                          ;; 21:4076 $4f
    ld   A, [BC]                                       ;; 21:4077 $0a
    ld   C, A                                          ;; 21:4078 $4f
    ld   A, [DE]                                       ;; 21:4079 $1a
    inc  DE                                            ;; 21:407a $13
    and  A, C                                          ;; 21:407b $a1
    ld   [HL+], A                                      ;; 21:407c $22
    jr   .jr_21_4071                                   ;; 21:407d $18 $f2
.jr_21_407f:
    ld   A, [wDFAE]                                    ;; 21:407f $fa $ae $df
    ld   E, A                                          ;; 21:4082 $5f
    ld   A, [wDFAF]                                    ;; 21:4083 $fa $af $df
    ld   D, A                                          ;; 21:4086 $57
    ld   A, [DE]                                       ;; 21:4087 $1a
    add  A, E                                          ;; 21:4088 $83
    ld   L, A                                          ;; 21:4089 $6f
    inc  DE                                            ;; 21:408a $13
    ld   A, [DE]                                       ;; 21:408b $1a
    dec  DE                                            ;; 21:408c $1b
    adc  A, D                                          ;; 21:408d $8a
    ld   D, A                                          ;; 21:408e $57
    ld   E, L                                          ;; 21:408f $5d
    jr   jr_21_40a4                                    ;; 21:4090 $18 $12

call_21_4092:
    ld   [wDFD0], A                                    ;; 21:4092 $ea $d0 $df
    ld   A, $02                                        ;; 21:4095 $3e $02
    ld   [wDFD1], A                                    ;; 21:4097 $ea $d1 $df
    ld   A, [wDFAE]                                    ;; 21:409a $fa $ae $df
    ld   E, A                                          ;; 21:409d $5f
    ld   A, [wDFAF]                                    ;; 21:409e $fa $af $df
    ld   D, A                                          ;; 21:40a1 $57
    inc  DE                                            ;; 21:40a2 $13
    inc  DE                                            ;; 21:40a3 $13

jr_21_40a4:
    ld   A, [wDFD0]                                    ;; 21:40a4 $fa $d0 $df
    add  A, A                                          ;; 21:40a7 $87
    ld   L, A                                          ;; 21:40a8 $6f
    ld   A, D                                          ;; 21:40a9 $7a
    adc  A, $00                                        ;; 21:40aa $ce $00
    ld   D, A                                          ;; 21:40ac $57
    ld   A, E                                          ;; 21:40ad $7b
    add  A, L                                          ;; 21:40ae $85
    ld   E, A                                          ;; 21:40af $5f
    ld   A, D                                          ;; 21:40b0 $7a
    adc  A, $00                                        ;; 21:40b1 $ce $00
    ld   D, A                                          ;; 21:40b3 $57
    ld   A, [DE]                                       ;; 21:40b4 $1a
    add  A, E                                          ;; 21:40b5 $83
    ld   L, A                                          ;; 21:40b6 $6f
    inc  DE                                            ;; 21:40b7 $13
    ld   A, [DE]                                       ;; 21:40b8 $1a
    dec  DE                                            ;; 21:40b9 $1b
    adc  A, D                                          ;; 21:40ba $8a
    ld   D, A                                          ;; 21:40bb $57
    ld   E, L                                          ;; 21:40bc $5d
    ld   A, [DE]                                       ;; 21:40bd $1a
    ld   [wDFFE], A                                    ;; 21:40be $ea $fe $df
    ld   L, A                                          ;; 21:40c1 $6f
    xor  A, A                                          ;; 21:40c2 $af
    scf                                                ;; 21:40c3 $37
.jr_21_40c4:
    rl   A                                             ;; 21:40c4 $cb $17
    dec  L                                             ;; 21:40c6 $2d
    jr   NZ, .jr_21_40c4                               ;; 21:40c7 $20 $fb
    ld   [wDFC1], A                                    ;; 21:40c9 $ea $c1 $df
    ld   L, A                                          ;; 21:40cc $6f
    ld   A, [wDFD1]                                    ;; 21:40cd $fa $d1 $df
    cp   A, $01                                        ;; 21:40d0 $fe $01
    jr   NZ, .jr_21_40e3                               ;; 21:40d2 $20 $0f
    ld   A, [wDFCF]                                    ;; 21:40d4 $fa $cf $df
    or   A, L                                          ;; 21:40d7 $b5
    ld   [wDFCF], A                                    ;; 21:40d8 $ea $cf $df
    ld   HL, wDFC3                                     ;; 21:40db $21 $c3 $df
    ld   BC, wDFCB                                     ;; 21:40de $01 $cb $df
    jr   .jr_21_40f0                                   ;; 21:40e1 $18 $0d
.jr_21_40e3:
    ld   A, [wDFC2]                                    ;; 21:40e3 $fa $c2 $df
    or   A, L                                          ;; 21:40e6 $b5
    ld   [wDFC2], A                                    ;; 21:40e7 $ea $c2 $df
    ld   HL, wDFB0                                     ;; 21:40ea $21 $b0 $df
    ld   BC, wDFB9                                     ;; 21:40ed $01 $b9 $df
.jr_21_40f0:
    ld   A, [DE]                                       ;; 21:40f0 $1a
    dec  A                                             ;; 21:40f1 $3d
    sla  A                                             ;; 21:40f2 $cb $27
    add  A, L                                          ;; 21:40f4 $85
    ld   L, A                                          ;; 21:40f5 $6f
    jr   NC, .jr_21_40f9                               ;; 21:40f6 $30 $01
    inc  H                                             ;; 21:40f8 $24
.jr_21_40f9:
    ld   A, [DE]                                       ;; 21:40f9 $1a
    dec  A                                             ;; 21:40fa $3d
    add  A, C                                          ;; 21:40fb $81
    ld   C, A                                          ;; 21:40fc $4f
    jr   NC, .jr_21_4100                               ;; 21:40fd $30 $01
    inc  B                                             ;; 21:40ff $04
.jr_21_4100:
    inc  DE                                            ;; 21:4100 $13
    ld   [HL], E                                       ;; 21:4101 $73
    inc  HL                                            ;; 21:4102 $23
    ld   [HL], D                                       ;; 21:4103 $72
    dec  HL                                            ;; 21:4104 $2b
    push BC                                            ;; 21:4105 $c5
    call call_21_4199                                  ;; 21:4106 $cd $99 $41
    pop  BC                                            ;; 21:4109 $c1
    ld   [BC], A                                       ;; 21:410a $02
    ret                                                ;; 21:410b $c9

call_21_410c:
    ld   BC, wDFB9                                     ;; 21:410c $01 $b9 $df
    ld   HL, wDFB0                                     ;; 21:410f $21 $b0 $df
    ld   A, $01                                        ;; 21:4112 $3e $01
    ld   [wDFC1], A                                    ;; 21:4114 $ea $c1 $df
    ld   A, $00                                        ;; 21:4117 $3e $00
    ld   [wDFB8], A                                    ;; 21:4119 $ea $b8 $df
    ld   A, $02                                        ;; 21:411c $3e $02
    ld   [wDFD1], A                                    ;; 21:411e $ea $d1 $df
.jp_21_4121:
    push BC                                            ;; 21:4121 $c5
    ld   A, [wDFC1]                                    ;; 21:4122 $fa $c1 $df
    ld   D, A                                          ;; 21:4125 $57
    ld   A, [wDFC2]                                    ;; 21:4126 $fa $c2 $df
    and  A, D                                          ;; 21:4129 $a2
    jr   Z, .jr_21_4139                                ;; 21:412a $28 $0d
    ld   A, [BC]                                       ;; 21:412c $0a
    dec  A                                             ;; 21:412d $3d
    jr   NZ, .jr_21_4139                               ;; 21:412e $20 $09
    ld   A, [wDFB8]                                    ;; 21:4130 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 21:4133 $ea $fe $df
    call call_21_4199                                  ;; 21:4136 $cd $99 $41
.jr_21_4139:
    pop  BC                                            ;; 21:4139 $c1
    ld   [BC], A                                       ;; 21:413a $02
    inc  BC                                            ;; 21:413b $03
    inc  HL                                            ;; 21:413c $23
    inc  HL                                            ;; 21:413d $23
    ld   A, [wDFC1]                                    ;; 21:413e $fa $c1 $df
    sla  A                                             ;; 21:4141 $cb $27
    ld   [wDFC1], A                                    ;; 21:4143 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 21:4146 $fa $b8 $df
    inc  A                                             ;; 21:4149 $3c
    ld   [wDFB8], A                                    ;; 21:414a $ea $b8 $df
    cp   A, $04                                        ;; 21:414d $fe $04
    jp   NZ, .jp_21_4121                               ;; 21:414f $c2 $21 $41
    ld   BC, wDFCB                                     ;; 21:4152 $01 $cb $df
    ld   HL, wDFC3                                     ;; 21:4155 $21 $c3 $df
    ld   A, $01                                        ;; 21:4158 $3e $01
    ld   [wDFC1], A                                    ;; 21:415a $ea $c1 $df
    ld   A, $00                                        ;; 21:415d $3e $00
    ld   [wDFB8], A                                    ;; 21:415f $ea $b8 $df
    ld   A, $01                                        ;; 21:4162 $3e $01
    ld   [wDFD1], A                                    ;; 21:4164 $ea $d1 $df
.jp_21_4167:
    push BC                                            ;; 21:4167 $c5
    ld   A, [wDFC1]                                    ;; 21:4168 $fa $c1 $df
    ld   D, A                                          ;; 21:416b $57
    ld   A, [wDFCF]                                    ;; 21:416c $fa $cf $df
    and  A, D                                          ;; 21:416f $a2
    jr   Z, .jr_21_417f                                ;; 21:4170 $28 $0d
    ld   A, [BC]                                       ;; 21:4172 $0a
    dec  A                                             ;; 21:4173 $3d
    jr   NZ, .jr_21_417f                               ;; 21:4174 $20 $09
    ld   A, [wDFB8]                                    ;; 21:4176 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 21:4179 $ea $fe $df
    call call_21_4199                                  ;; 21:417c $cd $99 $41
.jr_21_417f:
    pop  BC                                            ;; 21:417f $c1
    ld   [BC], A                                       ;; 21:4180 $02
    inc  BC                                            ;; 21:4181 $03
    inc  HL                                            ;; 21:4182 $23
    inc  HL                                            ;; 21:4183 $23
    ld   A, [wDFC1]                                    ;; 21:4184 $fa $c1 $df
    sla  A                                             ;; 21:4187 $cb $27
    ld   [wDFC1], A                                    ;; 21:4189 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 21:418c $fa $b8 $df
    inc  A                                             ;; 21:418f $3c
    ld   [wDFB8], A                                    ;; 21:4190 $ea $b8 $df
    cp   A, $04                                        ;; 21:4193 $fe $04
    jp   NZ, .jp_21_4167                               ;; 21:4195 $c2 $67 $41
    ret                                                ;; 21:4198 $c9

call_21_4199:
    ld   C, [HL]                                       ;; 21:4199 $4e
    inc  HL                                            ;; 21:419a $23
    ld   B, [HL]                                       ;; 21:419b $46
.jp_21_419c:
    ld   A, [BC]                                       ;; 21:419c $0a
    cp   A, $fe                                        ;; 21:419d $fe $fe
    jr   NZ, .jr_21_41ae                               ;; 21:419f $20 $0d
    inc  BC                                            ;; 21:41a1 $03
    ld   A, [BC]                                       ;; 21:41a2 $0a
    ld   E, A                                          ;; 21:41a3 $5f
    inc  BC                                            ;; 21:41a4 $03
    ld   A, [BC]                                       ;; 21:41a5 $0a
    ld   D, A                                          ;; 21:41a6 $57
    ld   A, C                                          ;; 21:41a7 $79
    sub  A, E                                          ;; 21:41a8 $93
    ld   C, A                                          ;; 21:41a9 $4f
    ld   A, B                                          ;; 21:41aa $78
    sbc  A, D                                          ;; 21:41ab $9a
    ld   B, A                                          ;; 21:41ac $47
    ld   A, [BC]                                       ;; 21:41ad $0a
.jr_21_41ae:
    inc  BC                                            ;; 21:41ae $03
    cp   A, $ff                                        ;; 21:41af $fe $ff
    jp   NZ, .jp_21_426f                               ;; 21:41b1 $c2 $6f $42
    ld   A, [wDFC1]                                    ;; 21:41b4 $fa $c1 $df
    cpl                                                ;; 21:41b7 $2f
    ld   E, A                                          ;; 21:41b8 $5f
    ld   A, [wDFD1]                                    ;; 21:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 21:41bc $fe $01
    jp   NZ, .jp_21_4253                               ;; 21:41be $c2 $53 $42
    ld   A, [wDFCF]                                    ;; 21:41c1 $fa $cf $df
    and  A, E                                          ;; 21:41c4 $a3
    ld   [wDFCF], A                                    ;; 21:41c5 $ea $cf $df
    ld   A, [wDFC2]                                    ;; 21:41c8 $fa $c2 $df
    ld   E, A                                          ;; 21:41cb $5f
    ld   A, [wDFC1]                                    ;; 21:41cc $fa $c1 $df
    and  A, E                                          ;; 21:41cf $a3
    jp   Z, .jp_21_4265                                ;; 21:41d0 $ca $65 $42
    push HL                                            ;; 21:41d3 $e5
    push BC                                            ;; 21:41d4 $c5
    ld   B, $ff                                        ;; 21:41d5 $06 $ff
    ld   DE, wDFD2                                     ;; 21:41d7 $11 $d2 $df
    ld   A, [wDFFE]                                    ;; 21:41da $fa $fe $df
    sla  A                                             ;; 21:41dd $cb $27
    sla  A                                             ;; 21:41df $cb $27
    add  A, E                                          ;; 21:41e1 $83
    ld   E, A                                          ;; 21:41e2 $5f
    ld   A, [wDFFE]                                    ;; 21:41e3 $fa $fe $df
    add  A, E                                          ;; 21:41e6 $83
    ld   E, A                                          ;; 21:41e7 $5f
    ld   HL, data_21_439e                              ;; 21:41e8 $21 $9e $43
    ld   A, [wDFFE]                                    ;; 21:41eb $fa $fe $df
    sla  A                                             ;; 21:41ee $cb $27
    ld   C, A                                          ;; 21:41f0 $4f
    sla  A                                             ;; 21:41f1 $cb $27
    sla  A                                             ;; 21:41f3 $cb $27
    add  A, C                                          ;; 21:41f5 $81
    add  A, L                                          ;; 21:41f6 $85
    ld   L, A                                          ;; 21:41f7 $6f
    jr   NC, .jr_21_41fb                               ;; 21:41f8 $30 $01
    inc  H                                             ;; 21:41fa $24
.jr_21_41fb:
    ld   A, [HL+]                                      ;; 21:41fb $2a
    and  A, A                                          ;; 21:41fc $a7
    jr   Z, .jr_21_4206                                ;; 21:41fd $28 $07
    ld   C, A                                          ;; 21:41ff $4f
    ld   A, [DE]                                       ;; 21:4200 $1a
    ld   [BC], A                                       ;; 21:4201 $02
    inc  DE                                            ;; 21:4202 $13
    inc  HL                                            ;; 21:4203 $23
    jr   .jr_21_41fb                                   ;; 21:4204 $18 $f5
.jr_21_4206:
    ld   A, [wDFC1]                                    ;; 21:4206 $fa $c1 $df
    cp   A, $04                                        ;; 21:4209 $fe $04
    jr   NZ, .jr_21_421b                               ;; 21:420b $20 $0e
    ld   HL, wDFE6                                     ;; 21:420d $21 $e6 $df
    ld   DE, $ff30                                     ;; 21:4210 $11 $30 $ff
    ld   C, $10                                        ;; 21:4213 $0e $10
.jr_21_4215:
    ld   A, [HL+]                                      ;; 21:4215 $2a
    ld   [DE], A                                       ;; 21:4216 $12
    inc  DE                                            ;; 21:4217 $13
    dec  C                                             ;; 21:4218 $0d
    jr   NZ, .jr_21_4215                               ;; 21:4219 $20 $fa
.jr_21_421b:
    ld   HL, wDFF6                                     ;; 21:421b $21 $f6 $df
    ld   A, [wDFFE]                                    ;; 21:421e $fa $fe $df
    sla  A                                             ;; 21:4221 $cb $27
    add  A, L                                          ;; 21:4223 $85
    ld   L, A                                          ;; 21:4224 $6f
    ld   A, [wDFC1]                                    ;; 21:4225 $fa $c1 $df
    dec  A                                             ;; 21:4228 $3d
    ld   DE, data_21_43c6                              ;; 21:4229 $11 $c6 $43
    add  A, E                                          ;; 21:422c $83
    ld   E, A                                          ;; 21:422d $5f
    jr   NC, .jr_21_4231                               ;; 21:422e $30 $01
    inc  D                                             ;; 21:4230 $14
.jr_21_4231:
    ld   A, [DE]                                       ;; 21:4231 $1a
    ld   E, A                                          ;; 21:4232 $5f
    ld   D, $ff                                        ;; 21:4233 $16 $ff
    ld   A, [wDFC1]                                    ;; 21:4235 $fa $c1 $df
    cp   A, $08                                        ;; 21:4238 $fe $08
    jr   NZ, .jr_21_4244                               ;; 21:423a $20 $08
    inc  HL                                            ;; 21:423c $23
    ld   [DE], A                                       ;; 21:423d $12
    ldh  A, [rNR42]                                    ;; 21:423e $f0 $21
    ldh  [rNR42], A                                    ;; 21:4240 $e0 $21
    jr   .jr_21_424e                                   ;; 21:4242 $18 $0a
.jr_21_4244:
    ld   A, [HL+]                                      ;; 21:4244 $2a
    ld   [DE], A                                       ;; 21:4245 $12
    inc  DE                                            ;; 21:4246 $13
    ld   A, [DE]                                       ;; 21:4247 $1a
    and  A, $c0                                        ;; 21:4248 $e6 $c0
    ld   C, A                                          ;; 21:424a $4f
    ld   A, [HL]                                       ;; 21:424b $7e
    or   A, C                                          ;; 21:424c $b1
    ld   [DE], A                                       ;; 21:424d $12
.jr_21_424e:
    pop  BC                                            ;; 21:424e $c1
    pop  HL                                            ;; 21:424f $e1
    jp   .jp_21_4392                                   ;; 21:4250 $c3 $92 $43
.jp_21_4253:
    ld   A, [wDFC2]                                    ;; 21:4253 $fa $c2 $df
    and  A, E                                          ;; 21:4256 $a3
    ld   [wDFC2], A                                    ;; 21:4257 $ea $c2 $df
    ld   A, [wDFCF]                                    ;; 21:425a $fa $cf $df
    ld   E, A                                          ;; 21:425d $5f
    ld   A, [wDFC1]                                    ;; 21:425e $fa $c1 $df
    and  A, E                                          ;; 21:4261 $a3
    jp   NZ, .jp_21_4392                               ;; 21:4262 $c2 $92 $43
.jp_21_4265:
    ldh  A, [rNR52]                                    ;; 21:4265 $f0 $26
    and  A, $8f                                        ;; 21:4267 $e6 $8f
    and  A, E                                          ;; 21:4269 $a3
    ldh  [rNR52], A                                    ;; 21:426a $e0 $26
    jp   .jp_21_4392                                   ;; 21:426c $c3 $92 $43
.jp_21_426f:
    cp   A, $fd                                        ;; 21:426f $fe $fd
    jr   NZ, .jr_21_4284                               ;; 21:4271 $20 $11
    push HL                                            ;; 21:4273 $e5
    ld   DE, $ff30                                     ;; 21:4274 $11 $30 $ff
    ld   L, $10                                        ;; 21:4277 $2e $10
.jr_21_4279:
    ld   A, [BC]                                       ;; 21:4279 $0a
    inc  BC                                            ;; 21:427a $03
    ld   [DE], A                                       ;; 21:427b $12
    inc  DE                                            ;; 21:427c $13
    dec  L                                             ;; 21:427d $2d
    jr   NZ, .jr_21_4279                               ;; 21:427e $20 $f9
    pop  HL                                            ;; 21:4280 $e1
    jp   .jp_21_419c                                   ;; 21:4281 $c3 $9c $41
.jr_21_4284:
    cp   A, $a0                                        ;; 21:4284 $fe $a0
    jr   C, .jr_21_42bb                                ;; 21:4286 $38 $33
    cp   A, $c0                                        ;; 21:4288 $fe $c0
    jr   NC, .jr_21_429c                               ;; 21:428a $30 $10
    sub  A, $90                                        ;; 21:428c $d6 $90
    ld   E, A                                          ;; 21:428e $5f
    ld   D, $ff                                        ;; 21:428f $16 $ff
    ld   A, [DE]                                       ;; 21:4291 $1a
    ld   D, A                                          ;; 21:4292 $57
    ld   A, [BC]                                       ;; 21:4293 $0a
    and  A, D                                          ;; 21:4294 $a2
    ld   D, $ff                                        ;; 21:4295 $16 $ff
    ld   [DE], A                                       ;; 21:4297 $12
    inc  BC                                            ;; 21:4298 $03
    jp   .jp_21_419c                                   ;; 21:4299 $c3 $9c $41
.jr_21_429c:
    cp   A, $e0                                        ;; 21:429c $fe $e0
    jr   NC, .jr_21_42b0                               ;; 21:429e $30 $10
    sub  A, $b0                                        ;; 21:42a0 $d6 $b0
    ld   E, A                                          ;; 21:42a2 $5f
    ld   D, $ff                                        ;; 21:42a3 $16 $ff
    ld   A, [DE]                                       ;; 21:42a5 $1a
    ld   D, A                                          ;; 21:42a6 $57
    ld   A, [BC]                                       ;; 21:42a7 $0a
    or   A, D                                          ;; 21:42a8 $b2
    ld   D, $ff                                        ;; 21:42a9 $16 $ff
    ld   [DE], A                                       ;; 21:42ab $12
    inc  BC                                            ;; 21:42ac $03
    jp   .jp_21_419c                                   ;; 21:42ad $c3 $9c $41
.jr_21_42b0:
    sub  A, $d0                                        ;; 21:42b0 $d6 $d0
    ld   E, A                                          ;; 21:42b2 $5f
    ld   D, $ff                                        ;; 21:42b3 $16 $ff
    ld   A, [BC]                                       ;; 21:42b5 $0a
    inc  BC                                            ;; 21:42b6 $03
    ld   [DE], A                                       ;; 21:42b7 $12
    jp   .jp_21_419c                                   ;; 21:42b8 $c3 $9c $41
.jr_21_42bb:
    cp   A, $49                                        ;; 21:42bb $fe $49
    jp   Z, .jp_21_4369                                ;; 21:42bd $ca $69 $43
    sla  A                                             ;; 21:42c0 $cb $27
    ld   [wDFBF], A                                    ;; 21:42c2 $ea $bf $df
    ld   A, [wDFC1]                                    ;; 21:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 21:42c8 $d6 $01
    ld   [wDFC0], A                                    ;; 21:42ca $ea $c0 $df
    ld   A, [wDFBF]                                    ;; 21:42cd $fa $bf $df
    and  A, A                                          ;; 21:42d0 $a7
    jr   NZ, .jr_21_42ff                               ;; 21:42d1 $20 $2c
    ld   A, [wDFD1]                                    ;; 21:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 21:42d6 $fe $01
    jr   Z, .jr_21_42e4                                ;; 21:42d8 $28 $0a
    ld   A, [wDFCF]                                    ;; 21:42da $fa $cf $df
    ld   E, A                                          ;; 21:42dd $5f
    ld   A, [wDFC1]                                    ;; 21:42de $fa $c1 $df
    and  A, E                                          ;; 21:42e1 $a3
    jr   NZ, .jr_21_42ff                               ;; 21:42e2 $20 $1b
.jr_21_42e4:
    ld   A, [wDFC1]                                    ;; 21:42e4 $fa $c1 $df
    cpl                                                ;; 21:42e7 $2f
    ld   E, A                                          ;; 21:42e8 $5f
    ldh  A, [rNR52]                                    ;; 21:42e9 $f0 $26
    and  A, $8f                                        ;; 21:42eb $e6 $8f
    and  A, E                                          ;; 21:42ed $a3
    ldh  [rNR52], A                                    ;; 21:42ee $e0 $26
    ld   A, [wDFC1]                                    ;; 21:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 21:42f3 $fe $04
    jr   NZ, .jr_21_42fa                               ;; 21:42f5 $20 $03
    xor  A, A                                          ;; 21:42f7 $af
    ldh  [rNR30], A                                    ;; 21:42f8 $e0 $1a
.jr_21_42fa:
    ld   A, [BC]                                       ;; 21:42fa $0a
    inc  BC                                            ;; 21:42fb $03
    jp   .jp_21_4392                                   ;; 21:42fc $c3 $92 $43
.jr_21_42ff:
    ld   DE, data_21_43ce                              ;; 21:42ff $11 $ce $43
    add  A, E                                          ;; 21:4302 $83
    ld   E, A                                          ;; 21:4303 $5f
    jr   NC, .jr_21_4307                               ;; 21:4304 $30 $01
    inc  D                                             ;; 21:4306 $14
.jr_21_4307:
    ld   A, [DE]                                       ;; 21:4307 $1a
    ld   [wDFBD], A                                    ;; 21:4308 $ea $bd $df
    inc  DE                                            ;; 21:430b $13
    ld   A, [DE]                                       ;; 21:430c $1a
    ld   [wDFBE], A                                    ;; 21:430d $ea $be $df
    ld   DE, wDFF6                                     ;; 21:4310 $11 $f6 $df
    ld   A, [wDFFE]                                    ;; 21:4313 $fa $fe $df
    sla  A                                             ;; 21:4316 $cb $27
    add  A, E                                          ;; 21:4318 $83
    ld   E, A                                          ;; 21:4319 $5f
    ld   A, [wDFBD]                                    ;; 21:431a $fa $bd $df
    ld   [DE], A                                       ;; 21:431d $12
    ld   A, [wDFBE]                                    ;; 21:431e $fa $be $df
    or   A, $80                                        ;; 21:4321 $f6 $80
    ld   [DE], A                                       ;; 21:4323 $12
    ld   A, [wDFD1]                                    ;; 21:4324 $fa $d1 $df
    cp   A, $01                                        ;; 21:4327 $fe $01
    jr   Z, .jr_21_4335                                ;; 21:4329 $28 $0a
    ld   A, [wDFCF]                                    ;; 21:432b $fa $cf $df
    ld   E, A                                          ;; 21:432e $5f
    ld   A, [wDFC1]                                    ;; 21:432f $fa $c1 $df
    and  A, E                                          ;; 21:4332 $a3
    jr   NZ, .jr_21_4390                               ;; 21:4333 $20 $5b
.jr_21_4335:
    ld   A, [wDFC0]                                    ;; 21:4335 $fa $c0 $df
    ld   DE, data_21_43c6                              ;; 21:4338 $11 $c6 $43
    add  A, E                                          ;; 21:433b $83
    ld   E, A                                          ;; 21:433c $5f
    jr   NC, .jr_21_4340                               ;; 21:433d $30 $01
    inc  D                                             ;; 21:433f $14
.jr_21_4340:
    ld   A, [DE]                                       ;; 21:4340 $1a
    ld   E, A                                          ;; 21:4341 $5f
    ld   D, $ff                                        ;; 21:4342 $16 $ff
    ld   A, [wDFC1]                                    ;; 21:4344 $fa $c1 $df
    cp   A, $08                                        ;; 21:4347 $fe $08
    jr   NZ, .jr_21_4357                               ;; 21:4349 $20 $0c
    ld   A, [wDFBE]                                    ;; 21:434b $fa $be $df
    or   A, $80                                        ;; 21:434e $f6 $80
    ld   [DE], A                                       ;; 21:4350 $12
    ldh  A, [rNR42]                                    ;; 21:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 21:4353 $e0 $21
    jr   .jp_21_4369                                   ;; 21:4355 $18 $12
.jr_21_4357:
    ld   A, [wDFBD]                                    ;; 21:4357 $fa $bd $df
    ld   [DE], A                                       ;; 21:435a $12
    inc  DE                                            ;; 21:435b $13
    push DE                                            ;; 21:435c $d5
    ld   A, [DE]                                       ;; 21:435d $1a
    and  A, $c0                                        ;; 21:435e $e6 $c0
    ld   D, A                                          ;; 21:4360 $57
    ld   A, [wDFBE]                                    ;; 21:4361 $fa $be $df
    or   A, $80                                        ;; 21:4364 $f6 $80
    or   A, D                                          ;; 21:4366 $b2
    pop  DE                                            ;; 21:4367 $d1
    ld   [DE], A                                       ;; 21:4368 $12
.jp_21_4369:
    ld   A, [wDFD1]                                    ;; 21:4369 $fa $d1 $df
    cp   A, $02                                        ;; 21:436c $fe $02
    jr   NZ, .jr_21_4376                               ;; 21:436e $20 $06
    ld   A, [wDFCF]                                    ;; 21:4370 $fa $cf $df
    and  A, E                                          ;; 21:4373 $a3
    jr   NZ, .jr_21_4390                               ;; 21:4374 $20 $1a
.jr_21_4376:
    ld   A, [wDFC1]                                    ;; 21:4376 $fa $c1 $df
    ld   E, A                                          ;; 21:4379 $5f
    ldh  A, [rNR52]                                    ;; 21:437a $f0 $26
    and  A, $8f                                        ;; 21:437c $e6 $8f
    or   A, E                                          ;; 21:437e $b3
    ldh  [rNR52], A                                    ;; 21:437f $e0 $26
    ld   A, [wDFC1]                                    ;; 21:4381 $fa $c1 $df
    cp   A, $04                                        ;; 21:4384 $fe $04
    jr   NZ, .jr_21_4390                               ;; 21:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 21:4388 $f0 $1a
    and  A, $80                                        ;; 21:438a $e6 $80
    or   A, $80                                        ;; 21:438c $f6 $80
    ldh  [rNR30], A                                    ;; 21:438e $e0 $1a
.jr_21_4390:
    ld   A, [BC]                                       ;; 21:4390 $0a
    inc  BC                                            ;; 21:4391 $03
.jp_21_4392:
    ld   [HL], B                                       ;; 21:4392 $70
    dec  HL                                            ;; 21:4393 $2b
    ld   [HL], C                                       ;; 21:4394 $71
    ret                                                ;; 21:4395 $c9
    
    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 21:4396 ????????

data_21_439e:
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 21:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 21:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 21:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 21:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 21:43be ????????

data_21_43c6:
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 21:43c6 ????????

data_21_43ce:
    db   $00, $00, $2c, $00, $9c, $00, $06, $01        ;; 21:43ce ????????
    db   $6b, $01, $c9, $01, $23, $02, $77, $02        ;; 21:43d6 ????????
    db   $c6, $02, $12, $03, $56, $03, $9b, $03        ;; 21:43de ????????
    db   $da, $03, $16, $04, $4e, $04, $83, $04        ;; 21:43e6 ????????
    db   $b5, $04, $e5, $04, $11, $05, $3b, $05        ;; 21:43ee ????????
    db   $63, $05, $89, $05, $ac, $05, $ce, $05        ;; 21:43f6 ????????
    db   $ed, $05, $0a, $06, $27, $06, $42, $06        ;; 21:43fe ????????
    db   $5b, $06, $72, $06, $89, $06, $9e, $06        ;; 21:4406 ????????
    db   $b2, $06, $c4, $06, $d6, $06, $e7, $06        ;; 21:440e ????????
    db   $f7, $06, $06, $07, $14, $07, $21, $07        ;; 21:4416 ????????
    db   $2d, $07, $39, $07, $44, $07, $4f, $07        ;; 21:441e ????????
    db   $59, $07, $62, $07, $6b, $07, $73, $07        ;; 21:4426 ????????
    db   $7b, $07, $83, $07, $8a, $07, $90, $07        ;; 21:442e ????????
    db   $97, $07, $9d, $07, $a2, $07, $a7, $07        ;; 21:4436 ????????
    db   $ac, $07, $b1, $07, $b6, $07, $ba, $07        ;; 21:443e ????????
    db   $be, $07, $c1, $07, $c4, $07, $c8, $07        ;; 21:4446 ????????
    db   $cb, $07, $ce, $07, $d1, $07, $d4, $07        ;; 21:444e ????????
    db   $d6, $07, $d9, $07, $db, $07, $dd, $07        ;; 21:4456 ????????
    db   $df, $07                                      ;; 21:445e ??

data_21_4460:
    db   $1a, $00, $9c, $00, $e0, $02, $04, $05        ;; 21:4460 ????????
    db   $81, $05, $95, $05, $27, $08, $a3, $0a        ;; 21:4468 ????????
    db   $40, $0f, $e0, $13, $e6, $1a, $62, $1e        ;; 21:4470 ????????
    db   $23, $20, $75, $29, $87, $29, $a3, $29        ;; 21:4478 ????????
    db   $cb, $29, $0b, $2a, $71, $2a, $7d, $2a        ;; 21:4480 ????????
    db   $b7, $2a, $c3, $2a, $cf, $2a, $e3, $2a        ;; 21:4488 ????????
    db   $f5, $2a, $15, $2b, $3d, $2b, $99, $2b        ;; 21:4490 ????????
    db   $af, $2b, $05, $2c, $4f, $2c, $fb, $2d        ;; 21:4498 ????????
    db   $1d, $2e, $71, $2e, $9d, $2e, $c9, $2e        ;; 21:44a0 ????????
    db   $db, $2e, $f1, $2e, $01, $2f, $0d, $2f        ;; 21:44a8 ????????
    db   $21, $2f, $35, $2f, $3d, $2f, $51, $2f        ;; 21:44b0 ????????
    db   $83, $2f, $91, $2f, $d3, $2f, $e1, $2f        ;; 21:44b8 ????????
    db   $1b, $30, $29, $30, $3f, $30, $45, $30        ;; 21:44c0 ????????
    db   $6b, $30, $7b, $30, $81, $30, $8f, $30        ;; 21:44c8 ????????
    db   $9f, $30, $dd, $30, $03, $31, $13, $31        ;; 21:44d0 ????????
    db   $59, $31, $83, $31, $97, $31, $ab, $31        ;; 21:44d8 ????????
    db   $b5, $31, $e7, $31, $0f, $32, $41, $32        ;; 21:44e0 ????????
    db   $57, $32, $83, $32, $91, $32, $bb, $32        ;; 21:44e8 ????????
    db   $c9, $32, $1f, $33, $33, $33, $47, $33        ;; 21:44f0 ????????
    db   $49, $33, $4b, $33, $4d, $33, $01, $f6        ;; 21:44f8 ????????
    db   $00, $f6, $80, $f6, $87, $f5, $ff, $f4        ;; 21:4500 ????????
    db   $77, $e0, $00, $e1, $ff, $e2, $a7, $e2        ;; 21:4508 ????????
    db   $a7, $19, $20, $01, $20, $e2, $97, $19        ;; 21:4510 ????????
    db   $20, $01, $20, $e2, $87, $19, $20, $01        ;; 21:4518 ????????
    db   $20, $e2, $77, $19, $20, $01, $20, $e2        ;; 21:4520 ????????
    db   $67, $19, $20, $01, $20, $e2, $57, $19        ;; 21:4528 ????????
    db   $20, $01, $20, $19, $20, $e2, $47, $01        ;; 21:4530 ????????
    db   $20, $19, $20, $e2, $37, $01, $20, $19        ;; 21:4538 ????????
    db   $20, $08, $20, $e2, $47, $19, $20, $08        ;; 21:4540 ????????
    db   $20, $e2, $57, $19, $20, $08, $20, $e2        ;; 21:4548 ????????
    db   $67, $19, $20, $08, $20, $e2, $77, $19        ;; 21:4550 ????????
    db   $20, $08, $20, $e2, $87, $19, $20, $08        ;; 21:4558 ????????
    db   $20, $19, $20, $e2, $97, $08, $20, $19        ;; 21:4560 ????????
    db   $20, $e2, $a7, $08, $20, $19, $20, $01        ;; 21:4568 ????????
    db   $20, $e2, $97, $19, $20, $01, $20, $e2        ;; 21:4570 ????????
    db   $87, $19, $20, $01, $20, $e2, $77, $19        ;; 21:4578 ????????
    db   $20, $01, $20, $e2, $67, $19, $20, $01        ;; 21:4580 ????????
    db   $20, $e2, $57, $19, $20, $01, $20, $19        ;; 21:4588 ????????
    db   $20, $e2, $47, $01, $20, $19, $20, $e2        ;; 21:4590 ????????
    db   $37, $01, $20, $e2, $a7, $19, $20, $08        ;; 21:4598 ????????
    db   $20, $e2, $97, $19, $20, $08, $20, $e2        ;; 21:45a0 ????????
    db   $87, $19, $20, $08, $20, $e2, $77, $19        ;; 21:45a8 ????????
    db   $20, $08, $20, $e2, $67, $19, $20, $08        ;; 21:45b0 ????????
    db   $20, $e2, $57, $19, $20, $08, $20, $e2        ;; 21:45b8 ????????
    db   $47, $19, $20, $08, $20, $e2, $37, $19        ;; 21:45c0 ????????
    db   $20, $08, $20, $19, $20, $08, $20, $e2        ;; 21:45c8 ????????
    db   $47, $19, $20, $08, $20, $e2, $57, $19        ;; 21:45d0 ????????
    db   $20, $08, $20, $e2, $67, $19, $20, $08        ;; 21:45d8 ????????
    db   $20, $e2, $77, $19, $20, $08, $20, $e2        ;; 21:45e0 ????????
    db   $87, $19, $20, $08, $20, $19, $20, $e2        ;; 21:45e8 ????????
    db   $97, $08, $20, $19, $20, $e2, $a7, $08        ;; 21:45f0 ????????
    db   $20, $e2, $a7, $19, $20, $01, $20, $e2        ;; 21:45f8 ????????
    db   $97, $19, $20, $01, $20, $e2, $87, $19        ;; 21:4600 ????????
    db   $20, $01, $20, $e2, $77, $19, $20, $01        ;; 21:4608 ????????
    db   $20, $e2, $67, $19, $20, $01, $20, $e2        ;; 21:4610 ????????
    db   $57, $19, $20, $01, $20, $19, $20, $e2        ;; 21:4618 ????????
    db   $47, $01, $20, $19, $20, $e2, $37, $01        ;; 21:4620 ????????
    db   $20, $19, $20, $08, $20, $e2, $47, $19        ;; 21:4628 ????????
    db   $20, $08, $20, $e2, $57, $19, $20, $08        ;; 21:4630 ????????
    db   $20, $e2, $67, $19, $20, $08, $20, $e2        ;; 21:4638 ????????
    db   $77, $19, $20, $08, $20, $e2, $87, $19        ;; 21:4640 ????????
    db   $20, $08, $20, $19, $20, $e2, $97, $08        ;; 21:4648 ????????
    db   $20, $19, $20, $e2, $a7, $08, $20, $e2        ;; 21:4650 ????????
    db   $a7, $19, $20, $01, $20, $e2, $97, $19        ;; 21:4658 ????????
    db   $20, $01, $20, $e2, $87, $19, $20, $01        ;; 21:4660 ????????
    db   $20, $e2, $77, $19, $20, $01, $20, $e2        ;; 21:4668 ????????
    db   $67, $19, $20, $01, $20, $e2, $57, $19        ;; 21:4670 ????????
    db   $20, $01, $20, $19, $20, $e2, $47, $01        ;; 21:4678 ????????
    db   $20, $19, $20, $e2, $37, $01, $20, $19        ;; 21:4680 ????????
    db   $20, $08, $20, $e2, $47, $19, $20, $08        ;; 21:4688 ????????
    db   $20, $e2, $57, $19, $20, $08, $20, $e2        ;; 21:4690 ????????
    db   $67, $19, $20, $08, $20, $e2, $77, $19        ;; 21:4698 ????????
    db   $20, $08, $20, $e2, $87, $19, $20, $08        ;; 21:46a0 ????????
    db   $20, $19, $20, $e2, $97, $08, $20, $19        ;; 21:46a8 ????????
    db   $20, $e2, $a7, $08, $20, $e2, $a7, $19        ;; 21:46b0 ????????
    db   $20, $01, $20, $e2, $97, $19, $20, $01        ;; 21:46b8 ????????
    db   $20, $e2, $87, $19, $20, $01, $20, $e2        ;; 21:46c0 ????????
    db   $77, $19, $20, $01, $20, $e2, $67, $19        ;; 21:46c8 ????????
    db   $20, $01, $20, $e2, $57, $19, $20, $01        ;; 21:46d0 ????????
    db   $20, $19, $20, $e2, $47, $01, $20, $19        ;; 21:46d8 ????????
    db   $20, $e2, $37, $01, $20, $19, $20, $08        ;; 21:46e0 ????????
    db   $20, $e2, $47, $19, $20, $08, $20, $e2        ;; 21:46e8 ????????
    db   $57, $19, $20, $08, $20, $e2, $67, $19        ;; 21:46f0 ????????
    db   $20, $08, $20, $e2, $77, $19, $20, $08        ;; 21:46f8 ????????
    db   $20, $e2, $87, $19, $20, $08, $20, $19        ;; 21:4700 ????????
    db   $20, $e2, $97, $08, $20, $19, $20, $e2        ;; 21:4708 ????????
    db   $a7, $08, $20, $19, $20, $01, $20, $e2        ;; 21:4710 ????????
    db   $97, $19, $20, $01, $20, $e2, $87, $19        ;; 21:4718 ????????
    db   $20, $01, $20, $e2, $77, $19, $20, $01        ;; 21:4720 ????????
    db   $20, $e2, $67, $19, $20, $01, $20, $e2        ;; 21:4728 ????????
    db   $57, $19, $20, $01, $20, $19, $20, $e2        ;; 21:4730 ????????
    db   $47, $01, $20, $19, $20, $e2, $37, $01        ;; 21:4738 ????????
    db   $20, $fe, $34, $02, $02, $e6, $ff, $e7        ;; 21:4740 ????????
    db   $a7, $e7, $87, $19, $20, $e7, $77, $19        ;; 21:4748 ????????
    db   $20, $e7, $67, $19, $20, $e7, $57, $19        ;; 21:4750 ????????
    db   $20, $e7, $47, $19, $20, $19, $20, $19        ;; 21:4758 ????????
    db   $20, $19, $60, $e7, $87, $1c, $20, $1c        ;; 21:4760 ????????
    db   $20, $e7, $77, $1c, $20, $e7, $67, $1c        ;; 21:4768 ????????
    db   $20, $1c, $20, $e7, $57, $1c, $20, $e7        ;; 21:4770 ????????
    db   $47, $1c, $20, $1c, $20, $e7, $37, $1c        ;; 21:4778 ????????
    db   $40, $1c, $40, $e7, $97, $1c, $20, $1c        ;; 21:4780 ????????
    db   $20, $e7, $87, $19, $20, $e7, $77, $19        ;; 21:4788 ????????
    db   $20, $e7, $67, $19, $20, $e7, $57, $19        ;; 21:4790 ????????
    db   $20, $19, $20, $e7, $47, $19, $20, $e7        ;; 21:4798 ????????
    db   $37, $19, $40, $19, $40, $e7, $97, $1c        ;; 21:47a0 ????????
    db   $20, $1c, $20, $e7, $87, $19, $20, $e7        ;; 21:47a8 ????????
    db   $77, $19, $20, $e7, $67, $19, $20, $e7        ;; 21:47b0 ????????
    db   $57, $19, $20, $19, $20, $e7, $47, $19        ;; 21:47b8 ????????
    db   $20, $e7, $37, $19, $40, $19, $40, $e7        ;; 21:47c0 ????????
    db   $77, $14, $20, $e7, $57, $14, $20, $e7        ;; 21:47c8 ????????
    db   $97, $1c, $20, $e7, $87, $1c, $20, $1c        ;; 21:47d0 ????????
    db   $20, $e7, $67, $1c, $20, $e7, $77, $1c        ;; 21:47d8 ????????
    db   $20, $e7, $67, $1c, $20, $1c, $40, $1c        ;; 21:47e0 ????????
    db   $20, $e7, $47, $1c, $20, $19, $20, $19        ;; 21:47e8 ????????
    db   $20, $1c, $01, $e7, $97, $1c, $3f, $e7        ;; 21:47f0 ????????
    db   $77, $1c, $40, $e7, $67, $1c, $40, $e7        ;; 21:47f8 ????????
    db   $57, $1c, $40, $e7, $47, $1c, $40, $1c        ;; 21:4800 ????????
    db   $20, $e7, $37, $17, $20, $e7, $97, $17        ;; 21:4808 ????????
    db   $40, $e7, $77, $17, $40, $e7, $67, $17        ;; 21:4810 ????????
    db   $40, $17, $20, $e7, $47, $17, $20, $49        ;; 21:4818 ????????
    db   $20, $e7, $47, $17, $20, $1c, $20, $1c        ;; 21:4820 ????????
    db   $20, $e7, $87, $19, $20, $e7, $77, $19        ;; 21:4828 ????????
    db   $20, $19, $20, $e7, $67, $19, $20, $e7        ;; 21:4830 ????????
    db   $57, $19, $20, $e7, $47, $19, $20, $e7        ;; 21:4838 ????????
    db   $57, $19, $20, $e7, $67, $1c, $20, $1c        ;; 21:4840 ????????
    db   $20, $e7, $57, $1c, $20, $1c, $20, $e7        ;; 21:4848 ????????
    db   $47, $1c, $20, $e7, $87, $19, $20, $e7        ;; 21:4850 ????????
    db   $77, $19, $20, $e7, $67, $19, $20, $e7        ;; 21:4858 ????????
    db   $57, $19, $20, $e7, $47, $19, $20, $19        ;; 21:4860 ????????
    db   $20, $19, $20, $19, $60, $e7, $87, $1c        ;; 21:4868 ????????
    db   $20, $1c, $20, $e7, $77, $1c, $20, $e7        ;; 21:4870 ????????
    db   $67, $1c, $20, $1c, $20, $e7, $57, $1c        ;; 21:4878 ????????
    db   $20, $e7, $47, $1c, $20, $1c, $20, $e7        ;; 21:4880 ????????
    db   $37, $1c, $20, $e7, $47, $1c, $20, $e7        ;; 21:4888 ????????
    db   $37, $1c, $40, $e7, $97, $1c, $20, $1c        ;; 21:4890 ????????
    db   $20, $e7, $87, $19, $20, $e7, $77, $19        ;; 21:4898 ????????
    db   $20, $e7, $67, $19, $20, $e7, $57, $19        ;; 21:48a0 ????????
    db   $20, $19, $20, $e7, $47, $19, $20, $e7        ;; 21:48a8 ????????
    db   $37, $19, $20, $e7, $47, $19, $20, $e7        ;; 21:48b0 ????????
    db   $37, $19, $40, $e7, $97, $1c, $20, $1c        ;; 21:48b8 ????????
    db   $20, $e7, $87, $19, $20, $e7, $77, $19        ;; 21:48c0 ????????
    db   $20, $e7, $67, $19, $20, $e7, $57, $19        ;; 21:48c8 ????????
    db   $20, $19, $20, $e7, $47, $19, $20, $e7        ;; 21:48d0 ????????
    db   $37, $19, $20, $e7, $47, $19, $20, $e7        ;; 21:48d8 ????????
    db   $37, $19, $40, $e7, $77, $14, $20, $14        ;; 21:48e0 ????????
    db   $20, $e7, $97, $1c, $20, $e7, $87, $1c        ;; 21:48e8 ????????
    db   $20, $1c, $20, $e7, $67, $1c, $20, $e7        ;; 21:48f0 ????????
    db   $77, $1c, $20, $e7, $67, $1c, $20, $1c        ;; 21:48f8 ????????
    db   $40, $1c, $20, $e7, $47, $1c, $20, $19        ;; 21:4900 ????????
    db   $20, $19, $20, $e7, $97, $1c, $40, $e7        ;; 21:4908 ????????
    db   $77, $1c, $40, $e7, $67, $1c, $40, $e7        ;; 21:4910 ????????
    db   $57, $1c, $40, $e7, $47, $1c, $40, $1c        ;; 21:4918 ????????
    db   $20, $e7, $37, $17, $20, $e7, $97, $17        ;; 21:4920 ????????
    db   $40, $e7, $77, $17, $40, $e7, $67, $17        ;; 21:4928 ????????
    db   $40, $17, $20, $e7, $47, $17, $40, $17        ;; 21:4930 ????????
    db   $20, $1c, $20, $1c, $20, $e7, $87, $19        ;; 21:4938 ????????
    db   $20, $e7, $77, $19, $20, $19, $20, $e7        ;; 21:4940 ????????
    db   $67, $19, $20, $e7, $57, $19, $20, $e7        ;; 21:4948 ????????
    db   $47, $19, $20, $e7, $57, $19, $20, $e7        ;; 21:4950 ????????
    db   $67, $1c, $20, $1c, $20, $e7, $57, $1c        ;; 21:4958 ????????
    db   $20, $1c, $20, $e7, $47, $1c, $20, $fe        ;; 21:4960 ????????
    db   $20, $02, $03, $fd, $0b, $16, $21, $2c        ;; 21:4968 ????????
    db   $37, $42, $4d, $58, $58, $4d, $42, $37        ;; 21:4970 ????????
    db   $2c, $21, $16, $0b, $ea, $80, $eb, $ff        ;; 21:4978 ????????
    db   $ec, $40, $01, $c8, $01, $c8, $01, $30        ;; 21:4980 ????????
    db   $04, $40, $01, $fe, $49, $02, $08, $80        ;; 21:4988 ????????
    db   $04, $80, $03, $c8, $03, $b8, $01, $40        ;; 21:4990 ????????
    db   $08, $40, $01, $c0, $04, $40, $08, $80        ;; 21:4998 ????????
    db   $04, $80, $03, $c0, $01, $20, $04, $20        ;; 21:49a0 ????????
    db   $08, $fe, $49, $02, $0d, $80, $25, $80        ;; 21:49a8 ????????
    db   $2c, $80, $28, $80, $27, $c8, $27, $b8        ;; 21:49b0 ????????
    db   $28, $40, $2c, $40, $25, $80, $01, $80        ;; 21:49b8 ????????
    db   $08, $80, $04, $80, $03, $c8, $03, $b8        ;; 21:49c0 ????????
    db   $01, $40, $08, $40, $01, $c0, $04, $40        ;; 21:49c8 ????????
    db   $08, $80, $04, $80, $03, $c0, $01, $20        ;; 21:49d0 ????????
    db   $04, $20, $08, $fe, $49, $02, $0d, $e0        ;; 21:49d8 ????????
    db   $01, $20, $01, $fe, $49, $02, $fe, $66        ;; 21:49e0 ????????
    db   $00, $04, $f0, $14, $f1, $51, $f2, $22        ;; 21:49e8 ????????
    db   $f1, $31, $27, $08, $f1, $11, $27, $08        ;; 21:49f0 ????????
    db   $27, $08, $27, $08, $fe, $0e, $00, $01        ;; 21:49f8 ????????
    db   $f6, $00, $f6, $80, $f6, $87, $f5, $ff        ;; 21:4a00 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:4a08 ????????
    db   $e2, $57, $1a, $0a, $e2, $47, $1a, $09        ;; 21:4a10 ????????
    db   $1a, $0a, $e2, $37, $1a, $09, $e2, $47        ;; 21:4a18 ????????
    db   $18, $0a, $e2, $07, $49, $0a, $e2, $47        ;; 21:4a20 ????????
    db   $18, $13, $15, $09, $e2, $07, $49, $0a        ;; 21:4a28 ????????
    db   $e2, $47, $18, $0a, $e2, $57, $15, $09        ;; 21:4a30 ????????
    db   $e2, $07, $49, $0a, $e2, $57, $13, $09        ;; 21:4a38 ????????
    db   $11, $14, $e2, $07, $49, $9a, $e2, $77        ;; 21:4a40 ????????
    db   $00, $99, $49, $9a, $49, $99, $49, $9a        ;; 21:4a48 ????????
    db   $49, $9a, $49, $99, $49, $9a, $e2, $77        ;; 21:4a50 ????????
    db   $49, $9a, $49, $99, $e2, $37, $1f, $0a        ;; 21:4a58 ????????
    db   $e2, $07, $49, $09, $e2, $47, $1c, $0a        ;; 21:4a60 ????????
    db   $e2, $07, $49, $0a, $e2, $37, $1c, $09        ;; 21:4a68 ????????
    db   $e2, $07, $49, $0a, $e2, $37, $1f, $09        ;; 21:4a70 ????????
    db   $e2, $07, $49, $0a, $e2, $37, $21, $0a        ;; 21:4a78 ????????
    db   $e2, $07, $49, $09, $e2, $37, $1f, $0a        ;; 21:4a80 ????????
    db   $e2, $07, $49, $09, $e2, $37, $1f, $0a        ;; 21:4a88 ????????
    db   $e2, $07, $49, $b6, $e2, $57, $1c, $0a        ;; 21:4a90 ????????
    db   $e2, $47, $1c, $0a, $1c, $09, $e2, $37        ;; 21:4a98 ????????
    db   $1c, $0a, $e2, $47, $1a, $09, $e2, $07        ;; 21:4aa0 ????????
    db   $49, $0a, $e2, $47, $1a, $13, $17, $0a        ;; 21:4aa8 ????????
    db   $e2, $07, $49, $09, $e2, $47, $17, $0a        ;; 21:4ab0 ????????
    db   $e2, $07, $49, $0a, $e2, $47, $1a, $26        ;; 21:4ab8 ????????
    db   $e2, $07, $49, $9a, $e2, $77, $00, $99        ;; 21:4ac0 ????????
    db   $e2, $47, $26, $0a, $24, $09, $1d, $0a        ;; 21:4ac8 ????????
    db   $1f, $0a, $21, $09, $24, $0a, $21, $09        ;; 21:4ad0 ????????
    db   $1f, $0a, $1d, $4d, $e2, $77, $00, $9a        ;; 21:4ad8 ????????
    db   $49, $99, $49, $9a, $e2, $57, $1a, $09        ;; 21:4ae0 ????????
    db   $e2, $47, $1a, $0a, $1a, $0a, $e2, $37        ;; 21:4ae8 ????????
    db   $1a, $09, $e2, $47, $18, $0a, $e2, $07        ;; 21:4af0 ????????
    db   $49, $09, $e2, $47, $18, $14, $15, $09        ;; 21:4af8 ????????
    db   $e2, $07, $49, $0a, $e2, $47, $18, $09        ;; 21:4b00 ????????
    db   $e2, $57, $15, $0a, $e2, $07, $49, $0a        ;; 21:4b08 ????????
    db   $e2, $57, $13, $09, $11, $13, $e2, $77        ;; 21:4b10 ????????
    db   $00, $9a, $49, $9a, $49, $99, $49, $9a        ;; 21:4b18 ????????
    db   $e2, $37, $2a, $1d, $e2, $07, $49, $09        ;; 21:4b20 ????????
    db   $e2, $37, $2c, $0a, $e2, $07, $49, $0a        ;; 21:4b28 ????????
    db   $e2, $27, $2d, $09, $e2, $07, $49, $0a        ;; 21:4b30 ????????
    db   $e2, $37, $2c, $09, $e2, $07, $49, $0a        ;; 21:4b38 ????????
    db   $e2, $37, $2a, $26, $e2, $07, $49, $14        ;; 21:4b40 ????????
    db   $e2, $37, $15, $09, $e2, $07, $49, $0a        ;; 21:4b48 ????????
    db   $e2, $47, $15, $09, $e2, $07, $49, $0a        ;; 21:4b50 ????????
    db   $e2, $57, $17, $0a, $e2, $07, $49, $09        ;; 21:4b58 ????????
    db   $e2, $47, $17, $0a, $e2, $07, $49, $09        ;; 21:4b60 ????????
    db   $e2, $47, $0d, $0a, $e2, $07, $49, $0a        ;; 21:4b68 ????????
    db   $e2, $47, $0d, $09, $e2, $07, $49, $0a        ;; 21:4b70 ????????
    db   $e2, $27, $10, $09, $e2, $07, $49, $1d        ;; 21:4b78 ????????
    db   $e2, $37, $2a, $1d, $e2, $07, $49, $0a        ;; 21:4b80 ????????
    db   $e2, $37, $2c, $09, $e2, $07, $49, $0a        ;; 21:4b88 ????????
    db   $e2, $27, $2d, $09, $e2, $07, $49, $0a        ;; 21:4b90 ????????
    db   $e2, $37, $2c, $0a, $e2, $07, $49, $09        ;; 21:4b98 ????????
    db   $e2, $37, $2a, $13, $e2, $07, $49, $14        ;; 21:4ba0 ????????
    db   $e2, $37, $1e, $39, $e2, $47, $1d, $4d        ;; 21:4ba8 ????????
    db   $e2, $07, $49, $13, $e2, $37, $1c, $13        ;; 21:4bb0 ????????
    db   $e2, $47, $2a, $1d, $e2, $07, $49, $0a        ;; 21:4bb8 ????????
    db   $e2, $37, $2c, $09, $e2, $07, $49, $0a        ;; 21:4bc0 ????????
    db   $e2, $37, $2d, $0a, $e2, $07, $49, $09        ;; 21:4bc8 ????????
    db   $e2, $37, $2c, $0a, $e2, $07, $49, $09        ;; 21:4bd0 ????????
    db   $e2, $37, $2a, $14, $e2, $07, $49, $26        ;; 21:4bd8 ????????
    db   $e2, $37, $15, $0a, $e2, $07, $49, $09        ;; 21:4be0 ????????
    db   $e2, $47, $15, $0a, $e2, $07, $49, $09        ;; 21:4be8 ????????
    db   $e2, $57, $17, $0a, $e2, $07, $49, $0a        ;; 21:4bf0 ????????
    db   $e2, $47, $17, $09, $e2, $07, $49, $0a        ;; 21:4bf8 ????????
    db   $e2, $47, $0d, $09, $e2, $07, $49, $0a        ;; 21:4c00 ????????
    db   $e2, $47, $0d, $0a, $e2, $07, $49, $09        ;; 21:4c08 ????????
    db   $e2, $27, $10, $0a, $e2, $07, $49, $1d        ;; 21:4c10 ????????
    db   $e2, $47, $2a, $1c, $e2, $07, $49, $0a        ;; 21:4c18 ????????
    db   $e2, $37, $2c, $0a, $e2, $07, $49, $09        ;; 21:4c20 ????????
    db   $e2, $37, $2d, $0a, $e2, $07, $49, $09        ;; 21:4c28 ????????
    db   $e2, $37, $2c, $0a, $e2, $07, $49, $0a        ;; 21:4c30 ????????
    db   $e2, $37, $2a, $13, $e2, $07, $49, $13        ;; 21:4c38 ????????
    db   $e2, $47, $1e, $3a, $1d, $4c, $e2, $07        ;; 21:4c40 ????????
    db   $49, $14, $e2, $17, $1c, $09, $e2, $07        ;; 21:4c48 ????????
    db   $49, $a3, $e2, $77, $00, $9a, $49, $9a        ;; 21:4c50 ????????
    db   $e2, $37, $1f, $09, $e2, $07, $49, $0a        ;; 21:4c58 ????????
    db   $e2, $47, $1c, $09, $e2, $07, $49, $0a        ;; 21:4c60 ????????
    db   $e2, $37, $1c, $0a, $e2, $07, $49, $09        ;; 21:4c68 ????????
    db   $e2, $37, $1f, $0a, $e2, $07, $49, $09        ;; 21:4c70 ????????
    db   $e2, $37, $21, $0a, $e2, $07, $49, $0a        ;; 21:4c78 ????????
    db   $e2, $37, $1f, $09, $e2, $07, $49, $0a        ;; 21:4c80 ????????
    db   $e2, $37, $1f, $09, $e2, $07, $49, $1d        ;; 21:4c88 ????????
    db   $fe, $82, $02, $02, $e6, $ff, $e7, $77        ;; 21:4c90 ????????
    db   $e7, $57, $24, $0a, $e7, $47, $24, $09        ;; 21:4c98 ????????
    db   $24, $0a, $24, $09, $e7, $57, $22, $0a        ;; 21:4ca0 ????????
    db   $e7, $07, $49, $0a, $e7, $57, $22, $09        ;; 21:4ca8 ????????
    db   $e7, $07, $49, $0a, $e7, $57, $1f, $09        ;; 21:4cb0 ????????
    db   $e7, $07, $49, $0a, $e7, $47, $22, $0a        ;; 21:4cb8 ????????
    db   $1f, $09, $e7, $07, $49, $0a, $e7, $47        ;; 21:4cc0 ????????
    db   $1d, $09, $e7, $07, $49, $14, $e7, $77        ;; 21:4cc8 ????????
    db   $00, $9a, $49, $99, $49, $9a, $49, $99        ;; 21:4cd0 ????????
    db   $49, $9a, $49, $9a, $49, $99, $49, $9a        ;; 21:4cd8 ????????
    db   $e7, $77, $00, $9a, $49, $99, $e7, $47        ;; 21:4ce0 ????????
    db   $29, $13, $26, $0a, $e7, $07, $49, $0a        ;; 21:4ce8 ????????
    db   $e7, $57, $26, $13, $29, $13, $e7, $47        ;; 21:4cf0 ????????
    db   $2b, $13, $e7, $57, $29, $0a, $e7, $07        ;; 21:4cf8 ????????
    db   $49, $09, $e7, $57, $29, $27, $e7, $77        ;; 21:4d00 ????????
    db   $49, $99, $e7, $57, $26, $0a, $e7, $47        ;; 21:4d08 ????????
    db   $26, $0a, $26, $09, $26, $0a, $e7, $57        ;; 21:4d10 ????????
    db   $24, $09, $e7, $07, $49, $0a, $e7, $57        ;; 21:4d18 ????????
    db   $24, $0a, $e7, $07, $49, $09, $e7, $57        ;; 21:4d20 ????????
    db   $21, $0a, $e7, $07, $49, $09, $e7, $57        ;; 21:4d28 ????????
    db   $21, $0a, $e7, $07, $49, $0a, $e7, $57        ;; 21:4d30 ????????
    db   $24, $26, $e7, $07, $49, $9a, $e7, $77        ;; 21:4d38 ????????
    db   $00, $99, $e7, $27, $21, $0a, $1f, $09        ;; 21:4d40 ????????
    db   $18, $0a, $1a, $0a, $1c, $09, $1f, $0a        ;; 21:4d48 ????????
    db   $1c, $09, $1a, $0a, $18, $4d, $e7, $77        ;; 21:4d50 ????????
    db   $00, $9a, $49, $99, $49, $9a, $e7, $57        ;; 21:4d58 ????????
    db   $24, $09, $e7, $47, $24, $0a, $24, $0a        ;; 21:4d60 ????????
    db   $24, $09, $e7, $57, $22, $0a, $e7, $07        ;; 21:4d68 ????????
    db   $49, $09, $e7, $57, $22, $0a, $e7, $07        ;; 21:4d70 ????????
    db   $49, $0a, $e7, $57, $1f, $09, $e7, $07        ;; 21:4d78 ????????
    db   $49, $0a, $e7, $47, $22, $09, $1f, $0a        ;; 21:4d80 ????????
    db   $e7, $07, $49, $0a, $e7, $47, $1d, $09        ;; 21:4d88 ????????
    db   $e7, $07, $49, $13, $e7, $77, $00, $9a        ;; 21:4d90 ????????
    db   $49, $9a, $49, $99, $49, $9a, $e7, $37        ;; 21:4d98 ????????
    db   $25, $1d, $e7, $07, $49, $09, $e7, $37        ;; 21:4da0 ????????
    db   $27, $0a, $e7, $07, $49, $0a, $e7, $27        ;; 21:4da8 ????????
    db   $28, $09, $e7, $07, $49, $0a, $e7, $37        ;; 21:4db0 ????????
    db   $27, $09, $e7, $07, $49, $0a, $e7, $37        ;; 21:4db8 ????????
    db   $25, $26, $e7, $07, $49, $14, $e7, $37        ;; 21:4dc0 ????????
    db   $10, $09, $e7, $07, $49, $0a, $e7, $47        ;; 21:4dc8 ????????
    db   $10, $09, $e7, $07, $49, $0a, $e7, $57        ;; 21:4dd0 ????????
    db   $12, $0a, $e7, $07, $49, $09, $e7, $47        ;; 21:4dd8 ????????
    db   $12, $0a, $e7, $07, $49, $09, $e7, $47        ;; 21:4de0 ????????
    db   $08, $0a, $e7, $07, $49, $0a, $e7, $47        ;; 21:4de8 ????????
    db   $08, $09, $e7, $07, $49, $0a, $e7, $27        ;; 21:4df0 ????????
    db   $0b, $09, $e7, $07, $49, $1d, $e7, $37        ;; 21:4df8 ????????
    db   $25, $1d, $e7, $07, $49, $0a, $e7, $37        ;; 21:4e00 ????????
    db   $27, $09, $e7, $07, $49, $0a, $e7, $27        ;; 21:4e08 ????????
    db   $28, $09, $e7, $07, $49, $0a, $e7, $37        ;; 21:4e10 ????????
    db   $27, $0a, $e7, $07, $49, $09, $e7, $37        ;; 21:4e18 ????????
    db   $25, $13, $e7, $07, $49, $14, $e7, $37        ;; 21:4e20 ????????
    db   $19, $39, $e7, $47, $18, $4d, $e7, $07        ;; 21:4e28 ????????
    db   $49, $13, $e7, $37, $17, $13, $e7, $47        ;; 21:4e30 ????????
    db   $25, $1d, $e7, $07, $49, $0a, $e7, $37        ;; 21:4e38 ????????
    db   $27, $09, $e7, $07, $49, $0a, $e7, $37        ;; 21:4e40 ????????
    db   $28, $0a, $e7, $07, $49, $09, $e7, $37        ;; 21:4e48 ????????
    db   $27, $0a, $e7, $07, $49, $09, $e7, $37        ;; 21:4e50 ????????
    db   $25, $14, $e7, $07, $49, $26, $e7, $37        ;; 21:4e58 ????????
    db   $10, $0a, $e7, $07, $49, $09, $e7, $47        ;; 21:4e60 ????????
    db   $10, $0a, $e7, $07, $49, $09, $e7, $57        ;; 21:4e68 ????????
    db   $12, $0a, $e7, $07, $49, $0a, $e7, $47        ;; 21:4e70 ????????
    db   $12, $09, $e7, $07, $49, $0a, $e7, $47        ;; 21:4e78 ????????
    db   $08, $09, $e7, $07, $49, $0a, $e7, $47        ;; 21:4e80 ????????
    db   $08, $0a, $e7, $07, $49, $09, $e7, $27        ;; 21:4e88 ????????
    db   $0b, $0a, $e7, $07, $49, $1d, $e7, $47        ;; 21:4e90 ????????
    db   $25, $1c, $e7, $07, $49, $0a, $e7, $37        ;; 21:4e98 ????????
    db   $27, $0a, $e7, $07, $49, $09, $e7, $37        ;; 21:4ea0 ????????
    db   $28, $0a, $e7, $07, $49, $09, $e7, $37        ;; 21:4ea8 ????????
    db   $27, $0a, $e7, $07, $49, $0a, $e7, $37        ;; 21:4eb0 ????????
    db   $25, $13, $e7, $07, $49, $13, $e7, $47        ;; 21:4eb8 ????????
    db   $19, $3a, $18, $4c, $e7, $07, $49, $14        ;; 21:4ec0 ????????
    db   $e7, $17, $17, $09, $e7, $07, $49, $a3        ;; 21:4ec8 ????????
    db   $e7, $77, $00, $9a, $49, $9a, $e7, $47        ;; 21:4ed0 ????????
    db   $29, $09, $e7, $07, $49, $0a, $e7, $47        ;; 21:4ed8 ????????
    db   $26, $09, $e7, $07, $49, $0a, $e7, $57        ;; 21:4ee0 ????????
    db   $26, $0a, $e7, $07, $49, $09, $e7, $57        ;; 21:4ee8 ????????
    db   $29, $0a, $e7, $07, $49, $09, $e7, $47        ;; 21:4ef0 ????????
    db   $2b, $0a, $e7, $07, $49, $0a, $e7, $57        ;; 21:4ef8 ????????
    db   $29, $09, $e7, $07, $49, $0a, $e7, $57        ;; 21:4f00 ????????
    db   $29, $09, $e7, $07, $49, $1d, $fe, $78        ;; 21:4f08 ????????
    db   $02, $03, $fd, $01, $17, $2d, $43, $59        ;; 21:4f10 ????????
    db   $00, $00, $00, $00, $00, $00, $57, $41        ;; 21:4f18 ????????
    db   $2b, $15, $00, $ea, $80, $eb, $ff, $ec        ;; 21:4f20 ????????
    db   $60, $00, $9a, $0b, $0a, $09, $09, $02        ;; 21:4f28 ????????
    db   $0a, $09, $09, $0b, $0a, $09, $0a, $02        ;; 21:4f30 ????????
    db   $09, $04, $0a, $09, $09, $0b, $0a, $02        ;; 21:4f38 ????????
    db   $0a, $09, $09, $0b, $0a, $09, $09, $02        ;; 21:4f40 ????????
    db   $0b, $04, $09, $0b, $09, $09, $0a, $02        ;; 21:4f48 ????????
    db   $09, $09, $0a, $0b, $0a, $09, $09, $02        ;; 21:4f50 ????????
    db   $0a, $04, $09, $09, $0a, $0b, $0a, $02        ;; 21:4f58 ????????
    db   $09, $09, $0a, $0b, $09, $09, $0a, $02        ;; 21:4f60 ????????
    db   $0a, $0b, $0a, $01, $09, $04, $0a, $05        ;; 21:4f68 ????????
    db   $09, $06, $0a, $08, $0a, $0b, $09, $01        ;; 21:4f70 ????????
    db   $09, $0b, $0a, $01, $0a, $04, $09, $05        ;; 21:4f78 ????????
    db   $0a, $06, $09, $08, $0a, $0b, $0a, $01        ;; 21:4f80 ????????
    db   $09, $0b, $0a, $01, $0a, $04, $09, $05        ;; 21:4f88 ????????
    db   $0a, $06, $0a, $08, $09, $0b, $0a, $01        ;; 21:4f90 ????????
    db   $09, $0b, $0a, $01, $09, $04, $0a, $05        ;; 21:4f98 ????????
    db   $09, $06, $0a, $08, $0a, $0b, $09, $01        ;; 21:4fa0 ????????
    db   $0a, $0b, $09, $01, $0a, $04, $0a, $05        ;; 21:4fa8 ????????
    db   $09, $06, $0a, $08, $09, $0b, $0a, $01        ;; 21:4fb0 ????????
    db   $0a, $0b, $09, $01, $0a, $04, $09, $05        ;; 21:4fb8 ????????
    db   $0a, $06, $09, $08, $0a, $0b, $0a, $01        ;; 21:4fc0 ????????
    db   $09, $09, $0a, $0b, $0a, $0b, $09, $02        ;; 21:4fc8 ????????
    db   $0a, $09, $09, $0b, $0a, $09, $0a, $02        ;; 21:4fd0 ????????
    db   $09, $04, $0a, $09, $09, $0b, $0a, $02        ;; 21:4fd8 ????????
    db   $0a, $09, $09, $0b, $0a, $09, $09, $02        ;; 21:4fe0 ????????
    db   $0a, $09, $0a, $0b, $09, $09, $0a, $02        ;; 21:4fe8 ????????
    db   $09, $09, $0a, $0b, $0a, $09, $09, $02        ;; 21:4ff0 ????????
    db   $0a, $04, $09, $09, $0a, $0b, $0a, $02        ;; 21:4ff8 ????????
    db   $09, $09, $0a, $0b, $09, $09, $0a, $02        ;; 21:5000 ????????
    db   $0a, $09, $0b, $0b, $09, $09, $0a, $02        ;; 21:5008 ????????
    db   $0a, $09, $09, $0b, $0a, $09, $09, $02        ;; 21:5010 ????????
    db   $0a, $04, $0a, $09, $09, $0b, $0a, $02        ;; 21:5018 ????????
    db   $09, $09, $0a, $0b, $0a, $09, $09, $02        ;; 21:5020 ????????
    db   $0a, $09, $08, $0b, $0a, $02, $09, $02        ;; 21:5028 ????????
    db   $0a, $04, $09, $04, $0a, $06, $0a, $09        ;; 21:5030 ????????
    db   $0a, $0a, $09, $0b, $0a, $02, $08, $02        ;; 21:5038 ????????
    db   $0a, $04, $0a, $04, $0a, $06, $09, $09        ;; 21:5040 ????????
    db   $0a, $0a, $09, $0b, $0a, $02, $0a, $03        ;; 21:5048 ????????
    db   $09, $04, $0a, $04, $0a, $06, $09, $09        ;; 21:5050 ????????
    db   $0a, $0a, $0a, $0b, $09, $02, $0a, $02        ;; 21:5058 ????????
    db   $0a, $03, $08, $04, $0b, $06, $09, $09        ;; 21:5060 ????????
    db   $0a, $0a, $09, $0b, $0a, $02, $09, $02        ;; 21:5068 ????????
    db   $0a, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:5070 ????????
    db   $0a, $0b, $09, $0b, $0a, $02, $09, $02        ;; 21:5078 ????????
    db   $0a, $03, $09, $04, $0a, $06, $09, $09        ;; 21:5080 ????????
    db   $0a, $0a, $09, $0b, $0a, $02, $0a, $02        ;; 21:5088 ????????
    db   $0a, $04, $0a, $04, $09, $06, $0a, $09        ;; 21:5090 ????????
    db   $09, $0a, $0a, $0b, $09, $02, $0a, $02        ;; 21:5098 ????????
    db   $09, $03, $0a, $04, $0a, $06, $09, $09        ;; 21:50a0 ????????
    db   $0a, $0a, $09, $01, $0a, $04, $09, $04        ;; 21:50a8 ????????
    db   $0a, $06, $09, $06, $0b, $08, $09, $0b        ;; 21:50b0 ????????
    db   $0a, $0c, $09, $01, $0a, $04, $0a, $04        ;; 21:50b8 ????????
    db   $09, $06, $0a, $06, $0a, $08, $09, $0b        ;; 21:50c0 ????????
    db   $09, $0c, $0a, $01, $0a, $04, $09, $04        ;; 21:50c8 ????????
    db   $0a, $05, $09, $06, $0a, $08, $0a, $0b        ;; 21:50d0 ????????
    db   $09, $0c, $0a, $01, $09, $04, $0a, $04        ;; 21:50d8 ????????
    db   $09, $05, $0a, $06, $0a, $08, $09, $0b        ;; 21:50e0 ????????
    db   $0a, $0c, $0a, $0b, $09, $02, $0a, $02        ;; 21:50e8 ????????
    db   $09, $03, $0a, $04, $0a, $06, $09, $09        ;; 21:50f0 ????????
    db   $0a, $0a, $09, $0b, $0a, $02, $0a, $02        ;; 21:50f8 ????????
    db   $09, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:5100 ????????
    db   $09, $0a, $0a, $0b, $0a, $02, $09, $02        ;; 21:5108 ????????
    db   $0a, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:5110 ????????
    db   $09, $0a, $0a, $0b, $0a, $0b, $09, $02        ;; 21:5118 ????????
    db   $0a, $03, $09, $04, $0a, $06, $0a, $09        ;; 21:5120 ????????
    db   $09, $0a, $0a, $09, $0a, $09, $09, $0c        ;; 21:5128 ????????
    db   $0a, $01, $0a, $02, $09, $04, $0a, $07        ;; 21:5130 ????????
    db   $0a, $09, $09, $09, $09, $0c, $0a, $0c        ;; 21:5138 ????????
    db   $0a, $02, $0a, $02, $09, $04, $09, $04        ;; 21:5140 ????????
    db   $09, $07, $0a, $09, $0a, $09, $09, $0c        ;; 21:5148 ????????
    db   $0a, $01, $0a, $02, $09, $04, $0a, $07        ;; 21:5150 ????????
    db   $0a, $08, $09, $09, $0a, $0c, $09, $0c        ;; 21:5158 ????????
    db   $0a, $01, $0a, $02, $09, $04, $0a, $07        ;; 21:5160 ????????
    db   $0a, $08, $08, $07, $09, $09, $0a, $0c        ;; 21:5168 ????????
    db   $09, $01, $0a, $02, $0a, $04, $09, $07        ;; 21:5170 ????????
    db   $0a, $08, $09, $09, $0a, $09, $0a, $0c        ;; 21:5178 ????????
    db   $09, $01, $0a, $02, $09, $04, $0a, $07        ;; 21:5180 ????????
    db   $09, $08, $0c, $0b, $09, $0b, $0a, $02        ;; 21:5188 ????????
    db   $09, $03, $0a, $04, $0a, $06, $09, $09        ;; 21:5190 ????????
    db   $0a, $0a, $09, $0b, $0a, $0b, $09, $02        ;; 21:5198 ????????
    db   $0a, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:51a0 ????????
    db   $0a, $0a, $09, $0b, $0a, $0b, $09, $02        ;; 21:51a8 ????????
    db   $0a, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:51b0 ????????
    db   $09, $0a, $0a, $0b, $0a, $0b, $09, $02        ;; 21:51b8 ????????
    db   $0a, $03, $09, $04, $0a, $06, $09, $09        ;; 21:51c0 ????????
    db   $0a, $0a, $0a, $0b, $09, $0b, $0a, $02        ;; 21:51c8 ????????
    db   $0a, $03, $09, $04, $0a, $06, $09, $09        ;; 21:51d0 ????????
    db   $0a, $0a, $09, $0b, $0a, $0b, $0a, $02        ;; 21:51d8 ????????
    db   $09, $03, $0a, $04, $0a, $09, $09, $0a        ;; 21:51e0 ????????
    db   $0a, $0b, $09, $0b, $0a, $09, $0a, $0b        ;; 21:51e8 ????????
    db   $09, $0b, $0a, $02, $0a, $04, $08, $04        ;; 21:51f0 ????????
    db   $0b, $06, $09, $0b, $0a, $09, $0a, $09        ;; 21:51f8 ????????
    db   $0a, $0b, $09, $02, $0a, $02, $09, $04        ;; 21:5200 ????????
    db   $0a, $06, $09, $0b, $0a, $09, $0a, $0b        ;; 21:5208 ????????
    db   $09, $0b, $0a, $02, $09, $04, $09, $04        ;; 21:5210 ????????
    db   $0b, $06, $09, $0b, $0a, $09, $09, $09        ;; 21:5218 ????????
    db   $0a, $0b, $0a, $02, $09, $02, $0a, $04        ;; 21:5220 ????????
    db   $09, $06, $0a, $01, $09, $04, $0a, $04        ;; 21:5228 ????????
    db   $0a, $06, $09, $06, $0a, $08, $09, $0b        ;; 21:5230 ????????
    db   $0a, $01, $0a, $01, $09, $04, $0a, $04        ;; 21:5238 ????????
    db   $0a, $06, $0a, $06, $09, $08, $0a, $08        ;; 21:5240 ????????
    db   $0a, $0b, $09, $01, $09, $04, $0a, $04        ;; 21:5248 ????????
    db   $09, $06, $0a, $06, $09, $08, $0a, $0b        ;; 21:5250 ????????
    db   $0a, $01, $09, $01, $0a, $04, $09, $04        ;; 21:5258 ????????
    db   $0a, $06, $02, $0b, $08, $01, $09, $08        ;; 21:5260 ????????
    db   $09, $01, $0a, $08, $0a, $0b, $09, $02        ;; 21:5268 ????????
    db   $0a, $02, $0a, $04, $09, $04, $09, $06        ;; 21:5270 ????????
    db   $0a, $09, $0a, $0b, $0a, $0b, $09, $02        ;; 21:5278 ????????
    db   $0a, $02, $09, $04, $0a, $04, $09, $06        ;; 21:5280 ????????
    db   $0a, $09, $0a, $0b, $09, $0b, $0a, $02        ;; 21:5288 ????????
    db   $09, $02, $0a, $04, $0a, $04, $09, $06        ;; 21:5290 ????????
    db   $09, $09, $0a, $0b, $0a, $0b, $0a, $02        ;; 21:5298 ????????
    db   $09, $02, $0a, $04, $09, $04, $0a, $06        ;; 21:52a0 ????????
    db   $0a, $09, $09, $0b, $0a, $0b, $09, $02        ;; 21:52a8 ????????
    db   $0a, $02, $0a, $04, $09, $04, $0a, $06        ;; 21:52b0 ????????
    db   $09, $09, $0a, $0b, $0a, $0b, $09, $02        ;; 21:52b8 ????????
    db   $0a, $02, $09, $04, $0a, $04, $0a, $06        ;; 21:52c0 ????????
    db   $09, $09, $0a, $0b, $0a, $0b, $09, $02        ;; 21:52c8 ????????
    db   $0a, $02, $09, $04, $0a, $04, $09, $06        ;; 21:52d0 ????????
    db   $0a, $09, $0a, $09, $09, $0b, $0a, $02        ;; 21:52d8 ????????
    db   $09, $02, $0a, $04, $0a, $04, $09, $06        ;; 21:52e0 ????????
    db   $09, $09, $0a, $0b, $0a, $0b, $0a, $02        ;; 21:52e8 ????????
    db   $09, $02, $0a, $04, $0a, $04, $09, $06        ;; 21:52f0 ????????
    db   $0a, $09, $0a, $0b, $09, $0b, $0a, $02        ;; 21:52f8 ????????
    db   $09, $02, $0a, $04, $09, $04, $0a, $06        ;; 21:5300 ????????
    db   $09, $09, $0a, $09, $09, $0b, $0a, $0b        ;; 21:5308 ????????
    db   $09, $02, $0a, $04, $0a, $04, $09, $06        ;; 21:5310 ????????
    db   $0a, $09, $0a, $09, $0a, $0b, $0a, $02        ;; 21:5318 ????????
    db   $08, $02, $0a, $02, $09, $04, $0a, $06        ;; 21:5320 ????????
    db   $0a, $09, $0a, $0b, $0a, $0b, $09, $02        ;; 21:5328 ????????
    db   $0a, $02, $09, $02, $09, $04, $09, $06        ;; 21:5330 ????????
    db   $0b, $09, $0a, $0b, $09, $0b, $0a, $02        ;; 21:5338 ????????
    db   $09, $03, $0a, $04, $0a, $04, $08, $06        ;; 21:5340 ????????
    db   $0a, $09, $0a, $0b, $0a, $0b, $09, $0b        ;; 21:5348 ????????
    db   $0a, $02, $09, $03, $0a, $04, $0a, $06        ;; 21:5350 ????????
    db   $09, $09, $0a, $0b, $0a, $02, $09, $02        ;; 21:5358 ????????
    db   $0a, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:5360 ????????
    db   $0a, $0b, $09, $09, $09, $0b, $0a, $02        ;; 21:5368 ????????
    db   $0a, $03, $09, $04, $0a, $06, $0a, $09        ;; 21:5370 ????????
    db   $09, $0b, $09, $09, $0a, $0b, $0a, $02        ;; 21:5378 ????????
    db   $0a, $03, $09, $04, $0a, $06, $0a, $09        ;; 21:5380 ????????
    db   $09, $0b, $09, $09, $0a, $0b, $0a, $02        ;; 21:5388 ????????
    db   $0a, $03, $09, $04, $0a, $06, $09, $09        ;; 21:5390 ????????
    db   $0a, $0b, $09, $09, $0a, $0b, $0a, $02        ;; 21:5398 ????????
    db   $09, $03, $0a, $04, $09, $06, $0a, $09        ;; 21:53a0 ????????
    db   $09, $0b, $0a, $09, $0a, $fe, $86, $04        ;; 21:53a8 ????????
    db   $04, $f0, $14, $f1, $21, $f2, $22, $f3        ;; 21:53b0 ????????
    db   $80, $19, $0a, $19, $09, $19, $0a, $19        ;; 21:53b8 ????????
    db   $09, $17, $14, $17, $13, $14, $13, $17        ;; 21:53c0 ????????
    db   $0a, $14, $13, $12, $09, $10, $14, $49        ;; 21:53c8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:53d0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:53d8 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:53e0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:53e8 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:53f0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:53f8 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5400 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5408 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5410 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5418 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5420 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5428 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5430 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5438 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5440 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5448 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5450 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5458 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5460 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5468 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5470 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5478 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5480 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5488 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5490 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5498 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:54a0 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:54a8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:54b0 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:54b8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:54c0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:54c8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:54d0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:54d8 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:54e0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:54e8 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:54f0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:54f8 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5500 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5508 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5510 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5518 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5520 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5528 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5530 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5538 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5540 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5548 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5550 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5558 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5560 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5568 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5570 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5578 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5580 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5588 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5590 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5598 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:55a0 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:55a8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:55b0 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:55b8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:55c0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:55c8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:55d0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:55d8 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:55e0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:55e8 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:55f0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:55f8 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5600 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5608 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5610 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5618 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5620 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5628 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5630 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5638 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5640 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5648 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5650 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5658 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5660 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5668 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5670 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5678 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5680 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5688 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5690 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5698 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:56a0 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:56a8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:56b0 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:56b8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:56c0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:56c8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:56d0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:56d8 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:56e0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:56e8 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:56f0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:56f8 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5700 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5708 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5710 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5718 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5720 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5728 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5730 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5738 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5740 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5748 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5750 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5758 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5760 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5768 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5770 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5778 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5780 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5788 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5790 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5798 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:57a0 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:57a8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:57b0 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:57b8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:57c0 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:57c8 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:57d0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:57d8 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:57e0 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:57e8 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:57f0 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:57f8 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5800 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5808 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5810 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5818 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $49        ;; 21:5820 ????????
    db   $0a, $07, $09, $49, $0a, $07, $0a, $49        ;; 21:5828 ????????
    db   $09, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5830 ????????
    db   $0a, $07, $09, $49, $0a, $07, $09, $49        ;; 21:5838 ????????
    db   $0a, $07, $0a, $49, $09, $07, $0a, $49        ;; 21:5840 ????????
    db   $09, $07, $0a, $49, $0a, $07, $09, $fe        ;; 21:5848 ????????
    db   $9a, $04, $01, $f6, $00, $f6, $80, $f6        ;; 21:5850 ????????
    db   $8f, $f5, $ff, $f4, $77, $e0, $00, $e1        ;; 21:5858 ????????
    db   $ff, $e2, $77, $e2, $57, $01, $1b, $e2        ;; 21:5860 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1c, $0d        ;; 21:5868 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5870 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $1b, $0d        ;; 21:5878 ????????
    db   $0e, $e2, $67, $01, $0e, $e2, $77, $49        ;; 21:5880 ????????
    db   $0d, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5888 ????????
    db   $0e, $01, $1b, $0d, $0e, $01, $0d, $e2        ;; 21:5890 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1c, $e2        ;; 21:5898 ????????
    db   $57, $0d, $0d, $01, $1c, $e2, $67, $0d        ;; 21:58a0 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:58a8 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:58b0 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:58b8 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $0d        ;; 21:58c0 ????????
    db   $0e, $01, $1b, $0d, $0e, $e2, $67, $01        ;; 21:58c8 ????????
    db   $0e, $e2, $77, $49, $0d, $e2, $67, $01        ;; 21:58d0 ????????
    db   $1c, $e2, $57, $0d, $0d, $01, $1c, $0d        ;; 21:58d8 ????????
    db   $0e, $01, $0d, $e2, $77, $49, $0e, $e2        ;; 21:58e0 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:58e8 ????????
    db   $1c, $e2, $67, $0d, $0d, $01, $0e, $e2        ;; 21:58f0 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $e2        ;; 21:58f8 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1b, $0d        ;; 21:5900 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0d, $e2        ;; 21:5908 ????????
    db   $57, $01, $1c, $0d, $0e, $01, $1b, $0d        ;; 21:5910 ????????
    db   $0e, $e2, $67, $01, $0d, $e2, $77, $49        ;; 21:5918 ????????
    db   $0e, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5920 ????????
    db   $0d, $01, $1c, $0d, $0d, $01, $0e, $e2        ;; 21:5928 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1b, $e2        ;; 21:5930 ????????
    db   $57, $0d, $0e, $01, $1b, $e2, $67, $0d        ;; 21:5938 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5940 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:5948 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:5950 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1c, $0d        ;; 21:5958 ????????
    db   $0d, $01, $1c, $0d, $0e, $e2, $67, $01        ;; 21:5960 ????????
    db   $0d, $e2, $77, $49, $0e, $e2, $67, $01        ;; 21:5968 ????????
    db   $1b, $e2, $57, $0d, $0e, $01, $1c, $0d        ;; 21:5970 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5978 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5980 ????????
    db   $1b, $e2, $67, $0d, $0e, $01, $0e, $e2        ;; 21:5988 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1b, $e2        ;; 21:5990 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1c, $0d        ;; 21:5998 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:59a0 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $1b, $0d        ;; 21:59a8 ????????
    db   $0e, $e2, $67, $01, $0e, $e2, $77, $49        ;; 21:59b0 ????????
    db   $0d, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:59b8 ????????
    db   $0e, $01, $1b, $0d, $0e, $01, $0d, $e2        ;; 21:59c0 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1c, $e2        ;; 21:59c8 ????????
    db   $57, $0d, $0d, $01, $1c, $e2, $67, $0d        ;; 21:59d0 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:59d8 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:59e0 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:59e8 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $0d        ;; 21:59f0 ????????
    db   $0e, $01, $1b, $0d, $0e, $e2, $67, $01        ;; 21:59f8 ????????
    db   $0e, $e2, $77, $49, $0d, $e2, $67, $01        ;; 21:5a00 ????????
    db   $1c, $e2, $57, $0d, $0d, $01, $1c, $0d        ;; 21:5a08 ????????
    db   $0e, $01, $0d, $e2, $77, $49, $0e, $e2        ;; 21:5a10 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5a18 ????????
    db   $1c, $e2, $67, $0d, $0d, $01, $0e, $e2        ;; 21:5a20 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $e2        ;; 21:5a28 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1b, $0d        ;; 21:5a30 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0d, $e2        ;; 21:5a38 ????????
    db   $57, $01, $1c, $0d, $0e, $01, $1b, $0d        ;; 21:5a40 ????????
    db   $0e, $e2, $67, $01, $0d, $e2, $77, $49        ;; 21:5a48 ????????
    db   $0e, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5a50 ????????
    db   $0d, $01, $1c, $0d, $0d, $01, $0e, $e2        ;; 21:5a58 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1b, $e2        ;; 21:5a60 ????????
    db   $57, $0d, $0e, $01, $1b, $e2, $67, $0d        ;; 21:5a68 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5a70 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:5a78 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:5a80 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1c, $0d        ;; 21:5a88 ????????
    db   $0d, $01, $1c, $0d, $0e, $e2, $67, $01        ;; 21:5a90 ????????
    db   $0d, $e2, $77, $49, $0e, $e2, $67, $01        ;; 21:5a98 ????????
    db   $1b, $e2, $57, $0d, $0e, $01, $1c, $0d        ;; 21:5aa0 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5aa8 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5ab0 ????????
    db   $1b, $e2, $67, $0d, $0e, $01, $0e, $e2        ;; 21:5ab8 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1b, $e2        ;; 21:5ac0 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1c, $0d        ;; 21:5ac8 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5ad0 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $1b, $0d        ;; 21:5ad8 ????????
    db   $0e, $e2, $67, $01, $0e, $e2, $77, $49        ;; 21:5ae0 ????????
    db   $0d, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5ae8 ????????
    db   $0e, $01, $1b, $0d, $0e, $01, $0d, $e2        ;; 21:5af0 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1c, $e2        ;; 21:5af8 ????????
    db   $57, $0d, $0d, $01, $1c, $e2, $67, $0d        ;; 21:5b00 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5b08 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:5b10 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:5b18 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $0d        ;; 21:5b20 ????????
    db   $0e, $01, $1b, $0d, $0e, $e2, $67, $01        ;; 21:5b28 ????????
    db   $0e, $e2, $77, $49, $0d, $e2, $67, $01        ;; 21:5b30 ????????
    db   $1c, $e2, $57, $0d, $0d, $01, $1c, $0d        ;; 21:5b38 ????????
    db   $0e, $01, $0d, $e2, $77, $49, $0e, $e2        ;; 21:5b40 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5b48 ????????
    db   $1c, $e2, $67, $0d, $0d, $01, $0e, $e2        ;; 21:5b50 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $e2        ;; 21:5b58 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1b, $0d        ;; 21:5b60 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0d, $e2        ;; 21:5b68 ????????
    db   $57, $01, $1c, $0d, $0e, $01, $1b, $0d        ;; 21:5b70 ????????
    db   $0e, $e2, $67, $01, $0d, $e2, $77, $49        ;; 21:5b78 ????????
    db   $0e, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5b80 ????????
    db   $0d, $01, $1c, $0d, $0d, $01, $0e, $e2        ;; 21:5b88 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1b, $e2        ;; 21:5b90 ????????
    db   $57, $0d, $0e, $01, $1b, $e2, $67, $0d        ;; 21:5b98 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5ba0 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:5ba8 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:5bb0 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1c, $0d        ;; 21:5bb8 ????????
    db   $0d, $01, $1c, $0d, $0e, $e2, $67, $01        ;; 21:5bc0 ????????
    db   $0d, $e2, $77, $49, $0e, $e2, $67, $01        ;; 21:5bc8 ????????
    db   $1b, $e2, $57, $0d, $0e, $01, $1c, $0d        ;; 21:5bd0 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5bd8 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5be0 ????????
    db   $1b, $e2, $67, $0d, $0e, $01, $0e, $e2        ;; 21:5be8 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1b, $e2        ;; 21:5bf0 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1c, $0d        ;; 21:5bf8 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5c00 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $1b, $0d        ;; 21:5c08 ????????
    db   $0e, $e2, $67, $01, $0e, $e2, $77, $49        ;; 21:5c10 ????????
    db   $0d, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5c18 ????????
    db   $0e, $01, $1b, $0d, $0e, $01, $0d, $e2        ;; 21:5c20 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1c, $e2        ;; 21:5c28 ????????
    db   $57, $0d, $0d, $01, $1c, $e2, $67, $0d        ;; 21:5c30 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5c38 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:5c40 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:5c48 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $0d        ;; 21:5c50 ????????
    db   $0e, $01, $1b, $0d, $0e, $e2, $67, $01        ;; 21:5c58 ????????
    db   $0e, $e2, $77, $49, $0d, $e2, $67, $01        ;; 21:5c60 ????????
    db   $1c, $e2, $57, $0d, $0d, $01, $1c, $0d        ;; 21:5c68 ????????
    db   $0e, $01, $0d, $e2, $77, $49, $0e, $e2        ;; 21:5c70 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5c78 ????????
    db   $1c, $e2, $67, $0d, $0d, $01, $0e, $e2        ;; 21:5c80 ????????
    db   $77, $49, $0e, $e2, $57, $01, $1b, $e2        ;; 21:5c88 ????????
    db   $67, $0d, $0e, $e2, $57, $01, $1b, $0d        ;; 21:5c90 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0d, $e2        ;; 21:5c98 ????????
    db   $57, $01, $1c, $0d, $0e, $01, $1b, $0d        ;; 21:5ca0 ????????
    db   $0e, $e2, $67, $01, $0d, $e2, $77, $49        ;; 21:5ca8 ????????
    db   $0e, $e2, $67, $01, $1c, $e2, $57, $0d        ;; 21:5cb0 ????????
    db   $0d, $01, $1c, $0d, $0d, $01, $0e, $e2        ;; 21:5cb8 ????????
    db   $77, $49, $0e, $e2, $67, $01, $1b, $e2        ;; 21:5cc0 ????????
    db   $57, $0d, $0e, $01, $1b, $e2, $67, $0d        ;; 21:5cc8 ????????
    db   $0e, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5cd0 ????????
    db   $57, $01, $1b, $e2, $67, $0d, $0e, $e2        ;; 21:5cd8 ????????
    db   $57, $01, $1b, $0d, $0e, $01, $0e, $e2        ;; 21:5ce0 ????????
    db   $77, $49, $0d, $e2, $57, $01, $1c, $0d        ;; 21:5ce8 ????????
    db   $0d, $01, $1c, $0d, $0e, $e2, $67, $01        ;; 21:5cf0 ????????
    db   $0d, $e2, $77, $49, $0e, $e2, $67, $01        ;; 21:5cf8 ????????
    db   $1b, $e2, $57, $0d, $0e, $01, $1c, $0d        ;; 21:5d00 ????????
    db   $0d, $01, $0e, $e2, $77, $49, $0e, $e2        ;; 21:5d08 ????????
    db   $67, $01, $1b, $e2, $57, $0d, $0e, $01        ;; 21:5d10 ????????
    db   $1b, $e2, $67, $0d, $0e, $01, $0e, $e2        ;; 21:5d18 ????????
    db   $77, $49, $0d, $e2, $47, $25, $37, $e2        ;; 21:5d20 ????????
    db   $37, $25, $37, $e2, $27, $25, $37, $e2        ;; 21:5d28 ????????
    db   $17, $25, $36, $e2, $47, $27, $37, $e2        ;; 21:5d30 ????????
    db   $37, $27, $37, $e2, $27, $27, $37, $e2        ;; 21:5d38 ????????
    db   $17, $27, $37, $e2, $47, $25, $37, $e2        ;; 21:5d40 ????????
    db   $37, $25, $37, $e2, $27, $25, $37, $e2        ;; 21:5d48 ????????
    db   $17, $25, $36, $e2, $47, $2c, $32, $e2        ;; 21:5d50 ????????
    db   $37, $2c, $32, $e2, $27, $2c, $32, $e2        ;; 21:5d58 ????????
    db   $17, $2c, $2a, $e2, $67, $e2, $47, $28        ;; 21:5d60 ????????
    db   $1c, $25, $6d, $2c, $37, $e2, $67, $1c        ;; 21:5d68 ????????
    db   $37, $1b, $dc, $e2, $57, $19, $db, $1b        ;; 21:5d70 ????????
    db   $db, $e2, $57, $19, $db, $20, $c0, $e2        ;; 21:5d78 ????????
    db   $37, $28, $1c, $e2, $47, $25, $6e, $2c        ;; 21:5d80 ????????
    db   $36, $28, $37, $27, $dc, $25, $6d, $e2        ;; 21:5d88 ????????
    db   $57, $20, $37, $e2, $47, $28, $37, $e2        ;; 21:5d90 ????????
    db   $37, $2c, $c0, $28, $1c, $25, $6d, $e2        ;; 21:5d98 ????????
    db   $47, $2c, $37, $28, $52, $e2, $67, $33        ;; 21:5da0 ????????
    db   $05, $2e, $05, $e2, $57, $33, $04, $2e        ;; 21:5da8 ????????
    db   $05, $e2, $67, $33, $04, $2e, $05, $33        ;; 21:5db0 ????????
    db   $04, $2e, $05, $e2, $77, $49, $09, $e2        ;; 21:5db8 ????????
    db   $57, $33, $05, $2e, $04, $e2, $77, $49        ;; 21:5dc0 ????????
    db   $09, $e2, $57, $33, $05, $2e, $05, $e2        ;; 21:5dc8 ????????
    db   $77, $49, $09, $34, $04, $2e, $05, $e2        ;; 21:5dd0 ????????
    db   $67, $34, $04, $2e, $05, $e2, $77, $49        ;; 21:5dd8 ????????
    db   $09, $e2, $67, $34, $05, $2e, $04, $e2        ;; 21:5de0 ????????
    db   $77, $49, $13, $34, $04, $2f, $05, $49        ;; 21:5de8 ????????
    db   $09, $e2, $67, $34, $04, $2f, $05, $e2        ;; 21:5df0 ????????
    db   $77, $49, $09, $e2, $67, $34, $05, $2f        ;; 21:5df8 ????????
    db   $04, $e2, $77, $49, $09, $e2, $67, $31        ;; 21:5e00 ????????
    db   $09, $31, $12, $31, $0a, $e2, $77, $49        ;; 21:5e08 ????????
    db   $5b, $31, $09, $49, $09, $e2, $67, $31        ;; 21:5e10 ????????
    db   $09, $e2, $77, $49, $0a, $31, $09, $49        ;; 21:5e18 ????????
    db   $09, $e2, $47, $2f, $09, $e2, $77, $49        ;; 21:5e20 ????????
    db   $09, $e2, $57, $31, $09, $e2, $77, $49        ;; 21:5e28 ????????
    db   $09, $e2, $67, $33, $0a, $e2, $57, $33        ;; 21:5e30 ????????
    db   $09, $e2, $77, $49, $09, $e2, $67, $33        ;; 21:5e38 ????????
    db   $09, $e2, $77, $49, $5b, $e2, $47, $33        ;; 21:5e40 ????????
    db   $0a, $e2, $77, $49, $09, $e2, $57, $33        ;; 21:5e48 ????????
    db   $09, $e2, $77, $49, $09, $34, $09, $49        ;; 21:5e50 ????????
    db   $09, $e2, $67, $34, $09, $e2, $77, $49        ;; 21:5e58 ????????
    db   $0a, $e2, $67, $34, $09, $e2, $77, $49        ;; 21:5e60 ????????
    db   $09, $e2, $67, $31, $09, $31, $09, $e2        ;; 21:5e68 ????????
    db   $77, $49, $09, $e2, $67, $31, $09, $e2        ;; 21:5e70 ????????
    db   $77, $49, $5c, $e2, $57, $31, $09, $e2        ;; 21:5e78 ????????
    db   $77, $49, $09, $e2, $67, $31, $09, $e2        ;; 21:5e80 ????????
    db   $77, $49, $09, $e2, $67, $31, $0a, $e2        ;; 21:5e88 ????????
    db   $77, $49, $09, $e2, $57, $2f, $09, $e2        ;; 21:5e90 ????????
    db   $77, $49, $09, $e2, $67, $31, $09, $e2        ;; 21:5e98 ????????
    db   $77, $49, $09, $33, $09, $e2, $67, $33        ;; 21:5ea0 ????????
    db   $0a, $e2, $77, $49, $09, $e2, $67, $33        ;; 21:5ea8 ????????
    db   $09, $e2, $77, $49, $5b, $e2, $57, $33        ;; 21:5eb0 ????????
    db   $09, $e2, $77, $49, $0a, $e2, $67, $33        ;; 21:5eb8 ????????
    db   $09, $e2, $77, $49, $09, $e2, $67, $34        ;; 21:5ec0 ????????
    db   $09, $34, $09, $e2, $77, $49, $09, $e2        ;; 21:5ec8 ????????
    db   $67, $34, $09, $34, $0a, $e2, $77, $49        ;; 21:5ed0 ????????
    db   $09, $31, $09, $e2, $67, $31, $09, $e2        ;; 21:5ed8 ????????
    db   $77, $49, $09, $31, $09, $49, $5c, $e2        ;; 21:5ee0 ????????
    db   $57, $31, $09, $e2, $67, $31, $09, $e2        ;; 21:5ee8 ????????
    db   $77, $49, $09, $e2, $67, $31, $09, $31        ;; 21:5ef0 ????????
    db   $09, $e2, $77, $49, $0a, $e2, $57, $2f        ;; 21:5ef8 ????????
    db   $09, $e2, $77, $49, $09, $e2, $67, $31        ;; 21:5f00 ????????
    db   $09, $e2, $77, $49, $09, $e2, $67, $33        ;; 21:5f08 ????????
    db   $09, $e2, $57, $33, $09, $e2, $77, $49        ;; 21:5f10 ????????
    db   $0a, $33, $09, $49, $24, $e2, $67, $33        ;; 21:5f18 ????????
    db   $09, $e2, $77, $34, $0a, $49, $09, $e2        ;; 21:5f20 ????????
    db   $67, $34, $09, $34, $09, $e2, $77, $49        ;; 21:5f28 ????????
    db   $09, $e2, $67, $34, $09, $e2, $77, $49        ;; 21:5f30 ????????
    db   $09, $e2, $67, $34, $0a, $e2, $77, $49        ;; 21:5f38 ????????
    db   $09, $e2, $67, $33, $09, $e2, $57, $33        ;; 21:5f40 ????????
    db   $09, $e2, $77, $49, $09, $e2, $67, $33        ;; 21:5f48 ????????
    db   $09, $33, $09, $e2, $77, $49, $0a, $fe        ;; 21:5f50 ????????
    db   $f6, $06, $02, $e6, $ff, $e7, $c7, $e7        ;; 21:5f58 ????????
    db   $f7, $01, $1b, $49, $53, $08, $1b, $49        ;; 21:5f60 ????????
    db   $1c, $04, $1b, $49, $1b, $03, $1c, $49        ;; 21:5f68 ????????
    db   $89, $01, $1b, $0b, $1c, $01, $1b, $49        ;; 21:5f70 ????????
    db   $53, $08, $1b, $49, $1b, $04, $1c, $49        ;; 21:5f78 ????????
    db   $1b, $03, $1c, $49, $c0, $01, $1b, $49        ;; 21:5f80 ????????
    db   $52, $08, $1c, $49, $1b, $04, $1c, $49        ;; 21:5f88 ????????
    db   $1b, $03, $1c, $49, $89, $01, $1b, $0b        ;; 21:5f90 ????????
    db   $1c, $01, $1b, $49, $52, $08, $1c, $49        ;; 21:5f98 ????????
    db   $1b, $04, $1c, $49, $1b, $03, $1b, $49        ;; 21:5fa0 ????????
    db   $c0, $e7, $f7, $01, $1b, $49, $53, $08        ;; 21:5fa8 ????????
    db   $1b, $49, $1c, $04, $1b, $49, $1b, $03        ;; 21:5fb0 ????????
    db   $1c, $49, $60, $e7, $b7, $01, $0e, $e7        ;; 21:5fb8 ????????
    db   $c7, $0b, $0d, $e7, $b7, $01, $0e, $e7        ;; 21:5fc0 ????????
    db   $c7, $49, $0e, $e7, $b7, $01, $0d, $0b        ;; 21:5fc8 ????????
    db   $0e, $e7, $c7, $01, $0e, $01, $1b, $49        ;; 21:5fd0 ????????
    db   $53, $08, $1b, $49, $1b, $04, $1c, $49        ;; 21:5fd8 ????????
    db   $1b, $03, $1c, $49, $60, $0b, $0d, $49        ;; 21:5fe0 ????????
    db   $0e, $0b, $0e, $49, $0e, $0b, $0d, $49        ;; 21:5fe8 ????????
    db   $0e, $0b, $0e, $01, $1b, $49, $52, $08        ;; 21:5ff0 ????????
    db   $1c, $49, $1b, $04, $1c, $49, $1b, $03        ;; 21:5ff8 ????????
    db   $1c, $49, $96, $01, $0e, $0b, $0e, $01        ;; 21:6000 ????????
    db   $29, $49, $52, $08, $1c, $49, $1b, $04        ;; 21:6008 ????????
    db   $1c, $49, $1b, $03, $1b, $49, $60, $03        ;; 21:6010 ????????
    db   $0e, $49, $0e, $03, $0e, $49, $0d, $03        ;; 21:6018 ????????
    db   $0e, $e7, $b7, $04, $0e, $e7, $c7, $08        ;; 21:6020 ????????
    db   $0d, $e7, $c7, $01, $1b, $49, $53, $08        ;; 21:6028 ????????
    db   $1b, $49, $1c, $04, $1b, $49, $1b, $03        ;; 21:6030 ????????
    db   $1c, $49, $89, $01, $1b, $0b, $1c, $01        ;; 21:6038 ????????
    db   $1b, $49, $53, $08, $1b, $49, $1b, $04        ;; 21:6040 ????????
    db   $1c, $49, $1b, $03, $1c, $49, $c0, $01        ;; 21:6048 ????????
    db   $1b, $49, $52, $08, $1c, $49, $1b, $04        ;; 21:6050 ????????
    db   $1c, $49, $1b, $03, $1c, $49, $89, $01        ;; 21:6058 ????????
    db   $1b, $0b, $1c, $01, $1b, $49, $52, $08        ;; 21:6060 ????????
    db   $1c, $49, $1b, $04, $1c, $49, $1b, $03        ;; 21:6068 ????????
    db   $1b, $49, $c0, $e7, $c7, $01, $1b, $49        ;; 21:6070 ????????
    db   $53, $08, $1b, $49, $1c, $04, $1b, $49        ;; 21:6078 ????????
    db   $1b, $03, $1c, $49, $60, $e7, $b7, $01        ;; 21:6080 ????????
    db   $0e, $e7, $c7, $0b, $0d, $e7, $b7, $01        ;; 21:6088 ????????
    db   $0e, $e7, $c7, $49, $0e, $e7, $b7, $01        ;; 21:6090 ????????
    db   $0d, $0b, $0e, $e7, $c7, $01, $0e, $01        ;; 21:6098 ????????
    db   $1b, $49, $53, $08, $1b, $49, $1b, $04        ;; 21:60a0 ????????
    db   $1c, $49, $1b, $03, $1c, $49, $60, $0b        ;; 21:60a8 ????????
    db   $0d, $49, $0e, $0b, $0e, $49, $0e, $0b        ;; 21:60b0 ????????
    db   $0d, $49, $0e, $0b, $0e, $01, $1b, $49        ;; 21:60b8 ????????
    db   $52, $08, $1c, $49, $1b, $04, $1c, $49        ;; 21:60c0 ????????
    db   $1b, $03, $1c, $49, $96, $01, $0e, $0b        ;; 21:60c8 ????????
    db   $0e, $01, $29, $49, $52, $08, $1c, $49        ;; 21:60d0 ????????
    db   $1b, $04, $1c, $49, $1b, $03, $1b, $49        ;; 21:60d8 ????????
    db   $60, $03, $0e, $49, $0e, $03, $0e, $49        ;; 21:60e0 ????????
    db   $0d, $03, $0e, $e7, $b7, $04, $0e, $e7        ;; 21:60e8 ????????
    db   $c7, $08, $0d, $e7, $c7, $49, $c8, $49        ;; 21:60f0 ????????
    db   $c8, $49, $c8, $49, $c8, $49, $c8, $49        ;; 21:60f8 ????????
    db   $c8, $49, $75, $e7, $a7, $25, $37, $2c        ;; 21:6100 ????????
    db   $36, $2f, $37, $34, $37, $27, $37, $2a        ;; 21:6108 ????????
    db   $37, $2e, $37, $33, $36, $e7, $a7, $25        ;; 21:6110 ????????
    db   $37, $2c, $37, $2f, $37, $34, $36, $27        ;; 21:6118 ????????
    db   $37, $2a, $1c, $2c, $1b, $e7, $b7, $2e        ;; 21:6120 ????????
    db   $37, $33, $37, $e7, $a7, $25, $37, $2c        ;; 21:6128 ????????
    db   $37, $2f, $37, $34, $36, $27, $37, $2a        ;; 21:6130 ????????
    db   $37, $2e, $37, $33, $37, $25, $37, $2c        ;; 21:6138 ????????
    db   $36, $2f, $37, $34, $37, $27, $37, $2a        ;; 21:6140 ????????
    db   $1b, $2c, $1c, $e7, $b7, $2e, $37, $33        ;; 21:6148 ????????
    db   $37, $1c, $0d, $20, $0e, $23, $0e, $1c        ;; 21:6150 ????????
    db   $0d, $20, $0e, $25, $0e, $1c, $0e, $20        ;; 21:6158 ????????
    db   $0d, $23, $0e, $1c, $0e, $20, $0d, $25        ;; 21:6160 ????????
    db   $0e, $23, $0e, $25, $0e, $23, $0d, $22        ;; 21:6168 ????????
    db   $0e, $1b, $0e, $20, $0d, $27, $0e, $1b        ;; 21:6170 ????????
    db   $0e, $20, $0e, $28, $0d, $1b, $0e, $20        ;; 21:6178 ????????
    db   $0e, $27, $0d, $23, $0e, $27, $0e, $23        ;; 21:6180 ????????
    db   $0e, $28, $0d, $27, $0e, $25, $0e, $27        ;; 21:6188 ????????
    db   $0d, $e7, $b7, $1c, $0e, $20, $0d, $25        ;; 21:6190 ????????
    db   $0e, $23, $0e, $20, $0e, $25, $0d, $1c        ;; 21:6198 ????????
    db   $0e, $20, $0e, $23, $0d, $20, $0e, $25        ;; 21:61a0 ????????
    db   $0e, $23, $0e, $1c, $0d, $20, $0e, $23        ;; 21:61a8 ????????
    db   $0e, $25, $0d, $27, $0e, $1b, $0e, $20        ;; 21:61b0 ????????
    db   $0e, $23, $0d, $28, $0e, $27, $0e, $23        ;; 21:61b8 ????????
    db   $0d, $20, $0e, $1b, $0e, $20, $0e, $28        ;; 21:61c0 ????????
    db   $0d, $27, $0e, $23, $0e, $25, $0d, $27        ;; 21:61c8 ????????
    db   $0e, $25, $0e, $e7, $a7, $34, $07, $31        ;; 21:61d0 ????????
    db   $07, $2f, $07, $2c, $07, $28, $07, $25        ;; 21:61d8 ????????
    db   $07, $23, $07, $20, $06, $1c, $07, $19        ;; 21:61e0 ????????
    db   $07, $17, $07, $14, $07, $10, $07, $0d        ;; 21:61e8 ????????
    db   $07, $0b, $07, $08, $06, $34, $07, $33        ;; 21:61f0 ????????
    db   $07, $2f, $07, $2e, $07, $2c, $07, $28        ;; 21:61f8 ????????
    db   $07, $27, $07, $25, $06, $23, $07, $20        ;; 21:6200 ????????
    db   $07, $1c, $07, $1b, $07, $19, $07, $17        ;; 21:6208 ????????
    db   $07, $16, $07, $14, $06, $34, $07, $31        ;; 21:6210 ????????
    db   $07, $2f, $07, $2c, $07, $28, $07, $25        ;; 21:6218 ????????
    db   $07, $23, $07, $20, $06, $1c, $07, $19        ;; 21:6220 ????????
    db   $07, $17, $07, $14, $07, $10, $07, $0f        ;; 21:6228 ????????
    db   $07, $0d, $07, $0b, $06, $38, $07, $34        ;; 21:6230 ????????
    db   $07, $33, $07, $2f, $07, $2e, $07, $2c        ;; 21:6238 ????????
    db   $07, $28, $07, $27, $06, $25, $07, $23        ;; 21:6240 ????????
    db   $07, $22, $07, $20, $07, $1c, $07, $1b        ;; 21:6248 ????????
    db   $07, $19, $07, $17, $06, $34, $07, $31        ;; 21:6250 ????????
    db   $07, $2f, $07, $2e, $07, $2c, $07, $28        ;; 21:6258 ????????
    db   $07, $27, $07, $25, $06, $23, $07, $22        ;; 21:6260 ????????
    db   $07, $20, $07, $1c, $07, $1b, $07, $19        ;; 21:6268 ????????
    db   $07, $17, $07, $14, $06, $31, $07, $33        ;; 21:6270 ????????
    db   $07, $34, $07, $2c, $07, $2e, $06, $2f        ;; 21:6278 ????????
    db   $07, $25, $07, $27, $06, $28, $07, $20        ;; 21:6280 ????????
    db   $07, $22, $07, $23, $07, $19, $06, $1b        ;; 21:6288 ????????
    db   $07, $1c, $07, $14, $06, $34, $07, $33        ;; 21:6290 ????????
    db   $07, $31, $07, $2f, $07, $2e, $07, $2c        ;; 21:6298 ????????
    db   $07, $25, $07, $27, $06, $28, $07, $23        ;; 21:62a0 ????????
    db   $07, $22, $07, $20, $07, $19, $07, $1b        ;; 21:62a8 ????????
    db   $07, $1c, $07, $17, $06, $19, $07, $1b        ;; 21:62b0 ????????
    db   $07, $1c, $07, $20, $07, $22, $07, $23        ;; 21:62b8 ????????
    db   $07, $25, $07, $27, $06, $28, $07, $2c        ;; 21:62c0 ????????
    db   $07, $2e, $07, $2f, $07, $31, $07, $33        ;; 21:62c8 ????????
    db   $07, $34, $07, $33, $06, $fe, $78, $03        ;; 21:62d0 ????????
    db   $03, $fd, $01, $17, $2d, $43, $59, $00        ;; 21:62d8 ????????
    db   $00, $00, $00, $00, $00, $57, $41, $2b        ;; 21:62e0 ????????
    db   $15, $00, $ea, $80, $eb, $ff, $ec, $40        ;; 21:62e8 ????????
    db   $00, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 21:62f0 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 21:62f8 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 21:6300 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 21:6308 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 21:6310 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $51        ;; 21:6318 ????????
    db   $49, $c8, $49, $c8, $49, $b8, $49, $c8        ;; 21:6320 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 21:6328 ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $9b        ;; 21:6330 ????????
    db   $01, $1b, $01, $1c, $01, $1b, $01, $1c        ;; 21:6338 ????????
    db   $01, $1b, $01, $1c, $01, $1b, $01, $1b        ;; 21:6340 ????????
    db   $03, $1c, $03, $1b, $03, $1c, $03, $1b        ;; 21:6348 ????????
    db   $03, $1c, $03, $1b, $03, $1b, $03, $1c        ;; 21:6350 ????????
    db   $04, $1b, $04, $1c, $04, $1b, $04, $1c        ;; 21:6358 ????????
    db   $04, $1b, $04, $1b, $04, $1c, $04, $1b        ;; 21:6360 ????????
    db   $06, $1c, $06, $1b, $06, $1c, $06, $1b        ;; 21:6368 ????????
    db   $06, $1b, $06, $1c, $06, $1b, $06, $1c        ;; 21:6370 ????????
    db   $08, $1b, $08, $1c, $08, $1b, $08, $1b        ;; 21:6378 ????????
    db   $08, $1c, $08, $1b, $08, $1c, $08, $1b        ;; 21:6380 ????????
    db   $08, $1c, $08, $1b, $08, $1b, $08, $1c        ;; 21:6388 ????????
    db   $08, $1b, $08, $1c, $06, $1b, $04, $1c        ;; 21:6390 ????????
    db   $01, $1b, $01, $1b, $01, $1c, $01, $1b        ;; 21:6398 ????????
    db   $01, $1c, $01, $1b, $01, $1c, $01, $1b        ;; 21:63a0 ????????
    db   $03, $1b, $03, $1c, $03, $1b, $03, $1c        ;; 21:63a8 ????????
    db   $03, $1b, $03, $1c, $03, $1b, $03, $1b        ;; 21:63b0 ????????
    db   $04, $1b, $04, $1c, $04, $1b, $04, $1c        ;; 21:63b8 ????????
    db   $04, $1b, $04, $1c, $04, $1b, $04, $1b        ;; 21:63c0 ????????
    db   $06, $1c, $06, $1b, $06, $1c, $06, $1b        ;; 21:63c8 ????????
    db   $06, $1c, $06, $1b, $06, $1b, $06, $1c        ;; 21:63d0 ????????
    db   $08, $1b, $08, $1c, $08, $1b, $08, $1c        ;; 21:63d8 ????????
    db   $08, $1b, $08, $1b, $08, $1c, $08, $1b        ;; 21:63e0 ????????
    db   $08, $1c, $08, $1b, $08, $1c, $08, $1b        ;; 21:63e8 ????????
    db   $08, $1b, $08, $1c, $06, $1b, $04, $1c        ;; 21:63f0 ????????
    db   $01, $1b, $01, $1c, $01, $1b, $01, $1b        ;; 21:63f8 ????????
    db   $01, $1c, $01, $1b, $01, $1c, $01, $1b        ;; 21:6400 ????????
    db   $08, $1c, $08, $1b, $08, $1b, $08, $1c        ;; 21:6408 ????????
    db   $08, $1b, $08, $1c, $04, $1b, $04, $1c        ;; 21:6410 ????????
    db   $08, $1b, $08, $1b, $08, $1c, $08, $1b        ;; 21:6418 ????????
    db   $08, $1c, $08, $1b, $08, $1c, $08, $1b        ;; 21:6420 ????????
    db   $08, $1b, $08, $1c, $08, $1b, $08, $1c        ;; 21:6428 ????????
    db   $08, $1b, $08, $1c, $06, $1b, $04, $1b        ;; 21:6430 ????????
    db   $0d, $1b, $01, $1c, $0d, $1b, $01, $1c        ;; 21:6438 ????????
    db   $0d, $1b, $01, $1c, $0d, $1b, $01, $1b        ;; 21:6440 ????????
    db   $0f, $1c, $03, $1b, $0f, $1c, $03, $1b        ;; 21:6448 ????????
    db   $0f, $1c, $03, $1b, $0f, $1b, $03, $1c        ;; 21:6450 ????????
    db   $10, $1b, $04, $1c, $10, $1b, $04, $1c        ;; 21:6458 ????????
    db   $10, $1b, $04, $1b, $10, $1c, $04, $1b        ;; 21:6460 ????????
    db   $12, $1c, $06, $1b, $12, $1c, $06, $1b        ;; 21:6468 ????????
    db   $12, $1b, $06, $1c, $12, $1b, $06, $1c        ;; 21:6470 ????????
    db   $14, $1b, $08, $1c, $14, $1b, $08, $1b        ;; 21:6478 ????????
    db   $14, $1c, $08, $1b, $14, $1c, $08, $1b        ;; 21:6480 ????????
    db   $14, $1c, $14, $1b, $14, $1b, $14, $1c        ;; 21:6488 ????????
    db   $14, $1b, $14, $1c, $12, $1b, $10, $1c        ;; 21:6490 ????????
    db   $fe, $aa, $01, $04, $f0, $14, $f1, $21        ;; 21:6498 ????????
    db   $f2, $22, $f3, $80, $08, $0e, $49, $0d        ;; 21:64a0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:64a8 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:64b0 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:64b8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:64c0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:64c8 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:64d0 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:64d8 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:64e0 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:64e8 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:64f0 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:64f8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6500 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6508 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6510 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6518 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6520 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:6528 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:6530 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:6538 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6540 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:6548 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6550 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6558 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6560 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:6568 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6570 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6578 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6580 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6588 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6590 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6598 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:65a0 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:65a8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $06        ;; 21:65b0 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:65b8 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:65c0 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $15        ;; 21:65c8 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:65d0 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:65d8 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:65e0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:65e8 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:65f0 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:65f8 ????????
    db   $08, $07, $49, $14, $08, $0e, $49, $0d        ;; 21:6600 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6608 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6610 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6618 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6620 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6628 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6630 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6638 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:6640 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6648 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:6650 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:6658 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6660 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6668 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6670 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6678 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6680 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:6688 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:6690 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:6698 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:66a0 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:66a8 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:66b0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:66b8 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:66c0 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:66c8 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:66d0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:66d8 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:66e0 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:66e8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:66f0 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:66f8 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6700 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6708 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $06        ;; 21:6710 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6718 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6720 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $15        ;; 21:6728 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6730 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6738 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6740 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6748 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6750 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6758 ????????
    db   $08, $07, $49, $14, $08, $0e, $49, $0d        ;; 21:6760 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6768 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6770 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6778 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6780 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6788 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6790 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6798 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:67a0 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:67a8 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:67b0 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:67b8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:67c0 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:67c8 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:67d0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:67d8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:67e0 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:67e8 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:67f0 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:67f8 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6800 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:6808 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6810 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6818 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6820 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:6828 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6830 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6838 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6840 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6848 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6850 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6858 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6860 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6868 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $06        ;; 21:6870 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6878 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6880 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $15        ;; 21:6888 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6890 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6898 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:68a0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:68a8 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:68b0 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:68b8 ????????
    db   $08, $07, $49, $14, $08, $0e, $49, $0d        ;; 21:68c0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:68c8 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:68d0 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:68d8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:68e0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:68e8 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:68f0 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:68f8 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:6900 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6908 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:6910 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:6918 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6920 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6928 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6930 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6938 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6940 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:6948 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:6950 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:6958 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6960 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:6968 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6970 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6978 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6980 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:6988 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6990 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6998 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:69a0 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:69a8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:69b0 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:69b8 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:69c0 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:69c8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $06        ;; 21:69d0 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:69d8 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:69e0 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $15        ;; 21:69e8 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:69f0 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:69f8 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6a00 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6a08 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6a10 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6a18 ????????
    db   $08, $07, $49, $14, $08, $0e, $49, $0d        ;; 21:6a20 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6a28 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6a30 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6a38 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6a40 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6a48 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6a50 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6a58 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:6a60 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6a68 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:6a70 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:6a78 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6a80 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6a88 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6a90 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6a98 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6aa0 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:6aa8 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:6ab0 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:6ab8 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6ac0 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:6ac8 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6ad0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6ad8 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6ae0 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:6ae8 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6af0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6af8 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6b00 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6b08 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6b10 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6b18 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6b20 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6b28 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $06        ;; 21:6b30 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6b38 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6b40 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $15        ;; 21:6b48 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6b50 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6b58 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6b60 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6b68 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6b70 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6b78 ????????
    db   $08, $07, $49, $14, $08, $0e, $49, $0d        ;; 21:6b80 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6b88 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6b90 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6b98 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6ba0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6ba8 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6bb0 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6bb8 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:6bc0 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6bc8 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:6bd0 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:6bd8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6be0 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6be8 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6bf0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6bf8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6c00 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:6c08 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:6c10 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:6c18 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6c20 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:6c28 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6c30 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6c38 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6c40 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:6c48 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6c50 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6c58 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6c60 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6c68 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6c70 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6c78 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6c80 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6c88 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $06        ;; 21:6c90 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6c98 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6ca0 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $15        ;; 21:6ca8 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6cb0 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6cb8 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6cc0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6cc8 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6cd0 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6cd8 ????????
    db   $08, $07, $49, $14, $08, $0e, $49, $0d        ;; 21:6ce0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6ce8 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6cf0 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6cf8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6d00 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6d08 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $07        ;; 21:6d10 ????????
    db   $08, $06, $49, $07, $08, $0e, $49, $0e        ;; 21:6d18 ????????
    db   $08, $07, $49, $06, $08, $07, $49, $07        ;; 21:6d20 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6d28 ????????
    db   $08, $07, $49, $15, $08, $07, $49, $06        ;; 21:6d30 ????????
    db   $08, $07, $49, $15, $08, $0e, $49, $0d        ;; 21:6d38 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6d40 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6d48 ????????
    db   $08, $07, $49, $07, $08, $0d, $49, $0e        ;; 21:6d50 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6d58 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6d60 ????????
    db   $08, $0e, $49, $0e, $08, $07, $49, $06        ;; 21:6d68 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0e        ;; 21:6d70 ????????
    db   $08, $06, $49, $07, $08, $07, $49, $07        ;; 21:6d78 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6d80 ????????
    db   $08, $07, $49, $15, $08, $06, $49, $07        ;; 21:6d88 ????????
    db   $08, $07, $49, $15, $08, $0d, $49, $0e        ;; 21:6d90 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6d98 ????????
    db   $08, $0d, $49, $0e, $08, $07, $49, $07        ;; 21:6da0 ????????
    db   $08, $07, $49, $06, $08, $0e, $49, $0e        ;; 21:6da8 ????????
    db   $08, $07, $49, $07, $08, $06, $49, $15        ;; 21:6db0 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $14        ;; 21:6db8 ????????
    db   $08, $0e, $49, $0e, $08, $06, $49, $07        ;; 21:6dc0 ????????
    db   $08, $07, $49, $07, $08, $0e, $49, $0d        ;; 21:6dc8 ????????
    db   $08, $07, $49, $07, $08, $07, $49, $07        ;; 21:6dd0 ????????
    db   $08, $0e, $49, $0d, $08, $07, $49, $07        ;; 21:6dd8 ????????
    db   $08, $07, $49, $14, $08, $07, $49, $07        ;; 21:6de0 ????????
    db   $08, $07, $49, $15, $fe, $4c, $09, $01        ;; 21:6de8 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:6df0 ????????
    db   $e2, $77, $e2, $b7, $19, $01, $e2, $07        ;; 21:6df8 ????????
    db   $49, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 21:6e00 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $00, $1e        ;; 21:6e08 ????????
    db   $e2, $47, $3d, $01, $31, $01, $3d, $01        ;; 21:6e10 ????????
    db   $31, $01, $3d, $01, $e2, $07, $49, $78        ;; 21:6e18 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $7e        ;; 21:6e20 ????????
    db   $e1, $ff, $e2, $77, $e2, $b7, $48, $01        ;; 21:6e28 ????????
    db   $0d, $01, $48, $01, $0d, $01, $48, $01        ;; 21:6e30 ????????
    db   $0d, $01, $48, $01, $0d, $01, $48, $01        ;; 21:6e38 ????????
    db   $0d, $01, $48, $01, $0d, $01, $49, $2d        ;; 21:6e40 ????????
    db   $00, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 21:6e48 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $17        ;; 21:6e50 ????????
    db   $2a, $01, $2e, $01, $31, $01, $36, $01        ;; 21:6e58 ????????
    db   $e2, $37, $2a, $01, $2e, $01, $31, $01        ;; 21:6e60 ????????
    db   $36, $01, $e2, $57, $2a, $01, $2e, $01        ;; 21:6e68 ????????
    db   $31, $01, $36, $01, $e2, $37, $2a, $01        ;; 21:6e70 ????????
    db   $2e, $01, $31, $01, $36, $01, $e2, $17        ;; 21:6e78 ????????
    db   $2a, $01, $2e, $01, $31, $01, $36, $02        ;; 21:6e80 ????????
    db   $e2, $07, $49, $78, $ff, $01, $f5, $ff        ;; 21:6e88 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:6e90 ????????
    db   $e2, $17, $2a, $01, $36, $01, $2e, $01        ;; 21:6e98 ????????
    db   $3a, $01, $31, $01, $3d, $01, $36, $01        ;; 21:6ea0 ????????
    db   $42, $01, $e2, $37, $2a, $01, $36, $01        ;; 21:6ea8 ????????
    db   $2e, $01, $3a, $01, $31, $01, $3d, $01        ;; 21:6eb0 ????????
    db   $36, $01, $42, $01, $e2, $57, $2a, $01        ;; 21:6eb8 ????????
    db   $36, $01, $2e, $01, $3a, $01, $31, $01        ;; 21:6ec0 ????????
    db   $3d, $01, $36, $01, $42, $01, $e2, $37        ;; 21:6ec8 ????????
    db   $2a, $01, $36, $01, $2e, $01, $3a, $01        ;; 21:6ed0 ????????
    db   $31, $01, $3d, $01, $36, $01, $42, $01        ;; 21:6ed8 ????????
    db   $e2, $17, $2a, $01, $36, $01, $2e, $01        ;; 21:6ee0 ????????
    db   $3a, $01, $31, $01, $3d, $01, $36, $01        ;; 21:6ee8 ????????
    db   $42, $01, $49, $78, $ff, $01, $f5, $ff        ;; 21:6ef0 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:6ef8 ????????
    db   $00, $0c, $ff, $01, $f5, $ff, $f4, $77        ;; 21:6f00 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 21:6f08 ????????
    db   $25, $05, $24, $05, $25, $05, $27, $05        ;; 21:6f10 ????????
    db   $25, $05, $27, $05, $29, $05, $e2, $07        ;; 21:6f18 ????????
    db   $49, $02, $e2, $57, $29, $03, $e2, $07        ;; 21:6f20 ????????
    db   $49, $02, $e2, $57, $29, $03, $e2, $07        ;; 21:6f28 ????????
    db   $49, $02, $e2, $57, $29, $03, $e2, $07        ;; 21:6f30 ????????
    db   $49, $02, $e2, $07, $49, $1e, $ff, $01        ;; 21:6f38 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:6f40 ????????
    db   $e2, $77, $00, $0c, $ff, $01, $f5, $ff        ;; 21:6f48 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:6f50 ????????
    db   $00, $0c, $ff, $01, $f5, $ff, $f4, $77        ;; 21:6f58 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 21:6f60 ????????
    db   $19, $01, $25, $01, $e2, $07, $49, $1e        ;; 21:6f68 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:6f70 ????????
    db   $e1, $ff, $e2, $77, $e2, $57, $01, $01        ;; 21:6f78 ????????
    db   $e2, $07, $49, $1e, $ff, $01, $f5, $ff        ;; 21:6f80 ????????
    db   $f4, $77, $e0, $76, $e1, $ff, $e2, $77        ;; 21:6f88 ????????
    db   $e2, $b7, $01, $01, $19, $01, $0d, $01        ;; 21:6f90 ????????
    db   $25, $01, $19, $01, $31, $01, $25, $01        ;; 21:6f98 ????????
    db   $3d, $01, $49, $2d, $00, $78, $ff, $01        ;; 21:6fa0 ????????
    db   $f5, $ff, $f4, $77, $e0, $17, $e1, $ff        ;; 21:6fa8 ????????
    db   $e2, $77, $e2, $57, $25, $01, $28, $01        ;; 21:6fb0 ????????
    db   $27, $01, $29, $01, $2a, $01, $2b, $01        ;; 21:6fb8 ????????
    db   $2c, $01, $2d, $01, $2e, $01, $2f, $01        ;; 21:6fc0 ????????
    db   $30, $01, $31, $01, $e2, $07, $49, $1e        ;; 21:6fc8 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:6fd0 ????????
    db   $e1, $ff, $e2, $77, $e2, $57, $25, $01        ;; 21:6fd8 ????????
    db   $26, $01, $27, $01, $29, $01, $2a, $01        ;; 21:6fe0 ????????
    db   $2b, $01, $2c, $01, $2d, $01, $2e, $01        ;; 21:6fe8 ????????
    db   $2f, $01, $30, $01, $31, $01, $34, $01        ;; 21:6ff0 ????????
    db   $33, $01, $35, $01, $36, $01, $37, $01        ;; 21:6ff8 ????????
    db   $38, $01, $39, $01, $3a, $01, $3b, $01        ;; 21:7000 ????????
    db   $3c, $01, $3d, $01, $3e, $01, $e2, $47        ;; 21:7008 ????????
    db   $3f, $01, $41, $01, $e2, $47, $42, $01        ;; 21:7010 ????????
    db   $43, $01, $e2, $37, $44, $01, $45, $01        ;; 21:7018 ????????
    db   $e2, $27, $46, $01, $47, $01, $e2, $17        ;; 21:7020 ????????
    db   $48, $01, $e2, $07, $49, $1e, $ff, $01        ;; 21:7028 ????????
    db   $f5, $ff, $f4, $77, $e0, $7c, $e1, $ff        ;; 21:7030 ????????
    db   $e2, $77, $e2, $b7, $25, $0f, $24, $0f        ;; 21:7038 ????????
    db   $23, $0f, $49, $2d, $00, $78, $ff, $01        ;; 21:7040 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:7048 ????????
    db   $e2, $77, $e2, $57, $3d, $05, $3c, $05        ;; 21:7050 ????????
    db   $3b, $05, $3a, $05, $3c, $04, $3b, $04        ;; 21:7058 ????????
    db   $3a, $04, $39, $04, $3b, $03, $3a, $03        ;; 21:7060 ????????
    db   $39, $02, $38, $02, $37, $01, $36, $01        ;; 21:7068 ????????
    db   $35, $01, $34, $01, $33, $01, $32, $01        ;; 21:7070 ????????
    db   $31, $01, $30, $01, $2e, $01, $e2, $47        ;; 21:7078 ????????
    db   $2c, $01, $2a, $01, $e2, $37, $28, $01        ;; 21:7080 ????????
    db   $26, $01, $e2, $27, $24, $01, $22, $01        ;; 21:7088 ????????
    db   $e2, $17, $20, $01, $1e, $01, $e2, $07        ;; 21:7090 ????????
    db   $1c, $01, $e2, $07, $49, $1e, $ff, $01        ;; 21:7098 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:70a0 ????????
    db   $e2, $77, $e2, $57, $22, $01, $e2, $07        ;; 21:70a8 ????????
    db   $49, $01, $e2, $57, $28, $01, $e2, $07        ;; 21:70b0 ????????
    db   $49, $01, $e2, $57, $22, $01, $e2, $07        ;; 21:70b8 ????????
    db   $49, $01, $e2, $57, $28, $01, $e2, $07        ;; 21:70c0 ????????
    db   $49, $01, $e2, $57, $22, $01, $e2, $07        ;; 21:70c8 ????????
    db   $49, $01, $e2, $57, $28, $01, $e2, $07        ;; 21:70d0 ????????
    db   $49, $01, $e2, $57, $22, $01, $e2, $07        ;; 21:70d8 ????????
    db   $49, $01, $e2, $57, $28, $01, $e2, $07        ;; 21:70e0 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 21:70e8 ????????
    db   $e0, $17, $e1, $ff, $e2, $c7, $e2, $17        ;; 21:70f0 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:70f8 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7100 ????????
    db   $e2, $27, $25, $01, $19, $01, $25, $01        ;; 21:7108 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7110 ????????
    db   $19, $01, $e2, $37, $3d, $01, $31, $01        ;; 21:7118 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7120 ????????
    db   $3d, $01, $31, $01, $e2, $47, $25, $01        ;; 21:7128 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7130 ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $57        ;; 21:7138 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7140 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7148 ????????
    db   $e2, $67, $25, $01, $19, $01, $25, $01        ;; 21:7150 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7158 ????????
    db   $19, $01, $e2, $77, $3d, $01, $31, $01        ;; 21:7160 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7168 ????????
    db   $3d, $01, $31, $01, $e2, $87, $25, $01        ;; 21:7170 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7178 ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $97        ;; 21:7180 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7188 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7190 ????????
    db   $e2, $a7, $25, $01, $19, $01, $25, $01        ;; 21:7198 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:71a0 ????????
    db   $19, $01, $e2, $b7, $3d, $01, $31, $01        ;; 21:71a8 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:71b0 ????????
    db   $3d, $01, $31, $01, $e2, $c7, $25, $01        ;; 21:71b8 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:71c0 ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $b7        ;; 21:71c8 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:71d0 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:71d8 ????????
    db   $e2, $a7, $25, $01, $19, $01, $25, $01        ;; 21:71e0 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:71e8 ????????
    db   $19, $01, $e2, $97, $3d, $01, $31, $01        ;; 21:71f0 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:71f8 ????????
    db   $3d, $01, $31, $01, $e2, $87, $25, $01        ;; 21:7200 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7208 ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $77        ;; 21:7210 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7218 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7220 ????????
    db   $e2, $67, $25, $01, $19, $01, $25, $01        ;; 21:7228 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7230 ????????
    db   $19, $01, $e2, $57, $3d, $01, $31, $01        ;; 21:7238 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7240 ????????
    db   $3d, $01, $31, $01, $e2, $47, $25, $01        ;; 21:7248 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7250 ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $37        ;; 21:7258 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7260 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7268 ????????
    db   $e2, $27, $25, $01, $19, $01, $25, $01        ;; 21:7270 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 21:7278 ????????
    db   $19, $01, $e2, $17, $3d, $01, $31, $01        ;; 21:7280 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 21:7288 ????????
    db   $3d, $01, $31, $01, $e2, $07, $49, $1e        ;; 21:7290 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $7f        ;; 21:7298 ????????
    db   $e1, $ff, $e2, $77, $e2, $b7, $19, $05        ;; 21:72a0 ????????
    db   $18, $05, $17, $05, $18, $05, $17, $05        ;; 21:72a8 ????????
    db   $16, $05, $17, $05, $16, $05, $15, $05        ;; 21:72b0 ????????
    db   $49, $0f, $00, $78, $ff, $01, $f5, $ff        ;; 21:72b8 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:72c0 ????????
    db   $e2, $b7, $19, $01, $e2, $d0, $00, $01        ;; 21:72c8 ????????
    db   $00, $03, $e2, $b7, $02, $04, $e2, $d0        ;; 21:72d0 ????????
    db   $00, $01, $e2, $b7, $19, $01, $e2, $d0        ;; 21:72d8 ????????
    db   $00, $01, $00, $03, $e2, $b7, $02, $04        ;; 21:72e0 ????????
    db   $e2, $d0, $00, $01, $e2, $b7, $1a, $01        ;; 21:72e8 ????????
    db   $e2, $d0, $00, $01, $00, $03, $e2, $b7        ;; 21:72f0 ????????
    db   $02, $04, $e2, $d0, $00, $01, $e2, $b7        ;; 21:72f8 ????????
    db   $19, $01, $e2, $d0, $00, $01, $00, $03        ;; 21:7300 ????????
    db   $e2, $b7, $02, $04, $e2, $d0, $00, $01        ;; 21:7308 ????????
    db   $00, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 21:7310 ????????
    db   $e0, $17, $e1, $ff, $e2, $77, $e2, $17        ;; 21:7318 ????????
    db   $20, $04, $14, $04, $e2, $27, $21, $04        ;; 21:7320 ????????
    db   $15, $04, $e2, $37, $22, $04, $16, $04        ;; 21:7328 ????????
    db   $e2, $47, $23, $04, $17, $04, $e2, $57        ;; 21:7330 ????????
    db   $24, $04, $18, $04, $e2, $07, $49, $1e        ;; 21:7338 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $1f        ;; 21:7340 ????????
    db   $e1, $ff, $e2, $77, $e2, $17, $24, $04        ;; 21:7348 ????????
    db   $18, $04, $e2, $27, $23, $04, $17, $04        ;; 21:7350 ????????
    db   $e2, $37, $22, $04, $16, $04, $e2, $47        ;; 21:7358 ????????
    db   $21, $04, $15, $04, $e2, $57, $20, $04        ;; 21:7360 ????????
    db   $14, $04, $e2, $07, $49, $1e, $ff, $01        ;; 21:7368 ????????
    db   $f5, $ff, $f4, $77, $e0, $1f, $e1, $ff        ;; 21:7370 ????????
    db   $e2, $77, $e2, $17, $24, $14, $e2, $07        ;; 21:7378 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 21:7380 ????????
    db   $e0, $1f, $e1, $ff, $e2, $77, $e2, $50        ;; 21:7388 ????????
    db   $24, $05, $23, $05, $22, $14, $e2, $07        ;; 21:7390 ????????
    db   $49, $1e, $ff, $04, $f5, $ff, $f4, $77        ;; 21:7398 ????????
    db   $f0, $13, $f1, $57, $f2, $27, $f1, $57        ;; 21:73a0 ????????
    db   $f2, $27, $19, $78, $ff, $01, $f5, $ff        ;; 21:73a8 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:73b0 ????????
    db   $00, $0c, $ff, $01, $f5, $ff, $f4, $77        ;; 21:73b8 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 21:73c0 ????????
    db   $01, $05, $49, $14, $e2, $07, $49, $1e        ;; 21:73c8 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:73d0 ????????
    db   $e1, $ff, $e2, $77, $e2, $b7, $31, $03        ;; 21:73d8 ????????
    db   $3d, $01, $49, $2d, $00, $78, $ff, $02        ;; 21:73e0 ????????
    db   $e6, $ff, $e7, $77, $e7, $57, $00, $78        ;; 21:73e8 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:73f0 ????????
    db   $e1, $ff, $e2, $77, $e2, $57, $01, $05        ;; 21:73f8 ????????
    db   $49, $14, $e2, $07, $49, $1e, $ff, $01        ;; 21:7400 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:7408 ????????
    db   $e2, $77, $e2, $17, $25, $01, $e2, $27        ;; 21:7410 ????????
    db   $24, $01, $e2, $37, $25, $01, $e2, $47        ;; 21:7418 ????????
    db   $24, $01, $e2, $57, $25, $01, $e2, $67        ;; 21:7420 ????????
    db   $24, $01, $e2, $57, $25, $01, $e2, $37        ;; 21:7428 ????????
    db   $24, $01, $e2, $27, $25, $01, $e2, $17        ;; 21:7430 ????????
    db   $24, $01, $ff, $01, $f5, $ff, $f4, $77        ;; 21:7438 ????????
    db   $e0, $7f, $e1, $ff, $e2, $77, $31, $01        ;; 21:7440 ????????
    db   $49, $3c, $ff, $04, $f5, $ff, $f4, $77        ;; 21:7448 ????????
    db   $f0, $13, $f1, $57, $f2, $27, $f3, $80        ;; 21:7450 ????????
    db   $f1, $5f, $f2, $27, $19, $78, $f2, $2f        ;; 21:7458 ????????
    db   $3d, $78, $f2, $77, $19, $78, $f2, $7f        ;; 21:7460 ????????
    db   $3d, $78, $f1, $57, $f2, $27, $19, $78        ;; 21:7468 ????????
    db   $f2, $2f, $19, $78, $f2, $77, $19, $78        ;; 21:7470 ????????
    db   $f2, $7f, $19, $78, $f1, $57, $f2, $27        ;; 21:7478 ????????
    db   $19, $78, $f2, $2f, $19, $78, $f2, $77        ;; 21:7480 ????????
    db   $19, $78, $f2, $7f, $19, $78, $ff, $01        ;; 21:7488 ????????
    db   $f5, $ff, $f4, $77, $e0, $7f, $e1, $ff        ;; 21:7490 ????????
    db   $e2, $77, $31, $01, $49, $3c, $ff, $01        ;; 21:7498 ????????
    db   $f5, $ff, $f4, $77, $e0, $7f, $e1, $ff        ;; 21:74a0 ????????
    db   $e2, $77, $e2, $27, $19, $02, $e2, $2f        ;; 21:74a8 ????????
    db   $3d, $02, $e2, $77, $19, $02, $e2, $7f        ;; 21:74b0 ????????
    db   $3d, $02, $e2, $27, $19, $02, $e2, $2f        ;; 21:74b8 ????????
    db   $19, $02, $e2, $77, $19, $02, $e2, $7f        ;; 21:74c0 ????????
    db   $19, $02, $e2, $27, $19, $02, $e2, $2f        ;; 21:74c8 ????????
    db   $19, $02, $e2, $77, $19, $02, $e2, $7f        ;; 21:74d0 ????????
    db   $19, $02, $ff, $01, $f5, $ff, $f4, $77        ;; 21:74d8 ????????
    db   $e0, $4d, $e1, $ff, $e2, $77, $31, $01        ;; 21:74e0 ????????
    db   $49, $3c, $ff, $01, $f5, $ff, $f4, $77        ;; 21:74e8 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $00, $78        ;; 21:74f0 ????????
    db   $e2, $77, $49, $03, $31, $0a, $49, $32        ;; 21:74f8 ????????
    db   $e2, $07, $ff, $02, $e6, $ff, $e7, $77        ;; 21:7500 ????????
    db   $00, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 21:7508 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 21:7510 ????????
    db   $10, $05, $0f, $01, $11, $01, $12, $01        ;; 21:7518 ????????
    db   $13, $01, $14, $01, $15, $01, $16, $01        ;; 21:7520 ????????
    db   $17, $01, $18, $01, $19, $01, $e2, $07        ;; 21:7528 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 21:7530 ????????
    db   $e0, $77, $e1, $ff, $e2, $77, $2a, $06        ;; 21:7538 ????????
    db   $2e, $06, $31, $0b, $ff, $02, $e6, $ff        ;; 21:7540 ????????
    db   $e7, $77, $00, $78, $ff, $01, $f5, $ff        ;; 21:7548 ????????
    db   $f4, $77, $e0, $77, $e1, $ff, $e2, $77        ;; 21:7550 ????????
    db   $31, $01, $49, $3c, $ff, $01, $f5, $ff        ;; 21:7558 ????????
    db   $f4, $77, $e0, $7f, $e1, $ff, $e2, $77        ;; 21:7560 ????????
    db   $19, $06, $14, $06, $0e, $06, $ff, $01        ;; 21:7568 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:7570 ????????
    db   $e2, $77, $e2, $57, $1d, $07, $19, $07        ;; 21:7578 ????????
    db   $16, $07, $e2, $07, $e2, $47, $1d, $07        ;; 21:7580 ????????
    db   $19, $07, $16, $07, $e2, $07, $e2, $37        ;; 21:7588 ????????
    db   $1d, $07, $19, $07, $16, $07, $e2, $07        ;; 21:7590 ????????
    db   $e2, $27, $1d, $07, $19, $07, $16, $07        ;; 21:7598 ????????
    db   $e2, $07, $e2, $17, $1d, $07, $19, $07        ;; 21:75a0 ????????
    db   $16, $07, $e2, $07, $49, $1e, $ff, $01        ;; 21:75a8 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:75b0 ????????
    db   $e2, $77, $e2, $57, $10, $05, $0f, $01        ;; 21:75b8 ????????
    db   $11, $01, $12, $01, $13, $01, $14, $01        ;; 21:75c0 ????????
    db   $15, $01, $16, $01, $17, $01, $18, $01        ;; 21:75c8 ????????
    db   $19, $01, $e2, $07, $49, $1e, $ff, $01        ;; 21:75d0 ????????
    db   $f5, $ff, $f4, $77, $e0, $77, $e1, $ff        ;; 21:75d8 ????????
    db   $e2, $77, $19, $0f, $26, $0f, $33, $2d        ;; 21:75e0 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:75e8 ????????
    db   $e1, $ff, $e2, $77, $08, $02, $05, $02        ;; 21:75f0 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:75f8 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:7600 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:7608 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:7610 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:7618 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:7620 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 21:7628 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:7630 ????????
    db   $e1, $ff, $e2, $77, $0d, $02, $0a, $02        ;; 21:7638 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:7640 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:7648 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:7650 ????????
    db   $0d, $02, $0a, $02, $ff, $01, $f5, $ff        ;; 21:7658 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:7660 ????????
    db   $e2, $57, $01, $05, $49, $14, $e2, $07        ;; 21:7668 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 21:7670 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $b7        ;; 21:7678 ????????
    db   $01, $03, $19, $01, $49, $2d, $00, $78        ;; 21:7680 ????????
    db   $ff, $04, $f0, $87, $f1, $e1, $f2, $eb        ;; 21:7688 ????????
    db   $00, $78, $49, $1e, $ff, $01, $f5, $ff        ;; 21:7690 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:7698 ????????
    db   $e2, $17, $25, $01, $e2, $27, $24, $01        ;; 21:76a0 ????????
    db   $e2, $37, $25, $01, $e2, $47, $24, $01        ;; 21:76a8 ????????
    db   $e2, $57, $25, $01, $e2, $67, $24, $01        ;; 21:76b0 ????????
    db   $e2, $57, $25, $01, $e2, $37, $24, $01        ;; 21:76b8 ????????
    db   $e2, $27, $25, $01, $e2, $17, $24, $01        ;; 21:76c0 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $17        ;; 21:76c8 ????????
    db   $e1, $ff, $e2, $77, $e2, $57, $25, $01        ;; 21:76d0 ????????
    db   $28, $01, $27, $01, $29, $01, $2a, $01        ;; 21:76d8 ????????
    db   $2b, $01, $2c, $01, $2d, $01, $2e, $01        ;; 21:76e0 ????????
    db   $2f, $01, $30, $01, $31, $01, $e2, $07        ;; 21:76e8 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 21:76f0 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $97        ;; 21:76f8 ????????
    db   $0d, $01, $e2, $87, $0c, $01, $e2, $77        ;; 21:7700 ????????
    db   $0d, $01, $e2, $67, $0c, $01, $e2, $57        ;; 21:7708 ????????
    db   $0d, $01, $e2, $47, $0c, $01, $e2, $37        ;; 21:7710 ????????
    db   $0d, $01, $e2, $27, $0c, $01, $e2, $17        ;; 21:7718 ????????
    db   $0d, $01, $e2, $07, $0c, $01, $ff, $04        ;; 21:7720 ????????
    db   $f5, $ff, $f4, $77, $f0, $13, $f1, $57        ;; 21:7728 ????????
    db   $f2, $27, $f2, $27, $f1, $1b, $19, $0a        ;; 21:7730 ????????
    db   $f1, $37, $19, $1e, $49, $78, $ff, $01        ;; 21:7738 ????????
    db   $f5, $ff, $f4, $77, $e0, $3b, $e1, $ff        ;; 21:7740 ????????
    db   $e2, $77, $e2, $57, $31, $04, $30, $04        ;; 21:7748 ????????
    db   $2f, $04, $2e, $04, $e2, $37, $30, $04        ;; 21:7750 ????????
    db   $2f, $04, $2e, $04, $2d, $04, $e2, $17        ;; 21:7758 ????????
    db   $2f, $04, $2e, $04, $2d, $04, $49, $14        ;; 21:7760 ????????
    db   $e2, $07, $49, $78, $ff, $01, $f5, $ff        ;; 21:7768 ????????
    db   $f4, $77, $e0, $7f, $e1, $ff, $e2, $77        ;; 21:7770 ????????
    db   $19, $01, $49, $3c, $ff, $01, $f5, $ff        ;; 21:7778 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 21:7780 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:7788 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:7790 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:7798 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 21:77a0 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $7f        ;; 21:77a8 ????????
    db   $e1, $ff, $e2, $77, $31, $01, $49, $3c        ;; 21:77b0 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $7f        ;; 21:77b8 ????????
    db   $e1, $ff, $e2, $77, $e2, $f7, $01, $0a        ;; 21:77c0 ????????
    db   $0d, $01, $e2, $f7, $0c, $01, $e2, $f7        ;; 21:77c8 ????????
    db   $0d, $01, $e2, $f7, $0c, $01, $e2, $e7        ;; 21:77d0 ????????
    db   $0d, $01, $e2, $d7, $0c, $01, $e2, $c7        ;; 21:77d8 ????????
    db   $0d, $01, $e2, $b7, $0c, $01, $e2, $97        ;; 21:77e0 ????????
    db   $0d, $01, $e2, $87, $0c, $01, $e2, $77        ;; 21:77e8 ????????
    db   $0d, $01, $e2, $67, $0c, $01, $e2, $57        ;; 21:77f0 ????????
    db   $0d, $01, $e2, $47, $0c, $01, $e2, $37        ;; 21:77f8 ????????
    db   $0d, $01, $e2, $27, $0c, $01, $e2, $17        ;; 21:7800 ????????
    db   $0d, $01, $e2, $07, $0c, $01, $49, $2d        ;; 21:7808 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 21:7810 ????????
    db   $e1, $ff, $e2, $77, $e2, $57, $01, $05        ;; 21:7818 ????????
    db   $49, $14, $e2, $07, $49, $1e, $ff, $01        ;; 21:7820 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 21:7828 ????????
    db   $e2, $77, $e2, $13, $25, $0a, $3d, $32        ;; 21:7830 ????????
    db   $e2, $07, $49, $1e, $ff, $01, $00, $0a        ;; 21:7838 ????????
    db   $ff, $02, $00, $0a, $ff, $03, $00, $0a        ;; 21:7840 ????????
    db   $ff, $04, $00, $0a, $ff                       ;; 21:7848 ?????
