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
