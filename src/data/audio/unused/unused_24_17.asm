; bank $24: entry $17 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 30 bytes, 4 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $81
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $1F
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $50
    audio_note $24, $05                            ; B4
    audio_note $23, $05                            ; A#4
    audio_note $22, $14                            ; A4
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
