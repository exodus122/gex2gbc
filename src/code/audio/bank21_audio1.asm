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
; wDFE6_Audio_SavedWaveRam. data_21_439e_ChannelSaveRegs is the list of which
; registers are worth saving per channel.
;
; A SEQUENCE is a byte stream walked by Audio_RunSequence, which runs commands until
; it hits a note and then returns that note's duration - the caller stores it as the
; channel's countdown and comes back when it expires. So one call advances one channel
; by one note, however many register writes are in front of it. See the AUDIO_CMD_*
; and AUDIO_NOTE_* constants for the opcode map.
;
; THE TRACK TABLES at data_21_4460_TrackPointerTables are two lists of self-relative
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

SECTION "bank21", ROMX[$4000], BANK[$21]

call_21_4000_Audio_Init:
; Boot-time reset. Points wDFAE_AudioBankDataPointer at this bank's track tables,
; clears every channel mask, both sets of duration counters and rNR51, then wipes the
; 20-byte music register save area and the 16-byte wave RAM save area. It does not
; touch rNR52, so the APU is left however the caller had it
    ld   HL, data_21_4460_TrackPointerTables                              ;; 21:4000 $21 $60 $44
    ld   A, L                                          ;; 21:4003 $7d
    ld   [wDFAE_AudioBankDataPointer], A                                    ;; 21:4004 $ea $ae $df
    ld   A, H                                          ;; 21:4007 $7c
    ld   [wDFAF_AudioBankDataPointer], A                                    ;; 21:4008 $ea $af $df
    xor  A, A                                          ;; 21:400b $af
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 21:400c $ea $c2 $df
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 21:400f $ea $c1 $df
    ldh  [rNR51], A                                    ;; 21:4012 $e0 $25
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 21:4014 $ea $b8 $df
    ld   [wDFB9_Audio_MusicTimerCh1], A                                    ;; 21:4017 $ea $b9 $df
    ld   [wDFBA_Audio_MusicTimerCh2], A                                    ;; 21:401a $ea $ba $df
    ld   [wDFBB_Audio_MusicTimerCh3], A                                    ;; 21:401d $ea $bb $df
    ld   [wDFBC_Audio_MusicTimerCh4], A                                    ;; 21:4020 $ea $bc $df
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 21:4023 $ea $cf $df
    ld   [wDFCB_Audio_SfxTimerCh1], A                                    ;; 21:4026 $ea $cb $df
    ld   [wDFCC_Audio_SfxTimerCh2], A                                    ;; 21:4029 $ea $cc $df
    ld   [wDFCD_Audio_SfxTimerCh3], A                                    ;; 21:402c $ea $cd $df
    ld   [wDFCE_Audio_SfxTimerCh4], A                                    ;; 21:402f $ea $ce $df
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 21:4032 $21 $d2 $df
    ld   C, $14                                        ;; 21:4035 $0e $14
    xor  A, A                                          ;; 21:4037 $af
jr_21_4038:
    ld   [HL+], A                                      ;; 21:4038 $22
    dec  C                                             ;; 21:4039 $0d
    jr   NZ, jr_21_4038                                ;; 21:403a $20 $fc
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 21:403c $21 $e6 $df
    ld   C, $10                                        ;; 21:403f $0e $10
    xor  A, A                                          ;; 21:4041 $af
.jr_21_4042:
    ld   [HL+], A                                      ;; 21:4042 $22
    dec  C                                             ;; 21:4043 $0d
    jr   NZ, .jr_21_4042                               ;; 21:4044 $20 $fc
    ret                                                ;; 21:4046 $c9

call_21_4047_Audio_PlaySfx:
; Start sound effect id A.
;
; Before anything is queued this snapshots the hardware state of the channels the
; effect is about to take: data_21_439e_ChannelSaveRegs lists five (register, mask)
; pairs per channel, and each register is read, masked and written into that channel's
; slot of wDFD2_Audio_SavedMusicRegs. The mask keeps only the bits worth restoring -
; the length counters and trigger bits are deliberately dropped.
;
; It then follows the first word of the track table block, which is the offset to the
; sfx list, and falls into the shared start-up path below with
; wDFD1_Audio_RequestKind = AUDIO_REQUEST_SFX
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 21:4047 $ea $d0 $df
    ld   A, $01                                        ;; 21:404a $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 21:404c $ea $d1 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 21:404f $fa $d0 $df
    sla  A                                             ;; 21:4052 $cb $27
    ld   E, A                                          ;; 21:4054 $5f
    sla  A                                             ;; 21:4055 $cb $27
    ld   C, A                                          ;; 21:4057 $4f
    sla  A                                             ;; 21:4058 $cb $27
    add  A, E                                          ;; 21:405a $83
    ld   DE, data_21_439e_ChannelSaveRegs                              ;; 21:405b $11 $9e $43
    add  A, E                                          ;; 21:405e $83
    ld   E, A                                          ;; 21:405f $5f
    jr   NC, .jr_21_4063                               ;; 21:4060 $30 $01
    inc  D                                             ;; 21:4062 $14
.jr_21_4063:
    ld   HL, wDFD2_Audio_SavedMusicRegs                                     ;; 21:4063 $21 $d2 $df
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 21:4066 $fa $d0 $df
    add  A, C                                          ;; 21:4069 $81
    add  A, L                                          ;; 21:406a $85
    ld   L, A                                          ;; 21:406b $6f
    jr   NC, .jr_21_406f                               ;; 21:406c $30 $01
    inc  H                                             ;; 21:406e $24
.jr_21_406f:
    ld   B, $ff                                        ;; 21:406f $06 $ff
.jr_21_4071:
    ld   A, [DE]                                       ;; 21:4071 $1a
    and  A, A                                          ;; 21:4072 $a7
    jr   Z, .jr_21_407f                                ;; 21:4073 $28 $0a
    inc  DE                                            ;; 21:4075 $13
    ld   C, A                                          ;; 21:4076 $4f
    ld   A, [BC]                                       ;; 21:4077 $0a
    ld   C, A                                          ;; 21:4078 $4f
    ld   A, [DE]                                       ;; 21:4079 $1a
    inc  DE                                            ;; 21:407a $13
    and  A, C                                          ;; 21:407b $a1
    ld   [HL+], A                                      ;; 21:407c $22
    jr   .jr_21_4071                                   ;; 21:407d $18 $f2
