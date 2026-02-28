call_00_1264_LoadFullMap:
    call call_00_0ede                                  ;; 00:1264 $cd $de $0e
    call call_00_2e77_GetCurrentMapBankNumber                                  ;; 00:1267 $cd $77 $2e
    ld   [wD6F5_CurrentMapBank], A                                    ;; 00:126a $ea $f5 $d6
    call call_00_2e80_GetCurrentSecondaryTilesetBank                                  ;; 00:126d $cd $80 $2e
    ld   [wD6F6_SecondaryTilesetOverrideBank], A                                    ;; 00:1270 $ea $f6 $d6
    call call_00_2e89_GetCurrentBlocksetBank                                  ;; 00:1273 $cd $89 $2e
    ld   [wD6F7_CurrentBlocksetAndCollisionBank], A                                    ;; 00:1276 $ea $f7 $d6
    call call_00_2e93_GetBlocksetOverrideBit                                  ;; 00:1279 $cd $93 $2e
    ld   [wD6FE_LevelTileOverrideBit], A                                    ;; 00:127c $ea $fe $d6
    call call_00_2e9c_GetCurrentBgTilesetBank                                  ;; 00:127f $cd $9c $2e
    ld   [wD6FF_CurrentBgTilesetBank], A                                    ;; 00:1282 $ea $ff $d6
    call call_00_2ea5                                  ;; 00:1285 $cd $a5 $2e
    ld   HL, wD700                                     ;; 00:1288 $21 $00 $d7
    ld   [HL], E                                       ;; 00:128b $73
    inc  HL                                            ;; 00:128c $23
    ld   [HL], D                                       ;; 00:128d $72
    call call_00_0f38                                  ;; 00:128e $cd $38 $0f
    call call_00_1419_WriteTilesToVRAM                                  ;; 00:1291 $cd $19 $14
    ld   A, $ff                                        ;; 00:1294 $3e $ff
    ld   [wD72D_CurrentSecondaryTilesetIndex], A                                    ;; 00:1296 $ea $2d $d7
    xor  A, A                                          ;; 00:1299 $af
    ld   [wD77B], A                                    ;; 00:129a $ea $7b $d7
    ld   [wD77D], A                                    ;; 00:129d $ea $7d $d7
    ld   A, $16                                        ;; 00:12a0 $3e $16
.jr_00_12a2:
    push AF                                            ;; 00:12a2 $f5
    ld   A, $01                                        ;; 00:12a3 $3e $01
    ld   [wD6F9], A                                    ;; 00:12a5 $ea $f9 $d6
    call call_00_1455_LoadBgMapDirtyRegions                                  ;; 00:12a8 $cd $55 $14
    ld   [wD59D_ReturnBank], A                                    ;; 00:12ab $ea $9d $d5
    ld   A, Bank03                                        ;; 00:12ae $3e $03
    ld   HL, call_03_6f5e_WriteVRAMBgMap                                     ;; 00:12b0 $21 $5e $6f
    call call_00_1078_FarCall                                  ;; 00:12b3 $cd $78 $10
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:12b6 $21 $ef $d6
    ld   A, [HL]                                       ;; 00:12b9 $7e
    add  A, $08                                        ;; 00:12ba $c6 $08
    ld   [HL], A                                       ;; 00:12bc $77
    inc  HL                                            ;; 00:12bd $23
    ld   A, [HL]                                       ;; 00:12be $7e
    adc  A, $00                                        ;; 00:12bf $ce $00
    ld   [HL], A                                       ;; 00:12c1 $77
    pop  AF                                            ;; 00:12c2 $f1
    dec  A                                             ;; 00:12c3 $3d
    jr   NZ, .jr_00_12a2                               ;; 00:12c4 $20 $dc
    ld   [wD6F9], A                                    ;; 00:12c6 $ea $f9 $d6
    ld   [wD59D_ReturnBank], A                                    ;; 00:12c9 $ea $9d $d5
    ld   A, Bank03                                        ;; 00:12cc $3e $03
    ld   HL, call_03_66ae                                     ;; 00:12ce $21 $ae $66
    call call_00_1078_FarCall                                  ;; 00:12d1 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:12d4 $ea $9d $d5
    ld   A, Bank02                                        ;; 00:12d7 $3e $02
    ld   HL, call_02_715a_UpdateMapWindow                                     ;; 00:12d9 $21 $5a $71
    call call_00_1078_FarCall                                  ;; 00:12dc $cd $78 $10
    xor  A, A                                          ;; 00:12df $af
    ld   [wD6F9], A                                    ;; 00:12e0 $ea $f9 $d6
    ret                                                ;; 00:12e3 $c9

call_00_12e4:
    ld   HL, wD78B                                     ;; 00:12e4 $21 $8b $d7
    ld   B, $10                                        ;; 00:12e7 $06 $10
    xor  A, A                                          ;; 00:12e9 $af
.jr_00_12ea:
    ld   [HL+], A                                      ;; 00:12ea $22
    dec  B                                             ;; 00:12eb $05
    jr   NZ, .jr_00_12ea                               ;; 00:12ec $20 $fc
    ld   [wD778], A                                    ;; 00:12ee $ea $78 $d7
    ld   HL, wD624_CurrentLevelId                                     ;; 00:12f1 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:12f4 $6e
    ld   H, $00                                        ;; 00:12f5 $26 $00
    ld   DE, .data_00_1356                                     ;; 00:12f7 $11 $56 $13
    add  HL, DE                                        ;; 00:12fa $19
    ld   A, [HL]                                       ;; 00:12fb $7e
    ld   HL, wD798                                     ;; 00:12fc $21 $98 $d7
    ld   B, $03                                        ;; 00:12ff $06 $03
.jr_00_1301:
    rrca                                               ;; 00:1301 $0f
    rl   [HL]                                          ;; 00:1302 $cb $16
    inc  HL                                            ;; 00:1304 $23
    dec  B                                             ;; 00:1305 $05
    jr   NZ, .jr_00_1301                               ;; 00:1306 $20 $f9
    ld   A, [wD624_CurrentLevelId]                                    ;; 00:1308 $fa $24 $d6
    and  A, A                                          ;; 00:130b $a7
    ret  NZ                                            ;; 00:130c $c0
    ld   HL, .data_00_1375                                     ;; 00:130d $21 $75 $13
.jr_00_1310:
    ld   A, [HL]                                       ;; 00:1310 $7e
    cp   A, $ff                                        ;; 00:1311 $fe $ff
    ret  Z                                             ;; 00:1313 $c8
    push HL                                            ;; 00:1314 $e5
    ld   A, [wD64F]                                    ;; 00:1315 $fa $4f $d6
    and  A, $7f                                        ;; 00:1318 $e6 $7f
    cp   A, [HL]                                       ;; 00:131a $be
    jr   C, .jr_00_134f                                ;; 00:131b $38 $32
    jr   NZ, .jr_00_1332                               ;; 00:131d $20 $13
    ld   A, [wD64F]                                    ;; 00:131f $fa $4f $d6
    bit  7, A                                          ;; 00:1322 $cb $7f
    jr   Z, .jr_00_1332                                ;; 00:1324 $28 $0c
    inc  HL                                            ;; 00:1326 $23
    ld   L, [HL]                                       ;; 00:1327 $6e
    ld   H, $00                                        ;; 00:1328 $26 $00
    ld   DE, wD78B                                     ;; 00:132a $11 $8b $d7
    add  HL, DE                                        ;; 00:132d $19
    ld   [HL], $02                                     ;; 00:132e $36 $02
    jr   .jr_00_134f                                   ;; 00:1330 $18 $1d
.jr_00_1332:
    inc  HL                                            ;; 00:1332 $23
    inc  HL                                            ;; 00:1333 $23
    ld   A, [HL+]                                      ;; 00:1334 $2a
    ld   [wD782], A                                    ;; 00:1335 $ea $82 $d7
    ld   A, [HL+]                                      ;; 00:1338 $2a
    ld   [wD783], A                                    ;; 00:1339 $ea $83 $d7
    ld   A, L                                          ;; 00:133c $7d
    ld   [wD780], A                                    ;; 00:133d $ea $80 $d7
    ld   A, H                                          ;; 00:1340 $7c
    ld   [wD781], A                                    ;; 00:1341 $ea $81 $d7
    ld   A, $02                                        ;; 00:1344 $3e $02
    ld   [wD784], A                                    ;; 00:1346 $ea $84 $d7
    ld   [wD785], A                                    ;; 00:1349 $ea $85 $d7
    call call_00_1ec9_UpdateBgTileFlags                                  ;; 00:134c $cd $c9 $1e
.jr_00_134f:
    pop  HL                                            ;; 00:134f $e1
    ld   DE, $0c                                       ;; 00:1350 $11 $0c $00
    add  HL, DE                                        ;; 00:1353 $19
    jr   .jr_00_1310                                   ;; 00:1354 $18 $ba
.data_00_1356:
    db   $00, $01, $05, $07, $03, $03, $00, $03        ;; 00:1356 ...?????
    db   $03, $07, $07, $03, $00, $07, $01, $00        ;; 00:135e ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:1366 ????????
    db   $01, $01, $03, $00, $00, $00, $00
.data_00_1375:
    db   $06        ;; 00:136e ???????.
    db   $00, $25, $0d, $7c, $01, $7d, $01, $8c        ;; 00:1376 ????????
    db   $01, $8d, $01, $09, $01, $1b, $16, $78        ;; 00:137e ???.????
    db   $01, $79, $01, $88, $01, $89, $01, $12        ;; 00:1386 ???????.
    db   $02, $2f, $16, $5c, $01, $5d, $01, $6c        ;; 00:138e ????????
    db   $01, $6d, $01, $0d, $03, $43, $16, $58        ;; 00:1396 ???.????
    db   $01, $59, $01, $68, $01, $69, $01, $ff        ;; 00:139e ???????.

call_00_13a6_UpdatePlayerMapWindow:
    ld   HL, wD20E_PlayerXPosition                                     ;; 00:13a6 $21 $0e $d2
    ld   A, [HL+]                                      ;; 00:13a9 $2a
    sub  A, $50                                        ;; 00:13aa $d6 $50
    ld   E, A                                          ;; 00:13ac $5f
    ld   A, [HL]                                       ;; 00:13ad $7e
    sbc  A, $00                                        ;; 00:13ae $de $00
    ld   D, A                                          ;; 00:13b0 $57
    jr   C, .jr_00_13c8                                ;; 00:13b1 $38 $15
    ld   A, E                                          ;; 00:13b3 $7b
    sub  A, $20                                        ;; 00:13b4 $d6 $20
    ld   A, D                                          ;; 00:13b6 $7a
    sbc  A, $00                                        ;; 00:13b7 $de $00
    jr   C, .jr_00_13c8                                ;; 00:13b9 $38 $0d
    ld   A, E                                          ;; 00:13bb $7b
    sub  A, $40                                        ;; 00:13bc $d6 $40
    ld   A, D                                          ;; 00:13be $7a
    sbc  A, $0f                                        ;; 00:13bf $de $0f
    jr   C, .jr_00_13cb                                ;; 00:13c1 $38 $08
    ld   DE, $f40                                      ;; 00:13c3 $11 $40 $0f
    jr   .jr_00_13cb                                   ;; 00:13c6 $18 $03
.jr_00_13c8:
    ld   DE, $20                                       ;; 00:13c8 $11 $20 $00
