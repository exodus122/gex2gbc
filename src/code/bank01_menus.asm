; ==================================================================
; MENUS
;
; Every full-screen non-gameplay state in the game - title, pause, mission
; select, password entry, the totals screens, the credits - is a "menu type",
; and all of them run through the single loop in call_01_4000_MenuLoad. There
; is no per-screen code; a menu is entirely described by data.
;
; Three tables define one:
;
;   data_01_5574_MenuTypeRecords  8 bytes per menu type - a pointer to its script
;                              plus the behaviour flags and cursor geometry.
;                              Copied into wD68A..wD691 on load
;   the script itself          a list of draw commands walked by
;                              call_01_44d7_MenuScript_RunToEnd. Besides
;                              putting graphics on screen, the commands also
;                              register which rows are selectable and what
;                              picking them means, by filling in
;                              wD6C5_Menu_OptionActions
;   data_01_5654_MenuTypeLcdcAndPalette
;                              2 bytes per menu type - the LCDC value and
;                              palette set installed once the script has run
;
; The scripts themselves start at data_01_5692_MenuScript_PausedInMediaDimension
; and are all named MenuScript_*, so the whole set of screens can be read off the
; label list. A script can also chain another one
; (data_01_568c_ChainedScriptTable), which is how the password keyboard's frame and
; its 29 cells, or the three mission select screens and their shared furniture, are
; kept as separate pieces of data.
;
; The four data shapes are written with macros so a screen can be read at a
; glance - menu_type_record, menu_cmd_descriptor, menu_cmd_text / menu_cmd_sub
; and menu_sprite. They are in code/macros/macros.asm, and each one is exactly
; the bytes the interpreter expects; none of them generate code.
;
; MenuLoad blocks: it does not return until the player leaves the screen, and
; the value in A tells the caller why. That is either a MENU_OPTION_* code
; taken from the highlighted row, or MENU_RESULT_DISMISSED / _TIMED_OUT /
; _PASSWORD_GO. Menus that lead to other menus (password entry, the quit
; confirmation) just call MenuLoad again recursively.
;
; Controls are inverted from what you might expect: B confirms the highlighted
; option, A backs out. MENU_FLAG_NO_CANCEL removes the back-out entirely,
; which is how the title and credits screens force the player forward.
;
; The rest of the bank is the machinery those screens need and nothing else: a
; proportional text renderer that composites glyphs into a tile buffer
; (call_01_4a8f_Text_Render), the sprite-script walker that puts the remote icons
; and the cursor into OAM (call_01_4dc8_Menu_BuildSpriteBlock), and the password
; encoder and decoder, which live here because the only thing that ever shows a
; password is a menu.
; ==================================================================

call_01_4000_MenuLoad:
; Loads the menu type in A and runs it until the player leaves. Returns the
; reason in A - see the header above.
;
; Entering here clears wD6DD_Menu_ReturnToType, so this is the "open a fresh
; menu" entry point. .jp_01_4005 just below is the "switch to a different menu
; type without forgetting where we came from" entry, used when START opens the
; pause menu on top of another screen
    ld   HL, wD6DD_Menu_ReturnToType                                     ;; 01:4000 $21 $dd $d6
    ld   [HL], $00                                     ;; 01:4003 $36 $00
.jp_01_4005:
    ld   [wD6DE_MenuType], A                                    ;; 01:4005 $ea $de $d6
    ld   L, A                                          ;; 01:4008 $6f
    ld   H, $00                                        ;; 01:4009 $26 $00
    add  HL, HL                                        ;; 01:400b $29
    add  HL, HL                                        ;; 01:400c $29
    add  HL, HL                                        ;; 01:400d $29
    ld   DE, data_01_5574_MenuTypeRecords                              ;; 01:400e $11 $74 $55
    add  HL, DE                                        ;; 01:4011 $19
    ld   DE, wD68A_Menu_ScriptPtr                                     ;; 01:4012 $11 $8a $d6
    ld   BC, $08                                       ;; 01:4015 $01 $08 $00
    call call_00_07b0_MemCopy                                  ;; 01:4018 $cd $b0 $07
    xor  A, A                                          ;; 01:401b $af
    ld   [wD6E0_MenuSelectedRow], A                                    ;; 01:401c $ea $e0 $d6
    ; the password keyboard starts on column 1 rather than 0, so that the
    ; cursor lands on the first letter instead of the EXIT key
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:401f $fa $8c $d6
    and  A, MENU_FLAG_GRID_CURSOR                      ;; 01:4022 $e6 $02
    jr   Z, .jr_01_402e                                ;; 01:4024 $28 $08
    ld   A, [wD68D_Menu_OptionCount]                                    ;; 01:4026 $fa $8d $d6
    and  A, A                                          ;; 01:4029 $a7
    jr   Z, .jr_01_402e                                ;; 01:402a $28 $02
    ld   A, $01                                        ;; 01:402c $3e $01
.jr_01_402e:
    ld   [wD6DF_MenuSelectedColumn], A                 ;; 01:402e $ea $df $d6
    ld   HL, wD68A_Menu_ScriptPtr                                     ;; 01:4031 $21 $8a $d6
    ld   A, [HL+]                                      ;; 01:4034 $2a
    ld   H, [HL]                                       ;; 01:4035 $66
    ld   L, A                                          ;; 01:4036 $6f
    call call_01_446f_LoadMenuGraphics                 ;; 01:4037 $cd $6f $44
.jp_01_403a: ; reload the timers and go round again - every branch that changes
             ; what is on screen comes back here rather than to the update loop
    ld   A, MENU_TIMEOUT_LO                            ;; 01:403a $3e $ff
    ld   [wD619_MenuTimeoutLo], A                                    ;; 01:403c $ea $19 $d6
    ld   [wD6D6_Menu_BlinkCounter], A                                    ;; 01:403f $ea $d6 $d6
    ld   A, MENU_TIMEOUT_HI                            ;; 01:4042 $3e $05
    ld   [wD61A_MenuTimeoutHi], A                                    ;; 01:4044 $ea $1a $d6
    call call_01_4e94_Menu_WaitForNoInput                                  ;; 01:4047 $cd $94 $4e
    ; the splash screen is the one menu with no update loop at all: it just holds
    ; for MENU_SPLASH_FRAMES and returns, ignoring the player entirely
    ld   A, [wD6DE_MenuType]                                    ;; 01:404a $fa $de $d6
    cp   A, MENU_TYPE_TITLE_SPLASH                     ;; 01:404d $fe $14
    jr   NZ, .jr_01_405c_MenuUpdate                               ;; 01:404f $20 $0b
    ld   B, MENU_SPLASH_FRAMES                         ;; 01:4051 $06 $b4
.jr_01_4053:
    push BC                                            ;; 01:4053 $c5
    call call_00_0ab4_WaitForInterrupt                                  ;; 01:4054 $cd $b4 $0a
    pop  BC                                            ;; 01:4057 $c1
    dec  B                                             ;; 01:4058 $05
    jr   NZ, .jr_01_4053                               ;; 01:4059 $20 $f8
    ret                                                ;; 01:405b $c9

.jr_01_405c_MenuUpdate: ; start of the menu update loop
    call call_01_4d72_Menu_DrawCursor                                  ;; 01:405c $cd $72 $4d
    call call_00_0ab4_WaitForInterrupt                                  ;; 01:405f $cd $b4 $0a
    ld   HL, wD6D6_Menu_BlinkCounter                                     ;; 01:4062 $21 $d6 $d6
    dec  [HL]                                          ;; 01:4065 $35
    call call_01_4d25_Menu_TickHideSprites                                  ;; 01:4066 $cd $25 $4d
    ; Timeout handling. A screen without MENU_FLAG_WAIT_FOR_INPUT counts down
    ; and leaves on its own; one with the flag normally waits forever, unless
    ; MENU_FLAG_DEMO_COUNTDOWN is also set and a demo is playing, in which case
    ; the demo's own clock still has to run out
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:4069 $fa $8c $d6
    ld   C, A                                          ;; 01:406c $4f
    and  A, MENU_FLAG_WAIT_FOR_INPUT                   ;; 01:406d $e6 $80
    jr   Z, .jr_01_4082                                ;; 01:406f $28 $11
    ld   A, C                                          ;; 01:4071 $79
    and  A, MENU_FLAG_DEMO_COUNTDOWN                   ;; 01:4072 $e6 $04
    jr   Z, .jr_01_408f                                ;; 01:4074 $28 $19
    ld   A, [wD61E_DemoModeEnabled]                                    ;; 01:4076 $fa $1e $d6
    and  A, A                                          ;; 01:4079 $a7
    jr   Z, .jr_01_408f                                ;; 01:407a $28 $13
    ld   A, [wD619_MenuTimeoutLo]                                    ;; 01:407c $fa $19 $d6
    and  A, A                                          ;; 01:407f $a7
    jr   Z, .jr_01_408c                                ;; 01:4080 $28 $0a
.jr_01_4082:
    ld   HL, wD619_MenuTimeoutLo                                     ;; 01:4082 $21 $19 $d6
    dec  [HL]                                          ;; 01:4085 $35
    jr   NZ, .jr_01_408f                               ;; 01:4086 $20 $07
    inc  HL                                            ;; 01:4088 $23
    dec  [HL]                                          ;; 01:4089 $35
    jr   NZ, .jr_01_408f                               ;; 01:408a $20 $03
.jr_01_408c:
    ld   A, MENU_RESULT_TIMED_OUT                      ;; 01:408c $3e $70
    ret                                                ;; 01:408e $c9
.jr_01_408f:
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:408f $fa $8c $d6
    and  A, MENU_FLAG_GRID_CURSOR                      ;; 01:4092 $e6 $02
    jp   Z, .jp_01_413a                                ;; 01:4094 $ca $3a $41
    ld   A, [wD59F_RawInputs]                                    ;; 01:4097 $fa $9f $d5
    and  A, PADF_A | PADF_B                                        ;; 01:409a $e6 $03
    jr   Z, .jr_01_40d0                                ;; 01:409c $28 $32
    ld   A, [wD59F_RawInputs]                                    ;; 01:409e $fa $9f $d5
    and  A, $f0                                        ;; 01:40a1 $e6 $f0
    swap A                                             ;; 01:40a3 $cb $37
    ld   E, A                                          ;; 01:40a5 $5f
    ld   A, [wD59F_RawInputs]                                    ;; 01:40a6 $fa $9f $d5
    and  A, PADF_A                                        ;; 01:40a9 $e6 $01
    jr   NZ, .jr_01_40af                               ;; 01:40ab $20 $02
    set  4, E                                          ;; 01:40ad $cb $e3
.jr_01_40af:
    ld   D, $00                                        ;; 01:40af $16 $00
    ld   HL, data_01_5c99_PasswordKeyGrid                              ;; 01:40b1 $21 $99 $5c
    add  HL, DE                                        ;; 01:40b4 $19
    ld   C, [HL]                                       ;; 01:40b5 $4e
    call call_01_4f1b_Password_GetCellUnderCursor                                  ;; 01:40b6 $cd $1b $4f
    cp   A, PASSWORD_KEY_EXIT                          ;; 01:40b9 $fe $49
    jp   Z, .jp_01_421e                                ;; 01:40bb $ca $1e $42
    cp   A, PASSWORD_KEY_GO                            ;; 01:40be $fe $4a
    jr   Z, .jr_01_40cd                                ;; 01:40c0 $28 $0b
    ld   A, C                                          ;; 01:40c2 $79
    cp   A, PASSWORD_KEY_BLANK                         ;; 01:40c3 $fe $20
    jr   Z, .jr_01_405c_MenuUpdate                                ;; 01:40c5 $28 $95
    ld   [HL], C                                       ;; 01:40c7 $71
    call call_01_4ecf_Password_RefreshCellGfx                                  ;; 01:40c8 $cd $cf $4e
    jr   .jp_01_4132                                   ;; 01:40cb $18 $65
.jr_01_40cd:
    ld   A, MENU_RESULT_PASSWORD_GO                    ;; 01:40cd $3e $30
    ret                                                ;; 01:40cf $c9
.jr_01_40d0:
    ld   A, [wD68D_Menu_OptionCount]                                    ;; 01:40d0 $fa $8d $d6
    and  A, A                                          ;; 01:40d3 $a7
    jp   Z, .jr_01_405c_MenuUpdate                                ;; 01:40d4 $ca $5c $40
    call call_00_10fb_CheckInputRight                                  ;; 01:40d7 $cd $fb $10
    jr   Z, .jr_01_40f2                                ;; 01:40da $28 $16
    ld   HL, wD6DF_MenuSelectedColumn                                     ;; 01:40dc $21 $df $d6
    inc  [HL]                                          ;; 01:40df $34
    ld   A, [HL]                                       ;; 01:40e0 $7e
    sub  A, PASSWORD_GRID_COLUMNS                      ;; 01:40e1 $d6 $06
    jr   NZ, .jp_01_4132                               ;; 01:40e3 $20 $4d
    ld   [HL], A                                       ;; 01:40e5 $77 ; wrapped past the last column
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:40e6 $21 $e0 $d6
    inc  [HL]                                          ;; 01:40e9 $34
    ld   A, [HL]                                       ;; 01:40ea $7e
    sub  A, PASSWORD_GRID_ROWS                         ;; 01:40eb $d6 $05
    jr   NZ, .jp_01_4132                               ;; 01:40ed $20 $43
    ld   [HL], A                                       ;; 01:40ef $77
    jr   .jp_01_4132                                   ;; 01:40f0 $18 $40
.jr_01_40f2:
    call call_00_10f5_CheckInputLeft                                  ;; 01:40f2 $cd $f5 $10
    jr   Z, .jr_01_410d                                ;; 01:40f5 $28 $16
    ld   HL, wD6DF_MenuSelectedColumn                                     ;; 01:40f7 $21 $df $d6
    dec  [HL]                                          ;; 01:40fa $35
    bit  7, [HL]                                       ;; 01:40fb $cb $7e
    jr   Z, .jp_01_4132                                ;; 01:40fd $28 $33
    ld   [HL], PASSWORD_GRID_COLUMNS - 1               ;; 01:40ff $36 $05
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4101 $21 $e0 $d6
    dec  [HL]                                          ;; 01:4104 $35
    bit  7, [HL]                                       ;; 01:4105 $cb $7e
    jr   Z, .jp_01_4132                                ;; 01:4107 $28 $29
    ld   [HL], PASSWORD_GRID_ROWS - 1                  ;; 01:4109 $36 $04
    jr   .jp_01_4132                                   ;; 01:410b $18 $25
.jr_01_410d:
    call call_00_1107_CheckInputDown                                  ;; 01:410d $cd $07 $11
    jr   Z, .jr_01_411f                                ;; 01:4110 $28 $0d
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4112 $21 $e0 $d6
    inc  [HL]                                          ;; 01:4115 $34
    ld   A, [HL]                                       ;; 01:4116 $7e
    cp   A, PASSWORD_GRID_ROWS                         ;; 01:4117 $fe $05
    jr   C, .jp_01_4132                                ;; 01:4119 $38 $17
    dec  [HL]                                          ;; 01:411b $35
    jp   .jp_01_403a                                   ;; 01:411c $c3 $3a $40
.jr_01_411f:
    call call_00_1101_CheckInputUp                                  ;; 01:411f $cd $01 $11
    jp   Z, .jr_01_405c_MenuUpdate                                ;; 01:4122 $ca $5c $40
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4125 $21 $e0 $d6
    dec  [HL]                                          ;; 01:4128 $35
    bit  7, [HL]                                       ;; 01:4129 $cb $7e
    jp   Z, .jp_01_4132                                ;; 01:412b $ca $32 $41
    inc  [HL]                                          ;; 01:412e $34
    jp   .jp_01_403a                                   ;; 01:412f $c3 $3a $40
.jp_01_4132:
    ld   A, $00                                        ;; 01:4132 $3e $00
    call call_00_113e_PlaySFX                                  ;; 01:4134 $cd $3e $11
    jp   .jp_01_403a                                   ;; 01:4137 $c3 $3a $40
.jp_01_413a:
    ld   A, [wD68D_Menu_OptionCount]                                    ;; 01:413a $fa $8d $d6
    and  A, A                                          ;; 01:413d $a7
    jr   Z, .jr_01_416a                                ;; 01:413e $28 $2a
    call call_00_1101_CheckInputUp                                  ;; 01:4140 $cd $01 $11
    jr   Z, .jr_01_414f                                ;; 01:4143 $28 $0a
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4145 $21 $e0 $d6
    ld   A, [HL]                                       ;; 01:4148 $7e
    and  A, A                                          ;; 01:4149 $a7
    jr   Z, .jr_01_416a                                ;; 01:414a $28 $1e
    dec  [HL]                                          ;; 01:414c $35
    jr   .jr_01_415f                                   ;; 01:414d $18 $10
.jr_01_414f:
    call call_00_1107_CheckInputDown                                  ;; 01:414f $cd $07 $11
    jr   Z, .jr_01_416a                                ;; 01:4152 $28 $16
    ld   A, [wD68D_Menu_OptionCount]                                    ;; 01:4154 $fa $8d $d6
    dec  A                                             ;; 01:4157 $3d
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:4158 $21 $e0 $d6
    cp   A, [HL]                                       ;; 01:415b $be
    jr   Z, .jr_01_416a                                ;; 01:415c $28 $0c
    inc  [HL]                                          ;; 01:415e $34
.jr_01_415f:
    ld   A, $00                                        ;; 01:415f $3e $00
    call call_00_113e_PlaySFX                                  ;; 01:4161 $cd $3e $11
    call call_01_43e6_Menu_OnSelectionChanged                                  ;; 01:4164 $cd $e6 $43
    jp   .jp_01_403a                                   ;; 01:4167 $c3 $3a $40
.jr_01_416a:
    ; the totals screens use left/right to page through the 30 levels, skipping
    ; any page marked hidden in call_01_4265_Menu_IsTotalsPageVisible
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:416a $fa $8c $d6
    and  A, MENU_FLAG_TOTALS_PAGING                    ;; 01:416d $e6 $01
    jr   Z, .jr_01_41b5                                ;; 01:416f $28 $44
.jr_01_4171:
    call call_00_10fb_CheckInputRight                                  ;; 01:4171 $cd $fb $10
    jr   Z, .jr_01_4187                                ;; 01:4174 $28 $11
    ld   HL, wD625_TotalsMenuPage                                     ;; 01:4176 $21 $25 $d6
    inc  [HL]                                          ;; 01:4179 $34
    ld   A, [HL]                                       ;; 01:417a $7e
    sub  A, LEVEL_COUNT                                ;; 01:417b $d6 $1e
    jr   NZ, .jr_01_4180                               ;; 01:417d $20 $01
    ld   [HL], A                                       ;; 01:417f $77
.jr_01_4180:
    call call_01_4265_Menu_IsTotalsPageVisible                                  ;; 01:4180 $cd $65 $42
    jr   Z, .jr_01_4171                                ;; 01:4183 $28 $ec
    jr   .jr_01_419b                                   ;; 01:4185 $18 $14
.jr_01_4187:
    call call_00_10f5_CheckInputLeft                                  ;; 01:4187 $cd $f5 $10
    jr   Z, .jr_01_41b5                                ;; 01:418a $28 $29
    ld   HL, wD625_TotalsMenuPage                                     ;; 01:418c $21 $25 $d6
    dec  [HL]                                          ;; 01:418f $35
    bit  7, [HL]                                       ;; 01:4190 $cb $7e
    jr   Z, .jr_01_4196                                ;; 01:4192 $28 $02
    ld   [HL], LEVEL_COUNT - 1                          ;; 01:4194 $36 $1d
.jr_01_4196:
    call call_01_4265_Menu_IsTotalsPageVisible                                  ;; 01:4196 $cd $65 $42
    jr   Z, .jr_01_4187                                ;; 01:4199 $28 $ec
.jr_01_419b:
    ld   A, [wD6DA_Menu_TotalsSpriteGroup]                                    ;; 01:419b $fa $da $d6
    call call_01_4d3b_Menu_EraseSpriteGroup                                  ;; 01:419e $cd $3b $4d
    ld   HL, data_01_57a0_MenuScript_TotalsPageRefresh                              ;; 01:41a1 $21 $a0 $57
    call call_01_44cf_MenuScript_RunFrom                                  ;; 01:41a4 $cd $cf $44
    ld   HL, data_00_0db6_GfxStreamScript_MenuSprites                                      ;; 01:41a7 $21 $b6 $0d
    call call_01_4d0a_Menu_StartGfxStream                                  ;; 01:41aa $cd $0a $4d
    ld   A, $01                                        ;; 01:41ad $3e $01
    call call_00_113e_PlaySFX                                  ;; 01:41af $cd $3e $11
    jp   .jp_01_403a                                   ;; 01:41b2 $c3 $3a $40
.jr_01_41b5:
    ; B confirms the highlighted option; A, SELECT and START all back out,
    ; each gated by its own flag. MENU_FLAG_NO_CANCEL short-circuits the lot
    call call_00_1129_CheckInputB                                  ;; 01:41b5 $cd $29 $11
    jr   NZ, .jr_01_41f1                               ;; 01:41b8 $20 $37
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:41ba $fa $8c $d6
    and  A, MENU_FLAG_NO_CANCEL                        ;; 01:41bd $e6 $40
    jp   NZ, .jr_01_405c_MenuUpdate                               ;; 01:41bf $c2 $5c $40
    call call_00_1123_CheckInputA                                  ;; 01:41c2 $cd $23 $11
    jr   NZ, .jp_01_421e                               ;; 01:41c5 $20 $57
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:41c7 $fa $8c $d6
    and  A, MENU_FLAG_SELECT_DISMISSES                 ;; 01:41ca $e6 $08
    call NZ, call_00_1118_CheckInputSelect                              ;; 01:41cc $c4 $18 $11
    jr   NZ, .jp_01_421e                               ;; 01:41cf $20 $4d
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:41d1 $fa $8c $d6
    and  A, MENU_FLAG_START_DISMISSES                  ;; 01:41d4 $e6 $10
    call NZ, call_00_110d_CheckInputStart                              ;; 01:41d6 $c4 $0d $11
    jr   NZ, .jp_01_421e                               ;; 01:41d9 $20 $43
    ; START on a totals screen opens the pause menu over the top of it, and
    ; remembers this screen so that closing the pause menu comes back here
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:41db $fa $8c $d6
    and  A, MENU_FLAG_START_OPENS_PAUSE                ;; 01:41de $e6 $20
    call NZ, call_00_110d_CheckInputStart                              ;; 01:41e0 $c4 $0d $11
    jp   Z, .jr_01_405c_MenuUpdate                                ;; 01:41e3 $ca $5c $40
    ld   A, [wD6DE_MenuType]                                    ;; 01:41e6 $fa $de $d6
    ld   [wD6DD_Menu_ReturnToType], A                                    ;; 01:41e9 $ea $dd $d6
    ld   A, MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION        ;; 01:41ec $3e $00
    jp   .jp_01_4005                                   ;; 01:41ee $c3 $05 $40
.jr_01_41f1:
    ; B was pressed. Look up what the highlighted row means. Codes that open
    ; another menu are handled here; the rest are returned to the caller in A
    call call_00_10eb_WaitUntilNoInputPressed                                  ;; 01:41f1 $cd $eb $10
    ld   A, [wD68D_Menu_OptionCount]                                    ;; 01:41f4 $fa $8d $d6
    and  A, A                                          ;; 01:41f7 $a7
    jr   Z, .jp_01_421e                                ;; 01:41f8 $28 $24 ; nothing selectable
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:41fa $21 $e0 $d6
    ld   L, [HL]                                       ;; 01:41fd $6e
    ld   H, $00                                        ;; 01:41fe $26 $00
    ld   DE, wD6C5_Menu_OptionActions                                     ;; 01:4200 $11 $c5 $d6
    add  HL, DE                                        ;; 01:4203 $19
    ld   A, [HL]                                       ;; 01:4204 $7e
    ; codes that open another menu are handled below; the rest go back to whoever
    ; called MenuLoad, which is where they get their meaning
    cp   A, MENU_OPTION_START_GAME                     ;; 01:4205 $fe $10
    ret  Z                                             ;; 01:4207 $c8
    cp   A, MENU_OPTION_AUDIO_OPTIONS                  ;; 01:4208 $fe $90
    jr   Z, .jr_01_4229                                ;; 01:420a $28 $1d
    cp   A, MENU_OPTION_ENTER_PASSWORD                 ;; 01:420c $fe $30
    jr   Z, .jr_01_422f                                ;; 01:420e $28 $1f
    cp   A, MENU_OPTION_VIEW_PASSWORD                  ;; 01:4210 $fe $40
    jr   Z, .jr_01_424f                                ;; 01:4212 $28 $3b
    cp   A, MENU_OPTION_QUIT                           ;; 01:4214 $fe $50
    jr   Z, .jr_01_4257                                ;; 01:4216 $28 $3f
    cp   A, MENU_OPTION_CONFIRM_QUIT                         ;; 01:4218 $fe $60
    ret  Z                                             ;; 01:421a $c8
    cp   A, MENU_OPTION_RESUME_PLAY                         ;; 01:421b $fe $80
    ret  Z                                             ;; 01:421d $c8
.jp_01_421e:
    ; leaving the menu. If another screen is waiting underneath, reload it
    ; instead of returning
    call call_00_10eb_WaitUntilNoInputPressed                                  ;; 01:421e $cd $eb $10
    ld   A, [wD6DD_Menu_ReturnToType]                                    ;; 01:4221 $fa $dd $d6
    and  A, A                                          ;; 01:4224 $a7
    jp   NZ, call_01_4000_MenuLoad                              ;; 01:4225 $c2 $00 $40
    ret                                                ;; 01:4228 $c9
.jr_01_4229:
    call call_01_4291_MenuLoad_AudioOptions                                  ;; 01:4229 $cd $91 $42
.jr_01_422c:
    ld   A, MENU_RESULT_DISMISSED                      ;; 01:422c $3e $00
    ret                                                ;; 01:422e $c9
.jr_01_422f:
    ; Password entry. The keyboard and the "wrong password" screen alternate
    ; until either the player types something valid or backs out entirely
    call call_01_4f87_Password_ClearEntryGrid                                  ;; 01:422f $cd $87 $4f
    ld   A, MENU_TYPE_ENTER_PASSWORD                                        ;; 01:4232 $3e $0f
    call call_01_4000_MenuLoad                                  ;; 01:4234 $cd $00 $40
    cp   A, MENU_RESULT_DISMISSED                      ;; 01:4237 $fe $00
    jr   Z, .jr_01_422c                                ;; 01:4239 $28 $f1
.jr_01_423b:
    call call_01_5271_Password_DecodeAndApply                                  ;; 01:423b $cd $71 $52
    cp   A, MENU_RESULT_PASSWORD_GO                    ;; 01:423e $fe $30 ; accepted
    ret  Z                                             ;; 01:4240 $c8
    call call_01_4f87_Password_ClearEntryGrid                                  ;; 01:4241 $cd $87 $4f
    ld   A, MENU_TYPE_ENTERED_INVALID_PASSWORD                                        ;; 01:4244 $3e $15
    call call_01_4000_MenuLoad                                  ;; 01:4246 $cd $00 $40
    cp   A, MENU_RESULT_DISMISSED                      ;; 01:4249 $fe $00
    jr   Z, .jr_01_422c                                ;; 01:424b $28 $df
    jr   .jr_01_423b                                   ;; 01:424d $18 $ec ; let them try again
.jr_01_424f:
    call call_01_4fa5_Password_Encode                                  ;; 01:424f $cd $a5 $4f
    ld   A, MENU_TYPE_VIEW_PASSWORD                                        ;; 01:4252 $3e $06
    jp   call_01_4000_MenuLoad                                  ;; 01:4254 $c3 $00 $40
.jr_01_4257:
    ; quitting means something different depending on where you are: from the
    ; hub there is nothing to back out to, so it offers to end the game instead
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4257 $fa $24 $d6
    and  A, A                                          ;; 01:425a $a7
    ld   A, MENU_TYPE_EXIT_GAME                        ;; 01:425b $3e $01
    jp   Z, .jp_01_4005                                ;; 01:425d $ca $05 $40
    ld   A, MENU_TYPE_EXIT_TO_MAP                      ;; 01:4260 $3e $03
    jp   .jp_01_4005                                   ;; 01:4262 $c3 $05 $40

call_01_4265_Menu_IsTotalsPageVisible:
; The totals menu pages through the levels with left/right, but ten of the thirty
; level ids are unused slots with no artwork or name behind them. Returns Z when
; the page in wD625_TotalsMenuPage should be skipped over.
;
; The caller keeps stepping in the same direction until this returns NZ, so a run
; of hidden pages is crossed in one press
    ld   HL, wD625_TotalsMenuPage                                     ;; 01:4265 $21 $25 $d6
    ld   L, [HL]                                       ;; 01:4268 $6e
    ld   H, $00                                        ;; 01:4269 $26 $00
    ld   DE, .data_01_4272_TotalsPageVisible                             ;; 01:426b $11 $72 $42
    add  HL, DE                                        ;; 01:426e $19
    ld   A, [HL]                                       ;; 01:426f $7e
    and  A, A                                          ;; 01:4270 $a7
    ret                                                ;; 01:4271 $c9
.data_01_4272_TotalsPageVisible:
; One byte per level id, nonzero = this page can be shown. The zeros are exactly
; the MAP_UNUSED_* slots, so this table is really "does this level id exist".
; There are 31 entries but paging wraps at LEVEL_COUNT, so the last is never read
    db   $01, $01, $01, $01, $01, $01, $00, $01        ; $00-$07, $06 unused
    db   $01, $01, $01, $01, $00, $01, $01, $00        ; $08-$0F, $0C and $0F unused
    db   $01, $00, $00, $00, $00, $01, $01, $01        ; $10-$17, $11-$14 unused
    db   $01, $01, $01, $00, $00, $00, $01             ; $18-$1E, $1B-$1D unused

call_01_4291_MenuLoad_AudioOptions:
; Opens MENU_TYPE_AUDIO_OPTIONS_UNUSED. Reachable only through
; MENU_OPTION_AUDIO_OPTIONS, which no shipped menu script ever assigns to a row, so
; this and the screen it opens are dead code kept from an earlier build
    ld   A, MENU_TYPE_AUDIO_OPTIONS_UNUSED                ;; 01:4291 $3e $11
    call call_01_4000_MenuLoad                         ;; 01:4293 $cd $00 $40
    ret                                                ;; 01:4296 $c9

