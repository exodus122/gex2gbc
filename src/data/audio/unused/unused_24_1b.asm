; bank $24: entry $1B - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 28 bytes, 3 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $83
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $57
    audio_note $29, $14                            ; E5
    audio_sustain $14
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
