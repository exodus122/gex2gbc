;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

; ==================================================================
; Bank 0 (home). Interrupt vectors, boot, the outer game loop, and the shared
; video / banking / input / sfx helpers that every other bank calls into.
;
; How graphics reach VRAM
; -----------------------
; The game never writes VRAM directly from game logic. Instead:
;
;   1. Something sets a request bit in wD60F_GfxTransferFlags (GFX_XFER_*).
;   2. call_00_08fc_StageNextGfxTransfer picks the lowest pending request, banks in
;      the source and stages 256 bytes into wD100_TilesToLoadBuffer, then raises
;      GFX_XFER_IN_PROGRESS.
;   3. call_00_0c11_VBlank_ArmVramStreamIsr (the vblank hook paired with
;      LCD_ISR_VRAM_STREAM) patches the destination page into the LCD STAT handler
;      living in wCCA0_LcdIsrCode and arms it by overwriting its leading reti with a
;      push af.
;   4. That handler then dribbles 4 bytes per hblank out of the buffer until the page
;      is done, at which point it disarms itself again.
;
; When the LCD is already off (level loads, menus) the same requests are serviced in
; one shot by call_00_0971_ProcessPendingGfxTransfers instead.
;
; Separately, call_00_0ac1_VBlank_UpdateVRAM performs exactly one "big" VRAM write per
; vblank - a bg map scroll row/column, a block patch, a tileset animation frame or a
; hud digit reload - chosen by priority.
;
; The other LCD STAT handler, LCD_ISR_RASTER_EFFECT, does the hud window split and the
; horizontal wobble used by the tv warp; its vblank hook
; (call_00_0d84_VBlank_RunGfxStream) copies one chunk of a menu graphics script.
;
; How banking works
; -----------------
; call_00_1089_SwitchBank PUSHES the new bank onto a stack in WRAM and
; call_00_10a3_RestoreBank POPS it, so the two must be matched or the stack pointer
; in wD59A_PtrToBankStackPosition drifts. FARCALL is that pair wrapped around a
; `jp hl`. Interrupt-time code cannot use them - an interrupt landing between the
; two halves of SwitchBank would corrupt the stack - so the vblank handler and the
; tileset animation player write the MBC registers directly with SET_MBC_BANK and
; restore from wD59C_CurrentROMBank instead.
;
; Map of this file
; ----------------
;   $0000-$014F  interrupt vectors, the entry point and the cartridge header
;   $0150-$0520  call_00_0150_Init and the outer game loop
;   $0521-$076C  level setup, the bonus timer and the fly power-up
;   $076D-$08FB  demo scripts, memcopy, and the screen / image loaders
;   $08FC-$0A53  the graphics transfer queue, in both streamed and blocking form
;   $0A54-$0BA0  the vblank handler and its one VRAM write per frame
;   $0BA1-$0E86  the two LCD STAT handler templates and their vblank hooks
;   $0E87-$1077  VRAM clearing, the DMG palette fade, and CGB palette upload
;   $1078-$112E  banking, joypad reading and the CheckInput* helpers
;   $112F-$1263  sound effects and music
;   $1264-$3BF3  included from bank00_bg_map.asm and friends - see the INCLUDEs below
;   $3BF4-$3C71  hub tv screen requests and the remote totals
;   $3C72-$3FFF  the password screen heading strip
; ==================================================================

    reti

; ------------------------------------------------------------------
; Interrupt vectors. Only two are ever enabled - Init writes
; IEF_VBLANK | IEF_STAT to rIE and nothing changes it afterwards - so the timer,
; serial and joypad entries are `reti` stubs that can never be reached.
;
; The LCD STAT vector is the unusual one: it jumps into RAM, because the handler is
; not fixed code but a template copied into wCCA0_LcdIsrCode and then patched in
; place. See call_00_0bb9_InstallLcdIsr and the two templates at $0BE5 and $0D49
; ------------------------------------------------------------------
SECTION "isrVBlank", ROM0[$0040]
isrVBlank:
    jp   call_00_0a54_VBlank_Handler                                    ;; 00:0040 $c3 $54 $0a

SECTION "isrLCDC", ROM0[$0048]
isrLCDC:
    jp   wCCA0_LcdIsrCode                                         ;; 00:0048 $c3 $a0 $cc

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
; The cartridge entry point and header. The $30 bytes reserved at $0104 are the
; Nintendo logo, filled in by rgbfix rather than stored here.
;
; Note the header claims CART_ROM_MBC5 but the code drives the cart as an MBC1 with
; the upper-bits trick - see SET_MBC_BANK
    nop                                                ;; 00:0100 $00
    jp   call_00_0150_Init                                   ;; 00:0101 $c3 $50 $01
    ds   $30                                           ;; 00:0104
    db   "GEX GECKO", $00, $00, $00, $00, $00, $00     ;; 00:0134
    db   CART_COMPATIBLE_DMG_GBC                       ;; 00:0143
    db   $34, $5a                                      ;; 00:0144 ; new licensee code "4Z" (Crave)
    db   CART_INDICATOR_GB                             ;; 00:0146
    db   CART_ROM_MBC5, CART_ROM_1024KB, CART_SRAM_NONE ;; 00:0147
    db   CART_DEST_NON_JAPANESE, $33, $00              ;; 00:014a ; old licensee $33 = use the new code above
    ds   $03                                           ;; 00:014d ; version, header checksum, global checksum

SECTION "bank00_0150", ROM0[$0150]

call_00_0150_Init:
; Cold boot. Runs once, from the entry point at $0100, and falls through into the
; outer game loop below - it never returns.
;
; The A register the boot ROM leaves behind is the only way to tell a CGB from a
; DMG, so it is saved across the RAM wipe and consulted twice: once immediately, to
; get WRAM bank 1 mapped before anything writes to $D000, and once afterwards to
; set wD59E_OnGBCFlag, which every colour-specific branch in the ROM reads.
;
; In order: shut the LCD down cleanly at the top of vblank, disable SRAM, zero all
; of $C000-$DFFE, set up the window position and DMG palettes, install the OAM DMA
; routine in HRAM, wipe VRAM, seed the bank stack, arm the vblank and LCD STAT
; interrupts, switch the LCD back on, start the audio driver, and on CGB flip to
; double speed
    di                                                 ;; 00:0150 $f3
    ld   SP, $fffe                                     ;; 00:0151 $31 $fe $ff
    push AF                                            ;; 00:0154 $f5 ; keep the boot ROM's A
    cp   A, BOOT_A_CGB                                 ;; 00:0155 $fe $11
    jr   NZ, .jr_00_015d                               ;; 00:0157 $20 $04
    ld   A, WRAM_BANK_GAME_STATE                       ;; 00:0159 $3e $01
    ldh  [rSVBK], A                                    ;; 00:015b $e0 $70
.jr_00_015d:
    ; Spin until the first line of vblank before clearing LCDCF_ON, so the LCD is
    ; never switched off mid-frame
    ldh  A, [rLY]                                      ;; 00:015d $f0 $44
    cp   A, LY_VBLANK_START                            ;; 00:015f $fe $91
    jr   NZ, .jr_00_015d                               ;; 00:0161 $20 $fa
    ldh  A, [rLCDC]                                    ;; 00:0163 $f0 $40
    and  A, ~LCDCF_ON & $FF                            ;; 00:0165 $e6 $7f
    ldh  [rLCDC], A                                    ;; 00:0167 $e0 $40
    xor  A, A                                          ;; 00:0169 $af
    ld   [MBC1SRamEnable], A                           ;; 00:016a $ea $01 $00
    ld   [MBC1SRamBankingMode], A                                    ;; 00:016d $ea $01 $60
    ; Zero $C000-$DFFE by seeding one byte and copying it forward over itself
    ld   HL, wC000_BgMapTileIds                                     ;; 00:0170 $21 $00 $c0
    ld   DE, wC000_BgMapTileIds+1                                     ;; 00:0173 $11 $01 $c0
    ld   BC, $1fff                                     ;; 00:0176 $01 $ff $1f
    ld   [HL], $00                                     ;; 00:0179 $36 $00
    call call_00_07b0_MemCopy                                  ;; 00:017b $cd $b0 $07
    xor  A, A                                          ;; 00:017e $af
    ldh  [rSCX], A                                     ;; 00:017f $e0 $43
    ldh  [rSCY], A                                     ;; 00:0181 $e0 $42
    ld   [wD59E_OnGBCFlag], A                                    ;; 00:0183 $ea $9e $d5
    ; Window at x = 7 (flush left) and y = $8F, i.e. parked one line below the
    ; screen. LCD_ISR_RASTER_EFFECT is what pulls the hud into view mid-frame
    ld   A, $07                                        ;; 00:0186 $3e $07
    ldh  [rWX], A                                      ;; 00:0188 $e0 $4b
    ld   A, $8f                                        ;; 00:018a $3e $8f
    ldh  [rWY], A                                      ;; 00:018c $e0 $4a
    ld   A, $e4                                        ;; 00:018e $3e $e4 ; 3-2-1-0, the identity DMG palette
    ld   [wDACB_DefaultBGP], A                                    ;; 00:0190 $ea $cb $da
    ld   [wDACC_DefaultOBP0], A                                    ;; 00:0193 $ea $cc $da
    ld   A, $00                                        ;; 00:0196 $3e $00
    ld   [wDACD_DefaultOBP1], A                                    ;; 00:0198 $ea $cd $da
    pop  AF                                            ;; 00:019b $f1
    cp   A, BOOT_A_CGB                                 ;; 00:019c $fe $11
    jr   NZ, .jr_00_01ac                               ;; 00:019e $20 $0c
    ld   A, $01                                        ;; 00:01a0 $3e $01
    ld   [wD59E_OnGBCFlag], A                                    ;; 00:01a2 $ea $9e $d5
    SELECT_VRAM_BANK 0                                 ;; 00:01a5 $3e $00 $e0 $4f
    call call_00_0f9d_UploadCgbPalettes                ;; 00:01a9 $cd $9d $0f
.jr_00_01ac:
    ; OAM DMA has to run from HRAM, because the CPU can only reach HRAM while the
    ; transfer is in progress
    ld   HL, call_00_0ef7_OamDmaRoutine                                      ;; 00:01ac $21 $f7 $0e
    ld   DE, hFF80_OamDmaRoutine                                     ;; 00:01af $11 $80 $ff
    ld   BC, $0a                                       ;; 00:01b2 $01 $0a $00
    call call_00_07b0_MemCopy                                  ;; 00:01b5 $cd $b0 $07
    call call_00_0e87_ClearVRAMAndResetScroll                                  ;; 00:01b8 $cd $87 $0e
    ; Seed the bank stack with one entry (bank 1) and point the stack pointer at it
    ld   HL, wD59A_PtrToBankStackPosition                                     ;; 00:01bb $21 $9a $d5
    ld   DE, wD58A_BankStack                                     ;; 00:01be $11 $8a $d5
    ld   A, BANK_01                                        ;; 00:01c1 $3e $01
    ld   [HL], E                                       ;; 00:01c3 $73
    inc  HL                                            ;; 00:01c4 $23
    ld   [HL], D                                       ;; 00:01c5 $72
    ld   [wD59C_CurrentROMBank], A                                    ;; 00:01c6 $ea $9c $d5
    ld   [DE], A                                       ;; 00:01c9 $12
    SET_MBC_BANK                                       ;; 00:01ca
    ld   A, LCD_ISR_NONE                               ;; 00:01d5 $3e $00
    call call_00_0bb9_InstallLcdIsr                                  ;; 00:01d7 $cd $b9 $0b
    xor  A, A                                          ;; 00:01da $af
    ldh  [rIF], A                                      ;; 00:01db $e0 $0f
    ld   A, STATF_MODE00                               ;; 00:01dd $3e $08 ; STAT fires on hblank
    ldh  [rSTAT], A                                    ;; 00:01df $e0 $41
    ld   A, IEF_VBLANK | IEF_STAT                      ;; 00:01e1 $3e $03
    ldh  [rIE], A                                      ;; 00:01e3 $e0 $ff
    ld   A, LCDC_GAMEPLAY                              ;; 00:01e5 $3e $c7
    call call_00_0f32_SetLCDC                                  ;; 00:01e7 $cd $32 $0f
    ; Bank $21 is the audio bank until the first song change picks another. Audio_Init
    ; is identical in all four banks, so which one runs it does not matter - but it
    ; points the driver's table pointer at its OWN bank, which is why this has to be
    ; set to the same bank the FARCALL enters
    ld   A, BANK_AUDIO_DEFAULT                         ;; 00:01ea $3e $21
    ld   [wD788_CurrentAudioBank], A                                    ;; 00:01ec $ea $88 $d7
    FARCALL call_21_4000_Audio_Init
    ld   A, $ff                                        ;; 00:01fa $3e $ff ; no song playing yet
    ld   [wD78A_MusicId], A                                    ;; 00:01fc $ea $8a $d7
    ei                                                 ;; 00:01ff $fb
    ; CGB only: the whole game runs in double-speed mode. rP1 is set to $30 first
    ; because `stop` reads the joypad lines, and a held button there would hang it
    ld   A, [wD59E_OnGBCFlag]                                    ;; 00:0200 $fa $9e $d5
    and  A, A                                          ;; 00:0203 $a7
    jr   Z, .jr_00_0210                                ;; 00:0204 $28 $0a
    ld   A, P1F_GET_NONE                               ;; 00:0206 $3e $30
    ldh  [rP1], A                                      ;; 00:0208 $e0 $00
    ld   A, KEY1F_PREPARE                              ;; 00:020a $3e $01
    ldh  [rKEY1], A                                    ;; 00:020c $e0 $4d
    stop                                               ;; 00:020e $10 $00
.jr_00_0210:
    ; Overwritten before it is ever read - see wD61D_AttractDemoIndex
    ld   A, $03                                        ;; 00:0210 $3e $03
    ld   [wD61D_AttractDemoIndex], A                                    ;; 00:0212 $ea $1d $d6
    FARCALL call_01_4f87_Password_ClearEntryGrid

; ==================================================================
; The outer game loop, $0220-$051E.
;
; This is not a subroutine and there is no `ret` anywhere in it - it is one long
; chain of labels that Init falls into and that only ever jumps backwards into
; itself. Reading it as a state machine, the states are:
;
;   .jp_00_0220_SoftReset  the four title screens, in order. Reached again from
;                          A+B+SELECT+START held during play
;   .jp_00_0254            the title options menu. Picking START GAME goes to
;                          .jp_00_029d, PASSWORD to .jr_00_02b8, and letting the
;                          menu time out starts an attract demo instead
;   .jp_00_029d            new game: hand out PLAYER_STARTING_LIVES and wipe all
;                          LEVEL_COUNT entries of wD629_RemoteProgressFlags
;   .jr_00_02b8            enter a level. Shared by "new game", "password
;                          accepted" and "warped out of a level into another one"
;   .jp_00_02ee            level setup proper - music, mission select, entity and
;                          collectible tables, the mission's cutscene
;   .jp_00_0370_GameOver   respawn setup. Everything that has to be reset per LIFE
;                          rather than per level lives here, which is why losing a
;                          life re-enters at this label with the level intact
;   .jp_00_0428            the per-frame loop
;
; The per-frame loop is deliberately short: wait for vblank, check the three exit
; conditions in wD621_WarpFlags, check for pause, then run one pass of the entity
; update and the deferred VRAM work. Everything that actually draws happens either
; in the vblank handler or in the LCD STAT handler.
; ==================================================================
.jp_00_0220_SoftReset:
    ld   A, MENU_TYPE_TITLE_SPLASH                                        ;; 00:0220 $3e $14
    FARCALL call_01_4000_MenuLoad
    ld   A, MENU_TYPE_TITLE_CRAVE                                        ;; 00:022d $3e $13
    FARCALL call_01_4000_MenuLoad
    ld   A, MENU_TYPE_TITLE_DAVID                                        ;; 00:023a $3e $16
    FARCALL call_01_4000_MenuLoad
    ld   A, MENU_TYPE_TITLE_SCREEN                                        ;; 00:0247 $3e $10
    FARCALL call_01_4000_MenuLoad
.jp_00_0254:
    ld   A, MUSIC_MEDIA_DIMENSION                                        ;; 00:0254 $3e $07
    call call_00_120c_SetupMusic                                  ;; 00:0256 $cd $0c $12
    xor  A, A                                          ;; 00:0259 $af
    ld   [wD61E_DemoModeEnabled], A                                    ;; 00:025a $ea $1e $d6
    ld   A, MENU_TYPE_TITLE_OPTIONS                                        ;; 00:025d $3e $07
    FARCALL call_01_4000_MenuLoad
    cp   A, MENU_OPTION_ENTER_PASSWORD                 ;; 00:026a $fe $30
    jr   Z, .jr_00_02b8                                ;; 00:026c $28 $4a
    cp   A, MENU_OPTION_START_GAME                         ;; 00:026e $fe $10
    jr   Z, .jp_00_029d                                ;; 00:0270 $28 $2b
    ; neither option was picked, so the only way out was the timeout - fall into the
    ; attract demo. Anything else means the title screen came back some other way
    cp   A, MENU_RESULT_TIMED_OUT                      ;; 00:0272 $fe $70
    jr   NZ, .jp_00_0254                               ;; 00:0274 $20 $de
    ; Round-robin to the next of the four demos - except the result is thrown away.
    ; `inc A / and DEMO_COUNT - 1` computes it into A and the very next instruction
    ; overwrites A, so the stored index is always DEMO_INDEX_FORCED and the attract
    ; mode always plays Samurai Night Fever. The other three demos are unreachable
    ld   HL, wD61D_AttractDemoIndex                                     ;; 00:0276 $21 $1d $d6
    ld   A, [HL]                                       ;; 00:0279 $7e
    inc  A                                             ;; 00:027a $3c
    and  A, DEMO_COUNT - 1                             ;; 00:027b $e6 $03 ; dead
    ld   A, DEMO_INDEX_FORCED                          ;; 00:027d $3e $02
    ld   [HL], A                                       ;; 00:027f $77
    ld   A, $01                                        ;; 00:0280 $3e $01
    ld   [wD61E_DemoModeEnabled], A                                    ;; 00:0282 $ea $1e $d6
    ld   HL, wD61D_AttractDemoIndex                                     ;; 00:0285 $21 $1d $d6
    ld   L, [HL]                                       ;; 00:0288 $6e
    ld   H, $00                                        ;; 00:0289 $26 $00
    add  HL, HL                                        ;; 00:028b $29
    ld   DE, data_00_0771_DemoInputScriptPointers                                      ;; 00:028c $11 $71 $07
    add  HL, DE                                        ;; 00:028f $19
    ld   A, [HL+]                                      ;; 00:0290 $2a
    ld   [wD61B_DemoInputsPtrLo], A                                    ;; 00:0291 $ea $1b $d6
    ld   A, [HL]                                       ;; 00:0294 $7e
    ld   [wD61C_DemoInputsPtrHi], A                                    ;; 00:0295 $ea $1c $d6
    ld   A, $01                                        ;; 00:0298 $3e $01
    ld   [wD61F_Demo_FramesUntilNextInput], A                                    ;; 00:029a $ea $1f $d6
.jp_00_029d:
    ; Start a new game: full lives and no progress recorded for any level. This is
    ; also where the game-over screen comes back to when the player continues
    ld   A, PLAYER_STARTING_LIVES                      ;; 00:029d $3e $05
    ld   [wD73D_LivesRemaining], A                     ;; 00:029f $ea $3d $d7
    ld   HL, wD629_RemoteProgressFlags                 ;; 00:02a2 $21 $29 $d6
    ld   B, LEVEL_COUNT                                ;; 00:02a5 $06 $1e
.jr_00_02a7:
    ld   [HL], $00                                     ;; 00:02a7 $36 $00
    inc  HL                                            ;; 00:02a9 $23
    dec  B                                             ;; 00:02aa $05
    jr   NZ, .jr_00_02a7                               ;; 00:02ab $20 $fa
    FARCALL call_01_4349_Password_BuildPayload
.jr_00_02b8:
    ; Pick the level to enter. In a demo it comes from the demo table; otherwise A
    ; still holds whatever got us here - $00 (the hub) for a new game, or the level
    ; the password decoded to
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:02b8 $fa $1e $d6
    and  A, A                                          ;; 00:02bb $a7
    jr   Z, .jr_00_02c9                                ;; 00:02bc $28 $0b
    ld   HL, wD61D_AttractDemoIndex                                     ;; 00:02be $21 $1d $d6
    ld   L, [HL]                                       ;; 00:02c1 $6e
    ld   H, $00                                        ;; 00:02c2 $26 $00
    ld   DE, data_00_076d_DemoLevelIds                                      ;; 00:02c4 $11 $6d $07
    add  HL, DE                                        ;; 00:02c7 $19
    ld   A, [HL]                                       ;; 00:02c8 $7e
.jr_00_02c9:
    ld   [wD624_CurrentLevelId], A                                    ;; 00:02c9 $ea $24 $d6
    ld   A, MENU_TYPE_ENTERING_LEVEL_NAME              ;; 00:02cc $3e $08
    FARCALL call_01_4000_MenuLoad
    xor  A, A                                          ;; 00:02d9 $af
    ld   [wD621_WarpFlags], A                                    ;; 00:02da $ea $21 $d6
    ld   [wD628_MediaDimensionRespawnPoint], A         ;; 00:02dd $ea $28 $d6
    ld   [wD64F_MissionRemoteTotal], A                                    ;; 00:02e0 $ea $4f $d6
    ld   [wD650_HiddenRemoteTotal], A                                    ;; 00:02e3 $ea $50 $d6
    ld   [wD651_BonusMissionTotal], A                                    ;; 00:02e6 $ea $51 $d6
    ld   A, PLAYER_ACTION_SPAWN                                        ;; 00:02e9 $3e $00
    ld   [wD744_Player_SpawnAction], A                                    ;; 00:02eb $ea $44 $d7
.jp_00_02ee:
    ; Per-level setup. A demo skips all of it - no mission select, no cutscene -
    ; and drops straight to the shared tail at .jr_00_0350
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:02ee $fa $1e $d6
    and  A, A                                          ;; 00:02f1 $a7
    jr   NZ, .jr_00_0350                               ;; 00:02f2 $20 $5c
    ld   A, [wD621_WarpFlags]                                    ;; 00:02f4 $fa $21 $d6
    and  A, WARP_ENTERED_TV                            ;; 00:02f7 $e6 $04
    jr   Z, .jr_00_0306                                ;; 00:02f9 $28 $0b
    FARCALL call_01_42bd_HandleTVWarp
.jr_00_0306:
    call call_00_11e0_PlayMusicBasedOnLevel                                  ;; 00:0306 $cd $e0 $11
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0309 $fa $24 $d6
    and  A, A                                          ;; 00:030c $a7
    jr   Z, .jr_00_0350                                ;; 00:030d $28 $41
    call call_00_0562_Collectible_InitForLevel                                  ;; 00:030f $cd $62 $05
    FARCALL call_01_4297_MenuLoad_MissionSelect
    FARCALL call_0b_4000_CollectibleList_LoadForCurrentLevel
    FARCALL call_02_6eb1_Entities_ClearFlagsTable
    call call_00_3c3f_Remotes_RecountAllTotals                                  ;; 00:0333 $cd $3f $3c
    call call_00_12e4_BlockPatch_Init                                  ;; 00:0336 $cd $e4 $12
    ld   A, DRAGON_SEGMENT_COUNT                       ;; 00:0339 $3e $0a
    ld   [wD613_Dragon_SegmentsRemaining], A                                    ;; 00:033b $ea $13 $d6
    xor  A, A                                          ;; 00:033e $af
    ld   [wD614_Dragon_HitTimer], A                                    ;; 00:033f $ea $14 $d6
    ld   [wD617_TailSpinChargeCounter], A                                    ;; 00:0342 $ea $17 $d6
    ; Every mission has its own intro cutscene, in the slot CUTSCENE_SLOT_MISSION_BASE
    ; + mission number of this level's cutscene table
    ld   A, [wD627_CurrentMission]                                    ;; 00:0345 $fa $27 $d6
    add  A, CUTSCENE_SLOT_MISSION_BASE                 ;; 00:0348 $c6 $0a
    ld   C, A                                          ;; 00:034a $4f ; C = cutscene slot
    ld   B, $01                                        ;; 00:034b $06 $01 ; B = skippable
    call call_00_2329_Cutscene_LoadAndRun                                  ;; 00:034d $cd $29 $23
.jr_00_0350:
    ; Shared tail of level setup, reached by demos too
    xor  A, A                                          ;; 00:0350 $af
    ld   [wD618_CheckpointSpawnId], A                                    ;; 00:0351 $ea $18 $d6
    ld   [wD686_Unused], A                                    ;; 00:0354 $ea $86 $d6
    ld   [wD625_TotalsMenuPage], A                                    ;; 00:0357 $ea $25 $d6
    ld   [wD648_CollectibleMilestoneIndex], A                                    ;; 00:035a $ea $48 $d6
    ; Cache this level's silver and gold remote bits where the hud can reach them
    ; without indexing the progress table again
    ld   HL, wD624_CurrentLevelId                                     ;; 00:035d $21 $24 $d6
    ld   L, [HL]                                       ;; 00:0360 $6e
    ld   H, $00                                        ;; 00:0361 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 00:0363 $11 $29 $d6
    add  HL, DE                                        ;; 00:0366 $19
    ld   A, [HL]                                       ;; 00:0367 $7e
    and  A, REMOTE_HIDDEN_MASK                         ;; 00:0368 $e6 $18
    ld   [wD64C_CurrentLevel_HiddenRemoteFlags], A                                    ;; 00:036a $ea $4c $d6
    call call_00_0562_Collectible_InitForLevel                                  ;; 00:036d $cd $62 $05
