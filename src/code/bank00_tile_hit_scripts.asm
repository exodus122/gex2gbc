call_00_1f46_TileHit_OnPlayerAttack:
; Entry point called each frame during TailSpin when the tile under Gex is interactive (type < $C0, inverted in C).
; Guards: returns if wD77D_BlockPatch_StepsRemaining nonzero (sequence already running),
; wD77B_BlockPatch_VramWritePending nonzero, or wD76B_Player_IsAttacking zero. Clears wD76B. Converts player X and Y
; world positions to block coordinates (world_pos × 8, high byte) and stores preliminary values to wD782/wD783.
; Uses inverted tile type C × 2 as index into data_00_1ff6_TileHitScriptTable — returns if null.
; Falls into TileHitScript_Run
    ld   A, [wD77D_BlockPatch_StepsRemaining]
    and  A, A
    ret  NZ
    ld   A, [wD77B_BlockPatch_VramWritePending]
    and  A, A
    ret  NZ
    ld   A, [wD76B_Player_IsAttacking]
    and  A, A
    ret  Z
    xor  A, A
    ld   [wD76B_Player_IsAttacking], A
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD782_BlockPatch_TargetBlockX], A
    ld   HL, wD210_Player_YPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD783_BlockPatch_TargetBlockY], A
    ld   L, C
    ld   H, $00
    add  HL, HL
    ld   DE, data_00_1ff6_TileHitScriptTable
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    or   A, H
    ret  Z
call_00_1f80_TileHitScript_Run:
; Also called directly by the mission preview cutscene system. Reads a callback function pointer (DE)
; and a step count byte from the script. If count is zero: skips block patch setup, jumps straight to
; calling DE (fire-and-forget). If nonzero: stores count to wD77D (sequence length), next byte
; to wD787 (timer reload), reads X/Y block offset into E/D, reads width/height into wD784/wD785,
; stores remaining script pointer to wD780/wD781. Computes the VRAM tilemap address for the patch
; rectangle from player Y (low byte masked $E0) shifted left 2 and D × 32, combined with player X low
; byte + E × 32 masked to $1C → stored to wD77E/wD77F. Recalculates wD782/wD783 as player block
; coords + D/E offset (the final target block coordinates for collision lookup).
; Zeroes wD786_BlockPatch_StepTimer. Pops and conditionally calls DE if nonzero
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
    push DE
    ld   A, [HL+]
    and  A, A
    jr   Z, .jr_00_1fef
    ld   [wD77D_BlockPatch_StepsRemaining], A
    ld   A, [HL+]
    ld   [wD787_BlockPatch_StepTimerReload], A
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
    ld   A, [HL+]
    ld   [wD784_BlockPatch_Width], A
    ld   A, [HL+]
    ld   [wD785_BlockPatch_Height], A
    ld   A, L
    ld   [wD780_BlockPatch_DataPtrLo], A
    ld   A, H
    ld   [wD781_BlockPatch_DataPtrHi], A
    ld   A, D
    add  A, A
    add  A, A
    add  A, A
    add  A, A
    add  A, A
    ld   HL, wD210_Player_YPositionLo
    add  A, [HL]
    and  A, $e0
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   A, E
    add  A, A
    add  A, A
    add  A, A
    add  A, A
    add  A, A
    ld   C, A
    ld   A, [wD20E_Player_XPositionLo]
    add  A, C
    rrca
    rrca
    rrca
    and  A, $1c
    or   A, L
    ld   [wD77E_BlockPatch_TilemapAddrLo], A
    ld   A, H
    add  A, $c0
    ld   [wD77F_BlockPatch_TilemapAddrHi], A
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    add  A, E
    ld   [wD782_BlockPatch_TargetBlockX], A
    ld   HL, wD210_Player_YPositionLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    add  A, D
    ld   [wD783_BlockPatch_TargetBlockY], A
    xor  A, A
    ld   [wD786_BlockPatch_StepTimer], A
.jr_00_1fef:
    pop  HL
    ld   A, L
    or   A, H
    call NZ, call_00_10bd_JumpHL
    ret
