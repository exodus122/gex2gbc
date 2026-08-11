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
; CUTSCENE_HOLD_FRAMES. The animation block is a block patch sequence, in the
; same format the special-tile runner uses; its layout is documented on
; .data_00_2662_CutsceneScriptPointerTable. That is also where the small `ld A,$xx /
; ld [$D7xx],A / ret` stubs scattered through the data come from - they are the sequence's
; callback field, run at setup, and they poke a block patch slot because the scene has
; permanently revealed something.
;
; The trick behind it is that there is no camera. Gex himself is teleported to the start of
; the shot and then *walked* along a scripted path, with the normal map window logic following
; him as usual. The script does this by writing fake d-pad values straight into
; wD75A_Player_EffectiveInputs, so from the map and entity code's point of view nothing unusual is
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
    call call_00_0521_Screen_PresentAndFadeIn                                  ;; 00:237d $cd $21 $05
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
    ld   [wD75A_Player_EffectiveInputs], A                                    ;; 00:2394 $ea $5a $d7
    ld   A, [HL+]                                      ;; 00:2397 $2a
    ld   [wD79B_Cutscene_MoveFramesRemaining], A                                    ;; 00:2398 $ea $9b $d7
    ld   A, [HL+]                                      ;; 00:239b $2a
    ld   [wD79B_Cutscene_MoveFramesRemaining+1], A                                    ;; 00:239c $ea $9c $d7
    push HL                                            ;; 00:239f $e5
.jr_00_23a0:
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:23a0 $fa $75 $d7
    and  A, A                                          ;; 00:23a3 $a7
    jr   Z, .jr_00_23b1                                ;; 00:23a4 $28 $0b
    ld   A, [wD59F_RawInputs]                                    ;; 00:23a6 $fa $9f $d5
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
    call call_00_08fc_StageNextGfxTransfer                                  ;; 00:23d0 $cd $fc $08
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
    call call_00_1f80_TileHitScript_Run                                  ;; 00:23ef $cd $80 $1f
.jr_00_23f2:
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:23f2 $fa $75 $d7
    and  A, A                                          ;; 00:23f5 $a7
    jr   Z, .jr_00_23fe                                ;; 00:23f6 $28 $06
    ld   A, [wD59F_RawInputs]                                    ;; 00:23f8 $fa $9f $d5
    and  A, A                                          ;; 00:23fb $a7
    jr   NZ, .jp_00_2445                               ;; 00:23fc $20 $47
.jr_00_23fe:
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:23fe $cd $b4 $0a
    call call_00_1e5b_BlockPatch_TickSequence                                  ;; 00:2401 $cd $5b $1e
    FARCALL call_02_6eba_Entities_UpdateAll
    call call_00_08fc_StageNextGfxTransfer                                  ;; 00:240f $cd $fc $08
    ld   A, [wD77D_BlockPatch_StepsRemaining]                                    ;; 00:2412 $fa $7d $d7
    and  A, A                                          ;; 00:2415 $a7
    jr   NZ, .jr_00_23f2                               ;; 00:2416 $20 $da
    ld   A, [wD77B_BlockPatch_VramWritePending]                                    ;; 00:2418 $fa $7b $d7
    and  A, A                                          ;; 00:241b $a7
    jr   NZ, .jr_00_23f2                               ;; 00:241c $20 $d4
.jr_00_241e:
    ld   A, CUTSCENE_HOLD_FRAMES                       ;; 00:241e $3e $b4
