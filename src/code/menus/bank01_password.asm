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
