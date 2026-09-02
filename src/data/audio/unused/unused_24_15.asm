; bank $24: entry $15 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 52 bytes, 11 notes, ending in
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
    audio_reg_set rNR12, $17
    audio_note $24, $04                            ; B4
    audio_note $18, $04                            ; B3
    audio_reg_set rNR12, $27
    audio_note $23, $04                            ; A#4
    audio_note $17, $04                            ; A#3
    audio_reg_set rNR12, $37
    audio_note $22, $04                            ; A4
    audio_note $16, $04                            ; A3
    audio_reg_set rNR12, $47
    audio_note $21, $04                            ; G#4
    audio_note $15, $04                            ; G#3
    audio_reg_set rNR12, $57
    audio_note $20, $04                            ; G4
    audio_note $14, $04                            ; G3
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
