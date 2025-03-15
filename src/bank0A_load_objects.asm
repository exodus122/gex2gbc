;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "bank0a", ROMX[$4000], BANK[$0a]

; This file handles loading objects (other than Gex).
; It contains a list of objects to load on each level.

entry_0a_4000:
call_0a_4000:
    ld   HL, wD624_CurrentLevelId                                     ;; 0a:4000 $21 $24 $d6
    ld   L, [HL]                                       ;; 0a:4003 $6e ; L = current level
    ld   H, $00                                        ;; 0a:4004 $26 $00
    add  HL, HL                                        ;; 0a:4006 $29 ; multiply by 2?
    ld   DE, .data_0a_4019                             ;; 0a:4007 $11 $19 $40
    add  HL, DE                                        ;; 0a:400a $19
    ld   A, [HL+]                                      ;; 0a:400b $2a
    ld   [wD336], A                                    ;; 0a:400c $ea $36 $d3
    ld   A, [HL+]                                      ;; 0a:400f $2a
    ld   [wD337], A                                    ;; 0a:4010 $ea $37 $d3
    ld   A, $01                                        ;; 0a:4013 $3e $01
    ld   [wD338], A                                    ;; 0a:4015 $ea $38 $d3
    ret                                                ;; 0a:4018 $c9

.data_0a_4019:
    dw   data_MediaDimensionObjects
    dw   data_OutOfToonObjects
    dw   data_SmellraiserObjects
    dw   data_FrankensteinfeldObjects
    dw   data_wwwdotcomcomObjects
    dw   data_MaoTseTongueObjects
    dw   data_Pangaea90210_Objects
    dw   data_Pangaea90210_Objects
    dw   data_FineTooningObjects
    dw   data_ThisOldCaveObjects
    dw   data_HoneyIShrunkTheGeckoObjects
    dw   data_PoltergexObjects
    dw   data_SamuraiNightFeverObjects
    dw   data_SamuraiNightFeverObjects
    dw   data_NoWeddingsAndAFuneralObjects
    dw   data_ThursdayThe12thObjects
    dw   data_ThursdayThe12thObjects
    dw   data_MediaDimensionObjects
    dw   data_MediaDimensionObjects
    dw   data_MediaDimensionObjects
    dw   data_MediaDimensionObjects
    dw   data_LizardInAChinaShopObjects
    dw   data_BuggedOutObjects
    dw   data_ChipsAndDipsObjects
    dw   data_LavaDabbaDooObjects
    dw   data_TexasChainsawManicureObjects
    dw   data_MazedAndConfusedObjects
    dw   data_MediaDimensionObjects
    dw   data_MediaDimensionObjects
    dw   data_MediaDimensionObjects
    dw   data_ChannelZObjects

data_MediaDimensionObjects:
INCLUDE "./maps/media_dimension/object_list_media_dimension.asm"

data_OutOfToonObjects:
INCLUDE "./maps/toon_tv/object_list_out_of_toon.asm"

data_SmellraiserObjects:
INCLUDE "./maps/scream_tv/object_list_smellraiser.asm"

data_FrankensteinfeldObjects:
INCLUDE "./maps/scream_tv/object_list_frankensteinfeld.asm"

data_wwwdotcomcomObjects:
INCLUDE "./maps/circuit_central/object_list_wwwdotcomcom.asm"

data_MaoTseTongueObjects:
INCLUDE "./maps/kung_fu_theater/object_list_mao_tse_tongue.asm"

data_Pangaea90210_Objects:
INCLUDE "./maps/prehistory_channel/object_list_pangaea90210.asm"

data_FineTooningObjects:
INCLUDE "./maps/toon_tv/object_list_fine_tooning.asm"

data_ThisOldCaveObjects:
INCLUDE "./maps/prehistory_channel/object_list_this_old_cave.asm"

data_HoneyIShrunkTheGeckoObjects:
INCLUDE "./maps/circuit_central/object_list_honey_i_shrunk_the_gecko.asm"
    
data_PoltergexObjects:
INCLUDE "./maps/scream_tv/object_list_poltergex.asm"

data_SamuraiNightFeverObjects:
INCLUDE "./maps/kung_fu_theater/object_list_samurai_night_fever.asm"

data_NoWeddingsAndAFuneralObjects:
INCLUDE "./maps/rezopolis/object_list_no_weddings_and_a_funeral.asm"

data_ThursdayThe12thObjects:
INCLUDE "./maps/scream_tv/object_list_thursday_the_12th.asm"

data_LizardInAChinaShopObjects:
INCLUDE "./maps/kung_fu_theater/object_list_lizard_in_a_china_shop.asm"

data_BuggedOutObjects:
INCLUDE "./maps/rezopolis/object_list_bugged_out.asm"

data_ChipsAndDipsObjects:
INCLUDE "./maps/circuit_central/object_list_chips_and_dips.asm"

data_LavaDabbaDooObjects:
INCLUDE "./maps/prehistory_channel/object_list_lava_dabba_doo.asm"

data_TexasChainsawManicureObjects:
INCLUDE "./maps/scream_tv/object_list_texas_chainsaw_manicure.asm"
    
data_MazedAndConfusedObjects:
INCLUDE "./maps/rezopolis/object_list_mazed_and_confused.asm"

data_ChannelZObjects:
INCLUDE "./maps/channel_z/object_list_channel_z.asm"

data_0a_75fc:
    db   $00                                           ;; 0a:75fc ?
