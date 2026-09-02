; banks $21, $22, $23: SFX_ENEMY_DEFEATED (sfx $17)
;
; One driver track for hardware channel 1 (pulse A), 24 bytes, 4 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $1F
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $50
    audio_note $24, $05                            ; B4
    audio_note $23, $05                            ; A#4
    audio_note $22, $14                            ; A4
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
