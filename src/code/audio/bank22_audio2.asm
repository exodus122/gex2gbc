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
; wDFE6_Audio_SavedWaveRam. data_22_439e_ChannelSaveRegs is the list of which
; registers are worth saving per channel.
;
; A SEQUENCE is a byte stream walked by Audio_RunSequence, which runs commands until
; it hits a note and then returns that note's duration - the caller stores it as the
; channel's countdown and comes back when it expires. So one call advances one channel
; by one note, however many register writes are in front of it. See the AUDIO_CMD_*
; and AUDIO_NOTE_* constants for the opcode map.
;
; THE TRACK TABLES at data_22_4460_TrackPointerTables are two lists of self-relative
; words. The first word of the block is the offset to the sfx list; the music list
; starts immediately after it.
;
; A SONG IS FOUR TRACKS, one per hardware channel, at four consecutive ids - which is
; why the ids come in groups whose headers read $01, $02, $03, $04.
; call_00_120c_SetupMusic in bank 0 starts all four in one go. So the 12 music ids
; here are 3 songs, and .data_00_1244_MusicList says which are which.
;
; The 66 sfx are one track each and are the same 66 effects in every bank that has
; them - the same effect id gives a different rendition depending on which bank is
; mapped in
; ==================================================================

SECTION "bank22", ROMX[$4000], BANK[$22]

call_22_4000_Audio_Init:
; Boot-time reset. Points wDFAE_AudioBankDataPointer at this bank's track tables,
; clears every channel mask, both sets of duration counters and rNR51, then wipes the
; 20-byte music register save area and the 16-byte wave RAM save area. It does not
; touch rNR52, so the APU is left however the caller had it
    ld   HL, data_22_4460_TrackPointerTables                              ;; 22:4000 $21 $60 $44
    ld   A, L                                          ;; 22:4003 $7d
    ld   [wDFAE_AudioBankDataPointer], A                                    ;; 22:4004 $ea $ae $df
    ld   A, H                                          ;; 22:4007 $7c
    ld   [wDFAF_AudioBankDataPointer], A                                    ;; 22:4008 $ea $af $df
    xor  A, A                                          ;; 22:400b $af
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 22:400c $ea $c2 $df
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 22:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 22:4012 $e0 $25
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 22:4014 $ea $b8 $df
    ld   [wDFB9_Audio_MusicTimerCh1], A                                    ;; 22:4017 $ea $b9 $df
    ld   [wDFBA_Audio_MusicTimerCh2], A                                    ;; 22:401a $ea $ba $df
    ld   [wDFBB_Audio_MusicTimerCh3], A                                    ;; 22:401d $ea $bb $df
    ld   [wDFBC_Audio_MusicTimerCh4], A                                    ;; 22:4020 $ea $bc $df
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 22:4023 $ea $cf $df
    ld   [wDFCB_Audio_SfxTimerCh1], A                                    ;; 22:4026 $ea $cb $df
    ld   [wDFCC_Audio_SfxTimerCh2], A                                    ;; 22:4029 $ea $cc $df
    ld   [wDFCD_Audio_SfxTimerCh3], A                                    ;; 22:402c $ea $cd $df
    ld   [wDFCE_Audio_SfxTimerCh4], A                                    ;; 22:402f $ea $ce $df
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 22:4032 $21 $d2 $df
    ld   C, $14                                        ;; 22:4035 $0e $14
    xor  A, A                                          ;; 22:4037 $af
jr_22_4038:
    ld   [HL+], A                                      ;; 22:4038 $22
    dec  C                                             ;; 22:4039 $0d
    jr   NZ, jr_22_4038                                ;; 22:403a $20 $fc
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 22:403c $21 $e6 $df
    ld   C, $10                                        ;; 22:403f $0e $10
    xor  A, A                                          ;; 22:4041 $af
.jr_22_4042:
    ld   [HL+], A                                      ;; 22:4042 $22
    dec  C                                             ;; 22:4043 $0d
    jr   NZ, .jr_22_4042                               ;; 22:4044 $20 $fc
    ret                                                ;; 22:4046 $c9

call_22_4047_Audio_PlaySfx:
; Start sound effect id A.
;
; Before anything is queued this snapshots the hardware state of the channels the
; effect is about to take: data_22_439e_ChannelSaveRegs lists five (register, mask)
; pairs per channel, and each register is read, masked and written into that channel's
; slot of wDFD2_Audio_SavedMusicRegs. The mask keeps only the bits worth restoring -
; the length counters and trigger bits are deliberately dropped.
;
; It then follows the first word of the track table block, which is the offset to the
; sfx list, and falls into the shared start-up path below with
; wDFD1_Audio_RequestKind = AUDIO_REQUEST_SFX
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 22:4047 $ea $d0 $df
    ld   A, $01                                        ;; 22:404a $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 22:404c $ea $d1 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 22:404f $fa $d0 $df
    sla  A                                             ;; 22:4052 $cb $27
    ld   E, A                                          ;; 22:4054 $5f
    sla  A                                             ;; 22:4055 $cb $27
    ld   C, A                                          ;; 22:4057 $4f
    sla  A                                             ;; 22:4058 $cb $27
    add  A, E                                          ;; 22:405a $83
    ld   DE, data_22_439e_ChannelSaveRegs                              ;; 22:405b $11 $9e $43
    add  A, E                                          ;; 22:405e $83
    ld   E, A                                          ;; 22:405f $5f
    jr   NC, .jr_22_4063                               ;; 22:4060 $30 $01
    inc  D                                             ;; 22:4062 $14
.jr_22_4063:
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 22:4063 $21 $d2 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 22:4066 $fa $d0 $df
    add  A, C                                          ;; 22:4069 $81
    add  A, L                                          ;; 22:406a $85
    ld   L, A                                          ;; 22:406b $6f
    jr   NC, .jr_22_406f                               ;; 22:406c $30 $01
    inc  H                                             ;; 22:406e $24
.jr_22_406f:
    ld   B, $ff                                        ;; 22:406f $06 $ff
.jr_22_4071:
    ld   A, [DE]                                       ;; 22:4071 $1a
    and  A, A                                          ;; 22:4072 $a7
    jr   Z, .jr_22_407f                                ;; 22:4073 $28 $0a
    inc  DE                                            ;; 22:4075 $13
    ld   C, A                                          ;; 22:4076 $4f
    ld   A, [BC]                                       ;; 22:4077 $0a
    ld   C, A                                          ;; 22:4078 $4f
    ld   A, [DE]                                       ;; 22:4079 $1a
    inc  DE                                            ;; 22:407a $13
    and  A, C                                          ;; 22:407b $a1
    ld   [HL+], A                                      ;; 22:407c $22
    jr   .jr_22_4071                                   ;; 22:407d $18 $f2
.jr_22_407f:
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 22:407f $fa $ae $df
    ld   E, A                                          ;; 22:4082 $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 22:4083 $fa $af $df
    ld   D, A                                          ;; 22:4086 $57
    ld   A, [DE]                                       ;; 22:4087 $1a
    add  A, E                                          ;; 22:4088 $83
    ld   L, A                                          ;; 22:4089 $6f
    inc  DE                                            ;; 22:408a $13
    ld   A, [DE]                                       ;; 22:408b $1a
    dec  DE                                            ;; 22:408c $1b
    adc  A, D                                          ;; 22:408d $8a
    ld   D, A                                          ;; 22:408e $57
    ld   E, L                                          ;; 22:408f $5d
    jr   jr_22_40a4_Audio_StartTrack                                    ;; 22:4090 $18 $12

