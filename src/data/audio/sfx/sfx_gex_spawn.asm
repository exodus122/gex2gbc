; banks $21, $22, $23: SFX_GEX_SPAWN (sfx $11)
;
; One driver track for hardware channel 1 (pulse A), 430 bytes, 185 notes, ending in
; AUDIO_CMD_END.
;
; Assembled separately at each of the sites above, so the ROM holds one copy per
; site - see data_21_4460_TrackPointerTables.
    audio_channel 1                                ; pulse A
    audio_reg_set rNR51, $FF
    audio_reg_set rNR50, $77
    audio_reg_set rNR10, $17
    audio_reg_set rNR11, $FF
    audio_reg_set rNR12, $C7
    audio_reg_set rNR12, $17
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $27
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $37
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $47
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $57
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $67
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $77
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $87
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $97
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $A7
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $B7
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $C7
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $B7
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $A7
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $97
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $87
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $77
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $67
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $57
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $47
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $37
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $27
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_note $25, $01                            ; C5
    audio_note $19, $01                            ; C4
    audio_reg_set rNR12, $17
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_note $3D, $01                            ; C7
    audio_note $31, $01                            ; C6
    audio_reg_set rNR12, $07
    audio_sustain $1E
    audio_end