call_01_4297_MenuLoad_MissionSelect:
; Shows the mission select screen for the level being entered and leaves the chosen
; row in wD627_CurrentMission.
;
; The three MENU_TYPE_MISSION_SELECT_* screens differ only in how many rows they
; have, so instead of branching this counts how many of the level's
; MISSION_SLOTS_PER_LEVEL mission strings are non-empty - bit 7 set on the first
; byte means empty - and adds that count to the menu type of the one-row screen
    xor  A, A                                          ;; 01:4297 $af
    ld   [wD626_MissionSelect_OptionCount], A                                    ;; 01:4298 $ea $26 $d6
.jr_01_429b:
    push AF                                            ;; 01:429b $f5
    call call_00_2e5f_MapData_GetMissionText                                  ;; 01:429c $cd $5f $2e
    bit  7, [HL]                                       ;; 01:429f $cb $7e
    jr   NZ, .jr_01_42a7                               ;; 01:42a1 $20 $04
    ld   HL, wD626_MissionSelect_OptionCount                                     ;; 01:42a3 $21 $26 $d6
    inc  [HL]                                          ;; 01:42a6 $34
.jr_01_42a7:
    pop  AF                                            ;; 01:42a7 $f1
    inc  A                                             ;; 01:42a8 $3c
    cp   A, MISSION_SLOTS_PER_LEVEL                    ;; 01:42a9 $fe $03
    jr   NZ, .jr_01_429b                               ;; 01:42ab $20 $ee
    ; the three mission-select menu types differ only in how many rows they have,
    ; so the count picks the type arithmetically
    ld   A, MENU_TYPE_MISSION_SELECT_1_OPTION - 1      ;; 01:42ad $3e $08
    ld   HL, wD626_MissionSelect_OptionCount           ;; 01:42af $21 $26 $d6
    add  A, [HL]                                       ;; 01:42b2 $86
    call call_01_4000_MenuLoad                                  ;; 01:42b3 $cd $00 $40
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:42b6 $fa $e0 $d6
    ld   [wD627_CurrentMission], A                                    ;; 01:42b9 $ea $27 $d6
    ret                                                ;; 01:42bc $c9

call_01_42bd_HandleTVWarp:
; Runs everything that happens when WARP_FLAG_ENTERED_TV is set - which covers both
; halves of a TV transition, entering a level from the hub and finishing one at its
; exit TV. In the second case: award the remote, show whatever screen that earns,
; then put the player back in the hub.
;
; Three ways through:
;   - in the hub (level 0) there is nothing to award; just set the respawn point
;   - in a bonus level, either the timer ran out (show MENU_TYPE_TIME_UP) or the
;     quota was met, in which case the bonus bit was already granted elsewhere
;   - in a normal level, OR the remote bit for the exit TV the player used into
;     wD629_RemoteProgressFlags, then show the congratulations screen - or the
;     credits, if this was Channel Z
;
; All three converge on building a fresh password and showing the totals, and every
; path leaves the player in the Media Dimension with PLAYER_ACTION_EXIT_TV.
;
; Which bit gets awarded comes from .data_01_4337_ExitTVRemoteBits, indexed by
; (remote progress id * 3) + wD647_ExitTVButtonIndex - the same three-exits-per-level
; layout every normal level uses
    ld   A, [wD621_WarpFlags]                                    ;; 01:42bd $fa $21 $d6
    and  A, $ff ^ WARP_FLAG_ENTERED_TV                 ;; 01:42c0 $e6 $fb
    ld   [wD621_WarpFlags], A                                    ;; 01:42c2 $ea $21 $d6
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:42c5 $fa $24 $d6
    and  A, A                                          ;; 01:42c8 $a7
    jr   Z, .jr_01_432b                                ;; 01:42c9 $28 $60
    ld   A, [wD623_CollectibleMode]                                    ;; 01:42cb $fa $23 $d6
    and  A, A                                          ;; 01:42ce $a7
    jr   Z, .jr_01_42e7                                ;; 01:42cf $28 $16
    ld   A, [wD621_WarpFlags]                                    ;; 01:42d1 $fa $21 $d6
    and  A, WARP_FLAG_TIME_UP                          ;; 01:42d4 $e6 $10
    jr   Z, .jr_01_4319                                ;; 01:42d6 $28 $41
    ld   A, [wD621_WarpFlags]                                    ;; 01:42d8 $fa $21 $d6
    and  A, $ff ^ WARP_FLAG_TIME_UP                    ;; 01:42db $e6 $ef
    ld   [wD621_WarpFlags], A                                    ;; 01:42dd $ea $21 $d6
    ld   A, MENU_TYPE_TIME_UP                                        ;; 01:42e0 $3e $1b
    call call_01_4000_MenuLoad                                  ;; 01:42e2 $cd $00 $40
    jr   .jr_01_4319                                   ;; 01:42e5 $18 $32
.jr_01_42e7:
    call call_00_2e43_MapData_GetRemoteProgressId                                  ;; 01:42e7 $cd $43 $2e
    ld   E, A                                          ;; 01:42ea $5f
    add  A, A                                          ;; 01:42eb $87
    add  A, E                                          ;; 01:42ec $83
    ld   E, A                                          ;; 01:42ed $5f
    ld   A, [wD647_ExitTVButtonIndex]                                    ;; 01:42ee $fa $47 $d6
    add  A, E                                          ;; 01:42f1 $83
    ld   E, A                                          ;; 01:42f2 $5f
    ld   HL, .data_01_4337_ExitTVRemoteBits                             ;; 01:42f3 $21 $37 $43
    add  HL, DE                                        ;; 01:42f6 $19
    ld   C, [HL]                                       ;; 01:42f7 $4e
    ld   HL, wD624_CurrentLevelId                                     ;; 01:42f8 $21 $24 $d6
    ld   L, [HL]                                       ;; 01:42fb $6e
    ld   H, $00                                        ;; 01:42fc $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 01:42fe $11 $29 $d6
    add  HL, DE                                        ;; 01:4301 $19
    ld   A, [wD64C_CurrentLevel_HiddenRemoteFlags]                                    ;; 01:4302 $fa $4c $d6
    or   A, C                                          ;; 01:4305 $b1
    or   A, [HL]                                       ;; 01:4306 $b6
    ld   [HL], A                                       ;; 01:4307 $77
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4308 $fa $24 $d6
    cp   A, MAP_BOSS_TV_CHANNEL_Z                                        ;; 01:430b $fe $1e
    jr   NZ, .jr_01_4314                               ;; 01:430d $20 $05
    call call_01_43c7_MenuLoad_Credits                                  ;; 01:430f $cd $c7 $43
    jr   .jr_01_4319                                   ;; 01:4312 $18 $05
.jr_01_4314:
    ld   A, MENU_TYPE_CONGRATULATIONS                                        ;; 01:4314 $3e $0e
    call call_01_4000_MenuLoad                                  ;; 01:4316 $cd $00 $40
.jr_01_4319:
    call call_01_4349_Password_BuildPayload                                  ;; 01:4319 $cd $49 $43
    ld   A, MENU_TYPE_VIEW_TOTALS                                        ;; 01:431c $3e $05
    call call_01_4000_MenuLoad                                  ;; 01:431e $cd $00 $40
    xor  A, A                                          ;; 01:4321 $af
    ld   [wD624_CurrentLevelId], A                                    ;; 01:4322 $ea $24 $d6
    ld   A, PLAYER_ACTION_EXIT_TV                                        ;; 01:4325 $3e $14
    ld   [wD744_Player_SpawnAction], A                                    ;; 01:4327 $ea $44 $d7
    ret                                                ;; 01:432a $c9
.jr_01_432b:
    ld   A, [wD628_MediaDimensionRespawnPoint]                                    ;; 01:432b $fa $28 $d6
    ld   [wD624_CurrentLevelId], A                                    ;; 01:432e $ea $24 $d6
    ld   A, PLAYER_ACTION_SPAWN                                        ;; 01:4331 $3e $00
    ld   [wD744_Player_SpawnAction], A                                    ;; 01:4333 $ea $44 $d7
    ret                                                ;; 01:4336 $c9
.data_01_4337_ExitTVRemoteBits:
; Which wD629_RemoteProgressFlags bit each exit TV awards, as three entries per
; remote progress id - one for each of the three exit TVs a level can have.
; The bits are just REMOTE_MISSION_MASK counted off in order, so exit TV n grants
; mission remote n; a level with fewer objectives has $00 in the slots past its
; last one, and those exits award nothing. Progress id 5 is the bonus-level row,
; where the single exit grants REMOTE_BONUS_MASK instead
    db   $01, $02, $04                                 ; progress id 0 - three missions
    db   $01, $02, $00                                 ; progress id 1 - two
    db   $01, $00, $00                                 ; progress id 2 - one
    db   $01, $02, $00                                 ; progress id 3 - two
    db   $01, $00, $00                                 ; progress id 4 - one
    db   $20, $00, $00                                 ; progress id 5 - the gold remote

call_01_4349_Password_BuildPayload:
; Packs the whole save state into wD652_Password_EncodeBuffer, ready for
; call_01_4fa5_Password_Encode to spell out as letters. Nothing to do with loading a
; menu, despite where it is called from - bank00 runs it when a new game starts and
; call_01_42bd_HandleTVWarp runs it on the way out of every level, so the password
; the totals screen shows is always current.
;
; It walks every level id from 0 to MAP_BOSS_TV_CHANNEL_Z, and for each one takes
; a mask from .data_01_43b6_LevelPayloadMasks - which bits of that level's wD629_RemoteProgressFlags
; are worth saving - then shifts mask and flags together, emitting one payload bit
; per set mask bit. So levels with fewer objectives cost fewer bits, which is how
; 30 levels fit in 64.
;
; Lives and a checksum are appended, the checksum being a plain 8-bit sum of the
; 9 bytes before it. Note wD624_CurrentLevelId is borrowed as the loop counter and
; restored afterwards
    ld   HL, wD652_Password_EncodeBuffer                                     ;; 01:4349 $21 $52 $d6
    ld   B, PASSWORD_PAYLOAD_BYTES                     ;; 01:434c $06 $0a
    xor  A, A                                          ;; 01:434e $af
.jr_01_434f:
    ld   [HL+], A                                      ;; 01:434f $22
    dec  B                                             ;; 01:4350 $05
    jr   NZ, .jr_01_434f                               ;; 01:4351 $20 $fc
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4353 $fa $24 $d6
    push AF                                            ;; 01:4356 $f5
    xor  A, A                                          ;; 01:4357 $af
    ld   [wD624_CurrentLevelId], A                                    ;; 01:4358 $ea $24 $d6
    ld   HL, wD652_Password_EncodeBuffer                                     ;; 01:435b $21 $52 $d6
    ld   C, $80                                        ;; 01:435e $0e $80
.jr_01_4360:
    push HL                                            ;; 01:4360 $e5
    call call_00_2e43_MapData_GetRemoteProgressId                                  ;; 01:4361 $cd $43 $2e
    ld   E, A                                          ;; 01:4364 $5f
    ld   D, $00                                        ;; 01:4365 $16 $00
    ld   HL, .data_01_43b6_LevelPayloadMasks                             ;; 01:4367 $21 $b6 $43
    add  HL, DE                                        ;; 01:436a $19
    ld   A, [HL]                                       ;; 01:436b $7e
    ld   HL, wD624_CurrentLevelId                                     ;; 01:436c $21 $24 $d6
    ld   L, [HL]                                       ;; 01:436f $6e
    ld   H, $00                                        ;; 01:4370 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 01:4372 $11 $29 $d6
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
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4392 $fa $24 $d6
    inc  A                                             ;; 01:4395 $3c
    ld   [wD624_CurrentLevelId], A                                    ;; 01:4396 $ea $24 $d6
    cp   A, LEVEL_COUNT                                ;; 01:4399 $fe $1e
    jr   NZ, .jr_01_4360                               ;; 01:439b $20 $c3
    pop  AF                                            ;; 01:439d $f1
    ld   [wD624_CurrentLevelId], A                                    ;; 01:439e $ea $24 $d6
    ld   A, [wD73D_LivesRemaining]                                    ;; 01:43a1 $fa $3d $d7
    ld   [wD65A_Password_EncodeLives], A                                    ;; 01:43a4 $ea $5a $d6
    ld   HL, wD652_Password_EncodeBuffer                                     ;; 01:43a7 $21 $52 $d6
    ld   B, PASSWORD_CHECKSUM_BYTES                    ;; 01:43aa $06 $09
    xor  A, A                                          ;; 01:43ac $af
.jr_01_43ad:
    add  A, [HL]                                       ;; 01:43ad $86
    inc  HL                                            ;; 01:43ae $23
    dec  B                                             ;; 01:43af $05
    jr   NZ, .jr_01_43ad                               ;; 01:43b0 $20 $fb
    ld   [wD65B_Password_EncodeChecksum], A                                    ;; 01:43b2 $ea $5b $d6
    ret                                                ;; 01:43b5 $c9
.data_01_43b6_LevelPayloadMasks:
; One byte per remote progress id: which bits of that level's
; wD629_RemoteProgressFlags are worth saving in a password. A level with three
; missions plus both hidden remotes costs five bits; a bonus level costs one.
; That is how thirty levels fit into a 64-bit payload.
; call_01_5271_Password_DecodeAndApply keeps its own identical copy at
; .data_01_531d_LevelPayloadMasks
    db   $1f                                           ; id 0 - 3 missions + silver + gold
    db   $1b                                           ; id 1 - 2 missions + silver + gold
    db   $19                                           ; id 2 - 1 mission  + silver + gold
    db   $03                                           ; id 3 - 2 missions
    db   $01                                           ; id 4 - 1 mission
    db   $20                                           ; id 5 - bonus level, gold only
    db   $00                                           ; id 6 - the stats page, nothing to save

call_01_43bd_MenuLoad_GameOver:
; The GAME OVER sequence: the words on their own (which times out by itself, since
; MENU_TYPE_GAME_OVER has no flags at all), then the totals screen
    ld a, MENU_TYPE_GAME_OVER
    call call_01_4000_MenuLoad
    ld a, MENU_TYPE_GAME_OVER_TOTALS
    jp call_01_4000_MenuLoad                                        ;; 01:43c6 ?

call_01_43c7_MenuLoad_Credits:
; The ending: start the Media Dimension theme, then walk the five credit screens in
; order. Each one blocks until the player presses B, since they all carry
; MENU_FLAG_NO_CANCEL and there is nothing else to press
    ld   A, MUSIC_MEDIA_DIMENSION                                        ;; 01:43c7 $3e $07
    call call_00_120c_SetupMusic                                  ;; 01:43c9 $cd $0c $12
    ld   A, MENU_TYPE_CREDITS_GREAT_JOB                                        ;; 01:43cc $3e $12
    call call_01_4000_MenuLoad                                  ;; 01:43ce $cd $00 $40
    ld   A, MENU_TYPE_CREDITS_1                                        ;; 01:43d1 $3e $17
    call call_01_4000_MenuLoad                                  ;; 01:43d3 $cd $00 $40
    ld   A, MENU_TYPE_CREDITS_2                                        ;; 01:43d6 $3e $18
    call call_01_4000_MenuLoad                                  ;; 01:43d8 $cd $00 $40
    ld   A, MENU_TYPE_CREDITS_3                                        ;; 01:43db $3e $19
    call call_01_4000_MenuLoad                                  ;; 01:43dd $cd $00 $40
    ld   A, MENU_TYPE_CREDITS_4                                        ;; 01:43e0 $3e $1a
    call call_01_4000_MenuLoad                                  ;; 01:43e2 $cd $00 $40
    ret                                                ;; 01:43e5 $c9

call_01_43e6_Menu_OnSelectionChanged:
; Called whenever the highlighted row changes. Jumps through
; .data_01_43f5_SelectionChangedHandlers, one entry per menu type, so what "the
; selection moved" means is per screen:
;
;   .jp_01_442d  set the wobble window (wD6EB/wD6EC) to the 8 scanlines of the
;                selected row, counting down from line $4E - this is what makes the
;                highlighted option ripple on the pause menus
;   .jp_01_4446  the same, from line $16, for the two totals screens
;   .jp_01_444c  no wobble; stream in a fresh set of tiles for the selected row
;   .jp_01_445d  the same for the audio options screen
;   .jp_01_446e  do nothing - most screens
;
; The two streaming entries reach into tables in bank00 whose names
; (data_00_0dd9_GfxStreamScriptTable_Rezopolis / _ChannelZ) look like level names but
; are really the title-options and audio-options highlight graphics
    ld   HL, wD6DE_MenuType                                     ;; 01:43e6 $21 $de $d6
    ld   L, [HL]                                       ;; 01:43e9 $6e
    ld   H, $00                                        ;; 01:43ea $26 $00
    add  HL, HL                                        ;; 01:43ec $29
    ld   DE, .data_01_43f5_SelectionChangedHandlers                             ;; 01:43ed $11 $f5 $43
    add  HL, DE                                        ;; 01:43f0 $19
    ld   A, [HL+]                                      ;; 01:43f1 $2a
    ld   H, [HL]                                       ;; 01:43f2 $66
    ld   L, A                                          ;; 01:43f3 $6f
    jp   HL                                            ;; 01:43f4 $e9
.data_01_43f5_SelectionChangedHandlers:
; One handler per MENU_TYPE_*, so "the highlighted row moved" means whatever that
; screen needs it to mean. Most screens want nothing
    dw   .jp_01_442d                           ; $00 MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION
    dw   .jp_01_442d                           ; $01 MENU_TYPE_EXIT_GAME
    dw   .jp_01_442d                           ; $02 MENU_TYPE_PAUSED_IN_LEVEL
    dw   .jp_01_442d                           ; $03 MENU_TYPE_EXIT_TO_MAP
    dw   .jp_01_4446                           ; $04 MENU_TYPE_GAME_OVER_TOTALS
    dw   .jp_01_4446                           ; $05 MENU_TYPE_VIEW_TOTALS
    dw   .jp_01_446e                           ; $06 MENU_TYPE_VIEW_PASSWORD
    dw   .jp_01_444c                           ; $07 MENU_TYPE_TITLE_OPTIONS
    dw   .jp_01_446e                           ; $08 MENU_TYPE_ENTERING_LEVEL_NAME
    dw   .jp_01_446e                           ; $09 MENU_TYPE_MISSION_SELECT_1_OPTION
    dw   .jp_01_446e                           ; $0a MENU_TYPE_MISSION_SELECT_2_OPTIONS
    dw   .jp_01_446e                           ; $0b MENU_TYPE_MISSION_SELECT_3_OPTIONS
    dw   .jp_01_446e                           ; $0c MENU_TYPE_GAME_OVER
    dw   .jp_01_446e                           ; $0d MENU_TYPE_BLACK_SCREEN
    dw   .jp_01_446e                           ; $0e MENU_TYPE_CONGRATULATIONS
    dw   .jp_01_446e                           ; $0f MENU_TYPE_ENTER_PASSWORD
    dw   .jp_01_446e                           ; $10 MENU_TYPE_TITLE_SCREEN
    dw   .jp_01_445d                           ; $11 MENU_TYPE_AUDIO_OPTIONS_UNUSED
    dw   .jp_01_446e                           ; $12 MENU_TYPE_CREDITS_GREAT_JOB
    dw   .jp_01_446e                           ; $13 MENU_TYPE_TITLE_CRAVE
    dw   .jp_01_446e                           ; $14 MENU_TYPE_TITLE_SPLASH
    dw   .jp_01_446e                           ; $15 MENU_TYPE_ENTERED_INVALID_PASSWORD
    dw   .jp_01_446e                           ; $16 MENU_TYPE_TITLE_DAVID
    dw   .jp_01_446e                           ; $17 MENU_TYPE_CREDITS_1
    dw   .jp_01_446e                           ; $18 MENU_TYPE_CREDITS_2
    dw   .jp_01_446e                           ; $19 MENU_TYPE_CREDITS_3
    dw   .jp_01_446e                           ; $1a MENU_TYPE_CREDITS_4
    dw   .jp_01_446e                           ; $1b MENU_TYPE_TIME_UP
.jp_01_442d:
    ld   C, MENU_WOBBLE_BASE_PAUSE                     ;; 01:442d $0e $4e
    ld   B, MENU_WOBBLE_ROW_HEIGHT                     ;; 01:442f $06 $08
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
    ld   HL, wD6EB_RasterWobble_StartLine                                     ;; 01:443d $21 $eb $d6
    ld   [HL], A                                       ;; 01:4440 $77
    ld   HL, wD6EC_RasterWobble_LineCount                                     ;; 01:4441 $21 $ec $d6
    ld   [HL], B                                       ;; 01:4444 $70
    ret                                                ;; 01:4445 $c9
.jp_01_4446:
    ld   C, MENU_WOBBLE_BASE_TOTALS                    ;; 01:4446 $0e $16
    ld   B, MENU_WOBBLE_ROW_HEIGHT                     ;; 01:4448 $06 $08
    jr   .jr_01_4431                                   ;; 01:444a $18 $e5
.jp_01_444c:
    ld   HL, wD6E0_MenuSelectedRow                                     ;; 01:444c $21 $e0 $d6
    ld   L, [HL]                                       ;; 01:444f $6e
    ld   H, $00                                        ;; 01:4450 $26 $00
    add  HL, HL                                        ;; 01:4452 $29
    ld   DE, data_00_0dd9_GfxStreamScriptTable_Rezopolis                                      ;; 01:4453 $11 $d9 $0d
    add  HL, DE                                        ;; 01:4456 $19
    ld   A, [HL+]                                      ;; 01:4457 $2a
    ld   H, [HL]                                       ;; 01:4458 $66
    ld   L, A                                          ;; 01:4459 $6f
    jp   call_01_4d0a_Menu_StartGfxStream                                  ;; 01:445a $c3 $0a $4d
.jp_01_445d:
    ld   hl,wD6E0_MenuSelectedRow
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,data_00_0e13_GfxStreamScriptTable_ChannelZ
    add  hl,de
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    jp   call_01_4d0a_Menu_StartGfxStream
.jp_01_446e:
    ret                                                ;; 01:446e $c9

call_01_446f_LoadMenuGraphics:
; Builds a whole screen from the script at HL: fade out, wipe VRAM, run the script,
; follow any chained script it queued, then set the raster split up from
; data_01_5654_MenuTypeLcdcAndPalette and fade back in.
;
; The chain loop is what lets one screen be assembled from several scripts - the
; password keyboard's frame and its 29 cells are separate scripts, and the mission
; select screens share their furniture with each other the same way
    push HL                                            ;; 01:446f $e5
    ld   A, $ff                                        ;; 01:4470 $3e $ff
    ld   [wD6C1_Menu_CursorSpriteId], A                                    ;; 01:4472 $ea $c1 $d6
    xor  A, A                                          ;; 01:4475 $af
    ld   [wD6D8_Menu_HideSpritesDelay], A                                    ;; 01:4476 $ea $d8 $d6
    call call_00_0f38_FadeOutAndClearVRAM                                  ;; 01:4479 $cd $38 $0f
    call call_00_0ede_SelectWramBank1                                  ;; 01:447c $cd $de $0e
    pop  HL                                            ;; 01:447f $e1
.jr_01_4480:
    ld   A, L                                          ;; 01:4480 $7d
    ld   [wD6B3_MenuScript_PtrLo], A                                    ;; 01:4481 $ea $b3 $d6
    ld   A, H                                          ;; 01:4484 $7c
    ld   [wD6B4_MenuScript_PtrHi], A                                    ;; 01:4485 $ea $b4 $d6
    ld   A, MENU_CHAINED_NONE                          ;; 01:4488 $3e $ff
    ld   [wD6D7_Menu_ChainedScriptId], A                                    ;; 01:448a $ea $d7 $d6
    call call_01_44d7_MenuScript_RunToEnd                                  ;; 01:448d $cd $d7 $44
    ld   A, [wD6D7_Menu_ChainedScriptId]                                    ;; 01:4490 $fa $d7 $d6
    cp   A, MENU_CHAINED_NONE                          ;; 01:4493 $fe $ff
    jr   Z, .jr_01_449f                                ;; 01:4495 $28 $08
    ld   DE, data_01_568c_ChainedScriptTable                              ;; 01:4497 $11 $8c $56
    call call_00_07b9_GetPointerFromTable                                  ;; 01:449a $cd $b9 $07
    jr   .jr_01_4480                                   ;; 01:449d $18 $e1
.jr_01_449f:
    ld   HL, wD6DE_MenuType                                     ;; 01:449f $21 $de $d6
    ld   L, [HL]                                       ;; 01:44a2 $6e
    ld   H, $00                                        ;; 01:44a3 $26 $00
    add  HL, HL                                        ;; 01:44a5 $29
    ld   DE, data_01_5654_MenuTypeLcdcAndPalette                              ;; 01:44a6 $11 $54 $56
    add  HL, DE                                        ;; 01:44a9 $19
    ld   A, [HL+]                                      ;; 01:44aa $2a
    ld   [wD6E1_RasterSplit_LCDCValue], A                                    ;; 01:44ab $ea $e1 $d6
    ld   C, [HL]                                       ;; 01:44ae $4e
    FARCALL call_0b_5537_BgPalette_LoadMonoOrGetSpriteParams
    ld   A, MENU_WOBBLE_OFF                            ;; 01:44ba $3e $ff
    ld   [wD6EB_RasterWobble_StartLine], A             ;; 01:44bc $ea $eb $d6 ; OnSelectionChanged turns it back on if the screen wants it
    call call_01_43e6_Menu_OnSelectionChanged                                  ;; 01:44bf $cd $e6 $43
    ld   A, $06                                        ;; 01:44c2 $3e $06
    call call_00_0bae_RequestLcdIsr                                  ;; 01:44c4 $cd $ae $0b
    ld   A, MENU_LCDC_WINDOW                           ;; 01:44c7 $3e $d7 ; LCDC for the bottom half of the split
    call call_00_0f56_SetLCDCAndFadeIn                 ;; 01:44c9 $cd $56 $0f
    jp   call_00_0ab4_WaitForInterrupt                                  ;; 01:44cc $c3 $b4 $0a

call_01_44cf_MenuScript_RunFrom:
; Points the script cursor at HL and runs it. Falls through into RunToEnd
    ld   A, L                                          ;; 01:44cf $7d
    ld   [wD6B3_MenuScript_PtrLo], A                                    ;; 01:44d0 $ea $b3 $d6
    ld   A, H                                          ;; 01:44d3 $7c
    ld   [wD6B4_MenuScript_PtrHi], A                                    ;; 01:44d4 $ea $b4 $d6

call_01_44d7_MenuScript_RunToEnd:
; Runs menu script commands until the terminator $FF. The cursor lives in
; wD6B3, not in a register, so a command is free to redirect the script
    ld   HL, wD6B3_MenuScript_PtrLo                                     ;; 01:44d7 $21 $b3 $d6
    ld   A, [HL+]                                      ;; 01:44da $2a
    ld   H, [HL]                                       ;; 01:44db $66
    ld   L, A                                          ;; 01:44dc $6f
    ld   A, [HL]                                       ;; 01:44dd $7e
    cp   A, MENUSCRIPT_END                             ;; 01:44de $fe $ff
    ret  Z                                             ;; 01:44e0 $c8
    call call_01_44e6_MenuScript_RunCommand                                  ;; 01:44e1 $cd $e6 $44
    jr   call_01_44d7_MenuScript_RunToEnd                                  ;; 01:44e4 $18 $f1

call_01_44e6_MenuScript_RunCommand:
; Executes one menu script command - the workhorse the whole menu system is built
; on. Almost every screen in the game is data fed through here rather than code.
;
; The first byte is a command id, which indexes an 8-byte descriptor in
; data_01_5324_MenuCmd_Descriptors; six of those bytes are copied to wD692..wD697 and hold the settings
; shared by every use of that command (block size, destination, tile ids,
; attributes). The script then supplies one or more 7-byte parameter blocks, each
; copied over wD698..wD69E, and each drawing one rectangle. The loop at
; .jr_01_4507 keeps consuming blocks until one has MENUCMD_LAST_BLOCK set, so a
; single id can stamp out a whole screen's worth of rectangles.
;
; Per block, in order:
;
;   1. wD69D_MenuCmd_OptionSlot registers a selectable row - low nibble is the row
;      index, high nibble the MENU_OPTION_* code - into wD6C5_Menu_OptionActions.
;      This is how a menu's script, not any code, decides what its options do
;   2. MENUCMD_CLEAR_BUFFER blanks the wC000 staging buffer
;   3. if the source pointer's HIGH byte is >= MENUCMD_SUB_BASE it is not a pointer
;      at all: (hi - $E0) indexes .data_01_4633_MenuCmd_SubHandlers and the low
;      byte is the argument. That is the escape hatch for the handful of screens
;      that need real code - palettes, totals, the password grid
;   4. MENUCMD_DRAW_TEXT runs the text renderer into the staging buffer
;   5. unless MENUCMD_NO_TILEMAP_FILL, fill the tilemap rectangle at
;      _SCRN0 + DestTileY*32 + DestTileX with consecutive tile ids starting at
;      wD696, and on CGB fill the matching VBK 1 rectangle with wD697
;   6. unless MENUCMD_NO_TILE_UPLOAD, copy the staged tile graphics to VRAM
;
; MENUCMD_TRANSPOSED flips steps 5 and 6 to walk down columns instead of across
; rows, for artwork whose tiles were stored column major.
    ld   HL, wD6B3_MenuScript_PtrLo                                     ;; 01:44e6 $21 $b3 $d6
    ld   E, [HL]                                       ;; 01:44e9 $5e
    inc  HL                                            ;; 01:44ea $23
    ld   D, [HL]                                       ;; 01:44eb $56
    ld   A, [DE]                                       ;; 01:44ec $1a
    inc  DE                                            ;; 01:44ed $13
    ld   [HL], D                                       ;; 01:44ee $72
    dec  HL                                            ;; 01:44ef $2b
    ld   [HL], E                                       ;; 01:44f0 $73
    ld   [wD6C4_MenuScript_CommandId], A                                    ;; 01:44f1 $ea $c4 $d6
    ld   L, A                                          ;; 01:44f4 $6f
    ld   H, $00                                        ;; 01:44f5 $26 $00
    add  HL, HL                                        ;; 01:44f7 $29
    add  HL, HL                                        ;; 01:44f8 $29
    add  HL, HL                                        ;; 01:44f9 $29
    ld   DE, data_01_5324_MenuCmd_Descriptors          ;; 01:44fa $11 $24 $53
    add  HL, DE                                        ;; 01:44fd $19
    ld   DE, wD692_Text_BlockWidthTiles                                     ;; 01:44fe $11 $92 $d6
    ld   BC, $06                                       ;; 01:4501 $01 $06 $00
    call call_00_07b0_MemCopy                                  ;; 01:4504 $cd $b0 $07