.jp_00_0370_GameOver:
    ; Per-LIFE setup. Losing a life re-enters here with the level already loaded, so
    ; everything reset below is state that must not survive a death: power-ups, the
    ; per-life kill counters, the level's gameplay clock, and every pending VRAM
    ; request left over from the previous life
    xor  A, A                                          ;; 00:0370 $af
    ld   [wD742_Player_CurrentFly], A                                    ;; 00:0371 $ea $42 $d7
    ld   [wD750_Player_DamageCooldownTimer], A                                    ;; 00:0374 $ea $50 $d7
    ld   [wD751_Player_CircuitPowerUpTimerLo], A                                    ;; 00:0377 $ea $51 $d7
    ld   [wD752_Player_CircuitPowerUpTimerHi], A                                    ;; 00:037a $ea $52 $d7
    ld   [wD755_FlyPowerup2_TimerLo], A                                    ;; 00:037d $ea $55 $d7
    ld   [wD756_FlyPowerup2_TimerHi], A                                    ;; 00:0380 $ea $56 $d7
    ld   [wD753_FlyPowerup1_TimerLo], A                                    ;; 00:0383 $ea $53 $d7
    ld   [wD754_FlyPowerup1_TimerHi], A                                    ;; 00:0386 $ea $54 $d7
    ld   [wD772_BreakablesDestroyedCount], A                 ;; 00:0389 $ea $72 $d7
    ld   [wD773_HuntersDefeatedCount], A               ;; 00:038c $ea $73 $d7
    ld   [wD774_MushroomsDestroyedCount], A                                    ;; 00:038f $ea $74 $d7
    ld   [wD73C_GameplayFrameCounter], A                                    ;; 00:0392 $ea $3c $d7 ; restart the level's gameplay clock; wD73B is never reset
    ld   [wD6F9_BgMap_LoadingFlags], A                                    ;; 00:0395 $ea $f9 $d6
    ld   [wD60E_HUDDirtyFlags], A                                    ;; 00:0398 $ea $0e $d6
    ld   [wD60F_GfxTransferFlags], A                                    ;; 00:039b $ea $0f $d6
    ld   [wD77B_BlockPatch_VramWritePending], A                                    ;; 00:039e $ea $7b $d7
    ld   [wD77D_BlockPatch_StepsRemaining], A                                    ;; 00:03a1 $ea $7d $d7
    ld   [wD72F_TilesetAnim_FrameCount], A                                    ;; 00:03a4 $ea $2f $d7
    ld   [wD71E_EntityGfxQueueCount], A                                    ;; 00:03a7 $ea $1e $d7
    ld   [wD5A3_ConveyorPowerTimer1], A                                    ;; 00:03aa $ea $a3 $d5
    ld   [wD5A4_ConveyorPowerTimer2], A                                    ;; 00:03ad $ea $a4 $d5
    ld   [wD5A5_ConveyorPowerTimer3], A                                    ;; 00:03b0 $ea $a5 $d5
    ld   A, PLAYER_MAX_HEALTH                          ;; 00:03b3 $3e $04
    ld   [wD741_Player_Health], A                                    ;; 00:03b5 $ea $41 $d7
    FARCALL call_0b_4000_CollectibleList_LoadForCurrentLevel
    FARCALL call_02_6eb1_Entities_ClearFlagsTable
    call call_00_3c3f_Remotes_RecountAllTotals                                  ;; 00:03ce $cd $3f $3c
    call call_00_12e4_BlockPatch_Init                                  ;; 00:03d1 $cd $e4 $12
    call call_00_0547_LevelTimer_Init                                  ;; 00:03d4 $cd $47 $05
    call call_00_0562_Collectible_InitForLevel                                  ;; 00:03d7 $cd $62 $05
.jr_00_03da:
    ; Respawn point proper. Reached both from the per-life setup above and, at
    ; 00:043d, from a door warp - which is why the boss and conveyor state is reset
    ; here a second time rather than only in the block above
    ld   A, DRAGON_SEGMENT_COUNT                       ;; 00:03da $3e $0a
    ld   [wD613_Dragon_SegmentsRemaining], A                                    ;; 00:03dc $ea $13 $d6
    xor  A, A                                          ;; 00:03df $af
    ld   [wD614_Dragon_HitTimer], A                                    ;; 00:03e0 $ea $14 $d6
    ld   [wD617_TailSpinChargeCounter], A                                    ;; 00:03e3 $ea $17 $d6
    ld   [wD5A3_ConveyorPowerTimer1], A                                    ;; 00:03e6 $ea $a3 $d5
    ld   [wD5A4_ConveyorPowerTimer2], A                                    ;; 00:03e9 $ea $a4 $d5
    ld   [wD5A5_ConveyorPowerTimer3], A                                    ;; 00:03ec $ea $a5 $d5
    ld   A, TV_SCREEN_NONE                             ;; 00:03ef $3e $ff
    ld   [wD610_MediaDimension_TVScreenId], A                                    ;; 00:03f1 $ea $10 $d6
    ld   A, $01                                        ;; 00:03f4 $3e $01
    ld   [wD743_Player_UpdateFlag], A                                    ;; 00:03f6 $ea $43 $d7
    FARCALL call_0b_4efe_Player_SetSpawnPosition
    call call_00_1264_BgMap_LoadFull                                  ;; 00:0404 $cd $64 $12
    FARCALL call_02_6e17_Entities_InitAndSpawnAll
    call call_00_0521_Screen_PresentAndFadeIn                                  ;; 00:0412 $cd $21 $05
    jr   .jp_00_0428                                   ;; 00:0415 $18 $11
.jp_00_0417:
    ; Resume after a menu closed. The level is still loaded and the entities are
    ; still in their slots, so this only has to rebuild what the menu overwrote:
    ; the bg map, the entity tiles and palettes, and the screen itself
    call call_00_1264_BgMap_LoadFull                                  ;; 00:0417 $cd $64 $12
    FARCALL call_02_71c8_Entities_QueueGraphicsAndPalettes
    call call_00_0521_Screen_PresentAndFadeIn                                  ;; 00:0425 $cd $21 $05
.jp_00_0428:
    ; ---- one pass of the in-game loop ----
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:0428 $cd $b4 $0a
    ; A+B+SELECT+START and nothing else is the soft reset. `cp` rather than `and`,
    ; so any fifth button held cancels it
    ld   A, [wD59F_RawInputs]                                    ;; 00:042b $fa $9f $d5
    cp   A, PADF_A | PADF_B | PADF_SELECT | PADF_START                                        ;; 00:042e $fe $0f
    jp   Z, .jp_00_0220_SoftReset                                ;; 00:0430 $ca $20 $02
    ; The three reasons to leave, tested in priority order. A door warp is the
    ; cheapest - the map changes but the level does not, so it only clears the
    ; entity slots and respawns
    ld   A, [wD621_WarpFlags]                                    ;; 00:0433 $fa $21 $d6
    and  A, WARP_ENTERED_DOOR                          ;; 00:0436 $e6 $08
    jr   Z, .jr_00_043f                                ;; 00:0438 $28 $05
    call call_00_38f0_Entity_ClearAllSlots                                  ;; 00:043a $cd $f0 $38
    jr   .jr_00_03da                                   ;; 00:043d $18 $9b
.jr_00_043f:
    ; Entering a tv (or collecting a gold remote) restarts level setup
    ld   A, [wD621_WarpFlags]                                    ;; 00:043f $fa $21 $d6
    and  A, WARP_ENTERED_TV                            ;; 00:0442 $e6 $04
    jp   NZ, .jp_00_02ee                               ;; 00:0444 $c2 $ee $02
    ; Death: spend a life and respawn, or run out and show the game over screen.
    ; The check is `lives != 0` AFTER call_00_0696_Player_Die already decremented,
    ; so reaching zero is what ends the game
    ld   A, [wD621_WarpFlags]                                    ;; 00:0447 $fa $21 $d6
    and  A, WARP_DIED                                  ;; 00:044a $e6 $02
    jr   Z, .jr_00_0468                                ;; 00:044c $28 $1a
    ld   A, [wD73D_LivesRemaining]                                    ;; 00:044e $fa $3d $d7
    and  A, A                                          ;; 00:0451 $a7
    jp   NZ, .jp_00_0370_GameOver                               ;; 00:0452 $c2 $70 $03
    FARCALL call_01_43bd_MenuLoad_GameOver
    ; GameOver ends on MENU_TYPE_GAME_OVER_TOTALS, so "RESUME PLAY" there is the
    ; continue option - it restarts at .jp_00_029d with a fresh set of lives.
    ; Anything else falls back to the title
    cp   A, MENU_OPTION_RESUME_PLAY                    ;; 00:0460 $fe $80
    jp   Z, .jp_00_029d                                ;; 00:0462 $ca $9d $02
    jp   .jp_00_0254                                   ;; 00:0465 $c3 $54 $02
.jr_00_0468:
    ; Pause. START opens the pause menu for wherever we are; SELECT opens the totals
    ; screen, but only in the hub. Both CheckInput helpers used here compare rather
    ; than mask, so holding a direction as well suppresses the pause
    call call_00_110d_CheckInputStart                                  ;; 00:0468 $cd $0d $11
    jr   Z, .jr_00_0479                                ;; 00:046b $28 $0c
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:046d $fa $24 $d6
    and  A, A                                          ;; 00:0470 $a7
    ld   A, MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION        ;; 00:0471 $3e $00
    jr   Z, .jr_00_0486                                ;; 00:0473 $28 $11
    ld   A, MENU_TYPE_PAUSED_IN_LEVEL                  ;; 00:0475 $3e $02
    jr   .jr_00_0486                                   ;; 00:0477 $18 $0d
.jr_00_0479:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0479 $fa $24 $d6
    and  A, A                                          ;; 00:047c $a7
    jr   NZ, .jr_00_04a9                               ;; 00:047d $20 $2a
    call call_00_1118_CheckInputSelect                                  ;; 00:047f $cd $18 $11
    jr   Z, .jr_00_04a9                                ;; 00:0482 $28 $25
    ld   A, MENU_TYPE_VIEW_TOTALS                      ;; 00:0484 $3e $05
.jr_00_0486:
    FARCALL call_01_4000_MenuLoad
    ; the pause and totals menus can only end the level by returning
    ; MENU_OPTION_CONFIRM_QUIT; every other result just resumes play
    cp   A, MENU_OPTION_CONFIRM_QUIT                   ;; 00:0491 $fe $60
    jp   NZ, .jp_00_0417                               ;; 00:0493 $c2 $17 $04
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0496 $fa $24 $d6
    and  A, A                                          ;; 00:0499 $a7
    jp   Z, .jp_00_0254                                ;; 00:049a $ca $54 $02
    xor  A, A                                          ;; 00:049d $af
    ld   [wD624_CurrentLevelId], A                                    ;; 00:049e $ea $24 $d6
    ld   A, PLAYER_ACTION_EXIT_TV                                        ;; 00:04a1 $3e $14
    ld   [wD744_Player_SpawnAction], A                                    ;; 00:04a3 $ea $44 $d7
    jp   .jp_00_02ee                                   ;; 00:04a6 $c3 $ee $02
.jr_00_04a9:
    ; During an attract demo, any button press - or the script running out, which
    ; call_02_4939_Player_UpdateMain signals by storing $FF over
    ; wD61E_DemoModeEnabled - drops back to the title options
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:04a9 $fa $1e $d6
    and  A, A                                          ;; 00:04ac $a7
    jr   Z, .jr_00_04bb                                ;; 00:04ad $28 $0c
    cp   A, DEMO_INPUT_END                             ;; 00:04af $fe $ff
    jp   Z, .jp_00_0254                                ;; 00:04b1 $ca $54 $02
    ld   A, [wD59F_RawInputs]                                    ;; 00:04b4 $fa $9f $d5
    and  A, A                                          ;; 00:04b7 $a7
    jp   NZ, .jp_00_0254                               ;; 00:04b8 $c2 $54 $02
.jr_00_04bb:
    ; The Circuit Central power-up announces itself twice: once on the very last
    ; tick, and once every $80 frames while it is still running. The expiry test
    ; looks for the pair reading exactly $0001, i.e. the frame before it hits zero
    ld   A, [wD752_Player_CircuitPowerUpTimerHi]                                    ;; 00:04bb $fa $52 $d7
    and  A, A                                          ;; 00:04be $a7
    jr   NZ, .jr_00_04cd                               ;; 00:04bf $20 $0c
    ld   A, [wD751_Player_CircuitPowerUpTimerLo]                                    ;; 00:04c1 $fa $51 $d7
    cp   A, $01                                        ;; 00:04c4 $fe $01
    jr   NZ, .jr_00_04cd                               ;; 00:04c6 $20 $05
    ld   C, SFX_GEX_POWERUP_EXPIRED                                        ;; 00:04c8 $0e $15
    call call_00_112f_QueueSFX                                  ;; 00:04ca $cd $2f $11
.jr_00_04cd:
    ; Paced off wD73B_VBlankFrameCounter rather than the timer itself, so the
    ; reminder keeps its rhythm across a pause
    ld   HL, wD751_Player_CircuitPowerUpTimerLo                                     ;; 00:04cd $21 $51 $d7
    ld   A, [HL+]                                      ;; 00:04d0 $2a
    or   A, [HL]                                       ;; 00:04d1 $b6
    jr   Z, .jr_00_04e0                                ;; 00:04d2 $28 $0c
    ld   A, [wD73B_VBlankFrameCounter]                                    ;; 00:04d4 $fa $3b $d7
    and  A, $7f                                        ;; 00:04d7 $e6 $7f
    jr   NZ, .jr_00_04e0                               ;; 00:04d9 $20 $05
    ld   C, SFX_GEX_POWERUP_ACTIVE                                        ;; 00:04db $0e $14
    call call_00_112f_QueueSFX                                  ;; 00:04dd $cd $2f $11
.jr_00_04e0:
    ; The actual work of a frame. Note none of this writes VRAM directly - the two
    ; BlockPatch ticks and StageNextGfxTransfer only queue requests for the vblank
    ; handler and the LCD STAT streamer to carry out
    FARCALL call_02_6eba_Entities_UpdateAll
    call call_00_1455_BgMap_LoadDirtyRegions                                  ;; 00:04eb $cd $55 $14
    call call_00_2305_BlockPatch_TickSlots                                  ;; 00:04ee $cd $05 $23
    call call_00_1e5b_BlockPatch_TickSequence                                  ;; 00:04f1 $cd $5b $1e
    call call_00_05c7_FlyPowerup_Update                                  ;; 00:04f4 $cd $c7 $05
    call call_00_08fc_StageNextGfxTransfer                                  ;; 00:04f7 $cd $fc $08
    FARCALL call_0b_5ec3_UpdatePlayerObjPalette
    ; End of one pass of the in-game update loop. wD73C_GameplayFrameCounter is
    ; bumped here rather than in the VBlank handler, so it only advances on frames
    ; that actually ran the loop - not while a menu or cutscene has play suspended
    ld   HL, wD73C_GameplayFrameCounter                                     ;; 00:0505 $21 $3c $d7
    inc  [HL]                                          ;; 00:0508 $34
    ; Once every 256 frames on the global clock, age the three conveyor timers
    ld   A, [wD73B_VBlankFrameCounter]                                    ;; 00:0509 $fa $3b $d7
    and  A, A                                          ;; 00:050c $a7
    jp   NZ, .jp_00_0428                               ;; 00:050d $c2 $28 $04
    ld   HL, wD5A3_ConveyorPowerTimer1                                     ;; 00:0510 $21 $a3 $d5
    ld   B, CONVEYOR_COUNT                             ;; 00:0513 $06 $03
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

call_00_0521_Screen_PresentAndFadeIn:
; Makes a freshly built screen visible. Drawing the entities is only the first of five
; steps; the routine ends by switching the LCD back on and starting a fade in, which is
; what callers want from it.
;
; Builds the OAM list, drains any pending graphics transfers, switches the LCD STAT
; interrupt over to the VRAM streaming handler, reloads the DMG background palette,
; then turns the LCD back on and fades in
    FARCALL call_02_6f80_Entities_DrawAll
    call call_00_0971_ProcessPendingGfxTransfers                                  ;; 00:052c $cd $71 $09
    ld   A, LCD_ISR_VRAM_STREAM                        ;; 00:052f $3e $03
    call call_00_0bae_RequestLcdIsr                                  ;; 00:0531 $cd $ae $0b
    ld   C, $00                                        ;; 00:0534 $0e $00
    FARCALL call_0b_5537_BgPalette_LoadMonoOrGetSpriteParams
    ld   A, LCDC_GAMEPLAY                              ;; 00:0541 $3e $c7
    call call_00_0f56_SetLCDCAndFadeIn                                  ;; 00:0543 $cd $56 $0f
    ret                                                ;; 00:0546 $c9

call_00_0547_LevelTimer_Init:
; Resets the fly power-up popup and arms the bonus level countdown timer.
; Zeros wD687_FlyAnimationState and wD689_FlyAnimationTimer, parks the fly sprite
; offscreen at wD688_FlyAnimationPosition = $A0, then sets the timer to 3:00
; (wD76F_LevelTimer_Minutes = $03, wD770_LevelTimer_SecondsBCD = $00) with a
; $3C frame tick in wD771_LevelTimer_FrameCounter.
; The timer only actually counts down in levels where wD623_CollectibleMode is set
    xor  A, A                                          ;; 00:0547 $af
    ld   [wD687_FlyAnimationState], A                                    ;; 00:0548 $ea $87 $d6
    ld   [wD689_FlyAnimationTimer], A                                    ;; 00:054b $ea $89 $d6
    ld   A, FLY_ANIM_Y_OFFSCREEN                       ;; 00:054e $3e $a0
    ld   [wD688_FlyAnimationPosition], A                                    ;; 00:0550 $ea $88 $d6
    ld   A, LEVEL_TIMER_START_MINUTES                  ;; 00:0553 $3e $03
    ld   [wD76F_LevelTimer_Minutes], A                                    ;; 00:0555 $ea $6f $d7
    xor  A, A                                          ;; 00:0558 $af
    ld   [wD770_LevelTimer_SecondsBCD], A                                    ;; 00:0559 $ea $70 $d7
    ld   A, FRAMES_PER_SECOND                          ;; 00:055c $3e $3c
    ld   [wD771_LevelTimer_FrameCounter], A                                    ;; 00:055e $ea $71 $d7
    ret                                                ;; 00:0561 $c9

call_00_0562_Collectible_InitForLevel:
; Looks up the current level ID in .data_00_0579_CollectibleCountTable and stores the result in 
; both wD649_CollectibleAmount and wD623_CollectibleMode. If zero (level has no collectible quota), returns. 
; Otherwise sets wD623_CollectibleMode = $01 (collectible mode active)
    ld   HL, wD624_CurrentLevelId                                     ;; 00:0562 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:0565 $6e
    ld   H, $00                                        ;; 00:0566 $26 $00
    ld   DE, .data_00_0579_CollectibleCountTable                                      ;; 00:0568 $11 $79 $05
    add  HL, DE                                        ;; 00:056b $19
    ld   A, [HL]                                       ;; 00:056c $7e
    ld   [wD649_CollectibleAmount], A                                    ;; 00:056d $ea $49 $d6
    ld   HL, wD623_CollectibleMode                                     ;; 00:0570 $21 $23 $d6
    ld   [HL], A                                       ;; 00:0573 $77
    and  A, A                                          ;; 00:0574 $a7
    ret  Z                                             ;; 00:0575 $c8
    ld   [HL], $01                                     ;; 00:0576 $36 $01
    ret                                                ;; 00:0578 $c9
.data_00_0579_CollectibleCountTable:
; One byte per level id, LEVEL_COUNT entries. Nonzero means "this is a bonus level":
; the value is the collectible quota, and its mere presence is what puts
; wD623_CollectibleMode into quota mode, which in turn arms the countdown timer and
; flips wD649_CollectibleAmount from a rising score into a falling target.
;
; Only four levels qualify - the four bonus rooms reached through the silver
; remotes. Everything else is $00
    db   $00 ; MAP_MEDIA_DIMENSION
    db   $00 ; MAP_TOON_TV_OUT_OF_TOON
    db   $00 ; MAP_SCREAM_TV_SMELLRAISER
    db   $00 ; MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $00 ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $00 ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $00 ; MAP_UNUSED_06
    db   $00 ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $00 ; MAP_TOON_TV_FINE_TOONING
    db   $00 ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $00 ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   $00 ; MAP_SCREAM_TV_POLTERGEX
    db   $00 ; MAP_UNUSED_0C
    db   $00 ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $00 ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $00 ; MAP_UNUSED_0F
    db   $32 ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $00 ; MAP_UNUSED_11
    db   $00 ; MAP_UNUSED_12
    db   $00 ; MAP_UNUSED_13
    db   $00 ; MAP_UNUSED_14
    db   $1f ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $32 ; MAP_REZOPOLIS_BUGGED_OUT
    db   $32 ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $00 ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   $00 ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $00 ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $00 ; MAP_UNUSED_1B
    db   $00 ; MAP_UNUSED_1C
    db   $00 ; MAP_UNUSED_1D
    db   $00 ; MAP_BOSS_TV_CHANNEL_Z

call_00_0598_LevelTimer_Tick:
; Per-frame tick of the bonus level countdown timer. Decrements
; wD771_LevelTimer_FrameCounter; once per second (every $3C frames) it reloads that
; counter, sets HUD_DIRTY_TIMER in wD60E_HUDDirtyFlags and decrements
; wD770_LevelTimer_SecondsBCD as a BCD value (via daa). When the seconds underflow past
; $00 to $99 they reload to $59 and wD76F_LevelTimer_Minutes is decremented.
; When the minutes go negative they are clamped to $00, the seconds are zeroed and
; WARP_TIME_UP | WARP_ENTERED_TV is OR'd into wD621_WarpFlags, which boots the player
; out of the level with the MENU_TYPE_TIME_UP screen
    ld   HL, wD771_LevelTimer_FrameCounter                                     ;; 00:0598 $21 $71 $d7
    dec  [HL]                                          ;; 00:059b $35
    ret  NZ                                            ;; 00:059c $c0
    ld   [HL], FRAMES_PER_SECOND                       ;; 00:059d $36 $3c
    ld   HL, wD60E_HUDDirtyFlags                                     ;; 00:059f $21 $0e $d6
    set  HUD_DIRTY_TIMER, [HL]                         ;; 00:05a2 $cb $d6
    ld   HL, wD770_LevelTimer_SecondsBCD                                     ;; 00:05a4 $21 $70 $d7
    ld   A, [HL]                                       ;; 00:05a7 $7e
    sub  A, $01                                        ;; 00:05a8 $d6 $01
    daa                                                ;; 00:05aa $27
    ld   [HL], A                                       ;; 00:05ab $77
    cp   A, LEVEL_TIMER_SECONDS_UNDERFLOW              ;; 00:05ac $fe $99
    ret  NZ                                            ;; 00:05ae $c0
    ld   [HL], LEVEL_TIMER_SECONDS_WRAP                ;; 00:05af $36 $59
    ld   HL, wD76F_LevelTimer_Minutes                                     ;; 00:05b1 $21 $6f $d7
    dec  [HL]                                          ;; 00:05b4 $35
    bit  7, [HL]                                       ;; 00:05b5 $cb $7e ; minutes went negative?
    ret  Z                                             ;; 00:05b7 $c8
    ld   [HL], $00                                     ;; 00:05b8 $36 $00
    xor  A, A                                          ;; 00:05ba $af
    ld   [wD770_LevelTimer_SecondsBCD], A                                    ;; 00:05bb $ea $70 $d7
    ld   A, [wD621_WarpFlags]                                    ;; 00:05be $fa $21 $d6
    or   A, WARP_TIME_UP | WARP_ENTERED_TV             ;; 00:05c1 $f6 $14
    ld   [wD621_WarpFlags], A                                    ;; 00:05c3 $ea $21 $d6
    ret                                                ;; 00:05c6 $c9

