; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/doors_pangaea_90210.bin
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
; 6 records.
; ==================================================================

    db   $57, $03, $5a, $3b                    ; #$00  <-> #$01
    db   $5a, $3b, $57, $03                    ; #$01  <-> #$00
    db   $7c, $03, $03, $37                    ; #$02  <-> #$04
    db   $7b, $12, $03, $46                    ; #$03  <-> #$05
    db   $03, $37, $7c, $03                    ; #$04  <-> #$02
    db   $03, $46, $7b, $12                    ; #$05  <-> #$03
    db   SPAWN_LIST_END
