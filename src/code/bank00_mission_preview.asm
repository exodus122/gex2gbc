; ==================================================================
; CUTSCENES
;
; Every in-level scripted camera move lives here. Most are mission previews - the fly-over
; shown when you pick a mission, panning from Gex to the objective - but they are not the
; only kind. Completing an objective also plays a short scene showing you where the exit tv
; is, and those use the same machinery with a different slot.
;
; That split is visible in the data. A mission preview has a movement list and no animation;
; a "here is the tv" scene is usually the opposite - a fixed camera position with an
; animation block, or nothing at all beyond repositioning and holding for
; CUTSCENE_HOLD_FRAMES. It is also why some scenes end by poking a tile-override slot
; through the embedded code stubs: the scene has permanently revealed something.
;
; The trick behind it is that there is no camera. Gex himself is teleported to the start of
; the shot and then *walked* along a scripted path, with the normal map window logic following
; him as usual. The script does this by writing fake d-pad values straight into
; wD75A_CurrentInputsAlt, so from the map and entity code's point of view nothing unusual is
; happening. wD743_Player_UpdateFlag is cleared for the duration, which is what stops the real
; player update from fighting the script for control - and also why Gex is invisible during
; the preview.
;
; Because the world has to be left exactly as it was, the whole thing is bracketed by
; Entity_SaveWorldState / Entity_RestoreWorldState, with Gex's original position stashed on
; the stack across all three phases.
; ==================================================================

call_00_2329_Cutscene_LoadAndRun:
; B = skippable (nonzero means any button aborts), C = which cutscene slot to play.
;
; The only call site is in call_00_0150_Init and passes C = CUTSCENE_SLOT_MISSION_BASE +
; wD627_CurrentMission, which is why the lookup table below has a column of three at slots
; $0A-$0C. The other slots are reached by the same expression with wD627 holding something
; other than a mission number - so a scene is selected purely by what that variable contains
; when the level is (re)initialised, and there is no separate "play cutscene" entry point.
;
; Two levels of lookup: (level, slot) gives a script index via
; .data_00_2472_CutsceneIndexLookupTable, and CUTSCENE_NONE there means this level has
; nothing for that slot and the routine simply returns - which is the common case.
;
; A script is:
;   +0  dw  Gex's start X            +4  dw  movement command list, or 0
;   +2  dw  Gex's start Y            +6  dw  animation script, or 0
;
; and runs in three phases, each of which can be cut short by a button press when skippable:
;
;   1. movement - walk the command list. Each command is 3 bytes (direction bits, then a
;      16-bit frame count) and the list ends with CUTSCENE_MOVE_END. The direction byte goes
;      into wD75A and MissionPreview_UpdateMovement does the actual moving
;   2. animation - hand off to the special-tile script runner and idle until it reports done
;   3. hold - CUTSCENE_HOLD_FRAMES of dwell so the objective stays on screen
;
; Each phase runs its own cut-down game loop rather than the real one: vblank wait, the phase's
; own update, entity update, and the VRAM transfer setup. Skipping jumps straight to the
; restore code, and only a non-skipped preview bothers to rebuild the map on the way out
    ld   A, B                                          ;; 00:2329 $78
    ld   [wD775_Cutscene_Skippable], A                                    ;; 00:232a $ea $75 $d7
    ld   B, $00                                        ;; 00:232d $06 $00
    ld   HL, wD624_CurrentLevelId                                     ;; 00:232f $21 $24 $d6
    ld   L, [HL]                                       ;; 00:2332 $6e
    ld   H, $00                                        ;; 00:2333 $26 $00
    add  HL, HL                                        ;; 00:2335 $29
    add  HL, HL                                        ;; 00:2336 $29
    add  HL, HL                                        ;; 00:2337 $29
    add  HL, HL                                        ;; 00:2338 $29
    ld   DE, .data_00_2472_CutsceneIndexLookupTable                                     ;; 00:2339 $11 $72 $24
    add  HL, DE                                        ;; 00:233c $19
    add  HL, BC                                        ;; 00:233d $09
    ld   A, [HL]                                       ;; 00:233e $7e
    cp   A, CUTSCENE_NONE                              ;; 00:233f $fe $ff
    ret  Z                                             ;; 00:2341 $c8
    ld   L, A                                          ;; 00:2342 $6f
    ld   H, $00                                        ;; 00:2343 $26 $00
    add  HL, HL                                        ;; 00:2345 $29
    ld   DE, .data_00_2662_CutsceneScriptPointerTable                                     ;; 00:2346 $11 $62 $26
    add  HL, DE                                        ;; 00:2349 $19
    ld   E, [HL]                                       ;; 00:234a $5e
    inc  HL                                            ;; 00:234b $23
    ld   D, [HL]                                       ;; 00:234c $56
    push DE                                            ;; 00:234d $d5
    call call_00_3628_Entity_SaveWorldState                                  ;; 00:234e $cd $28 $36
    pop  DE                                            ;; 00:2351 $d1
    ld   HL, wD20E_Player_XPositionLo                                     ;; 00:2352 $21 $0e $d2
    ld   C, [HL]                                       ;; 00:2355 $4e
    ld   A, [DE]                                       ;; 00:2356 $1a
    ld   [HL+], A                                      ;; 00:2357 $22
    inc  DE                                            ;; 00:2358 $13
    ld   B, [HL]                                       ;; 00:2359 $46
    ld   A, [DE]                                       ;; 00:235a $1a
    ld   [HL+], A                                      ;; 00:235b $22
    inc  DE                                            ;; 00:235c $13
    push BC                                            ;; 00:235d $c5
    ld   C, [HL]                                       ;; 00:235e $4e
    ld   A, [DE]                                       ;; 00:235f $1a
    ld   [HL+], A                                      ;; 00:2360 $22
    inc  DE                                            ;; 00:2361 $13
    ld   B, [HL]                                       ;; 00:2362 $46
    ld   A, [DE]                                       ;; 00:2363 $1a
    ld   [HL], A                                       ;; 00:2364 $77
    inc  DE                                            ;; 00:2365 $13
    push BC                                            ;; 00:2366 $c5
    push DE                                            ;; 00:2367 $d5
    call call_00_13a6_BgMap_UpdateWindowFromPlayerPos                                  ;; 00:2368 $cd $a6 $13
    xor  A, A                                          ;; 00:236b $af
    ld   [wD743_Player_UpdateFlag], A                                    ;; 00:236c $ea $43 $d7
    call call_00_1264_BgMap_LoadFull                                  ;; 00:236f $cd $64 $12
    FARCALL call_02_6e68_Entities_InitNPCSlots
    call call_00_0521_DrawEntitiesWrapper                                  ;; 00:237d $cd $21 $05
    pop  HL                                            ;; 00:2380 $e1
    ld   E, [HL]                                       ;; 00:2381 $5e
    inc  HL                                            ;; 00:2382 $23
    ld   D, [HL]                                       ;; 00:2383 $56
    inc  HL                                            ;; 00:2384 $23
    ld   A, E                                          ;; 00:2385 $7b
    or   A, D                                          ;; 00:2386 $b2
    jr   Z, .jr_00_23e9                                ;; 00:2387 $28 $60
    push HL                                            ;; 00:2389 $e5
    ld   L, E                                          ;; 00:238a $6b
    ld   H, D                                          ;; 00:238b $62
    xor  A, A                                          ;; 00:238c $af
    ld   [wD79D_Cutscene_MoveSpeed], A                                    ;; 00:238d $ea $9d $d7
    ld   [wD79E_Cutscene_MoveSubPixel], A                                    ;; 00:2390 $ea $9e $d7
    ld   A, [HL+]                                      ;; 00:2393 $2a
