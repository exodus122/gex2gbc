; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/collectible_list_samurai_night_fever.bin
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
; 117 records.
; ==================================================================

    db   $0c, $1c                              ; #$00
    db   $0c, $1d                              ; #$01
    db   $0c, $1e                              ; #$02
    db   $0c, $1f                              ; #$03
    db   $1b, $8a                              ; #$04
    db   $1b, $8b                              ; #$05
    db   $1b, $8c                              ; #$06
    db   $1b, $8d                              ; #$07
    db   $26, $3b                              ; #$08
    db   $27, $3a                              ; #$09
    db   $28, $39                              ; #$0a
    db   $29, $39                              ; #$0b
    db   $2a, $3a                              ; #$0c
    db   $2b, $3b                              ; #$0d
    db   $3c, $3e                              ; #$0e
    db   $3c, $3f                              ; #$0f
    db   $3c, $40                              ; #$10
    db   $3c, $41                              ; #$11
    db   $41, $3e                              ; #$12
    db   $41, $3f                              ; #$13
    db   $41, $40                              ; #$14
    db   $41, $41                              ; #$15
    db   $44, $17                              ; #$16
    db   $45, $16                              ; #$17
    db   $46, $16                              ; #$18
    db   $47, $17                              ; #$19
    db   $4c, $5b                              ; #$1a
    db   $4d, $5a                              ; #$1b
    db   $4e, $5a                              ; #$1c
    db   $4f, $5b                              ; #$1d
    db   $51, $19                              ; #$1e
    db   $53, $1a                              ; #$1f
    db   $54, $61                              ; #$20
    db   $54, $63                              ; #$21
    db   $54, $94                              ; #$22
    db   $54, $95                              ; #$23
    db   $55, $1b                              ; #$24
    db   $55, $60                              ; #$25
    db   $55, $62                              ; #$26
    db   $56, $86                              ; #$27
    db   $56, $87                              ; #$28
    db   $56, $88                              ; #$29
    db   $56, $89                              ; #$2a
    db   $58, $7a                              ; #$2b
    db   $58, $7b                              ; #$2c
    db   $59, $7a                              ; #$2d
    db   $59, $7b                              ; #$2e
    db   $65, $18                              ; #$2f
    db   $65, $19                              ; #$30
    db   $65, $1a                              ; #$31
    db   $65, $1b                              ; #$32
    db   $66, $38                              ; #$33
    db   $66, $39                              ; #$34
    db   $66, $3a                              ; #$35
    db   $66, $3b                              ; #$36
    db   $68, $92                              ; #$37
    db   $68, $93                              ; #$38
    db   $69, $92                              ; #$39
    db   $69, $93                              ; #$3a
    db   $72, $55                              ; #$3b
    db   $72, $57                              ; #$3c
    db   $73, $0e                              ; #$3d
    db   $73, $0f                              ; #$3e
    db   $73, $54                              ; #$3f
    db   $73, $56                              ; #$40
    db   $74, $0e                              ; #$41
    db   $74, $0f                              ; #$42
    db   $78, $38                              ; #$43
    db   $78, $3c                              ; #$44
    db   $79, $38                              ; #$45
    db   $79, $3c                              ; #$46
    db   $83, $5e                              ; #$47
    db   $84, $5e                              ; #$48
    db   $8b, $32                              ; #$49
    db   $8c, $32                              ; #$4a
    db   $8d, $5e                              ; #$4b
    db   $8e, $5e                              ; #$4c
    db   $97, $5e                              ; #$4d
    db   $98, $5e                              ; #$4e
    db   $99, $32                              ; #$4f
    db   $9a, $32                              ; #$50
    db   $a0, $19                              ; #$51
    db   $a1, $19                              ; #$52
    db   $af, $60                              ; #$53
    db   $af, $61                              ; #$54
    db   $b0, $19                              ; #$55
    db   $b0, $60                              ; #$56
    db   $b0, $61                              ; #$57
    db   $b1, $19                              ; #$58
    db   $b6, $0e                              ; #$59
    db   $b6, $14                              ; #$5a
    db   $b7, $0e                              ; #$5b
    db   $b7, $14                              ; #$5c
    db   $c4, $5b                              ; #$5d
    db   $c5, $5a                              ; #$5e
    db   $c6, $5a                              ; #$5f
    db   $c7, $5b                              ; #$60
    db   $cb, $0c                              ; #$61
    db   $cb, $0d                              ; #$62
    db   $cb, $0e                              ; #$63
    db   $cb, $0f                              ; #$64
    db   $d4, $1a                              ; #$65
    db   $d4, $1b                              ; #$66
    db   $d5, $1a                              ; #$67
    db   $d5, $1b                              ; #$68
    db   $dd, $11                              ; #$69
    db   $dd, $12                              ; #$6a
    db   $dd, $13                              ; #$6b
    db   $dd, $14                              ; #$6c
    db   $e3, $5c                              ; #$6d
    db   $e3, $5d                              ; #$6e
    db   $e8, $5c                              ; #$6f
    db   $e8, $5d                              ; #$70
    db   $e9, $06                              ; #$71
    db   $e9, $07                              ; #$72
    db   $e9, $08                              ; #$73
    db   $e9, $09                              ; #$74
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