call_00_05c7_FlyPowerup_Update:
; Per-frame update of the hud row that slides in and out at the bottom of the
; screen. Despite the name this routine does not touch the power-up itself; it only
; drives wD688_FlyAnimationPosition, which is the Y that all eight hud sprites
; share, so moving it slides the whole row.
;
; In a bonus level there is no fly row at all - the hud shows the countdown instead -
; so the whole routine is handed over to call_00_0598_LevelTimer_Tick. That is a
; `jr`, not a call, and it is the only thing that ever ticks the timer.
;
; Otherwise the state in wD687_FlyAnimationState decides which way the row is
; moving. Sliding in stops at FLY_ANIM_Y_ONSCREEN and arms the hold timer; sliding
; out stops at FLY_ANIM_Y_OFFSCREEN and stays there. When the hold expires the state
; advances, and which state it advances to is what gives the row its two visits:
;
;   first visit, in the hub    -> slide out and come back ($42), so the hub's row
;                                 pulses continuously
;   first visit, in a level    -> hand over to the second visit ($81)
;   second visit, health < 2   -> stay on the second visit ($81), i.e. keep the low
;                                 health warning up
;   second visit, healthy      -> slide out and finish ($82)
    ld   A, [wD623_CollectibleMode]                                    ;; 00:05c7 $fa $23 $d6
    and  A, A                                          ;; 00:05ca $a7
    jr   NZ, call_00_0598_LevelTimer_Tick                                ;; 00:05cb $20 $cb
    ld   A, [wD687_FlyAnimationState]                                    ;; 00:05cd $fa $87 $d6
    and  A, FLY_ANIM_SLIDING_IN                        ;; 00:05d0 $e6 $01
    jr   NZ, .jr_00_05e3                               ;; 00:05d2 $20 $0f
    ld   A, [wD687_FlyAnimationState]                                    ;; 00:05d4 $fa $87 $d6
    and  A, FLY_ANIM_SLIDING_OUT                       ;; 00:05d7 $e6 $02
    ret  Z                                             ;; 00:05d9 $c8 ; idle, neither direction
    ld   HL, wD688_FlyAnimationPosition                                     ;; 00:05da $21 $88 $d6
    ld   A, [HL]                                       ;; 00:05dd $7e
    cp   A, FLY_ANIM_Y_OFFSCREEN                       ;; 00:05de $fe $a0
    ret  Z                                             ;; 00:05e0 $c8
    inc  [HL]                                          ;; 00:05e1 $34
    ret                                                ;; 00:05e2 $c9
.jr_00_05e3:
    ; Sliding in. The arrival test is done twice - once on entry for the frame the
    ; row is already parked, once after the decrement for the frame it gets there
    ld   HL, wD688_FlyAnimationPosition                                     ;; 00:05e3 $21 $88 $d6
    ld   A, [HL]                                       ;; 00:05e6 $7e
    cp   A, FLY_ANIM_Y_ONSCREEN                        ;; 00:05e7 $fe $88
    jr   Z, .jr_00_05fe                                ;; 00:05e9 $28 $13
    dec  [HL]                                          ;; 00:05eb $35
    ld   A, [HL]                                       ;; 00:05ec $7e
    cp   A, FLY_ANIM_Y_ONSCREEN                        ;; 00:05ed $fe $88
    ret  NZ                                            ;; 00:05ef $c0
    ; Just arrived: arm the hold. The hub gets a much shorter one, which is what
    ; makes its row pulse rather than sit there
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:05f0 $fa $24 $d6
    and  A, A                                          ;; 00:05f3 $a7
    ld   A, FLY_ANIM_HOLD_LEVEL                        ;; 00:05f4 $3e $ff
    jr   NZ, .jr_00_05fa                               ;; 00:05f6 $20 $02
    ld   A, FLY_ANIM_HOLD_HUB                          ;; 00:05f8 $3e $05
.jr_00_05fa:
    ld   [wD689_FlyAnimationTimer], A                                    ;; 00:05fa $ea $89 $d6
    ret                                                ;; 00:05fd $c9
.jr_00_05fe:
    ; Parked on screen: run the hold down, then advance the state
    ld   HL, wD689_FlyAnimationTimer                                     ;; 00:05fe $21 $89 $d6
    dec  [HL]                                          ;; 00:0601 $35
    ret  NZ                                            ;; 00:0602 $c0
    ld   A, [wD687_FlyAnimationState]                                    ;; 00:0603 $fa $87 $d6
    and  A, FLY_ANIM_SECOND_VISIT                      ;; 00:0606 $e6 $80
    jr   NZ, .jr_00_061c                               ;; 00:0608 $20 $12
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:060a $fa $24 $d6
    and  A, A                                          ;; 00:060d $a7
    jr   NZ, .jr_00_0616                               ;; 00:060e $20 $06
    ld   A, FLY_ANIM_FIRST_VISIT | FLY_ANIM_SLIDING_OUT ;; 00:0610 $3e $42
    ld   [wD687_FlyAnimationState], A                                    ;; 00:0612 $ea $87 $d6
    ret                                                ;; 00:0615 $c9
.jr_00_0616:
    ld   A, FLY_ANIM_SECOND_VISIT | FLY_ANIM_SLIDING_IN ;; 00:0616 $3e $81
    ld   [wD687_FlyAnimationState], A                                    ;; 00:0618 $ea $87 $d6
    ret                                                ;; 00:061b $c9
.jr_00_061c:
    ld   A, [wD741_Player_Health]                                    ;; 00:061c $fa $41 $d7
    cp   A, $02                                        ;; 00:061f $fe $02
    jr   C, .jr_00_0616                                ;; 00:0621 $38 $f3 ; low health: keep it up
    ld   A, FLY_ANIM_SECOND_VISIT | FLY_ANIM_SLIDING_OUT ;; 00:0623 $3e $82
    ld   [wD687_FlyAnimationState], A                                    ;; 00:0625 $ea $87 $d6
    ret                                                ;; 00:0628 $c9

call_00_0629_FlyPowerup_StartExit:
; Sends the hud row away. It slides in one last time (the state is SLIDING_IN, not
; OUT - the row is normally already parked, so this just runs the hold), holds for
; FLY_ANIM_HOLD_LEVEL frames, and only then leaves through the second-visit branch
; of FlyPowerup_Update
    ld   A, FLY_ANIM_SECOND_VISIT | FLY_ANIM_SLIDING_IN ;; 00:0629 $3e $81
    ld   [wD687_FlyAnimationState], A                                    ;; 00:062b $ea $87 $d6
    ld   A, FLY_ANIM_HOLD_LEVEL                        ;; 00:062e $3e $ff
    ld   [wD689_FlyAnimationTimer], A                                    ;; 00:0630 $ea $89 $d6
    ret                                                ;; 00:0633 $c9

call_00_0634_FlyPowerup_StartEntry:
; Brings the hud row on screen for its first visit. Called whenever something the
; row displays has changed - a collectible, a life, a death
    ld   A, FLY_ANIM_FIRST_VISIT | FLY_ANIM_SLIDING_IN ;; 00:0634 $3e $41
    ld   [wD687_FlyAnimationState], A                                    ;; 00:0636 $ea $87 $d6
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:0639 $fa $24 $d6
    and  A, A                                          ;; 00:063c $a7
    ld   A, FLY_ANIM_HOLD_LEVEL                        ;; 00:063d $3e $ff
    jr   NZ, .jr_00_0643                               ;; 00:063f $20 $02
    ld   A, FLY_ANIM_HOLD_HUB                          ;; 00:0641 $3e $05
.jr_00_0643:
    ld   [wD689_FlyAnimationTimer], A                                    ;; 00:0643 $ea $89 $d6
    ret                                                ;; 00:0646 $c9

call_00_0647_Player_SwapFlyPowerup:
; Eats a new fly power-up, swapping it with the currently held one. 
; Stores the new power-up ID (A) into wD742_Player_CurrentFly, saves the old value in C. 
; Farcalls FlyPowerup_LoadParticlePalette to update the particle effect palette for the new power-up. 
; Then dispatches on the old power-up ID (C): 
; if FLY_POWERUP_HEALTH → Player_ResetHealth (the health fly was active, restore health on swap-out);
; if FLY_POWERUP_EXTRA_LIFE → Player_ExtraLifeFly (extra life);
; if FLY_POWERUP_SHIELD_1 → arms wD753_FlyPowerup1_Timer with FLY_POWERUP_DURATION, and
;   writes A to wD755_FlyPowerup2_TimerLo/Hi - see the note below;
; if FLY_POWERUP_SHIELD_2 → zeroes wD753_FlyPowerup1_Timer and arms
;   wD755_FlyPowerup2_Timer with FLY_POWERUP_DURATION.
; Returns without action if the old power-up was FLY_POWERUP_NONE or any other value.
;
; The two branches are NOT mirror images, though they look it. The $02 path does
; `xor a` first, so it genuinely clears the other timer. The $01 path jumps in
; straight off `cp a,$01` with A still holding $01, so instead of clearing
; wD755/wD756 it writes $01 to both - a timer value of $0101.
;
; That is very likely a bug rather than intent: call_00_075b_Player_IsInvincible
; treats any nonzero value in that pair as an active shield, so swapping out fly
; $01 leaves the other power-up's shield reading as live for $0101 ticks. Not
; verified on hardware; the asymmetry is plain in the code either way
    ld   hl,wD742_Player_CurrentFly
    ld   c,[hl]                                        ; C = the fly being displaced
    ld   [hl],a
    push bc
    FARCALL call_0b_5f1b_FlyPowerup_LoadParticlePalette
    pop  bc
    ld   a,c
    cp   a,FLY_POWERUP_HEALTH
    jr   z,call_00_06b7_Player_ResetHealth
    cp   a,FLY_POWERUP_EXTRA_LIFE
    jr   z,call_00_068a_Player_ExtraLifeFly
    cp   a,FLY_POWERUP_SHIELD_1
    jr   z,.jr_00_067a
    cp   a,FLY_POWERUP_SHIELD_2
    ret  nz                                            ; FLY_POWERUP_NONE, or an id with no effect
    xor  a
    ld   [wD753_FlyPowerup1_TimerLo],a
    ld   [wD754_FlyPowerup1_TimerHi],a
    ld   de,FLY_POWERUP_DURATION
    ld   hl,wD755_FlyPowerup2_TimerLo
    ld   [hl],e
    inc  hl
    ld   [hl],d
    ret
.jr_00_067a:
    ; Falls in here with A still holding FLY_POWERUP_SHIELD_1 from the `cp` above,
    ; so these two stores write $01 instead of clearing the pair - see the header
    ld   [wD755_FlyPowerup2_TimerLo],a
    ld   [wD756_FlyPowerup2_TimerHi],a
    ld   de,FLY_POWERUP_DURATION
    ld   hl,wD753_FlyPowerup1_TimerLo
    ld   [hl],e
    inc  hl
    ld   [hl],d
    ret

call_00_068a_Player_ExtraLifeFly:
; Grants one life, clamped at PLAYER_MAX_LIVES, and brings the hud row on to show
; it. The clamp is the `inc` itself: if it wrapped to zero the count was already
; $FF, so the `dec` puts it back
    call call_00_074d_HUD_MarkLivesDirty                                  ;; 00:068a $cd $4d $07
    ld   HL, wD73D_LivesRemaining                                     ;; 00:068d $21 $3d $d7
    inc  [HL]                                          ;; 00:0690 $34
    jr   NZ, call_00_0634_FlyPowerup_StartEntry                              ;; 00:0691 $20 $a1
    dec  [HL]                                          ;; 00:0693 $35
    jr   call_00_0634_FlyPowerup_StartEntry                                  ;; 00:0694 $18 $9e

call_00_0696_Player_Die:
; Starts the death animation and spends a life. The main loop only notices the death
; later, when call_02_49d0_PlayerAction_Death raises WARP_DIED at the end of that
; animation - which is why the life is deducted here and the game-over test at
; 00:044e reads "no lives left" rather than "last life".
;
; Two places are exempt from losing a life: the hub, where there is nothing to die
; to, and the bonus levels, which end on their timer instead
    ld   A, PLAYER_ACTION_DEATH                                      ;; 00:0696 $3e $10
    FARCALL call_02_4ccd_Player_RequestAction
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:06a3 $fa $24 $d6
    and  A, A                                          ;; 00:06a6 $a7
    ret  Z                                             ;; 00:06a7 $c8
    ld   A, [wD623_CollectibleMode]                                    ;; 00:06a8 $fa $23 $d6
    and  A, A                                          ;; 00:06ab $a7
    ret  NZ                                            ;; 00:06ac $c0
    call call_00_074d_HUD_MarkLivesDirty                                  ;; 00:06ad $cd $4d $07
    ld   HL, wD73D_LivesRemaining                                     ;; 00:06b0 $21 $3d $d7
    dec  [HL]                                          ;; 00:06b3 $35
    jp   call_00_0634_FlyPowerup_StartEntry                                  ;; 00:06b4 $c3 $34 $06

call_00_06b7_Player_ResetHealth:
; Refills health and sends the hud row away. Reached only by swapping out
; FLY_POWERUP_HEALTH, so eating a second fly is what cashes in the first one
    ld   hl, wD741_Player_Health
    ld   [hl], PLAYER_MAX_HEALTH
    jp   call_00_0629_FlyPowerup_StartExit

call_00_06bf_Player_TakeDamage:
; One hit. A held fly absorbs it entirely - the fly is dropped and health is left
; alone - so wD742_Player_CurrentFly is effectively an extra hit point that is
; spent before the real ones.
;
; Without a fly, health goes down by one and reaching zero jumps to Player_Die.
; Surviving requests PLAYER_ACTION_TAKE_DAMAGE, unless the player is already in
; PLAYER_ACTION_HIT_BOUNCE, in which case the current animation is left to finish
    call call_00_075b_Player_IsInvincible                                  ;; 00:06bf $cd $5b $07
    ret  NZ                                            ;; 00:06c2 $c0
    ld   HL, wD742_Player_CurrentFly                                     ;; 00:06c3 $21 $42 $d7
    ld   A, [HL]                                       ;; 00:06c6 $7e
    ld   [HL], $00                                     ;; 00:06c7 $36 $00
    and  A, A                                          ;; 00:06c9 $a7
    jr   NZ, .jr_00_06d2                               ;; 00:06ca $20 $06
    ld   HL, wD741_Player_Health                                     ;; 00:06cc $21 $41 $d7
    dec  [HL]                                          ;; 00:06cf $35
    jr   Z, call_00_0696_Player_Die                                 ;; 00:06d0 $28 $c4
.jr_00_06d2:
    ld   A, [wD201_Player_ActionId]                                    ;; 00:06d2 $fa $01 $d2
    and  A, PLAYER_ACTION_MASK                                        ;; 00:06d5 $e6 $1f
    cp   A, PLAYER_ACTION_HIT_BOUNCE                                        ;; 00:06d7 $fe $1c
    jp   Z, call_00_0629_FlyPowerup_StartExit                                 ;; 00:06d9 $ca $29 $06
    ld   A, PLAYER_ACTION_TAKE_DAMAGE                                        ;; 00:06dc $3e $0f
    FARCALL call_02_4ccd_Player_RequestAction
    jp   call_00_0629_FlyPowerup_StartExit                                    ;; 00:06e9 $c3 $29 $06

call_00_06ec_Player_ObtainedCollectible:
; One collectible picked up. wD649_CollectibleAmount means two different things
; depending on wD623_CollectibleMode, and this is the routine that keeps both:
;
;   quota mode (a bonus level)  the counter falls toward zero. It stops at zero and
;                               ignores further pickups once WARP_TIME_UP is set, so
;                               a collectible grabbed on the buzzer does not count
;   free mode (everywhere else) the counter rises, clamped at $FF, and crossing a
;                               milestone pays out
;
; The milestones are .data_00_074a_CollectibleMilestoneThresholds, walked by
; wD648_CollectibleMilestoneIndex. The first two just reset the counter and advance
; the index. The last one is different: the index stops there, and the threshold
; test becomes "is the count an exact multiple of COLLECTIBLE_EXTRA_LIFE_STEP",
; computed by subtracting it until the result is zero or goes negative.
;
; Note which way round the flag test goes at 00:073e - the extra life is awarded
; when REMOTE_SILVER_BIT is ALREADY set. The first multiple of 50 only sets it and
; returns empty handed; every multiple after that pays
    ld   C, SFX_COLLECTIBLE                                        ;; 00:06ec $0e $06
    call call_00_112f_QueueSFX                                  ;; 00:06ee $cd $2f $11
    call call_00_074d_HUD_MarkLivesDirty                                  ;; 00:06f1 $cd $4d $07
    call call_00_0634_FlyPowerup_StartEntry                                  ;; 00:06f4 $cd $34 $06
    ld   A, [wD623_CollectibleMode]                                    ;; 00:06f7 $fa $23 $d6
    and  A, A                                          ;; 00:06fa $a7
    jr   Z, .jr_00_070b                                ;; 00:06fb $28 $0e
    ld   A, [wD621_WarpFlags]                                    ;; 00:06fd $fa $21 $d6
    and  A, WARP_TIME_UP                               ;; 00:0700 $e6 $10
    ret  NZ                                            ;; 00:0702 $c0
    ld   HL, wD649_CollectibleAmount                                     ;; 00:0703 $21 $49 $d6
    ld   A, [HL]                                       ;; 00:0706 $7e
    and  A, A                                          ;; 00:0707 $a7
    ret  Z                                             ;; 00:0708 $c8 ; quota already met
    dec  [HL]                                          ;; 00:0709 $35
    ret                                                ;; 00:070a $c9
.jr_00_070b:
    ; Free mode. The inc/dec pair is the $FF clamp
    ld   HL, wD649_CollectibleAmount                                     ;; 00:070b $21 $49 $d6
    inc  [HL]                                          ;; 00:070e $34
    jr   NZ, .jr_00_0713                               ;; 00:070f $20 $02
    dec  [HL]                                          ;; 00:0711 $35
    ret                                                ;; 00:0712 $c9
.jr_00_0713:
    ld   HL, wD648_CollectibleMilestoneIndex                                     ;; 00:0713 $21 $48 $d6
    ld   L, [HL]                                       ;; 00:0716 $6e
    ld   H, $00                                        ;; 00:0717 $26 $00
    ld   DE, .data_00_074a_CollectibleMilestoneThresholds                                      ;; 00:0719 $11 $4a $07
    add  HL, DE                                        ;; 00:071c $19
    ld   A, [HL]                                       ;; 00:071d $7e
    cp   A, COLLECTIBLE_EXTRA_LIFE_STEP                ;; 00:071e $fe $32
    jr   Z, .jr_00_0733                                ;; 00:0720 $28 $11
    ; One of the two early milestones: reset the counter and move the index on
    ld   HL, wD649_CollectibleAmount                                     ;; 00:0722 $21 $49 $d6
    cp   A, [HL]                                       ;; 00:0725 $be
    ret  NZ                                            ;; 00:0726 $c0
    ld   [HL], $00                                     ;; 00:0727 $36 $00
    ld   HL, wD648_CollectibleMilestoneIndex                                     ;; 00:0729 $21 $48 $d6
    inc  [HL]                                          ;; 00:072c $34
    ld   HL, wD60E_HUDDirtyFlags                                     ;; 00:072d $21 $0e $d6
    set  HUD_DIRTY_COLLECTIBLES, [HL]                  ;; 00:0730 $cb $de
    ret                                                ;; 00:0732 $c9
.jr_00_0733:
    ; Last milestone: is the count an exact multiple of the step?
    ld   A, [wD649_CollectibleAmount]                                    ;; 00:0733 $fa $49 $d6
.jr_00_0736:
    sub  A, COLLECTIBLE_EXTRA_LIFE_STEP                ;; 00:0736 $d6 $32
    ret  C                                             ;; 00:0738 $d8 ; overshot - not a multiple
    jr   NZ, .jr_00_0736                               ;; 00:0739 $20 $fb
    ld   HL, wD64C_CurrentLevel_HiddenRemoteFlags                                     ;; 00:073b $21 $4c $d6
    bit  REMOTE_SILVER_BIT, [HL]                       ;; 00:073e $cb $5e
    jp   NZ, call_00_068a_Player_ExtraLifeFly                                ;; 00:0740 $c2 $8a $06
    set  REMOTE_SILVER_BIT, [HL]                       ;; 00:0743 $cb $de
    xor  A, A                                          ;; 00:0745 $af
    ld   [wD649_CollectibleAmount], A                                    ;; 00:0746 $ea $49 $d6
    ret                                                ;; 00:0749 $c9
.data_00_074a_CollectibleMilestoneThresholds:
; Successive collectible counts that pay out, indexed by
; wD648_CollectibleMilestoneIndex. The index never advances past the last entry, so
; COLLECTIBLE_EXTRA_LIFE_STEP is where the table effectively stops being a list and
; starts being a repeating interval
    db   COLLECTIBLE_MILESTONE_1, COLLECTIBLE_MILESTONE_2, COLLECTIBLE_EXTRA_LIFE_STEP ;; 00:074a

call_00_074d_HUD_MarkLivesDirty:
; Asks the vblank handler to redraw the lives digits. Suppressed during a demo and
; in the bonus levels, neither of which shows a lives counter at all
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 00:074d $fa $1e $d6
    ld   HL, wD623_CollectibleMode                                     ;; 00:0750 $21 $23 $d6
    or   A, [HL]                                       ;; 00:0753 $b6
    ret  NZ                                            ;; 00:0754 $c0
    ld   HL, wD60E_HUDDirtyFlags                                     ;; 00:0755 $21 $0e $d6
    set  HUD_DIRTY_LIVES, [HL]                         ;; 00:0758 $cb $ce
    ret                                                ;; 00:075a $c9

call_00_075b_Player_IsInvincible:
; Returns NZ if the player cannot be damaged right now and Z if they can, which is
; why callers read `call ... / ret NZ`.
;
; Three things grant it: wD750_Player_DamageCooldownTimer (the flicker after a hit)
; and the two fly shield timer pairs. call_00_0647_Player_SwapFlyPowerup is what
; pins down which pair is which - it arms FlyPowerup1 when the outgoing fly was
; FLY_POWERUP_SHIELD_1 and FlyPowerup2 when it was FLY_POWERUP_SHIELD_2
    ld   A, [wD750_Player_DamageCooldownTimer]                                    ;; 00:075b $fa $50 $d7
    and  A, A                                          ;; 00:075e $a7
    ret  NZ                                            ;; 00:075f $c0
    ld   HL, wD755_FlyPowerup2_TimerLo                                     ;; 00:0760 $21 $55 $d7
    ld   A, [HL+]                                      ;; 00:0763 $2a
    or   A, [HL]                                       ;; 00:0764 $b6
    ret  NZ                                            ;; 00:0765 $c0
    ld   HL, wD753_FlyPowerup1_TimerLo                                     ;; 00:0766 $21 $53 $d7
    ld   A, [HL+]                                      ;; 00:0769 $2a
    or   A, [HL]                                       ;; 00:076a $b6
    ret  NZ                                            ;; 00:076b $c0
    ret                                                ;; 00:076c $c9

data_00_076d_DemoLevelIds:
; level id played by each of the 4 attract-mode demos, indexed by wD61D_AttractDemoIndex
    db   MAP_TOON_TV_FINE_TOONING
    db   MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210

data_00_0771_DemoInputScriptPointers:
; One pointer per demo, in the same order as data_00_076d_DemoLevelIds and indexed
; by the same wD61D_AttractDemoIndex - so entry n is the recorded input for the
; level named by entry n of that table.
;
; Only entry 2 is ever reachable (see wD61D_AttractDemoIndex), and it is the only
; one that is a real recording. The other three are the same three-byte stub: hold
; RIGHT for $64 frames and stop. Whether those were placeholders or trimmed-down
; leftovers is not recoverable from the ROM, but they were plainly never finished
    dw   .data_00_0779_DemoScript_FineTooning, .data_00_077c_DemoScript_WwwDotComCom
    dw   .data_00_077f_DemoScript_SamuraiNightFever, .data_00_079e_DemoScript_Pangaea90210
.data_00_0779_DemoScript_FineTooning:
    demo_input $64, PADF_RIGHT
    demo_input_end
.data_00_077c_DemoScript_WwwDotComCom:
    demo_input $64, PADF_RIGHT
    demo_input_end
.data_00_077f_DemoScript_SamuraiNightFever:
; The attract demo everyone has actually seen: run right, jump the gaps, then work
; left across the ledges before the script runs out and the title comes back
    demo_input $30, PADF_RIGHT
    demo_input $08, PADF_RIGHT | PADF_A
    demo_input $40, PADF_RIGHT
    demo_input $08, PADF_RIGHT | PADF_A
    demo_input $a4, PADF_RIGHT
    demo_input $40, $00                                ; stand still
    demo_input $60, PADF_RIGHT
    demo_input $04, PADF_RIGHT | PADF_B
    demo_input $6c, PADF_RIGHT
    demo_input $20, PADF_LEFT
    demo_input $08, PADF_LEFT | PADF_A
    demo_input $20, PADF_LEFT
    demo_input $10, PADF_LEFT | PADF_B
    demo_input $50, PADF_LEFT
    demo_input $a0, PADF_RIGHT
    demo_input_end
.data_00_079e_DemoScript_Pangaea90210:
    demo_input $64, PADF_RIGHT
    demo_input_end

call_00_07a1_FarMemCopy:
; MemCopy from another bank: BC bytes from bank A:HL to DE. The three pushes are
; only there because SwitchBank clobbers HL, DE and BC on its way through the bank
; stack, so the arguments have to survive it
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
; Copy BC bytes from HL to DE, ascending. BC = 0 copies $10000 bytes rather than
; none, since the count is tested after the decrement.
;
; Init uses it as a memset by pointing DE one byte past HL, so each write feeds the
; next read. There is no overlap check and no unrolling; the unrolled tile-sized
; version is call_00_0b6d_CopyTileRows
    ld   A, [HL+]                                      ;; 00:07b0 $2a
    ld   [DE], A                                       ;; 00:07b1 $12
    inc  DE                                            ;; 00:07b2 $13
    dec  BC                                            ;; 00:07b3 $0b
    ld   A, B                                          ;; 00:07b4 $78
    or   A, C                                          ;; 00:07b5 $b1
    jr   NZ, call_00_07b0_MemCopy                              ;; 00:07b6 $20 $f8
    ret                                                ;; 00:07b8 $c9

