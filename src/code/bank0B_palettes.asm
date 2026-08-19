call_0b_5537_BgPalette_LoadMonoOrGetSpriteParams:
; Mono-mode (DMG) background palette loader, or sprite params setter in GBC mode.
; If wD59E_OnGBCFlag is zero (DMG): loads wD624 (level ID) to index either .data_0b_555f (C=0, primary BG)
; or .data_0b_55db (C≠0, secondary BG), copies 3 bytes into wDAD1_LevelBGP–wDAD3_LevelOBP1 (DMG palette register values).
; If GBC (wD59E_OnGBCFlag nonzero), branches to call_0b_561b_GBC_LoadLevelBgPalette
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jp   NZ, call_0b_561b_GBC_LoadLevelBgPalette
    ld   A, [wD624_CurrentLevelId]
    ld   DE, .data_0b_555f
    inc  C
    dec  C
    jr   Z, .jr_0b_554c
    ld   A, C
    ld   DE, .data_0b_55db
.jr_0b_554c:
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, DE
    ld   A, [HL+]
    ld   [wDAD1_LevelBGP], A
    ld   A, [HL+]
    ld   [wDAD2_LevelOBP0], A
    ld   A, [HL+]
    ld   [wDAD3_LevelOBP1], A
    ret
.data_0b_555f:
    db   $1b, $1f, $1f, $00, $e4, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $e4, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00, $1b, $1f, $1f, $00
    db   $1b, $1f, $1f, $00
.data_0b_55db:
    db   $00, $00, $00, $00, $1b, $1b, $1b, $00
    db   $1b, $1b, $1b, $00, $1b, $1b, $ff, $00
    db   $1b, $1b, $1b, $00, $1b, $1b, $1b, $00
    db   $1b, $1b, $1b, $00, $1b, $1b, $1b, $00
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00
    db   $e4, $e4, $24, $00, $e4, $e4, $24, $00
    db   $e4, $e4, $24, $00, $00, $00, $00, $00

call_0b_561b_GBC_LoadLevelBgPalette:
; GBC background palette loader. If C=0 (main gameplay): uses wD624 (level ID) to index
; .data_0b_5665_LevelBgPalettePointerTable (64 bytes = 8 palettes × 4 colors × 2 bytes each), copies
; to wD9CB (BG palette buffer). Calls call_0b_5df8_MediaDimension_LoadActiveTVPalette (Media
; Dimension TV palette overlay), then copies .data_gex_entity_palette2 (8 bytes) to wDA0B (OBJ
; palette 0), then calls HUD_LoadCollectiblePalette. If C≠0 (menu/cutscene): uses C as index
; into .data_0b_56a3_MenuPalettePointerTable (menu palette pointer table), copies 128 bytes to wD9CB
    inc  C
    dec  C
    jr   NZ, .jr_0b_5651
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_0b_5665_LevelBgPalettePointerTable
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, wD9CB_Bg_Palettes
    ld   BC, $40
    call call_00_07b0_MemCopy
    call call_0b_5df8_MediaDimension_LoadActiveTVPalette
    ld   HL, .data_gex_entity_palette2
    ld   DE, wDA0B_Entity_Palettes
    ld   BC, $08
    call call_00_07b0_MemCopy
    FARCALL call_03_6be5_HUD_LoadCollectiblePalette
    ret
.jr_0b_5651:
    ld   L, C
    ld   H, $00
    add  HL, HL
    ld   DE, .data_0b_56a3_MenuPalettePointerTable
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, wD9CB_Bg_Palettes
    ld   BC, $80
    jp   call_00_07b0_MemCopy
