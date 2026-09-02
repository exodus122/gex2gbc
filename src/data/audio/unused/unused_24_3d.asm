; bank $24: entry $3D - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 28 bytes, 3 notes, ending in
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
    audio_reg_set rNR12, $13
    audio_note $25, $0A                            ; C5
    audio_note $3D, $32                            ; C7
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
