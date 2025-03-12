;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; Note: All of the code in this file is identical in banks 0x21, 0x22, 0x23, and 0x24. This is a duplicated 
; audio engine. The data that follows the code is different and contains different songs or sound effects.

SECTION "bank23", ROMX[$4000], BANK[$23]

entry_23_4000:
    ld   HL, data_23_4460                              ;; 23:4000 $21 $60 $44
    ld   A, L                                          ;; 23:4003 $7d
    ld   [wDFAE], A                                    ;; 23:4004 $ea $ae $df
    ld   A, H                                          ;; 23:4007 $7c
    ld   [wDFAF], A                                    ;; 23:4008 $ea $af $df
    xor  A, A                                          ;; 23:400b $af
    ld   [wDFC2], A                                    ;; 23:400c $ea $c2 $df
    ld   [wDFC1], A                                    ;; 23:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 23:4012 $e0 $25
    ld   [wDFB8], A                                    ;; 23:4014 $ea $b8 $df
    ld   [wDFB9], A                                    ;; 23:4017 $ea $b9 $df
    ld   [wDFBA], A                                    ;; 23:401a $ea $ba $df
    ld   [wDFBB], A                                    ;; 23:401d $ea $bb $df
    ld   [wDFBC], A                                    ;; 23:4020 $ea $bc $df
    ld   [wDFCF], A                                    ;; 23:4023 $ea $cf $df
    ld   [wDFCB], A                                    ;; 23:4026 $ea $cb $df
    ld   [wDFCC], A                                    ;; 23:4029 $ea $cc $df
    ld   [wDFCD], A                                    ;; 23:402c $ea $cd $df
    ld   [wDFCE], A                                    ;; 23:402f $ea $ce $df
    ld   HL, wDFD2                                     ;; 23:4032 $21 $d2 $df
    ld   C, $14                                        ;; 23:4035 $0e $14
    xor  A, A                                          ;; 23:4037 $af
jr_23_4038:
    ld   [HL+], A                                      ;; 23:4038 $22
    dec  C                                             ;; 23:4039 $0d
    jr   NZ, jr_23_4038                                ;; 23:403a $20 $fc
    ld   HL, wDFE6                                     ;; 23:403c $21 $e6 $df
    ld   C, $10                                        ;; 23:403f $0e $10
    xor  A, A                                          ;; 23:4041 $af
.jr_23_4042:
    ld   [HL+], A                                      ;; 23:4042 $22
    dec  C                                             ;; 23:4043 $0d
    jr   NZ, .jr_23_4042                               ;; 23:4044 $20 $fc
    ret                                                ;; 23:4046 $c9

call_23_4047:
    ld   [wDFD0], A                                    ;; 23:4047 $ea $d0 $df
    ld   A, $01                                        ;; 23:404a $3e $01
    ld   [wDFD1], A                                    ;; 23:404c $ea $d1 $df
    ld   A, [wDFD0]                                    ;; 23:404f $fa $d0 $df
    sla  A                                             ;; 23:4052 $cb $27
    ld   E, A                                          ;; 23:4054 $5f
    sla  A                                             ;; 23:4055 $cb $27
    ld   C, A                                          ;; 23:4057 $4f
    sla  A                                             ;; 23:4058 $cb $27
    add  A, E                                          ;; 23:405a $83
    ld   DE, data_23_439e                              ;; 23:405b $11 $9e $43
    add  A, E                                          ;; 23:405e $83
    ld   E, A                                          ;; 23:405f $5f
    jr   NC, .jr_23_4063                               ;; 23:4060 $30 $01
    inc  D                                             ;; 23:4062 $14
.jr_23_4063:
    ld   HL, wDFD2                                     ;; 23:4063 $21 $d2 $df
    ld   A, [wDFD0]                                    ;; 23:4066 $fa $d0 $df
    add  A, C                                          ;; 23:4069 $81
    add  A, L                                          ;; 23:406a $85
    ld   L, A                                          ;; 23:406b $6f
    jr   NC, .jr_23_406f                               ;; 23:406c $30 $01
    inc  H                                             ;; 23:406e $24
.jr_23_406f:
    ld   B, $ff                                        ;; 23:406f $06 $ff
