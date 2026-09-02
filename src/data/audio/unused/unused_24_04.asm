; bank $24: entry $04 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 110 bytes, 41 notes, ending in
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
    audio_reg_set rNR12, $17
    audio_note $2A, $01                            ; F5
    audio_note $36, $01                            ; F6
    audio_note $2E, $01                            ; A5
    audio_note $3A, $01                            ; A6
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $36, $01                            ; F6
    audio_note $42, $01                            ; F7
    audio_reg_set rNR12, $37
    audio_note $2A, $01                            ; F5
    audio_note $36, $01                            ; F6
    audio_note $2E, $01                            ; A5
    audio_note $3A, $01                            ; A6
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $36, $01                            ; F6
    audio_note $42, $01                            ; F7
    audio_reg_set rNR12, $57
    audio_note $2A, $01                            ; F5
    audio_note $36, $01                            ; F6
    audio_note $2E, $01                            ; A5
    audio_note $3A, $01                            ; A6
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $36, $01                            ; F6
    audio_note $42, $01                            ; F7
    audio_reg_set rNR12, $37
    audio_note $2A, $01                            ; F5
    audio_note $36, $01                            ; F6
    audio_note $2E, $01                            ; A5
    audio_note $3A, $01                            ; A6
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $36, $01                            ; F6
    audio_note $42, $01                            ; F7
    audio_reg_set rNR12, $17
    audio_note $2A, $01                            ; F5
    audio_note $36, $01                            ; F6
    audio_note $2E, $01                            ; A5
    audio_note $3A, $01                            ; A6
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $36, $01                            ; F6
    audio_note $42, $01                            ; F7
    audio_sustain $78
    audio_end
