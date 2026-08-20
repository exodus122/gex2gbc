call_01_446f_LoadMenuGraphics:
; Builds a whole screen from the script at HL: fade out, wipe VRAM, run the script,
; follow any chained script it queued, then set the raster split up from
; data_01_5654_MenuTypeLcdcAndPalette and fade back in.
;
; The chain loop is what lets one screen be assembled from several scripts - the
; password keyboard's frame and its 29 cells are separate scripts, and the mission
; select screens share their furniture with each other the same way
    push HL                                            ;; 01:446f $e5
    ld   A, $ff                                        ;; 01:4470 $3e $ff
    ld   [wD6C1_Menu_CursorSpriteId], A                                    ;; 01:4472 $ea $c1 $d6
    xor  A, A                                          ;; 01:4475 $af
    ld   [wD6D8_Menu_HideSpritesDelay], A                                    ;; 01:4476 $ea $d8 $d6
    call call_00_0f38_FadeOutAndClearVRAM                                  ;; 01:4479 $cd $38 $0f
    call call_00_0ede_SelectWramBank1                                  ;; 01:447c $cd $de $0e
    pop  HL                                            ;; 01:447f $e1
.jr_01_4480:
    ld   A, L                                          ;; 01:4480 $7d
    ld   [wD6B3_MenuScript_PtrLo], A                                    ;; 01:4481 $ea $b3 $d6
    ld   A, H                                          ;; 01:4484 $7c
    ld   [wD6B4_MenuScript_PtrHi], A                                    ;; 01:4485 $ea $b4 $d6
    ld   A, MENU_CHAINED_NONE                          ;; 01:4488 $3e $ff
    ld   [wD6D7_Menu_ChainedScriptId], A                                    ;; 01:448a $ea $d7 $d6
    call call_01_44d7_MenuScript_RunToEnd                                  ;; 01:448d $cd $d7 $44
    ld   A, [wD6D7_Menu_ChainedScriptId]                                    ;; 01:4490 $fa $d7 $d6
    cp   A, MENU_CHAINED_NONE                          ;; 01:4493 $fe $ff
    jr   Z, .jr_01_449f                                ;; 01:4495 $28 $08
    ld   DE, data_01_568c_ChainedScriptTable                              ;; 01:4497 $11 $8c $56
    call call_00_07b9_GetPointerFromTable                                  ;; 01:449a $cd $b9 $07
    jr   .jr_01_4480                                   ;; 01:449d $18 $e1
.jr_01_449f:
    ld   HL, wD6DE_MenuType                                     ;; 01:449f $21 $de $d6
    ld   L, [HL]                                       ;; 01:44a2 $6e
    ld   H, $00                                        ;; 01:44a3 $26 $00
    add  HL, HL                                        ;; 01:44a5 $29
    ld   DE, data_01_5654_MenuTypeLcdcAndPalette                              ;; 01:44a6 $11 $54 $56
    add  HL, DE                                        ;; 01:44a9 $19
    ld   A, [HL+]                                      ;; 01:44aa $2a
    ld   [wD6E1_RasterSplit_LCDCValue], A                                    ;; 01:44ab $ea $e1 $d6
    ld   C, [HL]                                       ;; 01:44ae $4e
    FARCALL call_0b_5537_BgPalette_LoadMonoOrGetSpriteParams
    ld   A, MENU_WOBBLE_OFF                            ;; 01:44ba $3e $ff
    ld   [wD6EB_RasterWobble_StartLine], A             ;; 01:44bc $ea $eb $d6 ; OnSelectionChanged turns it back on if the screen wants it
    call call_01_43e6_Menu_OnSelectionChanged                                  ;; 01:44bf $cd $e6 $43
    ld   A, $06                                        ;; 01:44c2 $3e $06
    call call_00_0bae_RequestLcdIsr                                  ;; 01:44c4 $cd $ae $0b
    ld   A, MENU_LCDC_WINDOW                           ;; 01:44c7 $3e $d7 ; LCDC for the bottom half of the split
    call call_00_0f56_SetLCDCAndFadeIn                 ;; 01:44c9 $cd $56 $0f
    jp   call_00_0ab4_WaitForInterrupt                                  ;; 01:44cc $c3 $b4 $0a

call_01_44cf_MenuScript_RunFrom:
; Points the script cursor at HL and runs it. Falls through into RunToEnd
    ld   A, L                                          ;; 01:44cf $7d
    ld   [wD6B3_MenuScript_PtrLo], A                                    ;; 01:44d0 $ea $b3 $d6
    ld   A, H                                          ;; 01:44d3 $7c
    ld   [wD6B4_MenuScript_PtrHi], A                                    ;; 01:44d4 $ea $b4 $d6

call_01_44d7_MenuScript_RunToEnd:
; Runs menu script commands until the terminator $FF. The cursor lives in
; wD6B3, not in a register, so a command is free to redirect the script
    ld   HL, wD6B3_MenuScript_PtrLo                                     ;; 01:44d7 $21 $b3 $d6
    ld   A, [HL+]                                      ;; 01:44da $2a
    ld   H, [HL]                                       ;; 01:44db $66
    ld   L, A                                          ;; 01:44dc $6f
    ld   A, [HL]                                       ;; 01:44dd $7e
    cp   A, MENUSCRIPT_END                             ;; 01:44de $fe $ff
    ret  Z                                             ;; 01:44e0 $c8
    call call_01_44e6_MenuScript_RunCommand                                  ;; 01:44e1 $cd $e6 $44
    jr   call_01_44d7_MenuScript_RunToEnd                                  ;; 01:44e4 $18 $f1

call_01_44e6_MenuScript_RunCommand:
; Executes one menu script command - the workhorse the whole menu system is built
; on. Almost every screen in the game is data fed through here rather than code.
;
; The first byte is a command id, which indexes an 8-byte descriptor in
; data_01_5324_MenuCmd_Descriptors; six of those bytes are copied to wD692..wD697 and hold the settings
; shared by every use of that command (block size, destination, tile ids,
; attributes). The script then supplies one or more 7-byte parameter blocks, each
; copied over wD698..wD69E, and each drawing one rectangle. The loop at
; .jr_01_4507 keeps consuming blocks until one has MENUCMD_LAST_BLOCK set, so a
; single id can stamp out a whole screen's worth of rectangles.
;
; Per block, in order:
;
;   1. wD69D_MenuCmd_OptionSlot registers a selectable row - low nibble is the row
;      index, high nibble the MENU_OPTION_* code - into wD6C5_Menu_OptionActions.
;      This is how a menu's script, not any code, decides what its options do
;   2. MENUCMD_CLEAR_BUFFER blanks the wC000 staging buffer
;   3. if the source pointer's HIGH byte is >= MENUCMD_SUB_BASE it is not a pointer
;      at all: (hi - $E0) indexes .data_01_4633_MenuCmd_SubHandlers and the low
;      byte is the argument. That is the escape hatch for the handful of screens
;      that need real code - palettes, totals, the password grid
;   4. MENUCMD_DRAW_TEXT runs the text renderer into the staging buffer
;   5. unless MENUCMD_NO_TILEMAP_FILL, fill the tilemap rectangle at
;      _SCRN0 + DestTileY*32 + DestTileX with consecutive tile ids starting at
;      wD696, and on CGB fill the matching VBK 1 rectangle with wD697
;   6. unless MENUCMD_NO_TILE_UPLOAD, copy the staged tile graphics to VRAM
;
; MENUCMD_TRANSPOSED flips steps 5 and 6 to walk down columns instead of across
; rows, for artwork whose tiles were stored column major.
    ld   HL, wD6B3_MenuScript_PtrLo                                     ;; 01:44e6 $21 $b3 $d6
    ld   E, [HL]                                       ;; 01:44e9 $5e
    inc  HL                                            ;; 01:44ea $23
    ld   D, [HL]                                       ;; 01:44eb $56
    ld   A, [DE]                                       ;; 01:44ec $1a
    inc  DE                                            ;; 01:44ed $13
    ld   [HL], D                                       ;; 01:44ee $72
    dec  HL                                            ;; 01:44ef $2b
    ld   [HL], E                                       ;; 01:44f0 $73
    ld   [wD6C4_MenuScript_CommandId], A                                    ;; 01:44f1 $ea $c4 $d6
    ld   L, A                                          ;; 01:44f4 $6f
    ld   H, $00                                        ;; 01:44f5 $26 $00
    add  HL, HL                                        ;; 01:44f7 $29
    add  HL, HL                                        ;; 01:44f8 $29
    add  HL, HL                                        ;; 01:44f9 $29
    ld   DE, data_01_5324_MenuCmd_Descriptors          ;; 01:44fa $11 $24 $53
    add  HL, DE                                        ;; 01:44fd $19
    ld   DE, wD692_Text_BlockWidthTiles                                     ;; 01:44fe $11 $92 $d6
    ld   BC, $06                                       ;; 01:4501 $01 $06 $00
    call call_00_07b0_MemCopy                                  ;; 01:4504 $cd $b0 $07