data_00_1ff6_TileHitScriptTable:
; Sparse pointer table of 63 entries, running from $1FF6 up to the first script at $2074 - 126
; bytes, which is what fixes the count. Null entries ($0000) mean nothing happens when that tile
; type is attacked, which is most of them.
;
; ------------------------------------------------------------------
; WHAT INDEXES THIS TABLE - it is the COLLISION TILE TYPE, never the block id
; ------------------------------------------------------------------
; PlayerAction_TailSpin reads wD764_TileTypeBehindGexsUpperBody, complements it, and only calls in
; when the result is under TILE_TYPE_INTERACTIVE_MIN_CPL - so the interactive range is tile type
; $C0 and up. TileHit_OnPlayerAttack then uses that complement x 2 as the offset into this table,
; which is why the entries run downward from $FF and why entry n is tile type $FF - n.
;
; The tile type is a property of the BLOCKSET, not of the blockmap. A blockset bank is four
; regions of 16 pages, all indexed by block id:
;
;   $4000-$4FFF  tile ids            $6000-$6FFF  tile types  <- this table's index
;   $5000-$5FFF  alt blockset tiles  $7000-$7FFF  alt blockset tile types
;
; The strip loaders walk both at once - `set 5, B` flips $40 to $60, which is the same block id
; read as graphics and then as collision. Sixteen pages because a block is 4x4 tiles, so each
; block carries sixteen tile types and an object can occupy part of a block.
;
; So a block id and a tile type are unrelated numbering schemes that happen to share 0-255.
; Reading the shipped blocksets:
;
;   $FB-$FF are block id == tile type in every blockset - the checkpoint tv and the four fly tvs.
;   That is an authoring convention for the last five block ids, not something the engine needs.
;
;   Nothing else matches. Scream TV reaches tile type $F5 from block $E7 and $F9 from block $CC;
;   Kung Fu reaches the cannons ($C6/$C7) from blocks $B7/$BD; Circuit Central points fourteen
;   different block ids at just two tile types.
;
;   Every interactive tile type in those blocksets lives in the ALT half ($7000-$7FFF). The
;   normal half carries none at all, which is why smashable objects always look like alt
;   blockset blocks.
;
; Note also that tile types are not private to this system. $F0 below is also
; TILE_TYPE_POWERED_SPRING_LOW, read by Player_GetJumpVelocity when Gex stands on it
;
; ------------------------------------------------------------------
; WHAT A NULL ENTRY ACTUALLY MEANS
; ------------------------------------------------------------------
; Only that the tail whip does nothing. It says nothing about the tile otherwise - but in
; this range there is nothing else to say, because every tile type $C0 and up has zero
; solidity rows and a zero flags byte in the bank 3 collision tables. The whole interactive
; range is walk-through decoration.
;
; Sweeping all eight shipped blocksets, 25 tile types in the interactive range are used:
;
;   21 have a script here - $FF-$F5, $F0, $DF, $CD, $C7-$C1. Every non-null entry in this
;   table is reached by some blockset; none of them are dead.
;
;   3 are null here but handled elsewhere: $CE and $CF are the plain springs and $F1 is
;   TILE_TYPE_POWERED_SPRING_HIGH, all read by Player_GetJumpVelocity. Note $F0 is NOT one
;   of these - it has a script as well as a spring meaning.
;
;   1 is null here and handled nowhere: $E9, in the Prehistory Channel alt blockset on
;   blocks $AD, $AE and $AF. No script, no comparison anywhere in the ROM, not solid. The
;   three blocks draw a palm tree, which looks like a climbable tree that got cut.
;
; ------------------------------------------------------------------
; THE TABLE IS ONE ENTRY SHORT OF THE RANGE THE GATE ADMITS
; ------------------------------------------------------------------
; TILE_TYPE_INTERACTIVE_MIN is $C0 and the gate lets $C0 through, but 63 entries only reach
; $C1. Tile type $C0 would index 126 bytes past the base, which lands on
; data_00_2074_TileHitScript_CheckpointTV_Left itself: its first word $208C is read as a
; script pointer, the callback's own opcodes are then read as a header (step count $D7), and
; the run ends by calling $8221 - an address in VRAM.
;
; No shipped blockset uses $C0, so this is unreachable today. It is a trap for anyone
; authoring a new one: either keep $C0 out of blockset collision data, or add a 64th entry
; ------------------------------------------------------------------
;
; Scripts come in pairs for multi-block objects: the two halves get separate table entries whose
; only difference is the x/y offset, so that hitting either half places the rectangle over the
; whole object. The five tvs pair $FF-$FB with $C5-$C1, CountedBreakable pairs $FA with $F5, and
; Breakable_Left/RightTile pairs $F7 with $F8.
;
; Every script below is written with the shared block patch macros from macros.asm -
; blockpatch_header, blockpatch_step, blockpatch_sfx, blockpatch_cells - which are the same ones
; the cutscene animations use, because it is the same format and the same runner underneath. The
; layout each macro emits is documented on the macro itself.
;
; Two things specific to this file:
;
;   The rectangle offsets are relative to THE TILE THAT WAS HIT, not to Gex. That is what lets a
;   two-block object be hit on either half - the pair of scripts differ only in the offset, so
;   the rectangle lands over the whole object either way.
;
;   A step count of 0 means fire-and-forget: TileHitScript_Run calls the callback and returns
;   without touching the block patch state at all. .data_00_2266_TileHitScript_KungFu_DoorSwitch
;   is the one script that does this.
dw data_00_2074_TileHitScript_CheckpointTV_Left               ; Collision Tile $FF
dw data_00_20d3_TileHitScript_FlyTV2_1                        ; Collision Tile $FE
dw data_00_20ff_TileHitScript_FlyTV_Health1                   ; Collision Tile $FD
dw data_00_211c_TileHitScript_FlyTV1_1                        ; Collision Tile $FC
dw data_00_2139_TileHitScript_FlyTV_Life1                     ; Collision Tile $FB
dw data_00_2156_TileHitScript_CountedBreakable_LowerTile      ; Collision Tile $FA
dw data_00_21ae_TileHitScript_SlotSwitch_Wide                 ; Collision Tile $F9
dw data_00_21c2_TileHitScript_Breakable_RightTile             ; Collision Tile $F8
dw data_00_21e4_TileHitScript_Breakable_LeftTile              ; Collision Tile $F7
dw data_00_2206_TileHitScript_SlotSwitch_Single               ; Collision Tile $F6
dw data_00_216e_TileHitScript_CountedBreakable_UpperTile      ; Collision Tile $F5
dw $0000                                                      ; Collision Tile $F4
dw $0000                                                      ; Collision Tile $F3
dw $0000                                                      ; Collision Tile $F2
dw $0000                                                      ; Collision Tile $F1
dw data_00_20eb_TileHitScript_FlyTV2_3                        ; Collision Tile $F0
dw $0000                                                      ; Collision Tile $EF
dw $0000                                                      ; Collision Tile $EE
dw $0000                                                      ; Collision Tile $ED
dw $0000                                                      ; Collision Tile $EC
dw $0000                                                      ; Collision Tile $EB
dw $0000                                                      ; Collision Tile $EA
dw $0000                                                      ; Collision Tile $E9
dw $0000                                                      ; Collision Tile $E8
dw $0000                                                      ; Collision Tile $E7
dw $0000                                                      ; Collision Tile $E6
dw $0000                                                      ; Collision Tile $E5
dw $0000                                                      ; Collision Tile $E4
dw $0000                                                      ; Collision Tile $E3
dw $0000                                                      ; Collision Tile $E2
dw $0000                                                      ; Collision Tile $E1
dw $0000                                                      ; Collision Tile $E0
dw data_00_2217_TileHitScript_PositionedSwitch                ; Collision Tile $DF
dw $0000                                                      ; Collision Tile $DE
dw $0000                                                      ; Collision Tile $DD
dw $0000                                                      ; Collision Tile $DC
dw $0000                                                      ; Collision Tile $DB
dw $0000                                                      ; Collision Tile $DA
dw $0000                                                      ; Collision Tile $D9
dw $0000                                                      ; Collision Tile $D8
dw $0000                                                      ; Collision Tile $D7
dw $0000                                                      ; Collision Tile $D6
dw $0000                                                      ; Collision Tile $D5
dw $0000                                                      ; Collision Tile $D4
dw $0000                                                      ; Collision Tile $D3
dw $0000                                                      ; Collision Tile $D2
dw $0000                                                      ; Collision Tile $D1
dw $0000                                                      ; Collision Tile $D0
dw $0000                                                      ; Collision Tile $CF
dw $0000                                                      ; Collision Tile $CE
dw data_00_2266_TileHitScript_KungFu_DoorSwitch               ; Collision Tile $CD
dw $0000                                                      ; Collision Tile $CC
dw $0000                                                      ; Collision Tile $CB
dw $0000                                                      ; Collision Tile $CA
dw $0000                                                      ; Collision Tile $C9
dw $0000                                                      ; Collision Tile $C8
dw data_00_22e7_TileHitScript_Cannon_FaceLeft                 ; Collision Tile $C7
dw data_00_22c9_TileHitScript_Cannon_FaceRight                ; Collision Tile $C6
dw data_00_2080_TileHitScript_CheckpointTV_Right              ; Collision Tile $C5
dw data_00_20df_TileHitScript_FlyTV2_2                        ; Collision Tile $C4
dw data_00_210b_TileHitScript_FlyTV_Health2                   ; Collision Tile $C3
dw data_00_2128_TileHitScript_FlyTV1_2                        ; Collision Tile $C2
dw data_00_2145_TileHitScript_FlyTV_Life2                     ; Collision Tile $C1