.data_0b_5665_LevelBgPalettePointerTable:
; 31-entry pointer table mapping level IDs to 64-byte BG palette blocks (8 palettes × 4 GBC colors).
; One block per world: Media Dimension, Toon TV, Scream TV, Circuit Central, Kung Fu Theater,
; Kung Fu Theater 2 (bonus level variant), Prehistory Channel, Rezopolis, Channel Z
    dw   .palette_media_dimension
    dw   .palette_toon_tv
    dw   .palette_scream_tv
    dw   .palette_scream_tv
    dw   .palette_circuit_central
    dw   .palette_kung_fu_theater
    dw   .palette_media_dimension
    dw   .palette_prehistory_channel
    dw   .palette_toon_tv
    dw   .palette_prehistory_channel
    dw   .palette_circuit_central
    dw   .palette_scream_tv
    dw   .palette_media_dimension
    dw   .palette_kung_fu_theater
    dw   .palette_rezopolis
    dw   .palette_media_dimension
    dw   .palette_scream_tv
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_kung_fu_theater2
    dw   .palette_rezopolis
    dw   .palette_circuit_central
    dw   .palette_prehistory_channel
    dw   .palette_scream_tv
    dw   .palette_rezopolis
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_media_dimension
    dw   .palette_channel_z
.data_0b_56a3_MenuPalettePointerTable:
; 16-entry pointer table for menu/cutscene palettes indexed by C register. Covers: null,
; title screen (start/password), title screen (big Gex splash), password entry, unknown,
; "Great Job" credits, "Entering <level>" + pause screens, wDA4B_DynamicPalette (dynamic),
; first title splash (Enter the Gecko), CRAVE Entertainment splash, David A. Palmer splash,
; and 4 credits screen entries
    dw   $0000
    dw   .image_title_screen_008_1_palette
    dw   .image_title_screen_008_0_palette
    dw   .data_5743_Palette
    dw   .data_57c3_Palette
    dw   .image_great_job_00c_2_palette
    dw   .data_5a83_Palette
    dw   wDA4B_DynamicPalette
    dw   .image_splash_01f_1_palette
    dw   .image_crave_01f_0_palette
    dw   .image_david_01e_0_palette
    dw   .data_5903_Palette
    dw   .data_5943_Palette
    dw   .data_5983_Palette
    dw   .data_59c3_Palette
    dw   .data_5a03_Palette
.image_title_screen_008_1_palette: ; Palette for actual title screen splash (start/password) ; 56c3
    INCBIN "gfx/menus/palettes/image_title_screen_008_1_palette.bin"
.image_title_screen_008_0_palette: ; Palette for 4th title screen splash (big gex image) ; 5703
    INCBIN "gfx/menus/palettes/image_title_screen_008_0_palette.bin"
.data_5743_Palette: ; Palette for Password Entering Screen on title screen ; 5743
    INCBIN "gfx/menus/palettes/data_5743_Palette.bin"
.data_5783_Palette: ; Palette for ??? ; 5783
    INCBIN "gfx/menus/palettes/data_5783_Palette.bin"
.data_57c3_Palette: ; Palette for ??? ; 57c3
    INCBIN "gfx/menus/palettes/data_57c3_Palette.bin"
.image_great_job_00c_2_palette: ; Palette for "Great Job! Thanks for Playing- The GEX Team" ; 5803
    INCBIN "gfx/menus/palettes/image_great_job_00c_2_palette.bin"
.image_splash_01f_1_palette: ; Palette for first title screen splash (gex enter the gecko) ; 5843
    INCBIN "gfx/menus/palettes/image_splash_01f_1_palette.bin"
.image_crave_01f_0_palette: ; Palette for 2nd title screen splash (CRAVE entertainment) ; 5883
    INCBIN "gfx/menus/palettes/image_crave_01f_0_palette.bin"
.image_david_01e_0_palette: ; Palette for 3rd title screen splash (David A Palmer Productions) ; 58c3
    INCBIN "gfx/menus/palettes/image_david_01e_0_palette.bin"
.data_5903_Palette: ; Palette for credits?
    INCBIN "gfx/menus/palettes/data_5903_Palette.bin"
.data_5943_Palette: ; Palette for credits?
    INCBIN "gfx/menus/palettes/data_5943_Palette.bin"
.data_5983_Palette: ; Palette for credits?
    INCBIN "gfx/menus/palettes/data_5983_Palette.bin"
