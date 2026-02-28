call_0b_4000:
    xor  A, A                                          ;; 0b:4000 $af
    ld   L, A                                          ;; 0b:4001 $6f
.jr_0b_4002:
    ld   H, $c4                                        ;; 0b:4002 $26 $c4
    ld   [HL], $ff                                     ;; 0b:4004 $36 $ff
    inc  H                                             ;; 0b:4006 $24
    ld   [HL], A                                       ;; 0b:4007 $77
    inc  H                                             ;; 0b:4008 $24
    ld   [HL], A                                       ;; 0b:4009 $77
    inc  H                                             ;; 0b:400a $24
    ld   [HL], A                                       ;; 0b:400b $77
    inc  L                                             ;; 0b:400c $2c
    jr   NZ, .jr_0b_4002                                ;; 0b:400d $20 $f3
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:400f $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:4012 $6e
    ld   H, $00                                        ;; 0b:4013 $26 $00
    add  HL, HL                                        ;; 0b:4015 $29
    ld   DE, .data_0b_4062                             ;; 0b:4016 $11 $62 $40
    add  HL, DE                                        ;; 0b:4019 $19
    ld   A, [HL+]                                      ;; 0b:401a $2a
    ld   H, [HL]                                       ;; 0b:401b $66
    ld   L, A                                          ;; 0b:401c $6f
    ld   DE, wC400_CollectibleCoordinates                                     ;; 0b:401d $11 $00 $c4
.jr_0b_4020:
    ld   A, [HL+]                                      ;; 0b:4020 $2a
    ld   [DE], A                                       ;; 0b:4021 $12
    inc  D                                             ;; 0b:4022 $14
    ld   A, [HL+]                                      ;; 0b:4023 $2a
    ld   [DE], A                                       ;; 0b:4024 $12
    dec  D                                             ;; 0b:4025 $15
    inc  E                                             ;; 0b:4026 $1c
    and  A, A                                          ;; 0b:4027 $a7
    jr   NZ, .jr_0b_4020                               ;; 0b:4028 $20 $f6
    ld   DE, wC600_CollectibleRelated                                     ;; 0b:402a $11 $00 $c6
.jr_0b_402d:
    ld   HL, wC400_CollectibleCoordinates                                     ;; 0b:402d $21 $00 $c4
.jr_0b_4030:
    ld   A, [HL+]                                      ;; 0b:4030 $2a
    cp   A, $ff                                        ;; 0b:4031 $fe $ff
    jr   Z, .jr_0b_4038                                ;; 0b:4033 $28 $03
    cp   A, E                                          ;; 0b:4035 $bb
    jr   C, .jr_0b_4030                                ;; 0b:4036 $38 $f8
.jr_0b_4038:
    ld   A, L                                          ;; 0b:4038 $7d
    dec  A                                             ;; 0b:4039 $3d
    ld   [DE], A                                       ;; 0b:403a $12
    inc  E                                             ;; 0b:403b $1c
    jr   NZ, .jr_0b_402d                               ;; 0b:403c $20 $ef
    ld   E, $00                                        ;; 0b:403e $1e $00
.jr_0b_4040:
    ld   D, $c6                                        ;; 0b:4040 $16 $c6
    ld   A, [DE]                                       ;; 0b:4042 $1a
    ld   L, A                                          ;; 0b:4043 $6f
    ld   H, $c4                                        ;; 0b:4044 $26 $c4
    ld   B, $00                                        ;; 0b:4046 $06 $00
    ld   C, $ff                                        ;; 0b:4048 $0e $ff
    ld   A, E                                          ;; 0b:404a $7b
    add  A, $0b                                        ;; 0b:404b $c6 $0b
    jr   C, .jr_0b_4050                                ;; 0b:404d $38 $01
    ld   C, A                                          ;; 0b:404f $4f
.jr_0b_4050:
    inc  B                                             ;; 0b:4050 $04
    ld   A, [HL+]                                      ;; 0b:4051 $2a
    cp   A, $ff                                        ;; 0b:4052 $fe $ff
    jr   Z, .jr_0b_4059                                ;; 0b:4054 $28 $03
    cp   A, C                                          ;; 0b:4056 $b9
    jr   C, .jr_0b_4050                                ;; 0b:4057 $38 $f7
.jr_0b_4059:
    ld   D, $c7                                        ;; 0b:4059 $16 $c7
    ld   A, B                                          ;; 0b:405b $78
    dec  A                                             ;; 0b:405c $3d
    ld   [DE], A                                       ;; 0b:405d $12
    inc  E                                             ;; 0b:405e $1c
    jr   NZ, .jr_0b_4040                               ;; 0b:405f $20 $df
    ret                                                ;; 0b:4061 $c9
