;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

call_03_6484:
    ld   A, $5f                                        ;; 03:6484 $3e $5f
    ld   HL, wD739                                     ;; 03:6486 $21 $39 $d7
    ld   L, [HL]                                       ;; 03:6489 $6e
    cp   A, L                                          ;; 03:648a $bd
    ret  C                                             ;; 03:648b $d8
    ld   H, $cc                                        ;; 03:648c $26 $cc
    ld   DE, $04                                       ;; 03:648e $11 $04 $00
    ld   C, $00                                        ;; 03:6491 $0e $00
.jr_03_6493:
    ld   [HL], C                                       ;; 03:6493 $71
    add  HL, DE                                        ;; 03:6494 $19
    cp   A, L                                          ;; 03:6495 $bd
    jr   NC, .jr_03_6493                               ;; 03:6496 $30 $fb
    ret                                                ;; 03:6498 $c9

call_03_6499:
    ld   HL, wD6ED_XPositionInMap                                     ;; 03:6499 $21 $ed $d6
    ld   A, [HL]                                       ;; 03:649c $7e
    and  A, $0f                                        ;; 03:649d $e6 $0f
    ld   C, A                                          ;; 03:649f $4f
    ld   A, $0c                                        ;; 03:64a0 $3e $0c
    sub  A, C                                          ;; 03:64a2 $91
    ld   [wD64D], A                                    ;; 03:64a3 $ea $4d $d6
    ld   A, [HL+]                                      ;; 03:64a6 $2a
    swap A                                             ;; 03:64a7 $cb $37
    and  A, $0f                                        ;; 03:64a9 $e6 $0f
    ld   C, A                                          ;; 03:64ab $4f
    ld   A, [HL+]                                      ;; 03:64ac $2a
    swap A                                             ;; 03:64ad $cb $37
    or   A, C                                          ;; 03:64af $b1
    ld   C, A                                          ;; 03:64b0 $4f
    ld   B, $c7                                        ;; 03:64b1 $06 $c7
    ld   A, [BC]                                       ;; 03:64b3 $0a
    and  A, A                                          ;; 03:64b4 $a7
    ret  Z                                             ;; 03:64b5 $c8
    push AF                                            ;; 03:64b6 $f5
    dec  B                                             ;; 03:64b7 $05
    ld   A, [BC]                                       ;; 03:64b8 $0a
    ld   E, A                                          ;; 03:64b9 $5f
    ld   HL, wD6EF_YPositionInMap                                     ;; 03:64ba $21 $ef $d6
    ld   A, [HL]                                       ;; 03:64bd $7e
    and  A, $0f                                        ;; 03:64be $e6 $0f
    ld   B, A                                          ;; 03:64c0 $47
    ld   A, $10                                        ;; 03:64c1 $3e $10
    sub  A, B                                          ;; 03:64c3 $90
    ld   [wD64E], A                                    ;; 03:64c4 $ea $4e $d6
    ld   A, [HL+]                                      ;; 03:64c7 $2a
    swap A                                             ;; 03:64c8 $cb $37
    and  A, $0f                                        ;; 03:64ca $e6 $0f
    ld   B, A                                          ;; 03:64cc $47
    ld   A, [HL+]                                      ;; 03:64cd $2a
    swap A                                             ;; 03:64ce $cb $37
    or   A, B                                          ;; 03:64d0 $b0
    ld   B, A                                          ;; 03:64d1 $47
    ld   HL, wCC60                                     ;; 03:64d2 $21 $60 $cc
    pop  AF                                            ;; 03:64d5 $f1
