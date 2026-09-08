; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/entity_list_chips_and_dips.bin
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

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$00  x block $37  y block $10
    dw   $06f0, $0200
    db   $38, $36, $11, $09
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$01  x block $30  y block $09
    dw   $0610, $0130
    db   $31, $2f, $0a, $08
    db   $2c, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$02  x block $3b  y block $21
    dw   $0770, $0430
    db   $3c, $3a, $22, $20
    db   $84, $03, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$03  x block $1a  y block $2c
    dw   $0350, $0590
    db   $1b, $19, $2d, $2b
    db   $2c, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$04  x block $29  y block $36
    dw   $0530, $06d0
    db   $2a, $28, $37, $35
    db   $08, $07, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$05  x block $19  y block $3e
    dw   $0330, $07d0
    db   $1a, $18, $3f, $3d
    db   $84, $03, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$06  x block $04  y block $46
    dw   $0090, $08d0
    db   $05, $03, $47, $45
    db   $68, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_GOLD_REMOTE                    ; #$07  x block $3c  y block $05
    dw   $0790, $00b0
    db   $3d, $3b, $06, $04
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
