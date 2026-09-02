; banks $21, $22, $23: SFX_GEX_COLLAPSE (sfx $0E)
;
; One driver track for hardware channel 1 (pulse A), 24 bytes, 5 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $7C
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $B7
    audio_note $25, $0F                            ; C5
    audio_note $24, $0F                            ; B4
    audio_note $23, $0F                            ; A#4
    audio_sustain $2D
    audio_rest $78
    audio_end
