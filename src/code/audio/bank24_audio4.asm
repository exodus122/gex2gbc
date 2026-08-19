; ==================================================================
; SOUND DRIVER
;
; Banks $21-$24 each hold a byte-for-byte identical copy of this driver followed by
; their own track data, so a track is addressed as (bank, id) and the bank is switched
; by wD788_CurrentAudioBank before any entry point here is called.
;
; THREE ENTRY POINTS, called from bank 0:
;   Audio_Init      once, at boot - clears the driver's state and silences everything
;   Audio_PlaySfx   start sound effect id A
;   Audio_PlayMusic start music track id A
;   Audio_Update    once per frame, from the main loop
;
; MUSIC AND SFX RUN AS TWO PARALLEL SETS OF FOUR CHANNELS. Each set has its own
; sequence pointers, duration counters and active-channel mask:
;
;                    music                              sfx
;   pointers         wDFB0_Audio_MusicChannelPtrs       wDFC3_Audio_SfxChannelPtrs
;   timers           wDFB9_Audio_MusicTimerCh1 ...      wDFCB_Audio_SfxTimerCh1 ...
;   active mask      wDFC2_Audio_MusicChannelsActive    wDFCF_Audio_SfxChannelsActive
;
; Where both want the same hardware channel the sfx wins, and the music's registers
; for that channel are saved into wDFD2_Audio_SavedMusicRegs when the sfx starts and
; put back when it ends - so the music does not restart, it resumes mid-note. The wave
; channel gets the same treatment for its 16 bytes of wave RAM through
; wDFE6_Audio_SavedWaveRam. data_24_439e_ChannelSaveRegs is the list of which
; registers are worth saving per channel.
;
; A SEQUENCE is a byte stream walked by Audio_RunSequence, which runs commands until
; it hits a note and then returns that note's duration - the caller stores it as the
; channel's countdown and comes back when it expires. So one call advances one channel
; by one note, however many register writes are in front of it. See the AUDIO_CMD_*
; and AUDIO_NOTE_* constants for the opcode map.
;
; THE TRACK TABLES at data_24_4460_TrackPointerTables are two lists of self-relative
; words. The first word of the block is the offset to the sfx list; the music list
; starts immediately after it. This bank is the odd one out: its sfx
; list is empty and all 66 of its entries are reached through Audio_PlayMusic
; ==================================================================

SECTION "bank24", ROMX[$4000], BANK[$24]

call_24_4000_Audio_Init:
; Boot-time reset. Points wDFAE_AudioBankDataPointer at this bank's track tables,
; clears every channel mask, both sets of duration counters and rNR51, then wipes the
; 20-byte music register save area and the 16-byte wave RAM save area. It does not
; touch rNR52, so the APU is left however the caller had it
    ld   HL, data_24_4460_TrackPointerTables                              ;; 24:4000 $21 $60 $44
    ld   A, L                                          ;; 24:4003 $7d
    ld   [wDFAE_AudioBankDataPointer], A                                    ;; 24:4004 $ea $ae $df
    ld   A, H                                          ;; 24:4007 $7c
    ld   [wDFAF_AudioBankDataPointer], A                                    ;; 24:4008 $ea $af $df
    xor  A, A                                          ;; 24:400b $af
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 24:400c $ea $c2 $df
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 24:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 24:4012 $e0 $25
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 24:4014 $ea $b8 $df
    ld   [wDFB9_Audio_MusicTimerCh1], A                                    ;; 24:4017 $ea $b9 $df
    ld   [wDFBA_Audio_MusicTimerCh2], A                                    ;; 24:401a $ea $ba $df
    ld   [wDFBB_Audio_MusicTimerCh3], A                                    ;; 24:401d $ea $bb $df
    ld   [wDFBC_Audio_MusicTimerCh4], A                                    ;; 24:4020 $ea $bc $df
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 24:4023 $ea $cf $df
    ld   [wDFCB_Audio_SfxTimerCh1], A                                    ;; 24:4026 $ea $cb $df
    ld   [wDFCC_Audio_SfxTimerCh2], A                                    ;; 24:4029 $ea $cc $df
    ld   [wDFCD_Audio_SfxTimerCh3], A                                    ;; 24:402c $ea $cd $df
    ld   [wDFCE_Audio_SfxTimerCh4], A                                    ;; 24:402f $ea $ce $df
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 24:4032 $21 $d2 $df
    ld   C, $14                                        ;; 24:4035 $0e $14
    xor  A, A                                          ;; 24:4037 $af
jr_24_4038:
    ld   [HL+], A                                      ;; 24:4038 $22
    dec  C                                             ;; 24:4039 $0d
    jr   NZ, jr_24_4038                                ;; 24:403a $20 $fc
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 24:403c $21 $e6 $df
    ld   C, $10                                        ;; 24:403f $0e $10
    xor  A, A                                          ;; 24:4041 $af
.jr_24_4042:
    ld   [HL+], A                                      ;; 24:4042 $22
    dec  C                                             ;; 24:4043 $0d
    jr   NZ, .jr_24_4042                               ;; 24:4044 $20 $fc
    ret                                                ;; 24:4046 $c9

call_24_4047_Audio_PlaySfx:
; Start sound effect id A.
;
; Before anything is queued this snapshots the hardware state of the channels the
; effect is about to take: data_24_439e_ChannelSaveRegs lists five (register, mask)
; pairs per channel, and each register is read, masked and written into that channel's
; slot of wDFD2_Audio_SavedMusicRegs. The mask keeps only the bits worth restoring -
; the length counters and trigger bits are deliberately dropped.
;
; It then follows the first word of the track table block, which is the offset to the
; sfx list, and falls into the shared start-up path below with
; wDFD1_Audio_RequestKind = AUDIO_REQUEST_SFX
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 24:4047 $ea $d0 $df
    ld   A, $01                                        ;; 24:404a $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 24:404c $ea $d1 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 24:404f $fa $d0 $df
    sla  A                                             ;; 24:4052 $cb $27
    ld   E, A                                          ;; 24:4054 $5f
    sla  A                                             ;; 24:4055 $cb $27
    ld   C, A                                          ;; 24:4057 $4f
    sla  A                                             ;; 24:4058 $cb $27
    add  A, E                                          ;; 24:405a $83
    ld   DE, data_24_439e_ChannelSaveRegs                              ;; 24:405b $11 $9e $43
    add  A, E                                          ;; 24:405e $83
    ld   E, A                                          ;; 24:405f $5f
    jr   NC, .jr_24_4063                               ;; 24:4060 $30 $01
    inc  D                                             ;; 24:4062 $14
