; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/prehistory_channel/entity_list_pangaea_90210.bin
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

    db   ENTITY_TV_BUTTON                      ; #$00  x block $35  y block $3b
    dw   $06a0, $0778
    db   $36, $34, $3c, $3a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$01  x block $35  y block $3a
    dw   $06a0, $0740
    db   $36, $34, $3b, $39
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_TV_BUTTON                      ; #$02  x block $4a  y block $23
    dw   $0940, $0478
    db   $4b, $49, $24, $22
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_RED_REMOTE                     ; #$03  x block $4a  y block $22
    dw   $0940, $0440
    db   $4b, $49, $23, $21
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$04  x block $66  y block $02
    dw   $0cd0, $0050
    db   $6d, $65, $0b, $01
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$05  x block $69  y block $02
    dw   $0d30, $0050
    db   $6d, $65, $0b, $01
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_LAVA       ; #$06  x block $6c  y block $02
    dw   $0d90, $0050
    db   $6d, $65, $06, $01
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$07  x block $7b  y block $03
    dw   $0f70, $0070
    db   $7c, $79, $04, $02
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$08  x block $5b  y block $05
    dw   $0b70, $00b8
    db   $5c, $5a, $06, $04
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$09  x block $63  y block $0a
    dw   $0c70, $0150
    db   $65, $61, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$0a  x block $6a  y block $0a
    dw   $0d50, $0150
    db   $6c, $69, $0b, $09
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$0b  x block $18  y block $0b
    dw   $0310, $0170
    db   $1a, $15, $0c, $0a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$0c  x block $4e  y block $0e
    dw   $09d0, $01d0
    db   $4f, $4b, $0f, $0d
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$0d  x block $73  y block $0e
    dw   $0e70, $01c0
    db   $74, $72, $13, $0d
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$0e  x block $42  y block $0f
    dw   $0850, $01f0
    db   $43, $41, $10, $0e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_BOULDER    ; #$0f  x block $2d  y block $11
    dw   $05a0, $0230
    db   $31, $28, $12, $10
    db   $20, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$10  x block $46  y block $10
    dw   $08d0, $0204
    db   $4c, $44, $11, $0f
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$11  x block $1f  y block $11
    dw   $03f0, $0230
    db   $21, $1d, $12, $10
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$12  x block $3a  y block $11
    dw   $0750, $0238
    db   $3b, $39, $12, $10
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$13  x block $57  y block $11
    dw   $0af0, $0220
    db   $58, $56, $15, $10
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_EGG                ; #$14  x block $69  y block $12
    dw   $0d30, $0250
    db   $6b, $67, $13, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$15  x block $75  y block $12
    dw   $0eb0, $0240
    db   $76, $74, $13, $0d
    db   $52, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$16  x block $7b  y block $12
    dw   $0f70, $0258
    db   $7c, $7a, $13, $11
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_DRAGONFLY          ; #$17  x block $08  y block $13
    dw   $0110, $0270
    db   $09, $04, $14, $12
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$18  x block $0e  y block $13
    dw   $01d0, $0278
    db   $0f, $0d, $14, $12
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$19  x block $59  y block $14
    dw   $0b30, $0280
    db   $5a, $58, $15, $10
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$1a  x block $53  y block $2a
    dw   $0a70, $0550
    db   $55, $51, $2b, $29
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$1b  x block $5d  y block $2a
    dw   $0bb0, $0550
    db   $5f, $5b, $2b, $29
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$1c  x block $50  y block $2c
    dw   $0a10, $0584
    db   $63, $4e, $2d, $2b
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_TRICERATOPS        ; #$1d  x block $46  y block $2d
    dw   $08d0, $05b0
    db   $49, $44, $2e, $2c
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_BOULDER    ; #$1e  x block $06  y block $37
    dw   $00d0, $06f0
    db   $07, $05, $38, $36
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$1f  x block $3e  y block $2f
    dw   $07d0, $05f8
    db   $3f, $3d, $30, $2e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_BOULDER    ; #$20  x block $21  y block $36
    dw   $0430, $06d0
    db   $22, $20, $37, $35
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FALLING_BOULDER    ; #$21  x block $1e  y block $37
    dw   $03d0, $06f0
    db   $1f, $1d, $38, $36
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$22  x block $2d  y block $32
    dw   $05b0, $0640
    db   $2e, $2c, $35, $31
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$23  x block $2f  y block $34
    dw   $05f0, $0680
    db   $30, $2e, $35, $31
    db   $02, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FIRE_PLANT         ; #$24  x block $0e  y block $37
    dw   $01d0, $06f8
    db   $0f, $0d, $38, $36
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_SILVER_REMOTE                  ; #$25  x block $16  y block $3b
    dw   $02d0, $0770
    db   $17, $15, $3c, $3a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_TRICERATOPS        ; #$26  x block $58  y block $3b
    dw   $0b10, $0770
    db   $5c, $54, $3c, $3a
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$27  x block $14  y block $3c
    dw   $0290, $0784
    db   $1b, $0f, $3d, $3b
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_MOVING_PLATFORM    ; #$28  x block $4b  y block $3d
    dw   $0970, $07a0
    db   $4f, $49, $3e, $3c
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_PTEROSAUR          ; #$29  x block $25  y block $3f
    dw   $04b0, $07f0
    db   $27, $22, $40, $3e
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_DINOSAUR           ; #$2a  x block $3e  y block $40
    dw   $07d0, $0810
    db   $40, $3c, $41, $3f
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$2b  x block $23  y block $41
    dw   $0470, $0824
    db   $24, $20, $42, $40
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$2c  x block $27  y block $41
    dw   $04f0, $0824
    db   $2a, $26, $42, $40
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_LAVA_RAFT          ; #$2d  x block $34  y block $41
    dw   $0690, $0824
    db   $38, $30, $42, $40
    db   $a0, $ff, $10
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_DRAGONFLY          ; #$2e  x block $05  y block $43
    dw   $00b0, $0870
    db   $09, $03, $44, $42
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_PRE_HISTORY_FAST_DINOSAUR      ; #$2f  x block $14  y block $46
    dw   $0290, $08d0
    db   $17, $0f, $47, $45
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
