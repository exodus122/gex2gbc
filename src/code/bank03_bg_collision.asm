; ==================================================================
; BACKGROUND COLLISION
;
; Gex against the level geometry - walls, floors, ceilings, slopes and climbable
; surfaces. Runs once per frame from bank02_update_player.asm, after the player's
; intended movement is known and before it is applied, so what this file produces is
; a set of corrections rather than a position.
;
; THREE LAYERS OF LOOKUP
;
; Nothing here reads the blockmap. It reads wC800_CurrentCollisionData, a
; COLLISION_MAP_COLS x COLLISION_MAP_ROWS grid of tile type ids that bank 3 keeps in
; step with the visible tilemap - so a lookup is (Y & $F8) and (X >> 3) into a
; 1KB buffer, no matter where in the level Gex is. The buffer wraps as it scrolls,
; which is what every `res 2, H` in this file is doing: keeping H inside $C8-$CB.
;
; A tile type id is then resolved two different ways, and the difference matters:
;
;   data_03_4000_TileSolidityRows     eight pages, one per pixel row within a tile,
;                                     each a byte per tile type giving a bitmask of
;                                     which of the 8 pixel columns are solid on that
;                                     row. This is what makes slopes work: a slope
;                                     tile is solid in a different set of columns on
;                                     each of its 8 rows.
;   data_03_4800_TileCollisionFlags   one byte per tile type. Whole-tile properties
;                                     - is it solid at all, is it a ceiling, can it
;                                     be climbed. Cheap, and what most checks use.
;
; So the floor scan walks DOWN pixel rows through this second table until it finds a
; row where Gex's column is solid, and the distance it walked is how far he still has
; to fall. That is the whole of the slope handling.
;
; Both tables are one INCBIN in the ROM; the split below is where the code indexes
; each half, not two files
; ==================================================================

data_03_4000_TileSolidityRows:
; 8 pages of 256 bytes: page (Y & 7) gives, per tile type, a bitmask of the solid
; pixel columns on that row of the tile. Indexed as
; [HIGH(data_03_4000_TileSolidityRows) + pixel row][tile type]
    INCBIN "data/maps/data_03_4000_TileSolidityRows.bin"

data_03_4800_TileCollisionFlags:
; One TILECOLL_* flags byte per tile type
    INCBIN "data/maps/data_03_4800_TileCollisionFlags.bin"

call_03_4900_BgCollision_Update:
; Entry point, called once a frame from bank02_update_player.asm. Rolls this frame's
; collision flags into wD584_CollisionFlagsPrev and starts a fresh set, then either
; suppresses collision entirely (riding the rocket - the only action that moves Gex
; through geometry) or falls through into the walking handler
    ld   HL, wD585_CollisionFlags
    ld   A, [HL]
    ld   [HL], $00
    ld   [wD584_CollisionFlagsPrev], A
    ld   A, [wD201_Player_ActionId]
    and  A, PLAYER_ACTION_MASK
    cp   A, PLAYER_ACTION_RIDING_ROCKET
    jr   NZ, call_03_4915_BgCollision_SidescrollerHandler
    set  BGCOLL_NO_COLLISION_BIT, [HL]
    ret

call_03_4915_BgCollision_SidescrollerHandler:
; Collision for everything except climbing - walking, running, jumping, falling.
;
; Two early outs first. Standing on an entity (wD74D_Player_EntityStoodOnLo nonzero -
; a moving platform) suppresses background collision, because the platform is already
; holding him up. And a climbing state other than CLIMB_STATE_NOT_CLIMBING diverts to
; call_03_4ac4_BgCollision_ClimbingHandler, which is a completely separate routine.
;
; Then three passes, in order:
;
;   1. WALL. Only if Gex is actually moving horizontally - a zero predicted delta
;      skips straight to the floor check. Probes BGCOLL_WALL_PROBE_ROWS tile rows at
;      his leading edge, ORs their flags together, and a TILECOLL_SOLID bit anywhere
;      in that column means a wall: cancel the karate kick, drop the accumulated X
;      movement, and raise BGCOLL_WALL_BIT.
;   2. SLOPE. Walks tile by tile along the path he is about to take and counts how
;      many of those pixels are solid. That count goes into the low nibble of the
;      flags, and bank 2 reads it as "step up this many pixels" - which is how walking
;      up a slope works without any slope-specific code.
;   3. FLOOR and CEILING, below.
;
; The vertical lookahead is computed once up front: Y velocity minus 2, clamped so a
; fast fall does not probe absurdly far, then >> 4. Wall probing starts that far above
; his head so that a wall is caught on the frame he would enter it rather than after
    ld   A, [wD74D_Player_EntityStoodOnLo]
    and  A, A
    jr   Z, .jr_03_491d_CheckClimbing
    set  BGCOLL_NO_COLLISION_BIT, [HL]                 ; a platform is holding him up
