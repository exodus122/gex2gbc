; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/doors_honey_i_shrunk_the_gecko.bin
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
; 16 records.
; ==================================================================

    db   $04, $0e, $26, $1b                    ; #$00  <-> #$08
    db   $36, $0e, $4f, $34                    ; #$01  <-> #$09
    db   $4f, $2f, $41, $34                    ; #$02  <-> #$0a
    db   $43, $27, $64, $21                    ; #$03  <-> #$0b
    db   $47, $21, $0d, $6c                    ; #$04  <-> #$0c
    db   $58, $11, $62, $13                    ; #$05  <-> #$0d
    db   $79, $25, $04, $41                    ; #$06  <-> #$0e
    db   $63, $41, $69, $51                    ; #$07  <-> #$0f
    db   $26, $1b, $04, $0e                    ; #$08  <-> #$00
    db   $4f, $34, $36, $0e                    ; #$09  <-> #$01
    db   $41, $34, $4f, $2f                    ; #$0a  <-> #$02
    db   $64, $21, $43, $27                    ; #$0b  <-> #$03
    db   $0d, $6c, $47, $21                    ; #$0c  <-> #$04
    db   $62, $13, $58, $11                    ; #$0d  <-> #$05
    db   $04, $41, $79, $25                    ; #$0e  <-> #$06
    db   $69, $51, $63, $41                    ; #$0f  <-> #$07
    db   SPAWN_LIST_END
