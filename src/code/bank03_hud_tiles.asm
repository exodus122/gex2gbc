call_03_66ae_HUD_LoadTiles:
; Top-level HUD tile loader. Copies .image_03_66e1 ($140 bytes) to VRAM $8600 (main HUD graphics),
; calls call_03_6d13_HUD_LoadLivesDigits (lives digits) and call_03_6941_HUD_LoadCollectibleSprites (collectible icon). Then conditionally loads
; either the "DEMO MODE" banner tiles to $8680 if demo mode is active, or if wD623_CollectibleMode is set (timer mode),
; loads the timer's colon glyph (two tiles, $20 bytes, via VRAM_Copy32Bytes) and jumps to
; call_03_6ceb_HUD_LoadTimerDigits.
;
; Note demo mode and timer mode share the same VRAM slot, VRAM_HUD_DEMO_MODE_OR_TIMER - the
; banner and the clock can never be on screen together
    ld   HL, .image_03_66e1
    ld   DE, VRAM_HUD_TILES
    ld   BC, $140
    call call_00_07b0_MemCopy
    call call_03_6d13_HUD_LoadLivesDigits
    call call_03_6941_HUD_LoadCollectibleSprites
    ld   HL, .image_demo_mode_03_6821
    ld   DE, VRAM_HUD_DEMO_MODE_OR_TIMER
    ld   BC, $100
    ld   A, [wD61E_DemoModeEnabled]
    and  A, A
    jp   NZ, call_00_07b0_MemCopy
    ld   A, [wD623_CollectibleMode]
    and  A, A
    ret  Z
    ld   HL, .image_colon_03_6921
    ld   DE, VRAM_HUD_DEMO_MODE_OR_TIMER
    call call_03_6efd_VRAM_Copy32Bytes
    jp   call_03_6ceb_HUD_LoadTimerDigits
.image_03_66e1:
    INCBIN ".gfx/misc_sprites/image_003_66e1.bin"
.image_demo_mode_03_6821:
    INCBIN ".gfx/misc_sprites/image_demo_mode_003_6821.bin"
.image_colon_03_6921:
    INCBIN ".gfx/misc_sprites/image_colon_003_6921.bin"

call_03_6941_HUD_LoadCollectibleSprites:
; Loads the collectible sprite tiles for the current level. Calls call_03_6be5_HUD_LoadCollectiblePalette first (to set up the palette).
; Uses wD624 (level ID) to index .data_image_collectibles_03_6967 — a 31-entry pointer table mapping each
; level to one of 6 world-specific collectible tile sets (Toon TV, Scream TV, Circuit Central, Kung Fu Theater,
;  Prehistory Channel, Rezopolis). Then uses wD648_CollectibleMilestoneIndex (collectible type index, swap-shifted) as a sub-index
; within that set to select the specific tile frame, and copies TWO tiles ($20 bytes) to VRAM $87E0
; via VRAM_Copy32Bytes - the collectible icon is an 8x16 sprite, so it is two tiles, not the one
; collectible icon is an 8x16 sprite.
;
; Also clears HUD_DIRTY_COLLECTIBLES (bit 3 of wD60E_HUDDirtyFlags) on entry, which the old
; comment did not mention - this is the routine that services that dirty flag
    ld   HL, wD60E_HUDDirtyFlags
    res  3, [HL]
    call call_03_6be5_HUD_LoadCollectiblePalette
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_image_collectibles_03_6967
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   A, [wD648_CollectibleMilestoneIndex]
    swap A
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, DE
    ld   DE, VRAM_COLLECTIBLE_SPRITES
    jp   call_03_6efd_VRAM_Copy32Bytes
