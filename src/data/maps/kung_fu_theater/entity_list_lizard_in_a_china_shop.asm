; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/entity_list_lizard_in_a_china_shop.bin
; by tools/render_map_asm.py, per the entity_list layout in tools/map_formats.json.
;
; The .bin is the editable source of truth for the bytes; this file is a
; generated view of it that happens to be what gets assembled. To change the
; data, edit the .bin (a map editor writes it). To change what a field MEANS,
; edit the schema. Either way, `make maps-docs` refreshes this file; hand edits
; are overwritten on the next build.
;
; One record per placed object, walked by call_0a_4000_EntityList_LoadForCurrentLevel
; in bank0A_entity_load.asm. Field offsets below are exactly the
; ENTITY_SPAWN_*_OFFSET constants in src/constants/constants.asm - if you retune
; one there, change it here too.
;
; Record order is load-bearing: wD000_EntityFlags is indexed by an entry's
; position in the list, so inserting a record renumbers every flag after it.
; That is why each record's index is emitted as a comment.
;
; NOTE: offsets +7/+8 are named the other way round here than in constants.asm.
; In all 857 records byte +7 >= byte +8, exactly as +5 >= +6 for the X axis, so
; both axes store max then min and ENTITY_SPAWN_BOUNDINGBOX_YMIN_OFFSET /
; _YMAX_OFFSET look swapped. Renaming those two constants is cosmetic and would
; leave `make check` passing.
;
; Record layout - 16 bytes, ENTITY_SPAWN_RECORD_SIZE:
;   +0   db  id
;   +1   dw  x, y   - world position
;   +5   db  bbox_x_max, bbox_x_min, bbox_y_max, bbox_y_min   - room bounds in blocks, each axis max then min
;   +9   db  param1, param2, param3   - free parameters, meaning is per entity type
;   +12  db  spare0, spare1, spare2, spare3   - spare - not read by any code found so far
;
; 8 records.
; ==================================================================

    db   ENTITY_KUNG_FU_THEATER_MOVING_RAFT    ; #$00  x block $34  y block $68
    dw   $0690, $0d10
    db   $35, $33, $6d, $67
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_RAFT    ; #$01  x block $3c  y block $6a
    dw   $0780, $0d50
    db   $3d, $3b, $6c, $69
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_GOLD_REMOTE                    ; #$02  x block $10  y block $6c
    dw   $0210, $0d90
    db   $11, $0f, $6d, $6b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT  ; #$03  x block $14  y block $6d
    dw   $0290, $0dbe
    db   $15, $13, $6e, $6c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT  ; #$04  x block $1b  y block $6d
    dw   $0370, $0dbe
    db   $1c, $1a, $6e, $6c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_RAFT    ; #$05  x block $27  y block $6d
    dw   $04f0, $0dbe
    db   $29, $25, $6e, $6c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_RAFT    ; #$06  x block $46  y block $6d
    dw   $08d0, $0dbe
    db   $47, $42, $6e, $6c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_RAFT    ; #$07  x block $56  y block $6d
    dw   $0ad0, $0dbe
    db   $58, $51, $6e, $6c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
