;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

SECTION "bank02", ROMX[$4000], BANK[$02]

; This file updates all objects.
; Below is a table of jump tables, one for each object

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
    dw   $4e83 
    dw   $4e93 
    dw   $4e97 
    dw   $4ea3       ;; 02:4032 ????????
    dw   $4ea7                                         ;; 02:403a wW
    dw   $4eb3
    dw   $4ebb                            ;; 02:403c ????
    dw   $4ec3                                         ;; 02:4040 wW
    dw   $4ecb                                      ;; 02:4042 ??
    dw   $4ecf                                         ;; 02:4044 wW
    dw   $4edb                                      ;; 02:4046 ??
    dw   $4edf                                         ;; 02:4048 wW
    dw   $4ee3                                         ;; 02:404a wW
    dw   $4eef                                      ;; 02:404c ??
    dw   $4f07                                         ;; 02:404e wW
    dw   $4f0b                                         ;; 02:4050 wW
    dw   $4f0f                                      ;; 02:4052 ??
    dw   $4f13                                         ;; 02:4054 wW
    dw   $4f1b
    dw   $4f27                            ;; 02:4056 ????
    dw   $4f2f                                         ;; 02:405a wW
    dw   $4f33                                         ;; 02:405c wW
    dw   $4f37                                         ;; 02:405e wW
    dw   $4f43 
    dw   $4f4b 
    dw   $4f57 
    dw   $4f5b        ;; 02:4060 ????????
    dw   $4f5f 
    dw   $4f6b 
    dw   $4f73 
    dw   $4f77        ;; 02:4068 ????????
    dw   $4f7f 
    dw   $4f87 
    dw   $4f8b 
    dw   $4f8f        ;; 02:4070 ????????
    dw   $4f93 
    dw   $4f97 
    dw   $4f9b 
    dw   $4fab        ;; 02:4078 ????????
    dw   $4faf 
    dw   $4fb3 
    dw   $4fb7 
    dw   $4fbb        ;; 02:4080 ????????
    dw   $4fc7 
    dw   $4fcf 
    dw   $4fd7 
    dw   $4fdb        ;; 02:4088 ????????
    dw   $4fdf 
    dw   $4fe3 
    dw   $4fe7 
    dw   $4feb        ;; 02:4090 ????????
    dw   $4fef 
    dw   $4ff3 
    dw   $4ffb 
    dw   $4fff        ;; 02:4098 ????????
    dw   $5003 
    dw   $5007 
    dw   $500b 
    dw   $5013        ;; 02:40a0 ????????
    dw   $501f 
    dw   $502f 
    dw   $5037 
    dw   $5043        ;; 02:40a8 ????????
    dw   $5047 
    dw   $504f 
    dw   $5053 
    dw   $505b        ;; 02:40b0 ????????
    dw   $5063 
    dw   $5067 
    dw   $506b 
    dw   $5077        ;; 02:40b8 ????????
    dw   $507b 
    dw   $507f 
    dw   $5083 
    dw   $5087        ;; 02:40c0 ????????
    dw   $508b 
    dw   $508f 
    dw   $5093 
    dw   $5097        ;; 02:40c8 ????????
    dw   $509b 
    dw   $509f 
    dw   $50a3 
    dw   $50b7        ;; 02:40d0 ????????
    dw   $50bb 
    dw   $50bf 
    dw   $50c3 
    dw   $50cf        ;; 02:40d8 ????????
    dw   $50d3 
    dw   $50d7 
    dw   $50db 
    dw   $50e3        ;; 02:40e0 ????????
    dw   $50eb 
    dw   $50ef 
    dw   $50f3 
    dw   $50f7        ;; 02:40e8 ????????
    dw   $50ff 
    dw   $5107 
    dw   $510b 
    dw   $5113        ;; 02:40f0 ????????
    dw   $5117 
    dw   $511f 
    dw   $5123 
    dw   $512f        ;; 02:40f8 ????????
    dw   $5133 
    dw   $5137 
    dw   $513b 
    dw   $513f        ;; 02:4100 ????????
    dw   $5147 
    dw   $5157 
    dw   $515f 
    dw   $518b        ;; 02:4108 ????????
    dw   $518f 
    dw   $5193 
    dw   $5197 
    dw   $519b        ;; 02:4110 ????????
    dw   $51a3 
    dw   $51ab 
    dw   $51af                  ;; 02:4118 ??????
    dw   data_02_51b3                                         ;; 02:411e wW

data_02_4120:
INCLUDE "player_object_actions.asm"

call_02_489a:
    ld   HL, wD759                                     ;; 02:489a $21 $59 $d7
    set  6, [HL]                                       ;; 02:489d $cb $f6
    ld   C, $02                                        ;; 02:489f $0e $02
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:48a1 $fa $5a $d7
    and  A, $30                                        ;; 02:48a4 $e6 $30
    jr   Z, .jr_02_48b3                                ;; 02:48a6 $28 $0b
    ld   C, $05                                        ;; 02:48a8 $0e $05
    ld   A, [wD75E]                                    ;; 02:48aa $fa $5e $d7
    cp   A, $02                                        ;; 02:48ad $fe $02
    jr   NC, .jr_02_48b3                               ;; 02:48af $30 $02
    ld   C, $04                                        ;; 02:48b1 $0e $04
.jr_02_48b3:
    ld   A, C                                          ;; 02:48b3 $79
    jp   call_02_4ccd                                  ;; 02:48b4 $c3 $cd $4c

call_02_48b7:
    push AF                                            ;; 02:48b7 $f5
    ld   HL, wD624_CurrentLevelId                                     ;; 02:48b8 $21 $24 $d6
    ld   L, [HL]                                       ;; 02:48bb $6e
    ld   H, $00                                        ;; 02:48bc $26 $00
    ld   DE, data_02_491a                              ;; 02:48be $11 $1a $49
    add  HL, DE                                        ;; 02:48c1 $19
    ld   A, [HL]                                       ;; 02:48c2 $7e
    and  A, A                                          ;; 02:48c3 $a7
    jr   NZ, .jr_02_48c8                               ;; 02:48c4 $20 $02
    pop  AF                                            ;; 02:48c6 $f1
    ret                                                ;; 02:48c7 $c9
.jr_02_48c8:
    ld   C, A                                          ;; 02:48c8 $4f
    ld   H, $d2                                        ;; 02:48c9 $26 $d2
    ld   L, $20                                        ;; 02:48cb $2e $20
.jr_02_48cd:
    ld   A, [HL]                                       ;; 02:48cd $7e
    cp   A, $ff                                        ;; 02:48ce $fe $ff
    jr   Z, .jr_02_48d8                                ;; 02:48d0 $28 $06
    ld   A, L                                          ;; 02:48d2 $7d
    add  A, $20                                        ;; 02:48d3 $c6 $20
    ld   L, A                                          ;; 02:48d5 $6f
    jr   NZ, .jr_02_48cd                               ;; 02:48d6 $20 $f5
.jr_02_48d8:
    ld   A, L                                          ;; 02:48d8 $7d
    ld   [wD300], A                                    ;; 02:48d9 $ea $00 $d3
    or   A, $00                                        ;; 02:48dc $f6 $00
    ld   L, A                                          ;; 02:48de $6f
    ld   H, $d2                                        ;; 02:48df $26 $d2
    ld   [HL], C                                       ;; 02:48e1 $71
    ld   A, L                                          ;; 02:48e2 $7d
    xor  A, $16                                        ;; 02:48e3 $ee $16
    ld   L, A                                          ;; 02:48e5 $6f
    ld   [HL], $00                                     ;; 02:48e6 $36 $00
    ld   A, L                                          ;; 02:48e8 $7d
    xor  A, $1b                                        ;; 02:48e9 $ee $1b
    ld   L, A                                          ;; 02:48eb $6f
    ld   [HL], $00                                     ;; 02:48ec $36 $00
    ld   A, L                                          ;; 02:48ee $7d
    xor  A, $03                                        ;; 02:48ef $ee $03
    ld   L, A                                          ;; 02:48f1 $6f
    ld   DE, wD20E                                     ;; 02:48f2 $11 $0e $d2
    ld   A, [DE]                                       ;; 02:48f5 $1a
    add  A, $0f                                        ;; 02:48f6 $c6 $0f
    ld   C, A                                          ;; 02:48f8 $4f
    inc  DE                                            ;; 02:48f9 $13
    ld   A, [DE]                                       ;; 02:48fa $1a
    adc  A, $00                                        ;; 02:48fb $ce $00
    ld   B, A                                          ;; 02:48fd $47
    inc  DE                                            ;; 02:48fe $13
    ld   A, C                                          ;; 02:48ff $79