.jr_24_4063:
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 24:4063 $21 $d2 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 24:4066 $fa $d0 $df
    add  A, C                                          ;; 24:4069 $81
    add  A, L                                          ;; 24:406a $85
    ld   L, A                                          ;; 24:406b $6f
    jr   NC, .jr_24_406f                               ;; 24:406c $30 $01
    inc  H                                             ;; 24:406e $24
.jr_24_406f:
    ld   B, $ff                                        ;; 24:406f $06 $ff
.jr_24_4071:
    ld   A, [DE]                                       ;; 24:4071 $1a
    and  A, A                                          ;; 24:4072 $a7
    jr   Z, .jr_24_407f                                ;; 24:4073 $28 $0a
    inc  DE                                            ;; 24:4075 $13
    ld   C, A                                          ;; 24:4076 $4f
    ld   A, [BC]                                       ;; 24:4077 $0a
    ld   C, A                                          ;; 24:4078 $4f
    ld   A, [DE]                                       ;; 24:4079 $1a
    inc  DE                                            ;; 24:407a $13
    and  A, C                                          ;; 24:407b $a1
    ld   [HL+], A                                      ;; 24:407c $22
    jr   .jr_24_4071                                   ;; 24:407d $18 $f2
.jr_24_407f:
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 24:407f $fa $ae $df
    ld   E, A                                          ;; 24:4082 $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 24:4083 $fa $af $df
    ld   D, A                                          ;; 24:4086 $57
    ld   A, [DE]                                       ;; 24:4087 $1a
    add  A, E                                          ;; 24:4088 $83
    ld   L, A                                          ;; 24:4089 $6f
    inc  DE                                            ;; 24:408a $13
    ld   A, [DE]                                       ;; 24:408b $1a
    dec  DE                                            ;; 24:408c $1b
    adc  A, D                                          ;; 24:408d $8a
    ld   D, A                                          ;; 24:408e $57
    ld   E, L                                          ;; 24:408f $5d
    jr   jr_24_40a4_Audio_StartTrack                                    ;; 24:4090 $18 $12

call_24_4092_Audio_PlayMusic:
; Start music track id A. No state is saved, because music is what gets interrupted
; rather than what does the interrupting; the music list begins two bytes into the
; track table block, immediately after the word that locates the sfx list
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 24:4092 $ea $d0 $df
    ld   A, $02                                        ;; 24:4095 $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 24:4097 $ea $d1 $df
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 24:409a $fa $ae $df
    ld   E, A                                          ;; 24:409d $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 24:409e $fa $af $df
    ld   D, A                                          ;; 24:40a1 $57
    inc  DE                                            ;; 24:40a2 $13
    inc  DE                                            ;; 24:40a3 $13

jr_24_40a4_Audio_StartTrack:
; The half of track start-up both entry points share. DE arrives pointing at the right
; list, and the id selects a self-relative word from it - so a track pointer is stored
; as a distance rather than an address and the whole block is position independent.
;
; The first byte of a track is its channel count, and the mask of channels it claims is
; built from that by shifting a 1 in that many times - a track always takes channels 1
; to N rather than choosing them. That mask is OR'd into whichever active-channel mask
; this request kind owns, and the request kind also selects which set of pointer and
; timer arrays gets written.
;
; The channel byte that follows then indexes those arrays, the sequence pointer is
; stored, and Audio_RunSequence is called once to prime the first note - its return
; value is that channel's initial countdown
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 24:40a4 $fa $d0 $df
    add  A, A                                          ;; 24:40a7 $87
    ld   L, A                                          ;; 24:40a8 $6f
    ld   A, D                                          ;; 24:40a9 $7a
    adc  A, $00                                        ;; 24:40aa $ce $00
    ld   D, A                                          ;; 24:40ac $57
    ld   A, E                                          ;; 24:40ad $7b
    add  A, L                                          ;; 24:40ae $85
    ld   E, A                                          ;; 24:40af $5f
    ld   A, D                                          ;; 24:40b0 $7a
    adc  A, $00                                        ;; 24:40b1 $ce $00
    ld   D, A                                          ;; 24:40b3 $57
    ld   A, [DE]                                       ;; 24:40b4 $1a
    add  A, E                                          ;; 24:40b5 $83
    ld   L, A                                          ;; 24:40b6 $6f
    inc  DE                                            ;; 24:40b7 $13
    ld   A, [DE]                                       ;; 24:40b8 $1a
    dec  DE                                            ;; 24:40b9 $1b
    adc  A, D                                          ;; 24:40ba $8a
    ld   D, A                                          ;; 24:40bb $57
    ld   E, L                                          ;; 24:40bc $5d
    ld   A, [DE]                                       ;; 24:40bd $1a
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 24:40be $ea $fe $df
    ld   L, A                                          ;; 24:40c1 $6f
    xor  A, A                                          ;; 24:40c2 $af
    scf                                                ;; 24:40c3 $37
.jr_24_40c4:
    rl   A                                             ;; 24:40c4 $cb $17
    dec  L                                             ;; 24:40c6 $2d
    jr   NZ, .jr_24_40c4                               ;; 24:40c7 $20 $fb
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 24:40c9 $ea $c1 $df
    ld   L, A                                          ;; 24:40cc $6f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 24:40cd $fa $d1 $df
    cp   A, $01                                        ;; 24:40d0 $fe $01
    jr   NZ, .jr_24_40e3                               ;; 24:40d2 $20 $0f
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:40d4 $fa $cf $df
    or   A, L                                          ;; 24:40d7 $b5
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 24:40d8 $ea $cf $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 24:40db $21 $c3 $df
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 24:40de $01 $cb $df
    jr   .jr_24_40f0                                   ;; 24:40e1 $18 $0d
.jr_24_40e3:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 24:40e3 $fa $c2 $df
    or   A, L                                          ;; 24:40e6 $b5
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 24:40e7 $ea $c2 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 24:40ea $21 $b0 $df
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 24:40ed $01 $b9 $df
.jr_24_40f0:
    ld   A, [DE]                                       ;; 24:40f0 $1a
    dec  A                                             ;; 24:40f1 $3d
    sla  A                                             ;; 24:40f2 $cb $27
    add  A, L                                          ;; 24:40f4 $85
    ld   L, A                                          ;; 24:40f5 $6f
    jr   NC, .jr_24_40f9                               ;; 24:40f6 $30 $01
    inc  H                                             ;; 24:40f8 $24