.jr_01_4507:
    ld   HL, wD6B3_MenuScript_PtrLo                                     ;; 01:4507 $21 $b3 $d6
    ld   A, [HL+]                                      ;; 01:450a $2a
    ld   H, [HL]                                       ;; 01:450b $66
    ld   L, A                                          ;; 01:450c $6f
    ld   DE, wD698_Text_PenX                                     ;; 01:450d $11 $98 $d6
    ld   BC, $07                                       ;; 01:4510 $01 $07 $00
    call call_00_07b0_MemCopy                                  ;; 01:4513 $cd $b0 $07
    ld   A, L                                          ;; 01:4516 $7d
    ld   [wD6B3_MenuScript_PtrLo], A                                    ;; 01:4517 $ea $b3 $d6
    ld   A, H                                          ;; 01:451a $7c
    ld   [wD6B4_MenuScript_PtrHi], A                                    ;; 01:451b $ea $b4 $d6
    ld   A, [wD69D_MenuCmd_OptionSlot]                                    ;; 01:451e $fa $9d $d6
    and  A, $0f                                        ;; 01:4521 $e6 $0f
    ld   L, A                                          ;; 01:4523 $6f
    ld   H, $00                                        ;; 01:4524 $26 $00
    ld   DE, wD6C5_Menu_OptionActions                                     ;; 01:4526 $11 $c5 $d6
    add  HL, DE                                        ;; 01:4529 $19
    ld   A, [wD69D_MenuCmd_OptionSlot]                                    ;; 01:452a $fa $9d $d6
    and  A, $f0                                        ;; 01:452d $e6 $f0
    ld   [HL], A                                       ;; 01:452f $77
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4530 $fa $9e $d6
    and  A, MENUCMD_CLEAR_BUFFER                       ;; 01:4533 $e6 $01
    call NZ, call_01_4bb7_Text_ClearBuffer                              ;; 01:4535 $c4 $b7 $4b
    ld   A, [wD69C_Text_SrcPtrHi]                                    ;; 01:4538 $fa $9c $d6
    sub  A, MENUCMD_SUB_BASE                           ;; 01:453b $d6 $e0
    jr   C, .jr_01_4548                                ;; 01:453d $38 $09
    ld   DE, .data_01_4633_MenuCmd_SubHandlers         ;; 01:453f $11 $33 $46
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4542 $cd $b9 $07
    call call_00_10bd_JumpHL                                  ;; 01:4545 $cd $bd $10
.jr_01_4548:
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4548 $fa $9e $d6
    and  A, MENUCMD_DRAW_TEXT                          ;; 01:454b $e6 $02
    call NZ, call_01_4a8f_Text_Render                              ;; 01:454d $c4 $8f $4a
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4550 $fa $9e $d6
    and  A, MENUCMD_LAST_BLOCK                         ;; 01:4553 $e6 $80
    jr   Z, .jr_01_4507                                ;; 01:4555 $28 $b0
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4557 $fa $9e $d6
    and  A, MENUCMD_NO_TILEMAP_FILL                    ;; 01:455a $e6 $40
    jp   NZ, .jp_01_45e5                               ;; 01:455c $c2 $e5 $45
    ld   HL, wD694_MenuCmd_DestTileX                                     ;; 01:455f $21 $94 $d6
    ld   E, [HL]                                       ;; 01:4562 $5e
    ld   D, $00                                        ;; 01:4563 $16 $00
    inc  HL                                            ;; 01:4565 $23
    ld   L, [HL]                                       ;; 01:4566 $6e
    ld   H, D                                          ;; 01:4567 $62
    add  HL, HL                                        ;; 01:4568 $29
    add  HL, HL                                        ;; 01:4569 $29
    add  HL, HL                                        ;; 01:456a $29
    add  HL, HL                                        ;; 01:456b $29
    add  HL, HL                                        ;; 01:456c $29
    add  HL, DE                                        ;; 01:456d $19
    ld   DE, _SCRN0                                     ;; 01:456e $11 $00 $98
    add  HL, DE                                        ;; 01:4571 $19
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:4572 $fa $9e $d6
    and  A, MENUCMD_TRANSPOSED                         ;; 01:4575 $e6 $04
    jr   NZ, .jr_01_4586                               ;; 01:4577 $20 $0d
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4579 $fa $92 $d6
    ld   B, A                                          ;; 01:457c $47
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:457d $fa $93 $d6
    ld   C, A                                          ;; 01:4580 $4f
    ld   DE, $2001                                     ;; 01:4581 $11 $01 $20
    jr   .jr_01_4591                                   ;; 01:4584 $18 $0b
.jr_01_4586:
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4586 $fa $92 $d6
    ld   C, A                                          ;; 01:4589 $4f
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:458a $fa $93 $d6
    ld   B, A                                          ;; 01:458d $47
    ld   DE, $0120                                      ;; 01:458e $11 $20 $01
.jr_01_4591:
    ld   A, [wD59E_OnGBCFlag]                                    ;; 01:4591 $fa $9e $d5
    and  A, A                                          ;; 01:4594 $a7
    jr   Z, .jr_01_45cb                                ;; 01:4595 $28 $34
    push HL                                            ;; 01:4597 $e5
    push BC                                            ;; 01:4598 $c5
    ld   A, $01                                        ;; 01:4599 $3e $01
    ldh  [rVBK], A                                     ;; 01:459b $e0 $4f
    ld   A, [wD697_MenuCmd_CgbAttributes]                                    ;; 01:459d $fa $97 $d6
    cp   A, MENUCMD_ATTR_TV_COPY                       ;; 01:45a0 $fe $ff
    jr   NZ, .jr_01_45af                               ;; 01:45a2 $20 $0b
    call call_00_08b1_MediaDimension_CopyTVAttributes                                  ;; 01:45a4 $cd $b1 $08
    ld   A, $00                                        ;; 01:45a7 $3e $00
    ldh  [rVBK], A                                     ;; 01:45a9 $e0 $4f
    pop  BC                                            ;; 01:45ab $c1
    pop  HL                                            ;; 01:45ac $e1
    jr   .jr_01_45cb                                   ;; 01:45ad $18 $1c
