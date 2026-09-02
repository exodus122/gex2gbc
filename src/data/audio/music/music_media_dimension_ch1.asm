; bank $23: MUSIC_MEDIA_DIMENSION ch1
;
; One driver track for hardware channel 1 (pulse A), 748 bytes, 247 notes, ending in
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
    audio_reg_set rNR12, $B7
.loop:
    audio_rest $64
    audio_rest $64
    audio_rest $64
    audio_rest $64
    audio_rest $0A
    audio_reg_set rNR12, $80
    audio_note $1D, $66                            ; E4
    audio_note $1E, $67                            ; F4
    audio_reg_set rNR12, $70
    audio_note $20, $66                            ; G4
    audio_reg_set rNR12, $80
    audio_note $21, $67                            ; G#4
    audio_note $1D, $66                            ; E4
    audio_note $1E, $66                            ; F4
    audio_reg_set rNR12, $70
    audio_note $20, $67                            ; G4
    audio_reg_set rNR12, $80
    audio_note $21, $66                            ; G#4
    audio_reg_set rNR12, $B7
    audio_rest $C0
    audio_reg_set rNR12, $97
    audio_note $1A, $06                            ; C#4
    audio_reg_set rNR12, $87
    audio_note $21, $07                            ; G#4
    audio_note $20, $66                            ; G4
    audio_reg_set rNR12, $97
    audio_note $21, $0D                            ; G#4
    audio_reg_set rNR12, $B7
    audio_sustain $64
    audio_sustain $64
    audio_sustain $52
    audio_reg_set rNR12, $97
    audio_note $1A, $06                            ; C#4
    audio_reg_set rNR12, $87
    audio_note $21, $06                            ; G#4
    audio_note $20, $67                            ; G4
    audio_note $1D, $0D                            ; E4
    audio_reg_set rNR12, $B7
    audio_sustain $64
    audio_sustain $64
    audio_sustain $51
    audio_reg_set rNR12, $97
    audio_note $1A, $07                            ; C#4
    audio_reg_set rNR12, $87
    audio_note $21, $06                            ; G#4
    audio_note $20, $66                            ; G4
    audio_reg_set rNR12, $97
    audio_note $21, $0D                            ; G#4
    audio_reg_set rNR12, $B7
    audio_sustain $64
    audio_sustain $64
    audio_sustain $52
    audio_note $1A, $06                            ; C#4
    audio_reg_set rNR12, $A7
    audio_note $21, $07                            ; G#4
    audio_note $20, $66                            ; G4
    audio_reg_set rNR12, $B7
    audio_note $21, $0D                            ; G#4
    audio_sustain $59
    audio_reg_set rNR12, $B7
    audio_note $26, $11                            ; C#5
    audio_note $21, $1A                            ; G#4
    audio_note $20, $19                            ; G4
    audio_note $1D, $1A                            ; E4
    audio_note $1A, $19                            ; C#4
    audio_reg_set rNR12, $A7
    audio_note $17, $09                            ; A#3
    audio_reg_set rNR12, $B7
    audio_note $10, $1A                            ; D#3
    audio_reg_set rNR12, $A7
    audio_note $12, $19                            ; F3
    audio_reg_set rNR12, $B7
    audio_sustain $B3
    audio_reg_set rNR12, $B7
    audio_note $17, $09                            ; A#3
    audio_sustain $11
    audio_note $1D, $08                            ; E4
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $11                            ; G#4
    audio_sustain $09
    audio_note $20, $6F                            ; G4
    audio_note $17, $08                            ; A#3
    audio_sustain $11
    audio_note $1D, $09                            ; E4
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $09                            ; G#4
    audio_sustain $11
    audio_note $20, $55                            ; G4
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $17, $09                            ; A#3
    audio_reg_set rNR12, $B7
    audio_note $20, $11                            ; G4
    audio_reg_set rNR12, $87
    audio_note $21, $08                            ; G#4
    audio_reg_set rNR12, $A7
    audio_note $1D, $11                            ; E4
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $1A, $08                            ; C#4
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $16, $09                            ; A3
    audio_reg_set rNR12, $B7
    audio_note $19, $11                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $17, $09                            ; A#3
    audio_note $12, $11                            ; F3
    audio_reg_set rNR12, $97
    audio_note $11, $19                            ; E3
    audio_reg_set rNR12, $A7
    audio_note $15, $1A                            ; G#3
    audio_note $12, $D5                            ; F3
    audio_reg_set rNR12, $B7
    audio_note $17, $09                            ; A#3
    audio_sustain $11
    audio_note $1D, $08                            ; E4
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $11                            ; G#4
    audio_sustain $09
    audio_note $20, $6F                            ; G4
    audio_note $17, $08                            ; A#3
    audio_sustain $11
    audio_note $1D, $09                            ; E4
    audio_sustain $11
    audio_note $26, $11                            ; C#5
    audio_note $21, $09                            ; G#4
    audio_sustain $11
    audio_note $20, $55                            ; G4
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $17, $09                            ; A#3
    audio_reg_set rNR12, $B7
    audio_note $20, $11                            ; G4
    audio_reg_set rNR12, $87
    audio_note $21, $08                            ; G#4
    audio_reg_set rNR12, $A7
    audio_note $1D, $11                            ; E4
    audio_note $1E, $09                            ; F4
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $1A, $08                            ; C#4
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $16, $09                            ; A3
    audio_reg_set rNR12, $B7
    audio_note $19, $11                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $17, $09                            ; A#3
    audio_note $12, $11                            ; F3
    audio_reg_set rNR12, $97
    audio_note $11, $19                            ; E3
    audio_reg_set rNR12, $A7
    audio_note $15, $1A                            ; G#3
    audio_note $12, $D5                            ; F3
    audio_reg_set rNR12, $B7
    audio_note $17, $09                            ; A#3
    audio_sustain $11
    audio_note $1D, $11                            ; E4
    audio_sustain $08
    audio_note $26, $11                            ; C#5
    audio_note $21, $1A                            ; G#4
    audio_note $20, $6F                            ; G4
    audio_note $17, $08                            ; A#3
    audio_sustain $11
    audio_note $1D, $11                            ; E4
    audio_sustain $09
    audio_note $26, $11                            ; C#5
    audio_note $21, $1A                            ; G#4
    audio_note $20, $4C                            ; G4
    audio_sustain $3C
    audio_note $26, $11                            ; C#5
    audio_note $21, $1A                            ; G#4
    audio_note $20, $19                            ; G4
    audio_note $1D, $09                            ; E4
    audio_sustain $66
    audio_reg_set rNR12, $A7
    audio_note $32, $11                            ; C#6
    audio_reg_set rNR12, $97
    audio_note $2D, $1A                            ; G#5
    audio_reg_set rNR12, $A7
    audio_note $2C, $1A                            ; G5
    audio_note $29, $19                            ; E5
    audio_note $25, $09                            ; C5
    audio_note $26, $11                            ; C#5
    audio_reg_set rNR12, $97
    audio_note $21, $19                            ; G#4
    audio_reg_set rNR12, $A7
    audio_note $20, $1A                            ; G4
    audio_note $1D, $22                            ; E4
    audio_reg_set rNR12, $B7
    audio_note $38, $09                            ; G6
    audio_sustain $11
    audio_note $38, $08                            ; G6
    audio_sustain $AB
    audio_reg_set rNR12, $87
    audio_note $1D, $66                            ; E4
    audio_note $1E, $67                            ; F4
    audio_note $20, $66                            ; G4
    audio_note $21, $67                            ; G#4
    audio_reg_set rNR12, $B7
    audio_sustain $5C
    audio_sustain $64
    audio_note $1A, $06                            ; C#4
    audio_reg_set rNR12, $A7
    audio_note $21, $06                            ; G#4
    audio_note $20, $67                            ; G4
    audio_reg_set rNR12, $B7
    audio_note $21, $0D                            ; G#4
    audio_sustain $64
    audio_sustain $64
    audio_sustain $51
    audio_note $1A, $07                            ; C#4
    audio_reg_set rNR12, $A7
    audio_note $21, $06                            ; G#4
    audio_note $20, $66                            ; G4
    audio_note $1D, $0D                            ; E4
    audio_reg_set rNR12, $B7
    audio_sustain $5A
    audio_reg_set rNR12, $97
    audio_note $1D, $66                            ; E4
    audio_note $1E, $5A                            ; F4
    audio_reg_set rNR12, $B7
    audio_note $1A, $06                            ; C#4
    audio_reg_set rNR12, $A7
    audio_note $21, $07                            ; G#4
    audio_reg_set rNR12, $87
    audio_note $20, $66                            ; G4
    audio_reg_set rNR12, $97
    audio_note $21, $66                            ; G#4
    audio_reg_set rNR12, $97
    audio_note $20, $33                            ; G4
    audio_note $21, $33                            ; G#4
    audio_reg_set rNR12, $87
    audio_note $23, $34                            ; A#4
    audio_reg_set rNR12, $97
    audio_note $24, $33                            ; B4
    audio_note $23, $33                            ; A#4
    audio_note $24, $33                            ; B4
    audio_reg_set rNR12, $87
    audio_note $26, $33                            ; C#5
    audio_reg_set rNR12, $97
    audio_note $27, $34                            ; D5
    audio_note $29, $CC                            ; E5
    audio_reg_set rNR12, $97
    audio_note $1E, $33                            ; F4
    audio_reg_set rNR12, $A7
    audio_note $32, $11                            ; C#6
    audio_note $2D, $1A                            ; G#5
    audio_note $2C, $3C                            ; G5
    audio_reg_set rNR12, $97
    audio_note $21, $33                            ; G#4
    audio_note $23, $33                            ; A#4
    audio_reg_set rNR12, $A7
    audio_note $32, $11                            ; C#6
    audio_note $2D, $1A                            ; G#5
    audio_note $2C, $3B                            ; G5
    audio_reg_set rNR12, $97
    audio_note $26, $2B                            ; C#5
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR12, $A7
    audio_note $2C, $11                            ; G5
    audio_reg_set rNR12, $87
    audio_note $2D, $08                            ; G#5
    audio_reg_set rNR12, $97
    audio_note $29, $11                            ; E5
    audio_reg_set rNR12, $A7
    audio_note $2A, $09                            ; F5
    audio_reg_set rNR12, $97
    audio_note $25, $11                            ; C5
    audio_reg_set rNR12, $A7
    audio_note $26, $08                            ; C#5
    audio_reg_set rNR12, $97
    audio_note $22, $11                            ; A4
    audio_reg_set rNR12, $A7
    audio_note $23, $09                            ; A#4
    audio_note $25, $11                            ; C5
    audio_note $23, $09                            ; A#4
    audio_reg_set rNR12, $97
    audio_note $1E, $11                            ; F4
    audio_note $1D, $08                            ; E4
    audio_reg_set rNR12, $A7
    audio_note $21, $11                            ; G#4
    audio_note $20, $09                            ; G4
    audio_note $1D, $11                            ; E4
    audio_reg_set rNR12, $87
    audio_note $1E, $08                            ; F4
    audio_reg_set rNR12, $97
    audio_note $19, $34                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $1A, $33                            ; C#4
    audio_reg_set rNR12, $87
    audio_note $1B, $33                            ; D4
    audio_reg_set rNR12, $97
    audio_note $1C, $33                            ; D#4
    audio_reg_set rNR12, $97
    audio_note $23, $11                            ; A#4
    audio_sustain $09
    audio_reg_set rNR12, $A7
    audio_note $29, $19                            ; E5
    audio_note $32, $11                            ; C#6
    audio_reg_set rNR12, $97
    audio_note $2D, $09                            ; G#5
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $97
    audio_note $2C, $6F                            ; G5
    audio_note $23, $19                            ; A#4
    audio_reg_set rNR12, $A7
    audio_note $29, $1A                            ; E5
    audio_note $32, $1A                            ; C#6
    audio_reg_set rNR12, $97
    audio_note $2D, $11                            ; G#5
    audio_note $2C, $5E                            ; G5
    audio_reg_set rNR12, $B7
    audio_sustain $2A
    audio_reg_set rNR12, $A7
    audio_note $32, $11                            ; C#6
    audio_note $2D, $1A                            ; G#5
    audio_note $2C, $19                            ; G5
    audio_note $29, $09                            ; E5
    audio_reg_set rNR12, $B7
    audio_sustain $66
    audio_reg_set rNR12, $A7
    audio_note $32, $11                            ; C#6
    audio_reg_set rNR12, $97
    audio_note $2D, $09                            ; G#5
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $A7
    audio_note $2C, $09                            ; G5
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $A7
    audio_note $29, $08                            ; E5
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $A7
    audio_note $25, $09                            ; C5
    audio_note $26, $11                            ; C#5
    audio_reg_set rNR12, $97
    audio_note $21, $08                            ; G#4
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $A7
    audio_note $20, $09                            ; G4
    audio_reg_set rNR12, $B7
    audio_sustain $11
    audio_reg_set rNR12, $A7
    audio_note $1D, $09                            ; E4
    audio_reg_set rNR12, $B7
    audio_sustain $19
    audio_note $38, $11                            ; G6
    audio_sustain $09
    audio_note $38, $11                            ; G6
    audio_sustain $A2
    audio_loop .loop
