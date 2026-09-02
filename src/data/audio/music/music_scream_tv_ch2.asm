; bank $22: MUSIC_SCREAM_TV ch2
;
; One driver track for hardware channel 2 (pulse B), 658 bytes, 257 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $A7
.loop:
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_rest $78
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $87
    audio_sustain $08
    audio_rest $38
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $87
    audio_sustain $08
    audio_rest $18
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $87
    audio_sustain $08
    audio_rest $18
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $87
    audio_sustain $08
    audio_rest $18
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $87
    audio_sustain $08
    audio_rest $18
    audio_rest $20
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $87
    audio_sustain $08
    audio_rest $18
    audio_reg_set rNR22, $37
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_note $0D, $08                            ; C3
    audio_note $0E, $08                            ; C#3
    audio_note $0F, $08                            ; D3
    audio_note $10, $08                            ; D#3
    audio_reg_set rNR22, $17
    audio_sustain $08
    audio_rest $78
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_reg_set rNR22, $57
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $19, $10                            ; C4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1D, $10                            ; E4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $19, $10                            ; C4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1D, $10                            ; E4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_reg_set rNR22, $17
    audio_sustain $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_sustain $08
    audio_rest $78
    audio_note $20, $80                            ; G4
    audio_sustain $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_reg_set rNR22, $57
    audio_note $1A, $10                            ; C#4
    audio_note $1C, $10                            ; D#4
    audio_note $1D, $10                            ; E4
    audio_note $1F, $10                            ; F#4
    audio_note $20, $10                            ; G4
    audio_note $22, $10                            ; A4
    audio_note $23, $10                            ; A#4
    audio_note $25, $10                            ; C5
    audio_note $1A, $10                            ; C#4
    audio_note $1C, $10                            ; D#4
    audio_note $1D, $10                            ; E4
    audio_note $1F, $10                            ; F#4
    audio_note $20, $10                            ; G4
    audio_note $22, $10                            ; A4
    audio_note $23, $10                            ; A#4
    audio_note $25, $10                            ; C5
    audio_note $19, $10                            ; C4
    audio_note $1B, $10                            ; D4
    audio_note $1C, $10                            ; D#4
    audio_note $1E, $10                            ; F4
    audio_note $1F, $10                            ; F#4
    audio_note $21, $10                            ; G#4
    audio_note $22, $10                            ; A4
    audio_note $24, $10                            ; B4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $19, $10                            ; C4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1D, $10                            ; E4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_reg_set rNR22, $17
    audio_sustain $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_note $20, $80                            ; G4
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_reg_set rNR22, $57
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_note $1C, $40                            ; D#4
    audio_note $19, $38                            ; C4
    audio_note $25, $08                            ; C5
    audio_note $22, $40                            ; A4
    audio_note $1F, $40                            ; F#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $47
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $19, $10                            ; C4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1A, $20                            ; C#4
    audio_reg_set rNR22, $37
    audio_note $20, $10                            ; G4
    audio_reg_set rNR22, $57
    audio_note $1D, $10                            ; E4
    audio_note $1E, $40                            ; F4
    audio_note $1B, $38                            ; D4
    audio_note $27, $08                            ; D5
    audio_note $25, $40                            ; C5
    audio_note $22, $40                            ; A4
    audio_loop .loop
