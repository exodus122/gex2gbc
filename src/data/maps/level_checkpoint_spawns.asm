; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/level_checkpoint_spawns.bin
; by tools/render_map_asm.py, per the level_checkpoint_spawns layout in tools/map_formats.json.
;
; The .bin is the editable source of truth for the bytes; this file is a
; generated view of it that happens to be what gets assembled. To change the
; data, edit the .bin (a map editor writes it). To change what a field MEANS,
; edit the schema. Either way, `make maps-docs` refreshes this file; hand edits
; are overwritten on the next build.
;
; CHECKPOINTS_PER_LEVEL block coordinate pairs per level, indexed by
; levelId * 8 + wD618_CheckpointSpawnId * 2. Checkpoint 0 is where the level
; starts; the rest are set by call_00_208c_Checkpoint_WriteSpawnId when the player
; smashes a checkpoint TV block.
;
; Only 20 of the 31 levels define a start at all, only 7 of those define a
; checkpoint 1, and NO level uses checkpoint 2 or 3 - so the whole upper half of
; every record is dead weight, and 194 of the 248 bytes here are zero.
;
; Record layout - 8 bytes:
;   +0   db  cp0_x, cp0_y, cp1_x, cp1_y, cp2_x, cp2_y, cp3_x, cp3_y   - checkpoints 0-3, each a block x, block y pair
;
; 31 records.
; ==================================================================

    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$00  MAP_MEDIA_DIMENSION  no spawn defined
    db   $2f, $0b, $26, $3a, $00, $00, $00, $00  ; #$01  MAP_TOON_TV_OUT_OF_TOON
    db   $03, $0a, $4b, $0a, $00, $00, $00, $00  ; #$02  MAP_SCREAM_TV_SMELLRAISER
    db   $0b, $31, $00, $00, $00, $00, $00, $00  ; #$03  MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $1a, $15, $00, $00, $00, $00, $00, $00  ; #$04  MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $0f, $1d, $10, $15, $00, $00, $00, $00  ; #$05  MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$06  MAP_UNUSED_06  no spawn defined
    db   $04, $13, $00, $00, $00, $00, $00, $00  ; #$07  MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $04, $6a, $37, $56, $00, $00, $00, $00  ; #$08  MAP_TOON_TV_FINE_TOONING
    db   $04, $73, $3f, $70, $00, $00, $00, $00  ; #$09  MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $0d, $34, $4d, $34, $00, $00, $00, $00  ; #$0a  MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   $15, $31, $00, $00, $00, $00, $00, $00  ; #$0b  MAP_SCREAM_TV_POLTERGEX
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$0c  MAP_UNUSED_0C  no spawn defined
    db   $1e, $0c, $00, $00, $00, $00, $00, $00  ; #$0d  MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $04, $05, $00, $00, $00, $00, $00, $00  ; #$0e  MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$0f  MAP_UNUSED_0F  no spawn defined
    db   $6d, $55, $00, $00, $00, $00, $00, $00  ; #$10  MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$11  MAP_UNUSED_11  no spawn defined
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$12  MAP_UNUSED_12  no spawn defined
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$13  MAP_UNUSED_13  no spawn defined
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$14  MAP_UNUSED_14  no spawn defined
    db   $50, $66, $00, $00, $00, $00, $00, $00  ; #$15  MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $1c, $75, $00, $00, $00, $00, $00, $00  ; #$16  MAP_REZOPOLIS_BUGGED_OUT
    db   $05, $46, $00, $00, $00, $00, $00, $00  ; #$17  MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $07, $14, $0e, $34, $00, $00, $00, $00  ; #$18  MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   $05, $0c, $00, $00, $00, $00, $00, $00  ; #$19  MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $7b, $1a, $00, $00, $00, $00, $00, $00  ; #$1a  MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$1b  MAP_UNUSED_1B  no spawn defined
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$1c  MAP_UNUSED_1C  no spawn defined
    db   $00, $00, $00, $00, $00, $00, $00, $00  ; #$1d  MAP_UNUSED_1D  no spawn defined
    db   $06, $7c, $00, $00, $00, $00, $00, $00  ; #$1e  MAP_BOSS_TV_CHANNEL_Z
