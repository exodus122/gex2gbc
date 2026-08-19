; ==================================================================
; ENTITY AND PLAYER ANIMATION DATA
;
; One block per (entity, action) pair - the second word of every row in the
; action tables at the top of bank02_entity_actions.asm, and of every row of
; data_02_4120_EntityActions_Gex. Nothing else in the ROM points into this file,
; and it is one contiguous run of blocks from $755C to $7CF1 with no padding
; between them.
;
; A block is a four-byte header followed by a list of frame ids:
;
;   +0  ACTION_STATE_* flags, copied to ENTITY_FIELD_ACTION_STATE_FLAGS with
;       ACTION_STATE_IS_FIRST_FRAME forced on. The low five bits name an action
;       to hand over to when the animation runs out; ACTION_STATE_ADVANCE_ON_END
;       is what actually makes the hand-over happen
;   +1  SPRITE_FLAG_* flags, copied to ENTITY_FIELD_SPRITE_FLAGS with
;       SPRITE_FLAG_ID_CHANGED forced on so the first frame's tiles get fetched.
;       These pick which of the five drawing paths in bank03_oam_build.asm the
;       entity uses - see the field notes in constants.asm
;   +2  ticks per frame, into both ENTITY_FIELD_ANIM_SPEED and the live
;       ENTITY_FIELD_ANIM_FRAME_TIMER. $FF is special: Entity_TickAction returns
;       immediately on it, so the animation never advances at all
;   +3  number of frames
;   +4  the frame ids, one per frame. Byte +4 is also written straight into
;       ENTITY_FIELD_SPRITE_ID so the entity is drawn correctly on its first
;       frame, before the ticker has run
;
; Every block then ends with a $00 that no code reads - Entity_TickAction wraps
; the frame index before it ever indexes past the count. It is a terminator by
; convention only, which is why the two zombie blocks below can carry a spare
; frame in front of it without anything noticing.
;
; WHAT THE FRAME IDS MEAN depends on the entity, not on this file, and for a good
; many entities they are not frame numbers at all. For anything with
; SPRITE_FLAG_STREAMS_OWN_GFX the id is the high byte of a ROM address, and writing
; it queues that page of tiles into VRAM - the shape on screen never changes, only
; the tiles under it, which is why a whole enemy animation costs no layout data.
; For SPRITE_FLAG_LAYOUT_BY_ACTION entities the id lands in wD73A_Entity_TileIdBase
; instead. Either way the layout comes from bank03_sprite_shapes.asm via
; data_03_5446_EntitySpriteMetaTable, so two entities can share a block here only
; when they share a sprite set - which several do.
;
; HOW A BLOCK ENDS is declared here rather than decided by the ticker:
;
;   ACTION_STATE_ADVANCE_ON_END   hand over to the pending action in bits 0-4
;   SPRITE_FLAG_LOOP_LAST_FRAME   restart on the LAST frame, so the animation
;                                 plays once and then sits on its final pose
;   neither                       restart at frame 0
;
; In all three cases SPRITE_FLAG_ANIM_ENDED is pulsed for one frame, and that
; pulse is what every hand-off in bank02_player_actions.asm and every
; call_00_3843_Entity_CheckAnimationEnded in bank02_entity_actions.asm is
; watching for. A one-frame block is therefore not a still image but a metronome:
; it re-pulses ANIM_ENDED every +2 ticks, and a good number of entities use one
; purely as a timer.
;
; ONLY GEX USES THE HAND-OVER. Exactly eleven of the 229 blocks have a nonzero
; byte +0, and all eleven are his; every entity block is $00 there. Nothing
; anywhere writes ENTITY_FIELD_ACTION_STATE_FLAGS after Entity_SetAction has, so
; ACTION_STATE_HAS_PENDING and ACTION_STATE_ADVANCE_ON_END can only ever fire for
; the player. Enemies change action by calling Entity_SetAction from their own
; handler instead, which is why call_02_70f1_Entity_RequestQueuedAction - despite
; living in the shared entity code - is a player-only path.
;
; THREE BLOCKS ARE UNREACHABLE - $779D, $7840 and $7B33. No action table points
; at any of them, so in the ROM they have no label at all; the _Orphan names below
; exist only so they can be referred to. Each sits directly behind a live block
; whose frame ids come out of the same neighbourhood, so they read as animations
; cut late rather than as data laid out for code that was never written.
; Two more blocks, $76E5 and $76EE - the two zombie walks - carry a fourth frame
; in front of their terminator while declaring a count of three. That is the same
; kind of trim, made by editing the count and leaving the byte where it was
; ==================================================================

; ------------------------------------------------------------------
; GEX
;
; The player's 32 action rows, in PLAYER_ACTION_* order - 31 blocks, since
; PLAYER_ACTION_ENTER_TV and PLAYER_ACTION_ENTER_TV_ALT share data_02_75f9. These
; are the only blocks in the file that use byte +0. They are also the only ones drawn by the default sprite path -
; no SPRITE_FLAG_* configuration bits at all except SPRITE_FLAG_LOOP_LAST_FRAME,
; because Gex is drawn by call_03_5ca8_Entity_BuildPlayerSprites, a separate
; routine that reads none of the path-selection bits.
;
; Read down the ANIM_ENDED-driven ones and the flow of Gex's state machine is
; visible as data: spawn hands to the intro warp, the intro warp and the idle
; animation and the skid all hand back to Stand, death hands to the death warp
; ------------------------------------------------------------------

data_02_755c:                                               ; ENTITY_GEX action $00 PLAYER_ACTION_SPAWN
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_INTRO_WARP
    db   $00, $06, $0c                                      ; 12 frames at 6 ticks, then PLAYER_ACTION_INTRO_WARP
    db   $9f, $a0, $a1, $a2, $a3, $a4, $a5, $a6
    db   $a7, $a8, $a9, $aa
    db   $00

data_02_756d:                                               ; ENTITY_GEX action $01 PLAYER_ACTION_INTRO_WARP
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $04, $01                                      ; one frame, 4 ticks, then PLAYER_ACTION_STAND
    db   $14
    db   $00

data_02_7573:                                               ; ENTITY_GEX action $02 PLAYER_ACTION_STAND
    db   $00, $00, $04, $04                                 ; 4 frames at 4 ticks, looping
    db   $14, $15, $16, $17
    db   $00

