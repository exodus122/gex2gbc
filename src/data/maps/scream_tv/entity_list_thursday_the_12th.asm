; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/entity_list_thursday_the_12th.bin
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
; 12 records.
; ==================================================================

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$00  x block $70  y block $4f
    dw   $0e00, $09e0
    db   $71, $6f, $53, $4e
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$01  x block $70  y block $4c
    dw   $0e00, $0980
    db   $71, $6f, $4f, $4b
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$02  x block $6a  y block $42
    dw   $0d50, $0840
    db   $6b, $69, $46, $41
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$03  x block $66  y block $3f
    dw   $0cc0, $07e0
    db   $67, $65, $42, $3e
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$04  x block $68  y block $3f
    dw   $0d08, $07e0
    db   $69, $67, $42, $3e
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$05  x block $72  y block $3f
    dw   $0e40, $07e0
    db   $72, $71, $42, $3e
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$06  x block $70  y block $3b
    dw   $0e00, $0760
    db   $71, $6f, $3f, $3a
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$07  x block $75  y block $38
    dw   $0ea0, $0700
    db   $76, $74, $3b, $37
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$08  x block $6b  y block $38
    dw   $0d60, $0700
    db   $6c, $6a, $3b, $37
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$09  x block $6b  y block $32
    dw   $0d60, $0640
    db   $6c, $6a, $35, $31
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$0a  x block $6f  y block $32
    dw   $0df8, $0640
    db   $70, $6e, $35, $31
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_GOLD_REMOTE                    ; #$0b  x block $75  y block $64
    dw   $0ea0, $0c80
    db   $76, $74, $65, $63
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