.jr_00_13cb:
    ld   HL, wD6ED_XPositionInMap                                     ;; 00:13cb $21 $ed $d6
    ld   [HL], E                                       ;; 00:13ce $73
    inc  HL                                            ;; 00:13cf $23
    ld   [HL], D                                       ;; 00:13d0 $72
    ld   L, E                                          ;; 00:13d1 $6b
    ld   H, D                                          ;; 00:13d2 $62
    add  HL, HL                                        ;; 00:13d3 $29
    add  HL, HL                                        ;; 00:13d4 $29
    add  HL, HL                                        ;; 00:13d5 $29
    ld   A, H                                          ;; 00:13d6 $7c
    ld   [wD329], A                                    ;; 00:13d7 $ea $29 $d3
    add  A, $05                                        ;; 00:13da $c6 $05
    ld   [wD32A], A                                    ;; 00:13dc $ea $2a $d3
    ld   HL, wD210_PlayerYPosition                                     ;; 00:13df $21 $10 $d2
    ld   A, [HL+]                                      ;; 00:13e2 $2a
    sub  A, $48                                        ;; 00:13e3 $d6 $48
    ld   E, A                                          ;; 00:13e5 $5f
    ld   A, [HL]                                       ;; 00:13e6 $7e
    sbc  A, $00                                        ;; 00:13e7 $de $00
    ld   D, A                                          ;; 00:13e9 $57
    jr   C, .jr_00_1401                                ;; 00:13ea $38 $15
    ld   A, E                                          ;; 00:13ec $7b
    sub  A, $20                                        ;; 00:13ed $d6 $20
    ld   A, D                                          ;; 00:13ef $7a
    sbc  A, $00                                        ;; 00:13f0 $de $00
    jr   C, .jr_00_1401                                ;; 00:13f2 $38 $0d
    ld   A, E                                          ;; 00:13f4 $7b
    sub  A, $50                                        ;; 00:13f5 $d6 $50
    ld   A, D                                          ;; 00:13f7 $7a
    sbc  A, $0f                                        ;; 00:13f8 $de $0f
    jr   C, .jr_00_1404                                ;; 00:13fa $38 $08
    ld   DE, $f50                                      ;; 00:13fc $11 $50 $0f
    jr   .jr_00_1404                                   ;; 00:13ff $18 $03
.jr_00_1401:
    ld   DE, $20                                       ;; 00:1401 $11 $20 $00
.jr_00_1404:
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:1404 $21 $ef $d6
    ld   [HL], E                                       ;; 00:1407 $73
    inc  HL                                            ;; 00:1408 $23
    ld   [HL], D                                       ;; 00:1409 $72
    ld   L, E                                          ;; 00:140a $6b
    ld   H, D                                          ;; 00:140b $62
    add  HL, HL                                        ;; 00:140c $29
    add  HL, HL                                        ;; 00:140d $29
    add  HL, HL                                        ;; 00:140e $29
    ld   A, H                                          ;; 00:140f $7c
    ld   [wD32B], A                                    ;; 00:1410 $ea $2b $d3
    add  A, $05                                        ;; 00:1413 $c6 $05
    ld   [wD32C], A                                    ;; 00:1415 $ea $2c $d3
    ret                                                ;; 00:1418 $c9

call_00_1419_WriteTilesToVRAM: ; this function writes to the tiles part of vram (8000-9800)
    ld   A, [wD6FF_CurrentBgTilesetBank]                                    ;; 00:1419 $fa $ff $d6
    call call_00_1089_SwitchBank                                  ;; 00:141c $cd $89 $10
    ld   HL, wD700                                     ;; 00:141f $21 $00 $d7
    ld   A, [HL+]                                      ;; 00:1422 $2a
    ld   H, [HL]                                       ;; 00:1423 $66
    ld   L, A                                          ;; 00:1424 $6f
    ld   DE, $9000                                     ;; 00:1425 $11 $00 $90
.jr_00_1428:
    ld   A, [HL+]                                      ;; 00:1428 $2a
    ld   [DE], A                                       ;; 00:1429 $12
    inc  DE                                            ;; 00:142a $13
    ld   A, D                                          ;; 00:142b $7a
    cp   A, $98                                        ;; 00:142c $fe $98
    jr   NZ, .jr_00_1428                               ;; 00:142e $20 $f8
    ld   DE, $8800                                     ;; 00:1430 $11 $00 $88
.jr_00_1433:
    ld   A, [HL+]                                      ;; 00:1433 $2a
    ld   [DE], A                                       ;; 00:1434 $12
    inc  DE                                            ;; 00:1435 $13
    ld   A, D                                          ;; 00:1436 $7a
    cp   A, $90                                        ;; 00:1437 $fe $90
    jr   NZ, .jr_00_1433                               ;; 00:1439 $20 $f8
    ;; at this point the tiles have been written
    call call_00_10a3_RestoreBank                                  ;; 00:143b $cd $a3 $10 
    ld   [wD59D_ReturnBank], A                                    ;; 00:143e $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:1441 $3e $0b
    ld   HL, call_0b_641e                                     ;; 00:1443 $21 $1e $64
    call call_00_1078_FarCall                                  ;; 00:1446 $cd $78 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:1449 $ea $9d $d5
    ld   A, Bank03                                        ;; 00:144c $3e $03
    ld   HL, call_03_723c_SetupAnimatedTile                                     ;; 00:144e $21 $3c $72
    call call_00_1078_FarCall                                  ;; 00:1451 $cd $78 $10
    ret                                                ;; 00:1454 $c9

call_00_1455_LoadBgMapDirtyRegions:
    ld   HL, wD6F9                                     ;; 00:1455 $21 $f9 $d6
    bit  7, [HL]                                       ;; 00:1458 $cb $7e
    jr   NZ, call_00_1455_LoadBgMapDirtyRegions                              ;; 00:145a $20 $f9
    ld   A, [wD6F9]                                    ;; 00:145c $fa $f9 $d6
    and  A, $03                                        ;; 00:145f $e6 $03
    call NZ, call_00_1472_LoadVerticalBgStrip                              ;; 00:1461 $c4 $72 $14
    ld   A, [wD6F9]                                    ;; 00:1464 $fa $f9 $d6
    and  A, $0c                                        ;; 00:1467 $e6 $0c
    call NZ, call_00_157a_LoadHorizontalBgStrip                              ;; 00:1469 $c4 $7a $15
    ld   HL, wD6F9                                     ;; 00:146c $21 $f9 $d6
    set  7, [HL]                                       ;; 00:146f $cb $fe
    ret                                                ;; 00:1471 $c9

call_00_1472_LoadVerticalBgStrip:
; load bg map tiles (vertical camera movement)
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:1472 $21 $ef $d6
    ld   A, [HL+]                                      ;; 00:1475 $2a
    ld   C, A                                          ;; 00:1476 $4f
    ld   A, [HL+]                                      ;; 00:1477 $2a
    ld   B, A                                          ;; 00:1478 $47 ; after this point BC is equal to [wD6EF_YPositionInMap]
    ld   HL, $90                                       ;; 00:1479 $21 $90 $00 ; HL = $90
    ld   A, [wD6F9]                                    ;; 00:147c $fa $f9 $d6
    and  A, $02                                        ;; 00:147f $e6 $02
    jr   NZ, .jr_00_1486                               ;; 00:1481 $20 $03
    ld   HL, $ffff                                       ;; 00:1483 $21 $ff $ff (FFFF is -1 basically)
.jr_00_1486:
    add  HL, BC                                        ;; 00:1486 $09 ; HL = HL - 1
    ld   C, L                                          ;; 00:1487 $4d ; bc = hl
    ld   B, H                                          ;; 00:1488 $44 ; bc = hl
    ld   HL, wD6ED_XPositionInMap                      ;; 00:1489 $21 $ed $d6
    ld   A, [HL+]                                      ;; 00:148c $2a
    ld   E, A                                          ;; 00:148d $5f
    ld   A, [HL+]                                      ;; 00:148e $2a
    ld   D, A                                          ;; 00:148f $57 ; after this point DE is equal to [wD6ED_XPositionInMap], BC is [wD6EF_YPositionInMap]
    ld   L, C                                          ;; 00:1490 $69
    ld   H, B                                          ;; 00:1491 $60 ; HL = [wD6EF_YPositionInMap]
    add  HL, HL                                        ;; 00:1492 $29
    add  HL, HL                                        ;; 00:1493 $29
    add  HL, HL                                        ;; 00:1494 $29 ; HL = 8 * HL
    ld   A, H                                          ;; 00:1495 $7c
    ld   [wD77A_PlayerYPositionBlock], A                                    ;; 00:1496 $ea $7a $d7 ; [wD77A_PlayerYPositionBlock] = the upper byte of the 8x value
    ld   L, E                                          ;; 00:1499 $6b
    ld   H, D                                          ;; 00:149a $62 ; HL = [wD6ED_XPositionInMap]
    add  HL, HL                                        ;; 00:149b $29
    add  HL, HL                                        ;; 00:149c $29
    add  HL, HL                                        ;; 00:149d $29 ; HL = 8 * HL
    ld   A, H                                          ;; 00:149e $7c
    ld   [wD779_RelatedToXPosition], A                                    ;; 00:149f $ea $79 $d7 ; [wD779_RelatedToXPosition] = the upper byte of the 8x value
    ld   A, C                                          ;; 00:14a2 $79
    and  A, $f8                                        ;; 00:14a3 $e6 $f8
    ld   L, A                                          ;; 00:14a5 $6f
    ld   H, $00                                        ;; 00:14a6 $26 $00 ; after this, hl = C(lower byte of y pos) & 0xf8
    add  HL, HL                                        ;; 00:14a8 $29
    add  HL, HL                                        ;; 00:14a9 $29 ; HL = 4 * HL
    ld   A, E                                          ;; 00:14aa $7b ; a = lower byte of x pos
    rrca                                               ;; 00:14ab $0f
    rrca                                               ;; 00:14ac $0f
    rrca                                               ;; 00:14ad $0f ; rotate to check some bits in there
    and  A, $1c                                        ;; 00:14ae $e6 $1c 
    or   A, L                                          ;; 00:14b0 $b5
    ld   L, A                                          ;; 00:14b1 $6f
    push HL                                            ;; 00:14b2 $e5
    ld   [wD6FA], A                                    ;; 00:14b3 $ea $fa $d6
    ld   A, H                                          ;; 00:14b6 $7c
    ld   [wD6FB], A                                    ;; 00:14b7 $ea $fb $d6
    ld   A, C                                          ;; 00:14ba $79
    rrca                                               ;; 00:14bb $0f
    and  A, $0c                                        ;; 00:14bc $e6 $0c
    add  A, $40                                        ;; 00:14be $c6 $40
    push AF                                            ;; 00:14c0 $f5
    ld   L, C                                          ;; 00:14c1 $69
    ld   H, B                                          ;; 00:14c2 $60
    add  HL, HL                                        ;; 00:14c3 $29
    add  HL, HL                                        ;; 00:14c4 $29
    add  HL, HL                                        ;; 00:14c5 $29
    ld   A, H                                          ;; 00:14c6 $7c
    ld   L, E                                          ;; 00:14c7 $6b
    ld   H, D                                          ;; 00:14c8 $62
    add  HL, HL                                        ;; 00:14c9 $29
    add  HL, HL                                        ;; 00:14ca $29
    add  HL, HL                                        ;; 00:14cb $29
    add  HL, HL                                        ;; 00:14cc $29
    ld   L, H                                          ;; 00:14cd $6c
    srl  A                                             ;; 00:14ce $cb $3f
    rr   L                                             ;; 00:14d0 $cb $1d
    add  A, $40                                        ;; 00:14d2 $c6 $40
    ld   H, A                                          ;; 00:14d4 $67
    push HL                                            ;; 00:14d5 $e5
    push HL                                            ;; 00:14d6 $e5
    ld   A, [wD6F5_CurrentMapBank]                     ;; 00:14d7 $fa $f5 $d6
    call call_00_1089_SwitchBank                       ;; 00:14da $cd $89 $10 switch to map file bank
    pop  HL                                            ;; 00:14dd $e1
    ld   DE, wD702                                     ;; 00:14de $11 $02 $d7
    ld   A, [HL+]                                      ;; 00:14e1 $2a
    ld   [DE], A                                       ;; 00:14e2 $12
    inc  DE                                            ;; 00:14e3 $13
    inc  DE                                            ;; 00:14e4 $13
    ld   A, [HL+]                                      ;; 00:14e5 $2a
    ld   [DE], A                                       ;; 00:14e6 $12
    inc  DE                                            ;; 00:14e7 $13
    inc  DE                                            ;; 00:14e8 $13
    ld   A, [HL+]                                      ;; 00:14e9 $2a
    ld   [DE], A                                       ;; 00:14ea $12
    inc  DE                                            ;; 00:14eb $13
    inc  DE                                            ;; 00:14ec $13
    ld   A, [HL+]                                      ;; 00:14ed $2a
    ld   [DE], A                                       ;; 00:14ee $12
    inc  DE                                            ;; 00:14ef $13
    inc  DE                                            ;; 00:14f0 $13
    ld   A, [HL+]                                      ;; 00:14f1 $2a
    ld   [DE], A                                       ;; 00:14f2 $12
    inc  DE                                            ;; 00:14f3 $13
    inc  DE                                            ;; 00:14f4 $13
    ld   A, [HL+]                                      ;; 00:14f5 $2a
    ld   [DE], A                                       ;; 00:14f6 $12
    call call_00_10a3_RestoreBank                                  ;; 00:14f7 $cd $a3 $10
    ld   A, [wD6F6_SecondaryTilesetOverrideBank]                                    ;; 00:14fa $fa $f6 $d6
    call call_00_1089_SwitchBank                       ;; 00:14fd $cd $89 $10 switch to map data file 34/35
    pop  HL                                            ;; 00:1500 $e1 hl = 44b4
    ld   DE, wD703                                     ;; 00:1501 $11 $03 $d7 de = d703
    ld   A, [HL+]                                      ;; 00:1504 $2a a = 0, hl++
    ld   [DE], A                                       ;; 00:1505 $12 [wD703] = a (which is 0)
    inc  DE                                            ;; 00:1506 $13
    inc  DE                                            ;; 00:1507 $13 de = D705
    ld   A, [HL+]                                      ;; 00:1508 $2a a = [hl (44b5)]  AND hl++ (44B6 now)
    ld   [DE], A                                       ;; 00:1509 $12 [wD705] = a (which is 0)
    inc  DE                                            ;; 00:150a $13
    inc  DE                                            ;; 00:150b $13 de = D707
    ld   A, [HL+]                                      ;; 00:150c $2a
    ld   [DE], A                                       ;; 00:150d $12
    inc  DE                                            ;; 00:150e $13
    inc  DE                                            ;; 00:150f $13 de = D709
    ld   A, [HL+]                                      ;; 00:1510 $2a
    ld   [DE], A                                       ;; 00:1511 $12
    inc  DE                                            ;; 00:1512 $13
    inc  DE                                            ;; 00:1513 $13 de = D70B
    ld   A, [HL+]                                      ;; 00:1514 $2a
    ld   [DE], A                                       ;; 00:1515 $12
    inc  DE                                            ;; 00:1516 $13
    inc  DE                                            ;; 00:1517 $13 de = D70D
    ld   A, [HL+]                                      ;; 00:1518 $2a
    ld   [DE], A                                       ;; 00:1519 $12
    call call_00_10a3_RestoreBank                                  ;; 00:151a $cd $a3 $10
    ld   HL, wD702                                     ;; 00:151d $21 $02 $d7
    call call_00_18a7                                  ;; 00:1520 $cd $a7 $18
    ld   A, [wD6F7_CurrentBlocksetAndCollisionBank]                                    ;; 00:1523 $fa $f7 $d6
    call call_00_1089_SwitchBank                       ;; 00:1526 $cd $89 $10
    pop  AF                                            ;; 00:1529 $f1
    pop  HL                                            ;; 00:152a $e1
    ld   B, A                                          ;; 00:152b $47
    ld   A, H                                          ;; 00:152c $7c
    add  A, $c0                                        ;; 00:152d $c6 $c0
    ld   H, A                                          ;; 00:152f $67
    ld   DE, wD702                                     ;; 00:1530 $11 $02 $d7
    ld   A, $06                                        ;; 00:1533 $3e $06
