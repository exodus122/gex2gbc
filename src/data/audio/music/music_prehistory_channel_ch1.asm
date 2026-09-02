; bank $21: MUSIC_PREHISTORY_CHANNEL ch1
;
; One driver track for hardware channel 1 (pulse A), 1800 bytes, 549 notes, ending in
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
    audio_reg_set rNR12, $77
.loop:
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1C                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $57
    audio_note $01, $1B                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $57
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0E                            ; C3
    audio_reg_set rNR12, $67
    audio_note $01, $0D                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1C                            ; C2
    audio_note $0D, $0D                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0E
    audio_reg_set rNR12, $67
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $57
    audio_note $0D, $0E                            ; C3
    audio_note $01, $1B                            ; C2
    audio_reg_set rNR12, $67
    audio_note $0D, $0E                            ; C3
    audio_note $01, $0E                            ; C2
    audio_reg_set rNR12, $77
    audio_sustain $0D
    audio_reg_set rNR12, $47
    audio_note $25, $37                            ; C5
    audio_reg_set rNR12, $37
    audio_note $25, $37                            ; C5
    audio_reg_set rNR12, $27
    audio_note $25, $37                            ; C5
    audio_reg_set rNR12, $17
    audio_note $25, $36                            ; C5
    audio_reg_set rNR12, $47
    audio_note $27, $37                            ; D5
    audio_reg_set rNR12, $37
    audio_note $27, $37                            ; D5
    audio_reg_set rNR12, $27
    audio_note $27, $37                            ; D5
    audio_reg_set rNR12, $17
    audio_note $27, $37                            ; D5
    audio_reg_set rNR12, $47
    audio_note $25, $37                            ; C5
    audio_reg_set rNR12, $37
    audio_note $25, $37                            ; C5
    audio_reg_set rNR12, $27
    audio_note $25, $37                            ; C5
    audio_reg_set rNR12, $17
    audio_note $25, $36                            ; C5
    audio_reg_set rNR12, $47
    audio_note $2C, $32                            ; G5
    audio_reg_set rNR12, $37
    audio_note $2C, $32                            ; G5
    audio_reg_set rNR12, $27
    audio_note $2C, $32                            ; G5
    audio_reg_set rNR12, $17
    audio_note $2C, $2A                            ; G5
    audio_reg_set rNR12, $67
    audio_reg_set rNR12, $47
    audio_note $28, $1C                            ; D#5
    audio_note $25, $6D                            ; C5
    audio_note $2C, $37                            ; G5
    audio_reg_set rNR12, $67
    audio_note $1C, $37                            ; D#4
    audio_note $1B, $DC                            ; D4
    audio_reg_set rNR12, $57
    audio_note $19, $DB                            ; C4
    audio_note $1B, $DB                            ; D4
    audio_reg_set rNR12, $57
    audio_note $19, $DB                            ; C4
    audio_note $20, $C0                            ; G4
    audio_reg_set rNR12, $37
    audio_note $28, $1C                            ; D#5
    audio_reg_set rNR12, $47
    audio_note $25, $6E                            ; C5
    audio_note $2C, $36                            ; G5
    audio_note $28, $37                            ; D#5
    audio_note $27, $DC                            ; D5
    audio_note $25, $6D                            ; C5
    audio_reg_set rNR12, $57
    audio_note $20, $37                            ; G4
    audio_reg_set rNR12, $47
    audio_note $28, $37                            ; D#5
    audio_reg_set rNR12, $37
    audio_note $2C, $C0                            ; G5
    audio_note $28, $1C                            ; D#5
    audio_note $25, $6D                            ; C5
    audio_reg_set rNR12, $47
    audio_note $2C, $37                            ; G5
    audio_note $28, $52                            ; D#5
    audio_reg_set rNR12, $67
    audio_note $33, $05                            ; D6
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR12, $57
    audio_note $33, $04                            ; D6
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR12, $67
    audio_note $33, $04                            ; D6
    audio_note $2E, $05                            ; A5
    audio_note $33, $04                            ; D6
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $57
    audio_note $33, $05                            ; D6
    audio_note $2E, $04                            ; A5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $57
    audio_note $33, $05                            ; D6
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_note $34, $04                            ; D#6
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR12, $67
    audio_note $34, $04                            ; D#6
    audio_note $2E, $05                            ; A5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $05                            ; D#6
    audio_note $2E, $04                            ; A5
    audio_reg_set rNR12, $77
    audio_sustain $13
    audio_note $34, $04                            ; D#6
    audio_note $2F, $05                            ; A#5
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $04                            ; D#6
    audio_note $2F, $05                            ; A#5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $05                            ; D#6
    audio_note $2F, $04                            ; A#5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_note $31, $12                            ; C6
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $5B
    audio_note $31, $09                            ; C6
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $0A
    audio_note $31, $09                            ; C6
    audio_sustain $09
    audio_reg_set rNR12, $47
    audio_note $2F, $09                            ; A#5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $57
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $33, $0A                            ; D6
    audio_reg_set rNR12, $57
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $5B
    audio_reg_set rNR12, $47
    audio_note $33, $0A                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $57
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_note $34, $09                            ; D#6
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $0A
    audio_reg_set rNR12, $67
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $5C
    audio_reg_set rNR12, $57
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $0A                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $57
    audio_note $2F, $09                            ; A#5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $67
    audio_note $33, $0A                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $5B
    audio_reg_set rNR12, $57
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $0A
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $09                            ; D#6
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $09                            ; D#6
    audio_note $34, $0A                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_note $31, $09                            ; C6
    audio_sustain $5C
    audio_reg_set rNR12, $57
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $0A
    audio_reg_set rNR12, $57
    audio_note $2F, $09                            ; A#5
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $31, $09                            ; C6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $57
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $0A
    audio_note $33, $09                            ; D6
    audio_sustain $24
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_note $34, $0A                            ; D#6
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $09                            ; D#6
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $09                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $34, $0A                            ; D#6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $57
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $09
    audio_reg_set rNR12, $67
    audio_note $33, $09                            ; D6
    audio_note $33, $09                            ; D6
    audio_reg_set rNR12, $77
    audio_sustain $0A
    audio_loop .loop
