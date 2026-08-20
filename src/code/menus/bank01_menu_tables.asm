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