.jr_03_491d_CheckClimbing:
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_NOT_CLIMBING
    jp   NZ, call_03_4ac4_BgCollision_ClimbingHandler        ; 03:4922 $c2 $c4 $4a ; if climb state byte is not ff, run alternate collision func
    ld   A, [wD760_PlayerYVelocity]
    sub  A, $02
    bit  7, A
    jr   Z, .jr_03_4934_ScaleLookahead
    cp   A, $c0
    jr   NC, .jr_03_4934_ScaleLookahead
    ld   A, $c0
.jr_03_4934_ScaleLookahead:
    sra  A
    sra  A
    sra  A
    sra  A
    ld   [wD75F_BgCollision_WallProbeLookahead], A
    call call_03_4ab3_BgCollision_GetPredictedXDelta
    jp   Z, .jp_03_4a05_FloorCeilingCheck
    ld   E, A
    bit  7, E
    jr   Z, .jr_03_4954_MovingRight
    ld   A, [wD20E_Player_XPositionLo]
    and  A, $07
    add  A, E
    ld   C, $ff
    jr   .jr_03_495c_ProbeWall
.jr_03_4954_MovingRight:
    ld   A, [wD20E_Player_XPositionLo]
    and  A, $07
    add  A, E
    ld   C, $01
.jr_03_495c_ProbeWall:
    push DE
    ld   A, E
    ld   HL, wD20E_Player_XPositionLo
    add  A, [HL]
    add  A, C
    ld   C, A
    ld   A, [wD210_Player_YPositionLo]
    sub  A, $10
    ld   HL, wD75F_BgCollision_WallProbeLookahead
    sub  A, [HL]
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, C
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   D, HIGH(data_03_4800_TileCollisionFlags)
    ld   C, $00                                        ; OR of every row's flags
    ld   B, BGCOLL_WALL_PROBE_ROWS
.jr_03_4982_WallRowLoop:
    ld   E, [HL]
    ld   A, [DE]
    or   A, C
    ld   C, A
    ld   A, L
    add  A, COLLISION_MAP_STRIDE                       ; next tile row down
    ld   L, A
    ld   A, H
    adc  A, $00
    res  2, A
    ld   H, A
    dec  B
    jr   NZ, .jr_03_4982_WallRowLoop
    pop  DE
    bit  TILECOLL_SOLID_BIT, C
    jr   Z, .jr_03_49bd_SlopeCheck
    ld   A, $01
    ld   [wD74C_Player_KarateKickTimer], A
    ld   HL, wD20E_Player_XPositionLo
    bit  7, E
    jr   NZ, .jr_03_49ab_FacingLeft
    ld   A, $07
    sub  A, [HL]
    and  A, $07
    jr   .jr_03_49b0_ClearPush
.jr_03_49ab_FacingLeft:
    ld   A, [HL]
    and  A, $07
    cpl
    inc  A
.jr_03_49b0_ClearPush:
    xor  A, A
    ld   [wD75C_PlayerXDeltaExtra], A
    xor  A, A
    ld   [wD75D_PlayerXSpeedPrev], A
    ld   HL, wD585_CollisionFlags
    set  BGCOLL_WALL_BIT, [HL]
.jr_03_49bd_SlopeCheck:
    ld   HL, wD585_CollisionFlags
    bit  BGCOLL_NO_COLLISION_BIT, [HL]
    jr   NZ, .jp_03_4a05_FloorCeilingCheck
    call call_03_4ab3_BgCollision_GetPredictedXDelta
    jr   Z, .jp_03_4a05_FloorCeilingCheck
    bit  7, A
    jr   NZ, .jr_03_49e2_ScanLeftSetup
    ld   B, $00
    ld   C, $01