.jr_00_1535:
    push AF                                            ;; 00:1535 $f5
    ld   A, [DE]                                       ;; 00:1536 $1a
    ld   C, A                                          ;; 00:1537 $4f
    inc  DE                                            ;; 00:1538 $13
    res  4, B                                          ;; 00:1539 $cb $a0
    ld   A, [DE]                                       ;; 00:153b $1a ; loads 3435 data
    and  A, A                                          ;; 00:153c $a7
    jr   Z, .jr_00_1541                                ;; 00:153d $28 $02
    set  4, B                                          ;; 00:153f $cb $e0
.jr_00_1541:
    inc  DE                                            ;; 00:1541 $13
    ld   A, [BC]                                       ;; 00:1542 $0a
    ld   [HL], A                                       ;; 00:1543 $77
    set  3, H                                          ;; 00:1544 $cb $dc
    set  5, B                                          ;; 00:1546 $cb $e8
    ld   A, [BC]                                       ;; 00:1548 $0a
    ld   [HL+], A                                      ;; 00:1549 $22
    inc  B                                             ;; 00:154a $04
    ld   A, [BC]                                       ;; 00:154b $0a
    ld   [HL], A                                       ;; 00:154c $77
    res  3, H                                          ;; 00:154d $cb $9c
    res  5, B                                          ;; 00:154f $cb $a8
    ld   A, [BC]                                       ;; 00:1551 $0a
    ld   [HL+], A                                      ;; 00:1552 $22
    inc  B                                             ;; 00:1553 $04
    ld   A, [BC]                                       ;; 00:1554 $0a
    ld   [HL], A                                       ;; 00:1555 $77
    set  3, H                                          ;; 00:1556 $cb $dc
    set  5, B                                          ;; 00:1558 $cb $e8
    ld   A, [BC]                                       ;; 00:155a $0a
    ld   [HL+], A                                      ;; 00:155b $22
    inc  B                                             ;; 00:155c $04
    ld   A, [BC]                                       ;; 00:155d $0a
    ld   [HL], A                                       ;; 00:155e $77
    res  3, H                                          ;; 00:155f $cb $9c
    res  5, B                                          ;; 00:1561 $cb $a8
    ld   A, [BC]                                       ;; 00:1563 $0a
    ld   [HL+], A                                      ;; 00:1564 $22
    ld   A, L                                          ;; 00:1565 $7d
    and  A, $1f                                        ;; 00:1566 $e6 $1f
    jr   NZ, .jr_00_156f                               ;; 00:1568 $20 $05
    dec  HL                                            ;; 00:156a $2b
    ld   A, L                                          ;; 00:156b $7d
    and  A, $e0                                        ;; 00:156c $e6 $e0
    ld   L, A                                          ;; 00:156e $6f
.jr_00_156f:
    dec  B                                             ;; 00:156f $05
    dec  B                                             ;; 00:1570 $05
    dec  B                                             ;; 00:1571 $05
    pop  AF                                            ;; 00:1572 $f1
    dec  A                                             ;; 00:1573 $3d
    jr   NZ, .jr_00_1535                               ;; 00:1574 $20 $bf
    call call_00_10a3_RestoreBank                                  ;; 00:1576 $cd $a3 $10
    ret                                                ;; 00:1579 $c9

call_00_157a_LoadHorizontalBgStrip:
; load bg map tiles (horizontal camera movement)
    ld   HL, wD6ED_XPositionInMap                                     ;; 00:157a $21 $ed $d6
    ld   A, [HL+]                                      ;; 00:157d $2a
    ld   E, A                                          ;; 00:157e $5f
    ld   A, [HL+]                                      ;; 00:157f $2a
    ld   D, A                                          ;; 00:1580 $57
    ld   HL, $a0                                       ;; 00:1581 $21 $a0 $00
    ld   A, [wD6F9]                                    ;; 00:1584 $fa $f9 $d6
    and  A, $08                                        ;; 00:1587 $e6 $08
    jr   NZ, .jr_00_158e                               ;; 00:1589 $20 $03
    ld   HL, rIE                                       ;; 00:158b $21 $ff $ff
.jr_00_158e:
    add  HL, DE                                        ;; 00:158e $19
    ld   E, L                                          ;; 00:158f $5d
    ld   D, H                                          ;; 00:1590 $54
    ld   HL, wD6EF_YPositionInMap                                     ;; 00:1591 $21 $ef $d6
    ld   A, [HL+]                                      ;; 00:1594 $2a
    ld   C, A                                          ;; 00:1595 $4f
    ld   A, [HL+]                                      ;; 00:1596 $2a
    ld   B, A                                          ;; 00:1597 $47
    ld   L, C                                          ;; 00:1598 $69
    ld   H, B                                          ;; 00:1599 $60
    add  HL, HL                                        ;; 00:159a $29
    add  HL, HL                                        ;; 00:159b $29
    add  HL, HL                                        ;; 00:159c $29
    ld   A, H                                          ;; 00:159d $7c
    ld   [wD77A_PlayerYPositionBlock], A                                    ;; 00:159e $ea $7a $d7
    ld   L, E                                          ;; 00:15a1 $6b
    ld   H, D                                          ;; 00:15a2 $62
    add  HL, HL                                        ;; 00:15a3 $29
    add  HL, HL                                        ;; 00:15a4 $29
    add  HL, HL                                        ;; 00:15a5 $29
    ld   A, H                                          ;; 00:15a6 $7c
    ld   [wD779_RelatedToXPosition], A                                    ;; 00:15a7 $ea $79 $d7
    ld   A, C                                          ;; 00:15aa $79
    and  A, $e0                                        ;; 00:15ab $e6 $e0
    ld   L, A                                          ;; 00:15ad $6f
    ld   H, $00                                        ;; 00:15ae $26 $00
    add  HL, HL                                        ;; 00:15b0 $29
    add  HL, HL                                        ;; 00:15b1 $29
    ld   A, E                                          ;; 00:15b2 $7b
    rrca                                               ;; 00:15b3 $0f
    rrca                                               ;; 00:15b4 $0f
    rrca                                               ;; 00:15b5 $0f
    and  A, $1f                                        ;; 00:15b6 $e6 $1f
    or   A, L                                          ;; 00:15b8 $b5
    ld   L, A                                          ;; 00:15b9 $6f
    push HL                                            ;; 00:15ba $e5
    ld   [wD6FC], A                                    ;; 00:15bb $ea $fc $d6
    ld   A, H                                          ;; 00:15be $7c
    ld   [wD6FD], A                                    ;; 00:15bf $ea $fd $d6
    ld   A, E                                          ;; 00:15c2 $7b
    rrca                                               ;; 00:15c3 $0f
    rrca                                               ;; 00:15c4 $0f
    rrca                                               ;; 00:15c5 $0f
    and  A, $03                                        ;; 00:15c6 $e6 $03
    add  A, $40                                        ;; 00:15c8 $c6 $40
    push AF                                            ;; 00:15ca $f5
    ld   L, C                                          ;; 00:15cb $69
    ld   H, B                                          ;; 00:15cc $60
    add  HL, HL                                        ;; 00:15cd $29
    add  HL, HL                                        ;; 00:15ce $29
    add  HL, HL                                        ;; 00:15cf $29
    ld   A, H                                          ;; 00:15d0 $7c
    ld   L, E                                          ;; 00:15d1 $6b
    ld   H, D                                          ;; 00:15d2 $62
    add  HL, HL                                        ;; 00:15d3 $29
    add  HL, HL                                        ;; 00:15d4 $29
    add  HL, HL                                        ;; 00:15d5 $29
    add  HL, HL                                        ;; 00:15d6 $29
    ld   L, H                                          ;; 00:15d7 $6c
    srl  A                                             ;; 00:15d8 $cb $3f
    rr   L                                             ;; 00:15da $cb $1d
    add  A, $40                                        ;; 00:15dc $c6 $40
    ld   H, A                                          ;; 00:15de $67
    push HL                                            ;; 00:15df $e5
    push HL                                            ;; 00:15e0 $e5
    ld   A, [wD6F5_CurrentMapBank]                                    ;; 00:15e1 $fa $f5 $d6
    call call_00_1089_SwitchBank                                  ;; 00:15e4 $cd $89 $10
    pop  HL                                            ;; 00:15e7 $e1
    ld   DE, wD70E                                     ;; 00:15e8 $11 $0e $d7
    ld   BC, $80                                       ;; 00:15eb $01 $80 $00
    ld   A, [HL]                                       ;; 00:15ee $7e
    ld   [DE], A                                       ;; 00:15ef $12
    add  HL, BC                                        ;; 00:15f0 $09
    inc  DE                                            ;; 00:15f1 $13
    inc  DE                                            ;; 00:15f2 $13
    ld   A, [HL]                                       ;; 00:15f3 $7e
    ld   [DE], A                                       ;; 00:15f4 $12
    add  HL, BC                                        ;; 00:15f5 $09
    inc  DE                                            ;; 00:15f6 $13
    inc  DE                                            ;; 00:15f7 $13
    ld   A, [HL]                                       ;; 00:15f8 $7e
    ld   [DE], A                                       ;; 00:15f9 $12
    add  HL, BC                                        ;; 00:15fa $09
    inc  DE                                            ;; 00:15fb $13
    inc  DE                                            ;; 00:15fc $13
    ld   A, [HL]                                       ;; 00:15fd $7e
    ld   [DE], A                                       ;; 00:15fe $12
    add  HL, BC                                        ;; 00:15ff $09
    inc  DE                                            ;; 00:1600 $13
    inc  DE                                            ;; 00:1601 $13
    ld   A, [HL]                                       ;; 00:1602 $7e
    ld   [DE], A                                       ;; 00:1603 $12
    add  HL, BC                                        ;; 00:1604 $09
    inc  DE                                            ;; 00:1605 $13
    inc  DE                                            ;; 00:1606 $13
    ld   A, [HL]                                       ;; 00:1607 $7e
    ld   [DE], A                                       ;; 00:1608 $12
    call call_00_10a3_RestoreBank                                  ;; 00:1609 $cd $a3 $10
    ld   A, [wD6F6_SecondaryTilesetOverrideBank]                                    ;; 00:160c $fa $f6 $d6
    call call_00_1089_SwitchBank                                  ;; 00:160f $cd $89 $10
    pop  HL                                            ;; 00:1612 $e1
    ld   DE, wD70F                                     ;; 00:1613 $11 $0f $d7
    ld   BC, $80                                       ;; 00:1616 $01 $80 $00
    ld   A, [HL]                                       ;; 00:1619 $7e
    ld   [DE], A                                       ;; 00:161a $12
    add  HL, BC                                        ;; 00:161b $09
    inc  DE                                            ;; 00:161c $13
    inc  DE                                            ;; 00:161d $13
    ld   A, [HL]                                       ;; 00:161e $7e
    ld   [DE], A                                       ;; 00:161f $12
    add  HL, BC                                        ;; 00:1620 $09
    inc  DE                                            ;; 00:1621 $13
    inc  DE                                            ;; 00:1622 $13
    ld   A, [HL]                                       ;; 00:1623 $7e
    ld   [DE], A                                       ;; 00:1624 $12
    add  HL, BC                                        ;; 00:1625 $09
    inc  DE                                            ;; 00:1626 $13
    inc  DE                                            ;; 00:1627 $13
    ld   A, [HL]                                       ;; 00:1628 $7e
    ld   [DE], A                                       ;; 00:1629 $12
    add  HL, BC                                        ;; 00:162a $09
    inc  DE                                            ;; 00:162b $13
    inc  DE                                            ;; 00:162c $13
    ld   A, [HL]                                       ;; 00:162d $7e
    ld   [DE], A                                       ;; 00:162e $12
    add  HL, BC                                        ;; 00:162f $09
    inc  DE                                            ;; 00:1630 $13
    inc  DE                                            ;; 00:1631 $13
    ld   A, [HL]                                       ;; 00:1632 $7e
    ld   [DE], A                                       ;; 00:1633 $12
    call call_00_10a3_RestoreBank                                  ;; 00:1634 $cd $a3 $10
    ld   HL, wD70E                                     ;; 00:1637 $21 $0e $d7
    call call_00_18e4                                  ;; 00:163a $cd $e4 $18
    ld   A, [wD6F7_CurrentBlocksetAndCollisionBank]                                    ;; 00:163d $fa $f7 $d6
    call call_00_1089_SwitchBank                                  ;; 00:1640 $cd $89 $10
    pop  AF                                            ;; 00:1643 $f1
    pop  HL                                            ;; 00:1644 $e1
    ld   B, A                                          ;; 00:1645 $47
    ld   A, H                                          ;; 00:1646 $7c
    add  A, $c0                                        ;; 00:1647 $c6 $c0
    ld   H, A                                          ;; 00:1649 $67
    ld   DE, wD70E                                     ;; 00:164a $11 $0e $d7
    ld   A, $06                                        ;; 00:164d $3e $06