data_0a_75fd:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:75fd ????????
    db   $2c, $10, $01, $00, $01, $00, $00, $00        ;; 0a:7605 ????????
    db   $08, $08, $02, $00, $02, $00, $00, $70        ;; 0a:760d ???????.
    db   $08, $08, $83, $00, $06, $00, $00, $70        ;; 0a:7615 ....w??.
    db   $00, $00, $00, $00, $07, $00, $00, $00        ;; 0a:761d ....w???
    db   $10, $10, $07, $00, $07, $00, $00, $00        ;; 0a:7625 ????????
    db   $10, $10, $08, $00, $07, $00, $00, $00        ;; 0a:762d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7635 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $40        ;; 0a:763d ????????
    db   $10, $10, $83, $01, $05, $00, $00, $70        ;; 0a:7645 ???????.
    db   $10, $10, $84, $01, $04, $00, $00, $00        ;; 0a:764d ...ww???
    db   $10, $10, $03, $24, $05, $00, $00, $00        ;; 0a:7655 ???????.
    db   $10, $10, $06, $00, $07, $00, $00, $28        ;; 0a:765d ....w???
    db   $0c, $10, $06, $00, $07, $00, $00, $40        ;; 0a:7665 ????????
    db   $08, $10, $06, $33, $07, $00, $00, $00        ;; 0a:766d ????????
    db   $10, $10, $0c, $00, $06, $00, $00, $00        ;; 0a:7675 ????????
    db   $0c, $0c, $06, $00, $07, $00, $00, $00        ;; 0a:767d ????????
    db   $04, $04, $13, $00, $06, $00, $00, $00        ;; 0a:7685 ????????
    db   $0c, $10, $0b, $00, $07, $00, $00, $00        ;; 0a:768d ????????
    db   $10, $10, $0e, $00, $06, $00, $00, $40        ;; 0a:7695 ????????
    db   $08, $08, $09, $01, $03, $00, $00, $00        ;; 0a:769d ????????
    db   $20, $40, $0a, $02, $05, $00, $00, $00        ;; 0a:76a5 ????????
    db   $10, $08, $06, $00, $07, $00, $00, $50        ;; 0a:76ad ????????
    db   $10, $10, $84, $24, $05, $00, $00, $00        ;; 0a:76b5 ????????
    db   $00, $00, $00, $00, $07, $00, $00, $10        ;; 0a:76bd ????????
    db   $0c, $10, $0d, $00, $07, $00, $00, $50        ;; 0a:76c5 ????????
    db   $0c, $10, $06, $01, $05, $00, $00, $00        ;; 0a:76cd ????????
    db   $10, $10, $84, $01, $04, $00, $00, $50        ;; 0a:76d5 ????????
    db   $12, $10, $84, $01, $04, $00, $00, $00        ;; 0a:76dd ???????.
    db   $10, $10, $0f, $03, $07, $00, $00, $00        ;; 0a:76e5 .w.ww???
    db   $10, $08, $09, $05, $07, $00, $00, $00        ;; 0a:76ed ????????
    db   $08, $08, $09, $04, $07, $00, $00, $00        ;; 0a:76f5 ???????.
    db   $0c, $10, $06, $0f, $07, $00, $00, $88        ;; 0a:76fd ...ww???
    db   $0c, $10, $0f, $07, $07, $00, $00, $00        ;; 0a:7705 ???????.
    db   $0c, $10, $06, $06, $07, $00, $00, $00        ;; 0a:770d ...ww???
    db   $10, $10, $0f, $0e, $05, $00, $00, $00        ;; 0a:7715 ???????.
    db   $0c, $0a, $06, $0d, $05, $00, $00, $00        ;; 0a:771d ...ww??.
    db   $10, $10, $00, $08, $07, $00, $00, $00        ;; 0a:7725 ...ww???
    db   $0a, $10, $10, $00, $07, $00, $00, $00        ;; 0a:772d ???????.
    db   $0c, $08, $11, $0b, $05, $00, $00, $00        ;; 0a:7735 ...ww???
    db   $04, $08, $00, $23, $05, $00, $00, $00        ;; 0a:773d ...ww???
    db   $10, $08, $06, $09, $07, $00, $00, $00        ;; 0a:7745 ???????.
    db   $0c, $10, $06, $00, $07, $00, $00, $70        ;; 0a:774d ....w???
    db   $08, $10, $83, $10, $05, $00, $00, $70        ;; 0a:7755 ????????
    db   $08, $10, $84, $10, $05, $00, $00, $70        ;; 0a:775d ???????.
    db   $10, $10, $84, $0a, $04, $00, $00, $00        ;; 0a:7765 ...ww??.
    db   $10, $10, $84, $0c, $05, $00, $00, $00        ;; 0a:776d ...ww???
    db   $0a, $08, $0f, $00, $06, $00, $00, $00        ;; 0a:7775 .w..w???
    db   $10, $10, $09, $0a, $06, $00, $00, $00        ;; 0a:777d ????????
    db   $04, $08, $1f, $34, $05, $00, $00, $00        ;; 0a:7785 ????????
    db   $0c, $10, $06, $00, $07, $00, $00, $00        ;; 0a:778d ????????
    db   $10, $10, $06, $00, $07, $00, $00, $00        ;; 0a:7795 ????????
    db   $08, $08, $06, $00, $07, $00, $00, $00        ;; 0a:779d ????????
    db   $08, $20, $1a, $25, $07, $00, $00, $00        ;; 0a:77a5 ????????
    db   $10, $10, $83, $11, $05, $00, $00, $00        ;; 0a:77ad ????????
    db   $04, $06, $09, $12, $05, $00, $00, $70        ;; 0a:77b5 ????????
    db   $10, $08, $84, $20, $04, $00, $00, $70        ;; 0a:77bd ????????
    db   $0c, $0b, $84, $20, $04, $00, $00, $00        ;; 0a:77c5 ????????
    db   $10, $0c, $84, $20, $04, $00, $00, $00        ;; 0a:77cd ????????
    db   $0c, $10, $84, $20, $04, $00, $00, $00        ;; 0a:77d5 ????????
    db   $10, $10, $06, $00, $07, $00, $00, $00        ;; 0a:77dd ????????
    db   $0c, $10, $0f, $13, $07, $00, $00, $40        ;; 0a:77e5 ????????
    db   $0c, $10, $0f, $13, $07, $00, $00, $00        ;; 0a:77ed ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:77f5 ????????
    db   $08, $08, $06, $1e, $07, $00, $00, $00        ;; 0a:77fd ????????
    db   $08, $08, $06, $1e, $07, $00, $00, $00        ;; 0a:7805 ????????
    db   $08, $0c, $06, $1e, $07, $00, $00, $00        ;; 0a:780d ????????
    db   $0c, $08, $06, $14, $05, $00, $00, $00        ;; 0a:7815 ????????
    db   $04, $04, $13, $00, $04, $00, $00, $00        ;; 0a:781d ????????
    db   $08, $10, $1a, $21, $07, $00, $00, $00        ;; 0a:7825 ????????
    db   $10, $0c, $84, $20, $04, $00, $00, $00        ;; 0a:782d ????????
    db   $10, $10, $06, $00, $07, $00, $00, $00        ;; 0a:7835 ????????
    db   $10, $10, $1b, $22, $07, $00, $00, $00        ;; 0a:783d ????????
    db   $00, $00, $00, $00, $07, $00, $00, $00        ;; 0a:7845 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:784d ????????
    db   $10, $08, $16, $1a, $05, $00, $00, $00        ;; 0a:7855 ????????
    db   $10, $08, $20, $18, $06, $00, $00, $00        ;; 0a:785d ????????
    db   $08, $08, $00, $18, $06, $00, $00, $00        ;; 0a:7865 ????????
    db   $10, $10, $06, $00, $07, $00, $00, $70        ;; 0a:786d ????????
    db   $08, $08, $09, $19, $07, $00, $00, $00        ;; 0a:7875 ????????
    db   $0c, $0c, $09, $00, $07, $00, $00, $00        ;; 0a:787d ????????
    db   $08, $0c, $09, $1f, $07, $00, $00, $00        ;; 0a:7885 ????????
    db   $08, $08, $23, $19, $07, $00, $00, $40        ;; 0a:788d ????????
    db   $0a, $10, $15, $18, $07, $00, $00, $40        ;; 0a:7895 ????????
    db   $0a, $10, $15, $18, $07, $00, $00, $00        ;; 0a:789d ????????
    db   $0c, $10, $18, $18, $07, $00, $00, $00        ;; 0a:78a5 ????????
    db   $06, $06, $00, $00, $06, $00, $00, $00        ;; 0a:78ad ????????
    db   $10, $08, $06, $17, $07, $00, $00, $00        ;; 0a:78b5 ????????
    db   $04, $04, $09, $18, $06, $00, $00, $00        ;; 0a:78bd ????????
    db   $10, $04, $09, $1d, $04, $00, $00, $00        ;; 0a:78c5 ????????
    db   $0c, $10, $14, $15, $04, $00, $00, $00        ;; 0a:78cd ????????
    db   $0c, $10, $14, $16, $04, $00, $00, $00        ;; 0a:78d5 ????????
    db   $18, $08, $09, $1b, $07, $00, $00, $00        ;; 0a:78dd ????????
    db   $08, $20, $09, $1b, $07, $00, $00, $70        ;; 0a:78e5 ????????
    db   $10, $08, $84, $1d, $04, $00, $00, $70        ;; 0a:78ed ????????
    db   $10, $08, $84, $1d, $04, $00, $00, $00        ;; 0a:78f5 ????????
    db   $10, $08, $84, $1c, $04, $00, $00, $70        ;; 0a:78fd ????????
    db   $10, $08, $84, $1c, $04, $00, $00, $00        ;; 0a:7905 ????????
    db   $10, $08, $83, $1c, $04, $00, $00, $00        ;; 0a:790d ????????
    db   $00, $00, $00, $00, $04, $00, $00, $00        ;; 0a:7915 ????????
    db   $0c, $08, $84, $26, $04, $00, $00, $70        ;; 0a:791d ????????
    db   $0c, $08, $84, $26, $04, $00, $00, $70        ;; 0a:7925 ????????
    db   $0c, $08, $84, $26, $04, $00, $00, $00        ;; 0a:792d ????????
    db   $0c, $08, $84, $26, $04, $00, $00, $00        ;; 0a:7935 ????????
    db   $0c, $08, $84, $26, $04, $00, $00, $00        ;; 0a:793d ????????
    db   $0c, $04, $84, $29, $05, $00, $00, $00        ;; 0a:7945 ????????
    db   $0c, $08, $1c, $2a, $07, $00, $00, $00        ;; 0a:794d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7955 ????????
    db   $08, $10, $09, $27, $05, $00, $00, $00        ;; 0a:795d ????????
    db   $08, $20, $09, $27, $05, $00, $00, $00        ;; 0a:7965 ????????
    db   $10, $10, $06, $00, $07, $00, $00, $00        ;; 0a:796d ????????
    db   $00, $00, $00, $2b, $05, $00, $00, $00        ;; 0a:7975 ????????
    db   $00, $00, $00, $2b, $05, $00, $00, $40        ;; 0a:797d ????????
    db   $0c, $0c, $06, $00, $07, $00, $00, $00        ;; 0a:7985 ????????
    db   $04, $10, $09, $28, $07, $00, $00, $40        ;; 0a:798d ????????
    db   $10, $08, $06, $00, $07, $00, $00, $00        ;; 0a:7995 ????????
    db   $0c, $0c, $06, $38, $05, $00, $00, $40        ;; 0a:799d ????????
    db   $00, $00, $00, $00, $06, $00, $00, $00        ;; 0a:79a5 ????????
    db   $0c, $0c, $06, $2c, $07, $00, $00, $00        ;; 0a:79ad ????????
    db   $08, $10, $06, $2d, $05, $00, $00, $60        ;; 0a:79b5 ????????
    db   $08, $08, $22, $2e, $05, $00, $00, $00        ;; 0a:79bd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0a:79c5 ????????
    db   $0c, $08, $06, $2f, $07, $00, $00, $00        ;; 0a:79cd ????????
    db   $00, $00, $00, $2f, $06, $00, $00, $70        ;; 0a:79d5 ????????
    db   $08, $08, $1d, $30, $05, $00, $00, $40        ;; 0a:79dd ????????
    db   $10, $08, $84, $31, $04, $00, $00, $70        ;; 0a:79e5 ????????
    db   $10, $08, $84, $31, $04, $00, $00, $00        ;; 0a:79ed ????????
    db   $10, $08, $84, $31, $04, $00, $00, $00        ;; 0a:79f5 ????????
    db   $0c, $0c, $06, $00, $07, $00, $00, $40        ;; 0a:79fd ????????
    db   $10, $10, $21, $00, $07, $00, $00, $40        ;; 0a:7a05 ????????
    db   $10, $08, $85, $00, $07, $00, $00, $60        ;; 0a:7a0d ????????
    db   $08, $08, $00, $32, $05, $00, $00, $60        ;; 0a:7a15 ????????
    db   $08, $08, $00, $32, $05, $00, $00, $60        ;; 0a:7a1d ????????
    db   $08, $08, $00, $32, $05, $00, $00, $10        ;; 0a:7a25 ????????
    db   $10, $10, $24, $00, $07, $00, $00, $70        ;; 0a:7a2d ????????
    db   $10, $08, $84, $32, $04, $00, $00, $00        ;; 0a:7a35 ????????
    db   $10, $08, $84, $32, $04, $00, $00, $00        ;; 0a:7a3d ????????
    db   $08, $08, $00, $32, $06, $00, $00, $00        ;; 0a:7a45 ????????
    db   $08, $08, $09, $32, $03, $00, $00, $00        ;; 0a:7a4d ????????
    db   $10, $10, $00, $37, $05, $00, $00, $40        ;; 0a:7a55 ????????
    db   $08, $08, $83, $39, $04, $00, $00, $00        ;; 0a:7a5d ????????
    db   $10, $10, $00, $00, $07, $00, $00, $00        ;; 0a:7a65 ????????
    db   $00, $00, $00, $00, $07, $00, $00, $70        ;; 0a:7a6d ???????.
    db   $10, $08, $84, $35, $05, $00, $00             ;; 0a:7a75 ...ww??