.jr_03_49d1_ScanRight:
    push AF
    push BC
    call call_03_4bd4_BgCollision_IsPixelSolid
    pop  BC
    and  A, A
    jr   Z, .jr_03_49db_NextRight
    dec  B
.jr_03_49db_NextRight:
    inc  C
    pop  AF
    dec  A
    jr   NZ, .jr_03_49d1_ScanRight
    jr   .jr_03_49f5_StoreSlopeStep
.jr_03_49e2_ScanLeftSetup:
    ld   B, $00
    ld   C, $ff
.jr_03_49e6_ScanLeft:
    push AF
    push BC
    call call_03_4bd4_BgCollision_IsPixelSolid
    pop  BC
    and  A, A
    jr   Z, .jr_03_49f0_NextLeft
    dec  B
.jr_03_49f0_NextLeft:
    dec  C
    pop  AF
    inc  A
    jr   NZ, .jr_03_49e6_ScanLeft
.jr_03_49f5_StoreSlopeStep:
    ld   A, B
    cpl
    inc  A
    ld   HL, wD585_CollisionFlags
    or   A, [HL]
    ld   [HL], A
    and  A, BGCOLL_SLOPE_MASK
    jr   Z, .jp_03_4a05_FloorCeilingCheck
    set  BGCOLL_NO_COLLISION_BIT, [HL]                 ; on a slope counts as grounded
    jr   .jp_03_4a05_FloorCeilingCheck
.jp_03_4a05_FloorCeilingCheck:
; Which of the two runs depends on the sign of the Y velocity, and only one ever does.
;
; FLOOR (velocity zero or upward): take the tile under his feet and the one below it,
; then scan down through data_03_4000_TileSolidityRows a pixel row at a time - within
; the feet tile first, then continuing into the tile below - until his pixel column
; comes up solid. The number of rows walked is the gap to the floor, and it goes into
; wD761_Player_FloorSnapVelocity negated and scaled, for bank 2 to close.
; Finding solid ground also raises BGCOLL_NO_COLLISION_BIT, which downstream means
; grounded. Giving up after BGCOLL_FLOOR_SEARCH_ROWS leaves him airborne.
;
; CEILING (falling): one probe above his head, at a distance that grows with the fall
; speed. A TILECOLL_CEILING tile there zeroes the Y velocity - the head bonk
    xor  A, A
    ld   [wD761_Player_FloorSnapVelocity], A
    ld   HL, wD585_CollisionFlags
    bit  BGCOLL_NO_COLLISION_BIT, [HL]
    ret  NZ
    ld   A, [wD760_PlayerYVelocity]
    and  A, A
    jr   Z, .jr_03_4a19_FloorCheck
    bit  7, A
    jr   Z, .jr_03_4a7c_CeilingCheck
.jr_03_4a19_FloorCheck:
    ld   B, $00
    call call_03_4ab3_BgCollision_GetPredictedXDelta
    ld   C, A
    ld   A, [wD210_Player_YPositionLo]
    add  A, PLAYER_FEET_OFFSET
    add  A, B
    ld   B, A
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    ld   C, A
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   A, [HL]                                       ; load tile collision type from wC800_CurrentCollisionData
    ld   DE, COLLISION_MAP_STRIDE                      ; D = the tile below, for the scan to continue into
    add  HL, DE
    res  2, H
    ld   E, A
    ld   D, [HL]
    ld   A, C
    and  A, $07
    add  A, LOW(.data_03_4aab_PixelColumnMasks)
    ld   L, A
    ld   A, $00
    adc  A, HIGH(.data_03_4aab_PixelColumnMasks)
    ld   H, A
    ld   C, [HL]
    ld   A, B
    and  A, $07
    add  A, HIGH(data_03_4000_TileSolidityRows)
    ld   H, A
    ld   L, E
    ld   B, $00
.jr_03_4a57_ScanDownForFloor:
    ld   A, [HL]
    and  A, C
    jr   NZ, .jr_03_4a6e_FloorFound
    inc  H
    ld   A, H
    cp   A, HIGH(data_03_4800_TileCollisionFlags)      ; past pixel row 7?
    jr   NZ, .jr_03_4a64_NextFloorRow
    ld   H, HIGH(data_03_4000_TileSolidityRows)        ; wrap into row 0 of the tile below
    ld   L, D
