; banks $21, $22, $23: driver sfx id $40 - no .data_00_116c_SFXChannelTable row reaches it
;
; One driver track for hardware channel 3 (wave), 4 bytes, 1 note, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_rest $0A
    audio_end
