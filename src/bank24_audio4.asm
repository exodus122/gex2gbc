;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; Note: All of the code in this file is identical in banks 0x21, 0x22, 0x23, and 0x24. This is a duplicated 
; audio engine. The data that follows the code is different and contains different songs or sound effects.

SECTION "bank24", ROMX[$4000], BANK[$24]
entry_24_4000:
    ld   HL, data_24_4460                              ;; 24:4000 $21 $60 $44
    ld   A, L                                          ;; 24:4003 $7d
    ld   [wDFAE], A                                    ;; 24:4004 $ea $ae $df
    ld   A, H                                          ;; 24:4007 $7c
    ld   [wDFAF], A                                    ;; 24:4008 $ea $af $df
    xor  A, A                                          ;; 24:400b $af
    ld   [wDFC2], A                                    ;; 24:400c $ea $c2 $df
    ld   [wDFC1], A                                    ;; 24:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 24:4012 $e0 $25
    ld   [wDFB8], A                                    ;; 24:4014 $ea $b8 $df
    ld   [wDFB9], A                                    ;; 24:4017 $ea $b9 $df
    ld   [wDFBA], A                                    ;; 24:401a $ea $ba $df
    ld   [wDFBB], A                                    ;; 24:401d $ea $bb $df
    ld   [wDFBC], A                                    ;; 24:4020 $ea $bc $df
    ld   [wDFCF], A                                    ;; 24:4023 $ea $cf $df
    ld   [wDFCB], A                                    ;; 24:4026 $ea $cb $df
    ld   [wDFCC], A                                    ;; 24:4029 $ea $cc $df
    ld   [wDFCD], A                                    ;; 24:402c $ea $cd $df
    ld   [wDFCE], A                                    ;; 24:402f $ea $ce $df
    ld   HL, wDFD2                                     ;; 24:4032 $21 $d2 $df
    ld   C, $14                                        ;; 24:4035 $0e $14
    xor  A, A                                          ;; 24:4037 $af
jr_24_4038:
    ld   [HL+], A                                      ;; 24:4038 $22
    dec  C                                             ;; 24:4039 $0d
    jr   NZ, jr_24_4038                                ;; 24:403a $20 $fc
    ld   HL, wDFE6                                     ;; 24:403c $21 $e6 $df
    ld   C, $10                                        ;; 24:403f $0e $10
    xor  A, A                                          ;; 24:4041 $af
.jr_24_4042:
    ld   [HL+], A                                      ;; 24:4042 $22
    dec  C                                             ;; 24:4043 $0d
    jr   NZ, .jr_24_4042                               ;; 24:4044 $20 $fc
    ret                                                ;; 24:4046 $c9

call_24_4047:
    ld   [wDFD0], A                                    ;; 24:4047 $ea $d0 $df
    ld   A, $01                                        ;; 24:404a $3e $01
    ld   [wDFD1], A                                    ;; 24:404c $ea $d1 $df
    ld   A, [wDFD0]                                    ;; 24:404f $fa $d0 $df
    sla  A                                             ;; 24:4052 $cb $27
    ld   E, A                                          ;; 24:4054 $5f
    sla  A                                             ;; 24:4055 $cb $27
    ld   C, A                                          ;; 24:4057 $4f
    sla  A                                             ;; 24:4058 $cb $27
    add  A, E                                          ;; 24:405a $83
    ld   DE, data_24_439e                              ;; 24:405b $11 $9e $43
    add  A, E                                          ;; 24:405e $83
    ld   E, A                                          ;; 24:405f $5f
    jr   NC, .jr_24_4063                               ;; 24:4060 $30 $01
    inc  D                                             ;; 24:4062 $14
.jr_24_4063:
    ld   HL, wDFD2                                     ;; 24:4063 $21 $d2 $df
    ld   A, [wDFD0]                                    ;; 24:4066 $fa $d0 $df
    add  A, C                                          ;; 24:4069 $81
    add  A, L                                          ;; 24:406a $85
    ld   L, A                                          ;; 24:406b $6f
    jr   NC, .jr_24_406f                               ;; 24:406c $30 $01
    inc  H                                             ;; 24:406e $24
.jr_24_406f:
    ld   B, $ff                                        ;; 24:406f $06 $ff
.jr_24_4071:
    ld   A, [DE]                                       ;; 24:4071 $1a
    and  A, A                                          ;; 24:4072 $a7
    jr   Z, .jr_24_407f                                ;; 24:4073 $28 $0a
    inc  DE                                            ;; 24:4075 $13
    ld   C, A                                          ;; 24:4076 $4f
    ld   A, [BC]                                       ;; 24:4077 $0a
    ld   C, A                                          ;; 24:4078 $4f
    ld   A, [DE]                                       ;; 24:4079 $1a
    inc  DE                                            ;; 24:407a $13
    and  A, C                                          ;; 24:407b $a1
    ld   [HL+], A                                      ;; 24:407c $22
    jr   .jr_24_4071                                   ;; 24:407d $18 $f2
.jr_24_407f:
    ld   A, [wDFAE]                                    ;; 24:407f $fa $ae $df
    ld   E, A                                          ;; 24:4082 $5f
    ld   A, [wDFAF]                                    ;; 24:4083 $fa $af $df
    ld   D, A                                          ;; 24:4086 $57
    ld   A, [DE]                                       ;; 24:4087 $1a
    add  A, E                                          ;; 24:4088 $83
    ld   L, A                                          ;; 24:4089 $6f
    inc  DE                                            ;; 24:408a $13
    ld   A, [DE]                                       ;; 24:408b $1a
    dec  DE                                            ;; 24:408c $1b
    adc  A, D                                          ;; 24:408d $8a
    ld   D, A                                          ;; 24:408e $57
    ld   E, L                                          ;; 24:408f $5d
    jr   jr_24_40a4                                    ;; 24:4090 $18 $12

call_24_4092:
    ld   [wDFD0], A                                    ;; 24:4092 $ea $d0 $df
    ld   A, $02                                        ;; 24:4095 $3e $02
    ld   [wDFD1], A                                    ;; 24:4097 $ea $d1 $df
    ld   A, [wDFAE]                                    ;; 24:409a $fa $ae $df
    ld   E, A                                          ;; 24:409d $5f
    ld   A, [wDFAF]                                    ;; 24:409e $fa $af $df
    ld   D, A                                          ;; 24:40a1 $57
    inc  DE                                            ;; 24:40a2 $13
    inc  DE                                            ;; 24:40a3 $13

jr_24_40a4:
    ld   A, [wDFD0]                                    ;; 24:40a4 $fa $d0 $df
    add  A, A                                          ;; 24:40a7 $87
    ld   L, A                                          ;; 24:40a8 $6f
    ld   A, D                                          ;; 24:40a9 $7a
    adc  A, $00                                        ;; 24:40aa $ce $00
    ld   D, A                                          ;; 24:40ac $57
    ld   A, E                                          ;; 24:40ad $7b
    add  A, L                                          ;; 24:40ae $85
    ld   E, A                                          ;; 24:40af $5f
    ld   A, D                                          ;; 24:40b0 $7a
    adc  A, $00                                        ;; 24:40b1 $ce $00
    ld   D, A                                          ;; 24:40b3 $57
    ld   A, [DE]                                       ;; 24:40b4 $1a
    add  A, E                                          ;; 24:40b5 $83
    ld   L, A                                          ;; 24:40b6 $6f
    inc  DE                                            ;; 24:40b7 $13
    ld   A, [DE]                                       ;; 24:40b8 $1a
    dec  DE                                            ;; 24:40b9 $1b
    adc  A, D                                          ;; 24:40ba $8a
    ld   D, A                                          ;; 24:40bb $57
    ld   E, L                                          ;; 24:40bc $5d
    ld   A, [DE]                                       ;; 24:40bd $1a
    ld   [wDFFE], A                                    ;; 24:40be $ea $fe $df
    ld   L, A                                          ;; 24:40c1 $6f
    xor  A, A                                          ;; 24:40c2 $af
    scf                                                ;; 24:40c3 $37
.jr_24_40c4:
    rl   A                                             ;; 24:40c4 $cb $17
    dec  L                                             ;; 24:40c6 $2d
    jr   NZ, .jr_24_40c4                               ;; 24:40c7 $20 $fb
    ld   [wDFC1], A                                    ;; 24:40c9 $ea $c1 $df
    ld   L, A                                          ;; 24:40cc $6f
    ld   A, [wDFD1]                                    ;; 24:40cd $fa $d1 $df
    cp   A, $01                                        ;; 24:40d0 $fe $01
    jr   NZ, .jr_24_40e3                               ;; 24:40d2 $20 $0f
    ld   A, [wDFCF]                                    ;; 24:40d4 $fa $cf $df
    or   A, L                                          ;; 24:40d7 $b5
    ld   [wDFCF], A                                    ;; 24:40d8 $ea $cf $df
    ld   HL, wDFC3                                     ;; 24:40db $21 $c3 $df
    ld   BC, wDFCB                                     ;; 24:40de $01 $cb $df
    jr   .jr_24_40f0                                   ;; 24:40e1 $18 $0d
.jr_24_40e3:
    ld   A, [wDFC2]                                    ;; 24:40e3 $fa $c2 $df
    or   A, L                                          ;; 24:40e6 $b5
    ld   [wDFC2], A                                    ;; 24:40e7 $ea $c2 $df
    ld   HL, wDFB0                                     ;; 24:40ea $21 $b0 $df
    ld   BC, wDFB9                                     ;; 24:40ed $01 $b9 $df
