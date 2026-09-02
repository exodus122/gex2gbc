; banks $21, $22, $23: SFX_21 (sfx $21)
;
; One driver track for hardware channel 1 (pulse A), 60 bytes, 12 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $7F
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $27
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $2F
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $77
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $7F
    audio_note $3D, $02                            ; C7
    audio_reg_set rNR12, $27
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $2F
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $77
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $7F
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $27
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $2F
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $77
    audio_note $19, $02                            ; C4
    audio_reg_set rNR12, $7F
    audio_note $19, $02                            ; C4
    audio_end
