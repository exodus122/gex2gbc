;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; Note: All of the code in this file is identical in banks 0x21, 0x22, 0x23, and 0x24. This is a duplicated 
; audio engine. The data that follows the code is different and contains different songs or sound effects.

SECTION "bank22", ROMX[$4000], BANK[$22]
entry_22_4000:
    ld   HL, data_22_4460                              ;; 22:4000 $21 $60 $44
    ld   A, L                                          ;; 22:4003 $7d
    ld   [wDFAE], A                                    ;; 22:4004 $ea $ae $df
    ld   A, H                                          ;; 22:4007 $7c
    ld   [wDFAF], A                                    ;; 22:4008 $ea $af $df
    xor  A, A                                          ;; 22:400b $af
    ld   [wDFC2], A                                    ;; 22:400c $ea $c2 $df
    ld   [wDFC1], A                                    ;; 22:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 22:4012 $e0 $25
    ld   [wDFB8], A                                    ;; 22:4014 $ea $b8 $df
    ld   [wDFB9], A                                    ;; 22:4017 $ea $b9 $df
    ld   [wDFBA], A                                    ;; 22:401a $ea $ba $df
    ld   [wDFBB], A                                    ;; 22:401d $ea $bb $df
    ld   [wDFBC], A                                    ;; 22:4020 $ea $bc $df
    ld   [wDFCF], A                                    ;; 22:4023 $ea $cf $df
    ld   [wDFCB], A                                    ;; 22:4026 $ea $cb $df
    ld   [wDFCC], A                                    ;; 22:4029 $ea $cc $df
    ld   [wDFCD], A                                    ;; 22:402c $ea $cd $df
    ld   [wDFCE], A                                    ;; 22:402f $ea $ce $df
    ld   HL, wDFD2                                     ;; 22:4032 $21 $d2 $df
    ld   C, $14                                        ;; 22:4035 $0e $14
    xor  A, A                                          ;; 22:4037 $af
jr_22_4038:
    ld   [HL+], A                                      ;; 22:4038 $22
    dec  C                                             ;; 22:4039 $0d
    jr   NZ, jr_22_4038                                ;; 22:403a $20 $fc
    ld   HL, wDFE6                                     ;; 22:403c $21 $e6 $df
    ld   C, $10                                        ;; 22:403f $0e $10
    xor  A, A                                          ;; 22:4041 $af
.jr_22_4042:
    ld   [HL+], A                                      ;; 22:4042 $22
    dec  C                                             ;; 22:4043 $0d
    jr   NZ, .jr_22_4042                               ;; 22:4044 $20 $fc
    ret                                                ;; 22:4046 $c9

call_22_4047:
    ld   [wDFD0], A                                    ;; 22:4047 $ea $d0 $df
    ld   A, $01                                        ;; 22:404a $3e $01
    ld   [wDFD1], A                                    ;; 22:404c $ea $d1 $df
    ld   A, [wDFD0]                                    ;; 22:404f $fa $d0 $df
    sla  A                                             ;; 22:4052 $cb $27
    ld   E, A                                          ;; 22:4054 $5f
    sla  A                                             ;; 22:4055 $cb $27
    ld   C, A                                          ;; 22:4057 $4f
    sla  A                                             ;; 22:4058 $cb $27
    add  A, E                                          ;; 22:405a $83
    ld   DE, data_22_439e                              ;; 22:405b $11 $9e $43
    add  A, E                                          ;; 22:405e $83
    ld   E, A                                          ;; 22:405f $5f
    jr   NC, .jr_22_4063                               ;; 22:4060 $30 $01
    inc  D                                             ;; 22:4062 $14
.jr_22_4063:
    ld   HL, wDFD2                                     ;; 22:4063 $21 $d2 $df
    ld   A, [wDFD0]                                    ;; 22:4066 $fa $d0 $df
    add  A, C                                          ;; 22:4069 $81
    add  A, L                                          ;; 22:406a $85
    ld   L, A                                          ;; 22:406b $6f
    jr   NC, .jr_22_406f                               ;; 22:406c $30 $01
    inc  H                                             ;; 22:406e $24
.jr_22_406f:
    ld   B, $ff                                        ;; 22:406f $06 $ff
.jr_22_4071:
    ld   A, [DE]                                       ;; 22:4071 $1a
    and  A, A                                          ;; 22:4072 $a7
    jr   Z, .jr_22_407f                                ;; 22:4073 $28 $0a
    inc  DE                                            ;; 22:4075 $13
    ld   C, A                                          ;; 22:4076 $4f
    ld   A, [BC]                                       ;; 22:4077 $0a
    ld   C, A                                          ;; 22:4078 $4f
    ld   A, [DE]                                       ;; 22:4079 $1a
    inc  DE                                            ;; 22:407a $13
    and  A, C                                          ;; 22:407b $a1
    ld   [HL+], A                                      ;; 22:407c $22
    jr   .jr_22_4071                                   ;; 22:407d $18 $f2
.jr_22_407f:
    ld   A, [wDFAE]                                    ;; 22:407f $fa $ae $df
    ld   E, A                                          ;; 22:4082 $5f
    ld   A, [wDFAF]                                    ;; 22:4083 $fa $af $df
    ld   D, A                                          ;; 22:4086 $57
    ld   A, [DE]                                       ;; 22:4087 $1a
    add  A, E                                          ;; 22:4088 $83
    ld   L, A                                          ;; 22:4089 $6f
    inc  DE                                            ;; 22:408a $13
    ld   A, [DE]                                       ;; 22:408b $1a
    dec  DE                                            ;; 22:408c $1b
    adc  A, D                                          ;; 22:408d $8a
    ld   D, A                                          ;; 22:408e $57
    ld   E, L                                          ;; 22:408f $5d
    jr   jr_22_40a4                                    ;; 22:4090 $18 $12

call_22_4092:
    ld   [wDFD0], A                                    ;; 22:4092 $ea $d0 $df
    ld   A, $02                                        ;; 22:4095 $3e $02
    ld   [wDFD1], A                                    ;; 22:4097 $ea $d1 $df
    ld   A, [wDFAE]                                    ;; 22:409a $fa $ae $df
    ld   E, A                                          ;; 22:409d $5f
    ld   A, [wDFAF]                                    ;; 22:409e $fa $af $df
    ld   D, A                                          ;; 22:40a1 $57
    inc  DE                                            ;; 22:40a2 $13
    inc  DE                                            ;; 22:40a3 $13

jr_22_40a4:
    ld   A, [wDFD0]                                    ;; 22:40a4 $fa $d0 $df
    add  A, A                                          ;; 22:40a7 $87
    ld   L, A                                          ;; 22:40a8 $6f
    ld   A, D                                          ;; 22:40a9 $7a
    adc  A, $00                                        ;; 22:40aa $ce $00
    ld   D, A                                          ;; 22:40ac $57
    ld   A, E                                          ;; 22:40ad $7b
    add  A, L                                          ;; 22:40ae $85
    ld   E, A                                          ;; 22:40af $5f
    ld   A, D                                          ;; 22:40b0 $7a
    adc  A, $00                                        ;; 22:40b1 $ce $00
    ld   D, A                                          ;; 22:40b3 $57
    ld   A, [DE]                                       ;; 22:40b4 $1a
    add  A, E                                          ;; 22:40b5 $83
    ld   L, A                                          ;; 22:40b6 $6f
    inc  DE                                            ;; 22:40b7 $13
    ld   A, [DE]                                       ;; 22:40b8 $1a
    dec  DE                                            ;; 22:40b9 $1b
    adc  A, D                                          ;; 22:40ba $8a
    ld   D, A                                          ;; 22:40bb $57
    ld   E, L                                          ;; 22:40bc $5d
    ld   A, [DE]                                       ;; 22:40bd $1a
    ld   [wDFFE], A                                    ;; 22:40be $ea $fe $df
    ld   L, A                                          ;; 22:40c1 $6f
    xor  A, A                                          ;; 22:40c2 $af
    scf                                                ;; 22:40c3 $37
.jr_22_40c4:
    rl   A                                             ;; 22:40c4 $cb $17
    dec  L                                             ;; 22:40c6 $2d
    jr   NZ, .jr_22_40c4                               ;; 22:40c7 $20 $fb
    ld   [wDFC1], A                                    ;; 22:40c9 $ea $c1 $df
    ld   L, A                                          ;; 22:40cc $6f
    ld   A, [wDFD1]                                    ;; 22:40cd $fa $d1 $df
    cp   A, $01                                        ;; 22:40d0 $fe $01
    jr   NZ, .jr_22_40e3                               ;; 22:40d2 $20 $0f
    ld   A, [wDFCF]                                    ;; 22:40d4 $fa $cf $df
    or   A, L                                          ;; 22:40d7 $b5
    ld   [wDFCF], A                                    ;; 22:40d8 $ea $cf $df
    ld   HL, wDFC3                                     ;; 22:40db $21 $c3 $df
    ld   BC, wDFCB                                     ;; 22:40de $01 $cb $df
    jr   .jr_22_40f0                                   ;; 22:40e1 $18 $0d
.jr_22_40e3:
    ld   A, [wDFC2]                                    ;; 22:40e3 $fa $c2 $df
    or   A, L                                          ;; 22:40e6 $b5
    ld   [wDFC2], A                                    ;; 22:40e7 $ea $c2 $df
    ld   HL, wDFB0                                     ;; 22:40ea $21 $b0 $df
    ld   BC, wDFB9                                     ;; 22:40ed $01 $b9 $df
.jr_22_40f0:
    ld   A, [DE]                                       ;; 22:40f0 $1a
    dec  A                                             ;; 22:40f1 $3d
    sla  A                                             ;; 22:40f2 $cb $27
    add  A, L                                          ;; 22:40f4 $85
    ld   L, A                                          ;; 22:40f5 $6f
    jr   NC, .jr_22_40f9                               ;; 22:40f6 $30 $01
    inc  H                                             ;; 22:40f8 $24
.jr_22_40f9:
    ld   A, [DE]                                       ;; 22:40f9 $1a
    dec  A                                             ;; 22:40fa $3d
    add  A, C                                          ;; 22:40fb $81
    ld   C, A                                          ;; 22:40fc $4f
    jr   NC, .jr_22_4100                               ;; 22:40fd $30 $01
    inc  B                                             ;; 22:40ff $04
.jr_22_4100:
    inc  DE                                            ;; 22:4100 $13
    ld   [HL], E                                       ;; 22:4101 $73
    inc  HL                                            ;; 22:4102 $23
    ld   [HL], D                                       ;; 22:4103 $72
    dec  HL                                            ;; 22:4104 $2b
    push BC                                            ;; 22:4105 $c5
    call call_22_4199                                  ;; 22:4106 $cd $99 $41
    pop  BC                                            ;; 22:4109 $c1
    ld   [BC], A                                       ;; 22:410a $02
    ret                                                ;; 22:410b $c9

call_22_410c:
    ld   BC, wDFB9                                     ;; 22:410c $01 $b9 $df
    ld   HL, wDFB0                                     ;; 22:410f $21 $b0 $df
    ld   A, $01                                        ;; 22:4112 $3e $01
    ld   [wDFC1], A                                    ;; 22:4114 $ea $c1 $df
    ld   A, $00                                        ;; 22:4117 $3e $00
    ld   [wDFB8], A                                    ;; 22:4119 $ea $b8 $df
    ld   A, $02                                        ;; 22:411c $3e $02
    ld   [wDFD1], A                                    ;; 22:411e $ea $d1 $df
.jp_22_4121:
    push BC                                            ;; 22:4121 $c5
    ld   A, [wDFC1]                                    ;; 22:4122 $fa $c1 $df
    ld   D, A                                          ;; 22:4125 $57
    ld   A, [wDFC2]                                    ;; 22:4126 $fa $c2 $df
    and  A, D                                          ;; 22:4129 $a2
    jr   Z, .jr_22_4139                                ;; 22:412a $28 $0d
    ld   A, [BC]                                       ;; 22:412c $0a
    dec  A                                             ;; 22:412d $3d
    jr   NZ, .jr_22_4139                               ;; 22:412e $20 $09
    ld   A, [wDFB8]                                    ;; 22:4130 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 22:4133 $ea $fe $df
    call call_22_4199                                  ;; 22:4136 $cd $99 $41
.jr_22_4139:
    pop  BC                                            ;; 22:4139 $c1
    ld   [BC], A                                       ;; 22:413a $02
    inc  BC                                            ;; 22:413b $03
    inc  HL                                            ;; 22:413c $23
    inc  HL                                            ;; 22:413d $23
    ld   A, [wDFC1]                                    ;; 22:413e $fa $c1 $df
    sla  A                                             ;; 22:4141 $cb $27
    ld   [wDFC1], A                                    ;; 22:4143 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 22:4146 $fa $b8 $df
    inc  A                                             ;; 22:4149 $3c
    ld   [wDFB8], A                                    ;; 22:414a $ea $b8 $df
    cp   A, $04                                        ;; 22:414d $fe $04
    jp   NZ, .jp_22_4121                               ;; 22:414f $c2 $21 $41
    ld   BC, wDFCB                                     ;; 22:4152 $01 $cb $df
    ld   HL, wDFC3                                     ;; 22:4155 $21 $c3 $df
    ld   A, $01                                        ;; 22:4158 $3e $01
    ld   [wDFC1], A                                    ;; 22:415a $ea $c1 $df
    ld   A, $00                                        ;; 22:415d $3e $00
    ld   [wDFB8], A                                    ;; 22:415f $ea $b8 $df
    ld   A, $01                                        ;; 22:4162 $3e $01
    ld   [wDFD1], A                                    ;; 22:4164 $ea $d1 $df
.jp_22_4167:
    push BC                                            ;; 22:4167 $c5
    ld   A, [wDFC1]                                    ;; 22:4168 $fa $c1 $df
    ld   D, A                                          ;; 22:416b $57
    ld   A, [wDFCF]                                    ;; 22:416c $fa $cf $df
    and  A, D                                          ;; 22:416f $a2
    jr   Z, .jr_22_417f                                ;; 22:4170 $28 $0d
    ld   A, [BC]                                       ;; 22:4172 $0a
    dec  A                                             ;; 22:4173 $3d
    jr   NZ, .jr_22_417f                               ;; 22:4174 $20 $09
    ld   A, [wDFB8]                                    ;; 22:4176 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 22:4179 $ea $fe $df
    call call_22_4199                                  ;; 22:417c $cd $99 $41
.jr_22_417f:
    pop  BC                                            ;; 22:417f $c1
    ld   [BC], A                                       ;; 22:4180 $02
    inc  BC                                            ;; 22:4181 $03
    inc  HL                                            ;; 22:4182 $23
    inc  HL                                            ;; 22:4183 $23
    ld   A, [wDFC1]                                    ;; 22:4184 $fa $c1 $df
    sla  A                                             ;; 22:4187 $cb $27
    ld   [wDFC1], A                                    ;; 22:4189 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 22:418c $fa $b8 $df
    inc  A                                             ;; 22:418f $3c
    ld   [wDFB8], A                                    ;; 22:4190 $ea $b8 $df
    cp   A, $04                                        ;; 22:4193 $fe $04
    jp   NZ, .jp_22_4167                               ;; 22:4195 $c2 $67 $41
    ret                                                ;; 22:4198 $c9

call_22_4199:
    ld   C, [HL]                                       ;; 22:4199 $4e
    inc  HL                                            ;; 22:419a $23
    ld   B, [HL]                                       ;; 22:419b $46
.jp_22_419c:
    ld   A, [BC]                                       ;; 22:419c $0a
    cp   A, $fe                                        ;; 22:419d $fe $fe
    jr   NZ, .jr_22_41ae                               ;; 22:419f $20 $0d
    inc  BC                                            ;; 22:41a1 $03
    ld   A, [BC]                                       ;; 22:41a2 $0a
    ld   E, A                                          ;; 22:41a3 $5f
    inc  BC                                            ;; 22:41a4 $03
    ld   A, [BC]                                       ;; 22:41a5 $0a
    ld   D, A                                          ;; 22:41a6 $57
    ld   A, C                                          ;; 22:41a7 $79
    sub  A, E                                          ;; 22:41a8 $93
    ld   C, A                                          ;; 22:41a9 $4f
    ld   A, B                                          ;; 22:41aa $78
    sbc  A, D                                          ;; 22:41ab $9a
    ld   B, A                                          ;; 22:41ac $47
    ld   A, [BC]                                       ;; 22:41ad $0a
.jr_22_41ae:
    inc  BC                                            ;; 22:41ae $03
    cp   A, $ff                                        ;; 22:41af $fe $ff
    jp   NZ, .jp_22_426f                               ;; 22:41b1 $c2 $6f $42
    ld   A, [wDFC1]                                    ;; 22:41b4 $fa $c1 $df
    cpl                                                ;; 22:41b7 $2f
    ld   E, A                                          ;; 22:41b8 $5f
    ld   A, [wDFD1]                                    ;; 22:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 22:41bc $fe $01
    jp   NZ, .jp_22_4253                               ;; 22:41be $c2 $53 $42
    ld   A, [wDFCF]                                    ;; 22:41c1 $fa $cf $df
    and  A, E                                          ;; 22:41c4 $a3
    ld   [wDFCF], A                                    ;; 22:41c5 $ea $cf $df
    ld   A, [wDFC2]                                    ;; 22:41c8 $fa $c2 $df
    ld   E, A                                          ;; 22:41cb $5f
    ld   A, [wDFC1]                                    ;; 22:41cc $fa $c1 $df
    and  A, E                                          ;; 22:41cf $a3
    jp   Z, .jp_22_4265                                ;; 22:41d0 $ca $65 $42
    push HL                                            ;; 22:41d3 $e5
    push BC                                            ;; 22:41d4 $c5
    ld   B, $ff                                        ;; 22:41d5 $06 $ff
    ld   DE, wDFD2                                     ;; 22:41d7 $11 $d2 $df
    ld   A, [wDFFE]                                    ;; 22:41da $fa $fe $df
    sla  A                                             ;; 22:41dd $cb $27
    sla  A                                             ;; 22:41df $cb $27
    add  A, E                                          ;; 22:41e1 $83
    ld   E, A                                          ;; 22:41e2 $5f
    ld   A, [wDFFE]                                    ;; 22:41e3 $fa $fe $df
    add  A, E                                          ;; 22:41e6 $83
    ld   E, A                                          ;; 22:41e7 $5f
    ld   HL, data_22_439e                              ;; 22:41e8 $21 $9e $43
    ld   A, [wDFFE]                                    ;; 22:41eb $fa $fe $df
    sla  A                                             ;; 22:41ee $cb $27
    ld   C, A                                          ;; 22:41f0 $4f
    sla  A                                             ;; 22:41f1 $cb $27
    sla  A                                             ;; 22:41f3 $cb $27
    add  A, C                                          ;; 22:41f5 $81
    add  A, L                                          ;; 22:41f6 $85
    ld   L, A                                          ;; 22:41f7 $6f
    jr   NC, .jr_22_41fb                               ;; 22:41f8 $30 $01
    inc  H                                             ;; 22:41fa $24
