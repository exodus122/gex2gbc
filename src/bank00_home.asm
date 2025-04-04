;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "bank00", ROM0[$0000]
    db   $d9                                           ;; 00:0000 ?

SECTION "isrVBlank", ROM0[$0040]

isrVBlank:
    jp   call_00_0a54                                    ;; 00:0040 $c3 $54 $0a

SECTION "isrLCDC", ROM0[$0048]

isrLCDC:
    jp   wCCA0                                         ;; 00:0048 $c3 $a0 $cc

SECTION "isrTimer", ROM0[$0050]

isrTimer:
    reti                                               ;; 00:0050 $d9

SECTION "isrSerial", ROM0[$0058]

isrSerial:
    reti                                               ;; 00:0058 $d9

SECTION "isrJoypad", ROM0[$0060]

isrJoypad:
    reti                                               ;; 00:0060 $d9

SECTION "entry", ROM0[$0100]

; for list of entry functions, search: "entry_[_0-9A-Za-z]*:"
; for list of call/entry functions, search: "(call|entry)_[_0-9A-Za-z]*:"

entry:
    nop                                                ;; 00:0100 $00
    jp   call_00_0150_Init                                   ;; 00:0101 $c3 $50 $01
    ds   $30                                           ;; 00:0104
    db   "GEX GECKO", $00, $00, $00, $00, $00, $00     ;; 00:0134
    db   CART_COMPATIBLE_DMG_GBC                       ;; 00:0143
    db   $34, $5a                                      ;; 00:0144 ??
    db   CART_INDICATOR_GB                             ;; 00:0146
    db   CART_ROM_MBC5, CART_ROM_1024KB, CART_SRAM_NONE ;; 00:0147
    db   CART_DEST_NON_JAPANESE, $33, $00              ;; 00:014a $01 $33 $00
    ds   3                                             ;; 00:014d

SECTION "bank00_0150", ROM0[$0150]

call_00_0150_Init:
; Entry point of the code
    di                                                 ;; 00:0150 $f3
    ld   SP, $fffe                                     ;; 00:0151 $31 $fe $ff
    push AF                                            ;; 00:0154 $f5
    cp   A, $11                                        ;; 00:0155 $fe $11
    jr   NZ, .jr_00_015d                               ;; 00:0157 $20 $04
    ld   A, $01                                        ;; 00:0159 $3e $01
    ldh  [rSVBK], A                                    ;; 00:015b $e0 $70
.jr_00_015d:
    ldh  A, [rLY]                                      ;; 00:015d $f0 $44
    cp   A, $91                                        ;; 00:015f $fe $91
    jr   NZ, .jr_00_015d                               ;; 00:0161 $20 $fa
    ldh  A, [rLCDC]                                    ;; 00:0163 $f0 $40
    and  A, $7f                                        ;; 00:0165 $e6 $7f
    ldh  [rLCDC], A                                    ;; 00:0167 $e0 $40
    xor  A, A                                          ;; 00:0169 $af
    ld   [MBC1SRamEnable], A                           ;; 00:016a $ea $01 $00
    ld   [MBC1SRamBankingMode], A                                    ;; 00:016d $ea $01 $60
    ld   HL, wC000_BgMapTileIds                                     ;; 00:0170 $21 $00 $c0
    ld   DE, $c001                                     ;; 00:0173 $11 $01 $c0
    ld   BC, $1fff                                     ;; 00:0176 $01 $ff $1f
    ld   [HL], $00                                     ;; 00:0179 $36 $00
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:017b $cd $b0 $07
    xor  A, A                                          ;; 00:017e $af
    ldh  [rSCX], A                                     ;; 00:017f $e0 $43
    ldh  [rSCY], A                                     ;; 00:0181 $e0 $42
    ld   [wD59E], A                                    ;; 00:0183 $ea $9e $d5
    ld   A, $07                                        ;; 00:0186 $3e $07
    ldh  [rWX], A                                      ;; 00:0188 $e0 $4b
    ld   A, $8f                                        ;; 00:018a $3e $8f
    ldh  [rWY], A                                      ;; 00:018c $e0 $4a
    ld   A, $e4                                        ;; 00:018e $3e $e4
    ld   [wDACB], A                                    ;; 00:0190 $ea $cb $da
    ld   [wDACC], A                                    ;; 00:0193 $ea $cc $da
    ld   A, $00                                        ;; 00:0196 $3e $00
    ld   [wDACD], A                                    ;; 00:0198 $ea $cd $da
    pop  AF                                            ;; 00:019b $f1
    cp   A, $11                                        ;; 00:019c $fe $11
    jr   NZ, .jr_00_01ac                               ;; 00:019e $20 $0c
    ld   A, $01                                        ;; 00:01a0 $3e $01
    ld   [wD59E], A                                    ;; 00:01a2 $ea $9e $d5
    ld   A, $00                                        ;; 00:01a5 $3e $00
    ldh  [rVBK], A                                     ;; 00:01a7 $e0 $4f
    call call_00_0f9d_UpdateLCDPalettes                ;; 00:01a9 $cd $9d $0f
.jr_00_01ac:
    ld   HL, $ef7                                      ;; 00:01ac $21 $f7 $0e
    ld   DE, hFF80                                     ;; 00:01af $11 $80 $ff
    ld   BC, $0a                                       ;; 00:01b2 $01 $0a $00
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:01b5 $cd $b0 $07
    call call_00_0e87                                  ;; 00:01b8 $cd $87 $0e
    ld   HL, wD59A                                     ;; 00:01bb $21 $9a $d5
    ld   DE, wD58A                                     ;; 00:01be $11 $8a $d5
    ld   A, $01                                        ;; 00:01c1 $3e $01
    ld   [HL], E                                       ;; 00:01c3 $73
    inc  HL                                            ;; 00:01c4 $23
    ld   [HL], D                                       ;; 00:01c5 $72
    ld   [wD59C_CurrentROMBank], A                                    ;; 00:01c6 $ea $9c $d5
    ld   [DE], A                                       ;; 00:01c9 $12
    ld   [MBC1RomBank], A                                    ;; 00:01ca $ea $01 $20
    swap A                                             ;; 00:01cd $cb $37
    rrca                                               ;; 00:01cf $0f
    and  A, $01                                        ;; 00:01d0 $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:01d2 $ea $01 $40
    ld   A, $00                                        ;; 00:01d5 $3e $00
    call call_00_0bb9                                  ;; 00:01d7 $cd $b9 $0b
    xor  A, A                                          ;; 00:01da $af
    ldh  [rIF], A                                      ;; 00:01db $e0 $0f
    ld   A, $08                                        ;; 00:01dd $3e $08
    ldh  [rSTAT], A                                    ;; 00:01df $e0 $41
    ld   A, $03                                        ;; 00:01e1 $3e $03
    ldh  [rIE], A                                      ;; 00:01e3 $e0 $ff
    ld   A, $c7                                        ;; 00:01e5 $3e $c7
    call call_00_0f32                                  ;; 00:01e7 $cd $32 $0f
    ld   A, $21                                        ;; 00:01ea $3e $21
    ld   [wD788_CurrentAudioBank], A                                    ;; 00:01ec $ea $88 $d7
    ld   [wD59D_ReturnBank], A                                    ;; 00:01ef $ea $9d $d5
    ld   A, Bank21                                        ;; 00:01f2 $3e $21
    ld   HL, entry_21_4000                              ;; 00:01f4 $21 $00 $40
    call call_00_1078_CallAltBankFunc                    ;; 00:01f7 $cd $78 $10
    ld   A, $ff                                        ;; 00:01fa $3e $ff
    ld   [wD78A_MusicId], A                                    ;; 00:01fc $ea $8a $d7
    ei                                                 ;; 00:01ff $fb
    ld   A, [wD59E]                                    ;; 00:0200 $fa $9e $d5
    and  A, A                                          ;; 00:0203 $a7
    jr   Z, .jr_00_0210                                ;; 00:0204 $28 $0a
    ld   A, $30                                        ;; 00:0206 $3e $30
    ldh  [rP1], A                                      ;; 00:0208 $e0 $00
    ld   A, $01                                        ;; 00:020a $3e $01
    ldh  [rKEY1], A                                    ;; 00:020c $e0 $4d
    stop                                               ;; 00:020e $10 $00
.jr_00_0210:
    ld   A, $03                                        ;; 00:0210 $3e $03
    ld   [wD61D], A                                    ;; 00:0212 $ea $1d $d6
    ld   [wD59D_ReturnBank], A                                    ;; 00:0215 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0218 $3e $01
    ld   HL, entry_01_4f87_LoadEnterPasswordMenu                              ;; 00:021a $21 $87 $4f
    call call_00_1078_CallAltBankFunc                    ;; 00:021d $cd $78 $10
.jp_00_0220:
    ld   A, MenuType_TitleSplash                                        ;; 00:0220 $3e $14
    ld   [wD59D_ReturnBank], A                                    ;; 00:0222 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0225 $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:0227 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:022a $cd $78 $10
    ld   A, MenuType_TitleCrave                                        ;; 00:022d $3e $13
    ld   [wD59D_ReturnBank], A                                    ;; 00:022f $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0232 $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:0234 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:0237 $cd $78 $10
    ld   A, MenuType_TitleDavid                                        ;; 00:023a $3e $16
    ld   [wD59D_ReturnBank], A                                    ;; 00:023c $ea $9d $d5
    ld   A, Bank01                                        ;; 00:023f $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:0241 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:0244 $cd $78 $10
    ld   A, MenuType_TitleScreen                                        ;; 00:0247 $3e $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:0249 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:024c $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:024e $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:0251 $cd $78 $10
.jp_00_0254:
    ld   A, Music_MediaDimension                                        ;; 00:0254 $3e $07
    call call_00_120c_SetupMusic                                  ;; 00:0256 $cd $0c $12
    xor  A, A                                          ;; 00:0259 $af
    ld   [wD61E_DemoModeEnabled], A                                    ;; 00:025a $ea $1e $d6
    ld   A, MenuType_TitleOptions                                        ;; 00:025d $3e $07
    ld   [wD59D_ReturnBank], A                                    ;; 00:025f $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0262 $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:0264 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:0267 $cd $78 $10
    cp   A, $30                                        ;; 00:026a $fe $30
    jr   Z, .jr_00_02b8                                ;; 00:026c $28 $4a
    cp   A, $10                                        ;; 00:026e $fe $10
    jr   Z, .jp_00_029d                                ;; 00:0270 $28 $2b
    cp   A, $70                                        ;; 00:0272 $fe $70
    jr   NZ, .jp_00_0254                               ;; 00:0274 $20 $de
    ld   HL, wD61D                                     ;; 00:0276 $21 $1d $d6
    ld   A, [HL]                                       ;; 00:0279 $7e
    inc  A                                             ;; 00:027a $3c
    and  A, $03                                        ;; 00:027b $e6 $03
    ld   A, $02                                        ;; 00:027d $3e $02
    ld   [HL], A                                       ;; 00:027f $77
    ld   A, $01                                        ;; 00:0280 $3e $01
    ld   [wD61E_DemoModeEnabled], A                                    ;; 00:0282 $ea $1e $d6
    ld   HL, wD61D                                     ;; 00:0285 $21 $1d $d6
    ld   L, [HL]                                       ;; 00:0288 $6e
    ld   H, $00                                        ;; 00:0289 $26 $00
    add  HL, HL                                        ;; 00:028b $29
    ld   DE, data_00_0771                                      ;; 00:028c $11 $71 $07
    add  HL, DE                                        ;; 00:028f $19
    ld   A, [HL+]                                      ;; 00:0290 $2a
    ld   [wD61B_DemoInputsPointer], A                                    ;; 00:0291 $ea $1b $d6
    ld   A, [HL]                                       ;; 00:0294 $7e
    ld   [wD61C_DemoInputsPointer], A                                    ;; 00:0295 $ea $1c $d6
    ld   A, $01                                        ;; 00:0298 $3e $01
    ld   [wD61F_DemoRelatedCounter], A                                    ;; 00:029a $ea $1f $d6
.jp_00_029d:

    ; Set Lives Remaining to 5
    ld   A, $05                                        ;; 00:029d $3e $05
    ld   [wD73D_LivesRemaining], A                     ;; 00:029f $ea $3d $d7
    
    ; Set Remote Progress bitfields to 0
    ld   HL, wD629_RemoteProgressFlags                                     ;; 00:02a2 $21 $29 $d6
    ld   B, $1e                                        ;; 00:02a5 $06 $1e
.jr_00_02a7:
    ld   [HL], $00                                     ;; 00:02a7 $36 $00
    inc  HL                                            ;; 00:02a9 $23
    dec  B                                             ;; 00:02aa $05
    jr   NZ, .jr_00_02a7                               ;; 00:02ab $20 $fa
    
    ld   [wD59D_ReturnBank], A                                    ;; 00:02ad $ea $9d $d5
    
    ; Switch to bank 1
    ld   A, Bank01                                        ;; 00:02b0 $3e $01
    ld   HL, entry_01_4349_LoadEnteringMenu                              ;; 00:02b2 $21 $49 $43
    call call_00_1078_CallAltBankFunc                    ;; 00:02b5 $cd $78 $10
.jr_00_02b8:
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:02b8 $fa $1e $d6
    and  A, A                                          ;; 00:02bb $a7
    jr   Z, .jr_00_02c9                                ;; 00:02bc $28 $0b
    ld   HL, wD61D                                     ;; 00:02be $21 $1d $d6
    ld   L, [HL]                                       ;; 00:02c1 $6e
    ld   H, $00                                        ;; 00:02c2 $26 $00
    ld   DE, $76d                                      ;; 00:02c4 $11 $6d $07
    add  HL, DE                                        ;; 00:02c7 $19
    ld   A, [HL]                                       ;; 00:02c8 $7e
.jr_00_02c9:
    ld   [wD624_CurrentLevelId], A                                    ;; 00:02c9 $ea $24 $d6
    ld   A, $08                                        ;; 00:02cc $3e $08
    ld   [wD59D_ReturnBank], A                                    ;; 00:02ce $ea $9d $d5
    ld   A, Bank01                                        ;; 00:02d1 $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:02d3 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:02d6 $cd $78 $10
    xor  A, A                                          ;; 00:02d9 $af
    ld   [wD621], A                                    ;; 00:02da $ea $21 $d6
    ld   [wD628_MediaDimensionRespawnPoint], A         ;; 00:02dd $ea $28 $d6
    ld   [wD64F], A                                    ;; 00:02e0 $ea $4f $d6
    ld   [wD650], A                                    ;; 00:02e3 $ea $50 $d6
    ld   [wD651], A                                    ;; 00:02e6 $ea $51 $d6
    ld   A, $00                                        ;; 00:02e9 $3e $00
    ld   [wD744], A                                    ;; 00:02eb $ea $44 $d7
.jp_00_02ee:
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:02ee $fa $1e $d6
    and  A, A                                          ;; 00:02f1 $a7
    jr   NZ, .jr_00_0350                               ;; 00:02f2 $20 $5c
    ld   A, [wD621]                                    ;; 00:02f4 $fa $21 $d6
    and  A, $04                                        ;; 00:02f7 $e6 $04
    jr   Z, .jr_00_0306                                ;; 00:02f9 $28 $0b
    ld   [wD59D_ReturnBank], A                                    ;; 00:02fb $ea $9d $d5
    ld   A, Bank01                                        ;; 00:02fe $3e $01
    ld   HL, entry_01_42bd_EnterTV                                     ;; 00:0300 $21 $bd $42
    call call_00_1078_CallAltBankFunc                                  ;; 00:0303 $cd $78 $10
.jr_00_0306:
    call call_00_11e0_SetupMusicForLevel                                  ;; 00:0306 $cd $e0 $11
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0309 $fa $24 $d6
    and  A, A                                          ;; 00:030c $a7
    jr   Z, .jr_00_0350                                ;; 00:030d $28 $41
    call call_00_0562                                  ;; 00:030f $cd $62 $05
    ld   [wD59D_ReturnBank], A                                    ;; 00:0312 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0315 $3e $01
    ld   HL, entry_01_4297_LoadMissionSelectMenu                                     ;; 00:0317 $21 $97 $42
    call call_00_1078_CallAltBankFunc                                  ;; 00:031a $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:031d $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:0320 $3e $0b
    ld   HL, entry_0b_4000                              ;; 00:0322 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:0325 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:0328 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:032b $3e $02
    ld   HL, entry_02_6eb1                                     ;; 00:032d $21 $b1 $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:0330 $cd $78 $10
    call call_00_3c3f                                  ;; 00:0333 $cd $3f $3c
    call call_00_12e4                                  ;; 00:0336 $cd $e4 $12
    ld   A, $0a                                        ;; 00:0339 $3e $0a
    ld   [wD613], A                                    ;; 00:033b $ea $13 $d6
    xor  A, A                                          ;; 00:033e $af
    ld   [wD614], A                                    ;; 00:033f $ea $14 $d6
    ld   [wD617], A                                    ;; 00:0342 $ea $17 $d6
    ld   A, [wD627_CurrentMission]                                    ;; 00:0345 $fa $27 $d6
    add  A, $0a                                        ;; 00:0348 $c6 $0a
    ld   C, A                                          ;; 00:034a $4f
    ld   B, $01                                        ;; 00:034b $06 $01
    call call_00_2329_UpdateMain                                  ;; 00:034d $cd $29 $23
.jr_00_0350:
    xor  A, A                                          ;; 00:0350 $af
    ld   [wD618_CheckpointSpawnId], A                                    ;; 00:0351 $ea $18 $d6
    ld   [wD686], A                                    ;; 00:0354 $ea $86 $d6
    ld   [wD625_TotalsMenuPage], A                                    ;; 00:0357 $ea $25 $d6
    ld   [wD648], A                                    ;; 00:035a $ea $48 $d6
    ld   HL, wD624_CurrentLevelId                                     ;; 00:035d $21 $24 $d6
    ld   L, [HL]                                       ;; 00:0360 $6e
    ld   H, $00                                        ;; 00:0361 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 00:0363 $11 $29 $d6
    add  HL, DE                                        ;; 00:0366 $19
    ld   A, [HL]                                       ;; 00:0367 $7e
    and  A, $18                                        ;; 00:0368 $e6 $18
    ld   [wD64C], A                                    ;; 00:036a $ea $4c $d6
    call call_00_0562                                  ;; 00:036d $cd $62 $05
.jp_00_0370:
    xor  A, A                                          ;; 00:0370 $af
    ld   [wD742_PlayerCurrentFly], A                                    ;; 00:0371 $ea $42 $d7
    ld   [wD750], A                                    ;; 00:0374 $ea $50 $d7
    ld   [wD751], A                                    ;; 00:0377 $ea $51 $d7
    ld   [wD752], A                                    ;; 00:037a $ea $52 $d7
    ld   [wD755], A                                    ;; 00:037d $ea $55 $d7
    ld   [wD756], A                                    ;; 00:0380 $ea $56 $d7
    ld   [wD753], A                                    ;; 00:0383 $ea $53 $d7
    ld   [wD754], A                                    ;; 00:0386 $ea $54 $d7
    ld   [wD772], A                                    ;; 00:0389 $ea $72 $d7
    ld   [wD773], A                                    ;; 00:038c $ea $73 $d7
    ld   [wD774], A                                    ;; 00:038f $ea $74 $d7
    ld   [wD73C], A                                    ;; 00:0392 $ea $3c $d7
    ld   [wD6F9], A                                    ;; 00:0395 $ea $f9 $d6
    ld   [wD60E], A                                    ;; 00:0398 $ea $0e $d6
    ld   [wD60F_BitmapOfThingsToLoad], A                                    ;; 00:039b $ea $0f $d6
    ld   [wD77B], A                                    ;; 00:039e $ea $7b $d7
    ld   [wD77D], A                                    ;; 00:03a1 $ea $7d $d7
    ld   [wD72F], A                                    ;; 00:03a4 $ea $2f $d7
    ld   [wD71E], A                                    ;; 00:03a7 $ea $1e $d7
    ld   [wD5A3], A                                    ;; 00:03aa $ea $a3 $d5
    ld   [wD5A4], A                                    ;; 00:03ad $ea $a4 $d5
    ld   [wD5A5], A                                    ;; 00:03b0 $ea $a5 $d5
    
    ; Set Health to 4
    ld   A, $04                                        ;; 00:03b3 $3e $04
    ld   [wD741_PlayerHealth], A                                    ;; 00:03b5 $ea $41 $d7
    ld   [wD59D_ReturnBank], A                                    ;; 00:03b8 $ea $9d $d5
    
    ld   A, Bank0b                                        ;; 00:03bb $3e $0b
    ld   HL, entry_0b_4000                              ;; 00:03bd $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:03c0 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:03c3 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:03c6 $3e $02
    ld   HL, entry_02_6eb1                                     ;; 00:03c8 $21 $b1 $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:03cb $cd $78 $10
    call call_00_3c3f                                  ;; 00:03ce $cd $3f $3c
    call call_00_12e4                                  ;; 00:03d1 $cd $e4 $12
    call call_00_0547                                  ;; 00:03d4 $cd $47 $05
    call call_00_0562                                  ;; 00:03d7 $cd $62 $05
.jr_00_03da:
    ld   A, $0a                                        ;; 00:03da $3e $0a
    ld   [wD613], A                                    ;; 00:03dc $ea $13 $d6
    xor  A, A                                          ;; 00:03df $af
    ld   [wD614], A                                    ;; 00:03e0 $ea $14 $d6
    ld   [wD617], A                                    ;; 00:03e3 $ea $17 $d6
    ld   [wD5A3], A                                    ;; 00:03e6 $ea $a3 $d5
    ld   [wD5A4], A                                    ;; 00:03e9 $ea $a4 $d5
    ld   [wD5A5], A                                    ;; 00:03ec $ea $a5 $d5
    ld   A, $ff                                        ;; 00:03ef $3e $ff
    ld   [wD610], A                                    ;; 00:03f1 $ea $10 $d6
    ld   A, $01                                        ;; 00:03f4 $3e $01
    ld   [wD743], A                                    ;; 00:03f6 $ea $43 $d7
    ld   [wD59D_ReturnBank], A                                    ;; 00:03f9 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:03fc $3e $0b
    ld   HL, entry_0b_4efe_SpawnPositionInMap                                     ;; 00:03fe $21 $fe $4e
    call call_00_1078_CallAltBankFunc                                  ;; 00:0401 $cd $78 $10
    call call_00_1264_LoadMap                                  ;; 00:0404 $cd $64 $12
    ld   [wD59D_ReturnBank], A                                    ;; 00:0407 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:040a $3e $02
    ld   HL, entry_02_6e17_PlayerInit                                     ;; 00:040c $21 $17 $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:040f $cd $78 $10
    call call_00_0521                                  ;; 00:0412 $cd $21 $05
    jr   .jp_00_0428                                   ;; 00:0415 $18 $11
.jp_00_0417:
    call call_00_1264_LoadMap                                  ;; 00:0417 $cd $64 $12
    ld   [wD59D_ReturnBank], A                                    ;; 00:041a $ea $9d $d5
    ld   A, Bank02                                        ;; 00:041d $3e $02
    ld   HL, entry_02_71c8                                     ;; 00:041f $21 $c8 $71
    call call_00_1078_CallAltBankFunc                                  ;; 00:0422 $cd $78 $10
    call call_00_0521                                  ;; 00:0425 $cd $21 $05
.jp_00_0428:
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:0428 $cd $b4 $0a
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:042b $fa $9f $d5
    cp   A, $0f                                        ;; 00:042e $fe $0f
    jp   Z, .jp_00_0220                                ;; 00:0430 $ca $20 $02
    ld   A, [wD621]                                    ;; 00:0433 $fa $21 $d6
    and  A, $08                                        ;; 00:0436 $e6 $08
    jr   Z, .jr_00_043f                                ;; 00:0438 $28 $05
    call call_00_38f0                                  ;; 00:043a $cd $f0 $38
    jr   .jr_00_03da                                   ;; 00:043d $18 $9b
.jr_00_043f:
    ld   A, [wD621]                                    ;; 00:043f $fa $21 $d6
    and  A, $04                                        ;; 00:0442 $e6 $04
    jp   NZ, .jp_00_02ee                               ;; 00:0444 $c2 $ee $02
    ld   A, [wD621]                                    ;; 00:0447 $fa $21 $d6
    and  A, $02                                        ;; 00:044a $e6 $02
    jr   Z, .jr_00_0468                                ;; 00:044c $28 $1a
    ld   A, [wD73D_LivesRemaining]                                    ;; 00:044e $fa $3d $d7
    and  A, A                                          ;; 00:0451 $a7
    jp   NZ, .jp_00_0370                               ;; 00:0452 $c2 $70 $03
    ld   [wD59D_ReturnBank], A                                    ;; 00:0455 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0458 $3e $01
    ld   HL, entry_01_43bd_LoadGameOverMenu                                     ;; 00:045a $21 $bd $43
    call call_00_1078_CallAltBankFunc                                  ;; 00:045d $cd $78 $10
    cp   A, $80                                        ;; 00:0460 $fe $80
    jp   Z, .jp_00_029d                                ;; 00:0462 $ca $9d $02
    jp   .jp_00_0254                                   ;; 00:0465 $c3 $54 $02
.jr_00_0468:
    call call_00_110d_PressingStart                                  ;; 00:0468 $cd $0d $11
    jr   Z, .jr_00_0479                                ;; 00:046b $28 $0c
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:046d $fa $24 $d6
    and  A, A                                          ;; 00:0470 $a7
    ld   A, $00                                        ;; 00:0471 $3e $00
    jr   Z, .jr_00_0486                                ;; 00:0473 $28 $11
    ld   A, $02                                        ;; 00:0475 $3e $02
    jr   .jr_00_0486                                   ;; 00:0477 $18 $0d
.jr_00_0479:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0479 $fa $24 $d6
    and  A, A                                          ;; 00:047c $a7
    jr   NZ, .jr_00_04a9                               ;; 00:047d $20 $2a
    call call_00_1118_PressingSelect                                  ;; 00:047f $cd $18 $11
    jr   Z, .jr_00_04a9                                ;; 00:0482 $28 $25
    ld   A, $05                                        ;; 00:0484 $3e $05
.jr_00_0486:
    ld   [wD59D_ReturnBank], A                                    ;; 00:0486 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0489 $3e $01
    ld   HL, entry_01_4000_MenuLoad                              ;; 00:048b $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 00:048e $cd $78 $10
    cp   A, $60                                        ;; 00:0491 $fe $60
    jp   NZ, .jp_00_0417                               ;; 00:0493 $c2 $17 $04
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0496 $fa $24 $d6
    and  A, A                                          ;; 00:0499 $a7
    jp   Z, .jp_00_0254                                ;; 00:049a $ca $54 $02
    xor  A, A                                          ;; 00:049d $af
    ld   [wD624_CurrentLevelId], A                                    ;; 00:049e $ea $24 $d6
    ld   A, $14                                        ;; 00:04a1 $3e $14
    ld   [wD744], A                                    ;; 00:04a3 $ea $44 $d7
    jp   .jp_00_02ee                                   ;; 00:04a6 $c3 $ee $02
.jr_00_04a9:
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:04a9 $fa $1e $d6
    and  A, A                                          ;; 00:04ac $a7
    jr   Z, .jr_00_04bb                                ;; 00:04ad $28 $0c
    cp   A, $ff                                        ;; 00:04af $fe $ff
    jp   Z, .jp_00_0254                                ;; 00:04b1 $ca $54 $02
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:04b4 $fa $9f $d5
    and  A, A                                          ;; 00:04b7 $a7
    jp   NZ, .jp_00_0254                               ;; 00:04b8 $c2 $54 $02
.jr_00_04bb:
    ld   A, [wD752]                                    ;; 00:04bb $fa $52 $d7
    and  A, A                                          ;; 00:04be $a7
    jr   NZ, .jr_00_04cd                               ;; 00:04bf $20 $0c
    ld   A, [wD751]                                    ;; 00:04c1 $fa $51 $d7
    cp   A, $01                                        ;; 00:04c4 $fe $01
    jr   NZ, .jr_00_04cd                               ;; 00:04c6 $20 $05
    ld   C, $15                                        ;; 00:04c8 $0e $15
    call call_00_112f                                  ;; 00:04ca $cd $2f $11
.jr_00_04cd:
    ld   HL, wD751                                     ;; 00:04cd $21 $51 $d7
    ld   A, [HL+]                                      ;; 00:04d0 $2a
    or   A, [HL]                                       ;; 00:04d1 $b6
    jr   Z, .jr_00_04e0                                ;; 00:04d2 $28 $0c
    ld   A, [wD73B]                                    ;; 00:04d4 $fa $3b $d7
    and  A, $7f                                        ;; 00:04d7 $e6 $7f
    jr   NZ, .jr_00_04e0                               ;; 00:04d9 $20 $05
    ld   C, $14                                        ;; 00:04db $0e $14
    call call_00_112f                                  ;; 00:04dd $cd $2f $11
.jr_00_04e0:
    ld   [wD59D_ReturnBank], A                                    ;; 00:04e0 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:04e3 $3e $02
    ld   HL, entry_02_6eba_UpdateObjects                                     ;; 00:04e5 $21 $ba $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:04e8 $cd $78 $10
    call call_00_1455                                  ;; 00:04eb $cd $55 $14
    call call_00_2305                                  ;; 00:04ee $cd $05 $23
    call call_00_1e5b                                  ;; 00:04f1 $cd $5b $1e
    call call_00_05c7                                  ;; 00:04f4 $cd $c7 $05
    call call_00_08fc                                  ;; 00:04f7 $cd $fc $08
    ld   [wD59D_ReturnBank], A                                    ;; 00:04fa $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:04fd $3e $0b
    ld   HL, entry_0b_5ec3                                     ;; 00:04ff $21 $c3 $5e
    call call_00_1078_CallAltBankFunc                                  ;; 00:0502 $cd $78 $10
    ld   HL, wD73C                                     ;; 00:0505 $21 $3c $d7
    inc  [HL]                                          ;; 00:0508 $34
    ld   A, [wD73B]                                    ;; 00:0509 $fa $3b $d7
    and  A, A                                          ;; 00:050c $a7
    jp   NZ, .jp_00_0428                               ;; 00:050d $c2 $28 $04
    ld   HL, wD5A3                                     ;; 00:0510 $21 $a3 $d5
    ld   B, $03                                        ;; 00:0513 $06 $03
.jr_00_0515:
    ld   A, [HL]                                       ;; 00:0515 $7e
    and  A, A                                          ;; 00:0516 $a7
    jr   Z, .jr_00_051a                                ;; 00:0517 $28 $01
    dec  [HL]                                          ;; 00:0519 $35
.jr_00_051a:
    inc  HL                                            ;; 00:051a $23
    dec  B                                             ;; 00:051b $05
    jr   NZ, .jr_00_0515                               ;; 00:051c $20 $f7
    jp   .jp_00_0428                                   ;; 00:051e $c3 $28 $04
; End of Main loop

call_00_0521:
    ld   [wD59D_ReturnBank], A                                    ;; 00:0521 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:0524 $3e $02
    ld   HL, entry_02_6f80                                     ;; 00:0526 $21 $80 $6f
    call call_00_1078_CallAltBankFunc                                  ;; 00:0529 $cd $78 $10
    call call_00_0971                                  ;; 00:052c $cd $71 $09
    ld   A, $03                                        ;; 00:052f $3e $03
    call call_00_0bae                                  ;; 00:0531 $cd $ae $0b
    ld   C, $00                                        ;; 00:0534 $0e $00
    ld   [wD59D_ReturnBank], A                                    ;; 00:0536 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:0539 $3e $0b
    ld   HL, entry_0b_5537                              ;; 00:053b $21 $37 $55
    call call_00_1078_CallAltBankFunc                                  ;; 00:053e $cd $78 $10
    ld   A, $c7                                        ;; 00:0541 $3e $c7
    call call_00_0f56                                  ;; 00:0543 $cd $56 $0f
    ret                                                ;; 00:0546 $c9

call_00_0547:
    xor  A, A                                          ;; 00:0547 $af
    ld   [wD687], A                                    ;; 00:0548 $ea $87 $d6
    ld   [wD689], A                                    ;; 00:054b $ea $89 $d6
    ld   A, $a0                                        ;; 00:054e $3e $a0
    ld   [wD688], A                                    ;; 00:0550 $ea $88 $d6
    ld   A, $03                                        ;; 00:0553 $3e $03
    ld   [wD76F], A                                    ;; 00:0555 $ea $6f $d7
    xor  A, A                                          ;; 00:0558 $af
    ld   [wD770], A                                    ;; 00:0559 $ea $70 $d7
    ld   A, $3c                                        ;; 00:055c $3e $3c
    ld   [wD771], A                                    ;; 00:055e $ea $71 $d7
    ret                                                ;; 00:0561 $c9

call_00_0562:
    ld   HL, wD624_CurrentLevelId                                     ;; 00:0562 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:0565 $6e
    ld   H, $00                                        ;; 00:0566 $26 $00
    ld   DE, .data_00_0579                                      ;; 00:0568 $11 $79 $05
    add  HL, DE                                        ;; 00:056b $19
    ld   A, [HL]                                       ;; 00:056c $7e
    ld   [wD649_CollectibleAmount], A                                    ;; 00:056d $ea $49 $d6
    ld   HL, wD623                                     ;; 00:0570 $21 $23 $d6
    ld   [HL], A                                       ;; 00:0573 $77
    and  A, A                                          ;; 00:0574 $a7
    ret  Z                                             ;; 00:0575 $c8
    ld   [HL], $01                                     ;; 00:0576 $36 $01
    ret                                                ;; 00:0578 $c9
.data_00_0579:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:0579 .ww?????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:0581 ????????
    db   $32, $00, $00, $00, $00, $1f, $32, $32        ;; 00:0589 ????????
    db   $00, $00, $00, $00, $00, $00, $00             ;; 00:0591 ???????

call_00_0598:
    ld   HL, wD771                                     ;; 00:0598 $21 $71 $d7
    dec  [HL]                                          ;; 00:059b $35
    ret  NZ                                            ;; 00:059c $c0
    ld   [HL], $3c                                     ;; 00:059d $36 $3c
    ld   HL, wD60E                                     ;; 00:059f $21 $0e $d6
    set  2, [HL]                                       ;; 00:05a2 $cb $d6
    ld   HL, wD770                                     ;; 00:05a4 $21 $70 $d7
    ld   A, [HL]                                       ;; 00:05a7 $7e
    sub  A, $01                                        ;; 00:05a8 $d6 $01
    daa                                                ;; 00:05aa $27
    ld   [HL], A                                       ;; 00:05ab $77
    cp   A, $99                                        ;; 00:05ac $fe $99
    ret  NZ                                            ;; 00:05ae $c0
    ld   [HL], $59                                     ;; 00:05af $36 $59
    ld   HL, wD76F                                     ;; 00:05b1 $21 $6f $d7
    dec  [HL]                                          ;; 00:05b4 $35
    bit  7, [HL]                                       ;; 00:05b5 $cb $7e
    ret  Z                                             ;; 00:05b7 $c8
    ld   [HL], $00                                     ;; 00:05b8 $36 $00
    xor  A, A                                          ;; 00:05ba $af
    ld   [wD770], A                                    ;; 00:05bb $ea $70 $d7
    ld   A, [wD621]                                    ;; 00:05be $fa $21 $d6
    or   A, $14                                        ;; 00:05c1 $f6 $14
    ld   [wD621], A                                    ;; 00:05c3 $ea $21 $d6
    ret                                                ;; 00:05c6 $c9

call_00_05c7:
    ld   A, [wD623]                                    ;; 00:05c7 $fa $23 $d6
    and  A, A                                          ;; 00:05ca $a7
    jr   NZ, call_00_0598                                ;; 00:05cb $20 $cb
    ld   A, [wD687]                                    ;; 00:05cd $fa $87 $d6
    and  A, $01                                        ;; 00:05d0 $e6 $01
    jr   NZ, .jr_00_05e3                               ;; 00:05d2 $20 $0f
    ld   A, [wD687]                                    ;; 00:05d4 $fa $87 $d6
    and  A, $02                                        ;; 00:05d7 $e6 $02
    ret  Z                                             ;; 00:05d9 $c8
    ld   HL, wD688                                     ;; 00:05da $21 $88 $d6
    ld   A, [HL]                                       ;; 00:05dd $7e
    cp   A, $a0                                        ;; 00:05de $fe $a0
    ret  Z                                             ;; 00:05e0 $c8
    inc  [HL]                                          ;; 00:05e1 $34
    ret                                                ;; 00:05e2 $c9
.jr_00_05e3:
    ld   HL, wD688                                     ;; 00:05e3 $21 $88 $d6
    ld   A, [HL]                                       ;; 00:05e6 $7e
    cp   A, $88                                        ;; 00:05e7 $fe $88
    jr   Z, .jr_00_05fe                                ;; 00:05e9 $28 $13
    dec  [HL]                                          ;; 00:05eb $35
    ld   A, [HL]                                       ;; 00:05ec $7e
    cp   A, $88                                        ;; 00:05ed $fe $88
    ret  NZ                                            ;; 00:05ef $c0
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:05f0 $fa $24 $d6
    and  A, A                                          ;; 00:05f3 $a7
    ld   A, $ff                                        ;; 00:05f4 $3e $ff
    jr   NZ, .jr_00_05fa                               ;; 00:05f6 $20 $02
    ld   A, $05                                        ;; 00:05f8 $3e $05
.jr_00_05fa:
    ld   [wD689], A                                    ;; 00:05fa $ea $89 $d6
    ret                                                ;; 00:05fd $c9
.jr_00_05fe:
    ld   HL, wD689                                     ;; 00:05fe $21 $89 $d6
    dec  [HL]                                          ;; 00:0601 $35
    ret  NZ                                            ;; 00:0602 $c0
    ld   A, [wD687]                                    ;; 00:0603 $fa $87 $d6
    and  A, $80                                        ;; 00:0606 $e6 $80
    jr   NZ, .jr_00_061c                               ;; 00:0608 $20 $12
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:060a $fa $24 $d6
    and  A, A                                          ;; 00:060d $a7
    jr   NZ, .jr_00_0616                               ;; 00:060e $20 $06
    ld   A, $42                                        ;; 00:0610 $3e $42
    ld   [wD687], A                                    ;; 00:0612 $ea $87 $d6
    ret                                                ;; 00:0615 $c9
.jr_00_0616:
    ld   A, $81                                        ;; 00:0616 $3e $81
    ld   [wD687], A                                    ;; 00:0618 $ea $87 $d6
    ret                                                ;; 00:061b $c9
.jr_00_061c:
    ld   A, [wD741_PlayerHealth]                                    ;; 00:061c $fa $41 $d7
    cp   A, $02                                        ;; 00:061f $fe $02
    jr   C, .jr_00_0616                                ;; 00:0621 $38 $f3
    ld   A, $82                                        ;; 00:0623 $3e $82
    ld   [wD687], A                                    ;; 00:0625 $ea $87 $d6
    ret                                                ;; 00:0628 $c9

call_00_0629:
    ld   A, $81                                        ;; 00:0629 $3e $81
    ld   [wD687], A                                    ;; 00:062b $ea $87 $d6
    ld   A, $ff                                        ;; 00:062e $3e $ff
    ld   [wD689], A                                    ;; 00:0630 $ea $89 $d6
    ret                                                ;; 00:0633 $c9

call_00_0634:
    ld   A, $41                                        ;; 00:0634 $3e $41
    ld   [wD687], A                                    ;; 00:0636 $ea $87 $d6
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0639 $fa $24 $d6
    and  A, A                                          ;; 00:063c $a7
    ld   A, $ff                                        ;; 00:063d $3e $ff
    jr   NZ, .jr_00_0643                               ;; 00:063f $20 $02
    ld   A, $05                                        ;; 00:0641 $3e $05
.jr_00_0643:
    ld   [wD689], A                                    ;; 00:0643 $ea $89 $d6
    ret                                                ;; 00:0646 $c9
;    db   $21, $42, $d7, $4e, $77, $c5, $ea, $9d        ;; 00:0647 ????????
;    db   $d5, $3e, $0b, $21, $1b, $5f, $cd, $78        ;; 00:064f ????????
;    db   $10, $c1, $79, $fe, $03, $28, $59, $fe        ;; 00:0657 ????????
;    db   $04, $28, $28, $fe, $01, $28, $14, $fe        ;; 00:065f ????????
;    db   $02, $c0, $af, $ea, $53, $d7, $ea, $54        ;; 00:0667 ????????
;    db   $d7, $11, $08, $07, $21, $55, $d7, $73        ;; 00:066f ????????
;    db   $23, $72, $c9, $ea, $55, $d7, $ea, $56        ;; 00:0677 ????????
;    db   $d7, $11, $08, $07, $21, $53, $d7, $73        ;; 00:067f ????????
;    db   $23, $72, $c9                                 ;; 00:0687 ???

call_00_0647:
    ld hl, wD742_PlayerCurrentFly
    ld c, [hl]
    ld [hl], a
    push bc
    ld [wD59D_ReturnBank], a
    ld a, Bank0b
    ld hl, $5f1b
    call call_00_1078_CallAltBankFunc
    pop bc
    ld a, c
    cp $03
    jr z, jr_00_06b7

    cp $04
    jr z, call_00_068a

    cp $01
    jr z, jr_00_067a

    cp $02
    ret nz

    xor a
    ld [$d753], a
    ld [$d754], a
    ld de, $0708
    ld hl, wD755
    ld [hl], e
    inc hl
    ld [hl], d
    ret


jr_00_067a:
    ld [$d755], a
    ld [$d756], a
    ld de, $0708
    ld hl, wD753
    ld [hl], e
    inc hl
    ld [hl], d
    ret

call_00_068a:
    call call_00_074d                                  ;; 00:068a $cd $4d $07
    ld   HL, wD73D_LivesRemaining                                     ;; 00:068d $21 $3d $d7
    inc  [HL]                                          ;; 00:0690 $34
    jr   NZ, call_00_0634                              ;; 00:0691 $20 $a1
    dec  [HL]                                          ;; 00:0693 $35
    jr   call_00_0634                                  ;; 00:0694 $18 $9e

call_00_0696:
    ld   A, $10                                        ;; 00:0696 $3e $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:0698 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:069b $3e $02
    ld   HL, entry_02_4ccd                                   ;; 00:069d $21 $cd $4c (BANK 3)
    call call_00_1078_CallAltBankFunc                                  ;; 00:06a0 $cd $78 $10
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:06a3 $fa $24 $d6
    and  A, A                                          ;; 00:06a6 $a7
    ret  Z                                             ;; 00:06a7 $c8
    ld   A, [wD623]                                    ;; 00:06a8 $fa $23 $d6
    and  A, A                                          ;; 00:06ab $a7
    ret  NZ                                            ;; 00:06ac $c0
    call call_00_074d                                  ;; 00:06ad $cd $4d $07
    ld   HL, wD73D_LivesRemaining                                     ;; 00:06b0 $21 $3d $d7
    dec  [HL]                                          ;; 00:06b3 $35
    jp   call_00_0634                                  ;; 00:06b4 $c3 $34 $06
;    db   $21, $41, $d7, $36, $04, $c3, $29, $06        ;; 00:06b7 ????????
jr_00_06b7:
    ld   hl, wD741_PlayerHealth
    ld   [hl], $04
    jp   call_00_0629

call_00_06bf_GexTakesDamage:
; Deal damage to Gex
    call call_00_075b                                  ;; 00:06bf $cd $5b $07
    ret  NZ                                            ;; 00:06c2 $c0
    ld   HL, wD742_PlayerCurrentFly                                     ;; 00:06c3 $21 $42 $d7
    ld   A, [HL]                                       ;; 00:06c6 $7e
    ld   [HL], $00                                     ;; 00:06c7 $36 $00
    and  A, A                                          ;; 00:06c9 $a7
    jr   NZ, .jr_00_06d2                               ;; 00:06ca $20 $06
    ld   HL, wD741_PlayerHealth                                     ;; 00:06cc $21 $41 $d7
    dec  [HL]                                          ;; 00:06cf $35
    jr   Z, call_00_0696                                 ;; 00:06d0 $28 $c4
.jr_00_06d2:
    ld   A, [wD201_PlayerObject_ActionId]                                    ;; 00:06d2 $fa $01 $d2
    and  A, $1f                                        ;; 00:06d5 $e6 $1f
    cp   A, $1c                                        ;; 00:06d7 $fe $1c
    jp   Z, call_00_0629                                 ;; 00:06d9 $ca $29 $06
    ld   A, $0f                                        ;; 00:06dc $3e $0f
    ld   [wD59D_ReturnBank], A                                    ;; 00:06de $ea $9d $d5
    ld   A, Bank02                                        ;; 00:06e1 $3e $02
    ld   HL, entry_02_4ccd                                   ;; 00:06e3 $21 $cd $4c (BANK 3)
    call call_00_1078_CallAltBankFunc                                  ;; 00:06e6 $cd $78 $10
    jp   call_00_0629                                    ;; 00:06e9 $c3 $29 $06

call_00_06ec:
    ld   C, $06                                        ;; 00:06ec $0e $06
    call call_00_112f                                  ;; 00:06ee $cd $2f $11
    call call_00_074d                                  ;; 00:06f1 $cd $4d $07
    call call_00_0634                                  ;; 00:06f4 $cd $34 $06
    ld   A, [wD623]                                    ;; 00:06f7 $fa $23 $d6
    and  A, A                                          ;; 00:06fa $a7
    jr   Z, .jr_00_070b                                ;; 00:06fb $28 $0e
    ld   A, [wD621]                                    ;; 00:06fd $fa $21 $d6
    and  A, $10                                        ;; 00:0700 $e6 $10
    ret  NZ                                            ;; 00:0702 $c0
    ld   HL, wD649_CollectibleAmount                                     ;; 00:0703 $21 $49 $d6
    ld   A, [HL]                                       ;; 00:0706 $7e
    and  A, A                                          ;; 00:0707 $a7
    ret  Z                                             ;; 00:0708 $c8
    dec  [HL]                                          ;; 00:0709 $35
    ret                                                ;; 00:070a $c9
.jr_00_070b:
    ld   HL, wD649_CollectibleAmount                                     ;; 00:070b $21 $49 $d6
    inc  [HL]                                          ;; 00:070e $34
    jr   NZ, .jr_00_0713                               ;; 00:070f $20 $02
    dec  [HL]                                          ;; 00:0711 $35
    ret                                                ;; 00:0712 $c9
.jr_00_0713:
    ld   HL, wD648                                     ;; 00:0713 $21 $48 $d6
    ld   L, [HL]                                       ;; 00:0716 $6e
    ld   H, $00                                        ;; 00:0717 $26 $00
    ld   DE, $74a                                      ;; 00:0719 $11 $4a $07
    add  HL, DE                                        ;; 00:071c $19
    ld   A, [HL]                                       ;; 00:071d $7e
    cp   A, $32                                        ;; 00:071e $fe $32
    jr   Z, .jr_00_0733                                ;; 00:0720 $28 $11
    ld   HL, wD649_CollectibleAmount                                     ;; 00:0722 $21 $49 $d6
    cp   A, [HL]                                       ;; 00:0725 $be
    ret  NZ                                            ;; 00:0726 $c0
    ld   [HL], $00                                     ;; 00:0727 $36 $00
    ld   HL, wD648                                     ;; 00:0729 $21 $48 $d6
    inc  [HL]                                          ;; 00:072c $34
    ld   HL, wD60E                                     ;; 00:072d $21 $0e $d6
    set  3, [HL]                                       ;; 00:0730 $cb $de
    ret                                                ;; 00:0732 $c9
.jr_00_0733:
    ld   A, [wD649_CollectibleAmount]                                    ;; 00:0733 $fa $49 $d6
.jr_00_0736:
    sub  A, $32                                        ;; 00:0736 $d6 $32
    ret  C                                             ;; 00:0738 $d8
    jr   NZ, .jr_00_0736                               ;; 00:0739 $20 $fb
    ld   HL, wD64C                                     ;; 00:073b $21 $4c $d6
    bit  3, [HL]                                       ;; 00:073e $cb $5e
    jp   NZ, call_00_068a                                ;; 00:0740 $c2 $8a $06
    set  3, [HL]                                       ;; 00:0743 $cb $de
    xor  A, A                                          ;; 00:0745 $af
    ld   [wD649_CollectibleAmount], A                                    ;; 00:0746 $ea $49 $d6
    ret                                                ;; 00:0749 $c9
    db   $1e, $28, $32                                 ;; 00:074a .??

call_00_074d:
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:074d $fa $1e $d6
    ld   HL, wD623                                     ;; 00:0750 $21 $23 $d6
    or   A, [HL]                                       ;; 00:0753 $b6
    ret  NZ                                            ;; 00:0754 $c0
    ld   HL, wD60E                                     ;; 00:0755 $21 $0e $d6
    set  1, [HL]                                       ;; 00:0758 $cb $ce
    ret                                                ;; 00:075a $c9

call_00_075b:
    ld   A, [wD750]                                    ;; 00:075b $fa $50 $d7
    and  A, A                                          ;; 00:075e $a7
    ret  NZ                                            ;; 00:075f $c0
    ld   HL, wD755                                     ;; 00:0760 $21 $55 $d7
    ld   A, [HL+]                                      ;; 00:0763 $2a
    or   A, [HL]                                       ;; 00:0764 $b6
    ret  NZ                                            ;; 00:0765 $c0
    ld   HL, wD753                                     ;; 00:0766 $21 $53 $d7
    ld   A, [HL+]                                      ;; 00:0769 $2a
    or   A, [HL]                                       ;; 00:076a $b6
    ret  NZ                                            ;; 00:076b $c0
    ret                                                ;; 00:076c $c9

    db   $08, $04, $0d, $07
data_00_0771:
    db   $79, $07, $7c, $07        ;; 00:076d ????????
    db   $7f, $07, $9e, $07, $64, $10, $ff, $64        ;; 00:0775 ????????
    db   $10, $ff, $30, $10, $08, $11, $40, $10        ;; 00:077d ????????
    db   $08, $11, $a4, $10, $40, $00, $60, $10        ;; 00:0785 ????????
    db   $04, $12, $6c, $10, $20, $20, $08, $21        ;; 00:078d ????????
    db   $20, $20, $10, $22, $50, $20, $a0, $10        ;; 00:0795 ????????
    db   $ff, $64, $10, $ff                            ;; 00:079d ????

call_00_07a1:
    push HL                                            ;; 00:07a1 $e5
    push DE                                            ;; 00:07a2 $d5
    push BC                                            ;; 00:07a3 $c5
    call call_00_1089_SwitchBank                                  ;; 00:07a4 $cd $89 $10
    pop  BC                                            ;; 00:07a7 $c1
    pop  DE                                            ;; 00:07a8 $d1
    pop  HL                                            ;; 00:07a9 $e1
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:07aa $cd $b0 $07
    jp   call_00_10a3_SwitchBank2                                  ;; 00:07ad $c3 $a3 $10

call_00_07b0_CopyBCBytesFromHLToDE:
    ld   A, [HL+]                                      ;; 00:07b0 $2a
    ld   [DE], A                                       ;; 00:07b1 $12
    inc  DE                                            ;; 00:07b2 $13
    dec  BC                                            ;; 00:07b3 $0b
    ld   A, B                                          ;; 00:07b4 $78
    or   A, C                                          ;; 00:07b5 $b1
    jr   NZ, call_00_07b0_CopyBCBytesFromHLToDE                              ;; 00:07b6 $20 $f8
    ret                                                ;; 00:07b8 $c9

call_00_07b9:
    ld   L, A                                          ;; 00:07b9 $6f
    ld   H, $00                                        ;; 00:07ba $26 $00
    add  HL, HL                                        ;; 00:07bc $29
    add  HL, DE                                        ;; 00:07bd $19
    ld   E, [HL]                                       ;; 00:07be $5e
    inc  HL                                            ;; 00:07bf $23
    ld   H, [HL]                                       ;; 00:07c0 $66
    ld   L, E                                          ;; 00:07c1 $6b
    ret                                                ;; 00:07c2 $c9
;    db   $fa, $a5, $d6, $cd, $89, $10, $21, $ad        ;; 00:07c3 ????????
;    db   $d6, $4e, $23, $46, $21, $a6, $d6, $6e        ;; 00:07cb ????????
;    db   $26, $00, $29, $29, $29, $29, $11, $00        ;; 00:07d3 ????????
;    db   $80, $19, $5d, $54, $21, $ab, $d6, $2a        ;; 00:07db ????????
;    db   $66, $6f, $cd, $b0, $07, $fa, $a6, $d6        ;; 00:07e3 ????????
;    db   $ea, $af, $d6, $21, $a9, $d6, $2a, $66        ;; 00:07eb ????????
;    db   $6f, $11, $00, $98, $fa, $a8, $d6, $47        ;; 00:07f3 ????????
;    db   $fa, $a7, $d6, $4f, $d5, $fa, $9e, $d5        ;; 00:07fb ????????
;    db   $a7, $28, $2e, $3e, $01, $e0, $4f, $e5        ;; 00:0803 ????????
;    db   $d5, $c5, $4e, $21, $a7, $d6, $5e, $16        ;; 00:080b ????????
;    db   $00, $21, $a8, $d6, $46, $21, $00, $00        ;; 00:0813 ????????
;    db   $19, $05, $20, $fc, $5d, $54, $21, $a9        ;; 00:081b ????????
;    db   $d6, $2a, $66, $6f, $19, $06, $00, $09        ;; 00:0823 ????????
;    db   $7e, $c1, $d1, $e1, $12, $3e, $00, $e0        ;; 00:082b ????????
;    db   $4f, $fa, $af, $d6, $86, $12, $23, $13        ;; 00:0833 ????????
;    db   $0d, $20, $c2, $d1, $7b, $c6, $20, $5f        ;; 00:083b ????????
;    db   $7a, $ce, $00, $57, $05, $20, $b1, $c3        ;; 00:0843 ????????
;    db   $a3, $10                                      ;; 00:084b ??

call_00_07c3:
    ld a, [wD6A5_PasswordTilesBank]
    call call_00_1089_SwitchBank
    ld hl, wD6AD
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld hl, wD6A6
    ld l, [hl]
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, $8000
    add hl, de
    ld e, l
    ld d, h
    ld hl, wD6AB
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call call_00_07b0_CopyBCBytesFromHLToDE
    ld a, [wD6A6]
    ld [wD6AF], a
    ld hl, wD6A9
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $9800
    ld a, [wD6A8]
    ld b, a

jr_00_07fb:
    ld a, [$d6a7]
    ld c, a

call_00_07ff:
    push de

jr_00_0800:
    ld a, [$d59e]
    and a
    jr z, jr_00_0834

    ld a, $01
    ldh [rVBK], a
    push hl
    push de
    push bc
    ld c, [hl]
    ld hl, wD6A7
    ld e, [hl]
    ld d, $00
    ld hl, wD6A8
    ld b, [hl]
    ld hl, $0000

jr_00_081b:
    add hl, de
    dec b
    jr nz, jr_00_081b

    ld e, l
    ld d, h
    ld hl, wD6A9
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, de
    ld b, $00
    add hl, bc
    ld a, [hl]
    pop bc
    pop de
    pop hl
    ld [de], a
    ld a, $00
    ldh [rVBK], a

jr_00_0834:
    ld a, [$d6af]
    add [hl]
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, jr_00_0800

    pop de
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, jr_00_07fb

    jp call_00_10a3_SwitchBank2

call_00_084d:
    ld   A, [wD6B0]                                    ;; 00:084d $fa $b0 $d6
    call call_00_1089_SwitchBank                                  ;; 00:0850 $cd $89 $10
    ld   HL, wD6B1                                     ;; 00:0853 $21 $b1 $d6
    ld   A, [HL+]                                      ;; 00:0856 $2a
    ld   H, [HL]                                       ;; 00:0857 $66
    ld   L, A                                          ;; 00:0858 $6f
    ld   DE, $8000                                     ;; 00:0859 $11 $00 $80
    ld   BC, $f00                                      ;; 00:085c $01 $00 $0f
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:085f $cd $b0 $07
    ld   DE, $9000                                     ;; 00:0862 $11 $00 $90
    ld   BC, $780                                      ;; 00:0865 $01 $80 $07
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:0868 $cd $b0 $07
    ld   A, [wD59E]                                    ;; 00:086b $fa $9e $d5
    and  A, A                                          ;; 00:086e $a7
    jr   Z, .jr_00_0891                                ;; 00:086f $28 $20
    ld   A, $01                                        ;; 00:0871 $3e $01
    ldh  [rVBK], A                                     ;; 00:0873 $e0 $4f
    ld   DE, $9800                                     ;; 00:0875 $11 $00 $98
    ld   C, $12                                        ;; 00:0878 $0e $12
.jr_00_087a:
    ld   B, $14                                        ;; 00:087a $06 $14
.jr_00_087c:
    ld   A, [HL+]                                      ;; 00:087c $2a
    ld   [DE], A                                       ;; 00:087d $12
    inc  E                                             ;; 00:087e $1c
    dec  B                                             ;; 00:087f $05
    jr   NZ, .jr_00_087c                               ;; 00:0880 $20 $fa
    ld   A, E                                          ;; 00:0882 $7b
    add  A, $0c                                        ;; 00:0883 $c6 $0c
    ld   E, A                                          ;; 00:0885 $5f
    ld   A, D                                          ;; 00:0886 $7a
    adc  A, $00                                        ;; 00:0887 $ce $00
    ld   D, A                                          ;; 00:0889 $57
    dec  C                                             ;; 00:088a $0d
    jr   NZ, .jr_00_087a                               ;; 00:088b $20 $ed
    ld   A, $00                                        ;; 00:088d $3e $00
    ldh  [rVBK], A                                     ;; 00:088f $e0 $4f
.jr_00_0891:
    ld   HL, $9800                                     ;; 00:0891 $21 $00 $98
    ld   DE, $0c                                       ;; 00:0894 $11 $0c $00
    ld   B, $0c                                        ;; 00:0897 $06 $0c
    ld   A, $02                                        ;; 00:0899 $3e $02
.jr_00_089b:
    push AF                                            ;; 00:089b $f5
    xor  A, A                                          ;; 00:089c $af
.jr_00_089d:
    ld   C, $14                                        ;; 00:089d $0e $14
.jr_00_089f:
    ld   [HL+], A                                      ;; 00:089f $22
    inc  A                                             ;; 00:08a0 $3c
    dec  C                                             ;; 00:08a1 $0d
    jr   NZ, .jr_00_089f                               ;; 00:08a2 $20 $fb
    add  HL, DE                                        ;; 00:08a4 $19
    dec  B                                             ;; 00:08a5 $05
    jr   NZ, .jr_00_089d                               ;; 00:08a6 $20 $f5
    ld   B, $06                                        ;; 00:08a8 $06 $06
    pop  AF                                            ;; 00:08aa $f1
    dec  A                                             ;; 00:08ab $3d
    jr   NZ, .jr_00_089b                               ;; 00:08ac $20 $ed
    jp   call_00_10a3_SwitchBank2                                  ;; 00:08ae $c3 $a3 $10

call_00_08b1:
    push HL                                            ;; 00:08b1 $e5
    push DE                                            ;; 00:08b2 $d5
    push BC                                            ;; 00:08b3 $c5
    push HL                                            ;; 00:08b4 $e5
    ld   A, $13                                        ;; 00:08b5 $3e $13
    call call_00_1089_SwitchBank                                  ;; 00:08b7 $cd $89 $10
    call call_00_2e3a                                  ;; 00:08ba $cd $3a $2e
    ld   DE, $8e6                                      ;; 00:08bd $11 $e6 $08
    call call_00_07b9                                  ;; 00:08c0 $cd $b9 $07
    ld   DE, $240                                      ;; 00:08c3 $11 $40 $02
    add  HL, DE                                        ;; 00:08c6 $19
    ld   E, L                                          ;; 00:08c7 $5d
    ld   D, H                                          ;; 00:08c8 $54
    pop  HL                                            ;; 00:08c9 $e1
    ld   C, $05                                        ;; 00:08ca $0e $05
.jr_00_08cc:
    ld   B, $06                                        ;; 00:08cc $06 $06
.jr_00_08ce:
    ld   A, [DE]                                       ;; 00:08ce $1a
    ld   [HL+], A                                      ;; 00:08cf $22
    inc  DE                                            ;; 00:08d0 $13
    dec  B                                             ;; 00:08d1 $05
    jr   NZ, .jr_00_08ce                               ;; 00:08d2 $20 $fa
    ld   A, L                                          ;; 00:08d4 $7d
    add  A, $1a                                        ;; 00:08d5 $c6 $1a
    ld   L, A                                          ;; 00:08d7 $6f
    ld   A, H                                          ;; 00:08d8 $7c
    adc  A, $00                                        ;; 00:08d9 $ce $00
    ld   H, A                                          ;; 00:08db $67
    dec  C                                             ;; 00:08dc $0d
    jr   NZ, .jr_00_08cc                               ;; 00:08dd $20 $ed
    call call_00_10a3_SwitchBank2                                  ;; 00:08df $cd $a3 $10
    pop  BC                                            ;; 00:08e2 $c1
    pop  DE                                            ;; 00:08e3 $d1
    pop  HL                                            ;; 00:08e4 $e1
    ret                                                ;; 00:08e5 $c9
    db   $00, $40, $00, $6d, $00, $70, $00, $6a        ;; 00:08e6 ????????
    db   $00, $76, $00, $40                            ;; 00:08ee ????
    dw   $4000                                         ;; 00:08f2 wW
    dw   $6700                                         ;; 00:08f4 wW
    db   $00, $79, $00, $40, $00, $73                  ;; 00:08f6 ??????

call_00_08fc: ; this reads special tileset information from other banks and writes to a buffer that gets copied to vram
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:08fc $21 $0f $d6
    bit  7, [HL]                                       ;; 00:08ff $cb $7e
    jr   NZ, call_00_08fc                              ;; 00:0901 $20 $f9
    ld   A, [HL]                                       ;; 00:0903 $7e
    and  A, A                                          ;; 00:0904 $a7
    ret  Z                                             ;; 00:0905 $c8
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0906 $21 $0f $d6
    bit  0, [HL]                                       ;; 00:0909 $cb $46
    jr   NZ, .jr_00_091e                               ;; 00:090b $20 $11
    bit  1, [HL]                                       ;; 00:090d $cb $4e
    jr   NZ, .jr_00_0933                               ;; 00:090f $20 $22
    bit  2, [HL]                                       ;; 00:0911 $cb $56
    jr   NZ, .jr_00_093e                               ;; 00:0913 $20 $29
    bit  3, [HL]                                       ;; 00:0915 $cb $5e
    jr   NZ, .jr_00_0949                               ;; 00:0917 $20 $30
    bit  4, [HL]                                       ;; 00:0919 $cb $66
    jr   NZ, .jr_00_0954                               ;; 00:091b $20 $37
    ret                                                ;; 00:091d $c9
.jr_00_091e:
    ld   A, [wD208_PlayerSpriteIndex]                                    ;; 00:091e $fa $08 $d2
    rlca                                               ;; 00:0921 $07
    rlca                                               ;; 00:0922 $07
    and  A, $03                                        ;; 00:0923 $e6 $03
    add  A, $04                                        ;; 00:0925 $c6 $04
    call call_00_1089_SwitchBank                                  ;; 00:0927 $cd $89 $10
    ld   A, [wD208_PlayerSpriteIndex]                                    ;; 00:092a $fa $08 $d2
    and  A, $3f                                        ;; 00:092d $e6 $3f
    add  A, $40                                        ;; 00:092f $c6 $40
    jr   .jr_00_095e                                   ;; 00:0931 $18 $2b
.jr_00_0933:
    ld   A, [wD589]                                    ;; 00:0933 $fa $89 $d5
    call call_00_1089_SwitchBank                                  ;; 00:0936 $cd $89 $10
    ld   A, [wD588]                                    ;; 00:0939 $fa $88 $d5
    jr   .jr_00_095e                                   ;; 00:093c $18 $20
.jr_00_093e:
    ld   A, [wD726_SpecialTilesetBank]                                    ;; 00:093e $fa $26 $d7 ; this is where it went when loading seconda tileset info
    call call_00_1089_SwitchBank                                  ;; 00:0941 $cd $89 $10
    ld   A, [wD728_CurrentSpecialTilesetAddr]                                    ;; 00:0944 $fa $28 $d7
    jr   .jr_00_095e                                   ;; 00:0947 $18 $15
.jr_00_0949:
    ld   A, [wD71F]                                    ;; 00:0949 $fa $1f $d7
    call call_00_1089_SwitchBank                                  ;; 00:094c $cd $89 $10
    ld   A, [wD721]                                    ;; 00:094f $fa $21 $d7
    jr   .jr_00_095e                                   ;; 00:0952 $18 $0a
.jr_00_0954:
    ld   A, $14                                        ;; 00:0954 $3e $14
    call call_00_1089_SwitchBank                                  ;; 00:0956 $cd $89 $10
    ld   A, [wD610]                                    ;; 00:0959 $fa $10 $d6
    add  A, $40                                        ;; 00:095c $c6 $40
.jr_00_095e:
    ld   H, A                                          ;; 00:095e $67
    ld   L, $00                                        ;; 00:095f $2e $00
    ld   DE, wD100_TilesToLoadBuffer                                     ;; 00:0961 $11 $00 $d1
    ld   B, $10                                        ;; 00:0964 $06 $10
    call call_00_0b6d                                  ;; 00:0966 $cd $6d $0b ; this reads special tileset information from other banks
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0969 $21 $0f $d6
    set  7, [HL]                                       ;; 00:096c $cb $fe
    jp   call_00_10a3_SwitchBank2                                  ;; 00:096e $c3 $a3 $10

call_00_0971:
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0971 $21 $0f $d6
    bit  0, [HL]                                       ;; 00:0974 $cb $46
    call NZ, call_00_098f                              ;; 00:0976 $c4 $8f $09
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0979 $21 $0f $d6
    bit  1, [HL]                                       ;; 00:097c $cb $4e
    call NZ, call_00_09be                              ;; 00:097e $c4 $be $09
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0981 $21 $0f $d6
    bit  2, [HL]                                       ;; 00:0984 $cb $56
    call NZ, call_00_09e3                              ;; 00:0986 $c4 $e3 $09
    call call_00_09fd                                  ;; 00:0989 $cd $fd $09
    jp   call_00_0a21                                    ;; 00:098c $c3 $21 $0a

call_00_098f:
    res  0, [HL]                                       ;; 00:098f $cb $86
    ld   A, [wD208_PlayerSpriteIndex]                                    ;; 00:0991 $fa $08 $d2
    rlca                                               ;; 00:0994 $07
    rlca                                               ;; 00:0995 $07
    and  A, $03                                        ;; 00:0996 $e6 $03
    add  A, $04                                        ;; 00:0998 $c6 $04
    call call_00_1089_SwitchBank                                  ;; 00:099a $cd $89 $10
    ld   A, [wD208_PlayerSpriteIndex]                                    ;; 00:099d $fa $08 $d2
    and  A, $3f                                        ;; 00:09a0 $e6 $3f
    add  A, $40                                        ;; 00:09a2 $c6 $40
    ld   H, A                                          ;; 00:09a4 $67
    ld   L, $00                                        ;; 00:09a5 $2e $00
    push HL                                            ;; 00:09a7 $e5
    ld   DE, $8000                                     ;; 00:09a8 $11 $00 $80
    ld   BC, $100                                      ;; 00:09ab $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:09ae $cd $b0 $07
    pop  HL                                            ;; 00:09b1 $e1
    ld   DE, $8100                                     ;; 00:09b2 $11 $00 $81
    ld   BC, $100                                      ;; 00:09b5 $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:09b8 $cd $b0 $07
    jp   call_00_10a3_SwitchBank2                                  ;; 00:09bb $c3 $a3 $10

call_00_09be:
    res  1, [HL]                                       ;; 00:09be $cb $8e
    ld   A, [wD589]                                    ;; 00:09c0 $fa $89 $d5
    call call_00_1089_SwitchBank                                  ;; 00:09c3 $cd $89 $10
    ld   A, [wD588]                                    ;; 00:09c6 $fa $88 $d5
    ld   H, A                                          ;; 00:09c9 $67
    ld   L, $00                                        ;; 00:09ca $2e $00
    push HL                                            ;; 00:09cc $e5
    ld   DE, $8200                                     ;; 00:09cd $11 $00 $82
    ld   BC, $100                                      ;; 00:09d0 $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:09d3 $cd $b0 $07
    pop  HL                                            ;; 00:09d6 $e1
    ld   DE, $8300                                     ;; 00:09d7 $11 $00 $83
    ld   BC, $100                                      ;; 00:09da $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:09dd $cd $b0 $07
    jp   call_00_10a3_SwitchBank2                                  ;; 00:09e0 $c3 $a3 $10

call_00_09e3:
    res  2, [HL]                                       ;; 00:09e3 $cb $96
    ld   A, [wD726_SpecialTilesetBank]                                    ;; 00:09e5 $fa $26 $d7
    call call_00_1089_SwitchBank                                  ;; 00:09e8 $cd $89 $10
    ld   A, [wD728_CurrentSpecialTilesetAddr]                                    ;; 00:09eb $fa $28 $d7
    ld   H, A                                          ;; 00:09ee $67
    ld   L, $00                                        ;; 00:09ef $2e $00
    ld   DE, $9000                                     ;; 00:09f1 $11 $00 $90
    ld   BC, $240                                      ;; 00:09f4 $01 $40 $02
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:09f7 $cd $b0 $07
    jp   call_00_10a3_SwitchBank2                                  ;; 00:09fa $c3 $a3 $10

call_00_09fd:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:09fd $fa $24 $d6
    and  A, A                                          ;; 00:0a00 $a7
    ret  NZ                                            ;; 00:0a01 $c0
    ld   A, [wD610]                                    ;; 00:0a02 $fa $10 $d6
    cp   A, $ff                                        ;; 00:0a05 $fe $ff
    ret  Z                                             ;; 00:0a07 $c8
    ld   A, $14                                        ;; 00:0a08 $3e $14
    call call_00_1089_SwitchBank                                  ;; 00:0a0a $cd $89 $10
    ld   A, [wD610]                                    ;; 00:0a0d $fa $10 $d6
    add  A, $40                                        ;; 00:0a10 $c6 $40
    ld   H, A                                          ;; 00:0a12 $67
    ld   L, $00                                        ;; 00:0a13 $2e $00
    ld   DE, $8600                                     ;; 00:0a15 $11 $00 $86
    ld   BC, $100                                      ;; 00:0a18 $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:0a1b $cd $b0 $07
    jp   call_00_10a3_SwitchBank2                                  ;; 00:0a1e $c3 $a3 $10

call_00_0a21:
    ld   [wD59D_ReturnBank], A                                    ;; 00:0a21 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:0a24 $3e $02
    ld   HL, entry_02_722c                                     ;; 00:0a26 $21 $2c $72
    call call_00_1078_CallAltBankFunc                                  ;; 00:0a29 $cd $78 $10
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0a2c $21 $0f $d6
    bit  3, [HL]                                       ;; 00:0a2f $cb $5e
    ret  Z                                             ;; 00:0a31 $c8
    res  3, [HL]                                       ;; 00:0a32 $cb $9e
    ld   A, [wD71F]                                    ;; 00:0a34 $fa $1f $d7
    call call_00_1089_SwitchBank                                  ;; 00:0a37 $cd $89 $10
    ld   HL, wD724                                     ;; 00:0a3a $21 $24 $d7
    ld   C, [HL]                                       ;; 00:0a3d $4e
    inc  HL                                            ;; 00:0a3e $23
    ld   B, [HL]                                       ;; 00:0a3f $46
    ld   HL, wD722                                     ;; 00:0a40 $21 $22 $d7
    ld   E, [HL]                                       ;; 00:0a43 $5e
    inc  HL                                            ;; 00:0a44 $23
    ld   D, [HL]                                       ;; 00:0a45 $56
    ld   HL, wD720                                     ;; 00:0a46 $21 $20 $d7
    ld   A, [HL+]                                      ;; 00:0a49 $2a
    ld   H, [HL]                                       ;; 00:0a4a $66
    ld   L, A                                          ;; 00:0a4b $6f
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:0a4c $cd $b0 $07
    call call_00_10a3_SwitchBank2                                  ;; 00:0a4f $cd $a3 $10
    jr   call_00_0a21                                    ;; 00:0a52 $18 $cd

call_00_0a54:
    push AF                                            ;; 00:0a54 $f5
    push BC                                            ;; 00:0a55 $c5
    push DE                                            ;; 00:0a56 $d5
    push HL                                            ;; 00:0a57 $e5
    call hFF80                                         ;; 00:0a58 $cd $80 $ff ; calls oam update code in hram
    call call_00_0ac1                                  ;; 00:0a5b $cd $c1 $0a
    ld   A, [wCCFD]                                    ;; 00:0a5e $fa $fd $cc
    bit  7, A                                          ;; 00:0a61 $cb $7f
    call Z, call_00_0bb9                               ;; 00:0a63 $cc $b9 $0b
    ld   HL, wCCFE                                     ;; 00:0a66 $21 $fe $cc
    ld   A, [HL+]                                      ;; 00:0a69 $2a
    ld   H, [HL]                                       ;; 00:0a6a $66
    ld   L, A                                          ;; 00:0a6b $6f
    call call_00_10bd_CallFuncInHL                                  ;; 00:0a6c $cd $bd $10
    call call_00_10be_UpdateCurrentInputs                                  ;; 00:0a6f $cd $be $10
    ld   A, $01                                        ;; 00:0a72 $3e $01
    ld   [wD622], A                                    ;; 00:0a74 $ea $22 $d6
    ld   A, [wD5A0]                                    ;; 00:0a77 $fa $a0 $d5
    ldh  [rLCDC], A                                    ;; 00:0a7a $e0 $40
    ld   A, [wD5A1]                                    ;; 00:0a7c $fa $a1 $d5
    ldh  [rSCX], A                                     ;; 00:0a7f $e0 $43
    ld   A, [wD5A2]                                    ;; 00:0a81 $fa $a2 $d5
    ldh  [rSCY], A                                     ;; 00:0a84 $e0 $42
    call call_00_0f80                                  ;; 00:0a86 $cd $80 $0f
    ld   A, [wD788_CurrentAudioBank]                                    ;; 00:0a89 $fa $88 $d7
    ld   [MBC1RomBank], A                                    ;; 00:0a8c $ea $01 $20
    swap A                                             ;; 00:0a8f $cb $37
    rrca                                               ;; 00:0a91 $0f
    and  A, $01                                        ;; 00:0a92 $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:0a94 $ea $01 $40
    call call_22_410c                                  ;; 00:0a97 $cd $0c $41
    ld   HL, wD73B                                     ;; 00:0a9a $21 $3b $d7
    inc  [HL]                                          ;; 00:0a9d $34
    ld   A, [wD59C_CurrentROMBank]                                    ;; 00:0a9e $fa $9c $d5
    ld   [MBC1RomBank], A                                    ;; 00:0aa1 $ea $01 $20
    swap A                                             ;; 00:0aa4 $cb $37
    rrca                                               ;; 00:0aa6 $0f
    and  A, $01                                        ;; 00:0aa7 $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:0aa9 $ea $01 $40
    xor  A, A                                          ;; 00:0aac $af
    ldh  [rIF], A                                      ;; 00:0aad $e0 $0f
    pop  HL                                            ;; 00:0aaf $e1
    pop  DE                                            ;; 00:0ab0 $d1
    pop  BC                                            ;; 00:0ab1 $c1
    pop  AF                                            ;; 00:0ab2 $f1
    reti                                               ;; 00:0ab3 $d9

call_00_0ab4_UpdateVRAMTiles: ; updates tiles in VRAM
    xor  A, A                                          ;; 00:0ab4 $af
    ld   [wD622], A                                    ;; 00:0ab5 $ea $22 $d6
.jr_00_0ab8:
    halt                                               ;; 00:0ab8 $76
    nop                                                ;; 00:0ab9 $00
    ld   A, [wD622]                                    ;; 00:0aba $fa $22 $d6
    and  A, A                                          ;; 00:0abd $a7
    jr   Z, .jr_00_0ab8                                ;; 00:0abe $28 $f8
    ret                                                ;; 00:0ac0 $c9

call_00_0ac1:
    ld   A, $03                                        ;; 00:0ac1 $3e $03
    ld   [MBC1RomBank], A                                    ;; 00:0ac3 $ea $01 $20
    swap A                                             ;; 00:0ac6 $cb $37
    rrca                                               ;; 00:0ac8 $0f
    and  A, $01                                        ;; 00:0ac9 $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:0acb $ea $01 $40
    ld   HL, wD6F9                                     ;; 00:0ace $21 $f9 $d6
    bit  7, [HL]                                       ;; 00:0ad1 $cb $7e
    jr   Z, .jr_00_0af0                                ;; 00:0ad3 $28 $1b
    res  7, [HL]                                       ;; 00:0ad5 $cb $be
    ld   A, [wD6F9]                                    ;; 00:0ad7 $fa $f9 $d6
    and  A, $0f                                        ;; 00:0ada $e6 $0f
    jr   Z, .jr_00_0af0                                ;; 00:0adc $28 $12
    and  A, $03                                        ;; 00:0ade $e6 $03
    call NZ, entry_03_6f5e_WriteVRAMBgMap                              ;; 00:0ae0 $c4 $5e $6f
    ld   A, [wD6F9]                                    ;; 00:0ae3 $fa $f9 $d6
    and  A, $0c                                        ;; 00:0ae6 $e6 $0c
    call NZ, entry_03_708d                              ;; 00:0ae8 $c4 $8d $70
    xor  A, A                                          ;; 00:0aeb $af
    ld   [wD6F9], A                                    ;; 00:0aec $ea $f9 $d6
    ret                                                ;; 00:0aef $c9
.jr_00_0af0:
    ld   HL, wD77B                                     ;; 00:0af0 $21 $7b $d7
    ld   A, [HL]                                       ;; 00:0af3 $7e
    res  0, [HL]                                       ;; 00:0af4 $cb $86
    bit  0, A                                          ;; 00:0af6 $cb $47
    jp   NZ, call_00_1779                                ;; 00:0af8 $c2 $79 $17
    ld   A, [wD72F]                                    ;; 00:0afb $fa $2f $d7
    and  A, A                                          ;; 00:0afe $a7
    jr   Z, .jr_00_0b0c                                ;; 00:0aff $28 $0b
    ld   HL, wD731                                     ;; 00:0b01 $21 $31 $d7
    ld   A, [HL+]                                      ;; 00:0b04 $2a
    dec  [HL]                                          ;; 00:0b05 $35
    jr   NZ, .jr_00_0b0c                               ;; 00:0b06 $20 $04
    ld   [HL], A                                       ;; 00:0b08 $77
    jp   .jp_00_0b24                                   ;; 00:0b09 $c3 $24 $0b
.jr_00_0b0c:
    ld   A, [wD60E]                                    ;; 00:0b0c $fa $0e $d6
    bit  3, A                                          ;; 00:0b0f $cb $5f
    call NZ, entry_03_6941                              ;; 00:0b11 $c4 $41 $69
    ld   A, [wD60E]                                    ;; 00:0b14 $fa $0e $d6
    bit  1, A                                          ;; 00:0b17 $cb $4f
    jp   NZ, entry_03_6d13                              ;; 00:0b19 $c2 $13 $6d
    bit  2, A                                          ;; 00:0b1c $cb $57
    jp   NZ, entry_03_6ceb                                ;; 00:0b1e $c2 $eb $6c
    jp   entry_03_7253_UpdateMovingTiles                                    ;; 00:0b21 $c3 $53 $72
.jp_00_0b24:
    ld   A, [wD72E]                                    ;; 00:0b24 $fa $2e $d7
    ld   [MBC1RomBank], A                                    ;; 00:0b27 $ea $01 $20
    swap A                                             ;; 00:0b2a $cb $37
    rrca                                               ;; 00:0b2c $0f
    and  A, $01                                        ;; 00:0b2d $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:0b2f $ea $01 $40
    ld   A, [wD738]                                    ;; 00:0b32 $fa $38 $d7
    and  A, $01                                        ;; 00:0b35 $e6 $01
    jr   Z, .jr_00_0b48                                ;; 00:0b37 $28 $0f
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0b39 $21 $0f $d6
    bit  2, [HL]                                       ;; 00:0b3c $cb $56
    ret  NZ                                            ;; 00:0b3e $c0
    xor  A, A                                          ;; 00:0b3f $af
    ld   [wD72F], A                                    ;; 00:0b40 $ea $2f $d7
    ld   HL, wD730                                     ;; 00:0b43 $21 $30 $d7
    jr   .jr_00_0b51                                   ;; 00:0b46 $18 $09
.jr_00_0b48:
    ld   HL, wD72F                                     ;; 00:0b48 $21 $2f $d7
    ld   A, [HL+]                                      ;; 00:0b4b $2a
    inc  [HL]                                          ;; 00:0b4c $34
    sub  A, [HL]                                       ;; 00:0b4d $96
    jr   NZ, .jr_00_0b51                               ;; 00:0b4e $20 $01
    ld   [HL], A                                       ;; 00:0b50 $77
.jr_00_0b51:
    ld   C, [HL]                                       ;; 00:0b51 $4e
    ld   B, $00                                        ;; 00:0b52 $06 $00
    ld   HL, wD734                                     ;; 00:0b54 $21 $34 $d7
    ld   E, [HL]                                       ;; 00:0b57 $5e
    inc  HL                                            ;; 00:0b58 $23
    ld   D, [HL]                                       ;; 00:0b59 $56
    inc  HL                                            ;; 00:0b5a $23
    ld   A, [HL+]                                      ;; 00:0b5b $2a
    ld   H, [HL]                                       ;; 00:0b5c $66
    ld   L, A                                          ;; 00:0b5d $6f
    add  HL, BC                                        ;; 00:0b5e $09
    add  HL, BC                                        ;; 00:0b5f $09
    add  HL, BC                                        ;; 00:0b60 $09
    add  HL, BC                                        ;; 00:0b61 $09
    ld   E, [HL]                                       ;; 00:0b62 $5e
    inc  HL                                            ;; 00:0b63 $23
    ld   D, [HL]                                       ;; 00:0b64 $56
    inc  HL                                            ;; 00:0b65 $23
    ld   A, [HL+]                                      ;; 00:0b66 $2a
    ld   H, [HL]                                       ;; 00:0b67 $66
    ld   L, A                                          ;; 00:0b68 $6f
    ld   A, [wD733]                                    ;; 00:0b69 $fa $33 $d7
    ld   B, A                                          ;; 00:0b6c $47

call_00_0b6d: ; writes tile data in VRAM, reads from banks
    ld   A, [HL+]                                      ;; 00:0b6d $2a
    ld   [DE], A                                       ;; 00:0b6e $12
    inc  E                                             ;; 00:0b6f $1c
    ld   A, [HL+]                                      ;; 00:0b70 $2a
    ld   [DE], A                                       ;; 00:0b71 $12
    inc  E                                             ;; 00:0b72 $1c
    ld   A, [HL+]                                      ;; 00:0b73 $2a
    ld   [DE], A                                       ;; 00:0b74 $12
    inc  E                                             ;; 00:0b75 $1c
    ld   A, [HL+]                                      ;; 00:0b76 $2a
    ld   [DE], A                                       ;; 00:0b77 $12
    inc  E                                             ;; 00:0b78 $1c
    ld   A, [HL+]                                      ;; 00:0b79 $2a
    ld   [DE], A                                       ;; 00:0b7a $12
    inc  E                                             ;; 00:0b7b $1c
    ld   A, [HL+]                                      ;; 00:0b7c $2a
    ld   [DE], A                                       ;; 00:0b7d $12
    inc  E                                             ;; 00:0b7e $1c
    ld   A, [HL+]                                      ;; 00:0b7f $2a
    ld   [DE], A                                       ;; 00:0b80 $12
    inc  E                                             ;; 00:0b81 $1c
    ld   A, [HL+]                                      ;; 00:0b82 $2a
    ld   [DE], A                                       ;; 00:0b83 $12
    inc  E                                             ;; 00:0b84 $1c
    ld   A, [HL+]                                      ;; 00:0b85 $2a
    ld   [DE], A                                       ;; 00:0b86 $12
    inc  E                                             ;; 00:0b87 $1c
    ld   A, [HL+]                                      ;; 00:0b88 $2a
    ld   [DE], A                                       ;; 00:0b89 $12
    inc  E                                             ;; 00:0b8a $1c
    ld   A, [HL+]                                      ;; 00:0b8b $2a
    ld   [DE], A                                       ;; 00:0b8c $12
    inc  E                                             ;; 00:0b8d $1c
    ld   A, [HL+]                                      ;; 00:0b8e $2a
    ld   [DE], A                                       ;; 00:0b8f $12
    inc  E                                             ;; 00:0b90 $1c
    ld   A, [HL+]                                      ;; 00:0b91 $2a
    ld   [DE], A                                       ;; 00:0b92 $12
    inc  E                                             ;; 00:0b93 $1c
    ld   A, [HL+]                                      ;; 00:0b94 $2a
    ld   [DE], A                                       ;; 00:0b95 $12
    inc  E                                             ;; 00:0b96 $1c
    ld   A, [HL+]                                      ;; 00:0b97 $2a
    ld   [DE], A                                       ;; 00:0b98 $12
    inc  E                                             ;; 00:0b99 $1c
    ld   A, [HL+]                                      ;; 00:0b9a $2a
    ld   [DE], A                                       ;; 00:0b9b $12
    inc  DE                                            ;; 00:0b9c $13
    dec  B                                             ;; 00:0b9d $05
    jr   NZ, call_00_0b6d                              ;; 00:0b9e $20 $cd
    ret                                                ;; 00:0ba0 $c9
;    db   $fa, $fd, $cc, $e6, $7f, $fe, $00, $c8        ;; 00:0ba1 ????????
;    db   $cd, $b4, $0a, $18, $f3                       ;; 00:0ba9 ?????

jr_00_0ba1:
    ld a, [$ccfd]
    and $7f
    cp $00
    ret z

    call call_00_0ab4_UpdateVRAMTiles
    jr jr_00_0ba1

call_00_0bae:
    ld   HL, wCCFD                                     ;; 00:0bae $21 $fd $cc
    or   A, $80                                        ;; 00:0bb1 $f6 $80
    cp   A, [HL]                                       ;; 00:0bb3 $be
    ret  Z                                             ;; 00:0bb4 $c8
    and  A, $7f                                        ;; 00:0bb5 $e6 $7f
    ld   [HL], A                                       ;; 00:0bb7 $77
    ret                                                ;; 00:0bb8 $c9

call_00_0bb9:
    ld   L, A                                          ;; 00:0bb9 $6f
    ld   H, $00                                        ;; 00:0bba $26 $00
    ld   DE, $bdc                                      ;; 00:0bbc $11 $dc $0b
    add  HL, DE                                        ;; 00:0bbf $19
    or   A, $80                                        ;; 00:0bc0 $f6 $80
    ld   [wCCFD], A                                    ;; 00:0bc2 $ea $fd $cc
    ld   B, [HL]                                       ;; 00:0bc5 $46
    inc  HL                                            ;; 00:0bc6 $23
    ld   A, [HL+]                                      ;; 00:0bc7 $2a
    ld   H, [HL]                                       ;; 00:0bc8 $66
    ld   L, A                                          ;; 00:0bc9 $6f
    ld   DE, wCCA0                                     ;; 00:0bca $11 $a0 $cc
.jr_00_0bcd:
    ld   A, [HL+]                                      ;; 00:0bcd $2a
    ld   [DE], A                                       ;; 00:0bce $12
    inc  E                                             ;; 00:0bcf $1c
    dec  B                                             ;; 00:0bd0 $05
    jr   NZ, .jr_00_0bcd                               ;; 00:0bd1 $20 $fa
    ld   A, L                                          ;; 00:0bd3 $7d
    ld   [wCCFE], A                                    ;; 00:0bd4 $ea $fe $cc
    ld   A, H                                          ;; 00:0bd7 $7c
    ld   [wCCFF], A                                    ;; 00:0bd8 $ea $ff $cc
    ret                                                ;; 00:0bdb $c9
    db   $01, $e5, $0b, $2a, $e7, $0b, $3b, $49        ;; 00:0bdc ........
    db   $0d, $d9                                      ;; 00:0be4 ..
    ret                                                ;; 00:0be6 $c9
    db   $d9, $e5, $d5, $21, $ff, $d1, $16, $80        ;; 00:0be7 ........
    db   $5d, $3a, $12, $1d, $3a, $12, $1d, $3a        ;; 00:0bef ........
    db   $12, $1d, $3a, $12, $7d, $ea, $a4, $cc        ;; 00:0bf7 ........
    db   $3c, $20, $0b, $21, $0f, $d6, $cb, $be        ;; 00:0bff ........
    db   $fa, $83, $0d, $ea, $a0, $cc, $d1, $e1        ;; 00:0c07 ........
    db   $f1, $d9                                      ;; 00:0c0f ..
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0c11 $21 $0f $d6
    bit  7, [HL]                                       ;; 00:0c14 $cb $7e
    ret  Z                                             ;; 00:0c16 $c8
    bit  0, [HL]                                       ;; 00:0c17 $cb $46
    jr   NZ, .jr_00_0c31                               ;; 00:0c19 $20 $16
    bit  1, [HL]                                       ;; 00:0c1b $cb $4e
    jr   NZ, .jr_00_0c55                               ;; 00:0c1d $20 $36
    bit  2, [HL]                                       ;; 00:0c1f $cb $56
    jp   NZ, .jp_00_0c78                               ;; 00:0c21 $c2 $78 $0c
    bit  3, [HL]                                       ;; 00:0c24 $cb $5e
    jp   NZ, .jp_00_0cb4                               ;; 00:0c26 $c2 $b4 $0c
    bit  4, [HL]                                       ;; 00:0c29 $cb $66
    jp   NZ, .jp_00_0cf0                               ;; 00:0c2b $c2 $f0 $0c
    res  7, [HL]                                       ;; 00:0c2e $cb $be
    ret                                                ;; 00:0c30 $c9
.jr_00_0c31:
    ld   A, [.data_00_0c54]                            ;; 00:0c31 $fa $54 $0c
    ld   [wCCA0], A                                    ;; 00:0c34 $ea $a0 $cc
    ld   HL, wCCA5                                     ;; 00:0c37 $21 $a5 $cc
    ld   A, $d1                                        ;; 00:0c3a $3e $d1
    ld   [HL-], A                                      ;; 00:0c3c $32
    ld   [HL], $ff                                     ;; 00:0c3d $36 $ff
    ld   A, [wD586]                                    ;; 00:0c3f $fa $86 $d5
    add  A, $80                                        ;; 00:0c42 $c6 $80
    ld   [wCCA7], A                                    ;; 00:0c44 $ea $a7 $cc
    and  A, $01                                        ;; 00:0c47 $e6 $01
    xor  A, $01                                        ;; 00:0c49 $ee $01
    ld   [wD586], A                                    ;; 00:0c4b $ea $86 $d5
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0c4e $21 $0f $d6
    res  0, [HL]                                       ;; 00:0c51 $cb $86
    ret                                                ;; 00:0c53 $c9
.data_00_0c54:
    db   $f5                                           ;; 00:0c54 .
.jr_00_0c55:
    ld   A, [.data_00_0c54]                            ;; 00:0c55 $fa $54 $0c
    ld   [wCCA0], A                                    ;; 00:0c58 $ea $a0 $cc
    ld   HL, wCCA5                                     ;; 00:0c5b $21 $a5 $cc
    ld   A, $d1                                        ;; 00:0c5e $3e $d1
    ld   [HL-], A                                      ;; 00:0c60 $32
    ld   [HL], $ff                                     ;; 00:0c61 $36 $ff
    ld   A, [wD587]                                    ;; 00:0c63 $fa $87 $d5
    add  A, $82                                        ;; 00:0c66 $c6 $82
    ld   [wCCA7], A                                    ;; 00:0c68 $ea $a7 $cc
    and  A, $01                                        ;; 00:0c6b $e6 $01
    xor  A, $01                                        ;; 00:0c6d $ee $01
    ld   [wD587], A                                    ;; 00:0c6f $ea $87 $d5
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0c72 $21 $0f $d6
    res  1, [HL]                                       ;; 00:0c75 $cb $8e
    ret                                                ;; 00:0c77 $c9
.jp_00_0c78:
    ld   A, [.data_00_0c54]                            ;; 00:0c78 $fa $54 $0c
    ld   [wCCA0], A                                    ;; 00:0c7b $ea $a0 $cc
    ld   A, $d1                                        ;; 00:0c7e $3e $d1
    ld   HL, wCCA5                                     ;; 00:0c80 $21 $a5 $cc
    ld   [HL-], A                                      ;; 00:0c83 $32
    ld   [HL], $ff                                     ;; 00:0c84 $36 $ff
    ld   A, [wD72A]                                    ;; 00:0c86 $fa $2a $d7
    ld   [wCCA7], A                                    ;; 00:0c89 $ea $a7 $cc
    ld   A, [wD72C]                                    ;; 00:0c8c $fa $2c $d7
    and  A, A                                          ;; 00:0c8f $a7
    jr   NZ, .jr_00_0c9f                               ;; 00:0c90 $20 $0d
    ld   A, [wD72B]                                    ;; 00:0c92 $fa $2b $d7
    dec  A                                             ;; 00:0c95 $3d
    ld   [wCCA4], A                                    ;; 00:0c96 $ea $a4 $cc
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0c99 $21 $0f $d6
    res  2, [HL]                                       ;; 00:0c9c $cb $96
    ret                                                ;; 00:0c9e $c9
.jr_00_0c9f:
    ld   HL, wD728_CurrentSpecialTilesetAddr                                     ;; 00:0c9f $21 $28 $d7
    inc  [HL]                                          ;; 00:0ca2 $34
    ld   HL, wD72A                                     ;; 00:0ca3 $21 $2a $d7
    inc  [HL]                                          ;; 00:0ca6 $34
    ld   HL, wD72C                                     ;; 00:0ca7 $21 $2c $d7
    dec  [HL]                                          ;; 00:0caa $35
    ld   A, [HL-]                                      ;; 00:0cab $3a
    or   A, [HL]                                       ;; 00:0cac $b6
    ret  NZ                                            ;; 00:0cad $c0
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0cae $21 $0f $d6
    res  2, [HL]                                       ;; 00:0cb1 $cb $96
    ret                                                ;; 00:0cb3 $c9
.jp_00_0cb4:
    ld   A, [.data_00_0c54]                            ;; 00:0cb4 $fa $54 $0c
    ld   [wCCA0], A                                    ;; 00:0cb7 $ea $a0 $cc
    ld   A, $d1                                        ;; 00:0cba $3e $d1
    ld   HL, wCCA5                                     ;; 00:0cbc $21 $a5 $cc
    ld   [HL-], A                                      ;; 00:0cbf $32
    ld   [HL], $ff                                     ;; 00:0cc0 $36 $ff
    ld   A, [wD723]                                    ;; 00:0cc2 $fa $23 $d7
    ld   [wCCA7], A                                    ;; 00:0cc5 $ea $a7 $cc
    ld   A, [wD725]                                    ;; 00:0cc8 $fa $25 $d7
    and  A, A                                          ;; 00:0ccb $a7
    jr   NZ, .jr_00_0cdb                               ;; 00:0ccc $20 $0d
    ld   A, [wD724]                                    ;; 00:0cce $fa $24 $d7
    dec  A                                             ;; 00:0cd1 $3d
    ld   [wCCA4], A                                    ;; 00:0cd2 $ea $a4 $cc
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0cd5 $21 $0f $d6
    res  3, [HL]                                       ;; 00:0cd8 $cb $9e
    ret                                                ;; 00:0cda $c9
.jr_00_0cdb:
    ld   HL, wD721                                     ;; 00:0cdb $21 $21 $d7
    inc  [HL]                                          ;; 00:0cde $34
    ld   HL, wD723                                     ;; 00:0cdf $21 $23 $d7
    inc  [HL]                                          ;; 00:0ce2 $34
    ld   HL, wD725                                     ;; 00:0ce3 $21 $25 $d7
    dec  [HL]                                          ;; 00:0ce6 $35
    ld   A, [HL-]                                      ;; 00:0ce7 $3a
    or   A, [HL]                                       ;; 00:0ce8 $b6
    ret  NZ                                            ;; 00:0ce9 $c0
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0cea $21 $0f $d6
    res  3, [HL]                                       ;; 00:0ced $cb $9e
    ret                                                ;; 00:0cef $c9
.jp_00_0cf0:
    ld   A, [.data_00_0c54]                            ;; 00:0cf0 $fa $54 $0c
    ld   [wCCA0], A                                    ;; 00:0cf3 $ea $a0 $cc
    ld   HL, wCCA5                                     ;; 00:0cf6 $21 $a5 $cc
    ld   A, $d1                                        ;; 00:0cf9 $3e $d1
    ld   [HL-], A                                      ;; 00:0cfb $32
    ld   [HL], $ff                                     ;; 00:0cfc $36 $ff
    ld   A, $86                                        ;; 00:0cfe $3e $86
    ld   [wCCA7], A                                    ;; 00:0d00 $ea $a7 $cc
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0d03 $21 $0f $d6
    res  4, [HL]                                       ;; 00:0d06 $cb $a6
    ret                                                ;; 00:0d08 $c9
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d09 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d11 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d19 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d21 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d29 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d31 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d39 ????????
    db   $00, $ff, $00, $01, $00, $ff, $00, $01        ;; 00:0d41 ????????
    db   $f5, $e5, $d5, $f0, $44, $fe, $5f, $20        ;; 00:0d49 ........
    db   $05, $fa, $e1, $d6, $e0, $40, $f0, $44        ;; 00:0d51 ........
    db   $21, $eb, $d6, $96, $38, $21, $21, $ec        ;; 00:0d59 ........
    db   $d6, $be, $38, $05, $af, $e0, $43, $18        ;; 00:0d61 ........
    db   $16, $5f, $16, $00, $fa, $3b, $d7, $0f        ;; 00:0d69 ........
    db   $0f, $0f, $e6, $07, $6f, $26, $00, $19        ;; 00:0d71 ........
    db   $11, $09, $0d, $19, $7e, $e0, $43, $d1        ;; 00:0d79 ........
    db   $e1, $f1, $d9                                 ;; 00:0d81 ...
    ld   HL, wD6E2                                     ;; 00:0d84 $21 $e2 $d6
    ld   A, [HL]                                       ;; 00:0d87 $7e
    and  A, A                                          ;; 00:0d88 $a7
    ret  Z                                             ;; 00:0d89 $c8
    dec  [HL]                                          ;; 00:0d8a $35
    inc  HL                                            ;; 00:0d8b $23
    ld   B, [HL]                                       ;; 00:0d8c $46
    inc  HL                                            ;; 00:0d8d $23
    ld   A, [HL]                                       ;; 00:0d8e $7e
    ld   [MBC1RomBank], A                                    ;; 00:0d8f $ea $01 $20
    swap A                                             ;; 00:0d92 $cb $37
    rrca                                               ;; 00:0d94 $0f
    and  A, $01                                        ;; 00:0d95 $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:0d97 $ea $01 $40
    ld   HL, wD6E9                                     ;; 00:0d9a $21 $e9 $d6
    ld   A, [HL+]                                      ;; 00:0d9d $2a
    ld   H, [HL]                                       ;; 00:0d9e $66
    ld   L, A                                          ;; 00:0d9f $6f
    ld   E, [HL]                                       ;; 00:0da0 $5e
    inc  HL                                            ;; 00:0da1 $23
    ld   D, [HL]                                       ;; 00:0da2 $56
    inc  HL                                            ;; 00:0da3 $23
    push DE                                            ;; 00:0da4 $d5
    ld   E, [HL]                                       ;; 00:0da5 $5e
    inc  HL                                            ;; 00:0da6 $23
    ld   D, [HL]                                       ;; 00:0da7 $56
    inc  HL                                            ;; 00:0da8 $23
    ld   A, L                                          ;; 00:0da9 $7d
    ld   [wD6E9], A                                    ;; 00:0daa $ea $e9 $d6
    ld   A, H                                          ;; 00:0dad $7c
    ld   [wD6EA], A                                    ;; 00:0dae $ea $ea $d6
    pop  HL                                            ;; 00:0db1 $e1
    jp   call_00_0b6d                                  ;; 00:0db2 $c3 $6d $0b
    db   $c9, $08, $04, $00, $00, $c0                  ;; 00:0db5 ?.....
    dw   $8460                                         ;; 00:0dbb pP
    db   $40, $c0                                      ;; 00:0dbd ..
    dw   $84a0                                         ;; 00:0dbf pP
    db   $80, $c0                                      ;; 00:0dc1 ..
    dw   $84e0                                         ;; 00:0dc3 pP
    db   $c0, $c0                                      ;; 00:0dc5 ..
    dw   $8520                                         ;; 00:0dc7 pP
    db   $00, $c1                                      ;; 00:0dc9 ..
    dw   $8560                                         ;; 00:0dcb pP
    db   $40, $c1                                      ;; 00:0dcd ..
    dw   $85a0                                         ;; 00:0dcf pP
    db   $80, $c1                                      ;; 00:0dd1 ..
    dw   $85e0                                         ;; 00:0dd3 pP
    db   $c0, $c1                                      ;; 00:0dd5 ..
    dw   $8620                                         ;; 00:0dd7 pP
    db   $dd, $0d, $f8, $0d, $06, $06, $08, $d0        ;; 00:0dd9 ........
    db   $6f                                           ;; 00:0de1 .
    dw   $8cb0                                         ;; 00:0de2 pP
    db   $30, $70                                      ;; 00:0de4 ..
    dw   $8df0                                         ;; 00:0de6 pP
    db   $90, $70                                      ;; 00:0de8 ..
    dw   $9030                                         ;; 00:0dea pP
    db   $f0, $70                                      ;; 00:0dec ..
    dw   $9170                                         ;; 00:0dee pP
    db   $50, $71                                      ;; 00:0df0 ..
    dw   $92b0                                         ;; 00:0df2 pP
    db   $b0, $71                                      ;; 00:0df4 ..
    dw   $93f0                                         ;; 00:0df6 pP
    db   $06, $06, $08, $10, $72                       ;; 00:0df8 .....
    dw   $8cb0                                         ;; 00:0dfd pP
    db   $70, $72                                      ;; 00:0dff ..
    dw   $8df0                                         ;; 00:0e01 pP
    db   $d0, $72                                      ;; 00:0e03 ..
    dw   $9030                                         ;; 00:0e05 pP
    db   $30, $73                                      ;; 00:0e07 ..
    dw   $9170                                         ;; 00:0e09 pP
    db   $90, $73                                      ;; 00:0e0b ..
    dw   $92b0                                         ;; 00:0e0d pP
    db   $f0, $73                                      ;; 00:0e0f ..
    dw   $93f0                                         ;; 00:0e11 pP
    db   $1b, $0e, $36, $0e, $51, $0e, $6c, $0e        ;; 00:0e13 ????????
    db   $06, $06, $0c, $e8, $57, $00, $8d, $48        ;; 00:0e1b ????????
    db   $58, $40, $8e, $a8, $58, $80, $90, $08        ;; 00:0e23 ????????
    db   $59, $c0, $91, $68, $59, $00, $93, $c8        ;; 00:0e2b ????????
    db   $59, $40, $94, $06, $06, $0c, $28, $5a        ;; 00:0e33 ????????
    db   $00, $8d, $88, $5a, $40, $8e, $e8, $5a        ;; 00:0e3b ????????
    db   $80, $90, $48, $5b, $c0, $91, $a8, $5b        ;; 00:0e43 ????????
    db   $00, $93, $08, $5c, $40, $94, $06, $06        ;; 00:0e4b ????????
    db   $0c, $68, $5c, $00, $8d, $c8, $5c, $40        ;; 00:0e53 ????????
    db   $8e, $28, $5d, $80, $90, $88, $5d, $c0        ;; 00:0e5b ????????
    db   $91, $e8, $5d, $00, $93, $48, $5e, $40        ;; 00:0e63 ????????
    db   $94, $06, $06, $0c, $a8, $5e, $00, $8d        ;; 00:0e6b ????????
    db   $08, $5f, $40, $8e, $68, $5f, $80, $90        ;; 00:0e73 ????????
    db   $c8, $5f, $c0, $91, $28, $60, $00, $93        ;; 00:0e7b ????????
    db   $88, $60, $40, $94                            ;; 00:0e83 ????

call_00_0e87:
    ld   A, [wD59E]                                    ;; 00:0e87 $fa $9e $d5
    and  A, A                                          ;; 00:0e8a $a7
    jr   Z, .jr_00_0e98                                ;; 00:0e8b $28 $0b
    ld   A, $01                                        ;; 00:0e8d $3e $01
    ldh  [rVBK], A                                     ;; 00:0e8f $e0 $4f
    call call_00_0ec4_ClearTileVRAM                                  ;; 00:0e91 $cd $c4 $0e
    ld   A, $00                                        ;; 00:0e94 $3e $00
    ldh  [rVBK], A                                     ;; 00:0e96 $e0 $4f
.jr_00_0e98:
    call call_00_0ec4_ClearTileVRAM                                  ;; 00:0e98 $cd $c4 $0e
    ld   A, [wD59E]                                    ;; 00:0e9b $fa $9e $d5
    and  A, A                                          ;; 00:0e9e $a7
    jr   Z, .jr_00_0eac                                ;; 00:0e9f $28 $0b
    ld   A, $01                                        ;; 00:0ea1 $3e $01
    ldh  [rVBK], A                                     ;; 00:0ea3 $e0 $4f
    call call_00_0eba_ClearVRAMBgMap                                  ;; 00:0ea5 $cd $ba $0e
    ld   A, $00                                        ;; 00:0ea8 $3e $00
    ldh  [rVBK], A                                     ;; 00:0eaa $e0 $4f
.jr_00_0eac:
    call call_00_0eba_ClearVRAMBgMap                                  ;; 00:0eac $cd $ba $0e
    call call_00_0ee8                                  ;; 00:0eaf $cd $e8 $0e
    xor  A, A                                          ;; 00:0eb2 $af
    ld   [wD5A1], A                                    ;; 00:0eb3 $ea $a1 $d5
    ld   [wD5A2], A                                    ;; 00:0eb6 $ea $a2 $d5
    ret                                                ;; 00:0eb9 $c9

call_00_0eba_ClearVRAMBgMap:
    ld   HL, $9800                                     ;; 00:0eba $21 $00 $98
    xor  A, A                                          ;; 00:0ebd $af
.jr_00_0ebe:
    ld   [HL+], A                                      ;; 00:0ebe $22
    bit  5, H                                          ;; 00:0ebf $cb $6c
    jr   Z, .jr_00_0ebe                                ;; 00:0ec1 $28 $fb
    ret                                                ;; 00:0ec3 $c9

call_00_0ec4_ClearTileVRAM:
    ld   HL, $8000                                     ;; 00:0ec4 $21 $00 $80
.jr_00_0ec7:
    xor  A, A                                          ;; 00:0ec7 $af
    ld   [HL+], A                                      ;; 00:0ec8 $22
    ld   [HL+], A                                      ;; 00:0ec9 $22
    ld   [HL+], A                                      ;; 00:0eca $22
    ld   [HL+], A                                      ;; 00:0ecb $22
    ld   [HL+], A                                      ;; 00:0ecc $22
    ld   [HL+], A                                      ;; 00:0ecd $22
    ld   [HL+], A                                      ;; 00:0ece $22
    ld   [HL+], A                                      ;; 00:0ecf $22
    ld   [HL+], A                                      ;; 00:0ed0 $22
    ld   [HL+], A                                      ;; 00:0ed1 $22
    ld   [HL+], A                                      ;; 00:0ed2 $22
    ld   [HL+], A                                      ;; 00:0ed3 $22
    ld   [HL+], A                                      ;; 00:0ed4 $22
    ld   [HL+], A                                      ;; 00:0ed5 $22
    ld   [HL+], A                                      ;; 00:0ed6 $22
    ld   [HL+], A                                      ;; 00:0ed7 $22
    ld   A, H                                          ;; 00:0ed8 $7c
    cp   A, $98                                        ;; 00:0ed9 $fe $98
    jr   NZ, .jr_00_0ec7                               ;; 00:0edb $20 $ea
    ret                                                ;; 00:0edd $c9

call_00_0ede:
    ld   A, [wD59E]                                    ;; 00:0ede $fa $9e $d5
    and  A, A                                          ;; 00:0ee1 $a7
    ret  Z                                             ;; 00:0ee2 $c8
    ld   A, $01                                        ;; 00:0ee3 $3e $01
    ldh  [rSVBK], A                                    ;; 00:0ee5 $e0 $70
    ret                                                ;; 00:0ee7 $c9

call_00_0ee8:
    ld   HL, wCC00                                     ;; 00:0ee8 $21 $00 $cc
    ld   DE, wCC01                                     ;; 00:0eeb $11 $01 $cc
    ld   BC, $9f                                       ;; 00:0eee $01 $9f $00
    ld   [HL], $00                                     ;; 00:0ef1 $36 $00
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:0ef3 $cd $b0 $07
    ret                                                ;; 00:0ef6 $c9
    db   $3e, $cc, $e0, $46, $3e, $28, $3d, $20        ;; 00:0ef7 ........
    db   $fd, $c9                                      ;; 00:0eff ..

call_00_0f01:
    ld   A, $00                                        ;; 00:0f01 $3e $00
    ld   [wCCFD], A                                    ;; 00:0f03 $ea $fd $cc
    xor  A, A                                          ;; 00:0f06 $af
    ld   [wD6F9], A                                    ;; 00:0f07 $ea $f9 $d6
    ld   [wD60E], A                                    ;; 00:0f0a $ea $0e $d6
    ld   [wD60F_BitmapOfThingsToLoad], A                                    ;; 00:0f0d $ea $0f $d6
    ld   [wD77B], A                                    ;; 00:0f10 $ea $7b $d7
    ld   [wD72F], A                                    ;; 00:0f13 $ea $2f $d7
    ld   [wD611_MovingTilesId], A                                    ;; 00:0f16 $ea $11 $d6
    ld   [wD6E2], A                                    ;; 00:0f19 $ea $e2 $d6
    ld   [wDAD9], A                                    ;; 00:0f1c $ea $d9 $da
    ld   [wD71E], A                                    ;; 00:0f1f $ea $1e $d7
    ld   A, $ff                                        ;; 00:0f22 $3e $ff
    ld   [wD789], A                                    ;; 00:0f24 $ea $89 $d7
    ld   A, [wD5A0]                                    ;; 00:0f27 $fa $a0 $d5
    and  A, $7f                                        ;; 00:0f2a $e6 $7f
    ld   [wD5A0], A                                    ;; 00:0f2c $ea $a0 $d5
    jp   call_00_0ab4_UpdateVRAMTiles                                  ;; 00:0f2f $c3 $b4 $0a

call_00_0f32:
    ld   [wD5A0], A                                    ;; 00:0f32 $ea $a0 $d5
    ldh  [rLCDC], A                                    ;; 00:0f35 $e0 $40
    ret                                                ;; 00:0f37 $c9

call_00_0f38:
    call call_00_0f64                                  ;; 00:0f38 $cd $64 $0f
.jr_00_0f3b:
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:0f3b $cd $b4 $0a
    ld   HL, wDAD4                                     ;; 00:0f3e $21 $d4 $da
    ld   DE, wDACE                                     ;; 00:0f41 $11 $ce $da
    ld   B, $03                                        ;; 00:0f44 $06 $03
.jr_00_0f46:
    ld   A, [DE]                                       ;; 00:0f46 $1a
    cp   A, [HL]                                       ;; 00:0f47 $be
    jr   NZ, .jr_00_0f3b                               ;; 00:0f48 $20 $f1
    inc  DE                                            ;; 00:0f4a $13
    inc  HL                                            ;; 00:0f4b $23
    dec  B                                             ;; 00:0f4c $05
    jr   NZ, .jr_00_0f46                               ;; 00:0f4d $20 $f7
    call call_00_0f01                                  ;; 00:0f4f $cd $01 $0f
    call call_00_0e87                                  ;; 00:0f52 $cd $87 $0e
    ret                                                ;; 00:0f55 $c9

call_00_0f56:
    call call_00_0f32                                  ;; 00:0f56 $cd $32 $0f
    call call_00_0f72                                  ;; 00:0f59 $cd $72 $0f
    ret                                                ;; 00:0f5c $c9

call_00_0f5d:
    ld   A, $03                                        ;; 00:0f5d $3e $03
    ld   DE, $fdff                                     ;; 00:0f5f $11 $ff $fd
    jr   jr_00_0f69                                    ;; 00:0f62 $18 $05

call_00_0f64:
    ld   A, $02                                        ;; 00:0f64 $3e $02
    ld   DE, rIE                                       ;; 00:0f66 $11 $ff $ff

jr_00_0f69:
    ld   HL, wDAD7                                     ;; 00:0f69 $21 $d7 $da
    ld   [HL], E                                       ;; 00:0f6c $73
    inc  HL                                            ;; 00:0f6d $23
    ld   [HL], D                                       ;; 00:0f6e $72
    jp   call_00_0fbc                                    ;; 00:0f6f $c3 $bc $0f

call_00_0f72:
    ld   A, $01                                        ;; 00:0f72 $3e $01
    ld   DE, rIE                                       ;; 00:0f74 $11 $ff $ff
    ld   HL, wDAD7                                     ;; 00:0f77 $21 $d7 $da
    ld   [HL], E                                       ;; 00:0f7a $73
    inc  HL                                            ;; 00:0f7b $23
    ld   [HL], D                                       ;; 00:0f7c $72
    jp   call_00_0fbc                                    ;; 00:0f7d $c3 $bc $0f

call_00_0f80:
    ld   A, [wD59E]                                    ;; 00:0f80 $fa $9e $d5
    and  A, A                                          ;; 00:0f83 $a7
    jr   NZ, .jr_00_0f99                               ;; 00:0f84 $20 $13
    call call_00_1004                                  ;; 00:0f86 $cd $04 $10
    ld   A, [wDACE]                                    ;; 00:0f89 $fa $ce $da
    ldh  [rBGP], A                                     ;; 00:0f8c $e0 $47
    ld   A, [wDACF]                                    ;; 00:0f8e $fa $cf $da
    ldh  [rOBP0], A                                    ;; 00:0f91 $e0 $48
    ld   A, [wDAD0]                                    ;; 00:0f93 $fa $d0 $da
    ldh  [rOBP1], A                                    ;; 00:0f96 $e0 $49
    ret                                                ;; 00:0f98 $c9
.jr_00_0f99:
    call call_00_0f9d_UpdateLCDPalettes                ;; 00:0f99 $cd $9d $0f
    ret                                                ;; 00:0f9c $c9

call_00_0f9d_UpdateLCDPalettes:
    ld   A, $80                                        ;; 00:0f9d $3e $80
    ldh  [rBCPS], A                                    ;; 00:0f9f $e0 $68
    ld   HL, wD9CB_Bg_Palettes                         ;; 00:0fa1 $21 $cb $d9
    ld   B, $40                                        ;; 00:0fa4 $06 $40
.jr_00_0fa6:
    ld   A, [HL+]                                      ;; 00:0fa6 $2a
    ldh  [rBCPD], A                                    ;; 00:0fa7 $e0 $69
    dec  B                                             ;; 00:0fa9 $05
    jr   NZ, .jr_00_0fa6                               ;; 00:0faa $20 $fa
    ld   A, $80                                        ;; 00:0fac $3e $80
    ldh  [rOCPS], A                                    ;; 00:0fae $e0 $6a
    ld   HL, wDA0B_Obj_Palettes                        ;; 00:0fb0 $21 $0b $da
    ld   B, $40                                        ;; 00:0fb3 $06 $40
.jr_00_0fb5:
    ld   A, [HL+]                                      ;; 00:0fb5 $2a
    ldh  [rOCPD], A                                    ;; 00:0fb6 $e0 $6b
    dec  B                                             ;; 00:0fb8 $05
    jr   NZ, .jr_00_0fb5                               ;; 00:0fb9 $20 $fa
    ret                                                ;; 00:0fbb $c9

call_00_0fbc:
    ld   HL, wDAD9                                     ;; 00:0fbc $21 $d9 $da
    cp   A, [HL]                                       ;; 00:0fbf $be
    ret  Z                                             ;; 00:0fc0 $c8
    ld   [HL], A                                       ;; 00:0fc1 $77
    dec  A                                             ;; 00:0fc2 $3d
    ld   L, A                                          ;; 00:0fc3 $6f
    ld   H, $00                                        ;; 00:0fc4 $26 $00
    add  HL, HL                                        ;; 00:0fc6 $29
    ld   DE, $fd7                                      ;; 00:0fc7 $11 $d7 $0f
    add  HL, DE                                        ;; 00:0fca $19
    ld   A, [HL+]                                      ;; 00:0fcb $2a
    ld   H, [HL]                                       ;; 00:0fcc $66
    ld   L, A                                          ;; 00:0fcd $6f
    ld   A, $04                                        ;; 00:0fce $3e $04
    ld   [wDADA], A                                    ;; 00:0fd0 $ea $da $da
    ld   [wDADB], A                                    ;; 00:0fd3 $ea $db $da
    jp   HL                                            ;; 00:0fd6 $e9
    dw   .data_00_0fdd                                 ;; 00:0fd7 pP
    dw   .data_00_0fed                                 ;; 00:0fd9 pP
    dw   .data_00_0ff8                                 ;; 00:0fdb pP
.data_00_0fdd:
    ld   HL, wDAD1                                     ;; 00:0fdd $21 $d1 $da
    ld   A, [HL+]                                      ;; 00:0fe0 $2a
    ld   [wDAD4], A                                    ;; 00:0fe1 $ea $d4 $da
    ld   A, [HL+]                                      ;; 00:0fe4 $2a
    ld   [wDAD5], A                                    ;; 00:0fe5 $ea $d5 $da
    ld   A, [HL+]                                      ;; 00:0fe8 $2a
    ld   [wDAD6], A                                    ;; 00:0fe9 $ea $d6 $da
    ret                                                ;; 00:0fec $c9
.data_00_0fed:
    xor  A, A                                          ;; 00:0fed $af
    ld   [wDAD4], A                                    ;; 00:0fee $ea $d4 $da
    ld   [wDAD5], A                                    ;; 00:0ff1 $ea $d5 $da
    ld   [wDAD6], A                                    ;; 00:0ff4 $ea $d6 $da
    ret                                                ;; 00:0ff7 $c9
.data_00_0ff8:
    ld   A, $ff                                        ;; 00:0ff8 $3e $ff
    ld   [wDAD4], A                                    ;; 00:0ffa $ea $d4 $da
    ld   [wDAD5], A                                    ;; 00:0ffd $ea $d5 $da
    ld   [wDAD6], A                                    ;; 00:1000 $ea $d6 $da
    ret                                                ;; 00:1003 $c9

call_00_1004:
    ld   A, [wDAD9]                                    ;; 00:1004 $fa $d9 $da
    and  A, A                                          ;; 00:1007 $a7
    ret  Z                                             ;; 00:1008 $c8
    ld   HL, wDADB                                     ;; 00:1009 $21 $db $da
    dec  [HL]                                          ;; 00:100c $35
    ret  NZ                                            ;; 00:100d $c0
    ld   A, [wDADA]                                    ;; 00:100e $fa $da $da
    ld   [HL], A                                       ;; 00:1011 $77
    ld   HL, wDAD9                                     ;; 00:1012 $21 $d9 $da
    ld   L, [HL]                                       ;; 00:1015 $6e
    dec  L                                             ;; 00:1016 $2d
    ld   H, $00                                        ;; 00:1017 $26 $00
    add  HL, HL                                        ;; 00:1019 $29
    ld   DE, $1043                                     ;; 00:101a $11 $43 $10
    add  HL, DE                                        ;; 00:101d $19
    ld   A, [HL+]                                      ;; 00:101e $2a
    ld   H, [HL]                                       ;; 00:101f $66
    ld   L, A                                          ;; 00:1020 $6f
    call call_00_10bd_CallFuncInHL                                  ;; 00:1021 $cd $bd $10
    ld   HL, wDAD7                                     ;; 00:1024 $21 $d7 $da
    bit  0, [HL]                                       ;; 00:1027 $cb $46
    ld   A, $00                                        ;; 00:1029 $3e $00
    call NZ, call_00_104a                              ;; 00:102b $c4 $4a $10
    ld   HL, wDAD8                                     ;; 00:102e $21 $d8 $da
    bit  0, [HL]                                       ;; 00:1031 $cb $46
    ld   A, $01                                        ;; 00:1033 $3e $01
    call NZ, call_00_104a                              ;; 00:1035 $c4 $4a $10
    ld   HL, wDAD8                                     ;; 00:1038 $21 $d8 $da
    bit  1, [HL]                                       ;; 00:103b $cb $4e
    ld   A, $02                                        ;; 00:103d $3e $02
    call NZ, call_00_104a                              ;; 00:103f $c4 $4a $10
    ret                                                ;; 00:1042 $c9
    db   $49, $10, $49, $10, $49, $10, $c9             ;; 00:1043 ???????

call_00_104a:
    ld   E, A                                          ;; 00:104a $5f
    ld   D, $00                                        ;; 00:104b $16 $00
    ld   HL, wDACE                                     ;; 00:104d $21 $ce $da
    add  HL, DE                                        ;; 00:1050 $19
    push HL                                            ;; 00:1051 $e5
    ld   C, [HL]                                       ;; 00:1052 $4e
    ld   HL, wDAD4                                     ;; 00:1053 $21 $d4 $da
    add  HL, DE                                        ;; 00:1056 $19
    ld   E, [HL]                                       ;; 00:1057 $5e
    ld   B, $04                                        ;; 00:1058 $06 $04
.jr_00_105a:
    ld   A, E                                          ;; 00:105a $7b
    and  A, $03                                        ;; 00:105b $e6 $03
    ld   D, A                                          ;; 00:105d $57
    ld   A, C                                          ;; 00:105e $79
    and  A, $03                                        ;; 00:105f $e6 $03
    cp   A, D                                          ;; 00:1061 $ba
    jr   Z, .jr_00_106a                                ;; 00:1062 $28 $06
    jr   C, .jr_00_1069                                ;; 00:1064 $38 $03
    dec  C                                             ;; 00:1066 $0d
    jr   .jr_00_106a                                   ;; 00:1067 $18 $01
.jr_00_1069:
    inc  C                                             ;; 00:1069 $0c
.jr_00_106a:
    rrc  C                                             ;; 00:106a $cb $09
    rrc  C                                             ;; 00:106c $cb $09
    rrc  E                                             ;; 00:106e $cb $0b
    rrc  E                                             ;; 00:1070 $cb $0b
    dec  B                                             ;; 00:1072 $05
    jr   NZ, .jr_00_105a                               ;; 00:1073 $20 $e5
    pop  HL                                            ;; 00:1075 $e1
    ld   [HL], C                                       ;; 00:1076 $71
    ret                                                ;; 00:1077 $c9

call_00_1078_CallAltBankFunc:
    push HL                                            ;; 00:1078 $e5
    call call_00_1089_SwitchBank                                  ;; 00:1079 $cd $89 $10
    pop  HL                                            ;; 00:107c $e1
    ld   A, [wD59D_ReturnBank]                                    ;; 00:107d $fa $9d $d5
    call call_00_10bd_CallFuncInHL                                  ;; 00:1080 $cd $bd $10
    push AF                                            ;; 00:1083 $f5
    call call_00_10a3_SwitchBank2                                  ;; 00:1084 $cd $a3 $10
    pop  AF                                            ;; 00:1087 $f1
    ret                                                ;; 00:1088 $c9

call_00_1089_SwitchBank:
    ld   HL, wD59A                                     ;; 00:1089 $21 $9a $d5
    ld   E, [HL]                                       ;; 00:108c $5e
    inc  HL                                            ;; 00:108d $23
    ld   D, [HL]                                       ;; 00:108e $56
    inc  DE                                            ;; 00:108f $13
    ld   [DE], A                                       ;; 00:1090 $12
    ld   [HL], D                                       ;; 00:1091 $72
    dec  HL                                            ;; 00:1092 $2b
    ld   [HL], E                                       ;; 00:1093 $73
    ld   [wD59C_CurrentROMBank], A                                    ;; 00:1094 $ea $9c $d5
    ld   [MBC1RomBank], A                                    ;; 00:1097 $ea $01 $20
    swap A                                             ;; 00:109a $cb $37
    rrca                                               ;; 00:109c $0f
    and  A, $01                                        ;; 00:109d $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:109f $ea $01 $40
    ret                                                ;; 00:10a2 $c9

call_00_10a3_SwitchBank2:
    ld   HL, wD59A                                     ;; 00:10a3 $21 $9a $d5
    ld   E, [HL]                                       ;; 00:10a6 $5e
    inc  HL                                            ;; 00:10a7 $23
    ld   D, [HL]                                       ;; 00:10a8 $56
    dec  DE                                            ;; 00:10a9 $1b
    ld   A, [DE]                                       ;; 00:10aa $1a
    ld   [HL], D                                       ;; 00:10ab $72
    dec  HL                                            ;; 00:10ac $2b
    ld   [HL], E                                       ;; 00:10ad $73
    ld   [wD59C_CurrentROMBank], A                                    ;; 00:10ae $ea $9c $d5
    ld   [MBC1RomBank], A                                    ;; 00:10b1 $ea $01 $20
    swap A                                             ;; 00:10b4 $cb $37
    rrca                                               ;; 00:10b6 $0f
    and  A, $01                                        ;; 00:10b7 $e6 $01
    ld   [MBC1SRamBank], A                                    ;; 00:10b9 $ea $01 $40
    ret                                                ;; 00:10bc $c9

call_00_10bd_CallFuncInHL:
    jp   HL                                            ;; 00:10bd $e9

call_00_10be_UpdateCurrentInputs:
    ld   C, $00                                        ;; 00:10be $0e $00
    ld   A, $20                                        ;; 00:10c0 $3e $20
    ldh  [C], A                                        ;; 00:10c2 $e2
    ldh  A, [C]                                        ;; 00:10c3 $f2
    ldh  A, [C]                                        ;; 00:10c4 $f2
    ldh  A, [C]                                        ;; 00:10c5 $f2
    ld   B, A                                          ;; 00:10c6 $47
    ld   A, $10                                        ;; 00:10c7 $3e $10
    ldh  [C], A                                        ;; 00:10c9 $e2
    ld   A, B                                          ;; 00:10ca $78
    and  A, $0f                                        ;; 00:10cb $e6 $0f
    swap A                                             ;; 00:10cd $cb $37
    ld   B, A                                          ;; 00:10cf $47
    ldh  A, [C]                                        ;; 00:10d0 $f2
    ldh  A, [C]                                        ;; 00:10d1 $f2
    ldh  A, [C]                                        ;; 00:10d2 $f2
    ldh  A, [C]                                        ;; 00:10d3 $f2
    ldh  A, [C]                                        ;; 00:10d4 $f2
    ldh  A, [C]                                        ;; 00:10d5 $f2
    ldh  A, [C]                                        ;; 00:10d6 $f2
    ldh  A, [C]                                        ;; 00:10d7 $f2
    ldh  A, [C]                                        ;; 00:10d8 $f2
    ldh  A, [C]                                        ;; 00:10d9 $f2
    ldh  A, [C]                                        ;; 00:10da $f2
    ldh  A, [C]                                        ;; 00:10db $f2
    ldh  A, [C]                                        ;; 00:10dc $f2
    ldh  A, [C]                                        ;; 00:10dd $f2
    and  A, $0f                                        ;; 00:10de $e6 $0f
    or   A, B                                          ;; 00:10e0 $b0
    cpl                                                ;; 00:10e1 $2f
    ld   B, A                                          ;; 00:10e2 $47
    ld   A, $30                                        ;; 00:10e3 $3e $30
    ldh  [C], A                                        ;; 00:10e5 $e2
    ld   A, B                                          ;; 00:10e6 $78
    ld   [wD59F_CurrentInputs], A                                    ;; 00:10e7 $ea $9f $d5
    ret                                                ;; 00:10ea $c9

call_00_10eb:
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:10eb $cd $b4 $0a
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:10ee $fa $9f $d5
    and  A, A                                          ;; 00:10f1 $a7
    jr   NZ, call_00_10eb                              ;; 00:10f2 $20 $f7
    ret                                                ;; 00:10f4 $c9

call_00_10f5_PressingLeft:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:10f5 $fa $9f $d5
    and  A, Input_Left                                        ;; 00:10f8 $e6 $20
    ret                                                ;; 00:10fa $c9

call_00_10fb_PressingRight:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:10fb $fa $9f $d5
    and  A, Input_Right                                        ;; 00:10fe $e6 $10
    ret                                                ;; 00:1100 $c9

call_00_1101_PressingUp:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1101 $fa $9f $d5
    and  A, Input_Up                                        ;; 00:1104 $e6 $40
    ret                                                ;; 00:1106 $c9

call_00_1107_PressingDown:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1107 $fa $9f $d5
    and  A, Input_Down                                        ;; 00:110a $e6 $80
    ret                                                ;; 00:110c $c9

call_00_110d_PressingStart:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:110d $fa $9f $d5
    cp   A, Input_Start                                        ;; 00:1110 $fe $08
    jr   Z, .jr_00_1116                                ;; 00:1112 $28 $02
    xor  A, A                                          ;; 00:1114 $af
    ret                                                ;; 00:1115 $c9
.jr_00_1116:
    and  A, A                                          ;; 00:1116 $a7
    ret                                                ;; 00:1117 $c9

call_00_1118_PressingSelect:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1118 $fa $9f $d5
    cp   A, Input_Select                                        ;; 00:111b $fe $04
    jr   Z, .jr_00_1121                                ;; 00:111d $28 $02
    xor  A, A                                          ;; 00:111f $af
    ret                                                ;; 00:1120 $c9
.jr_00_1121:
    and  A, A                                          ;; 00:1121 $a7
    ret                                                ;; 00:1122 $c9

call_00_1123_PressingA:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1123 $fa $9f $d5
    and  A, Input_A                                        ;; 00:1126 $e6 $01
    ret                                                ;; 00:1128 $c9

call_00_1129_PressingB:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1129 $fa $9f $d5
    and  A, Input_B                                        ;; 00:112c $e6 $02
    ret                                                ;; 00:112e $c9

call_00_112f:
    ld   HL, wD789                                     ;; 00:112f $21 $89 $d7
    ld   A, [HL]                                       ;; 00:1132 $7e
    cp   A, $ff                                        ;; 00:1133 $fe $ff
    ret  NZ                                            ;; 00:1135 $c0
    ld   [HL], C                                       ;; 00:1136 $71
    ret                                                ;; 00:1137 $c9

call_00_1138:
    ld   A, [wD789]                                    ;; 00:1138 $fa $89 $d7
    cp   A, $ff                                        ;; 00:113b $fe $ff
    ret  Z                                             ;; 00:113d $c8

call_00_113e:
    ld   L, A                                          ;; 00:113e $6f
    ld   H, $00                                        ;; 00:113f $26 $00
    add  HL, HL                                        ;; 00:1141 $29
    ld   DE, .data_00_116c                                     ;; 00:1142 $11 $6c $11
    add  HL, DE                                        ;; 00:1145 $19
    push HL                                            ;; 00:1146 $e5
    ld   A, [wD788_CurrentAudioBank]                                    ;; 00:1147 $fa $88 $d7
    call call_00_1089_SwitchBank                                  ;; 00:114a $cd $89 $10
    pop  HL                                            ;; 00:114d $e1
    ld   C, [HL]                                       ;; 00:114e $4e
    inc  HL                                            ;; 00:114f $23
    ld   A, [HL]                                       ;; 00:1150 $7e
    ld   B, $04                                        ;; 00:1151 $06 $04
.jr_00_1153:
    bit  0, C                                          ;; 00:1153 $cb $41
    jr   Z, .jr_00_115f                                ;; 00:1155 $28 $08
    push AF                                            ;; 00:1157 $f5
    push BC                                            ;; 00:1158 $c5
    call call_22_4047                                  ;; 00:1159 $cd $47 $40
    pop  BC                                            ;; 00:115c $c1
    pop  AF                                            ;; 00:115d $f1
    inc  A                                             ;; 00:115e $3c
.jr_00_115f:
    rrc  C                                             ;; 00:115f $cb $09
    dec  B                                             ;; 00:1161 $05
    jr   NZ, .jr_00_1153                               ;; 00:1162 $20 $ef
    ld   A, $ff                                        ;; 00:1164 $3e $ff
    ld   [wD789], A                                    ;; 00:1166 $ea $89 $d7
    jp   call_00_10a3_SwitchBank2                                  ;; 00:1169 $c3 $a3 $10
.data_00_116c:
    db   $01, $00, $01, $01, $01, $02, $01, $03        ;; 00:116c ....????
    db   $01, $04, $01, $05, $01, $06, $01, $07        ;; 00:1174 ????..??
    db   $01, $08, $01, $09, $01, $0a, $01, $0b        ;; 00:117c ????????
    db   $01, $0c, $01, $0d, $01, $0e, $01, $0f        ;; 00:1184 ........
    db   $01, $10, $01, $11, $01, $12, $01, $13        ;; 00:118c ??..????
    db   $01, $14, $01, $15, $01, $16, $01, $17        ;; 00:1194 ??????..
    db   $01, $18, $01, $19, $01, $1a, $01, $1b        ;; 00:119c ??....??
    db   $01, $1d, $01, $1e, $01, $1f, $01, $20        ;; 00:11a4 ..??????
    db   $01, $21, $01, $22, $01, $23, $01, $24        ;; 00:11ac ????????
    db   $01, $26, $01, $27, $01, $29, $01, $2a        ;; 00:11b4 ..??????
    db   $01, $2b, $01, $2c, $01, $2d, $01, $2e        ;; 00:11bc ????????
    db   $01, $2f, $01, $30, $01, $31, $01, $33        ;; 00:11c4 ????????
    db   $01, $34, $01, $35, $01, $36, $01, $37        ;; 00:11cc ????????
    db   $01, $38, $01, $39, $01, $3a, $01, $3b        ;; 00:11d4 ????????
    db   $01, $3c, $01, $3d                            ;; 00:11dc ????

call_00_11e0_SetupMusicForLevel:
    ld   HL, wD624_CurrentLevelId                                     ;; 00:11e0 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:11e3 $6e
    ld   H, $00                                        ;; 00:11e4 $26 $00
    ld   DE, .data_00_11ed_LevelSongs                                     ;; 00:11e6 $11 $ed $11
    add  HL, DE                                        ;; 00:11e9 $19
    ld   A, [HL]                                       ;; 00:11ea $7e
    jr   call_00_120c_SetupMusic                                  ;; 00:11eb $18 $1f
.data_00_11ed_LevelSongs:
; this determines which song to use for each level
    db   Music_MediaDimension, Music_ToonTV, Music_ScreamTV, Music_ScreamTV
    db   Music_CircuitCentral, Music_KungFuTheater, Music_MediaDimension, Music_PrehistoryChannel        ;; 00:11ed www?????
    db   Music_ToonTV, Music_PrehistoryChannel, Music_CircuitCentral, Music_ScreamTV
    db   Music_MediaDimension, Music_KungFuTheater, Music_Rezopolis, Music_MediaDimension        ;; 00:11f5 ????????
    db   Music_ScreamTV, Music_MediaDimension, Music_MediaDimension, Music_MediaDimension
    db   Music_MediaDimension, Music_KungFuTheater, Music_Rezopolis, Music_CircuitCentral        ;; 00:11fd ????????
    db   Music_PrehistoryChannel, Music_ScreamTV, Music_Rezopolis, Music_MediaDimension
    db   Music_MediaDimension, Music_MediaDimension, Music_Rezopolis             ;; 00:1205 ???????

call_00_120c_SetupMusic:
    push AF                                            ;; 00:120c $f5
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:120d $cd $b4 $0a
    pop  AF                                            ;; 00:1210 $f1
    ld   HL, wD78A_MusicId                                     ;; 00:1211 $21 $8a $d7
    cp   A, [HL]                                       ;; 00:1214 $be
    ret  Z                                             ;; 00:1215 $c8
    ld   [HL], A                                       ;; 00:1216 $77
    ld   L, A                                          ;; 00:1217 $6f
    ld   H, $00                                        ;; 00:1218 $26 $00
    add  HL, HL                                        ;; 00:121a $29
    add  HL, HL                                        ;; 00:121b $29
    ld   DE, .data_00_1244_MusicList                                     ;; 00:121c $11 $44 $12
    add  HL, DE                                        ;; 00:121f $19
    ld   A, [HL+]                                      ;; 00:1220 $2a
    ld   [wD788_CurrentAudioBank], A                                    ;; 00:1221 $ea $88 $d7
    push HL                                            ;; 00:1224 $e5
    call call_00_1089_SwitchBank                                  ;; 00:1225 $cd $89 $10
    pop  HL                                            ;; 00:1228 $e1
    ld   A, [HL+]                                      ;; 00:1229 $2a
    ld   C, [HL]                                       ;; 00:122a $4e
    ld   B, $04                                        ;; 00:122b $06 $04
.jr_00_122d:
    push AF                                            ;; 00:122d $f5
    push BC                                            ;; 00:122e $c5
    bit  0, C                                          ;; 00:122f $cb $41
    call NZ, call_22_4092                              ;; 00:1231 $c4 $92 $40
    pop  BC                                            ;; 00:1234 $c1
    pop  AF                                            ;; 00:1235 $f1
    inc  A                                             ;; 00:1236 $3c
    rrc  C                                             ;; 00:1237 $cb $09
    dec  B                                             ;; 00:1239 $05
    jr   NZ, .jr_00_122d                               ;; 00:123a $20 $f1
    call call_00_10a3_SwitchBank2                                  ;; 00:123c $cd $a3 $10
    ld   A, $00                                        ;; 00:123f $3e $00
    jp   call_00_113e                                  ;; 00:1241 $c3 $3e $11
.data_00_1244_MusicList:
; this is the list of songs (first byte is bank number)
    db   Bank21, $04, $0f, $00
    db   Bank21, $00, $0f, $00        ;; 00:1244 ????????
    db   Bank21, $08, $0f, $00
    db   Bank22, $08, $0f, $00        ;; 00:124c ????????
    db   Bank22, $04, $0f, $00
    db   Bank22, $00, $0f, $00        ;; 00:1254 ????...?
    db   Bank23, $04, $0f, $00
    db   Bank23, $00, $0f, $00        ;; 00:125c ...?...?

call_00_1264_LoadMap:
    call call_00_0ede                                  ;; 00:1264 $cd $de $0e
    call call_00_2eb0_GetCurrentMapBankNumber                                  ;; 00:1267 $cd $77 $2e
    ld   [wD6F5_CurrentMapBank], A                                    ;; 00:126a $ea $f5 $d6
    call call_00_2eb0_GetCurrentSpecialTileBank                                  ;; 00:126d $cd $80 $2e
    ld   [wD6F6_CurrentMapSpecialTileBank], A                                    ;; 00:1270 $ea $f6 $d6
    call call_00_2eb0_GetCurrentBlocksetBank                                  ;; 00:1273 $cd $89 $2e
    ld   [wD6F7_CurrentBlocksetAndCollisionBank], A                                    ;; 00:1276 $ea $f7 $d6
    call call_00_2e93                                  ;; 00:1279 $cd $93 $2e
    ld   [wD6FE_LevelTileOverrideBit], A                                    ;; 00:127c $ea $fe $d6
    call call_00_2eb0_GetCurrentBgTilesetBank                                  ;; 00:127f $cd $9c $2e
    ld   [wD6FF_CurrentBgTilesetBank], A                                    ;; 00:1282 $ea $ff $d6
    call call_00_2ea5                                  ;; 00:1285 $cd $a5 $2e
    ld   HL, wD700                                     ;; 00:1288 $21 $00 $d7
    ld   [HL], E                                       ;; 00:128b $73
    inc  HL                                            ;; 00:128c $23
    ld   [HL], D                                       ;; 00:128d $72
    call call_00_0f38                                  ;; 00:128e $cd $38 $0f
    call call_00_1419_WriteTilesToVRAM                                  ;; 00:1291 $cd $19 $14
    ld   A, $ff                                        ;; 00:1294 $3e $ff
    ld   [wD72D_CurrentSpecialTilesetIndex], A                                    ;; 00:1296 $ea $2d $d7
    xor  A, A                                          ;; 00:1299 $af
    ld   [wD77B], A                                    ;; 00:129a $ea $7b $d7
    ld   [wD77D], A                                    ;; 00:129d $ea $7d $d7
    ld   A, $16                                        ;; 00:12a0 $3e $16
.jr_00_12a2:
    push AF                                            ;; 00:12a2 $f5
    ld   A, $01                                        ;; 00:12a3 $3e $01
    ld   [wD6F9], A                                    ;; 00:12a5 $ea $f9 $d6
    call call_00_1455                                  ;; 00:12a8 $cd $55 $14
    ld   [wD59D_ReturnBank], A                                    ;; 00:12ab $ea $9d $d5
    ld   A, Bank03                                        ;; 00:12ae $3e $03
    ld   HL, entry_03_6f5e_WriteVRAMBgMap                                     ;; 00:12b0 $21 $5e $6f
    call call_00_1078_CallAltBankFunc                                  ;; 00:12b3 $cd $78 $10
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:12b6 $21 $ef $d6
    ld   A, [HL]                                       ;; 00:12b9 $7e
    add  A, $08                                        ;; 00:12ba $c6 $08
    ld   [HL], A                                       ;; 00:12bc $77
    inc  HL                                            ;; 00:12bd $23
    ld   A, [HL]                                       ;; 00:12be $7e
    adc  A, $00                                        ;; 00:12bf $ce $00
    ld   [HL], A                                       ;; 00:12c1 $77
    pop  AF                                            ;; 00:12c2 $f1
    dec  A                                             ;; 00:12c3 $3d
    jr   NZ, .jr_00_12a2                               ;; 00:12c4 $20 $dc
    ld   [wD6F9], A                                    ;; 00:12c6 $ea $f9 $d6
    ld   [wD59D_ReturnBank], A                                    ;; 00:12c9 $ea $9d $d5
    ld   A, Bank03                                        ;; 00:12cc $3e $03
    ld   HL, entry_03_66ae                                     ;; 00:12ce $21 $ae $66
    call call_00_1078_CallAltBankFunc                                  ;; 00:12d1 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:12d4 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:12d7 $3e $02
    ld   HL, entry_02_715a                                     ;; 00:12d9 $21 $5a $71
    call call_00_1078_CallAltBankFunc                                  ;; 00:12dc $cd $78 $10
    xor  A, A                                          ;; 00:12df $af
    ld   [wD6F9], A                                    ;; 00:12e0 $ea $f9 $d6
    ret                                                ;; 00:12e3 $c9

call_00_12e4:
    ld   HL, wD78B                                     ;; 00:12e4 $21 $8b $d7
    ld   B, $10                                        ;; 00:12e7 $06 $10
    xor  A, A                                          ;; 00:12e9 $af
.jr_00_12ea:
    ld   [HL+], A                                      ;; 00:12ea $22
    dec  B                                             ;; 00:12eb $05
    jr   NZ, .jr_00_12ea                               ;; 00:12ec $20 $fc
    ld   [wD778], A                                    ;; 00:12ee $ea $78 $d7
    ld   HL, wD624_CurrentLevelId                                     ;; 00:12f1 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:12f4 $6e
    ld   H, $00                                        ;; 00:12f5 $26 $00
    ld   DE, .data_00_1356                                     ;; 00:12f7 $11 $56 $13
    add  HL, DE                                        ;; 00:12fa $19
    ld   A, [HL]                                       ;; 00:12fb $7e
    ld   HL, wD798                                     ;; 00:12fc $21 $98 $d7
    ld   B, $03                                        ;; 00:12ff $06 $03
.jr_00_1301:
    rrca                                               ;; 00:1301 $0f
    rl   [HL]                                          ;; 00:1302 $cb $16
    inc  HL                                            ;; 00:1304 $23
    dec  B                                             ;; 00:1305 $05
    jr   NZ, .jr_00_1301                               ;; 00:1306 $20 $f9
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:1308 $fa $24 $d6
    and  A, A                                          ;; 00:130b $a7
    ret  NZ                                            ;; 00:130c $c0
    ld   HL, .data_00_1375                                     ;; 00:130d $21 $75 $13
.jr_00_1310:
    ld   A, [HL]                                       ;; 00:1310 $7e
    cp   A, $ff                                        ;; 00:1311 $fe $ff
    ret  Z                                             ;; 00:1313 $c8
    push HL                                            ;; 00:1314 $e5
    ld   A, [wD64F]                                    ;; 00:1315 $fa $4f $d6
    and  A, $7f                                        ;; 00:1318 $e6 $7f
    cp   A, [HL]                                       ;; 00:131a $be
    jr   C, .jr_00_134f                                ;; 00:131b $38 $32
    jr   NZ, .jr_00_1332                               ;; 00:131d $20 $13
    ld   A, [wD64F]                                    ;; 00:131f $fa $4f $d6
    bit  7, A                                          ;; 00:1322 $cb $7f
    jr   Z, .jr_00_1332                                ;; 00:1324 $28 $0c
    inc  HL                                            ;; 00:1326 $23
    ld   L, [HL]                                       ;; 00:1327 $6e
    ld   H, $00                                        ;; 00:1328 $26 $00
    ld   DE, wD78B                                     ;; 00:132a $11 $8b $d7
    add  HL, DE                                        ;; 00:132d $19
    ld   [HL], $02                                     ;; 00:132e $36 $02
    jr   .jr_00_134f                                   ;; 00:1330 $18 $1d
.jr_00_1332:
    inc  HL                                            ;; 00:1332 $23
    inc  HL                                            ;; 00:1333 $23
    ld   A, [HL+]                                      ;; 00:1334 $2a
    ld   [wD782], A                                    ;; 00:1335 $ea $82 $d7
    ld   A, [HL+]                                      ;; 00:1338 $2a
    ld   [wD783], A                                    ;; 00:1339 $ea $83 $d7
    ld   A, L                                          ;; 00:133c $7d
    ld   [wD780], A                                    ;; 00:133d $ea $80 $d7
    ld   A, H                                          ;; 00:1340 $7c
    ld   [wD781], A                                    ;; 00:1341 $ea $81 $d7
    ld   A, $02                                        ;; 00:1344 $3e $02
    ld   [wD784], A                                    ;; 00:1346 $ea $84 $d7
    ld   [wD785], A                                    ;; 00:1349 $ea $85 $d7
    call call_00_1ec9_UpdateBgTileFlags                                  ;; 00:134c $cd $c9 $1e
.jr_00_134f:
    pop  HL                                            ;; 00:134f $e1
    ld   DE, $0c                                       ;; 00:1350 $11 $0c $00
    add  HL, DE                                        ;; 00:1353 $19
    jr   .jr_00_1310                                   ;; 00:1354 $18 $ba
.data_00_1356:
    db   $00, $01, $05, $07, $03, $03, $00, $03        ;; 00:1356 ...?????
    db   $03, $07, $07, $03, $00, $07, $01, $00        ;; 00:135e ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:1366 ????????
    db   $01, $01, $03, $00, $00, $00, $00
.data_00_1375:
    db   $06        ;; 00:136e ???????.
    db   $00, $25, $0d, $7c, $01, $7d, $01, $8c        ;; 00:1376 ????????
    db   $01, $8d, $01, $09, $01, $1b, $16, $78        ;; 00:137e ???.????
    db   $01, $79, $01, $88, $01, $89, $01, $12        ;; 00:1386 ???????.
    db   $02, $2f, $16, $5c, $01, $5d, $01, $6c        ;; 00:138e ????????
    db   $01, $6d, $01, $0d, $03, $43, $16, $58        ;; 00:1396 ???.????
    db   $01, $59, $01, $68, $01, $69, $01, $ff        ;; 00:139e ???????.

call_00_13a6:
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:13a6 $21 $0e $d2
    ld   A, [HL+]                                      ;; 00:13a9 $2a
    sub  A, $50                                        ;; 00:13aa $d6 $50
    ld   E, A                                          ;; 00:13ac $5f
    ld   A, [HL]                                       ;; 00:13ad $7e
    sbc  A, $00                                        ;; 00:13ae $de $00
    ld   D, A                                          ;; 00:13b0 $57
    jr   C, .jr_00_13c8                                ;; 00:13b1 $38 $15
    ld   A, E                                          ;; 00:13b3 $7b
    sub  A, $20                                        ;; 00:13b4 $d6 $20
    ld   A, D                                          ;; 00:13b6 $7a
    sbc  A, $00                                        ;; 00:13b7 $de $00
    jr   C, .jr_00_13c8                                ;; 00:13b9 $38 $0d
    ld   A, E                                          ;; 00:13bb $7b
    sub  A, $40                                        ;; 00:13bc $d6 $40
    ld   A, D                                          ;; 00:13be $7a
    sbc  A, $0f                                        ;; 00:13bf $de $0f
    jr   C, .jr_00_13cb                                ;; 00:13c1 $38 $08
    ld   DE, $f40                                      ;; 00:13c3 $11 $40 $0f
    jr   .jr_00_13cb                                   ;; 00:13c6 $18 $03
.jr_00_13c8:
    ld   DE, $20                                       ;; 00:13c8 $11 $20 $00
.jr_00_13cb:
    ld   HL, wD6ED_XPositionInMap                                     ;; 00:13cb $21 $ed $d6
    ld   [HL], E                                       ;; 00:13ce $73
    inc  HL                                            ;; 00:13cf $23
    ld   [HL], D                                       ;; 00:13d0 $72
    ld   L, E                                          ;; 00:13d1 $6b
    ld   H, D                                          ;; 00:13d2 $62
    add  HL, HL                                        ;; 00:13d3 $29
    add  HL, HL                                        ;; 00:13d4 $29
    add  HL, HL                                        ;; 00:13d5 $29
    ld   A, H                                          ;; 00:13d6 $7c
    ld   [wD329], A                                    ;; 00:13d7 $ea $29 $d3
    add  A, $05                                        ;; 00:13da $c6 $05
    ld   [wD32A], A                                    ;; 00:13dc $ea $2a $d3
    ld   HL, wD210_PlayerYPosition                                     ;; 00:13df $21 $10 $d2
    ld   A, [HL+]                                      ;; 00:13e2 $2a
    sub  A, $48                                        ;; 00:13e3 $d6 $48
    ld   E, A                                          ;; 00:13e5 $5f
    ld   A, [HL]                                       ;; 00:13e6 $7e
    sbc  A, $00                                        ;; 00:13e7 $de $00
    ld   D, A                                          ;; 00:13e9 $57
    jr   C, .jr_00_1401                                ;; 00:13ea $38 $15
    ld   A, E                                          ;; 00:13ec $7b
    sub  A, $20                                        ;; 00:13ed $d6 $20
    ld   A, D                                          ;; 00:13ef $7a
    sbc  A, $00                                        ;; 00:13f0 $de $00
    jr   C, .jr_00_1401                                ;; 00:13f2 $38 $0d
    ld   A, E                                          ;; 00:13f4 $7b
    sub  A, $50                                        ;; 00:13f5 $d6 $50
    ld   A, D                                          ;; 00:13f7 $7a
    sbc  A, $0f                                        ;; 00:13f8 $de $0f
    jr   C, .jr_00_1404                                ;; 00:13fa $38 $08
    ld   DE, $f50                                      ;; 00:13fc $11 $50 $0f
    jr   .jr_00_1404                                   ;; 00:13ff $18 $03
.jr_00_1401:
    ld   DE, $20                                       ;; 00:1401 $11 $20 $00
.jr_00_1404:
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:1404 $21 $ef $d6
    ld   [HL], E                                       ;; 00:1407 $73
    inc  HL                                            ;; 00:1408 $23
    ld   [HL], D                                       ;; 00:1409 $72
    ld   L, E                                          ;; 00:140a $6b
    ld   H, D                                          ;; 00:140b $62
    add  HL, HL                                        ;; 00:140c $29
    add  HL, HL                                        ;; 00:140d $29
    add  HL, HL                                        ;; 00:140e $29
    ld   A, H                                          ;; 00:140f $7c
    ld   [wD32B], A                                    ;; 00:1410 $ea $2b $d3
    add  A, $05                                        ;; 00:1413 $c6 $05
    ld   [wD32C], A                                    ;; 00:1415 $ea $2c $d3
    ret                                                ;; 00:1418 $c9

call_00_1419_WriteTilesToVRAM: ; this function writes to the tiles part of vram (8000-9800)
    ld   A, [wD6FF_CurrentBgTilesetBank]                                    ;; 00:1419 $fa $ff $d6
    call call_00_1089_SwitchBank                                  ;; 00:141c $cd $89 $10
    ld   HL, wD700                                     ;; 00:141f $21 $00 $d7
    ld   A, [HL+]                                      ;; 00:1422 $2a
    ld   H, [HL]                                       ;; 00:1423 $66
    ld   L, A                                          ;; 00:1424 $6f
    ld   DE, $9000                                     ;; 00:1425 $11 $00 $90
.jr_00_1428:
    ld   A, [HL+]                                      ;; 00:1428 $2a
    ld   [DE], A                                       ;; 00:1429 $12
    inc  DE                                            ;; 00:142a $13
    ld   A, D                                          ;; 00:142b $7a
    cp   A, $98                                        ;; 00:142c $fe $98
    jr   NZ, .jr_00_1428                               ;; 00:142e $20 $f8
    ld   DE, $8800                                     ;; 00:1430 $11 $00 $88
.jr_00_1433:
    ld   A, [HL+]                                      ;; 00:1433 $2a
    ld   [DE], A                                       ;; 00:1434 $12
    inc  DE                                            ;; 00:1435 $13
    ld   A, D                                          ;; 00:1436 $7a
    cp   A, $90                                        ;; 00:1437 $fe $90
    jr   NZ, .jr_00_1433                               ;; 00:1439 $20 $f8
    ;; at this point the tiles have been written
    call call_00_10a3_SwitchBank2                                  ;; 00:143b $cd $a3 $10 
    ld   [wD59D_ReturnBank], A                                    ;; 00:143e $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:1441 $3e $0b
    ld   HL, entry_0b_641e                                     ;; 00:1443 $21 $1e $64
    call call_00_1078_CallAltBankFunc                                  ;; 00:1446 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:1449 $ea $9d $d5
    ld   A, Bank03                                        ;; 00:144c $3e $03
    ld   HL, entry_03_723c_SetupMovingTiles                                     ;; 00:144e $21 $3c $72
    call call_00_1078_CallAltBankFunc                                  ;; 00:1451 $cd $78 $10
    ret                                                ;; 00:1454 $c9

call_00_1455:
    ld   HL, wD6F9                                     ;; 00:1455 $21 $f9 $d6
    bit  7, [HL]                                       ;; 00:1458 $cb $7e
    jr   NZ, call_00_1455                              ;; 00:145a $20 $f9
    ld   A, [wD6F9]                                    ;; 00:145c $fa $f9 $d6
    and  A, $03                                        ;; 00:145f $e6 $03
    call NZ, call_00_1472                              ;; 00:1461 $c4 $72 $14
    ld   A, [wD6F9]                                    ;; 00:1464 $fa $f9 $d6
    and  A, $0c                                        ;; 00:1467 $e6 $0c
    call NZ, call_00_157a                              ;; 00:1469 $c4 $7a $15
    ld   HL, wD6F9                                     ;; 00:146c $21 $f9 $d6
    set  7, [HL]                                       ;; 00:146f $cb $fe
    ret                                                ;; 00:1471 $c9

call_00_1472:
; load bg map tiles (vertical camera movement)
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:1472 $21 $ef $d6
    ld   A, [HL+]                                      ;; 00:1475 $2a
    ld   C, A                                          ;; 00:1476 $4f
    ld   A, [HL+]                                      ;; 00:1477 $2a
    ld   B, A                                          ;; 00:1478 $47 ; after this point BC is equal to [wD6EF_YPositionInMap]
    ld   HL, $90                                       ;; 00:1479 $21 $90 $00 ; HL = $90
    ld   A, [wD6F9]                                    ;; 00:147c $fa $f9 $d6
    and  A, $02                                        ;; 00:147f $e6 $02
    jr   NZ, .jr_00_1486                               ;; 00:1481 $20 $03
    ld   HL, $ffff                                       ;; 00:1483 $21 $ff $ff (FFFF is -1 basically)
.jr_00_1486:
    add  HL, BC                                        ;; 00:1486 $09 ; HL = HL - 1
    ld   C, L                                          ;; 00:1487 $4d ; bc = hl
    ld   B, H                                          ;; 00:1488 $44 ; bc = hl
    ld   HL, wD6ED_XPositionInMap                      ;; 00:1489 $21 $ed $d6
    ld   A, [HL+]                                      ;; 00:148c $2a
    ld   E, A                                          ;; 00:148d $5f
    ld   A, [HL+]                                      ;; 00:148e $2a
    ld   D, A                                          ;; 00:148f $57 ; after this point DE is equal to [wD6ED_XPositionInMap], BC is [wD6EF_YPositionInMap]
    ld   L, C                                          ;; 00:1490 $69
    ld   H, B                                          ;; 00:1491 $60 ; HL = [wD6EF_YPositionInMap]
    add  HL, HL                                        ;; 00:1492 $29
    add  HL, HL                                        ;; 00:1493 $29
    add  HL, HL                                        ;; 00:1494 $29 ; HL = 8 * HL
    ld   A, H                                          ;; 00:1495 $7c
    ld   [wD77A_PlayerYPositionBlock], A                                    ;; 00:1496 $ea $7a $d7 ; [wD77A_PlayerYPositionBlock] = the upper byte of the 8x value
    ld   L, E                                          ;; 00:1499 $6b
    ld   H, D                                          ;; 00:149a $62 ; HL = [wD6ED_XPositionInMap]
    add  HL, HL                                        ;; 00:149b $29
    add  HL, HL                                        ;; 00:149c $29
    add  HL, HL                                        ;; 00:149d $29 ; HL = 8 * HL
    ld   A, H                                          ;; 00:149e $7c
    ld   [wD779_RelatedToXPosition], A                                    ;; 00:149f $ea $79 $d7 ; [wD779_RelatedToXPosition] = the upper byte of the 8x value
    ld   A, C                                          ;; 00:14a2 $79
    and  A, $f8                                        ;; 00:14a3 $e6 $f8
    ld   L, A                                          ;; 00:14a5 $6f
    ld   H, $00                                        ;; 00:14a6 $26 $00 ; after this, hl = C(lower byte of y pos) & 0xf8
    add  HL, HL                                        ;; 00:14a8 $29
    add  HL, HL                                        ;; 00:14a9 $29 ; HL = 4 * HL
    ld   A, E                                          ;; 00:14aa $7b ; a = lower byte of x pos
    rrca                                               ;; 00:14ab $0f
    rrca                                               ;; 00:14ac $0f
    rrca                                               ;; 00:14ad $0f ; rotate to check some bits in there
    and  A, $1c                                        ;; 00:14ae $e6 $1c 
    or   A, L                                          ;; 00:14b0 $b5
    ld   L, A                                          ;; 00:14b1 $6f
    push HL                                            ;; 00:14b2 $e5
    ld   [wD6FA], A                                    ;; 00:14b3 $ea $fa $d6
    ld   A, H                                          ;; 00:14b6 $7c
    ld   [wD6FB], A                                    ;; 00:14b7 $ea $fb $d6
    ld   A, C                                          ;; 00:14ba $79
    rrca                                               ;; 00:14bb $0f
    and  A, $0c                                        ;; 00:14bc $e6 $0c
    add  A, $40                                        ;; 00:14be $c6 $40
    push AF                                            ;; 00:14c0 $f5
    ld   L, C                                          ;; 00:14c1 $69
    ld   H, B                                          ;; 00:14c2 $60
    add  HL, HL                                        ;; 00:14c3 $29
    add  HL, HL                                        ;; 00:14c4 $29
    add  HL, HL                                        ;; 00:14c5 $29
    ld   A, H                                          ;; 00:14c6 $7c
    ld   L, E                                          ;; 00:14c7 $6b
    ld   H, D                                          ;; 00:14c8 $62
    add  HL, HL                                        ;; 00:14c9 $29
    add  HL, HL                                        ;; 00:14ca $29
    add  HL, HL                                        ;; 00:14cb $29
    add  HL, HL                                        ;; 00:14cc $29
    ld   L, H                                          ;; 00:14cd $6c
    srl  A                                             ;; 00:14ce $cb $3f
    rr   L                                             ;; 00:14d0 $cb $1d
    add  A, $40                                        ;; 00:14d2 $c6 $40
    ld   H, A                                          ;; 00:14d4 $67
    push HL                                            ;; 00:14d5 $e5
    push HL                                            ;; 00:14d6 $e5
    ld   A, [wD6F5_CurrentMapBank]                     ;; 00:14d7 $fa $f5 $d6
    call call_00_1089_SwitchBank                       ;; 00:14da $cd $89 $10 switch to map file bank
    pop  HL                                            ;; 00:14dd $e1
    ld   DE, wD702                                     ;; 00:14de $11 $02 $d7
    ld   A, [HL+]                                      ;; 00:14e1 $2a
    ld   [DE], A                                       ;; 00:14e2 $12
    inc  DE                                            ;; 00:14e3 $13
    inc  DE                                            ;; 00:14e4 $13
    ld   A, [HL+]                                      ;; 00:14e5 $2a
    ld   [DE], A                                       ;; 00:14e6 $12
    inc  DE                                            ;; 00:14e7 $13
    inc  DE                                            ;; 00:14e8 $13
    ld   A, [HL+]                                      ;; 00:14e9 $2a
    ld   [DE], A                                       ;; 00:14ea $12
    inc  DE                                            ;; 00:14eb $13
    inc  DE                                            ;; 00:14ec $13
    ld   A, [HL+]                                      ;; 00:14ed $2a
    ld   [DE], A                                       ;; 00:14ee $12
    inc  DE                                            ;; 00:14ef $13
    inc  DE                                            ;; 00:14f0 $13
    ld   A, [HL+]                                      ;; 00:14f1 $2a
    ld   [DE], A                                       ;; 00:14f2 $12
    inc  DE                                            ;; 00:14f3 $13
    inc  DE                                            ;; 00:14f4 $13
    ld   A, [HL+]                                      ;; 00:14f5 $2a
    ld   [DE], A                                       ;; 00:14f6 $12
    call call_00_10a3_SwitchBank2                                  ;; 00:14f7 $cd $a3 $10
    ld   A, [wD6F6_CurrentMapSpecialTileBank]                                    ;; 00:14fa $fa $f6 $d6
    call call_00_1089_SwitchBank                       ;; 00:14fd $cd $89 $10 switch to map data file 34/35
    pop  HL                                            ;; 00:1500 $e1 hl = 44b4
    ld   DE, wD703                                     ;; 00:1501 $11 $03 $d7 de = d703
    ld   A, [HL+]                                      ;; 00:1504 $2a a = 0, hl++
    ld   [DE], A                                       ;; 00:1505 $12 [wD703] = a (which is 0)
    inc  DE                                            ;; 00:1506 $13
    inc  DE                                            ;; 00:1507 $13 de = D705
    ld   A, [HL+]                                      ;; 00:1508 $2a a = [hl (44b5)]  AND hl++ (44B6 now)
    ld   [DE], A                                       ;; 00:1509 $12 [wD705] = a (which is 0)
    inc  DE                                            ;; 00:150a $13
    inc  DE                                            ;; 00:150b $13 de = D707
    ld   A, [HL+]                                      ;; 00:150c $2a
    ld   [DE], A                                       ;; 00:150d $12
    inc  DE                                            ;; 00:150e $13
    inc  DE                                            ;; 00:150f $13 de = D709
    ld   A, [HL+]                                      ;; 00:1510 $2a
    ld   [DE], A                                       ;; 00:1511 $12
    inc  DE                                            ;; 00:1512 $13
    inc  DE                                            ;; 00:1513 $13 de = D70B
    ld   A, [HL+]                                      ;; 00:1514 $2a
    ld   [DE], A                                       ;; 00:1515 $12
    inc  DE                                            ;; 00:1516 $13
    inc  DE                                            ;; 00:1517 $13 de = D70D
    ld   A, [HL+]                                      ;; 00:1518 $2a
    ld   [DE], A                                       ;; 00:1519 $12
    call call_00_10a3_SwitchBank2                                  ;; 00:151a $cd $a3 $10
    ld   HL, wD702                                     ;; 00:151d $21 $02 $d7
    call call_00_18a7                                  ;; 00:1520 $cd $a7 $18
    ld   A, [wD6F7_CurrentBlocksetAndCollisionBank]                                    ;; 00:1523 $fa $f7 $d6
    call call_00_1089_SwitchBank                       ;; 00:1526 $cd $89 $10
    pop  AF                                            ;; 00:1529 $f1
    pop  HL                                            ;; 00:152a $e1
    ld   B, A                                          ;; 00:152b $47
    ld   A, H                                          ;; 00:152c $7c
    add  A, $c0                                        ;; 00:152d $c6 $c0
    ld   H, A                                          ;; 00:152f $67
    ld   DE, wD702                                     ;; 00:1530 $11 $02 $d7
    ld   A, $06                                        ;; 00:1533 $3e $06
.jr_00_1535:
    push AF                                            ;; 00:1535 $f5
    ld   A, [DE]                                       ;; 00:1536 $1a
    ld   C, A                                          ;; 00:1537 $4f
    inc  DE                                            ;; 00:1538 $13
    res  4, B                                          ;; 00:1539 $cb $a0
    ld   A, [DE]                                       ;; 00:153b $1a ; loads 3435 data
    and  A, A                                          ;; 00:153c $a7
    jr   Z, .jr_00_1541                                ;; 00:153d $28 $02
    set  4, B                                          ;; 00:153f $cb $e0
.jr_00_1541:
    inc  DE                                            ;; 00:1541 $13
    ld   A, [BC]                                       ;; 00:1542 $0a
    ld   [HL], A                                       ;; 00:1543 $77
    set  3, H                                          ;; 00:1544 $cb $dc
    set  5, B                                          ;; 00:1546 $cb $e8
    ld   A, [BC]                                       ;; 00:1548 $0a
    ld   [HL+], A                                      ;; 00:1549 $22
    inc  B                                             ;; 00:154a $04
    ld   A, [BC]                                       ;; 00:154b $0a
    ld   [HL], A                                       ;; 00:154c $77
    res  3, H                                          ;; 00:154d $cb $9c
    res  5, B                                          ;; 00:154f $cb $a8
    ld   A, [BC]                                       ;; 00:1551 $0a
    ld   [HL+], A                                      ;; 00:1552 $22
    inc  B                                             ;; 00:1553 $04
    ld   A, [BC]                                       ;; 00:1554 $0a
    ld   [HL], A                                       ;; 00:1555 $77
    set  3, H                                          ;; 00:1556 $cb $dc
    set  5, B                                          ;; 00:1558 $cb $e8
    ld   A, [BC]                                       ;; 00:155a $0a
    ld   [HL+], A                                      ;; 00:155b $22
    inc  B                                             ;; 00:155c $04
    ld   A, [BC]                                       ;; 00:155d $0a
    ld   [HL], A                                       ;; 00:155e $77
    res  3, H                                          ;; 00:155f $cb $9c
    res  5, B                                          ;; 00:1561 $cb $a8
    ld   A, [BC]                                       ;; 00:1563 $0a
    ld   [HL+], A                                      ;; 00:1564 $22
    ld   A, L                                          ;; 00:1565 $7d
    and  A, $1f                                        ;; 00:1566 $e6 $1f
    jr   NZ, .jr_00_156f                               ;; 00:1568 $20 $05
    dec  HL                                            ;; 00:156a $2b
    ld   A, L                                          ;; 00:156b $7d
    and  A, $e0                                        ;; 00:156c $e6 $e0
    ld   L, A                                          ;; 00:156e $6f
.jr_00_156f:
    dec  B                                             ;; 00:156f $05
    dec  B                                             ;; 00:1570 $05
    dec  B                                             ;; 00:1571 $05
    pop  AF                                            ;; 00:1572 $f1
    dec  A                                             ;; 00:1573 $3d
    jr   NZ, .jr_00_1535                               ;; 00:1574 $20 $bf
    call call_00_10a3_SwitchBank2                                  ;; 00:1576 $cd $a3 $10
    ret                                                ;; 00:1579 $c9

call_00_157a:
; load bg map tiles (horizontal camera movement)
    ld   HL, wD6ED_XPositionInMap                                     ;; 00:157a $21 $ed $d6
    ld   A, [HL+]                                      ;; 00:157d $2a
    ld   E, A                                          ;; 00:157e $5f
    ld   A, [HL+]                                      ;; 00:157f $2a
    ld   D, A                                          ;; 00:1580 $57
    ld   HL, $a0                                       ;; 00:1581 $21 $a0 $00
    ld   A, [wD6F9]                                    ;; 00:1584 $fa $f9 $d6
    and  A, $08                                        ;; 00:1587 $e6 $08
    jr   NZ, .jr_00_158e                               ;; 00:1589 $20 $03
    ld   HL, rIE                                       ;; 00:158b $21 $ff $ff
.jr_00_158e:
    add  HL, DE                                        ;; 00:158e $19
    ld   E, L                                          ;; 00:158f $5d
    ld   D, H                                          ;; 00:1590 $54
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:1591 $21 $ef $d6
    ld   A, [HL+]                                      ;; 00:1594 $2a
    ld   C, A                                          ;; 00:1595 $4f
    ld   A, [HL+]                                      ;; 00:1596 $2a
    ld   B, A                                          ;; 00:1597 $47
    ld   L, C                                          ;; 00:1598 $69
    ld   H, B                                          ;; 00:1599 $60
    add  HL, HL                                        ;; 00:159a $29
    add  HL, HL                                        ;; 00:159b $29
    add  HL, HL                                        ;; 00:159c $29
    ld   A, H                                          ;; 00:159d $7c
    ld   [wD77A_PlayerYPositionBlock], A                                    ;; 00:159e $ea $7a $d7
    ld   L, E                                          ;; 00:15a1 $6b
    ld   H, D                                          ;; 00:15a2 $62
    add  HL, HL                                        ;; 00:15a3 $29
    add  HL, HL                                        ;; 00:15a4 $29
    add  HL, HL                                        ;; 00:15a5 $29
    ld   A, H                                          ;; 00:15a6 $7c
    ld   [wD779_RelatedToXPosition], A                                    ;; 00:15a7 $ea $79 $d7
    ld   A, C                                          ;; 00:15aa $79
    and  A, $e0                                        ;; 00:15ab $e6 $e0
    ld   L, A                                          ;; 00:15ad $6f
    ld   H, $00                                        ;; 00:15ae $26 $00
    add  HL, HL                                        ;; 00:15b0 $29
    add  HL, HL                                        ;; 00:15b1 $29
    ld   A, E                                          ;; 00:15b2 $7b
    rrca                                               ;; 00:15b3 $0f
    rrca                                               ;; 00:15b4 $0f
    rrca                                               ;; 00:15b5 $0f
    and  A, $1f                                        ;; 00:15b6 $e6 $1f
    or   A, L                                          ;; 00:15b8 $b5
    ld   L, A                                          ;; 00:15b9 $6f
    push HL                                            ;; 00:15ba $e5
    ld   [wD6FC], A                                    ;; 00:15bb $ea $fc $d6
    ld   A, H                                          ;; 00:15be $7c
    ld   [wD6FD], A                                    ;; 00:15bf $ea $fd $d6
    ld   A, E                                          ;; 00:15c2 $7b
    rrca                                               ;; 00:15c3 $0f
    rrca                                               ;; 00:15c4 $0f
    rrca                                               ;; 00:15c5 $0f
    and  A, $03                                        ;; 00:15c6 $e6 $03
    add  A, $40                                        ;; 00:15c8 $c6 $40
    push AF                                            ;; 00:15ca $f5
    ld   L, C                                          ;; 00:15cb $69
    ld   H, B                                          ;; 00:15cc $60
    add  HL, HL                                        ;; 00:15cd $29
    add  HL, HL                                        ;; 00:15ce $29
    add  HL, HL                                        ;; 00:15cf $29
    ld   A, H                                          ;; 00:15d0 $7c
    ld   L, E                                          ;; 00:15d1 $6b
    ld   H, D                                          ;; 00:15d2 $62
    add  HL, HL                                        ;; 00:15d3 $29
    add  HL, HL                                        ;; 00:15d4 $29
    add  HL, HL                                        ;; 00:15d5 $29
    add  HL, HL                                        ;; 00:15d6 $29
    ld   L, H                                          ;; 00:15d7 $6c
    srl  A                                             ;; 00:15d8 $cb $3f
    rr   L                                             ;; 00:15da $cb $1d
    add  A, $40                                        ;; 00:15dc $c6 $40
    ld   H, A                                          ;; 00:15de $67
    push HL                                            ;; 00:15df $e5
    push HL                                            ;; 00:15e0 $e5
    ld   A, [wD6F5_CurrentMapBank]                                    ;; 00:15e1 $fa $f5 $d6
    call call_00_1089_SwitchBank                                  ;; 00:15e4 $cd $89 $10
    pop  HL                                            ;; 00:15e7 $e1
    ld   DE, wD70E                                     ;; 00:15e8 $11 $0e $d7
    ld   BC, $80                                       ;; 00:15eb $01 $80 $00
    ld   A, [HL]                                       ;; 00:15ee $7e
    ld   [DE], A                                       ;; 00:15ef $12
    add  HL, BC                                        ;; 00:15f0 $09
    inc  DE                                            ;; 00:15f1 $13
    inc  DE                                            ;; 00:15f2 $13
    ld   A, [HL]                                       ;; 00:15f3 $7e
    ld   [DE], A                                       ;; 00:15f4 $12
    add  HL, BC                                        ;; 00:15f5 $09
    inc  DE                                            ;; 00:15f6 $13
    inc  DE                                            ;; 00:15f7 $13
    ld   A, [HL]                                       ;; 00:15f8 $7e
    ld   [DE], A                                       ;; 00:15f9 $12
    add  HL, BC                                        ;; 00:15fa $09
    inc  DE                                            ;; 00:15fb $13
    inc  DE                                            ;; 00:15fc $13
    ld   A, [HL]                                       ;; 00:15fd $7e
    ld   [DE], A                                       ;; 00:15fe $12
    add  HL, BC                                        ;; 00:15ff $09
    inc  DE                                            ;; 00:1600 $13
    inc  DE                                            ;; 00:1601 $13
    ld   A, [HL]                                       ;; 00:1602 $7e
    ld   [DE], A                                       ;; 00:1603 $12
    add  HL, BC                                        ;; 00:1604 $09
    inc  DE                                            ;; 00:1605 $13
    inc  DE                                            ;; 00:1606 $13
    ld   A, [HL]                                       ;; 00:1607 $7e
    ld   [DE], A                                       ;; 00:1608 $12
    call call_00_10a3_SwitchBank2                                  ;; 00:1609 $cd $a3 $10
    ld   A, [wD6F6_CurrentMapSpecialTileBank]                                    ;; 00:160c $fa $f6 $d6
    call call_00_1089_SwitchBank                                  ;; 00:160f $cd $89 $10
    pop  HL                                            ;; 00:1612 $e1
    ld   DE, wD70F                                     ;; 00:1613 $11 $0f $d7
    ld   BC, $80                                       ;; 00:1616 $01 $80 $00
    ld   A, [HL]                                       ;; 00:1619 $7e
    ld   [DE], A                                       ;; 00:161a $12
    add  HL, BC                                        ;; 00:161b $09
    inc  DE                                            ;; 00:161c $13
    inc  DE                                            ;; 00:161d $13
    ld   A, [HL]                                       ;; 00:161e $7e
    ld   [DE], A                                       ;; 00:161f $12
    add  HL, BC                                        ;; 00:1620 $09
    inc  DE                                            ;; 00:1621 $13
    inc  DE                                            ;; 00:1622 $13
    ld   A, [HL]                                       ;; 00:1623 $7e
    ld   [DE], A                                       ;; 00:1624 $12
    add  HL, BC                                        ;; 00:1625 $09
    inc  DE                                            ;; 00:1626 $13
    inc  DE                                            ;; 00:1627 $13
    ld   A, [HL]                                       ;; 00:1628 $7e
    ld   [DE], A                                       ;; 00:1629 $12
    add  HL, BC                                        ;; 00:162a $09
    inc  DE                                            ;; 00:162b $13
    inc  DE                                            ;; 00:162c $13
    ld   A, [HL]                                       ;; 00:162d $7e
    ld   [DE], A                                       ;; 00:162e $12
    add  HL, BC                                        ;; 00:162f $09
    inc  DE                                            ;; 00:1630 $13
    inc  DE                                            ;; 00:1631 $13
    ld   A, [HL]                                       ;; 00:1632 $7e
    ld   [DE], A                                       ;; 00:1633 $12
    call call_00_10a3_SwitchBank2                                  ;; 00:1634 $cd $a3 $10
    ld   HL, wD70E                                     ;; 00:1637 $21 $0e $d7
    call call_00_18e4                                  ;; 00:163a $cd $e4 $18
    ld   A, [wD6F7_CurrentBlocksetAndCollisionBank]                                    ;; 00:163d $fa $f7 $d6
    call call_00_1089_SwitchBank                                  ;; 00:1640 $cd $89 $10
    pop  AF                                            ;; 00:1643 $f1
    pop  HL                                            ;; 00:1644 $e1
    ld   B, A                                          ;; 00:1645 $47
    ld   A, H                                          ;; 00:1646 $7c
    add  A, $c0                                        ;; 00:1647 $c6 $c0
    ld   H, A                                          ;; 00:1649 $67
    ld   DE, wD70E                                     ;; 00:164a $11 $0e $d7
    ld   A, $06                                        ;; 00:164d $3e $06
.jr_00_164f:
    push AF                                            ;; 00:164f $f5
    ld   A, [DE]                                       ;; 00:1650 $1a
    ld   C, A                                          ;; 00:1651 $4f
    inc  DE                                            ;; 00:1652 $13
    res  4, B                                          ;; 00:1653 $cb $a0
    ld   A, [DE]                                       ;; 00:1655 $1a
    and  A, A                                          ;; 00:1656 $a7
    jr   Z, .jr_00_165b                                ;; 00:1657 $28 $02
    set  4, B                                          ;; 00:1659 $cb $e0
.jr_00_165b:
    inc  DE                                            ;; 00:165b $13
    push DE                                            ;; 00:165c $d5
    ld   DE, $20                                       ;; 00:165d $11 $20 $00
    ld   A, [BC]                                       ;; 00:1660 $0a
    ld   [HL], A                                       ;; 00:1661 $77
    set  3, H                                          ;; 00:1662 $cb $dc
    set  5, B                                          ;; 00:1664 $cb $e8
    ld   A, [BC]                                       ;; 00:1666 $0a
    ld   [HL], A                                       ;; 00:1667 $77
    add  HL, DE                                        ;; 00:1668 $19
    ld   A, B                                          ;; 00:1669 $78
    add  A, $04                                        ;; 00:166a $c6 $04
    ld   B, A                                          ;; 00:166c $47
    ld   A, [BC]                                       ;; 00:166d $0a
    ld   [HL], A                                       ;; 00:166e $77
    res  3, H                                          ;; 00:166f $cb $9c
    res  5, B                                          ;; 00:1671 $cb $a8
    ld   A, [BC]                                       ;; 00:1673 $0a
    ld   [HL], A                                       ;; 00:1674 $77
    add  HL, DE                                        ;; 00:1675 $19
    ld   A, B                                          ;; 00:1676 $78
    add  A, $04                                        ;; 00:1677 $c6 $04
    ld   B, A                                          ;; 00:1679 $47
    ld   A, [BC]                                       ;; 00:167a $0a
    ld   [HL], A                                       ;; 00:167b $77
    set  3, H                                          ;; 00:167c $cb $dc
    set  5, B                                          ;; 00:167e $cb $e8
    ld   A, [BC]                                       ;; 00:1680 $0a
    ld   [HL], A                                       ;; 00:1681 $77
    add  HL, DE                                        ;; 00:1682 $19
    ld   A, B                                          ;; 00:1683 $78
    add  A, $04                                        ;; 00:1684 $c6 $04
    ld   B, A                                          ;; 00:1686 $47
    ld   A, [BC]                                       ;; 00:1687 $0a
    ld   [HL], A                                       ;; 00:1688 $77
    res  3, H                                          ;; 00:1689 $cb $9c
    res  5, B                                          ;; 00:168b $cb $a8
    ld   A, [BC]                                       ;; 00:168d $0a
    ld   [HL], A                                       ;; 00:168e $77
    add  HL, DE                                        ;; 00:168f $19
    res  2, H                                          ;; 00:1690 $cb $94
    pop  DE                                            ;; 00:1692 $d1
    ld   A, B                                          ;; 00:1693 $78
    sub  A, $0c                                        ;; 00:1694 $d6 $0c
    ld   B, A                                          ;; 00:1696 $47
    pop  AF                                            ;; 00:1697 $f1
    dec  A                                             ;; 00:1698 $3d
    jr   NZ, .jr_00_164f                               ;; 00:1699 $20 $b4
    call call_00_10a3_SwitchBank2                                  ;; 00:169b $cd $a3 $10
    ret                                                ;; 00:169e $c9

call_00_169f:
    ld   A, [wD6F7_CurrentBlocksetAndCollisionBank]                                    ;; 00:169f $fa $f7 $d6
    call call_00_1089_SwitchBank                                  ;; 00:16a2 $cd $89 $10
    ld   HL, wD780                                     ;; 00:16a5 $21 $80 $d7
    ld   E, [HL]                                       ;; 00:16a8 $5e
    inc  HL                                            ;; 00:16a9 $23
    ld   D, [HL]                                       ;; 00:16aa $56
    ld   HL, wD77E                                     ;; 00:16ab $21 $7e $d7
    ld   A, [HL+]                                      ;; 00:16ae $2a
    ld   H, [HL]                                       ;; 00:16af $66
    ld   L, A                                          ;; 00:16b0 $6f
    ld   A, [wD785]                                    ;; 00:16b1 $fa $85 $d7
.jp_00_16b4:
    push AF                                            ;; 00:16b4 $f5
    push HL                                            ;; 00:16b5 $e5
    ld   A, [wD784]                                    ;; 00:16b6 $fa $84 $d7
.jp_00_16b9:
    push AF                                            ;; 00:16b9 $f5
    push DE                                            ;; 00:16ba $d5
    push HL                                            ;; 00:16bb $e5
    ld   A, H                                          ;; 00:16bc $7c
    and  A, $03                                        ;; 00:16bd $e6 $03
    add  A, $c0                                        ;; 00:16bf $c6 $c0
    ld   H, A                                          ;; 00:16c1 $67
    ld   A, [DE]                                       ;; 00:16c2 $1a
    ld   C, A                                          ;; 00:16c3 $4f
    ld   B, $40                                        ;; 00:16c4 $06 $40
    inc  DE                                            ;; 00:16c6 $13
    ld   A, [DE]                                       ;; 00:16c7 $1a
    and  A, A                                          ;; 00:16c8 $a7
    jr   Z, .jr_00_16cd                                ;; 00:16c9 $28 $02
    set  4, B                                          ;; 00:16cb $cb $e0
.jr_00_16cd:
    ld   DE, $20                                       ;; 00:16cd $11 $20 $00
    ld   A, [BC]                                       ;; 00:16d0 $0a
    ld   [HL+], A                                      ;; 00:16d1 $22
    inc  B                                             ;; 00:16d2 $04
    ld   A, [BC]                                       ;; 00:16d3 $0a
    ld   [HL+], A                                      ;; 00:16d4 $22
    inc  B                                             ;; 00:16d5 $04
    ld   A, [BC]                                       ;; 00:16d6 $0a
    ld   [HL+], A                                      ;; 00:16d7 $22
    inc  B                                             ;; 00:16d8 $04
    ld   A, [BC]                                       ;; 00:16d9 $0a
    ld   [HL], A                                       ;; 00:16da $77
    set  3, H                                          ;; 00:16db $cb $dc
    set  5, B                                          ;; 00:16dd $cb $e8
    ld   A, [BC]                                       ;; 00:16df $0a
    ld   [HL-], A                                      ;; 00:16e0 $32
    dec  B                                             ;; 00:16e1 $05
    ld   A, [BC]                                       ;; 00:16e2 $0a
    ld   [HL-], A                                      ;; 00:16e3 $32
    dec  B                                             ;; 00:16e4 $05
    ld   A, [BC]                                       ;; 00:16e5 $0a
    ld   [HL-], A                                      ;; 00:16e6 $32
    dec  B                                             ;; 00:16e7 $05
    ld   A, [BC]                                       ;; 00:16e8 $0a
    ld   [HL], A                                       ;; 00:16e9 $77
    res  3, H                                          ;; 00:16ea $cb $9c
    res  5, B                                          ;; 00:16ec $cb $a8
    ld   A, B                                          ;; 00:16ee $78
    add  A, $04                                        ;; 00:16ef $c6 $04
    ld   B, A                                          ;; 00:16f1 $47
    add  HL, DE                                        ;; 00:16f2 $19
    ld   A, [BC]                                       ;; 00:16f3 $0a
    ld   [HL+], A                                      ;; 00:16f4 $22
    inc  B                                             ;; 00:16f5 $04
    ld   A, [BC]                                       ;; 00:16f6 $0a
    ld   [HL+], A                                      ;; 00:16f7 $22
    inc  B                                             ;; 00:16f8 $04
    ld   A, [BC]                                       ;; 00:16f9 $0a
    ld   [HL+], A                                      ;; 00:16fa $22
    inc  B                                             ;; 00:16fb $04
    ld   A, [BC]                                       ;; 00:16fc $0a
    ld   [HL], A                                       ;; 00:16fd $77
    set  3, H                                          ;; 00:16fe $cb $dc
    set  5, B                                          ;; 00:1700 $cb $e8
    ld   A, [BC]                                       ;; 00:1702 $0a
    ld   [HL-], A                                      ;; 00:1703 $32
    dec  B                                             ;; 00:1704 $05
    ld   A, [BC]                                       ;; 00:1705 $0a
    ld   [HL-], A                                      ;; 00:1706 $32
    dec  B                                             ;; 00:1707 $05
    ld   A, [BC]                                       ;; 00:1708 $0a
    ld   [HL-], A                                      ;; 00:1709 $32
    dec  B                                             ;; 00:170a $05
    ld   A, [BC]                                       ;; 00:170b $0a
    ld   [HL], A                                       ;; 00:170c $77
    res  3, H                                          ;; 00:170d $cb $9c
    res  5, B                                          ;; 00:170f $cb $a8
    ld   A, B                                          ;; 00:1711 $78
    add  A, $04                                        ;; 00:1712 $c6 $04
    ld   B, A                                          ;; 00:1714 $47
    add  HL, DE                                        ;; 00:1715 $19
    ld   A, [BC]                                       ;; 00:1716 $0a
    ld   [HL+], A                                      ;; 00:1717 $22
    inc  B                                             ;; 00:1718 $04
    ld   A, [BC]                                       ;; 00:1719 $0a
    ld   [HL+], A                                      ;; 00:171a $22
    inc  B                                             ;; 00:171b $04
    ld   A, [BC]                                       ;; 00:171c $0a
    ld   [HL+], A                                      ;; 00:171d $22
    inc  B                                             ;; 00:171e $04
    ld   A, [BC]                                       ;; 00:171f $0a
    ld   [HL], A                                       ;; 00:1720 $77
    set  3, H                                          ;; 00:1721 $cb $dc
    set  5, B                                          ;; 00:1723 $cb $e8
    ld   A, [BC]                                       ;; 00:1725 $0a
    ld   [HL-], A                                      ;; 00:1726 $32
    dec  B                                             ;; 00:1727 $05
    ld   A, [BC]                                       ;; 00:1728 $0a
    ld   [HL-], A                                      ;; 00:1729 $32
    dec  B                                             ;; 00:172a $05
    ld   A, [BC]                                       ;; 00:172b $0a
    ld   [HL-], A                                      ;; 00:172c $32
    dec  B                                             ;; 00:172d $05
    ld   A, [BC]                                       ;; 00:172e $0a
    ld   [HL], A                                       ;; 00:172f $77
    res  3, H                                          ;; 00:1730 $cb $9c
    res  5, B                                          ;; 00:1732 $cb $a8
    ld   A, B                                          ;; 00:1734 $78
    add  A, $04                                        ;; 00:1735 $c6 $04
    ld   B, A                                          ;; 00:1737 $47
    add  HL, DE                                        ;; 00:1738 $19
    ld   A, [BC]                                       ;; 00:1739 $0a
    ld   [HL+], A                                      ;; 00:173a $22
    inc  B                                             ;; 00:173b $04
    ld   A, [BC]                                       ;; 00:173c $0a
    ld   [HL+], A                                      ;; 00:173d $22
    inc  B                                             ;; 00:173e $04
    ld   A, [BC]                                       ;; 00:173f $0a
    ld   [HL+], A                                      ;; 00:1740 $22
    inc  B                                             ;; 00:1741 $04
    ld   A, [BC]                                       ;; 00:1742 $0a
    ld   [HL], A                                       ;; 00:1743 $77
    set  3, H                                          ;; 00:1744 $cb $dc
    set  5, B                                          ;; 00:1746 $cb $e8
    ld   A, [BC]                                       ;; 00:1748 $0a
    ld   [HL-], A                                      ;; 00:1749 $32
    dec  B                                             ;; 00:174a $05
    ld   A, [BC]                                       ;; 00:174b $0a
    ld   [HL-], A                                      ;; 00:174c $32
    dec  B                                             ;; 00:174d $05
    ld   A, [BC]                                       ;; 00:174e $0a
    ld   [HL-], A                                      ;; 00:174f $32
    dec  B                                             ;; 00:1750 $05
    ld   A, [BC]                                       ;; 00:1751 $0a
    ld   [HL], A                                       ;; 00:1752 $77
    pop  HL                                            ;; 00:1753 $e1
    ld   A, L                                          ;; 00:1754 $7d
    and  A, $e0                                        ;; 00:1755 $e6 $e0
    ld   C, A                                          ;; 00:1757 $4f
    ld   A, L                                          ;; 00:1758 $7d
    add  A, $04                                        ;; 00:1759 $c6 $04
    and  A, $1f                                        ;; 00:175b $e6 $1f
    or   A, C                                          ;; 00:175d $b1
    ld   L, A                                          ;; 00:175e $6f
    pop  DE                                            ;; 00:175f $d1
    inc  DE                                            ;; 00:1760 $13
    inc  DE                                            ;; 00:1761 $13
    pop  AF                                            ;; 00:1762 $f1
    dec  A                                             ;; 00:1763 $3d
    jp   NZ, .jp_00_16b9                               ;; 00:1764 $c2 $b9 $16
    pop  HL                                            ;; 00:1767 $e1
    ld   BC, $80                                       ;; 00:1768 $01 $80 $00
    add  HL, BC                                        ;; 00:176b $09
    pop  AF                                            ;; 00:176c $f1
    dec  A                                             ;; 00:176d $3d
    jp   NZ, .jp_00_16b4                               ;; 00:176e $c2 $b4 $16
    ld   HL, wD77B                                     ;; 00:1771 $21 $7b $d7
    set  0, [HL]                                       ;; 00:1774 $cb $c6
    jp   call_00_10a3_SwitchBank2                                  ;; 00:1776 $c3 $a3 $10

call_00_1779:
    ld   A, [wD59E]                                    ;; 00:1779 $fa $9e $d5
    and  A, A                                          ;; 00:177c $a7
    jp   Z, .jp_00_182a                                ;; 00:177d $ca $2a $18
    ld   A, $01                                        ;; 00:1780 $3e $01
    ldh  [rVBK], A                                     ;; 00:1782 $e0 $4f
    ld   HL, wD77E                                     ;; 00:1784 $21 $7e $d7
    ld   A, [HL+]                                      ;; 00:1787 $2a
    ld   H, [HL]                                       ;; 00:1788 $66
    ld   L, A                                          ;; 00:1789 $6f
    ld   B, $cf                                        ;; 00:178a $06 $cf
    ld   A, [wD785]                                    ;; 00:178c $fa $85 $d7
.jp_00_178f:
    push AF                                            ;; 00:178f $f5
    push HL                                            ;; 00:1790 $e5
    ld   A, [wD784]                                    ;; 00:1791 $fa $84 $d7
.jp_00_1794:
    push AF                                            ;; 00:1794 $f5
    push HL                                            ;; 00:1795 $e5
    ld   E, L                                          ;; 00:1796 $5d
    ld   A, H                                          ;; 00:1797 $7c
    and  A, $03                                        ;; 00:1798 $e6 $03
    add  A, $98                                        ;; 00:179a $c6 $98
    ld   D, A                                          ;; 00:179c $57
    and  A, $03                                        ;; 00:179d $e6 $03
    add  A, $c0                                        ;; 00:179f $c6 $c0
    ld   H, A                                          ;; 00:17a1 $67
    ld   C, [HL]                                       ;; 00:17a2 $4e
    ld   A, [BC]                                       ;; 00:17a3 $0a
    ld   [DE], A                                       ;; 00:17a4 $12
    inc  L                                             ;; 00:17a5 $2c
    inc  E                                             ;; 00:17a6 $1c
    ld   C, [HL]                                       ;; 00:17a7 $4e
    ld   A, [BC]                                       ;; 00:17a8 $0a
    ld   [DE], A                                       ;; 00:17a9 $12
    inc  L                                             ;; 00:17aa $2c
    inc  E                                             ;; 00:17ab $1c
    ld   C, [HL]                                       ;; 00:17ac $4e
    ld   A, [BC]                                       ;; 00:17ad $0a
    ld   [DE], A                                       ;; 00:17ae $12
    inc  L                                             ;; 00:17af $2c
    inc  E                                             ;; 00:17b0 $1c
    ld   C, [HL]                                       ;; 00:17b1 $4e
    ld   A, [BC]                                       ;; 00:17b2 $0a
    ld   [DE], A                                       ;; 00:17b3 $12
    ld   DE, $1d                                       ;; 00:17b4 $11 $1d $00
    add  HL, DE                                        ;; 00:17b7 $19
    ld   E, L                                          ;; 00:17b8 $5d
    ld   A, H                                          ;; 00:17b9 $7c
    and  A, $03                                        ;; 00:17ba $e6 $03
    add  A, $98                                        ;; 00:17bc $c6 $98
    ld   D, A                                          ;; 00:17be $57
    ld   C, [HL]                                       ;; 00:17bf $4e
    ld   A, [BC]                                       ;; 00:17c0 $0a
    ld   [DE], A                                       ;; 00:17c1 $12
    inc  L                                             ;; 00:17c2 $2c
    inc  E                                             ;; 00:17c3 $1c
    ld   C, [HL]                                       ;; 00:17c4 $4e
    ld   A, [BC]                                       ;; 00:17c5 $0a
    ld   [DE], A                                       ;; 00:17c6 $12
    inc  L                                             ;; 00:17c7 $2c
    inc  E                                             ;; 00:17c8 $1c
    ld   C, [HL]                                       ;; 00:17c9 $4e
    ld   A, [BC]                                       ;; 00:17ca $0a
    ld   [DE], A                                       ;; 00:17cb $12
    inc  L                                             ;; 00:17cc $2c
    inc  E                                             ;; 00:17cd $1c
    ld   C, [HL]                                       ;; 00:17ce $4e
    ld   A, [BC]                                       ;; 00:17cf $0a
    ld   [DE], A                                       ;; 00:17d0 $12
    ld   DE, $1d                                       ;; 00:17d1 $11 $1d $00
    add  HL, DE                                        ;; 00:17d4 $19
    ld   E, L                                          ;; 00:17d5 $5d
    ld   A, H                                          ;; 00:17d6 $7c
    and  A, $03                                        ;; 00:17d7 $e6 $03
    add  A, $98                                        ;; 00:17d9 $c6 $98
    ld   D, A                                          ;; 00:17db $57
    ld   C, [HL]                                       ;; 00:17dc $4e
    ld   A, [BC]                                       ;; 00:17dd $0a
    ld   [DE], A                                       ;; 00:17de $12
    inc  L                                             ;; 00:17df $2c
    inc  E                                             ;; 00:17e0 $1c
    ld   C, [HL]                                       ;; 00:17e1 $4e
    ld   A, [BC]                                       ;; 00:17e2 $0a
    ld   [DE], A                                       ;; 00:17e3 $12
    inc  L                                             ;; 00:17e4 $2c
    inc  E                                             ;; 00:17e5 $1c
    ld   C, [HL]                                       ;; 00:17e6 $4e
    ld   A, [BC]                                       ;; 00:17e7 $0a
    ld   [DE], A                                       ;; 00:17e8 $12
    inc  L                                             ;; 00:17e9 $2c
    inc  E                                             ;; 00:17ea $1c
    ld   C, [HL]                                       ;; 00:17eb $4e
    ld   A, [BC]                                       ;; 00:17ec $0a
    ld   [DE], A                                       ;; 00:17ed $12
    ld   DE, $1d                                       ;; 00:17ee $11 $1d $00
    add  HL, DE                                        ;; 00:17f1 $19
    ld   E, L                                          ;; 00:17f2 $5d
    ld   A, H                                          ;; 00:17f3 $7c
    and  A, $03                                        ;; 00:17f4 $e6 $03
    add  A, $98                                        ;; 00:17f6 $c6 $98
    ld   D, A                                          ;; 00:17f8 $57
    ld   C, [HL]                                       ;; 00:17f9 $4e
    ld   A, [BC]                                       ;; 00:17fa $0a
    ld   [DE], A                                       ;; 00:17fb $12
    inc  L                                             ;; 00:17fc $2c
    inc  E                                             ;; 00:17fd $1c
    ld   C, [HL]                                       ;; 00:17fe $4e
    ld   A, [BC]                                       ;; 00:17ff $0a
    ld   [DE], A                                       ;; 00:1800 $12
    inc  L                                             ;; 00:1801 $2c
    inc  E                                             ;; 00:1802 $1c
    ld   C, [HL]                                       ;; 00:1803 $4e
    ld   A, [BC]                                       ;; 00:1804 $0a
    ld   [DE], A                                       ;; 00:1805 $12
    inc  L                                             ;; 00:1806 $2c
    inc  E                                             ;; 00:1807 $1c
    ld   C, [HL]                                       ;; 00:1808 $4e
    ld   A, [BC]                                       ;; 00:1809 $0a
    ld   [DE], A                                       ;; 00:180a $12
    pop  HL                                            ;; 00:180b $e1
    ld   A, L                                          ;; 00:180c $7d
    and  A, $e0                                        ;; 00:180d $e6 $e0
    ld   E, A                                          ;; 00:180f $5f
    ld   A, L                                          ;; 00:1810 $7d
    add  A, $04                                        ;; 00:1811 $c6 $04
    and  A, $1f                                        ;; 00:1813 $e6 $1f
    or   A, E                                          ;; 00:1815 $b3
    ld   L, A                                          ;; 00:1816 $6f
    pop  AF                                            ;; 00:1817 $f1
    dec  A                                             ;; 00:1818 $3d
    jp   NZ, .jp_00_1794                               ;; 00:1819 $c2 $94 $17
    pop  HL                                            ;; 00:181c $e1
    ld   DE, $80                                       ;; 00:181d $11 $80 $00
    add  HL, DE                                        ;; 00:1820 $19
    pop  AF                                            ;; 00:1821 $f1
    dec  A                                             ;; 00:1822 $3d
    jp   NZ, .jp_00_178f                               ;; 00:1823 $c2 $8f $17
    ld   A, $00                                        ;; 00:1826 $3e $00
    ldh  [rVBK], A                                     ;; 00:1828 $e0 $4f
.jp_00_182a:
    ld   HL, wD77E                                     ;; 00:182a $21 $7e $d7
    ld   A, [HL+]                                      ;; 00:182d $2a
    ld   H, [HL]                                       ;; 00:182e $66
    ld   L, A                                          ;; 00:182f $6f
    ld   BC, $1d                                       ;; 00:1830 $01 $1d $00
    ld   A, [wD785]                                    ;; 00:1833 $fa $85 $d7
.jr_00_1836:
    push AF                                            ;; 00:1836 $f5
    push HL                                            ;; 00:1837 $e5
    ld   A, [wD784]                                    ;; 00:1838 $fa $84 $d7
.jr_00_183b:
    push AF                                            ;; 00:183b $f5
    push HL                                            ;; 00:183c $e5
    ld   E, L                                          ;; 00:183d $5d
    ld   A, H                                          ;; 00:183e $7c
    and  A, $03                                        ;; 00:183f $e6 $03
    add  A, $98                                        ;; 00:1841 $c6 $98
    ld   D, A                                          ;; 00:1843 $57
    and  A, $03                                        ;; 00:1844 $e6 $03
    add  A, $c0                                        ;; 00:1846 $c6 $c0
    ld   H, A                                          ;; 00:1848 $67
    ld   A, [HL+]                                      ;; 00:1849 $2a
    ld   [DE], A                                       ;; 00:184a $12
    inc  E                                             ;; 00:184b $1c
    ld   A, [HL+]                                      ;; 00:184c $2a
    ld   [DE], A                                       ;; 00:184d $12
    inc  E                                             ;; 00:184e $1c
    ld   A, [HL+]                                      ;; 00:184f $2a
    ld   [DE], A                                       ;; 00:1850 $12
    inc  E                                             ;; 00:1851 $1c
    ld   A, [HL]                                       ;; 00:1852 $7e
    ld   [DE], A                                       ;; 00:1853 $12
    add  HL, BC                                        ;; 00:1854 $09
    ld   E, L                                          ;; 00:1855 $5d
    ld   A, H                                          ;; 00:1856 $7c
    and  A, $03                                        ;; 00:1857 $e6 $03
    add  A, $98                                        ;; 00:1859 $c6 $98
    ld   D, A                                          ;; 00:185b $57
    ld   A, [HL+]                                      ;; 00:185c $2a
    ld   [DE], A                                       ;; 00:185d $12
    inc  E                                             ;; 00:185e $1c
    ld   A, [HL+]                                      ;; 00:185f $2a
    ld   [DE], A                                       ;; 00:1860 $12
    inc  E                                             ;; 00:1861 $1c
    ld   A, [HL+]                                      ;; 00:1862 $2a
    ld   [DE], A                                       ;; 00:1863 $12
    inc  E                                             ;; 00:1864 $1c
    ld   A, [HL]                                       ;; 00:1865 $7e
    ld   [DE], A                                       ;; 00:1866 $12
    add  HL, BC                                        ;; 00:1867 $09
    ld   E, L                                          ;; 00:1868 $5d
    ld   A, H                                          ;; 00:1869 $7c
    and  A, $03                                        ;; 00:186a $e6 $03
    add  A, $98                                        ;; 00:186c $c6 $98
    ld   D, A                                          ;; 00:186e $57
    ld   A, [HL+]                                      ;; 00:186f $2a
    ld   [DE], A                                       ;; 00:1870 $12
    inc  E                                             ;; 00:1871 $1c
    ld   A, [HL+]                                      ;; 00:1872 $2a
    ld   [DE], A                                       ;; 00:1873 $12
    inc  E                                             ;; 00:1874 $1c
    ld   A, [HL+]                                      ;; 00:1875 $2a
    ld   [DE], A                                       ;; 00:1876 $12
    inc  E                                             ;; 00:1877 $1c
    ld   A, [HL]                                       ;; 00:1878 $7e
    ld   [DE], A                                       ;; 00:1879 $12
    add  HL, BC                                        ;; 00:187a $09
    ld   E, L                                          ;; 00:187b $5d
    ld   A, H                                          ;; 00:187c $7c
    and  A, $03                                        ;; 00:187d $e6 $03
    add  A, $98                                        ;; 00:187f $c6 $98
    ld   D, A                                          ;; 00:1881 $57
    ld   A, [HL+]                                      ;; 00:1882 $2a
    ld   [DE], A                                       ;; 00:1883 $12
    inc  E                                             ;; 00:1884 $1c
    ld   A, [HL+]                                      ;; 00:1885 $2a
    ld   [DE], A                                       ;; 00:1886 $12
    inc  E                                             ;; 00:1887 $1c
    ld   A, [HL+]                                      ;; 00:1888 $2a
    ld   [DE], A                                       ;; 00:1889 $12
    inc  E                                             ;; 00:188a $1c
    ld   A, [HL]                                       ;; 00:188b $7e
    ld   [DE], A                                       ;; 00:188c $12
    pop  HL                                            ;; 00:188d $e1
    ld   A, L                                          ;; 00:188e $7d
    and  A, $e0                                        ;; 00:188f $e6 $e0
    ld   E, A                                          ;; 00:1891 $5f
    ld   A, L                                          ;; 00:1892 $7d
    add  A, $04                                        ;; 00:1893 $c6 $04
    and  A, $1f                                        ;; 00:1895 $e6 $1f
    or   A, E                                          ;; 00:1897 $b3
    ld   L, A                                          ;; 00:1898 $6f
    pop  AF                                            ;; 00:1899 $f1
    dec  A                                             ;; 00:189a $3d
    jr   NZ, .jr_00_183b                               ;; 00:189b $20 $9e
    pop  HL                                            ;; 00:189d $e1
    ld   DE, $80                                       ;; 00:189e $11 $80 $00
    add  HL, DE                                        ;; 00:18a1 $19
    pop  AF                                            ;; 00:18a2 $f1
    dec  A                                             ;; 00:18a3 $3d
    jr   NZ, .jr_00_1836                               ;; 00:18a4 $20 $90
    ret                                                ;; 00:18a6 $c9

call_00_18a7:
    call call_00_1e3c                                  ;; 00:18a7 $cd $3c $1e
    ld   A, [wD778]                                    ;; 00:18aa $fa $78 $d7
    and  A, A                                          ;; 00:18ad $a7
    jr   Z, call_00_1922_LoadSpecialTiles                                 ;; 00:18ae $28 $72
    dec  A                                             ;; 00:18b0 $3d
    ld   E, A                                          ;; 00:18b1 $5f
    ld   D, $ce                                        ;; 00:18b2 $16 $ce
    ld   A, [wD779_RelatedToXPosition]                                    ;; 00:18b4 $fa $79 $d7
    ld   C, A                                          ;; 00:18b7 $4f
    ld   A, [wD77A_PlayerYPositionBlock]                                    ;; 00:18b8 $fa $7a $d7
    ld   B, A                                          ;; 00:18bb $47
    push HL                                            ;; 00:18bc $e5
.jr_00_18bd:
    ld   A, [DE]                                       ;; 00:18bd $1a
    cp   A, B                                          ;; 00:18be $b8
    jr   NZ, .jr_00_18dc                               ;; 00:18bf $20 $1b
    dec  D                                             ;; 00:18c1 $15
    ld   A, [DE]                                       ;; 00:18c2 $1a
    inc  D                                             ;; 00:18c3 $14
    sub  A, C                                          ;; 00:18c4 $91
    cp   A, $06                                        ;; 00:18c5 $fe $06
    jr   NC, .jr_00_18dc                               ;; 00:18c7 $30 $13
    push HL                                            ;; 00:18c9 $e5
    add  A, A                                          ;; 00:18ca $87
    add  A, L                                          ;; 00:18cb $85
    ld   L, A                                          ;; 00:18cc $6f
    ld   A, H                                          ;; 00:18cd $7c
    adc  A, $00                                        ;; 00:18ce $ce $00
    ld   H, A                                          ;; 00:18d0 $67
    set  7, E                                          ;; 00:18d1 $cb $fb
    ld   A, [DE]                                       ;; 00:18d3 $1a
    ld   [HL+], A                                      ;; 00:18d4 $22
    dec  D                                             ;; 00:18d5 $15
    ld   A, [DE]                                       ;; 00:18d6 $1a
    ld   [HL], A                                       ;; 00:18d7 $77
    res  7, E                                          ;; 00:18d8 $cb $bb
    inc  D                                             ;; 00:18da $14
    pop  HL                                            ;; 00:18db $e1
.jr_00_18dc:
    dec  E                                             ;; 00:18dc $1d
    bit  7, E                                          ;; 00:18dd $cb $7b
    jr   Z, .jr_00_18bd                                ;; 00:18df $28 $dc
    pop  HL                                            ;; 00:18e1 $e1
    jr   call_00_1922_LoadSpecialTiles                                    ;; 00:18e2 $18 $3e

call_00_18e4:
    call call_00_1e3c                                  ;; 00:18e4 $cd $3c $1e
    ld   A, [wD778]                                    ;; 00:18e7 $fa $78 $d7
    and  A, A                                          ;; 00:18ea $a7
    jr   Z, call_00_1922_LoadSpecialTiles                                 ;; 00:18eb $28 $35
    dec  A                                             ;; 00:18ed $3d
    ld   E, A                                          ;; 00:18ee $5f
    ld   D, $cd                                        ;; 00:18ef $16 $cd
    ld   A, [wD779_RelatedToXPosition]                                    ;; 00:18f1 $fa $79 $d7
    ld   C, A                                          ;; 00:18f4 $4f
    ld   A, [wD77A_PlayerYPositionBlock]                                    ;; 00:18f5 $fa $7a $d7
    ld   B, A                                          ;; 00:18f8 $47
    push HL                                            ;; 00:18f9 $e5
.jr_00_18fa:
    ld   A, [DE]                                       ;; 00:18fa $1a
    cp   A, C                                          ;; 00:18fb $b9
    jr   NZ, .jr_00_191a                               ;; 00:18fc $20 $1c
    inc  D                                             ;; 00:18fe $14
    ld   A, [DE]                                       ;; 00:18ff $1a
    dec  D                                             ;; 00:1900 $15
    sub  A, B                                          ;; 00:1901 $90
    cp   A, $06                                        ;; 00:1902 $fe $06
    jr   NC, .jr_00_191a                               ;; 00:1904 $30 $14
    push HL                                            ;; 00:1906 $e5
    inc  HL                                            ;; 00:1907 $23
    add  A, A                                          ;; 00:1908 $87
    add  A, L                                          ;; 00:1909 $85
    ld   L, A                                          ;; 00:190a $6f
    ld   A, H                                          ;; 00:190b $7c
    adc  A, $00                                        ;; 00:190c $ce $00
    ld   H, A                                          ;; 00:190e $67
    set  7, E                                          ;; 00:190f $cb $fb
    ld   A, [DE]                                       ;; 00:1911 $1a
    ld   [HL-], A                                      ;; 00:1912 $32
    inc  D                                             ;; 00:1913 $14
    ld   A, [DE]                                       ;; 00:1914 $1a
    ld   [HL], A                                       ;; 00:1915 $77
    res  7, E                                          ;; 00:1916 $cb $bb
    dec  D                                             ;; 00:1918 $15
    pop  HL                                            ;; 00:1919 $e1
.jr_00_191a:
    dec  E                                             ;; 00:191a $1d
    bit  7, E                                          ;; 00:191b $cb $7b
    jr   Z, .jr_00_18fa                                ;; 00:191d $28 $db
    pop  HL                                            ;; 00:191f $e1
    jr   call_00_1922_LoadSpecialTiles                                    ;; 00:1920 $18 $00

call_00_1922_LoadSpecialTiles: ; special tile related
    ld   A, [wD60F_BitmapOfThingsToLoad]                                    ;; 00:1922 $fa $0f $d6
    bit  2, A                                          ;; 00:1925 $cb $57
    ret  NZ                                            ;; 00:1927 $c0
    ld   DE, $0b                                       ;; 00:1928 $11 $0b $00
    add  HL, DE                                        ;; 00:192b $19
    push HL                                            ;; 00:192c $e5
    ld   HL, wD624_CurrentLevelId                                     ;; 00:192d $21 $24 $d6
    ld   L, [HL]                                       ;; 00:1930 $6e
    ld   H, $00                                        ;; 00:1931 $26 $00
    add  HL, HL                                        ;; 00:1933 $29
    ld   BC, data_00_1a2e_LevelSpecialTileIndices             ;; 00:1934 $01 $2e $1a
    add  HL, BC                                        ;; 00:1937 $09
    ld   A, [HL+]                                      ;; 00:1938 $2a
    ld   H, [HL]                                       ;; 00:1939 $66
    ld   L, A                                          ;; 00:193a $6f
    ld   A, [HL+]                                      ;; 00:193b $2a ; load first value from the Level's data table
    ld   C, A                                          ;; 00:193c $4f ; c = a
    ld   E, L                                          ;; 00:193d $5d
    ld   D, H                                          ;; 00:193e $54 ; de = hl
    pop  HL                                            ;; 00:193f $e1 ; hl = d719
    ld   B, $06                                        ;; 00:1940 $06 $06
.jr_00_1942: ; loading a value written from 3435 bank
    ld   A, [HL-]                                      ;; 00:1942 $3a
    and  A, A                                          ;; 00:1943 $a7
    jr   Z, .jr_00_1954                                ;; 00:1944 $28 $0e ; jmp if 0
    ld   A, [HL]                                       ;; 00:1946 $7e    ; go here if not 0
    sub  A, C                                          ;; 00:1947 $91
    jr   C, .jr_00_1954                                ;; 00:1948 $38 $0a
    push HL                                            ;; 00:194a $e5
    ld   L, A                                          ;; 00:194b $6f
    ld   H, $00                                        ;; 00:194c $26 $00
    add  HL, DE                                        ;; 00:194e $19
    ld   A, [HL]                                       ;; 00:194f $7e
    pop  HL                                            ;; 00:1950 $e1
    and  A, A                                          ;; 00:1951 $a7
    jr   NZ, .jr_00_1959                               ;; 00:1952 $20 $05 ; perform this jump if going to load new special tileset
.jr_00_1954:
    dec  HL                                            ;; 00:1954 $2b
    dec  B                                             ;; 00:1955 $05
    jr   NZ, .jr_00_1942                               ;; 00:1956 $20 $ea ; looping over d719, d717,  looking for  non-zero value
    ret                                                ;; 00:1958 $c9
.jr_00_1959:
    dec  A                                             ;; 00:1959 $3d
    ld   HL, wD72D_CurrentSpecialTilesetIndex          ;; 00:195a $21 $2d $d7
    cp   A, [HL]                                       ;; 00:195d $be
    ret  Z                                             ;; 00:195e $c8 ; return if the special tileset is already the current one
    ld   [HL], A                                       ;; 00:195f $77
    ld   C, A                                          ;; 00:1960 $4f
    add  A, A                                          ;; 00:1961 $87
    add  A, C                                          ;; 00:1962 $81
    ld   HL, wD624_CurrentLevelId                                     ;; 00:1963 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:1966 $6e
    ld   H, $00                                        ;; 00:1967 $26 $00
    add  HL, HL                                        ;; 00:1969 $29
    ld   DE, data_LevelSpecialTilesetBanks                                     ;; 00:196a $11 $f0 $19
    add  HL, DE                                        ;; 00:196d $19
    add  A, [HL]                                       ;; 00:196e $86
    ld   [wD728_CurrentSpecialTilesetAddr], A                                    ;; 00:196f $ea $28 $d7
    inc  HL                                            ;; 00:1972 $23
    ld   A, [HL]                                       ;; 00:1973 $7e
    ld   [wD726_SpecialTilesetBank], A                                    ;; 00:1974 $ea $26 $d7
    ld   [wD72E], A                                    ;; 00:1977 $ea $2e $d7
    call call_00_1089_SwitchBank                                  ;; 00:197a $cd $89 $10
    xor  A, A                                          ;; 00:197d $af
    ld   [wD727], A                                    ;; 00:197e $ea $27 $d7
    ld   A, $00                                        ;; 00:1981 $3e $00
    ld   [wD729], A                                    ;; 00:1983 $ea $29 $d7
    ld   A, $90                                        ;; 00:1986 $3e $90
    ld   [wD72A], A                                    ;; 00:1988 $ea $2a $d7
    ld   A, $40                                        ;; 00:198b $3e $40
    ld   [wD72B], A                                    ;; 00:198d $ea $2b $d7
    ld   A, $02                                        ;; 00:1990 $3e $02
    ld   [wD72C], A                                    ;; 00:1992 $ea $2c $d7
    ld   HL, wD727                                     ;; 00:1995 $21 $27 $d7
    ld   A, [HL+]                                      ;; 00:1998 $2a
    ld   H, [HL]                                       ;; 00:1999 $66
    ld   L, A                                          ;; 00:199a $6f
    ld   DE, $240                                      ;; 00:199b $11 $40 $02
    add  HL, DE                                        ;; 00:199e $19
    ld   DE, wCF00_SpecialTilePaletteIds                                     ;; 00:199f $11 $00 $cf
    ld   B, $24                                        ;; 00:19a2 $06 $24
.jr_00_19a4:
    ld   A, [HL+]                                      ;; 00:19a4 $2a
    ld   [DE], A                                       ;; 00:19a5 $12
    inc  E                                             ;; 00:19a6 $1c
    dec  B                                             ;; 00:19a7 $05
    jr   NZ, .jr_00_19a4                               ;; 00:19a8 $20 $fa
    ld   A, [HL+]                                      ;; 00:19aa $2a
    ld   [wD72F], A                                    ;; 00:19ab $ea $2f $d7
    and  A, A                                          ;; 00:19ae $a7
    jr   Z, .jr_00_19dc                                ;; 00:19af $28 $2b
    ld   A, [HL+]                                      ;; 00:19b1 $2a
    ld   [wD738], A                                    ;; 00:19b2 $ea $38 $d7
    ld   E, [HL]                                       ;; 00:19b5 $5e
    inc  HL                                            ;; 00:19b6 $23
    ld   D, [HL]                                       ;; 00:19b7 $56
    inc  HL                                            ;; 00:19b8 $23
    and  A, $01                                        ;; 00:19b9 $e6 $01
    jr   Z, .jr_00_19be                                ;; 00:19bb $28 $01
    ld   A, [DE]                                       ;; 00:19bd $1a
.jr_00_19be:
    ld   [wD730], A                                    ;; 00:19be $ea $30 $d7
    ld   A, [HL+]                                      ;; 00:19c1 $2a
    ld   [wD731], A                                    ;; 00:19c2 $ea $31 $d7
    ld   [wD732], A                                    ;; 00:19c5 $ea $32 $d7
    ld   A, [HL+]                                      ;; 00:19c8 $2a
    ld   [wD733], A                                    ;; 00:19c9 $ea $33 $d7
    ld   A, [HL+]                                      ;; 00:19cc $2a
    ld   [wD734], A                                    ;; 00:19cd $ea $34 $d7
    ld   A, [HL+]                                      ;; 00:19d0 $2a
    ld   [wD735], A                                    ;; 00:19d1 $ea $35 $d7
    ld   A, L                                          ;; 00:19d4 $7d
    ld   [wD736], A                                    ;; 00:19d5 $ea $36 $d7
    ld   A, H                                          ;; 00:19d8 $7c
    ld   [wD737], A                                    ;; 00:19d9 $ea $37 $d7
.jr_00_19dc:
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:19dc $21 $0f $d6
    set  2, [HL]                                       ;; 00:19df $cb $d6
    call call_00_10a3_SwitchBank2                                  ;; 00:19e1 $cd $a3 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:19e4 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:19e7 $3e $0b
    ld   HL, entry_0b_5df8                                     ;; 00:19e9 $21 $f8 $5d
    call call_00_1078_CallAltBankFunc                                  ;; 00:19ec $cd $78 $10
    ret                                                ;; 00:19ef $c9

data_LevelSpecialTilesetBanks: ; this table contains the special tileset bank numbers 
; AND the offset into that bank to start getting the tilesets
    db   $40, $13, $40, $0e, $40, $0f, $40, $0f        ;; 00:19f0 ?.?.?.??
    db   $61, $0d, $40, $10, $40, $13, $5b, $0e        ;; 00:19f8 ????????
    db   $40, $0e, $5b, $0e, $61, $0d, $40, $0f        ;; 00:1a00 ????????
    db   $40, $13, $40, $10, $40, $0d, $40, $13        ;; 00:1a08 ????????
    db   $40, $0f, $40, $13, $40, $13, $40, $13        ;; 00:1a10 ????????
    db   $40, $13, $40, $10, $40, $0d, $61, $0d        ;; 00:1a18 ????????
    db   $5b, $0e, $40, $0f, $40, $0d, $40, $13        ;; 00:1a20 ????????
    db   $40, $13, $40, $13, $73, $0e
data_00_1a2e_LevelSpecialTileIndices: ; one for each channel, some levels share the same one
    dw   special_tile_data_media_dimension
    dw   special_tile_data_toon_tv
    dw   special_tile_data_scream_tv
    dw   special_tile_data_scream_tv        ;; 00:1a2e ??????..
    dw   special_tile_data_circuit_central
    dw   special_tile_data_kung_fu_theater
    dw   special_tile_data_media_dimension
    dw   special_tile_data_prehistory_channel       ;; 00:1a ....????
    dw   special_tile_data_toon_tv
    dw   special_tile_data_prehistory_channel
    dw   special_tile_data_circuit_central
    dw   special_tile_data_scream_tv        ;; 00:1a3e ????????
    dw   special_tile_data_media_dimension
    dw   special_tile_data_kung_fu_theater
    dw   special_tile_data_rezopolis
    dw   special_tile_data_media_dimension        ;; 00:1a ????????
    dw   special_tile_data_scream_tv
    dw   special_tile_data_media_dimension
    dw   special_tile_data_media_dimension
    dw   special_tile_data_media_dimension        ;; 00:1a4e ????????
    dw   special_tile_data_media_dimension
    dw   special_tile_data_kung_fu_theater
    dw   special_tile_data_rezopolis
    dw   special_tile_data_circuit_central        ;; 00:1a ????????
    dw   special_tile_data_prehistory_channel
    dw   special_tile_data_scream_tv
    dw   special_tile_data_rezopolis
    dw   special_tile_data_media_dimension        ;; 00:1a5e ????????
    dw   special_tile_data_media_dimension
    dw   special_tile_data_media_dimension
    dw   special_tile_data_channel_z

special_tile_data_media_dimension:
    INCBIN "maps/media_dimension/special_tile_data_media_dimension.bin"
special_tile_data_toon_tv:
    INCBIN "maps/toon_tv/special_tile_data_toon_tv.bin"
special_tile_data_scream_tv:
    INCBIN "maps/scream_tv/special_tile_data_scream_tv.bin"
special_tile_data_circuit_central:
    INCBIN "maps/circuit_central/special_tile_data_circuit_central.bin"
special_tile_data_kung_fu_theater:
    INCBIN "maps/kung_fu_theater/special_tile_data_kung_fu_theater.bin"
special_tile_data_prehistory_channel:
    INCBIN "maps/prehistory_channel/special_tile_data_prehistory_channel.bin"
special_tile_data_rezopolis:
    INCBIN "maps/rezopolis/special_tile_data_rezopolis.bin"
special_tile_data_channel_z:
    INCBIN "maps/channel_z/special_tile_data_channel_z.bin"

call_00_1e3c:
; this function loads the values that were obtained from bank special tile banks 34 and 35
    push HL                                            ;; 00:1e3c $e5
    ld   A, [wD6FE_LevelTileOverrideBit]                                    ;; 00:1e3d $fa $fe $d6
    ld   C, A                                          ;; 00:1e40 $4f
    inc  HL                                            ;; 00:1e41 $23
    ld   A, [HL]                                       ;; 00:1e42 $7e
    and  A, C                                          ;; 00:1e43 $a1
    ld   [HL+], A                                      ;; 00:1e44 $22
    inc  HL                                            ;; 00:1e45 $23
    ld   A, [HL]                                       ;; 00:1e46 $7e
    and  A, C                                          ;; 00:1e47 $a1
    ld   [HL+], A                                      ;; 00:1e48 $22
    inc  HL                                            ;; 00:1e49 $23
    ld   A, [HL]                                       ;; 00:1e4a $7e
    and  A, C                                          ;; 00:1e4b $a1
    ld   [HL+], A                                      ;; 00:1e4c $22
    inc  HL                                            ;; 00:1e4d $23
    ld   A, [HL]                                       ;; 00:1e4e $7e
    and  A, C                                          ;; 00:1e4f $a1
    ld   [HL+], A                                      ;; 00:1e50 $22
    inc  HL                                            ;; 00:1e51 $23
    ld   A, [HL]                                       ;; 00:1e52 $7e
    and  A, C                                          ;; 00:1e53 $a1
    ld   [HL+], A                                      ;; 00:1e54 $22
    inc  HL                                            ;; 00:1e55 $23
    ld   A, [HL]                                       ;; 00:1e56 $7e
    and  A, C                                          ;; 00:1e57 $a1
    ld   [HL], A                                       ;; 00:1e58 $77
    pop  HL                                            ;; 00:1e59 $e1
    ret                                                ;; 00:1e5a $c9

call_00_1e5b:
    ld   HL, wD786                                     ;; 00:1e5b $21 $86 $d7
    ld   A, [HL]                                       ;; 00:1e5e $7e
    and  A, A                                          ;; 00:1e5f $a7
    jr   Z, .jr_00_1e63                                ;; 00:1e60 $28 $01
    dec  [HL]                                          ;; 00:1e62 $35
.jr_00_1e63:
    ld   A, [wD77B]                                    ;; 00:1e63 $fa $7b $d7
    and  A, A                                          ;; 00:1e66 $a7
    ret  NZ                                            ;; 00:1e67 $c0
    ld   A, [HL]                                       ;; 00:1e68 $7e
    and  A, A                                          ;; 00:1e69 $a7
    ret  NZ                                            ;; 00:1e6a $c0
    ld   A, [wD787]                                    ;; 00:1e6b $fa $87 $d7
    ld   [HL], A                                       ;; 00:1e6e $77
.jr_00_1e6f:
    ld   HL, wD77D                                     ;; 00:1e6f $21 $7d $d7
    ld   A, [HL]                                       ;; 00:1e72 $7e
    and  A, A                                          ;; 00:1e73 $a7
    ret  Z                                             ;; 00:1e74 $c8
    dec  [HL]                                          ;; 00:1e75 $35
    ld   HL, wD780                                     ;; 00:1e76 $21 $80 $d7
    ld   A, [HL+]                                      ;; 00:1e79 $2a
    ld   H, [HL]                                       ;; 00:1e7a $66
    ld   L, A                                          ;; 00:1e7b $6f
    ld   A, [HL+]                                      ;; 00:1e7c $2a
    ld   [wD77C], A                                    ;; 00:1e7d $ea $7c $d7
    bit  5, A                                          ;; 00:1e80 $cb $6f
    jr   Z, .jr_00_1e8a                                ;; 00:1e82 $28 $06
    ld   A, [HL+]                                      ;; 00:1e84 $2a
    push HL                                            ;; 00:1e85 $e5
    call call_00_113e                                  ;; 00:1e86 $cd $3e $11
    pop  HL                                            ;; 00:1e89 $e1
.jr_00_1e8a:
    ld   A, L                                          ;; 00:1e8a $7d
    ld   [wD780], A                                    ;; 00:1e8b $ea $80 $d7
    ld   A, H                                          ;; 00:1e8e $7c
    ld   [wD781], A                                    ;; 00:1e8f $ea $81 $d7
    ld   HL, wD77C                                     ;; 00:1e92 $21 $7c $d7
    bit  1, [HL]                                       ;; 00:1e95 $cb $4e
    call NZ, call_00_1ec9_UpdateBgTileFlags                              ;; 00:1e97 $c4 $c9 $1e
    ld   HL, wD77C                                     ;; 00:1e9a $21 $7c $d7
    bit  2, [HL]                                       ;; 00:1e9d $cb $56
    call NZ, call_00_1f05                              ;; 00:1e9f $c4 $05 $1f
    ld   HL, wD77C                                     ;; 00:1ea2 $21 $7c $d7
    bit  3, [HL]                                       ;; 00:1ea5 $cb $5e
    call NZ, call_00_169f                              ;; 00:1ea7 $c4 $9f $16
    ld   HL, wD785                                     ;; 00:1eaa $21 $85 $d7
    ld   B, [HL]                                       ;; 00:1ead $46
    ld   HL, wD784                                     ;; 00:1eae $21 $84 $d7
    ld   C, [HL]                                       ;; 00:1eb1 $4e
    xor  A, A                                          ;; 00:1eb2 $af
.jr_00_1eb3:
    add  A, C                                          ;; 00:1eb3 $81
    dec  B                                             ;; 00:1eb4 $05
    jr   NZ, .jr_00_1eb3                               ;; 00:1eb5 $20 $fc
    add  A, A                                          ;; 00:1eb7 $87
    ld   HL, wD780                                     ;; 00:1eb8 $21 $80 $d7
    add  A, [HL]                                       ;; 00:1ebb $86
    ld   [HL+], A                                      ;; 00:1ebc $22
    ld   A, $00                                        ;; 00:1ebd $3e $00
    adc  A, [HL]                                       ;; 00:1ebf $8e
    ld   [HL], A                                       ;; 00:1ec0 $77
    ld   HL, wD77C                                     ;; 00:1ec1 $21 $7c $d7
    bit  0, [HL]                                       ;; 00:1ec4 $cb $46
    jr   NZ, .jr_00_1e6f                               ;; 00:1ec6 $20 $a7
    ret                                                ;; 00:1ec8 $c9

call_00_1ec9_UpdateBgTileFlags:
    ld   HL, wD782                                     ;; 00:1ec9 $21 $82 $d7
    ld   C, [HL]                                       ;; 00:1ecc $4e
    ld   HL, wD783                                     ;; 00:1ecd $21 $83 $d7
    ld   B, [HL]                                       ;; 00:1ed0 $46
    ld   HL, wD780                                     ;; 00:1ed1 $21 $80 $d7
    ld   E, [HL]                                       ;; 00:1ed4 $5e
    inc  HL                                            ;; 00:1ed5 $23
    ld   D, [HL]                                       ;; 00:1ed6 $56
    ld   HL, wD778                                     ;; 00:1ed7 $21 $78 $d7
    ld   L, [HL]                                       ;; 00:1eda $6e
    ld   H, $ce                                        ;; 00:1edb $26 $ce
    ld   A, [wD785]                                    ;; 00:1edd $fa $85 $d7
.jr_00_1ee0:
    push AF                                            ;; 00:1ee0 $f5
    push BC                                            ;; 00:1ee1 $c5
    ld   A, [wD784]                                    ;; 00:1ee2 $fa $84 $d7
.jr_00_1ee5:
    push AF                                            ;; 00:1ee5 $f5
    ld   [HL], B                                       ;; 00:1ee6 $70 ; updated CE00 bgtile flags
    set  7, L                                          ;; 00:1ee7 $cb $fd
    ld   A, [DE]                                       ;; 00:1ee9 $1a
    ld   [HL], A                                       ;; 00:1eea $77
    inc  DE                                            ;; 00:1eeb $13
    dec  H                                             ;; 00:1eec $25
    ld   A, [DE]                                       ;; 00:1eed $1a
    ld   [HL], A                                       ;; 00:1eee $77
    inc  DE                                            ;; 00:1eef $13
    res  7, L                                          ;; 00:1ef0 $cb $bd
    ld   [HL], C                                       ;; 00:1ef2 $71 ; updated CD00 bgtile flags
    inc  H                                             ;; 00:1ef3 $24
    inc  L                                             ;; 00:1ef4 $2c
    inc  C                                             ;; 00:1ef5 $0c
    pop  AF                                            ;; 00:1ef6 $f1
    dec  A                                             ;; 00:1ef7 $3d
    jr   NZ, .jr_00_1ee5                               ;; 00:1ef8 $20 $eb
    pop  BC                                            ;; 00:1efa $c1
    inc  B                                             ;; 00:1efb $04
    pop  AF                                            ;; 00:1efc $f1
    dec  A                                             ;; 00:1efd $3d
    jr   NZ, .jr_00_1ee0                               ;; 00:1efe $20 $e0
    ld   A, L                                          ;; 00:1f00 $7d
    ld   [wD778], A                                    ;; 00:1f01 $ea $78 $d7
    ret                                                ;; 00:1f04 $c9

call_00_1f05:
    ld   HL, wD782                                     ;; 00:1f05 $21 $82 $d7
    ld   C, [HL]                                       ;; 00:1f08 $4e
    ld   HL, wD783                                     ;; 00:1f09 $21 $83 $d7
    ld   B, [HL]                                       ;; 00:1f0c $46
    ld   HL, wD780                                     ;; 00:1f0d $21 $80 $d7
    ld   E, [HL]                                       ;; 00:1f10 $5e
    inc  HL                                            ;; 00:1f11 $23
    ld   D, [HL]                                       ;; 00:1f12 $56
    ld   HL, wD778                                     ;; 00:1f13 $21 $78 $d7
    ld   L, [HL]                                       ;; 00:1f16 $6e
    dec  L                                             ;; 00:1f17 $2d
    ld   H, $cd                                        ;; 00:1f18 $26 $cd
.jr_00_1f1a:
    ld   A, [HL]                                       ;; 00:1f1a $7e
    cp   A, C                                          ;; 00:1f1b $b9
    jr   NZ, .jr_00_1f24                               ;; 00:1f1c $20 $06
    inc  H                                             ;; 00:1f1e $24
    ld   A, [HL]                                       ;; 00:1f1f $7e
    cp   A, B                                          ;; 00:1f20 $b8
    jr   Z, .jr_00_1f2a                                ;; 00:1f21 $28 $07
    dec  H                                             ;; 00:1f23 $25
.jr_00_1f24:
    dec  L                                             ;; 00:1f24 $2d
    bit  7, L                                          ;; 00:1f25 $cb $7d
    jr   Z, .jr_00_1f1a                                ;; 00:1f27 $28 $f1
    ret                                                ;; 00:1f29 $c9
.jr_00_1f2a:
    set  7, L                                          ;; 00:1f2a $cb $fd
    ld   H, $ce                                        ;; 00:1f2c $26 $ce
    ld   A, [wD785]                                    ;; 00:1f2e $fa $85 $d7
    ld   B, A                                          ;; 00:1f31 $47
.jr_00_1f32:
    ld   A, [wD784]                                    ;; 00:1f32 $fa $84 $d7
    ld   C, A                                          ;; 00:1f35 $4f
.jr_00_1f36:
    ld   A, [DE]                                       ;; 00:1f36 $1a
    ld   [HL], A                                       ;; 00:1f37 $77
    inc  DE                                            ;; 00:1f38 $13
    dec  H                                             ;; 00:1f39 $25
    ld   A, [DE]                                       ;; 00:1f3a $1a
    ld   [HL], A                                       ;; 00:1f3b $77
    inc  DE                                            ;; 00:1f3c $13
    inc  H                                             ;; 00:1f3d $24
    inc  L                                             ;; 00:1f3e $2c
    dec  C                                             ;; 00:1f3f $0d
    jr   NZ, .jr_00_1f36                               ;; 00:1f40 $20 $f4
    dec  B                                             ;; 00:1f42 $05
    jr   NZ, .jr_00_1f32                               ;; 00:1f43 $20 $ed
    ret                                                ;; 00:1f45 $c9

call_00_1f46:
    ld   A, [wD77D]                                    ;; 00:1f46 $fa $7d $d7
    and  A, A                                          ;; 00:1f49 $a7
    ret  NZ                                            ;; 00:1f4a $c0
    ld   A, [wD77B]                                    ;; 00:1f4b $fa $7b $d7
    and  A, A                                          ;; 00:1f4e $a7
    ret  NZ                                            ;; 00:1f4f $c0
    ld   A, [wD76B_TailSpinningFlagMaybe]                                    ;; 00:1f50 $fa $6b $d7
    and  A, A                                          ;; 00:1f53 $a7
    ret  Z                                             ;; 00:1f54 $c8
    xor  A, A                                          ;; 00:1f55 $af
    ld   [wD76B_TailSpinningFlagMaybe], A                                    ;; 00:1f56 $ea $6b $d7
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:1f59 $21 $0e $d2
    ld   A, [HL+]                                      ;; 00:1f5c $2a
    ld   H, [HL]                                       ;; 00:1f5d $66
    ld   L, A                                          ;; 00:1f5e $6f
    add  HL, HL                                        ;; 00:1f5f $29
    add  HL, HL                                        ;; 00:1f60 $29
    add  HL, HL                                        ;; 00:1f61 $29
    ld   A, H                                          ;; 00:1f62 $7c
    ld   [wD782], A                                    ;; 00:1f63 $ea $82 $d7
    ld   HL, wD210_PlayerYPosition                                     ;; 00:1f66 $21 $10 $d2
    ld   A, [HL+]                                      ;; 00:1f69 $2a
    ld   H, [HL]                                       ;; 00:1f6a $66
    ld   L, A                                          ;; 00:1f6b $6f
    add  HL, HL                                        ;; 00:1f6c $29
    add  HL, HL                                        ;; 00:1f6d $29
    add  HL, HL                                        ;; 00:1f6e $29
    ld   A, H                                          ;; 00:1f6f $7c
    ld   [wD783], A                                    ;; 00:1f70 $ea $83 $d7
    ld   L, C                                          ;; 00:1f73 $69
    ld   H, $00                                        ;; 00:1f74 $26 $00
    add  HL, HL                                        ;; 00:1f76 $29
    ld   DE, $1ff6                                     ;; 00:1f77 $11 $f6 $1f
    add  HL, DE                                        ;; 00:1f7a $19
    ld   A, [HL+]                                      ;; 00:1f7b $2a
    ld   H, [HL]                                       ;; 00:1f7c $66
    ld   L, A                                          ;; 00:1f7d $6f
    or   A, H                                          ;; 00:1f7e $b4
    ret  Z                                             ;; 00:1f7f $c8

call_00_1f80:
    ld   E, [HL]                                       ;; 00:1f80 $5e
    inc  HL                                            ;; 00:1f81 $23
    ld   D, [HL]                                       ;; 00:1f82 $56
    inc  HL                                            ;; 00:1f83 $23
    push DE                                            ;; 00:1f84 $d5
    ld   A, [HL+]                                      ;; 00:1f85 $2a
    and  A, A                                          ;; 00:1f86 $a7
    jr   Z, .jr_00_1fef                                ;; 00:1f87 $28 $66
    ld   [wD77D], A                                    ;; 00:1f89 $ea $7d $d7
    ld   A, [HL+]                                      ;; 00:1f8c $2a
    ld   [wD787], A                                    ;; 00:1f8d $ea $87 $d7
    ld   E, [HL]                                       ;; 00:1f90 $5e
    inc  HL                                            ;; 00:1f91 $23
    ld   D, [HL]                                       ;; 00:1f92 $56
    inc  HL                                            ;; 00:1f93 $23
    ld   A, [HL+]                                      ;; 00:1f94 $2a
    ld   [wD784], A                                    ;; 00:1f95 $ea $84 $d7
    ld   A, [HL+]                                      ;; 00:1f98 $2a
    ld   [wD785], A                                    ;; 00:1f99 $ea $85 $d7
    ld   A, L                                          ;; 00:1f9c $7d
    ld   [wD780], A                                    ;; 00:1f9d $ea $80 $d7
    ld   A, H                                          ;; 00:1fa0 $7c
    ld   [wD781], A                                    ;; 00:1fa1 $ea $81 $d7
    ld   A, D                                          ;; 00:1fa4 $7a
    add  A, A                                          ;; 00:1fa5 $87
    add  A, A                                          ;; 00:1fa6 $87
    add  A, A                                          ;; 00:1fa7 $87
    add  A, A                                          ;; 00:1fa8 $87
    add  A, A                                          ;; 00:1fa9 $87
    ld   HL, wD210_PlayerYPosition                                     ;; 00:1faa $21 $10 $d2
    add  A, [HL]                                       ;; 00:1fad $86
    and  A, $e0                                        ;; 00:1fae $e6 $e0
    ld   L, A                                          ;; 00:1fb0 $6f
    ld   H, $00                                        ;; 00:1fb1 $26 $00
    add  HL, HL                                        ;; 00:1fb3 $29
    add  HL, HL                                        ;; 00:1fb4 $29
    ld   A, E                                          ;; 00:1fb5 $7b
    add  A, A                                          ;; 00:1fb6 $87
    add  A, A                                          ;; 00:1fb7 $87
    add  A, A                                          ;; 00:1fb8 $87
    add  A, A                                          ;; 00:1fb9 $87
    add  A, A                                          ;; 00:1fba $87
    ld   C, A                                          ;; 00:1fbb $4f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:1fbc $fa $0e $d2
    add  A, C                                          ;; 00:1fbf $81
    rrca                                               ;; 00:1fc0 $0f
    rrca                                               ;; 00:1fc1 $0f
    rrca                                               ;; 00:1fc2 $0f
    and  A, $1c                                        ;; 00:1fc3 $e6 $1c
    or   A, L                                          ;; 00:1fc5 $b5
    ld   [wD77E], A                                    ;; 00:1fc6 $ea $7e $d7
    ld   A, H                                          ;; 00:1fc9 $7c
    add  A, $c0                                        ;; 00:1fca $c6 $c0
    ld   [wD77F], A                                    ;; 00:1fcc $ea $7f $d7
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:1fcf $21 $0e $d2
    ld   A, [HL+]                                      ;; 00:1fd2 $2a
    ld   H, [HL]                                       ;; 00:1fd3 $66
    ld   L, A                                          ;; 00:1fd4 $6f
    add  HL, HL                                        ;; 00:1fd5 $29
    add  HL, HL                                        ;; 00:1fd6 $29
    add  HL, HL                                        ;; 00:1fd7 $29
    ld   A, H                                          ;; 00:1fd8 $7c
    add  A, E                                          ;; 00:1fd9 $83
    ld   [wD782], A                                    ;; 00:1fda $ea $82 $d7
    ld   HL, wD210_PlayerYPosition                                     ;; 00:1fdd $21 $10 $d2
    ld   A, [HL+]                                      ;; 00:1fe0 $2a
    ld   H, [HL]                                       ;; 00:1fe1 $66
    ld   L, A                                          ;; 00:1fe2 $6f
    add  HL, HL                                        ;; 00:1fe3 $29
    add  HL, HL                                        ;; 00:1fe4 $29
    add  HL, HL                                        ;; 00:1fe5 $29
    ld   A, H                                          ;; 00:1fe6 $7c
    add  A, D                                          ;; 00:1fe7 $82
    ld   [wD783], A                                    ;; 00:1fe8 $ea $83 $d7
    xor  A, A                                          ;; 00:1feb $af
    ld   [wD786], A                                    ;; 00:1fec $ea $86 $d7
.jr_00_1fef:
    pop  HL                                            ;; 00:1fef $e1
    ld   A, L                                          ;; 00:1ff0 $7d
    or   A, H                                          ;; 00:1ff1 $b4
    call NZ, call_00_10bd_CallFuncInHL                              ;; 00:1ff2 $c4 $bd $10
    ret                                                ;; 00:1ff5 $c9
    db   $74, $20, $d3, $20, $ff, $20, $1c, $21        ;; 00:1ff6 ????????
    db   $39, $21, $56, $21, $ae, $21, $c2, $21        ;; 00:1ffe ????????
    db   $e4, $21, $06, $22, $6e, $21, $00, $00        ;; 00:2006 ????????
    db   $00, $00, $00, $00, $00, $00, $eb, $20        ;; 00:200e ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:2016 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:201e ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:2026 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:202e ????????
    db   $17, $22, $00, $00, $00, $00, $00, $00        ;; 00:2036 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:203e ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:2046 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:204e ????????
    db   $00, $00, $00, $00, $66, $22, $00, $00        ;; 00:2056 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:205e ????????
    db   $e7, $22, $c9, $22, $80, $20, $df, $20        ;; 00:2066 ????????
    db   $0b, $21, $28, $21, $45, $21, $8c, $20        ;; 00:206e ????????
    db   $01, $00, $00, $00, $01, $01, $2a, $02        ;; 00:2076 ????????
    db   $fa, $01, $8c, $20, $01, $00, $00, $00        ;; 00:207e ????????
    db   $01, $01, $2a, $02, $ea, $01,                 ;; 00:2086 ????????
;     db   $21, $82                                      ;; 00:2086 ????????
;    db   $d7, $4e, $21, $83, $d7, $46, $21, $b6        ;; 00:208e ????????
;    db   $20, $11, $04, $00, $e5, $fa, $24, $d6        ;; 00:2096 ????????
;    db   $be, $20, $0d, $23, $2a, $b9, $20, $08        ;; 00:209e ????????
;    db   $2a, $b8, $20, $04, $7e, $ea, $18, $d6        ;; 00:20a6 ????????
;    db   $e1, $19, $7e, $fe, $ff, $20, $e5, $c9        ;; 00:20ae ????????
    
    ld hl, $d782
    ld c, [hl]
    ld hl, $d783

jr_00_2093:
    ld b, [hl]
    ld hl, $20b6
    ld de, $0004

jr_00_209a:
    push hl
    ld a, [wD624_CurrentLevelId]
    cp [hl]
    jr nz, jr_00_20ae

    inc hl
    ld a, [hl+]
    cp c
    jr nz, jr_00_20ae

    ld a, [hl+]
    cp b
    jr nz, jr_00_20ae

    ld a, [hl]
    ld [$d618], a

jr_00_20ae:
    pop hl
    add hl, de
    ld a, [hl]
    cp $ff
    jr nz, jr_00_209a

    ret
    
    db   $01, $26, $3a, $01, $02, $4b, $0a, $01        ;; 00:20b6 ????????
    db   $05, $10, $15, $01, $0a, $4d, $34, $01        ;; 00:20be ????????
    db   $08, $37, $56, $01, $09, $3f, $70, $01        ;; 00:20c6 ????????
    db   $18, $0e, $34, $01, $ff, $fa, $20, $01        ;; 00:20ce ????????
    db   $00, $00, $00, $01, $01, $2a, $02, $fa        ;; 00:20d6 ????????
    db   $01, $fa, $20, $01, $00, $00, $00, $01        ;; 00:20de ????????
    db   $01, $2a, $02, $ea, $01, $fa, $20, $02        ;; 00:20e6 ????????
    db   $28, $00, $00, $01, $01, $28, $02, $fa        ;; 00:20ee ????????
    db   $01, $08, $9f, $01, $3e, $02, $c3, $47        ;; 00:20f6 ????????
    db   $06, $17, $21, $01, $00, $00, $00, $01        ;; 00:20fe ????????
    db   $01, $2a, $02, $fa, $01, $17, $21, $01        ;; 00:2106 ????????
    db   $00, $00, $00, $01, $01, $2a, $02, $ea        ;; 00:210e ????????
    db   $01, $3e, $03, $c3, $47, $06, $34, $21        ;; 00:2116 ????????
    db   $01, $00, $00, $00, $01, $01, $2a, $02        ;; 00:211e ????????
    db   $fa, $01, $34, $21, $01, $00, $00, $00        ;; 00:2126 ????????
    db   $01, $01, $2a, $02, $ea, $01, $3e, $01        ;; 00:212e ????????
    db   $c3, $47, $06, $51, $21, $01, $00, $00        ;; 00:2136 ????????
    db   $00, $01, $01, $2a, $02, $fa, $01, $51        ;; 00:213e ????????
    db   $21, $01, $00, $00, $00, $01, $01, $2a        ;; 00:2146 ????????
    db   $02, $ea, $01, $3e, $04, $c3, $47, $06        ;; 00:214e ????????
    db   $86, $21, $03, $3c, $00, $ff, $01, $02        ;; 00:2156 ????????
    db   $23, $22, $00, $00, $e2, $01, $08, $d9        ;; 00:215e ????????
    db   $01, $da, $01, $08, $00, $00, $e2, $01        ;; 00:2166 ????????
    db   $86, $21, $03, $3c, $00, $00, $01, $02        ;; 00:216e ????????
    db   $23, $22, $00, $00, $e2, $01, $08, $d9        ;; 00:2176 ????????
    db   $01, $da, $01, $08, $00, $00, $e2, $01        ;; 00:217e ????????
    
;    db   $21, $72, $d7, $34, $0e, $05, $11, $99        ;; 00:2186 ????????
;    db   $d7, $fa, $24, $d6, $fe, $02, $28, $05        ;; 00:218e ????????
;    db   $0e, $08, $11, $9a, $d7, $79, $be, $20        ;; 00:2196 ????????
;    db   $03, $3e, $02, $12, $ea, $9d, $d5, $3e        ;; 00:219e ????????
;    db   $00, $21, $51, $39, $cd, $78, $10, $c9        ;; 00:21a6 ????????

    ld hl, $d772
    inc [hl]
    ld c, $05
    ld de, $d799
    ld a, [wD624_CurrentLevelId]
    cp $02
    jr z, jr_00_219b

    ld c, $08
    ld de, $d79a

jr_00_219b:
    ld a, c
    cp [hl]
    jr nz, jr_00_21a2

    ld a, $02
    ld [de], a

jr_00_21a2:
    ld [$d59d], a
    ld a, Bank00
    ld hl, $3951
    call call_00_1078_CallAltBankFunc
    ret
    
    db   $bc, $21, $01, $00, $ff, $00, $02, $01        ;; 00:21ae ????????
    db   $2c, $26, $c9, $01, $ca, $01, $21, $8b        ;; 00:21b6 ????????
    db   $d7, $36, $02, $c9, $00, $00, $05, $08        ;; 00:21be ????????
    db   $ff, $00, $02, $01, $2a, $25, $d3, $01        ;; 00:21c6 ????????
    db   $d4, $01, $08, $d1, $01, $d2, $01, $08        ;; 00:21ce ????????
    db   $cf, $01, $d0, $01, $08, $cd, $01, $ce        ;; 00:21d6 ????????
    db   $01, $0c, $cb, $01, $cc, $01, $00, $00        ;; 00:21de ????????
    db   $05, $08, $00, $00, $02, $01, $2a, $25        ;; 00:21e6 ????????
    db   $d3, $01, $d4, $01, $08, $d1, $01, $d2        ;; 00:21ee ????????
    db   $01, $08, $cf, $01, $d0, $01, $08, $cd        ;; 00:21f6 ????????
    db   $01, $ce, $01, $0c, $cb, $01, $cc, $01        ;; 00:21fe ????????
    db   $11, $22, $01, $00, $00, $00, $01, $01        ;; 00:2206 ????????
    db   $0a, $c7, $01, $21, $8b, $d7, $36, $02        ;; 00:220e ????????
    db   $c9, $25, $22, $01, $08, $00, $ff, $01        ;; 00:2216 ????????
    db   $02, $28, $1b, $f8, $01, $f9, $01             ;; 00:221e ????????
    
;    db   $21        
;    db   $82, $d7, $4e, $21, $83, $d7, $46, $21        ;; 00:2226 ????????
;    db   $53, $22, $1e, $00, $2a, $b9, $20, $04        ;; 00:222e ????????
;    db   $7e, $b8, $28, $08, $23, $1c, $7e, $fe        ;; 00:2236 ????????
;    db   $ff, $20, $f1, $c9, $16, $00, $21, $8b        ;; 00:223e ????????
;    db   $d7, $19, $7e, $a7, $c0, $36, $01, $7b        ;; 00:2246 ????????
;    db   $fe, $06, $c0, $34, $c9                       ;; 00:224e ????????
    
    
    ld hl, $d782
    ld c, [hl]
    ld hl, $d783
    ld b, [hl]
    ld hl, $2253
    ld e, $00

jr_00_2232:
    ld a, [hl+]
    cp c
    jr nz, jr_00_223a

    ld a, [hl]
    cp b

call_00_2238:
    jr z, jr_00_2242

jr_00_223a:
    inc hl
    inc e
    ld a, [hl]
    cp $ff
    jr nz, jr_00_2232

    ret

jr_00_2242:
    ld d, $00
    ld hl, $d78b
    add hl, de
    ld a, [hl]
    and a
    ret nz

    ld [hl], $01
    ld a, e
    cp $06
    ret nz

    inc [hl]
    ret
    
    db   $25, $59, $2a
    db   $59, $2f, $59, $47, $51, $54, $55, $5a        ;; 00:2256 ????????
    db   $55, $29, $4a, $39, $64, $10, $47, $ff        ;; 00:225e ????????
    db   $74, $22, $00, $08, $00, $00, $01, $01        ;; 00:2266 ????????
    db   $28, $1b, $f8, $01, $f9, $01                  ;; 00:226e ????????
    
;    db   $21, $82
;    db   $d7, $4e, $21, $83, $d7, $46, $21, $a7        ;; 00:2276 ????????
;    db   $22, $fa, $24, $d6, $fe, $05, $28, $03        ;; 00:227e ????????
;    db   $21, $b8, $22, $1e, $00, $2a, $b9, $20        ;; 00:2286 ????????
;    db   $04, $7e, $b8, $28, $08, $23, $1c, $7e        ;; 00:228e ????????
;    db   $fe, $ff, $20, $f1, $c9, $16, $00, $21        ;; 00:2296 ????????
;    db   $8b, $d7, $19, $7e, $a7, $c0, $36, $02        ;; 00:229e ????????
;    db   $c9,                                          ;; 00:22a6 ????????

    ld hl, $d782
    ld c, [hl]
    ld hl, $d783
    ld b, [hl]
    ld hl, $22a7
    ld a, [wD624_CurrentLevelId]
    cp $05
    jr z, jr_00_2289

    ld hl, $22b8

jr_00_2289:
    ld e, $00

jr_00_228b:
    ld a, [hl+]
    cp c
    jr nz, jr_00_2293

    ld a, [hl]
    cp b
    jr z, jr_00_229b

jr_00_2293:
    inc hl
    inc e
    ld a, [hl]
    cp $ff
    jr nz, jr_00_228b

    ret


jr_00_229b:
    ld d, $00
    ld hl, $d78b
    add hl, de
    ld a, [hl]
    and a
    ret nz

    ld [hl], $02
    ret
    
    db   $00, $00, $4c, $3a, $4b, $05, $44             ;; 00:22a6 ????????
    db   $36, $00, $00, $32, $04, $5a, $30, $48        ;; 00:22ae ????????
    db   $0e, $ff, $5e, $0d, $43, $1f, $4f, $1f        ;; 00:22b6 ????????
    db   $05, $0f, $75, $04, $51, $1e, $73, $2d        ;; 00:22be ????????
    db   $6e, $2d, $ff, $e1, $22, $03, $06, $00        ;; 00:22c6 ????????
    db   $00, $02, $01, $28, $2c, $b9, $01, $ba        ;; 00:22ce ????????
    db   $01, $08, $bb, $01, $bc, $01, $08, $bd        ;; 00:22d6 ????????
    db   $01, $be, $01, $3e, $20, $ea, $15, $d6        ;; 00:22de ????????
    db   $c9, $ff, $22, $03, $06, $00, $00, $02        ;; 00:22e6 ????????
    db   $01, $28, $2c, $bb, $01, $bc, $01, $08        ;; 00:22ee ????????
    db   $b9, $01, $ba, $01, $08, $b7, $01, $b8        ;; 00:22f6 ????????
    db   $01, $3e, $00, $ea, $15, $d6, $c9             ;; 00:22fe ???????

call_00_2305:
    ld   HL, wD78B                                     ;; 00:2305 $21 $8b $d7
    ld   B, $00                                        ;; 00:2308 $06 $00
    ld   C, $00                                        ;; 00:230a $0e $00
.jr_00_230c:
    ld   A, [HL]                                       ;; 00:230c $7e
    cp   A, $02                                        ;; 00:230d $fe $02
    jr   C, .jr_00_2314                                ;; 00:230f $38 $03
    inc  [HL]                                          ;; 00:2311 $34
    jr   Z, .jr_00_231c                                ;; 00:2312 $28 $08
.jr_00_2314:
    inc  HL                                            ;; 00:2314 $23
    inc  C                                             ;; 00:2315 $0c
    ld   A, C                                          ;; 00:2316 $79
    cp   A, $10                                        ;; 00:2317 $fe $10
    jr   NZ, .jr_00_230c                               ;; 00:2319 $20 $f1
    ret                                                ;; 00:231b $c9
.jr_00_231c:
    dec  [HL]                                          ;; 00:231c $35
    ld   A, [wD77D]                                    ;; 00:231d $fa $7d $d7
    and  A, A                                          ;; 00:2320 $a7
    ret  NZ                                            ;; 00:2321 $c0
    ld   A, [wD77B]                                    ;; 00:2322 $fa $7b $d7
    and  A, A                                          ;; 00:2325 $a7
    ret  NZ                                            ;; 00:2326 $c0
    ld   [HL], $01                                     ;; 00:2327 $36 $01

call_00_2329_UpdateMain:
    ld   A, B                                          ;; 00:2329 $78
    ld   [wD775], A                                    ;; 00:232a $ea $75 $d7
    ld   B, $00                                        ;; 00:232d $06 $00
    ld   HL, wD624_CurrentLevelId                                     ;; 00:232f $21 $24 $d6
    ld   L, [HL]                                       ;; 00:2332 $6e
    ld   H, $00                                        ;; 00:2333 $26 $00
    add  HL, HL                                        ;; 00:2335 $29
    add  HL, HL                                        ;; 00:2336 $29
    add  HL, HL                                        ;; 00:2337 $29
    add  HL, HL                                        ;; 00:2338 $29
    ld   DE, $2472                                     ;; 00:2339 $11 $72 $24
    add  HL, DE                                        ;; 00:233c $19
    add  HL, BC                                        ;; 00:233d $09
    ld   A, [HL]                                       ;; 00:233e $7e
    cp   A, $ff                                        ;; 00:233f $fe $ff
    ret  Z                                             ;; 00:2341 $c8
    ld   L, A                                          ;; 00:2342 $6f
    ld   H, $00                                        ;; 00:2343 $26 $00
    add  HL, HL                                        ;; 00:2345 $29
    ld   DE, $2662                                     ;; 00:2346 $11 $62 $26
    add  HL, DE                                        ;; 00:2349 $19
    ld   E, [HL]                                       ;; 00:234a $5e
    inc  HL                                            ;; 00:234b $23
    ld   D, [HL]                                       ;; 00:234c $56
    push DE                                            ;; 00:234d $d5
    call call_00_3628                                  ;; 00:234e $cd $28 $36
    pop  DE                                            ;; 00:2351 $d1
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:2352 $21 $0e $d2
    ld   C, [HL]                                       ;; 00:2355 $4e
    ld   A, [DE]                                       ;; 00:2356 $1a
    ld   [HL+], A                                      ;; 00:2357 $22
    inc  DE                                            ;; 00:2358 $13
    ld   B, [HL]                                       ;; 00:2359 $46
    ld   A, [DE]                                       ;; 00:235a $1a
    ld   [HL+], A                                      ;; 00:235b $22
    inc  DE                                            ;; 00:235c $13
    push BC                                            ;; 00:235d $c5
    ld   C, [HL]                                       ;; 00:235e $4e
    ld   A, [DE]                                       ;; 00:235f $1a
    ld   [HL+], A                                      ;; 00:2360 $22
    inc  DE                                            ;; 00:2361 $13
    ld   B, [HL]                                       ;; 00:2362 $46
    ld   A, [DE]                                       ;; 00:2363 $1a
    ld   [HL], A                                       ;; 00:2364 $77
    inc  DE                                            ;; 00:2365 $13
    push BC                                            ;; 00:2366 $c5
    push DE                                            ;; 00:2367 $d5
    call call_00_13a6                                  ;; 00:2368 $cd $a6 $13
    xor  A, A                                          ;; 00:236b $af
    ld   [wD743], A                                    ;; 00:236c $ea $43 $d7
    call call_00_1264_LoadMap                                  ;; 00:236f $cd $64 $12
    ld   [wD59D_ReturnBank], A                                    ;; 00:2372 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:2375 $3e $02
    ld   HL, entry_02_6e68                                     ;; 00:2377 $21 $68 $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:237a $cd $78 $10
    call call_00_0521                                  ;; 00:237d $cd $21 $05
    pop  HL                                            ;; 00:2380 $e1
    ld   E, [HL]                                       ;; 00:2381 $5e
    inc  HL                                            ;; 00:2382 $23
    ld   D, [HL]                                       ;; 00:2383 $56
    inc  HL                                            ;; 00:2384 $23
    ld   A, E                                          ;; 00:2385 $7b
    or   A, D                                          ;; 00:2386 $b2
    jr   Z, .jr_00_23e9                                ;; 00:2387 $28 $60
    push HL                                            ;; 00:2389 $e5
    ld   L, E                                          ;; 00:238a $6b
    ld   H, D                                          ;; 00:238b $62
    xor  A, A                                          ;; 00:238c $af
    ld   [wD79D], A                                    ;; 00:238d $ea $9d $d7
    ld   [wD79E], A                                    ;; 00:2390 $ea $9e $d7
    ld   A, [HL+]                                      ;; 00:2393 $2a
.jr_00_2394:
    ld   [wD75A_CurrentInputs], A                                    ;; 00:2394 $ea $5a $d7
    ld   A, [HL+]                                      ;; 00:2397 $2a
    ld   [wD79B], A                                    ;; 00:2398 $ea $9b $d7
    ld   A, [HL+]                                      ;; 00:239b $2a
    ld   [wD79C], A                                    ;; 00:239c $ea $9c $d7
    push HL                                            ;; 00:239f $e5
.jr_00_23a0:
    ld   A, [wD775]                                    ;; 00:23a0 $fa $75 $d7
    and  A, A                                          ;; 00:23a3 $a7
    jr   Z, .jr_00_23b1                                ;; 00:23a4 $28 $0b
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:23a6 $fa $9f $d5
    and  A, A                                          ;; 00:23a9 $a7
    jr   Z, .jr_00_23b1                                ;; 00:23aa $28 $05
    pop  HL                                            ;; 00:23ac $e1
    pop  HL                                            ;; 00:23ad $e1
    jp   .jp_00_2445                                   ;; 00:23ae $c3 $45 $24
.jr_00_23b1:
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:23b1 $cd $b4 $0a
    call call_00_2dbf                                  ;; 00:23b4 $cd $bf $2d
    ld   [wD59D_ReturnBank], A                                    ;; 00:23b7 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:23ba $3e $02
    ld   HL, entry_02_715a                                     ;; 00:23bc $21 $5a $71
    call call_00_1078_CallAltBankFunc                                  ;; 00:23bf $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:23c2 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:23c5 $3e $02
    ld   HL, entry_02_6eba_UpdateObjects                                     ;; 00:23c7 $21 $ba $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:23ca $cd $78 $10
    call call_00_1455                                  ;; 00:23cd $cd $55 $14
    call call_00_08fc                                  ;; 00:23d0 $cd $fc $08
    ld   HL, wD79B                                     ;; 00:23d3 $21 $9b $d7
    ld   A, [HL]                                       ;; 00:23d6 $7e
    sub  A, $01                                        ;; 00:23d7 $d6 $01
    ld   [HL+], A                                      ;; 00:23d9 $22
    ld   C, A                                          ;; 00:23da $4f
    ld   A, [HL]                                       ;; 00:23db $7e
    sbc  A, $00                                        ;; 00:23dc $de $00
    ld   [HL], A                                       ;; 00:23de $77
    or   A, C                                          ;; 00:23df $b1
    jr   NZ, .jr_00_23a0                               ;; 00:23e0 $20 $be
    pop  HL                                            ;; 00:23e2 $e1
    ld   A, [HL+]                                      ;; 00:23e3 $2a
    cp   A, $ff                                        ;; 00:23e4 $fe $ff
    jr   NZ, .jr_00_2394                               ;; 00:23e6 $20 $ac
    pop  HL                                            ;; 00:23e8 $e1
.jr_00_23e9:
    ld   A, [HL+]                                      ;; 00:23e9 $2a
    ld   H, [HL]                                       ;; 00:23ea $66
    ld   L, A                                          ;; 00:23eb $6f
    or   A, H                                          ;; 00:23ec $b4
    jr   Z, .jr_00_241e                                ;; 00:23ed $28 $2f
    call call_00_1f80                                  ;; 00:23ef $cd $80 $1f
.jr_00_23f2:
    ld   A, [wD775]                                    ;; 00:23f2 $fa $75 $d7
    and  A, A                                          ;; 00:23f5 $a7
    jr   Z, .jr_00_23fe                                ;; 00:23f6 $28 $06
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:23f8 $fa $9f $d5
    and  A, A                                          ;; 00:23fb $a7
    jr   NZ, .jp_00_2445                               ;; 00:23fc $20 $47
.jr_00_23fe:
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:23fe $cd $b4 $0a
    call call_00_1e5b                                  ;; 00:2401 $cd $5b $1e
    ld   [wD59D_ReturnBank], A                                    ;; 00:2404 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:2407 $3e $02
    ld   HL, entry_02_6eba_UpdateObjects                                     ;; 00:2409 $21 $ba $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:240c $cd $78 $10
    call call_00_08fc                                  ;; 00:240f $cd $fc $08
    ld   A, [wD77D]                                    ;; 00:2412 $fa $7d $d7
    and  A, A                                          ;; 00:2415 $a7
    jr   NZ, .jr_00_23f2                               ;; 00:2416 $20 $da
    ld   A, [wD77B]                                    ;; 00:2418 $fa $7b $d7
    and  A, A                                          ;; 00:241b $a7
    jr   NZ, .jr_00_23f2                               ;; 00:241c $20 $d4
.jr_00_241e:
    ld   A, $b4                                        ;; 00:241e $3e $b4
.jr_00_2420:
    push AF                                            ;; 00:2420 $f5
    call call_00_0ab4_UpdateVRAMTiles                                  ;; 00:2421 $cd $b4 $0a
    ld   [wD59D_ReturnBank], A                                    ;; 00:2424 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:2427 $3e $02
    ld   HL, entry_02_6eba_UpdateObjects                                     ;; 00:2429 $21 $ba $6e
    call call_00_1078_CallAltBankFunc                                  ;; 00:242c $cd $78 $10
    call call_00_08fc                                  ;; 00:242f $cd $fc $08
    ld   A, [wD775]                                    ;; 00:2432 $fa $75 $d7
    and  A, A                                          ;; 00:2435 $a7
    jr   Z, .jr_00_2441                                ;; 00:2436 $28 $09
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:2438 $fa $9f $d5
    and  A, A                                          ;; 00:243b $a7
    jr   Z, .jr_00_2441                                ;; 00:243c $28 $03
    pop  AF                                            ;; 00:243e $f1
    jr   .jp_00_2445                                   ;; 00:243f $18 $04
.jr_00_2441:
    pop  AF                                            ;; 00:2441 $f1
    dec  A                                             ;; 00:2442 $3d
    jr   NZ, .jr_00_2420                               ;; 00:2443 $20 $db
.jp_00_2445:
    ld   A, $01                                        ;; 00:2445 $3e $01
    ld   [wD743], A                                    ;; 00:2447 $ea $43 $d7
    call call_00_3675                                  ;; 00:244a $cd $75 $36
    ld   HL, wD211_PlayerYPosition                                     ;; 00:244d $21 $11 $d2
    pop  BC                                            ;; 00:2450 $c1
    ld   [HL], B                                       ;; 00:2451 $70
    dec  HL                                            ;; 00:2452 $2b
    ld   [HL], C                                       ;; 00:2453 $71
    dec  HL                                            ;; 00:2454 $2b
    pop  BC                                            ;; 00:2455 $c1
    ld   [HL], B                                       ;; 00:2456 $70
    dec  HL                                            ;; 00:2457 $2b
    ld   [HL], C                                       ;; 00:2458 $71
    ld   A, [wD775]                                    ;; 00:2459 $fa $75 $d7
    and  A, A                                          ;; 00:245c $a7
    ret  NZ                                            ;; 00:245d $c0
    call call_00_13a6                                  ;; 00:245e $cd $a6 $13
    call call_00_1264_LoadMap                                  ;; 00:2461 $cd $64 $12
    ld   [wD59D_ReturnBank], A                                    ;; 00:2464 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:2467 $3e $02
    ld   HL, entry_02_71c8                                     ;; 00:2469 $21 $c8 $71
    call call_00_1078_CallAltBankFunc                                  ;; 00:246c $cd $78 $10
    jp   call_00_0521                                  ;; 00:246f $c3 $21 $05
    db   $00, $01, $02, $03, $ff, $ff, $ff, $ff        ;; 00:2472 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:247a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2482 ????????
    db   $ff, $ff, $04, $05, $06, $ff, $07, $08        ;; 00:248a ??w?????
    db   $0d, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2492 ????????
    db   $ff, $ff, $09, $0a, $0b, $ff, $0c, $ff        ;; 00:249a ??w?????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:24a2 ????????
    db   $ff, $ff, $0e, $0f, $10, $ff, $ff, $ff        ;; 00:24aa ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:24b2 ????????
    db   $ff, $ff, $11, $12, $ff, $ff, $ff, $ff        ;; 00:24ba ????????
    db   $15, $16, $17, $18, $19, $1a, $1b, $1c        ;; 00:24c2 ????????
    db   $1d, $1e, $13, $14, $ff, $ff, $ff, $ff        ;; 00:24ca ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:24d2 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:24da ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:24e2 ????????
    db   $ff, $ff, $1f, $20, $ff, $ff, $ff, $ff        ;; 00:24ea ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $23, $ff        ;; 00:24f2 ????????
    db   $ff, $24, $21, $22, $ff, $ff, $25, $ff        ;; 00:24fa ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2502 ????????
    db   $ff, $ff, $26, $27, $28, $ff, $ff, $ff        ;; 00:250a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2512 ????????
    db   $ff, $ff, $29, $2a, $2b, $ff, $ff, $ff        ;; 00:251a ????????
    db   $30, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2522 ????????
    db   $ff, $ff, $2c, $2d, $2e, $ff, $ff, $2f        ;; 00:252a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2532 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:253a ????????
    db   $34, $35, $36, $37, $38, $39, $3a, $3b        ;; 00:2542 ????????
    db   $3c, $ff, $31, $32, $33, $ff, $ff, $ff        ;; 00:254a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2552 ????????
    db   $ff, $ff, $3d, $ff, $ff, $ff, $ff, $ff        ;; 00:255a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2562 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:256a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2572 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:257a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2582 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:258a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2592 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:259a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25a2 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25aa ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25b2 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25ba ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25c2 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25ca ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25d2 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25da ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25e2 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25ea ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:25f2 ????????
    db   $ff, $ff, $3e, $ff, $ff, $ff, $ff, $ff        ;; 00:25fa ????????
    db   $40, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2602 ????????
    db   $ff, $ff, $3f, $ff, $ff, $ff, $ff, $ff        ;; 00:260a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2612 ????????
    db   $ff, $ff, $41, $42, $ff, $ff, $ff, $ff        ;; 00:261a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2622 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:262a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2632 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:263a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2642 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:264a ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:2652 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff        ;; 00:265a ????????
    db   $e8, $26, $13, $27, $3e, $27, $69, $27        ;; 00:2662 ????????
    dw   .data_00_2794                                 ;; 00:266a pP
    db   $a6, $27, $b5, $27, $c4, $27, $cc, $27        ;; 00:266c ????????
    dw   .data_00_27d4                                 ;; 00:2674 pP
    db   $e3, $27, $fe, $27, $0d, $28, $15, $28        ;; 00:2676 ????????
    db   $30, $28, $3f, $28, $4e, $28, $63, $28        ;; 00:267e ????????
    db   $72, $28, $81, $28, $8d, $28, $a2, $28        ;; 00:2686 ????????
    db   $aa, $28, $b2, $28, $d4, $28, $f6, $28        ;; 00:268e ????????
    db   $18, $29, $9d, $29, $d0, $29, $55, $2a        ;; 00:2696 ????????
    db   $7d, $2a, $9f, $2a, $b1, $2a, $cf, $2a        ;; 00:269e ????????
    db   $e1, $2a, $f3, $2a, $22, $2b, $51, $2b        ;; 00:26a6 ????????
    db   $6b, $2b, $80, $2b, $95, $2b, $b0, $2b        ;; 00:26ae ????????
    db   $c5, $2b, $d7, $2b, $e6, $2b, $04, $2c        ;; 00:26b6 ????????
    db   $16, $2c, $25, $2c, $2d, $2c, $35, $2c        ;; 00:26be ????????
    db   $47, $2c, $56, $2c, $68, $2c, $70, $2c        ;; 00:26c6 ????????
    db   $78, $2c, $80, $2c, $a2, $2c, $c4, $2c        ;; 00:26ce ????????
    db   $e6, $2c, $ee, $2c, $f6, $2c, $57, $2d        ;; 00:26d6 ????????
    db   $6f, $2d, $7e, $2d, $93, $2d, $9b, $2d        ;; 00:26de ????????
    db   $b0, $2d, $e0, $04, $d0, $01, $00, $00        ;; 00:26e6 ????????
    db   $f0, $26, $00, $00, $03, $0a, $fe, $ff        ;; 00:26ee ????????
    db   $02, $02, $08, $ee, $01, $ef, $01, $fe        ;; 00:26f6 ????????
    db   $01, $ff, $01, $08, $7e, $01, $7f, $01        ;; 00:26fe ????????
    db   $8e, $01, $8f, $01, $0a, $7c, $01, $7d        ;; 00:2706 ????????
    db   $01, $8c, $01, $8d, $01, $a0, $03, $f0        ;; 00:270e ????????
    db   $02, $00, $00, $1b, $27, $00, $00, $03        ;; 00:2716 ????????
    db   $0a, $fe, $ff, $02, $02, $08, $ea, $01        ;; 00:271e ????????
    db   $eb, $01, $fa, $01, $fb, $01, $08, $7a        ;; 00:2726 ????????
    db   $01, $7b, $01, $8a, $01, $8b, $01, $0a        ;; 00:272e ????????
    db   $78, $01, $79, $01, $88, $01, $89, $01        ;; 00:2736 ????????
    db   $20, $06, $f0, $02, $00, $00, $46, $27        ;; 00:273e ????????
    db   $00, $00, $03, $0a, $fe, $ff, $02, $02        ;; 00:2746 ????????
    db   $08, $e6, $01, $e7, $01, $f6, $01, $f7        ;; 00:274e ????????
    db   $01, $08, $5e, $01, $5f, $01, $6e, $01        ;; 00:2756 ????????
    db   $6f, $01, $0a, $5c, $01, $5d, $01, $6c        ;; 00:275e ????????
    db   $01, $6d, $01, $a0, $08, $f0, $02, $00        ;; 00:2766 ????????
    db   $00, $71, $27, $00, $00, $03, $0a, $fe        ;; 00:276e ????????
    db   $ff, $02, $02, $08, $be, $01, $bf, $01        ;; 00:2776 ????????
    db   $ce, $01, $cf, $01, $08, $5a, $01, $5b        ;; 00:277e ????????
    db   $01, $6a, $01, $6b, $01, $0a, $58, $01        ;; 00:2786 ????????
    db   $59, $01, $68, $01, $69, $01                  ;; 00:278e ??????
.data_00_2794:
    db   $d0, $0d, $f0, $06, $9c, $27, $00, $00        ;; 00:2794 ........
    db   $00, $80, $00, $40, $00, $01, $10, $90        ;; 00:279c ........
    db   $01, $ff, $20, $03, $10, $05, $ae, $27        ;; 00:27a4 ..??????
    db   $00, $00, $00, $80, $00, $10, $80, $01        ;; 00:27ac ????????
    db   $ff, $20, $0a, $d0, $00, $bd, $27, $00        ;; 00:27b4 ????????
    db   $00, $00, $80, $00, $10, $60, $01, $ff        ;; 00:27bc ????????
    db   $a0, $04, $00, $05, $00, $00, $00, $00        ;; 00:27c4 ????????
    db   $20, $0c, $80, $01, $00, $00, $00, $00        ;; 00:27cc ????????
.data_00_27d4:
    db   $20, $05, $30, $04, $dc, $27, $00, $00        ;; 00:27d4 ......??
    db   $00, $80, $00, $40, $80, $00, $ff, $70        ;; 00:27dc ...?????
    db   $00, $50, $01, $eb, $27, $00, $00, $00        ;; 00:27e4 ????????
    db   $80, $00, $10, $a0, $00, $50, $40, $00        ;; 00:27ec ????????
    db   $10, $e0, $00, $40, $60, $00, $20, $c0        ;; 00:27f4 ????????
    db   $00, $ff, $b0, $00, $50, $04, $06, $28        ;; 00:27fc ????????
    db   $00, $00, $00, $80, $00, $10, $70, $02        ;; 00:2804 ????????
    db   $ff, $c0, $0e, $40, $01, $00, $00, $00        ;; 00:280c ????????
    db   $00, $bc, $00, $40, $03, $00, $00, $1d        ;; 00:2814 ????????
    db   $28, $00, $00, $02, $3c, $00, $00, $02        ;; 00:281c ????????
    db   $01, $28, $26, $f4, $01, $f5, $01, $0a        ;; 00:2824 ????????
    db   $f2, $01, $f3, $01, $90, $03, $f0, $0a        ;; 00:282c ????????
    db   $38, $28, $00, $00, $00, $80, $00, $20        ;; 00:2834 ????????
    db   $70, $02, $ff, $d0, $0a, $b0, $05, $47        ;; 00:283c ????????
    db   $28, $00, $00, $00, $80, $00, $90, $90        ;; 00:2844 ????????
    db   $00, $ff, $b0, $0a, $50, $0a, $56, $28        ;; 00:284c ????????
    db   $00, $00, $00, $80, $00, $40, $80, $00        ;; 00:2854 ????????
    db   $10, $a0, $00, $40, $40, $00, $ff, $c0        ;; 00:285c ????????
    db   $02, $50, $08, $6b, $28, $00, $00, $00        ;; 00:2864 ????????
    db   $80, $00, $40, $60, $04, $ff, $70, $0c        ;; 00:286c ????????
    db   $70, $07, $7a, $28, $00, $00, $00, $80        ;; 00:2874 ????????
    db   $00, $10, $d0, $02, $ff, $30, $02, $f0        ;; 00:287c ????????
    db   $04, $89, $28, $00, $00, $00, $2c, $01        ;; 00:2884 ????????
    db   $ff, $30, $0b, $b0, $08, $95, $28, $00        ;; 00:288c ????????
    db   $00, $00, $80, $00, $40, $a0, $00, $10        ;; 00:2894 ????????
    db   $90, $01, $50, $40, $00, $ff, $c0, $03        ;; 00:289c ????????
    db   $a0, $06, $00, $00, $00, $00, $60, $08        ;; 00:28a4 ????????
    db   $b0, $07, $00, $00, $00, $00, $c0, $09        ;; 00:28ac ????????
    db   $b0, $00, $00, $00, $ba, $28, $00, $00        ;; 00:28b4 ????????
    db   $02, $3c, $ff, $ff, $02, $02, $08, $f4        ;; 00:28bc ????????
    db   $01, $f5, $01, $f6, $01, $f7, $01, $0a        ;; 00:28c4 ????????
    db   $e0, $01, $e1, $01, $e2, $01, $e3, $01        ;; 00:28cc ????????
    db   $80, $09, $90, $06, $00, $00, $dc, $28        ;; 00:28d4 ????????
    db   $00, $00, $02, $3c, $ff, $ff, $02, $02        ;; 00:28dc ????????
    db   $08, $f4, $01, $f5, $01, $f6, $01, $f7        ;; 00:28e4 ????????
    db   $01, $0a, $e0, $01, $e1, $01, $e2, $01        ;; 00:28ec ????????
    db   $e3, $01, $00, $01, $50, $05, $00, $00        ;; 00:28f4 ????????
    db   $fe, $28, $00, $00, $02, $3c, $ff, $ff        ;; 00:28fc ????????
    db   $02, $02, $08, $f4, $01, $f5, $01, $f6        ;; 00:2904 ????????
    db   $01, $f7, $01, $0a, $e0, $01, $e1, $01        ;; 00:290c ????????
    db   $e2, $01, $e3, $01, $a0, $07, $f0, $00        ;; 00:2914 ????????
    db   $00, $00, $20, $29, $00, $00, $0d, $0a        ;; 00:291c ????????
    db   $00, $00, $02, $02, $08, $ad, $01, $ad        ;; 00:2924 ????????
    db   $01, $ad, $01, $ad, $01, $08, $ad, $01        ;; 00:292c ????????
    db   $ad, $01, $ad, $01, $a8, $01, $08, $ad        ;; 00:2934 ????????
    db   $01, $ad, $01, $ad, $01, $a7, $01, $08        ;; 00:293c ????????
    db   $ad, $01, $ad, $01, $ad, $01, $a6, $01        ;; 00:2944 ????????
    db   $08, $ad, $01, $ad, $01, $ad, $01, $a5        ;; 00:294c ????????
    db   $01, $08, $ad, $01, $a8, $01, $ad, $01        ;; 00:2954 ????????
    db   $a4, $01, $08, $ad, $01, $a7, $01, $ad        ;; 00:295c ????????
    db   $01, $a4, $01, $08, $ad, $01, $a6, $01        ;; 00:2964 ????????
    db   $ad, $01, $a4, $01, $08, $ad, $01, $a5        ;; 00:296c ????????
    db   $01, $ad, $01, $a4, $01, $08, $ad, $01        ;; 00:2974 ????????
    db   $a5, $01, $a8, $01, $a4, $01, $08, $ad        ;; 00:297c ????????
    db   $01, $a5, $01, $a7, $01, $a4, $01, $08        ;; 00:2984 ????????
    db   $ad, $01, $a5, $01, $a6, $01, $a4, $01        ;; 00:298c ????????
    db   $0a, $ad, $01, $a5, $01, $a5, $01, $a4        ;; 00:2994 ????????
    db   $01, $20, $0d, $90, $06, $00, $00, $a5        ;; 00:299c ????????
    db   $29, $00, $00, $07, $0a, $00, $00, $01        ;; 00:29a4 ????????
    db   $02, $08, $a5, $01, $a4, $01, $08, $a6        ;; 00:29ac ????????
    db   $01, $a4, $01, $08, $a7, $01, $a4, $01        ;; 00:29b4 ????????
    db   $08, $a8, $01, $a4, $01, $08, $ad, $01        ;; 00:29bc ????????
    db   $a5, $01, $08, $ad, $01, $a6, $01, $0a        ;; 00:29c4 ????????
    db   $ad, $01, $a7, $01, $e0, $09, $10, $02        ;; 00:29cc ????????
    db   $00, $00, $d8, $29, $00, $00, $0d, $0a        ;; 00:29d4 ????????
    db   $00, $00, $02, $02, $08, $ad, $01, $ad        ;; 00:29dc ????????
    db   $01, $ad, $01, $ad, $01, $08, $ad, $01        ;; 00:29e4 ????????
    db   $ad, $01, $ad, $01, $a8, $01, $08, $ad        ;; 00:29ec ????????
    db   $01, $ad, $01, $ad, $01, $a7, $01, $08        ;; 00:29f4 ????????
    db   $ad, $01, $ad, $01, $ad, $01, $a6, $01        ;; 00:29fc ????????
    db   $08, $ad, $01, $ad, $01, $ad, $01, $a5        ;; 00:2a04 ????????
    db   $01, $08, $ad, $01, $a8, $01, $ad, $01        ;; 00:2a0c ????????
    db   $a4, $01, $08, $ad, $01, $a7, $01, $ad        ;; 00:2a14 ????????
    db   $01, $a4, $01, $08, $ad, $01, $a6, $01        ;; 00:2a1c ????????
    db   $ad, $01, $a4, $01, $08, $ad, $01, $a5        ;; 00:2a24 ????????
    db   $01, $ad, $01, $a4, $01, $08, $ad, $01        ;; 00:2a2c ????????
    db   $a5, $01, $a8, $01, $a4, $01, $08, $ad        ;; 00:2a34 ????????
    db   $01, $a5, $01, $a7, $01, $a4, $01, $08        ;; 00:2a3c ????????
    db   $ad, $01, $a5, $01, $a6, $01, $a4, $01        ;; 00:2a44 ????????
    db   $0a, $ad, $01, $a5, $01, $a5, $01, $a4        ;; 00:2a4c ????????
    db   $01, $00, $0b, $b0, $06, $00, $00, $5d        ;; 00:2a54 ????????
    db   $2a, $77, $2a, $02, $3c, $ff, $00, $02        ;; 00:2a5c ????????
    db   $02, $08, $03, $00, $ce, $01, $11, $00        ;; 00:2a64 ????????
    db   $11, $00, $0a, $03, $00, $ce, $01, $22        ;; 00:2a6c ????????
    db   $00, $23, $00, $3e, $ef, $ea, $94, $d7        ;; 00:2a74 ????????
    db   $c9, $e0, $0c, $b0, $06, $00, $00, $85        ;; 00:2a7c ????????
    db   $2a, $00, $00, $02, $3c, $fe, $00, $02        ;; 00:2a84 ????????
    db   $02, $08, $03, $00, $ce, $01, $11, $00        ;; 00:2a8c ????????
    db   $11, $00, $0a, $03, $00, $ce, $01, $22        ;; 00:2a94 ????????
    db   $00, $23, $00, $d0, $03, $10, $08, $a7        ;; 00:2a9c ????????
    db   $2a, $00, $00, $00, $80, $00, $10, $d0        ;; 00:2aa4 ????????
    db   $02, $40, $a0, $00, $ff, $f0, $0c, $70        ;; 00:2aac ????????
    db   $05, $b9, $2a, $00, $00, $00, $80, $00        ;; 00:2ab4 ????????
    db   $60, $60, $00, $20, $c0, $00, $60, $40        ;; 00:2abc ????????
    db   $00, $20, $a0, $00, $60, $40, $00, $20        ;; 00:2ac4 ????????
    db   $70, $01, $ff, $80, $08, $10, $0f, $d7        ;; 00:2acc ????????
    db   $2a, $00, $00, $00, $80, $00, $20, $e0        ;; 00:2ad4 ????????
    db   $00, $40, $e0, $00, $ff, $80, $0b, $f0        ;; 00:2adc ????????
    db   $0c, $e9, $2a, $00, $00, $00, $80, $00        ;; 00:2ae4 ????????
    db   $10, $00, $02, $40, $80, $00, $ff, $40        ;; 00:2aec ????????
    db   $06, $70, $09, $00, $00, $fb, $2a, $1c        ;; 00:2af4 ????????
    db   $2b, $05, $0a, $ff, $00, $02, $01, $08        ;; 00:2afc ????????
    db   $99, $01, $9a, $01, $08, $86, $01, $87        ;; 00:2b04 ????????
    db   $01, $08, $88, $01, $89, $01, $08, $8a        ;; 00:2b0c ????????
    db   $01, $8b, $01, $0a, $8c, $01, $8d, $01        ;; 00:2b14 ????????
    db   $3e, $ef, $ea, $94, $d7, $c9, $00, $08        ;; 00:2b1c ????????
    db   $b0, $0c, $00, $00, $2a, $2b, $4b, $2b        ;; 00:2b24 ????????
    db   $05, $0a, $ff, $00, $02, $01, $08, $99        ;; 00:2b2c ????????
    db   $01, $9a, $01, $08, $86, $01, $87, $01        ;; 00:2b34 ????????
    db   $08, $88, $01, $89, $01, $08, $8a, $01        ;; 00:2b3c ????????
    db   $8b, $01, $0a, $8c, $01, $8d, $01, $3e        ;; 00:2b44 ????????
    db   $ef, $ea, $99, $d7, $c9, $20, $0b, $30        ;; 00:2b4c ????????
    db   $0d, $00, $00, $59, $2b, $00, $00, $02        ;; 00:2b54 ????????
    db   $3c, $ff, $00, $02, $01, $08, $94, $01        ;; 00:2b5c ????????
    db   $95, $01, $0a, $d9, $01, $da, $01, $40        ;; 00:2b64 ????????
    db   $06, $30, $0d, $73, $2b, $00, $00, $00        ;; 00:2b6c ????????
    db   $80, $00, $10, $e0, $00, $40, $00, $01        ;; 00:2b74 ????????
    db   $10, $60, $00, $ff, $c0, $0b, $b0, $0d        ;; 00:2b7c ????????
    db   $88, $2b, $00, $00, $00, $80, $00, $20        ;; 00:2b84 ????????
    db   $80, $01, $80, $60, $00, $20, $e0, $00        ;; 00:2b8c ????????
    db   $ff, $10, $08, $30, $0e, $9d, $2b, $00        ;; 00:2b94 ????????
    db   $00, $00, $80, $00, $10, $80, $00, $40        ;; 00:2b9c ????????
    db   $20, $01, $10, $e0, $00, $40, $40, $00        ;; 00:2ba4 ????????
    db   $10, $b0, $00, $ff, $b0, $0e, $10, $0a        ;; 00:2bac ????????
    db   $b8, $2b, $00, $00, $00, $80, $00, $10        ;; 00:2bb4 ????????
    db   $80, $00, $40, $40, $02, $20, $90, $01        ;; 00:2bbc ????????
    db   $ff, $80, $02, $90, $0d, $cd, $2b, $00        ;; 00:2bc4 ????????
    db   $00, $00, $80, $00, $40, $40, $03, $20        ;; 00:2bcc ????????
    db   $a0, $01, $ff, $30, $0f, $b0, $00, $df        ;; 00:2bd4 ????????
    db   $2b, $00, $00, $00, $80, $00, $20, $30        ;; 00:2bdc ????????
    db   $02, $ff, $00, $07, $b0, $06, $ee, $2b        ;; 00:2be4 ????????
    db   $00, $00, $00, $80, $00, $10, $e0, $00        ;; 00:2bec ????????
    db   $50, $60, $00, $10, $80, $00, $60, $00        ;; 00:2bf4 ????????
    db   $01, $50, $c0, $00, $60, $20, $01, $ff        ;; 00:2bfc ????????
    db   $80, $09, $b0, $0c, $0c, $2c, $00, $00        ;; 00:2c04 ????????
    db   $00, $80, $00, $40, $00, $02, $10, $40        ;; 00:2c0c ????????
    db   $02, $ff, $f0, $02, $f0, $0a, $1e, $2c        ;; 00:2c14 ????????
    db   $00, $00, $00, $80, $00, $10, $80, $02        ;; 00:2c1c ????????
    db   $ff, $40, $07, $c0, $0a, $00, $00, $00        ;; 00:2c24 ????????
    db   $00, $80, $05, $00, $0b, $00, $00, $00        ;; 00:2c2c ????????
    db   $00, $e0, $05, $d0, $03, $3d, $2c, $00        ;; 00:2c34 ????????
    db   $00, $00, $80, $00, $10, $a0, $01, $40        ;; 00:2c3c ????????
    db   $a0, $00, $ff, $70, $0e, $b0, $05, $4f        ;; 00:2c44 ????????
    db   $2c, $00, $00, $00, $80, $00, $10, $10        ;; 00:2c4c ????????
    db   $01, $ff, $70, $05, $70, $09, $5e, $2c        ;; 00:2c54 ????????
    db   $00, $00, $00, $80, $00, $40, $c0, $01        ;; 00:2c5c ????????
    db   $10, $70, $00, $ff, $80, $0b, $c0, $01        ;; 00:2c64 ????????
    db   $00, $00, $00, $00, $e0, $08, $00, $04        ;; 00:2c6c ????????
    db   $00, $00, $00, $00, $20, $09, $40, $03        ;; 00:2c74 ????????
    db   $00, $00, $00, $00, $80, $02, $90, $01        ;; 00:2c7c ????????
    db   $00, $00, $88, $2c, $00, $00, $02, $3c        ;; 00:2c84 ????????
    db   $ff, $ff, $02, $02, $08, $f4, $01, $f5        ;; 00:2c8c ????????
    db   $01, $f6, $01, $f7, $01, $0a, $e0, $01        ;; 00:2c94 ????????
    db   $e1, $01, $e2, $01, $e3, $01, $40, $0d        ;; 00:2c9c ????????
    db   $b0, $00, $00, $00, $aa, $2c, $00, $00        ;; 00:2ca4 ????????
    db   $02, $3c, $ff, $ff, $02, $02, $08, $f4        ;; 00:2cac ????????
    db   $01, $f5, $01, $f6, $01, $f7, $01, $0a        ;; 00:2cb4 ????????
    db   $e0, $01, $e1, $01, $e2, $01, $e3, $01        ;; 00:2cbc ????????
    db   $00, $03, $90, $01, $00, $00, $cc, $2c        ;; 00:2cc4 ????????
    db   $00, $00, $02, $3c, $ff, $ff, $02, $02        ;; 00:2ccc ????????
    db   $08, $f4, $01, $f5, $01, $f6, $01, $f7        ;; 00:2cd4 ????????
    db   $01, $0a, $e0, $01, $e1, $01, $e2, $01        ;; 00:2cdc ????????
    db   $e3, $01, $e0, $0e, $d0, $05, $00, $00        ;; 00:2ce4 ????????
    db   $fe, $2c, $20, $01, $d0, $08, $00, $00        ;; 00:2cec ????????
    db   $fe, $2c, $40, $0a, $f0, $05, $00, $00        ;; 00:2cf4 ????????
    db   $fe, $2c, $00, $00, $09, $0a, $00, $ff        ;; 00:2cfc ????????
    db   $01, $04, $08, $a5, $01, $a9, $01, $00        ;; 00:2d04 ????????
    db   $00, $00, $00, $08, $a6, $01, $a4, $01        ;; 00:2d0c ????????
    db   $aa, $01, $00, $00, $08, $a7, $01, $a4        ;; 00:2d14 ????????
    db   $01, $ab, $01, $00, $00, $08, $a8, $01        ;; 00:2d1c ????????
    db   $a4, $01, $ac, $01, $00, $00, $08, $ad        ;; 00:2d24 ????????
    db   $01, $a5, $01, $a9, $01, $00, $00, $08        ;; 00:2d2c ????????
    db   $ad, $01, $a6, $01, $a4, $01, $aa, $01        ;; 00:2d34 ????????
    db   $08, $ad, $01, $a7, $01, $a4, $01, $ab        ;; 00:2d3c ????????
    db   $01, $08, $ad, $01, $a8, $01, $a4, $01        ;; 00:2d44 ????????
    db   $ac, $01, $0a, $ad, $01, $ad, $01, $a5        ;; 00:2d4c ????????
    db   $01, $a9, $01, $60, $08, $10, $0c, $5f        ;; 00:2d54 ????????
    db   $2d, $00, $00, $00, $80, $00, $10, $40        ;; 00:2d5c ????????
    db   $00, $90, $40, $00, $10, $80, $02, $50        ;; 00:2d64 ????????
    db   $60, $00, $ff, $50, $0b, $f0, $06, $77        ;; 00:2d6c ????????
    db   $2d, $00, $00, $00, $80, $00, $10, $50        ;; 00:2d74 ????????
    db   $01, $ff, $c0, $03, $90, $03, $86, $2d        ;; 00:2d7c ????????
    db   $00, $00, $00, $80, $00, $40, $80, $00        ;; 00:2d84 ????????
    db   $10, $60, $01, $40, $60, $00, $ff, $00        ;; 00:2d8c ????????
    db   $0a, $00, $01, $00, $00, $00, $00, $c0        ;; 00:2d94 ????????
    db   $03, $b0, $05, $a3, $2d, $00, $00, $00        ;; 00:2d9c ????????
    db   $80, $00, $40, $60, $00, $10, $e0, $00        ;; 00:2da4 ????????
    db   $40, $40, $02, $ff, $b0, $08, $d0, $06        ;; 00:2dac ????????
    db   $b8, $2d, $00, $00, $00, $80, $00, $20        ;; 00:2db4 ????????
    db   $f0, $02, $ff                                 ;; 00:2dbc ???

call_00_2dbf:
    ld   A, [wD75A_CurrentInputs]                                    ;; 00:2dbf $fa $5a $d7
    and  A, A                                          ;; 00:2dc2 $a7
    jr   NZ, .jr_00_2dd1                               ;; 00:2dc3 $20 $0c
    ld   HL, wD79D                                     ;; 00:2dc5 $21 $9d $d7
    inc  [HL]                                          ;; 00:2dc8 $34
    dec  [HL]                                          ;; 00:2dc9 $35
    jr   Z, .jr_00_2ddc                                ;; 00:2dca $28 $10
    dec  [HL]                                          ;; 00:2dcc $35
    ld   [HL], $00                                     ;; 00:2dcd $36 $00
    jr   .jr_00_2ddc                                   ;; 00:2dcf $18 $0b
.jr_00_2dd1:
    ld   HL, wD79D                                     ;; 00:2dd1 $21 $9d $d7
    ld   A, [HL]                                       ;; 00:2dd4 $7e
    cp   A, $10                                        ;; 00:2dd5 $fe $10
    jr   Z, .jr_00_2ddc                                ;; 00:2dd7 $28 $03
    inc  [HL]                                          ;; 00:2dd9 $34
    ld   [HL], $10                                     ;; 00:2dda $36 $10
.jr_00_2ddc:
    ld   HL, wD79D                                     ;; 00:2ddc $21 $9d $d7
    ld   A, [HL+]                                      ;; 00:2ddf $2a
    ld   C, A                                          ;; 00:2de0 $4f
    ld   A, [HL]                                       ;; 00:2de1 $7e
    and  A, $0f                                        ;; 00:2de2 $e6 $0f
    add  A, C                                          ;; 00:2de4 $81
    ld   [HL], A                                       ;; 00:2de5 $77
    swap A                                             ;; 00:2de6 $cb $37
    and  A, $0f                                        ;; 00:2de8 $e6 $0f
    ld   C, A                                          ;; 00:2dea $4f
    ld   HL, wD75A_CurrentInputs                                     ;; 00:2deb $21 $5a $d7
    bit  4, [HL]                                       ;; 00:2dee $cb $66
    jr   Z, .jr_00_2e01                                ;; 00:2df0 $28 $0f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:2df2 $fa $0e $d2
    add  A, C                                          ;; 00:2df5 $81
    ld   [wD20E_PlayerXPosition], A                                    ;; 00:2df6 $ea $0e $d2
    ld   A, [wD20F_PlayerXPosition]                                    ;; 00:2df9 $fa $0f $d2
    adc  A, $00                                        ;; 00:2dfc $ce $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 00:2dfe $ea $0f $d2
.jr_00_2e01:
    bit  5, [HL]                                       ;; 00:2e01 $cb $6e
    jr   Z, .jr_00_2e14                                ;; 00:2e03 $28 $0f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:2e05 $fa $0e $d2
    sub  A, C                                          ;; 00:2e08 $91
    ld   [wD20E_PlayerXPosition], A                                    ;; 00:2e09 $ea $0e $d2
    ld   A, [wD20F_PlayerXPosition]                                    ;; 00:2e0c $fa $0f $d2
    sbc  A, $00                                        ;; 00:2e0f $de $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 00:2e11 $ea $0f $d2
.jr_00_2e14:
    bit  7, [HL]                                       ;; 00:2e14 $cb $7e
    jr   Z, .jr_00_2e27                                ;; 00:2e16 $28 $0f
    ld   A, [wD210_PlayerYPosition]                                    ;; 00:2e18 $fa $10 $d2
    add  A, C                                          ;; 00:2e1b $81
    ld   [wD210_PlayerYPosition], A                                    ;; 00:2e1c $ea $10 $d2
    ld   A, [wD211_PlayerYPosition]                                    ;; 00:2e1f $fa $11 $d2
    adc  A, $00                                        ;; 00:2e22 $ce $00
    ld   [wD211_PlayerYPosition], A                                    ;; 00:2e24 $ea $11 $d2
.jr_00_2e27:
    bit  6, [HL]                                       ;; 00:2e27 $cb $76
    ret  Z                                             ;; 00:2e29 $c8
    ld   A, [wD210_PlayerYPosition]                                    ;; 00:2e2a $fa $10 $d2
    sub  A, C                                          ;; 00:2e2d $91
    ld   [wD210_PlayerYPosition], A                                    ;; 00:2e2e $ea $10 $d2
    ld   A, [wD211_PlayerYPosition]                                    ;; 00:2e31 $fa $11 $d2
    sbc  A, $00                                        ;; 00:2e34 $de $00
    ld   [wD211_PlayerYPosition], A                                    ;; 00:2e36 $ea $11 $d2
    ret                                                ;; 00:2e39 $c9

call_00_2e3a:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e3a $cd $b0 $2e
    ld   DE, $00                                       ;; 00:2e3d $11 $00 $00
    add  HL, DE                                        ;; 00:2e40 $19
    ld   A, [HL]                                       ;; 00:2e41 $7e
    ret                                                ;; 00:2e42 $c9

call_00_2e43:
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

call_00_2eb0_GetCurrentMapBankNumber:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e77 $cd $b0 $2e
    ld   DE, $04                                       ;; 00:2e7a $11 $04 $00
    add  HL, DE                                        ;; 00:2e7d $19
    ld   A, [HL]                                       ;; 00:2e7e $7e
    ret                                                ;; 00:2e7f $c9

call_00_2eb0_GetCurrentSpecialTileBank:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e80 $cd $b0 $2e
    ld   DE, $05                                       ;; 00:2e83 $11 $05 $00
    add  HL, DE                                        ;; 00:2e86 $19
    ld   A, [HL]                                       ;; 00:2e87 $7e
    ret                                                ;; 00:2e88 $c9

call_00_2eb0_GetCurrentBlocksetBank:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e89 $cd $b0 $2e
    ld   DE, $06                                       ;; 00:2e8c $11 $06 $00
    add  HL, DE                                        ;; 00:2e8f $19
    ld   A, [HL]                                       ;; 00:2e90 $7e
    ret                                                ;; 00:2e91 $c9
    ret                                                ;; 00:2e92 $c9

call_00_2e93:
    call call_00_2eb0_GetLevelDataAddr                                  ;; 00:2e93 $cd $b0 $2e
    ld   DE, $08                                       ;; 00:2e96 $11 $08 $00
    add  HL, DE                                        ;; 00:2e99 $19
    ld   A, [HL]                                       ;; 00:2e9a $7e
    ret                                                ;; 00:2e9b $c9

call_00_2eb0_GetCurrentBgTilesetBank:
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
; 0x0
; 0x1
; 0x2-0x3 is a pointer to the level's text (level name, mission names)
; 0x4 is map bank number
; 0x5 is map special tile data bank
; 0x6 is blockset/collision data bank
; 0x7
; 0x8 is the bit to use in the blockset/collision data bank
; 0x9 is tileset bank
; 0xa
; 0xb
; 0xc
; 0xd
; 0xe
; 0xf
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

call_00_30af:
    ld   H, $d2                                        ;; 00:30af $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:30b1 $fa $00 $d3
    or   A, $1e                                        ;; 00:30b4 $f6 $1e
    ld   L, A                                          ;; 00:30b6 $6f
    ld   A, [HL]                                       ;; 00:30b7 $7e
    sub  A, $02                                        ;; 00:30b8 $d6 $02
    bit  7, A                                          ;; 00:30ba $cb $7f
    jr   Z, .jr_00_30c4                                ;; 00:30bc $28 $06
    cp   A, $c0                                        ;; 00:30be $fe $c0
    jr   NC, .jr_00_30c4                               ;; 00:30c0 $30 $02
    ld   A, $c0                                        ;; 00:30c2 $3e $c0
.jr_00_30c4:
    ld   [HL], A                                       ;; 00:30c4 $77
    cpl                                                ;; 00:30c5 $2f
    inc  A                                             ;; 00:30c6 $3c
    sra  A                                             ;; 00:30c7 $cb $2f
    sra  A                                             ;; 00:30c9 $cb $2f
    sra  A                                             ;; 00:30cb $cb $2f
    sra  A                                             ;; 00:30cd $cb $2f
    ld   C, A                                          ;; 00:30cf $4f
    cp   A, $80                                        ;; 00:30d0 $fe $80
    ld   A, $ff                                        ;; 00:30d2 $3e $ff
    adc  A, $00                                        ;; 00:30d4 $ce $00
    ld   B, A                                          ;; 00:30d6 $47
    jp   call_00_37d8                                  ;; 00:30d7 $c3 $d8 $37
;    db   $26, $d2, $fa, $00, $d3, $f6, $1e, $6f        ;; 00:30da ????????
;    db   $7e, $d6, $02, $cb, $7f, $28, $06, $fe        ;; 00:30e2 ????????
;    db   $c0, $30, $02, $3e, $c0, $77, $cb, $2f        ;; 00:30ea ????????
;    db   $cb, $2f, $cb, $2f, $cb, $2f, $4f, $fe        ;; 00:30f2 ????????
;    db   $80, $3e, $ff, $ce, $00, $47, $7d, $ee        ;; 00:30fa ????????
;    db   $0e, $6f, $7e, $81, $22, $7e, $88, $77        ;; 00:3102 ????????
;    db   $cd, $9c, $34, $26, $d2, $fa, $00, $d3        ;; 00:310a ????????
;    db   $f6, $10, $6f, $7b, $96, $23, $7a, $9e        ;; 00:3112 ????????
;    db   $d8, $72, $2d, $73, $7d, $ee, $0e, $6f        ;; 00:311a ????????
;    db   $af, $77, $c9, $26, $d2, $fa, $00, $d3        ;; 00:3122 ????????
;    db   $f6, $10, $6f, $5e, $2c, $56, $ee, $0a        ;; 00:312a ????????
;    db   $6f, $73, $2c, $72, $c9, $26, $d2, $fa        ;; 00:3132 ????????
;    db   $00, $d3, $f6, $1a, $6f, $5e, $2c, $56        ;; 00:313a ????????
;    db   $ee, $0a, $6f, $2a, $93, $7e, $9a, $d8        ;; 00:3142 ????????
;    db   $72, $2d, $73, $7d, $ee, $0e, $6f, $af        ;; 00:314a ????????
;    db   $77, $c9                                      ;; 00:3152 ??


    ld h, $d2
    ld a, [$d300]
    or $1e
    ld l, a
    ld a, [hl]
    sub $02
    bit 7, a
    jr z, jr_00_30ef

    cp $c0
    jr nc, jr_00_30ef

    ld a, $c0

jr_00_30ef:
    ld [hl], a
    sra a
    sra a
    sra a
    sra a
    ld c, a
    cp $80
    ld a, $ff
    adc $00
    ld b, a
    ld a, l
    xor $0e
    ld l, a
    ld a, [hl]
    add c
    ld [hl+], a
    ld a, [hl]
    adc b
    ld [hl], a
    call call_00_349c
    ld h, $d2
    ld a, [$d300]
    or $10
    ld l, a
    ld a, e
    sub [hl]
    inc hl
    ld a, d
    sbc [hl]
    ret c

    ld [hl], d
    dec l
    ld [hl], e
    ld a, l
    xor $0e
    ld l, a
    xor a
    ld [hl], a
    ret


    ld h, $d2
    ld a, [$d300]
    or $10
    ld l, a
    ld e, [hl]
    inc l
    ld d, [hl]
    xor $0a
    ld l, a
    ld [hl], e
    inc l
    ld [hl], d
    ret


call_00_3137:
    ld h, $d2
    ld a, [$d300]
    or $1a
    ld l, a
    ld e, [hl]
    inc l
    ld d, [hl]
    xor $0a
    ld l, a
    ld a, [hl+]
    sub e
    ld a, [hl]
    sbc d
    ret c

    ld [hl], d
    dec l
    ld [hl], e
    ld a, l
    xor $0e
    ld l, a
    xor a
    ld [hl], a
    ret

call_00_3154:
    call call_00_34ba                                  ;; 00:3154 $cd $ba $34
    ld   H, $d2                                        ;; 00:3157 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3159 $fa $00 $d3
    or   A, $10                                        ;; 00:315c $f6 $10
    ld   L, A                                          ;; 00:315e $6f
    ld   A, [HL+]                                      ;; 00:315f $2a
    sub  A, E                                          ;; 00:3160 $93
    ld   A, [HL]                                       ;; 00:3161 $7e
    sbc  A, D                                          ;; 00:3162 $9a
    ret  C                                             ;; 00:3163 $d8
    ld   [HL], D                                       ;; 00:3164 $72
    dec  L                                             ;; 00:3165 $2d
    ld   [HL], E                                       ;; 00:3166 $73
    ld   A, L                                          ;; 00:3167 $7d
    xor  A, $0e                                        ;; 00:3168 $ee $0e
    ld   L, A                                          ;; 00:316a $6f
    xor  A, A                                          ;; 00:316b $af
    ld   [HL], A                                       ;; 00:316c $77
    ret                                                ;; 00:316d $c9

call_00_316e:
    push BC                                            ;; 00:316e $c5
    call call_00_34ba                                  ;; 00:316f $cd $ba $34
    pop  HL                                            ;; 00:3172 $e1
    add  HL, DE                                        ;; 00:3173 $19
    ld   E, L                                          ;; 00:3174 $5d
    ld   D, H                                          ;; 00:3175 $54
    ld   H, $d2                                        ;; 00:3176 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3178 $fa $00 $d3
    or   A, $10                                        ;; 00:317b $f6 $10
    ld   L, A                                          ;; 00:317d $6f
    ld   A, [HL+]                                      ;; 00:317e $2a
    sub  A, E                                          ;; 00:317f $93
    ld   A, [HL]                                       ;; 00:3180 $7e
    sbc  A, D                                          ;; 00:3181 $9a
    ret  C                                             ;; 00:3182 $d8
    ld   [HL], D                                       ;; 00:3183 $72
    dec  L                                             ;; 00:3184 $2d
    ld   [HL], E                                       ;; 00:3185 $73
    ld   A, L                                          ;; 00:3186 $7d
    xor  A, $0e                                        ;; 00:3187 $ee $0e
    ld   L, A                                          ;; 00:3189 $6f
    xor  A, A                                          ;; 00:318a $af
    ld   [HL], A                                       ;; 00:318b $77
    ret                                                ;; 00:318c $c9

call_00_318d:
    ld   H, $d2                                        ;; 00:318d $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:318f $fa $00 $d3
    or   A, $17                                        ;; 00:3192 $f6 $17
    ld   L, A                                          ;; 00:3194 $6f
    bit  3, [HL]                                       ;; 00:3195 $cb $5e
    jr   Z, .jr_00_319c                                ;; 00:3197 $28 $03
    bit  0, [HL]                                       ;; 00:3199 $cb $46
    ret  Z                                             ;; 00:319b $c8
.jr_00_319c:
    bit  1, [HL]                                       ;; 00:319c $cb $4e
    jr   NZ, .jr_00_3202                               ;; 00:319e $20 $62
    bit  7, [HL]                                       ;; 00:31a0 $cb $7e
    jr   NZ, .jr_00_31de                               ;; 00:31a2 $20 $3a
    call call_00_347e                                  ;; 00:31a4 $cd $7e $34
    ld   H, $d2                                        ;; 00:31a7 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:31a9 $fa $00 $d3
    or   A, $0e                                        ;; 00:31ac $f6 $0e
    ld   L, A                                          ;; 00:31ae $6f
    ld   A, [HL+]                                      ;; 00:31af $2a
    sub  A, E                                          ;; 00:31b0 $93
    ld   A, [HL]                                       ;; 00:31b1 $7e
    sbc  A, D                                          ;; 00:31b2 $9a
    jr   NC, .jr_00_31be                               ;; 00:31b3 $30 $09
    ld   A, L                                          ;; 00:31b5 $7d
    xor  A, $14                                        ;; 00:31b6 $ee $14
    ld   L, A                                          ;; 00:31b8 $6f
    ld   A, [HL+]                                      ;; 00:31b9 $2a
    cp   A, [HL]                                       ;; 00:31ba $be
    ret  Z                                             ;; 00:31bb $c8
    inc  [HL]                                          ;; 00:31bc $34
    ret                                                ;; 00:31bd $c9
.jr_00_31be:
    ld   A, L                                          ;; 00:31be $7d
    xor  A, $18                                        ;; 00:31bf $ee $18
    ld   L, A                                          ;; 00:31c1 $6f
    set  7, [HL]                                       ;; 00:31c2 $cb $fe
.jp_00_31c4:
    push HL                                            ;; 00:31c4 $e5
    ld   A, L                                          ;; 00:31c5 $7d
    xor  A, $17                                        ;; 00:31c6 $ee $17
    ld   L, A                                          ;; 00:31c8 $6f
    ld   A, [HL]                                       ;; 00:31c9 $7e
    pop  HL                                            ;; 00:31ca $e1
    cp   A, $17                                        ;; 00:31cb $fe $17
    jr   Z, .jr_00_31d4                                ;; 00:31cd $28 $05
    bit  3, [HL]                                       ;; 00:31cf $cb $5e
    ret  Z                                             ;; 00:31d1 $c8
    res  0, [HL]                                       ;; 00:31d2 $cb $86
.jr_00_31d4:
    ld   A, L                                          ;; 00:31d4 $7d
    xor  A, $0b                                        ;; 00:31d5 $ee $0b
    ld   L, A                                          ;; 00:31d7 $6f
    xor  A, A                                          ;; 00:31d8 $af
    ld   [HL+], A                                      ;; 00:31d9 $22
    ld   [HL+], A                                      ;; 00:31da $22
    ld   [HL+], A                                      ;; 00:31db $22
    ld   [HL], A                                       ;; 00:31dc $77
    ret                                                ;; 00:31dd $c9
.jr_00_31de:
    call call_00_3460                                  ;; 00:31de $cd $60 $34
    ld   H, $d2                                        ;; 00:31e1 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:31e3 $fa $00 $d3
    or   A, $0e                                        ;; 00:31e6 $f6 $0e
    ld   L, A                                          ;; 00:31e8 $6f
    ld   A, [HL+]                                      ;; 00:31e9 $2a
    sub  A, E                                          ;; 00:31ea $93
    ld   A, [HL]                                       ;; 00:31eb $7e
    sbc  A, D                                          ;; 00:31ec $9a
    jr   C, .jr_00_31fa                                ;; 00:31ed $38 $0b
    ld   A, L                                          ;; 00:31ef $7d
    xor  A, $14                                        ;; 00:31f0 $ee $14
    ld   L, A                                          ;; 00:31f2 $6f
    ld   A, [HL+]                                      ;; 00:31f3 $2a
    cpl                                                ;; 00:31f4 $2f
    inc  A                                             ;; 00:31f5 $3c
    cp   A, [HL]                                       ;; 00:31f6 $be
    ret  Z                                             ;; 00:31f7 $c8
    dec  [HL]                                          ;; 00:31f8 $35
    ret                                                ;; 00:31f9 $c9
.jr_00_31fa:
    ld   A, L                                          ;; 00:31fa $7d
    xor  A, $18                                        ;; 00:31fb $ee $18
    ld   L, A                                          ;; 00:31fd $6f
    res  7, [HL]                                       ;; 00:31fe $cb $be
    jr   .jp_00_31c4                                   ;; 00:3200 $18 $c2
.jr_00_3202:
    bit  6, [HL]                                       ;; 00:3202 $cb $76
    jr   NZ, .jr_00_322a                               ;; 00:3204 $20 $24
    call call_00_34ba                                  ;; 00:3206 $cd $ba $34
    ld   H, $d2                                        ;; 00:3209 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:320b $fa $00 $d3
    or   A, $10                                        ;; 00:320e $f6 $10
    ld   L, A                                          ;; 00:3210 $6f
    ld   A, [HL+]                                      ;; 00:3211 $2a
    sub  A, E                                          ;; 00:3212 $93
    ld   A, [HL]                                       ;; 00:3213 $7e
    sbc  A, D                                          ;; 00:3214 $9a
    jr   NC, .jr_00_3222                               ;; 00:3215 $30 $0b
    ld   A, L                                          ;; 00:3217 $7d
    xor  A, $0a                                        ;; 00:3218 $ee $0a
    ld   L, A                                          ;; 00:321a $6f
    ld   A, [HL+]                                      ;; 00:321b $2a
    inc  L                                             ;; 00:321c $2c
    inc  L                                             ;; 00:321d $2c
    cp   A, [HL]                                       ;; 00:321e $be
    ret  Z                                             ;; 00:321f $c8
    inc  [HL]                                          ;; 00:3220 $34
    ret                                                ;; 00:3221 $c9
.jr_00_3222:
    ld   A, L                                          ;; 00:3222 $7d
    xor  A, $06                                        ;; 00:3223 $ee $06
    ld   L, A                                          ;; 00:3225 $6f
    set  6, [HL]                                       ;; 00:3226 $cb $f6
    jr   .jp_00_31c4                                   ;; 00:3228 $18 $9a
.jr_00_322a:
    call call_00_349c                                  ;; 00:322a $cd $9c $34
    ld   H, $d2                                        ;; 00:322d $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:322f $fa $00 $d3
    or   A, $10                                        ;; 00:3232 $f6 $10
    ld   L, A                                          ;; 00:3234 $6f
    ld   A, [HL+]                                      ;; 00:3235 $2a
    sub  A, E                                          ;; 00:3236 $93
    ld   A, [HL]                                       ;; 00:3237 $7e
    sbc  A, D                                          ;; 00:3238 $9a
    jr   C, .jr_00_3248                                ;; 00:3239 $38 $0d
    ld   A, L                                          ;; 00:323b $7d
    xor  A, $0a                                        ;; 00:323c $ee $0a
    ld   L, A                                          ;; 00:323e $6f
    ld   A, [HL+]                                      ;; 00:323f $2a
    cpl                                                ;; 00:3240 $2f
    inc  A                                             ;; 00:3241 $3c
    inc  L                                             ;; 00:3242 $2c
    inc  L                                             ;; 00:3243 $2c
    cp   A, [HL]                                       ;; 00:3244 $be
    ret  Z                                             ;; 00:3245 $c8
    dec  [HL]                                          ;; 00:3246 $35
    ret                                                ;; 00:3247 $c9
.jr_00_3248:
    ld   A, L                                          ;; 00:3248 $7d
    xor  A, $06                                        ;; 00:3249 $ee $06
    ld   L, A                                          ;; 00:324b $6f
    res  6, [HL]                                       ;; 00:324c $cb $b6
    jp   .jp_00_31c4                                   ;; 00:324e $c3 $c4 $31
    db   $26, $d2, $fa, $00, $d3, $f6, $0d, $6f        ;; 00:3251 ????????
    db   $4e, $ee, $16, $6f, $2a, $cb, $69, $28        ;; 00:3259 ????????
    db   $08, $2f, $3c, $be, $28, $07, $35, $18        ;; 00:3261 ????????
    db   $04, $be, $28, $01, $34, $2a, $4f, $7e        ;; 00:3269 ????????
    db   $e6, $0f, $81, $77, $cb, $2f, $cb, $2f        ;; 00:3271 ????????
    db   $cb, $2f, $cb, $2f, $4f, $fe, $80, $3e        ;; 00:3279 ????????
    db   $ff, $ce, $00, $47, $7d, $ee, $13, $6f        ;; 00:3281 ????????
    db   $7e, $81, $22, $7e, $88, $77, $c9, $26        ;; 00:3289 ????????
    db   $d2, $fa, $00, $d3, $f6, $0d, $6f, $71        ;; 00:3291 ????????
    db   $c9, $26, $d2, $fa, $00, $d3, $f6, $0d        ;; 00:3299 ????????
    db   $6f, $4e, $7d, $ee, $11, $6f, $2a, $cb        ;; 00:32a1 ????????
    db   $69, $28, $02, $2f, $3c, $86, $4f, $e6        ;; 00:32a9 ????????
    db   $0f, $77, $79, $cb, $2f, $cb, $2f, $cb        ;; 00:32b1 ????????
    db   $2f, $cb, $2f, $4f, $fe, $80, $3e, $ff        ;; 00:32b9 ????????
    db   $ce, $00, $47, $c5, $7d, $ee, $06, $6f        ;; 00:32c1 ????????
    db   $79, $86, $32, $cb, $7f, $28, $02, $2f        ;; 00:32c9 ????????
    db   $3c, $be, $38, $08, $7d, $ee, $17, $6f        ;; 00:32d1 ????????
    db   $7e, $ee, $20, $77, $c1, $c3, $c9, $37        ;; 00:32d9 ????????

call_00_32e1:
    ld   H, $d2                                        ;; 00:32e1 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:32e3 $fa $00 $d3
    or   A, $1c                                        ;; 00:32e6 $f6 $1c
    ld   L, A                                          ;; 00:32e8 $6f
    ld   A, [HL]                                       ;; 00:32e9 $7e
    cp   A, C                                          ;; 00:32ea $b9
    ret  Z                                             ;; 00:32eb $c8
    jr   C, .jr_00_32f0                                ;; 00:32ec $38 $02
    dec  [HL]                                          ;; 00:32ee $35
    ret                                                ;; 00:32ef $c9
.jr_00_32f0:
    inc  [HL]                                          ;; 00:32f0 $34
    ret                                                ;; 00:32f1 $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $1c, $6f        ;; 00:32f2 ????????
    db   $cb, $79, $20, $0b, $cb, $7e, $20, $12        ;; 00:32fa ????????
    db   $7e, $b9, $c8, $38, $0d, $18, $09, $cb        ;; 00:3302 ????????
    db   $7e, $28, $05, $7e, $b9, $c8, $38, $02        ;; 00:330a ????????
    db   $35, $c9, $34, $c9, $26, $d2, $fa, $00        ;; 00:3312 ????????
    db   $d3, $f6, $1e, $6f, $cb, $79, $20, $0b        ;; 00:331a ????????
    db   $cb, $7e, $20, $12, $7e, $b9, $c8, $38        ;; 00:3322 ????????
    db   $0d, $18, $09, $cb, $7e, $28, $05, $7e        ;; 00:332a ????????
    db   $b9, $c8, $38, $02, $35, $c9, $34, $c9        ;; 00:3332 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $1c, $6f        ;; 00:333a ????????
    db   $7e, $a7, $c9, $26, $d2, $fa, $00, $d3        ;; 00:3342 ????????
    db   $f6, $1e, $6f, $7e, $a7, $c9, $26, $d2        ;; 00:334a ????????
    db   $fa, $00, $d3, $f6, $1c, $6f, $71, $c9        ;; 00:3352 ????????

call_00_335a:
    ld   H, $d2                                        ;; 00:335a $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:335c $fa $00 $d3
    or   A, $1e                                        ;; 00:335f $f6 $1e
    ld   L, A                                          ;; 00:3361 $6f
    ld   [HL], C                                       ;; 00:3362 $71
    ret                                                ;; 00:3363 $c9
    db   $fa, $00, $d3, $0f, $0f, $0f, $e6, $1c        ;; 00:3364 ????????
    db   $6f, $26, $00, $11, $09, $d3, $19, $46        ;; 00:336c ????????
    db   $05, $23, $4e, $0c, $26, $d2, $fa, $00        ;; 00:3374 ????????
    db   $d3, $f6, $0e, $6f, $2a, $66, $6f, $29        ;; 00:337c ????????
    db   $29, $29, $5c, $21, $6a, $d7, $7e, $b9        ;; 00:3384 ????????
    db   $38, $17, $78, $be, $38, $13, $7b, $be        ;; 00:338c ????????
    db   $28, $0f, $16, $00, $38, $02, $16, $20        ;; 00:3394 ????????
    db   $26, $d2, $fa, $00, $d3, $f6, $0d, $6f        ;; 00:339c ????????
    db   $72, $26, $d2, $fa, $00, $d3, $f6, $0d        ;; 00:33a4 ????????
    db   $6f, $cb, $6e, $28, $16, $7b, $b9, $38        ;; 00:33ac ????????
    db   $16, $36, $20, $7d, $ee, $11, $6f, $4e        ;; 00:33b4 ????????
    db   $ee, $12, $6f, $7e, $91, $22, $7e, $de        ;; 00:33bc ????????
    db   $00, $77, $c9, $7b, $b8, $30, $ea, $36        ;; 00:33c4 ????????
    db   $00, $7d, $ee, $11, $6f, $4e, $ee, $12        ;; 00:33cc ????????
    db   $6f, $7e, $81, $22, $7e, $ce, $00, $77        ;; 00:33d4 ????????
    db   $c9, $26, $d2, $fa, $00, $d3, $f6, $0a        ;; 00:33dc ????????
    db   $6f, $cb, $6e, $c8, $7d, $ee, $1d, $6f        ;; 00:33e4 ????????
    db   $cb, $4e, $28, $02, $18, $29, $26, $d2        ;; 00:33ec ????????
    db   $fa, $00, $d3, $f6, $1c, $6f, $4e, $2d        ;; 00:33f4 ????????
    db   $cb, $7e, $20, $0c, $7e, $81, $fe, $80        ;; 00:33fc ????????
    db   $38, $08, $d6, $7f, $2f, $3c, $81, $4f        ;; 00:3404 ????????
    db   $7e, $81, $77, $7d, $ee, $15, $6f, $7e        ;; 00:340c ????????
    db   $81, $22, $7e, $ce, $00, $77, $c9, $26        ;; 00:3414 ????????
    db   $d2, $fa, $00, $d3, $f6, $1c, $6f, $4e        ;; 00:341c ????????
    db   $2d, $cb, $7e, $28, $0a, $7e, $91, $fe        ;; 00:3424 ????????
    db   $80, $30, $06, $d6, $80, $81, $4f, $7e        ;; 00:342c ????????
    db   $91, $77, $7d, $ee, $15, $6f, $7e, $91        ;; 00:3434 ????????
    db   $22, $7e, $de, $00, $77, $c9, $26, $d2        ;; 00:343c ????????
    db   $fa, $00, $d3, $f6, $0d, $6f, $4e, $ee        ;; 00:3444 ????????
    db   $11, $6f, $7e, $cb, $69, $28, $02, $2f        ;; 00:344c ????????
    db   $3c, $4f, $fe, $80, $3e, $ff, $ce, $00        ;; 00:3454 ????????
    db   $47, $c3, $c9, $37                            ;; 00:345c ????

call_00_3460:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3460 $fa $00 $d3
    rrca                                               ;; 00:3463 $0f
    rrca                                               ;; 00:3464 $0f
    rrca                                               ;; 00:3465 $0f
    and  A, $1c                                        ;; 00:3466 $e6 $1c
    ld   L, A                                          ;; 00:3468 $6f
    ld   H, $00                                        ;; 00:3469 $26 $00
    ld   DE, wD30A                                     ;; 00:346b $11 $0a $d3
    add  HL, DE                                        ;; 00:346e $19
    ld   L, [HL]                                       ;; 00:346f $6e
    ld   H, $00                                        ;; 00:3470 $26 $00
    add  HL, HL                                        ;; 00:3472 $29
    add  HL, HL                                        ;; 00:3473 $29
    add  HL, HL                                        ;; 00:3474 $29
    add  HL, HL                                        ;; 00:3475 $29
    add  HL, HL                                        ;; 00:3476 $29
    ld   DE, $30                                       ;; 00:3477 $11 $30 $00
    add  HL, DE                                        ;; 00:347a $19
    ld   E, L                                          ;; 00:347b $5d
    ld   D, H                                          ;; 00:347c $54
    ret                                                ;; 00:347d $c9

call_00_347e:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:347e $fa $00 $d3
    rrca                                               ;; 00:3481 $0f
    rrca                                               ;; 00:3482 $0f
    rrca                                               ;; 00:3483 $0f
    and  A, $1c                                        ;; 00:3484 $e6 $1c
    ld   L, A                                          ;; 00:3486 $6f
    ld   H, $00                                        ;; 00:3487 $26 $00
    ld   DE, wD309                                     ;; 00:3489 $11 $09 $d3
    add  HL, DE                                        ;; 00:348c $19
    ld   L, [HL]                                       ;; 00:348d $6e
    ld   H, $00                                        ;; 00:348e $26 $00
    add  HL, HL                                        ;; 00:3490 $29
    add  HL, HL                                        ;; 00:3491 $29
    add  HL, HL                                        ;; 00:3492 $29
    add  HL, HL                                        ;; 00:3493 $29
    add  HL, HL                                        ;; 00:3494 $29
    ld   DE, hFFF0                                     ;; 00:3495 $11 $f0 $ff
    add  HL, DE                                        ;; 00:3498 $19
    ld   E, L                                          ;; 00:3499 $5d
    ld   D, H                                          ;; 00:349a $54
    ret                                                ;; 00:349b $c9

call_00_349c:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:349c $fa $00 $d3
    rrca                                               ;; 00:349f $0f
    rrca                                               ;; 00:34a0 $0f
    rrca                                               ;; 00:34a1 $0f
    and  A, $1c                                        ;; 00:34a2 $e6 $1c
    ld   L, A                                          ;; 00:34a4 $6f
    ld   H, $00                                        ;; 00:34a5 $26 $00
    ld   DE, wD30C                                     ;; 00:34a7 $11 $0c $d3
    add  HL, DE                                        ;; 00:34aa $19
    ld   L, [HL]                                       ;; 00:34ab $6e
    ld   H, $00                                        ;; 00:34ac $26 $00
    add  HL, HL                                        ;; 00:34ae $29
    add  HL, HL                                        ;; 00:34af $29
    add  HL, HL                                        ;; 00:34b0 $29
    add  HL, HL                                        ;; 00:34b1 $29
    add  HL, HL                                        ;; 00:34b2 $29
    ld   DE, $30                                       ;; 00:34b3 $11 $30 $00
    add  HL, DE                                        ;; 00:34b6 $19
    ld   E, L                                          ;; 00:34b7 $5d
    ld   D, H                                          ;; 00:34b8 $54
    ret                                                ;; 00:34b9 $c9

call_00_34ba:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:34ba $fa $00 $d3
    rrca                                               ;; 00:34bd $0f
    rrca                                               ;; 00:34be $0f
    rrca                                               ;; 00:34bf $0f
    and  A, $1c                                        ;; 00:34c0 $e6 $1c
    ld   L, A                                          ;; 00:34c2 $6f
    ld   H, $00                                        ;; 00:34c3 $26 $00
    ld   DE, wD30B                                     ;; 00:34c5 $11 $0b $d3
    add  HL, DE                                        ;; 00:34c8 $19
    ld   L, [HL]                                       ;; 00:34c9 $6e
    ld   H, $00                                        ;; 00:34ca $26 $00
    add  HL, HL                                        ;; 00:34cc $29
    add  HL, HL                                        ;; 00:34cd $29
    add  HL, HL                                        ;; 00:34ce $29
    add  HL, HL                                        ;; 00:34cf $29
    add  HL, HL                                        ;; 00:34d0 $29
    ld   DE, hFFF0                                     ;; 00:34d1 $11 $f0 $ff
    add  HL, DE                                        ;; 00:34d4 $19
    ld   E, L                                          ;; 00:34d5 $5d
    ld   D, H                                          ;; 00:34d6 $54
    ret                                                ;; 00:34d7 $c9

call_00_34d8:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:34d8 $fa $00 $d3
    rlca                                               ;; 00:34db $07
    rlca                                               ;; 00:34dc $07
    rlca                                               ;; 00:34dd $07
    and  A, $07                                        ;; 00:34de $e6 $07
    ld   L, A                                          ;; 00:34e0 $6f
    ld   H, $00                                        ;; 00:34e1 $26 $00
    ld   DE, wD301                                     ;; 00:34e3 $11 $01 $d3
    add  HL, DE                                        ;; 00:34e6 $19
    ld   [HL], $00                                     ;; 00:34e7 $36 $00
    ret                                                ;; 00:34e9 $c9

call_00_34ea:
    ld   H, $d2                                        ;; 00:34ea $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:34ec $fa $00 $d3
    or   A, $09                                        ;; 00:34ef $f6 $09
    ld   L, A                                          ;; 00:34f1 $6f
    bit  5, [HL]                                       ;; 00:34f2 $cb $6e
    ret                                                ;; 00:34f4 $c9

call_00_34f5:
    ld   H, $d2                                        ;; 00:34f5 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:34f7 $fa $00 $d3
    or   A, $17                                        ;; 00:34fa $f6 $17
    ld   L, A                                          ;; 00:34fc $6f
    ld   A, [wD74D]                                    ;; 00:34fd $fa $4d $d7
    ld   B, A                                          ;; 00:3500 $47
    and  A, A                                          ;; 00:3501 $a7
    ret  Z                                             ;; 00:3502 $c8
    ld   A, L                                          ;; 00:3503 $7d
    and  A, $e0                                        ;; 00:3504 $e6 $e0
    cp   A, B                                          ;; 00:3506 $b8
    ld   B, $00                                        ;; 00:3507 $06 $00
    ret  NZ                                            ;; 00:3509 $c0
    inc  B                                             ;; 00:350a $04
    ret                                                ;; 00:350b $c9

call_00_350c:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:350c $fa $00 $d3
    rrca                                               ;; 00:350f $0f
    rrca                                               ;; 00:3510 $0f
    rrca                                               ;; 00:3511 $0f
    ld   L, A                                          ;; 00:3512 $6f
    ld   H, $00                                        ;; 00:3513 $26 $00
    ld   BC, wD309                                     ;; 00:3515 $01 $09 $d3
    add  HL, BC                                        ;; 00:3518 $09
    ld   B, [HL]                                       ;; 00:3519 $46
    inc  HL                                            ;; 00:351a $23
    ld   C, [HL]                                       ;; 00:351b $4e
    inc  HL                                            ;; 00:351c $23
    ld   D, [HL]                                       ;; 00:351d $56
    inc  HL                                            ;; 00:351e $23
    ld   E, [HL]                                       ;; 00:351f $5e
    ld   HL, wD329                                     ;; 00:3520 $21 $29 $d3
    ld   A, B                                          ;; 00:3523 $78
    cp   A, [HL]                                       ;; 00:3524 $be
    ret  C                                             ;; 00:3525 $d8
    inc  HL                                            ;; 00:3526 $23
    ld   A, [HL+]                                      ;; 00:3527 $2a
    cp   A, C                                          ;; 00:3528 $b9
    ret  C                                             ;; 00:3529 $d8
    ld   A, D                                          ;; 00:352a $7a
    cp   A, [HL]                                       ;; 00:352b $be
    ret  C                                             ;; 00:352c $d8
    inc  HL                                            ;; 00:352d $23
    ld   A, [HL]                                       ;; 00:352e $7e
    cp   A, E                                          ;; 00:352f $bb
    ret                                                ;; 00:3530 $c9
    db   $fa, $00, $d3, $0f, $0f, $0f, $e6, $1c        ;; 00:3531 ????????
    db   $6f, $26, $00, $11, $09, $d3, $19, $46        ;; 00:3539 ????????
    db   $05, $23, $4e, $0c, $26, $d2, $fa, $00        ;; 00:3541 ????????
    db   $d3, $f6, $0e, $6f, $2a, $66, $6f, $29        ;; 00:3549 ????????
    db   $29, $29, $7c, $b9, $d8, $78, $bc, $c9        ;; 00:3551 ????????

call_00_3559:
    ld   H, $d2                                        ;; 00:3559 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:355b $fa $00 $d3
    or   A, $1c                                        ;; 00:355e $f6 $1c
    ld   L, A                                          ;; 00:3560 $6f
    ld   A, [HL+]                                      ;; 00:3561 $2a
    ld   C, A                                          ;; 00:3562 $4f
    ld   A, [HL]                                       ;; 00:3563 $7e
    and  A, $0f                                        ;; 00:3564 $e6 $0f
    add  A, C                                          ;; 00:3566 $81
    ld   [HL+], A                                      ;; 00:3567 $22
    sra  A                                             ;; 00:3568 $cb $2f
    sra  A                                             ;; 00:356a $cb $2f
    sra  A                                             ;; 00:356c $cb $2f
    sra  A                                             ;; 00:356e $cb $2f
    ld   C, A                                          ;; 00:3570 $4f
    cp   A, $80                                        ;; 00:3571 $fe $80
    ld   A, $ff                                        ;; 00:3573 $3e $ff
    adc  A, $00                                        ;; 00:3575 $ce $00
    ld   B, A                                          ;; 00:3577 $47
    push BC                                            ;; 00:3578 $c5
    ld   A, [HL+]                                      ;; 00:3579 $2a
    ld   C, A                                          ;; 00:357a $4f
    ld   A, [HL]                                       ;; 00:357b $7e
    and  A, $0f                                        ;; 00:357c $e6 $0f
    add  A, C                                          ;; 00:357e $81
    ld   [HL], A                                       ;; 00:357f $77
    sra  A                                             ;; 00:3580 $cb $2f
    sra  A                                             ;; 00:3582 $cb $2f
    sra  A                                             ;; 00:3584 $cb $2f
    sra  A                                             ;; 00:3586 $cb $2f
    ld   C, A                                          ;; 00:3588 $4f
    cp   A, $80                                        ;; 00:3589 $fe $80
    ld   A, $ff                                        ;; 00:358b $3e $ff
    adc  A, $00                                        ;; 00:358d $ce $00
    ld   B, A                                          ;; 00:358f $47
    call call_00_37d8                                  ;; 00:3590 $cd $d8 $37
    pop  BC                                            ;; 00:3593 $c1
    jp   .jp_00_35d5                                   ;; 00:3594 $c3 $d5 $35
    db   $26, $d2, $fa, $00, $d3, $f6, $1c, $6f        ;; 00:3597 ????????
    db   $2a, $4f, $7e, $e6, $0f, $81, $22, $cb        ;; 00:359f ????????
    db   $2f, $cb, $2f, $cb, $2f, $cb, $2f, $4f        ;; 00:35a7 ????????
    db   $fe, $80, $3e, $ff, $ce, $00, $47, $c5        ;; 00:35af ????????
    db   $2a, $4f, $7e, $e6, $0f, $81, $77, $cb        ;; 00:35b7 ????????
    db   $2f, $cb, $2f, $cb, $2f, $cb, $2f, $4f        ;; 00:35bf ????????
    db   $fe, $80, $3e, $ff, $ce, $00, $47, $cd        ;; 00:35c7 ????????
    db   $d8, $37, $c1, $c3, $c9, $37                  ;; 00:35cf ??????
.jp_00_35d5:
    ld   H, $d2                                        ;; 00:35d5 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:35d7 $fa $00 $d3
    or   A, $0e                                        ;; 00:35da $f6 $0e
    ld   L, A                                          ;; 00:35dc $6f
    ld   A, [HL]                                       ;; 00:35dd $7e
    add  A, C                                          ;; 00:35de $81
    ld   [HL+], A                                      ;; 00:35df $22
    ld   E, A                                          ;; 00:35e0 $5f
    ld   A, [HL]                                       ;; 00:35e1 $7e
    adc  A, B                                          ;; 00:35e2 $88
    ld   [HL], A                                       ;; 00:35e3 $77
    ld   D, A                                          ;; 00:35e4 $57
    ld   A, L                                          ;; 00:35e5 $7d
    and  A, $e0                                        ;; 00:35e6 $e6 $e0
    ld   HL, wD74D                                     ;; 00:35e8 $21 $4d $d7
    cp   A, [HL]                                       ;; 00:35eb $be
    jr   NZ, .jr_00_35f3                               ;; 00:35ec $20 $05
    ld   A, C                                          ;; 00:35ee $79
    ld   [wD75C], A                                    ;; 00:35ef $ea $5c $d7
    ret                                                ;; 00:35f2 $c9
.jr_00_35f3:
    ld   HL, wD74F                                     ;; 00:35f3 $21 $4f $d7
    cp   A, [HL]                                       ;; 00:35f6 $be
    ret  NZ                                            ;; 00:35f7 $c0
    ld   H, $d2                                        ;; 00:35f8 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:35fa $fa $00 $d3
    or   A, $12                                        ;; 00:35fd $f6 $12
    ld   L, A                                          ;; 00:35ff $6f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 00:3600 $fa $12 $d2
    cp   A, [HL]                                       ;; 00:3603 $be
    jr   C, .jr_00_3616                                ;; 00:3604 $38 $10
    ld   A, L                                          ;; 00:3606 $7d
    xor  A, $06                                        ;; 00:3607 $ee $06
    ld   L, A                                          ;; 00:3609 $6f
    ld   A, E                                          ;; 00:360a $7b
    add  A, [HL]                                       ;; 00:360b $86
    ld   [wD20E_PlayerXPosition], A                                    ;; 00:360c $ea $0e $d2
    ld   A, D                                          ;; 00:360f $7a
    adc  A, $00                                        ;; 00:3610 $ce $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 00:3612 $ea $0f $d2
    ret                                                ;; 00:3615 $c9
.jr_00_3616:
    ld   A, L                                          ;; 00:3616 $7d
    xor  A, $06                                        ;; 00:3617 $ee $06
    ld   L, A                                          ;; 00:3619 $6f
    ld   C, [HL]                                       ;; 00:361a $4e
    inc  C                                             ;; 00:361b $0c
    ld   A, E                                          ;; 00:361c $7b
    sub  A, C                                          ;; 00:361d $91
    ld   [wD20E_PlayerXPosition], A                                    ;; 00:361e $ea $0e $d2
    ld   A, D                                          ;; 00:3621 $7a
    sbc  A, $00                                        ;; 00:3622 $de $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 00:3624 $ea $0f $d2
    ret                                                ;; 00:3627 $c9

call_00_3628:
    ld   A, [wD74D]                                    ;; 00:3628 $fa $4d $d7
    ld   [wD9C7], A                                    ;; 00:362b $ea $c7 $d9
    ld   A, [wD74E]                                    ;; 00:362e $fa $4e $d7
    ld   [wD9C8], A                                    ;; 00:3631 $ea $c8 $d9
    ld   A, [wD74F]                                    ;; 00:3634 $fa $4f $d7
    ld   [wD9C9], A                                    ;; 00:3637 $ea $c9 $d9
    ld   A, [wD688]                                    ;; 00:363a $fa $88 $d6
    ld   [wD9CA], A                                    ;; 00:363d $ea $ca $d9
    ld   A, $a0                                        ;; 00:3640 $3e $a0
    ld   [wD688], A                                    ;; 00:3642 $ea $88 $d6
    ld   HL, wD000_ObjectFlags                                     ;; 00:3645 $21 $00 $d0
    ld   DE, wD79F                                     ;; 00:3648 $11 $9f $d7
    ld   BC, $100                                      ;; 00:364b $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:364e $cd $b0 $07
    ld   HL, wD200_PlayerObject_Id                                     ;; 00:3651 $21 $00 $d2
    ld   DE, wD89F                                     ;; 00:3654 $11 $9f $d8
    ld   BC, $100                                      ;; 00:3657 $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:365a $cd $b0 $07
    ld   HL, wD301                                     ;; 00:365d $21 $01 $d3
    ld   DE, wD99F                                     ;; 00:3660 $11 $9f $d9
    ld   BC, $08                                       ;; 00:3663 $01 $08 $00
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:3666 $cd $b0 $07
    ld   HL, wD309                                     ;; 00:3669 $21 $09 $d3
    ld   DE, wD9A7                                     ;; 00:366c $11 $a7 $d9
    ld   BC, $20                                       ;; 00:366f $01 $20 $00
    jp   call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:3672 $c3 $b0 $07

call_00_3675:
    ld   A, [wD9C7]                                    ;; 00:3675 $fa $c7 $d9
    ld   [wD74D], A                                    ;; 00:3678 $ea $4d $d7
    ld   A, [wD9C8]                                    ;; 00:367b $fa $c8 $d9
    ld   [wD74E], A                                    ;; 00:367e $ea $4e $d7
    ld   A, [wD9C9]                                    ;; 00:3681 $fa $c9 $d9
    ld   [wD74F], A                                    ;; 00:3684 $ea $4f $d7
    ld   A, [wD9CA]                                    ;; 00:3687 $fa $ca $d9
    ld   [wD688], A                                    ;; 00:368a $ea $88 $d6
    ld   HL, wD79F                                     ;; 00:368d $21 $9f $d7
    ld   DE, wD000_ObjectFlags                                     ;; 00:3690 $11 $00 $d0
    ld   BC, $100                                      ;; 00:3693 $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:3696 $cd $b0 $07
    ld   HL, wD89F                                     ;; 00:3699 $21 $9f $d8
    ld   DE, wD200_PlayerObject_Id                                     ;; 00:369c $11 $00 $d2
    ld   BC, $100                                      ;; 00:369f $01 $00 $01
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:36a2 $cd $b0 $07
    ld   HL, wD99F                                     ;; 00:36a5 $21 $9f $d9
    ld   DE, wD301                                     ;; 00:36a8 $11 $01 $d3
    ld   BC, $08                                       ;; 00:36ab $01 $08 $00
    call call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:36ae $cd $b0 $07
    ld   HL, wD9A7                                     ;; 00:36b1 $21 $a7 $d9
    ld   DE, wD309                                     ;; 00:36b4 $11 $09 $d3
    ld   BC, $20                                       ;; 00:36b7 $01 $20 $00
    jp   call_00_07b0_CopyBCBytesFromHLToDE                                  ;; 00:36ba $c3 $b0 $07

call_00_36bd:
    ld   H, $d2                                        ;; 00:36bd $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:36bf $fa $00 $d3
    or   A, $0e                                        ;; 00:36c2 $f6 $0e
    ld   L, A                                          ;; 00:36c4 $6f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:36c5 $fa $0e $d2
    sub  A, [HL]                                       ;; 00:36c8 $96
    inc  HL                                            ;; 00:36c9 $23
    ld   A, [wD20F_PlayerXPosition]                                    ;; 00:36ca $fa $0f $d2
    sbc  A, [HL]                                       ;; 00:36cd $9e
    ld   C, $20                                        ;; 00:36ce $0e $20
    jr   C, .jr_00_36d4                                ;; 00:36d0 $38 $02
    ld   C, $00                                        ;; 00:36d2 $0e $00
.jr_00_36d4:
    ld   A, L                                          ;; 00:36d4 $7d
    xor  A, $02                                        ;; 00:36d5 $ee $02
    ld   L, A                                          ;; 00:36d7 $6f
    ld   [HL], C                                       ;; 00:36d8 $71
    ret                                                ;; 00:36d9 $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $0e, $6f        ;; 00:36da ????????
    db   $fa, $0e, $d2, $96, $23, $fa, $0f, $d2        ;; 00:36e2 ????????
    db   $9e, $0e, $00, $38, $02, $0e, $20, $7d        ;; 00:36ea ????????
    db   $ee, $02, $6f, $71, $c9                       ;; 00:36f2 ?????

call_00_36f7:
    ld   H, $d2                                        ;; 00:36f7 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:36f9 $fa $00 $d3
    or   A, $0d                                        ;; 00:36fc $f6 $0d
    ld   L, A                                          ;; 00:36fe $6f
    ld   C, [HL]                                       ;; 00:36ff $4e
    ld   A, L                                          ;; 00:3700 $7d
    xor  A, $11                                        ;; 00:3701 $ee $11
    ld   L, A                                          ;; 00:3703 $6f
    ld   A, [HL+]                                      ;; 00:3704 $2a
    bit  5, C                                          ;; 00:3705 $cb $69
    jr   Z, .jr_00_370b                                ;; 00:3707 $28 $02
    cpl                                                ;; 00:3709 $2f
    inc  A                                             ;; 00:370a $3c
.jr_00_370b:
    add  A, [HL]                                       ;; 00:370b $86
    ld   C, A                                          ;; 00:370c $4f
    and  A, $0f                                        ;; 00:370d $e6 $0f
    ld   [HL], A                                       ;; 00:370f $77
    ld   A, C                                          ;; 00:3710 $79
    sra  A                                             ;; 00:3711 $cb $2f
    sra  A                                             ;; 00:3713 $cb $2f
    sra  A                                             ;; 00:3715 $cb $2f
    sra  A                                             ;; 00:3717 $cb $2f
    ld   C, A                                          ;; 00:3719 $4f
    cp   A, $80                                        ;; 00:371a $fe $80
    ld   A, $ff                                        ;; 00:371c $3e $ff
    adc  A, $00                                        ;; 00:371e $ce $00
    ld   B, A                                          ;; 00:3720 $47
    ld   A, L                                          ;; 00:3721 $7d
    xor  A, $13                                        ;; 00:3722 $ee $13
    ld   L, A                                          ;; 00:3724 $6f
    ld   A, [HL]                                       ;; 00:3725 $7e
    add  A, C                                          ;; 00:3726 $81
    ld   [HL+], A                                      ;; 00:3727 $22
    ld   C, A                                          ;; 00:3728 $4f
    ld   A, [HL]                                       ;; 00:3729 $7e
    adc  A, B                                          ;; 00:372a $88
    ld   [HL], A                                       ;; 00:372b $77
    ld   L, C                                          ;; 00:372c $69
    ld   H, A                                          ;; 00:372d $67
    add  HL, HL                                        ;; 00:372e $29
    add  HL, HL                                        ;; 00:372f $29
    add  HL, HL                                        ;; 00:3730 $29
    ld   D, H                                          ;; 00:3731 $54
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3732 $fa $00 $d3
    rrca                                               ;; 00:3735 $0f
    rrca                                               ;; 00:3736 $0f
    rrca                                               ;; 00:3737 $0f
    and  A, $1c                                        ;; 00:3738 $e6 $1c
    ld   L, A                                          ;; 00:373a $6f
    ld   H, $00                                        ;; 00:373b $26 $00
    ld   BC, wD309                                     ;; 00:373d $01 $09 $d3
    add  HL, BC                                        ;; 00:3740 $09
    ld   B, [HL]                                       ;; 00:3741 $46
    dec  B                                             ;; 00:3742 $05
    inc  HL                                            ;; 00:3743 $23
    ld   C, [HL]                                       ;; 00:3744 $4e
    inc  C                                             ;; 00:3745 $0c
    ld   A, D                                          ;; 00:3746 $7a
    cp   A, C                                          ;; 00:3747 $b9
    ld   C, $00                                        ;; 00:3748 $0e $00
    jr   C, .jr_00_3754                                ;; 00:374a $38 $08
    ld   A, B                                          ;; 00:374c $78
    cp   A, D                                          ;; 00:374d $ba
    ld   C, $20                                        ;; 00:374e $0e $20
    jr   C, .jr_00_3754                                ;; 00:3750 $38 $02
    xor  A, A                                          ;; 00:3752 $af
    ret                                                ;; 00:3753 $c9
.jr_00_3754:
    ld   H, $d2                                        ;; 00:3754 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3756 $fa $00 $d3
    or   A, $0d                                        ;; 00:3759 $f6 $0d
    ld   L, A                                          ;; 00:375b $6f
    ld   A, [HL]                                       ;; 00:375c $7e
    ld   [HL], C                                       ;; 00:375d $71
    cp   A, C                                          ;; 00:375e $b9
    ret                                                ;; 00:375f $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $0d, $6f        ;; 00:3760 ????????
    db   $4e, $7d, $ee, $11, $6f, $2a, $cb, $71        ;; 00:3768 ????????
    db   $20, $02, $2f, $3c, $86, $4f, $e6, $0f        ;; 00:3770 ????????
    db   $77, $79, $cb, $2f, $cb, $2f, $cb, $2f        ;; 00:3778 ????????
    db   $cb, $2f, $4f, $fe, $80, $3e, $ff, $ce        ;; 00:3780 ????????
    db   $00, $47, $7d, $ee, $0d, $6f, $7e, $81        ;; 00:3788 ????????
    db   $22, $4f, $7e, $88, $77, $69, $67, $29        ;; 00:3790 ????????
    db   $29, $29, $54, $fa, $00, $d3, $0f, $0f        ;; 00:3798 ????????
    db   $0f, $e6, $1c, $6f, $26, $00, $01, $0b        ;; 00:37a0 ????????
    db   $d3, $09, $46, $05, $23, $4e, $0c, $7a        ;; 00:37a8 ????????
    db   $b9, $0e, $40, $38, $08, $78, $ba, $0e        ;; 00:37b0 ????????
    db   $00, $38, $02, $af, $c9, $26, $d2, $fa        ;; 00:37b8 ????????
    db   $00, $d3, $f6, $0d, $6f, $7e, $71, $b9        ;; 00:37c0 ????????
    db   $c9, $26, $d2, $fa, $00, $d3, $f6, $0e        ;; 00:37c8 ????????
    db   $6f, $7e, $81, $22, $7e, $88, $77, $c9        ;; 00:37d0 ????????

call_00_37d8:
    ld   H, $d2                                        ;; 00:37d8 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:37da $fa $00 $d3
    or   A, $10                                        ;; 00:37dd $f6 $10
    ld   L, A                                          ;; 00:37df $6f
    ld   A, [HL]                                       ;; 00:37e0 $7e
    add  A, C                                          ;; 00:37e1 $81
    ld   [HL+], A                                      ;; 00:37e2 $22
    ld   A, [HL]                                       ;; 00:37e3 $7e
    adc  A, B                                          ;; 00:37e4 $88
    ld   [HL], A                                       ;; 00:37e5 $77
    ret                                                ;; 00:37e6 $c9

call_00_37e7:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:37e7 $fa $00 $d3
    rlca                                               ;; 00:37ea $07
    rlca                                               ;; 00:37eb $07
    rlca                                               ;; 00:37ec $07
    and  A, $07                                        ;; 00:37ed $e6 $07
    ld   L, A                                          ;; 00:37ef $6f
    ld   H, $00                                        ;; 00:37f0 $26 $00
    ld   DE, wD32D                                     ;; 00:37f2 $11 $2d $d3
    add  HL, DE                                        ;; 00:37f5 $19
    ld   [HL], C                                       ;; 00:37f6 $71
    ret                                                ;; 00:37f7 $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $17, $6f        ;; 00:37f8 ????????
    db   $71, $c9                                      ;; 00:3800 ??

call_00_3802:
    ld   H, $d2                                        ;; 00:3802 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3804 $fa $00 $d3
    or   A, $18                                        ;; 00:3807 $f6 $18
    ld   L, A                                          ;; 00:3809 $6f
    ld   [HL], C                                       ;; 00:380a $71
    ret                                                ;; 00:380b $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $18, $6f        ;; 00:380c ????????
    db   $7e, $a7, $c9                                 ;; 00:3814 ???

call_00_3817:
    ld   H, $d2                                        ;; 00:3817 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3819 $fa $00 $d3
    or   A, $18                                        ;; 00:381c $f6 $18
    ld   L, A                                          ;; 00:381e $6f
    ld   A, [HL]                                       ;; 00:381f $7e
    and  A, A                                          ;; 00:3820 $a7
    ret  Z                                             ;; 00:3821 $c8
    dec  [HL]                                          ;; 00:3822 $35
    ld   A, [HL]                                       ;; 00:3823 $7e
    ret                                                ;; 00:3824 $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $16, $6f        ;; 00:3825 ????????
    db   $71, $c9, $26, $d2, $fa, $00, $d3, $f6        ;; 00:382d ????????
    db   $14, $6f, $71, $c9, $26, $d2, $fa, $00        ;; 00:3835 ????????
    db   $d3, $f6, $07, $6f, $7e, $c9                  ;; 00:383d ??????

call_00_3843:
    ld   H, $d2                                        ;; 00:3843 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3845 $fa $00 $d3
    or   A, $0a                                        ;; 00:3848 $f6 $0a
    ld   L, A                                          ;; 00:384a $6f
    bit  2, [HL]                                       ;; 00:384b $cb $56
    ret                                                ;; 00:384d $c9
    db   $26, $d2, $fa, $00, $d3, $f6, $0a, $6f        ;; 00:384e ????????
    db   $cb, $76, $c9                                 ;; 00:3856 ???

call_00_3859:
    ld   H, $d2                                        ;; 00:3859 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:385b $fa $00 $d3
    or   A, $0e                                        ;; 00:385e $f6 $0e
    ld   L, A                                          ;; 00:3860 $6f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:3861 $fa $0e $d2
    sub  A, [HL]                                       ;; 00:3864 $96
    ld   E, A                                          ;; 00:3865 $5f
    inc  HL                                            ;; 00:3866 $23
    ld   A, [wD20F_PlayerXPosition]                                    ;; 00:3867 $fa $0f $d2
    sbc  A, [HL]                                       ;; 00:386a $9e
    ld   D, A                                          ;; 00:386b $57
    ld   L, C                                          ;; 00:386c $69
    ld   H, $00                                        ;; 00:386d $26 $00
    add  HL, DE                                        ;; 00:386f $19
    sla  C                                             ;; 00:3870 $cb $21
    ld   A, L                                          ;; 00:3872 $7d
    sub  A, C                                          ;; 00:3873 $91
    ld   A, H                                          ;; 00:3874 $7c
    sbc  A, $00                                        ;; 00:3875 $de $00
    ret                                                ;; 00:3877 $c9

call_00_3878:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:3878 $fa $24 $d6
    and  A, A                                          ;; 00:387b $a7
    jr   Z, jr_00_3899                                 ;; 00:387c $28 $1b
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:387e $fa $00 $d3
    rlca                                               ;; 00:3881 $07
    rlca                                               ;; 00:3882 $07
    rlca                                               ;; 00:3883 $07
    and  A, $07                                        ;; 00:3884 $e6 $07
    ld   E, A                                          ;; 00:3886 $5f
    ld   D, $00                                        ;; 00:3887 $16 $00
    ld   HL, wD301                                     ;; 00:3889 $21 $01 $d3
    add  HL, DE                                        ;; 00:388c $19
    ld   A, [HL]                                       ;; 00:388d $7e
    dec  A                                             ;; 00:388e $3d
    srl  A                                             ;; 00:388f $cb $3f
    ld   E, A                                          ;; 00:3891 $5f
    ld   HL, wD798                                     ;; 00:3892 $21 $98 $d7
    add  HL, DE                                        ;; 00:3895 $19
    ld   A, [HL]                                       ;; 00:3896 $7e
    and  A, A                                          ;; 00:3897 $a7
    ret                                                ;; 00:3898 $c9

jr_00_3899:
    ld   H, $d2                                        ;; 00:3899 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:389b $fa $00 $d3
    or   A, $19                                        ;; 00:389e $f6 $19
    ld   L, A                                          ;; 00:38a0 $6f
    ld   A, [wD64F]                                    ;; 00:38a1 $fa $4f $d6
    and  A, $7f                                        ;; 00:38a4 $e6 $7f
    cp   A, [HL]                                       ;; 00:38a6 $be
    jr   C, .jr_00_38bf                                ;; 00:38a7 $38 $16
    inc  L                                             ;; 00:38a9 $2c
    ld   A, [wD650]                                    ;; 00:38aa $fa $50 $d6
    and  A, $7f                                        ;; 00:38ad $e6 $7f
    cp   A, [HL]                                       ;; 00:38af $be
    jr   C, .jr_00_38bf                                ;; 00:38b0 $38 $0d
    inc  L                                             ;; 00:38b2 $2c
    ld   A, [wD651]                                    ;; 00:38b3 $fa $51 $d6
    and  A, $7f                                        ;; 00:38b6 $e6 $7f
    cp   A, [HL]                                       ;; 00:38b8 $be
    jr   C, .jr_00_38bf                                ;; 00:38b9 $38 $04
    ld   A, $01                                        ;; 00:38bb $3e $01
    and  A, A                                          ;; 00:38bd $a7
    ret                                                ;; 00:38be $c9
.jr_00_38bf:
    xor  A, A                                          ;; 00:38bf $af
    ret                                                ;; 00:38c0 $c9

call_00_38c1:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:38c1 $fa $24 $d6
    and  A, A                                          ;; 00:38c4 $a7
    jr   Z, jr_00_3899                                 ;; 00:38c5 $28 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:38c7 $fa $00 $d3
    rlca                                               ;; 00:38ca $07
    rlca                                               ;; 00:38cb $07
    rlca                                               ;; 00:38cc $07
    and  A, $07                                        ;; 00:38cd $e6 $07
    ld   E, A                                          ;; 00:38cf $5f
    ld   D, $00                                        ;; 00:38d0 $16 $00
    ld   HL, wD301                                     ;; 00:38d2 $21 $01 $d3
    add  HL, DE                                        ;; 00:38d5 $19
    ld   A, [HL]                                       ;; 00:38d6 $7e
    dec  A                                             ;; 00:38d7 $3d
    srl  A                                             ;; 00:38d8 $cb $3f
    ld   E, A                                          ;; 00:38da $5f
    ld   HL, $38ed                                     ;; 00:38db $21 $ed $38
    add  HL, DE                                        ;; 00:38de $19
    ld   A, [HL]                                       ;; 00:38df $7e
    ld   HL, wD624_CurrentLevelId                                     ;; 00:38e0 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:38e3 $6e
    ld   H, $00                                        ;; 00:38e4 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 00:38e6 $11 $29 $d6
    add  HL, DE                                        ;; 00:38e9 $19
    and  A, [HL]                                       ;; 00:38ea $a6
    ld   E, A                                          ;; 00:38eb $5f
    ret                                                ;; 00:38ec $c9
    db   $01, $02, $04                                 ;; 00:38ed .?.

call_00_38f0:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:38f0 $fa $00 $d3
    push AF                                            ;; 00:38f3 $f5
    ld   A, $20                                        ;; 00:38f4 $3e $20
.jr_00_38f6:
    ld   [wD300_CurrentObjectAddr], A                                    ;; 00:38f6 $ea $00 $d3
    or   A, $00                                        ;; 00:38f9 $f6 $00
    ld   L, A                                          ;; 00:38fb $6f
    ld   H, $d2                                        ;; 00:38fc $26 $d2
    ld   A, [HL]                                       ;; 00:38fe $7e
    cp   A, $ff                                        ;; 00:38ff $fe $ff
    call NZ, call_00_3910                              ;; 00:3901 $c4 $10 $39
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3904 $fa $00 $d3
    add  A, $20                                        ;; 00:3907 $c6 $20
    jr   NZ, .jr_00_38f6                               ;; 00:3909 $20 $eb
    pop  AF                                            ;; 00:390b $f1
    ld   [wD300_CurrentObjectAddr], A                                    ;; 00:390c $ea $00 $d3
    ret                                                ;; 00:390f $c9

call_00_3910:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3910 $fa $00 $d3
    or   A, $00                                        ;; 00:3913 $f6 $00
    ld   L, A                                          ;; 00:3915 $6f
    ld   H, $d2                                        ;; 00:3916 $26 $d2
    ld   [HL], $ff                                     ;; 00:3918 $36 $ff
    ld   A, L                                          ;; 00:391a $7d
    rlca                                               ;; 00:391b $07
    rlca                                               ;; 00:391c $07
    rlca                                               ;; 00:391d $07
    and  A, $07                                        ;; 00:391e $e6 $07
    ld   L, A                                          ;; 00:3920 $6f
    ld   H, $00                                        ;; 00:3921 $26 $00
    ld   DE, wD301                                     ;; 00:3923 $11 $01 $d3
    add  HL, DE                                        ;; 00:3926 $19
    ld   L, [HL]                                       ;; 00:3927 $6e
    ld   H, $d0                                        ;; 00:3928 $26 $d0
    ld   A, [HL]                                       ;; 00:392a $7e
    cp   A, $ff                                        ;; 00:392b $fe $ff
    ret  Z                                             ;; 00:392d $c8
    ld   [HL], $00                                     ;; 00:392e $36 $00
    ret                                                ;; 00:3930 $c9

call_00_3931:
    ld   H, $d2                                        ;; 00:3931 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3933 $fa $00 $d3
    or   A, $00                                        ;; 00:3936 $f6 $00
    ld   L, A                                          ;; 00:3938 $6f
    ld   [HL], $ff                                     ;; 00:3939 $36 $ff
    ret                                                ;; 00:393b $c9

call_00_393c:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:393c $fa $00 $d3
    rlca                                               ;; 00:393f $07
    rlca                                               ;; 00:3940 $07
    rlca                                               ;; 00:3941 $07
    and  A, $07                                        ;; 00:3942 $e6 $07
    ld   L, A                                          ;; 00:3944 $6f
    ld   H, $00                                        ;; 00:3945 $26 $00
    ld   DE, wD301                                     ;; 00:3947 $11 $01 $d3
    add  HL, DE                                        ;; 00:394a $19
    ld   L, [HL]                                       ;; 00:394b $6e
    ld   H, $d0                                        ;; 00:394c $26 $d0
    ld   [HL], $ff                                     ;; 00:394e $36 $ff
    ret                                                ;; 00:3950 $c9
    db   $26, $d2, $3e, $20, $6f, $7e, $fe, $ff        ;; 00:3951 ????????
    db   $28, $06, $7d, $c6, $20, $20, $f5, $c9        ;; 00:3959 ????????
    db   $fa, $00, $d3, $f5, $7d, $ea, $00, $d3        ;; 00:3961 ????????
    db   $f6, $0e, $6f, $11, $0e, $d2, $1a, $22        ;; 00:3969 ????????
    db   $13, $1a, $22, $13, $1a, $22, $13, $1a        ;; 00:3971 ????????
    db   $77, $cd, $d8, $34, $cd, $85, $39, $f1        ;; 00:3979 ????????
    db   $ea, $00, $d3, $c9                            ;; 00:3981 ????

call_00_3985:
    ld   C, $01                                        ;; 00:3985 $0e $01
    call call_00_37e7                                  ;; 00:3987 $cd $e7 $37
    ld   H, $d2                                        ;; 00:398a $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:398c $fa $00 $d3
    or   A, $16                                        ;; 00:398f $f6 $16
    ld   L, A                                          ;; 00:3991 $6f
    ld   [HL], $00                                     ;; 00:3992 $36 $00
    ld   A, L                                          ;; 00:3994 $7d
    xor  A, $16                                        ;; 00:3995 $ee $16
    ld   L, A                                          ;; 00:3997 $6f
    ld   [HL], $07                                     ;; 00:3998 $36 $07
    ld   A, L                                          ;; 00:399a $7d
    xor  A, $17                                        ;; 00:399b $ee $17
    ld   L, A                                          ;; 00:399d $6f
    ld   [HL], $00                                     ;; 00:399e $36 $00
    ld   A, L                                          ;; 00:39a0 $7d
    xor  A, $1a                                        ;; 00:39a1 $ee $1a
    ld   L, A                                          ;; 00:39a3 $6f
    ld   [HL], $00                                     ;; 00:39a4 $36 $00
    ld   C, $01                                        ;; 00:39a6 $0e $01
    call call_00_3a23                                  ;; 00:39a8 $cd $23 $3a
    call call_00_393c                                  ;; 00:39ab $cd $3c $39
    xor  A, A                                          ;; 00:39ae $af
    ld   [wD59D_ReturnBank], A                                    ;; 00:39af $ea $9d $d5
    ld   A, Bank02                                        ;; 00:39b2 $3e $02
    ld   HL, entry_02_7102_SetObjectAction                                     ;; 00:39b4 $21 $02 $71
    call call_00_1078_CallAltBankFunc                                  ;; 00:39b7 $cd $78 $10
    ld   C, $17                                        ;; 00:39ba $0e $17
    call call_00_112f                                  ;; 00:39bc $cd $2f $11
    ret                                                ;; 00:39bf $c9
data_00_39c0:
    dw   wD33C, wD444, wD35D, wD46C
    dw   wD37E, wD494, wD39F, wD4BC
    dw   wD3C0, wD4E4, wD3E1, wD50C
    dw   wD402, wD534, wD423, wD55C

call_00_39e0:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:39e0 $fa $00 $d3
    rlca                                               ;; 00:39e3 $07
    rlca                                               ;; 00:39e4 $07
    rlca                                               ;; 00:39e5 $07
    and  A, $07                                        ;; 00:39e6 $e6 $07
    ld   L, A                                          ;; 00:39e8 $6f
    ld   H, $00                                        ;; 00:39e9 $26 $00
    add  HL, HL                                        ;; 00:39eb $29
    add  HL, HL                                        ;; 00:39ec $29
    ld   DE, $39c0                                     ;; 00:39ed $11 $c0 $39
    add  HL, DE                                        ;; 00:39f0 $19
    ld   E, [HL]                                       ;; 00:39f1 $5e
    inc  HL                                            ;; 00:39f2 $23
    ld   D, [HL]                                       ;; 00:39f3 $56
    ret                                                ;; 00:39f4 $c9

call_00_39f5:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:39f5 $fa $00 $d3
    rlca                                               ;; 00:39f8 $07
    rlca                                               ;; 00:39f9 $07
    rlca                                               ;; 00:39fa $07
    and  A, $07                                        ;; 00:39fb $e6 $07
    ld   L, A                                          ;; 00:39fd $6f
    ld   H, $00                                        ;; 00:39fe $26 $00
    add  HL, HL                                        ;; 00:3a00 $29
    add  HL, HL                                        ;; 00:3a01 $29
    ld   DE, $39c2                                     ;; 00:3a02 $11 $c2 $39
    add  HL, DE                                        ;; 00:3a05 $19
    ld   E, [HL]                                       ;; 00:3a06 $5e
    inc  HL                                            ;; 00:3a07 $23
    ld   D, [HL]                                       ;; 00:3a08 $56
    ret                                                ;; 00:3a09 $c9

call_00_3a0a:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3a0a $fa $00 $d3
    rlca                                               ;; 00:3a0d $07
    rlca                                               ;; 00:3a0e $07
    rlca                                               ;; 00:3a0f $07
    and  A, $07                                        ;; 00:3a10 $e6 $07
    ld   L, A                                          ;; 00:3a12 $6f
    ld   H, $00                                        ;; 00:3a13 $26 $00
    add  HL, HL                                        ;; 00:3a15 $29
    add  HL, HL                                        ;; 00:3a16 $29
    ld   DE, $39c0                                     ;; 00:3a17 $11 $c0 $39
    add  HL, DE                                        ;; 00:3a1a $19
    ld   E, [HL]                                       ;; 00:3a1b $5e
    inc  HL                                            ;; 00:3a1c $23
    ld   D, [HL]                                       ;; 00:3a1d $56
    inc  HL                                            ;; 00:3a1e $23
    ld   A, [HL+]                                      ;; 00:3a1f $2a
    ld   H, [HL]                                       ;; 00:3a20 $66
    ld   L, A                                          ;; 00:3a21 $6f
    ret                                                ;; 00:3a22 $c9

call_00_3a23:
    ld   L, C                                          ;; 00:3a23 $69
    ld   H, $00                                        ;; 00:3a24 $26 $00
    add  HL, HL                                        ;; 00:3a26 $29
    ld   DE, $3a67                                     ;; 00:3a27 $11 $67 $3a
    add  HL, DE                                        ;; 00:3a2a $19
    ld   E, [HL]                                       ;; 00:3a2b $5e
    inc  HL                                            ;; 00:3a2c $23
    ld   D, [HL]                                       ;; 00:3a2d $56
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3a2e $fa $00 $d3
    rlca                                               ;; 00:3a31 $07
    rlca                                               ;; 00:3a32 $07
    rlca                                               ;; 00:3a33 $07
    and  A, $07                                        ;; 00:3a34 $e6 $07
    ld   L, A                                          ;; 00:3a36 $6f
    ld   H, $00                                        ;; 00:3a37 $26 $00
    add  HL, HL                                        ;; 00:3a39 $29
    add  HL, HL                                        ;; 00:3a3a $29
    ld   BC, $39c0                                     ;; 00:3a3b $01 $c0 $39
    add  HL, BC                                        ;; 00:3a3e $09
    ld   C, [HL]                                       ;; 00:3a3f $4e
    inc  HL                                            ;; 00:3a40 $23
    ld   B, [HL]                                       ;; 00:3a41 $46
    inc  HL                                            ;; 00:3a42 $23
    xor  A, A                                          ;; 00:3a43 $af
    ld   [BC], A                                       ;; 00:3a44 $02
    ld   A, [HL+]                                      ;; 00:3a45 $2a
    ld   H, [HL]                                       ;; 00:3a46 $66
    ld   L, A                                          ;; 00:3a47 $6f
    ld   B, $08                                        ;; 00:3a48 $06 $08
.jr_00_3a4a:
    ld   A, [DE]                                       ;; 00:3a4a $1a
    ld   [HL+], A                                      ;; 00:3a4b $22
    inc  DE                                            ;; 00:3a4c $13
    ld   A, [DE]                                       ;; 00:3a4d $1a
    ld   [HL+], A                                      ;; 00:3a4e $22
    inc  DE                                            ;; 00:3a4f $13
    ld   A, [DE]                                       ;; 00:3a50 $1a
    ld   [HL+], A                                      ;; 00:3a51 $22
    inc  DE                                            ;; 00:3a52 $13
    ld   A, [DE]                                       ;; 00:3a53 $1a
    ld   [HL+], A                                      ;; 00:3a54 $22
    inc  DE                                            ;; 00:3a55 $13
    ld   A, [DE]                                       ;; 00:3a56 $1a
    ld   [HL+], A                                      ;; 00:3a57 $22
    inc  DE                                            ;; 00:3a58 $13
    dec  B                                             ;; 00:3a59 $05
    jr   NZ, .jr_00_3a4a                               ;; 00:3a5a $20 $ee
    ld   H, $d2                                        ;; 00:3a5c $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3a5e $fa $00 $d3
    or   A, $0a                                        ;; 00:3a61 $f6 $0a
    ld   L, A                                          ;; 00:3a63 $6f
    set  0, [HL]                                       ;; 00:3a64 $cb $c6
    ret                                                ;; 00:3a66 $c9
    db   $75, $3a                                      ;; 00:3a67 ??
    dw   .data_00_3a9d                                 ;; 00:3a69 pP
    dw   .data_00_3ac5                                 ;; 00:3a6b pP
    db   $ed, $3a, $15, $3b, $3d, $3b, $65, $3b        ;; 00:3a6d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a75 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a7d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a85 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a8d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a95 ????????
.data_00_3a9d:
    db   $81, $40, $00, $04, $01, $81, $30, $00        ;; 00:3a9d ........
    db   $03, $01, $81, $20, $00, $02, $01, $81        ;; 00:3aa5 ........
    db   $18, $00, $01, $01, $81, $40, $00, $04        ;; 00:3aad ........
    db   $ff, $81, $30, $00, $03, $ff, $81, $20        ;; 00:3ab5 ........
    db   $00, $02, $ff, $81, $18, $00, $01, $ff        ;; 00:3abd ........
.data_00_3ac5:
    db   $81, $24, $00, $00, $00, $81, $20, $00        ;; 00:3ac5 ........
    db   $06, $01, $81, $20, $00, $06, $ff, $00        ;; 00:3acd ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3ad5 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3add ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3ae5 ........
    db   $81, $24, $00, $00, $00, $81, $20, $00        ;; 00:3aed ????????
    db   $06, $01, $81, $20, $00, $06, $ff, $81        ;; 00:3af5 ????????
    db   $1c, $00, $0e, $01, $81, $1c, $00, $0e        ;; 00:3afd ????????
    db   $ff, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b0d ????????
    db   $01, $30, $10, $0c, $fb, $01, $20, $10        ;; 00:3b15 ????????
    db   $04, $ff, $01, $38, $10, $04, $05, $01        ;; 00:3b1d ????????
    db   $2e, $00, $0e, $fb, $01, $2c, $00, $06        ;; 00:3b25 ????????
    db   $01, $01, $26, $00, $0d, $05, $00, $00        ;; 00:3b2d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b35 ????????
    db   $01, $28, $10, $09, $f3, $01, $1a, $10        ;; 00:3b3d ????????
    db   $01, $fc, $01, $2e, $10, $02, $06, $01        ;; 00:3b45 ????????
    db   $26, $00, $0b, $f6, $01, $24, $00, $03        ;; 00:3b4d ????????
    db   $05, $01, $21, $00, $0a, $03, $00, $00        ;; 00:3b55 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b5d ????????
    db   $81, $40, $0c, $0c, $01, $81, $30, $0c        ;; 00:3b65 ????????
    db   $09, $01, $81, $20, $0c, $06, $01, $81        ;; 00:3b6d ????????
    db   $18, $0c, $03, $01, $81, $40, $0c, $0c        ;; 00:3b75 ????????
    db   $ff, $81, $30, $0c, $09, $ff, $81, $20        ;; 00:3b7d ????????
    db   $0c, $06, $ff, $81, $18, $0c, $03, $ff        ;; 00:3b85 ????????

call_00_3b8d:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3b8d $fa $00 $d3
    rlca                                               ;; 00:3b90 $07
    rlca                                               ;; 00:3b91 $07
    rlca                                               ;; 00:3b92 $07
    and  A, $07                                        ;; 00:3b93 $e6 $07
    ld   L, A                                          ;; 00:3b95 $6f
    ld   H, $00                                        ;; 00:3b96 $26 $00
    add  HL, HL                                        ;; 00:3b98 $29
    add  HL, HL                                        ;; 00:3b99 $29
    ld   DE, $39c2                                     ;; 00:3b9a $11 $c2 $39
    add  HL, DE                                        ;; 00:3b9d $19
    ld   A, [HL+]                                      ;; 00:3b9e $2a
    ld   H, [HL]                                       ;; 00:3b9f $66
    ld   L, A                                          ;; 00:3ba0 $6f
    push HL                                            ;; 00:3ba1 $e5
    ld   B, $08                                        ;; 00:3ba2 $06 $08
.jr_00_3ba4:
    push HL                                            ;; 00:3ba4 $e5
    bit  0, [HL]                                       ;; 00:3ba5 $cb $46
    jr   Z, .jr_00_3bd9                                ;; 00:3ba7 $28 $30
    inc  HL                                            ;; 00:3ba9 $23
    ld   A, [HL]                                       ;; 00:3baa $7e
    cp   A, $c0                                        ;; 00:3bab $fe $c0
    jr   Z, .jr_00_3bb0                                ;; 00:3bad $28 $01
    dec  [HL]                                          ;; 00:3baf $35
.jr_00_3bb0:
    ld   A, [HL+]                                      ;; 00:3bb0 $2a
    sra  A                                             ;; 00:3bb1 $cb $2f
    sra  A                                             ;; 00:3bb3 $cb $2f
    sra  A                                             ;; 00:3bb5 $cb $2f
    sra  A                                             ;; 00:3bb7 $cb $2f
    add  A, [HL]                                       ;; 00:3bb9 $86
    bit  7, A                                          ;; 00:3bba $cb $7f
    jr   Z, .jr_00_3bbf                                ;; 00:3bbc $28 $01
    xor  A, A                                          ;; 00:3bbe $af
.jr_00_3bbf:
    ld   [HL+], A                                      ;; 00:3bbf $22
    and  A, A                                          ;; 00:3bc0 $a7
    jr   Z, .jr_00_3bd9                                ;; 00:3bc1 $28 $16
    ld   A, [HL]                                       ;; 00:3bc3 $7e
    and  A, $0f                                        ;; 00:3bc4 $e6 $0f
    swap A                                             ;; 00:3bc6 $cb $37
    add  A, [HL]                                       ;; 00:3bc8 $86
    ld   [HL], A                                       ;; 00:3bc9 $77
    jr   NC, .jr_00_3bd7                               ;; 00:3bca $30 $0b
    inc  HL                                            ;; 00:3bcc $23
    ld   A, $01                                        ;; 00:3bcd $3e $01
    bit  7, [HL]                                       ;; 00:3bcf $cb $7e
    jr   Z, .jr_00_3bd5                                ;; 00:3bd1 $28 $02
    ld   A, $ff                                        ;; 00:3bd3 $3e $ff
.jr_00_3bd5:
    add  A, [HL]                                       ;; 00:3bd5 $86
    ld   [HL], A                                       ;; 00:3bd6 $77
.jr_00_3bd7:
    ld   A, $01                                        ;; 00:3bd7 $3e $01
.jr_00_3bd9:
    pop  HL                                            ;; 00:3bd9 $e1
    or   A, $fe                                        ;; 00:3bda $f6 $fe
    and  A, [HL]                                       ;; 00:3bdc $a6
    ld   [HL], A                                       ;; 00:3bdd $77
    ld   DE, $05                                       ;; 00:3bde $11 $05 $00
    add  HL, DE                                        ;; 00:3be1 $19
    dec  B                                             ;; 00:3be2 $05
    jr   NZ, .jr_00_3ba4                               ;; 00:3be3 $20 $bf
    pop  HL                                            ;; 00:3be5 $e1
    ld   DE, $05                                       ;; 00:3be6 $11 $05 $00
    ld   B, $08                                        ;; 00:3be9 $06 $08
    xor  A, A                                          ;; 00:3beb $af
.jr_00_3bec:
    or   A, [HL]                                       ;; 00:3bec $b6
    add  HL, DE                                        ;; 00:3bed $19
    dec  B                                             ;; 00:3bee $05
    jr   NZ, .jr_00_3bec                               ;; 00:3bef $20 $fb
    and  A, $01                                        ;; 00:3bf1 $e6 $01
    ret                                                ;; 00:3bf3 $c9

call_00_3bf4:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:3bf4 $fa $24 $d6
    and  A, A                                          ;; 00:3bf7 $a7
    ret  NZ                                            ;; 00:3bf8 $c0
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 00:3bf9 $fa $00 $d3
    rlca                                               ;; 00:3bfc $07
    rlca                                               ;; 00:3bfd $07
    rlca                                               ;; 00:3bfe $07
    and  A, $07                                        ;; 00:3bff $e6 $07
    ld   L, A                                          ;; 00:3c01 $6f
    ld   H, $00                                        ;; 00:3c02 $26 $00
    ld   DE, wD301                                     ;; 00:3c04 $11 $01 $d3
    add  HL, DE                                        ;; 00:3c07 $19
    ld   A, [HL]                                       ;; 00:3c08 $7e
    dec  A                                             ;; 00:3c09 $3d
    srl  A                                             ;; 00:3c0a $cb $3f
    ld   L, A                                          ;; 00:3c0c $6f
    ld   H, $00                                        ;; 00:3c0d $26 $00
    ld   DE, $3c20                                     ;; 00:3c0f $11 $20 $3c
    add  HL, DE                                        ;; 00:3c12 $19
    ld   A, [HL]                                       ;; 00:3c13 $7e
    cp   A, $ff                                        ;; 00:3c14 $fe $ff
    ret  Z                                             ;; 00:3c16 $c8
    ld   [wD610], A                                    ;; 00:3c17 $ea $10 $d6
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:3c1a $21 $0f $d6
    set  4, [HL]                                       ;; 00:3c1d $cb $e6
    ret                                                ;; 00:3c1f $c9
    db   $ff, $0f, $05, $04, $02, $0c, $ff, $09        ;; 00:3c20 ?..?????
    db   $0e, $08, $03, $00, $ff, $0b, $11, $ff        ;; 00:3c28 ????????
    db   $07, $ff, $ff, $ff, $ff, $0d, $0a, $01        ;; 00:3c30 .???????
    db   $13, $06, $12, $ff, $ff, $ff, $10             ;; 00:3c38 ???????

call_00_3c3f:
    ld   C, $07                                        ;; 00:3c3f $0e $07
    ld   HL, wD64F                                     ;; 00:3c41 $21 $4f $d6
    call call_00_3c54                                  ;; 00:3c44 $cd $54 $3c
    ld   C, $18                                        ;; 00:3c47 $0e $18
    ld   HL, wD650                                     ;; 00:3c49 $21 $50 $d6
    call call_00_3c54                                  ;; 00:3c4c $cd $54 $3c
    ld   C, $20                                        ;; 00:3c4f $0e $20
    ld   HL, wD651                                     ;; 00:3c51 $21 $51 $d6

call_00_3c54:
    push HL                                            ;; 00:3c54 $e5
    ld   HL, wD629_RemoteProgressFlags                                     ;; 00:3c55 $21 $29 $d6
    ld   B, $1e                                        ;; 00:3c58 $06 $1e
    ld   E, $00                                        ;; 00:3c5a $1e $00
.jr_00_3c5c:
    ld   A, [HL+]                                      ;; 00:3c5c $2a
    and  A, C                                          ;; 00:3c5d $a1
    ld   D, $08                                        ;; 00:3c5e $16 $08
.jr_00_3c60:
    rlca                                               ;; 00:3c60 $07
    jr   NC, .jr_00_3c64                               ;; 00:3c61 $30 $01
    inc  E                                             ;; 00:3c63 $1c
.jr_00_3c64:
    dec  D                                             ;; 00:3c64 $15
    jr   NZ, .jr_00_3c60                               ;; 00:3c65 $20 $f9
    dec  B                                             ;; 00:3c67 $05
    jr   NZ, .jr_00_3c5c                               ;; 00:3c68 $20 $f2
    ld   A, E                                          ;; 00:3c6a $7b
    pop  HL                                            ;; 00:3c6b $e1
    cp   A, [HL]                                       ;; 00:3c6c $be
    ret  Z                                             ;; 00:3c6d $c8
    ld   [HL], A                                       ;; 00:3c6e $77
    set  7, [HL]                                       ;; 00:3c6f $cb $fe
    ret                                                ;; 00:3c71 $c9
    
data_00_3c72:
    db   $1c, $02, $00, $7f, $00, $7f, $3f, $7f        ;; 00:3c72 ????????
    db   $3f, $7f, $38, $7c, $38, $7c, $38, $7f        ;; 00:3c7a ????????
    db   $38, $7f, $3f, $7f, $3f, $7f, $38, $7c        ;; 00:3c82 ????????
    db   $38, $7c, $38, $7f, $38, $7f, $3f, $7f        ;; 00:3c8a ????????
    db   $3f, $7f, $00, $c0, $00, $c0, $80, $c0        ;; 00:3c92 ????????
    db   $80, $c0, $00, $7f, $00, $7f, $3f, $ff        ;; 00:3c9a ????????
    db   $3f, $ff, $3b, $ff, $3b, $ff, $3b, $7f        ;; 00:3ca2 ????????
    db   $3b, $7f, $3b, $ff, $3b, $ff, $bb, $ff        ;; 00:3caa ????????
    db   $bb, $ff, $00, $3e, $00, $3e, $1c, $3e        ;; 00:3cb2 ????????
    db   $1c, $ff, $1c, $ff, $7f, $ff, $7f, $ff        ;; 00:3cba ????????
    db   $9c, $ff, $9c, $ff, $9c, $ff, $9c, $ff        ;; 00:3cc2 ????????
    db   $9c, $ff, $9c, $ff, $9c, $ff, $9e, $ff        ;; 00:3cca ????????
    db   $8e, $df, $00, $00, $00, $00, $00, $00        ;; 00:3cd2 ????????
    db   $00, $80, $00, $fe, $00, $ff, $7c, $ff        ;; 00:3cda ????????
    db   $fe, $ff, $ee, $ff, $ee, $ff, $fe, $ff        ;; 00:3ce2 ????????
    db   $fc, $fd, $e0, $ff, $e0, $ff, $fe, $ff        ;; 00:3cea ????????
    db   $7e, $ff, $00, $00, $00, $00, $00, $00        ;; 00:3cf2 ????????
    db   $00, $00, $00, $ee, $00, $ff, $ec, $ff        ;; 00:3cfa ????????
    db   $fe, $ff, $fe, $ff, $f0, $f8, $e0, $f0        ;; 00:3d02 ????????
    db   $e0, $f0, $e0, $f0, $e0, $f0, $e0, $f0        ;; 00:3d0a ????????
    db   $e0, $f0, $00, $7f, $00, $ff, $3f, $ff        ;; 00:3d12 ????????
    db   $7f, $ff, $70, $f8, $70, $f8, $70, $f8        ;; 00:3d1a ????????
    db   $70, $f8, $70, $f8, $70, $f8, $70, $f8        ;; 00:3d22 ????????
    db   $70, $f8, $70, $ff, $70, $ff, $7f, $ff        ;; 00:3d2a ????????
    db   $3f, $7f, $00, $80, $00, $80, $00, $80        ;; 00:3d32 ????????
    db   $00, $80, $00, $ff, $00, $ff, $77, $ff        ;; 00:3d3a ????????
    db   $77, $ff, $77, $ff, $77, $ff, $77, $ff        ;; 00:3d42 ????????
    db   $77, $ff, $77, $ff, $77, $ff, $7f, $ff        ;; 00:3d4a ????????
    db   $3f, $7f, $00, $00, $00, $00, $00, $00        ;; 00:3d52 ????????
    db   $00, $00, $00, $ff, $00, $ff, $76, $ff        ;; 00:3d5a ????????
    db   $7f, $ff, $7f, $ff, $78, $fc, $70, $f8        ;; 00:3d62 ????????
    db   $70, $f8, $70, $f8, $70, $f8, $70, $f8        ;; 00:3d6a ????????
    db   $70, $f8, $00, $00, $00, $00, $00, $00        ;; 00:3d72 ????????
    db   $00, $00, $00, $ff, $00, $ff, $76, $ff        ;; 00:3d7a ????????
    db   $7f, $ff, $7f, $ff, $78, $f8, $70, $f8        ;; 00:3d82 ????????
    db   $70, $f8, $70, $f8, $70, $f8, $70, $f8        ;; 00:3d8a ????????
    db   $70, $f8, $00, $00, $00, $00, $00, $00        ;; 00:3d92 ????????
    db   $00, $00, $00, $7f, $00, $ff, $3e, $ff        ;; 00:3d9a ????????
    db   $7f, $ff, $77, $ff, $77, $ff, $7f, $ff        ;; 00:3da2 ????????
    db   $7e, $fe, $70, $ff, $70, $ff, $7f, $ff        ;; 00:3daa ????????
    db   $3f, $7f, $00, $00, $00, $00, $00, $00        ;; 00:3db2 ????????
    db   $00, $01, $00, $ff, $00, $ff, $7e, $ff        ;; 00:3dba ????????
    db   $7f, $ff, $77, $ff, $77, $ff, $77, $ff        ;; 00:3dc2 ????????
    db   $77, $ff, $77, $ff, $77, $ff, $77, $ff        ;; 00:3dca ????????
    db   $77, $ff, $00, $7c, $00, $7c, $38, $7c        ;; 00:3dd2 ????????
    db   $38, $ff, $38, $ff, $fe, $ff, $fe, $ff        ;; 00:3dda ????????
    db   $38, $fc, $38, $fc, $38, $fc, $38, $fc        ;; 00:3de2 ????????
    db   $38, $fc, $38, $fe, $38, $fe, $3c, $fe        ;; 00:3dea ????????
    db   $1c, $be, $00, $3f, $00, $3f, $1f, $3f        ;; 00:3df2 ????????
    db   $1f, $3f, $07, $0f, $07, $0f, $07, $0f        ;; 00:3dfa ????????
    db   $07, $0f, $07, $0f, $07, $0f, $07, $0f        ;; 00:3e02 ????????
    db   $07, $0f, $07, $3f, $07, $3f, $1f, $3f        ;; 00:3e0a ????????
    db   $1f, $3f, $00, $e0, $00, $e0, $c0, $e0        ;; 00:3e12 ????????
    db   $c0, $e0, $00, $bf, $00, $bf, $1f, $bf        ;; 00:3e1a ????????
    db   $1f, $bf, $1d, $bf, $1d, $bf, $1d, $bf        ;; 00:3e22 ????????
    db   $1d, $bf, $1d, $ff, $1d, $ff, $dd, $ff        ;; 00:3e2a ????????
    db   $dd, $ff, $00, $00, $00, $00, $00, $00        ;; 00:3e32 ????????
    db   $00, $00, $00, $ff, $00, $ff, $9d, $ff        ;; 00:3e3a ????????
    db   $dd, $ff, $dd, $ff, $dd, $ff, $dd, $ff        ;; 00:3e42 ????????
    db   $dd, $ff, $dd, $ff, $cf, $ff, $cf, $ff        ;; 00:3e4a ????????
    db   $c7, $ef, $00, $00, $00, $00, $00, $00        ;; 00:3e52 ????????
    db   $00, $00, $00, $ff, $00, $ff, $df, $ff        ;; 00:3e5a ????????
    db   $df, $ff, $c1, $ff, $c1, $ff, $cf, $ff        ;; 00:3e62 ????????
    db   $df, $ff, $dd, $ff, $9d, $ff, $9f, $ff        ;; 00:3e6a ????????
    db   $0f, $9f, $00, $7f, $00, $7f, $3d, $7f        ;; 00:3e72 ????????
    db   $3d, $7f, $1c, $ff, $1c, $ff, $9d, $ff        ;; 00:3e7a ????????
    db   $dd, $ff, $dd, $ff, $dd, $ff, $dd, $ff        ;; 00:3e82 ????????
    db   $dd, $ff, $dd, $ff, $dd, $ff, $dd, $ff        ;; 00:3e8a ????????
    db   $dd, $ff, $00, $e1, $00, $e1, $c0, $e1        ;; 00:3e92 ????????
    db   $c0, $e1, $00, $ef, $00, $ff, $c7, $ff        ;; 00:3e9a ????????
    db   $cf, $ff, $dc, $ff, $dc, $ff, $dc, $ff        ;; 00:3ea2 ????????
    db   $dc, $ff, $dc, $ff, $dc, $ff, $cf, $ff        ;; 00:3eaa ????????
    db   $c7, $ef, $00, $f0, $00, $f0, $e0, $f0        ;; 00:3eb2 ????????
    db   $e0, $f0, $e0, $f0, $e0, $f0, $e0, $f0        ;; 00:3eba ????????
    db   $e0, $f0, $e0, $f0, $e0, $f0, $e0, $f0        ;; 00:3ec2 ????????
    db   $e0, $f0, $e0, $f0, $e0, $f0, $e0, $f0        ;; 00:3eca ????????
    db   $e0, $f0, $00, $ff, $00, $ff, $7f, $ff        ;; 00:3ed2 ????????
    db   $7f, $ff, $73, $ff, $73, $ff, $73, $ff        ;; 00:3eda ????????
    db   $73, $ff, $7f, $ff, $7f, $ff, $70, $f8        ;; 00:3ee2 ????????
    db   $70, $f8, $70, $f8, $70, $f8, $70, $f8        ;; 00:3eea ????????
    db   $70, $f8, $00, $80, $00, $c0, $00, $c0        ;; 00:3ef2 ????????
    db   $80, $c0, $80, $ff, $80, $ff, $bf, $ff        ;; 00:3efa ????????
    db   $bf, $ff, $83, $ff, $03, $ff, $1f, $7f        ;; 00:3f02 ????????
    db   $3f, $7f, $3b, $7f, $3b, $7f, $3f, $7f        ;; 00:3f0a ????????
    db   $1f, $3f, $00, $00, $00, $00, $00, $00        ;; 00:3f12 ????????
    db   $00, $00, $00, $bf, $00, $ff, $1f, $ff        ;; 00:3f1a ????????
    db   $bf, $ff, $b8, $ff, $b8, $ff, $bf, $ff        ;; 00:3f22 ????????
    db   $9f, $ff, $83, $ff, $83, $ff, $bf, $ff        ;; 00:3f2a ????????
    db   $bf, $ff, $00, $00, $00, $00, $00, $00        ;; 00:3f32 ????????
    db   $00, $00, $00, $ff, $00, $ff, $9f, $ff        ;; 00:3f3a ????????
    db   $bf, $ff, $38, $ff, $38, $ff, $3f, $ff        ;; 00:3f42 ????????
    db   $9f, $ff, $83, $ff, $83, $ff, $bf, $ff        ;; 00:3f4a ????????
    db   $3f, $ff, $00, $00, $00, $00, $00, $00        ;; 00:3f52 ????????
    db   $00, $00, $00, $fc, $00, $fc, $b8, $fc        ;; 00:3f5a ????????
    db   $b8, $fc, $38, $ff, $38, $ff, $3b, $ff        ;; 00:3f62 ????????
    db   $bb, $ff, $bb, $ff, $bf, $ff, $9f, $ff        ;; 00:3f6a ????????
    db   $0c, $9f, $00, $00, $00, $00, $00, $00        ;; 00:3f72 ????????
    db   $00, $00, $00, $ff, $00, $ff, $73, $ff        ;; 00:3f7a ????????
    db   $77, $ff, $77, $ff, $77, $ff, $77, $ff        ;; 00:3f82 ????????
    db   $77, $ff, $77, $ff, $f7, $ff, $e7, $ff        ;; 00:3f8a ????????
    db   $c3, $e7, $00, $00, $00, $00, $00, $00        ;; 00:3f92 ????????
    db   $00, $00, $00, $ff, $00, $ff, $f3, $ff        ;; 00:3f9a ????????
    db   $fb, $ff, $3b, $ff, $3b, $ff, $3b, $ff        ;; 00:3fa2 ????????
    db   $3b, $ff, $3b, $ff, $3b, $ff, $fb, $ff        ;; 00:3faa ????????
    db   $f3, $ff, $00, $00, $00, $00, $00, $00        ;; 00:3fb2 ????????
    db   $00, $00, $00, $fb, $00, $ff, $b1, $ff        ;; 00:3fba ????????
    db   $fb, $ff, $fb, $ff, $c3, $e7, $83, $c7        ;; 00:3fc2 ????????
    db   $83, $c7, $83, $c7, $83, $c7, $83, $c7        ;; 00:3fca ????????
    db   $81, $c3, $00, $3e, $00, $3e, $1c, $3e        ;; 00:3fd2 ????????
    db   $1c, $3e, $1c, $fe, $1c, $fe, $fc, $fe        ;; 00:3fda ????????
    db   $fc, $fe, $9c, $fe, $9c, $fe, $9c, $fe        ;; 00:3fe2 ????????
    db   $9c, $fe, $9c, $fe, $9c, $fe, $fc, $fe        ;; 00:3fea ????????
    db   $fc, $fe, $00, $fe                            ;; 00:3ff2 ????