.jr_01_4507:
    ld   HL, wD6B3_MenuScript_PtrLo                                     ;; 01:4507 $21 $b3 $d6
    ld   A, [HL+]                                      ;; 01:450a $2a
    ld   H, [HL]                                       ;; 01:450b $66
    ld   L, A                                          ;; 01:450c $6f
    ld   DE, wD698_Text_PenX                                     ;; 01:450d $11 $98 $d6
    ld   BC, $07                                       ;; 01:4510 $01 $07 $00
    call call_00_07b0_MemCopy                                  ;; 01:4513 $cd $b0 $07
    ld   A, L                                          ;; 01:4516 $7d
    ld   [wD6B3_MenuScript_PtrLo], A                                    ;; 01:4517 $ea $b3 $d6
    ld   A, H                                          ;; 01:451a $7c
    ld   [wD6B4_MenuScript_PtrHi], A                                    ;; 01:451b $ea $b4 $d6
    ld   A, [wD69D_MenuCmd_OptionSlot]                                    ;; 01:451e $fa $9d $d6
    and  A, $0f                                        ;; 01:4521 $e6 $0f
    ld   L, A                                          ;; 01:4523 $6f
    ld   H, $00                                        ;; 01:4524 $26 $00
    ld   DE, wD6C5_Menu_OptionActions                                     ;; 01:4526 $11 $c5 $d6
    add  HL, DE                                        ;; 01:4529 $19
    ld   A, [wD69D_MenuCmd_OptionSlot]                                    ;; 01:452a $fa $9d $d6
    and  A, $f0                                        ;; 01:452d $e6 $f0
    ld   [HL], A                                       ;; 01:452f $77
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4530 $fa $9e $d6
    and  A, MENUCMD_CLEAR_BUFFER                       ;; 01:4533 $e6 $01
    call NZ, call_01_4bb7_Text_ClearBuffer                              ;; 01:4535 $c4 $b7 $4b
    ld   A, [wD69C_Text_SrcPtrHi]                                    ;; 01:4538 $fa $9c $d6
    sub  A, MENUCMD_SUB_BASE                           ;; 01:453b $d6 $e0
    jr   C, .jr_01_4548                                ;; 01:453d $38 $09
    ld   DE, .data_01_4633_MenuCmd_SubHandlers         ;; 01:453f $11 $33 $46
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4542 $cd $b9 $07
    call call_00_10bd_JumpHL                                  ;; 01:4545 $cd $bd $10
.jr_01_4548:
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4548 $fa $9e $d6
    and  A, MENUCMD_DRAW_TEXT                          ;; 01:454b $e6 $02
    call NZ, call_01_4a8f_Text_Render                              ;; 01:454d $c4 $8f $4a
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4550 $fa $9e $d6
    and  A, MENUCMD_LAST_BLOCK                         ;; 01:4553 $e6 $80
    jr   Z, .jr_01_4507                                ;; 01:4555 $28 $b0
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4557 $fa $9e $d6
    and  A, MENUCMD_NO_TILEMAP_FILL                    ;; 01:455a $e6 $40
    jp   NZ, .jp_01_45e5                               ;; 01:455c $c2 $e5 $45
    ld   HL, wD694_MenuCmd_DestTileX                                     ;; 01:455f $21 $94 $d6
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
    ld   DE, _SCRN0                                     ;; 01:456e $11 $00 $98
    add  HL, DE                                        ;; 01:4571 $19
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4572 $fa $9e $d6
    and  A, MENUCMD_TRANSPOSED                         ;; 01:4575 $e6 $04
    jr   NZ, .jr_01_4586                               ;; 01:4577 $20 $0d
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4579 $fa $92 $d6
    ld   B, A                                          ;; 01:457c $47
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:457d $fa $93 $d6
    ld   C, A                                          ;; 01:4580 $4f
    ld   DE, $2001                                     ;; 01:4581 $11 $01 $20
    jr   .jr_01_4591                                   ;; 01:4584 $18 $0b
.jr_01_4586:
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4586 $fa $92 $d6
    ld   C, A                                          ;; 01:4589 $4f
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:458a $fa $93 $d6
    ld   B, A                                          ;; 01:458d $47
    ld   DE, $0120                                      ;; 01:458e $11 $20 $01
.jr_01_4591:
    ld   A, [wD59E_OnGBCFlag]                                    ;; 01:4591 $fa $9e $d5
    and  A, A                                          ;; 01:4594 $a7
    jr   Z, .jr_01_45cb                                ;; 01:4595 $28 $34
    push HL                                            ;; 01:4597 $e5
    push BC                                            ;; 01:4598 $c5
    ld   A, $01                                        ;; 01:4599 $3e $01
    ldh  [rVBK], A                                     ;; 01:459b $e0 $4f
    ld   A, [wD697_MenuCmd_CgbAttributes]                                    ;; 01:459d $fa $97 $d6
    cp   A, MENUCMD_ATTR_TV_COPY                       ;; 01:45a0 $fe $ff
    jr   NZ, .jr_01_45af                               ;; 01:45a2 $20 $0b
    call call_00_08b1_MediaDimension_CopyTVAttributes                                  ;; 01:45a4 $cd $b1 $08
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
    ld   A, [wD696_MenuCmd_FirstTileId]                                    ;; 01:45cb $fa $96 $d6
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
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:45e5 $fa $9e $d6
    and  A, MENUCMD_NO_TILE_UPLOAD                     ;; 01:45e8 $e6 $20
    ret  NZ                                            ;; 01:45ea $c0
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:45eb $fa $9e $d6
    and  A, MENUCMD_TRANSPOSED                         ;; 01:45ee $e6 $04
    jr   NZ, .jr_01_45fe                               ;; 01:45f0 $20 $0c
    call call_01_4e5a_Menu_GetTileDataSize                                  ;; 01:45f2 $cd $5a $4e
    call call_01_4e49_Menu_GetVramAddrForDestTile                                  ;; 01:45f5 $cd $49 $4e
    ld   HL, wC000_BgMapTileIds                                     ;; 01:45f8 $21 $00 $c0
    jp   call_00_07b0_MemCopy                                  ;; 01:45fb $c3 $b0 $07
.jr_01_45fe:
    call call_01_4e49_Menu_GetVramAddrForDestTile                                  ;; 01:45fe $cd $49 $4e
    ld   HL, wC000_BgMapTileIds                                     ;; 01:4601 $21 $00 $c0
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4604 $fa $92 $d6
    ld   C, A                                          ;; 01:4607 $4f
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:4608 $fa $93 $d6
    ld   B, A                                          ;; 01:460b $47
.jr_01_460c:
    push BC                                            ;; 01:460c $c5
    push HL                                            ;; 01:460d $e5
.jr_01_460e:
    push BC                                            ;; 01:460e $c5
    push HL                                            ;; 01:460f $e5
    ld   BC, $10                                       ;; 01:4610 $01 $10 $00
    call call_00_07b0_MemCopy                                  ;; 01:4613 $cd $b0 $07
    pop  HL                                            ;; 01:4616 $e1
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4617 $fa $92 $d6
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
.data_01_4633_MenuCmd_SubHandlers:
; Reached when a parameter block's source-pointer high byte is >= MENUCMD_SUB_BASE;
; the index is (hi - $E0) and the low byte of the pointer is the handler's single
; argument, read back out of wD69B_Text_SrcPtrLo. 16 entries, $E0-$EF.
;
; Most handlers do one of two things: stage some graphics into the wC000 buffer, or
; point the source pointer at a string that the following MENUCMD_DRAW_TEXT block
; will then render. So the escape hatch is mostly a way of choosing text and images
; at runtime while the rest of the screen stays pure data.
;
;   $E0  pick a sprite image from data_01_74e9_ImageTable1 by index and stage it
;   $E1  same, from data_01_74ed_ImageTable2
;   $E2  Media Dimension TV screen - load the TV palette, stage a 6x5 tile block
;   $E3  set the text to the current TV's name
;   $E4  set the text to the current level's name
;   $E5  set the text to a mission description, and place the "remote collected"
;        marker sprite next to it. MENUCMD_MISSION_CURRENT means "whichever mission
;        is being played", and suppresses the marker
;   $E6  load a full screen of tiles+tilemap from a 10-byte descriptor
;   $E7  stage image 2, then set up and draw the menu cursor sprite
;   $E8  compute a counter value and format it to text with Text_FormatByte
;   $E9  totals screen - draw the six remote icons for the current page, lit or
;        unlit from wD629_RemoteProgressFlags, and pick the sprite group
;   $EA  set the text to the totals page's level name, or a heading on page 0
;   $EB  set the text to a single password cell, as a one-character string
;   $EC  set wD6D7_Menu_ChainedScriptId - queue another screen to load next
;   $ED  load a fullscreen image from a 3-byte bank/pointer descriptor
;   $EE  set the text to a mission status line, chosen by how many of the level's
;        three mission remotes you hold
;   $EF  stage the current level's collectible icon as a 3x2 block
    dw   call_01_4653_MenuCmd_StageImage1                                 ;; 01:4633 pP
    dw   call_01_465f_MenuCmd_StageImage2                                  ;; 01:4635 pP
    dw   call_01_466b_MenuCmd_StageTVScreen                                  ;; 01:4637 pP
    dw   call_01_4728_MenuCmd_SetTVNameText                                  ;; 01:4639 pP
    dw   call_01_4734_MenuCmd_SetLevelText                                  ;; 01:463b pP
    dw   call_01_473a_MenuCmd_SetMissionText                                  ;; 01:463d pP
    dw   call_01_47a4_MenuCmd_LoadScreen                                  ;; 01:463f ??
    dw   call_01_47c5_MenuCmd_DrawCursorSprite                                  ;; 01:4641 pP
    dw   call_01_47ea_MenuCmd_SetCounterText                                  ;; 01:4643 pP
    dw   call_01_4879_MenuCmd_DrawRemoteIcons                                  ;; 01:4645 pP
    dw   call_01_48df_MenuCmd_SetTotalsPageText                                  ;; 01:4647 pP
    dw   call_01_48fd_MenuCmd_SetPasswordCharText                                      ;; 01:4649 ??
    dw   call_01_4916_MenuCmd_SetChainedScript                                  ;; 01:464b pP
    dw   call_01_491d_MenuCmd_LoadFullscreenImage                                  ;; 01:464d pP
    dw   call_01_4969_MenuCmd_SetMissionStatusText
    dw   call_01_49d7_MenuCmd_StageCollectibleIcon                            ;; 01:464f ????

call_01_4653_MenuCmd_StageImage1:
; MENUCMD_SUB_STAGE_IMAGE1. Argument indexes data_01_74e9_ImageTable1; the image's
; own three-byte header carries its size, so the script does not have to
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4653 $fa $9b $d6
    ld   DE, data_01_74e9_ImageTable1                              ;; 01:4656 $11 $e9 $74
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4659 $cd $b9 $07
    jp   call_01_4e78_Menu_StageTileData                                    ;; 01:465c $c3 $78 $4e

call_01_465f_MenuCmd_StageImage2:
; MENUCMD_SUB_STAGE_IMAGE2. As above but from data_01_74ed_ImageTable2, the larger
; table - cursors, remote icons, the stats icons
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:465f $fa $9b $d6
    ld   DE, data_01_74ed_ImageTable2                              ;; 01:4662 $11 $ed $74
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4665 $cd $b9 $07
    jp   call_01_4e78_Menu_StageTileData                                    ;; 01:4668 $c3 $78 $4e

call_01_466b_MenuCmd_StageTVScreen:
; MENUCMD_SUB_STAGE_TV_SCREEN. Draws the little picture inside the TV on the mission
; select screen: load the mission-select palette, hand the TV's own palette to bank
; $0B, then stage a fixed 6x5 tile block fetched from bank $13 through
; data_01_5cb9_TVScreenImageTable. Which picture is chosen by the map's
; MAPDATA_TV_PALETTE_ID, so the palette and the artwork can never disagree
    ld   HL, .data_01_46a8_MissionSelectPalette        ;; 01:466b $21 $a8 $46
    ld   DE, wDA4B_DynamicPalette                      ;; 01:466e $11 $4b $da
    ld   BC, MENU_PALETTE_BYTES                        ;; 01:4671 $01 $80 $00
    call call_00_07b0_MemCopy                                  ;; 01:4674 $cd $b0 $07
    FARCALL call_0b_5d4b_MediaDimension_LoadTVPalette
    call call_00_2e3a_MapData_GetTVPaletteId                                  ;; 01:4682 $cd $3a $2e
    ld   DE, data_01_5cb9_TVScreenImageTable                              ;; 01:4685 $11 $b9 $5c
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4688 $cd $b9 $07
    ld   A, [wD69A_Text_FontId]                                    ;; 01:468b $fa $9a $d6
    ld   [wD696_MenuCmd_FirstTileId], A                                    ;; 01:468e $ea $96 $d6
    ld   A, MENU_TV_SCREEN_WIDTH                       ;; 01:4691 $3e $06
    ld   [wD692_Text_BlockWidthTiles], A               ;; 01:4693 $ea $92 $d6
    ld   A, MENU_TV_SCREEN_HEIGHT                      ;; 01:4696 $3e $05
    ld   [wD693_Text_BlockHeightTiles], A              ;; 01:4698 $ea $93 $d6
    push HL                                            ;; 01:469b $e5
    call call_01_4e5a_Menu_GetTileDataSize                                  ;; 01:469c $cd $5a $4e
    pop  HL                                            ;; 01:469f $e1
    ld   DE, wC000_BgMapTileIds                        ;; 01:46a0 $11 $00 $c0
    ld   A, MENU_TV_SCREEN_BANK                        ;; 01:46a3 $3e $13
    jp   call_00_07a1_FarMemCopy                       ;; 01:46a5 $c3 $a1 $07
.data_01_46a8_MissionSelectPalette:
; MENU_PALETTE_BYTES of CGB background palettes for the mission select screen,
; installed before bank $0B is asked for the TV's own palette on top
    INCBIN "gfx/menus/palettes/palette_mission_select_menu.bin"

call_01_4728_MenuCmd_SetTVNameText:
; MENUCMD_SUB_TV_NAME_TEXT. Points the source pointer at the current TV's name
; ("SCREAM TV", "TOON TV", ...) from data_01_5ee7_TVNameTable, indexed the same way as the TV
; picture above
    call call_00_2e3a_MapData_GetTVPaletteId                                  ;; 01:4728 $cd $3a $2e
    ld   DE, data_01_5ee7_TVNameTable                              ;; 01:472b $11 $e7 $5e
    call call_00_07b9_GetPointerFromTable                                  ;; 01:472e $cd $b9 $07
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4731 $c3 $6f $4e

call_01_4734_MenuCmd_SetLevelText:
; MENUCMD_SUB_LEVEL_NAME_TEXT. Entry 0 of the map's text block is its name
    call call_00_2e4c_MapData_GetLevelNameText                                  ;; 01:4734 $cd $4c $2e
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4737 $c3 $6f $4e

call_01_473a_MenuCmd_SetMissionText:
; MENUCMD_SUB_MISSION_TEXT. Argument is a mission slot 0-2, or MENUCMD_MISSION_CURRENT
; meaning "whichever mission is being played" (wD627_CurrentMission).
;
; For a real slot it also places the little marker sprite to the left of the line,
; whose tile says whether that mission's remote is already collected ($EC/$F4 on
; CGB) and whose colour differs on DMG. MENUCMD_MISSION_CURRENT sets bit 7 to skip
; the marker, which is why the pause menu shows the mission text without one.
;
; The sprite's position is derived from the block's own destination tile, so the
; marker follows the text wherever a script puts it
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:473a $fa $9b $d6
    cp   A, MENUCMD_MISSION_CURRENT                    ;; 01:473d $fe $03
    jr   NZ, .jr_01_4746                               ;; 01:473f $20 $05
    ld   A, [wD627_CurrentMission]                                    ;; 01:4741 $fa $27 $d6
    or   A, $80                                        ;; 01:4744 $f6 $80
.jr_01_4746:
    push AF                                            ;; 01:4746 $f5
    and  A, $7f                                        ;; 01:4747 $e6 $7f
    call call_00_2e5f_MapData_GetMissionText                                  ;; 01:4749 $cd $5f $2e
    call call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:474c $cd $6f $4e
    pop  AF                                            ;; 01:474f $f1
    bit  7, A                                          ;; 01:4750 $cb $7f
    ret  NZ                                            ;; 01:4752 $c0
    push AF                                            ;; 01:4753 $f5
    call call_01_4eb1_Menu_IsMissionRemoteCollected                                  ;; 01:4754 $cd $b1 $4e
    push AF                                            ;; 01:4757 $f5
    ld   C, MENU_MISSION_MARKER_COLLECTED              ;; 01:4758 $0e $ec
    ld   A, [wD59E_OnGBCFlag]                          ;; 01:475a $fa $9e $d5
    and  A, A                                          ;; 01:475d $a7
    jr   NZ, .jr_01_4769                               ;; 01:475e $20 $09
    ld   C, MENU_MISSION_MARKER_COLLECTED_DMG          ;; 01:4760 $0e $e8
    ld   A, B                                          ;; 01:4762 $78 ; B is the mask IsMissionRemoteCollected tested
    cp   A, REMOTE_BONUS_MASK                          ;; 01:4763 $fe $20
    jr   NZ, .jr_01_4769                               ;; 01:4765 $20 $02
    ld   C, MENU_MISSION_MARKER_BONUS_DMG              ;; 01:4767 $0e $f0
.jr_01_4769:
    pop  AF                                            ;; 01:4769 $f1 ; the collected/not answer
    jr   NZ, .jr_01_476e                               ;; 01:476a $20 $02
    ld   C, MENU_MISSION_MARKER_UNCOLLECTED            ;; 01:476c $0e $f4 ; one uncollected tile for both machines
.jr_01_476e:
    ld   A, C                                          ;; 01:476e $79
    ld   [wD5A8_Sprite_TileId], A                                    ;; 01:476f $ea $a8 $d5
    ld   A, [wD695_MenuCmd_DestTileY]                                    ;; 01:4772 $fa $95 $d6
    add  A, $02                                        ;; 01:4775 $c6 $02
    add  A, A                                          ;; 01:4777 $87
    add  A, A                                          ;; 01:4778 $87
    add  A, A                                          ;; 01:4779 $87
    ld   [wD5A6_TextBuffer], A                                    ;; 01:477a $ea $a6 $d5
    ld   A, [wD694_MenuCmd_DestTileX]                                    ;; 01:477d $fa $94 $d6
    inc  A                                             ;; 01:4780 $3c
    sub  A, $02                                        ;; 01:4781 $d6 $02
    add  A, A                                          ;; 01:4783 $87
    add  A, A                                          ;; 01:4784 $87
    add  A, A                                          ;; 01:4785 $87
    sub  A, $02                                        ;; 01:4786 $d6 $02
    ld   [wD5A7_Sprite_X], A                                    ;; 01:4788 $ea $a7 $d5
    ld   A, B                                          ;; 01:478b $78
    cp   A, REMOTE_BONUS_MASK                          ;; 01:478c $fe $20
    ld   A, MENU_MISSION_MARKER_PAL_BONUS              ;; 01:478e $3e $05
    jr   Z, .jr_01_4794                                ;; 01:4790 $28 $02
    ld   A, MENU_MISSION_MARKER_PAL_NORMAL             ;; 01:4792 $3e $03
.jr_01_4794:
    ld   [wD5A9_Sprite_Attributes], A                                    ;; 01:4794 $ea $a9 $d5
    pop  AF                                            ;; 01:4797 $f1
    add  A, A                                          ;; 01:4798 $87
    add  A, $02                                        ;; 01:4799 $c6 $02
    ld   [wD6D5_Menu_OamSlot], A                                    ;; 01:479b $ea $d5 $d6
    ld   BC, $202                                      ;; 01:479e $01 $02 $02
    jp   call_01_4e01_Menu_WriteSpriteRect                                  ;; 01:47a1 $c3 $01 $4e
call_01_47a4_MenuCmd_LoadScreen:
; MENUCMD_SUB_LOAD_SCREEN. Copies a 10-byte screen descriptor into wD6A5..wD6AE and
; hands it to the shared loader, which brings in a whole tileset and tilemap at once.
; Only one descriptor exists (.data_01_47bb_PasswordScreen, the password keyboard), so the argument
; is always 0
    ld   a, [wD69B_Text_SrcPtrLo]
    ld   de, .data_01_47b9_ScreenTable
    call call_00_07b9_GetPointerFromTable
    ld   de, wD6A5_ScreenDraw_TileDataBank
    ld   bc, $000a
    call call_00_07b0_MemCopy
    jp   call_00_07c3_Screen_LoadTilesAndTilemap
.data_01_47b9_ScreenTable:
; Only one screen descriptor exists, so MENUCMD_SUB_LOAD_SCREEN's argument is
; always 0
    dw   .data_01_47bb_PasswordScreen
.data_01_47bb_PasswordScreen:
; The password keyboard's frame: a whole tileset plus tilemap in one go. Copied to
; wD6A5_ScreenDraw_TileDataBank onward, so the fields below are that block's layout
    db   $09                                           ; tile data bank
    db   $b6                                           ; first tile id, also added to every tilemap byte
    db   $14, $12                                      ; 20 x 18 tiles - the whole screen
    dw   $42d0                                         ; tilemap, then the same many attribute bytes
    dw   $4000                                         ; tile graphics
    db   $d0, $02                                      ; $02d0 bytes of them

call_01_47c5_MenuCmd_DrawCursorSprite:
; MENUCMD_SUB_DRAW_CURSOR. Stages the cursor's graphics like any other image, then
; builds the little sprite script at wD6B9..wD6C0 out of the block's own width and
; height and records the image index as wD6C1_Menu_CursorSpriteId. From here on
; call_01_4d72_Menu_DrawCursor redraws it every frame, so a script only ever declares
; the cursor once
    call call_01_465f_MenuCmd_StageImage2                                  ;; 01:47c5 $cd $5f $46
    xor  A, A                                          ;; 01:47c8 $af
    ld   [wD6B9_MenuCursor_OamSlot], A                                    ;; 01:47c9 $ea $b9 $d6
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:47cc $fa $92 $d6
    ld   [wD6BE_MenuCursor_WidthInColumns], A                                    ;; 01:47cf $ea $be $d6
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:47d2 $fa $93 $d6
    ld   [wD6BF_MenuCursor_HeightInTileRows], A                                    ;; 01:47d5 $ea $bf $d6
    ld   A, $ff                                        ;; 01:47d8 $3e $ff
    ld   [wD6C0_MenuCursor_ScriptEnd], A                                    ;; 01:47da $ea $c0 $d6
    ld   A, [wD69B_Text_SrcPtrLo]                      ;; 01:47dd $fa $9b $d6 ; the image index the block asked for
    sub  A, $00                                        ;; 01:47e0 $d6 $00 ; no-op left in by the compiler
    add  A, MENU_CURSOR_ID_BASE                        ;; 01:47e2 $c6 $10
    ld   [wD6C1_Menu_CursorSpriteId], A                ;; 01:47e4 $ea $c1 $d6
    jp   call_01_4d72_Menu_DrawCursor                                  ;; 01:47e7 $c3 $72 $4d

call_01_47ea_MenuCmd_SetCounterText:
; MENUCMD_SUB_COUNTER_TEXT. Fetches one of the MENU_COUNTER_* values, formats it as
; decimal into wD5A6_TextBuffer and points the source pointer there, so the following
; MENUCMD_DRAW_TEXT draws a number that was computed this frame
    call call_01_47f6_MenuCmd_GetCounterValue                                  ;; 01:47ea $cd $f6 $47
    call call_01_4ce5_Text_FormatByte                                  ;; 01:47ed $cd $e5 $4c
    ld   HL, wD5A6_TextBuffer                                     ;; 01:47f0 $21 $a6 $d5
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:47f3 $c3 $6f $4e

call_01_47f6_MenuCmd_GetCounterValue:
; A = the number a MENU_COUNTER_* id refers to. Dispatches through .data_01_4800_CounterHandlers.
;
; The three remote counters share .jr_01_4852, which walks all LEVEL_COUNT entries of
; wD629_RemoteProgressFlags and counts set bits under the mask in C - so "how many
; red remotes have I found" is a popcount over the whole save state rather than a
; running total anyone has to maintain.
;
; The collectible counters stage themselves off wD648_CollectibleMilestoneIndex:
; a milestone already passed shows its full value ($1E, $28), the one in progress
; shows wD649_CollectibleAmount, and the ones beyond it show zero.
;
; The last two entries read the player's position and are never referenced by any
; menu script - leftover debug readouts
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:47f6 $fa $9b $d6
    ld   DE, .data_01_4800_CounterHandlers                             ;; 01:47f9 $11 $00 $48
    call call_00_07b9_GetPointerFromTable                                  ;; 01:47fc $cd $b9 $07
    jp   HL                                            ;; 01:47ff $e9
.data_01_4800_CounterHandlers:
; One handler per MENU_COUNTER_*
    dw   .jr_01_4814                                   ; $00 MENU_COUNTER_LIVES
    dw   .jr_01_4818                                   ; $01 MENU_COUNTER_HEALTH
    dw   .jr_01_481c                                   ; $02 MENU_COUNTER_MISSION_REMOTES
    dw   .jr_01_4820                                   ; $03 MENU_COUNTER_HIDDEN_REMOTES
    dw   .jr_01_4824                                   ; $04 MENU_COUNTER_BONUS_REMOTES
    dw   .jr_01_4828                                   ; $05 MENU_COUNTER_COLLECTIBLES_1
    dw   .jr_01_4834                                   ; $06 MENU_COUNTER_COLLECTIBLES_2
    dw   .jr_01_4847                                   ; $07 MENU_COUNTER_COLLECTIBLES_3
    dw   .jr_01_4869                                   ; $08 MENU_COUNTER_PLAYER_X - unused
    dw   .jr_01_486e                                   ; $09 MENU_COUNTER_PLAYER_Y - unused
.jr_01_4814:
    ld   A, [wD73D_LivesRemaining]                                    ;; 01:4814 $fa $3d $d7
    ret                                                ;; 01:4817 $c9
.jr_01_4818:
    ld   A, [wD741_Player_Health]                                    ;; 01:4818 $fa $41 $d7
    ret                                                ;; 01:481b $c9
.jr_01_481c:
    ld   C, REMOTE_MISSION_MASK                        ;; 01:481c $0e $07
    jr   .jr_01_4852                                   ;; 01:481e $18 $32
.jr_01_4820:
    ld   C, REMOTE_HIDDEN_MASK                         ;; 01:4820 $0e $18
    jr   .jr_01_4852                                   ;; 01:4822 $18 $2e
.jr_01_4824:
    ld   C, REMOTE_BONUS_MASK                          ;; 01:4824 $0e $20
    jr   .jr_01_4852                                   ;; 01:4826 $18 $2a
.jr_01_4828:
    ; milestone 1: full once it has been passed, live otherwise
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$01
    ld   a,MENU_COLLECTIBLE_MILESTONE_1
    ret  nc
    ld   a,[wD649_CollectibleAmount]
    ret  
.jr_01_4834:
    ; milestone 2: full, live, or not started yet
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$02
    ld   a,MENU_COLLECTIBLE_MILESTONE_2
    ret  nc
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$01
    ld   a,[wD649_CollectibleAmount]
    ret  nc
    xor  a
    ret  
.jr_01_4847:
    ; milestone 3: the last one, so it is either live or not started - there is no
    ; "already passed" value for it
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$02
    ld   a,[wD649_CollectibleAmount]
    ret  nc
    xor  a
    ret  
.jr_01_4852:
    ld   HL, wD629_RemoteProgressFlags                                     ;; 01:4852 $21 $29 $d6
    ld   B, LEVEL_COUNT                                ;; 01:4855 $06 $1e
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
.jr_01_4869:
    ; MENU_COUNTER_PLAYER_X / _Y: the player's 16-bit subpixel position shifted
    ; down to whole tiles (x8, then take the high byte). No menu script asks for
    ; either, so these are leftover debug readouts
    ld   hl,wD20E_Player_XPositionLo
    jr   .jr_01_4871
.jr_01_486e:
    ld   hl,wD210_Player_YPositionLo
.jr_01_4871:
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    ret  

call_01_4879_MenuCmd_DrawRemoteIcons:
; MENUCMD_SUB_REMOTE_ICONS. Draws the row of remote icons for the page being shown.
;
; Each of the MENU_REMOTE_ICON_COUNT icons has a lit tile in .data_01_48d9_RemoteIconTiles and an
; unlit one $24 tiles later; the bits of wD629_RemoteProgressFlags are shifted out
; one at a time to choose between them, and the results go into
; wD5AA_Sprite_TileIdTable rather than into the sprite script - so one fixed layout
; covers every combination of collected remotes.
;
; The layout itself is picked by adding the level's remote progress id to the group
; base in the argument (MENU_SPRITE_GROUP_TOTALS or _CONGRATS), which is how a level
; with two objectives draws two icons and one with five draws five.
;
; wD69A is not a font id here: when non-zero it is the frame delay after which
; call_01_4d25_Menu_TickHideSprites erases this group again
    ld   A, [wD69A_Text_FontId]                                    ;; 01:4879 $fa $9a $d6
    and  A, A                                          ;; 01:487c $a7
    jr   Z, .jr_01_4888                                ;; 01:487d $28 $09
    ld   [wD6D8_Menu_HideSpritesDelay], A                                    ;; 01:487f $ea $d8 $d6
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4882 $fa $9b $d6
    ld   [wD6D9_Menu_HideSpritesGroup], A                                    ;; 01:4885 $ea $d9 $d6
.jr_01_4888:
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4888 $fa $9b $d6
    cp   A, MENU_SPRITE_GROUP_TOTALS                   ;; 01:488b $fe $00
    jr   Z, .jr_01_4899                                ;; 01:488d $28 $0a
    cp   A, MENU_SPRITE_GROUP_CONGRATS                 ;; 01:488f $fe $07
    jr   NZ, .jr_01_48d0                               ;; 01:4891 $20 $3d
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4893 $fa $24 $d6
    ld   [wD625_TotalsMenuPage], A                                    ;; 01:4896 $ea $25 $d6
