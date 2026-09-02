; bank $24: entry $0F - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 94 bytes, 31 notes, ending in
; AUDIO_CMD_END.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $81
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $57
    audio_note $3D, $05                            ; C7
    audio_note $3C, $05                            ; B6
    audio_note $3B, $05                            ; A#6
    audio_note $3A, $05                            ; A6
    audio_note $3C, $04                            ; B6
    audio_note $3B, $04                            ; A#6
    audio_note $3A, $04                            ; A6
    audio_note $39, $04                            ; G#6
    audio_note $3B, $03                            ; A#6
    audio_note $3A, $03                            ; A6
    audio_note $39, $02                            ; G#6
    audio_note $38, $02                            ; G6
    audio_note $37, $01                            ; F#6
    audio_note $36, $01                            ; F6
    audio_note $35, $01                            ; E6
    audio_note $34, $01                            ; D#6
    audio_note $33, $01                            ; D6
    audio_note $32, $01                            ; C#6
    audio_note $31, $01                            ; C6
    audio_note $30, $01                            ; B5
    audio_note $2E, $01                            ; A5
    audio_reg_set rNR12, $47
    audio_note $2C, $01                            ; G5
    audio_note $2A, $01                            ; F5
    audio_reg_set rNR12, $37
    audio_note $28, $01                            ; D#5
    audio_note $26, $01                            ; C#5
    audio_reg_set rNR12, $27
    audio_note $24, $01                            ; B4
    audio_note $22, $01                            ; A4
    audio_reg_set rNR12, $17
    audio_note $20, $01                            ; G4
    audio_note $1E, $01                            ; F4
    audio_reg_set rNR12, $07
    audio_note $1C, $01                            ; D#4
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
