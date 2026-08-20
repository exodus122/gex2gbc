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
; wDFE6_Audio_SavedWaveRam. data_23_439e_ChannelSaveRegs is the list of which
; registers are worth saving per channel.
;
; A SEQUENCE is a byte stream walked by Audio_RunSequence, which runs commands until
; it hits a note and then returns that note's duration - the caller stores it as the
; channel's countdown and comes back when it expires. So one call advances one channel
; by one note, however many register writes are in front of it. See the AUDIO_CMD_*
; and AUDIO_NOTE_* constants for the opcode map.
;
; THE TRACK TABLES at data_23_4460_TrackPointerTables are two lists of self-relative
; words. The first word of the block is the offset to the sfx list; the music list
; starts immediately after it.
;
; A SONG IS FOUR TRACKS, one per hardware channel, at four consecutive ids - which is
; why the ids come in groups whose headers read $01, $02, $03, $04.
; call_00_120c_SetupMusic in bank 0 starts all four in one go. So the 8 music ids
; here are 2 songs, and .data_00_1244_MusicList says which are which.
;
; The 66 sfx are one track each and are the same 66 effects in every bank that has
; them - the same effect id gives a different rendition depending on which bank is
; mapped in
; ==================================================================

SECTION "bank23", ROMX[$4000], BANK[$23]

call_23_4000_Audio_Init:
; Boot-time reset. Points wDFAE_AudioBankDataPointer at this bank's track tables,
; clears every channel mask, both sets of duration counters and rNR51, then wipes the
; 20-byte music register save area and the 16-byte wave RAM save area. It does not
; touch rNR52, so the APU is left however the caller had it
    ld   HL, data_23_4460_TrackPointerTables                              ;; 23:4000 $21 $60 $44
    ld   A, L                                          ;; 23:4003 $7d
    ld   [wDFAE_AudioBankDataPointer], A                                    ;; 23:4004 $ea $ae $df
    ld   A, H                                          ;; 23:4007 $7c
    ld   [wDFAF_AudioBankDataPointer], A                                    ;; 23:4008 $ea $af $df
    xor  A, A                                          ;; 23:400b $af
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 23:400c $ea $c2 $df
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 23:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 23:4012 $e0 $25
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 23:4014 $ea $b8 $df
    ld   [wDFB9_Audio_MusicTimerCh1], A                                    ;; 23:4017 $ea $b9 $df
    ld   [wDFBA_Audio_MusicTimerCh2], A                                    ;; 23:401a $ea $ba $df
    ld   [wDFBB_Audio_MusicTimerCh3], A                                    ;; 23:401d $ea $bb $df
    ld   [wDFBC_Audio_MusicTimerCh4], A                                    ;; 23:4020 $ea $bc $df
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 23:4023 $ea $cf $df
    ld   [wDFCB_Audio_SfxTimerCh1], A                                    ;; 23:4026 $ea $cb $df
    ld   [wDFCC_Audio_SfxTimerCh2], A                                    ;; 23:4029 $ea $cc $df
    ld   [wDFCD_Audio_SfxTimerCh3], A                                    ;; 23:402c $ea $cd $df
    ld   [wDFCE_Audio_SfxTimerCh4], A                                    ;; 23:402f $ea $ce $df
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 23:4032 $21 $d2 $df
    ld   C, $14                                        ;; 23:4035 $0e $14
    xor  A, A                                          ;; 23:4037 $af
jr_23_4038:
    ld   [HL+], A                                      ;; 23:4038 $22
    dec  C                                             ;; 23:4039 $0d
    jr   NZ, jr_23_4038                                ;; 23:403a $20 $fc
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 23:403c $21 $e6 $df
    ld   C, $10                                        ;; 23:403f $0e $10
    xor  A, A                                          ;; 23:4041 $af
.jr_23_4042:
    ld   [HL+], A                                      ;; 23:4042 $22
    dec  C                                             ;; 23:4043 $0d
    jr   NZ, .jr_23_4042                               ;; 23:4044 $20 $fc
    ret                                                ;; 23:4046 $c9

call_23_4047_Audio_PlaySfx:
; Start sound effect id A.
;
; Before anything is queued this snapshots the hardware state of the channels the
; effect is about to take: data_23_439e_ChannelSaveRegs lists five (register, mask)
; pairs per channel, and each register is read, masked and written into that channel's
; slot of wDFD2_Audio_SavedMusicRegs. The mask keeps only the bits worth restoring -
; the length counters and trigger bits are deliberately dropped.
;
; It then follows the first word of the track table block, which is the offset to the
; sfx list, and falls into the shared start-up path below with
; wDFD1_Audio_RequestKind = AUDIO_REQUEST_SFX
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 23:4047 $ea $d0 $df
    ld   A, $01                                        ;; 23:404a $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 23:404c $ea $d1 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 23:404f $fa $d0 $df
    sla  A                                             ;; 23:4052 $cb $27
    ld   E, A                                          ;; 23:4054 $5f
    sla  A                                             ;; 23:4055 $cb $27
    ld   C, A                                          ;; 23:4057 $4f
    sla  A                                             ;; 23:4058 $cb $27
    add  A, E                                          ;; 23:405a $83
    ld   DE, data_23_439e_ChannelSaveRegs                              ;; 23:405b $11 $9e $43
    add  A, E                                          ;; 23:405e $83
    ld   E, A                                          ;; 23:405f $5f
    jr   NC, .jr_23_4063                               ;; 23:4060 $30 $01
    inc  D                                             ;; 23:4062 $14
.jr_23_4063:
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 23:4063 $21 $d2 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 23:4066 $fa $d0 $df
    add  A, C                                          ;; 23:4069 $81
    add  A, L                                          ;; 23:406a $85
    ld   L, A                                          ;; 23:406b $6f
    jr   NC, .jr_23_406f                               ;; 23:406c $30 $01
    inc  H                                             ;; 23:406e $24
.jr_23_406f:
    ld   B, $ff                                        ;; 23:406f $06 $ff
.jr_23_4071:
    ld   A, [DE]                                       ;; 23:4071 $1a
    and  A, A                                          ;; 23:4072 $a7
    jr   Z, .jr_23_407f                                ;; 23:4073 $28 $0a
    inc  DE                                            ;; 23:4075 $13
    ld   C, A                                          ;; 23:4076 $4f
    ld   A, [BC]                                       ;; 23:4077 $0a
    ld   C, A                                          ;; 23:4078 $4f
    ld   A, [DE]                                       ;; 23:4079 $1a
    inc  DE                                            ;; 23:407a $13
    and  A, C                                          ;; 23:407b $a1
    ld   [HL+], A                                      ;; 23:407c $22
    jr   .jr_23_4071                                   ;; 23:407d $18 $f2
.jr_23_407f:
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 23:407f $fa $ae $df
    ld   E, A                                          ;; 23:4082 $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 23:4083 $fa $af $df
    ld   D, A                                          ;; 23:4086 $57
    ld   A, [DE]                                       ;; 23:4087 $1a
    add  A, E                                          ;; 23:4088 $83
    ld   L, A                                          ;; 23:4089 $6f
    inc  DE                                            ;; 23:408a $13
    ld   A, [DE]                                       ;; 23:408b $1a
    dec  DE                                            ;; 23:408c $1b
    adc  A, D                                          ;; 23:408d $8a
    ld   D, A                                          ;; 23:408e $57
    ld   E, L                                          ;; 23:408f $5d
    jr   jr_23_40a4_Audio_StartTrack                                    ;; 23:4090 $18 $12

