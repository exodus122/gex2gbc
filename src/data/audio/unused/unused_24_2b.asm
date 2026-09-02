; bank $24: entry $2B - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 70 bytes, 16 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $81
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $57
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $47
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $37
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $27
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $17
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
