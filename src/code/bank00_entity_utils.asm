call_00_30af:
    ld   H, $d2                                        ;; 00:30af $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:30b1 $fa $00 $d3
    or   A, $1e                                        ;; 00:30b4 $f6 $1e
    ld   L, A                                          ;; 00:30b6 $6f
    ld   A, [HL]                                       ;; 00:30b7 $7e
    sub  A, $02                                        ;; 00:30b8 $d6 $02
    bit  7, A                                          ;; 00:30ba $cb $7f
    jr   Z, .jr_00_30c4                                ;; 00:30bc $28 $06
    cp   A, $c0                                        ;; 00:30be $fe $c0
    jr   NC, .jr_00_30c4                               ;; 00:30c0 $30 $02
    ld   A, $c0                                        ;; 00:30c2 $3e $c0
.jr_00_30c4:
    ld   [HL], A                                       ;; 00:30c4 $77
    cpl                                                ;; 00:30c5 $2f
    inc  A                                             ;; 00:30c6 $3c
    sra  A                                             ;; 00:30c7 $cb $2f
    sra  A                                             ;; 00:30c9 $cb $2f
    sra  A                                             ;; 00:30cb $cb $2f
    sra  A                                             ;; 00:30cd $cb $2f
    ld   C, A                                          ;; 00:30cf $4f
    cp   A, $80                                        ;; 00:30d0 $fe $80
    ld   A, $ff                                        ;; 00:30d2 $3e $ff
    adc  A, $00                                        ;; 00:30d4 $ce $00
    ld   B, A                                          ;; 00:30d6 $47
    jp   call_00_37d8                                  ;; 00:30d7 $c3 $d8 $37
    