call_23_4092_Audio_PlayMusic:
; Start music track id A. No state is saved, because music is what gets interrupted
; rather than what does the interrupting; the music list begins two bytes into the
; track table block, immediately after the word that locates the sfx list
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 23:4092 $ea $d0 $df
    ld   A, $02                                        ;; 23:4095 $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 23:4097 $ea $d1 $df
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 23:409a $fa $ae $df
    ld   E, A                                          ;; 23:409d $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 23:409e $fa $af $df
    ld   D, A                                          ;; 23:40a1 $57
    inc  DE                                            ;; 23:40a2 $13
    inc  DE                                            ;; 23:40a3 $13

jr_23_40a4_Audio_StartTrack:
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
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 23:40a4 $fa $d0 $df
    add  A, A                                          ;; 23:40a7 $87
    ld   L, A                                          ;; 23:40a8 $6f
    ld   A, D                                          ;; 23:40a9 $7a
    adc  A, $00                                        ;; 23:40aa $ce $00
    ld   D, A                                          ;; 23:40ac $57
    ld   A, E                                          ;; 23:40ad $7b
    add  A, L                                          ;; 23:40ae $85
    ld   E, A                                          ;; 23:40af $5f
    ld   A, D                                          ;; 23:40b0 $7a
    adc  A, $00                                        ;; 23:40b1 $ce $00
    ld   D, A                                          ;; 23:40b3 $57
    ld   A, [DE]                                       ;; 23:40b4 $1a
    add  A, E                                          ;; 23:40b5 $83
    ld   L, A                                          ;; 23:40b6 $6f
    inc  DE                                            ;; 23:40b7 $13
    ld   A, [DE]                                       ;; 23:40b8 $1a
    dec  DE                                            ;; 23:40b9 $1b
    adc  A, D                                          ;; 23:40ba $8a
    ld   D, A                                          ;; 23:40bb $57
    ld   E, L                                          ;; 23:40bc $5d
    ld   A, [DE]                                       ;; 23:40bd $1a
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 23:40be $ea $fe $df
    ld   L, A                                          ;; 23:40c1 $6f
    xor  A, A                                          ;; 23:40c2 $af
    scf                                                ;; 23:40c3 $37
.jr_23_40c4:
    rl   A                                             ;; 23:40c4 $cb $17
    dec  L                                             ;; 23:40c6 $2d
    jr   NZ, .jr_23_40c4                               ;; 23:40c7 $20 $fb
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 23:40c9 $ea $c1 $df
    ld   L, A                                          ;; 23:40cc $6f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 23:40cd $fa $d1 $df
    cp   A, $01                                        ;; 23:40d0 $fe $01
    jr   NZ, .jr_23_40e3                               ;; 23:40d2 $20 $0f
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:40d4 $fa $cf $df
    or   A, L                                          ;; 23:40d7 $b5
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 23:40d8 $ea $cf $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 23:40db $21 $c3 $df
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 23:40de $01 $cb $df
    jr   .jr_23_40f0                                   ;; 23:40e1 $18 $0d
.jr_23_40e3:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 23:40e3 $fa $c2 $df
    or   A, L                                          ;; 23:40e6 $b5
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 23:40e7 $ea $c2 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 23:40ea $21 $b0 $df
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 23:40ed $01 $b9 $df
.jr_23_40f0:
    ld   A, [DE]                                       ;; 23:40f0 $1a
    dec  A                                             ;; 23:40f1 $3d
    sla  A                                             ;; 23:40f2 $cb $27
    add  A, L                                          ;; 23:40f4 $85
    ld   L, A                                          ;; 23:40f5 $6f
    jr   NC, .jr_23_40f9                               ;; 23:40f6 $30 $01
    inc  H                                             ;; 23:40f8 $24
.jr_23_40f9:
    ld   A, [DE]                                       ;; 23:40f9 $1a
    dec  A                                             ;; 23:40fa $3d
    add  A, C                                          ;; 23:40fb $81
    ld   C, A                                          ;; 23:40fc $4f
    jr   NC, .jr_23_4100                               ;; 23:40fd $30 $01
    inc  B                                             ;; 23:40ff $04
.jr_23_4100:
    inc  DE                                            ;; 23:4100 $13
    ld   [HL], E                                       ;; 23:4101 $73
    inc  HL                                            ;; 23:4102 $23
    ld   [HL], D                                       ;; 23:4103 $72
    dec  HL                                            ;; 23:4104 $2b
    push BC                                            ;; 23:4105 $c5
    call call_23_4199_Audio_RunSequence                                  ;; 23:4106 $cd $99 $41
    pop  BC                                            ;; 23:4109 $c1
    ld   [BC], A                                       ;; 23:410a $02
    ret                                                ;; 23:410b $c9

call_23_410c_Audio_Update:
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
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 23:410c $01 $b9 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 23:410f $21 $b0 $df
    ld   A, $01                                        ;; 23:4112 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 23:4114 $ea $c1 $df
    ld   A, $00                                        ;; 23:4117 $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 23:4119 $ea $b8 $df
    ld   A, $02                                        ;; 23:411c $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 23:411e $ea $d1 $df
.jp_23_4121:
    push BC                                            ;; 23:4121 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4122 $fa $c1 $df
    ld   D, A                                          ;; 23:4125 $57
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 23:4126 $fa $c2 $df
    and  A, D                                          ;; 23:4129 $a2
    jr   Z, .jr_23_4139                                ;; 23:412a $28 $0d
    ld   A, [BC]                                       ;; 23:412c $0a
    dec  A                                             ;; 23:412d $3d
    jr   NZ, .jr_23_4139                               ;; 23:412e $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 23:4130 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 23:4133 $ea $fe $df
    call call_23_4199_Audio_RunSequence                                  ;; 23:4136 $cd $99 $41
.jr_23_4139:
    pop  BC                                            ;; 23:4139 $c1
    ld   [BC], A                                       ;; 23:413a $02
    inc  BC                                            ;; 23:413b $03
    inc  HL                                            ;; 23:413c $23
    inc  HL                                            ;; 23:413d $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:413e $fa $c1 $df
    sla  A                                             ;; 23:4141 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 23:4143 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 23:4146 $fa $b8 $df
    inc  A                                             ;; 23:4149 $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 23:414a $ea $b8 $df
    cp   A, $04                                        ;; 23:414d $fe $04
    jp   NZ, .jp_23_4121                               ;; 23:414f $c2 $21 $41
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 23:4152 $01 $cb $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 23:4155 $21 $c3 $df
    ld   A, $01                                        ;; 23:4158 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 23:415a $ea $c1 $df
    ld   A, $00                                        ;; 23:415d $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 23:415f $ea $b8 $df
    ld   A, $01                                        ;; 23:4162 $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 23:4164 $ea $d1 $df
.jp_23_4167:
    push BC                                            ;; 23:4167 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4168 $fa $c1 $df
    ld   D, A                                          ;; 23:416b $57
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:416c $fa $cf $df
    and  A, D                                          ;; 23:416f $a2
    jr   Z, .jr_23_417f                                ;; 23:4170 $28 $0d
    ld   A, [BC]                                       ;; 23:4172 $0a
    dec  A                                             ;; 23:4173 $3d
    jr   NZ, .jr_23_417f                               ;; 23:4174 $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 23:4176 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 23:4179 $ea $fe $df
    call call_23_4199_Audio_RunSequence                                  ;; 23:417c $cd $99 $41
