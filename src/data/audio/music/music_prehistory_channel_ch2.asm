; bank $21: MUSIC_PREHISTORY_CHANNEL ch2
;
; One driver track for hardware channel 2 (pulse B), 894 bytes, 415 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $C7
.loop:
    audio_reg_set rNR22, $F7
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1C
    audio_note $04, $1B                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $89
    audio_note $01, $1B                            ; C2
    audio_note $0B, $1C                            ; A#2
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $C0
    audio_note $01, $1B                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $89
    audio_note $01, $1B                            ; C2
    audio_note $0B, $1C                            ; A#2
    audio_note $01, $1B                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1B                            ; D2
    audio_sustain $C0
    audio_reg_set rNR22, $F7
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1C
    audio_note $04, $1B                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $60
    audio_reg_set rNR22, $B7
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR22, $C7
    audio_note $0B, $0D                            ; A#2
    audio_reg_set rNR22, $B7
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR22, $C7
    audio_sustain $0E
    audio_reg_set rNR22, $B7
    audio_note $01, $0D                            ; C2
    audio_note $0B, $0E                            ; A#2
    audio_reg_set rNR22, $C7
    audio_note $01, $0E                            ; C2
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $60
    audio_note $0B, $0D                            ; A#2
    audio_sustain $0E
    audio_note $0B, $0E                            ; A#2
    audio_sustain $0E
    audio_note $0B, $0D                            ; A#2
    audio_sustain $0E
    audio_note $0B, $0E                            ; A#2
    audio_note $01, $1B                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $96
    audio_note $01, $0E                            ; C2
    audio_note $0B, $0E                            ; A#2
    audio_note $01, $29                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1B                            ; D2
    audio_sustain $60
    audio_note $03, $0E                            ; D2
    audio_sustain $0E
    audio_note $03, $0E                            ; D2
    audio_sustain $0D
    audio_note $03, $0E                            ; D2
    audio_reg_set rNR22, $B7
    audio_note $04, $0E                            ; D#2
    audio_reg_set rNR22, $C7
    audio_note $08, $0D                            ; G2
    audio_reg_set rNR22, $C7
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1C
    audio_note $04, $1B                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $89
    audio_note $01, $1B                            ; C2
    audio_note $0B, $1C                            ; A#2
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $C0
    audio_note $01, $1B                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $89
    audio_note $01, $1B                            ; C2
    audio_note $0B, $1C                            ; A#2
    audio_note $01, $1B                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1B                            ; D2
    audio_sustain $C0
    audio_reg_set rNR22, $C7
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1C
    audio_note $04, $1B                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $60
    audio_reg_set rNR22, $B7
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR22, $C7
    audio_note $0B, $0D                            ; A#2
    audio_reg_set rNR22, $B7
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR22, $C7
    audio_sustain $0E
    audio_reg_set rNR22, $B7
    audio_note $01, $0D                            ; C2
    audio_note $0B, $0E                            ; A#2
    audio_reg_set rNR22, $C7
    audio_note $01, $0E                            ; C2
    audio_note $01, $1B                            ; C2
    audio_sustain $53
    audio_note $08, $1B                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $60
    audio_note $0B, $0D                            ; A#2
    audio_sustain $0E
    audio_note $0B, $0E                            ; A#2
    audio_sustain $0E
    audio_note $0B, $0D                            ; A#2
    audio_sustain $0E
    audio_note $0B, $0E                            ; A#2
    audio_note $01, $1B                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1C                            ; D2
    audio_sustain $96
    audio_note $01, $0E                            ; C2
    audio_note $0B, $0E                            ; A#2
    audio_note $01, $29                            ; C2
    audio_sustain $52
    audio_note $08, $1C                            ; G2
    audio_sustain $1B
    audio_note $04, $1C                            ; D#2
    audio_sustain $1B
    audio_note $03, $1B                            ; D2
    audio_sustain $60
    audio_note $03, $0E                            ; D2
    audio_sustain $0E
    audio_note $03, $0E                            ; D2
    audio_sustain $0D
    audio_note $03, $0E                            ; D2
    audio_reg_set rNR22, $B7
    audio_note $04, $0E                            ; D#2
    audio_reg_set rNR22, $C7
    audio_note $08, $0D                            ; G2
    audio_reg_set rNR22, $C7
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $C8
    audio_sustain $75
    audio_reg_set rNR22, $A7
    audio_note $25, $37                            ; C5
    audio_note $2C, $36                            ; G5
    audio_note $2F, $37                            ; A#5
    audio_note $34, $37                            ; D#6
    audio_note $27, $37                            ; D5
    audio_note $2A, $37                            ; F5
    audio_note $2E, $37                            ; A5
    audio_note $33, $36                            ; D6
    audio_reg_set rNR22, $A7
    audio_note $25, $37                            ; C5
    audio_note $2C, $37                            ; G5
    audio_note $2F, $37                            ; A#5
    audio_note $34, $36                            ; D#6
    audio_note $27, $37                            ; D5
    audio_note $2A, $1C                            ; F5
    audio_note $2C, $1B                            ; G5
    audio_reg_set rNR22, $B7
    audio_note $2E, $37                            ; A5
    audio_note $33, $37                            ; D6
    audio_reg_set rNR22, $A7
    audio_note $25, $37                            ; C5
    audio_note $2C, $37                            ; G5
    audio_note $2F, $37                            ; A#5
    audio_note $34, $36                            ; D#6
    audio_note $27, $37                            ; D5
    audio_note $2A, $37                            ; F5
    audio_note $2E, $37                            ; A5
    audio_note $33, $37                            ; D6
    audio_note $25, $37                            ; C5
    audio_note $2C, $36                            ; G5
    audio_note $2F, $37                            ; A#5
    audio_note $34, $37                            ; D#6
    audio_note $27, $37                            ; D5
    audio_note $2A, $1B                            ; F5
    audio_note $2C, $1C                            ; G5
    audio_reg_set rNR22, $B7
    audio_note $2E, $37                            ; A5
    audio_note $33, $37                            ; D6
    audio_note $1C, $0D                            ; D#4
    audio_note $20, $0E                            ; G4
    audio_note $23, $0E                            ; A#4
    audio_note $1C, $0D                            ; D#4
    audio_note $20, $0E                            ; G4
    audio_note $25, $0E                            ; C5
    audio_note $1C, $0E                            ; D#4
    audio_note $20, $0D                            ; G4
    audio_note $23, $0E                            ; A#4
    audio_note $1C, $0E                            ; D#4
    audio_note $20, $0D                            ; G4
    audio_note $25, $0E                            ; C5
    audio_note $23, $0E                            ; A#4
    audio_note $25, $0E                            ; C5
    audio_note $23, $0D                            ; A#4
    audio_note $22, $0E                            ; A4
    audio_note $1B, $0E                            ; D4
    audio_note $20, $0D                            ; G4
    audio_note $27, $0E                            ; D5
    audio_note $1B, $0E                            ; D4
    audio_note $20, $0E                            ; G4
    audio_note $28, $0D                            ; D#5
    audio_note $1B, $0E                            ; D4
    audio_note $20, $0E                            ; G4
    audio_note $27, $0D                            ; D5
    audio_note $23, $0E                            ; A#4
    audio_note $27, $0E                            ; D5
    audio_note $23, $0E                            ; A#4
    audio_note $28, $0D                            ; D#5
    audio_note $27, $0E                            ; D5
    audio_note $25, $0E                            ; C5
    audio_note $27, $0D                            ; D5
    audio_reg_set rNR22, $B7
    audio_note $1C, $0E                            ; D#4
    audio_note $20, $0D                            ; G4
    audio_note $25, $0E                            ; C5
    audio_note $23, $0E                            ; A#4
    audio_note $20, $0E                            ; G4
    audio_note $25, $0D                            ; C5
    audio_note $1C, $0E                            ; D#4
    audio_note $20, $0E                            ; G4
    audio_note $23, $0D                            ; A#4
    audio_note $20, $0E                            ; G4
    audio_note $25, $0E                            ; C5
    audio_note $23, $0E                            ; A#4
    audio_note $1C, $0D                            ; D#4
    audio_note $20, $0E                            ; G4
    audio_note $23, $0E                            ; A#4
    audio_note $25, $0D                            ; C5
    audio_note $27, $0E                            ; D5
    audio_note $1B, $0E                            ; D4
    audio_note $20, $0E                            ; G4
    audio_note $23, $0D                            ; A#4
    audio_note $28, $0E                            ; D#5
    audio_note $27, $0E                            ; D5
    audio_note $23, $0D                            ; A#4
    audio_note $20, $0E                            ; G4
    audio_note $1B, $0E                            ; D4
    audio_note $20, $0E                            ; G4
    audio_note $28, $0D                            ; D#5
    audio_note $27, $0E                            ; D5
    audio_note $23, $0E                            ; A#4
    audio_note $25, $0D                            ; C5
    audio_note $27, $0E                            ; D5
    audio_note $25, $0E                            ; C5
    audio_reg_set rNR22, $A7
    audio_note $34, $07                            ; D#6
    audio_note $31, $07                            ; C6
    audio_note $2F, $07                            ; A#5
    audio_note $2C, $07                            ; G5
    audio_note $28, $07                            ; D#5
    audio_note $25, $07                            ; C5
    audio_note $23, $07                            ; A#4
    audio_note $20, $06                            ; G4
    audio_note $1C, $07                            ; D#4
    audio_note $19, $07                            ; C4
    audio_note $17, $07                            ; A#3
    audio_note $14, $07                            ; G3
    audio_note $10, $07                            ; D#3
    audio_note $0D, $07                            ; C3
    audio_note $0B, $07                            ; A#2
    audio_note $08, $06                            ; G2
    audio_note $34, $07                            ; D#6
    audio_note $33, $07                            ; D6
    audio_note $2F, $07                            ; A#5
    audio_note $2E, $07                            ; A5
    audio_note $2C, $07                            ; G5
    audio_note $28, $07                            ; D#5
    audio_note $27, $07                            ; D5
    audio_note $25, $06                            ; C5
    audio_note $23, $07                            ; A#4
    audio_note $20, $07                            ; G4
    audio_note $1C, $07                            ; D#4
    audio_note $1B, $07                            ; D4
    audio_note $19, $07                            ; C4
    audio_note $17, $07                            ; A#3
    audio_note $16, $07                            ; A3
    audio_note $14, $06                            ; G3
    audio_note $34, $07                            ; D#6
    audio_note $31, $07                            ; C6
    audio_note $2F, $07                            ; A#5
    audio_note $2C, $07                            ; G5
    audio_note $28, $07                            ; D#5
    audio_note $25, $07                            ; C5
    audio_note $23, $07                            ; A#4
    audio_note $20, $06                            ; G4
    audio_note $1C, $07                            ; D#4
    audio_note $19, $07                            ; C4
    audio_note $17, $07                            ; A#3
    audio_note $14, $07                            ; G3
    audio_note $10, $07                            ; D#3
    audio_note $0F, $07                            ; D3
    audio_note $0D, $07                            ; C3
    audio_note $0B, $06                            ; A#2
    audio_note $38, $07                            ; G6
    audio_note $34, $07                            ; D#6
    audio_note $33, $07                            ; D6
    audio_note $2F, $07                            ; A#5
    audio_note $2E, $07                            ; A5
    audio_note $2C, $07                            ; G5
    audio_note $28, $07                            ; D#5
    audio_note $27, $06                            ; D5
    audio_note $25, $07                            ; C5
    audio_note $23, $07                            ; A#4
    audio_note $22, $07                            ; A4
    audio_note $20, $07                            ; G4
    audio_note $1C, $07                            ; D#4
    audio_note $1B, $07                            ; D4
    audio_note $19, $07                            ; C4
    audio_note $17, $06                            ; A#3
    audio_note $34, $07                            ; D#6
    audio_note $31, $07                            ; C6
    audio_note $2F, $07                            ; A#5
    audio_note $2E, $07                            ; A5
    audio_note $2C, $07                            ; G5
    audio_note $28, $07                            ; D#5
    audio_note $27, $07                            ; D5
    audio_note $25, $06                            ; C5
    audio_note $23, $07                            ; A#4
    audio_note $22, $07                            ; A4
    audio_note $20, $07                            ; G4
    audio_note $1C, $07                            ; D#4
    audio_note $1B, $07                            ; D4
    audio_note $19, $07                            ; C4
    audio_note $17, $07                            ; A#3
    audio_note $14, $06                            ; G3
    audio_note $31, $07                            ; C6
    audio_note $33, $07                            ; D6
    audio_note $34, $07                            ; D#6
    audio_note $2C, $07                            ; G5
    audio_note $2E, $06                            ; A5
    audio_note $2F, $07                            ; A#5
    audio_note $25, $07                            ; C5
    audio_note $27, $06                            ; D5
    audio_note $28, $07                            ; D#5
    audio_note $20, $07                            ; G4
    audio_note $22, $07                            ; A4
    audio_note $23, $07                            ; A#4
    audio_note $19, $06                            ; C4
    audio_note $1B, $07                            ; D4
    audio_note $1C, $07                            ; D#4
    audio_note $14, $06                            ; G3
    audio_note $34, $07                            ; D#6
    audio_note $33, $07                            ; D6
    audio_note $31, $07                            ; C6
    audio_note $2F, $07                            ; A#5
    audio_note $2E, $07                            ; A5
    audio_note $2C, $07                            ; G5
    audio_note $25, $07                            ; C5
    audio_note $27, $06                            ; D5
    audio_note $28, $07                            ; D#5
    audio_note $23, $07                            ; A#4
    audio_note $22, $07                            ; A4
    audio_note $20, $07                            ; G4
    audio_note $19, $07                            ; C4
    audio_note $1B, $07                            ; D4
    audio_note $1C, $07                            ; D#4
    audio_note $17, $06                            ; A#3
    audio_note $19, $07                            ; C4
    audio_note $1B, $07                            ; D4
    audio_note $1C, $07                            ; D#4
    audio_note $20, $07                            ; G4
    audio_note $22, $07                            ; A4
    audio_note $23, $07                            ; A#4
    audio_note $25, $07                            ; C5
    audio_note $27, $06                            ; D5
    audio_note $28, $07                            ; D#5
    audio_note $2C, $07                            ; G5
    audio_note $2E, $07                            ; A5
    audio_note $2F, $07                            ; A#5
    audio_note $31, $07                            ; C6
    audio_note $33, $07                            ; D6
    audio_note $34, $07                            ; D#6
    audio_note $33, $06                            ; D6
    audio_loop .loop