.jr_24_40f9:
    ld   A, [DE]                                       ;; 24:40f9 $1a
    dec  A                                             ;; 24:40fa $3d
    add  A, C                                          ;; 24:40fb $81
    ld   C, A                                          ;; 24:40fc $4f
    jr   NC, .jr_24_4100                               ;; 24:40fd $30 $01
    inc  B                                             ;; 24:40ff $04
.jr_24_4100:
    inc  DE                                            ;; 24:4100 $13
    ld   [HL], E                                       ;; 24:4101 $73
    inc  HL                                            ;; 24:4102 $23
    ld   [HL], D                                       ;; 24:4103 $72
    dec  HL                                            ;; 24:4104 $2b
    push BC                                            ;; 24:4105 $c5
    call call_24_4199_Audio_RunSequence                                  ;; 24:4106 $cd $99 $41
    pop  BC                                            ;; 24:4109 $c1
    ld   [BC], A                                       ;; 24:410a $02
    ret                                                ;; 24:410b $c9

call_24_410c_Audio_Update:
; The per-frame tick, and the only thing that advances playback.
;
; It walks the four music channels and then the four sfx channels, each with the same
; loop: skip the channel unless its bit is set in the active mask, decrement its
; countdown, and when it reaches zero call Audio_RunSequence for the next note. The
; count it returns becomes the new countdown, so a channel costs nothing on the frames
; between notes.
;
; wDFC1_Audio_CurrentChannelBit is shifted left once per iteration and
; wDFB8_Audio_ChannelIndex counts 0 to 3; both are read by the interpreter, which is
; why they live in WRAM rather than in registers
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 24:410c $01 $b9 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 24:410f $21 $b0 $df
    ld   A, $01                                        ;; 24:4112 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 24:4114 $ea $c1 $df
    ld   A, $00                                        ;; 24:4117 $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 24:4119 $ea $b8 $df
    ld   A, $02                                        ;; 24:411c $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 24:411e $ea $d1 $df
.jp_24_4121:
    push BC                                            ;; 24:4121 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4122 $fa $c1 $df
    ld   D, A                                          ;; 24:4125 $57
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 24:4126 $fa $c2 $df
    and  A, D                                          ;; 24:4129 $a2
    jr   Z, .jr_24_4139                                ;; 24:412a $28 $0d
    ld   A, [BC]                                       ;; 24:412c $0a
    dec  A                                             ;; 24:412d $3d
    jr   NZ, .jr_24_4139                               ;; 24:412e $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 24:4130 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 24:4133 $ea $fe $df
    call call_24_4199_Audio_RunSequence                                  ;; 24:4136 $cd $99 $41
.jr_24_4139:
    pop  BC                                            ;; 24:4139 $c1
    ld   [BC], A                                       ;; 24:413a $02
    inc  BC                                            ;; 24:413b $03
    inc  HL                                            ;; 24:413c $23
    inc  HL                                            ;; 24:413d $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:413e $fa $c1 $df
    sla  A                                             ;; 24:4141 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 24:4143 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 24:4146 $fa $b8 $df
    inc  A                                             ;; 24:4149 $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 24:414a $ea $b8 $df
    cp   A, $04                                        ;; 24:414d $fe $04
    jp   NZ, .jp_24_4121                               ;; 24:414f $c2 $21 $41
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 24:4152 $01 $cb $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 24:4155 $21 $c3 $df
    ld   A, $01                                        ;; 24:4158 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 24:415a $ea $c1 $df
    ld   A, $00                                        ;; 24:415d $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 24:415f $ea $b8 $df
    ld   A, $01                                        ;; 24:4162 $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 24:4164 $ea $d1 $df
.jp_24_4167:
    push BC                                            ;; 24:4167 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4168 $fa $c1 $df
    ld   D, A                                          ;; 24:416b $57
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:416c $fa $cf $df
    and  A, D                                          ;; 24:416f $a2
    jr   Z, .jr_24_417f                                ;; 24:4170 $28 $0d
    ld   A, [BC]                                       ;; 24:4172 $0a
    dec  A                                             ;; 24:4173 $3d
    jr   NZ, .jr_24_417f                               ;; 24:4174 $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 24:4176 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 24:4179 $ea $fe $df
    call call_24_4199_Audio_RunSequence                                  ;; 24:417c $cd $99 $41
.jr_24_417f:
    pop  BC                                            ;; 24:417f $c1
    ld   [BC], A                                       ;; 24:4180 $02
    inc  BC                                            ;; 24:4181 $03
    inc  HL                                            ;; 24:4182 $23
    inc  HL                                            ;; 24:4183 $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4184 $fa $c1 $df
    sla  A                                             ;; 24:4187 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 24:4189 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 24:418c $fa $b8 $df
    inc  A                                             ;; 24:418f $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 24:4190 $ea $b8 $df
    cp   A, $04                                        ;; 24:4193 $fe $04
    jp   NZ, .jp_24_4167                               ;; 24:4195 $c2 $67 $41
    ret                                                ;; 24:4198 $c9

call_24_4199_Audio_RunSequence:
; Runs one channel's sequence until it produces a note, and returns that note's
; duration in A. HL points at the channel's stored sequence pointer, which is read in,
; walked, and written back before returning.
;
; The command set, in the order the dispatch tests it:
;
;   AUDIO_CMD_LOOP    ($FE) read a word and subtract it from the current position, so
;                     loops are backward jumps by distance. The byte at the
;                     destination is then executed immediately
;   AUDIO_CMD_END     ($FF) release the channel. For an sfx this is where the saved
;                     music registers go back - and the wave channel's saved wave RAM
;                     with them - and if the music still wants the channel it simply
;                     carries on. If nothing wants it, its enable bit is cleared in
;                     rNR52
;   AUDIO_CMD_LOAD_WAVE ($FD) copy the next 16 bytes straight into wave RAM
;   $A0-$BF           reg = reg AND data. The register is the opcode minus $90
;   $C0-$DF           reg = reg OR data. The register is the opcode minus $B0
;   $E0-$FC           reg = data. The register is the opcode minus $D0
;   anything else     a note, and the loop ends
;
; A note indexes data_24_43ce_NoteFrequencies for an 11-bit frequency, writes it to the
; channel's frequency registers with the trigger bit set, and enables the channel in
; rNR52. AUDIO_NOTE_REST silences the channel instead, and AUDIO_NOTE_SUSTAIN
; retriggers it without touching the pitch. The byte after the note is its duration.
;
; While an sfx owns a channel the music's note writes are computed and stored to
; wDFF6_Audio_ChannelFreqShadow but kept out of the hardware registers, which is how
; the music stays in time underneath and reappears in the right place
    ld   C, [HL]                                       ;; 24:4199 $4e
    inc  HL                                            ;; 24:419a $23
    ld   B, [HL]                                       ;; 24:419b $46