call_00_30da:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1E
    ld   l,a
    ld   a,[hl]
    sub  a,$02
    bit  7,a
    jr   z,jr_00_30ef
    cp   a,$C0
    jr   nc,jr_00_30ef
    ld   a,$C0
    jr_00_30ef:
    ld   [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$0E
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    call call_00_349c
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ld   a,e
    sub  [hl]
    inc  hl
    ld   a,d
    sbc  [hl]
    ret  c
    ld   [hl],d
    dec  l
    ld   [hl],e
    ld   a,l
    xor  a,$0E
    ld   l,a
    xor  a
    ld   [hl],a
    ret  
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    xor  a,$0A
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    ret  

call_00_3137:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    xor  a,$0A
    ld   l,a
    ldi  a,[hl]
    sub  e
    ld   a,[hl]
    sbc  d
    ret  c
    ld   [hl],d
    dec  l
    ld   [hl],e
    ld   a,l
    xor  a,$0E
    ld   l,a
    xor  a
    ld   [hl],a
    ret  

call_00_3154:
    call call_00_34ba                                  ;; 00:3154 $cd $ba $34
    ld   H, $d2                                        ;; 00:3157 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3159 $fa $00 $d3
    or   A, $10                                        ;; 00:315c $f6 $10
    ld   L, A                                          ;; 00:315e $6f
    ld   A, [HL+]                                      ;; 00:315f $2a
    sub  A, E                                          ;; 00:3160 $93
    ld   A, [HL]                                       ;; 00:3161 $7e
    sbc  A, D                                          ;; 00:3162 $9a
    ret  C                                             ;; 00:3163 $d8
    ld   [HL], D                                       ;; 00:3164 $72
    dec  L                                             ;; 00:3165 $2d
    ld   [HL], E                                       ;; 00:3166 $73
    ld   A, L                                          ;; 00:3167 $7d
    xor  A, $0e                                        ;; 00:3168 $ee $0e
    ld   L, A                                          ;; 00:316a $6f
    xor  A, A                                          ;; 00:316b $af
    ld   [HL], A                                       ;; 00:316c $77
    ret                                                ;; 00:316d $c9

call_00_316e:
    push BC                                            ;; 00:316e $c5
    call call_00_34ba                                  ;; 00:316f $cd $ba $34
    pop  HL                                            ;; 00:3172 $e1
    add  HL, DE                                        ;; 00:3173 $19
    ld   E, L                                          ;; 00:3174 $5d
    ld   D, H                                          ;; 00:3175 $54
    ld   H, $d2                                        ;; 00:3176 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3178 $fa $00 $d3
    or   A, $10                                        ;; 00:317b $f6 $10
    ld   L, A                                          ;; 00:317d $6f
    ld   A, [HL+]                                      ;; 00:317e $2a
    sub  A, E                                          ;; 00:317f $93
    ld   A, [HL]                                       ;; 00:3180 $7e
    sbc  A, D                                          ;; 00:3181 $9a
    ret  C                                             ;; 00:3182 $d8
    ld   [HL], D                                       ;; 00:3183 $72
    dec  L                                             ;; 00:3184 $2d
    ld   [HL], E                                       ;; 00:3185 $73
    ld   A, L                                          ;; 00:3186 $7d
    xor  A, $0e                                        ;; 00:3187 $ee $0e
    ld   L, A                                          ;; 00:3189 $6f
    xor  A, A                                          ;; 00:318a $af
    ld   [HL], A                                       ;; 00:318b $77
    ret                                                ;; 00:318c $c9

call_00_318d:
    ld   H, $d2                                        ;; 00:318d $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:318f $fa $00 $d3
    or   A, $17                                        ;; 00:3192 $f6 $17
    ld   L, A                                          ;; 00:3194 $6f
    bit  3, [HL]                                       ;; 00:3195 $cb $5e
    jr   Z, .jr_00_319c                                ;; 00:3197 $28 $03
    bit  0, [HL]                                       ;; 00:3199 $cb $46
    ret  Z                                             ;; 00:319b $c8
.jr_00_319c:
    bit  1, [HL]                                       ;; 00:319c $cb $4e
    jr   NZ, .jr_00_3202                               ;; 00:319e $20 $62
    bit  7, [HL]                                       ;; 00:31a0 $cb $7e
    jr   NZ, .jr_00_31de                               ;; 00:31a2 $20 $3a
    call call_00_347e                                  ;; 00:31a4 $cd $7e $34
    ld   H, $d2                                        ;; 00:31a7 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:31a9 $fa $00 $d3
    or   A, $0e                                        ;; 00:31ac $f6 $0e
    ld   L, A                                          ;; 00:31ae $6f
    ld   A, [HL+]                                      ;; 00:31af $2a
    sub  A, E                                          ;; 00:31b0 $93
    ld   A, [HL]                                       ;; 00:31b1 $7e
    sbc  A, D                                          ;; 00:31b2 $9a
    jr   NC, .jr_00_31be                               ;; 00:31b3 $30 $09
    ld   A, L                                          ;; 00:31b5 $7d
    xor  A, $14                                        ;; 00:31b6 $ee $14
    ld   L, A                                          ;; 00:31b8 $6f
    ld   A, [HL+]                                      ;; 00:31b9 $2a
    cp   A, [HL]                                       ;; 00:31ba $be
    ret  Z                                             ;; 00:31bb $c8
    inc  [HL]                                          ;; 00:31bc $34
    ret                                                ;; 00:31bd $c9
.jr_00_31be:
    ld   A, L                                          ;; 00:31be $7d
    xor  A, $18                                        ;; 00:31bf $ee $18
    ld   L, A                                          ;; 00:31c1 $6f
    set  7, [HL]                                       ;; 00:31c2 $cb $fe
.jp_00_31c4:
    push HL                                            ;; 00:31c4 $e5
    ld   A, L                                          ;; 00:31c5 $7d
    xor  A, $17                                        ;; 00:31c6 $ee $17
    ld   L, A                                          ;; 00:31c8 $6f
    ld   A, [HL]                                       ;; 00:31c9 $7e
    pop  HL                                            ;; 00:31ca $e1
    cp   A, $17                                        ;; 00:31cb $fe $17
    jr   Z, .jr_00_31d4                                ;; 00:31cd $28 $05
    bit  3, [HL]                                       ;; 00:31cf $cb $5e
    ret  Z                                             ;; 00:31d1 $c8
    res  0, [HL]                                       ;; 00:31d2 $cb $86
.jr_00_31d4:
    ld   A, L                                          ;; 00:31d4 $7d
    xor  A, $0b                                        ;; 00:31d5 $ee $0b
    ld   L, A                                          ;; 00:31d7 $6f
    xor  A, A                                          ;; 00:31d8 $af
    ld   [HL+], A                                      ;; 00:31d9 $22
    ld   [HL+], A                                      ;; 00:31da $22
    ld   [HL+], A                                      ;; 00:31db $22
    ld   [HL], A                                       ;; 00:31dc $77
    ret                                                ;; 00:31dd $c9
.jr_00_31de:
    call call_00_3460                                  ;; 00:31de $cd $60 $34
    ld   H, $d2                                        ;; 00:31e1 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:31e3 $fa $00 $d3
    or   A, $0e                                        ;; 00:31e6 $f6 $0e
    ld   L, A                                          ;; 00:31e8 $6f
    ld   A, [HL+]                                      ;; 00:31e9 $2a
    sub  A, E                                          ;; 00:31ea $93
    ld   A, [HL]                                       ;; 00:31eb $7e
    sbc  A, D                                          ;; 00:31ec $9a
    jr   C, .jr_00_31fa                                ;; 00:31ed $38 $0b
    ld   A, L                                          ;; 00:31ef $7d
    xor  A, $14                                        ;; 00:31f0 $ee $14
    ld   L, A                                          ;; 00:31f2 $6f
    ld   A, [HL+]                                      ;; 00:31f3 $2a
    cpl                                                ;; 00:31f4 $2f
    inc  A                                             ;; 00:31f5 $3c
    cp   A, [HL]                                       ;; 00:31f6 $be
    ret  Z                                             ;; 00:31f7 $c8
    dec  [HL]                                          ;; 00:31f8 $35
    ret                                                ;; 00:31f9 $c9
.jr_00_31fa:
    ld   A, L                                          ;; 00:31fa $7d
    xor  A, $18                                        ;; 00:31fb $ee $18
    ld   L, A                                          ;; 00:31fd $6f
    res  7, [HL]                                       ;; 00:31fe $cb $be
    jr   .jp_00_31c4                                   ;; 00:3200 $18 $c2
.jr_00_3202:
    bit  6, [HL]                                       ;; 00:3202 $cb $76
    jr   NZ, .jr_00_322a                               ;; 00:3204 $20 $24
    call call_00_34ba                                  ;; 00:3206 $cd $ba $34
    ld   H, $d2                                        ;; 00:3209 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:320b $fa $00 $d3
    or   A, $10                                        ;; 00:320e $f6 $10
    ld   L, A                                          ;; 00:3210 $6f
    ld   A, [HL+]                                      ;; 00:3211 $2a
    sub  A, E                                          ;; 00:3212 $93
    ld   A, [HL]                                       ;; 00:3213 $7e
    sbc  A, D                                          ;; 00:3214 $9a
    jr   NC, .jr_00_3222                               ;; 00:3215 $30 $0b
    ld   A, L                                          ;; 00:3217 $7d
    xor  A, $0a                                        ;; 00:3218 $ee $0a
    ld   L, A                                          ;; 00:321a $6f
    ld   A, [HL+]                                      ;; 00:321b $2a
    inc  L                                             ;; 00:321c $2c
    inc  L                                             ;; 00:321d $2c
    cp   A, [HL]                                       ;; 00:321e $be
    ret  Z                                             ;; 00:321f $c8
    inc  [HL]                                          ;; 00:3220 $34
    ret                                                ;; 00:3221 $c9
.jr_00_3222:
    ld   A, L                                          ;; 00:3222 $7d
    xor  A, $06                                        ;; 00:3223 $ee $06
    ld   L, A                                          ;; 00:3225 $6f
    set  6, [HL]                                       ;; 00:3226 $cb $f6
    jr   .jp_00_31c4                                   ;; 00:3228 $18 $9a
.jr_00_322a:
    call call_00_349c                                  ;; 00:322a $cd $9c $34
    ld   H, $d2                                        ;; 00:322d $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:322f $fa $00 $d3
    or   A, $10                                        ;; 00:3232 $f6 $10
    ld   L, A                                          ;; 00:3234 $6f
    ld   A, [HL+]                                      ;; 00:3235 $2a
    sub  A, E                                          ;; 00:3236 $93
    ld   A, [HL]                                       ;; 00:3237 $7e
    sbc  A, D                                          ;; 00:3238 $9a
    jr   C, .jr_00_3248                                ;; 00:3239 $38 $0d
    ld   A, L                                          ;; 00:323b $7d
    xor  A, $0a                                        ;; 00:323c $ee $0a
    ld   L, A                                          ;; 00:323e $6f
    ld   A, [HL+]                                      ;; 00:323f $2a
    cpl                                                ;; 00:3240 $2f
    inc  A                                             ;; 00:3241 $3c
    inc  L                                             ;; 00:3242 $2c
    inc  L                                             ;; 00:3243 $2c
    cp   A, [HL]                                       ;; 00:3244 $be
    ret  Z                                             ;; 00:3245 $c8
    dec  [HL]                                          ;; 00:3246 $35
    ret                                                ;; 00:3247 $c9
.jr_00_3248:
    ld   A, L                                          ;; 00:3248 $7d
    xor  A, $06                                        ;; 00:3249 $ee $06
    ld   L, A                                          ;; 00:324b $6f
    res  6, [HL]                                       ;; 00:324c $cb $b6
    jp   .jp_00_31c4                                   ;; 00:324e $c3 $c4 $31

call_00_3251:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   c,[hl]
    xor  a,$16
    ld   l,a
    ldi  a,[hl]
    bit  5,c
    jr   z,.jr_02_326A
    cpl  
    inc  a
    cp   [hl]
    jr   z,.jr_02_326E
    dec  [hl]
    jr   .jr_02_326E
.jr_02_326A:
    cp   [hl]
    jr   z,.jr_02_326E
    inc  [hl]
.jr_02_326E:
    ldi  a,[hl]
    ld   c,a
    ld   a,[hl]
    and  a,$0F
    add  c
    ld   [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$13
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    ret  

call_00_3290:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],c
    ret  

call_00_329a:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   c,[hl]
    ld   a,l
    xor  a,$11
    ld   l,a
    ldi  a,[hl]
    bit  5,c
    jr   z,.jr_02_32AE
    cpl  
    inc  a
.jr_02_32AE:
    add  [hl]
    ld   c,a
    and  a,$0F
    ld   [hl],a
    ld   a,c
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    push bc
    ld   a,l
    xor  a,$06
    ld   l,a
    ld   a,c
    add  [hl]
    ldd  [hl],a
    bit  7,a
    jr   z,.jr_02_32D2
    cpl  
    inc  a
.jr_02_32D2:
    cp   [hl]
    jr   c,.jr_02_32DD
    ld   a,l
    xor  a,$17
    ld   l,a
    ld   a,[hl]
    xor  a,$20
    ld   [hl],a
.jr_02_32DD:
    pop  bc
    jp   call_00_37c9

call_00_32e1:
    ld   H, $d2                                        ;; 00:32e1 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:32e3 $fa $00 $d3
    or   A, $1c                                        ;; 00:32e6 $f6 $1c
    ld   L, A                                          ;; 00:32e8 $6f
    ld   A, [HL]                                       ;; 00:32e9 $7e
    cp   A, C                                          ;; 00:32ea $b9
    ret  Z                                             ;; 00:32eb $c8
    jr   C, .jr_00_32f0                                ;; 00:32ec $38 $02
    dec  [HL]                                          ;; 00:32ee $35
    ret                                                ;; 00:32ef $c9
.jr_00_32f0:
    inc  [HL]                                          ;; 00:32f0 $34
    ret                                                ;; 00:32f1 $c9

    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    bit  7,c
    jr   nz,.jr_02_3309
    bit  7,[hl]
    jr   nz,.jr_02_3314
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3314
    jr   .jr_02_3312
.jr_02_3309:
    bit  7,[hl]
    jr   z,.jr_02_3312
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3314
.jr_02_3312:
    dec  [hl]
    ret  
.jr_02_3314:
    inc  [hl]
    ret  

call_00_3316:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1E
    ld   l,a
    bit  7,c
    jr   nz,.jr_02_332D
    bit  7,[hl]
    jr   nz,.jr_02_3338
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3338
    jr   .jr_02_3336
.jr_02_332D:
    bit  7,[hl]
    jr   z,.jr_02_3336
    ld   a,[hl]
    cp   c
    ret  z
    jr   c,.jr_02_3338
.jr_02_3336:
    dec  [hl]
    ret  
.jr_02_3338:
    inc  [hl]
    ret  
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    ld   a,[hl]
    and  a
    ret  

call_00_3345:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1E
    ld   l,a
    ld   a,[hl]
    and  a
    ret  

call_00_3350:  
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    ld   [hl],c
    ret  

call_00_335a:
    ld   H, $d2                                        ;; 00:335a $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:335c $fa $00 $d3
    or   A, $1e                                        ;; 00:335f $f6 $1e
    ld   L, A                                          ;; 00:3361 $6f
    ld   [HL], C                                       ;; 00:3362 $71
    ret                                                ;; 00:3363 $c9

call_00_3364:
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca 
    rrca 
    rrca 
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   de,wD309
    add  hl,de
    ld   b,[hl]
    dec  b
    inc  hl
    ld   c,[hl]
    inc  c
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   e,h
    ld   hl,wD76A_PlayerXPositionBlock
    ld   a,[hl]
    cp   c
    jr   c,.jr_02_33A5
    ld   a,b
    cp   [hl]
    jr   c,.jr_02_33A5
    ld   a,e
    cp   [hl]
    jr   z,.jr_02_33A5
    ld   d,$00
    jr   c,.jr_02_339C
    ld   d,$20
.jr_02_339C:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],d
.jr_02_33A5:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    bit  5,[hl]
    jr   z,.jr_02_33C7
    ld   a,e
    cp   c
    jr   c,.jr_02_33CB
.jr_02_33B5:
    ld   [hl],$20
    ld   a,l
    xor  a,$11
    ld   l,a
    ld   c,[hl]
    xor  a,$12
    ld   l,a
    ld   a,[hl]
    sub  c
    ldi  [hl],a
    ld   a,[hl]
    sbc  a,$00
    ld   [hl],a
    ret  
.jr_02_33C7:
    ld   a,e
    cp   b
    jr   nc,.jr_02_33B5
.jr_02_33CB:
    ld   [hl],$00
    ld   a,l
    xor  a,$11
    ld   l,a
    ld   c,[hl]
    xor  a,$12
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  a,$00
    ld   [hl],a
    ret  

    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0A
    ld   l,a
    bit  5,[hl]
    ret  z
    ld   a,l
    xor  a,$1D
    ld   l,a
    bit  1,[hl]
    jr   z,.jr_02_33F2
    jr   .jr_02_341B
.jr_02_33F2:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    ld   c,[hl]
    dec  l
    bit  7,[hl]
    jr   nz,.jr_02_340C
    ld   a,[hl]
    add  c
    cp   a,$80
    jr   c,.jr_02_340E
    sub  a,$7F
    cpl  
    inc  a
    add  c
    ld   c,a
.jr_02_340C:
    ld   a,[hl]
    add  c