.jr_00_2420:
    push AF                                            ;; 00:2420 $f5
    call call_00_0ab4_WaitForInterrupt                                  ;; 00:2421 $cd $b4 $0a
    FARCALL call_02_6eba_Entities_UpdateAll
    call call_00_08fc_StageNextGfxTransfer                                  ;; 00:242f $cd $fc $08
    ld   A, [wD775_Cutscene_Skippable]                                    ;; 00:2432 $fa $75 $d7
    and  A, A                                          ;; 00:2435 $a7
    jr   Z, .jr_00_2441                                ;; 00:2436 $28 $09
    ld   A, [wD59F_RawInputs]                                    ;; 00:2438 $fa $9f $d5
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
    jp   call_00_0521_Screen_PresentAndFadeIn                                  ;; 00:246f $c3 $21 $05
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
;  slot: 0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
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
; 67 entries, followed by the scripts themselves at $26E8-$2DBE. A script's movement list and
; animation block sit immediately after its header, so each script and its data are one
; contiguous run and the whole region is written in address order below.
;
; Everything down there is built from the macros in macros.asm - cutscene_script,
; cutscene_move, blockpatch_header, blockpatch_step, blockpatch_cells - which emit exactly the
; bytes the runner expects. The layout each one produces is documented on the macro itself.
;
; Three things worth knowing that the macros do not say:
;
;   The animation block is not cutscene-specific. It is a block patch sequence in exactly the
;   format TileHitScript_Run / BlockPatch_TickSequence consume for switches and breakable
;   scenery, so the same reveal machinery drives both.
;
;   The last step of every block here sets BLOCKPATCH_STEP_REGISTER, and that is what makes a
;   reveal permanent. Tiles are redrawn on every step, but only a registering step records the
;   rectangle in the block patch slot tables - which is what lets the change survive the
;   BgMap_LoadFull on the way out of the scene. Only .script_0D uses BLOCKPATCH_STEP_SFX.
;
;   The rectangle is positioned relative to *Gex*, not in map coordinates. That is why a scene
;   with an animation always teleports him to a fixed spot first: the tile edit lands wherever
;   he happens to be standing.
;
; The callbacks are real code sitting inside the data, at the address one past the end of the
; step data they belong to - see .script_1D_callback. Only three scripts have one.
;
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
; ------------------------------------------------------------------
; $00   media dimension, slot 0
; ------------------------------------------------------------------
.script_00:
    cutscene_script $04e0, $01d0, 0, .script_00_anim

.script_00_anim:
    blockpatch_header 0, 3, 10, -2, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/3
    blockpatch_cells $ee,1, $ef,1
    blockpatch_cells $fe,1, $ff,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/3
    blockpatch_cells $7e,1, $7f,1
    blockpatch_cells $8e,1, $8f,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 3/3
    blockpatch_cells $7c,1, $7d,1
    blockpatch_cells $8c,1, $8d,1

; ------------------------------------------------------------------
; $01   media dimension, slot 1
; ------------------------------------------------------------------
.script_01:
    cutscene_script $03a0, $02f0, 0, .script_01_anim

.script_01_anim:
    blockpatch_header 0, 3, 10, -2, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/3
    blockpatch_cells $ea,1, $eb,1
    blockpatch_cells $fa,1, $fb,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/3
    blockpatch_cells $7a,1, $7b,1
    blockpatch_cells $8a,1, $8b,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 3/3
    blockpatch_cells $78,1, $79,1
    blockpatch_cells $88,1, $89,1

; ------------------------------------------------------------------
; $02   media dimension, slot 2
; ------------------------------------------------------------------
.script_02:
    cutscene_script $0620, $02f0, 0, .script_02_anim

.script_02_anim:
    blockpatch_header 0, 3, 10, -2, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/3
    blockpatch_cells $e6,1, $e7,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/3
    blockpatch_cells $5e,1, $5f,1
    blockpatch_cells $6e,1, $6f,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 3/3
    blockpatch_cells $5c,1, $5d,1
    blockpatch_cells $6c,1, $6d,1

; ------------------------------------------------------------------
; $03   media dimension, slot 3
; ------------------------------------------------------------------
.script_03:
    cutscene_script $08a0, $02f0, 0, .script_03_anim

.script_03_anim:
    blockpatch_header 0, 3, 10, -2, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/3
    blockpatch_cells $be,1, $bf,1
    blockpatch_cells $ce,1, $cf,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/3
    blockpatch_cells $5a,1, $5b,1
    blockpatch_cells $6a,1, $6b,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 3/3
    blockpatch_cells $58,1, $59,1
    blockpatch_cells $68,1, $69,1

