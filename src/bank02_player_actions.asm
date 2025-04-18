; Player action jump table
data_02_4120:
    dw   call_02_41a0                                 ;; 02:4120 pP
    db   $5c, $75                                      ;; 02:4122 ..
    dw   call_02_41ad                                 ;; 02:4124 pP
    db   $6d, $75                                      ;; 02:4126 ..
    dw   call_02_41b7                                 ;; 02:4128 pP
    db   $73, $75                                      ;; 02:412a ..
    dw   call_02_422b                                  ;; 02:412c pP
    db   $7c, $75                                      ;; 02:412e ..
    dw   call_02_422c                                  ;; 02:4130 pP
    db   $82, $75                                      ;; 02:4132 ..
    dw   call_02_4248                                  ;; 02:4134 pP
    db   $8f, $75                                      ;; 02:4136 ..
    dw   call_02_425a                                  ;; 02:4138 pP
    db   $9c, $75
    dw   call_02_426b
    db   $a4, $75                          
    dw   call_02_4270                                  ;; 02:4140 pP
    db   $ad, $75                                      ;; 02:4142 ..
    dw   call_02_4275                                  ;; 02:4144 pP
    db   $b3, $75                                      ;; 02:4146 ..
    dw   call_02_42ac                                  ;; 02:4148 pP
    db   $bb, $75
    dw   $42e0
    db   $c1, $75
    dw   $42e1
    db   $c7, $75                                      ;; 02:4152 ??
    dw   call_02_42f7                                  ;; 02:4154 pP
    db   $ce, $75
    dw   $434d
    db   $d9, $75
    dw   $435b
    db   $df, $75                                      ;; 02:415e ??
    dw   call_02_4371                                  ;; 02:4160 pP
    db   $e9, $75                                      ;; 02:4162 ..
    dw   call_02_437b                                  ;; 02:4164 pP
    db   $f2, $75                                      ;; 02:4166 ..
    dw   call_02_43a7                                  ;; 02:4168 pP
    db   $f9, $75
    dw   $43c6
    db   $f9, $75                  ;; 02:416a ..????
    dw   call_02_43e5                                  ;; 02:4170 pP
    db   $08, $76
    dw   $43f6
    db   $17, $76                  ;; 02:4172 ..????
    dw   call_02_4407                                  ;; 02:4178 pP
    db   $1d, $76                                      ;; 02:417a ..
    dw   call_02_4418                                  ;; 02:417c pP
    db   $2a, $76
    dw   $4443
    db   $33, $76                  ;; 02:417e ..????
    dw   call_02_4448                                  ;; 02:4184 pP
    db   $39, $76
    dw   $4459
    db   $47, $76
    dw   $447e        ;; 02:4186 ..??????
    db   $58, $76
    dw   $4483
    db   $65, $76                  ;; 02:418e ??????
    dw   call_02_44af                                  ;; 02:4194 pP
    db   $6d, $76
    dw   $481b
    db   $73, $76
    dw   $4828        ;; 02:4196 ..??????
    db   $84, $76                                      ;; 02:419e ??
    
call_02_41a0:
    ld   A, [wD209]                                    ;; 02:41a0 $fa $09 $d2
    and  A, $20                                        ;; 02:41a3 $e6 $20
    jr   Z, .jr_02_41ac                                ;; 02:41a5 $28 $05
    ld   C, $11                                        ;; 02:41a7 $0e $11
    call call_00_112f                                  ;; 02:41a9 $cd $2f $11
.jr_02_41ac:
    ret                                                ;; 02:41ac $c9
    
call_02_41ad:
    ld   A, [wD624_CurrentLevelId]                                    ;; 02:41ad $fa $24 $d6
    and  A, A                                          ;; 02:41b0 $a7
    call NZ, call_00_0634                              ;; 02:41b1 $c4 $34 $06
    jp   call_02_70f1                                    ;; 02:41b4 $c3 $f1 $70
    
call_02_41b7:
    ld   A, [wD209]                                    ;; 02:41b7 $fa $09 $d2
    and  A, $20                                        ;; 02:41ba $e6 $20
    jr   Z, .jr_02_41da                                ;; 02:41bc $28 $1c
    ld   HL, wD759                                     ;; 02:41be $21 $59 $d7
    set  6, [HL]                                       ;; 02:41c1 $cb $f6
    xor  A, A                                          ;; 02:41c3 $af
    ld   [wD75D_PlayerXSpeedPrev], A                                    ;; 02:41c4 $ea $5d $d7
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:41c7 $ea $60 $d7
    xor  A, A                                          ;; 02:41ca $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:41cb $ea $5e $d7
    call call_02_4dd8                                  ;; 02:41ce $cd $d8 $4d
    cp   A, $32                                        ;; 02:41d1 $fe $32
    jr   NC, .jr_02_41d7                               ;; 02:41d3 $30 $02
    ld   A, $32                                        ;; 02:41d5 $3e $32
.jr_02_41d7:
    ld   [wD75B_IdleTimer], A                                    ;; 02:41d7 $ea $5b $d7
.jr_02_41da:
    ld   A, [wD767_FloorTileType]                                    ;; 02:41da $fa $67 $d7
    cp   A, $08                                        ;; 02:41dd $fe $08
    jr   Z, .jr_02_41ee                                ;; 02:41df $28 $0d
    cp   A, $09                                        ;; 02:41e1 $fe $09
    jr   NZ, .jr_02_41fa                               ;; 02:41e3 $20 $15
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 02:41e5 $fa $0d $d2
    cp   A, $00                                        ;; 02:41e8 $fe $00
    jr   NZ, .jr_02_41fa                               ;; 02:41ea $20 $0e
    jr   .jr_02_41f5                                   ;; 02:41ec $18 $07
