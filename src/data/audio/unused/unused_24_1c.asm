; bank $24: entry $1C - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 2 (pulse B), 16 bytes, 3 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $77
    audio_reg_set rNR22, $57
    audio_note $35, $14                            ; E6
    audio_sustain $14
    audio_reg_set rNR22, $07
    audio_sustain $1E
    audio_end