.data_0b_4062:
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a4_out_of_toon_collectible_coords
    dw   .data_41b8_smellraiser_collectible_coords
    dw   .data_4254_frankensteinfeld_collectible_coords
    dw   .data_430a_wwwdotcomcom_collectible_coords
    dw   .data_4400_mao_tse_tongue_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_44d0_pangaea_90210_collectible_coords
    dw   .data_45b4_fine_tooning_collectible_coords
    dw   .data_467a_this_old_cave_collectible_coords
    dw   .data_4778_honey_i_shrunk_the_gecko_collectible_coords
    dw   .data_48fe_poltergex_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_497a_samurai_night_fever_collectible_coords
    dw   .data_4a66_no_weddings_and_a_funeral_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_4b0e_thursday_the_12th_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_4b0e_lizard_in_a_china_shop_collectible_coords
    dw   .data_4bb4_bugged_out_collectible_coords
    dw   .data_4bb6_chips_and_dips_collectible_coords
    dw   .data_4c2c_lava_dabba_doo_collectible_coords
    dw   .data_4d3a_texas_chainsaw_manicure_collectible_coords
    dw   .data_4dee_mazed_and_confused_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
    dw   .data_40a0_media_dimension_collectible_coords
.data_40a0_media_dimension_collectible_coords:
    INCBIN "data/maps/media_dimension/collectible_list_media_dimension.bin"
.data_40a4_out_of_toon_collectible_coords:
    INCBIN "data/maps/toon_tv/collectible_list_out_of_toon.bin"
.data_41b8_smellraiser_collectible_coords:
    INCBIN "data/maps/scream_tv/collectible_list_smellraiser.bin"
.data_4254_frankensteinfeld_collectible_coords:
    INCBIN "data/maps/scream_tv/collectible_list_frankensteinfeld.bin"
.data_430a_wwwdotcomcom_collectible_coords:
    INCBIN "data/maps/circuit_central/collectible_list_wwwdotcomcom.bin"
.data_4400_mao_tse_tongue_collectible_coords:
    INCBIN "data/maps/kung_fu_theater/collectible_list_mao_tse_tongue.bin"
.data_44d0_pangaea_90210_collectible_coords:
    INCBIN "data/maps/prehistory_channel/collectible_list_pangaea_90210.bin"
.data_45b4_fine_tooning_collectible_coords:
    INCBIN "data/maps/toon_tv/collectible_list_fine_tooning.bin"
.data_467a_this_old_cave_collectible_coords:
    INCBIN "data/maps/prehistory_channel/collectible_list_this_old_cave.bin"
.data_4778_honey_i_shrunk_the_gecko_collectible_coords:
    INCBIN "data/maps/circuit_central/collectible_list_honey_i_shrunk_the_gecko.bin"
.data_48fe_poltergex_collectible_coords:
    INCBIN "data/maps/scream_tv/collectible_list_poltergex.bin"
.data_497a_samurai_night_fever_collectible_coords:
    INCBIN "data/maps/kung_fu_theater/collectible_list_samurai_night_fever.bin"
.data_4a66_no_weddings_and_a_funeral_collectible_coords:
    INCBIN "data/maps/rezopolis/collectible_list_no_weddings_and_a_funeral.bin"
.data_4b0e_thursday_the_12th_collectible_coords:
    INCBIN "data/maps/scream_tv/collectible_list_thursday_the_12th.bin"
.data_4b0e_lizard_in_a_china_shop_collectible_coords:
    INCBIN "data/maps/kung_fu_theater/collectible_list_lizard_in_a_china_shop.bin"
.data_4bb4_bugged_out_collectible_coords:
    INCBIN "data/maps/rezopolis/collectible_list_bugged_out.bin"
.data_4bb6_chips_and_dips_collectible_coords:
    INCBIN "data/maps/circuit_central/collectible_list_chips_and_dips.bin"
.data_4c2c_lava_dabba_doo_collectible_coords:
    INCBIN "data/maps/prehistory_channel/collectible_list_lava_dabba_doo.bin"
.data_4d3a_texas_chainsaw_manicure_collectible_coords:
    INCBIN "data/maps/scream_tv/collectible_list_texas_chainsaw_manicure.bin"
.data_4dee_mazed_and_confused_collectible_coords:
    INCBIN "data/maps/rezopolis/collectible_list_mazed_and_confused.bin"
