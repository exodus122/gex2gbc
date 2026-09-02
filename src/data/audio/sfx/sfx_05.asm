; banks $21, $22, $23: SFX_05 (sfx $05)
; banks $21, $22, $23: SFX_07 (sfx $07)
; banks $21, $22, $23: SFX_08 (sfx $08)
; banks $21, $22, $23: SFX_HARD_HEAD_AREA_HAZARD (sfx $19)
;
; One driver track for hardware channel 1 (pulse A), 14 bytes, 1 note, ending in
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
    audio_rest $0C
    audio_end
