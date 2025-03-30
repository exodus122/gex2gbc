;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; Note: All of the code in this file is identical in banks 0x21, 0x22, 0x23, and 0x24. This is a duplicated 
; audio engine. The data that follows the code is different and contains different songs or sound effects.

SECTION "bank24", ROMX[$4000], BANK[$24]

entry_24_4000:
    ld   HL, data_24_4460                              ;; 24:4000 $21 $60 $44
    ld   A, L                                          ;; 24:4003 $7d
    ld   [wDFAE_AudioBankDataPointer], A                                    ;; 24:4004 $ea $ae $df
    ld   A, H                                          ;; 24:4007 $7c
    ld   [wDFAF_AudioBankDataPointer], A                                    ;; 24:4008 $ea $af $df
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
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 24:407f $fa $ae $df
    ld   E, A                                          ;; 24:4082 $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 24:4083 $fa $af $df
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
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 24:409a $fa $ae $df
    ld   E, A                                          ;; 24:409d $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 24:409e $fa $af $df
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
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 21:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 21:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 21:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 21:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 21:43be ????????

data_24_43c6:
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 21:43c6 ????????

data_24_43ce:
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

data_24_4460:
audio_bank24.bin:
    INCBIN "audio/bank_24/audio_bank24.bin"

audio_24_44e4:
    INCBIN "./audio/bank_24/audio_24_44e4.bin"
audio_24_44fc:
    INCBIN "./audio/bank_24/audio_24_44fc.bin"
audio_24_451e:
    INCBIN "./audio/bank_24/audio_24_451e.bin"
audio_24_453c:
    INCBIN "./audio/bank_24/audio_24_453c.bin"
audio_24_4582:
    INCBIN "./audio/bank_24/audio_24_4582.bin"
audio_24_45ee:
    INCBIN "./audio/bank_24/audio_24_45ee.bin"
audio_24_4600:
    INCBIN "./audio/bank_24/audio_24_4600.bin"
audio_24_4640:
    INCBIN "./audio/bank_24/audio_24_4640.bin"
audio_24_4652:
    INCBIN "./audio/bank_24/audio_24_4652.bin"
audio_24_4664:
    INCBIN "./audio/bank_24/audio_24_4664.bin"
audio_24_467e:
    INCBIN "./audio/bank_24/audio_24_467e.bin"
audio_24_4696:
    INCBIN "./audio/bank_24/audio_24_4696.bin"
audio_24_46b4:
    INCBIN "./audio/bank_24/audio_24_46b4.bin"
audio_24_46e2:
    INCBIN "./audio/bank_24/audio_24_46e2.bin"
audio_24_4744:
    INCBIN "./audio/bank_24/audio_24_4744.bin"
audio_24_478c:
    INCBIN "./audio/bank_24/audio_24_478c.bin"
audio_24_47e8:
    INCBIN "./audio/bank_24/audio_24_47e8.bin"
audio_24_4838:
    INCBIN "./audio/bank_24/audio_24_4838.bin"
audio_24_49ea:
    INCBIN "./audio/bank_24/audio_24_49ea.bin"
audio_24_4a02:
    INCBIN "./audio/bank_24/audio_24_4a02.bin"
audio_24_4a62:
    INCBIN "./audio/bank_24/audio_24_4a62.bin"
audio_24_4a94:
    INCBIN "./audio/bank_24/audio_24_4a94.bin"
audio_24_4ac6:
    INCBIN "./audio/bank_24/audio_24_4ac6.bin"
audio_24_4ade:
    INCBIN "./audio/bank_24/audio_24_4ade.bin"
audio_24_4afa:
    INCBIN "./audio/bank_24/audio_24_4afa.bin"
audio_24_4b10:
    INCBIN "./audio/bank_24/audio_24_4b10.bin"
audio_24_4b22:
    INCBIN "./audio/bank_24/audio_24_4b22.bin"