.jr_02_41ee:
    ld   A, [wD20D_PlayerFacingAngle]                                    ;; 02:41ee $fa $0d $d2
    cp   A, $20                                        ;; 02:41f1 $fe $20
    jr   NZ, .jr_02_41fa                               ;; 02:41f3 $20 $05
.jr_02_41f5:
    ld   A, $07                                        ;; 02:41f5 $3e $07
    jp   call_02_4ccd                                  ;; 02:41f7 $c3 $cd $4c
.jr_02_41fa:
    ld   HL, wD75B_IdleTimer                                     ;; 02:41fa $21 $5b $d7
    dec  [HL]                                          ;; 02:41fd $35
    ret  NZ                                            ;; 02:41fe $c0
    ld   A, $03                                        ;; 02:41ff $3e $03
    jp   call_02_4ccd                                  ;; 02:4201 $c3 $cd $4c

call_02_4204:
    ld   A, [wD74E]                                    ;; 02:4204 $fa $4e $d7
    and  A, A                                          ;; 02:4207 $a7
    jr   NZ, .jr_02_4215                               ;; 02:4208 $20 $0b
    ld   HL, wD585_CollisionFlags                                     ;; 02:420a $21 $85 $d5
    bit  6, [HL]                                       ;; 02:420d $cb $76
    jr   Z, .jr_02_4227                                ;; 02:420f $28 $16
    ld   C, $15                                        ;; 02:4211 $0e $15
    jr   .jr_02_4227                                   ;; 02:4213 $18 $12
.jr_02_4215:
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4215 $fa $5a $d7
    and  A, $30                                        ;; 02:4218 $e6 $30
    jr   Z, .jr_02_4227                                ;; 02:421a $28 $0b
    ld   C, $15                                        ;; 02:421c $0e $15
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:421e $fa $5a $d7
    and  A, $30                                        ;; 02:4221 $e6 $30
    jr   Z, .jr_02_4227                                ;; 02:4223 $28 $02
    ld   C, $16                                        ;; 02:4225 $0e $16
.jr_02_4227:
    ld   A, C                                          ;; 02:4227 $79
    jp   call_02_4ccd                                  ;; 02:4228 $c3 $cd $4c

call_02_422b:
    ret                                                ;; 02:422b $c9

call_02_422c:
    ld   A, [wD209]                                    ;; 02:422c $fa $09 $d2
    and  A, $20                                        ;; 02:422f $e6 $20
    jr   Z, .jr_02_4238                                ;; 02:4231 $28 $05
    ld   A, $01                                        ;; 02:4233 $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4235 $ea $5e $d7
.jr_02_4238:
    ld   C, $04                                        ;; 02:4238 $0e $04
    call call_02_4204                                  ;; 02:423a $cd $04 $42
    ld   A, [wD20A]                                    ;; 02:423d $fa $0a $d2
    and  A, $04                                        ;; 02:4240 $e6 $04
    ld   A, $05                                        ;; 02:4242 $3e $05
    call NZ, call_02_4ccd                              ;; 02:4244 $c4 $cd $4c
    ret                                                ;; 02:4247 $c9

call_02_4248:
    ld   A, [wD209]                                    ;; 02:4248 $fa $09 $d2
    and  A, $20                                        ;; 02:424b $e6 $20
    jr   Z, .jr_02_4254                                ;; 02:424d $28 $05
    ld   A, $02                                        ;; 02:424f $3e $02
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4251 $ea $5e $d7
.jr_02_4254:
    ld   C, $05                                        ;; 02:4254 $0e $05
    call call_02_4204                                  ;; 02:4256 $cd $04 $42
    ret                                                ;; 02:4259 $c9

call_02_425a:
    ld   A, [wD207]                                    ;; 02:425a $fa $07 $d2
    inc  A                                             ;; 02:425d $3c
    srl  A                                             ;; 02:425e $cb $3f
    ld   C, A                                          ;; 02:4260 $4f
    ld   A, $02                                        ;; 02:4261 $3e $02
    sub  A, C                                          ;; 02:4263 $91
    jr   NC, .jr_02_4267                               ;; 02:4264 $30 $01
    xor  A, A                                          ;; 02:4266 $af
.jr_02_4267:
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4267 $ea $5e $d7
    ret                                                ;; 02:426a $c9

call_02_426b:
;    db   $af, $ea, $5e, $d7, $c9                       ;; 02:426b ?????
    xor a
    ld [$d75e], a
    ret

call_02_4270:
    xor  A, A                                          ;; 02:4270 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4271 $ea $5e $d7
    ret                                                ;; 02:4274 $c9

call_02_4275:
    ld   A, [wD209]                                    ;; 02:4275 $fa $09 $d2
    and  A, $20                                        ;; 02:4278 $e6 $20
    jr   Z, .jr_02_429a                                ;; 02:427a $28 $1e
    ld   C, $2a                                        ;; 02:427c $0e $2a
    call call_02_4856                                  ;; 02:427e $cd $56 $48
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4281 $ea $60 $d7
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:4284 $ea $62 $d7
    call call_02_4a3a                                  ;; 02:4287 $cd $3a $4a
    ld   C, $0c                                        ;; 02:428a $0e $0c
    call call_00_112f                                  ;; 02:428c $cd $2f $11
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:428f $fa $5e $d7
    and  A, A                                          ;; 02:4292 $a7
    jr   NZ, .jr_02_429a                               ;; 02:4293 $20 $05
    ld   A, $01                                        ;; 02:4295 $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4297 $ea $5e $d7
