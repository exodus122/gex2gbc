;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

call_0b_5537:
    ld   A, [wD59E]                                    ;; 0b:5537 $fa $9e $d5
    and  A, A                                          ;; 0b:553a $a7
    jp   NZ, call_0b_561b                               ;; 0b:553b $c2 $1b $56
    ld   A, [wD624_CurrentLevelId]                                    ;; 0b:553e $fa $24 $d6
    ld   DE, .data_0b_555f                             ;; 0b:5541 $11 $5f $55
    inc  C                                             ;; 0b:5544 $0c
    dec  C                                             ;; 0b:5545 $0d
    jr   Z, .jr_0b_554c                                ;; 0b:5546 $28 $04
    ld   A, C                                          ;; 0b:5548 $79
    ld   DE, .data_0b_55db                             ;; 0b:5549 $11 $db $55
.jr_0b_554c:
    ld   L, A                                          ;; 0b:554c $6f
    ld   H, $00                                        ;; 0b:554d $26 $00
    add  HL, HL                                        ;; 0b:554f $29
    add  HL, HL                                        ;; 0b:5550 $29
    add  HL, DE                                        ;; 0b:5551 $19
    ld   A, [HL+]                                      ;; 0b:5552 $2a
    ld   [wDAD1], A                                    ;; 0b:5553 $ea $d1 $da
    ld   A, [HL+]                                      ;; 0b:5556 $2a
    ld   [wDAD2], A                                    ;; 0b:5557 $ea $d2 $da
    ld   A, [HL+]                                      ;; 0b:555a $2a
    ld   [wDAD3], A                                    ;; 0b:555b $ea $d3 $da
    ret                                                ;; 0b:555e $c9
.data_0b_555f:
    db   $1b, $1f, $1f, $00, $e4, $1f, $1f, $00        ;; 0b:555f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5567 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:556f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5577 ????????
    db   $e4, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:557f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5587 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:558f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5597 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:559f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55a7 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55af ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55b7 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55bf ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55c7 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55cf ????????
    db   $1b, $1f, $1f, $00                            ;; 0b:55d7 ????
.data_0b_55db:
    db   $00, $00, $00, $00, $1b, $1b, $1b, $00        ;; 0b:55db ????????
    db   $1b, $1b, $1b, $00, $1b, $1b, $ff, $00        ;; 0b:55e3 ????????
    db   $1b, $1b, $1b, $00, $1b, $1b, $1b, $00        ;; 0b:55eb ????????
    db   $1b, $1b, $1b, $00, $1b, $1b, $1b, $00        ;; 0b:55f3 ????????
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00        ;; 0b:55fb ????????
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00        ;; 0b:5603 ????????
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00        ;; 0b:560b ????????
    db   $e4, $e4, $24, $00, $00, $00, $00, $00        ;; 0b:5613 ????????

call_0b_561b:
    inc  C                                             ;; 0b:561b $0c
    dec  C                                             ;; 0b:561c $0d
    jr   NZ, .jr_0b_5651                               ;; 0b:561d $20 $32
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:561f $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:5622 $6e
    ld   H, $00                                        ;; 0b:5623 $26 $00
    add  HL, HL                                        ;; 0b:5625 $29
    ld   DE, .data_0b_5665_level_palettes                             ;; 0b:5626 $11 $65 $56
    add  HL, DE                                        ;; 0b:5629 $19
    ld   A, [HL+]                                      ;; 0b:562a $2a
    ld   H, [HL]                                       ;; 0b:562b $66
    ld   L, A                                          ;; 0b:562c $6f
    ld   DE, wD9CB_Bg_Palettes                                     ;; 0b:562d $11 $cb $d9
    ld   BC, $40                                       ;; 0b:5630 $01 $40 $00
    call call_00_07b0_MemCopy                                  ;; 0b:5633 $cd $b0 $07
    call call_0b_5df8                                  ;; 0b:5636 $cd $f8 $5d
    ld   HL, .data_gex_object_palette2                             ;; 0b:5639 $21 $03 $5b
    ld   DE, wDA0B_Obj_Palettes                                     ;; 0b:563c $11 $0b $da
    ld   BC, $08                                       ;; 0b:563f $01 $08 $00
    call call_00_07b0_MemCopy                                  ;; 0b:5642 $cd $b0 $07
    ld   [wD59D_ReturnBank], A                                    ;; 0b:5645 $ea $9d $d5
    ld   A, Bank03                                        ;; 0b:5648 $3e $03
    ld   HL, call_03_6be5                                     ;; 0b:564a $21 $e5 $6b
    call call_00_1078_FarCall                                  ;; 0b:564d $cd $78 $10
    ret                                                ;; 0b:5650 $c9
