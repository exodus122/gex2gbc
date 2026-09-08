; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/entity_list_this_old_cave.bin
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
; 25 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $3c  y block $61
    dw   $0780, $0c38
    db   $3d, $3b, $62, $60
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $3c  y block $60
    dw   $0780, $0c00
    db   $3d, $3b, $61, $5f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $4b  y block $70
    dw   $0960, $0e18
    db   $4c, $4a, $71, $6f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $4b  y block $6f
    dw   $0960, $0de0
    db   $4c, $4a, $70, $6e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $51  y block $66
    dw   $0a20, $0cd8
    db   $52, $50, $67, $65
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $51  y block $65
    dw   $0a20, $0ca0
    db   $52, $50, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$06  x block $30  y block $62
    dw   $0610, $0c50
    db   $31, $2f, $6c, $61
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$07  x block $33  y block $63
    dw   $0670, $0c70
    db   $34, $32, $6b, $62
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$08  x block $2c  y block $6c
    dw   $0590, $0d90
    db   $2e, $2b, $6d, $6b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$09  x block $2e  y block $6c
    dw   $05d0, $0d90
    db   $2f, $2c, $6d, $6b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_DRAGONFLY          ; #$0a  x block $5d  y block $6c
    dw   $0bb0, $0d90
    db   $61, $59, $6d, $6b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$0b  x block $7a  y block $6d
    dw   $0f50, $0db0
    db   $7b, $79, $6e, $6c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$0c  x block $6a  y block $6e
    dw   $0d50, $0dd0
    db   $6b, $69, $6f, $6d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$0d  x block $4e  y block $6f
    dw   $09d0, $0df8
    db   $4f, $4d, $70, $6e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FAST_DINOSAUR      ; #$0e  x block $3f  y block $71
    dw   $07f0, $0e30
    db   $41, $3c, $72, $70
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$0f  x block $64  y block $71
    dw   $0c8e, $0e2e
    db   $65, $63, $72, $70
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_DRAGONFLY          ; #$10  x block $07  y block $73
    dw   $00f0, $0e70
    db   $09, $05, $74, $72
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$11  x block $61  y block $74
    dw   $0c2e, $0e8e
    db   $62, $60, $75, $73
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$12  x block $77  y block $74
    dw   $0ef0, $0e90
    db   $78, $76, $78, $73
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$13  x block $56  y block $76
    dw   $0ad0, $0ed0
    db   $57, $55, $78, $75
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$14  x block $73  y block $76
    dw   $0e70, $0ed0
    db   $76, $70, $77, $75
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$15  x block $5b  y block $77
    dw   $0b6e, $0eee
    db   $5c, $5a, $78, $76
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$16  x block $4d  y block $78
    dw   $09b0, $0f04
    db   $50, $4c, $79, $77
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$17  x block $6d  y block $78
    dw   $0db0, $0f04
    db   $6f, $5e, $79, $77
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$18  x block $3d  y block $79
    dw   $07b0, $0f30
    db   $48, $3c, $7a, $78
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
