; bank $23: MUSIC_TOON_TV ch3
;
; One driver track for hardware channel 3 (wave), 535 bytes, 254 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_load_wave $0b, $16, $21, $2c, $37, $42, $4d, $58, $4d, $42, $37, $2c, $21, $16, $0b, $00
    audio_reg_set rNR30, $80
    audio_reg_set rNR31, $3F
    audio_reg_set rNR32, $40
.loop:
    audio_note $0C, $0B                            ; B2
    audio_note $11, $0A                            ; E3
    audio_note $0C, $0B                            ; B2
    audio_note $11, $0B                            ; E3
    audio_note $13, $0A                            ; F#3
    audio_note $15, $0B                            ; G#3
    audio_note $18, $0B                            ; B3
    audio_note $15, $0A                            ; G#3
    audio_note $18, $50                            ; B3
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $15                            ; E2
    audio_note $0C, $5B                            ; B2
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $15                            ; E2
    audio_note $01, $5B                            ; C2
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $15                            ; E2
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $15
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $15
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $10                            ; E2
    audio_note $1D, $10                            ; E4
    audio_note $17, $40                            ; A#3
    audio_rest $20
    audio_note $05, $15                            ; E2
    audio_rest $5B
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $20                            ; E2
    audio_note $11, $20                            ; E3
    audio_note $10, $20                            ; D#3
    audio_note $0E, $10                            ; C#3
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $20                            ; E2
    audio_note $11, $20                            ; E3
    audio_note $10, $20                            ; D#3
    audio_note $0E, $10                            ; C#3
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $20                            ; E2
    audio_note $11, $20                            ; E3
    audio_note $10, $20                            ; D#3
    audio_note $0E, $10                            ; C#3
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $20                            ; E2
    audio_note $1C, $20                            ; D#4
    audio_note $18, $20                            ; B3
    audio_note $15, $20                            ; G#3
    audio_rest $70
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $20                            ; E2
    audio_note $0C, $45                            ; B2
    audio_rest $5B
    audio_note $05, $20                            ; E2
    audio_note $0C, $45                            ; B2
    audio_rest $4B
    audio_note $08, $05                            ; G2
    audio_note $07, $06                            ; F#2
    audio_note $06, $05                            ; F2
    audio_note $05, $15                            ; E2
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $15
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $15
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $06, $C0                            ; F2
    audio_rest $C8
    audio_rest $38
    audio_note $05, $15                            ; E2
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $15
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $15
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $06, $C0                            ; F2
    audio_rest $FE
    audio_rest $02
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $C0
    audio_note $05, $15                            ; E2
    audio_note $0C, $40                            ; B2
    audio_note $0D, $0B                            ; C3
    audio_note $0C, $0B                            ; B2
    audio_note $0A, $0A                            ; A2
    audio_note $06, $0B                            ; F2
    audio_note $05, $15                            ; E2
    audio_note $05, $01                            ; E2
    audio_note $0C, $3F                            ; B2
    audio_note $0D, $0B                            ; C3
    audio_note $0C, $0B                            ; B2
    audio_note $0A, $0A                            ; A2
    audio_note $06, $0B                            ; F2
    audio_note $05, $15                            ; E2
    audio_note $05, $01                            ; E2
    audio_note $0C, $3F                            ; B2
    audio_note $0D, $0B                            ; C3
    audio_note $0C, $0B                            ; B2
    audio_note $0A, $0A                            ; A2
    audio_note $06, $0B                            ; F2
    audio_note $05, $0B                            ; E2
    audio_note $06, $0A                            ; F2
    audio_note $07, $0B                            ; F#2
    audio_rest $20
    audio_note $08, $0B                            ; G2
    audio_note $09, $0A                            ; G#2
    audio_note $0A, $0B                            ; A2
    audio_rest $20
    audio_note $0B, $0B                            ; A#2
    audio_note $0C, $0A                            ; B2
    audio_rest $0B
    audio_note $0D, $0B                            ; C3
    audio_note $0E, $0A                            ; C#3
    audio_rest $CB
    audio_note $05, $10                            ; E2
    audio_note $09, $05                            ; G#2
    audio_note $0A, $06                            ; A2
    audio_note $0B, $05                            ; A#2
    audio_note $0C, $40                            ; B2
    audio_rest $20
    audio_note $05, $20                            ; E2
    audio_note $06, $20                            ; F2
    audio_note $07, $15                            ; F#2
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $20                            ; E2
    audio_note $06, $20                            ; F2
    audio_note $07, $15                            ; F#2
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $20                            ; E2
    audio_note $06, $20                            ; F2
    audio_note $07, $10                            ; F#2
    audio_rest $30
    audio_note $05, $0B                            ; E2
    audio_note $06, $0A                            ; F2
    audio_note $07, $0B                            ; F#2
    audio_note $08, $0B                            ; G2
    audio_note $07, $0A                            ; F#2
    audio_note $06, $0B                            ; F2
    audio_note $07, $0B                            ; F#2
    audio_note $08, $0A                            ; G2
    audio_note $09, $0B                            ; G#2
    audio_note $0A, $0B                            ; A2
    audio_note $09, $0A                            ; G#2
    audio_note $08, $0B                            ; G2
    audio_note $09, $0B                            ; G#2
    audio_note $0A, $0A                            ; A2
    audio_note $0B, $0B                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $0A                            ; A#2
    audio_note $0A, $0B                            ; A2
    audio_note $0D, $0B                            ; C3
    audio_note $0C, $0A                            ; B2
    audio_note $0B, $0B                            ; A#2
    audio_note $0A, $0B                            ; A2
    audio_note $07, $0A                            ; F#2
    audio_note $06, $0B                            ; F2
    audio_note $05, $10                            ; E2
    audio_rest $30
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $15                            ; E2
    audio_note $11, $0B                            ; E3
    audio_note $0B, $15                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_note $05, $0B                            ; E2
    audio_note $09, $0A                            ; G#2
    audio_note $09, $0B                            ; G#2
    audio_note $08, $0B                            ; G2
    audio_note $0E, $0A                            ; C#3
    audio_note $0C, $0B                            ; B2
    audio_note $0B, $0B                            ; A#2
    audio_note $13, $0A                            ; F#3
    audio_note $0F, $0B                            ; D3
    audio_note $0E, $0B                            ; C#3
    audio_note $14, $0A                            ; G3
    audio_note $12, $0B                            ; F3
    audio_note $1A, $0B                            ; C#4
    audio_note $14, $0A                            ; G3
    audio_note $0F, $0B                            ; D3
    audio_note $10, $0B                            ; D#3
    audio_rest $95
    audio_note $05, $0B                            ; E2
    audio_rest $0A
    audio_note $0B, $0B                            ; A#2
    audio_note $0C, $55                            ; B2
    audio_note $06, $0B                            ; F2
    audio_note $05, $0B                            ; E2
    audio_rest $0A
    audio_note $0B, $0B                            ; A#2
    audio_note $0C, $0B                            ; B2
    audio_rest $0A
    audio_note $06, $0B                            ; F2
    audio_note $05, $15                            ; E2
    audio_rest $60
    audio_note $08, $06                            ; G2
    audio_note $07, $05                            ; F#2
    audio_loop .loop