.jr_23_417f:
    pop  BC                                            ;; 23:417f $c1
    ld   [BC], A                                       ;; 23:4180 $02
    inc  BC                                            ;; 23:4181 $03
    inc  HL                                            ;; 23:4182 $23
    inc  HL                                            ;; 23:4183 $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4184 $fa $c1 $df
    sla  A                                             ;; 23:4187 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 23:4189 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 23:418c $fa $b8 $df
    inc  A                                             ;; 23:418f $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 23:4190 $ea $b8 $df
    cp   A, $04                                        ;; 23:4193 $fe $04
    jp   NZ, .jp_23_4167                               ;; 23:4195 $c2 $67 $41
    ret                                                ;; 23:4198 $c9

call_23_4199_Audio_RunSequence:
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
; A note indexes data_23_43ce_NoteFrequencies for an 11-bit frequency, writes it to the
; channel's frequency registers with the trigger bit set, and enables the channel in
; rNR52. AUDIO_NOTE_REST silences the channel instead, and AUDIO_NOTE_SUSTAIN
; retriggers it without touching the pitch. The byte after the note is its duration.
;
; While an sfx owns a channel the music's note writes are computed and stored to
; wDFF6_Audio_ChannelFreqShadow but kept out of the hardware registers, which is how
; the music stays in time underneath and reappears in the right place
    ld   C, [HL]                                       ;; 23:4199 $4e
    inc  HL                                            ;; 23:419a $23
    ld   B, [HL]                                       ;; 23:419b $46
.jp_23_419c:
    ld   A, [BC]                                       ;; 23:419c $0a
    cp   A, $fe                                        ;; 23:419d $fe $fe
    jr   NZ, .jr_23_41ae                               ;; 23:419f $20 $0d
    inc  BC                                            ;; 23:41a1 $03
    ld   A, [BC]                                       ;; 23:41a2 $0a
    ld   E, A                                          ;; 23:41a3 $5f
    inc  BC                                            ;; 23:41a4 $03
    ld   A, [BC]                                       ;; 23:41a5 $0a
    ld   D, A                                          ;; 23:41a6 $57
    ld   A, C                                          ;; 23:41a7 $79
    sub  A, E                                          ;; 23:41a8 $93
    ld   C, A                                          ;; 23:41a9 $4f
    ld   A, B                                          ;; 23:41aa $78
    sbc  A, D                                          ;; 23:41ab $9a
    ld   B, A                                          ;; 23:41ac $47
    ld   A, [BC]                                       ;; 23:41ad $0a
.jr_23_41ae:
    inc  BC                                            ;; 23:41ae $03
    cp   A, $ff                                        ;; 23:41af $fe $ff
    jp   NZ, .jp_23_426f                               ;; 23:41b1 $c2 $6f $42
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:41b4 $fa $c1 $df
    cpl                                                ;; 23:41b7 $2f
    ld   E, A                                          ;; 23:41b8 $5f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 23:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 23:41bc $fe $01
    jp   NZ, .jp_23_4253                               ;; 23:41be $c2 $53 $42
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:41c1 $fa $cf $df
    and  A, E                                          ;; 23:41c4 $a3
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 23:41c5 $ea $cf $df
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 23:41c8 $fa $c2 $df
    ld   E, A                                          ;; 23:41cb $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:41cc $fa $c1 $df
    and  A, E                                          ;; 23:41cf $a3
    jp   Z, .jp_23_4265                                ;; 23:41d0 $ca $65 $42
    push HL                                            ;; 23:41d3 $e5
    push BC                                            ;; 23:41d4 $c5
    ld   B, $ff                                        ;; 23:41d5 $06 $ff
    ld   DE, wDFD2_Audio_SavedMusicRegs                                     ;; 23:41d7 $11 $d2 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 23:41da $fa $fe $df
    sla  A                                             ;; 23:41dd $cb $27
    sla  A                                             ;; 23:41df $cb $27
    add  A, E                                          ;; 23:41e1 $83
    ld   E, A                                          ;; 23:41e2 $5f
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 23:41e3 $fa $fe $df
    add  A, E                                          ;; 23:41e6 $83
    ld   E, A                                          ;; 23:41e7 $5f
    ld   HL, data_23_439e_ChannelSaveRegs                              ;; 23:41e8 $21 $9e $43
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 23:41eb $fa $fe $df
    sla  A                                             ;; 23:41ee $cb $27
    ld   C, A                                          ;; 23:41f0 $4f
    sla  A                                             ;; 23:41f1 $cb $27
    sla  A                                             ;; 23:41f3 $cb $27
    add  A, C                                          ;; 23:41f5 $81
    add  A, L                                          ;; 23:41f6 $85
    ld   L, A                                          ;; 23:41f7 $6f
    jr   NC, .jr_23_41fb                               ;; 23:41f8 $30 $01
    inc  H                                             ;; 23:41fa $24
.jr_23_41fb:
    ld   A, [HL+]                                      ;; 23:41fb $2a
    and  A, A                                          ;; 23:41fc $a7
    jr   Z, .jr_23_4206                                ;; 23:41fd $28 $07
    ld   C, A                                          ;; 23:41ff $4f
    ld   A, [DE]                                       ;; 23:4200 $1a
    ld   [BC], A                                       ;; 23:4201 $02
    inc  DE                                            ;; 23:4202 $13
    inc  HL                                            ;; 23:4203 $23
    jr   .jr_23_41fb                                   ;; 23:4204 $18 $f5
.jr_23_4206:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4206 $fa $c1 $df
    cp   A, $04                                        ;; 23:4209 $fe $04
    jr   NZ, .jr_23_421b                               ;; 23:420b $20 $0e
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 23:420d $21 $e6 $df
    ld   DE, _AUD3WAVERAM                                     ;; 23:4210 $11 $30 $ff
    ld   C, $10                                        ;; 23:4213 $0e $10
.jr_23_4215:
    ld   A, [HL+]                                      ;; 23:4215 $2a
    ld   [DE], A                                       ;; 23:4216 $12
    inc  DE                                            ;; 23:4217 $13
    dec  C                                             ;; 23:4218 $0d
    jr   NZ, .jr_23_4215                               ;; 23:4219 $20 $fa
.jr_23_421b:
    ld   HL, wDFF6_Audio_ChannelFreqShadow                                     ;; 23:421b $21 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 23:421e $fa $fe $df
    sla  A                                             ;; 23:4221 $cb $27
    add  A, L                                          ;; 23:4223 $85
    ld   L, A                                          ;; 23:4224 $6f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4225 $fa $c1 $df
    dec  A                                             ;; 23:4228 $3d
    ld   DE, data_23_43c6_ChannelFreqLoReg                              ;; 23:4229 $11 $c6 $43
    add  A, E                                          ;; 23:422c $83
    ld   E, A                                          ;; 23:422d $5f
    jr   NC, .jr_23_4231                               ;; 23:422e $30 $01
    inc  D                                             ;; 23:4230 $14
.jr_23_4231:
    ld   A, [DE]                                       ;; 23:4231 $1a
    ld   E, A                                          ;; 23:4232 $5f
    ld   D, $ff                                        ;; 23:4233 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4235 $fa $c1 $df
    cp   A, $08                                        ;; 23:4238 $fe $08
    jr   NZ, .jr_23_4244                               ;; 23:423a $20 $08
    inc  HL                                            ;; 23:423c $23
    ld   [DE], A                                       ;; 23:423d $12
    ldh  A, [rNR42]                                    ;; 23:423e $f0 $21
    ldh  [rNR42], A                                    ;; 23:4240 $e0 $21
    jr   .jr_23_424e                                   ;; 23:4242 $18 $0a
