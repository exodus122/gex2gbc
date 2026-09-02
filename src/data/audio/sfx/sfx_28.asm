; banks $21, $22, $23: SFX_28 (sfx $28)
;
; One driver track for hardware channel 1 (pulse A), 64 bytes, 16 notes, ending in
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
    audio_reg_set rNR12, $57
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $47
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $37
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $27
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_reg_set rNR12, $17
    audio_note $1D, $07                            ; E4
    audio_note $19, $07                            ; C4
    audio_note $16, $07                            ; A3
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