.jr_03_4a64_NextFloorRow:
    inc  B
    ld   A, B
    cp   A, BGCOLL_FLOOR_SEARCH_ROWS
    jr   NZ, .jr_03_4a57_ScanDownForFloor
    ld   A, BGCOLL_FLOOR_SEARCH_ROWS - 1               ; no floor found - still falling
    jr   .jr_03_4a74_StoreFloorDistance
.jr_03_4a6e_FloorFound:
    ld   HL, wD585_CollisionFlags
    set  BGCOLL_NO_COLLISION_BIT, [HL]                 ; grounded
    ld   A, B
.jr_03_4a74_StoreFloorDistance:
    swap A
    cpl
    inc  A
    ld   [wD761_Player_FloorSnapVelocity], A
    ret
.jr_03_4a7c_CeilingCheck:
    call call_03_4ab3_BgCollision_GetPredictedXDelta
    ld   C, A
    ld   A, [wD760_PlayerYVelocity]
    swap A
    and  A, $0f
    add  A, PLAYER_FEET_OFFSET + 1
    ld   B, A
    ld   A, [wD210_Player_YPositionLo]
    sub  A, B
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   L, [HL]
    ld   H, HIGH(data_03_4800_TileCollisionFlags)
    bit  TILECOLL_CEILING_BIT, [HL]
    ret  Z
    xor  A, A
    ld   [wD760_PlayerYVelocity], A
    ret
.data_03_4aab_PixelColumnMasks:
; Pixel column X within a tile -> its bit in a solidity row byte, so column 0 is the
; high bit. Byte for byte the same table as .data_03_4c02_TileCollision_BitMasks
; further down; the two routines each carry their own copy rather than sharing one
    db   $80, $40, $20, $10, $08, $04, $02, $01

call_03_4ab3_BgCollision_GetPredictedXDelta:
; A = how far Gex is about to move horizontally this frame, signed: his own walking
; speed with the sign of his facing, plus whatever a platform or walkway is adding.
;
; Every probe in this file is aimed with this, which is why collision is checked
; against where he is going rather than where he is. A zero result also sets Z, and
; the callers use that to skip the wall and slope passes entirely - not moving
; sideways means there is nothing to hit
    ld   A, [wD75D_PlayerXSpeedPrev]
    ld   HL, wD20D_Player_FacingFlags
    bit  FACING_LEFT_BIT, [HL]
    jr   Z, .jr_03_4abf_AddCarry                                ; jump if not facing left
    cpl
    inc  A
.jr_03_4abf_AddCarry:
    ld   HL, wD75C_PlayerXDeltaExtra
    add  A, [HL]
    ret

call_03_4ac4_BgCollision_ClimbingHandler:
; Collision while Gex is on a ladder, pole or climbable wall. Nothing here corrects a
; position - climbing moves him directly in bank 2 - so this only ever answers "may he
; go that way", and it starts by raising BGCOLL_NO_COLLISION_BIT to switch the normal
; walking corrections off for the frame.
;
; Only the states below CLIMB_STATE_BACKGROUND_BOTTOM are handled; the dismount and
; stop states run to completion on their own. The state and facing pick a climb script
; out of .data_03_4b66_ClimbCollisionScriptTable, and that script is matched against
; the d-pad. An input the script has no entry for is not merely ignored - the d-pad
; bits are stripped out of wD75A_Player_EffectiveInputs so the movement code cannot act on
; them either. That is what stops Gex sliding off the side of a ladder.
;
; A matched entry carries two probes, and they answer different questions:
;
;   FAR probe, roughly a tile away - the square he would move into.
;     TILECOLL_CLIMB_BLOCKED means he cannot, and if he was pressing DOWN at the time
;     he lets go instead, dropping into CLIMB_STATE_BACKGROUND_BOTTOM or
;     CLIMB_STATE_WALL_BOTTOM.
;   NEAR probe, one pixel away - the surface he is holding onto. Losing
;     TILECOLL_CLIMB_BACKING while pressing UP means he has reached the top and pulls
;     himself over into CLIMB_STATE_WALL_TOP. Keeping it, but on a tile in the
;     TILE_TYPE_CLIMB_STOP_ENTRY_* range, is a stopper: the tile id doubles as the
;     direction, and he transitions into CLIMB_STATE_STOP
;
; THERE ARE THREE WAYS OUT, and only one of them touches the input:
;
;   pressed nothing the script handles   returns at once, input untouched. The
;                                        movement code in bank 2 then acts on that
;                                        press with no collision check behind it
;   handled input, no matching entry     .jr_03_4afa_SuppressDpad strips every d-pad
;   or a probe says no                   bit, leaving only A/B/Select/Start
;   handled input, entry matched, clear  returns having changed nothing; bank 2 moves
;
; The middle case is why a diagonal is either a first-class direction or nothing at
; all. The background script spells out all eight combinations, but the match is an
; exact `cp`, so pressing three directions at once matches no entry and freezes the
; d-pad for the frame.
;
; THE ALT WALL STATES DISAGREE WITH BANK 2 ABOUT WHICH AXIS THEY USE.
; .data_03_4bc6_ClimbScript_AltWall handles left and right, while
; .data_02_44e5 sends CLIMB_STATE_ALT_WALL to the same handler as CLIMB_STATE_WALL,
; whose call_02_47d5_PlayerWallClimb_GetDirection masks the pad down to up and down.
; So in those two states each axis is served by exactly one half of the system: up and
; down move Gex but take the first exit above and are never collision-checked, while
; left and right are checked here and then ignored by the movement code
    ld   HL, wD585_CollisionFlags
    set  7, [HL]
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_BACKGROUND_BOTTOM              ; $06 and up run themselves
    ret  NC
    ld   HL, wD746_Player_ClimbingState
    ld   A, [HL]
    add  A, A
    ld   HL, wD20D_Player_FacingFlags
    bit  FACING_LEFT_BIT, [HL]
    jr   Z, .jr_03_4adc_LookUpScript
    inc  A