.jr_23_4244:
    ld   A, [HL+]                                      ;; 23:4244 $2a
    ld   [DE], A                                       ;; 23:4245 $12
    inc  DE                                            ;; 23:4246 $13
    ld   A, [DE]                                       ;; 23:4247 $1a
    and  A, $c0                                        ;; 23:4248 $e6 $c0
    ld   C, A                                          ;; 23:424a $4f
    ld   A, [HL]                                       ;; 23:424b $7e
    or   A, C                                          ;; 23:424c $b1
    ld   [DE], A                                       ;; 23:424d $12
.jr_23_424e:
    pop  BC                                            ;; 23:424e $c1
    pop  HL                                            ;; 23:424f $e1
    jp   .jp_23_4392                                   ;; 23:4250 $c3 $92 $43
.jp_23_4253:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 23:4253 $fa $c2 $df
    and  A, E                                          ;; 23:4256 $a3
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 23:4257 $ea $c2 $df
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:425a $fa $cf $df
    ld   E, A                                          ;; 23:425d $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:425e $fa $c1 $df
    and  A, E                                          ;; 23:4261 $a3
    jp   NZ, .jp_23_4392                               ;; 23:4262 $c2 $92 $43
.jp_23_4265:
    ldh  A, [rNR52]                                    ;; 23:4265 $f0 $26
    and  A, $8f                                        ;; 23:4267 $e6 $8f
    and  A, E                                          ;; 23:4269 $a3
    ldh  [rNR52], A                                    ;; 23:426a $e0 $26
    jp   .jp_23_4392                                   ;; 23:426c $c3 $92 $43
.jp_23_426f:
    cp   A, $fd                                        ;; 23:426f $fe $fd
    jr   NZ, .jr_23_4284                               ;; 23:4271 $20 $11
    push HL                                            ;; 23:4273 $e5
    ld   DE, _AUD3WAVERAM                                     ;; 23:4274 $11 $30 $ff
    ld   L, $10                                        ;; 23:4277 $2e $10
.jr_23_4279:
    ld   A, [BC]                                       ;; 23:4279 $0a
    inc  BC                                            ;; 23:427a $03
    ld   [DE], A                                       ;; 23:427b $12
    inc  DE                                            ;; 23:427c $13
    dec  L                                             ;; 23:427d $2d
    jr   NZ, .jr_23_4279                               ;; 23:427e $20 $f9
    pop  HL                                            ;; 23:4280 $e1
    jp   .jp_23_419c                                   ;; 23:4281 $c3 $9c $41
.jr_23_4284:
    cp   A, $a0                                        ;; 23:4284 $fe $a0
    jr   C, .jr_23_42bb                                ;; 23:4286 $38 $33
    cp   A, $c0                                        ;; 23:4288 $fe $c0
    jr   NC, .jr_23_429c                               ;; 23:428a $30 $10
    sub  A, $90                                        ;; 23:428c $d6 $90
    ld   E, A                                          ;; 23:428e $5f
    ld   D, $ff                                        ;; 23:428f $16 $ff
    ld   A, [DE]                                       ;; 23:4291 $1a
    ld   D, A                                          ;; 23:4292 $57
    ld   A, [BC]                                       ;; 23:4293 $0a
    and  A, D                                          ;; 23:4294 $a2
    ld   D, $ff                                        ;; 23:4295 $16 $ff
    ld   [DE], A                                       ;; 23:4297 $12
    inc  BC                                            ;; 23:4298 $03
    jp   .jp_23_419c                                   ;; 23:4299 $c3 $9c $41
.jr_23_429c:
    cp   A, $e0                                        ;; 23:429c $fe $e0
    jr   NC, .jr_23_42b0                               ;; 23:429e $30 $10
    sub  A, $b0                                        ;; 23:42a0 $d6 $b0
    ld   E, A                                          ;; 23:42a2 $5f
    ld   D, $ff                                        ;; 23:42a3 $16 $ff
    ld   A, [DE]                                       ;; 23:42a5 $1a
    ld   D, A                                          ;; 23:42a6 $57
    ld   A, [BC]                                       ;; 23:42a7 $0a
    or   A, D                                          ;; 23:42a8 $b2
    ld   D, $ff                                        ;; 23:42a9 $16 $ff
    ld   [DE], A                                       ;; 23:42ab $12
    inc  BC                                            ;; 23:42ac $03
    jp   .jp_23_419c                                   ;; 23:42ad $c3 $9c $41
.jr_23_42b0:
    sub  A, $d0                                        ;; 23:42b0 $d6 $d0
    ld   E, A                                          ;; 23:42b2 $5f
    ld   D, $ff                                        ;; 23:42b3 $16 $ff
    ld   A, [BC]                                       ;; 23:42b5 $0a
    inc  BC                                            ;; 23:42b6 $03
    ld   [DE], A                                       ;; 23:42b7 $12
    jp   .jp_23_419c                                   ;; 23:42b8 $c3 $9c $41
.jr_23_42bb:
    cp   A, $49                                        ;; 23:42bb $fe $49
    jp   Z, .jp_23_4369                                ;; 23:42bd $ca $69 $43
    sla  A                                             ;; 23:42c0 $cb $27
    ld   [wDFBF_Audio_NoteTableOffset], A                                    ;; 23:42c2 $ea $bf $df
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 23:42c8 $d6 $01
    ld   [wDFC0_Audio_ChannelIndexFromMask], A                                    ;; 23:42ca $ea $c0 $df
    ld   A, [wDFBF_Audio_NoteTableOffset]                                    ;; 23:42cd $fa $bf $df
    and  A, A                                          ;; 23:42d0 $a7
    jr   NZ, .jr_23_42ff                               ;; 23:42d1 $20 $2c
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 23:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 23:42d6 $fe $01
    jr   Z, .jr_23_42e4                                ;; 23:42d8 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:42da $fa $cf $df
    ld   E, A                                          ;; 23:42dd $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:42de $fa $c1 $df
    and  A, E                                          ;; 23:42e1 $a3
    jr   NZ, .jr_23_42ff                               ;; 23:42e2 $20 $1b
.jr_23_42e4:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:42e4 $fa $c1 $df
    cpl                                                ;; 23:42e7 $2f
    ld   E, A                                          ;; 23:42e8 $5f
    ldh  A, [rNR52]                                    ;; 23:42e9 $f0 $26
    and  A, $8f                                        ;; 23:42eb $e6 $8f
    and  A, E                                          ;; 23:42ed $a3
    ldh  [rNR52], A                                    ;; 23:42ee $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 23:42f3 $fe $04
    jr   NZ, .jr_23_42fa                               ;; 23:42f5 $20 $03
    xor  A, A                                          ;; 23:42f7 $af
    ldh  [rNR30], A                                    ;; 23:42f8 $e0 $1a
.jr_23_42fa:
    ld   A, [BC]                                       ;; 23:42fa $0a
    inc  BC                                            ;; 23:42fb $03
    jp   .jp_23_4392                                   ;; 23:42fc $c3 $92 $43
.jr_23_42ff:
    ld   DE, data_23_43ce_NoteFrequencies                              ;; 23:42ff $11 $ce $43
    add  A, E                                          ;; 23:4302 $83
    ld   E, A                                          ;; 23:4303 $5f
    jr   NC, .jr_23_4307                               ;; 23:4304 $30 $01
    inc  D                                             ;; 23:4306 $14
