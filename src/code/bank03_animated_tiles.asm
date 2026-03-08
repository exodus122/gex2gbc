call_03_723c_AnimatedTile_Init:
; Initializes the animated tile system for the current level. Uses wD624 (level ID) to index 
; data_03_72ab_AnimatedTileBlockPointerTable and get a pointer to the level's animated tile descriptor block. Reads the first 
; byte of that block (tile frame count) into wD611_AnimatedTileId, and zeros the frame counter wD612
    ld   HL, wD624_CurrentLevelId                                     ;; 03:723c $21 $24 $d6
    ld   L, [HL]                                       ;; 03:723f $6e
    ld   H, $00                                        ;; 03:7240 $26 $00
    add  HL, HL                                        ;; 03:7242 $29
    ld   DE, data_03_72ab_AnimatedTileBlockPointerTable                              ;; 03:7243 $11 $ab $72
    add  HL, DE                                        ;; 03:7246 $19
    ld   A, [HL+]                                      ;; 03:7247 $2a
    ld   H, [HL]                                       ;; 03:7248 $66
    ld   L, A                                          ;; 03:7249 $6f
    ld   A, [HL]                                       ;; 03:724a $7e
    ld   [wD611_AnimatedTileId], A                                    ;; 03:724b $ea $11 $d6
    xor  A, A                                          ;; 03:724e $af
    ld   [wD612_AnimatedTime_FrameCounter], A                                    ;; 03:724f $ea $12 $d6
    ret                                                ;; 03:7252 $c9

call_03_7253_AnimatedTile_Update:
; Per-frame animated tile updater. Returns immediately if wD611 is zero (no animated tiles this level). 
; Looks up the level's animated tile block, reads the frame count, increments wD612 (frame counter) 
; and wraps it. Uses the frame index × 8 to index into the block's per-frame descriptor records. 
; Each record: (tile count B, VRAM dest lo C, VRAM dest hi, source bank E, source address D/+1, 
; tile data pointer HL). If bit 7 of C is set (conditional tile flag): checks wD72D (secondary tileset index) 
; and wD5A3_ConveyorState1–wD5A5_ConveyorState3 (conveyor states) — if the relevant conveyor is inactive, substitutes data_03_7bfd_AnimatedTile_BlankTileData 
; (blank/off tile) instead. Calls call_03_6f2d B times to copy B tiles of 16 bytes each to the 
; specified VRAM destination
    ld   A, [wD611_AnimatedTileId]                                    ;; 03:7253 $fa $11 $d6
    and  A, A                                          ;; 03:7256 $a7
    ret  Z                                             ;; 03:7257 $c8
    ld   HL, wD624_CurrentLevelId                                     ;; 03:7258 $21 $24 $d6
    ld   L, [HL]                                       ;; 03:725b $6e
    ld   H, $00                                        ;; 03:725c $26 $00
    add  HL, HL                                        ;; 03:725e $29
    ld   DE, data_03_72ab_AnimatedTileBlockPointerTable                              ;; 03:725f $11 $ab $72
    add  HL, DE                                        ;; 03:7262 $19
    ld   E, [HL]                                       ;; 03:7263 $5e
    inc  HL                                            ;; 03:7264 $23
    ld   D, [HL]                                       ;; 03:7265 $56
    ld   A, [DE]                                       ;; 03:7266 $1a
    inc  DE                                            ;; 03:7267 $13
    ld   HL, wD612_AnimatedTime_FrameCounter                                     ;; 03:7268 $21 $12 $d6
    inc  [HL]                                          ;; 03:726b $34
    sub  A, [HL]                                       ;; 03:726c $96
    jr   NZ, .jr_03_7271                               ;; 03:726d $20 $02
    ld   [HL], $00                                     ;; 03:726f $36 $00
