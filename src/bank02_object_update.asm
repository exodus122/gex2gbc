;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "bank02", ROMX[$4000], BANK[$02]

; This file updates all objects.
; Below is a list of jump tables, one for each object, starting with Player

data_02_4000_ObjectJumpTables:
    dw   data_02_4120                                      ;; 02:4000 w.
    dw   data_02_4ddb                                         ;; 02:4002 wW
    dw   data_02_4dff                                      ;; 02:4004 ??
    dw   data_02_4ddf                                         ;; 02:4006 wW
    dw   data_02_4de7                                         ;; 02:4008 wW
    dw   data_02_4def
    dw   data_02_4df7                            ;; 02:400a ????
    dw   data_02_4e03                                         ;; 02:400e wW
    dw   data_02_4e07 
    dw   data_02_4e0b                            ;; 02:4010 ????
    dw   data_02_4e0f                                         ;; 02:4014 wW
    dw   data_02_4e13                                      ;; 02:4016 ??
    dw   data_02_4e17                                         ;; 02:4018 wW
    dw   data_02_4e1f
    dw   data_02_4e23
    dw   data_02_4e2b
    dw   data_02_4e2f       ;; 02:401a ????????
    dw   data_02_4e3b 
    dw   data_02_4e43 
    dw   data_02_4e4f 
    dw   data_02_4e5b        ;; 02:4022 ????????
    dw   data_02_4e6b 
    dw   data_02_4e73 
    dw   data_02_4e77 
    dw   data_02_4e7b        ;; 02:402a ????????
    dw   data_02_4e83 
    dw   data_02_4e93 
    dw   data_02_4e97 
    dw   data_02_4ea3       ;; 02:4032 ????????
    dw   data_02_4ea7                                         ;; 02:403a wW
    dw   data_02_4eb3
    dw   data_02_4ebb                            ;; 02:403c ????
    dw   data_02_4ec3                                         ;; 02:4040 wW
    dw   data_02_4ecb                                      ;; 02:4042 ??
    dw   data_02_4ecf                                         ;; 02:4044 wW
    dw   data_02_4edb                                      ;; 02:4046 ??
    dw   data_02_4edf                                         ;; 02:4048 wW
    dw   data_02_4ee3                                         ;; 02:404a wW
    dw   data_02_4eef                                      ;; 02:404c ??
    dw   data_02_4f07                                         ;; 02:404e wW
    dw   data_02_4f0b                                         ;; 02:4050 wW
    dw   data_02_4f0f                                      ;; 02:4052 ??
    dw   data_02_4f13                                         ;; 02:4054 wW
    dw   data_02_4f1b
    dw   data_02_4f27                            ;; 02:4056 ????
    dw   data_02_4f2f                                         ;; 02:405a wW
    dw   data_02_4f33                                         ;; 02:405c wW
    dw   data_02_4f37                                         ;; 02:405e wW
    dw   data_02_4f43 
    dw   data_02_4f4b 
    dw   data_02_4f57 
    dw   data_02_4f5b        ;; 02:4060 ????????
    dw   data_02_4f5f 
    dw   data_02_4f6b 
    dw   data_02_4f73 
    dw   data_02_4f77        ;; 02:4068 ????????
    dw   data_02_4f7f 
    dw   data_02_4f87 
    dw   data_02_4f8b 
    dw   data_02_4f8f        ;; 02:4070 ????????
    dw   data_02_4f93 
    dw   data_02_4f97 
    dw   data_02_4f9b 
    dw   data_02_4fab        ;; 02:4078 ????????
    dw   data_02_4faf 
    dw   data_02_4fb3 
    dw   data_02_4fb7 
    dw   data_02_4fbb        ;; 02:4080 ????????
    dw   data_02_4fc7 
    dw   data_02_4fcf 
    dw   data_02_4fd7 
    dw   data_02_4fdb        ;; 02:4088 ????????
    dw   data_02_4fdf 
    dw   data_02_4fe3 
    dw   data_02_4fe7 
    dw   data_02_4feb        ;; 02:4090 ????????
    dw   data_02_4fef 
    dw   data_02_4ff3 
    dw   data_02_4ffb 
    dw   data_02_4fff        ;; 02:4098 ????????
    dw   data_02_5003 
    dw   data_02_5007 
    dw   data_02_500b 
    dw   data_02_5013        ;; 02:40a0 ????????
    dw   data_02_501f 
    dw   data_02_502f 
    dw   data_02_5037 
    dw   data_02_5043        ;; 02:40a8 ????????
    dw   data_02_5047 
    dw   data_02_504f 
    dw   data_02_5053 
    dw   data_02_505b        ;; 02:40b0 ????????
    dw   data_02_5063 
    dw   data_02_5067 
    dw   data_02_506b 
    dw   data_02_5077        ;; 02:40b8 ????????
    dw   data_02_507b 
    dw   data_02_507f 
    dw   data_02_5083 
    dw   data_02_5087        ;; 02:40c0 ????????
    dw   data_02_508b 
    dw   data_02_508f 
    dw   data_02_5093 
    dw   data_02_5097        ;; 02:40c8 ????????
    dw   data_02_509b 
    dw   data_02_509f 
    dw   data_02_50a3 
    dw   data_02_50b7        ;; 02:40d0 ????????
    dw   data_02_50bb 
    dw   data_02_50bf 
    dw   data_02_50c3 
    dw   data_02_50cf        ;; 02:40d8 ????????
    dw   data_02_50d3 
    dw   data_02_50d7 
    dw   data_02_50db 
    dw   data_02_50e3        ;; 02:40e0 ????????
    dw   data_02_50eb 
    dw   data_02_50ef 
    dw   data_02_50f3 
    dw   data_02_50f7        ;; 02:40e8 ????????
    dw   data_02_50ff 
    dw   data_02_5107 
    dw   data_02_510b 
    dw   data_02_5113        ;; 02:40f0 ????????
    dw   data_02_5117 
    dw   data_02_511f 
    dw   data_02_5123 
    dw   data_02_512f        ;; 02:40f8 ????????
    dw   data_02_5133 
    dw   data_02_5137 
    dw   data_02_513b 
    dw   data_02_513f        ;; 02:4100 ????????
    dw   data_02_5147 
    dw   data_02_5157 
    dw   data_02_515f 
    dw   data_02_518b        ;; 02:4108 ????????
    dw   data_02_518f 
    dw   data_02_5193 
    dw   data_02_5197 
    dw   data_02_519b        ;; 02:4110 ????????
    dw   data_02_51a3 
    dw   data_02_51ab 
    dw   data_02_51af                  ;; 02:4118 ??????
    dw   data_02_51b3                                         ;; 02:411e wW

INCLUDE "bank02_player_update.asm"

INCLUDE "bank02_object_actions.asm"
    
entry_02_6e17_PlayerInit:
    xor  A, A                                          ;; 02:6e17 $af
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6e18 $ea $00 $d3
    ld   A, $00                                        ;; 02:6e1b $3e $00
    ld   [wD200_PlayerObject_Id], A                                    ;; 02:6e1d $ea $00 $d2
    ld   A, [wD744]                                    ;; 02:6e20 $fa $44 $d7
    call call_02_7102_SetObjectAction                                  ;; 02:6e23 $cd $02 $71
    xor  A, A                                          ;; 02:6e26 $af
    ld   [wD621], A                                    ;; 02:6e27 $ea $21 $d6
    xor  A, A                                          ;; 02:6e2a $af
    ld   [wD74C], A                                    ;; 02:6e2b $ea $4c $d7
    ld   [wD75D_PlayerXSpeedPrev], A                                    ;; 02:6e2e $ea $5d $d7
    ld   [wD75E_PlayerXSpeed], A                                    ;; 02:6e31 $ea $5e $d7
    ld   [wD75C], A                                    ;; 02:6e34 $ea $5c $d7
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:6e37 $ea $60 $d7
    ld   [wD761_PlayerFallingFlag], A                                    ;; 02:6e3a $ea $61 $d7
    ld   [wD762_PlayerInitialYVelocity], A                                    ;; 02:6e3d $ea $62 $d7
    ld   [wD763_PlayerMovementFlags], A                                    ;; 02:6e40 $ea $63 $d7
    ld   [wD759], A                                    ;; 02:6e43 $ea $59 $d7
    ld   [wD758], A                                    ;; 02:6e46 $ea $58 $d7
    ld   [wD585_CollisionFlags], A                                    ;; 02:6e49 $ea $85 $d5
    ld   [wD584_CollisionFlagsPrev], A                                    ;; 02:6e4c $ea $84 $d5
    ld   A, $ff                                        ;; 02:6e4f $3e $ff
    ld   [wD745], A                                    ;; 02:6e51 $ea $45 $d7
    ld   [wD746_PlayerClimbingState], A                                    ;; 02:6e54 $ea $46 $d7
    xor  A, A                                          ;; 02:6e57 $af
    ld   [wD586], A                                    ;; 02:6e58 $ea $86 $d5
    ld   [wD74A], A                                    ;; 02:6e5b $ea $4a $d7
    ld   A, $00                                        ;; 02:6e5e $3e $00
    ld   [wD74B], A                                    ;; 02:6e60 $ea $4b $d7
    ld   A, $00                                        ;; 02:6e63 $3e $00
    ld   [wD20D_PlayerFacingAngle], A                                    ;; 02:6e65 $ea $0d $d2

entry_02_6e68:
    xor  A, A                                          ;; 02:6e68 $af
    ld   [wD587], A                                    ;; 02:6e69 $ea $87 $d5
    ld   [wD74D], A                                    ;; 02:6e6c $ea $4d $d7
    ld   [wD74E], A                                    ;; 02:6e6f $ea $4e $d7
    ld   [wD74F], A                                    ;; 02:6e72 $ea $4f $d7
    ld   HL, wD220_OtherLoadedObjects                                     ;; 02:6e75 $21 $20 $d2
    ld   DE, $20                                       ;; 02:6e78 $11 $20 $00
    ld   B, $07                                        ;; 02:6e7b $06 $07