data_02_757c:                                               ; ENTITY_GEX action $03 PLAYER_ACTION_IDLE_ANIMATION
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $0a, $01                                      ; one frame, 10 ticks, then PLAYER_ACTION_STAND
    db   $09
    db   $00

data_02_7582:                                               ; ENTITY_GEX action $04 PLAYER_ACTION_WALK
    db   $00, $00, $04, $08                                 ; 8 frames at 4 ticks, looping
    db   $00, $01, $02, $03, $04, $05, $06, $07
    db   $00

data_02_758f:                                               ; ENTITY_GEX action $05 PLAYER_ACTION_RUN
    db   $00, $00, $04, $08                                 ; 8 frames at 4 ticks, looping
    db   $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
    db   $00

data_02_759c:                                               ; ENTITY_GEX action $06 PLAYER_ACTION_SKID
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $04, $03                                      ; 3 frames at 4 ticks, then PLAYER_ACTION_STAND
    db   $18, $19, $1a
    db   $00

data_02_75a4:                                               ; ENTITY_GEX action $07 PLAYER_ACTION_TEETER
    db   $00, $00, $04, $04                                 ; 4 frames at 4 ticks, looping
    db   $32, $33, $34, $35
    db   $00

data_02_75ad:                                               ; ENTITY_GEX action $08 PLAYER_ACTION_CROUCH
    db   $00, $00, $0a, $01                                 ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $1d
    db   $00

data_02_75b3:                                               ; ENTITY_GEX action $09 PLAYER_ACTION_JUMP
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $04, $03         ; 3 frames at 4 ticks, then holds the last
    db   $93, $94, $95
    db   $00

data_02_75bb:                                               ; ENTITY_GEX action $0A PLAYER_ACTION_DOUBLE_JUMP
    db   $00, $00, $04, $01                                 ; one frame; ANIM_ENDED pulses every 4 ticks
    db   $1b
    db   $00

data_02_75c1:                                               ; ENTITY_GEX action $0B PLAYER_ACTION_NONE
    db   $00, $00, $0a, $01                                 ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $00
    db   $00

data_02_75c7:                                               ; ENTITY_GEX action $0C PLAYER_ACTION_KARATE_KICK
    db   $00, $00, $08, $02                                 ; 2 frames at 8 ticks, looping
    db   $ac, $ad
    db   $00

data_02_75ce:                                               ; ENTITY_GEX action $0D PLAYER_ACTION_TAIL_SPIN
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $04, $06         ; 6 frames at 4 ticks, then holds the last
    db   $27, $22, $23, $24, $25, $26
    db   $00

data_02_75d9:                                               ; ENTITY_GEX action $0E PLAYER_ACTION_EAT_FLY
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $04, $01                                      ; one frame, 4 ticks, then PLAYER_ACTION_STAND
    db   $09
    db   $00

data_02_75df:                                               ; ENTITY_GEX action $0F PLAYER_ACTION_TAKE_DAMAGE
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $04, $05                                      ; 5 frames at 4 ticks, then PLAYER_ACTION_STAND
    db   $8c, $8d, $8e, $8f, $1c
    db   $00

data_02_75e9:                                               ; ENTITY_GEX action $10 PLAYER_ACTION_DEATH
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_DEATH_SET_UP_WARP
    db   $00, $04, $04                                      ; 4 frames at 4 ticks, then PLAYER_ACTION_DEATH_SET_UP_WARP
    db   $90, $91, $92, $96
    db   $00

data_02_75f2:                                               ; ENTITY_GEX action $11 PLAYER_ACTION_DEATH_SET_UP_WARP
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $3c, $02         ; 2 frames at 60 ticks, then holds the last
    db   $ab, $3b
    db   $00

; ENTITY_GEX action $12 PLAYER_ACTION_ENTER_TV
; ENTITY_GEX action $13 PLAYER_ACTION_ENTER_TV_ALT
data_02_75f9:
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $0a, $0a         ; 10 frames at 10 ticks, then holds the last
    db   $28, $29, $2a, $2b, $2c, $2d, $2e, $2f
    db   $30, $31
    db   $00

data_02_7608:                                               ; ENTITY_GEX action $14 PLAYER_ACTION_EXIT_TV
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $0a, $0a                                      ; 10 frames at 10 ticks, then PLAYER_ACTION_STAND
    db   $31, $30, $2f, $d1, $d2, $d3, $d4, $d5
    db   $d6, $d7
    db   $00

data_02_7617:                                               ; ENTITY_GEX action $15 PLAYER_ACTION_STANDING_PUSH
    db   $00, $00, $ff, $01                                 ; one frame, never ticks
    db   $88
    db   $00

data_02_761d:                                               ; ENTITY_GEX action $16 PLAYER_ACTION_WALKING_PUSH
    db   $00, $00, $04, $08                                 ; 8 frames at 4 ticks, looping
    db   $84, $85, $86, $87, $88, $89, $8a, $8b
    db   $00

data_02_762a:                                               ; ENTITY_GEX action $17 PLAYER_ACTION_FREEFALL
    db   $00, $00, $04, $04                                 ; 4 frames at 4 ticks, looping
    db   $1e, $1f, $20, $21
    db   $00

data_02_7633:                                               ; ENTITY_GEX action $18 PLAYER_ACTION_STOP_IMMEDIATE
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $04, $01                                      ; one frame, 4 ticks, then PLAYER_ACTION_STAND
    db   $1c
    db   $00

data_02_7639:                                               ; ENTITY_GEX action $19 PLAYER_ACTION_COLLAPSE
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $04, $09                                      ; 9 frames at 4 ticks, then PLAYER_ACTION_STAND
    db   $1c, $36, $37, $38, $39, $3a, $38, $38
    db   $1c
    db   $00

data_02_7647:                                               ; ENTITY_GEX action $1A PLAYER_ACTION_ENTER_DOOR
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $06, $0c         ; 12 frames at 6 ticks, then holds the last
    db   $ae, $af, $b0, $b1, $b2, $b3, $b4, $b5
    db   $3c, $3c, $3c, $3c
    db   $00

data_02_7658:                                               ; ENTITY_GEX action $1B PLAYER_ACTION_LEAVE_DOOR
    db   ACTION_STATE_HAS_PENDING | ACTION_STATE_ADVANCE_ON_END | PLAYER_ACTION_STAND
    db   $00, $06, $08                                      ; 8 frames at 6 ticks, then PLAYER_ACTION_STAND
    db   $b6, $b7, $b8, $b9, $ba, $bb, $c0, $c1
    db   $00

