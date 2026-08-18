call_00_30af_Entity_ApplyGravityAndMoveY_Clamped:
; Applies gravity (subtracts 2 from Y velocity, clamps to $C0 minimum), negates velocity,
; right-shifts 4x to get pixel delta, then jumps to move Y position
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    ld   A, [HL]
    sub  A, $02
    bit  7, A
    jr   Z, .jr_00_30c4
    cp   A, $c0
    jr   NC, .jr_00_30c4
    ld   A, $c0
.jr_00_30c4:
    ld   [HL], A
    cpl
    inc  A
    sra  A
    sra  A
    sra  A
    sra  A
    ld   C, A
    cp   A, $80
    ld   A, $ff
    adc  A, $00
    ld   B, A
    jp   call_00_37d8_Entity_MoveY

call_00_30da_Entity_ApplyGravityMoveY_WithFloorCollision:
; Same gravity and clamp as above, and it keeps the sign-extension - what it drops
; is the `cpl / inc A` NEGATION. That is not a cosmetic difference: for the same
; stored YVEL the two routines move the entity in OPPOSITE directions.
;
; Because of that, "gravity" here pulls UPWARDS. call_00_30af treats a positive
; YVEL as up and subtracting 2 as falling; this routine treats a positive YVEL as
; down, so subtracting 2 accelerates the entity towards the ceiling until it is
; clamped there. Its one caller, call_02_5ccf_EntityAction_Pterosaur_Update, is
; built around exactly that: hanging at the top of its span is the rest state and
; a positive velocity is a swoop DOWN.
;
; Applies the delta to YPOS inline, then calls Entity_GetMinYBound - the CEILING,
; not a floor - and, if YPOS has reached or passed it, snaps YPOS to the bound and
; zeroes YVEL:
;
;   carry SET    still below the bound, moving freely
;   carry CLEAR  clamped to the bound this frame
;
; The code after the `ret` below is a separate routine that used to run on from
; here unlabelled - now split out as call_00_3125_Entity_SetYFloorToCurrentPos,
; which is the setter for the clamp in call_00_3137 just past it
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    ld   a,[hl]
    sub  a,$02
    bit  7,a
    jr   z,.jr_00_30ef
    cp   a,$C0
    jr   nc,.jr_00_30ef
    ld   a,$C0
.jr_00_30ef:
    ld   [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$0E
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    call call_00_349c_Entity_GetMinYBound
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   a,e
    sub  [hl]
    inc  hl
    ld   a,d
    sbc  [hl]
    ret  c
    ld   [hl],d
    dec  l
    ld   [hl],e
    ld   a,l
    xor  a,$0E
    ld   l,a
    xor  a
    ld   [hl],a
    ret

call_00_3125_Entity_SetYFloorToCurrentPos:
; Records the entity's current Y as its floor, by copying the 16-bit YPOS into the
; ENTITY_FIELD_MISC_PARAM pair ($1A/$1B).
;
; This is the setter half of a pair: call_00_3137_Entity_ClampYToStoredFloor
; reads those same two bytes back and snaps YPOS to them whenever the entity has
; sunk past. So together they mean "remember where I am now, and never let me fall
; below it" - used by entities that need a floor at wherever they happened to
; spawn or land, rather than one from the bounding-box tables.
;
; The `xor $0A` reaches MISC_PARAM from YPOS ($10 xor $0A = $1A). In this use the
; $1A/$1B pair is a coordinate rather than a parameter byte, which is one of the
; several unrelated things ENTITY_FIELD_MISC_PARAM holds depending on entity type
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    xor  a,$0A
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    ret

call_00_3137_Entity_ClampYToStoredFloor:
; Enforces the floor recorded by call_00_3125_Entity_SetYFloorToCurrentPos: reads
; the 16-bit value back out of ENTITY_FIELD_MISC_PARAM / +1, and if the entity has
; sunk to or past it, snaps YPOS back and zeroes YVEL.
;
; Deliberately not one of the Entity_Get{Min,Max}{X,Y}Bound helpers - those derive
; a bound from the bounding-box tables, whereas this one uses a floor the entity
; captured for itself at runtime
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    xor  a,$0A
    ld   l,a
    ldi  a,[hl]
    sub  e
    ld   a,[hl]
    sbc  d
    ret  c
    ld   [hl],d
    dec  l
    ld   [hl],e
    ld   a,l
    xor  a,$0E
    ld   l,a
    xor  a
    ld   [hl],a
    ret

call_00_3154_Entity_ClampYToMaxYBound:
; Enforces the floor from the bounding-box tables. Calls Entity_GetMaxYBound, and
; if the entity has reached or passed it, snaps YPOS to the bound and zeroes YVEL.
;
; It does NOT move the entity down - the caller has already done that, normally
; with call_00_30af_Entity_ApplyGravityAndMoveY_Clamped on the line before. This
; is purely the landing check, which is why the carry flag on return is the
; interesting part:
;
;   carry SET    still above the floor - the entity is airborne this frame
;   carry CLEAR  it has just been snapped to the floor - the entity has landed
;
; Every hopping enemy in bank 2 is built out of "apply gravity, then `ret c` on
; this" (see call_02_5399_EntityAction_Pumpkin_Hop)
    call call_00_34ba_Entity_GetMaxYBound
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   A, [HL+]
    sub  A, E
    ld   A, [HL]
    sbc  A, D
    ret  C
    ld   [HL], D
    dec  L
    ld   [HL], E
    ld   A, L
    xor  A, $0e
    ld   L, A
    xor  A, A
    ld   [HL], A
    ret

call_00_316e_Entity_ClampYToMaxYBound_Offset:
; Same as above, including the carry-means-airborne convention, but adds the signed
; BC offset to the bound first - a floor a fixed distance above or below the one the
; bounding box declares
    push BC
    call call_00_34ba_Entity_GetMaxYBound
    pop  HL
    add  HL, DE
    ld   E, L
    ld   D, H
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   A, [HL+]
    sub  A, E
    ld   A, [HL]
    sbc  A, D
    ret  C
    ld   [HL], D
    dec  L
    ld   [HL], E
    ld   A, L
    xor  A, $0e
    ld   L, A
    xor  A, A
    ld   [HL], A
    ret

call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip:
; Patrol driver for moving platforms. MISC_FLAGS bit 1 picks the axis (clear = X,
; set = Y); bits 7 and 6 hold the current direction on those axes. Each leg calls
; the matching Entity_Get{Min,Max}{X,Y}Bound helper, and while inside the range it
; nudges a speed counter toward its cap; on reaching the bound it toggles the
; direction bit and falls into the shared flip path.
;
; The flip path zeroes four consecutive bytes at MISC_FLAGS xor $0b = $1C, which is
; XVEL, X_SUBPIXEL, YVEL and Y_SUBPIXEL - so a direction change wipes the velocity
; block outright rather than reversing it, and the entity has to accelerate from a
; standstill again.
;
; Bit 3 is a stop-at-the-ends option, and it works through bit 0: with bit 3 set,
; the routine refuses to move at all unless bit 0 is also set, and it CLEARS bit 0
; on the flip path. So the platform runs one leg, stops on arrival, and stays
; stopped until whatever owns it sets bit 0 again - see
; call_02_5b9d_EntityAction_ToonTVMovingBlock_PauseAtEnd.
;
; It also reads ENTITY_FIELD_ENTITY_ID and special-cases the value $17, which is
; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM: that one entity type skips the bit 3/0
; handling and goes straight to the velocity wipe, so it never stops at its ends
; whatever its flags say. The $17 is an entity id, not a field offset, despite
; sitting next to a lot of field arithmetic
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_3, [HL]
    jr   Z, .jr_00_319c
    bit  MISC_FLAGS_BIT_0, [HL]
    ret  Z
.jr_00_319c:
    bit  MISC_FLAGS_BIT_1, [HL]
    jr   NZ, .jr_00_3202
    bit  MISC_FLAGS_BIT_7, [HL]
    jr   NZ, .jr_00_31de
    call call_00_347e_Entity_GetMaxXBound
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   A, [HL+]
    sub  A, E
    ld   A, [HL]
    sbc  A, D
    jr   NC, .jr_00_31be
    ld   A, L
    xor  A, $14
    ld   L, A
    ld   A, [HL+]
    cp   A, [HL]
    ret  Z
    inc  [HL]
    ret
.jr_00_31be:
    ld   A, L
    xor  A, $18
    ld   L, A
    set  MISC_FLAGS_BIT_7, [HL]
.jp_00_31c4:
    push HL
    ld   A, L
    xor  A, $17
    ld   L, A
    ld   A, [HL]
    pop  HL
    cp   A, $17
    jr   Z, .jr_00_31d4
    bit  MISC_FLAGS_BIT_3, [HL]
    ret  Z
    res  MISC_FLAGS_BIT_0, [HL]
.jr_00_31d4:
    ld   A, L
    xor  A, $0b
    ld   L, A
    xor  A, A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL], A
    ret