.jr_21_407f:
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 21:407f $fa $ae $df
    ld   E, A                                          ;; 21:4082 $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 21:4083 $fa $af $df
    ld   D, A                                          ;; 21:4086 $57
    ld   A, [DE]                                       ;; 21:4087 $1a
    add  A, E                                          ;; 21:4088 $83
    ld   L, A                                          ;; 21:4089 $6f
    inc  DE                                            ;; 21:408a $13
    ld   A, [DE]                                       ;; 21:408b $1a
    dec  DE                                            ;; 21:408c $1b
    adc  A, D                                          ;; 21:408d $8a
    ld   D, A                                          ;; 21:408e $57
    ld   E, L                                          ;; 21:408f $5d
    jr   jr_21_40a4_Audio_StartTrack                                    ;; 21:4090 $18 $12

call_21_4092_Audio_PlayMusic:
; Start music track id A. No state is saved, because music is what gets interrupted
; rather than what does the interrupting; the music list begins two bytes into the
; track table block, immediately after the word that locates the sfx list
    ld   [wDFD0_Audio_RequestedTrackId], A                                    ;; 21:4092 $ea $d0 $df
    ld   A, $02                                        ;; 21:4095 $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 21:4097 $ea $d1 $df
    ld   A, [wDFAE_AudioBankDataPointer]                                    ;; 21:409a $fa $ae $df
    ld   E, A                                          ;; 21:409d $5f
    ld   A, [wDFAF_AudioBankDataPointer]                                    ;; 21:409e $fa $af $df
    ld   D, A                                          ;; 21:40a1 $57
    inc  DE                                            ;; 21:40a2 $13
    inc  DE                                            ;; 21:40a3 $13

jr_21_40a4_Audio_StartTrack:
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
    ld   A, [wDFD0_Audio_RequestedTrackId]                                    ;; 21:40a4 $fa $d0 $df
    add  A, A                                          ;; 21:40a7 $87
    ld   L, A                                          ;; 21:40a8 $6f
    ld   A, D                                          ;; 21:40a9 $7a
    adc  A, $00                                        ;; 21:40aa $ce $00
    ld   D, A                                          ;; 21:40ac $57
    ld   A, E                                          ;; 21:40ad $7b
    add  A, L                                          ;; 21:40ae $85
    ld   E, A                                          ;; 21:40af $5f
    ld   A, D                                          ;; 21:40b0 $7a
    adc  A, $00                                        ;; 21:40b1 $ce $00
    ld   D, A                                          ;; 21:40b3 $57
    ld   A, [DE]                                       ;; 21:40b4 $1a
    add  A, E                                          ;; 21:40b5 $83
    ld   L, A                                          ;; 21:40b6 $6f
    inc  DE                                            ;; 21:40b7 $13
    ld   A, [DE]                                       ;; 21:40b8 $1a
    dec  DE                                            ;; 21:40b9 $1b
    adc  A, D                                          ;; 21:40ba $8a
    ld   D, A                                          ;; 21:40bb $57
    ld   E, L                                          ;; 21:40bc $5d
    ld   A, [DE]                                       ;; 21:40bd $1a
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 21:40be $ea $fe $df
    ld   L, A                                          ;; 21:40c1 $6f
    xor  A, A                                          ;; 21:40c2 $af
    scf                                                ;; 21:40c3 $37
.jr_21_40c4:
    rl   A                                             ;; 21:40c4 $cb $17
    dec  L                                             ;; 21:40c6 $2d
    jr   NZ, .jr_21_40c4                               ;; 21:40c7 $20 $fb
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 21:40c9 $ea $c1 $df
    ld   L, A                                          ;; 21:40cc $6f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 21:40cd $fa $d1 $df
    cp   A, $01                                        ;; 21:40d0 $fe $01
    jr   NZ, .jr_21_40e3                               ;; 21:40d2 $20 $0f
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:40d4 $fa $cf $df
    or   A, L                                          ;; 21:40d7 $b5
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 21:40d8 $ea $cf $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 21:40db $21 $c3 $df
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 21:40de $01 $cb $df
    jr   .jr_21_40f0                                   ;; 21:40e1 $18 $0d
.jr_21_40e3:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 21:40e3 $fa $c2 $df
    or   A, L                                          ;; 21:40e6 $b5
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 21:40e7 $ea $c2 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 21:40ea $21 $b0 $df
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 21:40ed $01 $b9 $df
.jr_21_40f0:
    ld   A, [DE]                                       ;; 21:40f0 $1a
    dec  A                                             ;; 21:40f1 $3d
    sla  A                                             ;; 21:40f2 $cb $27
    add  A, L                                          ;; 21:40f4 $85
    ld   L, A                                          ;; 21:40f5 $6f
    jr   NC, .jr_21_40f9                               ;; 21:40f6 $30 $01
    inc  H                                             ;; 21:40f8 $24
.jr_21_40f9:
    ld   A, [DE]                                       ;; 21:40f9 $1a
    dec  A                                             ;; 21:40fa $3d
    add  A, C                                          ;; 21:40fb $81
    ld   C, A                                          ;; 21:40fc $4f
    jr   NC, .jr_21_4100                               ;; 21:40fd $30 $01
    inc  B                                             ;; 21:40ff $04
.jr_21_4100:
    inc  DE                                            ;; 21:4100 $13
    ld   [HL], E                                       ;; 21:4101 $73
    inc  HL                                            ;; 21:4102 $23
    ld   [HL], D                                       ;; 21:4103 $72
    dec  HL                                            ;; 21:4104 $2b
    push BC                                            ;; 21:4105 $c5
    call call_21_4199_Audio_RunSequence                                  ;; 21:4106 $cd $99 $41
    pop  BC                                            ;; 21:4109 $c1
    ld   [BC], A                                       ;; 21:410a $02
    ret                                                ;; 21:410b $c9

call_21_410c_Audio_Update:
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
    ld   BC, wDFB9_Audio_MusicTimerCh1                                     ;; 21:410c $01 $b9 $df
    ld   HL, wDFB0_Audio_MusicChannelPtrs                                     ;; 21:410f $21 $b0 $df
    ld   A, $01                                        ;; 21:4112 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 21:4114 $ea $c1 $df
    ld   A, $00                                        ;; 21:4117 $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 21:4119 $ea $b8 $df
    ld   A, $02                                        ;; 21:411c $3e $02
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 21:411e $ea $d1 $df
.jp_21_4121:
    push BC                                            ;; 21:4121 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4122 $fa $c1 $df
    ld   D, A                                          ;; 21:4125 $57
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 21:4126 $fa $c2 $df
    and  A, D                                          ;; 21:4129 $a2
    jr   Z, .jr_21_4139                                ;; 21:412a $28 $0d
    ld   A, [BC]                                       ;; 21:412c $0a
    dec  A                                             ;; 21:412d $3d
    jr   NZ, .jr_21_4139                               ;; 21:412e $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 21:4130 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 21:4133 $ea $fe $df
    call call_21_4199_Audio_RunSequence                                  ;; 21:4136 $cd $99 $41
