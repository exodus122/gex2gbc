; ==================================================================
; Banking and video primitives - bank00_home.asm
; ==================================================================

; Point the MBC at the ROM bank in A. The cart is wired so that bit 5 of the ROM
; bank number also has to select the SRAM bank, which is what the swap/rrca/and
; does: it slides that bit down to bit 0 and writes it to MBC1SRamBank so the two
; stay in step. (That upper-bits trick is why a 1MB cart works despite the header
; saying MBC5.)
;
; This is the bare register write with no bookkeeping. Code that has to come back
; to the bank it was in goes through call_00_1089_SwitchBank /
; call_00_10a3_RestoreBank instead, which push and pop the bank stack around it.
; Interrupt handlers use this form deliberately, so that an interrupt landing
; mid-SwitchBank cannot corrupt that stack. Clobbers A
MACRO SET_MBC_BANK
    ld   [MBC1RomBank], a
    swap a
    rrca
    and  a, $01
    ld   [MBC1SRamBank], a
ENDM

; Select VRAM bank \1. GBC only - every caller checks wD59E_OnGBCFlag first,
; since rVBK does not exist on DMG. Clobbers A
MACRO SELECT_VRAM_BANK ; 0 or 1
    ld   a, \1
    ldh  [rVBK], a
ENDM

; Arm the LCD_ISR_VRAM_STREAM handler living in wCCA0_LcdIsrCode: overwrite its
; leading reti with a push af, and point its source pointer at the last byte of
; wD100_TilesToLoadBuffer, which it walks backwards four bytes per hblank. The
; caller still has to fill in wCCA7_LcdIsr_DestPageHi and clear its request bit.
;
; Only valid inside call_00_0c11_VBlank_ArmVramStreamIsr - .data_00_0c54_PushAfOpcode
; is a local label in that scope. Clobbers A and HL
MACRO ARM_VRAM_STREAM_ISR
    ld   a, [.data_00_0c54_PushAfOpcode]
    ld   [wCCA0_LcdIsrCode], a
    ld   hl, wCCA5_LcdIsr_SrcAddrHi
    ld   a, HIGH(wD100_TilesToLoadBuffer + GFX_PAGE_SIZE - 1)
    ld   [hl-], a
    ld   [hl], LOW(wD100_TilesToLoadBuffer + GFX_PAGE_SIZE - 1)
ENDM

; The same six instructions with the $D1 load hoisted above the `ld hl`. Identical
; effect, different encoding, so the two orderings cannot share one macro
MACRO ARM_VRAM_STREAM_ISR_ALT
    ld   a, [.data_00_0c54_PushAfOpcode]
    ld   [wCCA0_LcdIsrCode], a
    ld   a, HIGH(wD100_TilesToLoadBuffer + GFX_PAGE_SIZE - 1)
    ld   hl, wCCA5_LcdIsr_SrcAddrHi
    ld   [hl-], a
    ld   [hl], LOW(wD100_TilesToLoadBuffer + GFX_PAGE_SIZE - 1)
ENDM

; ==================================================================
; bank00_home.asm data tables
; ==================================================================

; One entry of .data_00_0bdc_LcdIsrTable. The length is computed from the two
; labels rather than written out, because the vblank hook always begins at the
; first byte after the handler template that call_00_0bb9_InstallLcdIsr copies
; into wCCA0_LcdIsrCode - which is exactly how the installer finds the hook
MACRO lcd_isr_entry ; handler template, vblank hook
    db   \2 - \1
    dw   \1
ENDM

; One record of an attract-mode demo input script: hold these buttons for this
; many frames. call_02_4939_Player_UpdateMain replays them into wD620_DemoInputs
MACRO demo_input ; frames, PADF_* bits
    db   \1, \2
ENDM

MACRO demo_input_end
    db   DEMO_INPUT_END
ENDM

; Header of a graphics stream script - see call_00_0d84_VBlank_RunGfxStream.
; Exactly one chunk is copied per frame, so the chunk count doubles as the number
; of frames the script takes to finish
MACRO gfx_stream_header ; chunk count, tiles per chunk, source bank
    db   \1, \2, \3
