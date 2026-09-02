; banks $21, $22, $23: driver sfx id $25 - no .data_00_116c_SFXChannelTable row reaches it
; banks $21, $22, $23: driver sfx id $28 - no .data_00_116c_SFXChannelTable row reaches it
;
; One driver track for hardware channel 2 (pulse B), 8 bytes, 1 note, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $77
    audio_rest $78
    audio_end