.jr_22_41fb:
    ld   A, [HL+]                                      ;; 22:41fb $2a
    and  A, A                                          ;; 22:41fc $a7
    jr   Z, .jr_22_4206                                ;; 22:41fd $28 $07
    ld   C, A                                          ;; 22:41ff $4f
    ld   A, [DE]                                       ;; 22:4200 $1a
    ld   [BC], A                                       ;; 22:4201 $02
    inc  DE                                            ;; 22:4202 $13
    inc  HL                                            ;; 22:4203 $23
    jr   .jr_22_41fb                                   ;; 22:4204 $18 $f5
.jr_22_4206:
    ld   A, [wDFC1]                                    ;; 22:4206 $fa $c1 $df
    cp   A, $04                                        ;; 22:4209 $fe $04
    jr   NZ, .jr_22_421b                               ;; 22:420b $20 $0e
    ld   HL, wDFE6                                     ;; 22:420d $21 $e6 $df
    ld   DE, $ff30                                     ;; 22:4210 $11 $30 $ff
    ld   C, $10                                        ;; 22:4213 $0e $10
.jr_22_4215:
    ld   A, [HL+]                                      ;; 22:4215 $2a
    ld   [DE], A                                       ;; 22:4216 $12
    inc  DE                                            ;; 22:4217 $13
    dec  C                                             ;; 22:4218 $0d
    jr   NZ, .jr_22_4215                               ;; 22:4219 $20 $fa
.jr_22_421b:
    ld   HL, wDFF6                                     ;; 22:421b $21 $f6 $df
    ld   A, [wDFFE]                                    ;; 22:421e $fa $fe $df
    sla  A                                             ;; 22:4221 $cb $27
    add  A, L                                          ;; 22:4223 $85
    ld   L, A                                          ;; 22:4224 $6f
    ld   A, [wDFC1]                                    ;; 22:4225 $fa $c1 $df
    dec  A                                             ;; 22:4228 $3d
    ld   DE, data_22_43c6                              ;; 22:4229 $11 $c6 $43
    add  A, E                                          ;; 22:422c $83
    ld   E, A                                          ;; 22:422d $5f
    jr   NC, .jr_22_4231                               ;; 22:422e $30 $01
    inc  D                                             ;; 22:4230 $14
.jr_22_4231:
    ld   A, [DE]                                       ;; 22:4231 $1a
    ld   E, A                                          ;; 22:4232 $5f
    ld   D, $ff                                        ;; 22:4233 $16 $ff
    ld   A, [wDFC1]                                    ;; 22:4235 $fa $c1 $df
    cp   A, $08                                        ;; 22:4238 $fe $08
    jr   NZ, .jr_22_4244                               ;; 22:423a $20 $08
    inc  HL                                            ;; 22:423c $23
    ld   [DE], A                                       ;; 22:423d $12
    ldh  A, [rNR42]                                    ;; 22:423e $f0 $21
    ldh  [rNR42], A                                    ;; 22:4240 $e0 $21
    jr   .jr_22_424e                                   ;; 22:4242 $18 $0a
.jr_22_4244:
    ld   A, [HL+]                                      ;; 22:4244 $2a
    ld   [DE], A                                       ;; 22:4245 $12
    inc  DE                                            ;; 22:4246 $13
    ld   A, [DE]                                       ;; 22:4247 $1a
    and  A, $c0                                        ;; 22:4248 $e6 $c0
    ld   C, A                                          ;; 22:424a $4f
    ld   A, [HL]                                       ;; 22:424b $7e
    or   A, C                                          ;; 22:424c $b1
    ld   [DE], A                                       ;; 22:424d $12
.jr_22_424e:
    pop  BC                                            ;; 22:424e $c1
    pop  HL                                            ;; 22:424f $e1
    jp   .jp_22_4392                                   ;; 22:4250 $c3 $92 $43
.jp_22_4253:
    ld   A, [wDFC2]                                    ;; 22:4253 $fa $c2 $df
    and  A, E                                          ;; 22:4256 $a3
    ld   [wDFC2], A                                    ;; 22:4257 $ea $c2 $df
    ld   A, [wDFCF]                                    ;; 22:425a $fa $cf $df
    ld   E, A                                          ;; 22:425d $5f
    ld   A, [wDFC1]                                    ;; 22:425e $fa $c1 $df
    and  A, E                                          ;; 22:4261 $a3
    jp   NZ, .jp_22_4392                               ;; 22:4262 $c2 $92 $43
.jp_22_4265:
    ldh  A, [rNR52]                                    ;; 22:4265 $f0 $26
    and  A, $8f                                        ;; 22:4267 $e6 $8f
    and  A, E                                          ;; 22:4269 $a3
    ldh  [rNR52], A                                    ;; 22:426a $e0 $26
    jp   .jp_22_4392                                   ;; 22:426c $c3 $92 $43
.jp_22_426f:
    cp   A, $fd                                        ;; 22:426f $fe $fd
    jr   NZ, .jr_22_4284                               ;; 22:4271 $20 $11
    push HL                                            ;; 22:4273 $e5
    ld   DE, $ff30                                     ;; 22:4274 $11 $30 $ff
    ld   L, $10                                        ;; 22:4277 $2e $10
.jr_22_4279:
    ld   A, [BC]                                       ;; 22:4279 $0a
    inc  BC                                            ;; 22:427a $03
    ld   [DE], A                                       ;; 22:427b $12
    inc  DE                                            ;; 22:427c $13
    dec  L                                             ;; 22:427d $2d
    jr   NZ, .jr_22_4279                               ;; 22:427e $20 $f9
    pop  HL                                            ;; 22:4280 $e1
    jp   .jp_22_419c                                   ;; 22:4281 $c3 $9c $41
.jr_22_4284:
    cp   A, $a0                                        ;; 22:4284 $fe $a0
    jr   C, .jr_22_42bb                                ;; 22:4286 $38 $33
    cp   A, $c0                                        ;; 22:4288 $fe $c0
    jr   NC, .jr_22_429c                               ;; 22:428a $30 $10
    sub  A, $90                                        ;; 22:428c $d6 $90
    ld   E, A                                          ;; 22:428e $5f
    ld   D, $ff                                        ;; 22:428f $16 $ff
    ld   A, [DE]                                       ;; 22:4291 $1a
    ld   D, A                                          ;; 22:4292 $57
    ld   A, [BC]                                       ;; 22:4293 $0a
    and  A, D                                          ;; 22:4294 $a2
    ld   D, $ff                                        ;; 22:4295 $16 $ff
    ld   [DE], A                                       ;; 22:4297 $12
    inc  BC                                            ;; 22:4298 $03
    jp   .jp_22_419c                                   ;; 22:4299 $c3 $9c $41
.jr_22_429c:
    cp   A, $e0                                        ;; 22:429c $fe $e0
    jr   NC, .jr_22_42b0                               ;; 22:429e $30 $10
    sub  A, $b0                                        ;; 22:42a0 $d6 $b0
    ld   E, A                                          ;; 22:42a2 $5f
    ld   D, $ff                                        ;; 22:42a3 $16 $ff
    ld   A, [DE]                                       ;; 22:42a5 $1a
    ld   D, A                                          ;; 22:42a6 $57
    ld   A, [BC]                                       ;; 22:42a7 $0a
    or   A, D                                          ;; 22:42a8 $b2
    ld   D, $ff                                        ;; 22:42a9 $16 $ff
    ld   [DE], A                                       ;; 22:42ab $12
    inc  BC                                            ;; 22:42ac $03
    jp   .jp_22_419c                                   ;; 22:42ad $c3 $9c $41
.jr_22_42b0:
    sub  A, $d0                                        ;; 22:42b0 $d6 $d0
    ld   E, A                                          ;; 22:42b2 $5f
    ld   D, $ff                                        ;; 22:42b3 $16 $ff
    ld   A, [BC]                                       ;; 22:42b5 $0a
    inc  BC                                            ;; 22:42b6 $03
    ld   [DE], A                                       ;; 22:42b7 $12
    jp   .jp_22_419c                                   ;; 22:42b8 $c3 $9c $41
.jr_22_42bb:
    cp   A, $49                                        ;; 22:42bb $fe $49
    jp   Z, .jp_22_4369                                ;; 22:42bd $ca $69 $43
    sla  A                                             ;; 22:42c0 $cb $27
    ld   [wDFBF], A                                    ;; 22:42c2 $ea $bf $df
    ld   A, [wDFC1]                                    ;; 22:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 22:42c8 $d6 $01
    ld   [wDFC0], A                                    ;; 22:42ca $ea $c0 $df
    ld   A, [wDFBF]                                    ;; 22:42cd $fa $bf $df
    and  A, A                                          ;; 22:42d0 $a7
    jr   NZ, .jr_22_42ff                               ;; 22:42d1 $20 $2c
    ld   A, [wDFD1]                                    ;; 22:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 22:42d6 $fe $01
    jr   Z, .jr_22_42e4                                ;; 22:42d8 $28 $0a
    ld   A, [wDFCF]                                    ;; 22:42da $fa $cf $df
    ld   E, A                                          ;; 22:42dd $5f
    ld   A, [wDFC1]                                    ;; 22:42de $fa $c1 $df
    and  A, E                                          ;; 22:42e1 $a3
    jr   NZ, .jr_22_42ff                               ;; 22:42e2 $20 $1b
.jr_22_42e4:
    ld   A, [wDFC1]                                    ;; 22:42e4 $fa $c1 $df
    cpl                                                ;; 22:42e7 $2f
    ld   E, A                                          ;; 22:42e8 $5f
    ldh  A, [rNR52]                                    ;; 22:42e9 $f0 $26
    and  A, $8f                                        ;; 22:42eb $e6 $8f
    and  A, E                                          ;; 22:42ed $a3
    ldh  [rNR52], A                                    ;; 22:42ee $e0 $26
    ld   A, [wDFC1]                                    ;; 22:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 22:42f3 $fe $04
    jr   NZ, .jr_22_42fa                               ;; 22:42f5 $20 $03
    xor  A, A                                          ;; 22:42f7 $af
    ldh  [rNR30], A                                    ;; 22:42f8 $e0 $1a
.jr_22_42fa:
    ld   A, [BC]                                       ;; 22:42fa $0a
    inc  BC                                            ;; 22:42fb $03
    jp   .jp_22_4392                                   ;; 22:42fc $c3 $92 $43
.jr_22_42ff:
    ld   DE, data_22_43ce                              ;; 22:42ff $11 $ce $43
    add  A, E                                          ;; 22:4302 $83
    ld   E, A                                          ;; 22:4303 $5f
    jr   NC, .jr_22_4307                               ;; 22:4304 $30 $01
    inc  D                                             ;; 22:4306 $14
.jr_22_4307:
    ld   A, [DE]                                       ;; 22:4307 $1a
    ld   [wDFBD], A                                    ;; 22:4308 $ea $bd $df
    inc  DE                                            ;; 22:430b $13
    ld   A, [DE]                                       ;; 22:430c $1a
    ld   [wDFBE], A                                    ;; 22:430d $ea $be $df
    ld   DE, wDFF6                                     ;; 22:4310 $11 $f6 $df
    ld   A, [wDFFE]                                    ;; 22:4313 $fa $fe $df
    sla  A                                             ;; 22:4316 $cb $27
    add  A, E                                          ;; 22:4318 $83
    ld   E, A                                          ;; 22:4319 $5f
    ld   A, [wDFBD]                                    ;; 22:431a $fa $bd $df
    ld   [DE], A                                       ;; 22:431d $12
    ld   A, [wDFBE]                                    ;; 22:431e $fa $be $df
    or   A, $80                                        ;; 22:4321 $f6 $80
    ld   [DE], A                                       ;; 22:4323 $12
    ld   A, [wDFD1]                                    ;; 22:4324 $fa $d1 $df
    cp   A, $01                                        ;; 22:4327 $fe $01
    jr   Z, .jr_22_4335                                ;; 22:4329 $28 $0a
    ld   A, [wDFCF]                                    ;; 22:432b $fa $cf $df
    ld   E, A                                          ;; 22:432e $5f
    ld   A, [wDFC1]                                    ;; 22:432f $fa $c1 $df
    and  A, E                                          ;; 22:4332 $a3
    jr   NZ, .jr_22_4390                               ;; 22:4333 $20 $5b
.jr_22_4335:
    ld   A, [wDFC0]                                    ;; 22:4335 $fa $c0 $df
    ld   DE, data_22_43c6                              ;; 22:4338 $11 $c6 $43
    add  A, E                                          ;; 22:433b $83
    ld   E, A                                          ;; 22:433c $5f
    jr   NC, .jr_22_4340                               ;; 22:433d $30 $01
    inc  D                                             ;; 22:433f $14
.jr_22_4340:
    ld   A, [DE]                                       ;; 22:4340 $1a
    ld   E, A                                          ;; 22:4341 $5f
    ld   D, $ff                                        ;; 22:4342 $16 $ff
    ld   A, [wDFC1]                                    ;; 22:4344 $fa $c1 $df
    cp   A, $08                                        ;; 22:4347 $fe $08
    jr   NZ, .jr_22_4357                               ;; 22:4349 $20 $0c
    ld   A, [wDFBE]                                    ;; 22:434b $fa $be $df
    or   A, $80                                        ;; 22:434e $f6 $80
    ld   [DE], A                                       ;; 22:4350 $12
    ldh  A, [rNR42]                                    ;; 22:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 22:4353 $e0 $21
    jr   .jp_22_4369                                   ;; 22:4355 $18 $12
.jr_22_4357:
    ld   A, [wDFBD]                                    ;; 22:4357 $fa $bd $df
    ld   [DE], A                                       ;; 22:435a $12
    inc  DE                                            ;; 22:435b $13
    push DE                                            ;; 22:435c $d5
    ld   A, [DE]                                       ;; 22:435d $1a
    and  A, $c0                                        ;; 22:435e $e6 $c0
    ld   D, A                                          ;; 22:4360 $57
    ld   A, [wDFBE]                                    ;; 22:4361 $fa $be $df
    or   A, $80                                        ;; 22:4364 $f6 $80
    or   A, D                                          ;; 22:4366 $b2
    pop  DE                                            ;; 22:4367 $d1
    ld   [DE], A                                       ;; 22:4368 $12
.jp_22_4369:
    ld   A, [wDFD1]                                    ;; 22:4369 $fa $d1 $df
    cp   A, $02                                        ;; 22:436c $fe $02
    jr   NZ, .jr_22_4376                               ;; 22:436e $20 $06
    ld   A, [wDFCF]                                    ;; 22:4370 $fa $cf $df
    and  A, E                                          ;; 22:4373 $a3
    jr   NZ, .jr_22_4390                               ;; 22:4374 $20 $1a
.jr_22_4376:
    ld   A, [wDFC1]                                    ;; 22:4376 $fa $c1 $df
    ld   E, A                                          ;; 22:4379 $5f
    ldh  A, [rNR52]                                    ;; 22:437a $f0 $26
    and  A, $8f                                        ;; 22:437c $e6 $8f
    or   A, E                                          ;; 22:437e $b3
    ldh  [rNR52], A                                    ;; 22:437f $e0 $26
    ld   A, [wDFC1]                                    ;; 22:4381 $fa $c1 $df
    cp   A, $04                                        ;; 22:4384 $fe $04
    jr   NZ, .jr_22_4390                               ;; 22:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 22:4388 $f0 $1a
    and  A, $80                                        ;; 22:438a $e6 $80
    or   A, $80                                        ;; 22:438c $f6 $80
    ldh  [rNR30], A                                    ;; 22:438e $e0 $1a
.jr_22_4390:
    ld   A, [BC]                                       ;; 22:4390 $0a
    inc  BC                                            ;; 22:4391 $03
.jp_22_4392:
    ld   [HL], B                                       ;; 22:4392 $70
    dec  HL                                            ;; 22:4393 $2b
    ld   [HL], C                                       ;; 22:4394 $71
    ret                                                ;; 22:4395 $c9

    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 22:4396 ????????

data_22_439e:
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 22:439e p.p.p.p.
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 22:43a6 .???????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 22:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 22:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 22:43be ????????

data_22_43c6:
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 22:43c6 pp?p???p

data_22_43ce:
    db   $00, $00, $2c, $00, $9c, $00, $06, $01        ;; 22:43ce ?.......
    db   $6b, $01, $c9, $01, $23, $02, $77, $02        ;; 22:43d6 ....p.p.
    db   $c6, $02, $12, $03, $56, $03, $9b, $03        ;; 22:43de p.p.p.p.
    db   $da, $03, $16, $04, $4e, $04, $83, $04        ;; 22:43e6 p.p.p.p.
    db   $b5, $04, $e5, $04, $11, $05, $3b, $05        ;; 22:43ee p.p.p.p.
    db   $63, $05, $89, $05, $ac, $05, $ce, $05        ;; 22:43f6 p.p.p.p.
    db   $ed, $05, $0a, $06, $27, $06, $42, $06        ;; 22:43fe p.p.p.p.
    db   $5b, $06, $72, $06, $89, $06, $9e, $06        ;; 22:4406 p.p.p.p.
    db   $b2, $06, $c4, $06, $d6, $06, $e7, $06        ;; 22:440e p.p.p.p.
    db   $f7, $06, $06, $07, $14, $07, $21, $07        ;; 22:4416 p.p.p.p.
    db   $2d, $07, $39, $07, $44, $07, $4f, $07        ;; 22:441e p.p.p.p.
    db   $59, $07, $62, $07, $6b, $07, $73, $07        ;; 22:4426 p.p.p.p.
    db   $7b, $07, $83, $07, $8a, $07, $90, $07        ;; 22:442e p.p.p.p.
    db   $97, $07, $9d, $07, $a2, $07, $a7, $07        ;; 22:4436 p.p.p.p.
    db   $ac, $07, $b1, $07, $b6, $07, $ba, $07        ;; 22:443e p.p.p.p.
    db   $be, $07, $c1, $07, $c4, $07, $c8, $07        ;; 22:4446 p.p.p.p.
    db   $cb, $07, $ce, $07, $d1, $07, $d4, $07        ;; 22:444e p.p.p.p.
    db   $d6, $07, $d9, $07, $db, $07, $dd, $07        ;; 22:4456 p.p.p.p.
    db   $df, $07                                      ;; 22:445e p.p.p.p.
    
