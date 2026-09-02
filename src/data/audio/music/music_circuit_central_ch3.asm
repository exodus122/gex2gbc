; bank $21: MUSIC_CIRCUIT_CENTRAL ch3
;
; One driver track for hardware channel 3 (wave), 127 bytes, 50 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_load_wave $0b, $16, $21, $2c, $37, $42, $4d, $58, $58, $4d, $42, $37, $2c, $21, $16, $0b
    audio_reg_set rNR30, $80
    audio_reg_set rNR31, $FF
    audio_reg_set rNR32, $40
.loop:
    audio_note $01, $C8                            ; C2
    audio_note $01, $C8                            ; C2
    audio_note $01, $30                            ; C2
    audio_note $04, $40                            ; D#2
    audio_note $01, $FE                            ; C2
    audio_sustain $02
    audio_note $08, $80                            ; G2
    audio_note $04, $80                            ; D#2
    audio_note $03, $C8                            ; D2
    audio_note $03, $B8                            ; D2
    audio_note $01, $40                            ; C2
    audio_note $08, $40                            ; G2
    audio_note $01, $C0                            ; C2
    audio_note $04, $40                            ; D#2
    audio_note $08, $80                            ; G2
    audio_note $04, $80                            ; D#2
    audio_note $03, $C0                            ; D2
    audio_note $01, $20                            ; C2
    audio_note $04, $20                            ; D#2
    audio_note $08, $FE                            ; G2
    audio_sustain $02
    audio_note $0D, $80                            ; C3
    audio_note $25, $80                            ; C5
    audio_note $2C, $80                            ; G5
    audio_note $28, $80                            ; D#5
    audio_note $27, $C8                            ; D5
    audio_note $27, $B8                            ; D5
    audio_note $28, $40                            ; D#5
    audio_note $2C, $40                            ; G5
    audio_note $25, $80                            ; C5
    audio_note $01, $80                            ; C2
    audio_note $08, $80                            ; G2
    audio_note $04, $80                            ; D#2
    audio_note $03, $C8                            ; D2
    audio_note $03, $B8                            ; D2
    audio_note $01, $40                            ; C2
    audio_note $08, $40                            ; G2
    audio_note $01, $C0                            ; C2
    audio_note $04, $40                            ; D#2
    audio_note $08, $80                            ; G2
    audio_note $04, $80                            ; D#2
    audio_note $03, $C0                            ; D2
    audio_note $01, $20                            ; C2
    audio_note $04, $20                            ; D#2
    audio_note $08, $FE                            ; G2
    audio_sustain $02
    audio_note $0D, $E0                            ; C3
    audio_note $01, $20                            ; C2
    audio_note $01, $FE                            ; C2
    audio_sustain $02
    audio_loop .loop