.jr_21_4139:
    pop  BC                                            ;; 21:4139 $c1
    ld   [BC], A                                       ;; 21:413a $02
    inc  BC                                            ;; 21:413b $03
    inc  HL                                            ;; 21:413c $23
    inc  HL                                            ;; 21:413d $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:413e $fa $c1 $df
    sla  A                                             ;; 21:4141 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 21:4143 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 21:4146 $fa $b8 $df
    inc  A                                             ;; 21:4149 $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 21:414a $ea $b8 $df
    cp   A, $04                                        ;; 21:414d $fe $04
    jp   NZ, .jp_21_4121                               ;; 21:414f $c2 $21 $41
    ld   BC, wDFCB_Audio_SfxTimerCh1                                     ;; 21:4152 $01 $cb $df
    ld   HL, wDFC3_Audio_SfxChannelPtrs                                     ;; 21:4155 $21 $c3 $df
    ld   A, $01                                        ;; 21:4158 $3e $01
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 21:415a $ea $c1 $df
    ld   A, $00                                        ;; 21:415d $3e $00
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 21:415f $ea $b8 $df
    ld   A, $01                                        ;; 21:4162 $3e $01
    ld   [wDFD1_Audio_RequestKind], A                                    ;; 21:4164 $ea $d1 $df
.jp_21_4167:
    push BC                                            ;; 21:4167 $c5
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4168 $fa $c1 $df
    ld   D, A                                          ;; 21:416b $57
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:416c $fa $cf $df
    and  A, D                                          ;; 21:416f $a2
    jr   Z, .jr_21_417f                                ;; 21:4170 $28 $0d
    ld   A, [BC]                                       ;; 21:4172 $0a
    dec  A                                             ;; 21:4173 $3d
    jr   NZ, .jr_21_417f                               ;; 21:4174 $20 $09
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 21:4176 $fa $b8 $df
    ld   [wDFFE_Audio_CurrentChannel], A                                    ;; 21:4179 $ea $fe $df
    call call_21_4199_Audio_RunSequence                                  ;; 21:417c $cd $99 $41
.jr_21_417f:
    pop  BC                                            ;; 21:417f $c1
    ld   [BC], A                                       ;; 21:4180 $02
    inc  BC                                            ;; 21:4181 $03
    inc  HL                                            ;; 21:4182 $23
    inc  HL                                            ;; 21:4183 $23
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4184 $fa $c1 $df
    sla  A                                             ;; 21:4187 $cb $27
    ld   [wDFC1_Audio_CurrentChannelBit], A                                    ;; 21:4189 $ea $c1 $df
    ld   A, [wDFB8_Audio_ChannelIndex]                                    ;; 21:418c $fa $b8 $df
    inc  A                                             ;; 21:418f $3c
    ld   [wDFB8_Audio_ChannelIndex], A                                    ;; 21:4190 $ea $b8 $df
    cp   A, $04                                        ;; 21:4193 $fe $04
    jp   NZ, .jp_21_4167                               ;; 21:4195 $c2 $67 $41
    ret                                                ;; 21:4198 $c9

call_21_4199_Audio_RunSequence:
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
; A note indexes data_21_43ce_NoteFrequencies for an 11-bit frequency, writes it to the
; channel's frequency registers with the trigger bit set, and enables the channel in
; rNR52. AUDIO_NOTE_REST silences the channel instead, and AUDIO_NOTE_SUSTAIN
; retriggers it without touching the pitch. The byte after the note is its duration.
;
; While an sfx owns a channel the music's note writes are computed and stored to
; wDFF6_Audio_ChannelFreqShadow but kept out of the hardware registers, which is how
; the music stays in time underneath and reappears in the right place
    ld   C, [HL]                                       ;; 21:4199 $4e
    inc  HL                                            ;; 21:419a $23
    ld   B, [HL]                                       ;; 21:419b $46
.jp_21_419c:
    ld   A, [BC]                                       ;; 21:419c $0a
    cp   A, $fe                                        ;; 21:419d $fe $fe
    jr   NZ, .jr_21_41ae                               ;; 21:419f $20 $0d
    inc  BC                                            ;; 21:41a1 $03
    ld   A, [BC]                                       ;; 21:41a2 $0a
    ld   E, A                                          ;; 21:41a3 $5f
    inc  BC                                            ;; 21:41a4 $03
    ld   A, [BC]                                       ;; 21:41a5 $0a
    ld   D, A                                          ;; 21:41a6 $57
    ld   A, C                                          ;; 21:41a7 $79
    sub  A, E                                          ;; 21:41a8 $93
    ld   C, A                                          ;; 21:41a9 $4f
    ld   A, B                                          ;; 21:41aa $78
    sbc  A, D                                          ;; 21:41ab $9a
    ld   B, A                                          ;; 21:41ac $47
    ld   A, [BC]                                       ;; 21:41ad $0a
.jr_21_41ae:
    inc  BC                                            ;; 21:41ae $03
    cp   A, $ff                                        ;; 21:41af $fe $ff
    jp   NZ, .jp_21_426f                               ;; 21:41b1 $c2 $6f $42
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:41b4 $fa $c1 $df
    cpl                                                ;; 21:41b7 $2f
    ld   E, A                                          ;; 21:41b8 $5f
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 21:41b9 $fa $d1 $df
    cp   A, $01                                        ;; 21:41bc $fe $01
    jp   NZ, .jp_21_4253                               ;; 21:41be $c2 $53 $42
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:41c1 $fa $cf $df
    and  A, E                                          ;; 21:41c4 $a3
    ld   [wDFCF_Audio_SfxChannelsActive], A                                    ;; 21:41c5 $ea $cf $df
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 21:41c8 $fa $c2 $df
    ld   E, A                                          ;; 21:41cb $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:41cc $fa $c1 $df
    and  A, E                                          ;; 21:41cf $a3
    jp   Z, .jp_21_4265                                ;; 21:41d0 $ca $65 $42
    push HL                                            ;; 21:41d3 $e5
    push BC                                            ;; 21:41d4 $c5
    ld   B, $ff                                        ;; 21:41d5 $06 $ff
    ld   DE, wDFD2_Audio_SavedMusicRegs                                     ;; 21:41d7 $11 $d2 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 21:41da $fa $fe $df
    sla  A                                             ;; 21:41dd $cb $27
    sla  A                                             ;; 21:41df $cb $27
    add  A, E                                          ;; 21:41e1 $83
    ld   E, A                                          ;; 21:41e2 $5f
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 21:41e3 $fa $fe $df
    add  A, E                                          ;; 21:41e6 $83
    ld   E, A                                          ;; 21:41e7 $5f
    ld   HL, data_21_439e_ChannelSaveRegs                              ;; 21:41e8 $21 $9e $43
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 21:41eb $fa $fe $df
    sla  A                                             ;; 21:41ee $cb $27
    ld   C, A                                          ;; 21:41f0 $4f
    sla  A                                             ;; 21:41f1 $cb $27
    sla  A                                             ;; 21:41f3 $cb $27
    add  A, C                                          ;; 21:41f5 $81
    add  A, L                                          ;; 21:41f6 $85
    ld   L, A                                          ;; 21:41f7 $6f
    jr   NC, .jr_21_41fb                               ;; 21:41f8 $30 $01
    inc  H                                             ;; 21:41fa $24
