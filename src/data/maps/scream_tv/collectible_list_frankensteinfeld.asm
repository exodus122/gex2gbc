; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/collectible_list_frankensteinfeld.bin
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
; 90 records.
; ==================================================================

    db   $05, $5f                              ; #$00
    db   $06, $5e                              ; #$01
    db   $07, $5f                              ; #$02
    db   $08, $5e                              ; #$03
    db   $09, $5f                              ; #$04
    db   $1a, $74                              ; #$05
    db   $1a, $76                              ; #$06
    db   $1b, $5e                              ; #$07
    db   $1b, $60                              ; #$08
    db   $1b, $75                              ; #$09
    db   $1d, $62                              ; #$0a
    db   $1e, $62                              ; #$0b
    db   $20, $5e                              ; #$0c
    db   $20, $60                              ; #$0d
    db   $36, $b0                              ; #$0e
    db   $38, $b0                              ; #$0f
    db   $3a, $b0                              ; #$10
    db   $3c, $b0                              ; #$11
    db   $3f, $62                              ; #$12
    db   $41, $61                              ; #$13
    db   $42, $61                              ; #$14
    db   $44, $62                              ; #$15
    db   $46, $a3                              ; #$16
    db   $46, $a5                              ; #$17
    db   $47, $a4                              ; #$18
    db   $47, $b6                              ; #$19
    db   $48, $b6                              ; #$1a
    db   $4a, $61                              ; #$1b
    db   $4b, $62                              ; #$1c
    db   $4c, $61                              ; #$1d
    db   $4c, $c4                              ; #$1e
    db   $4d, $62                              ; #$1f
    db   $4e, $c2                              ; #$20
    db   $50, $c0                              ; #$21
    db   $5c, $64                              ; #$22
    db   $5e, $65                              ; #$23
    db   $60, $66                              ; #$24
    db   $6a, $a4                              ; #$25
    db   $6b, $a4                              ; #$26
    db   $6c, $c0                              ; #$27
    db   $6e, $c1                              ; #$28
    db   $6f, $c2                              ; #$29
    db   $74, $c2                              ; #$2a
    db   $75, $c1                              ; #$2b
    db   $77, $c0                              ; #$2c
    db   $7b, $5c                              ; #$2d
    db   $7f, $5c                              ; #$2e
    db   $7f, $ad                              ; #$2f
    db   $83, $5c                              ; #$30
    db   $88, $ad                              ; #$31
    db   $89, $b2                              ; #$32
    db   $8b, $54                              ; #$33
    db   $8c, $53                              ; #$34
    db   $8d, $54                              ; #$35
    db   $8e, $59                              ; #$36
    db   $8e, $5d                              ; #$37
    db   $8f, $57                              ; #$38
    db   $8f, $5b                              ; #$39
    db   $8f, $5f                              ; #$3a
    db   $90, $b2                              ; #$3b
    db   $91, $af                              ; #$3c
    db   $94, $af                              ; #$3d
    db   $a8, $66                              ; #$3e
    db   $ac, $66                              ; #$3f
    db   $ae, $98                              ; #$40
    db   $ae, $99                              ; #$41
    db   $af, $98                              ; #$42
    db   $af, $99                              ; #$43
    db   $b4, $66                              ; #$44
    db   $b6, $66                              ; #$45
    db   $bc, $ac                              ; #$46
    db   $c6, $62                              ; #$47
    db   $c8, $62                              ; #$48
    db   $ca, $b0                              ; #$49
    db   $cc, $86                              ; #$4a
    db   $cc, $87                              ; #$4b
    db   $cd, $64                              ; #$4c
    db   $cd, $86                              ; #$4d
    db   $cd, $87                              ; #$4e
    db   $ce, $9e                              ; #$4f
    db   $ce, $9f                              ; #$50
    db   $cf, $9e                              ; #$51
    db   $cf, $9f                              ; #$52
    db   $d4, $64                              ; #$53
    db   $d6, $88                              ; #$54
    db   $da, $88                              ; #$55
    db   $e2, $92                              ; #$56
    db   $e2, $93                              ; #$57
    db   $e3, $92                              ; #$58
    db   $e3, $93                              ; #$59
    db   COLLECTIBLE_LIST_END
    db   $00                                   ; unreachable, past the terminator