.data_image_collectibles_03_6967:
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_MEDIA_DIMENSION
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_TOON_TV_OUT_OF_TOON
    dw   .image_collectibles_scream_tv_003_6a05           ; MAP_SCREAM_TV_SMELLRAISER
    dw   .image_collectibles_scream_tv_003_6a05           ; MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .image_collectibles_circuit_central_003_6a65     ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .image_collectibles_kung_fu_theater_003_6ac5     ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_06
    dw   .image_collectibles_prehistory_channel_003_6b25  ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_TOON_TV_FINE_TOONING
    dw   .image_collectibles_prehistory_channel_003_6b25  ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .image_collectibles_circuit_central_003_6a65     ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .image_collectibles_scream_tv_003_6a05           ; MAP_SCREAM_TV_POLTERGEX
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_0C
    dw   .image_collectibles_kung_fu_theater_003_6ac5     ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .image_collectibles_rezopolis_003_6b85           ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_0F
    dw   .image_collectibles_scream_tv_003_6a05           ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_11
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_12
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_13
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_14
    dw   .image_collectibles_kung_fu_theater_003_6ac5     ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .image_collectibles_rezopolis_003_6b85           ; MAP_REZOPOLIS_BUGGED_OUT
    dw   .image_collectibles_circuit_central_003_6a65     ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .image_collectibles_prehistory_channel_003_6b25  ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .image_collectibles_scream_tv_003_6a05           ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .image_collectibles_rezopolis_003_6b85           ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_1B
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_1C
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_UNUSED_1D
    dw   .image_collectibles_toon_tv_003_69a5             ; MAP_BOSS_TV_CHANNEL_Z
.image_collectibles_toon_tv_003_69a5:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_toon_tv.bin"
.image_collectibles_scream_tv_003_6a05:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_scream_tv.bin"
.image_collectibles_circuit_central_003_6a65:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_circuit_central.bin"
.image_collectibles_kung_fu_theater_003_6ac5:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_kung_fu_theater.bin"
.image_collectibles_prehistory_channel_003_6b25:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_prehistory_channel.bin"
.image_collectibles_rezopolis_003_6b85:
    INCBIN ".gfx/misc_sprites/collectibles/image_collectibles_rezopolis.bin"

call_03_6be5_HUD_LoadCollectiblePalette:
; Loads the GBC palette for the collectible icon into wDA13_EntityPalettes_Slot1 (8 bytes = 4 colors × 2 bytes).
; Returns immediately if wD59E_OnGBCFlag is zero (mono/non-GBC mode). Uses wD624 (level ID) to index
; .data_03_6c1d_collectible_palettes for a world-specific palette pointer, then uses wD648_CollectibleMilestoneIndex × 8
; as a sub-index to select the specific color entry within that palette block, copying 8 bytes to wDA13_EntityPalettes_Slot1
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ret  Z
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_03_6c1d_collectible_palettes
    add  HL, DE
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   HL, wD648_CollectibleMilestoneIndex
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    add  HL, DE
    ld   DE, wDA13_EntityPalettes_Slot1
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL+]
    ld   [DE], A
    inc  DE
    ld   A, [HL]
    ld   [DE], A
    ret
.data_03_6c1d_collectible_palettes:
    dw   .palette_toon_tv_collectibles             ; MAP_MEDIA_DIMENSION
    dw   .palette_toon_tv_collectibles             ; MAP_TOON_TV_OUT_OF_TOON
    dw   .palette_scream_tv_collectibles           ; MAP_SCREAM_TV_SMELLRAISER
    dw   .palette_scream_tv_collectibles           ; MAP_SCREAM_TV_FRANKENSTEINFELD
    dw   .palette_circuit_central_collectibles     ; MAP_CIRCUIT_CENTRAL_WWWDOTCOMCOM
    dw   .palette_kung_fu_theater_collectibles     ; MAP_KUNG_FU_THEATER_MAO_TSE_TONGUE
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_06
    dw   .palette_prehistory_channel_collectibles  ; MAP_PRE_HISTORY_CHANNEL_PANGAEA_90210
    dw   .palette_toon_tv_collectibles             ; MAP_TOON_TV_FINE_TOONING
    dw   .palette_prehistory_channel_collectibles  ; MAP_PRE_HISTORY_CHANNEL_THIS_OLD_CAVE
    dw   .palette_circuit_central_collectibles     ; MAP_CIRCUIT_CENTRAL_HONEY_I_SHRUNK_THE_GECKO
    dw   .palette_scream_tv_collectibles           ; MAP_SCREAM_TV_POLTERGEX
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_0C
    dw   .palette_kung_fu_theater_collectibles     ; MAP_KUNG_FU_THEATER_SAMURAI_NIGHT_FEVER
    dw   .palette_rezopolis_collectibles           ; MAP_REZOPOLIS_NO_WEDDINGS_AND_A_FUNERAL
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_0F
    dw   .palette_scream_tv_collectibles           ; MAP_SCREAM_TV_THURSDAY_THE_12TH
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_11
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_12
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_13
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_14
    dw   .palette_kung_fu_theater_collectibles     ; MAP_KUNG_FU_THEATER_LIZARD_IN_A_CHINA_SHOP
    dw   .palette_rezopolis_collectibles           ; MAP_REZOPOLIS_BUGGED_OUT
    dw   .palette_circuit_central_collectibles     ; MAP_CIRCUIT_CENTRAL_CHIPS_AND_DIPS
    dw   .palette_prehistory_channel_collectibles  ; MAP_PRE_HISTORY_CHANNEL_LAVA_DABBA_DOO
    dw   .palette_scream_tv_collectibles           ; MAP_SCREAM_TV_TEXAS_CHAINSAW_MANICURE
    dw   .palette_rezopolis_collectibles           ; MAP_REZOPOLIS_MAZED_AND_CONFUSED
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_1B
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_1C
    dw   .palette_toon_tv_collectibles             ; MAP_UNUSED_1D
    dw   .palette_toon_tv_collectibles             ; MAP_BOSS_TV_CHANNEL_Z