data_02_4900:
    and  A, $e0                                        ;; 02:4900 $e6 $e0
    ld   [HL+], A                                      ;; 02:4902 $22
    ld   A, B                                          ;; 02:4903 $78
    ld   [HL+], A                                      ;; 02:4904 $22
    ld   A, [DE]                                       ;; 02:4905 $1a
    and  A, $e0                                        ;; 02:4906 $e6 $e0
    or   A, $10                                        ;; 02:4908 $f6 $10
    ld   [HL+], A                                      ;; 02:490a $22
    inc  DE                                            ;; 02:490b $13
    ld   A, [DE]                                       ;; 02:490c $1a
    ld   [HL], A                                       ;; 02:490d $77
    pop  AF                                            ;; 02:490e $f1
    call call_02_7102                                  ;; 02:490f $cd $02 $71
    call call_00_34d8                                  ;; 02:4912 $cd $d8 $34
    xor  A, A                                          ;; 02:4915 $af
    ld   [wD300], A                                    ;; 02:4916 $ea $00 $d3
    ret                                                ;; 02:4919 $c9

data_02_491a:
    db   $00, $00, $18, $18, $00, $00, $00, $00        ;; 02:491a ????????
    db   $00, $00, $00, $18, $00, $00, $00, $00        ;; 02:4922 ????????
    db   $18, $00, $00, $00, $00, $00, $00, $00        ;; 02:492a ????????
    db   $00, $18, $00, $00, $00, $00, $00             ;; 02:4932 ???????

call_02_4939:
    ld   A, [wD61E]                                    ;; 02:4939 $fa $1e $d6
    and  A, A                                          ;; 02:493c $a7
    jr   Z, .jr_02_4965                                ;; 02:493d $28 $26
    ld   HL, wD61F                                     ;; 02:493f $21 $1f $d6
    dec  [HL]                                          ;; 02:4942 $35
    jr   NZ, .jr_02_495c                               ;; 02:4943 $20 $17
    ld   HL, wD61B                                     ;; 02:4945 $21 $1b $d6
    ld   E, [HL]                                       ;; 02:4948 $5e
    inc  HL                                            ;; 02:4949 $23
    ld   D, [HL]                                       ;; 02:494a $56
    ld   A, [DE]                                       ;; 02:494b $1a
    cp   A, $ff                                        ;; 02:494c $fe $ff
    jr   Z, .jr_02_4961                                ;; 02:494e $28 $11
    ld   [wD61F], A                                    ;; 02:4950 $ea $1f $d6
    inc  DE                                            ;; 02:4953 $13
    ld   A, [DE]                                       ;; 02:4954 $1a
    ld   [wD620], A                                    ;; 02:4955 $ea $20 $d6
    inc  DE                                            ;; 02:4958 $13
    ld   [HL], D                                       ;; 02:4959 $72
    dec  HL                                            ;; 02:495a $2b
    ld   [HL], E                                       ;; 02:495b $73
.jr_02_495c:
    ld   A, [wD620]                                    ;; 02:495c $fa $20 $d6
    jr   .jr_02_4968                                   ;; 02:495f $18 $07
.jr_02_4961:
    ld   [wD61E], A                                    ;; 02:4961 $ea $1e $d6
    ret                                                ;; 02:4964 $c9
.jr_02_4965:
    ld   A, [wD59F_CurrentInputs]                                    ;; 02:4965 $fa $9f $d5
.jr_02_4968:
    ld   C, A                                          ;; 02:4968 $4f
    ld   E, A                                          ;; 02:4969 $5f
    ld   HL, wD759                                     ;; 02:496a $21 $59 $d7
    bit  0, [HL]                                       ;; 02:496d $cb $46
    jr   Z, .jr_02_4979                                ;; 02:496f $28 $08
    bit  0, E                                          ;; 02:4971 $cb $43
    jr   NZ, .jr_02_4977                               ;; 02:4973 $20 $02
    res  0, [HL]                                       ;; 02:4975 $cb $86
.jr_02_4977:
    res  0, C                                          ;; 02:4977 $cb $81
.jr_02_4979:
    bit  6, [HL]                                       ;; 02:4979 $cb $76
    jr   Z, .jr_02_4989                                ;; 02:497b $28 $0c
    bit  1, E                                          ;; 02:497d $cb $4b
    jr   NZ, .jr_02_4985                               ;; 02:497f $20 $04
    ld   A, [HL]                                       ;; 02:4981 $7e
    and  A, $0f                                        ;; 02:4982 $e6 $0f
    ld   [HL], A                                       ;; 02:4984 $77
.jr_02_4985:
    res  1, C                                          ;; 02:4985 $cb $89
    jr   .jr_02_49a4                                   ;; 02:4987 $18 $1b
.jr_02_4989:
    bit  7, [HL]                                       ;; 02:4989 $cb $7e
    jr   Z, .jr_02_49a4                                ;; 02:498b $28 $17
    res  1, C                                          ;; 02:498d $cb $89
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:498f $fa $60 $d7
    bit  7, A                                          ;; 02:4992 $cb $7f
    jr   Z, .jr_02_49a4                                ;; 02:4994 $28 $0e
    bit  1, E                                          ;; 02:4996 $cb $4b
    jr   NZ, .jr_02_499e                               ;; 02:4998 $20 $04
    set  4, [HL]                                       ;; 02:499a $cb $e6
    jr   .jr_02_49a4                                   ;; 02:499c $18 $06
.jr_02_499e:
    bit  4, [HL]                                       ;; 02:499e $cb $66
    jr   Z, .jr_02_49a4                                ;; 02:49a0 $28 $02
    set  1, C                                          ;; 02:49a2 $cb $c9
.jr_02_49a4:
    ld   HL, wD75A_CurrentInputs                                     ;; 02:49a4 $21 $5a $d7
    ld   [HL], C                                       ;; 02:49a7 $71
    ld   HL, wD750                                     ;; 02:49a8 $21 $50 $d7
    ld   A, [HL]                                       ;; 02:49ab $7e
    and  A, A                                          ;; 02:49ac $a7
    jr   Z, .jr_02_49b0                                ;; 02:49ad $28 $01
    dec  [HL]                                          ;; 02:49af $35
.jr_02_49b0:
    call call_02_4a45                                  ;; 02:49b0 $cd $45 $4a
    ld   [wD59D_BankSwitch], A                                    ;; 02:49b3 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:49b6 $3e $03
    ld   HL, entry_03_4900                              ;; 02:49b8 $21 $00 $49
    call call_00_1078_SwitchBankWrapper                                  ;; 02:49bb $cd $78 $10
    call call_02_4b78                                  ;; 02:49be $cd $78 $4b
    ld   [wD59D_BankSwitch], A                                    ;; 02:49c1 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:49c4 $3e $03
    ld   HL, entry_03_4c0a                              ;; 02:49c6 $21 $0a $4c
    call call_00_1078_SwitchBankWrapper                                  ;; 02:49c9 $cd $78 $10
    call call_02_4c4f                                  ;; 02:49cc $cd $4f $4c
    ld   HL, wD745                                     ;; 02:49cf $21 $45 $d7
    ld   A, [HL]                                       ;; 02:49d2 $7e
    ld   [HL], $ff                                     ;; 02:49d3 $36 $ff
    cp   A, $ff                                        ;; 02:49d5 $fe $ff
    jr   Z, .jr_02_49e6                                ;; 02:49d7 $28 $0d
    call call_02_7102                                  ;; 02:49d9 $cd $02 $71
    ld   A, $ff                                        ;; 02:49dc $3e $ff
    ld   [wD746], A                                    ;; 02:49de $ea $46 $d7
    ld   A, $00                                        ;; 02:49e1 $3e $00
    ld   [wD74B], A                                    ;; 02:49e3 $ea $4b $d7