call_22_4092_Audio_PlayMusic:
; Start music track id A. No state is saved, because music is what gets interrupted
; rather than what does the interrupting; the music list begins two bytes into the
; track table block, immediately after the word that locates the sfx list
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 22:4092 $ea $d0 $df
    ld   A, $02                                        ;; 22:4095 $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 22:4097 $ea $d1 $df
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 22:409a $fa $ae $df
    ld   E, A                                          ;; 22:409d $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 22:409e $fa $af $df
    ld   D, A                                          ;; 22:40a1 $57
    inc  DE                                            ;; 22:40a2 $13
    inc  DE                                            ;; 22:40a3 $13

jr_22_40a4_Audio_StartTrack:
; The half of track start-up both entry points share. DE arrives pointing at the right
; list, and the id selects a self-relative word from it - so a track pointer is stored
; as a distance rather than an address and the whole block is position independent.
;
; The first byte of a track is the hardware channel it wants, 1 to 4. The shift loop that
; follows turns that into a single-bit mask - the carry set by `scf` is rolled in on the
; first pass and zeroes on the rest, so channel N gives bit N-1, never a range. That bit
; is OR'd into whichever active-channel mask this request kind owns, and the request kind
; also selects which set of pointer and timer arrays gets written.
;
; A track therefore plays exactly one channel. Music gets four of them going at once by
; starting four tracks - see .data_00_1244_MusicList.
;
; The channel byte that follows then indexes those arrays, the sequence pointer is
; stored, and Audio_RunSequence is called once to prime the first note - its return
; value is that channel's initial countdown
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 22:40a4 $fa $d0 $df
    add  A, A                                          ;; 22:40a7 $87
    ld   L, A                                          ;; 22:40a8 $6f
    ld   A, D                                          ;; 22:40a9 $7a
    adc  A, $00                                        ;; 22:40aa $ce $00
    ld   D, A                                          ;; 22:40ac $57
    ld   A, E                                          ;; 22:40ad $7b
    add  A, L                                          ;; 22:40ae $85
    ld   E, A                                          ;; 22:40af $5f
    ld   A, D                                          ;; 22:40b0 $7a
    adc  A, $00                                        ;; 22:40b1 $ce $00
    ld   D, A                                          ;; 22:40b3 $57
    ld   A, [DE]                                       ;; 22:40b4 $1a
    add  A, E                                          ;; 22:40b5 $83
    ld   L, A                                          ;; 22:40b6 $6f
    inc  DE                                            ;; 22:40b7 $13
    ld   A, [DE]                                       ;; 22:40b8 $1a
    dec  DE                                            ;; 22:40b9 $1b
    adc  A, D                                          ;; 22:40ba $8a
    ld   D, A                                          ;; 22:40bb $57
    ld   E, L                                          ;; 22:40bc $5d
    ld   A, [DE]                                       ;; 22:40bd $1a
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 22:40be $ea $fe $df
    ld   L, A                                          ;; 22:40c1 $6f
    xor  A, A                                          ;; 22:40c2 $af
    scf                                                ;; 22:40c3 $37
.jr_22_40c4:
    rl   A                                             ;; 22:40c4 $cb $17
    dec  L                                             ;; 22:40c6 $2d
    jr   NZ, .jr_22_40c4                               ;; 22:40c7 $20 $fb
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 22:40c9 $ea $c1 $df
    ld   L, A                                          ;; 22:40cc $6f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 22:40cd $fa $d1 $df
    cp   A, $01                                        ;; 22:40d0 $fe $01
    jr   NZ, .jr_22_40e3                               ;; 22:40d2 $20 $0f
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:40d4 $fa $cf $df
    or   A, L                                          ;; 22:40d7 $b5
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 22:40d8 $ea $cf $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 22:40db $21 $c3 $df
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 22:40de $01 $cb $df
    jr   .jr_22_40f0                                   ;; 22:40e1 $18 $0d
.jr_22_40e3:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 22:40e3 $fa $c2 $df
    or   A, L                                          ;; 22:40e6 $b5
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 22:40e7 $ea $c2 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 22:40ea $21 $b0 $df
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 22:40ed $01 $b9 $df
.jr_22_40f0:
    ld   A, [DE]                                       ;; 22:40f0 $1a
    dec  A                                             ;; 22:40f1 $3d
    sla  A                                             ;; 22:40f2 $cb $27
    add  A, L                                          ;; 22:40f4 $85
    ld   L, A                                          ;; 22:40f5 $6f
    jr   NC, .jr_22_40f9                               ;; 22:40f6 $30 $01
    inc  H                                             ;; 22:40f8 $24
.jr_22_40f9:
    ld   A, [DE]                                       ;; 22:40f9 $1a
    dec  A                                             ;; 22:40fa $3d
    add  A, C                                          ;; 22:40fb $81
    ld   C, A                                          ;; 22:40fc $4f
    jr   NC, .jr_22_4100                               ;; 22:40fd $30 $01
    inc  B                                             ;; 22:40ff $04
.jr_22_4100:
    inc  DE                                            ;; 22:4100 $13
    ld   [HL], E                                       ;; 22:4101 $73
    inc  HL                                            ;; 22:4102 $23
    ld   [HL], D                                       ;; 22:4103 $72
    dec  HL                                            ;; 22:4104 $2b
    push BC                                            ;; 22:4105 $c5
    call call_22_4199_Audio_RunSequence                                  ;; 22:4106 $cd $99 $41
    pop  BC                                            ;; 22:4109 $c1
    ld   [BC], A                                       ;; 22:410a $02
    ret                                                ;; 22:410b $c9

call_22_410c_Audio_Update:
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
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 22:410c $01 $b9 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 22:410f $21 $b0 $df
    ld   A, $01                                        ;; 22:4112 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 22:4114 $ea $c1 $df
    ld   A, $00                                        ;; 22:4117 $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 22:4119 $ea $b8 $df
    ld   A, $02                                        ;; 22:411c $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 22:411e $ea $d1 $df
.jp_22_4121:
    push BC                                            ;; 22:4121 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4122 $fa $c1 $df
    ld   D, A                                          ;; 22:4125 $57
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 22:4126 $fa $c2 $df
    and  A, D                                          ;; 22:4129 $a2
    jr   Z, .jr_22_4139                                ;; 22:412a $28 $0d
    ld   A, [BC]                                       ;; 22:412c $0a
    dec  A                                             ;; 22:412d $3d
    jr   NZ, .jr_22_4139                               ;; 22:412e $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 22:4130 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 22:4133 $ea $fe $df
    call call_22_4199_Audio_RunSequence                                  ;; 22:4136 $cd $99 $41
.jr_22_4139:
    pop  BC                                            ;; 22:4139 $c1
    ld   [BC], A                                       ;; 22:413a $02
    inc  BC                                            ;; 22:413b $03
    inc  HL                                            ;; 22:413c $23
    inc  HL                                            ;; 22:413d $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:413e $fa $c1 $df
    sla  A                                             ;; 22:4141 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 22:4143 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 22:4146 $fa $b8 $df
    inc  A                                             ;; 22:4149 $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 22:414a $ea $b8 $df
    cp   A, $04                                        ;; 22:414d $fe $04
    jp   NZ, .jp_22_4121                               ;; 22:414f $c2 $21 $41
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 22:4152 $01 $cb $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 22:4155 $21 $c3 $df
    ld   A, $01                                        ;; 22:4158 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 22:415a $ea $c1 $df
    ld   A, $00                                        ;; 22:415d $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 22:415f $ea $b8 $df
    ld   A, $01                                        ;; 22:4162 $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 22:4164 $ea $d1 $df