.jr_03_4adc_LookUpScript:
    ld   L, A
    ld   H, $00
    add  HL, HL
    ld   DE, .data_03_4b66_ClimbCollisionScriptTable
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, [HL]
    ret  Z
    inc  HL
    ld   B, [HL]
    inc  HL
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
.jr_03_4af3_MatchInput:
    cp   A, [HL]
    jr   Z, .jr_03_4b03_EntryMatched
    add  HL, DE
    dec  B
    jr   NZ, .jr_03_4af3_MatchInput
.jr_03_4afa_SuppressDpad:
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_A | PADF_B | PADF_SELECT | PADF_START
    ld   [wD75A_Player_EffectiveInputs], A
    ret
.jr_03_4b03_EntryMatched:
    inc  HL
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   B, A
    push HL
    call call_03_4c5a_BgCollision_GetTileAndFlags
    pop  HL
    bit  TILECOLL_CLIMB_BLOCKED_BIT, B
    jr   Z, .jr_03_4b2b_CheckNearProbe
    ld   A, [wD75A_Player_EffectiveInputs]
    cp   A, PADF_DOWN
    jr   NZ, .jr_03_4afa_SuppressDpad
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_WALL
    ld   A, CLIMB_STATE_BACKGROUND_BOTTOM
    jr   C, .jr_03_4b23_StoreDismount
    ld   A, CLIMB_STATE_WALL_BOTTOM
.jr_03_4b23_StoreDismount:
    ld   [wD746_Player_ClimbingState], A
    xor  A, A
    ld   [wD747_Player_ClimbAnimCounter], A
    ret
.jr_03_4b2b_CheckNearProbe:
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   B, A
    call call_03_4c5a_BgCollision_GetTileAndFlags
    bit  TILECOLL_CLIMB_BACKING_BIT, B
    jr   NZ, .jr_03_4b4a_MaybeStop
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_WALL
    jr   C, .jr_03_4afa_SuppressDpad
    ld   A, [wD75A_Player_EffectiveInputs]
    and  A, PADF_UP
    jr   Z, .jr_03_4afa_SuppressDpad
    ld   A, CLIMB_STATE_WALL_TOP
    ld   [wD746_Player_ClimbingState], A
    ret
.jr_03_4b4a_MaybeStop:
    ld   A, [wD746_Player_ClimbingState]
    cp   A, CLIMB_STATE_WALL
    ret  C
    ld   A, C
    cp   A, TILE_TYPE_CLIMB_STOP_ENTRY_FIRST
    ret  C
    cp   A, TILE_TYPE_CLIMB_STOP_ENTRY_LAST + 1
    ret  NC
    sub  A, TILE_TYPE_CLIMB_STOP_ENTRY_FIRST                 ; id doubles as the direction
    ld   [wD749_Player_ClimbingDirection], A
    ld   A, CLIMB_STATE_STOP
    ld   [wD746_Player_ClimbingState], A
    xor  A, A
    ld   [wD747_Player_ClimbAnimCounter], A
    ret