.jr_00_2394:
    ld   [wD75A_CurrentInputsAlt], A                                    ;; 00:2394 $ea $5a $d7
    ld   A, [HL+]                                      ;; 00:2397 $2a
    ld   [wD79B_Cutscene_MoveFramesRemaining], A                                    ;; 00:2398 $ea $9b $d7
    ld   A, [HL+]                                      ;; 00:239b $2a
    ld   [wD79B_Cutscene_MoveFramesRemaining+1], A                                    ;; 00:239c $ea $9c $d7
    push HL                                            ;; 00:239f $e5
.jr_00_23a0:
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:23a0 $fa $75 $d7
    and  A, A                                          ;; 00:23a3 $a7
    jr   Z, .jr_00_23b1                                ;; 00:23a4 $28 $0b
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:23a6 $fa $9f $d5
    and  A, A                                          ;; 00:23a9 $a7
    jr   Z, .jr_00_23b1                                ;; 00:23aa $28 $05
    pop  HL                                            ;; 00:23ac $e1
    pop  HL                                            ;; 00:23ad $e1
    jp   .jp_00_2445                                   ;; 00:23ae $c3 $45 $24
.jr_00_23b1:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:23b1 $cd $b4 $0a
    call call_00_2dbf_Cutscene_UpdateMovement                                  ;; 00:23b4 $cd $bf $2d
    FARCALL call_02_715a_MapWindow_Update
    FARCALL call_02_6eba_Entities_UpdateAll
    call call_00_1455_BgMap_LoadDirtyRegions                                  ;; 00:23cd $cd $55 $14
    call call_00_08fc_SetupEntityVRAMTransfer                                  ;; 00:23d0 $cd $fc $08
    ld   HL, wD79B_Cutscene_MoveFramesRemaining                                     ;; 00:23d3 $21 $9b $d7
    ld   A, [HL]                                       ;; 00:23d6 $7e
    sub  A, $01                                        ;; 00:23d7 $d6 $01
    ld   [HL+], A                                      ;; 00:23d9 $22
    ld   C, A                                          ;; 00:23da $4f
    ld   A, [HL]                                       ;; 00:23db $7e
    sbc  A, $00                                        ;; 00:23dc $de $00
    ld   [HL], A                                       ;; 00:23de $77
    or   A, C                                          ;; 00:23df $b1
    jr   NZ, .jr_00_23a0                               ;; 00:23e0 $20 $be
    pop  HL                                            ;; 00:23e2 $e1
    ld   A, [HL+]                                      ;; 00:23e3 $2a
    cp   A, CUTSCENE_MOVE_END                          ;; 00:23e4 $fe $ff
    jr   NZ, .jr_00_2394                               ;; 00:23e6 $20 $ac
    pop  HL                                            ;; 00:23e8 $e1
.jr_00_23e9:
    ld   A, [HL+]                                      ;; 00:23e9 $2a
    ld   H, [HL]                                       ;; 00:23ea $66
    ld   L, A                                          ;; 00:23eb $6f
    or   A, H                                          ;; 00:23ec $b4
    jr   Z, .jr_00_241e                                ;; 00:23ed $28 $2f
    call call_00_1f80_SpecialTile_RunScript                                  ;; 00:23ef $cd $80 $1f
.jr_00_23f2:
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:23f2 $fa $75 $d7
    and  A, A                                          ;; 00:23f5 $a7
    jr   Z, .jr_00_23fe                                ;; 00:23f6 $28 $06
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:23f8 $fa $9f $d5
    and  A, A                                          ;; 00:23fb $a7
    jr   NZ, .jp_00_2445                               ;; 00:23fc $20 $47
.jr_00_23fe:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:23fe $cd $b4 $0a
    call call_00_1e5b_BgMap_TickOverrideSequence                                  ;; 00:2401 $cd $5b $1e
    FARCALL call_02_6eba_Entities_UpdateAll
    call call_00_08fc_SetupEntityVRAMTransfer                                  ;; 00:240f $cd $fc $08
    ld   A, [wD77D_OverrideSequenceStepsRemaining]                                    ;; 00:2412 $fa $7d $d7
    and  A, A                                          ;; 00:2415 $a7
    jr   NZ, .jr_00_23f2                               ;; 00:2416 $20 $da
    ld   A, [wD77B_OverrideVRAMWritePending]                                    ;; 00:2418 $fa $7b $d7
    and  A, A                                          ;; 00:241b $a7
    jr   NZ, .jr_00_23f2                               ;; 00:241c $20 $d4
.jr_00_241e:
    ld   A, CUTSCENE_HOLD_FRAMES                       ;; 00:241e $3e $b4
.jr_00_2420:
    push AF                                            ;; 00:2420 $f5
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:2421 $cd $b4 $0a
    FARCALL call_02_6eba_Entities_UpdateAll
    call call_00_08fc_SetupEntityVRAMTransfer                                  ;; 00:242f $cd $fc $08
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:2432 $fa $75 $d7
    and  A, A                                          ;; 00:2435 $a7
    jr   Z, .jr_00_2441                                ;; 00:2436 $28 $09
    ld   A, [wD59F_CurrentInputs]                                    ;; 00:2438 $fa $9f $d5
    and  A, A                                          ;; 00:243b $a7
    jr   Z, .jr_00_2441                                ;; 00:243c $28 $03
    pop  AF                                            ;; 00:243e $f1
    jr   .jp_00_2445                                   ;; 00:243f $18 $04
.jr_00_2441:
    pop  AF                                            ;; 00:2441 $f1
    dec  A                                             ;; 00:2442 $3d
    jr   NZ, .jr_00_2420                               ;; 00:2443 $20 $db
.jp_00_2445:
    ld   A, $01                                        ;; 00:2445 $3e $01
    ld   [wD743_Player_UpdateFlag], A                                    ;; 00:2447 $ea $43 $d7
    call call_00_3675_Entity_RestoreWorldState                                  ;; 00:244a $cd $75 $36
    ld   HL, wD211_Player_YPositionHi                                     ;; 00:244d $21 $11 $d2
    pop  BC                                            ;; 00:2450 $c1
    ld   [HL], B                                       ;; 00:2451 $70
    dec  HL                                            ;; 00:2452 $2b
    ld   [HL], C                                       ;; 00:2453 $71
    dec  HL                                            ;; 00:2454 $2b
    pop  BC                                            ;; 00:2455 $c1
    ld   [HL], B                                       ;; 00:2456 $70
    dec  HL                                            ;; 00:2457 $2b
    ld   [HL], C                                       ;; 00:2458 $71
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:2459 $fa $75 $d7
    and  A, A                                          ;; 00:245c $a7
    ret  NZ                                            ;; 00:245d $c0
    call call_00_13a6_BgMap_UpdateWindowFromPlayerPos                                  ;; 00:245e $cd $a6 $13
    call call_00_1264_BgMap_LoadFull                                  ;; 00:2461 $cd $64 $12
    FARCALL call_02_71c8_Entities_QueueGraphicsAndPalettes
    jp   call_00_0521_DrawEntitiesWrapper                                  ;; 00:246f $c3 $21 $05