.jr_23_4307:
    ld   A, [DE]                                       ;; 23:4307 $1a
    ld   [wDFBD_Audio_FreqLo], A                                    ;; 23:4308 $ea $bd $df
    inc  DE                                            ;; 23:430b $13
    ld   A, [DE]                                       ;; 23:430c $1a
    ld   [wDFBE_Audio_FreqHi], A                                    ;; 23:430d $ea $be $df
    ld   DE, wDFF6_Audio_ChannelFreqShadow                                     ;; 23:4310 $11 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 23:4313 $fa $fe $df
    sla  A                                             ;; 23:4316 $cb $27
    add  A, E                                          ;; 23:4318 $83
    ld   E, A                                          ;; 23:4319 $5f
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 23:431a $fa $bd $df
    ld   [DE], A                                       ;; 23:431d $12
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 23:431e $fa $be $df
    or   A, $80                                        ;; 23:4321 $f6 $80
    ld   [DE], A                                       ;; 23:4323 $12
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 23:4324 $fa $d1 $df
    cp   A, $01                                        ;; 23:4327 $fe $01
    jr   Z, .jr_23_4335                                ;; 23:4329 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:432b $fa $cf $df
    ld   E, A                                          ;; 23:432e $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:432f $fa $c1 $df
    and  A, E                                          ;; 23:4332 $a3
    jr   NZ, .jr_23_4390                               ;; 23:4333 $20 $5b
.jr_23_4335:
    ld   A, [wDFC0_Audio_ChannelIndexFromMask]                                    ;; 23:4335 $fa $c0 $df
    ld   DE, data_23_43c6_ChannelFreqLoReg                              ;; 23:4338 $11 $c6 $43
    add  A, E                                          ;; 23:433b $83
    ld   E, A                                          ;; 23:433c $5f
    jr   NC, .jr_23_4340                               ;; 23:433d $30 $01
    inc  D                                             ;; 23:433f $14
.jr_23_4340:
    ld   A, [DE]                                       ;; 23:4340 $1a
    ld   E, A                                          ;; 23:4341 $5f
    ld   D, $ff                                        ;; 23:4342 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4344 $fa $c1 $df
    cp   A, $08                                        ;; 23:4347 $fe $08
    jr   NZ, .jr_23_4357                               ;; 23:4349 $20 $0c
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 23:434b $fa $be $df
    or   A, $80                                        ;; 23:434e $f6 $80
    ld   [DE], A                                       ;; 23:4350 $12
    ldh  A, [rNR42]                                    ;; 23:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 23:4353 $e0 $21
    jr   .jp_23_4369                                   ;; 23:4355 $18 $12
.jr_23_4357:
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 23:4357 $fa $bd $df
    ld   [DE], A                                       ;; 23:435a $12
    inc  DE                                            ;; 23:435b $13
    push DE                                            ;; 23:435c $d5
    ld   A, [DE]                                       ;; 23:435d $1a
    and  A, $c0                                        ;; 23:435e $e6 $c0
    ld   D, A                                          ;; 23:4360 $57
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 23:4361 $fa $be $df
    or   A, $80                                        ;; 23:4364 $f6 $80
    or   A, D                                          ;; 23:4366 $b2
    pop  DE                                            ;; 23:4367 $d1
    ld   [DE], A                                       ;; 23:4368 $12
.jp_23_4369:
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 23:4369 $fa $d1 $df
    cp   A, $02                                        ;; 23:436c $fe $02
    jr   NZ, .jr_23_4376                               ;; 23:436e $20 $06
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 23:4370 $fa $cf $df
    and  A, E                                          ;; 23:4373 $a3
    jr   NZ, .jr_23_4390                               ;; 23:4374 $20 $1a
.jr_23_4376:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4376 $fa $c1 $df
    ld   E, A                                          ;; 23:4379 $5f
    ldh  A, [rNR52]                                    ;; 23:437a $f0 $26
    and  A, $8f                                        ;; 23:437c $e6 $8f
    or   A, E                                          ;; 23:437e $b3
    ldh  [rNR52], A                                    ;; 23:437f $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 23:4381 $fa $c1 $df
    cp   A, $04                                        ;; 23:4384 $fe $04
    jr   NZ, .jr_23_4390                               ;; 23:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 23:4388 $f0 $1a
    and  A, $80                                        ;; 23:438a $e6 $80
    or   A, $80                                        ;; 23:438c $f6 $80
    ldh  [rNR30], A                                    ;; 23:438e $e0 $1a
.jr_23_4390:
    ld   A, [BC]                                       ;; 23:4390 $0a
    inc  BC                                            ;; 23:4391 $03
.jp_23_4392:
    ld   [HL], B                                       ;; 23:4392 $70
    dec  HL                                            ;; 23:4393 $2b
    ld   [HL], C                                       ;; 23:4394 $71
    ret                                                ;; 23:4395 $c9
    
    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 23:4396 ????????

data_23_439e_ChannelSaveRegs:
; Which registers to preserve when a sound effect takes a channel off the music, and
; with what mask. Five (register low byte, mask) pairs per channel, $00 terminating a
; channel's list early - so a channel is at most five registers and pulse 1, with its
; sweep, is the only one that needs four.
;
; The masks drop the bits that must not be replayed: the trigger and length-enable bits
; of NRx4 ($C7 keeps only the frequency high bits), the unused top bits of the length
; registers. Restoring a trigger bit would restart the note instead of resuming it
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 23:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 23:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 23:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 23:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 23:43be ????????

data_23_43c6_ChannelFreqLoReg:
; Channel bit -> that channel's frequency-low register, indexed by
; wDFC1_Audio_CurrentChannelBit minus 1. Only entries 0, 1, 3 and 7 are ever reached,
; which is why the table looks sparse: bits $01, $02, $04 and $08 give indices 0, 1, 3
; and 7. The noise channel's entry is rNR43, which is a polynomial counter rather than
; a frequency, and the interpreter special-cases it
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 23:43c6 ????????

data_23_43ce_NoteFrequencies:
; The pitch table: 73 little-endian 11-bit values, indexed by note number doubled.
; Entry 0 is silence and the rest climb to $07DF, the highest frequency the hardware
; will take. A sequence's note byte is an index into this - AUDIO_NOTE_LAST is the
; last real entry, and AUDIO_NOTE_SUSTAIN sits one past the end as a marker rather
; than a pitch
    db   $00, $00, $2c, $00, $9c, $00, $06, $01        ;; 23:43ce ????????
    db   $6b, $01, $c9, $01, $23, $02, $77, $02        ;; 23:43d6 ????????
    db   $c6, $02, $12, $03, $56, $03, $9b, $03        ;; 23:43de ????????
    db   $da, $03, $16, $04, $4e, $04, $83, $04        ;; 23:43e6 ????????
    db   $b5, $04, $e5, $04, $11, $05, $3b, $05        ;; 23:43ee ????????
    db   $63, $05, $89, $05, $ac, $05, $ce, $05        ;; 23:43f6 ????????
    db   $ed, $05, $0a, $06, $27, $06, $42, $06        ;; 23:43fe ????????
    db   $5b, $06, $72, $06, $89, $06, $9e, $06        ;; 23:4406 ????????
    db   $b2, $06, $c4, $06, $d6, $06, $e7, $06        ;; 23:440e ????????
    db   $f7, $06, $06, $07, $14, $07, $21, $07        ;; 23:4416 ????????
    db   $2d, $07, $39, $07, $44, $07, $4f, $07        ;; 23:441e ????????
    db   $59, $07, $62, $07, $6b, $07, $73, $07        ;; 23:4426 ????????
    db   $7b, $07, $83, $07, $8a, $07, $90, $07        ;; 23:442e ????????
    db   $97, $07, $9d, $07, $a2, $07, $a7, $07        ;; 23:4436 ????????
    db   $ac, $07, $b1, $07, $b6, $07, $ba, $07        ;; 23:443e ????????
    db   $be, $07, $c1, $07, $c4, $07, $c8, $07        ;; 23:4446 ????????
    db   $cb, $07, $ce, $07, $d1, $07, $d4, $07        ;; 23:444e ????????
    db   $d6, $07, $d9, $07, $db, $07, $dd, $07        ;; 23:4456 ????????
    db   $df, $07                                      ;; 23:445e ??