.jr_21_41fb:
    ld   A, [HL+]                                      ;; 21:41fb $2a
    and  A, A                                          ;; 21:41fc $a7
    jr   Z, .jr_21_4206                                ;; 21:41fd $28 $07
    ld   C, A                                          ;; 21:41ff $4f
    ld   A, [DE]                                       ;; 21:4200 $1a
    ld   [BC], A                                       ;; 21:4201 $02
    inc  DE                                            ;; 21:4202 $13
    inc  HL                                            ;; 21:4203 $23
    jr   .jr_21_41fb                                   ;; 21:4204 $18 $f5
.jr_21_4206:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4206 $fa $c1 $df
    cp   A, $04                                        ;; 21:4209 $fe $04
    jr   NZ, .jr_21_421b                               ;; 21:420b $20 $0e
    ld   HL, wDFE6_Audio_SavedWaveRam                                     ;; 21:420d $21 $e6 $df
    ld   DE, _AUD3WAVERAM                                     ;; 21:4210 $11 $30 $ff
    ld   C, $10                                        ;; 21:4213 $0e $10
.jr_21_4215:
    ld   A, [HL+]                                      ;; 21:4215 $2a
    ld   [DE], A                                       ;; 21:4216 $12
    inc  DE                                            ;; 21:4217 $13
    dec  C                                             ;; 21:4218 $0d
    jr   NZ, .jr_21_4215                               ;; 21:4219 $20 $fa
.jr_21_421b:
    ld   HL, wDFF6_Audio_ChannelFreqShadow                                     ;; 21:421b $21 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 21:421e $fa $fe $df
    sla  A                                             ;; 21:4221 $cb $27
    add  A, L                                          ;; 21:4223 $85
    ld   L, A                                          ;; 21:4224 $6f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4225 $fa $c1 $df
    dec  A                                             ;; 21:4228 $3d
    ld   DE, data_21_43c6_ChannelFreqLoReg                              ;; 21:4229 $11 $c6 $43
    add  A, E                                          ;; 21:422c $83
    ld   E, A                                          ;; 21:422d $5f
    jr   NC, .jr_21_4231                               ;; 21:422e $30 $01
    inc  D                                             ;; 21:4230 $14
.jr_21_4231:
    ld   A, [DE]                                       ;; 21:4231 $1a
    ld   E, A                                          ;; 21:4232 $5f
    ld   D, $ff                                        ;; 21:4233 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4235 $fa $c1 $df
    cp   A, $08                                        ;; 21:4238 $fe $08
    jr   NZ, .jr_21_4244                               ;; 21:423a $20 $08
    inc  HL                                            ;; 21:423c $23
    ld   [DE], A                                       ;; 21:423d $12
    ldh  A, [rNR42]                                    ;; 21:423e $f0 $21
    ldh  [rNR42], A                                    ;; 21:4240 $e0 $21
    jr   .jr_21_424e                                   ;; 21:4242 $18 $0a
.jr_21_4244:
    ld   A, [HL+]                                      ;; 21:4244 $2a
    ld   [DE], A                                       ;; 21:4245 $12
    inc  DE                                            ;; 21:4246 $13
    ld   A, [DE]                                       ;; 21:4247 $1a
    and  A, $c0                                        ;; 21:4248 $e6 $c0
    ld   C, A                                          ;; 21:424a $4f
    ld   A, [HL]                                       ;; 21:424b $7e
    or   A, C                                          ;; 21:424c $b1
    ld   [DE], A                                       ;; 21:424d $12
.jr_21_424e:
    pop  BC                                            ;; 21:424e $c1
    pop  HL                                            ;; 21:424f $e1
    jp   .jp_21_4392                                   ;; 21:4250 $c3 $92 $43
.jp_21_4253:
    ld   A, [wDFC2_Audio_MusicChannelsActive]                                    ;; 21:4253 $fa $c2 $df
    and  A, E                                          ;; 21:4256 $a3
    ld   [wDFC2_Audio_MusicChannelsActive], A                                    ;; 21:4257 $ea $c2 $df
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:425a $fa $cf $df
    ld   E, A                                          ;; 21:425d $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:425e $fa $c1 $df
    and  A, E                                          ;; 21:4261 $a3
    jp   NZ, .jp_21_4392                               ;; 21:4262 $c2 $92 $43
.jp_21_4265:
    ldh  A, [rNR52]                                    ;; 21:4265 $f0 $26
    and  A, $8f                                        ;; 21:4267 $e6 $8f
    and  A, E                                          ;; 21:4269 $a3
    ldh  [rNR52], A                                    ;; 21:426a $e0 $26
    jp   .jp_21_4392                                   ;; 21:426c $c3 $92 $43
.jp_21_426f:
    cp   A, $fd                                        ;; 21:426f $fe $fd
    jr   NZ, .jr_21_4284                               ;; 21:4271 $20 $11
    push HL                                            ;; 21:4273 $e5
    ld   DE, _AUD3WAVERAM                                     ;; 21:4274 $11 $30 $ff
    ld   L, $10                                        ;; 21:4277 $2e $10
.jr_21_4279:
    ld   A, [BC]                                       ;; 21:4279 $0a
    inc  BC                                            ;; 21:427a $03
    ld   [DE], A                                       ;; 21:427b $12
    inc  DE                                            ;; 21:427c $13
    dec  L                                             ;; 21:427d $2d
    jr   NZ, .jr_21_4279                               ;; 21:427e $20 $f9
    pop  HL                                            ;; 21:4280 $e1
    jp   .jp_21_419c                                   ;; 21:4281 $c3 $9c $41
.jr_21_4284:
    cp   A, $a0                                        ;; 21:4284 $fe $a0
    jr   C, .jr_21_42bb                                ;; 21:4286 $38 $33
    cp   A, $c0                                        ;; 21:4288 $fe $c0
    jr   NC, .jr_21_429c                               ;; 21:428a $30 $10
    sub  A, $90                                        ;; 21:428c $d6 $90
    ld   E, A                                          ;; 21:428e $5f
    ld   D, $ff                                        ;; 21:428f $16 $ff
    ld   A, [DE]                                       ;; 21:4291 $1a
    ld   D, A                                          ;; 21:4292 $57
    ld   A, [BC]                                       ;; 21:4293 $0a
    and  A, D                                          ;; 21:4294 $a2
    ld   D, $ff                                        ;; 21:4295 $16 $ff
    ld   [DE], A                                       ;; 21:4297 $12
    inc  BC                                            ;; 21:4298 $03
    jp   .jp_21_419c                                   ;; 21:4299 $c3 $9c $41