.data_00_2472_CutsceneIndexLookupTable:
; 31 rows of CUTSCENE_SLOTS_PER_LEVEL bytes, indexed by (level id, slot). The value is an
; index into .data_00_2662_CutsceneScriptPointerTable, or CUTSCENE_NONE for nothing.
;
; The shape tells you what the slots mean. Slots $0A-$0C are the three mission previews,
; which is why almost every playable level has a run of two or three entries there.
; Everything else is the other kind of scene - the short "the exit tv is over there" clip
; played once an objective is met - which matches those entries pointing at scripts with no
; movement list.
;
; Mao Tse Tongue and Samurai Night Fever fill slots $00-$09 as well, nineteen scripts between
; them. Both are Kung Fu Theater levels.
;
; The all-$FF rows are levels with no scenes at all: the unused ids, the hub variants
; ($11-$14), and everything from Lizard in a China Shop onward except four
;         slot: 0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    db   $00, $01, $02, $03, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 00 media dimension
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $04, $05, $06, $ff, $07, $08 ; 01 out of toon
    db   $0d, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $09, $0a, $0b, $ff, $0c, $ff ; 02 smellraiser
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $0e, $0f, $10, $ff, $ff, $ff ; 03 frankensteinfeld
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $11, $12, $ff, $ff, $ff, $ff ; 04 www.dotcom.com
    db   $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $13, $14, $ff, $ff, $ff, $ff ; 05 mao tse tongue
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 06 unused
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $1f, $20, $ff, $ff, $ff, $ff ; 07 pangaea 90210
    db   $ff, $ff, $ff, $ff, $ff, $ff, $23, $ff, $ff, $24, $21, $22, $ff, $ff, $25, $ff ; 08 fine tooning
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $26, $27, $28, $ff, $ff, $ff ; 09 this old cave
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $29, $2a, $2b, $ff, $ff, $ff ; 0a honey i shrunk the gecko
    db   $30, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $2c, $2d, $2e, $ff, $ff, $2f ; 0b poltergex
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0c unused
    db   $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $ff, $31, $32, $33, $ff, $ff, $ff ; 0d samurai night fever
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $3d, $ff, $ff, $ff, $ff, $ff ; 0e no weddings and a funeral
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0f unused
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 10 thursday the 12th
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 11
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 12
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 13
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 14
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 15 lizard in a china shop
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 16 bugged out
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 17 chips and dips
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $3e, $ff, $ff, $ff, $ff, $ff ; 18 lava dabba doo
    db   $40, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $3f, $ff, $ff, $ff, $ff, $ff ; 19 texas chainsaw manicure
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $41, $42, $ff, $ff, $ff, $ff ; 1a mazed and confused
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 1b
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 1c
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 1d
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 1e channel z
.data_00_2662_CutsceneScriptPointerTable:
; Pointer table for cutscene scripts, followed by inline script data blocks. Each script block 
; contains optional movement phase data (direction bytes, duration words) and an optional 
; animation/dialogue phase pointer. The inline binary data at data_00_26e8–data_00_2dbc represents 
; all level preview cutscene scripts
; 67 entries. The three that already have labels use them; the rest are still raw addresses
; into the script blob below, pending that blob being split up.
; The trailing comment on each line is who refers to it, read back out of
; .data_00_2472_CutsceneIndexLookupTable - "mission 1/2/3" are slots $0A-$0C
    dw   .script_00    ; $00  media dimension, slot 0
    dw   .script_01    ; $01  media dimension, slot 1
    dw   .script_02    ; $02  media dimension, slot 2
    dw   .script_03    ; $03  media dimension, slot 3
    dw   .script_04    ; $04  out of toon, mission 1
    dw   .script_05    ; $05  out of toon, mission 2
    dw   .script_06    ; $06  out of toon, mission 3
    dw   .script_07    ; $07  out of toon, slot $0E
    dw   .script_08    ; $08  out of toon, slot $0F
    dw   .script_09    ; $09  smellraiser, mission 1
    dw   .script_0A    ; $0a  smellraiser, mission 2
    dw   .script_0B    ; $0b  smellraiser, mission 3
    dw   .script_0C    ; $0c  smellraiser, slot $0E
    dw   .script_0D    ; $0d  smellraiser, slot 0
    dw   .script_0E    ; $0e  frankensteinfeld, mission 1
    dw   .script_0F    ; $0f  frankensteinfeld, mission 2
    dw   .script_10    ; $10  frankensteinfeld, mission 3
    dw   .script_11    ; $11  www.dotcom.com, mission 1
    dw   .script_12    ; $12  www.dotcom.com, mission 2
    dw   .script_13    ; $13  mao tse tongue, mission 1
    dw   .script_14    ; $14  mao tse tongue, mission 2
    dw   .script_15    ; $15  mao tse tongue, slot 0
    dw   .script_16    ; $16  mao tse tongue, slot 1
    dw   .script_17    ; $17  mao tse tongue, slot 2
    dw   .script_18    ; $18  mao tse tongue, slot 3
    dw   .script_19    ; $19  mao tse tongue, slot 4
    dw   .script_1A    ; $1a  mao tse tongue, slot 5
    dw   .script_1B    ; $1b  mao tse tongue, slot 6
    dw   .script_1C    ; $1c  mao tse tongue, slot 7
    dw   .script_1D    ; $1d  mao tse tongue, slot 8
    dw   .script_1E    ; $1e  mao tse tongue, slot 9
    dw   .script_1F    ; $1f  pangaea 90210, mission 1
    dw   .script_20    ; $20  pangaea 90210, mission 2
    dw   .script_21    ; $21  fine tooning, mission 1
    dw   .script_22    ; $22  fine tooning, mission 2
    dw   .script_23    ; $23  fine tooning, slot 6
    dw   .script_24    ; $24  fine tooning, slot 9
    dw   .script_25    ; $25  fine tooning, slot $0E
    dw   .script_26    ; $26  this old cave, mission 1
    dw   .script_27    ; $27  this old cave, mission 2
    dw   .script_28    ; $28  this old cave, mission 3
    dw   .script_29    ; $29  honey i shrunk the gecko, mission 1
    dw   .script_2A    ; $2a  honey i shrunk the gecko, mission 2
    dw   .script_2B    ; $2b  honey i shrunk the gecko, mission 3
    dw   .script_2C    ; $2c  poltergex, mission 1
    dw   .script_2D    ; $2d  poltergex, mission 2
    dw   .script_2E    ; $2e  poltergex, mission 3
    dw   .script_2F    ; $2f  poltergex, slot $0F
    dw   .script_30    ; $30  poltergex, slot 0
    dw   .script_31    ; $31  samurai night fever, mission 1
    dw   .script_32    ; $32  samurai night fever, mission 2
    dw   .script_33    ; $33  samurai night fever, mission 3
    dw   .script_34    ; $34  samurai night fever, slot 0
    dw   .script_35    ; $35  samurai night fever, slot 1
    dw   .script_36    ; $36  samurai night fever, slot 2
    dw   .script_37    ; $37  samurai night fever, slot 3
    dw   .script_38    ; $38  samurai night fever, slot 4
    dw   .script_39    ; $39  samurai night fever, slot 5
    dw   .script_3A    ; $3a  samurai night fever, slot 6
    dw   .script_3B    ; $3b  samurai night fever, slot 7
    dw   .script_3C    ; $3c  samurai night fever, slot 8
    dw   .script_3D    ; $3d  no weddings and a funeral, mission 1
    dw   .script_3E    ; $3e  lava dabba doo, mission 1
    dw   .script_3F    ; $3f  texas chainsaw manicure, mission 1
    dw   .script_40    ; $40  texas chainsaw manicure, slot 0
    dw   .script_41    ; $41  mazed and confused, mission 1
    dw   .script_42    ; $42  mazed and confused, mission 2
.script_00:
;   startX $04E0  startY $01D0  no movement  anim $26F0
    db   $e0, $04, $d0, $01, $00, $00                  ;; 00:26e8
    db   $f0, $26, $00, $00, $03, $0a, $fe, $ff        ;; 00:26ee ????????
    db   $02, $02, $08, $ee, $01, $ef, $01, $fe        ;; 00:26f6 ????????
    db   $01, $ff, $01, $08, $7e, $01, $7f, $01        ;; 00:26fe ????????
    db   $8e, $01, $8f, $01, $0a, $7c, $01, $7d        ;; 00:2706 ????????
    db   $01, $8c, $01, $8d, $01                       ;; 00:270e
.script_01:
;   startX $03A0  startY $02F0  no movement  anim $271B
    db   $a0, $03, $f0                                 ;; 00:2713
    db   $02, $00, $00, $1b, $27, $00, $00, $03        ;; 00:2716 ????????
    db   $0a, $fe, $ff, $02, $02, $08, $ea, $01        ;; 00:271e ????????
    db   $eb, $01, $fa, $01, $fb, $01, $08, $7a        ;; 00:2726 ????????
    db   $01, $7b, $01, $8a, $01, $8b, $01, $0a        ;; 00:272e ????????
    db   $78, $01, $79, $01, $88, $01, $89, $01        ;; 00:2736 ????????
