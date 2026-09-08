; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/doors_lava_dabba_doo.bin
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
; 14 records.
; ==================================================================

    db   $03, $0e, $02, $1f                    ; #$00  <-> #$01
    db   $02, $1f, $03, $0e                    ; #$01  <-> #$00
    db   $0b, $0e, $1b, $1f                    ; #$02  <-> #$03
    db   $1b, $1f, $0b, $0e                    ; #$03  <-> #$02
    db   $15, $0f, $34, $14                    ; #$04  <-> #$05
    db   $34, $14, $15, $0f                    ; #$05  <-> #$04
    db   $57, $07, $03, $2d                    ; #$06  <-> #$07
    db   $03, $2d, $57, $07                    ; #$07  <-> #$06
    db   $0e, $1d, $16, $2a                    ; #$08  <-> #$09
    db   $16, $2a, $0e, $1d                    ; #$09  <-> #$08
    db   $26, $1f, $3b, $2e                    ; #$0a  <-> #$0b
    db   $3b, $2e, $26, $1f                    ; #$0b  <-> #$0a
    db   $27, $2e, $04, $35                    ; #$0c  <-> #$0d
    db   $04, $35, $27, $2e                    ; #$0d  <-> #$0c
    db   SPAWN_LIST_END