.jr_00_31de:
    call call_00_3460_Entity_GetMinXBound
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   A, [HL+]
    sub  A, E
    ld   A, [HL]
    sbc  A, D
    jr   C, .jr_00_31fa
    ld   A, L
    xor  A, $14
    ld   L, A
    ld   A, [HL+]
    cpl
    inc  A
    cp   A, [HL]
    ret  Z
    dec  [HL]
    ret
.jr_00_31fa:
    ld   A, L
    xor  A, $18
    ld   L, A
    res  MISC_FLAGS_BIT_7, [HL]
    jr   .jp_00_31c4
.jr_00_3202:
    bit  MISC_FLAGS_BIT_6, [HL]
    jr   NZ, .jr_00_322a
    call call_00_34ba_Entity_GetMaxYBound
   LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   A, [HL+]
    sub  A, E
    ld   A, [HL]
    sbc  A, D
    jr   NC, .jr_00_3222
    ld   A, L
    xor  A, $0a
    ld   L, A
    ld   A, [HL+]
    inc  L
    inc  L
    cp   A, [HL]
    ret  Z
    inc  [HL]
    ret
.jr_00_3222:
    ld   A, L
    xor  A, $06
    ld   L, A
    set  MISC_FLAGS_BIT_6, [HL]
    jr   .jp_00_31c4
.jr_00_322a:
    call call_00_349c_Entity_GetMinYBound
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   A, [HL+]
    sub  A, E
    ld   A, [HL]
    sbc  A, D
    jr   C, .jr_00_3248
    ld   A, L
    xor  A, $0a
    ld   L, A
    ld   A, [HL+]
    cpl
    inc  A
    inc  L
    inc  L
    cp   A, [HL]
    ret  Z
    dec  [HL]
    ret
.jr_00_3248:
    ld   A, L
    xor  A, $06
    ld   L, A
    res  MISC_FLAGS_BIT_6, [HL]
    jp   .jp_00_31c4

call_00_3251_Entity_UpdateFacingMomentumAndMoveX:
; Nudges a momentum/facing sub-field toward a target based on facing direction bit 5,
; then adds fractional accumulator and moves X
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   c,[hl]
    xor  a,$16
    ld   l,a
    ldi  a,[hl]
    bit  5,c
    jr   z,.jr_02_326A
    cpl
    inc  a
    cp   [hl]
    jr   z,.jr_02_326E
    dec  [hl]
    jr   .jr_02_326E
.jr_02_326A:
    cp   [hl]
    jr   z,.jr_02_326E
    inc  [hl]
.jr_02_326E:
    ldi  a,[hl]
    ld   c,a
    ld   a,[hl]
    and  a,$0F
    add  c
    ld   [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$13
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    ret

call_00_3290_Entity_SetFacingDirection:
; Writes C into the facing direction field
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],c
    ret

call_00_329a_Entity_UpdateFacingMomentumMoveX_WithWallFlip:
; Similar momentum update as call_00_3251; additionally checks if entity has exceeded horizontal bounds
; and flips facing direction (bit 5 of flags)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   c,[hl]
    ld   a,l
    xor  a,$11
    ld   l,a
    ldi  a,[hl]
    bit  5,c
    jr   z,.jr_02_32AE
    cpl
    inc  a
