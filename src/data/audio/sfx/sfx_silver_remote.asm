; banks $21, $22, $23: SFX_SILVER_REMOTE (sfx $03)
;
; One driver track for hardware channel 1 (pulse A), 66 bytes, 21 notes, ending in
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
    audio_reg_set rNR12, $17
    audio_note $2A, $01                            ; F5
    audio_note $2E, $01                            ; A5
    audio_note $31, $01                            ; C6
    audio_note $36, $01                            ; F6
    audio_reg_set rNR12, $37
    audio_note $2A, $01                            ; F5
    audio_note $2E, $01                            ; A5
    audio_note $31, $01                            ; C6
    audio_note $36, $01                            ; F6
    audio_reg_set rNR12, $57
    audio_note $2A, $01                            ; F5
    audio_note $2E, $01                            ; A5
    audio_note $31, $01                            ; C6
    audio_note $36, $01                            ; F6
    audio_reg_set rNR12, $37
    audio_note $2A, $01                            ; F5
    audio_note $2E, $01                            ; A5
    audio_note $31, $01                            ; C6
    audio_note $36, $01                            ; F6
    audio_reg_set rNR12, $17
    audio_note $2A, $01                            ; F5
    audio_note $2E, $01                            ; A5
    audio_note $31, $01                            ; C6
    audio_note $36, $02                            ; F6
    audio_reg_set rNR12, $07
    audio_sustain $78
    audio_end