data_00_2074_TileHitScript_CheckpointTV_Left:
; The left half of a checkpoint tv. One step: smash the block to its broken state,
; register the change so it stays broken, and play the smash sound, all on the same
; frame. The callback is what actually banks the checkpoint
    blockpatch_header call_00_208c_Checkpoint_WriteSpawnId, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $fa,1
data_00_2080_TileHitScript_CheckpointTV_Right:
; The right half. Identical except for the block it leaves behind, so hitting either
; half smashes the tile under the hit and records the same checkpoint
    blockpatch_header call_00_208c_Checkpoint_WriteSpawnId, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $ea,1
call_00_208c_Checkpoint_WriteSpawnId:
; Searches .data_00_20b6_CheckpointBlockCoordTable for a record matching
; current level ID + wD782_BlockPatch_TargetBlockX + wD783_BlockPatch_TargetBlockY.
; On match: writes the record's 4th byte (checkpoint ID) to wD618_CheckpointSpawnId.
; Records are 4 bytes each: [level_id, block_x, block_y, checkpoint_id], $FF-terminated
    ld   hl,wD782_BlockPatch_TargetBlockX
    ld   c,[hl]
    ld   hl,wD783_BlockPatch_TargetBlockY
    ld   b,[hl]
    ld   hl,.data_00_20b6_CheckpointBlockCoordTable
    ld   de,$0004
