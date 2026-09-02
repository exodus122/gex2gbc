; banks $21, $22, $23: SFX_EMPTY (sfx $00)
;
; One driver track for hardware channel 1 (pulse A), 20 bytes, 2 notes, ending in
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
    audio_reg_set rNR12, $B7
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $07
    audio_sustain $78
    audio_end
