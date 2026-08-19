call_00_1264_BgMap_LoadFull:
; Top-level map initialization. Queries all map metadata (bank numbers for map data, alt blockset,
; blockset+collision, tileset; tileset offset; alt blockset mask) and stores them to wD6F5–wD700_BgMap_TilesetBankOffset.
; Calls call_00_0f38_FadeOutAndClearVRAM, then call_00_1419_BgMap_LoadTileset. Resets secondary tileset index to $FF,
; clears wD77B_BlockPatch_VramWritePending/wD77D_BlockPatch_StepsRemaining. Then loops 22 ($16) times:
; sets wD6F9_BgMap_LoadingFlags=$01 (dirty flag), calls LoadBgMapDirtyRegions
; and VRAM_WriteBgMapRowForVerticalScroll, advances wD6EF (Y map position) by 8 each iteration — so
; it walks DOWN the map, drawing one horizontal row per pass, until the whole visible area is
; filled. Clears dirty flag, loads HUD tiles, updates map window
    call call_00_0ede_SelectWramBank1
    call call_00_2e77_MapData_GetBlockmapBank
    ld   [wD6F5_BgMap_BlockmapBank], A
    call call_00_2e80_MapData_GetAltBlocksetBank
    ld   [wD6F6_BgMap_AltBlocksetBank], A
    call call_00_2e89_MapData_GetBlocksetAndCollisionBank
    ld   [wD6F7_BgMap_BlocksetAndCollisionBank], A
    call call_00_2e93_MapData_GetAltBlocksetMask
    ld   [wD6FE_BgMap_AltBlocksetMask], A
    call call_00_2e9c_MapData_GetTilesetBank
    ld   [wD6FF_BgMap_TilesetBank], A
    call call_00_2ea5_MapData_GetTilesetBankOffset
    ld   HL, wD700_BgMap_TilesetBankOffset
    ld   [HL], E
    inc  HL
    ld   [HL], D
    call call_00_0f38_FadeOutAndClearVRAM
    call call_00_1419_BgMap_LoadTileset
    ld   A, $ff
    ld   [wD72D_SecondaryTilesetIndex], A
    xor  A, A
    ld   [wD77B_BlockPatch_VramWritePending], A
    ld   [wD77D_BlockPatch_StepsRemaining], A
    ld   A, $16
.jr_00_12a2:
    push AF
    ld   A, MAP_SCROLL_DOWN
    ld   [wD6F9_BgMap_LoadingFlags], A
    call call_00_1455_BgMap_LoadDirtyRegions
    FARCALL call_03_6f5e_VRAM_WriteBgMapRowForVerticalScroll
    ld   HL, wD6EF_BgMap_ScrollY
    ld   A, [HL]
    add  A, $08
    ld   [HL], A
    inc  HL
    ld   A, [HL]
    adc  A, $00
    ld   [HL], A
    pop  AF
    dec  A
    jr   NZ, .jr_00_12a2
    ld   [wD6F9_BgMap_LoadingFlags], A
    FARCALL call_03_66ae_HUD_LoadTiles
    FARCALL call_02_715a_MapWindow_Update
    xor  A, A
    ld   [wD6F9_BgMap_LoadingFlags], A
    ret

call_00_12e4_BlockPatch_Init:
; Clears 16 bytes at wD78B_BlockPatch_SlotTable and wD778_BlockPatch_SlotWriteHead.
; Looks up current level ID in .data_00_1356_LevelInitialPatchSlots to get a tile flag byte, then
; rotates its 3 low bits into wD798_BlockPatch_SlotTable13–wD79A_BlockPatch_SlotTable15 (1 bit each via rrca/rl).
; If level ID is 0 (Media Dimension), iterates over .data_00_1375_MediaDimension_InitialPatches
; (a $FF-terminated list of 12-byte patch records): compares wD64F_MissionRemoteTotal (low 7 bits) against the record's
; threshold — if equal and bit 7 of wD64F_MissionRemoteTotal is set, marks the matching wD78B_BlockPatch_SlotTable slot as $02.
; If greater, loads the record's tile coordinates into wD782_BlockPatch_TargetBlockX/wD783_BlockPatch_TargetBlockY
; and pointer into wD780_BlockPatch_DataPtrLo/wD781_BlockPatch_DataPtrHi, sets wD784_BlockPatch_Width/
; wD785_BlockPatch_Height=$02, calls call_00_1ec9_BlockPatch_Register. Advances $0C per record.
    ld   HL, wD78B_BlockPatch_SlotTable
    ld   B, $10
    xor  A, A
.jr_00_12ea:
    ld   [HL+], A
    dec  B
    jr   NZ, .jr_00_12ea
    ld   [wD778_BlockPatch_SlotWriteHead], A
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    ld   DE, .data_00_1356_LevelInitialPatchSlots
    add  HL, DE
    ld   A, [HL]
    ld   HL, wD798_BlockPatch_SlotTable13
    ld   B, $03
.jr_00_1301:
    rrca
    rl   [HL]
    inc  HL
    dec  B
    jr   NZ, .jr_00_1301
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    ret  NZ
    ld   HL, .data_00_1375_MediaDimension_InitialPatches
.jr_00_1310:
    ld   A, [HL]
    cp   A, $ff
    ret  Z
    push HL
    ld   A, [wD64F_MissionRemoteTotal]
    and  A, $7f
    cp   A, [HL]
    jr   C, .jr_00_134f
    jr   NZ, .jr_00_1332
    ld   A, [wD64F_MissionRemoteTotal]
    bit  7, A
    jr   Z, .jr_00_1332
    inc  HL
    ld   L, [HL]
    ld   H, $00
    ld   DE, wD78B_BlockPatch_SlotTable
    add  HL, DE
    ld   [HL], $02
    jr   .jr_00_134f
.jr_00_1332:
    inc  HL
    inc  HL
    ld   A, [HL+]
    ld   [wD782_BlockPatch_TargetBlockX], A
    ld   A, [HL+]
    ld   [wD783_BlockPatch_TargetBlockY], A
    ld   A, L
    ld   [wD780_BlockPatch_DataPtrLo], A
    ld   A, H
    ld   [wD781_BlockPatch_DataPtrHi], A
    ld   A, $02
    ld   [wD784_BlockPatch_Width], A
    ld   [wD785_BlockPatch_Height], A
    call call_00_1ec9_BlockPatch_Register
.jr_00_134f:
    pop  HL
    ld   DE, $0c
    add  HL, DE
    jr   .jr_00_1310
