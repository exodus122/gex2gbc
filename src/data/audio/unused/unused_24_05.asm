; bank $24: entry $05 - unreachable, nothing selects bank $24
; bank $24: entry $07 - unreachable, nothing selects bank $24
; bank $24: entry $08 - unreachable, nothing selects bank $24
; bank $24: entry $19 - unreachable, nothing selects bank $24
;
; One driver track for hardware channel 1 (pulse A), 20 bytes, 1 note, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR52, $00
    audio_reg_set rNR52, $80
    audio_reg_set rNR52, $81
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $00
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_rest $0C
    audio_end
