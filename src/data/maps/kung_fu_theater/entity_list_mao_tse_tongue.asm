; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/kung_fu_theater/entity_list_mao_tse_tongue.bin
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
; 48 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $2d  y block $24
    dw   $05a0, $0498
    db   $2e, $2c, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $2d  y block $23
    dw   $05a0, $0460
    db   $2e, $2c, $24, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $68  y block $3e
    dw   $0d00, $07d8
    db   $69, $67, $3f, $3d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $68  y block $3d
    dw   $0d00, $07a0
    db   $69, $67, $3e, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JUMPING_NINJA  ; #$04  x block $14  y block $36
    dw   $0290, $06d0
    db   $19, $10, $37, $35
    db   $04, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JUMPING_NINJA  ; #$05  x block $62  y block $35
    dw   $0c50, $06b0
    db   $68, $57, $36, $34
    db   $04, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$06  x block $3b  y block $06
    dw   $0770, $00c0
    db   $3e, $39, $07, $05
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$07  x block $30  y block $06
    dw   $0610, $00c0
    db   $31, $2f, $08, $04
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$08  x block $70  y block $0d
    dw   $0e10, $01b0
    db   $71, $6f, $0e, $0c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$09  x block $10  y block $0f
    dw   $0210, $01e0
    db   $15, $0e, $10, $0e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$0a  x block $0a  y block $11
    dw   $0140, $0230
    db   $0b, $09, $12, $10
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$0b  x block $45  y block $12
    dw   $08b0, $0250
    db   $46, $44, $13, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_SAMURAI_BODY   ; #$0c  x block $5d  y block $12
    dw   $0bb0, $0250
    db   $60, $5c, $13, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$0d  x block $08  y block $15
    dw   $0110, $02b0
    db   $09, $07, $16, $14
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$0e  x block $1b  y block $15
    dw   $0370, $02b0
    db   $1c, $1a, $16, $14
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$0f  x block $63  y block $16
    dw   $0c60, $02d0
    db   $64, $62, $17, $15
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_LIZARD         ; #$10  x block $68  y block $1c
    dw   $0d10, $0398
    db   $6a, $67, $1d, $1b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$11  x block $03  y block $1d
    dw   $0070, $03b0
    db   $04, $02, $1e, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$12  x block $17  y block $1d
    dw   $02f0, $03b0
    db   $18, $16, $1e, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$13  x block $1e  y block $1d
    dw   $03d0, $03b0
    db   $1f, $1d, $1e, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_LIZARD         ; #$14  x block $69  y block $1e
    dw   $0d30, $03d8
    db   $6b, $68, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_LIZARD         ; #$15  x block $62  y block $1f
    dw   $0c50, $03f8
    db   $65, $60, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_HANGING_BLADE  ; #$16  x block $43  y block $21
    dw   $0870, $0430
    db   $44, $42, $23, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_HANGING_BLADE  ; #$17  x block $49  y block $21
    dw   $0930, $0430
    db   $4a, $48, $23, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$18  x block $38  y block $23
    dw   $0710, $0460
    db   $3a, $37, $24, $22
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$19  x block $2b  y block $24
    dw   $0570, $0490
    db   $2c, $2a, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_CANNON         ; #$1a  x block $11  y block $27
    dw   $0234, $04f4
    db   $12, $10, $28, $26
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_DRAGON_HEAD    ; #$1b  x block $0e  y block $27
    dw   $01d0, $04f0
    db   $15, $0d, $2b, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT  ; #$1c  x block $0e  y block $27
    dw   $01d0, $04f0
    db   $15, $0d, $2b, $23
    db   $37, $03, $01
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT  ; #$1d  x block $0e  y block $27
    dw   $01d0, $04f0
    db   $15, $0d, $2b, $23
    db   $1e, $03, $02
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT  ; #$1e  x block $0e  y block $27
    dw   $01d0, $04f0
    db   $15, $0d, $2b, $23
    db   $05, $03, $03
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$1f  x block $42  y block $26
    dw   $0840, $04d0
    db   $43, $41, $27, $25
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$20  x block $49  y block $26
    dw   $0920, $04d0
    db   $4a, $48, $27, $25
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$21  x block $28  y block $29
    dw   $0510, $0530
    db   $29, $27, $2a, $28
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$22  x block $2e  y block $2b
    dw   $05d0, $0570
    db   $2f, $2d, $2c, $2a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$23  x block $5d  y block $2f
    dw   $0bb0, $05f0
    db   $5e, $5c, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_JAR            ; #$24  x block $61  y block $30
    dw   $0c30, $0600
    db   $62, $60, $31, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$25  x block $3b  y block $33
    dw   $0760, $0670
    db   $3c, $3a, $34, $32
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$26  x block $4d  y block $34
    dw   $09b0, $0690
    db   $4e, $4c, $35, $33
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$27  x block $06  y block $35
    dw   $00d0, $06b0
    db   $07, $05, $36, $34
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$28  x block $1e  y block $35
    dw   $03d0, $06a0
    db   $1f, $1d, $36, $33
    db   $52, $00, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$29  x block $27  y block $35
    dw   $04f0, $06b0
    db   $28, $26, $36, $34
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_TALL_JAR       ; #$2a  x block $2e  y block $35
    dw   $05d0, $06b0
    db   $2f, $2d, $36, $34
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2b  x block $43  y block $3b
    dw   $0870, $0770
    db   $44, $42, $3e, $39
    db   $52, $01, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2c  x block $5a  y block $41
    dw   $0b50, $0820
    db   $5b, $58, $42, $40
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2d  x block $60  y block $40
    dw   $0c10, $0810
    db   $61, $5f, $42, $3f
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2e  x block $64  y block $40
    dw   $0c90, $0800
    db   $65, $62, $41, $3f
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM  ; #$2f  x block $5c  y block $41
    dw   $0b90, $0830
    db   $5d, $5a, $42, $40
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