.data_00_1356_LevelInitialPatchSlots:
; 31-byte table indexed by level ID. The low three bits are rotated into the block patch
; slots 13, 14 and 15 by call_00_12e4_BlockPatch_Init, pre-arming those three slots for
; levels that start with some geometry already changed.
    db   $00    ; MAP_MEDIA_DIMENSION
    db   $01    ; MAP_TOON_TV_OUT_OF_TOON
    db   $05    ; MAP_SCREAM_TV_SMELLRAISER
    db   $07    ; MAP_SCREAM_TV_FRANKENSTEINFELD
    db   $03    ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    db   $03    ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    db   $00    ; MAP_UNUSED_06
    db   $03    ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    db   $03    ; MAP_TOON_TV_FINE_TOONING
    db   $07    ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    db   $07    ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    db   $03    ; MAP_SCREAM_TV_POLTERGEX
    db   $00    ; MAP_UNUSED_0C
    db   $07    ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    db   $01    ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    db   $00    ; MAP_UNUSED_0F
    db   $00    ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    db   $00    ; MAP_UNUSED_11
    db   $00    ; MAP_UNUSED_12
    db   $00    ; MAP_UNUSED_13
    db   $00    ; MAP_UNUSED_14
    db   $00    ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    db   $00    ; MAP_REZOPOLIS_BUGGED_OUT
    db   $00    ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    db   $01    ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    db   $01    ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    db   $03    ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    db   $00    ; MAP_UNUSED_1B
    db   $00    ; MAP_UNUSED_1C
    db   $00    ; MAP_UNUSED_1D
    db   $00    ; MAP_BOSS_TV_CHANNEL_Z
.data_00_1375_MediaDimension_InitialPatches:
; $FF-terminated list of 12-byte records for Media Dimension block patches:
;   +0  db  remote-total threshold
;   +1  db  block patch slot index
;   +2  db  block X          +3  db  block Y
;   +4  8 bytes              the 2x2 block of replacement tiles
; There is no size field - the caller hardcodes width and height to $02, which is why the
; payload is always four 16-bit entries. Used to pre-apply the hub's opened-up geometry on
; load, so tvs the player has already unlocked are open when the map appears
    db   $06, $00, $25, $0d, $7c, $01, $7d, $01, $8c, $01, $8d, $01
    db   $09, $01, $1b, $16, $78, $01, $79, $01, $88, $01, $89, $01
    db   $12, $02, $2f, $16, $5c, $01, $5d, $01, $6c, $01, $6d, $01
    db   $0d, $03, $43, $16, $58, $01, $59, $01, $68, $01, $69, $01
    db   $ff

call_00_13a6_BgMap_UpdateWindowFromPlayerPos:
; Summary: Uses Player position to calculate wD6ED_BgMap_ScrollX, wD6ED_BgMap_ScrollY, wD329_MapWindow_BlockXRangeMin,
; wD32A_MapWindow_BlockXRangeMax, wD32B_MapWindow_BlockYRangeMin, and wD32C_MapWindow_BlockYRangeMax
;
; Computes the map scroll window X and Y positions from player world coordinates.
; For X: subtracts $50 from player X; clamps to $20 minimum and $0F40 maximum, defaulting to $20 if
; below zero. Stores result to wD6ED (map X scroll).
; For Y: subtracts $48 from player Y; clamps between $20 and $0F50, defaulting to $20 if underflow.
; Stores to wD6EF (map Y scroll).
; In both axes, computes block coordinates (value × 8, high byte) stored to wD329_MapWindow_BlockXRangeMin/
; wD32A_MapWindow_BlockXRangeMax (X block range) and wD32B_MapWindow_BlockYRangeMin/wD32C_MapWindow_BlockYRangeMax (Y block range)
    ld   HL, wD20E_Player_XPositionLo
    ld   A, [HL+]
    sub  A, $50
    ld   E, A
    ld   A, [HL]
    sbc  A, $00
    ld   D, A
    jr   C, .jr_00_13c8
    ld   A, E
    sub  A, $20
    ld   A, D
    sbc  A, $00
    jr   C, .jr_00_13c8
    ld   A, E
    sub  A, $40
    ld   A, D
    sbc  A, $0f
    jr   C, .jr_00_13cb
    ld   DE, $f40
    jr   .jr_00_13cb
.jr_00_13c8:
    ld   DE, $20
.jr_00_13cb:
    ld   HL, wD6ED_BgMap_ScrollX
    ld   [HL], E
    inc  HL
    ld   [HL], D
    ld   L, E
    ld   H, D
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD329_MapWindow_BlockXRangeMin], A
    add  A, $05
    ld   [wD32A_MapWindow_BlockXRangeMax], A
    ld   HL, wD210_Player_YPositionLo
    ld   A, [HL+]
    sub  A, $48
    ld   E, A
    ld   A, [HL]
    sbc  A, $00
    ld   D, A
    jr   C, .jr_00_1401
    ld   A, E
    sub  A, $20
    ld   A, D
    sbc  A, $00
    jr   C, .jr_00_1401
    ld   A, E
    sub  A, $50
    ld   A, D
    sbc  A, $0f
    jr   C, .jr_00_1404
    ld   DE, $f50
    jr   .jr_00_1404
.jr_00_1401:
    ld   DE, $20
.jr_00_1404:
    ld   HL, wD6EF_BgMap_ScrollY
    ld   [HL], E
    inc  HL
    ld   [HL], D
    ld   L, E
    ld   H, D
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD32B_MapWindow_BlockYRangeMin], A
    add  A, $05
    ld   [wD32C_MapWindow_BlockYRangeMax], A
    ret

call_00_1419_BgMap_LoadTileset:
; Loads the current BG tileset bank, reads the tileset pointer from wD700_BgMap_TilesetBankOffset.
; Copies tiles sequentially: first fills VRAM $9000–$9800 (256 tiles), then fills
; $8800–$9000 (another 256 tiles). Restores bank, then calls TilesetPaletteIds_Load
; and MapTileAnim_Init
    ld   A, [wD6FF_BgMap_TilesetBank]
    call call_00_1089_SwitchBank
    ld   HL, wD700_BgMap_TilesetBankOffset
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, VRAM_TILESET_ADDR_1
.jr_00_1428:
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, D
    cp   A, $98
    jr   NZ, .jr_00_1428
    ld   DE, VRAM_TILESET_ADDR_2
.jr_00_1433:
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, D
    cp   A, $90
    jr   NZ, .jr_00_1433
    call call_00_10a3_RestoreBank
    FARCALL call_0b_641e_TilesetPaletteIds_Load
    FARCALL call_03_723c_MapTileAnim_Init
    ret