.script_02:
;   startX $0620  startY $02F0  no movement  anim $2746
    db   $20, $06, $f0, $02, $00, $00, $46, $27        ;; 00:273e
    db   $00, $00, $03, $0a, $fe, $ff, $02, $02        ;; 00:2746 ????????
    db   $08, $e6, $01, $e7, $01, $f6, $01, $f7        ;; 00:274e ????????
    db   $01, $08, $5e, $01, $5f, $01, $6e, $01        ;; 00:2756 ????????
    db   $6f, $01, $0a, $5c, $01, $5d, $01, $6c        ;; 00:275e ????????
    db   $01, $6d, $01                                 ;; 00:2766
.script_03:
;   startX $08A0  startY $02F0  no movement  anim $2771
    db   $a0, $08, $f0, $02, $00                       ;; 00:2769
    db   $00, $71, $27, $00, $00, $03, $0a, $fe        ;; 00:276e ????????
    db   $ff, $02, $02, $08, $be, $01, $bf, $01        ;; 00:2776 ????????
    db   $ce, $01, $cf, $01, $08, $5a, $01, $5b        ;; 00:277e ????????
    db   $01, $6a, $01, $6b, $01, $0a, $58, $01        ;; 00:2786 ????????
    db   $59, $01, $68, $01, $69, $01                  ;; 00:278e ??????
.script_04:
;   startX $0DD0  startY $06F0  movement $279C  no anim
    db   $d0, $0d, $f0, $06, $9c, $27, $00, $00        ;; 00:2794
;   move: dir $00 for $0080, dir UP for $0100, dir RIGHT for $0190, end
    db   $00, $80, $00, $40, $00, $01, $10, $90        ;; 00:279c
    db   $01, $ff                                      ;; 00:27a4
.script_05:
;   startX $0320  startY $0510  movement $27AE  no anim
    db   $20, $03, $10, $05, $ae, $27                  ;; 00:27a6
    db   $00, $00                                      ;; 00:27ac
;   move: dir $00 for $0080, dir RIGHT for $0180, end
    db   $00, $80, $00, $10, $80, $01                  ;; 00:27ae
    db   $ff                                           ;; 00:27b4
.script_06:
;   startX $0A20  startY $00D0  movement $27BD  no anim
    db   $20, $0a, $d0, $00, $bd, $27, $00             ;; 00:27b5
    db   $00                                           ;; 00:27bc
;   move: dir $00 for $0080, dir RIGHT for $0160, end
    db   $00, $80, $00, $10, $60, $01, $ff             ;; 00:27bd
.script_07:
;   startX $04A0  startY $0500  no movement, no anim - reposition and hold
    db   $a0, $04, $00, $05, $00, $00, $00, $00        ;; 00:27c4
.script_08:
;   startX $0C20  startY $0180  no movement, no anim - reposition and hold
    db   $20, $0c, $80, $01, $00, $00, $00, $00        ;; 00:27cc
.script_09:
;   startX $0520  startY $0430  movement $27DC  no anim
    db   $20, $05, $30, $04, $dc, $27, $00, $00        ;; 00:27d4
;   move: pause $0080, UP $0080, end
    db   $00, $80, $00, $40, $80, $00, $ff             ;; 00:27dc
.script_0A:
;   startX $0070  startY $0150  movement $27EB  no anim
    db   $70                                           ;; 00:27e3
    db   $00, $50, $01, $eb, $27, $00, $00             ;; 00:27e4
;   move: pause $0080, RIGHT $00A0, UP+RIGHT $0040, RIGHT $00E0, UP $0060, LEFT $00C0, end
    db   $00                                           ;; 00:27eb
    db   $80, $00, $10, $a0, $00, $50, $40, $00        ;; 00:27ec
    db   $10, $e0, $00, $40, $60, $00, $20, $c0        ;; 00:27f4
    db   $00, $ff                                      ;; 00:27fc
.script_0B:
;   startX $00B0  startY $0450  movement $2806  no anim
    db   $b0, $00, $50, $04, $06, $28                  ;; 00:27fe
;   move: pause $0080, RIGHT $0270, end
    db   $00, $00, $00, $80, $00, $10, $70, $02        ;; 00:2804
    db   $ff                                           ;; 00:280c
.script_0C:
;   startX $0EC0  startY $0140  no movement, no anim - reposition and hold
    db   $c0, $0e, $40, $01, $00, $00, $00             ;; 00:280d
    db   $00                                           ;; 00:2814
.script_0D:
;   startX $00BC  startY $0340  no movement  anim $281D
    db   $bc, $00, $40, $03, $00, $00, $1d             ;; 00:2815
    db   $28, $00, $00, $02, $3c, $00, $00, $02        ;; 00:281c ????????
    db   $01, $28, $26, $f4, $01, $f5, $01, $0a        ;; 00:2824 ????????
    db   $f2, $01, $f3, $01                            ;; 00:282c
.script_0E:
;   startX $0390  startY $0AF0  movement $2838  no anim
    db   $90, $03, $f0, $0a                            ;; 00:2830
    db   $38, $28, $00, $00                            ;; 00:2834
;   move: pause $0080, LEFT $0270, end
    db   $00, $80, $00, $20                            ;; 00:2838
    db   $70, $02, $ff                                 ;; 00:283c
.script_0F:
;   startX $0AD0  startY $05B0  movement $2847  no anim
    db   $d0, $0a, $b0, $05, $47                       ;; 00:283f
    db   $28, $00, $00                                 ;; 00:2844
;   move: pause $0080, DOWN+RIGHT $0090, end
    db   $00, $80, $00, $90, $90                       ;; 00:2847
    db   $00, $ff                                      ;; 00:284c
.script_10:
;   startX $0AB0  startY $0A50  movement $2856  no anim
    db   $b0, $0a, $50, $0a, $56, $28                  ;; 00:284e
    db   $00, $00                                      ;; 00:2854
;   move: pause $0080, UP $0080, RIGHT $00A0, UP $0040, end
    db   $00, $80, $00, $40, $80, $00                  ;; 00:2856
    db   $10, $a0, $00, $40, $40, $00, $ff             ;; 00:285c
.script_11:
;   startX $02C0  startY $0850  movement $286B  no anim
    db   $c0                                           ;; 00:2863
    db   $02, $50, $08, $6b, $28, $00, $00             ;; 00:2864
;   move: pause $0080, UP $0460, end
    db   $00                                           ;; 00:286b
    db   $80, $00, $40, $60, $04, $ff                  ;; 00:286c
.script_12:
;   startX $0C70  startY $0770  movement $287A  no anim
    db   $70, $0c                                      ;; 00:2872
    db   $70, $07, $7a, $28, $00, $00                  ;; 00:2874
;   move: pause $0080, RIGHT $02D0, end
    db   $00, $80                                      ;; 00:287a
    db   $00, $10, $d0, $02, $ff                       ;; 00:287c
.script_13:
;   startX $0230  startY $04F0  movement $2889  no anim
    db   $30, $02, $f0                                 ;; 00:2881
    db   $04, $89, $28, $00, $00, $00, $2c, $01        ;; 00:2884 ????????
    db   $ff                                           ;; 00:288c
.script_14:
;   startX $0B30  startY $08B0  movement $2895  no anim
    db   $30, $0b, $b0, $08, $95, $28, $00             ;; 00:288d
;   move: pause $0080, UP $00A0, RIGHT $0190, UP+RIGHT $0040, end
    db   $00, $00, $80, $00, $40, $a0, $00, $10        ;; 00:2894
    db   $90, $01, $50, $40, $00, $ff                  ;; 00:289c