call_00_07b9_GetPointerFromTable:
; HL = word read from DE[A]. A is the entry index, DE points at a table of little
; endian pointers. Used all over the place for jump/frame/palette tables
    ld   L, A                                          ;; 00:07b9 $6f
    ld   H, $00                                        ;; 00:07ba $26 $00
    add  HL, HL                                        ;; 00:07bc $29
    add  HL, DE                                        ;; 00:07bd $19
    ld   E, [HL]                                       ;; 00:07be $5e
    inc  HL                                            ;; 00:07bf $23
    ld   H, [HL]                                       ;; 00:07c0 $66
    ld   L, E                                          ;; 00:07c1 $6b
    ret                                                ;; 00:07c2 $c9

call_00_07c3_Screen_LoadTilesAndTilemap:
; Draws a rectangular block of graphics into the top-left of the screen using the
; parameter block at wD6A5_ScreenDraw_TileDataBank..wD6AE.
; Copies wD6AD_ScreenDraw_TileDataSize bytes of tiles from
; wD6AB_ScreenDraw_TileDataPtr to _VRAM + wD6A6_ScreenDraw_FirstTileId * 16, then walks a
; wD6A7_ScreenDraw_WidthInTiles x wD6A8_ScreenDraw_HeightInTiles tilemap at
; wD6A9_ScreenDraw_TilemapPtr, writing (tile id + wD6AF_ScreenDraw_TileIdBase) to _SCRN0.
; On GBC it also writes the matching attribute byte (stored width*height further into
; the same tilemap) to VRAM bank 1. Used for the password keypad and similar overlays
    ld   a,[wD6A5_ScreenDraw_TileDataBank]
    call call_00_1089_SwitchBank
    ld   hl,wD6AD_ScreenDraw_TileDataSize
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    ld   hl,wD6A6_ScreenDraw_FirstTileId
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   de,_VRAM
    add  hl,de
    ld   e,l
    ld   d,h
    ld   hl,wD6AB_ScreenDraw_TileDataPtr
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    call call_00_07b0_MemCopy
    ld   a,[wD6A6_ScreenDraw_FirstTileId]
    ld   [wD6AF_ScreenDraw_TileIdBase],a
    ld   hl,wD6A9_ScreenDraw_TilemapPtr
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    ld   de,_SCRN0
    ld   a,[wD6A8_ScreenDraw_HeightInTiles]
    ld   b,a
.jr_00_07fb:
    ld   a,[wD6A7_ScreenDraw_WidthInTiles]
    ld   c,a
    push de
.jr_00_0800:
    ld   a,[wD59E_OnGBCFlag]
    and  a
    jr   z,.jr_00_0834
    SELECT_VRAM_BANK 1
    push hl
    push de
    push bc
    ld   c,[hl]
    ld   hl,wD6A7_ScreenDraw_WidthInTiles
    ld   e,[hl]
    ld   d,$00
    ld   hl,wD6A8_ScreenDraw_HeightInTiles
    ld   b,[hl]
    ld   hl,$0000
.jr_00_081b:
    add  hl,de
    dec  b
    jr   nz,.jr_00_081b
    ld   e,l
    ld   d,h
    ld   hl,wD6A9_ScreenDraw_TilemapPtr
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,de
    ld   b,$00
    add  hl,bc
    ld   a,[hl]
    pop  bc
    pop  de
    pop  hl
    ld   [de],a
    SELECT_VRAM_BANK 0
.jr_00_0834:
    ld   a,[wD6AF_ScreenDraw_TileIdBase]
    add  [hl]
    ld   [de],a
    inc  hl
    inc  de
    dec  c
    jr   nz,.jr_00_0800
    ; next tilemap row
    pop  de
    ld   a,e
    add  a,SCRN_VX_B
    ld   e,a
    ld   a,d
    adc  a,$00
    ld   d,a
    dec  b
    jr   nz,.jr_00_07fb
    jp   call_00_10a3_RestoreBank

call_00_084d_Screen_LoadFullscreenImage:
; Loads a full 20x18 screen image (title screens, credits, "great job", etc) from
; wD6B0_FullscreenImage_Bank / wD6B1_FullscreenImage_Ptr.
; The image is one blob: FULLSCREEN_IMAGE_BLOCK0_SIZE bytes of tiles for _VRAM,
; FULLSCREEN_IMAGE_BLOCK1_SIZE more for _VRAM+$1000, and on GBC a 20x18 attribute map
; after that. Nothing in the blob is a tilemap - the tilemap is generated instead, as
; a running id 0..$FF over 24 rows, so the tiles land on the screen in the order they
; appear in ROM and every image can use all 256 ids
    ld   A, [wD6B0_FullscreenImage_Bank]                                    ;; 00:084d $fa $b0 $d6
    call call_00_1089_SwitchBank                                  ;; 00:0850 $cd $89 $10
    ld   HL, wD6B1_FullscreenImage_Ptr                                     ;; 00:0853 $21 $b1 $d6
    ld   A, [HL+]                                      ;; 00:0856 $2a
    ld   H, [HL]                                       ;; 00:0857 $66
    ld   L, A                                          ;; 00:0858 $6f
    ld   DE, _VRAM                                     ;; 00:0859 $11 $00 $80
    ld   BC, FULLSCREEN_IMAGE_BLOCK0_SIZE              ;; 00:085c $01 $00 $0f
    call call_00_07b0_MemCopy                                  ;; 00:085f $cd $b0 $07
    ld   DE, _VRAM+$1000                                     ;; 00:0862 $11 $00 $90
    ld   BC, FULLSCREEN_IMAGE_BLOCK1_SIZE              ;; 00:0865 $01 $80 $07
    call call_00_07b0_MemCopy                                  ;; 00:0868 $cd $b0 $07
    ld   A, [wD59E_OnGBCFlag]                                    ;; 00:086b $fa $9e $d5
    and  A, A                                          ;; 00:086e $a7
    jr   Z, .jr_00_0891                                ;; 00:086f $28 $20
    ; HL is left pointing just past the tile data, i.e. at the attribute map
    SELECT_VRAM_BANK 1                                 ;; 00:0871 $3e $01 $e0 $4f
    ld   DE, _SCRN0                                     ;; 00:0875 $11 $00 $98
    ld   C, SCRN_Y_B                                   ;; 00:0878 $0e $12
.jr_00_087a:
    ld   B, SCRN_X_B                                   ;; 00:087a $06 $14
.jr_00_087c:
    ld   A, [HL+]                                      ;; 00:087c $2a
    ld   [DE], A                                       ;; 00:087d $12
    inc  E                                             ;; 00:087e $1c
    dec  B                                             ;; 00:087f $05
    jr   NZ, .jr_00_087c                               ;; 00:0880 $20 $fa
    ; step to the next tilemap row: SCRN_VX_B - SCRN_X_B bytes of off-screen map
    ld   A, E                                          ;; 00:0882 $7b
    add  A, SCRN_VX_B - SCRN_X_B                       ;; 00:0883 $c6 $0c
    ld   E, A                                          ;; 00:0885 $5f
    ld   A, D                                          ;; 00:0886 $7a
    adc  A, $00                                        ;; 00:0887 $ce $00
    ld   D, A                                          ;; 00:0889 $57
    dec  C                                             ;; 00:088a $0d
    jr   NZ, .jr_00_087a                               ;; 00:088b $20 $ed
    SELECT_VRAM_BANK 0                                 ;; 00:088d $3e $00 $e0 $4f
.jr_00_0891:
    ; Generate the tilemap. Two passes of 12 rows, each pass restarting the tile id
    ; at 0 and wrapping through $FF, which covers 24 rows in total - six more than
    ; the screen shows, but the extra rows cost nothing and the loop is smaller
    ld   HL, _SCRN0                                     ;; 00:0891 $21 $00 $98
    ld   DE, SCRN_VX_B - SCRN_X_B                      ;; 00:0894 $11 $0c $00
    ld   B, $0c                                        ;; 00:0897 $06 $0c
    ld   A, $02                                        ;; 00:0899 $3e $02
.jr_00_089b:
    push AF                                            ;; 00:089b $f5
    xor  A, A                                          ;; 00:089c $af
.jr_00_089d:
    ld   C, SCRN_X_B                                   ;; 00:089d $0e $14
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

call_00_08b1_MediaDimension_CopyTVAttributes:
; Writes the TV_ATTR_BLOCK_WIDTH x TV_ATTR_BLOCK_HEIGHT GBC attribute block for one
; hub tv into the VRAM bank 1 tilemap at HL. The caller has already set rVBK = 1;
; this routine only restores the ROM bank, not the VRAM bank.
;
; Every tv screen image in bank $13 is laid out the same way - TV_ATTR_OFFSET_IN_IMAGE
; bytes of tile data followed by its attribute block - so the attributes are found by
; looking the image up in .data_00_08e6_TVAttributeTable and skipping past the tiles.
; Rows are written with a full tilemap stride, hence the SCRN_VX_B - TV_ATTR_BLOCK_WIDTH
; added to L at the end of each one.
;
; Preserves HL, DE and BC, which is unusual for this file and is why the caller can
; treat it as a drop-in inside its own tilemap walk
    push HL                                            ;; 00:08b1 $e5
    push DE                                            ;; 00:08b2 $d5
    push BC                                            ;; 00:08b3 $c5
    push HL                                            ;; 00:08b4 $e5
    ld   A, BANK_TV_ATTRIBUTES                         ;; 00:08b5 $3e $13
    call call_00_1089_SwitchBank                                  ;; 00:08b7 $cd $89 $10
    call call_00_2e3a_MapData_GetTVPaletteId                                  ;; 00:08ba $cd $3a $2e
    ld   DE, .data_00_08e6_TVAttributeTable                                      ;; 00:08bd $11 $e6 $08
    call call_00_07b9_GetPointerFromTable                                  ;; 00:08c0 $cd $b9 $07
    ld   DE, TV_ATTR_OFFSET_IN_IMAGE                   ;; 00:08c3 $11 $40 $02
    add  HL, DE                                        ;; 00:08c6 $19
    ld   E, L                                          ;; 00:08c7 $5d
    ld   D, H                                          ;; 00:08c8 $54
    pop  HL                                            ;; 00:08c9 $e1
    ld   C, TV_ATTR_BLOCK_HEIGHT                       ;; 00:08ca $0e $05
.jr_00_08cc:
    ld   B, TV_ATTR_BLOCK_WIDTH                        ;; 00:08cc $06 $06
.jr_00_08ce:
    ld   A, [DE]                                       ;; 00:08ce $1a
    ld   [HL+], A                                      ;; 00:08cf $22
    inc  DE                                            ;; 00:08d0 $13
    dec  B                                             ;; 00:08d1 $05
    jr   NZ, .jr_00_08ce                               ;; 00:08d2 $20 $fa
    ld   A, L                                          ;; 00:08d4 $7d
    add  A, SCRN_VX_B - TV_ATTR_BLOCK_WIDTH            ;; 00:08d5 $c6 $1a
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
.data_00_08e6_TVAttributeTable:
; One bank $13 image per tv palette id, as returned by
; call_00_2e3a_MapData_GetTVPaletteId - so the id names a channel, not a level.
; Entries 5, 6 and 9 have no channel of their own and fall back to the Scream TV
; screen; there are eleven slots and only eight distinct pictures
    dw   image_013_00_scream_tv_screen
    dw   image_013_15_circuit_central_screen
    dw   image_013_16_kung_fu_theater_screen
    dw   image_013_14_prehistory_channel_screen
    dw   image_013_18_rezopolis_screen
    dw   image_013_00_scream_tv_screen
    dw   image_013_00_scream_tv_screen
    dw   image_013_13_toon_tv_screen
    dw   image_013_19_bonus_tv_screen
    dw   image_013_00_scream_tv_screen
    dw   image_013_17_channel_z_screen

call_00_08fc_StageNextGfxTransfer:
; Stages the next pending graphics transfer for the LCD STAT streaming handler.
; Entity tiles are only one of the five sources it handles - see the bit list below.
; Spins while GFX_XFER_IN_PROGRESS is set, then picks the lowest set request bit in
; wD60F_GfxTransferFlags and works out (bank, source page) for it:
;   bit 0 -> Gex tiles, bank $04 + (wD208_Player_SpriteID >> 6), page $40 + (id & $3F)
;   bit 1 -> entity tiles from wD589_EntityGfxSrcBank / wD588_EntityGfxSrcAddrHi
;   bit 2 -> secondary tileset from wD726_SecondaryTilesetBank / wD728_SecondaryTileset_SrcAddrHi
;   bit 3 -> queued entity gfx from wD71F_GfxCopy_SrcBank / wD721_GfxCopy_SrcAddrHi
;   bit 4 -> media dimension tv screen, bank $14, page $40 + wD610_MediaDimension_TVScreenId
; Copies $10 rows ($100 bytes) into wD100_TilesToLoadBuffer and raises
; GFX_XFER_IN_PROGRESS so the hblank handler starts draining it into VRAM
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:08fc $21 $0f $d6
    bit  GFX_XFER_IN_PROGRESS, [HL]                    ;; 00:08ff $cb $7e
    jr   NZ, call_00_08fc_StageNextGfxTransfer                              ;; 00:0901 $20 $f9
    ld   A, [HL]                                       ;; 00:0903 $7e
    and  A, A                                          ;; 00:0904 $a7
    ret  Z                                             ;; 00:0905 $c8 ; nothing pending
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0906 $21 $0f $d6
    bit  GFX_XFER_PLAYER_GFX, [HL]                     ;; 00:0909 $cb $46
    jr   NZ, .jr_00_091e                               ;; 00:090b $20 $11
    bit  GFX_XFER_ENTITY_GFX, [HL]                     ;; 00:090d $cb $4e
    jr   NZ, .jr_00_0933                               ;; 00:090f $20 $22
    bit  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:0911 $cb $56
    jr   NZ, .jr_00_093e                               ;; 00:0913 $20 $29
    bit  GFX_XFER_QUEUED_ENTITY_GFX, [HL]              ;; 00:0915 $cb $5e
    jr   NZ, .jr_00_0949                               ;; 00:0917 $20 $30
    bit  GFX_XFER_MEDIA_DIMENSION_TV, [HL]             ;; 00:0919 $cb $66
    jr   NZ, .jr_00_0954                               ;; 00:091b $20 $37
    ret                                                ;; 00:091d $c9
.jr_00_091e:
    ; The sprite id is a page number: its top two bits pick one of four consecutive
    ; banks from BANK_PLAYER_GFX_BASE, the low six a page inside that bank
    ld   A, [wD208_Player_SpriteID]                                    ;; 00:091e $fa $08 $d2
    rlca                                               ;; 00:0921 $07
    rlca                                               ;; 00:0922 $07
    and  A, $03                                        ;; 00:0923 $e6 $03
    add  A, BANK_PLAYER_GFX_BASE                       ;; 00:0925 $c6 $04
    call call_00_1089_SwitchBank                                  ;; 00:0927 $cd $89 $10
    ld   A, [wD208_Player_SpriteID]                                    ;; 00:092a $fa $08 $d2
    and  A, GFX_PAGE_INDEX_MASK                        ;; 00:092d $e6 $3f
    add  A, ROMX_PAGE_BASE                             ;; 00:092f $c6 $40
    jr   .jr_00_095e                                   ;; 00:0931 $18 $2b
.jr_00_0933:
    ld   A, [wD589_EntityGfxSrcBank]                                    ;; 00:0933 $fa $89 $d5
    call call_00_1089_SwitchBank                                  ;; 00:0936 $cd $89 $10
    ld   A, [wD588_EntityGfxSrcAddrHi]                                    ;; 00:0939 $fa $88 $d5
    jr   .jr_00_095e                                   ;; 00:093c $18 $20
.jr_00_093e:
    ld   A, [wD726_SecondaryTilesetBank]                                    ;; 00:093e $fa $26 $d7
    call call_00_1089_SwitchBank                                  ;; 00:0941 $cd $89 $10
    ld   A, [wD728_SecondaryTileset_SrcAddrHi]                                    ;; 00:0944 $fa $28 $d7
    jr   .jr_00_095e                                   ;; 00:0947 $18 $15
.jr_00_0949:
    ld   A, [wD71F_GfxCopy_SrcBank]                                    ;; 00:0949 $fa $1f $d7
    call call_00_1089_SwitchBank                                  ;; 00:094c $cd $89 $10
    ld   A, [wD721_GfxCopy_SrcAddrHi]                                    ;; 00:094f $fa $21 $d7
    jr   .jr_00_095e                                   ;; 00:0952 $18 $0a
.jr_00_0954:
    ld   A, BANK_TV_SCREENS                            ;; 00:0954 $3e $14
    call call_00_1089_SwitchBank                                  ;; 00:0956 $cd $89 $10
    ld   A, [wD610_MediaDimension_TVScreenId]                                    ;; 00:0959 $fa $10 $d6
    add  A, ROMX_PAGE_BASE                             ;; 00:095c $c6 $40
.jr_00_095e:
    ; A is the source page. Stage it and let the hblank handler drain the buffer
    ld   H, A                                          ;; 00:095e $67
    ld   L, $00                                        ;; 00:095f $2e $00
    ld   DE, wD100_TilesToLoadBuffer                                     ;; 00:0961 $11 $00 $d1
    ld   B, GFX_PAGE_ROWS                              ;; 00:0964 $06 $10
    call call_00_0b6d_CopyTileRows                                  ;; 00:0966 $cd $6d $0b
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0969 $21 $0f $d6
    set  GFX_XFER_IN_PROGRESS, [HL]                    ;; 00:096c $cb $fe
    jp   call_00_10a3_RestoreBank                                  ;; 00:096e $c3 $a3 $10

call_00_0971_ProcessPendingGfxTransfers:
; Blocking (LCD-off) version of the transfer queue, used when the screen is already
; blanked. Performs every pending copy with plain MemCopy instead of streaming it a few
; bytes at a time through the LCD STAT handler
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0971 $21 $0f $d6
    bit  GFX_XFER_PLAYER_GFX, [HL]                     ;; 00:0974 $cb $46
    call NZ, call_00_098f_CopyPlayerGfxToVRAM                              ;; 00:0976 $c4 $8f $09
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0979 $21 $0f $d6
    bit  GFX_XFER_ENTITY_GFX, [HL]                     ;; 00:097c $cb $4e
    call NZ, call_00_09be_CopyEntityGfxToVRAM                              ;; 00:097e $c4 $be $09
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0981 $21 $0f $d6
    bit  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:0984 $cb $56
    call NZ, call_00_09e3_CopySecondaryTilesetToVRAM                              ;; 00:0986 $c4 $e3 $09
    call call_00_09fd_CopyTVScreenToVRAM                                  ;; 00:0989 $cd $fd $09
    jp   call_00_0a21_FlushEntityGfxQueue                                    ;; 00:098c $c3 $21 $0a

call_00_098f_CopyPlayerGfxToVRAM:
; Clears GFX_XFER_PLAYER_GFX and copies the 256-byte Gex tile page into both VRAM
; pages $8000 and $8100 so whichever one wD586_PlayerGfxVramPage selects is correct
    res  GFX_XFER_PLAYER_GFX, [HL]                     ;; 00:098f $cb $86
    ld   A, [wD208_Player_SpriteID]                                    ;; 00:0991 $fa $08 $d2
    rlca                                               ;; 00:0994 $07
    rlca                                               ;; 00:0995 $07
    and  A, $03                                        ;; 00:0996 $e6 $03
    add  A, BANK_PLAYER_GFX_BASE                       ;; 00:0998 $c6 $04
    call call_00_1089_SwitchBank                                  ;; 00:099a $cd $89 $10
    ld   A, [wD208_Player_SpriteID]                                    ;; 00:099d $fa $08 $d2
    and  A, GFX_PAGE_INDEX_MASK                        ;; 00:09a0 $e6 $3f
    add  A, ROMX_PAGE_BASE                             ;; 00:09a2 $c6 $40
    ld   H, A                                          ;; 00:09a4 $67
    ld   L, $00                                        ;; 00:09a5 $2e $00
    push HL                                            ;; 00:09a7 $e5
    ld   DE, _VRAM                                     ;; 00:09a8 $11 $00 $80
    ld   BC, GFX_PAGE_SIZE                             ;; 00:09ab $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:09ae $cd $b0 $07
    pop  HL                                            ;; 00:09b1 $e1
    ld   DE, _VRAM+GFX_PAGE_SIZE                            ;; 00:09b2 $11 $00 $81
    ld   BC, GFX_PAGE_SIZE                             ;; 00:09b5 $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:09b8 $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:09bb $c3 $a3 $10

call_00_09be_CopyEntityGfxToVRAM:
; Same as above for the entity tile page, filling both $8200 and $8300
    res  GFX_XFER_ENTITY_GFX, [HL]                     ;; 00:09be $cb $8e
    ld   A, [wD589_EntityGfxSrcBank]                                    ;; 00:09c0 $fa $89 $d5
    call call_00_1089_SwitchBank                                  ;; 00:09c3 $cd $89 $10
    ld   A, [wD588_EntityGfxSrcAddrHi]                                    ;; 00:09c6 $fa $88 $d5
    ld   H, A                                          ;; 00:09c9 $67
    ld   L, $00                                        ;; 00:09ca $2e $00
    push HL                                            ;; 00:09cc $e5
    ld   DE, _VRAM+2*GFX_PAGE_SIZE                          ;; 00:09cd $11 $00 $82
    ld   BC, GFX_PAGE_SIZE                             ;; 00:09d0 $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:09d3 $cd $b0 $07
    pop  HL                                            ;; 00:09d6 $e1
    ld   DE, _VRAM+3*GFX_PAGE_SIZE                          ;; 00:09d7 $11 $00 $83
    ld   BC, GFX_PAGE_SIZE                             ;; 00:09da $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:09dd $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:09e0 $c3 $a3 $10

call_00_09e3_CopySecondaryTilesetToVRAM:
; Clears GFX_XFER_SECONDARY_TILESET and copies $240 bytes to VRAM_TILESET_ADDR_1
    res  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:09e3 $cb $96
    ld   A, [wD726_SecondaryTilesetBank]                                    ;; 00:09e5 $fa $26 $d7
    call call_00_1089_SwitchBank                                  ;; 00:09e8 $cd $89 $10
    ld   A, [wD728_SecondaryTileset_SrcAddrHi]                                    ;; 00:09eb $fa $28 $d7
    ld   H, A                                          ;; 00:09ee $67
    ld   L, $00                                        ;; 00:09ef $2e $00
    ld   DE, VRAM_TILESET_ADDR_1                            ;; 00:09f1 $11 $00 $90
    ld   BC, SECONDARY_TILESET_SIZE                    ;; 00:09f4 $01 $40 $02
    call call_00_07b0_MemCopy                                  ;; 00:09f7 $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:09fa $c3 $a3 $10

call_00_09fd_CopyTVScreenToVRAM:
; Hub only. If wD610_MediaDimension_TVScreenId is not $FF, copies that 256-byte screen
; image from bank $14 to VRAM_HUD_TILES ($8600)
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:09fd $fa $24 $d6
    and  A, A                                          ;; 00:0a00 $a7
    ret  NZ                                            ;; 00:0a01 $c0
    ld   A, [wD610_MediaDimension_TVScreenId]                                    ;; 00:0a02 $fa $10 $d6
    cp   A, TV_SCREEN_NONE                             ;; 00:0a05 $fe $ff
    ret  Z                                             ;; 00:0a07 $c8
    ld   A, BANK_TV_SCREENS                            ;; 00:0a08 $3e $14
    call call_00_1089_SwitchBank                                  ;; 00:0a0a $cd $89 $10
    ld   A, [wD610_MediaDimension_TVScreenId]                                    ;; 00:0a0d $fa $10 $d6
    add  A, ROMX_PAGE_BASE                             ;; 00:0a10 $c6 $40
    ld   H, A                                          ;; 00:0a12 $67
    ld   L, $00                                        ;; 00:0a13 $2e $00
    ld   DE, VRAM_HUD_TILES                                 ;; 00:0a15 $11 $00 $86
    ld   BC, GFX_PAGE_SIZE                             ;; 00:0a18 $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:0a1b $cd $b0 $07
    jp   call_00_10a3_RestoreBank                                  ;; 00:0a1e $c3 $a3 $10