call_00_1455_BgMap_LoadDirtyRegions:
; Spin-waits while bit 7 of wD6F9_BgMap_LoadingFlags is set (VBLANK transfer in progress). Checks bits 0–1 of
; wD6F9_BgMap_LoadingFlags — if set, calls LoadVerticalBgStrip (camera moved vertically). Checks bits 2–3 —
; if set, calls LoadHorizontalBgStrip (camera moved horizontally). Sets bit 7 of wD6F9_BgMap_LoadingFlags to
; signal a pending VRAM transfer is ready
    ld   HL, wD6F9_BgMap_LoadingFlags
    bit  MAP_PENDING_VRAM_TRANSFER, [HL]
    jr   NZ, call_00_1455_BgMap_LoadDirtyRegions
    ld   A, [wD6F9_BgMap_LoadingFlags]
    and  A, MAP_SCROLL_DOWN | MAP_SCROLL_UP
    call NZ, call_00_1472_BgMap_LoadRowForVerticalScroll
    ld   A, [wD6F9_BgMap_LoadingFlags]
    and  A, MAP_SCROLL_RIGHT | MAP_SCROLL_LEFT
    call NZ, call_00_157a_BgMap_LoadColumnForHorizontalScroll
    ld   HL, wD6F9_BgMap_LoadingFlags
    set  MAP_PENDING_VRAM_TRANSFER, [HL]
    ret

call_00_1472_BgMap_LoadRowForVerticalScroll:
; Loads one horizontal row of 6 metatiles into the BG tilemap for vertical camera scrolling.
; Scrolling vertically exposes a new horizontal ROW; the column twin below handles horizontal
; scrolling, which exposes a vertical COLUMN.
; Determines whether to load the top or bottom edge row based on wD6F9_BgMap_LoadingFlags bit 1.
; Computes map data addresses from current X/Y scroll positions (wD6ED/wD6EF).
; Reads 6 metatile IDs from the map bank (wD6F5) into wD702_BgMap_TempScratchRowMetaTileIDs–wD70C
; (every other byte), reads corresponding alt blockset flags from the secondary bank (wD6F6) into
; wD703_BgMap_TempScratchRowAltBlocksetFlags–wD70D. Calls call_00_18a7_BgMap_ApplyBlockPatchesToRow,
; which applies BOTH fix-ups to that scratch buffer before it is expanded: the alt blockset mask over
; the flag bytes, then any registered block patches over the metatile ids. Switches to
; blockset/collision bank (wD6F7), then expands
; each metatile into 8 tile IDs (2×4 tiles, GBC attribute bits set on alternating writes via set 3, H /
; set 5, B) and writes them to the GBC tilemap at computed VRAM addresses. Handles tilemap row wrap at
; $20-byte boundaries
    ld   HL, wD6EF_BgMap_ScrollY
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   B, A                                          ; after this point BC is equal to [wD6EF_BgMap_ScrollY]
    ld   HL, $90                                       ; HL = $90
    ld   A, [wD6F9_BgMap_LoadingFlags]
    and  A, MAP_SCROLL_UP
    jr   NZ, .jr_00_1486
    ld   HL, $ffff
.jr_00_1486:
    add  HL, BC                                        ; HL = HL - 1
    ld   C, L                                          ; bc = hl
    ld   B, H                                          ; bc = hl
    ld   HL, wD6ED_BgMap_ScrollX
    ld   A, [HL+]
    ld   E, A
    ld   A, [HL+]
    ld   D, A                                          ; after this point DE is equal to [wD6ED_BgMap_ScrollX], BC is [wD6EF_BgMap_ScrollY]
    ld   L, C
    ld   H, B                                          ; HL = [wD6EF_BgMap_ScrollY]
    add  HL, HL
    add  HL, HL
    add  HL, HL                                        ; HL = 8 * HL
    ld   A, H
    ld   [wD77A_BgMap_ScrollBlockY], A                                    ; [wD77A_BgMap_ScrollBlockY] = the upper byte of the 8x value
    ld   L, E
    ld   H, D                                          ; HL = [wD6ED_BgMap_ScrollX]
    add  HL, HL
    add  HL, HL
    add  HL, HL                                        ; HL = 8 * HL
    ld   A, H
    ld   [wD779_BgMap_ScrollBlockX], A                                    ; [wD779_BgMap_ScrollBlockX] = the upper byte of the 8x value
    ld   A, C
    and  A, $f8
    ld   L, A
    ld   H, $00                                        ; after this, hl = C(lower byte of y pos) & 0xf8
    add  HL, HL
    add  HL, HL                                        ; HL = 4 * HL
    ld   A, E                                          ; a = lower byte of x pos
    rrca
    rrca
    rrca                                               ; rotate to check some bits in there
    and  A, $1c
    or   A, L
    ld   L, A
    push HL
    ld   [wD6FA_BgMap_RowWritePosLo], A
    ld   A, H
    ld   [wD6FB_BgMap_RowWritePosHi], A
    ld   A, C
    rrca
    and  A, $0c
    add  A, $40
    push AF
    ld   L, C
    ld   H, B
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   L, E
    ld   H, D
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   L, H
    srl  A
    rr   L
    add  A, $40
    ld   H, A
    push HL
    push HL
    ld   A, [wD6F5_BgMap_BlockmapBank]
    call call_00_1089_SwitchBank
    pop  HL
    ld   DE, wD702_BgMap_TempScratchRowMetaTileIDs
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    call call_00_10a3_RestoreBank
    ld   A, [wD6F6_BgMap_AltBlocksetBank]
    call call_00_1089_SwitchBank
    pop  HL
    ld   DE, wD703_BgMap_TempScratchRowAltBlocksetFlags
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    call call_00_10a3_RestoreBank
    ld   HL, wD702_BgMap_TempScratchRowMetaTileIDs
    call call_00_18a7_BgMap_ApplyBlockPatchesToRow
    ld   A, [wD6F7_BgMap_BlocksetAndCollisionBank]
    call call_00_1089_SwitchBank
    pop  AF
    pop  HL
    ld   B, A
    ld   A, H
    add  A, $c0
    ld   H, A
    ld   DE, wD702_BgMap_TempScratchRowMetaTileIDs
    ld   A, $06
.jr_00_1535:
    push AF
    ld   A, [DE]
    ld   C, A
    inc  DE
    res  4, B
    ld   A, [DE]                                       ; loads 3435 data
    and  A, A
    jr   Z, .jr_00_1541
    set  4, B
.jr_00_1541:
    inc  DE
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, [BC]
    ld   [HL+], A
    ld   A, L
    and  A, $1f
    jr   NZ, .jr_00_156f
    dec  HL
    ld   A, L
    and  A, $e0
    ld   L, A
.jr_00_156f:
    dec  B
    dec  B
    dec  B
    pop  AF
    dec  A
    jr   NZ, .jr_00_1535
    call call_00_10a3_RestoreBank
    ret

call_00_157a_BgMap_LoadColumnForHorizontalScroll:
; Loads one vertical column of 6 metatiles for horizontal camera scrolling. Mirrors the
; structure of LoadVerticalBgStrip: determines left or right edge column from wD6F9_BgMap_LoadingFlags bit 3,
; reads 6 metatile IDs (stepping $80 bytes = one map row apart) from the map bank and alt blockset
; bank into wD70E_BgMap_TempScratchColumnMetaTileIDs–wD71C. Calls call_00_18e4_BgMap_ApplyBlockPatchesToColumn for secondary tileset resolution. Expands each metatile
; into 8 tile IDs and writes to VRAM column-wise, advancing HL by $20 (one tilemap row) per pair,
; with GBC attribute toggling via set 3, H / set 5, B. Handles tilemap column wrap at 32-tile ($20)
; boundaries
    ld   HL, wD6ED_BgMap_ScrollX
    ld   A, [HL+]
    ld   E, A
    ld   A, [HL+]
    ld   D, A
    ld   HL, $a0
    ld   A, [wD6F9_BgMap_LoadingFlags]
    and  A, MAP_SCROLL_LEFT
    jr   NZ, .jr_00_158e
    ld   HL, rIE
