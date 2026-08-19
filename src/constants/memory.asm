SECTION "wram0", WRAM0[$c000]

wC000_BgMapTileIds:
; tiles currently loaded (for current 32x32 tile bg map)
    ds 1024                                               ;; c000

; ------------------------------------------------------------------
; Collectibles, four parallel 256-byte tables built by
; call_0b_4000_CollectibleList_LoadForCurrentLevel and consumed by
; call_03_6499_Collectible_BuildSprites.
;
; Coordinates are in 16x16-pixel grid cells, not pixels: the drawing code
; multiplies them back up with `swap`. Two cells make one block, so a
; 128x128-block level is exactly 256x256 cells - which is why a single byte
; addresses either axis and why these tables are 256 entries long.
;
; The last two tables exist purely so the per-frame draw never has to walk the
; whole list. Both are indexed by the camera's own cell column
; (wD6ED_BgMap_ScrollX >> 4), which lets the drawing code turn "which
; collectibles are on screen" into two array reads
; ------------------------------------------------------------------
wC400_Collectible_GridX:
; X cell of each collectible in the current level, sorted ascending, $FF ends the list
    ds 256                                             ;; c400
wC500_Collectible_GridY:
; Y cell of the matching wC400_Collectible_GridX entry. Set to $FF when the player
; picks the collectible up, which also stops it drawing: the draw loop keeps only
; entries whose (Y - camera row) is under 10 cells, and $FF can never pass that
    ds 256                                             ;; c500
wC600_Collectible_ScanStartByColumn:
; For each camera cell column, the index of the first collectible at or past that
; column. The list is sorted by X, so this is a precomputed lower bound - the draw
; loop starts here instead of searching
    ds 256                                             ;; c600
wC700_Collectible_ScanCountByColumn:
; For each camera cell column, how many collectibles fall in the 11 cells starting
; there. 11 cells is 176 pixels, one more than the screen is wide, so the count
; covers everything visible plus the partial cell at each edge. Zero means the draw
; routine returns immediately
    ds 256                                            ;; c700

wC800_CurrentCollisionData:
;C800 to CC00 is the collision data currently loaded (for current 32x32 tile bg map)
    ds 1024

; ------------------------------------------------------------------
; Shadow OAM ($CC00-$CC9F).
; call_00_0ef7_OamDmaRoutine (copied to hFF80_OamDmaRoutine) writes $CC to rDMA
; every vblank, so this whole 160-byte block is DMA'd into OAM.
; ------------------------------------------------------------------
wCC00_ShadowOAM:
    ds 1                                               ;; cc00

wCC01_ShadowOAM_EntitySprites:
; sprite slots used by the player and the loaded entities
    ds 95                                              ;; cc01

wCC60_ShadowOAM_CollectibleSprites:
; 8 sprite slots built by call_03_6499_Collectible_BuildSprites
    ds 32                                              ;; cc60

wCC80_ShadowOAM_HudSprites:
; 8 sprite slots built by call_03_5b5b_HUD_BuildSprites (fly icon, health, etc)
    ds 32                                              ;; cc80

; ------------------------------------------------------------------
; LCD STAT interrupt powered spring ($CCA0-$CCFC).
; isrLCDC does "jp wCCA0_LcdIsrCode", and call_00_0bb9_InstallLcdIsr copies one of
; the handler templates in bank 0 into this buffer. The handler is self-modifying:
; wCCA0_LcdIsrCode holds $D9 (reti = disabled) until something arms it by writing
; $F5 (push AF) there, and wCCA4/wCCA5/wCCA7 are the immediate operands of the
; copied code rather than ordinary variables.
; ------------------------------------------------------------------
wCCA0_LcdIsrCode:
    ds 4                                               ;; cca0
wCCA4_LcdIsr_SrcAddrLo:
; low byte of the "ld HL, nnnn" operand inside the copied handler.
; For the VRAM streaming handler this walks backwards through
; wD100_TilesToLoadBuffer, 4 bytes per hblank
    ds 1                                               ;; cca4
wCCA5_LcdIsr_SrcAddrHi:
; high byte of the same operand (always $D1 for the VRAM streaming handler)
    ds 1                                               ;; cca5
wCCA6_LcdIsr_CodeCont:
; opcode byte of the "ld D, n" that follows; not a variable
    ds 1                                               ;; cca6
wCCA7_LcdIsr_DestPageHi:
; operand of that "ld D, n" - the high byte of the VRAM page the handler writes to
; ($80/$81 player gfx, $82/$83 entity gfx, $86 media dimension tv, $90 tileset)
    ds 1                                               ;; cca7

    ds 85                                              ;; cca8

wCCFD_LcdIsrId:
; which LCD STAT handler is installed. Low 7 bits = handler id
; (see LCD_ISR_* in constants.asm), bit 7 = "already installed".
; call_00_0bae_RequestLcdIsr clears bit 7 to request a change and the vblank
; handler picks it up
    ds 1                                               ;; ccfd

wCCFE_VBlankHookPtrLo:
; pointer to the vblank-side routine that pairs with the installed LCD STAT
; handler; called every frame from the vblank isr
    ds 1                                               ;; ccfe
wCCFF_VBlankHookPtrHi:
    ds 1                                             ;; ccff

wCD00_BgTileFlags:
; updated when hit a checkpoint in a level, or a blood cooler
; or hidden smellraiser switch, etc.
    ds 256

wCE00_BgTileFlags:
; updated when hit a checkpoint in a level, or a blood cooler
; or hidden smellraiser switch, etc.
    ds 256

wCF00_TilesetPaletteIds:
; Will be modified when a secondary tileset is loaded
    ds 256                                             ;; cf00

wD000_EntityFlags:
; One byte per entry in the current level's entity list, indexed by the entry's
; position in that list. The spawner tests it with "and A / ret NZ", so any
; non-zero value blocks placement:
;   ENTITY_LIST_FLAG_ABSENT     ($00) not placed, free to be placed
;   ENTITY_LIST_FLAG_PLACED     ($01) currently occupying an entity slot
;   ENTITY_LIST_FLAG_NEVER_AGAIN($FF) defeated or collected - sticky, and the
;                                     reason a killed enemy stays killed
;
; Entry $00 is never used by a real list entry (the cursor starts at 1); it is
; the scratch entry that dynamically spawned entities point at
    ds 256                                             ;; d000

wD100_TilesToLoadBuffer:
; 256-byte staging buffer. Filled by call_00_08fc_StageNextGfxTransfer and then
; streamed into a single VRAM page by the LCD STAT handler, 4 bytes per hblank
    ds 256                                             ;; d100

; From D200 to D300 is the loaded entities space
; Each entity takes up 0x20 of space, and there can be up to 8 entities.
; Gex occupies the first slot. The entity instance fields are defined in constants.asm
wD200_EntityMemory:
wD200_Player_EntityId:
    ds 1                                               ;; d200
wD201_Player_ActionId:
    ds 1                                               ;; d201
wD202_Player_ActionFunc:
    ds 2                                               ;; d202
    ds 3
wD207_Player_SpriteCounter:
    ds 1                                               ;; d207
wD208_Player_SpriteID:
    ds 1                                               ;; d208
wD209_Player_ActionState:
    ds 1                                               ;; d209
wD20A_Player_SpriteFlags:
    ds 3                                               ;; d20a
wD20D_Player_FacingFlags:
    ds 1                                               ;; d20d
; wD20E_Player_XPositionLo and wD20F_Player_XPositionHi_PlayerXPosition control gex's x coordinate position (can freeze wD20F_Player_XPositionHi_PlayerXPosition to sometimes fall through floors)
wD20E_Player_XPositionLo:
    ds 1                                               ;; d20e
wD20F_Player_XPositionHi:
    ds 1                                               ;; d20f
; wD210_Player_YPositionLo and wD211_Player_YPositionHi control gex's y coordinate position (can freeze both to hover at fixed height)
; can also set to 0000 to warp to top of map for example
wD210_Player_YPositionLo:
    ds 1                                               ;; d210
wD211_Player_YPositionHi:
    ds 1                                               ;; d211
wD212_Player_ScreenXPosition:
    ds 1                                               ;; d212
wD213_Player_ScreenYPosition:
    ds 1
    ds 12                                              ;; d213

wD220_OtherLoadedEntities:
    ds 224                                             ;; d220

wD300_CurrentEntityAddrLo:
; addr of entity currently being updated
; if the entity instance starts at $D2E0, this value is E0, for example
    ds 1                                               ;; d300
wD301_EntityListIndexesForCurrentEntities:
; stores the entry number in the entity list, of all the currently loaded entities
; the values stored here have 1 added to them though. so index 0 would have value 1 here
    ds 8                                               ;; d301

wD309_EntityBoundingBoxXMax:
    ds 1                                               ;; d309
wD30A_EntityBoundingBoxXMin:
    ds 1                                               ;; d30a
wD30B_EntityBoundingBoxYMax:
    ds 1                                               ;; d30b
wD30C_EntityBoundingBoxYMin:
    ds 1                                               ;; d30c

    ds 28                                              ;; d30d

wD329_MapWindow_BlockXRangeMin:
    ds 1                                               ;; d329
wD32A_MapWindow_BlockXRangeMax:
    ds 1                                               ;; d32a
wD32B_MapWindow_BlockYRangeMin:
    ds 1                                               ;; d32b
wD32C_MapWindow_BlockYRangeMax:
    ds 1                                               ;; d32c

wD32D_Entity_OamAttrBase:
; One byte per entity slot, OR'd into every OAM attribute byte that slot writes.
; call_03_5ebf_Entity_BuildSprites reads it, combines it with the entity's own
; ENTITY_FIELD_FACING_FLAGS, and leaves the result in wD335_Entity_OamAttr.
;
; call_00_37e7_Entity_SetOamAttrBase is the only writer, and both of its call
; sites pass $01 - CGB OBJ palette 1 - for the particle-burst effect. Every
; other slot leaves it at $00, so in practice this is "is this slot the burst
; effect", expressed as a palette number
    ds 8                                               ;; d32d

wD335_Entity_OamAttr:
; Attribute byte for the entity currently being drawn: wD32D_Entity_OamAttrBase
; for its slot OR'd with ENTITY_FIELD_FACING_FLAGS. Each sprite writer ORs it
; again with the per-sprite attribute from the sprite record before storing it
; into shadow OAM
    ds 1                                               ;; d335

wD336_CurrentEntityToLoadPtr:
    ds 1                                               ;; d336
wD337_CurrentEntityToLoadPtr:
    ds 1                                               ;; d337
wD338_EntityLoadingFlag:
    ds 1                                               ;; d338

; Scratch used while call_0a_7a7c_EntitySpawn_SpawnNextFromList builds a slot
wD339_SpawningSlotIndex:
; slot number 1-7 of the free slot being filled, derived from the slot address
; by rotating rather than dividing. Indexes the per-slot bounding box table at
; wD309 and the list-index table at wD301
    ds 1                                               ;; d339

wD33A_SpawningListIndex:
; position of this entry within the level's entity list. Doubles as the index
; into wD000_EntityFlags, which is what stops an entity being spawned twice
    ds 1                                               ;; d33a

wD33B_SpawningEntityId:
; entity type read from the list entry, used to look up the 8-byte record in
; data_0a_75fd_EntityAttributeTable
    ds 1                                             ;; d33b