.jr_01_4899:
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4899 $fa $24 $d6
    push AF                                            ;; 01:489c $f5
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:489d $fa $25 $d6
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48a0 $ea $24 $d6
    ld   L, A                                          ;; 01:48a3 $6f
    ld   H, $00                                        ;; 01:48a4 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 01:48a6 $11 $29 $d6
    add  HL, DE                                        ;; 01:48a9 $19
    ld   C, [HL]                                       ;; 01:48aa $4e
    ld   HL, wD5AA_Sprite_TileIdTable                                     ;; 01:48ab $21 $aa $d5
    ld   DE, .data_01_48d9_RemoteIconTiles                             ;; 01:48ae $11 $d9 $48
    ld   B, MENU_REMOTE_ICON_COUNT                     ;; 01:48b1 $06 $06
.jr_01_48b3:
    ld   A, [DE]                                       ;; 01:48b3 $1a
    srl  C                                             ;; 01:48b4 $cb $39 ; next remote bit, LSB first
    jr   C, .jr_01_48ba                                ;; 01:48b6 $38 $02
    add  A, MENU_REMOTE_ICON_UNLIT_OFFSET              ;; 01:48b8 $c6 $24 ; not collected - use the dark twin
.jr_01_48ba:
    ld   [HL+], A                                      ;; 01:48ba $22
    inc  DE                                            ;; 01:48bb $13
    dec  B                                             ;; 01:48bc $05
    jr   NZ, .jr_01_48b3                               ;; 01:48bd $20 $f4
    call call_00_2e43_MapData_GetRemoteProgressId                                  ;; 01:48bf $cd $43 $2e
    ld   C, A                                          ;; 01:48c2 $4f
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:48c3 $fa $9b $d6
    add  A, C                                          ;; 01:48c6 $81
    ld   C, A                                          ;; 01:48c7 $4f
    pop  AF                                            ;; 01:48c8 $f1
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48c9 $ea $24 $d6
    ld   A, C                                          ;; 01:48cc $79
    ld   [wD6DA_Menu_TotalsSpriteGroup], A                                    ;; 01:48cd $ea $da $d6
.jr_01_48d0:
    ld   DE, data_01_5aa9_SpriteScriptTable                              ;; 01:48d0 $11 $a9 $5a
    call call_00_07b9_GetPointerFromTable                                  ;; 01:48d3 $cd $b9 $07
    jp   call_01_4dc8_Menu_BuildSpriteBlock                                    ;; 01:48d6 $c3 $c8 $4d
.data_01_48d9_RemoteIconTiles:
; The lit tile for each of the six bits of wD629_RemoteProgressFlags. The icons
; are 3x4 tiles, so the three artworks are $0C apart: the three mission remotes
; all share the red one, the two hidden remotes share silver, and the bonus bit
; gets gold. Add MENU_REMOTE_ICON_UNLIT_OFFSET for the unlit version
    db   $98, $98, $98                                 ; bits 0-2, red
    db   $a4, $a4                                      ; bits 3-4, silver
    db   $b0                                           ; bit 5, gold

call_01_48df_MenuCmd_SetTotalsPageText:
; MENUCMD_SUB_TOTALS_PAGE_TEXT. The totals screen's heading: the level name for the
; page you are on, or "GAME STATS" for page 0, which is the whole-game summary rather
; than a level. wD624_CurrentLevelId is borrowed as the lookup key and restored,
; because the level name accessor only knows how to read the current level
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:48df $fa $25 $d6
    and  A, A                                          ;; 01:48e2 $a7
    jr   Z, .jr_01_48f7                                ;; 01:48e3 $28 $12
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:48e5 $fa $24 $d6
    push AF                                            ;; 01:48e8 $f5
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:48e9 $fa $25 $d6
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48ec $ea $24 $d6
    call call_01_4734_MenuCmd_SetLevelText                                  ;; 01:48ef $cd $34 $47
    pop  AF                                            ;; 01:48f2 $f1
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48f3 $ea $24 $d6
    ret                                                ;; 01:48f6 $c9
.jr_01_48f7:
    ld   HL, data_01_5d4b_Text_GameStats                              ;; 01:48f7 $21 $4b $5d
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:48fa $c3 $6f $4e

call_01_48fd_MenuCmd_SetPasswordCharText:
; MENUCMD_SUB_PASSWORD_CHAR_TEXT. Argument is a cell index into the flat array at
; wD667_PasswordExitButton. Copies that one character into wD60A_OneCharString and
; terminates it, so a single letter can go through the ordinary text renderer without
; a string in ROM for every possible letter in every possible box
    ld   hl,wD69B_Text_SrcPtrLo
    ld   l,[hl]
    ld   h,$00
    ld   de,wD667_PasswordExitButton
    add  hl,de
    ld   a,[hl]
    ld   [wD60A_OneCharString],a
    ld   a,END_TEXT
    ld   [wD60B_OneCharStringEnd],a                    ; bit 7 alone: an empty line, ending the string
    ld   hl,wD60A_OneCharString
    jp   call_01_4e6f_Menu_SetScriptSrcPtr

call_01_4916_MenuCmd_SetChainedScript:
; MENUCMD_SUB_CHAIN_SCRIPT. Queues another script to run once this one ends; see
; data_01_568c_ChainedScriptTable. Only the last one set wins, since there is a single
; slot in wD6D7_Menu_ChainedScriptId
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4916 $fa $9b $d6
    ld   [wD6D7_Menu_ChainedScriptId], A                                    ;; 01:4919 $ea $d7 $d6
    ret                                                ;; 01:491c $c9

call_01_491d_MenuCmd_LoadFullscreenImage:
; MENUCMD_SUB_FULLSCREEN_IMAGE. Argument is a MENU_IMAGE_* id; .data_01_4932_FullscreenImages turns it
; into a bank and pointer, which the shared loader unpacks over the whole screen.
; These are the title cards and the credit pages - the screens with no layout of their
; own, just a picture
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:491d $fa $9b $d6
    ld   DE, .data_01_4932_FullscreenImages                             ;; 01:4920 $11 $32 $49
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4923 $cd $b9 $07
    ld   DE, wD6B0_FullscreenImage_Bank                                     ;; 01:4926 $11 $b0 $d6
    ld   BC, $03                                       ;; 01:4929 $01 $03 $00
    call call_00_07b0_MemCopy                                  ;; 01:492c $cd $b0 $07
    jp   call_00_084d_Screen_LoadFullscreenImage                                    ;; 01:492f $c3 $4d $08
.data_01_4932_FullscreenImages:
; MENU_IMAGE_* -> a 3-byte bank/pointer descriptor for
; call_00_084d_Screen_LoadFullscreenImage. The indirection exists because the
; descriptor has to be copied into WRAM before the loader can read it
    dw   .data_01_4948_TitleScreen                     ; $00 MENU_IMAGE_TITLE_0
    dw   .data_01_494b_TitleOptions                    ; $01 MENU_IMAGE_TITLE_1
    dw   .data_01_494e_AudioMenu                       ; $02 MENU_IMAGE_AUDIO_MENU
    dw   .data_01_4951_GreatJob                        ; $03 MENU_IMAGE_GREAT_JOB
    dw   .data_01_4954_Crave                           ; $04 MENU_IMAGE_CRAVE
    dw   .data_01_4957_Splash                          ; $05 MENU_IMAGE_SPLASH
    dw   .data_01_495a_David                           ; $06 MENU_IMAGE_DAVID
    dw   .data_01_495d_Credits1                        ; $07 MENU_IMAGE_CREDITS_1
    dw   .data_01_4960_Credits2                        ; $08 MENU_IMAGE_CREDITS_2
    dw   .data_01_4963_Credits3                        ; $09 MENU_IMAGE_CREDITS_3
    dw   .data_01_4966_Credits4                        ; $0A MENU_IMAGE_CREDITS_4
.data_01_4948_TitleScreen:
    farpointer image_title_screen_008_0
.data_01_494b_TitleOptions:
    farpointer image_title_screen_008_1
.data_01_494e_AudioMenu:
    farpointer image_audio_menu_00c_0
.data_01_4951_GreatJob:
    farpointer image_great_job_0c_2
.data_01_4954_Crave:
    farpointer image_crave_01f_0
.data_01_4957_Splash:
    farpointer image_splash_01f_1
.data_01_495a_David:
    farpointer image_david_01e_0
.data_01_495d_Credits1:
    farpointer image_credits1_01e_1
.data_01_4960_Credits2:
    farpointer image_credits2_01d_0
.data_01_4963_Credits3:
    farpointer image_credits3_01d_1
.data_01_4966_Credits4:
    farpointer image_credits4_03d_0
    
call_01_4969_MenuCmd_SetMissionStatusText:
; Picks the "how are you doing on this level" string from a 2D table, and points
; the source pointer at it so the next MENUCMD_DRAW_TEXT block renders it.
;
; Row is the level's remote progress id; column is how many of its three mission
; remotes you hold, counted straight out of wD629_RemoteProgressFlags by the
; `srl C / adc A,$00` popcount of bits 0-2 - so 0 to 3. Progress id 5 is the odd
; one out and tests bit 5 instead, giving a plain yes/no.
;
; Address is .data_01_49a7_MissionStatusText + row*8 + column*2, so the table is
; eight rows of four pointers
    call call_00_2e43_MapData_GetRemoteProgressId
    push af
    push af
    ld   hl,wD624_CurrentLevelId
    ld   l,[hl]
    ld   h,$00
    ld   de,wD629_RemoteProgressFlags
    add  hl,de
    ld   c,[hl]
    pop  af
    cp   a,$05
    jr   nz,.jr_01_4987
    ld   a,c
    and  a,$20
    jr   z,.jr_01_4991
    ld   a,$01
    jr   .jr_01_4991
.jr_01_4987:
    ld   b,$03
    xor  a
.jr_01_498a:
    srl  c
    adc  a,$00
    dec  b
    jr   nz,.jr_01_498a
.jr_01_4991:
    add  a
    ld   e,a
    ld   d,$00
    pop  af
    ld   l,a
    ld   h,$00
    add  hl,hl
    add  hl,hl
    add  hl,hl
    add  hl,de
    ld   de,.data_01_49a7_MissionStatusText
    add  hl,de
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    jp   call_01_4e6f_Menu_SetScriptSrcPtr
.data_01_49a7_MissionStatusText:
; 8 rows x 4 pointers, indexed [remote progress id][missions collected]. Several
; columns repeat the same address, which is how one string covers "1 or 2 done"
    dw   data_01_5d97_Text_0Of3RedRemotes, data_01_5db0_Text_1Of3RedRemotes, data_01_5dc9_Text_2Of3RedRemotes, data_01_5de2_Text_3Of3RedRemotes
    dw   data_01_5dfb_Text_0Of2RedRemotes, data_01_5e14_Text_1Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes
    dw   data_01_5e46_Text_0Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes
    dw   data_01_5dfb_Text_0Of2RedRemotes, data_01_5e14_Text_1Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes
    dw   data_01_5e46_Text_0Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes
    dw   data_01_5e78_Text_0Of1GoldRemotes, data_01_5e92_Text_1Of1GoldRemotes, data_01_5e92_Text_1Of1GoldRemotes, data_01_5e92_Text_1Of1GoldRemotes

call_01_49d7_MenuCmd_StageCollectibleIcon:
; Stages the current level's collectible icon - the fruit/bug/whatever that level
; uses - as a 3x2 tile block starting at tile id $92.
;
; The graphics come from data_01_7c0f_CollectibleIconTable indexed by level id, and
; the 24 bytes immediately after them in ROM are the icon's tilemap ids, copied on
; to wDAAB_MenuBgMapTileIds. The 128-byte blob loaded first is the CGB palette set
    ld   hl,.data_01_4a0f_PauseMenuPalette
    ld   de,wDA4B_DynamicPalette
    ld   bc,MENU_PALETTE_BYTES
    call call_00_07b0_MemCopy
    ld   a,[wD624_CurrentLevelId]
    ld   de,data_01_7c0f_CollectibleIconTable
    call call_00_07b9_GetPointerFromTable
    ld   a,MENU_COLLECTIBLE_ICON_TILE
    ld   [wD696_MenuCmd_FirstTileId],a
    ld   a,MENU_COLLECTIBLE_ICON_WIDTH
    ld   [wD692_Text_BlockWidthTiles],a
    ld   a,MENU_COLLECTIBLE_ICON_HEIGHT
    ld   [wD693_Text_BlockHeightTiles],a
    push hl
    call call_01_4e5a_Menu_GetTileDataSize
    pop  hl
    ld   de,wC000_BgMapTileIds
    call call_00_07b0_MemCopy                          ; HL now sits on the tilemap ids that follow
    ld   de,wDAAB_MenuBgMapTileIds
    ld   bc,MENU_COLLECTIBLE_TILEMAP_BYTES
    jp   call_00_07b0_MemCopy
.data_01_4a0f_PauseMenuPalette:
; MENU_PALETTE_BYTES of CGB background palettes. Named for the screen it dresses -
; the collectible icon is drawn on the pause and congratulations screens, and the
; icon's own palette set is loaded on top of this one from the blob in ROM
    INCBIN "gfx/menus/palettes/palette_pause_menu.bin"

call_01_4a8f_Text_Render:
; Renders a string into the wC000 staging buffer as a proportional, word-wrapped,
; optionally centred block of text. Entered from call_01_44e6_MenuScript_RunCommand
; when bit 1 of wD69E_MenuCmd_Flags is set, so a menu script asks for text by setting a flag
; rather than by calling anything.
;
; There is no tilemap involved and no VRAM write here. Everything is drawn into
; wC000 as raw tile GRAPHICS - a wD692 x wD693 grid of 16-byte tiles, row major -
; which some later command uploads. That is why glyphs can be any height and can
; straddle tile boundaries freely: the renderer is compositing pixels, not
; placing characters in a grid.
;
; Three passes:
;   1. copy the six-byte font descriptor for wD69A into wD69F..wD6A4
;   2. call_01_4bd3_Text_WrapAndAlign - break the string into lines that fit, and
;      resolve a $FE PenY into evenly distributed line positions
;   3. walk the lines, drawing each character with call_01_4ae7_Text_DrawGlyph and
;      moving down wD6DC after each
;
; Per line, a PenX of TEXT_AUTO_ALIGN means centre: measure the line and start at
; (block width in pixels - width) / 2. Note the subtraction is done as
; `A = blockWidth*8` then `sub C` after `srl C`, i.e. half the measured width, so
; the result is a true centre rather than a right edge.
    ld   HL, wD69A_Text_FontId                                     ;; 01:4a8f $21 $9a $d6
    ld   L, [HL]                                       ;; 01:4a92 $6e
    ld   H, $00                                        ;; 01:4a93 $26 $00
    add  HL, HL                                        ;; 01:4a95 $29
    add  HL, HL                                        ;; 01:4a96 $29
    add  HL, HL                                        ;; 01:4a97 $29
    ld   DE, data_01_65fe_FontDescriptors                              ;; 01:4a98 $11 $fe $65
    add  HL, DE                                        ;; 01:4a9b $19
    ld   DE, wD69F_Font_GlyphBase                                     ;; 01:4a9c $11 $9f $d6
    ld   BC, $06                                       ;; 01:4a9f $01 $06 $00
    call call_00_07b0_MemCopy                                  ;; 01:4aa2 $cd $b0 $07
    call call_01_4bd3_Text_WrapAndAlign                                  ;; 01:4aa5 $cd $d3 $4b
.jr_01_4aa8:
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4aa8 $21 $9b $d6
    ld   E, [HL]                                       ;; 01:4aab $5e
    inc  HL                                            ;; 01:4aac $23
    ld   D, [HL]                                       ;; 01:4aad $56
    ld   A, [DE]                                       ;; 01:4aae $1a
    cp   A, $80                                        ;; 01:4aaf $fe $80
    ret  Z                                             ;; 01:4ab1 $c8
    and  A, A                                          ;; 01:4ab2 $a7
    ret  Z                                             ;; 01:4ab3 $c8
    ld   A, [wD6DB_Text_RequestedX]                                    ;; 01:4ab4 $fa $db $d6
    cp   A, $fe                                        ;; 01:4ab7 $fe $fe
    jr   NZ, .jr_01_4ac6                               ;; 01:4ab9 $20 $0b
    call call_01_4c81_Text_MeasureLine                                  ;; 01:4abb $cd $81 $4c
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4abe $fa $92 $d6
    add  A, A                                          ;; 01:4ac1 $87
    add  A, A                                          ;; 01:4ac2 $87
    srl  C                                             ;; 01:4ac3 $cb $39
    sub  A, C                                          ;; 01:4ac5 $91
.jr_01_4ac6:
    ld   [wD698_Text_PenX], A                                    ;; 01:4ac6 $ea $98 $d6
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4ac9 $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4acc $2a
    ld   H, [HL]                                       ;; 01:4acd $66
    ld   L, A                                          ;; 01:4ace $6f
.jr_01_4acf:
    ld   A, [HL+]                                      ;; 01:4acf $2a
    push HL                                            ;; 01:4ad0 $e5
    call call_01_4ae7_Text_DrawGlyph                                  ;; 01:4ad1 $cd $e7 $4a
    pop  HL                                            ;; 01:4ad4 $e1
    bit  7, [HL]                                       ;; 01:4ad5 $cb $7e
    jr   Z, .jr_01_4acf                                ;; 01:4ad7 $28 $f6
    inc  HL                                            ;; 01:4ad9 $23
    call call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4ada $cd $6f $4e
    ld   HL, wD699_Text_PenY                                     ;; 01:4add $21 $99 $d6
    ld   A, [wD6DC_Text_LineAdvance]                                    ;; 01:4ae0 $fa $dc $d6
    add  A, [HL]                                       ;; 01:4ae3 $86
    ld   [HL], A                                       ;; 01:4ae4 $77
    jr   .jr_01_4aa8                                   ;; 01:4ae5 $18 $c1

call_01_4ae7_Text_DrawGlyph:
; Draws one character at (wD698, wD699) and advances the pen. A = character code.
;
; The pen is in pixels, so a glyph almost never lands on a tile boundary. The trick
; is to treat each 8-pixel-wide glyph row as the top byte of a 16-bit window and
; shift it left by wD6C2 = 8 - (penX & 7). The high half is then the glyph shifted
; right by (penX & 7) - what belongs in the current tile - and the low half is the
; bits pushed past the right edge, which belong in the tile one column over. Both
; halves are OR'd in with XOR against what is already there, so glyphs composite
; rather than overwrite.
;
; Destination stepping mirrors that: two bytes per pixel row within a tile, and
; when the write pointer crosses a $10 boundary the glyph has run off the bottom
; of one tile, so it adds wD692*$10 and subtracts $10 to land on the tile directly
; below. The outer loop repeats the whole thing wD6A3 times, +$10 each time, for
; fonts whose glyphs are two tile columns wide.
;
; XOR rather than OR means drawing the same string twice erases it - which is how
; the password keyboard's blinking highlight works.
    call call_01_4cab_Text_SelectGlyph                                  ;; 01:4ae7 $cd $ab $4c
    ld   A, [wD698_Text_PenX]                                    ;; 01:4aea $fa $98 $d6
    and  A, $07                                        ;; 01:4aed $e6 $07
    ld   C, A                                          ;; 01:4aef $4f
    ld   A, $08                                        ;; 01:4af0 $3e $08
    sub  A, C                                          ;; 01:4af2 $91
    ld   [wD6C2_Text_ShiftCount], A                                    ;; 01:4af3 $ea $c2 $d6
    ld   A, [wD698_Text_PenX]                                    ;; 01:4af6 $fa $98 $d6
    and  A, $f8                                        ;; 01:4af9 $e6 $f8
    ld   L, A                                          ;; 01:4afb $6f
    ld   H, $00                                        ;; 01:4afc $26 $00
    add  HL, HL                                        ;; 01:4afe $29
    ld   A, [wD699_Text_PenY]                                    ;; 01:4aff $fa $99 $d6
    and  A, $07                                        ;; 01:4b02 $e6 $07
    add  A, A                                          ;; 01:4b04 $87
    ld   E, A                                          ;; 01:4b05 $5f
    ld   D, $00                                        ;; 01:4b06 $16 $00
    add  HL, DE                                        ;; 01:4b08 $19
    ld   A, [wD699_Text_PenY]                                    ;; 01:4b09 $fa $99 $d6
    srl  A                                             ;; 01:4b0c $cb $3f
    srl  A                                             ;; 01:4b0e $cb $3f
    srl  A                                             ;; 01:4b10 $cb $3f
    jr   Z, .jr_01_4b26                                ;; 01:4b12 $28 $12
    ld   C, A                                          ;; 01:4b14 $4f
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4b15 $fa $92 $d6
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
    ld   DE, wC000_BgMapTileIds                                     ;; 01:4b26 $11 $00 $c0
    add  HL, DE                                        ;; 01:4b29 $19
    ld   A, [wD6A3_Font_GlyphWidthCols]                                    ;; 01:4b2a $fa $a3 $d6
.jr_01_4b2d:
    push AF                                            ;; 01:4b2d $f5
    push HL                                            ;; 01:4b2e $e5
    ld   A, L                                          ;; 01:4b2f $7d
    ld   [wD6B5_Text_DestPtrLo], A                                    ;; 01:4b30 $ea $b5 $d6
    ld   A, H                                          ;; 01:4b33 $7c
    ld   [wD6B6_Text_DestPtrHi], A                                    ;; 01:4b34 $ea $b6 $d6
    ld   A, [wD6A4_Font_GlyphHeightPx]                                    ;; 01:4b37 $fa $a4 $d6
.jr_01_4b3a:
    push AF                                            ;; 01:4b3a $f5
    ld   A, [wD6B7_Text_GlyphPtrLo]                                    ;; 01:4b3b $fa $b7 $d6
    ld   L, A                                          ;; 01:4b3e $6f
    ld   A, [wD6B8_Text_GlyphPtrHi]                                    ;; 01:4b3f $fa $b8 $d6
    ld   H, A                                          ;; 01:4b42 $67
    ld   E, [HL]                                       ;; 01:4b43 $5e
    inc  HL                                            ;; 01:4b44 $23
    ld   C, [HL]                                       ;; 01:4b45 $4e
    inc  HL                                            ;; 01:4b46 $23
    ld   A, L                                          ;; 01:4b47 $7d
    ld   [wD6B7_Text_GlyphPtrLo], A                                    ;; 01:4b48 $ea $b7 $d6
    ld   A, H                                          ;; 01:4b4b $7c
    ld   [wD6B8_Text_GlyphPtrHi], A                                    ;; 01:4b4c $ea $b8 $d6
    ld   D, $00                                        ;; 01:4b4f $16 $00
    ld   B, $00                                        ;; 01:4b51 $06 $00
    ld   A, [wD6C2_Text_ShiftCount]                                    ;; 01:4b53 $fa $c2 $d6
.jr_01_4b56:
    sla  E                                             ;; 01:4b56 $cb $23
    rl   D                                             ;; 01:4b58 $cb $12
    sla  C                                             ;; 01:4b5a $cb $21
    rl   B                                             ;; 01:4b5c $cb $10
    dec  A                                             ;; 01:4b5e $3d
    jr   NZ, .jr_01_4b56                               ;; 01:4b5f $20 $f5
    ld   A, [wD6B5_Text_DestPtrLo]                                    ;; 01:4b61 $fa $b5 $d6
    ld   L, A                                          ;; 01:4b64 $6f
    ld   A, [wD6B6_Text_DestPtrHi]                                    ;; 01:4b65 $fa $b6 $d6
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
    ld   HL, wD6B5_Text_DestPtrLo                                     ;; 01:4b79 $21 $b5 $d6
    ld   A, [HL+]                                      ;; 01:4b7c $2a
    ld   H, [HL]                                       ;; 01:4b7d $66
    ld   L, A                                          ;; 01:4b7e $6f
    inc  HL                                            ;; 01:4b7f $23
    inc  HL                                            ;; 01:4b80 $23
    ld   A, L                                          ;; 01:4b81 $7d
    and  A, $0f                                        ;; 01:4b82 $e6 $0f
    jr   NZ, .jr_01_4b98                               ;; 01:4b84 $20 $12
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4b86 $fa $92 $d6
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
    ld   [wD6B5_Text_DestPtrLo], A                                    ;; 01:4b99 $ea $b5 $d6
    ld   A, H                                          ;; 01:4b9c $7c
    ld   [wD6B6_Text_DestPtrHi], A                                    ;; 01:4b9d $ea $b6 $d6
    pop  AF                                            ;; 01:4ba0 $f1
    dec  A                                             ;; 01:4ba1 $3d
    jr   NZ, .jr_01_4b3a                               ;; 01:4ba2 $20 $96
    pop  HL                                            ;; 01:4ba4 $e1
    ld   DE, $10                                       ;; 01:4ba5 $11 $10 $00
    add  HL, DE                                        ;; 01:4ba8 $19
    pop  AF                                            ;; 01:4ba9 $f1
    dec  A                                             ;; 01:4baa $3d
    jr   NZ, .jr_01_4b2d                               ;; 01:4bab $20 $80
    ld   HL, wD698_Text_PenX                                     ;; 01:4bad $21 $98 $d6
    ld   A, [wD6C3_Text_GlyphAdvance]                                    ;; 01:4bb0 $fa $c3 $d6
    add  A, [HL]                                       ;; 01:4bb3 $86
    inc  A                                             ;; 01:4bb4 $3c
    ld   [HL], A                                       ;; 01:4bb5 $77
    ret                                                ;; 01:4bb6 $c9

call_01_4bb7_Text_ClearBuffer:
; Zeroes the wC000 staging buffer for the current wD692 x wD693 tile block, so the
; XOR compositing in call_01_4ae7_Text_DrawGlyph starts from a blank page. Called
; from call_01_44e6_MenuScript_RunCommand when bit 0 of wD69E_MenuCmd_Flags is set.
;
; The inner loop is 16 unrolled `ld [HL+],A`, one whole tile per iteration, with B
; counting tiles rather than bytes
    call call_01_4e5a_Menu_GetTileDataSize                                  ;; 01:4bb7 $cd $5a $4e
    ld   B, A                                          ;; 01:4bba $47
    ld   HL, wC000_BgMapTileIds                                     ;; 01:4bbb $21 $00 $c0
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

call_01_4bd3_Text_WrapAndAlign:
; Word-wraps the string to the block width, then works out where the lines go.
;
; The string is first copied to wD5A6_TextBuffer, because the wrap is destructive:
; when a line measures wider than wD692*8 pixels, the routine scans back from the
; line end to the nearest TEXT_SPACE and writes $80 over it, turning that space
; into a line break. It then re-measures from the top and repeats until the line
; fits. Wrapping in a scratch buffer is what lets the same ROM string be re-wrapped
; to a different block width elsewhere.
;
; Afterwards, a PenY of TEXT_AUTO_ALIGN triggers vertical distribution: count the
; lines, take the leftover height (block height in pixels minus lines * glyph
; height) and divide it by lines+1 by repeated subtraction. That is the gap above
; the first line, and wD6DC becomes gap + glyph height - so the spacing above,
; between and below all come out equal
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4bd3 $21 $9b $d6
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
    call call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4be8 $cd $6f $4e
.jr_01_4beb:
    call call_01_4c81_Text_MeasureLine                                  ;; 01:4beb $cd $81 $4c
    ld   HL, wD692_Text_BlockWidthTiles                                     ;; 01:4bee $21 $92 $d6
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
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4bfd $21 $9b $d6
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
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4c12 $21 $9b $d6
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
    call call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4c21 $cd $6f $4e
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
    ld   A, [wD698_Text_PenX]                                    ;; 01:4c33 $fa $98 $d6
    ld   [wD6DB_Text_RequestedX], A                                    ;; 01:4c36 $ea $db $d6
    ld   HL, wD5A6_TextBuffer                                     ;; 01:4c39 $21 $a6 $d5
    call call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4c3c $cd $6f $4e
    ld   A, [wD6A4_Font_GlyphHeightPx]                                    ;; 01:4c3f $fa $a4 $d6
    inc  A                                             ;; 01:4c42 $3c
    ld   [wD6DC_Text_LineAdvance], A                                    ;; 01:4c43 $ea $dc $d6
    ld   A, [wD699_Text_PenY]                                    ;; 01:4c46 $fa $99 $d6
    cp   A, $fe                                        ;; 01:4c49 $fe $fe
    ret  NZ                                            ;; 01:4c4b $c0
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4c4c $21 $9b $d6
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
    ld   A, [wD6A4_Font_GlyphHeightPx]                                    ;; 01:4c5f $fa $a4 $d6
    ld   B, A                                          ;; 01:4c62 $47
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:4c63 $fa $93 $d6
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
    ld   [wD699_Text_PenY], A                                    ;; 01:4c76 $ea $99 $d6
    ld   HL, wD6A4_Font_GlyphHeightPx                                     ;; 01:4c79 $21 $a4 $d6
    add  A, [HL]                                       ;; 01:4c7c $86
    ld   [wD6DC_Text_LineAdvance], A                                    ;; 01:4c7d $ea $dc $d6
    ret                                                ;; 01:4c80 $c9

call_01_4c81_Text_MeasureLine:
; BC = pixel width of the line starting at wD69B, summing each glyph's advance from
; wD6A1 plus TEXT_CHAR_SPACING, and stopping after the character with bit 7 set.
;
; The `inc BC` per character adds the inter-character gap; the single `dec BC` at
; the end removes the one trailing gap, so a line is measured edge to edge. An
; empty line - bit 7 already set on the first byte - returns 0 via the early exit
    ld   HL, wD69B_Text_SrcPtrLo                                     ;; 01:4c81 $21 $9b $d6
    ld   A, [HL+]                                      ;; 01:4c84 $2a
    ld   H, [HL]                                       ;; 01:4c85 $66
    ld   L, A                                          ;; 01:4c86 $6f
    ld   BC, $00                                       ;; 01:4c87 $01 $00 $00
    bit  7, [HL]                                       ;; 01:4c8a $cb $7e
    ret  NZ                                            ;; 01:4c8c $c0