.jr_24_40f0:
    ld   A, [DE]                                       ;; 24:40f0 $1a
    dec  A                                             ;; 24:40f1 $3d
    sla  A                                             ;; 24:40f2 $cb $27
    add  A, L                                          ;; 24:40f4 $85
    ld   L, A                                          ;; 24:40f5 $6f
    jr   NC, .jr_24_40f9                               ;; 24:40f6 $30 $01
    inc  H                                             ;; 24:40f8 $24
.jr_24_40f9:
    ld   A, [DE]                                       ;; 24:40f9 $1a
    dec  A                                             ;; 24:40fa $3d
    add  A, C                                          ;; 24:40fb $81
    ld   C, A                                          ;; 24:40fc $4f
    jr   NC, .jr_24_4100                               ;; 24:40fd $30 $01
    inc  B                                             ;; 24:40ff $04
.jr_24_4100:
    inc  DE                                            ;; 24:4100 $13
    ld   [HL], E                                       ;; 24:4101 $73
    inc  HL                                            ;; 24:4102 $23
    ld   [HL], D                                       ;; 24:4103 $72
    dec  HL                                            ;; 24:4104 $2b
    push BC                                            ;; 24:4105 $c5
    call call_24_4199                                  ;; 24:4106 $cd $99 $41
    pop  BC                                            ;; 24:4109 $c1
    ld   [BC], A                                       ;; 24:410a $02
    ret                                                ;; 24:410b $c9

call_24_410c:
    ld   BC, wDFB9                                     ;; 24:410c $01 $b9 $df
    ld   HL, wDFB0                                     ;; 24:410f $21 $b0 $df
    ld   A, $01                                        ;; 24:4112 $3e $01
    ld   [wDFC1], A                                    ;; 24:4114 $ea $c1 $df
    ld   A, $00                                        ;; 24:4117 $3e $00
    ld   [wDFB8], A                                    ;; 24:4119 $ea $b8 $df
    ld   A, $02                                        ;; 24:411c $3e $02
    ld   [wDFD1], A                                    ;; 24:411e $ea $d1 $df
.jp_24_4121:
    push BC                                            ;; 24:4121 $c5
    ld   A, [wDFC1]                                    ;; 24:4122 $fa $c1 $df
    ld   D, A                                          ;; 24:4125 $57
    ld   A, [wDFC2]                                    ;; 24:4126 $fa $c2 $df
    and  A, D                                          ;; 24:4129 $a2
    jr   Z, .jr_24_4139                                ;; 24:412a $28 $0d
    ld   A, [BC]                                       ;; 24:412c $0a
    dec  A                                             ;; 24:412d $3d
    jr   NZ, .jr_24_4139                               ;; 24:412e $20 $09
    ld   A, [wDFB8]                                    ;; 24:4130 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 24:4133 $ea $fe $df
    call call_24_4199                                  ;; 24:4136 $cd $99 $41
.jr_24_4139:
    pop  BC                                            ;; 24:4139 $c1
    ld   [BC], A                                       ;; 24:413a $02
    inc  BC                                            ;; 24:413b $03
    inc  HL                                            ;; 24:413c $23
    inc  HL                                            ;; 24:413d $23
    ld   A, [wDFC1]                                    ;; 24:413e $fa $c1 $df
    sla  A                                             ;; 24:4141 $cb $27
    ld   [wDFC1], A                                    ;; 24:4143 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 24:4146 $fa $b8 $df
    inc  A                                             ;; 24:4149 $3c
    ld   [wDFB8], A                                    ;; 24:414a $ea $b8 $df
    cp   A, $04                                        ;; 24:414d $fe $04
    jp   NZ, .jp_24_4121                               ;; 24:414f $c2 $21 $41
    ld   BC, wDFCB                                     ;; 24:4152 $01 $cb $df
    ld   HL, wDFC3                                     ;; 24:4155 $21 $c3 $df
    ld   A, $01                                        ;; 24:4158 $3e $01
    ld   [wDFC1], A                                    ;; 24:415a $ea $c1 $df
    ld   A, $00                                        ;; 24:415d $3e $00
    ld   [wDFB8], A                                    ;; 24:415f $ea $b8 $df
    ld   A, $01                                        ;; 24:4162 $3e $01
    ld   [wDFD1], A                                    ;; 24:4164 $ea $d1 $df
.jp_24_4167:
    push BC                                            ;; 24:4167 $c5
    ld   A, [wDFC1]                                    ;; 24:4168 $fa $c1 $df
    ld   D, A                                          ;; 24:416b $57
    ld   A, [wDFCF]                                    ;; 24:416c $fa $cf $df
    and  A, D                                          ;; 24:416f $a2
    jr   Z, .jr_24_417f                                ;; 24:4170 $28 $0d
    ld   A, [BC]                                       ;; 24:4172 $0a
    dec  A                                             ;; 24:4173 $3d
    jr   NZ, .jr_24_417f                               ;; 24:4174 $20 $09
    ld   A, [wDFB8]                                    ;; 24:4176 $fa $b8 $df
    ld   [wDFFE], A                                    ;; 24:4179 $ea $fe $df
    call call_24_4199                                  ;; 24:417c $cd $99 $41
.jr_24_417f:
    pop  BC                                            ;; 24:417f $c1
    ld   [BC], A                                       ;; 24:4180 $02
    inc  BC                                            ;; 24:4181 $03
    inc  HL                                            ;; 24:4182 $23
    inc  HL                                            ;; 24:4183 $23
    ld   A, [wDFC1]                                    ;; 24:4184 $fa $c1 $df
    sla  A                                             ;; 24:4187 $cb $27
    ld   [wDFC1], A                                    ;; 24:4189 $ea $c1 $df
    ld   A, [wDFB8]                                    ;; 24:418c $fa $b8 $df
    inc  A                                             ;; 24:418f $3c
    ld   [wDFB8], A                                    ;; 24:4190 $ea $b8 $df
    cp   A, $04                                        ;; 24:4193 $fe $04
    jp   NZ, .jp_24_4167                               ;; 24:4195 $c2 $67 $41
    ret                                                ;; 24:4198 $c9

call_24_4199:
    ld   C, [HL]                                       ;; 24:4199 $4e
    inc  HL                                            ;; 24:419a $23
    ld   B, [HL]                                       ;; 24:419b $46
.jp_24_419c:
    ld   A, [BC]                                       ;; 24:419c $0a
    cp   A, $fe                                        ;; 24:419d $fe $fe
    jr   NZ, .jr_24_41ae                               ;; 24:419f $20 $0d
    inc  BC                                            ;; 24:41a1 $03
    ld   A, [BC]                                       ;; 24:41a2 $0a
    ld   E, A                                          ;; 24:41a3 $5f
    inc  BC                                            ;; 24:41a4 $03
    ld   A, [BC]                                       ;; 24:41a5 $0a
    ld   D, A                                          ;; 24:41a6 $57
    ld   A, C                                          ;; 24:41a7 $79
    sub  A, E                                          ;; 24:41a8 $93
    ld   C, A                                          ;; 24:41a9 $4f
    ld   A, B                                          ;; 24:41aa $78
    sbc  A, D                                          ;; 24:41ab $9a
    ld   B, A                                          ;; 24:41ac $47
    ld   A, [BC]                                       ;; 24:41ad $0a
.jr_24_41ae:
    inc  BC                                            ;; 24:41ae $03
    cp   A, $ff                                        ;; 24:41af $fe $ff
    jp   NZ, .jp_24_426f                               ;; 24:41b1 $c2 $6f $42
    ld   A, [wDFC1]                                    ;; 24:41b4 $fa $c1 $df
    cpl                                                ;; 24:41b7 $2f
    ld   E, A                                          ;; 24:41b8 $5f
    ld   A, [wDFD1]                                    ;; 24:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 24:41bc $fe $01
    jp   NZ, .jp_24_4253                               ;; 24:41be $c2 $53 $42
    ld   A, [wDFCF]                                    ;; 24:41c1 $fa $cf $df
    and  A, E                                          ;; 24:41c4 $a3
    ld   [wDFCF], A                                    ;; 24:41c5 $ea $cf $df
    ld   A, [wDFC2]                                    ;; 24:41c8 $fa $c2 $df
    ld   E, A                                          ;; 24:41cb $5f
    ld   A, [wDFC1]                                    ;; 24:41cc $fa $c1 $df
    and  A, E                                          ;; 24:41cf $a3
    jp   Z, .jp_24_4265                                ;; 24:41d0 $ca $65 $42
    push HL                                            ;; 24:41d3 $e5
    push BC                                            ;; 24:41d4 $c5
    ld   B, $ff                                        ;; 24:41d5 $06 $ff
    ld   DE, wDFD2                                     ;; 24:41d7 $11 $d2 $df
    ld   A, [wDFFE]                                    ;; 24:41da $fa $fe $df
    sla  A                                             ;; 24:41dd $cb $27
    sla  A                                             ;; 24:41df $cb $27
    add  A, E                                          ;; 24:41e1 $83
    ld   E, A                                          ;; 24:41e2 $5f
    ld   A, [wDFFE]                                    ;; 24:41e3 $fa $fe $df
    add  A, E                                          ;; 24:41e6 $83
    ld   E, A                                          ;; 24:41e7 $5f
    ld   HL, data_24_439e                              ;; 24:41e8 $21 $9e $43
    ld   A, [wDFFE]                                    ;; 24:41eb $fa $fe $df
    sla  A                                             ;; 24:41ee $cb $27
    ld   C, A                                          ;; 24:41f0 $4f
    sla  A                                             ;; 24:41f1 $cb $27
    sla  A                                             ;; 24:41f3 $cb $27
    add  A, C                                          ;; 24:41f5 $81
    add  A, L                                          ;; 24:41f6 $85
    ld   L, A                                          ;; 24:41f7 $6f
    jr   NC, .jr_24_41fb                               ;; 24:41f8 $30 $01
    inc  H                                             ;; 24:41fa $24
