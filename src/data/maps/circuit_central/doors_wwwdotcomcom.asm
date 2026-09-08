; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/doors_wwwdotcomcom.bin
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
; 12 records.
; ==================================================================

    db   $0b, $06, $2b, $09                    ; #$00  <-> #$06
    db   $13, $07, $1d, $21                    ; #$01  <-> #$07
    db   $7c, $0a, $04, $42                    ; #$02  <-> #$08
    db   $7c, $21, $1d, $2f                    ; #$03  <-> #$09
    db   $65, $2f, $1c, $43                    ; #$04  <-> #$0a
    db   $3d, $41, $46, $42                    ; #$05  <-> #$0b
    db   $2b, $09, $0b, $06                    ; #$06  <-> #$00
    db   $1d, $21, $13, $07                    ; #$07  <-> #$01
    db   $04, $42, $7c, $0a                    ; #$08  <-> #$02
    db   $1d, $2f, $7c, $21                    ; #$09  <-> #$03
    db   $1c, $43, $65, $2f                    ; #$0a  <-> #$04
    db   $46, $42, $3d, $41                    ; #$0b  <-> #$05
    db   SPAWN_LIST_END