.jp_22_4167:
    push BC                                            ;; 22:4167 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4168 $fa $c1 $df
    ld   D, A                                          ;; 22:416b $57
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:416c $fa $cf $df
    and  A, D                                          ;; 22:416f $a2
    jr   Z, .jr_22_417f                                ;; 22:4170 $28 $0d
    ld   A, [BC]                                       ;; 22:4172 $0a
    dec  A                                             ;; 22:4173 $3d
    jr   NZ, .jr_22_417f                               ;; 22:4174 $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 22:4176 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 22:4179 $ea $fe $df
    call call_22_4199_Audio_RunSequence                                  ;; 22:417c $cd $99 $41
.jr_22_417f:
    pop  BC                                            ;; 22:417f $c1
    ld   [BC], A                                       ;; 22:4180 $02
    inc  BC                                            ;; 22:4181 $03
    inc  HL                                            ;; 22:4182 $23
    inc  HL                                            ;; 22:4183 $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4184 $fa $c1 $df
    sla  A                                             ;; 22:4187 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 22:4189 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 22:418c $fa $b8 $df
    inc  A                                             ;; 22:418f $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 22:4190 $ea $b8 $df
    cp   A, $04                                        ;; 22:4193 $fe $04
    jp   NZ, .jp_22_4167                               ;; 22:4195 $c2 $67 $41
    ret                                                ;; 22:4198 $c9

call_22_4199_Audio_RunSequence:
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
; A note indexes data_22_43ce_NoteFrequencies for an 11-bit frequency, writes it to the
; channel's frequency registers with the trigger bit set, and enables the channel in
; rNR52. AUDIO_NOTE_REST silences the channel instead, and AUDIO_NOTE_SUSTAIN
; retriggers it without touching the pitch. The byte after the note is its duration.
;
; While an sfx owns a channel the music's note writes are computed and stored to
; wDFF6_Audio_ChannelFreqShadow but kept out of the hardware registers, which is how
; the music stays in time underneath and reappears in the right place
    ld   C, [HL]                                       ;; 22:4199 $4e
    inc  HL                                            ;; 22:419a $23
    ld   B, [HL]                                       ;; 22:419b $46
.jp_22_419c:
    ld   A, [BC]                                       ;; 22:419c $0a
    cp   A, $fe                                        ;; 22:419d $fe $fe
    jr   NZ, .jr_22_41ae                               ;; 22:419f $20 $0d
    inc  BC                                            ;; 22:41a1 $03
    ld   A, [BC]                                       ;; 22:41a2 $0a
    ld   E, A                                          ;; 22:41a3 $5f
    inc  BC                                            ;; 22:41a4 $03
    ld   A, [BC]                                       ;; 22:41a5 $0a
    ld   D, A                                          ;; 22:41a6 $57
    ld   A, C                                          ;; 22:41a7 $79
    sub  A, E                                          ;; 22:41a8 $93
    ld   C, A                                          ;; 22:41a9 $4f
    ld   A, B                                          ;; 22:41aa $78
    sbc  A, D                                          ;; 22:41ab $9a
    ld   B, A                                          ;; 22:41ac $47
    ld   A, [BC]                                       ;; 22:41ad $0a
.jr_22_41ae:
    inc  BC                                            ;; 22:41ae $03
    cp   A, $ff                                        ;; 22:41af $fe $ff
    jp   NZ, .jp_22_426f                               ;; 22:41b1 $c2 $6f $42
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:41b4 $fa $c1 $df
    cpl                                                ;; 22:41b7 $2f
    ld   E, A                                          ;; 22:41b8 $5f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 22:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 22:41bc $fe $01
    jp   NZ, .jp_22_4253                               ;; 22:41be $c2 $53 $42
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:41c1 $fa $cf $df
    and  A, E                                          ;; 22:41c4 $a3
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 22:41c5 $ea $cf $df
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 22:41c8 $fa $c2 $df
    ld   E, A                                          ;; 22:41cb $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:41cc $fa $c1 $df
    and  A, E                                          ;; 22:41cf $a3
    jp   Z, .jp_22_4265                                ;; 22:41d0 $ca $65 $42
    push HL                                            ;; 22:41d3 $e5
    push BC                                            ;; 22:41d4 $c5
    ld   B, $ff                                        ;; 22:41d5 $06 $ff
    ld   DE, wDFD2_Audio_SavedMusicRegs                                     ;; 22:41d7 $11 $d2 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 22:41da $fa $fe $df
    sla  A                                             ;; 22:41dd $cb $27
    sla  A                                             ;; 22:41df $cb $27
    add  A, E                                          ;; 22:41e1 $83
    ld   E, A                                          ;; 22:41e2 $5f
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 22:41e3 $fa $fe $df
    add  A, E                                          ;; 22:41e6 $83
    ld   E, A                                          ;; 22:41e7 $5f
    ld   HL, data_22_439e_ChannelSaveRegs                              ;; 22:41e8 $21 $9e $43
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 22:41eb $fa $fe $df
    sla  A                                             ;; 22:41ee $cb $27
    ld   C, A                                          ;; 22:41f0 $4f
    sla  A                                             ;; 22:41f1 $cb $27
    sla  A                                             ;; 22:41f3 $cb $27
    add  A, C                                          ;; 22:41f5 $81
    add  A, L                                          ;; 22:41f6 $85
    ld   L, A                                          ;; 22:41f7 $6f
    jr   NC, .jr_22_41fb                               ;; 22:41f8 $30 $01
    inc  H                                             ;; 22:41fa $24
.jr_22_41fb:
    ld   A, [HL+]                                      ;; 22:41fb $2a
    and  A, A                                          ;; 22:41fc $a7
    jr   Z, .jr_22_4206                                ;; 22:41fd $28 $07
    ld   C, A                                          ;; 22:41ff $4f
    ld   A, [DE]                                       ;; 22:4200 $1a
    ld   [BC], A                                       ;; 22:4201 $02
    inc  DE                                            ;; 22:4202 $13
    inc  HL                                            ;; 22:4203 $23
    jr   .jr_22_41fb                                   ;; 22:4204 $18 $f5
.jr_22_4206:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4206 $fa $c1 $df
    cp   A, $04                                        ;; 22:4209 $fe $04
    jr   NZ, .jr_22_421b                               ;; 22:420b $20 $0e
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 22:420d $21 $e6 $df
    ld   DE, _AUD3WAVERAM                                     ;; 22:4210 $11 $30 $ff
    ld   C, $10                                        ;; 22:4213 $0e $10
.jr_22_4215:
    ld   A, [HL+]                                      ;; 22:4215 $2a
    ld   [DE], A                                       ;; 22:4216 $12
    inc  DE                                            ;; 22:4217 $13
    dec  C                                             ;; 22:4218 $0d
    jr   NZ, .jr_22_4215                               ;; 22:4219 $20 $fa
.jr_22_421b:
    ld   HL, wDFF6_Audio_ChannelFreqShadow                                     ;; 22:421b $21 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 22:421e $fa $fe $df
    sla  A                                             ;; 22:4221 $cb $27
    add  A, L                                          ;; 22:4223 $85
    ld   L, A                                          ;; 22:4224 $6f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4225 $fa $c1 $df
    dec  A                                             ;; 22:4228 $3d
    ld   DE, data_22_43c6_ChannelFreqLoReg                              ;; 22:4229 $11 $c6 $43
    add  A, E                                          ;; 22:422c $83
    ld   E, A                                          ;; 22:422d $5f
    jr   NC, .jr_22_4231                               ;; 22:422e $30 $01
    inc  D                                             ;; 22:4230 $14
.jr_22_4231:
    ld   A, [DE]                                       ;; 22:4231 $1a
    ld   E, A                                          ;; 22:4232 $5f
    ld   D, $ff                                        ;; 22:4233 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4235 $fa $c1 $df
    cp   A, $08                                        ;; 22:4238 $fe $08
    jr   NZ, .jr_22_4244                               ;; 22:423a $20 $08
    inc  HL                                            ;; 22:423c $23
    ld   [DE], A                                       ;; 22:423d $12
    ldh  A, [rNR42]                                    ;; 22:423e $f0 $21
    ldh  [rNR42], A                                    ;; 22:4240 $e0 $21
    jr   .jr_22_424e                                   ;; 22:4242 $18 $0a