data_02_7665:                                               ; ENTITY_GEX action $1C PLAYER_ACTION_HIT_BOUNCE
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $04, $03         ; 3 frames at 4 ticks, then holds the last
    db   $93, $94, $95
    db   $00

data_02_766d:                                               ; ENTITY_GEX action $1D PLAYER_ACTION_CLIMB
    db   $00, $00, $ff, $01                                 ; one frame, never ticks
    db   $40
    db   $00

data_02_7673:                                               ; ENTITY_GEX action $1E PLAYER_ACTION_GOLD_REMOTE_WARP
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $06, $0c         ; 12 frames at 6 ticks, then holds the last
    db   $aa, $a9, $a8, $a7, $a6, $a5, $a4, $a3
    db   $a2, $a1, $a0, $9f
    db   $00

data_02_7684:                                               ; ENTITY_GEX action $1F PLAYER_ACTION_RIDING_ROCKET
    db   $00, SPRITE_FLAG_LOOP_LAST_FRAME, $04, $01         ; one frame; ANIM_ENDED pulses every 4 ticks
    db   $40
    db   $00

; ENTITY_UNK_02 action $00
; ENTITY_SCREAM_TV_ZOMBIE_HEAD action $00
; ENTITY_SCREAM_TV_ZOMBIE_HEAD action $01
; ENTITY_SCREAM_TV_ZOMBIE_HEAD action $02
data_02_768a:
    db   $00, $00, $0a, $01                                 ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $00
    db   $00

; ------------------------------------------------------------------
; CHARACTERS AND ENEMIES - SPRITE_FLAG_STREAMS_OWN_GFX
;
; Everything from here to $791F sets bit 7, which means two things at once: the
; OAM attributes come from the entity's own FACING_FLAGS rather than from the
; sprite flags byte, and the entity streams its own page of tiles into VRAM as
; its frame id changes. That is why these are the things that turn round and
; face Gex - enemies, bosses, the hub remotes - and why their frame ids run in
; small contiguous runs: each run is a tile page.
;
; SPRITE_FLAG_LOOP_LAST_FRAME appears throughout as $82. On an enemy it is almost
; always a death or a wind-up: play the sequence once, then sit on the final pose
; and let the handler notice ANIM_ENDED
; ------------------------------------------------------------------

data_02_7690:                                               ; ENTITY_RED_REMOTE action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $08         ; 8 frames at 6 ticks, looping
    db   $40, $41, $42, $43, $44, $45, $46, $47
    db   $00

; ENTITY_RED_REMOTE action $01
; ENTITY_SILVER_REMOTE action $00
; ENTITY_SILVER_REMOTE action $01
; ENTITY_GOLD_REMOTE action $01
data_02_769d:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $06         ; 6 frames at 6 ticks, looping
    db   $48, $49, $4a, $4b, $4c, $4d
    db   $00

data_02_76a8:                                               ; ENTITY_GOLD_REMOTE action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $08         ; 8 frames at 6 ticks, looping
    db   $50, $51, $52, $53, $54, $55, $56, $57
    db   $00

; ENTITY_UNK_08 action $00
; ENTITY_SCREAM_TV_PUMPKIN action $00
data_02_76b5:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $05, $05 ; 5 frames at 5 ticks, then holds the last
    db   $5d, $5c, $5b, $5a, $5b
    db   $00

data_02_76bf:                                               ; ENTITY_SCREAM_TV_PUMPKIN action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $05, $03 ; 3 frames at 5 ticks, then holds the last
    db   $5c, $5d, $5e
    db   $00

data_02_76c7:                                               ; ENTITY_SCREAM_TV_FRANKIE action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $04         ; 4 frames at 10 ticks, looping
    db   $5f, $60, $61, $60
    db   $00

data_02_76d0:                                               ; ENTITY_SCREAM_TV_FLOATING_SKULL action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $4b, $04 ; 4 frames at 75 ticks, then holds the last
    db   $75, $74, $74, $74
    db   $00

data_02_76d9:                                               ; ENTITY_SCREAM_TV_FLOATING_SKULL action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $0a, $01 ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $75
    db   $00

data_02_76df:                                               ; ENTITY_SCREAM_TV_FLOATING_SKULL action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $01         ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $76
    db   $00

data_02_76e5:                                               ; ENTITY_SCREAM_TV_ZOMBIE action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $03         ; 3 frames at 10 ticks, looping
    db   $67, $68, $69
    db   $68                                                ; beyond the frame count - never drawn
    db   $00

data_02_76ee:                                               ; ENTITY_SCREAM_TV_ZOMBIE action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $03         ; 3 frames at 10 ticks, looping
    db   $6a, $6b, $6c
    db   $6b                                                ; beyond the frame count - never drawn
    db   $00

data_02_76f7:                                               ; ENTITY_SCREAM_TV_ZOMBIE action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $0a, $01 ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $6b
    db   $00

data_02_76fd:                                               ; ENTITY_SCREAM_TV_BAT action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $04         ; 4 frames at 10 ticks, looping
    db   $7a, $7b, $7c, $7d
    db   $00

data_02_7706:                                               ; ENTITY_SCREAM_TV_DOOR_OPENING action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $04 ; 4 frames at 6 ticks, then holds the last
    db   $7c, $7d, $7e, $7f
    db   $00

data_02_770f:                                               ; ENTITY_SCREAM_TV_DOOR_OPENING action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $04 ; 4 frames at 6 ticks, then holds the last
    db   $7f, $7e, $7d, $7c
    db   $00

data_02_7718:                                               ; ENTITY_SCREAM_TV_GHOST action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $04, $05 ; 5 frames at 4 ticks, then holds the last
    db   $73, $72, $71, $70, $6f
    db   $00

data_02_7722:                                               ; ENTITY_SCREAM_TV_GHOST action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $04, $05 ; 5 frames at 4 ticks, then holds the last
    db   $6f, $70, $71, $72, $73
    db   $00

data_02_772c:                                               ; ENTITY_SCREAM_TV_GHOST action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $02         ; 2 frames at 10 ticks, looping
    db   $6b, $6c
    db   $00