.jr_02_32AE:
    add  [hl]
    ld   c,a
    and  a,$0F
    ld   [hl],a
    ld   a,c
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    push bc
    ld   a,l
    xor  a,$06
    ld   l,a
    ld   a,c
    add  [hl]
    ldd  [hl],a
    bit  7,a
    jr   z,.jr_02_32D2
    cpl
    inc  a
.jr_02_32D2:
    cp   [hl]
    jr   c,.jr_02_32DD
    ld   a,l
    xor  a,$17
    ld   l,a
    ld   a,[hl]
    xor  a,$20
    ld   [hl],a
.jr_02_32DD:
    pop  bc
    jp   call_00_37c9_Entity_MoveX

call_00_32e1_Entity_NudgeXVelocityTowardC:
; Increments or decrements X velocity by 1 step toward target value in C (simple approach)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   A, [HL]
    cp   A, C
    ret  Z
    jr   C, .jr_00_32f0
    dec  [HL]
    ret
.jr_00_32f0:
    inc  [HL]
    ret

call_00_32f2_Entity_NudgeXVelocityTowardC_Signed:
; Same nudge logic as above but sign-aware — handles negative C correctly by checking sign
; bits before deciding direction
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    bit  7,c
    jr   nz,.jr_02_3309
    bit  7,[hl]
    jr   nz,.jr_02_3314
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3314
    jr   .jr_02_3312
.jr_02_3309:
    bit  7,[hl]
    jr   z,.jr_02_3312
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3314
.jr_02_3312:
    dec  [hl]
    ret
.jr_02_3314:
    inc  [hl]
    ret

call_00_3316_Entity_NudgeYVelocityTowardC_Signed:
; Identical signed nudge logic as above, applied to Y velocity
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    bit  7,c
    jr   nz,.jr_02_332D
    bit  7,[hl]
    jr   nz,.jr_02_3338
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3338
    jr   .jr_02_3336
.jr_02_332D:
    bit  7,[hl]
    jr   z,.jr_02_3336
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3338
.jr_02_3336:
    dec  [hl]
    ret
.jr_02_3338:
    inc  [hl]
    ret

call_00_333a_Entity_CheckIfXVelocityIsZero:
; Loads X velocity into A and ANDs with itself; sets Z if zero
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   a,[hl]
    and  a
    ret

call_00_3345_Entity_CheckIfYVelocityIsZero:
; Loads Y velocity into A and ANDs with itself; sets Z flag if zero
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    ld   a,[hl]
    and  a
    ret

call_00_3350_Entity_SetXVelocity:
; Sets X velocity field to C
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   [hl],c
    ret

call_00_335a_Entity_SetYVelocity:
; Sets Y velocity field to C
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_Y_VELOCITY
    ld   [HL], C
    ret

call_00_3364_Entity_ApproachPlayerXWithBounds:
; Compares entity X (block-scaled) against bounding box from wD309_EntityBoundingBoxXMax; if player is within range,
; sets facing direction toward player and applies movement delta to X pos
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   de,wD309_EntityBoundingBoxXMax
    add  hl,de
    ld   b,[hl]
    dec  b
    inc  hl
    ld   c,[hl]
    inc  c
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   e,h
    ld   hl,wD76A_Player_BlockX
    ld   a,[hl]
    cp   c
    jr   c,.jr_02_33A5
    ld   a,b
    cp   [hl]
    jr   c,.jr_02_33A5
    ld   a,e
    cp   [hl]
    jr   z,.jr_02_33A5
    ld   d,$00
    jr   c,.jr_02_339C
    ld   d,$20
.jr_02_339C:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],d
.jr_02_33A5:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    bit  5,[hl]
    jr   z,.jr_02_33C7
    ld   a,e
    cp   c
    jr   c,.jr_02_33CB
.jr_02_33B5:
    ld   [hl],$20
    ld   a,l
    xor  a,$11
    ld   l,a
    ld   c,[hl]
    xor  a,$12
    ld   l,a
    ld   a,[hl]
    sub  c
    ldi  [hl],a
    ld   a,[hl]
    sbc  a,$00
    ld   [hl],a
    ret
.jr_02_33C7:
    ld   a,e
    cp   b
    jr   nc,.jr_02_33B5
.jr_02_33CB:
    ld   [hl],$00
    ld   a,l
    xor  a,$11
    ld   l,a
    ld   c,[hl]
    xor  a,$12
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  a,$00
    ld   [hl],a
    ret

call_00_33dd_Entity_ApplyXVelocityFriction:
; First checks SPRITE_FLAG_ON_SCREEN — if clear, returns immediately (offscreen entities are not simulated).
; Then branches on a bit of ENTITY_FIELD_MISC_FLAGS ($17) to decide add or subtract. NOT field $1D:
; the `xor $1D` is applied to L while it still holds SPRITE_FLAGS ($0A), and $0A xor $1D = $17. The
; bit is also spelled with a SPRITE_FLAG_* constant, which is the wrong family for a MISC_FLAGS read
; even though the number happens to work:
; Bit 1 clear (.jr_02_33F2): Adds X velocity (C) into a subpixel accumulator. Includes a clamping check
;   — if the accumulator would overflow past $80 (i.e. exceed half-range), it saturates and folds the
;   remainder back through C before applying. Then adds the adjusted C into the X position subpixel field
;   and propagates carry into the high byte.
; Bit 1 set (.jr_02_341B): Same logic but subtracts — if the accumulator would go below $80 it saturates similarly.
;   Subtracts from the X position subpixel field with borrow propagation.
; In both cases it's applying velocity-scaled positional drag with half-precision saturation clamping to
; avoid wrap-around artifacts — essentially a friction/momentum integrator that bleeds off X velocity
; into position while preventing the accumulator from flipping sign unexpectedly.
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    bit  SPRITE_FLAG_ON_SCREEN_BIT,[hl]
    ret  z
    ld   a,l
    xor  a,$1D
    ld   l,a
    bit  SPRITE_FLAG_LOOP_LAST_FRAME_BIT,[hl]
    jr   z,.jr_02_33F2
    jr   .jr_02_341B
