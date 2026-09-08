; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/collectible_list_this_old_cave.bin
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
; 126 records.
; ==================================================================

    db   $21, $e2                              ; #$00
    db   $21, $e3                              ; #$01
    db   $22, $e2                              ; #$02
    db   $22, $e3                              ; #$03
    db   $2f, $e3                              ; #$04
    db   $30, $e3                              ; #$05
    db   $35, $e7                              ; #$06
    db   $36, $e7                              ; #$07
    db   $37, $e7                              ; #$08
    db   $38, $e7                              ; #$09
    db   $4f, $df                              ; #$0a
    db   $50, $df                              ; #$0b
    db   $53, $e1                              ; #$0c
    db   $54, $dd                              ; #$0d
    db   $54, $e1                              ; #$0e
    db   $55, $dd                              ; #$0f
    db   $56, $dd                              ; #$10
    db   $57, $dd                              ; #$11
    db   $57, $e3                              ; #$12
    db   $58, $e3                              ; #$13
    db   $5d, $d4                              ; #$14
    db   $5d, $d6                              ; #$15
    db   $5e, $d3                              ; #$16
    db   $5f, $d2                              ; #$17
    db   $5f, $e5                              ; #$18
    db   $60, $e5                              ; #$19
    db   $61, $d2                              ; #$1a
    db   $63, $e5                              ; #$1b
    db   $64, $e5                              ; #$1c
    db   $66, $c5                              ; #$1d
    db   $66, $c7                              ; #$1e
    db   $67, $c4                              ; #$1f
    db   $67, $c6                              ; #$20
    db   $68, $d3                              ; #$21
    db   $69, $d3                              ; #$22
    db   $72, $ca                              ; #$23
    db   $72, $cb                              ; #$24
    db   $76, $c3                              ; #$25
    db   $76, $d3                              ; #$26
    db   $77, $c2                              ; #$27
    db   $77, $d3                              ; #$28
    db   $78, $c2                              ; #$29
    db   $78, $ec                              ; #$2a
    db   $78, $ed                              ; #$2b
    db   $78, $ee                              ; #$2c
    db   $78, $ef                              ; #$2d
    db   $78, $f0                              ; #$2e
    db   $78, $f1                              ; #$2f
    db   $79, $c3                              ; #$30
    db   $85, $dc                              ; #$31
    db   $85, $dd                              ; #$32
    db   $85, $de                              ; #$33
    db   $85, $df                              ; #$34
    db   $87, $d8                              ; #$35
    db   $87, $d9                              ; #$36
    db   $92, $eb                              ; #$37
    db   $93, $eb                              ; #$38
    db   $94, $eb                              ; #$39
    db   $95, $eb                              ; #$3a
    db   $96, $e6                              ; #$3b
    db   $97, $e6                              ; #$3c
    db   $a4, $df                              ; #$3d
    db   $a5, $df                              ; #$3e
    db   $a6, $d6                              ; #$3f
    db   $a6, $d7                              ; #$40
    db   $a6, $d8                              ; #$41
    db   $a6, $d9                              ; #$42
    db   $a6, $e1                              ; #$43
    db   $a7, $e1                              ; #$44
    db   $a8, $d3                              ; #$45
    db   $a8, $ef                              ; #$46
    db   $a9, $d3                              ; #$47
    db   $a9, $ee                              ; #$48
    db   $aa, $ee                              ; #$49
    db   $ab, $ef                              ; #$4a
    db   $ac, $d4                              ; #$4b
    db   $ad, $d4                              ; #$4c
    db   $b0, $d6                              ; #$4d
    db   $b1, $d6                              ; #$4e
    db   $b4, $eb                              ; #$4f
    db   $b5, $eb                              ; #$50
    db   $b6, $d8                              ; #$51
    db   $b6, $e8                              ; #$52
    db   $b7, $d8                              ; #$53
    db   $b7, $e8                              ; #$54
    db   $bf, $d9                              ; #$55
    db   $bf, $ec                              ; #$56
    db   $bf, $ed                              ; #$57
    db   $bf, $ee                              ; #$58
    db   $bf, $ef                              ; #$59
    db   $c0, $e8                              ; #$5a
    db   $c1, $da                              ; #$5b
    db   $c1, $e8                              ; #$5c
    db   $c3, $db                              ; #$5d
    db   $c4, $e8                              ; #$5e
    db   $c5, $e8                              ; #$5f
    db   $c9, $ec                              ; #$60
    db   $c9, $ed                              ; #$61
    db   $c9, $ee                              ; #$62
    db   $c9, $ef                              ; #$63
    db   $cf, $db                              ; #$64
    db   $d0, $da                              ; #$65
    db   $d1, $da                              ; #$66
    db   $d2, $db                              ; #$67
    db   $d3, $dc                              ; #$68
    db   $d5, $ec                              ; #$69
    db   $d5, $ed                              ; #$6a
    db   $d5, $ee                              ; #$6b
    db   $d5, $ef                              ; #$6c
    db   $d8, $de                              ; #$6d
    db   $d9, $de                              ; #$6e
    db   $dc, $dc                              ; #$6f
    db   $dd, $dc                              ; #$70
    db   $e0, $dd                              ; #$71
    db   $e0, $ef                              ; #$72
    db   $e1, $dd                              ; #$73
    db   $e1, $ee                              ; #$74
    db   $e2, $ef                              ; #$75
    db   $e3, $ee                              ; #$76
    db   $e4, $ef                              ; #$77
    db   $e5, $ee                              ; #$78
    db   $e6, $ef                              ; #$79
    db   $e7, $ee                              ; #$7a
    db   $e8, $ef                              ; #$7b
    db   $ec, $d8                              ; #$7c
    db   $ed, $d8                              ; #$7d
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