data_02_7733:                                               ; ENTITY_SCREAM_TV_GHOST action $03
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $02         ; 2 frames at 10 ticks, looping
    db   $6b, $6c
    db   $00

data_02_773a:                                               ; ENTITY_TOON_TV_HAPPY_FACE action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $05, $05 ; 5 frames at 5 ticks, then holds the last
    db   $42, $43, $44, $45, $44
    db   $00

data_02_7744:                                               ; ENTITY_TOON_TV_HAPPY_FACE action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $05, $03 ; 3 frames at 5 ticks, then holds the last
    db   $43, $42, $41
    db   $00

data_02_774c:                                               ; ENTITY_TOON_TV_HUNTER action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $08         ; 8 frames at 6 ticks, looping
    db   $46, $47, $48, $49, $4a, $4b, $4c, $4d
    db   $00

data_02_7759:                                               ; ENTITY_TOON_TV_HUNTER action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $0a         ; 10 frames at 6 ticks, looping
    db   $59, $5a, $5b, $5c, $5d, $5e, $46, $46
    db   $46, $46
    db   $00

data_02_7768:                                               ; ENTITY_TOON_TV_HUNTER action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $03, $0f ; 15 frames at 3 ticks, then holds the last
    db   $4e, $4f, $50, $51, $52, $53, $54, $4e
    db   $4f, $50, $51, $52, $53, $54, $4e
    db   $00

data_02_777c:                                               ; ENTITY_TOON_TV_HUNTER action $03
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $03 ; 3 frames at 6 ticks, then holds the last
    db   $55, $56, $57
    db   $00

data_02_7784:                                               ; ENTITY_TOON_TV_HUNTER action $04
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $b4, $01         ; one frame; ANIM_ENDED pulses every 180 ticks
    db   $58
    db   $00

data_02_778a:                                               ; ENTITY_TOON_TV_HUNTER action $05
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $01 ; one frame; ANIM_ENDED pulses every 6 ticks
    db   $57
    db   $00

; ENTITY_PRE_HISTORY_FAST_DINOSAUR action $00
; ENTITY_UNK_3F action $00
; ENTITY_UNK_4A action $00
; ENTITY_UNK_6B action $00
; ENTITY_UNK_79 action $00
data_02_7790:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $08         ; 8 frames at 10 ticks, looping
    db   $5a, $5b, $5c, $5d, $5e, $5f, $60, $61
    db   $00
data_02_779d_Orphan:                                        ; unreachable - no action table points here
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $05, $05         ; 5 frames at 5 ticks, looping
    db   $62, $63, $64, $65, $66
    db   $00

data_02_77a7:                                               ; ENTITY_PRE_HISTORY_DRAGONFLY action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $05, $06         ; 6 frames at 5 ticks, looping
    db   $40, $41, $42, $43, $44, $45
    db   $00

data_02_77b2:                                               ; ENTITY_PRE_HISTORY_PTEROSAUR action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $06         ; 6 frames at 6 ticks, looping
    db   $46, $47, $48, $49, $4a, $4b
    db   $00

data_02_77bd:                                               ; ENTITY_PRE_HISTORY_DINOSAUR action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $08         ; 8 frames at 6 ticks, looping
    db   $4c, $4d, $4e, $4f, $50, $51, $52, $53
    db   $00

data_02_77ca:                                               ; ENTITY_PRE_HISTORY_TRICERATOPS action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $06         ; 6 frames at 8 ticks, looping
    db   $54, $55, $56, $57, $58, $59
    db   $00

data_02_77d5:                                               ; ENTITY_PRE_HISTORY_EGG action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $08         ; 8 frames at 4 ticks, looping
    db   $6d, $6e, $6f, $70, $6d, $71, $72, $74
    db   $00

data_02_77e2:                                               ; ENTITY_PRE_HISTORY_EGG action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $04, $03 ; 3 frames at 4 ticks, then holds the last
    db   $74, $75, $76
    db   $00

data_02_77ea:                                               ; ENTITY_PRE_HISTORY_EGG action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $04, $03 ; 3 frames at 4 ticks, then holds the last
    db   $77, $78, $79
    db   $00

data_02_77f2:                                               ; ENTITY_KUNG_FU_THEATER_DRAGONFLY action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $05, $06         ; 6 frames at 5 ticks, looping
    db   $5f, $60, $61, $62, $63, $64
    db   $00

; ENTITY_KUNG_FU_THEATER_WALKING_NINJA action $00
; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA action $00
data_02_77fd:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $0a, $04         ; 4 frames at 10 ticks, looping
    db   $58, $59, $5a, $5b
    db   $00

; ENTITY_KUNG_FU_THEATER_WALKING_NINJA action $01
; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA action $01
data_02_7806:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $0a         ; 10 frames at 4 ticks, looping
    db   $5c, $5d, $5e, $5f, $60, $61, $60, $5f
    db   $5e, $5d
    db   $00

; ENTITY_KUNG_FU_THEATER_WALKING_NINJA action $02
; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA action $02
data_02_7815:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $04, $04 ; 4 frames at 4 ticks, then holds the last
    db   $62, $65, $64, $63
    db   $00

data_02_781e:                                               ; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA action $03
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $ff, $01 ; one frame, never ticks
    db   $66
    db   $00

data_02_7824:                                               ; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $ff, $01         ; one frame, never ticks
    db   $73
    db   $00

data_02_782a:                                               ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $08         ; 8 frames at 6 ticks, looping
    db   $67, $68, $69, $6a, $6b, $6c, $6d, $6e
    db   $00

data_02_7837:                                               ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $0a, $04 ; 4 frames at 10 ticks, then holds the last
    db   $6f, $70, $71, $72
    db   $00
data_02_7840_Orphan:                                        ; unreachable - no action table points here
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $06, $08         ; 8 frames at 6 ticks, looping
    db   $65, $66, $67, $68, $69, $6a, $6b, $6c
    db   $00

data_02_784d:                                               ; ENTITY_REZOPOLIS_UFO action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $0a         ; 10 frames at 4 ticks, looping
    db   $40, $41, $42, $43, $44, $45, $44, $43
    db   $42, $41
    db   $00

data_02_785c:                                               ; ENTITY_REZOPOLIS_UFO action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $04         ; 4 frames at 4 ticks, looping
    db   $47, $48, $49, $48
    db   $00