.jr_02_6e7d:
    ld   [HL], $ff                                     ;; 02:6e7d $36 $ff
    add  HL, DE                                        ;; 02:6e7f $19
    dec  B                                             ;; 02:6e80 $05
    jr   NZ, .jr_02_6e7d                               ;; 02:6e81 $20 $fa
    ld   A, [wD743]                                    ;; 02:6e83 $fa $43 $d7
    and  A, A                                          ;; 02:6e86 $a7
    jr   Z, .jr_02_6e93                                ;; 02:6e87 $28 $0a
    ld   A, [wD744]                                    ;; 02:6e89 $fa $44 $d7
    cp   A, $1b                                        ;; 02:6e8c $fe $1b
    ld   A, $01                                        ;; 02:6e8e $3e $01
    call Z, call_02_48b7                               ;; 02:6e90 $cc $b7 $48
.jr_02_6e93:
    ld   [wD59D_ReturnBank], A                                    ;; 02:6e93 $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:6e96 $3e $0a
    ld   HL, entry_0a_4000                              ;; 02:6e98 $21 $00 $40
    call call_00_1078_CallAltBankFunc                                  ;; 02:6e9b $cd $78 $10
.jr_02_6e9e:
    ld   [wD59D_ReturnBank], A                                    ;; 02:6e9e $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:6ea1 $3e $0a
    ld   HL, entry_0a_7a7c                              ;; 02:6ea3 $21 $7c $7a
    call call_00_1078_CallAltBankFunc                                  ;; 02:6ea6 $cd $78 $10
    ld   A, [wD338]                                    ;; 02:6ea9 $fa $38 $d3
    cp   A, $01                                        ;; 02:6eac $fe $01
    jr   NZ, .jr_02_6e9e                               ;; 02:6eae $20 $ee
    ret                                                ;; 02:6eb0 $c9

entry_02_6eb1:
    xor  A, A                                          ;; 02:6eb1 $af
    ld   HL, wD000_ObjectFlags                                     ;; 02:6eb2 $21 $00 $d0
.jr_02_6eb5:
    ld   [HL], A                                       ;; 02:6eb5 $77
    inc  L                                             ;; 02:6eb6 $2c
    jr   NZ, .jr_02_6eb5                               ;; 02:6eb7 $20 $fc
    ret                                                ;; 02:6eb9 $c9

entry_02_6eba_UpdateObjects:
    xor  A, A                                          ;; 02:6eba $af
    ld   [wD75C], A                                    ;; 02:6ebb $ea $5c $d7
    ld   A, $20                                        ;; 02:6ebe $3e $20
    ld   [wD739], A                                    ;; 02:6ec0 $ea $39 $d7
    ld   A, [wD743]                                    ;; 02:6ec3 $fa $43 $d7
    and  A, A                                          ;; 02:6ec6 $a7
    jr   Z, .jr_02_6f0f                                ;; 02:6ec7 $28 $46
    ld   A, [wD74D]                                    ;; 02:6ec9 $fa $4d $d7
    and  A, A                                          ;; 02:6ecc $a7
    jr   Z, .jr_02_6ef3                                ;; 02:6ecd $28 $24
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6ecf $ea $00 $d3
    or   A, $02                                        ;; 02:6ed2 $f6 $02
    ld   L, A                                          ;; 02:6ed4 $6f
    ld   H, $d2                                        ;; 02:6ed5 $26 $d2
    ld   A, [HL+]                                      ;; 02:6ed7 $2a
    ld   H, [HL]                                       ;; 02:6ed8 $66
    ld   L, A                                          ;; 02:6ed9 $6f
    call call_00_10bd_CallFuncInHL                                  ;; 02:6eda $cd $bd $10
    ld   H, $d2                                        ;; 02:6edd $26 $d2
    ld   A, [wD74D]                                    ;; 02:6edf $fa $4d $d7
    and  A, $e0                                        ;; 02:6ee2 $e6 $e0
    or   A, $10                                        ;; 02:6ee4 $f6 $10
    ld   L, A                                          ;; 02:6ee6 $6f
    ld   A, [HL+]                                      ;; 02:6ee7 $2a
    sub  A, $10                                        ;; 02:6ee8 $d6 $10
    ld   [wD210_PlayerYPosition], A                                    ;; 02:6eea $ea $10 $d2
    ld   A, [HL]                                       ;; 02:6eed $7e
    sbc  A, $00                                        ;; 02:6eee $de $00
    ld   [wD211_PlayerYPosition], A                                    ;; 02:6ef0 $ea $11 $d2
.jr_02_6ef3:
    ld   A, [wD74F]                                    ;; 02:6ef3 $fa $4f $d7
    and  A, A                                          ;; 02:6ef6 $a7
    jr   Z, .jr_02_6f07                                ;; 02:6ef7 $28 $0e
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6ef9 $ea $00 $d3
    or   A, $02                                        ;; 02:6efc $f6 $02
    ld   L, A                                          ;; 02:6efe $6f
    ld   H, $d2                                        ;; 02:6eff $26 $d2
    ld   A, [HL+]                                      ;; 02:6f01 $2a
    ld   H, [HL]                                       ;; 02:6f02 $66
    ld   L, A                                          ;; 02:6f03 $6f
    call call_00_10bd_CallFuncInHL                                  ;; 02:6f04 $cd $bd $10
.jr_02_6f07:
    ld   A, $00                                        ;; 02:6f07 $3e $00
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6f09 $ea $00 $d3
    call call_02_4939_PlayerUpdate                                  ;; 02:6f0c $cd $39 $49
.jr_02_6f0f:
    ld   A, $20                                        ;; 02:6f0f $3e $20
.jr_02_6f11:
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6f11 $ea $00 $d3
    or   A, $00                                        ;; 02:6f14 $f6 $00
    ld   L, A                                          ;; 02:6f16 $6f
    ld   H, $d2                                        ;; 02:6f17 $26 $d2
    ld   A, [HL]                                       ;; 02:6f19 $7e
    cp   A, $ff                                        ;; 02:6f1a $fe $ff
    jr   Z, .jr_02_6f5c                                ;; 02:6f1c $28 $3e
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:6f1e $fa $00 $d3
    ld   HL, wD74D                                     ;; 02:6f21 $21 $4d $d7
    cp   A, [HL]                                       ;; 02:6f24 $be
    jr   Z, .jr_02_6f38                                ;; 02:6f25 $28 $11
    ld   HL, wD74F                                     ;; 02:6f27 $21 $4f $d7
    cp   A, [HL]                                       ;; 02:6f2a $be
    jr   Z, .jr_02_6f38                                ;; 02:6f2b $28 $0b
    or   A, $02                                        ;; 02:6f2d $f6 $02
    ld   L, A                                          ;; 02:6f2f $6f
    ld   H, $d2                                        ;; 02:6f30 $26 $d2
    ld   A, [HL+]                                      ;; 02:6f32 $2a
    ld   H, [HL]                                       ;; 02:6f33 $66
    ld   L, A                                          ;; 02:6f34 $6f
    call call_00_10bd_CallFuncInHL                                  ;; 02:6f35 $cd $bd $10
.jr_02_6f38:
    ld   H, $d2                                        ;; 02:6f38 $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:6f3a $fa $00 $d3
    or   A, $00                                        ;; 02:6f3d $f6 $00
    ld   L, A                                          ;; 02:6f3f $6f
    ld   A, [HL]                                       ;; 02:6f40 $7e
    cp   A, $ff                                        ;; 02:6f41 $fe $ff
    jr   Z, .jr_02_6f5c                                ;; 02:6f43 $28 $17
    ld   A, L                                          ;; 02:6f45 $7d
    xor  A, $09                                        ;; 02:6f46 $ee $09
    ld   L, A                                          ;; 02:6f48 $6f
    res  5, [HL]                                       ;; 02:6f49 $cb $ae
    inc  L                                             ;; 02:6f4b $2c
    res  6, [HL]                                       ;; 02:6f4c $cb $b6
    call call_02_6fda                                  ;; 02:6f4e $cd $da $6f
    ld   [wD59D_ReturnBank], A                                    ;; 02:6f51 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6f54 $3e $03
    ld   HL, entry_03_5ebf                              ;; 02:6f56 $21 $bf $5e
    call call_00_1078_CallAltBankFunc                                  ;; 02:6f59 $cd $78 $10
.jr_02_6f5c:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:6f5c $fa $00 $d3
    add  A, $20                                        ;; 02:6f5f $c6 $20
    jr   NZ, .jr_02_6f11                               ;; 02:6f61 $20 $ae
    call call_00_1138                                  ;; 02:6f63 $cd $38 $11
    ld   [wD59D_ReturnBank], A                                    ;; 02:6f66 $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:6f69 $3e $0a
    ld   HL, entry_0a_7a7c                              ;; 02:6f6b $21 $7c $7a
    call call_00_1078_CallAltBankFunc                                  ;; 02:6f6e $cd $78 $10
    call call_02_722c                                  ;; 02:6f71 $cd $2c $72
    ld   [wD59D_ReturnBank], A                                    ;; 02:6f74 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6f77 $3e $03
    ld   HL, entry_03_6540                              ;; 02:6f79 $21 $40 $65
    call call_00_1078_CallAltBankFunc                                  ;; 02:6f7c $cd $78 $10
    ret                                                ;; 02:6f7f $c9
    
entry_02_6f80:
    ld   A, $20                                        ;; 02:6f80 $3e $20
    ld   [wD739], A                                    ;; 02:6f82 $ea $39 $d7
    ld   A, [wD743]                                    ;; 02:6f85 $fa $43 $d7
    and  A, A                                          ;; 02:6f88 $a7
    jr   Z, .jr_02_6fa0                                ;; 02:6f89 $28 $15
    ld   A, $00                                        ;; 02:6f8b $3e $00
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6f8d $ea $00 $d3
    ld   [wD59D_ReturnBank], A                                    ;; 02:6f90 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6f93 $3e $03
    ld   HL, entry_03_5ca8                              ;; 02:6f95 $21 $a8 $5c
    call call_00_1078_CallAltBankFunc                                  ;; 02:6f98 $cd $78 $10
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:6f9b $21 $0f $d6
    set  0, [HL]                                       ;; 02:6f9e $cb $c6
