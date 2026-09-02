; bank $21: MUSIC_PREHISTORY_CHANNEL ch3
;
; One driver track for hardware channel 3 (wave), 451 bytes, 212 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_load_wave $01, $17, $2d, $43, $59, $00, $00, $00, $00, $00, $00, $57, $41, $2b, $15, $00
    audio_reg_set rNR30, $80
    audio_reg_set rNR31, $FF
    audio_reg_set rNR32, $40
.loop:
    audio_rest $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $51
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $B8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $9B
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $03, $1C                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1C                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1C                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1C                            ; D2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $06, $1C                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1C                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1C                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1C                            ; F2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $06, $1B                            ; F2
    audio_note $04, $1C                            ; D#2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1C                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1C                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1C                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $03, $1B                            ; D2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1B                            ; D#2
    audio_note $06, $1C                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1C                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1C                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1B                            ; F2
    audio_note $06, $1C                            ; F2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $06, $1B                            ; F2
    audio_note $04, $1C                            ; D#2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $01, $1C                            ; C2
    audio_note $01, $1B                            ; C2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $04, $1B                            ; D#2
    audio_note $04, $1C                            ; D#2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $08, $1B                            ; G2
    audio_note $08, $1C                            ; G2
    audio_note $06, $1B                            ; F2
    audio_note $04, $1B                            ; D#2
    audio_note $0D, $1B                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $1B                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $1B                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $1B                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0F, $1C                            ; D3
    audio_note $03, $1B                            ; D2
    audio_note $0F, $1C                            ; D3
    audio_note $03, $1B                            ; D2
    audio_note $0F, $1C                            ; D3
    audio_note $03, $1B                            ; D2
    audio_note $0F, $1B                            ; D3
    audio_note $03, $1C                            ; D2
    audio_note $10, $1B                            ; D#3
    audio_note $04, $1C                            ; D#2
    audio_note $10, $1B                            ; D#3
    audio_note $04, $1C                            ; D#2
    audio_note $10, $1B                            ; D#3
    audio_note $04, $1B                            ; D#2
    audio_note $10, $1C                            ; D#3
    audio_note $04, $1B                            ; D#2
    audio_note $12, $1C                            ; F3
    audio_note $06, $1B                            ; F2
    audio_note $12, $1C                            ; F3
    audio_note $06, $1B                            ; F2
    audio_note $12, $1B                            ; F3
    audio_note $06, $1C                            ; F2
    audio_note $12, $1B                            ; F3
    audio_note $06, $1C                            ; F2
    audio_note $14, $1B                            ; G3
    audio_note $08, $1C                            ; G2
    audio_note $14, $1B                            ; G3
    audio_note $08, $1B                            ; G2
    audio_note $14, $1C                            ; G3
    audio_note $08, $1B                            ; G2
    audio_note $14, $1C                            ; G3
    audio_note $08, $1B                            ; G2
    audio_note $14, $1C                            ; G3
    audio_note $14, $1B                            ; G3
    audio_note $14, $1B                            ; G3
    audio_note $14, $1C                            ; G3
    audio_note $14, $1B                            ; G3
    audio_note $14, $1C                            ; G3
    audio_note $12, $1B                            ; F3
    audio_note $10, $1C                            ; D#3
    audio_loop .loop
