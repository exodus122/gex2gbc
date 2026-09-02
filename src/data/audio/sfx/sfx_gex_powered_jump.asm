; banks $21, $22, $23: SFX_GEX_POWERED_JUMP (sfx $2A)
;
; One driver track for hardware channel 1 (pulse A), 18 bytes, 3 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $77
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_note $19, $0F                            ; C4
    audio_note $26, $0F                            ; C#5
    audio_note $33, $2D                            ; D6
    audio_end
