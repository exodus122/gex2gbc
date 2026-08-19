; ==================================================================
; OAM BUILD
;
; Everything that writes wCC00_ShadowOAM, in the order the frame uses it: the shape
; tables first, then the builders that read them.
;
;   $5446  data       the shapes - which rectangle each entity draws as
;   $5B5B  HUD        the status row along the bottom
;   $5CA8  player     Gex, who has his own builder
;   $5EBF  entities   the five drawing paths, chosen by SPRITE_FLAG_*
;   $6484  frame end  collectibles, HUD, then blank whatever is left
;   $6549  particles  six per-effect sprite list builders
;
; OAM is carved up rather than allocated: Gex owns the first entries, entities run
; from OAM_ENTITY_FIRST_BYTE to OAM_ENTITY_LAST_BYTE through
; wD739_Entity_OamWriteOffset, collectibles have wCC60_ShadowOAM_CollectibleSprites
; and the HUD has wCC80_ShadowOAM_HudSprites. Nothing checks another region's
; boundary, so the ordering here is the whole of the arbitration.
;
; ------------------------------------------------------------------
; ENTITY SPRITE SHAPES
;
; Not artwork - shapes. These data tables describe WHERE an entity's OAM
; entries go and which tiles inside its tile page they use; the picture itself is
; never here. An enemy animates by streaming a different page of tiles into VRAM
; while drawing the same handful of rectangles every frame, which is why the
; whole of a boss's animation costs nothing more than a couple of dozen bytes of
; layout shared with every other enemy the same size.
;
; These data tables are reached only from the two frame-based sprite builders -
; the SPRITE_FLAG_FIXED_SHAPE path uses .data_03_608e_FixedSpriteShapeTable
; instead, and Gex has his own builder entirely.
;
; THE META TABLE IS READ BACKWARDS. The builders load
; data_03_5446_EntitySpriteDescriptors + 1, add entity id x 2, and then read with
; `ld a, [hl-]` - so the byte they pick up first is the SECOND of the pair and the
; one they test bit 7 of is the FIRST. The pair for entity N therefore starts at
; $5446 + 2N, and $5446 is a record byte, not a stray value in front of the table.
;
;   +0  shape index, or a layout index - see below
;   +1  tile id base, added to every tile number in the chosen layout
;
; BYTE +0 MEANS TWO DIFFERENT THINGS depending on how the entity is drawn, because
; two different builders index this same table:
;
;   SPRITE_FLAG_STREAMS_OWN_GFX entities   a SPRITE_SHAPE_* index into the pointer
;                                          table of data_03_5566_SpriteShapeTable_Main,
;                                          or, with bit 7 set, into
;                                          data_03_5a8a_SpriteShapeTable_Alt
;   SPRITE_FLAG_FIXED_SHAPE entities  a base index into
;                                          .data_03_608e_FixedSpriteShapeTable
;                                          in bank03_oam_build.asm, with +1 added when
;                                          the entity faces left. Byte +1 is unused for
;                                          these - their tile base is the live
;                                          ENTITY_FIELD_SPRITE_ID instead - and every
;                                          one of them leaves it $00
;
; No entity mixes the two, so each row below belongs to exactly one of the readings.
;
; PICKING A SHAPE. For the shape path the pointer table is indexed by
;
;     shape index + (wD587_EntityGfxVramPage | (facing left ? 2 : 0))
;
; so every shape is four consecutive entries: page 0, page 1, page 0 mirrored,
; page 1 mirrored. The two pages are the double-buffered entity tile pages at
; $8200 and $8300 - the layouts differ only in whether their tile numbers start at
; $10 or at $00, which with a tile base of $20 is exactly those two pages. Mirroring
; is OAMF_XFLIP on every part plus a mirrored set of X offsets, so an off-centre
; shape stays off-centre in the right direction.
;
; A LAYOUT BLOCK is a part count followed by that many four-byte parts. Sprites are
; 8x16 (LCDC is set to $C7), so a part is 8 wide and 16 tall and tile numbers step
; by 2 down a column and by 4 across, i.e. the tile page is stored column by column.
; The builder adds the entity's screen position to the offsets, the meta table's
; tile base to the tile, and wD335_Entity_OamAttr to the attributes.
;
; DEAD WEIGHT. Only seven shape indices are ever used - $08, $10, $18, $30, $40, $48
; and $50 - out of the twenty-two groups the pointer table holds. Five groups are
; byte-for-byte repeats of the group before them, one is an upside-down 32x32 and one
; is a 24x32 with its rows emitted in the other order; none of those is reachable.
; The alternate table is worse: bit 7 discards the page and facing bits, so its index
; is always plain 0, and the two entities that use it both take entry 0. Its other
; ten entries - a complete set of row and box shapes with tile numbers based at $00 -
; cannot be reached at all.
;
; THE TWO BUILDERS ARE THE SAME CODE. From the point where they read
; ENTITY_FIELD_FACING_FLAGS onwards, .jr_03_5fcb_Entity_BuildSprites_Streamed and
; the default path above it are 91 identical bytes. SPRITE_FLAG_STREAMS_OWN_GFX makes
; no difference to how a sprite is drawn - it only decides whether the entity streams
; its own tiles, which is settled elsewhere
; ==================================================================

data_03_5446_EntitySpriteDescriptors:
; One two-byte descriptor per entity id, 144 of them: which shape the entity is drawn
; as, and which tiles go inside it. The builders address this as
; `data_03_5446_EntitySpriteDescriptors + 1 + entity id * 2` and read backwards, so the
; two bytes of a row arrive in the order (+1, +0)
    db   $18, $00                                         ; $00 ENTITY_GEX - drawn by the player builder, never read here
    db   $08, $00                                         ; $01 ENTITY_COLLECTIBLE_SPAWN - embed, never read here
    db   SPRITE_SHAPE_ALT | $00, $66                      ; $02 ENTITY_UNK_02 - alt table entry $00
    db   $1a, $00                                         ; $03 ENTITY_TV_BUTTON - layout $1a/$1b by action
    db   SPRITE_SHAPE_16x32, $20                          ; $04 ENTITY_RED_REMOTE - 16x32, centred
    db   SPRITE_SHAPE_16x32, $20                          ; $05 ENTITY_SILVER_REMOTE - 16x32, centred
    db   SPRITE_SHAPE_16x32, $20                          ; $06 ENTITY_GOLD_REMOTE - 16x32, centred
    db   $08, $00                                         ; $07 ENTITY_ENEMY_DEFEATED - embed, never read here
    db   SPRITE_SHAPE_32x32, $20                          ; $08 ENTITY_UNK_08 - 32x32, centred
    db   $26, $00                                         ; $09 ENTITY_SCREAM_TV_FALLING_PLATFORM - layout $26/$27 by action
    db   $26, $00                                         ; $0A ENTITY_SCREAM_TV_MOVING_PLATFORM - layout $26/$27 by action
    db   $1e, $00                                         ; $0B ENTITY_SCREAM_TV_PUSH_BLOCK - layout $1e/$1f by action
    db   SPRITE_SHAPE_32x32, $20                          ; $0C ENTITY_SCREAM_TV_PUMPKIN - 32x32, centred
    db   SPRITE_SHAPE_24x32, $20                          ; $0D ENTITY_SCREAM_TV_FRANKIE - 24x32, centred
    db   $02, $00                                         ; $0E ENTITY_SCREAM_TV_HEAD_GHOST - layout $02/$03 by action
    db   $08, $00                                         ; $0F ENTITY_SCREAM_TV_HEAD_GHOST_HEAD - layout $08/$09 by action
    db   SPRITE_SHAPE_16x32, $20                          ; $10 ENTITY_SCREAM_TV_FLOATING_SKULL - 16x32, centred
    db   $08, $00                                         ; $11 ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE - layout $08/$09 by action
    db   SPRITE_SHAPE_24x32, $20                          ; $12 ENTITY_SCREAM_TV_ZOMBIE - 24x32, centred
    db   SPRITE_SHAPE_ALT | $00, $2c                      ; $13 ENTITY_SCREAM_TV_ZOMBIE_HEAD - alt table entry $00
    db   $0a, $00                                         ; $14 ENTITY_SCREAM_TV_FALLING_AXE - layout $0a/$0b by action
    db   $02, $00                                         ; $15 ENTITY_SCREAM_TV_LANTERN - layout $02/$03 by action
    db   SPRITE_SHAPE_24x16, $20                          ; $16 ENTITY_SCREAM_TV_BAT - 24x16, centred
    db   $1e, $00                                         ; $17 ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM - layout $1e/$1f by action
    db   SPRITE_SHAPE_32x32, $20                          ; $18 ENTITY_SCREAM_TV_DOOR_OPENING - 32x32, centred
    db   SPRITE_SHAPE_24x32, $20                          ; $19 ENTITY_SCREAM_TV_GHOST - 24x32, centred
    db   $0a, $00                                         ; $1A ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY - layout $0a/$0b by action
    db   $26, $00                                         ; $1B ENTITY_SCREAM_TV_VANISHING_PLATFORM - layout $26/$27 by action
    db   $26, $00                                         ; $1C ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR - layout $26/$27 by action
    db   $06, $00                                         ; $1D ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD - layout $06/$07 by action
    db   $0e, $00                                         ; $1E ENTITY_TOON_TV_STATIONARY_BEAR_TRAP - layout $0e/$0f by action
    db   $02, $00                                         ; $1F ENTITY_TOON_TV_MOVING_BEAR_TRAP - layout $02/$03 by action
    db   $04, $00                                         ; $20 ENTITY_TOON_TV_BUMBLEBEE - layout $04/$05 by action
    db   $04, $00                                         ; $21 ENTITY_TOON_TV_BOWLING_BALL - layout $04/$05 by action
    db   $04, $00                                         ; $22 ENTITY_TOON_TV_CACTUS - layout $04/$05 by action
    db   $04, $00                                         ; $23 ENTITY_TOON_TV_DOMINO - layout $04/$05 by action
    db   $0c, $00                                         ; $24 ENTITY_TOON_TV_SHARK - layout $0c/$0d by action
    db   $04, $00                                         ; $25 ENTITY_TOON_TV_FLOWER - layout $04/$05 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $26 ENTITY_TOON_TV_HUNTER - 32x32, centred
    db   $0c, $00                                         ; $27 ENTITY_TOON_TV_MUSHROOM - layout $0c/$0d by action
    db   $08, $00                                         ; $28 ENTITY_TOON_TV_MUSHROOM_PROJECTILE - layout $08/$09 by action
    db   $0e, $00                                         ; $29 ENTITY_TOON_TV_LIZARD - layout $0e/$0f by action
    db   SPRITE_SHAPE_24x32, $20                          ; $2A ENTITY_TOON_TV_HAPPY_FACE - 24x32, centred
    db   $1a, $00                                         ; $2B ENTITY_TOON_TV_VANISHING_BLOCK - layout $1a/$1b by action
    db   $1a, $00                                         ; $2C ENTITY_TOON_TV_MOVING_BLOCK - layout $1a/$1b by action
    db   $1e, $00                                         ; $2D ENTITY_TOON_TV_MOVING_LOG - layout $1e/$1f by action
    db   $1e, $00                                         ; $2E ENTITY_TOON_TV_STATIONARY_LOG - layout $1e/$1f by action
    db   $02, $00                                         ; $2F ENTITY_TOON_TV_FLOWER_HAMMER - layout $02/$03 by action
    db   $0a, $00                                         ; $30 ENTITY_TOON_TV_HUNTER_BULLET - layout $0a/$0b by action
    db   $38, $00                                         ; $31 ENTITY_TOON_TV_ROCKET - layout $38/$39 by action
    db   SPRITE_SHAPE_32x32_BEHIND4, $20                  ; $32 ENTITY_PRE_HISTORY_FAST_DINOSAUR - 32x32, shifted 4px against the facing direction
    db   SPRITE_SHAPE_32x32, $20                          ; $33 ENTITY_PRE_HISTORY_DRAGONFLY - 32x32, centred
    db   SPRITE_SHAPE_16x32, $20                          ; $34 ENTITY_PRE_HISTORY_EGG - 16x32, centred
    db   $02, $00                                         ; $35 ENTITY_UNK_35 - layout $02/$03 by action
    db   $26, $00                                         ; $36 ENTITY_UNK_36 - layout $26/$27 by action
    db   $08, $00                                         ; $37 ENTITY_PRE_HISTORY_FALLING_LAVA - layout $08/$09 by action
    db   $26, $00                                         ; $38 ENTITY_PRE_HISTORY_LAVA_RAFT - layout $26/$27 by action
    db   $24, $00                                         ; $39 ENTITY_PRE_HISTORY_MOVING_PLATFORM - layout $24/$25 by action
    db   $26, $00                                         ; $3A ENTITY_UNK_3A - layout $26/$27 by action
    db   $24, $00                                         ; $3B ENTITY_UNK_3B - layout $24/$25 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $3C ENTITY_PRE_HISTORY_PTEROSAUR - 32x32, centred
    db   $04, $00                                         ; $3D ENTITY_UNK_3D - layout $04/$05 by action
    db   $04, $00                                         ; $3E ENTITY_PRE_HISTORY_FALLING_BOULDER - layout $04/$05 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $3F ENTITY_UNK_3F - 32x32, centred
    db   $0a, $00                                         ; $40 ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL - layout $0a/$0b by action
    db   $0a, $00                                         ; $41 ENTITY_PRE_HISTORY_BEETLE_VERTICAL - layout $0a/$0b by action
    db   $0a, $00                                         ; $42 ENTITY_PRE_HISTORY_ANT - layout $0a/$0b by action
    db   $14, $00                                         ; $43 ENTITY_PRE_HISTORY_FIRE_PLANT - layout $14/$15 by action
    db   $08, $00                                         ; $44 ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES - layout $08/$09 by action
    db   $02, $00                                         ; $45 ENTITY_PRE_HISTORY_GEYSER - layout $02/$03 by action
    db   $26, $00                                         ; $46 ENTITY_UNK_46 - layout $26/$27 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $47 ENTITY_PRE_HISTORY_DINOSAUR - 32x32, centred
    db   SPRITE_SHAPE_32x32, $20                          ; $48 ENTITY_PRE_HISTORY_TRICERATOPS - 32x32, centred
    db   $00, $00                                         ; $49 ENTITY_PRE_HISTORY_TRICERATOPS_HORN - layout $00/$01 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $4A ENTITY_UNK_4A - 32x32, centred
    db   $28, $00                                         ; $4B ENTITY_KUNG_FU_THEATER_HANGING_BLADE - layout $28/$29 by action
    db   $08, $00                                         ; $4C ENTITY_KUNG_FU_THEATER_CANNON - invis, never read here
    db   $08, $00                                         ; $4D ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE - layout $08/$09 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $4E ENTITY_KUNG_FU_THEATER_DRAGONFLY - 32x32, centred
    db   $0a, $00                                         ; $4F ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT - layout $0a/$0b by action
    db   SPRITE_SHAPE_32x32, $20                          ; $50 ENTITY_KUNG_FU_THEATER_DRAGON_HEAD - 32x32, centred
    db   $02, $00                                         ; $51 ENTITY_UNK_51 - layout $02/$03 by action
    db   $08, $00                                         ; $52 ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE - layout $08/$09 by action
    db   SPRITE_SHAPE_32x32_AHEAD8, $20                   ; $53 ENTITY_KUNG_FU_THEATER_WALKING_NINJA - 32x32, shifted 8px in the facing direction
    db   SPRITE_SHAPE_32x32_AHEAD8, $20                   ; $54 ENTITY_KUNG_FU_THEATER_JUMPING_NINJA - 32x32, shifted 8px in the facing direction
    db   SPRITE_SHAPE_32x32_AHEAD4, $20                   ; $55 ENTITY_KUNG_FU_THEATER_SAMURAI_BODY - 32x32, shifted 4px in the facing direction
    db   $08, $00                                         ; $56 ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD - layout $08/$09 by action
    db   $0e, $00                                         ; $57 ENTITY_KUNG_FU_THEATER_LIZARD - layout $0e/$0f by action
    db   $08, $00                                         ; $58 ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE - layout $08/$09 by action
    db   $0e, $00                                         ; $59 ENTITY_KUNG_FU_THEATER_SPIKY_LOG - layout $0e/$0f by action
    db   $04, $00                                         ; $5A ENTITY_KUNG_FU_THEATER_TALL_JAR - layout $04/$05 by action
    db   $04, $00                                         ; $5B ENTITY_KUNG_FU_THEATER_JAR - layout $04/$05 by action
    db   $2a, $00                                         ; $5C ENTITY_UNK_5C - layout $2a/$2b by action
    db   $2c, $00                                         ; $5D ENTITY_UNK_5D - layout $2c/$2d by action
    db   $1e, $00                                         ; $5E ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM - layout $1e/$1f by action
    db   $1e, $00                                         ; $5F ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM - layout $1e/$1f by action
    db   $1e, $00                                         ; $60 ENTITY_UNK_60 - layout $1e/$1f by action
    db   $1e, $00                                         ; $61 ENTITY_KUNG_FU_THEATER_MOVING_RAFT - layout $1e/$1f by action
    db   $1e, $00                                         ; $62 ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT - layout $1e/$1f by action
    db   $1e, $00                                         ; $63 ENTITY_UNK_63 - invis, never read here
    db   $24, $00                                         ; $64 ENTITY_UNK_64 - layout $24/$25 by action
    db   $24, $00                                         ; $65 ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM - layout $24/$25 by action
    db   $24, $00                                         ; $66 ENTITY_REZOPOLIS_MOVING_PLATFORM - layout $24/$25 by action
    db   $24, $00                                         ; $67 ENTITY_REZOPOLIS_RED_PLATFORM - layout $24/$25 by action
    db   $24, $00                                         ; $68 ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM - layout $24/$25 by action
    db   $24, $00                                         ; $69 ENTITY_REZOPOLIS_TAILSPIN_PLATFORM - layout $24/$25 by action
    db   $0e, $00                                         ; $6A ENTITY_REZOPOLIS_TAILSPIN_GEAR - layout $0e/$0f by action
    db   SPRITE_SHAPE_32x32, $20                          ; $6B ENTITY_UNK_6B - 32x32, centred
    db   $02, $00                                         ; $6C ENTITY_UNK_6C - layout $02/$03 by action
    db   $06, $00                                         ; $6D ENTITY_UNK_6D - layout $06/$07 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $6E ENTITY_REZOPOLIS_GREEN_MONSTER - 32x32, centred
    db   $00, $00                                         ; $6F ENTITY_UNK_6F - layout $00/$01 by action
    db   $00, $00                                         ; $70 ENTITY_UNK_70 - layout $00/$01 by action
    db   SPRITE_SHAPE_24x32, $20                          ; $71 ENTITY_REZOPOLIS_PINCER - 24x32, centred
    db   $00, $00                                         ; $72 ENTITY_REZOPOLIS_FLAMETHROWER - layout $00/$01 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $73 ENTITY_REZOPOLIS_UFO - 32x32, centred
    db   $0c, $00                                         ; $74 ENTITY_REZOPOLIS_ANT - layout $0c/$0d by action
    db   $08, $00                                         ; $75 ENTITY_REZOPOLIS_ANT_SPAWNER - invis, never read here
    db   $0c, $00                                         ; $76 ENTITY_CIRCUIT_CENTRAL_ANT - layout $0c/$0d by action
    db   $32, $00                                         ; $77 ENTITY_CIRCUIT_CENTRAL_CAPACITOR - layout $32/$33 by action
    db   $0a, $00                                         ; $78 ENTITY_CIRCUIT_CENTRAL_POWER_UP - layout $0a/$0b by action
    db   SPRITE_SHAPE_32x32, $20                          ; $79 ENTITY_UNK_79 - 32x32, centred
    db   $0c, $00                                         ; $7A ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT - layout $0c/$0d by action
    db   $0a, $00                                         ; $7B ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR - layout $0a/$0b by action
    db   $0a, $00                                         ; $7C ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL - layout $0a/$0b by action
    db   $26, $00                                         ; $7D ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM - layout $26/$27 by action
    db   $26, $00                                         ; $7E ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM - layout $26/$27 by action
    db   $26, $00                                         ; $7F ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM - layout $26/$27 by action
    db   SPRITE_SHAPE_24x32, $20                          ; $80 ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT - 24x32, centred
    db   $08, $00                                         ; $81 ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY - invis, never read here
    db   $08, $00                                         ; $82 ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR - invis, never read here
    db   $12, $00                                         ; $83 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE - layout $12/$13 by action
    db   $12, $00                                         ; $84 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2 - layout $12/$13 by action
    db   $12, $00                                         ; $85 ENTITY_CHANNEL_Z_GUN_PROJECTILE - layout $12/$13 by action
    db   SPRITE_SHAPE_32x32, $20                          ; $86 ENTITY_CHANNEL_Z_REZ - 32x32, centred
    db   $26, $00                                         ; $87 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1 - layout $26/$27 by action
    db   $26, $00                                         ; $88 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2 - layout $26/$27 by action
    db   $0a, $00                                         ; $89 ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE - layout $0a/$0b by action
    db   $0a, $00                                         ; $8A ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION - layout $0a/$0b by action
    db   $0a, $00                                         ; $8B ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE - layout $0a/$0b by action
    db   $1a, $00                                         ; $8C ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON - layout $1a/$1b by action
    db   SPRITE_SHAPE_32x32, $20                          ; $8D ENTITY_CHANNEL_Z_REZ_PORTAL - 32x32, centred
    db   SPRITE_SHAPE_32x32, $20                          ; $8E ENTITY_UNK_8E - 32x32, centred
    db   $1e, $00                                         ; $8F ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM - layout $1e/$1f by action

