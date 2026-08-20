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
;                       map tile animation               secondary tileset animation
;   owned by            the level                        the loaded secondary tileset
;   set up by           MapTileAnim_Init                 BgMap_LoadSecondaryTileset
;   state               wD611, wD612                     wD72E-wD738
;   rate                one step every vblank            one frame every wD731 vblanks
;   can stop            no, runs while the level does    yes, flags bit 0 plays it once
;   priority in vblank  last                             ahead of the HUD reloads
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
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, data_03_72ab_MapTileAnim_ScheduleByLevel
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   A, [HL]
    ld   [wD611_MapTileAnim_StepCount], A
    xor  A, A
    ld   [wD612_MapTileAnim_StepIndex], A
    ret

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
    ld   A, [wD611_MapTileAnim_StepCount]
    and  A, A
    ret  Z
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, data_03_72ab_MapTileAnim_ScheduleByLevel
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   A, [DE]
    inc  DE
    ld   HL, wD612_MapTileAnim_StepIndex
    inc  [HL]
    sub  A, [HL]
    jr   NZ, .jr_03_7271
    ld   [HL], $00
.jr_03_7271:
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, DE
    ld   B, [HL]
    inc  HL
    ld   C, [HL]
    inc  HL
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    bit  7, C
    jr   Z, .jr_03_72a4
    ld   A, [wD72D_SecondaryTilesetIndex]
    cp   A, $00
    ret  NZ
    res  7, C
    ld   A, [wD5A3_ConveyorPowerTimer1]
    dec  C
    jr   Z, .jr_03_729e
    ld   A, [wD5A4_ConveyorPowerTimer2]
    dec  C
    jr   Z, .jr_03_729e
    ld   A, [wD5A5_ConveyorPowerTimer3]
.jr_03_729e:
    and  A, A
    jr   NZ, .jr_03_72a4
    ld   HL, data_03_7bfd_MapTileAnim_BlankTile
.jr_03_72a4:
    call call_03_6f2d_VRAM_Copy16Bytes
    dec  B
    jr   NZ, .jr_03_72a4
    ret

data_03_72ab_MapTileAnim_ScheduleByLevel:
; One pointer per level id, 31 of them, into five shared schedules. Levels of the same
; world point at the same schedule - the animation belongs to the world's artwork, not
; to the room - and everything with no cycling tiles, the hub included, points at the
; empty one
    dw   .data_03_72e8_MapTileAnim_Schedule_None
    dw   .data_03_72e9_MapTileAnim_Schedule_ToonTV
    dw   .data_03_734a_MapTileAnim_Schedule_ScreamTV
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
    db   $00
.data_03_72e9_MapTileAnim_Schedule_ToonTV:
; Three groups of tiles visited in strict rotation, four times each. Group 1 and group
; 3 are four tiles wide, group 2 is two, so a full cycle rewrites forty tiles spread
; over twelve vblanks - five and a bit tiles per frame on average
    db   $0c

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_1, .data_03_747d_ToonTV_Group1_Frame1

    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_2, .data_03_757d_ToonTV_Group2_Frame1

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_3, .data_03_75fd_ToonTV_Group3_Frame1

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_1, .data_03_74bd_ToonTV_Group1_Frame2

    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_2, .data_03_759d_ToonTV_Group2_Frame2

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_3, .data_03_763d_ToonTV_Group3_Frame2

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_1, .data_03_74fd_ToonTV_Group1_Frame3

    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_2, .data_03_75bd_ToonTV_Group2_Frame3

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_3, .data_03_767d_ToonTV_Group3_Frame3

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_1, .data_03_753d_ToonTV_Group1_Frame4

    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_2, .data_03_75dd_ToonTV_Group2_Frame4

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_TOON_TV_3, .data_03_76bd_ToonTV_Group3_Frame4
.data_03_734a_MapTileAnim_Schedule_ScreamTV:
; Four groups over fourteen steps, and the only schedule that is not an even rotation.
; The order is 1 2 3 4 2 3 4 1 2 3 4 2 3 4, so groups 2, 3 and 4 take four turns each
; while group 1 takes two - it comes round every seventh step instead of every third
; or fourth, and animates at half the speed of the rest
    db   $0e

    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_1, .data_03_787d_ScreamTV_Group1_Frame1

    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_2, .data_03_76fd_ScreamTV_Group2_Frame1

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_3, .data_03_78bd_ScreamTV_Group3_Frame1

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_4, .data_03_78fd_ScreamTV_Group4_Frame1

    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_2, .data_03_775d_ScreamTV_Group2_Frame2

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_3, .data_03_793d_ScreamTV_Group3_Frame2

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_4, .data_03_797d_ScreamTV_Group4_Frame2

    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_1, .data_03_789d_ScreamTV_Group1_Frame2

    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_2, .data_03_77bd_ScreamTV_Group2_Frame3

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_3, .data_03_79bd_ScreamTV_Group3_Frame3

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_4, .data_03_79fd_ScreamTV_Group4_Frame3

    map_tile_anim_step $06, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_2, .data_03_781d_ScreamTV_Group2_Frame4

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_3, .data_03_7a3d_ScreamTV_Group3_Frame4

    map_tile_anim_step $04, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_SCREAM_TV_4, .data_03_7a7d_ScreamTV_Group4_Frame4