.jp_24_419c:
    ld   A, [BC]                                       ;; 24:419c $0a
    cp   A, $fe                                        ;; 24:419d $fe $fe
    jr   NZ, .jr_24_41ae                               ;; 24:419f $20 $0d
    inc  BC                                            ;; 24:41a1 $03
    ld   A, [BC]                                       ;; 24:41a2 $0a
    ld   E, A                                          ;; 24:41a3 $5f
    inc  BC                                            ;; 24:41a4 $03
    ld   A, [BC]                                       ;; 24:41a5 $0a
    ld   D, A                                          ;; 24:41a6 $57
    ld   A, C                                          ;; 24:41a7 $79
    sub  A, E                                          ;; 24:41a8 $93
    ld   C, A                                          ;; 24:41a9 $4f
    ld   A, B                                          ;; 24:41aa $78
    sbc  A, D                                          ;; 24:41ab $9a
    ld   B, A                                          ;; 24:41ac $47
    ld   A, [BC]                                       ;; 24:41ad $0a
.jr_24_41ae:
    inc  BC                                            ;; 24:41ae $03
    cp   A, $ff                                        ;; 24:41af $fe $ff
    jp   NZ, .jp_24_426f                               ;; 24:41b1 $c2 $6f $42
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:41b4 $fa $c1 $df
    cpl                                                ;; 24:41b7 $2f
    ld   E, A                                          ;; 24:41b8 $5f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 24:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 24:41bc $fe $01
    jp   NZ, .jp_24_4253                               ;; 24:41be $c2 $53 $42
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:41c1 $fa $cf $df
    and  A, E                                          ;; 24:41c4 $a3
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 24:41c5 $ea $cf $df
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 24:41c8 $fa $c2 $df
    ld   E, A                                          ;; 24:41cb $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:41cc $fa $c1 $df
    and  A, E                                          ;; 24:41cf $a3
    jp   Z, .jp_24_4265                                ;; 24:41d0 $ca $65 $42
    push HL                                            ;; 24:41d3 $e5
    push BC                                            ;; 24:41d4 $c5
    ld   B, $ff                                        ;; 24:41d5 $06 $ff
    ld   DE, wDFD2_Audio_SavedMusicRegs                                     ;; 24:41d7 $11 $d2 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 24:41da $fa $fe $df
    sla  A                                             ;; 24:41dd $cb $27
    sla  A                                             ;; 24:41df $cb $27
    add  A, E                                          ;; 24:41e1 $83
    ld   E, A                                          ;; 24:41e2 $5f
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 24:41e3 $fa $fe $df
    add  A, E                                          ;; 24:41e6 $83
    ld   E, A                                          ;; 24:41e7 $5f
    ld   HL, data_24_439e_ChannelSaveRegs                              ;; 24:41e8 $21 $9e $43
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 24:41eb $fa $fe $df
    sla  A                                             ;; 24:41ee $cb $27
    ld   C, A                                          ;; 24:41f0 $4f
    sla  A                                             ;; 24:41f1 $cb $27
    sla  A                                             ;; 24:41f3 $cb $27
    add  A, C                                          ;; 24:41f5 $81
    add  A, L                                          ;; 24:41f6 $85
    ld   L, A                                          ;; 24:41f7 $6f
    jr   NC, .jr_24_41fb                               ;; 24:41f8 $30 $01
    inc  H                                             ;; 24:41fa $24
.jr_24_41fb:
    ld   A, [HL+]                                      ;; 24:41fb $2a
    and  A, A                                          ;; 24:41fc $a7
    jr   Z, .jr_24_4206                                ;; 24:41fd $28 $07
    ld   C, A                                          ;; 24:41ff $4f
    ld   A, [DE]                                       ;; 24:4200 $1a
    ld   [BC], A                                       ;; 24:4201 $02
    inc  DE                                            ;; 24:4202 $13
    inc  HL                                            ;; 24:4203 $23
    jr   .jr_24_41fb                                   ;; 24:4204 $18 $f5
.jr_24_4206:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4206 $fa $c1 $df
    cp   A, $04                                        ;; 24:4209 $fe $04
    jr   NZ, .jr_24_421b                               ;; 24:420b $20 $0e
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 24:420d $21 $e6 $df
    ld   DE, _AUD3WAVERAM                                     ;; 24:4210 $11 $30 $ff
    ld   C, $10                                        ;; 24:4213 $0e $10
.jr_24_4215:
    ld   A, [HL+]                                      ;; 24:4215 $2a
    ld   [DE], A                                       ;; 24:4216 $12
    inc  DE                                            ;; 24:4217 $13
    dec  C                                             ;; 24:4218 $0d
    jr   NZ, .jr_24_4215                               ;; 24:4219 $20 $fa
.jr_24_421b:
    ld   HL, wDFF6_Audio_ChannelFreqShadow                                     ;; 24:421b $21 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 24:421e $fa $fe $df
    sla  A                                             ;; 24:4221 $cb $27
    add  A, L                                          ;; 24:4223 $85
    ld   L, A                                          ;; 24:4224 $6f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4225 $fa $c1 $df
    dec  A                                             ;; 24:4228 $3d
    ld   DE, data_24_43c6_ChannelFreqLoReg                              ;; 24:4229 $11 $c6 $43
    add  A, E                                          ;; 24:422c $83
    ld   E, A                                          ;; 24:422d $5f
    jr   NC, .jr_24_4231                               ;; 24:422e $30 $01
    inc  D                                             ;; 24:4230 $14