; ------------------------------------------------------------------
; Entity particle effects - two blocks per entity slot, reached through
; data_00_39c0_EntityEffectBuffers. The sprite lists run $D33C-$D443 and the particle
; buffers $D444-$D583, contiguously, one after the other.
;
; SPRITE LIST: a count byte then up to ENTITY_PARTICLE_COUNT OAM records
; (Y, X, tile, attributes). Written by the per-effect builders in bank03_oam_build.asm
; and drawn by the SPRITE_FLAG_EMBEDDED_SPRITE_DATA path
; ------------------------------------------------------------------
wD33C_Entity_SpriteList0:
    ds ENTITY_SPRITE_LIST_SIZE
wD35D_Entity_SpriteList1:
    ds ENTITY_SPRITE_LIST_SIZE
wD37E_Entity_SpriteList2:
    ds ENTITY_SPRITE_LIST_SIZE
wD39F_Entity_SpriteList3:
    ds ENTITY_SPRITE_LIST_SIZE
wD3C0_Entity_SpriteList4:
    ds ENTITY_SPRITE_LIST_SIZE
wD3E1_Entity_SpriteList5:
    ds ENTITY_SPRITE_LIST_SIZE
wD402_Entity_SpriteList6:
    ds ENTITY_SPRITE_LIST_SIZE
wD423_Entity_SpriteList7:
    ds ENTITY_SPRITE_LIST_SIZE

; PARTICLES: ENTITY_PARTICLE_COUNT records of ENTITY_PARTICLE_RECORD_SIZE - position
; and velocity per particle. Started by call_00_3a23_Entity_StartParticleEffect, ticked
; by call_00_3b8d_Entity_TickParticles, read by both the sprite builders and the
; per-particle hitbox checks in bank03_entity_collision.asm. Field offsets are the
; PARTICLE_FIELD_* constants
wD444_Entity_Particles0:
    ds ENTITY_PARTICLES_SIZE
wD46C_Entity_Particles1:
    ds ENTITY_PARTICLES_SIZE
wD494_Entity_Particles2:
    ds ENTITY_PARTICLES_SIZE
wD4BC_Entity_Particles3:
    ds ENTITY_PARTICLES_SIZE
wD4E4_Entity_Particles4:
    ds ENTITY_PARTICLES_SIZE
wD50C_Entity_Particles5:
    ds ENTITY_PARTICLES_SIZE
wD534_Entity_Particles6:
    ds ENTITY_PARTICLES_SIZE
wD55C_Entity_Particles7:
    ds ENTITY_PARTICLES_SIZE

wD584_CollisionFlagsPrev:
; copy of the value that wD585_CollisionFlags had at the start of the frame
    ds 1                                               ;; d584
wD585_CollisionFlags: ; aka player state flags
; Rebuilt every frame by call_03_4900_BgCollision_Update. See the BGCOLL_* constants.
; bit 7 (80) = BGCOLL_NO_COLLISION_BIT - grounded, climbing, standing on an entity, or
;              riding the rocket. All four mean the normal corrections do not apply
; bit 6 (40) = BGCOLL_WALL_BIT - ran into a wall this frame
; bits 3-0    BGCOLL_SLOPE_MASK - how many pixels of slope he needs to step up, counted
;              by probing along the path he is about to walk. Bank 2 applies it as an
;              equal upward nudge, which is the whole of the slope handling
    ds 1                                               ;; d585

wD586_PlayerGfxVramPage:
; 0 or 1. The player's 256-byte tile set is double buffered across VRAM pages
; $8000 and $8100; this selects which page the next streamed frame goes to and
; the sprite builder in bank 3 uses it to pick the matching tile ids
    ds 1                                               ;; d586
wD587_EntityGfxVramPage:
; same idea for the shared entity tile pages $8200 / $8300. It is also read
; straight out of bank03_sprite_frame_data.asm's shape lookup: the index into
; data_03_5566_SpriteShapeTable_Main is the SPRITE_SHAPE_* value OR'd with this
; and with the facing bit, so the two pages simply select between two copies of
; the same layout whose tile numbers are $10 apart
    ds 1                                               ;; d587
wD588_EntityGfxSrcAddrHi:
; high byte of the ROM address holding the entity tile page to stream in
    ds 1                                               ;; d588
wD589_EntityGfxSrcBank:
; ROM bank holding that entity tile page
    ds 1                                               ;; d589

wD58A_BankStack:
; stack of previously selected ROM banks, used by call_00_1089_SwitchBank /
; call_00_10a3_RestoreBank. wD59A_PtrToBankStackPosition points at the top
    ds 16                                              ;; d58a

wD59A_PtrToBankStackPosition:
; used to switch back to previous bank after loaded asset from a new bank (or ran code?)
    ds 2                                               ;; d59a
wD59C_CurrentROMBank:
    ds 1                                               ;; d59c
wD59D_ReturnBank:
; bank to return to after the upcoming bank switch
    ds 1                                               ;; d59d

wD59E_OnGBCFlag:
; $01 on a Colour Game Boy, $00 otherwise. Set once during boot, from the A = $11
; the CGB boot ROM leaves behind, and never written again.
;
; Mostly it gates colour-only work - VRAM bank 1 attribute writes, palette
; uploads, the 9800/9C00 map split. The three remote entities read it for a
; different reason: they use it to pick between two sets of sprite frames, because
; on a DMG there is no palette to tell a red remote from a gold one and the
; artwork has to do it instead. See call_02_5253_EntityAction_RedRemote_Dmg
    ds 1                                               ;; d59e

wD59F_RawInputs:
; The pad exactly as the hardware reports it, complemented so a set bit means held.
; Written in one place only - the joypad read at call_00_10be - and never filtered, so
; this is the physical truth about the buttons for the whole frame. Bits are the
; PADF_* values in hardware.inc.
;
; Menus, the CheckInput* predicates and the cutscene skip checks all read this. The
; player character does NOT: it obeys wD75A_Player_EffectiveInputs, which can disagree
    ds 1                                               ;; d59f

wD5A0_LCDCValue:
; shadow copy of rLCDC. Written to the real register at the start of every vblank
; so LCDC changes always take effect between frames
    ds 1                                               ;; d5a0

wD5A1_BgMap_ScrollXLo:
    ds 1                                               ;; d5a1
wD5A2_BgMap_ScrollYLo:
    ds 1                                               ;; d5a2

; Three Circuit Central conveyor belts, addressed as a 1-based array: an entity
; carries the belt number in MISC_TIMER_2 and indexes from wD5A3.
;
; Nothing here is a position or a speed - a slot is simply energised or not, and
; three separate systems read it:
;   .jr_03_5129_CollisionHandler_PoweredWalkway   writes $06 when Gex touches the
;       walkway with his power-up running. That is the only producer
;   bank03_animated_tiles.asm                     swaps the belt tiles for blank
;       ones while the slot is empty, which is the entire visual difference
;   call_02_6a3c_EntityAction_WalkwayActivator_Update  turns its collision box on
;       and off to match
wD5A3_ConveyorState1:
    ds 1                                               ;; d5a3
wD5A4_ConveyorState2:
    ds 1                                               ;; d5a4
wD5A5_ConveyorState3:
    ds 1                                               ;; d5a5

; ------------------------------------------------------------------
; Shared menu scratch. This region wears two hats depending on who is using it,
; which is worth knowing before trusting the names:
;
;   - call_01_4bd3_Text_WrapAndAlign copies the string being rendered here and
;     wraps it in place, so during text rendering the whole run is one string
;     buffer (hence wD5A6_TextBuffer, good until at least $D5CC)
;   - call_01_4dc8_Menu_BuildSpriteBlock and call_01_4e01_Menu_WriteSpriteRect
;     instead use the first four bytes as the OAM fields of the sprite currently
;     being emitted, and wD5AA as an indirection table of runtime tile ids
;
; Nothing uses both at once, but wD5A6 being read as a sprite Y coordinate in the
; sprite path is a genuine trap when reading that code
; ------------------------------------------------------------------
wD5A6_TextBuffer: ; goes until at least D5CC
; also the sprite Y coordinate in the sprite-block path
    ds 1                                               ;; d5a6

wD5A7_Sprite_X:
    ds 1                                               ;; d5a7

wD5A8_Sprite_TileId:
; stepped by 2 per sprite, since the menus run in 8x16 sprite mode
    ds 1                                               ;; d5a8

wD5A9_Sprite_Attributes:
    ds 1                                               ;; d5a9

wD5AA_Sprite_TileIdTable:
; runtime tile ids for sprite scripts. If bit 0 of a script's tile byte is set,
; the byte >> 1 indexes here instead of being a literal tile - which is how a
; fixed script draws digits and icons that change as you play
    ds 96                                              ;; d5aa

wD60A_OneCharString:
; a two-byte string built on the fly: the character, then $80 to end the line.
; call_01_48fd_MenuCmd_SetPasswordCharText uses it to render one password cell
; through the normal text path without needing a string in ROM for every letter
    ds 1                                               ;; d60a
wD60B_OneCharStringEnd:
; the $80 line terminator call_01_48fd_MenuCmd_SetPasswordCharText writes after the
; character in wD60A, making the pair a complete one-character string. The two bytes
; after it are unused padding
    ds 3                                               ;; d60b

wD60E_HUDDirtyFlags:
; bit 1 (02) = lives counter changed, reload the lives digits
; bit 2 (04) = level timer changed, reload the timer digits
; bit 3 (08) = collectible milestone changed, reload the collectible sprites
    ds 1                                               ;; d60e

wD60F_GfxTransferFlags:
; queue of pending VRAM transfers, serviced in priority order (bit 0 first).
; See GFX_XFER_* in constants.asm
; bit 0 (01) = player sprite page
; bit 1 (02) = entity sprite page
; bit 2 (04) = secondary tileset
; bit 3 (08) = queued entity graphics (wD71F_GfxCopy_SrcBank block)
; bit 4 (10) = media dimension tv screen image
; bit 7 (80) = an hblank-driven transfer is currently running
    ds 1                                               ;; d60f

wD610_MediaDimension_TVScreenId:
; which tv screen image is being shown in the hub. $FF = none.
; Used as a page index into bank $14 and copied to VRAM $8600
    ds 1                                               ;; d610

wD611_AnimatedTileId:
    ds 1                                               ;; d611
wD612_AnimatedTime_FrameCounter:
    ds 1                                               ;; d612

wD613_Dragon_SegmentsRemaining:
; Kung Fu Theater dragon boss. Set to $0A on level start; the boss's health lives
; here rather than in any entity, because the dragon is a head plus a string of
; body segments that all read it.
;
; Only one thing decrements it: call_02_5efa_EntityAction_CannonProjectile_Fly,
; when a cannon shot passes within 8 screen pixels of the dragon's HEAD. Gex never
; damages the dragon directly - he aims the cannon with the tile blocks beside it
; and stomps it to fire. At zero every part of the dragon bursts and the head opens
; wD78F_BlockPatch_SlotTable4
    ds 1                                               ;; d613
wD614_Dragon_HitTimer:
; Set to $80 by a cannon hit. Bit 1 drives SPRITE_FLAG_INVISIBLE through
; call_02_613f_Dragon_UpdateHitFlash, so the whole dragon strobes in 2-frame
; blocks while it runs.
;
; It is decremented by call_02_5f50_EntityAction_DragonBodySegment_Update - i.e.
; once per body segment per frame - so the flash runs N times faster with N
; segments alive, and visibly lengthens as the boss is whittled down
    ds 1                                               ;; d614
wD615_Cannon_FacingDirection:
; Which way the Kung Fu Theater cannon is pointing, as an OAM facing byte ($00
; right, $20 left). Not owned by the cannon entity: the rotating blocks beside it
; are tile hit scripts, and their callbacks (call_00_22e1_Cannon_FaceRight /
; call_00_22ff_Cannon_FaceLeft in bank00_tile_hit_scripts.asm) write it. The
; cannon reads it only at the instant it fires, so aiming and firing are two
; separate things the player does to two different objects
    ds 1                                               ;; d615
