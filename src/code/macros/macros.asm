; Calls a function in a different bank
MACRO FARCALL
    ld   [wD59D_ReturnBank], a
	ld   a, BANK(\1)
	ld   hl, \1
	call call_00_1078_FarCall
ENDM

; Store an address and the associated bank.
macro FARPOINTER
    db   BANK(\1)
    dw   \1
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
