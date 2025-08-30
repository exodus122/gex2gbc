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
    ld   [wD6E5_PasswordArrowSprites], A                                    ;; 01:4ef8 $ea $e5 $d6
    ld   A, H                                          ;; 01:4efb $7c
    ld   [wD6E6_PasswordArrowSprites], A                                    ;; 01:4efc $ea $e6 $d6
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
    ld   [wD6E7_PasswordArrowSprites], A                                    ;; 01:4f0e $ea $e7 $d6
    ld   A, H                                          ;; 01:4f11 $7c
    ld   [wD6E8_PasswordArrowSprites], A                                    ;; 01:4f12 $ea $e8 $d6
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
    ld   HL, wD667_PasswordExitButton                                     ;; 01:4f2a $21 $67 $d6
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

entry_01_4f87_LoadEnterPasswordMenu:
call_01_4f87_LoadEnterPasswordMenu:
    ld   HL, wD667_PasswordExitButton                                     ;; 01:4f87 $21 $67 $d6
    ld   DE, wD668_PasswordValues                                     ;; 01:4f8a $11 $68 $d6
    ld   BC, $1d                                       ;; 01:4f8d $01 $1d $00
    ld   [HL], $20                                     ;; 01:4f90 $36 $20
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 01:4f92 $cd $b0 $07
    ld   A, $49                                        ;; 01:4f95 $3e $49
    ld   [wD667_PasswordExitButton], A                                    ;; 01:4f97 $ea $67 $d6
    ld   A, $4a                                        ;; 01:4f9a $3e $4a
    ld   [wD684_PasswordGoButton], A                                    ;; 01:4f9c $ea $84 $d6
    ld   A, $4b                                        ;; 01:4f9f $3e $4b
    ld   [wD685], A                                    ;; 01:4fa1 $ea $85 $d6
    ret                                                ;; 01:4fa4 $c9

call_01_4fa5_SetupPassword:
    ld   HL, wD667_PasswordExitButton                                     ;; 01:4fa5 $21 $67 $d6
    ld   DE, wD668_PasswordValues                                     ;; 01:4fa8 $11 $68 $d6
    ld   BC, $1d                                       ;; 01:4fab $01 $1d $00
    ld   [HL], $00                                     ;; 01:4fae $36 $00
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 01:4fb0 $cd $b0 $07
    ld   A, $49                                        ;; 01:4fb3 $3e $49
    ld   [wD667_PasswordExitButton], A                                    ;; 01:4fb5 $ea $67 $d6
    ld   A, $4a                                        ;; 01:4fb8 $3e $4a
    ld   [wD684_PasswordGoButton], A                                    ;; 01:4fba $ea $84 $d6
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
    ld   HL, wD668_PasswordValues                                     ;; 01:4fe2 $21 $68 $d6
    ld   B, $1c                                        ;; 01:4fe5 $06 $1c
.jr_01_4fe7:
    ld   A, [HL]                                       ;; 01:4fe7 $7e
    add  A, $41                                        ;; 01:4fe8 $c6 $41
    ld   [HL+], A                                      ;; 01:4fea $22
    dec  B                                             ;; 01:4feb $05
    jr   NZ, .jr_01_4fe7                               ;; 01:4fec $20 $f9
    ret                                                ;; 01:4fee $c9