.jr_24_4231:
    ld   A, [DE]                                       ;; 24:4231 $1a
    ld   E, A                                          ;; 24:4232 $5f
    ld   D, $ff                                        ;; 24:4233 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4235 $fa $c1 $df
    cp   A, $08                                        ;; 24:4238 $fe $08
    jr   NZ, .jr_24_4244                               ;; 24:423a $20 $08
    inc  HL                                            ;; 24:423c $23
    ld   [DE], A                                       ;; 24:423d $12
    ldh  A, [rNR42]                                    ;; 24:423e $f0 $21
    ldh  [rNR42], A                                    ;; 24:4240 $e0 $21
    jr   .jr_24_424e                                   ;; 24:4242 $18 $0a
.jr_24_4244:
    ld   A, [HL+]                                      ;; 24:4244 $2a
    ld   [DE], A                                       ;; 24:4245 $12
    inc  DE                                            ;; 24:4246 $13
    ld   A, [DE]                                       ;; 24:4247 $1a
    and  A, $c0                                        ;; 24:4248 $e6 $c0
    ld   C, A                                          ;; 24:424a $4f
    ld   A, [HL]                                       ;; 24:424b $7e
    or   A, C                                          ;; 24:424c $b1
    ld   [DE], A                                       ;; 24:424d $12
.jr_24_424e:
    pop  BC                                            ;; 24:424e $c1
    pop  HL                                            ;; 24:424f $e1
    jp   .jp_24_4392                                   ;; 24:4250 $c3 $92 $43
.jp_24_4253:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 24:4253 $fa $c2 $df
    and  A, E                                          ;; 24:4256 $a3
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 24:4257 $ea $c2 $df
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:425a $fa $cf $df
    ld   E, A                                          ;; 24:425d $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:425e $fa $c1 $df
    and  A, E                                          ;; 24:4261 $a3
    jp   NZ, .jp_24_4392                               ;; 24:4262 $c2 $92 $43
.jp_24_4265:
    ldh  A, [rNR52]                                    ;; 24:4265 $f0 $26
    and  A, $8f                                        ;; 24:4267 $e6 $8f
    and  A, E                                          ;; 24:4269 $a3
    ldh  [rNR52], A                                    ;; 24:426a $e0 $26
    jp   .jp_24_4392                                   ;; 24:426c $c3 $92 $43
.jp_24_426f:
    cp   A, $fd                                        ;; 24:426f $fe $fd
    jr   NZ, .jr_24_4284                               ;; 24:4271 $20 $11
    push HL                                            ;; 24:4273 $e5
    ld   DE, _AUD3WAVERAM                                     ;; 24:4274 $11 $30 $ff
    ld   L, $10                                        ;; 24:4277 $2e $10
.jr_24_4279:
    ld   A, [BC]                                       ;; 24:4279 $0a
    inc  BC                                            ;; 24:427a $03
    ld   [DE], A                                       ;; 24:427b $12
    inc  DE                                            ;; 24:427c $13
    dec  L                                             ;; 24:427d $2d
    jr   NZ, .jr_24_4279                               ;; 24:427e $20 $f9
    pop  HL                                            ;; 24:4280 $e1
    jp   .jp_24_419c                                   ;; 24:4281 $c3 $9c $41
.jr_24_4284:
    cp   A, $a0                                        ;; 24:4284 $fe $a0
    jr   C, .jr_24_42bb                                ;; 24:4286 $38 $33
    cp   A, $c0                                        ;; 24:4288 $fe $c0
    jr   NC, .jr_24_429c                               ;; 24:428a $30 $10
    sub  A, $90                                        ;; 24:428c $d6 $90
    ld   E, A                                          ;; 24:428e $5f
    ld   D, $ff                                        ;; 24:428f $16 $ff
    ld   A, [DE]                                       ;; 24:4291 $1a
    ld   D, A                                          ;; 24:4292 $57
    ld   A, [BC]                                       ;; 24:4293 $0a
    and  A, D                                          ;; 24:4294 $a2
    ld   D, $ff                                        ;; 24:4295 $16 $ff
    ld   [DE], A                                       ;; 24:4297 $12
    inc  BC                                            ;; 24:4298 $03
    jp   .jp_24_419c                                   ;; 24:4299 $c3 $9c $41
.jr_24_429c:
    cp   A, $e0                                        ;; 24:429c $fe $e0
    jr   NC, .jr_24_42b0                               ;; 24:429e $30 $10
    sub  A, $b0                                        ;; 24:42a0 $d6 $b0
    ld   E, A                                          ;; 24:42a2 $5f
    ld   D, $ff                                        ;; 24:42a3 $16 $ff
    ld   A, [DE]                                       ;; 24:42a5 $1a
    ld   D, A                                          ;; 24:42a6 $57
    ld   A, [BC]                                       ;; 24:42a7 $0a
    or   A, D                                          ;; 24:42a8 $b2
    ld   D, $ff                                        ;; 24:42a9 $16 $ff
    ld   [DE], A                                       ;; 24:42ab $12
    inc  BC                                            ;; 24:42ac $03
    jp   .jp_24_419c                                   ;; 24:42ad $c3 $9c $41
.jr_24_42b0:
    sub  A, $d0                                        ;; 24:42b0 $d6 $d0
    ld   E, A                                          ;; 24:42b2 $5f
    ld   D, $ff                                        ;; 24:42b3 $16 $ff
    ld   A, [BC]                                       ;; 24:42b5 $0a
    inc  BC                                            ;; 24:42b6 $03
    ld   [DE], A                                       ;; 24:42b7 $12
    jp   .jp_24_419c                                   ;; 24:42b8 $c3 $9c $41
.jr_24_42bb:
    cp   A, $49                                        ;; 24:42bb $fe $49
    jp   Z, .jp_24_4369                                ;; 24:42bd $ca $69 $43
    sla  A                                             ;; 24:42c0 $cb $27
    ld   [wDFBF_Audio_NoteTableOffset], A                                    ;; 24:42c2 $ea $bf $df
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 24:42c8 $d6 $01
    ld   [wDFC0_Audio_ChannelIndexFromMask], A                                    ;; 24:42ca $ea $c0 $df
    ld   A, [wDFBF_Audio_NoteTableOffset]                                    ;; 24:42cd $fa $bf $df
    and  A, A                                          ;; 24:42d0 $a7
    jr   NZ, .jr_24_42ff                               ;; 24:42d1 $20 $2c
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 24:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 24:42d6 $fe $01
    jr   Z, .jr_24_42e4                                ;; 24:42d8 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:42da $fa $cf $df
    ld   E, A                                          ;; 24:42dd $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:42de $fa $c1 $df
    and  A, E                                          ;; 24:42e1 $a3
    jr   NZ, .jr_24_42ff                               ;; 24:42e2 $20 $1b
