; banks $21, $22, $23: SFX_CANNON_ROTATE (sfx $2C)
; banks $21, $22, $23: SFX_GEAR (sfx $35)
;
; One driver track for hardware channel 1 (pulse A), 44 bytes, 16 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_note $0D, $02                            ; C3
    audio_note $0A, $02                            ; A2
    audio_end