ENDM

MACRO gfx_stream_chunk ; source address, VRAM destination
    dw   \1, \2
ENDM

; One row of .data_00_116c_SFXChannelTable. The row index is the game's SFX_* id;
; the row itself says which driver track to start, in whichever bank
; wD788_CurrentAudioBank currently names
MACRO sfx_entry ; count mask, first driver sfx id
    db   \1, \2
ENDM

; One record of .data_00_1244_MusicList, indexed by MUSIC_*. A song is four driver
; tracks at consecutive ids, one per hardware channel
MACRO music_record ; audio bank, first driver track id, count mask
    db   \1, \2, \3, $00
ENDM

; Calls a function in a different bank
MACRO FARCALL
    ld   [wD59D_ReturnBank], a
	ld   a, BANK(\1)
	ld   hl, \1
	call call_00_1078_FarCall
ENDM

; Store an address and the associated bank.
macro farpointer
    db   BANK(\1)
    dw   \1
endm

; Store a high address and the associated bank.
macro farpointer2
    db   HIGH(\1)
    db   BANK(\1)
endm

MACRO LOAD_OBJ_FIELD_TO_HL
    ld   h, HIGH(wD200_EntityMemory)
    ld   a, [wD300_CurrentEntityAddrLo]
    or   a, \1
    ld   l, a
ENDM

MACRO LOAD_OBJ_FIELD_TO_HL_ALT
    ld   a, [wD300_CurrentEntityAddrLo]
    or   a, \1
    ld   l, a
    ld   h, HIGH(wD200_EntityMemory)
ENDM

MACRO LOAD_OBJ_FIELD_TO_DE
    ld   d, HIGH(wD200_EntityMemory)
    ld   a, [wD300_CurrentEntityAddrLo]
    or   a, \1
    ld   e, a
ENDM

MACRO LOAD_OBJ_FIELD_TO_DE_ALT
    ld   a, [wD300_CurrentEntityAddrLo]
    or   a, \1
    ld   e, a
    ld   d, HIGH(wD200_EntityMemory)
ENDM

MACRO LOAD_OBJ_FIELD_TO_BC
    ld   b, HIGH(wD200_EntityMemory)
    ld   a, [wD300_CurrentEntityAddrLo]
    or   a, \1
    ld   c, a
ENDM

MACRO LOAD_OBJ_FIELD_TO_BC_ALT
    ld   a, [wD300_CurrentEntityAddrLo]
    or   a, \1
    ld   c, a
    ld   b, HIGH(wD200_EntityMemory)
ENDM

MACRO SET_ACTION
    ld a, \1
    jp call_02_7102_Entity_SetAction
ENDM

MACRO EntityChildSpawnData
    db \1
    dw \2, \3
    db 0, 0, 0
ENDM

; ==================================================================
; Cutscene scripts - bank00_cutscenes.asm
; ==================================================================

; One cutscene script header. Gex is teleported to (X, Y) and then walked through
; whichever phases are present; pass 0 for a phase the scene does not use
MACRO cutscene_script  ; start X, start Y, movement list, animation script
    dw   \1, \2, \3, \4
ENDM

; One entry of a movement list: d-pad bits faked into wD75A_Player_EffectiveInputs
; and held for a frame count. Two direction bits at once move diagonally; 0 stands
; still, which is how a scene pauses before setting off
MACRO cutscene_move    ; PADF_* direction bits, frames
    db   \1
    dw   \2
ENDM

MACRO cutscene_move_end
    db   CUTSCENE_MOVE_END
ENDM

; ==================================================================
; Block patch sequences. Two systems share this format: the animation phase of a
; cutscene (bank00_cutscenes.asm) and the tile hit scripts driven by
; TileHitScript_Run (bank00_tile_hit_scripts.asm)
; ==================================================================

; Sequence header. The rectangle is positioned relative to whatever the sequence is
; anchored on - Gex for a cutscene, the tile that was hit for a tile hit script -
; never in map coordinates. A step count of 0 means the callback runs and nothing
; else; TileHitScript_Run bails out before it reads any step data
MACRO blockpatch_header  ; callback (0 = none), step count, frames per step, X, Y, width, height
    dw   \1
    db   \2, \3, \4, \5, \6, \7