.jr_03_64d6:
    push AF                                            ;; 03:64d6 $f5
    push BC                                            ;; 03:64d7 $c5
    ld   D, $c5                                        ;; 03:64d8 $16 $c5
    ld   A, [DE]                                       ;; 03:64da $1a
    sub  A, B                                          ;; 03:64db $90
    cp   A, $0a                                        ;; 03:64dc $fe $0a
    jr   NC, .jr_03_653d                               ;; 03:64de $30 $5d
    swap A                                             ;; 03:64e0 $cb $37
    ld   B, A                                          ;; 03:64e2 $47
    ld   A, [wD64E]                                    ;; 03:64e3 $fa $4e $d6
    add  A, B                                          ;; 03:64e6 $80
    ld   B, A                                          ;; 03:64e7 $47
    ld   [HL+], A                                      ;; 03:64e8 $22
    ld   D, $c4                                        ;; 03:64e9 $16 $c4
    ld   A, [DE]                                       ;; 03:64eb $1a
    sub  A, C                                          ;; 03:64ec $91
    swap A                                             ;; 03:64ed $cb $37
    ld   C, A                                          ;; 03:64ef $4f
    ld   A, [wD64D]                                    ;; 03:64f0 $fa $4d $d6
    add  A, C                                          ;; 03:64f3 $81
    ld   C, A                                          ;; 03:64f4 $4f
    ld   [HL+], A                                      ;; 03:64f5 $22
    inc  E                                             ;; 03:64f6 $1c
    ld   [HL], $7e                                     ;; 03:64f7 $36 $7e
    inc  L                                             ;; 03:64f9 $2c
    ld   [HL], $01                                     ;; 03:64fa $36 $01
    inc  L                                             ;; 03:64fc $2c
    ld   A, [wD743]                                    ;; 03:64fd $fa $43 $d7
    and  A, A                                          ;; 03:6500 $a7
    jr   Z, .jr_03_6524                                ;; 03:6501 $28 $21
    ld   A, [wD212_PlayerScreenXPosition]                                    ;; 03:6503 $fa $12 $d2
    sub  A, C                                          ;; 03:6506 $91
    add  A, $05                                        ;; 03:6507 $c6 $05
    cp   A, $12                                        ;; 03:6509 $fe $12
    jr   NC, .jr_03_6524                               ;; 03:650b $30 $17
    ld   A, [wD213_PlayerScreenYPosition]                                    ;; 03:650d $fa $13 $d2
    sub  A, B                                          ;; 03:6510 $90
    add  A, $0a                                        ;; 03:6511 $c6 $0a
    cp   A, $24                                        ;; 03:6513 $fe $24
    jr   NC, .jr_03_6524                               ;; 03:6515 $30 $0d
    push HL                                            ;; 03:6517 $e5
    push DE                                            ;; 03:6518 $d5
    ld   D, $c5                                        ;; 03:6519 $16 $c5
    dec  E                                             ;; 03:651b $1d
    ld   A, $ff                                        ;; 03:651c $3e $ff
    ld   [DE], A                                       ;; 03:651e $12
    call call_00_06ec                                  ;; 03:651f $cd $ec $06
    pop  DE                                            ;; 03:6522 $d1
    pop  HL                                            ;; 03:6523 $e1
.jr_03_6524:
    bit  7, L                                          ;; 03:6524 $cb $7d
    jr   Z, .jr_03_652a                                ;; 03:6526 $28 $02
    ld   L, $80                                        ;; 03:6528 $2e $80
.jr_03_652a:
    pop  BC                                            ;; 03:652a $c1
    pop  AF                                            ;; 03:652b $f1
    dec  A                                             ;; 03:652c $3d
    jr   NZ, .jr_03_64d6                               ;; 03:652d $20 $a7
    bit  7, L                                          ;; 03:652f $cb $7d
    ret  NZ                                            ;; 03:6531 $c0
    ld   DE, $04                                       ;; 03:6532 $11 $04 $00
    xor  A, A                                          ;; 03:6535 $af
.jr_03_6536:
    ld   [HL], A                                       ;; 03:6536 $77
    add  HL, DE                                        ;; 03:6537 $19
    bit  7, L                                          ;; 03:6538 $cb $7d
    jr   Z, .jr_03_6536                                ;; 03:653a $28 $fa
    ret                                                ;; 03:653c $c9
.jr_03_653d:
    inc  E                                             ;; 03:653d $1c
    jr   .jr_03_652a                                   ;; 03:653e $18 $ea

entry_03_6540:
    call call_03_6499                                  ;; 03:6540 $cd $99 $64
    call call_03_5b5b                                  ;; 03:6543 $cd $5b $5b
    jp   call_03_6484                                    ;; 03:6546 $c3 $84 $64

