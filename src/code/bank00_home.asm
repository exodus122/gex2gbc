;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

    reti

SECTION "isrVBlank", ROM0[$0040]
isrVBlank:
    jp   call_00_0a54_MainGameLoop_UpdateAndRenderFrame                                    ;; 00:0040 $c3 $54 $0a

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
; call point of the code
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
    call call_00_07b0_MemCopy                                  ;; 00:017b $cd $b0 $07
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
    call call_00_07b0_MemCopy                                  ;; 00:01b5 $cd $b0 $07
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
    ld   HL, call_21_4000                              ;; 00:01f4 $21 $00 $40
    call call_00_1078_FarCall                    ;; 00:01f7 $cd $78 $10
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
    ld   HL, call_01_4f87_LoadEnterPasswordMenu                              ;; 00:021a $21 $87 $4f
    call call_00_1078_FarCall                    ;; 00:021d $cd $78 $10
.jp_00_0220:
    ld   A, MenuType_TitleSplash                                        ;; 00:0220 $3e $14
    ld   [wD59D_ReturnBank], A                                    ;; 00:0222 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0225 $3e $01
    ld   HL, call_01_4000_MenuLoad                              ;; 00:0227 $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:022a $cd $78 $10
    ld   A, MenuType_TitleCrave                                        ;; 00:022d $3e $13
    ld   [wD59D_ReturnBank], A                                    ;; 00:022f $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0232 $3e $01
    ld   HL, call_01_4000_MenuLoad                              ;; 00:0234 $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:0237 $cd $78 $10
    ld   A, MenuType_TitleDavid                                        ;; 00:023a $3e $16
    ld   [wD59D_ReturnBank], A                                    ;; 00:023c $ea $9d $d5
    ld   A, Bank01                                        ;; 00:023f $3e $01
    ld   HL, call_01_4000_MenuLoad                              ;; 00:0241 $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:0244 $cd $78 $10
    ld   A, MenuType_TitleScreen                                        ;; 00:0247 $3e $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:0249 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:024c $3e $01
    ld   HL, call_01_4000_MenuLoad                              ;; 00:024e $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:0251 $cd $78 $10
.jp_00_0254:
    ld   A, Music_MediaDimension                                        ;; 00:0254 $3e $07
    call call_00_120c_SetupMusic                                  ;; 00:0256 $cd $0c $12
    xor  A, A                                          ;; 00:0259 $af
    ld   [wD61E_DemoModeEnabled], A                                    ;; 00:025a $ea $1e $d6
    ld   A, MenuType_TitleOptions                                        ;; 00:025d $3e $07
    ld   [wD59D_ReturnBank], A                                    ;; 00:025f $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0262 $3e $01
    ld   HL, call_01_4000_MenuLoad                              ;; 00:0264 $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:0267 $cd $78 $10
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
    ld   A, $05 ; Set Lives Remaining to 5                                       ;; 00:029d $3e $05
    ld   [wD73D_LivesRemaining], A                     ;; 00:029f $ea $3d $d7=
    ld   HL, wD629_RemoteProgressFlags ; Set Remote Progress bitfields to 0                                    ;; 00:02a2 $21 $29 $d6
    ld   B, $1e                                        ;; 00:02a5 $06 $1e
.jr_00_02a7:
    ld   [HL], $00                                     ;; 00:02a7 $36 $00
    inc  HL                                            ;; 00:02a9 $23
    dec  B                                             ;; 00:02aa $05
    jr   NZ, .jr_00_02a7                               ;; 00:02ab $20 $fa
    ld   [wD59D_ReturnBank], A                                    ;; 00:02ad $ea $9d $d5=
    ld   A, Bank01 ; Switch to bank 1                                       ;; 00:02b0 $3e $01
    ld   HL, call_01_4349_LoadEnteringMenu                              ;; 00:02b2 $21 $49 $43
    call call_00_1078_FarCall                    ;; 00:02b5 $cd $78 $10
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
    ld   HL, call_01_4000_MenuLoad                              ;; 00:02d3 $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:02d6 $cd $78 $10
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
    ld   HL, call_01_42bd_EnterTV                                     ;; 00:0300 $21 $bd $42
    call call_00_1078_FarCall                                  ;; 00:0303 $cd $78 $10