.jr_01_45af:
    push BC                                            ;; 01:45af $c5
    push DE                                            ;; 01:45b0 $d5
    push DE                                            ;; 01:45b1 $d5
    push HL                                            ;; 01:45b2 $e5
    ld   D, $00                                        ;; 01:45b3 $16 $00
.jr_01_45b5:
    ld   [HL], A                                       ;; 01:45b5 $77
    add  HL, DE                                        ;; 01:45b6 $19
    dec  B                                             ;; 01:45b7 $05
    jr   NZ, .jr_01_45b5                               ;; 01:45b8 $20 $fb
    pop  HL                                            ;; 01:45ba $e1
    pop  DE                                            ;; 01:45bb $d1
    ld   E, D                                          ;; 01:45bc $5a
    ld   D, $00                                        ;; 01:45bd $16 $00
    add  HL, DE                                        ;; 01:45bf $19
    pop  DE                                            ;; 01:45c0 $d1
    pop  BC                                            ;; 01:45c1 $c1
    dec  C                                             ;; 01:45c2 $0d
    jr   NZ, .jr_01_45af                               ;; 01:45c3 $20 $ea
    ld   A, $00                                        ;; 01:45c5 $3e $00
    ldh  [rVBK], A                                     ;; 01:45c7 $e0 $4f
    pop  BC                                            ;; 01:45c9 $c1
    pop  HL                                            ;; 01:45ca $e1
.jr_01_45cb:
    ld   A, [wD696_MenuCmd_FirstTileId]                                    ;; 01:45cb $fa $96 $d6
.jr_01_45ce:
    push BC                                            ;; 01:45ce $c5
    push DE                                            ;; 01:45cf $d5
    push DE                                            ;; 01:45d0 $d5
    push HL                                            ;; 01:45d1 $e5
    ld   D, $00                                        ;; 01:45d2 $16 $00
.jr_01_45d4:
    ld   [HL], A                                       ;; 01:45d4 $77
    inc  A                                             ;; 01:45d5 $3c
    add  HL, DE                                        ;; 01:45d6 $19
    dec  B                                             ;; 01:45d7 $05
    jr   NZ, .jr_01_45d4                               ;; 01:45d8 $20 $fa
    pop  HL                                            ;; 01:45da $e1
    pop  DE                                            ;; 01:45db $d1
    ld   E, D                                          ;; 01:45dc $5a
    ld   D, $00                                        ;; 01:45dd $16 $00
    add  HL, DE                                        ;; 01:45df $19
    pop  DE                                            ;; 01:45e0 $d1
    pop  BC                                            ;; 01:45e1 $c1
    dec  C                                             ;; 01:45e2 $0d
    jr   NZ, .jr_01_45ce                               ;; 01:45e3 $20 $e9
.jp_01_45e5:
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:45e5 $fa $9e $d6
    and  A, MENUCMD_NO_TILE_UPLOAD                     ;; 01:45e8 $e6 $20
    ret  NZ                                            ;; 01:45ea $c0
    ld   A, [wD69E_MenuCmd_Flags]                                    ;; 01:45eb $fa $9e $d6
    and  A, MENUCMD_TRANSPOSED                         ;; 01:45ee $e6 $04
    jr   NZ, .jr_01_45fe                               ;; 01:45f0 $20 $0c
    call call_01_4e5a_Menu_GetTileDataSize                                  ;; 01:45f2 $cd $5a $4e
    call call_01_4e49_Menu_GetVramAddrForDestTile                                  ;; 01:45f5 $cd $49 $4e
    ld   HL, wC000_BgMapTileIds                                     ;; 01:45f8 $21 $00 $c0
    jp   call_00_07b0_MemCopy                                  ;; 01:45fb $c3 $b0 $07
.jr_01_45fe:
    call call_01_4e49_Menu_GetVramAddrForDestTile                                  ;; 01:45fe $cd $49 $4e
    ld   HL, wC000_BgMapTileIds                                     ;; 01:4601 $21 $00 $c0
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4604 $fa $92 $d6
    ld   C, A                                          ;; 01:4607 $4f
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:4608 $fa $93 $d6
    ld   B, A                                          ;; 01:460b $47
.jr_01_460c:
    push BC                                            ;; 01:460c $c5
    push HL                                            ;; 01:460d $e5
.jr_01_460e:
    push BC                                            ;; 01:460e $c5
    push HL                                            ;; 01:460f $e5
    ld   BC, $10                                       ;; 01:4610 $01 $10 $00
    call call_00_07b0_MemCopy                                  ;; 01:4613 $cd $b0 $07
    pop  HL                                            ;; 01:4616 $e1
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:4617 $fa $92 $d6
    swap A                                             ;; 01:461a $cb $37
    ld   B, A                                          ;; 01:461c $47
    and  A, $f0                                        ;; 01:461d $e6 $f0
    ld   C, A                                          ;; 01:461f $4f
    ld   A, B                                          ;; 01:4620 $78
    and  A, $0f                                        ;; 01:4621 $e6 $0f
    ld   B, A                                          ;; 01:4623 $47
    add  HL, BC                                        ;; 01:4624 $09
    pop  BC                                            ;; 01:4625 $c1
    dec  B                                             ;; 01:4626 $05
    jr   NZ, .jr_01_460e                               ;; 01:4627 $20 $e5
    pop  HL                                            ;; 01:4629 $e1
    ld   BC, $10                                       ;; 01:462a $01 $10 $00
    add  HL, BC                                        ;; 01:462d $09
    pop  BC                                            ;; 01:462e $c1
    dec  C                                             ;; 01:462f $0d
    jr   NZ, .jr_01_460c                               ;; 01:4630 $20 $da
    ret                                                ;; 01:4632 $c9