.data_03_73bb_MapTileAnim_Schedule_CircuitCentral:
; The conveyor belts, and the only schedule with conditional steps. Three groups of two
; tiles, and each group's condition names the conveyor of the same number - group 1
; follows wD5A3_ConveyorPowerTimer1 and so on - so the three belts start and stop
; independently while sharing one schedule
    db   $0c

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_1, .data_03_7b7d_CircuitCentral_Frame1

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_2, .data_03_7b7d_CircuitCentral_Frame1

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_3, .data_03_7b7d_CircuitCentral_Frame1

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_1, .data_03_7b9d_CircuitCentral_Frame2

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_2, .data_03_7b9d_CircuitCentral_Frame2

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_3, .data_03_7b9d_CircuitCentral_Frame2

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_1, .data_03_7bbd_CircuitCentral_Frame3

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_2, .data_03_7bbd_CircuitCentral_Frame3

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_3, .data_03_7bbd_CircuitCentral_Frame3

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 1,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_1, .data_03_7bdd_CircuitCentral_Frame4

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 2,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_2, .data_03_7bdd_CircuitCentral_Frame4

    map_tile_anim_step $02, MAP_TILE_ANIM_IF_CONVEYOR | 3,   VRAM_MAP_TILE_ANIM_CIRCUIT_CENTRAL_3, .data_03_7bdd_CircuitCentral_Frame4
.data_03_741c_MapTileAnim_Schedule_Rezopolis:
; Rezopolis. Three groups again - two tiles, one tile, one tile - but the four frames
; of group 1 are only two distinct pages used twice, so the twelve steps cost eight
; pages of artwork rather than twelve
    db   $0c                                              ; 12 steps, then back to the top
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_1, .data_03_7abd_Rezopolis_Group1_Frame1
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_2, .data_03_7afd_Rezopolis_Group2_Frame1
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_3, .data_03_7b3d_Rezopolis_Group3_Frame1
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_1, .data_03_7add_Rezopolis_Group1_Frame2
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_2, .data_03_7b0d_Rezopolis_Group2_Frame2
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_3, .data_03_7b4d_Rezopolis_Group3_Frame2
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_1, .data_03_7abd_Rezopolis_Group1_Frame1
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_2, .data_03_7b1d_Rezopolis_Group2_Frame3
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_3, .data_03_7b5d_Rezopolis_Group3_Frame3
    map_tile_anim_step $02, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_1, .data_03_7add_Rezopolis_Group1_Frame2
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_2, .data_03_7b2d_Rezopolis_Group2_Frame4
    map_tile_anim_step $01, MAP_TILE_ANIM_ALWAYS,            VRAM_MAP_TILE_ANIM_REZOPOLIS_3, .data_03_7b6d_Rezopolis_Group3_Frame4

