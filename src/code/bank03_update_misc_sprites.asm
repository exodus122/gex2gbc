call_03_66ae:
    ld   HL, .image_03_66e1                             ;; 03:66ae $21 $e1 $66
    ld   DE, $8600                                     ;; 03:66b1 $11 $00 $86
    ld   BC, $140                                      ;; 03:66b4 $01 $40 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 03:66b7 $cd $b0 $07
    call call_03_6d13                                  ;; 03:66ba $cd $13 $6d
    call call_03_6941                                  ;; 03:66bd $cd $41 $69
    ld   HL, .image_demo_mode_03_6821                             ;; 03:66c0 $21 $21 $68
    ld   DE, $8680                                     ;; 03:66c3 $11 $80 $86
    ld   BC, $100                                      ;; 03:66c6 $01 $00 $01
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 03:66c9 $fa $1e $d6
    and  A, A                                          ;; 03:66cc $a7
    jp   NZ, call_00_07b0_CopyBCBytesFromHLToDE                              ;; 03:66cd $c2 $b0 $07
    ld   A, [wD623]                                    ;; 03:66d0 $fa $23 $d6
    and  A, A                                          ;; 03:66d3 $a7
    ret  Z                                             ;; 03:66d4 $c8
    ld   HL, .image_colon_03_6921                             ;; 03:66d5 $21 $21 $69
    ld   DE, $8680                                     ;; 03:66d8 $11 $80 $86
    call call_03_6efd                                  ;; 03:66db $cd $fd $6e
    jp   call_03_6ceb                                    ;; 03:66de $c3 $eb $6c
.image_03_66e1:
    INCBIN ".gfx/misc_sprites/image_003_66e1.bin"
.image_demo_mode_03_6821:
    INCBIN ".gfx/misc_sprites/image_demo_mode_003_6821.bin"
.image_colon_03_6921:
    INCBIN ".gfx/misc_sprites/image_colon_003_6921.bin"

call_03_6941:
    ld   HL, wD60E                                     ;; 03:6941 $21 $0e $d6
    res  3, [HL]                                       ;; 03:6944 $cb $9e
    call call_03_6be5                                  ;; 03:6946 $cd $e5 $6b
    ld   HL, wD624_CurrentLevelId                                     ;; 03:6949 $21 $24 $d6
    ld   L, [HL]                                       ;; 03:694c $6e
    ld   H, $00                                        ;; 03:694d $26 $00
    add  HL, HL                                        ;; 03:694f $29
    ld   DE, .data_image_collectibles_03_6967                             ;; 03:6950 $11 $67 $69
    add  HL, DE                                        ;; 03:6953 $19
    ld   E, [HL]                                       ;; 03:6954 $5e
    inc  HL                                            ;; 03:6955 $23
    ld   D, [HL]                                       ;; 03:6956 $56
    ld   A, [wD648]                                    ;; 03:6957 $fa $48 $d6
    swap A                                             ;; 03:695a $cb $37
    ld   L, A                                          ;; 03:695c $6f
    ld   H, $00                                        ;; 03:695d $26 $00
    add  HL, HL                                        ;; 03:695f $29
    add  HL, DE                                        ;; 03:6960 $19
    ld   DE, $87e0                                     ;; 03:6961 $11 $e0 $87
    jp   call_03_6efd                                  ;; 03:6964 $c3 $fd $6e
.data_image_collectibles_03_6967:
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_scream_tv_003_6a05
    dw   .image_collectibles_scream_tv_003_6a05
    dw   .image_collectibles_circuit_central_003_6a65
    dw   .image_collectibles_kung_fu_theater_003_6ac5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_prehistory_channel_003_6b25
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_prehistory_channel_003_6b25
    dw   .image_collectibles_circuit_central_003_6a65
    dw   .image_collectibles_scream_tv_003_6a05
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_kung_fu_theater_003_6ac5
    dw   .image_collectibles_rezopolis_003_6b85
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_scream_tv_003_6a05
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_kung_fu_theater_003_6ac5
    dw   .image_collectibles_rezopolis_003_6b85
    dw   .image_collectibles_circuit_central_003_6a65
    dw   .image_collectibles_prehistory_channel_003_6b25
    dw   .image_collectibles_scream_tv_003_6a05
    dw   .image_collectibles_rezopolis_003_6b85
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
    dw   .image_collectibles_toon_tv_003_69a5