.jr_00_209a:
    push hl
    ld   a,[wD624_CurrentLevelId]
    cp   [hl]
    jr   nz,.jr_00_20ae
    inc  hl
    ldi  a,[hl]
    cp   c
    jr   nz,.jr_00_20ae
    ldi  a,[hl]
    cp   b
    jr   nz,.jr_00_20ae
    ld   a,[hl]
    ld   [wD618_CheckpointSpawnId],a
.jr_00_20ae:
    pop  hl
    add  hl,de
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_00_209a
    ret
.data_00_20b6_CheckpointBlockCoordTable:
; Seven checkpoints, terminated by BLOCK_COORD_LIST_END. Checkpoint_WriteSpawnId matches
; on all three of level, block X and block Y, so the same block coordinates in a different
; level are not a checkpoint
    checkpoint_block MAP_TOON_TV_OUT_OF_TOON,                       $26, $3a, $01
    checkpoint_block MAP_SCREAM_TV_SMELLRAISER,                     $4b, $0a, $01
    checkpoint_block MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE,            $10, $15, $01
    checkpoint_block MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO,  $4d, $34, $01
    checkpoint_block MAP_TOON_TV_FINE_TOONING,                      $37, $56, $01
    checkpoint_block MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE,         $3f, $70, $01
    checkpoint_block MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO,        $0e, $34, $01
    block_coord_list_end

data_00_20d3_TileHitScript_FlyTV2_1:
    blockpatch_header call_00_20fa_HitFlyTV_Type2, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $fa,1