.jr_24_42e4:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:42e4 $fa $c1 $df
    cpl                                                ;; 24:42e7 $2f
    ld   E, A                                          ;; 24:42e8 $5f
    ldh  A, [rNR52]                                    ;; 24:42e9 $f0 $26
    and  A, $8f                                        ;; 24:42eb $e6 $8f
    and  A, E                                          ;; 24:42ed $a3
    ldh  [rNR52], A                                    ;; 24:42ee $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 24:42f3 $fe $04
    jr   NZ, .jr_24_42fa                               ;; 24:42f5 $20 $03
    xor  A, A                                          ;; 24:42f7 $af
    ldh  [rNR30], A                                    ;; 24:42f8 $e0 $1a
.jr_24_42fa:
    ld   A, [BC]                                       ;; 24:42fa $0a
    inc  BC                                            ;; 24:42fb $03
    jp   .jp_24_4392                                   ;; 24:42fc $c3 $92 $43
.jr_24_42ff:
    ld   DE, data_24_43ce_NoteFrequencies                              ;; 24:42ff $11 $ce $43
    add  A, E                                          ;; 24:4302 $83
    ld   E, A                                          ;; 24:4303 $5f
    jr   NC, .jr_24_4307                               ;; 24:4304 $30 $01
    inc  D                                             ;; 24:4306 $14
.jr_24_4307:
    ld   A, [DE]                                       ;; 24:4307 $1a
    ld   [wDFBD_Audio_FreqLo], A                                    ;; 24:4308 $ea $bd $df
    inc  DE                                            ;; 24:430b $13
    ld   A, [DE]                                       ;; 24:430c $1a
    ld   [wDFBE_Audio_FreqHi], A                                    ;; 24:430d $ea $be $df
    ld   DE, wDFF6_Audio_ChannelFreqShadow                                     ;; 24:4310 $11 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 24:4313 $fa $fe $df
    sla  A                                             ;; 24:4316 $cb $27
    add  A, E                                          ;; 24:4318 $83
    ld   E, A                                          ;; 24:4319 $5f
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 24:431a $fa $bd $df
    ld   [DE], A                                       ;; 24:431d $12
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 24:431e $fa $be $df
    or   A, $80                                        ;; 24:4321 $f6 $80
    ld   [DE], A                                       ;; 24:4323 $12
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 24:4324 $fa $d1 $df
    cp   A, $01                                        ;; 24:4327 $fe $01
    jr   Z, .jr_24_4335                                ;; 24:4329 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:432b $fa $cf $df
    ld   E, A                                          ;; 24:432e $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:432f $fa $c1 $df
    and  A, E                                          ;; 24:4332 $a3
    jr   NZ, .jr_24_4390                               ;; 24:4333 $20 $5b
.jr_24_4335:
    ld   A, [wDFC0_Audio_ChannelIndexFromMask]                                    ;; 24:4335 $fa $c0 $df
    ld   DE, data_24_43c6_ChannelFreqLoReg                              ;; 24:4338 $11 $c6 $43
    add  A, E                                          ;; 24:433b $83
    ld   E, A                                          ;; 24:433c $5f
    jr   NC, .jr_24_4340                               ;; 24:433d $30 $01
    inc  D                                             ;; 24:433f $14
.jr_24_4340:
    ld   A, [DE]                                       ;; 24:4340 $1a
    ld   E, A                                          ;; 24:4341 $5f
    ld   D, $ff                                        ;; 24:4342 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4344 $fa $c1 $df
    cp   A, $08                                        ;; 24:4347 $fe $08
    jr   NZ, .jr_24_4357                               ;; 24:4349 $20 $0c
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 24:434b $fa $be $df
    or   A, $80                                        ;; 24:434e $f6 $80
    ld   [DE], A                                       ;; 24:4350 $12
    ldh  A, [rNR42]                                    ;; 24:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 24:4353 $e0 $21
    jr   .jp_24_4369                                   ;; 24:4355 $18 $12
.jr_24_4357:
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 24:4357 $fa $bd $df
    ld   [DE], A                                       ;; 24:435a $12
    inc  DE                                            ;; 24:435b $13
    push DE                                            ;; 24:435c $d5
    ld   A, [DE]                                       ;; 24:435d $1a
    and  A, $c0                                        ;; 24:435e $e6 $c0
    ld   D, A                                          ;; 24:4360 $57
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 24:4361 $fa $be $df
    or   A, $80                                        ;; 24:4364 $f6 $80
    or   A, D                                          ;; 24:4366 $b2
    pop  DE                                            ;; 24:4367 $d1
    ld   [DE], A                                       ;; 24:4368 $12
.jp_24_4369:
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 24:4369 $fa $d1 $df
    cp   A, $02                                        ;; 24:436c $fe $02
    jr   NZ, .jr_24_4376                               ;; 24:436e $20 $06
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 24:4370 $fa $cf $df
    and  A, E                                          ;; 24:4373 $a3
    jr   NZ, .jr_24_4390                               ;; 24:4374 $20 $1a
.jr_24_4376:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4376 $fa $c1 $df
    ld   E, A                                          ;; 24:4379 $5f
    ldh  A, [rNR52]                                    ;; 24:437a $f0 $26
    and  A, $8f                                        ;; 24:437c $e6 $8f
    or   A, E                                          ;; 24:437e $b3
    ldh  [rNR52], A                                    ;; 24:437f $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 24:4381 $fa $c1 $df
    cp   A, $04                                        ;; 24:4384 $fe $04
    jr   NZ, .jr_24_4390                               ;; 24:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 24:4388 $f0 $1a
    and  A, $80                                        ;; 24:438a $e6 $80
    or   A, $80                                        ;; 24:438c $f6 $80
    ldh  [rNR30], A                                    ;; 24:438e $e0 $1a
.jr_24_4390:
    ld   A, [BC]                                       ;; 24:4390 $0a
    inc  BC                                            ;; 24:4391 $03
.jp_24_4392:
    ld   [HL], B                                       ;; 24:4392 $70
    dec  HL                                            ;; 24:4393 $2b
    ld   [HL], C                                       ;; 24:4394 $71
    ret                                                ;; 24:4395 $c9
    
    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 24:4396 ????????