.data_59c3_Palette: ; Palette for credits?
    INCBIN "gfx/menus/palettes/data_59c3_Palette.bin"
.data_5a03_Palette: ; unknown palette. may be unused.
    INCBIN "gfx/menus/palettes/data_5a03_Palette.bin"
.data_5a43_Palette: ; unknown palette. may be unused.
    INCBIN "gfx/menus/palettes/data_5a43_Palette.bin"
.data_5a83_Palette: ; Palette for "Entering <level>" screen, also the 4 pause screens (main, exit to map, quit game, totals)
    INCBIN "gfx/menus/palettes/data_5a83_Palette.bin"
.data_5ac3_Palette: ; unknown palette. may be unused.
    INCBIN "gfx/menus/palettes/data_5ac3_Palette.bin"
.data_gex_entity_palette2:
    db   $00, $00, $00, $00, $8a, $02, $fd, $03
.palette_media_dimension:
    INCBIN "gfx/tilesets/palettes/palette_media_dimension.bin"
.palette_toon_tv:
    INCBIN "gfx/tilesets/palettes/palette_toon_tv.bin"
.palette_scream_tv:
    INCBIN "gfx/tilesets/palettes/palette_scream_tv.bin"
.palette_circuit_central:
    INCBIN "gfx/tilesets/palettes/palette_circuit_central.bin"
.palette_kung_fu_theater:
    INCBIN "gfx/tilesets/palettes/palette_kung_fu_theater.bin"
.palette_kung_fu_theater2:
    INCBIN "gfx/tilesets/palettes/palette_kung_fu_theater2.bin"
.palette_prehistory_channel:
    INCBIN "gfx/tilesets/palettes/palette_prehistory_channel.bin"
.palette_rezopolis:
    INCBIN "gfx/tilesets/palettes/palette_rezopolis.bin"
.palette_channel_z:
    INCBIN "gfx/tilesets/palettes/palette_channel_z.bin"

call_0b_5d4b_MediaDimension_LoadTVPalette:
; Loads the palette for the TV screen prop in Media Dimension. Returns immediately if DMG mode.
; Calls call_00_2e3a (gets TV palette ID from current map tile), indexes .data_0b_5d62 to get a
; pointer to the 16-byte television palette for the appropriate world (Scream TV, Toon TV,
; Prehistory Channel, Circuit Central, Kung Fu Theater, Channel Z, Rezopolis, or Bonus TV), copies
; to wDA7B_MediaDimensionTVPalette
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ret  Z
    call call_00_2e3a_MapData_GetTVPaletteId
    ld   DE, .data_0b_5d62
    call call_00_07b9_GetPointerFromTable
    ld   DE, wDA7B_MediaDimensionTVPalette
    ld   BC, $10
    jp   call_00_07b0_MemCopy
.data_0b_5d62:
    dw   $0000
    dw   .circuit_central_television_palette
    dw   .kung_fu_theater_television_palette
    dw   .prehistory_channel_television_palette
    dw   .rezopolis_television_palette
    dw   $0000
    dw   .scream_tv_television_palette
    dw   .toon_tv_television_palette
    dw   .bonus_tv_television_palette
    dw   $0000
    dw   .channel_z_television_palette
.scream_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/scream_tv_television_palette.bin"
.toon_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/toon_tv_television_palette.bin"
.prehistory_channel_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/prehistory_channel_television_palette.bin"
.circuit_central_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/circuit_central_television_palette.bin"
.kung_fu_theater_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/kung_fu_theater_television_palette.bin"
.channel_z_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/channel_z_television_palette.bin"
.rezopolis_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/rezopolis_television_palette.bin"
.bonus_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/bonus_tv_television_palette.bin"

