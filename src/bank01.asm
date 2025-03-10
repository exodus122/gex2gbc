;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "bank01", ROMX[$4000], BANK[$01]

call_01_4000:
    ld   HL, wD6DD                                     ;; 01:4000 $21 $dd $d6
    ld   [HL], $00                                     ;; 01:4003 $36 $00
.jp_01_4005:
    ld   [wD6DE_MenuType], A                                    ;; 01:4005 $ea $de $d6
    ld   L, A                                          ;; 01:4008 $6f
    ld   H, $00                                        ;; 01:4009 $26 $00
    add  HL, HL                                        ;; 01:400b $29
    add  HL, HL                                        ;; 01:400c $29
    add  HL, HL                                        ;; 01:400d $29
    ld   DE, data_01_5574                              ;; 01:400e $11 $74 $55
    add  HL, DE                                        ;; 01:4011 $19
    ld   DE, wD68A                                     ;; 01:4012 $11 $8a $d6
    ld   BC, $08                                       ;; 01:4015 $01 $08 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4018 $cd $b0 $07
    xor  A, A                                          ;; 01:401b $af
    ld   [wD6E0_MenuSelectedRow], A                                    ;; 01:401c $ea $e0 $d6
    ld   A, [wD68C]                                    ;; 01:401f $fa $8c $d6
    and  A, $02                                        ;; 01:4022 $e6 $02
    jr   Z, .jr_01_402e                                ;; 01:4024 $28 $08
    ld   A, [wD68D]                                    ;; 01:4026 $fa $8d $d6
    and  A, A                                          ;; 01:4029 $a7
    jr   Z, .jr_01_402e                                ;; 01:402a $28 $02
    ld   A, $01                                        ;; 01:402c $3e $01
.jr_01_402e:
    ld   [wD6DF_MenuSelectedColumn], A                                    ;; 01:402e $ea $df $d6
    ld   HL, wD68A                                     ;; 01:4031 $21 $8a $d6
    ld   A, [HL+]                                      ;; 01:4034 $2a
    ld   H, [HL]                                       ;; 01:4035 $66
    ld   L, A                                          ;; 01:4036 $6f
    call call_01_446f                                  ;; 01:4037 $cd $6f $44
.jp_01_403a:
    ld   A, $ff                                        ;; 01:403a $3e $ff
    ld   [wD619], A                                    ;; 01:403c $ea $19 $d6
    ld   [wD6D6], A                                    ;; 01:403f $ea $d6 $d6
    ld   A, $05                                        ;; 01:4042 $3e $05
    ld   [wD61A], A                                    ;; 01:4044 $ea $1a $d6
    call call_01_4e94                                  ;; 01:4047 $cd $94 $4e
    ld   A, [wD6DE_MenuType]                                    ;; 01:404a $fa $de $d6
    cp   A, $14                                        ;; 01:404d $fe $14
    jr   NZ, .jp_01_405c                               ;; 01:404f $20 $0b
    ld   B, $b4                                        ;; 01:4051 $06 $b4
.jr_01_4053:
    push BC                                            ;; 01:4053 $c5
    call call_00_0ab4                                  ;; 01:4054 $cd $b4 $0a
    pop  BC                                            ;; 01:4057 $c1
    dec  B                                             ;; 01:4058 $05
    jr   NZ, .jr_01_4053                               ;; 01:4059 $20 $f8
    ret                                                ;; 01:405b $c9
.jp_01_405c:
    call call_01_4d72                                  ;; 01:405c $cd $72 $4d
    call call_00_0ab4                                  ;; 01:405f $cd $b4 $0a
    ld   HL, wD6D6                                     ;; 01:4062 $21 $d6 $d6
    dec  [HL]                                          ;; 01:4065 $35
    call call_01_4d25                                  ;; 01:4066 $cd $25 $4d
    ld   A, [wD68C]                                    ;; 01:4069 $fa $8c $d6
    ld   C, A                                          ;; 01:406c $4f
    and  A, $80                                        ;; 01:406d $e6 $80
    jr   Z, .jr_01_4082                                ;; 01:406f $28 $11
    ld   A, C                                          ;; 01:4071 $79
    and  A, $04                                        ;; 01:4072 $e6 $04
    jr   Z, .jr_01_408f                                ;; 01:4074 $28 $19
    ld   A, [wD61E]                                    ;; 01:4076 $fa $1e $d6
    and  A, A                                          ;; 01:4079 $a7
    jr   Z, .jr_01_408f                                ;; 01:407a $28 $13
    ld   A, [wD619]                                    ;; 01:407c $fa $19 $d6
    and  A, A                                          ;; 01:407f $a7
    jr   Z, .jr_01_408c                                ;; 01:4080 $28 $0a
.jr_01_4082:
    ld   HL, wD619                                     ;; 01:4082 $21 $19 $d6
    dec  [HL]                                          ;; 01:4085 $35
    jr   NZ, .jr_01_408f                               ;; 01:4086 $20 $07
    inc  HL                                            ;; 01:4088 $23
    dec  [HL]                                          ;; 01:4089 $35
    jr   NZ, .jr_01_408f                               ;; 01:408a $20 $03
.jr_01_408c:
    ld   A, $70                                        ;; 01:408c $3e $70
    ret                                                ;; 01:408e $c9
.jr_01_408f:
    ld   A, [wD68C]                                    ;; 01:408f $fa $8c $d6
    and  A, $02                                        ;; 01:4092 $e6 $02
    jp   Z, .jp_01_413a                                ;; 01:4094 $ca $3a $41
    ld   A, [wD59F_CurrentInputs]                                    ;; 01:4097 $fa $9f $d5
    and  A, $03                                        ;; 01:409a $e6 $03
    jr   Z, .jr_01_40d0                                ;; 01:409c $28 $32
    ld   A, [wD59F_CurrentInputs]                                    ;; 01:409e $fa $9f $d5
    and  A, $f0                                        ;; 01:40a1 $e6 $f0
    swap A                                             ;; 01:40a3 $cb $37
    ld   E, A                                          ;; 01:40a5 $5f
    ld   A, [wD59F_CurrentInputs]                                    ;; 01:40a6 $fa $9f $d5
    and  A, $01                                        ;; 01:40a9 $e6 $01
    jr   NZ, .jr_01_40af                               ;; 01:40ab $20 $02
    set  4, E                                          ;; 01:40ad $cb $e3
.jr_01_40af:
    ld   D, $00                                        ;; 01:40af $16 $00
    ld   HL, data_01_5c99                              ;; 01:40b1 $21 $99 $5c
    add  HL, DE                                        ;; 01:40b4 $19
    ld   C, [HL]                                       ;; 01:40b5 $4e
    call call_01_4f1b                                  ;; 01:40b6 $cd $1b $4f
    cp   A, $49                                        ;; 01:40b9 $fe $49
    jp   Z, .jp_01_421e                                ;; 01:40bb $ca $1e $42
    cp   A, $4a                                        ;; 01:40be $fe $4a
    jr   Z, .jr_01_40cd                                ;; 01:40c0 $28 $0b
    ld   A, C                                          ;; 01:40c2 $79
    cp   A, $20                                        ;; 01:40c3 $fe $20
    jr   Z, .jp_01_405c                                ;; 01:40c5 $28 $95
    ld   [HL], C                                       ;; 01:40c7 $71
    call call_01_4ecf                                  ;; 01:40c8 $cd $cf $4e
    jr   .jp_01_4132                                   ;; 01:40cb $18 $65
.jr_01_40cd:
    ld   A, $30                                        ;; 01:40cd $3e $30
    ret                                                ;; 01:40cf $c9
.jr_01_40d0:
    ld   A, [wD68D]                                    ;; 01:40d0 $fa $8d $d6
    and  A, A                                          ;; 01:40d3 $a7
    jp   Z, .jp_01_405c                                ;; 01:40d4 $ca $5c $40
    call call_00_10fb                                  ;; 01:40d7 $cd $fb $10
    jr   Z, .jr_01_40f2                                ;; 01:40da $28 $16
    ld   HL, wD6DF_MenuSelectedColumn                                     ;; 01:40dc $21 $df $d6
    inc  [HL]                                          ;; 01:40df $34
    ld   A, [HL]                                       ;; 01:40e0 $7e
    sub  A, $06                                        ;; 01:40e1 $d6 $06
    jr   NZ, .jp_01_4132                               ;; 01:40e3 $20 $4d
    ld   [HL], A                                       ;; 01:40e5 $77
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:40e6 $21 $e0 $d6
    inc  [HL]                                          ;; 01:40e9 $34
    ld   A, [HL]                                       ;; 01:40ea $7e
    sub  A, $05                                        ;; 01:40eb $d6 $05
    jr   NZ, .jp_01_4132                               ;; 01:40ed $20 $43
    ld   [HL], A                                       ;; 01:40ef $77
    jr   .jp_01_4132                                   ;; 01:40f0 $18 $40
.jr_01_40f2:
    call call_00_10f5                                  ;; 01:40f2 $cd $f5 $10
    jr   Z, .jr_01_410d                                ;; 01:40f5 $28 $16
    ld   HL, wD6DF_MenuSelectedColumn                                     ;; 01:40f7 $21 $df $d6
    dec  [HL]                                          ;; 01:40fa $35
    bit  7, [HL]                                       ;; 01:40fb $cb $7e
    jr   Z, .jp_01_4132                                ;; 01:40fd $28 $33
    ld   [HL], $05                                     ;; 01:40ff $36 $05
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4101 $21 $e0 $d6
    dec  [HL]                                          ;; 01:4104 $35
    bit  7, [HL]                                       ;; 01:4105 $cb $7e
    jr   Z, .jp_01_4132                                ;; 01:4107 $28 $29
    ld   [HL], $04                                     ;; 01:4109 $36 $04
    jr   .jp_01_4132                                   ;; 01:410b $18 $25
.jr_01_410d:
    call call_00_1107                                  ;; 01:410d $cd $07 $11
    jr   Z, .jr_01_411f                                ;; 01:4110 $28 $0d
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4112 $21 $e0 $d6
    inc  [HL]                                          ;; 01:4115 $34
    ld   A, [HL]                                       ;; 01:4116 $7e
    cp   A, $05                                        ;; 01:4117 $fe $05
    jr   C, .jp_01_4132                                ;; 01:4119 $38 $17
    dec  [HL]                                          ;; 01:411b $35
    jp   .jp_01_403a                                   ;; 01:411c $c3 $3a $40
.jr_01_411f:
    call call_00_1101                                  ;; 01:411f $cd $01 $11
    jp   Z, .jp_01_405c                                ;; 01:4122 $ca $5c $40
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4125 $21 $e0 $d6
    dec  [HL]                                          ;; 01:4128 $35
    bit  7, [HL]                                       ;; 01:4129 $cb $7e
    jp   Z, .jp_01_4132                                ;; 01:412b $ca $32 $41
    inc  [HL]                                          ;; 01:412e $34
    jp   .jp_01_403a                                   ;; 01:412f $c3 $3a $40
.jp_01_4132:
    ld   A, $00                                        ;; 01:4132 $3e $00
    call call_00_113e                                  ;; 01:4134 $cd $3e $11
    jp   .jp_01_403a                                   ;; 01:4137 $c3 $3a $40
.jp_01_413a:
    ld   A, [wD68D]                                    ;; 01:413a $fa $8d $d6
    and  A, A                                          ;; 01:413d $a7
    jr   Z, .jr_01_416a                                ;; 01:413e $28 $2a
    call call_00_1101                                  ;; 01:4140 $cd $01 $11
    jr   Z, .jr_01_414f                                ;; 01:4143 $28 $0a
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4145 $21 $e0 $d6
    ld   A, [HL]                                       ;; 01:4148 $7e
    and  A, A                                          ;; 01:4149 $a7
    jr   Z, .jr_01_416a                                ;; 01:414a $28 $1e
    dec  [HL]                                          ;; 01:414c $35
    jr   .jr_01_415f                                   ;; 01:414d $18 $10
.jr_01_414f:
    call call_00_1107                                  ;; 01:414f $cd $07 $11
    jr   Z, .jr_01_416a                                ;; 01:4152 $28 $16
    ld   A, [wD68D]                                    ;; 01:4154 $fa $8d $d6
    dec  A                                             ;; 01:4157 $3d
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4158 $21 $e0 $d6
    cp   A, [HL]                                       ;; 01:415b $be
    jr   Z, .jr_01_416a                                ;; 01:415c $28 $0c
    inc  [HL]                                          ;; 01:415e $34
.jr_01_415f:
    ld   A, $00                                        ;; 01:415f $3e $00
    call call_00_113e                                  ;; 01:4161 $cd $3e $11
    call call_01_43e6                                  ;; 01:4164 $cd $e6 $43
    jp   .jp_01_403a                                   ;; 01:4167 $c3 $3a $40
.jr_01_416a:
    ld   A, [wD68C]                                    ;; 01:416a $fa $8c $d6
    and  A, $01                                        ;; 01:416d $e6 $01
    jr   Z, .jr_01_41b5                                ;; 01:416f $28 $44
.jr_01_4171:
    call call_00_10fb                                  ;; 01:4171 $cd $fb $10
    jr   Z, .jr_01_4187                                ;; 01:4174 $28 $11
    ld   HL, wD625_TotalsMenuPage                                     ;; 01:4176 $21 $25 $d6
    inc  [HL]                                          ;; 01:4179 $34
    ld   A, [HL]                                       ;; 01:417a $7e
    sub  A, $1e                                        ;; 01:417b $d6 $1e
    jr   NZ, .jr_01_4180                               ;; 01:417d $20 $01
    ld   [HL], A                                       ;; 01:417f $77
.jr_01_4180:
    call call_01_4265                                  ;; 01:4180 $cd $65 $42
    jr   Z, .jr_01_4171                                ;; 01:4183 $28 $ec
    jr   .jr_01_419b                                   ;; 01:4185 $18 $14
.jr_01_4187:
    call call_00_10f5                                  ;; 01:4187 $cd $f5 $10
    jr   Z, .jr_01_41b5                                ;; 01:418a $28 $29
    ld   HL, wD625_TotalsMenuPage                                     ;; 01:418c $21 $25 $d6
    dec  [HL]                                          ;; 01:418f $35
    bit  7, [HL]                                       ;; 01:4190 $cb $7e
    jr   Z, .jr_01_4196                                ;; 01:4192 $28 $02
    ld   [HL], $1d                                     ;; 01:4194 $36 $1d
.jr_01_4196:
    call call_01_4265                                  ;; 01:4196 $cd $65 $42
    jr   Z, .jr_01_4187                                ;; 01:4199 $28 $ec
.jr_01_419b:
    ld   A, [wD6DA]                                    ;; 01:419b $fa $da $d6
    call call_01_4d3b                                  ;; 01:419e $cd $3b $4d
    ld   HL, data_01_57a0                              ;; 01:41a1 $21 $a0 $57
    call call_01_44cf                                  ;; 01:41a4 $cd $cf $44
    ld   HL, $db6                                      ;; 01:41a7 $21 $b6 $0d
    call call_01_4d0a                                  ;; 01:41aa $cd $0a $4d
    ld   A, $01                                        ;; 01:41ad $3e $01
    call call_00_113e                                  ;; 01:41af $cd $3e $11
    jp   .jp_01_403a                                   ;; 01:41b2 $c3 $3a $40
.jr_01_41b5:
    call call_00_1129                                  ;; 01:41b5 $cd $29 $11
    jr   NZ, .jr_01_41f1                               ;; 01:41b8 $20 $37
    ld   A, [wD68C]                                    ;; 01:41ba $fa $8c $d6
    and  A, $40                                        ;; 01:41bd $e6 $40
    jp   NZ, .jp_01_405c                               ;; 01:41bf $c2 $5c $40
    call call_00_1123                                  ;; 01:41c2 $cd $23 $11
    jr   NZ, .jp_01_421e                               ;; 01:41c5 $20 $57
    ld   A, [wD68C]                                    ;; 01:41c7 $fa $8c $d6
    and  A, $08                                        ;; 01:41ca $e6 $08
    call NZ, call_00_1118                              ;; 01:41cc $c4 $18 $11
    jr   NZ, .jp_01_421e                               ;; 01:41cf $20 $4d
    ld   A, [wD68C]                                    ;; 01:41d1 $fa $8c $d6
    and  A, $10                                        ;; 01:41d4 $e6 $10
    call NZ, call_00_110d                              ;; 01:41d6 $c4 $0d $11
    jr   NZ, .jp_01_421e                               ;; 01:41d9 $20 $43
    ld   A, [wD68C]                                    ;; 01:41db $fa $8c $d6
    and  A, $20                                        ;; 01:41de $e6 $20
    call NZ, call_00_110d                              ;; 01:41e0 $c4 $0d $11
    jp   Z, .jp_01_405c                                ;; 01:41e3 $ca $5c $40
    ld   A, [wD6DE_MenuType]                                    ;; 01:41e6 $fa $de $d6
    ld   [wD6DD], A                                    ;; 01:41e9 $ea $dd $d6
    ld   A, $00                                        ;; 01:41ec $3e $00
    jp   .jp_01_4005                                   ;; 01:41ee $c3 $05 $40
.jr_01_41f1:
    call call_00_10eb                                  ;; 01:41f1 $cd $eb $10
    ld   A, [wD68D]                                    ;; 01:41f4 $fa $8d $d6
    and  A, A                                          ;; 01:41f7 $a7
    jr   Z, .jp_01_421e                                ;; 01:41f8 $28 $24
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:41fa $21 $e0 $d6
    ld   L, [HL]                                       ;; 01:41fd $6e
    ld   H, $00                                        ;; 01:41fe $26 $00
    ld   DE, wD6C5                                     ;; 01:4200 $11 $c5 $d6
    add  HL, DE                                        ;; 01:4203 $19
    ld   A, [HL]                                       ;; 01:4204 $7e
    cp   A, $10                                        ;; 01:4205 $fe $10
    ret  Z                                             ;; 01:4207 $c8
    cp   A, $90                                        ;; 01:4208 $fe $90
    jr   Z, .jr_01_4229                                ;; 01:420a $28 $1d
    cp   A, $30                                        ;; 01:420c $fe $30
    jr   Z, .jr_01_422f                                ;; 01:420e $28 $1f
    cp   A, $40                                        ;; 01:4210 $fe $40
    jr   Z, .jr_01_424f                                ;; 01:4212 $28 $3b
    cp   A, $50                                        ;; 01:4214 $fe $50
    jr   Z, .jr_01_4257                                ;; 01:4216 $28 $3f
    cp   A, $60                                        ;; 01:4218 $fe $60
    ret  Z                                             ;; 01:421a $c8
    cp   A, $80                                        ;; 01:421b $fe $80
    ret  Z                                             ;; 01:421d $c8
.jp_01_421e:
    call call_00_10eb                                  ;; 01:421e $cd $eb $10
    ld   A, [wD6DD]                                    ;; 01:4221 $fa $dd $d6
    and  A, A                                          ;; 01:4224 $a7
    jp   NZ, call_01_4000                              ;; 01:4225 $c2 $00 $40
    ret                                                ;; 01:4228 $c9
.jr_01_4229:
    call call_01_4291                                  ;; 01:4229 $cd $91 $42
.jr_01_422c:
    ld   A, $00                                        ;; 01:422c $3e $00
    ret                                                ;; 01:422e $c9
.jr_01_422f:
    call call_01_4f87                                  ;; 01:422f $cd $87 $4f
    ld   A, $0f                                        ;; 01:4232 $3e $0f
    call call_01_4000                                  ;; 01:4234 $cd $00 $40
    cp   A, $00                                        ;; 01:4237 $fe $00
    jr   Z, .jr_01_422c                                ;; 01:4239 $28 $f1
.jr_01_423b:
    call call_01_5271                                  ;; 01:423b $cd $71 $52
    cp   A, $30                                        ;; 01:423e $fe $30
    ret  Z                                             ;; 01:4240 $c8
    call call_01_4f87                                  ;; 01:4241 $cd $87 $4f
    ld   A, $15                                        ;; 01:4244 $3e $15
    call call_01_4000                                  ;; 01:4246 $cd $00 $40
    cp   A, $00                                        ;; 01:4249 $fe $00
    jr   Z, .jr_01_422c                                ;; 01:424b $28 $df
    jr   .jr_01_423b                                   ;; 01:424d $18 $ec
.jr_01_424f:
    call call_01_4fa5                                  ;; 01:424f $cd $a5 $4f
    ld   A, $06                                        ;; 01:4252 $3e $06
    jp   call_01_4000                                  ;; 01:4254 $c3 $00 $40
.jr_01_4257:
    ld   A, [wD624]                                    ;; 01:4257 $fa $24 $d6
    and  A, A                                          ;; 01:425a $a7
    ld   A, $01                                        ;; 01:425b $3e $01
    jp   Z, .jp_01_4005                                ;; 01:425d $ca $05 $40
    ld   A, $03                                        ;; 01:4260 $3e $03
    jp   .jp_01_4005                                   ;; 01:4262 $c3 $05 $40

call_01_4265:
    ld   HL, wD625_TotalsMenuPage                                     ;; 01:4265 $21 $25 $d6
    ld   L, [HL]                                       ;; 01:4268 $6e
    ld   H, $00                                        ;; 01:4269 $26 $00
    ld   DE, .data_01_4272                             ;; 01:426b $11 $72 $42
    add  HL, DE                                        ;; 01:426e $19
    ld   A, [HL]                                       ;; 01:426f $7e
    and  A, A                                          ;; 01:4270 $a7
    ret                                                ;; 01:4271 $c9
.data_01_4272:
    db   $01, $01, $01, $01, $01, $01, $00, $01        ;; 01:4272 ........
    db   $01, $01, $01, $01, $00, $01, $01, $00        ;; 01:427a ........
    db   $01, $00, $00, $00, $00, $01, $01, $01        ;; 01:4282 ........
    db   $01, $01, $01, $00, $00, $00, $01             ;; 01:428a ......?

call_01_4291:
    ld   A, $11                                        ;; 01:4291 $3e $11
    call call_01_4000                                  ;; 01:4293 $cd $00 $40
    ret                                                ;; 01:4296 $c9
    xor  A, A                                          ;; 01:4297 $af
    ld   [wD626], A                                    ;; 01:4298 $ea $26 $d6
.jr_01_429b:
    push AF                                            ;; 01:429b $f5
    call call_00_2e5f                                  ;; 01:429c $cd $5f $2e
    bit  7, [HL]                                       ;; 01:429f $cb $7e
    jr   NZ, .jr_01_42a7                               ;; 01:42a1 $20 $04
    ld   HL, wD626                                     ;; 01:42a3 $21 $26 $d6
    inc  [HL]                                          ;; 01:42a6 $34
.jr_01_42a7:
    pop  AF                                            ;; 01:42a7 $f1
    inc  A                                             ;; 01:42a8 $3c
    cp   A, $03                                        ;; 01:42a9 $fe $03
    jr   NZ, .jr_01_429b                               ;; 01:42ab $20 $ee
    ld   A, $08                                        ;; 01:42ad $3e $08
    ld   HL, wD626                                     ;; 01:42af $21 $26 $d6
    add  A, [HL]                                       ;; 01:42b2 $86
    call call_01_4000                                  ;; 01:42b3 $cd $00 $40
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:42b6 $fa $e0 $d6
    ld   [wD627], A                                    ;; 01:42b9 $ea $27 $d6
    ret                                                ;; 01:42bc $c9
    ld   A, [wD621]                                    ;; 01:42bd $fa $21 $d6
    and  A, $fb                                        ;; 01:42c0 $e6 $fb
    ld   [wD621], A                                    ;; 01:42c2 $ea $21 $d6
    ld   A, [wD624]                                    ;; 01:42c5 $fa $24 $d6
    and  A, A                                          ;; 01:42c8 $a7
    jr   Z, .jr_01_432b                                ;; 01:42c9 $28 $60
    ld   A, [wD623]                                    ;; 01:42cb $fa $23 $d6
    and  A, A                                          ;; 01:42ce $a7
    jr   Z, .jr_01_42e7                                ;; 01:42cf $28 $16
    ld   A, [wD621]                                    ;; 01:42d1 $fa $21 $d6
    and  A, $10                                        ;; 01:42d4 $e6 $10
    jr   Z, .jr_01_4319                                ;; 01:42d6 $28 $41
    ld   A, [wD621]                                    ;; 01:42d8 $fa $21 $d6
    and  A, $ef                                        ;; 01:42db $e6 $ef
    ld   [wD621], A                                    ;; 01:42dd $ea $21 $d6
    ld   A, $1b                                        ;; 01:42e0 $3e $1b
    call call_01_4000                                  ;; 01:42e2 $cd $00 $40
    jr   .jr_01_4319                                   ;; 01:42e5 $18 $32
.jr_01_42e7:
    call call_00_2e43                                  ;; 01:42e7 $cd $43 $2e
    ld   E, A                                          ;; 01:42ea $5f
    add  A, A                                          ;; 01:42eb $87
    add  A, E                                          ;; 01:42ec $83
    ld   E, A                                          ;; 01:42ed $5f
    ld   A, [wD647]                                    ;; 01:42ee $fa $47 $d6
    add  A, E                                          ;; 01:42f1 $83
    ld   E, A                                          ;; 01:42f2 $5f
    ld   HL, .data_01_4337                             ;; 01:42f3 $21 $37 $43
    add  HL, DE                                        ;; 01:42f6 $19
    ld   C, [HL]                                       ;; 01:42f7 $4e
    ld   HL, wD624                                     ;; 01:42f8 $21 $24 $d6
    ld   L, [HL]                                       ;; 01:42fb $6e
    ld   H, $00                                        ;; 01:42fc $26 $00
    ld   DE, wD629_RemoteProgressBitfields                                     ;; 01:42fe $11 $29 $d6
    add  HL, DE                                        ;; 01:4301 $19
    ld   A, [wD64C]                                    ;; 01:4302 $fa $4c $d6
    or   A, C                                          ;; 01:4305 $b1
    or   A, [HL]                                       ;; 01:4306 $b6
    ld   [HL], A                                       ;; 01:4307 $77
    ld   A, [wD624]                                    ;; 01:4308 $fa $24 $d6
    cp   A, $1e                                        ;; 01:430b $fe $1e
    jr   NZ, .jr_01_4314                               ;; 01:430d $20 $05
    call call_01_43c7                                  ;; 01:430f $cd $c7 $43
    jr   .jr_01_4319                                   ;; 01:4312 $18 $05
.jr_01_4314:
    ld   A, $0e                                        ;; 01:4314 $3e $0e
    call call_01_4000                                  ;; 01:4316 $cd $00 $40
.jr_01_4319:
    call call_01_4349                                  ;; 01:4319 $cd $49 $43
    ld   A, $05                                        ;; 01:431c $3e $05
    call call_01_4000                                  ;; 01:431e $cd $00 $40
    xor  A, A                                          ;; 01:4321 $af
    ld   [wD624], A                                    ;; 01:4322 $ea $24 $d6
    ld   A, $14                                        ;; 01:4325 $3e $14
    ld   [wD744], A                                    ;; 01:4327 $ea $44 $d7
    ret                                                ;; 01:432a $c9
.jr_01_432b:
    ld   A, [wD628]                                    ;; 01:432b $fa $28 $d6
    ld   [wD624], A                                    ;; 01:432e $ea $24 $d6
    ld   A, $00                                        ;; 01:4331 $3e $00
    ld   [wD744], A                                    ;; 01:4333 $ea $44 $d7
    ret                                                ;; 01:4336 $c9
.data_01_4337:
    db   $01, $02, $04, $01, $02, $00, $01, $00        ;; 01:4337 ????????
    db   $00, $01, $02, $00, $01, $00, $00, $20        ;; 01:433f ????????
    db   $00, $00                                      ;; 01:4347 ??

call_01_4349:
    ld   HL, wD652                                     ;; 01:4349 $21 $52 $d6
    ld   B, $0a                                        ;; 01:434c $06 $0a
    xor  A, A                                          ;; 01:434e $af
.jr_01_434f:
    ld   [HL+], A                                      ;; 01:434f $22
    dec  B                                             ;; 01:4350 $05
    jr   NZ, .jr_01_434f                               ;; 01:4351 $20 $fc
    ld   A, [wD624]                                    ;; 01:4353 $fa $24 $d6
    push AF                                            ;; 01:4356 $f5
    xor  A, A                                          ;; 01:4357 $af
    ld   [wD624], A                                    ;; 01:4358 $ea $24 $d6
    ld   HL, wD652                                     ;; 01:435b $21 $52 $d6
    ld   C, $80                                        ;; 01:435e $0e $80
.jr_01_4360:
    push HL                                            ;; 01:4360 $e5
    call call_00_2e43                                  ;; 01:4361 $cd $43 $2e
    ld   E, A                                          ;; 01:4364 $5f
    ld   D, $00                                        ;; 01:4365 $16 $00
    ld   HL, .data_01_43b6                             ;; 01:4367 $21 $b6 $43
    add  HL, DE                                        ;; 01:436a $19
    ld   A, [HL]                                       ;; 01:436b $7e
    ld   HL, wD624                                     ;; 01:436c $21 $24 $d6
    ld   L, [HL]                                       ;; 01:436f $6e
    ld   H, $00                                        ;; 01:4370 $26 $00
    ld   DE, wD629_RemoteProgressBitfields                                     ;; 01:4372 $11 $29 $d6
    add  HL, DE                                        ;; 01:4375 $19
    ld   E, [HL]                                       ;; 01:4376 $5e
    ld   D, A                                          ;; 01:4377 $57
    pop  HL                                            ;; 01:4378 $e1
    ld   B, $08                                        ;; 01:4379 $06 $08
.jr_01_437b:
    bit  7, D                                          ;; 01:437b $cb $7a
    jr   Z, .jr_01_438b                                ;; 01:437d $28 $0c
    bit  7, E                                          ;; 01:437f $cb $7b
    jr   Z, .jr_01_4386                                ;; 01:4381 $28 $03
    ld   A, [HL]                                       ;; 01:4383 $7e
    or   A, C                                          ;; 01:4384 $b1
    ld   [HL], A                                       ;; 01:4385 $77
.jr_01_4386:
    rrc  C                                             ;; 01:4386 $cb $09
    jr   NC, .jr_01_438b                               ;; 01:4388 $30 $01
    inc  HL                                            ;; 01:438a $23
.jr_01_438b:
    rlc  E                                             ;; 01:438b $cb $03
    rlc  D                                             ;; 01:438d $cb $02
    dec  B                                             ;; 01:438f $05
    jr   NZ, .jr_01_437b                               ;; 01:4390 $20 $e9
    ld   A, [wD624]                                    ;; 01:4392 $fa $24 $d6
    inc  A                                             ;; 01:4395 $3c
    ld   [wD624], A                                    ;; 01:4396 $ea $24 $d6
    cp   A, $1e                                        ;; 01:4399 $fe $1e
    jr   NZ, .jr_01_4360                               ;; 01:439b $20 $c3
    pop  AF                                            ;; 01:439d $f1
    ld   [wD624], A                                    ;; 01:439e $ea $24 $d6
    ld   A, [wD73D_LivesRemaining]                                    ;; 01:43a1 $fa $3d $d7
    ld   [wD65A], A                                    ;; 01:43a4 $ea $5a $d6
    ld   HL, wD652                                     ;; 01:43a7 $21 $52 $d6
    ld   B, $09                                        ;; 01:43aa $06 $09
    xor  A, A                                          ;; 01:43ac $af
.jr_01_43ad:
    add  A, [HL]                                       ;; 01:43ad $86
    inc  HL                                            ;; 01:43ae $23
    dec  B                                             ;; 01:43af $05
    jr   NZ, .jr_01_43ad                               ;; 01:43b0 $20 $fb
    ld   [wD65B], A                                    ;; 01:43b2 $ea $5b $d6
    ret                                                ;; 01:43b5 $c9
.data_01_43b6:
    db   $1f, $1b, $19, $03, $01, $20, $00, $3e        ;; 01:43b6 .......?
    db   $0c, $cd, $00, $40, $3e, $04, $c3, $00        ;; 01:43be ????????
    db   $40                                           ;; 01:43c6 ?

call_01_43c7:
    ld   A, $07                                        ;; 01:43c7 $3e $07
    call call_00_120c                                  ;; 01:43c9 $cd $0c $12
    ld   A, $12                                        ;; 01:43cc $3e $12
    call call_01_4000                                  ;; 01:43ce $cd $00 $40
    ld   A, $17                                        ;; 01:43d1 $3e $17
    call call_01_4000                                  ;; 01:43d3 $cd $00 $40
    ld   A, $18                                        ;; 01:43d6 $3e $18
    call call_01_4000                                  ;; 01:43d8 $cd $00 $40
    ld   A, $19                                        ;; 01:43db $3e $19
    call call_01_4000                                  ;; 01:43dd $cd $00 $40
    ld   A, $1a                                        ;; 01:43e0 $3e $1a
    call call_01_4000                                  ;; 01:43e2 $cd $00 $40
    ret                                                ;; 01:43e5 $c9

call_01_43e6:
    ld   HL, wD6DE_MenuType                                     ;; 01:43e6 $21 $de $d6
    ld   L, [HL]                                       ;; 01:43e9 $6e
    ld   H, $00                                        ;; 01:43ea $26 $00
    add  HL, HL                                        ;; 01:43ec $29
    ld   DE, .data_01_43f5                             ;; 01:43ed $11 $f5 $43
    add  HL, DE                                        ;; 01:43f0 $19
    ld   A, [HL+]                                      ;; 01:43f1 $2a
    ld   H, [HL]                                       ;; 01:43f2 $66
    ld   L, A                                          ;; 01:43f3 $6f
    jp   HL                                            ;; 01:43f4 $e9
.data_01_43f5:
    dw   .data_01_442d                                 ;; 01:43f5 pP
    dw   .data_01_442d                                 ;; 01:43f7 pP
    dw   .data_01_442d                                 ;; 01:43f9 pP
    dw   .data_01_442d                                 ;; 01:43fb pP
    db   $46, $44                                      ;; 01:43fd ??
    dw   .data_01_4446                                 ;; 01:43ff pP
    db   $6e, $44                                      ;; 01:4401 ??
    dw   .data_01_444c                                 ;; 01:4403 pP
    dw   .data_01_446e                                 ;; 01:4405 pP
    db   $6e, $44, $6e, $44                            ;; 01:4407 ????
    dw   .data_01_446e                                 ;; 01:440b pP
    db   $6e, $44, $6e, $44, $6e, $44, $6e, $44        ;; 01:440d ????????
    dw   .data_01_446e                                 ;; 01:4415 pP
    db   $5d, $44, $6e, $44                            ;; 01:4417 ????
    dw   .data_01_446e                                 ;; 01:441b pP
    dw   .data_01_446e                                 ;; 01:441d pP
    db   $6e, $44                                      ;; 01:441f ??
    dw   .data_01_446e                                 ;; 01:4421 pP
    db   $6e, $44, $6e, $44, $6e, $44, $6e, $44        ;; 01:4423 ????????
    db   $6e, $44                                      ;; 01:442b ??
.data_01_442d:
    ld   C, $4e                                        ;; 01:442d $0e $4e
    ld   B, $08                                        ;; 01:442f $06 $08
.jr_01_4431:
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:4431 $fa $e0 $d6
    ld   E, A                                          ;; 01:4434 $5f
    ld   A, C                                          ;; 01:4435 $79
    sub  A, B                                          ;; 01:4436 $90
.jr_01_4437:
    add  A, B                                          ;; 01:4437 $80
    dec  E                                             ;; 01:4438 $1d
    bit  7, E                                          ;; 01:4439 $cb $7b
    jr   Z, .jr_01_4437                                ;; 01:443b $28 $fa
    ld   HL, wD6EB                                     ;; 01:443d $21 $eb $d6
    ld   [HL], A                                       ;; 01:4440 $77
    ld   HL, wD6EC                                     ;; 01:4441 $21 $ec $d6
    ld   [HL], B                                       ;; 01:4444 $70
    ret                                                ;; 01:4445 $c9
.data_01_4446:
    ld   C, $16                                        ;; 01:4446 $0e $16
    ld   B, $08                                        ;; 01:4448 $06 $08
    jr   .jr_01_4431                                   ;; 01:444a $18 $e5
.data_01_444c:
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:444c $21 $e0 $d6
    ld   L, [HL]                                       ;; 01:444f $6e
    ld   H, $00                                        ;; 01:4450 $26 $00
    add  HL, HL                                        ;; 01:4452 $29
    ld   DE, $dd9                                      ;; 01:4453 $11 $d9 $0d
    add  HL, DE                                        ;; 01:4456 $19
    ld   A, [HL+]                                      ;; 01:4457 $2a
    ld   H, [HL]                                       ;; 01:4458 $66
    ld   L, A                                          ;; 01:4459 $6f
    jp   call_01_4d0a                                  ;; 01:445a $c3 $0a $4d
    db   $21, $e0, $d6, $6e, $26, $00, $29, $11        ;; 01:445d ????????
    db   $13, $0e, $19, $2a, $66, $6f, $c3, $0a        ;; 01:4465 ????????
    db   $4d                                           ;; 01:446d ?
.data_01_446e:
    ret                                                ;; 01:446e $c9

call_01_446f:
    push HL                                            ;; 01:446f $e5
    ld   A, $ff                                        ;; 01:4470 $3e $ff
    ld   [wD6C1], A                                    ;; 01:4472 $ea $c1 $d6
    xor  A, A                                          ;; 01:4475 $af
    ld   [wD6D8], A                                    ;; 01:4476 $ea $d8 $d6
    call call_00_0f38                                  ;; 01:4479 $cd $38 $0f
    call call_00_0ede                                  ;; 01:447c $cd $de $0e
    pop  HL                                            ;; 01:447f $e1
.jr_01_4480:
    ld   A, L                                          ;; 01:4480 $7d
    ld   [wD6B3], A                                    ;; 01:4481 $ea $b3 $d6
    ld   A, H                                          ;; 01:4484 $7c
    ld   [wD6B4], A                                    ;; 01:4485 $ea $b4 $d6
    ld   A, $ff                                        ;; 01:4488 $3e $ff
    ld   [wD6D7], A                                    ;; 01:448a $ea $d7 $d6
    call call_01_44d7                                  ;; 01:448d $cd $d7 $44
    ld   A, [wD6D7]                                    ;; 01:4490 $fa $d7 $d6
    cp   A, $ff                                        ;; 01:4493 $fe $ff
    jr   Z, .jr_01_449f                                ;; 01:4495 $28 $08
    ld   DE, data_01_568c                              ;; 01:4497 $11 $8c $56
    call call_00_07b9                                  ;; 01:449a $cd $b9 $07
    jr   .jr_01_4480                                   ;; 01:449d $18 $e1
.jr_01_449f:
    ld   HL, wD6DE_MenuType                                     ;; 01:449f $21 $de $d6
    ld   L, [HL]                                       ;; 01:44a2 $6e
    ld   H, $00                                        ;; 01:44a3 $26 $00
    add  HL, HL                                        ;; 01:44a5 $29
    ld   DE, data_01_5654                              ;; 01:44a6 $11 $54 $56
    add  HL, DE                                        ;; 01:44a9 $19
    ld   A, [HL+]                                      ;; 01:44aa $2a
    ld   [wD6E1], A                                    ;; 01:44ab $ea $e1 $d6
    ld   C, [HL]                                       ;; 01:44ae $4e
    ld   [wD59D], A                                    ;; 01:44af $ea $9d $d5
    ld   A, $0b                                        ;; 01:44b2 $3e $0b
    ld   HL, data_01_5537                              ;; 01:44b4 $21 $37 $55
    call call_00_1078_AltSwitchBank                                  ;; 01:44b7 $cd $78 $10
    ld   A, $ff                                        ;; 01:44ba $3e $ff
    ld   [wD6EB], A                                    ;; 01:44bc $ea $eb $d6
    call call_01_43e6                                  ;; 01:44bf $cd $e6 $43
    ld   A, $06                                        ;; 01:44c2 $3e $06
    call call_00_0bae                                  ;; 01:44c4 $cd $ae $0b
    ld   A, $d7                                        ;; 01:44c7 $3e $d7
    call call_00_0f56                                  ;; 01:44c9 $cd $56 $0f
    jp   call_00_0ab4                                  ;; 01:44cc $c3 $b4 $0a

call_01_44cf:
    ld   A, L                                          ;; 01:44cf $7d
    ld   [wD6B3], A                                    ;; 01:44d0 $ea $b3 $d6
    ld   A, H                                          ;; 01:44d3 $7c
    ld   [wD6B4], A                                    ;; 01:44d4 $ea $b4 $d6

call_01_44d7:
    ld   HL, wD6B3                                     ;; 01:44d7 $21 $b3 $d6
    ld   A, [HL+]                                      ;; 01:44da $2a
    ld   H, [HL]                                       ;; 01:44db $66
    ld   L, A                                          ;; 01:44dc $6f
    ld   A, [HL]                                       ;; 01:44dd $7e
    cp   A, $ff                                        ;; 01:44de $fe $ff
    ret  Z                                             ;; 01:44e0 $c8
    call call_01_44e6                                  ;; 01:44e1 $cd $e6 $44
    jr   call_01_44d7                                  ;; 01:44e4 $18 $f1

call_01_44e6:
    ld   HL, wD6B3                                     ;; 01:44e6 $21 $b3 $d6
    ld   E, [HL]                                       ;; 01:44e9 $5e
    inc  HL                                            ;; 01:44ea $23
    ld   D, [HL]                                       ;; 01:44eb $56
    ld   A, [DE]                                       ;; 01:44ec $1a
    inc  DE                                            ;; 01:44ed $13
    ld   [HL], D                                       ;; 01:44ee $72
    dec  HL                                            ;; 01:44ef $2b
    ld   [HL], E                                       ;; 01:44f0 $73
    ld   [wD6C4], A                                    ;; 01:44f1 $ea $c4 $d6
    ld   L, A                                          ;; 01:44f4 $6f
    ld   H, $00                                        ;; 01:44f5 $26 $00
    add  HL, HL                                        ;; 01:44f7 $29
    add  HL, HL                                        ;; 01:44f8 $29
    add  HL, HL                                        ;; 01:44f9 $29
    ld   DE, data_01_5324                              ;; 01:44fa $11 $24 $53
    add  HL, DE                                        ;; 01:44fd $19
    ld   DE, wD692                                     ;; 01:44fe $11 $92 $d6
    ld   BC, $06                                       ;; 01:4501 $01 $06 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4504 $cd $b0 $07
.jr_01_4507:
    ld   HL, wD6B3                                     ;; 01:4507 $21 $b3 $d6
    ld   A, [HL+]                                      ;; 01:450a $2a
    ld   H, [HL]                                       ;; 01:450b $66
    ld   L, A                                          ;; 01:450c $6f
    ld   DE, wD698                                     ;; 01:450d $11 $98 $d6
    ld   BC, $07                                       ;; 01:4510 $01 $07 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4513 $cd $b0 $07
    ld   A, L                                          ;; 01:4516 $7d
    ld   [wD6B3], A                                    ;; 01:4517 $ea $b3 $d6
    ld   A, H                                          ;; 01:451a $7c
    ld   [wD6B4], A                                    ;; 01:451b $ea $b4 $d6
    ld   A, [wD69D]                                    ;; 01:451e $fa $9d $d6
    and  A, $0f                                        ;; 01:4521 $e6 $0f
    ld   L, A                                          ;; 01:4523 $6f
    ld   H, $00                                        ;; 01:4524 $26 $00
    ld   DE, wD6C5                                     ;; 01:4526 $11 $c5 $d6
    add  HL, DE                                        ;; 01:4529 $19
    ld   A, [wD69D]                                    ;; 01:452a $fa $9d $d6
    and  A, $f0                                        ;; 01:452d $e6 $f0
    ld   [HL], A                                       ;; 01:452f $77
    ld   A, [wD69E]                                    ;; 01:4530 $fa $9e $d6
    and  A, $01                                        ;; 01:4533 $e6 $01
    call NZ, call_01_4bb7                              ;; 01:4535 $c4 $b7 $4b
    ld   A, [wD69C]                                    ;; 01:4538 $fa $9c $d6
    sub  A, $e0                                        ;; 01:453b $d6 $e0
    jr   C, .jr_01_4548                                ;; 01:453d $38 $09
    ld   DE, .data_01_4633                             ;; 01:453f $11 $33 $46
    call call_00_07b9                                  ;; 01:4542 $cd $b9 $07
    call call_00_10bd                                  ;; 01:4545 $cd $bd $10
.jr_01_4548:
    ld   A, [wD69E]                                    ;; 01:4548 $fa $9e $d6
    and  A, $02                                        ;; 01:454b $e6 $02
    call NZ, call_01_4a8f                              ;; 01:454d $c4 $8f $4a
    ld   A, [wD69E]                                    ;; 01:4550 $fa $9e $d6
    and  A, $80                                        ;; 01:4553 $e6 $80
    jr   Z, .jr_01_4507                                ;; 01:4555 $28 $b0
    ld   A, [wD69E]                                    ;; 01:4557 $fa $9e $d6
    and  A, $40                                        ;; 01:455a $e6 $40
    jp   NZ, .jp_01_45e5                               ;; 01:455c $c2 $e5 $45
    ld   HL, wD694                                     ;; 01:455f $21 $94 $d6
    ld   E, [HL]                                       ;; 01:4562 $5e
    ld   D, $00                                        ;; 01:4563 $16 $00
    inc  HL                                            ;; 01:4565 $23
    ld   L, [HL]                                       ;; 01:4566 $6e
    ld   H, D                                          ;; 01:4567 $62
    add  HL, HL                                        ;; 01:4568 $29
    add  HL, HL                                        ;; 01:4569 $29
    add  HL, HL                                        ;; 01:456a $29
    add  HL, HL                                        ;; 01:456b $29
    add  HL, HL                                        ;; 01:456c $29
    add  HL, DE                                        ;; 01:456d $19
    ld   DE, $9800                                     ;; 01:456e $11 $00 $98
    add  HL, DE                                        ;; 01:4571 $19
    ld   A, [wD69E]                                    ;; 01:4572 $fa $9e $d6
    and  A, $04                                        ;; 01:4575 $e6 $04
    jr   NZ, .jr_01_4586                               ;; 01:4577 $20 $0d
    ld   A, [wD692]                                    ;; 01:4579 $fa $92 $d6
    ld   B, A                                          ;; 01:457c $47
    ld   A, [wD693]                                    ;; 01:457d $fa $93 $d6
    ld   C, A                                          ;; 01:4580 $4f
    ld   DE, $2001                                     ;; 01:4581 $11 $01 $20
    jr   .jr_01_4591                                   ;; 01:4584 $18 $0b
.jr_01_4586:
    ld   A, [wD692]                                    ;; 01:4586 $fa $92 $d6
    ld   C, A                                          ;; 01:4589 $4f
    ld   A, [wD693]                                    ;; 01:458a $fa $93 $d6
    ld   B, A                                          ;; 01:458d $47
    ld   DE, $120                                      ;; 01:458e $11 $20 $01
.jr_01_4591:
    ld   A, [wD59E]                                    ;; 01:4591 $fa $9e $d5
    and  A, A                                          ;; 01:4594 $a7
    jr   Z, .jr_01_45cb                                ;; 01:4595 $28 $34
    push HL                                            ;; 01:4597 $e5
    push BC                                            ;; 01:4598 $c5
    ld   A, $01                                        ;; 01:4599 $3e $01
    ldh  [rVBK], A                                     ;; 01:459b $e0 $4f
    ld   A, [wD697]                                    ;; 01:459d $fa $97 $d6
    cp   A, $ff                                        ;; 01:45a0 $fe $ff
    jr   NZ, .jr_01_45af                               ;; 01:45a2 $20 $0b
    call call_00_08b1                                  ;; 01:45a4 $cd $b1 $08
    ld   A, $00                                        ;; 01:45a7 $3e $00
    ldh  [rVBK], A                                     ;; 01:45a9 $e0 $4f
    pop  BC                                            ;; 01:45ab $c1
    pop  HL                                            ;; 01:45ac $e1
    jr   .jr_01_45cb                                   ;; 01:45ad $18 $1c
.jr_01_45af:
    push BC                                            ;; 01:45af $c5
    push DE                                            ;; 01:45b0 $d5
    push DE                                            ;; 01:45b1 $d5
    push HL                                            ;; 01:45b2 $e5
    ld   D, $00                                        ;; 01:45b3 $16 $00
.jr_01_45b5:
    ld   [HL], A                                       ;; 01:45b5 $77
    add  HL, DE                                        ;; 01:45b6 $19
    dec  B                                             ;; 01:45b7 $05
    jr   NZ, .jr_01_45b5                               ;; 01:45b8 $20 $fb
    pop  HL                                            ;; 01:45ba $e1
    pop  DE                                            ;; 01:45bb $d1
    ld   E, D                                          ;; 01:45bc $5a
    ld   D, $00                                        ;; 01:45bd $16 $00
    add  HL, DE                                        ;; 01:45bf $19
    pop  DE                                            ;; 01:45c0 $d1
    pop  BC                                            ;; 01:45c1 $c1
    dec  C                                             ;; 01:45c2 $0d
    jr   NZ, .jr_01_45af                               ;; 01:45c3 $20 $ea
    ld   A, $00                                        ;; 01:45c5 $3e $00
    ldh  [rVBK], A                                     ;; 01:45c7 $e0 $4f
    pop  BC                                            ;; 01:45c9 $c1
    pop  HL                                            ;; 01:45ca $e1
.jr_01_45cb:
    ld   A, [wD696]                                    ;; 01:45cb $fa $96 $d6
.jr_01_45ce:
    push BC                                            ;; 01:45ce $c5
    push DE                                            ;; 01:45cf $d5
    push DE                                            ;; 01:45d0 $d5
    push HL                                            ;; 01:45d1 $e5
    ld   D, $00                                        ;; 01:45d2 $16 $00
.jr_01_45d4:
    ld   [HL], A                                       ;; 01:45d4 $77
    inc  A                                             ;; 01:45d5 $3c
    add  HL, DE                                        ;; 01:45d6 $19
    dec  B                                             ;; 01:45d7 $05
    jr   NZ, .jr_01_45d4                               ;; 01:45d8 $20 $fa
    pop  HL                                            ;; 01:45da $e1
    pop  DE                                            ;; 01:45db $d1
    ld   E, D                                          ;; 01:45dc $5a
    ld   D, $00                                        ;; 01:45dd $16 $00
    add  HL, DE                                        ;; 01:45df $19
    pop  DE                                            ;; 01:45e0 $d1
    pop  BC                                            ;; 01:45e1 $c1
    dec  C                                             ;; 01:45e2 $0d
    jr   NZ, .jr_01_45ce                               ;; 01:45e3 $20 $e9
.jp_01_45e5:
    ld   A, [wD69E]                                    ;; 01:45e5 $fa $9e $d6
    and  A, $20                                        ;; 01:45e8 $e6 $20
    ret  NZ                                            ;; 01:45ea $c0
    ld   A, [wD69E]                                    ;; 01:45eb $fa $9e $d6
    and  A, $04                                        ;; 01:45ee $e6 $04
    jr   NZ, .jr_01_45fe                               ;; 01:45f0 $20 $0c
    call call_01_4e5a                                  ;; 01:45f2 $cd $5a $4e
    call call_01_4e49                                  ;; 01:45f5 $cd $49 $4e
    ld   HL, wC000                                     ;; 01:45f8 $21 $00 $c0
    jp   call_00_07b0_CopyBytes                                  ;; 01:45fb $c3 $b0 $07
.jr_01_45fe:
    call call_01_4e49                                  ;; 01:45fe $cd $49 $4e
    ld   HL, wC000                                     ;; 01:4601 $21 $00 $c0
    ld   A, [wD692]                                    ;; 01:4604 $fa $92 $d6
    ld   C, A                                          ;; 01:4607 $4f
    ld   A, [wD693]                                    ;; 01:4608 $fa $93 $d6
    ld   B, A                                          ;; 01:460b $47
.jr_01_460c:
    push BC                                            ;; 01:460c $c5
    push HL                                            ;; 01:460d $e5
.jr_01_460e:
    push BC                                            ;; 01:460e $c5
    push HL                                            ;; 01:460f $e5
    ld   BC, $10                                       ;; 01:4610 $01 $10 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4613 $cd $b0 $07
    pop  HL                                            ;; 01:4616 $e1
    ld   A, [wD692]                                    ;; 01:4617 $fa $92 $d6
    swap A                                             ;; 01:461a $cb $37
    ld   B, A                                          ;; 01:461c $47
    and  A, $f0                                        ;; 01:461d $e6 $f0
    ld   C, A                                          ;; 01:461f $4f
    ld   A, B                                          ;; 01:4620 $78
    and  A, $0f                                        ;; 01:4621 $e6 $0f
    ld   B, A                                          ;; 01:4623 $47
    add  HL, BC                                        ;; 01:4624 $09
    pop  BC                                            ;; 01:4625 $c1
    dec  B                                             ;; 01:4626 $05
    jr   NZ, .jr_01_460e                               ;; 01:4627 $20 $e5
    pop  HL                                            ;; 01:4629 $e1
    ld   BC, $10                                       ;; 01:462a $01 $10 $00
    add  HL, BC                                        ;; 01:462d $09
    pop  BC                                            ;; 01:462e $c1
    dec  C                                             ;; 01:462f $0d
    jr   NZ, .jr_01_460c                               ;; 01:4630 $20 $da
    ret                                                ;; 01:4632 $c9
.data_01_4633:
    dw   .data_01_4653                                 ;; 01:4633 pP
    dw   call_01_465f                                  ;; 01:4635 pP
    dw   data_01_466b                                  ;; 01:4637 pP
    dw   data_01_4728                                  ;; 01:4639 pP
    dw   call_01_4734                                  ;; 01:463b pP
    dw   data_01_473a                                  ;; 01:463d pP
    db   $a4, $47                                      ;; 01:463f ??
    dw   data_01_47c5                                  ;; 01:4641 pP
    dw   data_01_47ea                                  ;; 01:4643 pP
    dw   data_01_4879                                  ;; 01:4645 pP
    dw   data_01_48df                                  ;; 01:4647 pP
    db   $fd, $48                                      ;; 01:4649 ??
    dw   data_01_4916                                  ;; 01:464b pP
    dw   data_01_491d                                  ;; 01:464d pP
    db   $69, $49, $d7, $49                            ;; 01:464f ????
.data_01_4653:
    ld   A, [wD69B]                                    ;; 01:4653 $fa $9b $d6
    ld   DE, data_01_74e9                              ;; 01:4656 $11 $e9 $74
    call call_00_07b9                                  ;; 01:4659 $cd $b9 $07
    jp   jp_01_4e78                                    ;; 01:465c $c3 $78 $4e

call_01_465f:
    ld   A, [wD69B]                                    ;; 01:465f $fa $9b $d6
    ld   DE, data_01_74ed                              ;; 01:4662 $11 $ed $74
    call call_00_07b9                                  ;; 01:4665 $cd $b9 $07
    jp   jp_01_4e78                                    ;; 01:4668 $c3 $78 $4e

data_01_466b:
    ld   HL, .data_01_46a8                             ;; 01:466b $21 $a8 $46
    ld   DE, wDA4B                                     ;; 01:466e $11 $4b $da
    ld   BC, $80                                       ;; 01:4671 $01 $80 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4674 $cd $b0 $07
    ld   [wD59D], A                                    ;; 01:4677 $ea $9d $d5
    ld   A, $0b                                        ;; 01:467a $3e $0b
    ld   HL, data_01_5d4b                              ;; 01:467c $21 $4b $5d
    call call_00_1078_AltSwitchBank                                  ;; 01:467f $cd $78 $10
    call call_00_2e3a                                  ;; 01:4682 $cd $3a $2e
    ld   DE, data_01_5cb9                              ;; 01:4685 $11 $b9 $5c
    call call_00_07b9                                  ;; 01:4688 $cd $b9 $07
    ld   A, [wD69A]                                    ;; 01:468b $fa $9a $d6
    ld   [wD696], A                                    ;; 01:468e $ea $96 $d6
    ld   A, $06                                        ;; 01:4691 $3e $06
    ld   [wD692], A                                    ;; 01:4693 $ea $92 $d6
    ld   A, $05                                        ;; 01:4696 $3e $05
    ld   [wD693], A                                    ;; 01:4698 $ea $93 $d6
    push HL                                            ;; 01:469b $e5
    call call_01_4e5a                                  ;; 01:469c $cd $5a $4e
    pop  HL                                            ;; 01:469f $e1
    ld   DE, wC000                                     ;; 01:46a0 $11 $00 $c0
    ld   A, $13                                        ;; 01:46a3 $3e $13
    jp   jp_00_07a1                                    ;; 01:46a5 $c3 $a1 $07
.data_01_46a8:
    db   $00, $00, $00, $02, $00, $00, $e0, $03        ;; 01:46a8 ........
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 01:46b0 ........
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 01:46b8 ........
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 01:46c0 ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 01:46c8 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 01:46d0 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:46d8 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:46e0 ........
    db   $00, $00, $00, $02, $00, $00, $e0, $03        ;; 01:46e8 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:46f0 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:46f8 ........
    db   $00, $00, $0f, $00, $17, $00, $1f, $00        ;; 01:4700 ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 01:4708 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 01:4710 ........
    db   $00, $00, $00, $00, $20, $03, $bf, $0b        ;; 01:4718 ........
    db   $00, $00, $1f, $00, $ff, $01, $7f, $03        ;; 01:4720 ........

data_01_4728:
    call call_00_2e3a                                  ;; 01:4728 $cd $3a $2e
    ld   DE, data_01_5ee7                              ;; 01:472b $11 $e7 $5e
    call call_00_07b9                                  ;; 01:472e $cd $b9 $07
    jp   call_01_4e6f                                  ;; 01:4731 $c3 $6f $4e

call_01_4734:
    call call_00_2e4c                                  ;; 01:4734 $cd $4c $2e
    jp   call_01_4e6f                                  ;; 01:4737 $c3 $6f $4e

data_01_473a:
    ld   A, [wD69B]                                    ;; 01:473a $fa $9b $d6
    cp   A, $03                                        ;; 01:473d $fe $03
    jr   NZ, .jr_01_4746                               ;; 01:473f $20 $05
    ld   A, [wD627]                                    ;; 01:4741 $fa $27 $d6
    or   A, $80                                        ;; 01:4744 $f6 $80
.jr_01_4746:
    push AF                                            ;; 01:4746 $f5
    and  A, $7f                                        ;; 01:4747 $e6 $7f
    call call_00_2e5f                                  ;; 01:4749 $cd $5f $2e
    call call_01_4e6f                                  ;; 01:474c $cd $6f $4e
    pop  AF                                            ;; 01:474f $f1
    bit  7, A                                          ;; 01:4750 $cb $7f
    ret  NZ                                            ;; 01:4752 $c0
    push AF                                            ;; 01:4753 $f5
    call call_01_4eb1                                  ;; 01:4754 $cd $b1 $4e
    push AF                                            ;; 01:4757 $f5
    ld   C, $ec                                        ;; 01:4758 $0e $ec
    ld   A, [wD59E]                                    ;; 01:475a $fa $9e $d5
    and  A, A                                          ;; 01:475d $a7
    jr   NZ, .jr_01_4769                               ;; 01:475e $20 $09
    ld   C, $e8                                        ;; 01:4760 $0e $e8
    ld   A, B                                          ;; 01:4762 $78
    cp   A, $20                                        ;; 01:4763 $fe $20
    jr   NZ, .jr_01_4769                               ;; 01:4765 $20 $02
    ld   C, $f0                                        ;; 01:4767 $0e $f0
.jr_01_4769:
    pop  AF                                            ;; 01:4769 $f1
    jr   NZ, .jr_01_476e                               ;; 01:476a $20 $02
    ld   C, $f4                                        ;; 01:476c $0e $f4
.jr_01_476e:
    ld   A, C                                          ;; 01:476e $79
    ld   [wD5A8], A                                    ;; 01:476f $ea $a8 $d5
    ld   A, [wD695]                                    ;; 01:4772 $fa $95 $d6
    add  A, $02                                        ;; 01:4775 $c6 $02
    add  A, A                                          ;; 01:4777 $87
    add  A, A                                          ;; 01:4778 $87
    add  A, A                                          ;; 01:4779 $87
    ld   [wD5A6_TextBuffer], A                                    ;; 01:477a $ea $a6 $d5
    ld   A, [wD694]                                    ;; 01:477d $fa $94 $d6
    inc  A                                             ;; 01:4780 $3c
    sub  A, $02                                        ;; 01:4781 $d6 $02
    add  A, A                                          ;; 01:4783 $87
    add  A, A                                          ;; 01:4784 $87
    add  A, A                                          ;; 01:4785 $87
    sub  A, $02                                        ;; 01:4786 $d6 $02
    ld   [wD5A7], A                                    ;; 01:4788 $ea $a7 $d5
    ld   A, B                                          ;; 01:478b $78
    cp   A, $20                                        ;; 01:478c $fe $20
    ld   A, $05                                        ;; 01:478e $3e $05
    jr   Z, .jr_01_4794                                ;; 01:4790 $28 $02
    ld   A, $03                                        ;; 01:4792 $3e $03
.jr_01_4794:
    ld   [wD5A9], A                                    ;; 01:4794 $ea $a9 $d5
    pop  AF                                            ;; 01:4797 $f1
    add  A, A                                          ;; 01:4798 $87
    add  A, $02                                        ;; 01:4799 $c6 $02
    ld   [wD6D5], A                                    ;; 01:479b $ea $d5 $d6
    ld   BC, $202                                      ;; 01:479e $01 $02 $02
    jp   call_01_4e01                                  ;; 01:47a1 $c3 $01 $4e
    db   $fa, $9b, $d6, $11, $b9, $47, $cd, $b9        ;; 01:47a4 ????????
    db   $07, $11, $a5, $d6, $01, $0a, $00, $cd        ;; 01:47ac ????????
    db   $b0, $07, $c3, $c3, $07, $bb, $47, $09        ;; 01:47b4 ????????
    db   $b6, $14, $12, $d0, $42, $00, $40, $d0        ;; 01:47bc ????????
    db   $02                                           ;; 01:47c4 ?

data_01_47c5:
    call call_01_465f                                  ;; 01:47c5 $cd $5f $46
    xor  A, A                                          ;; 01:47c8 $af
    ld   [wD6B9], A                                    ;; 01:47c9 $ea $b9 $d6
    ld   A, [wD692]                                    ;; 01:47cc $fa $92 $d6
    ld   [wD6BE], A                                    ;; 01:47cf $ea $be $d6
    ld   A, [wD693]                                    ;; 01:47d2 $fa $93 $d6
    ld   [wD6BF], A                                    ;; 01:47d5 $ea $bf $d6
    ld   A, $ff                                        ;; 01:47d8 $3e $ff
    ld   [wD6C0], A                                    ;; 01:47da $ea $c0 $d6
    ld   A, [wD69B]                                    ;; 01:47dd $fa $9b $d6
    sub  A, $00                                        ;; 01:47e0 $d6 $00
    add  A, $10                                        ;; 01:47e2 $c6 $10
    ld   [wD6C1], A                                    ;; 01:47e4 $ea $c1 $d6
    jp   call_01_4d72                                  ;; 01:47e7 $c3 $72 $4d

data_01_47ea:
    call call_01_47f6                                  ;; 01:47ea $cd $f6 $47
    call call_01_4ce5                                  ;; 01:47ed $cd $e5 $4c
    ld   HL, wD5A6_TextBuffer                                     ;; 01:47f0 $21 $a6 $d5
    jp   call_01_4e6f                                  ;; 01:47f3 $c3 $6f $4e

call_01_47f6:
    ld   A, [wD69B]                                    ;; 01:47f6 $fa $9b $d6
    ld   DE, .data_01_4800                             ;; 01:47f9 $11 $00 $48
    call call_00_07b9                                  ;; 01:47fc $cd $b9 $07
    jp   HL                                            ;; 01:47ff $e9
.data_01_4800:
    dw   .data_01_4814                                 ;; 01:4800 pP
    dw   .data_01_4818                                 ;; 01:4802 pP
    dw   .data_01_481c                                 ;; 01:4804 pP
    dw   .data_01_4820                                 ;; 01:4806 pP
    dw   .data_01_4824                                 ;; 01:4808 pP
    db   $28, $48, $34, $48, $47, $48, $69, $48        ;; 01:480a ????????
    db   $6e, $48                                      ;; 01:4812 ??
.data_01_4814:
    ld   A, [wD73D_LivesRemaining]                                    ;; 01:4814 $fa $3d $d7
    ret                                                ;; 01:4817 $c9
.data_01_4818:
    ld   A, [wD741_PlayerHealth]                                    ;; 01:4818 $fa $41 $d7
    ret                                                ;; 01:481b $c9
.data_01_481c:
    ld   C, $07                                        ;; 01:481c $0e $07
    jr   .jr_01_4852                                   ;; 01:481e $18 $32
.data_01_4820:
    ld   C, $18                                        ;; 01:4820 $0e $18
    jr   .jr_01_4852                                   ;; 01:4822 $18 $2e
.data_01_4824:
    ld   C, $20                                        ;; 01:4824 $0e $20
    jr   .jr_01_4852                                   ;; 01:4826 $18 $2a
    db   $fa, $48, $d6, $fe, $01, $3e, $1e, $d0        ;; 01:4828 ????????
    db   $fa, $49, $d6, $c9, $fa, $48, $d6, $fe        ;; 01:4830 ????????
    db   $02, $3e, $28, $d0, $fa, $48, $d6, $fe        ;; 01:4838 ????????
    db   $01, $fa, $49, $d6, $d0, $af, $c9, $fa        ;; 01:4840 ????????
    db   $48, $d6, $fe, $02, $fa, $49, $d6, $d0        ;; 01:4848 ????????
    db   $af, $c9                                      ;; 01:4850 ??
.jr_01_4852:
    ld   HL, wD629_RemoteProgressBitfields                                     ;; 01:4852 $21 $29 $d6
    ld   B, $1e                                        ;; 01:4855 $06 $1e
    ld   E, $00                                        ;; 01:4857 $1e $00
.jr_01_4859:
    ld   A, [HL+]                                      ;; 01:4859 $2a
    and  A, C                                          ;; 01:485a $a1
    ld   D, $08                                        ;; 01:485b $16 $08
.jr_01_485d:
    rlca                                               ;; 01:485d $07
    jr   NC, .jr_01_4861                               ;; 01:485e $30 $01
    inc  E                                             ;; 01:4860 $1c
.jr_01_4861:
    dec  D                                             ;; 01:4861 $15
    jr   NZ, .jr_01_485d                               ;; 01:4862 $20 $f9
    dec  B                                             ;; 01:4864 $05
    jr   NZ, .jr_01_4859                               ;; 01:4865 $20 $f2
    ld   A, E                                          ;; 01:4867 $7b
    ret                                                ;; 01:4868 $c9
    db   $21, $0e, $d2, $18, $03, $21, $10, $d2        ;; 01:4869 ????????
    db   $2a, $66, $6f, $29, $29, $29, $7c, $c9        ;; 01:4871 ????????

data_01_4879:
    ld   A, [wD69A]                                    ;; 01:4879 $fa $9a $d6
    and  A, A                                          ;; 01:487c $a7
    jr   Z, .jr_01_4888                                ;; 01:487d $28 $09
    ld   [wD6D8], A                                    ;; 01:487f $ea $d8 $d6
    ld   A, [wD69B]                                    ;; 01:4882 $fa $9b $d6
    ld   [wD6D9], A                                    ;; 01:4885 $ea $d9 $d6
.jr_01_4888:
    ld   A, [wD69B]                                    ;; 01:4888 $fa $9b $d6
    cp   A, $00                                        ;; 01:488b $fe $00
    jr   Z, .jr_01_4899                                ;; 01:488d $28 $0a
    cp   A, $07                                        ;; 01:488f $fe $07
    jr   NZ, .jr_01_48d0                               ;; 01:4891 $20 $3d
    ld   A, [wD624]                                    ;; 01:4893 $fa $24 $d6
    ld   [wD625_TotalsMenuPage], A                                    ;; 01:4896 $ea $25 $d6
.jr_01_4899:
    ld   A, [wD624]                                    ;; 01:4899 $fa $24 $d6
    push AF                                            ;; 01:489c $f5
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:489d $fa $25 $d6
    ld   [wD624], A                                    ;; 01:48a0 $ea $24 $d6
    ld   L, A                                          ;; 01:48a3 $6f
    ld   H, $00                                        ;; 01:48a4 $26 $00
    ld   DE, wD629_RemoteProgressBitfields                                     ;; 01:48a6 $11 $29 $d6
    add  HL, DE                                        ;; 01:48a9 $19
    ld   C, [HL]                                       ;; 01:48aa $4e
    ld   HL, wD5AA                                     ;; 01:48ab $21 $aa $d5
    ld   DE, .data_01_48d9                             ;; 01:48ae $11 $d9 $48
    ld   B, $06                                        ;; 01:48b1 $06 $06
.jr_01_48b3:
    ld   A, [DE]                                       ;; 01:48b3 $1a
    srl  C                                             ;; 01:48b4 $cb $39
    jr   C, .jr_01_48ba                                ;; 01:48b6 $38 $02
    add  A, $24                                        ;; 01:48b8 $c6 $24
.jr_01_48ba:
    ld   [HL+], A                                      ;; 01:48ba $22
    inc  DE                                            ;; 01:48bb $13
    dec  B                                             ;; 01:48bc $05
    jr   NZ, .jr_01_48b3                               ;; 01:48bd $20 $f4
    call call_00_2e43                                  ;; 01:48bf $cd $43 $2e
    ld   C, A                                          ;; 01:48c2 $4f
    ld   A, [wD69B]                                    ;; 01:48c3 $fa $9b $d6
    add  A, C                                          ;; 01:48c6 $81
    ld   C, A                                          ;; 01:48c7 $4f
    pop  AF                                            ;; 01:48c8 $f1
    ld   [wD624], A                                    ;; 01:48c9 $ea $24 $d6
    ld   A, C                                          ;; 01:48cc $79
    ld   [wD6DA], A                                    ;; 01:48cd $ea $da $d6
.jr_01_48d0:
    ld   DE, data_01_5aa9                              ;; 01:48d0 $11 $a9 $5a
    call call_00_07b9                                  ;; 01:48d3 $cd $b9 $07
    jp   jp_01_4dc8                                    ;; 01:48d6 $c3 $c8 $4d
.data_01_48d9:
    db   $98, $98, $98, $a4, $a4, $b0                  ;; 01:48d9 ......

data_01_48df:
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:48df $fa $25 $d6
    and  A, A                                          ;; 01:48e2 $a7
    jr   Z, .jr_01_48f7                                ;; 01:48e3 $28 $12
    ld   A, [wD624]                                    ;; 01:48e5 $fa $24 $d6
    push AF                                            ;; 01:48e8 $f5
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:48e9 $fa $25 $d6
    ld   [wD624], A                                    ;; 01:48ec $ea $24 $d6
    call call_01_4734                                  ;; 01:48ef $cd $34 $47
    pop  AF                                            ;; 01:48f2 $f1
    ld   [wD624], A                                    ;; 01:48f3 $ea $24 $d6
    ret                                                ;; 01:48f6 $c9
.jr_01_48f7:
    ld   HL, data_01_5d4b                              ;; 01:48f7 $21 $4b $5d
    jp   call_01_4e6f                                  ;; 01:48fa $c3 $6f $4e
    db   $21, $9b, $d6, $6e, $26, $00, $11, $67        ;; 01:48fd ????????
    db   $d6, $19, $7e, $ea, $0a, $d6, $3e, $80        ;; 01:4905 ????????
    db   $ea, $0b, $d6, $21, $0a, $d6, $c3, $6f        ;; 01:490d ????????
    db   $4e                                           ;; 01:4915 ?

data_01_4916:
    ld   A, [wD69B]                                    ;; 01:4916 $fa $9b $d6
    ld   [wD6D7], A                                    ;; 01:4919 $ea $d7 $d6
    ret                                                ;; 01:491c $c9

data_01_491d:
    ld   A, [wD69B]                                    ;; 01:491d $fa $9b $d6
    ld   DE, .data_01_4932                             ;; 01:4920 $11 $32 $49
    call call_00_07b9                                  ;; 01:4923 $cd $b9 $07
    ld   DE, wD6B0                                     ;; 01:4926 $11 $b0 $d6
    ld   BC, $03                                       ;; 01:4929 $01 $03 $00
    call call_00_07b0_CopyBytes                                  ;; 01:492c $cd $b0 $07
    jp   jp_00_084d                                    ;; 01:492f $c3 $4d $08
.data_01_4932:
    db   $48, $49, $4b, $49, $4e, $49, $51, $49        ;; 01:4932 ....????
    db   $54, $49, $57, $49, $5a, $49, $5d, $49        ;; 01:493a ......??
    db   $60, $49, $63, $49, $66, $49, $08, $00        ;; 01:4942 ??????..
    db   $40, $08, $e8, $57, $0c, $00, $40, $0c        ;; 01:494a ....????
    db   $e8, $60, $1f, $00, $40, $1f, $e8, $57        ;; 01:4952 ??......
    db   $1e, $00, $40, $1e, $e8, $57, $1d, $00        ;; 01:495a ...?????
    db   $40, $1d, $e8, $57, $3d, $00, $40, $cd        ;; 01:4962 ????????
    db   $43, $2e, $f5, $f5, $21, $24, $d6, $6e        ;; 01:496a ????????
    db   $26, $00, $11, $29, $d6, $19, $4e, $f1        ;; 01:4972 ????????
    db   $fe, $05, $20, $09, $79, $e6, $20, $28        ;; 01:497a ????????
    db   $0e, $3e, $01, $18, $0a, $06, $03, $af        ;; 01:4982 ????????
    db   $cb, $39, $ce, $00, $05, $20, $f9, $87        ;; 01:498a ????????
    db   $5f, $16, $00, $f1, $6f, $26, $00, $29        ;; 01:4992 ????????
    db   $29, $29, $19, $11, $a7, $49, $19, $2a        ;; 01:499a ????????
    db   $66, $6f, $c3, $6f, $4e, $97, $5d, $b0        ;; 01:49a2 ????????
    db   $5d, $c9, $5d, $e2, $5d, $fb, $5d, $14        ;; 01:49aa ????????
    db   $5e, $2d, $5e, $2d, $5e, $46, $5e, $5f        ;; 01:49b2 ????????
    db   $5e, $5f, $5e, $5f, $5e, $fb, $5d, $14        ;; 01:49ba ????????
    db   $5e, $2d, $5e, $2d, $5e, $46, $5e, $5f        ;; 01:49c2 ????????
    db   $5e, $5f, $5e, $5f, $5e, $78, $5e, $92        ;; 01:49ca ????????
    db   $5e, $92, $5e, $92, $5e, $21, $0f, $4a        ;; 01:49d2 ????????
    db   $11, $4b, $da, $01, $80, $00, $cd, $b0        ;; 01:49da ????????
    db   $07, $fa, $24, $d6, $11, $0f, $7c, $cd        ;; 01:49e2 ????????
    db   $b9, $07, $3e, $92, $ea, $96, $d6, $3e        ;; 01:49ea ????????
    db   $03, $ea, $92, $d6, $3e, $02, $ea, $93        ;; 01:49f2 ????????
    db   $d6, $e5, $cd, $5a, $4e, $e1, $11, $00        ;; 01:49fa ????????
    db   $c0, $cd, $b0, $07, $11, $ab, $da, $01        ;; 01:4a02 ????????
    db   $18, $00, $c3, $b0, $07, $00, $00, $00        ;; 01:4a0a ????????
    db   $02, $00, $00, $e0, $03, $00, $00, $8c        ;; 01:4a12 ????????
    db   $01, $c0, $02, $5a, $03, $00, $00, $10        ;; 01:4a1a ????????
    db   $42, $18, $63, $ff, $7f, $00, $00, $e0        ;; 01:4a22 ????????
    db   $01, $e0, $02, $e0, $03, $00, $00, $ef        ;; 01:4a2a ????????
    db   $3d, $f7, $5e, $ff, $7f, $00, $00, $ef        ;; 01:4a32 ????????
    db   $01, $f7, $02, $ff, $03, $00, $00, $00        ;; 01:4a3a ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:4a42 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:4a4a ????????
    db   $02, $00, $00, $e0, $03, $00, $00, $0f        ;; 01:4a52 ????????
    db   $00, $17, $00, $1f, $00, $00, $00, $ef        ;; 01:4a5a ????????
    db   $3d, $f7, $5e, $ff, $7f, $00, $00, $ef        ;; 01:4a62 ????????
    db   $01, $f7, $02, $ff, $03, $00, $00, $00        ;; 01:4a6a ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:4a72 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:4a7a ????????
    db   $00, $20, $03, $bf, $0b, $00, $00, $1f        ;; 01:4a82 ????????
    db   $00, $ff, $01, $7f, $03                       ;; 01:4a8a ?????

call_01_4a8f:
    ld   HL, wD69A                                     ;; 01:4a8f $21 $9a $d6
    ld   L, [HL]                                       ;; 01:4a92 $6e
    ld   H, $00                                        ;; 01:4a93 $26 $00
    add  HL, HL                                        ;; 01:4a95 $29
    add  HL, HL                                        ;; 01:4a96 $29
    add  HL, HL                                        ;; 01:4a97 $29
    ld   DE, data_01_65fe                              ;; 01:4a98 $11 $fe $65
    add  HL, DE                                        ;; 01:4a9b $19
    ld   DE, wD69F                                     ;; 01:4a9c $11 $9f $d6
    ld   BC, $06                                       ;; 01:4a9f $01 $06 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4aa2 $cd $b0 $07
    call call_01_4bd3                                  ;; 01:4aa5 $cd $d3 $4b
.jr_01_4aa8:
    ld   HL, wD69B                                     ;; 01:4aa8 $21 $9b $d6
    ld   E, [HL]                                       ;; 01:4aab $5e
    inc  HL                                            ;; 01:4aac $23
    ld   D, [HL]                                       ;; 01:4aad $56
    ld   A, [DE]                                       ;; 01:4aae $1a
    cp   A, $80                                        ;; 01:4aaf $fe $80
    ret  Z                                             ;; 01:4ab1 $c8
    and  A, A                                          ;; 01:4ab2 $a7
    ret  Z                                             ;; 01:4ab3 $c8
    ld   A, [wD6DB]                                    ;; 01:4ab4 $fa $db $d6
    cp   A, $fe                                        ;; 01:4ab7 $fe $fe
    jr   NZ, .jr_01_4ac6                               ;; 01:4ab9 $20 $0b
    call call_01_4c81                                  ;; 01:4abb $cd $81 $4c
    ld   A, [wD692]                                    ;; 01:4abe $fa $92 $d6
    add  A, A                                          ;; 01:4ac1 $87
    add  A, A                                          ;; 01:4ac2 $87
    srl  C                                             ;; 01:4ac3 $cb $39
    sub  A, C                                          ;; 01:4ac5 $91
.jr_01_4ac6:
    ld   [wD698], A                                    ;; 01:4ac6 $ea $98 $d6
    ld   HL, wD69B                                     ;; 01:4ac9 $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4acc $2a
    ld   H, [HL]                                       ;; 01:4acd $66
    ld   L, A                                          ;; 01:4ace $6f
.jr_01_4acf:
    ld   A, [HL+]                                      ;; 01:4acf $2a
    push HL                                            ;; 01:4ad0 $e5
    call call_01_4ae7                                  ;; 01:4ad1 $cd $e7 $4a
    pop  HL                                            ;; 01:4ad4 $e1
    bit  7, [HL]                                       ;; 01:4ad5 $cb $7e
    jr   Z, .jr_01_4acf                                ;; 01:4ad7 $28 $f6
    inc  HL                                            ;; 01:4ad9 $23
    call call_01_4e6f                                  ;; 01:4ada $cd $6f $4e
    ld   HL, wD699                                     ;; 01:4add $21 $99 $d6
    ld   A, [wD6DC]                                    ;; 01:4ae0 $fa $dc $d6
    add  A, [HL]                                       ;; 01:4ae3 $86
    ld   [HL], A                                       ;; 01:4ae4 $77
    jr   .jr_01_4aa8                                   ;; 01:4ae5 $18 $c1

call_01_4ae7:
    call call_01_4cab                                  ;; 01:4ae7 $cd $ab $4c
    ld   A, [wD698]                                    ;; 01:4aea $fa $98 $d6
    and  A, $07                                        ;; 01:4aed $e6 $07
    ld   C, A                                          ;; 01:4aef $4f
    ld   A, $08                                        ;; 01:4af0 $3e $08
    sub  A, C                                          ;; 01:4af2 $91
    ld   [wD6C2], A                                    ;; 01:4af3 $ea $c2 $d6
    ld   A, [wD698]                                    ;; 01:4af6 $fa $98 $d6
    and  A, $f8                                        ;; 01:4af9 $e6 $f8
    ld   L, A                                          ;; 01:4afb $6f
    ld   H, $00                                        ;; 01:4afc $26 $00
    add  HL, HL                                        ;; 01:4afe $29
    ld   A, [wD699]                                    ;; 01:4aff $fa $99 $d6
    and  A, $07                                        ;; 01:4b02 $e6 $07
    add  A, A                                          ;; 01:4b04 $87
    ld   E, A                                          ;; 01:4b05 $5f
    ld   D, $00                                        ;; 01:4b06 $16 $00
    add  HL, DE                                        ;; 01:4b08 $19
    ld   A, [wD699]                                    ;; 01:4b09 $fa $99 $d6
    srl  A                                             ;; 01:4b0c $cb $3f
    srl  A                                             ;; 01:4b0e $cb $3f
    srl  A                                             ;; 01:4b10 $cb $3f
    jr   Z, .jr_01_4b26                                ;; 01:4b12 $28 $12
    ld   C, A                                          ;; 01:4b14 $4f
    ld   A, [wD692]                                    ;; 01:4b15 $fa $92 $d6
    swap A                                             ;; 01:4b18 $cb $37
    ld   D, A                                          ;; 01:4b1a $57
    and  A, $f0                                        ;; 01:4b1b $e6 $f0
    ld   E, A                                          ;; 01:4b1d $5f
    ld   A, D                                          ;; 01:4b1e $7a
    and  A, $0f                                        ;; 01:4b1f $e6 $0f
    ld   D, A                                          ;; 01:4b21 $57
.jr_01_4b22:
    add  HL, DE                                        ;; 01:4b22 $19
    dec  C                                             ;; 01:4b23 $0d
    jr   NZ, .jr_01_4b22                               ;; 01:4b24 $20 $fc
.jr_01_4b26:
    ld   DE, wC000                                     ;; 01:4b26 $11 $00 $c0
    add  HL, DE                                        ;; 01:4b29 $19
    ld   A, [wD6A3]                                    ;; 01:4b2a $fa $a3 $d6
.jr_01_4b2d:
    push AF                                            ;; 01:4b2d $f5
    push HL                                            ;; 01:4b2e $e5
    ld   A, L                                          ;; 01:4b2f $7d
    ld   [wD6B5], A                                    ;; 01:4b30 $ea $b5 $d6
    ld   A, H                                          ;; 01:4b33 $7c
    ld   [wD6B6], A                                    ;; 01:4b34 $ea $b6 $d6
    ld   A, [wD6A4]                                    ;; 01:4b37 $fa $a4 $d6
.jr_01_4b3a:
    push AF                                            ;; 01:4b3a $f5
    ld   A, [wD6B7]                                    ;; 01:4b3b $fa $b7 $d6
    ld   L, A                                          ;; 01:4b3e $6f
    ld   A, [wD6B8]                                    ;; 01:4b3f $fa $b8 $d6
    ld   H, A                                          ;; 01:4b42 $67
    ld   E, [HL]                                       ;; 01:4b43 $5e
    inc  HL                                            ;; 01:4b44 $23
    ld   C, [HL]                                       ;; 01:4b45 $4e
    inc  HL                                            ;; 01:4b46 $23
    ld   A, L                                          ;; 01:4b47 $7d
    ld   [wD6B7], A                                    ;; 01:4b48 $ea $b7 $d6
    ld   A, H                                          ;; 01:4b4b $7c
    ld   [wD6B8], A                                    ;; 01:4b4c $ea $b8 $d6
    ld   D, $00                                        ;; 01:4b4f $16 $00
    ld   B, $00                                        ;; 01:4b51 $06 $00
    ld   A, [wD6C2]                                    ;; 01:4b53 $fa $c2 $d6
.jr_01_4b56:
    sla  E                                             ;; 01:4b56 $cb $23
    rl   D                                             ;; 01:4b58 $cb $12
    sla  C                                             ;; 01:4b5a $cb $21
    rl   B                                             ;; 01:4b5c $cb $10
    dec  A                                             ;; 01:4b5e $3d
    jr   NZ, .jr_01_4b56                               ;; 01:4b5f $20 $f5
    ld   A, [wD6B5]                                    ;; 01:4b61 $fa $b5 $d6
    ld   L, A                                          ;; 01:4b64 $6f
    ld   A, [wD6B6]                                    ;; 01:4b65 $fa $b6 $d6
    ld   H, A                                          ;; 01:4b68 $67
    ld   A, D                                          ;; 01:4b69 $7a
    xor  A, [HL]                                       ;; 01:4b6a $ae
    ld   [HL+], A                                      ;; 01:4b6b $22
    ld   A, B                                          ;; 01:4b6c $78
    xor  A, [HL]                                       ;; 01:4b6d $ae
    ld   [HL], A                                       ;; 01:4b6e $77
    ld   A, E                                          ;; 01:4b6f $7b
    ld   DE, $0f                                       ;; 01:4b70 $11 $0f $00
    add  HL, DE                                        ;; 01:4b73 $19
    xor  A, [HL]                                       ;; 01:4b74 $ae
    ld   [HL+], A                                      ;; 01:4b75 $22
    ld   A, C                                          ;; 01:4b76 $79
    xor  A, [HL]                                       ;; 01:4b77 $ae
    ld   [HL], A                                       ;; 01:4b78 $77
    ld   HL, wD6B5                                     ;; 01:4b79 $21 $b5 $d6
    ld   A, [HL+]                                      ;; 01:4b7c $2a
    ld   H, [HL]                                       ;; 01:4b7d $66
    ld   L, A                                          ;; 01:4b7e $6f
    inc  HL                                            ;; 01:4b7f $23
    inc  HL                                            ;; 01:4b80 $23
    ld   A, L                                          ;; 01:4b81 $7d
    and  A, $0f                                        ;; 01:4b82 $e6 $0f
    jr   NZ, .jr_01_4b98                               ;; 01:4b84 $20 $12
    ld   A, [wD692]                                    ;; 01:4b86 $fa $92 $d6
    swap A                                             ;; 01:4b89 $cb $37
    ld   D, A                                          ;; 01:4b8b $57
    and  A, $f0                                        ;; 01:4b8c $e6 $f0
    ld   E, A                                          ;; 01:4b8e $5f
    ld   A, D                                          ;; 01:4b8f $7a
    and  A, $0f                                        ;; 01:4b90 $e6 $0f
    ld   D, A                                          ;; 01:4b92 $57
    add  HL, DE                                        ;; 01:4b93 $19
    ld   DE, hFFF0                                     ;; 01:4b94 $11 $f0 $ff
    add  HL, DE                                        ;; 01:4b97 $19
.jr_01_4b98:
    ld   A, L                                          ;; 01:4b98 $7d
    ld   [wD6B5], A                                    ;; 01:4b99 $ea $b5 $d6
    ld   A, H                                          ;; 01:4b9c $7c
    ld   [wD6B6], A                                    ;; 01:4b9d $ea $b6 $d6
    pop  AF                                            ;; 01:4ba0 $f1
    dec  A                                             ;; 01:4ba1 $3d
    jr   NZ, .jr_01_4b3a                               ;; 01:4ba2 $20 $96
    pop  HL                                            ;; 01:4ba4 $e1
    ld   DE, $10                                       ;; 01:4ba5 $11 $10 $00
    add  HL, DE                                        ;; 01:4ba8 $19
    pop  AF                                            ;; 01:4ba9 $f1
    dec  A                                             ;; 01:4baa $3d
    jr   NZ, .jr_01_4b2d                               ;; 01:4bab $20 $80
    ld   HL, wD698                                     ;; 01:4bad $21 $98 $d6
    ld   A, [wD6C3]                                    ;; 01:4bb0 $fa $c3 $d6
    add  A, [HL]                                       ;; 01:4bb3 $86
    inc  A                                             ;; 01:4bb4 $3c
    ld   [HL], A                                       ;; 01:4bb5 $77
    ret                                                ;; 01:4bb6 $c9

call_01_4bb7:
    call call_01_4e5a                                  ;; 01:4bb7 $cd $5a $4e
    ld   B, A                                          ;; 01:4bba $47
    ld   HL, wC000                                     ;; 01:4bbb $21 $00 $c0
    xor  A, A                                          ;; 01:4bbe $af
.jr_01_4bbf:
    ld   [HL+], A                                      ;; 01:4bbf $22
    ld   [HL+], A                                      ;; 01:4bc0 $22
    ld   [HL+], A                                      ;; 01:4bc1 $22
    ld   [HL+], A                                      ;; 01:4bc2 $22
    ld   [HL+], A                                      ;; 01:4bc3 $22
    ld   [HL+], A                                      ;; 01:4bc4 $22
    ld   [HL+], A                                      ;; 01:4bc5 $22
    ld   [HL+], A                                      ;; 01:4bc6 $22
    ld   [HL+], A                                      ;; 01:4bc7 $22
    ld   [HL+], A                                      ;; 01:4bc8 $22
    ld   [HL+], A                                      ;; 01:4bc9 $22
    ld   [HL+], A                                      ;; 01:4bca $22
    ld   [HL+], A                                      ;; 01:4bcb $22
    ld   [HL+], A                                      ;; 01:4bcc $22
    ld   [HL+], A                                      ;; 01:4bcd $22
    ld   [HL+], A                                      ;; 01:4bce $22
    dec  B                                             ;; 01:4bcf $05
    jr   NZ, .jr_01_4bbf                               ;; 01:4bd0 $20 $ed
    ret                                                ;; 01:4bd2 $c9

call_01_4bd3:
    ld   HL, wD69B                                     ;; 01:4bd3 $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4bd6 $2a
    ld   H, [HL]                                       ;; 01:4bd7 $66
    ld   L, A                                          ;; 01:4bd8 $6f
    ld   DE, wD5A6_TextBuffer                                     ;; 01:4bd9 $11 $a6 $d5
.jr_01_4bdc:
    ld   A, [HL+]                                      ;; 01:4bdc $2a
    ld   [DE], A                                       ;; 01:4bdd $12
    inc  DE                                            ;; 01:4bde $13
    bit  7, A                                          ;; 01:4bdf $cb $7f
    jr   Z, .jr_01_4bdc                                ;; 01:4be1 $28 $f9
    xor  A, A                                          ;; 01:4be3 $af
    ld   [DE], A                                       ;; 01:4be4 $12
    ld   HL, wD5A6_TextBuffer                                     ;; 01:4be5 $21 $a6 $d5
    call call_01_4e6f                                  ;; 01:4be8 $cd $6f $4e
.jr_01_4beb:
    call call_01_4c81                                  ;; 01:4beb $cd $81 $4c
    ld   HL, wD692                                     ;; 01:4bee $21 $92 $d6
    ld   L, [HL]                                       ;; 01:4bf1 $6e
    ld   H, $00                                        ;; 01:4bf2 $26 $00
    add  HL, HL                                        ;; 01:4bf4 $29
    add  HL, HL                                        ;; 01:4bf5 $29
    add  HL, HL                                        ;; 01:4bf6 $29
    ld   A, L                                          ;; 01:4bf7 $7d
    sub  A, C                                          ;; 01:4bf8 $91
    ld   A, H                                          ;; 01:4bf9 $7c
    sbc  A, B                                          ;; 01:4bfa $98
    jr   NC, .jr_01_4c12                               ;; 01:4bfb $30 $15
    ld   HL, wD69B                                     ;; 01:4bfd $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4c00 $2a
    ld   H, [HL]                                       ;; 01:4c01 $66
    ld   L, A                                          ;; 01:4c02 $6f
.jr_01_4c03:
    inc  HL                                            ;; 01:4c03 $23
    bit  7, [HL]                                       ;; 01:4c04 $cb $7e
    jr   Z, .jr_01_4c03                                ;; 01:4c06 $28 $fb
.jr_01_4c08:
    dec  HL                                            ;; 01:4c08 $2b
    ld   A, [HL]                                       ;; 01:4c09 $7e
    cp   A, $20                                        ;; 01:4c0a $fe $20
    jr   NZ, .jr_01_4c08                               ;; 01:4c0c $20 $fa
    ld   [HL], $80                                     ;; 01:4c0e $36 $80
    jr   .jr_01_4beb                                   ;; 01:4c10 $18 $d9
.jr_01_4c12:
    ld   HL, wD69B                                     ;; 01:4c12 $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4c15 $2a
    ld   H, [HL]                                       ;; 01:4c16 $66
    ld   L, A                                          ;; 01:4c17 $6f
.jr_01_4c18:
    ld   A, [HL+]                                      ;; 01:4c18 $2a
    bit  7, A                                          ;; 01:4c19 $cb $7f
    jr   Z, .jr_01_4c18                                ;; 01:4c1b $28 $fb
    ld   A, [HL]                                       ;; 01:4c1d $7e
    and  A, A                                          ;; 01:4c1e $a7
    jr   Z, .jr_01_4c33                                ;; 01:4c1f $28 $12
    call call_01_4e6f                                  ;; 01:4c21 $cd $6f $4e
.jr_01_4c24:
    ld   A, [HL+]                                      ;; 01:4c24 $2a
    bit  7, A                                          ;; 01:4c25 $cb $7f
    jr   Z, .jr_01_4c24                                ;; 01:4c27 $28 $fb
    ld   A, [HL]                                       ;; 01:4c29 $7e
    and  A, A                                          ;; 01:4c2a $a7
    jr   Z, .jr_01_4beb                                ;; 01:4c2b $28 $be
    dec  HL                                            ;; 01:4c2d $2b
    ld   [HL], $20                                     ;; 01:4c2e $36 $20
    inc  HL                                            ;; 01:4c30 $23
    jr   .jr_01_4c24                                   ;; 01:4c31 $18 $f1
.jr_01_4c33:
    ld   A, [wD698]                                    ;; 01:4c33 $fa $98 $d6
    ld   [wD6DB], A                                    ;; 01:4c36 $ea $db $d6
    ld   HL, wD5A6_TextBuffer                                     ;; 01:4c39 $21 $a6 $d5
    call call_01_4e6f                                  ;; 01:4c3c $cd $6f $4e
    ld   A, [wD6A4]                                    ;; 01:4c3f $fa $a4 $d6
    inc  A                                             ;; 01:4c42 $3c
    ld   [wD6DC], A                                    ;; 01:4c43 $ea $dc $d6
    ld   A, [wD699]                                    ;; 01:4c46 $fa $99 $d6
    cp   A, $fe                                        ;; 01:4c49 $fe $fe
    ret  NZ                                            ;; 01:4c4b $c0
    ld   HL, wD69B                                     ;; 01:4c4c $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4c4f $2a
    ld   H, [HL]                                       ;; 01:4c50 $66
    ld   L, A                                          ;; 01:4c51 $6f
    ld   C, $00                                        ;; 01:4c52 $0e $00
.jr_01_4c54:
    ld   A, [HL+]                                      ;; 01:4c54 $2a
    bit  7, A                                          ;; 01:4c55 $cb $7f
    jr   Z, .jr_01_4c54                                ;; 01:4c57 $28 $fb
    inc  C                                             ;; 01:4c59 $0c
    ld   A, [HL]                                       ;; 01:4c5a $7e
    and  A, A                                          ;; 01:4c5b $a7
    jr   NZ, .jr_01_4c54                               ;; 01:4c5c $20 $f6
    push BC                                            ;; 01:4c5e $c5
    ld   A, [wD6A4]                                    ;; 01:4c5f $fa $a4 $d6
    ld   B, A                                          ;; 01:4c62 $47
    ld   A, [wD693]                                    ;; 01:4c63 $fa $93 $d6
    add  A, A                                          ;; 01:4c66 $87
    add  A, A                                          ;; 01:4c67 $87
    add  A, A                                          ;; 01:4c68 $87
.jr_01_4c69:
    sub  A, B                                          ;; 01:4c69 $90
    dec  C                                             ;; 01:4c6a $0d
    jr   NZ, .jr_01_4c69                               ;; 01:4c6b $20 $fc
    pop  BC                                            ;; 01:4c6d $c1
    inc  C                                             ;; 01:4c6e $0c
    ld   B, $ff                                        ;; 01:4c6f $06 $ff
.jr_01_4c71:
    inc  B                                             ;; 01:4c71 $04
    sub  A, C                                          ;; 01:4c72 $91
    jr   NC, .jr_01_4c71                               ;; 01:4c73 $30 $fc
    ld   A, B                                          ;; 01:4c75 $78
    ld   [wD699], A                                    ;; 01:4c76 $ea $99 $d6
    ld   HL, wD6A4                                     ;; 01:4c79 $21 $a4 $d6
    add  A, [HL]                                       ;; 01:4c7c $86
    ld   [wD6DC], A                                    ;; 01:4c7d $ea $dc $d6
    ret                                                ;; 01:4c80 $c9

call_01_4c81:
    ld   HL, wD69B                                     ;; 01:4c81 $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4c84 $2a
    ld   H, [HL]                                       ;; 01:4c85 $66
    ld   L, A                                          ;; 01:4c86 $6f
    ld   BC, $00                                       ;; 01:4c87 $01 $00 $00
    bit  7, [HL]                                       ;; 01:4c8a $cb $7e
    ret  NZ                                            ;; 01:4c8c $c0
.jr_01_4c8d:
    ld   A, [HL+]                                      ;; 01:4c8d $2a
    push HL                                            ;; 01:4c8e $e5
    call call_01_4f41                                  ;; 01:4c8f $cd $41 $4f
    ld   HL, wD6A1                                     ;; 01:4c92 $21 $a1 $d6
    ld   E, [HL]                                       ;; 01:4c95 $5e
    inc  HL                                            ;; 01:4c96 $23
    ld   D, [HL]                                       ;; 01:4c97 $56
    ld   L, A                                          ;; 01:4c98 $6f
    ld   H, $00                                        ;; 01:4c99 $26 $00
    add  HL, DE                                        ;; 01:4c9b $19
    ld   A, [HL]                                       ;; 01:4c9c $7e
    add  A, C                                          ;; 01:4c9d $81
    ld   C, A                                          ;; 01:4c9e $4f
    ld   A, $00                                        ;; 01:4c9f $3e $00
    adc  A, B                                          ;; 01:4ca1 $88
    ld   B, A                                          ;; 01:4ca2 $47
    inc  BC                                            ;; 01:4ca3 $03
    pop  HL                                            ;; 01:4ca4 $e1
    bit  7, [HL]                                       ;; 01:4ca5 $cb $7e
    jr   Z, .jr_01_4c8d                                ;; 01:4ca7 $28 $e4
    dec  BC                                            ;; 01:4ca9 $0b
    ret                                                ;; 01:4caa $c9

call_01_4cab:
    call call_01_4f41                                  ;; 01:4cab $cd $41 $4f
    push AF                                            ;; 01:4cae $f5
    ld   HL, wD6A1                                     ;; 01:4caf $21 $a1 $d6
    ld   E, [HL]                                       ;; 01:4cb2 $5e
    inc  HL                                            ;; 01:4cb3 $23
    ld   D, [HL]                                       ;; 01:4cb4 $56
    ld   L, A                                          ;; 01:4cb5 $6f
    ld   H, $00                                        ;; 01:4cb6 $26 $00
    add  HL, DE                                        ;; 01:4cb8 $19
    ld   A, [HL]                                       ;; 01:4cb9 $7e
    ld   [wD6C3], A                                    ;; 01:4cba $ea $c3 $d6
    ld   A, [wD6A4]                                    ;; 01:4cbd $fa $a4 $d6
    add  A, A                                          ;; 01:4cc0 $87
    ld   C, A                                          ;; 01:4cc1 $4f
    ld   A, [wD6A3]                                    ;; 01:4cc2 $fa $a3 $d6
    ld   B, A                                          ;; 01:4cc5 $47
    xor  A, A                                          ;; 01:4cc6 $af
.jr_01_4cc7:
    add  A, C                                          ;; 01:4cc7 $81
    dec  B                                             ;; 01:4cc8 $05
    jr   NZ, .jr_01_4cc7                               ;; 01:4cc9 $20 $fc
    ld   E, A                                          ;; 01:4ccb $5f
    ld   D, $00                                        ;; 01:4ccc $16 $00
    ld   HL, wD69F                                     ;; 01:4cce $21 $9f $d6
    ld   A, [HL+]                                      ;; 01:4cd1 $2a
    ld   H, [HL]                                       ;; 01:4cd2 $66
    ld   L, A                                          ;; 01:4cd3 $6f
    pop  AF                                            ;; 01:4cd4 $f1
    and  A, A                                          ;; 01:4cd5 $a7
    jr   Z, .jr_01_4cdc                                ;; 01:4cd6 $28 $04
.jr_01_4cd8:
    add  HL, DE                                        ;; 01:4cd8 $19
    dec  A                                             ;; 01:4cd9 $3d
    jr   NZ, .jr_01_4cd8                               ;; 01:4cda $20 $fc
.jr_01_4cdc:
    ld   A, L                                          ;; 01:4cdc $7d
    ld   [wD6B7], A                                    ;; 01:4cdd $ea $b7 $d6
    ld   A, H                                          ;; 01:4ce0 $7c
    ld   [wD6B8], A                                    ;; 01:4ce1 $ea $b8 $d6
    ret                                                ;; 01:4ce4 $c9

call_01_4ce5:
    ld   HL, wD5A6_TextBuffer                                     ;; 01:4ce5 $21 $a6 $d5
    cp   A, $0a                                        ;; 01:4ce8 $fe $0a
    jr   C, .jr_01_4d04                                ;; 01:4cea $38 $18
    cp   A, $64                                        ;; 01:4cec $fe $64
    jr   C, .jr_01_4cfa                                ;; 01:4cee $38 $0a
    ld   [HL], $2f                                     ;; 01:4cf0 $36 $2f
.jr_01_4cf2:
    inc  [HL]                                          ;; 01:4cf2 $34
    sub  A, $64                                        ;; 01:4cf3 $d6 $64
    jr   NC, .jr_01_4cf2                               ;; 01:4cf5 $30 $fb
    add  A, $64                                        ;; 01:4cf7 $c6 $64
    inc  HL                                            ;; 01:4cf9 $23
.jr_01_4cfa:
    ld   [HL], $2f                                     ;; 01:4cfa $36 $2f
.jr_01_4cfc:
    inc  [HL]                                          ;; 01:4cfc $34
    sub  A, $0a                                        ;; 01:4cfd $d6 $0a
    jr   NC, .jr_01_4cfc                               ;; 01:4cff $30 $fb
    add  A, $0a                                        ;; 01:4d01 $c6 $0a
    inc  HL                                            ;; 01:4d03 $23
.jr_01_4d04:
    add  A, $30                                        ;; 01:4d04 $c6 $30
    ld   [HL+], A                                      ;; 01:4d06 $22
    ld   [HL], $80                                     ;; 01:4d07 $36 $80
    ret                                                ;; 01:4d09 $c9

call_01_4d0a:
    ld   A, [wD6E2]                                    ;; 01:4d0a $fa $e2 $d6
    and  A, A                                          ;; 01:4d0d $a7
    jr   NZ, call_01_4d0a                              ;; 01:4d0e $20 $fa
    ld   A, [HL+]                                      ;; 01:4d10 $2a
    ld   [wD6E2], A                                    ;; 01:4d11 $ea $e2 $d6
    ld   A, [HL+]                                      ;; 01:4d14 $2a
    ld   [wD6E3], A                                    ;; 01:4d15 $ea $e3 $d6
    ld   A, [HL+]                                      ;; 01:4d18 $2a
    ld   [wD6E4], A                                    ;; 01:4d19 $ea $e4 $d6
    ld   A, L                                          ;; 01:4d1c $7d
    ld   [wD6E9], A                                    ;; 01:4d1d $ea $e9 $d6
    ld   A, H                                          ;; 01:4d20 $7c
    ld   [wD6EA], A                                    ;; 01:4d21 $ea $ea $d6
    ret                                                ;; 01:4d24 $c9

call_01_4d25:
    ld   HL, wD6D8                                     ;; 01:4d25 $21 $d8 $d6
    ld   A, [HL]                                       ;; 01:4d28 $7e
    and  A, A                                          ;; 01:4d29 $a7
    ret  Z                                             ;; 01:4d2a $c8
    ld   A, [wD59F_CurrentInputs]                                    ;; 01:4d2b $fa $9f $d5
    and  A, A                                          ;; 01:4d2e $a7
    jr   Z, .jr_01_4d33                                ;; 01:4d2f $28 $02
    ld   [HL], $01                                     ;; 01:4d31 $36 $01
.jr_01_4d33:
    dec  [HL]                                          ;; 01:4d33 $35
    ret  NZ                                            ;; 01:4d34 $c0
    ld   A, [wD6D9]                                    ;; 01:4d35 $fa $d9 $d6
    jp   call_01_4d3b                                  ;; 01:4d38 $c3 $3b $4d

call_01_4d3b:
    ld   DE, data_01_5aa9                              ;; 01:4d3b $11 $a9 $5a
    call call_00_07b9                                  ;; 01:4d3e $cd $b9 $07
    ld   A, [HL+]                                      ;; 01:4d41 $2a
    cp   A, $ff                                        ;; 01:4d42 $fe $ff
    ret  Z                                             ;; 01:4d44 $c8
    push HL                                            ;; 01:4d45 $e5
    ld   L, A                                          ;; 01:4d46 $6f
    ld   H, $00                                        ;; 01:4d47 $26 $00
    add  HL, HL                                        ;; 01:4d49 $29
    add  HL, HL                                        ;; 01:4d4a $29
    ld   DE, wCC00                                     ;; 01:4d4b $11 $00 $cc
    add  HL, DE                                        ;; 01:4d4e $19
    ld   E, L                                          ;; 01:4d4f $5d
    ld   D, H                                          ;; 01:4d50 $54
    pop  HL                                            ;; 01:4d51 $e1
.jr_01_4d52:
    ld   A, [HL+]                                      ;; 01:4d52 $2a
    cp   A, $ff                                        ;; 01:4d53 $fe $ff
    ret  Z                                             ;; 01:4d55 $c8
    ld   A, [HL+]                                      ;; 01:4d56 $2a
    ld   A, [HL+]                                      ;; 01:4d57 $2a
    ld   A, [HL+]                                      ;; 01:4d58 $2a
    ld   C, [HL]                                       ;; 01:4d59 $4e
    inc  HL                                            ;; 01:4d5a $23
    ld   B, [HL]                                       ;; 01:4d5b $46
    inc  HL                                            ;; 01:4d5c $23
    srl  B                                             ;; 01:4d5d $cb $38
    xor  A, A                                          ;; 01:4d5f $af
.jr_01_4d60:
    push BC                                            ;; 01:4d60 $c5
.jr_01_4d61:
    ld   [DE], A                                       ;; 01:4d61 $12
    inc  DE                                            ;; 01:4d62 $13
    ld   [DE], A                                       ;; 01:4d63 $12
    inc  DE                                            ;; 01:4d64 $13
    ld   [DE], A                                       ;; 01:4d65 $12
    inc  DE                                            ;; 01:4d66 $13
    ld   [DE], A                                       ;; 01:4d67 $12
    inc  DE                                            ;; 01:4d68 $13
    dec  B                                             ;; 01:4d69 $05
    jr   NZ, .jr_01_4d61                               ;; 01:4d6a $20 $f5
    pop  BC                                            ;; 01:4d6c $c1
    dec  C                                             ;; 01:4d6d $0d
    jr   NZ, .jr_01_4d60                               ;; 01:4d6e $20 $f0
    jr   .jr_01_4d52                                   ;; 01:4d70 $18 $e0

call_01_4d72:
    ld   A, [wD6C1]                                    ;; 01:4d72 $fa $c1 $d6
    cp   A, $ff                                        ;; 01:4d75 $fe $ff
    ret  Z                                             ;; 01:4d77 $c8
    ld   C, $02                                        ;; 01:4d78 $0e $02
    ld   B, $05                                        ;; 01:4d7a $06 $05
    cp   A, $12                                        ;; 01:4d7c $fe $12
    jr   NZ, .jr_01_4d92                               ;; 01:4d7e $20 $12
    call call_01_4f30                                  ;; 01:4d80 $cd $30 $4f
    ld   C, A                                          ;; 01:4d83 $4f
    ld   A, [wD6D6]                                    ;; 01:4d84 $fa $d6 $d6
    and  A, $10                                        ;; 01:4d87 $e6 $10
    jr   Z, .jr_01_4d8f                                ;; 01:4d89 $28 $04
    or   A, $06                                        ;; 01:4d8b $f6 $06
    jr   .jr_01_4d91                                   ;; 01:4d8d $18 $02
.jr_01_4d8f:
    or   A, $05                                        ;; 01:4d8f $f6 $05
.jr_01_4d91:
    ld   B, A                                          ;; 01:4d91 $47
.jr_01_4d92:
    ld   HL, wD6BC                                     ;; 01:4d92 $21 $bc $d6
    ld   [HL], C                                       ;; 01:4d95 $71
    ld   HL, wD6BD                                     ;; 01:4d96 $21 $bd $d6
    ld   [HL], B                                       ;; 01:4d99 $70
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:4d9a $fa $e0 $d6
    ld   C, A                                          ;; 01:4d9d $4f
    inc  C                                             ;; 01:4d9e $0c
    ld   A, [wD691]                                    ;; 01:4d9f $fa $91 $d6
    ld   B, A                                          ;; 01:4da2 $47
    ld   A, [wD68F]                                    ;; 01:4da3 $fa $8f $d6
    sub  A, B                                          ;; 01:4da6 $90
.jr_01_4da7:
    add  A, B                                          ;; 01:4da7 $80
    dec  C                                             ;; 01:4da8 $0d
    jr   NZ, .jr_01_4da7                               ;; 01:4da9 $20 $fc
    ld   [wD6BA], A                                    ;; 01:4dab $ea $ba $d6
    ld   A, [wD6DF_MenuSelectedColumn]                                    ;; 01:4dae $fa $df $d6
    ld   C, A                                          ;; 01:4db1 $4f
    inc  C                                             ;; 01:4db2 $0c
    ld   A, [wD690]                                    ;; 01:4db3 $fa $90 $d6
    ld   B, A                                          ;; 01:4db6 $47
    ld   A, [wD68E]                                    ;; 01:4db7 $fa $8e $d6
    sub  A, B                                          ;; 01:4dba $90
.jr_01_4dbb:
    add  A, B                                          ;; 01:4dbb $80
    dec  C                                             ;; 01:4dbc $0d
    jr   NZ, .jr_01_4dbb                               ;; 01:4dbd $20 $fc
    ld   [wD6BB], A                                    ;; 01:4dbf $ea $bb $d6
    ld   HL, wD6B9                                     ;; 01:4dc2 $21 $b9 $d6
    jp   jp_01_4dc8                                    ;; 01:4dc5 $c3 $c8 $4d

jp_01_4dc8:
    ld   A, [HL+]                                      ;; 01:4dc8 $2a
    cp   A, $ff                                        ;; 01:4dc9 $fe $ff
    ret  Z                                             ;; 01:4dcb $c8
    ld   [wD6D5], A                                    ;; 01:4dcc $ea $d5 $d6
.jr_01_4dcf:
    ld   A, [HL+]                                      ;; 01:4dcf $2a
    cp   A, $ff                                        ;; 01:4dd0 $fe $ff
    ret  Z                                             ;; 01:4dd2 $c8
    add  A, $10                                        ;; 01:4dd3 $c6 $10
    ld   [wD5A6_TextBuffer], A                                    ;; 01:4dd5 $ea $a6 $d5
    ld   A, [HL+]                                      ;; 01:4dd8 $2a
    add  A, $08                                        ;; 01:4dd9 $c6 $08
    ld   [wD5A7], A                                    ;; 01:4ddb $ea $a7 $d5
    ld   A, [HL+]                                      ;; 01:4dde $2a
    bit  0, A                                          ;; 01:4ddf $cb $47
    jr   Z, .jr_01_4def                                ;; 01:4de1 $28 $0c
    push HL                                            ;; 01:4de3 $e5
    srl  A                                             ;; 01:4de4 $cb $3f
    ld   E, A                                          ;; 01:4de6 $5f
    ld   D, $00                                        ;; 01:4de7 $16 $00
    ld   HL, wD5AA                                     ;; 01:4de9 $21 $aa $d5
    add  HL, DE                                        ;; 01:4dec $19
    ld   A, [HL]                                       ;; 01:4ded $7e
    pop  HL                                            ;; 01:4dee $e1
.jr_01_4def:
    ld   [wD5A8], A                                    ;; 01:4def $ea $a8 $d5
    ld   A, [HL+]                                      ;; 01:4df2 $2a
    ld   [wD5A9], A                                    ;; 01:4df3 $ea $a9 $d5
    ld   C, [HL]                                       ;; 01:4df6 $4e
    inc  HL                                            ;; 01:4df7 $23
    ld   B, [HL]                                       ;; 01:4df8 $46
    inc  HL                                            ;; 01:4df9 $23
    push HL                                            ;; 01:4dfa $e5
    call call_01_4e01                                  ;; 01:4dfb $cd $01 $4e
    pop  HL                                            ;; 01:4dfe $e1
    jr   .jr_01_4dcf                                   ;; 01:4dff $18 $ce

call_01_4e01:
    ld   HL, wD6D5                                     ;; 01:4e01 $21 $d5 $d6
    ld   L, [HL]                                       ;; 01:4e04 $6e
    ld   H, $00                                        ;; 01:4e05 $26 $00
    add  HL, HL                                        ;; 01:4e07 $29
    add  HL, HL                                        ;; 01:4e08 $29
    ld   DE, wCC00                                     ;; 01:4e09 $11 $00 $cc
    add  HL, DE                                        ;; 01:4e0c $19
    srl  B                                             ;; 01:4e0d $cb $38
    ld   A, [wD5A6_TextBuffer]                                    ;; 01:4e0f $fa $a6 $d5
.jr_01_4e12:
    push BC                                            ;; 01:4e12 $c5
    push AF                                            ;; 01:4e13 $f5
    ld   [wD5A6_TextBuffer], A                                    ;; 01:4e14 $ea $a6 $d5
.jr_01_4e17:
    ld   A, [wD5A6_TextBuffer]                                    ;; 01:4e17 $fa $a6 $d5
    ld   [HL+], A                                      ;; 01:4e1a $22
    add  A, $10                                        ;; 01:4e1b $c6 $10
    ld   [wD5A6_TextBuffer], A                                    ;; 01:4e1d $ea $a6 $d5
    ld   A, [wD5A7]                                    ;; 01:4e20 $fa $a7 $d5
    ld   [HL+], A                                      ;; 01:4e23 $22
    ld   A, [wD5A8]                                    ;; 01:4e24 $fa $a8 $d5
    ld   [HL+], A                                      ;; 01:4e27 $22
    add  A, $02                                        ;; 01:4e28 $c6 $02
    ld   [wD5A8], A                                    ;; 01:4e2a $ea $a8 $d5
    ld   A, [wD5A9]                                    ;; 01:4e2d $fa $a9 $d5
    ld   [HL+], A                                      ;; 01:4e30 $22
    ld   A, [wD6D5]                                    ;; 01:4e31 $fa $d5 $d6
    inc  A                                             ;; 01:4e34 $3c
    ld   [wD6D5], A                                    ;; 01:4e35 $ea $d5 $d6
    dec  B                                             ;; 01:4e38 $05
    jr   NZ, .jr_01_4e17                               ;; 01:4e39 $20 $dc
    ld   A, [wD5A7]                                    ;; 01:4e3b $fa $a7 $d5
    add  A, $08                                        ;; 01:4e3e $c6 $08
    ld   [wD5A7], A                                    ;; 01:4e40 $ea $a7 $d5
    pop  AF                                            ;; 01:4e43 $f1
    pop  BC                                            ;; 01:4e44 $c1
    dec  C                                             ;; 01:4e45 $0d
    jr   NZ, .jr_01_4e12                               ;; 01:4e46 $20 $ca
    ret                                                ;; 01:4e48 $c9

call_01_4e49:
    ld   HL, wD696                                     ;; 01:4e49 $21 $96 $d6
    ld   L, [HL]                                       ;; 01:4e4c $6e
    ld   H, $00                                        ;; 01:4e4d $26 $00
    add  HL, HL                                        ;; 01:4e4f $29
    add  HL, HL                                        ;; 01:4e50 $29
    add  HL, HL                                        ;; 01:4e51 $29
    add  HL, HL                                        ;; 01:4e52 $29
    ld   DE, $8000                                     ;; 01:4e53 $11 $00 $80
    add  HL, DE                                        ;; 01:4e56 $19
    ld   E, L                                          ;; 01:4e57 $5d
    ld   D, H                                          ;; 01:4e58 $54
    ret                                                ;; 01:4e59 $c9

call_01_4e5a:
    ld   HL, wD692                                     ;; 01:4e5a $21 $92 $d6
    ld   C, [HL]                                       ;; 01:4e5d $4e
    inc  HL                                            ;; 01:4e5e $23
    ld   B, [HL]                                       ;; 01:4e5f $46
    xor  A, A                                          ;; 01:4e60 $af
.jr_01_4e61:
    add  A, C                                          ;; 01:4e61 $81
    dec  B                                             ;; 01:4e62 $05
    jr   NZ, .jr_01_4e61                               ;; 01:4e63 $20 $fc
    ld   L, A                                          ;; 01:4e65 $6f
    ld   H, $00                                        ;; 01:4e66 $26 $00
    add  HL, HL                                        ;; 01:4e68 $29
    add  HL, HL                                        ;; 01:4e69 $29
    add  HL, HL                                        ;; 01:4e6a $29
    add  HL, HL                                        ;; 01:4e6b $29
    ld   C, L                                          ;; 01:4e6c $4d
    ld   B, H                                          ;; 01:4e6d $44
    ret                                                ;; 01:4e6e $c9

call_01_4e6f:
    ld   A, L                                          ;; 01:4e6f $7d
    ld   [wD69B], A                                    ;; 01:4e70 $ea $9b $d6
    ld   A, H                                          ;; 01:4e73 $7c
    ld   [wD69C], A                                    ;; 01:4e74 $ea $9c $d6
    ret                                                ;; 01:4e77 $c9

jp_01_4e78:
    ld   A, [wD69A]                                    ;; 01:4e78 $fa $9a $d6
    ld   [wD696], A                                    ;; 01:4e7b $ea $96 $d6
    ld   A, [HL+]                                      ;; 01:4e7e $2a
    ld   [wD692], A                                    ;; 01:4e7f $ea $92 $d6
    ld   A, [HL+]                                      ;; 01:4e82 $2a
    ld   [wD693], A                                    ;; 01:4e83 $ea $93 $d6
    push HL                                            ;; 01:4e86 $e5
    call call_01_4e5a                                  ;; 01:4e87 $cd $5a $4e
    pop  HL                                            ;; 01:4e8a $e1
    ld   DE, wC000                                     ;; 01:4e8b $11 $00 $c0
    ld   A, [HL+]                                      ;; 01:4e8e $2a
    and  A, A                                          ;; 01:4e8f $a7
    jp   Z, call_00_07b0_CopyBytes                               ;; 01:4e90 $ca $b0 $07
    ret                                                ;; 01:4e93 $c9

call_01_4e94:
    call call_01_4d72                                  ;; 01:4e94 $cd $72 $4d
    call call_01_4d25                                  ;; 01:4e97 $cd $25 $4d
    call call_00_0ab4                                  ;; 01:4e9a $cd $b4 $0a
    ld   HL, wD6D6                                     ;; 01:4e9d $21 $d6 $d6
    dec  [HL]                                          ;; 01:4ea0 $35
    ld   A, [wD68C]                                    ;; 01:4ea1 $fa $8c $d6
    and  A, $02                                        ;; 01:4ea4 $e6 $02
    ld   A, [wD59F_CurrentInputs]                                    ;; 01:4ea6 $fa $9f $d5
    jr   Z, .jr_01_4ead                                ;; 01:4ea9 $28 $02
    and  A, $fc                                        ;; 01:4eab $e6 $fc
.jr_01_4ead:
    and  A, A                                          ;; 01:4ead $a7
    jr   NZ, call_01_4e94                              ;; 01:4eae $20 $e4
    ret                                                ;; 01:4eb0 $c9

call_01_4eb1:
    ld   E, A                                          ;; 01:4eb1 $5f
    ld   D, $00                                        ;; 01:4eb2 $16 $00
    ld   HL, .data_01_4ecc                             ;; 01:4eb4 $21 $cc $4e
    add  HL, DE                                        ;; 01:4eb7 $19
    ld   B, [HL]                                       ;; 01:4eb8 $46
    ld   A, [wD623]                                    ;; 01:4eb9 $fa $23 $d6
    and  A, A                                          ;; 01:4ebc $a7
    jr   Z, .jr_01_4ec1                                ;; 01:4ebd $28 $02
    ld   B, $20                                        ;; 01:4ebf $06 $20
.jr_01_4ec1:
    ld   HL, wD624                                     ;; 01:4ec1 $21 $24 $d6
    ld   E, [HL]                                       ;; 01:4ec4 $5e
    ld   HL, wD629_RemoteProgressBitfields                                     ;; 01:4ec5 $21 $29 $d6
    add  HL, DE                                        ;; 01:4ec8 $19
    ld   A, B                                          ;; 01:4ec9 $78
    and  A, [HL]                                       ;; 01:4eca $a6
    ret                                                ;; 01:4ecb $c9
.data_01_4ecc:
    db   $01, $02, $04                                 ;; 01:4ecc ...

call_01_4ecf:
    ld   A, [wD6E2]                                    ;; 01:4ecf $fa $e2 $d6
    and  A, A                                          ;; 01:4ed2 $a7
    jr   NZ, call_01_4ecf                              ;; 01:4ed3 $20 $fa
    ld   A, $01                                        ;; 01:4ed5 $3e $01
    ld   [wD6E2], A                                    ;; 01:4ed7 $ea $e2 $d6
    ld   A, $04                                        ;; 01:4eda $3e $04
    ld   [wD6E3], A                                    ;; 01:4edc $ea $e3 $d6
    ld   A, $01                                        ;; 01:4edf $3e $01
    ld   [wD6E4], A                                    ;; 01:4ee1 $ea $e4 $d6
    call call_01_4f1b                                  ;; 01:4ee4 $cd $1b $4f
    call call_01_4f41                                  ;; 01:4ee7 $cd $41 $4f
    ld   L, A                                          ;; 01:4eea $6f
    ld   H, $00                                        ;; 01:4eeb $26 $00
    add  HL, HL                                        ;; 01:4eed $29
    add  HL, HL                                        ;; 01:4eee $29
    add  HL, HL                                        ;; 01:4eef $29
    add  HL, HL                                        ;; 01:4ef0 $29
    add  HL, HL                                        ;; 01:4ef1 $29
    add  HL, HL                                        ;; 01:4ef2 $29
    ld   DE, data_01_71e9                              ;; 01:4ef3 $11 $e9 $71
    add  HL, DE                                        ;; 01:4ef6 $19
    ld   A, L                                          ;; 01:4ef7 $7d
    ld   [wD6E5], A                                    ;; 01:4ef8 $ea $e5 $d6
    ld   A, H                                          ;; 01:4efb $7c
    ld   [wD6E6], A                                    ;; 01:4efc $ea $e6 $d6
    call call_01_4f30                                  ;; 01:4eff $cd $30 $4f
    ld   L, A                                          ;; 01:4f02 $6f
    ld   H, $00                                        ;; 01:4f03 $26 $00
    add  HL, HL                                        ;; 01:4f05 $29
    add  HL, HL                                        ;; 01:4f06 $29
    add  HL, HL                                        ;; 01:4f07 $29
    add  HL, HL                                        ;; 01:4f08 $29
    ld   DE, $8000                                     ;; 01:4f09 $11 $00 $80
    add  HL, DE                                        ;; 01:4f0c $19
    ld   A, L                                          ;; 01:4f0d $7d
    ld   [wD6E7], A                                    ;; 01:4f0e $ea $e7 $d6
    ld   A, H                                          ;; 01:4f11 $7c
    ld   [wD6E8], A                                    ;; 01:4f12 $ea $e8 $d6
    ld   HL, wD6E2                                     ;; 01:4f15 $21 $e2 $d6
    jp   call_01_4d0a                                  ;; 01:4f18 $c3 $0a $4d

call_01_4f1b:
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:4f1b $fa $e0 $d6
    add  A, A                                          ;; 01:4f1e $87
    ld   E, A                                          ;; 01:4f1f $5f
    add  A, A                                          ;; 01:4f20 $87
    add  A, E                                          ;; 01:4f21 $83
    ld   E, A                                          ;; 01:4f22 $5f
    ld   A, [wD6DF_MenuSelectedColumn]                                    ;; 01:4f23 $fa $df $d6
    add  A, E                                          ;; 01:4f26 $83
    ld   E, A                                          ;; 01:4f27 $5f
    ld   D, $00                                        ;; 01:4f28 $16 $00
    ld   HL, wD667                                     ;; 01:4f2a $21 $67 $d6
    add  HL, DE                                        ;; 01:4f2d $19
    ld   A, [HL]                                       ;; 01:4f2e $7e
    ret                                                ;; 01:4f2f $c9

call_01_4f30:
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:4f30 $fa $e0 $d6
    add  A, A                                          ;; 01:4f33 $87
    ld   L, A                                          ;; 01:4f34 $6f
    add  A, A                                          ;; 01:4f35 $87
    add  A, L                                          ;; 01:4f36 $85
    ld   L, A                                          ;; 01:4f37 $6f
    ld   A, [wD6DF_MenuSelectedColumn]                                    ;; 01:4f38 $fa $df $d6
    add  A, L                                          ;; 01:4f3b $85
    add  A, A                                          ;; 01:4f3c $87
    add  A, A                                          ;; 01:4f3d $87
    add  A, $3e                                        ;; 01:4f3e $c6 $3e
    ret                                                ;; 01:4f40 $c9

call_01_4f41:
    sub  A, $20                                        ;; 01:4f41 $d6 $20
    ld   E, A                                          ;; 01:4f43 $5f
    ld   D, $00                                        ;; 01:4f44 $16 $00
    ld   HL, .data_01_4f4c                             ;; 01:4f46 $21 $4c $4f
    add  HL, DE                                        ;; 01:4f49 $19
    ld   A, [HL]                                       ;; 01:4f4a $7e
    ret                                                ;; 01:4f4b $c9
.data_01_4f4c:
    db   $00, $27, $00, $00, $00, $00, $00, $29        ;; 01:4f4c ww??????
    db   $00, $00, $00, $00, $26, $28, $25, $00        ;; 01:4f54 ??????w?
    db   $1b, $1c, $1d, $1e, $1f, $20, $21, $22        ;; 01:4f5c www?ww??
    db   $23, $24, $00, $00, $00, $00, $00, $00        ;; 01:4f64 ?w??????
    db   $00, $01, $02, $03, $04, $05, $06, $07        ;; 01:4f6c ?wwwwwww
    db   $08, $09, $0a, $0b, $0c, $0d, $0e, $0f        ;; 01:4f74 wwwwwwww
    db   $10, $11, $12, $13, $14, $15, $16, $17        ;; 01:4f7c wwwwwwww
    db   $18, $19, $1a                                 ;; 01:4f84 www

call_01_4f87:
    ld   HL, wD667                                     ;; 01:4f87 $21 $67 $d6
    ld   DE, wD668                                     ;; 01:4f8a $11 $68 $d6
    ld   BC, $1d                                       ;; 01:4f8d $01 $1d $00
    ld   [HL], $20                                     ;; 01:4f90 $36 $20
    call call_00_07b0_CopyBytes                                  ;; 01:4f92 $cd $b0 $07
    ld   A, $49                                        ;; 01:4f95 $3e $49
    ld   [wD667], A                                    ;; 01:4f97 $ea $67 $d6
    ld   A, $4a                                        ;; 01:4f9a $3e $4a
    ld   [wD684], A                                    ;; 01:4f9c $ea $84 $d6
    ld   A, $4b                                        ;; 01:4f9f $3e $4b
    ld   [wD685], A                                    ;; 01:4fa1 $ea $85 $d6
    ret                                                ;; 01:4fa4 $c9

call_01_4fa5:
    ld   HL, wD667                                     ;; 01:4fa5 $21 $67 $d6
    ld   DE, wD668                                     ;; 01:4fa8 $11 $68 $d6
    ld   BC, $1d                                       ;; 01:4fab $01 $1d $00
    ld   [HL], $00                                     ;; 01:4fae $36 $00
    call call_00_07b0_CopyBytes                                  ;; 01:4fb0 $cd $b0 $07
    ld   A, $49                                        ;; 01:4fb3 $3e $49
    ld   [wD667], A                                    ;; 01:4fb5 $ea $67 $d6
    ld   A, $4a                                        ;; 01:4fb8 $3e $4a
    ld   [wD684], A                                    ;; 01:4fba $ea $84 $d6
    ld   A, $4b                                        ;; 01:4fbd $3e $4b
    ld   [wD685], A                                    ;; 01:4fbf $ea $85 $d6
    ld   HL, .data_01_4fef                             ;; 01:4fc2 $21 $ef $4f
.jr_01_4fc5:
    push HL                                            ;; 01:4fc5 $e5
    ld   A, [HL+]                                      ;; 01:4fc6 $2a
    ld   D, [HL]                                       ;; 01:4fc7 $56
    ld   E, A                                          ;; 01:4fc8 $5f
    or   A, D                                          ;; 01:4fc9 $b2
    jr   Z, .jr_01_4fe1                                ;; 01:4fca $28 $15
    inc  HL                                            ;; 01:4fcc $23
    ld   A, [DE]                                       ;; 01:4fcd $1a
    and  A, [HL]                                       ;; 01:4fce $a6
    jr   Z, .jr_01_4fda                                ;; 01:4fcf $28 $09
    inc  HL                                            ;; 01:4fd1 $23
    inc  HL                                            ;; 01:4fd2 $23
    ld   E, [HL]                                       ;; 01:4fd3 $5e
    inc  HL                                            ;; 01:4fd4 $23
    ld   D, [HL]                                       ;; 01:4fd5 $56
    inc  HL                                            ;; 01:4fd6 $23
    ld   A, [DE]                                       ;; 01:4fd7 $1a
    or   A, [HL]                                       ;; 01:4fd8 $b6
    ld   [DE], A                                       ;; 01:4fd9 $12
.jr_01_4fda:
    pop  HL                                            ;; 01:4fda $e1
    ld   DE, $08                                       ;; 01:4fdb $11 $08 $00
    add  HL, DE                                        ;; 01:4fde $19
    jr   .jr_01_4fc5                                   ;; 01:4fdf $18 $e4
.jr_01_4fe1:
    pop  HL                                            ;; 01:4fe1 $e1
    ld   HL, wD668                                     ;; 01:4fe2 $21 $68 $d6
    ld   B, $1c                                        ;; 01:4fe5 $06 $1c
.jr_01_4fe7:
    ld   A, [HL]                                       ;; 01:4fe7 $7e
    add  A, $41                                        ;; 01:4fe8 $c6 $41
    ld   [HL+], A                                      ;; 01:4fea $22
    dec  B                                             ;; 01:4feb $05
    jr   NZ, .jr_01_4fe7                               ;; 01:4fec $20 $f9
    ret                                                ;; 01:4fee $c9
.data_01_4fef:
    db   $52, $d6, $80, $00, $68, $d6, $04, $00        ;; 01:4fef ????????
    db   $52, $d6, $40, $00, $68, $d6, $02, $00        ;; 01:4ff7 ????????
    db   $52, $d6, $20, $00, $68, $d6, $01, $00        ;; 01:4fff ????????
    db   $52, $d6, $10, $00, $69, $d6, $04, $00        ;; 01:5007 ????????
    db   $52, $d6, $08, $00, $69, $d6, $02, $00        ;; 01:500f ????????
    db   $52, $d6, $04, $00, $69, $d6, $01, $00        ;; 01:5017 ????????
    db   $52, $d6, $02, $00, $6a, $d6, $04, $00        ;; 01:501f ????????
    db   $52, $d6, $01, $00, $6a, $d6, $02, $00        ;; 01:5027 ????????
    db   $53, $d6, $80, $00, $6a, $d6, $01, $00        ;; 01:502f ????????
    db   $53, $d6, $40, $00, $6b, $d6, $04, $00        ;; 01:5037 ????????
    db   $53, $d6, $20, $00, $6b, $d6, $02, $00        ;; 01:503f ????????
    db   $53, $d6, $10, $00, $6b, $d6, $01, $00        ;; 01:5047 ????????
    db   $53, $d6, $08, $00, $6c, $d6, $04, $00        ;; 01:504f ????????
    db   $53, $d6, $04, $00, $6c, $d6, $02, $00        ;; 01:5057 ????????
    db   $53, $d6, $02, $00, $6c, $d6, $01, $00        ;; 01:505f ????????
    db   $53, $d6, $01, $00, $6d, $d6, $04, $00        ;; 01:5067 ????????
    db   $54, $d6, $80, $00, $6d, $d6, $02, $00        ;; 01:506f ????????
    db   $54, $d6, $40, $00, $6d, $d6, $01, $00        ;; 01:5077 ????????
    db   $54, $d6, $20, $00, $6e, $d6, $04, $00        ;; 01:507f ????????
    db   $54, $d6, $10, $00, $6e, $d6, $02, $00        ;; 01:5087 ????????
    db   $54, $d6, $08, $00, $6e, $d6, $01, $00        ;; 01:508f ????????
    db   $54, $d6, $04, $00, $6f, $d6, $04, $00        ;; 01:5097 ????????
    db   $54, $d6, $02, $00, $6f, $d6, $02, $00        ;; 01:509f ????????
    db   $54, $d6, $01, $00, $6f, $d6, $01, $00        ;; 01:50a7 ????????
    db   $55, $d6, $80, $00, $70, $d6, $04, $00        ;; 01:50af ????????
    db   $55, $d6, $40, $00, $70, $d6, $02, $00        ;; 01:50b7 ????????
    db   $55, $d6, $20, $00, $70, $d6, $01, $00        ;; 01:50bf ????????
    db   $55, $d6, $10, $00, $71, $d6, $04, $00        ;; 01:50c7 ????????
    db   $55, $d6, $08, $00, $71, $d6, $02, $00        ;; 01:50cf ????????
    db   $55, $d6, $04, $00, $71, $d6, $01, $00        ;; 01:50d7 ????????
    db   $55, $d6, $02, $00, $72, $d6, $04, $00        ;; 01:50df ????????
    db   $55, $d6, $01, $00, $72, $d6, $02, $00        ;; 01:50e7 ????????
    db   $56, $d6, $80, $00, $72, $d6, $01, $00        ;; 01:50ef ????????
    db   $56, $d6, $40, $00, $73, $d6, $04, $00        ;; 01:50f7 ????????
    db   $56, $d6, $20, $00, $73, $d6, $02, $00        ;; 01:50ff ????????
    db   $56, $d6, $10, $00, $73, $d6, $01, $00        ;; 01:5107 ????????
    db   $56, $d6, $08, $00, $74, $d6, $04, $00        ;; 01:510f ????????
    db   $56, $d6, $04, $00, $74, $d6, $02, $00        ;; 01:5117 ????????
    db   $56, $d6, $02, $00, $74, $d6, $01, $00        ;; 01:511f ????????
    db   $56, $d6, $01, $00, $75, $d6, $04, $00        ;; 01:5127 ????????
    db   $57, $d6, $80, $00, $75, $d6, $02, $00        ;; 01:512f ????????
    db   $57, $d6, $40, $00, $75, $d6, $01, $00        ;; 01:5137 ????????
    db   $57, $d6, $20, $00, $76, $d6, $04, $00        ;; 01:513f ????????
    db   $57, $d6, $10, $00, $76, $d6, $02, $00        ;; 01:5147 ????????
    db   $57, $d6, $08, $00, $76, $d6, $01, $00        ;; 01:514f ????????
    db   $57, $d6, $04, $00, $77, $d6, $04, $00        ;; 01:5157 ????????
    db   $57, $d6, $02, $00, $77, $d6, $02, $00        ;; 01:515f ????????
    db   $57, $d6, $01, $00, $77, $d6, $01, $00        ;; 01:5167 ????????
    db   $58, $d6, $80, $00, $78, $d6, $04, $00        ;; 01:516f ????????
    db   $58, $d6, $40, $00, $78, $d6, $02, $00        ;; 01:5177 ????????
    db   $58, $d6, $20, $00, $78, $d6, $01, $00        ;; 01:517f ????????
    db   $58, $d6, $10, $00, $79, $d6, $04, $00        ;; 01:5187 ????????
    db   $58, $d6, $08, $00, $79, $d6, $02, $00        ;; 01:518f ????????
    db   $58, $d6, $04, $00, $79, $d6, $01, $00        ;; 01:5197 ????????
    db   $58, $d6, $02, $00, $7a, $d6, $04, $00        ;; 01:519f ????????
    db   $58, $d6, $01, $00, $7a, $d6, $02, $00        ;; 01:51a7 ????????
    db   $59, $d6, $80, $00, $7a, $d6, $01, $00        ;; 01:51af ????????
    db   $59, $d6, $40, $00, $7b, $d6, $04, $00        ;; 01:51b7 ????????
    db   $59, $d6, $20, $00, $7b, $d6, $02, $00        ;; 01:51bf ????????
    db   $59, $d6, $10, $00, $7b, $d6, $01, $00        ;; 01:51c7 ????????
    db   $59, $d6, $08, $00, $7c, $d6, $04, $00        ;; 01:51cf ????????
    db   $59, $d6, $04, $00, $7c, $d6, $02, $00        ;; 01:51d7 ????????
    db   $59, $d6, $02, $00, $7c, $d6, $01, $00        ;; 01:51df ????????
    db   $59, $d6, $01, $00, $7d, $d6, $04, $00        ;; 01:51e7 ????????
    db   $5a, $d6, $80, $00, $7d, $d6, $02, $00        ;; 01:51ef ????????
    db   $5a, $d6, $40, $00, $7d, $d6, $01, $00        ;; 01:51f7 ????????
    db   $5a, $d6, $20, $00, $7e, $d6, $04, $00        ;; 01:51ff ????????
    db   $5a, $d6, $10, $00, $7e, $d6, $02, $00        ;; 01:5207 ????????
    db   $5a, $d6, $08, $00, $7e, $d6, $01, $00        ;; 01:520f ????????
    db   $5a, $d6, $04, $00, $7f, $d6, $04, $00        ;; 01:5217 ????????
    db   $5a, $d6, $02, $00, $7f, $d6, $02, $00        ;; 01:521f ????????
    db   $5a, $d6, $01, $00, $7f, $d6, $01, $00        ;; 01:5227 ????????
    db   $5b, $d6, $80, $00, $80, $d6, $04, $00        ;; 01:522f ????????
    db   $5b, $d6, $40, $00, $80, $d6, $02, $00        ;; 01:5237 ????????
    db   $5b, $d6, $20, $00, $80, $d6, $01, $00        ;; 01:523f ????????
    db   $5b, $d6, $10, $00, $81, $d6, $04, $00        ;; 01:5247 ????????
    db   $5b, $d6, $08, $00, $81, $d6, $02, $00        ;; 01:524f ????????
    db   $5b, $d6, $04, $00, $81, $d6, $01, $00        ;; 01:5257 ????????
    db   $5b, $d6, $02, $00, $82, $d6, $04, $00        ;; 01:525f ????????
    db   $5b, $d6, $01, $00, $82, $d6, $02, $00        ;; 01:5267 ????????
    db   $00, $00                                      ;; 01:526f ??

call_01_5271:
    ld   HL, wD668                                     ;; 01:5271 $21 $68 $d6
    ld   B, $1c                                        ;; 01:5274 $06 $1c
.jr_01_5276:
    ld   A, [HL+]                                      ;; 01:5276 $2a
    cp   A, $20                                        ;; 01:5277 $fe $20
    jp   Z, .jp_01_531a                                ;; 01:5279 $ca $1a $53
    dec  B                                             ;; 01:527c $05
    jr   NZ, .jr_01_5276                               ;; 01:527d $20 $f7
    ld   HL, wD65C                                     ;; 01:527f $21 $5c $d6
    ld   B, $0b                                        ;; 01:5282 $06 $0b
    xor  A, A                                          ;; 01:5284 $af
.jr_01_5285:
    ld   [HL+], A                                      ;; 01:5285 $22
    dec  B                                             ;; 01:5286 $05
    jr   NZ, .jr_01_5285                               ;; 01:5287 $20 $fc
    ld   HL, wD65C                                     ;; 01:5289 $21 $5c $d6
    ld   DE, wD668                                     ;; 01:528c $11 $68 $d6
    ld   A, $1c                                        ;; 01:528f $3e $1c
    ld   C, $80                                        ;; 01:5291 $0e $80
.jr_01_5293:
    push AF                                            ;; 01:5293 $f5
    push DE                                            ;; 01:5294 $d5
    ld   A, [DE]                                       ;; 01:5295 $1a
    sub  A, $41                                        ;; 01:5296 $d6 $41
    ld   E, A                                          ;; 01:5298 $5f
    ld   B, $03                                        ;; 01:5299 $06 $03
.jr_01_529b:
    bit  2, E                                          ;; 01:529b $cb $53
    jr   Z, .jr_01_52a2                                ;; 01:529d $28 $03
    ld   A, [HL]                                       ;; 01:529f $7e
    or   A, C                                          ;; 01:52a0 $b1
    ld   [HL], A                                       ;; 01:52a1 $77
.jr_01_52a2:
    rrc  C                                             ;; 01:52a2 $cb $09
    jr   NC, .jr_01_52a7                               ;; 01:52a4 $30 $01
    inc  HL                                            ;; 01:52a6 $23
.jr_01_52a7:
    rlc  E                                             ;; 01:52a7 $cb $03
    dec  B                                             ;; 01:52a9 $05
    jr   NZ, .jr_01_529b                               ;; 01:52aa $20 $ef
    pop  DE                                            ;; 01:52ac $d1
    inc  DE                                            ;; 01:52ad $13
    pop  AF                                            ;; 01:52ae $f1
    dec  A                                             ;; 01:52af $3d
    jr   NZ, .jr_01_5293                               ;; 01:52b0 $20 $e1
    ld   HL, wD65C                                     ;; 01:52b2 $21 $5c $d6
    ld   B, $09                                        ;; 01:52b5 $06 $09
    xor  A, A                                          ;; 01:52b7 $af
.jr_01_52b8:
    add  A, [HL]                                       ;; 01:52b8 $86
    inc  HL                                            ;; 01:52b9 $23
    dec  B                                             ;; 01:52ba $05
    jr   NZ, .jr_01_52b8                               ;; 01:52bb $20 $fb
    ld   HL, wD665                                     ;; 01:52bd $21 $65 $d6
    cp   A, [HL]                                       ;; 01:52c0 $be
    jr   NZ, .jp_01_531a                               ;; 01:52c1 $20 $57
    ld   A, [wD664]                                    ;; 01:52c3 $fa $64 $d6
    ld   [wD73D_LivesRemaining], A                                    ;; 01:52c6 $ea $3d $d7
    ld   A, [wD624]                                    ;; 01:52c9 $fa $24 $d6
    push AF                                            ;; 01:52cc $f5
    xor  A, A                                          ;; 01:52cd $af
    ld   [wD624], A                                    ;; 01:52ce $ea $24 $d6
    ld   HL, wD65C                                     ;; 01:52d1 $21 $5c $d6
    ld   C, $80                                        ;; 01:52d4 $0e $80
.jr_01_52d6:
    push HL                                            ;; 01:52d6 $e5
    call call_00_2e43                                  ;; 01:52d7 $cd $43 $2e
    ld   E, A                                          ;; 01:52da $5f
    ld   D, $00                                        ;; 01:52db $16 $00
    ld   HL, .data_01_531d                             ;; 01:52dd $21 $1d $53
    add  HL, DE                                        ;; 01:52e0 $19
    ld   D, [HL]                                       ;; 01:52e1 $56
    pop  HL                                            ;; 01:52e2 $e1
    rlc  D                                             ;; 01:52e3 $cb $02
    rlc  D                                             ;; 01:52e5 $cb $02
    xor  A, A                                          ;; 01:52e7 $af
    ld   B, $06                                        ;; 01:52e8 $06 $06
.jr_01_52ea:
    rlc  D                                             ;; 01:52ea $cb $02
    jr   NC, .jr_01_52f7                               ;; 01:52ec $30 $09
    rlc  [HL]                                          ;; 01:52ee $cb $06
    push AF                                            ;; 01:52f0 $f5
    rrc  C                                             ;; 01:52f1 $cb $09
    jr   NC, .jr_01_52f6                               ;; 01:52f3 $30 $01
    inc  HL                                            ;; 01:52f5 $23
.jr_01_52f6:
    pop  AF                                            ;; 01:52f6 $f1
.jr_01_52f7:
    rla                                                ;; 01:52f7 $17
    dec  B                                             ;; 01:52f8 $05
    jr   NZ, .jr_01_52ea                               ;; 01:52f9 $20 $ef
    push HL                                            ;; 01:52fb $e5
    ld   HL, wD624                                     ;; 01:52fc $21 $24 $d6
    ld   L, [HL]                                       ;; 01:52ff $6e
    ld   H, $00                                        ;; 01:5300 $26 $00
    ld   DE, wD629_RemoteProgressBitfields                                     ;; 01:5302 $11 $29 $d6
    add  HL, DE                                        ;; 01:5305 $19
    ld   [HL], A                                       ;; 01:5306 $77
    pop  HL                                            ;; 01:5307 $e1
    ld   A, [wD624]                                    ;; 01:5308 $fa $24 $d6
    inc  A                                             ;; 01:530b $3c
    ld   [wD624], A                                    ;; 01:530c $ea $24 $d6
    cp   A, $1e                                        ;; 01:530f $fe $1e
    jr   NZ, .jr_01_52d6                               ;; 01:5311 $20 $c3
    pop  AF                                            ;; 01:5313 $f1
    ld   [wD624], A                                    ;; 01:5314 $ea $24 $d6
    ld   A, $30                                        ;; 01:5317 $3e $30
    ret                                                ;; 01:5319 $c9
.jp_01_531a:
    ld   A, $00                                        ;; 01:531a $3e $00
    ret                                                ;; 01:531c $c9
.data_01_531d:
    db   $1f, $1b, $19, $03, $01, $20, $00             ;; 01:531d ???????

data_01_5324:
    db   $06, $05, $01, $01, $06, $ff, $00, $00        ;; 01:5324 ..ww..??
    db   $0c, $03, $08, $01, $24, $01, $00, $00        ;; 01:532c w.www.??
    db   $0c, $02, $08, $04, $48, $00, $00, $00        ;; 01:5334 w.www.??
    db   $10, $02, $04, $07, $60, $00, $00, $00        ;; 01:533c w.www.??
    db   $10, $02, $04, $0a, $80, $00, $00, $00        ;; 01:5344 w.www.??
    db   $10, $02, $04, $0d, $a0, $00, $00, $00        ;; 01:534c w.www.??
    db   $10, $02, $04, $08, $60, $00, $00, $00        ;; 01:5354 ????????
    db   $10, $02, $04, $0c, $80, $00, $00, $00        ;; 01:535c ????????
    db   $14, $02, $00, $10, $c0, $02, $00, $00        ;; 01:5364 w.www.??
    db   $10, $02, $02, $05, $06, $00, $00, $00        ;; 01:536c w.www.??
    db   $14, $02, $00, $07, $26, $01, $00, $00        ;; 01:5374 w.www.??
    db   $08, $01, $06, $0a, $4e, $01, $00, $00        ;; 01:537c w.www.??
    db   $08, $01, $06, $0b, $56, $01, $00, $00        ;; 01:5384 w.www.??
    db   $08, $01, $02, $0a, $06, $00, $00, $00        ;; 01:538c w.....??
    db   $08, $01, $02, $0c, $0e, $00, $00, $00        ;; 01:5394 ????????
    db   $08, $01, $02, $0e, $16, $00, $00, $00        ;; 01:539c ????????
    db   $14, $02, $00, $08, $06, $01, $00, $00        ;; 01:53a4 w.www.??
    db   $14, $02, $00, $0a, $2e, $01, $00, $00        ;; 01:53ac w.www.??
    db   $0e, $02, $03, $00, $06, $00, $00, $00        ;; 01:53b4 ????????
    db   $0c, $01, $04, $03, $22, $00, $00, $00        ;; 01:53bc w.www.??
    db   $0c, $01, $04, $04, $2e, $00, $00, $00        ;; 01:53c4 w.www.??
    db   $0c, $01, $04, $05, $3a, $00, $00, $00        ;; 01:53cc ????????
    db   $10, $02, $02, $07, $46, $00, $00, $00        ;; 01:53d4 w.www.??
    db   $02, $02, $02, $0c, $66, $00, $00, $00        ;; 01:53dc ..ww..??
    db   $02, $02, $10, $0c, $6a, $00, $00, $00        ;; 01:53e4 ..ww..??
    db   $01, $02, $07, $09, $6e, $00, $00, $00        ;; 01:53ec w...w.??
    db   $03, $02, $08, $09, $70, $00, $00, $00        ;; 01:53f4 w...w.??
    db   $01, $02, $0f, $09, $76, $00, $00, $00        ;; 01:53fc w...w.??
    db   $02, $02, $0b, $0b, $78, $00, $00, $00        ;; 01:5404 w...w.??
    db   $02, $02, $0b, $0d, $7c, $00, $00, $00        ;; 01:540c w...w.??
    db   $02, $02, $0b, $0f, $80, $00, $00, $00        ;; 01:5414 w...w.??
    db   $10, $02, $02, $00, $06, $00, $00, $00        ;; 01:541c ????????
    db   $12, $01, $01, $06, $26, $00, $00, $00        ;; 01:5424 ????????
    db   $05, $01, $04, $0f, $38, $00, $00, $00        ;; 01:542c ????????
    db   $05, $01, $0b, $0f, $3d, $00, $00, $00        ;; 01:5434 ????????
    db   $0e, $01, $03, $11, $42, $00, $00, $00        ;; 01:543c ????????
    db   $02, $02, $03, $09, $50, $00, $00, $00        ;; 01:5444 ????????
    db   $02, $02, $09, $09, $54, $00, $00, $00        ;; 01:544c ????????
    db   $02, $02, $0f, $09, $58, $00, $00, $00        ;; 01:5454 ????????
    db   $03, $02, $09, $07, $90, $00, $00, $00        ;; 01:545c ????????
    db   $05, $02, $00, $00, $06, $05, $00, $00        ;; 01:5464 ????????
    db   $07, $02, $0a, $00, $10, $05, $00, $00        ;; 01:546c ????????
    db   $07, $02, $00, $02, $1e, $05, $00, $00        ;; 01:5474 ????????
    db   $09, $02, $0a, $02, $2c, $05, $00, $00        ;; 01:547c ????????
    db   $02, $02, $01, $02, $3e, $05, $00, $00        ;; 01:5484 ????????
    db   $02, $02, $04, $02, $42, $05, $00, $00        ;; 01:548c ????????
    db   $02, $02, $07, $02, $46, $05, $00, $00        ;; 01:5494 ????????
    db   $02, $02, $0a, $02, $4a, $05, $00, $00        ;; 01:549c ????????
    db   $02, $02, $0d, $02, $4e, $05, $00, $00        ;; 01:54a4 ????????
    db   $02, $02, $10, $02, $52, $05, $00, $00        ;; 01:54ac ????????
    db   $02, $02, $01, $05, $56, $05, $00, $00        ;; 01:54b4 ????????
    db   $02, $02, $04, $05, $5a, $05, $00, $00        ;; 01:54bc ????????
    db   $02, $02, $07, $05, $5e, $05, $00, $00        ;; 01:54c4 ????????
    db   $02, $02, $0a, $05, $62, $05, $00, $00        ;; 01:54cc ????????
    db   $02, $02, $0d, $05, $66, $05, $00, $00        ;; 01:54d4 ????????
    db   $02, $02, $10, $05, $6a, $05, $00, $00        ;; 01:54dc ????????
    db   $02, $02, $01, $08, $6e, $05, $00, $00        ;; 01:54e4 ????????
    db   $02, $02, $04, $08, $72, $05, $00, $00        ;; 01:54ec ????????
    db   $02, $02, $07, $08, $76, $05, $00, $00        ;; 01:54f4 ????????
    db   $02, $02, $0a, $08, $7a, $05, $00, $00        ;; 01:54fc ????????
    db   $02, $02, $0d, $08, $7e, $05, $00, $00        ;; 01:5504 ????????
    db   $02, $02, $10, $08, $82, $05, $00, $00        ;; 01:550c ????????
    db   $02, $02, $01, $0b, $86, $05, $00, $00        ;; 01:5514 ????????
    db   $02, $02, $04, $0b, $8a, $05, $00, $00        ;; 01:551c ????????
    db   $02, $02, $07, $0b, $8e, $05, $00, $00        ;; 01:5524 ????????
    db   $02, $02, $0a, $0b, $92, $05, $00, $00        ;; 01:552c ????????
    db   $02, $02, $0d                                 ;; 01:5534 ???

data_01_5537:
    db   $0b, $96, $05, $00, $00, $02, $02, $10        ;; 01:5537 ????????
    db   $0b, $9a, $05, $00, $00, $02, $02, $01        ;; 01:553f ????????
    db   $0e, $9e, $05, $00, $00, $02, $02, $04        ;; 01:5547 ????????
    db   $0e, $a2, $05, $00, $00, $02, $02, $07        ;; 01:554f ????????
    db   $0e, $a6, $05, $00, $00, $02, $02, $0a        ;; 01:5557 ????????
    db   $0e, $aa, $05, $00, $00, $02, $02, $0d        ;; 01:555f ????????
    db   $0e, $ae, $05, $00, $00, $02, $02, $10        ;; 01:5567 ????????
    db   $0e, $b2, $05, $00, $00                       ;; 01:556f ?????

data_01_5574:
    dw   data_01_5692                                  ;; 01:5574 pP
    db   $90, $02, $00, $00, $00, $00                  ;; 01:5576 ......
    dw   data_01_56ab                                  ;; 01:557c pP
    db   $90, $02, $00, $00, $00, $00                  ;; 01:557e ......
    dw   data_01_56c4                                  ;; 01:5584 pP
    db   $90, $02, $00, $00, $00, $00                  ;; 01:5586 ......
    dw   data_01_56e5                                  ;; 01:558c pP
    db   $90, $02, $00, $00, $00, $00, $06, $57        ;; 01:558e ......??
    db   $89, $03, $00, $00, $00, $00                  ;; 01:5596 ??????
    dw   data_01_571f                                  ;; 01:559c pP
    db   $a9, $02, $00, $00, $00, $00, $ca, $58        ;; 01:559e ......??
    db   $82, $00, $08, $10, $18, $18                  ;; 01:55a6 ??????
    dw   data_01_57b1                                  ;; 01:55ac pP
    db   $00, $02, $00, $4c, $00, $0c                  ;; 01:55ae ......
    dw   data_01_57ca                                  ;; 01:55b4 pP
    db   $c4, $00, $00, $00, $00, $00, $db, $57        ;; 01:55b6 ......??
    db   $c0, $01, $00, $50, $00, $18, $f4, $57        ;; 01:55be ????????
    db   $c0, $02, $00, $40, $00, $20                  ;; 01:55c6 ??????
    dw   data_01_5815                                  ;; 01:55cc pP
    db   $c0, $03, $00, $38, $00, $18, $67, $58        ;; 01:55ce ......??
    db   $00, $00, $00, $00, $00, $00, $70, $58        ;; 01:55d6 ????????
    db   $00, $00, $00, $00, $00, $00, $71, $58        ;; 01:55de ????????
    db   $c0, $00, $00, $00, $00, $00, $eb, $58        ;; 01:55e6 ????????
    db   $82, $1e, $08, $10, $18, $18                  ;; 01:55ee ??????
    dw   data_01_5a26                                  ;; 01:55f4 pP
    db   $c0, $00, $00, $00, $00, $00, $2f, $5a        ;; 01:55f6 ......??
    db   $c0, $04, $00, $00, $00, $00, $58, $5a        ;; 01:55fe ????????
    db   $c0, $00, $00, $00, $00, $00                  ;; 01:5606 ??????
    dw   data_01_5a61                                  ;; 01:560c pP
    db   $c0, $00, $00, $00, $00, $00                  ;; 01:560e ......
    dw   data_01_5a6a                                  ;; 01:5614 pP
    db   $c0, $00, $00, $00, $00, $00, $0c, $59        ;; 01:5616 ......??
    db   $82, $1e, $08, $10, $18, $18                  ;; 01:561e ??????
    dw   data_01_5a73                                  ;; 01:5624 pP
    db   $c0, $00, $00, $00, $00, $00, $7c, $5a        ;; 01:5626 ......??
    db   $c0, $00, $00, $00, $00, $00, $85, $5a        ;; 01:562e ????????
    db   $c0, $00, $00, $00, $00, $00, $8e, $5a        ;; 01:5636 ????????
    db   $c0, $00, $00, $00, $00, $00, $97, $5a        ;; 01:563e ????????
    db   $c0, $00, $00, $00, $00, $00, $a0, $5a        ;; 01:5646 ????????
    db   $00, $00, $00, $00, $00, $00                  ;; 01:564e ??????

data_01_5654:
    db   $d7, $06, $d7, $06, $d7, $06, $d7, $06        ;; 01:5654 ........
    db   $d7, $06, $d7, $06, $d7, $03, $c7, $01        ;; 01:565c ??..??..
    db   $d7, $06, $d7, $07, $d7, $07, $d7, $07        ;; 01:5664 ..????..
    db   $d7, $06, $d7, $06, $d7, $07, $d7, $03        ;; 01:566c ????????
    db   $c7, $02, $c7, $04, $c7, $05, $c7, $09        ;; 01:5674 ..????..
    db   $c7, $08, $d7, $03, $c7, $0a, $c7, $0b        ;; 01:567c ..??..??
    db   $c7, $0c, $c7, $0d, $c7, $0e, $d7, $06        ;; 01:5684 ????????

data_01_568c:
    db   $2d, $59                                      ;; 01:568c ??
    dw   data_01_583e                                  ;; 01:568e pP
    db   $1f, $57                                      ;; 01:5690 ??

data_01_5692:
    db   $0a, $fe, $fe, $02, $e4, $5c, $0f, $83        ;; 01:5692 w..w....
    db   $0b, $fe, $fe, $01, $eb, $5c, $00, $83        ;; 01:569a w..w....
    db   $0c, $fe, $fe, $01, $f2, $5c, $51, $83        ;; 01:56a2 w..w....
    db   $ff                                           ;; 01:56aa .

data_01_56ab:
    db   $0a, $fe, $fe, $02, $fc, $5c, $0f, $83        ;; 01:56ab w..w....
    db   $0b, $fe, $fe, $01, $12, $5d, $00, $83        ;; 01:56b3 w..w....
    db   $0c, $fe, $fe, $01, $1a, $5d, $61, $83        ;; 01:56bb w..w....
    db   $ff                                           ;; 01:56c3 .

data_01_56c4:
    db   $09, $fe, $fe, $00, $03, $e5, $0f, $83        ;; 01:56c4 w..w....
    db   $0a, $fe, $fe, $02, $e4, $5c, $0f, $83        ;; 01:56cc w..w....
    db   $0b, $fe, $fe, $01, $eb, $5c, $00, $83        ;; 01:56d4 w..w....
    db   $0c, $fe, $fe, $01, $f7, $5c, $51, $83        ;; 01:56dc w..w....
    db   $ff                                           ;; 01:56e4 .

data_01_56e5:
    db   $09, $fe, $fe, $00, $03, $e5, $0f, $83        ;; 01:56e5 w..w....
    db   $0a, $fe, $fe, $02, $06, $5d, $0f, $83        ;; 01:56ed w..w....
    db   $0b, $fe, $fe, $01, $12, $5d, $00, $83        ;; 01:56f5 w..w....
    db   $0c, $fe, $fe, $01, $1a, $5d, $61, $83        ;; 01:56fd w..w....
    db   $ff, $12, $fe, $fe, $02, $28, $5d, $0f        ;; 01:5705 .???????
    db   $83, $15, $fe, $fe, $01, $f2, $5c, $02        ;; 01:570d ????????
    db   $83, $00, $00, $00, $00, $02, $ec, $0f        ;; 01:5715 ????????
    db   $e0, $ff                                      ;; 01:571d ??

data_01_571f:
    db   $00, $00, $00, $00, $00, $e9, $0f, $e0        ;; 01:571f w.......
    db   $13, $fe, $fe, $01, $32, $5d, $80, $83        ;; 01:5727 w..w....
    db   $14, $fe, $fe, $01, $3e, $5d, $41, $83        ;; 01:572f w..w....
    db   $16, $fe, $fe, $00, $00, $ea, $0f, $83        ;; 01:5737 w..w....
    db   $19, $fe, $fe, $00, $62, $5d, $0f, $c3        ;; 01:573f w..w....
    db   $1a, $fe, $fe, $00, $00, $e8, $0f, $c7        ;; 01:5747 w..ww...
    db   $1b, $fe, $fe, $00, $01, $e8, $0f, $c7        ;; 01:574f w..ww...
    db   $1c, $fe, $fe, $00, $02, $e8, $0f, $c7        ;; 01:5757 w..ww...
    db   $1d, $fe, $fe, $00, $03, $e8, $0f, $c7        ;; 01:575f w..ww...
    db   $1e, $fe, $fe, $00, $04, $e8, $0f, $c7        ;; 01:5767 w..ww...
    db   $17, $00, $00, $66, $00, $e0, $0f, $80        ;; 01:576f w..ww...
    db   $18, $00, $00, $6a, $01, $e0, $0f, $80        ;; 01:5777 w..ww...
    db   $00, $00, $00, $84, $03, $e1, $0f, $c4        ;; 01:577f w..ww...
    db   $00, $00, $00, $88, $04, $e1, $0f, $c4        ;; 01:5787 w..ww...
    db   $00, $00, $00, $8c, $05, $e1, $0f, $c4        ;; 01:578f w..ww...
    db   $00, $00, $00, $98, $06, $e1, $0f, $c4        ;; 01:5797 w..ww...
    db   $ff                                           ;; 01:579f .

data_01_57a0:
    db   $00, $00, $00, $00, $00, $e9, $0f, $e0        ;; 01:57a0 w...w...
    db   $16, $fe, $fe, $00, $00, $ea, $0f, $e3        ;; 01:57a8 w..w....
    db   $ff                                           ;; 01:57b0 .

data_01_57b1:
    db   $00, $00, $00, $00, $01, $ed, $0f, $e0        ;; 01:57b1 w...w...
    db   $0d, $fe, $fe, $00, $cf, $5c, $10, $e3        ;; 01:57b9 w..w....
    db   $0d, $fe, $fe, $00, $db, $5c, $31, $e3        ;; 01:57c1 w..w....
    db   $ff                                           ;; 01:57c9 .

data_01_57ca:
    db   $10, $fe, $fe, $02, $56, $5d, $0f, $83        ;; 01:57ca w..w....
    db   $11, $fe, $fe, $01, $00, $e4, $0f, $83        ;; 01:57d2 w..w....
    db   $ff, $04, $00, $fe, $00, $00, $e5, $00        ;; 01:57da .???????
    db   $83, $08, $fe, $fe, $00, $d3, $5e, $0f        ;; 01:57e2 ????????
    db   $83, $00, $00, $00, $00, $01, $ec, $0f        ;; 01:57ea ????????
    db   $e0, $ff, $06, $00, $fe, $00, $00, $e5        ;; 01:57f2 ????????
    db   $00, $83, $07, $00, $fe, $00, $01, $e5        ;; 01:57fa ????????
    db   $01, $83, $08, $fe, $fe, $00, $ac, $5e        ;; 01:5802 ????????
    db   $0f, $83, $00, $00, $00, $00, $01, $ec        ;; 01:580a ????????
    db   $0f, $e0, $ff                                 ;; 01:5812 ???

data_01_5815:
    db   $03, $00, $fe, $00, $00, $e5, $00, $83        ;; 01:5815 w..ww...
    db   $04, $00, $fe, $00, $01, $e5, $01, $83        ;; 01:581d w..ww...
    db   $05, $00, $fe, $00, $02, $e5, $02, $83        ;; 01:5825 w..ww...
    db   $08, $fe, $fe, $00, $ac, $5e, $0f, $83        ;; 01:582d w..w....
    db   $00, $00, $00, $00, $01, $ec, $0f, $e0        ;; 01:5835 w...w...
    db   $ff                                           ;; 01:583d .

data_01_583e:
    db   $01, $fe, $fe, $02, $00, $e3, $0f, $83        ;; 01:583e w..w....
    db   $02, $fe, $fe, $00, $00, $e4, $0f, $83        ;; 01:5846 w..w....
    db   $00, $00, $00, $06, $00, $e2, $0f, $80        ;; 01:584e w..w....
    db   $00, $00, $00, $e8, $05, $e1, $0f, $c4        ;; 01:5856 w..ww...
    db   $00, $00, $00, $02, $01, $e7, $0f, $c4        ;; 01:585e w..ww...
    db   $ff, $16, $fe, $fe, $02, $28, $5d, $0f        ;; 01:5866 .???????
    db   $83, $ff, $ff, $1f, $fe, $fe, $01, $64        ;; 01:586e ????????
    db   $5d, $0f, $83, $20, $fe, $fe, $00, $00        ;; 01:5876 ????????
    db   $ee, $0f, $83, $21, $fe, $fe, $00, $75        ;; 01:587e ????????
    db   $5d, $0f, $83, $22, $fe, $fe, $00, $7c        ;; 01:5886 ????????
    db   $5d, $0f, $83, $23, $fe, $fe, $00, $83        ;; 01:588e ????????
    db   $5d, $0f, $83, $24, $fe, $fe, $00, $05        ;; 01:5896 ????????
    db   $e8, $0f, $83, $25, $fe, $fe, $00, $06        ;; 01:589e ????????
    db   $e8, $0f, $83, $26, $fe, $fe, $00, $07        ;; 01:58a6 ????????
    db   $e8, $0f, $83, $00, $00, $00, $00, $07        ;; 01:58ae ????????
    db   $e9, $0f, $e0, $00, $00, $00, $98, $06        ;; 01:58b6 ????????
    db   $e1, $0f, $c4, $27, $00, $00, $00, $00        ;; 01:58be ????????
    db   $ef, $0f, $c0, $ff, $00, $00, $00, $ff        ;; 01:58c6 ????????
    db   $0e, $e9, $0f, $e0, $00, $00, $00, $00        ;; 01:58ce ????????
    db   $00, $e6, $0f, $e0, $49, $00, $00, $03        ;; 01:58d6 ????????
    db   $1e, $eb, $0f, $87, $00, $00, $00, $00        ;; 01:58de ????????
    db   $00, $ec, $0f, $e0, $ff, $00, $00, $00        ;; 01:58e6 ????????
    db   $ff, $0d, $e9, $0f, $e0, $00, $00, $00        ;; 01:58ee ????????
    db   $00, $00, $e6, $0f, $e0, $49, $00, $00        ;; 01:58f6 ????????
    db   $03, $1d, $eb, $0f, $87, $00, $00, $00        ;; 01:58fe ????????
    db   $00, $00, $ec, $0f, $e0, $ff, $00, $00        ;; 01:5906 ????????
    db   $00, $ff, $0f, $e9, $0f, $e0, $00, $00        ;; 01:590e ????????
    db   $00, $00, $00, $e6, $0f, $e0, $49, $00        ;; 01:5916 ????????
    db   $00, $03, $1d, $eb, $0f, $87, $00, $00        ;; 01:591e ????????
    db   $00, $00, $00, $ec, $0f, $e0, $ff, $00        ;; 01:5926 ????????
    db   $00, $00, $02, $02, $e7, $0f, $c4, $00        ;; 01:592e ????????
    db   $00, $00, $06, $07, $e1, $0f, $c0, $2c        ;; 01:5936 ????????
    db   $00, $00, $03, $00, $eb, $0f, $87, $2d        ;; 01:593e ????????
    db   $00, $00, $03, $01, $eb, $0f, $87, $2e        ;; 01:5946 ????????
    db   $00, $00, $03, $02, $eb, $0f, $87, $2f        ;; 01:594e ????????
    db   $00, $00, $03, $03, $eb, $0f, $87, $30        ;; 01:5956 ????????
    db   $00, $00, $03, $04, $eb, $0f, $87, $31        ;; 01:595e ????????
    db   $00, $00, $03, $05, $eb, $0f, $87, $32        ;; 01:5966 ????????
    db   $00, $00, $03, $06, $eb, $0f, $87, $33        ;; 01:596e ????????
    db   $00, $00, $03, $07, $eb, $0f, $87, $34        ;; 01:5976 ????????
    db   $00, $00, $03, $08, $eb, $0f, $87, $35        ;; 01:597e ????????
    db   $00, $00, $03, $09, $eb, $0f, $87, $36        ;; 01:5986 ????????
    db   $00, $00, $03, $0a, $eb, $0f, $87, $37        ;; 01:598e ????????
    db   $00, $00, $03, $0b, $eb, $0f, $87, $38        ;; 01:5996 ????????
    db   $00, $00, $03, $0c, $eb, $0f, $87, $39        ;; 01:599e ????????
    db   $00, $00, $03, $0d, $eb, $0f, $87, $3a        ;; 01:59a6 ????????
    db   $00, $00, $03, $0e, $eb, $0f, $87, $3b        ;; 01:59ae ????????
    db   $00, $00, $03, $0f, $eb, $0f, $87, $3c        ;; 01:59b6 ????????
    db   $00, $00, $03, $10, $eb, $0f, $87, $3d        ;; 01:59be ????????
    db   $00, $00, $03, $11, $eb, $0f, $87, $3e        ;; 01:59c6 ????????
    db   $00, $00, $03, $12, $eb, $0f, $87, $3f        ;; 01:59ce ????????
    db   $00, $00, $03, $13, $eb, $0f, $87, $40        ;; 01:59d6 ????????
    db   $00, $00, $03, $14, $eb, $0f, $87, $41        ;; 01:59de ????????
    db   $00, $00, $03, $15, $eb, $0f, $87, $42        ;; 01:59e6 ????????
    db   $00, $00, $03, $16, $eb, $0f, $87, $43        ;; 01:59ee ????????
    db   $00, $00, $03, $17, $eb, $0f, $87, $44        ;; 01:59f6 ????????
    db   $00, $00, $03, $18, $eb, $0f, $87, $45        ;; 01:59fe ????????
    db   $00, $00, $03, $19, $eb, $0f, $87, $46        ;; 01:5a06 ????????
    db   $00, $00, $03, $1a, $eb, $0f, $87, $47        ;; 01:5a0e ????????
    db   $00, $00, $03, $1b, $eb, $0f, $87, $48        ;; 01:5a16 ????????
    db   $00, $00, $03, $1c, $eb, $0f, $87, $ff        ;; 01:5a1e ????????

data_01_5a26:
    db   $00, $00, $00, $00, $00, $ed, $0f, $e0        ;; 01:5a26 w...w...
    db   $ff, $00, $00, $00, $00, $02, $ed, $0f        ;; 01:5a2e .???????
    db   $e0, $0d, $fe, $fe, $00, $cf, $5c, $00        ;; 01:5a36 ????????
    db   $e3, $0d, $fe, $fe, $00, $d5, $5c, $01        ;; 01:5a3e ????????
    db   $e3, $0d, $fe, $fe, $00, $d5, $5c, $02        ;; 01:5a46 ????????
    db   $e3, $0d, $fe, $fe, $00, $d5, $5c, $03        ;; 01:5a4e ????????
    db   $e3, $ff, $00, $00, $00, $00, $03, $ed        ;; 01:5a56 ????????
    db   $0f, $e0, $ff                                 ;; 01:5a5e ???

data_01_5a61:
    db   $00, $00, $00, $00, $04, $ed, $0f, $e0        ;; 01:5a61 w...w...
    db   $ff                                           ;; 01:5a69 .

data_01_5a6a:
    db   $00, $00, $00, $00, $05, $ed, $0f, $e0        ;; 01:5a6a w...w...
    db   $ff                                           ;; 01:5a72 .

data_01_5a73:
    db   $00, $00, $00, $00, $06, $ed, $0f, $e0        ;; 01:5a73 w...w...
    db   $ff, $00, $00, $00, $00, $07, $ed, $0f        ;; 01:5a7b .???????
    db   $e0, $ff, $00, $00, $00, $00, $08, $ed        ;; 01:5a83 ????????
    db   $0f, $e0, $ff, $00, $00, $00, $00, $09        ;; 01:5a8b ????????
    db   $ed, $0f, $e0, $ff, $00, $00, $00, $00        ;; 01:5a93 ????????
    db   $0a, $ed, $0f, $e0, $ff, $16, $fe, $fe        ;; 01:5a9b ????????
    db   $02, $1f, $5d, $0f, $83, $ff                  ;; 01:5aa3 ??????

data_01_5aa9:
    db   $cf, $5a, $ef, $5a, $09, $5b, $1d, $5b        ;; 01:5aa9 ........
    db   $2b, $5b, $33, $5b, $13, $5c, $3b, $5b        ;; 01:5ab1 ......??
    db   $6d, $5b, $99, $5b, $bf, $5b, $df, $5b        ;; 01:5ab9 ????????
    db   $f9, $5b, $6f, $5c, $7d, $5c, $8b, $5c        ;; 01:5ac1 ????????
    db   $b9, $d6, $b9, $d6, $b9, $d6, $02, $48        ;; 01:5ac9 ??????w.
    db   $24, $01, $03, $03, $04, $48, $44, $03        ;; 01:5ad1 ........
    db   $03, $03, $04, $48, $64, $05, $03, $03        ;; 01:5ad9 ........
    db   $04, $68, $34, $07, $04, $03, $04, $68        ;; 01:5ae1 ........
    db   $54, $09, $04, $03, $04, $ff, $02, $48        ;; 01:5ae9 ......w.
    db   $34, $01, $03, $03, $04, $48, $54, $03        ;; 01:5af1 ........
    db   $03, $03, $04, $68, $34, $07, $04, $03        ;; 01:5af9 ........
    db   $04, $68, $54, $09, $04, $03, $04, $ff        ;; 01:5b01 ........
    db   $02, $48, $44, $01, $03, $03, $04, $68        ;; 01:5b09 w.......
    db   $34, $07, $04, $03, $04, $68, $54, $09        ;; 01:5b11 ........
    db   $04, $03, $04, $ff, $02, $58, $34, $01        ;; 01:5b19 ....w...
    db   $03, $03, $04, $58, $54, $03, $03, $03        ;; 01:5b21 ........
    db   $04, $ff, $02, $58, $44, $01, $03, $03        ;; 01:5b29 ..w.....
    db   $04, $ff, $02, $58, $44, $0b, $05, $03        ;; 01:5b31 ..w.....
    db   $04, $ff, $02, $10, $14, $01, $01, $03        ;; 01:5b39 ..??????
    db   $04, $10, $44, $03, $01, $03, $04, $10        ;; 01:5b41 ????????
    db   $74, $05, $01, $03, $04, $58, $29, $07        ;; 01:5b49 ????????
    db   $02, $03, $04, $58, $61, $09, $02, $03        ;; 01:5b51 ????????
    db   $04, $3b, $1c, $92, $04, $01, $02, $3b        ;; 01:5b59 ????????
    db   $4c, $94, $05, $01, $02, $3b, $7c, $96        ;; 01:5b61 ????????
    db   $06, $01, $02, $ff, $02, $10, $2c, $01        ;; 01:5b69 ????????
    db   $01, $03, $04, $10, $5c, $03, $01, $03        ;; 01:5b71 ????????
    db   $04, $58, $29, $07, $02, $03, $04, $58        ;; 01:5b79 ????????
    db   $61, $09, $02, $03, $04, $3b, $1c, $92        ;; 01:5b81 ????????
    db   $04, $01, $02, $3b, $4c, $94, $05, $01        ;; 01:5b89 ????????
    db   $02, $3b, $7c, $96, $06, $01, $02, $ff        ;; 01:5b91 ????????
    db   $02, $10, $44, $01, $01, $03, $04, $58        ;; 01:5b99 ????????
    db   $29, $07, $02, $03, $04, $58, $61, $09        ;; 01:5ba1 ????????
    db   $02, $03, $04, $3b, $1c, $92, $04, $01        ;; 01:5ba9 ????????
    db   $02, $3b, $4c, $94, $05, $01, $02, $3b        ;; 01:5bb1 ????????
    db   $7c, $96, $06, $01, $02, $ff, $02, $10        ;; 01:5bb9 ????????
    db   $2c, $01, $01, $03, $04, $10, $5c, $03        ;; 01:5bc1 ????????
    db   $01, $03, $04, $3b, $1c, $92, $04, $01        ;; 01:5bc9 ????????
    db   $02, $3b, $4c, $94, $05, $01, $02, $3b        ;; 01:5bd1 ????????
    db   $7c, $96, $06, $01, $02, $ff, $02, $10        ;; 01:5bd9 ????????
    db   $44, $01, $01, $03, $04, $3b, $1c, $92        ;; 01:5be1 ????????
    db   $04, $01, $02, $3b, $4c, $94, $05, $01        ;; 01:5be9 ????????
    db   $02, $3b, $7c, $96, $06, $01, $02, $ff        ;; 01:5bf1 ????????
    db   $02, $10, $44, $0b, $03, $03, $04, $3b        ;; 01:5bf9 ????????
    db   $1c, $92, $04, $01, $02, $3b, $4c, $94        ;; 01:5c01 ????????
    db   $05, $01, $02, $3b, $7c, $96, $06, $01        ;; 01:5c09 ????????
    db   $02, $ff, $02, $48, $20, $84, $06, $02        ;; 01:5c11 ??w.....
    db   $02, $48, $38, $6e, $00, $01, $02, $48        ;; 01:5c19 ........
    db   $40, $70, $00, $03, $02, $48, $60, $88        ;; 01:5c21 ........
    db   $06, $02, $02, $48, $70, $6e, $00, $01        ;; 01:5c29 ........
    db   $02, $48, $78, $76, $00, $01, $02, $58        ;; 01:5c31 ........
    db   $38, $8c, $03, $02, $02, $58, $4c, $6e        ;; 01:5c39 ........
    db   $00, $01, $02, $58, $58, $78, $00, $02        ;; 01:5c41 ........
    db   $02, $69, $38, $90, $04, $02, $02, $69        ;; 01:5c49 ........
    db   $4c, $6e, $00, $01, $02, $69, $58, $7c        ;; 01:5c51 ........
    db   $00, $02, $02, $7a, $38, $94, $05, $02        ;; 01:5c59 ........
    db   $02, $7a, $4c, $6e, $00, $01, $02, $7a        ;; 01:5c61 ........
    db   $58, $80, $00, $02, $02, $ff, $02, $30        ;; 01:5c69 ......??
    db   $3c, $06, $07, $05, $02, $40, $2c, $2c        ;; 01:5c71 ????????
    db   $07, $09, $02, $ff, $02, $30, $34, $10        ;; 01:5c79 ????????
    db   $07, $07, $02, $40, $2c, $2c, $07, $09        ;; 01:5c81 ????????
    db   $02, $ff, $02, $30, $34, $1e, $07, $07        ;; 01:5c89 ????????
    db   $02, $40, $2c, $2c, $07, $09, $02, $ff        ;; 01:5c91 ????????

data_01_5c99:
    db   $20, $41, $42, $41, $43, $41, $42, $41        ;; 01:5c99 ????????
    db   $44, $41, $42, $41, $43, $41, $42, $41        ;; 01:5ca1 ????????
    db   $20, $45, $46, $45, $47, $45, $46, $45        ;; 01:5ca9 ????????
    db   $48, $45, $46, $45, $47, $45, $46, $45        ;; 01:5cb1 ????????

data_01_5cb9:
    db   $00, $40, $00, $6d, $00, $70, $00, $6a        ;; 01:5cb9 ????????
    db   $00, $76, $00, $40, $00, $40, $00, $67        ;; 01:5cc1 ????....
    db   $00, $79, $00, $40, $00, $73, $53, $54        ;; 01:5cc9 ??????..
    db   $41, $52, $54, $80, $53, $4f, $55, $4e        ;; 01:5cd1 ....????
    db   $44, $80, $50, $41, $53, $53, $57, $4f        ;; 01:5cd9 ??......
    db   $52, $44, $80, $50, $41, $55, $53, $45        ;; 01:5ce1 ........
    db   $44, $80, $52, $45, $53, $55, $4d, $45        ;; 01:5ce9 ........
    db   $80, $51, $55, $49, $54, $80, $45, $58        ;; 01:5cf1 ........
    db   $49, $54, $80, $51, $55, $49, $54, $20        ;; 01:5cf9 ........
    db   $47, $41, $4d, $45, $80, $45, $58, $49        ;; 01:5d01 ........
    db   $54, $20, $54, $4f, $20, $4d, $41, $50        ;; 01:5d09 ........
    db   $80, $4e, $4f, $20, $57, $41, $59, $21        ;; 01:5d11 ........
    db   $80, $4f, $4b, $41, $59, $80, $54, $49        ;; 01:5d19 ......??
    db   $4d, $45, $20, $55, $50, $21, $80, $47        ;; 01:5d21 ????????
    db   $41, $4d, $45, $20, $4f, $56, $45, $52        ;; 01:5d29 ????????
    db   $80, $52, $45, $53, $55, $4d, $45, $20        ;; 01:5d31 ?.......
    db   $50, $4c, $41, $59, $80, $53, $45, $45        ;; 01:5d39 ........
    db   $20, $50, $41, $53, $53, $57, $4f, $52        ;; 01:5d41 ........
    db   $44, $80                                      ;; 01:5d49 ..

data_01_5d4b:
    db   $47, $41, $4d, $45, $20, $53, $54, $41        ;; 01:5d4b ........
    db   $54, $53, $80, $45, $4e, $54, $45, $52        ;; 01:5d53 ........
    db   $49, $4e, $47, $2e, $2e, $2e, $80, $58        ;; 01:5d5b ........
    db   $80, $43, $4f, $4e, $47, $52, $41, $54        ;; 01:5d63 .???????
    db   $55, $4c, $41, $54, $49, $4f, $4e, $53        ;; 01:5d6b ????????
    db   $21, $80, $52, $45, $57, $41, $52, $44        ;; 01:5d73 ????????
    db   $80, $48, $49, $44, $44, $45, $4e, $80        ;; 01:5d7b ????????
    db   $50, $52, $45, $53, $53, $20, $42, $20        ;; 01:5d83 ????????
    db   $54, $4f, $20, $43, $4f, $4e, $54, $49        ;; 01:5d8b ????????
    db   $4e, $55, $45, $80, $30, $20, $4f, $46        ;; 01:5d93 ????????
    db   $20, $33, $20, $52, $45, $44, $20, $52        ;; 01:5d9b ????????
    db   $45, $4d, $4f, $54, $45, $53, $20, $46        ;; 01:5da3 ????????
    db   $4f, $55, $4e, $44, $80, $31, $20, $4f        ;; 01:5dab ????????
    db   $46, $20, $33, $20, $52, $45, $44, $20        ;; 01:5db3 ????????
    db   $52, $45, $4d, $4f, $54, $45, $53, $20        ;; 01:5dbb ????????
    db   $46, $4f, $55, $4e, $44, $80, $32, $20        ;; 01:5dc3 ????????
    db   $4f, $46, $20, $33, $20, $52, $45, $44        ;; 01:5dcb ????????
    db   $20, $52, $45, $4d, $4f, $54, $45, $53        ;; 01:5dd3 ????????
    db   $20, $46, $4f, $55, $4e, $44, $80, $33        ;; 01:5ddb ????????
    db   $20, $4f, $46, $20, $33, $20, $52, $45        ;; 01:5de3 ????????
    db   $44, $20, $52, $45, $4d, $4f, $54, $45        ;; 01:5deb ????????
    db   $53, $20, $46, $4f, $55, $4e, $44, $80        ;; 01:5df3 ????????
    db   $30, $20, $4f, $46, $20, $32, $20, $52        ;; 01:5dfb ????????
    db   $45, $44, $20, $52, $45, $4d, $4f, $54        ;; 01:5e03 ????????
    db   $45, $53, $20, $46, $4f, $55, $4e, $44        ;; 01:5e0b ????????
    db   $80, $31, $20, $4f, $46, $20, $32, $20        ;; 01:5e13 ????????
    db   $52, $45, $44, $20, $52, $45, $4d, $4f        ;; 01:5e1b ????????
    db   $54, $45, $53, $20, $46, $4f, $55, $4e        ;; 01:5e23 ????????
    db   $44, $80, $32, $20, $4f, $46, $20, $32        ;; 01:5e2b ????????
    db   $20, $52, $45, $44, $20, $52, $45, $4d        ;; 01:5e33 ????????
    db   $4f, $54, $45, $53, $20, $46, $4f, $55        ;; 01:5e3b ????????
    db   $4e, $44, $80, $30, $20, $4f, $46, $20        ;; 01:5e43 ????????
    db   $31, $20, $52, $45, $44, $20, $52, $45        ;; 01:5e4b ????????
    db   $4d, $4f, $54, $45, $53, $20, $46, $4f        ;; 01:5e53 ????????
    db   $55, $4e, $44, $80, $31, $20, $4f, $46        ;; 01:5e5b ????????
    db   $20, $31, $20, $52, $45, $44, $20, $52        ;; 01:5e63 ????????
    db   $45, $4d, $4f, $54, $45, $53, $20, $46        ;; 01:5e6b ????????
    db   $4f, $55, $4e, $44, $80, $30, $20, $4f        ;; 01:5e73 ????????
    db   $46, $20, $31, $20, $47, $4f, $4c, $44        ;; 01:5e7b ????????
    db   $20, $52, $45, $4d, $4f, $54, $45, $53        ;; 01:5e83 ????????
    db   $20, $46, $4f, $55, $4e, $44, $80, $31        ;; 01:5e8b ????????
    db   $20, $4f, $46, $20, $31, $20, $47, $4f        ;; 01:5e93 ????????
    db   $4c, $44, $20, $52, $45, $4d, $4f, $54        ;; 01:5e9b ????????
    db   $45, $53, $20, $46, $4f, $55, $4e, $44        ;; 01:5ea3 ????????
    db   $80, $43, $48, $4f, $4f, $53, $45, $20        ;; 01:5eab ?.......
    db   $41, $20, $48, $49, $4e, $54, $20, $54        ;; 01:5eb3 ........
    db   $48, $45, $4e, $20, $50, $52, $45, $53        ;; 01:5ebb ........
    db   $53, $20, $42, $20, $54, $4f, $20, $43        ;; 01:5ec3 ........
    db   $4f, $4e, $54, $49, $4e, $55, $45, $80        ;; 01:5ecb ........
    db   $50, $52, $45, $53, $53, $20, $42, $20        ;; 01:5ed3 ????????
    db   $54, $4f, $20, $43, $4f, $4e, $54, $49        ;; 01:5edb ????????
    db   $4e, $55, $45, $80                            ;; 01:5ee3 ????

data_01_5ee7:
    db   $fd, $5e, $08, $5f, $18, $5f, $28, $5f        ;; 01:5ee7 ????????
    db   $38, $5f, $42, $5f, $51, $5f, $5b, $5f        ;; 01:5eef ????....
    db   $63, $5f, $71, $5f, $80, $5f, $47, $41        ;; 01:5ef7 ????????
    db   $4d, $45, $20, $53, $54, $41, $54, $53        ;; 01:5eff ????????
    db   $80, $43, $49, $52, $43, $55, $49, $54        ;; 01:5f07 ????????
    db   $20, $43, $45, $4e, $54, $52, $41, $4c        ;; 01:5f0f ????????
    db   $80, $4b, $55, $4e, $47, $2d, $46, $55        ;; 01:5f17 ????????
    db   $20, $54, $48, $45, $41, $54, $52, $45        ;; 01:5f1f ????????
    db   $80, $50, $52, $45, $48, $49, $53, $54        ;; 01:5f27 ????????
    db   $20, $43, $48, $41, $4e, $4e, $45, $4c        ;; 01:5f2f ????????
    db   $80, $52, $45, $5a, $4f, $50, $4f, $4c        ;; 01:5f37 ????????
    db   $49, $53, $80, $52, $4f, $43, $4b, $45        ;; 01:5f3f ????????
    db   $54, $20, $43, $48, $41, $4e, $4e, $45        ;; 01:5f47 ????????
    db   $4c, $80, $53, $43, $52, $45, $41, $4d        ;; 01:5f4f ??......
    db   $20, $54, $56, $80, $54, $4f, $4f, $4e        ;; 01:5f57 ........
    db   $20, $54, $56, $80, $42, $4f, $4e, $55        ;; 01:5f5f ....????
    db   $53, $20, $42, $4f, $4e, $41, $4e, $5a        ;; 01:5f67 ????????
    db   $41, $80, $53, $45, $43, $52, $45, $54        ;; 01:5f6f ????????
    db   $20, $53, $54, $41, $54, $49, $4f, $4e        ;; 01:5f77 ????????
    db   $80, $42, $4f, $53, $53, $20, $54, $56        ;; 01:5f7f ????????
    db   $80, $90, $5f, $a4, $5f, $a5, $5f, $a6        ;; 01:5f87 ?..?????
    db   $5f, $54, $48, $45, $20, $4d, $45, $44        ;; 01:5f8f ?.......
    db   $49, $41, $20, $44, $49, $4d, $45, $4e        ;; 01:5f97 ........
    db   $53, $49, $4f, $4e, $80, $80, $80, $80        ;; 01:5f9f .....???
    db   $af, $5f                                      ;; 01:5fa7 ..
    dw   .data_01_5fbb                                 ;; 01:5fa9 pP
    dw   .data_01_5fd6                                 ;; 01:5fab pP
    dw   .data_01_5feb                                 ;; 01:5fad pP
    db   $4f, $55, $54, $20, $4f, $46, $20, $54        ;; 01:5faf ........
    db   $4f, $4f, $4e, $80                            ;; 01:5fb7 ....
.data_01_5fbb:
    db   $4a, $55, $4d, $50, $20, $54, $4f, $20        ;; 01:5fbb ........
    db   $54, $48, $45, $20, $54, $45, $45, $54        ;; 01:5fc3 ........
    db   $45, $52, $49, $4e, $47, $20, $52, $4f        ;; 01:5fcb ........
    db   $43, $4b, $80                                 ;; 01:5fd3 ...
.data_01_5fd6:
    db   $48, $55, $4e, $54, $20, $54, $48, $45        ;; 01:5fd6 ........
    db   $20, $54, $57, $4f, $20, $48, $55, $4e        ;; 01:5fde ........
    db   $54, $45, $52, $53, $80                       ;; 01:5fe6 .....
.data_01_5feb:
    db   $57, $48, $41, $43, $4b, $20, $46, $49        ;; 01:5feb ........
    db   $56, $45, $20, $50, $55, $52, $50, $4c        ;; 01:5ff3 ........
    db   $45, $20, $4d, $55, $53, $48, $52, $4f        ;; 01:5ffb ........
    db   $4f, $4d, $53, $80, $0f, $60                  ;; 01:6003 ......
    dw   .data_01_601b                                 ;; 01:6009 pP
    dw   .data_01_6037                                 ;; 01:600b pP
    dw   .data_01_6050                                 ;; 01:600d pP
    db   $53, $4d, $45, $4c, $4c, $52, $41, $49        ;; 01:600f ........
    db   $53, $45, $52, $80                            ;; 01:6017 ....
.data_01_601b:
    db   $53, $55, $52, $56, $49, $56, $45, $20        ;; 01:601b ........
    db   $54, $48, $45, $20, $48, $41, $55, $4e        ;; 01:6023 ........
    db   $54, $45, $44, $20, $4d, $41, $4e, $53        ;; 01:602b ........
    db   $49, $4f, $4e, $80                            ;; 01:6033 ....
.data_01_6037:
    db   $53, $4d, $41, $53, $48, $20, $46, $49        ;; 01:6037 ........
    db   $56, $45, $20, $42, $4c, $4f, $4f, $44        ;; 01:603f ........
    db   $20, $43, $4f, $4f, $4c, $45, $52, $53        ;; 01:6047 ........
    db   $80                                           ;; 01:604f .
.data_01_6050:
    db   $52, $49, $44, $45, $20, $54, $48, $45        ;; 01:6050 ........
    db   $20, $48, $41, $55, $4e, $54, $45, $44        ;; 01:6058 ........
    db   $20, $45, $4c, $45, $56, $41, $54, $4f        ;; 01:6060 ........
    db   $52, $80, $72, $60, $83, $60, $98, $60        ;; 01:6068 ....????
    db   $ab, $60, $46, $52, $41, $4e, $4b, $45        ;; 01:6070 ??......
    db   $4e, $53, $54, $45, $49, $4e, $46, $45        ;; 01:6078 ........
    db   $4c, $44, $80, $52, $55, $4e, $20, $54        ;; 01:6080 ...?????
    db   $48, $45, $20, $41, $58, $45, $20, $47        ;; 01:6088 ????????
    db   $41, $55, $4e, $54, $4c, $45, $54, $80        ;; 01:6090 ????????
    db   $48, $45, $41, $44, $20, $44, $4f, $57        ;; 01:6098 ????????
    db   $4e, $20, $54, $48, $45, $20, $52, $41        ;; 01:60a0 ????????
    db   $4d, $50, $80, $53, $54, $49, $43, $4b        ;; 01:60a8 ????????
    db   $20, $41, $43, $52, $4f, $53, $53, $20        ;; 01:60b0 ????????
    db   $54, $48, $45, $20, $54, $4f, $57, $45        ;; 01:60b8 ????????
    db   $52, $20, $4f, $46, $20, $44, $4f, $4f        ;; 01:60c0 ????????
    db   $4d, $80, $d2, $60, $e1, $60, $ff, $60        ;; 01:60c8 ??..????
    db   $1a, $61, $57, $57, $57, $2e, $44, $4f        ;; 01:60d0 ??......
    db   $54, $43, $4f, $4d, $2e, $43, $4f, $4d        ;; 01:60d8 ........
    db   $80, $53, $43, $41, $4c, $45, $20, $54        ;; 01:60e0 .???????
    db   $48, $45, $20, $42, $49, $4f, $4e, $49        ;; 01:60e8 ????????
    db   $43, $20, $4c, $41, $55, $4e, $43, $48        ;; 01:60f0 ????????
    db   $20, $54, $4f, $57, $45, $52, $80, $43        ;; 01:60f8 ????????
    db   $52, $4f, $53, $53, $20, $54, $48, $45        ;; 01:6100 ????????
    db   $20, $44, $41, $54, $41, $20, $42, $55        ;; 01:6108 ????????
    db   $53, $20, $42, $52, $49, $44, $47, $45        ;; 01:6110 ????????
    db   $53, $80, $80, $23, $61, $32, $61, $4b        ;; 01:6118 ???..???
    db   $61, $5e, $61, $4d, $41, $4f, $20, $54        ;; 01:6120 ???.....
    db   $53, $45, $20, $54, $4f, $4e, $47, $55        ;; 01:6128 ........
    db   $45, $80, $44, $45, $46, $45, $41, $54        ;; 01:6130 ..??????
    db   $20, $54, $48, $45, $20, $44, $45, $41        ;; 01:6138 ????????
    db   $44, $4c, $59, $20, $44, $52, $41, $47        ;; 01:6140 ????????
    db   $4f, $4e, $80, $54, $52, $41, $56, $45        ;; 01:6148 ????????
    db   $52, $53, $45, $20, $54, $48, $45, $20        ;; 01:6150 ????????
    db   $53, $54, $45, $50, $53, $80, $80, $67        ;; 01:6158 ????????
    db   $61, $68, $61, $69, $61, $6a, $61, $80        ;; 01:6160 ????????
    db   $80, $80, $80, $73, $61, $81, $61, $99        ;; 01:6168 ???..???
    db   $61, $ab, $61, $50, $41, $4e, $47, $41        ;; 01:6170 ???.....
    db   $45, $41, $20, $39, $30, $32, $31, $30        ;; 01:6178 ........
    db   $80, $41, $53, $53, $41, $55, $4c, $54        ;; 01:6180 .???????
    db   $20, $54, $48, $45, $20, $4c, $41, $56        ;; 01:6188 ????????
    db   $41, $20, $49, $53, $4c, $41, $4e, $44        ;; 01:6190 ????????
    db   $80, $43, $4c, $49, $4d, $42, $20, $54        ;; 01:6198 ????????
    db   $48, $45, $20, $56, $4f, $4c, $43, $41        ;; 01:61a0 ????????
    db   $4e, $4f, $80, $80, $b4, $61, $c1, $61        ;; 01:61a8 ????..??
    db   $d0, $61, $e1, $61, $46, $49, $4e, $45        ;; 01:61b0 ????....
    db   $20, $54, $4f, $4f, $4e, $49, $4e, $47        ;; 01:61b8 ........
    db   $80, $43, $4c, $49, $4d, $42, $20, $54        ;; 01:61c0 .???????
    db   $48, $45, $20, $54, $52, $45, $45, $80        ;; 01:61c8 ????????
    db   $53, $54, $4f, $52, $4d, $20, $54, $48        ;; 01:61d0 ????????
    db   $45, $20, $43, $41, $53, $54, $4c, $45        ;; 01:61d8 ????????
    db   $80, $80, $ea, $61, $f8, $61, $0f, $62        ;; 01:61e0 ??..????
    db   $24, $62, $54, $48, $49, $53, $20, $4f        ;; 01:61e8 ??......
    db   $4c, $44, $20, $43, $41, $56, $45, $80        ;; 01:61f0 ........
    db   $57, $41, $54, $43, $48, $20, $46, $4f        ;; 01:61f8 ????????
    db   $52, $20, $46, $41, $4c, $4c, $49, $4e        ;; 01:6200 ????????
    db   $47, $20, $4c, $41, $56, $41, $80, $52        ;; 01:6208 ????????
    db   $49, $44, $45, $20, $54, $48, $45, $20        ;; 01:6210 ????????
    db   $53, $54, $45, $41, $4d, $20, $56, $45        ;; 01:6218 ????????
    db   $4e, $54, $53, $80, $42, $4f, $55, $4e        ;; 01:6220 ????????
    db   $43, $45, $20, $55, $50, $20, $4f, $56        ;; 01:6228 ????????
    db   $45, $52, $20, $54, $48, $45, $20, $43        ;; 01:6230 ????????
    db   $48, $41, $53, $4d, $80, $45, $62, $5e        ;; 01:6238 ?????..?
    db   $62, $70, $62, $83, $62, $48, $4f, $4e        ;; 01:6240 ?????...
    db   $45, $59, $20, $49, $20, $53, $48, $52        ;; 01:6248 ........
    db   $55, $4e, $4b, $20, $54, $48, $45, $20        ;; 01:6250 ........
    db   $47, $45, $43, $4b, $4f, $80, $43, $48        ;; 01:6258 ......??
    db   $41, $52, $47, $45, $20, $54, $4f, $20        ;; 01:6260 ????????
    db   $54, $48, $45, $20, $54, $4f, $50, $80        ;; 01:6268 ????????
    db   $46, $49, $4e, $44, $20, $54, $48, $45        ;; 01:6270 ????????
    db   $20, $49, $2e, $4f, $20, $54, $4f, $57        ;; 01:6278 ????????
    db   $45, $52, $80, $43, $48, $41, $52, $47        ;; 01:6280 ????????
    db   $45, $20, $54, $48, $45, $20, $41, $2e        ;; 01:6288 ????????
    db   $43, $2e, $54, $2e, $20, $53, $54, $45        ;; 01:6290 ????????
    db   $50, $53, $80, $a3, $62, $ad, $62, $c4        ;; 01:6298 ???..???
    db   $62, $e0, $62, $50, $4f, $4c, $54, $45        ;; 01:62a0 ???.....
    db   $52, $47, $45, $58, $80, $41, $53, $43        ;; 01:62a8 .....???
    db   $45, $4e, $44, $20, $54, $48, $45, $20        ;; 01:62b0 ????????
    db   $47, $48, $4f, $53, $54, $20, $54, $4f        ;; 01:62b8 ????????
    db   $57, $45, $52, $80, $52, $45, $41, $43        ;; 01:62c0 ????????
    db   $48, $20, $54, $48, $45, $20, $54, $4f        ;; 01:62c8 ????????
    db   $50, $20, $4f, $46, $20, $54, $48, $45        ;; 01:62d0 ????????
    db   $20, $4d, $4f, $52, $47, $55, $45, $80        ;; 01:62d8 ????????
    db   $53, $4d, $41, $53, $48, $20, $45, $49        ;; 01:62e0 ????????
    db   $47, $48, $54, $20, $42, $4c, $4f, $4f        ;; 01:62e8 ????????
    db   $44, $20, $43, $4f, $4f, $4c, $45, $52        ;; 01:62f0 ????????
    db   $53, $80, $02, $63, $03, $63, $04, $63        ;; 01:62f8 ????????
    db   $05, $63, $80, $80, $80, $80, $0e, $63        ;; 01:6300 ??????..
    db   $22, $63, $3c, $63, $58, $63, $53, $41        ;; 01:6308 ??????..
    db   $4d, $55, $52, $41, $49, $20, $4e, $49        ;; 01:6310 ........
    db   $47, $48, $54, $20, $46, $45, $56, $45        ;; 01:6318 ........
    db   $52, $80, $4e, $41, $56, $49, $47, $41        ;; 01:6320 ..??????
    db   $54, $45, $20, $54, $48, $45, $20, $50        ;; 01:6328 ????????
    db   $4f, $57, $45, $52, $20, $54, $4f, $57        ;; 01:6330 ????????
    db   $45, $52, $53, $80, $52, $49, $44, $45        ;; 01:6338 ????????
    db   $20, $54, $48, $45, $20, $46, $4c, $4f        ;; 01:6340 ????????
    db   $41, $54, $49, $4e, $47, $20, $50, $4c        ;; 01:6348 ????????
    db   $41, $54, $46, $4f, $52, $4d, $53, $80        ;; 01:6350 ????????
    db   $43, $4c, $49, $4d, $42, $20, $54, $48        ;; 01:6358 ????????
    db   $45, $20, $54, $4f, $57, $45, $52, $49        ;; 01:6360 ????????
    db   $4e, $47, $20, $54, $45, $4d, $50, $4c        ;; 01:6368 ????????
    db   $45, $80, $7a, $63, $94, $63, $b2, $63        ;; 01:6370 ??..????
    db   $b3, $63, $4e, $4f, $20, $57, $45, $44        ;; 01:6378 ??......
    db   $44, $49, $4e, $47, $53, $20, $41, $4e        ;; 01:6380 ........
    db   $44, $20, $41, $20, $46, $55, $4e, $45        ;; 01:6388 ........
    db   $52, $41, $4c, $80, $50, $45, $4e, $45        ;; 01:6390 ....????
    db   $54, $52, $41, $54, $45, $20, $52, $45        ;; 01:6398 ????????
    db   $5a, $27, $53, $20, $49, $4e, $4e, $45        ;; 01:63a0 ????????
    db   $52, $20, $53, $41, $4e, $43, $54, $55        ;; 01:63a8 ????????
    db   $4d, $80, $80, $80, $bc, $63, $bd, $63        ;; 01:63b0 ????????
    db   $be, $63, $bf, $63, $80, $80, $80, $80        ;; 01:63b8 ????????
    db   $c8, $63, $da, $63, $fb, $63, $fc, $63        ;; 01:63c0 ..??????
    db   $54, $48, $55, $52, $53, $44, $41, $59        ;; 01:63c8 ........
    db   $20, $54, $48, $45, $20, $31, $32, $54        ;; 01:63d0 ........
    db   $48, $80, $46, $49, $4e, $44, $20, $54        ;; 01:63d8 ..??????
    db   $48, $45, $20, $49, $54, $45, $4d, $53        ;; 01:63e0 ????????
    db   $20, $49, $4e, $20, $54, $48, $45, $20        ;; 01:63e8 ????????
    db   $47, $49, $56, $45, $4e, $20, $54, $49        ;; 01:63f0 ????????
    db   $4d, $45, $80, $80, $80, $05, $64, $06        ;; 01:63f8 ????????
    db   $64, $07, $64, $08, $64, $80, $80, $80        ;; 01:6400 ????????
    db   $80, $11, $64, $12, $64, $13, $64, $14        ;; 01:6408 ????????
    db   $64, $80, $80, $80, $80, $1d, $64, $1e        ;; 01:6410 ????????
    db   $64, $1f, $64, $20, $64, $80, $80, $80        ;; 01:6418 ????????
    db   $80, $29, $64, $2a, $64, $2b, $64, $2c        ;; 01:6420 ????????
    db   $64, $80, $80, $80, $80, $35, $64, $4c        ;; 01:6428 ?????..?
    db   $64, $6d, $64, $6e, $64, $4c, $49, $5a        ;; 01:6430 ?????...
    db   $41, $52, $44, $20, $49, $4e, $20, $41        ;; 01:6438 ........
    db   $20, $43, $48, $49, $4e, $41, $20, $53        ;; 01:6440 ........
    db   $48, $4f, $50, $80, $46, $49, $4e, $44        ;; 01:6448 ....????
    db   $20, $54, $48, $45, $20, $49, $54, $45        ;; 01:6450 ????????
    db   $4d, $53, $20, $49, $4e, $20, $54, $48        ;; 01:6458 ????????
    db   $45, $20, $47, $49, $56, $45, $4e, $20        ;; 01:6460 ????????
    db   $54, $49, $4d, $45, $80, $80, $80, $77        ;; 01:6468 ???????.
    db   $64, $82, $64, $a3, $64, $a4, $64, $42        ;; 01:6470 .??????.
    db   $55, $47, $47, $45, $44, $20, $4f, $55        ;; 01:6478 ........
    db   $54, $80, $46, $49, $4e, $44, $20, $54        ;; 01:6480 ..??????
    db   $48, $45, $20, $49, $54, $45, $4d, $53        ;; 01:6488 ????????
    db   $20, $49, $4e, $20, $54, $48, $45, $20        ;; 01:6490 ????????
    db   $47, $49, $56, $45, $4e, $20, $54, $49        ;; 01:6498 ????????
    db   $4d, $45, $80, $80, $80, $ad, $64, $bc        ;; 01:64a0 ?????..?
    db   $64, $dd, $64, $de, $64, $43, $48, $49        ;; 01:64a8 ?????...
    db   $50, $53, $20, $41, $4e, $44, $20, $44        ;; 01:64b0 ........
    db   $49, $50, $53, $80, $46, $49, $4e, $44        ;; 01:64b8 ....????
    db   $20, $54, $48, $45, $20, $49, $54, $45        ;; 01:64c0 ????????
    db   $4d, $53, $20, $49, $4e, $20, $54, $48        ;; 01:64c8 ????????
    db   $45, $20, $47, $49, $56, $45, $4e, $20        ;; 01:64d0 ????????
    db   $54, $49, $4d, $45, $80, $80, $80, $e7        ;; 01:64d8 ???????.
    db   $64, $f5, $64, $10, $65, $11, $65, $4c        ;; 01:64e0 .??????.
    db   $41, $56, $41, $20, $44, $41, $42, $41        ;; 01:64e8 ........
    db   $20, $44, $4f, $4f, $80, $4e, $41, $56        ;; 01:64f0 .....???
    db   $49, $47, $41, $54, $45, $20, $54, $48        ;; 01:64f8 ????????
    db   $45, $20, $52, $49, $56, $45, $52, $20        ;; 01:6500 ????????
    db   $4f, $46, $20, $46, $49, $52, $45, $80        ;; 01:6508 ????????
    db   $80, $80, $1a, $65, $32, $65, $4e, $65        ;; 01:6510 ??..????
    db   $4f, $65, $54, $45, $58, $41, $53, $20        ;; 01:6518 ??......
    db   $43, $48, $41, $49, $4e, $53, $41, $57        ;; 01:6520 ........
    db   $20, $4d, $41, $4e, $49, $43, $55, $52        ;; 01:6528 ........
    db   $45, $80, $52, $49, $44, $45, $20, $54        ;; 01:6530 ..??????
    db   $48, $45, $20, $46, $4c, $4f, $41, $54        ;; 01:6538 ????????
    db   $49, $4e, $47, $20, $46, $55, $52, $4e        ;; 01:6540 ????????
    db   $49, $54, $55, $52, $45, $80, $80, $80        ;; 01:6548 ????????
    db   $58, $65, $6b, $65, $80, $65, $a6, $65        ;; 01:6550 ..??????
    db   $4d, $41, $5a, $45, $44, $20, $41, $4e        ;; 01:6558 ........
    db   $44, $20, $43, $4f, $4e, $46, $55, $53        ;; 01:6560 ........
    db   $45, $44, $80, $50, $41, $53, $53, $20        ;; 01:6568 ...?????
    db   $54, $48, $45, $20, $54, $2e, $56, $2e        ;; 01:6570 ????????
    db   $20, $46, $4f, $52, $45, $53, $54, $80        ;; 01:6578 ????????
    db   $43, $52, $4f, $53, $53, $20, $54, $48        ;; 01:6580 ????????
    db   $45, $20, $42, $4c, $55, $45, $20, $42        ;; 01:6588 ????????
    db   $45, $41, $4d, $53, $20, $54, $4f, $20        ;; 01:6590 ????????
    db   $54, $48, $45, $20, $52, $45, $5a, $20        ;; 01:6598 ????????
    db   $54, $4f, $57, $45, $52, $80, $80, $af        ;; 01:65a0 ????????
    db   $65, $b0, $65, $b1, $65, $b2, $65, $80        ;; 01:65a8 ????????
    db   $80, $80, $80, $bb, $65, $bc, $65, $bd        ;; 01:65b0 ????????
    db   $65, $be, $65, $80, $80, $80, $80, $c7        ;; 01:65b8 ????????
    db   $65, $c8, $65, $c9, $65, $ca, $65, $80        ;; 01:65c0 ????????
    db   $80, $80, $80, $d3, $65, $dd, $65, $fc        ;; 01:65c8 ????????
    db   $65, $fd, $65, $43, $48, $41, $4e, $4e        ;; 01:65d0 ????????
    db   $45, $4c, $20, $5a, $80, $44, $45, $46        ;; 01:65d8 ????????
    db   $45, $41, $54, $20, $52, $45, $5a, $20        ;; 01:65e0 ????????
    db   $49, $4e, $20, $54, $48, $45, $20, $46        ;; 01:65e8 ????????
    db   $49, $4e, $41, $4c, $20, $42, $41, $54        ;; 01:65f0 ????????
    db   $54, $4c, $45, $80, $80, $80                  ;; 01:65f8 ??????

data_01_65fe:
    dw   data_01_66a7                                  ;; 01:65fe pP
    dw   $661e                                         ;; 01:6600 wW
    db   $01, $06, $00, $00                            ;; 01:6602 ..??
    dw   data_01_689f                                  ;; 01:6606 pP
    dw   $6648                                         ;; 01:6608 wW
    db   $01, $07, $00, $00                            ;; 01:660a ..??
    dw   data_01_6add                                  ;; 01:660e pP
    dw   $6672                                         ;; 01:6610 wW
    db   $02, $0b, $00, $00, $e9, $71, $9c, $66        ;; 01:6612 ..??????
    db   $02, $10, $00, $00, $03, $03, $03, $03        ;; 01:661a ????..ww
    db   $03, $03, $03, $03, $03, $03, $03, $03        ;; 01:6622 ..www.w.
    db   $03, $05, $03, $03, $03, $03, $03, $03        ;; 01:662a wwwww?ww
    db   $03, $03, $03, $05, $03, $03, $03, $03        ;; 01:6632 w..ww..w
    db   $03, $03, $03, $03, $03, $03, $03, $03        ;; 01:663a ..?ww???
    db   $03, $01, $02, $01, $03, $02, $04, $06        ;; 01:6642 ..????..
    db   $05, $06, $06, $05, $06, $05, $06, $02        ;; 01:664a ??.w??..
    db   $06, $06, $05, $06, $06, $06, $06, $06        ;; 01:6652 ?...ww.w
    db   $06, $05, $05, $06, $07, $06, $07, $06        ;; 01:665a www.?...
    db   $07, $06, $05, $05, $05, $05, $06, $05        ;; 01:6662 ????????
    db   $05, $05, $05, $02, $02, $03, $04, $02        ;; 01:666a ?????.??
    db   $05, $0a, $0a, $0a, $0b, $09, $08, $09        ;; 01:6672 ..?..w?.
    db   $09, $04, $0b, $0a, $09, $0b, $0a, $0a        ;; 01:667a ?.???...
    db   $09, $0b, $0a, $09, $09, $0a, $0b, $0b        ;; 01:6682 ww.ww..?
    db   $0b, $0b, $0b, $0a, $07, $09, $08, $09        ;; 01:668a .???????
    db   $09, $09, $09, $09, $09, $04, $04, $05        ;; 01:6692 ?????.??
    db   $06, $04, $10, $10, $10, $10, $10, $10        ;; 01:669a ????????
    db   $10, $10, $10, $10, $10                       ;; 01:66a2 ?????

data_01_66a7:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:66a7 ........
    db   $00, $00, $00, $00, $e0, $40, $a0, $a0        ;; 01:66af ........
    db   $a0, $a0, $e0, $e0, $a0, $a0, $a0, $a0        ;; 01:66b7 ........
    db   $e0, $c0, $a0, $a0, $e0, $c0, $a0, $a0        ;; 01:66bf ........
    db   $a0, $a0, $e0, $c0, $e0, $60, $80, $80        ;; 01:66c7 ........
    db   $80, $80, $80, $80, $80, $80, $e0, $60        ;; 01:66cf ........
    db   $e0, $c0, $a0, $a0, $a0, $a0, $a0, $a0        ;; 01:66d7 ........
    db   $a0, $a0, $e0, $c0, $e0, $e0, $80, $80        ;; 01:66df ........
    db   $e0, $e0, $80, $80, $80, $80, $e0, $e0        ;; 01:66e7 ........
    db   $e0, $e0, $80, $80, $e0, $e0, $80, $80        ;; 01:66ef ........
    db   $80, $80, $80, $80, $e0, $40, $a0, $a0        ;; 01:66f7 ........
    db   $80, $80, $a0, $a0, $a0, $a0, $e0, $60        ;; 01:66ff ........
    db   $a0, $a0, $a0, $a0, $e0, $e0, $a0, $a0        ;; 01:6707 ........
    db   $a0, $a0, $a0, $a0, $e0, $e0, $40, $40        ;; 01:670f ........
    db   $40, $40, $40, $40, $40, $40, $e0, $e0        ;; 01:6717 ........
    db   $e0, $e0, $20, $20, $20, $20, $20, $20        ;; 01:671f ........
    db   $a0, $a0, $e0, $40, $a0, $a0, $a0, $a0        ;; 01:6727 ........
    db   $c0, $c0, $c0, $c0, $a0, $a0, $a0, $a0        ;; 01:672f ........
    db   $80, $80, $80, $80, $80, $80, $80, $80        ;; 01:6737 ........
    db   $80, $80, $e0, $e0, $88, $88, $d8, $d8        ;; 01:673f ........
    db   $f8, $a8, $a8, $88, $88, $88, $88, $88        ;; 01:6747 ........
    db   $e0, $c0, $a0, $a0, $a0, $a0, $a0, $a0        ;; 01:674f ........
    db   $a0, $a0, $a0, $a0, $e0, $40, $a0, $a0        ;; 01:6757 ........
    db   $a0, $a0, $a0, $a0, $a0, $a0, $e0, $40        ;; 01:675f ........
    db   $e0, $c0, $a0, $a0, $a0, $a0, $e0, $c0        ;; 01:6767 ........
    db   $80, $80, $80, $80, $e0, $40, $a0, $a0        ;; 01:676f ....????
    db   $a0, $a0, $a0, $a0, $e0, $c0, $e0, $20        ;; 01:6777 ????????
    db   $e0, $c0, $a0, $a0, $a0, $a0, $e0, $c0        ;; 01:677f ........
    db   $e0, $a0, $a0, $a0, $e0, $60, $80, $80        ;; 01:6787 ........
    db   $e0, $40, $20, $20, $20, $20, $e0, $c0        ;; 01:678f ........
    db   $e0, $e0, $40, $40, $40, $40, $40, $40        ;; 01:6797 ........
    db   $40, $40, $40, $40, $a0, $a0, $a0, $a0        ;; 01:679f ........
    db   $a0, $a0, $a0, $a0, $e0, $a0, $e0, $60        ;; 01:67a7 ........
    db   $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0        ;; 01:67af ........
    db   $a0, $a0, $e0, $40, $88, $88, $88, $88        ;; 01:67b7 ........
    db   $a8, $88, $f8, $a8, $d8, $d8, $88, $88        ;; 01:67bf ........
    db   $a0, $a0, $e0, $a0, $40, $40, $40, $40        ;; 01:67c7 ........
    db   $e0, $a0, $a0, $a0, $a0, $a0, $a0, $a0        ;; 01:67cf ........
    db   $e0, $40, $40, $40, $40, $40, $40, $40        ;; 01:67d7 ........
    db   $e0, $e0, $60, $20, $60, $40, $c0, $40        ;; 01:67df ........
    db   $c0, $80, $e0, $e0, $e0, $40, $a0, $a0        ;; 01:67e7 ........
    db   $a0, $a0, $a0, $a0, $a0, $a0, $e0, $40        ;; 01:67ef ........
    db   $c0, $40, $c0, $c0, $40, $40, $40, $40        ;; 01:67f7 ........
    db   $40, $40, $e0, $e0, $e0, $c0, $20, $20        ;; 01:67ff ........
    db   $20, $20, $c0, $40, $c0, $80, $e0, $e0        ;; 01:6807 ........
    db   $e0, $c0, $20, $20, $60, $40, $20, $20        ;; 01:680f ????????
    db   $20, $20, $e0, $c0, $60, $20, $e0, $60        ;; 01:6817 ????....
    db   $a0, $a0, $e0, $e0, $20, $20, $20, $20        ;; 01:681f ........
    db   $e0, $e0, $80, $80, $e0, $c0, $20, $20        ;; 01:6827 ........
    db   $20, $20, $e0, $c0, $e0, $60, $80, $80        ;; 01:682f ....????
    db   $e0, $c0, $a0, $a0, $a0, $a0, $e0, $40        ;; 01:6837 ????????
    db   $e0, $e0, $20, $20, $60, $20, $60, $40        ;; 01:683f ????????
    db   $40, $40, $40, $40, $e0, $40, $a0, $a0        ;; 01:6847 ????????
    db   $e0, $40, $a0, $a0, $a0, $a0, $e0, $40        ;; 01:684f ????????
    db   $e0, $40, $a0, $a0, $a0, $a0, $e0, $60        ;; 01:6857 ........
    db   $20, $20, $e0, $c0, $00, $00, $00, $00        ;; 01:685f ........
    db   $00, $00, $00, $00, $00, $00, $80, $80        ;; 01:6867 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:686f ????????
    db   $c0, $40, $80, $80, $80, $80, $80, $80        ;; 01:6877 ????????
    db   $80, $80, $80, $80, $00, $00, $80, $80        ;; 01:687f ????????
    db   $00, $00, $00, $00, $00, $00, $e0, $e0        ;; 01:6887 ????????
    db   $00, $00, $00, $00, $c0, $40, $80, $80        ;; 01:688f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6897 ????????

data_01_689f:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:689f ........
    db   $00, $00, $00, $00, $00, $00, $70, $20        ;; 01:68a7 ........
    db   $70, $70, $f0, $50, $d8, $58, $f8, $f8        ;; 01:68af ........
    db   $fc, $d8, $dc, $98, $f0, $e0, $f8, $f0        ;; 01:68b7 ....????
    db   $98, $90, $f0, $f0, $d8, $98, $f8, $f8        ;; 01:68bf ????????
    db   $f8, $f0, $7c, $38, $7c, $7c, $e4, $c0        ;; 01:68c7 ????????
    db   $c0, $c0, $e0, $c0, $fc, $6c, $7c, $38        ;; 01:68cf ????????
    db   $f8, $f0, $f8, $f8, $8c, $88, $cc, $8c        ;; 01:68d7 ........
    db   $cc, $8c, $fc, $c8, $f8, $f8, $f8, $78        ;; 01:68df ........
    db   $f8, $78, $c0, $40, $f8, $f0, $e0, $c0        ;; 01:68e7 ........
    db   $f8, $f0, $f8, $f8, $7c, $78, $fc, $7c        ;; 01:68ef ....????
    db   $e0, $60, $f8, $78, $e0, $e0, $e0, $c0        ;; 01:68f7 ????????
    db   $e0, $c0, $f8, $70, $f8, $f0, $e0, $c0        ;; 01:68ff ????????
    db   $d8, $98, $d8, $88, $f8, $d8, $f8, $68        ;; 01:6907 ????????
    db   $ec, $4c, $ec, $4c, $ec, $cc, $fc, $fc        ;; 01:690f ........
    db   $fc, $cc, $cc, $c8, $cc, $c8, $c0, $40        ;; 01:6917 ........
    db   $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0        ;; 01:691f ........
    db   $c0, $c0, $c0, $c0, $1c, $1c, $1c, $1c        ;; 01:6927 ....????
    db   $1c, $0c, $1c, $0c, $dc, $58, $f8, $f8        ;; 01:692f ????????
    db   $70, $20, $cc, $4c, $dc, $cc, $f8, $f8        ;; 01:6937 ??......
    db   $f0, $f0, $f8, $d8, $dc, $cc, $cc, $cc        ;; 01:693f ........
    db   $e0, $60, $e0, $e0, $e0, $e0, $e0, $c0        ;; 01:6947 ........
    db   $e0, $c0, $f8, $f8, $f8, $f8, $cc, $cc        ;; 01:694f ........
    db   $fc, $fc, $fc, $b4, $cc, $cc, $cc, $cc        ;; 01:6957 ........
    db   $cc, $cc, $cc, $cc, $cc, $cc, $ec, $cc        ;; 01:695f ........
    db   $ec, $ec, $fc, $fc, $fc, $dc, $dc, $cc        ;; 01:6967 ........
    db   $cc, $c4, $78, $30, $f8, $78, $fc, $cc        ;; 01:696f ........
    db   $cc, $8c, $cc, $8c, $fc, $78, $78, $30        ;; 01:6977 ........
    db   $f8, $70, $fc, $f8, $cc, $cc, $fc, $f8        ;; 01:697f ........
    db   $f8, $f0, $c0, $c0, $c0, $c0, $f8, $70        ;; 01:6987 ........
    db   $f8, $f8, $dc, $88, $8c, $88, $bc, $a8        ;; 01:698f ........
    db   $f8, $d0, $f8, $68, $f8, $f0, $fc, $f8        ;; 01:6997 ........
    db   $cc, $cc, $f8, $f8, $f8, $f0, $fc, $d8        ;; 01:699f ........
    db   $dc, $cc, $f8, $70, $f8, $f8, $c0, $c0        ;; 01:69a7 ........
    db   $f8, $70, $38, $18, $f8, $f0, $f0, $e0        ;; 01:69af ........
    db   $f8, $f8, $f8, $f8, $70, $20, $60, $20        ;; 01:69b7 ........
    db   $60, $60, $e0, $60, $e0, $60, $ec, $6c        ;; 01:69bf ........
    db   $ec, $ec, $cc, $cc, $cc, $cc, $ec, $cc        ;; 01:69c7 ........
    db   $fc, $7c, $3c, $18, $e6, $c6, $e6, $c6        ;; 01:69cf ....????
    db   $ee, $66, $ee, $6c, $7c, $6c, $3c, $38        ;; 01:69d7 ????????
    db   $38, $10, $cc, $cc, $cc, $cc, $fc, $d4        ;; 01:69df ??......
    db   $fc, $fc, $fc, $ec, $fc, $cc, $cc, $c4        ;; 01:69e7 ........
    db   $e6, $c6, $f6, $66, $7c, $3c, $3c, $18        ;; 01:69ef ........
    db   $3c, $3c, $ee, $66, $e6, $c6, $cc, $cc        ;; 01:69f7 ........
    db   $cc, $cc, $fc, $68, $78, $38, $38, $30        ;; 01:69ff ........
    db   $70, $30, $70, $60, $fe, $fe, $fe, $fc        ;; 01:6a07 ....????
    db   $38, $18, $38, $30, $70, $70, $fc, $64        ;; 01:6a0f ????????
    db   $fe, $fc, $38, $10, $7c, $78, $ec, $64        ;; 01:6a17 ????????
    db   $c4, $c4, $ec, $c4, $fc, $78, $78, $30        ;; 01:6a1f ????????
    db   $60, $20, $e0, $e0, $20, $20, $20, $20        ;; 01:6a27 ????????
    db   $20, $20, $f8, $60, $f8, $f8, $f8, $70        ;; 01:6a2f ????????
    db   $f8, $f8, $b8, $30, $70, $60, $c0, $c0        ;; 01:6a37 ????????
    db   $f8, $d8, $f8, $f8, $f8, $f0, $f8, $f8        ;; 01:6a3f ????????
    db   $38, $10, $78, $30, $18, $18, $f8, $38        ;; 01:6a47 ????????
    db   $f0, $e0, $90, $90, $d8, $90, $d8, $98        ;; 01:6a4f ????????
    db   $f8, $f8, $78, $18, $18, $18, $18, $18        ;; 01:6a57 ????????
    db   $f8, $f8, $f8, $f8, $c0, $c0, $fc, $70        ;; 01:6a5f ????????
    db   $7c, $1c, $9c, $18, $f8, $f0, $30, $20        ;; 01:6a67 ????????
    db   $78, $70, $e0, $c0, $f0, $e0, $f0, $90        ;; 01:6a6f ????????
    db   $b8, $90, $f0, $60, $f8, $f8, $f8, $f8        ;; 01:6a77 ????????
    db   $b8, $18, $38, $10, $38, $30, $30, $30        ;; 01:6a7f ????????
    db   $70, $30, $70, $20, $f8, $78, $d8, $d8        ;; 01:6a87 ????????
    db   $f8, $70, $f8, $f8, $d8, $d8, $f8, $70        ;; 01:6a8f ????????
    db   $f0, $60, $f8, $f0, $d8, $d8, $f8, $78        ;; 01:6a97 ????????
    db   $18, $18, $38, $10, $f0, $60, $00, $00        ;; 01:6a9f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6aa7 ????????
    db   $c0, $00, $c0, $c0, $00, $00, $00, $00        ;; 01:6aaf ????????
    db   $00, $00, $00, $00, $00, $00, $c0, $40        ;; 01:6ab7 ????????
    db   $80, $80, $60, $40, $e0, $60, $e0, $e0        ;; 01:6abf ??......
    db   $e0, $40, $40, $40, $40, $00, $40, $40        ;; 01:6ac7 ........
    db   $00, $00, $00, $00, $00, $00, $f0, $f0        ;; 01:6acf ????????
    db   $f0, $f0, $00, $00, $00, $00                  ;; 01:6ad7 ??????

data_01_6add:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6add ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6ae5 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6aed ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6af5 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6afd ........
    db   $00, $00, $00, $00, $0e, $0e, $1f, $0e        ;; 01:6b05 ........
    db   $1f, $1e, $3f, $1b, $3b, $33, $7f, $33        ;; 01:6b0d ........
    db   $7f, $7f, $7f, $7f, $f3, $73, $f3, $e1        ;; 01:6b15 ........
    db   $e1, $e1, $00, $00, $00, $00, $00, $00        ;; 01:6b1d ........
    db   $00, $00, $80, $00, $80, $80, $80, $80        ;; 01:6b25 ........
    db   $80, $80, $c0, $80, $c0, $c0, $c0, $c0        ;; 01:6b2d ........
    db   $7e, $7c, $7f, $7f, $77, $33, $73, $33        ;; 01:6b35 ????????
    db   $7f, $3f, $7f, $3f, $7f, $73, $73, $71        ;; 01:6b3d ????????
    db   $f3, $71, $ff, $7f, $ff, $7f, $00, $00        ;; 01:6b45 ????????
    db   $80, $00, $80, $80, $80, $80, $80, $00        ;; 01:6b4d ????????
    db   $80, $00, $c0, $80, $c0, $c0, $c0, $c0        ;; 01:6b55 ????????
    db   $c0, $80, $80, $00, $3f, $3f, $7f, $3f        ;; 01:6b5d ????....
    db   $7f, $79, $70, $70, $f0, $60, $f0, $70        ;; 01:6b65 ........
    db   $f0, $70, $78, $70, $7f, $39, $3f, $3f        ;; 01:6b6d ........
    db   $1f, $0f, $e0, $00, $e0, $c0, $c0, $80        ;; 01:6b75 ........
    db   $80, $00, $00, $00, $00, $00, $00, $00        ;; 01:6b7d ........
    db   $60, $00, $c0, $c0, $c0, $80, $00, $00        ;; 01:6b85 ........
    db   $ff, $7f, $ff, $ff, $f7, $61, $61, $61        ;; 01:6b8d ........
    db   $71, $60, $70, $60, $70, $60, $70, $60        ;; 01:6b95 ........
    db   $7f, $79, $7f, $7f, $7f, $7f, $00, $00        ;; 01:6b9d ........
    db   $c0, $80, $e0, $c0, $e0, $c0, $e0, $e0        ;; 01:6ba5 ........
    db   $e0, $e0, $e0, $e0, $e0, $e0, $e0, $c0        ;; 01:6bad ........
    db   $c0, $c0, $c0, $80, $ff, $7f, $ff, $7f        ;; 01:6bb5 ........
    db   $ff, $73, $f0, $70, $f8, $70, $ff, $7e        ;; 01:6bbd ........
    db   $fe, $fe, $f8, $f0, $f3, $f0, $ff, $ff        ;; 01:6bc5 ........
    db   $ff, $ff, $00, $00, $80, $00, $80, $00        ;; 01:6bcd ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6bd5 ........
    db   $00, $00, $00, $00, $80, $00, $80, $80        ;; 01:6bdd ........
    db   $7f, $7f, $ff, $7f, $f8, $70, $f2, $70        ;; 01:6be5 ????????
    db   $ff, $7e, $ff, $7e, $f8, $f0, $f0, $f0        ;; 01:6bed ????????
    db   $f0, $e0, $f0, $e0, $f0, $e0, $00, $00        ;; 01:6bf5 ????????
    db   $80, $00, $00, $00, $00, $00, $00, $00        ;; 01:6bfd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6c05 ????????
    db   $00, $00, $00, $00, $7f, $1f, $7f, $7f        ;; 01:6c0d ????....
    db   $fe, $78, $f8, $70, $f3, $e3, $f7, $63        ;; 01:6c15 ........
    db   $f3, $61, $f1, $71, $7f, $73, $7f, $7f        ;; 01:6c1d ........
    db   $7f, $3d, $80, $00, $80, $00, $00, $00        ;; 01:6c25 ........
    db   $00, $00, $80, $00, $80, $80, $80, $80        ;; 01:6c2d ........
    db   $80, $80, $80, $80, $80, $80, $80, $80        ;; 01:6c35 ........
    db   $e7, $e3, $e7, $e7, $e7, $e3, $ff, $ff        ;; 01:6c3d ????????
    db   $ff, $ff, $ff, $ff, $e7, $c3, $e7, $c7        ;; 01:6c45 ????????
    db   $e7, $e7, $e7, $e7, $e7, $e7, $00, $00        ;; 01:6c4d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6c55 ????????
    db   $00, $00, $80, $00, $80, $00, $80, $00        ;; 01:6c5d ????????
    db   $80, $00, $80, $80, $f0, $70, $f0, $f0        ;; 01:6c65 ????....
    db   $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0        ;; 01:6c6d ........
    db   $f0, $f0, $f0, $f0, $f8, $f0, $f8, $f0        ;; 01:6c75 ........
    db   $f8, $f0, $00, $00, $00, $00, $00, $00        ;; 01:6c7d ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6c85 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6c8d ........
    db   $03, $01, $01, $01, $01, $00, $01, $00        ;; 01:6c95 ????????
    db   $01, $00, $01, $00, $73, $11, $fb, $71        ;; 01:6c9d ????????
    db   $7f, $3f, $3f, $3f, $1e, $0c, $e0, $e0        ;; 01:6ca5 ????????
    db   $e0, $e0, $e0, $e0, $e0, $e0, $e0, $e0        ;; 01:6cad ????????
    db   $e0, $e0, $e0, $c0, $c0, $c0, $c0, $80        ;; 01:6cb5 ????????
    db   $00, $00, $00, $00, $f1, $f1, $f3, $71        ;; 01:6cbd ????????
    db   $f7, $73, $ff, $6f, $ff, $7e, $ff, $7f        ;; 01:6cc5 ????????
    db   $ff, $73, $e3, $63, $f3, $63, $f3, $71        ;; 01:6ccd ????????
    db   $f1, $f1, $c0, $c0, $c0, $c0, $80, $80        ;; 01:6cd5 ????????
    db   $80, $00, $00, $00, $80, $00, $80, $00        ;; 01:6cdd ????????
    db   $c0, $80, $c0, $80, $c0, $c0, $c0, $c0        ;; 01:6ce5 ????????
    db   $7c, $18, $fc, $f8, $f8, $f8, $f8, $f8        ;; 01:6ced ????????
    db   $f8, $f0, $f8, $f0, $f8, $f0, $f8, $f0        ;; 01:6cf5 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $00, $00        ;; 01:6cfd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6d05 ????????
    db   $00, $00, $00, $00, $00, $00, $80, $80        ;; 01:6d0d ????????
    db   $80, $80, $80, $80, $e1, $e1, $f3, $e1        ;; 01:6d15 ????....
    db   $f3, $f1, $ff, $f3, $ff, $ff, $ff, $ff        ;; 01:6d1d ........
    db   $ff, $fc, $fd, $e8, $e9, $e0, $e1, $e0        ;; 01:6d25 ........
    db   $e0, $e0, $c0, $80, $c0, $80, $c0, $80        ;; 01:6d2d ........
    db   $c0, $c0, $c0, $c0, $e0, $c0, $e0, $c0        ;; 01:6d35 ........
    db   $e0, $c0, $e0, $e0, $e0, $e0, $e0, $e0        ;; 01:6d3d ........
    db   $e3, $e3, $e3, $e3, $f3, $e3, $fb, $f3        ;; 01:6d45 ........
    db   $ff, $ff, $ff, $ff, $ff, $e7, $e7, $e3        ;; 01:6d4d ........
    db   $e1, $e1, $e1, $e1, $e1, $e0, $80, $80        ;; 01:6d55 ........
    db   $80, $80, $c0, $80, $c0, $80, $c0, $80        ;; 01:6d5d ........
    db   $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0        ;; 01:6d65 ........
    db   $c0, $c0, $c0, $c0, $3f, $1e, $7f, $3f        ;; 01:6d6d ........
    db   $ff, $7f, $ff, $e3, $e3, $e1, $e1, $c1        ;; 01:6d75 ........
    db   $c3, $c1, $f7, $e3, $7f, $7f, $7f, $3f        ;; 01:6d7d ........
    db   $1e, $00, $00, $00, $00, $00, $80, $00        ;; 01:6d85 ........
    db   $80, $80, $c0, $80, $c0, $80, $c0, $80        ;; 01:6d8d ........
    db   $c0, $80, $80, $80, $80, $00, $00, $00        ;; 01:6d95 ........
    db   $ff, $7c, $ff, $ff, $fb, $e3, $f3, $e1        ;; 01:6d9d ........
    db   $ff, $e3, $ff, $ff, $ff, $fc, $f0, $f0        ;; 01:6da5 ........
    db   $f8, $f0, $f8, $f8, $f8, $f8, $00, $00        ;; 01:6dad ........
    db   $80, $00, $c0, $80, $c0, $80, $80, $80        ;; 01:6db5 ........
    db   $80, $00, $00, $00, $00, $00, $00, $00        ;; 01:6dbd ........
    db   $00, $00, $00, $00, $3f, $1f, $7f, $3f        ;; 01:6dc5 ........
    db   $7b, $71, $f1, $60, $f1, $60, $f0, $60        ;; 01:6dcd ........
    db   $70, $60, $73, $72, $7f, $33, $3f, $3d        ;; 01:6dd5 ........
    db   $1d, $0c, $00, $00, $c0, $80, $c0, $c0        ;; 01:6ddd ........
    db   $e0, $c0, $e0, $c0, $e0, $c0, $e0, $c0        ;; 01:6de5 ........
    db   $c0, $c0, $c0, $80, $c0, $80, $c0, $c0        ;; 01:6ded ........
    db   $ff, $ff, $ff, $ff, $fd, $e1, $f1, $e1        ;; 01:6df5 ........
    db   $ff, $fb, $ff, $ff, $ff, $ee, $ef, $e6        ;; 01:6dfd ........
    db   $e7, $e7, $e7, $e3, $e3, $e1, $80, $00        ;; 01:6e05 ........
    db   $c0, $80, $c0, $c0, $c0, $c0, $c0, $c0        ;; 01:6e0d ........
    db   $80, $80, $00, $00, $00, $00, $80, $00        ;; 01:6e15 ........
    db   $c0, $80, $c0, $80, $3f, $1e, $7f, $7f        ;; 01:6e1d ........
    db   $ff, $73, $f8, $f0, $ff, $fe, $ff, $7f        ;; 01:6e25 ........
    db   $1f, $07, $03, $03, $ff, $f3, $ff, $ff        ;; 01:6e2d ........
    db   $ff, $7e, $00, $00, $80, $00, $80, $00        ;; 01:6e35 ........
    db   $00, $00, $00, $00, $80, $00, $80, $80        ;; 01:6e3d ........
    db   $80, $80, $80, $00, $00, $00, $00, $00        ;; 01:6e45 ........
    db   $ff, $ff, $ff, $ff, $ff, $7f, $3e, $1c        ;; 01:6e4d ........
    db   $1c, $1c, $3c, $1c, $3c, $38, $78, $38        ;; 01:6e55 ........
    db   $7c, $78, $7c, $78, $7c, $78, $80, $80        ;; 01:6e5d ........
    db   $80, $80, $80, $80, $00, $00, $00, $00        ;; 01:6e65 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6e6d ........
    db   $00, $00, $00, $00, $f1, $71, $f1, $f1        ;; 01:6e75 ........
    db   $f1, $e1, $e1, $e1, $e1, $e1, $e1, $e1        ;; 01:6e7d ........
    db   $e1, $e1, $f9, $f1, $7f, $7f, $3f, $3f        ;; 01:6e85 ........
    db   $1f, $0f, $c0, $c0, $c0, $c0, $c0, $c0        ;; 01:6e8d ........
    db   $c0, $c0, $c0, $c0, $c0, $c0, $e0, $c0        ;; 01:6e95 ........
    db   $e0, $c0, $c0, $c0, $c0, $80, $80, $80        ;; 01:6e9d ........
    db   $f0, $f0, $f9, $71, $f9, $71, $f9, $71        ;; 01:6ea5 ........
    db   $f9, $71, $fb, $71, $7b, $73, $7f, $33        ;; 01:6ead ........
    db   $3f, $3f, $3f, $1e, $1e, $0c, $e0, $20        ;; 01:6eb5 ........
    db   $e0, $e0, $e0, $e0, $e0, $e0, $e0, $c0        ;; 01:6ebd ........
    db   $c0, $c0, $c0, $80, $80, $80, $00, $00        ;; 01:6ec5 ........
    db   $00, $00, $00, $00, $e0, $e0, $e1, $e0        ;; 01:6ecd ....????
    db   $e9, $e0, $fd, $e8, $ff, $fc, $ff, $ff        ;; 01:6ed5 ????????
    db   $ff, $ff, $ff, $f3, $f3, $f1, $f3, $e1        ;; 01:6edd ????????
    db   $e1, $e1, $e0, $e0, $e0, $e0, $e0, $e0        ;; 01:6ee5 ????????
    db   $e0, $c0, $e0, $c0, $e0, $c0, $c0, $c0        ;; 01:6eed ????????
    db   $c0, $c0, $c0, $80, $c0, $80, $c0, $80        ;; 01:6ef5 ????????
    db   $e0, $e0, $f1, $f0, $f9, $71, $3f, $3b        ;; 01:6efd ........
    db   $1f, $1f, $1f, $0f, $3f, $1f, $7f, $39        ;; 01:6f05 ........
    db   $f1, $f1, $e1, $e0, $e1, $c0, $e0, $e0        ;; 01:6f0d ........
    db   $e0, $e0, $e0, $c0, $c0, $80, $80, $00        ;; 01:6f15 ........
    db   $80, $00, $c0, $80, $c0, $c0, $e0, $e0        ;; 01:6f1d ........
    db   $e0, $e0, $e0, $e0, $e1, $c1, $f3, $e1        ;; 01:6f25 ....????
    db   $fb, $f3, $7f, $3b, $1f, $1f, $1f, $1f        ;; 01:6f2d ????????
    db   $0f, $0e, $0e, $0e, $1e, $1c, $3c, $1c        ;; 01:6f35 ????????
    db   $3c, $38, $e0, $e0, $e0, $e0, $e0, $c0        ;; 01:6f3d ????????
    db   $c0, $80, $80, $00, $00, $00, $00, $00        ;; 01:6f45 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6f4d ????????
    db   $ff, $0f, $ff, $7f, $7f, $3b, $07, $07        ;; 01:6f55 ????????
    db   $1f, $0e, $1e, $1c, $3c, $38, $78, $78        ;; 01:6f5d ????????
    db   $ff, $f9, $ff, $ff, $ff, $ff, $e0, $e0        ;; 01:6f65 ????????
    db   $e0, $c0, $c0, $80, $00, $00, $00, $00        ;; 01:6f6d ????????
    db   $00, $00, $00, $00, $00, $00, $c0, $80        ;; 01:6f75 ????????
    db   $c0, $c0, $e0, $c0, $1e, $00, $7f, $3f        ;; 01:6f7d ????????
    db   $7f, $7f, $fb, $71, $f0, $60, $e1, $60        ;; 01:6f85 ????????
    db   $f1, $61, $7f, $71, $7f, $3f, $3f, $3f        ;; 01:6f8d ????????
    db   $3f, $1e, $00, $00, $80, $00, $80, $80        ;; 01:6f95 ????????
    db   $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0        ;; 01:6f9d ????????
    db   $c0, $c0, $c0, $80, $80, $00, $00, $00        ;; 01:6fa5 ????????
    db   $78, $38, $f8, $f8, $78, $38, $38, $38        ;; 01:6fad ????????
    db   $38, $38, $38, $38, $38, $38, $38, $38        ;; 01:6fb5 ????????
    db   $fe, $78, $fe, $fe, $fe, $fe, $00, $00        ;; 01:6fbd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6fc5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:6fcd ????????
    db   $00, $00, $00, $00, $ff, $7f, $ff, $ff        ;; 01:6fd5 ????????
    db   $f7, $c3, $87, $07, $1f, $0e, $3e, $3c        ;; 01:6fdd ????????
    db   $78, $78, $f8, $70, $ff, $f3, $ff, $ff        ;; 01:6fe5 ????????
    db   $ff, $ff, $80, $00, $80, $80, $80, $80        ;; 01:6fed ????????
    db   $80, $00, $00, $00, $00, $00, $00, $00        ;; 01:6ff5 ????????
    db   $00, $00, $80, $00, $80, $80, $80, $80        ;; 01:6ffd ????????
    db   $ff, $fc, $ff, $ff, $7f, $0f, $0f, $06        ;; 01:7005 ????????
    db   $7e, $7e, $3f, $1e, $07, $07, $c7, $43        ;; 01:700d ????????
    db   $ff, $e7, $ff, $fe, $fe, $7c, $00, $00        ;; 01:7015 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:701d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7025 ????????
    db   $00, $00, $00, $00, $c7, $c6, $e7, $c6        ;; 01:702d ????????
    db   $e7, $c2, $e3, $c3, $ff, $7f, $7f, $7f        ;; 01:7035 ????????
    db   $77, $23, $07, $03, $07, $03, $07, $03        ;; 01:703d ????????
    db   $03, $03, $00, $00, $00, $00, $00, $00        ;; 01:7045 ????????
    db   $00, $00, $00, $00, $80, $00, $80, $00        ;; 01:704d ????????
    db   $80, $00, $80, $80, $80, $80, $80, $80        ;; 01:7055 ????????
    db   $ff, $1f, $ff, $ff, $f7, $e2, $e0, $e0        ;; 01:705d ????????
    db   $f0, $e0, $ff, $fe, $ff, $3f, $03, $03        ;; 01:7065 ????????
    db   $03, $03, $ff, $67, $7f, $7e, $00, $00        ;; 01:706d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7075 ????????
    db   $00, $00, $80, $00, $80, $00, $80, $80        ;; 01:707d ????????
    db   $80, $00, $00, $00, $07, $06, $1f, $0f        ;; 01:7085 ????????
    db   $3e, $1c, $3c, $38, $78, $78, $ff, $7e        ;; 01:708d ????????
    db   $ff, $f7, $e7, $e3, $e7, $63, $7f, $3f        ;; 01:7095 ????????
    db   $3f, $1e, $00, $00, $80, $00, $00, $00        ;; 01:709d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:70a5 ????????
    db   $80, $00, $80, $00, $00, $00, $00, $00        ;; 01:70ad ????????
    db   $7f, $70, $ff, $7f, $ff, $ff, $cf, $0f        ;; 01:70b5 ????????
    db   $0f, $07, $0f, $07, $0f, $07, $0f, $0e        ;; 01:70bd ????????
    db   $0f, $0e, $0e, $0e, $1e, $0e, $00, $00        ;; 01:70c5 ????????
    db   $80, $80, $80, $80, $80, $00, $80, $00        ;; 01:70cd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:70d5 ????????
    db   $00, $00, $00, $00, $3e, $1c, $7f, $3f        ;; 01:70dd ????????
    db   $f3, $73, $f3, $63, $7f, $7f, $7e, $3e        ;; 01:70e5 ????????
    db   $ff, $7f, $f7, $e3, $f3, $e3, $ff, $7f        ;; 01:70ed ????????
    db   $3e, $3e, $00, $00, $80, $00, $80, $80        ;; 01:70f5 ????????
    db   $80, $80, $00, $00, $00, $00, $80, $00        ;; 01:70fd ????????
    db   $80, $80, $80, $80, $00, $00, $00, $00        ;; 01:7105 ????????
    db   $7c, $38, $ff, $fe, $ef, $e7, $e7, $e7        ;; 01:710d ????????
    db   $ff, $7f, $7f, $3f, $0f, $07, $0f, $07        ;; 01:7115 ????????
    db   $1f, $0e, $fe, $7e, $fc, $f8, $00, $00        ;; 01:711d ????????
    db   $00, $00, $00, $00, $80, $00, $80, $80        ;; 01:7125 ????????
    db   $80, $80, $80, $00, $00, $00, $00, $00        ;; 01:712d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7135 ????....
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:713d ........
    db   $00, $00, $00, $00, $f0, $60, $f0, $70        ;; 01:7145 ........
    db   $f0, $60, $00, $00, $00, $00, $00, $00        ;; 01:714d ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7155 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:715d ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7165 ????????
    db   $00, $00, $00, $00, $00, $00, $f0, $e0        ;; 01:716d ????????
    db   $f0, $f0, $f0, $60, $e0, $c0, $00, $00        ;; 01:7175 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:717d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7185 ????????
    db   $00, $00, $00, $00, $70, $70, $f8, $78        ;; 01:718d ????????
    db   $f8, $f0, $f8, $f0, $f0, $70, $f0, $60        ;; 01:7195 ????????
    db   $60, $60, $60, $00, $f0, $60, $f0, $70        ;; 01:719d ????????
    db   $f0, $60, $00, $00, $00, $00, $00, $00        ;; 01:71a5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71ad ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71b5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71bd ????????
    db   $00, $00, $fc, $fc, $fc, $fc, $00, $00        ;; 01:71c5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71cd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71d5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71dd ????????
    db   $00, $00, $00, $00                            ;; 01:71e5 ????

data_01_71e9:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:71e9 ????????
    db   $00, $00, $00, $00, $03, $01, $03, $03        ;; 01:71f1 ????????
    db   $03, $03, $03, $01, $00, $00, $00, $00        ;; 01:71f9 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7201 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7209 ????????
    db   $00, $00, $00, $00, $c0, $80, $c0, $c0        ;; 01:7211 ????????
    db   $c0, $c0, $c0, $80, $00, $00, $00, $00        ;; 01:7219 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7221 ????????
    db   $00, $00, $01, $01, $01, $01, $01, $01        ;; 01:7229 ????????
    db   $01, $01, $7f, $7f, $40, $40, $5f, $40        ;; 01:7231 ????????
    db   $5f, $40, $5f, $40, $7f, $7f, $01, $01        ;; 01:7239 ????????
    db   $01, $01, $01, $01, $01, $01, $00, $00        ;; 01:7241 ????????
    db   $00, $00, $00, $80, $80, $c0, $40, $60        ;; 01:7249 ????????
    db   $20, $30, $50, $18, $68, $0c, $f4, $06        ;; 01:7251 ????????
    db   $fc, $06, $f8, $0c, $f0, $18, $60, $30        ;; 01:7259 ????????
    db   $40, $60, $80, $c0, $00, $80, $00, $00        ;; 01:7261 ????????
    db   $00, $00, $00, $01, $01, $03, $02, $06        ;; 01:7269 ????????
    db   $05, $0c, $0b, $18, $17, $30, $2f, $60        ;; 01:7271 ????????
    db   $3f, $60, $1f, $30, $0f, $18, $07, $0c        ;; 01:7279 ????????
    db   $03, $06, $01, $03, $00, $01, $00, $00        ;; 01:7281 ????????
    db   $00, $00, $80, $80, $80, $80, $80, $80        ;; 01:7289 ????????
    db   $80, $80, $fe, $fe, $82, $02, $fe, $02        ;; 01:7291 ????????
    db   $fe, $02, $fe, $02, $fe, $fe, $80, $80        ;; 01:7299 ????????
    db   $80, $80, $80, $80, $80, $80, $00, $00        ;; 01:72a1 ????????
    db   $00, $00, $00, $01, $01, $03, $02, $06        ;; 01:72a9 ????????
    db   $05, $0c, $0b, $18, $17, $30, $2f, $60        ;; 01:72b1 ????????
    db   $7f, $7c, $05, $04, $05, $04, $05, $04        ;; 01:72b9 ????????
    db   $05, $04, $05, $04, $07, $07, $00, $00        ;; 01:72c1 ????????
    db   $00, $00, $00, $80, $80, $c0, $c0, $60        ;; 01:72c9 ????????
    db   $e0, $30, $f0, $18, $f8, $0c, $fc, $06        ;; 01:72d1 ????????
    db   $fe, $3e, $e0, $20, $e0, $20, $e0, $20        ;; 01:72d9 ????????
    db   $e0, $20, $e0, $20, $e0, $e0, $00, $00        ;; 01:72e1 ????????
    db   $00, $00, $07, $07, $04, $04, $05, $04        ;; 01:72e9 ????????
    db   $05, $04, $05, $04, $05, $04, $7d, $7c        ;; 01:72f1 ????????
    db   $21, $60, $1f, $30, $0f, $18, $07, $0c        ;; 01:72f9 ????????
    db   $03, $06, $01, $03, $00, $01, $00, $00        ;; 01:7301 ????????
    db   $00, $00, $e0, $e0, $20, $20, $e0, $20        ;; 01:7309 ????????
    db   $e0, $20, $e0, $20, $e0, $20, $fe, $3e        ;; 01:7311 ????????
    db   $fc, $06, $f8, $0c, $f0, $18, $e0, $30        ;; 01:7319 ????????
    db   $c0, $60, $80, $c0, $00, $80, $00, $00        ;; 01:7321 ????????
    db   $00, $00, $01, $01, $01, $01, $01, $01        ;; 01:7329 ????????
    db   $01, $01, $7f, $7f, $7f, $7f, $7f, $7f        ;; 01:7331 ????????
    db   $7f, $7f, $7f, $7f, $7f, $7f, $01, $01        ;; 01:7339 ????????
    db   $01, $01, $01, $01, $01, $01, $00, $00        ;; 01:7341 ????????
    db   $00, $00, $00, $80, $80, $c0, $c0, $e0        ;; 01:7349 ????????
    db   $e0, $f0, $f0, $f8, $f8, $fc, $fc, $fe        ;; 01:7351 ????????
    db   $fc, $fe, $f8, $fc, $f0, $f8, $e0, $f0        ;; 01:7359 ????????
    db   $c0, $e0, $80, $c0, $00, $80, $00, $00        ;; 01:7361 ????????
    db   $00, $00, $00, $01, $01, $03, $03, $07        ;; 01:7369 ????????
    db   $07, $0f, $0f, $1f, $1f, $3f, $3f, $7f        ;; 01:7371 ????????
    db   $3f, $7f, $1f, $3f, $0f, $1f, $07, $0f        ;; 01:7379 ????????
    db   $03, $07, $01, $03, $00, $01, $00, $00        ;; 01:7381 ????????
    db   $00, $00, $80, $80, $80, $80, $80, $80        ;; 01:7389 ????????
    db   $80, $80, $fe, $fe, $fe, $fe, $fe, $fe        ;; 01:7391 ????????
    db   $fe, $fe, $fe, $fe, $fe, $fe, $80, $80        ;; 01:7399 ????????
    db   $80, $80, $80, $80, $80, $80, $00, $00        ;; 01:73a1 ????????
    db   $00, $00, $00, $01, $01, $03, $03, $07        ;; 01:73a9 ????????
    db   $07, $0f, $0f, $1f, $1f, $3f, $3f, $7f        ;; 01:73b1 ????????
    db   $7f, $7f, $07, $07, $07, $07, $07, $07        ;; 01:73b9 ????????
    db   $07, $07, $07, $07, $07, $07, $00, $00        ;; 01:73c1 ????????
    db   $00, $00, $00, $80, $80, $c0, $c0, $e0        ;; 01:73c9 ????????
    db   $e0, $f0, $f0, $f8, $f8, $fc, $fc, $fe        ;; 01:73d1 ????????
    db   $fe, $fe, $e0, $e0, $e0, $e0, $e0, $e0        ;; 01:73d9 ????????
    db   $e0, $e0, $e0, $e0, $e0, $e0, $00, $00        ;; 01:73e1 ????????
    db   $00, $00, $07, $07, $07, $07, $07, $07        ;; 01:73e9 ????????
    db   $07, $07, $07, $07, $07, $07, $7f, $7f        ;; 01:73f1 ????????
    db   $3f, $7f, $1f, $3f, $0f, $1f, $07, $0f        ;; 01:73f9 ????????
    db   $03, $07, $01, $03, $00, $01, $00, $00        ;; 01:7401 ????????
    db   $00, $00, $e0, $e0, $e0, $e0, $e0, $e0        ;; 01:7409 ????????
    db   $e0, $e0, $e0, $e0, $e0, $e0, $fe, $fe        ;; 01:7411 ????????
    db   $fc, $fe, $f8, $fc, $f0, $f8, $e0, $f0        ;; 01:7419 ????????
    db   $c0, $e0, $80, $c0, $00, $80, $00, $00        ;; 01:7421 ????????
    db   $00, $00, $00, $00, $00, $00, $74, $74        ;; 01:7429 ????????
    db   $74, $74, $46, $44, $47, $43, $73, $73        ;; 01:7431 ????????
    db   $77, $73, $45, $44, $44, $44, $74, $74        ;; 01:7439 ????????
    db   $74, $74, $00, $00, $00, $00, $00, $00        ;; 01:7441 ????????
    db   $00, $00, $00, $00, $00, $00, $ae, $ae        ;; 01:7449 ????????
    db   $ae, $ae, $a4, $a4, $a4, $24, $24, $24        ;; 01:7451 ????????
    db   $a4, $24, $a4, $a4, $a4, $a4, $a4, $a4        ;; 01:7459 ????????
    db   $a4, $a4, $00, $00, $00, $00, $00, $00        ;; 01:7461 ????????
    db   $00, $00, $00, $00, $00, $00, $7e, $3c        ;; 01:7469 ????????
    db   $7e, $7e, $66, $66, $60, $60, $6e, $6e        ;; 01:7471 ????????
    db   $6e, $6e, $66, $66, $66, $66, $7e, $7e        ;; 01:7479 ????????
    db   $7e, $3e, $00, $00, $00, $00, $00, $00        ;; 01:7481 ????????
    db   $00, $00, $00, $00, $00, $00, $7e, $3c        ;; 01:7489 ????????
    db   $7e, $7e, $66, $66, $66, $66, $66, $66        ;; 01:7491 ????????
    db   $66, $66, $66, $66, $66, $66, $7e, $7e        ;; 01:7499 ????????
    db   $7e, $3c, $00, $00, $00, $00, $00, $00        ;; 01:74a1 ????????
    db   $0f, $00, $0f, $00, $0f, $00, $0f, $00        ;; 01:74a9 ????????
    db   $0f, $00, $0f, $00, $0f, $00, $0f, $00        ;; 01:74b1 ????????
    db   $0f, $00, $0f, $00, $0f, $00, $0f, $00        ;; 01:74b9 ????????
    db   $0f, $00, $0f, $00, $0f, $00, $0f, $00        ;; 01:74c1 ????????
    db   $0f, $ff, $0f, $ff, $0f, $ff, $0f, $ff        ;; 01:74c9 ????????
    db   $0f, $ff, $0f, $ff, $0f, $ff, $0f, $ff        ;; 01:74d1 ????????
    db   $0f, $ff, $0f, $ff, $0f, $ff, $0f, $ff        ;; 01:74d9 ????????
    db   $0f, $ff, $0f, $ff, $0f, $ff, $0f, $ff        ;; 01:74e1 ????????

data_01_74e9:
    db   $fd, $74, $40, $75                            ;; 01:74e9 ....

data_01_74ed:
    db   $40, $75, $40, $75, $40, $75, $89, $7b        ;; 01:74ed ??..??..
    db   $cc, $7b, $83, $75, $06, $77, $72, $3c        ;; 01:74f5 ......??
    db   $02, $02, $00                                 ;; 01:74fd ...
    dw   `00000000                                     ;; 01:7500 $00 $00
    dw   `00000000                                     ;; 01:7502 $00 $00
    dw   `00000001                                     ;; 01:7504 $01 $00
    dw   `00000013                                     ;; 01:7506 $03 $01
    dw   `00000132                                     ;; 01:7508 $06 $03
    dw   `00001322                                     ;; 01:750a $0c $07
    dw   `00013222                                     ;; 01:750c $18 $0f
    dw   `00032222                                     ;; 01:750e $10 $1f

    dw   `01300000                                     ;; 01:7510 $60 $20
    dw   `13200000                                     ;; 01:7512 $c0 $60
    dw   `32200000                                     ;; 01:7514 $80 $e0
    dw   `22200000                                     ;; 01:7516 $00 $e0
    dw   `22200000                                     ;; 01:7518 $00 $e0
    dw   `22200000                                     ;; 01:751a $00 $e0
    dw   `22200000                                     ;; 01:751c $00 $e0
    dw   `22200000                                     ;; 01:751e $00 $e0

    dw   `00012222                                     ;; 01:7520 $10 $0f
    dw   `00001222                                     ;; 01:7522 $08 $07
    dw   `00000122                                     ;; 01:7524 $04 $03
    dw   `00000012                                     ;; 01:7526 $02 $01
    dw   `00000001                                     ;; 01:7528 $01 $00
    dw   `00000000                                     ;; 01:752a $00 $00
    dw   `00000000                                     ;; 01:752c $00 $00
    dw   `00000000                                     ;; 01:752e $00 $00

    dw   `22200000                                     ;; 01:7530 $00 $e0
    dw   `22200000                                     ;; 01:7532 $00 $e0
    dw   `22200000                                     ;; 01:7534 $00 $e0
    dw   `22200000                                     ;; 01:7536 $00 $e0
    dw   `22200000                                     ;; 01:7538 $00 $e0
    dw   `12200000                                     ;; 01:753a $80 $60
    dw   `01200000                                     ;; 01:753c $40 $20
    dw   `00100000                                     ;; 01:753e $20 $00

    db   $02, $02, $00                                 ;; 01:7540 ...
    dw   `00000310                                     ;; 01:7543 $06 $04
    dw   `00000331                                     ;; 01:7545 $07 $06
    dw   `00000323                                     ;; 01:7547 $05 $07
    dw   `00000322                                     ;; 01:7549 $04 $07
    dw   `00000322                                     ;; 01:754b $04 $07
    dw   `00000322                                     ;; 01:754d $04 $07
    dw   `00000322                                     ;; 01:754f $04 $07
    dw   `00000322                                     ;; 01:7551 $04 $07

    db   $00, $00, $00, $00, $80, $00, $c0, $80        ;; 01:7553 pppppppp
    dw   `23100000                                     ;; 01:755b $60 $c0
    dw   `22310000                                     ;; 01:755d $30 $e0
    dw   `22231000                                     ;; 01:755f $18 $f0
    dw   `22223000                                     ;; 01:7561 $08 $f8
    dw   `00000322                                     ;; 01:7563 $04 $07
    dw   `00000322                                     ;; 01:7565 $04 $07
    dw   `00000322                                     ;; 01:7567 $04 $07
    dw   `00000222                                     ;; 01:7569 $00 $07

    dw   `00000322                                     ;; 01:756b $04 $07
    dw   `00000221                                     ;; 01:756d $01 $06
    dw   `00000210                                     ;; 01:756f $02 $04
    dw   `00000100                                     ;; 01:7571 $04 $00

    db   $08, $f0, $10, $e0, $20, $c0, $40, $80        ;; 01:7573 pppppppp
    dw   `10000000                                     ;; 01:757b $80 $00
    dw   `00000000                                     ;; 01:757d $00 $00
    dw   `00000000                                     ;; 01:757f $00 $00
    dw   `00000000                                     ;; 01:7581 $00 $00

    db   $0c, $02, $00                                 ;; 01:7583 ...
    dw   `00000000                                     ;; 01:7586 $00 $00
    dw   `00000002                                     ;; 01:7588 $00 $01
    dw   `00000000                                     ;; 01:758a $00 $00
    dw   `00000000                                     ;; 01:758c $00 $00
    dw   `00000000                                     ;; 01:758e $00 $00
    dw   `00000000                                     ;; 01:7590 $00 $00
    dw   `00000222                                     ;; 01:7592 $00 $07
    dw   `00002111                                     ;; 01:7594 $07 $08

    dw   `20000000                                     ;; 01:7596 $00 $80
    dw   `21000000                                     ;; 01:7598 $40 $80
    dw   `10000000                                     ;; 01:759a $80 $00
    dw   `00000000                                     ;; 01:759c $00 $00
    dw   `10000000                                     ;; 01:759e $80 $00
    dw   `10000000                                     ;; 01:75a0 $80 $00
    dw   `22220000                                     ;; 01:75a2 $00 $f0
    dw   `11111000                                     ;; 01:75a4 $f8 $00

    dw   `00000001                                     ;; 01:75a6 $01 $00
    dw   `00000003                                     ;; 01:75a8 $01 $01
    dw   `00000001                                     ;; 01:75aa $01 $00
    dw   `00000000                                     ;; 01:75ac $00 $00
    dw   `00000000                                     ;; 01:75ae $00 $00
    dw   `00000000                                     ;; 01:75b0 $00 $00
    dw   `00001333                                     ;; 01:75b2 $0f $07
    dw   `00003222                                     ;; 01:75b4 $08 $0f

    dw   `31000000                                     ;; 01:75b6 $c0 $80
    dw   `32000000                                     ;; 01:75b8 $80 $c0
    dw   `21000000                                     ;; 01:75ba $40 $80
    dw   `10000000                                     ;; 01:75bc $80 $00
    dw   `20000000                                     ;; 01:75be $00 $80
    dw   `20000000                                     ;; 01:75c0 $00 $80
    dw   `33331000                                     ;; 01:75c2 $f8 $f0
    dw   `22222000                                     ;; 01:75c4 $00 $f8

    dw   `00000001                                     ;; 01:75c6 $01 $00
    dw   `00000003                                     ;; 01:75c8 $01 $01
    dw   `00000001                                     ;; 01:75ca $01 $00
    dw   `00000000                                     ;; 01:75cc $00 $00
    dw   `00000000                                     ;; 01:75ce $00 $00
    dw   `00000000                                     ;; 01:75d0 $00 $00
    dw   `00001233                                     ;; 01:75d2 $0b $07
    dw   `00002333                                     ;; 01:75d4 $07 $0f

    db   $c0, $80, $80, $c0, $40, $80, $80, $80        ;; 01:75d6 pppppppp
    dw   `30000000                                     ;; 01:75de $80 $80
    dw   `30000000                                     ;; 01:75e0 $80 $80
    dw   `33321000                                     ;; 01:75e2 $e8 $f0
    dw   `33332000                                     ;; 01:75e4 $f0 $f8
    dw   `00000000                                     ;; 01:75e6 $00 $00
    dw   `00000001                                     ;; 01:75e8 $01 $00
    dw   `00000000                                     ;; 01:75ea $00 $00
    dw   `00000000                                     ;; 01:75ec $00 $00

    dw   `00000000                                     ;; 01:75ee $00 $00
    dw   `00000000                                     ;; 01:75f0 $00 $00
    dw   `00000111                                     ;; 01:75f2 $07 $00
    dw   `00001000                                     ;; 01:75f4 $08 $00

    db   $80, $00, $40, $00, $80, $00, $80, $00        ;; 01:75f6 pppppppp
    dw   `10000000                                     ;; 01:75fe $80 $00
    dw   `10000000                                     ;; 01:7600 $80 $00
    dw   `11110000                                     ;; 01:7602 $f0 $00
    dw   `00001000                                     ;; 01:7604 $08 $00
    dw   `00000001                                     ;; 01:7606 $01 $00
    dw   `00000003                                     ;; 01:7608 $01 $01
    dw   `00000001                                     ;; 01:760a $01 $00
    dw   `00000000                                     ;; 01:760c $00 $00

    dw   `00000000                                     ;; 01:760e $00 $00
    dw   `00000000                                     ;; 01:7610 $00 $00
    dw   `00001333                                     ;; 01:7612 $0f $07
    dw   `00003222                                     ;; 01:7614 $08 $0f

    db   $c0, $80, $80, $c0, $40, $80, $80, $00        ;; 01:7616 pppppppp
    dw   `20000000                                     ;; 01:761e $00 $80
    dw   `20000000                                     ;; 01:7620 $00 $80
    dw   `33331000                                     ;; 01:7622 $f8 $f0
    dw   `22222000                                     ;; 01:7624 $00 $f8
    dw   `00000001                                     ;; 01:7626 $01 $00
    dw   `00000002                                     ;; 01:7628 $00 $01
    dw   `00000001                                     ;; 01:762a $01 $00
    dw   `00000000                                     ;; 01:762c $00 $00

    dw   `00000000                                     ;; 01:762e $00 $00
    dw   `00000000                                     ;; 01:7630 $00 $00
    dw   `00001222                                     ;; 01:7632 $08 $07
    dw   `00002000                                     ;; 01:7634 $00 $08

    db   $40, $80, $00, $40, $40, $80, $00, $80        ;; 01:7636 pppppppp
    dw   `20000000                                     ;; 01:763e $00 $80
    dw   `20000000                                     ;; 01:7640 $00 $80
    dw   `22221000                                     ;; 01:7642 $08 $f0
    dw   `00002000                                     ;; 01:7644 $00 $08
    dw   `00002120                                     ;; 01:7646 $04 $0a
    dw   `00002120                                     ;; 01:7648 $04 $0a
    dw   `00002110                                     ;; 01:764a $06 $08
    dw   `00002100                                     ;; 01:764c $04 $08

    dw   `00000211                                     ;; 01:764e $03 $04
    dw   `00000212                                     ;; 01:7650 $02 $05
    dw   `00000210                                     ;; 01:7652 $02 $04
    dw   `00000011                                     ;; 01:7654 $03 $00

    db   $08, $a0, $08, $a0, $a8, $00, $08, $00        ;; 01:7656 pppppppp
    dw   `11110000                                     ;; 01:765e $f0 $00
    dw   `22110000                                     ;; 01:7660 $30 $c0
    dw   `00110000                                     ;; 01:7662 $30 $00
    dw   `11100000                                     ;; 01:7664 $e0 $00
    dw   `00003231                                     ;; 01:7666 $0b $0e
    dw   `00003231                                     ;; 01:7668 $0b $0e
    dw   `00003221                                     ;; 01:766a $09 $0e
    dw   `00003211                                     ;; 01:766c $0b $0c

    dw   `00001322                                     ;; 01:766e $0c $07
    dw   `00000323                                     ;; 01:7670 $05 $07
    dw   `00000321                                     ;; 01:7672 $05 $06
    dw   `00000122                                     ;; 01:7674 $04 $03

    db   $f0, $a8, $f0, $a8, $50, $a8, $f0, $08        ;; 01:7676 pppppppp
    dw   `22221000                                     ;; 01:767e $08 $f0
    dw   `33220000                                     ;; 01:7680 $c0 $f0
    dw   `11220000                                     ;; 01:7682 $c0 $30
    dw   `22210000                                     ;; 01:7684 $10 $e0
    dw   `00002323                                     ;; 01:7686 $05 $0f
    dw   `00002323                                     ;; 01:7688 $05 $0f
    dw   `00002313                                     ;; 01:768a $07 $0d
    dw   `00002333                                     ;; 01:768c $07 $0f

    dw   `00001333                                     ;; 01:768e $0f $07
    dw   `00000232                                     ;; 01:7690 $02 $07
    dw   `00000231                                     ;; 01:7692 $03 $06
    dw   `00000133                                     ;; 01:7694 $07 $03

    db   $50, $f8, $50, $f8, $f0, $58, $f0, $f8        ;; 01:7696 pppppppp
    dw   `33331000                                     ;; 01:769e $f8 $f0
    dw   `22320000                                     ;; 01:76a0 $20 $f0
    dw   `11320000                                     ;; 01:76a2 $e0 $30
    dw   `33310000                                     ;; 01:76a4 $f0 $e0
    dw   `00001000                                     ;; 01:76a6 $08 $00
    dw   `00001000                                     ;; 01:76a8 $08 $00
    dw   `00001000                                     ;; 01:76aa $08 $00
    dw   `00001000                                     ;; 01:76ac $08 $00

    dw   `00000100                                     ;; 01:76ae $04 $00
    dw   `00000100                                     ;; 01:76b0 $04 $00
    dw   `00000100                                     ;; 01:76b2 $04 $00
    dw   `00000011                                     ;; 01:76b4 $03 $00

    db   $08, $00, $08, $00, $08, $00, $08, $00        ;; 01:76b6 pppppppp
    dw   `00010000                                     ;; 01:76be $10 $00
    dw   `00010000                                     ;; 01:76c0 $10 $00
    dw   `00010000                                     ;; 01:76c2 $10 $00
    dw   `11100000                                     ;; 01:76c4 $e0 $00
    dw   `00002323                                     ;; 01:76c6 $05 $0f
    dw   `00002323                                     ;; 01:76c8 $05 $0f
    dw   `00002313                                     ;; 01:76ca $07 $0d
    dw   `00002333                                     ;; 01:76cc $07 $0f

    dw   `00001333                                     ;; 01:76ce $0f $07
    dw   `00000232                                     ;; 01:76d0 $02 $07
    dw   `00000231                                     ;; 01:76d2 $03 $06
    dw   `00000133                                     ;; 01:76d4 $07 $03

    db   $50, $f8, $50, $f8, $f0, $58, $f0, $f8        ;; 01:76d6 pppppppp
    dw   `33331000                                     ;; 01:76de $f8 $f0
    dw   `22320000                                     ;; 01:76e0 $20 $f0
    dw   `11320000                                     ;; 01:76e2 $e0 $30
    dw   `33310000                                     ;; 01:76e4 $f0 $e0
    dw   `00001000                                     ;; 01:76e6 $08 $00
    dw   `00001000                                     ;; 01:76e8 $08 $00
    dw   `00001000                                     ;; 01:76ea $08 $00
    dw   `00001000                                     ;; 01:76ec $08 $00

    dw   `00000100                                     ;; 01:76ee $04 $00
    dw   `00000100                                     ;; 01:76f0 $04 $00
    dw   `00000100                                     ;; 01:76f2 $04 $00
    dw   `00000011                                     ;; 01:76f4 $03 $00

    db   $08, $00, $08, $00, $08, $00, $08, $00        ;; 01:76f6 pppppppp
    dw   `00010000                                     ;; 01:76fe $10 $00
    dw   `00010000                                     ;; 01:7700 $10 $00
    dw   `00010000                                     ;; 01:7702 $10 $00
    dw   `11100000                                     ;; 01:7704 $e0 $00

    db   $12, $04, $00                                 ;; 01:7706 ...
    dw   `00000000                                     ;; 01:7709 $00 $00
    dw   `00000000                                     ;; 01:770b $00 $00
    dw   `00000000                                     ;; 01:770d $00 $00
    dw   `00000000                                     ;; 01:770f $00 $00
    dw   `00000000                                     ;; 01:7711 $00 $00
    dw   `00000000                                     ;; 01:7713 $00 $00
    dw   `00000000                                     ;; 01:7715 $00 $00
    dw   `00000000                                     ;; 01:7717 $00 $00

    dw   `00000000                                     ;; 01:7719 $00 $00
    dw   `00000000                                     ;; 01:771b $00 $00
    dw   `00122000                                     ;; 01:771d $20 $18
    dw   `00221100                                     ;; 01:771f $0c $30
    dw   `00211100                                     ;; 01:7721 $1c $20
    dw   `00121000                                     ;; 01:7723 $28 $10
    dw   `00000000                                     ;; 01:7725 $00 $00
    dw   `00021000                                     ;; 01:7727 $08 $10

    dw   `00000000                                     ;; 01:7729 $00 $00
    dw   `00000000                                     ;; 01:772b $00 $00
    dw   `00000000                                     ;; 01:772d $00 $00
    dw   `00000000                                     ;; 01:772f $00 $00
    dw   `00000000                                     ;; 01:7731 $00 $00
    dw   `00000000                                     ;; 01:7733 $00 $00
    dw   `00000000                                     ;; 01:7735 $00 $00
    dw   `00000000                                     ;; 01:7737 $00 $00

    dw   `00000000                                     ;; 01:7739 $00 $00
    dw   `00000000                                     ;; 01:773b $00 $00
    dw   `00000000                                     ;; 01:773d $00 $00
    dw   `00000000                                     ;; 01:773f $00 $00
    dw   `00000000                                     ;; 01:7741 $00 $00
    dw   `00000000                                     ;; 01:7743 $00 $00
    dw   `00000000                                     ;; 01:7745 $00 $00
    dw   `00000000                                     ;; 01:7747 $00 $00

    dw   `00000000                                     ;; 01:7749 $00 $00
    dw   `00000000                                     ;; 01:774b $00 $00
    dw   `00133100                                     ;; 01:774d $3c $18
    dw   `00332200                                     ;; 01:774f $30 $3c
    dw   `00322200                                     ;; 01:7751 $20 $3c
    dw   `00132100                                     ;; 01:7753 $34 $18
    dw   `00021000                                     ;; 01:7755 $08 $10
    dw   `00032000                                     ;; 01:7757 $10 $18

    dw   `00000000                                     ;; 01:7759 $00 $00
    dw   `00000000                                     ;; 01:775b $00 $00
    dw   `00000000                                     ;; 01:775d $00 $00
    dw   `00000000                                     ;; 01:775f $00 $00
    dw   `00000000                                     ;; 01:7761 $00 $00
    dw   `00000000                                     ;; 01:7763 $00 $00
    dw   `00000000                                     ;; 01:7765 $00 $00
    dw   `00000000                                     ;; 01:7767 $00 $00

    dw   `00000000                                     ;; 01:7769 $00 $00
    dw   `00000000                                     ;; 01:776b $00 $00
    dw   `00000000                                     ;; 01:776d $00 $00
    dw   `00000000                                     ;; 01:776f $00 $00
    dw   `00000000                                     ;; 01:7771 $00 $00
    dw   `00000000                                     ;; 01:7773 $00 $00
    dw   `00000000                                     ;; 01:7775 $00 $00
    dw   `00000000                                     ;; 01:7777 $00 $00

    dw   `00000000                                     ;; 01:7779 $00 $00
    dw   `00000000                                     ;; 01:777b $00 $00
    dw   `00133100                                     ;; 01:777d $3c $18
    dw   `00333200                                     ;; 01:777f $38 $3c
    dw   `00332200                                     ;; 01:7781 $30 $3c
    dw   `00122100                                     ;; 01:7783 $24 $18
    dw   `00021000                                     ;; 01:7785 $08 $10
    dw   `00032000                                     ;; 01:7787 $10 $18

    dw   `00000000                                     ;; 01:7789 $00 $00
    dw   `00000000                                     ;; 01:778b $00 $00
    dw   `00000000                                     ;; 01:778d $00 $00
    dw   `00000000                                     ;; 01:778f $00 $00
    dw   `00000000                                     ;; 01:7791 $00 $00
    dw   `00000000                                     ;; 01:7793 $00 $00
    dw   `00000000                                     ;; 01:7795 $00 $00
    dw   `00000000                                     ;; 01:7797 $00 $00

    dw   `00000000                                     ;; 01:7799 $00 $00
    dw   `00000000                                     ;; 01:779b $00 $00
    dw   `00000000                                     ;; 01:779d $00 $00
    dw   `00000000                                     ;; 01:779f $00 $00
    dw   `00000000                                     ;; 01:77a1 $00 $00
    dw   `00000000                                     ;; 01:77a3 $00 $00
    dw   `00000000                                     ;; 01:77a5 $00 $00
    dw   `00000000                                     ;; 01:77a7 $00 $00

    dw   `00000000                                     ;; 01:77a9 $00 $00
    dw   `00011000                                     ;; 01:77ab $18 $00
    dw   `00100100                                     ;; 01:77ad $24 $00
    dw   `01000010                                     ;; 01:77af $42 $00
    dw   `01000010                                     ;; 01:77b1 $42 $00
    dw   `00100100                                     ;; 01:77b3 $24 $00
    dw   `00100100                                     ;; 01:77b5 $24 $00
    dw   `00100100                                     ;; 01:77b7 $24 $00

    dw   `00000000                                     ;; 01:77b9 $00 $00
    dw   `00000000                                     ;; 01:77bb $00 $00
    dw   `00000000                                     ;; 01:77bd $00 $00
    dw   `00000000                                     ;; 01:77bf $00 $00
    dw   `00000000                                     ;; 01:77c1 $00 $00
    dw   `00000000                                     ;; 01:77c3 $00 $00
    dw   `00000000                                     ;; 01:77c5 $00 $00
    dw   `00000000                                     ;; 01:77c7 $00 $00

    dw   `00000000                                     ;; 01:77c9 $00 $00
    dw   `00000000                                     ;; 01:77cb $00 $00
    dw   `00000000                                     ;; 01:77cd $00 $00
    dw   `00000000                                     ;; 01:77cf $00 $00
    dw   `00000000                                     ;; 01:77d1 $00 $00
    dw   `00000000                                     ;; 01:77d3 $00 $00
    dw   `00000000                                     ;; 01:77d5 $00 $00
    dw   `00000000                                     ;; 01:77d7 $00 $00

    dw   `00000000                                     ;; 01:77d9 $00 $00
    dw   `00122100                                     ;; 01:77db $24 $18
    dw   `01200210                                     ;; 01:77dd $42 $24
    dw   `02000020                                     ;; 01:77df $00 $42
    dw   `02000020                                     ;; 01:77e1 $00 $42
    dw   `01200210                                     ;; 01:77e3 $42 $24
    dw   `00211200                                     ;; 01:77e5 $18 $24
    dw   `00200200                                     ;; 01:77e7 $00 $24

    dw   `00000000                                     ;; 01:77e9 $00 $00
    dw   `00000000                                     ;; 01:77eb $00 $00
    dw   `00000000                                     ;; 01:77ed $00 $00
    dw   `00000000                                     ;; 01:77ef $00 $00
    dw   `00000000                                     ;; 01:77f1 $00 $00
    dw   `00000000                                     ;; 01:77f3 $00 $00
    dw   `00000000                                     ;; 01:77f5 $00 $00
    dw   `00000000                                     ;; 01:77f7 $00 $00

    dw   `00000000                                     ;; 01:77f9 $00 $00
    dw   `00000000                                     ;; 01:77fb $00 $00
    dw   `00000000                                     ;; 01:77fd $00 $00
    dw   `00000000                                     ;; 01:77ff $00 $00
    dw   `00000000                                     ;; 01:7801 $00 $00
    dw   `00000000                                     ;; 01:7803 $00 $00
    dw   `00000000                                     ;; 01:7805 $00 $00
    dw   `00000000                                     ;; 01:7807 $00 $00

    dw   `00000000                                     ;; 01:7809 $00 $00
    dw   `00133100                                     ;; 01:780b $3c $18
    dw   `01300310                                     ;; 01:780d $66 $24
    dw   `03000030                                     ;; 01:780f $42 $42
    dw   `03000030                                     ;; 01:7811 $42 $42
    dw   `01300310                                     ;; 01:7813 $66 $24
    dw   `00311300                                     ;; 01:7815 $3c $24
    dw   `00300300                                     ;; 01:7817 $24 $24

    dw   `00000000                                     ;; 01:7819 $00 $00
    dw   `00000000                                     ;; 01:781b $00 $00
    dw   `00000000                                     ;; 01:781d $00 $00
    dw   `00000000                                     ;; 01:781f $00 $00
    dw   `00000000                                     ;; 01:7821 $00 $00
    dw   `00000000                                     ;; 01:7823 $00 $00
    dw   `00000000                                     ;; 01:7825 $00 $00
    dw   `00000000                                     ;; 01:7827 $00 $00

    dw   `00000000                                     ;; 01:7829 $00 $00
    dw   `00000000                                     ;; 01:782b $00 $00
    dw   `00000000                                     ;; 01:782d $00 $00
    dw   `00000000                                     ;; 01:782f $00 $00
    dw   `00000000                                     ;; 01:7831 $00 $00
    dw   `00000002                                     ;; 01:7833 $00 $01
    dw   `00000021                                     ;; 01:7835 $01 $02
    dw   `00000211                                     ;; 01:7837 $03 $04

    dw   `00021000                                     ;; 01:7839 $08 $10
    dw   `00021000                                     ;; 01:783b $08 $10
    dw   `00021000                                     ;; 01:783d $08 $10
    dw   `00021000                                     ;; 01:783f $08 $10
    dw   `00021000                                     ;; 01:7841 $08 $10
    dw   `22222222                                     ;; 01:7843 $00 $ff
    dw   `11111111                                     ;; 01:7845 $ff $00
    dw   `11111111                                     ;; 01:7847 $ff $00

    dw   `00000000                                     ;; 01:7849 $00 $00
    dw   `00000000                                     ;; 01:784b $00 $00
    dw   `00000000                                     ;; 01:784d $00 $00
    dw   `00000000                                     ;; 01:784f $00 $00
    dw   `00000000                                     ;; 01:7851 $00 $00
    dw   `20000000                                     ;; 01:7853 $00 $80
    dw   `11000000                                     ;; 01:7855 $c0 $00
    dw   `11100000                                     ;; 01:7857 $e0 $00

    dw   `00000000                                     ;; 01:7859 $00 $00
    dw   `00000000                                     ;; 01:785b $00 $00
    dw   `00000000                                     ;; 01:785d $00 $00
    dw   `00000000                                     ;; 01:785f $00 $00
    dw   `00000000                                     ;; 01:7861 $00 $00
    dw   `00000013                                     ;; 01:7863 $03 $01
    dw   `00000132                                     ;; 01:7865 $06 $03
    dw   `00001322                                     ;; 01:7867 $0c $07

    dw   `00032000                                     ;; 01:7869 $10 $18
    dw   `00032000                                     ;; 01:786b $10 $18
    dw   `00032000                                     ;; 01:786d $10 $18
    dw   `00032000                                     ;; 01:786f $10 $18
    dw   `00032000                                     ;; 01:7871 $10 $18
    dw   `33333333                                     ;; 01:7873 $ff $ff
    dw   `22222222                                     ;; 01:7875 $00 $ff
    dw   `22222222                                     ;; 01:7877 $00 $ff

    dw   `00000000                                     ;; 01:7879 $00 $00
    dw   `00000000                                     ;; 01:787b $00 $00
    dw   `00000000                                     ;; 01:787d $00 $00
    dw   `00000000                                     ;; 01:787f $00 $00
    dw   `00000000                                     ;; 01:7881 $00 $00
    dw   `31000000                                     ;; 01:7883 $c0 $80
    dw   `22100000                                     ;; 01:7885 $20 $c0
    dw   `22210000                                     ;; 01:7887 $10 $e0

    dw   `00000000                                     ;; 01:7889 $00 $00
    dw   `00000000                                     ;; 01:788b $00 $00
    dw   `00000000                                     ;; 01:788d $00 $00
    dw   `00000000                                     ;; 01:788f $00 $00
    dw   `00000000                                     ;; 01:7891 $00 $00
    dw   `00000013                                     ;; 01:7893 $03 $01
    dw   `00000133                                     ;; 01:7895 $07 $03
    dw   `00001333                                     ;; 01:7897 $0f $07

    dw   `00032000                                     ;; 01:7899 $10 $18
    dw   `00032000                                     ;; 01:789b $10 $18
    dw   `00032000                                     ;; 01:789d $10 $18
    dw   `00032000                                     ;; 01:789f $10 $18
    dw   `00032000                                     ;; 01:78a1 $10 $18
    dw   `33333333                                     ;; 01:78a3 $ff $ff
    dw   `33333333                                     ;; 01:78a5 $ff $ff
    dw   `33333333                                     ;; 01:78a7 $ff $ff

    dw   `00000000                                     ;; 01:78a9 $00 $00
    dw   `00000000                                     ;; 01:78ab $00 $00
    dw   `00000000                                     ;; 01:78ad $00 $00
    dw   `00000000                                     ;; 01:78af $00 $00
    dw   `00000000                                     ;; 01:78b1 $00 $00
    dw   `20000000                                     ;; 01:78b3 $00 $80
    dw   `32000000                                     ;; 01:78b5 $80 $c0
    dw   `33200000                                     ;; 01:78b7 $c0 $e0

    dw   `00000000                                     ;; 01:78b9 $00 $00
    dw   `00000000                                     ;; 01:78bb $00 $00
    dw   `00000000                                     ;; 01:78bd $00 $00
    dw   `00000000                                     ;; 01:78bf $00 $00
    dw   `00000001                                     ;; 01:78c1 $01 $00
    dw   `00000010                                     ;; 01:78c3 $02 $00
    dw   `00000100                                     ;; 01:78c5 $04 $00
    dw   `00001000                                     ;; 01:78c7 $08 $00

    dw   `00100100                                     ;; 01:78c9 $24 $00
    dw   `00100100                                     ;; 01:78cb $24 $00
    dw   `00100100                                     ;; 01:78cd $24 $00
    dw   `00100100                                     ;; 01:78cf $24 $00
    dw   `11100111                                     ;; 01:78d1 $e7 $00
    dw   `00000000                                     ;; 01:78d3 $00 $00
    dw   `00000000                                     ;; 01:78d5 $00 $00
    dw   `00000000                                     ;; 01:78d7 $00 $00

    dw   `00000000                                     ;; 01:78d9 $00 $00
    dw   `00000000                                     ;; 01:78db $00 $00
    dw   `00000000                                     ;; 01:78dd $00 $00
    dw   `00000000                                     ;; 01:78df $00 $00
    dw   `10000000                                     ;; 01:78e1 $80 $00
    dw   `01000000                                     ;; 01:78e3 $40 $00
    dw   `00100000                                     ;; 01:78e5 $20 $00
    dw   `00010000                                     ;; 01:78e7 $10 $00

    dw   `00000000                                     ;; 01:78e9 $00 $00
    dw   `00000000                                     ;; 01:78eb $00 $00
    dw   `00000000                                     ;; 01:78ed $00 $00
    dw   `00000000                                     ;; 01:78ef $00 $00
    dw   `00000012                                     ;; 01:78f1 $02 $01
    dw   `00000121                                     ;; 01:78f3 $05 $02
    dw   `00001210                                     ;; 01:78f5 $0a $04
    dw   `00012100                                     ;; 01:78f7 $14 $08

    dw   `00200200                                     ;; 01:78f9 $00 $24
    dw   `00200200                                     ;; 01:78fb $00 $24
    dw   `00200200                                     ;; 01:78fd $00 $24
    dw   `00200200                                     ;; 01:78ff $00 $24
    dw   `22200222                                     ;; 01:7901 $00 $e7
    dw   `00000000                                     ;; 01:7903 $00 $00
    dw   `00000000                                     ;; 01:7905 $00 $00
    dw   `00000000                                     ;; 01:7907 $00 $00

    dw   `00000000                                     ;; 01:7909 $00 $00
    dw   `00000000                                     ;; 01:790b $00 $00
    dw   `00000000                                     ;; 01:790d $00 $00
    dw   `00000000                                     ;; 01:790f $00 $00
    dw   `21000000                                     ;; 01:7911 $40 $80
    dw   `12100000                                     ;; 01:7913 $a0 $40
    dw   `01210000                                     ;; 01:7915 $50 $20
    dw   `00121000                                     ;; 01:7917 $28 $10

    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7919 pppppppp
    dw   `00000013                                     ;; 01:7921 $03 $01
    dw   `00000131                                     ;; 01:7923 $07 $02
    dw   `00001310                                     ;; 01:7925 $0e $04
    dw   `00013100                                     ;; 01:7927 $1c $08
    dw   `00300300                                     ;; 01:7929 $24 $24
    dw   `00300300                                     ;; 01:792b $24 $24
    dw   `00300300                                     ;; 01:792d $24 $24
    dw   `00300300                                     ;; 01:792f $24 $24

    dw   `33300333                                     ;; 01:7931 $e7 $e7
    dw   `00000000                                     ;; 01:7933 $00 $00
    dw   `00000000                                     ;; 01:7935 $00 $00
    dw   `00000000                                     ;; 01:7937 $00 $00

    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7939 pppppppp
    dw   `31000000                                     ;; 01:7941 $c0 $80
    dw   `13100000                                     ;; 01:7943 $e0 $40
    dw   `01310000                                     ;; 01:7945 $70 $20
    dw   `00131000                                     ;; 01:7947 $38 $10
    dw   `00002111                                     ;; 01:7949 $07 $08
    dw   `00002112                                     ;; 01:794b $06 $09
    dw   `00002112                                     ;; 01:794d $06 $09
    dw   `00002112                                     ;; 01:794f $06 $09

    dw   `00000212                                     ;; 01:7951 $02 $05
    dw   `00000210                                     ;; 01:7953 $02 $04
    dw   `00000211                                     ;; 01:7955 $03 $04
    dw   `00000211                                     ;; 01:7957 $03 $04

    db   $ff, $00, $22, $99, $aa, $11, $aa, $11        ;; 01:7959 pppppppp
    dw   `10121012                                     ;; 01:7961 $aa $11
    dw   `00100010                                     ;; 01:7963 $22 $00
    dw   `11111111                                     ;; 01:7965 $ff $00
    dw   `11111111                                     ;; 01:7967 $ff $00
    dw   `11110000                                     ;; 01:7969 $f0 $00
    dw   `20110000                                     ;; 01:796b $30 $80
    dw   `10110000                                     ;; 01:796d $b0 $00
    dw   `10110000                                     ;; 01:796f $b0 $00

    dw   `10100000                                     ;; 01:7971 $a0 $00
    dw   `00100000                                     ;; 01:7973 $20 $00
    dw   `11100000                                     ;; 01:7975 $e0 $00
    dw   `11100000                                     ;; 01:7977 $e0 $00

    db   $08, $0f, $09, $0f, $09, $0f, $09, $0f        ;; 01:7979 pppppppp
    dw   `00001323                                     ;; 01:7981 $0d $07
    dw   `00000321                                     ;; 01:7983 $05 $06
    dw   `00000322                                     ;; 01:7985 $04 $07
    dw   `00000322                                     ;; 01:7987 $04 $07
    dw   `22222222                                     ;; 01:7989 $00 $ff
    dw   `31233123                                     ;; 01:798b $dd $bb
    dw   `21232123                                     ;; 01:798d $55 $bb
    dw   `21232123                                     ;; 01:798f $55 $bb

    dw   `21232123                                     ;; 01:7991 $55 $bb
    dw   `11211121                                     ;; 01:7993 $dd $22
    dw   `22222222                                     ;; 01:7995 $00 $ff
    dw   `22222222                                     ;; 01:7997 $00 $ff

    db   $00, $f0, $c0, $b0, $40, $b0, $40, $b0        ;; 01:7999 pppppppp
    dw   `21210000                                     ;; 01:79a1 $50 $a0
    dw   `11200000                                     ;; 01:79a3 $c0 $20
    dw   `22200000                                     ;; 01:79a5 $00 $e0
    dw   `22200000                                     ;; 01:79a7 $00 $e0
    dw   `00003333                                     ;; 01:79a9 $0f $0f
    dw   `00003333                                     ;; 01:79ab $0f $0f
    dw   `00003332                                     ;; 01:79ad $0e $0f
    dw   `00002332                                     ;; 01:79af $06 $0f

    dw   `00001332                                     ;; 01:79b1 $0e $07
    dw   `00000311                                     ;; 01:79b3 $07 $04
    dw   `00000333                                     ;; 01:79b5 $07 $07
    dw   `00000233                                     ;; 01:79b7 $03 $07

    db   $ff, $ff, $ff, $77, $ee, $77, $ee, $77        ;; 01:79b9 pppppppp
    dw   `13321332                                     ;; 01:79c1 $ee $77
    dw   `13111311                                     ;; 01:79c3 $ff $44
    dw   `33333333                                     ;; 01:79c5 $ff $ff
    dw   `33333333                                     ;; 01:79c7 $ff $ff
    dw   `33320000                                     ;; 01:79c9 $e0 $f0
    dw   `13320000                                     ;; 01:79cb $e0 $70
    dw   `13320000                                     ;; 01:79cd $e0 $70
    dw   `13320000                                     ;; 01:79cf $e0 $70

    dw   `13200000                                     ;; 01:79d1 $c0 $60
    dw   `13200000                                     ;; 01:79d3 $c0 $60
    dw   `33200000                                     ;; 01:79d5 $c0 $e0
    dw   `33200000                                     ;; 01:79d7 $c0 $e0

    db   $10, $00, $10, $00, $10, $00, $10, $00        ;; 01:79d9 pppppppp
    dw   `00001000                                     ;; 01:79e1 $08 $00
    dw   `00001000                                     ;; 01:79e3 $08 $00
    dw   `00001000                                     ;; 01:79e5 $08 $00
    dw   `00001000                                     ;; 01:79e7 $08 $00
    dw   `00000000                                     ;; 01:79e9 $00 $00
    dw   `00000000                                     ;; 01:79eb $00 $00
    dw   `00000000                                     ;; 01:79ed $00 $00
    dw   `00000000                                     ;; 01:79ef $00 $00

    dw   `00000000                                     ;; 01:79f1 $00 $00
    dw   `00000000                                     ;; 01:79f3 $00 $00
    dw   `00000000                                     ;; 01:79f5 $00 $00
    dw   `00000000                                     ;; 01:79f7 $00 $00

    db   $08, $00, $08, $00, $08, $00, $08, $00        ;; 01:79f9 pppppppp
    dw   `00010000                                     ;; 01:7a01 $10 $00
    dw   `00010000                                     ;; 01:7a03 $10 $00
    dw   `00010000                                     ;; 01:7a05 $10 $00
    dw   `00010000                                     ;; 01:7a07 $10 $00
    dw   `00021000                                     ;; 01:7a09 $08 $10
    dw   `00020000                                     ;; 01:7a0b $00 $10
    dw   `00020000                                     ;; 01:7a0d $00 $10
    dw   `00021000                                     ;; 01:7a0f $08 $10

    dw   `00012000                                     ;; 01:7a11 $10 $08
    dw   `00002000                                     ;; 01:7a13 $00 $08
    dw   `00002000                                     ;; 01:7a15 $00 $08
    dw   `00002100                                     ;; 01:7a17 $04 $08

    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7a19 pppppppp
    dw   `00000000                                     ;; 01:7a21 $00 $00
    dw   `00000000                                     ;; 01:7a23 $00 $00
    dw   `00000000                                     ;; 01:7a25 $00 $00
    dw   `00000000                                     ;; 01:7a27 $00 $00
    dw   `00012000                                     ;; 01:7a29 $10 $08
    dw   `00002000                                     ;; 01:7a2b $00 $08
    dw   `00002000                                     ;; 01:7a2d $00 $08
    dw   `00012000                                     ;; 01:7a2f $10 $08

    dw   `00021000                                     ;; 01:7a31 $08 $10
    dw   `00020000                                     ;; 01:7a33 $00 $10
    dw   `00020000                                     ;; 01:7a35 $00 $10
    dw   `00120000                                     ;; 01:7a37 $20 $10

    db   $18, $10, $10, $10, $10, $10, $18, $10        ;; 01:7a39 pppppppp
    dw   `00013000                                     ;; 01:7a41 $18 $08
    dw   `00003000                                     ;; 01:7a43 $08 $08
    dw   `00003000                                     ;; 01:7a45 $08 $08
    dw   `00003100                                     ;; 01:7a47 $0c $08
    dw   `00000000                                     ;; 01:7a49 $00 $00
    dw   `00000000                                     ;; 01:7a4b $00 $00
    dw   `00000000                                     ;; 01:7a4d $00 $00
    dw   `00000000                                     ;; 01:7a4f $00 $00

    dw   `00000000                                     ;; 01:7a51 $00 $00
    dw   `00000000                                     ;; 01:7a53 $00 $00
    dw   `00000000                                     ;; 01:7a55 $00 $00
    dw   `00000000                                     ;; 01:7a57 $00 $00

    db   $18, $08, $08, $08, $08, $08, $18, $08        ;; 01:7a59 pppppppp
    dw   `00031000                                     ;; 01:7a61 $18 $10
    dw   `00030000                                     ;; 01:7a63 $10 $10
    dw   `00030000                                     ;; 01:7a65 $10 $10
    dw   `00130000                                     ;; 01:7a67 $30 $10
    dw   `00000021                                     ;; 01:7a69 $01 $02
    dw   `00000021                                     ;; 01:7a6b $01 $02
    dw   `00000021                                     ;; 01:7a6d $01 $02
    dw   `00000011                                     ;; 01:7a6f $03 $00

    dw   `00000002                                     ;; 01:7a71 $00 $01
    dw   `00000001                                     ;; 01:7a73 $01 $00
    dw   `00000000                                     ;; 01:7a75 $00 $00
    dw   `00000000                                     ;; 01:7a77 $00 $00

    db   $00, $ff, $7f, $80, $00, $00, $ff, $00        ;; 01:7a79 pppppppp
    dw   `11111111                                     ;; 01:7a81 $ff $00
    dw   `11111111                                     ;; 01:7a83 $ff $00
    dw   `00000000                                     ;; 01:7a85 $00 $00
    dw   `00000000                                     ;; 01:7a87 $00 $00

    db   $40, $80, $40, $00, $40, $00, $c0, $00        ;; 01:7a89 pppppppp
    dw   `10000000                                     ;; 01:7a91 $80 $00
    dw   `10000000                                     ;; 01:7a93 $80 $00
    dw   `00000000                                     ;; 01:7a95 $00 $00
    dw   `00000000                                     ;; 01:7a97 $00 $00
    dw   `00000132                                     ;; 01:7a99 $06 $03
    dw   `00000032                                     ;; 01:7a9b $02 $03
    dw   `00000032                                     ;; 01:7a9d $02 $03
    dw   `00000032                                     ;; 01:7a9f $02 $03

    dw   `00000012                                     ;; 01:7aa1 $02 $01
    dw   `00000002                                     ;; 01:7aa3 $00 $01
    dw   `00000000                                     ;; 01:7aa5 $00 $00
    dw   `00000000                                     ;; 01:7aa7 $00 $00

    db   $ff, $ff, $80, $ff, $ff, $00, $00, $ff        ;; 01:7aa9 pppppppp
    dw   `22222222                                     ;; 01:7ab1 $00 $ff
    dw   `22222222                                     ;; 01:7ab3 $00 $ff
    dw   `00000000                                     ;; 01:7ab5 $00 $00
    dw   `00000000                                     ;; 01:7ab7 $00 $00
    dw   `32100000                                     ;; 01:7ab9 $a0 $c0
    dw   `12000000                                     ;; 01:7abb $80 $40
    dw   `12000000                                     ;; 01:7abd $80 $40
    dw   `22000000                                     ;; 01:7abf $00 $c0

    dw   `21000000                                     ;; 01:7ac1 $40 $80
    dw   `20000000                                     ;; 01:7ac3 $00 $80
    dw   `00000000                                     ;; 01:7ac5 $00 $00
    dw   `00000000                                     ;; 01:7ac7 $00 $00
    dw   `00000133                                     ;; 01:7ac9 $07 $03
    dw   `00000033                                     ;; 01:7acb $03 $03

    db   $03, $03, $01, $03                            ;; 01:7acd pppp
    dw   `00000013                                     ;; 01:7ad1 $03 $01
    dw   `00000002                                     ;; 01:7ad3 $00 $01
    dw   `00000000                                     ;; 01:7ad5 $00 $00
    dw   `00000000                                     ;; 01:7ad7 $00 $00
    dw   `33333332                                     ;; 01:7ad9 $fe $ff
    dw   `32222221                                     ;; 01:7adb $81 $fe
    dw   `21111111                                     ;; 01:7add $7f $80
    dw   `33333333                                     ;; 01:7adf $ff $ff

    dw   `33333333                                     ;; 01:7ae1 $ff $ff
    dw   `22222222                                     ;; 01:7ae3 $00 $ff
    dw   `00000000                                     ;; 01:7ae5 $00 $00
    dw   `00000000                                     ;; 01:7ae7 $00 $00
    dw   `32000000                                     ;; 01:7ae9 $80 $c0
    dw   `32000000                                     ;; 01:7aeb $80 $c0

    db   $80, $c0, $80, $c0                            ;; 01:7aed .ppp
    dw   `20000000                                     ;; 01:7af1 $00 $80
    dw   `20000000                                     ;; 01:7af3 $00 $80
    dw   `00000000                                     ;; 01:7af5 $00 $00
    dw   `00000000                                     ;; 01:7af7 $00 $00
    dw   `00000100                                     ;; 01:7af9 $04 $00
    dw   `00000100                                     ;; 01:7afb $04 $00
    dw   `00000100                                     ;; 01:7afd $04 $00
    dw   `00000100                                     ;; 01:7aff $04 $00

    dw   `00000010                                     ;; 01:7b01 $02 $00
    dw   `00000010                                     ;; 01:7b03 $02 $00
    dw   `00000001                                     ;; 01:7b05 $01 $00
    dw   `00000000                                     ;; 01:7b07 $00 $00
    dw   `00000000                                     ;; 01:7b09 $00 $00
    dw   `00000000                                     ;; 01:7b0b $00 $00
    dw   `00000000                                     ;; 01:7b0d $00 $00
    dw   `00000000                                     ;; 01:7b0f $00 $00

    dw   `00000000                                     ;; 01:7b11 $00 $00
    dw   `00000000                                     ;; 01:7b13 $00 $00
    dw   `11111111                                     ;; 01:7b15 $ff $00
    dw   `00000000                                     ;; 01:7b17 $00 $00
    dw   `00100000                                     ;; 01:7b19 $20 $00
    dw   `00100000                                     ;; 01:7b1b $20 $00
    dw   `00100000                                     ;; 01:7b1d $20 $00
    dw   `00100000                                     ;; 01:7b1f $20 $00

    dw   `01000000                                     ;; 01:7b21 $40 $00
    dw   `01000000                                     ;; 01:7b23 $40 $00
    dw   `10000000                                     ;; 01:7b25 $80 $00
    dw   `00000000                                     ;; 01:7b27 $00 $00
    dw   `00001200                                     ;; 01:7b29 $08 $04
    dw   `00000200                                     ;; 01:7b2b $00 $04
    dw   `00000200                                     ;; 01:7b2d $00 $04
    dw   `00000210                                     ;; 01:7b2f $02 $04

    dw   `00000120                                     ;; 01:7b31 $04 $02
    dw   `00000020                                     ;; 01:7b33 $00 $02
    dw   `00000012                                     ;; 01:7b35 $02 $01
    dw   `00000000                                     ;; 01:7b37 $00 $00
    dw   `00000000                                     ;; 01:7b39 $00 $00
    dw   `00000000                                     ;; 01:7b3b $00 $00
    dw   `00000000                                     ;; 01:7b3d $00 $00
    dw   `00000000                                     ;; 01:7b3f $00 $00

    dw   `00000000                                     ;; 01:7b41 $00 $00
    dw   `00000000                                     ;; 01:7b43 $00 $00
    dw   `22222222                                     ;; 01:7b45 $00 $ff
    dw   `00000000                                     ;; 01:7b47 $00 $00
    dw   `00210000                                     ;; 01:7b49 $10 $20
    dw   `00200000                                     ;; 01:7b4b $00 $20
    dw   `00200000                                     ;; 01:7b4d $00 $20
    dw   `01200000                                     ;; 01:7b4f $40 $20

    dw   `02100000                                     ;; 01:7b51 $20 $40
    dw   `02000000                                     ;; 01:7b53 $00 $40
    dw   `21000000                                     ;; 01:7b55 $40 $80
    dw   `00000000                                     ;; 01:7b57 $00 $00
    dw   `00001300                                     ;; 01:7b59 $0c $04
    dw   `00000300                                     ;; 01:7b5b $04 $04
    dw   `00000300                                     ;; 01:7b5d $04 $04
    dw   `00000310                                     ;; 01:7b5f $06 $04

    dw   `00000130                                     ;; 01:7b61 $06 $02
    dw   `00000030                                     ;; 01:7b63 $02 $02
    dw   `00000013                                     ;; 01:7b65 $03 $01
    dw   `00000000                                     ;; 01:7b67 $00 $00
    dw   `00000000                                     ;; 01:7b69 $00 $00
    dw   `00000000                                     ;; 01:7b6b $00 $00
    dw   `00000000                                     ;; 01:7b6d $00 $00
    dw   `00000000                                     ;; 01:7b6f $00 $00

    dw   `00000000                                     ;; 01:7b71 $00 $00
    dw   `00000000                                     ;; 01:7b73 $00 $00
    dw   `33333333                                     ;; 01:7b75 $ff $ff
    dw   `00000000                                     ;; 01:7b77 $00 $00
    dw   `00310000                                     ;; 01:7b79 $30 $20
    dw   `00300000                                     ;; 01:7b7b $20 $20
    dw   `00300000                                     ;; 01:7b7d $20 $20
    dw   `01300000                                     ;; 01:7b7f $60 $20

    dw   `03100000                                     ;; 01:7b81 $60 $40
    dw   `03000000                                     ;; 01:7b83 $40 $40
    dw   `31000000                                     ;; 01:7b85 $c0 $80
    dw   `00000000                                     ;; 01:7b87 $00 $00

    db   $02, $02, $00                                 ;; 01:7b89 ...
    dw   `00000000                                     ;; 01:7b8c $00 $00
    dw   `00000000                                     ;; 01:7b8e $00 $00
    dw   `00001110                                     ;; 01:7b90 $0e $00
    dw   `00012221                                     ;; 01:7b92 $11 $0e
    dw   `00121112                                     ;; 01:7b94 $2e $11
    dw   `01213131                                     ;; 01:7b96 $5f $2a
    dw   `01213233                                     ;; 01:7b98 $5b $2f
    dw   `01332111                                     ;; 01:7b9a $77 $38

    dw   `00000000                                     ;; 01:7b9c $00 $00
    dw   `00000000                                     ;; 01:7b9e $00 $00
    dw   `10000000                                     ;; 01:7ba0 $80 $00
    dw   `21000000                                     ;; 01:7ba2 $40 $80
    dw   `12100000                                     ;; 01:7ba4 $a0 $40
    dw   `22210000                                     ;; 01:7ba6 $10 $e0
    dw   `21210000                                     ;; 01:7ba8 $50 $a0
    dw   `22221000                                     ;; 01:7baa $08 $f0

    dw   `13323332                                     ;; 01:7bac $ee $7f
    dw   `13111233                                     ;; 01:7bae $fb $47
    dw   `12311123                                     ;; 01:7bb0 $bd $63
    dw   `01332211                                     ;; 01:7bb2 $73 $3c
    dw   `00123333                                     ;; 01:7bb4 $2f $1f
    dw   `00011111                                     ;; 01:7bb6 $1f $00
    dw   `00000000                                     ;; 01:7bb8 $00 $00
    dw   `00000000                                     ;; 01:7bba $00 $00

    dw   `22222110                                     ;; 01:7bbc $06 $f8
    dw   `32222321                                     ;; 01:7bbe $85 $fe
    dw   `33333211                                     ;; 01:7bc0 $fb $fc
    dw   `11111100                                     ;; 01:7bc2 $fc $00
    dw   `33333100                                     ;; 01:7bc4 $fc $f8
    dw   `11221000                                     ;; 01:7bc6 $c8 $30
    dw   `00110000                                     ;; 01:7bc8 $30 $00
    dw   `00000000                                     ;; 01:7bca $00 $00

    db   $02, $02, $00                                 ;; 01:7bcc ...
    dw   `00000110                                     ;; 01:7bcf $06 $00
    dw   `00001221                                     ;; 01:7bd1 $09 $06
    dw   `00012321                                     ;; 01:7bd3 $15 $0e
    dw   `00013321                                     ;; 01:7bd5 $1d $0e
    dw   `01012321                                     ;; 01:7bd7 $55 $0e
    dw   `12112311                                     ;; 01:7bd9 $b7 $4c
    dw   `13211211                                     ;; 01:7bdb $db $64
    dw   `12310101                                     ;; 01:7bdd $b5 $60

    dw   `00100000                                     ;; 01:7bdf $20 $00
    dw   `01210000                                     ;; 01:7be1 $50 $20
    dw   `12321000                                     ;; 01:7be3 $a8 $70
    dw   `13321000                                     ;; 01:7be5 $e8 $70
    dw   `13210100                                     ;; 01:7be7 $d4 $60
    dw   `23211210                                     ;; 01:7be9 $5a $e4
    dw   `22112321                                     ;; 01:7beb $35 $ce
    dw   `22113310                                     ;; 01:7bed $3e $cc

    dw   `01211100                                     ;; 01:7bef $5c $20
    dw   `00112210                                     ;; 01:7bf1 $32 $0c
    dw   `00123321                                     ;; 01:7bf3 $2d $1e
    dw   `00122232                                     ;; 01:7bf5 $22 $1f
    dw   `00012222                                     ;; 01:7bf7 $10 $0f
    dw   `00001222                                     ;; 01:7bf9 $08 $07
    dw   `00000112                                     ;; 01:7bfb $06 $01
    dw   `00000001                                     ;; 01:7bfd $01 $00

    dw   `11123210                                     ;; 01:7bff $ea $1c
    dw   `00122100                                     ;; 01:7c01 $24 $18
    dw   `00011000                                     ;; 01:7c03 $18 $00
    dw   `11100000                                     ;; 01:7c05 $e0 $00
    dw   `22210000                                     ;; 01:7c07 $10 $e0
    dw   `22210000                                     ;; 01:7c09 $10 $e0
    dw   `21100000                                     ;; 01:7c0b $60 $80
    dw   `10000000                                     ;; 01:7c0d $80 $00

    db   $4d, $7c, $4d, $7c, $c5, $7c, $c5, $7c        ;; 01:7c0f ????????
    db   $3d, $7d, $b5, $7d, $4d, $7c, $2d, $7e        ;; 01:7c17 ????????
    db   $4d, $7c, $2d, $7e, $3d, $7d, $c5, $7c        ;; 01:7c1f ????????
    db   $4d, $7c, $b5, $7d, $a5, $7e, $4d, $7c        ;; 01:7c27 ????????
    db   $c5, $7c, $4d, $7c, $4d, $7c, $4d, $7c        ;; 01:7c2f ????????
    db   $4d, $7c, $b5, $7d, $a5, $7e, $3d, $7d        ;; 01:7c37 ????????
    db   $2d, $7e, $c5, $7c, $a5, $7e, $4d, $7c        ;; 01:7c3f ????????
    db   $4d, $7c, $4d, $7c, $4d, $7c, $14, $00        ;; 01:7c47 ????????
    db   $2a, $14, $14, $08, $1c, $00, $3a, $1c        ;; 01:7c4f ????????
    db   $75, $3e, $71, $3e, $79, $3e, $31, $1e        ;; 01:7c57 ????????
    db   $32, $1c, $3a, $1c, $32, $1c, $14, $08        ;; 01:7c5f ????????
    db   $14, $08, $14, $08, $08, $00, $00, $00        ;; 01:7c67 ????????
    db   $00, $00, $3c, $00, $7e, $3c, $cf, $7e        ;; 01:7c6f ????????
    db   $ff, $3c, $bd, $42, $c1, $7e, $f9, $7e        ;; 01:7c77 ????????
    db   $e1, $7e, $e1, $7e, $e1, $7e, $a1, $7e        ;; 01:7c7f ????????
    db   $42, $3c, $3c, $00, $00, $00, $00, $00        ;; 01:7c87 ????????
    db   $7f, $00, $7f, $3e, $7f, $08, $1c, $08        ;; 01:7c8f ????????
    db   $1c, $08, $7f, $00, $7d, $3e, $61, $3e        ;; 01:7c97 ????????
    db   $61, $3e, $61, $3e, $41, $3e, $61, $3e        ;; 01:7c9f ????????
    db   $41, $3e, $7f, $00, $00, $00, $00, $00        ;; 01:7ca7 ????????
    db   $00, $00, $9b, $01, $5b, $07, $00, $00        ;; 01:7caf ????????
    db   $00, $00, $1f, $00, $ff, $7f, $00, $00        ;; 01:7cb7 ????????
    db   $00, $00, $1f, $00, $ff, $7f, $00, $00        ;; 01:7cbf ????????
    db   $00, $00, $7c, $00, $ba, $7c, $7c, $fe        ;; 01:7cc7 ????????
    db   $fe, $fe, $fe, $92, $92, $fe, $7c, $ee        ;; 01:7ccf ????????
    db   $ba, $7c, $54, $28, $ba, $7c, $7c, $00        ;; 01:7cd7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7cdf ????????
    db   $00, $00, $00, $00, $3a, $7c, $7d, $fe        ;; 01:7ce7 ????????
    db   $83, $fe, $ff, $fe, $a3, $fe, $fd, $fe        ;; 01:7cef ????????
    db   $fb, $fe, $ed, $fe, $71, $fe, $00, $00        ;; 01:7cf7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7cff ????????
    db   $00, $38, $38, $7c, $7c, $fe, $fe, $92        ;; 01:7d07 ????????
    db   $92, $fe, $92, $fe, $fe, $fe, $fe, $54        ;; 01:7d0f ????????
    db   $ba, $fe, $7c, $aa, $38, $7c, $00, $38        ;; 01:7d17 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7d1f ????????
    db   $00, $00, $94, $3e, $ff, $7f, $00, $00        ;; 01:7d27 ????????
    db   $00, $00, $94, $3e, $ff, $7f, $00, $00        ;; 01:7d2f ????????
    db   $00, $00, $94, $3e, $ff, $7f, $00, $00        ;; 01:7d37 ????????
    db   $3c, $00, $42, $3c, $b1, $7e, $b1, $7e        ;; 01:7d3f ????????
    db   $81, $7e, $81, $7e, $81, $7e, $ff, $7e        ;; 01:7d47 ????????
    db   $ff, $7e, $7e, $24, $7e, $24, $7e, $24        ;; 01:7d4f ????????
    db   $7e, $24, $24, $00, $00, $00, $00, $00        ;; 01:7d57 ????????
    db   $66, $00, $ff, $66, $ff, $00, $81, $7e        ;; 01:7d5f ????????
    db   $8d, $7e, $99, $7e, $bd, $7e, $89, $7e        ;; 01:7d67 ????????
    db   $91, $7e, $81, $7e, $ff, $00, $ff, $7e        ;; 01:7d6f ????????
    db   $ff, $00, $00, $00, $00, $00, $00, $00        ;; 01:7d77 ????????
    db   $00, $00, $30, $00, $48, $30, $58, $30        ;; 01:7d7f ????????
    db   $2e, $10, $29, $16, $75, $0e, $a6, $78        ;; 01:7d87 ????????
    db   $94, $68, $6a, $04, $0d, $06, $09, $06        ;; 01:7d8f ????????
    db   $06, $00, $00, $00, $00, $00, $00, $00        ;; 01:7d97 ????????
    db   $00, $00, $1f, $00, $5a, $6b, $00, $00        ;; 01:7d9f ????????
    db   $00, $00, $1f, $00, $5a, $6b, $00, $00        ;; 01:7da7 ????????
    db   $00, $00, $1f, $00, $5a, $6b, $00, $00        ;; 01:7daf ????????
    db   $00, $00, $3f, $00, $de, $3f, $f5, $fe        ;; 01:7db7 ????????
    db   $f9, $7e, $87, $7a, $fb, $7e, $fb, $7e        ;; 01:7dbf ????????
    db   $bb, $7e, $7b, $3e, $79, $3e, $42, $3c        ;; 01:7dc7 ????????
    db   $3c, $00, $00, $00, $00, $00, $00, $00        ;; 01:7dcf ????????
    db   $00, $00, $00, $00, $00, $00, $3c, $00        ;; 01:7dd7 ????????
    db   $7e, $3c, $ff, $7e, $f1, $5e, $e5, $7e        ;; 01:7ddf ????????
    db   $81, $7e, $42, $3c, $3c, $00, $00, $00        ;; 01:7de7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7def ????????
    db   $00, $00, $38, $00, $44, $38, $ba, $7c        ;; 01:7df7 ????????
    db   $fe, $7c, $ba, $7c, $ee, $10, $f6, $7c        ;; 01:7dff ????????
    db   $f6, $7c, $b2, $6c, $7c, $38, $38, $00        ;; 01:7e07 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7e0f ????????
    db   $00, $00, $73, $4e, $de, $7b, $00, $00        ;; 01:7e17 ????????
    db   $00, $00, $12, $71, $ff, $7f, $00, $00        ;; 01:7e1f ????????
    db   $00, $00, $73, $4e, $de, $7b, $00, $00        ;; 01:7e27 ????????
    db   $00, $00, $06, $00, $0b, $06, $0e, $04        ;; 01:7e2f ????????
    db   $0e, $04, $1c, $08, $14, $08, $24, $18        ;; 01:7e37 ????????
    db   $54, $38, $6a, $3c, $e2, $7c, $d2, $7c        ;; 01:7e3f ????????
    db   $a2, $7c, $44, $38, $38, $00, $00, $00        ;; 01:7e47 ????????
    db   $24, $00, $7e, $24, $e7, $42, $ff, $42        ;; 01:7e4f ????????
    db   $c3, $7e, $ff, $7e, $ff, $7e, $db, $7e        ;; 01:7e57 ????????
    db   $bd, $5a, $5a, $3c, $7e, $3c, $5a, $3c        ;; 01:7e5f ????????
    db   $3c, $18, $24, $18, $18, $00, $38, $00        ;; 01:7e67 ????????
    db   $76, $38, $7f, $3a, $2d, $1e, $32, $1c        ;; 01:7e6f ????????
    db   $34, $18, $3c, $18, $3c, $18, $3c, $18        ;; 01:7e77 ????????
    db   $3c, $18, $3c, $18, $7c, $18, $f4, $78        ;; 01:7e7f ????????
    db   $da, $6c, $7a, $0c, $0c, $00, $00, $00        ;; 01:7e87 ????????
    db   $00, $00, $fb, $4a, $dc, $67, $00, $00        ;; 01:7e8f ????????
    db   $00, $00, $73, $4e, $de, $7b, $00, $00        ;; 01:7e97 ????????
    db   $00, $00, $fb, $4a, $dc, $67, $00, $00        ;; 01:7e9f ????????
    db   $00, $00, $10, $00, $3c, $10, $6e, $3c        ;; 01:7ea7 ????????
    db   $46, $38, $c7, $7e, $92, $6c, $c7, $7e        ;; 01:7eaf ????????
    db   $46, $38, $6e, $3c, $3c, $10, $10, $00        ;; 01:7eb7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7ebf ????????
    db   $00, $00, $18, $00, $24, $18, $42, $24        ;; 01:7ec7 ????????
    db   $ff, $00, $e9, $7e, $c1, $7e, $c1, $7e        ;; 01:7ecf ????????
    db   $c1, $7e, $81, $7e, $ff, $00, $00, $00        ;; 01:7ed7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7edf ????????
    db   $00, $00, $00, $00, $38, $00, $7c, $38        ;; 01:7ee7 ????????
    db   $ba, $7c, $d6, $38, $fe, $10, $ba, $6c        ;; 01:7eef ????????
    db   $ba, $6c, $54, $28, $38, $00, $00, $00        ;; 01:7ef7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 01:7eff ????????
    db   $00, $00, $b4, $01, $7f, $3f, $00, $00        ;; 01:7f07 ????????
    db   $6f, $00, $bf, $04, $ff, $31, $00, $00        ;; 01:7f0f ????????
    db   $00, $00, $9c, $02, $7f, $03, $00, $b4        ;; 01:7f17 ????????
    db   $01, $7f, $3f, $00, $00, $6f, $00, $bf        ;; 01:7f1f ????????
    db   $04, $ff, $31, $00, $00, $00, $00, $9c        ;; 01:7f27 ????????
    db   $02, $7f, $03                                 ;; 01:7f2f ???