entry_0a_7a7c:
    ld   H, $d2                                        ;; 0a:7a7c $26 $d2
    ld   A, $20                                        ;; 0a:7a7e $3e $20
.jr_0a_7a80:
    ld   L, A                                          ;; 0a:7a80 $6f ; L = 0x20
    ld   A, [HL]                                       ;; 0a:7a81 $7e ; load from $d2xx, start at $d220
    cp   A, $ff                                        ;; 0a:7a82 $fe $ff ; if loaded value is ff, then jump
    jr   Z, .jr_0a_7a8c                                ;; 0a:7a84 $28 $06
    ld   A, L                                          ;; 0a:7a86 $7d
    add  A, $20                                        ;; 0a:7a87 $c6 $20
    jr   NZ, .jr_0a_7a80                               ;; 0a:7a89 $20 $f5
    ret                                                ;; 0a:7a8b $c9
.jr_0a_7a8c: ; jump here if the value was 0xff. so basically it is looping through 7 sets of 32 bytes looking for a free slot (ff)
    ld   A, L                                          ;; 0a:7a8c $7d
    ld   [wD300], A                                    ;; 0a:7a8d $ea $00 $d3 ; so d300 is the address of the ff byte it found
    rlca                                               ;; 0a:7a90 $07
    rlca                                               ;; 0a:7a91 $07
    rlca                                               ;; 0a:7a92 $07 so now a is the slot number, where slot 1 is dd20, and slot 3 is dd60
    ld   [wD339], A                                    ;; 0a:7a93 $ea $39 $d3
    ld   HL, wD336                                     ;; 0a:7a96 $21 $36 $d3
    ld   E, [HL]                                       ;; 0a:7a99 $5e
    inc  HL                                            ;; 0a:7a9a $23
    ld   D, [HL]                                       ;; 0a:7a9b $56
    ld   A, [DE]                                       ;; 0a:7a9c $1a ; load first byte from data
    cp   A, $ff                                        ;; 0a:7a9d $fe $ff
    jp   Z, call_0a_4000                                 ;; 0a:7a9f $ca $00 $40
    ld   [wD33B], A                                    ;; 0a:7aa2 $ea $3b $d3 ; first byte from data
    ld   HL, $10                                       ;; 0a:7aa5 $21 $10 $00
    add  HL, DE                                        ;; 0a:7aa8 $19
    ld   A, L                                          ;; 0a:7aa9 $7d
    ld   [wD336], A                                    ;; 0a:7aaa $ea $36 $d3
    ld   A, H                                          ;; 0a:7aad $7c
    ld   [wD337], A                                    ;; 0a:7aae $ea $37 $d3 ; load 2 bytes 0x10 after first
    ld   HL, wD338                                     ;; 0a:7ab1 $21 $38 $d3 
    ld   C, [HL]                                       ;; 0a:7ab4 $4e 
    inc  [HL]                                          ;; 0a:7ab5 $34
    ld   B, $d0                                        ;; 0a:7ab6 $06 $d0
    ld   A, [BC]                                       ;; 0a:7ab8 $0a
    and  A, A                                          ;; 0a:7ab9 $a7
    ret  NZ                                            ;; 0a:7aba $c0
    ld   A, C                                          ;; 0a:7abb $79
    ld   [wD33A], A                                    ;; 0a:7abc $ea $3a $d3
    inc  DE                                            ;; 0a:7abf $13
    ld   H, $d2                                        ;; 0a:7ac0 $26 $d2
    ld   A, [wD300]                                    ;; 0a:7ac2 $fa $00 $d3
    or   A, $0e                                        ;; 0a:7ac5 $f6 $0e
    ld   L, A                                          ;; 0a:7ac7 $6f
    ld   A, [DE]                                       ;; 0a:7ac8 $1a
    ld   [HL+], A                                      ;; 0a:7ac9 $22
    inc  DE                                            ;; 0a:7aca $13
    ld   A, [DE]                                       ;; 0a:7acb $1a
    ld   [HL+], A                                      ;; 0a:7acc $22
    inc  DE                                            ;; 0a:7acd $13
    ld   A, [DE]                                       ;; 0a:7ace $1a
    ld   [HL+], A                                      ;; 0a:7acf $22
    inc  DE                                            ;; 0a:7ad0 $13
    ld   A, [DE]                                       ;; 0a:7ad1 $1a
    ld   [HL], A                                       ;; 0a:7ad2 $77
    inc  DE                                            ;; 0a:7ad3 $13
    ld   HL, wD339                                     ;; 0a:7ad4 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7ad7 $6e
    ld   H, $00                                        ;; 0a:7ad8 $26 $00
    add  HL, HL                                        ;; 0a:7ada $29
    add  HL, HL                                        ;; 0a:7adb $29
    ld   BC, wD309                                     ;; 0a:7adc $01 $09 $d3
    add  HL, BC                                        ;; 0a:7adf $09
    ld   A, [DE]                                       ;; 0a:7ae0 $1a
    ld   [HL+], A                                      ;; 0a:7ae1 $22
    inc  DE                                            ;; 0a:7ae2 $13
    ld   A, [DE]                                       ;; 0a:7ae3 $1a
    ld   [HL+], A                                      ;; 0a:7ae4 $22
    inc  DE                                            ;; 0a:7ae5 $13
    ld   A, [DE]                                       ;; 0a:7ae6 $1a
    ld   [HL+], A                                      ;; 0a:7ae7 $22
    inc  DE                                            ;; 0a:7ae8 $13
    ld   A, [DE]                                       ;; 0a:7ae9 $1a
    ld   [HL+], A                                      ;; 0a:7aea $22
    inc  DE                                            ;; 0a:7aeb $13
    push DE                                            ;; 0a:7aec $d5
    ld   [wD59D], A                                    ;; 0a:7aed $ea $9d $d5
    ld   A, Bank00                                        ;; 0a:7af0 $3e $00
    ld   HL, call_00_350c                              ;; 0a:7af2 $21 $0c $35
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7af5 $cd $78 $10
    pop  DE                                            ;; 0a:7af8 $d1
    ret  C                                             ;; 0a:7af9 $d8
    push DE                                            ;; 0a:7afa $d5
    ld   A, [wD300]                                    ;; 0a:7afb $fa $00 $d3
    or   A, $00                                        ;; 0a:7afe $f6 $00
    ld   E, A                                          ;; 0a:7b00 $5f
    ld   D, $d2                                        ;; 0a:7b01 $16 $d2
    ld   A, [wD33B]                                    ;; 0a:7b03 $fa $3b $d3
    ld   [DE], A                                       ;; 0a:7b06 $12
    ld   L, A                                          ;; 0a:7b07 $6f
    ld   H, $00                                        ;; 0a:7b08 $26 $00
    add  HL, HL                                        ;; 0a:7b0a $29
    add  HL, HL                                        ;; 0a:7b0b $29
    add  HL, HL                                        ;; 0a:7b0c $29
    ld   BC, data_0a_75fc                             ;; 0a:7b0d $01 $fc $75
    add  HL, BC                                        ;; 0a:7b10 $09
    ld   C, L                                          ;; 0a:7b11 $4d
    ld   B, H                                          ;; 0a:7b12 $44
    pop  HL                                            ;; 0a:7b13 $e1
    ld   A, E                                          ;; 0a:7b14 $7b
    xor  A, $17                                        ;; 0a:7b15 $ee $17
    ld   E, A                                          ;; 0a:7b17 $5f
    xor  A, A                                          ;; 0a:7b18 $af
    ld   [DE], A                                       ;; 0a:7b19 $12
    inc  E                                             ;; 0a:7b1a $1c
    ld   A, [BC]                                       ;; 0a:7b1b $0a
    inc  BC                                            ;; 0a:7b1c $03
    push BC                                            ;; 0a:7b1d $c5
    ld   B, A                                          ;; 0a:7b1e $47
    ld   C, $08                                        ;; 0a:7b1f $0e $08