.jr_00_0306:
    call call_00_11e0_PlaySongBasedOnLevel                                  ;; 00:0306 $cd $e0 $11
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0309 $fa $24 $d6
    and  A, A                                          ;; 00:030c $a7
    jr   Z, .jr_00_0350                                ;; 00:030d $28 $41
    call call_00_0562                                  ;; 00:030f $cd $62 $05
    ld   [wD59D_ReturnBank], A                                    ;; 00:0312 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0315 $3e $01
    ld   HL, call_01_4297_LoadMissionSelectMenu                                     ;; 00:0317 $21 $97 $42
    call call_00_1078_FarCall                                  ;; 00:031a $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:031d $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:0320 $3e $0b
    ld   HL, call_0b_4000                              ;; 00:0322 $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:0325 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:0328 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:032b $3e $02
    ld   HL, call_02_6eb1                                     ;; 00:032d $21 $b1 $6e
    call call_00_1078_FarCall                                  ;; 00:0330 $cd $78 $10
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
    call call_00_2329_LoadAndRunMissionPreviewCutscene                                  ;; 00:034d $cd $29 $23
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
    ld   A, $04 ; Set Health to 4                                       ;; 00:03b3 $3e $04
    ld   [wD741_PlayerHealth], A                                    ;; 00:03b5 $ea $41 $d7
    ld   [wD59D_ReturnBank], A                                    ;; 00:03b8 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:03bb $3e $0b
    ld   HL, call_0b_4000                              ;; 00:03bd $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:03c0 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:03c3 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:03c6 $3e $02
    ld   HL, call_02_6eb1                                     ;; 00:03c8 $21 $b1 $6e
    call call_00_1078_FarCall                                  ;; 00:03cb $cd $78 $10
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
    ld   [wD743_DrawGexFlag], A                                    ;; 00:03f6 $ea $43 $d7
    ld   [wD59D_ReturnBank], A                                    ;; 00:03f9 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:03fc $3e $0b
    ld   HL, call_0b_4efe_SpawnPositionInMap                                     ;; 00:03fe $21 $fe $4e
    call call_00_1078_FarCall                                  ;; 00:0401 $cd $78 $10
    call call_00_1264_LoadFullMap                                  ;; 00:0404 $cd $64 $12
    ld   [wD59D_ReturnBank], A                                    ;; 00:0407 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:040a $3e $02
    ld   HL, call_02_6e17_InitEntitiesAndSpawnPlayer                                     ;; 00:040c $21 $17 $6e
    call call_00_1078_FarCall                                  ;; 00:040f $cd $78 $10
    call call_00_0521_DrawEntitiesWrapper                                  ;; 00:0412 $cd $21 $05
    jr   .jp_00_0428                                   ;; 00:0415 $18 $11
.jp_00_0417:
    call call_00_1264_LoadFullMap                                  ;; 00:0417 $cd $64 $12
    ld   [wD59D_ReturnBank], A                                    ;; 00:041a $ea $9d $d5
    ld   A, Bank02                                        ;; 00:041d $3e $02
    ld   HL, call_02_71c8                                     ;; 00:041f $21 $c8 $71
    call call_00_1078_FarCall                                  ;; 00:0422 $cd $78 $10
    call call_00_0521_DrawEntitiesWrapper                                  ;; 00:0425 $cd $21 $05
.jp_00_0428:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:0428 $cd $b4 $0a
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
    ld   HL, call_01_43bd_LoadGameOverMenu                                     ;; 00:045a $21 $bd $43
    call call_00_1078_FarCall                                  ;; 00:045d $cd $78 $10
    cp   A, $80                                        ;; 00:0460 $fe $80
    jp   Z, .jp_00_029d                                ;; 00:0462 $ca $9d $02
    jp   .jp_00_0254                                   ;; 00:0465 $c3 $54 $02
.jr_00_0468:
    call call_00_110d_CheckInputStart                                  ;; 00:0468 $cd $0d $11
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
    call call_00_1118_CheckInputSelect                                  ;; 00:047f $cd $18 $11
    jr   Z, .jr_00_04a9                                ;; 00:0482 $28 $25
    ld   A, $05                                        ;; 00:0484 $3e $05
