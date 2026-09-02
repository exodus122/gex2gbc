; bank $21: MUSIC_CIRCUIT_CENTRAL ch2
;
; One driver track for hardware channel 2 (pulse B), 550 bytes, 161 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 2                                ; pulse B
    audio_reg_set rNR21, $FF
    audio_reg_set rNR22, $A7
.loop:
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_note $19, $60                            ; C4
    audio_reg_set rNR22, $87
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $57
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $37
    audio_note $1C, $40                            ; D#4
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $97
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $37
    audio_note $19, $40                            ; C4
    audio_note $19, $40                            ; C4
    audio_reg_set rNR22, $97
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $37
    audio_note $19, $40                            ; C4
    audio_note $19, $40                            ; C4
    audio_reg_set rNR22, $77
    audio_note $14, $20                            ; G3
    audio_reg_set rNR22, $57
    audio_note $14, $20                            ; G3
    audio_reg_set rNR22, $97
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $40                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_note $1C, $01                            ; D#4
    audio_reg_set rNR22, $97
    audio_note $1C, $3F                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $57
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $40                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $37
    audio_note $17, $20                            ; A#3
    audio_reg_set rNR22, $97
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR22, $77
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $17, $40                            ; A#3
    audio_note $17, $20                            ; A#3
    audio_reg_set rNR22, $47
    audio_note $17, $20                            ; A#3
    audio_sustain $20
    audio_reg_set rNR22, $47
    audio_note $17, $20                            ; A#3
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $57
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_note $19, $60                            ; C4
    audio_reg_set rNR22, $87
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $57
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $37
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $37
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $97
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $37
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $37
    audio_note $19, $40                            ; C4
    audio_reg_set rNR22, $97
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $37
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $37
    audio_note $19, $40                            ; C4
    audio_reg_set rNR22, $77
    audio_note $14, $20                            ; G3
    audio_note $14, $20                            ; G3
    audio_reg_set rNR22, $97
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $40                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $97
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $77
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $67
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $57
    audio_note $1C, $40                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $40                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $37
    audio_note $17, $20                            ; A#3
    audio_reg_set rNR22, $97
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR22, $77
    audio_note $17, $40                            ; A#3
    audio_reg_set rNR22, $67
    audio_note $17, $40                            ; A#3
    audio_note $17, $20                            ; A#3
    audio_reg_set rNR22, $47
    audio_note $17, $40                            ; A#3
    audio_note $17, $20                            ; A#3
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $87
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $77
    audio_note $19, $20                            ; C4
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $47
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $57
    audio_note $19, $20                            ; C4
    audio_reg_set rNR22, $67
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $57
    audio_note $1C, $20                            ; D#4
    audio_note $1C, $20                            ; D#4
    audio_reg_set rNR22, $47
    audio_note $1C, $20                            ; D#4
    audio_loop .loop