data_00_20df_TileHitScript_FlyTV2_2:
    blockpatch_header call_00_20fa_HitFlyTV_Type2, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $ea,1
data_00_20eb_TileHitScript_FlyTV2_3:
; The odd one out among the fly tvs: two steps rather than one, $28 frames apart, and
; it never registers - so the second block it draws is not preserved and the tv comes
; back on the next full map load
    blockpatch_header call_00_20fa_HitFlyTV_Type2, 2, 40, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX                    ; step 1/2
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $fa,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/2
    blockpatch_cells $9f,1
call_00_20fa_HitFlyTV_Type2:
    ld   a,$02
    jp   call_00_0647_Player_SwapFlyPowerup

data_00_20ff_TileHitScript_FlyTV_Health1:
    blockpatch_header call_00_2117_HitFlyTV_RestoreHealth, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $fa,1
data_00_210b_TileHitScript_FlyTV_Health2:
    blockpatch_header call_00_2117_HitFlyTV_RestoreHealth, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $ea,1
call_00_2117_HitFlyTV_RestoreHealth:
    ld   a,$03
    jp   call_00_0647_Player_SwapFlyPowerup

data_00_211c_TileHitScript_FlyTV1_1:
    blockpatch_header call_00_2134_HitFlyTV_Type1, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $fa,1
data_00_2128_TileHitScript_FlyTV1_2:
    blockpatch_header call_00_2134_HitFlyTV_Type1, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $ea,1
call_00_2134_HitFlyTV_Type1:
    ld   a,$01
    jp   call_00_0647_Player_SwapFlyPowerup

data_00_2139_TileHitScript_FlyTV_Life1:
    blockpatch_header call_00_2151_HitFlyTV_ExtraLife, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $fa,1
data_00_2145_TileHitScript_FlyTV_Life2:
    blockpatch_header call_00_2151_HitFlyTV_ExtraLife, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_TV_SMASH
    blockpatch_cells $ea,1
call_00_2151_HitFlyTV_ExtraLife:
    ld   a,$04
    jp   call_00_0647_Player_SwapFlyPowerup

data_00_2156_TileHitScript_CountedBreakable_LowerTile:
; A destructible 1x2 object that counts toward a per-level quota. 3 steps at 60
; frames, offset (0,-1) - the -1 marks this as the LOWER tile of the pair, since
; the rectangle has to start one block above the tile actually hit. The upper tile
; has the identical script at offset (0,0).
;
; Step 1's flags are $23 = LOOP | REGISTER | SFX, so it plays SFX $22, commits the
; change immediately, and falls straight into step 2 in the same frame. Registering
; on the FIRST step rather than the last is the opposite of the cutscene sequences,
; and it is why a destroyed object stays destroyed while its animation is still
; playing out
    blockpatch_header call_00_2186_CountedBreakable_OnHit, 3, 60, 0, -1, 1, 2
    blockpatch_step BLOCKPATCH_STEP_LOOP | BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_SFX ; step 1/3
    blockpatch_sfx  SFX_22
    blockpatch_cells $00,0
    blockpatch_cells $e2,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/3
    blockpatch_cells $d9,1
    blockpatch_cells $da,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 3/3
    blockpatch_cells $00,0
    blockpatch_cells $e2,1
data_00_216e_TileHitScript_CountedBreakable_UpperTile:
; Same script as the lower tile but offset (0,0). Both sit in the script table -
; indices 5 and 10 - so either half of the object can be hit
    blockpatch_header call_00_2186_CountedBreakable_OnHit, 3, 60, 0, 0, 1, 2
    blockpatch_step BLOCKPATCH_STEP_LOOP | BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_SFX ; step 1/3
    blockpatch_sfx  SFX_22
    blockpatch_cells $00,0
    blockpatch_cells $e2,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/3
    blockpatch_cells $d9,1
    blockpatch_cells $da,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 3/3
    blockpatch_cells $00,0
    blockpatch_cells $e2,1