.jr_02_6fa0:
    ld   A, $20                                        ;; 02:6fa0 $3e $20
.jr_02_6fa2:
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:6fa2 $ea $00 $d3
    or   A, $00                                        ;; 02:6fa5 $f6 $00
    ld   L, A                                          ;; 02:6fa7 $6f
    ld   H, $d2                                        ;; 02:6fa8 $26 $d2
    ld   A, [HL]                                       ;; 02:6faa $7e
    cp   A, $ff                                        ;; 02:6fab $fe $ff
    jr   Z, .jr_02_6fc7                                ;; 02:6fad $28 $18
    ld   A, L                                          ;; 02:6faf $7d
    xor  A, $0a                                        ;; 02:6fb0 $ee $0a
    ld   L, A                                          ;; 02:6fb2 $6f
    bit  7, [HL]                                       ;; 02:6fb3 $cb $7e
    jr   Z, .jr_02_6fbc                                ;; 02:6fb5 $28 $05
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:6fb7 $21 $0f $d6
    set  1, [HL]                                       ;; 02:6fba $cb $ce
.jr_02_6fbc:
    ld   [wD59D_ReturnBank], A                                    ;; 02:6fbc $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6fbf $3e $03
    ld   HL, entry_03_5ebf                              ;; 02:6fc1 $21 $bf $5e
    call call_00_1078_CallAltBankFunc                                  ;; 02:6fc4 $cd $78 $10
.jr_02_6fc7:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:6fc7 $fa $00 $d3
    add  A, $20                                        ;; 02:6fca $c6 $20
    jr   NZ, .jr_02_6fa2                               ;; 02:6fcc $20 $d4
    ld   [wD59D_ReturnBank], A                                    ;; 02:6fce $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6fd1 $3e $03
    ld   HL, entry_03_6540                              ;; 02:6fd3 $21 $40 $65
    call call_00_1078_CallAltBankFunc                                  ;; 02:6fd6 $cd $78 $10
    ret                                                ;; 02:6fd9 $c9

call_02_6fda:
    ld   H, $d2                                        ;; 02:6fda $26 $d2
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:6fdc $fa $00 $d3
    ld   C, A                                          ;; 02:6fdf $4f
    or   A, $0a                                        ;; 02:6fe0 $f6 $0a
    ld   L, A                                          ;; 02:6fe2 $6f
    res  2, [HL]                                       ;; 02:6fe3 $cb $96
    ld   A, C                                          ;; 02:6fe5 $79
    or   A, $06                                        ;; 02:6fe6 $f6 $06
    ld   L, A                                          ;; 02:6fe8 $6f
    ld   A, [HL]                                       ;; 02:6fe9 $7e
    cp   A, $ff                                        ;; 02:6fea $fe $ff
    ret  Z                                             ;; 02:6fec $c8
    dec  [HL]                                          ;; 02:6fed $35
    ret  NZ                                            ;; 02:6fee $c0
    ld   A, C                                          ;; 02:6fef $79
    or   A, $0b                                        ;; 02:6ff0 $f6 $0b
    ld   E, A                                          ;; 02:6ff2 $5f
    ld   D, H                                          ;; 02:6ff3 $54
    ld   A, [DE]                                       ;; 02:6ff4 $1a
    ld   [HL+], A                                      ;; 02:6ff5 $22
    inc  [HL]                                          ;; 02:6ff6 $34
    inc  E                                             ;; 02:6ff7 $1c
    ld   A, [DE]                                       ;; 02:6ff8 $1a
    sub  A, [HL]                                       ;; 02:6ff9 $96
    jr   NZ, .jr_02_7013                               ;; 02:6ffa $20 $17
    inc  L                                             ;; 02:6ffc $2c
    inc  L                                             ;; 02:6ffd $2c
    bit  6, [HL]                                       ;; 02:6ffe $cb $76
    jp   NZ, call_02_70f1                                ;; 02:7000 $c2 $f1 $70
    inc  L                                             ;; 02:7003 $2c
    ld   B, [HL]                                       ;; 02:7004 $46
    dec  L                                             ;; 02:7005 $2d
    dec  L                                             ;; 02:7006 $2d
    dec  L                                             ;; 02:7007 $2d
    bit  1, B                                          ;; 02:7008 $cb $48
    jr   Z, .jr_02_700e                                ;; 02:700a $28 $02
    ld   A, [DE]                                       ;; 02:700c $1a
    dec  A                                             ;; 02:700d $3d
.jr_02_700e:
    ld   [HL+], A                                      ;; 02:700e $22
    inc  L                                             ;; 02:700f $2c
    inc  L                                             ;; 02:7010 $2c
    set  2, [HL]                                       ;; 02:7011 $cb $d6
.jr_02_7013:
    ld   A, C                                          ;; 02:7013 $79
    or   A, $0a                                        ;; 02:7014 $f6 $0a
    ld   L, A                                          ;; 02:7016 $6f
    set  6, [HL]                                       ;; 02:7017 $cb $f6
    ld   A, C                                          ;; 02:7019 $79
    or   A, $07                                        ;; 02:701a $f6 $07
    ld   L, A                                          ;; 02:701c $6f
    ld   E, [HL]                                       ;; 02:701d $5e
    ld   D, $00                                        ;; 02:701e $16 $00
    ld   A, C                                          ;; 02:7020 $79
    or   A, $04                                        ;; 02:7021 $f6 $04
    ld   L, A                                          ;; 02:7023 $6f
    ld   A, [HL+]                                      ;; 02:7024 $2a
    ld   H, [HL]                                       ;; 02:7025 $66
    ld   L, A                                          ;; 02:7026 $6f
    add  HL, DE                                        ;; 02:7027 $19
    ld   B, [HL]                                       ;; 02:7028 $46
    ld   A, C                                          ;; 02:7029 $79
    or   A, $08                                        ;; 02:702a $f6 $08
    ld   L, A                                          ;; 02:702c $6f
    ld   H, $d2                                        ;; 02:702d $26 $d2
    ld   [HL], B                                       ;; 02:702f $70

jp_02_7030:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:7030 $fa $00 $d3
    and  A, A                                          ;; 02:7033 $a7
    jr   NZ, .jr_02_703c                               ;; 02:7034 $20 $06
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:7036 $21 $0f $d6
    set  0, [HL]                                       ;; 02:7039 $cb $c6
    ret                                                ;; 02:703b $c9
.jr_02_703c:
    or   A, $0a                                        ;; 02:703c $f6 $0a
    ld   L, A                                          ;; 02:703e $6f
    ld   H, $d2                                        ;; 02:703f $26 $d2
    bit  7, [HL]                                       ;; 02:7041 $cb $7e
    ret  Z                                             ;; 02:7043 $c8
    ld   A, L                                          ;; 02:7044 $7d
    xor  A, $02                                        ;; 02:7045 $ee $02
    ld   L, A                                          ;; 02:7047 $6f
    ld   A, [HL]                                       ;; 02:7048 $7e
    ld   [wD588], A                                    ;; 02:7049 $ea $88 $d5
    ld   A, L                                          ;; 02:704c $7d
    xor  A, $08                                        ;; 02:704d $ee $08
    ld   L, A                                          ;; 02:704f $6f
    ld   L, [HL]                                       ;; 02:7050 $6e
    ld   H, $00                                        ;; 02:7051 $26 $00
    ld   DE, .data_02_7061                             ;; 02:7053 $11 $61 $70
    add  HL, DE                                        ;; 02:7056 $19
    ld   A, [HL]                                       ;; 02:7057 $7e
    ld   [wD589], A                                    ;; 02:7058 $ea $89 $d5
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:705b $21 $0f $d6
    set  1, [HL]                                       ;; 02:705e $cb $ce
    ret                                                ;; 02:7060 $c9
.data_02_7061:
    db   $00, $00, $00, $00, $18, $18, $18, $00        ;; 02:7061 ????.???
    db   $19, $00, $00, $00, $1a, $1a, $00, $00        ;; 02:7069 ????.???
    db   $1a, $00, $1b, $00, $00, $00, $19, $00        ;; 02:7071 ????????
    db   $18, $1a, $00, $00, $00, $00, $00, $00        ;; 02:7079 ????????
    db   $00, $00, $00, $00, $00, $00, $19, $00        ;; 02:7081 ????????
    db   $00, $00, $19, $00, $00, $00, $00, $00        ;; 02:7089 ??.?????
    db   $00, $00, $1b, $1a, $19, $00, $00, $00        ;; 02:7091 ????????
    db   $00, $00, $00, $00, $1a, $00, $00, $00        ;; 02:7099 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $1a        ;; 02:70a1 ????????
    db   $1a, $00, $00, $00, $00, $00, $19, $00        ;; 02:70a9 ????????
    db   $18, $00, $00, $18, $18, $18, $00, $00        ;; 02:70b1 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:70b9 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:70c1 ????????
    db   $00, $00, $00, $00, $00, $00, $1b, $00        ;; 02:70c9 ????????
    db   $00, $1b, $00, $1b, $00, $00, $00, $00        ;; 02:70d1 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:70d9 ????????
    db   $1a, $00, $00, $00, $00, $00, $1c, $00        ;; 02:70e1 ????????
    db   $00, $00, $00, $00, $00, $1b, $00, $00        ;; 02:70e9 ????????

call_02_70f1:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:70f1 $fa $00 $d3
    or   A, $09                                        ;; 02:70f4 $f6 $09
    ld   L, A                                          ;; 02:70f6 $6f
    ld   H, $d2                                        ;; 02:70f7 $26 $d2
    ld   A, [HL]                                       ;; 02:70f9 $7e
    bit  7, A                                          ;; 02:70fa $cb $7f
    ret  Z                                             ;; 02:70fc $c8
    and  A, $1f                                        ;; 02:70fd $e6 $1f
    jp   call_02_4ccd                                  ;; 02:70ff $c3 $cd $4c