wD616_FinalBattleButtonFlags:
; The whole state of the Channel Z final battle, in one byte with two fields.
;
;   bits 0-6  how many more button slams Rez needs before he dies. Rez writes $0A
;             here himself on his first frame, so the fight length is set by the
;             boss rather than by level data
;   bit 7     one-shot "a slam just landed" pulse
;
; The producer and consumer never touch each other:
; call_02_6d5d_EntityAction_FinalBattleButtonProjectile_Fall raises bit 7 when the
; thing a button dropped reaches the arena floor, and
; call_02_6ca7_Rez_CheckButtonSlam consumes it and takes one off the count. At
; zero Rez drops the exit portal and bursts.
;
; call_02_6d80_EntityAction_FinalBattleButton_Ready also reads the low bits, so
; once the count is zero the buttons stop responding
    ds 1                                               ;; d616
wD617_TailSpinChargeCounter:
; Rezopolis machinery power, 0 to $40. One producer and two consumers, all in
; bank02_entity_actions.asm; bank00_home.asm only zeroes it on level entry.
;
; ENTITY_REZOPOLIS_TAILSPIN_GEAR has five speed actions, and only the top one
; (call_02_65db_EntityAction_TailspinGear_Full) raises this - the other four lower
; it by one a frame. Since the gear only steps up while Gex is actively tail
; spinning on it, the counter measures how long he has held it flat out, and it
; bleeds away the moment he stops.
;
; Both consumers test for the maximum rather than for any particular level:
;   call_02_650f_EntityAction_ActivatedRedPlatform_Update  runs its rise/hold/fall
;   call_02_666c_EntityAction_AntSpawner_Update            produces an ant
    ds 1                                               ;; d617

wD618_CheckpointSpawnId:
; which of the level's CHECKPOINTS_PER_LEVEL spawn slots the player respawns at.
; Reset to 0 when a level is entered, and raised by
; call_00_208c_Checkpoint_WriteSpawnId when a checkpoint TV block is smashed - the
; block's coordinates are looked up in .data_00_20b6_CheckpointBlockCoordTable, which
; is what turns a particular block in a particular level into a checkpoint id.
; Read only by call_0b_4efe_Player_SetSpawnPosition
    ds 1                                               ;; d618

wD619_MenuTimeoutLo:
; low byte of the menu timeout, decremented once per frame by
; call_01_4000_MenuLoad. Reloaded with MENU_TIMEOUT_LO / MENU_TIMEOUT_HI every time
; the screen is redrawn, so the clock only really runs while the player is idle.
; Not title screen specific - every menu counts down, it is just that most of them
; also set MENU_FLAG_WAIT_FOR_INPUT and so never look at the result
    ds 1                                               ;; d619
wD61A_MenuTimeoutHi:
; high byte of the same counter; the pair expiring is what returns
; MENU_RESULT_TIMED_OUT, which on the title screen is what starts the attract demo
    ds 1                                               ;; d61a
wD61B_DemoInputsPointer:
; pointer to current demo mode inputs
    ds 1                                               ;; d61b
wD61C_DemoInputsPointer:
; pointer to current demo mode inputs
    ds 1                                               ;; d61c
wD61D_AttractDemoIndex:
; Which of the four attract-mode demos to play, 0-3. Indexes both
; data_00_076d_DemoLevelIds (the level) and data_00_0771_DemoInputScriptPointers
; (the recorded inputs).
;
; In practice it is always 2 - Samurai Night Fever. The code at 00:0276 computes the
; round-robin "(current + 1) AND 3" into A and then immediately overwrites A with
; $02 before storing it, so the increment is dead and the other three demos are
; unreachable. The $03 written here at boot is likewise overwritten before it is
; ever used to pick anything
    ds 1                                               ;; d61d
wD61E_DemoModeEnabled:
    ds 1                                               ;; d61e
wD61F_Demo_FramesUntilNextInput:
; Frames left to hold the button state currently in wD620_DemoInputs. The demo
; script is run-length encoded as (frame count, button bits) pairs;
; call_02_4939_Player_UpdateMain decrements this every frame and, when it reaches
; zero, pulls the next pair - reloading this from the new count and the buttons into
; wD620_DemoInputs. A count of $FF instead ends the demo and returns to the title.
;
; Seeded to 1 when a demo starts, so the very first pair is fetched on frame one
    ds 1                                               ;; d61f
wD620_DemoInputs:
; demo inputs that are being played currently
    ds 1                                               ;; d620

wD621_WarpFlags:
; bit 7 (80) =
; bit 6 (40) =
; bit 5 (20) =
; bit 4 (10) = time up in a bonus/collectible level
; bit 3 (08) = entered door
; bit 2 (04) = entered tv / collected gold remote
; bit 1 (02) = died
; bit 0 (01) =
    ds 1                                               ;; d621

wD622_InterruptFlag:
; gets set when an interrupt occurs. used when waiting for an interrupt
    ds 1                                               ;; d622

wD623_CollectibleMode:
; nonzero in the bonus levels that have a collectible quota and a countdown timer
    ds 1                                               ;; d623

wD624_CurrentLevelId:
    ds 1                                               ;; d624
wD625_TotalsMenuPage:
; which page you are on in the totals menu
    ds 1                                               ;; d625
wD626_MissionSelect_OptionCount:
; how many missions the level you are entering actually offers. Counted by
; call_01_4297_MenuLoad_MissionSelect, which asks call_00_2e5f_MapData_GetMissionText
; for each of the MISSION_SLOTS_PER_LEVEL slots and skips any whose first byte has
; bit 7 set (an empty string). The count then picks the menu type directly:
; MENU_TYPE_MISSION_SELECT_1_OPTION + count - 1, which is why the three mission
; select screens exist as separate menu types at all
    ds 1                                               ;; d626
wD627_CurrentMission:
; which mission you selected when entered a level
    ds 1                                               ;; d627
wD628_MediaDimensionRespawnPoint:
; which TV the player steps back out of when they return to the hub - an index into
; .data_0b_5401_MediaDimensionSpawnPoints, not a level id.
;
; Written in bank02 when a TV is entered, as (entity list index - 1) / 2 of the TV
; entity itself, so the hub spawn table is really indexed by TV entity rather than by
; destination. Also what MENU_OPTION_CONFIRM_QUIT uses to decide where quitting a
; level puts you back
    ds 1                                               ;; d628
wD629_RemoteProgressFlags:
; one byte per level. Bit meanings (see REMOTE_*_MASK in constants.asm):
;   bits 0-2 (07) = mission remotes collected (one per selectable mission)
;   bit  3   (08) = hidden (silver) remote collected
;   bit  4   (10) = gold remote collected
;   bit  5   (20) = bonus/collectible mission completed
    ds 30                                              ;; d629
; D62A : out of toon obtained remotes bitfield (1F = all)
; D62B : smellraiser obtained remotes bitfield (1F = all)
; D62C : frankensteinfeld obtained remotes bitfield (1F = all)
; D62D : www.dotcom.com obtained remotes bitfield (1B = all)
; D62E : moa tse tongue obtained remotes bitfield (1B = all)
; D62F : unused
; D630 : pangaea 90210 obtained remotes bitfield (1B = all)
; D631 : fine tooning obtained remotes bitfield (1B = all)
; D632 : this old cave obtained remotes bitfield (1F = all)
; D633 : honey I shrunk the gecko obtained remotes bitfield (1F = all)
; D634 : poltergex obtained remotes bitfield (1F = all)
; D635 : unused
; D636 : samurai night fever obtained remotes bitfield (1F = all)
; D637 : no weddings and a funeral obtained remotes bitfield (19 = all)
; D638 : unused
; D639 : thursday the 12th obtained remotes bitfield (20 = all)

; D63E : lizard in a china shop obtained remotes bitfield (20 = all)
; D63F : bugged out obtained remotes bitfield (20 = all)
; D640 : chips and dips obtained remotes bitfield (20 = all)
; D641 : lava daba doo obtained remotes bitfield (01 = all)
; D642 : texas chainsaw manicure obtained remotes bitfield (01 = all)
; D643 : mazed and confused obtained remotes bitfield (03 = all)

wD647_ExitTVButtonIndex:
; which exit tv button (0-2) the player pushed to finish the level.
; Selects which mission remote bit gets awarded in wD629_RemoteProgressFlags
    ds 1                                               ;; d647

wD648_CollectibleMilestoneIndex:
; index into .data_00_074a_CollectibleMilestoneThresholds (30 / 40 / 50)
    ds 1                                               ;; d648

wD649_CollectibleAmount:
; in a bonus level this counts down toward zero (the remaining quota);
; otherwise it counts up toward the next milestone.
;
; Two entities read it as "is the bonus quota still outstanding", and between them
; they are the whole structure of a bonus level:
;   call_02_666c_EntityAction_AntSpawner_Update  keeps producing while it is non-zero
;   call_02_5297_EntityAction_GoldRemote_Gbc     removes itself while it is non-zero,
;                                                so the prize appears at exactly zero
    ds 1                                               ;; d649

; wD649_CollectibleAmount split into two decimal digits for the HUD, by
; call_03_6d5e_HUD_LoadCollectibleCountDigits. Only ever 0-9, or $0A.
;
; $0A is not a digit: the digit font has eleven 16-byte glyphs and the eleventh is
; blank. Both bytes are preloaded with it, and a count under ten leaves the tens
; byte untouched - so leading-zero suppression is just "never overwrite the blank"
wD64A_HUD_CollectibleCountTens:
    ds 1                                               ;; d64a

wD64B_HUD_CollectibleCountOnes:
    ds 1                                               ;; d64b

wD64C_CurrentLevel_HiddenRemoteFlags:
; the current level's silver+gold remote bits (wD629 & $18), snapshotted on entry
; and OR'd back in when the level is completed
    ds 1                                               ;; d64c

; ------------------------------------------------------------------
; Where the collectible grid lands in shadow OAM this frame. Recomputed once per
; frame at the top of call_03_6499_Collectible_BuildSprites, then added to every
; sprite it places, so the whole grid scrolls smoothly instead of jumping a whole
; cell at a time.
;
; Collectible coordinates are 16x16-pixel cells (see wC400_Collectible_GridX), and
; the draw loop only has the cell offset from the camera - cell * 16 is therefore
; accurate to the nearest cell. These two carry the leftover sub-cell pixels of the
; scroll, plus the constant that turns a screen position into an OAM one
; ------------------------------------------------------------------
wD64D_Collectible_OamOriginX:
; $0C - (wD6ED_BgMap_ScrollX AND $0F). Net effect: OAM X = cell * 16 - scrollX + $0C,
; so the 8-pixel sprite sits 4 pixels in from the left edge of its 16-pixel cell
    ds 1                                               ;; d64d

wD64E_Collectible_OamOriginY:
; $10 - (wD6EF_BgMap_ScrollY AND $0F). Net effect: OAM Y = cell * 16 - scrollY + $10,
; which is exactly the top edge of the cell once OAM's 16-pixel Y bias is removed
    ds 1                                               ;; d64e

; The three totals below are recomputed by call_00_3c3f_Remotes_RecountAllTotals.
; Low 7 bits = the count, bit 7 = the count changed since the last recount
; (used by the hub to pop open newly unlocked tvs).
wD64F_MissionRemoteTotal:
; number of mission remotes collected across every level (mask $07)
    ds 1                                               ;; d64f
