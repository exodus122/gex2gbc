; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/collectible_list_smellraiser.bin
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
; 77 records.
; ==================================================================

    db   $1b, $12                              ; #$00
    db   $1b, $14                              ; #$01
    db   $1f, $11                              ; #$02
    db   $20, $27                              ; #$03
    db   $20, $29                              ; #$04
    db   $21, $28                              ; #$05
    db   $2b, $10                              ; #$06
    db   $2b, $12                              ; #$07
    db   $2c, $27                              ; #$08
    db   $2c, $29                              ; #$09
    db   $2d, $28                              ; #$0a
    db   $30, $0d                              ; #$0b
    db   $31, $0d                              ; #$0c
    db   $3a, $27                              ; #$0d
    db   $3a, $29                              ; #$0e
    db   $3b, $28                              ; #$0f
    db   $43, $3c                              ; #$10
    db   $45, $3c                              ; #$11
    db   $46, $27                              ; #$12
    db   $46, $29                              ; #$13
    db   $47, $28                              ; #$14
    db   $49, $3e                              ; #$15
    db   $50, $29                              ; #$16
    db   $52, $29                              ; #$17
    db   $54, $29                              ; #$18
    db   $56, $27                              ; #$19
    db   $58, $27                              ; #$1a
    db   $5a, $27                              ; #$1b
    db   $5a, $3e                              ; #$1c
    db   $5d, $0a                              ; #$1d
    db   $5d, $0c                              ; #$1e
    db   $5e, $3c                              ; #$1f
    db   $60, $3c                              ; #$20
    db   $64, $36                              ; #$21
    db   $66, $36                              ; #$22
    db   $6f, $14                              ; #$23
    db   $70, $13                              ; #$24
    db   $70, $15                              ; #$25
    db   $71, $14                              ; #$26
    db   $8e, $2d                              ; #$27
    db   $8f, $2d                              ; #$28
    db   $9c, $05                              ; #$29
    db   $a0, $28                              ; #$2a
    db   $a2, $27                              ; #$2b
    db   $a4, $28                              ; #$2c
    db   $a5, $12                              ; #$2d
    db   $a7, $10                              ; #$2e
    db   $aa, $03                              ; #$2f
    db   $aa, $0f                              ; #$30
    db   $ad, $0e                              ; #$31
    db   $ae, $04                              ; #$32
    db   $b0, $05                              ; #$33
    db   $b0, $0f                              ; #$34
    db   $b2, $10                              ; #$35
    db   $b7, $12                              ; #$36
    db   $b8, $12                              ; #$37
    db   $bb, $10                              ; #$38
    db   $bb, $1e                              ; #$39
    db   $bc, $10                              ; #$3a
    db   $bc, $1d                              ; #$3b
    db   $bd, $1d                              ; #$3c
    db   $be, $1e                              ; #$3d
    db   $c1, $05                              ; #$3e
    db   $c2, $04                              ; #$3f
    db   $c3, $04                              ; #$40
    db   $c4, $05                              ; #$41
    db   $db, $12                              ; #$42
    db   $df, $10                              ; #$43
    db   $ed, $2a                              ; #$44
    db   $ed, $2b                              ; #$45
    db   $ed, $2c                              ; #$46
    db   $f0, $2a                              ; #$47
    db   $f0, $2b                              ; #$48
    db   $f0, $2c                              ; #$49
    db   $f4, $2a                              ; #$4a
    db   $f4, $2b                              ; #$4b
    db   $f4, $2c                              ; #$4c
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