call_00_0a21_FlushEntityGfxQueue:
; Drains the entity graphics queue while the LCD is off. Pops a descriptor into
; wD71F_GfxCopy_SrcBank.., and if GFX_XFER_QUEUED_ENTITY_GFX came back set, does the
; wD724_GfxCopy_SizeLo-byte copy immediately and loops for the next queue entry
    FARCALL call_02_722c_EntityGfxQueue_StartNextTransfer
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0a2c $21 $0f $d6
    bit  GFX_XFER_QUEUED_ENTITY_GFX, [HL]              ;; 00:0a2f $cb $5e
    ret  Z                                             ;; 00:0a31 $c8 ; queue empty
    res  GFX_XFER_QUEUED_ENTITY_GFX, [HL]              ;; 00:0a32 $cb $9e
    ld   A, [wD71F_GfxCopy_SrcBank]                                    ;; 00:0a34 $fa $1f $d7
    call call_00_1089_SwitchBank                                  ;; 00:0a37 $cd $89 $10
    ld   HL, wD724_GfxCopy_SizeLo                                     ;; 00:0a3a $21 $24 $d7
    ld   C, [HL]                                       ;; 00:0a3d $4e
    inc  HL                                            ;; 00:0a3e $23
    ld   B, [HL]                                       ;; 00:0a3f $46
    ld   HL, wD722_GfxCopy_DestAddrLo                                     ;; 00:0a40 $21 $22 $d7
    ld   E, [HL]                                       ;; 00:0a43 $5e
    inc  HL                                            ;; 00:0a44 $23
    ld   D, [HL]                                       ;; 00:0a45 $56
    ld   HL, wD720_GfxCopy_SrcAddrLo                                     ;; 00:0a46 $21 $20 $d7
    ld   A, [HL+]                                      ;; 00:0a49 $2a
    ld   H, [HL]                                       ;; 00:0a4a $66
    ld   L, A                                          ;; 00:0a4b $6f
    call call_00_07b0_MemCopy                                  ;; 00:0a4c $cd $b0 $07
    call call_00_10a3_RestoreBank                                  ;; 00:0a4f $cd $a3 $10
    jr   call_00_0a21_FlushEntityGfxQueue                                    ;; 00:0a52 $18 $cd

call_00_0a54_VBlank_Handler:
; The VBlank interrupt handler - isrVBlank at $0040 is a bare `jp` to here, and this
; ends in `reti`. The main loop is elsewhere and calls call_00_0ab4_WaitForInterrupt
; to sync to this.
;
; In order: OAM DMA, the bank 3 VRAM update pass, install a
; newly requested LCD STAT handler if wCCFD_LcdIsrId still has bit 7 clear, run the
; vblank hook that pairs with the installed handler (wCCFE_VBlankHookPtrLo), read the
; joypad, push the shadow LCDC/SCX/SCY and palettes to hardware, then bank in the audio
; driver for its per-frame tick before restoring the previous bank
    push AF                                            ;; 00:0a54 $f5
    push BC                                            ;; 00:0a55 $c5
    push DE                                            ;; 00:0a56 $d5
    push HL                                            ;; 00:0a57 $e5
    call hFF80_OamDmaRoutine                                         ;; 00:0a58 $cd $80 $ff ; calls oam update code in hram
    call call_00_0ac1_VBlank_UpdateVRAM                                  ;; 00:0a5b $cd $c1 $0a
    ld   A, [wCCFD_LcdIsrId]                                    ;; 00:0a5e $fa $fd $cc
    bit  LCD_ISR_INSTALLED_BIT, A                      ;; 00:0a61 $cb $7f
    call Z, call_00_0bb9_InstallLcdIsr                               ;; 00:0a63 $cc $b9 $0b
    ld   HL, wCCFE_VBlankHookPtrLo                                     ;; 00:0a66 $21 $fe $cc
    ld   A, [HL+]                                      ;; 00:0a69 $2a
    ld   H, [HL]                                       ;; 00:0a6a $66
    ld   L, A                                          ;; 00:0a6b $6f
    call call_00_10bd_JumpHL                                  ;; 00:0a6c $cd $bd $10
    call call_00_10be_ReadJoypadInput                                  ;; 00:0a6f $cd $be $10
    ; Release anything blocked in call_00_0ab4_WaitForInterrupt
    ld   A, $01                                        ;; 00:0a72 $3e $01
    ld   [wD622_VBlankDoneFlag], A                                    ;; 00:0a74 $ea $22 $d6
    ld   A, [wD5A0_LCDCValue]                                    ;; 00:0a77 $fa $a0 $d5
    ldh  [rLCDC], A                                    ;; 00:0a7a $e0 $40
    ld   A, [wD5A1_BgMap_ScrollXLo]                                    ;; 00:0a7c $fa $a1 $d5
    ldh  [rSCX], A                                     ;; 00:0a7f $e0 $43
    ld   A, [wD5A2_BgMap_ScrollYLo]                                    ;; 00:0a81 $fa $a2 $d5
    ldh  [rSCY], A                                     ;; 00:0a84 $e0 $42
    call call_00_0f80_VBlank_UpdatePalettes                                  ;; 00:0a86 $cd $80 $0f
    ; Audio runs from vblank, so the audio bank has to be mapped in and then put back
    ; before the interrupt returns - the interrupted code has no idea this happened.
    ; This bypasses call_00_1089_SwitchBank / call_00_10a3_RestoreBank and touches the
    ; MBC registers directly, restoring from wD59C_CurrentROMBank rather than popping
    ; the bank stack, so an interrupt landing mid-SwitchBank cannot corrupt it
    ld   A, [wD788_CurrentAudioBank]                                    ;; 00:0a89 $fa $88 $d7
    SET_MBC_BANK                                       ;; 00:0a8c
    call call_22_410c_Audio_Update                                  ;; 00:0a97 $cd $0c $41
    ; The only write to wD73B_VBlankFrameCounter in the ROM. Because it is here and
    ; not in a game loop, it advances even while play is suspended
    ld   HL, wD73B_VBlankFrameCounter                                     ;; 00:0a9a $21 $3b $d7
    inc  [HL]                                          ;; 00:0a9d $34
    ld   A, [wD59C_CurrentROMBank]                                    ;; 00:0a9e $fa $9c $d5
    SET_MBC_BANK                                       ;; 00:0aa1
    xor  A, A                                          ;; 00:0aac $af
    ldh  [rIF], A                                      ;; 00:0aad $e0 $0f
    pop  HL                                            ;; 00:0aaf $e1
    pop  DE                                            ;; 00:0ab0 $d1
    pop  BC                                            ;; 00:0ab1 $c1
    pop  AF                                            ;; 00:0ab2 $f1
    reti                                               ;; 00:0ab3 $d9

call_00_0ab4_WaitForInterrupt:
; Clears wD622_VBlankDoneFlag and halts until the vblank handler sets it again,
; i.e. blocks until the start of the next frame
    xor  A, A                                          ;; 00:0ab4 $af
    ld   [wD622_VBlankDoneFlag], A                                    ;; 00:0ab5 $ea $22 $d6
.jr_00_0ab8:
    halt                                               ;; 00:0ab8 $76
    nop                                                ;; 00:0ab9 $00
    ld   A, [wD622_VBlankDoneFlag]                                    ;; 00:0aba $fa $22 $d6
    and  A, A                                          ;; 00:0abd $a7
    jr   Z, .jr_00_0ab8                                ;; 00:0abe $28 $f8
    ret                                                ;; 00:0ac0 $c9

call_00_0ac1_VBlank_UpdateVRAM:
; The one VRAM write the game is allowed to do per vblank, banked into BANK_03.
; Priority order:
;   1. a pending bg map scroll column/row (MAP_PENDING_VRAM_TRANSFER)
;   2. a pending block patch attribute write (wD77B_BlockPatch_VramWritePending)
;   3. the next secondary tileset animation frame, when its delay expires
;   4. HUD_DIRTY_COLLECTIBLES / HUD_DIRTY_LIVES / HUD_DIRTY_TIMER reloads
;   5. otherwise the ordinary animated tile update
    ld   A, BANK_03                                    ;; 00:0ac1 $3e $03
    SET_MBC_BANK                                       ;; 00:0ac3
    ld   HL, wD6F9_BgMap_LoadingFlags                                     ;; 00:0ace $21 $f9 $d6
    bit  MAP_PENDING_VRAM_TRANSFER, [HL]                                       ;; 00:0ad1 $cb $7e
    jr   Z, .jr_00_0af0                                ;; 00:0ad3 $28 $1b
    res  MAP_PENDING_VRAM_TRANSFER, [HL]                                       ;; 00:0ad5 $cb $be
    ld   A, [wD6F9_BgMap_LoadingFlags]                                    ;; 00:0ad7 $fa $f9 $d6
    and  A, MAP_SCROLL_DOWN | MAP_SCROLL_UP | MAP_SCROLL_RIGHT | MAP_SCROLL_LEFT  ;; 00:0ada $e6 $0f
    jr   Z, .jr_00_0af0                                ;; 00:0adc $28 $12
    and  A, MAP_SCROLL_DOWN | MAP_SCROLL_UP                                        ;; 00:0ade $e6 $03
    call NZ, call_03_6f5e_VRAM_WriteBgMapRowForVerticalScroll                              ;; 00:0ae0 $c4 $5e $6f
    ld   A, [wD6F9_BgMap_LoadingFlags]                                    ;; 00:0ae3 $fa $f9 $d6
    and  A, MAP_SCROLL_RIGHT | MAP_SCROLL_LEFT                                        ;; 00:0ae6 $e6 $0c
    call NZ, call_03_708d_VRAM_WriteBgMapColumnForHorizontalScroll                              ;; 00:0ae8 $c4 $8d $70
    xor  A, A                                          ;; 00:0aeb $af
    ld   [wD6F9_BgMap_LoadingFlags], A                                    ;; 00:0aec $ea $f9 $d6
    ret                                                ;; 00:0aef $c9
.jr_00_0af0:
    ; Read and clear in one go, so a request raised again between the two is not lost
    ld   HL, wD77B_BlockPatch_VramWritePending                                     ;; 00:0af0 $21 $7b $d7
    ld   A, [HL]                                       ;; 00:0af3 $7e
    res  0, [HL]                                       ;; 00:0af4 $cb $86
    bit  0, A                                          ;; 00:0af6 $cb $47
    jp   NZ, call_00_1779_BlockPatch_WriteAttributes                                ;; 00:0af8 $c2 $79 $17
    ; The secondary tileset's own animation. Unlike the map tile animation further down
    ; this one paces itself: wD732_TilesetAnim_DelayCounter counts vblanks and only
    ; every wD731_TilesetAnim_DelayReload of them plays a frame
    ld   A, [wD72F_TilesetAnim_FrameCount]                                    ;; 00:0afb $fa $2f $d7
    and  A, A                                          ;; 00:0afe $a7
    jr   Z, .jr_00_0b0c                                ;; 00:0aff $28 $0b ; tileset has no animation
    ld   HL, wD731_TilesetAnim_DelayReload                                     ;; 00:0b01 $21 $31 $d7
    ld   A, [HL+]                                      ;; 00:0b04 $2a ; A = reload, HL = counter
    dec  [HL]                                          ;; 00:0b05 $35
    jr   NZ, .jr_00_0b0c                               ;; 00:0b06 $20 $04
    ld   [HL], A                                       ;; 00:0b08 $77
    jp   .jp_00_0b24_TilesetAnim_PlayFrame                                   ;; 00:0b09 $c3 $24 $0b
.jr_00_0b0c:
    ld   A, [wD60E_HUDDirtyFlags]                                    ;; 00:0b0c $fa $0e $d6
    bit  HUD_DIRTY_COLLECTIBLES, A                     ;; 00:0b0f $cb $5f
    call NZ, call_03_6941_HUD_LoadCollectibleSprites                              ;; 00:0b11 $c4 $41 $69
    ld   A, [wD60E_HUDDirtyFlags]                                    ;; 00:0b14 $fa $0e $d6
    bit  HUD_DIRTY_LIVES, A                            ;; 00:0b17 $cb $4f
    jp   NZ, call_03_6d13_HUD_LoadLivesDigits                              ;; 00:0b19 $c2 $13 $6d
    bit  HUD_DIRTY_TIMER, A                            ;; 00:0b1c $cb $57
    jp   NZ, call_03_6ceb_HUD_LoadTimerDigits                                ;; 00:0b1e $c2 $eb $6c
    jp   call_03_7253_MapTileAnim_Update                                    ;; 00:0b21 $c3 $53 $72
.jp_00_0b24_TilesetAnim_PlayFrame:
; Plays one frame of the SECONDARY TILESET's animation - the second and rarer of the
; game's two tile animation systems. The other one, the per-level water and lava cycle
; in bank03_map_tile_anim.asm, is reached at the bottom of this routine instead; the
; header there sets the two side by side.
;
; What makes this one different is that it belongs to the artwork rather than to the
; room. call_00_1922_BgMap_LoadSecondaryTileset fills wD72F_TilesetAnim_FrameCount
; onward straight out of the tileset it just loaded, so swapping tilesets swaps the
; animation with it, and a tileset with no animation leaves the count at zero and is
; skipped for nothing.
;
; The frame data lives in the tileset's own ROM bank, so the first thing here is to
; bank it in - wD72E_TilesetAnim_Bank is a private copy of the value the loader keeps
; in wD726_SecondaryTilesetBank, held separately because this runs from vblank and
; cannot rely on whatever the main loop left mapped.
;
; Two ways to run, chosen by bit 0 of wD738_TilesetAnim_Flags:
;
;   clear  loop. wD730_TilesetAnim_FrameIndex advances and wraps against the frame
;          count, so the tileset cycles for as long as it stays loaded
;   set    play once. It waits for the tileset's own HDMA to finish, then clears the
;          frame count so this never runs again and draws wD730 once. The index was
;          seeded at load time from the frame table, so what this really does is swap
;          one alternate page of tiles in and stop
;
; Either way the chosen index selects a four-byte (destination, source) pair from the
; table at wD736_TilesetAnim_FrameTablePtrLo and wD733_TilesetAnim_RowsPerFrame tiles
; are copied. Note the destination read from wD734_TilesetAnim_DestAddrLo just below is
; overwritten by the table entry before it is ever used
    ld   A, [wD72E_TilesetAnim_Bank]                                    ;; 00:0b24 $fa $2e $d7
    SET_MBC_BANK                                       ;; 00:0b27
    ld   A, [wD738_TilesetAnim_Flags]                                    ;; 00:0b32 $fa $38 $d7
    and  A, TILESET_ANIM_PLAY_ONCE                     ;; 00:0b35 $e6 $01
    jr   Z, .jr_00_0b48                                ;; 00:0b37 $28 $0f ; looping
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0b39 $21 $0f $d6
    bit  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:0b3c $cb $56
    ret  NZ                                            ;; 00:0b3e $c0 ; tileset still streaming in
    xor  A, A                                          ;; 00:0b3f $af
    ld   [wD72F_TilesetAnim_FrameCount], A                                    ;; 00:0b40 $ea $2f $d7 ; fire once only
    ld   HL, wD730_TilesetAnim_FrameIndex                                     ;; 00:0b43 $21 $30 $d7
    jr   .jr_00_0b51                                   ;; 00:0b46 $18 $09
.jr_00_0b48:
    ld   HL, wD72F_TilesetAnim_FrameCount                                     ;; 00:0b48 $21 $2f $d7
    ld   A, [HL+]                                      ;; 00:0b4b $2a
    inc  [HL]                                          ;; 00:0b4c $34
    sub  A, [HL]                                       ;; 00:0b4d $96
    jr   NZ, .jr_00_0b51                               ;; 00:0b4e $20 $01
    ld   [HL], A                                       ;; 00:0b50 $77
.jr_00_0b51:
    ld   C, [HL]                                       ;; 00:0b51 $4e
    ld   B, $00                                        ;; 00:0b52 $06 $00
    ld   HL, wD734_TilesetAnim_DestAddrLo                                     ;; 00:0b54 $21 $34 $d7
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
    ld   A, [wD733_TilesetAnim_RowsPerFrame]                                    ;; 00:0b69 $fa $33 $d7
    ld   B, A                                          ;; 00:0b6c $47

call_00_0b6d_CopyTileRows:
; Copies B tiles (TILE_SIZE_BYTES bytes each) from HL to DE. This is the hot copy
; in the whole graphics path - every streamed page and every tileset animation frame
; goes through it - so the inner loop is fully unrolled.
;
; The unrolled body advances the destination with `inc E` rather than `inc DE`,
; which is why a tile must not straddle a $100 boundary: only the 16th byte uses
; `inc DE` and can carry. Every caller starts on a tile-aligned address, so that
; holds
    ; 15 bytes with `inc E`, which is one cycle cheaper than `inc DE` but cannot
    ; carry into the next page
    REPT TILE_SIZE_BYTES - 1
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ENDR
    ld   A, [HL+]                                      ;; 00:0b9a $2a
    ld   [DE], A                                       ;; 00:0b9b $12
    inc  DE                                            ;; 00:0b9c $13
    dec  B                                             ;; 00:0b9d $05
    jr   NZ, call_00_0b6d_CopyTileRows                              ;; 00:0b9e $20 $cd
    ret                                                ;; 00:0ba0 $c9

call_00_0ba1_WaitUntilLcdIsrNone:
; Spins a frame at a time until the LCD STAT handler id is LCD_ISR_NONE, i.e. until
; the STAT interrupt has been switched off. Callers use it to make sure no handler is
; still writing VRAM before they tear the screen down.
;
; The `cp $00` is redundant - `and` has already set Z - and the masked id is only
; ever compared against zero, so this cannot wait for any other handler
    ld   a,[wCCFD_LcdIsrId]
    and  a,LCD_ISR_ID_MASK
    cp   a,LCD_ISR_NONE
    ret  z
    call call_00_0ab4_WaitForInterrupt
    jr   call_00_0ba1_WaitUntilLcdIsrNone

call_00_0bae_RequestLcdIsr:
; Requests LCD STAT handler A (one of the LCD_ISR_* ids). If that handler is already
; installed this is a no-op; otherwise the id is stored with LCD_ISR_INSTALLED clear,
; which makes the next vblank call call_00_0bb9_InstallLcdIsr
    ld   HL, wCCFD_LcdIsrId                                     ;; 00:0bae $21 $fd $cc
    or   A, LCD_ISR_INSTALLED                          ;; 00:0bb1 $f6 $80
    cp   A, [HL]                                       ;; 00:0bb3 $be
    ret  Z                                             ;; 00:0bb4 $c8 ; already installed
    and  A, LCD_ISR_ID_MASK                            ;; 00:0bb5 $e6 $7f
    ld   [HL], A                                       ;; 00:0bb7 $77
    ret                                                ;; 00:0bb8 $c9

call_00_0bb9_InstallLcdIsr:
; Copies LCD STAT handler A out of .data_00_0bdc_LcdIsrTable into wCCA0_LcdIsrCode
; (which isrLCDC jumps straight into) and stores the address just past the copied code
; into wCCFE_VBlankHookPtrLo - that is the vblank-side routine that arms/services the
; handler each frame. Sets LCD_ISR_INSTALLED in wCCFD_LcdIsrId
    ld   L, A                                          ;; 00:0bb9 $6f
    ld   H, $00                                        ;; 00:0bba $26 $00
    ld   DE, .data_00_0bdc_LcdIsrTable                                      ;; 00:0bbc $11 $dc $0b
    add  HL, DE                                        ;; 00:0bbf $19
    or   A, LCD_ISR_INSTALLED                          ;; 00:0bc0 $f6 $80
    ld   [wCCFD_LcdIsrId], A                                    ;; 00:0bc2 $ea $fd $cc
    ld   B, [HL]                                       ;; 00:0bc5 $46
    inc  HL                                            ;; 00:0bc6 $23
    ld   A, [HL+]                                      ;; 00:0bc7 $2a
    ld   H, [HL]                                       ;; 00:0bc8 $66
    ld   L, A                                          ;; 00:0bc9 $6f
    ld   DE, wCCA0_LcdIsrCode                                     ;; 00:0bca $11 $a0 $cc
.jr_00_0bcd:
    ld   A, [HL+]                                      ;; 00:0bcd $2a
    ld   [DE], A                                       ;; 00:0bce $12
    inc  E                                             ;; 00:0bcf $1c
    dec  B                                             ;; 00:0bd0 $05
    jr   NZ, .jr_00_0bcd                               ;; 00:0bd1 $20 $fa
    ld   A, L                                          ;; 00:0bd3 $7d
    ld   [wCCFE_VBlankHookPtrLo], A                                    ;; 00:0bd4 $ea $fe $cc
    ld   A, H                                          ;; 00:0bd7 $7c
    ld   [wCCFF_VBlankHookPtrHi], A                                    ;; 00:0bd8 $ea $ff $cc
    ret                                                ;; 00:0bdb $c9
.data_00_0bdc_LcdIsrTable:
; 3 bytes per entry: [length of the handler template, pointer to the template].
; The vblank hook for an entry lives immediately after its template, so
; call_00_0bb9_InstallLcdIsr gets it for free from the end of the copy.
; Indexed directly by the LCD_ISR_* ids, hence the 3-byte spacing
    lcd_isr_entry .data_00_0be5_LcdIsrTemplate_None,       .data_00_0be6_VBlankHook_None
    lcd_isr_entry .data_00_0be7_LcdIsrTemplate_VramStream,  call_00_0c11_VBlank_ArmVramStreamIsr
    lcd_isr_entry data_00_0d49_LcdIsrTemplate_RasterEffect, call_00_0d84_VBlank_RunGfxStream

.data_00_0be5_LcdIsrTemplate_None:
    db   OPCODE_RETI                                   ;; 00:0be5 $d9
.data_00_0be6_VBlankHook_None:
    ret                                                ;; 00:0be6 $c9

.data_00_0be7_LcdIsrTemplate_VramStream:
; LCD_ISR_VRAM_STREAM. Copied to wCCA0_LcdIsrCode and RUN FROM THERE, so the bytes
; below are data as far as this bank is concerned - the addresses in the right-hand
; column are where they are stored, not where they execute.
;
; It moves wD100_TilesToLoadBuffer into a single VRAM page four bytes per hblank,
; walking backwards from the end of the buffer, and three of its own operand bytes
; are variables that the vblank hook patches before arming it:
;
;   +$00  wCCA0_LcdIsrCode        reti when idle, push af when armed
;   +$04  wCCA4_LcdIsr_SrcAddrLo  low byte of the source cursor; also the progress
;                                 counter, since the handler writes it back each pass
;   +$05  wCCA5_LcdIsr_SrcAddrHi  high byte, always HIGH(wD100_TilesToLoadBuffer) + 1
;   +$07  wCCA7_LcdIsr_DestPageHi destination VRAM page
;
; `ld e, l` is what makes the destination track the source: DE ends up as
; (dest page):(source low byte), so both walk down together and the copy finishes
; exactly when the low byte wraps past zero. That wrap is the whole termination
; condition - `inc a / jr nz` below - and it is why the tileset and queued-gfx paths
; shorten a transfer by seeding wCCA4 with something other than $FF
    db   OPCODE_RETI                                   ;; 00:0be7 $d9
    push hl
    push de
    ld   hl,wD100_TilesToLoadBuffer + GFX_PAGE_SIZE - 1
    ld   d,HIGH(_VRAM)                                 ; patched: destination page
    ld   e,l
    ldd  a,[hl]
    ld   [de],a
    dec  e
    ldd  a,[hl]
    ld   [de],a
    dec  e
    ldd  a,[hl]
    ld   [de],a
    dec  e
    ldd  a,[hl]
    ld   [de],a
    ; Save the cursor. When it has wrapped past zero the page is done, so clear the
    ; request and disarm by writing a reti back over the first byte
    ld   a,l
    ld   [wCCA4_LcdIsr_SrcAddrLo],a
    inc  a
    jr   nz, .jr_00_0C0D
    ld   hl,wD60F_GfxTransferFlags
    res  GFX_XFER_IN_PROGRESS,[hl]
    ld   a,[data_00_0d83_RetiOpcode]
    ld   [wCCA0_LcdIsrCode],a
.jr_00_0C0D:
    ; The `pop af` balances the `push af` that arming wrote over the first byte
    pop  de
    pop  hl
    pop  af
    reti

call_00_0c11_VBlank_ArmVramStreamIsr:
; VBlank hook paired with LCD_ISR_VRAM_STREAM. Returns unless a transfer has been staged
; (GFX_XFER_IN_PROGRESS). Otherwise picks the lowest pending request bit, patches the
; handler's source pointer (wCCA4/wCCA5 = $D1FF) and destination page
; (wCCA7_LcdIsr_DestPageHi), arms it by writing OPCODE_PUSH_AF over wCCA0_LcdIsrCode,
; and clears the request bit. The player/entity cases also flip their VRAM page toggle;
; the tileset and queued-gfx cases walk a multi-page descriptor instead
    ld   HL, wD60F_GfxTransferFlags                ;; 00:0c11 $21 $0f $d6
    bit  GFX_XFER_IN_PROGRESS, [HL]                    ;; 00:0c14 $cb $7e
    ret  Z                                             ;; 00:0c16 $c8 ; nothing staged
    bit  GFX_XFER_PLAYER_GFX, [HL]                     ;; 00:0c17 $cb $46
    jr   NZ, .jr_00_0c31                               ;; 00:0c19 $20 $16
    bit  GFX_XFER_ENTITY_GFX, [HL]                     ;; 00:0c1b $cb $4e
    jr   NZ, .jr_00_0c55                               ;; 00:0c1d $20 $36
    bit  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:0c1f $cb $56
    jp   NZ, .jp_00_0c78                               ;; 00:0c21 $c2 $78 $0c
    bit  GFX_XFER_QUEUED_ENTITY_GFX, [HL]              ;; 00:0c24 $cb $5e
    jp   NZ, .jp_00_0cb4                               ;; 00:0c26 $c2 $b4 $0c
    bit  GFX_XFER_MEDIA_DIMENSION_TV, [HL]             ;; 00:0c29 $cb $66
    jp   NZ, .jp_00_0cf0                               ;; 00:0c2b $c2 $f0 $0c
    res  GFX_XFER_IN_PROGRESS, [HL]                    ;; 00:0c2e $cb $be ; staged but nothing wants it
    ret                                                ;; 00:0c30 $c9