data_03_5566_SpriteShapeTable_Main:
; The shapes a SPRITE_SHAPE_* index selects: 88 pointers in twenty-two groups of four
; (page 0, page 1, page 0 mirrored, page 1 mirrored), then the shapes themselves.
; Only the seven groups marked below can be selected
    ; $00  unreachable - 8x32, centred
    dw   .box_8x32_page0, .box_8x32_page1, .box_8x32_page0_flipX, .box_8x32_page1_flipX
    ; $04  unreachable - a repeat of the group above
    dw   .box_8x32_page0, .box_8x32_page1, .box_8x32_page0_flipX, .box_8x32_page1_flipX
    ; $08  SPRITE_SHAPE_16x32 - 16x32, centred
    dw   .box_16x32_page0, .box_16x32_page1, .box_16x32_page0_flipX, .box_16x32_page1_flipX
    ; $0c  unreachable - a repeat of the group above
    dw   .box_16x32_page0, .box_16x32_page1, .box_16x32_page0_flipX, .box_16x32_page1_flipX
    ; $10  SPRITE_SHAPE_24x32 - 24x32, centred
    dw   .box_24x32_page0, .box_24x32_page1, .box_24x32_page0_flipX, .box_24x32_page1_flipX
    ; $14  unreachable - 24x32, centred - same picture as $10, bottom row emitted first
    dw   .box_24x32_rowswap_page0, .box_24x32_rowswap_page1, .box_24x32_rowswap_page0_flipX, .box_24x32_rowswap_page1_flipX
    ; $18  SPRITE_SHAPE_32x32 - 32x32, centred
    dw   .box_32x32_page0, .box_32x32_page1, .box_32x32_page0_flipX, .box_32x32_page1_flipX
    ; $1c  unreachable - 32x32, centred, upside down
    dw   .box_32x32_flipY_page0, .box_32x32_flipY_page1, .box_32x32_flipY_page0_flipX, .box_32x32_flipY_page1_flipX
    ; $20  unreachable - 8x16, centred
    dw   .box_8x16_page0, .box_8x16_page1, .box_8x16_page0_flipX, .box_8x16_page1_flipX
    ; $24  unreachable - a repeat of the group above
    dw   .box_8x16_page0, .box_8x16_page1, .box_8x16_page0_flipX, .box_8x16_page1_flipX
    ; $28  unreachable - 16x16, centred
    dw   .box_16x16_page0, .box_16x16_page1, .box_16x16_page0_flipX, .box_16x16_page1_flipX
    ; $2c  unreachable - a repeat of the group above
    dw   .box_16x16_page0, .box_16x16_page1, .box_16x16_page0_flipX, .box_16x16_page1_flipX
    ; $30  SPRITE_SHAPE_24x16 - 24x16, centred
    dw   .box_24x16_page0, .box_24x16_page1, .box_24x16_page0_flipX, .box_24x16_page1_flipX
    ; $34  unreachable - a repeat of the group above
    dw   .box_24x16_page0, .box_24x16_page1, .box_24x16_page0_flipX, .box_24x16_page1_flipX
    ; $38  unreachable - 32x16, centred
    dw   .box_32x16_page0, .box_32x16_page1, .box_32x16_page0_flipX, .box_32x16_page1_flipX
    ; $3c  unreachable - a repeat of the group above
    dw   .box_32x16_page0, .box_32x16_page1, .box_32x16_page0_flipX, .box_32x16_page1_flipX
    ; $40  SPRITE_SHAPE_32x32_AHEAD8 - 32x32, shifted 8px in the facing direction
    dw   .box_32x32_ahead8_page0, .box_32x32_ahead8_page1, .box_32x32_ahead8_page0_flipX, .box_32x32_ahead8_page1_flipX
    ; $44  unreachable - a repeat of the group above
    dw   .box_32x32_ahead8_page0, .box_32x32_ahead8_page1, .box_32x32_ahead8_page0_flipX, .box_32x32_ahead8_page1_flipX
    ; $48  SPRITE_SHAPE_32x32_AHEAD4 - 32x32, shifted 4px in the facing direction
    dw   .box_32x32_ahead4_page0, .box_32x32_ahead4_page1, .box_32x32_ahead4_page0_flipX, .box_32x32_ahead4_page1_flipX
    ; $4c  unreachable - a repeat of the group above
    dw   .box_32x32_ahead4_page0, .box_32x32_ahead4_page1, .box_32x32_ahead4_page0_flipX, .box_32x32_ahead4_page1_flipX
    ; $50  SPRITE_SHAPE_32x32_BEHIND4 - 32x32, shifted 4px against the facing direction
    dw   .box_32x32_behind4_page0, .box_32x32_behind4_page1, .box_32x32_behind4_page0_flipX, .box_32x32_behind4_page1_flipX
    ; $54  unreachable - a repeat of the group above
    dw   .box_32x32_behind4_page0, .box_32x32_behind4_page1, .box_32x32_behind4_page0_flipX, .box_32x32_behind4_page1_flipX

; ------------------------------------------------------------------
; THE LAYOUTS THEMSELVES
;
; Part count, then that many obj_part records. Read down one and the tile
; numbering is plain: +4 per column across, +2 per row down, because in 8x16 mode
; one part eats two tile slots and the tile page is stored column by column.
; The _page1 copies are the same rectangle with every tile number $10 lower, and
; the _flipX copies add OAMF_XFLIP and reverse the X offsets - reverse, not negate,
; so a shape that leans one way leans the other way when the entity turns round
; ------------------------------------------------------------------

.box_8x32_page0:
    db   2
    obj_part  -16,   -4, $10, $00
    obj_part    0,   -4, $12, $00
.box_8x32_page1:
    db   2
    obj_part  -16,   -4, $00, $00
    obj_part    0,   -4, $02, $00
.box_8x32_page0_flipX:
    db   2
    obj_part  -16,   -4, $10, OAMF_XFLIP
    obj_part    0,   -4, $12, OAMF_XFLIP
.box_8x32_page1_flipX:
    db   2
    obj_part  -16,   -4, $00, OAMF_XFLIP
    obj_part    0,   -4, $02, OAMF_XFLIP