call_00_2186_CountedBreakable_OnHit:
; Counts one more of these objects destroyed, and opens the way onward once the
; level's quota is met.
;
; The quota is level dependent: Smellraiser wants 5 and opens block patch slot 14,
; every other level wants 8 and opens slot 15. Hitting exactly the quota writes
; $02 into that slot, the "triggered" state - the same mechanism the toon tv
; hunters use through wD773_HuntersDefeatedCount.
;
; The comparison is `cp [hl]` against the running count, so it fires only on the
; exact hit; destroying more past the quota does not re-trigger it.
;
; The entity call is decoration only - a collisionless burst at the player's
; position. Nothing is spawned that the player can interact with
    ld   hl,wD772_BreakablesDestroyedCount
    inc  [hl]
    ld   c,$05
    ld   de,wD799_BlockPatch_SlotTable14
    ld   a,[wD624_CurrentLevelId]
    cp   a,MAP_SCREAM_TV_SMELLRAISER
    jr   z,.jr_00_219b
    ld   c,$08
    ld   de,wD79A_BlockPatch_SlotTable15
.jr_00_219b:
    ld   a,c
    cp   [hl]
    jr   nz,.jr_00_21a2
    ld   a,$02
    ld   [de],a
.jr_00_21a2:
    FARCALL call_00_3951_Entity_SpawnEffectAtPlayer
    ret

data_00_21ae_TileHitScript_SlotSwitch_Wide:
    blockpatch_header call_00_21bc_SlotSwitch_TriggerSlot0, 1, 0, -1, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_COLLISION | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/1
    blockpatch_sfx  SFX_26
    blockpatch_cells $c9,1, $ca,1
call_00_21bc_SlotSwitch_TriggerSlot0:
    ld   hl,wD78B_BlockPatch_SlotTable
    ld   [hl],$02
    ret

data_00_21c2_TileHitScript_Breakable_RightTile:
; Multi-stage breakable, no callback, 5 steps at 8 frames, 2x1 blocks, x offset -1
; so the rectangle covers the pair when the RIGHT half is hit.
;
; Worth noting the final step's flags are $0C = BLOCKPATCH_STEP_COLLISION |
; BLOCKPATCH_STEP_TILES, not the $0A the cutscene animations use. Bit 2 rewrites the
; collision block, so the last frame of the crumble is what actually makes the
; block passable - the four frames before it are cosmetic
    blockpatch_header 0, 5, 8, -1, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/5
    blockpatch_sfx  SFX_25
    blockpatch_cells $d3,1, $d4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/5
    blockpatch_cells $d1,1, $d2,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 3/5
    blockpatch_cells $cf,1, $d0,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 4/5
    blockpatch_cells $cd,1, $ce,1
    blockpatch_step BLOCKPATCH_STEP_COLLISION | BLOCKPATCH_STEP_TILES              ; step 5/5
    blockpatch_cells $cb,1, $cc,1
data_00_21e4_TileHitScript_Breakable_LeftTile:
; The same five frames at x offset 0, for when the left half is hit
    blockpatch_header 0, 5, 8, 0, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX ; step 1/5
    blockpatch_sfx  SFX_25
    blockpatch_cells $d3,1, $d4,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/5
    blockpatch_cells $d1,1, $d2,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 3/5
    blockpatch_cells $cf,1, $d0,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 4/5
    blockpatch_cells $cd,1, $ce,1
    blockpatch_step BLOCKPATCH_STEP_COLLISION | BLOCKPATCH_STEP_TILES              ; step 5/5
    blockpatch_cells $cb,1, $cc,1

data_00_2206_TileHitScript_SlotSwitch_Single:
    blockpatch_header call_00_2211_SlotSwitch_TriggerSlot0Alt, 1, 0, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_REGISTER | BLOCKPATCH_STEP_TILES               ; step 1/1
    blockpatch_cells $c7,1
call_00_2211_SlotSwitch_TriggerSlot0Alt:
    ld   hl,wD78B_BlockPatch_SlotTable
    ld   [hl],$02
    ret

data_00_2217_TileHitScript_PositionedSwitch:
    blockpatch_header call_00_2225_Switch_ArmSlotByPosition, 1, 8, 0, -1, 1, 2
    blockpatch_step BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX                    ; step 1/1
    blockpatch_sfx  SFX_1B
    blockpatch_cells $f8,1
    blockpatch_cells $f9,1
