call_00_2e3a_GetTVPaletteId:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e3a $cd $b0 $2e
    ld   DE, $00                                       ;; 00:2e3d $11 $00 $00
    add  HL, DE                                        ;; 00:2e40 $19
    ld   A, [HL]                                       ;; 00:2e41 $7e
    ret                                                ;; 00:2e42 $c9

call_00_2e43_GetRemoteProgressId:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e43 $cd $b0 $2e
    ld   DE, $01                                       ;; 00:2e46 $11 $01 $00
    add  HL, DE                                        ;; 00:2e49 $19
    ld   A, [HL]                                       ;; 00:2e4a $7e
    ret                                                ;; 00:2e4b $c9

call_00_2e4c:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e4c $cd $b0 $2e
    ld   DE, $02                                       ;; 00:2e4f $11 $02 $00
    add  HL, DE                                        ;; 00:2e52 $19
    ld   E, [HL]                                       ;; 00:2e53 $5e
    inc  HL                                            ;; 00:2e54 $23
    ld   D, [HL]                                       ;; 00:2e55 $56
    ld   HL, $00                                       ;; 00:2e56 $21 $00 $00
    add  HL, DE                                        ;; 00:2e59 $19
    ld   E, [HL]                                       ;; 00:2e5a $5e
    inc  HL                                            ;; 00:2e5b $23
    ld   H, [HL]                                       ;; 00:2e5c $66
    ld   L, E                                          ;; 00:2e5d $6b
    ret                                                ;; 00:2e5e $c9

call_00_2e5f:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e5f $cd $b0 $2e
    ld   DE, $02                                       ;; 00:2e62 $11 $02 $00
    add  HL, DE                                        ;; 00:2e65 $19
    ld   E, [HL]                                       ;; 00:2e66 $5e
    inc  HL                                            ;; 00:2e67 $23
    ld   D, [HL]                                       ;; 00:2e68 $56 ; DE is now 0x2-0x3 in the level data
    ld   HL, $02                                       ;; 00:2e69 $21 $02 $00
    add  HL, DE                                        ;; 00:2e6c $19 ; HL is 2 + DE
    add  A, A                                          ;; 00:2e6d $87
    ld   E, A                                          ;; 00:2e6e $5f
    ld   D, $00                                        ;; 00:2e6f $16 $00
    add  HL, DE                                        ;; 00:2e71 $19 ; HL is 2 + 0x2-0x3 in the level data + A*2
    ld   E, [HL]                                       ;; 00:2e72 $5e
    inc  HL                                            ;; 00:2e73 $23
    ld   H, [HL]                                       ;; 00:2e74 $66
    ld   L, E                                          ;; 00:2e75 $6b ; HL is value in [2 + 0x2-0x3 in the level data + A*2]
    ret                                                ;; 00:2e76 $c9

call_00_2e77_GetCurrentMapBankNumber:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e77 $cd $b0 $2e
    ld   DE, $04                                       ;; 00:2e7a $11 $04 $00
    add  HL, DE                                        ;; 00:2e7d $19
    ld   A, [HL]                                       ;; 00:2e7e $7e
    ret                                                ;; 00:2e7f $c9

call_00_2e80_GetCurrentSecondaryTilesetBank:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e80 $cd $b0 $2e
    ld   DE, $05                                       ;; 00:2e83 $11 $05 $00
    add  HL, DE                                        ;; 00:2e86 $19
    ld   A, [HL]                                       ;; 00:2e87 $7e
    ret                                                ;; 00:2e88 $c9

call_00_2e89_GetCurrentBlocksetBank:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e89 $cd $b0 $2e
    ld   DE, $06                                       ;; 00:2e8c $11 $06 $00
    add  HL, DE                                        ;; 00:2e8f $19
    ld   A, [HL]                                       ;; 00:2e90 $7e
    ret                                                ;; 00:2e91 $c9
    ret                                                ;; 00:2e92 $c9

call_00_2e93_GetBlocksetOverrideBit:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e93 $cd $b0 $2e
    ld   DE, $08                                       ;; 00:2e96 $11 $08 $00
    add  HL, DE                                        ;; 00:2e99 $19
    ld   A, [HL]                                       ;; 00:2e9a $7e
    ret                                                ;; 00:2e9b $c9

call_00_2e9c_GetCurrentBgTilesetBank:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e9c $cd $b0 $2e
    ld   DE, $09                                       ;; 00:2e9f $11 $09 $00
    add  HL, DE                                        ;; 00:2ea2 $19
    ld   A, [HL]                                       ;; 00:2ea3 $7e
    ret                                                ;; 00:2ea4 $c9