.jr_0a_7b21:
    xor  A, A                                          ;; 0a:7b21 $af
    ld   [DE], A                                       ;; 0a:7b22 $12
    bit  7, B                                          ;; 0a:7b23 $cb $78
    jr   Z, .jr_0a_7b29                                ;; 0a:7b25 $28 $02
    ld   A, [HL+]                                      ;; 0a:7b27 $2a
    ld   [DE], A                                       ;; 0a:7b28 $12
.jr_0a_7b29:
    inc  E                                             ;; 0a:7b29 $1c
    sla  B                                             ;; 0a:7b2a $cb $20
    dec  C                                             ;; 0a:7b2c $0d
    jr   NZ, .jr_0a_7b21                               ;; 0a:7b2d $20 $f2
    ld   A, [wD300]                                    ;; 0a:7b2f $fa $00 $d3
    or   A, $14                                        ;; 0a:7b32 $f6 $14
    ld   E, A                                          ;; 0a:7b34 $5f
    pop  HL                                            ;; 0a:7b35 $e1
    ld   A, [HL+]                                      ;; 0a:7b36 $2a
    ld   [DE], A                                       ;; 0a:7b37 $12
    inc  E                                             ;; 0a:7b38 $1c
    ld   A, [HL+]                                      ;; 0a:7b39 $2a
    ld   [DE], A                                       ;; 0a:7b3a $12
    inc  E                                             ;; 0a:7b3b $1c
    ld   A, [HL+]                                      ;; 0a:7b3c $2a
    ld   [DE], A                                       ;; 0a:7b3d $12
    push HL                                            ;; 0a:7b3e $e5
    ld   A, E                                          ;; 0a:7b3f $7b
    xor  A, $1b                                        ;; 0a:7b40 $ee $1b
    ld   E, A                                          ;; 0a:7b42 $5f
    ld   A, $00                                        ;; 0a:7b43 $3e $00
    ld   [DE], A                                       ;; 0a:7b45 $12
    ld   HL, wD339                                     ;; 0a:7b46 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7b49 $6e
    ld   H, $00                                        ;; 0a:7b4a $26 $00
    ld   DE, wD301                                     ;; 0a:7b4c $11 $01 $d3
    add  HL, DE                                        ;; 0a:7b4f $19
    ld   A, [wD33A]                                    ;; 0a:7b50 $fa $3a $d3
    ld   [HL], A                                       ;; 0a:7b53 $77
    ld   L, A                                          ;; 0a:7b54 $6f
    ld   H, $d0                                        ;; 0a:7b55 $26 $d0
    ld   [HL], $01                                     ;; 0a:7b57 $36 $01
    xor  A, A                                          ;; 0a:7b59 $af
    ld   [wD59D], A                                    ;; 0a:7b5a $ea $9d $d5
    ld   A, Bank02                                        ;; 0a:7b5d $3e $02
    ld   HL, entry_02_7102                             ;; 0a:7b5f $21 $02 $71
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7b62 $cd $78 $10
    ld   HL, wD339                                     ;; 0a:7b65 $21 $39 $d3
    ld   L, [HL]                                       ;; 0a:7b68 $6e
    ld   H, $00                                        ;; 0a:7b69 $26 $00
    add  HL, HL                                        ;; 0a:7b6b $29
    add  HL, HL                                        ;; 0a:7b6c $29
    ld   DE, data_00_39c0                                     ;; 0a:7b6d $11 $c0 $39
    add  HL, DE                                        ;; 0a:7b70 $19
    ld   A, [HL+]                                      ;; 0a:7b71 $2a
    ld   H, [HL]                                       ;; 0a:7b72 $66
    ld   L, A                                          ;; 0a:7b73 $6f
    ld   [HL], $00                                     ;; 0a:7b74 $36 $00
    pop  HL                                            ;; 0a:7b76 $e1
    ld   A, [HL+]                                      ;; 0a:7b77 $2a
    push HL                                            ;; 0a:7b78 $e5
    and  A, A                                          ;; 0a:7b79 $a7
    jr   Z, .jr_0a_7b87                                ;; 0a:7b7a $28 $0b
    ld   [wD59D], A                                    ;; 0a:7b7c $ea $9d $d5
    ld   A, Bank02                                        ;; 0a:7b7f $3e $02
    ld   HL, entry_02_7211                             ;; 0a:7b81 $21 $11 $72
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7b84 $cd $78 $10
.jr_0a_7b87:
    pop  HL                                            ;; 0a:7b87 $e1
    ld   A, [wD59E]                                    ;; 0a:7b88 $fa $9e $d5
    and  A, A                                          ;; 0a:7b8b $a7
    ret  Z                                             ;; 0a:7b8c $c8
    ld   C, [HL]                                       ;; 0a:7b8d $4e
    ld   [wD59D], A                                    ;; 0a:7b8e $ea $9d $d5
    ld   A, Bank0b                                        ;; 0a:7b91 $3e $0b
    ld   HL, entry_0b_5f57                             ;; 0a:7b93 $21 $57 $5f
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7b96 $cd $78 $10
    ret                                                ;; 0a:7b99 $c9