.jr_00_0486:
    ld   [wD59D_ReturnBank], A                                    ;; 00:0486 $ea $9d $d5
    ld   A, Bank01                                        ;; 00:0489 $3e $01
    ld   HL, call_01_4000_MenuLoad                              ;; 00:048b $21 $00 $40
    call call_00_1078_FarCall                                  ;; 00:048e $cd $78 $10
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
    ld   HL, call_02_6eba_UpdateAllEntities                                     ;; 00:04e5 $21 $ba $6e
    call call_00_1078_FarCall                                  ;; 00:04e8 $cd $78 $10
    call call_00_1455_LoadBgMapDirtyRegions                                  ;; 00:04eb $cd $55 $14
    call call_00_2305                                  ;; 00:04ee $cd $05 $23
    call call_00_1e5b                                  ;; 00:04f1 $cd $5b $1e
    call call_00_05c7                                  ;; 00:04f4 $cd $c7 $05
    call call_00_08fc_SetupEntityVRAMTransfer                                  ;; 00:04f7 $cd $fc $08
    ld   [wD59D_ReturnBank], A                                    ;; 00:04fa $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:04fd $3e $0b
    ld   HL, call_0b_5ec3                                     ;; 00:04ff $21 $c3 $5e
    call call_00_1078_FarCall                                  ;; 00:0502 $cd $78 $10
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

call_00_0521_DrawEntitiesWrapper:
    ld   [wD59D_ReturnBank], A                                    ;; 00:0521 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:0524 $3e $02
    ld   HL, call_02_6f80                                     ;; 00:0526 $21 $80 $6f
    call call_00_1078_FarCall                                  ;; 00:0529 $cd $78 $10
    call call_00_0971                                  ;; 00:052c $cd $71 $09
    ld   A, $03                                        ;; 00:052f $3e $03
    call call_00_0bae                                  ;; 00:0531 $cd $ae $0b
    ld   C, $00                                        ;; 00:0534 $0e $00
    ld   [wD59D_ReturnBank], A                                    ;; 00:0536 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:0539 $3e $0b
    ld   HL, call_0b_5537                              ;; 00:053b $21 $37 $55
    call call_00_1078_FarCall                                  ;; 00:053e $cd $78 $10
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
    call call_00_1078_FarCall
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
    ld   HL, call_02_4ccd                                   ;; 00:069d $21 $cd $4c (BANK 3)
    call call_00_1078_FarCall                                  ;; 00:06a0 $cd $78 $10
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

call_00_06bf_DealDamageToPlayer: ; Deal damage to Gex
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
    ld   HL, call_02_4ccd                                   ;; 00:06e3 $21 $cd $4c (BANK 3)
    call call_00_1078_FarCall                                  ;; 00:06e6 $cd $78 $10
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

call_00_07a1_SwitchBankAndCopyBCBytesFromHLToDE:
    push HL                                            ;; 00:07a1 $e5
    push DE                                            ;; 00:07a2 $d5
    push BC                                            ;; 00:07a3 $c5
    call call_00_1089_SwitchBank                                  ;; 00:07a4 $cd $89 $10
    pop  BC                                            ;; 00:07a7 $c1
    pop  DE                                            ;; 00:07a8 $d1
    pop  HL                                            ;; 00:07a9 $e1
    call call_00_07b0_MemCopy                                  ;; 00:07aa $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:07ad $c3 $a3 $10

call_00_07b0_MemCopy:
    ld   A, [HL+]                                      ;; 00:07b0 $2a
    ld   [DE], A                                       ;; 00:07b1 $12
    inc  DE                                            ;; 00:07b2 $13
    dec  BC                                            ;; 00:07b3 $0b
    ld   A, B                                          ;; 00:07b4 $78
    or   A, C                                          ;; 00:07b5 $b1
    jr   NZ, call_00_07b0_MemCopy                              ;; 00:07b6 $20 $f8
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
    call call_00_07b0_MemCopy
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

    jp call_00_10a3_RestoreBank

