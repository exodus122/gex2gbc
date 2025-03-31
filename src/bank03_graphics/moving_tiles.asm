entry_03_723c_SetupMovingTiles:
    ld   HL, wD624_CurrentLevelId                                     ;; 03:723c $21 $24 $d6
    ld   L, [HL]                                       ;; 03:723f $6e
    ld   H, $00                                        ;; 03:7240 $26 $00
    add  HL, HL                                        ;; 03:7242 $29
    ld   DE, data_03_72ab                              ;; 03:7243 $11 $ab $72
    add  HL, DE                                        ;; 03:7246 $19
    ld   A, [HL+]                                      ;; 03:7247 $2a
    ld   H, [HL]                                       ;; 03:7248 $66
    ld   L, A                                          ;; 03:7249 $6f
    ld   A, [HL]                                       ;; 03:724a $7e
    ld   [wD611_MovingTilesId], A                                    ;; 03:724b $ea $11 $d6
    xor  A, A                                          ;; 03:724e $af
    ld   [wD612_MovingTilesId], A                                    ;; 03:724f $ea $12 $d6
    ret                                                ;; 03:7252 $c9

entry_03_7253_UpdateMovingTiles:
    ld   A, [wD611_MovingTilesId]                                    ;; 03:7253 $fa $11 $d6
    and  A, A                                          ;; 03:7256 $a7
    ret  Z                                             ;; 03:7257 $c8
    ld   HL, wD624_CurrentLevelId                                     ;; 03:7258 $21 $24 $d6
    ld   L, [HL]                                       ;; 03:725b $6e
    ld   H, $00                                        ;; 03:725c $26 $00
    add  HL, HL                                        ;; 03:725e $29
    ld   DE, data_03_72ab                              ;; 03:725f $11 $ab $72
    add  HL, DE                                        ;; 03:7262 $19
    ld   E, [HL]                                       ;; 03:7263 $5e
    inc  HL                                            ;; 03:7264 $23
    ld   D, [HL]                                       ;; 03:7265 $56
    ld   A, [DE]                                       ;; 03:7266 $1a
    inc  DE                                            ;; 03:7267 $13
    ld   HL, wD612_MovingTilesId                                     ;; 03:7268 $21 $12 $d6
    inc  [HL]                                          ;; 03:726b $34
    sub  A, [HL]                                       ;; 03:726c $96
    jr   NZ, .jr_03_7271                               ;; 03:726d $20 $02
    ld   [HL], $00                                     ;; 03:726f $36 $00
.jr_03_7271:
    ld   L, [HL]                                       ;; 03:7271 $6e
    ld   H, $00                                        ;; 03:7272 $26 $00
    add  HL, HL                                        ;; 03:7274 $29
    add  HL, HL                                        ;; 03:7275 $29
    add  HL, HL                                        ;; 03:7276 $29
    add  HL, DE                                        ;; 03:7277 $19
    ld   B, [HL]                                       ;; 03:7278 $46
    inc  HL                                            ;; 03:7279 $23
    ld   C, [HL]                                       ;; 03:727a $4e
    inc  HL                                            ;; 03:727b $23
    ld   E, [HL]                                       ;; 03:727c $5e
    inc  HL                                            ;; 03:727d $23
    ld   D, [HL]                                       ;; 03:727e $56
    inc  HL                                            ;; 03:727f $23
    ld   A, [HL+]                                      ;; 03:7280 $2a
    ld   H, [HL]                                       ;; 03:7281 $66
    ld   L, A                                          ;; 03:7282 $6f
    bit  7, C                                          ;; 03:7283 $cb $79
    jr   Z, .jr_03_72a4                                ;; 03:7285 $28 $1d
    ld   A, [wD72D_CurrentSpecialTilesetIndex]                                    ;; 03:7287 $fa $2d $d7
    cp   A, $00                                        ;; 03:728a $fe $00
    ret  NZ                                            ;; 03:728c $c0
    res  7, C                                          ;; 03:728d $cb $b9
    ld   A, [wD5A3]                                    ;; 03:728f $fa $a3 $d5
    dec  C                                             ;; 03:7292 $0d
    jr   Z, .jr_03_729e                                ;; 03:7293 $28 $09
    ld   A, [wD5A4]                                    ;; 03:7295 $fa $a4 $d5
    dec  C                                             ;; 03:7298 $0d
    jr   Z, .jr_03_729e                                ;; 03:7299 $28 $03
    ld   A, [wD5A5]                                    ;; 03:729b $fa $a5 $d5
