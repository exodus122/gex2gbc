; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/rezopolis/collectible_list_mazed_and_confused.bin
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
; 135 records.
; ==================================================================

    db   $37, $75                              ; #$00
    db   $37, $76                              ; #$01
    db   $37, $77                              ; #$02
    db   $37, $78                              ; #$03
    db   $3c, $86                              ; #$04
    db   $3d, $86                              ; #$05
    db   $45, $71                              ; #$06
    db   $46, $6f                              ; #$07
    db   $47, $6e                              ; #$08
    db   $49, $3a                              ; #$09
    db   $49, $44                              ; #$0a
    db   $49, $54                              ; #$0b
    db   $49, $55                              ; #$0c
    db   $4a, $3a                              ; #$0d
    db   $4a, $44                              ; #$0e
    db   $54, $41                              ; #$0f
    db   $54, $6f                              ; #$10
    db   $54, $71                              ; #$11
    db   $55, $41                              ; #$12
    db   $55, $6e                              ; #$13
    db   $55, $70                              ; #$14
    db   $58, $47                              ; #$15
    db   $59, $47                              ; #$16
    db   $5c, $3d                              ; #$17
    db   $5c, $4d                              ; #$18
    db   $5d, $3d                              ; #$19
    db   $5d, $4d                              ; #$1a
    db   $5e, $4d                              ; #$1b
    db   $5f, $4d                              ; #$1c
    db   $5f, $72                              ; #$1d
    db   $60, $74                              ; #$1e
    db   $62, $6b                              ; #$1f
    db   $62, $6d                              ; #$20
    db   $63, $6a                              ; #$21
    db   $63, $6c                              ; #$22
    db   $64, $77                              ; #$23
    db   $65, $76                              ; #$24
    db   $6a, $76                              ; #$25
    db   $6b, $77                              ; #$26
    db   $6c, $6d                              ; #$27
    db   $6d, $6d                              ; #$28
    db   $72, $6d                              ; #$29
    db   $73, $6d                              ; #$2a
    db   $78, $6d                              ; #$2b
    db   $79, $6d                              ; #$2c
    db   $8a, $5c                              ; #$2d
    db   $8a, $5e                              ; #$2e
    db   $8a, $6a                              ; #$2f
    db   $8b, $5d                              ; #$30
    db   $8b, $5f                              ; #$31
    db   $8b, $68                              ; #$32
    db   $8c, $4f                              ; #$33
    db   $8d, $4f                              ; #$34
    db   $8e, $48                              ; #$35
    db   $8e, $58                              ; #$36
    db   $8f, $46                              ; #$37
    db   $8f, $56                              ; #$38
    db   $90, $29                              ; #$39
    db   $90, $2b                              ; #$3a
    db   $90, $62                              ; #$3b
    db   $91, $28                              ; #$3c
    db   $91, $2a                              ; #$3d
    db   $91, $60                              ; #$3e
    db   $9a, $31                              ; #$3f
    db   $9b, $31                              ; #$40
    db   $9c, $20                              ; #$41
    db   $9c, $34                              ; #$42
    db   $9c, $3e                              ; #$43
    db   $9d, $20                              ; #$44
    db   $9d, $35                              ; #$45
    db   $9d, $3f                              ; #$46
    db   $9e, $08                              ; #$47
    db   $9e, $09                              ; #$48
    db   $9e, $31                              ; #$49
    db   $9e, $4c                              ; #$4a
    db   $9e, $4d                              ; #$4b
    db   $9e, $54                              ; #$4c
    db   $9e, $55                              ; #$4d
    db   $9f, $31                              ; #$4e
    db   $9f, $4c                              ; #$4f
    db   $9f, $4d                              ; #$50
    db   $9f, $54                              ; #$51
    db   $9f, $55                              ; #$52
    db   $ac, $30                              ; #$53
    db   $ac, $32                              ; #$54
    db   $ad, $31                              ; #$55
    db   $ad, $33                              ; #$56
    db   $ae, $28                              ; #$57
    db   $ae, $3c                              ; #$58
    db   $af, $28                              ; #$59
    db   $af, $3c                              ; #$5a
    db   $b4, $5a                              ; #$5b
    db   $b5, $5a                              ; #$5c
    db   $ba, $59                              ; #$5d
    db   $bb, $0c                              ; #$5e
    db   $bb, $0d                              ; #$5f
    db   $bb, $59                              ; #$60
    db   $be, $44                              ; #$61
    db   $bf, $44                              ; #$62
    db   $c0, $5b                              ; #$63
    db   $c1, $22                              ; #$64
    db   $c1, $5b                              ; #$65
    db   $c2, $22                              ; #$66
    db   $c2, $39                              ; #$67
    db   $c3, $39                              ; #$68
    db   $c4, $37                              ; #$69
    db   $c5, $37                              ; #$6a
    db   $c8, $44                              ; #$6b
    db   $c9, $44                              ; #$6c
    db   $d0, $48                              ; #$6d
    db   $d0, $4e                              ; #$6e
    db   $d0, $50                              ; #$6f
    db   $d1, $48                              ; #$70
    db   $d1, $4f                              ; #$71
    db   $d1, $51                              ; #$72
    db   $d4, $43                              ; #$73
    db   $d4, $54                              ; #$74
    db   $d4, $5c                              ; #$75
    db   $d5, $43                              ; #$76
    db   $d5, $54                              ; #$77
    db   $d5, $5c                              ; #$78
    db   $d7, $4a                              ; #$79
    db   $d8, $20                              ; #$7a
    db   $d8, $4a                              ; #$7b
    db   $d9, $20                              ; #$7c
    db   $de, $3e                              ; #$7d
    db   $de, $3f                              ; #$7e
    db   $df, $3e                              ; #$7f
    db   $df, $3f                              ; #$80
    db   $e3, $43                              ; #$81
    db   $e3, $44                              ; #$82
    db   $e8, $36                              ; #$83
    db   $e9, $36                              ; #$84
    db   $ea, $3a                              ; #$85
    db   $eb, $3a                              ; #$86
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
