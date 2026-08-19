; ==================================================================
; ENTITY SPRITE SHAPES
;
; Not artwork - shapes. Everything in this file describes WHERE an entity's OAM
; entries go and which tiles inside its tile page they use; the picture itself is
; never here. An enemy animates by streaming a different page of tiles into VRAM
; while drawing the same handful of rectangles every frame, which is why the
; whole of a boss's animation costs nothing more than a couple of dozen bytes of
; layout shared with every other enemy the same size.
;
; The file is reached only from the two frame-based sprite builders in
; bank03_oam_build.asm - the SPRITE_FLAG_LAYOUT_BY_ACTION path uses
; .data_03_608e_EntitySpriteLayoutPointerTable over there instead, and Gex has his
; own builder entirely.
;
; THE META TABLE IS READ BACKWARDS. The builders load
; data_03_5446_EntitySpriteMetaTable + 1, add entity id x 2, and then read with
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
;                                          table of data_03_5566_SpriteFrameTable_Main,
;                                          or, with bit 7 set, into
;                                          data_03_5a8a_SpriteFrameTable_Alt
;   SPRITE_FLAG_LAYOUT_BY_ACTION entities  a base index into
;                                          .data_03_608e_EntitySpriteLayoutPointerTable
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
; ENTITY_FIELD_FACING_FLAGS onwards, .jr_03_5fcb_Entity_BuildSprites_FacingBased and
; the default path above it are 91 identical bytes. SPRITE_FLAG_STREAMS_OWN_GFX makes
; no difference to how a sprite is drawn - it only decides whether the entity streams
; its own tiles, which is settled elsewhere
; ==================================================================

data_03_5446_EntitySpriteMetaTable:
; Two bytes per entity id, 144 ids. The builders address this as
; `data_03_5446_EntitySpriteMetaTable + 1 + entity id * 2` and read backwards, so the
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

data_03_5566_SpriteFrameTable_Main:
; 88 pointers - twenty-two groups of four (page 0, page 1, page 0 mirrored,
; page 1 mirrored). Only the seven groups marked below can be selected
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

data_03_5a8a_SpriteFrameTable_Alt:
; The other frame table, chosen when bit 7 of a shape index is set. Because that
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
