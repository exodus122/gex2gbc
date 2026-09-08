; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/rezopolis/entity_list_mazed_and_confused.bin
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
; 29 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $25  y block $18
    dw   $04a0, $0318
    db   $26, $24, $19, $17
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $25  y block $17
    dw   $04a0, $02e0
    db   $26, $24, $18, $16
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $21  y block $45
    dw   $0420, $08b8
    db   $22, $20, $46, $44
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $21  y block $44
    dw   $0420, $0880
    db   $22, $20, $45, $43
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$04  x block $50  y block $05
    dw   $0a10, $00b0
    db   $51, $4f, $07, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_FLAMETHROWER         ; #$05  x block $58  y block $06
    dw   $0b0d, $00d0
    db   $59, $57, $07, $05
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$06  x block $5a  y block $09
    dw   $0b50, $0120
    db   $5b, $59, $0b, $06
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$07  x block $53  y block $10
    dw   $0a70, $0210
    db   $54, $52, $12, $05
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$08  x block $6a  y block $11
    dw   $0d50, $0230
    db   $6b, $69, $16, $0f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_GREEN_MONSTER        ; #$09  x block $61  y block $12
    dw   $0c30, $0250
    db   $63, $5e, $13, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$0a  x block $48  y block $18
    dw   $0910, $0310
    db   $49, $47, $19, $17
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$0b  x block $74  y block $1a
    dw   $0e90, $0350
    db   $75, $73, $1b, $19
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$0c  x block $64  y block $1b
    dw   $0c90, $0370
    db   $66, $5f, $1c, $1a
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_PLATFORM    ; #$0d  x block $56  y block $21
    dw   $0ad0, $0438
    db   $57, $55, $22, $15
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$0e  x block $63  y block $21
    dw   $0c70, $0428
    db   $64, $62, $24, $1d
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$0f  x block $54  y block $22
    dw   $0a90, $0450
    db   $55, $53, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$10  x block $5b  y block $22
    dw   $0b70, $0450
    db   $5c, $5a, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$11  x block $4f  y block $24
    dw   $09f0, $0488
    db   $51, $4c, $25, $23
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_FLAMETHROWER         ; #$12  x block $6f  y block $24
    dw   $0ded, $0490
    db   $70, $6e, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$13  x block $27  y block $25
    dw   $04f0, $04b0
    db   $28, $26, $28, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_GREEN_MONSTER        ; #$14  x block $33  y block $25
    dw   $0670, $04b0
    db   $35, $2f, $26, $24
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$15  x block $48  y block $28
    dw   $0910, $0510
    db   $49, $47, $2c, $26
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$16  x block $1e  y block $2c
    dw   $03c0, $0580
    db   $1f, $1d, $2e, $2a
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$17  x block $65  y block $2d
    dw   $0cb0, $05b0
    db   $66, $64, $2e, $2c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_FLAMETHROWER         ; #$18  x block $53  y block $2f
    dw   $0a6d, $05f0
    db   $54, $52, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$19  x block $5c  y block $2f
    dw   $0b80, $05f0
    db   $5d, $5b, $30, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_PLATFORM    ; #$1a  x block $69  y block $2f
    dw   $0d30, $05f8
    db   $6a, $68, $30, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$1b  x block $42  y block $36
    dw   $0850, $06d0
    db   $43, $41, $38, $34
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$1c  x block $36  y block $3d
    dw   $06d0, $07b0
    db   $38, $32, $3e, $3c
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
