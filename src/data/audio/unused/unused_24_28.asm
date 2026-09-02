; bank $24: entry $28 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 2 (pulse B), 36 bytes, 14 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $77
    audio_rest $78
    audio_note $25, $03                            ; C5
    audio_note $29, $03                            ; E5
    audio_note $2C, $03                            ; G5
    audio_note $31, $0C                            ; C6
    audio_note $29, $03                            ; E5
    audio_note $2C, $03                            ; G5
    audio_note $31, $03                            ; C6
    audio_note $35, $0C                            ; E6
    audio_note $2C, $03                            ; G5
    audio_note $31, $03                            ; C6
    audio_note $35, $03                            ; E6
    audio_note $38, $0C                            ; G6
    audio_reg_set rNR22, $07
    audio_sustain $1E
    audio_end