.box_16x32_page0:
    db   4
    obj_part  -16,   -8, $10, $00
    obj_part  -16,    0, $14, $00
    obj_part    0,   -8, $12, $00
    obj_part    0,    0, $16, $00
.box_16x32_page1:
    db   4
    obj_part  -16,   -8, $00, $00
    obj_part  -16,    0, $04, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $06, $00
.box_16x32_page0_flipX:
    db   4
    obj_part  -16,    0, $10, OAMF_XFLIP
    obj_part  -16,   -8, $14, OAMF_XFLIP
    obj_part    0,    0, $12, OAMF_XFLIP
    obj_part    0,   -8, $16, OAMF_XFLIP
.box_16x32_page1_flipX:
    db   4
    obj_part  -16,    0, $00, OAMF_XFLIP
    obj_part  -16,   -8, $04, OAMF_XFLIP
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,   -8, $06, OAMF_XFLIP
.box_24x32_page0:
    db   6
    obj_part  -16,  -12, $10, $00
    obj_part  -16,   -4, $14, $00
    obj_part  -16,    4, $18, $00
    obj_part    0,  -12, $12, $00
    obj_part    0,   -4, $16, $00
    obj_part    0,    4, $1a, $00
.box_24x32_page1:
    db   6
    obj_part  -16,  -12, $00, $00
    obj_part  -16,   -4, $04, $00
    obj_part  -16,    4, $08, $00
    obj_part    0,  -12, $02, $00
    obj_part    0,   -4, $06, $00
    obj_part    0,    4, $0a, $00
.box_24x32_page0_flipX:
    db   6
    obj_part  -16,    4, $10, OAMF_XFLIP
    obj_part  -16,   -4, $14, OAMF_XFLIP
    obj_part  -16,  -12, $18, OAMF_XFLIP
    obj_part    0,    4, $12, OAMF_XFLIP
    obj_part    0,   -4, $16, OAMF_XFLIP
    obj_part    0,  -12, $1a, OAMF_XFLIP
.box_24x32_page1_flipX:
    db   6
    obj_part  -16,    4, $00, OAMF_XFLIP
    obj_part  -16,   -4, $04, OAMF_XFLIP
    obj_part  -16,  -12, $08, OAMF_XFLIP
    obj_part    0,    4, $02, OAMF_XFLIP
    obj_part    0,   -4, $06, OAMF_XFLIP
    obj_part    0,  -12, $0a, OAMF_XFLIP
.box_24x32_rowswap_page0:
    db   6
    obj_part    0,  -12, $10, $00
    obj_part    0,   -4, $14, $00
    obj_part    0,    4, $18, $00
    obj_part  -16,  -12, $12, $00
    obj_part  -16,   -4, $16, $00
    obj_part  -16,    4, $1a, $00
.box_24x32_rowswap_page1:
    db   6
    obj_part    0,  -12, $00, $00
    obj_part    0,   -4, $04, $00
    obj_part    0,    4, $08, $00
    obj_part  -16,  -12, $02, $00
    obj_part  -16,   -4, $06, $00
    obj_part  -16,    4, $0a, $00
.box_24x32_rowswap_page0_flipX:
    db   6
    obj_part    0,    4, $10, OAMF_XFLIP
    obj_part    0,   -4, $14, OAMF_XFLIP
    obj_part    0,  -12, $18, OAMF_XFLIP
    obj_part  -16,    4, $12, OAMF_XFLIP
    obj_part  -16,   -4, $16, OAMF_XFLIP
    obj_part  -16,  -12, $1a, OAMF_XFLIP
.box_24x32_rowswap_page1_flipX:
    db   6
    obj_part    0,    4, $00, OAMF_XFLIP
    obj_part    0,   -4, $04, OAMF_XFLIP
    obj_part    0,  -12, $08, OAMF_XFLIP
    obj_part  -16,    4, $02, OAMF_XFLIP
    obj_part  -16,   -4, $06, OAMF_XFLIP
    obj_part  -16,  -12, $0a, OAMF_XFLIP
.box_32x32_page0:
    db   8
    obj_part  -16,  -16, $10, $00
    obj_part  -16,   -8, $14, $00
    obj_part  -16,    0, $18, $00
    obj_part  -16,    8, $1c, $00
    obj_part    0,  -16, $12, $00
    obj_part    0,   -8, $16, $00
    obj_part    0,    0, $1a, $00
    obj_part    0,    8, $1e, $00
.box_32x32_page1:
    db   8
    obj_part  -16,  -16, $00, $00
    obj_part  -16,   -8, $04, $00
    obj_part  -16,    0, $08, $00
    obj_part  -16,    8, $0c, $00
    obj_part    0,  -16, $02, $00
    obj_part    0,   -8, $06, $00
    obj_part    0,    0, $0a, $00
    obj_part    0,    8, $0e, $00
.box_32x32_page0_flipX:
    db   8
    obj_part  -16,    8, $10, OAMF_XFLIP
    obj_part  -16,    0, $14, OAMF_XFLIP
    obj_part  -16,   -8, $18, OAMF_XFLIP
    obj_part  -16,  -16, $1c, OAMF_XFLIP
    obj_part    0,    8, $12, OAMF_XFLIP
    obj_part    0,    0, $16, OAMF_XFLIP
    obj_part    0,   -8, $1a, OAMF_XFLIP
    obj_part    0,  -16, $1e, OAMF_XFLIP
.box_32x32_page1_flipX:
    db   8
    obj_part  -16,    8, $00, OAMF_XFLIP
    obj_part  -16,    0, $04, OAMF_XFLIP
    obj_part  -16,   -8, $08, OAMF_XFLIP
    obj_part  -16,  -16, $0c, OAMF_XFLIP
    obj_part    0,    8, $02, OAMF_XFLIP
    obj_part    0,    0, $06, OAMF_XFLIP
    obj_part    0,   -8, $0a, OAMF_XFLIP
    obj_part    0,  -16, $0e, OAMF_XFLIP
.box_32x32_flipY_page0:
    db   8
    obj_part    0,  -16, $10, OAMF_YFLIP
    obj_part    0,   -8, $14, OAMF_YFLIP
    obj_part    0,    0, $18, OAMF_YFLIP
    obj_part    0,    8, $1c, OAMF_YFLIP
    obj_part  -16,  -16, $12, OAMF_YFLIP
    obj_part  -16,   -8, $16, OAMF_YFLIP
    obj_part  -16,    0, $1a, OAMF_YFLIP
    obj_part  -16,    8, $1e, OAMF_YFLIP
.box_32x32_flipY_page1:
    db   8
    obj_part    0,  -16, $00, OAMF_YFLIP
    obj_part    0,   -8, $04, OAMF_YFLIP
    obj_part    0,    0, $08, OAMF_YFLIP
    obj_part    0,    8, $0c, OAMF_YFLIP
    obj_part  -16,  -16, $02, OAMF_YFLIP
    obj_part  -16,   -8, $06, OAMF_YFLIP
    obj_part  -16,    0, $0a, OAMF_YFLIP
    obj_part  -16,    8, $0e, OAMF_YFLIP
.box_32x32_flipY_page0_flipX:
    db   8
    obj_part    0,    8, $10, OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,    0, $14, OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,   -8, $18, OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,  -16, $1c, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    8, $12, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    0, $16, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,   -8, $1a, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,  -16, $1e, OAMF_XFLIP | OAMF_YFLIP
.box_32x32_flipY_page1_flipX:
    db   8
    obj_part    0,    8, $00, OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,    0, $04, OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,   -8, $08, OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,  -16, $0c, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    8, $02, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    0, $06, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,   -8, $0a, OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,  -16, $0e, OAMF_XFLIP | OAMF_YFLIP
.box_8x16_page0:
    db   1
    obj_part    0,   -4, $10, $00
.box_8x16_page1:
    db   1
    obj_part    0,   -4, $00, $00
.box_8x16_page0_flipX:
    db   1
    obj_part    0,   -4, $10, OAMF_XFLIP
.box_8x16_page1_flipX:
    db   1
    obj_part    0,   -4, $00, OAMF_XFLIP
.box_16x16_page0:
    db   2
    obj_part    0,   -8, $10, $00
    obj_part    0,    0, $14, $00
.box_16x16_page1:
    db   2
    obj_part    0,   -8, $00, $00
    obj_part    0,    0, $04, $00
.box_16x16_page0_flipX:
    db   2
    obj_part    0,    0, $10, OAMF_XFLIP
    obj_part    0,   -8, $14, OAMF_XFLIP
.box_16x16_page1_flipX:
    db   2
    obj_part    0,    0, $00, OAMF_XFLIP
    obj_part    0,   -8, $04, OAMF_XFLIP
.box_24x16_page0:
    db   3
    obj_part    0,  -12, $10, $00
    obj_part    0,   -4, $14, $00
    obj_part    0,    4, $18, $00
.box_24x16_page1:
    db   3
    obj_part    0,  -12, $00, $00
    obj_part    0,   -4, $04, $00
    obj_part    0,    4, $08, $00
.box_24x16_page0_flipX:
    db   3
    obj_part    0,    4, $10, OAMF_XFLIP
    obj_part    0,   -4, $14, OAMF_XFLIP
    obj_part    0,  -12, $18, OAMF_XFLIP
.box_24x16_page1_flipX:
    db   3
    obj_part    0,    4, $00, OAMF_XFLIP
    obj_part    0,   -4, $04, OAMF_XFLIP
    obj_part    0,  -12, $08, OAMF_XFLIP
.box_32x16_page0:
    db   4
    obj_part    0,  -16, $10, $00
    obj_part    0,   -8, $14, $00
    obj_part    0,    0, $18, $00
    obj_part    0,    8, $1c, $00
.box_32x16_page1:
    db   4
    obj_part    0,  -16, $00, $00
    obj_part    0,   -8, $04, $00
    obj_part    0,    0, $08, $00
    obj_part    0,    8, $0c, $00
.box_32x16_page0_flipX:
    db   4
    obj_part    0,    8, $10, OAMF_XFLIP
    obj_part    0,    0, $14, OAMF_XFLIP
    obj_part    0,   -8, $18, OAMF_XFLIP
    obj_part    0,  -16, $1c, OAMF_XFLIP
.box_32x16_page1_flipX:
    db   4
    obj_part    0,    8, $00, OAMF_XFLIP
    obj_part    0,    0, $04, OAMF_XFLIP
    obj_part    0,   -8, $08, OAMF_XFLIP
    obj_part    0,  -16, $0c, OAMF_XFLIP
.box_32x32_ahead8_page0:
    db   8
    obj_part  -16,   -8, $10, $00
    obj_part  -16,    0, $14, $00
    obj_part  -16,    8, $18, $00
    obj_part  -16,   16, $1c, $00
    obj_part    0,   -8, $12, $00
    obj_part    0,    0, $16, $00
    obj_part    0,    8, $1a, $00
    obj_part    0,   16, $1e, $00
.box_32x32_ahead8_page1:
    db   8
    obj_part  -16,   -8, $00, $00
    obj_part  -16,    0, $04, $00
    obj_part  -16,    8, $08, $00
    obj_part  -16,   16, $0c, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $06, $00
    obj_part    0,    8, $0a, $00
    obj_part    0,   16, $0e, $00
.box_32x32_ahead8_page0_flipX:
    db   8
    obj_part  -16,    0, $10, OAMF_XFLIP
    obj_part  -16,   -8, $14, OAMF_XFLIP
    obj_part  -16,  -16, $18, OAMF_XFLIP
    obj_part  -16,  -24, $1c, OAMF_XFLIP
    obj_part    0,    0, $12, OAMF_XFLIP
    obj_part    0,   -8, $16, OAMF_XFLIP
    obj_part    0,  -16, $1a, OAMF_XFLIP
    obj_part    0,  -24, $1e, OAMF_XFLIP
.box_32x32_ahead8_page1_flipX:
    db   8
    obj_part  -16,    0, $00, OAMF_XFLIP
    obj_part  -16,   -8, $04, OAMF_XFLIP
    obj_part  -16,  -16, $08, OAMF_XFLIP
    obj_part  -16,  -24, $0c, OAMF_XFLIP
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,   -8, $06, OAMF_XFLIP
    obj_part    0,  -16, $0a, OAMF_XFLIP
    obj_part    0,  -24, $0e, OAMF_XFLIP
.box_32x32_ahead4_page0:
    db   8
    obj_part  -16,  -12, $10, $00
    obj_part  -16,   -4, $14, $00
    obj_part  -16,    4, $18, $00
    obj_part  -16,   12, $1c, $00
    obj_part    0,  -12, $12, $00
    obj_part    0,   -4, $16, $00
    obj_part    0,    4, $1a, $00
    obj_part    0,   12, $1e, $00
.box_32x32_ahead4_page1:
    db   8
    obj_part  -16,  -12, $00, $00
    obj_part  -16,   -4, $04, $00
    obj_part  -16,    4, $08, $00
    obj_part  -16,   12, $0c, $00
    obj_part    0,  -12, $02, $00
    obj_part    0,   -4, $06, $00
    obj_part    0,    4, $0a, $00
    obj_part    0,   12, $0e, $00
.box_32x32_ahead4_page0_flipX:
    db   8
    obj_part  -16,    4, $10, OAMF_XFLIP
    obj_part  -16,   -4, $14, OAMF_XFLIP
    obj_part  -16,  -12, $18, OAMF_XFLIP
    obj_part  -16,  -20, $1c, OAMF_XFLIP
    obj_part    0,    4, $12, OAMF_XFLIP
    obj_part    0,   -4, $16, OAMF_XFLIP
    obj_part    0,  -12, $1a, OAMF_XFLIP
    obj_part    0,  -20, $1e, OAMF_XFLIP