.jr_02_429a:
    ld   A, [wD762_PlayerInitialYVelocity]                                    ;; 02:429a $fa $62 $d7
    and  A, A                                          ;; 02:429d $a7
    ret  NZ                                            ;; 02:429e $c0
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:429f $fa $5a $d7
    and  A, $02                                        ;; 02:42a2 $e6 $02
    ld   A, $0a                                        ;; 02:42a4 $3e $0a
    jp   NZ, call_02_4ccd                              ;; 02:42a6 $c2 $cd $4c
    jp   call_02_489a                                    ;; 02:42a9 $c3 $9a $48

call_02_42ac:
    ld   A, [wD209]                                    ;; 02:42ac $fa $09 $d2
    and  A, $20                                        ;; 02:42af $e6 $20
    jr   Z, .jr_02_42d1                                ;; 02:42b1 $28 $1e
.jr_02_42b3:
    ld   C, $36                                        ;; 02:42b3 $0e $36
    call call_02_4856                                  ;; 02:42b5 $cd $56 $48
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:42b8 $ea $60 $d7
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:42bb $ea $62 $d7
    call call_02_4a3a                                  ;; 02:42be $cd $3a $4a
    ld   C, $0d                                        ;; 02:42c1 $0e $0d
    call call_00_112f                                  ;; 02:42c3 $cd $2f $11
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:42c6 $fa $5e $d7
    and  A, A                                          ;; 02:42c9 $a7
    jr   NZ, .jr_02_42d1                               ;; 02:42ca $20 $05
    ld   A, $01                                        ;; 02:42cc $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:42ce $ea $5e $d7
.jr_02_42d1:
    ld   A, [wD762_PlayerInitialYVelocity]                                    ;; 02:42d1 $fa $62 $d7
    and  A, A                                          ;; 02:42d4 $a7
    ret  NZ                                            ;; 02:42d5 $c0
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:42d6 $fa $5a $d7
    and  A, $02                                        ;; 02:42d9 $e6 $02
    jr   NZ, .jr_02_42b3                               ;; 02:42db $20 $d6
    jp   call_02_489a                                    ;; 02:42dd $c3 $9a $48
    db   $c9, $fa, $09, $d2, $e6, $20, $28, $05        ;; 02:42e0 ????????
    db   $3e, $30, $ea, $4c, $d7, $21, $4c, $d7        ;; 02:42e8 ????????
    db   $35, $c0, $3e, $02, $c3, $cd, $4c             ;; 02:42f0 ???????

call_02_42f7:
    ld   A, [wD209]                                    ;; 02:42f7 $fa $09 $d2
    and  A, $20                                        ;; 02:42fa $e6 $20
    jr   Z, .jr_02_4313                                ;; 02:42fc $28 $15
    ld   HL, wD759                                     ;; 02:42fe $21 $59 $d7
    set  0, [HL]                                       ;; 02:4301 $cb $c6
    ld   A, $01                                        ;; 02:4303 $3e $01
    ld   [wD76B_TailSpinningFlagMaybe], A                                    ;; 02:4305 $ea $6b $d7
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:4308 $fa $5e $d7
    and  A, A                                          ;; 02:430b $a7
    jr   NZ, .jr_02_4313                               ;; 02:430c $20 $05
    ld   A, $01                                        ;; 02:430e $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4310 $ea $5e $d7
.jr_02_4313:
    ld   A, [wD764_TileTypeBehindGexsBody]                                    ;; 02:4313 $fa $64 $d7
    cpl                                                ;; 02:4316 $2f
    ld   C, A                                          ;; 02:4317 $4f
    cp   A, $40                                        ;; 02:4318 $fe $40
    call C, call_00_1f46                               ;; 02:431a $dc $46 $1f
    ld   A, [wD20A]                                    ;; 02:431d $fa $0a $d2
    and  A, $04                                        ;; 02:4320 $e6 $04
    ret  Z                                             ;; 02:4322 $c8
    xor  A, A                                          ;; 02:4323 $af
    ld   [wD76B_TailSpinningFlagMaybe], A                                    ;; 02:4324 $ea $6b $d7
    ld   HL, wD759                                     ;; 02:4327 $21 $59 $d7
    set  6, [HL]                                       ;; 02:432a $cb $f6
    ld   C, $17                                        ;; 02:432c $0e $17
    ld   HL, wD585_CollisionFlags                                     ;; 02:432e $21 $85 $d5
    bit  7, [HL]                                       ;; 02:4331 $cb $7e
    jr   Z, .jr_02_4349                                ;; 02:4333 $28 $14
    ld   C, $02                                        ;; 02:4335 $0e $02
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4337 $fa $5a $d7
    and  A, $30                                        ;; 02:433a $e6 $30
    jr   Z, .jr_02_4349                                ;; 02:433c $28 $0b
    ld   C, $05                                        ;; 02:433e $0e $05
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:4340 $fa $5e $d7
    cp   A, $02                                        ;; 02:4343 $fe $02
    jr   NC, .jr_02_4349                               ;; 02:4345 $30 $02
    ld   C, $04                                        ;; 02:4347 $0e $04
.jr_02_4349:
    ld   A, C                                          ;; 02:4349 $79
    jp   call_02_4ccd                                  ;; 02:434a $c3 $cd $4c
    db   $af, $ea, $5e, $d7, $fa, $09, $d2, $e6        ;; 02:434d ????????
    db   $20, $c8, $af, $c3, $47, $06, $fa, $09        ;; 02:4355 ????????
    db   $d2, $e6, $20, $28, $05, $0e, $10, $cd        ;; 02:435d ????????
    db   $2f, $11, $af, $ea, $5e, $d7, $3e, $77        ;; 02:4365 ????????
    db   $ea, $50, $d7, $c9                            ;; 02:436d ????