.jr_21_429c:
    cp   A, $e0                                        ;; 21:429c $fe $e0
    jr   NC, .jr_21_42b0                               ;; 21:429e $30 $10
    sub  A, $b0                                        ;; 21:42a0 $d6 $b0
    ld   E, A                                          ;; 21:42a2 $5f
    ld   D, $ff                                        ;; 21:42a3 $16 $ff
    ld   A, [DE]                                       ;; 21:42a5 $1a
    ld   D, A                                          ;; 21:42a6 $57
    ld   A, [BC]                                       ;; 21:42a7 $0a
    or   A, D                                          ;; 21:42a8 $b2
    ld   D, $ff                                        ;; 21:42a9 $16 $ff
    ld   [DE], A                                       ;; 21:42ab $12
    inc  BC                                            ;; 21:42ac $03
    jp   .jp_21_419c                                   ;; 21:42ad $c3 $9c $41
.jr_21_42b0:
    sub  A, $d0                                        ;; 21:42b0 $d6 $d0
    ld   E, A                                          ;; 21:42b2 $5f
    ld   D, $ff                                        ;; 21:42b3 $16 $ff
    ld   A, [BC]                                       ;; 21:42b5 $0a
    inc  BC                                            ;; 21:42b6 $03
    ld   [DE], A                                       ;; 21:42b7 $12
    jp   .jp_21_419c                                   ;; 21:42b8 $c3 $9c $41
.jr_21_42bb:
    cp   A, $49                                        ;; 21:42bb $fe $49
    jp   Z, .jp_21_4369                                ;; 21:42bd $ca $69 $43
    sla  A                                             ;; 21:42c0 $cb $27
    ld   [wDFBF_Audio_NoteTableOffset], A                                    ;; 21:42c2 $ea $bf $df
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:42c5 $fa $c1 $df
    sub  A, $01                                        ;; 21:42c8 $d6 $01
    ld   [wDFC0_Audio_ChannelIndexFromMask], A                                    ;; 21:42ca $ea $c0 $df
    ld   A, [wDFBF_Audio_NoteTableOffset]                                    ;; 21:42cd $fa $bf $df
    and  A, A                                          ;; 21:42d0 $a7
    jr   NZ, .jr_21_42ff                               ;; 21:42d1 $20 $2c
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 21:42d3 $fa $d1 $df
    cp   A, $01                                        ;; 21:42d6 $fe $01
    jr   Z, .jr_21_42e4                                ;; 21:42d8 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:42da $fa $cf $df
    ld   E, A                                          ;; 21:42dd $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:42de $fa $c1 $df
    and  A, E                                          ;; 21:42e1 $a3
    jr   NZ, .jr_21_42ff                               ;; 21:42e2 $20 $1b
.jr_21_42e4:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:42e4 $fa $c1 $df
    cpl                                                ;; 21:42e7 $2f
    ld   E, A                                          ;; 21:42e8 $5f
    ldh  A, [rNR52]                                    ;; 21:42e9 $f0 $26
    and  A, $8f                                        ;; 21:42eb $e6 $8f
    and  A, E                                          ;; 21:42ed $a3
    ldh  [rNR52], A                                    ;; 21:42ee $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:42f0 $fa $c1 $df
    cp   A, $04                                        ;; 21:42f3 $fe $04
    jr   NZ, .jr_21_42fa                               ;; 21:42f5 $20 $03
    xor  A, A                                          ;; 21:42f7 $af
    ldh  [rNR30], A                                    ;; 21:42f8 $e0 $1a
.jr_21_42fa:
    ld   A, [BC]                                       ;; 21:42fa $0a
    inc  BC                                            ;; 21:42fb $03
    jp   .jp_21_4392                                   ;; 21:42fc $c3 $92 $43
.jr_21_42ff:
    ld   DE, data_21_43ce_NoteFrequencies                              ;; 21:42ff $11 $ce $43
    add  A, E                                          ;; 21:4302 $83
    ld   E, A                                          ;; 21:4303 $5f
    jr   NC, .jr_21_4307                               ;; 21:4304 $30 $01
    inc  D                                             ;; 21:4306 $14
.jr_21_4307:
    ld   A, [DE]                                       ;; 21:4307 $1a
    ld   [wDFBD_Audio_FreqLo], A                                    ;; 21:4308 $ea $bd $df
    inc  DE                                            ;; 21:430b $13
    ld   A, [DE]                                       ;; 21:430c $1a
    ld   [wDFBE_Audio_FreqHi], A                                    ;; 21:430d $ea $be $df
    ld   DE, wDFF6_Audio_ChannelFreqShadow                                     ;; 21:4310 $11 $f6 $df
    ld   A, [wDFFE_Audio_CurrentChannel]                                    ;; 21:4313 $fa $fe $df
    sla  A                                             ;; 21:4316 $cb $27
    add  A, E                                          ;; 21:4318 $83
    ld   E, A                                          ;; 21:4319 $5f
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 21:431a $fa $bd $df
    ld   [DE], A                                       ;; 21:431d $12
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 21:431e $fa $be $df
    or   A, $80                                        ;; 21:4321 $f6 $80
    ld   [DE], A                                       ;; 21:4323 $12
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 21:4324 $fa $d1 $df
    cp   A, $01                                        ;; 21:4327 $fe $01
    jr   Z, .jr_21_4335                                ;; 21:4329 $28 $0a
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:432b $fa $cf $df
    ld   E, A                                          ;; 21:432e $5f
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:432f $fa $c1 $df
    and  A, E                                          ;; 21:4332 $a3
    jr   NZ, .jr_21_4390                               ;; 21:4333 $20 $5b
.jr_21_4335:
    ld   A, [wDFC0_Audio_ChannelIndexFromMask]                                    ;; 21:4335 $fa $c0 $df
    ld   DE, data_21_43c6_ChannelFreqLoReg                              ;; 21:4338 $11 $c6 $43
    add  A, E                                          ;; 21:433b $83
    ld   E, A                                          ;; 21:433c $5f
    jr   NC, .jr_21_4340                               ;; 21:433d $30 $01
    inc  D                                             ;; 21:433f $14