wD650_HiddenRemoteTotal:
; number of hidden + gold remotes collected across every level (mask $18)
    ds 1                                               ;; d650
wD651_BonusMissionTotal:
; number of bonus/collectible missions completed across every level (mask $20)
    ds 1                                               ;; d651

; ------------------------------------------------------------------
; Password payload, in two mirrored 10-byte copies: wD652 is what gets ENCODED
; into a password to show the player, wD65C is what a typed password DECODES to.
; Same layout both sides - 8 bytes of packed progress, then lives, then a
; checksum - which is what makes the two halves verifiable against each other.
;
; 8 bytes = 64 progress bits + 8 lives bits + 8 checksum bits = 80, and the
; password carries 28 boxes x 3 bits = 84, so there are four spare bits
; ------------------------------------------------------------------
wD652_Password_EncodeBuffer:
; packed progress, built by call_01_4349_Password_BuildPayload by walking every level
; and folding wD629_RemoteProgressFlags through a per-level mask
    ds 8                                               ;; d652
wD65A_Password_EncodeLives:
    ds 1                                               ;; d65a
wD65B_Password_EncodeChecksum:
; sum of the 9 bytes above, truncated to 8 bits
    ds 1                                               ;; d65b

wD65C_Password_DecodeBuffer:
; the decode side of the same struct, filled by call_01_5271_Password_DecodeAndApply
    ds 8                                               ;; d65c
wD664_Password_DecodeLives:
    ds 1                                               ;; d664
wD665_Password_DecodeChecksum:
; a typed password is rejected unless the sum of the 9 preceding bytes matches
    ds 2                                               ;; d665

wD667_PasswordExitButton: ; Password exit button (value 49)
    ds 1                                               ;; d667
wD668_PasswordValues: ; password on call screen and in game
; 20 is blank
; solid color arrows: 45 right, 46 left, 47 up, 48 down
; outlined arrows:  41 right, 42 left, 43 up, 44 down
; bug: the first time you enter a value after going into the "enter password" screen,
; it updates the value, but not visually
    ds 28                                              ;; d668
wD684_PasswordGoButton: ; PASSWORD_KEY_GO - cell $1D, submits what has been typed
    ds 1                                               ;; d684
wD685_PasswordUnkButton:
; PASSWORD_KEY_UNKNOWN - cell $1E. Drawn only by
; data_01_58ca_MenuScript_ViewPassword, which has nothing to submit, so this is the
; key that sits where GO would be on the read-only password screen
    ds 1                                               ;; d685

wD686: ; unused except set to 0?
    ds 1                                               ;; d686

wD687_FlyAnimationState:
    ds 1                                               ;; d687
wD688_FlyAnimationPosition:
    ds 1                                               ;; d688
wD689_FlyAnimationTimer:
    ds 1                                               ;; d689

; ------------------------------------------------------------------
; The active menu's 8-byte record, copied here from data_01_5574_MenuTypeRecords
; by call_01_4000_MenuLoad. Every screen in the game runs the same loop; this
; block is the only thing that makes them behave differently
; ------------------------------------------------------------------
wD68A_Menu_ScriptPtr:
; field +0 of the record: a pointer to the menu's script - the list of draw commands
; that builds the screen, walked by call_01_446f_LoadMenuGraphics
    ds 2                                               ;; d68a
wD68C_Menu_Flags:
; see MENU_FLAG_* in constants.asm
    ds 1                                               ;; d68c
wD68D_Menu_OptionCount:
; number of selectable rows, or for the password keyboard the total number of
; cells ($1E = 6 x 5). Zero means the screen has nothing to select and only
; waits to be dismissed
    ds 1                                               ;; d68d
wD68E_Menu_CursorBaseX:
; screen position of the cursor at row 0 / column 0, and the step it moves by.
; call_01_4d72_Menu_DrawCursor multiplies the step by the selected row/column
; rather than keeping a coordinate, which is why menus never scroll
    ds 1                                               ;; d68e
wD68F_Menu_CursorBaseY:
    ds 1                                               ;; d68f
wD690_Menu_CursorStepX:
    ds 1                                               ;; d690
wD691_Menu_CursorStepY:
    ds 1                                               ;; d691
; end of the copied menu record

; ------------------------------------------------------------------
; Menu command descriptor + text renderer state.
;
; wD692..wD697 are copied from an 8-byte descriptor in data_01_5324_MenuCmd_Descriptors, selected by
; the command id; wD698..wD69E are the seven parameter bytes that follow the id in
; the menu script. call_01_44e6_MenuScript_RunCommand does both copies, so the same
; six bytes mean slightly different things per command - the names below are how
; the text path (call_01_4a8f_Text_Render and friends) uses them, which is the only
; consumer that reads them all.
; ------------------------------------------------------------------
wD692_Text_BlockWidthTiles:
; width of the destination tile block. Also the row stride in the wC000 staging
; buffer: +$10 steps one tile right, +wD692*$10 steps one tile down
    ds 1                                               ;; d692

wD693_Text_BlockHeightTiles:
; height of the destination tile block. Together with wD692 this gives both the
; tilemap rectangle to fill and, times $10, the number of bytes of tile graphics
    ds 1                                               ;; d693

wD694_MenuCmd_DestTileX:
; destination in the tilemap, in tiles. call_01_44e6_MenuScript_RunCommand forms
; the address as _SCRN0 + DestTileY * 32 + DestTileX
    ds 1                                               ;; d694

wD695_MenuCmd_DestTileY:
    ds 1                                               ;; d695

wD696_MenuCmd_FirstTileId:
; tile id written into the top-left cell of the rectangle; the fill increments it
; per cell, so a command hands out a run of consecutive ids. Also reused as a
; scratch copy of wD69A_Text_FontId by call_01_4e78_Menu_StageTileData
    ds 1                                               ;; d696

wD697_MenuCmd_CgbAttributes:
; CGB attribute byte written across the rectangle in VBK 1, or $FF meaning "use
; call_00_08b1_MediaDimension_CopyTVAttributes instead of a flat fill". Ignored
; entirely on DMG
    ds 1                                               ;; d697

wD698_Text_PenX:
; pen X within the block, in PIXELS. $FE as the incoming parameter means "centre
; this line", which call_01_4a8f_Text_Render resolves by measuring the string
    ds 1                                               ;; d698
wD699_Text_PenY:
; pen Y within the block, in PIXELS. $FE means "distribute the lines evenly down
; the block", resolved in call_01_4bd3_Text_WrapAndAlign
    ds 1                                               ;; d699
wD69A_Text_FontId:
; which of the four descriptors in data_01_65fe_FontDescriptors to use - but only
; for parameter blocks that actually draw text. The byte is overloaded: the staging
; sub-handlers (call_01_4e78_Menu_StageTileData, call_01_466b_MenuCmd_StageTVScreen)
; read it as the destination tile id instead, and
; call_01_4879_MenuCmd_DrawRemoteIcons reads it as a sprite-hide delay in frames.
; Nothing distinguishes the three uses except which handler the block reaches
    ds 1                                               ;; d69a
wD69B_Text_SrcPtrLo:
; the string being rendered. call_01_4e6f_Menu_SetScriptSrcPtr writes this pair
    ds 1                                               ;; d69b
wD69C_Text_SrcPtrHi:
    ds 1                                               ;; d69c

wD69D_MenuCmd_OptionSlot:
; low nibble = selectable row index, high nibble = MENU_OPTION_* code; filed into
; wD6C5_Menu_OptionActions by call_01_44e6_MenuScript_RunCommand
    ds 1                                               ;; d69d
wD69E_MenuCmd_Flags:
; MENUCMD_* bits controlling what this parameter block actually does
    ds 1                                               ;; d69e

wD69F_Font_GlyphBase:
; the five fields below are the font descriptor, copied by call_01_4a8f_Text_Render
    ds 2                                               ;; d69f
wD6A1_Font_WidthTable:
; one advance width in pixels per glyph, indexed the same as the bitmaps
    ds 2                                               ;; d6a1
wD6A3_Font_GlyphWidthCols:
; glyph width in 8px columns
    ds 1                                               ;; d6a3
wD6A4_Font_GlyphHeightPx:
; glyph height in PIXELS - 6, 7, 11 or 16, never 8, which is why the font bitmaps
; have no tile structure and cannot go through rgbgfx
    ds 1                                              ;; d6a4

; ------------------------------------------------------------------
; Parameter block for call_00_07c3_Screen_LoadTilesAndTilemap.
; The 10 bytes wD6A5..wD6AE are copied in one go from a ROM descriptor
; (see .data_01_47b9_ScreenTable and friends) before the call.
; ------------------------------------------------------------------
wD6A5_ScreenDraw_TileDataBank:
    ds 1
wD6A6_ScreenDraw_FirstTileId:
; tile id the graphics get loaded at; also added to every tilemap byte
    ds 1
wD6A7_ScreenDraw_WidthInTiles:
    ds 1
wD6A8_ScreenDraw_HeightInTiles:
    ds 1
wD6A9_ScreenDraw_TilemapPtr:
; ROM pointer to width*height tile indices, immediately followed by the same
; number of GBC attribute bytes
    ds 2
wD6AB_ScreenDraw_TileDataPtr:
; ROM pointer to the tile graphics
    ds 2
wD6AD_ScreenDraw_TileDataSize:
; number of bytes of tile graphics to copy
    ds 2
wD6AF_ScreenDraw_TileIdBase:
; working copy of wD6A6_ScreenDraw_FirstTileId used while writing the tilemap
    ds 1

; Menu related memory starts here
wD6B0_FullscreenImage_Bank:
; parameters for call_00_084d_Screen_LoadFullscreenImage (title/credit screens)
    ds 1                                               ;; d6b0
wD6B1_FullscreenImage_Ptr:
; ROM pointer to $F00 bytes of tiles, then $780 more, then a 20x18 attribute map
    ds 2                                               ;; d6b1
wD6B3_MenuScript_PtrLo:
; read/write cursor into the current menu script. call_01_44e6 pulls one
; command from here at a time and advances it, and LoadMenuGraphics can point
; it at a different script mid-run to chain screens together
    ds 1                                               ;; d6b3
wD6B4_MenuScript_PtrHi:
    ds 1                                               ;; d6b4
wD6B5_Text_DestPtrLo:
; write cursor into the wC000 staging buffer, pointing at the current glyph
; column's top row. call_01_4ae7_Text_DrawGlyph saves and restores it per column
    ds 1                                               ;; d6b5
wD6B6_Text_DestPtrHi:
    ds 1                                               ;; d6b6
wD6B7_Text_GlyphPtrLo:
; read cursor into the font bitmap, advanced two bytes per pixel row as the glyph
; is drawn. Set up by call_01_4cab_Text_SelectGlyph
    ds 1                                               ;; d6b7
wD6B8_Text_GlyphPtrHi:
    ds 1                                               ;; d6b8
; ------------------------------------------------------------------
; Sprite descriptor for the menu cursor, laid out so that
; call_01_4d72_Menu_DrawCursor can fill in the position and then hand the whole
; block straight to call_01_4dc8_Menu_BuildSpriteBlock as a script
; ------------------------------------------------------------------
wD6B9_MenuCursor_OamSlot:
; entries $10-$12 of data_01_5aa9_SpriteScriptTable point here rather than into ROM,
; so "erase the cursor group" and "draw the cursor" go through the same code path
    ds 1                                               ;; d6b9
wD6BA_MenuCursor_Y:
    ds 1                                               ;; d6ba
wD6BB_MenuCursor_X:
    ds 1                                               ;; d6bb
