; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/entity_list_smellraiser.bin
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
; 31 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $29  y block $1d
    dw   $0520, $03b8
    db   $2a, $28, $1e, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $29  y block $1c
    dw   $0520, $0380
    db   $2a, $28, $1d, $1b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $76  y block $0a
    dw   $0ec0, $0158
    db   $77, $75, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $76  y block $09
    dw   $0ec0, $0120
    db   $77, $75, $0a, $08
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $19  y block $22
    dw   $0320, $0458
    db   $1a, $18, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $19  y block $21
    dw   $0320, $0420
    db   $1a, $18, $22, $20
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$06  x block $50  y block $03
    dw   $0a10, $0070
    db   $51, $4f, $04, $01
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FLOATING_SKULL       ; #$07  x block $63  y block $03
    dw   $0c70, $0070
    db   $64, $62, $04, $02
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_BAT                  ; #$08  x block $6d  y block $03
    dw   $0db0, $0070
    db   $71, $6b, $04, $02
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$09  x block $14  y block $07
    dw   $0290, $00e0
    db   $16, $10, $08, $06
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$0a  x block $2c  y block $07
    dw   $0590, $00e0
    db   $2d, $2b, $0b, $05
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$0b  x block $30  y block $07
    dw   $0610, $00e0
    db   $31, $2f, $0a, $05
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_LANTERN              ; #$0c  x block $66  y block $08
    dw   $0cd0, $0118
    db   $6b, $61, $09, $07
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$0d  x block $11  y block $0a
    dw   $0230, $0150
    db   $12, $10, $0b, $07
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_BAT                  ; #$0e  x block $4e  y block $0a
    dw   $09d0, $0150
    db   $52, $4b, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_GHOST                ; #$0f  x block $66  y block $0a
    dw   $0cd0, $0150
    db   $6b, $61, $0b, $09
    db   $10, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FLOATING_SKULL       ; #$10  x block $4c  y block $0f
    dw   $0990, $01f0
    db   $4d, $4b, $10, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_LANTERN              ; #$11  x block $68  y block $0f
    dw   $0d10, $01f8
    db   $6d, $63, $10, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$12  x block $26  y block $10
    dw   $04d0, $0210
    db   $27, $25, $11, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ZOMBIE               ; #$13  x block $18  y block $11
    dw   $0310, $0230
    db   $1d, $12, $12, $10
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_GHOST                ; #$14  x block $68  y block $11
    dw   $0d10, $0230
    db   $6d, $63, $12, $10
    db   $20, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$15  x block $24  y block $12
    dw   $0490, $0240
    db   $25, $23, $15, $10
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$16  x block $5a  y block $12
    dw   $0b40, $0240
    db   $5b, $58, $15, $11
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ZOMBIE               ; #$17  x block $78  y block $12
    dw   $0f10, $0250
    db   $7a, $76, $13, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$18  x block $3c  y block $15
    dw   $079e, $02b4
    db   $3e, $3c, $17, $14
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$19  x block $3e  y block $15
    dw   $07de, $02b4
    db   $40, $3e, $17, $14
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR   ; #$1a  x block $06  y block $1c
    dw   $00d0, $0380
    db   $07, $05, $23, $1b
    db   $02, $10, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$1b  x block $0b  y block $21
    dw   $017e, $0434
    db   $0d, $0b, $23, $20
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$1c  x block $10  y block $21
    dw   $021e, $0434
    db   $12, $10, $23, $20
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$1d  x block $15  y block $24
    dw   $02a0, $0480
    db   $16, $14, $27, $22
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$1e  x block $04  y block $26
    dw   $0090, $04d0
    db   $05, $03, $27, $25
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
