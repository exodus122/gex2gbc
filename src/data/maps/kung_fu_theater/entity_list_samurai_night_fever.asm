; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/entity_list_samurai_night_fever.bin
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
; 59 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $3c  y block $19
    dw   $0780, $0338
    db   $3d, $3b, $1a, $18
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $3c  y block $18
    dw   $0780, $0300
    db   $3d, $3b, $19, $17
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $7c  y block $2d
    dw   $0f80, $05b8
    db   $7d, $7b, $2e, $2c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $7c  y block $2c
    dw   $0f80, $0580
    db   $7d, $7b, $2d, $2b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $2f  y block $3d
    dw   $05e0, $07b8
    db   $30, $2e, $3e, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $2f  y block $3c
    dw   $05e0, $0780
    db   $30, $2e, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_WALKING_NINJA  ; #$06  x block $50  y block $2f
    dw   $0a10, $05f0
    db   $52, $4e, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_SPIKY_LOG      ; #$07  x block $66  y block $04
    dw   $0cd0, $0090
    db   $67, $65, $06, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$08  x block $70  y block $06
    dw   $0e10, $00c0
    db   $74, $6e, $07, $05
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JUMPING_NINJA  ; #$09  x block $38  y block $0a
    dw   $0710, $0150
    db   $3a, $36, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$0a  x block $40  y block $0a
    dw   $0810, $0150
    db   $41, $3f, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_DRAGONFLY      ; #$0b  x block $10  y block $0c
    dw   $0210, $0190
    db   $18, $0c, $0d, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$0c  x block $20  y block $0c
    dw   $0410, $0190
    db   $21, $1f, $0d, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$0d  x block $25  y block $0c
    dw   $04b0, $0190
    db   $26, $24, $0d, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_SPIKY_LOG      ; #$0e  x block $30  y block $0c
    dw   $0610, $0190
    db   $31, $2f, $0e, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$0f  x block $53  y block $0c
    dw   $0a70, $0180
    db   $54, $52, $0e, $0b
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_WALKING_NINJA  ; #$10  x block $46  y block $0d
    dw   $08d0, $01b0
    db   $4a, $44, $0e, $0c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$11  x block $55  y block $0e
    dw   $0ab0, $01c8
    db   $56, $54, $10, $0c
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$12  x block $5c  y block $0e
    dw   $0b90, $01c8
    db   $5d, $5b, $0f, $0a
    db   $52, $00, $10
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$13  x block $6a  y block $10
    dw   $0d50, $0210
    db   $6b, $69, $11, $0f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$14  x block $41  y block $1a
    dw   $0830, $0340
    db   $44, $3e, $1b, $19
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$15  x block $49  y block $1a
    dw   $0930, $0340
    db   $4a, $48, $1f, $18
    db   $52, $02, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$16  x block $08  y block $1e
    dw   $0110, $03d0
    db   $09, $07, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$17  x block $10  y block $1e
    dw   $0210, $03d0
    db   $11, $0f, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$18  x block $18  y block $1e
    dw   $0310, $03d0
    db   $19, $17, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_DRAGONFLY      ; #$19  x block $2a  y block $1e
    dw   $0550, $03d0
    db   $2d, $26, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$1a  x block $40  y block $1f
    dw   $0810, $03f0
    db   $42, $3f, $20, $1e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$1b  x block $48  y block $20
    dw   $0910, $0400
    db   $4b, $47, $21, $1f
    db   $a0, $01, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_WALKING_NINJA  ; #$1c  x block $34  y block $22
    dw   $0690, $0450
    db   $3a, $32, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$1d  x block $66  y block $22
    dw   $0cd0, $0450
    db   $67, $65, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$1e  x block $6b  y block $22
    dw   $0d70, $0450
    db   $6c, $6a, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$1f  x block $79  y block $2e
    dw   $0f30, $05d0
    db   $7a, $78, $2f, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$20  x block $34  y block $2f
    dw   $0690, $05e8
    db   $36, $32, $30, $2e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$21  x block $3e  y block $30
    dw   $07d0, $0600
    db   $40, $3c, $31, $2f
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$22  x block $44  y block $2f
    dw   $0890, $05f0
    db   $45, $43, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$23  x block $6e  y block $2f
    dw   $0dd0, $05e0
    db   $75, $6c, $30, $2e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$24  x block $20  y block $30
    dw   $0410, $0610
    db   $21, $1f, $32, $2e
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$25  x block $49  y block $30
    dw   $0930, $0600
    db   $4a, $48, $31, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$26  x block $5a  y block $30
    dw   $0b40, $0600
    db   $5b, $59, $31, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$27  x block $0d  y block $31
    dw   $01b0, $0630
    db   $0e, $0c, $32, $30
    db   $00, $00, $80
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$28  x block $10  y block $31
    dw   $0210, $0620
    db   $12, $0e, $32, $30
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JUMPING_NINJA  ; #$29  x block $1d  y block $31
    dw   $03b0, $0630
    db   $1e, $1b, $32, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2a  x block $27  y block $31
    dw   $04f0, $0638
    db   $29, $24, $32, $30
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$2b  x block $0b  y block $32
    dw   $0170, $0640
    db   $0c, $0a, $33, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2c  x block $15  y block $32
    dw   $02b0, $0640
    db   $1b, $13, $33, $31
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2d  x block $38  y block $42
    dw   $0710, $0848
    db   $39, $37, $44, $3e
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2e  x block $2e  y block $44
    dw   $05d0, $0890
    db   $30, $2b, $45, $43
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$2f  x block $37  y block $44
    dw   $06f0, $0880
    db   $38, $36, $45, $43
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$30  x block $11  y block $46
    dw   $0230, $08c0
    db   $12, $10, $47, $45
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JUMPING_NINJA  ; #$31  x block $2b  y block $45
    dw   $0570, $08b0
    db   $2d, $29, $46, $44
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$32  x block $13  y block $47
    dw   $0270, $08f0
    db   $14, $12, $48, $46
    db   $00, $00, $80
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$33  x block $02  y block $48
    dw   $0050, $0910
    db   $03, $01, $49, $47
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$34  x block $05  y block $48
    dw   $00b0, $0910
    db   $06, $04, $49, $47
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$35  x block $2f  y block $4a
    dw   $05f0, $0950
    db   $30, $2e, $4b, $49
    db   $00, $00, $80
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM  ; #$36  x block $2d  y block $4b
    dw   $05b0, $0970
    db   $2e, $2c, $4c, $4a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$37  x block $2c  y block $4f
    dw   $0590, $09e8
    db   $2d, $2b, $50, $4e
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$38  x block $31  y block $50
    dw   $0630, $0a00
    db   $32, $2d, $51, $4f
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_SAMURAI_BODY   ; #$39  x block $34  y block $54
    dw   $0690, $0a90
    db   $36, $32, $55, $53
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$3a  x block $2e  y block $55
    dw   $05d0, $0aa0
    db   $30, $2d, $56, $54
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