audio_24_4b3c:
    INCBIN "./audio/bank_24/audio_24_4b3c.bin"
audio_24_4b56:
    INCBIN "./audio/bank_24/audio_24_4b56.bin"
audio_24_4b64:
    INCBIN "./audio/bank_24/audio_24_4b64.bin"
audio_24_4b7e:
    INCBIN "./audio/bank_24/audio_24_4b7e.bin"
audio_24_4bdc:
    INCBIN "./audio/bank_24/audio_24_4bdc.bin"
audio_24_4bf4:
    INCBIN "./audio/bank_24/audio_24_4bf4.bin"
audio_24_4c3c:
    INCBIN "./audio/bank_24/audio_24_4c3c.bin"
audio_24_4c54:
    INCBIN "./audio/bank_24/audio_24_4c54.bin"
audio_24_4c9c:
    INCBIN "./audio/bank_24/audio_24_4c9c.bin"
audio_24_4ce4:
    INCBIN "./audio/bank_24/audio_24_4ce4.bin"
audio_24_4d00:
    INCBIN "./audio/bank_24/audio_24_4d00.bin"
audio_24_4d0e:
    INCBIN "./audio/bank_24/audio_24_4d0e.bin"
audio_24_4d3a:
    INCBIN "./audio/bank_24/audio_24_4d3a.bin"
audio_24_4da0:
    INCBIN "./audio/bank_24/audio_24_4da0.bin"
audio_24_4dc2:
    INCBIN "./audio/bank_24/audio_24_4dc2.bin"
audio_24_4e0a:
    INCBIN "./audio/bank_24/audio_24_4e0a.bin"
audio_24_4e22:
    INCBIN "./audio/bank_24/audio_24_4e22.bin"
audio_24_4e66:
    INCBIN "./audio/bank_24/audio_24_4e66.bin"
audio_24_4e92:
    INCBIN "./audio/bank_24/audio_24_4e92.bin"
audio_24_4ee8:
    INCBIN "./audio/bank_24/audio_24_4ee8.bin"
audio_24_4efe:
    INCBIN "./audio/bank_24/audio_24_4efe.bin"
audio_24_4f16:
    INCBIN "./audio/bank_24/audio_24_4f16.bin"
audio_24_4f30:
    INCBIN "./audio/bank_24/audio_24_4f30.bin"
audio_24_4f48:
    INCBIN "./audio/bank_24/audio_24_4f48.bin"
audio_24_4f54:
    INCBIN "./audio/bank_24/audio_24_4f54.bin"
audio_24_4f72:
    INCBIN "./audio/bank_24/audio_24_4f72.bin"
audio_24_4fa0:
    INCBIN "./audio/bank_24/audio_24_4fa0.bin"
audio_24_4fb8:
    INCBIN "./audio/bank_24/audio_24_4fb8.bin"
audio_24_4fd4:
    INCBIN "./audio/bank_24/audio_24_4fd4.bin"
audio_24_5006:
    INCBIN "./audio/bank_24/audio_24_5006.bin"
audio_24_5024:
    INCBIN "./audio/bank_24/audio_24_5024.bin"
audio_24_503c:
    INCBIN "./audio/bank_24/audio_24_503c.bin"
audio_24_5054:
    INCBIN "./audio/bank_24/audio_24_5054.bin"
audio_24_506c:
    INCBIN "./audio/bank_24/audio_24_506c.bin"
audio_24_5086:
    INCBIN "./audio/bank_24/audio_24_5086.bin"
audio_24_50a0:
    INCBIN "./audio/bank_24/audio_24_50a0.bin"
audio_24_50a2:
    INCBIN "./audio/bank_24/audio_24_50a2.bin"
audio_24_50a4:
    INCBIN "./audio/bank_24/audio_24_50a4.bin"
audio_24_50a6:
    INCBIN "./audio/bank_24/audio_24_50a6.bin"
