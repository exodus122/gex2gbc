;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "bank0b", ROMX[$4000], BANK[$0b]

; This file handles loading collectibles in maps (and where they are in each level),
; gex's spawns throughout the levels, and many palettes.

entry_0b_4000:
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
    INCBIN "./maps/media_dimension/collectible_list_media_dimension.bin"
.data_40a4_out_of_toon_collectible_coords:
    INCBIN "./maps/toon_tv/collectible_list_out_of_toon.bin"
.data_41b8_smellraiser_collectible_coords:
    INCBIN "./maps/scream_tv/collectible_list_smellraiser.bin"
.data_4254_frankensteinfeld_collectible_coords:
    INCBIN "./maps/scream_tv/collectible_list_frankensteinfeld.bin"
.data_430a_wwwdotcomcom_collectible_coords:
    INCBIN "./maps/circuit_central/collectible_list_wwwdotcomcom.bin"
.data_4400_mao_tse_tongue_collectible_coords:
    INCBIN "./maps/kung_fu_theater/collectible_list_mao_tse_tongue.bin"
.data_44d0_pangaea_90210_collectible_coords:
    INCBIN "./maps/prehistory_channel/collectible_list_pangaea_90210.bin"
.data_45b4_fine_tooning_collectible_coords:
    INCBIN "./maps/toon_tv/collectible_list_fine_tooning.bin"
.data_467a_this_old_cave_collectible_coords:
    INCBIN "./maps/prehistory_channel/collectible_list_this_old_cave.bin"
.data_4778_honey_i_shrunk_the_gecko_collectible_coords:
    INCBIN "./maps/circuit_central/collectible_list_honey_i_shrunk_the_gecko.bin"
.data_48fe_poltergex_collectible_coords:
    INCBIN "./maps/scream_tv/collectible_list_poltergex.bin"
.data_497a_samurai_night_fever_collectible_coords:
    INCBIN "./maps/kung_fu_theater/collectible_list_samurai_night_fever.bin"
.data_4a66_no_weddings_and_a_funeral_collectible_coords:
    INCBIN "./maps/rezopolis/collectible_list_no_weddings_and_a_funeral.bin"
.data_4b0e_thursday_the_12th_collectible_coords:
    INCBIN "./maps/scream_tv/collectible_list_thursday_the_12th.bin"
.data_4b0e_lizard_in_a_china_shop_collectible_coords:
    INCBIN "./maps/kung_fu_theater/collectible_list_lizard_in_a_china_shop.bin"
.data_4bb4_bugged_out_collectible_coords:
    INCBIN "./maps/rezopolis/collectible_list_bugged_out.bin"
.data_4bb6_chips_and_dips_collectible_coords:
    INCBIN "./maps/circuit_central/collectible_list_chips_and_dips.bin"
.data_4c2c_lava_dabba_doo_collectible_coords:
    INCBIN "./maps/prehistory_channel/collectible_list_lava_dabba_doo.bin"
.data_4d3a_texas_chainsaw_manicure_collectible_coords:
    INCBIN "./maps/scream_tv/collectible_list_texas_chainsaw_manicure.bin"
.data_4dee_mazed_and_confused_collectible_coords:
    INCBIN "./maps/rezopolis/collectible_list_mazed_and_confused.bin"

entry_0b_4efe_SpawnPositionInMap:
    ld   HL, wD621                                     ;; 0b:4efe $21 $21 $d6
    ld   A, [HL]                                       ;; 0b:4f01 $7e
    and  A, $08                                        ;; 0b:4f02 $e6 $08
    jr   Z, .jr_0b_4f70                                ;; 0b:4f04 $28 $6a
    ld   A, [HL]                                       ;; 0b:4f06 $7e
    and  A, $f7                                        ;; 0b:4f07 $e6 $f7
    ld   [HL], A                                       ;; 0b:4f09 $77
    ld   HL, wD20E                                     ;; 0b:4f0a $21 $0e $d2
    ld   A, [HL+]                                      ;; 0b:4f0d $2a
    ld   H, [HL]                                       ;; 0b:4f0e $66
    ld   L, A                                          ;; 0b:4f0f $6f
    ld   DE, hFFF1                                     ;; 0b:4f10 $11 $f1 $ff
    add  HL, DE                                        ;; 0b:4f13 $19
    add  HL, HL                                        ;; 0b:4f14 $29
    add  HL, HL                                        ;; 0b:4f15 $29
    add  HL, HL                                        ;; 0b:4f16 $29
    ld   C, H                                          ;; 0b:4f17 $4c
    ld   HL, wD210                                     ;; 0b:4f18 $21 $10 $d2
    ld   A, [HL+]                                      ;; 0b:4f1b $2a
    ld   H, [HL]                                       ;; 0b:4f1c $66
    ld   L, A                                          ;; 0b:4f1d $6f
    add  HL, HL                                        ;; 0b:4f1e $29
    add  HL, HL                                        ;; 0b:4f1f $29
    add  HL, HL                                        ;; 0b:4f20 $29
    ld   B, H                                          ;; 0b:4f21 $44
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:4f22 $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:4f25 $6e
    ld   H, $00                                        ;; 0b:4f26 $26 $00
    add  HL, HL                                        ;; 0b:4f28 $29
    ld   DE, .data_LevelDoorSpawns                             ;; 0b:4f29 $11 $f2 $4f
    add  HL, DE                                        ;; 0b:4f2c $19
    ld   A, [HL+]                                      ;; 0b:4f2d $2a
    ld   H, [HL]                                       ;; 0b:4f2e $66
    ld   L, A                                          ;; 0b:4f2f $6f
    ld   DE, $03                                       ;; 0b:4f30 $11 $03 $00
.jr_0b_4f33:
    ld   A, [HL+]                                      ;; 0b:4f33 $2a
    cp   A, $ff                                        ;; 0b:4f34 $fe $ff
    ret  Z                                             ;; 0b:4f36 $c8
    cp   A, C                                          ;; 0b:4f37 $b9
    jr   NZ, .jr_0b_4f3e                               ;; 0b:4f38 $20 $04
    ld   A, [HL]                                       ;; 0b:4f3a $7e
    cp   A, B                                          ;; 0b:4f3b $b8
    jr   Z, .jr_0b_4f41                                ;; 0b:4f3c $28 $03
.jr_0b_4f3e:
    add  HL, DE                                        ;; 0b:4f3e $19
    jr   .jr_0b_4f33                                   ;; 0b:4f3f $18 $f2
.jr_0b_4f41:
    inc  HL                                            ;; 0b:4f41 $23
    ld   C, [HL]                                       ;; 0b:4f42 $4e
    inc  HL                                            ;; 0b:4f43 $23
    ld   B, [HL]                                       ;; 0b:4f44 $46
    ld   L, C                                          ;; 0b:4f45 $69
    ld   H, $00                                        ;; 0b:4f46 $26 $00
    add  HL, HL                                        ;; 0b:4f48 $29
    add  HL, HL                                        ;; 0b:4f49 $29
    add  HL, HL                                        ;; 0b:4f4a $29
    add  HL, HL                                        ;; 0b:4f4b $29
    add  HL, HL                                        ;; 0b:4f4c $29
    ld   DE, $20                                       ;; 0b:4f4d $11 $20 $00
    add  HL, DE                                        ;; 0b:4f50 $19
    ld   A, L                                          ;; 0b:4f51 $7d
    ld   [wD20E], A                                    ;; 0b:4f52 $ea $0e $d2
    ld   A, H                                          ;; 0b:4f55 $7c
    ld   [wD20F], A                                    ;; 0b:4f56 $ea $0f $d2
    ld   L, B                                          ;; 0b:4f59 $68
    ld   H, $00                                        ;; 0b:4f5a $26 $00
    add  HL, HL                                        ;; 0b:4f5c $29
    add  HL, HL                                        ;; 0b:4f5d $29
    add  HL, HL                                        ;; 0b:4f5e $29
    add  HL, HL                                        ;; 0b:4f5f $29
    add  HL, HL                                        ;; 0b:4f60 $29
    ld   DE, $10                                       ;; 0b:4f61 $11 $10 $00
    add  HL, DE                                        ;; 0b:4f64 $19
    ld   A, L                                          ;; 0b:4f65 $7d
    ld   [wD210], A                                    ;; 0b:4f66 $ea $10 $d2
    ld   A, H                                          ;; 0b:4f69 $7c
    ld   [wD211], A                                    ;; 0b:4f6a $ea $11 $d2
    jp   call_00_13a6                                  ;; 0b:4f6d $c3 $a6 $13