.jr_02_33F2:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   c,[hl]
    dec  l
    bit  7,[hl]
    jr   nz,.jr_02_340C
    ld   a,[hl]
    add  c
    cp   a,$80
    jr   c,.jr_02_340E
    sub  a,$7F
    cpl
    inc  a
    add  c
    ld   c,a
.jr_02_340C:
    ld   a,[hl]
    add  c
.jr_02_340E:
    ld   [hl],a
    ld   a,l
    xor  a,$15
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  a,$00
    ld   [hl],a
    ret
.jr_02_341B:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   c,[hl]
    dec  l
    bit  7,[hl]
    jr   z,.jr_02_3433
    ld   a,[hl]
    sub  c
    cp   a,$80
    jr   nc,.jr_02_3435
    sub  a,$80
    add  c
    ld   c,a
.jr_02_3433:
    ld   a,[hl]
    sub  c
.jr_02_3435:
    ld   [hl],a
    ld   a,l
    xor  a,$15
    ld   l,a
    ld   a,[hl]
    sub  c
    ldi  [hl],a
    ld   a,[hl]
    sbc  a,$00
    ld   [hl],a
    ret

call_00_3442_Entity_MoveXByFacingSpeed:
; Reads facing direction and a speed field, negates speed if facing left,
; sign-extends, then calls Entity_MoveX
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   c,[hl]
    xor  a,$11
    ld   l,a
    ld   a,[hl]
    bit  5,c
    jr   z,.jr_02_3455
    cpl
    inc  a
.jr_02_3455:
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    jp   call_00_37c9_Entity_MoveX

call_00_3460_Entity_GetMinXBound:
; DE = the LOW end of this entity's X patrol range: wD30A_EntityBoundingBoxXMin
; for this slot, scaled by 32 (blocks to pixels), plus $30.
;
; call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip calls this on the leftward
; leg and flips when XPOS drops BELOW the result
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   DE, wD30A_EntityBoundingBoxXMin
    add  HL, DE
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, $30
    add  HL, DE
    ld   E, L
    ld   D, H
    ret

call_00_347e_Entity_GetMaxXBound:
; DE = the HIGH end of the X patrol range: wD309_EntityBoundingBoxXMax scaled by
; 32, minus $10. The patrol code calls it on the rightward leg and flips when
; XPOS rises above the result
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   DE, wD309_EntityBoundingBoxXMax
    add  HL, DE
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, hFFF0
    add  HL, DE
    ld   E, L
    ld   D, H
    ret

call_00_349c_Entity_GetMinYBound:
; DE = low end of the Y range: wD30C_EntityBoundingBoxYMin scaled by 32, plus $30.
; Smaller Y is higher on screen, so this is the CEILING despite reading as "min"
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   DE, wD30C_EntityBoundingBoxYMin
    add  HL, DE
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, $30
    add  HL, DE
    ld   E, L
    ld   D, H
    ret

call_00_34ba_Entity_GetMaxYBound:
; DE = high end of the Y range: wD30B_EntityBoundingBoxYMax scaled by 32, minus
; $10. Larger Y is lower on screen, so this is the FLOOR - which is why the
; "move down until floor" helpers all call this one
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   DE, wD30B_EntityBoundingBoxYMax
    add  HL, DE
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, hFFF0
    add  HL, DE
    ld   E, L
    ld   D, H
    ret

call_00_34d8_Entity_ResetEntityListIndex:
; Zeros the wD301_EntityListIndexesForCurrentEntities-indexed slot counter byte for this entity's slot
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   [HL], $00
    ret

call_00_34ea_Entity_IsFirstFrameOfAction:
; Tests bit 5 of ACTION_STATE; returns Z/NZ for use as an activation/spawn gate
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_STATE_FLAGS
    bit  ACTION_STATE_IS_FIRST_FRAME_BIT, [HL]
    ret

call_00_34f5_Entity_IsPlayerStandingOnSelf:
; "Is Gex standing on me this frame?" - compares wD74D_Player_EntityStoodOnLo, which
; holds the slot base ($00/$20/$40/...) of whatever the player is riding, against this
; entity's own slot base. Returns B = 1 on a match, B = 0 otherwise (and B = 0 with Z
; set when the player is not standing on anything at all).
;
; It also returns HL pointing at this entity's ENTITY_FIELD_MISC_FLAGS, and every
; caller relies on that: the idiom throughout bank02_entity_actions.asm is
;
;     call call_00_34f5_Entity_IsPlayerStandingOnSelf
;     bit  0, [hl]      ; my own state flags, HL is still MISC_FLAGS
;     ...
;     bit  0, B         ; and B is the "player is on me" answer
;
; The old name (Entity_CompareMiscFlags) described the LOAD_OBJ_FIELD_TO_HL on the
; first line and not what the routine actually decides - it never reads MISC_FLAGS
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    ld   A, [wD74D_Player_EntityStoodOnLo]
    ld   B, A
    and  A, A
    ret  Z
    ld   A, L
    and  A, $e0
    cp   A, B
    ld   B, $00
    ret  NZ
    inc  B
    ret

call_00_350c_Entity_CheckIfOnScreen:
; Reads this entity's bounding box (X min/max, Y min/max) from wD309_EntityBoundingBoxXMax–wD30C_EntityBoundingBoxYMin;
; compares against wD329_MapWindow_BlockXRangeMin (camera/scroll bounds); returns carry if entity is outside
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    ld   L, A
    ld   H, $00
    ld   BC, wD309_EntityBoundingBoxXMax
    add  HL, BC
    ld   B, [HL]
    inc  HL
    ld   C, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
    ld   E, [HL]
    ld   HL, wD329_MapWindow_BlockXRangeMin
    ld   A, B
    cp   A, [HL]
    ret  C
    inc  HL
    ld   A, [HL+]
    cp   A, C
    ret  C
    ld   A, D
    cp   A, [HL]
    ret  C
    inc  HL
    ld   A, [HL]
    cp   A, E
    ret

