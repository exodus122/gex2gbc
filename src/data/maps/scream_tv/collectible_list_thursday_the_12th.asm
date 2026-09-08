; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/collectible_list_thursday_the_12th.bin
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
; 50 records.
; ==================================================================

    db   $c9, $68                              ; #$00
    db   $c9, $74                              ; #$01
    db   $ce, $68                              ; #$02
    db   $ce, $74                              ; #$03
    db   $cf, $aa                              ; #$04
    db   $d0, $96                              ; #$05
    db   $d2, $9c                              ; #$06
    db   $d2, $aa                              ; #$07
    db   $d3, $5c                              ; #$08
    db   $d3, $62                              ; #$09
    db   $d3, $6e                              ; #$0a
    db   $d3, $a4                              ; #$0b
    db   $d6, $a4                              ; #$0c
    db   $d8, $62                              ; #$0d
    db   $d8, $6e                              ; #$0e
    db   $d9, $5c                              ; #$0f
    db   $d9, $aa                              ; #$10
    db   $da, $5b                              ; #$11
    db   $da, $74                              ; #$12
    db   $da, $7c                              ; #$13
    db   $da, $82                              ; #$14
    db   $da, $96                              ; #$15
    db   $db, $5b                              ; #$16
    db   $db, $7c                              ; #$17
    db   $dc, $5c                              ; #$18
    db   $dc, $aa                              ; #$19
    db   $dd, $62                              ; #$1a
    db   $dd, $90                              ; #$1b
    db   $e2, $5c                              ; #$1c
    db   $e2, $62                              ; #$1d
    db   $e2, $88                              ; #$1e
    db   $e3, $5b                              ; #$1f
    db   $e3, $90                              ; #$20
    db   $e3, $a4                              ; #$21
    db   $e3, $aa                              ; #$22
    db   $e4, $5c                              ; #$23
    db   $e4, $87                              ; #$24
    db   $e6, $74                              ; #$25
    db   $e6, $88                              ; #$26
    db   $e6, $90                              ; #$27
    db   $e6, $96                              ; #$28
    db   $e6, $9c                              ; #$29
    db   $e6, $a4                              ; #$2a
    db   $e6, $aa                              ; #$2b
    db   $e7, $68                              ; #$2c
    db   $e7, $6e                              ; #$2d
    db   $e7, $7c                              ; #$2e
    db   $ec, $68                              ; #$2f
    db   $ec, $7c                              ; #$30
    db   $ec, $90                              ; #$31
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