.jr_24_41fb:
    ld   A, [HL+]                                      ;; 24:41fb $2a
    and  A, A                                          ;; 24:41fc $a7
    jr   Z, .jr_24_4206                                ;; 24:41fd $28 $07
    ld   C, A                                          ;; 24:41ff $4f
    ld   A, [DE]                                       ;; 24:4200 $1a
    ld   [BC], A                                       ;; 24:4201 $02
    inc  DE                                            ;; 24:4202 $13
    inc  HL                                            ;; 24:4203 $23
    jr   .jr_24_41fb                                   ;; 24:4204 $18 $f5
.jr_24_4206:
    ld   A, [wDFC1]                                    ;; 24:4206 $fa $c1 $df
    cp   A, $04                                        ;; 24:4209 $fe $04
    jr   NZ, .jr_24_421b                               ;; 24:420b $20 $0e
    ld   HL, wDFE6                                     ;; 24:420d $21 $e6 $df
    ld   DE, $ff30                                     ;; 24:4210 $11 $30 $ff
    ld   C, $10                                        ;; 24:4213 $0e $10
.jr_24_4215:
    ld   A, [HL+]                                      ;; 24:4215 $2a
    ld   [DE], A                                       ;; 24:4216 $12
    inc  DE                                            ;; 24:4217 $13
    dec  C                                             ;; 24:4218 $0d
    jr   NZ, .jr_24_4215                               ;; 24:4219 $20 $fa
.jr_24_421b:
    ld   HL, wDFF6                                     ;; 24:421b $21 $f6 $df
    ld   A, [wDFFE]                                    ;; 24:421e $fa $fe $df
    sla  A                                             ;; 24:4221 $cb $27
    add  A, L                                          ;; 24:4223 $85
    ld   L, A                                          ;; 24:4224 $6f
    ld   A, [wDFC1]                                    ;; 24:4225 $fa $c1 $df
    dec  A                                             ;; 24:4228 $3d
    ld   DE, data_24_43c6                              ;; 24:4229 $11 $c6 $43
    add  A, E                                          ;; 24:422c $83
    ld   E, A                                          ;; 24:422d $5f
    jr   NC, .jr_24_4231                               ;; 24:422e $30 $01
    inc  D                                             ;; 24:4230 $14
.jr_24_4231:
    ld   A, [DE]                                       ;; 24:4231 $1a
    ld   E, A                                          ;; 24:4232 $5f
    ld   D, $ff                                        ;; 24:4233 $16 $ff
    ld   A, [wDFC1]                                    ;; 24:4235 $fa $c1 $df
    cp   A, $08                                        ;; 24:4238 $fe $08
    jr   NZ, .jr_24_4244                               ;; 24:423a $20 $08
    inc  HL                                            ;; 24:423c $23
    ld   [DE], A                                       ;; 24:423d $12
    ldh  A, [rNR42]                                    ;; 24:423e $f0 $21
    ldh  [rNR42], A                                    ;; 24:4240 $e0 $21
    jr   .jr_24_424e                                   ;; 24:4242 $18 $0a
.jr_24_4244:
    ld   A, [HL+]                                      ;; 24:4244 $2a
    ld   [DE], A                                       ;; 24:4245 $12
    inc  DE                                            ;; 24:4246 $13
    ld   A, [DE]                                       ;; 24:4247 $1a
    and  A, $c0                                        ;; 24:4248 $e6 $c0
    ld   C, A                                          ;; 24:424a $4f
    ld   A, [HL]                                       ;; 24:424b $7e
    or   A, C                                          ;; 24:424c $b1
    ld   [DE], A                                       ;; 24:424d $12
.jr_24_424e:
    pop  BC                                            ;; 24:424e $c1
    pop  HL                                            ;; 24:424f $e1
    jp   .jp_24_4392                                   ;; 24:4250 $c3 $92 $43
.jp_24_4253:
    ld   A, [wDFC2]                                    ;; 24:4253 $fa $c2 $df
    and  A, E                                          ;; 24:4256 $a3
    ld   [wDFC2], A                                    ;; 24:4257 $ea $c2 $df
    ld   A, [wDFCF]                                    ;; 24:425a $fa $cf $df
    ld   E, A                                          ;; 24:425d $5f
    ld   A, [wDFC1]                                    ;; 24:425e $fa $c1 $df
    and  A, E                                          ;; 24:4261 $a3
    jp   NZ, .jp_24_4392                               ;; 24:4262 $c2 $92 $43
.jp_24_4265:
    ldh  A, [rNR52]                                    ;; 24:4265 $f0 $26
    and  A, $8f                                        ;; 24:4267 $e6 $8f
    and  A, E                                          ;; 24:4269 $a3
    ldh  [rNR52], A                                    ;; 24:426a $e0 $26
    jp   .jp_24_4392                                   ;; 24:426c $c3 $92 $43
.jp_24_426f:
    cp   A, $fd                                        ;; 24:426f $fe $fd
    jr   NZ, .jr_24_4284                               ;; 24:4271 $20 $11
    push HL                                            ;; 24:4273 $e5
    ld   DE, $ff30                                     ;; 24:4274 $11 $30 $ff
    ld   L, $10                                        ;; 24:4277 $2e $10
.jr_24_4279:
    ld   A, [BC]                                       ;; 24:4279 $0a
    inc  BC                                            ;; 24:427a $03
    ld   [DE], A                                       ;; 24:427b $12
    inc  DE                                            ;; 24:427c $13
    dec  L                                             ;; 24:427d $2d
    jr   NZ, .jr_24_4279                               ;; 24:427e $20 $f9
    pop  HL                                            ;; 24:4280 $e1
    jp   .jp_24_419c                                   ;; 24:4281 $c3 $9c $41
.jr_24_4284:
    cp   A, $a0                                        ;; 24:4284 $fe $a0
    jr   C, .jr_24_42bb                                ;; 24:4286 $38 $33
    cp   A, $c0                                        ;; 24:4288 $fe $c0
    jr   NC, .jr_24_429c                               ;; 24:428a $30 $10
    sub  A, $90                                        ;; 24:428c $d6 $90
    ld   E, A                                          ;; 24:428e $5f
    ld   D, $ff                                        ;; 24:428f $16 $ff
    ld   A, [DE]                                       ;; 24:4291 $1a
    ld   D, A                                          ;; 24:4292 $57
    ld   A, [BC]                                       ;; 24:4293 $0a
    and  A, D                                          ;; 24:4294 $a2
    ld   D, $ff                                        ;; 24:4295 $16 $ff
    ld   [DE], A                                       ;; 24:4297 $12
    inc  BC                                            ;; 24:4298 $03
    jp   .jp_24_419c                                   ;; 24:4299 $c3 $9c $41
.jr_24_429c:
    cp   A, $e0                                        ;; 24:429c $fe $e0
    jr   NC, .jr_24_42b0                               ;; 24:429e $30 $10
    sub  A, $b0                                        ;; 24:42a0 $d6 $b0
    ld   E, A                                          ;; 24:42a2 $5f
    ld   D, $ff                                        ;; 24:42a3 $16 $ff
    ld   A, [DE]                                       ;; 24:42a5 $1a
    ld   D, A                                          ;; 24:42a6 $57
    ld   A, [BC]                                       ;; 24:42a7 $0a
    or   A, D                                          ;; 24:42a8 $b2
    ld   D, $ff                                        ;; 24:42a9 $16 $ff
    ld   [DE], A                                       ;; 24:42ab $12
    inc  BC                                            ;; 24:42ac $03
    jp   .jp_24_419c                                   ;; 24:42ad $c3 $9c $41
.jr_24_42b0:
    sub  A, $d0                                        ;; 24:42b0 $d6 $d0
    ld   E, A                                          ;; 24:42b2 $5f
    ld   D, $ff                                        ;; 24:42b3 $16 $ff
    ld   A, [BC]                                       ;; 24:42b5 $0a
    inc  BC                                            ;; 24:42b6 $03
    ld   [DE], A                                       ;; 24:42b7 $12
    jp   .jp_24_419c                                   ;; 24:42b8 $c3 $9c $41
.jr_24_42bb:
    cp   A, $49                                        ;; 24:42bb $fe $49
    jp   Z, .jp_24_4369                                ;; 24:42bd $ca $69 $43
    sla  A                                             ;; 24:42c0 $cb $27
    ld   [wDFBF], A                                    ;; 24:42c2 $ea $bf $df
    ld   A, [wDFC1]                                    ;; 24:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 24:42c8 $d6 $01
    ld   [wDFC0], A                                    ;; 24:42ca $ea $c0 $df
    ld   A, [wDFBF]                                    ;; 24:42cd $fa $bf $df
    and  A, A                                          ;; 24:42d0 $a7
    jr   NZ, .jr_24_42ff                               ;; 24:42d1 $20 $2c
    ld   A, [wDFD1]                                    ;; 24:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 24:42d6 $fe $01
    jr   Z, .jr_24_42e4                                ;; 24:42d8 $28 $0a
    ld   A, [wDFCF]                                    ;; 24:42da $fa $cf $df
    ld   E, A                                          ;; 24:42dd $5f
    ld   A, [wDFC1]                                    ;; 24:42de $fa $c1 $df
    and  A, E                                          ;; 24:42e1 $a3
    jr   NZ, .jr_24_42ff                               ;; 24:42e2 $20 $1b