.jr_22_4244:
    ld   A, [HL+]                                      ;; 22:4244 $2a
    ld   [DE], A                                       ;; 22:4245 $12
    inc  DE                                            ;; 22:4246 $13
    ld   A, [DE]                                       ;; 22:4247 $1a
    and  A, $c0                                        ;; 22:4248 $e6 $c0
    ld   C, A                                          ;; 22:424a $4f
    ld   A, [HL]                                       ;; 22:424b $7e
    or   A, C                                          ;; 22:424c $b1
    ld   [DE], A                                       ;; 22:424d $12
.jr_22_424e:
    pop  BC                                            ;; 22:424e $c1
    pop  HL                                            ;; 22:424f $e1
    jp   .jp_22_4392                                   ;; 22:4250 $c3 $92 $43
.jp_22_4253:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 22:4253 $fa $c2 $df
    and  A, E                                          ;; 22:4256 $a3
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 22:4257 $ea $c2 $df
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:425a $fa $cf $df
    ld   E, A                                          ;; 22:425d $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:425e $fa $c1 $df
    and  A, E                                          ;; 22:4261 $a3
    jp   NZ, .jp_22_4392                               ;; 22:4262 $c2 $92 $43
.jp_22_4265:
    ldh  A, [rNR52]                                    ;; 22:4265 $f0 $26
    and  A, $8f                                        ;; 22:4267 $e6 $8f
    and  A, E                                          ;; 22:4269 $a3
    ldh  [rNR52], A                                    ;; 22:426a $e0 $26
    jp   .jp_22_4392                                   ;; 22:426c $c3 $92 $43
.jp_22_426f:
    cp   A, $fd                                        ;; 22:426f $fe $fd
    jr   NZ, .jr_22_4284                               ;; 22:4271 $20 $11
    push HL                                            ;; 22:4273 $e5
    ld   DE, _AUD3WAVERAM                                     ;; 22:4274 $11 $30 $ff
    ld   L, $10                                        ;; 22:4277 $2e $10
.jr_22_4279:
    ld   A, [BC]                                       ;; 22:4279 $0a
    inc  BC                                            ;; 22:427a $03
    ld   [DE], A                                       ;; 22:427b $12
    inc  DE                                            ;; 22:427c $13
    dec  L                                             ;; 22:427d $2d
    jr   NZ, .jr_22_4279                               ;; 22:427e $20 $f9
    pop  HL                                            ;; 22:4280 $e1
    jp   .jp_22_419c                                   ;; 22:4281 $c3 $9c $41
.jr_22_4284:
    cp   A, $a0                                        ;; 22:4284 $fe $a0
    jr   C, .jr_22_42bb                                ;; 22:4286 $38 $33
    cp   A, $c0                                        ;; 22:4288 $fe $c0
    jr   NC, .jr_22_429c                               ;; 22:428a $30 $10
    sub  A, $90                                        ;; 22:428c $d6 $90
    ld   E, A                                          ;; 22:428e $5f
    ld   D, $ff                                        ;; 22:428f $16 $ff
    ld   A, [DE]                                       ;; 22:4291 $1a
    ld   D, A                                          ;; 22:4292 $57
    ld   A, [BC]                                       ;; 22:4293 $0a
    and  A, D                                          ;; 22:4294 $a2
    ld   D, $ff                                        ;; 22:4295 $16 $ff
    ld   [DE], A                                       ;; 22:4297 $12
    inc  BC                                            ;; 22:4298 $03
    jp   .jp_22_419c                                   ;; 22:4299 $c3 $9c $41
.jr_22_429c:
    cp   A, $e0                                        ;; 22:429c $fe $e0
    jr   NC, .jr_22_42b0                               ;; 22:429e $30 $10
    sub  A, $b0                                        ;; 22:42a0 $d6 $b0
    ld   E, A                                          ;; 22:42a2 $5f
    ld   D, $ff                                        ;; 22:42a3 $16 $ff
    ld   A, [DE]                                       ;; 22:42a5 $1a
    ld   D, A                                          ;; 22:42a6 $57
    ld   A, [BC]                                       ;; 22:42a7 $0a
    or   A, D                                          ;; 22:42a8 $b2
    ld   D, $ff                                        ;; 22:42a9 $16 $ff
    ld   [DE], A                                       ;; 22:42ab $12
    inc  BC                                            ;; 22:42ac $03
    jp   .jp_22_419c                                   ;; 22:42ad $c3 $9c $41
.jr_22_42b0:
    sub  A, $d0                                        ;; 22:42b0 $d6 $d0
    ld   E, A                                          ;; 22:42b2 $5f
    ld   D, $ff                                        ;; 22:42b3 $16 $ff
    ld   A, [BC]                                       ;; 22:42b5 $0a
    inc  BC                                            ;; 22:42b6 $03
    ld   [DE], A                                       ;; 22:42b7 $12
    jp   .jp_22_419c                                   ;; 22:42b8 $c3 $9c $41
.jr_22_42bb:
    cp   A, $49                                        ;; 22:42bb $fe $49
    jp   Z, .jp_22_4369                                ;; 22:42bd $ca $69 $43
    sla  A                                             ;; 22:42c0 $cb $27
    ld   [wDFBF_Audio_NoteTableOffset], A                                    ;; 22:42c2 $ea $bf $df
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 22:42c8 $d6 $01
    ld   [wDFC0_Audio_ChannelIndexFromMask], A                                    ;; 22:42ca $ea $c0 $df
    ld   A, [wDFBF_Audio_NoteTableOffset]                                    ;; 22:42cd $fa $bf $df
    and  A, A                                          ;; 22:42d0 $a7
    jr   NZ, .jr_22_42ff                               ;; 22:42d1 $20 $2c
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 22:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 22:42d6 $fe $01
    jr   Z, .jr_22_42e4                                ;; 22:42d8 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:42da $fa $cf $df
    ld   E, A                                          ;; 22:42dd $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:42de $fa $c1 $df
    and  A, E                                          ;; 22:42e1 $a3
    jr   NZ, .jr_22_42ff                               ;; 22:42e2 $20 $1b
.jr_22_42e4:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:42e4 $fa $c1 $df
    cpl                                                ;; 22:42e7 $2f
    ld   E, A                                          ;; 22:42e8 $5f
    ldh  A, [rNR52]                                    ;; 22:42e9 $f0 $26
    and  A, $8f                                        ;; 22:42eb $e6 $8f
    and  A, E                                          ;; 22:42ed $a3
    ldh  [rNR52], A                                    ;; 22:42ee $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 22:42f3 $fe $04
    jr   NZ, .jr_22_42fa                               ;; 22:42f5 $20 $03
    xor  A, A                                          ;; 22:42f7 $af
    ldh  [rNR30], A                                    ;; 22:42f8 $e0 $1a
.jr_22_42fa:
    ld   A, [BC]                                       ;; 22:42fa $0a
    inc  BC                                            ;; 22:42fb $03
    jp   .jp_22_4392                                   ;; 22:42fc $c3 $92 $43
.jr_22_42ff:
    ld   DE, data_22_43ce_NoteFrequencies                              ;; 22:42ff $11 $ce $43
    add  A, E                                          ;; 22:4302 $83
    ld   E, A                                          ;; 22:4303 $5f
    jr   NC, .jr_22_4307                               ;; 22:4304 $30 $01
    inc  D                                             ;; 22:4306 $14