.jr_21_4340:
    ld   A, [DE]                                       ;; 21:4340 $1a
    ld   E, A                                          ;; 21:4341 $5f
    ld   D, $ff                                        ;; 21:4342 $16 $ff
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4344 $fa $c1 $df
    cp   A, $08                                        ;; 21:4347 $fe $08
    jr   NZ, .jr_21_4357                               ;; 21:4349 $20 $0c
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 21:434b $fa $be $df
    or   A, $80                                        ;; 21:434e $f6 $80
    ld   [DE], A                                       ;; 21:4350 $12
    ldh  A, [rNR42]                                    ;; 21:4351 $f0 $21
    ldh  [rNR42], A                                    ;; 21:4353 $e0 $21
    jr   .jp_21_4369                                   ;; 21:4355 $18 $12
.jr_21_4357:
    ld   A, [wDFBD_Audio_FreqLo]                                    ;; 21:4357 $fa $bd $df
    ld   [DE], A                                       ;; 21:435a $12
    inc  DE                                            ;; 21:435b $13
    push DE                                            ;; 21:435c $d5
    ld   A, [DE]                                       ;; 21:435d $1a
    and  A, $c0                                        ;; 21:435e $e6 $c0
    ld   D, A                                          ;; 21:4360 $57
    ld   A, [wDFBE_Audio_FreqHi]                                    ;; 21:4361 $fa $be $df
    or   A, $80                                        ;; 21:4364 $f6 $80
    or   A, D                                          ;; 21:4366 $b2
    pop  DE                                            ;; 21:4367 $d1
    ld   [DE], A                                       ;; 21:4368 $12
.jp_21_4369:
    ld   A, [wDFD1_Audio_RequestKind]                                    ;; 21:4369 $fa $d1 $df
    cp   A, $02                                        ;; 21:436c $fe $02
    jr   NZ, .jr_21_4376                               ;; 21:436e $20 $06
    ld   A, [wDFCF_Audio_SfxChannelsActive]                                    ;; 21:4370 $fa $cf $df
    and  A, E                                          ;; 21:4373 $a3
    jr   NZ, .jr_21_4390                               ;; 21:4374 $20 $1a
.jr_21_4376:
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4376 $fa $c1 $df
    ld   E, A                                          ;; 21:4379 $5f
    ldh  A, [rNR52]                                    ;; 21:437a $f0 $26
    and  A, $8f                                        ;; 21:437c $e6 $8f
    or   A, E                                          ;; 21:437e $b3
    ldh  [rNR52], A                                    ;; 21:437f $e0 $26
    ld   A, [wDFC1_Audio_CurrentChannelBit]                                    ;; 21:4381 $fa $c1 $df
    cp   A, $04                                        ;; 21:4384 $fe $04
    jr   NZ, .jr_21_4390                               ;; 21:4386 $20 $08
    ldh  A, [rNR30]                                    ;; 21:4388 $f0 $1a
    and  A, $80                                        ;; 21:438a $e6 $80
    or   A, $80                                        ;; 21:438c $f6 $80
    ldh  [rNR30], A                                    ;; 21:438e $e0 $1a
.jr_21_4390:
    ld   A, [BC]                                       ;; 21:4390 $0a
    inc  BC                                            ;; 21:4391 $03
.jp_21_4392:
    ld   [HL], B                                       ;; 21:4392 $70
    dec  HL                                            ;; 21:4393 $2b
    ld   [HL], C                                       ;; 21:4394 $71
    ret                                                ;; 21:4395 $c9
    
    db   $00, $02, $00, $04, $00, $00, $00, $06        ;; 21:4396 ????????

data_21_439e_ChannelSaveRegs:
; Which registers to preserve when a sound effect takes a channel off the music, and
; with what mask. Five (register low byte, mask) pairs per channel, $00 terminating a
; channel's list early - so a channel is at most five registers and pulse 1, with its
; sweep, is the only one that needs four.
;
; The masks drop the bits that must not be replayed: the trigger and length-enable bits
; of NRx4 ($C7 keeps only the frequency high bits), the unused top bits of the length
; registers. Restoring a trigger bit would restart the note instead of resuming it
    db   $10, $7f, $11, $ff, $12, $ff, $14, $c7        ;; 21:439e ????????
    db   $00, $00, $16, $ff, $17, $ff, $19, $c7        ;; 21:43a6 ????????
    db   $00, $00, $00, $00, $1b, $ff, $1c, $60        ;; 21:43ae ????????
    db   $1e, $c7, $00, $00, $00, $00, $20, $3f        ;; 21:43b6 ????????
    db   $21, $ff, $23, $c0, $00, $00, $00, $00        ;; 21:43be ????????

data_21_43c6_ChannelFreqLoReg:
; Channel bit -> that channel's frequency-low register, indexed by
; wDFC1_Audio_CurrentChannelBit minus 1. Only entries 0, 1, 3 and 7 are ever reached,
; which is why the table looks sparse: bits $01, $02, $04 and $08 give indices 0, 1, 3
; and 7. The noise channel's entry is rNR43, which is a polynomial counter rather than
; a frequency, and the interpreter special-cases it
    db   $13, $18, $00, $1d, $00, $00, $00, $23        ;; 21:43c6 ????????

data_21_43ce_NoteFrequencies:
; The pitch table: 73 little-endian 11-bit values, indexed by note number doubled.
; Entry 0 is silence and the rest climb to $07DF, the highest frequency the hardware
; will take. A sequence's note byte is an index into this - AUDIO_NOTE_LAST is the
; last real entry, and AUDIO_NOTE_SUSTAIN sits one past the end as a marker rather
; than a pitch
    db   $00, $00, $2c, $00, $9c, $00, $06, $01        ;; 21:43ce ????????
    db   $6b, $01, $c9, $01, $23, $02, $77, $02        ;; 21:43d6 ????????
    db   $c6, $02, $12, $03, $56, $03, $9b, $03        ;; 21:43de ????????
    db   $da, $03, $16, $04, $4e, $04, $83, $04        ;; 21:43e6 ????????
    db   $b5, $04, $e5, $04, $11, $05, $3b, $05        ;; 21:43ee ????????
    db   $63, $05, $89, $05, $ac, $05, $ce, $05        ;; 21:43f6 ????????
    db   $ed, $05, $0a, $06, $27, $06, $42, $06        ;; 21:43fe ????????
    db   $5b, $06, $72, $06, $89, $06, $9e, $06        ;; 21:4406 ????????
    db   $b2, $06, $c4, $06, $d6, $06, $e7, $06        ;; 21:440e ????????
    db   $f7, $06, $06, $07, $14, $07, $21, $07        ;; 21:4416 ????????
    db   $2d, $07, $39, $07, $44, $07, $4f, $07        ;; 21:441e ????????
    db   $59, $07, $62, $07, $6b, $07, $73, $07        ;; 21:4426 ????????
    db   $7b, $07, $83, $07, $8a, $07, $90, $07        ;; 21:442e ????????
    db   $97, $07, $9d, $07, $a2, $07, $a7, $07        ;; 21:4436 ????????
    db   $ac, $07, $b1, $07, $b6, $07, $ba, $07        ;; 21:443e ????????
    db   $be, $07, $c1, $07, $c4, $07, $c8, $07        ;; 21:4446 ????????
    db   $cb, $07, $ce, $07, $d1, $07, $d4, $07        ;; 21:444e ????????
    db   $d6, $07, $d9, $07, $db, $07, $dd, $07        ;; 21:4456 ????????
    db   $df, $07                                      ;; 21:445e ??

