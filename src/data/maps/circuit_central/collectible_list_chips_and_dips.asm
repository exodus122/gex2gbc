; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/collectible_list_chips_and_dips.bin
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
; 58 records.
; ==================================================================

    db   $16, $88                              ; #$00
    db   $16, $8a                              ; #$01
    db   $17, $89                              ; #$02
    db   $17, $8b                              ; #$03
    db   $1c, $72                              ; #$04
    db   $1d, $72                              ; #$05
    db   $21, $5b                              ; #$06
    db   $21, $5d                              ; #$07
    db   $21, $5f                              ; #$08
    db   $21, $69                              ; #$09
    db   $21, $6b                              ; #$0a
    db   $21, $6d                              ; #$0b
    db   $28, $74                              ; #$0c
    db   $28, $76                              ; #$0d
    db   $29, $75                              ; #$0e
    db   $29, $77                              ; #$0f
    db   $2a, $64                              ; #$10
    db   $2b, $58                              ; #$11
    db   $2b, $59                              ; #$12
    db   $2b, $64                              ; #$13
    db   $2c, $58                              ; #$14
    db   $2c, $59                              ; #$15
    db   $2e, $64                              ; #$16
    db   $2f, $64                              ; #$17
    db   $30, $52                              ; #$18
    db   $30, $53                              ; #$19
    db   $31, $50                              ; #$1a
    db   $31, $51                              ; #$1b
    db   $32, $7a                              ; #$1c
    db   $33, $7a                              ; #$1d
    db   $52, $51                              ; #$1e
    db   $56, $66                              ; #$1f
    db   $57, $67                              ; #$20
    db   $58, $5f                              ; #$21
    db   $59, $45                              ; #$22
    db   $5a, $45                              ; #$23
    db   $5a, $67                              ; #$24
    db   $5a, $6c                              ; #$25
    db   $5b, $66                              ; #$26
    db   $5b, $6c                              ; #$27
    db   $5c, $5a                              ; #$28
    db   $5c, $5f                              ; #$29
    db   $5d, $54                              ; #$2a
    db   $5d, $5a                              ; #$2b
    db   $5e, $4d                              ; #$2c
    db   $5e, $66                              ; #$2d
    db   $5f, $67                              ; #$2e
    db   $60, $47                              ; #$2f
    db   $60, $5f                              ; #$30
    db   $61, $54                              ; #$31
    db   $65, $0b                              ; #$32
    db   $65, $0d                              ; #$33
    db   $65, $0f                              ; #$34
    db   $65, $11                              ; #$35
    db   $66, $0b                              ; #$36
    db   $66, $0d                              ; #$37
    db   $66, $0f                              ; #$38
    db   $66, $11                              ; #$39
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
