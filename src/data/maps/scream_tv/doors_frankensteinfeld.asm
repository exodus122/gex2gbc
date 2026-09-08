; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/doors_frankensteinfeld.bin
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
; 18 records.
; ==================================================================

    db   $16, $33, $1d, $31                    ; #$00  <-> #$09
    db   $23, $31, $2e, $30                    ; #$01  <-> #$0a
    db   $27, $31, $24, $62                    ; #$02  <-> #$0b
    db   $43, $2a, $4d, $2d                    ; #$03  <-> #$0c
    db   $4c, $32, $02, $42                    ; #$04  <-> #$0d
    db   $50, $2b, $0a, $3b                    ; #$05  <-> #$0e
    db   $1e, $41, $08, $57                    ; #$06  <-> #$0f
    db   $71, $28, $12, $3f                    ; #$07  <-> #$10
    db   $76, $46, $28, $3f                    ; #$08  <-> #$11
    db   $1d, $31, $16, $33                    ; #$09  <-> #$00
    db   $2e, $30, $23, $31                    ; #$0a  <-> #$01
    db   $24, $62, $27, $31                    ; #$0b  <-> #$02
    db   $4d, $2d, $43, $2a                    ; #$0c  <-> #$03
    db   $02, $42, $4c, $32                    ; #$0d  <-> #$04
    db   $0a, $3b, $50, $2b                    ; #$0e  <-> #$05
    db   $08, $57, $1e, $41                    ; #$0f  <-> #$06
    db   $12, $3f, $71, $28                    ; #$10  <-> #$07
    db   $28, $3f, $76, $46                    ; #$11  <-> #$08
    db   SPAWN_LIST_END
