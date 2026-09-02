; bank $23: MUSIC_TOON_TV ch1
;
; One driver track for hardware channel 1 (pulse A), 1556 bytes, 415 notes, ending in
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
    audio_reg_set rNR12, $77
    audio_note $18, $0B                            ; B3
    audio_note $1D, $0A                            ; E4
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $87
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR12, $77
    audio_note $1F, $0A                            ; F#4
    audio_note $21, $01                            ; G#4
    audio_reg_set rNR12, $87
    audio_note $24, $0A                            ; B4
    audio_reg_set rNR12, $77
    audio_note $21, $0B                            ; G#4
    audio_note $1D, $0A                            ; E4
    audio_note $1F, $4B                            ; F#4
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $B7
    audio_rest $35
    audio_reg_set rNR12, $77
    audio_note $17, $0B                            ; A#3
    audio_note $18, $15                            ; B3
    audio_note $11, $2B                            ; E3
    audio_reg_set rNR12, $47
    audio_sustain $35
    audio_reg_set rNR12, $77
    audio_note $17, $0B                            ; A#3
    audio_note $18, $15                            ; B3
    audio_note $1D, $1B                            ; E4
    audio_reg_set rNR12, $47
    audio_sustain $25
    audio_reg_set rNR12, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $67
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $67
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $1D, $10                            ; E4
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR12, $87
    audio_note $1E, $0B                            ; F4
    audio_reg_set rNR12, $67
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR12, $77
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $67
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $67
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $67
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $67
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $67
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $57
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $67
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $67
    audio_note $21, $0B                            ; G#4
    audio_note $20, $15                            ; G4
    audio_note $21, $0B                            ; G#4
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $67
    audio_note $21, $0B                            ; G#4
    audio_reg_set rNR12, $77
    audio_note $20, $15                            ; G4
    audio_reg_set rNR12, $67
    audio_note $21, $0B                            ; G#4
    audio_reg_set rNR12, $77
    audio_note $1D, $0B                            ; E4
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR12, $67
    audio_note $21, $0B                            ; G#4
    audio_reg_set rNR12, $77
    audio_note $25, $0B                            ; C5
    audio_reg_set rNR12, $67
    audio_note $24, $0A                            ; B4
    audio_reg_set rNR12, $77
    audio_note $25, $0B                            ; C5
    audio_note $22, $0B                            ; A4
    audio_note $21, $0A                            ; G#4
    audio_reg_set rNR12, $67
    audio_note $22, $0B                            ; A4
    audio_reg_set rNR12, $77
    audio_note $1E, $0B                            ; F4
    audio_reg_set rNR12, $67
    audio_note $1D, $0A                            ; E4
    audio_reg_set rNR12, $77
    audio_note $1E, $0B                            ; F4
    audio_reg_set rNR12, $67
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR12, $57
    audio_note $1F, $0A                            ; F#4
    audio_reg_set rNR12, $67
    audio_note $21, $0B                            ; G#4
    audio_note $24, $05                            ; B4
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $67
    audio_note $21, $0B                            ; G#4
    audio_note $1F, $3B                            ; F#4
    audio_reg_set rNR12, $47
    audio_rest $05
    audio_reg_set rNR12, $B7
    audio_sustain $15
    audio_reg_set rNR12, $67
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $67
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $67
    audio_note $1F, $0B                            ; F#4
    audio_note $1E, $40                            ; F4
    audio_reg_set rNR12, $47
    audio_sustain $35
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $1A
    audio_reg_set rNR12, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $1D, $0B                            ; E4
    audio_note $1C, $3B                            ; D#4
    audio_reg_set rNR12, $47
    audio_rest $25
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $87
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $87
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $87
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $3A
    audio_reg_set rNR12, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $35                            ; B3
    audio_reg_set rNR12, $87
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR12, $77
    audio_note $18, $35                            ; B3
    audio_reg_set rNR12, $87
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR12, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR12, $87
    audio_note $1F, $0B                            ; F#4
    audio_note $21, $15                            ; G#4
    audio_note $1A, $0B                            ; C#4
    audio_reg_set rNR12, $77
    audio_note $1C, $15                            ; D#4
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $16, $05                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $06
    audio_reg_set rNR12, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $97
    audio_note $13, $0B                            ; F#3
    audio_reg_set rNR12, $47
    audio_rest $60
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $87
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $87
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $87
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $3A
    audio_reg_set rNR12, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $35                            ; B3
    audio_reg_set rNR12, $87
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR12, $77
    audio_note $18, $35                            ; B3
    audio_reg_set rNR12, $87
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR12, $77
    audio_note $19, $0B                            ; C4
    audio_note $18, $15                            ; B3
    audio_reg_set rNR12, $87
    audio_note $1F, $0B                            ; F#4
    audio_note $21, $15                            ; G#4
    audio_note $1A, $0B                            ; C#4
    audio_reg_set rNR12, $77
    audio_note $1C, $15                            ; D#4
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $16, $05                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $06
    audio_reg_set rNR12, $87
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $97
    audio_note $13, $0B                            ; F#3
    audio_reg_set rNR12, $47
    audio_rest $60
    audio_reg_set rNR12, $B7
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $1D, $15                            ; E4
    audio_reg_set rNR12, $77
    audio_note $1F, $0B                            ; F#4
    audio_note $21, $0B                            ; G#4
    audio_note $20, $0A                            ; G4
    audio_note $1F, $0B                            ; F#4
    audio_note $1E, $0B                            ; F4
    audio_note $1D, $0A                            ; E4
    audio_note $1C, $0B                            ; D#4
    audio_note $1B, $0B                            ; D4
    audio_reg_set rNR12, $87
    audio_note $1A, $0A                            ; C#4
    audio_note $19, $0B                            ; C4
    audio_reg_set rNR12, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $87
    audio_note $17, $0A                            ; A#3
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR12, $47
    audio_rest $20
    audio_reg_set rNR12, $67
    audio_note $17, $15                            ; A#3
    audio_note $18, $20                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $4B
    audio_reg_set rNR12, $67
    audio_note $17, $15                            ; A#3
    audio_note $18, $2B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $40
    audio_reg_set rNR12, $67
    audio_note $17, $15                            ; A#3
    audio_note $18, $2B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $20
    audio_reg_set rNR12, $77
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR12, $67
    audio_note $16, $0A                            ; A3
    audio_reg_set rNR12, $87
    audio_note $17, $0B                            ; A#3
    audio_reg_set rNR12, $47
    audio_sustain $20
    audio_reg_set rNR12, $77
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $87
    audio_note $19, $0A                            ; C4
    audio_reg_set rNR12, $77
    audio_note $1A, $0B                            ; C#4
    audio_reg_set rNR12, $47
    audio_sustain $20
    audio_reg_set rNR12, $87
    audio_note $1B, $0B                            ; D4
    audio_reg_set rNR12, $77
    audio_note $1C, $0A                            ; D#4
    audio_reg_set rNR12, $47
    audio_sustain $0B
    audio_reg_set rNR12, $87
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR12, $77
    audio_note $1E, $0A                            ; F4
    audio_reg_set rNR12, $47
    audio_sustain $0B
    audio_reg_set rNR12, $87
    audio_note $1F, $10                            ; F#4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $1E, $0B                            ; F4
    audio_note $1D, $10                            ; E4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $1C, $0B                            ; D#4
    audio_note $1B, $10                            ; D4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $1A, $10                            ; C#4
    audio_reg_set rNR12, $47
    audio_sustain $06
    audio_reg_set rNR12, $87
    audio_note $19, $10                            ; C4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $10                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $17, $10                            ; A#3
    audio_reg_set rNR12, $47
    audio_sustain $06
    audio_reg_set rNR12, $87
    audio_note $16, $10                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $67
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $67
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $67
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $B7
    audio_rest $15
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $17, $15                            ; A#3
    audio_reg_set rNR12, $77
    audio_note $16, $10                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $50
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $17, $15                            ; A#3
    audio_note $16, $16                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $4A
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $17, $15                            ; A#3
    audio_reg_set rNR12, $77
    audio_note $16, $10                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $1F, $05                            ; F#4
    audio_reg_set rNR12, $47
    audio_sustain $06
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $12, $06                            ; F3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $11, $0B                            ; E3
    audio_reg_set rNR12, $67
    audio_note $12, $0A                            ; F3
    audio_note $13, $0B                            ; F#3
    audio_reg_set rNR12, $77
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR12, $87
    audio_note $13, $0A                            ; F#3
    audio_reg_set rNR12, $77
    audio_note $12, $0B                            ; F3
    audio_reg_set rNR12, $87
    audio_note $13, $0B                            ; F#3
    audio_reg_set rNR12, $77
    audio_note $14, $0A                            ; G3
    audio_reg_set rNR12, $87
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR12, $77
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR12, $87
    audio_note $15, $0A                            ; G#3
    audio_reg_set rNR12, $77
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR12, $97
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR12, $77
    audio_note $16, $0A                            ; A3
    audio_reg_set rNR12, $87
    audio_note $17, $0B                            ; A#3
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $97
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $77
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR12, $87
    audio_note $19, $0B                            ; C4
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR12, $97
    audio_note $17, $0B                            ; A#3
    audio_reg_set rNR12, $77
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR12, $87
    audio_note $13, $0A                            ; F#3
    audio_reg_set rNR12, $77
    audio_note $12, $0B                            ; F3
    audio_note $11, $10                            ; E3
    audio_reg_set rNR12, $47
    audio_sustain $45
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_note $17, $15                            ; A#3
    audio_note $16, $0B                            ; A3
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $87
    audio_note $1D, $0B                            ; E4
    audio_note $1C, $15                            ; D#4
    audio_reg_set rNR12, $77
    audio_note $1B, $0B                            ; D4
    audio_reg_set rNR12, $47
    audio_sustain $15
    audio_reg_set rNR12, $77
    audio_note $21, $0B                            ; G#4
    audio_reg_set rNR12, $87
    audio_note $20, $15                            ; G4
    audio_note $1F, $0B                            ; F#4
    audio_reg_set rNR12, $47
    audio_rest $0B
    audio_reg_set rNR12, $77
    audio_note $0C, $0A                            ; B2
    audio_reg_set rNR12, $47
    audio_sustain $16
    audio_reg_set rNR12, $87
    audio_note $12, $0A                            ; F3
    audio_reg_set rNR12, $47
    audio_sustain $16
    audio_reg_set rNR12, $77
    audio_note $17, $0A                            ; A#3
    audio_reg_set rNR12, $47
    audio_sustain $16
    audio_reg_set rNR12, $77
    audio_note $18, $0A                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $0B
    audio_reg_set rNR12, $87
    audio_note $1E, $0B                            ; F4
    audio_reg_set rNR12, $77
    audio_note $18, $0A                            ; B3
    audio_note $13, $06                            ; F#3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR12, $87
    audio_note $1D, $05                            ; E4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $17, $0B                            ; A#3
    audio_note $1B, $0B                            ; D4
    audio_note $1A, $05                            ; C#4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $77
    audio_note $17, $05                            ; A#3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $11, $0B                            ; E3
    audio_note $15, $0B                            ; G#3
    audio_reg_set rNR12, $87
    audio_note $14, $05                            ; G3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $0D, $0B                            ; C3
    audio_reg_set rNR12, $87
    audio_note $14, $0B                            ; G3
    audio_reg_set rNR12, $77
    audio_note $1A, $05                            ; C#4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $19, $06                            ; C4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $87
    audio_note $18, $0B                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $0A
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $10
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $0B
    audio_reg_set rNR12, $67
    audio_note $18, $05                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $06
    audio_reg_set rNR12, $77
    audio_note $15, $05                            ; G#3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $06                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $1D, $0B                            ; E4
    audio_reg_set rNR12, $47
    audio_sustain $05
    audio_reg_set rNR12, $77
    audio_note $18, $20                            ; B3
    audio_reg_set rNR12, $47
    audio_sustain $20
    audio_loop .loop
