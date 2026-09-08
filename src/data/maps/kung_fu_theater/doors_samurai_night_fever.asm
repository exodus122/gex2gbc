; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/doors_samurai_night_fever.bin
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
; 11 records.
; ==================================================================

    db   $0b, $0c, $68, $22                    ; #$00  <-> #$04
    db   $69, $05, $09, $1e                    ; #$01  <-> #$05
    db   $13, $0c, $07, $31                    ; #$02  <-> #$06
    db   $17, $0c, $03, $48                    ; #$03  <-> #$07
    db   $68, $22, $0b, $0c                    ; #$04  <-> #$00
    db   $09, $1e, $69, $05                    ; #$05  <-> #$01
    db   $07, $31, $13, $0c                    ; #$06  <-> #$02
    db   $03, $48, $17, $0c                    ; #$07  <-> #$03
    db   $63, $11, $39, $0a                    ; #$08  one-way
    db   $1a, $46, $31, $54                    ; #$09  <-> #$0a
    db   $31, $54, $1a, $46                    ; #$0a  <-> #$09
    db   SPAWN_LIST_END