.data_03_4b66_ClimbCollisionScriptTable:
; Indexed by climb state * 2 + facing, so twelve words covering CLIMB_STATE_BACKGROUND
; through CLIMB_STATE_ALT_WALL_TAIL_SPIN. A state and its tail-spin variant always
; share a script - spinning does not change what he is allowed to climb into.
;
; Only the wall states distinguish facing, because the wall is on one side of him;
; background climbing works the same either way and points both entries at one script
    dw   .data_03_4b7e_ClimbScript_Background          ; CLIMB_STATE_BACKGROUND, facing right
    dw   .data_03_4b7e_ClimbScript_Background          ;                         facing left
    dw   .data_03_4b7e_ClimbScript_Background          ; CLIMB_STATE_BACKGROUND_TAIL_SPIN, right
    dw   .data_03_4b7e_ClimbScript_Background          ;                                   left
    dw   .data_03_4baa_ClimbScript_WallFacingRight     ; CLIMB_STATE_WALL, facing right
    dw   .data_03_4bb8_ClimbScript_WallFacingLeft      ;                   facing left
    dw   .data_03_4baa_ClimbScript_WallFacingRight     ; CLIMB_STATE_WALL_TAIL_SPIN, right
    dw   .data_03_4bb8_ClimbScript_WallFacingLeft      ;                             left
    dw   .data_03_4bc6_ClimbScript_AltWall             ; CLIMB_STATE_ALT_WALL, facing right
    dw   .data_03_4bc6_ClimbScript_AltWall             ;                       facing left
    dw   .data_03_4bc6_ClimbScript_AltWall             ; CLIMB_STATE_ALT_WALL_TAIL_SPIN, right
    dw   .data_03_4bc6_ClimbScript_AltWall             ;                                 left
; THE SCRIPTS. A header naming the d-pad bits the script answers for and how many
; entries follow, then the entries themselves - see the climb_script and
; climb_script_entry macros. Probe offsets are signed pixels from Gex's position.
;
; The far probes are a tile away on the axis of travel and the near probes a single
; pixel, which is the whole difference between them: the far one asks what he is
; climbing into and the near one asks what he is still holding on to. Reading down the
; four scripts, the near probe is also what identifies the surface - it stays on the
; axis of travel for a background climb, sits nine pixels to one side on a wall, and
; nine pixels up for the ALT states
.data_03_4b7e_ClimbScript_Background:
; Climbing a background surface. Responds to all four directions including the
; diagonals, which is why this one has eight entries where the wall scripts have two
    climb_script PADF_DOWN | PADF_UP | PADF_LEFT | PADF_RIGHT, 8
    climb_script_entry PADF_UP,                   0,  -17,    0,   -1
    climb_script_entry PADF_DOWN,                 0,   16,    0,    1
    climb_script_entry PADF_LEFT,                -9,    0,   -1,    0
    climb_script_entry PADF_RIGHT,                9,    0,    1,    0
    climb_script_entry PADF_UP | PADF_LEFT,      -9,  -17,   -1,   -1
    climb_script_entry PADF_DOWN | PADF_LEFT,    -9,   16,   -1,    1
    climb_script_entry PADF_UP | PADF_RIGHT,      9,  -17,    1,   -1
    climb_script_entry PADF_DOWN | PADF_RIGHT,    9,   16,    1,    1
.data_03_4baa_ClimbScript_WallFacingRight:
; On a wall to his right: up and down only. The near probe sits +9 to the right, on
; the wall he is holding
    climb_script PADF_DOWN | PADF_UP, 2
    climb_script_entry PADF_UP,                   0,  -17,    9,   -1
    climb_script_entry PADF_DOWN,                 0,   16,    9,    1
.data_03_4bb8_ClimbScript_WallFacingLeft:
; Mirror of the above - the near probe is -9, on the wall to his left
    climb_script PADF_DOWN | PADF_UP, 2
    climb_script_entry PADF_UP,                   0,  -17,   -9,   -1
    climb_script_entry PADF_DOWN,                 0,   16,   -9,    1