call_02_4371:
    xor  A, A                                          ;; 02:4371 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4372 $ea $5e $d7
    ld   A, $77                                        ;; 02:4375 $3e $77
    ld   [wD750], A                                    ;; 02:4377 $ea $50 $d7
    ret                                                ;; 02:437a $c9

call_02_437b:
    ld   A, [wD209]                                    ;; 02:437b $fa $09 $d2
    and  A, $20                                        ;; 02:437e $e6 $20
    jr   Z, .jr_02_438e                                ;; 02:4380 $28 $0c
    xor  A, A                                          ;; 02:4382 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4383 $ea $5e $d7
    call call_00_0f5d                                  ;; 02:4386 $cd $5d $0f
    ld   C, $0f                                        ;; 02:4389 $0e $0f
    call call_00_112f                                  ;; 02:438b $cd $2f $11
.jr_02_438e:
    ld   A, $77                                        ;; 02:438e $3e $77
    ld   [wD750], A                                    ;; 02:4390 $ea $50 $d7
    ld   A, [wD20A]                                    ;; 02:4393 $fa $0a $d2
    and  A, $04                                        ;; 02:4396 $e6 $04
    ret  Z                                             ;; 02:4398 $c8
    ld   A, $00                                        ;; 02:4399 $3e $00
    ld   [wD744], A                                    ;; 02:439b $ea $44 $d7
    ld   A, [wD621]                                    ;; 02:439e $fa $21 $d6
    or   A, $02                                        ;; 02:43a1 $f6 $02
    ld   [wD621], A                                    ;; 02:43a3 $ea $21 $d6
    ret                                                ;; 02:43a6 $c9

call_02_43a7:
    ld   A, [wD209]                                    ;; 02:43a7 $fa $09 $d2
    and  A, $20                                        ;; 02:43aa $e6 $20
    jr   Z, .jr_02_43b3                                ;; 02:43ac $28 $05
    ld   C, $11                                        ;; 02:43ae $0e $11
    call call_00_112f                                  ;; 02:43b0 $cd $2f $11
.jr_02_43b3:
    xor  A, A                                          ;; 02:43b3 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:43b4 $ea $5e $d7
    ld   HL, wD20A                                     ;; 02:43b7 $21 $0a $d2
    bit  2, [HL]                                       ;; 02:43ba $cb $56
    ret  Z                                             ;; 02:43bc $c8
    ld   A, [wD621]                                    ;; 02:43bd $fa $21 $d6
    or   A, $04                                        ;; 02:43c0 $f6 $04
    ld   [wD621], A                                    ;; 02:43c2 $ea $21 $d6
    ret                                                ;; 02:43c5 $c9
    db   $fa, $09, $d2, $e6, $20, $28, $05, $0e        ;; 02:43c6 ????????
    db   $11, $cd, $2f, $11, $af, $ea, $5e, $d7        ;; 02:43ce ????????
    db   $fa, $0a, $d2, $e6, $04, $c8, $fa, $21        ;; 02:43d6 ????????
    db   $d6, $f6, $04, $ea, $21, $d6, $c9             ;; 02:43de ???????

call_02_43e5:
    ld   A, [wD209]                                    ;; 02:43e5 $fa $09 $d2
    and  A, $20                                        ;; 02:43e8 $e6 $20
    jr   Z, .jr_02_43f1                                ;; 02:43ea $28 $05
    ld   C, $11                                        ;; 02:43ec $0e $11
    call call_00_112f                                  ;; 02:43ee $cd $2f $11
.jr_02_43f1:
    xor  A, A                                          ;; 02:43f1 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:43f2 $ea $5e $d7
    ret                                                ;; 02:43f5 $c9
    db   $fa, $09, $d2, $e6, $20, $28, $05, $3e        ;; 02:43f6 ????????
    db   $01, $ea, $5e, $d7, $0e, $02, $c3, $04        ;; 02:43fe ????????
    db   $42                                           ;; 02:4406 ?

call_02_4407:
    ld   A, [wD209]                                    ;; 02:4407 $fa $09 $d2
    and  A, $20                                        ;; 02:440a $e6 $20
    jr   Z, .jr_02_4413                                ;; 02:440c $28 $05
    ld   A, $01                                        ;; 02:440e $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4410 $ea $5e $d7
.jr_02_4413:
    ld   C, $02                                        ;; 02:4413 $0e $02
    jp   call_02_4204                                  ;; 02:4415 $c3 $04 $42

call_02_4418:
    ld   A, [wD209]                                    ;; 02:4418 $fa $09 $d2
    and  A, $20                                        ;; 02:441b $e6 $20
    jr   Z, .jr_02_442f                                ;; 02:441d $28 $10
    ld   A, $01                                        ;; 02:441f $3e $01
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:4421 $ea $62 $d7
    ld   A, [wD75E_PlayerXSpeed]                                    ;; 02:4424 $fa $5e $d7
    and  A, A                                          ;; 02:4427 $a7
    jr   NZ, .jr_02_442f                               ;; 02:4428 $20 $05
    ld   A, $01                                        ;; 02:442a $3e $01
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:442c $ea $5e $d7
.jr_02_442f:
    ld   A, [wD762_PlayerInitialYVelocity]                                    ;; 02:442f $fa $62 $d7
    and  A, A                                          ;; 02:4432 $a7
    ret  NZ                                            ;; 02:4433 $c0
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4434 $fa $5a $d7
    and  A, $30                                        ;; 02:4437 $e6 $30
    ld   A, $04                                        ;; 02:4439 $3e $04
    jp   NZ, call_02_4ccd                              ;; 02:443b $c2 $cd $4c
    ld   A, $02                                        ;; 02:443e $3e $02
    jp   call_02_4ccd                                  ;; 02:4440 $c3 $cd $4c
    db   $af, $ea, $5e, $d7, $c9                       ;; 02:4443 ?????