data_02_7865:                                               ; ENTITY_REZOPOLIS_GREEN_MONSTER action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $08         ; 8 frames at 8 ticks, looping
    db   $4a, $4b, $4c, $4d, $4e, $4f, $50, $51
    db   $00

data_02_7872:                                               ; ENTITY_REZOPOLIS_GREEN_MONSTER action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $08, $02 ; 2 frames at 8 ticks, then holds the last
    db   $52, $53
    db   $00

data_02_7879:                                               ; ENTITY_REZOPOLIS_GREEN_MONSTER action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $02         ; 2 frames at 4 ticks, looping
    db   $54, $55
    db   $00

data_02_7880:                                               ; ENTITY_REZOPOLIS_PINCER action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $04         ; 4 frames at 4 ticks, looping
    db   $56, $57, $58, $59
    db   $00

data_02_7889:                                               ; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $04, $06         ; 6 frames at 4 ticks, looping
    db   $77, $78, $79, $7a, $7b, $7c
    db   $00

data_02_7894:                                               ; ENTITY_CHANNEL_Z_REZ_PORTAL action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $0f         ; 15 frames at 8 ticks, looping
    db   $6d, $6e, $6f, $70, $71, $72, $73, $74
    db   $75, $76, $77, $78, $79, $7a, $7b
    db   $00

data_02_78a8:                                               ; ENTITY_CHANNEL_Z_REZ action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $08         ; 8 frames at 8 ticks, looping
    db   $50, $51, $52, $53, $54, $55, $56, $57
    db   $00

data_02_78b5:                                               ; ENTITY_CHANNEL_Z_REZ action $01
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $08         ; 8 frames at 8 ticks, looping
    db   $57, $56, $55, $54, $53, $52, $51, $50
    db   $00

data_02_78c2:                                               ; ENTITY_CHANNEL_Z_REZ action $04
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX | SPRITE_FLAG_LOOP_LAST_FRAME, $08, $10 ; 16 frames at 8 ticks, then holds the last
    db   $57, $56, $55, $54, $53, $52, $51, $50
    db   $50, $51, $52, $53, $54, $55, $56, $57
    db   $00

data_02_78d7:                                               ; ENTITY_CHANNEL_Z_REZ action $02
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $08         ; 8 frames at 8 ticks, looping
    db   $40, $41, $42, $43, $44, $45, $46, $47
    db   $00

data_02_78e4:                                               ; ENTITY_CHANNEL_Z_REZ action $03
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $08         ; 8 frames at 8 ticks, looping
    db   $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
    db   $00

; ENTITY_CHANNEL_Z_REZ action $05
; ENTITY_CHANNEL_Z_REZ action $06
; ENTITY_CHANNEL_Z_REZ action $07
; ENTITY_CHANNEL_Z_REZ action $08
data_02_78f1:
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $06         ; 6 frames at 8 ticks, looping
    db   $76, $77, $78, $79, $7a, $7b
    db   $00

data_02_78fc:                                               ; ENTITY_CHANNEL_Z_REZ action $09
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $0a         ; 10 frames at 8 ticks, looping
    db   $7c, $79, $7c, $79, $7c, $79, $7c, $79
    db   $7c, $79
    db   $00

data_02_790b:                                               ; ENTITY_CHANNEL_Z_REZ action $0A
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $08, $0a         ; 10 frames at 8 ticks, looping
    db   $7c, $79, $7c, $79, $7c, $79, $7c, $79
    db   $7c, $79
    db   $00

data_02_791a:                                               ; ENTITY_UNK_8E action $00
    db   $00, SPRITE_FLAG_STREAMS_OWN_GFX, $ff, $01         ; one frame, never ticks
    db   $00
    db   $00

; ------------------------------------------------------------------
; OBJECTS AND PLATFORMS - SPRITE_FLAG_LAYOUT_BY_ACTION
;
; From here to $7CCD the entities set bit 4, so the OAM layout is chosen by the
; entity's ACTION_ID through .data_03_608e_EntitySpriteLayoutPointerTable rather
; than by the animation frame. An action is a shape here, not a pose - which is
; how a platform can be one action wide and another action tall.
;
; That makes the frame list secondary, and it shows: a tick of $FF is the single
; commonest header in this section. Those entities have no animation at all and
; write ENTITY_FIELD_SPRITE_ID from their handler when they want to change.
;
; SPRITE_FLAG_INVISIBLE ($18) blocks are scattered through the run. They draw
; nothing and go straight to collision dispatch - trigger volumes, hitboxes for
; things drawn by other means, and the vanished half of a vanishing platform
; ------------------------------------------------------------------

data_02_7920:                                               ; ENTITY_SCREAM_TV_HEAD_GHOST action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $0a, $08        ; 8 frames at 10 ticks, looping
    db   $20, $28, $20, $28, $20, $28, $20, $28
    db   $00

data_02_792d:                                               ; ENTITY_SCREAM_TV_HEAD_GHOST action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $2d, $01        ; one frame; ANIM_ENDED pulses every 45 ticks
    db   $30
    db   $00

data_02_7933:                                               ; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $2d, $01        ; one frame; ANIM_ENDED pulses every 45 ticks
    db   $38
    db   $00

; ENTITY_SCREAM_TV_FALLING_AXE action $00
; ENTITY_SCREAM_TV_FALLING_AXE action $01
; ENTITY_SCREAM_TV_FALLING_AXE action $03
data_02_7939:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_793f:                                               ; ENTITY_SCREAM_TV_FALLING_AXE action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $1e, $01        ; one frame; ANIM_ENDED pulses every 30 ticks
    db   $40
    db   $00

data_02_7945:                                               ; ENTITY_TV_BUTTON action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $28
    db   $00

data_02_794b:                                               ; ENTITY_TV_BUTTON action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $2c
    db   $00

data_02_7951:                                               ; ENTITY_SCREAM_TV_LANTERN action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7957:                                               ; ENTITY_SCREAM_TV_LANTERN action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_795d:                                               ; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $44
    db   $00

data_02_7963:                                               ; ENTITY_SCREAM_TV_FALLING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $4c
    db   $00

data_02_7969:                                               ; ENTITY_SCREAM_TV_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $48
    db   $00

data_02_796f:                                               ; ENTITY_SCREAM_TV_PUSH_BLOCK action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7975:                                               ; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