.jr_23_4071:
    ld   A, [DE]                                       ;; 23:4071 $1a
    and  A, A                                          ;; 23:4072 $a7
    jr   Z, .jr_23_407f                                ;; 23:4073 $28 $0a
    inc  DE                                            ;; 23:4075 $13
    ld   C, A                                          ;; 23:4076 $4f
    ld   A, [BC]                                       ;; 23:4077 $0a
    ld   C, A                                          ;; 23:4078 $4f
    ld   A, [DE]                                       ;; 23:4079 $1a
    inc  DE                                            ;; 23:407a $13
    and  A, C                                          ;; 23:407b $a1
    ld   [HL+], A                                      ;; 23:407c $22
    jr   .jr_23_4071                                   ;; 23:407d $18 $f2
.jr_23_407f:
    ld   A, [wDFAE]                                    ;; 23:407f $fa $ae $df
    ld   E, A                                          ;; 23:4082 $5f
    ld   A, [wDFAF]                                    ;; 23:4083 $fa $af $df
    ld   D, A                                          ;; 23:4086 $57
    ld   A, [DE]                                       ;; 23:4087 $1a
    add  A, E                                          ;; 23:4088 $83
    ld   L, A                                          ;; 23:4089 $6f
    inc  DE                                            ;; 23:408a $13
    ld   A, [DE]                                       ;; 23:408b $1a
    dec  DE                                            ;; 23:408c $1b
    adc  A, D                                          ;; 23:408d $8a
    ld   D, A                                          ;; 23:408e $57
    ld   E, L                                          ;; 23:408f $5d
    jr   jr_23_40a4                                    ;; 23:4090 $18 $12

call_23_4092:
    ld   [wDFD0], A                                    ;; 23:4092 $ea $d0 $df
    ld   A, $02                                        ;; 23:4095 $3e $02
    ld   [wDFD1], A                                    ;; 23:4097 $ea $d1 $df
    ld   A, [wDFAE]                                    ;; 23:409a $fa $ae $df
    ld   E, A                                          ;; 23:409d $5f
    ld   A, [wDFAF]                                    ;; 23:409e $fa $af $df
    ld   D, A                                          ;; 23:40a1 $57
    inc  DE                                            ;; 23:40a2 $13
    inc  DE                                            ;; 23:40a3 $13

jr_23_40a4:
    ld   A, [wDFD0]                                    ;; 23:40a4 $fa $d0 $df
    add  A, A                                          ;; 23:40a7 $87
    ld   L, A                                          ;; 23:40a8 $6f
    ld   A, D                                          ;; 23:40a9 $7a
    adc  A, $00                                        ;; 23:40aa $ce $00
    ld   D, A                                          ;; 23:40ac $57
    ld   A, E                                          ;; 23:40ad $7b
    add  A, L                                          ;; 23:40ae $85
    ld   E, A                                          ;; 23:40af $5f
    ld   A, D                                          ;; 23:40b0 $7a
    adc  A, $00                                        ;; 23:40b1 $ce $00
    ld   D, A                                          ;; 23:40b3 $57
    ld   A, [DE]                                       ;; 23:40b4 $1a
    add  A, E                                          ;; 23:40b5 $83
    ld   L, A                                          ;; 23:40b6 $6f
    inc  DE                                            ;; 23:40b7 $13
    ld   A, [DE]                                       ;; 23:40b8 $1a
    dec  DE                                            ;; 23:40b9 $1b
    adc  A, D                                          ;; 23:40ba $8a
    ld   D, A                                          ;; 23:40bb $57
    ld   E, L                                          ;; 23:40bc $5d
    ld   A, [DE]                                       ;; 23:40bd $1a
    ld   [wDFFE], A                                    ;; 23:40be $ea $fe $df
    ld   L, A                                          ;; 23:40c1 $6f
    xor  A, A                                          ;; 23:40c2 $af
    scf                                                ;; 23:40c3 $37
.jr_23_40c4:
    rl   A                                             ;; 23:40c4 $cb $17
    dec  L                                             ;; 23:40c6 $2d
    jr   NZ, .jr_23_40c4                               ;; 23:40c7 $20 $fb
    ld   [wDFC1], A                                    ;; 23:40c9 $ea $c1 $df
    ld   L, A                                          ;; 23:40cc $6f
    ld   A, [wDFD1]                                    ;; 23:40cd $fa $d1 $df
    cp   A, $01                                        ;; 23:40d0 $fe $01
    jr   NZ, .jr_23_40e3                               ;; 23:40d2 $20 $0f
    ld   A, [wDFCF]                                    ;; 23:40d4 $fa $cf $df
    or   A, L                                          ;; 23:40d7 $b5
    ld   [wDFCF], A                                    ;; 23:40d8 $ea $cf $df
    ld   HL, wDFC3                                     ;; 23:40db $21 $c3 $df
    ld   BC, wDFCB                                     ;; 23:40de $01 $cb $df
    jr   .jr_23_40f0                                   ;; 23:40e1 $18 $0d
