; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/collectible_list_poltergex.bin
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
; 61 records.
; ==================================================================

    db   $07, $62                              ; #$00
    db   $08, $62                              ; #$01
    db   $08, $92                              ; #$02
    db   $0a, $a8                              ; #$03
    db   $11, $92                              ; #$04
    db   $17, $91                              ; #$05
    db   $18, $71                              ; #$06
    db   $1b, $a6                              ; #$07
    db   $1c, $76                              ; #$08
    db   $1c, $ad                              ; #$09
    db   $20, $ab                              ; #$0a
    db   $22, $90                              ; #$0b
    db   $28, $8f                              ; #$0c
    db   $2c, $5d                              ; #$0d
    db   $2c, $5e                              ; #$0e
    db   $2c, $5f                              ; #$0f
    db   $2c, $60                              ; #$10
    db   $2c, $61                              ; #$11
    db   $2d, $92                              ; #$12
    db   $30, $96                              ; #$13
    db   $33, $8d                              ; #$14
    db   $36, $72                              ; #$15
    db   $39, $90                              ; #$16
    db   $3b, $94                              ; #$17
    db   $3b, $a8                              ; #$18
    db   $3c, $a8                              ; #$19
    db   $3d, $a8                              ; #$1a
    db   $40, $72                              ; #$1b
    db   $40, $8f                              ; #$1c
    db   $41, $93                              ; #$1d
    db   $48, $73                              ; #$1e
    db   $56, $92                              ; #$1f
    db   $5c, $73                              ; #$20
    db   $5e, $73                              ; #$21
    db   $60, $73                              ; #$22
    db   $68, $a5                              ; #$23
    db   $69, $94                              ; #$24
    db   $6f, $a6                              ; #$25
    db   $74, $5c                              ; #$26
    db   $75, $5c                              ; #$27
    db   $7b, $a6                              ; #$28
    db   $7d, $a5                              ; #$29
    db   $7f, $a6                              ; #$2a
    db   $8c, $52                              ; #$2b
    db   $8e, $4e                              ; #$2c
    db   $90, $84                              ; #$2d
    db   $93, $88                              ; #$2e
    db   $98, $88                              ; #$2f
    db   $99, $81                              ; #$30
    db   $9a, $a9                              ; #$31
    db   $9c, $85                              ; #$32
    db   $9e, $ae                              ; #$33
    db   $9f, $a8                              ; #$34
    db   $a4, $aa                              ; #$35
    db   $a4, $ae                              ; #$36
    db   $a7, $a7                              ; #$37
    db   $aa, $ae                              ; #$38
    db   $ac, $a9                              ; #$39
    db   $af, $a7                              ; #$3a
    db   $b0, $ae                              ; #$3b
    db   $b4, $a9                              ; #$3c
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
