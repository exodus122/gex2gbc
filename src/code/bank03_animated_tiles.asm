; ==================================================================
; MAP TILE ANIMATION
;
; The cycling tiles that belong to a LEVEL - water, lava, the Circuit Central conveyor
; belts. wD624_CurrentLevelId picks a schedule out of
; data_03_72ab_MapTileAnim_ScheduleByLevel, and from then until the level ends the
; vblank handler walks that schedule one step per frame, rewriting a few tiles of VRAM
; each time.
;
; This is not the only tile animation in the game, and the two are easy to confuse.
; The other one belongs to the SECONDARY TILESET rather than to the level, keeps its
; state in wD72E_TilesetAnim_Bank onward, and is played by .jp_00_0b24_TilesetAnim_PlayFrame
; in bank00_home.asm. The differences that matter:
;
;                       map tile animation          secondary tileset animation
;   owned by            the level                   the loaded secondary tileset
;   set up by           MapTileAnim_Init            BgMap_LoadSecondaryTileset
;   state               wD611, wD612                wD72E-wD738
;   rate                one step every vblank       one frame every wD731 vblanks
;   can stop            no, runs while the level does  yes, flags bit 0 plays it once
;   priority in vblank  last                        ahead of the HUD reloads
;
; They also cannot both run in one vblank - call_00_0ac1_VBlank_UpdateVRAM picks a
; single VRAM job per frame and this one is the fallback it reaches when nothing else
; wants the time. And they interact once: a conditional step here refuses to run at all
; while wD72D_SecondaryTilesetIndex is nonzero, so a room that has swapped its
; secondary tileset in freezes its conveyor tiles.
;
; A SCHEDULE IS A ROUND ROBIN, NOT A FILM STRIP. The first byte is the number of steps;
; each step after it is one map_tile_anim_step naming a tile count, a VRAM destination
; and a page of artwork. Toon TV's twelve steps are three groups of tiles visited four
; times each, in the order 1 2 3 1 2 3 1 2 3 1 2 3 - so each group advances one frame
; every third vblank and the three animate in parallel at a third of the frame rate.
; That is the whole trick: the schedule length divided by the number of groups is each
; group's frame count, and the cost per vblank stays at one small copy no matter how
; many things are animating
; ==================================================================

call_03_723c_MapTileAnim_Init:
; Called once when a level loads. Reads the schedule's length byte into
; wD611_MapTileAnim_StepCount, which doubles as the enable flag - a level whose
; schedule is .data_03_72e8_MapTileAnim_Schedule_None stores zero here and
; MapTileAnim_Update returns immediately from then on
    ld   HL, wD624_CurrentLevelId                                     ;; 03:723c $21 $24 $d6
    ld   L, [HL]                                       ;; 03:723f $6e
    ld   H, $00                                        ;; 03:7240 $26 $00
    add  HL, HL                                        ;; 03:7242 $29
    ld   DE, data_03_72ab_MapTileAnim_ScheduleByLevel                              ;; 03:7243 $11 $ab $72
    add  HL, DE                                        ;; 03:7246 $19
    ld   A, [HL+]                                      ;; 03:7247 $2a
    ld   H, [HL]                                       ;; 03:7248 $66
    ld   L, A                                          ;; 03:7249 $6f
    ld   A, [HL]                                       ;; 03:724a $7e
    ld   [wD611_MapTileAnim_StepCount], A                                    ;; 03:724b $ea $11 $d6
    xor  A, A                                          ;; 03:724e $af
    ld   [wD612_MapTileAnim_StepIndex], A                                    ;; 03:724f $ea $12 $d6
    ret                                                ;; 03:7252 $c9

call_03_7253_MapTileAnim_Update:
; Runs one step of the level's schedule, once per vblank, and no more than one - the
; step index advances and the routine returns, so the cost is a single small copy
; however many groups the level animates.
;
; wD612_MapTileAnim_StepIndex is incremented first and wrapped against the schedule
; length, then multiplied by the eight-byte step size to reach the record. The record
; is unpacked into exactly the registers the copy needs: B = tile count, C = the
; condition byte, DE = VRAM destination, HL = artwork.
;
; A conditional step - MAP_TILE_ANIM_IF_CONVEYOR in the condition byte - has two ways
; of not drawing. If wD72D_SecondaryTilesetIndex is nonzero the routine returns without
; copying anything, because the tiles it would write no longer belong to it. Otherwise
; the low bits name a conveyor, and a stopped conveyor swaps the artwork pointer for
; data_03_7bfd_MapTileAnim_BlankTile so the belt is drawn as bare tiles instead of
; moving ones. Only the Circuit Central schedule uses either path.
;
; Note the copy loop calls VRAM_Copy16Bytes B times without touching DE or HL between
; calls, so that routine has to leave both advanced by one tile
    ld   A, [wD611_MapTileAnim_StepCount]                                    ;; 03:7253 $fa $11 $d6
    and  A, A                                          ;; 03:7256 $a7
    ret  Z                                             ;; 03:7257 $c8
    ld   HL, wD624_CurrentLevelId                                     ;; 03:7258 $21 $24 $d6
    ld   L, [HL]                                       ;; 03:725b $6e
    ld   H, $00                                        ;; 03:725c $26 $00
    add  HL, HL                                        ;; 03:725e $29
    ld   DE, data_03_72ab_MapTileAnim_ScheduleByLevel                              ;; 03:725f $11 $ab $72
    add  HL, DE                                        ;; 03:7262 $19
    ld   E, [HL]                                       ;; 03:7263 $5e
    inc  HL                                            ;; 03:7264 $23
    ld   D, [HL]                                       ;; 03:7265 $56
    ld   A, [DE]                                       ;; 03:7266 $1a
    inc  DE                                            ;; 03:7267 $13
    ld   HL, wD612_MapTileAnim_StepIndex                                     ;; 03:7268 $21 $12 $d6
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
    ld   HL, data_03_7bfd_MapTileAnim_BlankTile                              ;; 03:72a1 $21 $fd $7b