.jr_23_40e3:
    ld   A, [wDFC2]                                    ;; 23:40e3 $fa $c2 $df
    or   A, L                                          ;; 23:40e6 $b5
    ld   [wDFC2], A                                    ;; 23:40e7 $ea $c2 $df
    ld   HL, wDFB0                                     ;; 23:40ea $21 $b0 $df
    ld   BC, wDFB9                                     ;; 23:40ed $01 $b9 $df
.jr_23_40f0:
    ld   A, [DE]                                       ;; 23:40f0 $1a
    dec  A                                             ;; 23:40f1 $3d
    sla  A                                             ;; 23:40f2 $cb $27
    add  A, L                                          ;; 23:40f4 $85
    ld   L, A                                          ;; 23:40f5 $6f
    jr   NC, .jr_23_40f9                               ;; 23:40f6 $30 $01
    inc  H                                             ;; 23:40f8 $24
.jr_23_40f9:
    ld   A, [DE]                                       ;; 23:40f9 $1a
    dec  A                                             ;; 23:40fa $3d
    add  A, C                                          ;; 23:40fb $81
    ld   C, A                                          ;; 23:40fc $4f
    jr   NC, .jr_23_4100                               ;; 23:40fd $30 $01
    inc  B                                             ;; 23:40ff $04
.jr_23_4100:
    inc  DE                                            ;; 23:4100 $13
    ld   [HL], E                                       ;; 23:4101 $73
    inc  HL                                            ;; 23:4102 $23
    ld   [HL], D                                       ;; 23:4103 $72
    dec  HL                                            ;; 23:4104 $2b
    push BC                                            ;; 23:4105 $c5
    call call_23_4199                                  ;; 23:4106 $cd $99 $41
    pop  BC                                            ;; 23:4109 $c1
    ld   [BC], A                                       ;; 23:410a $02
    ret                                                ;; 23:410b $c9

call_23_410c:
    ld   BC, wDFB9                                     ;; 23:410c $01 $b9 $df
    ld   HL, wDFB0                                     ;; 23:410f $21 $b0 $df
    ld   A, $01                                        ;; 23:4112 $3e $01
    ld   [wDFC1], A                                    ;; 23:4114 $ea $c1 $df
    ld   A, $00                                        ;; 23:4117 $3e $00
    ld   [wDFB8], A                                    ;; 23:4119 $ea $b8 $df
    ld   A, $02                                        ;; 23:411c $3e $02
    ld   [wDFD1], A                                    ;; 23:411e $ea $d1 $df
.jp_23_4121:
    push BC                                            ;; 23:4121 $c5
    ld   A, [wDFC1]                                    ;; 23:4122 $fa $c1 $df
    ld   D, A                                          ;; 23:4125 $57
    ld   A, [wDFC2]                                    ;; 23:4126 $fa $c2 $df
    and  A, D                                          ;; 23:4129 $a2
    jr   Z, .jr_23_4139                                ;; 23:412a $28 $0d
    ld   A, [BC]                                       ;; 23:412c $0a
    dec  A                                             ;; 23:412d $3d
    jr   NZ, .jr_23_4139                               ;; 23:412e $20 $09
    ld   A, [wDFB8]                                    ;; 23:4130 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 23:4133 $ea $fe $df
    call call_23_4199                                  ;; 23:4136 $cd $99 $41
.jr_23_4139:
    pop  BC                                            ;; 23:4139 $c1
    ld   [BC], A                                       ;; 23:413a $02
    inc  BC                                            ;; 23:413b $03
    inc  HL                                            ;; 23:413c $23
    inc  HL                                            ;; 23:413d $23
    ld   A, [wDFC1]                                    ;; 23:413e $fa $c1 $df
    sla  A                                             ;; 23:4141 $cb $27
    ld   [wDFC1], A                                    ;; 23:4143 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 23:4146 $fa $b8 $df
    inc  A                                             ;; 23:4149 $3c
    ld   [wDFB8], A                                    ;; 23:414a $ea $b8 $df
    cp   A, $04                                        ;; 23:414d $fe $04
    jp   NZ, .jp_23_4121                               ;; 23:414f $c2 $21 $41
    ld   BC, wDFCB                                     ;; 23:4152 $01 $cb $df
    ld   HL, wDFC3                                     ;; 23:4155 $21 $c3 $df
    ld   A, $01                                        ;; 23:4158 $3e $01
    ld   [wDFC1], A                                    ;; 23:415a $ea $c1 $df
    ld   A, $00                                        ;; 23:415d $3e $00
    ld   [wDFB8], A                                    ;; 23:415f $ea $b8 $df
    ld   A, $01                                        ;; 23:4162 $3e $01
    ld   [wDFD1], A                                    ;; 23:4164 $ea $d1 $df