wD6BC_MenuCursor_TileId:
    ds 1                                               ;; d6bc
wD6BD_MenuCursor_Attributes:
    ds 1                                               ;; d6bd
wD6BE_MenuCursor_WidthInColumns:
; taken from the staged image's own width, in 8px columns
    ds 1                                               ;; d6be
wD6BF_MenuCursor_HeightInTileRows:
; height in 8px tile rows - call_01_4e01_Menu_WriteSpriteRect halves it to get a
; count of 8x16 sprites. Same units as a sprite script's height field, and taken
; straight from the staged image's own height
    ds 1                                               ;; d6bf
wD6C0_MenuCursor_ScriptEnd:
; only ever written, always $FF - the terminator that lets the descriptor above be
; handed to call_01_4dc8_Menu_BuildSpriteBlock as if it were a sprite script
    ds 1                                               ;; d6c0
wD6C1_Menu_CursorSpriteId:
; which cursor graphic to draw, or $FF for a screen with no cursor at all.
; $12 is special-cased into the password keyboard's blinking highlight
    ds 1                                               ;; d6c1
wD6C2_Text_ShiftCount:
; 8 - (wD698_Text_PenX & 7). call_01_4ae7_Text_DrawGlyph shifts each glyph row
; left by this much in a 16-bit window, which is a right shift by (penX & 7) with
; the bits that fall off the end landing in the next tile along
    ds 1                                               ;; d6c2
wD6C3_Text_GlyphAdvance:
; advance width of the glyph just drawn, read from wD6A1_Font_WidthTable. The pen
; moves by this plus one, so every font has a 1px inter-character gap built in
    ds 1                                               ;; d6c3
wD6C4_MenuScript_CommandId:
; the command id byte most recently consumed by call_01_44e6_MenuScript_RunCommand
    ds 1                                               ;; d6c4
wD6C5_Menu_OptionActions:
; one MENU_OPTION_* code per selectable row, filled in by the menu script as it
; draws each option. When the player presses B, the code for the highlighted
; row is what call_01_4000_MenuLoad returns to its caller
    ds 16                                              ;; d6c5
wD6D5_Menu_OamSlot:
; write cursor into shadow OAM, advanced as sprite blocks are emitted
    ds 1                                               ;; d6d5
wD6D6_Menu_BlinkCounter:
; free-running counter decremented once per menu frame. Bit 4 drives the
; password cursor's blink
    ds 1                                               ;; d6d6
wD6D7_Menu_ChainedScriptId:
; MENU_CHAINED_NONE normally. A menu script can set it to hand control to another
; script from data_01_568c_ChainedScriptTable, which is how one menu type builds
; itself out of several
    ds 1                                               ;; d6d7
wD6D8_Menu_HideSpritesDelay:
; frames until the sprite group named by wD6D9 is erased. Pressing any button
; forces it to fire immediately, which is what makes prompts disappear as soon
; as the player responds. Zero disables it
    ds 1                                               ;; d6d8
wD6D9_Menu_HideSpritesGroup:
; MENU_SPRITE_GROUP_* index into data_01_5aa9_SpriteScriptTable naming the group
; wD6D8 will erase
    ds 1                                               ;; d6d9
wD6DA_Menu_TotalsSpriteGroup:
; the MENU_SPRITE_GROUP_* actually drawn on the totals page, remembered so that
; paging left or right can erase exactly the icons it put there. Recomputed by
; call_01_4879_MenuCmd_DrawRemoteIcons every time the page is drawn, because the
; layout depends on the new page's remote progress id
    ds 1                                               ;; d6da
wD6DB_Text_RequestedX:
; the pen X the script asked for, stashed before rendering so that every wrapped
; line starts from it again. Keeps the $FE centring sentinel, which is what
; call_01_4a8f_Text_Render tests per line
    ds 1                                               ;; d6db
wD6DC_Text_LineAdvance:
; how far down to move for the next line: glyph height + 1 normally, or the evenly
; distributed spacing worked out by call_01_4bd3_Text_WrapAndAlign when PenY is $FE
    ds 1                                               ;; d6dc
wD6DD_Menu_ReturnToType:
; when START opens the pause menu over another screen (MENU_FLAG_START_OPENS_PAUSE),
; the screen underneath is remembered here so that dismissing the pause menu
; reloads it instead of returning to the caller. Zeroed on a fresh MenuLoad
    ds 1                                               ;; d6dd
wD6DE_MenuType:
; the MENU_TYPE_* currently on screen. Doubles as the index into
; data_01_5574_MenuTypeRecords, data_01_5654_MenuTypeLcdcAndPalette and the jump table
; in call_01_43e6_Menu_OnSelectionChanged, so all three tables are the same length
    ds 1                                               ;; d6de
wD6DF_MenuSelectedColumn:
; only meaningful with MENU_FLAG_GRID_CURSOR - the password keyboard's column 0-5.
; Every other screen leaves it at 0, and left/right either page the totals or do
; nothing. Starts at 1 on the keyboard so the cursor opens on a letter rather than
; on the EXIT key
    ds 1                                               ;; d6df
wD6E0_MenuSelectedRow:
; the highlighted row. Indexes wD6C5_Menu_OptionActions to decide what B does, drives
; the cursor position in call_01_4d72_Menu_DrawCursor and the raster wobble in
; call_01_43e6_Menu_OnSelectionChanged, and on the mission select screen is copied to
; wD627_CurrentMission on the way out
    ds 1                                               ;; d6e0
wD6E1_RasterSplit_LCDCValue:
; LCDC value the raster-effect LCD STAT handler installs at scanline $5F,
; used to turn the window on for the bottom of the screen
    ds 1                                               ;; d6e1

; ------------------------------------------------------------------
; Scripted graphics streamer, run from the vblank hook that pairs with the
; raster-effect LCD STAT handler (call_00_0d84_VBlank_RunGfxStream).
; The script is [chunks, rowsPerChunk, bank] followed by (srcPtr, destPtr) pairs;
; one pair is copied per frame.
; ------------------------------------------------------------------
wD6E2_GfxStream_ChunksRemaining:
    ds 1                                               ;; d6e2
wD6E3_GfxStream_RowsPerChunk:
; each row is 16 bytes (one tile)
    ds 1                                               ;; d6e3
wD6E4_GfxStream_SrcBank:
    ds 1                                               ;; d6e4
; The four bytes below are the source and destination pointers of the pending
; graphics stream, not sprites - they sit at the end of the wD6E2..wD6E8 block
; that call_01_4d0a_Menu_StartGfxStream is handed as one unit, which is why they
; are never read through their own symbols.
; call_01_4ecf_Password_RefreshCellGfx is the main user
wD6E5_GfxStream_SrcPtrLo:
    ds 1                                               ;; d6e5
wD6E6_GfxStream_SrcPtrHi:
    ds 1                                               ;; d6e6
wD6E7_GfxStream_DestPtrLo:
    ds 1                                               ;; d6e7
wD6E8_GfxStream_DestPtrHi:
    ds 1                                               ;; d6e8
wD6E9_GfxStream_ListPtrLo:
; pointer to the next (srcPtr, destPtr) pair in the script
    ds 1                                               ;; d6e9
wD6EA_GfxStream_ListPtrHi:
    ds 1                                               ;; d6ea
wD6EB_RasterWobble_StartLine:
; first scanline of the horizontal wobble effect
    ds 1                                               ;; d6eb
wD6EC_RasterWobble_LineCount:
; how many scanlines the wobble covers; outside this band rSCX is forced to 0
    ds 1                                               ;; d6ec

; BgMap related memory starts here
wD6ED_BgMap_ScrollX:
    ds 2                                               ;; d6ed
wD6EF_BgMap_ScrollY:
    ds 2                                               ;; d6ef
wD6F1_BgMap_PrevColumn:
    ds 2                                               ;; d6f1
wD6F3_BgMap_PrevRow:
    ds 2                                               ;; d6f3
wD6F5_BgMap_BlockmapBank:
; ROM bank of the level's blockmap - the grid of block ids that is the layout itself.
; Paged in to read the six block ids of each strip, then swapped for the blockset
; bank to expand them
    ds 1                                               ;; d6f5
wD6F6_BgMap_AltBlocksetBank:
; ROM bank of the alt-blockset flag plane ($34 or $35). Paged in on its own for the
; few bytes of each strip that need it, then the blockset bank is paged straight
; back - see the two loaders in bank00_bg_map.asm
    ds 1                                               ;; d6f6
wD6F7_BgMap_BlocksetAndCollisionBank:
; ROM bank of the block definitions - 8 bytes per block, the 4x2 tile ids it expands
; to - taken from page $40 or page $50 depending on the alt blockset flag. The
; collision table lives in the same bank, which is why one field names both
    ds 1                                               ;; d6f7
; unused byte
    ds 1
wD6F9_BgMap_LoadingFlags:
; see constants.asm for values
    ds 1                                               ;; d6f9
; Where the next pending tilemap strip goes. Scrolling vertically writes a horizontal
; row, scrolling horizontally writes a vertical column - see
; call_03_6f5e_VRAM_WriteBgMapRowForVerticalScroll and its column twin.
wD6FA_BgMap_RowWritePosLo:
; 16-bit. The row writer masks the low byte with $E0 to snap to the start of a
; tilemap row, and ORs the high byte with $98 / $C0 to reach VRAM and the shadow map
    ds 1                                               ;; d6fa
wD6FB_BgMap_RowWritePosHi:
    ds 1                                               ;; d6fb
wD6FC_BgMap_ColumnWritePos:
; the column writer masks this with $1F to get a column index, then steps by $20 per
; entry. Only the one byte is read; wD6FD is written alongside but never used here
    ds 1                                               ;; d6fc
wD6FD_BgMap_ColumnWritePosHi:
    ds 1                                               ;; d6fd
wD6FE_BgMap_AltBlocksetMask:
; this map's single bit within the shared flag plane at wD6F6_BgMap_AltBlocksetBank.
; call_00_1e3c_BgMap_MaskAltBlocksetFlags ANDs it over every flag byte just read, so
; the other maps' bits fall away. $00 means this map never uses the alt blockset
    ds 1                                               ;; d6fe
wD6FF_BgMap_TilesetBank:
    ds 1                                               ;; d6ff
wD700_BgMap_TilesetBankOffset:
    ds 2                                               ;; d700
wD702_BgMap_TempScratchRowMetaTileIDs:
; where block ids get written temporarily when a row is loaded
    ds 1                                               ;; d702
wD703_BgMap_TempScratchRowAltBlocksetFlags:
; alt blockset flags for the loaded row tiles - one per metatile, gated by
; wD6FE_BgMap_AltBlocksetMask
    ds 11                                              ;; d703
wD70E_BgMap_TempScratchColumnMetaTileIDs:
; where block ids get written temporarily when a column is loaded
    ds 1                                               ;; d70e
wD70F_BgMap_TempScratchColumnAltBlocksetFlags:
; alt blockset flags for the loaded column tiles - one per metatile, gated by
; wD6FE_BgMap_AltBlocksetMask
    ds 11                                              ;; d70f

; ------------------------------------------------------------------
; Entity graphics queue.
; call_02_7211_EntityGfxQueue_Enqueue collects up to 4 pending graphics loads
; (one per on-screen entity type) and call_02_722c_EntityGfxQueue_StartNext
; expands the next one into the wD71F.. descriptor and raises
; GFX_XFER_QUEUED_ENTITY_GFX.
; ------------------------------------------------------------------
wD71A_EntityGfxQueue:
    ds 4                                               ;; d71a
wD71E_EntityGfxQueueCount:
    ds 1                                               ;; d71e