entry_0a_7b9a:
    ld   D, $d2                                        ;; 0a:7b9a $16 $d2
    ld   A, $20                                        ;; 0a:7b9c $3e $20
.jr_0a_7b9e:
    ld   E, A                                          ;; 0a:7b9e $5f
    ld   A, [DE]                                       ;; 0a:7b9f $1a
    cp   A, $ff                                        ;; 0a:7ba0 $fe $ff
    jr   Z, .jr_0a_7baa                                ;; 0a:7ba2 $28 $06
    ld   A, E                                          ;; 0a:7ba4 $7b
    add  A, $20                                        ;; 0a:7ba5 $c6 $20
    jr   NZ, .jr_0a_7b9e                               ;; 0a:7ba7 $20 $f5
    ret                                                ;; 0a:7ba9 $c9
.jr_0a_7baa:
    ld   HL, wD300                                     ;; 0a:7baa $21 $00 $d3
    ld   A, [HL]                                       ;; 0a:7bad $7e
    ld   [HL], E                                       ;; 0a:7bae $73
    push AF                                            ;; 0a:7baf $f5
    ld   H, $d2                                        ;; 0a:7bb0 $26 $d2
    or   A, $0e                                        ;; 0a:7bb2 $f6 $0e
    ld   L, A                                          ;; 0a:7bb4 $6f
    ld   D, H                                          ;; 0a:7bb5 $54
    ld   A, E                                          ;; 0a:7bb6 $7b
    or   A, $0e                                        ;; 0a:7bb7 $f6 $0e
    ld   E, A                                          ;; 0a:7bb9 $5f
    push BC                                            ;; 0a:7bba $c5
    ld   B, H                                          ;; 0a:7bbb $44
    xor  A, $16                                        ;; 0a:7bbc $ee $16
    ld   C, A                                          ;; 0a:7bbe $4f
