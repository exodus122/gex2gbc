; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/collectible_list_mao_tse_tongue.bin
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
; 103 records.
; ==================================================================

    db   $0c, $5c                              ; #$00
    db   $0c, $5d                              ; #$01
    db   $0c, $5e                              ; #$02
    db   $0c, $5f                              ; #$03
    db   $12, $18                              ; #$04
    db   $12, $19                              ; #$05
    db   $12, $31                              ; #$06
    db   $13, $18                              ; #$07
    db   $13, $30                              ; #$08
    db   $14, $18                              ; #$09
    db   $14, $30                              ; #$0a
    db   $15, $18                              ; #$0b
    db   $15, $19                              ; #$0c
    db   $15, $31                              ; #$0d
    db   $1e, $34                              ; #$0e
    db   $1e, $35                              ; #$0f
    db   $1f, $2e                              ; #$10
    db   $1f, $2f                              ; #$11
    db   $22, $2e                              ; #$12
    db   $22, $2f                              ; #$13
    db   $23, $34                              ; #$14
    db   $23, $35                              ; #$15
    db   $28, $1c                              ; #$16
    db   $29, $1d                              ; #$17
    db   $2a, $1f                              ; #$18
    db   $2c, $2a                              ; #$19
    db   $2c, $32                              ; #$1a
    db   $2c, $33                              ; #$1b
    db   $2d, $2a                              ; #$1c
    db   $2e, $2a                              ; #$1d
    db   $2f, $2a                              ; #$1e
    db   $2f, $32                              ; #$1f
    db   $2f, $33                              ; #$20
    db   $3c, $2e                              ; #$21
    db   $3c, $30                              ; #$22
    db   $3d, $2f                              ; #$23
    db   $3d, $31                              ; #$24
    db   $55, $6a                              ; #$25
    db   $56, $6a                              ; #$26
    db   $70, $14                              ; #$27
    db   $70, $15                              ; #$28
    db   $70, $16                              ; #$29
    db   $70, $17                              ; #$2a
    db   $75, $7e                              ; #$2b
    db   $76, $7e                              ; #$2c
    db   $84, $0b                              ; #$2d
    db   $85, $0b                              ; #$2e
    db   $8e, $0b                              ; #$2f
    db   $8f, $0b                              ; #$30
    db   $95, $7e                              ; #$31
    db   $96, $7e                              ; #$32
    db   $9c, $0b                              ; #$33
    db   $9c, $6c                              ; #$34
    db   $9c, $6d                              ; #$35
    db   $9c, $6e                              ; #$36
    db   $9c, $6f                              ; #$37
    db   $9d, $0b                              ; #$38
    db   $ac, $7e                              ; #$39
    db   $ac, $7f                              ; #$3a
    db   $ad, $7e                              ; #$3b
    db   $ad, $7f                              ; #$3c
    db   $bc, $5f                              ; #$3d
    db   $bd, $5f                              ; #$3e
    db   $bd, $64                              ; #$3f
    db   $bd, $65                              ; #$40
    db   $be, $64                              ; #$41
    db   $be, $65                              ; #$42
    db   $c2, $17                              ; #$43
    db   $c3, $17                              ; #$44
    db   $c4, $8a                              ; #$45
    db   $c4, $8b                              ; #$46
    db   $c5, $8a                              ; #$47
    db   $c5, $8b                              ; #$48
    db   $c6, $1b                              ; #$49
    db   $c6, $21                              ; #$4a
    db   $c7, $1b                              ; #$4b
    db   $c7, $21                              ; #$4c
    db   $cd, $37                              ; #$4d
    db   $ce, $37                              ; #$4e
    db   $d0, $1b                              ; #$4f
    db   $d1, $12                              ; #$50
    db   $d1, $13                              ; #$51
    db   $d1, $1b                              ; #$52
    db   $d2, $12                              ; #$53
    db   $d2, $13                              ; #$54
    db   $d2, $1b                              ; #$55
    db   $d3, $1b                              ; #$56
    db   $d5, $3b                              ; #$57
    db   $d6, $3b                              ; #$58
    db   $d8, $20                              ; #$59
    db   $d9, $20                              ; #$5a
    db   $e5, $2a                              ; #$5b
    db   $e5, $2b                              ; #$5c
    db   $e5, $2c                              ; #$5d
    db   $e5, $2d                              ; #$5e
    db   $e5, $2e                              ; #$5f
    db   $e5, $2f                              ; #$60
    db   $ee, $10                              ; #$61
    db   $ee, $11                              ; #$62
    db   $ee, $12                              ; #$63
    db   $ef, $10                              ; #$64
    db   $ef, $11                              ; #$65
    db   $ef, $12                              ; #$66
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
