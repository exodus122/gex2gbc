; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/entity_list_poltergex.bin
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
; 54 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $3b  y block $1b
    dw   $0760, $0378
    db   $3c, $3a, $1c, $1a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $3b  y block $1a
    dw   $0760, $0340
    db   $3c, $3a, $1b, $19
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $5e  y block $55
    dw   $0bc0, $0ab8
    db   $5f, $5d, $56, $54
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $5e  y block $54
    dw   $0bc0, $0a80
    db   $5f, $5d, $55, $53
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $3a  y block $56
    dw   $0740, $0ad8
    db   $3b, $39, $57, $55
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $3a  y block $55
    dw   $0740, $0aa0
    db   $3b, $39, $56, $54
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$06  x block $45  y block $23
    dw   $08a8, $0470
    db   $46, $44, $24, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$07  x block $3f  y block $27
    dw   $07f8, $04f0
    db   $41, $3f, $28, $26
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$08  x block $52  y block $2a
    dw   $0a50, $0540
    db   $53, $51, $2e, $29
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$09  x block $54  y block $2a
    dw   $0a90, $0540
    db   $55, $53, $2e, $29
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$0a  x block $3e  y block $2c
    dw   $07c8, $0590
    db   $3f, $3d, $2d, $2b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$0b  x block $0a  y block $2e
    dw   $015e, $05d4
    db   $0c, $0a, $30, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$0c  x block $42  y block $2e
    dw   $0848, $05d0
    db   $43, $41, $2f, $2d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$0d  x block $41  y block $32
    dw   $0838, $0650
    db   $43, $41, $33, $31
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FRANKIE              ; #$0e  x block $11  y block $39
    dw   $0230, $0730
    db   $14, $0e, $3a, $38
    db   $03, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$0f  x block $2f  y block $3a
    dw   $05f0, $0750
    db   $30, $2e, $3b, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_LANTERN              ; #$10  x block $1d  y block $3c
    dw   $03b0, $0798
    db   $22, $18, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$11  x block $3e  y block $3c
    dw   $07d0, $0790
    db   $3f, $3d, $3d, $3a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_LANTERN              ; #$12  x block $0e  y block $3d
    dw   $01d0, $07b8
    db   $13, $09, $3e, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$13  x block $41  y block $3d
    dw   $0830, $07a0
    db   $42, $40, $40, $3b
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$14  x block $4f  y block $3d
    dw   $09f0, $07a0
    db   $50, $4e, $41, $3c
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_GHOST                ; #$15  x block $1d  y block $3e
    dw   $03b0, $07d0
    db   $22, $18, $3f, $3d
    db   $20, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$16  x block $36  y block $3e
    dw   $06de, $07d4
    db   $3d, $36, $40, $3d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$17  x block $3b  y block $3e
    dw   $077e, $07d4
    db   $3d, $36, $40, $3d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$18  x block $4b  y block $3e
    dw   $0970, $07c0
    db   $4c, $4a, $43, $3d
    db   $48, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$19  x block $53  y block $3e
    dw   $0a70, $07c0
    db   $54, $52, $42, $3d
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_GHOST                ; #$1a  x block $0d  y block $3f
    dw   $01b0, $07f0
    db   $13, $09, $40, $3e
    db   $20, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$1b  x block $06  y block $4a
    dw   $00d0, $0940
    db   $07, $05, $4d, $49
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$1c  x block $51  y block $4a
    dw   $0a30, $0940
    db   $52, $50, $4d, $47
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$1d  x block $26  y block $4b
    dw   $04de, $0974
    db   $2a, $26, $4d, $4a
    db   $1e, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$1e  x block $28  y block $4b
    dw   $051e, $0974
    db   $2a, $26, $4d, $4a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$1f  x block $38  y block $4b
    dw   $071e, $0974
    db   $3b, $38, $4d, $4a
    db   $0f, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$20  x block $39  y block $4b
    dw   $073e, $0974
    db   $3b, $38, $4d, $4a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$21  x block $1b  y block $4c
    dw   $037e, $0994
    db   $1f, $1b, $4e, $4b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$22  x block $1d  y block $4c
    dw   $03be, $0994
    db   $1f, $1b, $4e, $4b
    db   $1e, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$23  x block $0a  y block $54
    dw   $0150, $0a80
    db   $0b, $09, $59, $53
    db   $48, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$24  x block $23  y block $54
    dw   $0470, $0a80
    db   $24, $22, $58, $53
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$25  x block $3a  y block $54
    dw   $0750, $0a80
    db   $3d, $37, $55, $53
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$26  x block $08  y block $55
    dw   $0110, $0aa0
    db   $09, $07, $59, $54
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$27  x block $1b  y block $55
    dw   $0370, $0aa0
    db   $1c, $1a, $58, $54
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$28  x block $27  y block $55
    dw   $04f0, $0aa0
    db   $28, $26, $58, $54
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUSH_BLOCK           ; #$29  x block $15  y block $57
    dw   $02b0, $0af0
    db   $16, $14, $58, $56
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$2a  x block $4a  y block $57
    dw   $0950, $0ae0
    db   $4b, $48, $58, $56
    db   $a0, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$2b  x block $25  y block $58
    dw   $04b0, $0b00
    db   $2a, $17, $59, $57
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$2c  x block $2c  y block $58
    dw   $0590, $0b00
    db   $2d, $2b, $5a, $57
    db   $52, $00, $10
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$2d  x block $2b  y block $59
    dw   $0570, $0b30
    db   $2c, $2a, $5a, $58
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$2e  x block $4d  y block $59
    dw   $09b0, $0b20
    db   $4f, $4c, $5a, $58
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$2f  x block $49  y block $5b
    dw   $0930, $0b60
    db   $4b, $48, $5c, $5a
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$30  x block $4a  y block $5d
    dw   $0950, $0ba0
    db   $4b, $48, $5e, $5c
    db   $a0, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$31  x block $49  y block $5f
    dw   $0930, $0be0
    db   $4b, $48, $60, $5e
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$32  x block $4d  y block $62
    dw   $09b0, $0c40
    db   $4f, $4c, $63, $61
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$33  x block $49  y block $67
    dw   $0930, $0ce0
    db   $4a, $47, $6a, $66
    db   $a0, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$34  x block $48  y block $68
    dw   $0910, $0d00
    db   $4a, $47, $6a, $66
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$35  x block $49  y block $69
    dw   $0930, $0d20
    db   $4a, $47, $6a, $66
    db   $a0, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