.jr_24_42e4:
    ld   A, [wDFC1]                                    ;; 24:42e4 $fa $c1 $df
    cpl                                                ;; 24:42e7 $2f
    ld   E, A                                          ;; 24:42e8 $5f
    ldh  A, [rNR52]                                    ;; 24:42e9 $f0 $26
    and  A, $8f                                        ;; 24:42eb $e6 $8f
    and  A, E                                          ;; 24:42ed $a3
    ldh  [rNR52], A                                    ;; 24:42ee $e0 $26
    ld   A, [wDFC1]                                    ;; 24:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 24:42f3 $fe $04
    jr   NZ, .jr_24_42fa                               ;; 24:42f5 $20 $03
    xor  A, A                                          ;; 24:42f7 $af
    ldh  [rNR30], A                                    ;; 24:42f8 $e0 $1a
.jr_24_42fa:
    ld   A, [BC]                                       ;; 24:42fa $0a
    inc  BC                                            ;; 24:42fb $03
    jp   .jp_24_4392                                   ;; 24:42fc $c3 $92 $43
.jr_24_42ff:
    ld   DE, data_24_43ce                              ;; 24:42ff $11 $ce $43
    add  A, E                                          ;; 24:4302 $83
    ld   E, A                                          ;; 24:4303 $5f
    jr   NC, .jr_24_4307                               ;; 24:4304 $30 $01
    inc  D                                             ;; 24:4306 $14
.jr_24_4307:
    ld   A, [DE]                                       ;; 24:4307 $1a
    ld   [wDFBD], A                                    ;; 24:4308 $ea $bd $df
    inc  DE                                            ;; 24:430b $13
    ld   A, [DE]                                       ;; 24:430c $1a
    ld   [wDFBE], A                                    ;; 24:430d $ea $be $df
    ld   DE, wDFF6                                     ;; 24:4310 $11 $f6 $df
    ld   A, [wDFFE]                                    ;; 24:4313 $fa $fe $df
    sla  A                                             ;; 24:4316 $cb $27
    add  A, E                                          ;; 24:4318 $83
    ld   E, A                                          ;; 24:4319 $5f
    ld   A, [wDFBD]                                    ;; 24:431a $fa $bd $df
    ld   [DE], A                                       ;; 24:431d $12
    ld   A, [wDFBE]                                    ;; 24:431e $fa $be $df
    or   A, $80                                        ;; 24:4321 $f6 $80
    ld   [DE], A                                       ;; 24:4323 $12
    ld   A, [wDFD1]                                    ;; 24:4324 $fa $d1 $df
    cp   A, $01                                        ;; 24:4327 $fe $01
    jr   Z, .jr_24_4335                                ;; 24:4329 $28 $0a
    ld   A, [wDFCF]                                    ;; 24:432b $fa $cf $df
    ld   E, A                                          ;; 24:432e $5f
    ld   A, [wDFC1]                                    ;; 24:432f $fa $c1 $df
    and  A, E                                          ;; 24:4332 $a3
    jr   NZ, .jr_24_4390                               ;; 24:4333 $20 $5b
.jr_24_4335:
    ld   A, [wDFC0]                                    ;; 24:4335 $fa $c0 $df
    ld   DE, data_24_43c6                              ;; 24:4338 $11 $c6 $43
    add  A, E                                          ;; 24:433b $83
    ld   E, A                                          ;; 24:433c $5f
    jr   NC, .jr_24_4340                               ;; 24:433d $30 $01
    inc  D                                             ;; 24:433f $14
.jr_24_4340:
    ld   A, [DE]                                       ;; 24:4340 $1a
    ld   E, A                                          ;; 24:4341 $5f
    ld   D, $ff                                        ;; 24:4342 $16 $ff
    ld   A, [wDFC1]                                    ;; 24:4344 $fa $c1 $df
    cp   A, $08                                        ;; 24:4347 $fe $08
    jr   NZ, .jr_24_4357                               ;; 24:4349 $20 $0c
    ld   A, [wDFBE]                                    ;; 24:434b $fa $be $df
    or   A, $80                                        ;; 24:434e $f6 $80
    ld   [DE], A                                       ;; 24:4350 $12
    ldh  A, [rNR42]                                    ;; 24:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 24:4353 $e0 $21
    jr   .jp_24_4369                                   ;; 24:4355 $18 $12
.jr_24_4357:
    ld   A, [wDFBD]                                    ;; 24:4357 $fa $bd $df
    ld   [DE], A                                       ;; 24:435a $12
    inc  DE                                            ;; 24:435b $13
    push DE                                            ;; 24:435c $d5
    ld   A, [DE]                                       ;; 24:435d $1a
    and  A, $c0                                        ;; 24:435e $e6 $c0
    ld   D, A                                          ;; 24:4360 $57
    ld   A, [wDFBE]                                    ;; 24:4361 $fa $be $df
    or   A, $80                                        ;; 24:4364 $f6 $80
    or   A, D                                          ;; 24:4366 $b2
    pop  DE                                            ;; 24:4367 $d1
    ld   [DE], A                                       ;; 24:4368 $12
.jp_24_4369:
    ld   A, [wDFD1]                                    ;; 24:4369 $fa $d1 $df
    cp   A, $02                                        ;; 24:436c $fe $02
    jr   NZ, .jr_24_4376                               ;; 24:436e $20 $06
    ld   A, [wDFCF]                                    ;; 24:4370 $fa $cf $df
    and  A, E                                          ;; 24:4373 $a3
    jr   NZ, .jr_24_4390                               ;; 24:4374 $20 $1a
.jr_24_4376:
    ld   A, [wDFC1]                                    ;; 24:4376 $fa $c1 $df
    ld   E, A                                          ;; 24:4379 $5f
    ldh  A, [rNR52]                                    ;; 24:437a $f0 $26
    and  A, $8f                                        ;; 24:437c $e6 $8f
    or   A, E                                          ;; 24:437e $b3
    ldh  [rNR52], A                                    ;; 24:437f $e0 $26
    ld   A, [wDFC1]                                    ;; 24:4381 $fa $c1 $df
    cp   A, $04                                        ;; 24:4384 $fe $04
    jr   NZ, .jr_24_4390                               ;; 24:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 24:4388 $f0 $1a
    and  A, $80                                        ;; 24:438a $e6 $80
    or   A, $80                                        ;; 24:438c $f6 $80
    ldh  [rNR30], A                                    ;; 24:438e $e0 $1a
.jr_24_4390:
    ld   A, [BC]                                       ;; 24:4390 $0a
    inc  BC                                            ;; 24:4391 $03
.jp_24_4392:
    ld   [HL], B                                       ;; 24:4392 $70
    dec  HL                                            ;; 24:4393 $2b
    ld   [HL], C                                       ;; 24:4394 $71
    ret                                                ;; 24:4395 $c9
    
    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 24:4396 ????????

data_24_439e:            
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 24:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 24:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 24:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 24:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 24:43be ????????

data_24_43c6:
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 24:43c6 ????????

data_24_43ce:
    db   $00, $00                                      ;; 24:43ce ????????
    db   $2c, $00, $9c, $00, $06, $01, $6b, $01        ;; 24:43d0 ????????
    db   $c9, $01, $23, $02, $77, $02, $c6, $02        ;; 24:43d8 ????????
    db   $12, $03, $56, $03, $9b, $03, $da, $03        ;; 24:43e0 ????????
    db   $16, $04, $4e, $04, $83, $04, $b5, $04        ;; 24:43e8 ????????
    db   $e5, $04, $11, $05, $3b, $05, $63, $05        ;; 24:43f0 ????????
    db   $89, $05, $ac, $05, $ce, $05, $ed, $05        ;; 24:43f8 ????????
    db   $0a, $06, $27, $06, $42, $06, $5b, $06        ;; 24:4400 ????????
    db   $72, $06, $89, $06, $9e, $06, $b2, $06        ;; 24:4408 ????????
    db   $c4, $06, $d6, $06, $e7, $06, $f7, $06        ;; 24:4410 ????????
    db   $06, $07, $14, $07, $21, $07, $2d, $07        ;; 24:4418 ????????
    db   $39, $07, $44, $07, $4f, $07, $59, $07        ;; 24:4420 ????????
    db   $62, $07, $6b, $07, $73, $07, $7b, $07        ;; 24:4428 ????????
    db   $83, $07, $8a, $07, $90, $07, $97, $07        ;; 24:4430 ????????
    db   $9d, $07, $a2, $07, $a7, $07, $ac, $07        ;; 24:4438 ????????
    db   $b1, $07, $b6, $07, $ba, $07, $be, $07        ;; 24:4440 ????????
    db   $c1, $07, $c4, $07, $c8, $07, $cb, $07        ;; 24:4448 ????????
    db   $ce, $07, $d1, $07, $d4, $07, $d6, $07        ;; 24:4450 ????????
    db   $d9, $07, $db, $07, $dd, $07, $df, $07        ;; 24:4458 ????????