.jr_00_158e:
    add  HL, DE
    ld   E, L
    ld   D, H
    ld   HL, wD6EF_BgMap_ScrollY
    ld   A, [HL+]
    ld   C, A
    ld   A, [HL+]
    ld   B, A
    ld   L, C
    ld   H, B
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD77A_BgMap_ScrollBlockY], A
    ld   L, E
    ld   H, D
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   [wD779_BgMap_ScrollBlockX], A
    ld   A, C
    and  A, $e0
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    ld   A, E
    rrca
    rrca
    rrca
    and  A, $1f
    or   A, L
    ld   L, A
    push HL
    ld   [wD6FC_BgMap_ColumnWritePos], A
    ld   A, H
    ld   [wD6FD_BgMap_ColumnWritePosHi], A
    ld   A, E
    rrca
    rrca
    rrca
    and  A, $03
    add  A, $40
    push AF
    ld   L, C
    ld   H, B
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   A, H
    ld   L, E
    ld   H, D
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   L, H
    srl  A
    rr   L
    add  A, $40
    ld   H, A
    push HL
    push HL
    ld   A, [wD6F5_BgMap_BlockmapBank]
    call call_00_1089_SwitchBank
    pop  HL
    ld   DE, wD70E_BgMap_TempScratchColumnMetaTileIDs
    ld   BC, $80
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    call call_00_10a3_RestoreBank
    ld   A, [wD6F6_BgMap_AltBlocksetBank]
    call call_00_1089_SwitchBank
    pop  HL
    ld   DE, wD70F_BgMap_TempScratchColumnAltBlocksetFlags
    ld   BC, $80
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    inc  DE
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    call call_00_10a3_RestoreBank
    ld   HL, wD70E_BgMap_TempScratchColumnMetaTileIDs
    call call_00_18e4_BgMap_ApplyBlockPatchesToColumn
    ld   A, [wD6F7_BgMap_BlocksetAndCollisionBank]
    call call_00_1089_SwitchBank
    pop  AF
    pop  HL
    ld   B, A
    ld   A, H
    add  A, $c0
    ld   H, A
    ld   DE, wD70E_BgMap_TempScratchColumnMetaTileIDs
    ld   A, $06
.jr_00_164f:
    push AF
    ld   A, [DE]
    ld   C, A
    inc  DE
    res  4, B
    ld   A, [DE]
    and  A, A
    jr   Z, .jr_00_165b
    set  4, B
.jr_00_165b:
    inc  DE
    push DE
    ld   DE, $20
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL], A
    add  HL, DE
    ld   A, B
    add  A, $04
    ld   B, A
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, [BC]
    ld   [HL], A
    add  HL, DE
    ld   A, B
    add  A, $04
    ld   B, A
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL], A
    add  HL, DE
    ld   A, B
    add  A, $04
    ld   B, A
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, [BC]
    ld   [HL], A
    add  HL, DE
    res  2, H
    pop  DE
    ld   A, B
    sub  A, $0c
    ld   B, A
    pop  AF
    dec  A
    jr   NZ, .jr_00_164f
    call call_00_10a3_RestoreBank
    ret

call_00_169f_BlockPatch_WriteTiles:
; Writes a rectangular block of metatile graphics to the GBC BG tilemap, using metatile
; indices from wD780/wD781 (data pointer) and the tilemap VRAM address from wD77E/wD77F.
; Switches to wD6F7_BgMap_BlocksetAndCollisionBank. For each metatile in the width × height rectangle:
; reads 2 bytes from the data pointer (blockset index C, alt blockset flag); sets B=$40 as
; the blockset page base, or $50 if the alt blockset flag is nonzero. This is the one place the
; two systems meet: a block patch's per-cell data carries an alt blockset selector alongside the
; metatile id;
; expands the metatile to 8 tile IDs by reading 8 consecutive bytes from [BC] in the blockset bank.
; Writes them to the tilemap in a 4×2 pattern: first row left-to-right, second row right-to-left,
; with set 3, H toggling between the two halves of the interleaved GBC tilemap layout.
; Each row advances HL by $20 (one tilemap row). After writing all columns in a row, L is wrapped
; within its $20-byte aligned block; after all rows, HL advances by $80 (one full metatile row).
; After all metatiles, sets bit 0 of wD77B_BlockPatch_VramWritePending to gate further sequence steps
; until VBLANK flushes the write. Restores bank
    ld   A, [wD6F7_BgMap_BlocksetAndCollisionBank]
    call call_00_1089_SwitchBank
    ld   HL, wD780_BlockPatch_DataPtrLo
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   HL, wD77E_BlockPatch_TilemapAddrLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   A, [wD785_BlockPatch_Height]
.jp_00_16b4:
    push AF
    push HL
    ld   A, [wD784_BlockPatch_Width]
.jp_00_16b9:
    push AF
    push DE
    push HL
    ld   A, H
    and  A, $03
    add  A, $c0
    ld   H, A
    ld   A, [DE]
    ld   C, A
    ld   B, $40
    inc  DE
    ld   A, [DE]
    and  A, A
    jr   Z, .jr_00_16cd
    set  4, B
.jr_00_16cd:
    ld   DE, $20
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, B
    add  A, $04
    ld   B, A
    add  HL, DE
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, B
    add  A, $04
    ld   B, A
    add  HL, DE
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL], A
    res  3, H
    res  5, B
    ld   A, B
    add  A, $04
    ld   B, A
    add  HL, DE
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL+], A
    inc  B
    ld   A, [BC]
    ld   [HL], A
    set  3, H
    set  5, B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL-], A
    dec  B
    ld   A, [BC]
    ld   [HL], A
    pop  HL
    ld   A, L
    and  A, $e0
    ld   C, A
    ld   A, L
    add  A, $04
    and  A, $1f
    or   A, C
    ld   L, A
    pop  DE
    inc  DE
    inc  DE
    pop  AF
    dec  A
    jp   NZ, .jp_00_16b9
    pop  HL
    ld   BC, $80
    add  HL, BC
    pop  AF
    dec  A
    jp   NZ, .jp_00_16b4
    ld   HL, wD77B_BlockPatch_VramWritePending
    set  0, [HL]
    jp   call_00_10a3_RestoreBank

