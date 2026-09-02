; bank $24: entry $37 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 52 bytes, 13 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $81
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $3B
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $57
    audio_note $31, $04                            ; C6
    audio_note $30, $04                            ; B5
    audio_note $2F, $04                            ; A#5
    audio_note $2E, $04                            ; A5
    audio_reg_set rNR12, $37
    audio_note $30, $04                            ; B5
    audio_note $2F, $04                            ; A#5
    audio_note $2E, $04                            ; A5
    audio_note $2D, $04                            ; G#5
    audio_reg_set rNR12, $17
    audio_note $2F, $04                            ; A#5
    audio_note $2E, $04                            ; A5
    audio_note $2D, $04                            ; G#5
    audio_sustain $14
    audio_reg_set rNR12, $07
    audio_sustain $78
    audio_end