ENDM

; Starts one step. Followed by an blockpatch_sfx line if the flags include
; BLOCKPATCH_STEP_SFX, then by width * height cells in row-major order
MACRO blockpatch_step  ; BLOCKPATCH_STEP_* flags
    db   \1
ENDM

; The argument BLOCKPATCH_STEP_SFX takes. Only valid directly after a step that
; sets that flag
MACRO blockpatch_sfx   ; SFX_*
    db   \1
ENDM

; A run of block patch cells, as (block id, alt blockset flag) pairs. A nonzero
; alt flag expands the block from blockset page $50 instead of $40
MACRO blockpatch_cells ; block id, alt flag, block id, alt flag, ...
    REPT _NARG / 2
        db   \1, \2
        SHIFT
        SHIFT
    ENDR
ENDM

; ==================================================================
; Tile hit script coordinate tables - bank00_tile_hit_scripts.asm
; ==================================================================

; One checkpoint. Hitting the block at (X, Y) in that level sets the spawn id
MACRO checkpoint_block ; level id, block X, block Y, checkpoint spawn id
    db   \1, \2, \3, \4
ENDM

; One switch position. A switch is identified by where it sits on the map, and its
; index in the table is the wD78B_BlockPatch_SlotTable slot it owns
MACRO switch_block     ; block X, block Y
    db   \1, \2
ENDM

MACRO block_coord_list_end
    db   BLOCK_COORD_LIST_END
ENDM

; One part of an entity sprite layout in bank03_sprite_frame_data.asm and in
; .data_03_608e_FixedSpriteShapeTable: a signed offset from the entity's
; screen position, a tile number relative to the entity's tile base, and attribute
; bits that get OR'd on top of wD335_Entity_OamAttr. Sprites are 8x16, so a part is
; 8 wide and 16 tall and tile numbers step by 2 down a column
MACRO obj_part ; dY, dX, tile, attributes
    db   \1, \2, \3, \4
ENDM

; One sprite of the eight-sprite HUD row built by call_03_5b5b_HUD_BuildSprites.
; There is no Y here - all eight share one Y, taken from wD688_FlyAnimationPosition
; so the whole row slides on and off screen together. An X of 0 parks the sprite
; off the left edge, which is how the row hides entries it does not need
MACRO hud_sprite ; X, tile, attributes
    db   \1, \2, \3
ENDM

; One step of a level's map tile animation schedule - see
; call_03_7253_MapTileAnim_Update. The vblank handler runs exactly one of these per
; frame and then moves on to the next, so a schedule is a round robin of VRAM writes
; rather than a list of animation frames.
;   tiles      how many 16-byte tiles to copy
;   condition  0 for an unconditional step, or MAP_TILE_ANIM_IF_CONVEYOR | n to skip
;              the step and blank the tiles while conveyor n is stopped
MACRO map_tile_anim_step ; tiles, condition, vram destination, tile data
    db   \1, \2
    dw   \3
    dw   \4
    db   $00, $00
ENDM

; Header of a climb script - see call_03_4ac4_BgCollision_ClimbingHandler. The mask is
; the set of d-pad bits this script has an answer for; a press outside it makes the
; handler return without touching the input, and a press inside it that matches no
; entry gets the whole d-pad stripped from wD75A_Player_EffectiveInputs
MACRO climb_script ; d-pad mask, number of entries
    db   \1
    db   \2
    dw   CLIMB_SCRIPT_ENTRY_SIZE
ENDM

; One entry of a climb script: an exact d-pad pattern, then two probe offsets from
; Gex's position. The FAR probe is the square he would move into, tested for
; TILECOLL_CLIMB_BLOCKED; the NEAR probe is the surface he is holding, tested for
; TILECOLL_CLIMB_BACKING
MACRO climb_script_entry ; input, far X, far Y, near X, near Y
    db   \1, \2, \3, \4, \5
ENDM