call_02_7102_SetObjectAction:
entry_02_7102_SetObjectAction:
; gets a jump table value from data_02_4000_ObjectJumpTables
; updates the object instances at D200-D300
; sets action id, action pointer, data_0c, unknown_pointer_04_05, and more?
    and  A, $1f                                        ;; 02:7102 $e6 $1f
    ld   C, A                                          ;; 02:7104 $4f
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:7105 $fa $00 $d3
    or   A, $01                                        ;; 02:7108 $f6 $01
    ld   L, A                                          ;; 02:710a $6f
    ld   H, $d2                                        ;; 02:710b $26 $d2
    ld   [HL], C                                       ;; 02:710d $71
    dec  L                                             ;; 02:710e $2d
    ld   L, [HL]                                       ;; 02:710f $6e
    ld   H, $00                                        ;; 02:7110 $26 $00
    add  HL, HL                                        ;; 02:7112 $29
    ld   DE, data_02_4000_ObjectJumpTables                              ;; 02:7113 $11 $00 $40
    add  HL, DE                                        ;; 02:7116 $19
    ld   E, [HL]                                       ;; 02:7117 $5e
    inc  HL                                            ;; 02:7118 $23
    ld   D, [HL]                                       ;; 02:7119 $56
    ld   L, C                                          ;; 02:711a $69
    ld   H, $00                                        ;; 02:711b $26 $00
    add  HL, HL                                        ;; 02:711d $29
    add  HL, HL                                        ;; 02:711e $29
    add  HL, DE                                        ;; 02:711f $19
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:7120 $fa $00 $d3
    or   A, $02                                        ;; 02:7123 $f6 $02
    ld   E, A                                          ;; 02:7125 $5f
    ld   D, $d2                                        ;; 02:7126 $16 $d2
    ld   A, [HL+]                                      ;; 02:7128 $2a
    ld   [DE], A                                       ;; 02:7129 $12 ; sets current action pointer in object instance
    inc  E                                             ;; 02:712a $1c
    ld   A, [HL+]                                      ;; 02:712b $2a
    ld   [DE], A                                       ;; 02:712c $12 ; sets current action pointer in object instance
    inc  E                                             ;; 02:712d $1c
    ld   A, [HL+]                                      ;; 02:712e $2a
    ld   H, [HL]                                       ;; 02:712f $66
    ld   L, A                                          ;; 02:7130 $6f
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:7131 $fa $00 $d3
    or   A, $09                                        ;; 02:7134 $f6 $09
    ld   C, A                                          ;; 02:7136 $4f
    ld   B, $d2                                        ;; 02:7137 $06 $d2
    ld   A, [HL+]                                      ;; 02:7139 $2a
    or   A, $20                                        ;; 02:713a $f6 $20
    ld   [BC], A                                       ;; 02:713c $02
    inc  C                                             ;; 02:713d $0c
    ld   A, [HL+]                                      ;; 02:713e $2a
    or   A, $40                                        ;; 02:713f $f6 $40
    ld   [BC], A                                       ;; 02:7141 $02
    inc  C                                             ;; 02:7142 $0c
    ld   A, [HL+]                                      ;; 02:7143 $2a
    ld   [BC], A                                       ;; 02:7144 $02
    inc  C                                             ;; 02:7145 $0c
    push AF                                            ;; 02:7146 $f5
    ld   A, [HL+]                                      ;; 02:7147 $2a
    ld   [BC], A                                       ;; 02:7148 $02
    ld   A, L                                          ;; 02:7149 $7d
    ld   [DE], A                                       ;; 02:714a $12
    inc  E                                             ;; 02:714b $1c
    ld   A, H                                          ;; 02:714c $7c
    ld   [DE], A                                       ;; 02:714d $12
    inc  E                                             ;; 02:714e $1c
    pop  AF                                            ;; 02:714f $f1
    ld   [DE], A                                       ;; 02:7150 $12
    inc  E                                             ;; 02:7151 $1c
    xor  A, A                                          ;; 02:7152 $af
    ld   [DE], A                                       ;; 02:7153 $12
    inc  E                                             ;; 02:7154 $1c
    ld   A, [HL]                                       ;; 02:7155 $7e
    ld   [DE], A                                       ;; 02:7156 $12
    jp   jp_02_7030                                    ;; 02:7157 $c3 $30 $70

call_02_715a:
entry_02_715a:
    call call_00_13a6                                  ;; 02:715a $cd $a6 $13
    call call_02_7164                                  ;; 02:715d $cd $64 $71
    call call_02_7196                                  ;; 02:7160 $cd $96 $71
    ret                                                ;; 02:7163 $c9

call_02_7164:
    ld   HL, wD6EF_YPositionInMap                                     ;; 02:7164 $21 $ef $d6
    ld   A, [HL+]                                      ;; 02:7167 $2a
    ld   D, [HL]                                       ;; 02:7168 $56
    ld   [wD5A2], A                                    ;; 02:7169 $ea $a2 $d5
    srl  D                                             ;; 02:716c $cb $3a
    rra                                                ;; 02:716e $1f
    srl  D                                             ;; 02:716f $cb $3a
    rra                                                ;; 02:7171 $1f
    srl  D                                             ;; 02:7172 $cb $3a
    rra                                                ;; 02:7174 $1f
    ld   E, A                                          ;; 02:7175 $5f
    ld   HL, wD6F3                                     ;; 02:7176 $21 $f3 $d6
    ld   A, [HL]                                       ;; 02:7179 $7e
    ld   [HL], E                                       ;; 02:717a $73
    sub  A, E                                          ;; 02:717b $93
    ld   E, A                                          ;; 02:717c $5f
    inc  HL                                            ;; 02:717d $23
    ld   A, [HL]                                       ;; 02:717e $7e
    ld   [HL], D                                       ;; 02:717f $72
    sbc  A, D                                          ;; 02:7180 $9a
    ld   D, A                                          ;; 02:7181 $57
    jr   C, .jr_02_718e                                ;; 02:7182 $38 $0a
    or   A, E                                          ;; 02:7184 $b3
    ret  Z                                             ;; 02:7185 $c8
    ld   HL, wD6F9                                     ;; 02:7186 $21 $f9 $d6
    ld   A, [HL]                                       ;; 02:7189 $7e
    or   A, $01                                        ;; 02:718a $f6 $01
    ld   [HL], A                                       ;; 02:718c $77
    ret                                                ;; 02:718d $c9
.jr_02_718e:
    ld   HL, wD6F9                                     ;; 02:718e $21 $f9 $d6
    ld   A, [HL]                                       ;; 02:7191 $7e
    or   A, $02                                        ;; 02:7192 $f6 $02
    ld   [HL], A                                       ;; 02:7194 $77
    ret                                                ;; 02:7195 $c9

call_02_7196:
    ld   HL, wD6ED_XPositionInMap                                     ;; 02:7196 $21 $ed $d6
    ld   A, [HL+]                                      ;; 02:7199 $2a
    ld   D, [HL]                                       ;; 02:719a $56
    ld   [wD5A1], A                                    ;; 02:719b $ea $a1 $d5
    srl  D                                             ;; 02:719e $cb $3a
    rra                                                ;; 02:71a0 $1f
    srl  D                                             ;; 02:71a1 $cb $3a
    rra                                                ;; 02:71a3 $1f
    srl  D                                             ;; 02:71a4 $cb $3a
    rra                                                ;; 02:71a6 $1f
    ld   E, A                                          ;; 02:71a7 $5f
    ld   HL, wD6F1                                     ;; 02:71a8 $21 $f1 $d6
    ld   A, [HL]                                       ;; 02:71ab $7e
    ld   [HL], E                                       ;; 02:71ac $73
    sub  A, E                                          ;; 02:71ad $93
    ld   E, A                                          ;; 02:71ae $5f
    inc  HL                                            ;; 02:71af $23
    ld   A, [HL]                                       ;; 02:71b0 $7e
    ld   [HL], D                                       ;; 02:71b1 $72
    sbc  A, D                                          ;; 02:71b2 $9a
    ld   D, A                                          ;; 02:71b3 $57
    jr   C, .jr_02_71c0                                ;; 02:71b4 $38 $0a
    or   A, E                                          ;; 02:71b6 $b3
    ret  Z                                             ;; 02:71b7 $c8
    ld   HL, wD6F9                                     ;; 02:71b8 $21 $f9 $d6
    ld   A, [HL]                                       ;; 02:71bb $7e
    or   A, $04                                        ;; 02:71bc $f6 $04
    ld   [HL], A                                       ;; 02:71be $77
    ret                                                ;; 02:71bf $c9
.jr_02_71c0:
    ld   HL, wD6F9                                     ;; 02:71c0 $21 $f9 $d6
    ld   A, [HL]                                       ;; 02:71c3 $7e
    or   A, $08                                        ;; 02:71c4 $f6 $08
    ld   [HL], A                                       ;; 02:71c6 $77
    ret                                                ;; 02:71c7 $c9
    
entry_02_71c8:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:71c8 $fa $00 $d3
    push AF                                            ;; 02:71cb $f5
    ld   A, $20                                        ;; 02:71cc $3e $20
.jr_02_71ce:
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:71ce $ea $00 $d3
    ld   L, A                                          ;; 02:71d1 $6f
    ld   H, $d2                                        ;; 02:71d2 $26 $d2
    ld   A, [HL]                                       ;; 02:71d4 $7e
    cp   A, $ff                                        ;; 02:71d5 $fe $ff
    jr   Z, .jr_02_71fa                                ;; 02:71d7 $28 $21
    ld   L, A                                          ;; 02:71d9 $6f
    ld   H, $00                                        ;; 02:71da $26 $00
    add  HL, HL                                        ;; 02:71dc $29
    ld   DE, data_02_743c                              ;; 02:71dd $11 $3c $74
    add  HL, DE                                        ;; 02:71e0 $19
    ld   A, [HL+]                                      ;; 02:71e1 $2a
    push HL                                            ;; 02:71e2 $e5
    and  A, A                                          ;; 02:71e3 $a7
    call NZ, call_02_7211                              ;; 02:71e4 $c4 $11 $72
    pop  HL                                            ;; 02:71e7 $e1
    ld   A, [wD59E]                                    ;; 02:71e8 $fa $9e $d5
    and  A, A                                          ;; 02:71eb $a7
    jr   Z, .jr_02_71fa                                ;; 02:71ec $28 $0c
    ld   C, [HL]                                       ;; 02:71ee $4e
    ld   [wD59D_ReturnBank], A                                    ;; 02:71ef $ea $9d $d5
    ld   A, Bank0b                                        ;; 02:71f2 $3e $0b
    ld   HL, entry_0b_5f57                              ;; 02:71f4 $21 $57 $5f
    call call_00_1078_CallAltBankFunc                                  ;; 02:71f7 $cd $78 $10
