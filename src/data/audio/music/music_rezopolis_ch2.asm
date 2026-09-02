; bank $22: MUSIC_REZOPOLIS ch2
;
; One driver track for hardware channel 2 (pulse B), 724 bytes, 243 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $77
.loop:
    audio_reg_set rNR22, $07
    audio_sustain $10
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $18
    audio_reg_set rNR22, $67
    audio_note $30, $20                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $20
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $18
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $18
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $18
    audio_reg_set rNR22, $67
    audio_note $30, $20                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $20
    audio_reg_set rNR22, $67
    audio_note $30, $04                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $10                            ; B5
    audio_note $30, $08                            ; B5
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $67
    audio_note $30, $08                            ; B5
    audio_note $30, $08                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $04                            ; B5
    audio_note $30, $10                            ; B5
    audio_note $31, $10                            ; C6
    audio_reg_set rNR22, $57
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_reg_set rNR22, $57
    audio_note $3C, $08                            ; B6
    audio_note $3C, $10                            ; B6
    audio_note $3C, $08                            ; B6
    audio_reg_set rNR22, $07
    audio_sustain $08
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $70
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $10                            ; F#3
    audio_note $10, $10                            ; D#3
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $20                            ; F#3
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $10                            ; F#3
    audio_note $10, $10                            ; D#3
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $20                            ; F#3
    audio_reg_set rNR22, $07
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $70
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $10                            ; F#3
    audio_note $10, $10                            ; D#3
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $20                            ; F#3
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $10                            ; F#3
    audio_note $10, $10                            ; D#3
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $20                            ; F#3
    audio_reg_set rNR22, $77
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_note $12, $10                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_note $12, $10                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $18, $10                            ; B3
    audio_note $14, $10                            ; G3
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_note $12, $10                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_note $12, $10                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $18, $20                            ; B3
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_note $12, $10                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_note $12, $10                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $18, $08                            ; B3
    audio_reg_set rNR22, $67
    audio_note $14, $08                            ; G3
    audio_reg_set rNR22, $77
    audio_note $14, $10                            ; G3
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $67
    audio_note $12, $08                            ; F3
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $77
    audio_note $18, $08                            ; B3
    audio_note $18, $08                            ; B3
    audio_note $1C, $10                            ; D#4
    audio_reg_set rNR22, $07
    audio_sustain $B0
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $20                            ; F#3
    audio_reg_set rNR22, $07
    audio_sustain $A8
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $12, $10                            ; F3
    audio_reg_set rNR22, $67
    audio_note $0D, $08                            ; C3
    audio_note $0D, $10                            ; C3
    audio_note $0D, $08                            ; C3
    audio_reg_set rNR22, $77
    audio_note $13, $10                            ; F#3
    audio_note $17, $10                            ; A#3
    audio_loop .loop