call_00_1779_BlockPatch_WriteAttributes:
; Writes GBC palette attribute bytes and tile IDs to the BG tilemap for a block patch rectangle.
; On GBC (wD59E_OnGBCFlag nonzero): switches to VRAM bank 1; for each of the width × height metatiles,
; reads 4 tile IDs per sub-row from the $C0xx block coordinate cache (using H bits 0–1 + $C0 as page),
; looks up the palette attribute for each from $CFxx via B=$CF as page base, and writes the
; 4 attribute bytes to the tilemap. Advances through 4 sub-rows per metatile (+ $1D each),
; wraps L within $E0-aligned blocks, advances HL by $80 per metatile row. Restores VRAM bank 0
; afterward. Both GBC and DMG paths then write the plain tile IDs (4 per sub-row × 4 sub-rows
; per metatile, BC=$1D stride) from the same $C0xx cache to tilemap bank 0. Reads the tilemap
; base address from wD77E/wD77F
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jp   Z, .jp_00_182a
    ld   A, $01
    ldh  [rVBK], A
    ld   HL, wD77E_BlockPatch_TilemapAddrLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   B, $cf
    ld   A, [wD785_BlockPatch_Height]
.jp_00_178f:
    push AF
    push HL
    ld   A, [wD784_BlockPatch_Width]
.jp_00_1794:
    push AF
    push HL
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    and  A, $03
    add  A, $c0
    ld   H, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   DE, $1d
    add  HL, DE
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   DE, $1d
    add  HL, DE
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    ld   DE, $1d
    add  HL, DE
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    inc  L
    inc  E
    ld   C, [HL]
    ld   A, [BC]
    ld   [DE], A
    pop  HL
    ld   A, L
    and  A, $e0
    ld   E, A
    ld   A, L
    add  A, $04
    and  A, $1f
    or   A, E
    ld   L, A
    pop  AF
    dec  A
    jp   NZ, .jp_00_1794
    pop  HL
    ld   DE, $80
    add  HL, DE
    pop  AF
    dec  A
    jp   NZ, .jp_00_178f
    ld   A, $00
    ldh  [rVBK], A
.jp_00_182a:
    ld   HL, wD77E_BlockPatch_TilemapAddrLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   BC, $1d
    ld   A, [wD785_BlockPatch_Height]
.jr_00_1836:
    push AF
    push HL
    ld   A, [wD784_BlockPatch_Width]
.jr_00_183b:
    push AF
    push HL
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    and  A, $03
    add  A, $c0
    ld   H, A
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL]
    ld   [DE], A
    add  HL, BC
    ld   E, L
    ld   A, H
    and  A, $03
    add  A, $98
    ld   D, A
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [HL]
    ld   [DE], A
    pop  HL
    ld   A, L
    and  A, $e0
    ld   E, A
    ld   A, L
    add  A, $04
    and  A, $1f
    or   A, E
    ld   L, A
    pop  AF
    dec  A
    jr   NZ, .jr_00_183b
    pop  HL
    ld   DE, $80
    add  HL, DE
    pop  AF
    dec  A
    jr   NZ, .jr_00_1836
    ret

call_00_18a7_BgMap_ApplyBlockPatchesToRow:
; Reapplies registered block patches to a horizontal ROW strip. Calls
; BgMap_MaskAltBlocksetFlags, then walks the registered patch slots backwards from
; wD778_BlockPatch_SlotWriteHead.
;
; A slot qualifies when its Y (the $CE00 table) equals wD77A_BgMap_ScrollBlockY exactly -
; that is the row being built - and its X (the $CD00 table) is within 6 blocks of
; wD779_BgMap_ScrollBlockX, the width of the strip. Matching slots overwrite the row
; buffer at HL + (X - wD779_BgMap_ScrollBlockX) * 2 with the slot's two patch bytes,
; which live in the parallel $CD80/$CE80 halves of the same tables.
;
; Exact on Y, ranged on X. The column twin below has it exactly the other way round
    call call_00_1e3c_BgMap_MaskAltBlocksetFlags
    ld   A, [wD778_BlockPatch_SlotWriteHead]
    and  A, A
    jr   Z, call_00_1922_BgMap_LoadSecondaryTileset
    dec  A
    ld   E, A
    ld   D, $ce
    ld   A, [wD779_BgMap_ScrollBlockX]
    ld   C, A
    ld   A, [wD77A_BgMap_ScrollBlockY]
    ld   B, A
    push HL
.jr_00_18bd:
    ld   A, [DE]
    cp   A, B
    jr   NZ, .jr_00_18dc
    dec  D
    ld   A, [DE]
    inc  D
    sub  A, C
    cp   A, $06
    jr   NC, .jr_00_18dc
    push HL
    add  A, A
    add  A, L
    ld   L, A
    ld   A, H
    adc  A, $00
    ld   H, A
    set  7, E
    ld   A, [DE]
    ld   [HL+], A
    dec  D
    ld   A, [DE]
    ld   [HL], A
    res  7, E
    inc  D
    pop  HL
.jr_00_18dc:
    dec  E
    bit  7, E
    jr   Z, .jr_00_18bd
    pop  HL
    jr   call_00_1922_BgMap_LoadSecondaryTileset

call_00_18e4_BgMap_ApplyBlockPatchesToColumn:
; The vertical COLUMN twin of the routine above. Same slot walk, mirrored test: a slot
; qualifies when its X (the $CD00 table) equals wD779_BgMap_ScrollBlockX exactly and its Y
; (the $CE00 table) is within 6 blocks of wD77A_BgMap_ScrollBlockY. Matches patch the
; wD70E_BgMap_TempScratchColumnMetaTileIDs buffer at HL+1 + (Y - wD77A_BgMap_ScrollBlockY) * 2.
; Falls through to BgMap_LoadSecondaryTileset
    call call_00_1e3c_BgMap_MaskAltBlocksetFlags
    ld   A, [wD778_BlockPatch_SlotWriteHead]
    and  A, A
    jr   Z, call_00_1922_BgMap_LoadSecondaryTileset
    dec  A
    ld   E, A
    ld   D, $cd
    ld   A, [wD779_BgMap_ScrollBlockX]
    ld   C, A
    ld   A, [wD77A_BgMap_ScrollBlockY]
    ld   B, A
    push HL
.jr_00_18fa:
    ld   A, [DE]
    cp   A, C
    jr   NZ, .jr_00_191a
    inc  D
    ld   A, [DE]
    dec  D
    sub  A, B
    cp   A, $06
    jr   NC, .jr_00_191a
    push HL
    inc  HL
    add  A, A
    add  A, L
    ld   L, A
    ld   A, H
    adc  A, $00
    ld   H, A
    set  7, E
    ld   A, [DE]
    ld   [HL-], A
    inc  D
    ld   A, [DE]
    ld   [HL], A
    res  7, E
    dec  D
    pop  HL
.jr_00_191a:
    dec  E
    bit  7, E
    jr   Z, .jr_00_18fa
    pop  HL
    jr   call_00_1922_BgMap_LoadSecondaryTileset