.box_32x32_ahead4_page1_flipX:
    db   8
    obj_part  -16,    4, $00, OAMF_XFLIP
    obj_part  -16,   -4, $04, OAMF_XFLIP
    obj_part  -16,  -12, $08, OAMF_XFLIP
    obj_part  -16,  -20, $0c, OAMF_XFLIP
    obj_part    0,    4, $02, OAMF_XFLIP
    obj_part    0,   -4, $06, OAMF_XFLIP
    obj_part    0,  -12, $0a, OAMF_XFLIP
    obj_part    0,  -20, $0e, OAMF_XFLIP
.box_32x32_behind4_page0:
    db   8
    obj_part  -16,  -20, $10, $00
    obj_part  -16,  -12, $14, $00
    obj_part  -16,   -4, $18, $00
    obj_part  -16,    4, $1c, $00
    obj_part    0,  -20, $12, $00
    obj_part    0,  -12, $16, $00
    obj_part    0,   -4, $1a, $00
    obj_part    0,    4, $1e, $00
.box_32x32_behind4_page1:
    db   8
    obj_part  -16,  -20, $00, $00
    obj_part  -16,  -12, $04, $00
    obj_part  -16,   -4, $08, $00
    obj_part  -16,    4, $0c, $00
    obj_part    0,  -20, $02, $00
    obj_part    0,  -12, $06, $00
    obj_part    0,   -4, $0a, $00
    obj_part    0,    4, $0e, $00
.box_32x32_behind4_page0_flipX:
    db   8
    obj_part  -16,   12, $10, OAMF_XFLIP
    obj_part  -16,    4, $14, OAMF_XFLIP
    obj_part  -16,   -4, $18, OAMF_XFLIP
    obj_part  -16,  -12, $1c, OAMF_XFLIP
    obj_part    0,   12, $12, OAMF_XFLIP
    obj_part    0,    4, $16, OAMF_XFLIP
    obj_part    0,   -4, $1a, OAMF_XFLIP
    obj_part    0,  -12, $1e, OAMF_XFLIP
.box_32x32_behind4_page1_flipX:
    db   8
    obj_part  -16,   12, $00, OAMF_XFLIP
    obj_part  -16,    4, $04, OAMF_XFLIP
    obj_part  -16,   -4, $08, OAMF_XFLIP
    obj_part  -16,  -12, $0c, OAMF_XFLIP
    obj_part    0,   12, $02, OAMF_XFLIP
    obj_part    0,    4, $06, OAMF_XFLIP
    obj_part    0,   -4, $0a, OAMF_XFLIP
    obj_part    0,  -12, $0e, OAMF_XFLIP

data_03_5a8a_SpriteShapeTable_Alt:
; The other shape table, chosen when bit 7 of a shape index is set. Because that
; branch replaces the index with (value - $80) instead of adding the page and
; facing bits, the four-entry grouping of the main table does not apply here and
; every shape is a single entry. Both entities that reach it - ENTITY_UNK_02 and
; ENTITY_SCREAM_TV_ZOMBIE_HEAD - carry $80, so only entry $00 is ever used;
; entries $01-$0A are a full unused set of rows and boxes
    dw   .row_8x16                                        ; $00
    dw   .row_16x16                                       ; $01 - unreachable
    dw   .row_24x16                                       ; $02 - unreachable
    dw   .row_32x16                                       ; $03 - unreachable
    dw   .box_8x32                                        ; $04 - unreachable
    dw   .box_16x32                                       ; $05 - unreachable
    dw   .box_24x32                                       ; $06 - unreachable
    dw   .box_32x32                                       ; $07 - unreachable
    dw   .pair_16x16                                      ; $08 - unreachable
    dw   .pair_32x16                                      ; $09 - unreachable
    dw   .pair_64x16                                      ; $0a - unreachable

; The .pair_* three are the interesting ones and the reason this table exists at
; all: they build a symmetric object out of one half of it, mirroring the same two
; tiles about the entity's position. .pair_64x16 draws eight parts from two tiles
;
.row_8x16:
    db   1
    obj_part    0,   -4, $00, $00
.row_16x16:
    db   2
    obj_part    0,   -8, $00, $00
    obj_part    0,    0, $02, $00
.row_24x16:
    db   3
    obj_part    0,  -12, $00, $00
    obj_part    0,   -4, $02, $00
    obj_part    0,    4, $04, $00
.row_32x16:
    db   4
    obj_part    0,  -16, $00, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $04, $00
    obj_part    0,    8, $06, $00
.box_8x32:
    db   2
    obj_part  -16,   -4, $00, $00
    obj_part    0,   -4, $02, $00
.box_16x32:
    db   4
    obj_part  -16,   -8, $00, $00
    obj_part  -16,    0, $04, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $06, $00
.box_24x32:
    db   6
    obj_part  -16,  -12, $00, $00
    obj_part  -16,   -4, $04, $00
    obj_part  -16,    4, $08, $00
    obj_part    0,  -12, $02, $00
    obj_part    0,   -4, $06, $00
    obj_part    0,    4, $0a, $00
.box_32x32:
    db   8
    obj_part  -16,  -16, $00, $00
    obj_part  -16,   -8, $04, $00
    obj_part  -16,    0, $08, $00
    obj_part  -16,    8, $0c, $00
    obj_part    0,  -16, $02, $00
    obj_part    0,   -8, $06, $00
    obj_part    0,    0, $0a, $00
    obj_part    0,    8, $0e, $00
.pair_16x16:
    db   2
    obj_part    0,   -8, $00, $00
    obj_part    0,    0, $00, OAMF_XFLIP
.pair_32x16:
    db   4
    obj_part    0,  -16, $00, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,    8, $00, OAMF_XFLIP
.pair_64x16:
    db   8
    obj_part    0,  -32, $00, $00
    obj_part    0,  -24, $02, $00
    obj_part    0,  -16, $02, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,    8, $02, OAMF_XFLIP
    obj_part    0,   16, $02, OAMF_XFLIP
    obj_part    0,   24, $00, OAMF_XFLIP


; ==================================================================
; THE BUILDERS
;
; Everything above is data. From here on it is the code that reads it
; ==================================================================

call_03_5b5b_HUD_BuildSprites:
; Fills the eight sprites of wCC80_ShadowOAM_HudSprites - the status row along the
; bottom of the screen - from one of five fixed layouts.
;
; NONE OF THE LAYOUTS CONTAIN A NUMBER. Every table below is static: fixed X, fixed
; tile id, fixed attributes. What changes when you gain a life or pick something up is
; the PIXEL DATA behind those tile ids, rewritten into VRAM by the loaders in
; bank03_hud_tiles.asm when a bit of wD60E_HUDDirtyFlags says so. So the row is eight
; permanent windows onto VRAM, and the tile numbers below double as names for what each
; window shows - VRAM_DIGIT_HUNDREDS is $8748, i.e. tile $74, and so on.
;
; The Y byte is not in the tables either: all eight take it from C, which is
; wD688_FlyAnimationPosition. call_00_05c7_FlyPowerup_Update walking that byte between
; $88 and $A0 is the whole of the slide-on/slide-off animation. Outside the hub the
; slide is skipped for three of the layouts by forcing C to $88, the resting height.
;
; Which layout runs, in the order the code tests:
;
;   hub (level 0)         .data_03_5beb_HudRow_MediaDimension, sliding
;   demo mode             .data_03_5bd3_HudRow_DemoBanner, parked
;   collectible mode      .data_03_5c03_HudRow_Timer, parked - or
;                         .data_03_5c1b_HudRow_TimerBlink for 15 frames of each of the
;                         last ten seconds, which is how the clock flashes
;   fly popup showing     .data_03_5bbb_HudRow_LivesAndCollectibles, sliding
;   otherwise             .jp_03_5c33_HUD_BuildSprites_Health, sliding
;
; The last two are the same row of hardware sprites showing two different things, and
; wD687_FlyAnimationState bit 7 is the switch. A level entered with the fly popup up
; ($41) shows the lives and collectible counters, then FlyPowerup_Update flips it to
; $81 and the hearts take over
    ld   A, [wD688_FlyAnimationPosition]
    ld   C, A
    ld   DE, .data_03_5beb_HudRow_MediaDimension
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    jr   Z, .jr_03_5ba7
    ld   C, $88
    ld   DE, .data_03_5bd3_HudRow_DemoBanner
    ld   A, [wD61E_DemoModeEnabled]
    and  A, A
    jr   NZ, .jr_03_5ba7
    ld   A, [wD623_CollectibleMode]
    and  A, A
    jr   Z, .jr_03_5b98
    ld   DE, .data_03_5c03_HudRow_Timer
    ld   A, [wD76F_LevelTimer_Minutes]
    and  A, A
    jr   NZ, .jr_03_5ba7
    ld   A, [wD770_LevelTimer_SecondsBCD]
    and  A, A
    jr   Z, .jr_03_5ba7
    and  A, $f0
    jr   NZ, .jr_03_5ba7
    ld   A, [wD771_LevelTimer_FrameCounter]
    cp   A, $0f
    jr   NC, .jr_03_5ba7
    ld   DE, .data_03_5c1b_HudRow_TimerBlink
    jr   .jr_03_5ba7
.jr_03_5b98:
    ld   A, [wD687_FlyAnimationState]
    and  A, $80
    jp   NZ, .jp_03_5c33_HUD_BuildSprites_Health
    ld   A, [wD688_FlyAnimationPosition]
    ld   C, A
    ld   DE, .data_03_5bbb_HudRow_LivesAndCollectibles
.jr_03_5ba7:
    ld   HL, wCC80_ShadowOAM_HudSprites
    ld   B, $08
.jr_03_5bac:
    ld   A, C
    ld   [HL+], A
    ld   A, [DE]
    inc  DE
    ld   [HL+], A
    ld   A, [DE]
    inc  DE
    ld   [HL+], A
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    dec  B
    jr   NZ, .jr_03_5bac
    ret
; All five rows use OAMF_PAL1 (DMG palette 1) and CGB OBJ palette 0, except the
; collectible icon, which takes CGB palette 1 because its artwork is per-level and
; loaded with its own palette by call_03_6941_HUD_LoadCollectibleSprites

.data_03_5bbb_HudRow_LivesAndCollectibles:
; The normal in-level row, shown while the fly popup is up. Two 8x16 sprites of fixed
; art, then the three lives digits at a 6-pixel pitch so the glyphs tuck together,
; then the collectible icon and its two digits
    hud_sprite $32, $70, OAMF_PAL1                     ; fixed art, tiles $70-$73
    hud_sprite $3a, $72, OAMF_PAL1
    hud_sprite $43, $74, OAMF_PAL1                     ; VRAM_DIGIT_HUNDREDS - lives
    hud_sprite $49, $76, OAMF_PAL1                     ; VRAM_DIGIT_TENS
    hud_sprite $4f, $78, OAMF_PAL1                     ; VRAM_DIGIT_ONES
    hud_sprite $67, $7e, OAMF_PAL1 | 1                 ; VRAM_COLLECTIBLE_SPRITES
    hud_sprite $70, $7a, OAMF_PAL1                     ; VRAM_DIGIT_COLLECTIBLE_TENS
    hud_sprite $76, $7c, OAMF_PAL1                     ; VRAM_DIGIT_COLLECTIBLE_ONES

.data_03_5bd3_HudRow_DemoBanner:
; Demo mode only. Eight sprites at an even 8-pixel pitch covering tiles $68-$77, which
; is exactly the 16 tiles call_03_66ae_HUD_LoadTiles copies to
; VRAM_HUD_DEMO_MODE_OR_TIMER - so this row is one 64x16 banner and nothing else
    hud_sprite $38, $68, OAMF_PAL1
    hud_sprite $40, $6a, OAMF_PAL1
    hud_sprite $48, $6c, OAMF_PAL1
    hud_sprite $50, $6e, OAMF_PAL1
    hud_sprite $58, $70, OAMF_PAL1
    hud_sprite $60, $72, OAMF_PAL1
    hud_sprite $68, $74, OAMF_PAL1
    hud_sprite $70, $76, OAMF_PAL1

.data_03_5beb_HudRow_MediaDimension:
; The hub. Same 64x16 banner shape as the demo row, one tile page lower - tiles
; $60-$6F, the front of the image loaded to VRAM_HUD_TILES. The hub has no lives or
; collectible counters to show
    hud_sprite $38, $60, OAMF_PAL1
    hud_sprite $40, $62, OAMF_PAL1
    hud_sprite $48, $64, OAMF_PAL1
    hud_sprite $50, $66, OAMF_PAL1
    hud_sprite $58, $68, OAMF_PAL1
    hud_sprite $60, $6a, OAMF_PAL1
    hud_sprite $68, $6c, OAMF_PAL1
    hud_sprite $70, $6e, OAMF_PAL1

.data_03_5c03_HudRow_Timer:
; Collectible (timed) mode. The three digit windows are reused for the clock with the
; colon between them - tile $68 is VRAM_HUD_DEMO_MODE_OR_TIMER, the slot the demo
; banner would occupy, which is why a demo can never be timed. The collectible icon and
; counter move right to make room, and the lives icon is parked at X 0, off the left
; edge of the screen
    hud_sprite $18, $74, OAMF_PAL1                     ; minutes
    hud_sprite $20, $68, OAMF_PAL1                     ; colon
    hud_sprite $28, $76, OAMF_PAL1                     ; seconds, tens
    hud_sprite $30, $78, OAMF_PAL1                     ; seconds, ones
    hud_sprite $80, $7e, OAMF_PAL1 | 1                 ; collectible icon
    hud_sprite $88, $7a, OAMF_PAL1
    hud_sprite $90, $7c, OAMF_PAL1
    hud_sprite $00, $70, OAMF_PAL1                     ; hidden