call_0b_5df8_MediaDimension_LoadActiveTVPalette:
; Loads the active world's TV palette into BG palette slot at wD9FB_BgPalettes_Slot6. Returns if DMG or if level
; ID is nonzero (not Media Dimension). Uses wD72D (secondary tileset index = current TV channel)
; to index .media_dimension_tv_palettes — same world palette set as above but with null entries
; for some slots — copies 16 bytes to wD9FB_BgPalettes_Slot6. Zero pointer = return early (no TV active)
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ret  Z
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    ret  NZ
    ld   HL, wD72D_SecondaryTilesetIndex
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .media_dimension_tv_palettes
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    or   A, H
    ret  Z
    ld   DE, wD9FB_BgPalettes_Slot6
    ld   BC, $10
    jp   call_00_07b0_MemCopy
.media_dimension_tv_palettes:
    dw   .scream_tv_television_palette
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    db   $00, $00
    dw   .toon_tv_television_palette
    dw   .prehistory_channel_television_palette
    dw   .circuit_central_television_palette
    dw   .kung_fu_theater_television_palette
    dw   .channel_z_television_palette
    dw   .rezopolis_television_palette
    dw   .bonus_tv_television_palette
.scream_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/scream_tv_television_palette.bin"
.toon_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/toon_tv_television_palette.bin"
.prehistory_channel_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/prehistory_channel_television_palette.bin"
.circuit_central_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/circuit_central_television_palette.bin"
.kung_fu_theater_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/kung_fu_theater_television_palette.bin"
.channel_z_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/channel_z_television_palette.bin"
.rezopolis_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/rezopolis_television_palette.bin"
.bonus_tv_television_palette:
    INCBIN "gfx/secondary_tilesets/media_dimension/palettes/bonus_tv_television_palette.bin"

call_0b_5ec3_UpdatePlayerObjPalette:
; Updates Gex's OBJ palette based on current power-up state. Returns if DMG.
; Reads wD73B_VBlankFrameCounter low 5 bits; if ≥ 8 (not ?), checks powerup timers
; wD751_Player_CircuitPowerUpTimerLo/wD752_Player_CircuitPowerUpTimerHi →
; uses .data_0b_5efb (gold flash palette), then wD755_FlyPowerup2_TimerLo/wD756 → uses .data_0b_5f03
; (blue/white palette), then wD753_FlyPowerup1_TimerLo/wD754_FlyPowerup1_TimerHi → same blue/white palette.
; Otherwise falls through to .data_gex_entity_palette (normal Gex palette). Copies 8 bytes to wDA0B
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ret  Z
    ld   A, [wD73B_VBlankFrameCounter]
    and  A, $1f
    cp   A, $08
    jr   C, .jr_0b_5eef
    ld   HL, wD751_Player_CircuitPowerUpTimerLo
    ld   A, [HL+]
    or   A, [HL]
    ld   HL, .data_0b_5efb
    jr   NZ, .jr_0b_5ef2
    ld   HL, wD755_FlyPowerup2_TimerLo
    ld   A, [HL+]
    or   A, [HL]
    ld   HL, .data_0b_5f03
    jr   NZ, .jr_0b_5ef2
    ld   HL, wD753_FlyPowerup1_TimerLo
    ld   A, [HL+]
    or   A, [HL]
    ld   HL, .data_0b_5f03
    jr   NZ, .jr_0b_5ef2
.jr_0b_5eef:
    ld   HL, .data_gex_entity_palette
.jr_0b_5ef2:
    ld   DE, wDA0B_Entity_Palettes
    ld   BC, $08
    jp   call_00_07b0_MemCopy
.data_0b_5efb:
    db   $00, $00, $64, $02, $f5, $3b, $ff, $43
.data_0b_5f03:
    db   $00, $00, $55, $01, $7f, $02, $ff, $03
    db   $00, $00, $40, $45, $af, $7e, $f5, $7f
.data_gex_entity_palette:
    db   $00, $00, $00, $00, $8a, $02, $fd, $03

