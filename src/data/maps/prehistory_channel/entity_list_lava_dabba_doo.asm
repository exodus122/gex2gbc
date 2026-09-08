; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/entity_list_lava_dabba_doo.bin
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
; 45 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $65  y block $37
    dw   $0ca0, $06f8
    db   $66, $64, $38, $36
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $65  y block $36
    dw   $0ca0, $06c0
    db   $66, $64, $37, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$02  x block $5e  y block $07
    dw   $0bd0, $00f0
    db   $60, $5d, $08, $06
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$03  x block $1d  y block $0e
    dw   $03b0, $01d0
    db   $20, $1a, $0f, $0d
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$04  x block $20  y block $0e
    dw   $0410, $01d0
    db   $21, $1f, $11, $0d
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$05  x block $23  y block $0f
    dw   $0470, $01f0
    db   $26, $22, $10, $0e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$06  x block $19  y block $0e
    dw   $0330, $01d0
    db   $1a, $18, $11, $0c
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$07  x block $27  y block $10
    dw   $04f0, $0210
    db   $28, $24, $11, $0f
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$08  x block $51  y block $0f
    dw   $0a30, $01f0
    db   $52, $50, $16, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$09  x block $54  y block $0f
    dw   $0a90, $01f0
    db   $55, $53, $16, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$0a  x block $28  y block $11
    dw   $0510, $0230
    db   $29, $27, $13, $10
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_ANT                ; #$0b  x block $2b  y block $11
    dw   $0570, $0238
    db   $2d, $2a, $12, $10
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$0c  x block $4e  y block $10
    dw   $09d0, $0210
    db   $4f, $4d, $16, $0f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$0d  x block $57  y block $10
    dw   $0af0, $0210
    db   $58, $56, $16, $0f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_ANT                ; #$0e  x block $0b  y block $14
    dw   $0170, $0298
    db   $0d, $0a, $15, $13
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$0f  x block $14  y block $15
    dw   $0290, $02a4
    db   $1a, $12, $16, $14
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$10  x block $05  y block $1f
    dw   $00ae, $03ee
    db   $06, $04, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$11  x block $07  y block $1f
    dw   $00ee, $03ee
    db   $08, $06, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$12  x block $1e  y block $1f
    dw   $03ce, $03ee
    db   $1f, $1d, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_GEYSER             ; #$13  x block $25  y block $1f
    dw   $04ae, $03ee
    db   $26, $24, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$14  x block $0e  y block $23
    dw   $01d0, $0470
    db   $0f, $0d, $2a, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$15  x block $13  y block $23
    dw   $0270, $0470
    db   $14, $12, $30, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$16  x block $16  y block $23
    dw   $02d0, $0470
    db   $17, $15, $29, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$17  x block $1a  y block $23
    dw   $0350, $0470
    db   $1b, $19, $28, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_BEETLE_VERTICAL    ; #$18  x block $29  y block $25
    dw   $0530, $04b0
    db   $2a, $28, $27, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$19  x block $30  y block $25
    dw   $0610, $04b0
    db   $31, $2f, $30, $24
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL  ; #$1a  x block $25  y block $26
    dw   $04b0, $04d0
    db   $27, $22, $27, $25
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL  ; #$1b  x block $07  y block $29
    dw   $00f0, $0530
    db   $0a, $05, $2a, $28
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_BEETLE_VERTICAL    ; #$1c  x block $1d  y block $29
    dw   $03b0, $0530
    db   $1e, $1c, $2b, $27
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_BEETLE_VERTICAL    ; #$1d  x block $36  y block $29
    dw   $06d0, $0530
    db   $37, $35, $2b, $27
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$1e  x block $38  y block $2c
    dw   $0710, $0590
    db   $39, $37, $30, $2b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_ANT                ; #$1f  x block $26  y block $2e
    dw   $04d0, $05d8
    db   $28, $1f, $2f, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$20  x block $2e  y block $2f
    dw   $05d0, $05e4
    db   $30, $2c, $30, $2e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$21  x block $56  y block $36
    dw   $0ad0, $06d0
    db   $58, $55, $37, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$22  x block $44  y block $37
    dw   $0890, $06f0
    db   $45, $41, $38, $36
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$23  x block $5f  y block $38
    dw   $0bf0, $0718
    db   $60, $5e, $39, $37
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$24  x block $0f  y block $39
    dw   $01f0, $0730
    db   $11, $0c, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$25  x block $15  y block $39
    dw   $02b0, $0730
    db   $18, $12, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$26  x block $22  y block $39
    dw   $0450, $0730
    db   $24, $1e, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$27  x block $33  y block $39
    dw   $0670, $0730
    db   $38, $2a, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$28  x block $4e  y block $39
    dw   $09d0, $0730
    db   $4f, $4b, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$29  x block $0d  y block $3b
    dw   $01b0, $0764
    db   $13, $0a, $3c, $3a
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$2a  x block $20  y block $3b
    dw   $0410, $0764
    db   $24, $1e, $3c, $3a
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$2b  x block $2b  y block $3b
    dw   $0570, $0764
    db   $38, $29, $3c, $3a
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$2c  x block $47  y block $3b
    dw   $08f0, $0764
    db   $53, $45, $3c, $3a
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