; Descriptor for the pending entity graphics copy
wD71F_GfxCopy_SrcBank:
    ds 1                                               ;; d71f
wD720_GfxCopy_SrcAddrLo:
    ds 1                                               ;; d720
wD721_GfxCopy_SrcAddrHi:
    ds 1                                               ;; d721
wD722_GfxCopy_DestAddrLo:
    ds 1                                               ;; d722
wD723_GfxCopy_DestAddrHi:
    ds 1                                               ;; d723
wD724_GfxCopy_SizeLo:
    ds 1                                               ;; d724
wD725_GfxCopy_SizeHi:
    ds 1                                               ;; d725

; Secondary Tileset related
wD726_SecondaryTilesetBank:
    ds 1                                               ;; d726
wD727_SecondaryTileset_SrcAddrLo: ; always 0
    ds 1                                               ;; d727
wD728_SecondaryTilesetAddr: ; this determines which secondary tilset to load (and is loading)
    ds 1                                               ;; d728
wD729_SecondaryTileset_DestAddrLo:
    ds 1                                               ;; d729
wD72A_SecondaryTileset_DestAddrHi: ; $90 -> VRAM_TILESET_ADDR_1
    ds 1                                               ;; d72a
wD72B_SecondaryTileset_RowsPerPage: ; $40 tiles = $400 bytes
    ds 1                                               ;; d72b
wD72C_SecondaryTileset_PagesRemaining:
    ds 1                                               ;; d72c
wD72D_SecondaryTilesetIndex:
    ds 1                                               ;; d72d
wD72E_TilesetAnim_Bank:
; ROM bank holding the secondary tileset's animation frames. Written from the same
; table entry as wD726_SecondaryTilesetBank, so the two always hold the same value -
; but they are read by different systems and that is why there are two.
; wD726 belongs to the loader (call_00_08fc_StageNextGfxTransfer), while this copy
; belongs to the animation player, which runs from the vblank handler via
; call_00_0ac1_VBlank_UpdateVRAM and banks this in before touching any frame data
    ds 1                                               ;; d72e

; ------------------------------------------------------------------
; Secondary tileset animation player. Loaded alongside the secondary tileset;
; ticked from call_00_0ac1_VBlank_UpdateVRAM.
; ------------------------------------------------------------------
wD72F_TilesetAnim_FrameCount:
; number of animation frames; 0 = this tileset has no animation
    ds 1                                               ;; d72f
wD730_TilesetAnim_FrameIndex:
    ds 1                                               ;; d730
wD731_TilesetAnim_DelayReload:
    ds 1                                               ;; d731
wD732_TilesetAnim_DelayCounter:
    ds 1                                               ;; d732
wD733_TilesetAnim_RowsPerFrame:
; number of 16-byte tiles copied per frame
    ds 1                                               ;; d733
wD734_TilesetAnim_DestAddrLo:
; read into DE but immediately overwritten by the frame table entry - dead
    ds 1                                               ;; d734
wD735_TilesetAnim_DestAddrHi:
    ds 1                                               ;; d735
wD736_TilesetAnim_FrameTablePtrLo:
; table of 4-byte (destPtr, srcPtr) entries, one per animation frame
    ds 1                                               ;; d736
wD737_TilesetAnim_FrameTablePtrHi:
    ds 1                                               ;; d737
wD738_TilesetAnim_Flags:
; bit 0 = play once and stop instead of looping
    ds 1                                               ;; d738

; Entity graphics related
wD739_Entity_OamWriteOffset:
; byte offset into wCC00_ShadowOAM where the next entity sprite goes. Reset to
; OAM_ENTITY_FIRST_BYTE at the top of every frame - the player owns everything
; below that - and advanced as each entity emits its sprites. Entities are
; drawn in slot order, so a later entity simply gets no sprites once this
; reaches OAM_ENTITY_LAST_BYTE, and whatever is left over is blanked by
; call_03_6484_OAM_ClearUnusedEntries
    ds 1                                               ;; d739
wD73A_Entity_TileIdBase:
; added to every tile number the current entity emits, so one shared sprite
; layout can be pointed at whichever VRAM page that entity's tiles were
; streamed into. Where it comes from depends on the drawing path: the shape
; paths take it from byte +1 of the entity's row of
; data_03_5446_EntitySpriteDescriptors (always $20, the shared entity tile pages),
; while the layout-by-action path takes it from the live
; ENTITY_FIELD_SPRITE_ID instead
    ds 1                                               ;; d73a
wD73B_VBlankFrameCounter:
; Free-running 8-bit frame clock. call_00_0a54_VBlank_Handler does "inc [HL]" on it
; once per VBlank and nothing in the ROM ever writes it, so it counts frames since
; power-on and wraps every 256. It keeps ticking through menus, cutscenes, loading
; screens and the pause screen, because it lives in the interrupt handler rather
; than in any game loop.
;
; Used as the game's shared phase source rather than as a measurement of time:
;   AND a power-of-two mask, test for zero -> "do this every N frames"
;   AND $01 / bit 3 -> damage-flash and blink, by toggling SPRITE_FLAG_INVISIBLE
;   (counter >> 2) & 2 -> pick between two HUD tiles
;   CP a per-entity byte -> each entity acts on the one frame the global clock
;   matches its own stored value, which staggers identical enemies instead of
;   firing them all on the same frame
    ds 1                                               ;; d73b
wD73C_GameplayFrameCounter:
; Counts frames of ACTIVE gameplay in the current level. Incremented once per pass
; of the in-game update loop at 00:0505, and zeroed by the level start/respawn
; block at 00:0392.
;
; That makes it the counterpart to wD73B_VBlankFrameCounter, not a duplicate of it.
; The update loop is entered once per frame (it opens with
; call_00_0ab4_WaitForInterrupt), but it does not run at all while a menu is open,
; during a cutscene, or while a screen is being rebuilt - and wD73B keeps counting
; through all of those. So this one stops when play stops and restarts from zero
; with the level.
;
; Read in three places, always masked: a randomised 1-4 frame delay before a cactus
; attacks, a randomised $40-$7F frame respawn delay for falling lava, and a
; "every 32 frames" gate on the stop climbing action
    ds 1                                               ;; d73c

; Player related memory
wD73D_LivesRemaining:
    ds 1                                               ;; d73d
wD73E_LivesRemaining_Hundreds: ; the hundreds unit of your lives
    ds 1                                               ;; d73e
wD73F_LivesRemaining_Tens: ; the tens unit of your lives
    ds 1                                               ;; d73f
wD740_LivesRemaining_Ones: ; the ones unit of your lives
    ds 1                                               ;; d740
wD741_Player_Health:
    ds 1                                               ;; d741
wD742_Player_CurrentFly:
    ds 1                                               ;; d742
wD743_Player_UpdateFlag:
    ds 1                                               ;; d743
wD744_Player_SpawnAction:
    ds 1                                               ;; d744
wD745_Player_QueuedAction:
    ds 1                                               ;; d745
wD746_Player_ClimbingState:
; Sub-state of PLAYER_ACTION_CLIMB. See CLIMB_STATE_* in constants.asm;
; call_02_44af_PlayerAction_Climb uses this as an index into .data_02_44e5.
; $FF (CLIMB_STATE_NOT_CLIMBING) is the normal, non-climbing value and is what
; Player_UpdateFacing / Player_ApplyXMovement / Player_ApplyYVelocity all
; check before doing anything - while climbing, gravity and walking are off
; and the climb handler moves Gex directly
    ds 1                                               ;; d746
wD747_Player_ClimbAnimCounter:
; frame counter within the current climb sub-state, and zeroed on every change of
; sub-state. The climbing and tail-spin states take the sprite frame from
; (counter >> 2) & 7; the dismount states use it as a countdown, shifting it by
; 2 (background/wall bottom) or by 1 (the corner transition) to index their sprite
; lists and comparing it against a fixed length to know when they are done
    ds 1                                               ;; d747
