; banks $21, $22, $23: SFX_23 (sfx $23)
;
; One driver track for hardware channel 1 (pulse A), 24 bytes, 4 notes, ending in
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
    audio_rest $78
    audio_reg_set rNR12, $77
    audio_sustain $03
    audio_note $31, $0A                            ; C6
    audio_sustain $32
    audio_reg_set rNR12, $07
    audio_end