call_00_1922_BgMap_LoadSecondaryTileset:
; Checks wD60F bit 2 (HDMA active) — returns if set. Advances HL by $0B to reach the tile area
; index within the strip. Looks up the current level ID in .data_00_1a2e_LevelSecondaryTilesetLookups
; to get a per-world data pointer. Reads the first byte (base index C). Scans 6 entries backward
; through the strip (from wD719 downward), checking each non-zero alt blockset byte against the world's
; secondary tileset index table — if a non-null entry is found, checks if its tileset index differs
; from wD72D (current secondary tileset). If different: stores the new index to wD72D, computes the
; tileset address using .data_LevelSecondaryTilesetBankTable (bank + offset per level), stores to
; wD728/wD726. Loads 36 ($24) palette ID bytes into wCF00. If the tileset has animation data
; (wD72F_TilesetAnim_FrameCount nonzero): loads wD738_TilesetAnim_Flags, animation frame pointer, speed wD730_TilesetAnim_FrameIndex–wD735_TilesetAnim_DestAddrHi, pointer to wD736_TilesetAnim_FrameTablePtrLo/wD737_TilesetAnim_FrameTablePtrHi.
; Sets bit 2 of wD60F to trigger HDMA transfer. Calls MediaDimension_LoadActiveTVPalette
    ld   A, [wD60F_GfxTransferFlags]
    bit  2, A
    ret  NZ
    ld   DE, $0b
    add  HL, DE
    push HL
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   BC, .data_00_1a2e_LevelSecondaryTilesetLookups
    add  HL, BC
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   A, [HL+]                                      ; load first value from the Level's data table
    ld   C, A                                          ; c = a
    ld   E, L
    ld   D, H                                          ; de = hl
    pop  HL                                            ; hl = d719
    ld   B, $06
.jr_00_1942: ; loading a value written from 3435 bank
    ld   A, [HL-]
    and  A, A
    jr   Z, .jr_00_1954                                ; jmp if 0
    ld   A, [HL]                                       ; go here if not 0
    sub  A, C
    jr   C, .jr_00_1954
    push HL
    ld   L, A
    ld   H, $00
    add  HL, DE
    ld   A, [HL]
    pop  HL
    and  A, A
    jr   NZ, .jr_00_1959                               ; perform this jump if going to load new secondary tileset
.jr_00_1954:
    dec  HL
    dec  B
    jr   NZ, .jr_00_1942                               ; looping over d719, d717,  looking for  non-zero value
    ret
.jr_00_1959:
    dec  A
    ld   HL, wD72D_SecondaryTilesetIndex
    cp   A, [HL]
    ret  Z                                             ; return if the secondary tileset is already the current one
    ld   [HL], A
    ld   C, A
    add  A, A
    add  A, C
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_LevelSecondaryTilesetBankTable
    add  HL, DE
    add  A, [HL]
    ld   [wD728_SecondaryTilesetAddr], A
    inc  HL
    ld   A, [HL]
    ld   [wD726_SecondaryTilesetBank], A
    ld   [wD72E_TilesetAnim_Bank], A
    call call_00_1089_SwitchBank
    xor  A, A
    ld   [wD727_SecondaryTileset_SrcAddrLo], A
    ld   A, $00
    ld   [wD729_SecondaryTileset_DestAddrLo], A
    ld   A, $90
    ld   [wD72A_SecondaryTileset_DestAddrHi], A
    ld   A, $40
    ld   [wD72B_SecondaryTileset_RowsPerPage], A
    ld   A, $02
    ld   [wD72C_SecondaryTileset_PagesRemaining], A
    ld   HL, wD727_SecondaryTileset_SrcAddrLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, $240
    add  HL, DE
    ld   DE, wCF00_TilesetPaletteIds
    ld   B, $24
.jr_00_19a4:
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    dec  B
    jr   NZ, .jr_00_19a4
    ld   A, [HL+]
    ld   [wD72F_TilesetAnim_FrameCount], A
    and  A, A
    jr   Z, .jr_00_19dc
    ld   A, [HL+]
    ld   [wD738_TilesetAnim_Flags], A
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    inc  HL
    and  A, $01
    jr   Z, .jr_00_19be
    ld   A, [DE]
.jr_00_19be:
    ld   [wD730_TilesetAnim_FrameIndex], A
    ld   A, [HL+]
    ld   [wD731_TilesetAnim_DelayReload], A
    ld   [wD732_TilesetAnim_DelayCounter], A
    ld   A, [HL+]
    ld   [wD733_TilesetAnim_RowsPerFrame], A
    ld   A, [HL+]
    ld   [wD734_TilesetAnim_DestAddrLo], A
    ld   A, [HL+]
    ld   [wD735_TilesetAnim_DestAddrHi], A
    ld   A, L
    ld   [wD736_TilesetAnim_FrameTablePtrLo], A
    ld   A, H
    ld   [wD737_TilesetAnim_FrameTablePtrHi], A
.jr_00_19dc:
    ld   HL, wD60F_GfxTransferFlags
    set  2, [HL]
    call call_00_10a3_RestoreBank
    FARCALL call_0b_5df8_MediaDimension_LoadActiveTVPalette
    ret
.data_LevelSecondaryTilesetBankTable:
; 62-byte table (31 levels × 2 bytes): each pair is (base offset byte, bank number) for the level's secondary
; tileset data. Used by LoadSecondaryTileset to compute the ROM address of the secondary tileset
    farpointer2 media_dimension_secondary_tilesets       ; MAP_MEDIA_DIMENSION
    farpointer2 toon_tv_secondary_tilesets               ; MAP_TOON_TV_OUT_OF_TOON
    farpointer2 scream_tv_secondary_tilesets             ; MAP_SCREAM_TV_SMELLRAISER
    farpointer2 scream_tv_secondary_tilesets             ; MAP_SCREAM_TV_FRANKENSTEINFELD
    farpointer2 circuit_central_secondary_tilesets       ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    farpointer2 kung_fu_theater_secondary_tilesets       ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_06
    farpointer2 prehistory_channel_secondary_tilesets    ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    farpointer2 toon_tv_secondary_tilesets               ; MAP_TOON_TV_FINE_TOONING
    farpointer2 prehistory_channel_secondary_tilesets    ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    farpointer2 circuit_central_secondary_tilesets       ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    farpointer2 scream_tv_secondary_tilesets             ; MAP_SCREAM_TV_POLTERGEX
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_0C
    farpointer2 kung_fu_theater_secondary_tilesets       ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    farpointer2 rezopolis_secondary_tilesets             ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_0F
    farpointer2 scream_tv_secondary_tilesets             ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_11
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_12
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_13
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_14
    farpointer2 kung_fu_theater_secondary_tilesets       ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    farpointer2 rezopolis_secondary_tilesets             ; MAP_REZOPOLIS_BUGGED_OUT
    farpointer2 circuit_central_secondary_tilesets       ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    farpointer2 prehistory_channel_secondary_tilesets    ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    farpointer2 scream_tv_secondary_tilesets             ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    farpointer2 rezopolis_secondary_tilesets             ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_1B
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_1C
    farpointer2 media_dimension_secondary_tilesets       ; MAP_UNUSED_1D
    farpointer2 channel_z_secondary_tilesets             ; MAP_BOSS_TV_CHANNEL_Z