.jp_23_4167:
    push BC                                            ;; 23:4167 $c5
    ld   A, [wDFC1]                                    ;; 23:4168 $fa $c1 $df
    ld   D, A                                          ;; 23:416b $57
    ld   A, [wDFCF]                                    ;; 23:416c $fa $cf $df
    and  A, D                                          ;; 23:416f $a2
    jr   Z, .jr_23_417f                                ;; 23:4170 $28 $0d
    ld   A, [BC]                                       ;; 23:4172 $0a
    dec  A                                             ;; 23:4173 $3d
    jr   NZ, .jr_23_417f                               ;; 23:4174 $20 $09
    ld   A, [wDFB8]                                    ;; 23:4176 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 23:4179 $ea $fe $df
    call call_23_4199                                  ;; 23:417c $cd $99 $41
.jr_23_417f:
    pop  BC                                            ;; 23:417f $c1
    ld   [BC], A                                       ;; 23:4180 $02
    inc  BC                                            ;; 23:4181 $03
    inc  HL                                            ;; 23:4182 $23
    inc  HL                                            ;; 23:4183 $23
    ld   A, [wDFC1]                                    ;; 23:4184 $fa $c1 $df
    sla  A                                             ;; 23:4187 $cb $27
    ld   [wDFC1], A                                    ;; 23:4189 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 23:418c $fa $b8 $df
    inc  A                                             ;; 23:418f $3c
    ld   [wDFB8], A                                    ;; 23:4190 $ea $b8 $df
    cp   A, $04                                        ;; 23:4193 $fe $04
    jp   NZ, .jp_23_4167                               ;; 23:4195 $c2 $67 $41
    ret                                                ;; 23:4198 $c9

call_23_4199:
    ld   C, [HL]                                       ;; 23:4199 $4e
    inc  HL                                            ;; 23:419a $23
    ld   B, [HL]                                       ;; 23:419b $46
.jp_23_419c:
    ld   A, [BC]                                       ;; 23:419c $0a
    cp   A, $fe                                        ;; 23:419d $fe $fe
    jr   NZ, .jr_23_41ae                               ;; 23:419f $20 $0d
    inc  BC                                            ;; 23:41a1 $03
    ld   A, [BC]                                       ;; 23:41a2 $0a
    ld   E, A                                          ;; 23:41a3 $5f
    inc  BC                                            ;; 23:41a4 $03
    ld   A, [BC]                                       ;; 23:41a5 $0a
    ld   D, A                                          ;; 23:41a6 $57
    ld   A, C                                          ;; 23:41a7 $79
    sub  A, E                                          ;; 23:41a8 $93
    ld   C, A                                          ;; 23:41a9 $4f
    ld   A, B                                          ;; 23:41aa $78
    sbc  A, D                                          ;; 23:41ab $9a
    ld   B, A                                          ;; 23:41ac $47
    ld   A, [BC]                                       ;; 23:41ad $0a