.data_01_4633_MenuCmd_SubHandlers:
; Reached when a parameter block's source-pointer high byte is >= MENUCMD_SUB_BASE;
; the index is (hi - $E0) and the low byte of the pointer is the handler's single
; argument, read back out of wD69B_Text_SrcPtrLo. 16 entries, $E0-$EF.
;
; Most handlers do one of two things: stage some graphics into the wC000 buffer, or
; point the source pointer at a string that the following MENUCMD_DRAW_TEXT block
; will then render. So the escape hatch is mostly a way of choosing text and images
; at runtime while the rest of the screen stays pure data.
;
;   $E0  pick a sprite image from data_01_74e9_ImageTable1 by index and stage it
;   $E1  same, from data_01_74ed_ImageTable2
;   $E2  Media Dimension TV screen - load the TV palette, stage a 6x5 tile block
;   $E3  set the text to the current TV's name
;   $E4  set the text to the current level's name
;   $E5  set the text to a mission description, and place the "remote collected"
;        marker sprite next to it. MENUCMD_MISSION_CURRENT means "whichever mission
;        is being played", and suppresses the marker
;   $E6  load a full screen of tiles+tilemap from a 10-byte descriptor
;   $E7  stage image 2, then set up and draw the menu cursor sprite
;   $E8  compute a counter value and format it to text with Text_FormatByte
;   $E9  totals screen - draw the six remote icons for the current page, lit or
;        unlit from wD629_RemoteProgressFlags, and pick the sprite group
;   $EA  set the text to the totals page's level name, or a heading on page 0
;   $EB  set the text to a single password cell, as a one-character string
;   $EC  set wD6D7_Menu_ChainedScriptId - queue another screen to load next
;   $ED  load a fullscreen image from a 3-byte bank/pointer descriptor
;   $EE  set the text to a mission status line, chosen by how many of the level's
;        three mission remotes you hold
;   $EF  stage the current level's collectible icon as a 3x2 block
    dw   call_01_4653_MenuCmd_StageImage1                                 ;; 01:4633 pP
    dw   call_01_465f_MenuCmd_StageImage2                                  ;; 01:4635 pP
    dw   call_01_466b_MenuCmd_StageTVScreen                                  ;; 01:4637 pP
    dw   call_01_4728_MenuCmd_SetTVNameText                                  ;; 01:4639 pP
    dw   call_01_4734_MenuCmd_SetLevelText                                  ;; 01:463b pP
    dw   call_01_473a_MenuCmd_SetMissionText                                  ;; 01:463d pP
    dw   call_01_47a4_MenuCmd_LoadScreen                                  ;; 01:463f ??
    dw   call_01_47c5_MenuCmd_DrawCursorSprite                                  ;; 01:4641 pP
    dw   call_01_47ea_MenuCmd_SetCounterText                                  ;; 01:4643 pP
    dw   call_01_4879_MenuCmd_DrawRemoteIcons                                  ;; 01:4645 pP
    dw   call_01_48df_MenuCmd_SetTotalsPageText                                  ;; 01:4647 pP
    dw   call_01_48fd_MenuCmd_SetPasswordCharText                                      ;; 01:4649 ??
    dw   call_01_4916_MenuCmd_SetChainedScript                                  ;; 01:464b pP
    dw   call_01_491d_MenuCmd_LoadFullscreenImage                                  ;; 01:464d pP
    dw   call_01_4969_MenuCmd_SetMissionStatusText
    dw   call_01_49d7_MenuCmd_StageCollectibleIcon                            ;; 01:464f ????

call_01_4653_MenuCmd_StageImage1:
; MENUCMD_SUB_STAGE_IMAGE1. Argument indexes data_01_74e9_ImageTable1; the image's
; own three-byte header carries its size, so the script does not have to
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4653 $fa $9b $d6
    ld   DE, data_01_74e9_ImageTable1                              ;; 01:4656 $11 $e9 $74
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4659 $cd $b9 $07
    jp   call_01_4e78_Menu_StageTileData                                    ;; 01:465c $c3 $78 $4e

call_01_465f_MenuCmd_StageImage2:
; MENUCMD_SUB_STAGE_IMAGE2. As above but from data_01_74ed_ImageTable2, the larger
; table - cursors, remote icons, the stats icons
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:465f $fa $9b $d6
    ld   DE, data_01_74ed_ImageTable2                              ;; 01:4662 $11 $ed $74
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4665 $cd $b9 $07
    jp   call_01_4e78_Menu_StageTileData                                    ;; 01:4668 $c3 $78 $4e

call_01_466b_MenuCmd_StageTVScreen:
; MENUCMD_SUB_STAGE_TV_SCREEN. Draws the little picture inside the TV on the mission
; select screen: load the mission-select palette, hand the TV's own palette to bank
; $0B, then stage a fixed 6x5 tile block fetched from bank $13 through
; data_01_5cb9_TVScreenImageTable. Which picture is chosen by the map's
; MAPDATA_TV_PALETTE_ID, so the palette and the artwork can never disagree
    ld   HL, .data_01_46a8_MissionSelectPalette        ;; 01:466b $21 $a8 $46
    ld   DE, wDA4B_DynamicPalette                      ;; 01:466e $11 $4b $da
    ld   BC, MENU_PALETTE_BYTES                        ;; 01:4671 $01 $80 $00
    call call_00_07b0_MemCopy                                  ;; 01:4674 $cd $b0 $07
    FARCALL call_0b_5d4b_MediaDimension_LoadTVPalette
    call call_00_2e3a_MapData_GetTVPaletteId                                  ;; 01:4682 $cd $3a $2e
    ld   DE, data_01_5cb9_TVScreenImageTable                              ;; 01:4685 $11 $b9 $5c
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4688 $cd $b9 $07
    ld   A, [wD69A_Text_FontId]                                    ;; 01:468b $fa $9a $d6
    ld   [wD696_MenuCmd_FirstTileId], A                                    ;; 01:468e $ea $96 $d6
    ld   A, MENU_TV_SCREEN_WIDTH                       ;; 01:4691 $3e $06
    ld   [wD692_Text_BlockWidthTiles], A               ;; 01:4693 $ea $92 $d6
    ld   A, MENU_TV_SCREEN_HEIGHT                      ;; 01:4696 $3e $05
    ld   [wD693_Text_BlockHeightTiles], A              ;; 01:4698 $ea $93 $d6
    push HL                                            ;; 01:469b $e5
    call call_01_4e5a_Menu_GetTileDataSize                                  ;; 01:469c $cd $5a $4e
    pop  HL                                            ;; 01:469f $e1
    ld   DE, wC000_BgMapTileIds                        ;; 01:46a0 $11 $00 $c0
    ld   A, MENU_TV_SCREEN_BANK                        ;; 01:46a3 $3e $13
    jp   call_00_07a1_FarMemCopy                       ;; 01:46a5 $c3 $a1 $07
.data_01_46a8_MissionSelectPalette:
; MENU_PALETTE_BYTES of CGB background palettes for the mission select screen,
; installed before bank $0B is asked for the TV's own palette on top
    INCBIN "gfx/menus/palettes/palette_mission_select_menu.bin"

call_01_4728_MenuCmd_SetTVNameText:
; MENUCMD_SUB_TV_NAME_TEXT. Points the source pointer at the current TV's name
; ("SCREAM TV", "TOON TV", ...) from data_01_5ee7_TVNameTable, indexed the same way as the TV
; picture above
    call call_00_2e3a_MapData_GetTVPaletteId                                  ;; 01:4728 $cd $3a $2e
    ld   DE, data_01_5ee7_TVNameTable                              ;; 01:472b $11 $e7 $5e
    call call_00_07b9_GetPointerFromTable                                  ;; 01:472e $cd $b9 $07
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4731 $c3 $6f $4e

call_01_4734_MenuCmd_SetLevelText:
; MENUCMD_SUB_LEVEL_NAME_TEXT. Entry 0 of the map's text block is its name
    call call_00_2e4c_MapData_GetLevelNameText                                  ;; 01:4734 $cd $4c $2e
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:4737 $c3 $6f $4e

call_01_473a_MenuCmd_SetMissionText:
; MENUCMD_SUB_MISSION_TEXT. Argument is a mission slot 0-2, or MENUCMD_MISSION_CURRENT
; meaning "whichever mission is being played" (wD627_CurrentMission).
;
; For a real slot it also places the little marker sprite to the left of the line,
; whose tile says whether that mission's remote is already collected ($EC/$F4 on
; CGB) and whose colour differs on DMG. MENUCMD_MISSION_CURRENT sets bit 7 to skip
; the marker, which is why the pause menu shows the mission text without one.
;
; The sprite's position is derived from the block's own destination tile, so the
; marker follows the text wherever a script puts it
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:473a $fa $9b $d6
    cp   A, MENUCMD_MISSION_CURRENT                    ;; 01:473d $fe $03
    jr   NZ, .jr_01_4746                               ;; 01:473f $20 $05
    ld   A, [wD627_CurrentMission]                                    ;; 01:4741 $fa $27 $d6
    or   A, $80                                        ;; 01:4744 $f6 $80
