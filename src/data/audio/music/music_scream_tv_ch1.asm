; bank $22: MUSIC_SCREAM_TV ch1
;
; One driver track for hardware channel 1 (pulse A), 1240 bytes, 577 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $8F
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $07
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $91
.loop:
    audio_reg_set rNR12, $33
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $18
    audio_reg_set rNR12, $33
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $18
    audio_rest $20
    audio_reg_set rNR12, $33
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $28                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $28                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $18
    audio_reg_set rNR12, $33
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $38
    audio_reg_set rNR12, $33
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $78
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $40
    audio_reg_set rNR12, $57
    audio_note $31, $40                            ; C6
    audio_note $2B, $80                            ; F#5
    audio_note $30, $40                            ; B5
    audio_note $2A, $60                            ; F5
    audio_note $2F, $20                            ; A#5
    audio_note $29, $40                            ; E5
    audio_note $2E, $20                            ; A5
    audio_note $28, $20                            ; D#5
    audio_note $2D, $15                            ; G#5
    audio_note $27, $16                            ; D5
    audio_note $2C, $15                            ; G5
    audio_note $26, $40                            ; C#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $38
    audio_rest $80
    audio_rest $80
    audio_reg_set rNR12, $57
    audio_note $19, $10                            ; C4
    audio_note $17, $10                            ; A#3
    audio_note $16, $10                            ; A3
    audio_note $14, $10                            ; G3
    audio_note $13, $10                            ; F#3
    audio_note $11, $10                            ; E3
    audio_note $10, $10                            ; D#3
    audio_note $0E, $10                            ; C#3
    audio_note $1A, $10                            ; C#4
    audio_note $18, $10                            ; B3
    audio_note $17, $10                            ; A#3
    audio_note $15, $10                            ; G#3
    audio_note $14, $10                            ; G3
    audio_note $12, $10                            ; F3
    audio_note $11, $10                            ; E3
    audio_note $0F, $10                            ; D3
    audio_note $1A, $10                            ; C#4
    audio_note $18, $10                            ; B3
    audio_note $17, $10                            ; A#3
    audio_note $15, $10                            ; G#3
    audio_note $14, $10                            ; G3
    audio_note $12, $10                            ; F3
    audio_note $11, $10                            ; E3
    audio_note $0F, $10                            ; D3
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $14
    audio_reg_set rNR12, $11
    audio_rest $64
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_rest $80
    audio_reg_set rNR12, $33
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_note $25, $08                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $27, $08                            ; D5
    audio_note $28, $08                            ; D#5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $38
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $30
    audio_rest $38
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $28
    audio_rest $40
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $68
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $68
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $68
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $68
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $68
    audio_reg_set rNR12, $57
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_note $2B, $04                            ; F#5
    audio_note $25, $04                            ; C5
    audio_reg_set rNR12, $11
    audio_sustain $08
    audio_rest $28
    audio_loop .loop
