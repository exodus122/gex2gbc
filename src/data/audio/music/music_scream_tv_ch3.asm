; bank $22: MUSIC_SCREAM_TV ch3
;
; One driver track for hardware channel 3 (wave), 819 bytes, 396 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_load_wave $01, $17, $2d, $43, $59, $00, $00, $00, $00, $00, $00, $57, $41, $2b, $15, $00
    audio_reg_set rNR30, $80
    audio_reg_set rNR31, $01
    audio_reg_set rNR32, $60
.loop:
    audio_sustain $08
    audio_rest $38
    audio_note $0D, $40                            ; C3
    audio_note $07, $80                            ; F#2
    audio_note $0C, $40                            ; B2
    audio_note $06, $60                            ; F2
    audio_note $0B, $20                            ; A#2
    audio_note $05, $40                            ; E2
    audio_note $0A, $20                            ; A2
    audio_note $04, $20                            ; D#2
    audio_note $09, $15                            ; G#2
    audio_note $03, $16                            ; D2
    audio_note $08, $15                            ; G2
    audio_note $02, $40                            ; C#2
    audio_sustain $08
    audio_rest $38
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_rest $08
    audio_rest $78
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $08
    audio_rest $18
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $20
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $08
    audio_rest $18
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $20
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $08
    audio_rest $18
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $08
    audio_rest $18
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $08
    audio_rest $18
    audio_note $01, $60                            ; C2
    audio_note $02, $20                            ; C#2
    audio_note $01, $60                            ; C2
    audio_sustain $08
    audio_rest $18
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0D, $10                            ; C3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_note $0E, $10                            ; C#3
    audio_sustain $10
    audio_note $01, $10                            ; C2
    audio_sustain $08
    audio_rest $78
    audio_sustain $08
    audio_rest $78
    audio_sustain $08
    audio_rest $78
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $0B, $10                            ; A#2
    audio_note $0E, $10                            ; C#3
    audio_note $0B, $10                            ; A#2
    audio_note $08, $10                            ; G2
    audio_note $05, $10                            ; E2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $0B, $10                            ; A#2
    audio_note $0E, $10                            ; C#3
    audio_note $0B, $10                            ; A#2
    audio_note $08, $10                            ; G2
    audio_note $05, $10                            ; E2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $0B, $10                            ; A#2
    audio_note $0E, $10                            ; C#3
    audio_note $0B, $10                            ; A#2
    audio_note $08, $10                            ; G2
    audio_note $05, $10                            ; E2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $0B, $10                            ; A#2
    audio_note $0E, $10                            ; C#3
    audio_note $0B, $10                            ; A#2
    audio_note $08, $10                            ; G2
    audio_note $05, $10                            ; E2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $01, $10                            ; C2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_note $04, $10                            ; D#2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $02, $10                            ; C#2
    audio_note $05, $10                            ; E2
    audio_note $08, $10                            ; G2
    audio_note $02, $10                            ; C#2
    audio_note $03, $10                            ; D2
    audio_note $06, $10                            ; F2
    audio_note $09, $10                            ; G#2
    audio_note $0C, $10                            ; B2
    audio_note $0F, $10                            ; D3
    audio_note $0C, $10                            ; B2
    audio_note $09, $10                            ; G#2
    audio_note $06, $10                            ; F2
    audio_note $04, $10                            ; D#2
    audio_note $07, $10                            ; F#2
    audio_note $0A, $10                            ; A2
    audio_note $0D, $10                            ; C3
    audio_note $10, $10                            ; D#3
    audio_note $0D, $10                            ; C3
    audio_note $0A, $10                            ; A2
    audio_note $07, $10                            ; F#2
    audio_loop .loop