.jr_01_4746:
    push AF                                            ;; 01:4746 $f5
    and  A, $7f                                        ;; 01:4747 $e6 $7f
    call call_00_2e5f_MapData_GetMissionText                                  ;; 01:4749 $cd $5f $2e
    call call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:474c $cd $6f $4e
    pop  AF                                            ;; 01:474f $f1
    bit  7, A                                          ;; 01:4750 $cb $7f
    ret  NZ                                            ;; 01:4752 $c0
    push AF                                            ;; 01:4753 $f5
    call call_01_4eb1_Menu_IsMissionRemoteCollected                                  ;; 01:4754 $cd $b1 $4e
    push AF                                            ;; 01:4757 $f5
    ld   C, MENU_MISSION_MARKER_COLLECTED              ;; 01:4758 $0e $ec
    ld   A, [wD59E_OnGBCFlag]                          ;; 01:475a $fa $9e $d5
    and  A, A                                          ;; 01:475d $a7
    jr   NZ, .jr_01_4769                               ;; 01:475e $20 $09
    ld   C, MENU_MISSION_MARKER_COLLECTED_DMG          ;; 01:4760 $0e $e8
    ld   A, B                                          ;; 01:4762 $78 ; B is the mask IsMissionRemoteCollected tested
    cp   A, REMOTE_BONUS_MASK                          ;; 01:4763 $fe $20
    jr   NZ, .jr_01_4769                               ;; 01:4765 $20 $02
    ld   C, MENU_MISSION_MARKER_BONUS_DMG              ;; 01:4767 $0e $f0
.jr_01_4769:
    pop  AF                                            ;; 01:4769 $f1 ; the collected/not answer
    jr   NZ, .jr_01_476e                               ;; 01:476a $20 $02
    ld   C, MENU_MISSION_MARKER_UNCOLLECTED            ;; 01:476c $0e $f4 ; one uncollected tile for both machines
.jr_01_476e:
    ld   A, C                                          ;; 01:476e $79
    ld   [wD5A8_Sprite_TileId], A                                    ;; 01:476f $ea $a8 $d5
    ld   A, [wD695_MenuCmd_DestTileY]                                    ;; 01:4772 $fa $95 $d6
    add  A, $02                                        ;; 01:4775 $c6 $02
    add  A, A                                          ;; 01:4777 $87
    add  A, A                                          ;; 01:4778 $87
    add  A, A                                          ;; 01:4779 $87
    ld   [wD5A6_TextBuffer], A                                    ;; 01:477a $ea $a6 $d5
    ld   A, [wD694_MenuCmd_DestTileX]                                    ;; 01:477d $fa $94 $d6
    inc  A                                             ;; 01:4780 $3c
    sub  A, $02                                        ;; 01:4781 $d6 $02
    add  A, A                                          ;; 01:4783 $87
    add  A, A                                          ;; 01:4784 $87
    add  A, A                                          ;; 01:4785 $87
    sub  A, $02                                        ;; 01:4786 $d6 $02
    ld   [wD5A7_Sprite_X], A                                    ;; 01:4788 $ea $a7 $d5
    ld   A, B                                          ;; 01:478b $78
    cp   A, REMOTE_BONUS_MASK                          ;; 01:478c $fe $20
    ld   A, MENU_MISSION_MARKER_PAL_BONUS              ;; 01:478e $3e $05
    jr   Z, .jr_01_4794                                ;; 01:4790 $28 $02
    ld   A, MENU_MISSION_MARKER_PAL_NORMAL             ;; 01:4792 $3e $03
.jr_01_4794:
    ld   [wD5A9_Sprite_Attributes], A                                    ;; 01:4794 $ea $a9 $d5
    pop  AF                                            ;; 01:4797 $f1
    add  A, A                                          ;; 01:4798 $87
    add  A, $02                                        ;; 01:4799 $c6 $02
    ld   [wD6D5_Menu_OamSlot], A                                    ;; 01:479b $ea $d5 $d6
    ld   BC, $202                                      ;; 01:479e $01 $02 $02
    jp   call_01_4e01_Menu_WriteSpriteRect                                  ;; 01:47a1 $c3 $01 $4e
call_01_47a4_MenuCmd_LoadScreen:
; MENUCMD_SUB_LOAD_SCREEN. Copies a 10-byte screen descriptor into wD6A5..wD6AE and
; hands it to the shared loader, which brings in a whole tileset and tilemap at once.
; Only one descriptor exists (.data_01_47bb_PasswordScreen, the password keyboard), so the argument
; is always 0
    ld   a, [wD69B_Text_SrcPtrLo]
    ld   de, .data_01_47b9_ScreenTable
    call call_00_07b9_GetPointerFromTable
    ld   de, wD6A5_ScreenDraw_TileDataBank
    ld   bc, $000a
    call call_00_07b0_MemCopy
    jp   call_00_07c3_Screen_LoadTilesAndTilemap
.data_01_47b9_ScreenTable:
; Only one screen descriptor exists, so MENUCMD_SUB_LOAD_SCREEN's argument is
; always 0
    dw   .data_01_47bb_PasswordScreen
.data_01_47bb_PasswordScreen:
; The password keyboard's frame: a whole tileset plus tilemap in one go. Copied to
; wD6A5_ScreenDraw_TileDataBank onward, so the fields below are that block's layout
    db   $09                                           ; tile data bank
    db   $b6                                           ; first tile id, also added to every tilemap byte
    db   $14, $12                                      ; 20 x 18 tiles - the whole screen
    dw   $42d0                                         ; tilemap, then the same many attribute bytes
    dw   $4000                                         ; tile graphics
    db   $d0, $02                                      ; $02d0 bytes of them

call_01_47c5_MenuCmd_DrawCursorSprite:
; MENUCMD_SUB_DRAW_CURSOR. Stages the cursor's graphics like any other image, then
; builds the little sprite script at wD6B9..wD6C0 out of the block's own width and
; height and records the image index as wD6C1_Menu_CursorSpriteId. From here on
; call_01_4d72_Menu_DrawCursor redraws it every frame, so a script only ever declares
; the cursor once
    call call_01_465f_MenuCmd_StageImage2                                  ;; 01:47c5 $cd $5f $46
    xor  A, A                                          ;; 01:47c8 $af
    ld   [wD6B9_MenuCursor_OamSlot], A                                    ;; 01:47c9 $ea $b9 $d6
    ld   A, [wD692_Text_BlockWidthTiles]                                    ;; 01:47cc $fa $92 $d6
    ld   [wD6BE_MenuCursor_WidthInColumns], A                                    ;; 01:47cf $ea $be $d6
    ld   A, [wD693_Text_BlockHeightTiles]                                    ;; 01:47d2 $fa $93 $d6
    ld   [wD6BF_MenuCursor_HeightInTileRows], A                                    ;; 01:47d5 $ea $bf $d6
    ld   A, $ff                                        ;; 01:47d8 $3e $ff
    ld   [wD6C0_MenuCursor_ScriptEnd], A                                    ;; 01:47da $ea $c0 $d6
    ld   A, [wD69B_Text_SrcPtrLo]                      ;; 01:47dd $fa $9b $d6 ; the image index the block asked for
    sub  A, $00                                        ;; 01:47e0 $d6 $00 ; no-op left in by the compiler
    add  A, MENU_CURSOR_ID_BASE                        ;; 01:47e2 $c6 $10
    ld   [wD6C1_Menu_CursorSpriteId], A                ;; 01:47e4 $ea $c1 $d6
    jp   call_01_4d72_Menu_DrawCursor                                  ;; 01:47e7 $c3 $72 $4d