; ENTITY_SCREAM_TV_VANISHING_PLATFORM action $00
; ENTITY_SCREAM_TV_VANISHING_PLATFORM action $01
data_02_797b:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $48
    db   $00

data_02_7981:                                               ; ENTITY_SCREAM_TV_VANISHING_PLATFORM action $02
    db   $00, SPRITE_FLAG_INVISIBLE, $3c, $01               ; one frame; ANIM_ENDED pulses every 60 ticks
    db   $48
    db   $00

data_02_7987:                                               ; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $48
    db   $00

data_02_798d:                                               ; ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_7993:                                               ; ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_7999:                                               ; ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $30
    db   $00

; ENTITY_TOON_TV_BUMBLEBEE action $00
; ENTITY_TOON_TV_BUMBLEBEE action $01
data_02_799f:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $02        ; 2 frames at 4 ticks, looping
    db   $20, $30
    db   $00

data_02_79a6:                                               ; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $2d, $01        ; one frame; ANIM_ENDED pulses every 45 ticks
    db   $20
    db   $00

data_02_79ac:                                               ; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $02 ; 2 frames at 6 ticks, then holds the last
    db   $28, $30
    db   $00

data_02_79b3:                                               ; ENTITY_TOON_TV_MOVING_BEAR_TRAP action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $32, $01        ; one frame; ANIM_ENDED pulses every 50 ticks
    db   $20
    db   $00

data_02_79b9:                                               ; ENTITY_TOON_TV_MOVING_BEAR_TRAP action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $07 ; 7 frames at 6 ticks, then holds the last
    db   $28, $28, $28, $28, $28, $30, $38
    db   $00

data_02_79c5:                                               ; ENTITY_TOON_TV_BOWLING_BALL action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $06        ; 6 frames at 6 ticks, looping
    db   $44, $20, $2c, $38, $50, $50
    db   $00

; ENTITY_TOON_TV_HUNTER_BULLET action $00
; ENTITY_TOON_TV_HUNTER_BULLET action $01
data_02_79d0:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_79d6:                                               ; ENTITY_TOON_TV_CACTUS action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_79dc:                                               ; ENTITY_TOON_TV_CACTUS action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $0a, $02        ; 2 frames at 10 ticks, looping
    db   $2c, $38
    db   $00

data_02_79e3:                                               ; ENTITY_TOON_TV_CACTUS action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $44
    db   $00

data_02_79e9:                                               ; ENTITY_TOON_TV_DOMINO action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_79ef:                                               ; ENTITY_TOON_TV_SHARK action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $0a, $02        ; 2 frames at 10 ticks, looping
    db   $40, $46
    db   $00

data_02_79f6:                                               ; ENTITY_TOON_TV_FLOWER action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_79fc:                                               ; ENTITY_TOON_TV_FLOWER action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $2c
    db   $00

data_02_7a02:                                               ; ENTITY_TOON_TV_FLOWER action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $38
    db   $00

data_02_7a08:                                               ; ENTITY_TOON_TV_FLOWER_HAMMER action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $0a, $01        ; one frame; ANIM_ENDED pulses every 10 ticks
    db   $44
    db   $00

data_02_7a0e:                                               ; ENTITY_TOON_TV_FLOWER_HAMMER action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $0c, $02 ; 2 frames at 12 ticks, then holds the last
    db   $4c, $54
    db   $00

data_02_7a15:                                               ; ENTITY_TOON_TV_FLOWER_HAMMER action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $1e, $01 ; one frame; ANIM_ENDED pulses every 30 ticks
    db   $54
    db   $00

data_02_7a1b:                                               ; ENTITY_TOON_TV_MUSHROOM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7a21:                                               ; ENTITY_TOON_TV_MUSHROOM_PROJECTILE action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $08        ; 8 frames, but tick $ff means only the first is ever drawn
    db   $40, $42, $44, $46, $48, $4a, $4c, $4e
    db   $00

data_02_7a2e:                                               ; ENTITY_TOON_TV_MOVING_LOG action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7a34:                                               ; ENTITY_TOON_TV_STATIONARY_LOG action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7a3a:                                               ; ENTITY_TOON_TV_LIZARD action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $06        ; 6 frames at 6 ticks, looping
    db   $20, $28, $30, $38, $40, $48
    db   $00

; ENTITY_TOON_TV_VANISHING_BLOCK action $00
; ENTITY_TOON_TV_VANISHING_BLOCK action $01
data_02_7a45:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7a4b:                                               ; ENTITY_TOON_TV_VANISHING_BLOCK action $02
    db   $00, SPRITE_FLAG_INVISIBLE, $1e, $01               ; one frame; ANIM_ENDED pulses every 30 ticks
    db   $40
    db   $00

; ENTITY_TOON_TV_MOVING_BLOCK action $00
; ENTITY_TOON_TV_MOVING_BLOCK action $01
data_02_7a51:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7a57:                                               ; ENTITY_UNK_36 action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $08, $06        ; 6 frames at 8 ticks, looping
    db   $40, $44, $48, $4c, $48, $44
    db   $00

data_02_7a62:                                               ; ENTITY_UNK_35 action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $20
    db   $00

data_02_7a68:                                               ; ENTITY_UNK_35 action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $06 ; 6 frames at 6 ticks, then holds the last
    db   $20, $28, $30, $38, $40, $48
    db   $00

data_02_7a73:                                               ; ENTITY_PRE_HISTORY_FALLING_LAVA action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7a79:                                               ; ENTITY_PRE_HISTORY_FALLING_LAVA action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $06 ; 6 frames at 6 ticks, then holds the last
    db   $40, $42, $44, $46, $48, $4a
    db   $00

data_02_7a84:                                               ; ENTITY_PRE_HISTORY_LAVA_RAFT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7a8a:                                               ; ENTITY_PRE_HISTORY_LAVA_RAFT action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $60
    db   $00

data_02_7a90:                                               ; ENTITY_PRE_HISTORY_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7a96:                                               ; ENTITY_UNK_3A action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7a9c:                                               ; ENTITY_UNK_3B action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $54
    db   $00

data_02_7aa2:                                               ; ENTITY_UNK_46 action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7aa8:                                               ; ENTITY_UNK_3D action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_7aae:                                               ; ENTITY_PRE_HISTORY_FALLING_BOULDER action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $20
    db   $00