.jr_0b_5651:
    ld   L, C                                          ;; 0b:5651 $69
    ld   H, $00                                        ;; 0b:5652 $26 $00
    add  HL, HL                                        ;; 0b:5654 $29
    ld   DE, .data_0b_56a3                             ;; 0b:5655 $11 $a3 $56
    add  HL, DE                                        ;; 0b:5658 $19
    ld   A, [HL+]                                      ;; 0b:5659 $2a
    ld   H, [HL]                                       ;; 0b:565a $66
    ld   L, A                                          ;; 0b:565b $6f
    ld   DE, wD9CB_Bg_Palettes                                     ;; 0b:565c $11 $cb $d9
    ld   BC, $80                                       ;; 0b:565f $01 $80 $00
    jp   call_00_07b0_MemCopy                                  ;; 0b:5662 $c3 $b0 $07
.data_0b_5665_level_palettes:
    dw   .palette_media_dimension
    dw   .palette_toon_tv
    dw   .palette_scream_tv
    dw   .palette_scream_tv
    dw   .palette_circuit_central
    dw   .palette_kung_fu_theater
    dw   .palette_media_dimension
    dw   .palette_prehistory_channel
    dw   .palette_toon_tv
    dw   .palette_prehistory_channel
    dw   .palette_circuit_central
    dw   .palette_scream_tv
    dw   .palette_media_dimension
    dw   .palette_kung_fu_theater
    dw   .palette_rezopolis
    dw   .palette_media_dimension
    dw   .palette_scream_tv
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_kung_fu_theater2
    dw   .palette_rezopolis
    dw   .palette_circuit_central
    dw   .palette_prehistory_channel
    dw   .palette_scream_tv
    dw   .palette_rezopolis
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_channel_z
.data_0b_56a3:
    dw   $0000
    dw   .image_title_screen_008_1_palette
    dw   .image_title_screen_008_0_palette
    dw   .data_5743_Palette
    dw   .data_57c3_Palette
    dw   .image_great_job_00c_2_palette
    dw   .data_5a83_Palette
    dw   $da4b
    dw   .image_splash_01f_1_palette
    dw   .image_crave_01f_0_palette
    dw   .image_david_01e_0_palette
    dw   .data_5903_Palette
    dw   .data_5943_Palette
    dw   .data_5983_Palette
    dw   .data_59c3_Palette
    dw   .data_5a03_Palette
.image_title_screen_008_1_palette: ; Palette for actual title screen splash (start/password) ; 56c3
    INCBIN "gfx/menus/palettes/image_title_screen_008_1_palette.bin"    
.image_title_screen_008_0_palette: ; Palette for 4th title screen splash (big gex image) ; 5703
    INCBIN "gfx/menus/palettes/image_title_screen_008_0_palette.bin"    
.data_5743_Palette: ; Palette for Password Entering Screen on title screen ; 5743
    db   $00, $00, $4a, $29, $73, $52, $5a, $6b        ;; 0b:5743 ........
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 0b:574b ........
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 0b:5753 ........
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 0b:575b ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:5763 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:576b ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5773 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:577b ........
.data_5783_Palette: ; Palette for ??? ; 5783
    db   $00, $00, $4a, $29, $73, $52, $5a, $6b        ;; 0b:5783 ????????
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 0b:578b ????????
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 0b:5793 ????????
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 0b:579b ????????
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:57a3 ????????
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:57ab ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:57b3 ????????
    db   $00, $00, $00, $00, $6b, $2d, $5a, $6b        ;; 0b:57bb ????????
