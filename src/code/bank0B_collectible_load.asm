call_0b_4000_CollectibleList_LoadForCurrentLevel:
; Builds the four collectible tables for the current level. Three passes.
;
; 1. Clear. All 256 slots of all four tables: wC400_Collectible_GridX to $FF (the
;    list terminator, so an empty list is the default) and the other three to zero.
;
; 2. Load. wD624_CurrentLevelId indexes .data_0b_4062_MapCollectibleLists for this
;    level's list, which is interleaved (X, Y) pairs in 16x16-pixel grid cells,
;    ending at the first pair whose X is zero. The pairs are de-interleaved into
;    wC400_Collectible_GridX and wC500_Collectible_GridY. The lists are authored
;    sorted by ascending X, which is what makes pass 3 valid.
;
; 3. Index. Two lookup tables keyed by camera cell column, so the per-frame draw
;    never walks the list. For every column 0-255:
;      wC600_Collectible_ScanStartByColumn - walk wC400 until an X reaches the
;        column (or the terminator) and store that index: a lower bound
;      wC700_Collectible_ScanCountByColumn - from that index, count entries with X
;        below column + $0B, saturating at the terminator. $0B cells is 176 pixels,
;        one cell more than the screen is wide
;
; The cost is 256 list walks at level load in exchange for two array reads per frame
; in call_03_6499_Collectible_BuildSprites
    xor  A, A
    ld   L, A
.jr_0b_4002:
    ld   H, HIGH(wC400_Collectible_GridX)
    ld   [HL], $ff
    inc  H
    ld   [HL], A
    inc  H
    ld   [HL], A
    inc  H
    ld   [HL], A
    inc  L
    jr   NZ, .jr_0b_4002
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_0b_4062_MapCollectibleLists
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, wC400_Collectible_GridX
.jr_0b_4020:
    ld   A, [HL+]
    ld   [DE], A
    inc  D
    ld   A, [HL+]
    ld   [DE], A
    dec  D
    inc  E
    and  A, A
    jr   NZ, .jr_0b_4020
    ld   DE, wC600_Collectible_ScanStartByColumn
.jr_0b_402d:
    ld   HL, wC400_Collectible_GridX
.jr_0b_4030:
    ld   A, [HL+]
    cp   A, $ff
    jr   Z, .jr_0b_4038
    cp   A, E
    jr   C, .jr_0b_4030
.jr_0b_4038:
    ld   A, L
    dec  A
    ld   [DE], A
    inc  E
    jr   NZ, .jr_0b_402d
    ld   E, $00
.jr_0b_4040:
    ld   D, HIGH(wC600_Collectible_ScanStartByColumn)
    ld   A, [DE]
    ld   L, A
    ld   H, HIGH(wC400_Collectible_GridX)
    ld   B, $00
    ld   C, $ff
    ld   A, E
    add  A, $0b
    jr   C, .jr_0b_4050
    ld   C, A
.jr_0b_4050:
    inc  B
    ld   A, [HL+]
    cp   A, $ff
    jr   Z, .jr_0b_4059
    cp   A, C
    jr   C, .jr_0b_4050
.jr_0b_4059:
    ld   D, HIGH(wC700_Collectible_ScanCountByColumn)
    ld   A, B
    dec  A
    ld   [DE], A
    inc  E
    jr   NZ, .jr_0b_4040
    ret
