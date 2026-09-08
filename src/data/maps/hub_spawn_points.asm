; ==================================================================
; GENERATED FILE - do not edit by hand.
;
; Rendered from data/maps/hub_spawn_points.bin
; by tools/render_map_asm.py, per the hub_spawn_points layout in tools/map_formats.json.
;
; The .bin is the editable source of truth for the bytes; this file is a
; generated view of it that happens to be what gets assembled. To change the
; data, edit the .bin (a map editor writes it). To change what a field MEANS,
; edit the schema. Either way, `make maps-docs` refreshes this file; hand edits
; are overwritten on the next build.
;
; Where the player lands when they step back out of a TV into the Media Dimension,
; in blocks. Indexed by wD628_MediaDimensionRespawnPoint, which bank02 computes as
; (TV entity list index - 1) / 2 when a TV is entered - and that works out to a
; LEVEL ID. So each level effectively records where its own TV stands in the hub,
; and the player is put back in front of whichever TV they came out of.
;
; The empty entries are exactly the ten MAP_UNUSED_* slots, which is corroboration
; that the index really is a map id.
;
; Record layout - 2 bytes:
;   +0   db  x, y   - block x, block y
;
; 31 records.
; ==================================================================

    db   $25, $0d                              ; #$00  MAP_MEDIA_DIMENSION
    db   $05, $0b                              ; #$01  MAP_TOON_TV_OUT_OF_TOON
    db   $36, $0b                              ; #$02  MAP_SCREAM_TV_SMELLRAISER
    db   $11, $16                              ; #$03  MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $39, $16                              ; #$04  MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $25, $16                              ; #$05  MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $00, $00                              ; #$06  MAP_UNUSED_06  unused
    db   $1e, $23                              ; #$07  MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $32, $23                              ; #$08  MAP_TOON_TV_FINE_TOONING
    db   $24, $46                              ; #$09  MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $1a, $46                              ; #$0a  MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   $10, $46                              ; #$0b  MAP_SCREAM_TV_POLTERGEX
    db   $00, $00                              ; #$0c  MAP_UNUSED_0C  unused
    db   $11, $31                              ; #$0d  MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $3e, $31                              ; #$0e  MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $00, $00                              ; #$0f  MAP_UNUSED_0F  unused
    db   $1a, $0d                              ; #$10  MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $00, $00                              ; #$11  MAP_UNUSED_11  unused
    db   $00, $00                              ; #$12  MAP_UNUSED_12  unused
    db   $00, $00                              ; #$13  MAP_UNUSED_13  unused
    db   $00, $00                              ; #$14  MAP_UNUSED_14  unused
    db   $26, $1e                              ; #$15  MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $18, $4c                              ; #$16  MAP_REZOPOLIS_BUGGED_OUT
    db   $1c, $31                              ; #$17  MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $1a, $04                              ; #$18  MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   $11, $04                              ; #$19  MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $23, $04                              ; #$1a  MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $00, $00                              ; #$1b  MAP_UNUSED_1B  unused
    db   $00, $00                              ; #$1c  MAP_UNUSED_1C  unused
    db   $00, $00                              ; #$1d  MAP_UNUSED_1D  unused
    db   $48, $31                              ; #$1e  MAP_BOSS_TV_CHANNEL_Z
