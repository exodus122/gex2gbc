; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/entity_list_frankensteinfeld.bin
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
; 50 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $1e  y block $3a
    dw   $03c0, $0758
    db   $1f, $1d, $3b, $39
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $1e  y block $39
    dw   $03c0, $0720
    db   $1f, $1d, $3a, $38
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $1a  y block $3d
    dw   $0340, $07b8
    db   $1b, $19, $3e, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $1a  y block $3c
    dw   $0340, $0780
    db   $1b, $19, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$04  x block $22  y block $3d
    dw   $0440, $07b8
    db   $23, $21, $3e, $3c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$05  x block $22  y block $3c
    dw   $0440, $0780
    db   $23, $21, $3d, $3b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$06  x block $34  y block $31
    dw   $0690, $0620
    db   $35, $33, $32, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$07  x block $3d  y block $31
    dw   $07b0, $0620
    db   $3e, $3c, $34, $30
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$08  x block $41  y block $31
    dw   $0830, $0620
    db   $42, $40, $34, $30
    db   $28, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ZOMBIE               ; #$09  x block $71  y block $31
    dw   $0e30, $0630
    db   $74, $6f, $32, $30
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$0a  x block $33  y block $33
    dw   $0670, $0670
    db   $34, $32, $34, $32
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$0b  x block $66  y block $32
    dw   $0cde, $0654
    db   $6a, $66, $34, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$0c  x block $68  y block $32
    dw   $0d1e, $0654
    db   $6a, $66, $34, $31
    db   $3c, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$0d  x block $45  y block $33
    dw   $08b0, $0670
    db   $46, $44, $34, $31
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$0e  x block $04  y block $3a
    dw   $0090, $0740
    db   $06, $03, $3b, $39
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$0f  x block $05  y block $3c
    dw   $00b0, $0780
    db   $06, $03, $3d, $3b
    db   $a0, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$10  x block $24  y block $3d
    dw   $0490, $07b0
    db   $25, $23, $3f, $3b
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM  ; #$11  x block $04  y block $3e
    dw   $0090, $07c0
    db   $06, $03, $3f, $3d
    db   $00, $08, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$12  x block $27  y block $3e
    dw   $04f0, $07d0
    db   $28, $26, $40, $3c
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$13  x block $6f  y block $41
    dw   $0df0, $0830
    db   $70, $6e, $44, $3e
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$14  x block $75  y block $43
    dw   $0eb0, $0870
    db   $78, $72, $44, $42
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$15  x block $62  y block $45
    dw   $0c50, $08b0
    db   $63, $61, $47, $43
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$16  x block $68  y block $45
    dw   $0d10, $08b0
    db   $69, $67, $48, $42
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$17  x block $71  y block $46
    dw   $0e30, $08d0
    db   $76, $6e, $47, $45
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$18  x block $6c  y block $48
    dw   $0d90, $0910
    db   $6e, $6a, $49, $47
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$19  x block $60  y block $4a
    dw   $0c10, $0950
    db   $61, $5f, $4f, $47
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$1a  x block $68  y block $4a
    dw   $0d10, $0950
    db   $6c, $65, $4b, $49
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$1b  x block $70  y block $4b
    dw   $0e10, $0970
    db   $74, $6c, $4c, $4a
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$1c  x block $66  y block $4d
    dw   $0cd0, $09b0
    db   $68, $64, $4e, $4c
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$1d  x block $3f  y block $52
    dw   $07f0, $0a40
    db   $40, $3e, $56, $51
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FRANKIE              ; #$1e  x block $45  y block $52
    dw   $08b0, $0a50
    db   $4a, $42, $53, $51
    db   $03, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_BAT                  ; #$1f  x block $55  y block $52
    dw   $0ab0, $0a50
    db   $57, $53, $53, $51
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$20  x block $2b  y block $53
    dw   $0578, $0a70
    db   $2d, $2b, $54, $52
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$21  x block $3d  y block $53
    dw   $07b0, $0a60
    db   $3e, $3c, $57, $52
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$22  x block $55  y block $53
    dw   $0ab0, $0a60
    db   $56, $54, $54, $52
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$23  x block $35  y block $54
    dw   $06b0, $0a80
    db   $36, $34, $55, $53
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_PLATFORM     ; #$24  x block $3b  y block $54
    dw   $0770, $0a80
    db   $3c, $3a, $58, $53
    db   $38, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$25  x block $69  y block $54
    dw   $0d30, $0a90
    db   $6d, $62, $55, $53
    db   $00, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$26  x block $0b  y block $56
    dw   $017e, $0ad4
    db   $0f, $0b, $58, $55
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$27  x block $0d  y block $56
    dw   $01be, $0ad4
    db   $0f, $0b, $58, $55
    db   $1e, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$28  x block $11  y block $56
    dw   $023e, $0ad4
    db   $14, $0f, $58, $55
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$29  x block $15  y block $56
    dw   $02be, $0ad4
    db   $17, $15, $58, $55
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$2a  x block $17  y block $56
    dw   $02fe, $0ad4
    db   $19, $17, $58, $55
    db   $3c, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_PUMPKIN              ; #$2b  x block $22  y block $57
    dw   $0450, $0af0
    db   $23, $21, $58, $55
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY ; #$2c  x block $5a  y block $57
    dw   $0b50, $0af0
    db   $5b, $59, $5b, $55
    db   $02, $20, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$2d  x block $33  y block $58
    dw   $067e, $0b14
    db   $35, $33, $5a, $57
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_HEAD_GHOST           ; #$2e  x block $41  y block $5a
    dw   $0828, $0b50
    db   $42, $40, $5b, $59
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$2f  x block $4d  y block $5b
    dw   $09b0, $0b60
    db   $4e, $4c, $5c, $5a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FRANKIE              ; #$30  x block $33  y block $5f
    dw   $0670, $0bf0
    db   $35, $30, $60, $5e
    db   $03, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$31  x block $2e  y block $60
    dw   $05d0, $0c00
    db   $2f, $2d, $61, $5f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