call_00_084d:
    ld   A, [wD6B0]                                    ;; 00:084d $fa $b0 $d6
    call call_00_1089_SwitchBank                                  ;; 00:0850 $cd $89 $10
    ld   HL, wD6B1                                     ;; 00:0853 $21 $b1 $d6
    ld   A, [HL+]                                      ;; 00:0856 $2a
    ld   H, [HL]                                       ;; 00:0857 $66
    ld   L, A                                          ;; 00:0858 $6f
    ld   DE, $8000                                     ;; 00:0859 $11 $00 $80
    ld   BC, $f00                                      ;; 00:085c $01 $00 $0f
    call call_00_07b0_MemCopy                                  ;; 00:085f $cd $b0 $07
    ld   DE, $9000                                     ;; 00:0862 $11 $00 $90
    ld   BC, $780                                      ;; 00:0865 $01 $80 $07
    call call_00_07b0_MemCopy                                  ;; 00:0868 $cd $b0 $07
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
    jp   call_00_10a3_RestoreBank                                  ;; 00:08ae $c3 $a3 $10

call_00_08b1:
    push HL                                            ;; 00:08b1 $e5
    push DE                                            ;; 00:08b2 $d5
    push BC                                            ;; 00:08b3 $c5
    push HL                                            ;; 00:08b4 $e5
    ld   A, $13                                        ;; 00:08b5 $3e $13
    call call_00_1089_SwitchBank                                  ;; 00:08b7 $cd $89 $10
    call call_00_2e3a_GetTVPaletteId                                  ;; 00:08ba $cd $3a $2e
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
    call call_00_10a3_RestoreBank                                  ;; 00:08df $cd $a3 $10
    pop  BC                                            ;; 00:08e2 $c1
    pop  DE                                            ;; 00:08e3 $d1
    pop  HL                                            ;; 00:08e4 $e1
    ret                                                ;; 00:08e5 $c9
    db   $00, $40, $00, $6d, $00, $70, $00, $6a        ;; 00:08e6 ????????
    db   $00, $76, $00, $40                            ;; 00:08ee ????
    dw   $4000                                         ;; 00:08f2 wW
    dw   $6700                                         ;; 00:08f4 wW
    db   $00, $79, $00, $40, $00, $73                  ;; 00:08f6 ??????

call_00_08fc_SetupEntityVRAMTransfer: ; this reads secondary tileset information from other banks and writes to a buffer that gets copied to vram
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:08fc $21 $0f $d6
    bit  7, [HL]                                       ;; 00:08ff $cb $7e
    jr   NZ, call_00_08fc_SetupEntityVRAMTransfer                              ;; 00:0901 $20 $f9
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
    ld   A, [wD726_SecondaryTilesetBank]                                    ;; 00:093e $fa $26 $d7 ; this is where it went when loading seconda tileset info
    call call_00_1089_SwitchBank                                  ;; 00:0941 $cd $89 $10
    ld   A, [wD728_CurrentSecondaryTilesetAddr]                                    ;; 00:0944 $fa $28 $d7
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
    call call_00_0b6d                                  ;; 00:0966 $cd $6d $0b ; this reads secondary tileset information from other banks
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:0969 $21 $0f $d6
    set  7, [HL]                                       ;; 00:096c $cb $fe
    jp   call_00_10a3_RestoreBank                                  ;; 00:096e $c3 $a3 $10

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
    call call_00_07b0_MemCopy                                  ;; 00:09ae $cd $b0 $07
    pop  HL                                            ;; 00:09b1 $e1
    ld   DE, $8100                                     ;; 00:09b2 $11 $00 $81
    ld   BC, $100                                      ;; 00:09b5 $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:09b8 $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:09bb $c3 $a3 $10

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
    call call_00_07b0_MemCopy                                  ;; 00:09d3 $cd $b0 $07
    pop  HL                                            ;; 00:09d6 $e1
    ld   DE, $8300                                     ;; 00:09d7 $11 $00 $83
    ld   BC, $100                                      ;; 00:09da $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:09dd $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:09e0 $c3 $a3 $10

call_00_09e3:
    res  2, [HL]                                       ;; 00:09e3 $cb $96
    ld   A, [wD726_SecondaryTilesetBank]                                    ;; 00:09e5 $fa $26 $d7
    call call_00_1089_SwitchBank                                  ;; 00:09e8 $cd $89 $10
    ld   A, [wD728_CurrentSecondaryTilesetAddr]                                    ;; 00:09eb $fa $28 $d7
    ld   H, A                                          ;; 00:09ee $67
    ld   L, $00                                        ;; 00:09ef $2e $00
    ld   DE, $9000                                     ;; 00:09f1 $11 $00 $90
    ld   BC, $240                                      ;; 00:09f4 $01 $40 $02
    call call_00_07b0_MemCopy                                  ;; 00:09f7 $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:09fa $c3 $a3 $10

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
    call call_00_07b0_MemCopy                                  ;; 00:0a1b $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:0a1e $c3 $a3 $10

