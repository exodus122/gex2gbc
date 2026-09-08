; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/collectible_list_lizard_in_a_china_shop.bin
; by tools/render_map_asm.py, per the collectible_list layout in tools/map_formats.json.
;
; The .bin is the editable source of truth for the bytes; this file is a
; generated view of it that happens to be what gets assembled. To change the
; data, edit the .bin (a map editor writes it). To change what a field MEANS,
; edit the schema. Either way, `make maps-docs` refreshes this file; hand edits
; are overwritten on the next build.
;
; One level's collectibles, in 16x16-pixel grid cells rather than blocks or
; pixels - COLLECTIBLE_CELL_SIZE. call_0b_4000_CollectibleList_LoadForCurrentLevel
; de-interleaves them into wC400_Collectible_GridX and wC500_Collectible_GridY and
; then builds two per-column index tables, so the per-frame draw never walks the
; list.
;
; The lists are authored sorted by ascending X, and pass 3 of that loader depends
; on it: moving a collectible to the left of an earlier one will place it, but the
; column index built at level load will not find it. Keep a list sorted.
;
; The list ends at the first record whose X is zero, which is also why no
; collectible can sit in column 0.
;
; Record layout - 2 bytes, COLLECTIBLE_RECORD_SIZE:
;   +0   db  grid_x, grid_y   - grid x, grid y
;
; 31 records.
; ==================================================================

    db   $31, $d8                              ; #$00
    db   $32, $d8                              ; #$01
    db   $5a, $c7                              ; #$02
    db   $5b, $c7                              ; #$03
    db   $64, $ca                              ; #$04
    db   $65, $ca                              ; #$05
    db   $68, $cd                              ; #$06
    db   $69, $cd                              ; #$07
    db   $70, $d3                              ; #$08
    db   $71, $d2                              ; #$09
    db   $72, $d2                              ; #$0a
    db   $73, $d3                              ; #$0b
    db   $7c, $d3                              ; #$0c
    db   $7d, $d2                              ; #$0d
    db   $7e, $d2                              ; #$0e
    db   $7f, $d3                              ; #$0f
    db   $93, $cf                              ; #$10
    db   $94, $ce                              ; #$11
    db   $95, $cf                              ; #$12
    db   $96, $ce                              ; #$13
    db   $97, $cf                              ; #$14
    db   $9c, $d8                              ; #$15
    db   $9d, $d8                              ; #$16
    db   $aa, $ce                              ; #$17
    db   $ab, $ce                              ; #$18
    db   $ae, $d5                              ; #$19
    db   $af, $d4                              ; #$1a
    db   $b0, $d0                              ; #$1b
    db   $b1, $d1                              ; #$1c
    db   $bc, $d0                              ; #$1d
    db   $bc, $d1                              ; #$1e
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