.jr_02_49e6:
    ld   HL, wD202                                     ;; 02:49e6 $21 $02 $d2
    ld   A, [HL+]                                      ;; 02:49e9 $2a
    ld   H, [HL]                                       ;; 02:49ea $66
    ld   L, A                                          ;; 02:49eb $6f
    call call_00_10bd_CallAltBankFunc                                  ;; 02:49ec $cd $bd $10
    call call_02_4a77                                  ;; 02:49ef $cd $77 $4a
    xor  A, A                                          ;; 02:49f2 $af
    ld   [wD758], A                                    ;; 02:49f3 $ea $58 $d7
    ld   HL, wD20E                                     ;; 02:49f6 $21 $0e $d2
    ld   A, [HL+]                                      ;; 02:49f9 $2a
    ld   H, [HL]                                       ;; 02:49fa $66
    ld   L, A                                          ;; 02:49fb $6f
    add  HL, HL                                        ;; 02:49fc $29
    add  HL, HL                                        ;; 02:49fd $29
    add  HL, HL                                        ;; 02:49fe $29
    ld   A, H                                          ;; 02:49ff $7c
    ld   [wD76A], A                                    ;; 02:4a00 $ea $6a $d7
    ld   HL, wD209                                     ;; 02:4a03 $21 $09 $d2
    res  5, [HL]                                       ;; 02:4a06 $cb $ae
    ld   HL, wD20A                                     ;; 02:4a08 $21 $0a $d2
    res  6, [HL]                                       ;; 02:4a0b $cb $b6
    call call_02_6fda                                  ;; 02:4a0d $cd $da $6f
    call call_02_715a                                  ;; 02:4a10 $cd $5a $71
    call call_02_4c28                                  ;; 02:4a13 $cd $28 $4c
    ld   [wD59D_BankSwitch], A                                    ;; 02:4a16 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:4a19 $3e $03
    ld   HL, entry_03_5ca8                              ;; 02:4a1b $21 $a8 $5c
    call call_00_1078_SwitchBankWrapper                                  ;; 02:4a1e $cd $78 $10
    ld   HL, wD751                                     ;; 02:4a21 $21 $51 $d7
    call call_02_4a30                                  ;; 02:4a24 $cd $30 $4a
    ld   HL, wD755                                     ;; 02:4a27 $21 $55 $d7
    call call_02_4a30                                  ;; 02:4a2a $cd $30 $4a
    ld   HL, wD753                                     ;; 02:4a2d $21 $53 $d7

call_02_4a30:
    ld   A, [HL+]                                      ;; 02:4a30 $2a
    ld   D, [HL]                                       ;; 02:4a31 $56
    ld   E, A                                          ;; 02:4a32 $5f
    or   A, D                                          ;; 02:4a33 $b2
    ret  Z                                             ;; 02:4a34 $c8
    dec  DE                                            ;; 02:4a35 $1b
    ld   [HL], D                                       ;; 02:4a36 $72
    dec  HL                                            ;; 02:4a37 $2b
    ld   [HL], E                                       ;; 02:4a38 $73
    ret                                                ;; 02:4a39 $c9

call_02_4a3a:
    ld   A, [wD759]                                    ;; 02:4a3a $fa $59 $d7
    and  A, $0f                                        ;; 02:4a3d $e6 $0f
    or   A, $80                                        ;; 02:4a3f $f6 $80
    ld   [wD759], A                                    ;; 02:4a41 $ea $59 $d7
    ret                                                ;; 02:4a44 $c9

call_02_4a45:
    ld   A, [wD746]                                    ;; 02:4a45 $fa $46 $d7
    cp   A, $ff                                        ;; 02:4a48 $fe $ff
    ret  NZ                                            ;; 02:4a4a $c0
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4a4b $fa $5a $d7
    and  A, $30                                        ;; 02:4a4e $e6 $30
    jr   Z, .jr_02_4a62                                ;; 02:4a50 $28 $10
    ld   C, $00                                        ;; 02:4a52 $0e $00
    and  A, $10                                        ;; 02:4a54 $e6 $10
    jr   NZ, .jr_02_4a5a                               ;; 02:4a56 $20 $02
    ld   C, $20                                        ;; 02:4a58 $0e $20
.jr_02_4a5a:
    ld   HL, wD20D                                     ;; 02:4a5a $21 $0d $d2
    ld   A, [HL]                                       ;; 02:4a5d $7e
    ld   [HL], C                                       ;; 02:4a5e $71
    cp   A, C                                          ;; 02:4a5f $b9
    jr   Z, .jr_02_4a67                                ;; 02:4a60 $28 $05
.jr_02_4a62:
    xor  A, A                                          ;; 02:4a62 $af
    ld   [wD75D], A                                    ;; 02:4a63 $ea $5d $d7
    ret                                                ;; 02:4a66 $c9
.jr_02_4a67:
    ld   A, [wD75D]                                    ;; 02:4a67 $fa $5d $d7
    ld   HL, wD75E                                     ;; 02:4a6a $21 $5e $d7
    cp   A, [HL]                                       ;; 02:4a6d $be
    jr   C, .jr_02_4a72                                ;; 02:4a6e $38 $02
    ld   A, [HL]                                       ;; 02:4a70 $7e
    dec  A                                             ;; 02:4a71 $3d
.jr_02_4a72:
    inc  A                                             ;; 02:4a72 $3c
    ld   [wD75D], A                                    ;; 02:4a73 $ea $5d $d7
    ret                                                ;; 02:4a76 $c9

call_02_4a77:
    ld   A, [wD746]                                    ;; 02:4a77 $fa $46 $d7
    cp   A, $ff                                        ;; 02:4a7a $fe $ff
    ret  NZ                                            ;; 02:4a7c $c0
    ld   A, [wD75D]                                    ;; 02:4a7d $fa $5d $d7
    ld   HL, wD20D                                     ;; 02:4a80 $21 $0d $d2
    bit  5, [HL]                                       ;; 02:4a83 $cb $6e
    jr   Z, .jr_02_4a89                                ;; 02:4a85 $28 $02
    cpl                                                ;; 02:4a87 $2f
    inc  A                                             ;; 02:4a88 $3c
.jr_02_4a89:
    ld   HL, wD75C                                     ;; 02:4a89 $21 $5c $d7
    add  A, [HL]                                       ;; 02:4a8c $86
    ret  Z                                             ;; 02:4a8d $c8
    push AF                                            ;; 02:4a8e $f5
    ld   A, [wD585]                                    ;; 02:4a8f $fa $85 $d5
    and  A, $0f                                        ;; 02:4a92 $e6 $0f
    jr   Z, .jr_02_4a9e                                ;; 02:4a94 $28 $08
    cpl                                                ;; 02:4a96 $2f
    inc  A                                             ;; 02:4a97 $3c
    ld   C, A                                          ;; 02:4a98 $4f
    ld   B, $ff                                        ;; 02:4a99 $06 $ff
    call call_02_4c19                                  ;; 02:4a9b $cd $19 $4c
.jr_02_4a9e:
    pop  AF                                            ;; 02:4a9e $f1
    ld   C, A                                          ;; 02:4a9f $4f
    bit  7, A                                          ;; 02:4aa0 $cb $7f
    jr   Z, .jr_02_4b10                                ;; 02:4aa2 $28 $6c
    cpl                                                ;; 02:4aa4 $2f
    inc  A                                             ;; 02:4aa5 $3c
    ld   C, A                                          ;; 02:4aa6 $4f
    jp   .jp_02_4aaa                                   ;; 02:4aa7 $c3 $aa $4a
