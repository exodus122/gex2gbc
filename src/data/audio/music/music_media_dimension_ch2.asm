; bank $23: MUSIC_MEDIA_DIMENSION ch2
;
; One driver track for hardware channel 2 (pulse B), 572 bytes, 212 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $B7
.loop:
    audio_rest $64
    audio_rest $64
    audio_rest $64
    audio_rest $64
    audio_rest $0A
    audio_reg_set rNR22, $80
    audio_note $11, $66                            ; E3
    audio_note $12, $67                            ; F3
    audio_note $14, $66                            ; G3
    audio_note $15, $67                            ; G#3
    audio_note $11, $66                            ; E3
    audio_note $12, $66                            ; F3
    audio_note $14, $67                            ; G3
    audio_note $15, $66                            ; G#3
    audio_reg_set rNR22, $87
    audio_note $17, $40                            ; A#3
    audio_note $18, $0D                            ; B3
    audio_note $15, $0D                            ; G#3
    audio_note $14, $0C                            ; G3
    audio_note $17, $67                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $CD
    audio_reg_set rNR22, $97
    audio_note $17, $40                            ; A#3
    audio_note $18, $0C                            ; B3
    audio_note $15, $0D                            ; G#3
    audio_note $14, $0D                            ; G3
    audio_note $17, $66                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $CD
    audio_note $1E, $40                            ; F4
    audio_reg_set rNR22, $A7
    audio_note $1D, $0D                            ; E4
    audio_reg_set rNR22, $B7
    audio_note $1A, $0D                            ; C#4
    audio_reg_set rNR22, $A7
    audio_note $19, $0D                            ; C4
    audio_reg_set rNR22, $97
    audio_note $16, $0C                            ; A3
    audio_reg_set rNR22, $B7
    audio_note $17, $0D                            ; A#3
    audio_note $12, $73                            ; F3
    audio_sustain $A7
    audio_note $1E, $40                            ; F4
    audio_reg_set rNR22, $A7
    audio_note $1D, $0D                            ; E4
    audio_reg_set rNR22, $B7
    audio_note $1A, $0C                            ; C#4
    audio_reg_set rNR22, $97
    audio_note $19, $0D                            ; C4
    audio_note $16, $0D                            ; A3
    audio_reg_set rNR22, $B7
    audio_note $19, $0D                            ; C4
    audio_note $17, $0D                            ; A#3
    audio_note $12, $79                            ; F3
    audio_sustain $93
    audio_reg_set rNR22, $97
    audio_note $32, $11                            ; C#6
    audio_reg_set rNR22, $A7
    audio_note $2D, $1A                            ; G#5
    audio_reg_set rNR22, $97
    audio_note $2C, $19                            ; G5
    audio_note $29, $1A                            ; E5
    audio_note $26, $19                            ; C#5
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR22, $A7
    audio_note $1C, $1A                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $1E, $11                            ; F4
    audio_reg_set rNR22, $B7
    audio_sustain $BB
    audio_reg_set rNR22, $B7
    audio_sustain $80
    audio_reg_set rNR22, $A7
    audio_note $29, $11                            ; E5
    audio_reg_set rNR22, $97
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $A7
    audio_note $25, $11                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $22, $11                            ; A4
    audio_note $25, $09                            ; C5
    audio_note $23, $11                            ; A#4
    audio_note $17, $11                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $C8
    audio_sustain $AF
    audio_reg_set rNR22, $97
    audio_note $19, $34                            ; C4
    audio_note $1A, $33                            ; C#4
    audio_note $1B, $33                            ; D4
    audio_note $1C, $33                            ; D#4
    audio_reg_set rNR22, $B7
    audio_sustain $80
    audio_reg_set rNR22, $A7
    audio_note $29, $11                            ; E5
    audio_reg_set rNR22, $97
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR22, $A7
    audio_note $25, $11                            ; C5
    audio_note $26, $08                            ; C#5
    audio_note $22, $11                            ; A4
    audio_note $25, $09                            ; C5
    audio_note $23, $11                            ; A#4
    audio_note $17, $11                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $C8
    audio_sustain $AF
    audio_reg_set rNR22, $97
    audio_note $19, $34                            ; C4
    audio_note $1A, $33                            ; C#4
    audio_note $1B, $33                            ; D4
    audio_note $1C, $33                            ; D#4
    audio_reg_set rNR22, $97
    audio_note $1D, $33                            ; E4
    audio_note $1E, $33                            ; F4
    audio_reg_set rNR22, $A7
    audio_note $20, $34                            ; G4
    audio_note $21, $33                            ; G#4
    audio_note $20, $33                            ; G4
    audio_note $21, $33                            ; G#4
    audio_note $23, $33                            ; A#4
    audio_note $24, $34                            ; B4
    audio_reg_set rNR22, $B7
    audio_sustain $CC
    audio_note $26, $11                            ; C#5
    audio_note $21, $1A                            ; G#4
    audio_note $20, $1A                            ; G4
    audio_note $1D, $08                            ; E4
    audio_sustain $80
    audio_note $25, $11                            ; C5
    audio_sustain $09
    audio_note $25, $11                            ; C5
    audio_sustain $A2
    audio_rest $64
    audio_rest $64
    audio_rest $64
    audio_rest $64
    audio_rest $09
    audio_reg_set rNR22, $97
    audio_note $17, $40                            ; A#3
    audio_note $18, $0D                            ; B3
    audio_note $15, $0D                            ; G#3
    audio_note $14, $0C                            ; G3
    audio_note $17, $47                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $ED
    audio_reg_set rNR22, $97
    audio_note $17, $40                            ; A#3
    audio_note $18, $0C                            ; B3
    audio_note $15, $0D                            ; G#3
    audio_note $14, $0D                            ; G3
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $F3
    audio_note $2A, $40                            ; F5
    audio_reg_set rNR22, $A7
    audio_note $29, $0D                            ; E5
    audio_reg_set rNR22, $B7
    audio_note $26, $0D                            ; C#5
    audio_reg_set rNR22, $A7
    audio_note $25, $0D                            ; C5
    audio_reg_set rNR22, $97
    audio_note $22, $0C                            ; A4
    audio_reg_set rNR22, $B7
    audio_note $23, $0D                            ; A#4
    audio_note $1E, $3A                            ; F4
    audio_sustain $13
    audio_reg_set rNR22, $77
    audio_note $20, $66                            ; G4
    audio_note $21, $67                            ; G#4
    audio_reg_set rNR22, $77
    audio_note $20, $33                            ; G4
    audio_reg_set rNR22, $87
    audio_note $21, $33                            ; G#4
    audio_reg_set rNR22, $77
    audio_note $23, $34                            ; A#4
    audio_note $24, $33                            ; B4
    audio_note $23, $33                            ; A#4
    audio_reg_set rNR22, $87
    audio_note $24, $33                            ; B4
    audio_reg_set rNR22, $77
    audio_note $26, $33                            ; C#5
    audio_note $27, $34                            ; D5
    audio_note $29, $CC                            ; E5
    audio_reg_set rNR22, $77
    audio_note $12, $33                            ; F3
    audio_reg_set rNR22, $B7
    audio_note $26, $11                            ; C#5
    audio_note $21, $1A                            ; G#4
    audio_note $20, $22                            ; G4
    audio_note $2A, $11                            ; F5
    audio_reg_set rNR22, $97
    audio_note $2B, $09                            ; F#5
    audio_reg_set rNR22, $A7
    audio_note $25, $11                            ; C5
    audio_reg_set rNR22, $B7
    audio_note $28, $08                            ; D#5
    audio_note $22, $11                            ; A4
    audio_reg_set rNR22, $A7
    audio_note $26, $09                            ; C#5
    audio_reg_set rNR22, $B7
    audio_sustain $11
    audio_note $1E, $08                            ; F4
    audio_sustain $1A
    audio_note $26, $11                            ; C#5
    audio_sustain $1A
    audio_note $21, $01                            ; G#4
    audio_note $20, $65                            ; G4
    audio_reg_set rNR22, $A7
    audio_note $17, $09                            ; A#3
    audio_reg_set rNR22, $B7
    audio_note $20, $11                            ; G4
    audio_reg_set rNR22, $97
    audio_note $21, $08                            ; G#4
    audio_reg_set rNR22, $B7
    audio_note $1D, $11                            ; E4
    audio_note $1E, $09                            ; F4
    audio_note $19, $11                            ; C4
    audio_note $1A, $08                            ; C#4
    audio_note $16, $11                            ; A3
    audio_note $17, $09                            ; A#3
    audio_note $19, $11                            ; C4
    audio_note $17, $09                            ; A#3
    audio_note $12, $11                            ; F3
    audio_note $11, $08                            ; E3
    audio_note $15, $11                            ; G#3
    audio_note $14, $09                            ; G3
    audio_note $11, $11                            ; E3
    audio_reg_set rNR22, $A7
    audio_note $12, $08                            ; F3
    audio_reg_set rNR22, $87
    audio_note $19, $34                            ; C4
    audio_note $1A, $33                            ; C#4
    audio_reg_set rNR22, $77
    audio_note $1B, $33                            ; D4
    audio_reg_set rNR22, $87
    audio_note $1C, $33                            ; D#4
    audio_reg_set rNR22, $B7
    audio_note $17, $09                            ; A#3
    audio_sustain $11
    audio_note $1D, $08                            ; E4
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $11                            ; G#4
    audio_sustain $09
    audio_note $20, $08                            ; G4
    audio_reg_set rNR22, $77
    audio_note $20, $4D                            ; G4
    audio_reg_set rNR22, $B7
    audio_sustain $1A
    audio_note $17, $08                            ; A#3
    audio_sustain $11
    audio_note $1D, $09                            ; E4
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $09                            ; G#4
    audio_sustain $11
    audio_note $20, $55                            ; G4
    audio_sustain $1A
    audio_reg_set rNR22, $87
    audio_note $17, $08                            ; A#3
    audio_reg_set rNR22, $B7
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $11                            ; G#4
    audio_sustain $09
    audio_note $20, $08                            ; G4
    audio_sustain $11
    audio_note $1D, $09                            ; E4
    audio_sustain $66
    audio_note $26, $11                            ; C#5
    audio_note $21, $09                            ; G#4
    audio_sustain $11
    audio_note $20, $09                            ; G4
    audio_sustain $11
    audio_note $1D, $08                            ; E4
    audio_sustain $80
    audio_note $25, $11                            ; C5
    audio_sustain $09
    audio_note $25, $08                            ; C5
    audio_sustain $AB
    audio_loop .loop