.jr_00_0c31:
    ; Gex tiles. Two VRAM pages are kept and written alternately, so the page the
    ; PPU is reading is never the page being overwritten - the toggle in
    ; wD586_PlayerGfxVramPage is what call_03_5ca8_Player_BuildSprites reads to pick
    ; his shape table entry, and therefore his tile base, for this frame
    ARM_VRAM_STREAM_ISR                                ;; 00:0c31
    ld   A, [wD586_PlayerGfxVramPage]                                    ;; 00:0c3f $fa $86 $d5
    add  A, HIGH(_VRAM)                                ;; 00:0c42 $c6 $80
    ld   [wCCA7_LcdIsr_DestPageHi], A                                    ;; 00:0c44 $ea $a7 $cc
    and  A, $01                                        ;; 00:0c47 $e6 $01
    xor  A, $01                                        ;; 00:0c49 $ee $01
    ld   [wD586_PlayerGfxVramPage], A                                    ;; 00:0c4b $ea $86 $d5
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0c4e $21 $0f $d6
    res  GFX_XFER_PLAYER_GFX, [HL]                     ;; 00:0c51 $cb $86
    ret                                                ;; 00:0c53 $c9
.data_00_0c54_PushAfOpcode:
; Sits in the middle of the routine because the five branches above and below all
; load it from here to arm the handler - see ARM_VRAM_STREAM_ISR
    db   OPCODE_PUSH_AF                                ;; 00:0c54 $f5
.jr_00_0c55:
    ; Entity tiles, double buffered the same way at $8200 / $8300
    ARM_VRAM_STREAM_ISR                                ;; 00:0c55
    ld   A, [wD587_EntityGfxVramPage]                                    ;; 00:0c63 $fa $87 $d5
    add  A, HIGH(_VRAM) + 2                            ;; 00:0c66 $c6 $82
    ld   [wCCA7_LcdIsr_DestPageHi], A                                    ;; 00:0c68 $ea $a7 $cc
    and  A, $01                                        ;; 00:0c6b $e6 $01
    xor  A, $01                                        ;; 00:0c6d $ee $01
    ld   [wD587_EntityGfxVramPage], A                                    ;; 00:0c6f $ea $87 $d5
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0c72 $21 $0f $d6
    res  GFX_XFER_ENTITY_GFX, [HL]                     ;; 00:0c75 $cb $8e
    ret                                                ;; 00:0c77 $c9
.jp_00_0c78:
    ; Secondary tileset. Bigger than one page, so this walks a descriptor: each frame
    ; arms one page, then advances the source and destination and counts down. The
    ; request bit is only cleared on the last page, and that last page is a short one
    ; - wD72B_SecondaryTileset_RowsPerPage - 1 becomes the starting source offset, so
    ; the handler stops early instead of running off the end of the tileset
    ARM_VRAM_STREAM_ISR_ALT                            ;; 00:0c78
    ld   A, [wD72A_SecondaryTileset_DestAddrHi]                                    ;; 00:0c86 $fa $2a $d7
    ld   [wCCA7_LcdIsr_DestPageHi], A                                    ;; 00:0c89 $ea $a7 $cc
    ld   A, [wD72C_SecondaryTileset_PagesRemaining]                                    ;; 00:0c8c $fa $2c $d7
    and  A, A                                          ;; 00:0c8f $a7
    jr   NZ, .jr_00_0c9f                               ;; 00:0c90 $20 $0d
    ld   A, [wD72B_SecondaryTileset_RowsPerPage]                                    ;; 00:0c92 $fa $2b $d7
    dec  A                                             ;; 00:0c95 $3d
    ld   [wCCA4_LcdIsr_SrcAddrLo], A                                    ;; 00:0c96 $ea $a4 $cc
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0c99 $21 $0f $d6
    res  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:0c9c $cb $96
    ret                                                ;; 00:0c9e $c9
.jr_00_0c9f:
    ld   HL, wD728_SecondaryTileset_SrcAddrHi                                     ;; 00:0c9f $21 $28 $d7
    inc  [HL]                                          ;; 00:0ca2 $34
    ld   HL, wD72A_SecondaryTileset_DestAddrHi                                     ;; 00:0ca3 $21 $2a $d7
    inc  [HL]                                          ;; 00:0ca6 $34
    ld   HL, wD72C_SecondaryTileset_PagesRemaining                                     ;; 00:0ca7 $21 $2c $d7
    dec  [HL]                                          ;; 00:0caa $35
    ld   A, [HL-]                                      ;; 00:0cab $3a
    or   A, [HL]                                       ;; 00:0cac $b6
    ret  NZ                                            ;; 00:0cad $c0
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0cae $21 $0f $d6
    res  GFX_XFER_SECONDARY_TILESET, [HL]              ;; 00:0cb1 $cb $96
    ret                                                ;; 00:0cb3 $c9
.jp_00_0cb4:
    ; Queued entity graphics. Same multi-page walk as the tileset above, over the
    ; descriptor at wD71F_GfxCopy_SrcBank that
    ; call_02_722c_EntityGfxQueue_StartNextTransfer filled in
    ARM_VRAM_STREAM_ISR_ALT                            ;; 00:0cb4
    ld   A, [wD723_GfxCopy_DestAddrHi]                                    ;; 00:0cc2 $fa $23 $d7
    ld   [wCCA7_LcdIsr_DestPageHi], A                                    ;; 00:0cc5 $ea $a7 $cc
    ld   A, [wD725_GfxCopy_SizeHi]                                    ;; 00:0cc8 $fa $25 $d7
    and  A, A                                          ;; 00:0ccb $a7
    jr   NZ, .jr_00_0cdb                               ;; 00:0ccc $20 $0d
    ld   A, [wD724_GfxCopy_SizeLo]                                    ;; 00:0cce $fa $24 $d7
    dec  A                                             ;; 00:0cd1 $3d
    ld   [wCCA4_LcdIsr_SrcAddrLo], A                                    ;; 00:0cd2 $ea $a4 $cc
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0cd5 $21 $0f $d6
    res  GFX_XFER_QUEUED_ENTITY_GFX, [HL]              ;; 00:0cd8 $cb $9e
    ret                                                ;; 00:0cda $c9
.jr_00_0cdb:
    ld   HL, wD721_GfxCopy_SrcAddrHi                                     ;; 00:0cdb $21 $21 $d7
    inc  [HL]                                          ;; 00:0cde $34
    ld   HL, wD723_GfxCopy_DestAddrHi                                     ;; 00:0cdf $21 $23 $d7
    inc  [HL]                                          ;; 00:0ce2 $34
    ld   HL, wD725_GfxCopy_SizeHi                                     ;; 00:0ce3 $21 $25 $d7
    dec  [HL]                                          ;; 00:0ce6 $35
    ld   A, [HL-]                                      ;; 00:0ce7 $3a
    or   A, [HL]                                       ;; 00:0ce8 $b6
    ret  NZ                                            ;; 00:0ce9 $c0
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0cea $21 $0f $d6
    res  GFX_XFER_QUEUED_ENTITY_GFX, [HL]              ;; 00:0ced $cb $9e
    ret                                                ;; 00:0cef $c9
.jp_00_0cf0:
    ; Hub tv screen. Always exactly one page, so there is no descriptor to walk
    ARM_VRAM_STREAM_ISR                                ;; 00:0cf0
    ld   A, HIGH(VRAM_HUD_TILES)                       ;; 00:0cfe $3e $86
    ld   [wCCA7_LcdIsr_DestPageHi], A                                    ;; 00:0d00 $ea $a7 $cc
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:0d03 $21 $0f $d6
    res  GFX_XFER_MEDIA_DIMENSION_TV, [HL]             ;; 00:0d06 $cb $a6
    ret                                                ;; 00:0d08 $c9
data_00_0d09_RasterWobbleTable:
; rSCX offsets for the horizontal wobble effect, read as
; [scanline - wD6EB_RasterWobble_StartLine] + [(wD73B_VBlankFrameCounter >> 3) & 7].
; The repeating 0/-1/0/+1 pattern gives the 4-frame shimmer used by the tv warp.
;
; It is 64 bytes of the same 8-byte run, and it has to be: the two indices are added
; together before the lookup, so a wobble band of up to 56 scanlines can be offset by
; a frame phase of up to 7 and still land inside the table. Repeating the pattern is
; what removes the need for any masking in the handler
    REPT 8
    db   $00, $ff, $00, $01, $00, $ff, $00, $01
    ENDR

data_00_0d49_LcdIsrTemplate_RasterEffect:
; LCD_ISR_RASTER_EFFECT. Like the streaming template above, this is copied to
; wCCA0_LcdIsrCode and RUN FROM THERE - it is written out as instructions because
; that is what it is, but nothing in this bank ever executes it, and the addresses in
; the right-hand column are where the bytes are stored rather than where they run.
;
; It is safe to write as real code because everything in it is either relative (the
; three jumps) or an absolute address that is mapped no matter what - hardware
; registers, WRAM, and data_00_0d09_RasterWobbleTable down in ROM0.
;
; Unlike the streaming handler this one is armed from the moment it is installed: its
; first byte is already a push af, and there is no disarm path. It does two unrelated
; jobs on every scanline:
;
;   1. At rLY == $5F it swaps in wD6E1_RasterSplit_LCDCValue, which is what turns the
;      hud window on partway down the screen instead of for the whole frame
;   2. Inside the wD6EB_RasterWobble_StartLine band it writes a table entry to rSCX,
;      giving the horizontal shimmer used by the tv warp and by the menu cursor
;
; Note the asymmetry in the band test: a scanline ABOVE the band leaves rSCX alone,
; while one below it forces rSCX to zero. So the band has to be re-armed from the top
; each frame, which .jp_01_442d does
    push af                                            ;; 00:0d49 $f5
    push hl                                            ;; 00:0d4a $e5
    push de                                            ;; 00:0d4b $d5
    ldh  a, [rLY]                                      ;; 00:0d4c $f0 $44
    cp   a, RASTER_SPLIT_SCANLINE                      ;; 00:0d4e $fe $5f
    jr   nz, .jr_00_0d57                               ;; 00:0d50 $20 $05
    ld   a, [wD6E1_RasterSplit_LCDCValue]              ;; 00:0d52 $fa $e1 $d6
    ldh  [rLCDC], a                                    ;; 00:0d55 $e0 $40
.jr_00_0d57:
    ; A = rLY - band start. Carry means we are above the band
    ldh  a, [rLY]                                      ;; 00:0d57 $f0 $44
    ld   hl, wD6EB_RasterWobble_StartLine              ;; 00:0d59 $21 $eb $d6
    sub  [hl]                                          ;; 00:0d5c $96
    jr   c, .jr_00_0d80                                ;; 00:0d5d $38 $21
    ld   hl, wD6EC_RasterWobble_LineCount              ;; 00:0d5f $21 $ec $d6
    cp   [hl]                                          ;; 00:0d62 $be
    jr   c, .jr_00_0d6a                                ;; 00:0d63 $38 $05
    xor  a                                             ;; 00:0d65 $af ; below the band: no scroll
    ldh  [rSCX], a                                     ;; 00:0d66 $e0 $43
    jr   .jr_00_0d80                                   ;; 00:0d68 $18 $16
.jr_00_0d6a:
    ; Inside the band. The table index is (line within band) + (frame phase), and the
    ; table repeats its 8-byte pattern eight times so the sum never needs masking
    ld   e, a                                          ;; 00:0d6a $5f
    ld   d, $00                                        ;; 00:0d6b $16 $00
    ld   a, [wD73B_VBlankFrameCounter]                 ;; 00:0d6d $fa $3b $d7
    rrca                                               ;; 00:0d70 $0f
    rrca                                               ;; 00:0d71 $0f
    rrca                                               ;; 00:0d72 $0f ; one phase step every 8 frames
    and  a, $07                                        ;; 00:0d73 $e6 $07
    ld   l, a                                          ;; 00:0d75 $6f
    ld   h, $00                                        ;; 00:0d76 $26 $00
    add  hl, de                                        ;; 00:0d78 $19
    ld   de, data_00_0d09_RasterWobbleTable            ;; 00:0d79 $11 $09 $0d
    add  hl, de                                        ;; 00:0d7c $19
    ld   a, [hl]                                       ;; 00:0d7d $7e
    ldh  [rSCX], a                                     ;; 00:0d7e $e0 $43
.jr_00_0d80:
    pop  de                                            ;; 00:0d80 $d1
    pop  hl                                            ;; 00:0d81 $e1
    pop  af                                            ;; 00:0d82 $f1
data_00_0d83_RetiOpcode:
; The reti that ends the raster handler. It doubles as the constant the streaming
; handler writes over wCCA0_LcdIsrCode to disarm itself, which is why it has a label
; of its own
    db   OPCODE_RETI                                   ;; 00:0d83 $d9

call_00_0d84_VBlank_RunGfxStream:
; VBlank hook paired with LCD_ISR_RASTER_EFFECT. Copies one chunk of a graphics stream
; script per frame: decrements wD6E2_GfxStream_ChunksRemaining, banks in
; wD6E4_GfxStream_SrcBank, reads the next (srcPtr, destPtr) pair from
; wD6E9_GfxStream_ListPtrLo, advances that pointer, and copies
; wD6E3_GfxStream_RowsPerChunk tiles. Used to animate the menu / cutscene backgrounds
    ld   HL, wD6E2_GfxStream_ChunksRemaining                                     ;; 00:0d84 $21 $e2 $d6
    ld   A, [HL]                                       ;; 00:0d87 $7e
    and  A, A                                          ;; 00:0d88 $a7
    ret  Z                                             ;; 00:0d89 $c8
    dec  [HL]                                          ;; 00:0d8a $35
    inc  HL                                            ;; 00:0d8b $23
    ld   B, [HL]                                       ;; 00:0d8c $46 ; B = tiles per chunk
    inc  HL                                            ;; 00:0d8d $23
    ld   A, [HL]                                       ;; 00:0d8e $7e
    SET_MBC_BANK                                       ;; 00:0d8f
    ld   HL, wD6E9_GfxStream_ListPtrLo                                     ;; 00:0d9a $21 $e9 $d6
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
    ld   [wD6E9_GfxStream_ListPtrLo], A                                    ;; 00:0daa $ea $e9 $d6
    ld   A, H                                          ;; 00:0dad $7c
    ld   [wD6EA_GfxStream_ListPtrHi], A                                    ;; 00:0dae $ea $ea $d6
    pop  HL                                            ;; 00:0db1 $e1
    jp   call_00_0b6d_CopyTileRows                                  ;; 00:0db2 $c3 $6d $0b

    ret 

data_00_0db6_GfxStreamScript_MenuSprites:
; The odd one out among the three tables here: its source is WRAM, not ROM, so the
; bank byte is meaningless. call_01_4bd3_Text_WrapAndAlign and the rest of the menu
; text renderer build glyph tiles into wC000_BgMapTileIds - which is free while a
; menu is up, since there is no bg map to hold - and this script then walks them out
; to VRAM eight chunks at a time, one chunk per frame.
;
; Used after the totals page is redrawn, which is why the transfer is spread over
; frames rather than done in one blocking copy: the screen stays on throughout
    gfx_stream_header $08, $04, BANK_00
    gfx_stream_chunk  wC000_BgMapTileIds + $000, $8460
    gfx_stream_chunk  wC000_BgMapTileIds + $040, $84a0
    gfx_stream_chunk  wC000_BgMapTileIds + $080, $84e0
    gfx_stream_chunk  wC000_BgMapTileIds + $0c0, $8520
    gfx_stream_chunk  wC000_BgMapTileIds + $100, $8560
    gfx_stream_chunk  wC000_BgMapTileIds + $140, $85a0
    gfx_stream_chunk  wC000_BgMapTileIds + $180, $85e0
    gfx_stream_chunk  wC000_BgMapTileIds + $1c0, $8620
data_00_0dd9_GfxStreamScriptTable_TitleOptions:
; MENU_TYPE_TITLE_OPTIONS: one script per selectable row, indexed by
; wD6E0_MenuSelectedRow through .jp_01_444c. Moving the cursor streams in a fresh
; copy of the whole option block with the newly selected row highlighted - the game
; has no palette trick for "selected", so it swaps the artwork instead.
;
; Both scripts write the same six VRAM destinations and differ only in which source
; block they read, $240 bytes apart in bank $08's image_title_options_008_2
    dw   .data_00_0ddd_TitleOptions_Row0
    dw   .data_00_0df8_TitleOptions_Row1
.data_00_0ddd_TitleOptions_Row0:
    gfx_stream_header $06, $06, BANK_08
    gfx_stream_chunk  $6fd0, $8cb0
    gfx_stream_chunk  $7030, $8df0
    gfx_stream_chunk  $7090, $9030
    gfx_stream_chunk  $70f0, $9170
    gfx_stream_chunk  $7150, $92b0
    gfx_stream_chunk  $71b0, $93f0
.data_00_0df8_TitleOptions_Row1:
    gfx_stream_header $06, $06, BANK_08
    gfx_stream_chunk  $7210, $8cb0
    gfx_stream_chunk  $7270, $8df0
    gfx_stream_chunk  $72d0, $9030
    gfx_stream_chunk  $7330, $9170
    gfx_stream_chunk  $7390, $92b0
    gfx_stream_chunk  $73f0, $93f0

data_00_0e13_GfxStreamScriptTable_AudioOptions:
; MENU_TYPE_AUDIO_OPTIONS_UNUSED, reached through .jp_01_445d. Same idea and the
; same six VRAM destinations as the title options table above, four rows this time,
; out of bank $0C's image_audio_options_00c_1.
;
; The screen these belong to is unreachable in the shipped game - nothing ever opens
; MENU_TYPE_AUDIO_OPTIONS_UNUSED - so all four scripts are dead data
    dw   .data_00_0e1b_AudioOptions_Row0
    dw   .data_00_0e36_AudioOptions_Row1
    dw   .data_00_0e51_AudioOptions_Row2
    dw   .data_00_0e6c_AudioOptions_Row3
.data_00_0e1b_AudioOptions_Row0:
    gfx_stream_header $06, $06, BANK_0C
    gfx_stream_chunk  $57e8, $8d00
    gfx_stream_chunk  $5848, $8e40
    gfx_stream_chunk  $58a8, $9080
    gfx_stream_chunk  $5908, $91c0
    gfx_stream_chunk  $5968, $9300
    gfx_stream_chunk  $59c8, $9440
.data_00_0e36_AudioOptions_Row1:
    gfx_stream_header $06, $06, BANK_0C
    gfx_stream_chunk  $5a28, $8d00
    gfx_stream_chunk  $5a88, $8e40
    gfx_stream_chunk  $5ae8, $9080
    gfx_stream_chunk  $5b48, $91c0
    gfx_stream_chunk  $5ba8, $9300
    gfx_stream_chunk  $5c08, $9440
.data_00_0e51_AudioOptions_Row2:
    gfx_stream_header $06, $06, BANK_0C
    gfx_stream_chunk  $5c68, $8d00
    gfx_stream_chunk  $5cc8, $8e40
    gfx_stream_chunk  $5d28, $9080
    gfx_stream_chunk  $5d88, $91c0
    gfx_stream_chunk  $5de8, $9300
    gfx_stream_chunk  $5e48, $9440
.data_00_0e6c_AudioOptions_Row3:
    gfx_stream_header $06, $06, BANK_0C
    gfx_stream_chunk  $5ea8, $8d00
    gfx_stream_chunk  $5f08, $8e40
    gfx_stream_chunk  $5f68, $9080
    gfx_stream_chunk  $5fc8, $91c0
    gfx_stream_chunk  $6028, $9300
    gfx_stream_chunk  $6088, $9440

call_00_0e87_ClearVRAMAndResetScroll:
; Zeroes the tile data and both tilemaps (in both VRAM banks on GBC), clears shadow OAM
; and resets wD5A1_BgMap_ScrollXLo / wD5A2_BgMap_ScrollYLo
    ld   A, [wD59E_OnGBCFlag]                                    ;; 00:0e87 $fa $9e $d5
    and  A, A                                          ;; 00:0e8a $a7
    jr   Z, .jr_00_0e98                                ;; 00:0e8b $28 $0b
    SELECT_VRAM_BANK 1                                 ;; 00:0e8d $3e $01 $e0 $4f
    call call_00_0ec4_ClearTileVRAM                                  ;; 00:0e91 $cd $c4 $0e
    SELECT_VRAM_BANK 0                                 ;; 00:0e94 $3e $00 $e0 $4f
.jr_00_0e98:
    call call_00_0ec4_ClearTileVRAM                                  ;; 00:0e98 $cd $c4 $0e
    ld   A, [wD59E_OnGBCFlag]                                    ;; 00:0e9b $fa $9e $d5
    and  A, A                                          ;; 00:0e9e $a7
    jr   Z, .jr_00_0eac                                ;; 00:0e9f $28 $0b
    SELECT_VRAM_BANK 1                                 ;; 00:0ea1 $3e $01 $e0 $4f
    call call_00_0eba_ClearVRAMBgMap                                  ;; 00:0ea5 $cd $ba $0e
    SELECT_VRAM_BANK 0                                 ;; 00:0ea8 $3e $00 $e0 $4f
.jr_00_0eac:
    call call_00_0eba_ClearVRAMBgMap                                  ;; 00:0eac $cd $ba $0e
    call call_00_0ee8_ClearShadowOAM                                  ;; 00:0eaf $cd $e8 $0e
    xor  A, A                                          ;; 00:0eb2 $af
    ld   [wD5A1_BgMap_ScrollXLo], A                                    ;; 00:0eb3 $ea $a1 $d5
    ld   [wD5A2_BgMap_ScrollYLo], A                                    ;; 00:0eb6 $ea $a2 $d5
    ret                                                ;; 00:0eb9 $c9

call_00_0eba_ClearVRAMBgMap:
; Zeroes both tilemaps, $9800-$9FFF, in whichever VRAM bank is currently selected.
; The end test is `bit 5, H`: HL runs from $98xx to $9Fxx, and bit 5 of the high byte
; only becomes set at $A000, so it costs one instruction instead of a 16-bit compare
    ld   HL, _SCRN0                                     ;; 00:0eba $21 $00 $98
    xor  A, A                                          ;; 00:0ebd $af
.jr_00_0ebe:
    ld   [HL+], A                                      ;; 00:0ebe $22
    bit  5, H                                          ;; 00:0ebf $cb $6c
    jr   Z, .jr_00_0ebe                                ;; 00:0ec1 $28 $fb
    ret                                                ;; 00:0ec3 $c9

call_00_0ec4_ClearTileVRAM:
; Zeroes the tile data, $8000-$97FF, in whichever VRAM bank is currently selected.
; Unrolled a tile at a time so the loop overhead is paid once per 16 bytes
    ld   HL, _VRAM                                     ;; 00:0ec4 $21 $00 $80
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

call_00_0ede_SelectWramBank1:
; GBC only: makes sure SVBK selects WRAM bank 1, since $D000-$DFFF is used for game state
    ld   A, [wD59E_OnGBCFlag]                                    ;; 00:0ede $fa $9e $d5
    and  A, A                                          ;; 00:0ee1 $a7
    ret  Z                                             ;; 00:0ee2 $c8
    ld   A, WRAM_BANK_GAME_STATE                       ;; 00:0ee3 $3e $01
    ldh  [rSVBK], A                                    ;; 00:0ee5 $e0 $70
    ret                                                ;; 00:0ee7 $c9

call_00_0ee8_ClearShadowOAM:
; Zeroes all SHADOW_OAM_SIZE bytes of wCC00_ShadowOAM, using the same seed-and-copy
; trick as Init: one byte is written and then copied forward over itself
    ld   HL, wCC00_ShadowOAM                                     ;; 00:0ee8 $21 $00 $cc
    ld   DE, wCC01_ShadowOAM_EntitySprites                                     ;; 00:0eeb $11 $01 $cc
    ld   BC, SHADOW_OAM_SIZE - 1                       ;; 00:0eee $01 $9f $00
    ld   [HL], $00                                     ;; 00:0ef1 $36 $00
    call call_00_07b0_MemCopy                                  ;; 00:0ef3 $cd $b0 $07
    ret                                                ;; 00:0ef6 $c9

call_00_0ef7_OamDmaRoutine:
; Copied to hFF80_OamDmaRoutine at boot and called from vblank. Kicks off an OAM DMA
; from wCC00_ShadowOAM ($CC00) and busy-waits the required 160 cycles
    ld   a,HIGH(wCC00_ShadowOAM)
    ldh   [rDMA],a
    ld   a,OAM_DMA_WAIT_LOOPS
.jr_00_0EFD:
    dec  a
    jr   nz,.jr_00_0EFD
    ret  

