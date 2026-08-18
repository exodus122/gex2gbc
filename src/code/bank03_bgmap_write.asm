call_03_6f5e_BgMap_WriteRowForVerticalScroll:
; Writes one horizontal ROW of 31 tilemap entries. The loop does `inc L / inc E`, walking
; CONSECUTIVE tilemap addresses, and the start is masked with $E0 to snap to the beginning
; of a row; a column would instead step by $20, which is what the other routine here does.
; Called on MAP_SCROLL_DOWN | MAP_SCROLL_UP, since scrolling vertically is exactly when a
; new row comes into view.
;
; Reads wD6FA_BgMap_RowWritePosLo
; to compute the target BG map address in 9800/9800/9800/C000 space. If wD59E_OnGBCFlag is set (GBC mode):
; switches to VRAM bank 1 (rVBK=$01), reads 31 tile attribute bytes from the $CF00 bank (attribute data),
; writes them to $9800 address space via the $CF indirect read pattern (ld B,$CF; ld C,[HL]; ld A,[BC]),
; then switches back to bank 0 and repeats for tile indices into $9800. If not GBC: directly copies 31
; tile bytes from $C0xx to $98xx
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
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
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
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    ret

call_03_708d_BgMap_WriteColumnForHorizontalScroll:
; Writes one vertical COLUMN of 32 tilemap entries - the mirror of the routine above. Each
; step does `add A,$20`, the tilemap row stride, so it walks down a column; the start is
; masked with $1F to pick the column index. Called on MAP_SCROLL_RIGHT | MAP_SCROLL_LEFT.
;
; Reads wD6FC_BgMap_ColumnWritePos to compute the $9800 address, uses the same $CF indirect attribute
; read pattern for GBC bank 1 attributes (32 tiles across 4 VRAM rows with inc D/inc H to cross
; page boundaries at rows 8, 16, 24), then copies tile indices in bank 0. The inc D/inc H pairs
; handle the GBC BG map layout where attribute and tile data are in different VRAM banks but share
; the same addresses
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
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    inc  H
    inc  D
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    inc  H
    inc  D
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    inc  H
    inc  D
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   A, L
    add  A, $20
    ld   L, A
    ld   E, A
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
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    inc  D
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    inc  D
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    inc  D
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, [HL]
    ld   [DE], A
    ret