.data_00_1a2e_LevelSecondaryTilesetLookups:
; One pointer per level to that world's block -> secondary tileset lookup below.
; Levels sharing a world theme share a pointer, so there are 31 entries but only
; eight tables: Media Dimension, Toon TV, Scream TV, Circuit Central, Kung Fu
; Theater, Prehistory Channel, Rezopolis, Channel Z.
;
; Each table is:
;   byte 0    base block id
;   byte 1+   indexed by (block id - base), giving a secondary tileset index,
;             or $00 for a block that needs no secondary tileset
;
; It holds no graphics of its own. call_00_1922_BgMap_LoadSecondaryTileset walks the
; six blocks of the strip just loaded, and for each one whose alt blockset flag is
; set, looks its id up here; a nonzero answer that differs from
; wD72D_SecondaryTilesetIndex is what triggers the HDMA stream of a new secondary
; tileset. The tileset graphics themselves are reached through the separate
; farpointer2 table above
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_MEDIA_DIMENSION
    dw   .secondary_tileset_for_block_toon_tv               ; MAP_TOON_TV_OUT_OF_TOON
    dw   .secondary_tileset_for_block_scream_tv             ; MAP_SCREAM_TV_SMELLRAISER
    dw   .secondary_tileset_for_block_scream_tv             ; MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .secondary_tileset_for_block_circuit_central       ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .secondary_tileset_for_block_kung_fu_theater       ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_06
    dw   .secondary_tileset_for_block_prehistory_channel    ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .secondary_tileset_for_block_toon_tv               ; MAP_TOON_TV_FINE_TOONING
    dw   .secondary_tileset_for_block_prehistory_channel    ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .secondary_tileset_for_block_circuit_central       ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .secondary_tileset_for_block_scream_tv             ; MAP_SCREAM_TV_POLTERGEX
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_0C
    dw   .secondary_tileset_for_block_kung_fu_theater       ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .secondary_tileset_for_block_rezopolis             ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_0F
    dw   .secondary_tileset_for_block_scream_tv             ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_11
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_12
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_13
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_14
    dw   .secondary_tileset_for_block_kung_fu_theater       ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .secondary_tileset_for_block_rezopolis             ; MAP_REZOPOLIS_BUGGED_OUT
    dw   .secondary_tileset_for_block_circuit_central       ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .secondary_tileset_for_block_prehistory_channel    ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .secondary_tileset_for_block_scream_tv             ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .secondary_tileset_for_block_rezopolis             ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_1B
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_1C
    dw   .secondary_tileset_for_block_media_dimension       ; MAP_UNUSED_1D
    dw   .secondary_tileset_for_block_channel_z             ; MAP_BOSS_TV_CHANNEL_Z
.secondary_tileset_for_block_media_dimension:
    INCBIN "data/maps/media_dimension/secondary_tileset_for_block_media_dimension.bin"
.secondary_tileset_for_block_toon_tv:
    INCBIN "data/maps/toon_tv/secondary_tileset_for_block_toon_tv.bin"
.secondary_tileset_for_block_scream_tv:
    INCBIN "data/maps/scream_tv/secondary_tileset_for_block_scream_tv.bin"
.secondary_tileset_for_block_circuit_central:
    INCBIN "data/maps/circuit_central/secondary_tileset_for_block_circuit_central.bin"
.secondary_tileset_for_block_kung_fu_theater:
    INCBIN "data/maps/kung_fu_theater/secondary_tileset_for_block_kung_fu_theater.bin"
.secondary_tileset_for_block_prehistory_channel:
    INCBIN "data/maps/prehistory_channel/secondary_tileset_for_block_prehistory_channel.bin"
.secondary_tileset_for_block_rezopolis:
    INCBIN "data/maps/rezopolis/secondary_tileset_for_block_rezopolis.bin"
.secondary_tileset_for_block_channel_z:
    INCBIN "data/maps/channel_z/secondary_tileset_for_block_channel_z.bin"

call_00_1e3c_BgMap_MaskAltBlocksetFlags:
; Reads wD6FE_BgMap_AltBlocksetMask into C. Masks 6 consecutive bytes at HL+1 through HL+6 each with
; AND C in place. The 6 bytes are the alt blockset flags in the horizontal/vertical
; strip buffer (alternating bytes at wD703_BgMap_TempScratchRowAltBlocksetFlags/wD705/... or
; wD70F_BgMap_TempScratchColumnAltBlocksetFlags/... depending on caller).
; Effectively zeroes the alt blockset layer for levels whose mask has that layer's bit clear
    push HL
    ld   A, [wD6FE_BgMap_AltBlocksetMask]
    ld   C, A
    inc  HL
    ld   A, [HL]
    and  A, C
    ld   [HL+], A
    inc  HL
    ld   A, [HL]
    and  A, C
    ld   [HL+], A
    inc  HL
    ld   A, [HL]
    and  A, C
    ld   [HL+], A
    inc  HL
    ld   A, [HL]
    and  A, C
    ld   [HL+], A
    inc  HL
    ld   A, [HL]
    and  A, C
    ld   [HL+], A
    inc  HL
    ld   A, [HL]
    and  A, C
    ld   [HL], A
    pop  HL
    ret

