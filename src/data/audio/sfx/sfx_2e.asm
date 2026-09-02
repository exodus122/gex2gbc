; banks $21, $22, $23: SFX_2E (sfx $2E)
;
; One driver track for hardware channel 1 (pulse A), 22 bytes, 4 notes, ending in
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
    audio_note $01, $03                            ; C2
    audio_note $19, $01                            ; C4
    audio_sustain $2D
    audio_rest $78
    audio_end
