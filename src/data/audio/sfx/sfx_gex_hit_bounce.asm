; banks $21, $22, $23: SFX_GEX_HIT_BOUNCE (sfx $12)
;
; One driver track for hardware channel 1 (pulse A), 36 bytes, 11 notes, ending in
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
    audio_reg_set rNR12, $B7
    audio_note $19, $05                            ; C4
    audio_note $18, $05                            ; B3
    audio_note $17, $05                            ; A#3
    audio_note $18, $05                            ; B3
    audio_note $17, $05                            ; A#3
    audio_note $16, $05                            ; A3
    audio_note $17, $05                            ; A#3
    audio_note $16, $05                            ; A3
    audio_note $15, $05                            ; G#3
    audio_sustain $0F
    audio_rest $78
    audio_end