call_00_1e5b_BlockPatch_TickSequence:
; Per-frame driver for block patch animations. Decrements wD786_BlockPatch_StepTimer if nonzero.
; Returns early if wD77B_BlockPatch_VramWritePending is set (VRAM write not yet flushed by VBLANK)
; or if timer is still nonzero. Otherwise reloads timer from wD787_BlockPatch_StepTimerReload and
; re-enters the step loop (.jr_00_1e6f). Decrements wD77D_BlockPatch_StepsRemaining;
; returns if now zero. Dereferences wD780/wD781 as a pointer into the script and reads the step's
; flag byte into wD77C_BlockPatch_StepFlags. If bit 5 set: reads a bank argument byte and calls
; call_00_113e_PlaySFX (farcall dispatcher — used to play a SFX or trigger an effect mid-sequence). Saves
; updated pointer back to wD780/wD781.
; Dispatches on remaining flag bits:
; bit 1 → BgMap_UpdateCollisionFlags;
; bit 2 → BlockPatch_WriteCollision;
; bit 3 → BlockPatch_WriteTiles.
; Advances wD780/wD781 forward by width × height × 2 bytes (the size of one frame's tile data block).
; If bit 0 set, loops back immediately to process the next step without waiting for the next frame
    ld   HL, wD786_BlockPatch_StepTimer
    ld   A, [HL]
    and  A, A
    jr   Z, .jr_00_1e63
    dec  [HL]
.jr_00_1e63:
    ld   A, [wD77B_BlockPatch_VramWritePending]
    and  A, A
    ret  NZ
    ld   A, [HL]
    and  A, A
    ret  NZ
    ld   A, [wD787_BlockPatch_StepTimerReload]
    ld   [HL], A
.jr_00_1e6f:
    ld   HL, wD77D_BlockPatch_StepsRemaining
    ld   A, [HL]
    and  A, A
    ret  Z
    dec  [HL]
    ld   HL, wD780_BlockPatch_DataPtrLo
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   A, [HL+]
    ld   [wD77C_BlockPatch_StepFlags], A
    bit  BLOCKPATCH_STEP_SFX_BIT, A
    jr   Z, .jr_00_1e8a
    ld   A, [HL+]
    push HL
    call call_00_113e_PlaySFX
    pop  HL
.jr_00_1e8a:
    ld   A, L
    ld   [wD780_BlockPatch_DataPtrLo], A
    ld   A, H
    ld   [wD781_BlockPatch_DataPtrHi], A
    ld   HL, wD77C_BlockPatch_StepFlags
    bit  BLOCKPATCH_STEP_REGISTER_BIT, [HL]
    call NZ, call_00_1ec9_BlockPatch_Register
    ld   HL, wD77C_BlockPatch_StepFlags
    bit  BLOCKPATCH_STEP_COLLISION_BIT, [HL]
    call NZ, call_00_1f05_BlockPatch_WriteCollision
    ld   HL, wD77C_BlockPatch_StepFlags
    bit  BLOCKPATCH_STEP_TILES_BIT, [HL]
    call NZ, call_00_169f_BlockPatch_WriteTiles
    ld   HL, wD785_BlockPatch_Height
    ld   B, [HL]
    ld   HL, wD784_BlockPatch_Width
    ld   C, [HL]
    xor  A, A
.jr_00_1eb3:
    add  A, C
    dec  B
    jr   NZ, .jr_00_1eb3
    add  A, A
    ld   HL, wD780_BlockPatch_DataPtrLo
    add  A, [HL]
    ld   [HL+], A
    ld   A, $00
    adc  A, [HL]
    ld   [HL], A
    ld   HL, wD77C_BlockPatch_StepFlags
    bit  BLOCKPATCH_STEP_LOOP_BIT, [HL]
    jr   NZ, .jr_00_1e6f
    ret

call_00_1ec9_BlockPatch_Register:
; Registers a rectangular block patch region into the wCE00/wCD00 block coordinate tables and
; advances wD778_BlockPatch_SlotWriteHead. Reads starting block coordinates from
; wD782_BlockPatch_TargetBlockX/wD783_BlockPatch_TargetBlockY into C/B. Reads the data pointer from
; wD780/wD781 into DE. Sets HL = $CE00 + slot index from wD778. For each cell in the width × height
; rectangle: writes B (current Y block coord) to $CE[slot], writes C (current X block coord) to $CD[slot],
; then reads the cell's 2 bytes from DE and writes them to $CF[slot] and $CC[slot] - the `set 7,L` /
; `dec H` pair walks between the four parallel $CC/$CD/$CE/$CF tables that together hold one patch
; entry. C is bumped per column and B per row, so each cell is registered under its own map
; coordinates.
;
; This is the step that makes a change PERMANENT: BlockPatch_WriteTiles only paints the tilemap, whereas
; this records what the region should look like so the strip loaders
; (BgMap_ApplyBlockPatchesToRow and its column twin) can reapply it when the camera
; scrolls the area back into view. That is why sequences set BLOCKPATCH_STEP_REGISTER on their final
; step only - the intermediate animation frames are not meant to survive
    ld   HL, wD782_BlockPatch_TargetBlockX
    ld   C, [HL]
    ld   HL, wD783_BlockPatch_TargetBlockY
    ld   B, [HL]
    ld   HL, wD780_BlockPatch_DataPtrLo
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   HL, wD778_BlockPatch_SlotWriteHead
    ld   L, [HL]
    ld   H, $ce
    ld   A, [wD785_BlockPatch_Height]
.jr_00_1ee0:
    push AF
    push BC
    ld   A, [wD784_BlockPatch_Width]
.jr_00_1ee5:
    push AF
    ld   [HL], B                                       ; updated CE00 bgtile flags
    set  7, L
    ld   A, [DE]
    ld   [HL], A
    inc  DE
    dec  H
    ld   A, [DE]
    ld   [HL], A
    inc  DE
    res  7, L
    ld   [HL], C                                       ; updated CD00 bgtile flags
    inc  H
    inc  L
    inc  C
    pop  AF
    dec  A
    jr   NZ, .jr_00_1ee5
    pop  BC
    inc  B
    pop  AF
    dec  A
    jr   NZ, .jr_00_1ee0
    ld   A, L
    ld   [wD778_BlockPatch_SlotWriteHead], A
    ret

call_00_1f05_BlockPatch_WriteCollision:
; Searches the $CD00/$CE00 tables backward from wD778_BlockPatch_SlotWriteHead for a slot
; whose X byte ($CD[slot]) matches wD782_BlockPatch_TargetBlockX and whose Y byte ($CE[slot])
; matches wD783_BlockPatch_TargetBlockY. Stops when L wraps past bit 7 (scanned all slots).
; On match: switches to $CE00 page with bit 7 of L set, then copies width × height × 2 bytes
; from wD780/wD781 data pointer into the matched slot range in `$CE[slot
    ld   HL, wD782_BlockPatch_TargetBlockX
    ld   C, [HL]
    ld   HL, wD783_BlockPatch_TargetBlockY
    ld   B, [HL]
    ld   HL, wD780_BlockPatch_DataPtrLo
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   HL, wD778_BlockPatch_SlotWriteHead
    ld   L, [HL]
    dec  L
    ld   H, $cd
.jr_00_1f1a:
    ld   A, [HL]
    cp   A, C
    jr   NZ, .jr_00_1f24
    inc  H
    ld   A, [HL]
    cp   A, B
    jr   Z, .jr_00_1f2a
    dec  H
.jr_00_1f24:
    dec  L
    bit  7, L
    jr   Z, .jr_00_1f1a
    ret
.jr_00_1f2a:
    set  7, L
    ld   H, $ce
    ld   A, [wD785_BlockPatch_Height]
    ld   B, A
.jr_00_1f32:
    ld   A, [wD784_BlockPatch_Width]
    ld   C, A
.jr_00_1f36:
    ld   A, [DE]
    ld   [HL], A
    inc  DE
    dec  H
    ld   A, [DE]
    ld   [HL], A
    inc  DE
    inc  H
    inc  L
    dec  C
    jr   NZ, .jr_00_1f36
    dec  B
    jr   NZ, .jr_00_1f32
    ret