.jp_02_4aaa:
    ld   A, [wD74E]                                    ;; 02:4aaa $fa $4e $d7
    and  A, A                                          ;; 02:4aad $a7
    jr   NZ, .jr_02_4ac0                               ;; 02:4aae $20 $10
    ld   A, [wD74F]                                    ;; 02:4ab0 $fa $4f $d7
    and  A, A                                          ;; 02:4ab3 $a7
    ret  NZ                                            ;; 02:4ab4 $c0
.jr_02_4ab5:
    ld   HL, wD20E                                     ;; 02:4ab5 $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4ab8 $7e
    sub  A, C                                          ;; 02:4ab9 $91
    ld   [HL+], A                                      ;; 02:4aba $22
    ld   A, [HL]                                       ;; 02:4abb $7e
    sbc  A, $00                                        ;; 02:4abc $de $00
    ld   [HL], A                                       ;; 02:4abe $77
    ret                                                ;; 02:4abf $c9
.jr_02_4ac0:
    or   A, $16                                        ;; 02:4ac0 $f6 $16
    ld   L, A                                          ;; 02:4ac2 $6f
    ld   H, $d2                                        ;; 02:4ac3 $26 $d2
    bit  7, [HL]                                       ;; 02:4ac5 $cb $7e
    jr   Z, .jr_02_4ae8                                ;; 02:4ac7 $28 $1f
    ld   A, L                                          ;; 02:4ac9 $7d
    xor  A, $04                                        ;; 02:4aca $ee $04
    ld   L, A                                          ;; 02:4acc $6f
    ld   A, [wD212]                                    ;; 02:4acd $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4ad0 $be
    jr   C, .jr_02_4ab5                                ;; 02:4ad1 $38 $e2
    ld   A, L                                          ;; 02:4ad3 $7d
    xor  A, $06                                        ;; 02:4ad4 $ee $06
    ld   L, A                                          ;; 02:4ad6 $6f
    ld   D, [HL]                                       ;; 02:4ad7 $56
    ld   A, L                                          ;; 02:4ad8 $7d
    xor  A, $1a                                        ;; 02:4ad9 $ee $1a
    ld   L, A                                          ;; 02:4adb $6f
    ld   A, [HL+]                                      ;; 02:4adc $2a
    add  A, D                                          ;; 02:4add $82
    ld   [wD20E], A                                    ;; 02:4ade $ea $0e $d2
    ld   A, [HL]                                       ;; 02:4ae1 $7e
    adc  A, $00                                        ;; 02:4ae2 $ce $00
    ld   [wD20F], A                                    ;; 02:4ae4 $ea $0f $d2
    ret                                                ;; 02:4ae7 $c9
.jr_02_4ae8:
    push HL                                            ;; 02:4ae8 $e5
    ld   HL, wD20E                                     ;; 02:4ae9 $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4aec $7e
    sub  A, C                                          ;; 02:4aed $91
    ld   [HL+], A                                      ;; 02:4aee $22
    ld   C, A                                          ;; 02:4aef $4f
    ld   A, [HL]                                       ;; 02:4af0 $7e
    sbc  A, $00                                        ;; 02:4af1 $de $00
    ld   [HL], A                                       ;; 02:4af3 $77
    ld   B, A                                          ;; 02:4af4 $47
    pop  HL                                            ;; 02:4af5 $e1
    ld   A, L                                          ;; 02:4af6 $7d
    xor  A, $04                                        ;; 02:4af7 $ee $04
    ld   L, A                                          ;; 02:4af9 $6f
    ld   A, [wD212]                                    ;; 02:4afa $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4afd $be
    ret  C                                             ;; 02:4afe $d8
    ld   A, L                                          ;; 02:4aff $7d
    xor  A, $06                                        ;; 02:4b00 $ee $06
    ld   L, A                                          ;; 02:4b02 $6f
    ld   D, [HL]                                       ;; 02:4b03 $56
    ld   A, L                                          ;; 02:4b04 $7d
    xor  A, $1a                                        ;; 02:4b05 $ee $1a
    ld   L, A                                          ;; 02:4b07 $6f
    ld   A, C                                          ;; 02:4b08 $79
    sub  A, D                                          ;; 02:4b09 $92
    ld   [HL+], A                                      ;; 02:4b0a $22
    ld   A, B                                          ;; 02:4b0b $78
    sbc  A, $00                                        ;; 02:4b0c $de $00
    ld   [HL], A                                       ;; 02:4b0e $77
    ret                                                ;; 02:4b0f $c9
.jr_02_4b10:
    ld   A, [wD74E]                                    ;; 02:4b10 $fa $4e $d7
    and  A, A                                          ;; 02:4b13 $a7
    jr   NZ, .jr_02_4b26                               ;; 02:4b14 $20 $10
    ld   A, [wD74F]                                    ;; 02:4b16 $fa $4f $d7
    and  A, A                                          ;; 02:4b19 $a7
    ret  NZ                                            ;; 02:4b1a $c0
.jr_02_4b1b:
    ld   HL, wD20E                                     ;; 02:4b1b $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4b1e $7e
    add  A, C                                          ;; 02:4b1f $81
    ld   [HL+], A                                      ;; 02:4b20 $22
    ld   A, [HL]                                       ;; 02:4b21 $7e
    adc  A, $00                                        ;; 02:4b22 $ce $00
    ld   [HL], A                                       ;; 02:4b24 $77
    ret                                                ;; 02:4b25 $c9
.jr_02_4b26:
    or   A, $16                                        ;; 02:4b26 $f6 $16
    ld   L, A                                          ;; 02:4b28 $6f
    ld   H, $d2                                        ;; 02:4b29 $26 $d2
    bit  7, [HL]                                       ;; 02:4b2b $cb $7e
    jr   Z, .jr_02_4b4f                                ;; 02:4b2d $28 $20
    ld   A, L                                          ;; 02:4b2f $7d
    xor  A, $04                                        ;; 02:4b30 $ee $04
    ld   L, A                                          ;; 02:4b32 $6f
    ld   A, [wD212]                                    ;; 02:4b33 $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4b36 $be
    jr   NC, .jr_02_4b1b                               ;; 02:4b37 $30 $e2
    ld   A, L                                          ;; 02:4b39 $7d
    xor  A, $06                                        ;; 02:4b3a $ee $06
    ld   L, A                                          ;; 02:4b3c $6f
    ld   D, [HL]                                       ;; 02:4b3d $56
    inc  D                                             ;; 02:4b3e $14
    ld   A, L                                          ;; 02:4b3f $7d
    xor  A, $1a                                        ;; 02:4b40 $ee $1a
    ld   L, A                                          ;; 02:4b42 $6f
    ld   A, [HL+]                                      ;; 02:4b43 $2a
    sub  A, D                                          ;; 02:4b44 $92
    ld   [wD20E], A                                    ;; 02:4b45 $ea $0e $d2
    ld   A, [HL]                                       ;; 02:4b48 $7e
    sbc  A, $00                                        ;; 02:4b49 $de $00
    ld   [wD20F], A                                    ;; 02:4b4b $ea $0f $d2
    ret                                                ;; 02:4b4e $c9
