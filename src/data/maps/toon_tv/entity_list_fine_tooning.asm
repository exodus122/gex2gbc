; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/toon_tv/entity_list_fine_tooning.bin
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
; 74 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $3d  y block $71
    dw   $07a0, $0e38
    db   $3e, $3c, $72, $70
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $3d  y block $70
    dw   $07a0, $0e00
    db   $3e, $3c, $71, $6f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $6f  y block $59
    dw   $0de0, $0b38
    db   $70, $6e, $5a, $58
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $6f  y block $58
    dw   $0de0, $0b00
    db   $70, $6e, $59, $57
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$04  x block $0d  y block $46
    dw   $01b0, $08c8
    db   $10, $0a, $47, $45
    db   $a0, $08, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$05  x block $0d  y block $48
    dw   $01b0, $0908
    db   $10, $0a, $49, $47
    db   $00, $08, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$06  x block $14  y block $49
    dw   $0290, $0930
    db   $19, $13, $4c, $48
    db   $00, $00, $b4
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$07  x block $16  y block $4a
    dw   $02d0, $0950
    db   $19, $13, $4c, $48
    db   $00, $00, $5a
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$08  x block $22  y block $4a
    dw   $044c, $0950
    db   $23, $21, $4b, $49
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$09  x block $27  y block $4a
    dw   $04ec, $0950
    db   $28, $26, $4b, $49
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$0a  x block $2c  y block $4a
    dw   $058c, $0950
    db   $2d, $2b, $4b, $49
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$0b  x block $18  y block $4b
    dw   $0310, $0970
    db   $19, $13, $4c, $48
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD  ; #$0c  x block $3d  y block $4b
    dw   $07b0, $0960
    db   $41, $39, $4c, $4a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$0d  x block $37  y block $4c
    dw   $06f0, $0998
    db   $39, $34, $4d, $4b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$0e  x block $47  y block $4c
    dw   $08f6, $0980
    db   $4a, $46, $4d, $4b
    db   $00, $00, $80
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$0f  x block $49  y block $4c
    dw   $0932, $0980
    db   $4a, $46, $4d, $4b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$10  x block $4e  y block $4c
    dw   $09d0, $098c
    db   $4f, $4d, $4d, $4b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$11  x block $53  y block $4d
    dw   $0a70, $09b0
    db   $55, $51, $4e, $4c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$12  x block $58  y block $4f
    dw   $0b10, $09f0
    db   $5a, $56, $50, $4e
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$13  x block $5c  y block $52
    dw   $0b90, $0a40
    db   $5d, $5b, $54, $50
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$14  x block $45  y block $53
    dw   $08a0, $0a68
    db   $46, $44, $54, $52
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$15  x block $55  y block $54
    dw   $0ab0, $0a80
    db   $59, $54, $55, $53
    db   $00, $04, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$16  x block $3b  y block $55
    dw   $0770, $0aa0
    db   $3e, $3a, $57, $54
    db   $00, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BOWLING_BALL           ; #$17  x block $0f  y block $58
    dw   $01e0, $0b10
    db   $13, $0b, $65, $55
    db   $86, $10, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BOWLING_BALL           ; #$18  x block $10  y block $5c
    dw   $0210, $0b90
    db   $13, $0b, $65, $55
    db   $84, $10, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$19  x block $2b  y block $55
    dw   $0570, $0aac
    db   $2c, $2a, $56, $54
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$1a  x block $3d  y block $56
    dw   $07b0, $0ac0
    db   $3e, $3a, $57, $54
    db   $00, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$1b  x block $59  y block $56
    dw   $0b30, $0ac0
    db   $5a, $55, $57, $55
    db   $a0, $05, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$1c  x block $22  y block $57
    dw   $0450, $0ae0
    db   $28, $1c, $58, $56
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$1d  x block $32  y block $57
    dw   $0650, $0ae0
    db   $34, $2d, $58, $56
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$1e  x block $4d  y block $57
    dw   $09b0, $0ae0
    db   $52, $4c, $58, $56
    db   $01, $03, $b4
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$1f  x block $4f  y block $57
    dw   $09f0, $0ae0
    db   $52, $4c, $58, $56
    db   $01, $03, $5a
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$20  x block $51  y block $57
    dw   $0a30, $0ae0
    db   $52, $4c, $58, $56
    db   $01, $03, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$21  x block $20  y block $5a
    dw   $0410, $0b50
    db   $22, $1f, $5b, $56
    db   $5a, $00, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$22  x block $21  y block $5a
    dw   $0420, $0b50
    db   $22, $1f, $5b, $57
    db   $5a, $01, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$23  x block $21  y block $5a
    dw   $0430, $0b50
    db   $22, $1f, $5b, $58
    db   $5a, $02, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$24  x block $4f  y block $5a
    dw   $09f0, $0b50
    db   $53, $4b, $5b, $59
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$25  x block $57  y block $5a
    dw   $0af0, $0b50
    db   $5a, $54, $5b, $59
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$26  x block $77  y block $61
    dw   $0ef0, $0c30
    db   $78, $76, $62, $60
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_ROCKET                 ; #$27  x block $6c  y block $63
    dw   $0d80, $0c60
    db   $6d, $6b, $64, $62
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_VANISHING_BLOCK        ; #$28  x block $74  y block $63
    dw   $0e90, $0c60
    db   $75, $73, $64, $62
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$29  x block $1b  y block $65
    dw   $0370, $0cb0
    db   $20, $1a, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD  ; #$2a  x block $28  y block $65
    dw   $0510, $0ca0
    db   $2e, $23, $66, $64
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BLOCK           ; #$2b  x block $37  y block $65
    dw   $06f0, $0ca0
    db   $38, $33, $66, $64
    db   $a8, $07, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$2c  x block $5f  y block $67
    dw   $0bf0, $0cf0
    db   $61, $5b, $68, $66
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$2d  x block $08  y block $69
    dw   $010c, $0d30
    db   $09, $07, $6a, $68
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$2e  x block $0e  y block $69
    dw   $01cc, $0d30
    db   $0f, $0d, $6a, $68
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_FLOWER                 ; #$2f  x block $13  y block $69
    dw   $026c, $0d30
    db   $14, $12, $6a, $68
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_DOMINO                 ; #$30  x block $24  y block $69
    dw   $0490, $0d30
    db   $2e, $23, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_DOMINO                 ; #$31  x block $25  y block $6a
    dw   $04a8, $0d50
    db   $2e, $23, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_DOMINO                 ; #$32  x block $2c  y block $6a
    dw   $0598, $0d50
    db   $2e, $23, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_DOMINO                 ; #$33  x block $2d  y block $69
    dw   $05b0, $0d30
    db   $2e, $23, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$34  x block $36  y block $6a
    dw   $06d0, $0d50
    db   $39, $33, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_DOMINO                 ; #$35  x block $42  y block $69
    dw   $0850, $0d30
    db   $44, $41, $6b, $67
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_DOMINO                 ; #$36  x block $43  y block $6a
    dw   $0868, $0d50
    db   $44, $41, $6b, $67
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$37  x block $51  y block $6a
    dw   $0a30, $0d58
    db   $53, $4f, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$38  x block $55  y block $6a
    dw   $0ab0, $0d58
    db   $58, $53, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$39  x block $5a  y block $6a
    dw   $0b50, $0d58
    db   $5d, $58, $6b, $69
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$3a  x block $51  y block $72
    dw   $0a30, $0e50
    db   $52, $4d, $73, $71
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$3b  x block $53  y block $71
    dw   $0a70, $0e30
    db   $58, $52, $72, $70
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_BEAR_TRAP   ; #$3c  x block $44  y block $76
    dw   $0880, $0ed8
    db   $45, $43, $77, $75
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$3d  x block $51  y block $77
    dw   $0a30, $0ef0
    db   $53, $4e, $78, $76
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_BEAR_TRAP   ; #$3e  x block $3e  y block $78
    dw   $07d0, $0f10
    db   $3f, $3d, $79, $77
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_BEAR_TRAP   ; #$3f  x block $42  y block $78
    dw   $0850, $0f10
    db   $43, $41, $79, $77
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_STATIONARY_BEAR_TRAP   ; #$40  x block $46  y block $78
    dw   $08d0, $0f10
    db   $47, $45, $79, $77
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$41  x block $56  y block $79
    dw   $0ad0, $0f20
    db   $57, $55, $7a, $76
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$42  x block $5e  y block $79
    dw   $0bd0, $0f30
    db   $60, $5c, $7a, $78
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_LOG             ; #$43  x block $57  y block $7a
    dw   $0af0, $0f40
    db   $5d, $56, $7b, $79
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$44  x block $61  y block $7a
    dw   $0c30, $0f50
    db   $64, $5f, $7b, $79
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_BUMBLEBEE              ; #$45  x block $6f  y block $7a
    dw   $0df0, $0f50
    db   $71, $6c, $7b, $79
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$46  x block $54  y block $7d
    dw   $0a90, $0fb0
    db   $56, $50, $7e, $7c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_MOVING_BEAR_TRAP       ; #$47  x block $5c  y block $7d
    dw   $0b90, $0fb0
    db   $5f, $59, $7e, $7c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$48  x block $74  y block $7d
    dw   $0e90, $0fb8
    db   $77, $72, $7e, $7c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TOON_TV_SHARK                  ; #$49  x block $79  y block $7d
    dw   $0f30, $0fb8
    db   $7e, $77, $7e, $7c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
