; bank $24: entry $40 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 3 (wave), 4 bytes, 1 note, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_rest $0A
    audio_end
