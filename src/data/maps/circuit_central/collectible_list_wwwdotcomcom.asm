; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/collectible_list_wwwdotcomcom.bin
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
; 122 records.
; ==================================================================

    db   $08, $3f                              ; #$00
    db   $08, $78                              ; #$01
    db   $09, $3e                              ; #$02
    db   $09, $53                              ; #$03
    db   $09, $56                              ; #$04
    db   $09, $59                              ; #$05
    db   $09, $5c                              ; #$06
    db   $09, $78                              ; #$07
    db   $0a, $28                              ; #$08
    db   $0a, $29                              ; #$09
    db   $0a, $2a                              ; #$0a
    db   $0a, $2b                              ; #$0b
    db   $0c, $51                              ; #$0c
    db   $0d, $51                              ; #$0d
    db   $0e, $55                              ; #$0e
    db   $0f, $55                              ; #$0f
    db   $10, $83                              ; #$10
    db   $11, $83                              ; #$11
    db   $1a, $58                              ; #$12
    db   $1a, $5a                              ; #$13
    db   $1b, $59                              ; #$14
    db   $1b, $5b                              ; #$15
    db   $1e, $24                              ; #$16
    db   $1e, $26                              ; #$17
    db   $1f, $25                              ; #$18
    db   $1f, $27                              ; #$19
    db   $26, $24                              ; #$1a
    db   $27, $25                              ; #$1b
    db   $28, $24                              ; #$1c
    db   $28, $72                              ; #$1d
    db   $29, $25                              ; #$1e
    db   $29, $72                              ; #$1f
    db   $2c, $1f                              ; #$20
    db   $2c, $6e                              ; #$21
    db   $2d, $1e                              ; #$22
    db   $2d, $6e                              ; #$23
    db   $2e, $1f                              ; #$24
    db   $2e, $6a                              ; #$25
    db   $2e, $7c                              ; #$26
    db   $2f, $1e                              ; #$27
    db   $2f, $6a                              ; #$28
    db   $2f, $7c                              ; #$29
    db   $3a, $0c                              ; #$2a
    db   $3a, $0e                              ; #$2b
    db   $3b, $0d                              ; #$2c
    db   $3b, $0f                              ; #$2d
    db   $3e, $21                              ; #$2e
    db   $3e, $23                              ; #$2f
    db   $3f, $20                              ; #$30
    db   $3f, $22                              ; #$31
    db   $42, $5c                              ; #$32
    db   $43, $5c                              ; #$33
    db   $48, $88                              ; #$34
    db   $48, $8a                              ; #$35
    db   $49, $5c                              ; #$36
    db   $49, $89                              ; #$37
    db   $49, $8b                              ; #$38
    db   $4a, $5c                              ; #$39
    db   $4b, $28                              ; #$3a
    db   $4b, $29                              ; #$3b
    db   $4c, $28                              ; #$3c
    db   $4c, $29                              ; #$3d
    db   $54, $85                              ; #$3e
    db   $55, $84                              ; #$3f
    db   $56, $83                              ; #$40
    db   $57, $82                              ; #$41
    db   $5a, $82                              ; #$42
    db   $5b, $83                              ; #$43
    db   $5c, $84                              ; #$44
    db   $5d, $85                              ; #$45
    db   $68, $5e                              ; #$46
    db   $69, $5e                              ; #$47
    db   $69, $66                              ; #$48
    db   $6f, $65                              ; #$49
    db   $77, $66                              ; #$4a
    db   $79, $08                              ; #$4b
    db   $79, $0a                              ; #$4c
    db   $7a, $09                              ; #$4d
    db   $7a, $0b                              ; #$4e
    db   $7a, $5d                              ; #$4f
    db   $7b, $5c                              ; #$50
    db   $7c, $5c                              ; #$51
    db   $7d, $5d                              ; #$52
    db   $7d, $64                              ; #$53
    db   $83, $65                              ; #$54
    db   $89, $64                              ; #$55
    db   $8d, $66                              ; #$56
    db   $90, $5d                              ; #$57
    db   $91, $5c                              ; #$58
    db   $92, $5c                              ; #$59
    db   $93, $5d                              ; #$5a
    db   $95, $64                              ; #$5b
    db   $98, $7e                              ; #$5c
    db   $99, $7e                              ; #$5d
    db   $9b, $65                              ; #$5e
    db   $a0, $83                              ; #$5f
    db   $a0, $84                              ; #$60
    db   $a1, $64                              ; #$61
    db   $a1, $83                              ; #$62
    db   $a1, $84                              ; #$63
    db   $a8, $7e                              ; #$64
    db   $a9, $60                              ; #$65
    db   $a9, $61                              ; #$66
    db   $a9, $62                              ; #$67
    db   $a9, $63                              ; #$68
    db   $a9, $7e                              ; #$69
    db   $b0, $7a                              ; #$6a
    db   $b1, $7a                              ; #$6b
    db   $c0, $7a                              ; #$6c
    db   $c1, $7a                              ; #$6d
    db   $d6, $75                              ; #$6e
    db   $d6, $77                              ; #$6f
    db   $d7, $74                              ; #$70
    db   $d7, $76                              ; #$71
    db   $ee, $7b                              ; #$72
    db   $ee, $7d                              ; #$73
    db   $ee, $7f                              ; #$74
    db   $ee, $81                              ; #$75
    db   $ef, $7a                              ; #$76
    db   $ef, $7c                              ; #$77
    db   $ef, $7e                              ; #$78
    db   $ef, $80                              ; #$79
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