.jr_00_164f:
    push AF                                            ;; 00:164f $f5
    ld   A, [DE]                                       ;; 00:1650 $1a
    ld   C, A                                          ;; 00:1651 $4f
    inc  DE                                            ;; 00:1652 $13
    res  4, B                                          ;; 00:1653 $cb $a0
    ld   A, [DE]                                       ;; 00:1655 $1a
    and  A, A                                          ;; 00:1656 $a7
    jr   Z, .jr_00_165b                                ;; 00:1657 $28 $02
    set  4, B                                          ;; 00:1659 $cb $e0
.jr_00_165b:
    inc  DE                                            ;; 00:165b $13
    push DE                                            ;; 00:165c $d5
    ld   DE, $20                                       ;; 00:165d $11 $20 $00
    ld   A, [BC]                                       ;; 00:1660 $0a
    ld   [HL], A                                       ;; 00:1661 $77
    set  3, H                                          ;; 00:1662 $cb $dc
    set  5, B                                          ;; 00:1664 $cb $e8
    ld   A, [BC]                                       ;; 00:1666 $0a
    ld   [HL], A                                       ;; 00:1667 $77
    add  HL, DE                                        ;; 00:1668 $19
    ld   A, B                                          ;; 00:1669 $78
    add  A, $04                                        ;; 00:166a $c6 $04
    ld   B, A                                          ;; 00:166c $47
    ld   A, [BC]                                       ;; 00:166d $0a
    ld   [HL], A                                       ;; 00:166e $77
    res  3, H                                          ;; 00:166f $cb $9c
    res  5, B                                          ;; 00:1671 $cb $a8
    ld   A, [BC]                                       ;; 00:1673 $0a
    ld   [HL], A                                       ;; 00:1674 $77
    add  HL, DE                                        ;; 00:1675 $19
    ld   A, B                                          ;; 00:1676 $78
    add  A, $04                                        ;; 00:1677 $c6 $04
    ld   B, A                                          ;; 00:1679 $47
    ld   A, [BC]                                       ;; 00:167a $0a
    ld   [HL], A                                       ;; 00:167b $77
    set  3, H                                          ;; 00:167c $cb $dc
    set  5, B                                          ;; 00:167e $cb $e8
    ld   A, [BC]                                       ;; 00:1680 $0a
    ld   [HL], A                                       ;; 00:1681 $77
    add  HL, DE                                        ;; 00:1682 $19
    ld   A, B                                          ;; 00:1683 $78
    add  A, $04                                        ;; 00:1684 $c6 $04
    ld   B, A                                          ;; 00:1686 $47
    ld   A, [BC]                                       ;; 00:1687 $0a
    ld   [HL], A                                       ;; 00:1688 $77
    res  3, H                                          ;; 00:1689 $cb $9c
    res  5, B                                          ;; 00:168b $cb $a8
    ld   A, [BC]                                       ;; 00:168d $0a
    ld   [HL], A                                       ;; 00:168e $77
    add  HL, DE                                        ;; 00:168f $19
    res  2, H                                          ;; 00:1690 $cb $94
    pop  DE                                            ;; 00:1692 $d1
    ld   A, B                                          ;; 00:1693 $78
    sub  A, $0c                                        ;; 00:1694 $d6 $0c
    ld   B, A                                          ;; 00:1696 $47
    pop  AF                                            ;; 00:1697 $f1
    dec  A                                             ;; 00:1698 $3d
    jr   NZ, .jr_00_164f                               ;; 00:1699 $20 $b4
    call call_00_10a3_RestoreBank                                  ;; 00:169b $cd $a3 $10
    ret                                                ;; 00:169e $c9

call_00_169f:
    ld   A, [wD6F7_CurrentBlocksetAndCollisionBank]                                    ;; 00:169f $fa $f7 $d6
    call call_00_1089_SwitchBank                                  ;; 00:16a2 $cd $89 $10
    ld   HL, wD780                                     ;; 00:16a5 $21 $80 $d7
    ld   E, [HL]                                       ;; 00:16a8 $5e
    inc  HL                                            ;; 00:16a9 $23
    ld   D, [HL]                                       ;; 00:16aa $56
    ld   HL, wD77E                                     ;; 00:16ab $21 $7e $d7
    ld   A, [HL+]                                      ;; 00:16ae $2a
    ld   H, [HL]                                       ;; 00:16af $66
    ld   L, A                                          ;; 00:16b0 $6f
    ld   A, [wD785]                                    ;; 00:16b1 $fa $85 $d7
.jp_00_16b4:
    push AF                                            ;; 00:16b4 $f5
    push HL                                            ;; 00:16b5 $e5
    ld   A, [wD784]                                    ;; 00:16b6 $fa $84 $d7
.jp_00_16b9:
    push AF                                            ;; 00:16b9 $f5
    push DE                                            ;; 00:16ba $d5
    push HL                                            ;; 00:16bb $e5
    ld   A, H                                          ;; 00:16bc $7c
    and  A, $03                                        ;; 00:16bd $e6 $03
    add  A, $c0                                        ;; 00:16bf $c6 $c0
    ld   H, A                                          ;; 00:16c1 $67
    ld   A, [DE]                                       ;; 00:16c2 $1a
    ld   C, A                                          ;; 00:16c3 $4f
    ld   B, $40                                        ;; 00:16c4 $06 $40
    inc  DE                                            ;; 00:16c6 $13
    ld   A, [DE]                                       ;; 00:16c7 $1a
    and  A, A                                          ;; 00:16c8 $a7
    jr   Z, .jr_00_16cd                                ;; 00:16c9 $28 $02
    set  4, B                                          ;; 00:16cb $cb $e0