.jr_0b_4f70:
    ld   A, [wD624_CurrentLevelId]                                    ;; 0b:4f70 $fa $24 $d6
    and  A, A                                          ;; 0b:4f73 $a7
    jr   NZ, .jr_0b_4faf                               ;; 0b:4f74 $20 $39
    ld   HL, wD628_MediaDimensionRespawnPoint                                     ;; 0b:4f76 $21 $28 $d6
    ld   L, [HL]                                       ;; 0b:4f79 $6e
    ld   H, $00                                        ;; 0b:4f7a $26 $00
    add  HL, HL                                        ;; 0b:4f7c $29
    ld   DE, .data_MediaDimensionSpawns                             ;; 0b:4f7d $11 $01 $54
    add  HL, DE                                        ;; 0b:4f80 $19
    ld   C, [HL]                                       ;; 0b:4f81 $4e
    inc  HL                                            ;; 0b:4f82 $23
    ld   B, [HL]                                       ;; 0b:4f83 $46
    ld   L, C                                          ;; 0b:4f84 $69
    ld   H, $00                                        ;; 0b:4f85 $26 $00
    add  HL, HL                                        ;; 0b:4f87 $29
    add  HL, HL                                        ;; 0b:4f88 $29
    add  HL, HL                                        ;; 0b:4f89 $29
    add  HL, HL                                        ;; 0b:4f8a $29
    add  HL, HL                                        ;; 0b:4f8b $29
    ld   DE, $20                                       ;; 0b:4f8c $11 $20 $00
    add  HL, DE                                        ;; 0b:4f8f $19
    ld   A, L                                          ;; 0b:4f90 $7d
    ld   [wD20E], A                                    ;; 0b:4f91 $ea $0e $d2
    ld   A, H                                          ;; 0b:4f94 $7c
    ld   [wD20F], A                                    ;; 0b:4f95 $ea $0f $d2
    ld   L, B                                          ;; 0b:4f98 $68
    ld   H, $00                                        ;; 0b:4f99 $26 $00
    add  HL, HL                                        ;; 0b:4f9b $29
    add  HL, HL                                        ;; 0b:4f9c $29
    add  HL, HL                                        ;; 0b:4f9d $29
    add  HL, HL                                        ;; 0b:4f9e $29
    add  HL, HL                                        ;; 0b:4f9f $29
    ld   DE, $30                                       ;; 0b:4fa0 $11 $30 $00
    add  HL, DE                                        ;; 0b:4fa3 $19
    ld   A, L                                          ;; 0b:4fa4 $7d
    ld   [wD210], A                                    ;; 0b:4fa5 $ea $10 $d2
    ld   A, H                                          ;; 0b:4fa8 $7c
    ld   [wD211], A                                    ;; 0b:4fa9 $ea $11 $d2
    jp   call_00_13a6                                  ;; 0b:4fac $c3 $a6 $13
.jr_0b_4faf:
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:4faf $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:4fb2 $6e
    ld   H, $00                                        ;; 0b:4fb3 $26 $00
    add  HL, HL                                        ;; 0b:4fb5 $29
    add  HL, HL                                        ;; 0b:4fb6 $29
    add  HL, HL                                        ;; 0b:4fb7 $29
    ld   A, [wD618_CheckpointSpawnId]                                    ;; 0b:4fb8 $fa $18 $d6
    add  A, A                                          ;; 0b:4fbb $87
    ld   E, A                                          ;; 0b:4fbc $5f
    ld   D, $00                                        ;; 0b:4fbd $16 $00
    add  HL, DE                                        ;; 0b:4fbf $19
    ld   DE, .data_LevelInitialSpawns                             ;; 0b:4fc0 $11 $3f $54
    add  HL, DE                                        ;; 0b:4fc3 $19
    ld   C, [HL]                                       ;; 0b:4fc4 $4e
    inc  HL                                            ;; 0b:4fc5 $23
    ld   B, [HL]                                       ;; 0b:4fc6 $46
    ld   L, C                                          ;; 0b:4fc7 $69
    ld   H, $00                                        ;; 0b:4fc8 $26 $00
    add  HL, HL                                        ;; 0b:4fca $29
    add  HL, HL                                        ;; 0b:4fcb $29
    add  HL, HL                                        ;; 0b:4fcc $29
    add  HL, HL                                        ;; 0b:4fcd $29
    add  HL, HL                                        ;; 0b:4fce $29
    ld   DE, $10                                       ;; 0b:4fcf $11 $10 $00
    add  HL, DE                                        ;; 0b:4fd2 $19
    ld   A, L                                          ;; 0b:4fd3 $7d
    ld   [wD20E], A                                    ;; 0b:4fd4 $ea $0e $d2
    ld   A, H                                          ;; 0b:4fd7 $7c
    ld   [wD20F], A                                    ;; 0b:4fd8 $ea $0f $d2
    ld   L, B                                          ;; 0b:4fdb $68
    ld   H, $00                                        ;; 0b:4fdc $26 $00
    add  HL, HL                                        ;; 0b:4fde $29
    add  HL, HL                                        ;; 0b:4fdf $29
    add  HL, HL                                        ;; 0b:4fe0 $29
    add  HL, HL                                        ;; 0b:4fe1 $29
    add  HL, HL                                        ;; 0b:4fe2 $29
    ld   DE, $10                                       ;; 0b:4fe3 $11 $10 $00
    add  HL, DE                                        ;; 0b:4fe6 $19
    ld   A, L                                          ;; 0b:4fe7 $7d
    ld   [wD210], A                                    ;; 0b:4fe8 $ea $10 $d2
    ld   A, H                                          ;; 0b:4feb $7c
    ld   [wD211], A                                    ;; 0b:4fec $ea $11 $d2
    jp   call_00_13a6                                  ;; 0b:4fef $c3 $a6 $13
.data_LevelDoorSpawns:
    dw   .data_0b_5030
    dw   .data_0b_5051
    dw   .data_0b_5066
    dw   .data_0b_5097
    dw   .data_0b_50e0
    dw   .data_0b_5111
    dw   .data_0b_5030
    dw   .data_0b_5182
    dw   .data_0b_519b
    dw   .data_0b_5030
    dw   .data_0b_51ac
    dw   .data_0b_51ed
    dw   .data_0b_5030
    dw   .data_0b_5266
    dw   .data_0b_5293
    dw   .data_0b_5030
    dw   .data_0b_52d4
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5389
    dw   .data_0b_53c2
    dw   .data_0b_53f3
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_5030
    dw   .data_0b_53fc