call_00_3531_Entity_IsXOutsideBounds:
; The bounds test out of call_00_3364_Entity_ApproachPlayerXWithBounds with the facing
; and movement stripped off: converts the entity's own 16-bit world X to a block
; coordinate (x8, keep the high byte) and compares it against its patrol range,
; wD309_EntityBoundingBoxXMax - 1 down to wD30A_EntityBoundingBoxXMin + 1.
;
;   carry SET    outside the range - the entity has run off its own patrol span
;   carry CLEAR  inside it
;
; Named for the carry, because the one caller (call_02_5612_EntityAction_Ghost_Chase)
; branches on `jr c` to give up the chase
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   de,wD309_EntityBoundingBoxXMax
    add  hl,de
    ld   b,[hl]
    dec  b
    inc  hl
    ld   c,[hl]
    inc  c
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   c
    ret  c
    ld   a,b
    cp   h
    ret

call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth:
; Integrates subpixel accumulator for both X and Y velocity (4-bit fractional),
; then moves entity and calls Y movement
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL]
    and  A, $0f
    add  A, C
    ld   [HL+], A
    sra  A
    sra  A
    sra  A
    sra  A
    ld   C, A
    cp   A, $80
    ld   A, $ff
    adc  A, $00
    ld   B, A
    push BC
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL]
    and  A, $0f
    add  A, C
    ld   [HL], A
    sra  A
    sra  A
    sra  A
    sra  A
    ld   C, A
    cp   A, $80
    ld   A, $ff
    adc  A, $00
    ld   B, A
    call call_00_37d8_Entity_MoveY
    pop  BC
    jp   call_00_35d5_Entity_MoveXAndPushPlayer