.data_01_4fef: ; this is used to encode the password to and from the bitmap
    dw   $d652, $0080, $d668, $0004        ;; 01:4fef ????????
    dw   $d652, $0040, $d668, $0002        ;; 01:4ff7 ????????
    dw   $d652, $0020, $d668, $0001        ;; 01:4fff ????????
    dw   $d652, $0010, $d669, $0004        ;; 01:5007 ????????
    dw   $d652, $0008, $d669, $0002        ;; 01:500f ????????
    dw   $d652, $0004, $d669, $0001        ;; 01:5017 ????????
    dw   $d652, $0002, $d66a, $0004        ;; 01:501f ????????
    dw   $d652, $0001, $d66a, $0002        ;; 01:5027 ????????
    dw   $d653, $0080, $d66a, $0001        ;; 01:502f ????????
    dw   $d653, $0040, $d66b, $0004        ;; 01:5037 ????????
    dw   $d653, $0020, $d66b, $0002        ;; 01:503f ????????
    dw   $d653, $0010, $d66b, $0001        ;; 01:5047 ????????
    dw   $d653, $0008, $d66c, $0004        ;; 01:504f ????????
    dw   $d653, $0004, $d66c, $0002        ;; 01:5057 ????????
    dw   $d653, $0002, $d66c, $0001        ;; 01:505f ????????
    dw   $d653, $0001, $d66d, $0004        ;; 01:5067 ????????
    dw   $d654, $0080, $d66d, $0002        ;; 01:506f ????????
    dw   $d654, $0040, $d66d, $0001        ;; 01:5077 ????????
    dw   $d654, $0020, $d66e, $0004        ;; 01:507f ????????
    dw   $d654, $0010, $d66e, $0002        ;; 01:5087 ????????
    dw   $d654, $0008, $d66e, $0001        ;; 01:508f ????????
    dw   $d654, $0004, $d66f, $0004        ;; 01:5097 ????????
    dw   $d654, $0002, $d66f, $0002        ;; 01:509f ????????
    dw   $d654, $0001, $d66f, $0001        ;; 01:50a7 ????????
    dw   $d655, $0080, $d670, $0004        ;; 01:50af ????????
    dw   $d655, $0040, $d670, $0002        ;; 01:50b7 ????????
    dw   $d655, $0020, $d670, $0001        ;; 01:50bf ????????
    dw   $d655, $0010, $d671, $0004        ;; 01:50c7 ????????
    dw   $d655, $0008, $d671, $0002        ;; 01:50cf ????????
    dw   $d655, $0004, $d671, $0001        ;; 01:50d7 ????????
    dw   $d655, $0002, $d672, $0004        ;; 01:50df ????????
    dw   $d655, $0001, $d672, $0002        ;; 01:50e7 ????????
    dw   $d656, $0080, $d672, $0001        ;; 01:50ef ????????
    dw   $d656, $0040, $d673, $0004        ;; 01:50f7 ????????
    dw   $d656, $0020, $d673, $0002        ;; 01:50ff ????????
    dw   $d656, $0010, $d673, $0001        ;; 01:5107 ????????
    dw   $d656, $0008, $d674, $0004        ;; 01:510f ????????
    dw   $d656, $0004, $d674, $0002        ;; 01:5117 ????????
    dw   $d656, $0002, $d674, $0001        ;; 01:511f ????????
    dw   $d656, $0001, $d675, $0004        ;; 01:5127 ????????
    dw   $d657, $0080, $d675, $0002        ;; 01:512f ????????
    dw   $d657, $0040, $d675, $0001        ;; 01:5137 ????????
    dw   $d657, $0020, $d676, $0004        ;; 01:513f ????????
    dw   $d657, $0010, $d676, $0002        ;; 01:5147 ????????
    dw   $d657, $0008, $d676, $0001        ;; 01:514f ????????
    dw   $d657, $0004, $d677, $0004        ;; 01:5157 ????????
    dw   $d657, $0002, $d677, $0002        ;; 01:515f ????????
    dw   $d657, $0001, $d677, $0001        ;; 01:5167 ????????
    dw   $d658, $0080, $d678, $0004        ;; 01:516f ????????
    dw   $d658, $0040, $d678, $0002        ;; 01:5177 ????????
    dw   $d658, $0020, $d678, $0001        ;; 01:517f ????????
    dw   $d658, $0010, $d679, $0004        ;; 01:5187 ????????
    dw   $d658, $0008, $d679, $0002        ;; 01:518f ????????
    dw   $d658, $0004, $d679, $0001        ;; 01:5197 ????????
    dw   $d658, $0002, $d67a, $0004        ;; 01:519f ????????
    dw   $d658, $0001, $d67a, $0002        ;; 01:51a7 ????????
    dw   $d659, $0080, $d67a, $0001        ;; 01:51af ????????
    dw   $d659, $0040, $d67b, $0004        ;; 01:51b7 ????????
    dw   $d659, $0020, $d67b, $0002        ;; 01:51bf ????????
    dw   $d659, $0010, $d67b, $0001        ;; 01:51c7 ????????
    dw   $d659, $0008, $d67c, $0004        ;; 01:51cf ????????
    dw   $d659, $0004, $d67c, $0002        ;; 01:51d7 ????????
    dw   $d659, $0002, $d67c, $0001        ;; 01:51df ????????
    dw   $d659, $0001, $d67d, $0004        ;; 01:51e7 ????????
    dw   $d65a, $0080, $d67d, $0002        ;; 01:51ef ????????
    dw   $d65a, $0040, $d67d, $0001        ;; 01:51f7 ????????
    dw   $d65a, $0020, $d67e, $0004        ;; 01:51ff ????????
    dw   $d65a, $0010, $d67e, $0002        ;; 01:5207 ????????
    dw   $d65a, $0008, $d67e, $0001        ;; 01:520f ????????
    dw   $d65a, $0004, $d67f, $0004        ;; 01:5217 ????????
    dw   $d65a, $0002, $d67f, $0002        ;; 01:521f ????????
    dw   $d65a, $0001, $d67f, $0001        ;; 01:5227 ????????
    dw   $d65b, $0080, $d680, $0004        ;; 01:522f ????????
    dw   $d65b, $0040, $d680, $0002        ;; 01:5237 ????????
    dw   $d65b, $0020, $d680, $0001        ;; 01:523f ????????
    dw   $d65b, $0010, $d681, $0004        ;; 01:5247 ????????
    dw   $d65b, $0008, $d681, $0002        ;; 01:524f ????????
    dw   $d65b, $0004, $d681, $0001        ;; 01:5257 ????????
    dw   $d65b, $0002, $d682, $0004        ;; 01:525f ????????
    dw   $d65b, $0001, $d682, $0002        ;; 01:5267 ????????
    dw   $0000                             ;; 01:526f ??