.jr_03_7271:
    ld   L, [HL]                                       ;; 03:7271 $6e
    ld   H, $00                                        ;; 03:7272 $26 $00
    add  HL, HL                                        ;; 03:7274 $29
    add  HL, HL                                        ;; 03:7275 $29
    add  HL, HL                                        ;; 03:7276 $29
    add  HL, DE                                        ;; 03:7277 $19
    ld   B, [HL]                                       ;; 03:7278 $46
    inc  HL                                            ;; 03:7279 $23
    ld   C, [HL]                                       ;; 03:727a $4e
    inc  HL                                            ;; 03:727b $23
    ld   E, [HL]                                       ;; 03:727c $5e
    inc  HL                                            ;; 03:727d $23
    ld   D, [HL]                                       ;; 03:727e $56
    inc  HL                                            ;; 03:727f $23
    ld   A, [HL+]                                      ;; 03:7280 $2a
    ld   H, [HL]                                       ;; 03:7281 $66
    ld   L, A                                          ;; 03:7282 $6f
    bit  7, C                                          ;; 03:7283 $cb $79
    jr   Z, .jr_03_72a4                                ;; 03:7285 $28 $1d
    ld   A, [wD72D_SecondaryTilesetIndex]                                    ;; 03:7287 $fa $2d $d7
    cp   A, $00                                        ;; 03:728a $fe $00
    ret  NZ                                            ;; 03:728c $c0
    res  7, C                                          ;; 03:728d $cb $b9
    ld   A, [wD5A3_ConveyorState1]                                    ;; 03:728f $fa $a3 $d5
    dec  C                                             ;; 03:7292 $0d
    jr   Z, .jr_03_729e                                ;; 03:7293 $28 $09
    ld   A, [wD5A4_ConveyorState2]                                    ;; 03:7295 $fa $a4 $d5
    dec  C                                             ;; 03:7298 $0d
    jr   Z, .jr_03_729e                                ;; 03:7299 $28 $03
    ld   A, [wD5A5_ConveyorState3]                                    ;; 03:729b $fa $a5 $d5
.jr_03_729e:
    and  A, A                                          ;; 03:729e $a7
    jr   NZ, .jr_03_72a4                               ;; 03:729f $20 $03
    ld   HL, data_03_7bfd_AnimatedTile_BlankTileData                              ;; 03:72a1 $21 $fd $7b
.jr_03_72a4:
    call call_03_6f2d_VRAM_Copy16Bytes                                  ;; 03:72a4 $cd $2d $6f
    dec  B                                             ;; 03:72a7 $05
    jr   NZ, .jr_03_72a4                               ;; 03:72a8 $20 $fa
    ret                                                ;; 03:72aa $c9

data_03_72ab_AnimatedTileBlockPointerTable:
; 31-entry pointer table mapping level IDs to animated tile descriptor blocks. 
; Points to one of 5 blocks: media_dimension ($00 = none), toon_tv (12 frames, 3 tile groups), 
; scream_tv (14 frames, 4 tile groups), circuit_central (12 frames, 3 conditional conveyor 
; belt tile groups), rezopolis (12 frames, 3 tile groups). Media Dimension and most hub/transition 
; levels use the null entry
    dw   .data_03_72e8_AnimatedTileBlock_None                                  ;; 03:72ab pP
    dw   .data_03_72e9_AnimatedTileBlock_ToonTV                                  ;; 03:72ad pP
    dw   .data_03_734a_AnimatedTileBlock_ScreamTV                                  ;; 03:72af pP
    dw   .data_03_734a_AnimatedTileBlock_ScreamTV
    dw   .data_03_73bb_AnimatedTileBlock_CircuitCentral
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e9_AnimatedTileBlock_ToonTV
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_73bb_AnimatedTileBlock_CircuitCentral
    dw   .data_03_734a_AnimatedTileBlock_ScreamTV
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_741c_AnimatedTileBlock_Rezopolis
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_734a_AnimatedTileBlock_ScreamTV
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_741c_AnimatedTileBlock_Rezopolis
    dw   .data_03_73bb_AnimatedTileBlock_CircuitCentral
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_734a_AnimatedTileBlock_ScreamTV
    dw   .data_03_741c_AnimatedTileBlock_Rezopolis
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    dw   .data_03_72e8_AnimatedTileBlock_None
    db   $e8
.data_03_72e8_AnimatedTileBlock_None:
; Single byte $00 — no animated tiles. Used for Media Dimension and levels without tile animation
    db   $00                                           ;; 03:72e8 .
.data_03_72e9_AnimatedTileBlock_ToonTV:
; 12-frame animated tile block for Toon TV. 3 parallel tile groups animating 4 frames each: 
; group 1 writes 4 tiles to VRAM_ANIMATED_TILE_TOON_TV_GROUP_1, group 2 writes 2 tiles to VRAM_ANIMATED_TILE_TOON_TV_GROUP_2, group 3 writes 4 tiles to VRAM_ANIMATED_TILE_TOON_TV_GROUP_3. 
; Used for the water/pool/cartoon environment animations
    db   $0c
    
    db   $04, $00                                 ;; 03:72e9 ...
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_1
    dw   .data_03_747d
    db   $00, $00
    
    db   $02, $00                  ;; 03:72ee ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_2
    dw   .data_03_757d
    db   $00, $00
    
    db   $04, $00                  ;; 03:72f6 ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_3
    dw   .data_03_75fd
    db   $00, $00
    
    db   $04, $00                  ;; 03:72fe ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_1
    dw   .data_03_74bd
    db   $00, $00
    
    db   $02, $00                  ;; 03:7306 ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_2
    dw   .data_03_759d
    db   $00, $00
    
    db   $04, $00                  ;; 03:730e ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_3
    dw   .data_03_763d
    db   $00, $00
    
    db   $04, $00                  ;; 03:7316 ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_1
    dw   .data_03_74fd
    db   $00, $00
    
    db   $02, $00                  ;; 03:731e ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_2
    dw   .data_03_75bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:7326 ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_3
    dw   .data_03_767d
    db   $00, $00
    
    db   $04, $00                  ;; 03:732e ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_1
    dw   .data_03_753d
    db   $00, $00
    
    db   $02, $00                  ;; 03:7336 ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_2
    dw   .data_03_75dd
    db   $00, $00
    
    db   $04, $00                  ;; 03:733e ..??..
    dw   VRAM_ANIMATED_TILE_TOON_TV_GROUP_3
    dw   .data_03_76bd
    db   $00, $00                            ;; 03:7346 ..??