.jr_02_340E:
    ld   [hl],a
    ld   a,l
    xor  a,$15
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  a,$00
    ld   [hl],a
    ret  
.jr_02_341B:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    ld   c,[hl]
    dec  l
    bit  7,[hl]
    jr   z,.jr_02_3433
    ld   a,[hl]
    sub  c
    cp   a,$80
    jr   nc,.jr_02_3435
    sub  a,$80
    add  c
    ld   c,a
.jr_02_3433:
    ld   a,[hl]
    sub  c
.jr_02_3435:
    ld   [hl],a
    ld   a,l
    xor  a,$15
    ld   l,a
    ld   a,[hl]
    sub  c
    ldi  [hl],a
    ld   a,[hl]
    sbc  a,$00
    ld   [hl],a
    ret  

call_00_3442:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   c,[hl]
    xor  a,$11
    ld   l,a
    ld   a,[hl]
    bit  5,c
    jr   z,.jr_02_3455
    cpl  
    inc  a
.jr_02_3455:
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    jp   call_00_37c9

call_00_3460:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3460 $fa $00 $d3
    rrca                                               ;; 00:3463 $0f
    rrca                                               ;; 00:3464 $0f
    rrca                                               ;; 00:3465 $0f
    and  A, $1c                                        ;; 00:3466 $e6 $1c
    ld   L, A                                          ;; 00:3468 $6f
    ld   H, $00                                        ;; 00:3469 $26 $00
    ld   DE, wD30A                                     ;; 00:346b $11 $0a $d3
    add  HL, DE                                        ;; 00:346e $19
    ld   L, [HL]                                       ;; 00:346f $6e
    ld   H, $00                                        ;; 00:3470 $26 $00
    add  HL, HL                                        ;; 00:3472 $29
    add  HL, HL                                        ;; 00:3473 $29
    add  HL, HL                                        ;; 00:3474 $29
    add  HL, HL                                        ;; 00:3475 $29
    add  HL, HL                                        ;; 00:3476 $29
    ld   DE, $30                                       ;; 00:3477 $11 $30 $00
    add  HL, DE                                        ;; 00:347a $19
    ld   E, L                                          ;; 00:347b $5d
    ld   D, H                                          ;; 00:347c $54
    ret                                                ;; 00:347d $c9

call_00_347e:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:347e $fa $00 $d3
    rrca                                               ;; 00:3481 $0f
    rrca                                               ;; 00:3482 $0f
    rrca                                               ;; 00:3483 $0f
    and  A, $1c                                        ;; 00:3484 $e6 $1c
    ld   L, A                                          ;; 00:3486 $6f
    ld   H, $00                                        ;; 00:3487 $26 $00
    ld   DE, wD309                                     ;; 00:3489 $11 $09 $d3
    add  HL, DE                                        ;; 00:348c $19
    ld   L, [HL]                                       ;; 00:348d $6e
    ld   H, $00                                        ;; 00:348e $26 $00
    add  HL, HL                                        ;; 00:3490 $29
    add  HL, HL                                        ;; 00:3491 $29
    add  HL, HL                                        ;; 00:3492 $29
    add  HL, HL                                        ;; 00:3493 $29
    add  HL, HL                                        ;; 00:3494 $29
    ld   DE, hFFF0                                     ;; 00:3495 $11 $f0 $ff
    add  HL, DE                                        ;; 00:3498 $19
    ld   E, L                                          ;; 00:3499 $5d
    ld   D, H                                          ;; 00:349a $54
    ret                                                ;; 00:349b $c9

call_00_349c:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:349c $fa $00 $d3
    rrca                                               ;; 00:349f $0f
    rrca                                               ;; 00:34a0 $0f
    rrca                                               ;; 00:34a1 $0f
    and  A, $1c                                        ;; 00:34a2 $e6 $1c
    ld   L, A                                          ;; 00:34a4 $6f
    ld   H, $00                                        ;; 00:34a5 $26 $00
    ld   DE, wD30C                                     ;; 00:34a7 $11 $0c $d3
    add  HL, DE                                        ;; 00:34aa $19
    ld   L, [HL]                                       ;; 00:34ab $6e
    ld   H, $00                                        ;; 00:34ac $26 $00
    add  HL, HL                                        ;; 00:34ae $29
    add  HL, HL                                        ;; 00:34af $29
    add  HL, HL                                        ;; 00:34b0 $29
    add  HL, HL                                        ;; 00:34b1 $29
    add  HL, HL                                        ;; 00:34b2 $29
    ld   DE, $30                                       ;; 00:34b3 $11 $30 $00
    add  HL, DE                                        ;; 00:34b6 $19
    ld   E, L                                          ;; 00:34b7 $5d
    ld   D, H                                          ;; 00:34b8 $54
    ret                                                ;; 00:34b9 $c9

call_00_34ba:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:34ba $fa $00 $d3
    rrca                                               ;; 00:34bd $0f
    rrca                                               ;; 00:34be $0f
    rrca                                               ;; 00:34bf $0f
    and  A, $1c                                        ;; 00:34c0 $e6 $1c
    ld   L, A                                          ;; 00:34c2 $6f
    ld   H, $00                                        ;; 00:34c3 $26 $00
    ld   DE, wD30B                                     ;; 00:34c5 $11 $0b $d3
    add  HL, DE                                        ;; 00:34c8 $19
    ld   L, [HL]                                       ;; 00:34c9 $6e
    ld   H, $00                                        ;; 00:34ca $26 $00
    add  HL, HL                                        ;; 00:34cc $29
    add  HL, HL                                        ;; 00:34cd $29
    add  HL, HL                                        ;; 00:34ce $29
    add  HL, HL                                        ;; 00:34cf $29
    add  HL, HL                                        ;; 00:34d0 $29
    ld   DE, hFFF0                                     ;; 00:34d1 $11 $f0 $ff
    add  HL, DE                                        ;; 00:34d4 $19
    ld   E, L                                          ;; 00:34d5 $5d
    ld   D, H                                          ;; 00:34d6 $54
    ret                                                ;; 00:34d7 $c9

call_00_34d8:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:34d8 $fa $00 $d3
    rlca                                               ;; 00:34db $07
    rlca                                               ;; 00:34dc $07
    rlca                                               ;; 00:34dd $07
    and  A, $07                                        ;; 00:34de $e6 $07
    ld   L, A                                          ;; 00:34e0 $6f
    ld   H, $00                                        ;; 00:34e1 $26 $00
    ld   DE, wD301                                     ;; 00:34e3 $11 $01 $d3
    add  HL, DE                                        ;; 00:34e6 $19
    ld   [HL], $00                                     ;; 00:34e7 $36 $00
    ret                                                ;; 00:34e9 $c9

call_00_34ea:
    ld   H, $d2                                        ;; 00:34ea $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:34ec $fa $00 $d3
    or   A, $09                                        ;; 00:34ef $f6 $09
    ld   L, A                                          ;; 00:34f1 $6f
    bit  5, [HL]                                       ;; 00:34f2 $cb $6e
    ret                                                ;; 00:34f4 $c9

call_00_34f5:
    ld   H, $d2                                        ;; 00:34f5 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:34f7 $fa $00 $d3
    or   A, $17                                        ;; 00:34fa $f6 $17
    ld   L, A                                          ;; 00:34fc $6f
    ld   A, [wD74D]                                    ;; 00:34fd $fa $4d $d7
    ld   B, A                                          ;; 00:3500 $47
    and  A, A                                          ;; 00:3501 $a7
    ret  Z                                             ;; 00:3502 $c8
    ld   A, L                                          ;; 00:3503 $7d
    and  A, $e0                                        ;; 00:3504 $e6 $e0
    cp   A, B                                          ;; 00:3506 $b8
    ld   B, $00                                        ;; 00:3507 $06 $00
    ret  NZ                                            ;; 00:3509 $c0
    inc  B                                             ;; 00:350a $04
    ret                                                ;; 00:350b $c9

call_00_350c:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:350c $fa $00 $d3
    rrca                                               ;; 00:350f $0f
    rrca                                               ;; 00:3510 $0f
    rrca                                               ;; 00:3511 $0f
    ld   L, A                                          ;; 00:3512 $6f
    ld   H, $00                                        ;; 00:3513 $26 $00
    ld   BC, wD309                                     ;; 00:3515 $01 $09 $d3
    add  HL, BC                                        ;; 00:3518 $09
    ld   B, [HL]                                       ;; 00:3519 $46
    inc  HL                                            ;; 00:351a $23
    ld   C, [HL]                                       ;; 00:351b $4e
    inc  HL                                            ;; 00:351c $23
    ld   D, [HL]                                       ;; 00:351d $56
    inc  HL                                            ;; 00:351e $23
    ld   E, [HL]                                       ;; 00:351f $5e
    ld   HL, wD329                                     ;; 00:3520 $21 $29 $d3
    ld   A, B                                          ;; 00:3523 $78
    cp   A, [HL]                                       ;; 00:3524 $be
    ret  C                                             ;; 00:3525 $d8
    inc  HL                                            ;; 00:3526 $23
    ld   A, [HL+]                                      ;; 00:3527 $2a
    cp   A, C                                          ;; 00:3528 $b9
    ret  C                                             ;; 00:3529 $d8
    ld   A, D                                          ;; 00:352a $7a
    cp   A, [HL]                                       ;; 00:352b $be
    ret  C                                             ;; 00:352c $d8
    inc  HL                                            ;; 00:352d $23
    ld   A, [HL]                                       ;; 00:352e $7e
    cp   A, E                                          ;; 00:352f $bb
    ret                                                ;; 00:3530 $c9