call_00_2ea5:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2ea5 $cd $b0 $2e
    ld   DE, $0a                                       ;; 00:2ea8 $11 $0a $00
    add  HL, DE                                        ;; 00:2eab $19
    ld   E, [HL]                                       ;; 00:2eac $5e
    inc  HL                                            ;; 00:2ead $23
    ld   D, [HL]                                       ;; 00:2eae $56
    ret                                                ;; 00:2eaf $c9

call_00_2eb0_GetLevelDataAddr:
    ld   HL, wD624_CurrentLevelId                                     ;; 00:2eb0 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:2eb3 $6e
    ld   H, $00                                        ;; 00:2eb4 $26 $00
    add  HL, HL                                        ;; 00:2eb6 $29
    add  HL, HL                                        ;; 00:2eb7 $29
    add  HL, HL                                        ;; 00:2eb8 $29
    add  HL, HL                                        ;; 00:2eb9 $29
    ld   DE, .data_LevelData                                     ;; 00:2eba $11 $bf $2e
    add  HL, DE                                        ;; 00:2ebd $19
    ret                                                ;; 00:2ebe $c9 ; HL is now the pointer to the level data
.data_LevelData:
; List of which banks to use for each of the 31 maps. 0x10 bytes each
; 0x0 tv palette number (index into .data_0b_5d62)
; 0x1 remote progress related
; 0x2-0x3 is a pointer to the level's text (level name, mission names)
; 0x4 is map bank number
; 0x5 is blockset override bank
; 0x6 is blockset/collision data bank
; 0x7 unused (always 0)
; 0x8 is the bit to use in the blockset override data bank
; 0x9 is tileset bank
; 0xa-0xb is tileset bank offset
; 0xc unused (always 0)
; 0xd unused (always 0)
; 0xe unused (always 0)
; 0xf unused (always 0)
    db   $00, $06                                      ;; 00:2ebf ?w
    dw   data_01_5f88                                         ;; 00:2ec1 wW
    db   $30, $34, $38, $00, $04, $36, $00, $40        ;; 00:2ec3 ...?....
    db   $00, $00, $00, $00
    
    db   $07, $00                  ;; 00:2ecb ????ww
    dw   data_01_5fa7                                         ;; 00:2ed1 wW
    db   $31, $34, $39, $00, $08, $36, $00, $50        ;; 00:2ed3 ...?....
    db   $00, $00, $00, $00
    
    db   $06, $00                  ;; 00:2edb ????ww
    dw   data_01_6007                                         ;; 00:2ee1 wW
    db   $32, $34, $3a, $00, $02, $36, $00, $60        ;; 00:2ee3 ...?....
    db   $00, $00, $00, $00
    
    db   $06, $00                  ;; 00:2eeb ?????w
    dw   data_01_606a                                         ;; 00:2ef1 wW
    db   $33, $34, $3a, $00, $01, $36, $00, $60        ;; 00:2ef3 ????????
    db   $00, $00, $00, $00
    
    db   $01, $01                  ;; 00:2efb ?????w
    dw   data_01_60ca                                         ;; 00:2f01 wW
    db   $25, $35, $3b, $00, $02, $36, $00, $70        ;; 00:2f03 ????????
    db   $00, $00, $00, $00
    
    db   $02, $01                  ;; 00:2f0b ?????w
    dw   data_01_611b                                         ;; 00:2f11 wW
    db   $2d, $34, $3c, $00, $80, $37, $00, $40        ;; 00:2f13 ????????
    db   $00, $00, $00, $00
    
    db   $05, $06
    dw   data_01_615f        ;; 00:2f1b ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:2f23 ????????
    db   $00, $00, $00, $00
    
    db   $03, $01                  ;; 00:2f2b ?????w
    dw   data_01_616b                                         ;; 00:2f31 wW
    db   $2e, $34, $3e, $00, $10, $37, $00, $50        ;; 00:2f33 ????????
    db   $00, $00, $00, $00
    
    db   $07, $01                  ;; 00:2f3b ?????w
    dw   data_01_61ac                                         ;; 00:2f41 wW
    db   $31, $34, $39, $00, $08, $36, $00, $50        ;; 00:2f43 ????????
    db   $00, $00, $00, $00
    
    db   $03, $00                  ;; 00:2f4b ?????w
    dw   data_01_61e2                                         ;; 00:2f51 wW
    db   $2f, $34, $3e, $00, $20, $37, $00, $50        ;; 00:2f53 ????????
    db   $00, $00, $00, $00
    
    db   $01, $00                  ;; 00:2f5b ?????w
    dw   data_01_623d                                         ;; 00:2f61 wW
    db   $2a, $35, $3b, $00, $08, $36, $00, $70        ;; 00:2f63 ????????
    db   $00, $00, $00, $00
    
    db   $06, $00                  ;; 00:2f6b ?????w
    dw   data_01_629b                                         ;; 00:2f71 wW
    db   $32, $34, $3a, $00, $02, $36, $00, $60        ;; 00:2f73 ????????
    db   $00, $00, $00, $00
    
    db   $05, $06
    dw   data_01_62fa                     ;; 00:2f7b ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:2f83 ????????
    db   $00, $00, $00, $00
    
    db   $02, $00                  ;; 00:2f8b ?????w
    dw   data_01_6306                                         ;; 00:2f91 wW
    db   $2c, $34, $3c, $00, $40, $37, $00, $40        ;; 00:2f93 ????????
    db   $00, $00, $00, $00
    
    db   $04, $02                  ;; 00:2f9b ?????w
    dw   data_01_6372                                         ;; 00:2fa1 wW
    db   $29, $35, $3f, $00, $01, $37, $00, $60        ;; 00:2fa3 ????????
    db   $00, $00, $00, $00
    
    db   $08, $06
    dw   data_01_63b4        ;; 00:2fab ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:2fb3 ????????
    db   $00, $00, $00, $00
    
    db   $08, $05                  ;; 00:2fbb ?????w
    dw   data_01_63c0                                         ;; 00:2fc1 wW
    db   $32, $34, $3a, $00, $02, $36, $00, $60        ;; 00:2fc3 ????????
    db   $00, $00, $00, $00
    
    db   $08, $06
    dw   data_01_63fd        ;; 00:2fcb ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:2fd3 ????????
    db   $00, $00, $00, $00
    
    db   $08, $06
    dw   data_01_6409        ;; 00:2fdb ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:2fe3 ????????
    db   $00, $00, $00, $00
    
    db   $08, $06
    dw   data_01_6415        ;; 00:2feb ?????w??
    db   $32, $34, $3f, $00, $00, $36, $00, $40        ;; 00:2ff3 ????????
    db   $00, $00, $00, $00
    
    db   $08, $06
    dw   data_01_6421        ;; 00:2ffb ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:3003 ????????
    db   $00, $00, $00, $00
    
    db   $08, $05                  ;; 00:300b ?????w
    dw   data_01_642d                                         ;; 00:3011 wW
    db   $2c, $34, $3c, $00, $40, $37, $00, $40        ;; 00:3013 ????????
    db   $00, $00, $00, $00
    
    db   $08, $05                  ;; 00:301b ?????w
    dw   data_01_646f                                         ;; 00:3021 wW
    db   $29, $35, $3f, $00, $01, $37, $00, $60        ;; 00:3023 ????????
    db   $00, $00, $00, $00
    
    db   $08, $05                  ;; 00:302b ?????w
    dw   data_01_64a5                                         ;; 00:3031 wW
    db   $2b, $35, $3b, $00, $04, $36, $00, $70        ;; 00:3033 ????????
    db   $00, $00, $00, $00
    
    db   $03, $04                  ;; 00:303b ?????w
    dw   data_01_64df                                         ;; 00:3041 wW
    db   $2f, $34, $3e, $00, $20, $37, $00, $50        ;; 00:3043 ????????
    db   $00, $00, $00, $00
    
    db   $06, $04                  ;; 00:304b ?????w
    dw   data_01_6512                                         ;; 00:3051 wW
    db   $33, $34, $3a, $00, $01, $36, $00, $60        ;; 00:3053 ????????
    db   $00, $00, $00, $00
    
    db   $04, $03                  ;; 00:305b ?????w
    dw   data_01_6550                                         ;; 00:3061 wW
    db   $29, $35, $3f, $00, $01, $37, $00, $60        ;; 00:3063 ????????
    db   $00, $00, $00, $00
    
    db   $0a, $06
    dw   data_01_65a7        ;; 00:306b ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:3073 ????????
    db   $00, $00, $00, $00
    
    db   $0a, $06
    dw   data_01_65b3        ;; 00:307b ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:3083 ????????
    db   $00, $00, $00, $00
    
    db   $0a, $06
    dw   data_01_65bf        ;; 00:308b ?????w??
    db   $32, $34, $38, $00, $00, $36, $00, $40        ;; 00:3093 ????????
    db   $00, $00, $00, $00
    
    db   $0a, $05
    dw   data_01_65cb        ;; 00:309b ????????
    db   $28, $35, $27, $00, $10, $26, $00, $40        ;; 00:30a3 ????????
    db   $00, $00, $00, $00                            ;; 00:30ab ????