call_00_2225_Switch_ArmSlotByPosition:
; Arms the block patch slot belonging to THIS switch, identified by where it sits on
; the map rather than by any id in the script.
;
; Walks .data_00_2253_SwitchBlockCoordTable looking for a (block x, block y) pair
; matching the tile that was hit; the match's position in the table is the slot
; index. So the nine switches in the table each own one entry of
; wD78B_BlockPatch_SlotTable, and adding a switch means adding coordinates here.
;
; Already-nonzero slots return early, making the switch one-shot. Slot 6 is
; special-cased to $02 instead of $01 - it skips the armed state and goes straight
; to triggered
    ld   hl,wD782_BlockPatch_TargetBlockX
    ld   c,[hl]
    ld   hl,wD783_BlockPatch_TargetBlockY
    ld   b,[hl]
    ld   hl,.data_00_2253_SwitchBlockCoordTable
    ld   e,$00
.jr_00_2232:
    ldi  a,[hl]
    cp   c
    jr   nz,.jr_00_223a
    ld   a,[hl]
    cp   b
    jr   z,.jr_00_2242
.jr_00_223a:
    inc  hl
    inc  e
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_00_2232
    ret
.jr_00_2242:
    ld   d,$00
    ld   hl,wD78B_BlockPatch_SlotTable
    add  hl,de
    ld   a,[hl]
    and  a
    ret  nz
    ld   [hl],$01
    ld   a,e
    cp   a,$06
    ret  nz
    inc  [hl]
    ret
.data_00_2253_SwitchBlockCoordTable:
; Nine switch positions, terminated by BLOCK_COORD_LIST_END. A switch has no id of its
; own - its index here IS its wD78B_BlockPatch_SlotTable slot, so adding a switch means
; adding a line here and the order matters
    switch_block $25, $59   ; slot 0
    switch_block $2a, $59   ; slot 1
    switch_block $2f, $59   ; slot 2
    switch_block $47, $51   ; slot 3
    switch_block $54, $55   ; slot 4
    switch_block $5a, $55   ; slot 5
    switch_block $29, $4a   ; slot 6
    switch_block $39, $64   ; slot 7
    switch_block $10, $47   ; slot 8
    block_coord_list_end

data_00_2266_TileHitScript_KungFu_DoorSwitch:
; Kung Fu Theater door switch. The step count is ZERO, so TileHitScript_Run does nothing
; but call DoorSwitch_UpdateState - the switch changes state without any tile animation.
;
; The step below is still in the file and is byte-for-byte the one PositionedSwitch uses,
; but the runner returns before it reads any of it. Left in place because it is real data
; in the ROM, not because anything consumes it
    blockpatch_header call_00_2274_DoorSwitch_UpdateState, 0, 8, 0, 0, 1, 1
    blockpatch_step BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX                    ; step 1/1 - never read, step count is 0
    blockpatch_sfx  SFX_1B
    blockpatch_cells $f8,1, $f9,1
call_00_2274_DoorSwitch_UpdateState:
    ld   hl,wD782_BlockPatch_TargetBlockX
    ld   c,[hl]
    ld   hl,wD783_BlockPatch_TargetBlockY
    ld   b,[hl]
    ld   hl,.data_00_22a7_MaoTseTongue_DoorSwitchCoordTable
    ld   a,[wD624_CurrentLevelId]
    cp   a,MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    jr   z,.jr_00_2289
    ld   hl,.data_00_22b8_Other_DoorSwitchCoordTable
.jr_00_2289:
    ld   e,$00
.jr_00_228b:
    ldi  a,[hl]
    cp   c
    jr   nz,.jr_00_2293
    ld   a,[hl]
    cp   b
    jr   z,.jr_00_229b
.jr_00_2293:
    inc  hl
    inc  e
    ld   a,[hl]
    cp   a,$FF
    jr   nz,.jr_00_228b
    ret
.jr_00_229b:
    ld   d,$00
    ld   hl,wD78B_BlockPatch_SlotTable
    add  hl,de
    ld   a,[hl]
    and  a
    ret  nz
    ld   [hl],$02
    ret