.palette_toon_tv_collectibles:
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_toon_tv_collectibles.bin"
.palette_scream_tv_collectibles:
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_scream_tv_collectibles.bin"
.palette_circuit_central_collectibles:
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_circuit_central_collectibles.bin"
.palette_kung_fu_theater_collectibles:
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_kung_fu_theater_collectibles.bin"
.palette_prehistory_channel_collectibles:
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_prehistory_channel_collectibles.bin"
.palette_rezopolis_collectibles:
    INCBIN "gfx/misc_sprites/collectibles/palettes/palette_rezopolis_collectibles.bin"

call_03_6ceb_HUD_LoadTimerDigits:
; Loads the bonus level countdown timer digits. Clears bit 2 of wD60E_HUDDirtyFlags.
; Reads wD76F_LevelTimer_Minutes (minutes), wD770_LevelTimer_SecondsBCD high nibble (tens of seconds),
; and wD770_LevelTimer_SecondsBCD low nibble (seconds), calling call_03_6d88_HUD_LoadDigitTile for each to write digit tiles to VRAM $8748, $8768,
; $8788 respectively. Falls through to call_03_6d5e_HUD_LoadCollectibleCountDigits to also load the collectible count digits
    ld   HL, wD60E_HUDDirtyFlags
    res  2, [HL]
    ld   A, [wD76F_LevelTimer_Minutes]
    ld   DE, VRAM_DIGIT_HUNDREDS
    call call_03_6d88_HUD_LoadDigitTile
    ld   A, [wD770_LevelTimer_SecondsBCD]
    swap A
    and  A, $0f
    ld   DE, VRAM_DIGIT_TENS
    call call_03_6d88_HUD_LoadDigitTile
    ld   A, [wD770_LevelTimer_SecondsBCD]
    and  A, $0f
    ld   DE, VRAM_DIGIT_ONES
    call call_03_6d88_HUD_LoadDigitTile
    jr   call_03_6d5e_HUD_LoadCollectibleCountDigits

call_03_6d13_HUD_LoadLivesDigits:
; Loads the lives counter display tiles. Clears bit 1 of wD60E_HUDDirtyFlags. Decomposes wD73D (lives remaining)
; into hundreds/tens/ones digits stored in wD73E/wD73F/wD740 using repeated subtraction. Calls
; call_03_6d88_HUD_LoadDigitTile for each digit to write tiles to VRAM $8748/$8768/$8788. Falls through to call_03_6d5e_HUD_LoadCollectibleCountDigits
; to load the collectible count
    ld   HL, wD60E_HUDDirtyFlags
    res  1, [HL]
    ld   HL, wD73E_LivesRemaining_Hundreds
    ld   A, $0a
    ld   [HL+], A
    ld   [HL+], A
    ld   [HL-], A
    dec  HL
    ld   A, [wD73D_LivesRemaining]
    cp   A, $64
    jr   NC, .jr_03_6d2e
    cp   A, $0a
    jr   NC, .jr_03_6d38
    jr   .jr_03_6d42