.jr_22_4307:
    ld   A, [DE]                                       ;; 22:4307 $1a
    ld   [wDFBD_Audio_FreqLo], A                                    ;; 22:4308 $ea $bd $df
    inc  DE                                            ;; 22:430b $13
    ld   A, [DE]                                       ;; 22:430c $1a
    ld   [wDFBE_Audio_FreqHi], A                                    ;; 22:430d $ea $be $df
    ld   DE, wDFF6_Audio_ChannelFreqShadow                                     ;; 22:4310 $11 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 22:4313 $fa $fe $df
    sla  A                                             ;; 22:4316 $cb $27
    add  A, E                                          ;; 22:4318 $83
    ld   E, A                                          ;; 22:4319 $5f
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 22:431a $fa $bd $df
    ld   [DE], A                                       ;; 22:431d $12
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 22:431e $fa $be $df
    or   A, $80                                        ;; 22:4321 $f6 $80
    ld   [DE], A                                       ;; 22:4323 $12
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 22:4324 $fa $d1 $df
    cp   A, $01                                        ;; 22:4327 $fe $01
    jr   Z, .jr_22_4335                                ;; 22:4329 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:432b $fa $cf $df
    ld   E, A                                          ;; 22:432e $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:432f $fa $c1 $df
    and  A, E                                          ;; 22:4332 $a3
    jr   NZ, .jr_22_4390                               ;; 22:4333 $20 $5b
.jr_22_4335:
    ld   A, [wDFC0_Audio_ChannelIndexFromMask]                                    ;; 22:4335 $fa $c0 $df
    ld   DE, data_22_43c6_ChannelFreqLoReg                              ;; 22:4338 $11 $c6 $43
    add  A, E                                          ;; 22:433b $83
    ld   E, A                                          ;; 22:433c $5f
    jr   NC, .jr_22_4340                               ;; 22:433d $30 $01
    inc  D                                             ;; 22:433f $14
.jr_22_4340:
    ld   A, [DE]                                       ;; 22:4340 $1a
    ld   E, A                                          ;; 22:4341 $5f
    ld   D, $ff                                        ;; 22:4342 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4344 $fa $c1 $df
    cp   A, $08                                        ;; 22:4347 $fe $08
    jr   NZ, .jr_22_4357                               ;; 22:4349 $20 $0c
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 22:434b $fa $be $df
    or   A, $80                                        ;; 22:434e $f6 $80
    ld   [DE], A                                       ;; 22:4350 $12
    ldh  A, [rNR42]                                    ;; 22:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 22:4353 $e0 $21
    jr   .jp_22_4369                                   ;; 22:4355 $18 $12
.jr_22_4357:
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 22:4357 $fa $bd $df
    ld   [DE], A                                       ;; 22:435a $12
    inc  DE                                            ;; 22:435b $13
    push DE                                            ;; 22:435c $d5
    ld   A, [DE]                                       ;; 22:435d $1a
    and  A, $c0                                        ;; 22:435e $e6 $c0
    ld   D, A                                          ;; 22:4360 $57
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 22:4361 $fa $be $df
    or   A, $80                                        ;; 22:4364 $f6 $80
    or   A, D                                          ;; 22:4366 $b2
    pop  DE                                            ;; 22:4367 $d1
    ld   [DE], A                                       ;; 22:4368 $12
.jp_22_4369:
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 22:4369 $fa $d1 $df
    cp   A, $02                                        ;; 22:436c $fe $02
    jr   NZ, .jr_22_4376                               ;; 22:436e $20 $06
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 22:4370 $fa $cf $df
    and  A, E                                          ;; 22:4373 $a3
    jr   NZ, .jr_22_4390                               ;; 22:4374 $20 $1a
.jr_22_4376:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4376 $fa $c1 $df
    ld   E, A                                          ;; 22:4379 $5f
    ldh  A, [rNR52]                                    ;; 22:437a $f0 $26
    and  A, $8f                                        ;; 22:437c $e6 $8f
    or   A, E                                          ;; 22:437e $b3
    ldh  [rNR52], A                                    ;; 22:437f $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 22:4381 $fa $c1 $df
    cp   A, $04                                        ;; 22:4384 $fe $04
    jr   NZ, .jr_22_4390                               ;; 22:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 22:4388 $f0 $1a
    and  A, $80                                        ;; 22:438a $e6 $80
    or   A, $80                                        ;; 22:438c $f6 $80
    ldh  [rNR30], A                                    ;; 22:438e $e0 $1a
.jr_22_4390:
    ld   A, [BC]                                       ;; 22:4390 $0a
    inc  BC                                            ;; 22:4391 $03
.jp_22_4392:
    ld   [HL], B                                       ;; 22:4392 $70
    dec  HL                                            ;; 22:4393 $2b
    ld   [HL], C                                       ;; 22:4394 $71
    ret                                                ;; 22:4395 $c9
    
    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 22:4396 ????????

data_22_439e_ChannelSaveRegs:
; Which registers to preserve when a sound effect takes a channel off the music, and
; with what mask. Five (register low byte, mask) pairs per channel, $00 terminating a
; channel's list early - so a channel is at most five registers and pulse 1, with its
; sweep, is the only one that needs four.
;
; The masks drop the bits that must not be replayed: the trigger and length-enable bits
; of NRx4 ($C7 keeps only the frequency high bits), the unused top bits of the length
; registers. Restoring a trigger bit would restart the note instead of resuming it
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 22:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 22:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 22:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 22:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 22:43be ????????

data_22_43c6_ChannelFreqLoReg:
; Channel bit -> that channel's frequency-low register, indexed by
; wDFC1_Audio_CurrentChannelBit minus 1. Only entries 0, 1, 3 and 7 are ever reached,
; which is why the table looks sparse: bits $01, $02, $04 and $08 give indices 0, 1, 3
; and 7. The noise channel's entry is rNR43, which is a polynomial counter rather than
; a frequency, and the interpreter special-cases it
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 22:43c6 ????????

data_22_43ce_NoteFrequencies:
; The pitch table: 73 little-endian 11-bit values, indexed by note number doubled.
; Entry 0 is silence and the rest climb to $07DF, the highest frequency the hardware
; will take. A sequence's note byte is an index into this - AUDIO_NOTE_LAST is the
; last real entry, and AUDIO_NOTE_SUSTAIN sits one past the end as a marker rather
; than a pitch
    db   $00, $00, $2c, $00, $9c, $00, $06, $01        ;; 22:43ce ????????
    db   $6b, $01, $c9, $01, $23, $02, $77, $02        ;; 22:43d6 ????????
    db   $c6, $02, $12, $03, $56, $03, $9b, $03        ;; 22:43de ????????
    db   $da, $03, $16, $04, $4e, $04, $83, $04        ;; 22:43e6 ????????
    db   $b5, $04, $e5, $04, $11, $05, $3b, $05        ;; 22:43ee ????????
    db   $63, $05, $89, $05, $ac, $05, $ce, $05        ;; 22:43f6 ????????
    db   $ed, $05, $0a, $06, $27, $06, $42, $06        ;; 22:43fe ????????
    db   $5b, $06, $72, $06, $89, $06, $9e, $06        ;; 22:4406 ????????
    db   $b2, $06, $c4, $06, $d6, $06, $e7, $06        ;; 22:440e ????????
    db   $f7, $06, $06, $07, $14, $07, $21, $07        ;; 22:4416 ????????
    db   $2d, $07, $39, $07, $44, $07, $4f, $07        ;; 22:441e ????????
    db   $59, $07, $62, $07, $6b, $07, $73, $07        ;; 22:4426 ????????
    db   $7b, $07, $83, $07, $8a, $07, $90, $07        ;; 22:442e ????????
    db   $97, $07, $9d, $07, $a2, $07, $a7, $07        ;; 22:4436 ????????
    db   $ac, $07, $b1, $07, $b6, $07, $ba, $07        ;; 22:443e ????????
    db   $be, $07, $c1, $07, $c4, $07, $c8, $07        ;; 22:4446 ????????
    db   $cb, $07, $ce, $07, $d1, $07, $d4, $07        ;; 22:444e ????????
    db   $d6, $07, $d9, $07, $db, $07, $dd, $07        ;; 22:4456 ????????
    db   $df, $07                                      ;; 22:445e ??

