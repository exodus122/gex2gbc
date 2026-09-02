; bank $24: entry $0C - unreachable, nothing selects bank $24
; bank $24: entry $34 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 48 bytes, 13 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $81
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $17
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $57
    audio_note $25, $01                            ; C5
    audio_note $28, $01                            ; D#5
    audio_note $27, $01                            ; D5
    audio_note $29, $01                            ; E5
    audio_note $2A, $01                            ; F5
    audio_note $2B, $01                            ; F#5
    audio_note $2C, $01                            ; G5
    audio_note $2D, $01                            ; G#5
    audio_note $2E, $01                            ; A5
    audio_note $2F, $01                            ; A#5
    audio_note $30, $01                            ; B5
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
