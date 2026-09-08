; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/toon_tv/collectible_list_fine_tooning.bin
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
; 98 records.
; ==================================================================

    db   $04, $d3                              ; #$00
    db   $06, $d3                              ; #$01
    db   $14, $d4                              ; #$02
    db   $18, $ab                              ; #$03
    db   $18, $ac                              ; #$04
    db   $18, $b0                              ; #$05
    db   $18, $b1                              ; #$06
    db   $18, $b4                              ; #$07
    db   $18, $b5                              ; #$08
    db   $18, $b8                              ; #$09
    db   $18, $b9                              ; #$0a
    db   $18, $bb                              ; #$0b
    db   $18, $c0                              ; #$0c
    db   $18, $c1                              ; #$0d
    db   $18, $c3                              ; #$0e
    db   $18, $c8                              ; #$0f
    db   $18, $c9                              ; #$10
    db   $18, $d4                              ; #$11
    db   $20, $d4                              ; #$12
    db   $22, $88                              ; #$13
    db   $22, $d4                              ; #$14
    db   $23, $88                              ; #$15
    db   $25, $b0                              ; #$16
    db   $25, $b1                              ; #$17
    db   $25, $b3                              ; #$18
    db   $25, $b8                              ; #$19
    db   $25, $b9                              ; #$1a
    db   $25, $bc                              ; #$1b
    db   $25, $bd                              ; #$1c
    db   $25, $bf                              ; #$1d
    db   $25, $c4                              ; #$1e
    db   $25, $c5                              ; #$1f
    db   $26, $88                              ; #$20
    db   $27, $88                              ; #$21
    db   $2e, $d3                              ; #$22
    db   $32, $c9                              ; #$23
    db   $32, $d3                              ; #$24
    db   $36, $96                              ; #$25
    db   $36, $c9                              ; #$26
    db   $36, $d3                              ; #$27
    db   $3a, $c9                              ; #$28
    db   $3c, $96                              ; #$29
    db   $41, $d3                              ; #$2a
    db   $44, $d3                              ; #$2b
    db   $5c, $96                              ; #$2c
    db   $5f, $d3                              ; #$2d
    db   $60, $96                              ; #$2e
    db   $62, $d3                              ; #$2f
    db   $68, $c6                              ; #$30
    db   $69, $c5                              ; #$31
    db   $69, $c7                              ; #$32
    db   $6a, $c6                              ; #$33
    db   $6c, $97                              ; #$34
    db   $6f, $97                              ; #$35
    db   $75, $e8                              ; #$36
    db   $76, $d3                              ; #$37
    db   $76, $e5                              ; #$38
    db   $78, $a6                              ; #$39
    db   $79, $a5                              ; #$3a
    db   $79, $a7                              ; #$3b
    db   $79, $d3                              ; #$3c
    db   $7a, $a6                              ; #$3d
    db   $7f, $ec                              ; #$3e
    db   $86, $cb                              ; #$3f
    db   $8a, $cd                              ; #$40
    db   $8e, $cf                              ; #$41
    db   $92, $d1                              ; #$42
    db   $92, $ee                              ; #$43
    db   $92, $f0                              ; #$44
    db   $93, $ef                              ; #$45
    db   $a4, $ee                              ; #$46
    db   $a4, $f0                              ; #$47
    db   $a5, $ef                              ; #$48
    db   $af, $f2                              ; #$49
    db   $b1, $f2                              ; #$4a
    db   $b3, $f2                              ; #$4b
    db   $b6, $f9                              ; #$4c
    db   $b8, $d2                              ; #$4d
    db   $b8, $d3                              ; #$4e
    db   $b8, $f9                              ; #$4f
    db   $b9, $d2                              ; #$50
    db   $b9, $d3                              ; #$51
    db   $ba, $f9                              ; #$52
    db   $bc, $b2                              ; #$53
    db   $bc, $b4                              ; #$54
    db   $bd, $b3                              ; #$55
    db   $bd, $b5                              ; #$56
    db   $c2, $f3                              ; #$57
    db   $c4, $f3                              ; #$58
    db   $c6, $f3                              ; #$59
    db   $e8, $fa                              ; #$5a
    db   $e9, $fa                              ; #$5b
    db   $ee, $fa                              ; #$5c
    db   $ef, $fa                              ; #$5d
    db   $f4, $fa                              ; #$5e
    db   $f5, $fa                              ; #$5f
    db   $fa, $fa                              ; #$60
    db   $fb, $fa                              ; #$61
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