.data_03_734a_AnimatedTileBlock_ScreamTV:
; 14-frame animated tile block for Scream TV. 4 tile groups: 2 tiles to VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_1, 6 tiles to VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2, 
; 4 tiles to VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3, 4 tiles to VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4. Used for the haunted/horror environment animations (candles, lightning, etc.)
    db   $0e
    
    db   $02, $00                                 ;; 03:734a ...
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_1
    dw   .data_03_787d
    db   $00, $00
    
    db   $06, $00                  ;; 03:734f ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2
    dw   .data_03_76fd
    db   $00, $00
    
    db   $04, $00                  ;; 03:7357 ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3
    dw   .data_03_78bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:735f ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4
    dw   .data_03_78fd
    db   $00, $00
    
    db   $06, $00                  ;; 03:7367 ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2
    dw   .data_03_775d
    db   $00, $00
    
    db   $04, $00                  ;; 03:736f ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3
    dw   .data_03_793d
    db   $00, $00
    
    db   $04, $00                  ;; 03:7377 ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4
    dw   .data_03_797d
    db   $00, $00
    
    db   $02, $00                  ;; 03:737f ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_1
    dw   .data_03_789d
    db   $00, $00
    
    db   $06, $00                  ;; 03:7387 ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2
    dw   .data_03_77bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:738f ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3
    dw   .data_03_79bd
    db   $00, $00
    
    db   $04, $00                  ;; 03:7397 ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4
    dw   .data_03_79fd
    db   $00, $00
    
    db   $06, $00                  ;; 03:739f ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2
    dw   .data_03_781d
    db   $00, $00
    
    db   $04, $00                  ;; 03:73a7 ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3
    dw   .data_03_7a3d
    db   $00, $00
    
    db   $04, $00                  ;; 03:73af ..??..
    dw   VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4
    dw   .data_03_7a7d
    db   $00, $00
.data_03_73bb_AnimatedTileBlock_CircuitCentral:
; 12-frame animated tile block for Circuit Central. 3 tile groups each writing 2 tiles with conditional 
; conveyor belt logic (bit 7 of dest byte set): groups at $81E0/$91, $8200/$92, $8320/$92, cycling 
; through 4 frame sets. If the corresponding conveyor slot (wD5A3_ConveyorState1–wD5A5_ConveyorState3) is inactive, substitutes 
; blank tiles from data_03_7bfd_AnimatedTile_BlankTileData
    db   $0c
    
    db   $02, $81        ;; 03:73bb ..??????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1     
    dw   .data_03_7b7d
    db   $00, $00
    
    db   $02, $82        ;; 03:73bf ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2
    dw   .data_03_7b7d
    db   $00, $00
    
    db   $02, $83        ;; 03:73c7 ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3
    dw   .data_03_7b7d
    db   $00, $00
    
    db   $02, $81        ;; 03:73cf ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1 
    dw   .data_03_7b9d
    db   $00, $00
    
    db   $02, $82        ;; 03:73d7 ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2
    dw   .data_03_7b9d
    db   $00, $00
    
    db   $02, $83        ;; 03:73df ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3
    dw   .data_03_7b9d
    db   $00, $00
    
    db   $02, $81        ;; 03:73e7 ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1 
    dw   .data_03_7bbd
    db   $00, $00
    
    db   $02, $82        ;; 03:73ef ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2
    dw   .data_03_7bbd
    db   $00, $00
    
    db   $02, $83        ;; 03:73f7 ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3
    dw   .data_03_7bbd
    db   $00, $00
    
    db   $02, $81        ;; 03:73ff ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1 
    dw   .data_03_7bdd
    db   $00, $00
    
    db   $02, $82        ;; 03:7407 ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2
    dw   .data_03_7bdd
    db   $00, $00
    
    db   $02, $83        ;; 03:740f ????????
    dw   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3
    dw   .data_03_7bdd
    db   $00, $00