.data_0b_5030:
    db   $25, $0e                                      ;; 0b:5030 ????????
    db   $07, $17, $1b, $17, $07, $24, $2f, $17        ;; 0b:5032 ????????
    db   $07, $4d, $43, $17, $27, $3a, $07, $17        ;; 0b:503a ????????
    db   $25, $0e, $07, $24, $1b, $17, $07, $4d        ;; 0b:5042 ????????
    db   $2f, $17, $27, $3a, $43, $17, $ff
.data_0b_5051:
    db   $41                                            ;; 0b:5051 ????????
    db   $03, $03, $28, $6a, $1d, $03, $3c, $49        ;; 0b:5052 ????????
    db   $36, $52, $3e, $03, $28, $41, $03, $03        ;; 0b:505a ????????
    db   $3c, $6a, $1d, $ff
.data_0b_5066:
    db   $19, $07, $23, $09        ;; 0b:5066 ????????
    db   $34, $06, $3f, $06, $47, $02, $02, $12        ;; 0b:506a ????????
    db   $2d, $10, $37, $15, $3a, $0f, $02, $1b        ;; 0b:5072 ????????
    db   $3e, $0f, $28, $21, $23, $09, $19, $07        ;; 0b:507a ????????
    db   $3f, $06, $34, $06, $02, $12, $47, $02        ;; 0b:5082 ????????
    db   $37, $15, $2d, $10, $02, $1b, $3a, $0f        ;; 0b:508a ????????
    db   $28, $21, $3e, $0f, $ff
.data_0b_5097:
    db   $16, $33, $1d        ;; 0b:5097 ????????
    db   $31, $23, $31, $2e, $30, $27, $31, $24        ;; 0b:509a ????????
    db   $62, $43, $2a, $4d, $2d, $4c, $32, $02        ;; 0b:50a2 ????????
    db   $42, $50, $2b, $0a, $3b, $1e, $41, $08        ;; 0b:50aa ????????
    db   $57, $71, $28, $12, $3f, $76, $46, $28        ;; 0b:50b2 ????????
    db   $3f, $1d, $31, $16, $33, $2e, $30, $23        ;; 0b:50ba ????????
    db   $31, $24, $62, $27, $31, $4d, $2d, $43        ;; 0b:50c2 ????????
    db   $2a, $02, $42, $4c, $32, $0a, $3b, $50        ;; 0b:50ca ????????
    db   $2b, $08, $57, $1e, $41, $12, $3f, $71        ;; 0b:50d2 ????????
    db   $28, $28, $3f, $76, $46, $ff
.data_0b_50e0:
    db   $0b, $06        ;; 0b:50da ????????
    db   $2b, $09, $13, $07, $1d, $21, $7c, $0a        ;; 0b:50e2 ????????
    db   $04, $42, $7c, $21, $1d, $2f, $65, $2f        ;; 0b:50ea ????????
    db   $1c, $43, $3d, $41, $46, $42, $2b, $09        ;; 0b:50f2 ????????
    db   $0b, $06, $1d, $21, $13, $07, $04, $42        ;; 0b:50fa ????????
    db   $7c, $0a, $1d, $2f, $7c, $21, $1c, $43        ;; 0b:5102 ????????
    db   $65, $2f, $46, $42, $3d, $41, $ff
.data_0b_5111:
    db   $09        ;; 0b:5111 ????????
    db   $1d, $2b, $06, $40, $05, $09, $19, $16        ;; 0b:5112 ????????
    db   $19, $48, $05, $4d, $05, $40, $12, $52        ;; 0b:511a ????????
    db   $0e, $09, $15, $19, $15, $5f, $1f, $68        ;; 0b:5122 ????????
    db   $10, $09, $0d, $18, $11, $07, $35, $07        ;; 0b:512a ????????
    db   $2a, $2b, $2c, $19, $1d, $28, $35, $2c        ;; 0b:5132 ????????
    db   $35, $35, $28, $35, $22, $39, $3a, $4b        ;; 0b:513a ????????
    db   $34, $5e, $35, $6a, $35, $5c, $45, $2b        ;; 0b:5142 ????????
    db   $06, $09, $1d, $09, $19, $40, $05, $48        ;; 0b:514a ????????
    db   $05, $16, $19, $40, $12, $4d, $05, $09        ;; 0b:5152 ????????
    db   $15, $52, $0e, $5f, $1f, $19, $15, $09        ;; 0b:515a ????????
    db   $0d, $68, $10, $07, $35, $18, $11, $2b        ;; 0b:5162 ????????
    db   $2c, $07, $2a, $28, $35, $19, $1d, $35        ;; 0b:516a ????????
    db   $28, $2c, $35, $39, $3a, $35, $22, $5e        ;; 0b:5172 ????????
    db   $35, $4b, $34, $5c, $45, $6a, $35, $ff        ;; 0b:517a ????????
.data_0b_5182:
    db   $57, $03, $5a, $3b, $5a, $3b, $57, $03        ;; 0b:5182 ????????
    db   $7c, $03, $03, $37, $7b, $12, $03, $46        ;; 0b:518a ????????
    db   $03, $37, $7c, $03, $03, $46, $7b, $12        ;; 0b:5192 ????????
    db   $ff
.data_0b_519b:
    db   $17, $44, $4a, $7d, $4a, $7d, $17        ;; 0b:519b ????????
    db   $44, $31, $4b, $3f, $65, $3f, $65, $31        ;; 0b:51a2 ????????
    db   $4b, $ff
.data_0b_51ac:
    db   $04, $0e, $26, $1b, $36, $0e        ;; 0b:51ac ????????
    db   $4f, $34, $4f, $2f, $41, $34, $43, $27        ;; 0b:51b2 ????????
    db   $64, $21, $47, $21, $0d, $6c, $58, $11        ;; 0b:51ba ????????
    db   $62, $13, $79, $25, $04, $41, $63, $41        ;; 0b:51c2 ????????
    db   $69, $51, $26, $1b, $04, $0e, $4f, $34        ;; 0b:51ca ????????
    db   $36, $0e, $41, $34, $4f, $2f, $64, $21        ;; 0b:51d2 ????????
    db   $43, $27, $0d, $6c, $47, $21, $62, $13        ;; 0b:51da ????????
    db   $58, $11, $04, $41, $79, $25, $69, $51        ;; 0b:51e2 ????????
    db   $63, $41, $ff
.data_0b_51ed:
    db   $59, $35, $03, $4d, $09        ;; 0b:51ed ????????
    db   $49, $3c, $4c, $11, $4d, $02, $3f, $28        ;; 0b:51f2 ????????
    db   $3e, $4e, $47, $03, $3b, $46, $42, $46        ;; 0b:51fa ????????
    db   $3c, $37, $35, $54, $47, $31, $58, $56        ;; 0b:5202 ????????
    db   $4c, $37, $66, $59, $29, $0e, $53, $2a        ;; 0b:520a ????????
    db   $54, $03, $54, $47, $4a, $16, $54, $55        ;; 0b:5212 ????????
    db   $42, $35, $3f, $57, $3c, $35, $3c, $02        ;; 0b:521a ????????
    db   $2d, $4c, $29, $02, $31, $4c, $35, $03        ;; 0b:5222 ????????
    db   $4d, $59, $35, $3c, $4c, $09, $49, $02        ;; 0b:522a ????????
    db   $3f, $11, $4d, $4e, $47, $28, $3e, $46        ;; 0b:5232 ????????
    db   $42, $03, $3b, $37, $35, $46, $3c, $31        ;; 0b:523a ????????
    db   $58, $54, $47, $37, $66, $56, $4c, $0e        ;; 0b:5242 ????????
    db   $53, $59, $29, $03, $54, $2a, $54, $16        ;; 0b:524a ????????
    db   $54, $47, $4a, $35, $3f, $55, $42, $35        ;; 0b:5252 ????????
    db   $3c, $57, $3c, $4c, $29, $02, $2d, $4c        ;; 0b:525a ????????
    db   $35, $02, $31, $ff