data_22_4460_TrackPointerTables:
; Where every track in this bank starts. Two lists of self-relative words - each entry
; is the distance from itself to its own target - so the whole block is position
; independent and could be assembled anywhere.
;
; The first word is not a track: it locates the sfx list, and the music list fills
; everything between that word and there.
;
; 12 music tracks - 3 songs of four - followed by 66 sound effects. The sfx are
; byte-identical to bank $21's in every bank that has them, so the INCBINs below
; point at one shared set of files rather than a copy per bank
    dw   .sfx_list - @                             ; where the sfx half starts

.music_list:
    dw   audio_22_44fe_Music_ScreamTv_Ch1 - @        ; MUSIC_SCREAM_TV ch1
    dw   audio_22_49d6_Music_ScreamTv_Ch2 - @        ; MUSIC_SCREAM_TV ch2
    dw   audio_22_4c68_Music_ScreamTv_Ch3 - @        ; MUSIC_SCREAM_TV ch3
    dw   audio_22_4f9b_Music_ScreamTv_Ch4 - @        ; MUSIC_SCREAM_TV ch4
    dw   audio_22_4fb1_Music_Unk04_Ch1 - @           ; MUSIC_UNK_04 ch1
    dw   audio_22_5117_Music_Unk04_Ch2 - @           ; MUSIC_UNK_04 ch2
    dw   audio_22_58a5_Music_Unk04_Ch3 - @           ; MUSIC_UNK_04 ch3
    dw   audio_22_5aa4_Music_Unk04_Ch4 - @           ; MUSIC_UNK_04 ch4
    dw   audio_22_5aa6_Music_Rezopolis_Ch1 - @       ; MUSIC_REZOPOLIS ch1
    dw   audio_22_5bd0_Music_Rezopolis_Ch2 - @       ; MUSIC_REZOPOLIS ch2
    dw   audio_22_5ea4_Music_Rezopolis_Ch3 - @       ; MUSIC_REZOPOLIS ch3
    dw   audio_22_60fd_Music_Rezopolis_Ch4 - @       ; MUSIC_REZOPOLIS ch4

.sfx_list:
    dw   audio_22_6149_Sfx_Empty - @                 ; SFX_EMPTY (sfx $00)
    dw   audio_22_615d_Sfx_01 - @                    ; SFX_01 (sfx $01)
    dw   audio_22_617b_Sfx_TvSmash - @               ; SFX_TV_SMASH (sfx $02)
    dw   audio_22_61a5_Sfx_SilverRemote - @          ; SFX_SILVER_REMOTE (sfx $03)
    dw   audio_22_61e7_Sfx_GoldRemote - @            ; SFX_GOLD_REMOTE (sfx $04)
    dw   audio_22_624f_Sfx_05 - @                    ; SFX_05 (sfx $05)
    dw   audio_22_625d_Sfx_Collectible - @           ; SFX_COLLECTIBLE (sfx $06)
    dw   audio_22_6299_Sfx_07 - @                    ; SFX_07 (sfx $07)
    dw   audio_22_62a7_Sfx_08 - @                    ; SFX_08 (sfx $08)
    dw   audio_22_62b5_Sfx_09 - @                    ; SFX_09 (sfx $09)
    dw   audio_22_62cb_Sfx_0a - @                    ; SFX_0A (sfx $0A)
    dw   audio_22_62df_Sfx_0b - @                    ; SFX_0B (sfx $0B)
    dw   audio_22_6301_Sfx_GexJump - @               ; SFX_GEX_JUMP (sfx $0C)
    dw   audio_22_632b_Sfx_GexDoubleJump - @         ; SFX_GEX_DOUBLE_JUMP (sfx $0D)
    dw   audio_22_6389_Sfx_GexCollapse - @           ; SFX_GEX_COLLAPSE (sfx $0E)
    dw   audio_22_63a1_Sfx_GexDeath - @              ; SFX_GEX_DEATH (sfx $0F)
    dw   audio_22_63f9_Sfx_GexHurt - @               ; SFX_GEX_HURT (sfx $10)
    dw   audio_22_6445_Sfx_GexSpawn - @              ; SFX_GEX_SPAWN (sfx $11)
    dw   audio_22_65f3_Sfx_GexHitBounce - @          ; SFX_GEX_HIT_BOUNCE (sfx $12)
    dw   audio_22_6617_Sfx_13 - @                    ; SFX_13 (sfx $13)
    dw   audio_22_666d_Sfx_MenuUnk1 - @              ; SFX_MENU_UNK_1 (sfx $14)
    dw   audio_22_669b_Sfx_MenuUnk2 - @              ; SFX_MENU_UNK_2 (sfx $15)
    dw   audio_22_66c9_Sfx_16 - @                    ; SFX_16 (sfx $16)
    dw   audio_22_66dd_Sfx_EnemyDefeated - @         ; SFX_ENEMY_DEFEATED (sfx $17)
    dw   audio_22_66f5_Sfx_18 - @                    ; SFX_18 (sfx $18)
    dw   audio_22_6707_Sfx_HardHeadAreaHazard - @    ; SFX_HARD_HEAD_AREA_HAZARD (sfx $19)
    dw   audio_22_6715_Sfx_FallingHazard - @         ; SFX_FALLING_HAZARD (sfx $1A)
    dw   audio_22_672b_Sfx_1b - @                    ; SFX_1B (sfx $1B)
    dw   audio_22_6741_Sfx_Unused1C - @              ; driver sfx id $1C - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_674b_Sfx_FlowerHammer - @          ; SFX_FLOWER_HAMMER (sfx $1C)
    dw   audio_22_6761_Sfx_Bumblebee - @             ; SFX_BUMBLEBEE (sfx $1D)
    dw   audio_22_6795_Sfx_Rocket - @                ; SFX_ROCKET (sfx $1E)
    dw   audio_22_67a5_Sfx_1f - @                    ; SFX_1F (sfx $1F)
    dw   audio_22_67e9_Sfx_Hunter - @                ; SFX_HUNTER (sfx $20)
    dw   audio_22_67f9_Sfx_21 - @                    ; SFX_21 (sfx $21)
    dw   audio_22_6835_Sfx_22 - @                    ; SFX_22 (sfx $22)
    dw   audio_22_6845_Sfx_23 - @                    ; SFX_23 (sfx $23)
    dw   audio_22_685d_Sfx_Unused25 - @              ; driver sfx id $25 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_6865_Sfx_EnemyBounce - @           ; SFX_ENEMY_BOUNCE (sfx $24)
    dw   audio_22_688d_Sfx_25 - @                    ; SFX_25 (sfx $25)
    dw   audio_22_689f_Sfx_Unused28 - @              ; driver sfx id $28 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_68a7_Sfx_26 - @                    ; SFX_26 (sfx $26)
    dw   audio_22_68b7_Sfx_FallingPlatform - @       ; SFX_FALLING_PLATFORM (sfx $27)
    dw   audio_22_68c9_Sfx_28 - @                    ; SFX_28 (sfx $28)
    dw   audio_22_6909_Sfx_29 - @                    ; SFX_29 (sfx $29)
    dw   audio_22_6931_Sfx_GexJumpUnk - @            ; SFX_GEX_JUMP_UNK (sfx $2A)
    dw   audio_22_6943_Sfx_PoweredWalkway - @        ; SFX_POWERED_WALKWAY (sfx $2B)
    dw   audio_22_698b_Sfx_CannonRotate - @          ; SFX_CANNON_ROTATE (sfx $2C)
    dw   audio_22_69b7_Sfx_Jar - @                   ; SFX_JAR (sfx $2D)
    dw   audio_22_69cd_Sfx_2e - @                    ; SFX_2E (sfx $2E)
    dw   audio_22_69e3_Sfx_Unused32 - @              ; driver sfx id $32 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_69ef_Sfx_Dragon - @                ; SFX_DRAGON (sfx $2F)
    dw   audio_22_6a23_Sfx_Cannon - @                ; SFX_CANNON (sfx $30)
    dw   audio_22_6a4d_Sfx_FallingBoulder - @        ; SFX_FALLING_BOULDER (sfx $31)
    dw   audio_22_6a81_Sfx_32 - @                    ; SFX_32 (sfx $32)
    dw   audio_22_6a99_Sfx_Pterosaur - @             ; SFX_PTEROSAUR (sfx $33)
    dw   audio_22_6ac7_Sfx_MultiProjectile - @       ; SFX_MULTI_PROJECTILE (sfx $34)
    dw   audio_22_6ad7_Sfx_Gear - @                  ; SFX_GEAR (sfx $35)
    dw   audio_22_6b03_Sfx_GunProjectile - @         ; SFX_GUN_PROJECTILE (sfx $36)
    dw   audio_22_6b13_Sfx_RezProjectile - @         ; SFX_REZ_PROJECTILE (sfx $37)
    dw   audio_22_6b6b_Sfx_FinalBattleButton - @     ; SFX_FINAL_BATTLE_BUTTON (sfx $38)
    dw   audio_22_6b81_Sfx_RezButton - @             ; SFX_REZ_BUTTON (sfx $39)
    dw   audio_22_6b97_Sfx_Unused3E - @              ; driver sfx id $3E - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_6b9b_Sfx_Unused3F - @              ; driver sfx id $3F - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_6b9f_Sfx_Unused40 - @              ; driver sfx id $40 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_22_6ba3_Sfx_Unused41 - @              ; driver sfx id $41 - no .data_00_116c_SFXChannelTable row reaches it