.jr_0a_7bbf:
    ld   A, [HL+]                                      ;; 0a:7bbf $2a
    ld   [DE], A                                       ;; 0a:7bc0 $12
    ld   [BC], A                                       ;; 0a:7bc1 $02
    inc  E                                             ;; 0a:7bc2 $1c
    inc  C                                             ;; 0a:7bc3 $0c
    ld   A, L                                          ;; 0a:7bc4 $7d
    and  A, $1f                                        ;; 0a:7bc5 $e6 $1f
    cp   A, $12                                        ;; 0a:7bc7 $fe $12
    jr   NZ, .jr_0a_7bbf                               ;; 0a:7bc9 $20 $f4
    xor  A, A                                          ;; 0a:7bcb $af
    ld   [BC], A                                       ;; 0a:7bcc $02
    inc  C                                             ;; 0a:7bcd $0c
    ld   [BC], A                                       ;; 0a:7bce $02
    inc  C                                             ;; 0a:7bcf $0c
    ld   [BC], A                                       ;; 0a:7bd0 $02
    inc  C                                             ;; 0a:7bd1 $0c
    ld   [BC], A                                       ;; 0a:7bd2 $02
    pop  BC                                            ;; 0a:7bd3 $c1
    ld   A, L                                          ;; 0a:7bd4 $7d
    xor  A, $1f                                        ;; 0a:7bd5 $ee $1f
    ld   L, A                                          ;; 0a:7bd7 $6f
    ld   A, E                                          ;; 0a:7bd8 $7b
    xor  A, $1f                                        ;; 0a:7bd9 $ee $1f
    ld   E, A                                          ;; 0a:7bdb $5f
    ld   A, [HL]                                       ;; 0a:7bdc $7e
    ld   [DE], A                                       ;; 0a:7bdd $12
    push AF                                            ;; 0a:7bde $f5
    ld   L, C                                          ;; 0a:7bdf $69
    ld   H, $00                                        ;; 0a:7be0 $26 $00
    add  HL, HL                                        ;; 0a:7be2 $29
    add  HL, HL                                        ;; 0a:7be3 $29
    add  HL, HL                                        ;; 0a:7be4 $29
    ld   BC, .data_0a_7c92                             ;; 0a:7be5 $01 $92 $7c
    add  HL, BC                                        ;; 0a:7be8 $09
    ld   A, E                                          ;; 0a:7be9 $7b
    xor  A, $0d                                        ;; 0a:7bea $ee $0d
    ld   E, A                                          ;; 0a:7bec $5f
    ld   A, [HL+]                                      ;; 0a:7bed $2a
    ld   [DE], A                                       ;; 0a:7bee $12
    ld   C, A                                          ;; 0a:7bef $4f
    ld   A, E                                          ;; 0a:7bf0 $7b
    xor  A, $0e                                        ;; 0a:7bf1 $ee $0e
    ld   E, A                                          ;; 0a:7bf3 $5f
    pop  AF                                            ;; 0a:7bf4 $f1
    cp   A, $00                                        ;; 0a:7bf5 $fe $00
    jr   NZ, .jr_0a_7c05                               ;; 0a:7bf7 $20 $0c
    ld   A, [DE]                                       ;; 0a:7bf9 $1a
    add  A, [HL]                                       ;; 0a:7bfa $86
    ld   [DE], A                                       ;; 0a:7bfb $12
    inc  HL                                            ;; 0a:7bfc $23
    inc  DE                                            ;; 0a:7bfd $13
    ld   A, [DE]                                       ;; 0a:7bfe $1a
    adc  A, [HL]                                       ;; 0a:7bff $8e
    ld   [DE], A                                       ;; 0a:7c00 $12
    inc  HL                                            ;; 0a:7c01 $23
    inc  E                                             ;; 0a:7c02 $1c
    jr   .jr_0a_7c0f                                   ;; 0a:7c03 $18 $0a
