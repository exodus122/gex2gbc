; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/rezopolis/entity_list_bugged_out.bin
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
; 3 records.
; ==================================================================

    db   ENTITY_REZOPOLIS_ANT_SPAWNER          ; #$00  x block $12  y block $76
    dw   $0250, $0ed0
    db   $1f, $11, $7a, $74
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_GEAR        ; #$01  x block $1d  y block $75
    dw   $03a0, $0eb8
    db   $1f, $11, $7a, $72
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_GOLD_REMOTE                    ; #$02  x block $27  y block $76
    dw   $04f0, $0ed0
    db   $28, $26, $77, $75
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
