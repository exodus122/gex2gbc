; banks $21, $22, $23: SFX_ENEMY_JUMP (sfx $24)
; banks $21, $22, $23: SFX_ALT_ENEMY_JUMP (sfx $29)
;
; One driver track for hardware channel 1 (pulse A), 40 bytes, 12 notes, ending in
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
    audio_note $10, $05                            ; D#3
    audio_note $0F, $01                            ; D3
    audio_note $11, $01                            ; E3
    audio_note $12, $01                            ; F3
    audio_note $13, $01                            ; F#3
    audio_note $14, $01                            ; G3
    audio_note $15, $01                            ; G#3
    audio_note $16, $01                            ; A3
    audio_note $17, $01                            ; A#3
    audio_note $18, $01                            ; B3
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
