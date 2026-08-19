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

; One part of an entity sprite layout in bank03_sprite_shapes.asm and in
; .data_03_608e_EntitySpriteLayoutPointerTable: a signed offset from the entity's
; screen position, a tile number relative to the entity's tile base, and attribute
; bits that get OR'd on top of wD335_Entity_OamAttr. Sprites are 8x16, so a part is
; 8 wide and 16 tall and tile numbers step by 2 down a column
MACRO obj_part ; dY, dX, tile, attributes
    db   \1, \2, \3, \4
ENDM