.data_03_741c_AnimatedTileBlock_Rezopolis:
; 12-frame animated tile block for Rezopolis. 3 tile groups: 2 tiles to $8CB0, 1 tile to $8E00, 
; 1 tile to $8F00, cycling through 4 frame sets. Used for the neon/electric environment animations
    db   $0c
    
    db   $02, $00        ;; 03:7417 ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1
    dw   .data_03_7abd
    db   $00
    
    db   $00, $01, $00        ;; 03:741f ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2
    dw   .data_03_7afd
    db   $00
    
    db   $00, $01, $00        ;; 03:7427 ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3
    dw   .data_03_7b3d
    db   $00
    
    db   $00, $02, $00        ;; 03:742f ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1
    dw   .data_03_7add
    db   $00
    
    db   $00, $01, $00        ;; 03:7437 ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2
    dw   .data_03_7b0d
    db   $00
    
    db   $00, $01, $00        ;; 03:743f ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3
    dw   .data_03_7b4d
    db   $00
    
    db   $00, $02, $00        ;; 03:7447 ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1
    dw   .data_03_7abd
    db   $00
    
    db   $00, $01, $00        ;; 03:744f ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2
    dw   .data_03_7b1d
    db   $00
    
    db   $00, $01, $00        ;; 03:7457 ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3
    dw   .data_03_7b5d
    db   $00
    
    db   $00, $02, $00        ;; 03:745f ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1
    dw   .data_03_7add
    db   $00
    
    db   $00, $01, $00        ;; 03:7467 ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2
    dw   .data_03_7b2d
    db   $00
    
    db   $00, $01, $00        ;; 03:746f ????????
    dw   VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3
    dw   .data_03_7b6d
    db   $00, $00                  ;; 03:7477 ??????
.data_03_747d:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_747d.bin"
.data_03_74bd:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_74bd.bin"
.data_03_74fd:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_74fd.bin"
.data_03_753d:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_753d.bin"
.data_03_757d:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_757d.bin"
.data_03_759d:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_759d.bin"
.data_03_75bd:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_75bd.bin"
.data_03_75dd:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_75dd.bin"
.data_03_75fd:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_75fd.bin"
.data_03_763d:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_763d.bin"
.data_03_767d:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_767d.bin"
.data_03_76bd:
    INCBIN ".gfx/animated_tiles/toon_tv/image_003_76bd.bin"
.data_03_76fd:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_76fd.bin"
.data_03_775d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_775d.bin"
.data_03_77bd:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_77bd.bin"
.data_03_781d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_781d.bin"
.data_03_787d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_787d.bin"
.data_03_789d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_789d.bin"
.data_03_78bd:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_78bd.bin"
.data_03_78fd:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_78fd.bin"
.data_03_793d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_793d.bin"
.data_03_797d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_797d.bin"
.data_03_79bd:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_79bd.bin"
.data_03_79fd:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_79fd.bin"
.data_03_7a3d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_7a3d.bin"
.data_03_7a7d:
    INCBIN ".gfx/animated_tiles/scream_tv/image_003_7a7d.bin"
.data_03_7abd:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7abd.bin"
.data_03_7add:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7add.bin"
.data_03_7afd:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7afd.bin"
.data_03_7b0d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b0d.bin"
.data_03_7b1d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b1d.bin"
.data_03_7b2d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b2d.bin"
.data_03_7b3d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b3d.bin"
.data_03_7b4d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b4d.bin"
.data_03_7b5d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b5d.bin"
.data_03_7b6d:
    INCBIN ".gfx/animated_tiles/rezopolis/image_003_7b6d.bin"
.data_03_7b7d:
    INCBIN ".gfx/animated_tiles/circuit_central/image_003_7b7d.bin"
.data_03_7b9d:
    INCBIN ".gfx/animated_tiles/circuit_central/image_003_7b9d.bin"
.data_03_7bbd:
    INCBIN ".gfx/animated_tiles/circuit_central/image_003_7bbd.bin"
.data_03_7bdd:
    INCBIN ".gfx/animated_tiles/circuit_central/image_003_7bdd.bin"

data_03_7bfd_AnimatedTile_BlankTileData:
; 32-byte buffer of zeros (with $FF sentinel bytes at start and end) used as a substitute 
; tile when a conditional animated tile slot is inactive (e.g. conveyor belt is off in Circuit Central)
    db   $ff, $00, $00, $00, $00, $00, $00, $00        ;; 03:7bfd ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 03:7c05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 03:7c0d ????????
    db   $00, $00, $00, $00, $00, $00, $ff, $00        ;; 03:7c15 ???????