;    db   $cd, $0a, $3a, $d5, $13, $0e, $00, $06        ;; 03:6549 ????????
;    db   $08, $cb, $46, $28, $27, $2a, $2a, $2a        ;; 03:6551 ????????
;    db   $2f, $3c, $d6, $08, $12, $13, $2a, $2a        ;; 03:6559 ????????
;    db   $d6, $04, $12, $13, $fa, $3b, $d7, $0f        ;; 03:6561 ????????
;    db   $0f, $e6, $02, $c6, $2c, $12, $13, $3e        ;; 03:6569 ????????
;    db   $04, $12, $13, $0c, $05, $20, $da, $e1        ;; 03:6571 ????????
;    db   $71, $79, $a7, $c9, $23, $23, $23, $23        ;; 03:6579 ????????
;    db   $23, $18, $f1                                 ;; 03:6581 ???

call_03_6549:
    call call_00_3a0a
    push de
    inc de
    ld c, $00
    ld b, $08

jr_03_6552:
    bit 0, [hl]
    jr z, jr_03_657d

    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    cpl
    inc a
    sub $08
    ld [de], a
    inc de
    ld a, [hl+]
    ld a, [hl+]
    sub $04
    ld [de], a
    inc de
    ld a, [$d73b]
    rrca
    rrca
    and $02
    add $2c
    ld [de], a
    inc de
    ld a, $04
    ld [de], a
    inc de
    inc c

jr_03_6575:
    dec b
    jr nz, jr_03_6552

    pop hl
    ld [hl], c
    ld a, c
    and a
    ret


jr_03_657d:
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr jr_03_6575

entry_03_6584:
    call call_00_3a0a                                  ;; 03:6584 $cd $0a $3a
    push DE                                            ;; 03:6587 $d5
    inc  DE                                            ;; 03:6588 $13
    ld   C, $00                                        ;; 03:6589 $0e $00
    ld   B, $08                                        ;; 03:658b $06 $08
.jr_03_658d:
    bit  7, [HL]                                       ;; 03:658d $cb $7e
    jr   Z, .jr_03_65b1                                ;; 03:658f $28 $20
    ld   A, [HL+]                                      ;; 03:6591 $2a
    ld   A, [HL+]                                      ;; 03:6592 $2a
    ld   A, [HL+]                                      ;; 03:6593 $2a
    cpl                                                ;; 03:6594 $2f
    inc  A                                             ;; 03:6595 $3c
    sub  A, $08                                        ;; 03:6596 $d6 $08
    ld   [DE], A                                       ;; 03:6598 $12
    inc  DE                                            ;; 03:6599 $13
    ld   A, [HL+]                                      ;; 03:659a $2a
    ld   A, [HL+]                                      ;; 03:659b $2a
    sub  A, $04                                        ;; 03:659c $d6 $04
    ld   [DE], A                                       ;; 03:659e $12
    inc  DE                                            ;; 03:659f $13
    ld   A, $7e                                        ;; 03:65a0 $3e $7e
    ld   [DE], A                                       ;; 03:65a2 $12
    inc  DE                                            ;; 03:65a3 $13
    ld   A, $01                                        ;; 03:65a4 $3e $01
    ld   [DE], A                                       ;; 03:65a6 $12
    inc  DE                                            ;; 03:65a7 $13
    inc  C                                             ;; 03:65a8 $0c
.jr_03_65a9:
    dec  B                                             ;; 03:65a9 $05
    jr   NZ, .jr_03_658d                               ;; 03:65aa $20 $e1
    pop  HL                                            ;; 03:65ac $e1
    ld   [HL], C                                       ;; 03:65ad $71
    ld   A, C                                          ;; 03:65ae $79
    and  A, A                                          ;; 03:65af $a7
    ret                                                ;; 03:65b0 $c9