data_24_4460:
    db   $86, $00, $84, $00, $9c, $00, $be, $00        ;; 24:4460 ????????
    db   $dc, $00, $22, $01, $8e, $01, $a0, $01        ;; 24:4468 ????????
    db   $e0, $01, $f2, $01, $04, $02, $1e, $02        ;; 24:4470 ????????
    db   $36, $02, $54, $02, $82, $02, $e4, $02        ;; 24:4478 ????????
    db   $2c, $03, $88, $03, $d8, $03, $8a, $05        ;; 24:4480 ????????
    db   $a2, $05, $02, $06, $34, $06, $66, $06        ;; 24:4488 ????????
    db   $7e, $06, $9a, $06, $b0, $06, $c2, $06        ;; 24:4490 ????????
    db   $dc, $06, $f6, $06, $04, $07, $1e, $07        ;; 24:4498 ????????
    db   $7c, $07, $94, $07, $dc, $07, $f4, $07        ;; 24:44a0 ????????
    db   $3c, $08, $84, $08, $a0, $08, $ae, $08        ;; 24:44a8 ????????
    db   $da, $08, $40, $09, $62, $09, $aa, $09        ;; 24:44b0 ????????
    db   $c2, $09, $06, $0a, $32, $0a, $88, $0a        ;; 24:44b8 ????????
    db   $9e, $0a, $b6, $0a, $d0, $0a, $e8, $0a        ;; 24:44c0 ????????
    db   $f4, $0a, $12, $0b, $40, $0b, $58, $0b        ;; 24:44c8 ????????
    db   $74, $0b, $a6, $0b, $c4, $0b, $dc, $0b        ;; 24:44d0 ????????
    db   $f4, $0b, $0c, $0c, $26, $0c, $40, $0c        ;; 24:44d8 ????????
    db   $42, $0c, $44, $0c, $46, $0c, $01, $f6        ;; 24:44e0 ????????
    db   $00, $f6, $80, $f6, $81, $f5, $ff, $f4        ;; 24:44e8 ????????
    db   $77, $e0, $00, $e1, $ff, $e2, $77, $e2        ;; 24:44f0 ????????
    db   $b7, $19, $01, $e2, $07, $49, $78, $ff        ;; 24:44f8 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4500 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4508 ????????
    db   $77, $00, $1e, $e2, $47, $3d, $01, $31        ;; 24:4510 ????????
    db   $01, $3d, $01, $31, $01, $3d, $01, $e2        ;; 24:4518 ????????
    db   $07, $49, $78, $ff, $04, $f6, $00, $f6        ;; 24:4520 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:4528 ????????
    db   $13, $f1, $57, $f2, $27, $f3, $80, $f1        ;; 24:4530 ????????
    db   $5f, $f2, $7f, $3d, $78, $f1, $57, $f2        ;; 24:4538 ????????
    db   $27, $19, $78, $ff, $01, $f6, $00, $f6        ;; 24:4540 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4548 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $17, $2a        ;; 24:4550 ????????
    db   $01, $2e, $01, $31, $01, $36, $01, $e2        ;; 24:4558 ????????
    db   $37, $2a, $01, $2e, $01, $31, $01, $36        ;; 24:4560 ????????
    db   $01, $e2, $57, $2a, $01, $2e, $01, $31        ;; 24:4568 ????????
    db   $01, $36, $01, $e2, $37, $2a, $01, $2e        ;; 24:4570 ????????
    db   $01, $31, $01, $36, $01, $e2, $17, $2a        ;; 24:4578 ????????
    db   $01, $2e, $01, $31, $01, $36, $02, $e2        ;; 24:4580 ????????
    db   $07, $49, $78, $ff, $01, $f6, $00, $f6        ;; 24:4588 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4590 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $17, $2a        ;; 24:4598 ????????
    db   $01, $36, $01, $2e, $01, $3a, $01, $31        ;; 24:45a0 ????????
    db   $01, $3d, $01, $36, $01, $42, $01, $e2        ;; 24:45a8 ????????
    db   $37, $2a, $01, $36, $01, $2e, $01, $3a        ;; 24:45b0 ????????
    db   $01, $31, $01, $3d, $01, $36, $01, $42        ;; 24:45b8 ????????
    db   $01, $e2, $57, $2a, $01, $36, $01, $2e        ;; 24:45c0 ????????
    db   $01, $3a, $01, $31, $01, $3d, $01, $36        ;; 24:45c8 ????????
    db   $01, $42, $01, $e2, $37, $2a, $01, $36        ;; 24:45d0 ????????
    db   $01, $2e, $01, $3a, $01, $31, $01, $3d        ;; 24:45d8 ????????
    db   $01, $36, $01, $42, $01, $e2, $17, $2a        ;; 24:45e0 ????????
    db   $01, $36, $01, $2e, $01, $3a, $01, $31        ;; 24:45e8 ????????
    db   $01, $3d, $01, $36, $01, $42, $01, $49        ;; 24:45f0 ????????
    db   $78, $ff, $01, $f6, $00, $f6, $80, $f6        ;; 24:45f8 ????????
    db   $81, $f5, $ff, $f4, $77, $e0, $00, $e1        ;; 24:4600 ????????
    db   $ff, $e2, $77, $00, $0c, $ff, $01, $f6        ;; 24:4608 ????????
    db   $00, $f6, $80, $f6, $81, $f5, $ff, $f4        ;; 24:4610 ????????
    db   $77, $e0, $00, $e1, $ff, $e2, $77, $e2        ;; 24:4618 ????????
    db   $57, $25, $05, $24, $05, $25, $05, $27        ;; 24:4620 ????????
    db   $05, $25, $05, $27, $05, $29, $05, $e2        ;; 24:4628 ????????
    db   $07, $49, $02, $e2, $57, $29, $03, $e2        ;; 24:4630 ????????
    db   $07, $49, $02, $e2, $57, $29, $03, $e2        ;; 24:4638 ????????
    db   $07, $49, $02, $e2, $57, $29, $03, $e2        ;; 24:4640 ????????
    db   $07, $49, $02, $e2, $07, $49, $1e, $ff        ;; 24:4648 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4650 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4658 ????????
    db   $77, $00, $0c, $ff, $01, $f6, $00, $f6        ;; 24:4660 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4668 ????????
    db   $00, $e1, $ff, $e2, $77, $00, $0c, $ff        ;; 24:4670 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4678 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4680 ????????
    db   $77, $e2, $57, $19, $01, $25, $01, $e2        ;; 24:4688 ????????
    db   $07, $49, $1e, $ff, $01, $f6, $00, $f6        ;; 24:4690 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4698 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $57, $01        ;; 24:46a0 ????????
    db   $01, $e2, $07, $49, $1e, $ff, $04, $f6        ;; 24:46a8 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:46b0 ????????
    db   $77, $f0, $13, $f1, $57, $f2, $27, $f3        ;; 24:46b8 ????????
    db   $80, $f1, $5f, $f2, $7f, $3d, $78, $f1        ;; 24:46c0 ????????
    db   $57, $f2, $27, $19, $78, $ff, $01, $f6        ;; 24:46c8 ????????
    db   $00, $f6, $80, $f6, $81, $f5, $ff, $f4        ;; 24:46d0 ????????
    db   $77, $e0, $17, $e1, $ff, $e2, $77, $e2        ;; 24:46d8 ????????
    db   $57, $25, $01, $28, $01, $27, $01, $29        ;; 24:46e0 ????????
    db   $01, $2a, $01, $2b, $01, $2c, $01, $2d        ;; 24:46e8 ????????
    db   $01, $2e, $01, $2f, $01, $30, $01, $31        ;; 24:46f0 ????????
    db   $01, $e2, $07, $49, $1e, $ff, $01, $f6        ;; 24:46f8 ????????
    db   $00, $f6, $80, $f6, $81, $f5, $ff, $f4        ;; 24:4700 ????????
    db   $77, $e0, $00, $e1, $ff, $e2, $77, $e2        ;; 24:4708 ????????
    db   $57, $25, $01, $26, $01, $27, $01, $29        ;; 24:4710 ????????
    db   $01, $2a, $01, $2b, $01, $2c, $01, $2d        ;; 24:4718 ????????
    db   $01, $2e, $01, $2f, $01, $30, $01, $31        ;; 24:4720 ????????
    db   $01, $34, $01, $33, $01, $35, $01, $36        ;; 24:4728 ????????
    db   $01, $37, $01, $38, $01, $39, $01, $3a        ;; 24:4730 ????????
    db   $01, $3b, $01, $3c, $01, $3d, $01, $3e        ;; 24:4738 ????????
    db   $01, $e2, $47, $3f, $01, $41, $01, $e2        ;; 24:4740 ????????
    db   $47, $42, $01, $43, $01, $e2, $37, $44        ;; 24:4748 ????????
    db   $01, $45, $01, $e2, $27, $46, $01, $47        ;; 24:4750 ????????
    db   $01, $e2, $17, $48, $01, $e2, $07, $49        ;; 24:4758 ????????
    db   $1e, $ff, $04, $f6, $00, $f6, $80, $f6        ;; 24:4760 ????????
    db   $88, $f5, $ff, $f4, $77, $f0, $13, $f1        ;; 24:4768 ????????
    db   $57, $f2, $27, $f3, $80, $f1, $5f, $f2        ;; 24:4770 ????????
    db   $27, $19, $78, $f2, $2f, $3d, $78, $f2        ;; 24:4778 ????????
    db   $77, $19, $78, $f2, $7f, $3d, $78, $f1        ;; 24:4780 ????????
    db   $57, $f2, $27, $19, $78, $f2, $2f, $19        ;; 24:4788 ????????
    db   $78, $f2, $77, $19, $78, $f2, $7f, $19        ;; 24:4790 ????????
    db   $78, $f1, $57, $f2, $27, $19, $78, $f2        ;; 24:4798 ????????
    db   $2f, $19, $78, $f2, $77, $19, $78, $f2        ;; 24:47a0 ????????
    db   $7f, $19, $78, $ff, $01, $f6, $00, $f6        ;; 24:47a8 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:47b0 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $57, $3d        ;; 24:47b8 ????????
    db   $05, $3c, $05, $3b, $05, $3a, $05, $3c        ;; 24:47c0 ????????
    db   $04, $3b, $04, $3a, $04, $39, $04, $3b        ;; 24:47c8 ????????
    db   $03, $3a, $03, $39, $02, $38, $02, $37        ;; 24:47d0 ????????
    db   $01, $36, $01, $35, $01, $34, $01, $33        ;; 24:47d8 ????????
    db   $01, $32, $01, $31, $01, $30, $01, $2e        ;; 24:47e0 ????????
    db   $01, $e2, $47, $2c, $01, $2a, $01, $e2        ;; 24:47e8 ????????
    db   $37, $28, $01, $26, $01, $e2, $27, $24        ;; 24:47f0 ????????
    db   $01, $22, $01, $e2, $17, $20, $01, $1e        ;; 24:47f8 ????????
    db   $01, $e2, $07, $1c, $01, $e2, $07, $49        ;; 24:4800 ????????
    db   $1e, $ff, $01, $f6, $00, $f6, $80, $f6        ;; 24:4808 ????????
    db   $81, $f5, $ff, $f4, $77, $e0, $00, $e1        ;; 24:4810 ????????
    db   $ff, $e2, $77, $e2, $57, $22, $01, $e2        ;; 24:4818 ????????
    db   $07, $49, $01, $e2, $57, $28, $01, $e2        ;; 24:4820 ????????
    db   $07, $49, $01, $e2, $57, $22, $01, $e2        ;; 24:4828 ????????
    db   $07, $49, $01, $e2, $57, $28, $01, $e2        ;; 24:4830 ????????
    db   $07, $49, $01, $e2, $57, $22, $01, $e2        ;; 24:4838 ????????
    db   $07, $49, $01, $e2, $57, $28, $01, $e2        ;; 24:4840 ????????
    db   $07, $49, $01, $e2, $57, $22, $01, $e2        ;; 24:4848 ????????
    db   $07, $49, $01, $e2, $57, $28, $01, $e2        ;; 24:4850 ????????
    db   $07, $49, $1e, $ff, $01, $f6, $00, $f6        ;; 24:4858 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4860 ????????
    db   $17, $e1, $ff, $e2, $c7, $e2, $17, $3d        ;; 24:4868 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4870 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $e2        ;; 24:4878 ????????
    db   $27, $25, $01, $19, $01, $25, $01, $19        ;; 24:4880 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:4888 ????????
    db   $01, $e2, $37, $3d, $01, $31, $01, $3d        ;; 24:4890 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4898 ????????
    db   $01, $31, $01, $e2, $47, $25, $01, $19        ;; 24:48a0 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:48a8 ????????
    db   $01, $25, $01, $19, $01, $e2, $57, $3d        ;; 24:48b0 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:48b8 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $e2        ;; 24:48c0 ????????
    db   $67, $25, $01, $19, $01, $25, $01, $19        ;; 24:48c8 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:48d0 ????????
    db   $01, $e2, $77, $3d, $01, $31, $01, $3d        ;; 24:48d8 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:48e0 ????????
    db   $01, $31, $01, $e2, $87, $25, $01, $19        ;; 24:48e8 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:48f0 ????????
    db   $01, $25, $01, $19, $01, $e2, $97, $3d        ;; 24:48f8 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4900 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $e2        ;; 24:4908 ????????
    db   $a7, $25, $01, $19, $01, $25, $01, $19        ;; 24:4910 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:4918 ????????
    db   $01, $e2, $b7, $3d, $01, $31, $01, $3d        ;; 24:4920 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4928 ????????
    db   $01, $31, $01, $e2, $c7, $25, $01, $19        ;; 24:4930 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:4938 ????????
    db   $01, $25, $01, $19, $01, $e2, $b7, $3d        ;; 24:4940 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4948 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $e2        ;; 24:4950 ????????
    db   $a7, $25, $01, $19, $01, $25, $01, $19        ;; 24:4958 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:4960 ????????
    db   $01, $e2, $97, $3d, $01, $31, $01, $3d        ;; 24:4968 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4970 ????????
    db   $01, $31, $01, $e2, $87, $25, $01, $19        ;; 24:4978 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:4980 ????????
    db   $01, $25, $01, $19, $01, $e2, $77, $3d        ;; 24:4988 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4990 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $e2        ;; 24:4998 ????????
    db   $67, $25, $01, $19, $01, $25, $01, $19        ;; 24:49a0 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:49a8 ????????
    db   $01, $e2, $57, $3d, $01, $31, $01, $3d        ;; 24:49b0 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:49b8 ????????
    db   $01, $31, $01, $e2, $47, $25, $01, $19        ;; 24:49c0 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:49c8 ????????
    db   $01, $25, $01, $19, $01, $e2, $37, $3d        ;; 24:49d0 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:49d8 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $e2        ;; 24:49e0 ????????
    db   $27, $25, $01, $19, $01, $25, $01, $19        ;; 24:49e8 ????????
    db   $01, $25, $01, $19, $01, $25, $01, $19        ;; 24:49f0 ????????
    db   $01, $e2, $17, $3d, $01, $31, $01, $3d        ;; 24:49f8 ????????
    db   $01, $31, $01, $3d, $01, $31, $01, $3d        ;; 24:4a00 ????????
    db   $01, $31, $01, $e2, $07, $49, $1e, $ff        ;; 24:4a08 ????????
    db   $04, $f6, $00, $f6, $80, $f6, $88, $f5        ;; 24:4a10 ????????
    db   $ff, $f4, $77, $f0, $13, $f1, $57, $f2        ;; 24:4a18 ????????
    db   $27, $f3, $80, $f1, $57, $f2, $27, $19        ;; 24:4a20 ????????
    db   $78, $ff, $04, $f6, $00, $f6, $80, $f6        ;; 24:4a28 ????????
    db   $88, $f5, $ff, $f4, $77, $f0, $13, $f1        ;; 24:4a30 ????????
    db   $57, $f2, $27, $f3, $80, $f1, $50, $f2        ;; 24:4a38 ????????
    db   $2f, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a40 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a48 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a50 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a58 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a60 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a68 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a70 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a78 ????????
    db   $50, $19, $02, $f1, $00, $00, $02, $f1        ;; 24:4a80 ????????
    db   $00, $00, $78, $ff, $01, $f6, $00, $f6        ;; 24:4a88 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4a90 ????????
    db   $17, $e1, $ff, $e2, $77, $e2, $17, $20        ;; 24:4a98 ????????
    db   $04, $14, $04, $e2, $27, $21, $04, $15        ;; 24:4aa0 ????????
    db   $04, $e2, $37, $22, $04, $16, $04, $e2        ;; 24:4aa8 ????????
    db   $47, $23, $04, $17, $04, $e2, $57, $24        ;; 24:4ab0 ????????
    db   $04, $18, $04, $e2, $07, $49, $1e, $ff        ;; 24:4ab8 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4ac0 ????????
    db   $ff, $f4, $77, $e0, $1f, $e1, $ff, $e2        ;; 24:4ac8 ????????
    db   $77, $e2, $17, $24, $04, $18, $04, $e2        ;; 24:4ad0 ????????
    db   $27, $23, $04, $17, $04, $e2, $37, $22        ;; 24:4ad8 ????????
    db   $04, $16, $04, $e2, $47, $21, $04, $15        ;; 24:4ae0 ????????
    db   $04, $e2, $57, $20, $04, $14, $04, $e2        ;; 24:4ae8 ????????
    db   $07, $49, $1e, $ff, $01, $f6, $00, $f6        ;; 24:4af0 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4af8 ????????
    db   $1f, $e1, $ff, $e2, $77, $e2, $17, $24        ;; 24:4b00 ????????
    db   $14, $e2, $07, $49, $1e, $ff, $01, $f6        ;; 24:4b08 ????????
    db   $00, $f6, $80, $f6, $81, $f5, $ff, $f4        ;; 24:4b10 ????????
    db   $77, $e0, $1f, $e1, $ff, $e2, $77, $e2        ;; 24:4b18 ????????
    db   $50, $24, $05, $23, $05, $22, $14, $e2        ;; 24:4b20 ????????
    db   $07, $49, $1e, $ff, $04, $f6, $00, $f6        ;; 24:4b28 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:4b30 ????????
    db   $13, $f1, $57, $f2, $27, $f1, $57, $f2        ;; 24:4b38 ????????
    db   $27, $19, $78, $ff, $01, $f6, $00, $f6        ;; 24:4b40 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4b48 ????????
    db   $00, $e1, $ff, $e2, $77, $00, $0c, $ff        ;; 24:4b50 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4b58 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4b60 ????????
    db   $77, $e2, $57, $01, $05, $49, $14, $e2        ;; 24:4b68 ????????
    db   $07, $49, $1e, $ff, $01, $f6, $00, $f6        ;; 24:4b70 ????????
    db   $80, $f6, $83, $f5, $ff, $f4, $77, $e0        ;; 24:4b78 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $57, $29        ;; 24:4b80 ????????
    db   $14, $49, $14, $e2, $07, $49, $1e, $ff        ;; 24:4b88 ????????
    db   $02, $e6, $ff, $e7, $77, $e7, $57, $35        ;; 24:4b90 ????????
    db   $14, $49, $14, $e7, $07, $49, $1e, $ff        ;; 24:4b98 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4ba0 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4ba8 ????????
    db   $77, $e2, $57, $01, $05, $49, $14, $e2        ;; 24:4bb0 ????????
    db   $07, $49, $1e, $ff, $03, $f6, $00, $f6        ;; 24:4bb8 ????????
    db   $80, $f6, $84, $f5, $ff, $f4, $77, $ea        ;; 24:4bc0 ????????
    db   $80, $eb, $0f, $ec, $20, $31, $01, $31        ;; 24:4bc8 ????????
    db   $01, $31, $01, $31, $01, $31, $01, $32        ;; 24:4bd0 ????????
    db   $01, $32, $01, $32, $01, $32, $01, $32        ;; 24:4bd8 ????????
    db   $01, $32, $01, $32, $01, $31, $01, $31        ;; 24:4be0 ????????
    db   $01, $31, $01, $31, $01, $31, $01, $31        ;; 24:4be8 ????????
    db   $01, $30, $01, $30, $01, $30, $01, $30        ;; 24:4bf0 ????????
    db   $01, $30, $01, $30, $01, $30, $01, $30        ;; 24:4bf8 ????????
    db   $01, $30, $01, $3b, $01, $3b, $01, $3b        ;; 24:4c00 ????????
    db   $01, $3b, $01, $3b, $01, $3b, $01, $30        ;; 24:4c08 ????????
    db   $01, $30, $01, $30, $01, $30, $01, $30        ;; 24:4c10 ????????
    db   $01, $30, $01, $ff, $04, $f6, $00, $f6        ;; 24:4c18 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:4c20 ????????
    db   $13, $f1, $57, $f2, $27, $f3, $80, $f1        ;; 24:4c28 ????????
    db   $5f, $f2, $27, $19, $78, $ff, $04, $f6        ;; 24:4c30 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:4c38 ????????
    db   $77, $f0, $13, $f1, $57, $f2, $27, $f3        ;; 24:4c40 ????????
    db   $80, $f1, $5f, $f2, $27, $19, $78, $f2        ;; 24:4c48 ????????
    db   $2f, $3d, $78, $f2, $77, $19, $78, $f2        ;; 24:4c50 ????????
    db   $7f, $3d, $78, $f1, $57, $f2, $27, $19        ;; 24:4c58 ????????
    db   $78, $f2, $2f, $19, $78, $f2, $77, $19        ;; 24:4c60 ????????
    db   $78, $f2, $7f, $19, $78, $f1, $57, $f2        ;; 24:4c68 ????????
    db   $27, $19, $78, $f2, $2f, $19, $78, $f2        ;; 24:4c70 ????????
    db   $77, $19, $78, $f2, $7f, $19, $78, $ff        ;; 24:4c78 ????????
    db   $04, $f6, $00, $f6, $80, $f6, $88, $f5        ;; 24:4c80 ????????
    db   $ff, $f4, $77, $f0, $13, $f1, $57, $f2        ;; 24:4c88 ????????
    db   $27, $f3, $80, $f1, $57, $f2, $27, $19        ;; 24:4c90 ????????
    db   $78, $ff, $04, $f6, $00, $f6, $80, $f6        ;; 24:4c98 ????????
    db   $88, $f5, $ff, $f4, $77, $f0, $13, $f1        ;; 24:4ca0 ????????
    db   $57, $f2, $27, $f3, $80, $f1, $5f, $f2        ;; 24:4ca8 ????????
    db   $27, $19, $78, $f2, $2f, $3d, $78, $f2        ;; 24:4cb0 ????????
    db   $77, $19, $78, $f2, $7f, $3d, $78, $f1        ;; 24:4cb8 ????????
    db   $57, $f2, $27, $19, $78, $f2, $2f, $19        ;; 24:4cc0 ????????
    db   $78, $f2, $77, $19, $78, $f2, $7f, $19        ;; 24:4cc8 ????????
    db   $78, $f1, $57, $f2, $27, $19, $78, $f2        ;; 24:4cd0 ????????
    db   $2f, $19, $78, $f2, $77, $19, $78, $f2        ;; 24:4cd8 ????????
    db   $7f, $19, $78, $ff, $04, $f6, $00, $f6        ;; 24:4ce0 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:4ce8 ????????
    db   $13, $f1, $57, $f2, $27, $f3, $80, $f1        ;; 24:4cf0 ????????
    db   $5f, $f2, $27, $19, $78, $f2, $2f, $3d        ;; 24:4cf8 ????????
    db   $78, $f2, $77, $19, $78, $f2, $7f, $3d        ;; 24:4d00 ????????
    db   $78, $f1, $57, $f2, $27, $19, $78, $f2        ;; 24:4d08 ????????
    db   $2f, $19, $78, $f2, $77, $19, $78, $f2        ;; 24:4d10 ????????
    db   $7f, $19, $78, $f1, $57, $f2, $27, $19        ;; 24:4d18 ????????
    db   $78, $f2, $2f, $19, $78, $f2, $77, $19        ;; 24:4d20 ????????
    db   $78, $f2, $7f, $19, $78, $ff, $01, $f6        ;; 24:4d28 ????????
    db   $00, $f6, $80, $f6, $83, $f5, $ff, $f4        ;; 24:4d30 ????????
    db   $77, $e0, $00, $e1, $ff, $e2, $77, $00        ;; 24:4d38 ????????
    db   $78, $e2, $77, $49, $03, $31, $0a, $49        ;; 24:4d40 ????????
    db   $32, $e2, $07, $ff, $02, $e6, $ff, $e7        ;; 24:4d48 ????????
    db   $77, $00, $78, $01, $05, $e7, $07, $49        ;; 24:4d50 ????????
    db   $08, $49, $32, $ff, $01, $f6, $00, $f6        ;; 24:4d58 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4d60 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $57, $10        ;; 24:4d68 ????????
    db   $05, $0f, $01, $11, $01, $12, $01, $13        ;; 24:4d70 ????????
    db   $01, $14, $01, $15, $01, $16, $01, $17        ;; 24:4d78 ????????
    db   $01, $18, $01, $19, $01, $e2, $07, $49        ;; 24:4d80 ????????
    db   $1e, $ff, $01, $f6, $00, $f6, $80, $f6        ;; 24:4d88 ????????
    db   $83, $f5, $ff, $f4, $77, $e0, $00, $e1        ;; 24:4d90 ????????
    db   $ff, $e2, $77, $e2, $57, $e2, $67, $31        ;; 24:4d98 ????????
    db   $02, $e2, $57, $3d, $02, $e2, $47, $31        ;; 24:4da0 ????????
    db   $02, $e2, $37, $3d, $02, $e2, $27, $31        ;; 24:4da8 ????????
    db   $02, $e2, $17, $3d, $02, $e2, $07, $e2        ;; 24:4db0 ????????
    db   $57, $3d, $02, $e2, $47, $31, $02, $e2        ;; 24:4db8 ????????
    db   $37, $3d, $02, $e2, $27, $31, $02, $e2        ;; 24:4dc0 ????????
    db   $17, $3d, $02, $e2, $07, $e2, $47, $31        ;; 24:4dc8 ????????
    db   $02, $e2, $37, $3d, $02, $e2, $27, $31        ;; 24:4dd0 ????????
    db   $02, $e2, $17, $3d, $02, $e2, $07, $e2        ;; 24:4dd8 ????????
    db   $37, $3d, $02, $e2, $27, $31, $02, $e2        ;; 24:4de0 ????????
    db   $17, $3d, $02, $e2, $07, $49, $1b, $49        ;; 24:4de8 ????????
    db   $1e, $ff, $02, $e6, $ff, $e7, $77, $00        ;; 24:4df0 ????????
    db   $78, $25, $03, $29, $03, $2c, $03, $31        ;; 24:4df8 ????????
    db   $0c, $29, $03, $2c, $03, $31, $03, $35        ;; 24:4e00 ????????
    db   $0c, $2c, $03, $31, $03, $35, $03, $38        ;; 24:4e08 ????????
    db   $0c, $e7, $07, $49, $1e, $ff, $04, $f6        ;; 24:4e10 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:4e18 ????????
    db   $77, $f0, $13, $f1, $57, $f2, $27, $f3        ;; 24:4e20 ????????
    db   $80, $f1, $5f, $f2, $27, $19, $78, $f2        ;; 24:4e28 ????????
    db   $2f, $3d, $78, $f2, $77, $19, $78, $f2        ;; 24:4e30 ????????
    db   $7f, $3d, $78, $f1, $57, $f2, $27, $19        ;; 24:4e38 ????????
    db   $78, $f2, $2f, $19, $78, $f2, $77, $19        ;; 24:4e40 ????????
    db   $78, $f2, $7f, $19, $78, $f1, $57, $f2        ;; 24:4e48 ????????
    db   $27, $19, $78, $f2, $2f, $19, $78, $f2        ;; 24:4e50 ????????
    db   $77, $19, $78, $f2, $7f, $19, $78, $ff        ;; 24:4e58 ????????
    db   $04, $f6, $00, $f6, $80, $f6, $88, $f5        ;; 24:4e60 ????????
    db   $ff, $f4, $77, $f0, $13, $f1, $57, $f2        ;; 24:4e68 ????????
    db   $27, $f3, $80, $f1, $57, $f2, $27, $19        ;; 24:4e70 ????????
    db   $78, $ff, $01, $f6, $00, $f6, $80, $f6        ;; 24:4e78 ????????
    db   $81, $f5, $ff, $f4, $77, $e0, $00, $e1        ;; 24:4e80 ????????
    db   $ff, $e2, $77, $e2, $57, $1d, $07, $19        ;; 24:4e88 ????????
    db   $07, $16, $07, $e2, $07, $e2, $47, $1d        ;; 24:4e90 ????????
    db   $07, $19, $07, $16, $07, $e2, $07, $e2        ;; 24:4e98 ????????
    db   $37, $1d, $07, $19, $07, $16, $07, $e2        ;; 24:4ea0 ????????
    db   $07, $e2, $27, $1d, $07, $19, $07, $16        ;; 24:4ea8 ????????
    db   $07, $e2, $07, $e2, $17, $1d, $07, $19        ;; 24:4eb0 ????????
    db   $07, $16, $07, $e2, $07, $49, $1e, $ff        ;; 24:4eb8 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4ec0 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4ec8 ????????
    db   $77, $e2, $57, $10, $05, $0f, $01, $11        ;; 24:4ed0 ????????
    db   $01, $12, $01, $13, $01, $14, $01, $15        ;; 24:4ed8 ????????
    db   $01, $16, $01, $17, $01, $18, $01, $19        ;; 24:4ee0 ????????
    db   $01, $e2, $07, $49, $1e, $ff, $04, $f6        ;; 24:4ee8 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:4ef0 ????????
    db   $77, $f0, $13, $f1, $57, $f2, $27, $f3        ;; 24:4ef8 ????????
    db   $80, $f1, $f0, $f2, $2f, $19, $02, $f1        ;; 24:4f00 ????????
    db   $00, $00, $02, $f1, $a0, $19, $02, $f1        ;; 24:4f08 ????????
    db   $00, $00, $02, $f1, $80, $19, $02, $f1        ;; 24:4f10 ????????
    db   $00, $00, $02, $f1, $60, $19, $02, $f1        ;; 24:4f18 ????????
    db   $00, $00, $02, $f1, $40, $19, $02, $f1        ;; 24:4f20 ????????
    db   $00, $00, $02, $f1, $30, $19, $02, $f1        ;; 24:4f28 ????????
    db   $00, $00, $02, $f1, $20, $19, $02, $f1        ;; 24:4f30 ????????
    db   $00, $00, $02, $f1, $10, $19, $02, $f1        ;; 24:4f38 ????????
    db   $00, $00, $02, $00, $78, $ff, $04, $f6        ;; 24:4f40 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:4f48 ????????
    db   $77, $f0, $13, $f1, $1f, $f2, $27, $f3        ;; 24:4f50 ????????
    db   $80, $f2, $27, $19, $2d, $ff, $04, $f6        ;; 24:4f58 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:4f60 ????????
    db   $77, $f0, $13, $f1, $57, $f2, $27, $f3        ;; 24:4f68 ????????
    db   $80, $f1, $57, $f2, $27, $19, $78, $ff        ;; 24:4f70 ????????
    db   $01, $f6, $00, $f6, $80, $f6, $81, $f5        ;; 24:4f78 ????????
    db   $ff, $f4, $77, $e0, $00, $e1, $ff, $e2        ;; 24:4f80 ????????
    db   $77, $e2, $57, $01, $05, $49, $14, $e2        ;; 24:4f88 ????????
    db   $07, $49, $1e, $ff, $01, $f6, $00, $f6        ;; 24:4f90 ????????
    db   $80, $f6, $89, $f5, $ff, $f4, $77, $e0        ;; 24:4f98 ????????
    db   $00, $e1, $ff, $e2, $77, $e2, $17, $01        ;; 24:4fa0 ????????
    db   $14, $e2, $07, $49, $1e, $ff, $04, $f0        ;; 24:4fa8 ????????
    db   $87, $f1, $e1, $f2, $eb, $00, $78, $19        ;; 24:4fb0 ????????
    db   $14, $49, $1e, $ff, $04, $f6, $00, $f6        ;; 24:4fb8 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:4fc0 ????????
    db   $13, $f1, $57, $f2, $27, $f3, $80, $f1        ;; 24:4fc8 ????????
    db   $5f, $f2, $27, $19, $64, $f1, $57, $f2        ;; 24:4fd0 ????????
    db   $27, $49, $64, $ff, $01, $f6, $00, $f6        ;; 24:4fd8 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:4fe0 ????????
    db   $17, $e1, $ff, $e2, $77, $e2, $57, $25        ;; 24:4fe8 ????????
    db   $01, $28, $01, $27, $01, $29, $01, $2a        ;; 24:4ff0 ????????
    db   $01, $2b, $01, $2c, $01, $2d, $01, $2e        ;; 24:4ff8 ????????
    db   $01, $2f, $01, $30, $01, $31, $01, $e2        ;; 24:5000 ????????
    db   $07, $49, $1e, $ff, $04, $f6, $00, $f6        ;; 24:5008 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:5010 ????????
    db   $13, $f1, $57, $f2, $27, $f3, $80, $f1        ;; 24:5018 ????????
    db   $57, $f2, $27, $19, $78, $ff, $04, $f6        ;; 24:5020 ????????
    db   $00, $f6, $80, $f6, $88, $f5, $ff, $f4        ;; 24:5028 ????????
    db   $77, $f0, $13, $f1, $57, $f2, $27, $f2        ;; 24:5030 ????????
    db   $27, $f1, $1b, $19, $0a, $f1, $37, $19        ;; 24:5038 ????????
    db   $1e, $49, $78, $ff, $01, $f6, $00, $f6        ;; 24:5040 ????????
    db   $80, $f6, $81, $f5, $ff, $f4, $77, $e0        ;; 24:5048 ????????
    db   $3b, $e1, $ff, $e2, $77, $e2, $57, $31        ;; 24:5050 ????????
    db   $04, $30, $04, $2f, $04, $2e, $04, $e2        ;; 24:5058 ????????
    db   $37, $30, $04, $2f, $04, $2e, $04, $2d        ;; 24:5060 ????????
    db   $04, $e2, $17, $2f, $04, $2e, $04, $2d        ;; 24:5068 ????????
    db   $04, $49, $14, $e2, $07, $49, $78, $ff        ;; 24:5070 ????????
    db   $04, $f6, $00, $f6, $80, $f6, $88, $f5        ;; 24:5078 ????????
    db   $ff, $f4, $77, $f0, $13, $f1, $57, $f2        ;; 24:5080 ????????
    db   $27, $f3, $80, $f1, $5f, $f2, $27, $19        ;; 24:5088 ????????
    db   $64, $f1, $57, $f2, $27, $49, $64, $ff        ;; 24:5090 ????????
    db   $04, $f6, $00, $f6, $80, $f6, $88, $f5        ;; 24:5098 ????????
    db   $ff, $f4, $77, $f0, $13, $f1, $57, $f2        ;; 24:50a0 ????????
    db   $27, $f3, $80, $f1, $57, $f2, $27, $19        ;; 24:50a8 ????????
    db   $78, $ff, $04, $f6, $00, $f6, $80, $f6        ;; 24:50b0 ????????
    db   $88, $f5, $ff, $f4, $77, $f0, $13, $f1        ;; 24:50b8 ????????
    db   $57, $f2, $27, $f3, $80, $f1, $5f, $f2        ;; 24:50c0 ????????
    db   $27, $19, $78, $ff, $04, $f6, $00, $f6        ;; 24:50c8 ????????
    db   $80, $f6, $88, $f5, $ff, $f4, $77, $f0        ;; 24:50d0 ????????
    db   $13, $f1, $57, $f2, $27, $f3, $80, $f1        ;; 24:50d8 ????????
    db   $57, $f2, $27, $19, $78, $ff, $01, $f6        ;; 24:50e0 ????????
    db   $00, $f6, $80, $f6, $81, $f5, $ff, $f4        ;; 24:50e8 ????????
    db   $77, $e0, $00, $e1, $ff, $e2, $77, $e2        ;; 24:50f0 ????????
    db   $57, $01, $05, $49, $14, $e2, $07, $49        ;; 24:50f8 ????????
    db   $1e, $ff, $01, $f6, $00, $f6, $80, $f6        ;; 24:5100 ????????
    db   $81, $f5, $ff, $f4, $77, $e0, $00, $e1        ;; 24:5108 ????????
    db   $ff, $e2, $77, $e2, $13, $25, $0a, $3d        ;; 24:5110 ????????
    db   $32, $e2, $07, $49, $1e, $ff, $01, $00        ;; 24:5118 ????????
    db   $0a, $ff, $02, $00, $0a, $ff, $03, $00        ;; 24:5120 ????????
    db   $0a, $ff, $04, $00, $0a, $ff                  ;; 24:5128 ??????