.jr_02_71fa:
    ld   A, [wD300_CurrentObjectAddr]                                    ;; 02:71fa $fa $00 $d3
    add  A, $20                                        ;; 02:71fd $c6 $20
    jr   NZ, .jr_02_71ce                               ;; 02:71ff $20 $cd
    ld   [wD59D_ReturnBank], A                                    ;; 02:7201 $ea $9d $d5
    ld   A, Bank0b                                        ;; 02:7204 $3e $0b
    ld   HL, entry_03_5f1b                              ;; 02:7206 $21 $1b $5f
    call call_00_1078_CallAltBankFunc                                  ;; 02:7209 $cd $78 $10
    pop  AF                                            ;; 02:720c $f1
    ld   [wD300_CurrentObjectAddr], A                                    ;; 02:720d $ea $00 $d3
    ret                                                ;; 02:7210 $c9

call_02_7211:
entry_02_7211:
    ld   HL, wD71E                                     ;; 02:7211 $21 $1e $d7
    ld   E, [HL]                                       ;; 02:7214 $5e
    ld   HL, wD71A                                     ;; 02:7215 $21 $1a $d7
    ld   D, $04                                        ;; 02:7218 $16 $04
.jr_02_721a:
    dec  E                                             ;; 02:721a $1d
    bit  7, E                                          ;; 02:721b $cb $7b
    jr   NZ, .jr_02_7226                               ;; 02:721d $20 $07
    cp   A, [HL]                                       ;; 02:721f $be
    ret  Z                                             ;; 02:7220 $c8
    inc  HL                                            ;; 02:7221 $23
    dec  D                                             ;; 02:7222 $15
    jr   NZ, .jr_02_721a                               ;; 02:7223 $20 $f5
    ret                                                ;; 02:7225 $c9
.jr_02_7226:
    ld   [HL], A                                       ;; 02:7226 $77
    ld   HL, wD71E                                     ;; 02:7227 $21 $1e $d7
    inc  [HL]                                          ;; 02:722a $34
    ret                                                ;; 02:722b $c9

call_02_722c:
entry_02_722c:
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:722c $21 $0f $d6
    bit  3, [HL]                                       ;; 02:722f $cb $5e
    ret  NZ                                            ;; 02:7231 $c0
    ld   HL, wD71E                                     ;; 02:7232 $21 $1e $d7
    ld   A, [HL]                                       ;; 02:7235 $7e
    and  A, A                                          ;; 02:7236 $a7
    ret  Z                                             ;; 02:7237 $c8
    dec  [HL]                                          ;; 02:7238 $35
    ld   L, [HL]                                       ;; 02:7239 $6e
    ld   H, $00                                        ;; 02:723a $26 $00
    ld   DE, wD71A                                     ;; 02:723c $11 $1a $d7
    add  HL, DE                                        ;; 02:723f $19
    ld   L, [HL]                                       ;; 02:7240 $6e
    ld   H, $00                                        ;; 02:7241 $26 $00
    add  HL, HL                                        ;; 02:7243 $29
    add  HL, HL                                        ;; 02:7244 $29
    add  HL, HL                                        ;; 02:7245 $29
    ld   DE, .data_02_726c                             ;; 02:7246 $11 $6c $72
    add  HL, DE                                        ;; 02:7249 $19
    ld   A, [HL+]                                      ;; 02:724a $2a
    ld   [wD71F], A                                    ;; 02:724b $ea $1f $d7
    ld   A, [HL+]                                      ;; 02:724e $2a
    ld   [wD720], A                                    ;; 02:724f $ea $20 $d7
    ld   A, [HL+]                                      ;; 02:7252 $2a
    ld   [wD721], A                                    ;; 02:7253 $ea $21 $d7
    ld   A, [HL+]                                      ;; 02:7256 $2a
    ld   [wD722], A                                    ;; 02:7257 $ea $22 $d7
    ld   A, [HL+]                                      ;; 02:725a $2a
    ld   [wD723], A                                    ;; 02:725b $ea $23 $d7
    ld   A, [HL+]                                      ;; 02:725e $2a
    ld   [wD724], A                                    ;; 02:725f $ea $24 $d7
    ld   A, [HL+]                                      ;; 02:7262 $2a
    ld   [wD725], A                                    ;; 02:7263 $ea $25 $d7
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:7266 $21 $0f $d6
    set  3, [HL]                                       ;; 02:7269 $cb $de
    ret                                                ;; 02:726b $c9
.data_02_726c:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:726c ????????
    db   $12, $00, $40                                 ;; 02:7274 ...
    dw   $8400                                         ;; 02:7277 pP
    db   $00, $01, $00, $12, $00, $41, $00, $85        ;; 02:7279 ..??????
    db   $00, $01, $00, $12, $00, $51, $00, $82        ;; 02:7281 ???.....
    db   $00, $02, $00, $12, $00, $53, $00, $82        ;; 02:7289 ..??????
    db   $00, $02, $00, $12, $00, $55, $00, $82        ;; 02:7291 ????????
    db   $00, $02, $00, $12, $00, $4b                  ;; 02:7299 ???...
    dw   $8200                                         ;; 02:729f pP
    db   $00, $03, $00, $12, $00, $43, $00, $82        ;; 02:72a1 ..??????
    db   $00, $04, $00, $12, $00, $47                  ;; 02:72a9 ???...
    dw   $8200                                         ;; 02:72af pP
    db   $00, $04, $00, $12, $00, $4e, $00, $82        ;; 02:72b1 ..??????
    db   $00, $03, $00, $12, $00, $5d, $00, $85        ;; 02:72b9 ???.....
    db   $00, $01, $00, $12, $00, $5b, $00, $84        ;; 02:72c1 ..?.....
    db   $00, $01, $00, $12, $00, $5e, $00, $85        ;; 02:72c9 ..?.....
    db   $00, $01, $00, $12, $00, $5a, $00, $84        ;; 02:72d1 ..?.....
    db   $00, $01, $00, $12, $00, $59, $00, $84        ;; 02:72d9 ..??????
    db   $00, $01, $00, $12, $00, $57, $00, $82        ;; 02:72e1 ???.....
    db   $00, $02, $00, $12, $00, $5f, $00, $84        ;; 02:72e9 ..??????
    db   $00, $01, $00, $12, $00, $60, $00, $84        ;; 02:72f1 ????????
    db   $00, $01, $00, $12, $00, $61, $00, $84        ;; 02:72f9 ????????
    db   $00, $01, $00, $12, $00, $63, $00, $82        ;; 02:7301 ????????
    db   $00, $03, $00, $12, $00, $6e, $00, $84        ;; 02:7309 ????????
    db   $00, $02, $00, $12, $00, $71, $00, $85        ;; 02:7311 ????????
    db   $00, $01, $00, $12, $00, $72, $00, $85        ;; 02:7319 ????????
    db   $00, $01, $00, $12, $00, $73, $00, $82        ;; 02:7321 ????????
    db   $00, $03, $00, $12, $00, $76, $00, $84        ;; 02:7329 ????????
    db   $00, $01, $00, $12, $00, $77, $00, $85        ;; 02:7331 ????????
    db   $00, $01, $00, $12, $00, $78, $00, $84        ;; 02:7339 ????????
    db   $00, $01, $00, $12, $00, $79, $00, $82        ;; 02:7341 ????????
    db   $00, $01, $00, $12, $00, $7a, $00, $85        ;; 02:7349 ????????
    db   $00, $01, $00, $12, $00, $7b, $00, $85        ;; 02:7351 ????????
    db   $00, $01, $00, $12, $00, $66, $00, $82        ;; 02:7359 ????????
    db   $00, $02, $00, $12, $00, $7c, $00, $82        ;; 02:7361 ????????
    db   $00, $02, $00, $12, $00, $62, $00, $85        ;; 02:7369 ????????
    db   $00, $01, $00, $12, $00, $68, $00, $82        ;; 02:7371 ????????
    db   $00, $03, $00, $12, $00, $70, $00, $85        ;; 02:7379 ????????
    db   $00, $01, $00, $12, $00, $5c, $00, $84        ;; 02:7381 ???.....
    db   $00, $01, $00, $12, $00, $42, $00, $85        ;; 02:7389 ..??????
    db   $00, $01, $00, $12, $00, $6b, $00, $82        ;; 02:7391 ????????
    db   $00, $03, $00, $11, $00, $40, $00, $85        ;; 02:7399 ????????
    db   $00, $01, $00, $11, $00, $41, $00, $84        ;; 02:73a1 ????????
    db   $00, $01, $00, $11, $00, $42, $00, $82        ;; 02:73a9 ????????
    db   $00, $02, $00, $11, $00, $44, $00, $84        ;; 02:73b1 ????????
    db   $00, $01, $00, $11, $00, $45, $00, $82        ;; 02:73b9 ????????
    db   $00, $02, $00, $11, $00, $47, $00, $84        ;; 02:73c1 ????????
    db   $00, $01, $00, $11, $00, $48, $00, $82        ;; 02:73c9 ????????
    db   $00, $02, $00, $11, $00, $4a, $00, $84        ;; 02:73d1 ????????
    db   $00, $01, $00, $11, $00, $4b, $00, $84        ;; 02:73d9 ????????
    db   $00, $01, $00, $11, $00, $4c, $00, $82        ;; 02:73e1 ????????
    db   $00, $02, $00, $11, $00, $4e, $00, $84        ;; 02:73e9 ????????
    db   $00, $01, $00, $11, $00, $4f, $00, $85        ;; 02:73f1 ????????
    db   $00, $01, $00, $11, $00, $50, $00, $84        ;; 02:73f9 ????????
    db   $00, $02, $00, $11, $00, $52, $00, $82        ;; 02:7401 ????????
    db   $00, $02, $00, $11, $00, $54, $00, $84        ;; 02:7409 ????????
    db   $00, $02, $00, $11, $00, $56                  ;; 02:7411 ???...
    dw   $8400                                         ;; 02:7417 pP
    db   $00, $01, $00, $11, $00, $57, $00, $85        ;; 02:7419 ..??????
    db   $00, $01, $00, $11, $00, $58, $00, $84        ;; 02:7421 ????????
    db   $00, $01, $00, $11, $00, $48, $00, $84        ;; 02:7429 ????????
    db   $00, $02, $00, $11, $00, $59, $00, $85        ;; 02:7431 ????????
    db   $00, $01, $00                                 ;; 02:7439 ???