wD748_Player_ClimbDirectionIndex:
; which way Gex is climbing this frame, as a CLIMB_DIR_* compass index - see
; constants.asm. Written by the two direction routines in
; bank02_player_actions.asm from the held d-pad, and used to index every
; per-direction table in the climb handlers for facing, frame set and sprite base.
; Left alone (so it keeps the previous frame's value) when no direction is held
    ds 1                                               ;; d748
wD749_Player_ClimbingDirection:
; Which corner Gex is rounding, NOT a movement direction - unrelated to wD748.
; call_03_4ac4_BgCollision_ClimbingHandler writes tile type minus
; TILE_TYPE_CLIMB_STOP_ENTRY_FIRST here, so the value is 0-3 and is chosen by which
; of the four stopper tiles the level places. .jp_02_46b8_PlayerClimbAction_Stop
; pairs it with the current facing to pick the step deltas and the wall state to
; come out in; only 2 and 3 have real table rows
    ds 1                                               ;; d749
wD74A_Player_InWaterOrLava:
; $80 = Gex is not touching liquid, $00 = he is (the flag is built by xor $80,
; so it reads inverted). Set every frame by
; call_02_4c28_Player_CheckLavaAndWaterTiles and read by the sprite builder in
; bank 3 to swap in the partially submerged frames
    ds 1                                               ;; d74a

wD74B_Player_ClimbingFlags:
; bit 6 (CLIMB_FLAG_ALT_FRAMES) selects the rotated climb sprite frame set in
; call_03_5ca8_Entity_BuildPlayerSprites. Cleared whenever a new action is queued.
; Together with FACING_LEFT in wD20D this is what lets eight climb directions be
; drawn from four sets of artwork - see
; .data_02_4557_BackgroundClimbSpriteFlagsByDirection. The dismount states clear it
; every frame so the drop-off is always drawn from the primary set
    ds 1                                               ;; d74b

wD74C_Player_KarateKickTimer: ; gets canceled if done into a wall
    ds 1                                               ;; d74c

wD74D_Player_EntityStoodOnLo: ; stores lo address of platform entity stood on
    ds 1                                               ;; d74d
wD74E_Player_PushedStationaryPlatformLo: ; stores lo address of stationary platform entity pushed
    ds 1                                               ;; d74e
wD74F_Player_PushedMovingPlatformLo: ; stores lo address of moving platform entity pushed
    ds 1                                               ;; d74f

; Player Timers
wD750_Player_DamageCooldownTimer:
    ds 1                                               ;; d750
; 16-bit countdown for the Circuit Central power-up, and the channel's equivalent
; of the Rezopolis tail spin charge - two entities refuse to do anything at all
; while it is zero:
;   call_02_696f_EntityAction_CircuitCentralPoweredPlatform_Idle  will not start
;   .jr_03_5129_CollisionHandler_PoweredWalkway                   will not energise
;       a conveyor slot
; Both test the pair for non-zero rather than for any particular value, so it is
; purely "is the power on right now"
wD751_Player_CircuitPowerUpTimerLo:
    ds 1                                               ;; d751
wD752_Player_CircuitPowerUpTimerHi:
    ds 1                                               ;; d752
wD753_FlyPowerup1_TimerLo:
    ds 1                                               ;; d753
wD754_FlyPowerup1_TimerHi:
    ds 1                                               ;; d754
wD755_FlyPowerup2_TimerLo:
    ds 1                                               ;; d755
wD756_FlyPowerup2_TimerHi:
    ds 1                                               ;; d756

wD757_LanternLitFlag:
; Scream TV only, and rewritten from scratch every frame rather than latched.
; .jr_03_4d8c_CollisionHandler_Lantern raises it to $01 as the first thing it does
; and drops it back to $00 if Gex is overlapping the lantern, so it reads as
; "a lantern is loaded this frame and Gex is not at it".
;
; Nothing clears it when the lantern leaves the room, so it keeps whatever the
; last lantern to run left behind - which is why the ghost sits harmlessly in
; call_02_55f1_EntityAction_Ghost_Dormant in rooms with no lantern at all.
;
; Three things read it, and they agree on the sense:
;   the lantern's own actions   pick which sprite to draw
;   the ghost's actions         chase while set, hold still while clear
;   the ghost collision handler let an attack land only while it is clear
;
; So the flag is what makes the ghost invulnerable until Gex reaches the lantern
    ds 1                                               ;; d757

wD758_JumpVelocityOverride:
; When nonzero this replaces the jump velocity that
; call_02_4856_Player_GetJumpVelocity would otherwise return, letting an entity
; launch Gex harder than a normal jump. Entity collision in bank 3 writes it
; (PLAYER_GEYSER_VELOCITY for the pre-history geyser,
; PLAYER_LAUNCH_PAD_VELOCITY for COLLISION_TYPE_LAUNCH_PAD) and
; call_02_4939_Player_UpdateMain clears it again at the end of every frame,
; so it only survives for the one frame in which the entity was touched
    ds 1                                               ;; d758

wD759_ButtonBlockingFlags:
; bit 7 (80) = suppresses b button during upward velocity
; bit 6 (40) = suppresses b button
; bit 5 (20) =
; bit 4 (10) = can hold b to double jump when landing
; bit 3 (08) =
; bit 2 (04) =
; bit 1 (02) =
; bit 0 (01) = suppresses a button
    ds 1                                               ;; d759

wD75A_Player_EffectiveInputs:
; What Gex is told the player is doing, which is not always what they are doing.
; Rebuilt once a frame by call_02_4939_Player_UpdateMain and read by every player
; action, so this - not wD59F_RawInputs - is the input the character obeys.
;
; It diverges from the pad in four ways:
;
;   1. SOURCE. In demo mode it comes from the run-length encoded stream at
;      wD61B_DemoInputsPointer instead of the pad, which is how attract mode drives
;      Gex through code that has no idea a demo is playing.
;   2. BUTTON BLOCKING. A and B are passed through wD759_ButtonBlockingFlags, which
;      clears a blocked button until the player physically lets go. That is why the
;      face buttons read as one-frame events here while the d-pad stays set as long
;      as it is held - the d-pad is never blocked.
;   3. CUTSCENES. call_00_2329_Cutscene_LoadAndRun writes canned input bytes straight
;      into it, so a cutscene moves Gex by faking the pad rather than by moving him.
;   4. COLLISION. call_03_4ac4_BgCollision_ClimbingHandler strips the d-pad bits back
;      out when a climb script has no entry for that direction, which is what stops
;      him sliding off the side of a ladder.
;
; Bits are the PADF_* values in hardware.inc, same as the raw pad
    ds 1                                               ;; d75a

wD75B_IdleTimer:
; counter used to determine if gex has been idle long enough to do the tongue flick
    ds 1                                               ;; d75b
wD75C_PlayerXDeltaExtra:
; extra horizontal displacement added on top of Gex's own walking speed by
; call_02_4a77_Player_ApplyXMovement. Written by whatever is carrying or
; shoving him this frame - moving platforms and powered walkways in bank 2,
; slope correction in bank 3 - and zeroed again on a wall hit
    ds 1                                               ;; d75c
wD75D_PlayerXSpeedPrev:
; (0 = still, 1 = walk, 2 = run)
;
; call_02_56dc_EntityAction_HardHeadAreaHazard_Aim reads it as an index rather than
; a speed: 0/1/2 select how far ahead of Gex the falling hazard aims, so the three
; values here are the three lead distances in .data_02_575e
    ds 1                                               ;; d75d
wD75E_PlayerXSpeed:
; how fast gex runs (1 = walk, 2 = run)
; can freeze to change how fast you run, but doesn't make you move by itself
    ds 1                                               ;; d75e
wD75F_BgCollision_WallProbeLookahead:
; how far above his head the wall probe in call_03_4915_BgCollision_SidescrollerHandler
; starts, in pixels: (Y velocity - 2) clamped to $C0, then >> 4. Rising fast means
; looking further up, so a wall is caught on the frame he would enter it rather than
; after. Recomputed every frame and used nowhere outside bank 3
    ds 1                                               ;; d75f
wD760_PlayerYVelocity:
; signed byte (positive = up, negative = down)
; can freeze this to levitate
    ds 1                                               ;; d760
wD761_Player_FloorSnapVelocity:
; The exact downward velocity that would put Gex's feet on the floor this frame -
; the gap below him, expressed in the same units as wD760_PlayerYVelocity so it can
; be dropped straight into it.
;
; Written only by the floor branch of call_03_49dc_BgCollision_FloorCeilingCheck,
; which scans down through data_03_4000_TileSolidityRows a pixel row at a time and
; stores -(rows * 16). Zero therefore means he is already resting exactly on the
; floor. If no floor turns up within BGCOLL_FLOOR_SEARCH_ROWS it stores the search
; limit instead, which just reads as "keep falling".
;
; call_02_4b78_Player_ApplyYVelocity uses it to land without tunnelling: when Gex is
; grounded and not moving up, it takes this snap velocity instead of gravity - but on
; the first grounded frame only if the snap is the smaller step of the two, otherwise
; the fall continues normally.
;
; Nothing to do with ceilings despite the old name; the head-bonk case is the other
; branch of that routine and it zeroes wD760_PlayerYVelocity, not this
    ds 1                                               ;; d761
wD762_PlayerInitialYVelocity:
; y velocity when first entered the air (2a = jump, 36 = double jump). also set to 1 if fall off ledge
; Counts down to zero as the arc plays out, so the jump actions poll it to find
; out when the jump has finished
    ds 1                                               ;; d762
wD763_FallDistanceCounter:
; how long Gex has been falling, incremented once per frame while he is at
; terminal velocity and capped at $80. Checked on landing to pick between no
; animation, a walk/run landing, and PLAYER_ACTION_COLLAPSE - see the
; FALL_DISTANCE_* constants
    ds 1                                               ;; d763
; The four tile types cached each frame by
; call_03_4c0a_BgCollision_CacheNearbyTileTypes. See TILE_TYPE_* in constants.asm
wD764_TileTypeBehindGexsUpperBody:
; the tile at his own row
    ds 1                                               ;; d764
wD765_TileTypeBehindGexsLowerBody:
; one tile row down
    ds 1                                               ;; d765
wD766_TileTypeBehindGexsFace: ; also set to 22 in front of doors?
    ds 1                                               ;; d766
wD767_FloorTileType:
; two tile rows down - the floor he is standing on
    ds 1                                               ;; d767
    ds 1
wD769_ClimbSurfaceTileType:
; tile type that triggered the climb; $26 = climbable background, otherwise wall
    ds 1                                               ;; d769
wD76A_Player_BlockX:
; The player's X in block coordinates - world X >> 5, the same 128-wide grid the
; blockmap and the spawn tables use (SPAWN_UNITS_PER_BLOCK). Recomputed at the end of
; every call_02_4939_Player_UpdateMain.
;
; It exists so entity logic can compare against the block coordinates it already has
; without redoing the shift: call_00_3364_Entity_ApproachPlayerXWithBounds converts
; its own X the same way and tests this against the patrol bounds in
; wD309_EntityBoundingBoxXMax, which came from the spawn record in block units
    ds 1                                               ;; d76a
wD76B_Player_IsAttacking:
    ds 1                                               ;; d76b

; Screen position the orbiting fly sprite circles around, written and read a few
; instructions apart inside call_03_5ca8_Entity_BuildPlayerSprites - scratch, not
; state. The routine needs both of Gex's coordinates live while it is also indexing
; .data_03_5e9f_FlyParticleOffsetTable, which is more than the registers hold
wD76C_FlyPowerup_AnchorX:
; wD212_Player_ScreenXPosition, unmodified
    ds 1                                               ;; d76c
wD76D_FlyPowerup_AnchorY:
; wD213_Player_ScreenYPosition minus $20, putting the orbit centre two tiles above
; Gex. The table's signed offsets then swing the fly around that point
    ds 1                                               ;; d76d

wD76E_FlyPowerup_OrbitPhase:
; Animation phase of the single fly sprite that circles above Gex while he is
; carrying a fly (wD742_Player_CurrentFly). call_03_5ca8_Entity_BuildPlayerSprites
; increments it once per frame, then uses (phase >> 1) AND $0F to index the 16
; signed (Y, X) offsets in .data_03_5e9f_FlyParticleOffsetTable - so the fly steps
; every other frame and completes its loop every 32 frames.
;
; Not related to wD688_FlyAnimationPosition, which is the HUD fly counter's
; slide-in position
    ds 1                                               ;; d76e

; ------------------------------------------------------------------
; Bonus level countdown timer (only ticks while wD623_CollectibleMode is set).
; Displayed by call_03_6ceb_HUD_LoadTimerDigits as hundreds/tens/ones.
; Starts at 3:00; when it runs out, bits 2 and 4 of wD621_WarpFlags are set,
; which kicks the player out with the MENU_TYPE_TIME_UP screen.
; ------------------------------------------------------------------
wD76F_LevelTimer_Minutes:
    ds 1                                               ;; d76f
wD770_LevelTimer_SecondsBCD:
; BCD seconds, decremented with daa
    ds 1                                               ;; d770
wD771_LevelTimer_FrameCounter:
; counts down from $3C (60 frames = 1 second)
    ds 1                                               ;; d771

; Three per-level progress counters, zeroed together on level entry. Each
; counts one kind of event and unlocks something once it reaches a threshold
wD772_BreakablesDestroyedCount:
; how many counted-breakable tile objects have been destroyed this level.
; call_00_2186_CountedBreakable_OnHit compares it against a per-level quota - 5 in
; Smellraiser, 8 elsewhere - and opens a block patch slot on the exact match
    ds 1                                               ;; d772
wD773_HuntersDefeatedCount:
; bumped each time a toon tv hunter is beaten. On the second one the collision
; handler writes $02 into wD799_BlockPatch_SlotTable14, opening the way onward
    ds 1                                               ;; d773
wD774_MushroomsDestroyedCount:
; Bumped by call_02_5a28_EntityAction_Mushroom_Update the frame a Toon TV mushroom
; is attacked. It does two jobs at once: the fifth one opens
; wD79A_BlockPatch_SlotTable15, and the count also picks which of the eight icons
; in data_02_7a21 the mushroom pops out, as sprite id $40 + 2 * (count - 1). So
; each mushroom in the room gives a different prize, in the order they are broken
    ds 1                                               ;; d774

wD775_Cutscene_Skippable:
    ds 1                                               ;; d775
    ds 2

wD778_BlockPatch_SlotWriteHead:
; Index into wD78B_BlockPatch_SlotTable slot table; incremented by BgMap_UpdateCollisionFlags as slots are filled
    ds 1                                               ;; d778

; ------------------------------------------------------------------
; Camera position in block coordinates - wD6ED_BgMap_ScrollX / wD6EF_BgMap_ScrollY
; shifted right by 5, computed as a 16-bit "<< 3, keep the high byte". Despite the
; old names, neither has anything to do with the player; both come from the scroll
; registers and both are refreshed at the top of each strip load.
;
; They exist so the strip loaders can match registered block patches without
; converting units per candidate: the $CD00/$CE00 coordinate tables that
; call_00_1ec9_BlockPatch_Register fills hold block coordinates too, straight from
; wD782_BlockPatch_TargetBlockX / wD783_BlockPatch_TargetBlockY.
; BgMap_ApplyBlockPatchesToRow and its column twin compare against these to decide
; which patches land inside the strip being built
; ------------------------------------------------------------------
wD779_BgMap_ScrollBlockX:
    ds 1                                               ;; d779

wD77A_BgMap_ScrollBlockY:
    ds 1                                               ;; d77a

; Block patch state - runtime replacement of map blocks. Not to be confused with the
; alt blockset flags above, which are a static per-level rendering variant
wD77B_BlockPatch_VramWritePending:
; Bit 0 set = BlockPatch_WriteTiles has queued a VRAM write that hasn't completed yet;
; gates BlockPatch_TickSequence and TileHit_OnPlayerAttack
    ds 1                                               ;; d77b
wD77C_BlockPatch_StepFlags:
; Flags for current sequence step - see the BLOCKPATCH_STEP_* constants:
; bit 0 = loop immediately (BLOCKPATCH_STEP_LOOP),
; bit 1 = call call_00_1ec9_BlockPatch_Register (BLOCKPATCH_STEP_REGISTER),
; bit 2 = call call_00_1f05_BgMap_FindAndWriteCollisionBlock (BLOCKPATCH_STEP_COLLISION),
; bit 3 = call call_00_169f_BlockPatch_WriteTiles (BLOCKPATCH_STEP_TILES),
; bit 5 = call call_00_113e_PlaySFX before proceeding; the step carries one extra argument
;         byte after the flags for this (BLOCKPATCH_STEP_SFX)
    ds 1                                               ;; d77c
wD77D_BlockPatch_StepsRemaining:
; Countdown of remaining steps in the active tile animation sequence; zero = sequence idle
    ds 1                                               ;; d77d
wD77E_BlockPatch_TilemapAddrLo:
; VRAM tilemap address where BlockPatch_WriteTiles will write the expanded tile block
    ds 1                                               ;; d77e
wD77F_BlockPatch_TilemapAddrHi:
    ds 1                                               ;; d77f
wD780_BlockPatch_DataPtrLo:
; Pointer into ROM script data; advances by (width × height × 2) after each step
    ds 1                                               ;; d780
wD781_BlockPatch_DataPtrHi:
    ds 1                                               ;; d781
wD782_BlockPatch_TargetBlockX:
; Block X coordinate of the tile being overridden (player world X × 8, high byte);
; used by call_00_1ec9_BlockPatch_Register and call_00_1f05_BlockPatch_WriteCollision
    ds 1                                               ;; d782
wD783_BlockPatch_TargetBlockY:
; Block Y coordinate of the tile being overridden
    ds 1                                               ;; d783
wD784_BlockPatch_Width:
; Width in metatiles of the patch rectangle
    ds 1                                               ;; d784
wD785_BlockPatch_Height:
; Height in metatiles of the patch rectangle
    ds 1                                               ;; d785
wD786_BlockPatch_StepTimer:
; Counts down to zero before the next sequence step fires; reloaded from wD787 each step
    ds 1                                               ;; d786
wD787_BlockPatch_StepTimerReload:
; Per-script frame delay between animation steps
    ds 1                                               ;; d787

wD788_CurrentAudioBank:
    ds 1                                               ;; d788
wD789_QueuedSFX:
    ds 1                                               ;; d789
wD78A_MusicId: ; multiplied by 4 and used as index into .data_00_1244_MusicList
    ds 1                                               ;; d78a

wD78B_BlockPatch_SlotTable:
; 16-byte table of slot states:
; $00 = empty,
; $01 = armed/active,
; $02 = triggered/counting-up,
; $FF = completed.
; Each slot tracks one interactive tile region's state. Slots 0–15 correspond to tile
; block patch regions registered by call_00_1ec9_BlockPatch_Register.
;
; The 16 bytes are contiguous ($D78B-$D79A) but declared in four pieces so that the
; slots code refers to by name get their own labels. Code indexes straight off
; wD78B, so an offset can run past this `ds 4` into the labels below - see
; call_00_2225_Switch_ArmSlotByPosition, which reaches slots 0-8
    ds 4                                              ;; d78b
wD78F_BlockPatch_SlotTable4:
    ds 9
wD798_BlockPatch_SlotTable13:
    ds 1                                               ;; d798
wD799_BlockPatch_SlotTable14:
    ds 1                                               ;; d799
wD79A_BlockPatch_SlotTable15:
    ds 1                                               ;; d79a

; Mission preview cutscene related variables and backup buffers
; ------------------------------------------------------------------
; Mission preview cutscene state. The preview is a scripted camera move over a
; frozen level, driven by faking d-pad input into wD75A_Player_EffectiveInputs
; ------------------------------------------------------------------
wD79B_Cutscene_MoveFramesRemaining:
; 16-bit countdown for the movement command currently running. Loaded from the
; script, decremented once per frame; at zero the next command is fetched
    ds 2                                               ;; d79b
wD79D_Cutscene_MoveSpeed:
; movement speed in 1/16ths of a pixel per frame. Only ever $00 or
; CUTSCENE_MOVE_SPEED_MAX in practice - see the dead ramp code in
; call_00_2dbf_MissionPreview_UpdateMovement
    ds 1                                               ;; d79d
wD79E_Cutscene_MoveSubPixel:
; sub-pixel accumulator. wD79D is added to the low nibble each frame and the
; carry out of the high nibble becomes the whole-pixel step
    ds 1                                               ;; d79e
wD79F_BackupBuffer_EntityFlags:
    ds 256                                             ;; d79f
wD89F_BackupBuffer_EntityMemory:
    ds 256                                             ;; d89f
wD99F_BackupBuffer_EntityListIndexes:
    ds 8                                               ;; d99f
wD9A7_BackupBuffer_BoundingBoxAndMore:
    ds 32                                              ;; d9a7
wD9C7_BackupPlayer_EntityStoodOnLo:
    ds 1                                               ;; d9c7
wD9C8_BackupPlayer_PushedStationaryPlatformLo:
    ds 1                                               ;; d9c8
wD9C9_BackupPlayer_PushedMovingPlatformLo:
    ds 1                                               ;; d9c9
wD9CA_BackupBuffer_FlyAnimationPosition:
    ds 1                                               ;; d9ca

; Palettes
wD9CB_Bg_Palettes:
    ds 48                                              ;; d9cb
wD9FB_BgPalettes_Slot6:
    ds 16                                              ;; d9fb
wDA0B_Entity_Palettes:
    ds 8                                               ;; da0b
wDA13_EntityPalettes_Slot1:
    ds 8                                               ;; da13
wDA1B_EntityPalettes_Slot2:
    ds 32                                              ;; da1b
wDA3B_EntityPalettes_Slot6:
    ds 16                                              ;; da1b
wDA4B_DynamicPalette:
    ds 48                                              ;; da4b
wDA7B_MediaDimensionTVPalette:
    ds 48                                              ;; da7b

wDAAB_MenuBgMapTileIds:
    ds 32                                              ;; daab

; ------------------------------------------------------------------
; DMG palette fading ($DACB-$DADB).
; Only used when wD59E_OnGBCFlag is clear - on GBC the palettes are written
; straight out by call_00_0f9d_UploadCgbPalettes instead.
; call_00_1004_Fade_Update walks wDACE/wDACF/wDAD0 one shade at a time toward
; wDAD4/wDAD5/wDAD6, and call_00_0f80_VBlank_UpdatePalettes pushes them to the
; hardware registers.
; ------------------------------------------------------------------
wDACB_DefaultBGP: ; written to $E4 at boot, never read back
    ds 1                                               ;; dacb

wDACC_DefaultOBP0: ; written to $E4 at boot, never read back
    ds 1                                               ;; dacc

wDACD_DefaultOBP1: ; written to $00 at boot, never read back
    ds 1                                               ;; dacd

wDACE_CurrentBGP:
    ds 1                                               ;; dace

wDACF_CurrentOBP0:
    ds 1                                               ;; dacf

wDAD0_CurrentOBP1:
    ds 1                                               ;; dad0

wDAD1_LevelBGP:
; the level's "real" palettes, set by call_0b_5537_BgPalette_LoadMonoOrGetSpriteParams.
; These are what FADE_MODE_IN fades back to
    ds 1                                               ;; dad1

wDAD2_LevelOBP0:
    ds 1                                               ;; dad2

wDAD3_LevelOBP1:
    ds 1                                               ;; dad3

wDAD4_TargetBGP:
    ds 1                                               ;; dad4

wDAD5_TargetOBP0:
    ds 1                                               ;; dad5

wDAD6_TargetOBP1:
    ds 1                                               ;; dad6

wDAD7_FadeMaskLo:
; bit 0 = fade BGP
    ds 1                                               ;; dad7

wDAD8_FadeMaskHi:
; bit 0 = fade OBP0, bit 1 = fade OBP1.
; The death fade leaves OBP1 alone so Gex stays visible
    ds 1                                               ;; dad8

wDAD9_FadeMode:
; 0 = idle, otherwise one of the FADE_MODE_* values in constants.asm
    ds 1                                               ;; dad9

wDADA_FadeStepDelay:
; frames between fade steps (always $04)
    ds 1                                               ;; dada

wDADB_FadeStepCounter:
    ds 1                                               ;; dadb

    ds 1                                               ;; dadc

; DADD through DFAD might be be unused memory?
    ds 1233

; The rest of wram is used for audio-related purposes
wDFAE_AudioBankDataPointer: ; always 60 (as in 0x4460, which is where the audio data begins in all 4 audio banks)
    ds 1                                               ;; dfae
wDFAF_AudioBankDataPointer: ; always 44 (as in 0x4460, which is where the audio data begins in all 4 audio banks)
    ds 1                                               ;; dfaf

wDFB0:
    ds 8                                               ;; dfb0

wDFB8:
    ds 1                                               ;; dfb8

wDFB9:
    ds 1                                               ;; dfb9

wDFBA:
    ds 1                                               ;; dfba

wDFBB:
    ds 1                                               ;; dfbb

wDFBC:
    ds 1                                               ;; dfbc

wDFBD:
    ds 1                                               ;; dfbd

wDFBE:
    ds 1                                               ;; dfbe

wDFBF:
    ds 1                                               ;; dfbf

wDFC0:
    ds 1                                               ;; dfc0

wDFC1:
    ds 1                                               ;; dfc1

wDFC2:
    ds 1                                               ;; dfc2

wDFC3:
    ds 8                                               ;; dfc3

wDFCB:
    ds 1                                               ;; dfcb

wDFCC:
    ds 1                                               ;; dfcc

wDFCD:
    ds 1                                               ;; dfcd

wDFCE:
    ds 1                                               ;; dfce

wDFCF:
    ds 1                                               ;; dfcf

wDFD0:
    ds 1                                               ;; dfd0

wDFD1:
    ds 1                                               ;; dfd1

wDFD2:
    ds 20                                              ;; dfd2

wDFE6:
    ds 16                                              ;; dfe6

wDFF6:
    ds 8                                               ;; dff6

wDFFE:
    ds 2                                               ;; dffe

SECTION "hram", HRAM[$ff80]

hFF80_OamDmaRoutine:
; call_00_0ef7_OamDmaRoutine is copied here at boot and called every vblank
    ds 112                                             ;; ff80

hFFF0:
    ds 1                                               ;; fff0

hFFF1:
    ds 14                                              ;; fff1

SECTION "vram", VRAM[$8000]
    ds 8192                                            ;; 8000

SECTION "sram", SRAM[$a000]
    ds 8192                                            ;; a000