.jr_02_4b4f:
    push HL                                            ;; 02:4b4f $e5
    ld   HL, wD20E                                     ;; 02:4b50 $21 $0e $d2
    ld   A, [HL]                                       ;; 02:4b53 $7e
    add  A, C                                          ;; 02:4b54 $81
    ld   [HL+], A                                      ;; 02:4b55 $22
    ld   C, A                                          ;; 02:4b56 $4f
    ld   A, [HL]                                       ;; 02:4b57 $7e
    adc  A, $00                                        ;; 02:4b58 $ce $00
    ld   [HL], A                                       ;; 02:4b5a $77
    ld   B, A                                          ;; 02:4b5b $47
    pop  HL                                            ;; 02:4b5c $e1
    ld   A, L                                          ;; 02:4b5d $7d
    xor  A, $04                                        ;; 02:4b5e $ee $04
    ld   L, A                                          ;; 02:4b60 $6f
    ld   A, [wD212]                                    ;; 02:4b61 $fa $12 $d2
    cp   A, [HL]                                       ;; 02:4b64 $be
    ret  NC                                            ;; 02:4b65 $d0
    ld   A, L                                          ;; 02:4b66 $7d
    xor  A, $06                                        ;; 02:4b67 $ee $06
    ld   L, A                                          ;; 02:4b69 $6f
    ld   D, [HL]                                       ;; 02:4b6a $56
    inc  D                                             ;; 02:4b6b $14
    ld   A, L                                          ;; 02:4b6c $7d
    xor  A, $1a                                        ;; 02:4b6d $ee $1a
    ld   L, A                                          ;; 02:4b6f $6f
    ld   A, C                                          ;; 02:4b70 $79
    add  A, D                                          ;; 02:4b71 $82
    ld   [HL+], A                                      ;; 02:4b72 $22
    ld   A, B                                          ;; 02:4b73 $78
    adc  A, $00                                        ;; 02:4b74 $ce $00
    ld   [HL], A                                       ;; 02:4b76 $77
    ret                                                ;; 02:4b77 $c9

call_02_4b78:
    ld   A, [wD746]                                    ;; 02:4b78 $fa $46 $d7
    cp   A, $ff                                        ;; 02:4b7b $fe $ff
    ret  NZ                                            ;; 02:4b7d $c0
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:4b7e $fa $60 $d7
    bit  7, A                                          ;; 02:4b81 $cb $7f
    jr   NZ, .jr_02_4bbc                               ;; 02:4b83 $20 $37
    and  A, A                                          ;; 02:4b85 $a7
    jr   Z, .jr_02_4bbc                                ;; 02:4b86 $28 $34
    xor  A, A                                          ;; 02:4b88 $af
    ld   [wD763], A                                    ;; 02:4b89 $ea $63 $d7
.jr_02_4b8c:
    ld   A, [wD760_PlayerYVelocity]                                    ;; 02:4b8c $fa $60 $d7
    sub  A, $02                                        ;; 02:4b8f $d6 $02
    bit  7, A                                          ;; 02:4b91 $cb $7f
    jr   Z, .jr_02_4ba4                                ;; 02:4b93 $28 $0f
    cp   A, $c0                                        ;; 02:4b95 $fe $c0
    jr   NC, .jr_02_4ba4                               ;; 02:4b97 $30 $0b
    ld   HL, wD763                                     ;; 02:4b99 $21 $63 $d7
    ld   A, [HL]                                       ;; 02:4b9c $7e
    cp   A, $7f                                        ;; 02:4b9d $fe $7f
    adc  A, $00                                        ;; 02:4b9f $ce $00
    ld   [HL], A                                       ;; 02:4ba1 $77
    ld   A, $c0                                        ;; 02:4ba2 $3e $c0
.jr_02_4ba4:
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4ba4 $ea $60 $d7
    cpl                                                ;; 02:4ba7 $2f
    inc  A                                             ;; 02:4ba8 $3c
    swap A                                             ;; 02:4ba9 $cb $37
    and  A, $0f                                        ;; 02:4bab $e6 $0f
    ld   C, A                                          ;; 02:4bad $4f
    ld   B, $00                                        ;; 02:4bae $06 $00
    bit  3, A                                          ;; 02:4bb0 $cb $5f
    jp   Z, call_02_4c19                               ;; 02:4bb2 $ca $19 $4c
    or   A, $f0                                        ;; 02:4bb5 $f6 $f0
    ld   C, A                                          ;; 02:4bb7 $4f
    dec  B                                             ;; 02:4bb8 $05
    jp   call_02_4c19                                  ;; 02:4bb9 $c3 $19 $4c
.jr_02_4bbc:
    ld   A, [wD585]                                    ;; 02:4bbc $fa $85 $d5
    and  A, $80                                        ;; 02:4bbf $e6 $80
    jr   Z, .jr_02_4bd8                                ;; 02:4bc1 $28 $15
    ld   A, [wD761]                                    ;; 02:4bc3 $fa $61 $d7
    and  A, A                                          ;; 02:4bc6 $a7
    jr   Z, .jr_02_4bed                                ;; 02:4bc7 $28 $24
    ld   HL, wD584                                     ;; 02:4bc9 $21 $84 $d5
    bit  7, [HL]                                       ;; 02:4bcc $cb $7e
    jr   NZ, .jr_02_4ba4                               ;; 02:4bce $20 $d4
    ld   HL, wD760_PlayerYVelocity                                     ;; 02:4bd0 $21 $60 $d7
    cp   A, [HL]                                       ;; 02:4bd3 $be
    jr   NC, .jr_02_4ba4                               ;; 02:4bd4 $30 $ce
    jr   .jr_02_4b8c                                   ;; 02:4bd6 $18 $b4
.jr_02_4bd8:
    ld   A, [wD584]                                    ;; 02:4bd8 $fa $84 $d5
    and  A, $80                                        ;; 02:4bdb $e6 $80
    jr   NZ, .jr_02_4be6                               ;; 02:4bdd $20 $07
    ld   A, [wD763]                                    ;; 02:4bdf $fa $63 $d7
    cp   A, $10                                        ;; 02:4be2 $fe $10
    jr   C, .jr_02_4b8c                                ;; 02:4be4 $38 $a6
.jr_02_4be6:
    ld   A, $17                                        ;; 02:4be6 $3e $17
    call call_02_4ccd                                  ;; 02:4be8 $cd $cd $4c
    jr   .jr_02_4b8c                                   ;; 02:4beb $18 $9f
.jr_02_4bed:
    xor  A, A                                          ;; 02:4bed $af
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:4bee $ea $60 $d7
    ld   HL, wD763                                     ;; 02:4bf1 $21 $63 $d7
    ld   A, [HL]                                       ;; 02:4bf4 $7e
    ld   [HL], $00                                     ;; 02:4bf5 $36 $00
    cp   A, $08                                        ;; 02:4bf7 $fe $08
    jr   NC, .jr_02_4c00                               ;; 02:4bf9 $30 $05
    xor  A, A                                          ;; 02:4bfb $af
    ld   [wD762], A                                    ;; 02:4bfc $ea $62 $d7
    ret                                                ;; 02:4bff $c9
.jr_02_4c00:
    cp   A, $10                                        ;; 02:4c00 $fe $10
    jp   C, call_02_489a                                 ;; 02:4c02 $da $9a $48
    ld   A, $19                                        ;; 02:4c05 $3e $19
    jp   call_02_4ccd                                  ;; 02:4c07 $c3 $cd $4c

call_02_4c0a:
    ld   A, [wD20E]                                    ;; 02:4c0a $fa $0e $d2
    add  A, C                                          ;; 02:4c0d $81
    ld   [wD20E], A                                    ;; 02:4c0e $ea $0e $d2
    ld   A, [wD20F]                                    ;; 02:4c11 $fa $0f $d2
    adc  A, B                                          ;; 02:4c14 $88
    ld   [wD20F], A                                    ;; 02:4c15 $ea $0f $d2
    ret                                                ;; 02:4c18 $c9

call_02_4c19:
    ld   A, [wD210]                                    ;; 02:4c19 $fa $10 $d2
    add  A, C                                          ;; 02:4c1c $81
    ld   [wD210], A                                    ;; 02:4c1d $ea $10 $d2
    ld   A, [wD211]                                    ;; 02:4c20 $fa $11 $d2
    adc  A, B                                          ;; 02:4c23 $88
    ld   [wD211], A                                    ;; 02:4c24 $ea $11 $d2
    ret                                                ;; 02:4c27 $c9

call_02_4c28:
    ld   A, [wD765]                                    ;; 02:4c28 $fa $65 $d7
    sub  A, $25                                        ;; 02:4c2b $d6 $25
    jr   Z, .jr_02_4c3f                                ;; 02:4c2d $28 $10
    ld   A, [wD767]                                    ;; 02:4c2f $fa $67 $d7
    sub  A, $25                                        ;; 02:4c32 $d6 $25
    jr   Z, .jr_02_4c3f                                ;; 02:4c34 $28 $09
    ld   A, [wD765]                                    ;; 02:4c36 $fa $65 $d7
    sub  A, $24                                        ;; 02:4c39 $d6 $24
    jr   Z, .jr_02_4c3f                                ;; 02:4c3b $28 $02
    ld   A, $80                                        ;; 02:4c3d $3e $80