.data_57c3_Palette: ; Palette for ??? ; 57c3
    db   $e0, $01, $e0, $01, $e0, $01, $e0, $01        ;; 0b:57c3 ????????
    db   $00, $00, $8d, $00, $74, $01, $bc, $02        ;; 0b:57cb ????????
    db   $00, $00, $0c, $01, $36, $02, $00, $7c        ;; 0b:57d3 ????????
    db   $00, $00, $0c, $01, $36, $02, $bc, $02        ;; 0b:57db ????????
    db   $00, $00, $0c, $01, $36, $02, $7f, $33        ;; 0b:57e3 ????????
    db   $00, $00, $05, $25, $4e, $52, $12, $6f        ;; 0b:57eb ????????
    db   $00, $00, $8d, $00, $36, $02, $bc, $02        ;; 0b:57f3 ????????
    db   $00, $00, $3b, $04, $41, $69, $e0, $76        ;; 0b:57fb ????????
.image_great_job_00c_2_palette: ; Palette for "Great Job! Thanks for Playing- The GEX Team" ; 5803
    INCBIN "gfx/menus/palettes/image_great_job_00c_2_palette.bin"
.image_splash_01f_1_palette: ; Palette for first title screen splash (gex enter the gecko) ; 5843
    INCBIN "gfx/menus/palettes/image_splash_01f_1_palette.bin"
.image_crave_01f_0_palette: ; Palette for 2nd title screen splash (CRAVE entertainment) ; 5883
    INCBIN "gfx/menus/palettes/image_crave_01f_0_palette.bin"
.image_david_01e_0_palette: ; Palette for 3rd title screen splash (David A Palmer Productions) ; 58c3
    INCBIN "gfx/menus/palettes/image_david_01e_0_palette.bin"
.data_5903_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:5903 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:590b ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5913 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:591b ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5923 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:592b ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5933 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:593b ........
.data_5943_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:5943 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:594b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5953 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:595b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5963 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:596b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5973 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:597b ????????
.data_5983_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:5983 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:598b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5993 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:599b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59a3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59ab ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59b3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59bb ????????
.data_59c3_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:59c3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59cb ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59d3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59db ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59e3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59eb ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59f3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59fb ????????
.data_5a03_Palette: ; unknown palette. may be unused.
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a03 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a0b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a13 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a1b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a23 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a2b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a33 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a3b ????????
; unknown palette. may be unused.
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a43 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a4b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a53 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a5b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a63 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a6b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a73 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a7b ????????
.data_5a83_Palette: ; Palette for "Entering <level>" screen, also the 4 pause screens (main, exit to map, quit game, totals)
    db   $00, $00, $00, $02, $00, $00, $e0, $03        ;; 0b:5a83 ........
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 0b:5a8b ........
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 0b:5a93 ........
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 0b:5a9b ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:5aa3 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:5aab ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5ab3 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5abb ........
; unknown palette
    db   $00, $00, $00, $02, $00, $00, $e0, $03        ;; 0b:5ac3 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5acb ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5ad3 ........
    db   $00, $00, $0f, $00, $17, $00, $1f, $00        ;; 0b:5adb ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:5ae3 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:5aeb ........
    db   $00, $00, $00, $00, $20, $03, $bf, $0b        ;; 0b:5af3 ........
    db   $00, $00, $1f, $00, $ff, $01, $7f, $03        ;; 0b:5afb ........
.data_gex_object_palette2:
    db   $00, $00, $00, $00, $8a, $02, $fd, $03        ;; 0b:5b03 ........
.palette_media_dimension:
    INCBIN "gfx/tilesets/palettes/palette_media_dimension.bin"
