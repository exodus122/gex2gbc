; bank $22: MUSIC_REZOPOLIS ch1
;
; One driver track for hardware channel 1 (pulse A), 298 bytes, 100 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $8F
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $A7
.loop:
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_reg_set rNR12, $97
    audio_note $1D, $30                            ; E4
    audio_note $1F, $50                            ; F#4
    audio_note $1B, $30                            ; D4
    audio_note $1D, $50                            ; E4
    audio_note $1D, $30                            ; E4
    audio_note $1F, $50                            ; F#4
    audio_note $1B, $30                            ; D4
    audio_note $18, $50                            ; B3
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_reg_set rNR12, $37
    audio_sustain $10
    audio_reg_set rNR12, $A7
    audio_note $1D, $20                            ; E4
    audio_note $1D, $20                            ; E4
    audio_note $1B, $20                            ; D4
    audio_note $18, $10                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $10
    audio_reg_set rNR12, $A7
    audio_note $1D, $20                            ; E4
    audio_note $1D, $20                            ; E4
    audio_note $1B, $20                            ; D4
    audio_note $18, $10                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $10
    audio_reg_set rNR12, $A7
    audio_note $1E, $20                            ; F4
    audio_note $1E, $20                            ; F4
    audio_note $1D, $20                            ; E4
    audio_note $19, $10                            ; C4
    audio_reg_set rNR12, $37
    audio_sustain $10
    audio_reg_set rNR12, $A7
    audio_note $1E, $20                            ; F4
    audio_note $1E, $20                            ; F4
    audio_note $1D, $20                            ; E4
    audio_note $18, $10                            ; B3
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_note $18, $30                            ; B3
    audio_note $18, $30                            ; B3
    audio_reg_set rNR12, $37
    audio_sustain $20
    audio_reg_set rNR12, $A7
    audio_note $18, $30                            ; B3
    audio_note $18, $20                            ; B3
    audio_note $19, $30                            ; C4
    audio_loop .loop