data_21_4460_TrackPointerTables:
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
    db   $1A, $00, $9C, $00, $E0, $02, $04, $05, $81, $05, $95, $05, $27, $08, $A3, $0A, $40, $0F, $E0, $13, $E6, $1A, $62
    db   $1E, $23, $20, $75, $29, $87, $29, $A3, $29, $CB, $29, $0B, $2A, $71, $2A, $7D, $2A, $B7, $2A, $C3, $2A, $CF, $2A
    db   $E3, $2A, $F5, $2A, $15, $2B, $3D, $2B, $99, $2B, $AF, $2B, $05, $2C, $4F, $2C, $FB, $2D, $1D, $2E, $71, $2E, $9D
    db   $2E, $C9, $2E, $DB, $2E, $F1, $2E, $01, $2F, $0D, $2F, $21, $2F, $35, $2F, $3D, $2F, $51, $2F, $83, $2F, $91, $2F
    db   $D3, $2F, $E1, $2F, $1B, $30, $29, $30, $3F, $30, $45, $30, $6B, $30, $7B, $30, $81, $30, $8F, $30, $9F, $30, $DD
    db   $30, $03, $31, $13, $31, $59, $31, $83, $31, $97, $31, $AB, $31, $B5, $31, $E7, $31, $0F, $32, $41, $32, $57, $32
    db   $83, $32, $91, $32, $BB, $32, $C9, $32, $1F, $33, $33, $33, $47, $33, $49, $33, $4B, $33, $4D, $33

audio_21_44fe:         ; MUSIC_CIRCUIT_CENTRAL ch1
    INCBIN "data/audio/bank_21/audio_21_44fe.bin"
audio_21_4744:         ; MUSIC_CIRCUIT_CENTRAL ch2
    INCBIN "data/audio/bank_21/audio_21_4744.bin"
audio_21_496a:         ; MUSIC_CIRCUIT_CENTRAL ch3
    INCBIN "data/audio/bank_21/audio_21_496a.bin"
audio_21_49e9:         ; MUSIC_CIRCUIT_CENTRAL ch4
    INCBIN "data/audio/bank_21/audio_21_49e9.bin"
audio_21_49ff:         ; MUSIC_KUNG_FU_THEATER ch1
    INCBIN "data/audio/bank_21/audio_21_49ff.bin"
audio_21_4c93:         ; MUSIC_KUNG_FU_THEATER ch2
    INCBIN "data/audio/bank_21/audio_21_4c93.bin"
audio_21_4f11:         ; MUSIC_KUNG_FU_THEATER ch3
    INCBIN "data/audio/bank_21/audio_21_4f11.bin"
audio_21_53b0:         ; MUSIC_KUNG_FU_THEATER ch4
    INCBIN "data/audio/bank_21/audio_21_53b0.bin"
audio_21_5852:         ; MUSIC_PREHISTORY_CHANNEL ch1
    INCBIN "data/audio/bank_21/audio_21_5852.bin"
audio_21_5f5a:         ; MUSIC_PREHISTORY_CHANNEL ch2
    INCBIN "data/audio/bank_21/audio_21_5f5a.bin"
audio_21_62d8:         ; MUSIC_PREHISTORY_CHANNEL ch3
    INCBIN "data/audio/bank_21/audio_21_62d8.bin"
audio_21_649b:         ; MUSIC_PREHISTORY_CHANNEL ch4
    INCBIN "data/audio/bank_21/audio_21_649b.bin"
audio_21_6def:         ; SFX_EMPTY (sfx $00)
    INCBIN "data/audio/bank_21/audio_21_6def.bin"
audio_21_6e03:         ; SFX_01 (sfx $01)
    INCBIN "data/audio/bank_21/audio_21_6e03.bin"
audio_21_6e21:         ; SFX_TV_SMASH (sfx $02)
    INCBIN "data/audio/bank_21/audio_21_6e21.bin"
audio_21_6e4b:         ; SFX_SILVER_REMOTE (sfx $03)
    INCBIN "data/audio/bank_21/audio_21_6e4b.bin"
audio_21_6e8d:         ; SFX_GOLD_REMOTE (sfx $04)
    INCBIN "data/audio/bank_21/audio_21_6e8d.bin"
audio_21_6ef5:         ; SFX_05 (sfx $05)
    INCBIN "data/audio/bank_21/audio_21_6ef5.bin"
audio_21_6f03:         ; SFX_COLLECTIBLE (sfx $06)
    INCBIN "data/audio/bank_21/audio_21_6f03.bin"
audio_21_6f3f:         ; SFX_07 (sfx $07)
    INCBIN "data/audio/bank_21/audio_21_6ef5.bin"
audio_21_6f4d:         ; SFX_08 (sfx $08)
    INCBIN "data/audio/bank_21/audio_21_6ef5.bin"
audio_21_6f5b:         ; SFX_09 (sfx $09)
    INCBIN "data/audio/bank_21/audio_21_6f5b.bin"
audio_21_6f71:         ; SFX_0A (sfx $0A)
    INCBIN "data/audio/bank_21/audio_21_6f71.bin"
audio_21_6f85:         ; SFX_0B (sfx $0B)
    INCBIN "data/audio/bank_21/audio_21_6f85.bin"
audio_21_6fa7:         ; SFX_GEX_JUMP (sfx $0C)
    INCBIN "data/audio/bank_21/audio_21_6fa7.bin"
audio_21_6fd1:         ; SFX_GEX_DOUBLE_JUMP (sfx $0D)
    INCBIN "data/audio/bank_21/audio_21_6fd1.bin"
audio_21_702f:         ; SFX_GEX_COLLAPSE (sfx $0E)
    INCBIN "data/audio/bank_21/audio_21_702f.bin"
audio_21_7047:         ; SFX_GEX_DEATH (sfx $0F)
    INCBIN "data/audio/bank_21/audio_21_7047.bin"
audio_21_709f:         ; SFX_GEX_HURT (sfx $10)
    INCBIN "data/audio/bank_21/audio_21_709f.bin"
audio_21_70eb:         ; SFX_GEX_SPAWN (sfx $11)
    INCBIN "data/audio/bank_21/audio_21_70eb.bin"
