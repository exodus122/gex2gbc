; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/circuit_central/entity_list_honey_i_shrunk_the_gecko.bin
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
; 81 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $6d  y block $3e
    dw   $0da0, $07d8
    db   $6e, $6c, $3f, $3d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $6d  y block $3d
    dw   $0da0, $07a0
    db   $6e, $6c, $3e, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $07  y block $52
    dw   $00e0, $0a58
    db   $08, $06, $53, $51
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $07  y block $51
    dw   $00e0, $0a20
    db   $08, $06, $52, $50
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $68  y block $05
    dw   $0d00, $00b8
    db   $69, $67, $06, $04
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $68  y block $04
    dw   $0d00, $0080
    db   $69, $67, $05, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$06  x block $7a  y block $09
    dw   $0f50, $0130
    db   $7b, $79, $0a, $05
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$07  x block $6c  y block $0a
    dw   $0d90, $0150
    db   $6e, $69, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$08  x block $6f  y block $0b
    dw   $0df0, $0160
    db   $7a, $6e, $0c, $0a
    db   $08, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$09  x block $68  y block $0e
    dw   $0d10, $01d0
    db   $69, $67, $0f, $0a
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$0a  x block $0a  y block $0f
    dw   $0150, $01f0
    db   $0f, $06, $10, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$0b  x block $34  y block $0f
    dw   $0690, $01f0
    db   $35, $33, $10, $0c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$0c  x block $79  y block $10
    dw   $0f30, $0200
    db   $7a, $67, $11, $0f
    db   $a8, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$0d  x block $7b  y block $11
    dw   $0f70, $0220
    db   $7c, $7a, $13, $10
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$0e  x block $79  y block $12
    dw   $0f30, $0240
    db   $7a, $78, $14, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$0f  x block $67  y block $13
    dw   $0cf0, $0270
    db   $69, $64, $14, $12
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$10  x block $72  y block $13
    dw   $0e50, $0270
    db   $76, $6e, $14, $12
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$11  x block $7a  y block $13
    dw   $0f50, $0260
    db   $7b, $78, $15, $12
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$12  x block $52  y block $1b
    dw   $0a50, $0370
    db   $53, $51, $1c, $18
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ANT            ; #$13  x block $65  y block $1c
    dw   $0cb0, $0398
    db   $67, $63, $1d, $1b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_CAPACITOR      ; #$14  x block $6c  y block $1c
    dw   $0d90, $0390
    db   $6d, $6b, $1d, $1a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$15  x block $77  y block $1e
    dw   $0ef0, $03d0
    db   $78, $76, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$16  x block $0e  y block $1f
    dw   $01d0, $03e0
    db   $0f, $0d, $21, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$17  x block $0d  y block $20
    dw   $01b0, $0400
    db   $0f, $0c, $22, $1f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM  ; #$18  x block $5e  y block $22
    dw   $0bd0, $0450
    db   $5f, $4d, $23, $21
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$19  x block $6e  y block $22
    dw   $0dd0, $0450
    db   $70, $6c, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$1a  x block $11  y block $25
    dw   $0230, $04b0
    db   $19, $0f, $26, $24
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$1b  x block $25  y block $25
    dw   $04b0, $04b0
    db   $28, $22, $26, $24
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$1c  x block $4f  y block $2a
    dw   $09f0, $0550
    db   $52, $4c, $2b, $29
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$1d  x block $66  y block $2a
    dw   $0cd0, $0550
    db   $69, $63, $2b, $29
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$1e  x block $6b  y block $2a
    dw   $0d70, $0540
    db   $6c, $6a, $2b, $22
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$1f  x block $6f  y block $2a
    dw   $0df0, $0550
    db   $72, $6c, $2b, $29
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$20  x block $7c  y block $2a
    dw   $0f90, $0550
    db   $7e, $79, $2b, $29
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ANT            ; #$21  x block $3e  y block $2b
    dw   $07d0, $0578
    db   $41, $3b, $2c, $2a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ANT            ; #$22  x block $1d  y block $2d
    dw   $03b0, $05b8
    db   $1f, $1b, $2e, $2c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$23  x block $5d  y block $2d
    dw   $0bb0, $05a0
    db   $5e, $5c, $2e, $2c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM  ; #$24  x block $20  y block $2e
    dw   $0410, $05c0
    db   $21, $1f, $2f, $25
    db   $5a, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ANT            ; #$25  x block $2c  y block $2e
    dw   $0590, $05d8
    db   $2e, $29, $2f, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$26  x block $5c  y block $2e
    dw   $0b90, $05c0
    db   $5d, $5b, $2f, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ANT            ; #$27  x block $19  y block $2f
    dw   $0330, $05f8
    db   $1b, $16, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$28  x block $5d  y block $2f
    dw   $0bb0, $05e0
    db   $5e, $5c, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$29  x block $0f  y block $30
    dw   $01f0, $0600
    db   $10, $0e, $32, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM  ; #$2a  x block $40  y block $30
    dw   $0810, $0610
    db   $41, $30, $31, $27
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$2b  x block $0d  y block $31
    dw   $01b0, $0620
    db   $0e, $0c, $33, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$2c  x block $0b  y block $32
    dw   $0170, $0640
    db   $0c, $0a, $34, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ANT            ; #$2d  x block $3d  y block $32
    dw   $07b0, $0658
    db   $40, $3b, $33, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$2e  x block $5f  y block $33
    dw   $0bf0, $0670
    db   $61, $5d, $34, $32
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$2f  x block $09  y block $34
    dw   $0130, $0690
    db   $0c, $07, $35, $33
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT   ; #$30  x block $53  y block $34
    dw   $0a70, $0690
    db   $57, $51, $35, $33
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT   ; #$31  x block $5f  y block $42
    dw   $0bf0, $0850
    db   $61, $5a, $43, $41
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM  ; #$32  x block $17  y block $68
    dw   $02f0, $0d10
    db   $18, $0f, $69, $52
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$33  x block $19  y block $6b
    dw   $0330, $0d60
    db   $1a, $18, $6d, $6a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM  ; #$34  x block $18  y block $6c
    dw   $0310, $0d80
    db   $1a, $17, $6e, $6b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$35  x block $55  y block $2f
    dw   $0ab0, $05f0
    db   $56, $54, $30, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$36  x block $5d  y block $2f
    dw   $0bb0, $05f0
    db   $5e, $5c, $30, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$37  x block $57  y block $30
    dw   $0af0, $0610
    db   $5c, $56, $31, $2e
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$38  x block $1f  y block $20
    dw   $03f0, $0410
    db   $20, $1e, $21, $1f
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$39  x block $27  y block $20
    dw   $04f0, $0410
    db   $28, $26, $21, $1f
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$3a  x block $21  y block $21
    dw   $0430, $0430
    db   $26, $20, $22, $1f
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$3b  x block $59  y block $2a
    dw   $0b30, $0550
    db   $5a, $58, $2b, $29
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$3c  x block $61  y block $2a
    dw   $0c30, $0550
    db   $62, $60, $2b, $29
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$3d  x block $5b  y block $2b
    dw   $0b70, $0570
    db   $60, $5a, $2c, $29
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$3e  x block $1a  y block $1b
    dw   $0350, $0370
    db   $1b, $19, $1c, $1a
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$3f  x block $22  y block $1b
    dw   $0450, $0370
    db   $23, $21, $1c, $1a
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$40  x block $1c  y block $1c
    dw   $0390, $0390
    db   $21, $1b, $1d, $1a
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$41  x block $71  y block $05
    dw   $0e30, $00b0
    db   $72, $70, $06, $04
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY  ; #$42  x block $79  y block $05
    dw   $0f30, $00b0
    db   $7a, $78, $06, $04
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR  ; #$43  x block $73  y block $06
    dw   $0e70, $00d0
    db   $78, $72, $07, $04
    db   $03, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$44  x block $6b  y block $12
    dw   $0d70, $0250
    db   $6c, $6a, $13, $11
    db   $60, $09, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$45  x block $0f  y block $25
    dw   $01f0, $04b0
    db   $10, $0e, $26, $24
    db   $60, $09, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$46  x block $4f  y block $29
    dw   $09f0, $0530
    db   $50, $4e, $2a, $28
    db   $58, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$47  x block $74  y block $2a
    dw   $0e90, $0550
    db   $75, $73, $2b, $29
    db   $58, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$48  x block $5d  y block $2c
    dw   $0bb0, $0590
    db   $5e, $5c, $2d, $2b
    db   $58, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$49  x block $23  y block $2d
    dw   $0470, $05b0
    db   $24, $22, $2e, $2c
    db   $2c, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$4a  x block $06  y block $33
    dw   $00d0, $0670
    db   $07, $05, $34, $32
    db   $e0, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$4b  x block $62  y block $34
    dw   $0c50, $0690
    db   $63, $61, $35, $33
    db   $58, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_POWER_UP       ; #$4c  x block $75  y block $50
    dw   $0eb0, $0a10
    db   $76, $74, $51, $4f
    db   $08, $07, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$4d  x block $14  y block $0e
    dw   $0288, $01d7
    db   $1b, $13, $0f, $0d
    db   $06, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$4e  x block $1d  y block $0e
    dw   $03a8, $01d7
    db   $28, $1c, $10, $0d
    db   $07, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$4f  x block $20  y block $0c
    dw   $0408, $0197
    db   $26, $1f, $0e, $0b
    db   $08, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL  ; #$50  x block $14  y block $41
    dw   $0288, $0837
    db   $55, $13, $44, $3e
    db   $09, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