.jr_00_16cd:
    ld   DE, $20                                       ;; 00:16cd $11 $20 $00
    ld   A, [BC]                                       ;; 00:16d0 $0a
    ld   [HL+], A                                      ;; 00:16d1 $22
    inc  B                                             ;; 00:16d2 $04
    ld   A, [BC]                                       ;; 00:16d3 $0a
    ld   [HL+], A                                      ;; 00:16d4 $22
    inc  B                                             ;; 00:16d5 $04
    ld   A, [BC]                                       ;; 00:16d6 $0a
    ld   [HL+], A                                      ;; 00:16d7 $22
    inc  B                                             ;; 00:16d8 $04
    ld   A, [BC]                                       ;; 00:16d9 $0a
    ld   [HL], A                                       ;; 00:16da $77
    set  3, H                                          ;; 00:16db $cb $dc
    set  5, B                                          ;; 00:16dd $cb $e8
    ld   A, [BC]                                       ;; 00:16df $0a
    ld   [HL-], A                                      ;; 00:16e0 $32
    dec  B                                             ;; 00:16e1 $05
    ld   A, [BC]                                       ;; 00:16e2 $0a
    ld   [HL-], A                                      ;; 00:16e3 $32
    dec  B                                             ;; 00:16e4 $05
    ld   A, [BC]                                       ;; 00:16e5 $0a
    ld   [HL-], A                                      ;; 00:16e6 $32
    dec  B                                             ;; 00:16e7 $05
    ld   A, [BC]                                       ;; 00:16e8 $0a
    ld   [HL], A                                       ;; 00:16e9 $77
    res  3, H                                          ;; 00:16ea $cb $9c
    res  5, B                                          ;; 00:16ec $cb $a8
    ld   A, B                                          ;; 00:16ee $78
    add  A, $04                                        ;; 00:16ef $c6 $04
    ld   B, A                                          ;; 00:16f1 $47
    add  HL, DE                                        ;; 00:16f2 $19
    ld   A, [BC]                                       ;; 00:16f3 $0a
    ld   [HL+], A                                      ;; 00:16f4 $22
    inc  B                                             ;; 00:16f5 $04
    ld   A, [BC]                                       ;; 00:16f6 $0a
    ld   [HL+], A                                      ;; 00:16f7 $22
    inc  B                                             ;; 00:16f8 $04
    ld   A, [BC]                                       ;; 00:16f9 $0a
    ld   [HL+], A                                      ;; 00:16fa $22
    inc  B                                             ;; 00:16fb $04
    ld   A, [BC]                                       ;; 00:16fc $0a
    ld   [HL], A                                       ;; 00:16fd $77
    set  3, H                                          ;; 00:16fe $cb $dc
    set  5, B                                          ;; 00:1700 $cb $e8
    ld   A, [BC]                                       ;; 00:1702 $0a
    ld   [HL-], A                                      ;; 00:1703 $32
    dec  B                                             ;; 00:1704 $05
    ld   A, [BC]                                       ;; 00:1705 $0a
    ld   [HL-], A                                      ;; 00:1706 $32
    dec  B                                             ;; 00:1707 $05
    ld   A, [BC]                                       ;; 00:1708 $0a
    ld   [HL-], A                                      ;; 00:1709 $32
    dec  B                                             ;; 00:170a $05
    ld   A, [BC]                                       ;; 00:170b $0a
    ld   [HL], A                                       ;; 00:170c $77
    res  3, H                                          ;; 00:170d $cb $9c
    res  5, B                                          ;; 00:170f $cb $a8
    ld   A, B                                          ;; 00:1711 $78
    add  A, $04                                        ;; 00:1712 $c6 $04
    ld   B, A                                          ;; 00:1714 $47
    add  HL, DE                                        ;; 00:1715 $19
    ld   A, [BC]                                       ;; 00:1716 $0a
    ld   [HL+], A                                      ;; 00:1717 $22
    inc  B                                             ;; 00:1718 $04
    ld   A, [BC]                                       ;; 00:1719 $0a
    ld   [HL+], A                                      ;; 00:171a $22
    inc  B                                             ;; 00:171b $04
    ld   A, [BC]                                       ;; 00:171c $0a
    ld   [HL+], A                                      ;; 00:171d $22
    inc  B                                             ;; 00:171e $04
    ld   A, [BC]                                       ;; 00:171f $0a
    ld   [HL], A                                       ;; 00:1720 $77
    set  3, H                                          ;; 00:1721 $cb $dc
    set  5, B                                          ;; 00:1723 $cb $e8
    ld   A, [BC]                                       ;; 00:1725 $0a
    ld   [HL-], A                                      ;; 00:1726 $32
    dec  B                                             ;; 00:1727 $05
    ld   A, [BC]                                       ;; 00:1728 $0a
    ld   [HL-], A                                      ;; 00:1729 $32
    dec  B                                             ;; 00:172a $05
    ld   A, [BC]                                       ;; 00:172b $0a
    ld   [HL-], A                                      ;; 00:172c $32
    dec  B                                             ;; 00:172d $05
    ld   A, [BC]                                       ;; 00:172e $0a
    ld   [HL], A                                       ;; 00:172f $77
    res  3, H                                          ;; 00:1730 $cb $9c
    res  5, B                                          ;; 00:1732 $cb $a8
    ld   A, B                                          ;; 00:1734 $78
    add  A, $04                                        ;; 00:1735 $c6 $04
    ld   B, A                                          ;; 00:1737 $47
    add  HL, DE                                        ;; 00:1738 $19
    ld   A, [BC]                                       ;; 00:1739 $0a
    ld   [HL+], A                                      ;; 00:173a $22
    inc  B                                             ;; 00:173b $04
    ld   A, [BC]                                       ;; 00:173c $0a
    ld   [HL+], A                                      ;; 00:173d $22
    inc  B                                             ;; 00:173e $04
    ld   A, [BC]                                       ;; 00:173f $0a
    ld   [HL+], A                                      ;; 00:1740 $22
    inc  B                                             ;; 00:1741 $04
    ld   A, [BC]                                       ;; 00:1742 $0a
    ld   [HL], A                                       ;; 00:1743 $77
    set  3, H                                          ;; 00:1744 $cb $dc
    set  5, B                                          ;; 00:1746 $cb $e8
    ld   A, [BC]                                       ;; 00:1748 $0a
    ld   [HL-], A                                      ;; 00:1749 $32
    dec  B                                             ;; 00:174a $05
    ld   A, [BC]                                       ;; 00:174b $0a
    ld   [HL-], A                                      ;; 00:174c $32
    dec  B                                             ;; 00:174d $05
    ld   A, [BC]                                       ;; 00:174e $0a
    ld   [HL-], A                                      ;; 00:174f $32
    dec  B                                             ;; 00:1750 $05
    ld   A, [BC]                                       ;; 00:1751 $0a
    ld   [HL], A                                       ;; 00:1752 $77
    pop  HL                                            ;; 00:1753 $e1
    ld   A, L                                          ;; 00:1754 $7d
    and  A, $e0                                        ;; 00:1755 $e6 $e0
    ld   C, A                                          ;; 00:1757 $4f
    ld   A, L                                          ;; 00:1758 $7d
    add  A, $04                                        ;; 00:1759 $c6 $04
    and  A, $1f                                        ;; 00:175b $e6 $1f
    or   A, C                                          ;; 00:175d $b1
    ld   L, A                                          ;; 00:175e $6f
    pop  DE                                            ;; 00:175f $d1
    inc  DE                                            ;; 00:1760 $13
    inc  DE                                            ;; 00:1761 $13
    pop  AF                                            ;; 00:1762 $f1
    dec  A                                             ;; 00:1763 $3d
    jp   NZ, .jp_00_16b9                               ;; 00:1764 $c2 $b9 $16
    pop  HL                                            ;; 00:1767 $e1
    ld   BC, $80                                       ;; 00:1768 $01 $80 $00
    add  HL, BC                                        ;; 00:176b $09
    pop  AF                                            ;; 00:176c $f1
    dec  A                                             ;; 00:176d $3d
    jp   NZ, .jp_00_16b4                               ;; 00:176e $c2 $b4 $16
    ld   HL, wD77B                                     ;; 00:1771 $21 $7b $d7
    set  0, [HL]                                       ;; 00:1774 $cb $c6
    jp   call_00_10a3_RestoreBank                                  ;; 00:1776 $c3 $a3 $10

call_00_1779:
    ld   A, [wD59E]                                    ;; 00:1779 $fa $9e $d5
    and  A, A                                          ;; 00:177c $a7
    jp   Z, .jp_00_182a                                ;; 00:177d $ca $2a $18
    ld   A, $01                                        ;; 00:1780 $3e $01
    ldh  [rVBK], A                                     ;; 00:1782 $e0 $4f
    ld   HL, wD77E                                     ;; 00:1784 $21 $7e $d7
    ld   A, [HL+]                                      ;; 00:1787 $2a
    ld   H, [HL]                                       ;; 00:1788 $66
    ld   L, A                                          ;; 00:1789 $6f
    ld   B, $cf                                        ;; 00:178a $06 $cf
    ld   A, [wD785]                                    ;; 00:178c $fa $85 $d7
.jp_00_178f:
    push AF                                            ;; 00:178f $f5
    push HL                                            ;; 00:1790 $e5
    ld   A, [wD784]                                    ;; 00:1791 $fa $84 $d7
.jp_00_1794:
    push AF                                            ;; 00:1794 $f5
    push HL                                            ;; 00:1795 $e5
    ld   E, L                                          ;; 00:1796 $5d
    ld   A, H                                          ;; 00:1797 $7c
    and  A, $03                                        ;; 00:1798 $e6 $03
    add  A, $98                                        ;; 00:179a $c6 $98
    ld   D, A                                          ;; 00:179c $57
    and  A, $03                                        ;; 00:179d $e6 $03
    add  A, $c0                                        ;; 00:179f $c6 $c0
    ld   H, A                                          ;; 00:17a1 $67
    ld   C, [HL]                                       ;; 00:17a2 $4e
    ld   A, [BC]                                       ;; 00:17a3 $0a
    ld   [DE], A                                       ;; 00:17a4 $12
    inc  L                                             ;; 00:17a5 $2c
    inc  E                                             ;; 00:17a6 $1c
    ld   C, [HL]                                       ;; 00:17a7 $4e
    ld   A, [BC]                                       ;; 00:17a8 $0a
    ld   [DE], A                                       ;; 00:17a9 $12
    inc  L                                             ;; 00:17aa $2c
    inc  E                                             ;; 00:17ab $1c
    ld   C, [HL]                                       ;; 00:17ac $4e
    ld   A, [BC]                                       ;; 00:17ad $0a
    ld   [DE], A                                       ;; 00:17ae $12
    inc  L                                             ;; 00:17af $2c
    inc  E                                             ;; 00:17b0 $1c
    ld   C, [HL]                                       ;; 00:17b1 $4e
    ld   A, [BC]                                       ;; 00:17b2 $0a
    ld   [DE], A                                       ;; 00:17b3 $12
    ld   DE, $1d                                       ;; 00:17b4 $11 $1d $00
    add  HL, DE                                        ;; 00:17b7 $19
    ld   E, L                                          ;; 00:17b8 $5d
    ld   A, H                                          ;; 00:17b9 $7c
    and  A, $03                                        ;; 00:17ba $e6 $03
    add  A, $98                                        ;; 00:17bc $c6 $98
    ld   D, A                                          ;; 00:17be $57
    ld   C, [HL]                                       ;; 00:17bf $4e
    ld   A, [BC]                                       ;; 00:17c0 $0a
    ld   [DE], A                                       ;; 00:17c1 $12
    inc  L                                             ;; 00:17c2 $2c
    inc  E                                             ;; 00:17c3 $1c
    ld   C, [HL]                                       ;; 00:17c4 $4e
    ld   A, [BC]                                       ;; 00:17c5 $0a
    ld   [DE], A                                       ;; 00:17c6 $12
    inc  L                                             ;; 00:17c7 $2c
    inc  E                                             ;; 00:17c8 $1c
    ld   C, [HL]                                       ;; 00:17c9 $4e
    ld   A, [BC]                                       ;; 00:17ca $0a
    ld   [DE], A                                       ;; 00:17cb $12
    inc  L                                             ;; 00:17cc $2c
    inc  E                                             ;; 00:17cd $1c
    ld   C, [HL]                                       ;; 00:17ce $4e
    ld   A, [BC]                                       ;; 00:17cf $0a
    ld   [DE], A                                       ;; 00:17d0 $12
    ld   DE, $1d                                       ;; 00:17d1 $11 $1d $00
    add  HL, DE                                        ;; 00:17d4 $19
    ld   E, L                                          ;; 00:17d5 $5d
    ld   A, H                                          ;; 00:17d6 $7c
    and  A, $03                                        ;; 00:17d7 $e6 $03
    add  A, $98                                        ;; 00:17d9 $c6 $98
    ld   D, A                                          ;; 00:17db $57
    ld   C, [HL]                                       ;; 00:17dc $4e
    ld   A, [BC]                                       ;; 00:17dd $0a
    ld   [DE], A                                       ;; 00:17de $12
    inc  L                                             ;; 00:17df $2c
    inc  E                                             ;; 00:17e0 $1c
    ld   C, [HL]                                       ;; 00:17e1 $4e
    ld   A, [BC]                                       ;; 00:17e2 $0a
    ld   [DE], A                                       ;; 00:17e3 $12
    inc  L                                             ;; 00:17e4 $2c
    inc  E                                             ;; 00:17e5 $1c
    ld   C, [HL]                                       ;; 00:17e6 $4e
    ld   A, [BC]                                       ;; 00:17e7 $0a
    ld   [DE], A                                       ;; 00:17e8 $12
    inc  L                                             ;; 00:17e9 $2c
    inc  E                                             ;; 00:17ea $1c
    ld   C, [HL]                                       ;; 00:17eb $4e
    ld   A, [BC]                                       ;; 00:17ec $0a
    ld   [DE], A                                       ;; 00:17ed $12
    ld   DE, $1d                                       ;; 00:17ee $11 $1d $00
    add  HL, DE                                        ;; 00:17f1 $19
    ld   E, L                                          ;; 00:17f2 $5d
    ld   A, H                                          ;; 00:17f3 $7c
    and  A, $03                                        ;; 00:17f4 $e6 $03
    add  A, $98                                        ;; 00:17f6 $c6 $98
    ld   D, A                                          ;; 00:17f8 $57
    ld   C, [HL]                                       ;; 00:17f9 $4e
    ld   A, [BC]                                       ;; 00:17fa $0a
    ld   [DE], A                                       ;; 00:17fb $12
    inc  L                                             ;; 00:17fc $2c
    inc  E                                             ;; 00:17fd $1c
    ld   C, [HL]                                       ;; 00:17fe $4e
    ld   A, [BC]                                       ;; 00:17ff $0a
    ld   [DE], A                                       ;; 00:1800 $12
    inc  L                                             ;; 00:1801 $2c
    inc  E                                             ;; 00:1802 $1c
    ld   C, [HL]                                       ;; 00:1803 $4e
    ld   A, [BC]                                       ;; 00:1804 $0a
    ld   [DE], A                                       ;; 00:1805 $12
    inc  L                                             ;; 00:1806 $2c
    inc  E                                             ;; 00:1807 $1c
    ld   C, [HL]                                       ;; 00:1808 $4e
    ld   A, [BC]                                       ;; 00:1809 $0a
    ld   [DE], A                                       ;; 00:180a $12
    pop  HL                                            ;; 00:180b $e1
    ld   A, L                                          ;; 00:180c $7d
    and  A, $e0                                        ;; 00:180d $e6 $e0
    ld   E, A                                          ;; 00:180f $5f
    ld   A, L                                          ;; 00:1810 $7d
    add  A, $04                                        ;; 00:1811 $c6 $04
    and  A, $1f                                        ;; 00:1813 $e6 $1f
    or   A, E                                          ;; 00:1815 $b3
    ld   L, A                                          ;; 00:1816 $6f
    pop  AF                                            ;; 00:1817 $f1
    dec  A                                             ;; 00:1818 $3d
    jp   NZ, .jp_00_1794                               ;; 00:1819 $c2 $94 $17
    pop  HL                                            ;; 00:181c $e1
    ld   DE, $80                                       ;; 00:181d $11 $80 $00
    add  HL, DE                                        ;; 00:1820 $19
    pop  AF                                            ;; 00:1821 $f1
    dec  A                                             ;; 00:1822 $3d
    jp   NZ, .jp_00_178f                               ;; 00:1823 $c2 $8f $17
    ld   A, $00                                        ;; 00:1826 $3e $00
    ldh  [rVBK], A                                     ;; 00:1828 $e0 $4f