data_23_4460_TrackPointerTables:
; Where every track in this bank starts. Two lists of self-relative words - each entry
; is the distance from itself to its own target - so the whole block is position
; independent and could be assembled anywhere.
;
; The first word is not a track: it locates the sfx list, and the music list fills
; everything between that word and there.
;
; 8 music tracks - 2 songs of four - followed by 66 sound effects. The sfx are
; byte-identical to bank $21's in every bank that has them, so the INCBINs below
; point at one shared set of files rather than a copy per bank
    dw   .sfx_list - @                               ; where the sfx half starts

.music_list:
    dw   audio_23_44f6_Music_MediaDimension_Ch1 - @    ; MUSIC_MEDIA_DIMENSION ch1
    dw   audio_23_47e2_Music_MediaDimension_Ch2 - @    ; MUSIC_MEDIA_DIMENSION ch2
    dw   audio_23_4a1e_Music_MediaDimension_Ch3 - @    ; MUSIC_MEDIA_DIMENSION ch3
    dw   audio_23_4e89_Music_MediaDimension_Ch4 - @    ; MUSIC_MEDIA_DIMENSION ch4
    dw   audio_23_54d3_Music_ToonTv_Ch1 - @            ; MUSIC_TOON_TV ch1
    dw   audio_23_5ae7_Music_ToonTv_Ch2 - @            ; MUSIC_TOON_TV ch2
    dw   audio_23_6113_Music_ToonTv_Ch3 - @            ; MUSIC_TOON_TV ch3
    dw   audio_23_632a_Music_ToonTv_Ch4 - @            ; MUSIC_TOON_TV ch4

.sfx_list:
    dw   audio_23_65d0_Sfx_Empty - @                   ; SFX_EMPTY (sfx $00)
    dw   audio_23_65e4_Sfx_01 - @                      ; SFX_01 (sfx $01)
    dw   audio_23_6602_Sfx_TvSmash - @                 ; SFX_TV_SMASH (sfx $02)
    dw   audio_23_662c_Sfx_SilverRemote - @            ; SFX_SILVER_REMOTE (sfx $03)
    dw   audio_23_666e_Sfx_GoldRemote - @              ; SFX_GOLD_REMOTE (sfx $04)
    dw   audio_23_66d6_Sfx_05 - @                      ; SFX_05 (sfx $05)
    dw   audio_23_66e4_Sfx_Collectible - @             ; SFX_COLLECTIBLE (sfx $06)
    dw   audio_23_6720_Sfx_07 - @                      ; SFX_07 (sfx $07)
    dw   audio_23_672e_Sfx_08 - @                      ; SFX_08 (sfx $08)
    dw   audio_23_673c_Sfx_09 - @                      ; SFX_09 (sfx $09)
    dw   audio_23_6752_Sfx_0a - @                      ; SFX_0A (sfx $0A)
    dw   audio_23_6766_Sfx_0b - @                      ; SFX_0B (sfx $0B)
    dw   audio_23_6788_Sfx_GexJump - @                 ; SFX_GEX_JUMP (sfx $0C)
    dw   audio_23_67b2_Sfx_GexDoubleJump - @           ; SFX_GEX_DOUBLE_JUMP (sfx $0D)
    dw   audio_23_6810_Sfx_GexCollapse - @             ; SFX_GEX_COLLAPSE (sfx $0E)
    dw   audio_23_6828_Sfx_GexDeath - @                ; SFX_GEX_DEATH (sfx $0F)
    dw   audio_23_6880_Sfx_GexHurt - @                 ; SFX_GEX_HURT (sfx $10)
    dw   audio_23_68cc_Sfx_GexSpawn - @                ; SFX_GEX_SPAWN (sfx $11)
    dw   audio_23_6a7a_Sfx_GexHitBounce - @            ; SFX_GEX_HIT_BOUNCE (sfx $12)
    dw   audio_23_6a9e_Sfx_13 - @                      ; SFX_13 (sfx $13)
    dw   audio_23_6af4_Sfx_GexPowerupActive - @ ; SFX_GEX_POWERUP_ACTIVE (sfx $14)
    dw   audio_23_6b22_Sfx_GexPowerupExpired - @   ; SFX_GEX_POWERUP_EXPIRED (sfx $15)
    dw   audio_23_6b50_Sfx_16 - @                      ; SFX_16 (sfx $16)
    dw   audio_23_6b64_Sfx_EnemyDefeated - @           ; SFX_ENEMY_DEFEATED (sfx $17)
    dw   audio_23_6b7c_Sfx_18 - @                      ; SFX_18 (sfx $18)
    dw   audio_23_6b8e_Sfx_HardHeadAreaHazard - @      ; SFX_HARD_HEAD_AREA_HAZARD (sfx $19)
    dw   audio_23_6b9c_Sfx_FallingHazard - @           ; SFX_FALLING_HAZARD (sfx $1A)
    dw   audio_23_6bb2_Sfx_1b - @                      ; SFX_1B (sfx $1B)
    dw   audio_23_6bc8_Sfx_Unused1C - @                ; driver sfx id $1C - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_6bd2_Sfx_FlowerHammer - @            ; SFX_FLOWER_HAMMER (sfx $1C)
    dw   audio_23_6be8_Sfx_Bumblebee - @               ; SFX_BUMBLEBEE (sfx $1D)
    dw   audio_23_6c1c_Sfx_Rocket - @                  ; SFX_ROCKET (sfx $1E)
    dw   audio_23_6c2c_Sfx_1f - @                      ; SFX_1F (sfx $1F)
    dw   audio_23_6c70_Sfx_Hunter - @                  ; SFX_HUNTER (sfx $20)
    dw   audio_23_6c80_Sfx_21 - @                      ; SFX_21 (sfx $21)
    dw   audio_23_6cbc_Sfx_22 - @                      ; SFX_22 (sfx $22)
    dw   audio_23_6ccc_Sfx_23 - @                      ; SFX_23 (sfx $23)
    dw   audio_23_6ce4_Sfx_Unused25 - @                ; driver sfx id $25 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_6cec_Sfx_EnemyJump - @               ; SFX_ENEMY_JUMP (sfx $24)
    dw   audio_23_6d14_Sfx_25 - @                      ; SFX_25 (sfx $25)
    dw   audio_23_6d26_Sfx_Unused28 - @                ; driver sfx id $28 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_6d2e_Sfx_26 - @                      ; SFX_26 (sfx $26)
    dw   audio_23_6d3e_Sfx_FallingPlatform - @         ; SFX_FALLING_PLATFORM (sfx $27)
    dw   audio_23_6d50_Sfx_28 - @                      ; SFX_28 (sfx $28)
    dw   audio_23_6d90_Sfx_AltEnemyJump - @            ; SFX_ALT_ENEMY_JUMP (sfx $29)
    dw   audio_23_6db8_Sfx_GexPoweredJump - @          ; SFX_GEX_POWERED_JUMP (sfx $2A)
    dw   audio_23_6dca_Sfx_PoweredWalkway - @          ; SFX_POWERED_WALKWAY (sfx $2B)
    dw   audio_23_6e12_Sfx_CannonRotate - @            ; SFX_CANNON_ROTATE (sfx $2C)
    dw   audio_23_6e3e_Sfx_Jar - @                     ; SFX_JAR (sfx $2D)
    dw   audio_23_6e54_Sfx_2e - @                      ; SFX_2E (sfx $2E)
    dw   audio_23_6e6a_Sfx_Unused32 - @                ; driver sfx id $32 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_6e76_Sfx_Dragon - @                  ; SFX_DRAGON (sfx $2F)
    dw   audio_23_6eaa_Sfx_Cannon - @                  ; SFX_CANNON (sfx $30)
    dw   audio_23_6ed4_Sfx_FallingBoulder - @          ; SFX_FALLING_BOULDER (sfx $31)
    dw   audio_23_6f08_Sfx_32 - @                      ; SFX_32 (sfx $32)
    dw   audio_23_6f20_Sfx_Pterosaur - @               ; SFX_PTEROSAUR (sfx $33)
    dw   audio_23_6f4e_Sfx_MultiProjectile - @         ; SFX_MULTI_PROJECTILE (sfx $34)
    dw   audio_23_6f5e_Sfx_Gear - @                    ; SFX_GEAR (sfx $35)
    dw   audio_23_6f8a_Sfx_GunProjectile - @           ; SFX_GUN_PROJECTILE (sfx $36)
    dw   audio_23_6f9a_Sfx_Explosion - @               ; SFX_EXPLOSION (sfx $37)
    dw   audio_23_6ff2_Sfx_RezHurt - @                 ; SFX_REZ_HURT (sfx $38)
    dw   audio_23_7008_Sfx_RezButton - @               ; SFX_REZ_BUTTON (sfx $39)
    dw   audio_23_701e_Sfx_Unused3E - @                ; driver sfx id $3E - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_7022_Sfx_Unused3F - @                ; driver sfx id $3F - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_7026_Sfx_Unused40 - @                ; driver sfx id $40 - no .data_00_116c_SFXChannelTable row reaches it
    dw   audio_23_702a_Sfx_Unused41 - @                ; driver sfx id $41 - no .data_00_116c_SFXChannelTable row reaches it