.jr_02_4c3f:
    xor  A, $80                                        ;; 02:4c3f $ee $80
    ld   [wD74A], A                                    ;; 02:4c41 $ea $4a $d7
    ld   A, [wD765]                                    ;; 02:4c44 $fa $65 $d7
    cp   A, $24                                        ;; 02:4c47 $fe $24
    ld   A, $1c                                        ;; 02:4c49 $3e $1c
    call Z, call_02_4ccd                               ;; 02:4c4b $cc $cd $4c
    ret                                                ;; 02:4c4e $c9

call_02_4c4f:
    ld   A, [wD201]                                    ;; 02:4c4f $fa $01 $d2
    cp   A, $10                                        ;; 02:4c52 $fe $10
    jr   Z, .jr_02_4c6a                                ;; 02:4c54 $28 $14
    cp   A, $11                                        ;; 02:4c56 $fe $11
    jr   Z, .jr_02_4c6a                                ;; 02:4c58 $28 $10
    ld   A, [wD764]                                    ;; 02:4c5a $fa $64 $d7
    cp   A, $23                                        ;; 02:4c5d $fe $23
    jp   Z, call_00_0696                                 ;; 02:4c5f $ca $96 $06
    ld   A, [wD765]                                    ;; 02:4c62 $fa $65 $d7
    cp   A, $23                                        ;; 02:4c65 $fe $23
    jp   Z, call_00_0696                                 ;; 02:4c67 $ca $96 $06
.jr_02_4c6a:
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4c6a $fa $5a $d7
    and  A, $40                                        ;; 02:4c6d $e6 $40
    jr   Z, .jr_02_4ca6                                ;; 02:4c6f $28 $35
    ld   A, [wD764]                                    ;; 02:4c71 $fa $64 $d7
    cp   A, $22                                        ;; 02:4c74 $fe $22
    ld   A, $1a                                        ;; 02:4c76 $3e $1a
    jr   Z, call_02_4ccd                               ;; 02:4c78 $28 $53
    ld   A, [wD764]                                    ;; 02:4c7a $fa $64 $d7
    ld   [wD769], A                                    ;; 02:4c7d $ea $69 $d7
    cp   A, $26                                        ;; 02:4c80 $fe $26
    jr   Z, .jr_02_4ca2                                ;; 02:4c82 $28 $1e
    ld   A, [wD766]                                    ;; 02:4c84 $fa $66 $d7
    ld   [wD769], A                                    ;; 02:4c87 $ea $69 $d7
    cp   A, $2c                                        ;; 02:4c8a $fe $2c
    jr   Z, .jr_02_4c9b                                ;; 02:4c8c $28 $0d
    cp   A, $2d                                        ;; 02:4c8e $fe $2d
    jr   NZ, .jr_02_4ca6                               ;; 02:4c90 $20 $14
    ld   A, [wD20D]                                    ;; 02:4c92 $fa $0d $d2
    cp   A, $00                                        ;; 02:4c95 $fe $00
    jr   NZ, .jr_02_4ca6                               ;; 02:4c97 $20 $0d
    jr   .jr_02_4ca2                                   ;; 02:4c99 $18 $07
.jr_02_4c9b:
    ld   A, [wD20D]                                    ;; 02:4c9b $fa $0d $d2
    cp   A, $20                                        ;; 02:4c9e $fe $20
    jr   NZ, .jr_02_4ca6                               ;; 02:4ca0 $20 $04
.jr_02_4ca2:
    ld   A, $1d                                        ;; 02:4ca2 $3e $1d
    jr   call_02_4ccd                                  ;; 02:4ca4 $18 $27
.jr_02_4ca6:
    ld   HL, wD201                                     ;; 02:4ca6 $21 $01 $d2
    ld   L, [HL]                                       ;; 02:4ca9 $6e
    ld   H, $00                                        ;; 02:4caa $26 $00
    add  HL, HL                                        ;; 02:4cac $29
    ld   DE, data_02_4d15                              ;; 02:4cad $11 $15 $4d
    add  HL, DE                                        ;; 02:4cb0 $19
    ld   A, [HL+]                                      ;; 02:4cb1 $2a
    ld   H, [HL]                                       ;; 02:4cb2 $66
    ld   L, A                                          ;; 02:4cb3 $6f
    or   A, H                                          ;; 02:4cb4 $b4
    ret  Z                                             ;; 02:4cb5 $c8
    ld   A, [wD75A_CurrentInputs]                                    ;; 02:4cb6 $fa $5a $d7
    ld   C, A                                          ;; 02:4cb9 $4f
.jr_02_4cba:
    ld   A, [HL+]                                      ;; 02:4cba $2a
    cp   A, $ff                                        ;; 02:4cbb $fe $ff
    ret  Z                                             ;; 02:4cbd $c8
    cp   A, $fe                                        ;; 02:4cbe $fe $fe
    jr   NZ, .jr_02_4cc6                               ;; 02:4cc0 $20 $04
    inc  C                                             ;; 02:4cc2 $0c
    dec  C                                             ;; 02:4cc3 $0d
    jr   NZ, .jr_02_4ccc                               ;; 02:4cc4 $20 $06
.jr_02_4cc6:
    cp   A, C                                          ;; 02:4cc6 $b9
    jr   Z, .jr_02_4ccc                                ;; 02:4cc7 $28 $03
    inc  HL                                            ;; 02:4cc9 $23
    jr   .jr_02_4cba                                   ;; 02:4cca $18 $ee
.jr_02_4ccc:
    ld   A, [HL+]                                      ;; 02:4ccc $2a

entry_02_4ccd:
call_02_4ccd:
    ld   HL, wD201                                     ;; 02:4ccd $21 $01 $d2
    cp   A, [HL]                                       ;; 02:4cd0 $be
    ret  Z                                             ;; 02:4cd1 $c8
    ld   L, A                                          ;; 02:4cd2 $6f
    ld   H, $00                                        ;; 02:4cd3 $26 $00
    ld   DE, .data_02_4cf5                             ;; 02:4cd5 $11 $f5 $4c
    add  HL, DE                                        ;; 02:4cd8 $19
    bit  0, [HL]                                       ;; 02:4cd9 $cb $46
    jr   NZ, .jr_02_4cf1                               ;; 02:4cdb $20 $14
    ld   HL, wD745                                     ;; 02:4cdd $21 $45 $d7
    bit  7, [HL]                                       ;; 02:4ce0 $cb $7e
    jr   Z, .jr_02_4ce7                                ;; 02:4ce2 $28 $03
    ld   HL, wD201                                     ;; 02:4ce4 $21 $01 $d2
.jr_02_4ce7:
    ld   L, [HL]                                       ;; 02:4ce7 $6e
    ld   H, $00                                        ;; 02:4ce8 $26 $00
    ld   DE, .data_02_4cf5                             ;; 02:4cea $11 $f5 $4c
    add  HL, DE                                        ;; 02:4ced $19
    bit  1, [HL]                                       ;; 02:4cee $cb $4e
    ret  NZ                                            ;; 02:4cf0 $c0
.jr_02_4cf1:
    ld   [wD745], A                                    ;; 02:4cf1 $ea $45 $d7
    ret                                                ;; 02:4cf4 $c9
.data_02_4cf5:
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4cf5 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $01        ;; 02:4cfd ????????
    db   $03, $03, $03, $03, $01, $00, $00, $00        ;; 02:4d05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4d0d ????????