.jr_23_41ae:
    inc  BC                                            ;; 23:41ae $03
    cp   A, $ff                                        ;; 23:41af $fe $ff
    jp   NZ, .jp_23_426f                               ;; 23:41b1 $c2 $6f $42
    ld   A, [wDFC1]                                    ;; 23:41b4 $fa $c1 $df
    cpl                                                ;; 23:41b7 $2f
    ld   E, A                                          ;; 23:41b8 $5f
    ld   A, [wDFD1]                                    ;; 23:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 23:41bc $fe $01
    jp   NZ, .jp_23_4253                               ;; 23:41be $c2 $53 $42
    ld   A, [wDFCF]                                    ;; 23:41c1 $fa $cf $df
    and  A, E                                          ;; 23:41c4 $a3
    ld   [wDFCF], A                                    ;; 23:41c5 $ea $cf $df
    ld   A, [wDFC2]                                    ;; 23:41c8 $fa $c2 $df
    ld   E, A                                          ;; 23:41cb $5f
    ld   A, [wDFC1]                                    ;; 23:41cc $fa $c1 $df
    and  A, E                                          ;; 23:41cf $a3
    jp   Z, .jp_23_4265                                ;; 23:41d0 $ca $65 $42
    push HL                                            ;; 23:41d3 $e5
    push BC                                            ;; 23:41d4 $c5
    ld   B, $ff                                        ;; 23:41d5 $06 $ff
    ld   DE, wDFD2                                     ;; 23:41d7 $11 $d2 $df
    ld   A, [wDFFE]                                    ;; 23:41da $fa $fe $df
    sla  A                                             ;; 23:41dd $cb $27
    sla  A                                             ;; 23:41df $cb $27
    add  A, E                                          ;; 23:41e1 $83
    ld   E, A                                          ;; 23:41e2 $5f
    ld   A, [wDFFE]                                    ;; 23:41e3 $fa $fe $df
    add  A, E                                          ;; 23:41e6 $83
    ld   E, A                                          ;; 23:41e7 $5f
    ld   HL, data_23_439e                              ;; 23:41e8 $21 $9e $43
    ld   A, [wDFFE]                                    ;; 23:41eb $fa $fe $df
    sla  A                                             ;; 23:41ee $cb $27
    ld   C, A                                          ;; 23:41f0 $4f
    sla  A                                             ;; 23:41f1 $cb $27
    sla  A                                             ;; 23:41f3 $cb $27
    add  A, C                                          ;; 23:41f5 $81
    add  A, L                                          ;; 23:41f6 $85
    ld   L, A                                          ;; 23:41f7 $6f
    jr   NC, .jr_23_41fb                               ;; 23:41f8 $30 $01
    inc  H                                             ;; 23:41fa $24
.jr_23_41fb:
    ld   A, [HL+]                                      ;; 23:41fb $2a
    and  A, A                                          ;; 23:41fc $a7
    jr   Z, .jr_23_4206                                ;; 23:41fd $28 $07
    ld   C, A                                          ;; 23:41ff $4f
    ld   A, [DE]                                       ;; 23:4200 $1a
    ld   [BC], A                                       ;; 23:4201 $02
    inc  DE                                            ;; 23:4202 $13
    inc  HL                                            ;; 23:4203 $23
    jr   .jr_23_41fb                                   ;; 23:4204 $18 $f5
.jr_23_4206:
    ld   A, [wDFC1]                                    ;; 23:4206 $fa $c1 $df
    cp   A, $04                                        ;; 23:4209 $fe $04
    jr   NZ, .jr_23_421b                               ;; 23:420b $20 $0e
    ld   HL, wDFE6                                     ;; 23:420d $21 $e6 $df
    ld   DE, $ff30                                     ;; 23:4210 $11 $30 $ff
    ld   C, $10                                        ;; 23:4213 $0e $10
.jr_23_4215:
    ld   A, [HL+]                                      ;; 23:4215 $2a
    ld   [DE], A                                       ;; 23:4216 $12
    inc  DE                                            ;; 23:4217 $13
    dec  C                                             ;; 23:4218 $0d
    jr   NZ, .jr_23_4215                               ;; 23:4219 $20 $fa
.jr_23_421b:
    ld   HL, wDFF6                                     ;; 23:421b $21 $f6 $df
    ld   A, [wDFFE]                                    ;; 23:421e $fa $fe $df
    sla  A                                             ;; 23:4221 $cb $27
    add  A, L                                          ;; 23:4223 $85
    ld   L, A                                          ;; 23:4224 $6f
    ld   A, [wDFC1]                                    ;; 23:4225 $fa $c1 $df
    dec  A                                             ;; 23:4228 $3d
    ld   DE, data_23_43c6                              ;; 23:4229 $11 $c6 $43
    add  A, E                                          ;; 23:422c $83
    ld   E, A                                          ;; 23:422d $5f
    jr   NC, .jr_23_4231                               ;; 23:422e $30 $01
    inc  D                                             ;; 23:4230 $14
.jr_23_4231:
    ld   A, [DE]                                       ;; 23:4231 $1a
    ld   E, A                                          ;; 23:4232 $5f
    ld   D, $ff                                        ;; 23:4233 $16 $ff
    ld   A, [wDFC1]                                    ;; 23:4235 $fa $c1 $df
    cp   A, $08                                        ;; 23:4238 $fe $08
    jr   NZ, .jr_23_4244                               ;; 23:423a $20 $08
    inc  HL                                            ;; 23:423c $23
    ld   [DE], A                                       ;; 23:423d $12
    ldh  A, [rNR42]                                    ;; 23:423e $f0 $21
    ldh  [rNR42], A                                    ;; 23:4240 $e0 $21
    jr   .jr_23_424e                                   ;; 23:4242 $18 $0a