.data_0b_5266:
    db   $0b, $0c, $68, $22        ;; 0b:5266 ????????
    db   $69, $05, $09, $1e, $13, $0c, $07, $31        ;; 0b:526a ????????
    db   $17, $0c, $03, $48, $68, $22, $0b, $0c        ;; 0b:5272 ????????
    db   $09, $1e, $69, $05, $07, $31, $13, $0c        ;; 0b:527a ????????
    db   $03, $48, $17, $0c, $63, $11, $39, $0a        ;; 0b:5282 ????????
    db   $1a, $46, $31, $54, $31, $54, $1a, $46        ;; 0b:528a ????????
    db   $ff
.data_0b_5293:
    db   $14, $07, $1b, $07, $26, $07, $0b        ;; 0b:5293 ????????
    db   $28, $0b, $15, $06, $2f, $0e, $2f, $05        ;; 0b:529a ????????
    db   $5a, $29, $53, $05, $64, $1d, $64, $2c        ;; 0b:52a2 ????????
    db   $5e, $31, $51, $42, $56, $56, $52, $42        ;; 0b:52aa ????????
    db   $60, $1b, $07, $14, $07, $0b, $28, $26        ;; 0b:52b2 ????????
    db   $07, $06, $2f, $0b, $15, $05, $5a, $0e        ;; 0b:52ba ????????
    db   $2f, $05, $64, $29, $53, $2c, $5e, $1d        ;; 0b:52c2 ????????
    db   $64, $42, $56, $31, $51, $42, $60, $56        ;; 0b:52ca ????????
    db   $52, $ff
.data_0b_52d4:
    db   $6a, $2e, $6d, $66, $6f, $2e        ;; 0b:52d4 ????????
    db   $65, $34, $74, $2e, $6f, $2e, $65, $31        ;; 0b:52da ????????
    db   $65, $34, $6a, $31, $74, $31, $74, $31        ;; 0b:52e2 ????????
    db   $6a, $31, $65, $34, $74, $2e, $6f, $34        ;; 0b:52ea ????????
    db   $71, $5c, $74, $34, $65, $34, $65, $37        ;; 0b:52f2 ????????
    db   $6a, $31, $6a, $37, $65, $34, $6f, $37        ;; 0b:52fa ????????
    db   $74, $34, $74, $37, $65, $3a, $65, $3a        ;; 0b:5302 ????????
    db   $6f, $37, $6a, $3a, $74, $37, $74, $3a        ;; 0b:530a ????????
    db   $65, $5c, $65, $3e, $6a, $3a, $6a, $3e        ;; 0b:5312 ????????
    db   $74, $3e, $6f, $3e, $65, $3a, $74, $3e        ;; 0b:531a ????????
    db   $6f, $3e, $65, $41, $6f, $44, $6f, $41        ;; 0b:5322 ????????
    db   $65, $3e, $65, $44, $6d, $44, $6d, $44        ;; 0b:532a ????????
    db   $6f, $48, $6f, $44, $65, $41, $74, $44        ;; 0b:5332 ????????
    db   $65, $44, $6f, $48, $74, $44, $74, $48        ;; 0b:533a ????????
    db   $6f, $4b, $65, $4b, $6f, $48, $6a, $4b        ;; 0b:5342 ????????
    db   $74, $4b, $6f, $4b, $6d, $44, $74, $4b        ;; 0b:534a ????????
    db   $6a, $4e, $65, $4e, $74, $52, $6a, $4e        ;; 0b:5352 ????????
    db   $65, $4e, $74, $4e, $6f, $4b, $65, $52        ;; 0b:535a ????????
    db   $6f, $52, $6f, $52, $6f, $55, $74, $52        ;; 0b:5362 ????????
    db   $6a, $4e, $65, $55, $74, $55, $6a, $55        ;; 0b:536a ????????
    db   $65, $52, $6f, $55, $74, $55, $74, $55        ;; 0b:5372 ????????
    db   $6a, $55, $6d, $66, $6a, $2e, $65, $5c        ;; 0b:537a ????????
    db   $74, $3a, $71, $5c, $6f, $34, $ff
.data_0b_5389:
    db   $03        ;; 0b:5389 ????????
    db   $0e, $02, $1f, $02, $1f, $03, $0e, $0b        ;; 0b:538a ????????
    db   $0e, $1b, $1f, $1b, $1f, $0b, $0e, $15        ;; 0b:5392 ????????
    db   $0f, $34, $14, $34, $14, $15, $0f, $57        ;; 0b:539a ????????
    db   $07, $03, $2d, $03, $2d, $57, $07, $0e        ;; 0b:53a2 ????????
    db   $1d, $16, $2a, $16, $2a, $0e, $1d, $26        ;; 0b:53aa ????????
    db   $1f, $3b, $2e, $3b, $2e, $26, $1f, $27        ;; 0b:53b2 ????????
    db   $2e, $04, $35, $04, $35, $27, $2e, $ff        ;; 0b:53ba ????????
.data_0b_53c2:
    db   $03, $03, $18, $0f, $25, $04, $2c, $0a        ;; 0b:53c2 ????????
    db   $3e, $04, $58, $09, $44, $03, $61, $07        ;; 0b:53ca ????????
    db   $51, $04, $02, $19, $02, $15, $1d, $1c        ;; 0b:53d2 ????????
    db   $18, $0f, $03, $03, $2c, $0a, $25, $04        ;; 0b:53da ????????
    db   $58, $09, $3e, $04, $61, $07, $44, $03        ;; 0b:53e2 ????????
    db   $02, $19, $51, $04, $1d, $1c, $02, $15        ;; 0b:53ea ????????
    db   $ff
.data_0b_53f3:
    db   $1d, $2d, $5a, $0a, $5a, $0a, $1d        ;; 0b:53f3 ????????
    db   $2d, $ff
.data_0b_53fc:
    db   $62, $7d, $70, $7d, $ff             ;; 0b:53fc ???????

.data_MediaDimensionSpawns:
    db   $25, $0d
    db   $05, $0b
    db   $36, $0b
    db   $11, $16        ;; 0b:5401 wwww????
    db   $39, $16, $25, $16, $00, $00, $1e, $23        ;; 0b:5409 ????????
    db   $32, $23, $24, $46, $1a, $46, $10, $46        ;; 0b:5411 ????????
    db   $00, $00, $11, $31, $3e, $31, $00, $00        ;; 0b:5419 ????????
    db   $1a, $0d, $00, $00, $00, $00, $00, $00        ;; 0b:5421 ????????
    db   $00, $00, $26, $1e, $18, $4c, $1c, $31        ;; 0b:5429 ????????
    db   $1a, $04, $11, $04, $23, $04, $00, $00        ;; 0b:5431 ????????
    db   $00, $00, $00, $00, $48, $31                  ;; 0b:5439 ??????