; ------------------------------------------------------------------
; $04   out of toon, mission 1
; ------------------------------------------------------------------
.script_04:
    cutscene_script $0dd0, $06f0, .script_04_move, 0

.script_04_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0100
    cutscene_move PADF_RIGHT,            $0190
    cutscene_move_end

; ------------------------------------------------------------------
; $05   out of toon, mission 2
; ------------------------------------------------------------------
.script_05:
    cutscene_script $0320, $0510, .script_05_move, 0

.script_05_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0180
    cutscene_move_end

; ------------------------------------------------------------------
; $06   out of toon, mission 3
; ------------------------------------------------------------------
.script_06:
    cutscene_script $0a20, $00d0, .script_06_move, 0

.script_06_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0160
    cutscene_move_end

; ------------------------------------------------------------------
; $07   out of toon, slot $0E
; ------------------------------------------------------------------
.script_07:
    cutscene_script $04a0, $0500, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $08   out of toon, slot $0F
; ------------------------------------------------------------------
.script_08:
    cutscene_script $0c20, $0180, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $09   smellraiser, mission 1
; ------------------------------------------------------------------
.script_09:
    cutscene_script $0520, $0430, .script_09_move, 0

.script_09_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0080
    cutscene_move_end

; ------------------------------------------------------------------
; $0a   smellraiser, mission 2
; ------------------------------------------------------------------
.script_0A:
    cutscene_script $0070, $0150, .script_0A_move, 0

.script_0A_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $00a0
    cutscene_move PADF_UP | PADF_RIGHT,  $0040
    cutscene_move PADF_RIGHT,            $00e0
    cutscene_move PADF_UP,               $0060
    cutscene_move PADF_LEFT,             $00c0
    cutscene_move_end

; ------------------------------------------------------------------
; $0b   smellraiser, mission 3
; ------------------------------------------------------------------
.script_0B:
    cutscene_script $00b0, $0450, .script_0B_move, 0

.script_0B_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0270
    cutscene_move_end

; ------------------------------------------------------------------
; $0c   smellraiser, slot $0E
; ------------------------------------------------------------------
.script_0C:
    cutscene_script $0ec0, $0140, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $0d   smellraiser, slot 0
; ------------------------------------------------------------------
.script_0D:
    cutscene_script $00bc, $0340, 0, .script_0D_anim

.script_0D_anim:
    blockpatch_header 0, 2, 60, 0, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX                ; step 1/2
    blockpatch_sfx  SFX_26
    blockpatch_cells $f4,1, $f5,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $f2,1, $f3,1

; ------------------------------------------------------------------
; $0e   frankensteinfeld, mission 1
; ------------------------------------------------------------------
.script_0E:
    cutscene_script $0390, $0af0, .script_0E_move, 0

.script_0E_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_LEFT,             $0270
    cutscene_move_end

; ------------------------------------------------------------------
; $0f   frankensteinfeld, mission 2
; ------------------------------------------------------------------
.script_0F:
    cutscene_script $0ad0, $05b0, .script_0F_move, 0

.script_0F_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_DOWN | PADF_RIGHT, $0090
    cutscene_move_end

; ------------------------------------------------------------------
; $10   frankensteinfeld, mission 3
; ------------------------------------------------------------------
.script_10:
    cutscene_script $0ab0, $0a50, .script_10_move, 0

.script_10_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0080
    cutscene_move PADF_RIGHT,            $00a0
    cutscene_move PADF_UP,               $0040
    cutscene_move_end

; ------------------------------------------------------------------
; $11   www.dotcom.com, mission 1
; ------------------------------------------------------------------
.script_11:
    cutscene_script $02c0, $0850, .script_11_move, 0

.script_11_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0460
    cutscene_move_end

; ------------------------------------------------------------------
; $12   www.dotcom.com, mission 2
; ------------------------------------------------------------------
.script_12:
    cutscene_script $0c70, $0770, .script_12_move, 0

.script_12_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $02d0
    cutscene_move_end

