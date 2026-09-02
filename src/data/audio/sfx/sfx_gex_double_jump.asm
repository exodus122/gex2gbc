; banks $21, $22, $23: SFX_GEX_DOUBLE_JUMP (sfx $0D)
;
; One driver track for hardware channel 1 (pulse A), 94 bytes, 34 notes, ending in
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
    audio_reg_set rNR12, $57
    audio_note $25, $01                            ; C5
    audio_note $26, $01                            ; C#5
    audio_note $27, $01                            ; D5
    audio_note $29, $01                            ; E5
    audio_note $2A, $01                            ; F5
    audio_note $2B, $01                            ; F#5
    audio_note $2C, $01                            ; G5
    audio_note $2D, $01                            ; G#5
    audio_note $2E, $01                            ; A5
    audio_note $2F, $01                            ; A#5
    audio_note $30, $01                            ; B5
    audio_note $31, $01                            ; C6
    audio_note $34, $01                            ; D#6
    audio_note $33, $01                            ; D6
    audio_note $35, $01                            ; E6
    audio_note $36, $01                            ; F6
    audio_note $37, $01                            ; F#6
    audio_note $38, $01                            ; G6
    audio_note $39, $01                            ; G#6
    audio_note $3A, $01                            ; A6
    audio_note $3B, $01                            ; A#6
    audio_note $3C, $01                            ; B6
    audio_note $3D, $01                            ; C7
    audio_note $3E, $01                            ; C#7
    audio_reg_set rNR12, $47
    audio_note $3F, $01                            ; D7
    audio_note $41, $01                            ; E7
    audio_reg_set rNR12, $47
    audio_note $42, $01                            ; F7
    audio_note $43, $01                            ; F#7
    audio_reg_set rNR12, $37
    audio_note $44, $01                            ; G7
    audio_note $45, $01                            ; G#7
    audio_reg_set rNR12, $27
    audio_note $46, $01                            ; A7
    audio_note $47, $01                            ; A#7
    audio_reg_set rNR12, $17
    audio_note $48, $01                            ; B7
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