.data_LevelInitialSpawns:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:543f ????????
    db   $2f, $0b, $26, $3a, $00, $00, $00, $00        ;; 0b:5447 ww??????
    db   $03, $0a, $4b, $0a, $00, $00, $00, $00        ;; 0b:544f ww??????
    db   $0b, $31, $00, $00, $00, $00, $00, $00        ;; 0b:5457 ????????
    db   $1a, $15, $00, $00, $00, $00, $00, $00        ;; 0b:545f ????????
    db   $0f, $1d, $10, $15, $00, $00, $00, $00        ;; 0b:5467 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:546f ????????
    db   $04, $13, $00, $00, $00, $00, $00, $00        ;; 0b:5477 ????????
    db   $04, $6a, $37, $56, $00, $00, $00, $00        ;; 0b:547f ????????
    db   $04, $73, $3f, $70, $00, $00, $00, $00        ;; 0b:5487 ????????
    db   $0d, $34, $4d, $34, $00, $00, $00, $00        ;; 0b:548f ????????
    db   $15, $31, $00, $00, $00, $00, $00, $00        ;; 0b:5497 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:549f ????????
    db   $1e, $0c, $00, $00, $00, $00, $00, $00        ;; 0b:54a7 ????????
    db   $04, $05, $00, $00, $00, $00, $00, $00        ;; 0b:54af ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:54b7 ????????
    db   $6d, $55, $00, $00, $00, $00, $00, $00        ;; 0b:54bf ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:54c7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:54cf ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:54d7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:54df ????????
    db   $50, $66, $00, $00, $00, $00, $00, $00        ;; 0b:54e7 ????????
    db   $1c, $75, $00, $00, $00, $00, $00, $00        ;; 0b:54ef ????????
    db   $05, $46, $00, $00, $00, $00, $00, $00        ;; 0b:54f7 ????????
    db   $07, $14, $0e, $34, $00, $00, $00, $00        ;; 0b:54ff ????????
    db   $05, $0c, $00, $00, $00, $00, $00, $00        ;; 0b:5507 ????????
    db   $7b, $1a, $00, $00, $00, $00, $00, $00        ;; 0b:550f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5517 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:551f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5527 ????????
    db   $06, $7c, $00, $00, $00, $00, $00, $00        ;; 0b:552f ????????

entry_0b_5537:
    ld   A, [wD59E]                                    ;; 0b:5537 $fa $9e $d5
    and  A, A                                          ;; 0b:553a $a7
    jp   NZ, call_0b_561b                               ;; 0b:553b $c2 $1b $56
    ld   A, [wD624_CurrentLevelId]                                    ;; 0b:553e $fa $24 $d6
    ld   DE, .data_0b_555f                             ;; 0b:5541 $11 $5f $55
    inc  C                                             ;; 0b:5544 $0c
    dec  C                                             ;; 0b:5545 $0d
    jr   Z, .jr_0b_554c                                ;; 0b:5546 $28 $04
    ld   A, C                                          ;; 0b:5548 $79
    ld   DE, .data_0b_55db                             ;; 0b:5549 $11 $db $55
.jr_0b_554c:
    ld   L, A                                          ;; 0b:554c $6f
    ld   H, $00                                        ;; 0b:554d $26 $00
    add  HL, HL                                        ;; 0b:554f $29
    add  HL, HL                                        ;; 0b:5550 $29
    add  HL, DE                                        ;; 0b:5551 $19
    ld   A, [HL+]                                      ;; 0b:5552 $2a
    ld   [wDAD1], A                                    ;; 0b:5553 $ea $d1 $da
    ld   A, [HL+]                                      ;; 0b:5556 $2a
    ld   [wDAD2], A                                    ;; 0b:5557 $ea $d2 $da
    ld   A, [HL+]                                      ;; 0b:555a $2a
    ld   [wDAD3], A                                    ;; 0b:555b $ea $d3 $da
    ret                                                ;; 0b:555e $c9
.data_0b_555f:
    db   $1b, $1f, $1f, $00, $e4, $1f, $1f, $00        ;; 0b:555f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5567 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:556f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5577 ????????
    db   $e4, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:557f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5587 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:558f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:5597 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:559f ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55a7 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55af ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55b7 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55bf ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55c7 ????????
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00        ;; 0b:55cf ????????
    db   $1b, $1f, $1f, $00                            ;; 0b:55d7 ????
.data_0b_55db:
    db   $00, $00, $00, $00, $1b, $1b, $1b, $00        ;; 0b:55db ????????
    db   $1b, $1b, $1b, $00, $1b, $1b, $ff, $00        ;; 0b:55e3 ????????
    db   $1b, $1b, $1b, $00, $1b, $1b, $1b, $00        ;; 0b:55eb ????????
    db   $1b, $1b, $1b, $00, $1b, $1b, $1b, $00        ;; 0b:55f3 ????????
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00        ;; 0b:55fb ????????
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00        ;; 0b:5603 ????????
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00        ;; 0b:560b ????????
    db   $e4, $e4, $24, $00, $00, $00, $00, $00        ;; 0b:5613 ????????

call_0b_561b:
    inc  C                                             ;; 0b:561b $0c
    dec  C                                             ;; 0b:561c $0d
    jr   NZ, call_0b_5651                               ;; 0b:561d $20 $32
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:561f $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:5622 $6e
    ld   H, $00                                        ;; 0b:5623 $26 $00
    add  HL, HL                                        ;; 0b:5625 $29
    ld   DE, data_0b_5665_level_palettes                             ;; 0b:5626 $11 $65 $56
    add  HL, DE                                        ;; 0b:5629 $19
    ld   A, [HL+]                                      ;; 0b:562a $2a
    ld   H, [HL]                                       ;; 0b:562b $66
    ld   L, A                                          ;; 0b:562c $6f
    ld   DE, wD9CB_Bg_Palettes                                     ;; 0b:562d $11 $cb $d9
    ld   BC, $40                                       ;; 0b:5630 $01 $40 $00
    call call_00_07b0_CopyBytes                                  ;; 0b:5633 $cd $b0 $07
    call call_0b_5df8                                  ;; 0b:5636 $cd $f8 $5d
    ld   HL, data_gex_object_palette2                             ;; 0b:5639 $21 $03 $5b
    ld   DE, wDA0B_Obj_Palettes                                     ;; 0b:563c $11 $0b $da
    ld   BC, $08                                       ;; 0b:563f $01 $08 $00
    call call_00_07b0_CopyBytes                                  ;; 0b:5642 $cd $b0 $07
    ld   [wD59D_BankSwitch], A                                    ;; 0b:5645 $ea $9d $d5
    ld   A, Bank03                                        ;; 0b:5648 $3e $03
    ld   HL, entry_03_6be5                                     ;; 0b:564a $21 $e5 $6b
    call call_00_1078_SwitchBankWrapper                                  ;; 0b:564d $cd $78 $10
    ret                                                ;; 0b:5650 $c9

call_0b_5651:
    ld   L, C                                          ;; 0b:5651 $69
    ld   H, $00                                        ;; 0b:5652 $26 $00
    add  HL, HL                                        ;; 0b:5654 $29
    ld   DE, data_0b_56a3                             ;; 0b:5655 $11 $a3 $56
    add  HL, DE                                        ;; 0b:5658 $19
    ld   A, [HL+]                                      ;; 0b:5659 $2a
    ld   H, [HL]                                       ;; 0b:565a $66
    ld   L, A                                          ;; 0b:565b $6f
    ld   DE, wD9CB_Bg_Palettes                                     ;; 0b:565c $11 $cb $d9
    ld   BC, $80                                       ;; 0b:565f $01 $80 $00
    jp   call_00_07b0_CopyBytes                                  ;; 0b:5662 $c3 $b0 $07

data_0b_5665_level_palettes:
    dw   palette_media_dimension
    dw   palette_toon_tv
    dw   palette_scream_tv
    dw   palette_scream_tv
    dw   palette_circuit_central
    dw   palette_kung_fu_theater
    dw   palette_media_dimension
    dw   palette_prehistory_channel
    dw   palette_toon_tv
    dw   palette_prehistory_channel
    dw   palette_circuit_central
    dw   palette_scream_tv
    dw   palette_media_dimension
    dw   palette_kung_fu_theater
    dw   palette_rezopolis
    dw   palette_media_dimension
    dw   palette_scream_tv
    dw   palette_media_dimension
    dw   palette_media_dimension
    dw   palette_media_dimension
    dw   palette_media_dimension
    dw   palette_kung_fu_theater2
    dw   palette_rezopolis
    dw   palette_circuit_central
    dw   palette_prehistory_channel
    dw   palette_scream_tv
    dw   palette_rezopolis
    dw   palette_media_dimension
    dw   palette_media_dimension
    dw   palette_media_dimension
    dw   palette_channel_z