call_02_4448:
    ld   A, [wD209]                                    ;; 02:4448 $fa $09 $d2
    and  A, $20                                        ;; 02:444b $e6 $20
    jr   Z, .jr_02_4454                                ;; 02:444d $28 $05
    ld   C, $0e                                        ;; 02:444f $0e $0e
    call call_00_112f                                  ;; 02:4451 $cd $2f $11
.jr_02_4454:
    xor  A, A                                          ;; 02:4454 $af
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:4455 $ea $5e $d7
    ret                                                ;; 02:4458 $c9
    db   $fa, $09, $d2, $e6, $20, $28, $05, $3e        ;; 02:4459 ????????
    db   $00, $cd, $b7, $48, $af, $ea, $5e, $d7        ;; 02:4461 ????????
    db   $cd, $94, $48, $c8, $fa, $21, $d6, $f6        ;; 02:4469 ????????
    db   $08, $ea, $21, $d6, $3e, $1b, $ea, $44        ;; 02:4471 ????????
    db   $d7, $cd, $f0, $38, $c9, $af, $ea, $5e        ;; 02:4479 ????????
    db   $d7, $c9, $fa, $09, $d2, $e6, $20, $28        ;; 02:4481 ????????
    db   $1b, $0e, $12, $cd, $2f, $11, $cd, $bf        ;; 02:4489 ????????
    db   $06, $3e, $50, $ea, $60, $d7, $ea, $62        ;; 02:4491 ????????
    db   $d7, $fa, $5e, $d7, $a7, $20, $05, $3e        ;; 02:4499 ????????
    db   $01, $ea, $5e, $d7, $fa, $62, $d7, $a7        ;; 02:44a1 ????????
    db   $c0, $3e, $02, $c3, $cd, $4c                  ;; 02:44a9 ??????

call_02_44af:
    ld   A, [wD209]                                    ;; 02:44af $fa $09 $d2
    and  A, $20                                        ;; 02:44b2 $e6 $20
    jr   Z, .jr_02_44d6                                ;; 02:44b4 $28 $20
    ld   HL, wD759                                     ;; 02:44b6 $21 $59 $d7
    set  6, [HL]                                       ;; 02:44b9 $cb $f6
    xor  A, A                                          ;; 02:44bb $af
    ld   [wD747], A                                    ;; 02:44bc $ea $47 $d7
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:44bf $ea $5e $d7
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:44c2 $ea $60 $d7
    ld   [wD761_PlayerFallingFlag], A                                    ;; 02:44c5 $ea $61 $d7
    ld   A, [wD769]                                    ;; 02:44c8 $fa $69 $d7
    cp   A, $26                                        ;; 02:44cb $fe $26
    ld   A, $00                                        ;; 02:44cd $3e $00
    jr   Z, .jr_02_44d3                                ;; 02:44cf $28 $02
    ld   A, $02                                        ;; 02:44d1 $3e $02
.jr_02_44d3:
    ld   [wD746_PlayerClimbingState], A                                    ;; 02:44d3 $ea $46 $d7
.jr_02_44d6:
    ld   HL, wD746_PlayerClimbingState                                     ;; 02:44d6 $21 $46 $d7
    ld   L, [HL]                                       ;; 02:44d9 $6e
    ld   H, $00                                        ;; 02:44da $26 $00
    add  HL, HL                                        ;; 02:44dc $29
    ld   DE, .data_02_44e5                             ;; 02:44dd $11 $e5 $44
    add  HL, DE                                        ;; 02:44e0 $19
    ld   A, [HL+]                                      ;; 02:44e1 $2a
    ld   H, [HL]                                       ;; 02:44e2 $66
    ld   L, A                                          ;; 02:44e3 $6f
    jp   HL                                            ;; 02:44e4 $e9
.data_02_44e5:
    dw   call_02_44f9                                 ;; 02:44e5 pP
    db   $5f, $45, $b0, $45, $26, $46, $b0, $45        ;; 02:44e7 ????????
    db   $26, $46                                      ;; 02:44ef ??
    dw   call_02_4667                                 ;; 02:44f1 pP
    db   $8f, $46, $b3, $46, $b8, $46                  ;; 02:44f3 ??????

call_02_44f9:
    call call_02_4777                                  ;; 02:44f9 $cd $77 $47
    cp   A, $ff                                        ;; 02:44fc $fe $ff
    jr   Z, .jr_02_4531                                ;; 02:44fe $28 $31
    ld   [wD748], A                                    ;; 02:4500 $ea $48 $d7
    ld   E, A                                          ;; 02:4503 $5f
    ld   D, $00                                        ;; 02:4504 $16 $00
    ld   HL, .data_02_4557                             ;; 02:4506 $21 $57 $45
    add  HL, DE                                        ;; 02:4509 $19
    ld   A, [HL]                                       ;; 02:450a $7e
    and  A, $20                                        ;; 02:450b $e6 $20
    ld   [wD20D_PlayerFacingAngle], A                                    ;; 02:450d $ea $0d $d2
    ld   A, [HL]                                       ;; 02:4510 $7e
    and  A, $40                                        ;; 02:4511 $e6 $40
    ld   [wD74B], A                                    ;; 02:4513 $ea $4b $d7
    ld   HL, .data_02_454f                             ;; 02:4516 $21 $4f $45
    add  HL, DE                                        ;; 02:4519 $19
    ld   C, [HL]                                       ;; 02:451a $4e
    ld   HL, wD747                                     ;; 02:451b $21 $47 $d7
    inc  [HL]                                          ;; 02:451e $34
    ld   A, [HL]                                       ;; 02:451f $7e
    rrca                                               ;; 02:4520 $0f
    rrca                                               ;; 02:4521 $0f
    and  A, $07                                        ;; 02:4522 $e6 $07
    add  A, C                                          ;; 02:4524 $81
    ld   HL, wD208_PlayerSpriteIndex                                     ;; 02:4525 $21 $08 $d2
    cp   A, [HL]                                       ;; 02:4528 $be
    jr   Z, .jr_02_4531                                ;; 02:4529 $28 $06
    ld   [HL], A                                       ;; 02:452b $77
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:452c $21 $0f $d6
    set  0, [HL]                                       ;; 02:452f $cb $c6
