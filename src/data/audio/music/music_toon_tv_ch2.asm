; bank $23: MUSIC_TOON_TV ch2
;
; One driver track for hardware channel 2 (pulse B), 1580 bytes, 418 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $B7
.loop:
    audio_reg_set rNR22, $67
    audio_note $11, $0B                            ; E3
    audio_reg_set rNR22, $77
    audio_note $15, $0A                            ; G#3
    audio_note $11, $0B                            ; E3
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $18, $0A                            ; B3
    audio_note $1D, $01                            ; E4
    audio_reg_set rNR22, $87
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR22, $77
    audio_note $1D, $0B                            ; E4
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR22, $67
    audio_note $1E, $4B                            ; F4
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $B7
    audio_rest $35
    audio_reg_set rNR22, $77
    audio_note $14, $0B                            ; G3
    audio_note $15, $15                            ; G#3
    audio_note $11, $2B                            ; E3
    audio_reg_set rNR22, $47
    audio_sustain $35
    audio_reg_set rNR22, $77
    audio_note $14, $0B                            ; G3
    audio_note $15, $30                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $25
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $77
    audio_note $1D, $10                            ; E4
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR22, $87
    audio_note $1C, $0B                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $16, $0A                            ; A3
    audio_reg_set rNR22, $77
    audio_note $10, $0B                            ; D#3
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $67
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $67
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $67
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $67
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $67
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $57
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $18, $0B                            ; B3
    audio_note $18, $01                            ; B3
    audio_reg_set rNR22, $67
    audio_note $17, $14                            ; A#3
    audio_reg_set rNR22, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR22, $67
    audio_note $18, $01                            ; B3
    audio_reg_set rNR22, $47
    audio_sustain $14
    audio_reg_set rNR22, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR22, $67
    audio_note $18, $01                            ; B3
    audio_note $17, $14                            ; A#3
    audio_reg_set rNR22, $77
    audio_note $18, $0B                            ; B3
    audio_note $18, $01                            ; B3
    audio_note $15, $0A                            ; G#3
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR22, $67
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR22, $77
    audio_note $1F, $0B                            ; F#4
    audio_reg_set rNR22, $67
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR22, $77
    audio_note $1F, $0B                            ; F#4
    audio_note $1C, $0B                            ; D#4
    audio_note $1B, $0A                            ; D4
    audio_reg_set rNR22, $67
    audio_note $1C, $0B                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR22, $67
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR22, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR22, $67
    audio_note $15, $0B                            ; G#3
    audio_note $18, $0A                            ; B3
    audio_note $1D, $0B                            ; E4
    audio_note $21, $05                            ; G#4
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $57
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR22, $67
    audio_note $18, $3B                            ; B3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $B7
    audio_rest $15
    audio_reg_set rNR22, $67
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $67
    audio_note $1B, $0B                            ; D4
    audio_reg_set rNR22, $77
    audio_note $1A, $40                            ; C#4
    audio_reg_set rNR22, $47
    audio_sustain $35
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $1A
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $77
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR22, $67
    audio_note $18, $3B                            ; B3
    audio_reg_set rNR22, $47
    audio_sustain $25
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $3A
    audio_reg_set rNR22, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $35                            ; B3
    audio_reg_set rNR22, $87
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR22, $77
    audio_note $18, $35                            ; B3
    audio_reg_set rNR22, $87
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR22, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR22, $87
    audio_note $1E, $0B                            ; F4
    audio_note $15, $15                            ; G#3
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR22, $77
    audio_note $10, $15                            ; D#3
    audio_reg_set rNR22, $87
    audio_note $17, $0B                            ; A#3
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $06
    audio_reg_set rNR22, $87
    audio_note $14, $05                            ; G3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR22, $47
    audio_sustain $60
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $3A
    audio_reg_set rNR22, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $35                            ; B3
    audio_reg_set rNR22, $87
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR22, $77
    audio_note $18, $35                            ; B3
    audio_reg_set rNR22, $87
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR22, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR22, $87
    audio_note $1E, $0B                            ; F4
    audio_note $15, $15                            ; G#3
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR22, $77
    audio_note $10, $15                            ; D#3
    audio_reg_set rNR22, $87
    audio_note $17, $0B                            ; A#3
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $06
    audio_reg_set rNR22, $87
    audio_note $14, $05                            ; G3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR22, $47
    audio_sustain $60
    audio_reg_set rNR22, $B7
    audio_rest $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $11, $0B                            ; E3
    audio_note $15, $15                            ; G#3
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR22, $77
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR22, $87
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1B, $0B                            ; D4
    audio_reg_set rNR22, $87
    audio_note $1A, $0B                            ; C#4
    audio_reg_set rNR22, $77
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR22, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR22, $77
    audio_note $17, $0B                            ; A#3
    audio_note $16, $0A                            ; A3
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR22, $87
    audio_note $13, $0A                            ; F#3
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR22, $47
    audio_rest $20
    audio_reg_set rNR22, $67
    audio_note $14, $15                            ; G3
    audio_note $15, $20                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $4B
    audio_reg_set rNR22, $67
    audio_note $14, $15                            ; G3
    audio_note $15, $2B                            ; G#3
    audio_sustain $40
    audio_note $14, $15                            ; G3
    audio_note $15, $2B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $20
    audio_reg_set rNR22, $77
    audio_note $0C, $0B                            ; B2
    audio_reg_set rNR22, $67
    audio_note $0D, $0A                            ; C3
    audio_reg_set rNR22, $87
    audio_note $0E, $0B                            ; C#3
    audio_reg_set rNR22, $47
    audio_sustain $20
    audio_reg_set rNR22, $77
    audio_note $0F, $0B                            ; D3
    audio_reg_set rNR22, $87
    audio_note $10, $0A                            ; D#3
    audio_reg_set rNR22, $77
    audio_note $11, $0B                            ; E3
    audio_reg_set rNR22, $47
    audio_sustain $20
    audio_reg_set rNR22, $87
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR22, $77
    audio_note $13, $0A                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $0B
    audio_reg_set rNR22, $87
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR22, $77
    audio_note $15, $0A                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $0B
    audio_reg_set rNR22, $87
    audio_note $1B, $10                            ; D4
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $1A, $0B                            ; C#4
    audio_note $19, $10                            ; C4
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $18, $0B                            ; B3
    audio_note $17, $10                            ; A#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $16, $10                            ; A3
    audio_reg_set rNR22, $47
    audio_sustain $06
    audio_reg_set rNR22, $87
    audio_note $15, $10                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $14, $10                            ; G3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $13, $10                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $06
    audio_reg_set rNR22, $97
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $67
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $67
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $67
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $B7
    audio_rest $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $14, $15                            ; G3
    audio_reg_set rNR22, $87
    audio_note $13, $10                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $50
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $14, $15                            ; G3
    audio_reg_set rNR22, $87
    audio_note $13, $16                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $4A
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $14, $15                            ; G3
    audio_reg_set rNR22, $87
    audio_note $13, $10                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $87
    audio_note $16, $06                            ; A3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $1D, $05                            ; E4
    audio_reg_set rNR22, $47
    audio_sustain $06
    audio_reg_set rNR22, $87
    audio_note $16, $05                            ; A3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $10, $06                            ; D#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $05, $0B                            ; E2
    audio_reg_set rNR22, $77
    audio_note $06, $0A                            ; F2
    audio_reg_set rNR22, $67
    audio_note $07, $0B                            ; F#2
    audio_reg_set rNR22, $77
    audio_note $08, $0B                            ; G2
    audio_reg_set rNR22, $87
    audio_note $07, $0A                            ; F#2
    audio_reg_set rNR22, $77
    audio_note $06, $0B                            ; F2
    audio_reg_set rNR22, $87
    audio_note $07, $0B                            ; F#2
    audio_reg_set rNR22, $77
    audio_note $08, $0A                            ; G2
    audio_reg_set rNR22, $97
    audio_note $09, $0B                            ; G#2
    audio_reg_set rNR22, $87
    audio_note $0A, $0B                            ; A2
    audio_reg_set rNR22, $97
    audio_note $09, $0A                            ; G#2
    audio_reg_set rNR22, $77
    audio_note $08, $0B                            ; G2
    audio_reg_set rNR22, $97
    audio_note $09, $0B                            ; G#2
    audio_reg_set rNR22, $87
    audio_note $0A, $0A                            ; A2
    audio_note $0B, $0B                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_reg_set rNR22, $A7
    audio_note $0B, $0A                            ; A#2
    audio_reg_set rNR22, $87
    audio_note $0A, $0B                            ; A2
    audio_reg_set rNR22, $97
    audio_note $0D, $0B                            ; C3
    audio_reg_set rNR22, $87
    audio_note $0C, $0A                            ; B2
    audio_reg_set rNR22, $97
    audio_note $0B, $0B                            ; A#2
    audio_reg_set rNR22, $77
    audio_note $0A, $0B                            ; A2
    audio_reg_set rNR22, $97
    audio_note $07, $0A                            ; F#2
    audio_reg_set rNR22, $77
    audio_note $06, $0B                            ; F2
    audio_reg_set rNR22, $87
    audio_note $05, $10                            ; E2
    audio_reg_set rNR22, $47
    audio_sustain $45
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $14, $15                            ; G3
    audio_note $13, $0B                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $77
    audio_note $14, $15                            ; G3
    audio_reg_set rNR22, $87
    audio_note $13, $0B                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $15
    audio_reg_set rNR22, $87
    audio_note $18, $0B                            ; B3
    audio_note $17, $15                            ; A#3
    audio_reg_set rNR22, $77
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR22, $47
    audio_rest $0B
    audio_reg_set rNR22, $77
    audio_note $09, $0A                            ; G#2
    audio_reg_set rNR22, $47
    audio_sustain $16
    audio_reg_set rNR22, $77
    audio_note $0E, $0A                            ; C#3
    audio_reg_set rNR22, $47
    audio_sustain $16
    audio_reg_set rNR22, $77
    audio_note $13, $0A                            ; F#3
    audio_reg_set rNR22, $47
    audio_sustain $16
    audio_reg_set rNR22, $77
    audio_note $14, $0A                            ; G3
    audio_reg_set rNR22, $47
    audio_sustain $0B
    audio_reg_set rNR22, $87
    audio_note $1A, $0B                            ; C#4
    audio_reg_set rNR22, $77
    audio_note $14, $0A                            ; G3
    audio_note $0F, $06                            ; D3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $10, $0B                            ; D#3
    audio_note $1B, $05                            ; D4
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $0B                            ; G#3
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR22, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $12, $0B                            ; F3
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $0F, $0B                            ; D3
    audio_reg_set rNR22, $87
    audio_note $13, $0B                            ; F#3
    audio_note $12, $05                            ; F3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $0B, $0B                            ; A#2
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR22, $77
    audio_note $17, $05                            ; A#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $16, $06                            ; A3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $0A
    audio_reg_set rNR22, $67
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $10
    audio_reg_set rNR22, $77
    audio_note $15, $06                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR22, $47
    audio_sustain $0B
    audio_reg_set rNR22, $77
    audio_note $17, $05                            ; A#3
    audio_reg_set rNR22, $47
    audio_sustain $06
    audio_reg_set rNR22, $67
    audio_note $11, $05                            ; E3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $17, $06                            ; A#3
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $77
    audio_note $1C, $0B                            ; D#4
    audio_reg_set rNR22, $47
    audio_sustain $05
    audio_reg_set rNR22, $67
    audio_note $17, $20                            ; A#3
    audio_reg_set rNR22, $47
    audio_sustain $20
    audio_loop .loop
