; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/scream_tv/entity_list_texas_chainsaw_manicure.bin
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
; 32 records.
; ==================================================================

    db   ENTITY_TV_BUTTON                      ; #$00  x block $29  y block $15
    dw   $0520, $02b8
    db   $2a, $28, $16, $14
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $29  y block $14
    dw   $0520, $0280
    db   $2a, $28, $15, $13
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$02  x block $6e  y block $03
    dw   $0dd0, $0060
    db   $70, $61, $04, $02
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$03  x block $06  y block $04
    dw   $00d0, $0080
    db   $0d, $04, $05, $03
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$04  x block $19  y block $05
    dw   $0330, $00a0
    db   $24, $16, $06, $04
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$05  x block $6f  y block $04
    dw   $0dfe, $0094
    db   $71, $6f, $06, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$06  x block $71  y block $04
    dw   $0e3e, $0094
    db   $73, $71, $06, $03
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$07  x block $74  y block $04
    dw   $0e90, $0080
    db   $75, $73, $06, $02
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$08  x block $32  y block $05
    dw   $0650, $00a0
    db   $38, $2f, $06, $04
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$09  x block $3c  y block $05
    dw   $0790, $00a0
    db   $3d, $3b, $06, $04
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$0a  x block $0e  y block $06
    dw   $01d0, $00c0
    db   $0f, $0d, $09, $04
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$0b  x block $2f  y block $07
    dw   $05f0, $00e0
    db   $30, $2e, $09, $04
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$0c  x block $1a  y block $08
    dw   $035e, $0114
    db   $1c, $1a, $0a, $07
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$0d  x block $50  y block $08
    dw   $0a10, $0100
    db   $51, $4f, $09, $04
    db   $52, $00, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$0e  x block $6e  y block $08
    dw   $0dd0, $0100
    db   $6f, $6d, $0b, $05
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$0f  x block $08  y block $09
    dw   $0110, $0130
    db   $09, $04, $0a, $08
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$10  x block $3b  y block $09
    dw   $0770, $0120
    db   $3c, $3a, $0a, $08
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$11  x block $05  y block $0a
    dw   $00b0, $0150
    db   $09, $04, $0b, $09
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$12  x block $6c  y block $0a
    dw   $0d90, $0148
    db   $6e, $62, $0b, $09
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$13  x block $07  y block $0b
    dw   $00f0, $0170
    db   $09, $04, $0c, $0a
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$14  x block $21  y block $0c
    dw   $043e, $0194
    db   $23, $21, $0e, $0b
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_BAT                  ; #$15  x block $14  y block $14
    dw   $0290, $0290
    db   $18, $13, $15, $13
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$16  x block $08  y block $16
    dw   $0110, $02c0
    db   $0d, $03, $17, $15
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$17  x block $20  y block $17
    dw   $0410, $02e0
    db   $22, $1d, $18, $16
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_VANISHING_PLATFORM   ; #$18  x block $25  y block $17
    dw   $04b0, $02e0
    db   $26, $24, $18, $16
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$19  x block $04  y block $18
    dw   $009e, $0314
    db   $08, $04, $1a, $17
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_FALLING_AXE          ; #$1a  x block $06  y block $18
    dw   $00de, $0314
    db   $08, $04, $1a, $17
    db   $3c, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$1b  x block $1d  y block $18
    dw   $03b0, $0310
    db   $1e, $1c, $1a, $16
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_ZOMBIE               ; #$1c  x block $0c  y block $1a
    dw   $0190, $0350
    db   $0e, $0a, $1b, $19
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$1d  x block $29  y block $1b
    dw   $0530, $0368
    db   $2a, $28, $1d, $19
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$1e  x block $24  y block $1d
    dw   $0490, $03a0
    db   $28, $1e, $1e, $1c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_SCREAM_TV_MOVING_PLATFORM      ; #$1f  x block $26  y block $20
    dw   $04d0, $0400
    db   $27, $25, $22, $1d
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