data_22_4460:
    db   $1a, $00, $9c, $00, $72, $05                  ;; 22:4460 p.p.p.p.
    db   $02, $08, $33, $0b, $47, $0b, $ab, $0c        ;; 22:4466 p.p.p.p.
    db   $37, $14, $34, $16, $34, $16, $5c, $17        ;; 22:446e p.p.p.p.
    db   $2e, $1a, $85, $1c, $cf, $1c, $e1, $1c        ;; 22:4476 p.p.p.p.
    db   $fd, $1c, $25, $1d, $65, $1d, $cb, $1d        ;; 22:447e p.p.p.p.
    db   $d7, $1d, $11, $1e, $1d, $1e, $29, $1e        ;; 22:4486 p.p.p.p.
    db   $3d, $1e, $4f, $1e, $6f, $1e, $97, $1e        ;; 22:448e p.p.p.p.
    db   $f3, $1e, $09, $1f, $5f, $1f, $a9, $1f        ;; 22:4496 p.p.p.p.
    db   $55, $21, $77, $21, $cb, $21, $f7, $21        ;; 22:449e p.p.p.p.
    db   $23, $22, $35, $22, $4b, $22, $5b, $22        ;; 22:44a6 p.p.p.p.
    db   $67, $22, $7b, $22, $8f, $22, $97, $22        ;; 22:44ae p.p.p.p.
    db   $ab, $22, $dd, $22, $eb, $22, $2d, $23        ;; 22:44b6 p.p.p.p.
    db   $3b, $23, $75, $23, $83, $23, $99, $23        ;; 22:44be p.p.p.p.
    db   $9f, $23, $c5, $23, $d5, $23, $db, $23        ;; 22:44c6 p.p.p.p.
    db   $e9, $23, $f9, $23, $37, $24, $5d, $24        ;; 22:44ce p.p.p.p.
    db   $6d, $24, $b3, $24, $dd, $24, $f1, $24        ;; 22:44d6 p.p.p.p.
    db   $05, $25, $0f, $25, $41, $25, $69, $25        ;; 22:44de p.p.p.p.
    db   $9b, $25, $b1, $25, $dd, $25, $eb, $25        ;; 22:44e6 p.p.p.p.
    db   $15, $26, $23, $26, $79, $26, $8d, $26        ;; 22:44ee p.p.p.p.
    db   $a1, $26, $a3, $26, $a5, $26, $a7, $26        ;; 22:44f6 p.p.p.p.
    db   $01, $f6, $00, $f6, $80, $f6, $8f, $f5        ;; 22:44fe p.......
    db   $ff, $f4, $77, $e0, $07, $e1, $ff, $e2        ;; 22:4506 ........
    db   $91, $e2, $33, $25, $08, $26, $08, $27        ;; 22:450e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4516 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:451e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4526 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:452e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4536 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:453e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4546 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:454e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4556 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:455e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4566 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:456e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4576 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:457e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4586 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:458e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4596 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:459e ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45a6 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45ae ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45b6 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45be ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45c6 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45ce ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45d6 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45de ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45e6 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45ee ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45f6 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:45fe ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4606 ........
    db   $08, $28, $08, $e2, $11, $49, $08, $00        ;; 22:460e ........
    db   $18, $e2, $33, $25, $08, $26, $08, $27        ;; 22:4616 ........
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:461e ........
    db   $08, $28, $08, $e2, $11, $49, $08, $00        ;; 22:4626 ........
    db   $18, $00, $20, $e2, $33, $25, $08, $26        ;; 22:462e ........
    db   $08, $27, $08, $28, $28, $25, $08, $26        ;; 22:4636 ........
    db   $08, $27, $08, $28, $28, $25, $08, $26        ;; 22:463e ........
    db   $08, $27, $08, $28, $08, $e2, $11, $49        ;; 22:4646 ........
    db   $08, $00, $18, $e2, $33, $25, $08, $26        ;; 22:464e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4656 ........
    db   $08, $27, $08, $28, $08, $e2, $11, $49        ;; 22:465e ........
    db   $08, $00, $38, $e2, $33, $25, $08, $26        ;; 22:4666 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:466e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4676 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:467e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4686 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:468e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4696 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:469e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46a6 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46ae ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46b6 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46be ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46c6 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46ce ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46d6 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46de ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46e6 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46ee ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46f6 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:46fe ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4706 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:470e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4716 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:471e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4726 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:472e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4736 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:473e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4746 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:474e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4756 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:475e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4766 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:476e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4776 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:477e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4786 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:478e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:4796 ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:479e ........
    db   $08, $27, $08, $28, $08, $25, $08, $26        ;; 22:47a6 ........
    db   $08, $27, $08, $28, $08, $e2, $11, $49        ;; 22:47ae ........
    db   $08, $00, $78, $00, $80, $00, $80, $00        ;; 22:47b6 ........
    db   $80, $00, $80, $00, $80, $00, $80, $00        ;; 22:47be ........
    db   $80, $00, $80, $00, $80, $00, $80, $00        ;; 22:47c6 ........
    db   $80, $00, $80, $00, $80, $00, $80, $00        ;; 22:47ce ........
    db   $80, $00, $40, $e2, $57, $31, $40, $2b        ;; 22:47d6 ........
    db   $80, $30, $40, $2a, $60, $2f, $20, $29        ;; 22:47de ........
    db   $40, $2e, $20, $28, $20, $2d, $15, $27        ;; 22:47e6 ........
    db   $16, $2c, $15, $26, $40, $e2, $11, $49        ;; 22:47ee ........
    db   $08, $00, $38, $00, $80, $00, $80, $e2        ;; 22:47f6 ........
    db   $57, $19, $10, $17, $10, $16, $10, $14        ;; 22:47fe ........
    db   $10, $13, $10, $11, $10, $10, $10, $0e        ;; 22:4806 ........
    db   $10, $1a, $10, $18, $10, $17, $10, $15        ;; 22:480e ........
    db   $10, $14, $10, $12, $10, $11, $10, $0f        ;; 22:4816 ........
    db   $10, $1a, $10, $18, $10, $17, $10, $15        ;; 22:481e ........
    db   $10, $14, $10, $12, $10, $11, $10, $0f        ;; 22:4826 ........
    db   $10, $e2, $11, $49, $08, $00, $14, $e2        ;; 22:482e ........
    db   $11, $00, $64, $00, $80, $00, $80, $00        ;; 22:4836 ...?????
    db   $80, $00, $80, $00, $80, $00, $80, $00        ;; 22:483e ????????
    db   $80, $e2, $33, $25, $08, $26, $08, $27        ;; 22:4846 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:484e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4856 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:485e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4866 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:486e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4876 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:487e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4886 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:488e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4896 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:489e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48a6 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48ae ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48b6 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48be ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48c6 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48ce ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48d6 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48de ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48e6 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48ee ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48f6 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:48fe ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4906 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:490e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4916 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:491e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4926 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:492e ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:4936 ????????
    db   $08, $28, $08, $25, $08, $26, $08, $27        ;; 22:493e ????????
    db   $08, $28, $08, $e2, $11, $49, $08, $00        ;; 22:4946 ????????
    db   $38, $e2, $57, $2b, $04, $25, $04, $2b        ;; 22:494e ????????
    db   $04, $25, $04, $e2, $11, $49, $08, $00        ;; 22:4956 ????????
    db   $30, $00, $38, $e2, $57, $2b, $04, $25        ;; 22:495e ????????
    db   $04, $2b, $04, $25, $04, $e2, $11, $49        ;; 22:4966 ????????
    db   $08, $00, $28, $00, $40, $e2, $57, $2b        ;; 22:496e ????????
    db   $04, $25, $04, $2b, $04, $25, $04, $e2        ;; 22:4976 ????????
    db   $11, $49, $08, $00, $68, $e2, $57, $2b        ;; 22:497e ????????
    db   $04, $25, $04, $2b, $04, $25, $04, $e2        ;; 22:4986 ????????
    db   $11, $49, $08, $00, $68, $e2, $57, $2b        ;; 22:498e ????????
    db   $04, $25, $04, $2b, $04, $25, $04, $e2        ;; 22:4996 ????????
    db   $11, $49, $08, $00, $68, $e2, $57, $2b        ;; 22:499e ????????
    db   $04, $25, $04, $2b, $04, $25, $04, $e2        ;; 22:49a6 ????????
    db   $11, $49, $08, $00, $68, $e2, $57, $2b        ;; 22:49ae ????????
    db   $04, $25, $04, $2b, $04, $25, $04, $e2        ;; 22:49b6 ????????
    db   $11, $49, $08, $00, $68, $e2, $57, $2b        ;; 22:49be ????????
    db   $04, $25, $04, $2b, $04, $25, $04, $e2        ;; 22:49c6 ????????
    db   $11, $49, $08, $00, $28, $fe, $c6, $04        ;; 22:49ce ????????
    db   $02, $e6, $ff, $e7, $a7, $e7, $07, $49        ;; 22:49d6 ........
    db   $08, $00, $78, $00, $80, $00, $80, $00        ;; 22:49de ........
    db   $80, $00, $80, $00, $80, $00, $80, $00        ;; 22:49e6 ........
    db   $80, $e7, $37, $0d, $08, $0e, $08, $0f        ;; 22:49ee ........
    db   $08, $10, $08, $e7, $87, $49, $08, $00        ;; 22:49f6 ........
    db   $38, $e7, $37, $0d, $08, $0e, $08, $0f        ;; 22:49fe ........
    db   $08, $10, $08, $0d, $08, $0e, $08, $0f        ;; 22:4a06 ........
    db   $08, $10, $08, $e7, $87, $49, $08, $00        ;; 22:4a0e ........
    db   $18, $e7, $37, $0d, $08, $0e, $08, $0f        ;; 22:4a16 ........
    db   $08, $10, $08, $e7, $87, $49, $08, $00        ;; 22:4a1e ........
    db   $18, $e7, $37, $0d, $08, $0e, $08, $0f        ;; 22:4a26 ........
    db   $08, $10, $08, $e7, $87, $49, $08, $00        ;; 22:4a2e ........
    db   $18, $e7, $37, $0d, $08, $0e, $08, $0f        ;; 22:4a36 ........
    db   $08, $10, $08, $e7, $87, $49, $08, $00        ;; 22:4a3e ........
    db   $18, $00, $20, $e7, $37, $0d, $08, $0e        ;; 22:4a46 ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a4e ........
    db   $08, $0f, $08, $10, $08, $e7, $87, $49        ;; 22:4a56 ........
    db   $08, $00, $18, $e7, $37, $0d, $08, $0e        ;; 22:4a5e ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a66 ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a6e ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a76 ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a7e ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a86 ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a8e ........
    db   $08, $0f, $08, $10, $08, $0d, $08, $0e        ;; 22:4a96 ........
    db   $08, $0f, $08, $10, $08, $e7, $17, $49        ;; 22:4a9e ........
    db   $08, $00, $78, $00, $80, $00, $80, $00        ;; 22:4aa6 ........
    db   $80, $00, $80, $00, $80, $00, $80, $00        ;; 22:4aae ........
    db   $80, $e7, $57, $1c, $40, $19, $38, $25        ;; 22:4ab6 ........
    db   $08, $22, $40, $1f, $40, $1c, $40, $19        ;; 22:4abe ........
    db   $38, $25, $08, $22, $40, $1f, $40, $e7        ;; 22:4ac6 ........
    db   $47, $20, $10, $e7, $57, $1a, $20, $e7        ;; 22:4ace ........
    db   $37, $20, $10, $e7, $57, $1a, $20, $e7        ;; 22:4ad6 ........
    db   $47, $20, $10, $e7, $57, $19, $10, $e7        ;; 22:4ade ........
    db   $37, $20, $10, $e7, $57, $1a, $20, $e7        ;; 22:4ae6 ........
    db   $37, $20, $10, $e7, $57, $1a, $20, $e7        ;; 22:4aee ........
    db   $37, $20, $10, $e7, $57, $1d, $10, $1c        ;; 22:4af6 ........
    db   $40, $19, $38, $25, $08, $22, $40, $1f        ;; 22:4afe ........
    db   $40, $1c, $40, $19, $38, $25, $08, $22        ;; 22:4b06 ........
    db   $40, $1f, $40, $1c, $40, $19, $38, $25        ;; 22:4b0e ........
    db   $08, $22, $40, $1f, $40, $e7, $47, $20        ;; 22:4b16 ........
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4b1e ........
    db   $10, $e7, $57, $1a, $20, $e7, $47, $20        ;; 22:4b26 ........
    db   $10, $e7, $57, $19, $10, $e7, $37, $20        ;; 22:4b2e ........
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4b36 ........
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4b3e ........
    db   $10, $e7, $57, $1d, $10, $1c, $40, $19        ;; 22:4b46 ........
    db   $38, $25, $08, $22, $40, $1f, $40, $e7        ;; 22:4b4e ........
    db   $17, $49, $08, $00, $78, $00, $08, $00        ;; 22:4b56 ........
    db   $78, $00, $08, $00, $78, $49, $08, $00        ;; 22:4b5e ........
    db   $78, $20, $80, $49, $08, $00, $78, $00        ;; 22:4b66 ........
    db   $08, $00, $78, $00, $08, $00, $78, $e7        ;; 22:4b6e ........
    db   $57, $1a, $10, $1c, $10, $1d, $10, $1f        ;; 22:4b76 ........
    db   $10, $20, $10, $22, $10, $23, $10, $25        ;; 22:4b7e ........
    db   $10, $1a, $10, $1c, $10, $1d, $10, $1f        ;; 22:4b86 ........
    db   $10, $20, $10, $22, $10, $23, $10, $25        ;; 22:4b8e ........
    db   $10, $19, $10, $1b, $10, $1c, $10, $1e        ;; 22:4b96 ........
    db   $10, $1f, $10, $21, $10, $22, $10, $24        ;; 22:4b9e ........
    db   $10, $1c, $40, $19, $38, $25, $08, $22        ;; 22:4ba6 ...?????
    db   $40, $1f, $40, $1c, $40, $19, $38, $25        ;; 22:4bae ????????
    db   $08, $22, $40, $1f, $40, $e7, $47, $20        ;; 22:4bb6 ????????
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4bbe ????????
    db   $10, $e7, $57, $1a, $20, $e7, $47, $20        ;; 22:4bc6 ????????
    db   $10, $e7, $57, $19, $10, $e7, $37, $20        ;; 22:4bce ????????
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4bd6 ????????
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4bde ????????
    db   $10, $e7, $57, $1d, $10, $1c, $40, $19        ;; 22:4be6 ????????
    db   $38, $25, $08, $22, $40, $1f, $40, $e7        ;; 22:4bee ????????
    db   $17, $49, $08, $00, $78, $00, $08, $00        ;; 22:4bf6 ????????
    db   $78, $00, $08, $00, $78, $00, $08, $00        ;; 22:4bfe ????????
    db   $78, $20, $80, $00, $08, $00, $78, $00        ;; 22:4c06 ????????
    db   $08, $00, $78, $00, $08, $00, $78, $e7        ;; 22:4c0e ????????
    db   $57, $1c, $40, $19, $38, $25, $08, $22        ;; 22:4c16 ????????
    db   $40, $1f, $40, $1c, $40, $19, $38, $25        ;; 22:4c1e ????????
    db   $08, $22, $40, $1f, $40, $e7, $47, $20        ;; 22:4c26 ????????
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4c2e ????????
    db   $10, $e7, $57, $1a, $20, $e7, $47, $20        ;; 22:4c36 ????????
    db   $10, $e7, $57, $19, $10, $e7, $37, $20        ;; 22:4c3e ????????
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4c46 ????????
    db   $10, $e7, $57, $1a, $20, $e7, $37, $20        ;; 22:4c4e ????????
    db   $10, $e7, $57, $1d, $10, $1e, $40, $1b        ;; 22:4c56 ????????
    db   $38, $27, $08, $25, $40, $22, $40, $fe        ;; 22:4c5e ????????
    db   $8c, $02, $03, $fd, $01, $17, $2d, $43        ;; 22:4c66 ??......
    db   $59, $00, $00, $00, $00, $00, $00, $57        ;; 22:4c6e ........
    db   $41, $2b, $15, $00, $ea, $80, $eb, $01        ;; 22:4c76 ........
    db   $ec, $60, $49, $08, $00, $38, $0d, $40        ;; 22:4c7e ........
    db   $07, $80, $0c, $40, $06, $60, $0b, $20        ;; 22:4c86 ........
    db   $05, $40, $0a, $20, $04, $20, $09, $15        ;; 22:4c8e ........
    db   $03, $16, $08, $15, $02, $40, $49, $08        ;; 22:4c96 ........
    db   $00, $38, $00, $08, $00, $78, $00, $08        ;; 22:4c9e ........
    db   $00, $78, $00, $08, $00, $78, $00, $08        ;; 22:4ca6 ........
    db   $00, $78, $00, $08, $00, $78, $00, $08        ;; 22:4cae ........
    db   $00, $78, $00, $08, $00, $78, $00, $08        ;; 22:4cb6 ........
    db   $00, $78, $01, $60, $02, $20, $01, $60        ;; 22:4cbe ........
    db   $49, $08, $00, $18, $01, $60, $02, $20        ;; 22:4cc6 ........
    db   $01, $60, $49, $20, $01, $60, $02, $20        ;; 22:4cce ........
    db   $01, $60, $49, $08, $00, $18, $01, $60        ;; 22:4cd6 ........
    db   $02, $20, $01, $60, $49, $20, $01, $60        ;; 22:4cde ........
    db   $02, $20, $01, $60, $49, $08, $00, $18        ;; 22:4ce6 ........
    db   $01, $60, $02, $20, $01, $60, $49, $08        ;; 22:4cee ........
    db   $00, $18, $01, $60, $02, $20, $01, $60        ;; 22:4cf6 ........
    db   $49, $08, $00, $18, $01, $60, $02, $20        ;; 22:4cfe ........
    db   $01, $60, $49, $08, $00, $18, $01, $10        ;; 22:4d06 ........
    db   $0d, $10, $49, $10, $01, $10, $0d, $10        ;; 22:4d0e ........
    db   $49, $10, $01, $10, $0d, $10, $49, $10        ;; 22:4d16 ........
    db   $01, $10, $0d, $10, $49, $10, $01, $10        ;; 22:4d1e ........
    db   $0d, $10, $49, $10, $01, $10, $0d, $10        ;; 22:4d26 ........
    db   $49, $10, $01, $10, $0d, $10, $49, $10        ;; 22:4d2e ........
    db   $01, $10, $0d, $10, $49, $10, $01, $10        ;; 22:4d36 ........
    db   $0d, $10, $49, $10, $01, $10, $0d, $10        ;; 22:4d3e ........
    db   $49, $10, $01, $10, $0e, $10, $49, $10        ;; 22:4d46 ........
    db   $01, $10, $0e, $10, $49, $10, $01, $10        ;; 22:4d4e ........
    db   $0e, $10, $49, $10, $01, $10, $0e, $10        ;; 22:4d56 ........
    db   $49, $10, $01, $10, $0e, $10, $49, $10        ;; 22:4d5e ........
    db   $01, $10, $0e, $10, $49, $10, $01, $10        ;; 22:4d66 ........
    db   $0d, $10, $49, $10, $01, $10, $0d, $10        ;; 22:4d6e ........
    db   $49, $10, $01, $10, $0d, $10, $49, $10        ;; 22:4d76 ........
    db   $01, $10, $0d, $10, $49, $10, $01, $10        ;; 22:4d7e ........
    db   $0d, $10, $49, $10, $01, $10, $01, $10        ;; 22:4d86 ........
    db   $0d, $10, $49, $10, $01, $10, $0d, $10        ;; 22:4d8e ........
    db   $49, $10, $01, $10, $0d, $10, $49, $10        ;; 22:4d96 ........
    db   $01, $10, $0d, $10, $49, $10, $01, $10        ;; 22:4d9e ........
    db   $0d, $10, $49, $10, $01, $10, $0e, $10        ;; 22:4da6 ........
    db   $49, $10, $01, $10, $0e, $10, $49, $10        ;; 22:4dae ........
    db   $01, $10, $0e, $10, $49, $10, $01, $10        ;; 22:4db6 ........
    db   $0e, $10, $49, $10, $01, $10, $0e, $10        ;; 22:4dbe ........
    db   $49, $10, $01, $10, $0d, $10, $49, $10        ;; 22:4dc6 ........
    db   $01, $10, $0d, $10, $49, $10, $01, $10        ;; 22:4dce ........
    db   $0d, $10, $49, $10, $01, $10, $0d, $10        ;; 22:4dd6 ........
    db   $49, $10, $01, $10, $0d, $10, $49, $10        ;; 22:4dde ........
    db   $01, $10, $0d, $10, $49, $10, $01, $10        ;; 22:4de6 ........
    db   $0e, $10, $49, $10, $01, $10, $0e, $10        ;; 22:4dee ........
    db   $49, $10, $01, $10, $0e, $10, $49, $10        ;; 22:4df6 ........
    db   $01, $10, $0e, $10, $49, $10, $01, $10        ;; 22:4dfe ........
    db   $0e, $10, $49, $10, $01, $10, $49, $08        ;; 22:4e06 ........
    db   $00, $78, $49, $08, $00, $78, $49, $08        ;; 22:4e0e ........
    db   $00, $78, $01, $10, $04, $10, $07, $10        ;; 22:4e16 ........
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e1e ..??????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4e26 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e2e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4e36 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e3e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4e46 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e4e ????????
    db   $04, $10, $02, $10, $05, $10, $08, $10        ;; 22:4e56 ????????
    db   $0b, $10, $0e, $10, $0b, $10, $08, $10        ;; 22:4e5e ????????
    db   $05, $10, $02, $10, $05, $10, $08, $10        ;; 22:4e66 ????????
    db   $0b, $10, $0e, $10, $0b, $10, $08, $10        ;; 22:4e6e ????????
    db   $05, $10, $01, $10, $04, $10, $07, $10        ;; 22:4e76 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e7e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4e86 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e8e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4e96 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4e9e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4ea6 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4eae ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4eb6 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4ebe ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4ec6 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4ece ????????
    db   $04, $10, $02, $10, $05, $10, $08, $10        ;; 22:4ed6 ????????
    db   $0b, $10, $0e, $10, $0b, $10, $08, $10        ;; 22:4ede ????????
    db   $05, $10, $02, $10, $05, $10, $08, $10        ;; 22:4ee6 ????????
    db   $0b, $10, $0e, $10, $0b, $10, $08, $10        ;; 22:4eee ????????
    db   $05, $10, $01, $10, $04, $10, $07, $10        ;; 22:4ef6 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4efe ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4f06 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4f0e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4f16 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4f1e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4f26 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4f2e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4f36 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4f3e ????????
    db   $04, $10, $01, $10, $04, $10, $07, $10        ;; 22:4f46 ????????
    db   $0a, $10, $0d, $10, $0a, $10, $07, $10        ;; 22:4f4e ????????
    db   $04, $10, $02, $10, $05, $10, $08, $10        ;; 22:4f56 ????????
    db   $02, $10, $05, $10, $08, $10, $02, $10        ;; 22:4f5e ????????
    db   $05, $10, $08, $10, $02, $10, $05, $10        ;; 22:4f66 ????????
    db   $08, $10, $02, $10, $05, $10, $08, $10        ;; 22:4f6e ????????
    db   $02, $10, $03, $10, $06, $10, $09, $10        ;; 22:4f76 ????????
    db   $0c, $10, $0f, $10, $0c, $10, $09, $10        ;; 22:4f7e ????????
    db   $06, $10, $04, $10, $07, $10, $0a, $10        ;; 22:4f86 ????????
    db   $0d, $10, $10, $10, $0d, $10, $0a, $10        ;; 22:4f8e ????????
    db   $07, $10, $fe, $1a, $03, $04, $f0, $14        ;; 22:4f96 ?????...
    db   $f1, $51, $f2, $22, $f1, $31, $27, $08        ;; 22:4f9e ........
    db   $f1, $11, $27, $08, $27, $08, $27, $08        ;; 22:4fa6 ........
    db   $fe, $0e, $00, $01, $f6, $00, $f6, $80        ;; 22:4fae ...?????
    db   $f6, $8f, $f5, $ff, $f4, $77, $e0, $00        ;; 22:4fb6 ????????
    db   $e1, $ff, $e2, $b7, $e2, $47, $00, $c8        ;; 22:4fbe ????????
    db   $49, $c8, $49, $c8, $49, $c8, $49, $c8        ;; 22:4fc6 ????????
    db   $49, $c8, $49, $1d, $e2, $a7, $25, $0a        ;; 22:4fce ????????
    db   $e2, $97, $24, $09, $e2, $a7, $25, $27        ;; 22:4fd6 ????????
    db   $e2, $97, $20, $09, $e2, $47, $00, $0a        ;; 22:4fde ????????
    db   $e2, $97, $20, $4d, $e2, $47, $00, $26        ;; 22:4fe6 ????????
    db   $e2, $a7, $20, $26, $25, $1a, $27, $1a        ;; 22:4fee ????????
    db   $2a, $19, $28, $3a, $27, $09, $e2, $97        ;; 22:4ff6 ????????
    db   $25, $0a, $27, $9a, $e2, $47, $00, $4c        ;; 22:4ffe ????????
    db   $e2, $a7, $25, $0a, $e2, $97, $24, $0a        ;; 22:5006 ????????
    db   $e2, $a7, $25, $26, $20, $0a, $e2, $47        ;; 22:500e ????????
    db   $00, $09, $e2, $a7, $20, $4d, $e2, $47        ;; 22:5016 ????????
    db   $00, $26, $e2, $a7, $20, $27, $25, $20        ;; 22:501e ????????
    db   $27, $19, $29, $14, $29, $e6, $e2, $47        ;; 22:5026 ????????
    db   $00, $4d, $e2, $a7, $28, $0a, $27, $09        ;; 22:502e ????????
    db   $28, $3a, $23, $4d, $e2, $47, $00, $26        ;; 22:5036 ????????
    db   $e2, $a7, $23, $26, $e2, $97, $28, $1a        ;; 22:503e ????????
    db   $2a, $1a, $2c, $19, $e2, $a7, $2c, $3a        ;; 22:5046 ????????
    db   $e2, $97, $2a, $09, $e2, $47, $00, $0a        ;; 22:504e ????????
    db   $e2, $97, $2a, $e6, $e2, $a7, $2d, $13        ;; 22:5056 ????????
    db   $2c, $0a, $2a, $09, $2c, $14, $e2, $97        ;; 22:505e ????????
    db   $25, $13, $2a, $39, $e2, $a7, $27, $0a        ;; 22:5066 ????????
    db   $e2, $97, $25, $0a, $e2, $a7, $27, $99        ;; 22:506e ????????
    db   $e2, $47, $00, $4d, $e2, $87, $24, $09        ;; 22:5076 ????????
    db   $25, $0a, $27, $90, $e2, $47, $00, $43        ;; 22:507e ????????
    db   $e2, $87, $2c, $0a, $2d, $09, $2f, $87        ;; 22:5086 ????????
    db   $e2, $97, $23, $19, $e2, $87, $25, $1a        ;; 22:508e ????????
    db   $26, $1a, $28, $19, $26, $1a, $25, $19        ;; 22:5096 ????????
    db   $26, $1a, $2a, $1a, $e2, $97, $28, $19        ;; 22:509e ????????
    db   $e2, $77, $2b, $1a, $e2, $87, $2d, $19        ;; 22:50a6 ????????
    db   $2f, $1a, $e2, $47, $00, $26, $e2, $87        ;; 22:50ae ????????
    db   $25, $27, $25, $20, $27, $19, $29, $14        ;; 22:50b6 ????????
    db   $e2, $97, $29, $39, $e2, $87, $27, $13        ;; 22:50be ????????
    db   $27, $4d, $2c, $3a, $25, $13, $e2, $97        ;; 22:50c6 ????????
    db   $29, $20, $27, $1a, $e2, $87, $25, $13        ;; 22:50ce ????????
    db   $e2, $97, $27, $4d, $e2, $47, $00, $4c        ;; 22:50d6 ????????
    db   $e2, $97, $25, $3a, $e2, $67, $20, $13        ;; 22:50de ????????
    db   $e2, $87, $2a, $20, $29, $1a, $25, $13        ;; 22:50e6 ????????
    db   $2c, $3a, $2d, $13, $28, $4d, $e2, $97        ;; 22:50ee ????????
    db   $28, $39, $e2, $87, $25, $0a, $e2, $97        ;; 22:50f6 ????????
    db   $27, $09, $e2, $87, $28, $1d, $27, $1d        ;; 22:50fe ????????
    db   $25, $13, $27, $3a, $2c, $13, $2c, $4d        ;; 22:5106 ????????
    db   $e2, $47, $00, $99, $49, $9a, $fe, $54        ;; 22:510e ????????
    db   $01, $02, $e6, $ff, $e7, $b7, $e7, $a7        ;; 22:5116 ????????
    db   $25, $0a, $e7, $87, $23, $09, $e7, $a7        ;; 22:511e ????????
    db   $25, $0a, $e7, $97, $23, $09, $25, $0a        ;; 22:5126 ????????
    db   $e7, $87, $23, $0a, $e7, $97, $20, $09        ;; 22:512e ????????
    db   $1e, $0a, $19, $09, $1e, $0a, $1c, $0a        ;; 22:5136 ????????
    db   $e7, $87, $19, $09, $e7, $97, $1e, $0a        ;; 22:513e ????????
    db   $19, $09, $e7, $a7, $20, $0a, $e7, $87        ;; 22:5146 ????????
    db   $23, $0a, $e7, $97, $25, $09, $23, $0a        ;; 22:514e ????????
    db   $e7, $87, $25, $09, $e7, $97, $23, $0a        ;; 22:5156 ????????
    db   $e7, $a7, $25, $0a, $e7, $97, $23, $09        ;; 22:515e ????????
    db   $e7, $a7, $20, $0a, $e7, $97, $1e, $09        ;; 22:5166 ????????
    db   $19, $0a, $1e, $0a, $e7, $87, $1c, $09        ;; 22:516e ????????
    db   $e7, $97, $19, $0a, $1e, $09, $19, $0a        ;; 22:5176 ????????
    db   $e7, $a7, $20, $0a, $e7, $87, $23, $09        ;; 22:517e ????????
    db   $e7, $a7, $25, $0a, $23, $09, $e7, $97        ;; 22:5186 ????????
    db   $25, $0a, $23, $0a, $25, $09, $e7, $87        ;; 22:518e ????????
    db   $23, $0a, $e7, $97, $20, $09, $e7, $87        ;; 22:5196 ????????
    db   $1e, $0a, $19, $0a, $e7, $a7, $1e, $09        ;; 22:519e ????????
    db   $e7, $97, $1c, $0a, $19, $09, $1e, $0a        ;; 22:51a6 ????????
    db   $19, $0a, $e7, $a7, $20, $09, $e7, $87        ;; 22:51ae ????????
    db   $23, $0a, $e7, $a7, $25, $09, $e7, $97        ;; 22:51b6 ????????
    db   $23, $0a, $25, $0a, $23, $09, $25, $0a        ;; 22:51be ????????
    db   $e7, $87, $23, $09, $e7, $97, $20, $0a        ;; 22:51c6 ????????
    db   $1e, $0a, $19, $09, $e7, $a7, $1e, $0a        ;; 22:51ce ????????
    db   $e7, $97, $1c, $09, $e7, $87, $19, $0a        ;; 22:51d6 ????????
    db   $e7, $a7, $1e, $0a, $e7, $87, $19, $09        ;; 22:51de ????????
    db   $e7, $97, $20, $0a, $23, $09, $e7, $a7        ;; 22:51e6 ????????
    db   $25, $0a, $23, $0a, $25, $09, $e7, $97        ;; 22:51ee ????????
    db   $23, $0a, $e7, $a7, $25, $09, $e7, $87        ;; 22:51f6 ????????
    db   $23, $0a, $20, $0a, $1e, $09, $e7, $97        ;; 22:51fe ????????
    db   $19, $0a, $1e, $09, $e7, $87, $1c, $0a        ;; 22:5206 ????????
    db   $e7, $97, $19, $0a, $e7, $a7, $1e, $09        ;; 22:520e ????????
    db   $e7, $97, $19, $0a, $e7, $a7, $20, $09        ;; 22:5216 ????????
    db   $e7, $87, $23, $0a, $e7, $97, $25, $0a        ;; 22:521e ????????
    db   $23, $09, $25, $0a, $23, $09, $25, $0a        ;; 22:5226 ????????
    db   $e7, $87, $23, $0a, $e7, $97, $20, $09        ;; 22:522e ????????
    db   $1e, $0a, $e7, $87, $19, $09, $e7, $a7        ;; 22:5236 ????????
    db   $1e, $0a, $1c, $0a, $e7, $87, $19, $09        ;; 22:523e ????????
    db   $e7, $a7, $1e, $0a, $e7, $87, $19, $09        ;; 22:5246 ????????
    db   $e7, $a7, $20, $0a, $e7, $97, $23, $0a        ;; 22:524e ????????
    db   $e7, $a7, $25, $09, $e7, $97, $23, $0a        ;; 22:5256 ????????
    db   $e7, $a7, $25, $09, $e7, $97, $23, $0a        ;; 22:525e ????????
    db   $e7, $a7, $25, $0a, $e7, $97, $23, $09        ;; 22:5266 ????????
    db   $20, $0a, $1e, $09, $e7, $a7, $19, $0a        ;; 22:526e ????????
    db   $e7, $97, $1e, $0a, $1c, $09, $19, $0a        ;; 22:5276 ????????
    db   $e7, $a7, $1e, $09, $e7, $97, $19, $0a        ;; 22:527e ????????
    db   $20, $0a, $23, $09, $e7, $a7, $25, $0a        ;; 22:5286 ????????
    db   $e7, $97, $23, $09, $25, $0a, $23, $0a        ;; 22:528e ????????
    db   $e7, $a7, $25, $09, $e7, $97, $23, $0a        ;; 22:5296 ????????
    db   $20, $09, $e7, $87, $1e, $0a, $20, $0a        ;; 22:529e ????????
    db   $22, $04, $e7, $a7, $2a, $05, $e7, $97        ;; 22:52a6 ????????
    db   $27, $05, $25, $05, $22, $05, $20, $04        ;; 22:52ae ????????
    db   $22, $05, $e7, $a7, $25, $05, $27, $05        ;; 22:52b6 ????????
    db   $29, $05, $2a, $04, $2c, $05, $e7, $b7        ;; 22:52be ????????
    db   $2e, $05, $30, $05, $e7, $b7, $31, $0a        ;; 22:52c6 ????????
    db   $e7, $77, $20, $09, $e7, $87, $25, $0a        ;; 22:52ce ????????
    db   $20, $09, $25, $0a, $e7, $77, $27, $0a        ;; 22:52d6 ????????
    db   $e7, $87, $29, $09, $2c, $0a, $20, $09        ;; 22:52de ????????
    db   $29, $0a, $27, $0a, $e7, $77, $25, $09        ;; 22:52e6 ????????
    db   $e7, $87, $29, $0a, $25, $09, $29, $0a        ;; 22:52ee ????????
    db   $e7, $77, $2a, $0a, $e7, $87, $25, $09        ;; 22:52f6 ????????
    db   $20, $0a, $e7, $77, $25, $09, $e7, $87        ;; 22:52fe ????????
    db   $20, $0a, $e7, $97, $25, $0a, $e7, $87        ;; 22:5306 ????????
    db   $27, $09, $29, $0a, $2c, $09, $20, $0a        ;; 22:530e ????????
    db   $29, $0a, $e7, $77, $27, $09, $e7, $87        ;; 22:5316 ????????
    db   $25, $0a, $29, $09, $25, $0a, $e7, $97        ;; 22:531e ????????
    db   $29, $0a, $e7, $77, $2a, $09, $e7, $97        ;; 22:5326 ????????
    db   $25, $0a, $e7, $87, $20, $09, $25, $0a        ;; 22:532e ????????
    db   $20, $0a, $25, $09, $e7, $77, $27, $0a        ;; 22:5336 ????????
    db   $e7, $87, $28, $09, $e7, $77, $2c, $0a        ;; 22:533e ????????
    db   $20, $0a, $e7, $97, $28, $09, $e7, $87        ;; 22:5346 ????????
    db   $27, $0a, $25, $09, $28, $0a, $25, $0a        ;; 22:534e ????????
    db   $e7, $97, $28, $09, $e7, $77, $2a, $0a        ;; 22:5356 ????????
    db   $e7, $87, $25, $09, $20, $0a, $25, $0a        ;; 22:535e ????????
    db   $20, $09, $25, $0a, $e7, $77, $27, $09        ;; 22:5366 ????????
    db   $e7, $87, $28, $0a, $2c, $0a, $20, $09        ;; 22:536e ????????
    db   $e7, $97, $28, $0a, $e7, $87, $27, $09        ;; 22:5376 ????????
    db   $e7, $77, $25, $0a, $e7, $97, $28, $0a        ;; 22:537e ????????
    db   $e7, $77, $25, $09, $e7, $87, $28, $0a        ;; 22:5386 ????????
    db   $2a, $09, $e7, $97, $25, $0a, $e7, $77        ;; 22:538e ????????
    db   $20, $0a, $e7, $87, $25, $09, $20, $0a        ;; 22:5396 ????????
    db   $25, $09, $e7, $77, $27, $0a, $e7, $87        ;; 22:539e ????????
    db   $29, $0a, $2c, $09, $20, $0a, $29, $09        ;; 22:53a6 ????????
    db   $27, $0a, $e7, $77, $25, $0a, $e7, $87        ;; 22:53ae ????????
    db   $29, $09, $25, $0a, $29, $09, $e7, $77        ;; 22:53b6 ????????
    db   $2a, $0a, $e7, $87, $25, $0a, $20, $09        ;; 22:53be ????????
    db   $e7, $77, $25, $0a, $e7, $87, $20, $09        ;; 22:53c6 ????????
    db   $e7, $97, $25, $0a, $e7, $87, $27, $0a        ;; 22:53ce ????????
    db   $29, $09, $2c, $0a, $20, $09, $29, $0a        ;; 22:53d6 ????????
    db   $e7, $77, $27, $0a, $e7, $87, $25, $09        ;; 22:53de ????????
    db   $29, $0a, $25, $09, $e7, $97, $29, $0a        ;; 22:53e6 ????????
    db   $e7, $77, $2a, $0a, $e7, $97, $25, $09        ;; 22:53ee ????????
    db   $25, $01, $e7, $77, $20, $09, $e7, $87        ;; 22:53f6 ????????
    db   $25, $09, $20, $0a, $25, $0a, $e7, $77        ;; 22:53fe ????????
    db   $27, $09, $e7, $87, $29, $0a, $2c, $09        ;; 22:5406 ????????
    db   $20, $0a, $29, $0a, $27, $09, $e7, $77        ;; 22:540e ????????
    db   $25, $0a, $e7, $87, $29, $09, $25, $0a        ;; 22:5416 ????????
    db   $29, $0a, $e7, $77, $2a, $09, $e7, $87        ;; 22:541e ????????
    db   $25, $0a, $20, $09, $e7, $77, $25, $0a        ;; 22:5426 ????????
    db   $e7, $87, $20, $0a, $e7, $97, $25, $09        ;; 22:542e ????????
    db   $e7, $87, $27, $0a, $29, $09, $2c, $0a        ;; 22:5436 ????????
    db   $20, $0e, $e7, $b7, $2e, $05, $e7, $97        ;; 22:543e ????????
    db   $2a, $05, $29, $05, $e7, $77, $27, $05        ;; 22:5446 ????????
    db   $e7, $a7, $24, $04, $25, $05, $e7, $87        ;; 22:544e ????????
    db   $29, $05, $e7, $a7, $29, $01, $2a, $04        ;; 22:5456 ????????
    db   $e7, $b7, $2c, $05, $2e, $04, $30, $05        ;; 22:545e ????????
    db   $31, $05, $33, $05, $e7, $b7, $34, $0a        ;; 22:5466 ????????
    db   $e7, $77, $20, $09, $e7, $87, $23, $0a        ;; 22:546e ????????
    db   $20, $09, $23, $0a, $e7, $77, $28, $0a        ;; 22:5476 ????????
    db   $e7, $87, $28, $09, $2c, $0a, $20, $09        ;; 22:547e ????????
    db   $28, $0a, $28, $0a, $e7, $77, $23, $09        ;; 22:5486 ????????
    db   $e7, $87, $28, $0a, $23, $09, $28, $0a        ;; 22:548e ????????
    db   $e7, $77, $2a, $0a, $e7, $87, $23, $09        ;; 22:5496 ????????
    db   $20, $0a, $e7, $77, $23, $09, $e7, $87        ;; 22:549e ????????
    db   $20, $0a, $e7, $97, $23, $0a, $e7, $87        ;; 22:54a6 ????????
    db   $28, $09, $28, $0a, $2c, $09, $20, $0a        ;; 22:54ae ????????
    db   $28, $0a, $e7, $77, $28, $09, $e7, $87        ;; 22:54b6 ????????
    db   $23, $0a, $28, $09, $23, $0a, $e7, $97        ;; 22:54be ????????
    db   $28, $0a, $e7, $77, $2a, $09, $e7, $97        ;; 22:54c6 ????????
    db   $25, $0a, $e7, $77, $20, $09, $e7, $87        ;; 22:54ce ????????
    db   $25, $0a, $20, $0a, $25, $09, $e7, $77        ;; 22:54d6 ????????
    db   $27, $0a, $e7, $87, $29, $09, $2d, $0a        ;; 22:54de ????????
    db   $21, $0a, $2a, $09, $28, $0a, $e7, $77        ;; 22:54e6 ????????
    db   $26, $09, $e7, $87, $2a, $0a, $26, $0a        ;; 22:54ee ????????
    db   $2a, $09, $e7, $77, $2b, $0a, $e7, $87        ;; 22:54f6 ????????
    db   $26, $09, $21, $0a, $e7, $77, $26, $0a        ;; 22:54fe ????????
    db   $e7, $87, $21, $09, $e7, $97, $26, $0a        ;; 22:5506 ????????
    db   $e7, $87, $28, $09, $2a, $0a, $2d, $0a        ;; 22:550e ????????
    db   $21, $09, $2a, $0a, $e7, $77, $28, $09        ;; 22:5516 ????????
    db   $e7, $87, $26, $0a, $20, $05, $21, $05        ;; 22:551e ????????
    db   $23, $04, $e7, $97, $25, $05, $26, $05        ;; 22:5526 ????????
    db   $28, $05, $2a, $05, $2c, $04, $e7, $97        ;; 22:552e ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:5536 ????????
    db   $2d, $04, $e7, $87, $2c, $05, $e7, $97        ;; 22:553e ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:5546 ????????
    db   $2d, $05, $e7, $87, $2c, $04, $e7, $97        ;; 22:554e ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:5556 ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:555e ????????
    db   $2d, $04, $e7, $87, $2c, $05, $e7, $97        ;; 22:5566 ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:556e ????????
    db   $2d, $05, $e7, $87, $2c, $04, $e7, $97        ;; 22:5576 ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:557e ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:5586 ????????
    db   $2d, $04, $e7, $87, $2c, $05, $e7, $97        ;; 22:558e ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:5596 ????????
    db   $2d, $05, $e7, $87, $2c, $04, $e7, $97        ;; 22:559e ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $97        ;; 22:55a6 ????????
    db   $2d, $05, $e7, $87, $2c, $05, $e7, $77        ;; 22:55ae ????????
    db   $30, $0c, $e7, $87, $2e, $0d, $30, $0d        ;; 22:55b6 ????????
    db   $2e, $0d, $e7, $97, $30, $0d, $31, $0c        ;; 22:55be ????????
    db   $e7, $a7, $33, $0d, $e7, $97, $31, $0d        ;; 22:55c6 ????????
    db   $33, $0d, $e7, $87, $34, $0d, $33, $0c        ;; 22:55ce ????????
    db   $e7, $77, $31, $0d, $e7, $77, $22, $0a        ;; 22:55d6 ????????
    db   $22, $09, $e7, $47, $00, $0a, $e7, $77        ;; 22:55de ????????
    db   $22, $09, $22, $0a, $22, $0a, $e7, $47        ;; 22:55e6 ????????
    db   $00, $09, $e7, $77, $22, $0a, $e7, $87        ;; 22:55ee ????????
    db   $22, $09, $e7, $77, $22, $0a, $e7, $47        ;; 22:55f6 ????????
    db   $00, $0a, $e7, $77, $22, $09, $e7, $87        ;; 22:55fe ????????
    db   $22, $0a, $22, $09, $e7, $47, $00, $0a        ;; 22:5606 ????????
    db   $e7, $87, $22, $0a, $22, $09, $e7, $77        ;; 22:560e ????????
    db   $22, $0a, $e7, $47, $00, $09, $e7, $87        ;; 22:5616 ????????
    db   $22, $0a, $22, $0a, $22, $09, $e7, $47        ;; 22:561e ????????
    db   $00, $0a, $e7, $87, $22, $09, $e7, $77        ;; 22:5626 ????????
    db   $23, $0a, $23, $0a, $e7, $47, $00, $09        ;; 22:562e ????????
    db   $e7, $77, $23, $0a, $23, $09, $23, $0a        ;; 22:5636 ????????
    db   $e7, $47, $00, $0a, $e7, $77, $23, $09        ;; 22:563e ????????
    db   $23, $0a, $23, $09, $e7, $47, $00, $0a        ;; 22:5646 ????????
    db   $e7, $77, $23, $0a, $e7, $87, $23, $09        ;; 22:564e ????????
    db   $e7, $77, $23, $0a, $e7, $47, $00, $09        ;; 22:5656 ????????
    db   $e7, $77, $23, $0a, $e7, $47, $00, $4d        ;; 22:565e ????????
    db   $e7, $97, $2f, $19, $31, $1a, $e7, $87        ;; 22:5666 ????????
    db   $32, $1a, $34, $19, $e7, $97, $32, $1a        ;; 22:566e ????????
    db   $e7, $87, $31, $19, $32, $1a, $36, $1a        ;; 22:5676 ????????
    db   $e7, $97, $34, $19, $e7, $77, $37, $1a        ;; 22:567e ????????
    db   $e7, $97, $39, $0d, $2f, $04, $31, $05        ;; 22:5686 ????????
    db   $32, $05, $34, $05, $36, $05, $37, $04        ;; 22:568e ????????
    db   $e7, $87, $39, $05, $e7, $97, $3b, $05        ;; 22:5696 ????????
    db   $e7, $87, $3d, $0a, $3c, $09, $38, $0a        ;; 22:569e ????????
    db   $e7, $77, $31, $09, $e7, $97, $2c, $0a        ;; 22:56a6 ????????
    db   $e7, $77, $31, $0a, $e7, $87, $38, $09        ;; 22:56ae ????????
    db   $3c, $0a, $e7, $97, $3d, $09, $e7, $87        ;; 22:56b6 ????????
    db   $3c, $0a, $38, $0a, $31, $09, $e7, $97        ;; 22:56be ????????
    db   $2c, $0a, $e7, $87, $31, $09, $38, $0a        ;; 22:56c6 ????????
    db   $e7, $77, $3c, $0a, $e7, $87, $3d, $09        ;; 22:56ce ????????
    db   $e7, $77, $39, $0a, $35, $09, $31, $0a        ;; 22:56d6 ????????
    db   $e7, $87, $2d, $0a, $e7, $77, $31, $09        ;; 22:56de ????????
    db   $35, $0a, $e7, $67, $39, $09, $e7, $87        ;; 22:56e6 ????????
    db   $3d, $0a, $e7, $67, $39, $0a, $e7, $77        ;; 22:56ee ????????
    db   $35, $09, $31, $0a, $e7, $87, $2d, $09        ;; 22:56f6 ????????
    db   $e7, $77, $31, $0a, $35, $0a, $39, $09        ;; 22:56fe ????????
    db   $3d, $0a, $3c, $09, $38, $0a, $e7, $67        ;; 22:5706 ????????
    db   $31, $0a, $e7, $87, $2c, $09, $e7, $67        ;; 22:570e ????????
    db   $31, $0a, $e7, $77, $38, $09, $3c, $0a        ;; 22:5716 ????????
    db   $e7, $87, $3d, $0a, $e7, $77, $36, $09        ;; 22:571e ????????
    db   $35, $0a, $31, $09, $e7, $87, $2a, $0a        ;; 22:5726 ????????
    db   $e7, $77, $31, $0a, $35, $09, $e7, $67        ;; 22:572e ????????
    db   $36, $0a, $e7, $77, $3d, $09, $3b, $0a        ;; 22:5736 ????????
    db   $36, $0a, $e7, $67, $31, $09, $e7, $87        ;; 22:573e ????????
    db   $2f, $0a, $e7, $67, $31, $09, $e7, $77        ;; 22:5746 ????????
    db   $36, $0a, $3b, $0a, $e7, $87, $3d, $09        ;; 22:574e ????????
    db   $e7, $77, $3b, $0a, $36, $09, $31, $0a        ;; 22:5756 ????????
    db   $e7, $87, $2f, $0a, $e7, $77, $31, $09        ;; 22:575e ????????
    db   $36, $0a, $e7, $67, $3b, $09, $e7, $77        ;; 22:5766 ????????
    db   $3d, $0a, $3c, $0a, $38, $09, $e7, $67        ;; 22:576e ????????
    db   $31, $0a, $e7, $87, $2c, $09, $e7, $67        ;; 22:5776 ????????
    db   $31, $0a, $e7, $77, $38, $0a, $3c, $09        ;; 22:577e ????????
    db   $e7, $87, $3d, $0a, $e7, $77, $3c, $09        ;; 22:5786 ????????
    db   $38, $0a, $31, $0a, $e7, $87, $2c, $09        ;; 22:578e ????????
    db   $e7, $77, $31, $0a, $38, $09, $e7, $67        ;; 22:5796 ????????
    db   $3c, $0a, $e7, $87, $3d, $0a, $e7, $77        ;; 22:579e ????????
    db   $3b, $09, $36, $0a, $34, $09, $e7, $87        ;; 22:57a6 ????????
    db   $2d, $0a, $e7, $77, $34, $0a, $36, $09        ;; 22:57ae ????????
    db   $e7, $67, $3b, $0a, $e7, $87, $3d, $09        ;; 22:57b6 ????????
    db   $e7, $67, $3b, $0a, $e7, $77, $36, $0a        ;; 22:57be ????????
    db   $34, $09, $e7, $87, $2d, $0a, $e7, $77        ;; 22:57c6 ????????
    db   $34, $09, $36, $0a, $3b, $0a, $3d, $09        ;; 22:57ce ????????
    db   $38, $0a, $36, $09, $e7, $67, $31, $0a        ;; 22:57d6 ????????
    db   $e7, $87, $2f, $0a, $e7, $67, $31, $09        ;; 22:57de ????????
    db   $e7, $77, $36, $0a, $38, $09, $e7, $87        ;; 22:57e6 ????????
    db   $3d, $0a, $e7, $77, $38, $0a, $36, $09        ;; 22:57ee ????????
    db   $31, $0a, $e7, $87, $2f, $09, $e7, $77        ;; 22:57f6 ????????
    db   $31, $0a, $36, $0a, $e7, $67, $38, $09        ;; 22:57fe ????????
    db   $e7, $87, $3d, $0a, $e7, $77, $38, $09        ;; 22:5806 ????????
    db   $36, $0a, $33, $0a, $e7, $87, $36, $09        ;; 22:580e ????????
    db   $e7, $77, $33, $0a, $31, $09, $e7, $67        ;; 22:5816 ????????
    db   $2e, $0a, $e7, $87, $33, $0a, $e7, $67        ;; 22:581e ????????
    db   $31, $09, $e7, $77, $2c, $0a, $2a, $09        ;; 22:5826 ????????
    db   $e7, $87, $31, $0a, $e7, $77, $2c, $0a        ;; 22:582e ????????
    db   $2a, $09, $27, $0a, $e7, $87, $25, $09        ;; 22:5836 ????????
    db   $23, $0a, $e7, $77, $25, $0a, $e7, $87        ;; 22:583e ????????
    db   $23, $09, $25, $0a, $23, $09, $e7, $97        ;; 22:5846 ????????
    db   $20, $0a, $e7, $87, $1e, $0a, $19, $09        ;; 22:584e ????????
    db   $e7, $a7, $1e, $0a, $e7, $87, $1c, $09        ;; 22:5856 ????????
    db   $e7, $a7, $19, $0a, $e7, $97, $1e, $0a        ;; 22:585e ????????
    db   $19, $09, $e7, $a7, $20, $0a, $e7, $77        ;; 22:5866 ????????
    db   $23, $09, $e7, $a7, $25, $0a, $23, $0a        ;; 22:586e ????????
    db   $e7, $97, $25, $09, $23, $0a, $25, $09        ;; 22:5876 ????????
    db   $e7, $87, $23, $0a, $e7, $97, $20, $0a        ;; 22:587e ????????
    db   $e7, $87, $1e, $09, $19, $0a, $e7, $a7        ;; 22:5886 ????????
    db   $1e, $09, $e7, $97, $1c, $0a, $19, $0a        ;; 22:588e ????????
    db   $1e, $09, $19, $0a, $e7, $a7, $20, $09        ;; 22:5896 ????????
    db   $e7, $87, $23, $0a, $fe, $88, $07, $03        ;; 22:589e ????????
    db   $fd, $01, $17, $2d, $43, $59, $00, $00        ;; 22:58a6 ????????
    db   $00, $00, $00, $00, $57, $41, $2b, $15        ;; 22:58ae ????????
    db   $00, $ea, $80, $eb, $ff, $ec, $40, $01        ;; 22:58b6 ????????
    db   $13, $01, $73, $01, $14, $01, $99, $00        ;; 22:58be ????????
    db   $87, $09, $13, $09, $26, $09, $73, $49        ;; 22:58c6 ????????
    db   $9a, $08, $13, $08, $87, $00, $39, $08        ;; 22:58ce ????????
    db   $13, $08, $4d, $00, $13, $08, $14, $08        ;; 22:58d6 ????????
    db   $13, $08, $13, $08, $4d, $00, $3a, $01        ;; 22:58de ????????
    db   $13, $01, $99, $00, $4d, $20, $27, $1e        ;; 22:58e6 ????????
    db   $26, $20, $26, $21, $27, $23, $26, $21        ;; 22:58ee ????????
    db   $27, $20, $26, $0d, $0a, $0d, $09, $0d        ;; 22:58f6 ????????
    db   $0a, $0d, $09, $01, $3a, $01, $13, $01        ;; 22:58fe ????????
    db   $9a, $00, $d3, $0b, $13, $0b, $9a, $00        ;; 22:5906 ????????
    db   $3a, $04, $13, $04, $99, $00, $e7, $12        ;; 22:590e ????????
    db   $13, $14, $13, $17, $13, $1a, $1a, $1e        ;; 22:5916 ????????
    db   $1a, $1c, $19, $17, $13, $19, $26, $1b        ;; 22:591e ????????
    db   $27, $1c, $26, $1e, $27, $20, $99, $0d        ;; 22:5926 ????????
    db   $0a, $00, $09, $08, $d3, $0d, $0a, $00        ;; 22:592e ????????
    db   $0a, $0d, $86, $04, $0a, $04, $09, $04        ;; 22:5936 ????????
    db   $0a, $04, $09, $04, $0a, $04, $0a, $04        ;; 22:593e ????????
    db   $09, $04, $0a, $02, $09, $02, $0a, $02        ;; 22:5946 ????????
    db   $0a, $00, $1c, $02, $0a, $02, $0a, $02        ;; 22:594e ????????
    db   $09, $00, $0a, $02, $09, $00, $0a, $02        ;; 22:5956 ????????
    db   $0a, $02, $09, $02, $0a, $00, $09, $02        ;; 22:595e ????????
    db   $0a, $02, $0a, $02, $09, $00, $1d, $02        ;; 22:5966 ????????
    db   $0a, $02, $09, $02, $0a, $00, $09, $02        ;; 22:596e ????????
    db   $0a, $00, $0a, $02, $09, $02, $0a, $02        ;; 22:5976 ????????
    db   $09, $00, $0a, $01, $0a, $01, $09, $01        ;; 22:597e ????????
    db   $0a, $00, $1d, $01, $09, $01, $0a, $01        ;; 22:5986 ????????
    db   $09, $00, $0a, $01, $0a, $00, $09, $01        ;; 22:598e ????????
    db   $0a, $01, $09, $01, $0a, $00, $0a, $05        ;; 22:5996 ????????
    db   $09, $05, $0a, $05, $09, $00, $1d, $05        ;; 22:599e ????????
    db   $0a, $05, $09, $05, $0a, $00, $0a, $05        ;; 22:59a6 ????????
    db   $09, $00, $0a, $05, $09, $05, $0a, $05        ;; 22:59ae ????????
    db   $0a, $00, $09, $05, $0a, $05, $09, $05        ;; 22:59b6 ????????
    db   $0a, $00, $1d, $05, $09, $05, $0a, $06        ;; 22:59be ????????
    db   $0a, $00, $09, $06, $0a, $00, $09, $06        ;; 22:59c6 ????????
    db   $0a, $06, $0a, $06, $09, $00, $0a, $06        ;; 22:59ce ????????
    db   $09, $00, $0a, $06, $0a, $00, $1c, $06        ;; 22:59d6 ????????
    db   $0a, $00, $0a, $08, $13, $06, $09, $00        ;; 22:59de ????????
    db   $0a, $08, $13, $06, $0a, $00, $09, $05        ;; 22:59e6 ????????
    db   $0a, $05, $0a, $05, $09, $00, $1d, $01        ;; 22:59ee ????????
    db   $0a, $00, $09, $01, $0a, $49, $09, $01        ;; 22:59f6 ????????
    db   $0a, $00, $0a, $01, $09, $01, $0a, $01        ;; 22:59fe ????????
    db   $09, $00, $0a, $01, $0a, $01, $09, $01        ;; 22:5a06 ????????
    db   $0a, $00, $1d, $01, $09, $00, $0a, $0b        ;; 22:5a0e ????????
    db   $09, $00, $0a, $0b, $0a, $00, $09, $0b        ;; 22:5a16 ????????
    db   $0a, $0b, $09, $0b, $0a, $00, $0a, $01        ;; 22:5a1e ????????
    db   $09, $01, $0a, $01, $09, $00, $1d, $01        ;; 22:5a26 ????????
    db   $0a, $00, $09, $01, $0a, $00, $0a, $01        ;; 22:5a2e ????????
    db   $09, $00, $0a, $01, $09, $01, $0a, $01        ;; 22:5a36 ????????
    db   $0a, $00, $09, $01, $0a, $00, $09, $01        ;; 22:5a3e ????????
    db   $0a, $01, $0a, $01, $09, $00, $0a, $01        ;; 22:5a46 ????????
    db   $09, $01, $0a, $01, $0a, $00, $09, $01        ;; 22:5a4e ????????
    db   $0a, $01, $09, $01, $0a, $00, $0a, $01        ;; 22:5a56 ????????
    db   $09, $01, $0a, $01, $09, $00, $0a, $01        ;; 22:5a5e ????????
    db   $0a, $01, $09, $01, $0a, $00, $09, $01        ;; 22:5a66 ????????
    db   $0a, $01, $0a, $01, $09, $00, $0a, $01        ;; 22:5a6e ????????
    db   $09, $01, $0a, $01, $0a, $00, $09, $01        ;; 22:5a76 ????????
    db   $0a, $01, $09, $01, $0a, $00, $0a, $01        ;; 22:5a7e ????????
    db   $09, $01, $0a, $01, $09, $00, $0a, $01        ;; 22:5a86 ????????
    db   $0a, $01, $09, $01, $0a, $00, $09, $01        ;; 22:5a8e ????????
    db   $0a, $01, $0a, $01, $09, $00, $0a, $01        ;; 22:5a96 ????????
    db   $09, $01, $0a, $fe, $e6, $01, $04, $ff        ;; 22:5a9e ????????
    db   $01, $f6, $00, $f6, $80, $f6, $8f, $f5        ;; 22:5aa6 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 22:5aae ????????
    db   $a7, $e2, $a7, $18, $30, $18, $30, $e2        ;; 22:5ab6 ????????
    db   $37, $49, $20, $e2, $a7, $18, $30, $18        ;; 22:5abe ????????
    db   $20, $19, $30, $18, $30, $18, $30, $e2        ;; 22:5ac6 ????????
    db   $37, $49, $20, $e2, $a7, $18, $30, $18        ;; 22:5ace ????????
    db   $20, $19, $30, $e2, $a7, $18, $30, $18        ;; 22:5ad6 ????????
    db   $30, $e2, $37, $49, $20, $e2, $a7, $18        ;; 22:5ade ????????
    db   $30, $18, $20, $19, $30, $18, $30, $18        ;; 22:5ae6 ????????
    db   $30, $e2, $37, $49, $20, $e2, $a7, $18        ;; 22:5aee ????????
    db   $30, $18, $20, $19, $30, $e2, $a7, $18        ;; 22:5af6 ????????
    db   $30, $18, $30, $e2, $37, $49, $20, $e2        ;; 22:5afe ????????
    db   $a7, $18, $30, $18, $20, $19, $30, $18        ;; 22:5b06 ????????
    db   $30, $18, $30, $e2, $37, $49, $20, $e2        ;; 22:5b0e ????????
    db   $a7, $18, $30, $18, $20, $19, $30, $e2        ;; 22:5b16 ????????
    db   $a7, $18, $30, $18, $30, $e2, $37, $49        ;; 22:5b1e ????????
    db   $20, $e2, $a7, $18, $30, $18, $20, $19        ;; 22:5b26 ????????
    db   $30, $18, $30, $18, $30, $e2, $37, $49        ;; 22:5b2e ????????
    db   $20, $e2, $a7, $18, $30, $18, $20, $19        ;; 22:5b36 ????????
    db   $30, $e2, $97, $1d, $30, $1f, $50, $1b        ;; 22:5b3e ????????
    db   $30, $1d, $50, $1d, $30, $1f, $50, $1b        ;; 22:5b46 ????????
    db   $30, $18, $50, $e2, $a7, $18, $30, $18        ;; 22:5b4e ????????
    db   $30, $e2, $37, $49, $20, $e2, $a7, $18        ;; 22:5b56 ????????
    db   $30, $18, $20, $19, $30, $18, $30, $18        ;; 22:5b5e ????????
    db   $30, $e2, $37, $49, $20, $e2, $a7, $18        ;; 22:5b66 ????????
    db   $30, $18, $20, $19, $30, $e2, $37, $49        ;; 22:5b6e ????????
    db   $10, $e2, $a7, $1d, $20, $1d, $20, $1b        ;; 22:5b76 ????????
    db   $20, $18, $10, $e2, $37, $49, $10, $e2        ;; 22:5b7e ????????
    db   $a7, $1d, $20, $1d, $20, $1b, $20, $18        ;; 22:5b86 ????????
    db   $10, $e2, $37, $49, $10, $e2, $a7, $1e        ;; 22:5b8e ????????
    db   $20, $1e, $20, $1d, $20, $19, $10, $e2        ;; 22:5b96 ????????
    db   $37, $49, $10, $e2, $a7, $1e, $20, $1e        ;; 22:5b9e ????????
    db   $20, $1d, $20, $18, $10, $e2, $a7, $18        ;; 22:5ba6 ????????
    db   $30, $18, $30, $e2, $37, $49, $20, $e2        ;; 22:5bae ????????
    db   $a7, $18, $30, $18, $20, $19, $30, $18        ;; 22:5bb6 ????????
    db   $30, $18, $30, $e2, $37, $49, $20, $e2        ;; 22:5bbe ????????
    db   $a7, $18, $30, $18, $20, $19, $30, $fe        ;; 22:5bc6 ????????
    db   $18, $01, $02, $e6, $ff, $e7, $77, $e7        ;; 22:5bce ????????
    db   $07, $49, $10, $e7, $67, $30, $08, $e7        ;; 22:5bd6 ????????
    db   $07, $49, $18, $e7, $67, $30, $20, $e7        ;; 22:5bde ????????
    db   $07, $49, $08, $e7, $67, $30, $08, $30        ;; 22:5be6 ????????
    db   $08, $30, $08, $e7, $07, $49, $20, $e7        ;; 22:5bee ????????
    db   $67, $30, $08, $30, $08, $e7, $07, $49        ;; 22:5bf6 ????????
    db   $08, $e7, $67, $30, $08, $30, $08, $e7        ;; 22:5bfe ????????
    db   $07, $49, $18, $e7, $67, $30, $08, $30        ;; 22:5c06 ????????
    db   $08, $e7, $07, $49, $08, $e7, $67, $30        ;; 22:5c0e ????????
    db   $08, $30, $08, $e7, $07, $49, $18, $e7        ;; 22:5c16 ????????
    db   $67, $30, $08, $e7, $07, $49, $18, $e7        ;; 22:5c1e ????????
    db   $67, $30, $20, $e7, $07, $49, $08, $e7        ;; 22:5c26 ????????
    db   $67, $30, $08, $30, $08, $30, $08, $e7        ;; 22:5c2e ????????
    db   $07, $49, $20, $e7, $67, $30, $04, $30        ;; 22:5c36 ????????
    db   $04, $30, $04, $30, $04, $30, $10, $30        ;; 22:5c3e ????????
    db   $08, $e7, $07, $49, $08, $e7, $67, $30        ;; 22:5c46 ????????
    db   $08, $30, $08, $30, $04, $30, $04, $30        ;; 22:5c4e ????????
    db   $04, $30, $04, $30, $10, $31, $10, $e7        ;; 22:5c56 ????????
    db   $57, $3c, $10, $3c, $08, $3c, $08, $e7        ;; 22:5c5e ????????
    db   $07, $49, $08, $e7, $57, $3c, $08, $3c        ;; 22:5c66 ????????
    db   $10, $3c, $08, $3c, $08, $e7, $07, $49        ;; 22:5c6e ????????
    db   $08, $e7, $57, $3c, $08, $3c, $10, $3c        ;; 22:5c76 ????????
    db   $08, $e7, $07, $49, $08, $e7, $57, $3c        ;; 22:5c7e ????????
    db   $10, $3c, $08, $3c, $08, $e7, $07, $49        ;; 22:5c86 ????????
    db   $08, $e7, $57, $3c, $08, $3c, $10, $3c        ;; 22:5c8e ????????
    db   $08, $3c, $08, $e7, $07, $49, $08, $e7        ;; 22:5c96 ????????
    db   $57, $3c, $08, $3c, $10, $3c, $08, $e7        ;; 22:5c9e ????????
    db   $07, $49, $08, $e7, $57, $3c, $10, $3c        ;; 22:5ca6 ????????
    db   $08, $3c, $08, $e7, $07, $49, $08, $e7        ;; 22:5cae ????????
    db   $57, $3c, $08, $3c, $10, $3c, $08, $3c        ;; 22:5cb6 ????????
    db   $08, $e7, $07, $49, $08, $e7, $57, $3c        ;; 22:5cbe ????????
    db   $08, $3c, $10, $3c, $08, $e7, $07, $49        ;; 22:5cc6 ????????
    db   $08, $e7, $57, $3c, $10, $3c, $08, $3c        ;; 22:5cce ????????
    db   $08, $e7, $07, $49, $08, $e7, $57, $3c        ;; 22:5cd6 ????????
    db   $08, $3c, $10, $3c, $08, $3c, $08, $e7        ;; 22:5cde ????????
    db   $07, $49, $08, $e7, $57, $3c, $08, $3c        ;; 22:5ce6 ????????
    db   $10, $3c, $08, $e7, $07, $49, $08, $49        ;; 22:5cee ????????
    db   $c8, $49, $c8, $49, $70, $e7, $77, $12        ;; 22:5cf6 ????????
    db   $10, $e7, $67, $0d, $08, $0d, $10, $0d        ;; 22:5cfe ????????
    db   $08, $e7, $77, $12, $10, $e7, $67, $0d        ;; 22:5d06 ????????
    db   $08, $0d, $10, $0d, $08, $e7, $77, $13        ;; 22:5d0e ????????
    db   $10, $10, $10, $12, $10, $e7, $67, $0d        ;; 22:5d16 ????????
    db   $08, $0d, $10, $0d, $08, $e7, $77, $12        ;; 22:5d1e ????????
    db   $10, $e7, $67, $0d, $08, $0d, $10, $0d        ;; 22:5d26 ????????
    db   $08, $e7, $77, $13, $20, $12, $10, $e7        ;; 22:5d2e ????????
    db   $67, $0d, $08, $0d, $10, $0d, $08, $e7        ;; 22:5d36 ????????
    db   $77, $12, $10, $e7, $67, $0d, $08, $0d        ;; 22:5d3e ????????
    db   $10, $0d, $08, $e7, $77, $13, $10, $10        ;; 22:5d46 ????????
    db   $10, $12, $10, $e7, $67, $0d, $08, $0d        ;; 22:5d4e ????????
    db   $10, $0d, $08, $e7, $77, $12, $10, $e7        ;; 22:5d56 ????????
    db   $67, $0d, $08, $0d, $10, $0d, $08, $e7        ;; 22:5d5e ????????
    db   $77, $13, $20, $e7, $07, $49, $c8, $49        ;; 22:5d66 ????????
    db   $c8, $49, $70, $e7, $77, $12, $10, $e7        ;; 22:5d6e ????????
    db   $67, $0d, $08, $0d, $10, $0d, $08, $e7        ;; 22:5d76 ????????
    db   $77, $12, $10, $e7, $67, $0d, $08, $0d        ;; 22:5d7e ????????
    db   $10, $0d, $08, $e7, $77, $13, $10, $10        ;; 22:5d86 ????????
    db   $10, $12, $10, $e7, $67, $0d, $08, $0d        ;; 22:5d8e ????????
    db   $10, $0d, $08, $e7, $77, $12, $10, $e7        ;; 22:5d96 ????????
    db   $67, $0d, $08, $0d, $10, $0d, $08, $e7        ;; 22:5d9e ????????
    db   $77, $13, $20, $12, $10, $e7, $67, $0d        ;; 22:5da6 ????????
    db   $08, $0d, $10, $0d, $08, $e7, $77, $12        ;; 22:5dae ????????
    db   $10, $e7, $67, $0d, $08, $0d, $10, $0d        ;; 22:5db6 ????????
    db   $08, $e7, $77, $13, $10, $10, $10, $12        ;; 22:5dbe ????????
    db   $10, $e7, $67, $0d, $08, $0d, $10, $0d        ;; 22:5dc6 ????????
    db   $08, $e7, $77, $12, $10, $e7, $67, $0d        ;; 22:5dce ????????
    db   $08, $0d, $10, $0d, $08, $e7, $77, $13        ;; 22:5dd6 ????????
    db   $20, $e7, $77, $17, $08, $e7, $67, $12        ;; 22:5dde ????????
    db   $08, $12, $08, $12, $10, $12, $08, $e7        ;; 22:5de6 ????????
    db   $77, $17, $08, $e7, $67, $12, $08, $12        ;; 22:5dee ????????
    db   $08, $12, $10, $12, $08, $e7, $77, $18        ;; 22:5df6 ????????
    db   $10, $14, $10, $17, $08, $e7, $67, $12        ;; 22:5dfe ????????
    db   $08, $12, $08, $12, $10, $12, $08, $e7        ;; 22:5e06 ????????
    db   $77, $17, $08, $e7, $67, $12, $08, $12        ;; 22:5e0e ????????
    db   $08, $12, $10, $12, $08, $e7, $77, $18        ;; 22:5e16 ????????
    db   $20, $17, $08, $e7, $67, $12, $08, $12        ;; 22:5e1e ????????
    db   $08, $12, $10, $12, $08, $e7, $77, $17        ;; 22:5e26 ????????
    db   $08, $e7, $67, $12, $08, $12, $08, $12        ;; 22:5e2e ????????
    db   $10, $12, $08, $e7, $77, $18, $08, $e7        ;; 22:5e36 ????????
    db   $67, $14, $08, $e7, $77, $14, $10, $17        ;; 22:5e3e ????????
    db   $08, $e7, $67, $12, $08, $12, $08, $e7        ;; 22:5e46 ????????
    db   $77, $12, $08, $e7, $67, $12, $08, $12        ;; 22:5e4e ????????
    db   $08, $e7, $77, $17, $08, $e7, $67, $12        ;; 22:5e56 ????????
    db   $08, $12, $08, $e7, $77, $12, $08, $e7        ;; 22:5e5e ????????
    db   $67, $12, $08, $12, $08, $e7, $77, $18        ;; 22:5e66 ????????
    db   $08, $18, $08, $1c, $10, $e7, $07, $49        ;; 22:5e6e ????????
    db   $b0, $e7, $77, $12, $10, $e7, $67, $0d        ;; 22:5e76 ????????
    db   $08, $0d, $10, $0d, $08, $e7, $77, $13        ;; 22:5e7e ????????
    db   $20, $e7, $07, $49, $a8, $e7, $67, $0d        ;; 22:5e86 ????????
    db   $08, $e7, $77, $12, $10, $e7, $67, $0d        ;; 22:5e8e ????????
    db   $08, $0d, $10, $0d, $08, $e7, $77, $13        ;; 22:5e96 ????????
    db   $10, $17, $10, $fe, $ce, $02, $03, $fd        ;; 22:5e9e ????????
    db   $01, $17, $2d, $43, $59, $00, $00, $00        ;; 22:5ea6 ????????
    db   $00, $00, $00, $57, $41, $2b, $15, $00        ;; 22:5eae ????????
    db   $ea, $80, $eb, $ff, $ec, $20, $18, $10        ;; 22:5eb6 ????????
    db   $18, $08, $18, $08, $24, $08, $18, $10        ;; 22:5ebe ????????
    db   $18, $10, $18, $08, $18, $08, $18, $08        ;; 22:5ec6 ????????
    db   $22, $10, $18, $10, $18, $10, $18, $08        ;; 22:5ece ????????
    db   $18, $08, $21, $08, $18, $10, $18, $10        ;; 22:5ed6 ????????
    db   $18, $08, $18, $08, $18, $08, $20, $10        ;; 22:5ede ????????
    db   $1f, $10, $18, $10, $18, $08, $18, $08        ;; 22:5ee6 ????????
    db   $24, $08, $18, $10, $18, $10, $18, $08        ;; 22:5eee ????????
    db   $18, $08, $18, $08, $22, $10, $18, $10        ;; 22:5ef6 ????????
    db   $18, $10, $18, $08, $18, $08, $21, $08        ;; 22:5efe ????????
    db   $18, $10, $18, $10, $18, $08, $18, $08        ;; 22:5f06 ????????
    db   $18, $08, $20, $10, $1f, $10, $12, $10        ;; 22:5f0e ????????
    db   $0d, $08, $0d, $10, $0d, $08, $12, $10        ;; 22:5f16 ????????
    db   $0d, $08, $0d, $10, $0d, $08, $13, $10        ;; 22:5f1e ????????
    db   $10, $10, $12, $10, $0d, $08, $0d, $10        ;; 22:5f26 ????????
    db   $0d, $08, $12, $10, $0d, $08, $0d, $10        ;; 22:5f2e ????????
    db   $0d, $08, $13, $20, $12, $10, $0d, $08        ;; 22:5f36 ????????
    db   $0d, $10, $0d, $08, $12, $10, $0d, $08        ;; 22:5f3e ????????
    db   $0d, $10, $0d, $08, $13, $10, $10, $10        ;; 22:5f46 ????????
    db   $12, $10, $0d, $08, $0d, $10, $0d, $08        ;; 22:5f4e ????????
    db   $12, $10, $0d, $08, $0d, $10, $0d, $28        ;; 22:5f56 ????????
    db   $0c, $80, $0c, $40, $19, $20, $25, $20        ;; 22:5f5e ????????
    db   $0c, $80, $0c, $40, $19, $20, $29, $20        ;; 22:5f66 ????????
    db   $30, $20, $30, $28, $30, $08, $30, $08        ;; 22:5f6e ????????
    db   $30, $28, $30, $08, $30, $10, $30, $08        ;; 22:5f76 ????????
    db   $30, $20, $30, $08, $30, $10, $30, $08        ;; 22:5f7e ????????
    db   $30, $20, $30, $20, $30, $28, $30, $08        ;; 22:5f86 ????????
    db   $30, $08, $30, $28, $30, $04, $30, $04        ;; 22:5f8e ????????
    db   $30, $04, $30, $04, $30, $10, $30, $10        ;; 22:5f96 ????????
    db   $30, $08, $30, $08, $30, $04, $30, $04        ;; 22:5f9e ????????
    db   $30, $04, $30, $04, $30, $10, $31, $20        ;; 22:5fa6 ????????
    db   $1d, $10, $1d, $08, $1d, $08, $24, $08        ;; 22:5fae ????????
    db   $1d, $10, $18, $10, $18, $08, $18, $08        ;; 22:5fb6 ????????
    db   $18, $08, $1b, $10, $18, $10, $1b, $10        ;; 22:5fbe ????????
    db   $1b, $08, $1b, $08, $21, $08, $1b, $10        ;; 22:5fc6 ????????
    db   $18, $10, $18, $08, $18, $08, $18, $08        ;; 22:5fce ????????
    db   $1b, $10, $18, $10, $1d, $10, $1d, $08        ;; 22:5fd6 ????????
    db   $1d, $08, $24, $08, $1d, $10, $18, $10        ;; 22:5fde ????????
    db   $18, $08, $18, $08, $18, $08, $1b, $10        ;; 22:5fe6 ????????
    db   $18, $10, $1b, $10, $1b, $08, $1b, $08        ;; 22:5fee ????????
    db   $21, $08, $1b, $10, $18, $10, $18, $08        ;; 22:5ff6 ????????
    db   $18, $08, $18, $08, $1b, $10, $18, $10        ;; 22:5ffe ????????
    db   $12, $10, $0d, $08, $0d, $10, $0d, $08        ;; 22:6006 ????????
    db   $12, $10, $0d, $08, $0d, $10, $0d, $08        ;; 22:600e ????????
    db   $13, $10, $10, $10, $12, $10, $0d, $08        ;; 22:6016 ????????
    db   $0d, $10, $0d, $08, $12, $10, $0d, $08        ;; 22:601e ????????
    db   $0d, $10, $0d, $08, $13, $20, $12, $10        ;; 22:6026 ????????
    db   $0d, $08, $0d, $10, $0d, $08, $12, $10        ;; 22:602e ????????
    db   $0d, $08, $0d, $10, $0d, $08, $13, $10        ;; 22:6036 ????????
    db   $10, $10, $12, $10, $0d, $08, $0d, $10        ;; 22:603e ????????
    db   $0d, $08, $12, $10, $0d, $08, $0d, $10        ;; 22:6046 ????????
    db   $0d, $08, $13, $20, $3c, $10, $3c, $08        ;; 22:604e ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $08        ;; 22:6056 ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $10        ;; 22:605e ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $08        ;; 22:6066 ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $08        ;; 22:606e ????????
    db   $3c, $10, $3c, $10, $3c, $10, $3c, $08        ;; 22:6076 ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $08        ;; 22:607e ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $10        ;; 22:6086 ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $08        ;; 22:608e ????????
    db   $3c, $10, $3c, $08, $3c, $10, $3c, $08        ;; 22:6096 ????????
    db   $3c, $10, $3c, $10, $18, $10, $18, $08        ;; 22:609e ????????
    db   $18, $08, $24, $08, $18, $10, $18, $10        ;; 22:60a6 ????????
    db   $18, $08, $18, $08, $18, $08, $22, $10        ;; 22:60ae ????????
    db   $18, $10, $18, $10, $18, $08, $18, $08        ;; 22:60b6 ????????
    db   $21, $08, $18, $10, $18, $10, $18, $08        ;; 22:60be ????????
    db   $18, $08, $18, $08, $20, $10, $1f, $10        ;; 22:60c6 ????????
    db   $18, $10, $18, $08, $18, $08, $24, $08        ;; 22:60ce ????????
    db   $18, $10, $18, $10, $18, $08, $18, $08        ;; 22:60d6 ????????
    db   $18, $08, $22, $10, $18, $10, $18, $10        ;; 22:60de ????????
    db   $18, $08, $18, $08, $21, $08, $18, $10        ;; 22:60e6 ????????
    db   $18, $10, $18, $08, $18, $08, $18, $08        ;; 22:60ee ????????
    db   $20, $10, $1f, $10, $fe, $40, $02, $04        ;; 22:60f6 ????????
    db   $f0, $14, $f1, $51, $f2, $22, $f3, $80        ;; 22:60fe ????????
    db   $0d, $08, $49, $08, $49, $08, $49, $08        ;; 22:6106 ????????
    db   $0d, $08, $49, $08, $49, $08, $49, $08        ;; 22:610e ????????
    db   $0d, $08, $49, $08, $49, $08, $0d, $08        ;; 22:6116 ????????
    db   $0d, $08, $49, $08, $0d, $08, $49, $08        ;; 22:611e ????????
    db   $0d, $08, $49, $08, $49, $08, $49, $08        ;; 22:6126 ????????
    db   $0d, $08, $49, $08, $0d, $08, $49, $08        ;; 22:612e ????????
    db   $49, $08, $49, $08, $0d, $08, $49, $08        ;; 22:6136 ????????
    db   $49, $08, $0d, $08, $49, $08, $49, $08        ;; 22:613e ????????
    db   $fe, $44, $00, $01, $f5, $ff, $f4, $77        ;; 22:6146 ???.....
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $b7        ;; 22:614e ........
    db   $19, $01, $e2, $07, $49, $78, $ff, $01        ;; 22:6156 .......?
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:615e ????????
    db   $e2, $77, $00, $1e, $e2, $47, $3d, $01        ;; 22:6166 ????????
    db   $31, $01, $3d, $01, $31, $01, $3d, $01        ;; 22:616e ????????
    db   $e2, $07, $49, $78, $ff, $01, $f5, $ff        ;; 22:6176 ????????
    db   $f4, $77, $e0, $7e, $e1, $ff, $e2, $77        ;; 22:617e ????????
    db   $e2, $b7, $48, $01, $0d, $01, $48, $01        ;; 22:6186 ????????
    db   $0d, $01, $48, $01, $0d, $01, $48, $01        ;; 22:618e ????????
    db   $0d, $01, $48, $01, $0d, $01, $48, $01        ;; 22:6196 ????????
    db   $0d, $01, $49, $2d, $00, $78, $ff, $01        ;; 22:619e ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:61a6 ????????
    db   $e2, $77, $e2, $17, $2a, $01, $2e, $01        ;; 22:61ae ????????
    db   $31, $01, $36, $01, $e2, $37, $2a, $01        ;; 22:61b6 ????????
    db   $2e, $01, $31, $01, $36, $01, $e2, $57        ;; 22:61be ????????
    db   $2a, $01, $2e, $01, $31, $01, $36, $01        ;; 22:61c6 ????????
    db   $e2, $37, $2a, $01, $2e, $01, $31, $01        ;; 22:61ce ????????
    db   $36, $01, $e2, $17, $2a, $01, $2e, $01        ;; 22:61d6 ????????
    db   $31, $01, $36, $02, $e2, $07, $49, $78        ;; 22:61de ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:61e6 ????????
    db   $e1, $ff, $e2, $77, $e2, $17, $2a, $01        ;; 22:61ee ????????
    db   $36, $01, $2e, $01, $3a, $01, $31, $01        ;; 22:61f6 ????????
    db   $3d, $01, $36, $01, $42, $01, $e2, $37        ;; 22:61fe ????????
    db   $2a, $01, $36, $01, $2e, $01, $3a, $01        ;; 22:6206 ????????
    db   $31, $01, $3d, $01, $36, $01, $42, $01        ;; 22:620e ????????
    db   $e2, $57, $2a, $01, $36, $01, $2e, $01        ;; 22:6216 ????????
    db   $3a, $01, $31, $01, $3d, $01, $36, $01        ;; 22:621e ????????
    db   $42, $01, $e2, $37, $2a, $01, $36, $01        ;; 22:6226 ????????
    db   $2e, $01, $3a, $01, $31, $01, $3d, $01        ;; 22:622e ????????
    db   $36, $01, $42, $01, $e2, $17, $2a, $01        ;; 22:6236 ????????
    db   $36, $01, $2e, $01, $3a, $01, $31, $01        ;; 22:623e ????????
    db   $3d, $01, $36, $01, $42, $01, $49, $78        ;; 22:6246 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:624e ????????
    db   $e1, $ff, $e2, $77, $00, $0c, $ff, $01        ;; 22:6256 ???????.
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:625e ........
    db   $e2, $77, $e2, $57, $25, $05, $24, $05        ;; 22:6266 ........
    db   $25, $05, $27, $05, $25, $05, $27, $05        ;; 22:626e ........
    db   $29, $05, $e2, $07, $49, $02, $e2, $57        ;; 22:6276 ........
    db   $29, $03, $e2, $07, $49, $02, $e2, $57        ;; 22:627e ........
    db   $29, $03, $e2, $07, $49, $02, $e2, $57        ;; 22:6286 ........
    db   $29, $03, $e2, $07, $49, $02, $e2, $07        ;; 22:628e ........
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:6296 ..??????
    db   $e0, $00, $e1, $ff, $e2, $77, $00, $0c        ;; 22:629e ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:62a6 ????????
    db   $e1, $ff, $e2, $77, $00, $0c, $ff, $01        ;; 22:62ae ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:62b6 ????????
    db   $e2, $77, $e2, $57, $19, $01, $25, $01        ;; 22:62be ????????
    db   $e2, $07, $49, $1e, $ff, $01, $f5, $ff        ;; 22:62c6 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:62ce ????????
    db   $e2, $57, $01, $01, $e2, $07, $49, $1e        ;; 22:62d6 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $76        ;; 22:62de ????????
    db   $e1, $ff, $e2, $77, $e2, $b7, $01, $01        ;; 22:62e6 ????????
    db   $19, $01, $0d, $01, $25, $01, $19, $01        ;; 22:62ee ????????
    db   $31, $01, $25, $01, $3d, $01, $49, $2d        ;; 22:62f6 ????????
    db   $00, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 22:62fe ???.....
    db   $e0, $17, $e1, $ff, $e2, $77, $e2, $57        ;; 22:6306 ........
    db   $25, $01, $28, $01, $27, $01, $29, $01        ;; 22:630e ........
    db   $2a, $01, $2b, $01, $2c, $01, $2d, $01        ;; 22:6316 ........
    db   $2e, $01, $2f, $01, $30, $01, $31, $01        ;; 22:631e ........
    db   $e2, $07, $49, $1e, $ff, $01, $f5, $ff        ;; 22:6326 ........
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:632e ........
    db   $e2, $57, $25, $01, $26, $01, $27, $01        ;; 22:6336 ........
    db   $29, $01, $2a, $01, $2b, $01, $2c, $01        ;; 22:633e ........
    db   $2d, $01, $2e, $01, $2f, $01, $30, $01        ;; 22:6346 ........
    db   $31, $01, $34, $01, $33, $01, $35, $01        ;; 22:634e ........
    db   $36, $01, $37, $01, $38, $01, $39, $01        ;; 22:6356 ........
    db   $3a, $01, $3b, $01, $3c, $01, $3d, $01        ;; 22:635e ........
    db   $3e, $01, $e2, $47, $3f, $01, $41, $01        ;; 22:6366 ........
    db   $e2, $47, $42, $01, $43, $01, $e2, $37        ;; 22:636e ........
    db   $44, $01, $45, $01, $e2, $27, $46, $01        ;; 22:6376 ........
    db   $47, $01, $e2, $17, $48, $01, $e2, $07        ;; 22:637e ........
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:6386 ...?????
    db   $e0, $7c, $e1, $ff, $e2, $77, $e2, $b7        ;; 22:638e ????????
    db   $25, $0f, $24, $0f, $23, $0f, $49, $2d        ;; 22:6396 ????????
    db   $00, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 22:639e ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 22:63a6 ????????
    db   $3d, $05, $3c, $05, $3b, $05, $3a, $05        ;; 22:63ae ????????
    db   $3c, $04, $3b, $04, $3a, $04, $39, $04        ;; 22:63b6 ????????
    db   $3b, $03, $3a, $03, $39, $02, $38, $02        ;; 22:63be ????????
    db   $37, $01, $36, $01, $35, $01, $34, $01        ;; 22:63c6 ????????
    db   $33, $01, $32, $01, $31, $01, $30, $01        ;; 22:63ce ????????
    db   $2e, $01, $e2, $47, $2c, $01, $2a, $01        ;; 22:63d6 ????????
    db   $e2, $37, $28, $01, $26, $01, $e2, $27        ;; 22:63de ????????
    db   $24, $01, $22, $01, $e2, $17, $20, $01        ;; 22:63e6 ????????
    db   $1e, $01, $e2, $07, $1c, $01, $e2, $07        ;; 22:63ee ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:63f6 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 22:63fe ????????
    db   $22, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:6406 ????????
    db   $28, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:640e ????????
    db   $22, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:6416 ????????
    db   $28, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:641e ????????
    db   $22, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:6426 ????????
    db   $28, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:642e ????????
    db   $22, $01, $e2, $07, $49, $01, $e2, $57        ;; 22:6436 ????????
    db   $28, $01, $e2, $07, $49, $1e, $ff, $01        ;; 22:643e ???????.
    db   $f5, $ff, $f4, $77, $e0, $17, $e1, $ff        ;; 22:6446 ........
    db   $e2, $c7, $e2, $17, $3d, $01, $31, $01        ;; 22:644e ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:6456 ........
    db   $3d, $01, $31, $01, $e2, $27, $25, $01        ;; 22:645e ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:6466 ........
    db   $19, $01, $25, $01, $19, $01, $e2, $37        ;; 22:646e ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:6476 ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:647e ........
    db   $e2, $47, $25, $01, $19, $01, $25, $01        ;; 22:6486 ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:648e ........
    db   $19, $01, $e2, $57, $3d, $01, $31, $01        ;; 22:6496 ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:649e ........
    db   $3d, $01, $31, $01, $e2, $67, $25, $01        ;; 22:64a6 ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:64ae ........
    db   $19, $01, $25, $01, $19, $01, $e2, $77        ;; 22:64b6 ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:64be ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:64c6 ........
    db   $e2, $87, $25, $01, $19, $01, $25, $01        ;; 22:64ce ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:64d6 ........
    db   $19, $01, $e2, $97, $3d, $01, $31, $01        ;; 22:64de ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:64e6 ........
    db   $3d, $01, $31, $01, $e2, $a7, $25, $01        ;; 22:64ee ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:64f6 ........
    db   $19, $01, $25, $01, $19, $01, $e2, $b7        ;; 22:64fe ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:6506 ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:650e ........
    db   $e2, $c7, $25, $01, $19, $01, $25, $01        ;; 22:6516 ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:651e ........
    db   $19, $01, $e2, $b7, $3d, $01, $31, $01        ;; 22:6526 ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:652e ........
    db   $3d, $01, $31, $01, $e2, $a7, $25, $01        ;; 22:6536 ........
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:653e ........
    db   $19, $01, $25, $01, $19, $01, $e2, $97        ;; 22:6546 ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:654e ........
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:6556 ..??????
    db   $e2, $87, $25, $01, $19, $01, $25, $01        ;; 22:655e ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:6566 ????????
    db   $19, $01, $e2, $77, $3d, $01, $31, $01        ;; 22:656e ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:6576 ????????
    db   $3d, $01, $31, $01, $e2, $67, $25, $01        ;; 22:657e ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:6586 ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $57        ;; 22:658e ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:6596 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:659e ????????
    db   $e2, $47, $25, $01, $19, $01, $25, $01        ;; 22:65a6 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:65ae ????????
    db   $19, $01, $e2, $37, $3d, $01, $31, $01        ;; 22:65b6 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:65be ????????
    db   $3d, $01, $31, $01, $e2, $27, $25, $01        ;; 22:65c6 ????????
    db   $19, $01, $25, $01, $19, $01, $25, $01        ;; 22:65ce ????????
    db   $19, $01, $25, $01, $19, $01, $e2, $17        ;; 22:65d6 ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:65de ????????
    db   $3d, $01, $31, $01, $3d, $01, $31, $01        ;; 22:65e6 ????????
    db   $e2, $07, $49, $1e, $ff, $01, $f5, $ff        ;; 22:65ee ????????
    db   $f4, $77, $e0, $7f, $e1, $ff, $e2, $77        ;; 22:65f6 ????????
    db   $e2, $b7, $19, $05, $18, $05, $17, $05        ;; 22:65fe ????????
    db   $18, $05, $17, $05, $16, $05, $17, $05        ;; 22:6606 ????????
    db   $16, $05, $15, $05, $49, $0f, $00, $78        ;; 22:660e ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:6616 ????????
    db   $e1, $ff, $e2, $77, $e2, $b7, $19, $01        ;; 22:661e ????????
    db   $e2, $d0, $00, $01, $00, $03, $e2, $b7        ;; 22:6626 ????????
    db   $02, $04, $e2, $d0, $00, $01, $e2, $b7        ;; 22:662e ????????
    db   $19, $01, $e2, $d0, $00, $01, $00, $03        ;; 22:6636 ????????
    db   $e2, $b7, $02, $04, $e2, $d0, $00, $01        ;; 22:663e ????????
    db   $e2, $b7, $1a, $01, $e2, $d0, $00, $01        ;; 22:6646 ????????
    db   $00, $03, $e2, $b7, $02, $04, $e2, $d0        ;; 22:664e ????????
    db   $00, $01, $e2, $b7, $19, $01, $e2, $d0        ;; 22:6656 ????????
    db   $00, $01, $00, $03, $e2, $b7, $02, $04        ;; 22:665e ????????
    db   $e2, $d0, $00, $01, $00, $78, $ff, $01        ;; 22:6666 ????????
    db   $f5, $ff, $f4, $77, $e0, $17, $e1, $ff        ;; 22:666e ????????
    db   $e2, $77, $e2, $17, $20, $04, $14, $04        ;; 22:6676 ????????
    db   $e2, $27, $21, $04, $15, $04, $e2, $37        ;; 22:667e ????????
    db   $22, $04, $16, $04, $e2, $47, $23, $04        ;; 22:6686 ????????
    db   $17, $04, $e2, $57, $24, $04, $18, $04        ;; 22:668e ????????
    db   $e2, $07, $49, $1e, $ff, $01, $f5, $ff        ;; 22:6696 ????????
    db   $f4, $77, $e0, $1f, $e1, $ff, $e2, $77        ;; 22:669e ????????
    db   $e2, $17, $24, $04, $18, $04, $e2, $27        ;; 22:66a6 ????????
    db   $23, $04, $17, $04, $e2, $37, $22, $04        ;; 22:66ae ????????
    db   $16, $04, $e2, $47, $21, $04, $15, $04        ;; 22:66b6 ????????
    db   $e2, $57, $20, $04, $14, $04, $e2, $07        ;; 22:66be ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:66c6 ????????
    db   $e0, $1f, $e1, $ff, $e2, $77, $e2, $17        ;; 22:66ce ????????
    db   $24, $14, $e2, $07, $49, $1e, $ff, $01        ;; 22:66d6 ???????.
    db   $f5, $ff, $f4, $77, $e0, $1f, $e1, $ff        ;; 22:66de ........
    db   $e2, $77, $e2, $50, $24, $05, $23, $05        ;; 22:66e6 ........
    db   $22, $14, $e2, $07, $49, $1e, $ff, $04        ;; 22:66ee .......?
    db   $f5, $ff, $f4, $77, $f0, $13, $f1, $57        ;; 22:66f6 ????????
    db   $f2, $27, $f1, $57, $f2, $27, $19, $78        ;; 22:66fe ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:6706 ????????
    db   $e1, $ff, $e2, $77, $00, $0c, $ff, $01        ;; 22:670e ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:6716 ????????
    db   $e2, $77, $e2, $57, $01, $05, $49, $14        ;; 22:671e ????????
    db   $e2, $07, $49, $1e, $ff, $01, $f5, $ff        ;; 22:6726 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:672e ????????
    db   $e2, $b7, $31, $03, $3d, $01, $49, $2d        ;; 22:6736 ????????
    db   $00, $78, $ff, $02, $e6, $ff, $e7, $77        ;; 22:673e ????????
    db   $e7, $57, $00, $78, $ff, $01, $f5, $ff        ;; 22:6746 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:674e ????????
    db   $e2, $57, $01, $05, $49, $14, $e2, $07        ;; 22:6756 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:675e ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $17        ;; 22:6766 ????????
    db   $25, $01, $e2, $27, $24, $01, $e2, $37        ;; 22:676e ????????
    db   $25, $01, $e2, $47, $24, $01, $e2, $57        ;; 22:6776 ????????
    db   $25, $01, $e2, $67, $24, $01, $e2, $57        ;; 22:677e ????????
    db   $25, $01, $e2, $37, $24, $01, $e2, $27        ;; 22:6786 ????????
    db   $25, $01, $e2, $17, $24, $01, $ff, $01        ;; 22:678e ????????
    db   $f5, $ff, $f4, $77, $e0, $7f, $e1, $ff        ;; 22:6796 ????????
    db   $e2, $77, $31, $01, $49, $3c, $ff, $04        ;; 22:679e ????????
    db   $f5, $ff, $f4, $77, $f0, $13, $f1, $57        ;; 22:67a6 ????????
    db   $f2, $27, $f3, $80, $f1, $5f, $f2, $27        ;; 22:67ae ????????
    db   $19, $78, $f2, $2f, $3d, $78, $f2, $77        ;; 22:67b6 ????????
    db   $19, $78, $f2, $7f, $3d, $78, $f1, $57        ;; 22:67be ????????
    db   $f2, $27, $19, $78, $f2, $2f, $19, $78        ;; 22:67c6 ????????
    db   $f2, $77, $19, $78, $f2, $7f, $19, $78        ;; 22:67ce ????????
    db   $f1, $57, $f2, $27, $19, $78, $f2, $2f        ;; 22:67d6 ????????
    db   $19, $78, $f2, $77, $19, $78, $f2, $7f        ;; 22:67de ????????
    db   $19, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 22:67e6 ????????
    db   $e0, $7f, $e1, $ff, $e2, $77, $31, $01        ;; 22:67ee ????????
    db   $49, $3c, $ff, $01, $f5, $ff, $f4, $77        ;; 22:67f6 ????????
    db   $e0, $7f, $e1, $ff, $e2, $77, $e2, $27        ;; 22:67fe ????????
    db   $19, $02, $e2, $2f, $3d, $02, $e2, $77        ;; 22:6806 ????????
    db   $19, $02, $e2, $7f, $3d, $02, $e2, $27        ;; 22:680e ????????
    db   $19, $02, $e2, $2f, $19, $02, $e2, $77        ;; 22:6816 ????????
    db   $19, $02, $e2, $7f, $19, $02, $e2, $27        ;; 22:681e ????????
    db   $19, $02, $e2, $2f, $19, $02, $e2, $77        ;; 22:6826 ????????
    db   $19, $02, $e2, $7f, $19, $02, $ff, $01        ;; 22:682e ????????
    db   $f5, $ff, $f4, $77, $e0, $4d, $e1, $ff        ;; 22:6836 ????????
    db   $e2, $77, $31, $01, $49, $3c, $ff, $01        ;; 22:683e ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:6846 ????????
    db   $e2, $77, $00, $78, $e2, $77, $49, $03        ;; 22:684e ????????
    db   $31, $0a, $49, $32, $e2, $07, $ff, $02        ;; 22:6856 ????????
    db   $e6, $ff, $e7, $77, $00, $78, $ff, $01        ;; 22:685e ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:6866 ????????
    db   $e2, $77, $e2, $57, $10, $05, $0f, $01        ;; 22:686e ????????
    db   $11, $01, $12, $01, $13, $01, $14, $01        ;; 22:6876 ????????
    db   $15, $01, $16, $01, $17, $01, $18, $01        ;; 22:687e ????????
    db   $19, $01, $e2, $07, $49, $1e, $ff, $01        ;; 22:6886 ????????
    db   $f5, $ff, $f4, $77, $e0, $77, $e1, $ff        ;; 22:688e ????????
    db   $e2, $77, $2a, $06, $2e, $06, $31, $0b        ;; 22:6896 ????????
    db   $ff, $02, $e6, $ff, $e7, $77, $00, $78        ;; 22:689e ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $77        ;; 22:68a6 ????????
    db   $e1, $ff, $e2, $77, $31, $01, $49, $3c        ;; 22:68ae ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $7f        ;; 22:68b6 ????????
    db   $e1, $ff, $e2, $77, $19, $06, $14, $06        ;; 22:68be ????????
    db   $0e, $06, $ff, $01, $f5, $ff, $f4, $77        ;; 22:68c6 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 22:68ce ????????
    db   $1d, $07, $19, $07, $16, $07, $e2, $07        ;; 22:68d6 ????????
    db   $e2, $47, $1d, $07, $19, $07, $16, $07        ;; 22:68de ????????
    db   $e2, $07, $e2, $37, $1d, $07, $19, $07        ;; 22:68e6 ????????
    db   $16, $07, $e2, $07, $e2, $27, $1d, $07        ;; 22:68ee ????????
    db   $19, $07, $16, $07, $e2, $07, $e2, $17        ;; 22:68f6 ????????
    db   $1d, $07, $19, $07, $16, $07, $e2, $07        ;; 22:68fe ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:6906 ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $57        ;; 22:690e ????????
    db   $10, $05, $0f, $01, $11, $01, $12, $01        ;; 22:6916 ????????
    db   $13, $01, $14, $01, $15, $01, $16, $01        ;; 22:691e ????????
    db   $17, $01, $18, $01, $19, $01, $e2, $07        ;; 22:6926 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:692e ????????
    db   $e0, $77, $e1, $ff, $e2, $77, $19, $0f        ;; 22:6936 ????????
    db   $26, $0f, $33, $2d, $ff, $01, $f5, $ff        ;; 22:693e ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:6946 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:694e ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:6956 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:695e ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:6966 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:696e ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:6976 ????????
    db   $08, $02, $05, $02, $08, $02, $05, $02        ;; 22:697e ????????
    db   $08, $02, $05, $02, $ff, $01, $f5, $ff        ;; 22:6986 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:698e ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:6996 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:699e ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:69a6 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:69ae ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:69b6 ????????
    db   $e1, $ff, $e2, $77, $e2, $57, $01, $05        ;; 22:69be ????????
    db   $49, $14, $e2, $07, $49, $1e, $ff, $01        ;; 22:69c6 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:69ce ????????
    db   $e2, $77, $e2, $b7, $01, $03, $19, $01        ;; 22:69d6 ????????
    db   $49, $2d, $00, $78, $ff, $04, $f0, $87        ;; 22:69de ????????
    db   $f1, $e1, $f2, $eb, $00, $78, $49, $1e        ;; 22:69e6 ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:69ee ????????
    db   $e1, $ff, $e2, $77, $e2, $17, $25, $01        ;; 22:69f6 ????????
    db   $e2, $27, $24, $01, $e2, $37, $25, $01        ;; 22:69fe ????????
    db   $e2, $47, $24, $01, $e2, $57, $25, $01        ;; 22:6a06 ????????
    db   $e2, $67, $24, $01, $e2, $57, $25, $01        ;; 22:6a0e ????????
    db   $e2, $37, $24, $01, $e2, $27, $25, $01        ;; 22:6a16 ????????
    db   $e2, $17, $24, $01, $ff, $01, $f5, $ff        ;; 22:6a1e ????????
    db   $f4, $77, $e0, $17, $e1, $ff, $e2, $77        ;; 22:6a26 ????????
    db   $e2, $57, $25, $01, $28, $01, $27, $01        ;; 22:6a2e ????????
    db   $29, $01, $2a, $01, $2b, $01, $2c, $01        ;; 22:6a36 ????????
    db   $2d, $01, $2e, $01, $2f, $01, $30, $01        ;; 22:6a3e ????????
    db   $31, $01, $e2, $07, $49, $1e, $ff, $01        ;; 22:6a46 ????????
    db   $f5, $ff, $f4, $77, $e0, $00, $e1, $ff        ;; 22:6a4e ????????
    db   $e2, $77, $e2, $97, $0d, $01, $e2, $87        ;; 22:6a56 ????????
    db   $0c, $01, $e2, $77, $0d, $01, $e2, $67        ;; 22:6a5e ????????
    db   $0c, $01, $e2, $57, $0d, $01, $e2, $47        ;; 22:6a66 ????????
    db   $0c, $01, $e2, $37, $0d, $01, $e2, $27        ;; 22:6a6e ????????
    db   $0c, $01, $e2, $17, $0d, $01, $e2, $07        ;; 22:6a76 ????????
    db   $0c, $01, $ff, $04, $f5, $ff, $f4, $77        ;; 22:6a7e ????????
    db   $f0, $13, $f1, $57, $f2, $27, $f2, $27        ;; 22:6a86 ????????
    db   $f1, $1b, $19, $0a, $f1, $37, $19, $1e        ;; 22:6a8e ????????
    db   $49, $78, $ff, $01, $f5, $ff, $f4, $77        ;; 22:6a96 ????????
    db   $e0, $3b, $e1, $ff, $e2, $77, $e2, $57        ;; 22:6a9e ????????
    db   $31, $04, $30, $04, $2f, $04, $2e, $04        ;; 22:6aa6 ????????
    db   $e2, $37, $30, $04, $2f, $04, $2e, $04        ;; 22:6aae ????????
    db   $2d, $04, $e2, $17, $2f, $04, $2e, $04        ;; 22:6ab6 ????????
    db   $2d, $04, $49, $14, $e2, $07, $49, $78        ;; 22:6abe ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $7f        ;; 22:6ac6 ????????
    db   $e1, $ff, $e2, $77, $19, $01, $49, $3c        ;; 22:6ace ????????
    db   $ff, $01, $f5, $ff, $f4, $77, $e0, $00        ;; 22:6ad6 ????????
    db   $e1, $ff, $e2, $77, $0d, $02, $0a, $02        ;; 22:6ade ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:6ae6 ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:6aee ????????
    db   $0d, $02, $0a, $02, $0d, $02, $0a, $02        ;; 22:6af6 ????????
    db   $0d, $02, $0a, $02, $ff, $01, $f5, $ff        ;; 22:6afe ????????
    db   $f4, $77, $e0, $7f, $e1, $ff, $e2, $77        ;; 22:6b06 ????????
    db   $31, $01, $49, $3c, $ff, $01, $f5, $ff        ;; 22:6b0e ????????
    db   $f4, $77, $e0, $7f, $e1, $ff, $e2, $77        ;; 22:6b16 ????????
    db   $e2, $f7, $01, $0a, $0d, $01, $e2, $f7        ;; 22:6b1e ????????
    db   $0c, $01, $e2, $f7, $0d, $01, $e2, $f7        ;; 22:6b26 ????????
    db   $0c, $01, $e2, $e7, $0d, $01, $e2, $d7        ;; 22:6b2e ????????
    db   $0c, $01, $e2, $c7, $0d, $01, $e2, $b7        ;; 22:6b36 ????????
    db   $0c, $01, $e2, $97, $0d, $01, $e2, $87        ;; 22:6b3e ????????
    db   $0c, $01, $e2, $77, $0d, $01, $e2, $67        ;; 22:6b46 ????????
    db   $0c, $01, $e2, $57, $0d, $01, $e2, $47        ;; 22:6b4e ????????
    db   $0c, $01, $e2, $37, $0d, $01, $e2, $27        ;; 22:6b56 ????????
    db   $0c, $01, $e2, $17, $0d, $01, $e2, $07        ;; 22:6b5e ????????
    db   $0c, $01, $49, $2d, $ff, $01, $f5, $ff        ;; 22:6b66 ????????
    db   $f4, $77, $e0, $00, $e1, $ff, $e2, $77        ;; 22:6b6e ????????
    db   $e2, $57, $01, $05, $49, $14, $e2, $07        ;; 22:6b76 ????????
    db   $49, $1e, $ff, $01, $f5, $ff, $f4, $77        ;; 22:6b7e ????????
    db   $e0, $00, $e1, $ff, $e2, $77, $e2, $13        ;; 22:6b86 ????????
    db   $25, $0a, $3d, $32, $e2, $07, $49, $1e        ;; 22:6b8e ????????
    db   $ff, $01, $00, $0a, $ff, $02, $00, $0a        ;; 22:6b96 ????????
    db   $ff, $03, $00, $0a, $ff, $04, $00, $0a        ;; 22:6b9e ????????
    db   $ff                                           ;; 22:6ba6 ?