.jr_0a_7c05:
    ld   A, [DE]                                       ;; 0a:7c05 $1a
    sub  A, [HL]                                       ;; 0a:7c06 $96
    ld   [DE], A                                       ;; 0a:7c07 $12
    inc  HL                                            ;; 0a:7c08 $23
    inc  DE                                            ;; 0a:7c09 $13
    ld   A, [DE]                                       ;; 0a:7c0a $1a
    sbc  A, [HL]                                       ;; 0a:7c0b $9e
    ld   [DE], A                                       ;; 0a:7c0c $12
    inc  HL                                            ;; 0a:7c0d $23
    inc  E                                             ;; 0a:7c0e $1c
.jr_0a_7c0f:
    ld   A, [DE]                                       ;; 0a:7c0f $1a
    add  A, [HL]                                       ;; 0a:7c10 $86
    ld   [DE], A                                       ;; 0a:7c11 $12
    inc  HL                                            ;; 0a:7c12 $23
    inc  DE                                            ;; 0a:7c13 $13
    ld   A, [DE]                                       ;; 0a:7c14 $1a
    adc  A, [HL]                                       ;; 0a:7c15 $8e
    ld   [DE], A                                       ;; 0a:7c16 $12
    ld   A, E                                          ;; 0a:7c17 $7b
    xor  A, $05                                        ;; 0a:7c18 $ee $05
    ld   E, A                                          ;; 0a:7c1a $5f
    ld   L, C                                          ;; 0a:7c1b $69
    ld   H, $00                                        ;; 0a:7c1c $26 $00
    add  HL, HL                                        ;; 0a:7c1e $29
    add  HL, HL                                        ;; 0a:7c1f $29
    add  HL, HL                                        ;; 0a:7c20 $29
    ld   BC, data_0a_75fd                             ;; 0a:7c21 $01 $fd $75
    add  HL, BC                                        ;; 0a:7c24 $09
    ld   A, [HL+]                                      ;; 0a:7c25 $2a
    ld   [DE], A                                       ;; 0a:7c26 $12
    inc  E                                             ;; 0a:7c27 $1c
    ld   A, [HL+]                                      ;; 0a:7c28 $2a
    ld   [DE], A                                       ;; 0a:7c29 $12
    inc  E                                             ;; 0a:7c2a $1c
    ld   A, [HL+]                                      ;; 0a:7c2b $2a
    ld   [DE], A                                       ;; 0a:7c2c $12
    ld   A, E                                          ;; 0a:7c2d $7b
    xor  A, $08                                        ;; 0a:7c2e $ee $08
    ld   E, A                                          ;; 0a:7c30 $5f
    xor  A, A                                          ;; 0a:7c31 $af
    ld   [DE], A                                       ;; 0a:7c32 $12
    ld   A, [HL+]                                      ;; 0a:7c33 $2a
    push HL                                            ;; 0a:7c34 $e5
    and  A, A                                          ;; 0a:7c35 $a7
    jr   Z, .jr_0a_7c43                                ;; 0a:7c36 $28 $0b
    ld   [wD59D], A                                    ;; 0a:7c38 $ea $9d $d5
    ld   A, Bank02                                        ;; 0a:7c3b $3e $02
    ld   HL, entry_02_7211                             ;; 0a:7c3d $21 $11 $72
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7c40 $cd $78 $10
.jr_0a_7c43:
    pop  HL                                            ;; 0a:7c43 $e1
    ld   A, [wD59E]                                    ;; 0a:7c44 $fa $9e $d5
    and  A, A                                          ;; 0a:7c47 $a7
    jr   Z, .jr_0a_7c56                                ;; 0a:7c48 $28 $0c
    ld   C, [HL]                                       ;; 0a:7c4a $4e
    ld   [wD59D], A                                    ;; 0a:7c4b $ea $9d $d5
    ld   A, Bank0b                                        ;; 0a:7c4e $3e $0b
    ld   HL, entry_0b_5f57                             ;; 0a:7c50 $21 $57 $5f
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7c53 $cd $78 $10
.jr_0a_7c56:
    call call_00_34d8                                  ;; 0a:7c56 $cd $d8 $34
    xor  A, A                                          ;; 0a:7c59 $af
    ld   [wD59D], A                                    ;; 0a:7c5a $ea $9d $d5
    ld   A, Bank02                                        ;; 0a:7c5d $3e $02
    ld   HL, entry_02_7102                             ;; 0a:7c5f $21 $02 $71
    call call_00_1078_SwitchBankWrapper                                  ;; 0a:7c62 $cd $78 $10
    pop  AF                                            ;; 0a:7c65 $f1
    ld   HL, wD300                                     ;; 0a:7c66 $21 $00 $d3
    ld   C, [HL]                                       ;; 0a:7c69 $4e
    ld   [HL], A                                       ;; 0a:7c6a $77
    rrca                                               ;; 0a:7c6b $0f
    rrca                                               ;; 0a:7c6c $0f
    rrca                                               ;; 0a:7c6d $0f
    and  A, $1c                                        ;; 0a:7c6e $e6 $1c
    ld   L, A                                          ;; 0a:7c70 $6f
    ld   H, $00                                        ;; 0a:7c71 $26 $00
    ld   DE, wD309                                     ;; 0a:7c73 $11 $09 $d3
    add  HL, DE                                        ;; 0a:7c76 $19
    ld   E, L                                          ;; 0a:7c77 $5d
    ld   D, H                                          ;; 0a:7c78 $54
    ld   A, C                                          ;; 0a:7c79 $79
    rrca                                               ;; 0a:7c7a $0f
    rrca                                               ;; 0a:7c7b $0f
    rrca                                               ;; 0a:7c7c $0f
    and  A, $1c                                        ;; 0a:7c7d $e6 $1c
    ld   L, A                                          ;; 0a:7c7f $6f
    ld   H, $00                                        ;; 0a:7c80 $26 $00
    ld   BC, wD309                                     ;; 0a:7c82 $01 $09 $d3
    add  HL, BC                                        ;; 0a:7c85 $09
    ld   A, [DE]                                       ;; 0a:7c86 $1a
    ld   [HL+], A                                      ;; 0a:7c87 $22
    inc  DE                                            ;; 0a:7c88 $13
    ld   A, [DE]                                       ;; 0a:7c89 $1a
    ld   [HL+], A                                      ;; 0a:7c8a $22
    inc  DE                                            ;; 0a:7c8b $13
    ld   A, [DE]                                       ;; 0a:7c8c $1a
    ld   [HL+], A                                      ;; 0a:7c8d $22
    inc  DE                                            ;; 0a:7c8e $13
    ld   A, [DE]                                       ;; 0a:7c8f $1a
    ld   [HL], A                                       ;; 0a:7c90 $77
    ret                                                ;; 0a:7c91 $c9