.jr_03_72a4:
    call call_03_6f2d_VRAM_Copy16Bytes                                  ;; 03:72a4 $cd $2d $6f
    dec  B                                             ;; 03:72a7 $05
    jr   NZ, .jr_03_72a4                               ;; 03:72a8 $20 $fa
    ret                                                ;; 03:72aa $c9

data_03_72ab_MapTileAnim_ScheduleByLevel:
; One pointer per level id, 31 of them, into five shared schedules. Levels of the same
; world point at the same schedule - the animation belongs to the world's artwork, not
; to the room - and everything with no cycling tiles, the hub included, points at the
; empty one
    dw   .data_03_72e8_MapTileAnim_Schedule_None                                  ;; 03:72ab pP
    dw   .data_03_72e9_MapTileAnim_Schedule_ToonTV                                  ;; 03:72ad pP
    dw   .data_03_734a_MapTileAnim_Schedule_ScreamTV                                  ;; 03:72af pP
    dw   .data_03_734a_MapTileAnim_Schedule_ScreamTV
    dw   .data_03_73bb_MapTileAnim_Schedule_CircuitCentral
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e9_MapTileAnim_Schedule_ToonTV
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_73bb_MapTileAnim_Schedule_CircuitCentral
    dw   .data_03_734a_MapTileAnim_Schedule_ScreamTV
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_741c_MapTileAnim_Schedule_Rezopolis
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_734a_MapTileAnim_Schedule_ScreamTV
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_741c_MapTileAnim_Schedule_Rezopolis
    dw   .data_03_73bb_MapTileAnim_Schedule_CircuitCentral
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_734a_MapTileAnim_Schedule_ScreamTV
    dw   .data_03_741c_MapTileAnim_Schedule_Rezopolis
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    db   $e8
.data_03_72e8_MapTileAnim_Schedule_None:
; A length of zero. MapTileAnim_Init copies it into wD611_MapTileAnim_StepCount, which
; switches the whole system off for the level
    db   $00                                           ;; 03:72e8 .
.data_03_72e9_MapTileAnim_Schedule_ToonTV:
; Three groups of tiles visited in strict rotation, four times each. Group 1 and group
; 3 are four tiles wide, group 2 is two, so a full cycle rewrites forty tiles spread
; over twelve vblanks - five and a bit tiles per frame on average
    db   $0c
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_1, .data_03_747d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_2, .data_03_757d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_3, .data_03_75fd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_1, .data_03_74bd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_2, .data_03_759d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_3, .data_03_763d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_1, .data_03_74fd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_2, .data_03_75bd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_3, .data_03_767d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_1, .data_03_753d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_2, .data_03_75dd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_TOON_TV_GROUP_3, .data_03_76bd
.data_03_734a_MapTileAnim_Schedule_ScreamTV:
; Four groups over fourteen steps, and the only schedule that is not an even rotation.
; The order is 1 2 3 4 2 3 4 1 2 3 4 2 3 4, so groups 2, 3 and 4 take four turns each
; while group 1 takes two - it comes round every seventh step instead of every third
; or fourth, and animates at half the speed of the rest
    db   $0e
    
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_1, .data_03_787d
    
    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2, .data_03_76fd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3, .data_03_78bd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4, .data_03_78fd
    
    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2, .data_03_775d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3, .data_03_793d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4, .data_03_797d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_1, .data_03_789d
    
    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2, .data_03_77bd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3, .data_03_79bd
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4, .data_03_79fd
    
    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_2, .data_03_781d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_3, .data_03_7a3d
    
    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_SCREAM_TV_GROUP_4, .data_03_7a7d
.data_03_73bb_MapTileAnim_Schedule_CircuitCentral:
; The conveyor belts, and the only schedule with conditional steps. Three groups of two
; tiles, and each group's condition names the conveyor of the same number - group 1
; follows wD5A3_ConveyorState1 and so on - so the three belts start and stop
; independently while sharing one schedule
    db   $0c
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1, .data_03_7b7d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2, .data_03_7b7d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3, .data_03_7b7d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1, .data_03_7b9d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2, .data_03_7b9d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3, .data_03_7b9d
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1, .data_03_7bbd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2, .data_03_7bbd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3, .data_03_7bbd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_1, .data_03_7bdd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_2, .data_03_7bdd
    
    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_ANIMATED_TILE_CIRCUIT_CENTRAL_GROUP_3, .data_03_7bdd
.data_03_741c_MapTileAnim_Schedule_Rezopolis:
; Rezopolis. Three groups again - two tiles, one tile, one tile - but the four frames
; of group 1 are only two distinct pages used twice, so the twelve steps cost eight
; pages of artwork rather than twelve
    db   $0c                                              ; 12 steps, then back to the top
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1, .data_03_7abd
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2, .data_03_7afd
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3, .data_03_7b3d
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1, .data_03_7add
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2, .data_03_7b0d
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3, .data_03_7b4d
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1, .data_03_7abd
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2, .data_03_7b1d
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3, .data_03_7b5d
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_1, .data_03_7add
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_2, .data_03_7b2d
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_ANIMATED_TILE_REZOPOLIS_GROUP_3, .data_03_7b6d

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

data_03_7bfd_MapTileAnim_BlankTile:
; used as a substitute tile when a conditional animated tile slot is inactive (e.g. conveyor belt is off in Circuit Central)
    INCBIN ".gfx/animated_tiles/circuit_central/image_003_7bfd.bin"
