; bank $24: entry $3F - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 2 (pulse B), 4 bytes, 1 note, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_rest $0A
    audio_end