.jr_02_4531:
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4531 $fa $5a $d7
    and  A, $02                                        ;; 02:4534 $e6 $02
    jr   Z, .jr_02_453d                                ;; 02:4536 $28 $05
    ld   A, $17                                        ;; 02:4538 $3e $17
    call call_02_4ccd                                  ;; 02:453a $cd $cd $4c
.jr_02_453d:
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:453d $fa $5a $d7
    and  A, $01                                        ;; 02:4540 $e6 $01
    jr   Z, .jr_02_454e                                ;; 02:4542 $28 $0a
    ld   A, $01                                        ;; 02:4544 $3e $01
    ld   [wD746_PlayerClimbingState], A                                    ;; 02:4546 $ea $46 $d7
    xor  A, A                                          ;; 02:4549 $af
    ld   [wD747], A                                    ;; 02:454a $ea $47 $d7
    ret                                                ;; 02:454d $c9
.jr_02_454e:
    ret                                                ;; 02:454e $c9
.data_02_454f:
    db   $40, $50, $48, $97, $40, $50, $48, $97        ;; 02:454f ........
.data_02_4557:
    db   $00, $00, $00, $00, $60, $60, $60, $60        ;; 02:4557 ........
    db   $cd, $77, $47, $fe, $ff, $28, $03, $ea        ;; 02:455f ????????
    db   $48, $d7, $21, $47, $d7, $34, $7e, $0f        ;; 02:4567 ????????
    db   $0f, $e6, $07, $4f, $21, $48, $d7, $6e        ;; 02:456f ????????
    db   $26, $00, $11, $a8, $45, $19, $7e, $81        ;; 02:4577 ????????
    db   $e6, $07, $c6, $58, $21, $08, $d2, $be        ;; 02:457f ????????
    db   $c8, $77, $3e, $00, $ea, $0d, $d2, $3e        ;; 02:4587 ????????
    db   $00, $ea, $4b, $d7, $21, $0f, $d6, $cb        ;; 02:458f ????????
    db   $c6, $fa, $47, $d7, $fe, $20, $d8, $3e        ;; 02:4597 ????????
    db   $00, $ea, $46, $d7, $af, $ea, $47, $d7        ;; 02:459f ????????
    db   $c9, $00, $07, $06, $05, $04, $03, $02        ;; 02:45a7 ????????
    db   $01, $cd, $d5, $47, $fe, $ff, $28, $39        ;; 02:45af ????????
    db   $ea, $48, $d7, $5f, $16, $00, $21, $0e        ;; 02:45b7 ????????
    db   $46, $19, $7e, $fe, $ff, $28, $03, $ea        ;; 02:45bf ????????
    db   $0d, $d2, $21, $16, $46, $19, $7e, $fe        ;; 02:45c7 ????????
    db   $ff, $28, $03, $ea, $4b, $d7, $21, $1e        ;; 02:45cf ????????
    db   $46, $19, $4e, $21, $47, $d7, $34, $7e        ;; 02:45d7 ????????
    db   $0f, $0f, $e6, $07, $81, $21, $08, $d2        ;; 02:45df ????????
    db   $be, $28, $06, $77, $21, $0f, $d6, $cb        ;; 02:45e7 ????????
    db   $c6, $fa, $5a, $d7, $e6, $02, $28, $05        ;; 02:45ef ????????
    db   $3e, $17, $cd, $cd, $4c, $fa, $5a, $d7        ;; 02:45f7 ????????
    db   $e6, $01, $28, $0a, $3e, $03, $ea, $46        ;; 02:45ff ????????
    db   $d7, $af, $ea, $47, $d7, $c9, $c9, $ff        ;; 02:4607 ????????
    db   $00, $00, $00, $ff, $20, $20, $20, $00        ;; 02:460f ????????
    db   $00, $00, $40, $40, $40, $00, $00, $60        ;; 02:4617 ????????
    db   $60, $68, $60, $60, $60, $68, $60, $cd        ;; 02:461f ????????
    db   $d5, $47, $fe, $ff, $28, $03, $ea, $48        ;; 02:4627 ????????
    db   $d7, $21, $47, $d7, $34, $7e, $0f, $0f        ;; 02:462f ????????
    db   $e6, $07, $21, $48, $d7, $6e, $26, $00        ;; 02:4637 ????????
    db   $11, $5f, $46, $19, $86, $21, $08, $d2        ;; 02:463f ????????
    db   $be, $c8, $77, $21, $0f, $d6, $cb, $c6        ;; 02:4647 ????????
    db   $fa, $47, $d7, $fe, $20, $d8, $3e, $02        ;; 02:464f ????????
    db   $ea, $46, $d7, $af, $ea, $47, $d7, $c9        ;; 02:4657 ????????
    db   $70, $00, $78, $00, $70, $00, $78, $00        ;; 02:465f ????????

