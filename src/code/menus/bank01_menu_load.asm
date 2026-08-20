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
