; bank $22: MUSIC_UNK_04 ch2
;
; One driver track for hardware channel 2 (pulse B), 1934 bytes, 603 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $B7
.loop:
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $09                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $20, $09                            ; G4
    audio_note $1E, $0A                            ; F4
    audio_note $19, $09                            ; C4
    audio_note $1E, $0A                            ; F4
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $97
    audio_note $1E, $0A                            ; F4
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $25, $09                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $97
    audio_note $1E, $09                            ; F4
    audio_note $19, $0A                            ; C4
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $87
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR22, $97
    audio_note $19, $0A                            ; C4
    audio_note $1E, $09                            ; F4
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $87
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $1E, $0A                            ; F4
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $97
    audio_note $1C, $0A                            ; D#4
    audio_note $19, $09                            ; C4
    audio_note $1E, $0A                            ; F4
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_note $23, $09                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $20, $0A                            ; G4
    audio_note $1E, $0A                            ; F4
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $97
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $87
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $97
    audio_note $20, $0A                            ; G4
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_note $20, $0A                            ; G4
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $97
    audio_note $19, $0A                            ; C4
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $87
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR22, $97
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $97
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_note $23, $09                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_note $23, $09                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $20, $09                            ; G4
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $87
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $0A                            ; F4
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $87
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $09                            ; A#4
    audio_note $20, $0A                            ; G4
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $A7
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $97
    audio_note $1E, $0A                            ; F4
    audio_note $1C, $09                            ; D#4
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $97
    audio_note $19, $0A                            ; C4
    audio_note $20, $0A                            ; G4
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $09                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $1E, $0A                            ; F4
    audio_note $20, $0A                            ; G4
    audio_note $22, $04                            ; A4
    audio_reg_set rNR22, $A7
    audio_note $2A, $05                            ; F5
    audio_reg_set rNR22, $97
    audio_note $27, $05                            ; D5
    audio_note $25, $05                            ; C5
    audio_note $22, $05                            ; A4
    audio_note $20, $04                            ; G4
    audio_note $22, $05                            ; A4
    audio_reg_set rNR22, $A7
    audio_note $25, $05                            ; C5
    audio_note $27, $05                            ; D5
    audio_note $29, $05                            ; E5
    audio_note $2A, $04                            ; F5
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $B7
    audio_note $2E, $05                            ; A5
    audio_note $30, $05                            ; B5
    audio_reg_set rNR22, $B7
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $77
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $25, $0A                            ; C5
    audio_note $20, $09                            ; G4
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $77
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $87
    audio_note $29, $09                            ; E5
    audio_note $2C, $0A                            ; G5
    audio_note $20, $09                            ; G4
    audio_note $29, $0A                            ; E5
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $77
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $29, $0A                            ; E5
    audio_note $25, $09                            ; C5
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $77
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $77
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $27, $09                            ; D5
    audio_note $29, $0A                            ; E5
    audio_note $2C, $09                            ; G5
    audio_note $20, $0A                            ; G4
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $77
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $87
    audio_note $25, $0A                            ; C5
    audio_note $29, $09                            ; E5
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $77
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $20, $09                            ; G4
    audio_note $25, $0A                            ; C5
    audio_note $20, $0A                            ; G4
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $77
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $87
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $2C, $0A                            ; G5
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $97
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $87
    audio_note $27, $0A                            ; D5
    audio_note $25, $09                            ; C5
    audio_note $28, $0A                            ; D#5
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_note $20, $0A                            ; G4
    audio_note $25, $0A                            ; C5
    audio_note $20, $09                            ; G4
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $77
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $87
    audio_note $28, $0A                            ; D#5
    audio_note $2C, $0A                            ; G5
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $97
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $87
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $77
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $97
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $28, $0A                            ; D#5
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $77
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_note $20, $0A                            ; G4
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $77
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $87
    audio_note $29, $0A                            ; E5
    audio_note $2C, $09                            ; G5
    audio_note $20, $0A                            ; G4
    audio_note $29, $09                            ; E5
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $77
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $29, $09                            ; E5
    audio_note $25, $0A                            ; C5
    audio_note $29, $09                            ; E5
    audio_reg_set rNR22, $77
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $87
    audio_note $25, $0A                            ; C5
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $77
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $27, $0A                            ; D5
    audio_note $29, $09                            ; E5
    audio_note $2C, $0A                            ; G5
    audio_note $20, $09                            ; G4
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $77
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_note $29, $0A                            ; E5
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $97
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $77
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $97
    audio_note $25, $09                            ; C5
    audio_note $25, $01                            ; C5
    audio_reg_set rNR22, $77
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_note $20, $0A                            ; G4
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $77
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $87
    audio_note $29, $0A                            ; E5
    audio_note $2C, $09                            ; G5
    audio_note $20, $0A                            ; G4
    audio_note $29, $0A                            ; E5
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $77
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $29, $09                            ; E5
    audio_note $25, $0A                            ; C5
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $77
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $87
    audio_note $25, $0A                            ; C5
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $77
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $97
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $27, $0A                            ; D5
    audio_note $29, $09                            ; E5
    audio_note $2C, $0A                            ; G5
    audio_note $20, $0E                            ; G4
    audio_reg_set rNR22, $B7
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR22, $97
    audio_note $2A, $05                            ; F5
    audio_note $29, $05                            ; E5
    audio_reg_set rNR22, $77
    audio_note $27, $05                            ; D5
    audio_reg_set rNR22, $A7
    audio_note $24, $04                            ; B4
    audio_note $25, $05                            ; C5
    audio_reg_set rNR22, $87
    audio_note $29, $05                            ; E5
    audio_reg_set rNR22, $A7
    audio_note $29, $01                            ; E5
    audio_note $2A, $04                            ; F5
    audio_reg_set rNR22, $B7
    audio_note $2C, $05                            ; G5
    audio_note $2E, $04                            ; A5
    audio_note $30, $05                            ; B5
    audio_note $31, $05                            ; C6
    audio_note $33, $05                            ; D6
    audio_reg_set rNR22, $B7
    audio_note $34, $0A                            ; D#6
    audio_reg_set rNR22, $77
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_note $20, $09                            ; G4
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $77
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $87
    audio_note $28, $09                            ; D#5
    audio_note $2C, $0A                            ; G5
    audio_note $20, $09                            ; G4
    audio_note $28, $0A                            ; D#5
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $87
    audio_note $28, $0A                            ; D#5
    audio_note $23, $09                            ; A#4
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $87
    audio_note $23, $09                            ; A#4
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $77
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $87
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $97
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $87
    audio_note $28, $09                            ; D#5
    audio_note $28, $0A                            ; D#5
    audio_note $2C, $09                            ; G5
    audio_note $20, $0A                            ; G4
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_note $28, $09                            ; D#5
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $97
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $77
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $25, $0A                            ; C5
    audio_note $20, $0A                            ; G4
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $77
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $87
    audio_note $29, $09                            ; E5
    audio_note $2D, $0A                            ; G#5
    audio_note $21, $0A                            ; G#4
    audio_note $2A, $09                            ; F5
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $77
    audio_note $26, $09                            ; C#5
    audio_reg_set rNR22, $87
    audio_note $2A, $0A                            ; F5
    audio_note $26, $0A                            ; C#5
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $77
    audio_note $2B, $0A                            ; F#5
    audio_reg_set rNR22, $87
    audio_note $26, $09                            ; C#5
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR22, $77
    audio_note $26, $0A                            ; C#5
    audio_reg_set rNR22, $87
    audio_note $21, $09                            ; G#4
    audio_reg_set rNR22, $97
    audio_note $26, $0A                            ; C#5
    audio_reg_set rNR22, $87
    audio_note $28, $09                            ; D#5
    audio_note $2A, $0A                            ; F5
    audio_note $2D, $0A                            ; G#5
    audio_note $21, $09                            ; G#4
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $77
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $87
    audio_note $26, $0A                            ; C#5
    audio_note $20, $05                            ; G4
    audio_note $21, $05                            ; G#4
    audio_note $23, $04                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $25, $05                            ; C5
    audio_note $26, $05                            ; C#5
    audio_note $28, $05                            ; D#5
    audio_note $2A, $05                            ; F5
    audio_note $2C, $04                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $04                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $04                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $04                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $04                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $04                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $04                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $97
    audio_note $2D, $05                            ; G#5
    audio_reg_set rNR22, $87
    audio_note $2C, $05                            ; G5
    audio_reg_set rNR22, $77
    audio_note $30, $0C                            ; B5
    audio_reg_set rNR22, $87
    audio_note $2E, $0D                            ; A5
    audio_note $30, $0D                            ; B5
    audio_note $2E, $0D                            ; A5
    audio_reg_set rNR22, $97
    audio_note $30, $0D                            ; B5
    audio_note $31, $0C                            ; C6
    audio_reg_set rNR22, $A7
    audio_note $33, $0D                            ; D6
    audio_reg_set rNR22, $97
    audio_note $31, $0D                            ; C6
    audio_note $33, $0D                            ; D6
    audio_reg_set rNR22, $87
    audio_note $34, $0D                            ; D#6
    audio_note $33, $0C                            ; D6
    audio_reg_set rNR22, $77
    audio_note $31, $0D                            ; C6
    audio_reg_set rNR22, $77
    audio_note $22, $0A                            ; A4
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $47
    audio_rest $0A
    audio_reg_set rNR22, $77
    audio_note $22, $09                            ; A4
    audio_note $22, $0A                            ; A4
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $47
    audio_rest $09
    audio_reg_set rNR22, $77
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $87
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $77
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $47
    audio_rest $0A
    audio_reg_set rNR22, $77
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $87
    audio_note $22, $0A                            ; A4
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $47
    audio_rest $0A
    audio_reg_set rNR22, $87
    audio_note $22, $0A                            ; A4
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $77
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $47
    audio_rest $09
    audio_reg_set rNR22, $87
    audio_note $22, $0A                            ; A4
    audio_note $22, $0A                            ; A4
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $47
    audio_rest $0A
    audio_reg_set rNR22, $87
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $77
    audio_note $23, $0A                            ; A#4
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $47
    audio_rest $09
    audio_reg_set rNR22, $77
    audio_note $23, $0A                            ; A#4
    audio_note $23, $09                            ; A#4
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $47
    audio_rest $0A
    audio_reg_set rNR22, $77
    audio_note $23, $09                            ; A#4
    audio_note $23, $0A                            ; A#4
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $47
    audio_rest $0A
    audio_reg_set rNR22, $77
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $87
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $77
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $47
    audio_rest $09
    audio_reg_set rNR22, $77
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $47
    audio_rest $4D
    audio_reg_set rNR22, $97
    audio_note $2F, $19                            ; A#5
    audio_note $31, $1A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $32, $1A                            ; C#6
    audio_note $34, $19                            ; D#6
    audio_reg_set rNR22, $97
    audio_note $32, $1A                            ; C#6
    audio_reg_set rNR22, $87
    audio_note $31, $19                            ; C6
    audio_note $32, $1A                            ; C#6
    audio_note $36, $1A                            ; F6
    audio_reg_set rNR22, $97
    audio_note $34, $19                            ; D#6
    audio_reg_set rNR22, $77
    audio_note $37, $1A                            ; F#6
    audio_reg_set rNR22, $97
    audio_note $39, $0D                            ; G#6
    audio_note $2F, $04                            ; A#5
    audio_note $31, $05                            ; C6
    audio_note $32, $05                            ; C#6
    audio_note $34, $05                            ; D#6
    audio_note $36, $05                            ; F6
    audio_note $37, $04                            ; F#6
    audio_reg_set rNR22, $87
    audio_note $39, $05                            ; G#6
    audio_reg_set rNR22, $97
    audio_note $3B, $05                            ; A#6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_note $3C, $09                            ; B6
    audio_note $38, $0A                            ; G6
    audio_reg_set rNR22, $77
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $97
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR22, $77
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $38, $09                            ; G6
    audio_note $3C, $0A                            ; B6
    audio_reg_set rNR22, $97
    audio_note $3D, $09                            ; C7
    audio_reg_set rNR22, $87
    audio_note $3C, $0A                            ; B6
    audio_note $38, $0A                            ; G6
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $97
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR22, $87
    audio_note $31, $09                            ; C6
    audio_note $38, $0A                            ; G6
    audio_reg_set rNR22, $77
    audio_note $3C, $0A                            ; B6
    audio_reg_set rNR22, $87
    audio_note $3D, $09                            ; C7
    audio_reg_set rNR22, $77
    audio_note $39, $0A                            ; G#6
    audio_note $35, $09                            ; E6
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2D, $0A                            ; G#5
    audio_reg_set rNR22, $77
    audio_note $31, $09                            ; C6
    audio_note $35, $0A                            ; E6
    audio_reg_set rNR22, $67
    audio_note $39, $09                            ; G#6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_reg_set rNR22, $67
    audio_note $39, $0A                            ; G#6
    audio_reg_set rNR22, $77
    audio_note $35, $09                            ; E6
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2D, $09                            ; G#5
    audio_reg_set rNR22, $77
    audio_note $31, $0A                            ; C6
    audio_note $35, $0A                            ; E6
    audio_note $39, $09                            ; G#6
    audio_note $3D, $0A                            ; C7
    audio_note $3C, $09                            ; B6
    audio_note $38, $0A                            ; G6
    audio_reg_set rNR22, $67
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR22, $67
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $77
    audio_note $38, $09                            ; G6
    audio_note $3C, $0A                            ; B6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_reg_set rNR22, $77
    audio_note $36, $09                            ; F6
    audio_note $35, $0A                            ; E6
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2A, $0A                            ; F5
    audio_reg_set rNR22, $77
    audio_note $31, $0A                            ; C6
    audio_note $35, $09                            ; E6
    audio_reg_set rNR22, $67
    audio_note $36, $0A                            ; F6
    audio_reg_set rNR22, $77
    audio_note $3D, $09                            ; C7
    audio_note $3B, $0A                            ; A#6
    audio_note $36, $0A                            ; F6
    audio_reg_set rNR22, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2F, $0A                            ; A#5
    audio_reg_set rNR22, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $77
    audio_note $36, $0A                            ; F6
    audio_note $3B, $0A                            ; A#6
    audio_reg_set rNR22, $87
    audio_note $3D, $09                            ; C7
    audio_reg_set rNR22, $77
    audio_note $3B, $0A                            ; A#6
    audio_note $36, $09                            ; F6
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2F, $0A                            ; A#5
    audio_reg_set rNR22, $77
    audio_note $31, $09                            ; C6
    audio_note $36, $0A                            ; F6
    audio_reg_set rNR22, $67
    audio_note $3B, $09                            ; A#6
    audio_reg_set rNR22, $77
    audio_note $3D, $0A                            ; C7
    audio_note $3C, $0A                            ; B6
    audio_note $38, $09                            ; G6
    audio_reg_set rNR22, $67
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR22, $67
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $77
    audio_note $38, $0A                            ; G6
    audio_note $3C, $09                            ; B6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_reg_set rNR22, $77
    audio_note $3C, $09                            ; B6
    audio_note $38, $0A                            ; G6
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR22, $77
    audio_note $31, $0A                            ; C6
    audio_note $38, $09                            ; G6
    audio_reg_set rNR22, $67
    audio_note $3C, $0A                            ; B6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_reg_set rNR22, $77
    audio_note $3B, $09                            ; A#6
    audio_note $36, $0A                            ; F6
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR22, $87
    audio_note $2D, $0A                            ; G#5
    audio_reg_set rNR22, $77
    audio_note $34, $0A                            ; D#6
    audio_note $36, $09                            ; F6
    audio_reg_set rNR22, $67
    audio_note $3B, $0A                            ; A#6
    audio_reg_set rNR22, $87
    audio_note $3D, $09                            ; C7
    audio_reg_set rNR22, $67
    audio_note $3B, $0A                            ; A#6
    audio_reg_set rNR22, $77
    audio_note $36, $0A                            ; F6
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR22, $87
    audio_note $2D, $0A                            ; G#5
    audio_reg_set rNR22, $77
    audio_note $34, $09                            ; D#6
    audio_note $36, $0A                            ; F6
    audio_note $3B, $0A                            ; A#6
    audio_note $3D, $09                            ; C7
    audio_note $38, $0A                            ; G6
    audio_note $36, $09                            ; F6
    audio_reg_set rNR22, $67
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2F, $0A                            ; A#5
    audio_reg_set rNR22, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $77
    audio_note $36, $0A                            ; F6
    audio_note $38, $09                            ; G6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_reg_set rNR22, $77
    audio_note $38, $0A                            ; G6
    audio_note $36, $09                            ; F6
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $87
    audio_note $2F, $09                            ; A#5
    audio_reg_set rNR22, $77
    audio_note $31, $0A                            ; C6
    audio_note $36, $0A                            ; F6
    audio_reg_set rNR22, $67
    audio_note $38, $09                            ; G6
    audio_reg_set rNR22, $87
    audio_note $3D, $0A                            ; C7
    audio_reg_set rNR22, $77
    audio_note $38, $09                            ; G6
    audio_note $36, $0A                            ; F6
    audio_note $33, $0A                            ; D6
    audio_reg_set rNR22, $87
    audio_note $36, $09                            ; F6
    audio_reg_set rNR22, $77
    audio_note $33, $0A                            ; D6
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $67
    audio_note $2E, $0A                            ; A5
    audio_reg_set rNR22, $87
    audio_note $33, $0A                            ; D6
    audio_reg_set rNR22, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR22, $77
    audio_note $2C, $0A                            ; G5
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $87
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR22, $77
    audio_note $2C, $0A                            ; G5
    audio_note $2A, $09                            ; F5
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $87
    audio_note $25, $09                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $77
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $09                            ; A#4
    audio_note $25, $0A                            ; C5
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $87
    audio_note $1E, $0A                            ; F4
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $87
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR22, $A7
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $97
    audio_note $1E, $0A                            ; F4
    audio_note $19, $09                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $77
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $25, $0A                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $25, $09                            ; C5
    audio_note $23, $0A                            ; A#4
    audio_note $25, $09                            ; C5
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_reg_set rNR22, $97
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR22, $87
    audio_note $1E, $09                            ; F4
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR22, $97
    audio_note $1C, $0A                            ; D#4
    audio_note $19, $0A                            ; C4
    audio_note $1E, $09                            ; F4
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $A7
    audio_note $20, $09                            ; G4
    audio_reg_set rNR22, $87
    audio_note $23, $0A                            ; A#4
    audio_loop .loop
