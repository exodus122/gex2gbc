; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/collectible_list_texas_chainsaw_manicure.bin
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
; 89 records.
; ==================================================================

    db   $04, $10                              ; #$00
    db   $05, $0f                              ; #$01
    db   $06, $10                              ; #$02
    db   $09, $18                              ; #$03
    db   $09, $19                              ; #$04
    db   $0b, $18                              ; #$05
    db   $0b, $19                              ; #$06
    db   $0d, $0b                              ; #$07
    db   $0e, $0a                              ; #$08
    db   $0f, $0b                              ; #$09
    db   $10, $0a                              ; #$0a
    db   $10, $18                              ; #$0b
    db   $10, $19                              ; #$0c
    db   $11, $0b                              ; #$0d
    db   $12, $0a                              ; #$0e
    db   $12, $18                              ; #$0f
    db   $12, $19                              ; #$10
    db   $13, $0b                              ; #$11
    db   $14, $0a                              ; #$12
    db   $1e, $33                              ; #$13
    db   $1f, $32                              ; #$14
    db   $20, $28                              ; #$15
    db   $20, $33                              ; #$16
    db   $26, $06                              ; #$17
    db   $26, $07                              ; #$18
    db   $26, $08                              ; #$19
    db   $28, $06                              ; #$1a
    db   $28, $07                              ; #$1b
    db   $28, $08                              ; #$1c
    db   $2d, $0e                              ; #$1d
    db   $2f, $0d                              ; #$1e
    db   $30, $10                              ; #$1f
    db   $30, $28                              ; #$20
    db   $3a, $3b                              ; #$21
    db   $3a, $3d                              ; #$22
    db   $3a, $3f                              ; #$23
    db   $3c, $04                              ; #$24
    db   $3d, $04                              ; #$25
    db   $3d, $14                              ; #$26
    db   $3e, $04                              ; #$27
    db   $3e, $1e                              ; #$28
    db   $3f, $04                              ; #$29
    db   $3f, $16                              ; #$2a
    db   $3f, $1d                              ; #$2b
    db   $3f, $1f                              ; #$2c
    db   $41, $30                              ; #$2d
    db   $41, $38                              ; #$2e
    db   $43, $31                              ; #$2f
    db   $44, $2c                              ; #$30
    db   $45, $2c                              ; #$31
    db   $45, $38                              ; #$32
    db   $48, $14                              ; #$33
    db   $48, $2c                              ; #$34
    db   $49, $2c                              ; #$35
    db   $49, $38                              ; #$36
    db   $4a, $1a                              ; #$37
    db   $4b, $19                              ; #$38
    db   $4b, $30                              ; #$39
    db   $4c, $1a                              ; #$3a
    db   $4d, $31                              ; #$3b
    db   $4f, $30                              ; #$3c
    db   $51, $31                              ; #$3d
    db   $53, $30                              ; #$3e
    db   $63, $08                              ; #$3f
    db   $63, $10                              ; #$40
    db   $64, $0f                              ; #$41
    db   $66, $14                              ; #$42
    db   $67, $0f                              ; #$43
    db   $68, $10                              ; #$44
    db   $69, $08                              ; #$45
    db   $6b, $10                              ; #$46
    db   $6c, $0f                              ; #$47
    db   $6e, $14                              ; #$48
    db   $6f, $0f                              ; #$49
    db   $70, $10                              ; #$4a
    db   $76, $14                              ; #$4b
    db   $8f, $08                              ; #$4c
    db   $91, $09                              ; #$4d
    db   $93, $0a                              ; #$4e
    db   $95, $0b                              ; #$4f
    db   $97, $0c                              ; #$50
    db   $99, $0d                              ; #$51
    db   $9b, $0e                              ; #$52
    db   $c2, $0e                              ; #$53
    db   $c5, $0e                              ; #$54
    db   $c8, $12                              ; #$55
    db   $ce, $11                              ; #$56
    db   $d1, $12                              ; #$57
    db   $d4, $11                              ; #$58
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