.jp_00_182a:
    ld   HL, wD77E                                     ;; 00:182a $21 $7e $d7
    ld   A, [HL+]                                      ;; 00:182d $2a
    ld   H, [HL]                                       ;; 00:182e $66
    ld   L, A                                          ;; 00:182f $6f
    ld   BC, $1d                                       ;; 00:1830 $01 $1d $00
    ld   A, [wD785]                                    ;; 00:1833 $fa $85 $d7
.jr_00_1836:
    push AF                                            ;; 00:1836 $f5
    push HL                                            ;; 00:1837 $e5
    ld   A, [wD784]                                    ;; 00:1838 $fa $84 $d7
.jr_00_183b:
    push AF                                            ;; 00:183b $f5
    push HL                                            ;; 00:183c $e5
    ld   E, L                                          ;; 00:183d $5d
    ld   A, H                                          ;; 00:183e $7c
    and  A, $03                                        ;; 00:183f $e6 $03
    add  A, $98                                        ;; 00:1841 $c6 $98
    ld   D, A                                          ;; 00:1843 $57
    and  A, $03                                        ;; 00:1844 $e6 $03
    add  A, $c0                                        ;; 00:1846 $c6 $c0
    ld   H, A                                          ;; 00:1848 $67
    ld   A, [HL+]                                      ;; 00:1849 $2a
    ld   [DE], A                                       ;; 00:184a $12
    inc  E                                             ;; 00:184b $1c
    ld   A, [HL+]                                      ;; 00:184c $2a
    ld   [DE], A                                       ;; 00:184d $12
    inc  E                                             ;; 00:184e $1c
    ld   A, [HL+]                                      ;; 00:184f $2a
    ld   [DE], A                                       ;; 00:1850 $12
    inc  E                                             ;; 00:1851 $1c
    ld   A, [HL]                                       ;; 00:1852 $7e
    ld   [DE], A                                       ;; 00:1853 $12
    add  HL, BC                                        ;; 00:1854 $09
    ld   E, L                                          ;; 00:1855 $5d
    ld   A, H                                          ;; 00:1856 $7c
    and  A, $03                                        ;; 00:1857 $e6 $03
    add  A, $98                                        ;; 00:1859 $c6 $98
    ld   D, A                                          ;; 00:185b $57
    ld   A, [HL+]                                      ;; 00:185c $2a
    ld   [DE], A                                       ;; 00:185d $12
    inc  E                                             ;; 00:185e $1c
    ld   A, [HL+]                                      ;; 00:185f $2a
    ld   [DE], A                                       ;; 00:1860 $12
    inc  E                                             ;; 00:1861 $1c
    ld   A, [HL+]                                      ;; 00:1862 $2a
    ld   [DE], A                                       ;; 00:1863 $12
    inc  E                                             ;; 00:1864 $1c
    ld   A, [HL]                                       ;; 00:1865 $7e
    ld   [DE], A                                       ;; 00:1866 $12
    add  HL, BC                                        ;; 00:1867 $09
    ld   E, L                                          ;; 00:1868 $5d
    ld   A, H                                          ;; 00:1869 $7c
    and  A, $03                                        ;; 00:186a $e6 $03
    add  A, $98                                        ;; 00:186c $c6 $98
    ld   D, A                                          ;; 00:186e $57
    ld   A, [HL+]                                      ;; 00:186f $2a
    ld   [DE], A                                       ;; 00:1870 $12
    inc  E                                             ;; 00:1871 $1c
    ld   A, [HL+]                                      ;; 00:1872 $2a
    ld   [DE], A                                       ;; 00:1873 $12
    inc  E                                             ;; 00:1874 $1c
    ld   A, [HL+]                                      ;; 00:1875 $2a
    ld   [DE], A                                       ;; 00:1876 $12
    inc  E                                             ;; 00:1877 $1c
    ld   A, [HL]                                       ;; 00:1878 $7e
    ld   [DE], A                                       ;; 00:1879 $12
    add  HL, BC                                        ;; 00:187a $09
    ld   E, L                                          ;; 00:187b $5d
    ld   A, H                                          ;; 00:187c $7c
    and  A, $03                                        ;; 00:187d $e6 $03
    add  A, $98                                        ;; 00:187f $c6 $98
    ld   D, A                                          ;; 00:1881 $57
    ld   A, [HL+]                                      ;; 00:1882 $2a
    ld   [DE], A                                       ;; 00:1883 $12
    inc  E                                             ;; 00:1884 $1c
    ld   A, [HL+]                                      ;; 00:1885 $2a
    ld   [DE], A                                       ;; 00:1886 $12
    inc  E                                             ;; 00:1887 $1c
    ld   A, [HL+]                                      ;; 00:1888 $2a
    ld   [DE], A                                       ;; 00:1889 $12
    inc  E                                             ;; 00:188a $1c
    ld   A, [HL]                                       ;; 00:188b $7e
    ld   [DE], A                                       ;; 00:188c $12
    pop  HL                                            ;; 00:188d $e1
    ld   A, L                                          ;; 00:188e $7d
    and  A, $e0                                        ;; 00:188f $e6 $e0
    ld   E, A                                          ;; 00:1891 $5f
    ld   A, L                                          ;; 00:1892 $7d
    add  A, $04                                        ;; 00:1893 $c6 $04
    and  A, $1f                                        ;; 00:1895 $e6 $1f
    or   A, E                                          ;; 00:1897 $b3
    ld   L, A                                          ;; 00:1898 $6f
    pop  AF                                            ;; 00:1899 $f1
    dec  A                                             ;; 00:189a $3d
    jr   NZ, .jr_00_183b                               ;; 00:189b $20 $9e
    pop  HL                                            ;; 00:189d $e1
    ld   DE, $80                                       ;; 00:189e $11 $80 $00
    add  HL, DE                                        ;; 00:18a1 $19
    pop  AF                                            ;; 00:18a2 $f1
    dec  A                                             ;; 00:18a3 $3d
    jr   NZ, .jr_00_1836                               ;; 00:18a4 $20 $90
    ret                                                ;; 00:18a6 $c9

call_00_18a7:
    call call_00_1e3c                                  ;; 00:18a7 $cd $3c $1e
    ld   A, [wD778]                                    ;; 00:18aa $fa $78 $d7
    and  A, A                                          ;; 00:18ad $a7
    jr   Z, call_00_1922_LoadSecondaryTileset                                 ;; 00:18ae $28 $72
    dec  A                                             ;; 00:18b0 $3d
    ld   E, A                                          ;; 00:18b1 $5f
    ld   D, $ce                                        ;; 00:18b2 $16 $ce
    ld   A, [wD779_RelatedToXPosition]                                    ;; 00:18b4 $fa $79 $d7
    ld   C, A                                          ;; 00:18b7 $4f
    ld   A, [wD77A_PlayerYPositionBlock]                                    ;; 00:18b8 $fa $7a $d7
    ld   B, A                                          ;; 00:18bb $47
    push HL                                            ;; 00:18bc $e5
.jr_00_18bd:
    ld   A, [DE]                                       ;; 00:18bd $1a
    cp   A, B                                          ;; 00:18be $b8
    jr   NZ, .jr_00_18dc                               ;; 00:18bf $20 $1b
    dec  D                                             ;; 00:18c1 $15
    ld   A, [DE]                                       ;; 00:18c2 $1a
    inc  D                                             ;; 00:18c3 $14
    sub  A, C                                          ;; 00:18c4 $91
    cp   A, $06                                        ;; 00:18c5 $fe $06
    jr   NC, .jr_00_18dc                               ;; 00:18c7 $30 $13
    push HL                                            ;; 00:18c9 $e5
    add  A, A                                          ;; 00:18ca $87
    add  A, L                                          ;; 00:18cb $85
    ld   L, A                                          ;; 00:18cc $6f
    ld   A, H                                          ;; 00:18cd $7c
    adc  A, $00                                        ;; 00:18ce $ce $00
    ld   H, A                                          ;; 00:18d0 $67
    set  7, E                                          ;; 00:18d1 $cb $fb
    ld   A, [DE]                                       ;; 00:18d3 $1a
    ld   [HL+], A                                      ;; 00:18d4 $22
    dec  D                                             ;; 00:18d5 $15
    ld   A, [DE]                                       ;; 00:18d6 $1a
    ld   [HL], A                                       ;; 00:18d7 $77
    res  7, E                                          ;; 00:18d8 $cb $bb
    inc  D                                             ;; 00:18da $14
    pop  HL                                            ;; 00:18db $e1
.jr_00_18dc:
    dec  E                                             ;; 00:18dc $1d
    bit  7, E                                          ;; 00:18dd $cb $7b
    jr   Z, .jr_00_18bd                                ;; 00:18df $28 $dc
    pop  HL                                            ;; 00:18e1 $e1
    jr   call_00_1922_LoadSecondaryTileset                                    ;; 00:18e2 $18 $3e

call_00_18e4:
    call call_00_1e3c                                  ;; 00:18e4 $cd $3c $1e
    ld   A, [wD778]                                    ;; 00:18e7 $fa $78 $d7
    and  A, A                                          ;; 00:18ea $a7
    jr   Z, call_00_1922_LoadSecondaryTileset                                 ;; 00:18eb $28 $35
    dec  A                                             ;; 00:18ed $3d
    ld   E, A                                          ;; 00:18ee $5f
    ld   D, $cd                                        ;; 00:18ef $16 $cd
    ld   A, [wD779_RelatedToXPosition]                                    ;; 00:18f1 $fa $79 $d7
    ld   C, A                                          ;; 00:18f4 $4f
    ld   A, [wD77A_PlayerYPositionBlock]                                    ;; 00:18f5 $fa $7a $d7
    ld   B, A                                          ;; 00:18f8 $47
    push HL                                            ;; 00:18f9 $e5
.jr_00_18fa:
    ld   A, [DE]                                       ;; 00:18fa $1a
    cp   A, C                                          ;; 00:18fb $b9
    jr   NZ, .jr_00_191a                               ;; 00:18fc $20 $1c
    inc  D                                             ;; 00:18fe $14
    ld   A, [DE]                                       ;; 00:18ff $1a
    dec  D                                             ;; 00:1900 $15
    sub  A, B                                          ;; 00:1901 $90
    cp   A, $06                                        ;; 00:1902 $fe $06
    jr   NC, .jr_00_191a                               ;; 00:1904 $30 $14
    push HL                                            ;; 00:1906 $e5
    inc  HL                                            ;; 00:1907 $23
    add  A, A                                          ;; 00:1908 $87
    add  A, L                                          ;; 00:1909 $85
    ld   L, A                                          ;; 00:190a $6f
    ld   A, H                                          ;; 00:190b $7c
    adc  A, $00                                        ;; 00:190c $ce $00
    ld   H, A                                          ;; 00:190e $67
    set  7, E                                          ;; 00:190f $cb $fb
    ld   A, [DE]                                       ;; 00:1911 $1a
    ld   [HL-], A                                      ;; 00:1912 $32
    inc  D                                             ;; 00:1913 $14
    ld   A, [DE]                                       ;; 00:1914 $1a
    ld   [HL], A                                       ;; 00:1915 $77
    res  7, E                                          ;; 00:1916 $cb $bb
    dec  D                                             ;; 00:1918 $15
    pop  HL                                            ;; 00:1919 $e1