.jr_03_729e:
    and  A, A                                          ;; 03:729e $a7
    jr   NZ, .jr_03_72a4                               ;; 03:729f $20 $03
    ld   HL, data_03_7bfd                              ;; 03:72a1 $21 $fd $7b
.jr_03_72a4:
    call call_03_6f2d                                  ;; 03:72a4 $cd $2d $6f
    dec  B                                             ;; 03:72a7 $05
    jr   NZ, .jr_03_72a4                               ;; 03:72a8 $20 $fa
    ret                                                ;; 03:72aa $c9

data_03_72ab:
    dw   data_03_72e8_media_dimension_moving_tiles                                  ;; 03:72ab pP
    dw   data_03_72e9_toon_tv_moving_tiles                                  ;; 03:72ad pP
    dw   data_03_734a_scream_tv_moving_tiles                                  ;; 03:72af pP
    dw   data_03_734a_scream_tv_moving_tiles
    dw   data_03_73bb_circuit_central_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e9_toon_tv_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_73bb_circuit_central_moving_tiles
    dw   data_03_734a_scream_tv_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_741c_rezopolis_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_734a_scream_tv_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_741c_rezopolis_moving_tiles
    dw   data_03_73bb_circuit_central_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_734a_scream_tv_moving_tiles
    dw   data_03_741c_rezopolis_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    dw   data_03_72e8_media_dimension_moving_tiles
    db   $e8

data_03_72e8_media_dimension_moving_tiles:
    db   $00                                           ;; 03:72e8 .

data_03_72e9_toon_tv_moving_tiles:
    db   $0c
    
    db   $04, $00                                 ;; 03:72e9 ...
    dw   $8b30                                         ;; 03:72ec pP
    dw   data_03_747d
    db   $00, $00
    
    db   $02, $00                  ;; 03:72ee ..??..
    dw   $8a50                                         ;; 03:72f4 pP
    dw   data_03_757d
    db   $00, $00
    
    db   $04, $00                  ;; 03:72f6 ..??..
    dw   $8c40                                         ;; 03:72fc pP
    dw   data_03_75fd
    db   $00, $00
    
    db   $04, $00                  ;; 03:72fe ..??..
    dw   $8b30                                         ;; 03:7304 pP
    dw   data_03_74bd
    db   $00, $00
    
    db   $02, $00                  ;; 03:7306 ..??..
    dw   $8a50                                         ;; 03:730c pP
    dw   data_03_759d
    db   $00, $00
    
    db   $04, $00                  ;; 03:730e ..??..
    dw   $8c40                                         ;; 03:7314 pP
    dw   data_03_763d
    db   $00, $00
    
    db   $04, $00                  ;; 03:7316 ..??..
    dw   $8b30                                         ;; 03:731c pP
    dw   data_03_74fd
    db   $00, $00
    
    db   $02, $00                  ;; 03:731e ..??..
    dw   $8a50                                         ;; 03:7324 pP
    dw   data_03_75bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:7326 ..??..
    dw   $8c40                                         ;; 03:732c pP
    dw   data_03_767d
    db   $00, $00
    
    db   $04, $00                  ;; 03:732e ..??..
    dw   $8b30                                         ;; 03:7334 pP
    dw   data_03_753d
    db   $00, $00
    
    db   $02, $00                  ;; 03:7336 ..??..
    dw   $8a50                                         ;; 03:733c pP
    dw   data_03_75dd
    db   $00, $00
    
    db   $04, $00                  ;; 03:733e ..??..
    dw   $8c40                                         ;; 03:7344 pP
    dw   data_03_76bd
    db   $00, $00                            ;; 03:7346 ..??