.data_03_5c1b_HudRow_TimerBlink:
; The row above with the clock hidden. Selected while the timer reads under ten
; seconds and wD771_LevelTimer_FrameCounter is below $0F, so the four clock sprites
; vanish for part of every second and the collectible counter carries on unblinking
    hud_sprite $00, $74, OAMF_PAL1                     ; hidden
    hud_sprite $00, $68, OAMF_PAL1                     ; hidden
    hud_sprite $00, $76, OAMF_PAL1                     ; hidden
    hud_sprite $00, $78, OAMF_PAL1                     ; hidden
    hud_sprite $80, $7e, OAMF_PAL1 | 1
    hud_sprite $88, $7a, OAMF_PAL1
    hud_sprite $90, $7c, OAMF_PAL1
    hud_sprite $00, $70, OAMF_PAL1                     ; hidden
.jp_03_5c33_HUD_BuildSprites_Health:
; The health row - four hearts, each two 8x16 sprites wide, so the same eight hardware
; sprites as every other layout.
;
; Rather than draw one heart at a time and count, it keeps a whole prebuilt row per
; health value and indexes it with `swap A` - health x 16 - so a heart row is 16 bytes
; and there are five of them for health $00 to $04. That is why the records here are
; two bytes and not three: the attribute is the same for all of them and is written as
; a literal further down.
;
; There is no bound on the index. wD741_Player_Health never exceeds $04
; (call_00_06b7_Player_ResetHealth is the only thing that raises it, and it writes a
; literal $04), but a value of $05 would read the 16 bytes at $5CA8, which are the
; first instructions of call_03_5ca8_Player_BuildSprites
    ld   A, [wD741_Player_Health]
    swap A                                             ; health * 16
    add  A, $58
    ld   E, A
    ld   A, $00
    adc  A, $5c
    ld   D, A
    ld   A, [wD688_FlyAnimationPosition]
    ld   C, A
    ld   HL, wCC80_ShadowOAM_HudSprites
    ld   B, $08
.jr_03_5c49:
    ld   A, C
    ld   [HL+], A
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, [DE]
    ld   [HL+], A
    inc  DE
    ld   A, OAMF_PAL1
    ld   [HL+], A
    dec  B
    jr   NZ, .jr_03_5c49
    ret

.data_03_5c58_HudHeartsByHealth:
; Five prebuilt heart rows, indexed by wD741_Player_Health. Each row is eight
; (X, tile) pairs - four hearts at X $2c, $44, $5c, $74, each built from a left half
; and a right half eight pixels along.
;
; Only two pieces of artwork are involved: tiles $68/$6a are the left and right halves
; of a full heart and $6c/$6e the halves of an empty one. Reading down the rows, one
; more heart fills each time, which is the whole animation
    db   $2c, $6c, $34, $6e                            ; health $00 - all four empty
    db   $44, $6c, $4c, $6e
    db   $5c, $6c, $64, $6e
    db   $74, $6c, $7c, $6e
    db   $2c, $68, $34, $6a                            ; health $01 - one full
    db   $44, $6c, $4c, $6e
    db   $5c, $6c, $64, $6e
    db   $74, $6c, $7c, $6e
    db   $2c, $68, $34, $6a                            ; health $02
    db   $44, $68, $4c, $6a
    db   $5c, $6c, $64, $6e
    db   $74, $6c, $7c, $6e
    db   $2c, $68, $34, $6a                            ; health $03
    db   $44, $68, $4c, $6a
    db   $5c, $68, $64, $6a
    db   $74, $6c, $7c, $6e
    db   $2c, $68, $34, $6a                            ; health $04 - full
    db   $44, $68, $4c, $6a
    db   $5c, $68, $64, $6a
    db   $74, $68, $7c, $6a

call_03_5ca8_Player_BuildSprites:
; Gex's own sprite builder, separate from the entity one and simpler, because he is
; always the same 32x32 rectangle. It picks one of the eight entries of
; .data_03_5d6f_PlayerSpriteShapeTable from wD586_PlayerGfxVramPage plus 2 for facing
; left and 4 for CLIMB_FLAG_ALT_FRAMES, works out his screen position as world minus
; scroll plus the OAM bias ($08 across, $10 down), and copies eight OAM entries into
; the front of wCC00_ShadowOAM - the region entities are forbidden from touching.
;
; Two things make him flicker, and both swap the shape for
; .data_03_5e7f_PlayerShapeHidden with BC cleared, which parks all eight sprites off
; screen for that frame:
;
;   wD750_Player_DamageCooldownTimer    bit 3, so he strobes every 8 frames after a hit
;   a power-up shield is running        wD751/wD753/wD755, strobed on bit 3 of the
;                                       global frame counter - but only on a DMG.
;                                       wD59E_OnGBCFlag skips the test entirely,
;                                       because on a Colour Game Boy the shield shows
;                                       as a cycling palette instead
;
; PLAYER_ACTION_DEATH_SET_UP_WARP is checked first and jumps PAST both tests, so during
; the death warp Gex is drawn solidly rather than flickering - which is the point of
; call_00_0f5d_FadeToBlack using a mask that leaves OBP1 alone. The world darkens
; around him and he stays lit.
;
; Each part's attribute byte is OR'd with wD74A_Player_InWaterOrLava on the way out.
; That byte is $80 - OAMF_PRI - while he is NOT in liquid and $00 while he is, so he
; normally renders behind solid background pixels and comes to the front on the frames
; he is in water or lava
    ld   A, [wD586_PlayerGfxVramPage]
    ld   HL, wD20D_Player_FacingFlags
    bit  5, [HL]
    jr   Z, .jr_03_5cb4
    add  A, $02
.jr_03_5cb4:
    ld   HL, wD74B_Player_ClimbingFlags
    bit  6, [HL]
    jr   Z, .jr_03_5cbd
    add  A, $04
.jr_03_5cbd:
    ld   DE, .data_03_5d6f_PlayerSpriteShapeTable
    call call_00_07b9_GetPointerFromTable
    ld   A, [wD6ED_BgMap_ScrollX]
    ld   C, A
    ld   A, [wD20E_Player_XPositionLo]
    sub  A, C
    add  A, $08
    ld   C, A
    ld   [wD212_Player_ScreenXPosition], A
    ld   A, [wD6EF_BgMap_ScrollY]
    ld   B, A
    ld   A, [wD210_Player_YPositionLo]
    sub  A, B
    add  A, $10
    ld   B, A
    ld   [wD213_Player_ScreenYPosition], A
    ld   A, [wD201_Player_ActionId]
    and  A, PLAYER_ACTION_MASK
    cp   A, PLAYER_ACTION_DEATH_SET_UP_WARP
    jr   Z, .jr_03_5d11
    ld   A, [wD750_Player_DamageCooldownTimer]
    and  A, $08
    jr   NZ, .jr_03_5d0b
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jr   NZ, .jr_03_5d11
    push HL
    ld   A, [wD755_FlyPowerup2_TimerLo]
    ld   HL, wD753_FlyPowerup1_TimerLo
    or   A, [HL]
    ld   HL, wD751_Player_CircuitPowerUpTimerLo
    or   A, [HL]
    pop  HL
    jr   Z, .jr_03_5d11
    ld   A, [wD73B_VBlankFrameCounter]
    and  A, $08
    jr   Z, .jr_03_5d11
.jr_03_5d0b:
    ld   HL, .data_03_5e7f_PlayerShapeHidden
    ld   BC, $00
.jr_03_5d11:
    ld   DE, wCC00_ShadowOAM
    ld   A, $08
.jr_03_5d16:
    push AF
    ld   A, [HL+]
    add  A, B
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    add  A, C
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [wD74A_Player_InWaterOrLava]
    or   A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
    pop  AF
    dec  A
    jr   NZ, .jr_03_5d16
    ld   A, [wD742_Player_CurrentFly]
    and  A, A
    ret  Z
    ld   A, [wD212_Player_ScreenXPosition]
    ld   [wD76C_FlyPowerup_AnchorX], A
    ld   A, [wD213_Player_ScreenYPosition]
    sub  A, $20
    ld   [wD76D_FlyPowerup_AnchorY], A
    ld   HL, wD739_Entity_OamWriteOffset
    ld   E, [HL]
    ld   A, E
    add  A, $04
    ld   [HL], A
    ld   D, $cc
    ld   HL, wD76E_FlyPowerup_OrbitPhase
    inc  [HL]
    ld   A, [HL]
    rrca
    and  A, $0f
    add  A, A
    ld   L, A
    ld   H, $00
    ld   BC, .data_03_5e9f_FlyParticleOffsetTable
    add  HL, BC
    ld   A, [wD76D_FlyPowerup_AnchorY]
    add  A, [HL]
    ld   [DE], A
    inc  E
    inc  HL
    ld   A, [wD76C_FlyPowerup_AnchorX]
    add  A, [HL]
    ld   [DE], A
    inc  E
    ld   A, $66
    ld   [DE], A
    inc  E
    ld   A, $02
    ld   [DE], A
    ret
.data_03_5d6f_PlayerSpriteShapeTable:
; Gex is always the same shape: four columns of 8x16 sprites by two rows, 32x32
; pixels, centred on his position. All eight entries here are that one rectangle - what
; differs is which tile page it reads and which way it is flipped.
;
; call_03_5ca8_Player_BuildSprites builds the index as
;
;     wD586_PlayerGfxVramPage + 2 (facing left) + 4 (CLIMB_FLAG_ALT_FRAMES)
;
; so bit 0 swaps between the two double-buffered player tile pages at $8000 and $8100
; - the layouts differ only in whether their tile numbers start at $10 or $00 - bit 1
; is OAMF_XFLIP with the columns reversed, and bit 2 is OAMF_YFLIP with the rows
; swapped. Setting both gives a 180 degree rotation, which is exactly what
; .data_02_4557_BackgroundClimbSpriteFlagsByDirection asks for when Gex climbs
; downwards on a chain-link fence.
;
; Every part carries OAMF_PAL1 as well, because Gex's tiles live in the palette the
; HUD does not use
    dw   .player_shape_page0
    dw   .player_shape_page1
    dw   .player_shape_page0_flipX
    dw   .player_shape_page1_flipX
    dw   .player_shape_page0_flipY
    dw   .player_shape_page1_flipY
    dw   .player_shape_page0_flipXY
    dw   .player_shape_page1_flipXY

.player_shape_page0:                                ; $00 - facing right
    obj_part  -16,  -16, $10, OAMF_PAL1
    obj_part  -16,   -8, $14, OAMF_PAL1
    obj_part  -16,    0, $18, OAMF_PAL1
    obj_part  -16,    8, $1c, OAMF_PAL1
    obj_part    0,  -16, $12, OAMF_PAL1
    obj_part    0,   -8, $16, OAMF_PAL1
    obj_part    0,    0, $1a, OAMF_PAL1
    obj_part    0,    8, $1e, OAMF_PAL1
.player_shape_page1:                                ; $01 - facing right, other tile page
    obj_part  -16,  -16, $00, OAMF_PAL1
    obj_part  -16,   -8, $04, OAMF_PAL1
    obj_part  -16,    0, $08, OAMF_PAL1
    obj_part  -16,    8, $0c, OAMF_PAL1
    obj_part    0,  -16, $02, OAMF_PAL1
    obj_part    0,   -8, $06, OAMF_PAL1
    obj_part    0,    0, $0a, OAMF_PAL1
    obj_part    0,    8, $0e, OAMF_PAL1
.player_shape_page0_flipX:                          ; $02 - facing left
    obj_part  -16,    8, $10, OAMF_PAL1 | OAMF_XFLIP
    obj_part  -16,    0, $14, OAMF_PAL1 | OAMF_XFLIP
    obj_part  -16,   -8, $18, OAMF_PAL1 | OAMF_XFLIP
    obj_part  -16,  -16, $1c, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,    8, $12, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,    0, $16, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,   -8, $1a, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,  -16, $1e, OAMF_PAL1 | OAMF_XFLIP
.player_shape_page1_flipX:                          ; $03 - facing left, other tile page
    obj_part  -16,    8, $00, OAMF_PAL1 | OAMF_XFLIP
    obj_part  -16,    0, $04, OAMF_PAL1 | OAMF_XFLIP
    obj_part  -16,   -8, $08, OAMF_PAL1 | OAMF_XFLIP
    obj_part  -16,  -16, $0c, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,    8, $02, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,    0, $06, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,   -8, $0a, OAMF_PAL1 | OAMF_XFLIP
    obj_part    0,  -16, $0e, OAMF_PAL1 | OAMF_XFLIP
.player_shape_page0_flipY:                          ; $04 - climbing down - upside down
    obj_part    0,  -16, $10, OAMF_PAL1 | OAMF_YFLIP
    obj_part    0,   -8, $14, OAMF_PAL1 | OAMF_YFLIP
    obj_part    0,    0, $18, OAMF_PAL1 | OAMF_YFLIP
    obj_part    0,    8, $1c, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,  -16, $12, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,   -8, $16, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,    0, $1a, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,    8, $1e, OAMF_PAL1 | OAMF_YFLIP
.player_shape_page1_flipY:                          ; $05 - climbing down, other tile page
    obj_part    0,  -16, $00, OAMF_PAL1 | OAMF_YFLIP
    obj_part    0,   -8, $04, OAMF_PAL1 | OAMF_YFLIP
    obj_part    0,    0, $08, OAMF_PAL1 | OAMF_YFLIP
    obj_part    0,    8, $0c, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,  -16, $02, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,   -8, $06, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,    0, $0a, OAMF_PAL1 | OAMF_YFLIP
    obj_part  -16,    8, $0e, OAMF_PAL1 | OAMF_YFLIP
.player_shape_page0_flipXY:                         ; $06 - climbing down and facing left - a 180 degree turn
    obj_part    0,    8, $10, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,    0, $14, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,   -8, $18, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,  -16, $1c, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    8, $12, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    0, $16, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,   -8, $1a, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,  -16, $1e, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
.player_shape_page1_flipXY:                         ; $07 - the same, other tile page
    obj_part    0,    8, $00, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,    0, $04, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,   -8, $08, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part    0,  -16, $0c, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    8, $02, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,    0, $06, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,   -8, $0a, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
    obj_part  -16,  -16, $0e, OAMF_PAL1 | OAMF_XFLIP | OAMF_YFLIP
