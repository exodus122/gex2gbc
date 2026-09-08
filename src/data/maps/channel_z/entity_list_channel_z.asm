; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/channel_z/entity_list_channel_z.bin
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
; 14 records.
; ==================================================================

    db   ENTITY_CHANNEL_Z_REZ                  ; #$00  x block $04  y block $7c
    dw   $0090, $0f90
    db   $63, $02, $7e, $78
    db   $21, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE   ; #$01  x block $04  y block $7d
    dw   $0088, $0fa8
    db   $63, $02, $7e, $78
    db   $00, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE       ; #$02  x block $10  y block $79
    dw   $020c, $0f30
    db   $11, $0f, $7c, $78
    db   $1f, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE       ; #$03  x block $24  y block $79
    dw   $048c, $0f30
    db   $25, $23, $7d, $78
    db   $1f, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE       ; #$04  x block $34  y block $79
    dw   $068c, $0f30
    db   $35, $33, $7f, $78
    db   $1f, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE       ; #$05  x block $36  y block $79
    dw   $06cc, $0f30
    db   $37, $35, $7f, $78
    db   $1f, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE       ; #$06  x block $0a  y block $7d
    dw   $014c, $0fb0
    db   $0b, $09, $7e, $75
    db   $1f, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_GUN_PROJECTILE       ; #$07  x block $2e  y block $7d
    dw   $05cc, $0fb0
    db   $2f, $2d, $7e, $77
    db   $1f, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE ; #$08  x block $28  y block $7d
    dw   $050c, $0fb0
    db   $2d, $23, $7e, $7c
    db   $1f, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2  ; #$09  x block $46  y block $7d
    dw   $08cc, $0fb0
    db   $47, $45, $7e, $7c
    db   $1f, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2  ; #$0a  x block $4d  y block $7d
    dw   $09ac, $0fb0
    db   $4e, $4c, $7e, $7c
    db   $1f, $01, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_REZ                  ; #$0b  x block $75  y block $7d
    dw   $0eb4, $0fa0
    db   $7a, $70, $7e, $78
    db   $21, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON  ; #$0c  x block $73  y block $79
    dw   $0e68, $0f38
    db   $7a, $70, $7d, $78
    db   $01, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON  ; #$0d  x block $78  y block $79
    dw   $0f00, $0f38
    db   $7a, $70, $7d, $78
    db   $02, $00, $00
    db   $00, $00, $00, $00

    db   ENTITY_LIST_TERMINATOR