data_0b_56a3:
    dw   $0000
    dw   image_title_screen_008_1_palette
    dw   image_title_screen_008_0_palette
    dw   data_5743_Palette
    dw   data_57c3_Palette
    dw   image_great_job_00c_2_palette
    dw   data_5a83_Palette
    dw   $da4b
    dw   image_splash_01f_1_palette
    dw   image_crave_01f_0_palette
    dw   image_david_01e_0_palette
    dw   data_5903_Palette
    dw   data_5943_Palette
    dw   data_5983_Palette
    dw   data_59c3_Palette
    dw   data_5a03_Palette

image_title_screen_008_1_palette: ; Palette for actual title screen splash (start/password) ; 56c3
    INCBIN "../gfx/menus/palettes/image_title_screen_008_1_palette.bin"    
image_title_screen_008_0_palette: ; Palette for 4th title screen splash (big gex image) ; 5703
    INCBIN "../gfx/menus/palettes/image_title_screen_008_0_palette.bin"    
data_5743_Palette: ; Palette for Password Entering Screen on title screen ; 5743
    db   $00, $00, $4a, $29, $73, $52, $5a, $6b        ;; 0b:5743 ........
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 0b:574b ........
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 0b:5753 ........
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 0b:575b ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:5763 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:576b ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5773 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:577b ........
data_5783_Palette: ; Palette for ??? ; 5783
    db   $00, $00, $4a, $29, $73, $52, $5a, $6b        ;; 0b:5783 ????????
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 0b:578b ????????
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 0b:5793 ????????
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 0b:579b ????????
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:57a3 ????????
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:57ab ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:57b3 ????????
    db   $00, $00, $00, $00, $6b, $2d, $5a, $6b        ;; 0b:57bb ????????
data_57c3_Palette: ; Palette for ??? ; 57c3
    db   $e0, $01, $e0, $01, $e0, $01, $e0, $01        ;; 0b:57c3 ????????
    db   $00, $00, $8d, $00, $74, $01, $bc, $02        ;; 0b:57cb ????????
    db   $00, $00, $0c, $01, $36, $02, $00, $7c        ;; 0b:57d3 ????????
    db   $00, $00, $0c, $01, $36, $02, $bc, $02        ;; 0b:57db ????????
    db   $00, $00, $0c, $01, $36, $02, $7f, $33        ;; 0b:57e3 ????????
    db   $00, $00, $05, $25, $4e, $52, $12, $6f        ;; 0b:57eb ????????
    db   $00, $00, $8d, $00, $36, $02, $bc, $02        ;; 0b:57f3 ????????
    db   $00, $00, $3b, $04, $41, $69, $e0, $76        ;; 0b:57fb ????????
image_great_job_00c_2_palette: ; Palette for "Great Job! Thanks for Playing- The GEX Team" ; 5803
    INCBIN "../gfx/menus/palettes/image_great_job_00c_2_palette.bin"
image_splash_01f_1_palette: ; Palette for first title screen splash (gex enter the gecko) ; 5843
    INCBIN "../gfx/menus/palettes/image_splash_01f_1_palette.bin"
image_crave_01f_0_palette: ; Palette for 2nd title screen splash (CRAVE entertainment) ; 5883
    INCBIN "../gfx/menus/palettes/image_crave_01f_0_palette.bin"
image_david_01e_0_palette: ; Palette for 3rd title screen splash (David A Palmer Productions) ; 58c3
    INCBIN "../gfx/menus/palettes/image_david_01e_0_palette.bin"
data_5903_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:5903 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:590b ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5913 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:591b ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5923 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:592b ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5933 ........
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:593b ........
data_5943_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:5943 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:594b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5953 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:595b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5963 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:596b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5973 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:597b ????????
data_5983_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:5983 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:598b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:5993 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:599b ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59a3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59ab ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59b3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59bb ????????
data_59c3_Palette: ; Palette for credits?
    db   $ff, $7f, $bf, $63, $f7, $4a, $00, $00        ;; 0b:59c3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59cb ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59d3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59db ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59e3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59eb ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59f3 ????????
    db   $e0, $03, $e0, $03, $e0, $03, $e0, $03        ;; 0b:59fb ????????
data_5a03_Palette: ; unknown palette. may be unused.
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a03 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a0b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a13 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a1b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a23 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a2b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a33 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a3b ????????
; unknown palette. may be unused.
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a43 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a4b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a53 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a5b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a63 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a6b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a73 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5a7b ????????
data_5a83_Palette: ; Palette for "Entering <level>" screen, also the 4 pause screens (main, exit to map, quit game, totals)
    db   $00, $00, $00, $02, $00, $00, $e0, $03        ;; 0b:5a83 ........
    db   $00, $00, $8c, $01, $c0, $02, $5a, $03        ;; 0b:5a8b ........
    db   $00, $00, $10, $42, $18, $63, $ff, $7f        ;; 0b:5a93 ........
    db   $00, $00, $e0, $01, $e0, $02, $e0, $03        ;; 0b:5a9b ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:5aa3 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:5aab ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5ab3 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5abb ........
; unknown palette
    db   $00, $00, $00, $02, $00, $00, $e0, $03        ;; 0b:5ac3 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5acb ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0b:5ad3 ........
    db   $00, $00, $0f, $00, $17, $00, $1f, $00        ;; 0b:5adb ........
    db   $00, $00, $ef, $3d, $f7, $5e, $ff, $7f        ;; 0b:5ae3 ........
    db   $00, $00, $ef, $01, $f7, $02, $ff, $03        ;; 0b:5aeb ........
    db   $00, $00, $00, $00, $20, $03, $bf, $0b        ;; 0b:5af3 ........
    db   $00, $00, $1f, $00, $ff, $01, $7f, $03        ;; 0b:5afb ........
data_gex_object_palette2:
    db   $00, $00, $00, $00, $8a, $02, $fd, $03        ;; 0b:5b03 ........

palette_media_dimension:
    INCBIN "../gfx/tilesets/palettes/palette_media_dimension.bin"
palette_toon_tv:
    INCBIN "../gfx/tilesets/palettes/palette_toon_tv.bin"
palette_scream_tv:
    INCBIN "../gfx/tilesets/palettes/palette_scream_tv.bin"
palette_circuit_central:
    INCBIN "../gfx/tilesets/palettes/palette_circuit_central.bin"
palette_kung_fu_theater:
    INCBIN "../gfx/tilesets/palettes/palette_kung_fu_theater.bin"
palette_kung_fu_theater2:
    INCBIN "../gfx/tilesets/palettes/palette_kung_fu_theater2.bin"
palette_prehistory_channel:
    INCBIN "../gfx/tilesets/palettes/palette_prehistory_channel.bin"
palette_rezopolis:
    INCBIN "../gfx/tilesets/palettes/palette_rezopolis.bin"
palette_channel_z:
    INCBIN "../gfx/tilesets/palettes/palette_channel_z.bin"