call_00_3531:
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca 
    rrca 
    rrca 
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   de,wD309
    add  hl,de
    ld   b,[hl]
    dec  b
    inc  hl
    ld   c,[hl]
    inc  c
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   c
    ret  c
    ld   a,b
    cp   h
    ret  

call_00_3559:
    ld   H, $d2                                        ;; 00:3559 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:355b $fa $00 $d3
    or   A, $1c                                        ;; 00:355e $f6 $1c
    ld   L, A                                          ;; 00:3560 $6f
    ld   A, [HL+]                                      ;; 00:3561 $2a
    ld   C, A                                          ;; 00:3562 $4f
    ld   A, [HL]                                       ;; 00:3563 $7e
    and  A, $0f                                        ;; 00:3564 $e6 $0f
    add  A, C                                          ;; 00:3566 $81
    ld   [HL+], A                                      ;; 00:3567 $22
    sra  A                                             ;; 00:3568 $cb $2f
    sra  A                                             ;; 00:356a $cb $2f
    sra  A                                             ;; 00:356c $cb $2f
    sra  A                                             ;; 00:356e $cb $2f
    ld   C, A                                          ;; 00:3570 $4f
    cp   A, $80                                        ;; 00:3571 $fe $80
    ld   A, $ff                                        ;; 00:3573 $3e $ff
    adc  A, $00                                        ;; 00:3575 $ce $00
    ld   B, A                                          ;; 00:3577 $47
    push BC                                            ;; 00:3578 $c5
    ld   A, [HL+]                                      ;; 00:3579 $2a
    ld   C, A                                          ;; 00:357a $4f
    ld   A, [HL]                                       ;; 00:357b $7e
    and  A, $0f                                        ;; 00:357c $e6 $0f
    add  A, C                                          ;; 00:357e $81
    ld   [HL], A                                       ;; 00:357f $77
    sra  A                                             ;; 00:3580 $cb $2f
    sra  A                                             ;; 00:3582 $cb $2f
    sra  A                                             ;; 00:3584 $cb $2f
    sra  A                                             ;; 00:3586 $cb $2f
    ld   C, A                                          ;; 00:3588 $4f
    cp   A, $80                                        ;; 00:3589 $fe $80
    ld   A, $ff                                        ;; 00:358b $3e $ff
    adc  A, $00                                        ;; 00:358d $ce $00
    ld   B, A                                          ;; 00:358f $47
    call call_00_37d8                                  ;; 00:3590 $cd $d8 $37
    pop  BC                                            ;; 00:3593 $c1
    jp   call_00_35d5                                   ;; 00:3594 $c3 $d5 $35