data_02_4d15:
    db   $55, $4d, $00, $00, $58, $4d, $58, $4d        ;; 02:4d15 ........
    db   $65, $4d, $78, $4d, $8b, $4d, $92, $4d        ;; 02:4d1d ......??
    db   $9b, $4d, $a2, $4d, $a9, $4d, $b0, $4d        ;; 02:4d25 ......??
    db   $b1, $4d, $b2, $4d, $b3, $4d, $00, $00        ;; 02:4d2d ??..????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4d35 ......??
    db   $00, $00, $b4, $4d, $c5, $4d, $00, $00        ;; 02:4d3d ..??....
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4d45 ??..????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 02:4d4d ??..????
    
    db   $fe, $01, $ff, $02, $09, $01, $0d, $80        ;; 02:4d55 .w..w.w.
    db   $08, $04, $0e, $10, $04, $20, $04, $ff        ;; 02:4d5d w.?.w.w.
    db   $12, $09, $22, $09, $11, $0d, $21, $0d        ;; 02:4d65 .w.w.?.w
    db   $90, $08, $a0, $08, $14, $0e, $24, $0e        ;; 02:4d6d .?.?.?.?
    db   $00, $02, $ff, $12, $09, $22, $09, $11        ;; 02:4d75 .w..w.w.
    db   $0d, $21, $0d, $92, $0c, $a2, $0c, $80        ;; 02:4d7d w.w.?.?.
    db   $06, $40, $06, $00, $06, $ff, $10, $04        ;; 02:4d85 ?.?.w..?
    db   $20, $04, $fe, $02, $ff, $02, $09, $04        ;; 02:4d8d .w.w.???
    db   $0e, $10, $04, $20, $04, $ff, $02, $09        ;; 02:4d95 ??????.?
    db   $01, $0d, $00, $02, $ff, $01, $0d, $11        ;; 02:4d9d .?.w..w.
    db   $0d, $21, $0d, $ff, $01, $0d, $11, $0d        ;; 02:4da5 w.?..?.?
    db   $21, $0d, $ff, $ff, $ff, $ff, $ff, $12        ;; 02:4dad .w.??.??
    db   $09, $22, $09, $11, $0d, $21, $0d, $90        ;; 02:4db5 ????????
    db   $08, $a0, $08, $14, $0e, $24, $0e, $ff        ;; 02:4dbd ????????
    db   $12, $09, $22, $09, $11, $0d, $21, $0d        ;; 02:4dc5 .w.?.?.?
    db   $90, $08, $a0, $08, $14, $0e, $24, $0e        ;; 02:4dcd .?.?.?.?
    db   $00, $02, $ff                                 ;; 02:4dd5 .?.

call_02_4dd8:
    ld   A, $7d                                        ;; 02:4dd8 $3e $7d
    ret                                                ;; 02:4dda $c9

INCLUDE "other_object_actions.asm"
    
entry_02_6e17:
    xor  A, A                                          ;; 02:6e17 $af
    ld   [wD300], A                                    ;; 02:6e18 $ea $00 $d3
    ld   A, $00                                        ;; 02:6e1b $3e $00
    ld   [wD200], A                                    ;; 02:6e1d $ea $00 $d2
    ld   A, [wD744]                                    ;; 02:6e20 $fa $44 $d7
    call call_02_7102                                  ;; 02:6e23 $cd $02 $71
    xor  A, A                                          ;; 02:6e26 $af
    ld   [wD621], A                                    ;; 02:6e27 $ea $21 $d6
    xor  A, A                                          ;; 02:6e2a $af
    ld   [wD74C], A                                    ;; 02:6e2b $ea $4c $d7
    ld   [wD75D], A                                    ;; 02:6e2e $ea $5d $d7
    ld   [wD75E], A                                    ;; 02:6e31 $ea $5e $d7
    ld   [wD75C], A                                    ;; 02:6e34 $ea $5c $d7
    ld   [wD760_PlayerYVelocity], A                                    ;; 02:6e37 $ea $60 $d7
    ld   [wD761], A                                    ;; 02:6e3a $ea $61 $d7
    ld   [wD762], A                                    ;; 02:6e3d $ea $62 $d7
    ld   [wD763], A                                    ;; 02:6e40 $ea $63 $d7
    ld   [wD759], A                                    ;; 02:6e43 $ea $59 $d7
    ld   [wD758], A                                    ;; 02:6e46 $ea $58 $d7
    ld   [wD585], A                                    ;; 02:6e49 $ea $85 $d5
    ld   [wD584], A                                    ;; 02:6e4c $ea $84 $d5
    ld   A, $ff                                        ;; 02:6e4f $3e $ff
    ld   [wD745], A                                    ;; 02:6e51 $ea $45 $d7
    ld   [wD746], A                                    ;; 02:6e54 $ea $46 $d7
    xor  A, A                                          ;; 02:6e57 $af
    ld   [wD586], A                                    ;; 02:6e58 $ea $86 $d5
    ld   [wD74A], A                                    ;; 02:6e5b $ea $4a $d7
    ld   A, $00                                        ;; 02:6e5e $3e $00
    ld   [wD74B], A                                    ;; 02:6e60 $ea $4b $d7
    ld   A, $00                                        ;; 02:6e63 $3e $00
    ld   [wD20D], A                                    ;; 02:6e65 $ea $0d $d2

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
    ld   [wD59D_BankSwitch], A                                    ;; 02:6e93 $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:6e96 $3e $0a
    ld   HL, entry_0a_4000                              ;; 02:6e98 $21 $00 $40
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6e9b $cd $78 $10
.jr_02_6e9e:
    ld   [wD59D_BankSwitch], A                                    ;; 02:6e9e $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:6ea1 $3e $0a
    ld   HL, entry_0a_7a7c                              ;; 02:6ea3 $21 $7c $7a
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6ea6 $cd $78 $10
    ld   A, [wD338]                                    ;; 02:6ea9 $fa $38 $d3
    cp   A, $01                                        ;; 02:6eac $fe $01
    jr   NZ, .jr_02_6e9e                               ;; 02:6eae $20 $ee
    ret                                                ;; 02:6eb0 $c9

entry_02_6eb1:
    xor  A, A                                          ;; 02:6eb1 $af
    ld   HL, wD000                                     ;; 02:6eb2 $21 $00 $d0
.jr_02_6eb5:
    ld   [HL], A                                       ;; 02:6eb5 $77
    inc  L                                             ;; 02:6eb6 $2c
    jr   NZ, .jr_02_6eb5                               ;; 02:6eb7 $20 $fc
    ret                                                ;; 02:6eb9 $c9

entry_02_6eba:
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
    ld   [wD300], A                                    ;; 02:6ecf $ea $00 $d3
    or   A, $02                                        ;; 02:6ed2 $f6 $02
    ld   L, A                                          ;; 02:6ed4 $6f
    ld   H, $d2                                        ;; 02:6ed5 $26 $d2
    ld   A, [HL+]                                      ;; 02:6ed7 $2a
    ld   H, [HL]                                       ;; 02:6ed8 $66
    ld   L, A                                          ;; 02:6ed9 $6f
    call call_00_10bd_CallAltBankFunc                                  ;; 02:6eda $cd $bd $10
    ld   H, $d2                                        ;; 02:6edd $26 $d2
    ld   A, [wD74D]                                    ;; 02:6edf $fa $4d $d7
    and  A, $e0                                        ;; 02:6ee2 $e6 $e0
    or   A, $10                                        ;; 02:6ee4 $f6 $10
    ld   L, A                                          ;; 02:6ee6 $6f
    ld   A, [HL+]                                      ;; 02:6ee7 $2a
    sub  A, $10                                        ;; 02:6ee8 $d6 $10
    ld   [wD210], A                                    ;; 02:6eea $ea $10 $d2
    ld   A, [HL]                                       ;; 02:6eed $7e
    sbc  A, $00                                        ;; 02:6eee $de $00
    ld   [wD211], A                                    ;; 02:6ef0 $ea $11 $d2
