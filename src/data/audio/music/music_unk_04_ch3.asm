; bank $22: MUSIC_UNK_04 ch3
;
; One driver track for hardware channel 3 (wave), 511 bytes, 242 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_load_wave $01, $17, $2d, $43, $59, $00, $00, $00, $00, $00, $00, $57, $41, $2b, $15, $00
    audio_reg_set rNR30, $80
    audio_reg_set rNR31, $FF
    audio_reg_set rNR32, $40
.loop:
    audio_note $01, $13                            ; C2
    audio_note $01, $73                            ; C2
    audio_note $01, $14                            ; C2
    audio_note $01, $99                            ; C2
    audio_rest $87
    audio_note $09, $13                            ; G#2
    audio_note $09, $26                            ; G#2
    audio_note $09, $73                            ; G#2
    audio_sustain $9A
    audio_note $08, $13                            ; G2
    audio_note $08, $87                            ; G2
    audio_rest $39
    audio_note $08, $13                            ; G2
    audio_note $08, $4D                            ; G2
    audio_rest $13
    audio_note $08, $14                            ; G2
    audio_note $08, $13                            ; G2
    audio_note $08, $13                            ; G2
    audio_note $08, $4D                            ; G2
    audio_rest $3A
    audio_note $01, $13                            ; C2
    audio_note $01, $99                            ; C2
    audio_rest $4D
    audio_note $20, $27                            ; G4
    audio_note $1E, $26                            ; F4
    audio_note $20, $26                            ; G4
    audio_note $21, $27                            ; G#4
    audio_note $23, $26                            ; A#4
    audio_note $21, $27                            ; G#4
    audio_note $20, $26                            ; G4
    audio_note $0D, $0A                            ; C3
    audio_note $0D, $09                            ; C3
    audio_note $0D, $0A                            ; C3
    audio_note $0D, $09                            ; C3
    audio_note $01, $3A                            ; C2
    audio_note $01, $13                            ; C2
    audio_note $01, $9A                            ; C2
    audio_rest $D3
    audio_note $0B, $13                            ; A#2
    audio_note $0B, $9A                            ; A#2
    audio_rest $3A
    audio_note $04, $13                            ; D#2
    audio_note $04, $99                            ; D#2
    audio_rest $E7
    audio_note $12, $13                            ; F3
    audio_note $14, $13                            ; G3
    audio_note $17, $13                            ; A#3
    audio_note $1A, $1A                            ; C#4
    audio_note $1E, $1A                            ; F4
    audio_note $1C, $19                            ; D#4
    audio_note $17, $13                            ; A#3
    audio_note $19, $26                            ; C4
    audio_note $1B, $27                            ; D4
    audio_note $1C, $26                            ; D#4
    audio_note $1E, $27                            ; F4
    audio_note $20, $99                            ; G4
    audio_note $0D, $0A                            ; C3
    audio_rest $09
    audio_note $08, $D3                            ; G2
    audio_note $0D, $0A                            ; C3
    audio_rest $0A
    audio_note $0D, $86                            ; C3
    audio_note $04, $0A                            ; D#2
    audio_note $04, $09                            ; D#2
    audio_note $04, $0A                            ; D#2
    audio_note $04, $09                            ; D#2
    audio_note $04, $0A                            ; D#2
    audio_note $04, $0A                            ; D#2
    audio_note $04, $09                            ; D#2
    audio_note $04, $0A                            ; D#2
    audio_note $02, $09                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_rest $1C
    audio_note $02, $0A                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_note $02, $09                            ; C#2
    audio_rest $0A
    audio_note $02, $09                            ; C#2
    audio_rest $0A
    audio_note $02, $0A                            ; C#2
    audio_note $02, $09                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_rest $09
    audio_note $02, $0A                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_note $02, $09                            ; C#2
    audio_rest $1D
    audio_note $02, $0A                            ; C#2
    audio_note $02, $09                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_rest $09
    audio_note $02, $0A                            ; C#2
    audio_rest $0A
    audio_note $02, $09                            ; C#2
    audio_note $02, $0A                            ; C#2
    audio_note $02, $09                            ; C#2
    audio_rest $0A
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $1D
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $0A
    audio_note $05, $09                            ; E2
    audio_note $05, $0A                            ; E2
    audio_note $05, $09                            ; E2
    audio_rest $1D
    audio_note $05, $0A                            ; E2
    audio_note $05, $09                            ; E2
    audio_note $05, $0A                            ; E2
    audio_rest $0A
    audio_note $05, $09                            ; E2
    audio_rest $0A
    audio_note $05, $09                            ; E2
    audio_note $05, $0A                            ; E2
    audio_note $05, $0A                            ; E2
    audio_rest $09
    audio_note $05, $0A                            ; E2
    audio_note $05, $09                            ; E2
    audio_note $05, $0A                            ; E2
    audio_rest $1D
    audio_note $05, $09                            ; E2
    audio_note $05, $0A                            ; E2
    audio_note $06, $0A                            ; F2
    audio_rest $09
    audio_note $06, $0A                            ; F2
    audio_rest $09
    audio_note $06, $0A                            ; F2
    audio_note $06, $0A                            ; F2
    audio_note $06, $09                            ; F2
    audio_rest $0A
    audio_note $06, $09                            ; F2
    audio_rest $0A
    audio_note $06, $0A                            ; F2
    audio_rest $1C
    audio_note $06, $0A                            ; F2
    audio_rest $0A
    audio_note $08, $13                            ; G2
    audio_note $06, $09                            ; F2
    audio_rest $0A
    audio_note $08, $13                            ; G2
    audio_note $06, $0A                            ; F2
    audio_rest $09
    audio_note $05, $0A                            ; E2
    audio_note $05, $0A                            ; E2
    audio_note $05, $09                            ; E2
    audio_rest $1D
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_sustain $09
    audio_note $01, $0A                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $1D
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $0B, $09                            ; A#2
    audio_rest $0A
    audio_note $0B, $0A                            ; A#2
    audio_rest $09
    audio_note $0B, $0A                            ; A#2
    audio_note $0B, $09                            ; A#2
    audio_note $0B, $0A                            ; A#2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $1D
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_rest $09
    audio_note $01, $0A                            ; C2
    audio_note $01, $0A                            ; C2
    audio_note $01, $09                            ; C2
    audio_rest $0A
    audio_note $01, $09                            ; C2
    audio_note $01, $0A                            ; C2
    audio_loop .loop