; ------------------------------------------------------------------
; $13   mao tse tongue, mission 1
; ------------------------------------------------------------------
.script_13:
    cutscene_script $0230, $04f0, .script_13_move, 0

.script_13_move:
    cutscene_move 0,                     $012c   ; stand still
    cutscene_move_end

; ------------------------------------------------------------------
; $14   mao tse tongue, mission 2
; ------------------------------------------------------------------
.script_14:
    cutscene_script $0b30, $08b0, .script_14_move, 0

.script_14_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $00a0
    cutscene_move PADF_RIGHT,            $0190
    cutscene_move PADF_UP | PADF_RIGHT,  $0040
    cutscene_move_end

; ------------------------------------------------------------------
; $15   mao tse tongue, slot 0
; ------------------------------------------------------------------
.script_15:
    cutscene_script $03c0, $06a0, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $16   mao tse tongue, slot 1
; ------------------------------------------------------------------
.script_16:
    cutscene_script $0860, $07b0, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $17   mao tse tongue, slot 2
; ------------------------------------------------------------------
.script_17:
    cutscene_script $09c0, $00b0, 0, .script_17_anim

.script_17_anim:
    blockpatch_header 0, 2, 60, -1, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $f4,1, $f5,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $e0,1, $e1,1
    blockpatch_cells $e2,1, $e3,1

; ------------------------------------------------------------------
; $18   mao tse tongue, slot 3
; ------------------------------------------------------------------
.script_18:
    cutscene_script $0980, $0690, 0, .script_18_anim

.script_18_anim:
    blockpatch_header 0, 2, 60, -1, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $f4,1, $f5,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $e0,1, $e1,1
    blockpatch_cells $e2,1, $e3,1

; ------------------------------------------------------------------
; $19   mao tse tongue, slot 4
; ------------------------------------------------------------------
.script_19:
    cutscene_script $0100, $0550, 0, .script_19_anim

.script_19_anim:
    blockpatch_header 0, 2, 60, -1, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $f4,1, $f5,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $e0,1, $e1,1
    blockpatch_cells $e2,1, $e3,1

; ------------------------------------------------------------------
; $1a   mao tse tongue, slot 5
; ------------------------------------------------------------------
.script_1A:
    cutscene_script $07a0, $00f0, 0, .script_1A_anim

.script_1A_anim:
    blockpatch_header 0, 13, 10, 0, 0, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $ad,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a8,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 3/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a7,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 4/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a6,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 5/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a5,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 6/13
    blockpatch_cells $ad,1, $a8,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 7/13
    blockpatch_cells $ad,1, $a7,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 8/13
    blockpatch_cells $ad,1, $a6,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 9/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 10/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a8,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 11/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a7,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 12/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a6,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 13/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a5,1, $a4,1

; ------------------------------------------------------------------
; $1b   mao tse tongue, slot 6
; ------------------------------------------------------------------
.script_1B:
    cutscene_script $0d20, $0690, 0, .script_1B_anim

.script_1B_anim:
    blockpatch_header 0, 7, 10, 0, 0, 1, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/7
    blockpatch_cells $a5,1
    blockpatch_cells $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/7
    blockpatch_cells $a6,1
    blockpatch_cells $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 3/7
    blockpatch_cells $a7,1
    blockpatch_cells $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 4/7
    blockpatch_cells $a8,1
    blockpatch_cells $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 5/7
    blockpatch_cells $ad,1
    blockpatch_cells $a5,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 6/7
    blockpatch_cells $ad,1
    blockpatch_cells $a6,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 7/7
    blockpatch_cells $ad,1
    blockpatch_cells $a7,1

; ------------------------------------------------------------------
; $1c   mao tse tongue, slot 7
; ------------------------------------------------------------------
.script_1C:
    cutscene_script $09e0, $0210, 0, .script_1C_anim

