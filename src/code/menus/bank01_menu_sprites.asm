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
