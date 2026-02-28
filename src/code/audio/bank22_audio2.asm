;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; Note: All of the code in this file is identical in banks 0x21, 0x22, 0x23, and 0x24. This is a duplicated 
; audio engine. The data that follows the code is different and contains different songs or sound effects.

SECTION "bank22", ROMX[$4000], BANK[$22]

call_22_4000:
    ld   HL, data_22_4460                              ;; 22:4000 $21 $60 $44
    ld   A, L                                          ;; 22:4003 $7d
    ld   [wDFAE_AudioBankDataPointer], A                                    ;; 22:4004 $ea $ae $df
    ld   A, H                                          ;; 22:4007 $7c
    ld   [wDFAF_AudioBankDataPointer], A                                    ;; 22:4008 $ea $af $df
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
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 22:407f $fa $ae $df
    ld   E, A                                          ;; 22:4082 $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 22:4083 $fa $af $df
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
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 22:409a $fa $ae $df
    ld   E, A                                          ;; 22:409d $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 22:409e $fa $af $df
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
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 21:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 21:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 21:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 21:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 21:43be ????????

data_22_43c6:
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 21:43c6 ????????

data_22_43ce:
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
    
data_22_4460:
audio_bank22.bin:
    INCBIN "data/audio/bank_22/audio_bank22.bin"

audio_22_44fe:
    INCBIN "data/audio/bank_22/audio_22_44fe.bin"
audio_22_49d4:
    INCBIN "data/audio/bank_22/audio_22_49d4.bin"
audio_22_4c64:
    INCBIN "data/audio/bank_22/audio_22_4c64.bin"
audio_22_4f95:
    INCBIN "data/audio/bank_22/audio_22_4f95.bin"
audio_22_4fa9:
    INCBIN "data/audio/bank_22/audio_22_4fa9.bin"
audio_22_510d:
    INCBIN "data/audio/bank_22/audio_22_510d.bin"
audio_22_5899:
    INCBIN "data/audio/bank_22/audio_22_5899.bin"
audio_22_5a96:
    INCBIN "data/audio/bank_22/audio_22_5a96.bin"
audio_22_5bbe:
    INCBIN "data/audio/bank_22/audio_22_5bbe.bin"
audio_22_5e90:
    INCBIN "data/audio/bank_22/audio_22_5e90.bin"
audio_22_60e7:
    INCBIN "data/audio/bank_22/audio_22_60e7.bin"
audio_22_6131:
    INCBIN "data/audio/bank_22/audio_22_6131.bin"
audio_22_6143:
    INCBIN "data/audio/bank_22/audio_22_6143.bin"
audio_22_6e05:
    INCBIN "data/audio/bank_21/audio_21_6e05.bin"
audio_22_6e2d:
    INCBIN "data/audio/bank_21/audio_21_6e2d.bin"
audio_22_6e6d:
    INCBIN "data/audio/bank_21/audio_21_6e6d.bin"
audio_22_6ed3:
    INCBIN "data/audio/bank_21/audio_21_6ed3.bin"
audio_22_6edf:
    INCBIN "data/audio/bank_21/audio_21_6edf.bin"
audio_22_6f19:
    INCBIN "data/audio/bank_21/audio_21_6f19.bin"
audio_22_6f25:
    INCBIN "data/audio/bank_21/audio_21_6f25.bin"
audio_22_6f31:
    INCBIN "data/audio/bank_21/audio_21_6f31.bin"
audio_22_6f45:
    INCBIN "data/audio/bank_21/audio_21_6f45.bin"
audio_22_6f57:
    INCBIN "data/audio/bank_21/audio_21_6f57.bin"
audio_22_6f77:
    INCBIN "data/audio/bank_21/audio_21_6f77.bin"
audio_22_6f9f:
    INCBIN "data/audio/bank_21/audio_21_6f9f.bin"
audio_22_6ffb:
    INCBIN "data/audio/bank_21/audio_21_6ffb.bin"
audio_22_7011:
    INCBIN "data/audio/bank_21/audio_21_7011.bin"
audio_22_7067:
    INCBIN "data/audio/bank_21/audio_21_7067.bin"
audio_22_70b1:
    INCBIN "data/audio/bank_21/audio_21_70b1.bin"
audio_22_725d:
    INCBIN "data/audio/bank_21/audio_21_725d.bin"
audio_22_727f:
    INCBIN "data/audio/bank_21/audio_21_727f.bin"
