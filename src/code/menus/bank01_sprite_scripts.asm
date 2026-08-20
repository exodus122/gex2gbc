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