call_02_4667:
    ld   A, $00                                        ;; 02:4667 $3e $00
    ld   [wD74B], A                                    ;; 02:4669 $ea $4b $d7
    ld   HL, wD747                                     ;; 02:466c $21 $47 $d7
    ld   A, [HL]                                       ;; 02:466f $7e
    cp   A, $18                                        ;; 02:4670 $fe $18
    jr   Z, .jr_02_4684                                ;; 02:4672 $28 $10
    inc  [HL]                                          ;; 02:4674 $34
    srl  A                                             ;; 02:4675 $cb $3f
    srl  A                                             ;; 02:4677 $cb $3f
    ld   L, A                                          ;; 02:4679 $6f
    ld   H, $00                                        ;; 02:467a $26 $00
    ld   DE, .data_02_4689                             ;; 02:467c $11 $89 $46
    add  HL, DE                                        ;; 02:467f $19
    ld   A, [HL]                                       ;; 02:4680 $7e
    jp   call_02_480f                                    ;; 02:4681 $c3 $0f $48
.jr_02_4684:
    ld   A, $02                                        ;; 02:4684 $3e $02
    jp   call_02_4ccd                                  ;; 02:4686 $c3 $cd $4c
.data_02_4689:
    db   $c2, $c3, $c4, $c5, $c6, $c7, $3e, $00        ;; 02:4689 ......??
    db   $ea, $4b, $d7, $21, $47, $d7, $7e, $fe        ;; 02:4691 ????????
    db   $08, $28, $10, $34, $cb, $3f, $cb, $3f        ;; 02:4699 ????????
    db   $6f, $26, $00, $11, $b1, $46, $19, $7e        ;; 02:46a1 ????????
    db   $c3, $0f, $48, $3e, $02, $c3, $cd, $4c        ;; 02:46a9 ????????
    db   $c8, $c9, $3e, $09, $c3, $cd, $4c, $fa        ;; 02:46b1 ????????
    db   $3c, $d7, $e6, $1f, $c0, $fa, $49, $d7        ;; 02:46b9 ????????
    db   $87, $87, $21, $0d, $d2, $cb, $6e, $28        ;; 02:46c1 ????????
    db   $02, $c6, $02, $87, $6f, $26, $00, $11        ;; 02:46c9 ????????
    db   $37, $47, $19, $4e, $23, $46, $23, $c5        ;; 02:46d1 ????????
    db   $4e, $23, $46, $cd, $19, $4c, $c1, $cd        ;; 02:46d9 ????????
    db   $0a, $4c, $fa, $47, $d7, $cb, $3f, $6f        ;; 02:46e1 ????????
    db   $26, $00, $11, $2e, $47, $19, $7e, $cd        ;; 02:46e9 ????????
    db   $0f, $48, $3e, $00, $ea, $4b, $d7, $21        ;; 02:46f1 ????????
    db   $47, $d7, $34, $7e, $fe, $11, $c0, $36        ;; 02:46f9 ????????
    db   $00, $fa, $49, $d7, $87, $87, $87, $21        ;; 02:4701 ????????
    db   $0d, $d2, $cb, $6e, $28, $02, $c6, $04        ;; 02:4709 ????????
    db   $6f, $26, $00, $11, $57, $47, $19, $2a        ;; 02:4711 ????????
    db   $ea, $46, $d7, $2a, $ea, $0d, $d2, $2a        ;; 02:4719 ????????
    db   $ea, $4b, $d7, $2a, $ea, $08, $d2, $21        ;; 02:4721 ????????
    db   $0f, $d6, $cb, $c6, $c9, $08, $ca, $cb        ;; 02:4729 ????????
    db   $cc, $cd, $ce, $cf, $d0, $d0, $00, $00        ;; 02:4731 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4739 ????????
    db   $00, $00, $00, $00, $00, $00, $01, $00        ;; 02:4741 ????????
    db   $01, $00, $ff, $ff, $ff, $ff, $01, $00        ;; 02:4749 ????????
    db   $ff, $ff, $ff, $ff, $01, $00, $00, $00        ;; 02:4751 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4759 ????????
    db   $00, $00, $00, $00, $00, $00, $04, $00        ;; 02:4761 ????????
    db   $00, $68, $02, $00, $00, $60, $02, $20        ;; 02:4769 ????????
    db   $00, $60, $04, $20, $00, $68                  ;; 02:4771 ??????

call_02_4777:
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4777 $fa $5a $d7
    and  A, $f0                                        ;; 02:477a $e6 $f0
    jr   Z, .jr_02_478d                                ;; 02:477c $28 $0f
    ld   HL, .data_02_47a5                             ;; 02:477e $21 $a5 $47
    ld   DE, $06                                       ;; 02:4781 $11 $06 $00
    ld   B, $08                                        ;; 02:4784 $06 $08
.jr_02_4786:
    cp   A, [HL]                                       ;; 02:4786 $be
    jr   Z, .jr_02_4790                                ;; 02:4787 $28 $07
    add  HL, DE                                        ;; 02:4789 $19
    dec  B                                             ;; 02:478a $05
    jr   NZ, .jr_02_4786                               ;; 02:478b $20 $f9
.jr_02_478d:
    ld   A, $ff                                        ;; 02:478d $3e $ff
    ret                                                ;; 02:478f $c9
.jr_02_4790:
    inc  HL                                            ;; 02:4790 $23
    ld   A, [HL+]                                      ;; 02:4791 $2a
    push AF                                            ;; 02:4792 $f5
    ld   A, [HL+]                                      ;; 02:4793 $2a
    ld   C, A                                          ;; 02:4794 $4f
    ld   A, [HL+]                                      ;; 02:4795 $2a
    ld   B, A                                          ;; 02:4796 $47
    push BC                                            ;; 02:4797 $c5
    ld   A, [HL+]                                      ;; 02:4798 $2a
    ld   C, A                                          ;; 02:4799 $4f
    ld   A, [HL+]                                      ;; 02:479a $2a
    ld   B, A                                          ;; 02:479b $47
    call call_02_4c19_UpdatePlayerYPosition                                  ;; 02:479c $cd $19 $4c
    pop  BC                                            ;; 02:479f $c1
    call call_02_4c0a_UpdatePlayerXPosition                                  ;; 02:47a0 $cd $0a $4c
    pop  AF                                            ;; 02:47a3 $f1
    ret                                                ;; 02:47a4 $c9
