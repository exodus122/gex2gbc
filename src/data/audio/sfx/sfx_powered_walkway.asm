; banks $21, $22, $23: SFX_POWERED_WALKWAY (sfx $2B)
;
; One driver track for hardware channel 1 (pulse A), 72 bytes, 30 notes, ending in
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
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_note $08, $02                            ; G2
    audio_note $05, $02                            ; E2
    audio_end