data_02_743c:
    db   $00, $00, $00, $01, $00, $02, $00, $06        ;; 02:743c ??????.w
    db   $00, $07, $00, $07, $00, $07, $00, $00        ;; 02:7444 .w??????
    db   $00, $00, $01, $05, $01, $04, $24, $05        ;; 02:744c ????ww??
    db   $00, $07, $00, $07, $33, $07, $00, $06        ;; 02:7454 ????????
    db   $00, $07, $00, $06, $00, $07, $00, $06        ;; 02:745c ????????
    db   $01, $03, $02, $05, $00, $07, $24, $05        ;; 02:7464 ????????
    db   $00, $07, $00, $07, $01, $05, $01, $04        ;; 02:746c ????????
    db   $01, $04, $03, $07, $05, $07, $04, $07        ;; 02:7474 ????????
    db   $0f, $07, $07, $07, $06, $07, $0e, $05        ;; 02:747c ????????
    db   $0d, $05, $08, $07, $00, $07, $0b, $05        ;; 02:7484 ??ww????
    db   $23, $05, $09, $07, $00, $07, $10, $05        ;; 02:748c ????????
    db   $10, $05, $0a, $04, $0c, $05, $00, $06        ;; 02:7494 ????????
    db   $0a, $06, $34, $05, $00, $07, $00, $07        ;; 02:749c ????????
    db   $00, $07, $25, $07, $11, $05, $12, $05        ;; 02:74a4 ????????
    db   $20, $04, $20, $04, $20, $04, $20, $04        ;; 02:74ac ????????
    db   $00, $07, $13, $07, $13, $07, $00, $00        ;; 02:74b4 ????????
    db   $1e, $07, $1e, $07, $1e, $07, $14, $05        ;; 02:74bc ????????
    db   $00, $04, $21, $07, $20, $04, $00, $07        ;; 02:74c4 ????????
    db   $22, $07, $00, $07, $00, $00, $1a, $05        ;; 02:74cc ????????
    db   $18, $06, $18, $06, $00, $07, $19, $07        ;; 02:74d4 ????????
    db   $00, $07, $1f, $07, $19, $07, $18, $07        ;; 02:74dc ????????
    db   $18, $07, $18, $07, $00, $06, $17, $07        ;; 02:74e4 ????????
    db   $18, $06, $1d, $04, $15, $04, $16, $04        ;; 02:74ec ????????
    db   $1b, $07, $1b, $07, $1d, $04, $1d, $04        ;; 02:74f4 ????????
    db   $1c, $04, $1c, $04, $1c, $04, $00, $04        ;; 02:74fc ????????
    db   $26, $04, $26, $04, $26, $04, $26, $04        ;; 02:7504 ????????
    db   $26, $04, $29, $05, $2a, $07, $00, $00        ;; 02:750c ????????
    db   $27, $05, $27, $05, $00, $07, $2b, $05        ;; 02:7514 ????????
    db   $2b, $05, $00, $07, $28, $07, $00, $07        ;; 02:751c ????????
    db   $38, $05, $00, $06, $2c, $07, $2d, $05        ;; 02:7524 ????????
    db   $2e, $05, $00, $00, $2f, $07, $2f, $06        ;; 02:752c ????????
    db   $30, $05, $31, $04, $31, $04, $31, $04        ;; 02:7534 ????????
    db   $00, $07, $00, $07, $00, $07, $32, $05        ;; 02:753c ????????
    db   $32, $05, $32, $05, $00, $07, $32, $04        ;; 02:7544 ????????
    db   $32, $04, $32, $06, $32, $03, $37, $05        ;; 02:754c ????????
    db   $39, $04, $00, $07, $00, $07, $35, $05        ;; 02:7554 ????????
    db   $c1, $00, $06, $0c, $9f, $a0, $a1, $a2        ;; 02:755c ........
    db   $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa        ;; 02:7564 ........
    db   $00, $c2, $00, $04, $01, $14, $00, $00        ;; 02:756c ?.....?.
    db   $00, $04, $04, $14, $15, $16, $17, $00        ;; 02:7574 .......?
    db   $c2, $00, $0a, $01, $09, $00, $00, $00        ;; 02:757c .....?..
    db   $04, $08, $00, $01, $02, $03, $04, $05        ;; 02:7584 ........
    db   $06, $07, $00, $00, $00, $04, $08, $0a        ;; 02:758c ..?.....
    db   $0b, $0c, $0d, $0e, $0f, $10, $11, $00        ;; 02:7594 .......?
    db   $c2, $00, $04, $03, $18, $19, $1a, $00        ;; 02:759c .......?
    db   $00, $00, $04, $04, $32, $33, $34, $35        ;; 02:75a4 ????????
    db   $00, $00, $00, $0a, $01, $1d, $00, $00        ;; 02:75ac ?.....?.
    db   $02, $04, $03, $93, $94, $95, $00, $00        ;; 02:75b4 ......?.
    db   $00, $04, $01, $1b, $00, $00, $00, $0a        ;; 02:75bc ....????
    db   $01, $00, $00, $00, $00, $08, $02, $ac        ;; 02:75c4 ????????
    db   $ad, $00, $00, $02, $04, $06, $27, $22        ;; 02:75cc ??......
    db   $23, $24, $25, $26, $00, $c2, $00, $04        ;; 02:75d4 ....????
    db   $01, $09, $00, $c2, $00, $04, $05, $8c        ;; 02:75dc ????????
    db   $8d, $8e, $8f, $1c, $00, $d1, $00, $04        ;; 02:75e4 ?????...
    db   $04, $90, $91, $92, $96, $00, $00, $02        ;; 02:75ec .....?..
    db   $3c, $02, $ab, $3b, $00, $00, $02, $0a        ;; 02:75f4 ....?...
    db   $0a, $28, $29, $2a, $2b, $2c, $2d, $2e        ;; 02:75fc ........
    db   $2f, $30, $31, $00, $c2, $00, $0a, $0a        ;; 02:7604 ...?....
    db   $31, $30, $2f, $d1, $d2, $d3, $d4, $d5        ;; 02:760c ........
    db   $d6, $d7, $00, $00, $00, $ff, $01, $88        ;; 02:7614 ..??????
    db   $00, $00, $00, $04, $08, $84, $85, $86        ;; 02:761c ?.......
    db   $87, $88, $89, $8a, $8b, $00, $00, $00        ;; 02:7624 ??????..
    db   $04, $04, $1e, $1f, $20, $21, $00, $c2        ;; 02:762c ......??
    db   $00, $04, $01, $1c, $00, $c2, $00, $04        ;; 02:7634 ?????...
    db   $09, $1c, $36, $37, $38, $39, $3a, $38        ;; 02:763c ........
    db   $38, $1c, $00, $00, $02, $06, $0c, $ae        ;; 02:7644 ..??????
    db   $af, $b0, $b1, $b2, $b3, $b4, $b5, $3c        ;; 02:764c ????????
    db   $3c, $3c, $3c, $00, $c2, $00, $06, $08        ;; 02:7654 ????????
    db   $b6, $b7, $b8, $b9, $ba, $bb, $c0, $c1        ;; 02:765c ????????
    db   $00, $00, $02, $04, $03, $93, $94, $95        ;; 02:7664 ????????
    db   $00, $00, $00, $ff, $01, $40, $00, $00        ;; 02:766c ?.....??
    db   $02, $06, $0c, $aa, $a9, $a8, $a7, $a6        ;; 02:7674 ????????
    db   $a5, $a4, $a3, $a2, $a1, $a0, $9f, $00        ;; 02:767c ????????
    db   $00, $02, $04, $01, $40, $00, $00, $00        ;; 02:7684 ????????
    db   $0a, $01, $00, $00, $00, $80, $06, $08        ;; 02:768c ????....
    db   $40, $41, $42, $43, $44, $45, $46, $47        ;; 02:7694 .???????
    db   $00, $00, $80, $06, $06, $48, $49, $4a        ;; 02:769c ?.......
    db   $4b, $4c, $4d, $00, $00, $80, $06, $08        ;; 02:76a4 ...?????
    db   $50, $51, $52, $53, $54, $55, $56, $57        ;; 02:76ac ????????
    db   $00, $00, $82, $05, $05, $5d, $5c, $5b        ;; 02:76b4 ?.......
    db   $5a, $5b, $00, $00, $82, $05, $03, $5c        ;; 02:76bc ..?.....
    db   $5d, $5e, $00, $00, $80, $0a, $04, $5f        ;; 02:76c4 ..??????
    db   $60, $61, $60, $00, $00, $82, $4b, $04        ;; 02:76cc ????????
    db   $75, $74, $74, $74, $00, $00, $82, $0a        ;; 02:76d4 ????????
    db   $01, $75, $00, $00, $80, $0a, $01, $76        ;; 02:76dc ????????
    db   $00, $00, $80, $0a, $03, $67, $68, $69        ;; 02:76e4 ????????
    db   $68, $00, $00, $80, $0a, $03, $6a, $6b        ;; 02:76ec ????????
    db   $6c, $6b, $00, $00, $82, $0a, $01, $6b        ;; 02:76f4 ????????
    db   $00, $00, $80, $0a, $04, $7a, $7b, $7c        ;; 02:76fc ????????
    db   $7d, $00, $00, $82, $06, $04, $7c, $7d        ;; 02:7704 ????????
    db   $7e, $7f, $00, $00, $82, $06, $04, $7f        ;; 02:770c ????????
    db   $7e, $7d, $7c, $00, $00, $82, $04, $05        ;; 02:7714 ????????
    db   $73, $72, $71, $70, $6f, $00, $00, $82        ;; 02:771c ????????
    db   $04, $05, $6f, $70, $71, $72, $73, $00        ;; 02:7724 ????????
    db   $00, $80, $0a, $02, $6b, $6c, $00, $00        ;; 02:772c ????????
    db   $80, $0a, $02, $6b, $6c, $00, $00, $82        ;; 02:7734 ??????..
    db   $05, $05, $42, $43, $44, $45, $44, $00        ;; 02:773c .......?
    db   $00, $82, $05, $03, $43, $42, $41, $00        ;; 02:7744 .......?
    db   $00, $80, $06, $08, $46, $47, $48, $49        ;; 02:774c ????????
    db   $4a, $4b, $4c, $4d, $00, $00, $80, $06        ;; 02:7754 ????????
    db   $0a, $59, $5a, $5b, $5c, $5d, $5e, $46        ;; 02:775c ????????
    db   $46, $46, $46, $00, $00, $82, $03, $0f        ;; 02:7764 ????????
    db   $4e, $4f, $50, $51, $52, $53, $54, $4e        ;; 02:776c ????????
    db   $4f, $50, $51, $52, $53, $54, $4e, $00        ;; 02:7774 ????????
    db   $00, $82, $06, $03, $55, $56, $57, $00        ;; 02:777c ????????
    db   $00, $80, $b4, $01, $58, $00, $00, $82        ;; 02:7784 ????????
    db   $06, $01, $57, $00, $00, $80, $0a, $08        ;; 02:778c ????????
    db   $5a, $5b, $5c, $5d, $5e, $5f, $60, $61        ;; 02:7794 ????????
    db   $00, $00, $80, $05, $05, $62, $63, $64        ;; 02:779c ????????
    db   $65, $66, $00, $00, $80, $05, $06, $40        ;; 02:77a4 ????????
    db   $41, $42, $43, $44, $45, $00, $00, $80        ;; 02:77ac ????????
    db   $06, $06, $46, $47, $48, $49, $4a, $4b        ;; 02:77b4 ????????
    db   $00, $00, $80, $06, $08, $4c, $4d, $4e        ;; 02:77bc ????????
    db   $4f, $50, $51, $52, $53, $00, $00, $80        ;; 02:77c4 ????????
    db   $08, $06, $54, $55, $56, $57, $58, $59        ;; 02:77cc ????????
    db   $00, $00, $80, $04, $08, $6d, $6e, $6f        ;; 02:77d4 ????????
    db   $70, $6d, $71, $72, $74, $00, $00, $82        ;; 02:77dc ????????
    db   $04, $03, $74, $75, $76, $00, $00, $82        ;; 02:77e4 ????????
    db   $04, $03, $77, $78, $79, $00, $00, $80        ;; 02:77ec ????????
    db   $05, $06, $5f, $60, $61, $62, $63, $64        ;; 02:77f4 ????????
    db   $00, $00, $80, $0a, $04, $58, $59, $5a        ;; 02:77fc ????????
    db   $5b, $00, $00, $80, $04, $0a, $5c, $5d        ;; 02:7804 ????????
    db   $5e, $5f, $60, $61, $60, $5f, $5e, $5d        ;; 02:780c ????????
    db   $00, $00, $82, $04, $04, $62, $65, $64        ;; 02:7814 ????????
    db   $63, $00, $00, $82, $ff, $01, $66, $00        ;; 02:781c ????????
    db   $00, $80, $ff, $01, $73, $00, $00, $80        ;; 02:7824 ????????
    db   $06, $08, $67, $68, $69, $6a, $6b, $6c        ;; 02:782c ????????
    db   $6d, $6e, $00, $00, $82, $0a, $04, $6f        ;; 02:7834 ????????
    db   $70, $71, $72, $00, $00, $80, $06, $08        ;; 02:783c ????????
    db   $65, $66, $67, $68, $69, $6a, $6b, $6c        ;; 02:7844 ????????
    db   $00, $00, $80, $04, $0a, $40, $41, $42        ;; 02:784c ????????
    db   $43, $44, $45, $44, $43, $42, $41, $00        ;; 02:7854 ????????
    db   $00, $80, $04, $04, $47, $48, $49, $48        ;; 02:785c ????????
    db   $00, $00, $80, $08, $08, $4a, $4b, $4c        ;; 02:7864 ????????
    db   $4d, $4e, $4f, $50, $51, $00, $00, $82        ;; 02:786c ????????
    db   $08, $02, $52, $53, $00, $00, $80, $04        ;; 02:7874 ????????
    db   $02, $54, $55, $00, $00, $80, $04, $04        ;; 02:787c ????????
    db   $56, $57, $58, $59, $00, $00, $80, $04        ;; 02:7884 ????????
    db   $06, $77, $78, $79, $7a, $7b, $7c, $00        ;; 02:788c ????????
    db   $00, $80, $08, $0f, $6d, $6e, $6f, $70        ;; 02:7894 ????????
    db   $71, $72, $73, $74, $75, $76, $77, $78        ;; 02:789c ????????
    db   $79, $7a, $7b, $00, $00, $80, $08, $08        ;; 02:78a4 ????????
    db   $50, $51, $52, $53, $54, $55, $56, $57        ;; 02:78ac ????????
    db   $00, $00, $80, $08, $08, $57, $56, $55        ;; 02:78b4 ????????
    db   $54, $53, $52, $51, $50, $00, $00, $82        ;; 02:78bc ????????
    db   $08, $10, $57, $56, $55, $54, $53, $52        ;; 02:78c4 ????????
    db   $51, $50, $50, $51, $52, $53, $54, $55        ;; 02:78cc ????????
    db   $56, $57, $00, $00, $80, $08, $08, $40        ;; 02:78d4 ????????
    db   $41, $42, $43, $44, $45, $46, $47, $00        ;; 02:78dc ????????
    db   $00, $80, $08, $08, $48, $49, $4a, $4b        ;; 02:78e4 ????????
    db   $4c, $4d, $4e, $4f, $00, $00, $80, $08        ;; 02:78ec ????????
    db   $06, $76, $77, $78, $79, $7a, $7b, $00        ;; 02:78f4 ????????
    db   $00, $80, $08, $0a, $7c, $79, $7c, $79        ;; 02:78fc ????????
    db   $7c, $79, $7c, $79, $7c, $79, $00, $00        ;; 02:7904 ????????
    db   $80, $08, $0a, $7c, $79, $7c, $79, $7c        ;; 02:790c ????????
    db   $79, $7c, $79, $7c, $79, $00, $00, $80        ;; 02:7914 ????????
    db   $ff, $01, $00, $00, $00, $10, $0a, $08        ;; 02:791c ????????
    db   $20, $28, $20, $28, $20, $28, $20, $28        ;; 02:7924 ????????
    db   $00, $00, $10, $2d, $01, $30, $00, $00        ;; 02:792c ????????
    db   $10, $2d, $01, $38, $00, $00, $10, $ff        ;; 02:7934 ????????
    db   $01, $40, $00, $00, $10, $1e, $01, $40        ;; 02:793c ????????
    db   $00, $00, $10, $ff, $01, $28, $00, $00        ;; 02:7944 ?.....?.
    db   $10, $ff, $01, $2c, $00, $00, $10, $ff        ;; 02:794c ....????
    db   $01, $50, $00, $00, $10, $ff, $01, $58        ;; 02:7954 ????????
    db   $00, $00, $10, $ff, $01, $44, $00, $00        ;; 02:795c ????????
    db   $10, $ff, $01, $4c, $00, $00, $10, $ff        ;; 02:7964 ?????...
    db   $01, $48, $00, $00, $10, $ff, $01, $50        ;; 02:796c ..??????
    db   $00, $00, $10, $ff, $01, $58, $00, $00        ;; 02:7974 ????????
    db   $10, $ff, $01, $48, $00, $00, $08, $3c        ;; 02:797c ????????
    db   $01, $48, $00, $00, $10, $ff, $01, $48        ;; 02:7984 ????????
    db   $00, $00, $10, $ff, $01, $20, $00, $00        ;; 02:798c ?.....?.
    db   $10, $ff, $01, $20, $00, $00, $10, $ff        ;; 02:7994 ....?...
    db   $01, $30, $00, $00, $10, $04, $02, $20        ;; 02:799c ..?.....
    db   $30, $00, $00, $10, $2d, $01, $20, $00        ;; 02:79a4 .???????
    db   $00, $12, $06, $02, $28, $30, $00, $00        ;; 02:79ac ????????
    db   $10, $32, $01, $20, $00, $00, $12, $06        ;; 02:79b4 ????????
    db   $07, $28, $28, $28, $28, $28, $30, $38        ;; 02:79bc ????????
    db   $00, $00, $10, $06, $06, $44, $20, $2c        ;; 02:79c4 ????????
    db   $38, $50, $50, $00, $00, $10, $ff, $01        ;; 02:79cc ????????
    db   $58, $00, $00, $10, $ff, $01, $20, $00        ;; 02:79d4 ??.....?
    db   $00, $10, $0a, $02, $2c, $38, $00, $00        ;; 02:79dc ......?.
    db   $10, $ff, $01, $44, $00, $00, $10, $ff        ;; 02:79e4 ....????
    db   $01, $40, $00, $00, $10, $0a, $02, $40        ;; 02:79ec ???.....
    db   $46, $00, $00, $10, $ff, $01, $20, $00        ;; 02:79f4 .?.....?
    db   $00, $10, $ff, $01, $2c, $00, $00, $10        ;; 02:79fc .....?..
    db   $ff, $01, $38, $00, $00, $10, $0a, $01        ;; 02:7a04 ...?....
    db   $44, $00, $00, $12, $0c, $02, $4c, $54        ;; 02:7a0c .?.....?
    db   $00, $00, $12, $1e, $01, $54, $00, $00        ;; 02:7a14 ?.....?.
    db   $10, $ff, $01, $40, $00, $00, $10, $ff        ;; 02:7a1c ....?...
    db   $08, $40, $42, $44, $46, $48, $4a, $4c        ;; 02:7a24 ..??????
    db   $4e, $00, $00, $10, $ff, $01, $50, $00        ;; 02:7a2c ??.....?
    db   $00, $10, $ff, $01, $50, $00, $00, $10        ;; 02:7a34 .....???
    db   $06, $06, $20, $28, $30, $38, $40, $48        ;; 02:7a3c ????????
    db   $00, $00, $10, $ff, $01, $40, $00, $00        ;; 02:7a44 ????????
    db   $08, $1e, $01, $40, $00, $00, $10, $ff        ;; 02:7a4c ????????
    db   $01, $40, $00, $00, $10, $08, $06, $40        ;; 02:7a54 ????????
    db   $44, $48, $4c, $48, $44, $00, $00, $08        ;; 02:7a5c ????????
    db   $ff, $01, $20, $00, $00, $12, $06, $06        ;; 02:7a64 ????????
    db   $20, $28, $30, $38, $40, $48, $00, $00        ;; 02:7a6c ????????
    db   $10, $ff, $01, $40, $00, $00, $12, $06        ;; 02:7a74 ????????