call_00_0a21:
    ld   [wD59D_ReturnBank], A                                    ;; 00:0a21 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:0a24 $3e $02
    ld   HL, call_02_722c                                     ;; 00:0a26 $21 $2c $72
    call call_00_1078_FarCall                                  ;; 00:0a29 $cd $78 $10
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
    call call_00_07b0_MemCopy                                  ;; 00:0a4c $cd $b0 $07
    call call_00_10a3_RestoreBank                                  ;; 00:0a4f $cd $a3 $10
    jr   call_00_0a21                                    ;; 00:0a52 $18 $cd

call_00_0a54_MainGameLoop_UpdateAndRenderFrame:
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
    call call_00_10bd_JumpHL                                  ;; 00:0a6c $cd $bd $10
    call call_00_10be_ReadJoypadInput                                  ;; 00:0a6f $cd $be $10
    ld   A, $01                                        ;; 00:0a72 $3e $01
    ld   [wD622_InterruptFlag], A                                    ;; 00:0a74 $ea $22 $d6
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

call_00_0ab4_WaitForInterrupt: ; updates tiles in VRAM
    xor  A, A                                          ;; 00:0ab4 $af
    ld   [wD622_InterruptFlag], A                                    ;; 00:0ab5 $ea $22 $d6
.jr_00_0ab8:
    halt                                               ;; 00:0ab8 $76
    nop                                                ;; 00:0ab9 $00
    ld   A, [wD622_InterruptFlag]                                    ;; 00:0aba $fa $22 $d6
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
    call NZ, call_03_6f5e_WriteVRAMBgMap                              ;; 00:0ae0 $c4 $5e $6f
    ld   A, [wD6F9]                                    ;; 00:0ae3 $fa $f9 $d6
    and  A, $0c                                        ;; 00:0ae6 $e6 $0c
    call NZ, call_03_708d                              ;; 00:0ae8 $c4 $8d $70
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
    call NZ, call_03_6941                              ;; 00:0b11 $c4 $41 $69
    ld   A, [wD60E]                                    ;; 00:0b14 $fa $0e $d6
    bit  1, A                                          ;; 00:0b17 $cb $4f
    jp   NZ, call_03_6d13                              ;; 00:0b19 $c2 $13 $6d
    bit  2, A                                          ;; 00:0b1c $cb $57
    jp   NZ, call_03_6ceb                                ;; 00:0b1e $c2 $eb $6c
    jp   call_03_7253_UpdateAnimatedTile                                    ;; 00:0b21 $c3 $53 $72
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

    call call_00_0ab4_WaitForInterrupt
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
    ld   HL, wD728_CurrentSecondaryTilesetAddr                                     ;; 00:0c9f $21 $28 $d7
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
    call call_00_07b0_MemCopy                                  ;; 00:0ef3 $cd $b0 $07
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
    ld   [wD611_AnimatedTileId], A                                    ;; 00:0f16 $ea $11 $d6
    ld   [wD6E2], A                                    ;; 00:0f19 $ea $e2 $d6
    ld   [wDAD9], A                                    ;; 00:0f1c $ea $d9 $da
    ld   [wD71E], A                                    ;; 00:0f1f $ea $1e $d7
    ld   A, $ff                                        ;; 00:0f22 $3e $ff
    ld   [wD789], A                                    ;; 00:0f24 $ea $89 $d7
    ld   A, [wD5A0]                                    ;; 00:0f27 $fa $a0 $d5
    and  A, $7f                                        ;; 00:0f2a $e6 $7f
    ld   [wD5A0], A                                    ;; 00:0f2c $ea $a0 $d5
    jp   call_00_0ab4_WaitForInterrupt                                  ;; 00:0f2f $c3 $b4 $0a

call_00_0f32:
    ld   [wD5A0], A                                    ;; 00:0f32 $ea $a0 $d5
    ldh  [rLCDC], A                                    ;; 00:0f35 $e0 $40
    ret                                                ;; 00:0f37 $c9