.data_03_5e7f_PlayerShapeHidden:
; The ninth player shape, and the one that draws nothing. Substituted for the eight
; above on the frames Gex should not be visible - the invincibility and damage
; flicker, and the whole of PLAYER_ACTION_DEATH_SET_UP_WARP.
;
; It is not a blank tile. Every part sits at offset (0, 0) and the caller pairs it with
; BC = 0, so all eight sprites are written to OAM at Y = 0, which the hardware treats
; as off the top of the screen. Tile $7e is never fetched and the value is arbitrary.
;
; Keeping the flicker as a shape rather than a branch is what lets the main copy loop
; below stay one loop with no test in it
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1
    obj_part    0,    0, $7e, OAMF_PAL1

.data_03_5e9f_FlyParticleOffsetTable:
; The path of the single fly that circles above Gex while he is carrying a power-up.
; Sixteen signed (Y, X) offsets from wD76D_FlyPowerup_AnchorY / wD76C_FlyPowerup_AnchorX,
; stepped every other frame by (wD76E_FlyPowerup_OrbitPhase >> 1) AND $0F, so one lap
; takes 32 frames.
;
; Y stays between 0 and -6 while X runs from +4 out to -8, so the "orbit" is a flat
; sixteen-step loop about twelve pixels wide and six tall rather than a circle - and it
; is deliberately uneven, doubling back on itself, which is what makes the fly read as
; buzzing rather than sweeping
    db    0, -2,  -2, -4,  -4, -2,  -4,  0
    db   -6,  2,  -4,  4,  -2,  2,   0,  4
    db    0,  2,  -2,  0,  -2, -2,  -4, -4
    db   -6, -6,  -4, -8,  -2, -6,   0, -4


call_03_5ebf_Entity_BuildSprites:
; Draws one entity, and decides on the way whether it should still exist.
;
; The OAM attribute byte is built first: a per-slot base from wD32D_Entity_OamAttrBase (a CGB
; OBJ palette number) OR'd with the entity's own FACING_FLAGS, kept in wD335_Entity_OamAttr for
; the sprite writers further down.
;
; Then two nested tests on the entity's position relative to the scroll origin, which are
; easy to misread because they are 16-bit compares done as high-byte-then-low:
;
;   the outer box is generous - X from -$28 to $B7, Y from -$10 to $EF. Outside it the
;   entity is not merely hidden, it is a candidate for removal: Entity_CheckIfOnScreen gets
;   the final say and Entity_ClearSlot frees the slot if it agrees. This is how offscreen
;   enemies get recycled
;
;   the inner box is the genuinely visible one, X $08..$A7 and Y $10..$9F once the OAM bias
;   is added. Only that sets SPRITE_FLAG_ON_SCREEN, which other systems read to decide whether an
;   entity can be interacted with
;
; Note the entity is drawn either way - failing the inner test only clears the flag. Which of
; the five sprite paths runs is then decided by the SPRITE_FLAG_* bits; see the struct notes in
; constants.asm
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD32D_Entity_OamAttrBase
    add  HL, DE
    ld   E, [HL]
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   A, [HL]
    or   A, E
    ld   [wD335_Entity_OamAttr], A
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_SPRITE_FLAGS
    ld   A, [DE]
    res  SPRITE_FLAG_ON_SCREEN_BIT, A
    ld   [DE], A
    ld   A, E
    xor  A, $04
    ld   E, A
    ld   HL, wD6ED_BgMap_ScrollX
    ld   A, [DE]
    sub  A, [HL]
    ld   C, A
    inc  HL
    inc  DE
    ld   A, [DE]
    sbc  A, [HL]
    jr   C, .jr_03_5f02
    and  A, A
    jr   NZ, .jr_03_5f2b
    ld   A, C
    cp   A, $b8
    jr   C, .jr_03_5f0b
    jr   .jr_03_5f2b
.jr_03_5f02:
    cp   A, $ff
    jr   NZ, .jr_03_5f2b
    ld   A, C
    cp   A, $d8
    jr   C, .jr_03_5f2b
.jr_03_5f0b:
    inc  E
    ld   HL, wD6EF_BgMap_ScrollY
    ld   A, [DE]
    sub  A, [HL]
    ld   B, A
    inc  HL
    inc  DE
    ld   A, [DE]
    sbc  A, [HL]
    jr   C, .jr_03_5f22
    and  A, A
    jr   NZ, .jr_03_5f2b
    ld   A, B
    cp   A, $f0
    jr   NC, .jr_03_5f2b
    jr   .jr_03_5f32
.jr_03_5f22:
    cp   A, $ff
    jr   NZ, .jr_03_5f2b
    ld   A, B
    cp   A, $f0
    jr   NC, .jr_03_5f32
.jr_03_5f2b:
    call call_00_350c_Entity_CheckIfOnScreen
    call C, call_00_3910_Entity_ClearSlot
    ret
.jr_03_5f32:
    inc  E
    ld   A, C
    add  A, $08
    ld   C, A
    ld   [DE], A                                       ; updates entity instance + 0x12
    inc  E
    ld   A, B
    add  A, $10
    ld   B, A
    ld   [DE], A                                       ; updates entity instance + 0x13
    ld   A, E
    xor  A, $19
    ld   E, A
    ld   A, C
    cp   A, $08
    jr   C, .jr_03_5f58_Entity_SelectSpritePath
    cp   A, $a8
    jr   NC, .jr_03_5f58_Entity_SelectSpritePath
    ld   A, B
    cp   A, $10
    jr   C, .jr_03_5f58_Entity_SelectSpritePath
    cp   A, $a0
    jr   NC, .jr_03_5f58_Entity_SelectSpritePath
    ld   A, [DE]
    set  SPRITE_FLAG_ON_SCREEN_BIT, A
    ld   [DE], A
.jr_03_5f58_Entity_SelectSpritePath:
; Picks one of five drawing paths from the SPRITE_FLAG_* bits, tested in this order:
; invisible, embedded sprite list, streams-own-gfx, layout-by-action, and finally the
; shape path below as the default.
;
; The shape path (and its streams-own-gfx twin, which is the same 91 bytes again -
; see the note there) draws the entity as a rectangle of 8x16 parts: entity id picks a
; row of data_03_5446_EntitySpriteDescriptors, whose byte +0 is a SPRITE_SHAPE_* index
; into data_03_5566_SpriteShapeTable_Main and whose byte +1 is the tile base. The
; index has (wD587_EntityGfxVramPage | facing left ? 2 : 0) added, which is what picks
; the mirrored variant and the right one of the two entity tile pages.
;
; The chosen layout is a part count followed by that many (dY, dX, tile, attr) parts,
; each written into wCC00_ShadowOAM at wD739_Entity_OamWriteOffset as
; (dY + B, dX + C, tile + wD73A_Entity_TileIdBase, attr | wD335_Entity_OamAttr).
; The offset is capped at $A0, so an entity that would overflow OAM is silently and
; partially dropped rather than corrupting anything past it
    ld   A, [DE]
    bit  SPRITE_FLAG_INVISIBLE_BIT, A
    jp   NZ, call_03_4c76_EntityCollision_Dispatch
    bit  SPRITE_FLAG_EMBEDDED_SPRITE_DATA_BIT, A
    jp   NZ, .jp_03_6451_Entity_BuildSprites_SpriteList
    bit  SPRITE_FLAG_STREAMS_OWN_GFX_BIT, A
    jr   NZ, .jr_03_5fcb_Entity_BuildSprites_Streamed
    bit  SPRITE_FLAG_FIXED_SHAPE_BIT, A
    jp   NZ, .jp_03_602e_Entity_BuildSprites_FixedShape
    ld   A, E
    xor  A, $07
    ld   E, A
    ld   A, [DE]
    swap A
    ld   HL, wD587_EntityGfxVramPage
    or   A, [HL]
    push AF
    ld   A, E
    xor  A, $0d
    ld   E, A
    ld   A, [DE]
    ld   L, A
    ld   H, $00
    add  HL, HL
    ld   DE, data_03_5446_EntitySpriteDescriptors + 1
    add  HL, DE
    ld   A, [HL-]
    ld   [wD73A_Entity_TileIdBase], A
    pop  AF
    bit  7, [HL]
    jr   Z, .jr_03_5f96
    ld   A, [HL]
    sub  A, $80
    ld   DE, data_03_5a8a_SpriteShapeTable_Alt
    jr   .jr_03_5f9a
.jr_03_5f96:
    add  A, [HL]
    ld   DE, data_03_5566_SpriteShapeTable_Main
.jr_03_5f9a:
    call call_00_07b9_GetPointerFromTable
    ld   A, [wD739_Entity_OamWriteOffset]
    ld   E, A
    ld   D, $cc
    ld   A, [HL+]
.jr_03_5fa4:
    push AF
    ld   A, E
    cp   A, $a0
    jr   NC, .jr_03_5fc0
    ld   A, [HL+]
    add  A, B
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    add  A, C
    ld   [DE], A
    inc  E
    ld   A, [wD73A_Entity_TileIdBase]
    add  A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
    ld   A, [wD335_Entity_OamAttr]
    or   A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
.jr_03_5fc0:
    pop  AF
    dec  A
    jr   NZ, .jr_03_5fa4
    ld   A, E
    ld   [wD739_Entity_OamWriteOffset], A
    jp   call_03_4c76_EntityCollision_Dispatch
.jr_03_5fcb_Entity_BuildSprites_Streamed:
; Sprite path for entities with SPRITE_FLAG_STREAMS_OWN_GFX set - and a byte-for-byte
; copy of the default path above it. From the `ld A, [DE]` that reads
; ENTITY_FIELD_FACING_FLAGS to the final jump, the two routines are 91 identical bytes;
; the only difference is that the default path arrives with DE on SPRITE_FLAGS and has
; to `xor $07` its way to FACING_FLAGS, while this one loads FACING_FLAGS outright.
;
; So the flag changes nothing about how the entity is drawn. What it actually selects
; is tile streaming - Entity_NotifyActionChanged and Entities_DrawAll test the same bit
; to decide whether the entity's ENTITY_FIELD_SPRITE_ID names a ROM page to pull into
; VRAM. That is the whole animation system for these entities: the shape stays put and
; the tiles underneath it are replaced
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_FACING_FLAGS
    ld   A, [DE]
    swap A
    ld   HL, wD587_EntityGfxVramPage
    or   A, [HL]
    push AF
    ld   A, E
    xor  A, $0d
    ld   E, A
    ld   A, [DE]
    ld   L, A
    ld   H, $00
    add  HL, HL
    ld   DE, data_03_5446_EntitySpriteDescriptors + 1
    add  HL, DE
    ld   A, [HL-]
    ld   [wD73A_Entity_TileIdBase], A
    pop  AF
    bit  7, [HL]
    jr   Z, .jr_03_5ff9
    ld   A, [HL]
    sub  A, $80
    ld   DE, data_03_5a8a_SpriteShapeTable_Alt
    jr   .jr_03_5ffd
.jr_03_5ff9:
    add  A, [HL]
    ld   DE, data_03_5566_SpriteShapeTable_Main
.jr_03_5ffd:
    call call_00_07b9_GetPointerFromTable
    ld   A, [wD739_Entity_OamWriteOffset]
    ld   E, A
    ld   D, $cc
    ld   A, [HL+]
.jr_03_6007:
    push AF
    ld   A, E
    cp   A, $a0
    jr   NC, .jr_03_6023
    ld   A, [HL+]
    add  A, B
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    add  A, C
    ld   [DE], A
    inc  E
    ld   A, [wD73A_Entity_TileIdBase]
    add  A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
    ld   A, [wD335_Entity_OamAttr]
    or   A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
.jr_03_6023:
    pop  AF
    dec  A
    jr   NZ, .jr_03_6007
    ld   A, E
    ld   [wD739_Entity_OamWriteOffset], A
    jp   call_03_4c76_EntityCollision_Dispatch
.jp_03_602e_Entity_BuildSprites_FixedShape:
; Sprite path for entities with SPRITE_FLAG_FIXED_SHAPE set - the platforms,
; blocks, buttons and projectiles.
;
; DESPITE THE FLAG'S NAME, THE ACTION DOES NOT PICK THE SHAPE. Follow the three
; lookups below: ENTITY_FIELD_SPRITE_ID becomes wD73A_Entity_TileIdBase, then E is
; walked to ENTITY_FIELD_ENTITY_ID to index data_03_5446_EntitySpriteDescriptors, then
; to ENTITY_FIELD_FACING_FLAGS to add 1 (the `sub A, $00` is only there to set Z).
; The action id is never read. So the shape is fixed per entity and facing for the
; entity's whole life, and what an action changes is which tiles get drawn inside it.
;
; That inverts the usual reading of ENTITY_FIELD_SPRITE_ID for these entities: it is
; not a frame number but the first tile of a group already resident in VRAM, which is
; why their animation blocks in bank02_entity_animation_data.asm so often hold a
; single frame at a tick of $FF and let the handler write the field by hand.
;
; Byte +1 of the meta row is unused here, and all 99 of these entities leave it $00.
;
; The shape blocks are the same format as the ones in bank03_sprite_frame_data.asm -
; a part count then that many obj_part records
    push BC
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_SPRITE_ID
    ld   A, [DE]
    ld   [wD73A_Entity_TileIdBase], A
    ld   A, E
    xor  A, $08
    ld   E, A
    ld   A, [DE]
    ld   L, A
    ld   H, $00
    add  HL, HL
    ld   BC, data_03_5446_EntitySpriteDescriptors
    add  HL, BC
    ld   A, E
    xor  A, $0d
    ld   E, A
    ld   A, [DE]
    sub  A, $00
    jr   Z, .jr_03_6053
    ld   A, $01
