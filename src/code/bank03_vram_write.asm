; ==================================================================
; Bank 3. Everything that writes to VRAM outside of DMA: two tile copies used by the
; HUD, and the row and column writers that feed the background tilemap as the camera
; scrolls.
;
; Every routine in this file is FULLY UNROLLED in the ROM - no loop counters at all -
; because it all runs inside vblank, where a `dec B / jr NZ` per byte is time the
; routine does not have. In the disassembly that came to a little over eight hundred
; lines of `ld A, [HL+] / ld [DE], A / inc E`.
;
; The bodies below are written as REPT blocks instead. REPT is a pure assemble-time
; repeat: rgbasm emits the block N times and the ROM is unchanged, byte for byte -
; it is the same code, just not typed out N times.
;
; Where a routine walks the tilemap the last iteration always DROPS the advance, so
; the count is one less than the number of bytes written and the pointer is left on
; the last entry rather than past it. That is why each REPT is followed by a bare
; copy of its first few instructions.
; ==================================================================

call_03_6efd_VRAM_Copy32Bytes:
; Unrolled copy of exactly 32 bytes from HL to DE - the first 16 here, then falling into
; call_03_6f2d_VRAM_Copy16Bytes for the rest.
;
; 32 bytes is TWO 8x8 tiles. A GB 2bpp tile is 16 bytes total - two bytes per row, eight
; rows - and that does not change on GBC, which adds a second VRAM bank for attributes
; rather than doubling tile size.
;
; Note the join: this half ends on `inc DE` rather than `inc E`, so the pair carries correctly
; across a page boundary between the two tiles
    REPT TILE_SIZE_BYTES - 1
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ENDR
    ld   A, [HL+]
    ld   [DE], A
    inc  DE

call_03_6f2d_VRAM_Copy16Bytes:
; Unrolled copy of exactly 16 bytes - one 8x8 2bpp tile - from HL to DE. The fundamental
; tile-write primitive, used throughout the HUD system.
;
; Fifteen `inc E` and then a final `inc DE`, so D is held fixed across the tile but does
; carry on the last byte, leaving DE pointing at the next tile even across a page boundary
    REPT TILE_SIZE_BYTES - 1
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ENDR
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ret

call_03_6f5e_VRAM_WriteBgMapRowForVerticalScroll:
; Writes one horizontal ROW of SCRN_VX_B tilemap entries. The loop does `inc L / inc E`, walking
; CONSECUTIVE tilemap addresses, and the start is masked with $E0 to snap to the beginning
; of a row; a column would instead step by $20, which is what the other routine here does.
; Called on MAP_SCROLL_UP | MAP_SCROLL_DOWN, since scrolling vertically is exactly when a
; new row comes into view.
;
; wD6FA_BgMap_RowWritePosLo / wD6FB_BgMap_RowWritePosHi hold one position that names two
; addresses: the high byte is a $00-$03 map page, OR'd with $98 it is the destination in the
; VRAM tilemap and OR'd with $C0 it is the source row in wC000_BgMapTileIds.
;
; On a GBC it makes two passes. The first switches to VRAM bank 1 and writes ATTRIBUTES,
; which are not stored anywhere - each tile id is looked up in wCF00_TilesetPaletteIds by the
; indirect pattern `ld B,$CF / ld C,[HL] / ld A,[BC]`. It then switches back to bank 0 and
; makes the second pass, copying the tile ids themselves. A DMG runs only the second pass.
;
; Thirty-two entries, not thirty-one: the REPT runs SCRN_VX_B - 1 times and the write that
; follows it is the last column of the row, the one that needs no advance after it
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jp   Z, .jp_03_701d
    ld   A, $01
    ldh  [rVBK], A
    ld   HL, wD6FA_BgMap_RowWritePosLo
    ld   A, [HL+]
    and  A, $e0
    ld   E, A
    ld   A, [HL]
    or   A, $98
    ld   D, A
    ld   A, [HL]
    or   A, $c0
    ld   H, A
    ld   L, E
    ld   B, $cf
    REPT SCRN_VX_B - 1
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ENDR
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, $00
    ldh  [rVBK], A

.jp_03_701d:
    ld   HL, wD6FA_BgMap_RowWritePosLo
    ld   A, [HL+]
    and  A, $e0
    ld   E, A
    ld   A, [HL]
    or   A, $98
    ld   D, A
    ld   A, [HL]
    or   A, $c0
    ld   H, A
    ld   L, E
    REPT SCRN_VX_B - 1
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ENDR
    ld   A, [HL+]
    ld   [DE], A
    ret

call_03_708d_VRAM_WriteBgMapColumnForHorizontalScroll:
; Writes one vertical COLUMN of 32 tilemap entries - the mirror of the routine above. Each
; step does `add A,$20`, the tilemap row stride, so it walks down a column; the start is
; masked with $1F to pick the column index. Called on MAP_SCROLL_LEFT | MAP_SCROLL_RIGHT.
;
; Reads wD6FC_BgMap_ColumnWritePos to compute the $9800 address and uses the same $CF indirect
; attribute read pattern for GBC bank 1 attributes, then copies tile indices in bank 0.
;
; This one is a NESTED REPT, because the step is only 8-bit: `ld A, L / add A, $20 / ld L, A`
; wraps L after eight rows of $20, so H and D have to be bumped by hand each time the walk
; crosses a page. Eight rows per page, four pages to a 32-row column - hence three inner
; blocks of eight followed by `inc H / inc D`, then a last block of seven and the final write
; that needs no advance.
;
; The DMG path below does the same thing with one `inc D` instead of two, because it advances
; the source with a real 16-bit `add HL, BC` and only the destination needs the fixup
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jp   Z, .jp_03_71ab
    ld   A, $01
    ldh  [rVBK], A
    ld   HL, wD6FC_BgMap_ColumnWritePos
    ld   A, [HL]
    and  A, $1f
    ld   E, A
    ld   D, $98
    ld   L, A
    ld   H, $c0
    ld   B, $cf
    REPT 3
    REPT $100 / SCRN_VX_B
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ENDR
    inc  H
    inc  D
    ENDR
    REPT ($100 / SCRN_VX_B) - 1
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ENDR
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, $00
    ldh  [rVBK], A

.jp_03_71ab:
    ld   HL, wD6FC_BgMap_ColumnWritePos
    ld   A, [HL]
    and  A, $1f
    ld   E, A
    ld   D, $98
    ld   L, A
    ld   H, $c0
    ld   BC, $20
    REPT 3
    REPT $100 / SCRN_VX_B
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ENDR
    inc  D
    ENDR
    REPT ($100 / SCRN_VX_B) - 1
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ENDR
    ld   A, [HL]
    ld   [DE], A
    ret