.script_1C_anim:
    blockpatch_header 0, 13, 10, 0, 0, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $ad,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a8,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 3/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a7,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 4/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a6,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 5/13
    blockpatch_cells $ad,1, $ad,1
    blockpatch_cells $ad,1, $a5,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 6/13
    blockpatch_cells $ad,1, $a8,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 7/13
    blockpatch_cells $ad,1, $a7,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 8/13
    blockpatch_cells $ad,1, $a6,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 9/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $ad,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 10/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a8,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 11/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a7,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 12/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a6,1, $a4,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 13/13
    blockpatch_cells $ad,1, $a5,1
    blockpatch_cells $a5,1, $a4,1

; ------------------------------------------------------------------
; $1d   mao tse tongue, slot 8
; ------------------------------------------------------------------
.script_1D:
    cutscene_script $0b00, $06b0, 0, .script_1D_anim

.script_1D_anim:
    blockpatch_header .script_1D_callback, 2, 60, -1, 0, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $03,0, $ce,1
    blockpatch_cells $11,0, $11,0
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $03,0, $ce,1
    blockpatch_cells $22,0, $23,0

.script_1D_callback:
; The setup callback of the animation above. Puts block patch slot 9 into the
; counting-up state, but at $EF rather than the $02 a switch would use - so
; BlockPatch_TickSlots has only $11 frames left to count before it wraps and
; re-arms the slot to $01
    ld   A, $ef
    ld   [wD78B_BlockPatch_SlotTable + 9], A
    ret

; ------------------------------------------------------------------
; $1e   mao tse tongue, slot 9
; ------------------------------------------------------------------
.script_1E:
    cutscene_script $0ce0, $06b0, 0, .script_1E_anim

.script_1E_anim:
    blockpatch_header 0, 2, 60, -2, 0, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $03,0, $ce,1
    blockpatch_cells $11,0, $11,0
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $03,0, $ce,1
    blockpatch_cells $22,0, $23,0

; ------------------------------------------------------------------
; $1f   pangaea 90210, mission 1
; ------------------------------------------------------------------
.script_1F:
    cutscene_script $03d0, $0810, .script_1F_move, 0

.script_1F_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $02d0
    cutscene_move PADF_UP,               $00a0
    cutscene_move_end

; ------------------------------------------------------------------
; $20   pangaea 90210, mission 2
; ------------------------------------------------------------------
.script_20:
    cutscene_script $0cf0, $0570, .script_20_move, 0

.script_20_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP | PADF_LEFT,   $0060
    cutscene_move PADF_LEFT,             $00c0
    cutscene_move PADF_UP | PADF_LEFT,   $0040
    cutscene_move PADF_LEFT,             $00a0
    cutscene_move PADF_UP | PADF_LEFT,   $0040
    cutscene_move PADF_LEFT,             $0170
    cutscene_move_end

; ------------------------------------------------------------------
; $21   fine tooning, mission 1
; ------------------------------------------------------------------
.script_21:
    cutscene_script $0880, $0f10, .script_21_move, 0

.script_21_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_LEFT,             $00e0
    cutscene_move PADF_UP,               $00e0
    cutscene_move_end

; ------------------------------------------------------------------
; $22   fine tooning, mission 2
; ------------------------------------------------------------------
.script_22:
    cutscene_script $0b80, $0cf0, .script_22_move, 0

.script_22_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0200
    cutscene_move PADF_UP,               $0080
    cutscene_move_end

; ------------------------------------------------------------------
; $23   fine tooning, slot 6
; ------------------------------------------------------------------
.script_23:
    cutscene_script $0640, $0970, 0, .script_23_anim

.script_23_anim:
    blockpatch_header .script_23_callback, 5, 10, -1, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/5
    blockpatch_cells $99,1, $9a,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/5
    blockpatch_cells $86,1, $87,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 3/5
    blockpatch_cells $88,1, $89,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 4/5
    blockpatch_cells $8a,1, $8b,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 5/5
    blockpatch_cells $8c,1, $8d,1

.script_23_callback:
; The setup callback of the animation above. Puts block patch slot 9 into the
; counting-up state, but at $EF rather than the $02 a switch would use - so
; BlockPatch_TickSlots has only $11 frames left to count before it wraps and
; re-arms the slot to $01
    ld   A, $ef
    ld   [wD78B_BlockPatch_SlotTable + 9], A
    ret