.jr_03_6053:
    add  A, [HL]
    ld   L, A
    ld   H, $00
    add  HL, HL
    ld   DE, .data_03_608e_FixedSpriteShapeTable
    add  HL, DE
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    pop  BC
    ld   A, [wD739_Entity_OamWriteOffset]
    ld   E, A
    ld   D, $cc
    ld   A, [HL+]
.jr_03_6067:
    push AF
    ld   A, E
    cp   A, $a0
    jr   NC, .jr_03_6083
    ld   A, [HL+]
    add  A, B
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    add  A, C
    ld   [DE], A
    inc  E
    ld   A, [wD73A_Entity_TileIdBase]
    add  A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
    ld   A, [wD335_Entity_OamAttr]
    or   A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
.jr_03_6083:
    pop  AF
    dec  A
    jr   NZ, .jr_03_6067
    ld   A, E
    ld   [wD739_Entity_OamWriteOffset], A
    jp   call_03_4c76_EntityCollision_Dispatch
.data_03_608e_FixedSpriteShapeTable:
; The shape catalogue for everything drawn by the routine above - the platforms,
; blocks, buttons, projectiles and other scenery. Format is exactly the same as the
; shapes in bank03_sprite_frame_data.asm: a part count, then that many obj_part
; records of (dY, dX, tile, attributes).
;
; Indexed by (byte +0 of the entity's data_03_5446_EntitySpriteDescriptors row) + 1
; when it faces left, so entries come in right/left pairs and every base index below
; is even. Note what does NOT select the shape: the action. An entity of this kind
; keeps one shape for its whole life and changes what is drawn inside it by writing
; ENTITY_FIELD_SPRITE_ID, which becomes wD73A_Entity_TileIdBase - so all the tile
; numbers here are small offsets from wherever that points.
;
; Three things are worth reading off the list. First the anchors: a plain box
; straddles the entity position, a "_below" row hangs underneath it, and a "_mirrored"
; shape is built out of half its tiles by X-flipping them about the middle - which is
; why the game can afford a 64-pixel-wide platform made of two tiles. Second, several
; left entries are not mirrors at all, just the same parts listed in reverse order, so
; they draw an identical picture. And third, ten of the twenty-nine pairs are never
; selected by any entity

    ; $00/$01  8x32 upright, straddling the position
    ;           4 entities, e.g. ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    dw   .box_8x32_right
    dw   .box_8x32_left
    ; $02/$03  16x32 upright
    ;           8 entities, e.g. ENTITY_SCREAM_TV_HEAD_GHOST
    dw   .box_16x32_right
    dw   .box_16x32_left
    ; $04/$05  24x32 upright
    ;           9 entities, e.g. ENTITY_TOON_TV_BUMBLEBEE
    dw   .box_24x32_right
    dw   .box_24x32_left
    ; $06/$07  32x32 upright
    ;           ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD, ENTITY_UNK_6D
    dw   .box_32x32_right
    dw   .box_32x32_left
    ; $08/$09  8x16, vertically centred - the standard projectile
    ;           9 entities, e.g. ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    dw   .row_8x16_right
    dw   .row_8x16_left
    ; $0a/$0b  16x16, vertically centred
    ;           13 entities, e.g. ENTITY_SCREAM_TV_FALLING_AXE
    dw   .row_16x16_right
    dw   .row_16x16_left
    ; $0c/$0d  24x16, vertically centred
    ;           5 entities, e.g. ENTITY_TOON_TV_SHARK
    dw   .row_24x16_right
    dw   .row_24x16_left
    ; $0e/$0f  32x16, vertically centred
    ;           5 entities, e.g. ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    dw   .row_32x16_right
    dw   .row_32x16_left
    ; $10/$11  8x16 - one part has nothing to mirror, so identical bytes to $08
    ;           never selected
    dw   .row_8x16_mirrored_right
    dw   .row_8x16_mirrored_left
    ; $12/$13  16x16 from one tile, mirrored about the middle
    ;           3 entities, e.g. ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    dw   .row_16x16_mirrored_right
    dw   .row_16x16_mirrored_left
    ; $14/$15  24x16 from two tiles
    ;           ENTITY_PRE_HISTORY_FIRE_PLANT
    dw   .row_24x16_mirrored_right
    dw   .row_24x16_mirrored_left
    ; $16/$17  32x16 from two tiles
    ;           never selected
    dw   .row_32x16_mirrored_right
    dw   .row_32x16_mirrored_left
    ; $18/$19  8x16, hanging below the position
    ;           never selected
    dw   .row_8x16_below_right
    dw   .row_8x16_below_left
    ; $1a/$1b  16x16, hanging below - the button and block shape
    ;           4 entities, e.g. ENTITY_TV_BUTTON
    dw   .row_16x16_below_right
    dw   .row_16x16_below_left
    ; $1c/$1d  24x16, hanging below
    ;           never selected
    dw   .row_24x16_below_right
    dw   .row_24x16_below_left
    ; $1e/$1f  32x16, hanging below - the plain platform shape
    ;           10 entities, e.g. ENTITY_SCREAM_TV_PUSH_BLOCK
    dw   .row_32x16_below_right
    dw   .row_32x16_below_left
    ; $20/$21  8x16 below - identical bytes to $18, nothing to mirror
    ;           never selected
    dw   .row_8x16_below_mirrored_right
    dw   .row_8x16_below_mirrored_left
    ; $22/$23  16x16 below from one tile
    ;           never selected
    dw   .row_16x16_below_mirrored_right
    dw   .row_16x16_below_mirrored_left
    ; $24/$25  24x16 below from two tiles
    ;           8 entities, e.g. ENTITY_PRE_HISTORY_MOVING_PLATFORM
    dw   .row_24x16_below_mirrored_right
    dw   .row_24x16_below_mirrored_left
    ; $26/$27  32x16 below from two tiles - the commonest platform shape in the game
    ;           13 entities, e.g. ENTITY_SCREAM_TV_FALLING_PLATFORM
    dw   .row_32x16_below_mirrored_right
    dw   .row_32x16_below_mirrored_left
    ; $28/$29  a four-part chain running $48 up from the position with a 32-wide blade across the bottom. Both entries are the same pointer, so it never mirrors
    ;           ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    dw   .hanging_blade
    dw   .hanging_blade
    ; $2a/$2b  24x16 sitting entirely to one side of the position rather than centred on it
    ;           ENTITY_UNK_5C
    dw   .row_24x16_ahead_right
    dw   .row_24x16_ahead_left
    ; $2c/$2d  16x32 below the position, both columns the same tile. The "left" entry is
    ;          not a mirror at all - it is the same box 32 pixels ABOVE the position with
    ;          OAMF_YFLIP, so for this one entity facing means up or down
    ;           ENTITY_UNK_5D
    dw   .box_16x32_under
    dw   .box_16x32_over
    ; $2e/$2f  64x16 built from two tiles - three copies of the middle tile either side of the centre, with the end tile mirrored. Both entries are the same pointer
    ;           never selected
    dw   .row_64x16_below_mirrored
    dw   .row_64x16_below_mirrored
    ; $30/$31  identical bytes to $00
    ;           never selected
    dw   .box_8x32_copy_right
    dw   .box_8x32_copy_left
    ; $32/$33  16x32 from two tiles, mirrored
    ;           ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    dw   .box_16x32_mirrored_right
    dw   .box_16x32_mirrored_left
    ; $34/$35  24x32 from four tiles
    ;           never selected
    dw   .box_24x32_mirrored_right
    dw   .box_24x32_mirrored_left
    ; $36/$37  32x32 from four tiles
    ;           never selected
    dw   .box_32x32_mirrored_right
    dw   .box_32x32_mirrored_left
    ; $38/$39  16x64, two 16x32 halves stacked. Both entries are the same pointer
    ;           ENTITY_TOON_TV_ROCKET
    dw   .box_16x64
    dw   .box_16x64

.box_8x32_right:
    db   2
    obj_part  -16,   -4, $00, $00
    obj_part    0,   -4, $02, $00
.box_8x32_left:
    db   2
    obj_part  -16,   -4, $00, OAMF_XFLIP
    obj_part    0,   -4, $02, OAMF_XFLIP
.box_16x32_right:
    db   4
    obj_part  -16,   -8, $00, $00
    obj_part  -16,    0, $04, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $06, $00
.box_16x32_left:
    db   4
    obj_part  -16,    0, $00, OAMF_XFLIP
    obj_part  -16,   -8, $04, OAMF_XFLIP
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,   -8, $06, OAMF_XFLIP
.box_24x32_right:
    db   6
    obj_part  -16,  -12, $00, $00
    obj_part  -16,   -4, $04, $00
    obj_part  -16,    4, $08, $00
    obj_part    0,  -12, $02, $00
    obj_part    0,   -4, $06, $00
    obj_part    0,    4, $0a, $00
.box_24x32_left:
    db   6
    obj_part  -16,    4, $00, OAMF_XFLIP
    obj_part  -16,   -4, $04, OAMF_XFLIP
    obj_part  -16,  -12, $08, OAMF_XFLIP
    obj_part    0,    4, $02, OAMF_XFLIP
    obj_part    0,   -4, $06, OAMF_XFLIP
    obj_part    0,  -12, $0a, OAMF_XFLIP
.box_32x32_right:
    db   8
    obj_part  -16,  -16, $00, $00
    obj_part  -16,   -8, $04, $00
    obj_part  -16,    0, $08, $00
    obj_part  -16,    8, $0c, $00
    obj_part    0,  -16, $02, $00
    obj_part    0,   -8, $06, $00
    obj_part    0,    0, $0a, $00
    obj_part    0,    8, $0e, $00
.box_32x32_left:
    db   8
    obj_part  -16,    8, $00, OAMF_XFLIP
    obj_part  -16,    0, $04, OAMF_XFLIP
    obj_part  -16,   -8, $08, OAMF_XFLIP
    obj_part  -16,  -16, $0c, OAMF_XFLIP
    obj_part    0,    8, $02, OAMF_XFLIP
    obj_part    0,    0, $06, OAMF_XFLIP
    obj_part    0,   -8, $0a, OAMF_XFLIP
    obj_part    0,  -16, $0e, OAMF_XFLIP
.row_8x16_right:
    db   1
    obj_part   -8,   -4, $00, $00
.row_8x16_left:
    db   1
    obj_part   -8,   -4, $00, OAMF_XFLIP
.row_16x16_right:
    db   2
    obj_part   -8,   -8, $00, $00
    obj_part   -8,    0, $02, $00
.row_16x16_left:
    db   2
    obj_part   -8,    0, $00, OAMF_XFLIP
    obj_part   -8,   -8, $02, OAMF_XFLIP
.row_24x16_right:
    db   3
    obj_part   -8,  -12, $00, $00
    obj_part   -8,   -4, $02, $00
    obj_part   -8,    4, $04, $00
.row_24x16_left:
    db   3
    obj_part   -8,    4, $00, OAMF_XFLIP
    obj_part   -8,   -4, $02, OAMF_XFLIP
    obj_part   -8,  -12, $04, OAMF_XFLIP
.row_32x16_right:
    db   4
    obj_part   -8,  -16, $00, $00
    obj_part   -8,   -8, $02, $00
    obj_part   -8,    0, $04, $00
    obj_part   -8,    8, $06, $00
.row_32x16_left:
    db   4
    obj_part   -8,    8, $00, OAMF_XFLIP
    obj_part   -8,    0, $02, OAMF_XFLIP
    obj_part   -8,   -8, $04, OAMF_XFLIP
    obj_part   -8,  -16, $06, OAMF_XFLIP
.row_8x16_mirrored_right:
    db   1
    obj_part   -8,   -4, $00, $00
.row_8x16_mirrored_left:
    db   1
    obj_part   -8,   -4, $00, OAMF_XFLIP
.row_16x16_mirrored_right:
    db   2
    obj_part   -8,   -8, $00, $00
    obj_part   -8,    0, $00, OAMF_XFLIP
.row_16x16_mirrored_left:
    db   2
    obj_part   -8,    0, $00, OAMF_XFLIP
    obj_part   -8,   -8, $00, $00
.row_24x16_mirrored_right:
    db   3
    obj_part   -8,  -12, $00, $00
    obj_part   -8,   -4, $02, $00
    obj_part   -8,    4, $00, OAMF_XFLIP
.row_24x16_mirrored_left:
    db   3
    obj_part   -8,    4, $00, OAMF_XFLIP
    obj_part   -8,   -4, $02, OAMF_XFLIP
    obj_part   -8,  -12, $00, $00
.row_32x16_mirrored_right:
    db   4
    obj_part   -8,  -16, $00, $00
    obj_part   -8,   -8, $02, $00
    obj_part   -8,    0, $02, OAMF_XFLIP
    obj_part   -8,    8, $00, OAMF_XFLIP
.row_32x16_mirrored_left:
    db   4
    obj_part   -8,    8, $00, OAMF_XFLIP
    obj_part   -8,    0, $02, OAMF_XFLIP
    obj_part   -8,   -8, $02, $00
    obj_part   -8,  -16, $00, $00
.row_8x16_below_right:
    db   1
    obj_part    0,   -4, $00, $00
.row_8x16_below_left:
    db   1
    obj_part    0,   -4, $00, OAMF_XFLIP
.row_16x16_below_right:
    db   2
    obj_part    0,   -8, $00, $00
    obj_part    0,    0, $02, $00
.row_16x16_below_left:
    db   2
    obj_part    0,    0, $00, OAMF_XFLIP
    obj_part    0,   -8, $02, OAMF_XFLIP
.row_24x16_below_right:
    db   3
    obj_part    0,  -12, $00, $00
    obj_part    0,   -4, $02, $00
    obj_part    0,    4, $04, $00
.row_24x16_below_left:
    db   3
    obj_part    0,    4, $00, OAMF_XFLIP
    obj_part    0,   -4, $02, OAMF_XFLIP
    obj_part    0,  -12, $04, OAMF_XFLIP
.row_32x16_below_right:
    db   4
    obj_part    0,  -16, $00, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $04, $00
    obj_part    0,    8, $06, $00
.row_32x16_below_left:
    db   4
    obj_part    0,    8, $00, OAMF_XFLIP
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,   -8, $04, OAMF_XFLIP
    obj_part    0,  -16, $06, OAMF_XFLIP
.row_8x16_below_mirrored_right:
    db   1
    obj_part    0,   -4, $00, $00
.row_8x16_below_mirrored_left:
    db   1
    obj_part    0,   -4, $00, OAMF_XFLIP
.row_16x16_below_mirrored_right:
    db   2
    obj_part    0,   -8, $00, $00
    obj_part    0,    0, $00, OAMF_XFLIP
.row_16x16_below_mirrored_left:
    db   2
    obj_part    0,    0, $00, OAMF_XFLIP
    obj_part    0,   -8, $00, $00
.row_24x16_below_mirrored_right:
    db   3
    obj_part    0,  -12, $00, $00
    obj_part    0,   -4, $02, $00
    obj_part    0,    4, $00, OAMF_XFLIP
.row_24x16_below_mirrored_left:
    db   3
    obj_part    0,    4, $00, OAMF_XFLIP
    obj_part    0,   -4, $02, OAMF_XFLIP
    obj_part    0,  -12, $00, $00
.row_32x16_below_mirrored_right:
    db   4
    obj_part    0,  -16, $00, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,    8, $00, OAMF_XFLIP
.row_32x16_below_mirrored_left:
    db   4
    obj_part    0,    8, $00, OAMF_XFLIP
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,   -8, $02, $00
    obj_part    0,  -16, $00, $00
.hanging_blade:
; ENTITY_KUNG_FU_THEATER_HANGING_BLADE, and the only shape in the table that is not a
; rectangle: four parts of chain running 72 pixels up from the entity position, then a
; 32-wide blade across the bottom
    db   8
    obj_part  -72,   -4, $00, $00
    obj_part  -56,   -4, $02, $00
    obj_part  -40,   -4, $04, $00
    obj_part  -24,   -4, $06, $00
    obj_part   -8,  -16, $08, $00
    obj_part   -8,   -8, $0a, $00
    obj_part   -8,    0, $0c, $00
    obj_part   -8,    8, $0e, $00
.row_24x16_ahead_right:
    db   3
    obj_part   -8,    0, $00, $00
    obj_part   -8,    8, $02, $00
    obj_part   -8,   16, $04, $00
.row_24x16_ahead_left:
    db   3
    obj_part   -8,   -8, $00, OAMF_XFLIP
    obj_part   -8,  -16, $02, OAMF_XFLIP
    obj_part   -8,  -24, $04, OAMF_XFLIP
.box_16x32_under:
; Two columns of the same tile rather than a mirrored pair - this shape is symmetric
; already, so there is nothing to flip
    db   4
    obj_part    0,   -8, $00, $00
    obj_part    0,    0, $00, $00
    obj_part   16,   -8, $02, $00
    obj_part   16,    0, $02, $00
.box_16x32_over:
    db   4
    obj_part  -16,   -8, $00, OAMF_YFLIP
    obj_part  -16,    0, $00, OAMF_YFLIP
    obj_part  -32,   -8, $02, OAMF_YFLIP
    obj_part  -32,    0, $02, OAMF_YFLIP
.row_64x16_below_mirrored:
    db   8
    obj_part    0,  -32, $00, $00
    obj_part    0,  -24, $02, $00
    obj_part    0,  -16, $02, $00
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,    8, $02, OAMF_XFLIP
    obj_part    0,   16, $02, OAMF_XFLIP
    obj_part    0,   24, $00, OAMF_XFLIP
.box_8x32_copy_right:
    db   2
    obj_part  -16,   -4, $00, $00
    obj_part    0,   -4, $02, $00
.box_8x32_copy_left:
    db   2
    obj_part  -16,   -4, $00, OAMF_XFLIP
    obj_part    0,   -4, $02, OAMF_XFLIP
.box_16x32_mirrored_right:
    db   4
    obj_part  -16,   -8, $00, $00
    obj_part  -16,    0, $00, OAMF_XFLIP
    obj_part    0,   -8, $02, $00
    obj_part    0,    0, $02, OAMF_XFLIP
.box_16x32_mirrored_left:
    db   4
    obj_part  -16,    0, $00, OAMF_XFLIP
    obj_part  -16,   -8, $00, $00
    obj_part    0,    0, $02, OAMF_XFLIP
    obj_part    0,   -8, $02, $00
.box_24x32_mirrored_right:
    db   6
    obj_part  -16,  -12, $00, $00
    obj_part  -16,   -4, $04, $00
    obj_part  -16,    4, $00, OAMF_XFLIP
    obj_part    0,  -12, $02, $00
    obj_part    0,   -4, $06, $00
    obj_part    0,    4, $02, OAMF_XFLIP
.box_24x32_mirrored_left:
    db   6
    obj_part  -16,    4, $00, OAMF_XFLIP
    obj_part  -16,   -4, $04, OAMF_XFLIP
    obj_part  -16,  -12, $00, $00
    obj_part    0,    4, $02, OAMF_XFLIP
    obj_part    0,   -4, $06, OAMF_XFLIP
    obj_part    0,  -12, $02, $00
.box_32x32_mirrored_right:
    db   8
    obj_part  -16,  -16, $00, $00
    obj_part  -16,   -8, $04, $00
    obj_part  -16,    0, $04, OAMF_XFLIP
    obj_part  -16,    8, $00, OAMF_XFLIP
    obj_part    0,  -16, $02, $00
    obj_part    0,   -8, $06, $00
    obj_part    0,    0, $06, OAMF_XFLIP
    obj_part    0,    8, $02, OAMF_XFLIP
.box_32x32_mirrored_left:
    db   8
    obj_part  -16,    8, $00, OAMF_XFLIP
    obj_part  -16,    0, $04, OAMF_XFLIP
    obj_part  -16,   -8, $04, $00
    obj_part  -16,  -16, $00, $00
    obj_part    0,    8, $02, OAMF_XFLIP
    obj_part    0,    0, $06, OAMF_XFLIP
    obj_part    0,   -8, $06, $00
    obj_part    0,  -16, $02, $00
.box_16x64:
    db   8
    obj_part  -32,   -8, $00, $00
    obj_part  -32,    0, $04, $00
    obj_part  -16,   -8, $02, $00
    obj_part  -16,    0, $06, $00
    obj_part    0,   -8, $08, $00
    obj_part    0,    0, $0c, $00
    obj_part   16,   -8, $0a, $00
    obj_part   16,    0, $0e, $00

.jp_03_6451_Entity_BuildSprites_SpriteList:
; The generic draw for SPRITE_FLAG_EMBEDDED_SPRITE_DATA entities: copy the sprite list that a
; per-effect builder already filled in straight into shadow OAM.
;
; call_00_39e0_Entity_GetSpriteListPtr gives the buffer. The first byte is the sprite
; count, and a count of zero means the effect has nothing on screen this frame - it
; falls through to collision dispatch rather than drawing. Each following record is
; ENTITY_SPRITE_RECORD_SIZE bytes: Y offset, X offset, tile, attributes, with B and C
; added to the offsets to place them relative to the entity.
;
; So the particle builders never touch OAM themselves; they only produce the list, and
; this is the one place it is drawn
    call call_00_39e0_Entity_GetSpriteListPtr
    ld   L, E
    ld   H, D
    ld   A, [wD739_Entity_OamWriteOffset]
    ld   E, A
    ld   D, $cc
    ld   A, [HL+]
    and  A, A
    jp   Z, call_03_4c76_EntityCollision_Dispatch
.jr_03_6461:
    push AF
    ld   A, E
    cp   A, $a0
    jr   NC, .jr_03_6479
    ld   A, [HL+]
    add  A, B
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    add  A, C
    ld   [DE], A
    inc  E
    ld   A, [HL+]
    ld   [DE], A
    inc  E
    ld   A, [wD335_Entity_OamAttr]
    or   A, [HL]
    ld   [DE], A
    inc  HL
    inc  E
.jr_03_6479:
    pop  AF
    dec  A
    jr   NZ, .jr_03_6461
    ld   A, E
    ld   [wD739_Entity_OamWriteOffset], A
    jp   call_03_4c76_EntityCollision_Dispatch

call_03_6484_OAM_ClearUnusedEntries:
; Clears all OAM entries from wD739_Entity_OamWriteOffset (current write cursor) up to $5F (end of NPC OAM region)
; by writing $00 to every Y byte (stride 4). Effectively hides any sprite slots not written this frame
    ld   A, $5f
    ld   HL, wD739_Entity_OamWriteOffset
    ld   L, [HL]
    cp   A, L
    ret  C
    ld   H, $cc
    ld   DE, $04
    ld   C, $00
.jr_03_6493:
    ld   [HL], C
    add  HL, DE
    cp   A, L
    jr   NC, .jr_03_6493
    ret

call_03_6499_Collectible_BuildSprites:
; Draws the on-screen collectibles into wCC60_ShadowOAM_CollectibleSprites, and collects
; any the player is touching.
;
; The camera is reduced to a cell column and row (scroll >> 4, since a collectible cell is
; 16x16 pixels) plus the leftover sub-cell pixels, which become the fine biases in
; wD64D_Collectible_OamOriginX/wD64E_Collectible_OamOriginY. The column then indexes the two tables that
; call_0b_4000_CollectibleList_LoadForCurrentLevel precomputed:
; wC700_Collectible_ScanCountByColumn says how many collectibles are in range - zero
; returns immediately - and wC600_Collectible_ScanStartByColumn says where to start. So
; the list is never searched at runtime.
;
; Each entry in that run is then filtered on Y only: (wC500_Collectible_GridY - camera
; row) must be under 10 cells. That single test also drops collected entries for free,
; because collection writes $FF into the Y table. Survivors are placed at cell * 16 plus
; the fine bias, as tile $7E with attribute $01.
;
; Collection happens in the same pass, but only when the player is actually being drawn
; (wD743_Player_UpdateFlag): if Gex's screen position is inside an 18x36 pixel window
; around the sprite, the Y entry becomes $FF and
; call_00_06ec_Player_ObtainedCollectible runs. Drawing and collecting therefore use the
; same coordinates, so what you see is what you can pick up.
;
; The OAM region is capped by "bit 7, L" - once the write pointer passes $CC80 the loop
; stops advancing it, so a crowded screen silently drops the extras rather than
; overrunning into the next OAM block. Unused entries after the last one are cleared
    ld   HL, wD6ED_BgMap_ScrollX
    ld   A, [HL]
    and  A, $0f
    ld   C, A
    ld   A, $0c
    sub  A, C
    ld   [wD64D_Collectible_OamOriginX], A
    ld   A, [HL+]
    swap A
    and  A, $0f
    ld   C, A
    ld   A, [HL+]
    swap A
    or   A, C
    ld   C, A
    ld   B, HIGH(wC700_Collectible_ScanCountByColumn)
    ld   A, [BC]
    and  A, A
    ret  Z
    push AF
    dec  B
    ld   A, [BC]
    ld   E, A
    ld   HL, wD6EF_BgMap_ScrollY
    ld   A, [HL]
    and  A, $0f
    ld   B, A
    ld   A, $10
    sub  A, B
    ld   [wD64E_Collectible_OamOriginY], A
    ld   A, [HL+]
    swap A
    and  A, $0f
    ld   B, A
    ld   A, [HL+]
    swap A
    or   A, B
    ld   B, A
    ld   HL, wCC60_ShadowOAM_CollectibleSprites
    pop  AF
.jr_03_64d6:
    push AF
    push BC
    ld   D, HIGH(wC500_Collectible_GridY)
    ld   A, [DE]
    sub  A, B
    cp   A, $0a
    jr   NC, .jr_03_653d
    swap A
    ld   B, A
    ld   A, [wD64E_Collectible_OamOriginY]
    add  A, B
    ld   B, A
    ld   [HL+], A
    ld   D, HIGH(wC400_Collectible_GridX)
    ld   A, [DE]
    sub  A, C
    swap A
    ld   C, A
    ld   A, [wD64D_Collectible_OamOriginX]
    add  A, C
    ld   C, A
    ld   [HL+], A
    inc  E
    ld   [HL], $7e
    inc  L
    ld   [HL], $01
    inc  L
    ld   A, [wD743_Player_UpdateFlag]
    and  A, A
    jr   Z, .jr_03_6524
    ld   A, [wD212_Player_ScreenXPosition]
    sub  A, C
    add  A, $05
    cp   A, $12
    jr   NC, .jr_03_6524
    ld   A, [wD213_Player_ScreenYPosition]
    sub  A, B
    add  A, $0a
    cp   A, $24
    jr   NC, .jr_03_6524
    push HL
    push DE
    ld   D, HIGH(wC500_Collectible_GridY)
    dec  E
    ld   A, $ff
    ld   [DE], A
    call call_00_06ec_Player_ObtainedCollectible
    pop  DE
    pop  HL
.jr_03_6524:
    bit  7, L
    jr   Z, .jr_03_652a
    ld   L, $80
.jr_03_652a:
    pop  BC
    pop  AF
    dec  A
    jr   NZ, .jr_03_64d6
    bit  7, L
    ret  NZ
    ld   DE, $04
    xor  A, A
.jr_03_6536:
    ld   [HL], A
    add  HL, DE
    bit  7, L
    jr   Z, .jr_03_6536
    ret
.jr_03_653d:
    inc  E
    jr   .jr_03_652a

call_03_6540_OAM_FinishFrame:
; Closes out the frame's OAM pass, after the entity builders have already filled the
; NPC region: collectible sprites, then the HUD row, then blank every slot the frame
; did not use.
;
; Only the middle step is HUD, and it does not build all the sprites - it finishes a
; list the entity code started
    call call_03_6499_Collectible_BuildSprites
    call call_03_5b5b_HUD_BuildSprites
    jp   call_03_6484_OAM_ClearUnusedEntries
