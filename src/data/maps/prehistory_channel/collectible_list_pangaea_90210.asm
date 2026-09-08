; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/collectible_list_pangaea_90210.bin
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
; 113 records.
; ==================================================================

    db   $14, $26                              ; #$00
    db   $14, $27                              ; #$01
    db   $17, $26                              ; #$02
    db   $17, $27                              ; #$03
    db   $1e, $6e                              ; #$04
    db   $1e, $88                              ; #$05
    db   $1f, $6f                              ; #$06
    db   $1f, $70                              ; #$07
    db   $1f, $71                              ; #$08
    db   $1f, $88                              ; #$09
    db   $23, $6e                              ; #$0a
    db   $24, $6e                              ; #$0b
    db   $2b, $1c                              ; #$0c
    db   $2b, $22                              ; #$0d
    db   $2b, $6e                              ; #$0e
    db   $2c, $1f                              ; #$0f
    db   $2c, $6e                              ; #$10
    db   $3e, $20                              ; #$11
    db   $3e, $21                              ; #$12
    db   $3e, $22                              ; #$13
    db   $3e, $23                              ; #$14
    db   $3e, $76                              ; #$15
    db   $3e, $80                              ; #$16
    db   $3f, $77                              ; #$17
    db   $3f, $78                              ; #$18
    db   $3f, $79                              ; #$19
    db   $3f, $80                              ; #$1a
    db   $41, $20                              ; #$1b
    db   $41, $21                              ; #$1c
    db   $41, $22                              ; #$1d
    db   $41, $23                              ; #$1e
    db   $4a, $80                              ; #$1f
    db   $4b, $80                              ; #$20
    db   $4d, $22                              ; #$21
    db   $4e, $21                              ; #$22
    db   $4f, $21                              ; #$23
    db   $50, $21                              ; #$24
    db   $51, $21                              ; #$25
    db   $52, $22                              ; #$26
    db   $54, $62                              ; #$27
    db   $54, $63                              ; #$28
    db   $55, $62                              ; #$29
    db   $55, $63                              ; #$2a
    db   $66, $25                              ; #$2b
    db   $67, $24                              ; #$2c
    db   $68, $23                              ; #$2d
    db   $69, $23                              ; #$2e
    db   $6a, $24                              ; #$2f
    db   $6b, $25                              ; #$30
    db   $72, $80                              ; #$31
    db   $73, $80                              ; #$32
    db   $7b, $22                              ; #$33
    db   $7d, $21                              ; #$34
    db   $7f, $20                              ; #$35
    db   $80, $80                              ; #$36
    db   $81, $1f                              ; #$37
    db   $82, $7f                              ; #$38
    db   $84, $7e                              ; #$39
    db   $86, $7d                              ; #$3a
    db   $88, $1c                              ; #$3b
    db   $88, $1d                              ; #$3c
    db   $8a, $4f                              ; #$3d
    db   $8a, $51                              ; #$3e
    db   $8a, $53                              ; #$3f
    db   $8b, $4e                              ; #$40
    db   $8b, $50                              ; #$41
    db   $8b, $52                              ; #$42
    db   $98, $78                              ; #$43
    db   $99, $1c                              ; #$44
    db   $99, $1d                              ; #$45
    db   $99, $79                              ; #$46
    db   $9a, $78                              ; #$47
    db   $9b, $79                              ; #$48
    db   $a0, $1e                              ; #$49
    db   $a1, $1e                              ; #$4a
    db   $aa, $20                              ; #$4b
    db   $aa, $21                              ; #$4c
    db   $aa, $22                              ; #$4d
    db   $aa, $23                              ; #$4e
    db   $b5, $74                              ; #$4f
    db   $b5, $75                              ; #$50
    db   $b6, $1a                              ; #$51
    db   $b6, $73                              ; #$52
    db   $b7, $1b                              ; #$53
    db   $b7, $72                              ; #$54
    db   $b8, $10                              ; #$55
    db   $b8, $1c                              ; #$56
    db   $b8, $1d                              ; #$57
    db   $b8, $70                              ; #$58
    db   $b8, $71                              ; #$59
    db   $ba, $10                              ; #$5a
    db   $bc, $10                              ; #$5b
    db   $be, $10                              ; #$5c
    db   $c4, $10                              ; #$5d
    db   $c6, $12                              ; #$5e
    db   $c9, $24                              ; #$5f
    db   $c9, $25                              ; #$60
    db   $c9, $26                              ; #$61
    db   $c9, $27                              ; #$62
    db   $ca, $0e                              ; #$63
    db   $cc, $0b                              ; #$64
    db   $cd, $0a                              ; #$65
    db   $d6, $0d                              ; #$66
    db   $d6, $0f                              ; #$67
    db   $d6, $11                              ; #$68
    db   $d7, $0c                              ; #$69
    db   $d7, $0e                              ; #$6a
    db   $d7, $10                              ; #$6b
    db   $de, $18                              ; #$6c
    db   $e0, $19                              ; #$6d
    db   $e2, $1a                              ; #$6e
    db   $e8, $09                              ; #$6f
    db   $e9, $09                              ; #$70
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