; ------------------------------------------------------------------
; $24   fine tooning, slot 9
; ------------------------------------------------------------------
.script_24:
    cutscene_script $0800, $0cb0, 0, .script_24_anim

.script_24_anim:
    blockpatch_header .script_24_callback, 5, 10, -1, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/5
    blockpatch_cells $99,1, $9a,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/5
    blockpatch_cells $86,1, $87,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 3/5
    blockpatch_cells $88,1, $89,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 4/5
    blockpatch_cells $8a,1, $8b,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 5/5
    blockpatch_cells $8c,1, $8d,1

.script_24_callback:
; The setup callback of the animation above. Puts block patch slot 14 into the
; counting-up state, but at $EF rather than the $02 a switch would use - so
; BlockPatch_TickSlots has only $11 frames left to count before it wraps and
; re-arms the slot to $01
    ld   A, $ef
    ld   [wD78B_BlockPatch_SlotTable + 14], A
    ret

; ------------------------------------------------------------------
; $25   fine tooning, slot $0E
; ------------------------------------------------------------------
.script_25:
    cutscene_script $0b20, $0d30, 0, .script_25_anim

.script_25_anim:
    blockpatch_header 0, 2, 60, -1, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $94,1, $95,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $d9,1, $da,1

; ------------------------------------------------------------------
; $26   this old cave, mission 1
; ------------------------------------------------------------------
.script_26:
    cutscene_script $0640, $0d30, .script_26_move, 0

.script_26_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $00e0
    cutscene_move PADF_UP,               $0100
    cutscene_move PADF_RIGHT,            $0060
    cutscene_move_end

; ------------------------------------------------------------------
; $27   this old cave, mission 2
; ------------------------------------------------------------------
.script_27:
    cutscene_script $0bc0, $0db0, .script_27_move, 0

.script_27_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_LEFT,             $0180
    cutscene_move PADF_DOWN,             $0060
    cutscene_move PADF_LEFT,             $00e0
    cutscene_move_end

; ------------------------------------------------------------------
; $28   this old cave, mission 3
; ------------------------------------------------------------------
.script_28:
    cutscene_script $0810, $0e30, .script_28_move, 0

.script_28_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0080
    cutscene_move PADF_UP,               $0120
    cutscene_move PADF_RIGHT,            $00e0
    cutscene_move PADF_UP,               $0040
    cutscene_move PADF_RIGHT,            $00b0
    cutscene_move_end

; ------------------------------------------------------------------
; $29   honey i shrunk the gecko, mission 1
; ------------------------------------------------------------------
.script_29:
    cutscene_script $0eb0, $0a10, .script_29_move, 0

.script_29_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0080
    cutscene_move PADF_UP,               $0240
    cutscene_move PADF_LEFT,             $0190
    cutscene_move_end

; ------------------------------------------------------------------
; $2a   honey i shrunk the gecko, mission 2
; ------------------------------------------------------------------
.script_2A:
    cutscene_script $0280, $0d90, .script_2A_move, 0

.script_2A_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0340
    cutscene_move PADF_LEFT,             $01a0
    cutscene_move_end

; ------------------------------------------------------------------
; $2b   honey i shrunk the gecko, mission 3
; ------------------------------------------------------------------
.script_2B:
    cutscene_script $0f30, $00b0, .script_2B_move, 0

.script_2B_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_LEFT,             $0230
    cutscene_move_end

; ------------------------------------------------------------------
; $2c   poltergex, mission 1
; ------------------------------------------------------------------
.script_2C:
    cutscene_script $0700, $06b0, .script_2C_move, 0

.script_2C_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $00e0
    cutscene_move PADF_UP | PADF_RIGHT,  $0060
    cutscene_move PADF_RIGHT,            $0080
    cutscene_move PADF_UP | PADF_LEFT,   $0100
    cutscene_move PADF_UP | PADF_RIGHT,  $00c0
    cutscene_move PADF_UP | PADF_LEFT,   $0120
    cutscene_move_end

