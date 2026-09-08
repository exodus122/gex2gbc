; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/toon_tv/collectible_list_out_of_toon.bin
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
; 137 records.
; ==================================================================

    db   $05, $16                              ; #$00
    db   $05, $1a                              ; #$01
    db   $05, $4d                              ; #$02
    db   $07, $4d                              ; #$03
    db   $08, $18                              ; #$04
    db   $0e, $1c                              ; #$05
    db   $16, $6f                              ; #$06
    db   $17, $6e                              ; #$07
    db   $17, $70                              ; #$08
    db   $1e, $71                              ; #$09
    db   $1f, $70                              ; #$0a
    db   $1f, $72                              ; #$0b
    db   $20, $4b                              ; #$0c
    db   $20, $4d                              ; #$0d
    db   $21, $4c                              ; #$0e
    db   $21, $4e                              ; #$0f
    db   $22, $24                              ; #$10
    db   $23, $22                              ; #$11
    db   $24, $21                              ; #$12
    db   $26, $20                              ; #$13
    db   $28, $21                              ; #$14
    db   $29, $22                              ; #$15
    db   $29, $4c                              ; #$16
    db   $2c, $4a                              ; #$17
    db   $2f, $42                              ; #$18
    db   $30, $40                              ; #$19
    db   $31, $22                              ; #$1a
    db   $32, $3f                              ; #$1b
    db   $32, $43                              ; #$1c
    db   $32, $4f                              ; #$1d
    db   $33, $22                              ; #$1e
    db   $33, $43                              ; #$1f
    db   $33, $4e                              ; #$20
    db   $34, $40                              ; #$21
    db   $36, $6c                              ; #$22
    db   $37, $22                              ; #$23
    db   $38, $6c                              ; #$24
    db   $3b, $22                              ; #$25
    db   $3c, $29                              ; #$26
    db   $3e, $29                              ; #$27
    db   $40, $29                              ; #$28
    db   $48, $4a                              ; #$29
    db   $49, $4a                              ; #$2a
    db   $4a, $78                              ; #$2b
    db   $4e, $78                              ; #$2c
    db   $51, $3e                              ; #$2d
    db   $52, $78                              ; #$2e
    db   $54, $13                              ; #$2f
    db   $56, $13                              ; #$30
    db   $56, $78                              ; #$31
    db   $58, $13                              ; #$32
    db   $5a, $78                              ; #$33
    db   $5e, $78                              ; #$34
    db   $5f, $3a                              ; #$35
    db   $62, $78                              ; #$36
    db   $63, $4e                              ; #$37
    db   $63, $4f                              ; #$38
    db   $63, $50                              ; #$39
    db   $63, $51                              ; #$3a
    db   $64, $69                              ; #$3b
    db   $66, $69                              ; #$3c
    db   $66, $78                              ; #$3d
    db   $68, $44                              ; #$3e
    db   $6a, $78                              ; #$3f
    db   $6d, $72                              ; #$40
    db   $6e, $78                              ; #$41
    db   $6f, $36                              ; #$42
    db   $70, $1d                              ; #$43
    db   $70, $72                              ; #$44
    db   $71, $6c                              ; #$45
    db   $72, $78                              ; #$46
    db   $73, $1c                              ; #$47
    db   $74, $0f                              ; #$48
    db   $74, $6c                              ; #$49
    db   $76, $78                              ; #$4a
    db   $78, $38                              ; #$4b
    db   $7b, $76                              ; #$4c
    db   $7b, $77                              ; #$4d
    db   $7b, $78                              ; #$4e
    db   $7b, $79                              ; #$4f
    db   $7d, $12                              ; #$50
    db   $7e, $43                              ; #$51
    db   $7f, $04                              ; #$52
    db   $7f, $43                              ; #$53
    db   $80, $38                              ; #$54
    db   $81, $04                              ; #$55
    db   $82, $03                              ; #$56
    db   $82, $38                              ; #$57
    db   $83, $12                              ; #$58
    db   $86, $3e                              ; #$59
    db   $87, $3e                              ; #$5a
    db   $87, $67                              ; #$5b
    db   $88, $60                              ; #$5c
    db   $89, $12                              ; #$5d
    db   $8c, $61                              ; #$5e
    db   $8c, $66                              ; #$5f
    db   $8f, $12                              ; #$60
    db   $92, $64                              ; #$61
    db   $93, $40                              ; #$62
    db   $93, $5e                              ; #$63
    db   $94, $40                              ; #$64
    db   $95, $12                              ; #$65
    db   $98, $0c                              ; #$66
    db   $99, $0b                              ; #$67
    db   $9a, $0b                              ; #$68
    db   $9b, $0c                              ; #$69
    db   $ad, $1b                              ; #$6a
    db   $af, $34                              ; #$6b
    db   $b0, $08                              ; #$6c
    db   $b1, $1b                              ; #$6d
    db   $b2, $08                              ; #$6e
    db   $b2, $36                              ; #$6f
    db   $b5, $1b                              ; #$70
    db   $b7, $34                              ; #$71
    db   $b7, $74                              ; #$72
    db   $b8, $18                              ; #$73
    db   $ba, $18                              ; #$74
    db   $bb, $34                              ; #$75
    db   $bc, $18                              ; #$76
    db   $bd, $1b                              ; #$77
    db   $be, $74                              ; #$78
    db   $c3, $36                              ; #$79
    db   $c7, $14                              ; #$7a
    db   $c9, $16                              ; #$7b
    db   $cd, $18                              ; #$7c
    db   $cf, $78                              ; #$7d
    db   $dd, $15                              ; #$7e
    db   $dd, $16                              ; #$7f
    db   $dd, $17                              ; #$80
    db   $e7, $76                              ; #$81
    db   $e8, $76                              ; #$82
    db   $f8, $67                              ; #$83
    db   $f8, $68                              ; #$84
    db   $f8, $69                              ; #$85
    db   $f8, $77                              ; #$86
    db   $f8, $78                              ; #$87
    db   $f8, $79                              ; #$88
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