.script_15:
;   startX $03C0  startY $06A0  no movement, no anim - reposition and hold
    db   $c0, $03                                      ;; 00:28a2
    db   $a0, $06, $00, $00, $00, $00                  ;; 00:28a4
.script_16:
;   startX $0860  startY $07B0  no movement, no anim - reposition and hold
    db   $60, $08                                      ;; 00:28aa
    db   $b0, $07, $00, $00, $00, $00                  ;; 00:28ac
.script_17:
;   startX $09C0  startY $00B0  no movement  anim $28BA
    db   $c0, $09                                      ;; 00:28b2
    db   $b0, $00, $00, $00, $ba, $28, $00, $00        ;; 00:28b4 ????????
    db   $02, $3c, $ff, $ff, $02, $02, $08, $f4        ;; 00:28bc ????????
    db   $01, $f5, $01, $f6, $01, $f7, $01, $0a        ;; 00:28c4 ????????
    db   $e0, $01, $e1, $01, $e2, $01, $e3, $01        ;; 00:28cc ????????
.script_18:
;   startX $0980  startY $0690  no movement  anim $28DC
    db   $80, $09, $90, $06, $00, $00, $dc, $28        ;; 00:28d4
    db   $00, $00, $02, $3c, $ff, $ff, $02, $02        ;; 00:28dc ????????
    db   $08, $f4, $01, $f5, $01, $f6, $01, $f7        ;; 00:28e4 ????????
    db   $01, $0a, $e0, $01, $e1, $01, $e2, $01        ;; 00:28ec ????????
    db   $e3, $01                                      ;; 00:28f4
.script_19:
;   startX $0100  startY $0550  no movement  anim $28FE
    db   $00, $01, $50, $05, $00, $00                  ;; 00:28f6
    db   $fe, $28, $00, $00, $02, $3c, $ff, $ff        ;; 00:28fc ????????
    db   $02, $02, $08, $f4, $01, $f5, $01, $f6        ;; 00:2904 ????????
    db   $01, $f7, $01, $0a, $e0, $01, $e1, $01        ;; 00:290c ????????
    db   $e2, $01, $e3, $01                            ;; 00:2914
.script_1A:
;   startX $07A0  startY $00F0  no movement  anim $2920
    db   $a0, $07, $f0, $00                            ;; 00:2918
    db   $00, $00, $20, $29, $00, $00, $0d, $0a        ;; 00:291c ????????
    db   $00, $00, $02, $02, $08, $ad, $01, $ad        ;; 00:2924 ????????
    db   $01, $ad, $01, $ad, $01, $08, $ad, $01        ;; 00:292c ????????
    db   $ad, $01, $ad, $01, $a8, $01, $08, $ad        ;; 00:2934 ????????
    db   $01, $ad, $01, $ad, $01, $a7, $01, $08        ;; 00:293c ????????
    db   $ad, $01, $ad, $01, $ad, $01, $a6, $01        ;; 00:2944 ????????
    db   $08, $ad, $01, $ad, $01, $ad, $01, $a5        ;; 00:294c ????????
    db   $01, $08, $ad, $01, $a8, $01, $ad, $01        ;; 00:2954 ????????
    db   $a4, $01, $08, $ad, $01, $a7, $01, $ad        ;; 00:295c ????????
    db   $01, $a4, $01, $08, $ad, $01, $a6, $01        ;; 00:2964 ????????
    db   $ad, $01, $a4, $01, $08, $ad, $01, $a5        ;; 00:296c ????????
    db   $01, $ad, $01, $a4, $01, $08, $ad, $01        ;; 00:2974 ????????
    db   $a5, $01, $a8, $01, $a4, $01, $08, $ad        ;; 00:297c ????????
    db   $01, $a5, $01, $a7, $01, $a4, $01, $08        ;; 00:2984 ????????
    db   $ad, $01, $a5, $01, $a6, $01, $a4, $01        ;; 00:298c ????????
    db   $0a, $ad, $01, $a5, $01, $a5, $01, $a4        ;; 00:2994 ????????
    db   $01                                           ;; 00:299c
.script_1B:
;   startX $0D20  startY $0690  no movement  anim $29A5
    db   $20, $0d, $90, $06, $00, $00, $a5             ;; 00:299d
    db   $29, $00, $00, $07, $0a, $00, $00, $01        ;; 00:29a4 ????????
    db   $02, $08, $a5, $01, $a4, $01, $08, $a6        ;; 00:29ac ????????
    db   $01, $a4, $01, $08, $a7, $01, $a4, $01        ;; 00:29b4 ????????
    db   $08, $a8, $01, $a4, $01, $08, $ad, $01        ;; 00:29bc ????????
    db   $a5, $01, $08, $ad, $01, $a6, $01, $0a        ;; 00:29c4 ????????
    db   $ad, $01, $a7, $01                            ;; 00:29cc
.script_1C:
;   startX $09E0  startY $0210  no movement  anim $29D8
    db   $e0, $09, $10, $02                            ;; 00:29d0
    db   $00, $00, $d8, $29, $00, $00, $0d, $0a        ;; 00:29d4 ????????
    db   $00, $00, $02, $02, $08, $ad, $01, $ad        ;; 00:29dc ????????
    db   $01, $ad, $01, $ad, $01, $08, $ad, $01        ;; 00:29e4 ????????
    db   $ad, $01, $ad, $01, $a8, $01, $08, $ad        ;; 00:29ec ????????
    db   $01, $ad, $01, $ad, $01, $a7, $01, $08        ;; 00:29f4 ????????
    db   $ad, $01, $ad, $01, $ad, $01, $a6, $01        ;; 00:29fc ????????
    db   $08, $ad, $01, $ad, $01, $ad, $01, $a5        ;; 00:2a04 ????????
    db   $01, $08, $ad, $01, $a8, $01, $ad, $01        ;; 00:2a0c ????????
    db   $a4, $01, $08, $ad, $01, $a7, $01, $ad        ;; 00:2a14 ????????
    db   $01, $a4, $01, $08, $ad, $01, $a6, $01        ;; 00:2a1c ????????
    db   $ad, $01, $a4, $01, $08, $ad, $01, $a5        ;; 00:2a24 ????????
    db   $01, $ad, $01, $a4, $01, $08, $ad, $01        ;; 00:2a2c ????????
    db   $a5, $01, $a8, $01, $a4, $01, $08, $ad        ;; 00:2a34 ????????
    db   $01, $a5, $01, $a7, $01, $a4, $01, $08        ;; 00:2a3c ????????
    db   $ad, $01, $a5, $01, $a6, $01, $a4, $01        ;; 00:2a44 ????????
    db   $0a, $ad, $01, $a5, $01, $a5, $01, $a4        ;; 00:2a4c ????????
    db   $01                                           ;; 00:2a54
.script_1D:
;   startX $0B00  startY $06B0  no movement  anim $2A5D
    db   $00, $0b, $b0, $06, $00, $00, $5d             ;; 00:2a55
    db   $2a, $77, $2a, $02, $3c, $ff, $00, $02        ;; 00:2a5c ????????
    db   $02, $08, $03, $00, $ce, $01, $11, $00        ;; 00:2a64 ????????
    db   $11, $00, $0a, $03, $00, $ce, $01, $22        ;; 00:2a6c ????????
    db   $00, $23, $00, $3e, $ef, $ea, $94, $d7        ;; 00:2a74 ????????
    db   $c9                                           ;; 00:2a7c
.script_1E:
;   startX $0CE0  startY $06B0  no movement  anim $2A85
    db   $e0, $0c, $b0, $06, $00, $00, $85             ;; 00:2a7d
    db   $2a, $00, $00, $02, $3c, $fe, $00, $02        ;; 00:2a84 ????????
    db   $02, $08, $03, $00, $ce, $01, $11, $00        ;; 00:2a8c ????????
    db   $11, $00, $0a, $03, $00, $ce, $01, $22        ;; 00:2a94 ????????
    db   $00, $23, $00                                 ;; 00:2a9c