call_01_47ea_MenuCmd_SetCounterText:
; MENUCMD_SUB_COUNTER_TEXT. Fetches one of the MENU_COUNTER_* values, formats it as
; decimal into wD5A6_TextBuffer and points the source pointer there, so the following
; MENUCMD_DRAW_TEXT draws a number that was computed this frame
    call call_01_47f6_MenuCmd_GetCounterValue                                  ;; 01:47ea $cd $f6 $47
    call call_01_4ce5_Text_FormatByte                                  ;; 01:47ed $cd $e5 $4c
    ld   HL, wD5A6_TextBuffer                                     ;; 01:47f0 $21 $a6 $d5
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:47f3 $c3 $6f $4e

call_01_47f6_MenuCmd_GetCounterValue:
; A = the number a MENU_COUNTER_* id refers to. Dispatches through .data_01_4800_CounterHandlers.
;
; The three remote counters share .jr_01_4852, which walks all LEVEL_COUNT entries of
; wD629_RemoteProgressFlags and counts set bits under the mask in C - so "how many
; red remotes have I found" is a popcount over the whole save state rather than a
; running total anyone has to maintain.
;
; The collectible counters stage themselves off wD648_CollectibleMilestoneIndex:
; a milestone already passed shows its full value ($1E, $28), the one in progress
; shows wD649_CollectibleAmount, and the ones beyond it show zero.
;
; The last two entries read the player's position and are never referenced by any
; menu script - leftover debug readouts
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:47f6 $fa $9b $d6
    ld   DE, .data_01_4800_CounterHandlers                             ;; 01:47f9 $11 $00 $48
    call call_00_07b9_GetPointerFromTable                                  ;; 01:47fc $cd $b9 $07
    jp   HL                                            ;; 01:47ff $e9
.data_01_4800_CounterHandlers:
; One handler per MENU_COUNTER_*
    dw   .jr_01_4814                                   ; $00 MENU_COUNTER_LIVES
    dw   .jr_01_4818                                   ; $01 MENU_COUNTER_HEALTH
    dw   .jr_01_481c                                   ; $02 MENU_COUNTER_MISSION_REMOTES
    dw   .jr_01_4820                                   ; $03 MENU_COUNTER_HIDDEN_REMOTES
    dw   .jr_01_4824                                   ; $04 MENU_COUNTER_BONUS_REMOTES
    dw   .jr_01_4828                                   ; $05 MENU_COUNTER_COLLECTIBLES_1
    dw   .jr_01_4834                                   ; $06 MENU_COUNTER_COLLECTIBLES_2
    dw   .jr_01_4847                                   ; $07 MENU_COUNTER_COLLECTIBLES_3
    dw   .jr_01_4869                                   ; $08 MENU_COUNTER_PLAYER_X - unused
    dw   .jr_01_486e                                   ; $09 MENU_COUNTER_PLAYER_Y - unused
.jr_01_4814:
    ld   A, [wD73D_LivesRemaining]                                    ;; 01:4814 $fa $3d $d7
    ret                                                ;; 01:4817 $c9
.jr_01_4818:
    ld   A, [wD741_Player_Health]                                    ;; 01:4818 $fa $41 $d7
    ret                                                ;; 01:481b $c9
.jr_01_481c:
    ld   C, REMOTE_MISSION_MASK                        ;; 01:481c $0e $07
    jr   .jr_01_4852                                   ;; 01:481e $18 $32
.jr_01_4820:
    ld   C, REMOTE_HIDDEN_MASK                         ;; 01:4820 $0e $18
    jr   .jr_01_4852                                   ;; 01:4822 $18 $2e
.jr_01_4824:
    ld   C, REMOTE_BONUS_MASK                          ;; 01:4824 $0e $20
    jr   .jr_01_4852                                   ;; 01:4826 $18 $2a
.jr_01_4828:
    ; milestone 1: full once it has been passed, live otherwise
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$01
    ld   a,MENU_COLLECTIBLE_MILESTONE_1
    ret  nc
    ld   a,[wD649_CollectibleAmount]
    ret  
.jr_01_4834:
    ; milestone 2: full, live, or not started yet
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$02
    ld   a,MENU_COLLECTIBLE_MILESTONE_2
    ret  nc
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$01
    ld   a,[wD649_CollectibleAmount]
    ret  nc
    xor  a
    ret  
.jr_01_4847:
    ; milestone 3: the last one, so it is either live or not started - there is no
    ; "already passed" value for it
    ld   a,[wD648_CollectibleMilestoneIndex]
    cp   a,$02
    ld   a,[wD649_CollectibleAmount]
    ret  nc
    xor  a
    ret  
.jr_01_4852:
    ld   HL, wD629_RemoteProgressFlags                                     ;; 01:4852 $21 $29 $d6
    ld   B, LEVEL_COUNT                                ;; 01:4855 $06 $1e
    ld   E, $00                                        ;; 01:4857 $1e $00
.jr_01_4859:
    ld   A, [HL+]                                      ;; 01:4859 $2a
    and  A, C                                          ;; 01:485a $a1
    ld   D, $08                                        ;; 01:485b $16 $08
.jr_01_485d:
    rlca                                               ;; 01:485d $07
    jr   NC, .jr_01_4861                               ;; 01:485e $30 $01
    inc  E                                             ;; 01:4860 $1c
.jr_01_4861:
    dec  D                                             ;; 01:4861 $15
    jr   NZ, .jr_01_485d                               ;; 01:4862 $20 $f9
    dec  B                                             ;; 01:4864 $05
    jr   NZ, .jr_01_4859                               ;; 01:4865 $20 $f2
    ld   A, E                                          ;; 01:4867 $7b
    ret                                                ;; 01:4868 $c9
.jr_01_4869:
    ; MENU_COUNTER_PLAYER_X / _Y: the player's 16-bit subpixel position shifted
    ; down to whole tiles (x8, then take the high byte). No menu script asks for
    ; either, so these are leftover debug readouts
    ld   hl,wD20E_Player_XPositionLo
    jr   .jr_01_4871
.jr_01_486e:
    ld   hl,wD210_Player_YPositionLo
.jr_01_4871:
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    ret  

call_01_4879_MenuCmd_DrawRemoteIcons:
; MENUCMD_SUB_REMOTE_ICONS. Draws the row of remote icons for the page being shown.
;
; Each of the MENU_REMOTE_ICON_COUNT icons has a lit tile in .data_01_48d9_RemoteIconTiles and an
; unlit one $24 tiles later; the bits of wD629_RemoteProgressFlags are shifted out
; one at a time to choose between them, and the results go into
; wD5AA_Sprite_TileIdTable rather than into the sprite script - so one fixed layout
; covers every combination of collected remotes.
;
; The layout itself is picked by adding the level's remote progress id to the group
; base in the argument (MENU_SPRITE_GROUP_TOTALS or _CONGRATS), which is how a level
; with two objectives draws two icons and one with five draws five.
;
; wD69A is not a font id here: when non-zero it is the frame delay after which
; call_01_4d25_Menu_TickHideSprites erases this group again
    ld   A, [wD69A_Text_FontId]                                    ;; 01:4879 $fa $9a $d6
    and  A, A                                          ;; 01:487c $a7
    jr   Z, .jr_01_4888                                ;; 01:487d $28 $09
    ld   [wD6D8_Menu_HideSpritesDelay], A                                    ;; 01:487f $ea $d8 $d6
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4882 $fa $9b $d6
    ld   [wD6D9_Menu_HideSpritesGroup], A                                    ;; 01:4885 $ea $d9 $d6
