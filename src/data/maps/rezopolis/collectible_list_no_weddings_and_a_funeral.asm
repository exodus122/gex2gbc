; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/rezopolis/collectible_list_no_weddings_and_a_funeral.bin
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
; 83 records.
; ==================================================================

    db   $04, $08                              ; #$00
    db   $04, $0a                              ; #$01
    db   $05, $09                              ; #$02
    db   $05, $0b                              ; #$03
    db   $05, $b0                              ; #$04
    db   $05, $b1                              ; #$05
    db   $05, $b2                              ; #$06
    db   $05, $b3                              ; #$07
    db   $08, $42                              ; #$08
    db   $08, $58                              ; #$09
    db   $09, $33                              ; #$0a
    db   $09, $39                              ; #$0b
    db   $09, $42                              ; #$0c
    db   $09, $58                              ; #$0d
    db   $0d, $37                              ; #$0e
    db   $0f, $31                              ; #$0f
    db   $0f, $35                              ; #$10
    db   $11, $39                              ; #$11
    db   $16, $c8                              ; #$12
    db   $17, $0e                              ; #$13
    db   $17, $3b                              ; #$14
    db   $17, $c8                              ; #$15
    db   $18, $0e                              ; #$16
    db   $19, $37                              ; #$17
    db   $1a, $c9                              ; #$18
    db   $1b, $c9                              ; #$19
    db   $1c, $30                              ; #$1a
    db   $1c, $31                              ; #$1b
    db   $1d, $30                              ; #$1c
    db   $1d, $31                              ; #$1d
    db   $1e, $29                              ; #$1e
    db   $1e, $2b                              ; #$1f
    db   $1e, $c8                              ; #$20
    db   $1f, $28                              ; #$21
    db   $1f, $2a                              ; #$22
    db   $1f, $c8                              ; #$23
    db   $22, $c9                              ; #$24
    db   $23, $c9                              ; #$25
    db   $26, $c8                              ; #$26
    db   $27, $c8                              ; #$27
    db   $29, $0c                              ; #$28
    db   $2a, $0c                              ; #$29
    db   $2a, $a8                              ; #$2a
    db   $2a, $c9                              ; #$2b
    db   $2b, $a8                              ; #$2c
    db   $2b, $c9                              ; #$2d
    db   $2e, $c8                              ; #$2e
    db   $2f, $c8                              ; #$2f
    db   $30, $a6                              ; #$30
    db   $30, $a7                              ; #$31
    db   $31, $a6                              ; #$32
    db   $31, $a7                              ; #$33
    db   $45, $a6                              ; #$34
    db   $46, $a5                              ; #$35
    db   $47, $a5                              ; #$36
    db   $48, $a6                              ; #$37
    db   $49, $a7                              ; #$38
    db   $4f, $ae                              ; #$39
    db   $4f, $af                              ; #$3a
    db   $6c, $a4                              ; #$3b
    db   $6c, $a6                              ; #$3c
    db   $6d, $a5                              ; #$3d
    db   $6d, $a7                              ; #$3e
    db   $72, $bc                              ; #$3f
    db   $72, $bd                              ; #$40
    db   $73, $bc                              ; #$41
    db   $73, $bd                              ; #$42
    db   $80, $a0                              ; #$43
    db   $80, $a1                              ; #$44
    db   $81, $a0                              ; #$45
    db   $81, $a1                              ; #$46
    db   $91, $a6                              ; #$47
    db   $92, $a6                              ; #$48
    db   $9f, $a6                              ; #$49
    db   $a0, $a6                              ; #$4a
    db   $af, $c0                              ; #$4b
    db   $af, $c1                              ; #$4c
    db   $b0, $c0                              ; #$4d
    db   $b0, $c1                              ; #$4e
    db   $b6, $bc                              ; #$4f
    db   $b6, $bd                              ; #$50
    db   $b7, $bc                              ; #$51
    db   $b7, $bd                              ; #$52
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