call_00_3597:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    ldi  a,[hl]
    ld   c,a
    ld   a,[hl]
    and  a,$0F
    add  c
    ldi  [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    push bc
    ldi  a,[hl]
    ld   c,a
    ld   a,[hl]
    and  a,$0F
    add  c
    ld   [hl],a
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    call call_00_37d8
    pop  bc
    jp   call_00_37c9

call_00_35d5:
    ld   H, $d2                                        ;; 00:35d5 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:35d7 $fa $00 $d3
    or   A, $0e                                        ;; 00:35da $f6 $0e
    ld   L, A                                          ;; 00:35dc $6f
    ld   A, [HL]                                       ;; 00:35dd $7e
    add  A, C                                          ;; 00:35de $81
    ld   [HL+], A                                      ;; 00:35df $22
    ld   E, A                                          ;; 00:35e0 $5f
    ld   A, [HL]                                       ;; 00:35e1 $7e
    adc  A, B                                          ;; 00:35e2 $88
    ld   [HL], A                                       ;; 00:35e3 $77
    ld   D, A                                          ;; 00:35e4 $57
    ld   A, L                                          ;; 00:35e5 $7d
    and  A, $e0                                        ;; 00:35e6 $e6 $e0
    ld   HL, wD74D                                     ;; 00:35e8 $21 $4d $d7
    cp   A, [HL]                                       ;; 00:35eb $be
    jr   NZ, .jr_00_35f3                               ;; 00:35ec $20 $05
    ld   A, C                                          ;; 00:35ee $79
    ld   [wD75C], A                                    ;; 00:35ef $ea $5c $d7
    ret                                                ;; 00:35f2 $c9
.jr_00_35f3:
    ld   HL, wD74F                                     ;; 00:35f3 $21 $4f $d7
    cp   A, [HL]                                       ;; 00:35f6 $be
    ret  NZ                                            ;; 00:35f7 $c0
    ld   H, $d2                                        ;; 00:35f8 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:35fa $fa $00 $d3
    or   A, $12                                        ;; 00:35fd $f6 $12
    ld   L, A                                          ;; 00:35ff $6f
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 00:3600 $fa $12 $d2
    cp   A, [HL]                                       ;; 00:3603 $be
    jr   C, .jr_00_3616                                ;; 00:3604 $38 $10
    ld   A, L                                          ;; 00:3606 $7d
    xor  A, $06                                        ;; 00:3607 $ee $06
    ld   L, A                                          ;; 00:3609 $6f
    ld   A, E                                          ;; 00:360a $7b
    add  A, [HL]                                       ;; 00:360b $86
    ld   [wD20E_PlayerXPosition], A                                    ;; 00:360c $ea $0e $d2
    ld   A, D                                          ;; 00:360f $7a
    adc  A, $00                                        ;; 00:3610 $ce $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 00:3612 $ea $0f $d2
    ret                                                ;; 00:3615 $c9
.jr_00_3616:
    ld   A, L                                          ;; 00:3616 $7d
    xor  A, $06                                        ;; 00:3617 $ee $06
    ld   L, A                                          ;; 00:3619 $6f
    ld   C, [HL]                                       ;; 00:361a $4e
    inc  C                                             ;; 00:361b $0c
    ld   A, E                                          ;; 00:361c $7b
    sub  A, C                                          ;; 00:361d $91
    ld   [wD20E_PlayerXPosition], A                                    ;; 00:361e $ea $0e $d2
    ld   A, D                                          ;; 00:3621 $7a
    sbc  A, $00                                        ;; 00:3622 $de $00
    ld   [wD20F_PlayerXPosition], A                                    ;; 00:3624 $ea $0f $d2
    ret                                                ;; 00:3627 $c9

call_00_3628:
    ld   A, [wD74D]                                    ;; 00:3628 $fa $4d $d7
    ld   [wD9C7], A                                    ;; 00:362b $ea $c7 $d9
    ld   A, [wD74E]                                    ;; 00:362e $fa $4e $d7
    ld   [wD9C8], A                                    ;; 00:3631 $ea $c8 $d9
    ld   A, [wD74F]                                    ;; 00:3634 $fa $4f $d7
    ld   [wD9C9], A                                    ;; 00:3637 $ea $c9 $d9
    ld   A, [wD688]                                    ;; 00:363a $fa $88 $d6
    ld   [wD9CA], A                                    ;; 00:363d $ea $ca $d9
    ld   A, $a0                                        ;; 00:3640 $3e $a0
    ld   [wD688], A                                    ;; 00:3642 $ea $88 $d6
    ld   HL, wD000_ObjectFlags                                     ;; 00:3645 $21 $00 $d0
    ld   DE, wD79F                                     ;; 00:3648 $11 $9f $d7
    ld   BC, $100                                      ;; 00:364b $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:364e $cd $b0 $07
    ld   HL, wD200_PlayerObject_Id                                     ;; 00:3651 $21 $00 $d2
    ld   DE, wD89F                                     ;; 00:3654 $11 $9f $d8
    ld   BC, $100                                      ;; 00:3657 $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:365a $cd $b0 $07
    ld   HL, wD301                                     ;; 00:365d $21 $01 $d3
    ld   DE, wD99F                                     ;; 00:3660 $11 $9f $d9
    ld   BC, $08                                       ;; 00:3663 $01 $08 $00
    call call_00_07b0_MemCopy                                  ;; 00:3666 $cd $b0 $07
    ld   HL, wD309                                     ;; 00:3669 $21 $09 $d3
    ld   DE, wD9A7                                     ;; 00:366c $11 $a7 $d9
    ld   BC, $20                                       ;; 00:366f $01 $20 $00
    jp   call_00_07b0_MemCopy                                  ;; 00:3672 $c3 $b0 $07

call_00_3675:
    ld   A, [wD9C7]                                    ;; 00:3675 $fa $c7 $d9
    ld   [wD74D], A                                    ;; 00:3678 $ea $4d $d7
    ld   A, [wD9C8]                                    ;; 00:367b $fa $c8 $d9
    ld   [wD74E], A                                    ;; 00:367e $ea $4e $d7
    ld   A, [wD9C9]                                    ;; 00:3681 $fa $c9 $d9
    ld   [wD74F], A                                    ;; 00:3684 $ea $4f $d7
    ld   A, [wD9CA]                                    ;; 00:3687 $fa $ca $d9
    ld   [wD688], A                                    ;; 00:368a $ea $88 $d6
    ld   HL, wD79F                                     ;; 00:368d $21 $9f $d7
    ld   DE, wD000_ObjectFlags                                     ;; 00:3690 $11 $00 $d0
    ld   BC, $100                                      ;; 00:3693 $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:3696 $cd $b0 $07
    ld   HL, wD89F                                     ;; 00:3699 $21 $9f $d8
    ld   DE, wD200_PlayerObject_Id                                     ;; 00:369c $11 $00 $d2
    ld   BC, $100                                      ;; 00:369f $01 $00 $01
    call call_00_07b0_MemCopy                                  ;; 00:36a2 $cd $b0 $07
    ld   HL, wD99F                                     ;; 00:36a5 $21 $9f $d9
    ld   DE, wD301                                     ;; 00:36a8 $11 $01 $d3
    ld   BC, $08                                       ;; 00:36ab $01 $08 $00
    call call_00_07b0_MemCopy                                  ;; 00:36ae $cd $b0 $07
    ld   HL, wD9A7                                     ;; 00:36b1 $21 $a7 $d9
    ld   DE, wD309                                     ;; 00:36b4 $11 $09 $d3
    ld   BC, $20                                       ;; 00:36b7 $01 $20 $00
    jp   call_00_07b0_MemCopy                                  ;; 00:36ba $c3 $b0 $07

call_00_36bd:
    ld   H, $d2                                        ;; 00:36bd $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:36bf $fa $00 $d3
    or   A, $0e                                        ;; 00:36c2 $f6 $0e
    ld   L, A                                          ;; 00:36c4 $6f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:36c5 $fa $0e $d2
    sub  A, [HL]                                       ;; 00:36c8 $96
    inc  HL                                            ;; 00:36c9 $23
    ld   A, [wD20F_PlayerXPosition]                                    ;; 00:36ca $fa $0f $d2
    sbc  A, [HL]                                       ;; 00:36cd $9e
    ld   C, $20                                        ;; 00:36ce $0e $20
    jr   C, .jr_00_36d4                                ;; 00:36d0 $38 $02
    ld   C, $00                                        ;; 00:36d2 $0e $00
.jr_00_36d4:
    ld   A, L                                          ;; 00:36d4 $7d
    xor  A, $02                                        ;; 00:36d5 $ee $02
    ld   L, A                                          ;; 00:36d7 $6f
    ld   [HL], C                                       ;; 00:36d8 $71
    ret                                                ;; 00:36d9 $c9
    
call_00_36da:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ld   a,[wD20E_PlayerXPosition]
    sub  [hl]
    inc  hl
    ld   a,[wD20F_PlayerXPosition]
    sbc  [hl]
    ld   c,$00
    jr   c,.jr_02_36F1
    ld   c,$20
.jr_02_36F1:
    ld   a,l
    xor  a,$02
    ld   l,a
    ld   [hl],c
    ret  

call_00_36f7:
    ld   H, $d2                                        ;; 00:36f7 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:36f9 $fa $00 $d3
    or   A, $0d                                        ;; 00:36fc $f6 $0d
    ld   L, A                                          ;; 00:36fe $6f
    ld   C, [HL]                                       ;; 00:36ff $4e
    ld   A, L                                          ;; 00:3700 $7d
    xor  A, $11                                        ;; 00:3701 $ee $11
    ld   L, A                                          ;; 00:3703 $6f
    ld   A, [HL+]                                      ;; 00:3704 $2a
    bit  5, C                                          ;; 00:3705 $cb $69
    jr   Z, .jr_00_370b                                ;; 00:3707 $28 $02
    cpl                                                ;; 00:3709 $2f
    inc  A                                             ;; 00:370a $3c
.jr_00_370b:
    add  A, [HL]                                       ;; 00:370b $86
    ld   C, A                                          ;; 00:370c $4f
    and  A, $0f                                        ;; 00:370d $e6 $0f
    ld   [HL], A                                       ;; 00:370f $77
    ld   A, C                                          ;; 00:3710 $79
    sra  A                                             ;; 00:3711 $cb $2f
    sra  A                                             ;; 00:3713 $cb $2f
    sra  A                                             ;; 00:3715 $cb $2f
    sra  A                                             ;; 00:3717 $cb $2f
    ld   C, A                                          ;; 00:3719 $4f
    cp   A, $80                                        ;; 00:371a $fe $80
    ld   A, $ff                                        ;; 00:371c $3e $ff
    adc  A, $00                                        ;; 00:371e $ce $00
    ld   B, A                                          ;; 00:3720 $47
    ld   A, L                                          ;; 00:3721 $7d
    xor  A, $13                                        ;; 00:3722 $ee $13
    ld   L, A                                          ;; 00:3724 $6f
    ld   A, [HL]                                       ;; 00:3725 $7e
    add  A, C                                          ;; 00:3726 $81
    ld   [HL+], A                                      ;; 00:3727 $22
    ld   C, A                                          ;; 00:3728 $4f
    ld   A, [HL]                                       ;; 00:3729 $7e
    adc  A, B                                          ;; 00:372a $88
    ld   [HL], A                                       ;; 00:372b $77
    ld   L, C                                          ;; 00:372c $69
    ld   H, A                                          ;; 00:372d $67
    add  HL, HL                                        ;; 00:372e $29
    add  HL, HL                                        ;; 00:372f $29
    add  HL, HL                                        ;; 00:3730 $29
    ld   D, H                                          ;; 00:3731 $54
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3732 $fa $00 $d3
    rrca                                               ;; 00:3735 $0f
    rrca                                               ;; 00:3736 $0f
    rrca                                               ;; 00:3737 $0f
    and  A, $1c                                        ;; 00:3738 $e6 $1c
    ld   L, A                                          ;; 00:373a $6f
    ld   H, $00                                        ;; 00:373b $26 $00
    ld   BC, wD309                                     ;; 00:373d $01 $09 $d3
    add  HL, BC                                        ;; 00:3740 $09
    ld   B, [HL]                                       ;; 00:3741 $46
    dec  B                                             ;; 00:3742 $05
    inc  HL                                            ;; 00:3743 $23
    ld   C, [HL]                                       ;; 00:3744 $4e
    inc  C                                             ;; 00:3745 $0c
    ld   A, D                                          ;; 00:3746 $7a
    cp   A, C                                          ;; 00:3747 $b9
    ld   C, $00                                        ;; 00:3748 $0e $00
    jr   C, .jr_00_3754                                ;; 00:374a $38 $08
    ld   A, B                                          ;; 00:374c $78
    cp   A, D                                          ;; 00:374d $ba
    ld   C, $20                                        ;; 00:374e $0e $20
    jr   C, .jr_00_3754                                ;; 00:3750 $38 $02
    xor  A, A                                          ;; 00:3752 $af
    ret                                                ;; 00:3753 $c9
.jr_00_3754:
    ld   H, $d2                                        ;; 00:3754 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3756 $fa $00 $d3
    or   A, $0d                                        ;; 00:3759 $f6 $0d
    ld   L, A                                          ;; 00:375b $6f
    ld   A, [HL]                                       ;; 00:375c $7e
    ld   [HL], C                                       ;; 00:375d $71
    cp   A, C                                          ;; 00:375e $b9
    ret                                                ;; 00:375f $c9
    
call_00_3760:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   c,[hl]
    ld   a,l
    xor  a,$11
    ld   l,a
    ldi  a,[hl]
    bit  6,c
    jr   nz,.jr_02_3774
    cpl  
    inc  a
.jr_02_3774:
    add  [hl]
    ld   c,a
    and  a,$0F
    ld   [hl],a
    ld   a,c
    sra  a
    sra  a
    sra  a
    sra  a
    ld   c,a
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$0D
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   c,a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    ld   l,c
    ld   h,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   d,h
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca 
    rrca 
    rrca 
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   bc,wD30B
    add  hl,bc
    ld   b,[hl]
    dec  b
    inc  hl
    ld   c,[hl]
    inc  c
    ld   a,d
    cp   c
    ld   c,$40
    jr   c,.jr_02_37BD
    ld   a,b
    cp   d
    ld   c,$00
    jr   c,.jr_02_37BD
    xor  a
    ret  
.jr_02_37BD:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   a,[hl]
    ld   [hl],c
    cp   c
    ret  

call_00_37c9:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ld   a,[hl]
    add  c
    ldi  [hl],a
    ld   a,[hl]
    adc  b
    ld   [hl],a
    ret  

call_00_37d8:
    ld   H, $d2                                        ;; 00:37d8 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:37da $fa $00 $d3
    or   A, $10                                        ;; 00:37dd $f6 $10
    ld   L, A                                          ;; 00:37df $6f
    ld   A, [HL]                                       ;; 00:37e0 $7e
    add  A, C                                          ;; 00:37e1 $81
    ld   [HL+], A                                      ;; 00:37e2 $22
    ld   A, [HL]                                       ;; 00:37e3 $7e
    adc  A, B                                          ;; 00:37e4 $88
    ld   [HL], A                                       ;; 00:37e5 $77
    ret                                                ;; 00:37e6 $c9

call_00_37e7:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:37e7 $fa $00 $d3
    rlca                                               ;; 00:37ea $07
    rlca                                               ;; 00:37eb $07
    rlca                                               ;; 00:37ec $07
    and  A, $07                                        ;; 00:37ed $e6 $07
    ld   L, A                                          ;; 00:37ef $6f
    ld   H, $00                                        ;; 00:37f0 $26 $00
    ld   DE, wD32D                                     ;; 00:37f2 $11 $2d $d3
    add  HL, DE                                        ;; 00:37f5 $19
    ld   [HL], C                                       ;; 00:37f6 $71
    ret                                                ;; 00:37f7 $c9

call_00_37f8:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    ld   [hl],c
    ret  

call_00_3802:
    ld   H, $d2                                        ;; 00:3802 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3804 $fa $00 $d3
    or   A, $18                                        ;; 00:3807 $f6 $18
    ld   L, A                                          ;; 00:3809 $6f
    ld   [HL], C                                       ;; 00:380a $71
    ret                                                ;; 00:380b $c9
    
call_00_380c:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    ld   a,[hl]
    and  a
    ret  

call_00_3817:
    ld   H, $d2                                        ;; 00:3817 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3819 $fa $00 $d3
    or   A, $18                                        ;; 00:381c $f6 $18
    ld   L, A                                          ;; 00:381e $6f
    ld   A, [HL]                                       ;; 00:381f $7e
    and  A, A                                          ;; 00:3820 $a7
    ret  Z                                             ;; 00:3821 $c8
    dec  [HL]                                          ;; 00:3822 $35
    ld   A, [HL]                                       ;; 00:3823 $7e
    ret                                                ;; 00:3824 $c9

call_00_3825:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$16
    ld   l,a
    ld   [hl],c
    ret  

call_00_382f:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$14
    ld   l,a
    ld   [hl],c
    ret  

    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$07
    ld   l,a
    ld   a,[hl]
    ret  

call_00_3843:
    ld   H, $d2                                        ;; 00:3843 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3845 $fa $00 $d3
    or   A, $0a                                        ;; 00:3848 $f6 $0a
    ld   L, A                                          ;; 00:384a $6f
    bit  2, [HL]                                       ;; 00:384b $cb $56
    ret                                                ;; 00:384d $c9

    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0A
    ld   l,a
    bit  6,[hl]
    ret  

call_00_3859:
    ld   H, $d2                                        ;; 00:3859 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:385b $fa $00 $d3
    or   A, $0e                                        ;; 00:385e $f6 $0e
    ld   L, A                                          ;; 00:3860 $6f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 00:3861 $fa $0e $d2
    sub  A, [HL]                                       ;; 00:3864 $96
    ld   E, A                                          ;; 00:3865 $5f
    inc  HL                                            ;; 00:3866 $23
    ld   A, [wD20F_PlayerXPosition]                                    ;; 00:3867 $fa $0f $d2
    sbc  A, [HL]                                       ;; 00:386a $9e
    ld   D, A                                          ;; 00:386b $57
    ld   L, C                                          ;; 00:386c $69
    ld   H, $00                                        ;; 00:386d $26 $00
    add  HL, DE                                        ;; 00:386f $19
    sla  C                                             ;; 00:3870 $cb $21
    ld   A, L                                          ;; 00:3872 $7d
    sub  A, C                                          ;; 00:3873 $91
    ld   A, H                                          ;; 00:3874 $7c
    sbc  A, $00                                        ;; 00:3875 $de $00
    ret                                                ;; 00:3877 $c9

call_00_3878:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:3878 $fa $24 $d6
    and  A, A                                          ;; 00:387b $a7
    jr   Z, jr_00_3899                                 ;; 00:387c $28 $1b
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:387e $fa $00 $d3
    rlca                                               ;; 00:3881 $07
    rlca                                               ;; 00:3882 $07
    rlca                                               ;; 00:3883 $07
    and  A, $07                                        ;; 00:3884 $e6 $07
    ld   E, A                                          ;; 00:3886 $5f
    ld   D, $00                                        ;; 00:3887 $16 $00
    ld   HL, wD301                                     ;; 00:3889 $21 $01 $d3
    add  HL, DE                                        ;; 00:388c $19
    ld   A, [HL]                                       ;; 00:388d $7e
    dec  A                                             ;; 00:388e $3d
    srl  A                                             ;; 00:388f $cb $3f
    ld   E, A                                          ;; 00:3891 $5f
    ld   HL, wD798                                     ;; 00:3892 $21 $98 $d7
    add  HL, DE                                        ;; 00:3895 $19
    ld   A, [HL]                                       ;; 00:3896 $7e
    and  A, A                                          ;; 00:3897 $a7
    ret                                                ;; 00:3898 $c9

jr_00_3899:
    ld   H, $d2                                        ;; 00:3899 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:389b $fa $00 $d3
    or   A, $19                                        ;; 00:389e $f6 $19
    ld   L, A                                          ;; 00:38a0 $6f
    ld   A, [wD64F]                                    ;; 00:38a1 $fa $4f $d6
    and  A, $7f                                        ;; 00:38a4 $e6 $7f
    cp   A, [HL]                                       ;; 00:38a6 $be
    jr   C, .jr_00_38bf                                ;; 00:38a7 $38 $16
    inc  L                                             ;; 00:38a9 $2c
    ld   A, [wD650]                                    ;; 00:38aa $fa $50 $d6
    and  A, $7f                                        ;; 00:38ad $e6 $7f
    cp   A, [HL]                                       ;; 00:38af $be
    jr   C, .jr_00_38bf                                ;; 00:38b0 $38 $0d
    inc  L                                             ;; 00:38b2 $2c
    ld   A, [wD651]                                    ;; 00:38b3 $fa $51 $d6
    and  A, $7f                                        ;; 00:38b6 $e6 $7f
    cp   A, [HL]                                       ;; 00:38b8 $be
    jr   C, .jr_00_38bf                                ;; 00:38b9 $38 $04
    ld   A, $01                                        ;; 00:38bb $3e $01
    and  A, A                                          ;; 00:38bd $a7
    ret                                                ;; 00:38be $c9
.jr_00_38bf:
    xor  A, A                                          ;; 00:38bf $af
    ret                                                ;; 00:38c0 $c9

call_00_38c1:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:38c1 $fa $24 $d6
    and  A, A                                          ;; 00:38c4 $a7
    jr   Z, jr_00_3899                                 ;; 00:38c5 $28 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:38c7 $fa $00 $d3
    rlca                                               ;; 00:38ca $07
    rlca                                               ;; 00:38cb $07
    rlca                                               ;; 00:38cc $07
    and  A, $07                                        ;; 00:38cd $e6 $07
    ld   E, A                                          ;; 00:38cf $5f
    ld   D, $00                                        ;; 00:38d0 $16 $00
    ld   HL, wD301                                     ;; 00:38d2 $21 $01 $d3
    add  HL, DE                                        ;; 00:38d5 $19
    ld   A, [HL]                                       ;; 00:38d6 $7e
    dec  A                                             ;; 00:38d7 $3d
    srl  A                                             ;; 00:38d8 $cb $3f
    ld   E, A                                          ;; 00:38da $5f
    ld   HL, .data_02_38ed                                     ;; 00:38db $21 $ed $38
    add  HL, DE                                        ;; 00:38de $19
    ld   A, [HL]                                       ;; 00:38df $7e
    ld   HL, wD624_CurrentLevelId                                     ;; 00:38e0 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:38e3 $6e
    ld   H, $00                                        ;; 00:38e4 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 00:38e6 $11 $29 $d6
    add  HL, DE                                        ;; 00:38e9 $19
    and  A, [HL]                                       ;; 00:38ea $a6
    ld   E, A                                          ;; 00:38eb $5f
    ret                                                ;; 00:38ec $c9
.data_02_38ed:
    db   $01, $02, $04                                 ;; 00:38ed .?.

call_00_38f0:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:38f0 $fa $00 $d3
    push AF                                            ;; 00:38f3 $f5
    ld   A, $20                                        ;; 00:38f4 $3e $20
.jr_00_38f6:
    ld   [wD300_CurrentEntityAddrLo], A                                    ;; 00:38f6 $ea $00 $d3
    or   A, $00                                        ;; 00:38f9 $f6 $00
    ld   L, A                                          ;; 00:38fb $6f
    ld   H, $d2                                        ;; 00:38fc $26 $d2
    ld   A, [HL]                                       ;; 00:38fe $7e
    cp   A, $ff                                        ;; 00:38ff $fe $ff
    call NZ, call_00_3910                              ;; 00:3901 $c4 $10 $39
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3904 $fa $00 $d3
    add  A, $20                                        ;; 00:3907 $c6 $20
    jr   NZ, .jr_00_38f6                               ;; 00:3909 $20 $eb
    pop  AF                                            ;; 00:390b $f1
    ld   [wD300_CurrentEntityAddrLo], A                                    ;; 00:390c $ea $00 $d3
    ret                                                ;; 00:390f $c9

call_00_3910:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3910 $fa $00 $d3
    or   A, $00                                        ;; 00:3913 $f6 $00
    ld   L, A                                          ;; 00:3915 $6f
    ld   H, $d2                                        ;; 00:3916 $26 $d2
    ld   [HL], $ff                                     ;; 00:3918 $36 $ff
    ld   A, L                                          ;; 00:391a $7d
    rlca                                               ;; 00:391b $07
    rlca                                               ;; 00:391c $07
    rlca                                               ;; 00:391d $07
    and  A, $07                                        ;; 00:391e $e6 $07
    ld   L, A                                          ;; 00:3920 $6f
    ld   H, $00                                        ;; 00:3921 $26 $00
    ld   DE, wD301                                     ;; 00:3923 $11 $01 $d3
    add  HL, DE                                        ;; 00:3926 $19
    ld   L, [HL]                                       ;; 00:3927 $6e
    ld   H, $d0                                        ;; 00:3928 $26 $d0
    ld   A, [HL]                                       ;; 00:392a $7e
    cp   A, $ff                                        ;; 00:392b $fe $ff
    ret  Z                                             ;; 00:392d $c8
    ld   [HL], $00                                     ;; 00:392e $36 $00
    ret                                                ;; 00:3930 $c9

call_00_3931:
    ld   H, $d2                                        ;; 00:3931 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3933 $fa $00 $d3
    or   A, $00                                        ;; 00:3936 $f6 $00
    ld   L, A                                          ;; 00:3938 $6f
    ld   [HL], $ff                                     ;; 00:3939 $36 $ff
    ret                                                ;; 00:393b $c9

call_00_393c:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:393c $fa $00 $d3
    rlca                                               ;; 00:393f $07
    rlca                                               ;; 00:3940 $07
    rlca                                               ;; 00:3941 $07
    and  A, $07                                        ;; 00:3942 $e6 $07
    ld   L, A                                          ;; 00:3944 $6f
    ld   H, $00                                        ;; 00:3945 $26 $00
    ld   DE, wD301                                     ;; 00:3947 $11 $01 $d3
    add  HL, DE                                        ;; 00:394a $19
    ld   L, [HL]                                       ;; 00:394b $6e
    ld   H, $d0                                        ;; 00:394c $26 $d0
    ld   [HL], $ff                                     ;; 00:394e $36 $ff
    ret                                                ;; 00:3950 $c9

    ld   h,$D2
    ld   a,$20
.jr_02_3955:
    ld   l,a
    ld   a,[hl]
    cp   a,$FF
    jr   z,.jr_02_3961
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_3955
    ret  
.jr_02_3961:
    ld   a,[wD300_CurrentEntityAddrLo]
    push af
    ld   a,l
    ld   [wD300_CurrentEntityAddrLo],a
    or   a,$0E
    ld   l,a
    ld   de,wD20E_PlayerXPosition
    ld   a,[de]
    ldi  [hl],a
    inc  de
    ld   a,[de]
    ldi  [hl],a
    inc  de
    ld   a,[de]
    ldi  [hl],a
    inc  de
    ld   a,[de]
    ld   [hl],a
    call call_00_34d8
    call call_00_3985
    pop  af
    ld   [wD300_CurrentEntityAddrLo],a
    ret  

call_00_3985:
    ld   C, $01                                        ;; 00:3985 $0e $01
    call call_00_37e7                                  ;; 00:3987 $cd $e7 $37
    ld   H, $d2                                        ;; 00:398a $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:398c $fa $00 $d3
    or   A, $16                                        ;; 00:398f $f6 $16
    ld   L, A                                          ;; 00:3991 $6f
    ld   [HL], $00                                     ;; 00:3992 $36 $00
    ld   A, L                                          ;; 00:3994 $7d
    xor  A, $16                                        ;; 00:3995 $ee $16
    ld   L, A                                          ;; 00:3997 $6f
    ld   [HL], $07                                     ;; 00:3998 $36 $07
    ld   A, L                                          ;; 00:399a $7d
    xor  A, $17                                        ;; 00:399b $ee $17
    ld   L, A                                          ;; 00:399d $6f
    ld   [HL], $00                                     ;; 00:399e $36 $00
    ld   A, L                                          ;; 00:39a0 $7d
    xor  A, $1a                                        ;; 00:39a1 $ee $1a
    ld   L, A                                          ;; 00:39a3 $6f
    ld   [HL], $00                                     ;; 00:39a4 $36 $00
    ld   C, $01                                        ;; 00:39a6 $0e $01
    call call_00_3a23                                  ;; 00:39a8 $cd $23 $3a
    call call_00_393c                                  ;; 00:39ab $cd $3c $39
    xor  A, A                                          ;; 00:39ae $af
    ld   [wD59D_ReturnBank], A                                    ;; 00:39af $ea $9d $d5
    ld   A, Bank02                                        ;; 00:39b2 $3e $02
    ld   HL, call_02_7102_SetEntityAction                                     ;; 00:39b4 $21 $02 $71
    call call_00_1078_FarCall                                  ;; 00:39b7 $cd $78 $10
    ld   C, $17                                        ;; 00:39ba $0e $17
    call call_00_112f                                  ;; 00:39bc $cd $2f $11
    ret                                                ;; 00:39bf $c9
data_00_39c0:
    dw   wD33C
data_00_39c2:
    dw   wD444, wD35D, wD46C
    dw   wD37E, wD494, wD39F, wD4BC
    dw   wD3C0, wD4E4, wD3E1, wD50C
    dw   wD402, wD534, wD423, wD55C

call_00_39e0:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:39e0 $fa $00 $d3
    rlca                                               ;; 00:39e3 $07
    rlca                                               ;; 00:39e4 $07
    rlca                                               ;; 00:39e5 $07
    and  A, $07                                        ;; 00:39e6 $e6 $07
    ld   L, A                                          ;; 00:39e8 $6f
    ld   H, $00                                        ;; 00:39e9 $26 $00
    add  HL, HL                                        ;; 00:39eb $29
    add  HL, HL                                        ;; 00:39ec $29
    ld   DE, data_00_39c0                                     ;; 00:39ed $11 $c0 $39
    add  HL, DE                                        ;; 00:39f0 $19
    ld   E, [HL]                                       ;; 00:39f1 $5e
    inc  HL                                            ;; 00:39f2 $23
    ld   D, [HL]                                       ;; 00:39f3 $56
    ret                                                ;; 00:39f4 $c9

call_00_39f5:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:39f5 $fa $00 $d3
    rlca                                               ;; 00:39f8 $07
    rlca                                               ;; 00:39f9 $07
    rlca                                               ;; 00:39fa $07
    and  A, $07                                        ;; 00:39fb $e6 $07
    ld   L, A                                          ;; 00:39fd $6f
    ld   H, $00                                        ;; 00:39fe $26 $00
    add  HL, HL                                        ;; 00:3a00 $29
    add  HL, HL                                        ;; 00:3a01 $29
    ld   DE, data_00_39c2                                     ;; 00:3a02 $11 $c2 $39
    add  HL, DE                                        ;; 00:3a05 $19
    ld   E, [HL]                                       ;; 00:3a06 $5e
    inc  HL                                            ;; 00:3a07 $23
    ld   D, [HL]                                       ;; 00:3a08 $56
    ret                                                ;; 00:3a09 $c9

call_00_3a0a:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3a0a $fa $00 $d3
    rlca                                               ;; 00:3a0d $07
    rlca                                               ;; 00:3a0e $07
    rlca                                               ;; 00:3a0f $07
    and  A, $07                                        ;; 00:3a10 $e6 $07
    ld   L, A                                          ;; 00:3a12 $6f
    ld   H, $00                                        ;; 00:3a13 $26 $00
    add  HL, HL                                        ;; 00:3a15 $29
    add  HL, HL                                        ;; 00:3a16 $29
    ld   DE, data_00_39c0                                     ;; 00:3a17 $11 $c0 $39
    add  HL, DE                                        ;; 00:3a1a $19
    ld   E, [HL]                                       ;; 00:3a1b $5e
    inc  HL                                            ;; 00:3a1c $23
    ld   D, [HL]                                       ;; 00:3a1d $56
    inc  HL                                            ;; 00:3a1e $23
    ld   A, [HL+]                                      ;; 00:3a1f $2a
    ld   H, [HL]                                       ;; 00:3a20 $66
    ld   L, A                                          ;; 00:3a21 $6f
    ret                                                ;; 00:3a22 $c9

call_00_3a23:
    ld   L, C                                          ;; 00:3a23 $69
    ld   H, $00                                        ;; 00:3a24 $26 $00
    add  HL, HL                                        ;; 00:3a26 $29
    ld   DE, .data_00_3a67                                     ;; 00:3a27 $11 $67 $3a
    add  HL, DE                                        ;; 00:3a2a $19
    ld   E, [HL]                                       ;; 00:3a2b $5e
    inc  HL                                            ;; 00:3a2c $23
    ld   D, [HL]                                       ;; 00:3a2d $56
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3a2e $fa $00 $d3
    rlca                                               ;; 00:3a31 $07
    rlca                                               ;; 00:3a32 $07
    rlca                                               ;; 00:3a33 $07
    and  A, $07                                        ;; 00:3a34 $e6 $07
    ld   L, A                                          ;; 00:3a36 $6f
    ld   H, $00                                        ;; 00:3a37 $26 $00
    add  HL, HL                                        ;; 00:3a39 $29
    add  HL, HL                                        ;; 00:3a3a $29
    ld   BC, data_00_39c0                                     ;; 00:3a3b $01 $c0 $39
    add  HL, BC                                        ;; 00:3a3e $09
    ld   C, [HL]                                       ;; 00:3a3f $4e
    inc  HL                                            ;; 00:3a40 $23
    ld   B, [HL]                                       ;; 00:3a41 $46
    inc  HL                                            ;; 00:3a42 $23
    xor  A, A                                          ;; 00:3a43 $af
    ld   [BC], A                                       ;; 00:3a44 $02
    ld   A, [HL+]                                      ;; 00:3a45 $2a
    ld   H, [HL]                                       ;; 00:3a46 $66
    ld   L, A                                          ;; 00:3a47 $6f
    ld   B, $08                                        ;; 00:3a48 $06 $08
.jr_00_3a4a:
    ld   A, [DE]                                       ;; 00:3a4a $1a
    ld   [HL+], A                                      ;; 00:3a4b $22
    inc  DE                                            ;; 00:3a4c $13
    ld   A, [DE]                                       ;; 00:3a4d $1a
    ld   [HL+], A                                      ;; 00:3a4e $22
    inc  DE                                            ;; 00:3a4f $13
    ld   A, [DE]                                       ;; 00:3a50 $1a
    ld   [HL+], A                                      ;; 00:3a51 $22
    inc  DE                                            ;; 00:3a52 $13
    ld   A, [DE]                                       ;; 00:3a53 $1a
    ld   [HL+], A                                      ;; 00:3a54 $22
    inc  DE                                            ;; 00:3a55 $13
    ld   A, [DE]                                       ;; 00:3a56 $1a
    ld   [HL+], A                                      ;; 00:3a57 $22
    inc  DE                                            ;; 00:3a58 $13
    dec  B                                             ;; 00:3a59 $05
    jr   NZ, .jr_00_3a4a                               ;; 00:3a5a $20 $ee
    ld   H, $d2                                        ;; 00:3a5c $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3a5e $fa $00 $d3
    or   A, $0a                                        ;; 00:3a61 $f6 $0a
    ld   L, A                                          ;; 00:3a63 $6f
    set  0, [HL]                                       ;; 00:3a64 $cb $c6
    ret                                                ;; 00:3a66 $c9
.data_00_3a67:
    db   $75, $3a                                      ;; 00:3a67 ??
    dw   .data_00_3a9d                                 ;; 00:3a69 pP
    dw   .data_00_3ac5                                 ;; 00:3a6b pP
    db   $ed, $3a, $15, $3b, $3d, $3b, $65, $3b        ;; 00:3a6d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a75 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a7d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a85 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a8d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3a95 ????????
.data_00_3a9d:
    db   $81, $40, $00, $04, $01, $81, $30, $00        ;; 00:3a9d ........
    db   $03, $01, $81, $20, $00, $02, $01, $81        ;; 00:3aa5 ........
    db   $18, $00, $01, $01, $81, $40, $00, $04        ;; 00:3aad ........
    db   $ff, $81, $30, $00, $03, $ff, $81, $20        ;; 00:3ab5 ........
    db   $00, $02, $ff, $81, $18, $00, $01, $ff        ;; 00:3abd ........
.data_00_3ac5:
    db   $81, $24, $00, $00, $00, $81, $20, $00        ;; 00:3ac5 ........
    db   $06, $01, $81, $20, $00, $06, $ff, $00        ;; 00:3acd ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3ad5 ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3add ........
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3ae5 ........
    db   $81, $24, $00, $00, $00, $81, $20, $00        ;; 00:3aed ????????
    db   $06, $01, $81, $20, $00, $06, $ff, $81        ;; 00:3af5 ????????
    db   $1c, $00, $0e, $01, $81, $1c, $00, $0e        ;; 00:3afd ????????
    db   $ff, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b05 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b0d ????????
    db   $01, $30, $10, $0c, $fb, $01, $20, $10        ;; 00:3b15 ????????
    db   $04, $ff, $01, $38, $10, $04, $05, $01        ;; 00:3b1d ????????
    db   $2e, $00, $0e, $fb, $01, $2c, $00, $06        ;; 00:3b25 ????????
    db   $01, $01, $26, $00, $0d, $05, $00, $00        ;; 00:3b2d ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b35 ????????
    db   $01, $28, $10, $09, $f3, $01, $1a, $10        ;; 00:3b3d ????????
    db   $01, $fc, $01, $2e, $10, $02, $06, $01        ;; 00:3b45 ????????
    db   $26, $00, $0b, $f6, $01, $24, $00, $03        ;; 00:3b4d ????????
    db   $05, $01, $21, $00, $0a, $03, $00, $00        ;; 00:3b55 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:3b5d ????????
    db   $81, $40, $0c, $0c, $01, $81, $30, $0c        ;; 00:3b65 ????????
    db   $09, $01, $81, $20, $0c, $06, $01, $81        ;; 00:3b6d ????????
    db   $18, $0c, $03, $01, $81, $40, $0c, $0c        ;; 00:3b75 ????????
    db   $ff, $81, $30, $0c, $09, $ff, $81, $20        ;; 00:3b7d ????????
    db   $0c, $06, $ff, $81, $18, $0c, $03, $ff        ;; 00:3b85 ????????

call_00_3b8d:
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3b8d $fa $00 $d3
    rlca                                               ;; 00:3b90 $07
    rlca                                               ;; 00:3b91 $07
    rlca                                               ;; 00:3b92 $07
    and  A, $07                                        ;; 00:3b93 $e6 $07
    ld   L, A                                          ;; 00:3b95 $6f
    ld   H, $00                                        ;; 00:3b96 $26 $00
    add  HL, HL                                        ;; 00:3b98 $29
    add  HL, HL                                        ;; 00:3b99 $29
    ld   DE, data_00_39c2                                     ;; 00:3b9a $11 $c2 $39
    add  HL, DE                                        ;; 00:3b9d $19
    ld   A, [HL+]                                      ;; 00:3b9e $2a
    ld   H, [HL]                                       ;; 00:3b9f $66
    ld   L, A                                          ;; 00:3ba0 $6f
    push HL                                            ;; 00:3ba1 $e5
    ld   B, $08                                        ;; 00:3ba2 $06 $08
.jr_00_3ba4:
    push HL                                            ;; 00:3ba4 $e5
    bit  0, [HL]                                       ;; 00:3ba5 $cb $46
    jr   Z, .jr_00_3bd9                                ;; 00:3ba7 $28 $30
    inc  HL                                            ;; 00:3ba9 $23
    ld   A, [HL]                                       ;; 00:3baa $7e
    cp   A, $c0                                        ;; 00:3bab $fe $c0
    jr   Z, .jr_00_3bb0                                ;; 00:3bad $28 $01
    dec  [HL]                                          ;; 00:3baf $35
.jr_00_3bb0:
    ld   A, [HL+]                                      ;; 00:3bb0 $2a
    sra  A                                             ;; 00:3bb1 $cb $2f
    sra  A                                             ;; 00:3bb3 $cb $2f
    sra  A                                             ;; 00:3bb5 $cb $2f
    sra  A                                             ;; 00:3bb7 $cb $2f
    add  A, [HL]                                       ;; 00:3bb9 $86
    bit  7, A                                          ;; 00:3bba $cb $7f
    jr   Z, .jr_00_3bbf                                ;; 00:3bbc $28 $01
    xor  A, A                                          ;; 00:3bbe $af
.jr_00_3bbf:
    ld   [HL+], A                                      ;; 00:3bbf $22
    and  A, A                                          ;; 00:3bc0 $a7
    jr   Z, .jr_00_3bd9                                ;; 00:3bc1 $28 $16
    ld   A, [HL]                                       ;; 00:3bc3 $7e
    and  A, $0f                                        ;; 00:3bc4 $e6 $0f
    swap A                                             ;; 00:3bc6 $cb $37
    add  A, [HL]                                       ;; 00:3bc8 $86
    ld   [HL], A                                       ;; 00:3bc9 $77
    jr   NC, .jr_00_3bd7                               ;; 00:3bca $30 $0b
    inc  HL                                            ;; 00:3bcc $23
    ld   A, $01                                        ;; 00:3bcd $3e $01
    bit  7, [HL]                                       ;; 00:3bcf $cb $7e
    jr   Z, .jr_00_3bd5                                ;; 00:3bd1 $28 $02
    ld   A, $ff                                        ;; 00:3bd3 $3e $ff
.jr_00_3bd5:
    add  A, [HL]                                       ;; 00:3bd5 $86
    ld   [HL], A                                       ;; 00:3bd6 $77
.jr_00_3bd7:
    ld   A, $01                                        ;; 00:3bd7 $3e $01
.jr_00_3bd9:
    pop  HL                                            ;; 00:3bd9 $e1
    or   A, $fe                                        ;; 00:3bda $f6 $fe
    and  A, [HL]                                       ;; 00:3bdc $a6
    ld   [HL], A                                       ;; 00:3bdd $77
    ld   DE, $05                                       ;; 00:3bde $11 $05 $00
    add  HL, DE                                        ;; 00:3be1 $19
    dec  B                                             ;; 00:3be2 $05
    jr   NZ, .jr_00_3ba4                               ;; 00:3be3 $20 $bf
    pop  HL                                            ;; 00:3be5 $e1
    ld   DE, $05                                       ;; 00:3be6 $11 $05 $00
    ld   B, $08                                        ;; 00:3be9 $06 $08
    xor  A, A                                          ;; 00:3beb $af
.jr_00_3bec:
    or   A, [HL]                                       ;; 00:3bec $b6
    add  HL, DE                                        ;; 00:3bed $19
    dec  B                                             ;; 00:3bee $05
    jr   NZ, .jr_00_3bec                               ;; 00:3bef $20 $fb
    and  A, $01                                        ;; 00:3bf1 $e6 $01
    ret                                                ;; 00:3bf3 $c9

call_00_3bf4:
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:3bf4 $fa $24 $d6
    and  A, A                                          ;; 00:3bf7 $a7
    ret  NZ                                            ;; 00:3bf8 $c0
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 00:3bf9 $fa $00 $d3
    rlca                                               ;; 00:3bfc $07
    rlca                                               ;; 00:3bfd $07
    rlca                                               ;; 00:3bfe $07
    and  A, $07                                        ;; 00:3bff $e6 $07
    ld   L, A                                          ;; 00:3c01 $6f
    ld   H, $00                                        ;; 00:3c02 $26 $00
    ld   DE, wD301                                     ;; 00:3c04 $11 $01 $d3
    add  HL, DE                                        ;; 00:3c07 $19
    ld   A, [HL]                                       ;; 00:3c08 $7e
    dec  A                                             ;; 00:3c09 $3d
    srl  A                                             ;; 00:3c0a $cb $3f
    ld   L, A                                          ;; 00:3c0c $6f
    ld   H, $00                                        ;; 00:3c0d $26 $00
    ld   DE, .data_00_3c20                                     ;; 00:3c0f $11 $20 $3c
    add  HL, DE                                        ;; 00:3c12 $19
    ld   A, [HL]                                       ;; 00:3c13 $7e
    cp   A, $ff                                        ;; 00:3c14 $fe $ff
    ret  Z                                             ;; 00:3c16 $c8
    ld   [wD610], A                                    ;; 00:3c17 $ea $10 $d6
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:3c1a $21 $0f $d6
    set  4, [HL]                                       ;; 00:3c1d $cb $e6
    ret                                                ;; 00:3c1f $c9
.data_00_3c20:
    db   $ff, $0f, $05, $04, $02, $0c, $ff, $09        ;; 00:3c20 ?..?????
    db   $0e, $08, $03, $00, $ff, $0b, $11, $ff        ;; 00:3c28 ????????
    db   $07, $ff, $ff, $ff, $ff, $0d, $0a, $01        ;; 00:3c30 .???????
    db   $13, $06, $12, $ff, $ff, $ff, $10             ;; 00:3c38 ???????