.data_02_47a5:
    db   $40, $00, $00, $00, $ff, $ff, $80, $04        ;; 02:47a5 ?w....?w
    db   $00, $00, $01, $00, $20, $06, $ff, $ff        ;; 02:47ad ....?w..
    db   $00, $00, $10, $02, $01, $00, $00, $00        ;; 02:47b5 ..?w....
    db   $60, $07, $ff, $ff, $ff, $ff, $a0, $05        ;; 02:47bd ?w....?w
    db   $ff, $ff, $01, $00, $50, $01, $01, $00        ;; 02:47c5 ....?w..
    db   $ff, $ff, $90, $03, $01, $00, $01, $00        ;; 02:47cd ..?w....
    db   $fa, $5a, $d7, $e6, $c0, $28, $0f, $21        ;; 02:47d5 ????????
    db   $03, $48, $11, $06, $00, $06, $02, $be        ;; 02:47dd ????????
    db   $28, $07, $19, $05, $20, $f9, $3e, $ff        ;; 02:47e5 ????????
    db   $c9, $23, $2a, $f5, $2a, $4f, $2a, $47        ;; 02:47ed ????????
    db   $c5, $2a, $4f, $2a, $47, $cd, $19, $4c        ;; 02:47f5 ????????
    db   $c1, $cd, $0a, $4c, $f1, $c9, $40, $00        ;; 02:47fd ????????
    db   $00, $00, $ff, $ff, $80, $04, $00, $00        ;; 02:4805 ????????
    db   $01, $00                                      ;; 02:480d ??

call_02_480f:
    ld   HL, wD208_PlayerSpriteIndex                                     ;; 02:480f $21 $08 $d2
    cp   A, [HL]                                       ;; 02:4812 $be
    ret  Z                                             ;; 02:4813 $c8
    ld   [HL], A                                       ;; 02:4814 $77
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:4815 $21 $0f $d6
    set  0, [HL]                                       ;; 02:4818 $cb $c6
    ret                                                ;; 02:481a $c9
    db   $cd, $94, $48, $c8, $fa, $21, $d6, $f6        ;; 02:481b ????????
    db   $04, $ea, $21, $d6, $c9, $af, $ea, $5e        ;; 02:4823 ????????
    db   $d7, $26, $d2, $3e, $20, $6f, $7e, $fe        ;; 02:482b ????????
    db   $31, $28, $06, $7d, $c6, $20, $20, $f5        ;; 02:4833 ????????
    db   $c9, $7d, $f6, $10, $6f, $2a, $66, $6f        ;; 02:483b ????????
    db   $ea, $10, $d2, $7c, $ea, $11, $d2, $29        ;; 02:4843 ????????
    db   $29, $29, $7c, $fe, $55, $d0, $3e, $09        ;; 02:484b ????????
    db   $c3, $cd, $4c                                 ;; 02:4853 ???
    
call_02_4856:
    ld   A, [wD758]                                    ;; 02:4856 $fa $58 $d7
    and  A, A                                          ;; 02:4859 $a7
    ret  NZ                                            ;; 02:485a $c0
    ld   A, [wD765_TileTypeBehindGexsBody]                                    ;; 02:485b $fa $65 $d7
    cp   A, $f0                                        ;; 02:485e $fe $f0
    jr   Z, .jr_02_4876                                ;; 02:4860 $28 $14
    cp   A, $f1                                        ;; 02:4862 $fe $f1
    jr   Z, .jr_02_4885                                ;; 02:4864 $28 $1f
    cp   A, $ce                                        ;; 02:4866 $fe $ce
    jr   Z, .jr_02_4870                                ;; 02:4868 $28 $06
    cp   A, $cf                                        ;; 02:486a $fe $cf
    jr   Z, .jr_02_4873                                ;; 02:486c $28 $05
.jr_02_486e:
    ld   A, C                                          ;; 02:486e $79
    ret                                                ;; 02:486f $c9
.jr_02_4870:
    ld   A, $4c                                        ;; 02:4870 $3e $4c
    ret                                                ;; 02:4872 $c9
.jr_02_4873:
    ld   A, $60                                        ;; 02:4873 $3e $60
    ret                                                ;; 02:4875 $c9
.jr_02_4876:
    ld   HL, wD751                                     ;; 02:4876 $21 $51 $d7
    ld   A, [HL+]                                      ;; 02:4879 $2a
    or   A, [HL]                                       ;; 02:487a $b6
    jr   Z, .jr_02_486e                                ;; 02:487b $28 $f1
    ld   C, $2a                                        ;; 02:487d $0e $2a
    call call_00_112f                                  ;; 02:487f $cd $2f $11
    ld   A, $4c                                        ;; 02:4882 $3e $4c
    ret                                                ;; 02:4884 $c9
.jr_02_4885:
    ld   HL, wD751                                     ;; 02:4885 $21 $51 $d7
    ld   A, [HL+]                                      ;; 02:4888 $2a
    or   A, [HL]                                       ;; 02:4889 $b6
    jr   Z, .jr_02_486e                                ;; 02:488a $28 $e2
    ld   C, $2a                                        ;; 02:488c $0e $2a
    call call_00_112f                                  ;; 02:488e $cd $2f $11
    ld   A, $60                                        ;; 02:4891 $3e $60
    ret                                                ;; 02:4893 $c9
    db   $fa, $0a, $d2, $e6, $04, $c9                  ;; 02:4894 ??????
    