.data_03_747d_ToonTV_Group1_Frame1:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_747d.bin"
.data_03_74bd_ToonTV_Group1_Frame2:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_74bd.bin"
.data_03_74fd_ToonTV_Group1_Frame3:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_74fd.bin"
.data_03_753d_ToonTV_Group1_Frame4:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_753d.bin"
.data_03_757d_ToonTV_Group2_Frame1:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_757d.bin"
.data_03_759d_ToonTV_Group2_Frame2:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_759d.bin"
.data_03_75bd_ToonTV_Group2_Frame3:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_75bd.bin"
.data_03_75dd_ToonTV_Group2_Frame4:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_75dd.bin"
.data_03_75fd_ToonTV_Group3_Frame1:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_75fd.bin"
.data_03_763d_ToonTV_Group3_Frame2:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_763d.bin"
.data_03_767d_ToonTV_Group3_Frame3:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_767d.bin"
.data_03_76bd_ToonTV_Group3_Frame4:
    INCBIN ".gfx/map_tile_anim/toon_tv/image_003_76bd.bin"
.data_03_76fd_ScreamTV_Group2_Frame1:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_76fd.bin"
.data_03_775d_ScreamTV_Group2_Frame2:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_775d.bin"
.data_03_77bd_ScreamTV_Group2_Frame3:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_77bd.bin"
.data_03_781d_ScreamTV_Group2_Frame4:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_781d.bin"
.data_03_787d_ScreamTV_Group1_Frame1:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_787d.bin"
.data_03_789d_ScreamTV_Group1_Frame2:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_789d.bin"
.data_03_78bd_ScreamTV_Group3_Frame1:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_78bd.bin"
.data_03_78fd_ScreamTV_Group4_Frame1:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_78fd.bin"
.data_03_793d_ScreamTV_Group3_Frame2:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_793d.bin"
.data_03_797d_ScreamTV_Group4_Frame2:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_797d.bin"
.data_03_79bd_ScreamTV_Group3_Frame3:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_79bd.bin"
.data_03_79fd_ScreamTV_Group4_Frame3:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_79fd.bin"
.data_03_7a3d_ScreamTV_Group3_Frame4:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_7a3d.bin"
.data_03_7a7d_ScreamTV_Group4_Frame4:
    INCBIN ".gfx/map_tile_anim/scream_tv/image_003_7a7d.bin"
.data_03_7abd_Rezopolis_Group1_Frame1:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7abd.bin"
.data_03_7add_Rezopolis_Group1_Frame2:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7add.bin"
.data_03_7afd_Rezopolis_Group2_Frame1:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7afd.bin"
.data_03_7b0d_Rezopolis_Group2_Frame2:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b0d.bin"
.data_03_7b1d_Rezopolis_Group2_Frame3:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b1d.bin"
.data_03_7b2d_Rezopolis_Group2_Frame4:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b2d.bin"
.data_03_7b3d_Rezopolis_Group3_Frame1:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b3d.bin"
.data_03_7b4d_Rezopolis_Group3_Frame2:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b4d.bin"
.data_03_7b5d_Rezopolis_Group3_Frame3:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b5d.bin"
.data_03_7b6d_Rezopolis_Group3_Frame4:
    INCBIN ".gfx/map_tile_anim/rezopolis/image_003_7b6d.bin"
.data_03_7b7d_CircuitCentral_Frame1:
    INCBIN ".gfx/map_tile_anim/circuit_central/image_003_7b7d.bin"
.data_03_7b9d_CircuitCentral_Frame2:
    INCBIN ".gfx/map_tile_anim/circuit_central/image_003_7b9d.bin"
.data_03_7bbd_CircuitCentral_Frame3:
    INCBIN ".gfx/map_tile_anim/circuit_central/image_003_7bbd.bin"
.data_03_7bdd_CircuitCentral_Frame4:
    INCBIN ".gfx/map_tile_anim/circuit_central/image_003_7bdd.bin"

data_03_7bfd_MapTileAnim_BlankTile:
; used as a substitute tile when a conditional animated tile slot is inactive (e.g. conveyor belt is off in Circuit Central)
    INCBIN ".gfx/map_tile_anim/circuit_central/image_003_7bfd.bin"
