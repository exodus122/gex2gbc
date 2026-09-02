; bank $24: entry $33 - unreachable, nothing selects bank $24
; bank $24: entry $38 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 4 (noise), 32 bytes, 2 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
;
; On the noise channel a note is only a retrigger. Audio_RunSequence sends the
; frequency's high bits to rNR44 rather than to a pitch register, so what is
; audible is whatever rNR43 was last set to - which is why the note indices here
; carry no pitch and are left unnamed.
    audio_channel 4                                ; noise
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $88
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR41, $13
    audio_reg_set rNR42, $57
    audio_reg_set rNR43, $27
    audio_reg_set rNR44, $80
    audio_reg_set rNR42, $5F
    audio_reg_set rNR43, $27
    audio_note $19, $64
    audio_reg_set rNR42, $57
    audio_reg_set rNR43, $27
    audio_sustain $64
    audio_end