.jr_01_4888:
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4888 $fa $9b $d6
    cp   A, MENU_SPRITE_GROUP_TOTALS                   ;; 01:488b $fe $00
    jr   Z, .jr_01_4899                                ;; 01:488d $28 $0a
    cp   A, MENU_SPRITE_GROUP_CONGRATS                 ;; 01:488f $fe $07
    jr   NZ, .jr_01_48d0                               ;; 01:4891 $20 $3d
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4893 $fa $24 $d6
    ld   [wD625_TotalsMenuPage], A                                    ;; 01:4896 $ea $25 $d6
.jr_01_4899:
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:4899 $fa $24 $d6
    push AF                                            ;; 01:489c $f5
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:489d $fa $25 $d6
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48a0 $ea $24 $d6
    ld   L, A                                          ;; 01:48a3 $6f
    ld   H, $00                                        ;; 01:48a4 $26 $00
    ld   DE, wD629_RemoteProgressFlags                                     ;; 01:48a6 $11 $29 $d6
    add  HL, DE                                        ;; 01:48a9 $19
    ld   C, [HL]                                       ;; 01:48aa $4e
    ld   HL, wD5AA_Sprite_TileIdTable                                     ;; 01:48ab $21 $aa $d5
    ld   DE, .data_01_48d9_RemoteIconTiles                             ;; 01:48ae $11 $d9 $48
    ld   B, MENU_REMOTE_ICON_COUNT                     ;; 01:48b1 $06 $06
.jr_01_48b3:
    ld   A, [DE]                                       ;; 01:48b3 $1a
    srl  C                                             ;; 01:48b4 $cb $39 ; next remote bit, LSB first
    jr   C, .jr_01_48ba                                ;; 01:48b6 $38 $02
    add  A, MENU_REMOTE_ICON_UNLIT_OFFSET              ;; 01:48b8 $c6 $24 ; not collected - use the dark twin
.jr_01_48ba:
    ld   [HL+], A                                      ;; 01:48ba $22
    inc  DE                                            ;; 01:48bb $13
    dec  B                                             ;; 01:48bc $05
    jr   NZ, .jr_01_48b3                               ;; 01:48bd $20 $f4
    call call_00_2e43_MapData_GetRemoteProgressId                                  ;; 01:48bf $cd $43 $2e
    ld   C, A                                          ;; 01:48c2 $4f
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:48c3 $fa $9b $d6
    add  A, C                                          ;; 01:48c6 $81
    ld   C, A                                          ;; 01:48c7 $4f
    pop  AF                                            ;; 01:48c8 $f1
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48c9 $ea $24 $d6
    ld   A, C                                          ;; 01:48cc $79
    ld   [wD6DA_Menu_TotalsSpriteGroup], A                                    ;; 01:48cd $ea $da $d6
.jr_01_48d0:
    ld   DE, data_01_5aa9_SpriteScriptTable                              ;; 01:48d0 $11 $a9 $5a
    call call_00_07b9_GetPointerFromTable                                  ;; 01:48d3 $cd $b9 $07
    jp   call_01_4dc8_Menu_BuildSpriteBlock                                    ;; 01:48d6 $c3 $c8 $4d
.data_01_48d9_RemoteIconTiles:
; The lit tile for each of the six bits of wD629_RemoteProgressFlags. The icons
; are 3x4 tiles, so the three artworks are $0C apart: the three mission remotes
; all share the red one, the two hidden remotes share silver, and the bonus bit
; gets gold. Add MENU_REMOTE_ICON_UNLIT_OFFSET for the unlit version
    db   $98, $98, $98                                 ; bits 0-2, red
    db   $a4, $a4                                      ; bits 3-4, silver
    db   $b0                                           ; bit 5, gold

call_01_48df_MenuCmd_SetTotalsPageText:
; MENUCMD_SUB_TOTALS_PAGE_TEXT. The totals screen's heading: the level name for the
; page you are on, or "GAME STATS" for page 0, which is the whole-game summary rather
; than a level. wD624_CurrentLevelId is borrowed as the lookup key and restored,
; because the level name accessor only knows how to read the current level
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:48df $fa $25 $d6
    and  A, A                                          ;; 01:48e2 $a7
    jr   Z, .jr_01_48f7                                ;; 01:48e3 $28 $12
    ld   A, [wD624_CurrentLevelId]                                    ;; 01:48e5 $fa $24 $d6
    push AF                                            ;; 01:48e8 $f5
    ld   A, [wD625_TotalsMenuPage]                                    ;; 01:48e9 $fa $25 $d6
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48ec $ea $24 $d6
    call call_01_4734_MenuCmd_SetLevelText                                  ;; 01:48ef $cd $34 $47
    pop  AF                                            ;; 01:48f2 $f1
    ld   [wD624_CurrentLevelId], A                                    ;; 01:48f3 $ea $24 $d6
    ret                                                ;; 01:48f6 $c9
.jr_01_48f7:
    ld   HL, data_01_5d4b_Text_GameStats                              ;; 01:48f7 $21 $4b $5d
    jp   call_01_4e6f_Menu_SetScriptSrcPtr                                  ;; 01:48fa $c3 $6f $4e

call_01_48fd_MenuCmd_SetPasswordCharText:
; MENUCMD_SUB_PASSWORD_CHAR_TEXT. Argument is a cell index into the flat array at
; wD667_PasswordExitButton. Copies that one character into wD60A_OneCharString and
; terminates it, so a single letter can go through the ordinary text renderer without
; a string in ROM for every possible letter in every possible box
    ld   hl,wD69B_Text_SrcPtrLo
    ld   l,[hl]
    ld   h,$00
    ld   de,wD667_PasswordExitButton
    add  hl,de
    ld   a,[hl]
    ld   [wD60A_OneCharString],a
    ld   a,END_TEXT
    ld   [wD60B_OneCharStringEnd],a                    ; bit 7 alone: an empty line, ending the string
    ld   hl,wD60A_OneCharString
    jp   call_01_4e6f_Menu_SetScriptSrcPtr

call_01_4916_MenuCmd_SetChainedScript:
; MENUCMD_SUB_CHAIN_SCRIPT. Queues another script to run once this one ends; see
; data_01_568c_ChainedScriptTable. Only the last one set wins, since there is a single
; slot in wD6D7_Menu_ChainedScriptId
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:4916 $fa $9b $d6
    ld   [wD6D7_Menu_ChainedScriptId], A                                    ;; 01:4919 $ea $d7 $d6
    ret                                                ;; 01:491c $c9

call_01_491d_MenuCmd_LoadFullscreenImage:
; MENUCMD_SUB_FULLSCREEN_IMAGE. Argument is a MENU_IMAGE_* id; .data_01_4932_FullscreenImages turns it
; into a bank and pointer, which the shared loader unpacks over the whole screen.
; These are the title cards and the credit pages - the screens with no layout of their
; own, just a picture
    ld   A, [wD69B_Text_SrcPtrLo]                                    ;; 01:491d $fa $9b $d6
    ld   DE, .data_01_4932_FullscreenImages                             ;; 01:4920 $11 $32 $49
    call call_00_07b9_GetPointerFromTable                                  ;; 01:4923 $cd $b9 $07
    ld   DE, wD6B0_FullscreenImage_Bank                                     ;; 01:4926 $11 $b0 $d6
    ld   BC, $03                                       ;; 01:4929 $01 $03 $00
    call call_00_07b0_MemCopy                                  ;; 01:492c $cd $b0 $07
    jp   call_00_084d_Screen_LoadFullscreenImage                                    ;; 01:492f $c3 $4d $08
