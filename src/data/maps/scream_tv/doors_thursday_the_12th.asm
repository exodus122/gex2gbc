; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/doors_thursday_the_12th.bin
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
; 45 records.
; ==================================================================

    db   $6a, $2e, $6d, $66                    ; #$00  <-> #$2a
    db   $6f, $2e, $65, $34                    ; #$01  one-way
    db   $74, $2e, $6f, $2e                    ; #$02  one-way
    db   $65, $31, $65, $34                    ; #$03  one-way
    db   $6a, $31, $74, $31                    ; #$04  <-> #$05
    db   $74, $31, $6a, $31                    ; #$05  <-> #$04
    db   $65, $34, $74, $2e                    ; #$06  one-way
    db   $6f, $34, $71, $5c                    ; #$07  <-> #$2c
    db   $74, $34, $65, $34                    ; #$08  one-way
    db   $65, $37, $6a, $31                    ; #$09  one-way
    db   $6a, $37, $65, $34                    ; #$0a  one-way
    db   $6f, $37, $74, $34                    ; #$0b  one-way
    db   $74, $37, $65, $3a                    ; #$0c  one-way
    db   $65, $3a, $6f, $37                    ; #$0d  one-way
    db   $6a, $3a, $74, $37                    ; #$0e  one-way
    db   $74, $3a, $65, $5c                    ; #$0f  <-> #$2b
    db   $65, $3e, $6a, $3a                    ; #$10  one-way
    db   $6a, $3e, $74, $3e                    ; #$11  one-way
    db   $6f, $3e, $65, $3a                    ; #$12  one-way
    db   $74, $3e, $6f, $3e                    ; #$13  one-way
    db   $65, $41, $6f, $44                    ; #$14  <-> #$18
    db   $6f, $41, $65, $3e                    ; #$15  one-way
    db   $65, $44, $6d, $44                    ; #$16  one-way
    db   $6d, $44, $6f, $48                    ; #$17  one-way
    db   $6f, $44, $65, $41                    ; #$18  <-> #$14
    db   $74, $44, $65, $44                    ; #$19  one-way
    db   $6f, $48, $74, $44                    ; #$1a  one-way
    db   $74, $48, $6f, $4b                    ; #$1b  one-way
    db   $65, $4b, $6f, $48                    ; #$1c  one-way
    db   $6a, $4b, $74, $4b                    ; #$1d  one-way
    db   $6f, $4b, $6d, $44                    ; #$1e  one-way
    db   $74, $4b, $6a, $4e                    ; #$1f  one-way
    db   $65, $4e, $74, $52                    ; #$20  one-way
    db   $6a, $4e, $65, $4e                    ; #$21  one-way
    db   $74, $4e, $6f, $4b                    ; #$22  one-way
    db   $65, $52, $6f, $52                    ; #$23  one-way
    db   $6f, $52, $6f, $55                    ; #$24  one-way
    db   $74, $52, $6a, $4e                    ; #$25  one-way
    db   $65, $55, $74, $55                    ; #$26  one-way
    db   $6a, $55, $65, $52                    ; #$27  one-way
    db   $6f, $55, $74, $55                    ; #$28  one-way
    db   $74, $55, $6a, $55                    ; #$29  one-way
    db   $6d, $66, $6a, $2e                    ; #$2a  <-> #$00
    db   $65, $5c, $74, $3a                    ; #$2b  <-> #$0f
    db   $71, $5c, $6f, $34                    ; #$2c  <-> #$07
    db   SPAWN_LIST_END