.jr_01_4c8d:
    ld   A, [HL+]                                      ;; 01:4c8d $2a
    push HL                                            ;; 01:4c8e $e5
    call call_01_4f41_Text_CharToGlyphIndex                                  ;; 01:4c8f $cd $41 $4f
    ld   HL, wD6A1_Font_WidthTable                                     ;; 01:4c92 $21 $a1 $d6
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

call_01_4cab_Text_SelectGlyph:
; Points wD6B7 at a character's bitmap and records its advance in wD6C3.
; A = character code.
;
;   stride    = wD6A3 * wD6A4 * FONT_BYTES_PER_ROW
;   glyph_ptr = wD69F + index * stride
;
; Both the multiply and the index scaling are repeated addition. There is no
; special case for index 0, which is what establishes that the font blobs have no
; header - glyph 0 sits at the very first byte
    call call_01_4f41_Text_CharToGlyphIndex                                  ;; 01:4cab $cd $41 $4f
    push AF                                            ;; 01:4cae $f5
    ld   HL, wD6A1_Font_WidthTable                                     ;; 01:4caf $21 $a1 $d6
    ld   E, [HL]                                       ;; 01:4cb2 $5e
    inc  HL                                            ;; 01:4cb3 $23
    ld   D, [HL]                                       ;; 01:4cb4 $56
    ld   L, A                                          ;; 01:4cb5 $6f
    ld   H, $00                                        ;; 01:4cb6 $26 $00
    add  HL, DE                                        ;; 01:4cb8 $19
    ld   A, [HL]                                       ;; 01:4cb9 $7e
    ld   [wD6C3_Text_GlyphAdvance], A                                    ;; 01:4cba $ea $c3 $d6
    ld   A, [wD6A4_Font_GlyphHeightPx]                                    ;; 01:4cbd $fa $a4 $d6
    add  A, A                                          ;; 01:4cc0 $87
    ld   C, A                                          ;; 01:4cc1 $4f
    ld   A, [wD6A3_Font_GlyphWidthCols]                                    ;; 01:4cc2 $fa $a3 $d6
    ld   B, A                                          ;; 01:4cc5 $47
    xor  A, A                                          ;; 01:4cc6 $af
.jr_01_4cc7:
    add  A, C                                          ;; 01:4cc7 $81
    dec  B                                             ;; 01:4cc8 $05
    jr   NZ, .jr_01_4cc7                               ;; 01:4cc9 $20 $fc
    ld   E, A                                          ;; 01:4ccb $5f
    ld   D, $00                                        ;; 01:4ccc $16 $00
    ld   HL, wD69F_Font_GlyphBase                                     ;; 01:4cce $21 $9f $d6
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
    ld   [wD6B7_Text_GlyphPtrLo], A                                    ;; 01:4cdd $ea $b7 $d6
    ld   A, H                                          ;; 01:4ce0 $7c
    ld   [wD6B8_Text_GlyphPtrHi], A                                    ;; 01:4ce1 $ea $b8 $d6
    ret                                                ;; 01:4ce4 $c9

call_01_4ce5_Text_FormatByte:
; Writes A (0-255) into wD5A6_TextBuffer as decimal digits with no leading zeros,
; terminated by $80 on the last digit as the renderer expects.
;
; Each digit is produced by starting the cell at $2F and `inc [HL]` once per
; successful subtraction of 100 then 10, so the digit is built in place and the
; character codes for '0'-'9' must be contiguous from $30 - which they are, since
; call_01_4f41_Text_CharToGlyphIndex maps $30-$39 to glyphs $1B-$24
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

call_01_4d0a_Menu_StartGfxStream:
; Hands a graphics-stream script at HL to the vblank streamer described in
; bank00_home.asm - three header bytes (chunk count, rows per chunk, source
; bank) followed by (src, dest) pairs, one pair copied per frame. Spins until
; any script already running has finished, so menus can queue these back to
; back without tracking completion themselves
    ld   A, [wD6E2_GfxStream_ChunksRemaining]                                    ;; 01:4d0a $fa $e2 $d6
    and  A, A                                          ;; 01:4d0d $a7
    jr   NZ, call_01_4d0a_Menu_StartGfxStream                              ;; 01:4d0e $20 $fa
    ld   A, [HL+]                                      ;; 01:4d10 $2a
    ld   [wD6E2_GfxStream_ChunksRemaining], A                                    ;; 01:4d11 $ea $e2 $d6
    ld   A, [HL+]                                      ;; 01:4d14 $2a
    ld   [wD6E3_GfxStream_RowsPerChunk], A                                    ;; 01:4d15 $ea $e3 $d6
    ld   A, [HL+]                                      ;; 01:4d18 $2a
    ld   [wD6E4_GfxStream_SrcBank], A                                    ;; 01:4d19 $ea $e4 $d6
    ld   A, L                                          ;; 01:4d1c $7d
    ld   [wD6E9_GfxStream_ListPtrLo], A                                    ;; 01:4d1d $ea $e9 $d6
    ld   A, H                                          ;; 01:4d20 $7c
    ld   [wD6EA_GfxStream_ListPtrHi], A                                    ;; 01:4d21 $ea $ea $d6
    ret                                                ;; 01:4d24 $c9

call_01_4d25_Menu_TickHideSprites:
; Counts wD6D8_Menu_HideSpritesDelay down and erases the sprite group named by
; wD6D9 when it reaches zero. Touching any button forces the counter to 1 so
; that it fires on this same frame - that is what makes a prompt vanish the
; instant the player responds to it, rather than after the full delay.
; A delay of zero disables the whole thing
    ld   HL, wD6D8_Menu_HideSpritesDelay                                     ;; 01:4d25 $21 $d8 $d6
    ld   A, [HL]                                       ;; 01:4d28 $7e
    and  A, A                                          ;; 01:4d29 $a7
    ret  Z                                             ;; 01:4d2a $c8
    ld   A, [wD59F_RawInputs]                                    ;; 01:4d2b $fa $9f $d5
    and  A, A                                          ;; 01:4d2e $a7
    jr   Z, .jr_01_4d33                                ;; 01:4d2f $28 $02
    ld   [HL], $01                                     ;; 01:4d31 $36 $01
.jr_01_4d33:
    dec  [HL]                                          ;; 01:4d33 $35
    ret  NZ                                            ;; 01:4d34 $c0
    ld   A, [wD6D9_Menu_HideSpritesGroup]                                    ;; 01:4d35 $fa $d9 $d6
    jp   call_01_4d3b_Menu_EraseSpriteGroup                                  ;; 01:4d38 $c3 $3b $4d

call_01_4d3b_Menu_EraseSpriteGroup:
; Blanks a named group of sprites in shadow OAM. A is an index into
; data_01_5aa9_SpriteScriptTable, which points at a script in the same format
; call_01_4dc8_Menu_BuildSpriteBlock consumes - so erasing reuses the layout
; that drew it, walking the same rectangles and writing zeroes instead
    ld   DE, data_01_5aa9_SpriteScriptTable                              ;; 01:4d3b $11 $a9 $5a
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4d3e $cd $b9 $07
    ld   A, [HL+]                                      ;; 01:4d41 $2a
    cp   A, $ff                                        ;; 01:4d42 $fe $ff
    ret  Z                                             ;; 01:4d44 $c8
    push HL                                            ;; 01:4d45 $e5
    ld   L, A                                          ;; 01:4d46 $6f
    ld   H, $00                                        ;; 01:4d47 $26 $00
    add  HL, HL                                        ;; 01:4d49 $29
    add  HL, HL                                        ;; 01:4d4a $29
    ld   DE, wCC00_ShadowOAM                                     ;; 01:4d4b $11 $00 $cc
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

call_01_4d72_Menu_DrawCursor:
; Rebuilds the selection cursor's sprite every frame. The position is computed
; rather than stored: base + step x index, separately for row and column, using
; the four geometry bytes from the menu record. Repeated addition stands in for
; the multiply.
; Cursor id $12 is the password keyboard's highlight, which picks its tile from
; the cell under the cursor and blinks off bit 4 of wD6D6_Menu_BlinkCounter.
; $FF means this screen has no cursor and the routine does nothing
    ld   A, [wD6C1_Menu_CursorSpriteId]                                    ;; 01:4d72 $fa $c1 $d6
    cp   A, MENU_CURSOR_NONE                           ;; 01:4d75 $fe $ff
    ret  Z                                             ;; 01:4d77 $c8
    ld   C, $02                                        ;; 01:4d78 $0e $02
    ld   B, $05                                        ;; 01:4d7a $06 $05
    cp   A, MENU_CURSOR_PASSWORD                       ;; 01:4d7c $fe $12
    jr   NZ, .jr_01_4d92                               ;; 01:4d7e $20 $12
    call call_01_4f30_Password_GetCellTileIndex                                  ;; 01:4d80 $cd $30 $4f
    ld   C, A                                          ;; 01:4d83 $4f
    ld   A, [wD6D6_Menu_BlinkCounter]                  ;; 01:4d84 $fa $d6 $d6
    and  A, MENU_CURSOR_BLINK_BIT                      ;; 01:4d87 $e6 $10 ; alternates the highlight's palette
    jr   Z, .jr_01_4d8f                                ;; 01:4d89 $28 $04
    or   A, $06                                        ;; 01:4d8b $f6 $06
    jr   .jr_01_4d91                                   ;; 01:4d8d $18 $02
.jr_01_4d8f:
    or   A, $05                                        ;; 01:4d8f $f6 $05
.jr_01_4d91:
    ld   B, A                                          ;; 01:4d91 $47
.jr_01_4d92:
    ld   HL, wD6BC_MenuCursor_TileId                                     ;; 01:4d92 $21 $bc $d6
    ld   [HL], C                                       ;; 01:4d95 $71
    ld   HL, wD6BD_MenuCursor_Attributes                                     ;; 01:4d96 $21 $bd $d6
    ld   [HL], B                                       ;; 01:4d99 $70
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:4d9a $fa $e0 $d6
    ld   C, A                                          ;; 01:4d9d $4f
    inc  C                                             ;; 01:4d9e $0c
    ld   A, [wD691_Menu_CursorStepY]                                    ;; 01:4d9f $fa $91 $d6
    ld   B, A                                          ;; 01:4da2 $47
    ld   A, [wD68F_Menu_CursorBaseY]                                    ;; 01:4da3 $fa $8f $d6
    sub  A, B                                          ;; 01:4da6 $90
.jr_01_4da7:
    add  A, B                                          ;; 01:4da7 $80
    dec  C                                             ;; 01:4da8 $0d
    jr   NZ, .jr_01_4da7                               ;; 01:4da9 $20 $fc
    ld   [wD6BA_MenuCursor_Y], A                                    ;; 01:4dab $ea $ba $d6
    ld   A, [wD6DF_MenuSelectedColumn]                                    ;; 01:4dae $fa $df $d6
    ld   C, A                                          ;; 01:4db1 $4f
    inc  C                                             ;; 01:4db2 $0c
    ld   A, [wD690_Menu_CursorStepX]                                    ;; 01:4db3 $fa $90 $d6
    ld   B, A                                          ;; 01:4db6 $47
    ld   A, [wD68E_Menu_CursorBaseX]                                    ;; 01:4db7 $fa $8e $d6
    sub  A, B                                          ;; 01:4dba $90
.jr_01_4dbb:
    add  A, B                                          ;; 01:4dbb $80
    dec  C                                             ;; 01:4dbc $0d
    jr   NZ, .jr_01_4dbb                               ;; 01:4dbd $20 $fc
    ld   [wD6BB_MenuCursor_X], A                                    ;; 01:4dbf $ea $bb $d6
    ld   HL, wD6B9_MenuCursor_OamSlot                                     ;; 01:4dc2 $21 $b9 $d6
    jp   call_01_4dc8_Menu_BuildSpriteBlock                                    ;; 01:4dc5 $c3 $c8 $4d

call_01_4dc8_Menu_BuildSpriteBlock:
; Walks a sprite script at HL and emits the sprites into shadow OAM.
; First byte is the OAM slot to start writing at; then each entry is
;   Y, X, tile, attributes, width in 8px columns, height in pixels
; terminated by $FF. Y and X are stored relative to the visible screen, so $10
; and $08 are added back on. If bit 0 of the tile byte is set the rest of it is
; an index into wD5AA_Sprite_TileIdTable instead of a literal tile - that indirection is how the
; same script can draw a digit that changes at runtime
    ld   A, [HL+]                                      ;; 01:4dc8 $2a
    cp   A, SPRITE_SCRIPT_END                          ;; 01:4dc9 $fe $ff
    ret  Z                                             ;; 01:4dcb $c8
    ld   [wD6D5_Menu_OamSlot], A                                    ;; 01:4dcc $ea $d5 $d6
.jr_01_4dcf:
    ld   A, [HL+]                                      ;; 01:4dcf $2a
    cp   A, SPRITE_SCRIPT_END                          ;; 01:4dd0 $fe $ff
    ret  Z                                             ;; 01:4dd2 $c8
    add  A, $10                                        ;; 01:4dd3 $c6 $10
    ld   [wD5A6_TextBuffer], A                                    ;; 01:4dd5 $ea $a6 $d5
    ld   A, [HL+]                                      ;; 01:4dd8 $2a
    add  A, $08                                        ;; 01:4dd9 $c6 $08
    ld   [wD5A7_Sprite_X], A                                    ;; 01:4ddb $ea $a7 $d5
    ld   A, [HL+]                                      ;; 01:4dde $2a
    bit  0, A                                          ;; 01:4ddf $cb $47
    jr   Z, .jr_01_4def                                ;; 01:4de1 $28 $0c
    push HL                                            ;; 01:4de3 $e5
    srl  A                                             ;; 01:4de4 $cb $3f
    ld   E, A                                          ;; 01:4de6 $5f
    ld   D, $00                                        ;; 01:4de7 $16 $00
    ld   HL, wD5AA_Sprite_TileIdTable                                     ;; 01:4de9 $21 $aa $d5
    add  HL, DE                                        ;; 01:4dec $19
    ld   A, [HL]                                       ;; 01:4ded $7e
    pop  HL                                            ;; 01:4dee $e1
.jr_01_4def:
    ld   [wD5A8_Sprite_TileId], A                                    ;; 01:4def $ea $a8 $d5
    ld   A, [HL+]                                      ;; 01:4df2 $2a
    ld   [wD5A9_Sprite_Attributes], A                                    ;; 01:4df3 $ea $a9 $d5
    ld   C, [HL]                                       ;; 01:4df6 $4e
    inc  HL                                            ;; 01:4df7 $23
    ld   B, [HL]                                       ;; 01:4df8 $46
    inc  HL                                            ;; 01:4df9 $23
    push HL                                            ;; 01:4dfa $e5
    call call_01_4e01_Menu_WriteSpriteRect                                  ;; 01:4dfb $cd $01 $4e
    pop  HL                                            ;; 01:4dfe $e1
    jr   .jr_01_4dcf                                   ;; 01:4dff $18 $ce

call_01_4e01_Menu_WriteSpriteRect:
; Emits one rectangle of 8x16 sprites, C columns wide and B pixels tall,
; starting at the OAM slot in wD6D5_Menu_OamSlot and advancing it. Tiles run
; down each column before moving right, stepping the tile id by 2 (8x16 sprites
; use tile pairs) and Y by $10
    ld   HL, wD6D5_Menu_OamSlot                                     ;; 01:4e01 $21 $d5 $d6
    ld   L, [HL]                                       ;; 01:4e04 $6e
    ld   H, $00                                        ;; 01:4e05 $26 $00
    add  HL, HL                                        ;; 01:4e07 $29
    add  HL, HL                                        ;; 01:4e08 $29
    ld   DE, wCC00_ShadowOAM                                     ;; 01:4e09 $11 $00 $cc
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
    ld   A, [wD5A7_Sprite_X]                                    ;; 01:4e20 $fa $a7 $d5
    ld   [HL+], A                                      ;; 01:4e23 $22
    ld   A, [wD5A8_Sprite_TileId]                                    ;; 01:4e24 $fa $a8 $d5
    ld   [HL+], A                                      ;; 01:4e27 $22
    add  A, SPRITE_TILE_STEP                           ;; 01:4e28 $c6 $02
    ld   [wD5A8_Sprite_TileId], A                                    ;; 01:4e2a $ea $a8 $d5
    ld   A, [wD5A9_Sprite_Attributes]                                    ;; 01:4e2d $fa $a9 $d5
    ld   [HL+], A                                      ;; 01:4e30 $22
    ld   A, [wD6D5_Menu_OamSlot]                                    ;; 01:4e31 $fa $d5 $d6
    inc  A                                             ;; 01:4e34 $3c
    ld   [wD6D5_Menu_OamSlot], A                                    ;; 01:4e35 $ea $d5 $d6
    dec  B                                             ;; 01:4e38 $05
    jr   NZ, .jr_01_4e17                               ;; 01:4e39 $20 $dc
    ld   A, [wD5A7_Sprite_X]                                    ;; 01:4e3b $fa $a7 $d5
    add  A, $08                                        ;; 01:4e3e $c6 $08
    ld   [wD5A7_Sprite_X], A                                    ;; 01:4e40 $ea $a7 $d5
    pop  AF                                            ;; 01:4e43 $f1
    pop  BC                                            ;; 01:4e44 $c1
    dec  C                                             ;; 01:4e45 $0d
    jr   NZ, .jr_01_4e12                               ;; 01:4e46 $20 $ca
    ret                                                ;; 01:4e48 $c9

call_01_4e49_Menu_GetVramAddrForDestTile:
; DE = VRAM address of the tile whose index is in wD696_MenuCmd_FirstTileId (index x 16 + $8000)
    ld   HL, wD696_MenuCmd_FirstTileId                                     ;; 01:4e49 $21 $96 $d6
    ld   L, [HL]                                       ;; 01:4e4c $6e
    ld   H, $00                                        ;; 01:4e4d $26 $00
    add  HL, HL                                        ;; 01:4e4f $29
    add  HL, HL                                        ;; 01:4e50 $29
    add  HL, HL                                        ;; 01:4e51 $29
    add  HL, HL                                        ;; 01:4e52 $29
    ld   DE, _VRAM                                     ;; 01:4e53 $11 $00 $80
    add  HL, DE                                        ;; 01:4e56 $19
    ld   E, L                                          ;; 01:4e57 $5d
    ld   D, H                                          ;; 01:4e58 $54
    ret                                                ;; 01:4e59 $c9

call_01_4e5a_Menu_GetTileDataSize:
; BC = number of bytes of tile graphics for a wD692_Text_BlockWidthTiles x wD693_Text_BlockHeightTiles block of tiles,
; that is width x height x 16. The multiply is repeated addition
    ld   HL, wD692_Text_BlockWidthTiles                                     ;; 01:4e5a $21 $92 $d6
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

call_01_4e6f_Menu_SetScriptSrcPtr:
; Stores HL as the current menu command's source pointer
    ld   A, L                                          ;; 01:4e6f $7d
    ld   [wD69B_Text_SrcPtrLo], A                                    ;; 01:4e70 $ea $9b $d6
    ld   A, H                                          ;; 01:4e73 $7c
    ld   [wD69C_Text_SrcPtrHi], A                                    ;; 01:4e74 $ea $9c $d6
    ret                                                ;; 01:4e77 $c9

call_01_4e78_Menu_StageTileData:
; Reads a width/height pair from the script at HL, works out how many bytes of
; tile graphics that is, and stages them at wC000 - which is the background map
; buffer during gameplay but free scratch while a menu is up. The byte after
; the pair gates the copy; nonzero means skip it
    ld   A, [wD69A_Text_FontId]                                    ;; 01:4e78 $fa $9a $d6
    ld   [wD696_MenuCmd_FirstTileId], A                                    ;; 01:4e7b $ea $96 $d6
    ld   A, [HL+]                                      ;; 01:4e7e $2a
    ld   [wD692_Text_BlockWidthTiles], A                                    ;; 01:4e7f $ea $92 $d6
    ld   A, [HL+]                                      ;; 01:4e82 $2a
    ld   [wD693_Text_BlockHeightTiles], A                                    ;; 01:4e83 $ea $93 $d6
    push HL                                            ;; 01:4e86 $e5
    call call_01_4e5a_Menu_GetTileDataSize                                  ;; 01:4e87 $cd $5a $4e
    pop  HL                                            ;; 01:4e8a $e1
    ld   DE, wC000_BgMapTileIds                                     ;; 01:4e8b $11 $00 $c0
    ld   A, [HL+]                                      ;; 01:4e8e $2a
    and  A, A                                          ;; 01:4e8f $a7
    jp   Z, call_00_07b0_MemCopy                               ;; 01:4e90 $ca $b0 $07
    ret                                                ;; 01:4e93 $c9

call_01_4e94_Menu_WaitForNoInput:
; Blocks until the player is not holding anything, keeping the menu alive
; meanwhile - cursor redrawn, timers ticked, one frame per iteration. Called
; after loading a screen so that the button that opened it does not
; immediately act on it.
; On the password keyboard A and B are excluded from the test, because those
; are the keys used to type and waiting for them would stall
    call call_01_4d72_Menu_DrawCursor                                  ;; 01:4e94 $cd $72 $4d
    call call_01_4d25_Menu_TickHideSprites                                  ;; 01:4e97 $cd $25 $4d
    call call_00_0ab4_WaitForInterrupt                                  ;; 01:4e9a $cd $b4 $0a
    ld   HL, wD6D6_Menu_BlinkCounter                                     ;; 01:4e9d $21 $d6 $d6
    dec  [HL]                                          ;; 01:4ea0 $35
    ld   A, [wD68C_Menu_Flags]                                    ;; 01:4ea1 $fa $8c $d6
    and  A, MENU_FLAG_GRID_CURSOR                      ;; 01:4ea4 $e6 $02
    ld   A, [wD59F_RawInputs]                                    ;; 01:4ea6 $fa $9f $d5
    jr   Z, .jr_01_4ead                                ;; 01:4ea9 $28 $02
    and  A, PADF_SELECT | PADF_START | PADF_RIGHT | PADF_LEFT | PADF_UP | PADF_DOWN    ;; 01:4eab $e6 $fc
.jr_01_4ead:
    and  A, A                                          ;; 01:4ead $a7
    jr   NZ, call_01_4e94_Menu_WaitForNoInput                              ;; 01:4eae $20 $e4
    ret                                                ;; 01:4eb0 $c9

call_01_4eb1_Menu_IsMissionRemoteCollected:
; A = mission slot 0-2. Returns NZ if that mission's remote has already been
; collected in the current level, so the mission select screen can grey it out.
; In a bonus level there is only one objective, so it tests the
; REMOTE_BONUS_MASK bit instead of the per-mission bits
    ld   E, A                                          ;; 01:4eb1 $5f
    ld   D, $00                                        ;; 01:4eb2 $16 $00
    ld   HL, .data_01_4ecc_MissionRemoteMasks                             ;; 01:4eb4 $21 $cc $4e
    add  HL, DE                                        ;; 01:4eb7 $19
    ld   B, [HL]                                       ;; 01:4eb8 $46
    ld   A, [wD623_CollectibleMode]                                    ;; 01:4eb9 $fa $23 $d6
    and  A, A                                          ;; 01:4ebc $a7
    jr   Z, .jr_01_4ec1                                ;; 01:4ebd $28 $02
    ld   B, REMOTE_BONUS_MASK                          ;; 01:4ebf $06 $20
.jr_01_4ec1:
    ld   HL, wD624_CurrentLevelId                                     ;; 01:4ec1 $21 $24 $d6
    ld   E, [HL]                                       ;; 01:4ec4 $5e
    ld   HL, wD629_RemoteProgressFlags                                     ;; 01:4ec5 $21 $29 $d6
    add  HL, DE                                        ;; 01:4ec8 $19
    ld   A, B                                          ;; 01:4ec9 $78
    and  A, [HL]                                       ;; 01:4eca $a6
    ret                                                ;; 01:4ecb $c9
.data_01_4ecc_MissionRemoteMasks:
; wD629_RemoteProgressFlags bit for mission slot 0, 1 and 2 - the low three bits,
; which together are REMOTE_MISSION_MASK
    db   $01, $02, $04                                 ;; 01:4ecc ...

call_01_4ecf_Password_RefreshCellGfx:
; Redraws the one keyboard cell the player just typed into. Queues a one-chunk
; graphics stream copying four tiles from the font at data_01_71e9_PasswordFont to the VRAM
; tiles that cell occupies. Only the edited cell is touched, so typing does not
; disturb the rest of the screen
    ld   A, [wD6E2_GfxStream_ChunksRemaining]                                    ;; 01:4ecf $fa $e2 $d6
    and  A, A                                          ;; 01:4ed2 $a7
    jr   NZ, call_01_4ecf_Password_RefreshCellGfx                              ;; 01:4ed3 $20 $fa
    ld   A, $01                                        ;; 01:4ed5 $3e $01
    ld   [wD6E2_GfxStream_ChunksRemaining], A                                    ;; 01:4ed7 $ea $e2 $d6
    ld   A, $04                                        ;; 01:4eda $3e $04
    ld   [wD6E3_GfxStream_RowsPerChunk], A                                    ;; 01:4edc $ea $e3 $d6
    ld   A, $01                                        ;; 01:4edf $3e $01
    ld   [wD6E4_GfxStream_SrcBank], A                                    ;; 01:4ee1 $ea $e4 $d6
    call call_01_4f1b_Password_GetCellUnderCursor                                  ;; 01:4ee4 $cd $1b $4f
    call call_01_4f41_Text_CharToGlyphIndex                                  ;; 01:4ee7 $cd $41 $4f
    ld   L, A                                          ;; 01:4eea $6f
    ld   H, $00                                        ;; 01:4eeb $26 $00
    add  HL, HL                                        ;; 01:4eed $29
    add  HL, HL                                        ;; 01:4eee $29
    add  HL, HL                                        ;; 01:4eef $29
    add  HL, HL                                        ;; 01:4ef0 $29
    add  HL, HL                                        ;; 01:4ef1 $29
    add  HL, HL                                        ;; 01:4ef2 $29
    ld   DE, data_01_71e9_PasswordFont                              ;; 01:4ef3 $11 $e9 $71
    add  HL, DE                                        ;; 01:4ef6 $19
    ld   A, L                                          ;; 01:4ef7 $7d
    ld   [wD6E5_GfxStream_SrcPtrLo], A                                    ;; 01:4ef8 $ea $e5 $d6
    ld   A, H                                          ;; 01:4efb $7c
    ld   [wD6E6_GfxStream_SrcPtrHi], A                                    ;; 01:4efc $ea $e6 $d6
    call call_01_4f30_Password_GetCellTileIndex                                  ;; 01:4eff $cd $30 $4f
    ld   L, A                                          ;; 01:4f02 $6f
    ld   H, $00                                        ;; 01:4f03 $26 $00
    add  HL, HL                                        ;; 01:4f05 $29
    add  HL, HL                                        ;; 01:4f06 $29
    add  HL, HL                                        ;; 01:4f07 $29
    add  HL, HL                                        ;; 01:4f08 $29
    ld   DE, _VRAM                                     ;; 01:4f09 $11 $00 $80
    add  HL, DE                                        ;; 01:4f0c $19
    ld   A, L                                          ;; 01:4f0d $7d
    ld   [wD6E7_GfxStream_DestPtrLo], A                                    ;; 01:4f0e $ea $e7 $d6
    ld   A, H                                          ;; 01:4f11 $7c
    ld   [wD6E8_GfxStream_DestPtrHi], A                                    ;; 01:4f12 $ea $e8 $d6
    ld   HL, wD6E2_GfxStream_ChunksRemaining                                     ;; 01:4f15 $21 $e2 $d6
    jp   call_01_4d0a_Menu_StartGfxStream                                  ;; 01:4f18 $c3 $0a $4d

call_01_4f1b_Password_GetCellUnderCursor:
; HL = address of the highlighted keyboard cell, A = its current character.
; The cells are one flat array from wD667_PasswordExitButton, indexed
; row x 6 + column
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

call_01_4f30_Password_GetCellTileIndex:
; A = index of the first VRAM tile backing the highlighted cell. Each cell is
; four tiles wide in the tile map, and the keyboard's tiles start at $3E
    ld   A, [wD6E0_MenuSelectedRow]                                    ;; 01:4f30 $fa $e0 $d6
    add  A, A                                          ;; 01:4f33 $87
    ld   L, A                                          ;; 01:4f34 $6f
    add  A, A                                          ;; 01:4f35 $87
    add  A, L                                          ;; 01:4f36 $85
    ld   L, A                                          ;; 01:4f37 $6f
    ld   A, [wD6DF_MenuSelectedColumn]                                    ;; 01:4f38 $fa $df $d6
    add  A, L                                          ;; 01:4f3b $85
    add  A, A                                          ;; 01:4f3c $87
    add  A, A                                          ;; 01:4f3d $87 ; x PASSWORD_CELL_TILE_WIDTH
    add  A, PASSWORD_KEYBOARD_TILE_BASE                ;; 01:4f3e $c6 $3e
    ret                                                ;; 01:4f40 $c9

call_01_4f41_Text_CharToGlyphIndex:
; Maps a character code to its glyph index within the current font. Used by the whole
; text path (call_01_4c81_Text_MeasureLine, call_01_4cab_Text_SelectGlyph) and not
; just by the password screens - the table is indexed from PASSWORD_KEY_BLANK because
; that is also TEXT_SPACE, the lowest code any string can contain.
;
; The result is a glyph index, not a VRAM tile id: $00 space, $01-$1A A-Z, $1B-$24
; 0-9, $25-$29 punctuation. Entries of $00 are codes with no glyph of their own
    sub  A, PASSWORD_KEY_BLANK                         ;; 01:4f41 $d6 $20
    ld   E, A                                          ;; 01:4f43 $5f
    ld   D, $00                                        ;; 01:4f44 $16 $00
    ld   HL, .data_01_4f4c_CharToGlyph                             ;; 01:4f46 $21 $4c $4f
    add  HL, DE                                        ;; 01:4f49 $19
    ld   A, [HL]                                       ;; 01:4f4a $7e
    ret                                                ;; 01:4f4b $c9
