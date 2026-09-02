; bank $22: MUSIC_UNK_04 ch1
;
; One driver track for hardware channel 1 (pulse A), 358 bytes, 112 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $8F
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $B7
.loop:
    audio_reg_set rNR12, $47
    audio_rest $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $1D
    audio_reg_set rNR12, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR12, $97
    audio_note $24, $09                            ; B4
    audio_reg_set rNR12, $A7
    audio_note $25, $27                            ; C5
    audio_reg_set rNR12, $97
    audio_note $20, $09                            ; G4
    audio_reg_set rNR12, $47
    audio_rest $0A
    audio_reg_set rNR12, $97
    audio_note $20, $4D                            ; G4
    audio_reg_set rNR12, $47
    audio_rest $26
    audio_reg_set rNR12, $A7
    audio_note $20, $26                            ; G4
    audio_note $25, $1A                            ; C5
    audio_note $27, $1A                            ; D5
    audio_note $2A, $19                            ; F5
    audio_note $28, $3A                            ; D#5
    audio_note $27, $09                            ; D5
    audio_reg_set rNR12, $97
    audio_note $25, $0A                            ; C5
    audio_note $27, $9A                            ; D5
    audio_reg_set rNR12, $47
    audio_rest $4C
    audio_reg_set rNR12, $A7
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR12, $97
    audio_note $24, $0A                            ; B4
    audio_reg_set rNR12, $A7
    audio_note $25, $26                            ; C5
    audio_note $20, $0A                            ; G4
    audio_reg_set rNR12, $47
    audio_rest $09
    audio_reg_set rNR12, $A7
    audio_note $20, $4D                            ; G4
    audio_reg_set rNR12, $47
    audio_rest $26
    audio_reg_set rNR12, $A7
    audio_note $20, $27                            ; G4
    audio_note $25, $20                            ; C5
    audio_note $27, $19                            ; D5
    audio_note $29, $14                            ; E5
    audio_note $29, $E6                            ; E5
    audio_reg_set rNR12, $47
    audio_rest $4D
    audio_reg_set rNR12, $A7
    audio_note $28, $0A                            ; D#5
    audio_note $27, $09                            ; D5
    audio_note $28, $3A                            ; D#5
    audio_note $23, $4D                            ; A#4
    audio_reg_set rNR12, $47
    audio_rest $26
    audio_reg_set rNR12, $A7
    audio_note $23, $26                            ; A#4
    audio_reg_set rNR12, $97
    audio_note $28, $1A                            ; D#5
    audio_note $2A, $1A                            ; F5
    audio_note $2C, $19                            ; G5
    audio_reg_set rNR12, $A7
    audio_note $2C, $3A                            ; G5
    audio_reg_set rNR12, $97
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR12, $47
    audio_rest $0A
    audio_reg_set rNR12, $97
    audio_note $2A, $E6                            ; F5
    audio_reg_set rNR12, $A7
    audio_note $2D, $13                            ; G#5
    audio_note $2C, $0A                            ; G5
    audio_note $2A, $09                            ; F5
    audio_note $2C, $14                            ; G5
    audio_reg_set rNR12, $97
    audio_note $25, $13                            ; C5
    audio_note $2A, $39                            ; F5
    audio_reg_set rNR12, $A7
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR12, $97
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR12, $A7
    audio_note $27, $99                            ; D5
    audio_reg_set rNR12, $47
    audio_rest $4D
    audio_reg_set rNR12, $87
    audio_note $24, $09                            ; B4
    audio_note $25, $0A                            ; C5
    audio_note $27, $90                            ; D5
    audio_reg_set rNR12, $47
    audio_rest $43
    audio_reg_set rNR12, $87
    audio_note $2C, $0A                            ; G5
    audio_note $2D, $09                            ; G#5
    audio_note $2F, $87                            ; A#5
    audio_reg_set rNR12, $97
    audio_note $23, $19                            ; A#4
    audio_reg_set rNR12, $87
    audio_note $25, $1A                            ; C5
    audio_note $26, $1A                            ; C#5
    audio_note $28, $19                            ; D#5
    audio_note $26, $1A                            ; C#5
    audio_note $25, $19                            ; C5
    audio_note $26, $1A                            ; C#5
    audio_note $2A, $1A                            ; F5
    audio_reg_set rNR12, $97
    audio_note $28, $19                            ; D#5
    audio_reg_set rNR12, $77
    audio_note $2B, $1A                            ; F#5
    audio_reg_set rNR12, $87
    audio_note $2D, $19                            ; G#5
    audio_note $2F, $1A                            ; A#5
    audio_reg_set rNR12, $47
    audio_rest $26
    audio_reg_set rNR12, $87
    audio_note $25, $27                            ; C5
    audio_note $25, $20                            ; C5
    audio_note $27, $19                            ; D5
    audio_note $29, $14                            ; E5
    audio_reg_set rNR12, $97
    audio_note $29, $39                            ; E5
    audio_reg_set rNR12, $87
    audio_note $27, $13                            ; D5
    audio_note $27, $4D                            ; D5
    audio_note $2C, $3A                            ; G5
    audio_note $25, $13                            ; C5
    audio_reg_set rNR12, $97
    audio_note $29, $20                            ; E5
    audio_note $27, $1A                            ; D5
    audio_reg_set rNR12, $87
    audio_note $25, $13                            ; C5
    audio_reg_set rNR12, $97
    audio_note $27, $4D                            ; D5
    audio_reg_set rNR12, $47
    audio_rest $4C
    audio_reg_set rNR12, $97
    audio_note $25, $3A                            ; C5
    audio_reg_set rNR12, $67
    audio_note $20, $13                            ; G4
    audio_reg_set rNR12, $87
    audio_note $2A, $20                            ; F5
    audio_note $29, $1A                            ; E5
    audio_note $25, $13                            ; C5
    audio_note $2C, $3A                            ; G5
    audio_note $2D, $13                            ; G#5
    audio_note $28, $4D                            ; D#5
    audio_reg_set rNR12, $97
    audio_note $28, $39                            ; D#5
    audio_reg_set rNR12, $87
    audio_note $25, $0A                            ; C5
    audio_reg_set rNR12, $97
    audio_note $27, $09                            ; D5
    audio_reg_set rNR12, $87
    audio_note $28, $1D                            ; D#5
    audio_note $27, $1D                            ; D5
    audio_note $25, $13                            ; C5
    audio_note $27, $3A                            ; D5
    audio_note $2C, $13                            ; G5
    audio_note $2C, $4D                            ; G5
    audio_reg_set rNR12, $47
    audio_rest $99
    audio_sustain $9A
    audio_loop .loop