call_00_0f38:
    call call_00_0f64                                  ;; 00:0f38 $cd $64 $0f
.jr_00_0f3b:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:0f3b $cd $b4 $0a
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
    call call_00_10bd_JumpHL                                  ;; 00:1021 $cd $bd $10
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

call_00_1078_FarCall:
    push HL                                            ;; 00:1078 $e5
    call call_00_1089_SwitchBank                                  ;; 00:1079 $cd $89 $10
    pop  HL                                            ;; 00:107c $e1
    ld   A, [wD59D_ReturnBank]                                    ;; 00:107d $fa $9d $d5
    call call_00_10bd_JumpHL                                  ;; 00:1080 $cd $bd $10
    push AF                                            ;; 00:1083 $f5
    call call_00_10a3_RestoreBank                                  ;; 00:1084 $cd $a3 $10
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

call_00_10a3_RestoreBank:
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

call_00_10bd_JumpHL:
    jp   HL                                            ;; 00:10bd $e9

call_00_10be_ReadJoypadInput:
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

call_00_10eb_WaitUntilNoInputPressed:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:10eb $cd $b4 $0a
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:10ee $fa $9f $d5
    and  A, A                                          ;; 00:10f1 $a7
    jr   NZ, call_00_10eb_WaitUntilNoInputPressed                              ;; 00:10f2 $20 $f7
    ret                                                ;; 00:10f4 $c9

call_00_10f5_CheckInputLeft:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:10f5 $fa $9f $d5
    and  A, PADF_LEFT                                        ;; 00:10f8 $e6 $20
    ret                                                ;; 00:10fa $c9

call_00_10fb_CheckInputRight:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:10fb $fa $9f $d5
    and  A, PADF_RIGHT                                        ;; 00:10fe $e6 $10
    ret                                                ;; 00:1100 $c9

call_00_1101_CheckInputUp:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1101 $fa $9f $d5
    and  A, PADF_UP                                        ;; 00:1104 $e6 $40
    ret                                                ;; 00:1106 $c9

call_00_1107_CheckInputDown:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1107 $fa $9f $d5
    and  A, PADF_DOWN                                        ;; 00:110a $e6 $80
    ret                                                ;; 00:110c $c9

call_00_110d_CheckInputStart:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:110d $fa $9f $d5
    cp   A, PADF_START                                        ;; 00:1110 $fe $08
    jr   Z, .jr_00_1116                                ;; 00:1112 $28 $02
    xor  A, A                                          ;; 00:1114 $af
    ret                                                ;; 00:1115 $c9
.jr_00_1116:
    and  A, A                                          ;; 00:1116 $a7
    ret                                                ;; 00:1117 $c9

call_00_1118_CheckInputSelect:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1118 $fa $9f $d5
    cp   A, PADF_SELECT                                        ;; 00:111b $fe $04
    jr   Z, .jr_00_1121                                ;; 00:111d $28 $02
    xor  A, A                                          ;; 00:111f $af
    ret                                                ;; 00:1120 $c9
.jr_00_1121:
    and  A, A                                          ;; 00:1121 $a7
    ret                                                ;; 00:1122 $c9

call_00_1123_CheckInputA:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1123 $fa $9f $d5
    and  A, PADF_A                                        ;; 00:1126 $e6 $01
    ret                                                ;; 00:1128 $c9

call_00_1129_CheckInputB:
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:1129 $fa $9f $d5
    and  A, PADF_B                                        ;; 00:112c $e6 $02
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
    jp   call_00_10a3_RestoreBank                                  ;; 00:1169 $c3 $a3 $10
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

call_00_11e0_PlaySongBasedOnLevel:
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
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:120d $cd $b4 $0a
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
    call call_00_10a3_RestoreBank                                  ;; 00:123c $cd $a3 $10
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

INCLUDE "code/bank00_maps_core.asm"

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
    call NZ, call_00_10bd_JumpHL                              ;; 00:1ff2 $c4 $bd $10
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
    call call_00_1078_FarCall
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

INCLUDE "code/bank00_mission_preview.asm"

INCLUDE "code/bank00_map_data.asm"

INCLUDE "code/bank00_entity_utils.asm"

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
    db   $1c, $02, $00
    INCBIN ".gfx/misc_sprites/image_000_3c75.bin"  
    db   $fe  