data_02_7a7c:
    db   $06, $40, $42, $44, $46, $48, $4a, $00        ;; 02:7a7c ????????
    db   $00, $10, $ff, $01, $58, $00, $00, $10        ;; 02:7a84 ????????
    db   $ff, $01, $60, $00, $00, $10, $ff, $01        ;; 02:7a8c ????????
    db   $50, $00, $00, $10, $ff, $01, $58, $00        ;; 02:7a94 ????????
    db   $00, $10, $ff, $01, $54, $00, $00, $10        ;; 02:7a9c ????????
    db   $ff, $01, $58, $00, $00, $10, $ff, $01        ;; 02:7aa4 ????????
    db   $20, $00, $00, $08, $ff, $01, $20, $00        ;; 02:7aac ????????
    db   $00, $10, $ff, $01, $20, $00, $00, $12        ;; 02:7ab4 ????????
    db   $02, $02, $2c, $38, $00, $00, $10, $06        ;; 02:7abc ????????
    db   $02, $28, $2c, $00, $00, $10, $06, $02        ;; 02:7ac4 ????????
    db   $20, $24, $00, $00, $10, $06, $04, $30        ;; 02:7acc ????????
    db   $34, $38, $3c, $00, $00, $08, $ff, $01        ;; 02:7ad4 ????????
    db   $20, $00, $00, $12, $06, $06, $20, $28        ;; 02:7adc ????????
    db   $30, $38, $40, $48, $00, $00, $10, $ff        ;; 02:7ae4 ????????
    db   $01, $50, $00, $00, $10, $08, $04, $40        ;; 02:7aec ????????
    db   $44, $48, $44, $00, $00, $12, $08, $04        ;; 02:7af4 ????????
    db   $40, $44, $48, $4c, $00, $00, $10, $08        ;; 02:7afc ????????
    db   $02, $50, $54, $00, $00, $10, $04, $02        ;; 02:7b04 ????????
    db   $58, $5a, $00, $00, $10, $ff, $01, $2c        ;; 02:7b0c ????????
    db   $00, $00, $10, $ff, $01, $40, $00, $00        ;; 02:7b14 ????????
    db   $08, $ff, $01, $00, $00, $00, $10, $ff        ;; 02:7b1c ????????
    db   $01, $48, $00, $00, $10, $ff, $01, $50        ;; 02:7b24 ????????
    db   $00, $00, $10, $78, $01, $20, $00, $00        ;; 02:7b2c ????????
    db   $10, $f0, $01, $28, $00, $00, $10, $06        ;; 02:7b34 ????????
    db   $04, $58, $5a, $5c, $5a, $00, $00, $10        ;; 02:7b3c ????????
    db   $ff, $01, $50, $00, $00, $08, $1e, $01        ;; 02:7b44 ????????
    db   $50, $00, $00, $10, $ff, $01, $50, $00        ;; 02:7b4c ????????
    db   $00, $10, $ff, $01, $50, $00, $00, $10        ;; 02:7b54 ????????
    db   $ff, $01, $58, $00, $00, $10, $ff, $01        ;; 02:7b5c ????????
    db   $58, $00, $00, $08, $ff, $01, $58, $00        ;; 02:7b64 ????????
    db   $00, $10, $ff, $01, $46, $00, $00, $10        ;; 02:7b6c ????????
    db   $06, $03, $40, $42, $44, $00, $00, $10        ;; 02:7b74 ????????
    db   $06, $06, $20, $28, $30, $38, $40, $48        ;; 02:7b7c ????????
    db   $00, $00, $10, $06, $02, $4c, $4e, $00        ;; 02:7b84 ????????
    db   $00, $10, $ff, $01, $58, $00, $00, $10        ;; 02:7b8c ????????
    db   $ff, $01, $50, $00, $00, $10                  ;; 02:7b94 ??????