audio_21_7299:         ; SFX_GEX_HIT_BOUNCE (sfx $12)
    INCBIN "data/audio/bank_21/audio_21_7299.bin"
audio_21_72bd:         ; SFX_13 (sfx $13)
    INCBIN "data/audio/bank_21/audio_21_72bd.bin"
audio_21_7313:         ; SFX_MENU_UNK_1 (sfx $14)
    INCBIN "data/audio/bank_21/audio_21_7313.bin"
audio_21_7341:         ; SFX_MENU_UNK_2 (sfx $15)
    INCBIN "data/audio/bank_21/audio_21_7341.bin"
audio_21_736f:         ; SFX_16 (sfx $16)
    INCBIN "data/audio/bank_21/audio_21_736f.bin"
audio_21_7383:         ; SFX_ENEMY_DEFEATED (sfx $17)
    INCBIN "data/audio/bank_21/audio_21_7383.bin"
audio_21_739b:         ; SFX_18 (sfx $18)
    INCBIN "data/audio/bank_21/audio_21_739b.bin"
audio_21_73ad:         ; SFX_HARD_HEAD_AREA_HAZARD (sfx $19)
    INCBIN "data/audio/bank_21/audio_21_6ef5.bin"
audio_21_73bb:         ; SFX_FALLING_HAZARD (sfx $1A)
    INCBIN "data/audio/bank_21/audio_21_73bb.bin"
audio_21_73d1:         ; SFX_1B (sfx $1B)
    INCBIN "data/audio/bank_21/audio_21_73d1.bin"
audio_21_73e7:         ; driver sfx id $1C - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_73e7.bin"
audio_21_73f1:         ; SFX_FLOWER_HAMMER (sfx $1C)
    INCBIN "data/audio/bank_21/audio_21_73bb.bin"
audio_21_7407:         ; SFX_BUMBLEBEE (sfx $1D)
    INCBIN "data/audio/bank_21/audio_21_7407.bin"
audio_21_743b:         ; SFX_ROCKET (sfx $1E)
    INCBIN "data/audio/bank_21/audio_21_743b.bin"
audio_21_744b:         ; SFX_1F (sfx $1F)
    INCBIN "data/audio/bank_21/audio_21_744b.bin"
audio_21_748f:         ; SFX_HUNTER (sfx $20)
    INCBIN "data/audio/bank_21/audio_21_743b.bin"
audio_21_749f:         ; SFX_21 (sfx $21)
    INCBIN "data/audio/bank_21/audio_21_749f.bin"
audio_21_74db:         ; SFX_22 (sfx $22)
    INCBIN "data/audio/bank_21/audio_21_74db.bin"
audio_21_74eb:         ; SFX_23 (sfx $23)
    INCBIN "data/audio/bank_21/audio_21_74eb.bin"
audio_21_7503:         ; driver sfx id $25 - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_7503.bin"
audio_21_750b:         ; SFX_ENEMY_BOUNCE (sfx $24)
    INCBIN "data/audio/bank_21/audio_21_750b.bin"
audio_21_7533:         ; SFX_25 (sfx $25)
    INCBIN "data/audio/bank_21/audio_21_7533.bin"
audio_21_7545:         ; driver sfx id $28 - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_7503.bin"
audio_21_754d:         ; SFX_26 (sfx $26)
    INCBIN "data/audio/bank_21/audio_21_754d.bin"
audio_21_755d:         ; SFX_FALLING_PLATFORM (sfx $27)
    INCBIN "data/audio/bank_21/audio_21_755d.bin"
audio_21_756f:         ; SFX_28 (sfx $28)
    INCBIN "data/audio/bank_21/audio_21_756f.bin"
audio_21_75af:         ; SFX_29 (sfx $29)
    INCBIN "data/audio/bank_21/audio_21_750b.bin"
audio_21_75d7:         ; SFX_GEX_JUMP_UNK (sfx $2A)
    INCBIN "data/audio/bank_21/audio_21_75d7.bin"
audio_21_75e9:         ; SFX_POWERED_WALKWAY (sfx $2B)
    INCBIN "data/audio/bank_21/audio_21_75e9.bin"
audio_21_7631:         ; SFX_CANNON_ROTATE (sfx $2C)
    INCBIN "data/audio/bank_21/audio_21_7631.bin"
audio_21_765d:         ; SFX_JAR (sfx $2D)
    INCBIN "data/audio/bank_21/audio_21_73bb.bin"
audio_21_7673:         ; SFX_2E (sfx $2E)
    INCBIN "data/audio/bank_21/audio_21_7673.bin"
audio_21_7689:         ; driver sfx id $32 - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_7689.bin"
audio_21_7695:         ; SFX_DRAGON (sfx $2F)
    INCBIN "data/audio/bank_21/audio_21_7407.bin"
audio_21_76c9:         ; SFX_CANNON (sfx $30)
    INCBIN "data/audio/bank_21/audio_21_6fa7.bin"
audio_21_76f3:         ; SFX_FALLING_BOULDER (sfx $31)
    INCBIN "data/audio/bank_21/audio_21_76f3.bin"
audio_21_7727:         ; SFX_32 (sfx $32)
    INCBIN "data/audio/bank_21/audio_21_7727.bin"
audio_21_773f:         ; SFX_PTEROSAUR (sfx $33)
    INCBIN "data/audio/bank_21/audio_21_773f.bin"
audio_21_776d:         ; SFX_MULTI_PROJECTILE (sfx $34)
    INCBIN "data/audio/bank_21/audio_21_776d.bin"
audio_21_777d:         ; SFX_GEAR (sfx $35)
    INCBIN "data/audio/bank_21/audio_21_7631.bin"
audio_21_77a9:         ; SFX_GUN_PROJECTILE (sfx $36)
    INCBIN "data/audio/bank_21/audio_21_743b.bin"
audio_21_77b9:         ; SFX_REZ_PROJECTILE (sfx $37)
    INCBIN "data/audio/bank_21/audio_21_77b9.bin"
audio_21_7811:         ; SFX_FINAL_BATTLE_BUTTON (sfx $38)
    INCBIN "data/audio/bank_21/audio_21_73bb.bin"
audio_21_7827:         ; SFX_REZ_BUTTON (sfx $39)
    INCBIN "data/audio/bank_21/audio_21_7827.bin"
audio_21_783d:         ; driver sfx id $3E - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_783d.bin"
audio_21_7841:         ; driver sfx id $3F - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_7841.bin"
audio_21_7845:         ; driver sfx id $40 - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_7845.bin"
audio_21_7849:         ; driver sfx id $41 - no .data_00_116c_SFXChannelTable row reaches it
    INCBIN "data/audio/bank_21/audio_21_7849.bin"