call_01_5271_ProcessPassword: ; handles setting save data from password
    
    ; check if any of the boxes are blank. if so, it is an invalid password
    ld   HL, wD668_PasswordValues                      ;; 01:5271 $21 $68 $d6
    ld   B, $1c                                        ;; 01:5274 $06 $1c ; 1c is the number of password boxes (28)
.jr_01_5276:
    ld   A, [HL+]                                      ;; 01:5276 $2a
    cp   A, $20                                        ;; 01:5277 $fe $20
    jp   Z, .jp_01_531a                                ;; 01:5279 $ca $1a $53
    dec  B                                             ;; 01:527c $05
    jr   NZ, .jr_01_5276                               ;; 01:527d $20 $f7 
    
    ; set these 11 bytes to 0
    ld   HL, wD65C                                     ;; 01:527f $21 $5c $d6
    ld   B, $0b                                        ;; 01:5282 $06 $0b ; b = 11
    xor  A, A                                          ;; 01:5284 $af ; a = 0
.jr_01_5285:
    ld   [HL+], A                                      ;; 01:5285 $22
    dec  B                                             ;; 01:5286 $05
    jr   NZ, .jr_01_5285                               ;; 01:5287 $20 $fc
    
    ; decode the password into wD65C array of 11 bytes
    ld   HL, wD65C                                     ;; 01:5289 $21 $5c $d6
    ld   DE, wD668_PasswordValues                      ;; 01:528c $11 $68 $d6
    ld   A, $1c                                        ;; 01:528f $3e $1c ; 28
    ld   C, $80                                        ;; 01:5291 $0e $80 ; 128
.jr_01_5293:
    push AF                                            ;; 01:5293 $f5
    push DE                                            ;; 01:5294 $d5
    ld   A, [DE]                                       ;; 01:5295 $1a ; a = value in password box
    sub  A, $41                                        ;; 01:5296 $d6 $41 ; subtract 0x41 to make value 0-7
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
    
    ; add up all the values into a
    ld   HL, wD65C                                     ;; 01:52b2 $21 $5c $d6
    ld   B, $09                                        ;; 01:52b5 $06 $09
    xor  A, A                                          ;; 01:52b7 $af
.jr_01_52b8:
    add  A, [HL]                                       ;; 01:52b8 $86
    inc  HL                                            ;; 01:52b9 $23
    dec  B                                             ;; 01:52ba $05
    jr   NZ, .jr_01_52b8                               ;; 01:52bb $20 $fb
    
    ; invalid password if the sum of values is not equal to value in wD665
    ld   HL, wD665                                     ;; 01:52bd $21 $65 $d6
    cp   A, [HL]                                       ;; 01:52c0 $be
    jr   NZ, .jp_01_531a                               ;; 01:52c1 $20 $57
    
    ; set lives to value in wD664
    ld   A, [wD664]                                    ;; 01:52c3 $fa $64 $d6
    ld   [wD73D_LivesRemaining], A                                    ;; 01:52c6 $ea $3d $d7
    
    ; set current level to 0
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:52c9 $fa $24 $d6
    push AF                                            ;; 01:52cc $f5
    xor  A, A                                          ;; 01:52cd $af
    ld   [wD624_CurrentLevelId], A                                    ;; 01:52ce $ea $24 $d6
    
    ; set remote bitfields
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
    ld   HL, wD624_CurrentLevelId                                     ;; 01:52fc $21 $24 $d6
    ld   L, [HL]                                       ;; 01:52ff $6e
    ld   H, $00                                        ;; 01:5300 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 01:5302 $11 $29 $d6
    add  HL, DE                                        ;; 01:5305 $19
    ld   [HL], A                                       ;; 01:5306 $77
    pop  HL                                            ;; 01:5307 $e1
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:5308 $fa $24 $d6
    inc  A                                             ;; 01:530b $3c
    ld   [wD624_CurrentLevelId], A                                    ;; 01:530c $ea $24 $d6
    cp   A, $1e                                        ;; 01:530f $fe $1e
    jr   NZ, .jr_01_52d6                               ;; 01:5311 $20 $c3
    
    ; set current level to 0
    pop  AF                                            ;; 01:5313 $f1
    ld   [wD624_CurrentLevelId], A                                    ;; 01:5314 $ea $24 $d6
    
    ld   A, $30                                        ;; 01:5317 $3e $30
    ret                                                ;; 01:5319 $c9
.jp_01_531a:
    ld   A, $00                                        ;; 01:531a $3e $00
    ret                                                ;; 01:531c $c9
.data_01_531d:
    db   $1f, $1b, $19, $03, $01, $20, $00             ;; 01:531d ???????
