; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/rezopolis/entity_list_no_weddings_and_a_funeral.bin
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
; 36 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $5e  y block $5f
    dw   $0bc0, $0bf8
    db   $5f, $5d, $60, $5e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $5e  y block $5e
    dw   $0bc0, $0bc0
    db   $5f, $5d, $5f, $5d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$02  x block $07  y block $05
    dw   $00f0, $00b0
    db   $08, $06, $07, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_GREEN_MONSTER        ; #$03  x block $21  y block $07
    dw   $0430, $00f0
    db   $24, $1e, $08, $06
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM  ; #$04  x block $0f  y block $08
    dw   $01f0, $0100
    db   $13, $0e, $09, $07
    db   $00, $ff, $08
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM  ; #$05  x block $10  y block $08
    dw   $0210, $0100
    db   $13, $0e, $09, $07
    db   $00, $ff, $08
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_GREEN_MONSTER        ; #$06  x block $10  y block $0a
    dw   $0210, $0150
    db   $13, $0e, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$07  x block $07  y block $17
    dw   $00f0, $02e0
    db   $08, $06, $1a, $15
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$08  x block $0c  y block $1c
    dw   $0190, $0390
    db   $0d, $0b, $1d, $1b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_FLAMETHROWER         ; #$09  x block $03  y block $1d
    dw   $006d, $03b0
    db   $04, $02, $1e, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$0a  x block $03  y block $27
    dw   $0070, $04e0
    db   $04, $02, $26, $21
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_PLATFORM    ; #$0b  x block $05  y block $28
    dw   $00b0, $0518
    db   $06, $04, $29, $26
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_FLAMETHROWER         ; #$0c  x block $07  y block $28
    dw   $00ed, $0510
    db   $08, $06, $29, $27
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_GREEN_MONSTER        ; #$0d  x block $0a  y block $2f
    dw   $0150, $05f0
    db   $0d, $07, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_UFO                  ; #$0e  x block $43  y block $52
    dw   $0870, $0a50
    db   $44, $42, $54, $50
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_PINCER               ; #$0f  x block $58  y block $52
    dw   $0b10, $0a50
    db   $59, $57, $53, $51
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$10  x block $35  y block $53
    dw   $06b0, $0a60
    db   $36, $34, $55, $51
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_PLATFORM    ; #$11  x block $4a  y block $54
    dw   $0950, $0a80
    db   $4b, $49, $55, $4f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$12  x block $53  y block $53
    dw   $0a70, $0a68
    db   $55, $51, $54, $52
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_GEAR        ; #$13  x block $12  y block $57
    dw   $0258, $0af8
    db   $13, $11, $58, $56
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  ; #$14  x block $14  y block $58
    dw   $0290, $0b0f
    db   $17, $13, $59, $57
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  ; #$15  x block $16  y block $58
    dw   $02d0, $0b0f
    db   $17, $13, $59, $57
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_PLATFORM    ; #$16  x block $0f  y block $5a
    dw   $01f0, $0b58
    db   $10, $0e, $5b, $57
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$17  x block $31  y block $59
    dw   $0630, $0b20
    db   $32, $30, $5b, $55
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$18  x block $3a  y block $59
    dw   $0750, $0b30
    db   $3b, $39, $5a, $58
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_GEAR        ; #$19  x block $08  y block $5a
    dw   $0118, $0b58
    db   $09, $07, $5b, $59
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  ; #$1a  x block $0b  y block $5b
    dw   $0160, $0b6f
    db   $0c, $0a, $5c, $5a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_TAILSPIN_GEAR        ; #$1b  x block $33  y block $5e
    dw   $0660, $0bd8
    db   $34, $32, $5f, $5d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  ; #$1c  x block $35  y block $5f
    dw   $06b0, $0bef
    db   $38, $34, $60, $5e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM  ; #$1d  x block $37  y block $5f
    dw   $06f0, $0bef
    db   $38, $34, $60, $5e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_MOVING_PLATFORM      ; #$1e  x block $5b  y block $61
    dw   $0b70, $0c20
    db   $5c, $5a, $63, $5e
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_RED_PLATFORM         ; #$1f  x block $0b  y block $65
    dw   $0168, $0ca0
    db   $0c, $0a, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_RED_PLATFORM         ; #$20  x block $0d  y block $65
    dw   $01a8, $0ca0
    db   $0e, $0c, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_RED_PLATFORM         ; #$21  x block $11  y block $65
    dw   $0230, $0ca0
    db   $12, $10, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_RED_PLATFORM         ; #$22  x block $13  y block $65
    dw   $0270, $0ca0
    db   $14, $12, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_REZOPOLIS_RED_PLATFORM         ; #$23  x block $18  y block $65
    dw   $0300, $0ca0
    db   $19, $17, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