data_24_439e_ChannelSaveRegs:
; Which registers to preserve when a sound effect takes a channel off the music, and
; with what mask. Five (register low byte, mask) pairs per channel, $00 terminating a
; channel's list early - so a channel is at most five registers and pulse 1, with its
; sweep, is the only one that needs four.
;
; The masks drop the bits that must not be replayed: the trigger and length-enable bits
; of NRx4 ($C7 keeps only the frequency high bits), the unused top bits of the length
; registers. Restoring a trigger bit would restart the note instead of resuming it
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 24:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 24:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 24:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 24:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 24:43be ????????

data_24_43c6_ChannelFreqLoReg:
; Channel bit -> that channel's frequency-low register, indexed by
; wDFC1_Audio_CurrentChannelBit minus 1. Only entries 0, 1, 3 and 7 are ever reached,
; which is why the table looks sparse: bits $01, $02, $04 and $08 give indices 0, 1, 3
; and 7. The noise channel's entry is rNR43, which is a polynomial counter rather than
; a frequency, and the interpreter special-cases it
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 24:43c6 ????????

data_24_43ce_NoteFrequencies:
; The pitch table: 73 little-endian 11-bit values, indexed by note number doubled.
; Entry 0 is silence and the rest climb to $07DF, the highest frequency the hardware
; will take. A sequence's note byte is an index into this - AUDIO_NOTE_LAST is the
; last real entry, and AUDIO_NOTE_SUSTAIN sits one past the end as a marker rather
; than a pitch
    db   $00, $00, $2c, $00, $9c, $00, $06, $01        ;; 24:43ce ????????
    db   $6b, $01, $c9, $01, $23, $02, $77, $02        ;; 24:43d6 ????????
    db   $c6, $02, $12, $03, $56, $03, $9b, $03        ;; 24:43de ????????
    db   $da, $03, $16, $04, $4e, $04, $83, $04        ;; 24:43e6 ????????
    db   $b5, $04, $e5, $04, $11, $05, $3b, $05        ;; 24:43ee ????????
    db   $63, $05, $89, $05, $ac, $05, $ce, $05        ;; 24:43f6 ????????
    db   $ed, $05, $0a, $06, $27, $06, $42, $06        ;; 24:43fe ????????
    db   $5b, $06, $72, $06, $89, $06, $9e, $06        ;; 24:4406 ????????
    db   $b2, $06, $c4, $06, $d6, $06, $e7, $06        ;; 24:440e ????????
    db   $f7, $06, $06, $07, $14, $07, $21, $07        ;; 24:4416 ????????
    db   $2d, $07, $39, $07, $44, $07, $4f, $07        ;; 24:441e ????????
    db   $59, $07, $62, $07, $6b, $07, $73, $07        ;; 24:4426 ????????
    db   $7b, $07, $83, $07, $8a, $07, $90, $07        ;; 24:442e ????????
    db   $97, $07, $9d, $07, $a2, $07, $a7, $07        ;; 24:4436 ????????
    db   $ac, $07, $b1, $07, $b6, $07, $ba, $07        ;; 24:443e ????????
    db   $be, $07, $c1, $07, $c4, $07, $c8, $07        ;; 24:4446 ????????
    db   $cb, $07, $ce, $07, $d1, $07, $d4, $07        ;; 24:444e ????????
    db   $d6, $07, $d9, $07, $db, $07, $dd, $07        ;; 24:4456 ????????
    db   $df, $07                                      ;; 24:445e ??

data_24_4460_TrackPointerTables:
; Where every track in this bank starts. Two lists of self-relative words - each entry
; is the distance from itself to its track - so the whole block can be assembled at any
; address and moved between banks without fixing anything up.
;
; The first word is not a track. It is the offset to the SFX list, which means the
; music list occupies everything between it and there. In this bank that gives 12 music
; tracks followed by 66 sound effects.
;
; Each target is a track header: a channel count, then a channel number, then that
; channel's sequence. The blocks below are labelled with the id that reaches them
    db   $86, $00, $84, $00, $9C, $00, $BE, $00, $DC, $00, $22, $01, $8E, $01, $A0, $01, $E0, $01, $F2, $01, $04, $02, $1E, $02, $36, $02, $54, $02
    db   $82, $02, $E4, $02, $2C, $03, $88, $03, $D8, $03, $8A, $05, $A2, $05, $02, $06, $34, $06, $66, $06, $7E, $06, $9A, $06, $B0, $06, $C2, $06
    db   $DC, $06, $F6, $06, $04, $07, $1E, $07, $7C, $07, $94, $07, $DC, $07, $F4, $07, $3C, $08, $84, $08, $A0, $08, $AE, $08, $DA, $08, $40, $09
    db   $62, $09, $AA, $09, $C2, $09, $06, $0A, $32, $0A, $88, $0A, $9E, $0A, $B6, $0A, $D0, $0A, $E8, $0A, $F4, $0A, $12, $0B, $40, $0B, $58, $0B
    db   $74, $0B, $A6, $0B, $C4, $0B, $DC, $0B, $F4, $0B, $0C, $0C, $26, $0C, $40, $0C, $42, $0C, $44, $0C, $46, $0C

audio_24_44e6:         ; music $00 MUSIC_KUNG_FU_THEATER
    INCBIN "data/audio/bank_24/audio_24_44e6.bin"
audio_24_4500:         ; music $01 MUSIC_CIRCUIT_CENTRAL
    INCBIN "data/audio/bank_24/audio_24_4500.bin"
audio_24_4524:         ; music $02 MUSIC_PREHISTORY_CHANNEL
    INCBIN "data/audio/bank_24/audio_24_4524.bin"
audio_24_4544:         ; music $03 MUSIC_REZOPOLIS
    INCBIN "data/audio/bank_24/audio_24_4544.bin"
audio_24_458c:         ; music $04 MUSIC_UNK_04
    INCBIN "data/audio/bank_24/audio_24_458c.bin"
audio_24_45fa:         ; music $05 MUSIC_SCREAM_TV
    INCBIN "data/audio/bank_24/audio_24_45fa.bin"
audio_24_460e:         ; music $06 MUSIC_TOON_TV
    INCBIN "data/audio/bank_24/audio_24_460e.bin"
