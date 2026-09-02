; banks $21, $22, $23: SFX_EXPLOSION (sfx $37)
;
; One driver track for hardware channel 1 (pulse A), 88 bytes, 20 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $7F
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $77
    audio_reg_set rNR12, $F7
    audio_note $01, $0A                            ; C2
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $F7
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $F7
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $F7
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $E7
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $D7
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $C7
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $B7
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $97
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $87
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $77
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $67
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $57
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $47
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $37
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $27
    audio_note $0C, $01                            ; B2
    audio_reg_set rNR12, $17
    audio_note $0D, $01                            ; C3
    audio_reg_set rNR12, $07
    audio_note $0C, $01                            ; B2
    audio_sustain $2D
    audio_end
