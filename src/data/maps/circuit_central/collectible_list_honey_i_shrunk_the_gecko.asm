; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/collectible_list_honey_i_shrunk_the_gecko.bin
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
; 194 records.
; ==================================================================

    db   $0e, $54                              ; #$00
    db   $0e, $55                              ; #$01
    db   $0e, $5c                              ; #$02
    db   $0e, $5d                              ; #$03
    db   $0e, $85                              ; #$04
    db   $0f, $54                              ; #$05
    db   $10, $85                              ; #$06
    db   $12, $85                              ; #$07
    db   $14, $84                              ; #$08
    db   $16, $54                              ; #$09
    db   $16, $85                              ; #$0a
    db   $17, $54                              ; #$0b
    db   $18, $bc                              ; #$0c
    db   $18, $bd                              ; #$0d
    db   $18, $c0                              ; #$0e
    db   $18, $c1                              ; #$0f
    db   $18, $c4                              ; #$10
    db   $18, $c5                              ; #$11
    db   $1d, $32                              ; #$12
    db   $1e, $32                              ; #$13
    db   $1e, $54                              ; #$14
    db   $1f, $32                              ; #$15
    db   $1f, $54                              ; #$16
    db   $20, $1a                              ; #$17
    db   $20, $1c                              ; #$18
    db   $21, $1b                              ; #$19
    db   $21, $1d                              ; #$1a
    db   $24, $32                              ; #$1b
    db   $25, $32                              ; #$1c
    db   $26, $32                              ; #$1d
    db   $26, $54                              ; #$1e
    db   $27, $54                              ; #$1f
    db   $2a, $3f                              ; #$20
    db   $2a, $62                              ; #$21
    db   $2a, $66                              ; #$22
    db   $2b, $3e                              ; #$23
    db   $2b, $63                              ; #$24
    db   $2b, $67                              ; #$25
    db   $2c, $3e                              ; #$26
    db   $2d, $3f                              ; #$27
    db   $32, $3f                              ; #$28
    db   $33, $3e                              ; #$29
    db   $34, $32                              ; #$2a
    db   $34, $34                              ; #$2b
    db   $34, $3e                              ; #$2c
    db   $34, $d3                              ; #$2d
    db   $35, $33                              ; #$2e
    db   $35, $35                              ; #$2f
    db   $35, $3f                              ; #$30
    db   $35, $d2                              ; #$31
    db   $36, $5d                              ; #$32
    db   $36, $d3                              ; #$33
    db   $37, $5d                              ; #$34
    db   $37, $aa                              ; #$35
    db   $37, $ab                              ; #$36
    db   $37, $ae                              ; #$37
    db   $37, $af                              ; #$38
    db   $37, $b2                              ; #$39
    db   $37, $b3                              ; #$3a
    db   $37, $d2                              ; #$3b
    db   $3e, $16                              ; #$3c
    db   $3e, $17                              ; #$3d
    db   $3f, $16                              ; #$3e
    db   $3f, $17                              ; #$3f
    db   $44, $41                              ; #$40
    db   $45, $40                              ; #$41
    db   $46, $41                              ; #$42
    db   $47, $40                              ; #$43
    db   $48, $41                              ; #$44
    db   $50, $47                              ; #$45
    db   $50, $49                              ; #$46
    db   $51, $46                              ; #$47
    db   $51, $48                              ; #$48
    db   $58, $84                              ; #$49
    db   $59, $84                              ; #$4a
    db   $5c, $5f                              ; #$4b
    db   $5d, $5f                              ; #$4c
    db   $61, $1e                              ; #$4d
    db   $61, $1f                              ; #$4e
    db   $62, $1e                              ; #$4f
    db   $62, $1f                              ; #$50
    db   $65, $5c                              ; #$51
    db   $67, $5a                              ; #$52
    db   $68, $66                              ; #$53
    db   $68, $67                              ; #$54
    db   $69, $58                              ; #$55
    db   $69, $66                              ; #$56
    db   $69, $67                              ; #$57
    db   $6b, $56                              ; #$58
    db   $6d, $54                              ; #$59
    db   $6f, $52                              ; #$5a
    db   $72, $7d                              ; #$5b
    db   $73, $7d                              ; #$5c
    db   $74, $66                              ; #$5d
    db   $74, $67                              ; #$5e
    db   $75, $66                              ; #$5f
    db   $75, $67                              ; #$60
    db   $7f, $7c                              ; #$61
    db   $80, $7c                              ; #$62
    db   $96, $40                              ; #$63
    db   $96, $42                              ; #$64
    db   $96, $58                              ; #$65
    db   $96, $5a                              ; #$66
    db   $96, $60                              ; #$67
    db   $96, $62                              ; #$68
    db   $97, $41                              ; #$69
    db   $97, $43                              ; #$6a
    db   $97, $59                              ; #$6b
    db   $97, $5b                              ; #$6c
    db   $97, $61                              ; #$6d
    db   $97, $63                              ; #$6e
    db   $98, $36                              ; #$6f
    db   $99, $36                              ; #$70
    db   $a2, $36                              ; #$71
    db   $a3, $36                              ; #$72
    db   $a4, $52                              ; #$73
    db   $a5, $53                              ; #$74
    db   $a6, $20                              ; #$75
    db   $a6, $21                              ; #$76
    db   $a6, $23                              ; #$77
    db   $a6, $26                              ; #$78
    db   $a6, $2a                              ; #$79
    db   $a8, $52                              ; #$7a
    db   $a9, $36                              ; #$7b
    db   $a9, $53                              ; #$7c
    db   $aa, $36                              ; #$7d
    db   $b2, $60                              ; #$7e
    db   $b2, $62                              ; #$7f
    db   $b2, $80                              ; #$80
    db   $b2, $81                              ; #$81
    db   $b2, $82                              ; #$82
    db   $b2, $83                              ; #$83
    db   $b3, $61                              ; #$84
    db   $b3, $63                              ; #$85
    db   $c8, $60                              ; #$86
    db   $c8, $62                              ; #$87
    db   $c9, $61                              ; #$88
    db   $c9, $63                              ; #$89
    db   $d4, $7c                              ; #$8a
    db   $d4, $7d                              ; #$8b
    db   $d5, $7c                              ; #$8c
    db   $d5, $7d                              ; #$8d
    db   $d6, $12                              ; #$8e
    db   $d7, $13                              ; #$8f
    db   $d8, $12                              ; #$90
    db   $d9, $13                              ; #$91
    db   $dc, $3f                              ; #$92
    db   $dd, $3f                              ; #$93
    db   $de, $3c                              ; #$94
    db   $de, $42                              ; #$95
    db   $df, $3c                              ; #$96
    db   $df, $42                              ; #$97
    db   $e3, $0a                              ; #$98
    db   $e5, $08                              ; #$99
    db   $e7, $09                              ; #$9a
    db   $e8, $41                              ; #$9b
    db   $e8, $43                              ; #$9c
    db   $e8, $46                              ; #$9d
    db   $e8, $48                              ; #$9e
    db   $e8, $4d                              ; #$9f
    db   $e8, $4f                              ; #$a0
    db   $e9, $08                              ; #$a1
    db   $e9, $40                              ; #$a2
    db   $e9, $42                              ; #$a3
    db   $e9, $47                              ; #$a4
    db   $e9, $49                              ; #$a5
    db   $e9, $4c                              ; #$a6
    db   $e9, $4e                              ; #$a7
    db   $eb, $0b                              ; #$a8
    db   $ed, $09                              ; #$a9
    db   $ee, $94                              ; #$aa
    db   $ef, $94                              ; #$ab
    db   $f0, $7c                              ; #$ac
    db   $f1, $7e                              ; #$ad
    db   $f2, $80                              ; #$ae
    db   $f2, $82                              ; #$af
    db   $f2, $8e                              ; #$b0
    db   $f3, $83                              ; #$b1
    db   $f3, $8e                              ; #$b2
    db   $f3, $9b                              ; #$b3
    db   $f4, $14                              ; #$b4
    db   $f4, $1e                              ; #$b5
    db   $f5, $14                              ; #$b6
    db   $f5, $1e                              ; #$b7
    db   $f5, $9c                              ; #$b8
    db   $f6, $14                              ; #$b9
    db   $f6, $1e                              ; #$ba
    db   $f6, $88                              ; #$bb
    db   $f6, $9e                              ; #$bc
    db   $f6, $a0                              ; #$bd
    db   $f6, $a1                              ; #$be
    db   $f7, $14                              ; #$bf
    db   $f7, $1e                              ; #$c0
    db   $f7, $88                              ; #$c1
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