.script_1F:
;   startX $03D0  startY $0810  movement $2AA7  no anim
    db   $d0, $03, $10, $08, $a7                       ;; 00:2a9f
;   move: pause $0080, RIGHT $02D0, UP $00A0, end
    db   $2a, $00, $00, $00, $80, $00, $10, $d0        ;; 00:2aa4
    db   $02, $40, $a0, $00, $ff                       ;; 00:2aac
.script_20:
;   startX $0CF0  startY $0570  movement $2AB9  no anim
    db   $f0, $0c, $70                                 ;; 00:2ab1
    db   $05, $b9, $2a, $00, $00                       ;; 00:2ab4
;   move: pause $0080, UP+LEFT $0060, LEFT $00C0, UP+LEFT $0040,
;         LEFT $00A0, UP+LEFT $0040, LEFT $0170, end
    db   $00, $80, $00                                 ;; 00:2ab9
    db   $60, $60, $00, $20, $c0, $00, $60, $40        ;; 00:2abc
    db   $00, $20, $a0, $00, $60, $40, $00, $20        ;; 00:2ac4
    db   $70, $01, $ff                                 ;; 00:2acc
.script_21:
;   startX $0880  startY $0F10  movement $2AD7  no anim
    db   $80, $08, $10, $0f, $d7                       ;; 00:2acf
;   move: pause $0080, LEFT $00E0, UP $00E0, end
    db   $2a, $00, $00, $00, $80, $00, $20, $e0        ;; 00:2ad4
    db   $00, $40, $e0, $00, $ff                       ;; 00:2adc
.script_22:
;   startX $0B80  startY $0CF0  movement $2AE9  no anim
    db   $80, $0b, $f0                                 ;; 00:2ae1
    db   $0c, $e9, $2a, $00, $00                       ;; 00:2ae4
;   move: pause $0080, RIGHT $0200, UP $0080, end
    db   $00, $80, $00                                 ;; 00:2ae9
    db   $10, $00, $02, $40, $80, $00, $ff             ;; 00:2aec
.script_23:
;   startX $0640  startY $0970  no movement  anim $2AFB
    db   $40                                           ;; 00:2af3
    db   $06, $70, $09, $00, $00, $fb, $2a, $1c        ;; 00:2af4 ????????
    db   $2b, $05, $0a, $ff, $00, $02, $01, $08        ;; 00:2afc ????????
    db   $99, $01, $9a, $01, $08, $86, $01, $87        ;; 00:2b04 ????????
    db   $01, $08, $88, $01, $89, $01, $08, $8a        ;; 00:2b0c ????????
    db   $01, $8b, $01, $0a, $8c, $01, $8d, $01        ;; 00:2b14 ????????
;   $3E $EF $EA $94 $D7 $C9 = "ld A,$EF / ld [$D794],A / ret" - the animation script
;   runner calls into its own data, so a scene can poke an override slot when it finishes
    db   $3e, $ef, $ea, $94, $d7, $c9                  ;; 00:2b1c
.script_24:
;   startX $0800  startY $0CB0  no movement  anim $2B2A
    db   $00, $08                                      ;; 00:2b22
    db   $b0, $0c, $00, $00, $2a, $2b, $4b, $2b        ;; 00:2b24 ????????
    db   $05, $0a, $ff, $00, $02, $01, $08, $99        ;; 00:2b2c ????????
    db   $01, $9a, $01, $08, $86, $01, $87, $01        ;; 00:2b34 ????????
    db   $08, $88, $01, $89, $01, $08, $8a, $01        ;; 00:2b3c ????????
    db   $8b, $01, $0a, $8c, $01, $8d, $01, $3e        ;; 00:2b44 ????????
    db   $ef, $ea, $99, $d7, $c9                       ;; 00:2b4c ; ...here writing $D799
.script_25:
;   startX $0B20  startY $0D30  no movement  anim $2B59
    db   $20, $0b, $30                                 ;; 00:2b51
    db   $0d, $00, $00, $59, $2b, $00, $00, $02        ;; 00:2b54 ????????
    db   $3c, $ff, $00, $02, $01, $08, $94, $01        ;; 00:2b5c ????????
    db   $95, $01, $0a, $d9, $01, $da, $01             ;; 00:2b64
.script_26:
;   startX $0640  startY $0D30  movement $2B73  no anim
    db   $40                                           ;; 00:2b6b
    db   $06, $30, $0d, $73, $2b, $00, $00             ;; 00:2b6c
;   move: pause $0080, RIGHT $00E0, UP $0100, RIGHT $0060, end
    db   $00                                           ;; 00:2b73
    db   $80, $00, $10, $e0, $00, $40, $00, $01        ;; 00:2b74
    db   $10, $60, $00, $ff                            ;; 00:2b7c
.script_27:
;   startX $0BC0  startY $0DB0  movement $2B88  no anim
    db   $c0, $0b, $b0, $0d                            ;; 00:2b80
    db   $88, $2b, $00, $00, $00, $80, $00, $20        ;; 00:2b84 ????????
    db   $80, $01, $80, $60, $00, $20, $e0, $00        ;; 00:2b8c ????????
    db   $ff                                           ;; 00:2b94
.script_28:
;   startX $0810  startY $0E30  movement $2B9D  no anim
;   move: pause $0080, RIGHT $0080, UP $0120, RIGHT $00E0, UP $0040, RIGHT $00B0, end
    db   $10, $08, $30, $0e, $9d, $2b, $00             ;; 00:2b95
    db   $00, $00, $80, $00, $10, $80, $00, $40        ;; 00:2b9c ????????
    db   $20, $01, $10, $e0, $00, $40, $40, $00        ;; 00:2ba4 ????????
    db   $10, $b0, $00, $ff                            ;; 00:2bac
.script_29:
;   startX $0EB0  startY $0A10  movement $2BB8  no anim
;   move: pause $0080, RIGHT $0080, UP $0240, LEFT $0190, end
    db   $b0, $0e, $10, $0a                            ;; 00:2bb0
    db   $b8, $2b, $00, $00, $00, $80, $00, $10        ;; 00:2bb4 ????????
    db   $80, $00, $40, $40, $02, $20, $90, $01        ;; 00:2bbc ????????
    db   $ff                                           ;; 00:2bc4
.script_2A:
;   startX $0280  startY $0D90  movement $2BCD  no anim
;   move: pause $0080, UP $0340, LEFT $01A0, end
    db   $80, $02, $90, $0d, $cd, $2b, $00             ;; 00:2bc5
    db   $00, $00, $80, $00, $40, $40, $03, $20        ;; 00:2bcc ????????
    db   $a0, $01, $ff                                 ;; 00:2bd4
.script_2B:
;   startX $0F30  startY $00B0  movement $2BDF  no anim
;   move: pause $0080, LEFT $0230, end
    db   $30, $0f, $b0, $00, $df                       ;; 00:2bd7
    db   $2b, $00, $00, $00, $80, $00, $20, $30        ;; 00:2bdc ????????
    db   $02, $ff                                      ;; 00:2be4
.script_2C:
;   startX $0700  startY $06B0  movement $2BEE  no anim
;   move: pause $0080, RIGHT $00E0, UP+RIGHT $0060, RIGHT $0080,
;         UP+LEFT $0100, UP+RIGHT $00C0, UP+LEFT $0120, end - a zigzag climb
    db   $00, $07, $b0, $06, $ee, $2b                  ;; 00:2be6
    db   $00, $00, $00, $80, $00, $10, $e0, $00        ;; 00:2bec ????????
    db   $50, $60, $00, $10, $80, $00, $60, $00        ;; 00:2bf4 ????????
    db   $01, $50, $c0, $00, $60, $20, $01, $ff        ;; 00:2bfc ????????
