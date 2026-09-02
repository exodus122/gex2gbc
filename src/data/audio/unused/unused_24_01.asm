; bank $24: entry $01 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 36 bytes, 7 notes, ending in
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
    audio_rest $1E
    audio_reg_set rNR12, $47
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_reg_set rNR12, $07
    audio_sustain $78
    audio_end