.data_03_4bc6_ClimbScript_AltWall:
; The ALT wall states, which move sideways instead: left and right only, both probes
; nine pixels up
    climb_script PADF_LEFT | PADF_RIGHT, 2
    climb_script_entry PADF_LEFT,                -9,   -9,   -1,   -9
    climb_script_entry PADF_RIGHT,                9,   -9,    1,   -9

call_03_4bd4_BgCollision_IsPixelSolid:
; Is one single pixel solid? B and C are Y and X offsets from the player; A comes back
; nonzero if that pixel is inside geometry.
;
; The pixel, not the tile - it looks the tile type up in wC800_CurrentCollisionData,
; then takes the solidity row for (Y & 7) and tests the one bit for (X & 7). That
; per-pixel resolution is what lets the slope scan in the walking handler count an
; exact rise rather than snapping to whole tiles
    ld   A, [wD210_Player_YPositionLo]
    add  A, PLAYER_FEET_OFFSET - 1
    add  A, B
    ld   B, A
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    ld   C, A
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   E, [HL]
    ld   A, B
    and  A, $07
    add  A, HIGH(data_03_4000_TileSolidityRows)
    ld   D, A
    ld   A, C
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   BC, .data_03_4c02_TileCollision_BitMasks
    add  HL, BC
    ld   A, [DE]
    and  A, [HL]
    ret
.data_03_4c02_TileCollision_BitMasks:
; Pixel column X within a tile -> its bit in a solidity row byte. The second copy of
; this table in the file; .data_03_4aab_PixelColumnMasks up in the floor scan is
; identical
    db   $80, $40, $20, $10, $08, $04, $02, $01

call_03_4c0a_BgCollision_CacheNearbyTileTypes:
; Caches the four tile types around Gex so the player code in bank 2 can react to them
; without repeating the lookup - water, lava, doors, springs, climbable surfaces are
; all decided from these four bytes. Called once a frame, straight after
; call_03_4900_BgCollision_Update.
;
;   wD764  at his own row          upper body
;   wD765  one tile row down       lower body
;   wD767  two tile rows down      the floor he is standing on
;   wD766  one row up, one tile ahead in the direction he faces - what he is looking at
;
; The first three are a straight column, so they walk by COLLISION_MAP_STRIDE with the
; usual wrap. Only the fourth depends on facing
    ld   A, [wD210_Player_YPositionLo]
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, [wD20E_Player_XPositionLo]
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   A, [HL]
    ld   [wD764_TileTypeBehindGexsUpperBody], A
    ld   DE, COLLISION_MAP_STRIDE
    add  HL, DE
    res  2, H
    ld   A, [HL]
    ld   [wD765_TileTypeBehindGexsLowerBody], A
    add  HL, DE
    res  2, H
    ld   A, [HL]                                       ; load tile collision type from wC800_CurrentCollisionData
    ld   [wD767_FloorTileType], A
    ld   C, $09                                        ; one tile to the right
    ld   A, [wD20D_Player_FacingFlags]
    cp   A, FACING_RIGHT
    jr   Z, .jr_03_4c3e_SampleFace
    ld   C, $f7                                        ; ...or to the left
.jr_03_4c3e_SampleFace:
    ld   A, [wD210_Player_YPositionLo]
    sub  A, $08
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   A, [HL]
    ld   [wD766_TileTypeBehindGexsFace], A
    ret

call_03_4c5a_BgCollision_GetTileAndFlags:
; Looks up one whole tile at B, C offsets from the player and returns BOTH halves:
;   B = its TILECOLL_* flags byte
;   C = the tile type id itself
;
; Callers use one or the other or both - the climb handler tests the flags for
; TILECOLL_CLIMB_BLOCKED and then reads C to recognise a climbing stopper by its id. Unlike
; call_03_4bd4_BgCollision_IsPixelSolid this is whole-tile, with no per-pixel detail
    ld   A, [wD210_Player_YPositionLo]
    add  A, B
    and  A, $f8
    ld   L, A
    ld   H, HIGH(wC800_CurrentCollisionData) >> 2
    add  HL, HL
    add  HL, HL
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    rrca
    rrca
    rrca
    and  A, COLLISION_MAP_COLS - 1
    or   A, L
    ld   L, A
    ld   C, [HL]
    ld   B, $48
    ld   A, [BC]
    ld   B, A
    ret