.jr_03_65b1:
    inc  HL                                            ;; 03:65b1 $23
    inc  HL                                            ;; 03:65b2 $23
    inc  HL                                            ;; 03:65b3 $23
    inc  HL                                            ;; 03:65b4 $23
    inc  HL                                            ;; 03:65b5 $23
    jr   .jr_03_65a9                                   ;; 03:65b6 $18 $f1

;    db   $cd, $0a, $3a, $d5, $13, $0e, $00, $06        ;; 03:65b8 ????????
;    db   $08, $cb, $46, $28, $2d, $2a, $2a, $2a        ;; 03:65c0 ????????
;    db   $f5, $2f, $3c, $d6, $08, $12, $13, $2a        ;; 03:65c8 ????????
;    db   $d6, $04, $2a, $12, $13, $f1, $cb, $37        ;; 03:65d0 ????????
;    db   $e6, $0f, $fe, $06, $38, $02, $3e, $05        ;; 03:65d8 ????????
;    db   $87, $c6, $44, $12, $13, $3e, $07, $12        ;; 03:65e0 ????????
;    db   $13, $0c, $05, $20, $d4, $e1, $71, $79        ;; 03:65e8 ????????
;    db   $a7, $c9, $23, $23, $23, $23, $23, $18        ;; 03:65f0 ????????
;    db   $f1                                           ;; 03:65f8 ?

call_03_65b8:
    call call_00_3a0a
    push de
    inc de
    ld c, $00
    ld b, $08

jr_03_65c1:
    bit 0, [hl]
    jr z, jr_03_65f2

    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    push af
    cpl
    inc a
    sub $08
    ld [de], a
    inc de
    ld a, [hl+]
    sub $04
    ld a, [hl+]
    ld [de], a
    inc de
    pop af
    swap a
    and $0f
    cp $06
    jr c, jr_03_65e0

    ld a, $05

jr_03_65e0:
    add a
    add $44
    ld [de], a
    inc de
    ld a, $07
    ld [de], a
    inc de
    inc c

jr_03_65ea:
    dec b
    jr nz, jr_03_65c1

    pop hl
    ld [hl], c
    ld a, c
    and a
    ret


jr_03_65f2:
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr jr_03_65ea

entry_03_65f9:
    call call_00_3a0a                                  ;; 03:65f9 $cd $0a $3a
    push DE                                            ;; 03:65fc $d5
    inc  DE                                            ;; 03:65fd $13
    ld   C, $00                                        ;; 03:65fe $0e $00
    ld   B, $08                                        ;; 03:6600 $06 $08
.jr_03_6602:
    bit  0, [HL]                                       ;; 03:6602 $cb $46
    jr   Z, .jr_03_6633                                ;; 03:6604 $28 $2d
    ld   A, [HL+]                                      ;; 03:6606 $2a
    ld   A, [HL+]                                      ;; 03:6607 $2a
    ld   A, [HL+]                                      ;; 03:6608 $2a
    push AF                                            ;; 03:6609 $f5
    cpl                                                ;; 03:660a $2f
    inc  A                                             ;; 03:660b $3c
    sub  A, $08                                        ;; 03:660c $d6 $08
    ld   [DE], A                                       ;; 03:660e $12
    inc  DE                                            ;; 03:660f $13
    ld   A, [HL+]                                      ;; 03:6610 $2a
    ld   A, [HL+]                                      ;; 03:6611 $2a
    sub  A, $04                                        ;; 03:6612 $d6 $04
    ld   [DE], A                                       ;; 03:6614 $12
    inc  DE                                            ;; 03:6615 $13
    pop  AF                                            ;; 03:6616 $f1
    swap A                                             ;; 03:6617 $cb $37
    and  A, $0f                                        ;; 03:6619 $e6 $0f
    cp   A, $03                                        ;; 03:661b $fe $03
    jr   C, .jr_03_6621                                ;; 03:661d $38 $02
    ld   A, $02                                        ;; 03:661f $3e $02
.jr_03_6621:
    add  A, A                                          ;; 03:6621 $87
    add  A, $60                                        ;; 03:6622 $c6 $60
    ld   [DE], A                                       ;; 03:6624 $12
    inc  DE                                            ;; 03:6625 $13
    ld   A, $01                                        ;; 03:6626 $3e $01
    ld   [DE], A                                       ;; 03:6628 $12
    inc  DE                                            ;; 03:6629 $13
    inc  C                                             ;; 03:662a $0c
