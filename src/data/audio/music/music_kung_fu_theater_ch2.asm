; bank $21: MUSIC_KUNG_FU_THEATER ch2
;
; One driver track for hardware channel 2 (pulse B), 638 bytes, 174 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $77
.loop:
    audio_reg_set rNR22, $57
    audio_note $24, $0A                            ; B4
    audio_reg_set rNR22, $47
    audio_note $24, $09                            ; B4
    audio_note $24, $0A                            ; B4
    audio_note $24, $09                            ; B4
    audio_reg_set rNR22, $57
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $22, $09                            ; A4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $22, $0A                            ; A4
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $1D, $09                            ; E4
    audio_reg_set rNR22, $07
    audio_sustain $14
    audio_reg_set rNR22, $77
    audio_rest $9A
    audio_sustain $99
    audio_sustain $9A
    audio_sustain $99
    audio_sustain $9A
    audio_sustain $9A
    audio_sustain $99
    audio_sustain $9A
    audio_reg_set rNR22, $77
    audio_rest $9A
    audio_sustain $99
    audio_reg_set rNR22, $47
    audio_note $29, $13                            ; E5
    audio_note $26, $0A                            ; C#5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $26, $13                            ; C#5
    audio_note $29, $13                            ; E5
    audio_reg_set rNR22, $47
    audio_note $2B, $13                            ; F#5
    audio_reg_set rNR22, $57
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $57
    audio_note $29, $27                            ; E5
    audio_reg_set rNR22, $77
    audio_sustain $99
    audio_reg_set rNR22, $57
    audio_note $26, $0A                            ; C#5
    audio_reg_set rNR22, $47
    audio_note $26, $0A                            ; C#5
    audio_note $26, $09                            ; C#5
    audio_note $26, $0A                            ; C#5
    audio_reg_set rNR22, $57
    audio_note $24, $09                            ; B4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $24, $0A                            ; B4
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $57
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $57
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $24, $26                            ; B4
    audio_reg_set rNR22, $07
    audio_sustain $9A
    audio_reg_set rNR22, $77
    audio_rest $99
    audio_reg_set rNR22, $27
    audio_note $21, $0A                            ; G#4
    audio_note $1F, $09                            ; F#4
    audio_note $18, $0A                            ; B3
    audio_note $1A, $0A                            ; C#4
    audio_note $1C, $09                            ; D#4
    audio_note $1F, $0A                            ; F#4
    audio_note $1C, $09                            ; D#4
    audio_note $1A, $0A                            ; C#4
    audio_note $18, $4D                            ; B3
    audio_reg_set rNR22, $77
    audio_rest $9A
    audio_sustain $99
    audio_sustain $9A
    audio_reg_set rNR22, $57
    audio_note $24, $09                            ; B4
    audio_reg_set rNR22, $47
    audio_note $24, $0A                            ; B4
    audio_note $24, $0A                            ; B4
    audio_note $24, $09                            ; B4
    audio_reg_set rNR22, $57
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $57
    audio_note $22, $0A                            ; A4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $1F, $09                            ; F#4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $22, $09                            ; A4
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $1D, $09                            ; E4
    audio_reg_set rNR22, $07
    audio_sustain $13
    audio_reg_set rNR22, $77
    audio_rest $9A
    audio_sustain $9A
    audio_sustain $99
    audio_sustain $9A
    audio_reg_set rNR22, $37
    audio_note $25, $1D                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $37
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $27
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $25, $26                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $14
    audio_reg_set rNR22, $37
    audio_note $10, $09                            ; D#3
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $10, $09                            ; D#3
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $12, $0A                            ; F3
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $47
    audio_note $12, $0A                            ; F3
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $47
    audio_note $08, $0A                            ; G2
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $08, $09                            ; G2
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $27
    audio_note $0B, $09                            ; A#2
    audio_reg_set rNR22, $07
    audio_sustain $1D
    audio_reg_set rNR22, $37
    audio_note $25, $1D                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $27
    audio_note $28, $09                            ; D#5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $37
    audio_note $25, $13                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $14
    audio_reg_set rNR22, $37
    audio_note $19, $39                            ; C4
    audio_reg_set rNR22, $47
    audio_note $18, $4D                            ; B3
    audio_reg_set rNR22, $07
    audio_sustain $13
    audio_reg_set rNR22, $37
    audio_note $17, $13                            ; A#3
    audio_reg_set rNR22, $47
    audio_note $25, $1D                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $27, $09                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $37
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $37
    audio_note $25, $14                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $26
    audio_reg_set rNR22, $37
    audio_note $10, $0A                            ; D#3
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $47
    audio_note $10, $0A                            ; D#3
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $57
    audio_note $12, $0A                            ; F3
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $12, $09                            ; F3
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $08, $09                            ; G2
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $08, $0A                            ; G2
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $27
    audio_note $0B, $0A                            ; A#2
    audio_reg_set rNR22, $07
    audio_sustain $1D
    audio_reg_set rNR22, $47
    audio_note $25, $1C                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $37
    audio_note $28, $0A                            ; D#5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $37
    audio_note $27, $0A                            ; D5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $37
    audio_note $25, $13                            ; C5
    audio_reg_set rNR22, $07
    audio_sustain $13
    audio_reg_set rNR22, $47
    audio_note $19, $3A                            ; C4
    audio_note $18, $4C                            ; B3
    audio_reg_set rNR22, $07
    audio_sustain $14
    audio_reg_set rNR22, $17
    audio_note $17, $09                            ; A#3
    audio_reg_set rNR22, $07
    audio_sustain $A3
    audio_reg_set rNR22, $77
    audio_rest $9A
    audio_sustain $9A
    audio_reg_set rNR22, $47
    audio_note $29, $09                            ; E5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $47
    audio_note $26, $09                            ; C#5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $26, $0A                            ; C#5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $57
    audio_note $29, $0A                            ; E5
    audio_reg_set rNR22, $07
    audio_sustain $09
    audio_reg_set rNR22, $47
    audio_note $2B, $0A                            ; F#5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $29, $09                            ; E5
    audio_reg_set rNR22, $07
    audio_sustain $0A
    audio_reg_set rNR22, $57
    audio_note $29, $09                            ; E5
    audio_reg_set rNR22, $07
    audio_sustain $1D
    audio_loop .loop