.jr_23_4244:
    ld   A, [HL+]                                      ;; 23:4244 $2a
    ld   [DE], A                                       ;; 23:4245 $12
    inc  DE                                            ;; 23:4246 $13
    ld   A, [DE]                                       ;; 23:4247 $1a
    and  A, $c0                                        ;; 23:4248 $e6 $c0
    ld   C, A                                          ;; 23:424a $4f
    ld   A, [HL]                                       ;; 23:424b $7e
    or   A, C                                          ;; 23:424c $b1
    ld   [DE], A                                       ;; 23:424d $12
.jr_23_424e:
    pop  BC                                            ;; 23:424e $c1
    pop  HL                                            ;; 23:424f $e1
    jp   .jp_23_4392                                   ;; 23:4250 $c3 $92 $43
.jp_23_4253:
    ld   A, [wDFC2]                                    ;; 23:4253 $fa $c2 $df
    and  A, E                                          ;; 23:4256 $a3
    ld   [wDFC2], A                                    ;; 23:4257 $ea $c2 $df
    ld   A, [wDFCF]                                    ;; 23:425a $fa $cf $df
    ld   E, A                                          ;; 23:425d $5f
    ld   A, [wDFC1]                                    ;; 23:425e $fa $c1 $df
    and  A, E                                          ;; 23:4261 $a3
    jp   NZ, .jp_23_4392                               ;; 23:4262 $c2 $92 $43
.jp_23_4265:
    ldh  A, [rNR52]                                    ;; 23:4265 $f0 $26
    and  A, $8f                                        ;; 23:4267 $e6 $8f
    and  A, E                                          ;; 23:4269 $a3
    ldh  [rNR52], A                                    ;; 23:426a $e0 $26
    jp   .jp_23_4392                                   ;; 23:426c $c3 $92 $43
.jp_23_426f:
    cp   A, $fd                                        ;; 23:426f $fe $fd
    jr   NZ, .jr_23_4284                               ;; 23:4271 $20 $11
    push HL                                            ;; 23:4273 $e5
    ld   DE, $ff30                                     ;; 23:4274 $11 $30 $ff
    ld   L, $10                                        ;; 23:4277 $2e $10
.jr_23_4279:
    ld   A, [BC]                                       ;; 23:4279 $0a
    inc  BC                                            ;; 23:427a $03
    ld   [DE], A                                       ;; 23:427b $12
    inc  DE                                            ;; 23:427c $13
    dec  L                                             ;; 23:427d $2d
    jr   NZ, .jr_23_4279                               ;; 23:427e $20 $f9
    pop  HL                                            ;; 23:4280 $e1
    jp   .jp_23_419c                                   ;; 23:4281 $c3 $9c $41
.jr_23_4284:
    cp   A, $a0                                        ;; 23:4284 $fe $a0
    jr   C, .jr_23_42bb                                ;; 23:4286 $38 $33
    cp   A, $c0                                        ;; 23:4288 $fe $c0
    jr   NC, .jr_23_429c                               ;; 23:428a $30 $10
    sub  A, $90                                        ;; 23:428c $d6 $90
    ld   E, A                                          ;; 23:428e $5f
    ld   D, $ff                                        ;; 23:428f $16 $ff
    ld   A, [DE]                                       ;; 23:4291 $1a
    ld   D, A                                          ;; 23:4292 $57
    ld   A, [BC]                                       ;; 23:4293 $0a
    and  A, D                                          ;; 23:4294 $a2
    ld   D, $ff                                        ;; 23:4295 $16 $ff
    ld   [DE], A                                       ;; 23:4297 $12
    inc  BC                                            ;; 23:4298 $03
    jp   .jp_23_419c                                   ;; 23:4299 $c3 $9c $41
.jr_23_429c:
    cp   A, $e0                                        ;; 23:429c $fe $e0
    jr   NC, .jr_23_42b0                               ;; 23:429e $30 $10
    sub  A, $b0                                        ;; 23:42a0 $d6 $b0
    ld   E, A                                          ;; 23:42a2 $5f
    ld   D, $ff                                        ;; 23:42a3 $16 $ff
    ld   A, [DE]                                       ;; 23:42a5 $1a
    ld   D, A                                          ;; 23:42a6 $57
    ld   A, [BC]                                       ;; 23:42a7 $0a
    or   A, D                                          ;; 23:42a8 $b2
    ld   D, $ff                                        ;; 23:42a9 $16 $ff
    ld   [DE], A                                       ;; 23:42ab $12
    inc  BC                                            ;; 23:42ac $03
    jp   .jp_23_419c                                   ;; 23:42ad $c3 $9c $41