.image_collectibles_toon_tv_003_69a5:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_toon_tv.bin"
.image_collectibles_scream_tv_003_6a05:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_scream_tv.bin"
.image_collectibles_circuit_central_003_6a65:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_circuit_central.bin"    
.image_collectibles_kung_fu_theater_003_6ac5:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_kung_fu_theater.bin"
.image_collectibles_prehistory_channel_003_6b25:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_prehistory_channel.bin"
.image_collectibles_rezopolis_003_6b85:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_rezopolis.bin"

call_03_6be5:
    ld   A, [wD59E]                                    ;; 03:6be5 $fa $9e $d5
    and  A, A                                          ;; 03:6be8 $a7
    ret  Z                                             ;; 03:6be9 $c8
    ld   HL, wD624_CurrentLevelId                                     ;; 03:6bea $21 $24 $d6
    ld   L, [HL]                                       ;; 03:6bed $6e
    ld   H, $00                                        ;; 03:6bee $26 $00
    add  HL, HL                                        ;; 03:6bf0 $29
    ld   DE, .data_03_6c1d_collectible_palettes                             ;; 03:6bf1 $11 $1d $6c
    add  HL, DE                                        ;; 03:6bf4 $19
    ld   E, [HL]                                       ;; 03:6bf5 $5e
    inc  HL                                            ;; 03:6bf6 $23
    ld   D, [HL]                                       ;; 03:6bf7 $56
    ld   HL, wD648                                     ;; 03:6bf8 $21 $48 $d6
    ld   L, [HL]                                       ;; 03:6bfb $6e
    ld   H, $00                                        ;; 03:6bfc $26 $00
    add  HL, HL                                        ;; 03:6bfe $29
    add  HL, HL                                        ;; 03:6bff $29
    add  HL, HL                                        ;; 03:6c00 $29
    add  HL, DE                                        ;; 03:6c01 $19
    ld   DE, wDA13                                     ;; 03:6c02 $11 $13 $da
    ld   A, [HL+]                                      ;; 03:6c05 $2a
    ld   [DE], A                                       ;; 03:6c06 $12
    inc  DE                                            ;; 03:6c07 $13
    ld   A, [HL+]                                      ;; 03:6c08 $2a
    ld   [DE], A                                       ;; 03:6c09 $12
    inc  DE                                            ;; 03:6c0a $13
    ld   A, [HL+]                                      ;; 03:6c0b $2a
    ld   [DE], A                                       ;; 03:6c0c $12
    inc  DE                                            ;; 03:6c0d $13
    ld   A, [HL+]                                      ;; 03:6c0e $2a
    ld   [DE], A                                       ;; 03:6c0f $12
    inc  DE                                            ;; 03:6c10 $13
    ld   A, [HL+]                                      ;; 03:6c11 $2a
    ld   [DE], A                                       ;; 03:6c12 $12
    inc  DE                                            ;; 03:6c13 $13
    ld   A, [HL+]                                      ;; 03:6c14 $2a
    ld   [DE], A                                       ;; 03:6c15 $12
    inc  DE                                            ;; 03:6c16 $13
    ld   A, [HL+]                                      ;; 03:6c17 $2a
    ld   [DE], A                                       ;; 03:6c18 $12
    inc  DE                                            ;; 03:6c19 $13
    ld   A, [HL]                                       ;; 03:6c1a $7e
    ld   [DE], A                                       ;; 03:6c1b $12
    ret                                                ;; 03:6c1c $c9