call_00_0f01_ResetVideoState:
; Tears down everything that could still write to VRAM: selects LCD_ISR_NONE, clears the
; map loading / hud dirty / graphics transfer / block patch / tileset animation /
; graphics stream / fade state, clears the queued SFX, turns the LCD off in
; wD5A0_LCDCValue and waits one frame for it to take effect
    ld   A, LCD_ISR_NONE                               ;; 00:0f01 $3e $00
    ld   [wCCFD_LcdIsrId], A                                    ;; 00:0f03 $ea $fd $cc
    xor  A, A                                          ;; 00:0f06 $af
    ld   [wD6F9_BgMap_LoadingFlags], A                                    ;; 00:0f07 $ea $f9 $d6
    ld   [wD60E_HUDDirtyFlags], A                                    ;; 00:0f0a $ea $0e $d6
    ld   [wD60F_GfxTransferFlags], A                                    ;; 00:0f0d $ea $0f $d6
    ld   [wD77B_BlockPatch_VramWritePending], A                                    ;; 00:0f10 $ea $7b $d7
    ld   [wD72F_TilesetAnim_FrameCount], A                                    ;; 00:0f13 $ea $2f $d7
    ld   [wD611_MapTileAnim_StepCount], A                                    ;; 00:0f16 $ea $11 $d6
    ld   [wD6E2_GfxStream_ChunksRemaining], A                                    ;; 00:0f19 $ea $e2 $d6
    ld   [wDAD9_FadeMode], A                                    ;; 00:0f1c $ea $d9 $da
    ld   [wD71E_EntityGfxQueueCount], A                                    ;; 00:0f1f $ea $1e $d7
    ld   A, SFX_NONE                                   ;; 00:0f22 $3e $ff
    ld   [wD789_QueuedSFX], A                                    ;; 00:0f24 $ea $89 $d7
    ld   A, [wD5A0_LCDCValue]                                    ;; 00:0f27 $fa $a0 $d5
    and  A, ~LCDCF_ON & $FF                            ;; 00:0f2a $e6 $7f
    ld   [wD5A0_LCDCValue], A                                    ;; 00:0f2c $ea $a0 $d5
    jp   call_00_0ab4_WaitForInterrupt                                  ;; 00:0f2f $c3 $b4 $0a

call_00_0f32_SetLCDC:
; Writes A to both the shadow (wD5A0_LCDCValue) and the real rLCDC
    ld   [wD5A0_LCDCValue], A                                    ;; 00:0f32 $ea $a0 $d5
    ldh  [rLCDC], A                                    ;; 00:0f35 $e0 $40
    ret                                                ;; 00:0f37 $c9

call_00_0f38_FadeOutAndClearVRAM:
; Starts a fade to white and blocks until wDACE_CurrentBGP..wDAD0_CurrentOBP1 have
; reached wDAD4_TargetBGP..wDAD6_TargetOBP1, then tears down the video state and wipes
; VRAM. On GBC the fade state never moves, so this falls straight through
    call call_00_0f64_FadeToWhite                                  ;; 00:0f38 $cd $64 $0f
.jr_00_0f3b:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:0f3b $cd $b4 $0a
    ld   HL, wDAD4_TargetBGP                                     ;; 00:0f3e $21 $d4 $da
    ld   DE, wDACE_CurrentBGP                                     ;; 00:0f41 $11 $ce $da
    ld   B, FADE_REG_COUNT                             ;; 00:0f44 $06 $03
.jr_00_0f46:
    ld   A, [DE]                                       ;; 00:0f46 $1a
    cp   A, [HL]                                       ;; 00:0f47 $be
    jr   NZ, .jr_00_0f3b                               ;; 00:0f48 $20 $f1
    inc  DE                                            ;; 00:0f4a $13
    inc  HL                                            ;; 00:0f4b $23
    dec  B                                             ;; 00:0f4c $05
    jr   NZ, .jr_00_0f46                               ;; 00:0f4d $20 $f7
    call call_00_0f01_ResetVideoState                                  ;; 00:0f4f $cd $01 $0f
    call call_00_0e87_ClearVRAMAndResetScroll                                  ;; 00:0f52 $cd $87 $0e
    ret                                                ;; 00:0f55 $c9

call_00_0f56_SetLCDCAndFadeIn:
; Turns the LCD on with the LCDC value in A, then fades the DMG palettes back up
    call call_00_0f32_SetLCDC                                  ;; 00:0f56 $cd $32 $0f
    call call_00_0f72_FadeIn                                  ;; 00:0f59 $cd $72 $0f
    ret                                                ;; 00:0f5c $c9

call_00_0f5d_FadeToBlack:
; Fade mask $FDFF: bit 0 of the low byte fades BGP, bit 0 of the high byte fades OBP0,
; bit 1 is clear so OBP1 is left alone. Used on death so Gex stays visible while the
; world darkens around him
    ld   A, FADE_MODE_TO_BLACK                         ;; 00:0f5d $3e $03
    ld   DE, FADE_MASK_KEEP_OBP1                       ;; 00:0f5f $11 $ff $fd
    jr   jr_00_0f69_Fade_SetMaskAndStart                                    ;; 00:0f62 $18 $05

call_00_0f64_FadeToWhite:
; Fade mask $FFFF - all three palette registers fade.
;
; The mask was written as `ld DE, rIE`, which assembles to the same $11 $FF $FF but
; reads as though it were touching the interrupt enable register. It is only the
; constant $FFFF. Same trap as `ld DE, MBC1RomBank` in bank01_menus.asm
    ld   A, FADE_MODE_TO_WHITE                         ;; 00:0f64 $3e $02
    ld   DE, FADE_MASK_ALL                             ;; 00:0f66 $11 $ff $ff ; mask, not rIE

jr_00_0f69_Fade_SetMaskAndStart:
; Stores DE into wDAD7_FadeMaskLo/wDAD8_FadeMaskHi and starts fade mode A
    ld   HL, wDAD7_FadeMaskLo                                     ;; 00:0f69 $21 $d7 $da
    ld   [HL], E                                       ;; 00:0f6c $73
    inc  HL                                            ;; 00:0f6d $23
    ld   [HL], D                                       ;; 00:0f6e $72
    jp   call_00_0fbc_Fade_Start                                    ;; 00:0f6f $c3 $bc $0f

call_00_0f72_FadeIn:
; Fades all three palette registers back to the level palettes in
; wDAD1_LevelBGP / wDAD2_LevelOBP0 / wDAD3_LevelOBP1
    ld   A, FADE_MODE_IN                               ;; 00:0f72 $3e $01
    ld   DE, FADE_MASK_ALL                             ;; 00:0f74 $11 $ff $ff ; mask, not rIE
    ld   HL, wDAD7_FadeMaskLo                                     ;; 00:0f77 $21 $d7 $da
    ld   [HL], E                                       ;; 00:0f7a $73
    inc  HL                                            ;; 00:0f7b $23
    ld   [HL], D                                       ;; 00:0f7c $72
    jp   call_00_0fbc_Fade_Start                                    ;; 00:0f7d $c3 $bc $0f

call_00_0f80_VBlank_UpdatePalettes:
; On DMG: ticks the fade and pushes wDACE_CurrentBGP/wDACF_CurrentOBP0/wDAD0_CurrentOBP1
; to rBGP/rOBP0/rOBP1. On GBC: uploads the full CGB palette rams instead (there is no
; fade on GBC)
    ld   A, [wD59E_OnGBCFlag]                                    ;; 00:0f80 $fa $9e $d5
    and  A, A                                          ;; 00:0f83 $a7
    jr   NZ, .jr_00_0f99                               ;; 00:0f84 $20 $13
    call call_00_1004_Fade_Update                                  ;; 00:0f86 $cd $04 $10
    ld   A, [wDACE_CurrentBGP]                                    ;; 00:0f89 $fa $ce $da
    ldh  [rBGP], A                                     ;; 00:0f8c $e0 $47
    ld   A, [wDACF_CurrentOBP0]                                    ;; 00:0f8e $fa $cf $da
    ldh  [rOBP0], A                                    ;; 00:0f91 $e0 $48
    ld   A, [wDAD0_CurrentOBP1]                                    ;; 00:0f93 $fa $d0 $da
    ldh  [rOBP1], A                                    ;; 00:0f96 $e0 $49
    ret                                                ;; 00:0f98 $c9
.jr_00_0f99:
    call call_00_0f9d_UploadCgbPalettes                ;; 00:0f99 $cd $9d $0f
    ret                                                ;; 00:0f9c $c9

call_00_0f9d_UploadCgbPalettes:
; Pushes both CGB palette rams to hardware: $40 bytes of background palette from
; wD9CB_Bg_Palettes through rBCPS/rBCPD, then $40 bytes of sprite palette from
; wDA0B_Entity_Palettes through rOCPS/rOCPD. Auto-increment is set by writing $80
; to the index registers first.
;
; GBC only - it is the whole of the GBC branch of call_00_0f80_VBlank_UpdatePalettes,
; which is why there is no DMG fade here
    ld   A, BCPSF_AUTOINC                              ;; 00:0f9d $3e $80
    ldh  [rBCPS], A                                    ;; 00:0f9f $e0 $68
    ld   HL, wD9CB_Bg_Palettes                         ;; 00:0fa1 $21 $cb $d9
    ld   B, CGB_PALETTE_RAM_SIZE                       ;; 00:0fa4 $06 $40
.jr_00_0fa6:
    ld   A, [HL+]                                      ;; 00:0fa6 $2a
    ldh  [rBCPD], A                                    ;; 00:0fa7 $e0 $69
    dec  B                                             ;; 00:0fa9 $05
    jr   NZ, .jr_00_0fa6                               ;; 00:0faa $20 $fa
    ld   A, OCPSF_AUTOINC                              ;; 00:0fac $3e $80
    ldh  [rOCPS], A                                    ;; 00:0fae $e0 $6a
    ld   HL, wDA0B_Entity_Palettes                        ;; 00:0fb0 $21 $0b $da
    ld   B, CGB_PALETTE_RAM_SIZE                       ;; 00:0fb3 $06 $40
.jr_00_0fb5:
    ld   A, [HL+]                                      ;; 00:0fb5 $2a
    ldh  [rOCPD], A                                    ;; 00:0fb6 $e0 $6b
    dec  B                                             ;; 00:0fb8 $05
    jr   NZ, .jr_00_0fb5                               ;; 00:0fb9 $20 $fa
    ret                                                ;; 00:0fbb $c9

call_00_0fbc_Fade_Start:
; Starts fade mode A (FADE_MODE_*). No-op if that mode is already running. Resets the
; step delay to 4 frames and dispatches through .data_00_0fd7_FadeTargetSetters to fill
; in wDAD4_TargetBGP..wDAD6_TargetOBP1
    ld   HL, wDAD9_FadeMode                                     ;; 00:0fbc $21 $d9 $da
    cp   A, [HL]                                       ;; 00:0fbf $be
    ret  Z                                             ;; 00:0fc0 $c8
    ld   [HL], A                                       ;; 00:0fc1 $77
    dec  A                                             ;; 00:0fc2 $3d
    ld   L, A                                          ;; 00:0fc3 $6f
    ld   H, $00                                        ;; 00:0fc4 $26 $00
    add  HL, HL                                        ;; 00:0fc6 $29
    ld   DE, .data_00_0fd7_FadeTargetSetters                    ;; 00:0fc7 $11 $d7 $0f
    add  HL, DE                                        ;; 00:0fca $19
    ld   A, [HL+]                                      ;; 00:0fcb $2a
    ld   H, [HL]                                       ;; 00:0fcc $66
    ld   L, A                                          ;; 00:0fcd $6f
    ld   A, FADE_STEP_DELAY_FRAMES                     ;; 00:0fce $3e $04
    ld   [wDADA_FadeStepDelay], A                                    ;; 00:0fd0 $ea $da $da
    ld   [wDADB_FadeStepCounter], A                                    ;; 00:0fd3 $ea $db $da
    jp   HL                                            ;; 00:0fd6 $e9
.data_00_0fd7_FadeTargetSetters:
; indexed by FADE_MODE_* - 1
    dw   .jp_00_0fdd_FadeTarget_LevelPalettes          ;; 00:0fd7 pP
    dw   .jp_00_0fed_FadeTarget_White                  ;; 00:0fd9 pP
    dw   .jp_00_0ff8_FadeTarget_Black                  ;; 00:0fdb pP
.jp_00_0fdd_FadeTarget_LevelPalettes:
    ld   HL, wDAD1_LevelBGP                                     ;; 00:0fdd $21 $d1 $da
    ld   A, [HL+]                                      ;; 00:0fe0 $2a
    ld   [wDAD4_TargetBGP], A                                    ;; 00:0fe1 $ea $d4 $da
    ld   A, [HL+]                                      ;; 00:0fe4 $2a
    ld   [wDAD5_TargetOBP0], A                                    ;; 00:0fe5 $ea $d5 $da
    ld   A, [HL+]                                      ;; 00:0fe8 $2a
    ld   [wDAD6_TargetOBP1], A                                    ;; 00:0fe9 $ea $d6 $da
    ret                                                ;; 00:0fec $c9
.jp_00_0fed_FadeTarget_White:
    xor  A, A                                          ;; 00:0fed $af
    ld   [wDAD4_TargetBGP], A                                    ;; 00:0fee $ea $d4 $da
    ld   [wDAD5_TargetOBP0], A                                    ;; 00:0ff1 $ea $d5 $da
    ld   [wDAD6_TargetOBP1], A                                    ;; 00:0ff4 $ea $d6 $da
    ret                                                ;; 00:0ff7 $c9
.jp_00_0ff8_FadeTarget_Black:
    ld   A, $ff                                        ;; 00:0ff8 $3e $ff
    ld   [wDAD4_TargetBGP], A                                    ;; 00:0ffa $ea $d4 $da
    ld   [wDAD5_TargetOBP0], A                                    ;; 00:0ffd $ea $d5 $da
    ld   [wDAD6_TargetOBP1], A                                    ;; 00:1000 $ea $d6 $da
    ret                                                ;; 00:1003 $c9

call_00_1004_Fade_Update:
; Runs one fade step every wDADA_FadeStepDelay frames, then nudges each palette register
; selected by wDAD7_FadeMaskLo / wDAD8_FadeMaskHi one shade toward its target
    ld   A, [wDAD9_FadeMode]                                    ;; 00:1004 $fa $d9 $da
    and  A, A                                          ;; 00:1007 $a7
    ret  Z                                             ;; 00:1008 $c8
    ld   HL, wDADB_FadeStepCounter                                     ;; 00:1009 $21 $db $da
    dec  [HL]                                          ;; 00:100c $35
    ret  NZ                                            ;; 00:100d $c0
    ld   A, [wDADA_FadeStepDelay]                                    ;; 00:100e $fa $da $da
    ld   [HL], A                                       ;; 00:1011 $77
    ld   HL, wDAD9_FadeMode                                     ;; 00:1012 $21 $d9 $da
    ld   L, [HL]                                       ;; 00:1015 $6e
    dec  L                                             ;; 00:1016 $2d
    ld   H, $00                                        ;; 00:1017 $26 $00
    add  HL, HL                                        ;; 00:1019 $29
    ld   DE, .data_00_1043_FadeStepHooks                       ;; 00:101a $11 $43 $10
    add  HL, DE                                        ;; 00:101d $19
    ld   A, [HL+]                                      ;; 00:101e $2a
    ld   H, [HL]                                       ;; 00:101f $66
    ld   L, A                                          ;; 00:1020 $6f
    call call_00_10bd_JumpHL                                  ;; 00:1021 $cd $bd $10
    ld   HL, wDAD7_FadeMaskLo                                     ;; 00:1024 $21 $d7 $da
    bit  0, [HL]                                       ;; 00:1027 $cb $46 ; FADE_MASK_BGP
    ld   A, FADE_REG_BGP                               ;; 00:1029 $3e $00
    call NZ, call_00_104a_Fade_StepPaletteRegister                              ;; 00:102b $c4 $4a $10
    ld   HL, wDAD8_FadeMaskHi                                     ;; 00:102e $21 $d8 $da
    bit  0, [HL]                                       ;; 00:1031 $cb $46 ; FADE_MASK_OBP0
    ld   A, FADE_REG_OBP0                              ;; 00:1033 $3e $01
    call NZ, call_00_104a_Fade_StepPaletteRegister                              ;; 00:1035 $c4 $4a $10
    ld   HL, wDAD8_FadeMaskHi                                     ;; 00:1038 $21 $d8 $da
    bit  1, [HL]                                       ;; 00:103b $cb $4e ; FADE_MASK_OBP1
    ld   A, FADE_REG_OBP1                              ;; 00:103d $3e $02
    call NZ, call_00_104a_Fade_StepPaletteRegister                              ;; 00:103f $c4 $4a $10
    ret                                                ;; 00:1042 $c9
.data_00_1043_FadeStepHooks:
; per-mode pre-step hook, indexed by FADE_MODE_* - 1. All three point at the ret at
; $1049, so no mode currently does anything extra
    dw   .ret_00_1049
    dw   .ret_00_1049
    dw   .ret_00_1049
.ret_00_1049:
    ret                                                ;; 00:1049 $c9

call_00_104a_Fade_StepPaletteRegister:
; Moves palette register A (0 = BGP, 1 = OBP0, 2 = OBP1) one shade closer to its target.
; Compares each of the four 2-bit colour entries in wDACE_CurrentBGP + A against the
; matching entry in wDAD4_TargetBGP + A and increments or decrements it by one
    ld   E, A                                          ;; 00:104a $5f
    ld   D, $00                                        ;; 00:104b $16 $00
    ld   HL, wDACE_CurrentBGP                                     ;; 00:104d $21 $ce $da
    add  HL, DE                                        ;; 00:1050 $19
    push HL                                            ;; 00:1051 $e5
    ld   C, [HL]                                       ;; 00:1052 $4e
    ld   HL, wDAD4_TargetBGP                                     ;; 00:1053 $21 $d4 $da
    add  HL, DE                                        ;; 00:1056 $19
    ld   E, [HL]                                       ;; 00:1057 $5e
    ld   B, $04                                        ;; 00:1058 $06 $04 ; four 2-bit colour entries
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
; Calls HL in bank A and comes back to the caller's bank. The FARCALL macro is what
; sets up A and HL; this is its body.
;
; Note it loads wD59D_ReturnBank into A immediately before jumping, so the callee is
; entered with A holding the bank to return to rather than anything the caller chose -
; worth knowing before assuming A is a free argument register across a FARCALL.
; The callee's return value in A does survive, since it is pushed around RestoreBank
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
; Switches to ROM bank A and PUSHES it onto the bank stack that
; wD59A_PtrToBankStackPosition walks, so nesting works: every SwitchBank must be
; matched by a call_00_10a3_RestoreBank or the stack pointer drifts.
;
; The register write itself is SET_MBC_BANK - see the macro for why the SRAM bank
; has to move with the ROM bank
    ld   HL, wD59A_PtrToBankStackPosition                                     ;; 00:1089 $21 $9a $d5
    ld   E, [HL]                                       ;; 00:108c $5e
    inc  HL                                            ;; 00:108d $23
    ld   D, [HL]                                       ;; 00:108e $56
    inc  DE                                            ;; 00:108f $13
    ld   [DE], A                                       ;; 00:1090 $12
    ld   [HL], D                                       ;; 00:1091 $72
    dec  HL                                            ;; 00:1092 $2b
    ld   [HL], E                                       ;; 00:1093 $73
    ld   [wD59C_CurrentROMBank], A                                    ;; 00:1094 $ea $9c $d5
    SET_MBC_BANK                                       ;; 00:1097
    ret                                                ;; 00:10a2 $c9

call_00_10a3_RestoreBank:
; POPS the bank stack and switches back to whatever was underneath, mirroring
; call_00_1089_SwitchBank exactly - `dec DE` here against its `inc DE`. Clobbers A
; with the restored bank number
    ld   HL, wD59A_PtrToBankStackPosition                                     ;; 00:10a3 $21 $9a $d5
    ld   E, [HL]                                       ;; 00:10a6 $5e
    inc  HL                                            ;; 00:10a7 $23
    ld   D, [HL]                                       ;; 00:10a8 $56
    dec  DE                                            ;; 00:10a9 $1b
    ld   A, [DE]                                       ;; 00:10aa $1a
    ld   [HL], D                                       ;; 00:10ab $72
    dec  HL                                            ;; 00:10ac $2b
    ld   [HL], E                                       ;; 00:10ad $73
    ld   [wD59C_CurrentROMBank], A                                    ;; 00:10ae $ea $9c $d5
    SET_MBC_BANK                                       ;; 00:10b1
    ret                                                ;; 00:10bc $c9

call_00_10bd_JumpHL:
; `call call_00_10bd_JumpHL` is how this codebase does an indirect CALL - the `jp hl`
; here leaves the return address of the CALL on the stack, so the routine at HL
; returns to the caller. call_00_1078_FarCall and call_00_1004_Fade_Update both rely
; on that
    jp   HL                                            ;; 00:10bd $e9

call_00_10be_ReadJoypadInput:
; Reads both halves of the pad and leaves the buttons in wD59F_RawInputs, active
; high, in PADF_* order: d-pad in the high nibble, buttons in the low one.
;
; The repeated `ldh a, [C]` reads are the standard settle delay after switching the
; selector line - the pad matrix is slow to respond. The button half gets fourteen
; reads against the d-pad's three, because it is switched to while the previous
; result is still being shifted about and needs longer.
;
; C is the low byte of rP1 throughout, which is what lets `ldh [C], a` address it
    ld   C, LOW(rP1)                                   ;; 00:10be $0e $00
    ld   A, P1F_GET_DPAD                               ;; 00:10c0 $3e $20
    ldh  [C], A                                        ;; 00:10c2 $e2
    ldh  A, [C]                                        ;; 00:10c3 $f2
    ldh  A, [C]                                        ;; 00:10c4 $f2
    ldh  A, [C]                                        ;; 00:10c5 $f2
    ld   B, A                                          ;; 00:10c6 $47
    ld   A, P1F_GET_BTN                                ;; 00:10c7 $3e $10
    ldh  [C], A                                        ;; 00:10c9 $e2
    ld   A, B                                          ;; 00:10ca $78
    and  A, $0f                                        ;; 00:10cb $e6 $0f
    swap A                                             ;; 00:10cd $cb $37 ; d-pad into the high nibble
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
    cpl                                                ;; 00:10e1 $2f ; the hardware reads active low
    ld   B, A                                          ;; 00:10e2 $47
    ld   A, P1F_GET_NONE                               ;; 00:10e3 $3e $30
    ldh  [C], A                                        ;; 00:10e5 $e2
    ld   A, B                                          ;; 00:10e6 $78
    ld   [wD59F_RawInputs], A                                    ;; 00:10e7 $ea $9f $d5
    ret                                                ;; 00:10ea $c9

call_00_10eb_WaitUntilNoInputPressed:
; Blocks, a frame at a time, until nothing is held. Used before a screen that reacts
; to a button, so a press left over from the previous screen does not carry into it
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:10eb $cd $b4 $0a
    ld   A, [wD59F_RawInputs]                                    ;; 00:10ee $fa $9f $d5
    and  A, A                                          ;; 00:10f1 $a7
    jr   NZ, call_00_10eb_WaitUntilNoInputPressed                              ;; 00:10f2 $20 $f7
    ret                                                ;; 00:10f4 $c9

; ------------------------------------------------------------------
; CheckInput* - "is this button held", returning NZ if it is.
;
; These report the button being HELD, not a fresh press; nothing here compares
; against a previous frame. Code that needs an edge does its own bookkeeping, which
; is what wD759_ButtonBlockingFlags is for on the player side.
;
; The four d-pad helpers mask with `and`, so they do not care what else is held.
; START and SELECT compare with `cp` instead and only report a press when that button
; is the ONLY one down - see call_00_110d_CheckInputStart
; ------------------------------------------------------------------
call_00_10f5_CheckInputLeft:
    ld   A, [wD59F_RawInputs]                                    ;; 00:10f5 $fa $9f $d5
    and  A, PADF_LEFT                                        ;; 00:10f8 $e6 $20
    ret                                                ;; 00:10fa $c9

call_00_10fb_CheckInputRight:
    ld   A, [wD59F_RawInputs]                                    ;; 00:10fb $fa $9f $d5
    and  A, PADF_RIGHT                                        ;; 00:10fe $e6 $10
    ret                                                ;; 00:1100 $c9

call_00_1101_CheckInputUp:
    ld   A, [wD59F_RawInputs]                                    ;; 00:1101 $fa $9f $d5
    and  A, PADF_UP                                        ;; 00:1104 $e6 $40
    ret                                                ;; 00:1106 $c9

call_00_1107_CheckInputDown:
    ld   A, [wD59F_RawInputs]                                    ;; 00:1107 $fa $9f $d5
    and  A, PADF_DOWN                                        ;; 00:110a $e6 $80
    ret                                                ;; 00:110c $c9

call_00_110d_CheckInputStart:
; NZ if START is held - but note the `cp` rather than `and`: this only reports a
; press when START is the ONLY button down, so holding it with any direction reads as
; not pressed. call_00_1118_CheckInputSelect does the same.
;
; The tail is `xor a / ret` against `and a / ret`, which looks redundant but is not:
; both paths have to leave the Z flag set from the comparison the caller will test,
; and the not-pressed path also has to clear A
    ld   A, [wD59F_RawInputs]                                    ;; 00:110d $fa $9f $d5
    cp   A, PADF_START                                        ;; 00:1110 $fe $08
    jr   Z, .jr_00_1116                                ;; 00:1112 $28 $02
    xor  A, A                                          ;; 00:1114 $af
    ret                                                ;; 00:1115 $c9
