; bank $22: MUSIC_REZOPOLIS ch4
;
; One driver track for hardware channel 4 (noise), 76 bytes, 32 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
;
; On the noise channel a note is only a retrigger. Audio_RunSequence sends the
; frequency's high bits to rNR44 rather than to a pitch register, so what is
; audible is whatever rNR43 was last set to - which is why the note indices here
; carry no pitch and are left unnamed.
    audio_channel 4                                ; noise
    audio_reg_set rNR41, $14
    audio_reg_set rNR42, $51
    audio_reg_set rNR43, $22
.loop:
    audio_reg_set rNR44, $80
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_note $0D, $08
    audio_note $0D, $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_note $0D, $08
    audio_sustain $08
    audio_sustain $08
    audio_loop .loop
