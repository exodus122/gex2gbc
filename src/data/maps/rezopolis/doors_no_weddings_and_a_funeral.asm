; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/rezopolis/doors_no_weddings_and_a_funeral.bin
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

    db   $14, $07, $1b, $07                    ; #$00  <-> #$08
    db   $26, $07, $0b, $28                    ; #$01  <-> #$09
    db   $0b, $15, $06, $2f                    ; #$02  <-> #$0a
    db   $0e, $2f, $05, $5a                    ; #$03  <-> #$0b
    db   $29, $53, $05, $64                    ; #$04  <-> #$0c
    db   $1d, $64, $2c, $5e                    ; #$05  <-> #$0d
    db   $31, $51, $42, $56                    ; #$06  <-> #$0e
    db   $56, $52, $42, $60                    ; #$07  <-> #$0f
    db   $1b, $07, $14, $07                    ; #$08  <-> #$00
    db   $0b, $28, $26, $07                    ; #$09  <-> #$01
    db   $06, $2f, $0b, $15                    ; #$0a  <-> #$02
    db   $05, $5a, $0e, $2f                    ; #$0b  <-> #$03
    db   $05, $64, $29, $53                    ; #$0c  <-> #$04
    db   $2c, $5e, $1d, $64                    ; #$0d  <-> #$05
    db   $42, $56, $31, $51                    ; #$0e  <-> #$06
    db   $42, $60, $56, $52                    ; #$0f  <-> #$07
    db   SPAWN_LIST_END