audio_24_4650:         ; music $07 MUSIC_MEDIA_DIMENSION
    INCBIN "data/audio/bank_24/audio_24_45fa.bin"
audio_24_4664:         ; music $08
    INCBIN "data/audio/bank_24/audio_24_45fa.bin"
audio_24_4678:         ; music $09
    INCBIN "data/audio/bank_24/audio_24_4678.bin"
audio_24_4694:         ; music $0A
    INCBIN "data/audio/bank_24/audio_24_4694.bin"
audio_24_46ae:         ; music $0B
    INCBIN "data/audio/bank_24/audio_24_4524.bin"
audio_24_46ce:         ; music $0C
    INCBIN "data/audio/bank_24/audio_24_46ce.bin"
audio_24_46fe:         ; music $0D
    INCBIN "data/audio/bank_24/audio_24_46fe.bin"
audio_24_4762:         ; music $0E
    INCBIN "data/audio/bank_24/audio_24_4762.bin"
audio_24_47ac:         ; music $0F
    INCBIN "data/audio/bank_24/audio_24_47ac.bin"
audio_24_480a:         ; music $10
    INCBIN "data/audio/bank_24/audio_24_480a.bin"
audio_24_485c:         ; music $11
    INCBIN "data/audio/bank_24/audio_24_485c.bin"
audio_24_4a10:         ; music $12
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_4a2a:         ; music $13
    INCBIN "data/audio/bank_24/audio_24_4a2a.bin"
audio_24_4a8c:         ; music $14
    INCBIN "data/audio/bank_24/audio_24_4a8c.bin"
audio_24_4ac0:         ; music $15
    INCBIN "data/audio/bank_24/audio_24_4ac0.bin"
audio_24_4af4:         ; music $16
    INCBIN "data/audio/bank_24/audio_24_4af4.bin"
audio_24_4b0e:         ; music $17
    INCBIN "data/audio/bank_24/audio_24_4b0e.bin"
audio_24_4b2c:         ; music $18
    INCBIN "data/audio/bank_24/audio_24_4b2c.bin"
audio_24_4b44:         ; music $19
    INCBIN "data/audio/bank_24/audio_24_45fa.bin"
audio_24_4b58:         ; music $1A
    INCBIN "data/audio/bank_24/audio_24_4b58.bin"
audio_24_4b74:         ; music $1B
    INCBIN "data/audio/bank_24/audio_24_4b74.bin"
audio_24_4b90:         ; music $1C
    INCBIN "data/audio/bank_24/audio_24_4b90.bin"
audio_24_4ba0:         ; music $1D
    INCBIN "data/audio/bank_24/audio_24_4b58.bin"
audio_24_4bbc:         ; music $1E
    INCBIN "data/audio/bank_24/audio_24_4bbc.bin"
audio_24_4c1c:         ; music $1F
    INCBIN "data/audio/bank_24/audio_24_4c1c.bin"
audio_24_4c36:         ; music $20
    INCBIN "data/audio/bank_24/audio_24_4762.bin"
audio_24_4c80:         ; music $21
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_4c9a:         ; music $22
    INCBIN "data/audio/bank_24/audio_24_4762.bin"
audio_24_4ce4:         ; music $23
    INCBIN "data/audio/bank_24/audio_24_4762.bin"
audio_24_4d2e:         ; music $24
    INCBIN "data/audio/bank_24/audio_24_4d2e.bin"
audio_24_4d4c:         ; music $25
    INCBIN "data/audio/bank_24/audio_24_4d4c.bin"
audio_24_4d5c:         ; music $26
    INCBIN "data/audio/bank_24/audio_24_4d5c.bin"
audio_24_4d8a:         ; music $27
    INCBIN "data/audio/bank_24/audio_24_4d8a.bin"
audio_24_4df2:         ; music $28
    INCBIN "data/audio/bank_24/audio_24_4df2.bin"
audio_24_4e16:         ; music $29
    INCBIN "data/audio/bank_24/audio_24_4762.bin"
audio_24_4e60:         ; music $2A
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_4e7a:         ; music $2B
    INCBIN "data/audio/bank_24/audio_24_4e7a.bin"
audio_24_4ec0:         ; music $2C
    INCBIN "data/audio/bank_24/audio_24_4d5c.bin"
audio_24_4eee:         ; music $2D
    INCBIN "data/audio/bank_24/audio_24_4eee.bin"
audio_24_4f46:         ; music $2E
    INCBIN "data/audio/bank_24/audio_24_4f46.bin"
audio_24_4f5e:         ; music $2F
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_4f78:         ; music $30
    INCBIN "data/audio/bank_24/audio_24_4b58.bin"
audio_24_4f94:         ; music $31
    INCBIN "data/audio/bank_24/audio_24_4f94.bin"
audio_24_4fae:         ; music $32
    INCBIN "data/audio/bank_24/audio_24_4fae.bin"
audio_24_4fbc:         ; music $33
    INCBIN "data/audio/bank_24/audio_24_4fbc.bin"
audio_24_4fdc:         ; music $34
    INCBIN "data/audio/bank_24/audio_24_46ce.bin"
audio_24_500c:         ; music $35
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_5026:         ; music $36
    INCBIN "data/audio/bank_24/audio_24_5026.bin"
audio_24_5044:         ; music $37
    INCBIN "data/audio/bank_24/audio_24_5044.bin"
audio_24_5078:         ; music $38
    INCBIN "data/audio/bank_24/audio_24_4fbc.bin"
audio_24_5098:         ; music $39
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_50b2:         ; music $3A
    INCBIN "data/audio/bank_24/audio_24_4c1c.bin"
audio_24_50cc:         ; music $3B
    INCBIN "data/audio/bank_24/audio_24_4a10.bin"
audio_24_50e6:         ; music $3C
    INCBIN "data/audio/bank_24/audio_24_4b58.bin"
audio_24_5102:         ; music $3D
    INCBIN "data/audio/bank_24/audio_24_5102.bin"
audio_24_511e:         ; music $3E
    INCBIN "data/audio/bank_21/audio_21_783d.bin"
audio_24_5122:         ; music $3F
    INCBIN "data/audio/bank_21/audio_21_7841.bin"
audio_24_5126:         ; music $40
    INCBIN "data/audio/bank_21/audio_21_7845.bin"
audio_24_512a:         ; music $41
    INCBIN "data/audio/bank_21/audio_21_7849.bin"