.jr_02_6ef3:
    ld   A, [wD74F]                                    ;; 02:6ef3 $fa $4f $d7
    and  A, A                                          ;; 02:6ef6 $a7
    jr   Z, .jr_02_6f07                                ;; 02:6ef7 $28 $0e
    ld   [wD300], A                                    ;; 02:6ef9 $ea $00 $d3
    or   A, $02                                        ;; 02:6efc $f6 $02
    ld   L, A                                          ;; 02:6efe $6f
    ld   H, $d2                                        ;; 02:6eff $26 $d2
    ld   A, [HL+]                                      ;; 02:6f01 $2a
    ld   H, [HL]                                       ;; 02:6f02 $66
    ld   L, A                                          ;; 02:6f03 $6f
    call call_00_10bd_CallAltBankFunc                                  ;; 02:6f04 $cd $bd $10
.jr_02_6f07:
    ld   A, $00                                        ;; 02:6f07 $3e $00
    ld   [wD300], A                                    ;; 02:6f09 $ea $00 $d3
    call call_02_4939                                  ;; 02:6f0c $cd $39 $49
.jr_02_6f0f:
    ld   A, $20                                        ;; 02:6f0f $3e $20
.jr_02_6f11:
    ld   [wD300], A                                    ;; 02:6f11 $ea $00 $d3
    or   A, $00                                        ;; 02:6f14 $f6 $00
    ld   L, A                                          ;; 02:6f16 $6f
    ld   H, $d2                                        ;; 02:6f17 $26 $d2
    ld   A, [HL]                                       ;; 02:6f19 $7e
    cp   A, $ff                                        ;; 02:6f1a $fe $ff
    jr   Z, .jr_02_6f5c                                ;; 02:6f1c $28 $3e
    ld   A, [wD300]                                    ;; 02:6f1e $fa $00 $d3
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
    call call_00_10bd_CallAltBankFunc                                  ;; 02:6f35 $cd $bd $10
.jr_02_6f38:
    ld   H, $d2                                        ;; 02:6f38 $26 $d2
    ld   A, [wD300]                                    ;; 02:6f3a $fa $00 $d3
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
    ld   [wD59D_BankSwitch], A                                    ;; 02:6f51 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6f54 $3e $03
    ld   HL, entry_03_5ebf                              ;; 02:6f56 $21 $bf $5e
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6f59 $cd $78 $10
.jr_02_6f5c:
    ld   A, [wD300]                                    ;; 02:6f5c $fa $00 $d3
    add  A, $20                                        ;; 02:6f5f $c6 $20
    jr   NZ, .jr_02_6f11                               ;; 02:6f61 $20 $ae
    call call_00_1138                                  ;; 02:6f63 $cd $38 $11
    ld   [wD59D_BankSwitch], A                                    ;; 02:6f66 $ea $9d $d5
    ld   A, Bank0a                                        ;; 02:6f69 $3e $0a
    ld   HL, entry_0a_7a7c                              ;; 02:6f6b $21 $7c $7a
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6f6e $cd $78 $10
    call call_02_722c                                  ;; 02:6f71 $cd $2c $72
    ld   [wD59D_BankSwitch], A                                    ;; 02:6f74 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6f77 $3e $03
    ld   HL, entry_03_6540                              ;; 02:6f79 $21 $40 $65
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6f7c $cd $78 $10
    ret                                                ;; 02:6f7f $c9
    
entry_02_6f80:
    ld   A, $20                                        ;; 02:6f80 $3e $20
    ld   [wD739], A                                    ;; 02:6f82 $ea $39 $d7
    ld   A, [wD743]                                    ;; 02:6f85 $fa $43 $d7
    and  A, A                                          ;; 02:6f88 $a7
    jr   Z, .jr_02_6fa0                                ;; 02:6f89 $28 $15
    ld   A, $00                                        ;; 02:6f8b $3e $00
    ld   [wD300], A                                    ;; 02:6f8d $ea $00 $d3
    ld   [wD59D_BankSwitch], A                                    ;; 02:6f90 $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6f93 $3e $03
    ld   HL, entry_03_5ca8                              ;; 02:6f95 $21 $a8 $5c
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6f98 $cd $78 $10
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 02:6f9b $21 $0f $d6
    set  0, [HL]                                       ;; 02:6f9e $cb $c6
.jr_02_6fa0:
    ld   A, $20                                        ;; 02:6fa0 $3e $20
.jr_02_6fa2:
    ld   [wD300], A                                    ;; 02:6fa2 $ea $00 $d3
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
    ld   [wD59D_BankSwitch], A                                    ;; 02:6fbc $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6fbf $3e $03
    ld   HL, entry_03_5ebf                              ;; 02:6fc1 $21 $bf $5e
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6fc4 $cd $78 $10
.jr_02_6fc7:
    ld   A, [wD300]                                    ;; 02:6fc7 $fa $00 $d3
    add  A, $20                                        ;; 02:6fca $c6 $20
    jr   NZ, .jr_02_6fa2                               ;; 02:6fcc $20 $d4
    ld   [wD59D_BankSwitch], A                                    ;; 02:6fce $ea $9d $d5
    ld   A, Bank03                                        ;; 02:6fd1 $3e $03
    ld   HL, entry_03_6540                              ;; 02:6fd3 $21 $40 $65
    call call_00_1078_SwitchBankWrapper                                  ;; 02:6fd6 $cd $78 $10
    ret                                                ;; 02:6fd9 $c9

call_02_6fda:
    ld   H, $d2                                        ;; 02:6fda $26 $d2
    ld   A, [wD300]                                    ;; 02:6fdc $fa $00 $d3
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
    ld   A, [wD300]                                    ;; 02:7030 $fa $00 $d3
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
    ld   A, [wD300]                                    ;; 02:70f1 $fa $00 $d3
    or   A, $09                                        ;; 02:70f4 $f6 $09
    ld   L, A                                          ;; 02:70f6 $6f
    ld   H, $d2                                        ;; 02:70f7 $26 $d2
    ld   A, [HL]                                       ;; 02:70f9 $7e
    bit  7, A                                          ;; 02:70fa $cb $7f
    ret  Z                                             ;; 02:70fc $c8
    and  A, $1f                                        ;; 02:70fd $e6 $1f
    jp   call_02_4ccd                                  ;; 02:70ff $c3 $cd $4c

call_02_7102:
entry_02_7102:
; probably one of the main actor update functions, gets a jump table value from data_02_4000_ObjectJumpTables
; updates the object instances at D200-D300
; sets action id, action pointer, data_0c, unknown_pointer_04_05, and more?
    and  A, $1f                                        ;; 02:7102 $e6 $1f
    ld   C, A                                          ;; 02:7104 $4f
    ld   A, [wD300]                                    ;; 02:7105 $fa $00 $d3
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
    ld   A, [wD300]                                    ;; 02:7120 $fa $00 $d3
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
    ld   A, [wD300]                                    ;; 02:7131 $fa $00 $d3
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
    ld   A, [wD300]                                    ;; 02:71c8 $fa $00 $d3
    push AF                                            ;; 02:71cb $f5
    ld   A, $20                                        ;; 02:71cc $3e $20
.jr_02_71ce:
    ld   [wD300], A                                    ;; 02:71ce $ea $00 $d3
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
    ld   [wD59D_BankSwitch], A                                    ;; 02:71ef $ea $9d $d5
    ld   A, Bank0b                                        ;; 02:71f2 $3e $0b
    ld   HL, entry_0b_5f57                              ;; 02:71f4 $21 $57 $5f
    call call_00_1078_SwitchBankWrapper                                  ;; 02:71f7 $cd $78 $10
.jr_02_71fa:
    ld   A, [wD300]                                    ;; 02:71fa $fa $00 $d3
    add  A, $20                                        ;; 02:71fd $c6 $20
    jr   NZ, .jr_02_71ce                               ;; 02:71ff $20 $cd
    ld   [wD59D_BankSwitch], A                                    ;; 02:7201 $ea $9d $d5
    ld   A, Bank0b                                        ;; 02:7204 $3e $0b
    ld   HL, entry_03_5f1b                              ;; 02:7206 $21 $1b $5f
    call call_00_1078_SwitchBankWrapper                                  ;; 02:7209 $cd $78 $10
    pop  AF                                            ;; 02:720c $f1
    ld   [wD300], A                                    ;; 02:720d $ea $00 $d3
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
