; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/entity_list_wwwdotcomcom.bin
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
; 65 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $16  y block $1f
    dw   $02c0, $03f8
    db   $17, $15, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $16  y block $1e
    dw   $02c0, $03c0
    db   $17, $15, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $7a  y block $3b
    dw   $0f40, $0778
    db   $7b, $79, $3c, $3a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $7a  y block $3a
    dw   $0f40, $0740
    db   $7b, $79, $3b, $39
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$04  x block $49  y block $0c
    dw   $0930, $0180
    db   $4a, $48, $0d, $06
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$05  x block $71  y block $0a
    dw   $0e30, $0150
    db   $72, $70, $0b, $07
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$06  x block $75  y block $0b
    dw   $0eb0, $0170
    db   $76, $74, $0c, $08
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$07  x block $04  y block $1e
    dw   $0090, $03d0
    db   $05, $03, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$08  x block $0b  y block $1f
    dw   $0170, $03f0
    db   $0e, $09, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$09  x block $25  y block $22
    dw   $04b0, $0450
    db   $26, $24, $23, $1f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$0a  x block $75  y block $22
    dw   $0eb0, $0450
    db   $76, $74, $23, $1f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$0b  x block $29  y block $30
    dw   $0530, $0610
    db   $2a, $28, $31, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$0c  x block $5c  y block $30
    dw   $0b90, $0610
    db   $5d, $5b, $31, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$0d  x block $60  y block $30
    dw   $0c10, $0610
    db   $61, $5f, $31, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$0e  x block $73  y block $3c
    dw   $0e70, $0780
    db   $78, $72, $3d, $3b
    db   $08, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$0f  x block $56  y block $40
    dw   $0ad0, $0800
    db   $57, $55, $41, $3d
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$10  x block $37  y block $42
    dw   $06f0, $0850
    db   $38, $36, $43, $3f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$11  x block $3b  y block $42
    dw   $0770, $0850
    db   $3c, $3a, $43, $3f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$12  x block $5e  y block $42
    dw   $0bd0, $0850
    db   $61, $59, $43, $41
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$13  x block $22  y block $43
    dw   $0450, $0870
    db   $23, $21, $44, $40
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$14  x block $4a  y block $43
    dw   $0950, $0860
    db   $4b, $49, $44, $3f
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$15  x block $20  y block $44
    dw   $0410, $0890
    db   $21, $1f, $45, $41
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM  ; #$16  x block $25  y block $44
    dw   $04b0, $0890
    db   $32, $24, $45, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$17  x block $12  y block $0f
    dw   $0250, $01f0
    db   $13, $11, $10, $0e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$18  x block $1a  y block $0f
    dw   $0350, $01f0
    db   $1b, $19, $10, $0e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$19  x block $57  y block $10
    dw   $0af0, $0210
    db   $19, $13, $11, $0e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$1a  x block $4c  y block $3f
    dw   $0990, $07f0
    db   $4d, $4b, $40, $3e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$1b  x block $54  y block $3f
    dw   $0a90, $07f0
    db   $55, $53, $40, $3e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$1c  x block $57  y block $40
    dw   $0af0, $0810
    db   $53, $4d, $41, $3e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$1d  x block $4a  y block $2f
    dw   $0950, $05f0
    db   $4b, $49, $30, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$1e  x block $52  y block $2f
    dw   $0a50, $05f0
    db   $53, $51, $30, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$1f  x block $57  y block $30
    dw   $0af0, $0610
    db   $51, $4b, $31, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$20  x block $17  y block $0c
    dw   $02f0, $0190
    db   $18, $16, $0d, $0b
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$21  x block $1f  y block $0c
    dw   $03f0, $0190
    db   $20, $1e, $0d, $0b
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$22  x block $57  y block $0d
    dw   $0af0, $01b0
    db   $1e, $18, $0e, $0b
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$23  x block $58  y block $3d
    dw   $0b10, $07b0
    db   $59, $57, $3e, $3c
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$24  x block $60  y block $3d
    dw   $0c10, $07b0
    db   $61, $5f, $3e, $3c
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$25  x block $57  y block $3e
    dw   $0af0, $07d0
    db   $5f, $59, $3f, $3c
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$26  x block $3f  y block $2f
    dw   $07f0, $05f0
    db   $40, $3e, $30, $2e
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$27  x block $47  y block $2f
    dw   $08f0, $05f0
    db   $48, $46, $30, $2e
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$28  x block $57  y block $30
    dw   $0af0, $0610
    db   $46, $40, $31, $2e
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$29  x block $15  y block $07
    dw   $02b0, $00f0
    db   $16, $14, $08, $06
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$2a  x block $1d  y block $07
    dw   $03b0, $00f0
    db   $1e, $1c, $08, $06
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$2b  x block $57  y block $08
    dw   $0af0, $0110
    db   $1c, $16, $09, $06
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$2c  x block $66  y block $3b
    dw   $0cd0, $0770
    db   $67, $65, $3c, $3a
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$2d  x block $71  y block $3b
    dw   $0e30, $0770
    db   $72, $70, $3c, $3a
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$2e  x block $57  y block $3c
    dw   $0af0, $0790
    db   $70, $67, $3d, $3a
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$2f  x block $34  y block $2f
    dw   $0690, $05f0
    db   $35, $33, $30, $2e
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$30  x block $3c  y block $2f
    dw   $0790, $05f0
    db   $3d, $3b, $30, $2e
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$31  x block $57  y block $30
    dw   $0af0, $0610
    db   $3b, $35, $31, $2e
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$32  x block $33  y block $0a
    dw   $0670, $0150
    db   $34, $32, $0b, $09
    db   $08, $07, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$33  x block $16  y block $14
    dw   $02d0, $0290
    db   $17, $15, $15, $13
    db   $60, $09, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$34  x block $31  y block $2f
    dw   $0630, $05f0
    db   $32, $30, $30, $2e
    db   $b0, $04, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$35  x block $55  y block $2f
    dw   $0ab0, $05f0
    db   $56, $54, $30, $2e
    db   $b0, $04, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$36  x block $11  y block $34
    dw   $0230, $0690
    db   $12, $10, $35, $33
    db   $b0, $04, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$37  x block $63  y block $3c
    dw   $0c70, $0790
    db   $64, $62, $3d, $3b
    db   $58, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$38  x block $0b  y block $41
    dw   $0170, $0830
    db   $0c, $0a, $42, $40
    db   $d0, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$39  x block $63  y block $41
    dw   $0c70, $0830
    db   $64, $62, $42, $40
    db   $b0, $04, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$3a  x block $2d  y block $46
    dw   $05b0, $08d0
    db   $2e, $2c, $47, $45
    db   $2c, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$3b  x block $3f  y block $06
    dw   $07e8, $00d7
    db   $47, $3e, $08, $05
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$3c  x block $3b  y block $09
    dw   $0768, $0137
    db   $47, $3a, $0c, $08
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$3d  x block $64  y block $09
    dw   $0c88, $0137
    db   $6e, $63, $0b, $08
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$3e  x block $4c  y block $07
    dw   $0988, $00f7
    db   $61, $4b, $0b, $06
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$3f  x block $2d  y block $21
    dw   $05a8, $0437
    db   $45, $2c, $24, $20
    db   $04, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$40  x block $47  y block $21
    dw   $08e8, $0437
    db   $6e, $46, $22, $20
    db   $05, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