data_02_7ab4:                                               ; ENTITY_PRE_HISTORY_FALLING_BOULDER action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_7aba:                                               ; ENTITY_PRE_HISTORY_FALLING_BOULDER action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $02, $02 ; 2 frames at 2 ticks, then holds the last
    db   $2c, $38
    db   $00

data_02_7ac1:                                               ; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $02        ; 2 frames at 6 ticks, looping
    db   $28, $2c
    db   $00

data_02_7ac8:                                               ; ENTITY_PRE_HISTORY_BEETLE_VERTICAL action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $02        ; 2 frames at 6 ticks, looping
    db   $20, $24
    db   $00

data_02_7acf:                                               ; ENTITY_PRE_HISTORY_ANT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $04        ; 4 frames at 6 ticks, looping
    db   $30, $34, $38, $3c
    db   $00

data_02_7ad8:                                               ; ENTITY_PRE_HISTORY_GEYSER action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $20
    db   $00

data_02_7ade:                                               ; ENTITY_PRE_HISTORY_GEYSER action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $06, $06 ; 6 frames at 6 ticks, then holds the last
    db   $20, $28, $30, $38, $40, $48
    db   $00

data_02_7ae9:                                               ; ENTITY_PRE_HISTORY_TRICERATOPS_HORN action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7aef:                                               ; ENTITY_PRE_HISTORY_FIRE_PLANT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $08, $04        ; 4 frames at 8 ticks, looping
    db   $40, $44, $48, $44
    db   $00

data_02_7af8:                                               ; ENTITY_PRE_HISTORY_FIRE_PLANT action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $08, $04 ; 4 frames at 8 ticks, then holds the last
    db   $40, $44, $48, $4c
    db   $00

data_02_7b01:                                               ; ENTITY_PRE_HISTORY_FIRE_PLANT action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $08, $02        ; 2 frames at 8 ticks, looping
    db   $50, $54
    db   $00

data_02_7b08:                                               ; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $02        ; 2 frames at 4 ticks, looping
    db   $58, $5a
    db   $00

data_02_7b0f:                                               ; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $2c
    db   $00

data_02_7b15:                                               ; ENTITY_KUNG_FU_THEATER_HANGING_BLADE action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7b1b:                                               ; ENTITY_KUNG_FU_THEATER_CANNON action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $00
    db   $00

; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE action $00
; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE action $01
data_02_7b21:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $48
    db   $00

data_02_7b27:                                               ; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7b2d:                                               ; ENTITY_UNK_51 action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $78, $01        ; one frame; ANIM_ENDED pulses every 120 ticks
    db   $20
    db   $00
data_02_7b33_Orphan:                                        ; unreachable - no action table points here
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $f0, $01        ; one frame; ANIM_ENDED pulses every 240 ticks
    db   $28
    db   $00

; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE action $00
; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE action $01
data_02_7b39:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $04        ; 4 frames at 6 ticks, looping
    db   $58, $5a, $5c, $5a
    db   $00

; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM action $00
; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM action $01
data_02_7b42:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7b48:                                               ; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM action $02
    db   $00, SPRITE_FLAG_INVISIBLE, $1e, $01               ; one frame; ANIM_ENDED pulses every 30 ticks
    db   $50
    db   $00

data_02_7b4e:                                               ; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7b54:                                               ; ENTITY_UNK_60 action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7b5a:                                               ; ENTITY_KUNG_FU_THEATER_MOVING_RAFT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7b60:                                               ; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7b66:                                               ; ENTITY_UNK_63 action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $58
    db   $00

; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD action $00
; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD action $01
data_02_7b6c:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $46
    db   $00

data_02_7b72:                                               ; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $03        ; 3 frames at 6 ticks, looping
    db   $40, $42, $44
    db   $00

data_02_7b7a:                                               ; ENTITY_KUNG_FU_THEATER_LIZARD action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $06        ; 6 frames at 6 ticks, looping
    db   $20, $28, $30, $38, $40, $48
    db   $00

; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE action $00
; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE action $01
data_02_7b85:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $02        ; 2 frames at 6 ticks, looping
    db   $4c, $4e
    db   $00

data_02_7b8c:                                               ; ENTITY_KUNG_FU_THEATER_SPIKY_LOG action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

; ENTITY_KUNG_FU_THEATER_TALL_JAR action $00
; ENTITY_KUNG_FU_THEATER_JAR action $00
data_02_7b92:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

; ENTITY_UNK_5C action $00
; ENTITY_UNK_5D action $00
; ENTITY_UNK_64 action $00
; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM action $00
data_02_7b98:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7b9e:                                               ; ENTITY_REZOPOLIS_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $54
    db   $00

; ENTITY_REZOPOLIS_RED_PLATFORM action $00
; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM action $00
data_02_7ba4:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7baa:                                               ; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

; ENTITY_UNK_6C action $00
; ENTITY_UNK_6D action $00
; ENTITY_REZOPOLIS_FLAMETHROWER action $00
; ENTITY_REZOPOLIS_FLAMETHROWER action $01
data_02_7bb0:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $08        ; 8 frames at 4 ticks, looping
    db   $20, $24, $28, $2c, $30, $34, $38, $3c
    db   $00

data_02_7bbd:                                               ; ENTITY_REZOPOLIS_TAILSPIN_GEAR action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_7bc3:                                               ; ENTITY_REZOPOLIS_TAILSPIN_GEAR action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $04        ; 4 frames at 4 ticks, looping
    db   $20, $28, $30, $38
    db   $00

data_02_7bcc:                                               ; ENTITY_REZOPOLIS_TAILSPIN_GEAR action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $03, $04        ; 4 frames at 3 ticks, looping
    db   $20, $28, $30, $38
    db   $00

data_02_7bd5:                                               ; ENTITY_REZOPOLIS_TAILSPIN_GEAR action $03
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $02, $04        ; 4 frames at 2 ticks, looping
    db   $20, $28, $30, $38
    db   $00

data_02_7bde:                                               ; ENTITY_REZOPOLIS_TAILSPIN_GEAR action $04
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $01, $04        ; 4 frames at 1 tick, looping
    db   $20, $28, $30, $38
    db   $00

data_02_7be7:                                               ; ENTITY_REZOPOLIS_ANT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $08, $04        ; 4 frames at 8 ticks, looping
    db   $40, $46, $4c, $52
    db   $00