.data_03_6c1d_collectible_palettes:
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_scream_tv_collectibles
    dw   .palette_scream_tv_collectibles
    dw   .palette_circuit_central_collectibles
    dw   .palette_kung_fu_theater_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_prehistory_channel_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_prehistory_channel_collectibles
    dw   .palette_circuit_central_collectibles
    dw   .palette_scream_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_kung_fu_theater_collectibles
    dw   .palette_rezopolis_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_scream_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_kung_fu_theater_collectibles
    dw   .palette_rezopolis_collectibles
    dw   .palette_circuit_central_collectibles
    dw   .palette_prehistory_channel_collectibles
    dw   .palette_scream_tv_collectibles
    dw   .palette_rezopolis_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
    dw   .palette_toon_tv_collectibles
.palette_toon_tv_collectibles: ;; 03:6c5b
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_toon_tv_collectibles.bin"
.palette_scream_tv_collectibles: ;; 03:6c73
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_scream_tv_collectibles.bin"
.palette_circuit_central_collectibles: ;; 03:6c8b
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_circuit_central_collectibles.bin"
.palette_kung_fu_theater_collectibles: ;; 03:6ca3
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_kung_fu_theater_collectibles.bin"
.palette_prehistory_channel_collectibles: ;; 03:6cbb
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_prehistory_channel_collectibles.bin"
.palette_rezopolis_collectibles: ;; 03:6cd3
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_rezopolis_collectibles.bin"

call_03_6ceb:
    ld   HL, wD60E                                     ;; 03:6ceb $21 $0e $d6
    res  2, [HL]                                       ;; 03:6cee $cb $96
    ld   A, [wD76F]                                    ;; 03:6cf0 $fa $6f $d7
    ld   DE, $8748                                     ;; 03:6cf3 $11 $48 $87
    call call_03_6d88                                  ;; 03:6cf6 $cd $88 $6d
    ld   A, [wD770]                                    ;; 03:6cf9 $fa $70 $d7
    swap A                                             ;; 03:6cfc $cb $37
    and  A, $0f                                        ;; 03:6cfe $e6 $0f
    ld   DE, $8768                                     ;; 03:6d00 $11 $68 $87
    call call_03_6d88                                  ;; 03:6d03 $cd $88 $6d
    ld   A, [wD770]                                    ;; 03:6d06 $fa $70 $d7
    and  A, $0f                                        ;; 03:6d09 $e6 $0f
    ld   DE, $8788                                     ;; 03:6d0b $11 $88 $87
    call call_03_6d88                                  ;; 03:6d0e $cd $88 $6d
    jr   jr_03_6d5e                                    ;; 03:6d11 $18 $4b

call_03_6d13:
    ld   HL, wD60E                                     ;; 03:6d13 $21 $0e $d6
    res  1, [HL]                                       ;; 03:6d16 $cb $8e
    ld   HL, wD73E_PlayerLivesHundreds                                     ;; 03:6d18 $21 $3e $d7
    ld   A, $0a                                        ;; 03:6d1b $3e $0a
    ld   [HL+], A                                      ;; 03:6d1d $22
    ld   [HL+], A                                      ;; 03:6d1e $22
    ld   [HL-], A                                      ;; 03:6d1f $32
    dec  HL                                            ;; 03:6d20 $2b
    ld   A, [wD73D_LivesRemaining]                                    ;; 03:6d21 $fa $3d $d7
    cp   A, $64                                        ;; 03:6d24 $fe $64
    jr   NC, .jr_03_6d2e                               ;; 03:6d26 $30 $06
    cp   A, $0a                                        ;; 03:6d28 $fe $0a
    jr   NC, .jr_03_6d38                               ;; 03:6d2a $30 $0c
    jr   .jr_03_6d42                                   ;; 03:6d2c $18 $14
.jr_03_6d2e:
    ld   [HL], $ff                                     ;; 03:6d2e $36 $ff
.jr_03_6d30:
    inc  [HL]                                          ;; 03:6d30 $34
    sub  A, $64                                        ;; 03:6d31 $d6 $64
    jr   NC, .jr_03_6d30                               ;; 03:6d33 $30 $fb
    add  A, $64                                        ;; 03:6d35 $c6 $64
    inc  HL                                            ;; 03:6d37 $23
