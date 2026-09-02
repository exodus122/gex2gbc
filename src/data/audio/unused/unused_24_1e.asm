; bank $24: entry $1E - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 3 (wave), 96 bytes, 39 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 3                                ; wave
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $84
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR30, $80
    audio_reg_set rNR31, $0F
    audio_reg_set rNR32, $20
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $32, $01                            ; C#6
    audio_note $32, $01                            ; C#6
    audio_note $32, $01                            ; C#6
    audio_note $32, $01                            ; C#6
    audio_note $32, $01                            ; C#6
    audio_note $32, $01                            ; C#6
    audio_note $32, $01                            ; C#6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $31, $01                            ; C6
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $3B, $01                            ; A#6
    audio_note $3B, $01                            ; A#6
    audio_note $3B, $01                            ; A#6
    audio_note $3B, $01                            ; A#6
    audio_note $3B, $01                            ; A#6
    audio_note $3B, $01                            ; A#6
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_note $30, $01                            ; B5
    audio_end