.jr_00_191a:
    dec  E                                             ;; 00:191a $1d
    bit  7, E                                          ;; 00:191b $cb $7b
    jr   Z, .jr_00_18fa                                ;; 00:191d $28 $db
    pop  HL                                            ;; 00:191f $e1
    jr   call_00_1922_LoadSecondaryTileset                                    ;; 00:1920 $18 $00

call_00_1922_LoadSecondaryTileset:
    ld   A, [wD60F_BitmapOfThingsToLoad]                                    ;; 00:1922 $fa $0f $d6
    bit  2, A                                          ;; 00:1925 $cb $57
    ret  NZ                                            ;; 00:1927 $c0
    ld   DE, $0b                                       ;; 00:1928 $11 $0b $00
    add  HL, DE                                        ;; 00:192b $19
    push HL                                            ;; 00:192c $e5
    ld   HL, wD624_CurrentLevelId                                     ;; 00:192d $21 $24 $d6
    ld   L, [HL]                                       ;; 00:1930 $6e
    ld   H, $00                                        ;; 00:1931 $26 $00
    add  HL, HL                                        ;; 00:1933 $29
    ld   BC, .data_00_1a2e_LevelSecondaryTilesetIndices             ;; 00:1934 $01 $2e $1a
    add  HL, BC                                        ;; 00:1937 $09
    ld   A, [HL+]                                      ;; 00:1938 $2a
    ld   H, [HL]                                       ;; 00:1939 $66
    ld   L, A                                          ;; 00:193a $6f
    ld   A, [HL+]                                      ;; 00:193b $2a ; load first value from the Level's data table
    ld   C, A                                          ;; 00:193c $4f ; c = a
    ld   E, L                                          ;; 00:193d $5d
    ld   D, H                                          ;; 00:193e $54 ; de = hl
    pop  HL                                            ;; 00:193f $e1 ; hl = d719
    ld   B, $06                                        ;; 00:1940 $06 $06
.jr_00_1942: ; loading a value written from 3435 bank
    ld   A, [HL-]                                      ;; 00:1942 $3a
    and  A, A                                          ;; 00:1943 $a7
    jr   Z, .jr_00_1954                                ;; 00:1944 $28 $0e ; jmp if 0
    ld   A, [HL]                                       ;; 00:1946 $7e    ; go here if not 0
    sub  A, C                                          ;; 00:1947 $91
    jr   C, .jr_00_1954                                ;; 00:1948 $38 $0a
    push HL                                            ;; 00:194a $e5
    ld   L, A                                          ;; 00:194b $6f
    ld   H, $00                                        ;; 00:194c $26 $00
    add  HL, DE                                        ;; 00:194e $19
    ld   A, [HL]                                       ;; 00:194f $7e
    pop  HL                                            ;; 00:1950 $e1
    and  A, A                                          ;; 00:1951 $a7
    jr   NZ, .jr_00_1959                               ;; 00:1952 $20 $05 ; perform this jump if going to load new secondary tileset
.jr_00_1954:
    dec  HL                                            ;; 00:1954 $2b
    dec  B                                             ;; 00:1955 $05
    jr   NZ, .jr_00_1942                               ;; 00:1956 $20 $ea ; looping over d719, d717,  looking for  non-zero value
    ret                                                ;; 00:1958 $c9
.jr_00_1959:
    dec  A                                             ;; 00:1959 $3d
    ld   HL, wD72D_CurrentSecondaryTilesetIndex          ;; 00:195a $21 $2d $d7
    cp   A, [HL]                                       ;; 00:195d $be
    ret  Z                                             ;; 00:195e $c8 ; return if the secondary tileset is already the current one
    ld   [HL], A                                       ;; 00:195f $77
    ld   C, A                                          ;; 00:1960 $4f
    add  A, A                                          ;; 00:1961 $87
    add  A, C                                          ;; 00:1962 $81
    ld   HL, wD624_CurrentLevelId                                     ;; 00:1963 $21 $24 $d6
    ld   L, [HL]                                       ;; 00:1966 $6e
    ld   H, $00                                        ;; 00:1967 $26 $00
    add  HL, HL                                        ;; 00:1969 $29
    ld   DE, .data_LevelSecondaryTilesetBanks                                     ;; 00:196a $11 $f0 $19
    add  HL, DE                                        ;; 00:196d $19
    add  A, [HL]                                       ;; 00:196e $86
    ld   [wD728_CurrentSecondaryTilesetAddr], A                                    ;; 00:196f $ea $28 $d7
    inc  HL                                            ;; 00:1972 $23
    ld   A, [HL]                                       ;; 00:1973 $7e
    ld   [wD726_SecondaryTilesetBank], A                                    ;; 00:1974 $ea $26 $d7
    ld   [wD72E], A                                    ;; 00:1977 $ea $2e $d7
    call call_00_1089_SwitchBank                                  ;; 00:197a $cd $89 $10
    xor  A, A                                          ;; 00:197d $af
    ld   [wD727], A                                    ;; 00:197e $ea $27 $d7
    ld   A, $00                                        ;; 00:1981 $3e $00
    ld   [wD729], A                                    ;; 00:1983 $ea $29 $d7
    ld   A, $90                                        ;; 00:1986 $3e $90
    ld   [wD72A], A                                    ;; 00:1988 $ea $2a $d7
    ld   A, $40                                        ;; 00:198b $3e $40
    ld   [wD72B], A                                    ;; 00:198d $ea $2b $d7
    ld   A, $02                                        ;; 00:1990 $3e $02
    ld   [wD72C], A                                    ;; 00:1992 $ea $2c $d7
    ld   HL, wD727                                     ;; 00:1995 $21 $27 $d7
    ld   A, [HL+]                                      ;; 00:1998 $2a
    ld   H, [HL]                                       ;; 00:1999 $66
    ld   L, A                                          ;; 00:199a $6f
    ld   DE, $240                                      ;; 00:199b $11 $40 $02
    add  HL, DE                                        ;; 00:199e $19
    ld   DE, wCF00_SecondaryTilesetPaletteIds                                     ;; 00:199f $11 $00 $cf
    ld   B, $24                                        ;; 00:19a2 $06 $24
.jr_00_19a4:
    ld   A, [HL+]                                      ;; 00:19a4 $2a
    ld   [DE], A                                       ;; 00:19a5 $12
    inc  E                                             ;; 00:19a6 $1c
    dec  B                                             ;; 00:19a7 $05
    jr   NZ, .jr_00_19a4                               ;; 00:19a8 $20 $fa
    ld   A, [HL+]                                      ;; 00:19aa $2a
    ld   [wD72F], A                                    ;; 00:19ab $ea $2f $d7
    and  A, A                                          ;; 00:19ae $a7
    jr   Z, .jr_00_19dc                                ;; 00:19af $28 $2b
    ld   A, [HL+]                                      ;; 00:19b1 $2a
    ld   [wD738], A                                    ;; 00:19b2 $ea $38 $d7
    ld   E, [HL]                                       ;; 00:19b5 $5e
    inc  HL                                            ;; 00:19b6 $23
    ld   D, [HL]                                       ;; 00:19b7 $56
    inc  HL                                            ;; 00:19b8 $23
    and  A, $01                                        ;; 00:19b9 $e6 $01
    jr   Z, .jr_00_19be                                ;; 00:19bb $28 $01
    ld   A, [DE]                                       ;; 00:19bd $1a
.jr_00_19be:
    ld   [wD730], A                                    ;; 00:19be $ea $30 $d7
    ld   A, [HL+]                                      ;; 00:19c1 $2a
    ld   [wD731], A                                    ;; 00:19c2 $ea $31 $d7
    ld   [wD732], A                                    ;; 00:19c5 $ea $32 $d7
    ld   A, [HL+]                                      ;; 00:19c8 $2a
    ld   [wD733], A                                    ;; 00:19c9 $ea $33 $d7
    ld   A, [HL+]                                      ;; 00:19cc $2a
    ld   [wD734], A                                    ;; 00:19cd $ea $34 $d7
    ld   A, [HL+]                                      ;; 00:19d0 $2a
    ld   [wD735], A                                    ;; 00:19d1 $ea $35 $d7
    ld   A, L                                          ;; 00:19d4 $7d
    ld   [wD736], A                                    ;; 00:19d5 $ea $36 $d7
    ld   A, H                                          ;; 00:19d8 $7c
    ld   [wD737], A                                    ;; 00:19d9 $ea $37 $d7
.jr_00_19dc:
    ld   HL, wD60F_BitmapOfThingsToLoad                                     ;; 00:19dc $21 $0f $d6
    set  2, [HL]                                       ;; 00:19df $cb $d6
    call call_00_10a3_RestoreBank                                  ;; 00:19e1 $cd $a3 $10
    ld   [wD59D_ReturnBank], A                                    ;; 00:19e4 $ea $9d $d5
    ld   A, Bank0b                                        ;; 00:19e7 $3e $0b
    ld   HL, call_0b_5df8                                     ;; 00:19e9 $21 $f8 $5d
    call call_00_1078_FarCall                                  ;; 00:19ec $cd $78 $10
    ret                                                ;; 00:19ef $c9
.data_LevelSecondaryTilesetBanks: ; this table contains the secondary tileset bank numbers 
; AND the offset into that bank to start getting the tilesets
    db   $40, $13, $40, $0e, $40, $0f, $40, $0f        ;; 00:19f0 ?.?.?.??
    db   $61, $0d, $40, $10, $40, $13, $5b, $0e        ;; 00:19f8 ????????
    db   $40, $0e, $5b, $0e, $61, $0d, $40, $0f        ;; 00:1a00 ????????
    db   $40, $13, $40, $10, $40, $0d, $40, $13        ;; 00:1a08 ????????
    db   $40, $0f, $40, $13, $40, $13, $40, $13        ;; 00:1a10 ????????
    db   $40, $13, $40, $10, $40, $0d, $61, $0d        ;; 00:1a18 ????????
    db   $5b, $0e, $40, $0f, $40, $0d, $40, $13        ;; 00:1a20 ????????
    db   $40, $13, $40, $13, $73, $0e
.data_00_1a2e_LevelSecondaryTilesetIndices: ; one for each channel, some levels share the same one
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_toon_tv
    dw   .secondary_tileset_data_scream_tv
    dw   .secondary_tileset_data_scream_tv        ;; 00:1a2e ??????..
    dw   .secondary_tileset_data_circuit_central
    dw   .secondary_tileset_data_kung_fu_theater
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_prehistory_channel       ;; 00:1a ....????
    dw   .secondary_tileset_data_toon_tv
    dw   .secondary_tileset_data_prehistory_channel
    dw   .secondary_tileset_data_circuit_central
    dw   .secondary_tileset_data_scream_tv        ;; 00:1a3e ????????
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_kung_fu_theater
    dw   .secondary_tileset_data_rezopolis
    dw   .secondary_tileset_data_media_dimension        ;; 00:1a ????????
    dw   .secondary_tileset_data_scream_tv
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_media_dimension        ;; 00:1a4e ????????
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_kung_fu_theater
    dw   .secondary_tileset_data_rezopolis
    dw   .secondary_tileset_data_circuit_central        ;; 00:1a ????????
    dw   .secondary_tileset_data_prehistory_channel
    dw   .secondary_tileset_data_scream_tv
    dw   .secondary_tileset_data_rezopolis
    dw   .secondary_tileset_data_media_dimension        ;; 00:1a5e ????????
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_media_dimension
    dw   .secondary_tileset_data_channel_z
.secondary_tileset_data_media_dimension:
    INCBIN "data/maps/media_dimension/secondary_tileset_data_media_dimension.bin"
.secondary_tileset_data_toon_tv:
    INCBIN "data/maps/toon_tv/secondary_tileset_data_toon_tv.bin"
.secondary_tileset_data_scream_tv:
    INCBIN "data/maps/scream_tv/secondary_tileset_data_scream_tv.bin"
.secondary_tileset_data_circuit_central:
    INCBIN "data/maps/circuit_central/secondary_tileset_data_circuit_central.bin"
.secondary_tileset_data_kung_fu_theater:
    INCBIN "data/maps/kung_fu_theater/secondary_tileset_data_kung_fu_theater.bin"
.secondary_tileset_data_prehistory_channel:
    INCBIN "data/maps/prehistory_channel/secondary_tileset_data_prehistory_channel.bin"
.secondary_tileset_data_rezopolis:
    INCBIN "data/maps/rezopolis/secondary_tileset_data_rezopolis.bin"