.data_01_4f4c_CharToGlyph:
; Glyph index for each character code from PASSWORD_KEY_BLANK ($20, the space)
; up to 'Z'. Character codes are plain ASCII, so this is really an ASCII table
; with the gaps knocked out: $00 means "no glyph of its own", which covers every
; punctuation mark the fonts do not draw
    db   $00, $27, $00, $00, $00, $00, $00, $29        ; $20 space ! " # $ % & '
    db   $00, $00, $00, $00, $26, $28, $25, $00        ; $28 ( ) * + , - . /
    db   $1b, $1c, $1d, $1e, $1f, $20, $21, $22        ; $30 digits 0-7
    db   $23, $24, $00, $00, $00, $00, $00, $00        ; $38 digits 8-9, then : ; < = > ?
    db   $00, $01, $02, $03, $04, $05, $06, $07        ; $40 @, then A-G
    db   $08, $09, $0a, $0b, $0c, $0d, $0e, $0f        ; $48 H-O
    db   $10, $11, $12, $13, $14, $15, $16, $17        ; $50 P-W
    db   $18, $19, $1a                                 ; $58 X-Z

call_01_4f87_Password_ClearEntryGrid:
; Wipes the keyboard back to 28 blank boxes, ready for the player to type into.
; The counterpart of call_01_4fa5_Password_Encode, which runs the same fill but
; then writes the player's CURRENT password into the grid to show them.
;
; The wipe is an overlapping-copy fill: DE is HL+1, so MemCopy reads each byte it
; has just written and propagates the single seed byte at wD667 through all 29
; cells. It is a fill written as a copy, not a copy - easy to misread as moving
; the exit button into the password boxes.
;
; That covers the exit button plus the 28 boxes; the three fixed keys are then
; stamped back over the blanks. wD667 is blanked and immediately rewritten, which
; is redundant but harmless.
;
; Called before both password screens, so backing out of "wrong password" starts
; from an empty grid rather than leaving the bad guess on screen
    ld   HL, wD667_PasswordExitButton                                     ;; 01:4f87 $21 $67 $d6
    ld   DE, wD668_PasswordValues                                     ;; 01:4f8a $11 $68 $d6
    ld   BC, PASSWORD_BOX_COUNT + 1                    ;; 01:4f8d $01 $1d $00 ; exit + 28 boxes
    ld   [HL], PASSWORD_KEY_BLANK                      ;; 01:4f90 $36 $20 ; seed for the fill
    call call_00_07b0_MemCopy                                  ;; 01:4f92 $cd $b0 $07
    ld   A, PASSWORD_KEY_EXIT                                        ;; 01:4f95 $3e $49
    ld   [wD667_PasswordExitButton], A                                    ;; 01:4f97 $ea $67 $d6
    ld   A, PASSWORD_KEY_GO                                        ;; 01:4f9a $3e $4a
    ld   [wD684_PasswordGoButton], A                                    ;; 01:4f9c $ea $84 $d6
    ld   A, PASSWORD_KEY_UNKNOWN                                        ;; 01:4f9f $3e $4b
    ld   [wD685_PasswordUnkButton], A                                    ;; 01:4fa1 $ea $85 $d6
    ret                                                ;; 01:4fa4 $c9

call_01_4fa5_Password_Encode:
; Turns the packed payload in wD652_Password_EncodeBuffer into the 28 letters the
; player is shown. Blanks the grid, scatters the payload bits into the boxes, then
; adds PASSWORD_CHAR_BASE to turn each 0-7 value into A-H.
;
; Shares its opening fill with call_01_4f87_Password_ClearEntryGrid - same
; overlapping MemCopy, but seeded $00 instead of PASSWORD_KEY_BLANK, because these
; boxes are about to be overwritten with values rather than left empty.
;
; The scatter is table driven where the decoder is a loop:
; .data_01_4fef_Password_BitMap holds one 8-byte entry per bit,
; (src addr, src mask, dst addr, dst mask), and the walk ends on a null source.
; The table does not reorder anything - sources and destinations both advance in
; step - so this is the same MSB-first packing
; call_01_5271_Password_DecodeAndApply undoes, just written out longhand instead
; of rolled into a loop
    ld   HL, wD667_PasswordExitButton                                     ;; 01:4fa5 $21 $67 $d6
    ld   DE, wD668_PasswordValues                                     ;; 01:4fa8 $11 $68 $d6
    ld   BC, PASSWORD_BOX_COUNT + 1                    ;; 01:4fab $01 $1d $00
    ld   [HL], $00                                     ;; 01:4fae $36 $00 ; seed for the fill
    call call_00_07b0_MemCopy                                  ;; 01:4fb0 $cd $b0 $07
    ld   A, PASSWORD_KEY_EXIT                          ;; 01:4fb3 $3e $49
    ld   [wD667_PasswordExitButton], A                                    ;; 01:4fb5 $ea $67 $d6
    ld   A, PASSWORD_KEY_GO                            ;; 01:4fb8 $3e $4a
    ld   [wD684_PasswordGoButton], A                                    ;; 01:4fba $ea $84 $d6
    ld   A, PASSWORD_KEY_UNKNOWN                       ;; 01:4fbd $3e $4b
    ld   [wD685_PasswordUnkButton], A                                    ;; 01:4fbf $ea $85 $d6
    ld   HL, .data_01_4fef_Password_BitMap                             ;; 01:4fc2 $21 $ef $4f
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
    ld   B, PASSWORD_BOX_COUNT                         ;; 01:4fe5 $06 $1c
.jr_01_4fe7:
    ld   A, [HL]                                       ;; 01:4fe7 $7e
    add  A, PASSWORD_CHAR_BASE                         ;; 01:4fe8 $c6 $41
    ld   [HL+], A                                      ;; 01:4fea $22
    dec  B                                             ;; 01:4feb $05
    jr   NZ, .jr_01_4fe7                               ;; 01:4fec $20 $f9
    ret                                                ;; 01:4fee $c9
.data_01_4fef_Password_BitMap:
; One entry per bit of the payload, 8 bytes each:
;   dw source address, dw source mask, dw dest address, dw dest mask
; A null source address ends the table. Only the low byte of each mask is read,
; so the words are really bytes with padding.
;
; The destination masks cycle $04, $02, $01 - the three bits of one password box -
; so consecutive entries fill a box MSB first, and a box is finished every third
; entry. Reading down the source column shows the payload walked in order too,
; which means this table is not actually a scramble; it is a straight bit copy
; written out longhand

    password_bit wD652_Password_EncodeBuffer,           $0080,   wD668_PasswordValues,            $0004
    password_bit wD652_Password_EncodeBuffer,           $0040,   wD668_PasswordValues,            $0002
    password_bit wD652_Password_EncodeBuffer,           $0020,   wD668_PasswordValues,            $0001
    password_bit wD652_Password_EncodeBuffer,           $0010,   wD668_PasswordValues+1,          $0004
    password_bit wD652_Password_EncodeBuffer,           $0008,   wD668_PasswordValues+1,          $0002
    password_bit wD652_Password_EncodeBuffer,           $0004,   wD668_PasswordValues+1,          $0001
    password_bit wD652_Password_EncodeBuffer,           $0002,   wD668_PasswordValues+2,          $0004
    password_bit wD652_Password_EncodeBuffer,           $0001,   wD668_PasswordValues+2,          $0002
    password_bit wD652_Password_EncodeBuffer+1,         $0080,   wD668_PasswordValues+2,          $0001
    password_bit wD652_Password_EncodeBuffer+1,         $0040,   wD668_PasswordValues+3,          $0004
    password_bit wD652_Password_EncodeBuffer+1,         $0020,   wD668_PasswordValues+3,          $0002
    password_bit wD652_Password_EncodeBuffer+1,         $0010,   wD668_PasswordValues+3,          $0001
    password_bit wD652_Password_EncodeBuffer+1,         $0008,   wD668_PasswordValues+4,          $0004
    password_bit wD652_Password_EncodeBuffer+1,         $0004,   wD668_PasswordValues+4,          $0002
    password_bit wD652_Password_EncodeBuffer+1,         $0002,   wD668_PasswordValues+4,          $0001
    password_bit wD652_Password_EncodeBuffer+1,         $0001,   wD668_PasswordValues+5,          $0004
    password_bit wD652_Password_EncodeBuffer+2,         $0080,   wD668_PasswordValues+5,          $0002
    password_bit wD652_Password_EncodeBuffer+2,         $0040,   wD668_PasswordValues+5,          $0001
    password_bit wD652_Password_EncodeBuffer+2,         $0020,   wD668_PasswordValues+6,          $0004
    password_bit wD652_Password_EncodeBuffer+2,         $0010,   wD668_PasswordValues+6,          $0002
    password_bit wD652_Password_EncodeBuffer+2,         $0008,   wD668_PasswordValues+6,          $0001
    password_bit wD652_Password_EncodeBuffer+2,         $0004,   wD668_PasswordValues+7,          $0004
    password_bit wD652_Password_EncodeBuffer+2,         $0002,   wD668_PasswordValues+7,          $0002
    password_bit wD652_Password_EncodeBuffer+2,         $0001,   wD668_PasswordValues+7,          $0001
    password_bit wD652_Password_EncodeBuffer+3,         $0080,   wD668_PasswordValues+8,          $0004
    password_bit wD652_Password_EncodeBuffer+3,         $0040,   wD668_PasswordValues+8,          $0002
    password_bit wD652_Password_EncodeBuffer+3,         $0020,   wD668_PasswordValues+8,          $0001
    password_bit wD652_Password_EncodeBuffer+3,         $0010,   wD668_PasswordValues+9,          $0004
    password_bit wD652_Password_EncodeBuffer+3,         $0008,   wD668_PasswordValues+9,          $0002
    password_bit wD652_Password_EncodeBuffer+3,         $0004,   wD668_PasswordValues+9,          $0001
    password_bit wD652_Password_EncodeBuffer+3,         $0002,   wD668_PasswordValues+10,         $0004
    password_bit wD652_Password_EncodeBuffer+3,         $0001,   wD668_PasswordValues+10,         $0002
    password_bit wD652_Password_EncodeBuffer+4,         $0080,   wD668_PasswordValues+10,         $0001
    password_bit wD652_Password_EncodeBuffer+4,         $0040,   wD668_PasswordValues+11,         $0004
    password_bit wD652_Password_EncodeBuffer+4,         $0020,   wD668_PasswordValues+11,         $0002
    password_bit wD652_Password_EncodeBuffer+4,         $0010,   wD668_PasswordValues+11,         $0001
    password_bit wD652_Password_EncodeBuffer+4,         $0008,   wD668_PasswordValues+12,         $0004
    password_bit wD652_Password_EncodeBuffer+4,         $0004,   wD668_PasswordValues+12,         $0002
    password_bit wD652_Password_EncodeBuffer+4,         $0002,   wD668_PasswordValues+12,         $0001
    password_bit wD652_Password_EncodeBuffer+4,         $0001,   wD668_PasswordValues+13,         $0004
    password_bit wD652_Password_EncodeBuffer+5,         $0080,   wD668_PasswordValues+13,         $0002
    password_bit wD652_Password_EncodeBuffer+5,         $0040,   wD668_PasswordValues+13,         $0001
    password_bit wD652_Password_EncodeBuffer+5,         $0020,   wD668_PasswordValues+14,         $0004
    password_bit wD652_Password_EncodeBuffer+5,         $0010,   wD668_PasswordValues+14,         $0002
    password_bit wD652_Password_EncodeBuffer+5,         $0008,   wD668_PasswordValues+14,         $0001
    password_bit wD652_Password_EncodeBuffer+5,         $0004,   wD668_PasswordValues+15,         $0004
    password_bit wD652_Password_EncodeBuffer+5,         $0002,   wD668_PasswordValues+15,         $0002
    password_bit wD652_Password_EncodeBuffer+5,         $0001,   wD668_PasswordValues+15,         $0001
    password_bit wD652_Password_EncodeBuffer+6,         $0080,   wD668_PasswordValues+16,         $0004
    password_bit wD652_Password_EncodeBuffer+6,         $0040,   wD668_PasswordValues+16,         $0002
    password_bit wD652_Password_EncodeBuffer+6,         $0020,   wD668_PasswordValues+16,         $0001
    password_bit wD652_Password_EncodeBuffer+6,         $0010,   wD668_PasswordValues+17,         $0004
    password_bit wD652_Password_EncodeBuffer+6,         $0008,   wD668_PasswordValues+17,         $0002
    password_bit wD652_Password_EncodeBuffer+6,         $0004,   wD668_PasswordValues+17,         $0001
    password_bit wD652_Password_EncodeBuffer+6,         $0002,   wD668_PasswordValues+18,         $0004
    password_bit wD652_Password_EncodeBuffer+6,         $0001,   wD668_PasswordValues+18,         $0002
    password_bit wD652_Password_EncodeBuffer+7,         $0080,   wD668_PasswordValues+18,         $0001
    password_bit wD652_Password_EncodeBuffer+7,         $0040,   wD668_PasswordValues+19,         $0004
    password_bit wD652_Password_EncodeBuffer+7,         $0020,   wD668_PasswordValues+19,         $0002
    password_bit wD652_Password_EncodeBuffer+7,         $0010,   wD668_PasswordValues+19,         $0001
    password_bit wD652_Password_EncodeBuffer+7,         $0008,   wD668_PasswordValues+20,         $0004
    password_bit wD652_Password_EncodeBuffer+7,         $0004,   wD668_PasswordValues+20,         $0002
    password_bit wD652_Password_EncodeBuffer+7,         $0002,   wD668_PasswordValues+20,         $0001
    password_bit wD652_Password_EncodeBuffer+7,         $0001,   wD668_PasswordValues+21,         $0004
    password_bit wD652_Password_EncodeBuffer+8,         $0080,   wD668_PasswordValues+21,         $0002
    password_bit wD652_Password_EncodeBuffer+8,         $0040,   wD668_PasswordValues+21,         $0001
    password_bit wD652_Password_EncodeBuffer+8,         $0020,   wD668_PasswordValues+22,         $0004
    password_bit wD652_Password_EncodeBuffer+8,         $0010,   wD668_PasswordValues+22,         $0002
    password_bit wD652_Password_EncodeBuffer+8,         $0008,   wD668_PasswordValues+22,         $0001
    password_bit wD652_Password_EncodeBuffer+8,         $0004,   wD668_PasswordValues+23,         $0004
    password_bit wD652_Password_EncodeBuffer+8,         $0002,   wD668_PasswordValues+23,         $0002
    password_bit wD652_Password_EncodeBuffer+8,         $0001,   wD668_PasswordValues+23,         $0001
    password_bit wD652_Password_EncodeBuffer+9,         $0080,   wD668_PasswordValues+24,         $0004
    password_bit wD652_Password_EncodeBuffer+9,         $0040,   wD668_PasswordValues+24,         $0002
    password_bit wD652_Password_EncodeBuffer+9,         $0020,   wD668_PasswordValues+24,         $0001
    password_bit wD652_Password_EncodeBuffer+9,         $0010,   wD668_PasswordValues+25,         $0004
    password_bit wD652_Password_EncodeBuffer+9,         $0008,   wD668_PasswordValues+25,         $0002
    password_bit wD652_Password_EncodeBuffer+9,         $0004,   wD668_PasswordValues+25,         $0001
    password_bit wD652_Password_EncodeBuffer+9,         $0002,   wD668_PasswordValues+26,         $0004
    password_bit wD652_Password_EncodeBuffer+9,         $0001,   wD668_PasswordValues+26,         $0002
    password_bit_end

call_01_5271_Password_DecodeAndApply:
; Validates a typed password and, if it passes, writes it into the live save
; state - hence AndApply: this does not just decode, it commits. The inverse of
; call_01_4349_Password_BuildPayload and call_01_4fa5_Password_Encode together.
;
; Rejects on either a blank box or a checksum mismatch, and returns a MENU_RESULT
; so the caller can swap in the "wrong password" screen. Nothing is written to the
; save state until both checks have passed.
;
; Unpacking is a plain bit loop where the encoder uses a table - subtract
; PASSWORD_CHAR_BASE to get 0-7, then shift the three bits out MSB first into
; wD65C_Password_DecodeBuffer, walking C as a rotating mask and stepping HL
; whenever it wraps. On success the payload is expanded back into
; wD629_RemoteProgressFlags level by level, mirroring the encoder's mask walk
    ; check if any of the boxes are blank. if so, it is an invalid password
    ld   HL, wD668_PasswordValues                      ;; 01:5271 $21 $68 $d6
    ld   B, PASSWORD_BOX_COUNT                         ;; 01:5274 $06 $1c ; 28 password boxes
.jr_01_5276:
    ld   A, [HL+]                                      ;; 01:5276 $2a
    cp   A, PASSWORD_KEY_BLANK                         ;; 01:5277 $fe $20
    jp   Z, .jp_01_531a                                ;; 01:5279 $ca $1a $53
    dec  B                                             ;; 01:527c $05
    jr   NZ, .jr_01_5276                               ;; 01:527d $20 $f7 
    ld   HL, wD65C_Password_DecodeBuffer                                     ;; 01:527f $21 $5c $d6 ; blank the payload plus its two trailing bytes
    ld   B, PASSWORD_PAYLOAD_BYTES + 1                 ;; 01:5282 $06 $0b
    xor  A, A                                          ;; 01:5284 $af ; a = 0
.jr_01_5285:
    ld   [HL+], A                                      ;; 01:5285 $22
    dec  B                                             ;; 01:5286 $05
    jr   NZ, .jr_01_5285                               ;; 01:5287 $20 $fc
    ld   HL, wD65C_Password_DecodeBuffer                                     ;; 01:5289 $21 $5c $d6 ; decode the password into wD65C_Password_DecodeBuffer array of 11 bytes
    ld   DE, wD668_PasswordValues                      ;; 01:528c $11 $68 $d6
    ld   A, PASSWORD_BOX_COUNT                         ;; 01:528f $3e $1c
    ld   C, $80                                        ;; 01:5291 $0e $80 ; 128
.jr_01_5293:
    push AF                                            ;; 01:5293 $f5
    push DE                                            ;; 01:5294 $d5
    ld   A, [DE]                                       ;; 01:5295 $1a ; a = value in password box
    sub  A, PASSWORD_CHAR_BASE                         ;; 01:5296 $d6 $41 ; 'A'-'H' becomes 0-7
    ld   E, A                                          ;; 01:5298 $5f
    ld   B, PASSWORD_BITS_PER_BOX                      ;; 01:5299 $06 $03
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
    ld   HL, wD65C_Password_DecodeBuffer                                     ;; 01:52b2 $21 $5c $d6 ; add up all the values into a
    ld   B, PASSWORD_CHECKSUM_BYTES                    ;; 01:52b5 $06 $09
    xor  A, A                                          ;; 01:52b7 $af
.jr_01_52b8:
    add  A, [HL]                                       ;; 01:52b8 $86
    inc  HL                                            ;; 01:52b9 $23
    dec  B                                             ;; 01:52ba $05
    jr   NZ, .jr_01_52b8                               ;; 01:52bb $20 $fb
    ld   HL, wD665_Password_DecodeChecksum                                     ;; 01:52bd $21 $65 $d6 ; invalid password if the sum of values is not equal to value in wD665_Password_DecodeChecksum
    cp   A, [HL]                                       ;; 01:52c0 $be
    jr   NZ, .jp_01_531a                               ;; 01:52c1 $20 $57
    ld   A, [wD664_Password_DecodeLives]                                    ;; 01:52c3 $fa $64 $d6 ; set lives to value in wD664_Password_DecodeLives
    ld   [wD73D_LivesRemaining], A                                    ;; 01:52c6 $ea $3d $d7
    ld   A, [wD624_CurrentLevelId]                     ;; 01:52c9 $fa $24 $d6 ; set current level to 0
    push AF                                            ;; 01:52cc $f5
    xor  A, A                                          ;; 01:52cd $af
    ld   [wD624_CurrentLevelId], A                                    ;; 01:52ce $ea $24 $d6
    ld   HL, wD65C_Password_DecodeBuffer                                     ;; 01:52d1 $21 $5c $d6 ; set remote bitfields
    ld   C, $80                                        ;; 01:52d4 $0e $80 ; rotating source-bit mask
.jr_01_52d6:
    push HL                                            ;; 01:52d6 $e5
    call call_00_2e43_MapData_GetRemoteProgressId                                  ;; 01:52d7 $cd $43 $2e
    ld   E, A                                          ;; 01:52da $5f
    ld   D, $00                                        ;; 01:52db $16 $00
    ld   HL, .data_01_531d_LevelPayloadMasks                             ;; 01:52dd $21 $1d $53
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
    cp   A, LEVEL_COUNT                                ;; 01:530f $fe $1e
    jr   NZ, .jr_01_52d6                               ;; 01:5311 $20 $c3
    pop  AF                                            ;; 01:5313 $f1
    ld   [wD624_CurrentLevelId], A ; set current level to 0                                   ;; 01:5314 $ea $24 $d6
    ld   A, MENU_RESULT_PASSWORD_GO                    ;; 01:5317 $3e $30
    ret                                                ;; 01:5319 $c9
.jp_01_531a:
    ld   A, MENU_RESULT_DISMISSED                      ;; 01:531a $3e $00
    ret                                                ;; 01:531c $c9
.data_01_531d_LevelPayloadMasks:
; A byte-for-byte duplicate of .data_01_43b6_LevelPayloadMasks - the encoder and
; the decoder each carry their own copy rather than sharing one
; One byte per remote progress id: which bits of that level's
; wD629_RemoteProgressFlags are worth saving in a password. A level with three
; missions plus both hidden remotes costs five bits; a bonus level costs one.
; That is how thirty levels fit into a 64-bit payload.
; call_01_5271_Password_DecodeAndApply keeps its own identical copy at
; .data_01_531d_LevelPayloadMasks
    db   $1f                                           ; id 0 - 3 missions + silver + gold
    db   $1b                                           ; id 1 - 2 missions + silver + gold
    db   $19                                           ; id 2 - 1 mission  + silver + gold
    db   $03                                           ; id 3 - 2 missions
    db   $01                                           ; id 4 - 1 mission
    db   $20                                           ; id 5 - bonus level, gold only
    db   $00                                           ; id 6 - the stats page, nothing to save

data_01_5324_MenuCmd_Descriptors:
; One 8-byte descriptor per menu script command id, copied to
; wD692_Text_BlockWidthTiles onward by call_01_44e6_MenuScript_RunCommand. The id
; fixes a rectangle's size, where it lands and which tiles it uses; the script's
; parameter block then says what goes in it. A screen's layout lives here and its
; content lives in its script, which is why one id is shared by every screen that
; wants the same box in the same place.
;
; Ids $00-$27 are the shapes the ordinary screens use, $28-$2B are dead, and
; $2C-$49 are the password keyboard.
;                       w,   h,   x,   y, tile, attr
;
; $00 is also the "shape does not matter" id: every block that exists only to run
; a sub-handler uses it with MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD, and
; every block that stages an image lets the staging handler overwrite the size
    menu_cmd_descriptor $06, $05, $01, $01, $06, MENUCMD_ATTR_TV_COPY ; $00  the Media Dimension TV picture
    menu_cmd_descriptor $0c, $03, $08, $01, $24, $01                  ; $01  mission select: the TV's name
    menu_cmd_descriptor $0c, $02, $08, $04, $48, $00                  ; $02  mission select: the level's name
    menu_cmd_descriptor $10, $02, $04, $07, $60, $00                  ; $03  mission select: row 0 of 3
    menu_cmd_descriptor $10, $02, $04, $0a, $80, $00                  ; $04  mission select: row 1 of 3, or the only row of 1
    menu_cmd_descriptor $10, $02, $04, $0d, $a0, $00                  ; $05  mission select: row 2 of 3
    menu_cmd_descriptor $10, $02, $04, $08, $60, $00                  ; $06  mission select: row 0 of 2
    menu_cmd_descriptor $10, $02, $04, $0c, $80, $00                  ; $07  mission select: row 1 of 2
    menu_cmd_descriptor $14, $02, $00, $10, $c0, $02                  ; $08  mission select: the footer prompt
    menu_cmd_descriptor $10, $02, $02, $05, $06, $00                  ; $09  pause menus: the current mission line
    menu_cmd_descriptor $14, $02, $00, $07, $26, $01                  ; $0a  pause menus: the heading
    menu_cmd_descriptor $08, $01, $06, $0a, $4e, $01                  ; $0b  pause menus: row 0
    menu_cmd_descriptor $08, $01, $06, $0b, $56, $01                  ; $0c  pause menus: row 1
;
; The title and audio option rows are all the same box in the same place, drawn
; one over another; only the cursor position says which row is selected
    menu_cmd_descriptor $08, $01, $02, $0a, $06, $00                  ; $0d  title and audio options: every row
;
; $0E and $0F are two more rows below $0D that no script draws
    menu_cmd_descriptor $08, $01, $02, $0c, $0e, $00                  ; $0e  unused
    menu_cmd_descriptor $08, $01, $02, $0e, $16, $00                  ; $0f  unused
    menu_cmd_descriptor $14, $02, $00, $08, $06, $01                  ; $10  "ENTERING..."
    menu_cmd_descriptor $14, $02, $00, $0a, $2e, $01                  ; $11  the level name under it
    menu_cmd_descriptor $0e, $02, $03, $00, $06, $00                  ; $12  game over totals: the heading
    menu_cmd_descriptor $0c, $01, $04, $03, $22, $00                  ; $13  totals: "RESUME PLAY"
    menu_cmd_descriptor $0c, $01, $04, $04, $2e, $00                  ; $14  totals: "SEE PASSWORD"
    menu_cmd_descriptor $0c, $01, $04, $05, $3a, $00                  ; $15  game over totals: "QUIT"
    menu_cmd_descriptor $10, $02, $02, $07, $46, $00                  ; $16  totals page heading, "GAME OVER", "TIME UP!"
    menu_cmd_descriptor $02, $02, $02, $0c, $66, $00                  ; $17  totals: the gex head
    menu_cmd_descriptor $02, $02, $10, $0c, $6a, $00                  ; $18  totals: the hand print
    menu_cmd_descriptor $01, $02, $07, $09, $6e, $00                  ; $19  totals: the "X" before the life count
    menu_cmd_descriptor $03, $02, $08, $09, $70, $00                  ; $1a  totals: lives
    menu_cmd_descriptor $01, $02, $0f, $09, $76, $00                  ; $1b  totals: health
    menu_cmd_descriptor $02, $02, $0b, $0b, $78, $00                  ; $1c  totals: mission remotes collected
    menu_cmd_descriptor $02, $02, $0b, $0d, $7c, $00                  ; $1d  totals: hidden remotes collected
    menu_cmd_descriptor $02, $02, $0b, $0f, $80, $00                  ; $1e  totals: bonus remotes collected
    menu_cmd_descriptor $10, $02, $02, $00, $06, $00                  ; $1f  congratulations: the heading
    menu_cmd_descriptor $12, $01, $01, $06, $26, $00                  ; $20  congratulations: the mission status line
    menu_cmd_descriptor $05, $01, $04, $0f, $38, $00                  ; $21  congratulations: "REWARD"
    menu_cmd_descriptor $05, $01, $0b, $0f, $3d, $00                  ; $22  congratulations: "HIDDEN"
    menu_cmd_descriptor $0e, $01, $03, $11, $42, $00                  ; $23  congratulations: "PRESS B TO CONTINUE"
    menu_cmd_descriptor $02, $02, $03, $09, $50, $00                  ; $24  congratulations: collectible milestone 1
    menu_cmd_descriptor $02, $02, $09, $09, $54, $00                  ; $25  congratulations: collectible milestone 2
    menu_cmd_descriptor $02, $02, $0f, $09, $58, $00                  ; $26  congratulations: collectible milestone 3
    menu_cmd_descriptor $03, $02, $09, $07, $90, $00                  ; $27  congratulations: the level's collectible icon
;
; $28-$2B are the password headings as tilemap blocks. The shipped game draws
; them as sprites instead (data_01_5c6f_SpriteScript_EnterPasswordHeader onward),
; so these four shapes survive with nothing pointing at them
    menu_cmd_descriptor $05, $02, $00, $00, $06, $05                  ; $28  unused
    menu_cmd_descriptor $07, $02, $0a, $00, $10, $05                  ; $29  unused
    menu_cmd_descriptor $07, $02, $00, $02, $1e, $05                  ; $2a  unused
    menu_cmd_descriptor $09, $02, $0a, $02, $2c, $05                  ; $2b  unused
;
; The password keyboard. 30 boxes, 6 across and 5 down, tiles running $3E..$B5
; four at a time - see MENUCMD_PASSWORD_CELL_BASE
    menu_cmd_descriptor $02, $02, $01, $02, $3e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 0   keyboard cell (column 0, row 0)
    menu_cmd_descriptor $02, $02, $04, $02, $42, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 1   keyboard cell (column 1, row 0)
    menu_cmd_descriptor $02, $02, $07, $02, $46, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 2   keyboard cell (column 2, row 0)
    menu_cmd_descriptor $02, $02, $0a, $02, $4a, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 3   keyboard cell (column 3, row 0)
    menu_cmd_descriptor $02, $02, $0d, $02, $4e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 4   keyboard cell (column 4, row 0)
    menu_cmd_descriptor $02, $02, $10, $02, $52, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 5   keyboard cell (column 5, row 0)
    menu_cmd_descriptor $02, $02, $01, $05, $56, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 6   keyboard cell (column 0, row 1)
    menu_cmd_descriptor $02, $02, $04, $05, $5a, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 7   keyboard cell (column 1, row 1)
    menu_cmd_descriptor $02, $02, $07, $05, $5e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 8   keyboard cell (column 2, row 1)
    menu_cmd_descriptor $02, $02, $0a, $05, $62, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 9   keyboard cell (column 3, row 1)
    menu_cmd_descriptor $02, $02, $0d, $05, $66, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 10  keyboard cell (column 4, row 1)
    menu_cmd_descriptor $02, $02, $10, $05, $6a, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 11  keyboard cell (column 5, row 1)
    menu_cmd_descriptor $02, $02, $01, $08, $6e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 12  keyboard cell (column 0, row 2)
    menu_cmd_descriptor $02, $02, $04, $08, $72, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 13  keyboard cell (column 1, row 2)
    menu_cmd_descriptor $02, $02, $07, $08, $76, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 14  keyboard cell (column 2, row 2)
    menu_cmd_descriptor $02, $02, $0a, $08, $7a, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 15  keyboard cell (column 3, row 2)
    menu_cmd_descriptor $02, $02, $0d, $08, $7e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 16  keyboard cell (column 4, row 2)
    menu_cmd_descriptor $02, $02, $10, $08, $82, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 17  keyboard cell (column 5, row 2)
    menu_cmd_descriptor $02, $02, $01, $0b, $86, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 18  keyboard cell (column 0, row 3)
    menu_cmd_descriptor $02, $02, $04, $0b, $8a, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 19  keyboard cell (column 1, row 3)
    menu_cmd_descriptor $02, $02, $07, $0b, $8e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 20  keyboard cell (column 2, row 3)
    menu_cmd_descriptor $02, $02, $0a, $0b, $92, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 21  keyboard cell (column 3, row 3)
    menu_cmd_descriptor $02, $02, $0d, $0b, $96, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 22  keyboard cell (column 4, row 3)
    menu_cmd_descriptor $02, $02, $10, $0b, $9a, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 23  keyboard cell (column 5, row 3)
    menu_cmd_descriptor $02, $02, $01, $0e, $9e, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 24  keyboard cell (column 0, row 4)
    menu_cmd_descriptor $02, $02, $04, $0e, $a2, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 25  keyboard cell (column 1, row 4)
    menu_cmd_descriptor $02, $02, $07, $0e, $a6, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 26  keyboard cell (column 2, row 4)
    menu_cmd_descriptor $02, $02, $0a, $0e, $aa, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 27  keyboard cell (column 3, row 4)
    menu_cmd_descriptor $02, $02, $0d, $0e, $ae, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 28  keyboard cell (column 4, row 4)
    menu_cmd_descriptor $02, $02, $10, $0e, $b2, $05                  ; MENUCMD_PASSWORD_CELL_BASE + 29  keyboard cell (column 5, row 4) - drawn by the chaining screen