.jr_23_42b0:
    sub  A, $d0                                        ;; 23:42b0 $d6 $d0
    ld   E, A                                          ;; 23:42b2 $5f
    ld   D, $ff                                        ;; 23:42b3 $16 $ff
    ld   A, [BC]                                       ;; 23:42b5 $0a
    inc  BC                                            ;; 23:42b6 $03
    ld   [DE], A                                       ;; 23:42b7 $12
    jp   .jp_23_419c                                   ;; 23:42b8 $c3 $9c $41
.jr_23_42bb:
    cp   A, $49                                        ;; 23:42bb $fe $49
    jp   Z, .jp_23_4369                                ;; 23:42bd $ca $69 $43
    sla  A                                             ;; 23:42c0 $cb $27
    ld   [wDFBF], A                                    ;; 23:42c2 $ea $bf $df
    ld   A, [wDFC1]                                    ;; 23:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 23:42c8 $d6 $01
    ld   [wDFC0], A                                    ;; 23:42ca $ea $c0 $df
    ld   A, [wDFBF]                                    ;; 23:42cd $fa $bf $df
    and  A, A                                          ;; 23:42d0 $a7
    jr   NZ, .jr_23_42ff                               ;; 23:42d1 $20 $2c
    ld   A, [wDFD1]                                    ;; 23:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 23:42d6 $fe $01
    jr   Z, .jr_23_42e4                                ;; 23:42d8 $28 $0a
    ld   A, [wDFCF]                                    ;; 23:42da $fa $cf $df
    ld   E, A                                          ;; 23:42dd $5f
    ld   A, [wDFC1]                                    ;; 23:42de $fa $c1 $df
    and  A, E                                          ;; 23:42e1 $a3
    jr   NZ, .jr_23_42ff                               ;; 23:42e2 $20 $1b
.jr_23_42e4:
    ld   A, [wDFC1]                                    ;; 23:42e4 $fa $c1 $df
    cpl                                                ;; 23:42e7 $2f
    ld   E, A                                          ;; 23:42e8 $5f
    ldh  A, [rNR52]                                    ;; 23:42e9 $f0 $26
    and  A, $8f                                        ;; 23:42eb $e6 $8f
    and  A, E                                          ;; 23:42ed $a3
    ldh  [rNR52], A                                    ;; 23:42ee $e0 $26
    ld   A, [wDFC1]                                    ;; 23:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 23:42f3 $fe $04
    jr   NZ, .jr_23_42fa                               ;; 23:42f5 $20 $03
    xor  A, A                                          ;; 23:42f7 $af
    ldh  [rNR30], A                                    ;; 23:42f8 $e0 $1a
.jr_23_42fa:
    ld   A, [BC]                                       ;; 23:42fa $0a
    inc  BC                                            ;; 23:42fb $03
    jp   .jp_23_4392                                   ;; 23:42fc $c3 $92 $43
.jr_23_42ff:
    ld   DE, data_23_43ce                              ;; 23:42ff $11 $ce $43
    add  A, E                                          ;; 23:4302 $83
    ld   E, A                                          ;; 23:4303 $5f
    jr   NC, .jr_23_4307                               ;; 23:4304 $30 $01
    inc  D                                             ;; 23:4306 $14
.jr_23_4307:
    ld   A, [DE]                                       ;; 23:4307 $1a
    ld   [wDFBD], A                                    ;; 23:4308 $ea $bd $df
    inc  DE                                            ;; 23:430b $13
    ld   A, [DE]                                       ;; 23:430c $1a
    ld   [wDFBE], A                                    ;; 23:430d $ea $be $df
    ld   DE, wDFF6                                     ;; 23:4310 $11 $f6 $df
    ld   A, [wDFFE]                                    ;; 23:4313 $fa $fe $df
    sla  A                                             ;; 23:4316 $cb $27
    add  A, E                                          ;; 23:4318 $83
    ld   E, A                                          ;; 23:4319 $5f
    ld   A, [wDFBD]                                    ;; 23:431a $fa $bd $df
    ld   [DE], A                                       ;; 23:431d $12
    ld   A, [wDFBE]                                    ;; 23:431e $fa $be $df
    or   A, $80                                        ;; 23:4321 $f6 $80
    ld   [DE], A                                       ;; 23:4323 $12
    ld   A, [wDFD1]                                    ;; 23:4324 $fa $d1 $df
    cp   A, $01                                        ;; 23:4327 $fe $01
    jr   Z, .jr_23_4335                                ;; 23:4329 $28 $0a
    ld   A, [wDFCF]                                    ;; 23:432b $fa $cf $df
    ld   E, A                                          ;; 23:432e $5f
    ld   A, [wDFC1]                                    ;; 23:432f $fa $c1 $df
    and  A, E                                          ;; 23:4332 $a3
    jr   NZ, .jr_23_4390                               ;; 23:4333 $20 $5b
