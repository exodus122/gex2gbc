; bank $21: MUSIC_KUNG_FU_THEATER ch1
;
; One driver track for hardware channel 1 (pulse A), 660 bytes, 175 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $87
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
.loop:
    audio_reg_set rNR12, $57
    audio_note $1A, $0A                            ; C#4
    audio_reg_set rNR12, $47
    audio_note $1A, $09                            ; C#4
    audio_note $1A, $0A                            ; C#4
    audio_reg_set rNR12, $37
    audio_note $1A, $09                            ; C#4
    audio_reg_set rNR12, $47
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $18, $13                            ; B3
    audio_note $15, $09                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR12, $57
    audio_note $15, $09                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $57
    audio_note $13, $09                            ; F#3
    audio_note $11, $14                            ; E3
    audio_reg_set rNR12, $07
    audio_sustain $9A
    audio_reg_set rNR12, $77
    audio_rest $99
    audio_sustain $9A
    audio_sustain $99
    audio_sustain $9A
    audio_sustain $9A
    audio_sustain $99
    audio_sustain $9A
    audio_reg_set rNR12, $77
    audio_sustain $9A
    audio_sustain $99
    audio_reg_set rNR12, $37
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $B6
    audio_reg_set rNR12, $57
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR12, $47
    audio_note $1C, $0A                            ; D#4
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR12, $37
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR12, $47
    audio_note $1A, $09                            ; C#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $1A, $13                            ; C#4
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $1A, $26                            ; C#4
    audio_reg_set rNR12, $07
    audio_sustain $9A
    audio_reg_set rNR12, $77
    audio_rest $99
    audio_reg_set rNR12, $47
    audio_note $26, $0A                            ; C#5
    audio_note $24, $09                            ; B4
    audio_note $1D, $0A                            ; E4
    audio_note $1F, $0A                            ; F#4
    audio_note $21, $09                            ; G#4
    audio_note $24, $0A                            ; B4
    audio_note $21, $09                            ; G#4
    audio_note $1F, $0A                            ; F#4
    audio_note $1D, $4D                            ; E4
    audio_reg_set rNR12, $77
    audio_rest $9A
    audio_sustain $99
    audio_sustain $9A
    audio_reg_set rNR12, $57
    audio_note $1A, $09                            ; C#4
    audio_reg_set rNR12, $47
    audio_note $1A, $0A                            ; C#4
    audio_note $1A, $0A                            ; C#4
    audio_reg_set rNR12, $37
    audio_note $1A, $09                            ; C#4
    audio_reg_set rNR12, $47
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $18, $14                            ; B3
    audio_note $15, $09                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $18, $09                            ; B3
    audio_reg_set rNR12, $57
    audio_note $15, $0A                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $57
    audio_note $13, $09                            ; F#3
    audio_note $11, $13                            ; E3
    audio_reg_set rNR12, $77
    audio_rest $9A
    audio_sustain $9A
    audio_sustain $99
    audio_sustain $9A
    audio_reg_set rNR12, $37
    audio_note $2A, $1D                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $27
    audio_note $2D, $09                            ; G#5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2A, $26                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $14
    audio_reg_set rNR12, $37
    audio_note $15, $09                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $15, $09                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $57
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $0D, $0A                            ; C3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $0D, $09                            ; C3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $27
    audio_note $10, $09                            ; D#3
    audio_reg_set rNR12, $07
    audio_sustain $1D
    audio_reg_set rNR12, $37
    audio_note $2A, $1D                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $27
    audio_note $2D, $09                            ; G#5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $2A, $13                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $14
    audio_reg_set rNR12, $37
    audio_note $1E, $39                            ; F4
    audio_reg_set rNR12, $47
    audio_note $1D, $4D                            ; E4
    audio_reg_set rNR12, $07
    audio_sustain $13
    audio_reg_set rNR12, $37
    audio_note $1C, $13                            ; D#4
    audio_reg_set rNR12, $47
    audio_note $2A, $1D                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2D, $0A                            ; G#5
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $2A, $14                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $26
    audio_reg_set rNR12, $37
    audio_note $15, $0A                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $15, $0A                            ; G#3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $57
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $17, $09                            ; A#3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $0D, $09                            ; C3
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $0D, $0A                            ; C3
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $27
    audio_note $10, $0A                            ; D#3
    audio_reg_set rNR12, $07
    audio_sustain $1D
    audio_reg_set rNR12, $47
    audio_note $2A, $1C                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $2D, $0A                            ; G#5
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $2C, $0A                            ; G5
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $2A, $13                            ; F5
    audio_reg_set rNR12, $07
    audio_sustain $13
    audio_reg_set rNR12, $47
    audio_note $1E, $3A                            ; F4
    audio_note $1D, $4C                            ; E4
    audio_reg_set rNR12, $07
    audio_sustain $14
    audio_reg_set rNR12, $17
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR12, $07
    audio_sustain $A3
    audio_reg_set rNR12, $77
    audio_rest $9A
    audio_sustain $9A
    audio_reg_set rNR12, $37
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $47
    audio_note $1C, $09                            ; D#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $09
    audio_reg_set rNR12, $37
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $0A
    audio_reg_set rNR12, $37
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR12, $07
    audio_sustain $1D
    audio_loop .loop