data_02_7b9a:
    db   $ff, $01, $50, $00, $00, $10, $ff, $01        ;; 02:7b9a ????????
    db   $54, $00, $00, $10, $ff, $01, $58, $00        ;; 02:7ba2 ????????
    db   $00, $10, $ff, $01, $40, $00, $00, $10        ;; 02:7baa ????????
    db   $04, $08, $20, $24, $28, $2c, $30, $34        ;; 02:7bb2 ????????
    db   $38, $3c, $00, $00, $10, $ff, $01, $20        ;; 02:7bba ????????
    db   $00, $00, $10, $04, $04, $20, $28, $30        ;; 02:7bc2 ????????
    db   $38, $00, $00, $10, $03, $04, $20, $28        ;; 02:7bca ????????
    db   $30, $38, $00, $00, $10, $02, $04, $20        ;; 02:7bd2 ????????
    db   $28, $30, $38, $00, $00, $10, $01, $04        ;; 02:7bda ????????
    db   $20, $28, $30, $38, $00, $00, $10, $08        ;; 02:7be2 ????????
    db   $04, $40, $46, $4c, $52, $00, $00, $10        ;; 02:7bea ????????
    db   $08, $04, $20, $26, $2c, $32, $00, $00        ;; 02:7bf2 ????????
    db   $12, $04, $03, $44, $40, $44, $00, $00        ;; 02:7bfa ????????
    db   $10, $ff, $01, $48, $00, $00, $12, $05        ;; 02:7c02 ????????
    db   $04, $40, $44, $48, $4c, $00, $00, $10        ;; 02:7c0a ????????
    db   $ff, $01, $20, $00, $00, $10, $04, $02        ;; 02:7c12 ????????
    db   $26, $2c, $00, $00, $10, $06, $03, $32        ;; 02:7c1a ????????
    db   $36, $3a, $00, $00, $18, $ff, $01, $40        ;; 02:7c22 ????????
    db   $00, $00, $10, $06, $04, $40, $44, $48        ;; 02:7c2a ????????
    db   $4c, $00, $00, $10, $ff, $01, $58, $00        ;; 02:7c32 ????????
    db   $00, $10, $06, $03, $58, $54, $54, $00        ;; 02:7c3a ????????
    db   $00, $10, $ff, $01, $50, $00, $00, $10        ;; 02:7c42 ????????
    db   $03, $03, $58, $54, $54, $00, $00, $10        ;; 02:7c4a ????????
    db   $ff, $01, $5c, $00, $00, $08, $ff, $01        ;; 02:7c52 ????????
    db   $00, $00, $00, $08, $ff, $01, $00, $00        ;; 02:7c5a ????????
    db   $00, $18, $ff, $01, $40, $00, $00, $10        ;; 02:7c62 ????????
    db   $04, $02, $40, $42, $00, $00, $08, $ff        ;; 02:7c6a ????????
    db   $01, $00, $00, $00, $10, $ff, $01, $5c        ;; 02:7c72 ????????
    db   $00, $00, $10, $ff, $01, $40, $00, $00        ;; 02:7c7a ????????
    db   $10, $04, $14, $40, $50, $40, $50, $50        ;; 02:7c82 ????????
    db   $40, $40, $50, $40, $50, $40, $40, $50        ;; 02:7c8a ????????
    db   $50, $50, $40, $40, $50, $50, $40, $00        ;; 02:7c92 ????????
    db   $00, $10, $03, $02, $40, $50, $00, $00        ;; 02:7c9a ????????
    db   $10, $04, $04, $50, $54, $58, $54, $00        ;; 02:7ca2 ????????
    db   $00, $10, $04, $07, $44, $44, $48, $48        ;; 02:7caa ????????
    db   $48, $48, $4c, $00, $00, $10, $ff, $01        ;; 02:7cb2 ????????
    db   $40, $00, $00, $10, $ff, $01, $50, $00        ;; 02:7cba ????????
    db   $00, $10, $ff, $01, $54, $00, $00, $10        ;; 02:7cc2 ??????..
    db   $ff, $01, $40, $00, $00, $01, $ff, $01        ;; 02:7cca ...?....
    db   $7e, $00, $00, $01, $ff, $01, $60, $00        ;; 02:7cd2 .?.....?
    db   $00, $01, $ff, $01, $44, $00, $00, $01        ;; 02:7cda ????????
    db   $ff, $01, $58, $00, $00, $01, $ff, $01        ;; 02:7ce2 ????????
    db   $2c, $00, $00, $01, $ff, $01, $5c             ;; 02:7cea ???????