audio_23_44f6_Music_MediaDimension_Ch1:
    INCBIN "data/audio/music/music_media_dimension_ch1.bin" ; MUSIC_MEDIA_DIMENSION ch1
audio_23_47e2_Music_MediaDimension_Ch2:
    INCBIN "data/audio/music/music_media_dimension_ch2.bin" ; MUSIC_MEDIA_DIMENSION ch2
audio_23_4a1e_Music_MediaDimension_Ch3:
    INCBIN "data/audio/music/music_media_dimension_ch3.bin" ; MUSIC_MEDIA_DIMENSION ch3
audio_23_4e89_Music_MediaDimension_Ch4:
    INCBIN "data/audio/music/music_media_dimension_ch4.bin" ; MUSIC_MEDIA_DIMENSION ch4
audio_23_54d3_Music_ToonTv_Ch1:
    INCBIN "data/audio/music/music_toon_tv_ch1.bin" ; MUSIC_TOON_TV ch1
audio_23_5ae7_Music_ToonTv_Ch2:
    INCBIN "data/audio/music/music_toon_tv_ch2.bin" ; MUSIC_TOON_TV ch2
audio_23_6113_Music_ToonTv_Ch3:
    INCBIN "data/audio/music/music_toon_tv_ch3.bin" ; MUSIC_TOON_TV ch3
audio_23_632a_Music_ToonTv_Ch4:
    INCBIN "data/audio/music/music_toon_tv_ch4.bin" ; MUSIC_TOON_TV ch4
audio_23_65d0_Sfx_Empty:
    INCBIN "data/audio/sfx/sfx_empty.bin"           ; SFX_EMPTY (sfx $00)
audio_23_65e4_Sfx_01:
    INCBIN "data/audio/sfx/sfx_01.bin"              ; SFX_01 (sfx $01)
audio_23_6602_Sfx_TvSmash:
    INCBIN "data/audio/sfx/sfx_tv_smash.bin"        ; SFX_TV_SMASH (sfx $02)
audio_23_662c_Sfx_SilverRemote:
    INCBIN "data/audio/sfx/sfx_silver_remote.bin"   ; SFX_SILVER_REMOTE (sfx $03)
audio_23_666e_Sfx_GoldRemote:
    INCBIN "data/audio/sfx/sfx_gold_remote.bin"     ; SFX_GOLD_REMOTE (sfx $04)
audio_23_66d6_Sfx_05:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_05 (sfx $05)
audio_23_66e4_Sfx_Collectible:
    INCBIN "data/audio/sfx/sfx_collectible.bin"     ; SFX_COLLECTIBLE (sfx $06)
audio_23_6720_Sfx_07:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_07 (sfx $07)
audio_23_672e_Sfx_08:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_08 (sfx $08)
audio_23_673c_Sfx_09:
    INCBIN "data/audio/sfx/sfx_09.bin"              ; SFX_09 (sfx $09)
audio_23_6752_Sfx_0a:
    INCBIN "data/audio/sfx/sfx_0a.bin"              ; SFX_0A (sfx $0A)
audio_23_6766_Sfx_0b:
    INCBIN "data/audio/sfx/sfx_0b.bin"              ; SFX_0B (sfx $0B)
audio_23_6788_Sfx_GexJump:
    INCBIN "data/audio/sfx/sfx_gex_jump.bin"        ; SFX_GEX_JUMP (sfx $0C)
audio_23_67b2_Sfx_GexDoubleJump:
    INCBIN "data/audio/sfx/sfx_gex_double_jump.bin" ; SFX_GEX_DOUBLE_JUMP (sfx $0D)
audio_23_6810_Sfx_GexCollapse:
    INCBIN "data/audio/sfx/sfx_gex_collapse.bin"    ; SFX_GEX_COLLAPSE (sfx $0E)
audio_23_6828_Sfx_GexDeath:
    INCBIN "data/audio/sfx/sfx_gex_death.bin"       ; SFX_GEX_DEATH (sfx $0F)
audio_23_6880_Sfx_GexHurt:
    INCBIN "data/audio/sfx/sfx_gex_hurt.bin"        ; SFX_GEX_HURT (sfx $10)
audio_23_68cc_Sfx_GexSpawn:
    INCBIN "data/audio/sfx/sfx_gex_spawn.bin"       ; SFX_GEX_SPAWN (sfx $11)
audio_23_6a7a_Sfx_GexHitBounce:
    INCBIN "data/audio/sfx/sfx_gex_hit_bounce.bin"  ; SFX_GEX_HIT_BOUNCE (sfx $12)
audio_23_6a9e_Sfx_13:
    INCBIN "data/audio/sfx/sfx_13.bin"              ; SFX_13 (sfx $13)
audio_23_6af4_Sfx_GexPowerupActive:
    INCBIN "data/audio/sfx/sfx_gex_powerup_active.bin"  ; SFX_GEX_POWERUP_ACTIVE (sfx $14)
audio_23_6b22_Sfx_GexPowerupExpired:
    INCBIN "data/audio/sfx/sfx_gex_powerup_expired.bin" ; SFX_GEX_POWERUP_EXPIRED (sfx $15)
audio_23_6b50_Sfx_16:
    INCBIN "data/audio/sfx/sfx_16.bin"              ; SFX_16 (sfx $16)