.script_2D:
;   startX $0980  startY $0CB0  movement $2C0C  no anim
;   move: pause $0080, UP $0200, RIGHT $0240, end
    db   $80, $09, $b0, $0c, $0c, $2c, $00, $00        ;; 00:2c04
    db   $00, $80, $00, $40, $00, $02, $10, $40        ;; 00:2c0c ????????
    db   $02, $ff                                      ;; 00:2c14
.script_2E:
;   startX $02F0  startY $0AF0  movement $2C1E  no anim
;   move: pause $0080, RIGHT $0280, end
    db   $f0, $02, $f0, $0a, $1e, $2c                  ;; 00:2c16
    db   $00, $00, $00, $80, $00, $10, $80, $02        ;; 00:2c1c ????????
    db   $ff                                           ;; 00:2c24
.script_2F:
;   startX $0740  startY $0AC0  no movement, no anim - reposition and hold
    db   $40, $07, $c0, $0a, $00, $00, $00             ;; 00:2c25
    db   $00                                           ;; 00:2c2c
.script_30:
;   startX $0580  startY $0B00  no movement, no anim - reposition and hold
    db   $80, $05, $00, $0b, $00, $00, $00             ;; 00:2c2d
    db   $00                                           ;; 00:2c34
.script_31:
;   startX $05E0  startY $03D0  movement $2C3D  no anim
    db   $e0, $05, $d0, $03, $3d, $2c, $00             ;; 00:2c35
    db   $00, $00, $80, $00, $10, $a0, $01, $40        ;; 00:2c3c ????????
    db   $a0, $00, $ff                                 ;; 00:2c44
.script_32:
;   startX $0E70  startY $05B0  movement $2C4F  no anim
;   move: pause $0080, RIGHT $0110, end
    db   $70, $0e, $b0, $05, $4f                       ;; 00:2c47
    db   $2c, $00, $00, $00, $80, $00, $10, $10        ;; 00:2c4c ????????
    db   $01, $ff                                      ;; 00:2c54
.script_33:
;   startX $0570  startY $0970  movement $2C5E  no anim
;   move: pause $0080, UP $01C0, RIGHT $0070, end
    db   $70, $05, $70, $09, $5e, $2c                  ;; 00:2c56
    db   $00, $00, $00, $80, $00, $40, $c0, $01        ;; 00:2c5c ????????
    db   $10, $70, $00, $ff                            ;; 00:2c64
.script_34:
;   startX $0B80  startY $01C0  no movement, no anim - reposition and hold
    db   $80, $0b, $c0, $01                            ;; 00:2c68
    db   $00, $00, $00, $00                            ;; 00:2c6c
.script_35:
;   startX $08E0  startY $0400  no movement, no anim - reposition and hold
    db   $e0, $08, $00, $04                            ;; 00:2c70
    db   $00, $00, $00, $00                            ;; 00:2c74
.script_36:
;   startX $0920  startY $0340  no movement, no anim - reposition and hold
    db   $20, $09, $40, $03                            ;; 00:2c78
    db   $00, $00, $00, $00                            ;; 00:2c7c
.script_37:
;   startX $0280  startY $0190  no movement  anim $2C88
    db   $80, $02, $90, $01                            ;; 00:2c80
    db   $00, $00, $88, $2c, $00, $00, $02, $3c        ;; 00:2c84 ????????
    db   $ff, $ff, $02, $02, $08, $f4, $01, $f5        ;; 00:2c8c ????????
    db   $01, $f6, $01, $f7, $01, $0a, $e0, $01        ;; 00:2c94 ????????
    db   $e1, $01, $e2, $01, $e3, $01                  ;; 00:2c9c
.script_38:
;   startX $0D40  startY $00B0  no movement  anim $2CAA
    db   $40, $0d                                      ;; 00:2ca2
    db   $b0, $00, $00, $00, $aa, $2c, $00, $00        ;; 00:2ca4 ????????
    db   $02, $3c, $ff, $ff, $02, $02, $08, $f4        ;; 00:2cac ????????
    db   $01, $f5, $01, $f6, $01, $f7, $01, $0a        ;; 00:2cb4 ????????
    db   $e0, $01, $e1, $01, $e2, $01, $e3, $01        ;; 00:2cbc ????????
.script_39:
;   startX $0300  startY $0190  no movement  anim $2CCC
    db   $00, $03, $90, $01, $00, $00, $cc, $2c        ;; 00:2cc4
    db   $00, $00, $02, $3c, $ff, $ff, $02, $02        ;; 00:2ccc ????????
    db   $08, $f4, $01, $f5, $01, $f6, $01, $f7        ;; 00:2cd4 ????????
    db   $01, $0a, $e0, $01, $e1, $01, $e2, $01        ;; 00:2cdc ????????
    db   $e3, $01                                      ;; 00:2ce4
.script_3A:
;   startX $0EE0  startY $05D0  no movement  anim $2CFE
    db   $e0, $0e, $d0, $05, $00, $00                  ;; 00:2ce6
    db   $fe, $2c                                      ;; 00:2cec
.script_3B:
;   startX $0120  startY $08D0  no movement  anim $2CFE - same block as $3A
    db   $20, $01, $d0, $08, $00, $00                  ;; 00:2cee
    db   $fe, $2c                                      ;; 00:2cf4
.script_3C:
;   startX $0A40  startY $05F0  no movement  anim $2CFE - same block as $3A and $3B
    db   $40, $0a, $f0, $05, $00, $00                  ;; 00:2cf6
    db   $fe, $2c, $00, $00, $09, $0a, $00, $ff        ;; 00:2cfc ????????
    db   $01, $04, $08, $a5, $01, $a9, $01, $00        ;; 00:2d04 ????????
    db   $00, $00, $00, $08, $a6, $01, $a4, $01        ;; 00:2d0c ????????
    db   $aa, $01, $00, $00, $08, $a7, $01, $a4        ;; 00:2d14 ????????
    db   $01, $ab, $01, $00, $00, $08, $a8, $01        ;; 00:2d1c ????????
    db   $a4, $01, $ac, $01, $00, $00, $08, $ad        ;; 00:2d24 ????????
    db   $01, $a5, $01, $a9, $01, $00, $00, $08        ;; 00:2d2c ????????
    db   $ad, $01, $a6, $01, $a4, $01, $aa, $01        ;; 00:2d34 ????????
    db   $08, $ad, $01, $a7, $01, $a4, $01, $ab        ;; 00:2d3c ????????
    db   $01, $08, $ad, $01, $a8, $01, $a4, $01        ;; 00:2d44 ????????
    db   $ac, $01, $0a, $ad, $01, $ad, $01, $a5        ;; 00:2d4c ????????
    db   $01, $a9, $01                                 ;; 00:2d54
.script_3D:
;   startX $0860  startY $0C10  movement $2D5F  no anim
;   move: pause $0080, RIGHT $0040, DOWN+RIGHT $0040, RIGHT $0280, UP+RIGHT $0060, end
    db   $60, $08, $10, $0c, $5f                       ;; 00:2d57
    db   $2d, $00, $00, $00, $80, $00, $10, $40        ;; 00:2d5c ????????
    db   $00, $90, $40, $00, $10, $80, $02, $50        ;; 00:2d64 ????????
    db   $60, $00, $ff                                 ;; 00:2d6c
.script_3E:
;   startX $0B50  startY $06F0  movement $2D77  no anim
;   move: pause $0080, RIGHT $0150, end
    db   $50, $0b, $f0, $06, $77                       ;; 00:2d6f
    db   $2d, $00, $00, $00, $80, $00, $10, $50        ;; 00:2d74 ????????
    db   $01, $ff                                      ;; 00:2d7c
.script_3F:
;   startX $03C0  startY $0390  movement $2D86  no anim
;   move: pause $0080, UP $0080, RIGHT $0160, UP $0060, end
    db   $c0, $03, $90, $03, $86, $2d                  ;; 00:2d7e
    db   $00, $00, $00, $80, $00, $40, $80, $00        ;; 00:2d84 ????????
    db   $10, $60, $01, $40, $60, $00, $ff             ;; 00:2d8c