.palette_toon_tv:
    INCBIN "gfx/tilesets/palettes/palette_toon_tv.bin"
.palette_scream_tv:
    INCBIN "gfx/tilesets/palettes/palette_scream_tv.bin"
.palette_circuit_central:
    INCBIN "gfx/tilesets/palettes/palette_circuit_central.bin"
.palette_kung_fu_theater:
    INCBIN "gfx/tilesets/palettes/palette_kung_fu_theater.bin"
.palette_kung_fu_theater2:
    INCBIN "gfx/tilesets/palettes/palette_kung_fu_theater2.bin"
.palette_prehistory_channel:
    INCBIN "gfx/tilesets/palettes/palette_prehistory_channel.bin"
.palette_rezopolis:
    INCBIN "gfx/tilesets/palettes/palette_rezopolis.bin"
.palette_channel_z:
    INCBIN "gfx/tilesets/palettes/palette_channel_z.bin"

call_0b_5d4b:
    ld   A, [wD59E]                                    ;; 0b:5d4b $fa $9e $d5
    and  A, A                                          ;; 0b:5d4e $a7
    ret  Z                                             ;; 0b:5d4f $c8
    call call_00_2e3a_GetTVPaletteId                                  ;; 0b:5d50 $cd $3a $2e
    ld   DE, .data_0b_5d62                             ;; 0b:5d53 $11 $62 $5d
    call call_00_07b9                                  ;; 0b:5d56 $cd $b9 $07
    ld   DE, wDA7B                                     ;; 0b:5d59 $11 $7b $da
    ld   BC, $10                                       ;; 0b:5d5c $01 $10 $00
    jp   call_00_07b0_MemCopy                                  ;; 0b:5d5f $c3 $b0 $07
.data_0b_5d62:
    dw   $0000
    dw   .circuit_central_television_palette
    dw   .kung_fu_theater_television_palette
    dw   .prehistory_channel_television_palette        ;; 0b:5d62 ????????
    dw   .rezopolis_television_palette
    dw   $0000
    dw   .scream_tv_television_palette
    dw   .toon_tv_television_palette        ;; 0b:5d6a ????....
    dw   .bonus_tv_television_palette
    dw   $0000
    dw   .channel_z_television_palette
.scream_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/scream_tv_television_palette.bin"
.toon_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/toon_tv_television_palette.bin"
.prehistory_channel_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/prehistory_channel_television_palette.bin"
.circuit_central_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/circuit_central_television_palette.bin"
.kung_fu_theater_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/kung_fu_theater_television_palette.bin"
.channel_z_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/channel_z_television_palette.bin"
.rezopolis_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/rezopolis_television_palette.bin"
.bonus_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/bonus_tv_television_palette.bin"

call_0b_5df8:
    ld   A, [wD59E]                                    ;; 0b:5df8 $fa $9e $d5
    and  A, A                                          ;; 0b:5dfb $a7
    ret  Z                                             ;; 0b:5dfc $c8
    ld   A, [wD624_CurrentLevelId]                                    ;; 0b:5dfd $fa $24 $d6
    and  A, A                                          ;; 0b:5e00 $a7
    ret  NZ                                            ;; 0b:5e01 $c0
    ld   HL, wD72D_CurrentSecondaryTilesetIndex                                     ;; 0b:5e02 $21 $2d $d7
    ld   L, [HL]                                       ;; 0b:5e05 $6e
    ld   H, $00                                        ;; 0b:5e06 $26 $00
    add  HL, HL                                        ;; 0b:5e08 $29
    ld   DE, .media_dimension_tv_palettes                             ;; 0b:5e09 $11 $1b $5e
    add  HL, DE                                        ;; 0b:5e0c $19
    ld   A, [HL+]                                      ;; 0b:5e0d $2a
    ld   H, [HL]                                       ;; 0b:5e0e $66
    ld   L, A                                          ;; 0b:5e0f $6f
    or   A, H                                          ;; 0b:5e10 $b4
    ret  Z                                             ;; 0b:5e11 $c8
    ld   DE, wD9FB                                     ;; 0b:5e12 $11 $fb $d9
    ld   BC, $10                                       ;; 0b:5e15 $01 $10 $00
    jp   call_00_07b0_MemCopy                                  ;; 0b:5e18 $c3 $b0 $07