.jr_03_662b:
    dec  B                                             ;; 03:662b $05
    jr   NZ, .jr_03_6602                               ;; 03:662c $20 $d4
    pop  HL                                            ;; 03:662e $e1
    ld   [HL], C                                       ;; 03:662f $71
    ld   A, C                                          ;; 03:6630 $79
    and  A, A                                          ;; 03:6631 $a7
    ret                                                ;; 03:6632 $c9
.jr_03_6633:
    inc  HL                                            ;; 03:6633 $23
    inc  HL                                            ;; 03:6634 $23
    inc  HL                                            ;; 03:6635 $23
    inc  HL                                            ;; 03:6636 $23
    inc  HL                                            ;; 03:6637 $23
    jr   .jr_03_662b                                   ;; 03:6638 $18 $f1

;    db   $cd, $0a, $3a, $d5, $13, $0e, $00, $06        ;; 03:663a ????????
;    db   $08, $cb, $46, $28, $27, $2a, $2a, $2a        ;; 03:6642 ????????
;    db   $2f, $3c, $d6, $08, $12, $13, $2a, $2a        ;; 03:664a ????????
;    db   $d6, $04, $12, $13, $fa, $3b, $d7, $0f        ;; 03:6652 ????????
;    db   $0f, $e6, $02, $c6, $58, $12, $13, $3e        ;; 03:665a ????????
;    db   $04, $12, $13, $0c, $05, $20, $da, $e1        ;; 03:6662 ????????
;    db   $71, $79, $a7, $c9, $23, $23, $23, $23        ;; 03:666a ????????
;    db   $23, $18, $f1, $cd, $0a, $3a, $d5, $13        ;; 03:6672 ????????
;    db   $0e, $00, $06, $08, $cb, $46, $28, $25        ;; 03:667a ????????
;    db   $2a, $2a, $2a, $f5, $2f, $3c, $d6, $08        ;; 03:6682 ????????
;    db   $12, $13, $2a, $2a, $d6, $04, $12, $13        ;; 03:668a ????????
;    db   $f1, $0f, $e6, $02, $c6, $5c, $12, $13        ;; 03:6692 ????????
;    db   $3e, $04, $12, $13, $0c, $05, $20, $dc        ;; 03:669a ????????
;    db   $e1, $71, $79, $a7, $c9, $23, $23, $23        ;; 03:66a2 ????????
;    db   $23, $23, $18, $f1                            ;; 03:66aa ????

call_03_663a:
    call call_00_3a0a
    push de
    inc de
    ld c, $00
    ld b, $08

jr_03_6643:
    bit 0, [hl]
    jr z, jr_03_666e

    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    cpl
    inc a
    sub $08
    ld [de], a
    inc de
    ld a, [hl+]
    ld a, [hl+]
    sub $04
    ld [de], a
    inc de
    ld a, [$d73b]
    rrca
    rrca
    and $02
    add $58
    ld [de], a
    inc de
    ld a, $04
    ld [de], a
    inc de
    inc c

jr_03_6666:
    dec b
    jr nz, jr_03_6643

    pop hl
    ld [hl], c
    ld a, c
    and a
    ret


jr_03_666e:
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr jr_03_6666

    call call_00_3a0a
    push de
    inc de
    ld c, $00
    ld b, $08

jr_03_667e:
    bit 0, [hl]
    jr z, jr_03_66a7

    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    push af
    cpl
    inc a
    sub $08
    ld [de], a
    inc de
    ld a, [hl+]
    ld a, [hl+]
    sub $04
    ld [de], a
    inc de
    pop af
    rrca
    and $02
    add $5c
    ld [de], a
    inc de
    ld a, $04
    ld [de], a
    inc de
    inc c

jr_03_669f:
    dec b
    jr nz, jr_03_667e

    pop hl
    ld [hl], c
    ld a, c
    and a
    ret


jr_03_66a7:
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr jr_03_669f