.data_01_4932_FullscreenImages:
; MENU_IMAGE_* -> a 3-byte bank/pointer descriptor for
; call_00_084d_Screen_LoadFullscreenImage. The indirection exists because the
; descriptor has to be copied into WRAM before the loader can read it
    dw   .data_01_4948_TitleScreen                     ; $00 MENU_IMAGE_TITLE_0
    dw   .data_01_494b_TitleOptions                    ; $01 MENU_IMAGE_TITLE_1
    dw   .data_01_494e_AudioMenu                       ; $02 MENU_IMAGE_AUDIO_MENU
    dw   .data_01_4951_GreatJob                        ; $03 MENU_IMAGE_GREAT_JOB
    dw   .data_01_4954_Crave                           ; $04 MENU_IMAGE_CRAVE
    dw   .data_01_4957_Splash                          ; $05 MENU_IMAGE_SPLASH
    dw   .data_01_495a_David                           ; $06 MENU_IMAGE_DAVID
    dw   .data_01_495d_Credits1                        ; $07 MENU_IMAGE_CREDITS_1
    dw   .data_01_4960_Credits2                        ; $08 MENU_IMAGE_CREDITS_2
    dw   .data_01_4963_Credits3                        ; $09 MENU_IMAGE_CREDITS_3
    dw   .data_01_4966_Credits4                        ; $0A MENU_IMAGE_CREDITS_4
.data_01_4948_TitleScreen:
    farpointer image_title_screen_008_0
.data_01_494b_TitleOptions:
    farpointer image_title_screen_008_1
.data_01_494e_AudioMenu:
    farpointer image_audio_menu_00c_0
.data_01_4951_GreatJob:
    farpointer image_great_job_0c_2
.data_01_4954_Crave:
    farpointer image_crave_01f_0
.data_01_4957_Splash:
    farpointer image_splash_01f_1
.data_01_495a_David:
    farpointer image_david_01e_0
.data_01_495d_Credits1:
    farpointer image_credits1_01e_1
.data_01_4960_Credits2:
    farpointer image_credits2_01d_0
.data_01_4963_Credits3:
    farpointer image_credits3_01d_1
.data_01_4966_Credits4:
    farpointer image_credits4_03d_0
    
call_01_4969_MenuCmd_SetMissionStatusText:
; Picks the "how are you doing on this level" string from a 2D table, and points
; the source pointer at it so the next MENUCMD_DRAW_TEXT block renders it.
;
; Row is the level's remote progress id; column is how many of its three mission
; remotes you hold, counted straight out of wD629_RemoteProgressFlags by the
; `srl C / adc A,$00` popcount of bits 0-2 - so 0 to 3. Progress id 5 is the odd
; one out and tests bit 5 instead, giving a plain yes/no.
;
; Address is .data_01_49a7_MissionStatusText + row*8 + column*2, so the table is
; eight rows of four pointers
    call call_00_2e43_MapData_GetRemoteProgressId
    push af
    push af
    ld   hl,wD624_CurrentLevelId
    ld   l,[hl]
    ld   h,$00
    ld   de,wD629_RemoteProgressFlags
    add  hl,de
    ld   c,[hl]
    pop  af
    cp   a,$05
    jr   nz,.jr_01_4987
    ld   a,c
    and  a,$20
    jr   z,.jr_01_4991
    ld   a,$01
    jr   .jr_01_4991
.jr_01_4987:
    ld   b,$03
    xor  a
.jr_01_498a:
    srl  c
    adc  a,$00
    dec  b
    jr   nz,.jr_01_498a
.jr_01_4991:
    add  a
    ld   e,a
    ld   d,$00
    pop  af
    ld   l,a
    ld   h,$00
    add  hl,hl
    add  hl,hl
    add  hl,hl
    add  hl,de
    ld   de,.data_01_49a7_MissionStatusText
    add  hl,de
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    jp   call_01_4e6f_Menu_SetScriptSrcPtr
.data_01_49a7_MissionStatusText:
; 8 rows x 4 pointers, indexed [remote progress id][missions collected]. Several
; columns repeat the same address, which is how one string covers "1 or 2 done"
    dw   data_01_5d97_Text_0Of3RedRemotes, data_01_5db0_Text_1Of3RedRemotes, data_01_5dc9_Text_2Of3RedRemotes, data_01_5de2_Text_3Of3RedRemotes
    dw   data_01_5dfb_Text_0Of2RedRemotes, data_01_5e14_Text_1Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes
    dw   data_01_5e46_Text_0Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes
    dw   data_01_5dfb_Text_0Of2RedRemotes, data_01_5e14_Text_1Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes, data_01_5e2d_Text_2Of2RedRemotes
    dw   data_01_5e46_Text_0Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes, data_01_5e5f_Text_1Of1RedRemotes
    dw   data_01_5e78_Text_0Of1GoldRemotes, data_01_5e92_Text_1Of1GoldRemotes, data_01_5e92_Text_1Of1GoldRemotes, data_01_5e92_Text_1Of1GoldRemotes

call_01_49d7_MenuCmd_StageCollectibleIcon:
; Stages the current level's collectible icon - the fruit/bug/whatever that level
; uses - as a 3x2 tile block starting at tile id $92.
;
; The graphics come from data_01_7c0f_CollectibleIconTable indexed by level id, and
; the 24 bytes immediately after them in ROM are the icon's tilemap ids, copied on
; to wDAAB_MenuBgMapTileIds. The 128-byte blob loaded first is the CGB palette set
    ld   hl,.data_01_4a0f_PauseMenuPalette
    ld   de,wDA4B_DynamicPalette
    ld   bc,MENU_PALETTE_BYTES
    call call_00_07b0_MemCopy
    ld   a,[wD624_CurrentLevelId]
    ld   de,data_01_7c0f_CollectibleIconTable
    call call_00_07b9_GetPointerFromTable
    ld   a,MENU_COLLECTIBLE_ICON_TILE
    ld   [wD696_MenuCmd_FirstTileId],a
    ld   a,MENU_COLLECTIBLE_ICON_WIDTH
    ld   [wD692_Text_BlockWidthTiles],a
    ld   a,MENU_COLLECTIBLE_ICON_HEIGHT
    ld   [wD693_Text_BlockHeightTiles],a
    push hl
    call call_01_4e5a_Menu_GetTileDataSize
    pop  hl
    ld   de,wC000_BgMapTileIds
    call call_00_07b0_MemCopy                          ; HL now sits on the tilemap ids that follow
    ld   de,wDAAB_MenuBgMapTileIds
    ld   bc,MENU_COLLECTIBLE_TILEMAP_BYTES
    jp   call_00_07b0_MemCopy
.data_01_4a0f_PauseMenuPalette:
; MENU_PALETTE_BYTES of CGB background palettes. Named for the screen it dresses -
; the collectible icon is drawn on the pause and congratulations screens, and the
; icon's own palette set is loaded on top of this one from the blob in ROM
    INCBIN "gfx/menus/palettes/palette_pause_menu.bin"
