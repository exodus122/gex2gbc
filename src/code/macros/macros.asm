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
; Block patch sequences - the animation phase of a cutscene, and the same format
; the tile hit scripts in bank00_tile_hit_scripts.asm use
; ==================================================================

; Sequence header. The rectangle is positioned relative to GEX, not to the map,
; which is why a scene with an animation always teleports him somewhere fixed first
MACRO blockpatch_anim  ; callback (0 = none), step count, frames per step, X, Y, width, height
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