audio_22_44fe_Music_ScreamTv_Ch1:
    INCBIN "data/audio/music/music_scream_tv_ch1.bin" ; MUSIC_SCREAM_TV ch1
audio_22_49d6_Music_ScreamTv_Ch2:
    INCBIN "data/audio/music/music_scream_tv_ch2.bin" ; MUSIC_SCREAM_TV ch2
audio_22_4c68_Music_ScreamTv_Ch3:
    INCBIN "data/audio/music/music_scream_tv_ch3.bin" ; MUSIC_SCREAM_TV ch3
audio_22_4f9b_Music_ScreamTv_Ch4:
    INCBIN "data/audio/music/music_circuit_central_ch4.bin" ; MUSIC_SCREAM_TV ch4
audio_22_4fb1_Music_Unk04_Ch1:
    INCBIN "data/audio/music/music_unk_04_ch1.bin"  ; MUSIC_UNK_04 ch1
audio_22_5117_Music_Unk04_Ch2:
    INCBIN "data/audio/music/music_unk_04_ch2.bin"  ; MUSIC_UNK_04 ch2
audio_22_58a5_Music_Unk04_Ch3:
    INCBIN "data/audio/music/music_unk_04_ch3.bin"  ; MUSIC_UNK_04 ch3
audio_22_5aa4_Music_Unk04_Ch4:
    INCBIN "data/audio/music/music_unk_04_ch4.bin"  ; MUSIC_UNK_04 ch4
audio_22_5aa6_Music_Rezopolis_Ch1:
    INCBIN "data/audio/music/music_rezopolis_ch1.bin" ; MUSIC_REZOPOLIS ch1
audio_22_5bd0_Music_Rezopolis_Ch2:
    INCBIN "data/audio/music/music_rezopolis_ch2.bin" ; MUSIC_REZOPOLIS ch2
audio_22_5ea4_Music_Rezopolis_Ch3:
    INCBIN "data/audio/music/music_rezopolis_ch3.bin" ; MUSIC_REZOPOLIS ch3
audio_22_60fd_Music_Rezopolis_Ch4:
    INCBIN "data/audio/music/music_rezopolis_ch4.bin" ; MUSIC_REZOPOLIS ch4
audio_22_6149_Sfx_Empty:
    INCBIN "data/audio/sfx/sfx_empty.bin"           ; SFX_EMPTY (sfx $00)
audio_22_615d_Sfx_01:
    INCBIN "data/audio/sfx/sfx_01.bin"              ; SFX_01 (sfx $01)
audio_22_617b_Sfx_TvSmash:
    INCBIN "data/audio/sfx/sfx_tv_smash.bin"        ; SFX_TV_SMASH (sfx $02)
audio_22_61a5_Sfx_SilverRemote:
    INCBIN "data/audio/sfx/sfx_silver_remote.bin"   ; SFX_SILVER_REMOTE (sfx $03)
audio_22_61e7_Sfx_GoldRemote:
    INCBIN "data/audio/sfx/sfx_gold_remote.bin"     ; SFX_GOLD_REMOTE (sfx $04)
audio_22_624f_Sfx_05:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_05 (sfx $05)
audio_22_625d_Sfx_Collectible:
    INCBIN "data/audio/sfx/sfx_collectible.bin"     ; SFX_COLLECTIBLE (sfx $06)
audio_22_6299_Sfx_07:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_07 (sfx $07)
audio_22_62a7_Sfx_08:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_08 (sfx $08)
audio_22_62b5_Sfx_09:
    INCBIN "data/audio/sfx/sfx_09.bin"              ; SFX_09 (sfx $09)
audio_22_62cb_Sfx_0a:
    INCBIN "data/audio/sfx/sfx_0a.bin"              ; SFX_0A (sfx $0A)
audio_22_62df_Sfx_0b:
    INCBIN "data/audio/sfx/sfx_0b.bin"              ; SFX_0B (sfx $0B)
audio_22_6301_Sfx_GexJump:
    INCBIN "data/audio/sfx/sfx_gex_jump.bin"        ; SFX_GEX_JUMP (sfx $0C)
audio_22_632b_Sfx_GexDoubleJump:
    INCBIN "data/audio/sfx/sfx_gex_double_jump.bin" ; SFX_GEX_DOUBLE_JUMP (sfx $0D)
audio_22_6389_Sfx_GexCollapse:
    INCBIN "data/audio/sfx/sfx_gex_collapse.bin"    ; SFX_GEX_COLLAPSE (sfx $0E)
audio_22_63a1_Sfx_GexDeath:
    INCBIN "data/audio/sfx/sfx_gex_death.bin"       ; SFX_GEX_DEATH (sfx $0F)
audio_22_63f9_Sfx_GexHurt:
    INCBIN "data/audio/sfx/sfx_gex_hurt.bin"        ; SFX_GEX_HURT (sfx $10)
audio_22_6445_Sfx_GexSpawn:
    INCBIN "data/audio/sfx/sfx_gex_spawn.bin"       ; SFX_GEX_SPAWN (sfx $11)
audio_22_65f3_Sfx_GexHitBounce:
    INCBIN "data/audio/sfx/sfx_gex_hit_bounce.bin"  ; SFX_GEX_HIT_BOUNCE (sfx $12)
audio_22_6617_Sfx_13:
    INCBIN "data/audio/sfx/sfx_13.bin"              ; SFX_13 (sfx $13)
audio_22_666d_Sfx_MenuUnk1:
    INCBIN "data/audio/sfx/sfx_menu_unk_1.bin"      ; SFX_MENU_UNK_1 (sfx $14)