.jr_03_6d38:
    ld   [HL], $ff                                     ;; 03:6d38 $36 $ff
.jr_03_6d3a:
    inc  [HL]                                          ;; 03:6d3a $34
    sub  A, $0a                                        ;; 03:6d3b $d6 $0a
    jr   NC, .jr_03_6d3a                               ;; 03:6d3d $30 $fb
    add  A, $0a                                        ;; 03:6d3f $c6 $0a
    inc  HL                                            ;; 03:6d41 $23
.jr_03_6d42:
    ld   [HL], A                                       ;; 03:6d42 $77
    ld   A, [wD73E_PlayerLivesHundreds]                                    ;; 03:6d43 $fa $3e $d7
    ld   DE, $8748                                     ;; 03:6d46 $11 $48 $87
    call call_03_6d88                                  ;; 03:6d49 $cd $88 $6d
    ld   A, [wD73F_PlayerLivesTens]                                    ;; 03:6d4c $fa $3f $d7
    ld   DE, $8768                                     ;; 03:6d4f $11 $68 $87
    call call_03_6d88                                  ;; 03:6d52 $cd $88 $6d
    ld   A, [wD740_PlayerLivesOnes]                                    ;; 03:6d55 $fa $40 $d7
    ld   DE, $8788                                     ;; 03:6d58 $11 $88 $87
    call call_03_6d88                                  ;; 03:6d5b $cd $88 $6d

jr_03_6d5e:
    ld   HL, wD64A                                     ;; 03:6d5e $21 $4a $d6
    ld   A, $0a                                        ;; 03:6d61 $3e $0a
    ld   [HL+], A                                      ;; 03:6d63 $22
    ld   [HL-], A                                      ;; 03:6d64 $32
    ld   A, [wD649_CollectibleAmount]                                    ;; 03:6d65 $fa $49 $d6
    cp   A, $0a                                        ;; 03:6d68 $fe $0a
    jr   C, .jr_03_6d76                                ;; 03:6d6a $38 $0a
    ld   [HL], $ff                                     ;; 03:6d6c $36 $ff
.jr_03_6d6e:
    inc  [HL]                                          ;; 03:6d6e $34
    sub  A, $0a                                        ;; 03:6d6f $d6 $0a
    jr   NC, .jr_03_6d6e                               ;; 03:6d71 $30 $fb
    add  A, $0a                                        ;; 03:6d73 $c6 $0a
    inc  HL                                            ;; 03:6d75 $23
.jr_03_6d76:
    ld   [HL], A                                       ;; 03:6d76 $77
    ld   A, [wD64A]                                    ;; 03:6d77 $fa $4a $d6
    ld   DE, $87a8                                     ;; 03:6d7a $11 $a8 $87
    call call_03_6d88                                  ;; 03:6d7d $cd $88 $6d
    ld   A, [wD64B]                                    ;; 03:6d80 $fa $4b $d6
    ld   DE, $87c8                                     ;; 03:6d83 $11 $c8 $87
    jr   call_03_6d88                                  ;; 03:6d86 $18 $00

call_03_6d88:
    swap A                                             ;; 03:6d88 $cb $37
    ld   L, A                                          ;; 03:6d8a $6f
    ld   H, $00                                        ;; 03:6d8b $26 $00
    ld   BC, .numbers_003_6d9d                             ;; 03:6d8d $01 $9d $6d
    ld   A, [wD623]                                    ;; 03:6d90 $fa $23 $d6
    and  A, A                                          ;; 03:6d93 $a7
    jr   Z, .jr_03_6d99                                ;; 03:6d94 $28 $03
    ld   BC, .numbers_003_6e4d                             ;; 03:6d96 $01 $4d $6e
.jr_03_6d99:
    add  HL, BC                                        ;; 03:6d99 $09
    jp   call_03_6f2d                                  ;; 03:6d9a $c3 $2d $6f
.numbers_003_6d9d:
    INCBIN ".gfx/misc_sprites/numbers_003_6d9d.bin"
.numbers_003_6e4d:
    INCBIN ".gfx/misc_sprites/numbers_003_6e4d.bin"
