; banks $21, $22, $23: SFX_TV_SMASH (sfx $02)
;
; One driver track for hardware channel 1 (pulse A), 42 bytes, 14 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $7E
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $B7
    audio_note $48, $01                            ; B7
    audio_note $0D, $01                            ; C3
    audio_note $48, $01                            ; B7
    audio_note $0D, $01                            ; C3
    audio_note $48, $01                            ; B7
    audio_note $0D, $01                            ; C3
    audio_note $48, $01                            ; B7
    audio_note $0D, $01                            ; C3
    audio_note $48, $01                            ; B7
    audio_note $0D, $01                            ; C3
    audio_note $48, $01                            ; B7
    audio_note $0D, $01                            ; C3
    audio_sustain $2D
    audio_rest $78
    audio_end