audio_22_669b_Sfx_MenuUnk2:
    INCBIN "data/audio/sfx/sfx_menu_unk_2.bin"      ; SFX_MENU_UNK_2 (sfx $15)
audio_22_66c9_Sfx_16:
    INCBIN "data/audio/sfx/sfx_16.bin"              ; SFX_16 (sfx $16)
audio_22_66dd_Sfx_EnemyDefeated:
    INCBIN "data/audio/sfx/sfx_enemy_defeated.bin"  ; SFX_ENEMY_DEFEATED (sfx $17)
audio_22_66f5_Sfx_18:
    INCBIN "data/audio/sfx/sfx_18.bin"              ; SFX_18 (sfx $18)
audio_22_6707_Sfx_HardHeadAreaHazard:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_HARD_HEAD_AREA_HAZARD (sfx $19)
audio_22_6715_Sfx_FallingHazard:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_FALLING_HAZARD (sfx $1A)
audio_22_672b_Sfx_1b:
    INCBIN "data/audio/sfx/sfx_1b.bin"              ; SFX_1B (sfx $1B)
audio_22_6741_Sfx_Unused1C:
    INCBIN "data/audio/sfx/sfx_unused_1c.bin"       ; driver sfx id $1C - no .data_00_116c_SFXChannelTable row reaches it
audio_22_674b_Sfx_FlowerHammer:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_FLOWER_HAMMER (sfx $1C)
audio_22_6761_Sfx_Bumblebee:
    INCBIN "data/audio/sfx/sfx_bumblebee.bin"       ; SFX_BUMBLEBEE (sfx $1D)
audio_22_6795_Sfx_Rocket:
    INCBIN "data/audio/sfx/sfx_rocket.bin"          ; SFX_ROCKET (sfx $1E)
audio_22_67a5_Sfx_1f:
    INCBIN "data/audio/sfx/sfx_1f.bin"              ; SFX_1F (sfx $1F)
audio_22_67e9_Sfx_Hunter:
    INCBIN "data/audio/sfx/sfx_rocket.bin"          ; SFX_HUNTER (sfx $20)
audio_22_67f9_Sfx_21:
    INCBIN "data/audio/sfx/sfx_21.bin"              ; SFX_21 (sfx $21)
audio_22_6835_Sfx_22:
    INCBIN "data/audio/sfx/sfx_22.bin"              ; SFX_22 (sfx $22)
audio_22_6845_Sfx_23:
    INCBIN "data/audio/sfx/sfx_23.bin"              ; SFX_23 (sfx $23)
audio_22_685d_Sfx_Unused25:
    INCBIN "data/audio/sfx/sfx_unused_25.bin"       ; driver sfx id $25 - no .data_00_116c_SFXChannelTable row reaches it
audio_22_6865_Sfx_EnemyBounce:
    INCBIN "data/audio/sfx/sfx_enemy_bounce.bin"    ; SFX_ENEMY_BOUNCE (sfx $24)
audio_22_688d_Sfx_25:
    INCBIN "data/audio/sfx/sfx_25.bin"              ; SFX_25 (sfx $25)
audio_22_689f_Sfx_Unused28:
    INCBIN "data/audio/sfx/sfx_unused_25.bin"       ; driver sfx id $28 - no .data_00_116c_SFXChannelTable row reaches it
audio_22_68a7_Sfx_26:
    INCBIN "data/audio/sfx/sfx_26.bin"              ; SFX_26 (sfx $26)
audio_22_68b7_Sfx_FallingPlatform:
    INCBIN "data/audio/sfx/sfx_falling_platform.bin" ; SFX_FALLING_PLATFORM (sfx $27)
audio_22_68c9_Sfx_28:
    INCBIN "data/audio/sfx/sfx_28.bin"              ; SFX_28 (sfx $28)
audio_22_6909_Sfx_29:
    INCBIN "data/audio/sfx/sfx_enemy_bounce.bin"    ; SFX_29 (sfx $29)
audio_22_6931_Sfx_GexJumpUnk:
    INCBIN "data/audio/sfx/sfx_gex_jump_unk.bin"    ; SFX_GEX_JUMP_UNK (sfx $2A)
audio_22_6943_Sfx_PoweredWalkway:
    INCBIN "data/audio/sfx/sfx_powered_walkway.bin" ; SFX_POWERED_WALKWAY (sfx $2B)
audio_22_698b_Sfx_CannonRotate:
    INCBIN "data/audio/sfx/sfx_cannon_rotate.bin"   ; SFX_CANNON_ROTATE (sfx $2C)
audio_22_69b7_Sfx_Jar:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_JAR (sfx $2D)
audio_22_69cd_Sfx_2e:
    INCBIN "data/audio/sfx/sfx_2e.bin"              ; SFX_2E (sfx $2E)
audio_22_69e3_Sfx_Unused32:
    INCBIN "data/audio/sfx/sfx_unused_32.bin"       ; driver sfx id $32 - no .data_00_116c_SFXChannelTable row reaches it
audio_22_69ef_Sfx_Dragon:
    INCBIN "data/audio/sfx/sfx_bumblebee.bin"       ; SFX_DRAGON (sfx $2F)
audio_22_6a23_Sfx_Cannon:
    INCBIN "data/audio/sfx/sfx_gex_jump.bin"        ; SFX_CANNON (sfx $30)
audio_22_6a4d_Sfx_FallingBoulder:
    INCBIN "data/audio/sfx/sfx_falling_boulder.bin" ; SFX_FALLING_BOULDER (sfx $31)
audio_22_6a81_Sfx_32:
    INCBIN "data/audio/sfx/sfx_32.bin"              ; SFX_32 (sfx $32)
audio_22_6a99_Sfx_Pterosaur:
    INCBIN "data/audio/sfx/sfx_pterosaur.bin"       ; SFX_PTEROSAUR (sfx $33)
audio_22_6ac7_Sfx_MultiProjectile:
    INCBIN "data/audio/sfx/sfx_multi_projectile.bin" ; SFX_MULTI_PROJECTILE (sfx $34)
audio_22_6ad7_Sfx_Gear:
    INCBIN "data/audio/sfx/sfx_cannon_rotate.bin"   ; SFX_GEAR (sfx $35)
audio_22_6b03_Sfx_GunProjectile:
    INCBIN "data/audio/sfx/sfx_rocket.bin"          ; SFX_GUN_PROJECTILE (sfx $36)
audio_22_6b13_Sfx_RezProjectile:
    INCBIN "data/audio/sfx/sfx_rez_projectile.bin"  ; SFX_REZ_PROJECTILE (sfx $37)
audio_22_6b6b_Sfx_FinalBattleButton:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_FINAL_BATTLE_BUTTON (sfx $38)
audio_22_6b81_Sfx_RezButton:
    INCBIN "data/audio/sfx/sfx_rez_button.bin"      ; SFX_REZ_BUTTON (sfx $39)
audio_22_6b97_Sfx_Unused3E:
    INCBIN "data/audio/sfx/sfx_unused_3e.bin"       ; driver sfx id $3E - no .data_00_116c_SFXChannelTable row reaches it
audio_22_6b9b_Sfx_Unused3F:
    INCBIN "data/audio/sfx/sfx_unused_3f.bin"       ; driver sfx id $3F - no .data_00_116c_SFXChannelTable row reaches it
audio_22_6b9f_Sfx_Unused40:
    INCBIN "data/audio/sfx/sfx_unused_40.bin"       ; driver sfx id $40 - no .data_00_116c_SFXChannelTable row reaches it
audio_22_6ba3_Sfx_Unused41:
    INCBIN "data/audio/sfx/sfx_unused_41.bin"       ; driver sfx id $41 - no .data_00_116c_SFXChannelTable row reaches it