data_03_734a_scream_tv_moving_tiles:
    db   $0e
    
    db   $02, $00                                 ;; 03:734a ...
    dw   $97e0                                         ;; 03:734d pP
    dw   data_03_787d
    db   $00, $00
    
    db   $06, $00                  ;; 03:734f ..??..
    dw   $96a0                                         ;; 03:7355 pP
    dw   data_03_76fd
    db   $00, $00
    
    db   $04, $00                  ;; 03:7357 ..??..
    dw   $8ac0                                         ;; 03:735d pP
    dw   data_03_78bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:735f ..??..
    dw   $8b00                                         ;; 03:7365 pP
    dw   data_03_78fd
    db   $00, $00
    
    db   $06, $00                  ;; 03:7367 ..??..
    dw   $96a0                                         ;; 03:736d pP
    dw   data_03_775d
    db   $00, $00
    
    db   $04, $00                  ;; 03:736f ..??..
    dw   $8ac0                                         ;; 03:7375 pP
    dw   data_03_793d
    db   $00, $00
    
    db   $04, $00                  ;; 03:7377 ..??..
    dw   $8b00                                         ;; 03:737d pP
    dw   data_03_797d
    db   $00, $00
    
    db   $02, $00                  ;; 03:737f ..??..
    dw   $97e0                                         ;; 03:7385 pP
    dw   data_03_789d
    db   $00, $00
    
    db   $06, $00                  ;; 03:7387 ..??..
    dw   $96a0                                         ;; 03:738d pP
    dw   data_03_77bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:738f ..??..
    dw   $8ac0                                         ;; 03:7395 pP
    dw   data_03_79bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:7397 ..??..
    dw   $8b00                                         ;; 03:739d pP
    dw   data_03_79fd
    db   $00, $00
    
    db   $06, $00                  ;; 03:739f ..??..
    dw   $96a0                                         ;; 03:73a5 pP
    dw   data_03_781d
    db   $00, $00
    
    db   $04, $00                  ;; 03:73a7 ..??..
    dw   $8ac0                                         ;; 03:73ad pP
    dw   data_03_7a3d
    db   $00, $00
    
    db   $04, $00                  ;; 03:73af ..??..
    dw   $8b00                                         ;; 03:73b5 pP
    dw   data_03_7a7d
    db   $00, $00
data_03_73bb_circuit_central_moving_tiles:
    db   $0c
    
    db   $02, $81, $e0        ;; 03:73bb ..??????
    db   $91
    dw   data_03_7b7d
    db   $00, $00
    
    db   $02, $82, $00        ;; 03:73bf ????????
    db   $92
    dw   data_03_7b7d
    db   $00, $00
    
    db   $02, $83, $20        ;; 03:73c7 ????????
    db   $92
    dw   data_03_7b7d
    db   $00, $00
    
    db   $02, $81, $e0        ;; 03:73cf ????????
    db   $91
    dw   data_03_7b9d
    db   $00, $00
    
    db   $02, $82, $00        ;; 03:73d7 ????????
    db   $92
    dw   data_03_7b9d
    db   $00, $00
    
    db   $02, $83, $20        ;; 03:73df ????????
    db   $92
    dw   data_03_7b9d
    db   $00, $00
    
    db   $02, $81, $e0        ;; 03:73e7 ????????
    db   $91
    dw   data_03_7bbd
    db   $00, $00
    
    db   $02, $82, $00        ;; 03:73ef ????????
    db   $92
    dw   data_03_7bbd
    db   $00, $00
    
    db   $02, $83, $20        ;; 03:73f7 ????????
    db   $92
    dw   data_03_7bbd
    db   $00, $00
    
    db   $02, $81, $e0        ;; 03:73ff ????????
    db   $91
    dw   data_03_7bdd
    db   $00, $00
    
    db   $02, $82, $00        ;; 03:7407 ????????
    db   $92
    dw   data_03_7bdd
    db   $00, $00
    
    db   $02, $83, $20        ;; 03:740f ????????
    db   $92
    dw   data_03_7bdd
    db   $00, $00
data_03_741c_rezopolis_moving_tiles:
    db   $0c
    
    db   $02, $00        ;; 03:7417 ????????
    db   $b0, $8c
    dw   data_03_7abd
    db   $00
    
    db   $00, $01, $00        ;; 03:741f ????????
    db   $00, $8e
    dw   data_03_7afd
    db   $00
    
    db   $00, $01, $00        ;; 03:7427 ????????
    db   $00, $8f
    dw   data_03_7b3d
    db   $00
    
    db   $00, $02, $00        ;; 03:742f ????????
    db   $b0, $8c
    dw   data_03_7add
    db   $00
    
    db   $00, $01, $00        ;; 03:7437 ????????
    db   $00, $8e
    dw   data_03_7b0d
    db   $00
    
    db   $00, $01, $00        ;; 03:743f ????????
    db   $00, $8f
    dw   data_03_7b4d
    db   $00
    
    db   $00, $02, $00        ;; 03:7447 ????????
    db   $b0, $8c
    dw   data_03_7abd
    db   $00
    
    db   $00, $01, $00        ;; 03:744f ????????
    db   $00, $8e
    dw   data_03_7b1d
    db   $00
    
    db   $00, $01, $00        ;; 03:7457 ????????
    db   $00, $8f
    dw   data_03_7b5d
    db   $00
    
    db   $00, $02, $00        ;; 03:745f ????????
    db   $b0, $8c
    dw   data_03_7add
    db   $00
    
    db   $00, $01, $00        ;; 03:7467 ????????
    db   $00, $8e
    dw   data_03_7b2d
    db   $00
    
    db   $00, $01, $00        ;; 03:746f ????????
    db   $00, $8f
    dw   data_03_7b6d
    db   $00, $00                  ;; 03:7477 ??????