audio_22_72d3:
    INCBIN "data/audio/bank_21/audio_21_72d3.bin"
audio_22_72ff:
    INCBIN "data/audio/bank_21/audio_21_72ff.bin"
audio_22_732b:
    INCBIN "data/audio/bank_21/audio_21_732b.bin"
audio_22_733d:
    INCBIN "data/audio/bank_21/audio_21_733d.bin"
audio_22_7353:
    INCBIN "data/audio/bank_21/audio_21_7353.bin"
audio_22_7363:
    INCBIN "data/audio/bank_21/audio_21_7363.bin"
audio_22_736f:
    INCBIN "data/audio/bank_21/audio_21_736f.bin"
audio_22_7383:
    INCBIN "data/audio/bank_21/audio_21_7383.bin"
audio_22_7397:
    INCBIN "data/audio/bank_21/audio_21_7397.bin"
audio_22_739f:
    INCBIN "data/audio/bank_21/audio_21_739f.bin"
audio_22_73b3:
    INCBIN "data/audio/bank_21/audio_21_73b3.bin"
audio_22_73e5:
    INCBIN "data/audio/bank_21/audio_21_73e5.bin"
audio_22_73f3:
    INCBIN "data/audio/bank_21/audio_21_73f3.bin"
audio_22_7435:
    INCBIN "data/audio/bank_21/audio_21_7435.bin"
audio_22_7443:
    INCBIN "data/audio/bank_21/audio_21_7443.bin"
audio_22_747d:
    INCBIN "data/audio/bank_21/audio_21_747d.bin"
audio_22_748b:
    INCBIN "data/audio/bank_21/audio_21_748b.bin"
audio_22_74a1:
    INCBIN "data/audio/bank_21/audio_21_74a1.bin"
audio_22_74a7:
    INCBIN "data/audio/bank_21/audio_21_74a7.bin"
audio_22_74cd:
    INCBIN "data/audio/bank_21/audio_21_74cd.bin"
audio_22_74dd:
    INCBIN "data/audio/bank_21/audio_21_74dd.bin"
audio_22_74e3:
    INCBIN "data/audio/bank_21/audio_21_74e3.bin"
audio_22_74f1:
    INCBIN "data/audio/bank_21/audio_21_74f1.bin"
audio_22_7501:
    INCBIN "data/audio/bank_21/audio_21_7501.bin"
audio_22_753f:
    INCBIN "data/audio/bank_21/audio_21_753f.bin"
audio_22_7565:
    INCBIN "data/audio/bank_21/audio_21_7565.bin"
audio_22_7575:
    INCBIN "data/audio/bank_21/audio_21_7575.bin"
audio_22_75bb:
    INCBIN "data/audio/bank_21/audio_21_75bb.bin"
audio_22_75e5:
    INCBIN "data/audio/bank_21/audio_21_75e5.bin"
audio_22_75f9:
    INCBIN "data/audio/bank_21/audio_21_75f9.bin"
audio_22_760d:
    INCBIN "data/audio/bank_21/audio_21_760d.bin"
audio_22_7617:
    INCBIN "data/audio/bank_21/audio_21_7617.bin"
audio_22_7649:
    INCBIN "data/audio/bank_21/audio_21_7649.bin"
audio_22_7671:
    INCBIN "data/audio/bank_21/audio_21_7671.bin"
audio_22_76a3:
    INCBIN "data/audio/bank_21/audio_21_76a3.bin"
audio_22_76b9:
    INCBIN "data/audio/bank_21/audio_21_76b9.bin"
audio_22_76e5:
    INCBIN "data/audio/bank_21/audio_21_76e5.bin"
audio_22_76f3:
    INCBIN "data/audio/bank_21/audio_21_76f3.bin"
audio_22_771d:
    INCBIN "data/audio/bank_21/audio_21_771d.bin"
audio_22_772b:
    INCBIN "data/audio/bank_21/audio_21_772b.bin"
audio_22_7781:
    INCBIN "data/audio/bank_21/audio_21_7781.bin"
audio_22_7795:
    INCBIN "data/audio/bank_21/audio_21_7795.bin"
audio_22_77a9:
    INCBIN "data/audio/bank_21/audio_21_77a9.bin"
audio_22_77ab:
    INCBIN "data/audio/bank_21/audio_21_77ab.bin"
audio_22_77ad:
    INCBIN "data/audio/bank_21/audio_21_77ad.bin"
audio_22_77af:
    INCBIN "data/audio/bank_21/audio_21_77af.bin"