; ------------------------------------------------------------------
; $2d   poltergex, mission 2
; ------------------------------------------------------------------
.script_2D:
    cutscene_script $0980, $0cb0, .script_2D_move, 0

.script_2D_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0200
    cutscene_move PADF_RIGHT,            $0240
    cutscene_move_end

; ------------------------------------------------------------------
; $2e   poltergex, mission 3
; ------------------------------------------------------------------
.script_2E:
    cutscene_script $02f0, $0af0, .script_2E_move, 0

.script_2E_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0280
    cutscene_move_end

; ------------------------------------------------------------------
; $2f   poltergex, slot $0F
; ------------------------------------------------------------------
.script_2F:
    cutscene_script $0740, $0ac0, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $30   poltergex, slot 0
; ------------------------------------------------------------------
.script_30:
    cutscene_script $0580, $0b00, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $31   samurai night fever, mission 1
; ------------------------------------------------------------------
.script_31:
    cutscene_script $05e0, $03d0, .script_31_move, 0

.script_31_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $01a0
    cutscene_move PADF_UP,               $00a0
    cutscene_move_end

; ------------------------------------------------------------------
; $32   samurai night fever, mission 2
; ------------------------------------------------------------------
.script_32:
    cutscene_script $0e70, $05b0, .script_32_move, 0

.script_32_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0110
    cutscene_move_end

; ------------------------------------------------------------------
; $33   samurai night fever, mission 3
; ------------------------------------------------------------------
.script_33:
    cutscene_script $0570, $0970, .script_33_move, 0

.script_33_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $01c0
    cutscene_move PADF_RIGHT,            $0070
    cutscene_move_end

; ------------------------------------------------------------------
; $34   samurai night fever, slot 0
; ------------------------------------------------------------------
.script_34:
    cutscene_script $0b80, $01c0, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $35   samurai night fever, slot 1
; ------------------------------------------------------------------
.script_35:
    cutscene_script $08e0, $0400, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $36   samurai night fever, slot 2
; ------------------------------------------------------------------
.script_36:
    cutscene_script $0920, $0340, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $37   samurai night fever, slot 3
; ------------------------------------------------------------------
.script_37:
    cutscene_script $0280, $0190, 0, .script_37_anim

.script_37_anim:
    blockpatch_header 0, 2, 60, -1, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $f4,1, $f5,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $e0,1, $e1,1
    blockpatch_cells $e2,1, $e3,1

; ------------------------------------------------------------------
; $38   samurai night fever, slot 4
; ------------------------------------------------------------------
.script_38:
    cutscene_script $0d40, $00b0, 0, .script_38_anim

.script_38_anim:
    blockpatch_header 0, 2, 60, -1, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $f4,1, $f5,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $e0,1, $e1,1
    blockpatch_cells $e2,1, $e3,1

; ------------------------------------------------------------------
; $39   samurai night fever, slot 5
; ------------------------------------------------------------------
.script_39:
    cutscene_script $0300, $0190, 0, .script_39_anim

.script_39_anim:
    blockpatch_header 0, 2, 60, -1, -1, 2, 2
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/2
    blockpatch_cells $f4,1, $f5,1
    blockpatch_cells $f6,1, $f7,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 2/2
    blockpatch_cells $e0,1, $e1,1
    blockpatch_cells $e2,1, $e3,1

; ------------------------------------------------------------------
; $3a   samurai night fever, slot 6
; ------------------------------------------------------------------
.script_3A:
    cutscene_script $0ee0, $05d0, 0, .anim_shared_3A_3C

; ------------------------------------------------------------------
; $3b   samurai night fever, slot 7
; ------------------------------------------------------------------
.script_3B:
    cutscene_script $0120, $08d0, 0, .anim_shared_3A_3C

; ------------------------------------------------------------------
; $3c   samurai night fever, slot 8
; ------------------------------------------------------------------
.script_3C:
    cutscene_script $0a40, $05f0, 0, .anim_shared_3A_3C