call_00_3597_Entity_ApplyVelocityXY_Subpixel_NoPlayerPush:
; Same subpixel integration for X and Y, but calls plain Entity_MoveX/Entity_MoveY
; with no player-push side effect
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ldi  a,[hl]
    ld   c,a
    ld   a,[hl]
    and  a,$0F
    add  c
    ldi  [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    push bc
    ldi  a,[hl]
    ld   c,a
    ld   a,[hl]
    and  a,$0F
    add  c
    ld   [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    call call_00_37d8_Entity_MoveY
    pop  bc
    jp   call_00_37c9_Entity_MoveX

call_00_35d5_Entity_MoveXAndPushPlayer:
; Moves entity X by BC, then does one of two different things to the player.
;
; If the player is STANDING ON this entity (wD74D_Player_EntityStoodOnLo matches
; the slot base) it just records the delta C in wD75C_PlayerXDeltaExtra, so the
; player gets carried along - a moving platform.
;
; If instead the player is being PUSHED by it (wD74F_Player_PushedMovingPlatformLo)
; it does not apply a delta at all: it compares the player's screen X against the
; entity's and snaps the player's absolute X to whichever side of the entity they
; are on. That is a collision resolution, not a carry.
;
; Anything else returns without touching the player
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   A, [HL]
    add  A, C
    ld   [HL+], A
    ld   E, A
    ld   A, [HL]
    adc  A, B
    ld   [HL], A
    ld   D, A
    ld   A, L
    and  A, $e0
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   NZ, .jr_00_35f3
    ld   A, C
    ld   [wD75C_PlayerXDeltaExtra], A
    ret
.jr_00_35f3:
    ld   HL, wD74F_Player_PushedMovingPlatformLo
    cp   A, [HL]
    ret  NZ
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SCREEN_X
    ld   A, [wD212_Player_ScreenXPosition]
    cp   A, [HL]
    jr   C, .jr_00_3616
    ld   A, L
    xor  A, $06
    ld   L, A
    ld   A, E
    add  A, [HL]
    ld   [wD20E_Player_XPositionLo], A
    ld   A, D
    adc  A, $00
    ld   [wD20F_Player_XPositionHi], A
    ret
.jr_00_3616:
    ld   A, L
    xor  A, $06
    ld   L, A
    ld   C, [HL]
    inc  C
    ld   A, E
    sub  A, C
    ld   [wD20E_Player_XPositionLo], A
    ld   A, D
    sbc  A, $00
    ld   [wD20F_Player_XPositionHi], A
    ret

call_00_3628_Entity_SaveWorldState:
; Note the side effect: as well as backing up
; wD688_FlyAnimationPosition, it OVERWRITES it with $A0. So calling this does not
; only save state, it parks the fly animation - which matters because the cutscene
; code brackets whole previews with Save/Restore.
;
; Backs up camera/interaction pointers (wD74D_Player_EntityStoodOnLo–wD74F_Player_PushedMovingPlatformLo,
; wD688_FlyAnimationPosition), copies entity table (wD000), player entity (wD200),
; slot table (wD301_EntityListIndexesForCurrentEntities), and bounding box (wD309_EntityBoundingBoxXMax) into
; save buffers at wD79F_BackupBuffer_EntityFlags/wD89F_BackupBuffer_EntityMemory/
; wD99F_BackupBuffer_EntityListIndexes/wD9A7_BackupBuffer_BoundingBoxAndMore
    ld   A, [wD74D_Player_EntityStoodOnLo]
    ld   [wD9C7_BackupPlayer_EntityStoodOnLo], A
    ld   A, [wD74E_Player_PushedStationaryPlatformLo]
    ld   [wD9C8_BackupPlayer_PushedStationaryPlatformLo], A
    ld   A, [wD74F_Player_PushedMovingPlatformLo]
    ld   [wD9C9_BackupPlayer_PushedMovingPlatformLo], A
    ld   A, [wD688_FlyAnimationPosition]
    ld   [wD9CA_BackupBuffer_FlyAnimationPosition], A
    ld   A, $a0
    ld   [wD688_FlyAnimationPosition], A
    ld   HL, wD000_EntityFlags
    ld   DE, wD79F_BackupBuffer_EntityFlags
    ld   BC, $100
    call call_00_07b0_MemCopy
    ld   HL, wD200_EntityMemory
    ld   DE, wD89F_BackupBuffer_EntityMemory
    ld   BC, $100
    call call_00_07b0_MemCopy
    ld   HL, wD301_EntityListIndexesForCurrentEntities
    ld   DE, wD99F_BackupBuffer_EntityListIndexes
    ld   BC, $08
    call call_00_07b0_MemCopy
    ld   HL, wD309_EntityBoundingBoxXMax
    ld   DE, wD9A7_BackupBuffer_BoundingBoxAndMore
    ld   BC, $20
    jp   call_00_07b0_MemCopy

call_00_3675_Entity_RestoreWorldState:
; Inverse of call_00_3628_Entity_SaveWorldState — restores all saved buffers back to live RAM
    ld   A, [wD9C7_BackupPlayer_EntityStoodOnLo]
    ld   [wD74D_Player_EntityStoodOnLo], A
    ld   A, [wD9C8_BackupPlayer_PushedStationaryPlatformLo]
    ld   [wD74E_Player_PushedStationaryPlatformLo], A
    ld   A, [wD9C9_BackupPlayer_PushedMovingPlatformLo]
    ld   [wD74F_Player_PushedMovingPlatformLo], A
    ld   A, [wD9CA_BackupBuffer_FlyAnimationPosition]
    ld   [wD688_FlyAnimationPosition], A
    ld   HL, wD79F_BackupBuffer_EntityFlags
    ld   DE, wD000_EntityFlags
    ld   BC, $100
    call call_00_07b0_MemCopy
    ld   HL, wD89F_BackupBuffer_EntityMemory
    ld   DE, wD200_Player_EntityId
    ld   BC, $100
    call call_00_07b0_MemCopy
    ld   HL, wD99F_BackupBuffer_EntityListIndexes
    ld   DE, wD301_EntityListIndexesForCurrentEntities
    ld   BC, $08
    call call_00_07b0_MemCopy
    ld   HL, wD9A7_BackupBuffer_BoundingBoxAndMore
    ld   DE, wD309_EntityBoundingBoxXMax
    ld   BC, $20
    jp   call_00_07b0_MemCopy

call_00_36bd_Entity_FaceTowardsPlayer:
; Computes sign of (player X − entity X); sets facing direction to $20 (left) or $00 (right)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   A, [wD20E_Player_XPositionLo]
    sub  A, [HL]
    inc  HL
    ld   A, [wD20F_Player_XPositionHi]
    sbc  A, [HL]
    ld   C, $20
    jr   C, .jr_00_36d4
    ld   C, $00
.jr_00_36d4:
    ld   A, L
    xor  A, $02
    ld   L, A
    ld   [HL], C
    ret

call_00_36da_Entity_FaceAwayFromPlayer:
; Inverse of above — faces away from player
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   a,[wD20E_Player_XPositionLo]
    sub  [hl]
    inc  hl
    ld   a,[wD20F_Player_XPositionHi]
    sbc  [hl]
    ld   c,$00
    jr   c,.jr_02_36F1
    ld   c,$20
.jr_02_36F1:
    ld   a,l
    xor  a,$02
    ld   l,a
    ld   [hl],c
    ret

call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked:
; The standard "pace back and forth" step, and the second half of nearly every
; walking enemy in bank02_entity_actions.asm. Moves X by the current speed in the
; current facing direction, integrating the subpixel accumulator, then converts the
; new X to a block coordinate and compares it against the entity's own patrol span
; (wD309_EntityBoundingBoxXMax - 1 .. wD30A_EntityBoundingBoxXMin + 1), flipping
; FACING_FLAGS if it has run past either end.
;
; The return value is the flip, not the position:
;
;   NZ  the facing changed this frame - the entity has just turned around
;   Z   still going the same way (including when it is comfortably inside)
;
; Several entities use that as a "reached the end of my run" event instead of
; tracking position: the pre-history egg treats it as being cornered, the
; pterosaur only lets its dive cooldown tick on those frames, and the Kung Fu ninja
; abandons a stalk when it fires
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   C, [HL]
    ld   A, L
    xor  A, $11
    ld   L, A
    ld   A, [HL+]
    bit  5, C
    jr   Z, .jr_00_370b
    cpl
    inc  A
.jr_00_370b:
    add  A, [HL]
    ld   C, A
    and  A, $0f
    ld   [HL], A
    ld   A, C
    sra  A
    sra  A
    sra  A
    sra  A
    ld   C, A
    cp   A, $80
    ld   A, $ff
    adc  A, $00
    ld   B, A
    ld   A, L
    xor  A, $13
    ld   L, A
    ld   A, [HL]
    add  A, C
    ld   [HL+], A
    ld   C, A
    ld   A, [HL]
    adc  A, B
    ld   [HL], A
    ld   L, C
    ld   H, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   D, H
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   BC, wD309_EntityBoundingBoxXMax
    add  HL, BC
    ld   B, [HL]
    dec  B
    inc  HL
    ld   C, [HL]
    inc  C
    ld   A, D
    cp   A, C
    ld   C, $00
    jr   C, .jr_00_3754
    ld   A, B
    cp   A, D
    ld   C, $20
    jr   C, .jr_00_3754
    xor  A, A
    ret
.jr_00_3754:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   A, [HL]
    ld   [HL], C
    cp   A, C
    ret

call_00_3760_Entity_PatrolY_FacingBased:
; Vertical patrol using facing direction bit 6 to determine up/down;
; moves Y, checks against wD30B_EntityBoundingBoxYMax bounds, flips a $40/$00 flag in facing when bound hit
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   c,[hl]
    ld   a,l
    xor  a,$11
    ld   l,a
    ldi  a,[hl]
    bit  6,c
    jr   nz,.jr_02_3774
    cpl
    inc  a
.jr_02_3774:
    add  [hl]
    ld   c,a
    and  a,$0F
    ld   [hl],a
    ld   a,c
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$0D
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   c,a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    ld   l,c
    ld   h,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   d,h
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   bc,wD30B_EntityBoundingBoxYMax
    add  hl,bc
    ld   b,[hl]
    dec  b
    inc  hl
    ld   c,[hl]
    inc  c
    ld   a,d
    cp   c
    ld   c,$40
    jr   c,.jr_02_37BD
    ld   a,b
    cp   d
    ld   c,$00
    jr   c,.jr_02_37BD
    xor  a
    ret
.jr_02_37BD:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   a,[hl]
    ld   [hl],c
    cp   c
    ret

call_00_37c9_Entity_MoveX:
; Adds BC (signed delta) to entity's X position
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   a,[hl]
    add  a, c
    ldi  [hl],a
    ld   a,[hl]
    adc  a, b
    ld   [hl],a
    ret

call_00_37d8_Entity_MoveY:
; Adds BC (signed delta) to entity's Y position
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   A, [HL]
    add  A, C
    ld   [HL+], A
    ld   A, [HL]
    adc  A, B
    ld   [HL], A
    ret

call_00_37e7_Entity_SetOamAttrBase:
; Writes C into wD32D_Entity_OamAttrBase for this entity's slot - the value that
; call_03_5ebf_Entity_BuildSprites ORs into every OAM attribute byte the slot
; produces. In OAM attribute terms the low three bits are the CGB OBJ palette,
; so this picks the palette the whole entity is drawn in.
;
; The slot index comes from wD300_CurrentEntityAddrLo the usual way: slots are
; $20 bytes apart, so rotating the low address byte left three times and masking
; $07 turns $00/$20/$40/... into 0/1/2/...
;
; Both call sites pass $01, and both are the particle burst - here from
; call_00_3985_Entity_ParticleBurstInit when the burst is created, and again from
; call_02_52ab_EntityAction_ParticleBurst_Update when it is recycled into its
; follow-up effect. Nothing else ever writes the table, so every other slot draws
; with base $00
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD32D_Entity_OamAttrBase
    add  HL, DE
    ld   [HL], C
    ret

call_00_37f8_Entity_SetMiscFlags:
; Writes C to the MISC_FLAGS field
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    ld   [hl],c
    ret

call_00_3802_Entity_SetMiscTimer:
; Writes C to misc timer field
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   [HL], C
    ret

call_00_380c_Entity_CheckMiscTimerZero:
; Loads misc timer and ANDs; Z set if zero
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   a,[hl]
    and  a
    ret

call_00_3817_Entity_DecrementMiscTimer:
; Decrements misc timer if non-zero; returns new value in A
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   A, [HL]
    and  A, A
    ret  Z
    dec  [HL]
    ld   A, [HL]
    ret

call_00_3825_Entity_SetCollisionType:
; Writes C to collision type field
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_COLLISION_TYPE
    ld   [hl],c
    ret

call_00_382f_Entity_SetWidth:
; Writes C to width field
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_COLLISION_WIDTH
    ld   [hl],c
    ret

call_00_3839_Entity_GetSpriteCounter:
; A = ENTITY_FIELD_ANIM_FRAME_INDEX, the index into the current frame list
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ANIM_FRAME_INDEX
    ld   a,[hl]
    ret

call_00_3843_Entity_CheckAnimationEnded:
; Z if the current action's animation did NOT wrap this frame, NZ if it just
; finished its last frame. Tests SPRITE_FLAG_ANIM_ENDED_BIT, which is a one-frame
; pulse, so this only reads true on the frame the wrap happens.
;
; This is how nearly every action hands off to the next one - it has around 45
; call sites in bank02_entity_actions.asm, easily the most-used helper here
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    bit  SPRITE_FLAG_ANIM_ENDED_BIT, [HL]
    ret

call_00_384e_Entity_CheckSpriteIdChanged:
; NZ if the entity's sprite id changed this frame and its tiles need refetching.
; Tests SPRITE_FLAG_ID_CHANGED_BIT, another one-frame pulse.
;
; Nothing in the disassembly calls this - unlike its neighbour above, which is
; everywhere. Either the graphics streaming path checks the flag inline, or this
; is a leftover
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    bit  SPRITE_FLAG_ID_CHANGED_BIT,[hl]
    ret

call_00_3859_Entity_CheckPlayerXProximity:
; "Is Gex within +/- C pixels of me horizontally?"
;
;   carry SET    yes, he is inside the window
;   carry CLEAR  no, on either side
;
; The one-sided compare does both directions at once by biasing first: it forms
; (playerX - myX) + C and then subtracts 2C, so a player anywhere in the window
; lands in [0, 2C) and anywhere outside it - including far to the LEFT, where the
; difference goes negative and wraps to a large unsigned value - lands at or above
; 2C. No sign handling needed.
;
; This is the trigger for most of Toon TV. Note that entities which need to latch
; on and off call it twice with different radii (bumblebee: $20 to start charging,
; $40 to stop) so that standing on the boundary does not make them flicker between
; two actions
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   A, [wD20E_Player_XPositionLo]
    sub  A, [HL]
    ld   E, A
    inc  HL
    ld   A, [wD20F_Player_XPositionHi]
    sbc  A, [HL]
    ld   D, A
    ld   L, C
    ld   H, $00
    add  HL, DE
    sla  C
    ld   A, L
    sub  A, C
    ld   A, H
    sbc  A, $00
    ret

call_00_3878_Entity_CheckTVButtonEnabled:
; Is this TV button active? Two entirely different tests depending on where you are.
;
; In the hub (level id 0) it falls through to call_00_3899, which checks collection
; totals against the entity's requirements. Everywhere else it derives a slot index
; from the entity's list index - (index - 1) >> 1 - looks it up from
; wD798_BlockPatch_SlotTable13 and returns whether that slot is nonzero.
;
; Neither path involves distance
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    jr   Z, call_00_3899_Entity_CheckRemoteTotalsUnlock
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   E, A
    ld   D, $00
    ld   HL, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   A, [HL]
    dec  A
    srl  A
    ld   E, A
    ld   HL, wD798_BlockPatch_SlotTable13
    add  HL, DE
    ld   A, [HL]
    and  A, A
    ret

call_00_3899_Entity_CheckRemoteTotalsUnlock:
; Hub-world unlock gate: has the player collected enough remotes for this entity?
;
; Reads the three running totals wD64F_MissionRemoteTotal, wD650_HiddenRemoteTotal
; and wD651_BonusMissionTotal, masks off the top bit of each (& $7F), and compares
; each against three consecutive bytes starting at the entity's TIMER_2 field,
; which hold that entity's required counts. Returns A=1 only if all three totals
; meet or exceed their requirement, A=0 otherwise.
;
; The three requirement bytes at $19/$1A/$1B are not hardcoded: they are the three
; spawn parameters from the level's entity list, routed there by spawn mask $70 -
; which is precisely the mask ENTITY_TV_BUTTON and ENTITY_RED_REMOTE carry in
; bank0A_entity_load.asm. So each hub TV's unlock condition is three numbers in
; data.
;
; Nothing here reads a position - the three variables are collection totals. It is
; a progress requirement, which is why it gates the hub TVs
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   A, [wD64F_MissionRemoteTotal]
    and  A, $7f
    cp   A, [HL]
    jr   C, .jr_00_38bf
    inc  L
    ld   A, [wD650_HiddenRemoteTotal]
    and  A, $7f
    cp   A, [HL]
    jr   C, .jr_00_38bf
    inc  L
    ld   A, [wD651_BonusMissionTotal]
    and  A, $7f
    cp   A, [HL]
    jr   C, .jr_00_38bf
    ld   A, $01
    and  A, A
    ret
.jr_00_38bf:
    xor  A, A
    ret

call_00_38c1_Entity_CheckRedRemoteProgressFlag:
; In non-hub levels, maps slot to a bitmask via a 3-byte table and ANDs against
; wD629 remote progress flags; in hub delegates to call_00_3899_Entity_CheckRemoteTotalsUnlock
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    jr   Z, call_00_3899_Entity_CheckRemoteTotalsUnlock
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   E, A
    ld   D, $00
    ld   HL, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   A, [HL]
    dec  A
    srl  A
    ld   E, A
    ld   HL, .data_02_38ed
    add  HL, DE
    ld   A, [HL]
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    ld   DE, wD629_RemoteProgressFlags
    add  HL, DE
    and  A, [HL]
    ld   E, A
    ret
.data_02_38ed:
    db   $01, $02, $04

call_00_38f0_Entity_ClearAllSlots:
; Iterates the seven NPC entity slots - $D220 to $D2E0 in steps of $20, stopping
; when the low byte wraps to $00 - and calls call_00_3910_Entity_ClearSlot on each
; one that is not already free. $D200 is the player and is never touched.
;
; Seven, not eight, and the range ends at $D2E0 rather than $D3E0; the same seven
; are what call_00_3951_Entity_SpawnEffectAtPlayer scans for a free slot.
; wD300_CurrentEntityAddrLo is saved and restored around the loop
    ld   A, [wD300_CurrentEntityAddrLo]
    push AF
    ld   A, $20
.jr_00_38f6:
    ld   [wD300_CurrentEntityAddrLo], A
    or   A, $00
    ld   L, A
    ld   H, $d2
    ld   A, [HL]
    cp   A, $ff
    call NZ, call_00_3910_Entity_ClearSlot
    ld   A, [wD300_CurrentEntityAddrLo]
    add  A, $20
    jr   NZ, .jr_00_38f6
    pop  AF
    ld   [wD300_CurrentEntityAddrLo], A
    ret

call_00_3910_Entity_ClearSlot:
; Frees an entity slot and, unless the entity was permanently removed, allows its
; list entry to be placed again.
;
; Two writes. First ENTITY_ID_NONE into ENTITY_FIELD_ENTITY_ID, which is what
; actually releases the slot. Then it follows the slot -> list-entry link
; (wD301_EntityListIndexesForCurrentEntities) into wD000_EntityFlags and stores
; ENTITY_LIST_FLAG_ABSENT, so the spawner may place that entry again.
;
; The "cp ENTITY_LIST_FLAG_NEVER_AGAIN / ret Z" in between is the important part:
; a $FF entry is never cleared. That is what makes defeat stick. An enemy that
; merely scrolled off screen goes back to ABSENT and returns when you walk back;
; one that was killed was marked $FF by call_00_393c_Entity_MarkNeverRespawn
; first, and stays gone
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_ENTITY_ID
    ld   [HL], $ff
    ld   A, L
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   L, [HL]
    ld   H, HIGH(wD000_EntityFlags)
    ld   A, [HL]
    cp   A, ENTITY_LIST_FLAG_NEVER_AGAIN
    ret  Z
    ld   [HL], ENTITY_LIST_FLAG_ABSENT
    ret

call_00_3931_Entity_DeactivateSelf:
; Sets own entity ID field to $FF (marks slot as dead)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ENTITY_ID
    ld   [HL], $ff
    ret

call_00_393c_Entity_MarkNeverRespawn:
; Marks this entity's list entry as permanently gone: follows the slot -> list-entry
; link through wD301_EntityListIndexesForCurrentEntities into wD000_EntityFlags and
; stores ENTITY_LIST_FLAG_NEVER_AGAIN.
;
; This does NOT free the slot. It only affects whether the spawner is ever allowed
; to place this list entry again, and it is sticky:
; call_00_3910_Entity_ClearSlot bails out rather than overwrite $FF. So the entity
; is gone for as long as the level's flag array survives - which is until the level
; is reloaded, since the array is level-scoped and is saved/restored wholesale by
; call_00_3628_Entity_SaveWorldState around cutscenes.
;
; Callers pair it with call_00_3931_Entity_DeactivateSelf, which is what actually
; releases the slot: the silver and gold remotes, and every enemy that dies through
; call_00_3985_Entity_ParticleBurstInit. Things that should come back when you
; re-enter a room - scrolled-off enemies - do not call this.
;
; Note the special case: for a dynamically spawned entity,
; call_00_34d8_Entity_ResetEntityListIndex has already set the slot's list index to
; $00, so this writes to wD000_EntityFlags entry $00. That entry never belongs to a
; real list entry (the spawn cursor wD338 starts at 1), so the write is harmless -
; it is the scratch entry
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   L, [HL]
    ld   H, HIGH(wD000_EntityFlags)
    ld   [HL], ENTITY_LIST_FLAG_NEVER_AGAIN
    ret