.media_dimension_tv_palettes:
    dw   .scream_tv_television_palette
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    dw   .toon_tv_television_palette
    dw   .prehistory_channel_television_palette
    dw   .circuit_central_television_palette
    dw   .kung_fu_theater_television_palette
    dw   .channel_z_television_palette
    dw   .rezopolis_television_palette
    dw   .bonus_tv_television_palette
.scream_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/scream_tv_television_palette.bin"
.toon_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/toon_tv_television_palette.bin"
.prehistory_channel_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/prehistory_channel_television_palette.bin"
.circuit_central_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/circuit_central_television_palette.bin"
.kung_fu_theater_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/kung_fu_theater_television_palette.bin"
.channel_z_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/channel_z_television_palette.bin"
.rezopolis_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/rezopolis_television_palette.bin"
.bonus_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/bonus_tv_television_palette.bin"

call_0b_5ec3:
    ld   A, [wD59E]                                    ;; 0b:5ec3 $fa $9e $d5
    and  A, A                                          ;; 0b:5ec6 $a7
    ret  Z                                             ;; 0b:5ec7 $c8
    ld   A, [wD73B]                                    ;; 0b:5ec8 $fa $3b $d7
    and  A, $1f                                        ;; 0b:5ecb $e6 $1f
    cp   A, $08                                        ;; 0b:5ecd $fe $08
    jr   C, .jr_0b_5eef                                ;; 0b:5ecf $38 $1e
    ld   HL, wD751                                     ;; 0b:5ed1 $21 $51 $d7
    ld   A, [HL+]                                      ;; 0b:5ed4 $2a
    or   A, [HL]                                       ;; 0b:5ed5 $b6
    ld   HL, .data_0b_5efb                             ;; 0b:5ed6 $21 $fb $5e
    jr   NZ, .jr_0b_5ef2                               ;; 0b:5ed9 $20 $17
    ld   HL, wD755                                     ;; 0b:5edb $21 $55 $d7
    ld   A, [HL+]                                      ;; 0b:5ede $2a
    or   A, [HL]                                       ;; 0b:5edf $b6
    ld   HL, .data_0b_5f03                             ;; 0b:5ee0 $21 $03 $5f
    jr   NZ, .jr_0b_5ef2                               ;; 0b:5ee3 $20 $0d
    ld   HL, wD753                                     ;; 0b:5ee5 $21 $53 $d7
    ld   A, [HL+]                                      ;; 0b:5ee8 $2a
    or   A, [HL]                                       ;; 0b:5ee9 $b6
    ld   HL, .data_0b_5f03                             ;; 0b:5eea $21 $03 $5f
    jr   NZ, .jr_0b_5ef2                               ;; 0b:5eed $20 $03
.jr_0b_5eef:
    ld   HL, .data_gex_object_palette                             ;; 0b:5eef $21 $13 $5f
.jr_0b_5ef2:
    ld   DE, wDA0B_Obj_Palettes                                     ;; 0b:5ef2 $11 $0b $da
    ld   BC, $08                                       ;; 0b:5ef5 $01 $08 $00
    jp   call_00_07b0_MemCopy                                  ;; 0b:5ef8 $c3 $b0 $07
.data_0b_5efb:
    db   $00, $00, $64, $02, $f5, $3b, $ff, $43        ;; 0b:5efb ????????
.data_0b_5f03:
    db   $00, $00, $55, $01, $7f, $02, $ff, $03        ;; 0b:5f03 ????????
    db   $00, $00, $40, $45, $af, $7e, $f5, $7f        ;; 0b:5f0b ????????
