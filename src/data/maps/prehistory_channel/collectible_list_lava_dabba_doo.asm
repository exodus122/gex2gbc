; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/collectible_list_lava_dabba_doo.bin
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
; 134 records.
; ==================================================================

    db   $0c, $26                              ; #$00
    db   $0c, $27                              ; #$01
    db   $0c, $28                              ; #$02
    db   $0c, $29                              ; #$03
    db   $0c, $3c                              ; #$04
    db   $0d, $3d                              ; #$05
    db   $0e, $39                              ; #$06
    db   $0f, $38                              ; #$07
    db   $10, $3d                              ; #$08
    db   $11, $3c                              ; #$09
    db   $12, $1b                              ; #$0a
    db   $12, $1d                              ; #$0b
    db   $13, $1a                              ; #$0c
    db   $13, $1c                              ; #$0d
    db   $16, $23                              ; #$0e
    db   $16, $25                              ; #$0f
    db   $16, $70                              ; #$10
    db   $16, $71                              ; #$11
    db   $16, $72                              ; #$12
    db   $16, $73                              ; #$13
    db   $17, $22                              ; #$14
    db   $17, $24                              ; #$15
    db   $17, $69                              ; #$16
    db   $17, $6b                              ; #$17
    db   $18, $6a                              ; #$18
    db   $18, $6c                              ; #$19
    db   $1c, $75                              ; #$1a
    db   $1d, $74                              ; #$1b
    db   $1e, $74                              ; #$1c
    db   $1f, $75                              ; #$1d
    db   $20, $29                              ; #$1e
    db   $20, $5d                              ; #$1f
    db   $21, $29                              ; #$20
    db   $21, $5d                              ; #$21
    db   $22, $29                              ; #$22
    db   $22, $5d                              ; #$23
    db   $23, $29                              ; #$24
    db   $23, $5d                              ; #$25
    db   $2c, $50                              ; #$26
    db   $2c, $51                              ; #$27
    db   $2d, $50                              ; #$28
    db   $2d, $51                              ; #$29
    db   $34, $4e                              ; #$2a
    db   $34, $4f                              ; #$2b
    db   $35, $4e                              ; #$2c
    db   $35, $4f                              ; #$2d
    db   $35, $6f                              ; #$2e
    db   $35, $71                              ; #$2f
    db   $36, $29                              ; #$30
    db   $36, $5d                              ; #$31
    db   $36, $70                              ; #$32
    db   $36, $72                              ; #$33
    db   $37, $29                              ; #$34
    db   $37, $5d                              ; #$35
    db   $3c, $3c                              ; #$36
    db   $3c, $3e                              ; #$37
    db   $3d, $3d                              ; #$38
    db   $3d, $3f                              ; #$39
    db   $40, $29                              ; #$3a
    db   $41, $29                              ; #$3b
    db   $42, $29                              ; #$3c
    db   $43, $29                              ; #$3d
    db   $44, $29                              ; #$3e
    db   $45, $29                              ; #$3f
    db   $4a, $3d                              ; #$40
    db   $4a, $3f                              ; #$41
    db   $4b, $3c                              ; #$42
    db   $4b, $3e                              ; #$43
    db   $4c, $73                              ; #$44
    db   $4d, $72                              ; #$45
    db   $4e, $72                              ; #$46
    db   $4f, $73                              ; #$47
    db   $61, $71                              ; #$48
    db   $61, $73                              ; #$49
    db   $61, $75                              ; #$4a
    db   $62, $5d                              ; #$4b
    db   $62, $72                              ; #$4c
    db   $62, $74                              ; #$4d
    db   $63, $5d                              ; #$4e
    db   $6a, $5d                              ; #$4f
    db   $6b, $5d                              ; #$50
    db   $70, $58                              ; #$51
    db   $70, $59                              ; #$52
    db   $70, $5a                              ; #$53
    db   $70, $5b                              ; #$54
    db   $78, $75                              ; #$55
    db   $79, $75                              ; #$56
    db   $82, $23                              ; #$57
    db   $82, $25                              ; #$58
    db   $82, $6c                              ; #$59
    db   $83, $22                              ; #$5a
    db   $83, $24                              ; #$5b
    db   $83, $6c                              ; #$5c
    db   $84, $71                              ; #$5d
    db   $85, $71                              ; #$5e
    db   $88, $27                              ; #$5f
    db   $88, $28                              ; #$60
    db   $88, $6a                              ; #$61
    db   $89, $26                              ; #$62
    db   $89, $6a                              ; #$63
    db   $8a, $25                              ; #$64
    db   $8b, $25                              ; #$65
    db   $8c, $26                              ; #$66
    db   $8d, $27                              ; #$67
    db   $92, $1d                              ; #$68
    db   $92, $1f                              ; #$69
    db   $92, $21                              ; #$6a
    db   $93, $1c                              ; #$6b
    db   $93, $1e                              ; #$6c
    db   $93, $20                              ; #$6d
    db   $9a, $24                              ; #$6e
    db   $9b, $25                              ; #$6f
    db   $9c, $24                              ; #$70
    db   $9d, $25                              ; #$71
    db   $a2, $24                              ; #$72
    db   $a3, $25                              ; #$73
    db   $a4, $24                              ; #$74
    db   $a5, $25                              ; #$75
    db   $aa, $24                              ; #$76
    db   $ab, $25                              ; #$77
    db   $ac, $24                              ; #$78
    db   $ad, $25                              ; #$79
    db   $af, $10                              ; #$7a
    db   $af, $11                              ; #$7b
    db   $b0, $10                              ; #$7c
    db   $b0, $11                              ; #$7d
    db   $b4, $24                              ; #$7e
    db   $b5, $25                              ; #$7f
    db   $b6, $24                              ; #$80
    db   $b7, $25                              ; #$81
    db   $bf, $6e                              ; #$82
    db   $bf, $6f                              ; #$83
    db   $c0, $6e                              ; #$84
    db   $c0, $6f                              ; #$85
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
