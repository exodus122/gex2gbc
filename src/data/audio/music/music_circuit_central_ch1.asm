; bank $21: MUSIC_CIRCUIT_CENTRAL ch1
;
; One driver track for hardware channel 1 (pulse A), 582 bytes, 192 notes, ending in
; AUDIO_CMD_LOOP, so it repeats forever.
;
; Reached through data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $87
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $A7
.loop:
    audio_reg_set rNR12, $A7
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $47
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $37
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $47
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $97
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $47
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $37
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $A7
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $47
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $37
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $47
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $97
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $A7
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $47
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $37
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $47
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $97
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $A7
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $47
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $37
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $47
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $97
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $A7
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $47
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $37
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $47
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $97
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $A7
    audio_note $08, $20                            ; G2
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $97
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $87
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $77
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $67
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_reg_set rNR12, $57
    audio_note $19, $20                            ; C4
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $47
    audio_note $01, $20                            ; C2
    audio_note $19, $20                            ; C4
    audio_reg_set rNR12, $37
    audio_note $01, $20                            ; C2
    audio_loop .loop