.data_0b_4062_MapCollectibleLists:
; 31-entry pointer table mapping level IDs to per-level collectible coordinate lists.
; Media Dimension and hub levels share a stub entry. The 19 non-hub playable levels each have unique lists
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_MEDIA_DIMENSION
    dw   .data_40a4_out_of_toon_collectible_list                ; MAP_TOON_TV_OUT_OF_TOON
    dw   .data_41b8_smellraiser_collectible_list                ; MAP_SCREAM_TV_SMELLRAISER
    dw   .data_4254_frankensteinfeld_collectible_list           ; MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .data_430a_wwwdotcomcom_collectible_list               ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .data_4400_mao_tse_tongue_collectible_list             ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_06
    dw   .data_44d0_pangaea_90210_collectible_list              ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .data_45b4_fine_tooning_collectible_list               ; MAP_TOON_TV_FINE_TOONING
    dw   .data_467a_this_old_cave_collectible_list              ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .data_4778_honey_i_shrunk_the_gecko_collectible_list   ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .data_48fe_poltergex_collectible_list                  ; MAP_SCREAM_TV_POLTERGEX
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_0C
    dw   .data_497a_samurai_night_fever_collectible_list        ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .data_4a66_no_weddings_and_a_funeral_collectible_list  ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_0F
    dw   .data_4b0e_thursday_the_12th_collectible_list          ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_11
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_12
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_13
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_14
    dw   .data_4b0e_lizard_in_a_china_shop_collectible_list     ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .data_4bb4_bugged_out_collectible_list                 ; MAP_REZOPOLIS_BUGGED_OUT
    dw   .data_4bb6_chips_and_dips_collectible_list             ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .data_4c2c_lava_dabba_doo_collectible_list             ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .data_4d3a_texas_chainsaw_manicure_collectible_list    ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .data_4dee_mazed_and_confused_collectible_list         ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_1B
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_1C
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_UNUSED_1D
    dw   .data_40a0_media_dimension_collectible_list            ; MAP_BOSS_TV_CHANNEL_Z
.data_40a0_media_dimension_collectible_list:
    INCBIN "data/maps/media_dimension/collectible_list_media_dimension.bin"
.data_40a4_out_of_toon_collectible_list:
    INCBIN "data/maps/toon_tv/collectible_list_out_of_toon.bin"
.data_41b8_smellraiser_collectible_list:
    INCBIN "data/maps/scream_tv/collectible_list_smellraiser.bin"
.data_4254_frankensteinfeld_collectible_list:
    INCBIN "data/maps/scream_tv/collectible_list_frankensteinfeld.bin"
.data_430a_wwwdotcomcom_collectible_list:
    INCBIN "data/maps/circuit_central/collectible_list_wwwdotcomcom.bin"
.data_4400_mao_tse_tongue_collectible_list:
    INCBIN "data/maps/kung_fu_theater/collectible_list_mao_tse_tongue.bin"
.data_44d0_pangaea_90210_collectible_list:
    INCBIN "data/maps/prehistory_channel/collectible_list_pangaea_90210.bin"
.data_45b4_fine_tooning_collectible_list:
    INCBIN "data/maps/toon_tv/collectible_list_fine_tooning.bin"
.data_467a_this_old_cave_collectible_list:
    INCBIN "data/maps/prehistory_channel/collectible_list_this_old_cave.bin"
.data_4778_honey_i_shrunk_the_gecko_collectible_list:
    INCBIN "data/maps/circuit_central/collectible_list_honey_i_shrunk_the_gecko.bin"
.data_48fe_poltergex_collectible_list:
    INCBIN "data/maps/scream_tv/collectible_list_poltergex.bin"
.data_497a_samurai_night_fever_collectible_list:
    INCBIN "data/maps/kung_fu_theater/collectible_list_samurai_night_fever.bin"
.data_4a66_no_weddings_and_a_funeral_collectible_list:
    INCBIN "data/maps/rezopolis/collectible_list_no_weddings_and_a_funeral.bin"
.data_4b0e_thursday_the_12th_collectible_list:
    INCBIN "data/maps/scream_tv/collectible_list_thursday_the_12th.bin"
.data_4b0e_lizard_in_a_china_shop_collectible_list:
    INCBIN "data/maps/kung_fu_theater/collectible_list_lizard_in_a_china_shop.bin"
.data_4bb4_bugged_out_collectible_list:
    INCBIN "data/maps/rezopolis/collectible_list_bugged_out.bin"
.data_4bb6_chips_and_dips_collectible_list:
    INCBIN "data/maps/circuit_central/collectible_list_chips_and_dips.bin"
.data_4c2c_lava_dabba_doo_collectible_list:
    INCBIN "data/maps/prehistory_channel/collectible_list_lava_dabba_doo.bin"
.data_4d3a_texas_chainsaw_manicure_collectible_list:
    INCBIN "data/maps/scream_tv/collectible_list_texas_chainsaw_manicure.bin"
.data_4dee_mazed_and_confused_collectible_list:
    INCBIN "data/maps/rezopolis/collectible_list_mazed_and_confused.bin"