.jr_00_1116:
    and  A, A                                          ;; 00:1116 $a7
    ret                                                ;; 00:1117 $c9

call_00_1118_CheckInputSelect:
    ld   A, [wD59F_RawInputs]                                    ;; 00:1118 $fa $9f $d5
    cp   A, PADF_SELECT                                        ;; 00:111b $fe $04
    jr   Z, .jr_00_1121                                ;; 00:111d $28 $02
    xor  A, A                                          ;; 00:111f $af
    ret                                                ;; 00:1120 $c9
.jr_00_1121:
    and  A, A                                          ;; 00:1121 $a7
    ret                                                ;; 00:1122 $c9

call_00_1123_CheckInputA:
    ld   A, [wD59F_RawInputs]                                    ;; 00:1123 $fa $9f $d5
    and  A, PADF_A                                        ;; 00:1126 $e6 $01
    ret                                                ;; 00:1128 $c9

call_00_1129_CheckInputB:
    ld   A, [wD59F_RawInputs]                                    ;; 00:1129 $fa $9f $d5
    and  A, PADF_B                                        ;; 00:112c $e6 $02
    ret                                                ;; 00:112e $c9

call_00_112f_QueueSFX:
; Queues SFX_* id C for the next call_00_1138_PlayQueuedSFX - but only if the slot is
; currently SFX_NONE. A sound already waiting is NOT replaced, so when two effects
; are requested in the same frame the second is silently dropped rather than
; overriding the first
    ld   HL, wD789_QueuedSFX                                     ;; 00:112f $21 $89 $d7
    ld   A, [HL]                                       ;; 00:1132 $7e
    cp   A, SFX_NONE                                        ;; 00:1133 $fe $ff
    ret  NZ                                            ;; 00:1135 $c0
    ld   [HL], C                                       ;; 00:1136 $71
    ret                                                ;; 00:1137 $c9

call_00_1138_PlayQueuedSFX:
; Plays whatever call_00_112f_QueueSFX left pending, or returns if the slot is empty.
; On the non-empty path it falls straight through into call_00_113e_PlaySFX
    ld   A, [wD789_QueuedSFX]                                    ;; 00:1138 $fa $89 $d7
    cp   A, SFX_NONE                                        ;; 00:113b $fe $ff
    ret  Z                                             ;; 00:113d $c8
call_00_113e_PlaySFX:
; Plays SFX_* id A.
;
; The game's sfx ids are not the driver's. .data_00_116c_SFXChannelTable translates:
; each row is (count mask, first driver sfx id), and for every set bit of the mask this
; calls Audio_PlaySfx once with the driver id incremented each time. Every row in the
; table uses mask $01, so in practice it is one driver track per effect and the loop
; runs its four passes to fire once.
;
; The call lands in whichever bank wD788_CurrentAudioBank names, which is the bank the
; current music came from - so the same SFX_* id sounds different depending on what is
; playing. Finishes by clearing wD789_QueuedSFX back to SFX_NONE
    ld   L, A                                          ;; 00:113e $6f
    ld   H, $00                                        ;; 00:113f $26 $00
    add  HL, HL                                        ;; 00:1141 $29 ; two bytes per row
    ld   DE, .data_00_116c_SFXChannelTable                                     ;; 00:1142 $11 $6c $11
    add  HL, DE                                        ;; 00:1145 $19
    push HL                                            ;; 00:1146 $e5
    ld   A, [wD788_CurrentAudioBank]                                    ;; 00:1147 $fa $88 $d7
    call call_00_1089_SwitchBank                                  ;; 00:114a $cd $89 $10
    pop  HL                                            ;; 00:114d $e1
    ld   C, [HL]                                       ;; 00:114e $4e ; count mask
    inc  HL                                            ;; 00:114f $23
    ld   A, [HL]                                       ;; 00:1150 $7e ; first driver id
    ld   B, $04                                        ;; 00:1151 $06 $04 ; four hardware channels
.jr_00_1153:
    bit  0, C                                          ;; 00:1153 $cb $41
    jr   Z, .jr_00_115f                                ;; 00:1155 $28 $08
    push AF                                            ;; 00:1157 $f5
    push BC                                            ;; 00:1158 $c5
    call call_22_4047_Audio_PlaySfx                                  ;; 00:1159 $cd $47 $40
    pop  BC                                            ;; 00:115c $c1
    pop  AF                                            ;; 00:115d $f1
    inc  A                                             ;; 00:115e $3c
.jr_00_115f:
    rrc  C                                             ;; 00:115f $cb $09
    dec  B                                             ;; 00:1161 $05
    jr   NZ, .jr_00_1153                               ;; 00:1162 $20 $ef
    ld   A, SFX_NONE                                   ;; 00:1164 $3e $ff
    ld   [wD789_QueuedSFX], A                                    ;; 00:1166 $ea $89 $d7
    jp   call_00_10a3_RestoreBank                                  ;; 00:1169 $c3 $a3 $10
.data_00_116c_SFXChannelTable:
; SFX_* id -> driver sfx id, two bytes per row, 58 rows covering SFX_EMPTY through
; SFX_REZ_BUTTON.
;
; First byte is a count mask: one bit per driver track to start, so $01 means one and
; $03 would mean two at consecutive ids. Every row here is $01. Second byte is the
; driver id to start at.
;
; The mapping is nearly the identity but not quite: four driver ids are skipped, so
; from SFX_FLOWER_HAMMER onwards the game id and the driver id drift apart. Those
; four, plus driver ids $3E-$41 past the end of the table, are the eight sound
; effects present in every audio bank that nothing in the game can play. The skips
; are marked below
    sfx_entry SFX_ONE_TRACK, $00  ; SFX_EMPTY
    sfx_entry SFX_ONE_TRACK, $01  ; SFX_01
    sfx_entry SFX_ONE_TRACK, $02  ; SFX_TV_SMASH
    sfx_entry SFX_ONE_TRACK, $03  ; SFX_SILVER_REMOTE
    sfx_entry SFX_ONE_TRACK, $04  ; SFX_GOLD_REMOTE
    sfx_entry SFX_ONE_TRACK, $05  ; SFX_05
    sfx_entry SFX_ONE_TRACK, $06  ; SFX_COLLECTIBLE
    sfx_entry SFX_ONE_TRACK, $07  ; SFX_07
    sfx_entry SFX_ONE_TRACK, $08  ; SFX_08
    sfx_entry SFX_ONE_TRACK, $09  ; SFX_09
    sfx_entry SFX_ONE_TRACK, $0a  ; SFX_0A
    sfx_entry SFX_ONE_TRACK, $0b  ; SFX_0B
    sfx_entry SFX_ONE_TRACK, $0c  ; SFX_GEX_JUMP
    sfx_entry SFX_ONE_TRACK, $0d  ; SFX_GEX_DOUBLE_JUMP
    sfx_entry SFX_ONE_TRACK, $0e  ; SFX_GEX_COLLAPSE
    sfx_entry SFX_ONE_TRACK, $0f  ; SFX_GEX_DEATH
    sfx_entry SFX_ONE_TRACK, $10  ; SFX_GEX_HURT
    sfx_entry SFX_ONE_TRACK, $11  ; SFX_GEX_SPAWN
    sfx_entry SFX_ONE_TRACK, $12  ; SFX_GEX_HIT_BOUNCE
    sfx_entry SFX_ONE_TRACK, $13  ; SFX_13
    sfx_entry SFX_ONE_TRACK, $14  ; SFX_GEX_POWERUP_ACTIVE
    sfx_entry SFX_ONE_TRACK, $15  ; SFX_GEX_POWERUP_EXPIRED
    sfx_entry SFX_ONE_TRACK, $16  ; SFX_16
    sfx_entry SFX_ONE_TRACK, $17  ; SFX_ENEMY_DEFEATED
    sfx_entry SFX_ONE_TRACK, $18  ; SFX_18
    sfx_entry SFX_ONE_TRACK, $19  ; SFX_HARD_HEAD_AREA_HAZARD
    sfx_entry SFX_ONE_TRACK, $1a  ; SFX_FALLING_HAZARD
    sfx_entry SFX_ONE_TRACK, $1b  ; SFX_1B
    sfx_entry SFX_ONE_TRACK, $1d  ; SFX_FLOWER_HAMMER - driver $1c skipped, unreachable from here on
    sfx_entry SFX_ONE_TRACK, $1e  ; SFX_BUMBLEBEE
    sfx_entry SFX_ONE_TRACK, $1f  ; SFX_ROCKET
    sfx_entry SFX_ONE_TRACK, $20  ; SFX_1F
    sfx_entry SFX_ONE_TRACK, $21  ; SFX_HUNTER
    sfx_entry SFX_ONE_TRACK, $22  ; SFX_21
    sfx_entry SFX_ONE_TRACK, $23  ; SFX_22
    sfx_entry SFX_ONE_TRACK, $24  ; SFX_23
    sfx_entry SFX_ONE_TRACK, $26  ; SFX_ENEMY_JUMP - driver $25 skipped, unreachable from here on
    sfx_entry SFX_ONE_TRACK, $27  ; SFX_25
    sfx_entry SFX_ONE_TRACK, $29  ; SFX_26 - driver $28 skipped, unreachable from here on
    sfx_entry SFX_ONE_TRACK, $2a  ; SFX_FALLING_PLATFORM
    sfx_entry SFX_ONE_TRACK, $2b  ; SFX_28
    sfx_entry SFX_ONE_TRACK, $2c  ; SFX_ALT_ENEMY_JUMP
    sfx_entry SFX_ONE_TRACK, $2d  ; SFX_GEX_POWERED_JUMP
    sfx_entry SFX_ONE_TRACK, $2e  ; SFX_POWERED_WALKWAY
    sfx_entry SFX_ONE_TRACK, $2f  ; SFX_CANNON_ROTATE
    sfx_entry SFX_ONE_TRACK, $30  ; SFX_JAR
    sfx_entry SFX_ONE_TRACK, $31  ; SFX_2E
    sfx_entry SFX_ONE_TRACK, $33  ; SFX_DRAGON - driver $32 skipped, unreachable from here on
    sfx_entry SFX_ONE_TRACK, $34  ; SFX_CANNON
    sfx_entry SFX_ONE_TRACK, $35  ; SFX_FALLING_BOULDER
    sfx_entry SFX_ONE_TRACK, $36  ; SFX_32
    sfx_entry SFX_ONE_TRACK, $37  ; SFX_PTEROSAUR
    sfx_entry SFX_ONE_TRACK, $38  ; SFX_MULTI_PROJECTILE
    sfx_entry SFX_ONE_TRACK, $39  ; SFX_GEAR
    sfx_entry SFX_ONE_TRACK, $3a  ; SFX_GUN_PROJECTILE
    sfx_entry SFX_ONE_TRACK, $3b  ; SFX_EXPLOSION
    sfx_entry SFX_ONE_TRACK, $3c  ; SFX_REZ_HURT
    sfx_entry SFX_ONE_TRACK, $3d  ; SFX_REZ_BUTTON

call_00_11e0_PlayMusicBasedOnLevel:
; Looks up the current map's song in .data_00_11ed_LevelMusic and hands it to
; call_00_120c_SetupMusic, which no-ops if that song is already playing - so this is
; safe to call on every room load, not just level changes
    ld   HL, wD624_CurrentLevelId                                   ;; 00:11e0 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:11e3 $6e
    ld   H, $00                                        ;; 00:11e4 $26 $00
    ld   DE, .data_00_11ed_LevelMusic                                     ;; 00:11e6 $11 $ed $11
    add  HL, DE                                        ;; 00:11e9 $19
    ld   A, [HL]                                       ;; 00:11ea $7e
    jr   call_00_120c_SetupMusic                                  ;; 00:11eb $18 $1f
.data_00_11ed_LevelMusic:
; this determines which music to use for each level
    db   MUSIC_MEDIA_DIMENSION       ; MAP_MEDIA_DIMENSION
    db   MUSIC_TOON_TV               ; MAP_TOON_TV_OUT_OF_TOON
    db   MUSIC_SCREAM_TV             ; MAP_SCREAM_TV_SMELLRAISER
    db   MUSIC_SCREAM_TV             ; MAP_SCREAM_TV_FRANKENSTEINFELD
    db   MUSIC_CIRCUIT_CENTRAL       ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   MUSIC_KUNG_FU_THEATER       ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_06
    db   MUSIC_PREHISTORY_CHANNEL    ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   MUSIC_TOON_TV               ; MAP_TOON_TV_FINE_TOONING
    db   MUSIC_PREHISTORY_CHANNEL    ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   MUSIC_CIRCUIT_CENTRAL       ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   MUSIC_SCREAM_TV             ; MAP_SCREAM_TV_POLTERGEX
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_0C
    db   MUSIC_KUNG_FU_THEATER       ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   MUSIC_REZOPOLIS             ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_0F
    db   MUSIC_SCREAM_TV             ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_11
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_12
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_13
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_14
    db   MUSIC_KUNG_FU_THEATER       ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   MUSIC_REZOPOLIS             ; MAP_REZOPOLIS_BUGGED_OUT
    db   MUSIC_CIRCUIT_CENTRAL       ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   MUSIC_PREHISTORY_CHANNEL    ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   MUSIC_SCREAM_TV             ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   MUSIC_REZOPOLIS             ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_1B
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_1C
    db   MUSIC_MEDIA_DIMENSION       ; MAP_UNUSED_1D
    db   MUSIC_REZOPOLIS             ; MAP_BOSS_TV_CHANNEL_Z

call_00_120c_SetupMusic:
; Starts music track A, or returns immediately if it is already the one playing
; (wD78A_MusicId). Syncs to vblank first so the swap does not land mid-frame.
;
; A song is FOUR driver tracks, one per hardware channel, stored at four consecutive
; ids. The .data_00_1244_MusicList record supplies the audio bank and the first of the
; four; the count mask is $0F, so the loop below runs four times and calls
; Audio_PlayMusic with the id incremented each pass. Four calls, four channels, one
; song.
;
; The record's bank byte is what sets wD788_CurrentAudioBank, and it stays set until
; the next song change - which is how sound effects find a bank of their own.
;
; Ends by playing SFX_EMPTY through call_00_113e_PlaySFX, which is what silences
; whatever the sfx side was holding
    push AF                                            ;; 00:120c $f5
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:120d $cd $b4 $0a
    pop  AF                                            ;; 00:1210 $f1
    ld   HL, wD78A_MusicId                                     ;; 00:1211 $21 $8a $d7
    cp   A, [HL]                                       ;; 00:1214 $be
    ret  Z                                             ;; 00:1215 $c8 ; already playing
    ld   [HL], A                                       ;; 00:1216 $77
    ld   L, A                                          ;; 00:1217 $6f
    ld   H, $00                                        ;; 00:1218 $26 $00
    add  HL, HL                                        ;; 00:121a $29
    add  HL, HL                                        ;; 00:121b $29 ; four bytes per record
    ld   DE, .data_00_1244_MusicList                                     ;; 00:121c $11 $44 $12
    add  HL, DE                                        ;; 00:121f $19
    ld   A, [HL+]                                      ;; 00:1220 $2a
    ld   [wD788_CurrentAudioBank], A                                    ;; 00:1221 $ea $88 $d7
    push HL                                            ;; 00:1224 $e5
    call call_00_1089_SwitchBank                                  ;; 00:1225 $cd $89 $10
    pop  HL                                            ;; 00:1228 $e1
    ld   A, [HL+]                                      ;; 00:1229 $2a ; first driver track id
    ld   C, [HL]                                       ;; 00:122a $4e ; count mask
    ld   B, $04                                        ;; 00:122b $06 $04 ; four hardware channels
.jr_00_122d:
    push AF                                            ;; 00:122d $f5
    push BC                                            ;; 00:122e $c5
    bit  0, C                                          ;; 00:122f $cb $41
    call NZ, call_22_4092_Audio_PlayMusic                              ;; 00:1231 $c4 $92 $40
    pop  BC                                            ;; 00:1234 $c1
    pop  AF                                            ;; 00:1235 $f1
    inc  A                                             ;; 00:1236 $3c
    rrc  C                                             ;; 00:1237 $cb $09
    dec  B                                             ;; 00:1239 $05
    jr   NZ, .jr_00_122d                               ;; 00:123a $20 $f1
    call call_00_10a3_RestoreBank                                  ;; 00:123c $cd $a3 $10
    ld   A, SFX_EMPTY                                  ;; 00:123f $3e $00
    jp   call_00_113e_PlaySFX                                  ;; 00:1241 $c3 $3e $11
.data_00_1244_MusicList:
; The eight songs, indexed by MUSIC_*. Each record names an audio bank and the first
; of four consecutive driver tracks, one per hardware channel - so a song occupies
; driver ids n through n+3.
;
; Three songs live in bank $21, three in $22 and two in $23, which accounts for all
; 12, 12 and 8 music tracks those banks hold. Bank $24 is never named here, so
; nothing in the ROM can select it and its 66 tracks are unreachable.
;
; The bank byte is also what leaves wD788_CurrentAudioBank pointing somewhere, which
; is how sound effects end up being played out of whichever bank the current song
; came from
    music_record BANK_21, $04, MUSIC_FOUR_TRACKS  ; MUSIC_KUNG_FU_THEATER
    music_record BANK_21, $00, MUSIC_FOUR_TRACKS  ; MUSIC_CIRCUIT_CENTRAL
    music_record BANK_21, $08, MUSIC_FOUR_TRACKS  ; MUSIC_PREHISTORY_CHANNEL
    music_record BANK_22, $08, MUSIC_FOUR_TRACKS  ; MUSIC_REZOPOLIS
    music_record BANK_22, $04, MUSIC_FOUR_TRACKS  ; MUSIC_UNK_04
    music_record BANK_22, $00, MUSIC_FOUR_TRACKS  ; MUSIC_SCREAM_TV
    music_record BANK_23, $04, MUSIC_FOUR_TRACKS  ; MUSIC_TOON_TV
    music_record BANK_23, $00, MUSIC_FOUR_TRACKS  ; MUSIC_MEDIA_DIMENSION

INCLUDE "code/bank00_bg_map.asm"
INCLUDE "code/bank00_tile_hit_scripts.asm"
INCLUDE "code/bank00_cutscenes.asm"
INCLUDE "code/bank00_map_init_data.asm"
INCLUDE "code/bank00_entity_utils.asm"
INCLUDE "code/bank00_particles.asm"

call_00_3bf4_MediaDimension_RequestTVScreenGfx:
; Hub only. Called when Gex walks up to one of the tvs: works out which channel that
; tv shows and asks for its screen image to be streamed into VRAM_HUD_TILES, so the
; tv "switches on" as he approaches.
;
; Getting from the tv to the channel takes two hops. The current entity's address
; gives its slot number, the slot indexes wD301_EntityListIndexesForCurrentEntities
; to get the entity's index in the level's spawn list, and THAT indexes the table
; below to get a screen id. The middle step is what makes this depend on the order
; entities are listed in entity_list_media_dimension.asm rather than on the tv itself
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:3bf4 $fa $24 $d6
    and  A, A                                          ;; 00:3bf7 $a7
    ret  NZ                                            ;; 00:3bf8 $c0
    ; slot = (entity address >> 5) & 7
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3bf9 $fa $00 $d3
    rlca                                               ;; 00:3bfc $07
    rlca                                               ;; 00:3bfd $07
    rlca                                               ;; 00:3bfe $07
    and  A, $07                                        ;; 00:3bff $e6 $07
    ld   L, A                                          ;; 00:3c01 $6f
    ld   H, $00                                        ;; 00:3c02 $26 $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities                                     ;; 00:3c04 $11 $01 $d3
    add  HL, DE                                        ;; 00:3c07 $19
    ld   A, [HL]                                       ;; 00:3c08 $7e
    dec  A                                             ;; 00:3c09 $3d
    srl  A                                             ;; 00:3c0a $cb $3f
    ld   L, A                                          ;; 00:3c0c $6f
    ld   H, $00                                        ;; 00:3c0d $26 $00
    ld   DE, .data_00_3c20_TVScreenIdByEntityListIndex                                     ;; 00:3c0f $11 $20 $3c
    add  HL, DE                                        ;; 00:3c12 $19
    ld   A, [HL]                                       ;; 00:3c13 $7e
    cp   A, TV_SCREEN_NONE                             ;; 00:3c14 $fe $ff
    ret  Z                                             ;; 00:3c16 $c8 ; this entity is not a tv
    ld   [wD610_MediaDimension_TVScreenId], A                                    ;; 00:3c17 $ea $10 $d6
    ld   HL, wD60F_GfxTransferFlags                                     ;; 00:3c1a $21 $0f $d6
    set  GFX_XFER_MEDIA_DIMENSION_TV, [HL]             ;; 00:3c1d $cb $e6
    ret                                                ;; 00:3c1f $c9
.data_00_3c20_TVScreenIdByEntityListIndex:
; Screen image id per hub entity, indexed by (spawn list index - 1) >> 1 - so one
; entry covers a pair of consecutive list entries, which is how a tv and its button
; share a screen. TV_SCREEN_NONE marks an entity that is not a tv at all.
;
; The ids are scattered rather than sequential because they are page numbers into
; bank $14, packed in whatever order the artwork was assembled rather than in channel
; order. 31 entries, of which 20 name a screen - and those 20 are all distinct, so
; every tv in the hub shows a different picture
    db   TV_SCREEN_NONE, $0f, $05, $04, $02, $0c, TV_SCREEN_NONE, $09
    db   $0e, $08, $03, $00, TV_SCREEN_NONE, $0b, $11, TV_SCREEN_NONE
    db   $07, TV_SCREEN_NONE, TV_SCREEN_NONE, TV_SCREEN_NONE, TV_SCREEN_NONE, $0d, $0a, $01
    db   $13, $06, $12, TV_SCREEN_NONE, TV_SCREEN_NONE, TV_SCREEN_NONE, $10

call_00_3c3f_Remotes_RecountAllTotals:
; Recomputes the three collection totals shown on the totals screen and used to gate
; which hub tvs are open. Falls through into the last count
    ld   C, REMOTE_MISSION_MASK                        ;; 00:3c3f $0e $07
    ld   HL, wD64F_MissionRemoteTotal                                     ;; 00:3c41 $21 $4f $d6
    call call_00_3c54_Remotes_CountAndStore                                  ;; 00:3c44 $cd $54 $3c
    ld   C, REMOTE_HIDDEN_MASK                         ;; 00:3c47 $0e $18
    ld   HL, wD650_HiddenRemoteTotal                                     ;; 00:3c49 $21 $50 $d6
    call call_00_3c54_Remotes_CountAndStore                                  ;; 00:3c4c $cd $54 $3c
    ld   C, REMOTE_BONUS_MASK                          ;; 00:3c4f $0e $20
    ld   HL, wD651_BonusMissionTotal                                     ;; 00:3c51 $21 $51 $d6

call_00_3c54_Remotes_CountAndStore:
; Counts the set bits of (wD629_RemoteProgressFlags[n] & C) over all 30 levels and stores
; the total at [HL]. If the total changed, REMOTE_TOTAL_CHANGED (bit 7) is also set so
; the hub knows to play the "new tv unlocked" animation.
;
; That bit 7 is why every reader masks with $7F before comparing - see
; call_00_3899_Entity_CheckRemoteTotalsUnlock, which strips it off all three totals
; before testing them against a tv's requirements
    push HL                                            ;; 00:3c54 $e5
    ld   HL, wD629_RemoteProgressFlags                                     ;; 00:3c55 $21 $29 $d6
    ld   B, LEVEL_COUNT                                ;; 00:3c58 $06 $1e
    ld   E, $00                                        ;; 00:3c5a $1e $00 ; running total
.jr_00_3c5c:
    ld   A, [HL+]                                      ;; 00:3c5c $2a
    and  A, C                                          ;; 00:3c5d $a1
    ld   D, $08                                        ;; 00:3c5e $16 $08 ; bits per byte
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
    ret  Z                                             ;; 00:3c6d $c8 ; unchanged since last count
    ld   [HL], A                                       ;; 00:3c6e $77
    set  REMOTE_TOTAL_CHANGED_BIT, [HL]                ;; 00:3c6f $cb $fe
    ret                                                ;; 00:3c71 $c9

data_00_3c72_Image_PasswordHeadings:
; The words the three password screens put across the top, in one 28x2 tile strip:
; "Enter" "Current" "Invalid" "Password". Entry 7 of data_01_74ed_ImageTable2 - the
; only image in that table that lives outside bank 01, which is presumably just
; where there was room for it.
;
; data_01_592d_MenuScript_PasswordCells stages the whole strip at tile $06, filling
; $06-$3D exactly up to PASSWORD_KEYBOARD_TILE_BASE. The tiles are column major
; (rgbgfx --columns, see the Makefile), so each 8x16 sprite column is a tile pair and
; the three header sprite scripts just index into the strip: $06 picks "Enter", $10
; "Current", $1E "Invalid", and all three follow it with $2C for "Password".
;
; The three header bytes are the usual width / height / skip-copy flag. The $FE after
; the graphics is a stray byte at the very end of the bank, not part of the image
    db   $1c, $02, $00
    INCBIN ".gfx/misc_sprites/image_password_headings.bin"
    db   $fe  