.data_gex_object_palette:
    db   $00, $00, $00, $00, $8a, $02, $fd, $03        ;; 0b:5f13 ........
    
    ld   A, [wD59E]                                    ;; 0b:5f1b $fa $9e $d5
    and  A, A                                          ;; 0b:5f1e $a7
    ret  Z                                             ;; 0b:5f1f $c8
    ld   A, [wD742_PlayerCurrentFly]                                    ;; 0b:5f20 $fa $42 $d7
    dec  A                                             ;; 0b:5f23 $3d
    ld   L, A                                          ;; 0b:5f24 $6f
    ld   H, $00                                        ;; 0b:5f25 $26 $00
    add  HL, HL                                        ;; 0b:5f27 $29
    add  HL, HL                                        ;; 0b:5f28 $29
    add  HL, HL                                        ;; 0b:5f29 $29
    ld   DE, .data_0b_5f37                             ;; 0b:5f2a $11 $37 $5f
    add  HL, DE                                        ;; 0b:5f2d $19
    ld   DE, wDA1B                                     ;; 0b:5f2e $11 $1b $da
    ld   BC, $08                                       ;; 0b:5f31 $01 $08 $00
    jp   call_00_07b0_MemCopy                                  ;; 0b:5f34 $c3 $b0 $07
.data_0b_5f37:
    db   $00, $00, $00, $00, $94, $52, $9c, $73        ;; 0b:5f37 ????????
    db   $00, $00, $00, $00, $14, $00, $1c, $00        ;; 0b:5f3f ????????
    db   $00, $00, $00, $00, $00, $50, $00, $70        ;; 0b:5f47 ????????
    db   $00, $00, $00, $00, $00, $03, $00, $03        ;; 0b:5f4f ????????

call_0b_5f57:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 0b:5f57 $fa $00 $d3
    rlca                                               ;; 0b:5f5a $07
    rlca                                               ;; 0b:5f5b $07
    rlca                                               ;; 0b:5f5c $07
    and  A, $07                                        ;; 0b:5f5d $e6 $07
    ld   L, A                                          ;; 0b:5f5f $6f
    ld   H, $00                                        ;; 0b:5f60 $26 $00
    ld   DE, wD32D                                     ;; 0b:5f62 $11 $2d $d3
    add  HL, DE                                        ;; 0b:5f65 $19
    ld   A, C                                          ;; 0b:5f66 $79
    ld   [HL], A                                       ;; 0b:5f67 $77
    ld   L, A                                          ;; 0b:5f68 $6f
    ld   H, $00                                        ;; 0b:5f69 $26 $00
    add  HL, HL                                        ;; 0b:5f6b $29
    add  HL, HL                                        ;; 0b:5f6c $29
    add  HL, HL                                        ;; 0b:5f6d $29
    ld   DE, wDA0B_Obj_Palettes                                     ;; 0b:5f6e $11 $0b $da
    add  HL, DE                                        ;; 0b:5f71 $19
    ld   E, L                                          ;; 0b:5f72 $5d
    ld   D, H                                          ;; 0b:5f73 $54
    ld   H, $d2                                        ;; 0b:5f74 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 0b:5f76 $fa $00 $d3
    or   A, $00                                        ;; 0b:5f79 $f6 $00
    ld   L, A                                          ;; 0b:5f7b $6f
    ld   L, [HL]                                       ;; 0b:5f7c $6e
    ld   H, $00                                        ;; 0b:5f7d $26 $00
    add  HL, HL                                        ;; 0b:5f7f $29
    add  HL, HL                                        ;; 0b:5f80 $29
    add  HL, HL                                        ;; 0b:5f81 $29
    ld   BC, .data_object_palettes                             ;; 0b:5f82 $01 $9e $5f
    add  HL, BC                                        ;; 0b:5f85 $09
    ld   A, [HL+]                                      ;; 0b:5f86 $2a
    ld   [DE], A                                       ;; 0b:5f87 $12
    inc  DE                                            ;; 0b:5f88 $13
    ld   A, [HL+]                                      ;; 0b:5f89 $2a
    ld   [DE], A                                       ;; 0b:5f8a $12
    inc  DE                                            ;; 0b:5f8b $13
    ld   A, [HL+]                                      ;; 0b:5f8c $2a
    ld   [DE], A                                       ;; 0b:5f8d $12
    inc  DE                                            ;; 0b:5f8e $13
    ld   A, [HL+]                                      ;; 0b:5f8f $2a
    ld   [DE], A                                       ;; 0b:5f90 $12
    inc  DE                                            ;; 0b:5f91 $13
    ld   A, [HL+]                                      ;; 0b:5f92 $2a
    ld   [DE], A                                       ;; 0b:5f93 $12
    inc  DE                                            ;; 0b:5f94 $13
    ld   A, [HL+]                                      ;; 0b:5f95 $2a
    ld   [DE], A                                       ;; 0b:5f96 $12
    inc  DE                                            ;; 0b:5f97 $13
    ld   A, [HL+]                                      ;; 0b:5f98 $2a
    ld   [DE], A                                       ;; 0b:5f99 $12
    inc  DE                                            ;; 0b:5f9a $13
    ld   A, [HL]                                       ;; 0b:5f9b $7e
    ld   [DE], A                                       ;; 0b:5f9c $12
    ret                                                ;; 0b:5f9d $c9
