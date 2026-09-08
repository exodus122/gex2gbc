; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/doors_poltergex.bin
; by tools/render_map_asm.py, per the door_list layout in tools/map_formats.json.
;
; The .bin is the editable source of truth for the bytes; this file is a
; generated view of it that happens to be what gets assembled. To change the
; data, edit the .bin (a map editor writes it). To change what a field MEANS,
; edit the schema. Either way, `make maps-docs` refreshes this file; hand edits
; are overwritten on the next build.
;
; One level's doors, searched by call_0b_4efe_Map_SetSpawnPosition in
; bank0B_map_spawns.asm. The search is linear and takes the first match, but no
; list holds two records with the same source block, so record order never
; matters here - unlike the entity lists.
;
; Everything is in BLOCK coordinates: the grid the blockmap is laid out in, 128 x
; 128 blocks per level. One block is SPAWN_UNITS_PER_BLOCK ($20) units of player
; world position, so the routine shifts these up by 5 and adds a per-case offset.
;
; A record is one-directional. Most come in pairs, a record and its exact reverse,
; which is what makes a door walkable both ways; the rest drop the player
; somewhere they cannot walk back from. Thursday the 12th is the extreme case,
; which is how a level whose mission is "find the items in the time given" is
; built as a maze out of nothing but door records.
;
; The note on each record is COMPUTED from the table, not authored, so it
; cannot go stale. Do not hand-correct it - fix the data or the generator.
;
; Record layout - 4 bytes, DOOR_RECORD_SIZE:
;   +0   db  from_x, from_y, to_x, to_y   - from block x, from block y, to block x, to block y
;
; 30 records.
; ==================================================================

    db   $59, $35, $03, $4d                    ; #$00  <-> #$0f
    db   $09, $49, $3c, $4c                    ; #$01  <-> #$10
    db   $11, $4d, $02, $3f                    ; #$02  <-> #$11
    db   $28, $3e, $4e, $47                    ; #$03  <-> #$12
    db   $03, $3b, $46, $42                    ; #$04  <-> #$13
    db   $46, $3c, $37, $35                    ; #$05  <-> #$14
    db   $54, $47, $31, $58                    ; #$06  <-> #$15
    db   $56, $4c, $37, $66                    ; #$07  <-> #$16
    db   $59, $29, $0e, $53                    ; #$08  <-> #$17
    db   $2a, $54, $03, $54                    ; #$09  <-> #$18
    db   $47, $4a, $16, $54                    ; #$0a  <-> #$19
    db   $55, $42, $35, $3f                    ; #$0b  <-> #$1a
    db   $57, $3c, $35, $3c                    ; #$0c  <-> #$1b
    db   $02, $2d, $4c, $29                    ; #$0d  <-> #$1c
    db   $02, $31, $4c, $35                    ; #$0e  <-> #$1d
    db   $03, $4d, $59, $35                    ; #$0f  <-> #$00
    db   $3c, $4c, $09, $49                    ; #$10  <-> #$01
    db   $02, $3f, $11, $4d                    ; #$11  <-> #$02
    db   $4e, $47, $28, $3e                    ; #$12  <-> #$03
    db   $46, $42, $03, $3b                    ; #$13  <-> #$04
    db   $37, $35, $46, $3c                    ; #$14  <-> #$05
    db   $31, $58, $54, $47                    ; #$15  <-> #$06
    db   $37, $66, $56, $4c                    ; #$16  <-> #$07
    db   $0e, $53, $59, $29                    ; #$17  <-> #$08
    db   $03, $54, $2a, $54                    ; #$18  <-> #$09
    db   $16, $54, $47, $4a                    ; #$19  <-> #$0a
    db   $35, $3f, $55, $42                    ; #$1a  <-> #$0b
    db   $35, $3c, $57, $3c                    ; #$1b  <-> #$0c
    db   $4c, $29, $02, $2d                    ; #$1c  <-> #$0d
    db   $4c, $35, $02, $31                    ; #$1d  <-> #$0e
    db   SPAWN_LIST_END
