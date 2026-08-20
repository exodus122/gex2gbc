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