.data_object_palettes:
    INCBIN "gfx/object_sprites/object_palettes.bin"

call_0b_641e:
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:641e $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:6421 $6e
    ld   H, $00                                        ;; 0b:6422 $26 $00
    add  HL, HL                                        ;; 0b:6424 $29
    ld   DE, .data_level_palette_ids                             ;; 0b:6425 $11 $35 $64
    add  HL, DE                                        ;; 0b:6428 $19
    ld   A, [HL+]                                      ;; 0b:6429 $2a
    ld   H, [HL]                                       ;; 0b:642a $66
    ld   L, A                                          ;; 0b:642b $6f
    ld   DE, wCF00_SecondaryTilesetPaletteIds                                     ;; 0b:642c $11 $00 $cf
.jr_0b_642f:
    ld   A, [HL+]                                      ;; 0b:642f $2a
    ld   [DE], A                                       ;; 0b:6430 $12
    inc  E                                             ;; 0b:6431 $1c
    jr   NZ, .jr_0b_642f                               ;; 0b:6432 $20 $fb
    ret                                                ;; 0b:6434 $c9
.data_level_palette_ids:                                      ;; 0b:6435
    dw   .palette_ids_media_dimension
    dw   .palette_ids_toon_tv
    dw   .palette_ids_scream_tv
    dw   .palette_ids_scream_tv
    dw   .palette_ids_circuit_central
    dw   .palette_ids_kung_fu_theater
    dw   .palette_ids_media_dimension
    dw   .palette_ids_prehistory_channel
    dw   .palette_ids_toon_tv
    dw   .palette_ids_prehistory_channel
    dw   .palette_ids_circuit_central
    dw   .palette_ids_scream_tv
    dw   .palette_ids_media_dimension
    dw   .palette_ids_kung_fu_theater
    dw   .palette_ids_rezopolis
    dw   .palette_ids_media_dimension
    dw   .palette_ids_scream_tv
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_kung_fu_theater
    dw   .palette_ids_rezopolis
    dw   .palette_ids_circuit_central
    dw   .palette_ids_prehistory_channel
    dw   .palette_ids_scream_tv
    dw   .palette_ids_rezopolis
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_channel_z
.palette_ids_media_dimension:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_media_dimension.bin"
.palette_ids_toon_tv:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_toon_tv.bin"
.palette_ids_scream_tv:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_scream_tv.bin"
.palette_ids_circuit_central:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_circuit_central.bin"
.palette_ids_kung_fu_theater:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_kung_fu_theater.bin"
.palette_ids_prehistory_channel:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_prehistory_channel.bin"
.palette_ids_rezopolis:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_rezopolis.bin"
.palette_ids_channel_z:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_channel_z.bin"
