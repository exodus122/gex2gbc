; banks $21, $22, $23: SFX_22 (sfx $22)
;
; One driver track for hardware channel 1 (pulse A), 16 bytes, 2 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $4D
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_note $31, $01                            ; C6
    audio_sustain $3C
    audio_end