.script_40:
;   startX $0A00  startY $0100  no movement, no anim - reposition and hold
    db   $00                                           ;; 00:2d93
    db   $0a, $00, $01, $00, $00, $00, $00             ;; 00:2d94
.script_41:
;   startX $03C0  startY $05B0  movement $2DA3  no anim
;   move: pause $0080, UP $0060, RIGHT $00E0, UP $0240, end
    db   $c0                                           ;; 00:2d9b
    db   $03, $b0, $05, $a3, $2d, $00, $00, $00        ;; 00:2d9c ????????
    db   $80, $00, $40, $60, $00, $10, $e0, $00        ;; 00:2da4 ????????
    db   $40, $40, $02, $ff                            ;; 00:2dac
.script_42:
;   startX $08B0  startY $06D0  movement $2DB8  no anim
;   move: pause $0080, LEFT $02F0, end - the $FF below is the last byte of the blob
    db   $b0, $08, $d0, $06                            ;; 00:2db0
    db   $b8, $2d, $00, $00, $00, $80, $00, $20        ;; 00:2db4 ????????
    db   $f0, $02, $ff                                 ;; 00:2dbc ???

call_00_2dbf_Cutscene_UpdateMovement:
; Moves Gex one step along the scripted path, once per frame.
;
; The speed is kept as 1/16ths of a pixel: wD79D_Cutscene_MoveSpeed is added into the low
; nibble of wD79E_Cutscene_MoveSubPixel each frame, and whatever carries into the high nibble
; is the whole-pixel step applied to the position. Then the direction bits in wD75A decide
; which axis it goes on - and note nothing stops two bits being set, so a script can move
; diagonally by using $30 or $90.
;
; The two speed-ramp branches below look like acceleration and deceleration, but both are
; dead: each does an inc/dec of the speed and then immediately overwrites it with a constant.
; The `inc [HL] / dec [HL]` pair in the first branch is a zero test, but the `dec [HL]` that
; follows is thrown away by `ld [HL],$00`, and likewise `inc [HL]` before
; `ld [HL],CUTSCENE_MOVE_SPEED_MAX`. So the speed is only ever $00 or $10 - the preview always
; glides at exactly one pixel per frame and the sub-pixel accumulator never does anything
; interesting. Presumably the ramp was meant to ease the pan in and out
    ld   A, [wD75A_CurrentInputsAlt]                                    ;; 00:2dbf $fa $5a $d7
    and  A, A                                          ;; 00:2dc2 $a7
    jr   NZ, .jr_00_2dd1                               ;; 00:2dc3 $20 $0c
    ld   HL, wD79D_Cutscene_MoveSpeed                                     ;; 00:2dc5 $21 $9d $d7
    inc  [HL]                                          ;; 00:2dc8 $34 ; inc/dec = test for zero
    dec  [HL]                                          ;; 00:2dc9 $35
    jr   Z, .jr_00_2ddc                                ;; 00:2dca $28 $10
    dec  [HL]                                          ;; 00:2dcc $35 ; dead - overwritten below
    ld   [HL], $00                                     ;; 00:2dcd $36 $00
    jr   .jr_00_2ddc                                   ;; 00:2dcf $18 $0b
.jr_00_2dd1:
    ld   HL, wD79D_Cutscene_MoveSpeed                                     ;; 00:2dd1 $21 $9d $d7
    ld   A, [HL]                                       ;; 00:2dd4 $7e
    cp   A, CUTSCENE_MOVE_SPEED_MAX                    ;; 00:2dd5 $fe $10
    jr   Z, .jr_00_2ddc                                ;; 00:2dd7 $28 $03
    inc  [HL]                                          ;; 00:2dd9 $34 ; dead - overwritten below
    ld   [HL], CUTSCENE_MOVE_SPEED_MAX                 ;; 00:2dda $36 $10
.jr_00_2ddc:
    ld   HL, wD79D_Cutscene_MoveSpeed                                     ;; 00:2ddc $21 $9d $d7
    ld   A, [HL+]                                      ;; 00:2ddf $2a
    ld   C, A                                          ;; 00:2de0 $4f
    ld   A, [HL]                                       ;; 00:2de1 $7e
    and  A, $0f                                        ;; 00:2de2 $e6 $0f
    add  A, C                                          ;; 00:2de4 $81
    ld   [HL], A                                       ;; 00:2de5 $77
    swap A                                             ;; 00:2de6 $cb $37
    and  A, $0f                                        ;; 00:2de8 $e6 $0f
    ld   C, A                                          ;; 00:2dea $4f
    ld   HL, wD75A_CurrentInputsAlt                                     ;; 00:2deb $21 $5a $d7
    bit  PADF_RIGHT_BIT, [HL]                                       ;; 00:2dee $cb $66
    jr   Z, .jr_00_2e01                                ;; 00:2df0 $28 $0f
    ld   A, [wD20E_Player_XPositionLo]                                    ;; 00:2df2 $fa $0e $d2
    add  A, C                                          ;; 00:2df5 $81
    ld   [wD20E_Player_XPositionLo], A                                    ;; 00:2df6 $ea $0e $d2
    ld   A, [wD20F_Player_XPositionHi]                                    ;; 00:2df9 $fa $0f $d2
    adc  A, $00                                        ;; 00:2dfc $ce $00
    ld   [wD20F_Player_XPositionHi], A                                    ;; 00:2dfe $ea $0f $d2
.jr_00_2e01:
    bit  PADF_LEFT_BIT, [HL]                                       ;; 00:2e01 $cb $6e
    jr   Z, .jr_00_2e14                                ;; 00:2e03 $28 $0f
    ld   A, [wD20E_Player_XPositionLo]                                    ;; 00:2e05 $fa $0e $d2
    sub  A, C                                          ;; 00:2e08 $91
    ld   [wD20E_Player_XPositionLo], A                                    ;; 00:2e09 $ea $0e $d2
    ld   A, [wD20F_Player_XPositionHi]                                    ;; 00:2e0c $fa $0f $d2
    sbc  A, $00                                        ;; 00:2e0f $de $00
    ld   [wD20F_Player_XPositionHi], A                                    ;; 00:2e11 $ea $0f $d2
.jr_00_2e14:
    bit  PADF_DOWN_BIT, [HL]                                       ;; 00:2e14 $cb $7e
    jr   Z, .jr_00_2e27                                ;; 00:2e16 $28 $0f
    ld   A, [wD210_Player_YPositionLo]                                    ;; 00:2e18 $fa $10 $d2
    add  A, C                                          ;; 00:2e1b $81
    ld   [wD210_Player_YPositionLo], A                                    ;; 00:2e1c $ea $10 $d2
    ld   A, [wD211_Player_YPositionHi]                                    ;; 00:2e1f $fa $11 $d2
    adc  A, $00                                        ;; 00:2e22 $ce $00
    ld   [wD211_Player_YPositionHi], A                                    ;; 00:2e24 $ea $11 $d2
.jr_00_2e27:
    bit  PADF_UP_BIT, [HL]                                       ;; 00:2e27 $cb $76
    ret  Z                                             ;; 00:2e29 $c8
    ld   A, [wD210_Player_YPositionLo]                                    ;; 00:2e2a $fa $10 $d2
    sub  A, C                                          ;; 00:2e2d $91
    ld   [wD210_Player_YPositionLo], A                                    ;; 00:2e2e $ea $10 $d2
    ld   A, [wD211_Player_YPositionHi]                                    ;; 00:2e31 $fa $11 $d2
    sbc  A, $00                                        ;; 00:2e34 $de $00
    ld   [wD211_Player_YPositionHi], A                                    ;; 00:2e36 $ea $11 $d2
    ret                                                ;; 00:2e39 $c9