.jr_23_4335:
    ld   A, [wDFC0]                                    ;; 23:4335 $fa $c0 $df
    ld   DE, data_23_43c6                              ;; 23:4338 $11 $c6 $43
    add  A, E                                          ;; 23:433b $83
    ld   E, A                                          ;; 23:433c $5f
    jr   NC, .jr_23_4340                               ;; 23:433d $30 $01
    inc  D                                             ;; 23:433f $14
.jr_23_4340:
    ld   A, [DE]                                       ;; 23:4340 $1a
    ld   E, A                                          ;; 23:4341 $5f
    ld   D, $ff                                        ;; 23:4342 $16 $ff
    ld   A, [wDFC1]                                    ;; 23:4344 $fa $c1 $df
    cp   A, $08                                        ;; 23:4347 $fe $08
    jr   NZ, .jr_23_4357                               ;; 23:4349 $20 $0c
    ld   A, [wDFBE]                                    ;; 23:434b $fa $be $df
    or   A, $80                                        ;; 23:434e $f6 $80
    ld   [DE], A                                       ;; 23:4350 $12
    ldh  A, [rNR42]                                    ;; 23:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 23:4353 $e0 $21
    jr   .jp_23_4369                                   ;; 23:4355 $18 $12
.jr_23_4357:
    ld   A, [wDFBD]                                    ;; 23:4357 $fa $bd $df
    ld   [DE], A                                       ;; 23:435a $12
    inc  DE                                            ;; 23:435b $13
    push DE                                            ;; 23:435c $d5
    ld   A, [DE]                                       ;; 23:435d $1a
    and  A, $c0                                        ;; 23:435e $e6 $c0
    ld   D, A                                          ;; 23:4360 $57
    ld   A, [wDFBE]                                    ;; 23:4361 $fa $be $df
    or   A, $80                                        ;; 23:4364 $f6 $80
    or   A, D                                          ;; 23:4366 $b2
    pop  DE                                            ;; 23:4367 $d1
    ld   [DE], A                                       ;; 23:4368 $12
.jp_23_4369:
    ld   A, [wDFD1]                                    ;; 23:4369 $fa $d1 $df
    cp   A, $02                                        ;; 23:436c $fe $02
    jr   NZ, .jr_23_4376                               ;; 23:436e $20 $06
    ld   A, [wDFCF]                                    ;; 23:4370 $fa $cf $df
    and  A, E                                          ;; 23:4373 $a3
    jr   NZ, .jr_23_4390                               ;; 23:4374 $20 $1a
.jr_23_4376:
    ld   A, [wDFC1]                                    ;; 23:4376 $fa $c1 $df
    ld   E, A                                          ;; 23:4379 $5f
    ldh  A, [rNR52]                                    ;; 23:437a $f0 $26
    and  A, $8f                                        ;; 23:437c $e6 $8f
    or   A, E                                          ;; 23:437e $b3
    ldh  [rNR52], A                                    ;; 23:437f $e0 $26
    ld   A, [wDFC1]                                    ;; 23:4381 $fa $c1 $df
    cp   A, $04                                        ;; 23:4384 $fe $04
    jr   NZ, .jr_23_4390                               ;; 23:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 23:4388 $f0 $1a
    and  A, $80                                        ;; 23:438a $e6 $80
    or   A, $80                                        ;; 23:438c $f6 $80
    ldh  [rNR30], A                                    ;; 23:438e $e0 $1a
.jr_23_4390:
    ld   A, [BC]                                       ;; 23:4390 $0a
    inc  BC                                            ;; 23:4391 $03
.jp_23_4392:
    ld   [HL], B                                       ;; 23:4392 $70
    dec  HL                                            ;; 23:4393 $2b
    ld   [HL], C                                       ;; 23:4394 $71
    ret                                                ;; 23:4395 $c9

    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 23:4396 ????????

data_23_439e:
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 21:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 21:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 21:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 21:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 21:43be ????????

data_23_43c6:
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 21:43c6 ????????

data_23_43ce:
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
    
data_23_4460:
audio_bank23.bin:
    INCBIN "audio/audio_bank23.bin"