entry_0b_5d4b:
    ld   A, [wD59E]                                    ;; 0b:5d4b $fa $9e $d5
    and  A, A                                          ;; 0b:5d4e $a7
    ret  Z                                             ;; 0b:5d4f $c8
    call call_00_2e3a                                  ;; 0b:5d50 $cd $3a $2e
    ld   DE, .data_0b_5d62                             ;; 0b:5d53 $11 $62 $5d
    call call_00_07b9                                  ;; 0b:5d56 $cd $b9 $07
    ld   DE, wDA7B                                     ;; 0b:5d59 $11 $7b $da
    ld   BC, $10                                       ;; 0b:5d5c $01 $10 $00
    jp   call_00_07b0_CopyBytes                                  ;; 0b:5d5f $c3 $b0 $07
.data_0b_5d62:
    dw   $0000
    dw   .circuit_central_television_palette
    dw   .kung_fu_theater_television_palette
    dw   .prehistory_channel_television_palette        ;; 0b:5d62 ????????
    dw   .rezopolis_television_palette
    dw   $0000
    dw   .scream_tv_television_palette
    dw   .toon_tv_television_palette        ;; 0b:5d6a ????....
    dw   .bonus_tv_television_palette
    dw   $0000
    dw   .channel_z_television_palette
.scream_tv_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/scream_tv_television_palette.bin"
.toon_tv_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/toon_tv_television_palette.bin"
.prehistory_channel_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/prehistory_channel_television_palette.bin"
.circuit_central_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/circuit_central_television_palette.bin"
.kung_fu_theater_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/kung_fu_theater_television_palette.bin"
.channel_z_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/channel_z_television_palette.bin"
.rezopolis_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/rezopolis_television_palette.bin"
.bonus_tv_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/bonus_tv_television_palette.bin"


entry_0b_5df8:
call_0b_5df8:
    ld   A, [wD59E]                                    ;; 0b:5df8 $fa $9e $d5
    and  A, A                                          ;; 0b:5dfb $a7
    ret  Z                                             ;; 0b:5dfc $c8
    ld   A, [wD624_CurrentLevelId]                                    ;; 0b:5dfd $fa $24 $d6
    and  A, A                                          ;; 0b:5e00 $a7
    ret  NZ                                            ;; 0b:5e01 $c0
    ld   HL, wD72D_CurrentSpecialTilesetIndex                                     ;; 0b:5e02 $21 $2d $d7
    ld   L, [HL]                                       ;; 0b:5e05 $6e
    ld   H, $00                                        ;; 0b:5e06 $26 $00
    add  HL, HL                                        ;; 0b:5e08 $29
    ld   DE, .media_dimension_tv_palettes                             ;; 0b:5e09 $11 $1b $5e
    add  HL, DE                                        ;; 0b:5e0c $19
    ld   A, [HL+]                                      ;; 0b:5e0d $2a
    ld   H, [HL]                                       ;; 0b:5e0e $66
    ld   L, A                                          ;; 0b:5e0f $6f
    or   A, H                                          ;; 0b:5e10 $b4
    ret  Z                                             ;; 0b:5e11 $c8
    ld   DE, wD9FB                                     ;; 0b:5e12 $11 $fb $d9
    ld   BC, $10                                       ;; 0b:5e15 $01 $10 $00
    jp   call_00_07b0_CopyBytes                                  ;; 0b:5e18 $c3 $b0 $07
    
.media_dimension_tv_palettes:
    dw   .scream_tv_television_palette
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    db   $00, $00, $00, $00, $00, $00, $00, $00
    dw   .toon_tv_television_palette
    dw   .prehistory_channel_television_palette
    dw   .circuit_central_television_palette
    dw   .kung_fu_theater_television_palette
    dw   .channel_z_television_palette
    dw   .rezopolis_television_palette
    dw   .bonus_tv_television_palette
    
.scream_tv_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/scream_tv_television_palette.bin"
.toon_tv_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/toon_tv_television_palette.bin"
.prehistory_channel_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/prehistory_channel_television_palette.bin"
.circuit_central_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/circuit_central_television_palette.bin"
.kung_fu_theater_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/kung_fu_theater_television_palette.bin"
.channel_z_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/channel_z_television_palette.bin"
.rezopolis_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/rezopolis_television_palette.bin"
.bonus_tv_television_palette:
    INCBIN "../gfx/special_tilesets/media_dimension/palettes/bonus_tv_television_palette.bin"

entry_0b_5ec3:
    ld   A, [wD59E]                                    ;; 0b:5ec3 $fa $9e $d5
    and  A, A                                          ;; 0b:5ec6 $a7
    ret  Z                                             ;; 0b:5ec7 $c8
    ld   A, [wD73B]                                    ;; 0b:5ec8 $fa $3b $d7
    and  A, $1f                                        ;; 0b:5ecb $e6 $1f
    cp   A, $08                                        ;; 0b:5ecd $fe $08
    jr   C, .jr_0b_5eef                                ;; 0b:5ecf $38 $1e
    ld   HL, wD751                                     ;; 0b:5ed1 $21 $51 $d7
    ld   A, [HL+]                                      ;; 0b:5ed4 $2a
    or   A, [HL]                                       ;; 0b:5ed5 $b6
    ld   HL, .data_0b_5efb                             ;; 0b:5ed6 $21 $fb $5e
    jr   NZ, .jr_0b_5ef2                               ;; 0b:5ed9 $20 $17
    ld   HL, wD755                                     ;; 0b:5edb $21 $55 $d7
    ld   A, [HL+]                                      ;; 0b:5ede $2a
    or   A, [HL]                                       ;; 0b:5edf $b6
    ld   HL, .data_0b_5f03                             ;; 0b:5ee0 $21 $03 $5f
    jr   NZ, .jr_0b_5ef2                               ;; 0b:5ee3 $20 $0d
    ld   HL, wD753                                     ;; 0b:5ee5 $21 $53 $d7
    ld   A, [HL+]                                      ;; 0b:5ee8 $2a
    or   A, [HL]                                       ;; 0b:5ee9 $b6
    ld   HL, .data_0b_5f03                             ;; 0b:5eea $21 $03 $5f
    jr   NZ, .jr_0b_5ef2                               ;; 0b:5eed $20 $03
.jr_0b_5eef:
    ld   HL, .data_gex_object_palette                             ;; 0b:5eef $21 $13 $5f
.jr_0b_5ef2:
    ld   DE, wDA0B_Obj_Palettes                                     ;; 0b:5ef2 $11 $0b $da
    ld   BC, $08                                       ;; 0b:5ef5 $01 $08 $00
    jp   call_00_07b0_CopyBytes                                  ;; 0b:5ef8 $c3 $b0 $07
.data_0b_5efb:
    db   $00, $00, $64, $02, $f5, $3b, $ff, $43        ;; 0b:5efb ????????
.data_0b_5f03:
    db   $00, $00, $55, $01, $7f, $02, $ff, $03        ;; 0b:5f03 ????????
    db   $00, $00, $40, $45, $af, $7e, $f5, $7f        ;; 0b:5f0b ????????
.data_gex_object_palette:
    db   $00, $00, $00, $00, $8a, $02, $fd, $03        ;; 0b:5f13 ........
    
    ld   A, [wD59E]                                    ;; 0b:5f1b $fa $9e $d5
    and  A, A                                          ;; 0b:5f1e $a7
    ret  Z                                             ;; 0b:5f1f $c8
    ld   A, [wD742_PlayerCurrentFly]                                    ;; 0b:5f20 $fa $42 $d7
    dec  A                                             ;; 0b:5f23 $3d
    ld   L, A                                          ;; 0b:5f24 $6f
    ld   H, $00                                        ;; 0b:5f25 $26 $00
    add  HL, HL                                        ;; 0b:5f27 $29
    add  HL, HL                                        ;; 0b:5f28 $29
    add  HL, HL                                        ;; 0b:5f29 $29
    ld   DE, .data_0b_5f37                             ;; 0b:5f2a $11 $37 $5f
    add  HL, DE                                        ;; 0b:5f2d $19
    ld   DE, wDA1B                                     ;; 0b:5f2e $11 $1b $da
    ld   BC, $08                                       ;; 0b:5f31 $01 $08 $00
    jp   call_00_07b0_CopyBytes                                  ;; 0b:5f34 $c3 $b0 $07