; ENTITY_UNK_6F action $00
; ENTITY_UNK_70 action $00
; ENTITY_CIRCUIT_CENTRAL_ANT action $00
data_02_7bf0:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $08, $04        ; 4 frames at 8 ticks, looping
    db   $20, $26, $2c, $32
    db   $00

data_02_7bf9:                                               ; ENTITY_CIRCUIT_CENTRAL_CAPACITOR action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $04, $03 ; 3 frames at 4 ticks, then holds the last
    db   $44, $40, $44
    db   $00

data_02_7c01:                                               ; ENTITY_CIRCUIT_CENTRAL_CAPACITOR action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $48
    db   $00

; ENTITY_CIRCUIT_CENTRAL_POWER_UP action $00
; ENTITY_CIRCUIT_CENTRAL_POWER_UP action $01
data_02_7c07:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_LOOP_LAST_FRAME, $05, $04 ; 4 frames at 5 ticks, then holds the last
    db   $40, $44, $48, $4c
    db   $00

data_02_7c10:                                               ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $20
    db   $00

data_02_7c16:                                               ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $02        ; 2 frames at 4 ticks, looping
    db   $26, $2c
    db   $00

data_02_7c1d:                                               ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $03        ; 3 frames at 6 ticks, looping
    db   $32, $36, $3a
    db   $00

data_02_7c25:                                               ; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_INVISIBLE, $ff, $01 ; one frame, never ticks
    db   $40
    db   $00

data_02_7c2b:                                               ; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $04        ; 4 frames at 6 ticks, looping
    db   $40, $44, $48, $4c
    db   $00

data_02_7c34:                                               ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $58
    db   $00

data_02_7c3a:                                               ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $06, $03        ; 3 frames at 6 ticks, looping
    db   $58, $54, $54
    db   $00

data_02_7c42:                                               ; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7c48:                                               ; ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $03, $03        ; 3 frames at 3 ticks, looping
    db   $58, $54, $54
    db   $00

data_02_7c50:                                               ; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $5c
    db   $00

data_02_7c56:                                               ; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $00
    db   $00

data_02_7c5c:                                               ; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $00
    db   $00

; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE action $00
; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2 action $00
; ENTITY_CHANNEL_Z_GUN_PROJECTILE action $00
data_02_7c62:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION | SPRITE_FLAG_INVISIBLE, $ff, $01 ; one frame, never ticks
    db   $40
    db   $00

; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE action $01
; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2 action $01
; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2 action $02
; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2 action $03
; ENTITY_CHANNEL_Z_GUN_PROJECTILE action $01
data_02_7c68:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $02        ; 2 frames at 4 ticks, looping
    db   $40, $42
    db   $00

data_02_7c6f:                                               ; ENTITY_REZOPOLIS_ANT_SPAWNER action $00
    db   $00, SPRITE_FLAG_INVISIBLE, $ff, $01               ; one frame, never ticks
    db   $00
    db   $00

; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1 action $00
; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2 action $00
data_02_7c75:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $5c
    db   $00

data_02_7c7b:                                               ; ENTITY_TOON_TV_ROCKET action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7c81:                                               ; ENTITY_TOON_TV_ROCKET action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $14        ; 20 frames at 4 ticks, looping
    db   $40, $50, $40, $50, $50, $40, $40, $50
    db   $40, $50, $40, $40, $50, $50, $50, $40
    db   $40, $50, $50, $40
    db   $00

data_02_7c9a:                                               ; ENTITY_TOON_TV_ROCKET action $02
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $03, $02        ; 2 frames at 3 ticks, looping
    db   $40, $50
    db   $00

data_02_7ca1:                                               ; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $04        ; 4 frames at 4 ticks, looping
    db   $50, $54, $58, $54
    db   $00

data_02_7caa:                                               ; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $04, $07        ; 7 frames at 4 ticks, looping
    db   $44, $44, $48, $48, $48, $48, $4c
    db   $00

; ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE action $00
; ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE action $01
data_02_7cb6:
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

data_02_7cbc:                                               ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $50
    db   $00

data_02_7cc2:                                               ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON action $01
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $54
    db   $00

data_02_7cc8:                                               ; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM action $00
    db   $00, SPRITE_FLAG_LAYOUT_BY_ACTION, $ff, $01        ; one frame, never ticks
    db   $40
    db   $00

; ------------------------------------------------------------------
; PARTICLE EFFECTS - SPRITE_FLAG_EMBEDDED_SPRITE_DATA
;
; The last six blocks set bit 0, so .jp_03_6451_Entity_BuildSprites_SpriteList
; draws them from a sprite list their handler builds in WRAM each frame instead
; of from a frame table. The frame list here is never drawn from at all, and
; every one of these blocks is a single frame at a tick of $FF - the header is
; carrying the flag byte and nothing else
; ------------------------------------------------------------------

data_02_7cce:                                               ; ENTITY_COLLECTIBLE_SPAWN action $00
    db   $00, SPRITE_FLAG_EMBEDDED_SPRITE_DATA, $ff, $01    ; one frame, never ticks
    db   $7e
    db   $00

data_02_7cd4:                                               ; ENTITY_ENEMY_DEFEATED action $00
    db   $00, SPRITE_FLAG_EMBEDDED_SPRITE_DATA, $ff, $01    ; one frame, never ticks
    db   $60
    db   $00

data_02_7cda:                                               ; ENTITY_PRE_HISTORY_FALLING_BOULDER action $03
    db   $00, SPRITE_FLAG_EMBEDDED_SPRITE_DATA, $ff, $01    ; one frame, never ticks
    db   $44
    db   $00

data_02_7ce0:                                               ; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES action $01
    db   $00, SPRITE_FLAG_EMBEDDED_SPRITE_DATA, $ff, $01    ; one frame, never ticks
    db   $58
    db   $00

data_02_7ce6:                                               ; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE action $01
    db   $00, SPRITE_FLAG_EMBEDDED_SPRITE_DATA, $ff, $01    ; one frame, never ticks
    db   $2c
    db   $00

; ENTITY_KUNG_FU_THEATER_TALL_JAR action $01
; ENTITY_KUNG_FU_THEATER_JAR action $01
data_02_7cec:
    db   $00, SPRITE_FLAG_EMBEDDED_SPRITE_DATA, $ff, $01    ; one frame, never ticks
    db   $5c
    db   $00
