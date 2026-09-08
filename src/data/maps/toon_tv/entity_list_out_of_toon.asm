; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/toon_tv/entity_list_out_of_toon.bin
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
; 68 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $7b  y block $2f
    dw   $0f60, $05f8
    db   $7c, $7a, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $7b  y block $2e
    dw   $0f60, $05c0
    db   $7c, $7a, $2f, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $25  y block $28
    dw   $04a0, $0518
    db   $26, $24, $29, $27
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $25  y block $27
    dw   $04a0, $04e0
    db   $26, $24, $28, $26
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $61  y block $0c
    dw   $0c20, $0198
    db   $62, $60, $0d, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $61  y block $0b
    dw   $0c20, $0160
    db   $62, $60, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$06  x block $47  y block $04
    dw   $08f0, $0088
    db   $48, $46, $06, $03
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$07  x block $53  y block $04
    dw   $0a70, $0090
    db   $55, $50, $05, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$08  x block $38  y block $04
    dw   $0700, $0090
    db   $39, $37, $05, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HAPPY_FACE             ; #$09  x block $41  y block $06
    dw   $0830, $00d0
    db   $42, $40, $07, $05
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$0a  x block $47  y block $06
    dw   $08f0, $00d8
    db   $49, $45, $07, $05
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MUSHROOM               ; #$0b  x block $5c  y block $06
    dw   $0b90, $00d8
    db   $5d, $5b, $07, $05
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$0c  x block $54  y block $08
    dw   $0a90, $0100
    db   $55, $4f, $0b, $07
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$0d  x block $50  y block $0a
    dw   $0a10, $0140
    db   $55, $4f, $0b, $07
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$0e  x block $33  y block $0a
    dw   $066c, $0150
    db   $34, $32, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MUSHROOM               ; #$0f  x block $2b  y block $0b
    dw   $0570, $0178
    db   $2c, $2a, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$10  x block $6b  y block $0b
    dw   $0d6c, $0170
    db   $6c, $6a, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MUSHROOM               ; #$11  x block $63  y block $0b
    dw   $0c70, $0178
    db   $64, $62, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HAPPY_FACE             ; #$12  x block $13  y block $0d
    dw   $0270, $01b0
    db   $14, $12, $0e, $0c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MUSHROOM               ; #$13  x block $15  y block $0d
    dw   $02b0, $01b8
    db   $16, $14, $0e, $0c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_LOG         ; #$14  x block $0c  y block $0e
    dw   $0190, $01d0
    db   $0d, $0b, $0f, $0d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD  ; #$15  x block $48  y block $0e
    dw   $0910, $01d0
    db   $4e, $42, $0f, $0d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$16  x block $53  y block $0e
    dw   $0a70, $01d8
    db   $55, $4f, $0f, $0d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_LOG         ; #$17  x block $0a  y block $0f
    dw   $0150, $01f0
    db   $0b, $09, $10, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$18  x block $20  y block $10
    dw   $040c, $0210
    db   $21, $1f, $11, $0f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$19  x block $26  y block $10
    dw   $04cc, $0210
    db   $27, $25, $11, $0f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HAPPY_FACE             ; #$1a  x block $0b  y block $13
    dw   $0170, $0270
    db   $0c, $0a, $14, $12
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MUSHROOM               ; #$1b  x block $2f  y block $14
    dw   $05f0, $0298
    db   $30, $2e, $15, $13
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$1c  x block $3e  y block $1c
    dw   $07d0, $0380
    db   $3f, $3d, $1f, $1b
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$1d  x block $50  y block $1c
    dw   $0a10, $0380
    db   $51, $43, $1d, $1b
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$1e  x block $39  y block $1d
    dw   $0730, $03b0
    db   $3b, $34, $1e, $1c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HUNTER                 ; #$1f  x block $5b  y block $1d
    dw   $0b70, $03b0
    db   $5d, $58, $1e, $1c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$20  x block $50  y block $1e
    dw   $0a10, $03d0
    db   $51, $4e, $1f, $1d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$21  x block $31  y block $1f
    dw   $0630, $03e0
    db   $33, $2c, $20, $1e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$22  x block $4c  y block $1f
    dw   $0990, $03f0
    db   $4e, $4b, $20, $1e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$23  x block $29  y block $21
    dw   $0530, $0420
    db   $2b, $27, $22, $20
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$24  x block $39  y block $22
    dw   $0730, $0450
    db   $3e, $36, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$25  x block $42  y block $22
    dw   $0850, $0450
    db   $46, $40, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$26  x block $49  y block $22
    dw   $0930, $0450
    db   $4d, $47, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$27  x block $34  y block $24
    dw   $0690, $0490
    db   $37, $31, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$28  x block $30  y block $25
    dw   $0610, $04a0
    db   $31, $2f, $29, $24
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_BEAR_TRAP   ; #$29  x block $5b  y block $24
    dw   $0b70, $0498
    db   $5c, $5a, $25, $23
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$2a  x block $0b  y block $27
    dw   $016c, $04f0
    db   $0c, $0a, $28, $26
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HUNTER                 ; #$2b  x block $1b  y block $28
    dw   $0370, $0510
    db   $1d, $16, $29, $27
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$2c  x block $6e  y block $2f
    dw   $0dd0, $05f0
    db   $6f, $6d, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_LOG         ; #$2d  x block $76  y block $2f
    dw   $0ed0, $05f0
    db   $77, $75, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$2e  x block $5c  y block $30
    dw   $0b90, $0610
    db   $5e, $59, $31, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_LOG         ; #$2f  x block $74  y block $30
    dw   $0e90, $0610
    db   $75, $73, $31, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_LOG         ; #$30  x block $63  y block $31
    dw   $0c70, $0630
    db   $64, $62, $32, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$31  x block $6a  y block $32
    dw   $0d50, $0650
    db   $6b, $69, $33, $2f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$32  x block $39  y block $35
    dw   $072c, $06b0
    db   $3a, $38, $36, $34
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_LIZARD                 ; #$33  x block $46  y block $36
    dw   $08cc, $06d8
    db   $48, $43, $37, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$34  x block $56  y block $35
    dw   $0ad0, $06a0
    db   $57, $55, $39, $30
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$35  x block $1b  y block $36
    dw   $036c, $06d0
    db   $1e, $18, $37, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$36  x block $20  y block $37
    dw   $0410, $06e0
    db   $22, $1e, $38, $36
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$37  x block $63  y block $37
    dw   $0c70, $06f0
    db   $64, $62, $38, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$38  x block $6a  y block $37
    dw   $0d50, $06f0
    db   $6b, $69, $38, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$39  x block $12  y block $38
    dw   $0250, $0708
    db   $19, $10, $39, $37
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HAPPY_FACE             ; #$3a  x block $0e  y block $39
    dw   $01d0, $0730
    db   $0f, $0d, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$3b  x block $63  y block $3a
    dw   $0c70, $0750
    db   $64, $62, $3b, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$3c  x block $6c  y block $3b
    dw   $0d90, $0770
    db   $6d, $6b, $3c, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$3d  x block $17  y block $3c
    dw   $02f0, $0798
    db   $19, $13, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$3e  x block $20  y block $3c
    dw   $0410, $0798
    db   $23, $1d, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$3f  x block $32  y block $3c
    dw   $0650, $0798
    db   $34, $30, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$40  x block $3c  y block $3c
    dw   $0790, $0798
    db   $3e, $3b, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$41  x block $59  y block $3e
    dw   $0b30, $07d0
    db   $5a, $58, $3f, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$42  x block $70  y block $3e
    dw   $0e10, $07d0
    db   $71, $6f, $3f, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_CACTUS                 ; #$43  x block $77  y block $3e
    dw   $0ef0, $07d0
    db   $78, $76, $3f, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
