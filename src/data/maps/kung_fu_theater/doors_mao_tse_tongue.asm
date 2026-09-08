; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/doors_mao_tse_tongue.bin
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
; 28 records.
; ==================================================================

    db   $09, $1d, $2b, $06                    ; #$00  <-> #$0e
    db   $40, $05, $09, $19                    ; #$01  <-> #$0f
    db   $16, $19, $48, $05                    ; #$02  <-> #$10
    db   $4d, $05, $40, $12                    ; #$03  <-> #$11
    db   $52, $0e, $09, $15                    ; #$04  <-> #$12
    db   $19, $15, $5f, $1f                    ; #$05  <-> #$13
    db   $68, $10, $09, $0d                    ; #$06  <-> #$14
    db   $18, $11, $07, $35                    ; #$07  <-> #$15
    db   $07, $2a, $2b, $2c                    ; #$08  <-> #$16
    db   $19, $1d, $28, $35                    ; #$09  <-> #$17
    db   $2c, $35, $35, $28                    ; #$0a  <-> #$18
    db   $35, $22, $39, $3a                    ; #$0b  <-> #$19
    db   $4b, $34, $5e, $35                    ; #$0c  <-> #$1a
    db   $6a, $35, $5c, $45                    ; #$0d  <-> #$1b
    db   $2b, $06, $09, $1d                    ; #$0e  <-> #$00
    db   $09, $19, $40, $05                    ; #$0f  <-> #$01
    db   $48, $05, $16, $19                    ; #$10  <-> #$02
    db   $40, $12, $4d, $05                    ; #$11  <-> #$03
    db   $09, $15, $52, $0e                    ; #$12  <-> #$04
    db   $5f, $1f, $19, $15                    ; #$13  <-> #$05
    db   $09, $0d, $68, $10                    ; #$14  <-> #$06
    db   $07, $35, $18, $11                    ; #$15  <-> #$07
    db   $2b, $2c, $07, $2a                    ; #$16  <-> #$08
    db   $28, $35, $19, $1d                    ; #$17  <-> #$09
    db   $35, $28, $2c, $35                    ; #$18  <-> #$0a
    db   $39, $3a, $35, $22                    ; #$19  <-> #$0b
    db   $5e, $35, $4b, $34                    ; #$1a  <-> #$0c
    db   $5c, $45, $6a, $35                    ; #$1b  <-> #$0d
    db   SPAWN_LIST_END