audio_23_6b64_Sfx_EnemyDefeated:
    INCBIN "data/audio/sfx/sfx_enemy_defeated.bin"  ; SFX_ENEMY_DEFEATED (sfx $17)
audio_23_6b7c_Sfx_18:
    INCBIN "data/audio/sfx/sfx_18.bin"              ; SFX_18 (sfx $18)
audio_23_6b8e_Sfx_HardHeadAreaHazard:
    INCBIN "data/audio/sfx/sfx_05.bin"              ; SFX_HARD_HEAD_AREA_HAZARD (sfx $19)
audio_23_6b9c_Sfx_FallingHazard:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_FALLING_HAZARD (sfx $1A)
audio_23_6bb2_Sfx_1b:
    INCBIN "data/audio/sfx/sfx_1b.bin"              ; SFX_1B (sfx $1B)
audio_23_6bc8_Sfx_Unused1C:
    INCBIN "data/audio/sfx/sfx_unused_1c.bin"       ; driver sfx id $1C - no .data_00_116c_SFXChannelTable row reaches it
audio_23_6bd2_Sfx_FlowerHammer:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_FLOWER_HAMMER (sfx $1C)
audio_23_6be8_Sfx_Bumblebee:
    INCBIN "data/audio/sfx/sfx_bumblebee.bin"       ; SFX_BUMBLEBEE (sfx $1D)
audio_23_6c1c_Sfx_Rocket:
    INCBIN "data/audio/sfx/sfx_shoot.bin"           ; SFX_ROCKET (sfx $1E)
audio_23_6c2c_Sfx_1f:
    INCBIN "data/audio/sfx/sfx_1f.bin"              ; SFX_1F (sfx $1F)
audio_23_6c70_Sfx_Hunter:
    INCBIN "data/audio/sfx/sfx_shoot.bin"           ; SFX_HUNTER (sfx $20)
audio_23_6c80_Sfx_21:
    INCBIN "data/audio/sfx/sfx_21.bin"              ; SFX_21 (sfx $21)
audio_23_6cbc_Sfx_22:
    INCBIN "data/audio/sfx/sfx_22.bin"              ; SFX_22 (sfx $22)
audio_23_6ccc_Sfx_23:
    INCBIN "data/audio/sfx/sfx_23.bin"              ; SFX_23 (sfx $23)
audio_23_6ce4_Sfx_Unused25:
    INCBIN "data/audio/sfx/sfx_unused_25.bin"       ; driver sfx id $25 - no .data_00_116c_SFXChannelTable row reaches it
audio_23_6cec_Sfx_EnemyJump:
    INCBIN "data/audio/sfx/sfx_enemy_jump.bin"      ; SFX_ENEMY_JUMP (sfx $24)
audio_23_6d14_Sfx_25:
    INCBIN "data/audio/sfx/sfx_25.bin"              ; SFX_25 (sfx $25)
audio_23_6d26_Sfx_Unused28:
    INCBIN "data/audio/sfx/sfx_unused_25.bin"       ; driver sfx id $28 - no .data_00_116c_SFXChannelTable row reaches it
audio_23_6d2e_Sfx_26:
    INCBIN "data/audio/sfx/sfx_26.bin"              ; SFX_26 (sfx $26)
audio_23_6d3e_Sfx_FallingPlatform:
    INCBIN "data/audio/sfx/sfx_falling_platform.bin" ; SFX_FALLING_PLATFORM (sfx $27)
audio_23_6d50_Sfx_28:
    INCBIN "data/audio/sfx/sfx_28.bin"              ; SFX_28 (sfx $28)
audio_23_6d90_Sfx_AltEnemyJump:
    INCBIN "data/audio/sfx/sfx_enemy_jump.bin"      ; SFX_ALT_ENEMY_JUMP (sfx $29)
audio_23_6db8_Sfx_GexPoweredJump:
    INCBIN "data/audio/sfx/sfx_gex_powered_jump.bin"; SFX_GEX_POWERED_JUMP (sfx $2A)
audio_23_6dca_Sfx_PoweredWalkway:
    INCBIN "data/audio/sfx/sfx_powered_walkway.bin" ; SFX_POWERED_WALKWAY (sfx $2B)
audio_23_6e12_Sfx_CannonRotate:
    INCBIN "data/audio/sfx/sfx_cannon_rotate.bin"   ; SFX_CANNON_ROTATE (sfx $2C)
audio_23_6e3e_Sfx_Jar:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_JAR (sfx $2D)
audio_23_6e54_Sfx_2e:
    INCBIN "data/audio/sfx/sfx_2e.bin"              ; SFX_2E (sfx $2E)
audio_23_6e6a_Sfx_Unused32:
    INCBIN "data/audio/sfx/sfx_unused_32.bin"       ; driver sfx id $32 - no .data_00_116c_SFXChannelTable row reaches it
audio_23_6e76_Sfx_Dragon:
    INCBIN "data/audio/sfx/sfx_bumblebee.bin"       ; SFX_DRAGON (sfx $2F)
audio_23_6eaa_Sfx_Cannon:
    INCBIN "data/audio/sfx/sfx_gex_jump.bin"        ; SFX_CANNON (sfx $30)
audio_23_6ed4_Sfx_FallingBoulder:
    INCBIN "data/audio/sfx/sfx_falling_boulder.bin" ; SFX_FALLING_BOULDER (sfx $31)
audio_23_6f08_Sfx_32:
    INCBIN "data/audio/sfx/sfx_32.bin"              ; SFX_32 (sfx $32)
audio_23_6f20_Sfx_Pterosaur:
    INCBIN "data/audio/sfx/sfx_pterosaur.bin"       ; SFX_PTEROSAUR (sfx $33)
audio_23_6f4e_Sfx_MultiProjectile:
    INCBIN "data/audio/sfx/sfx_multi_projectile.bin" ; SFX_MULTI_PROJECTILE (sfx $34)
audio_23_6f5e_Sfx_Gear:
    INCBIN "data/audio/sfx/sfx_cannon_rotate.bin"   ; SFX_GEAR (sfx $35)
audio_23_6f8a_Sfx_GunProjectile:
    INCBIN "data/audio/sfx/sfx_shoot.bin"           ; SFX_GUN_PROJECTILE (sfx $36)
audio_23_6f9a_Sfx_Explosion:
    INCBIN "data/audio/sfx/sfx_explosion.bin"       ; SFX_EXPLOSION (sfx $37)
audio_23_6ff2_Sfx_RezHurt:
    INCBIN "data/audio/sfx/sfx_falling_hazard.bin"  ; SFX_REZ_HURT (sfx $38)
audio_23_7008_Sfx_RezButton:
    INCBIN "data/audio/sfx/sfx_rez_button.bin"      ; SFX_REZ_BUTTON (sfx $39)
audio_23_701e_Sfx_Unused3E:
    INCBIN "data/audio/sfx/sfx_unused_3e.bin"       ; driver sfx id $3E - no .data_00_116c_SFXChannelTable row reaches it
audio_23_7022_Sfx_Unused3F:
    INCBIN "data/audio/sfx/sfx_unused_3f.bin"       ; driver sfx id $3F - no .data_00_116c_SFXChannelTable row reaches it
audio_23_7026_Sfx_Unused40:
    INCBIN "data/audio/sfx/sfx_unused_40.bin"       ; driver sfx id $40 - no .data_00_116c_SFXChannelTable row reaches it
audio_23_702a_Sfx_Unused41:
    INCBIN "data/audio/sfx/sfx_unused_41.bin"       ; driver sfx id $41 - no .data_00_116c_SFXChannelTable row reaches it
