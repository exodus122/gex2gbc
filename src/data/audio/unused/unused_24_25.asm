; bank $24: entry $25 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 2 (pulse B), 16 bytes, 4 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $77
    audio_rest $78
    audio_note $01, $05                            ; C2
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_sustain $32
    audio_end
