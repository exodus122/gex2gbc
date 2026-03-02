; Calls a function in a different bank
MACRO farcall
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