data_01_5574_MenuTypeRecords:
; One 8-byte record per MENU_TYPE_*, copied into wD68A..wD691 by
; call_01_4000_MenuLoad. This table plus the script each entry points at is the
; entire definition of a menu; there is no per-screen code anywhere.
;
;   +0  dw  pointer to the menu's script
;   +2  db  MENU_FLAG_* behaviour flags
;   +3  db  number of selectable options (or keyboard cells)
;   +4  db  cursor base X       +6  db  cursor step X per column
;   +5  db  cursor base Y       +7  db  cursor step Y per row
;
; A few things fall out of reading the flags column. The four pause menus and
; the two totals screens are the only ones the player can back out of at will.
; Everything with MENU_FLAG_NO_CANCEL - the title cards, the credits, the
; mission select - can only be left by choosing something. And the four entries
; with no flags at all (title options, game over, black screen, time up) are
; the screens that leave on a timer, which is how the title drops into the
; attract-mode demo if you stand there long enough.
    ; $00 MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION
    menu_type_record data_01_5692_MenuScript_PausedInMediaDimension, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_START_DISMISSES, $02, $00, $00, $00, $00
    ; $01 MENU_TYPE_EXIT_GAME
    menu_type_record data_01_56ab_MenuScript_ExitGame, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_START_DISMISSES, $02, $00, $00, $00, $00
    ; $02 MENU_TYPE_PAUSED_IN_LEVEL
    menu_type_record data_01_56c4_MenuScript_PausedInLevel, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_START_DISMISSES, $02, $00, $00, $00, $00
    ; $03 MENU_TYPE_EXIT_TO_MAP
    menu_type_record data_01_56e5_MenuScript_ExitToMap, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_START_DISMISSES, $02, $00, $00, $00, $00
    ; $04 MENU_TYPE_GAME_OVER_TOTALS
    menu_type_record data_01_5706_MenuScript_GameOverTotals, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_SELECT_DISMISSES | MENU_FLAG_TOTALS_PAGING, $03, $00, $00, $00, $00
    ; $05 MENU_TYPE_VIEW_TOTALS
    menu_type_record data_01_571f_MenuScript_ViewTotals, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_START_OPENS_PAUSE | MENU_FLAG_SELECT_DISMISSES | MENU_FLAG_TOTALS_PAGING, $02, $00, $00, $00, $00
    ; $06 MENU_TYPE_VIEW_PASSWORD - grid, but nothing to type
    menu_type_record data_01_58ca_MenuScript_ViewPassword, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_GRID_CURSOR, $00, $08, $10, $18, $18
    ; $07 MENU_TYPE_TITLE_OPTIONS - times out into the demo
    menu_type_record data_01_57b1_MenuScript_TitleOptions, $00, $02, $00, $4c, $00, $0c
    ; $08 MENU_TYPE_ENTERING_LEVEL_NAME
    menu_type_record data_01_57ca_MenuScript_EnteringLevelName, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL | MENU_FLAG_DEMO_COUNTDOWN, $00, $00, $00, $00, $00
    ; $09 MENU_TYPE_MISSION_SELECT_1_OPTION
    menu_type_record data_01_57db_MenuScript_MissionSelect1, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $01, $00, $50, $00, $18
    ; $0A MENU_TYPE_MISSION_SELECT_2_OPTIONS
    menu_type_record data_01_57f4_MenuScript_MissionSelect2, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $02, $00, $40, $00, $20
    ; $0B MENU_TYPE_MISSION_SELECT_3_OPTIONS
    menu_type_record data_01_5815_MenuScript_MissionSelect3, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $03, $00, $38, $00, $18
    ; $0C MENU_TYPE_GAME_OVER
    menu_type_record data_01_5867_MenuScript_GameOver, $00, $00, $00, $00, $00, $00
    ; $0D MENU_TYPE_BLACK_SCREEN
    menu_type_record data_01_5870_MenuScript_BlackScreen, $00, $00, $00, $00, $00, $00
    ; $0E MENU_TYPE_CONGRATULATIONS
    menu_type_record data_01_5871_MenuScript_Congratulations, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $0F MENU_TYPE_ENTER_PASSWORD - 6 x 5 = $1E cells
    menu_type_record data_01_58eb_MenuScript_EnterPassword, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_GRID_CURSOR, $1e, $08, $10, $18, $18
    ; $10 MENU_TYPE_TITLE_SCREEN
    menu_type_record data_01_5a26_MenuScript_TitleScreen, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $11 MENU_TYPE_AUDIO_OPTIONS_UNUSED
    menu_type_record data_01_5a2f_MenuScript_AudioOptions, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $04, $00, $00, $00, $00
    ; $12 MENU_TYPE_CREDITS_GREAT_JOB
    menu_type_record data_01_5a58_MenuScript_CreditsGreatJob, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $13 MENU_TYPE_TITLE_CRAVE
    menu_type_record data_01_5a61_MenuScript_TitleCrave, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $14 MENU_TYPE_TITLE_SPLASH
    menu_type_record data_01_5a6a_MenuScript_TitleSplash, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $15 MENU_TYPE_ENTERED_INVALID_PASSWORD
    menu_type_record data_01_590c_MenuScript_InvalidPassword, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_GRID_CURSOR, $1e, $08, $10, $18, $18
    ; $16 MENU_TYPE_TITLE_DAVID
    menu_type_record data_01_5a73_MenuScript_TitleDavid, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $17 MENU_TYPE_CREDITS_1
    menu_type_record data_01_5a7c_MenuScript_Credits1, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $18 MENU_TYPE_CREDITS_2
    menu_type_record data_01_5a85_MenuScript_Credits2, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $19 MENU_TYPE_CREDITS_3
    menu_type_record data_01_5a8e_MenuScript_Credits3, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $1A MENU_TYPE_CREDITS_4
    menu_type_record data_01_5a97_MenuScript_Credits4, MENU_FLAG_WAIT_FOR_INPUT | MENU_FLAG_NO_CANCEL, $00, $00, $00, $00, $00
    ; $1B MENU_TYPE_TIME_UP - leaves on a timer
    menu_type_record data_01_5aa0_MenuScript_TimeUp, $00, $00, $00, $00, $00, $00

data_01_5654_MenuTypeLcdcAndPalette:
; Two bytes per MENU_TYPE_*, read by call_01_446f_LoadMenuGraphics once the
; script has finished drawing:
;
;   +0  db  LCDC value for the top of the screen -> wD6E1_RasterSplit_LCDCValue
;   +1  db  palette set id, passed in C to call_0b_5537_BgPalette_LoadMonoOrGetSpriteParams
;
; $D7 is the ordinary "BG + OBJ on, unsigned tiles" LCDC; the screens that use
; $C7 (the totals pages, the password keyboard, the credits) switch the window
; off for the split half of the frame
    db   $d7, $06                                       ; $00 MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION
    db   $d7, $06                                       ; $01 MENU_TYPE_EXIT_GAME
    db   $d7, $06                                       ; $02 MENU_TYPE_PAUSED_IN_LEVEL
    db   $d7, $06                                       ; $03 MENU_TYPE_EXIT_TO_MAP
    db   $d7, $06                                       ; $04 MENU_TYPE_GAME_OVER_TOTALS
    db   $d7, $06                                       ; $05 MENU_TYPE_VIEW_TOTALS
    db   $d7, $03                                       ; $06 MENU_TYPE_VIEW_PASSWORD
    db   $c7, $01                                       ; $07 MENU_TYPE_TITLE_OPTIONS
    db   $d7, $06                                       ; $08 MENU_TYPE_ENTERING_LEVEL_NAME
    db   $d7, $07                                       ; $09 MENU_TYPE_MISSION_SELECT_1_OPTION
    db   $d7, $07                                       ; $0a MENU_TYPE_MISSION_SELECT_2_OPTIONS
    db   $d7, $07                                       ; $0b MENU_TYPE_MISSION_SELECT_3_OPTIONS
    db   $d7, $06                                       ; $0c MENU_TYPE_GAME_OVER
    db   $d7, $06                                       ; $0d MENU_TYPE_BLACK_SCREEN
    db   $d7, $07                                       ; $0e MENU_TYPE_CONGRATULATIONS
    db   $d7, $03                                       ; $0f MENU_TYPE_ENTER_PASSWORD
    db   $c7, $02                                       ; $10 MENU_TYPE_TITLE_SCREEN
    db   $c7, $04                                       ; $11 MENU_TYPE_AUDIO_OPTIONS_UNUSED
    db   $c7, $05                                       ; $12 MENU_TYPE_CREDITS_GREAT_JOB
    db   $c7, $09                                       ; $13 MENU_TYPE_TITLE_CRAVE
    db   $c7, $08                                       ; $14 MENU_TYPE_TITLE_SPLASH
    db   $d7, $03                                       ; $15 MENU_TYPE_ENTERED_INVALID_PASSWORD
    db   $c7, $0a                                       ; $16 MENU_TYPE_TITLE_DAVID
    db   $c7, $0b                                       ; $17 MENU_TYPE_CREDITS_1
    db   $c7, $0c                                       ; $18 MENU_TYPE_CREDITS_2
    db   $c7, $0d                                       ; $19 MENU_TYPE_CREDITS_3
    db   $c7, $0e                                       ; $1a MENU_TYPE_CREDITS_4
    db   $d7, $06                                       ; $1b MENU_TYPE_TIME_UP

data_01_568c_ChainedScriptTable:
; Scripts a screen can queue up with MENUCMD_SUB_CHAIN_SCRIPT. The id is written
; to wD6D7_Menu_ChainedScriptId and call_01_446f_LoadMenuGraphics loops back to
; run the script named here, so a screen can be assembled from several scripts
; without any of them knowing about the others
    dw   data_01_592d_MenuScript_PasswordCells          ; 0 = MENU_CHAINED_PASSWORD_CELLS
    dw   data_01_583e_MenuScript_MissionSelectCommon    ; 1 = MENU_CHAINED_MISSION_SELECT
    dw   data_01_571f_MenuScript_ViewTotals             ; 2 = MENU_CHAINED_TOTALS

data_01_5692_MenuScript_PausedInMediaDimension:
; MENU_TYPE_PAUSED_IN_MEDIA_DIMENSION ($00) - START in the hub. "PAUSED" / "RESUME" / "QUIT"
    ; "PAUSED" - 20x2 at (0,7), tile $26, attr $01
    menu_cmd_text $0a, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5ce4_Text_Paused, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "RESUME" - 8x1 at (6,10), tile $4e, attr $01
    menu_cmd_text $0b, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5ceb_Text_Resume, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "QUIT" - 8x1 at (6,11), tile $56, attr $01
    menu_cmd_text $0c, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5cf2_Text_Quit, MENU_OPTION_QUIT | 1, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_56ab_MenuScript_ExitGame:
; MENU_TYPE_EXIT_GAME ($01) - the confirmation MENU_OPTION_QUIT opens from the hub
    ; "QUIT GAME" - 20x2 at (0,7), tile $26, attr $01
    menu_cmd_text $0a, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5cfc_Text_QuitGame, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "NO WAY!" - 8x1 at (6,10), tile $4e, attr $01
    menu_cmd_text $0b, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d12_Text_NoWay, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "OKAY" - 8x1 at (6,11), tile $56, attr $01
    menu_cmd_text $0c, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d1a_Text_Okay, MENU_OPTION_CONFIRM_QUIT | 1, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_56c4_MenuScript_PausedInLevel:
; MENU_TYPE_PAUSED_IN_LEVEL ($02) - START inside a level. Same as $00 plus the mission line
    ; a mission line - 16x2 at (2,5), tile $06
    menu_cmd_sub  $09, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENUCMD_MISSION_CURRENT, MENUCMD_SUB_MISSION_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "PAUSED" - 20x2 at (0,7), tile $26, attr $01
    menu_cmd_text $0a, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5ce4_Text_Paused, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "RESUME" - 8x1 at (6,10), tile $4e, attr $01
    menu_cmd_text $0b, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5ceb_Text_Resume, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "EXIT" - 8x1 at (6,11), tile $56, attr $01
    menu_cmd_text $0c, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5cf7_Text_Exit, MENU_OPTION_QUIT | 1, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_56e5_MenuScript_ExitToMap:
; MENU_TYPE_EXIT_TO_MAP ($03) - the confirmation MENU_OPTION_QUIT opens inside a level
    ; a mission line - 16x2 at (2,5), tile $06
    menu_cmd_sub  $09, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENUCMD_MISSION_CURRENT, MENUCMD_SUB_MISSION_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "EXIT TO MAP" - 20x2 at (0,7), tile $26, attr $01
    menu_cmd_text $0a, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5d06_Text_ExitToMap, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "NO WAY!" - 8x1 at (6,10), tile $4e, attr $01
    menu_cmd_text $0b, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d12_Text_NoWay, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "OKAY" - 8x1 at (6,11), tile $56, attr $01
    menu_cmd_text $0c, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d1a_Text_Okay, MENU_OPTION_CONFIRM_QUIT | 1, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_5706_MenuScript_GameOverTotals:
; MENU_TYPE_GAME_OVER_TOTALS ($04) - the totals shown after GAME OVER. Chains the totals script
    ; "GAME OVER" - 14x2 at (3,0), tile $06
    menu_cmd_text $12, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5d28_Text_GameOver, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "QUIT" - 12x1 at (4,5), tile $3a
    menu_cmd_text $15, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5cf2_Text_Quit, $02, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_TOTALS, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_571f_MenuScript_ViewTotals:
; MENU_TYPE_VIEW_TOTALS ($05) - the per-level stats page, also the chained script id 2
    ; the remote icon sprites (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_SPRITE_GROUP_TOTALS, MENUCMD_SUB_REMOTE_ICONS, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; "RESUME PLAY" - 12x1 at (4,3), tile $22
    menu_cmd_text $13, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d32_Text_ResumePlay, MENU_OPTION_RESUME_PLAY, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "SEE PASSWORD" - 12x1 at (4,4), tile $2e
    menu_cmd_text $14, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d3e_Text_SeePassword, MENU_OPTION_VIEW_PASSWORD | 1, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; the totals page heading - 16x2 at (2,7), tile $46
    menu_cmd_sub  $16, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_TOTALS_PAGE_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "X" - 1x2 at (7,9), tile $6e
    menu_cmd_text $19, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5d62_Text_LivesX, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 3x2 at (8,9), tile $70
    menu_cmd_sub  $1a, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_LIVES, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 1x2 at (15,9), tile $76
    menu_cmd_sub  $1b, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_HEALTH, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 2x2 at (11,11), tile $78
    menu_cmd_sub  $1c, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_MISSION_REMOTES, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 2x2 at (11,13), tile $7c
    menu_cmd_sub  $1d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_HIDDEN_REMOTES, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 2x2 at (11,15), tile $80
    menu_cmd_sub  $1e, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_BONUS_REMOTES, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; stage an image from table 1 - 2x2 at (2,12), tile $66, staged at tile $66
    menu_cmd_sub  $17, $00, $00, $66, $00, MENUCMD_SUB_STAGE_IMAGE1, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK

    ; stage an image from table 1 - 2x2 at (16,12), tile $6a, staged at tile $6a
    menu_cmd_sub  $18, $00, $00, $6a, $01, MENUCMD_SUB_STAGE_IMAGE1, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $84
    menu_cmd_sub  $00, $00, $00, $84, $03, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $88
    menu_cmd_sub  $00, $00, $00, $88, $04, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $8c
    menu_cmd_sub  $00, $00, $00, $8c, $05, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $98
    menu_cmd_sub  $00, $00, $00, $98, $06, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    menu_script_end

data_01_57a0_MenuScript_TotalsPageRefresh:
; Re-run by call_01_4000_MenuLoad alone when left/right pages the totals screen:
; just the remote icons and the page heading, so paging does not redraw the frame
    ; the remote icon sprites (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_SPRITE_GROUP_TOTALS, MENUCMD_SUB_REMOTE_ICONS, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; the totals page heading - 16x2 at (2,7), tile $46
    menu_cmd_sub  $16, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_TOTALS_PAGE_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_57b1_MenuScript_TitleOptions:
; MENU_TYPE_TITLE_OPTIONS ($07) - "START" / "PASSWORD" over the title image
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_TITLE_1, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; "START" - 8x1 at (2,10), tile $06
    menu_cmd_text $0d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5ccf_Text_Start, MENU_OPTION_START_GAME, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "PASSWORD" - 8x1 at (2,10), tile $06
    menu_cmd_text $0d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5cdb_Text_Password, MENU_OPTION_ENTER_PASSWORD | 1, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_57ca_MenuScript_EnteringLevelName:
; MENU_TYPE_ENTERING_LEVEL_NAME ($08) - the "ENTERING..." card shown on the way into a level
    ; "ENTERING..." - 20x2 at (0,8), tile $06, attr $01
    menu_cmd_text $10, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5d56_Text_Entering, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; the level's name - 20x2 at (0,10), tile $2e, attr $01
    menu_cmd_sub  $11, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, $00, MENUCMD_SUB_LEVEL_NAME_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_57db_MenuScript_MissionSelect1:
; MENU_TYPE_MISSION_SELECT_1_OPTION ($09) - mission select for a level with one mission
    ; a mission line - 16x2 at (4,10), tile $80
    menu_cmd_sub  $04, $00, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_MISSION_TEXT, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "PRESS B TO CONTINUE" - 20x2 at (0,16), tile $c0, attr $02
    menu_cmd_text $08, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5ed3_Text_PressBToContinueShort, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_MISSION_SELECT, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_57f4_MenuScript_MissionSelect2:
; MENU_TYPE_MISSION_SELECT_2_OPTIONS ($0A)
    ; a mission line - 16x2 at (4,8), tile $60
    menu_cmd_sub  $06, $00, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_MISSION_TEXT, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a mission line - 16x2 at (4,12), tile $80
    menu_cmd_sub  $07, $00, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $01, MENUCMD_SUB_MISSION_TEXT, $01, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "CHOOSE A HINT THEN PRESS B TO CONTINUE" - 20x2 at (0,16), tile $c0, attr $02
    menu_cmd_text $08, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5eac_Text_ChooseAHint, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_MISSION_SELECT, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5815_MenuScript_MissionSelect3:
; MENU_TYPE_MISSION_SELECT_3_OPTIONS ($0B)
    ; a mission line - 16x2 at (4,7), tile $60
    menu_cmd_sub  $03, $00, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_MISSION_TEXT, $00, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a mission line - 16x2 at (4,10), tile $80
    menu_cmd_sub  $04, $00, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $01, MENUCMD_SUB_MISSION_TEXT, $01, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a mission line - 16x2 at (4,13), tile $a0
    menu_cmd_sub  $05, $00, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $02, MENUCMD_SUB_MISSION_TEXT, $02, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "CHOOSE A HINT THEN PRESS B TO CONTINUE" - 20x2 at (0,16), tile $c0, attr $02
    menu_cmd_text $08, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5eac_Text_ChooseAHint, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_MISSION_SELECT, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_583e_MenuScript_MissionSelectCommon:
; Chained script id 1 - the furniture every mission select screen shares:
; TV name, level name, the TV screen picture and the selection cursor
    ; the TV's name - 12x3 at (8,1), tile $24, attr $01
    menu_cmd_sub  $01, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, $00, MENUCMD_SUB_TV_NAME_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; the level's name - 12x2 at (8,4), tile $48
    menu_cmd_sub  $02, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_LEVEL_NAME_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; the TV picture (size comes from the handler, not from id $00), staged at tile $06
    menu_cmd_sub  $00, $00, $00, $06, $00, MENUCMD_SUB_STAGE_TV_SCREEN, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $e8
    menu_cmd_sub  $00, $00, $00, $e8, $05, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    ; the selection cursor (size comes from the handler, not from id $00), staged at tile $02
    menu_cmd_sub  $00, $00, $00, $02, $01, MENUCMD_SUB_DRAW_CURSOR, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    menu_script_end

data_01_5867_MenuScript_GameOver:
; MENU_TYPE_GAME_OVER ($0C) - one line, no options; the menu leaves on its timer
    ; "GAME OVER" - 16x2 at (2,7), tile $46
    menu_cmd_text $16, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5d28_Text_GameOver, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_5870_MenuScript_BlackScreen:
; MENU_TYPE_BLACK_SCREEN ($0D) - draws nothing at all
    menu_script_end

data_01_5871_MenuScript_Congratulations:
; MENU_TYPE_CONGRATULATIONS ($0E) - the level-complete screen: reward text, the
; mission status line, the three collectible counters and the remote icons
    ; "CONGRATULATIONS!" - 16x2 at (2,0), tile $06
    menu_cmd_text $1f, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_MEDIUM, data_01_5d64_Text_Congratulations, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; the mission status line - 18x1 at (1,6), tile $26
    menu_cmd_sub  $20, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, $00, MENUCMD_SUB_MISSION_STATUS_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "REWARD" - 5x1 at (4,15), tile $38
    menu_cmd_text $21, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5d75_Text_Reward, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "HIDDEN" - 5x1 at (11,15), tile $3d
    menu_cmd_text $22, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5d7c_Text_Hidden, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "PRESS B TO CONTINUE" - 14x1 at (3,17), tile $42
    menu_cmd_text $23, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5d83_Text_PressBToContinue, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 2x2 at (3,9), tile $50
    menu_cmd_sub  $24, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_COLLECTIBLES_1, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 2x2 at (9,9), tile $54
    menu_cmd_sub  $25, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_COLLECTIBLES_2, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; a counter - 2x2 at (15,9), tile $58
    menu_cmd_sub  $26, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, MENU_COUNTER_COLLECTIBLES_3, MENUCMD_SUB_COUNTER_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; the remote icon sprites (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_SPRITE_GROUP_CONGRATS, MENUCMD_SUB_REMOTE_ICONS, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $98
    menu_cmd_sub  $00, $00, $00, $98, $06, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    ; the level's collectible icon - 3x2 at (9,7), tile $90
    menu_cmd_sub  $27, $00, $00, $00, $00, MENUCMD_SUB_COLLECTIBLE_ICON, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL

    menu_script_end

data_01_58ca_MenuScript_ViewPassword:
; MENU_TYPE_VIEW_PASSWORD ($06) - shows the password the game generated for you.
; Draws the frame and the $4B key, then chains the 29-cell keyboard script
    ; the remote icon sprites (no shape needed - the block only runs its sub-handler), hidden again on the next button press
    menu_cmd_sub  $00, $00, $00, MENU_HIDE_ON_INPUT, MENU_SPRITE_GROUP_VIEW_PASSWORD, MENUCMD_SUB_REMOTE_ICONS, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; load a whole tileset + tilemap (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, $00, MENUCMD_SUB_LOAD_SCREEN, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; the blank key (no GO when you are only looking) - 2x2 at (16,14), tile $b2, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $1d, $00, $00, MENU_FONT_PASSWORD, PASSWORD_CELL_UNKNOWN, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_PASSWORD_CELLS, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_58eb_MenuScript_EnterPassword:
; MENU_TYPE_ENTER_PASSWORD ($0F) - the keyboard you type a password into
    ; the remote icon sprites (no shape needed - the block only runs its sub-handler), hidden again on the next button press
    menu_cmd_sub  $00, $00, $00, MENU_HIDE_ON_INPUT, MENU_SPRITE_GROUP_ENTER_PASSWORD, MENUCMD_SUB_REMOTE_ICONS, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; load a whole tileset + tilemap (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, $00, MENUCMD_SUB_LOAD_SCREEN, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; the GO key - 2x2 at (16,14), tile $b2, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $1d, $00, $00, MENU_FONT_PASSWORD, PASSWORD_CELL_GO, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_PASSWORD_CELLS, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_590c_MenuScript_InvalidPassword:
; MENU_TYPE_ENTERED_INVALID_PASSWORD ($15) - same keyboard, different banner
    ; the remote icon sprites (no shape needed - the block only runs its sub-handler), hidden again on the next button press
    menu_cmd_sub  $00, $00, $00, MENU_HIDE_ON_INPUT, MENU_SPRITE_GROUP_INVALID_PASSWORD, MENUCMD_SUB_REMOTE_ICONS, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; load a whole tileset + tilemap (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, $00, MENUCMD_SUB_LOAD_SCREEN, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; the GO key - 2x2 at (16,14), tile $b2, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $1d, $00, $00, MENU_FONT_PASSWORD, PASSWORD_CELL_GO, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; queue another script (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_CHAINED_PASSWORD_CELLS, MENUCMD_SUB_CHAIN_SCRIPT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_592d_MenuScript_PasswordCells:
; Chained script id 0 - the cursor, the keyboard artwork and 29 of the 30 grid
; positions. The 30th, MENUCMD_PASSWORD_CELL_BASE + $1D, is left to whichever
; screen chained this one, because its key face differs per screen.
;
; Every cell is the same 2x2 box drawn through MENUCMD_SUB_PASSWORD_CHAR_TEXT; the
; box's position comes from its command id and the character from its cell index,
; so this is 29 near-identical lines rather than a loop
    ; the selection cursor (size comes from the handler, not from id $00), staged at tile $02
    menu_cmd_sub  $00, $00, $00, $02, $02, MENUCMD_SUB_DRAW_CURSOR, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_TRANSPOSED

    ; stage an image from table 2 (size comes from the handler, not from id $00), staged at tile $06
    menu_cmd_sub  $00, $00, $00, $06, $07, MENUCMD_SUB_STAGE_IMAGE2, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL

    ; the EXIT key - 2x2 at (1,2), tile $3e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $00, $00, $00, MENU_FONT_PASSWORD, PASSWORD_CELL_EXIT, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 1 - 2x2 at (4,2), tile $42, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $01, $00, $00, MENU_FONT_PASSWORD, $01, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 2 - 2x2 at (7,2), tile $46, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $02, $00, $00, MENU_FONT_PASSWORD, $02, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 3 - 2x2 at (10,2), tile $4a, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $03, $00, $00, MENU_FONT_PASSWORD, $03, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 4 - 2x2 at (13,2), tile $4e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $04, $00, $00, MENU_FONT_PASSWORD, $04, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 5 - 2x2 at (16,2), tile $52, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $05, $00, $00, MENU_FONT_PASSWORD, $05, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 6 - 2x2 at (1,5), tile $56, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $06, $00, $00, MENU_FONT_PASSWORD, $06, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 7 - 2x2 at (4,5), tile $5a, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $07, $00, $00, MENU_FONT_PASSWORD, $07, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 8 - 2x2 at (7,5), tile $5e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $08, $00, $00, MENU_FONT_PASSWORD, $08, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 9 - 2x2 at (10,5), tile $62, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $09, $00, $00, MENU_FONT_PASSWORD, $09, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 10 - 2x2 at (13,5), tile $66, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $0a, $00, $00, MENU_FONT_PASSWORD, $0a, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 11 - 2x2 at (16,5), tile $6a, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $0b, $00, $00, MENU_FONT_PASSWORD, $0b, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 12 - 2x2 at (1,8), tile $6e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $0c, $00, $00, MENU_FONT_PASSWORD, $0c, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 13 - 2x2 at (4,8), tile $72, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $0d, $00, $00, MENU_FONT_PASSWORD, $0d, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 14 - 2x2 at (7,8), tile $76, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $0e, $00, $00, MENU_FONT_PASSWORD, $0e, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 15 - 2x2 at (10,8), tile $7a, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $0f, $00, $00, MENU_FONT_PASSWORD, $0f, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 16 - 2x2 at (13,8), tile $7e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $10, $00, $00, MENU_FONT_PASSWORD, $10, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 17 - 2x2 at (16,8), tile $82, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $11, $00, $00, MENU_FONT_PASSWORD, $11, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 18 - 2x2 at (1,11), tile $86, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $12, $00, $00, MENU_FONT_PASSWORD, $12, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 19 - 2x2 at (4,11), tile $8a, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $13, $00, $00, MENU_FONT_PASSWORD, $13, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 20 - 2x2 at (7,11), tile $8e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $14, $00, $00, MENU_FONT_PASSWORD, $14, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 21 - 2x2 at (10,11), tile $92, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $15, $00, $00, MENU_FONT_PASSWORD, $15, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 22 - 2x2 at (13,11), tile $96, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $16, $00, $00, MENU_FONT_PASSWORD, $16, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 23 - 2x2 at (16,11), tile $9a, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $17, $00, $00, MENU_FONT_PASSWORD, $17, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 24 - 2x2 at (1,14), tile $9e, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $18, $00, $00, MENU_FONT_PASSWORD, $18, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 25 - 2x2 at (4,14), tile $a2, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $19, $00, $00, MENU_FONT_PASSWORD, $19, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 26 - 2x2 at (7,14), tile $a6, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $1a, $00, $00, MENU_FONT_PASSWORD, $1a, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 27 - 2x2 at (10,14), tile $aa, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $1b, $00, $00, MENU_FONT_PASSWORD, $1b, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; password box 28 - 2x2 at (13,14), tile $ae, attr $05
    menu_cmd_sub  MENUCMD_PASSWORD_CELL_BASE + $1c, $00, $00, MENU_FONT_PASSWORD, $1c, MENUCMD_SUB_PASSWORD_CHAR_TEXT, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_TRANSPOSED | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_5a26_MenuScript_TitleScreen:
; MENU_TYPE_TITLE_SCREEN ($10)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_TITLE_0, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a2f_MenuScript_AudioOptions:
; MENU_TYPE_AUDIO_OPTIONS_UNUSED ($11) - four "SOUND" rows, never reachable in game
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_AUDIO_MENU, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    ; "START" - 8x1 at (2,10), tile $06
    menu_cmd_text $0d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5ccf_Text_Start, $00, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "SOUND" - 8x1 at (2,10), tile $06
    menu_cmd_text $0d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5cd5_Text_Sound, $01, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "SOUND" - 8x1 at (2,10), tile $06
    menu_cmd_text $0d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5cd5_Text_Sound, $02, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    ; "SOUND" - 8x1 at (2,10), tile $06
    menu_cmd_text $0d, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_SMALL, data_01_5cd5_Text_Sound, $03, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_5a58_MenuScript_CreditsGreatJob:
; MENU_TYPE_CREDITS_GREAT_JOB ($12)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_GREAT_JOB, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a61_MenuScript_TitleCrave:
; MENU_TYPE_TITLE_CRAVE ($13)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_CRAVE, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a6a_MenuScript_TitleSplash:
; MENU_TYPE_TITLE_SPLASH ($14)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_SPLASH, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a73_MenuScript_TitleDavid:
; MENU_TYPE_TITLE_DAVID ($16)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_DAVID, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a7c_MenuScript_Credits1:
; MENU_TYPE_CREDITS_1 ($17)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_CREDITS_1, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a85_MenuScript_Credits2:
; MENU_TYPE_CREDITS_2 ($18)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_CREDITS_2, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a8e_MenuScript_Credits3:
; MENU_TYPE_CREDITS_3 ($19)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_CREDITS_3, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5a97_MenuScript_Credits4:
; MENU_TYPE_CREDITS_4 ($1A)
    ; a fullscreen image (no shape needed - the block only runs its sub-handler)
    menu_cmd_sub  $00, $00, $00, $00, MENU_IMAGE_CREDITS_4, MENUCMD_SUB_FULLSCREEN_IMAGE, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_NO_TILEMAP_FILL | MENUCMD_NO_TILE_UPLOAD

    menu_script_end

data_01_5aa0_MenuScript_TimeUp:
; MENU_TYPE_TIME_UP ($1B) - "TIME UP!", leaves on its timer
    ; "TIME UP!" - 16x2 at (2,7), tile $46
    menu_cmd_text $16, TEXT_AUTO_ALIGN, TEXT_AUTO_ALIGN, MENU_FONT_LARGE, data_01_5d1f_Text_TimeUp, MENU_OPTION_SLOT_NONE, MENUCMD_LAST_BLOCK | MENUCMD_DRAW_TEXT | MENUCMD_CLEAR_BUFFER

    menu_script_end

data_01_5aa9_SpriteScriptTable:
; Sprite groups, indexed by the argument of MENUCMD_SUB_REMOTE_ICONS and by
; call_01_4d3b_Menu_EraseSpriteGroup. Entries 0-6 and 7-13 are two parallel sets
; selected by adding the level's remote progress id to a base of 0 or 7, so the
; layout automatically matches how many remotes that level actually has
; (see .data_01_43b6_LevelPayloadMasks for the per-progress-id masks)
    dw   data_01_5acf_SpriteScript_Totals_5Remotes      ; $00 MENU_SPRITE_GROUP_TOTALS + progress id 0
    dw   data_01_5aef_SpriteScript_Totals_4Remotes      ; $01   +1
    dw   data_01_5b09_SpriteScript_Totals_3Remotes      ; $02   +2
    dw   data_01_5b1d_SpriteScript_Totals_2Remotes      ; $03   +3
    dw   data_01_5b2b_SpriteScript_Totals_1Remote       ; $04   +4
    dw   data_01_5b33_SpriteScript_Totals_GoldOnly      ; $05   +5
    dw   data_01_5c13_SpriteScript_Totals_StatsPage     ; $06   +6 (the stats page)
    dw   data_01_5b3b_SpriteScript_Congrats_5Remotes    ; $07 MENU_SPRITE_GROUP_CONGRATS + progress id 0
    dw   data_01_5b6d_SpriteScript_Congrats_4Remotes    ; $08   +1
    dw   data_01_5b99_SpriteScript_Congrats_3Remotes    ; $09   +2
    dw   data_01_5bbf_SpriteScript_Congrats_2Remotes    ; $0a   +3
    dw   data_01_5bdf_SpriteScript_Congrats_1Remote     ; $0b   +4
    dw   data_01_5bf9_SpriteScript_Congrats_GoldOnly    ; $0c   +5
    dw   data_01_5c6f_SpriteScript_EnterPasswordHeader  ; $0d MENU_SPRITE_GROUP_ENTER_PASSWORD
    dw   data_01_5c7d_SpriteScript_ViewPasswordHeader   ; $0e MENU_SPRITE_GROUP_VIEW_PASSWORD
    dw   data_01_5c8b_SpriteScript_InvalidPasswordHeader; $0f MENU_SPRITE_GROUP_INVALID_PASSWORD
    dw   wD6B9_MenuCursor_OamSlot                       ; $10 $10-$12: the live cursor block in WRAM, not a ROM script
    dw   wD6B9_MenuCursor_OamSlot                       ; $11 $10-$12: the live cursor block in WRAM, not a ROM script
    dw   wD6B9_MenuCursor_OamSlot                       ; $12 $10-$12: the live cursor block in WRAM, not a ROM script

; Sprite scripts. Each entry is  Y, X, tile, attributes, width in 8px columns,
; height in 8px rows. An odd tile byte is an index into wD5AA_Sprite_TileIdTable
; ((byte >> 1)) rather than a literal tile, which is how the remote icons switch
; between lit and unlit without a second copy of the layout

data_01_5acf_SpriteScript_Totals_5Remotes:
; Five mission/hidden remote icons - progress id 0 (mask $1F)
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $48, $24, $01, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $48, $44, $03, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[1]
    menu_sprite $48, $64, $05, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[2]
    menu_sprite $68, $34, $07, $04, 3, 4   ; wD5AA_Sprite_TileIdTable[3]
    menu_sprite $68, $54, $09, $04, 3, 4   ; wD5AA_Sprite_TileIdTable[4]
    menu_sprite_end

data_01_5aef_SpriteScript_Totals_4Remotes:
; Four - progress id 1 (mask $1B)
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $48, $34, $01, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $48, $54, $03, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[1]
    menu_sprite $68, $34, $07, $04, 3, 4   ; wD5AA_Sprite_TileIdTable[3]
    menu_sprite $68, $54, $09, $04, 3, 4   ; wD5AA_Sprite_TileIdTable[4]
    menu_sprite_end

data_01_5b09_SpriteScript_Totals_3Remotes:
; Three - progress id 2 (mask $19)
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $48, $44, $01, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $68, $34, $07, $04, 3, 4   ; wD5AA_Sprite_TileIdTable[3]
    menu_sprite $68, $54, $09, $04, 3, 4   ; wD5AA_Sprite_TileIdTable[4]
    menu_sprite_end

data_01_5b1d_SpriteScript_Totals_2Remotes:
; Two - progress id 3 (mask $03)
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $58, $34, $01, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $58, $54, $03, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[1]
    menu_sprite_end

data_01_5b2b_SpriteScript_Totals_1Remote:
; One - progress id 4 (mask $01)
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $58, $44, $01, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite_end

data_01_5b33_SpriteScript_Totals_GoldOnly:
; Just the gold remote - progress id 5 (mask $20)
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $58, $44, $0b, $05, 3, 4   ; wD5AA_Sprite_TileIdTable[5]
    menu_sprite_end

data_01_5b3b_SpriteScript_Congrats_5Remotes:
; Congratulations screen, five remotes plus the three collectible counters
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $10, $14, $01, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $10, $44, $03, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[1]
    menu_sprite $10, $74, $05, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[2]
    menu_sprite $58, $29, $07, $02, 3, 4   ; wD5AA_Sprite_TileIdTable[3]
    menu_sprite $58, $61, $09, $02, 3, 4   ; wD5AA_Sprite_TileIdTable[4]
    menu_sprite $3b, $1c, $92, $04, 1, 2   ; the level's collectible icon, one 8x16 slice
    menu_sprite $3b, $4c, $94, $05, 1, 2   ; above each counter - the 3x2 block staged at
    menu_sprite $3b, $7c, $96, $06, 1, 2   ; MENU_COLLECTIBLE_ICON_TILE, split three ways
    menu_sprite_end

data_01_5b6d_SpriteScript_Congrats_4Remotes:
; Four remotes plus the collectible counters
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $10, $2c, $01, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $10, $5c, $03, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[1]
    menu_sprite $58, $29, $07, $02, 3, 4   ; wD5AA_Sprite_TileIdTable[3]
    menu_sprite $58, $61, $09, $02, 3, 4   ; wD5AA_Sprite_TileIdTable[4]
    menu_sprite $3b, $1c, $92, $04, 1, 2   ; the level's collectible icon, one 8x16 slice
    menu_sprite $3b, $4c, $94, $05, 1, 2   ; above each counter - the 3x2 block staged at
    menu_sprite $3b, $7c, $96, $06, 1, 2   ; MENU_COLLECTIBLE_ICON_TILE, split three ways
    menu_sprite_end

data_01_5b99_SpriteScript_Congrats_3Remotes:
; Three remotes plus the collectible counters
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $10, $44, $01, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $58, $29, $07, $02, 3, 4   ; wD5AA_Sprite_TileIdTable[3]
    menu_sprite $58, $61, $09, $02, 3, 4   ; wD5AA_Sprite_TileIdTable[4]
    menu_sprite $3b, $1c, $92, $04, 1, 2   ; the level's collectible icon, one 8x16 slice
    menu_sprite $3b, $4c, $94, $05, 1, 2   ; above each counter - the 3x2 block staged at
    menu_sprite $3b, $7c, $96, $06, 1, 2   ; MENU_COLLECTIBLE_ICON_TILE, split three ways
    menu_sprite_end

data_01_5bbf_SpriteScript_Congrats_2Remotes:
; Two remotes plus the collectible counters
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $10, $2c, $01, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $10, $5c, $03, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[1]
    menu_sprite $3b, $1c, $92, $04, 1, 2   ; the level's collectible icon, one 8x16 slice
    menu_sprite $3b, $4c, $94, $05, 1, 2   ; above each counter - the 3x2 block staged at
    menu_sprite $3b, $7c, $96, $06, 1, 2   ; MENU_COLLECTIBLE_ICON_TILE, split three ways
    menu_sprite_end

data_01_5bdf_SpriteScript_Congrats_1Remote:
; One remote plus the collectible counters
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $10, $44, $01, $01, 3, 4   ; wD5AA_Sprite_TileIdTable[0]
    menu_sprite $3b, $1c, $92, $04, 1, 2   ; the level's collectible icon, one 8x16 slice
    menu_sprite $3b, $4c, $94, $05, 1, 2   ; above each counter - the 3x2 block staged at
    menu_sprite $3b, $7c, $96, $06, 1, 2   ; MENU_COLLECTIBLE_ICON_TILE, split three ways
    menu_sprite_end

data_01_5bf9_SpriteScript_Congrats_GoldOnly:
; Gold remote plus the collectible counters
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $10, $44, $0b, $03, 3, 4   ; wD5AA_Sprite_TileIdTable[5]
    menu_sprite $3b, $1c, $92, $04, 1, 2   ; the level's collectible icon, one 8x16 slice
    menu_sprite $3b, $4c, $94, $05, 1, 2   ; above each counter - the 3x2 block staged at
    menu_sprite $3b, $7c, $96, $06, 1, 2   ; MENU_COLLECTIBLE_ICON_TILE, split three ways
    menu_sprite_end

data_01_5c13_SpriteScript_Totals_StatsPage:
; Page 0 of the totals - the whole-game tally rather than one level, so instead of
; remote icons it lays out five "<icon> X <number>" rows. Every tile here is a
; literal, because the numbers were already rendered into tiles by the counter
; commands of data_01_571f_MenuScript_ViewTotals; these sprites only place them
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $48, $20, $84, $06, 2, 2   ; gex head
    menu_sprite $48, $38, $6e, $00, 1, 2   ;   "X"
    menu_sprite $48, $40, $70, $00, 3, 2   ;   lives
    menu_sprite $48, $60, $88, $06, 2, 2   ; hand print
    menu_sprite $48, $70, $6e, $00, 1, 2   ;   "X"
    menu_sprite $48, $78, $76, $00, 1, 2   ;   health
    menu_sprite $58, $38, $8c, $03, 2, 2   ; red remote
    menu_sprite $58, $4c, $6e, $00, 1, 2   ;   "X"
    menu_sprite $58, $58, $78, $00, 2, 2   ;   mission remotes collected
    menu_sprite $69, $38, $90, $04, 2, 2   ; silver remote
    menu_sprite $69, $4c, $6e, $00, 1, 2   ;   "X"
    menu_sprite $69, $58, $7c, $00, 2, 2   ;   hidden remotes collected
    menu_sprite $7a, $38, $94, $05, 2, 2   ; gold remote
    menu_sprite $7a, $4c, $6e, $00, 1, 2   ;   "X"
    menu_sprite $7a, $58, $80, $00, 2, 2   ;   bonus remotes collected
    menu_sprite_end

data_01_5c6f_SpriteScript_EnterPasswordHeader:
; "Enter Password" - two slices of data_00_3c72_Image_PasswordHeadings, staged at
; tile $06, so the words are sprites rather than part of the tilemap
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $30, $3c, $06, $07, 5, 2   ; the word that changes
    menu_sprite $40, $2c, $2c, $07, 9, 2   ; "PASSWORD", shared by all three
    menu_sprite_end

data_01_5c7d_SpriteScript_ViewPasswordHeader:
; "Current Password" - same strip, starting at tile $10 instead
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $30, $34, $10, $07, 7, 2   ; the word that changes
    menu_sprite $40, $2c, $2c, $07, 9, 2   ; "PASSWORD", shared by all three
    menu_sprite_end

data_01_5c8b_SpriteScript_InvalidPasswordHeader:
; "Invalid Password" - same strip again, starting at tile $1E
    menu_sprite_script $02                            ; first OAM slot
    ;           Y,   X, tile, attr, w, h
    menu_sprite $30, $34, $1e, $07, 7, 2   ; the word that changes
    menu_sprite $40, $2c, $2c, $07, 9, 2   ; "PASSWORD", shared by all three
    menu_sprite_end

data_01_5c99_PasswordKeyGrid:
; What each button combination types on the password keyboard. Indexed by the
; d-pad/START/SELECT nibble of wD59F_RawInputs, with bit 4 set when B was
; pressed rather than A - so the two face buttons give two banks of 16.
; PASSWORD_KEY_BLANK entries are combinations that type nothing.
;
; Only one d-pad direction is really used per letter - RIGHT/LEFT/UP/DOWN with A
; give A B C D, and the same four with B give E F G H, which is exactly the 0-7
; alphabet PASSWORD_CHAR_BASE encodes. The duplicated entries are what happens
; when two directions are held at once
    ; A pressed
    db   $20, $41, $42, $41, $43, $41, $42, $41
    db   $44, $41, $42, $41, $43, $41, $42, $41
    ; B pressed
    db   $20, $45, $46, $45, $47, $45, $46, $45
    db   $48, $45, $46, $45, $47, $45, $46, $45

data_01_5cb9_TVScreenImageTable:
; The Media Dimension TV pictures, one per TV palette id (MAPDATA_TV_PALETTE_ID).
; These are raw addresses in ROM bank $13, staged as a 6x5 tile block by
; call_01_466b_MenuCmd_StageTVScreen
    dw   image_013_00_scream_tv_screen                       ; GAME STATS
    dw   image_013_15_circuit_central_screen                 ; CIRCUIT CENTRAL
    dw   image_013_16_kung_fu_theater_screen                 ; KUNG-FU THEATRE
    dw   image_013_14_prehistory_channel_screen              ; PREHIST CHANNEL
    dw   image_013_18_rezopolis_screen                       ; REZOPOLIS
    dw   image_013_00_scream_tv_screen                       ; ROCKET CHANNEL
    dw   image_013_00_scream_tv_screen                       ; SCREAM TV
    dw   image_013_13_toon_tv_screen                         ; TOON TV
    dw   image_013_19_bonus_tv_screen                        ; BONUS BONANZA
    dw   image_013_00_scream_tv_screen                       ; SECRET STATION
    dw   image_013_17_channel_z_screen                       ; BOSS TV

INCLUDE "code/bank01_text.asm"

data_01_65fe_FontDescriptors:
; Four font descriptors, 8 bytes each, indexed by wD69A_Text_FontId. call_01_4a8f_Text_Render copies the first 6 bytes
; of the selected one to wD69F_Font_GlyphBase-wD6A4_Font_GlyphHeightPx; the trailing two bytes are padding and never read.
;
;   +0  dw  glyph bitmap base          -> wD69F_Font_GlyphBase
;   +2  dw  advance-width table        -> wD6A1_Font_WidthTable (one byte per glyph, pixels)
;   +4  db  glyph width in 8px columns -> wD6A3_Font_GlyphWidthCols
;   +5  db  glyph height in PIXELS     -> wD6A4_Font_GlyphHeightPx
;   +6  db  $00, $00                   (padding)
;
; The height is a pixel count, not a tile count, so the glyph bitmaps have no 8-row tile
; structure at all - which is why their sizes are not multiples of $10 and why rgbgfx cannot
; read them. call_01_4cab_Text_SelectGlyph computes a glyph's address as
;
;   stride    = width_cols * height_px * 2
;   glyph_ptr = base + index * stride
;
; and takes no special case for index 0, so there is no header on the blobs: byte 0 is the
; first pixel row of glyph 0. Inside a glyph the layout is column major - all height_px rows
; of column 0, then all height_px rows of column 1 - with each row being two bytes of ordinary
; GB 2bpp (plane 0, plane 1), the pair that call_01_4ae7_Text_DrawGlyph loads into E and C.
;
; Glyph indices come from call_01_4f41_Text_CharToGlyphIndex and run $00-$29: $00 space,
; $01-$1A A-Z, $1B-$24 0-9, $25-$29 punctuation. That is 42 glyphs, and the width tables all
; have 42 entries, but only the first font actually has 42 bitmaps - see the note there.
    dw   .data_01_66a7_SmallFont, .data_01_661e_SmallFontWidths
    db   $01, $06, $00, $00
    dw   .data_01_689f_MediumFont, .data_01_6648_MediumFontWidths
    db   $01, $07, $00, $00
    dw   .data_01_6add_LargeFont, .data_01_6672_LargeFontWidths
    db   $02, $0b, $00, $00
    dw   data_01_71e9_PasswordFont, .data_01_669c_PasswordFontWidths
    db   $02, $10, $00, $00
.data_01_661e_SmallFontWidths:
; Advance width in pixels, one per glyph, in glyph-index order: space, A-Z, 0-9,
; then . , ! - ' (see .data_01_4f4c_CharToGlyph). call_01_4c81_Text_MeasureLine
; adds TEXT_CHAR_SPACING on top of each
; The small font is fixed pitch apart from M and W, so nearly every entry is 3
    db   $03, $03, $03, $03                        ; space .. C
    db   $03, $03, $03, $03, $03, $03, $03, $03    ; D .. K
    db   $03, $05, $03, $03, $03, $03, $03, $03    ; L .. S
    db   $03, $03, $03, $05, $03, $03, $03, $03    ; T .. 0
    db   $03, $03, $03, $03, $03, $03, $03, $03    ; 1 .. 8
    db   $03, $01, $02, $01, $03, $02              ; 9 .. '
.data_01_6648_MediumFontWidths:
; Advance width in pixels, one per glyph, in glyph-index order: space, A-Z, 0-9,
; then . , ! - ' (see .data_01_4f4c_CharToGlyph). call_01_4c81_Text_MeasureLine
; adds TEXT_CHAR_SPACING on top of each
    db   $04, $06                                  ; space .. A
    db   $05, $06, $06, $05, $06, $05, $06, $02    ; B .. I
    db   $06, $06, $05, $06, $06, $06, $06, $06    ; J .. Q
    db   $06, $05, $05, $06, $07, $06, $07, $06    ; R .. Y
    db   $07, $06, $05, $05, $05, $05, $06, $05    ; Z .. 6
    db   $05, $05, $05, $02, $02, $03, $04, $02    ; 7 .. '
.data_01_6672_LargeFontWidths:
; Advance width in pixels, one per glyph, in glyph-index order: space, A-Z, 0-9,
; then . , ! - ' (see .data_01_4f4c_CharToGlyph). call_01_4c81_Text_MeasureLine
; adds TEXT_CHAR_SPACING on top of each
    db   $05, $0a, $0a, $0a, $0b, $09, $08, $09    ; space .. G
    db   $09, $04, $0b, $0a, $09, $0b, $0a, $0a    ; H .. O
    db   $09, $0b, $0a, $09, $09, $0a, $0b, $0b    ; P .. W
    db   $0b, $0b, $0b, $0a, $07, $09, $08, $09    ; X .. 4
    db   $09, $09, $09, $09, $09, $04, $04, $05    ; 5 .. !
    db   $06, $04                                  ; - .. '
.data_01_669c_PasswordFontWidths:
; The password font is fixed pitch and has only the eleven glyphs listed at
; data_01_71e9_PasswordFont, so this table stops well short of FONT_GLYPH_COUNT
    db   $10, $10, $10, $10, $10, $10
    db   $10, $10, $10, $10, $10                       ;; 01:66a2 ?????
.data_01_66a7_SmallFont:
; 8x6 glyphs, stride 12. $1F8 bytes = 42 glyphs, matching the 42-entry width table exactly
    INCBIN ".gfx/fonts/font_small.bin"
.data_01_689f_MediumFont:
; 8x7 glyphs, stride 14. $23E bytes = 41 glyphs, one short of the 42-entry width table - index
; $29 (apostrophe) would read into data_01_6add_font. The width table still carries a $02 for
; it, so the entry is reachable in principle; presumably no string in this font uses one
    INCBIN ".gfx/fonts/font_medium.bin"
.data_01_6add_LargeFont:
; 16x11 glyphs, stride 44. $70C bytes = 41 glyphs, same one-short situation as $689F
    INCBIN ".gfx/fonts/font_large.bin"

data_01_71e9_PasswordFont:
; 16x16 glyphs, stride 64. $300 bytes = 12 glyphs, and its width table
; (.data_01_669c_PasswordFontWidths) has only 11 entries, all $10 - a restricted
; set, not the full $00-$29 charset. The glyphs are the keyboard's key faces: a
; dot, the four d-pad arrows twice over (grey for A, black for B), then EXIT, GO
; and a divider bar
    INCBIN ".gfx/misc_sprites/password/image_password_keys.bin"

; The two image tables the staging sub-handlers index. Entry 7 aside, every entry
; points at a blob
; whose first three bytes are its own header - width in tiles, height in tiles, and a
; flag that when non-zero means "reserve the space but do not copy" - which is why the
; scripts never have to state an image's size.
;
; The two tables overlap on purpose: data_01_74e9_ImageTable1 is just the two entries
; before data_01_74ed_ImageTable2, so MENUCMD_SUB_STAGE_IMAGE1 can reach the title
; cursor while MENUCMD_SUB_STAGE_IMAGE2 starts at the menu cursor
data_01_74e9_ImageTable1:
    dw   data_01_74fd_Image_ArrowLeft                  ; $00
    dw   data_01_7540_Image_ArrowRight                 ; $01
data_01_74ed_ImageTable2:
    dw   data_01_7540_Image_ArrowRight                 ; $00 the list cursor
    dw   data_01_7540_Image_ArrowRight                 ; $01 the same again
    dw   data_01_7540_Image_ArrowRight                 ; $02 and again - three ids, one image
    dw   data_01_7b89_Image_GexHead                    ; $03
    dw   data_01_7bcc_Image_Hand                       ; $04
    dw   data_01_7583_Image_MissionRemoteMarkers       ; $05
    dw   data_01_7706_Image_RemoteIcons                ; $06
    dw   data_00_3c72_Image_PasswordHeadings           ; $07 lives in bank $00, not here
data_01_74fd_Image_ArrowLeft:
; 2x2 tiles - the left page-turn arrow on the totals screen
    db   $02, $02, $00                                 ;; 01:74fd ...
    INCBIN ".gfx/menu_sprites/image_arrow_left.bin"
data_01_7540_Image_ArrowRight:
; 2x2 tiles - the right page-turn arrow, and also the selection cursor every list
; menu draws (entries 0-2 of data_01_74ed_ImageTable2 all point here)
    db   $02, $02, $00                                 ;; 01:7540 ...
    INCBIN ".gfx/menu_sprites/image_arrow_right.bin"
data_01_7583_Image_MissionRemoteMarkers:
; 12x2 tiles - six 2x2 markers, three collected and three not. Staged at tile $E8,
; which is where the $E8/$EC/$F0/$F4 tile ids in
; call_01_473a_MenuCmd_SetMissionText come from
    db   $0c, $02, $00                                 ;; 01:7583 ...
    INCBIN ".gfx/menu_sprites/image_mission_remote_markers.bin"
data_01_7706_Image_RemoteIcons:
; 18x4 tiles - six 3x4 remote icons: red, silver and gold, then the same three
; unlit $24 tiles later. Staged at tile $98, which is where the ids in
; .data_01_48d9_RemoteIconTiles come from
    db   $12, $04, $00                                 ;; 01:7706 ...
    INCBIN ".gfx/menu_sprites/image_remote_icons.bin"
data_01_7b89_Image_GexHead:
; 2x2 tiles - gex head. Totals screen decoration, staged as background tiles at
; $84; never drawn as a sprite
    db   $02, $02, $00                                 ;; 01:7b89 ...
    INCBIN ".gfx/menu_sprites/image_gex_head.bin"
data_01_7bcc_Image_Hand:
; 2x2 tiles - a gecko hand print, the totals screen decoration beside the gex head
    db   $02, $02, $00                                 ;; 01:7bcc ...
    INCBIN ".gfx/menu_sprites/image_hand.bin"

data_01_7c0f_CollectibleIconTable:
; One entry per level id, pointing at that level's collectible artwork - the fruit,
; bug or whatever the TV channel uses. Each blob is 3x2 tiles of graphics, then 24
; bytes of tilemap ids, then a 128-byte CGB palette set, all of which
; call_01_49d7_MenuCmd_StageCollectibleIcon copies in one pass.
;
; Levels on the same channel share a blob, so the table is 31 pointers to six images
    dw   .data_01_7c4d_ToonTV              ; MAP_MEDIA_DIMENSION
    dw   .data_01_7c4d_ToonTV              ; MAP_TOON_TV_OUT_OF_TOON
    dw   .data_01_7cc5_ScreamTV            ; MAP_SCREAM_TV_SMELLRAISER
    dw   .data_01_7cc5_ScreamTV            ; MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .data_01_7d3d_CircuitCentral      ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .data_01_7db5_KungFuTheater       ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_06
    dw   .data_01_7e2d_PrehistoryChannel   ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .data_01_7c4d_ToonTV              ; MAP_TOON_TV_FINE_TOONING
    dw   .data_01_7e2d_PrehistoryChannel   ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .data_01_7d3d_CircuitCentral      ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .data_01_7cc5_ScreamTV            ; MAP_SCREAM_TV_POLTERGEX
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_0C
    dw   .data_01_7db5_KungFuTheater       ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .data_01_7ea5_Rezopolis           ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_0F
    dw   .data_01_7cc5_ScreamTV            ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_11
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_12
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_13
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_14
    dw   .data_01_7db5_KungFuTheater       ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .data_01_7ea5_Rezopolis           ; MAP_REZOPOLIS_BUGGED_OUT
    dw   .data_01_7d3d_CircuitCentral      ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .data_01_7e2d_PrehistoryChannel   ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .data_01_7cc5_ScreamTV            ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .data_01_7ea5_Rezopolis           ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_1B
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_1C
    dw   .data_01_7c4d_ToonTV              ; MAP_UNUSED_1D
    dw   .data_01_7c4d_ToonTV              ; MAP_BOSS_TV_CHANNEL_Z
.data_01_7c4d_ToonTV:
; Toon TV - 3x2 tiles of graphics, then MENU_COLLECTIBLE_TILEMAP_BYTES of tile ids,
; then MENU_PALETTE_BYTES of CGB palettes
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_toon_tv.bin"
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_toon_tv_collectibles.bin"
.data_01_7cc5_ScreamTV:
; Scream TV - 3x2 tiles of graphics, then MENU_COLLECTIBLE_TILEMAP_BYTES of tile ids,
; then MENU_PALETTE_BYTES of CGB palettes
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_scream_tv.bin"
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_scream_tv_collectibles.bin"
.data_01_7d3d_CircuitCentral:
; Circuit Central - 3x2 tiles of graphics, then MENU_COLLECTIBLE_TILEMAP_BYTES of tile ids,
; then MENU_PALETTE_BYTES of CGB palettes
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_circuit_central.bin"
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_circuit_central_collectibles.bin"
.data_01_7db5_KungFuTheater:
; Kung-Fu Theatre - 3x2 tiles of graphics, then MENU_COLLECTIBLE_TILEMAP_BYTES of tile ids,
; then MENU_PALETTE_BYTES of CGB palettes
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_kung_fu_theater.bin"
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_kung_fu_theater_collectibles.bin"
.data_01_7e2d_PrehistoryChannel:
; Prehistory Channel - 3x2 tiles of graphics, then MENU_COLLECTIBLE_TILEMAP_BYTES of tile ids,
; then MENU_PALETTE_BYTES of CGB palettes
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_prehistory_channel.bin"
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_prehistory_channel_collectibles.bin"
.data_01_7ea5_Rezopolis:
; Rezopolis - 3x2 tiles of graphics, then MENU_COLLECTIBLE_TILEMAP_BYTES of tile ids,
; then MENU_PALETTE_BYTES of CGB palettes
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_rezopolis.bin"
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_rezopolis_collectibles.bin"

; the below bytes are an incomplete portion of palette_rezopolis_collectibles.bin
    db   $00, $b4, $01, $7f, $3f, $00, $00, $6f                             ;; 01:7f08 ????????
    db   $00, $bf, $04, $ff, $31, $00, $00, $00
    db   $00, $9c, $02, $7f, $03
