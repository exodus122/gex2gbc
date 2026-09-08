; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/media_dimension/entity_list_media_dimension.bin
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
; 67 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $06  y block $0c
    dw   $00c0, $0198
    db   $07, $05, $0d, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $06  y block $0b
    dw   $00c0, $0160
    db   $07, $05, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $37  y block $0c
    dw   $06e0, $0198
    db   $38, $36, $0d, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $37  y block $0b
    dw   $06e0, $0160
    db   $38, $36, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$06  x block $12  y block $17
    dw   $0240, $02f8
    db   $13, $11, $18, $16
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$07  x block $12  y block $16
    dw   $0240, $02c0
    db   $13, $11, $17, $15
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$08  x block $3a  y block $17
    dw   $0740, $02f8
    db   $3b, $39, $18, $16
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$09  x block $3a  y block $16
    dw   $0740, $02c0
    db   $3b, $39, $17, $15
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$0a  x block $26  y block $17
    dw   $04c0, $02f8
    db   $27, $25, $18, $16
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$0b  x block $26  y block $16
    dw   $04c0, $02c0
    db   $27, $25, $17, $15
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$0c  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$0d  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$0e  x block $1f  y block $24
    dw   $03e0, $0498
    db   $20, $1e, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$0f  x block $1f  y block $23
    dw   $03e0, $0460
    db   $20, $1e, $24, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$10  x block $33  y block $24
    dw   $0660, $0498
    db   $34, $32, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$11  x block $33  y block $23
    dw   $0660, $0460
    db   $34, $32, $24, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$12  x block $25  y block $47
    dw   $04a0, $08f8
    db   $26, $24, $48, $46
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$13  x block $25  y block $46
    dw   $04a0, $08c0
    db   $26, $24, $47, $45
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$14  x block $1b  y block $47
    dw   $0360, $08f8
    db   $1c, $1a, $48, $46
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$15  x block $1b  y block $46
    dw   $0360, $08c0
    db   $1c, $1a, $47, $45
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$16  x block $11  y block $47
    dw   $0220, $08f8
    db   $12, $10, $48, $46
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$17  x block $11  y block $46
    dw   $0220, $08c0
    db   $12, $10, $47, $45
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$18  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$19  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$1a  x block $12  y block $32
    dw   $0240, $0658
    db   $13, $11, $33, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$1b  x block $12  y block $31
    dw   $0240, $0620
    db   $13, $11, $32, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$1c  x block $3f  y block $32
    dw   $07e0, $0658
    db   $40, $3e, $33, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$1d  x block $3f  y block $31
    dw   $07e0, $0620
    db   $40, $3e, $32, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$1e  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$1f  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$20  x block $1b  y block $0e
    dw   $0360, $01d8
    db   $1c, $1a, $0f, $0d
    db   $00, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$21  x block $1b  y block $0d
    dw   $0360, $01a0
    db   $1c, $1a, $0e, $0c
    db   $00, $02, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$22  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$23  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$24  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$25  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$26  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$27  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$28  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$29  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$2a  x block $27  y block $1f
    dw   $04e0, $03f8
    db   $28, $26, $20, $1e
    db   $00, $04, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$2b  x block $27  y block $1e
    dw   $04e0, $03c0
    db   $28, $26, $1f, $1d
    db   $00, $04, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$2c  x block $19  y block $4d
    dw   $0320, $09b8
    db   $1a, $18, $4e, $4c
    db   $00, $10, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$2d  x block $19  y block $4c
    dw   $0320, $0980
    db   $1a, $18, $4d, $4b
    db   $00, $10, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$2e  x block $1d  y block $32
    dw   $03a0, $0658
    db   $1e, $1c, $33, $31
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$2f  x block $1d  y block $31
    dw   $03a0, $0620
    db   $1e, $1c, $32, $30
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$30  x block $1b  y block $05
    dw   $0360, $00b8
    db   $1c, $1a, $06, $04
    db   $00, $00, $01
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$31  x block $1b  y block $04
    dw   $0360, $0080
    db   $1c, $1a, $05, $03
    db   $00, $00, $01
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$32  x block $12  y block $05
    dw   $0240, $00b8
    db   $13, $11, $06, $04
    db   $00, $00, $02
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$33  x block $12  y block $04
    dw   $0240, $0080
    db   $13, $11, $05, $03
    db   $00, $00, $02
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$34  x block $24  y block $05
    dw   $0480, $00b8
    db   $25, $23, $06, $04
    db   $00, $00, $04
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$35  x block $24  y block $04
    dw   $0480, $0080
    db   $25, $23, $05, $03
    db   $00, $00, $04
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$36  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$37  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$38  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$39  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$3a  x block $80  y block $80
    dw   $1000, $1018
    db   $81, $7f, $81, $7f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$3b  x block $80  y block $7f
    dw   $1000, $0fe0
    db   $81, $7f, $80, $7e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$3c  x block $49  y block $32
    dw   $0920, $0658
    db   $4a, $48, $33, $31
    db   $22, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$3d  x block $49  y block $31
    dw   $0920, $0620
    db   $4a, $48, $32, $30
    db   $22, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM  ; #$3e  x block $28  y block $0b
    dw   $0510, $0170
    db   $29, $27, $0c, $05
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM  ; #$3f  x block $11  y block $25
    dw   $0230, $04a0
    db   $13, $0f, $26, $24
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM  ; #$40  x block $21  y block $3b
    dw   $0430, $0770
    db   $22, $20, $3c, $32
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM  ; #$41  x block $2e  y block $3b
    dw   $05d0, $0760
    db   $2f, $2d, $3c, $33
    db   $52, $1a, $10
    db   $00, $00, $00, $00

    db   ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM  ; #$42  x block $11  y block $4e
    dw   $0230, $09c0
    db   $13, $0f, $4f, $4d
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