.data_0b_5f37:
    db   $00, $00, $00, $00, $94, $52, $9c, $73        ;; 0b:5f37 ????????
    db   $00, $00, $00, $00, $14, $00, $1c, $00        ;; 0b:5f3f ????????
    db   $00, $00, $00, $00, $00, $50, $00, $70        ;; 0b:5f47 ????????
    db   $00, $00, $00, $00, $00, $03, $00, $03        ;; 0b:5f4f ????????

entry_0b_5f57:
    ld   A, [wD300]                                    ;; 0b:5f57 $fa $00 $d3
    rlca                                               ;; 0b:5f5a $07
    rlca                                               ;; 0b:5f5b $07
    rlca                                               ;; 0b:5f5c $07
    and  A, $07                                        ;; 0b:5f5d $e6 $07
    ld   L, A                                          ;; 0b:5f5f $6f
    ld   H, $00                                        ;; 0b:5f60 $26 $00
    ld   DE, wD32D                                     ;; 0b:5f62 $11 $2d $d3
    add  HL, DE                                        ;; 0b:5f65 $19
    ld   A, C                                          ;; 0b:5f66 $79
    ld   [HL], A                                       ;; 0b:5f67 $77
    ld   L, A                                          ;; 0b:5f68 $6f
    ld   H, $00                                        ;; 0b:5f69 $26 $00
    add  HL, HL                                        ;; 0b:5f6b $29
    add  HL, HL                                        ;; 0b:5f6c $29
    add  HL, HL                                        ;; 0b:5f6d $29
    ld   DE, wDA0B_Obj_Palettes                                     ;; 0b:5f6e $11 $0b $da
    add  HL, DE                                        ;; 0b:5f71 $19
    ld   E, L                                          ;; 0b:5f72 $5d
    ld   D, H                                          ;; 0b:5f73 $54
    ld   H, $d2                                        ;; 0b:5f74 $26 $d2
    ld   A, [wD300]                                    ;; 0b:5f76 $fa $00 $d3
    or   A, $00                                        ;; 0b:5f79 $f6 $00
    ld   L, A                                          ;; 0b:5f7b $6f
    ld   L, [HL]                                       ;; 0b:5f7c $6e
    ld   H, $00                                        ;; 0b:5f7d $26 $00
    add  HL, HL                                        ;; 0b:5f7f $29
    add  HL, HL                                        ;; 0b:5f80 $29
    add  HL, HL                                        ;; 0b:5f81 $29
    ld   BC, .data_object_palettes                             ;; 0b:5f82 $01 $9e $5f
    add  HL, BC                                        ;; 0b:5f85 $09
    ld   A, [HL+]                                      ;; 0b:5f86 $2a
    ld   [DE], A                                       ;; 0b:5f87 $12
    inc  DE                                            ;; 0b:5f88 $13
    ld   A, [HL+]                                      ;; 0b:5f89 $2a
    ld   [DE], A                                       ;; 0b:5f8a $12
    inc  DE                                            ;; 0b:5f8b $13
    ld   A, [HL+]                                      ;; 0b:5f8c $2a
    ld   [DE], A                                       ;; 0b:5f8d $12
    inc  DE                                            ;; 0b:5f8e $13
    ld   A, [HL+]                                      ;; 0b:5f8f $2a
    ld   [DE], A                                       ;; 0b:5f90 $12
    inc  DE                                            ;; 0b:5f91 $13
    ld   A, [HL+]                                      ;; 0b:5f92 $2a
    ld   [DE], A                                       ;; 0b:5f93 $12
    inc  DE                                            ;; 0b:5f94 $13
    ld   A, [HL+]                                      ;; 0b:5f95 $2a
    ld   [DE], A                                       ;; 0b:5f96 $12
    inc  DE                                            ;; 0b:5f97 $13
    ld   A, [HL+]                                      ;; 0b:5f98 $2a
    ld   [DE], A                                       ;; 0b:5f99 $12
    inc  DE                                            ;; 0b:5f9a $13
    ld   A, [HL]                                       ;; 0b:5f9b $7e
    ld   [DE], A                                       ;; 0b:5f9c $12
    ret                                                ;; 0b:5f9d $c9
.data_object_palettes:
    INCBIN "../gfx/object_sprites/object_palettes.bin"

entry_0b_641e:
    ld   HL, wD624_CurrentLevelId                                     ;; 0b:641e $21 $24 $d6
    ld   L, [HL]                                       ;; 0b:6421 $6e
    ld   H, $00                                        ;; 0b:6422 $26 $00
    add  HL, HL                                        ;; 0b:6424 $29
    ld   DE, .data_level_palette_ids                             ;; 0b:6425 $11 $35 $64
    add  HL, DE                                        ;; 0b:6428 $19
    ld   A, [HL+]                                      ;; 0b:6429 $2a
    ld   H, [HL]                                       ;; 0b:642a $66
    ld   L, A                                          ;; 0b:642b $6f
    ld   DE, wCF00_SpecialTilePaletteIds                                     ;; 0b:642c $11 $00 $cf
.jr_0b_642f:
    ld   A, [HL+]                                      ;; 0b:642f $2a
    ld   [DE], A                                       ;; 0b:6430 $12
    inc  E                                             ;; 0b:6431 $1c
    jr   NZ, .jr_0b_642f                               ;; 0b:6432 $20 $fb
    ret                                                ;; 0b:6434 $c9
.data_level_palette_ids:                                      ;; 0b:6435
    dw   palette_ids_media_dimension
    dw   palette_ids_toon_tv
    dw   palette_ids_scream_tv
    dw   palette_ids_scream_tv
    dw   palette_ids_circuit_central
    dw   palette_ids_kung_fu_theater
    dw   palette_ids_media_dimension
    dw   palette_ids_prehistory_channel
    dw   palette_ids_toon_tv
    dw   palette_ids_prehistory_channel
    dw   palette_ids_circuit_central
    dw   palette_ids_scream_tv
    dw   palette_ids_media_dimension
    dw   palette_ids_kung_fu_theater
    dw   palette_ids_rezopolis
    dw   palette_ids_media_dimension
    dw   palette_ids_scream_tv
    dw   palette_ids_media_dimension
    dw   palette_ids_media_dimension
    dw   palette_ids_media_dimension
    dw   palette_ids_media_dimension
    dw   palette_ids_kung_fu_theater
    dw   palette_ids_rezopolis
    dw   palette_ids_circuit_central
    dw   palette_ids_prehistory_channel
    dw   palette_ids_scream_tv
    dw   palette_ids_rezopolis
    dw   palette_ids_media_dimension
    dw   palette_ids_media_dimension
    dw   palette_ids_media_dimension
    dw   palette_ids_channel_z

palette_ids_media_dimension:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_media_dimension.bin"
palette_ids_toon_tv:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_toon_tv.bin"
palette_ids_scream_tv:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_scream_tv.bin"
palette_ids_circuit_central:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_circuit_central.bin"
palette_ids_kung_fu_theater:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_kung_fu_theater.bin"
palette_ids_prehistory_channel:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_prehistory_channel.bin"
palette_ids_rezopolis:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_rezopolis.bin"
palette_ids_channel_z:
    INCBIN "../gfx/tilesets/palette_ids/palette_ids_channel_z.bin"
