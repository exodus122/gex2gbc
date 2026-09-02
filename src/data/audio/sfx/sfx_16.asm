; banks $21, $22, $23: SFX_16 (sfx $16)
;
; One driver track for hardware channel 1 (pulse A), 20 bytes, 2 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $1F
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $17
    audio_note $24, $14                            ; B4
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