.secondary_tileset_data_channel_z:
    INCBIN "data/maps/channel_z/secondary_tileset_data_channel_z.bin"

call_00_1e3c:
; this function loads the values that were obtained from bank special tile banks 34 and 35
    push HL                                            ;; 00:1e3c $e5
    ld   A, [wD6FE_LevelTileOverrideBit]                                    ;; 00:1e3d $fa $fe $d6
    ld   C, A                                          ;; 00:1e40 $4f
    inc  HL                                            ;; 00:1e41 $23
    ld   A, [HL]                                       ;; 00:1e42 $7e
    and  A, C                                          ;; 00:1e43 $a1
    ld   [HL+], A                                      ;; 00:1e44 $22
    inc  HL                                            ;; 00:1e45 $23
    ld   A, [HL]                                       ;; 00:1e46 $7e
    and  A, C                                          ;; 00:1e47 $a1
    ld   [HL+], A                                      ;; 00:1e48 $22
    inc  HL                                            ;; 00:1e49 $23
    ld   A, [HL]                                       ;; 00:1e4a $7e
    and  A, C                                          ;; 00:1e4b $a1
    ld   [HL+], A                                      ;; 00:1e4c $22
    inc  HL                                            ;; 00:1e4d $23
    ld   A, [HL]                                       ;; 00:1e4e $7e
    and  A, C                                          ;; 00:1e4f $a1
    ld   [HL+], A                                      ;; 00:1e50 $22
    inc  HL                                            ;; 00:1e51 $23
    ld   A, [HL]                                       ;; 00:1e52 $7e
    and  A, C                                          ;; 00:1e53 $a1
    ld   [HL+], A                                      ;; 00:1e54 $22
    inc  HL                                            ;; 00:1e55 $23
    ld   A, [HL]                                       ;; 00:1e56 $7e
    and  A, C                                          ;; 00:1e57 $a1
    ld   [HL], A                                       ;; 00:1e58 $77
    pop  HL                                            ;; 00:1e59 $e1
    ret                                                ;; 00:1e5a $c9

call_00_1e5b:
    ld   HL, wD786                                     ;; 00:1e5b $21 $86 $d7
    ld   A, [HL]                                       ;; 00:1e5e $7e
    and  A, A                                          ;; 00:1e5f $a7
    jr   Z, .jr_00_1e63                                ;; 00:1e60 $28 $01
    dec  [HL]                                          ;; 00:1e62 $35
.jr_00_1e63:
    ld   A, [wD77B]                                    ;; 00:1e63 $fa $7b $d7
    and  A, A                                          ;; 00:1e66 $a7
    ret  NZ                                            ;; 00:1e67 $c0
    ld   A, [HL]                                       ;; 00:1e68 $7e
    and  A, A                                          ;; 00:1e69 $a7
    ret  NZ                                            ;; 00:1e6a $c0
    ld   A, [wD787]                                    ;; 00:1e6b $fa $87 $d7
    ld   [HL], A                                       ;; 00:1e6e $77
.jr_00_1e6f:
    ld   HL, wD77D                                     ;; 00:1e6f $21 $7d $d7
    ld   A, [HL]                                       ;; 00:1e72 $7e
    and  A, A                                          ;; 00:1e73 $a7
    ret  Z                                             ;; 00:1e74 $c8
    dec  [HL]                                          ;; 00:1e75 $35
    ld   HL, wD780                                     ;; 00:1e76 $21 $80 $d7
    ld   A, [HL+]                                      ;; 00:1e79 $2a
    ld   H, [HL]                                       ;; 00:1e7a $66
    ld   L, A                                          ;; 00:1e7b $6f
    ld   A, [HL+]                                      ;; 00:1e7c $2a
    ld   [wD77C], A                                    ;; 00:1e7d $ea $7c $d7
    bit  5, A                                          ;; 00:1e80 $cb $6f
    jr   Z, .jr_00_1e8a                                ;; 00:1e82 $28 $06
    ld   A, [HL+]                                      ;; 00:1e84 $2a
    push HL                                            ;; 00:1e85 $e5
    call call_00_113e                                  ;; 00:1e86 $cd $3e $11
    pop  HL                                            ;; 00:1e89 $e1
.jr_00_1e8a:
    ld   A, L                                          ;; 00:1e8a $7d
    ld   [wD780], A                                    ;; 00:1e8b $ea $80 $d7
    ld   A, H                                          ;; 00:1e8e $7c
    ld   [wD781], A                                    ;; 00:1e8f $ea $81 $d7
    ld   HL, wD77C                                     ;; 00:1e92 $21 $7c $d7
    bit  1, [HL]                                       ;; 00:1e95 $cb $4e
    call NZ, call_00_1ec9_UpdateBgTileFlags                              ;; 00:1e97 $c4 $c9 $1e
    ld   HL, wD77C                                     ;; 00:1e9a $21 $7c $d7
    bit  2, [HL]                                       ;; 00:1e9d $cb $56
    call NZ, call_00_1f05                              ;; 00:1e9f $c4 $05 $1f
    ld   HL, wD77C                                     ;; 00:1ea2 $21 $7c $d7
    bit  3, [HL]                                       ;; 00:1ea5 $cb $5e
    call NZ, call_00_169f                              ;; 00:1ea7 $c4 $9f $16
    ld   HL, wD785                                     ;; 00:1eaa $21 $85 $d7
    ld   B, [HL]                                       ;; 00:1ead $46
    ld   HL, wD784                                     ;; 00:1eae $21 $84 $d7
    ld   C, [HL]                                       ;; 00:1eb1 $4e
    xor  A, A                                          ;; 00:1eb2 $af
.jr_00_1eb3:
    add  A, C                                          ;; 00:1eb3 $81
    dec  B                                             ;; 00:1eb4 $05
    jr   NZ, .jr_00_1eb3                               ;; 00:1eb5 $20 $fc
    add  A, A                                          ;; 00:1eb7 $87
    ld   HL, wD780                                     ;; 00:1eb8 $21 $80 $d7
    add  A, [HL]                                       ;; 00:1ebb $86
    ld   [HL+], A                                      ;; 00:1ebc $22
    ld   A, $00                                        ;; 00:1ebd $3e $00
    adc  A, [HL]                                       ;; 00:1ebf $8e
    ld   [HL], A                                       ;; 00:1ec0 $77
    ld   HL, wD77C                                     ;; 00:1ec1 $21 $7c $d7
    bit  0, [HL]                                       ;; 00:1ec4 $cb $46
    jr   NZ, .jr_00_1e6f                               ;; 00:1ec6 $20 $a7
    ret                                                ;; 00:1ec8 $c9

call_00_1ec9_UpdateBgTileFlags:
    ld   HL, wD782                                     ;; 00:1ec9 $21 $82 $d7
    ld   C, [HL]                                       ;; 00:1ecc $4e
    ld   HL, wD783                                     ;; 00:1ecd $21 $83 $d7
    ld   B, [HL]                                       ;; 00:1ed0 $46
    ld   HL, wD780                                     ;; 00:1ed1 $21 $80 $d7
    ld   E, [HL]                                       ;; 00:1ed4 $5e
    inc  HL                                            ;; 00:1ed5 $23
    ld   D, [HL]                                       ;; 00:1ed6 $56
    ld   HL, wD778                                     ;; 00:1ed7 $21 $78 $d7
    ld   L, [HL]                                       ;; 00:1eda $6e
    ld   H, $ce                                        ;; 00:1edb $26 $ce
    ld   A, [wD785]                                    ;; 00:1edd $fa $85 $d7
.jr_00_1ee0:
    push AF                                            ;; 00:1ee0 $f5
    push BC                                            ;; 00:1ee1 $c5
    ld   A, [wD784]                                    ;; 00:1ee2 $fa $84 $d7
.jr_00_1ee5:
    push AF                                            ;; 00:1ee5 $f5
    ld   [HL], B                                       ;; 00:1ee6 $70 ; updated CE00 bgtile flags
    set  7, L                                          ;; 00:1ee7 $cb $fd
    ld   A, [DE]                                       ;; 00:1ee9 $1a
    ld   [HL], A                                       ;; 00:1eea $77
    inc  DE                                            ;; 00:1eeb $13
    dec  H                                             ;; 00:1eec $25
    ld   A, [DE]                                       ;; 00:1eed $1a
    ld   [HL], A                                       ;; 00:1eee $77
    inc  DE                                            ;; 00:1eef $13
    res  7, L                                          ;; 00:1ef0 $cb $bd
    ld   [HL], C                                       ;; 00:1ef2 $71 ; updated CD00 bgtile flags
    inc  H                                             ;; 00:1ef3 $24
    inc  L                                             ;; 00:1ef4 $2c
    inc  C                                             ;; 00:1ef5 $0c
    pop  AF                                            ;; 00:1ef6 $f1
    dec  A                                             ;; 00:1ef7 $3d
    jr   NZ, .jr_00_1ee5                               ;; 00:1ef8 $20 $eb
    pop  BC                                            ;; 00:1efa $c1
    inc  B                                             ;; 00:1efb $04
    pop  AF                                            ;; 00:1efc $f1
    dec  A                                             ;; 00:1efd $3d
    jr   NZ, .jr_00_1ee0                               ;; 00:1efe $20 $e0
    ld   A, L                                          ;; 00:1f00 $7d
    ld   [wD778], A                                    ;; 00:1f01 $ea $78 $d7
    ret                                                ;; 00:1f04 $c9

call_00_1f05:
    ld   HL, wD782                                     ;; 00:1f05 $21 $82 $d7
    ld   C, [HL]                                       ;; 00:1f08 $4e
    ld   HL, wD783                                     ;; 00:1f09 $21 $83 $d7
    ld   B, [HL]                                       ;; 00:1f0c $46
    ld   HL, wD780                                     ;; 00:1f0d $21 $80 $d7
    ld   E, [HL]                                       ;; 00:1f10 $5e
    inc  HL                                            ;; 00:1f11 $23
    ld   D, [HL]                                       ;; 00:1f12 $56
    ld   HL, wD778                                     ;; 00:1f13 $21 $78 $d7
    ld   L, [HL]                                       ;; 00:1f16 $6e
    dec  L                                             ;; 00:1f17 $2d
    ld   H, $cd                                        ;; 00:1f18 $26 $cd
.jr_00_1f1a:
    ld   A, [HL]                                       ;; 00:1f1a $7e
    cp   A, C                                          ;; 00:1f1b $b9
    jr   NZ, .jr_00_1f24                               ;; 00:1f1c $20 $06
    inc  H                                             ;; 00:1f1e $24
    ld   A, [HL]                                       ;; 00:1f1f $7e
    cp   A, B                                          ;; 00:1f20 $b8
    jr   Z, .jr_00_1f2a                                ;; 00:1f21 $28 $07
    dec  H                                             ;; 00:1f23 $25
.jr_00_1f24:
    dec  L                                             ;; 00:1f24 $2d
    bit  7, L                                          ;; 00:1f25 $cb $7d
    jr   Z, .jr_00_1f1a                                ;; 00:1f27 $28 $f1
    ret                                                ;; 00:1f29 $c9
.jr_00_1f2a:
    set  7, L                                          ;; 00:1f2a $cb $fd
    ld   H, $ce                                        ;; 00:1f2c $26 $ce
    ld   A, [wD785]                                    ;; 00:1f2e $fa $85 $d7
    ld   B, A                                          ;; 00:1f31 $47
.jr_00_1f32:
    ld   A, [wD784]                                    ;; 00:1f32 $fa $84 $d7
    ld   C, A                                          ;; 00:1f35 $4f
.jr_00_1f36:
    ld   A, [DE]                                       ;; 00:1f36 $1a
    ld   [HL], A                                       ;; 00:1f37 $77
    inc  DE                                            ;; 00:1f38 $13
    dec  H                                             ;; 00:1f39 $25
    ld   A, [DE]                                       ;; 00:1f3a $1a
    ld   [HL], A                                       ;; 00:1f3b $77
    inc  DE                                            ;; 00:1f3c $13
    inc  H                                             ;; 00:1f3d $24
    inc  L                                             ;; 00:1f3e $2c
    dec  C                                             ;; 00:1f3f $0d
    jr   NZ, .jr_00_1f36                               ;; 00:1f40 $20 $f4
    dec  B                                             ;; 00:1f42 $05
    jr   NZ, .jr_00_1f32                               ;; 00:1f43 $20 $ed
    ret                                                ;; 00:1f45 $c9
