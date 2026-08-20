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