.jr_03_6d2e:
    ld   [HL], $ff
.jr_03_6d30:
    inc  [HL]
    sub  A, $64
    jr   NC, .jr_03_6d30
    add  A, $64
    inc  HL
.jr_03_6d38:
    ld   [HL], $ff
.jr_03_6d3a:
    inc  [HL]
    sub  A, $0a
    jr   NC, .jr_03_6d3a
    add  A, $0a
    inc  HL
.jr_03_6d42:
    ld   [HL], A
    ld   A, [wD73E_LivesRemaining_Hundreds]
    ld   DE, VRAM_DIGIT_HUNDREDS
    call call_03_6d88_HUD_LoadDigitTile
    ld   A, [wD73F_LivesRemaining_Tens]
    ld   DE, VRAM_DIGIT_TENS
    call call_03_6d88_HUD_LoadDigitTile
    ld   A, [wD740_LivesRemaining_Ones]
    ld   DE, VRAM_DIGIT_ONES
    call call_03_6d88_HUD_LoadDigitTile

call_03_6d5e_HUD_LoadCollectibleCountDigits:
; Shared tail of both the lives and timer loaders: redraws the two collectible-count
; digits, which sit in the HUD's last two digit slots and are not shared with anything.
;
; wD649_CollectibleAmount is split by repeated subtraction of 10 into
; wD64A_HUD_CollectibleCountTens and wD64B_HUD_CollectibleCountOnes, then each is handed
; to call_03_6d88_HUD_LoadDigitTile.
;
; Both digit bytes are preloaded with $0A first. That is one past the last real digit and
; selects the eleventh glyph in the font, which is blank - so a count under ten simply
; skips the tens byte and leaves the blank in place. Leading-zero suppression with no
; branch to do it
    ld   HL, wD64A_HUD_CollectibleCountTens
    ld   A, $0a
    ld   [HL+], A
    ld   [HL-], A
    ld   A, [wD649_CollectibleAmount]
    cp   A, $0a
    jr   C, .jr_03_6d76
    ld   [HL], $ff
.jr_03_6d6e:
    inc  [HL]
    sub  A, $0a
    jr   NC, .jr_03_6d6e
    add  A, $0a
    inc  HL
.jr_03_6d76:
    ld   [HL], A
    ld   A, [wD64A_HUD_CollectibleCountTens]
    ld   DE, VRAM_DIGIT_COLLECTIBLE_TENS
    call call_03_6d88_HUD_LoadDigitTile
    ld   A, [wD64B_HUD_CollectibleCountOnes]
    ld   DE, VRAM_DIGIT_COLLECTIBLE_ONES
    jr   call_03_6d88_HUD_LoadDigitTile

call_03_6d88_HUD_LoadDigitTile:
; Core digit tile writer. Takes a glyph index in A (0-9, or $0A for the blank) and a VRAM
; destination in DE.
; Swap-shifts A to use as an index, selects either .numbers_003_6d9d or .numbers_003_6e4d
; (alternate digit font, based on wD623_CollectibleMode timer-mode flag), adds to get the correct tile data pointer,
; and copies 16 bytes (2 tiles = one digit glyph) to VRAM via VRAM_Copy16Bytes
    swap A
    ld   L, A
    ld   H, $00
    ld   BC, .numbers_003_6d9d
    ld   A, [wD623_CollectibleMode]
    and  A, A
    jr   Z, .jr_03_6d99
    ld   BC, .numbers_003_6e4d
.jr_03_6d99:
    add  HL, BC
    jp   call_03_6f2d_VRAM_Copy16Bytes
.numbers_003_6d9d:
    INCBIN ".gfx/misc_sprites/numbers_003_6d9d.bin"
.numbers_003_6e4d:
    INCBIN ".gfx/misc_sprites/numbers_003_6e4d.bin"
