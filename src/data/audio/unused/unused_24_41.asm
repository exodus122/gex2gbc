; bank $24: entry $41 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 4 (noise), 4 bytes, 1 note, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
;
; On the noise channel a note is only a retrigger. Audio_RunSequence sends the
; frequency's high bits to rNR44 rather than to a pitch register, so what is
; audible is whatever rNR43 was last set to - which is why the note indices here
; carry no pitch and are left unnamed.
    audio_channel 4                                ; noise
    audio_rest $0A
    audio_end