.data_00_22a7_MaoTseTongue_DoorSwitchCoordTable:
; Door switch positions for Mao Tse Tongue. Index = wD78B_BlockPatch_SlotTable slot, same
; convention as the switch table above. Slots 0 and 4 are ($00,$00), which no real tile
; matches - they are holes in the numbering rather than switches
    switch_block $00, $00   ; slot 0
    switch_block $4c, $3a   ; slot 1
    switch_block $4b, $05   ; slot 2
    switch_block $44, $36   ; slot 3
    switch_block $00, $00   ; slot 4
    switch_block $32, $04   ; slot 5
    switch_block $5a, $30   ; slot 6
    switch_block $48, $0e   ; slot 7
    block_coord_list_end
.data_00_22b8_Other_DoorSwitchCoordTable:
; Door switch positions for every other level that has them. Eight entries, no holes
    switch_block $5e, $0d   ; slot 0
    switch_block $43, $1f   ; slot 1
    switch_block $4f, $1f   ; slot 2
    switch_block $05, $0f   ; slot 3
    switch_block $75, $04   ; slot 4
    switch_block $51, $1e   ; slot 5
    switch_block $73, $2d   ; slot 6
    switch_block $6e, $2d   ; slot 7
    block_coord_list_end

data_00_22c9_TileHitScript_Cannon_FaceRight:
; Rotating cannon, turning right: three frames $06 apart stepping the barrel through
; $b9/$ba, $bb/$bc, $bd/$be. No step registers, so the barrel angle is not preserved -
; the callback stores the facing in wD615_Cannon_FacingDirection instead
    blockpatch_header call_00_22e1_Cannon_FaceRight, 3, 6, 0, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX                    ; step 1/3
    blockpatch_sfx  SFX_CANNON_ROTATE
    blockpatch_cells $b9,1, $ba,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/3
    blockpatch_cells $bb,1, $bc,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 3/3
    blockpatch_cells $bd,1, $be,1
call_00_22e1_Cannon_FaceRight:
; Writes $20 to wD615_Cannon_FacingDirection. Sets rotating cannon to right state
    ld   a,$20
    ld   [wD615_Cannon_FacingDirection],a
    ret

data_00_22e7_TileHitScript_Cannon_FaceLeft:
; The same three frames turning the other way, from $bb/$bc back down to $b7/$b8
    blockpatch_header call_00_22ff_Cannon_FaceLeft, 3, 6, 0, 0, 2, 1
    blockpatch_step BLOCKPATCH_STEP_TILES | BLOCKPATCH_STEP_SFX                    ; step 1/3
    blockpatch_sfx  SFX_CANNON_ROTATE
    blockpatch_cells $bb,1, $bc,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 2/3
    blockpatch_cells $b9,1, $ba,1
    blockpatch_step BLOCKPATCH_STEP_TILES                                          ; step 3/3
    blockpatch_cells $b7,1, $b8,1
call_00_22ff_Cannon_FaceLeft:
; Writes $00 to wD615_Cannon_FacingDirection. Sets rotating cannon to left state
    ld   a,$00
    ld   [wD615_Cannon_FacingDirection],a
    ret

call_00_2305_BlockPatch_TickSlots:
; Scans all 16 wD78B_BlockPatch_SlotTable slots. For each slot with value ≥ 2: increments it.
; If the increment wraps to zero (overflowed from $FF): decrements back to $FF, checks wD77D
; and wD77B (if either nonzero, a sequence is busy — returns without triggering). Otherwise
; sets the slot to $01, re-arming it for the next attack. Slots with value 0 or 1 are skipped.
; This drives the per-frame countdown for triggered tiles (state $02 = just triggered, counts
; up to $FF = expired, then re-arms to $01 = active/waiting)
    ld   HL, wD78B_BlockPatch_SlotTable
    ld   B, $00
    ld   C, $00
.jr_00_230c:
    ld   A, [HL]
    cp   A, $02
    jr   C, .jr_00_2314
    inc  [HL]
    jr   Z, .jr_00_231c
.jr_00_2314:
    inc  HL
    inc  C
    ld   A, C
    cp   A, $10
    jr   NZ, .jr_00_230c
    ret
.jr_00_231c:
    dec  [HL]
    ld   A, [wD77D_BlockPatch_StepsRemaining]
    and  A, A
    ret  NZ
    ld   A, [wD77B_BlockPatch_VramWritePending]
    and  A, A
    ret  NZ
    ld   [HL], $01