; Shared by scripts $3a, $3b and $3c - all three show the same reveal
.anim_shared_3A_3C:
    blockpatch_header 0, 9, 10, 0, -1, 1, 4
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 1/9
    blockpatch_cells $a5,1
    blockpatch_cells $a9,1
    blockpatch_cells $00,0
    blockpatch_cells $00,0
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 2/9
    blockpatch_cells $a6,1
    blockpatch_cells $a4,1
    blockpatch_cells $aa,1
    blockpatch_cells $00,0
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 3/9
    blockpatch_cells $a7,1
    blockpatch_cells $a4,1
    blockpatch_cells $ab,1
    blockpatch_cells $00,0
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 4/9
    blockpatch_cells $a8,1
    blockpatch_cells $a4,1
    blockpatch_cells $ac,1
    blockpatch_cells $00,0
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 5/9
    blockpatch_cells $ad,1
    blockpatch_cells $a5,1
    blockpatch_cells $a9,1
    blockpatch_cells $00,0
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 6/9
    blockpatch_cells $ad,1
    blockpatch_cells $a6,1
    blockpatch_cells $a4,1
    blockpatch_cells $aa,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 7/9
    blockpatch_cells $ad,1
    blockpatch_cells $a7,1
    blockpatch_cells $a4,1
    blockpatch_cells $ab,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                      ; step 8/9
    blockpatch_cells $ad,1
    blockpatch_cells $a8,1
    blockpatch_cells $a4,1
    blockpatch_cells $ac,1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES           ; step 9/9
    blockpatch_cells $ad,1
    blockpatch_cells $ad,1
    blockpatch_cells $a5,1
    blockpatch_cells $a9,1

; ------------------------------------------------------------------
; $3d   no weddings and a funeral, mission 1
; ------------------------------------------------------------------
.script_3D:
    cutscene_script $0860, $0c10, .script_3D_move, 0

.script_3D_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0040
    cutscene_move PADF_DOWN | PADF_RIGHT, $0040
    cutscene_move PADF_RIGHT,            $0280
    cutscene_move PADF_UP | PADF_RIGHT,  $0060
    cutscene_move_end

; ------------------------------------------------------------------
; $3e   lava dabba doo, mission 1
; ------------------------------------------------------------------
.script_3E:
    cutscene_script $0b50, $06f0, .script_3E_move, 0

.script_3E_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_RIGHT,            $0150
    cutscene_move_end

; ------------------------------------------------------------------
; $3f   texas chainsaw manicure, mission 1
; ------------------------------------------------------------------
.script_3F:
    cutscene_script $03c0, $0390, .script_3F_move, 0

.script_3F_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0080
    cutscene_move PADF_RIGHT,            $0160
    cutscene_move PADF_UP,               $0060
    cutscene_move_end

; ------------------------------------------------------------------
; $40   texas chainsaw manicure, slot 0
; ------------------------------------------------------------------
.script_40:
    cutscene_script $0a00, $0100, 0, 0
    ; no movement and no animation - reposition, hold, return

; ------------------------------------------------------------------
; $41   mazed and confused, mission 1
; ------------------------------------------------------------------
.script_41:
    cutscene_script $03c0, $05b0, .script_41_move, 0

.script_41_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_UP,               $0060
    cutscene_move PADF_RIGHT,            $00e0
    cutscene_move PADF_UP,               $0240
    cutscene_move_end

; ------------------------------------------------------------------
; $42   mazed and confused, mission 2
; ------------------------------------------------------------------
.script_42:
    cutscene_script $08b0, $06d0, .script_42_move, 0

.script_42_move:
    cutscene_move 0,                     $0080   ; stand still
    cutscene_move PADF_LEFT,             $02f0
    cutscene_move_end

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
    ld   A, [wD75A_Player_EffectiveInputs]                                    ;; 00:2dbf $fa $5a $d7
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
    ld   HL, wD75A_Player_EffectiveInputs                                     ;; 00:2deb $21 $5a $d7
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