data_03_747d:
    INCBIN ".gfx/moving_tiles/image_003_747d.bin"
data_03_74bd:
    INCBIN ".gfx/moving_tiles/image_003_74bd.bin"
data_03_74fd:
    INCBIN ".gfx/moving_tiles/image_003_74fd.bin"
data_03_753d:
    INCBIN ".gfx/moving_tiles/image_003_753d.bin"
data_03_757d:
    INCBIN ".gfx/moving_tiles/image_003_757d.bin"
data_03_759d:
    INCBIN ".gfx/moving_tiles/image_003_759d.bin"
data_03_75bd:
    INCBIN ".gfx/moving_tiles/image_003_75bd.bin"
data_03_75dd:
    INCBIN ".gfx/moving_tiles/image_003_75dd.bin"
data_03_75fd:
    INCBIN ".gfx/moving_tiles/image_003_75fd.bin"
data_03_763d:
    INCBIN ".gfx/moving_tiles/image_003_763d.bin"
data_03_767d:
    INCBIN ".gfx/moving_tiles/image_003_767d.bin"
data_03_76bd:
    INCBIN ".gfx/moving_tiles/image_003_76bd.bin"
data_03_76fd:
    INCBIN ".gfx/moving_tiles/image_003_76fd.bin"
data_03_775d:
    INCBIN ".gfx/moving_tiles/image_003_775d.bin"
data_03_77bd:
    INCBIN ".gfx/moving_tiles/image_003_77bd.bin"
data_03_781d:
    INCBIN ".gfx/moving_tiles/image_003_781d.bin"
data_03_787d:
    INCBIN ".gfx/moving_tiles/image_003_787d.bin"
data_03_789d:
    INCBIN ".gfx/moving_tiles/image_003_789d.bin"
data_03_78bd:
    INCBIN ".gfx/moving_tiles/image_003_78bd.bin"
data_03_78fd:
    INCBIN ".gfx/moving_tiles/image_003_78fd.bin"
data_03_793d:
    INCBIN ".gfx/moving_tiles/image_003_793d.bin"
data_03_797d:
    INCBIN ".gfx/moving_tiles/image_003_797d.bin"
data_03_79bd:
    INCBIN ".gfx/moving_tiles/image_003_79bd.bin"
data_03_79fd:
    INCBIN ".gfx/moving_tiles/image_003_79fd.bin"
data_03_7a3d:
    INCBIN ".gfx/moving_tiles/image_003_7a3d.bin"
data_03_7a7d:
    INCBIN ".gfx/moving_tiles/image_003_7a7d.bin"
data_03_7abd:
    INCBIN ".gfx/moving_tiles/image_003_7abd.bin"
data_03_7add:
    INCBIN ".gfx/moving_tiles/image_003_7add.bin"
data_03_7afd:
    INCBIN ".gfx/moving_tiles/image_003_7afd.bin"
data_03_7b0d:
    INCBIN ".gfx/moving_tiles/image_003_7b0d.bin"
data_03_7b1d:
    INCBIN ".gfx/moving_tiles/image_003_7b1d.bin"
data_03_7b2d:
    INCBIN ".gfx/moving_tiles/image_003_7b2d.bin"
data_03_7b3d:
    INCBIN ".gfx/moving_tiles/image_003_7b3d.bin"
data_03_7b4d:
    INCBIN ".gfx/moving_tiles/image_003_7b4d.bin"
data_03_7b5d:
    INCBIN ".gfx/moving_tiles/image_003_7b5d.bin"
data_03_7b6d:
    INCBIN ".gfx/moving_tiles/image_003_7b6d.bin"
data_03_7b7d:
    INCBIN ".gfx/moving_tiles/image_003_7b7d.bin"
data_03_7b9d:
    INCBIN ".gfx/moving_tiles/image_003_7b9d.bin"
data_03_7bbd:
    INCBIN ".gfx/moving_tiles/image_003_7bbd.bin"
data_03_7bdd:
    INCBIN ".gfx/moving_tiles/image_003_7bdd.bin"

data_03_7bfd:
    db   $ff, $00, $00, $00, $00, $00, $00, $00        ;; 03:7bfd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 03:7c05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 03:7c0d ????????
    db   $00, $00, $00, $00, $00, $00, $ff             ;; 03:7c15 ???????