; One entry of .data_02_726c_EntityGfxDescriptors - a description of where an entity
; type's tiles live and where they go. call_02_722c_EntityGfxQueue_StartNextTransfer
; copies it straight into wD71F_GfxCopy_SrcBank onward and lets the vblank handler
; perform the copy, so the field order here IS that WRAM block's layout
MACRO entity_gfx_descriptor ; source bank, source address, VRAM destination, bytes
    db   \1
    dw   \2
    dw   \3
    dw   \4
    db   $00
ENDM

; ==================================================================
; Menus - bank01_menus.asm
;
; Every non-gameplay screen in the game is described by three tables and a
; script; the macros below are those four shapes written out. Nothing here
; generates code, so a screen can be read (and moved) without touching
; call_01_4000_MenuLoad
; ==================================================================

; One menu type's record in data_01_5574_MenuTypeRecords. Copied to
; wD68A_Menu_ScriptPtr onward when the menu opens, so the field order here IS that
; WRAM block's layout. The cursor is positioned as base + step * selected index,
; separately per axis, which is why menus never scroll
MACRO menu_type_record ; script, MENU_FLAG_*, option count, cursor base X, base Y, step X, step Y
    dw   \1
    db   \2, \3, \4, \5, \6, \7
ENDM

; One 8-byte descriptor in data_01_5324_MenuCmd_Descriptors, selected by a menu
; script's command id. The id fixes the shape and where it lands; the script's
; parameter block then says what goes in it. Only the first six bytes are copied
; (to wD692_Text_BlockWidthTiles onward) - the last two are padding
MACRO menu_cmd_descriptor ; width tiles, height tiles, dest tile X, dest tile Y, first tile id, CGB attributes
    db   \1, \2, \3, \4, \5, \6
    db   $00, $00
ENDM

; One menu script command whose source pointer really is a string in ROM. The
; seven bytes after the command id are copied over wD698_Text_PenX onward
MACRO menu_cmd_text ; command id, pen X, pen Y, MENU_FONT_*, string, option slot, MENUCMD_* flags
    db   \1
    db   \2, \3, \4
    dw   \5
    db   \6, \7
ENDM

; One menu script command whose source pointer is not a pointer at all: the high
; byte is a MENUCMD_SUB_* id, so the block runs a handler out of
; .data_01_4633_MenuCmd_SubHandlers, and the low byte is that handler's single
; argument. Argument 4 is a font id only when the handler ends up drawing text -
; the staging handlers read the same byte as a destination tile id, and
; MENUCMD_SUB_REMOTE_ICONS reads it as a sprite-hide delay in frames
MACRO menu_cmd_sub ; command id, pen X, pen Y, font/tile id/delay, handler argument, MENUCMD_SUB_*, option slot, MENUCMD_* flags
    db   \1
    db   \2, \3, \4
    db   \5, \6
    db   \7, \8
ENDM

MACRO menu_script_end
    db   MENUSCRIPT_END
ENDM

; Header of a sprite script for call_01_4dc8_Menu_BuildSpriteBlock - the shadow OAM
; slot the first sprite lands in. call_01_4d3b_Menu_EraseSpriteGroup walks the same
; script to blank the sprites again, so a group is drawn and erased by one layout
MACRO menu_sprite_script ; first OAM slot
    db   \1
ENDM

; One rectangle of 8x16 sprites in a sprite script. Y and X are relative to the
; visible screen ($10 and $08 are added back on). An ODD tile byte is not a tile id:
; the rest of it indexes wD5AA_Sprite_TileIdTable, which is how the remote icons
; switch between lit and unlit without a second copy of the layout
MACRO menu_sprite ; Y, X, tile, attributes, width in 8px columns, height in 8px rows
    db   \1, \2, \3, \4, \5, \6
ENDM

MACRO menu_sprite_end
    db   SPRITE_SCRIPT_END
ENDM

; One entry of .data_01_4fef_Password_BitMap - where a single bit of the packed
; payload ends up in the letter grid. The masks are stored as words but only their
; low bytes are ever read
MACRO password_bit ; source address, source mask, destination address, destination mask
    dw   \1, \2, \3, \4
ENDM

MACRO password_bit_end
    dw   $0000
ENDM