call_0b_5f1b_FlyPowerup_LoadParticlePalette:
; Loads the fly power-up particle's GBC palette. Returns if DMG. Uses wD742 (fly power-up type, 1-based)
; × 8 to index .data_0b_5f37_FlyPalettes (4 entries × 8 bytes), copies to wDA1B_EntityPalettes_Slot2
; (OBJ palette 2). The 4 fly types have different particle colors: green/teal, white/gray, blue, and transparent/white
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ret  Z
    ld   A, [wD742_Player_CurrentFly]
    dec  A
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, .data_0b_5f37_FlyPalettes
    add  HL, DE
    ld   DE, wDA1B_EntityPalettes_Slot2
    ld   BC, $08
    jp   call_00_07b0_MemCopy
.data_0b_5f37_FlyPalettes:
    db   $00, $00, $00, $00, $94, $52, $9c, $73
    db   $00, $00, $00, $00, $14, $00, $1c, $00
    db   $00, $00, $00, $00, $00, $50, $00, $70
    db   $00, $00, $00, $00, $00, $03, $00, $03

call_0b_5f57_Entity_LoadGBCPalette:
; Loads a GBC OBJ palette for the current entity slot. Derives palette slot from wD300
; (entity address low byte, rotated 3 bits). Reads entity ID from ENTITY_FIELD_ENTITY_ID,
; multiplies by 8, indexes .data_entity_palettes for that entity's 8-byte color data, writes
; to the computed wDA0B+ slot. Also stores the palette slot index in wD32D_Entity_OamAttrBase table entry for this entity slot
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD32D_Entity_OamAttrBase
    add  HL, DE
    ld   A, C
    ld   [HL], A
    ld   L, A
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, wDA0B_Entity_Palettes
    add  HL, DE
    ld   E, L
    ld   D, H
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ENTITY_ID
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   BC, .data_entity_palettes
    add  HL, BC
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
.data_entity_palettes:
    INCBIN "gfx/entity_sprites/entity_palettes.bin"

call_0b_641e_TilesetPaletteIds_Load:
; Loads the per-tile palette ID table for the current level into wCF00. Uses wD624 (level ID)
; to index .data_level_palette_ids (31-entry pointer table, one per world), then copies 256 bytes
; (one palette ID per tile type, wrapping at 256) into wCF00_TilesetPaletteIds.
; Used by the BG map renderer to assign the correct GBC palette to each background tile
    ld   HL, wD624_CurrentLevelId
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, .data_level_palette_ids
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    ld   DE, wCF00_TilesetPaletteIds
.jr_0b_642f:
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    jr   NZ, .jr_0b_642f
    ret
.data_level_palette_ids:
    dw   .palette_ids_media_dimension
    dw   .palette_ids_toon_tv
    dw   .palette_ids_scream_tv
    dw   .palette_ids_scream_tv
    dw   .palette_ids_circuit_central
    dw   .palette_ids_kung_fu_theater
    dw   .palette_ids_media_dimension
    dw   .palette_ids_prehistory_channel
    dw   .palette_ids_toon_tv
    dw   .palette_ids_prehistory_channel
    dw   .palette_ids_circuit_central
    dw   .palette_ids_scream_tv
    dw   .palette_ids_media_dimension
    dw   .palette_ids_kung_fu_theater
    dw   .palette_ids_rezopolis
    dw   .palette_ids_media_dimension
    dw   .palette_ids_scream_tv
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_kung_fu_theater
    dw   .palette_ids_rezopolis
    dw   .palette_ids_circuit_central
    dw   .palette_ids_prehistory_channel
    dw   .palette_ids_scream_tv
    dw   .palette_ids_rezopolis
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_media_dimension
    dw   .palette_ids_channel_z
.palette_ids_media_dimension:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_media_dimension.bin"
.palette_ids_toon_tv:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_toon_tv.bin"
.palette_ids_scream_tv:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_scream_tv.bin"
.palette_ids_circuit_central:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_circuit_central.bin"
.palette_ids_kung_fu_theater:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_kung_fu_theater.bin"
.palette_ids_prehistory_channel:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_prehistory_channel.bin"
.palette_ids_rezopolis:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_rezopolis.bin"
.palette_ids_channel_z:
    INCBIN "gfx/tilesets/palette_ids/palette_ids_channel_z.bin"