.data_0a_7c92:
    db   $0f, $06, $00, $f2, $ff, $00, $00, $00        ;; 0a:7c92 ????????
    db   $11, $00, $00, $0c, $00, $00, $00, $00        ;; 0a:7c9a ????????
    db   $13, $00, $00, $ee, $ff, $00, $00, $00        ;; 0a:7ca2 ????????
    db   $2f, $f5, $ff, $fc, $ff, $00, $00, $00        ;; 0a:7caa w???????
    db   $58, $08, $00, $00, $00, $00, $00, $00        ;; 0a:7cb2 ????????
    db   $56, $00, $00, $e8, $ff, $00, $00, $00        ;; 0a:7cba ????????
    db   $44, $00, $00, $08, $00, $00, $00, $00        ;; 0a:7cc2 ????????
    db   $49, $14, $00, $00, $00, $00, $00, $00        ;; 0a:7cca ????????
    db   $28, $00, $00, $f8, $ff, $00, $00, $00        ;; 0a:7cd2 w???????
    db   $7b, $00, $00, $10, $00, $00, $00, $00        ;; 0a:7cda ????????
    db   $8a, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7ce2 ????????
    db   $30, $10, $00, $00, $00, $00, $00, $00        ;; 0a:7cea ????????
    db   $52, $00, $00, $00, $00, $00, $00, $00        ;; 0a:7cf2 ????????
    db   $4d, $14, $00, $00, $00, $00, $00, $00        ;; 0a:7cfa ????????
    db   $74, $00, $00, $08, $00, $00, $00, $00        ;; 0a:7d02 ????????
    db   $8b, $4c, $00, $68, $ff, $00, $00, $00        ;; 0a:7d0a ????????
    db   $8b, $b4, $ff, $68, $ff, $00, $00, $00        ;; 0a:7d12 ????????
    db   $8d                                           ;; 0a:7d1a ?
