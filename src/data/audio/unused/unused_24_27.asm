; bank $24: entry $27 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 104 bytes, 20 notes, ending in
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
    audio_reg_set rNR12, $67
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $57
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $47
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $37
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $27
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $17
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $57
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $47
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $37
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $27
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $17
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $47
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $37
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $27
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $17
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $37
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $27
    audio_note $31, $02                            ; C6
    audio_reg_set rNR12, $17
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $07
    audio_sustain $1B
    audio_sustain $1E
    audio_end
