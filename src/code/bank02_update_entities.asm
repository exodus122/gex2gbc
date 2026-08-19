data_02_4000_EntityActionJumpTable:
; One word per entity type, indexed by ENTITY_FIELD_ENTITY_ID, pointing at that
; type's action table. The tables themselves are at the top of
; bank02_entity_actions.asm, where the format is documented; each of their rows
; is 4 bytes (action function, action data block) and the row number is the
; action id.
;
; call_02_7102_Entity_SetAction is the only reader, and it does both lookups in
; one go: entity id x 2 into this table, then action id x 4 into the result.
;
; The comment on each line is the entity id, which is also this line's index -
; ENTITY_* ids are positions in this table, not values stored anywhere else
    dw   data_02_4120_EntityActions_Gex                              ; $00 ENTITY_GEX
    dw   data_02_4ddb_EntityActions_CollectibleSpawn                ; $01 ENTITY_COLLECTIBLE_SPAWN
    dw   data_02_4dff_EntityActions_Unk02                           ; $02 ENTITY_UNK_02
    dw   data_02_4ddf_EntityActions_TVButton                        ; $03 ENTITY_TV_BUTTON
    dw   data_02_4de7_EntityActions_RedRemote                       ; $04 ENTITY_RED_REMOTE
    dw   data_02_4def_EntityActions_SilverRemote                    ; $05 ENTITY_SILVER_REMOTE
    dw   data_02_4df7_EntityActions_GoldRemote                      ; $06 ENTITY_GOLD_REMOTE
    dw   data_02_4e03_EntityActions_ParticleBurst                   ; $07 ENTITY_ENEMY_DEFEATED
    dw   data_02_4e07_EntityActions_Unk08                           ; $08 ENTITY_UNK_08
    dw   data_02_4e0b_EntityActions_ScreamTVFallingPlatform         ; $09 ENTITY_SCREAM_TV_FALLING_PLATFORM
    dw   data_02_4e0f_EntityActions_ScreamTVMovingPlatform          ; $0A ENTITY_SCREAM_TV_MOVING_PLATFORM
    dw   data_02_4e13_EntityActions_ScreamTVPushBlock               ; $0B ENTITY_SCREAM_TV_PUSH_BLOCK
    dw   data_02_4e17_EntityActions_ScreamTVPumpkin                 ; $0C ENTITY_SCREAM_TV_PUMPKIN
    dw   data_02_4e1f_EntityActions_ScreamTVFrankie                 ; $0D ENTITY_SCREAM_TV_FRANKIE
    dw   data_02_4e23_EntityActions_ScreamTVHeadGhost               ; $0E ENTITY_SCREAM_TV_HEAD_GHOST
    dw   data_02_4e2b_EntityActions_ScreamTVHeadGhostHead           ; $0F ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    dw   data_02_4e2f_EntityActions_ScreamTVFloatingSkull           ; $10 ENTITY_SCREAM_TV_FLOATING_SKULL
    dw   data_02_4e3b_EntityActions_ScreamTVFloatingSkullProjectile ; $11 ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    dw   data_02_4e43_EntityActions_ScreamTVZombie                  ; $12 ENTITY_SCREAM_TV_ZOMBIE
    dw   data_02_4e4f_EntityActions_ScreamTVZombieHead              ; $13 ENTITY_SCREAM_TV_ZOMBIE_HEAD
    dw   data_02_4e5b_EntityActions_ScreamTVFallingAxe              ; $14 ENTITY_SCREAM_TV_FALLING_AXE
    dw   data_02_4e6b_EntityActions_ScreamTVLantern                 ; $15 ENTITY_SCREAM_TV_LANTERN
    dw   data_02_4e73_EntityActions_ScreamTVBat                     ; $16 ENTITY_SCREAM_TV_BAT
    dw   data_02_4e77_EntityActions_ScreamTVOrangeMovingPlatform    ; $17 ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    dw   data_02_4e7b_EntityActions_ScreamTVDoorOpening             ; $18 ENTITY_SCREAM_TV_DOOR_OPENING
    dw   data_02_4e83_EntityActions_ScreamTVGhost                   ; $19 ENTITY_SCREAM_TV_GHOST
    dw   data_02_4e93_EntityActions_ScreamTVClimbWallSunEnemy       ; $1A ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    dw   data_02_4e97_EntityActions_ScreamTVVanishingPlatform       ; $1B ENTITY_SCREAM_TV_VANISHING_PLATFORM
    dw   data_02_4ea3_EntityActions_ScreamTVMonaLisaElevator        ; $1C ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    dw   data_02_4ea7_EntityActions_ToonTVHardHeadAreaHazard        ; $1D ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    dw   data_02_4eb3_EntityActions_ToonTVStationaryBearTrap        ; $1E ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    dw   data_02_4ebb_EntityActions_ToonTVMovingBearTrap            ; $1F ENTITY_TOON_TV_MOVING_BEAR_TRAP
    dw   data_02_4ec3_EntityActions_ToonTVBumblebee                 ; $20 ENTITY_TOON_TV_BUMBLEBEE
    dw   data_02_4ecb_EntityActions_ToonTVBowlingBall               ; $21 ENTITY_TOON_TV_BOWLING_BALL
    dw   data_02_4ecf_EntityActions_ToonTVCactus                    ; $22 ENTITY_TOON_TV_CACTUS
    dw   data_02_4edb_EntityActions_ToonTVDomino                    ; $23 ENTITY_TOON_TV_DOMINO
    dw   data_02_4edf_EntityActions_ToonTVShark                     ; $24 ENTITY_TOON_TV_SHARK
    dw   data_02_4ee3_EntityActions_ToonTVFlower                    ; $25 ENTITY_TOON_TV_FLOWER
    dw   data_02_4eef_EntityActions_ToonTVHunter                    ; $26 ENTITY_TOON_TV_HUNTER
    dw   data_02_4f07_EntityActions_ToonTVMushroom                  ; $27 ENTITY_TOON_TV_MUSHROOM
    dw   data_02_4f0b_EntityActions_ToonTVMushroomProjectile        ; $28 ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    dw   data_02_4f0f_EntityActions_ToonTVLizard                    ; $29 ENTITY_TOON_TV_LIZARD
    dw   data_02_4f13_EntityActions_ToonTVHappyFace                 ; $2A ENTITY_TOON_TV_HAPPY_FACE
    dw   data_02_4f1b_EntityActions_ToonTVVanishingBlock            ; $2B ENTITY_TOON_TV_VANISHING_BLOCK
    dw   data_02_4f27_EntityActions_ToonTVMovingBlock               ; $2C ENTITY_TOON_TV_MOVING_BLOCK
    dw   data_02_4f2f_EntityActions_ToonTVMovingLog                 ; $2D ENTITY_TOON_TV_MOVING_LOG
    dw   data_02_4f33_EntityActions_ToonTVStationaryLog             ; $2E ENTITY_TOON_TV_STATIONARY_LOG
    dw   data_02_4f37_EntityActions_ToonTVFlowerHammer              ; $2F ENTITY_TOON_TV_FLOWER_HAMMER
    dw   data_02_4f43_EntityActions_ToonTVHunterBullet              ; $30 ENTITY_TOON_TV_HUNTER_BULLET
    dw   data_02_4f4b_EntityActions_ToonTVRocket                    ; $31 ENTITY_TOON_TV_ROCKET
    dw   data_02_4f57_EntityActions_PreHistoryFastDinosaur          ; $32 ENTITY_PRE_HISTORY_FAST_DINOSAUR
    dw   data_02_4f5b_EntityActions_PreHistoryDragonfly             ; $33 ENTITY_PRE_HISTORY_DRAGONFLY
    dw   data_02_4f5f_EntityActions_PreHistoryEgg                   ; $34 ENTITY_PRE_HISTORY_EGG
    dw   data_02_4f6b_EntityActions_Unk35                           ; $35 ENTITY_UNK_35
    dw   data_02_4f73_EntityActions_Unk36                           ; $36 ENTITY_UNK_36
    dw   data_02_4f77_EntityActions_PreHistoryFallingLava           ; $37 ENTITY_PRE_HISTORY_FALLING_LAVA
    dw   data_02_4f7f_EntityActions_PreHistoryLavaRaft              ; $38 ENTITY_PRE_HISTORY_LAVA_RAFT
    dw   data_02_4f87_EntityActions_PreHistoryMovingPlatform        ; $39 ENTITY_PRE_HISTORY_MOVING_PLATFORM
    dw   data_02_4f8b_EntityActions_Unk3A                           ; $3A ENTITY_UNK_3A
    dw   data_02_4f8f_EntityActions_Unk3B                           ; $3B ENTITY_UNK_3B
    dw   data_02_4f93_EntityActions_PreHistoryPterosaur             ; $3C ENTITY_PRE_HISTORY_PTEROSAUR
    dw   data_02_4f97_EntityActions_Unk3D                           ; $3D ENTITY_UNK_3D
    dw   data_02_4f9b_EntityActions_PreHistoryFallingBoulder        ; $3E ENTITY_PRE_HISTORY_FALLING_BOULDER
    dw   data_02_4fab_EntityActions_Unk3F                           ; $3F ENTITY_UNK_3F
    dw   data_02_4faf_EntityActions_PreHistoryBeetleHorizontal      ; $40 ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    dw   data_02_4fb3_EntityActions_PreHistoryBeetleVertical        ; $41 ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    dw   data_02_4fb7_EntityActions_PreHistoryAnt                   ; $42 ENTITY_PRE_HISTORY_ANT
    dw   data_02_4fbb_EntityActions_PreHistoryFirePlant             ; $43 ENTITY_PRE_HISTORY_FIRE_PLANT
    dw   data_02_4fc7_EntityActions_PreHistoryFirePlantProjectiles  ; $44 ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    dw   data_02_4fcf_EntityActions_PreHistoryGeyser                ; $45 ENTITY_PRE_HISTORY_GEYSER
    dw   data_02_4fd7_EntityActions_Unk46                           ; $46 ENTITY_UNK_46
    dw   data_02_4fdb_EntityActions_PreHistoryDinosaur              ; $47 ENTITY_PRE_HISTORY_DINOSAUR
    dw   data_02_4fdf_EntityActions_PreHistoryTriceratops           ; $48 ENTITY_PRE_HISTORY_TRICERATOPS
    dw   data_02_4fe3_EntityActions_PreHistoryTriceratopsHorn       ; $49 ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    dw   data_02_4fe7_EntityActions_Unk4A                           ; $4A ENTITY_UNK_4A
    dw   data_02_4feb_EntityActions_KungFuTheaterHangingBlade       ; $4B ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    dw   data_02_4fef_EntityActions_KungFuTheaterCannon             ; $4C ENTITY_KUNG_FU_THEATER_CANNON
    dw   data_02_4ff3_EntityActions_KungFuTheaterCannonProjectile   ; $4D ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    dw   data_02_4ffb_EntityActions_KungFuTheaterDragonfly          ; $4E ENTITY_KUNG_FU_THEATER_DRAGONFLY
    dw   data_02_4fff_EntityActions_KungFuTheaterDragonBodySegment  ; $4F ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    dw   data_02_5003_EntityActions_KungFuTheaterDragonHead         ; $50 ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    dw   data_02_5007_EntityActions_Unk51                           ; $51 ENTITY_UNK_51
    dw   data_02_500b_EntityActions_KungFuTheaterDragonProjectile   ; $52 ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    dw   data_02_5013_EntityActions_KungFuTheaterWalkingNinja       ; $53 ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    dw   data_02_501f_EntityActions_KungFuTheaterJumpingNinja       ; $54 ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    dw   data_02_502f_EntityActions_KungFuTheaterSamuraiBody        ; $55 ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    dw   data_02_5037_EntityActions_KungFuTheaterSamuraiHead        ; $56 ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    dw   data_02_5043_EntityActions_KungFuTheaterLizard             ; $57 ENTITY_KUNG_FU_THEATER_LIZARD
    dw   data_02_5047_EntityActions_KungFuTheaterNinjaProjectile    ; $58 ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    dw   data_02_504f_EntityActions_KungFuTheaterSpikyLog           ; $59 ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    dw   data_02_5053_EntityActions_KungFuTheaterTallJar            ; $5A ENTITY_KUNG_FU_THEATER_TALL_JAR
    dw   data_02_505b_EntityActions_KungFuTheaterJar                ; $5B ENTITY_KUNG_FU_THEATER_JAR
    dw   data_02_5063_EntityActions_Unk5C                           ; $5C ENTITY_UNK_5C
    dw   data_02_5067_EntityActions_Unk5D                           ; $5D ENTITY_UNK_5D
    dw   data_02_506b_EntityActions_KungFuTheaterVanishingPlatform  ; $5E ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    dw   data_02_5077_EntityActions_KungFuTheaterMovingPlatform     ; $5F ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    dw   data_02_507b_EntityActions_Unk60                           ; $60 ENTITY_UNK_60
    dw   data_02_507f_EntityActions_KungFuTheaterMovingRaft         ; $61 ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    dw   data_02_5083_EntityActions_KungFuTheaterStationaryRaft     ; $62 ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    dw   data_02_5087_EntityActions_Unk63                           ; $63 ENTITY_UNK_63
    dw   data_02_508b_EntityActions_Unk64                           ; $64 ENTITY_UNK_64
    dw   data_02_508f_EntityActions_RezopolisSpecialMovingPlatform  ; $65 ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    dw   data_02_5093_EntityActions_RezopolisMovingPlatform         ; $66 ENTITY_REZOPOLIS_MOVING_PLATFORM
    dw   data_02_5097_EntityActions_RezopolisRedPlatform            ; $67 ENTITY_REZOPOLIS_RED_PLATFORM
    dw   data_02_509b_EntityActions_RezopolisActivatedRedPlatform   ; $68 ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    dw   data_02_509f_EntityActions_RezopolisTailspinPlatform       ; $69 ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    dw   data_02_50a3_EntityActions_RezopolisTailspinGear           ; $6A ENTITY_REZOPOLIS_TAILSPIN_GEAR
    dw   data_02_50b7_EntityActions_Unk6B                           ; $6B ENTITY_UNK_6B
    dw   data_02_50bb_EntityActions_Unk6C                           ; $6C ENTITY_UNK_6C
    dw   data_02_50bf_EntityActions_Unk6D                           ; $6D ENTITY_UNK_6D
    dw   data_02_50c3_EntityActions_RezopolisGreenMonster           ; $6E ENTITY_REZOPOLIS_GREEN_MONSTER
    dw   data_02_50cf_EntityActions_Unk6F                           ; $6F ENTITY_UNK_6F
    dw   data_02_50d3_EntityActions_Unk70                           ; $70 ENTITY_UNK_70
    dw   data_02_50d7_EntityActions_RezopolisPincer                 ; $71 ENTITY_REZOPOLIS_PINCER
    dw   data_02_50db_EntityActions_RezopolisFlamethrower           ; $72 ENTITY_REZOPOLIS_FLAMETHROWER
    dw   data_02_50e3_EntityActions_RezopolisUfo                    ; $73 ENTITY_REZOPOLIS_UFO
    dw   data_02_50eb_EntityActions_RezopolisAnt                    ; $74 ENTITY_REZOPOLIS_ANT
    dw   data_02_50ef_EntityActions_RezopolisAntSpawner             ; $75 ENTITY_REZOPOLIS_ANT_SPAWNER
    dw   data_02_50f3_EntityActions_CircuitCentralAnt               ; $76 ENTITY_CIRCUIT_CENTRAL_ANT
    dw   data_02_50f7_EntityActions_CircuitCentralCapacitor         ; $77 ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    dw   data_02_50ff_EntityActions_CircuitCentralPowerUp           ; $78 ENTITY_CIRCUIT_CENTRAL_POWER_UP
    dw   data_02_5107_EntityActions_Unk79                           ; $79 ENTITY_UNK_79
    dw   data_02_510b_EntityActions_CircuitCentralLittleRobot       ; $7A ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    dw   data_02_5113_EntityActions_CircuitCentralLittleRobotGear   ; $7B ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    dw   data_02_5117_EntityActions_CircuitCentralElectricBall      ; $7C ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    dw   data_02_511f_EntityActions_CircuitCentralMovingPlatform    ; $7D ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    dw   data_02_5123_EntityActions_CircuitCentralPoweredPlatform   ; $7E ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    dw   data_02_512f_EntityActions_CircuitCentralLoweringPlatform  ; $7F ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    dw   data_02_5133_EntityActions_CircuitCentralWalkerRobot       ; $80 ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    dw   data_02_5137_EntityActions_CircuitCentralPoweredWalkway    ; $81 ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    dw   data_02_513b_EntityActions_CircuitCentralWalkwayActivator  ; $82 ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    dw   data_02_513f_EntityActions_ChannelZArcedGunProjectile      ; $83 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    dw   data_02_5147_EntityActions_ChannelZArcedGunProjectile2     ; $84 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    dw   data_02_5157_EntityActions_ChannelZGunProjectile           ; $85 ENTITY_CHANNEL_Z_GUN_PROJECTILE
    dw   data_02_515f_EntityActions_ChannelZRez                     ; $86 ENTITY_CHANNEL_Z_REZ
    dw   data_02_518b_EntityActions_ChannelZUnusedPlatform1         ; $87 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1
    dw   data_02_518f_EntityActions_ChannelZUnusedPlatform2         ; $88 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2
    dw   data_02_5193_EntityActions_ChannelZRezFollowingFire        ; $89 ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    dw   data_02_5197_EntityActions_ChannelZGunProjectileExplosion  ; $8A ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    dw   data_02_519b_EntityActions_FinalBattleButtonProjectile     ; $8B ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    dw   data_02_51a3_EntityActions_ChannelZFinalBattleButton       ; $8C ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    dw   data_02_51ab_EntityActions_ChannelZRezPortal               ; $8D ENTITY_CHANNEL_Z_REZ_PORTAL
    dw   data_02_51af_EntityActions_Unk8E                           ; $8E ENTITY_UNK_8E
    dw   data_02_51b3_EntityActions_MediaDimensionMovingPlatform    ; $8F ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

INCLUDE "code/bank02_player_actions.asm"

INCLUDE "code/bank02_update_player.asm"

INCLUDE "code/bank02_entity_actions.asm"

call_02_6e17_Entities_InitAndSpawnAll:
; Full level-start initialization: zeros player entity state (velocities, flags, climbing, collision),
; resets all 7 NPC slots to $FF, conditionally spawns Gex via call_02_48b7_Player_SpawnOpeningDoorEntity,
; then calls EntityList_LoadForCurrentLevel and loops EntitySpawn_SpawnNextFromList until wD338_EntityLoadingFlag returns to 1
    xor  A, A
    ld   [wD300_CurrentEntityAddrLo], A
    ld   A, $00
    ld   [wD200_Player_EntityId], A
    ld   A, [wD744_Player_SpawnAction]
    call call_02_7102_Entity_SetAction
    xor  A, A
    ld   [wD621_WarpFlags], A
    xor  A, A
    ld   [wD74C_Player_KarateKickTimer], A
    ld   [wD75D_PlayerXSpeedPrev], A
    ld   [wD75E_PlayerXSpeed], A
    ld   [wD75C_PlayerXDeltaExtra], A
    ld   [wD760_PlayerYVelocity], A
    ld   [wD761_Player_FloorSnapVelocity], A
    ld   [wD762_PlayerInitialYVelocity], A
    ld   [wD763_FallDistanceCounter], A
    ld   [wD759_ButtonBlockingFlags], A
    ld   [wD758_JumpVelocityOverride], A
    ld   [wD585_CollisionFlags], A
    ld   [wD584_CollisionFlagsPrev], A
    ld   A, PLAYER_ACTION_NONE_PENDING
    ld   [wD745_Player_QueuedAction], A
    ld   [wD746_Player_ClimbingState], A
    xor  A, A
    ld   [wD586_PlayerGfxVramPage], A
    ld   [wD74A_Player_InWaterOrLava], A
    ld   A, $00
    ld   [wD74B_Player_ClimbingFlags], A
    ld   A, $00
    ld   [wD20D_Player_FacingFlags], A
call_02_6e68_Entities_InitNPCSlots:
; Subset of above — only zeros entity interaction-tracking vars (wD74D–wD74F, wD587_EntityGfxVramPage) and
; fills the 7 NPC slots (D220–D3E0) with $FF
    xor  A, A
    ld   [wD587_EntityGfxVramPage], A
    ld   [wD74D_Player_EntityStoodOnLo], A
    ld   [wD74E_Player_PushedStationaryPlatformLo], A
    ld   [wD74F_Player_PushedMovingPlatformLo], A
    ld   HL, wD220_OtherLoadedEntities
    ld   DE, ENTITY_SLOT_SIZE
    ld   B, ENTITY_NPC_SLOT_COUNT
.jr_02_6e7d:
    ld   [HL], ENTITY_ID_NONE
    add  HL, DE
    dec  B
    jr   NZ, .jr_02_6e7d
    ld   A, [wD743_Player_UpdateFlag]
    and  A, A
    jr   Z, .jr_02_6e93
    ld   A, [wD744_Player_SpawnAction]
    cp   A, PLAYER_ACTION_LEAVE_DOOR
    ld   A, $01
    call Z, call_02_48b7_Player_SpawnOpeningDoorEntity
.jr_02_6e93:
    FARCALL call_0a_4000_EntityList_LoadForCurrentLevel
.jr_02_6e9e:
    FARCALL call_0a_7a7c_EntitySpawn_SpawnNextFromList
    ld   A, [wD338_EntityLoadingFlag]
    cp   A, $01
    jr   NZ, .jr_02_6e9e
    ret

call_02_6eb1_Entities_ClearFlagsTable:
; Zeroes the entire 256-byte wD000 entity-flags table
    xor  A, A
    ld   HL, wD000_EntityFlags
.jr_02_6eb5:
    ld   [HL], A
    inc  L
    jr   NZ, .jr_02_6eb5
    ret

call_02_6eba_Entities_UpdateAll:
; The per-frame entity pass. Ordering matters more than it looks.
;
; Whatever Gex is standing on or pushing runs *first*, before Gex himself, and out of slot
; order. A moving platform therefore finishes its move for the frame before the player update
; reads its position, and Gex is snapped to sit $10 above it - that is what stops him
; visibly lagging a frame behind a platform he is riding.
;
; Then Player_UpdateMain, then every NPC slot in order: an entity outside the active room
; gets its action function called anyway (that is the despawn check, which is why it is not
; simply skipped), otherwise the two per-frame collision bits are cleared, its action ticks,
; and its sprites are built.
;
; The tail is the deferred work the loop accumulated - queued sound, one spawn from the
; level's entity list, the next entity graphics transfer, and the shared sprite pipeline
    xor  A, A
    ld   [wD75C_PlayerXDeltaExtra], A
    ld   A, OAM_ENTITY_FIRST_BYTE
    ld   [wD739_Entity_OamWriteOffset], A
    ld   A, [wD743_Player_UpdateFlag]
    and  A, A
    jr   Z, .jr_02_6f0f
    ld   A, [wD74D_Player_EntityStoodOnLo]
    and  A, A
    jr   Z, .jr_02_6ef3
    ld   [wD300_CurrentEntityAddrLo], A
    or   A, $02
    ld   L, A
    ld   H, $d2
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    call call_00_10bd_JumpHL
    ld   H, $d2
    ld   A, [wD74D_Player_EntityStoodOnLo]
    and  A, $e0
    or   A, $10
    ld   L, A
    ld   A, [HL+]
    sub  A, $10
    ld   [wD210_Player_YPositionLo], A
    ld   A, [HL]
    sbc  A, $00
    ld   [wD211_Player_YPositionHi], A
.jr_02_6ef3:
    ld   A, [wD74F_Player_PushedMovingPlatformLo]
    and  A, A
    jr   Z, .jr_02_6f07
    ld   [wD300_CurrentEntityAddrLo], A
    or   A, $02
    ld   L, A
    ld   H, $d2
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    call call_00_10bd_JumpHL
.jr_02_6f07:
    ld   A, $00
    ld   [wD300_CurrentEntityAddrLo], A
    call call_02_4939_Player_UpdateMain
.jr_02_6f0f:
    ld   A, ENTITY_SLOT_FIRST_NPC
.jr_02_6f11:
    ld   [wD300_CurrentEntityAddrLo], A
    or   A, $00
    ld   L, A
    ld   H, $d2
    ld   A, [HL]
    cp   A, ENTITY_ID_NONE
    jr   Z, .jr_02_6f5c
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   HL, wD74D_Player_EntityStoodOnLo
    cp   A, [HL]
    jr   Z, .jr_02_6f38
    ld   HL, wD74F_Player_PushedMovingPlatformLo
    cp   A, [HL]
    jr   Z, .jr_02_6f38
    or   A, $02
    ld   L, A
    ld   H, $d2
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    call call_00_10bd_JumpHL
.jr_02_6f38:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ENTITY_ID
    ld   A, [HL]
    cp   A, ENTITY_ID_NONE                             ; the despawn check may have freed it
    jr   Z, .jr_02_6f5c
    ld   A, L
    xor  A, $09
    ld   L, A
    res  ACTION_STATE_IS_FIRST_FRAME_BIT, [HL]
    inc  L
    res  SPRITE_FLAG_ID_CHANGED_BIT, [HL]
    call call_02_6fda_Entity_TickAction
    FARCALL call_03_5ebf_Entity_BuildSprites
.jr_02_6f5c:
    ld   A, [wD300_CurrentEntityAddrLo]
    add  A, ENTITY_SLOT_SIZE                           ; wraps to 0 after the last slot
    jr   NZ, .jr_02_6f11
    call call_00_1138_PlayQueuedSFX
    FARCALL call_0a_7a7c_EntitySpawn_SpawnNextFromList
    call call_02_722c_EntityGfxQueue_StartNextTransfer
    FARCALL call_03_6540_OAM_FinishFrame
    ret

call_02_6f80_Entities_DrawAll:
; Rebuilds every sprite without running any logic. Used when the world has to stay on screen
; but must not advance - the mission preview pans over a frozen level, for example.
; Because nothing ticks, the graphics requests that Entity_NotifyActionChanged would normally
; raise are re-raised here instead: GFX_XFER_PLAYER_GFX unconditionally, and
; GFX_XFER_ENTITY_GFX for any entity whose SPRITE_FLAG_STREAMS_OWN_GFX is set
    ld   A, OAM_ENTITY_FIRST_BYTE
    ld   [wD739_Entity_OamWriteOffset], A
    ld   A, [wD743_Player_UpdateFlag]
    and  A, A
    jr   Z, .jr_02_6fa0
    ld   A, $00
    ld   [wD300_CurrentEntityAddrLo], A
    FARCALL call_03_5ca8_Player_BuildSprites
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX, [HL]
.jr_02_6fa0:
    ld   A, ENTITY_SLOT_FIRST_NPC
.jr_02_6fa2:
    ld   [wD300_CurrentEntityAddrLo], A
    or   A, $00
    ld   L, A
    ld   H, $d2
    ld   A, [HL]
    cp   A, ENTITY_ID_NONE
    jr   Z, .jr_02_6fc7
    ld   A, L
    xor  A, $0a
    ld   L, A
    bit  SPRITE_FLAG_STREAMS_OWN_GFX_BIT, [HL]
    jr   Z, .jr_02_6fbc
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_ENTITY_GFX, [HL]
.jr_02_6fbc:
    FARCALL call_03_5ebf_Entity_BuildSprites
.jr_02_6fc7:
    ld   A, [wD300_CurrentEntityAddrLo]
    add  A, ENTITY_SLOT_SIZE
    jr   NZ, .jr_02_6fa2
    FARCALL call_03_6540_OAM_FinishFrame
    ret

call_02_6fda_Entity_TickAction:
; The animation player, run once per frame for every entity including Gex.
;
; SPRITE_FRAME_COUNTER counts down; $FF means "hold this frame forever" and is how an entity
; freezes its animation without a separate flag. When it reaches zero it reloads from
; SPRITE_FRAME_COUNTER_MAX and SPRITE_COUNTER steps to the next frame.
;
; When SPRITE_COUNTER reaches SPRITE_COUNTER_MAX the sequence has run out, and what happens
; next is declared by the action data rather than decided here:
;   ACTION_STATE_ADVANCE_ON_END  hand over to the pending action and stop. Only Gex's
;                                animation blocks ever set this - see the file header in
;                                bank02_entity_action_data.asm
;   SPRITE_FLAG_LOOP_LAST_FRAME  restart ON the final frame, so the animation plays once
;                                and then sits on its last pose
;   otherwise                    restart at frame 0
; Either way SPRITE_FLAG_ANIM_ENDED is pulsed so the action function can notice the wrap on this
; one frame - that is the flag every hand-off in bank02_player_actions.asm polls. Note it is
; pulsed on EVERY wrap, not just the first, so a looping block re-raises it once per cycle and
; a one-frame block becomes a metronome ticking every ANIM_SPEED frames - which is exactly what
; a good number of entities use theirs for.
;
; Finally the new frame's sprite id is fetched through SPRITE_IDS_PTR into SPRITE_ID,
; SPRITE_FLAG_ID_CHANGED is raised, and it falls through into
; Entity_NotifyActionChanged to get the tiles fetched
    ld   H, $d2
    ld   A, [wD300_CurrentEntityAddrLo]
    ld   C, A
    or   A, $0a
    ld   L, A
    res  SPRITE_FLAG_ANIM_ENDED_BIT, [HL]
    ld   A, C
    or   A, $06
    ld   L, A
    ld   A, [HL]
    cp   A, $ff
    ret  Z
    dec  [HL]
    ret  NZ
    ld   A, C
    or   A, $0b
    ld   E, A
    ld   D, H
    ld   A, [DE]
    ld   [HL+], A
    inc  [HL]
    inc  E
    ld   A, [DE]
    sub  A, [HL]
    jr   NZ, .jr_02_7013
    inc  L
    inc  L
    bit  ACTION_STATE_ADVANCE_ON_END_BIT, [HL]
    jp   NZ, call_02_70f1_Entity_RequestQueuedAction
    inc  L
    ld   B, [HL]
    dec  L
    dec  L
    dec  L
    bit  SPRITE_FLAG_LOOP_LAST_FRAME_BIT, B
    jr   Z, .jr_02_700e
    ld   A, [DE]
    dec  A
.jr_02_700e:
    ld   [HL+], A
    inc  L
    inc  L
    set  SPRITE_FLAG_ANIM_ENDED_BIT, [HL]
.jr_02_7013:
    ld   A, C
    or   A, $0a
    ld   L, A
    set  SPRITE_FLAG_ID_CHANGED_BIT, [HL]
    ld   A, C
    or   A, $07
    ld   L, A
    ld   E, [HL]
    ld   D, $00
    ld   A, C
    or   A, $04
    ld   L, A
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A
    add  HL, DE
    ld   B, [HL]
    ld   A, C
    or   A, $08
    ld   L, A
    ld   H, $d2
    ld   [HL], B

call_02_7030_Entity_NotifyActionChanged:
; Requests the graphics for whatever the entity just changed into. Nothing here is sound
; related - wD588/wD589 name a ROM address, and the flag raised is a VRAM transfer request.
;
; For the player (slot 0) that is all it takes: raise GFX_XFER_PLAYER_GFX and the vblank
; handler streams the new frame into $8000/$8100.
;
; For anything else it only acts when SPRITE_FLAG_STREAMS_OWN_GFX is set. The new sprite id
; becomes the high byte of the ROM source address, the entity id selects the ROM bank out of
; .data_02_7061_EntityGfxBankTable, and GFX_XFER_ENTITY_GFX gets that page copied into
; $8200/$8300.
;
; THERE ARE TWO TILE-STREAMING PATHS AND THIS IS ONLY ONE OF THEM. They do not share a
; table, a bank, a VRAM window or a trigger:
;
;                  this one                      the queued one
;   entities       SPRITE_FLAG_STREAMS_OWN_GFX   SPRITE_FLAG_FIXED_SHAPE and friends
;   table          .data_02_7061 (bank per id)   data_02_743c -> .data_02_726c
;   ROM banks      $18-$1C                       $11-$12
;   VRAM           $8200/$8300, double buffered  $8200, $8400, $8500
;   how much       one page                      one to four pages
;   when           every action change           once, as the room's entities load
;   queued         no, a flag                    yes, wD71A_EntityGfxQueue
;
; So an enemy that animates by swapping its own tiles goes through here every time its
; frame changes, while a platform gets its artwork once on room load and never comes
; back. Thirty entities use this path and ninety-three use the other; four appear in
; both tables - ENTITY_PRE_HISTORY_TRICERATOPS and the three Kung Fu Theater humans -
; which is how a large enemy gets a streamed animation in one VRAM window plus a
; preloaded page in another
    ld   A, [wD300_CurrentEntityAddrLo]
    and  A, A
    jr   NZ, .jr_02_703c
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_PLAYER_GFX, [HL]
    ret
.jr_02_703c:
    or   A, $0a
    ld   L, A
    ld   H, $d2
    bit  SPRITE_FLAG_STREAMS_OWN_GFX_BIT, [HL]
    ret  Z
    ld   A, L
    xor  A, $02
    ld   L, A
    ld   A, [HL]
    ld   [wD588_EntityGfxSrcAddrHi], A
    ld   A, L
    xor  A, $08
    ld   L, A
    ld   L, [HL]
    ld   H, $00
    ld   DE, .data_02_7061_EntityGfxBankTable
    add  HL, DE
    ld   A, [HL]
    ld   [wD589_EntityGfxSrcBank], A
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_ENTITY_GFX, [HL]
    ret
.data_02_7061_EntityGfxBankTable:
; One ROM bank per entity id, and the whole of the streaming path's addressing: the
; page number comes from the entity's live ENTITY_FIELD_SPRITE_ID, so bank plus sprite
; id is a complete ROM address. Banks $18-$1C hold this artwork.
;
; $00 means the entity does not stream. Thirty entities have a bank here; five more
; carry SPRITE_FLAG_STREAMS_OWN_GFX but are left at $00 - ENTITY_UNK_3F, _4A, _6B, _79
; and _8E, none of which appears in any level's entity list, so they are unfinished
; rather than broken
    db   $00             ; $00 ENTITY_GEX
    db   $00             ; $01 ENTITY_COLLECTIBLE_SPAWN
    db   $00             ; $02 ENTITY_UNK_02
    db   $00             ; $03 ENTITY_TV_BUTTON
    db   $18             ; $04 ENTITY_RED_REMOTE
    db   $18             ; $05 ENTITY_SILVER_REMOTE
    db   $18             ; $06 ENTITY_GOLD_REMOTE
    db   $00             ; $07 ENTITY_ENEMY_DEFEATED
    db   $19             ; $08 ENTITY_UNK_08
    db   $00             ; $09 ENTITY_SCREAM_TV_FALLING_PLATFORM
    db   $00             ; $0A ENTITY_SCREAM_TV_MOVING_PLATFORM
    db   $00             ; $0B ENTITY_SCREAM_TV_PUSH_BLOCK
    db   $1a             ; $0C ENTITY_SCREAM_TV_PUMPKIN
    db   $1a             ; $0D ENTITY_SCREAM_TV_FRANKIE
    db   $00             ; $0E ENTITY_SCREAM_TV_HEAD_GHOST
    db   $00             ; $0F ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    db   $1a             ; $10 ENTITY_SCREAM_TV_FLOATING_SKULL
    db   $00             ; $11 ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    db   $1b             ; $12 ENTITY_SCREAM_TV_ZOMBIE
    db   $00             ; $13 ENTITY_SCREAM_TV_ZOMBIE_HEAD
    db   $00             ; $14 ENTITY_SCREAM_TV_FALLING_AXE
    db   $00             ; $15 ENTITY_SCREAM_TV_LANTERN
    db   $19             ; $16 ENTITY_SCREAM_TV_BAT
    db   $00             ; $17 ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    db   $18             ; $18 ENTITY_SCREAM_TV_DOOR_OPENING
    db   $1a             ; $19 ENTITY_SCREAM_TV_GHOST
    db   $00             ; $1A ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    db   $00             ; $1B ENTITY_SCREAM_TV_VANISHING_PLATFORM
    db   $00             ; $1C ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    db   $00             ; $1D ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    db   $00             ; $1E ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    db   $00             ; $1F ENTITY_TOON_TV_MOVING_BEAR_TRAP
    db   $00             ; $20 ENTITY_TOON_TV_BUMBLEBEE
    db   $00             ; $21 ENTITY_TOON_TV_BOWLING_BALL
    db   $00             ; $22 ENTITY_TOON_TV_CACTUS
    db   $00             ; $23 ENTITY_TOON_TV_DOMINO
    db   $00             ; $24 ENTITY_TOON_TV_SHARK
    db   $00             ; $25 ENTITY_TOON_TV_FLOWER
    db   $19             ; $26 ENTITY_TOON_TV_HUNTER
    db   $00             ; $27 ENTITY_TOON_TV_MUSHROOM
    db   $00             ; $28 ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    db   $00             ; $29 ENTITY_TOON_TV_LIZARD
    db   $19             ; $2A ENTITY_TOON_TV_HAPPY_FACE
    db   $00             ; $2B ENTITY_TOON_TV_VANISHING_BLOCK
    db   $00             ; $2C ENTITY_TOON_TV_MOVING_BLOCK
    db   $00             ; $2D ENTITY_TOON_TV_MOVING_LOG
    db   $00             ; $2E ENTITY_TOON_TV_STATIONARY_LOG
    db   $00             ; $2F ENTITY_TOON_TV_FLOWER_HAMMER
    db   $00             ; $30 ENTITY_TOON_TV_HUNTER_BULLET
    db   $00             ; $31 ENTITY_TOON_TV_ROCKET
    db   $1b             ; $32 ENTITY_PRE_HISTORY_FAST_DINOSAUR
    db   $1a             ; $33 ENTITY_PRE_HISTORY_DRAGONFLY
    db   $19             ; $34 ENTITY_PRE_HISTORY_EGG
    db   $00             ; $35 ENTITY_UNK_35
    db   $00             ; $36 ENTITY_UNK_36
    db   $00             ; $37 ENTITY_PRE_HISTORY_FALLING_LAVA
    db   $00             ; $38 ENTITY_PRE_HISTORY_LAVA_RAFT
    db   $00             ; $39 ENTITY_PRE_HISTORY_MOVING_PLATFORM
    db   $00             ; $3A ENTITY_UNK_3A
    db   $00             ; $3B ENTITY_UNK_3B
    db   $1a             ; $3C ENTITY_PRE_HISTORY_PTEROSAUR
    db   $00             ; $3D ENTITY_UNK_3D
    db   $00             ; $3E ENTITY_PRE_HISTORY_FALLING_BOULDER
    db   $00             ; $3F ENTITY_UNK_3F
    db   $00             ; $40 ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    db   $00             ; $41 ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    db   $00             ; $42 ENTITY_PRE_HISTORY_ANT
    db   $00             ; $43 ENTITY_PRE_HISTORY_FIRE_PLANT
    db   $00             ; $44 ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    db   $00             ; $45 ENTITY_PRE_HISTORY_GEYSER
    db   $00             ; $46 ENTITY_UNK_46
    db   $1a             ; $47 ENTITY_PRE_HISTORY_DINOSAUR
    db   $1a             ; $48 ENTITY_PRE_HISTORY_TRICERATOPS
    db   $00             ; $49 ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    db   $00             ; $4A ENTITY_UNK_4A
    db   $00             ; $4B ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    db   $00             ; $4C ENTITY_KUNG_FU_THEATER_CANNON
    db   $00             ; $4D ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    db   $19             ; $4E ENTITY_KUNG_FU_THEATER_DRAGONFLY
    db   $00             ; $4F ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    db   $18             ; $50 ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    db   $00             ; $51 ENTITY_UNK_51
    db   $00             ; $52 ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    db   $18             ; $53 ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    db   $18             ; $54 ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    db   $18             ; $55 ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    db   $00             ; $56 ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    db   $00             ; $57 ENTITY_KUNG_FU_THEATER_LIZARD
    db   $00             ; $58 ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    db   $00             ; $59 ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    db   $00             ; $5A ENTITY_KUNG_FU_THEATER_TALL_JAR
    db   $00             ; $5B ENTITY_KUNG_FU_THEATER_JAR
    db   $00             ; $5C ENTITY_UNK_5C
    db   $00             ; $5D ENTITY_UNK_5D
    db   $00             ; $5E ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    db   $00             ; $5F ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    db   $00             ; $60 ENTITY_UNK_60
    db   $00             ; $61 ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    db   $00             ; $62 ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    db   $00             ; $63 ENTITY_UNK_63
    db   $00             ; $64 ENTITY_UNK_64
    db   $00             ; $65 ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    db   $00             ; $66 ENTITY_REZOPOLIS_MOVING_PLATFORM
    db   $00             ; $67 ENTITY_REZOPOLIS_RED_PLATFORM
    db   $00             ; $68 ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    db   $00             ; $69 ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    db   $00             ; $6A ENTITY_REZOPOLIS_TAILSPIN_GEAR
    db   $00             ; $6B ENTITY_UNK_6B
    db   $00             ; $6C ENTITY_UNK_6C
    db   $00             ; $6D ENTITY_UNK_6D
    db   $1b             ; $6E ENTITY_REZOPOLIS_GREEN_MONSTER
    db   $00             ; $6F ENTITY_UNK_6F
    db   $00             ; $70 ENTITY_UNK_70
    db   $1b             ; $71 ENTITY_REZOPOLIS_PINCER
    db   $00             ; $72 ENTITY_REZOPOLIS_FLAMETHROWER
    db   $1b             ; $73 ENTITY_REZOPOLIS_UFO
    db   $00             ; $74 ENTITY_REZOPOLIS_ANT
    db   $00             ; $75 ENTITY_REZOPOLIS_ANT_SPAWNER
    db   $00             ; $76 ENTITY_CIRCUIT_CENTRAL_ANT
    db   $00             ; $77 ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    db   $00             ; $78 ENTITY_CIRCUIT_CENTRAL_POWER_UP
    db   $00             ; $79 ENTITY_UNK_79
    db   $00             ; $7A ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    db   $00             ; $7B ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    db   $00             ; $7C ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    db   $00             ; $7D ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    db   $00             ; $7E ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    db   $00             ; $7F ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    db   $1a             ; $80 ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    db   $00             ; $81 ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    db   $00             ; $82 ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    db   $00             ; $83 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    db   $00             ; $84 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    db   $00             ; $85 ENTITY_CHANNEL_Z_GUN_PROJECTILE
    db   $1c             ; $86 ENTITY_CHANNEL_Z_REZ
    db   $00             ; $87 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1
    db   $00             ; $88 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2
    db   $00             ; $89 ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    db   $00             ; $8A ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    db   $00             ; $8B ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    db   $00             ; $8C ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    db   $1b             ; $8D ENTITY_CHANNEL_Z_REZ_PORTAL
    db   $00             ; $8E ENTITY_UNK_8E
    db   $00             ; $8F ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

call_02_70f1_Entity_RequestQueuedAction:
; Called when an animation sequence finishes. Reads ACTION_STATE, checks bit 7; if clear, returns (sequence loops).
; If set, masks to low 5 bits and calls call_02_4ccd_Player_RequestAction (likely a state-machine transition
; or death/reset handler)
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_ACTION_STATE_FLAGS
    ld   A, [HL]
    bit  ACTION_STATE_HAS_PENDING_BIT, A
    ret  Z
    and  A, ACTION_STATE_PENDING_ACTION_MASK
    jp   call_02_4ccd_Player_RequestAction

call_02_7102_Entity_SetAction:
; Sets a new action on the current entity. Masks action index to 5 bits, writes to ACTION_ID field,
; then double-indexes data_02_4000_EntityDataTables (by entity ID, then by action index × 4) to get
; the action function pointer and data pointer. Writes function pointer to ACTION_FUNC, reads 4 bytes
; from the data block: byte 0 → ACTION_STATE | $20, byte 1 → SPRITE_FLAGS | $40, byte 2 → SPRITE_FRAME_COUNTER_MAX
; and SPRITE_FRAME_COUNTER, byte 3 → SPRITE_COUNTER_MAX; sets SPRITE_IDS_PTR to 4 bytes into the data block;
; zeroes SPRITE_COUNTER; writes byte 4 to SPRITE_ID; then falls into Entity_NotifyActionChanged
    and  A, $1f
    ld   C, A
    LOAD_OBJ_FIELD_TO_HL_ALT ENTITY_FIELD_ACTION_ID
    ld   [HL], C
    dec  L
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    ld   DE, data_02_4000_EntityActionJumpTable
    add  HL, DE                                        ; HL = data_02_4000_EntityActionJumpTable + 2*ENTITY_FIELD_ENTITY_ID
    ld   E, [HL]
    inc  HL
    ld   D, [HL]
    ld   L, C
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, DE
    LOAD_OBJ_FIELD_TO_DE_ALT ENTITY_FIELD_ACTION_FUNC
    ld   A, [HL+]
    ld   [DE], A                                       ; sets current action pointer in entity instance
    inc  E
    ld   A, [HL+]
    ld   [DE], A                                       ; sets current action pointer in entity instance
    inc  E                                             ; DE = ENTITY_FIELD_ANIM_FRAME_LIST_PTR
    ld   A, [HL+]
    ld   H, [HL]
    ld   L, A                                          ; HL = action data ptr
    LOAD_OBJ_FIELD_TO_BC_ALT ENTITY_FIELD_ACTION_STATE_FLAGS
    ld   A, [HL+]
    or   A, ACTION_STATE_IS_FIRST_FRAME
    ld   [BC], A                                       ; ENTITY_FIELD_ACTION_STATE_FLAGS = first byte in data table | 0x20
    inc  C                                             ; BC = ENTITY_FIELD_SPRITE_FLAGS
    ld   A, [HL+]
    or   A, 1 << SPRITE_FLAG_ID_CHANGED_BIT
    ld   [BC], A                                       ; force a graphics refresh on the new action's first frame
    inc  C                                             ; BC = ENTITY_FIELD_ANIM_SPEED
    ld   A, [HL+]
    ld   [BC], A                                       ; ENTITY_FIELD_ANIM_SPEED = third byte in data table
    inc  C                                             ; BC = ENTITY_FIELD_ANIM_FRAME_COUNT
    push AF
    ld   A, [HL+]
    ld   [BC], A                                       ; ENTITY_FIELD_ANIM_FRAME_COUNT = fourth byte in data table
    ld   A, L
    ld   [DE], A                                       ; ENTITY_FIELD_ANIM_FRAME_LIST_PTR = ptr to 4 bytes after start of data table
    inc  E                                             ; DE = ENTITY_FIELD_ANIM_FRAME_LIST_PTR+1
    ld   A, H
    ld   [DE], A                                       ; ENTITY_FIELD_ANIM_FRAME_LIST_PTR+1 = ptr to 5 bytes after start of data table
    inc  E                                             ; DE = ENTITY_FIELD_ANIM_FRAME_TIMER
    pop  AF
    ld   [DE], A                                       ; ENTITY_FIELD_UNK_06 = third byte in data table
    inc  E                                             ; DE = ENTITY_FIELD_ANIM_FRAME_INDEX
    xor  A, A
    ld   [DE], A                                       ; ENTITY_FIELD_ANIM_FRAME_INDEX = 0
    inc  E                                             ; DE = ENTITY_FIELD_SPRITE_ID
    ld   A, [HL]
    ld   [DE], A                                       ; ENTITY_FIELD_SPRITE_ID = fifth byte in data table
    jp   call_02_7030_Entity_NotifyActionChanged

call_02_715a_MapWindow_Update:
; Calls all three map-window update routines: player window update, vertical scroll check,
; horizontal scroll check
    call call_00_13a6_BgMap_UpdateWindowFromPlayerPos
    call call_02_7164_MapScroll_CheckVertical
    call call_02_7196_MapScroll_CheckHorizontal
    ret

call_02_7164_MapScroll_CheckVertical:
; Reads wD6EF (Y position in map, 16-bit), right-shifts 3 to get tile row, compares against previously
; stored row in wD6F3_BgMap_PrevRow; if changed, sets bit 0 (scroll down) or bit 1 (scroll up) in
; wD6F9_BgMap_LoadingFlags scroll-request flags
    ld   HL, wD6EF_BgMap_ScrollY
    ld   A, [HL+]
    ld   D, [HL]
    ld   [wD5A2_BgMap_ScrollYLo], A
    srl  D
    rra
    srl  D
    rra
    srl  D
    rra
    ld   E, A
    ld   HL, wD6F3_BgMap_PrevRow
    ld   A, [HL]
    ld   [HL], E
    sub  A, E
    ld   E, A
    inc  HL
    ld   A, [HL]
    ld   [HL], D
    sbc  A, D
    ld   D, A
    jr   C, .jr_02_718e
    or   A, E
    ret  Z
    ld   HL, wD6F9_BgMap_LoadingFlags
    ld   A, [HL]
    or   A, MAP_SCROLL_DOWN
    ld   [HL], A
    ret
.jr_02_718e:
    ld   HL, wD6F9_BgMap_LoadingFlags
    ld   A, [HL]
    or   A, MAP_SCROLL_UP
    ld   [HL], A
    ret

call_02_7196_MapScroll_CheckHorizontal:
; Same logic as above for wD6ED (X position in map); sets bit 2 (scroll right) or bit 3 (scroll left)
; in wD6F9_BgMap_LoadingFlags
    ld   HL, wD6ED_BgMap_ScrollX
    ld   A, [HL+]
    ld   D, [HL]
    ld   [wD5A1_BgMap_ScrollXLo], A
    srl  D
    rra
    srl  D
    rra
    srl  D
    rra
    ld   E, A
    ld   HL, wD6F1_BgMap_PrevColumn
    ld   A, [HL]
    ld   [HL], E
    sub  A, E
    ld   E, A
    inc  HL
    ld   A, [HL]
    ld   [HL], D
    sbc  A, D
    ld   D, A
    jr   C, .jr_02_71c0
    or   A, E
    ret  Z
    ld   HL, wD6F9_BgMap_LoadingFlags
    ld   A, [HL]
    or   A, MAP_SCROLL_RIGHT
    ld   [HL], A
    ret
.jr_02_71c0:
    ld   HL, wD6F9_BgMap_LoadingFlags
    ld   A, [HL]
    or   A, MAP_SCROLL_LEFT
    ld   [HL], A
    ret

call_02_71c8_Entities_QueueGraphicsAndPalettes:
; Iterates all 7 NPC slots; for each active entity looks up its entity ID in
; data_02_743c_EntityGfxAndPaletteTable to get a (gfx-set id, palette id) pair.
; The gfx-set id (if non-zero) is queued with call_02_7211_EntityGfxQueue_Enqueue so the
; entity's tiles get streamed into VRAM; on GBC the palette id is loaded via
; call_0b_5f57_Entity_LoadGBCPalette. After the loop, refreshes the fly power-up
; particle palette
    ld   A, [wD300_CurrentEntityAddrLo]
    push AF
    ld   A, ENTITY_SLOT_FIRST_NPC
.jr_02_71ce:
    ld   [wD300_CurrentEntityAddrLo], A
    ld   L, A
    ld   H, $d2
    ld   A, [HL]
    cp   A, ENTITY_ID_NONE
    jr   Z, .jr_02_71fa
    ld   L, A
    ld   H, $00
    add  HL, HL
    ld   DE, data_02_743c_EntityGfxAndPaletteTable
    add  HL, DE
    ld   A, [HL+]
    push HL
    and  A, A
    call NZ, call_02_7211_EntityGfxQueue_Enqueue
    pop  HL
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    jr   Z, .jr_02_71fa
    ld   C, [HL]
    FARCALL call_0b_5f57_Entity_LoadGBCPalette
.jr_02_71fa:
    ld   A, [wD300_CurrentEntityAddrLo]
    add  A, ENTITY_SLOT_SIZE
    jr   NZ, .jr_02_71ce
    FARCALL call_0b_5f1b_FlyPowerup_LoadParticlePalette
    pop  AF
    ld   [wD300_CurrentEntityAddrLo], A
    ret

call_02_7211_EntityGfxQueue_Enqueue:
; Checks if A (entity graphics set id) is already present in the 4-entry queue at
; wD71A_EntityGfxQueue; if found, returns without duplicating it. If the queue has space
; (checked via wD71E_EntityGfxQueueCount), writes A into the next free slot and
; increments the count
    ld   HL, wD71E_EntityGfxQueueCount
    ld   E, [HL]
    ld   HL, wD71A_EntityGfxQueue
    ld   D, ENTITY_GFX_QUEUE_SIZE
.jr_02_721a:
    dec  E
    bit  7, E
    jr   NZ, .jr_02_7226
    cp   A, [HL]
    ret  Z
    inc  HL
    dec  D
    jr   NZ, .jr_02_721a
    ret
.jr_02_7226:
    ld   [HL], A
    ld   HL, wD71E_EntityGfxQueueCount
    inc  [HL]
    ret

call_02_722c_EntityGfxQueue_StartNextTransfer:
; If GFX_XFER_QUEUED_ENTITY_GFX is already set, returns immediately (a transfer is still
; pending). Otherwise pops the next entry off wD71A_EntityGfxQueue, indexes
; .data_02_726c_EntityGfxDescriptors_EntityGfxDescriptors (8-byte records: src bank, src addr lo/hi,
; dest addr lo/hi, size lo/hi, pad), copies the record into
; wD71F_GfxCopy_SrcBank..wD725_GfxCopy_SizeHi and raises GFX_XFER_QUEUED_ENTITY_GFX
; so call_00_0a21_FlushEntityGfxQueue performs the copy
    ld   HL, wD60F_GfxTransferFlags
    bit  GFX_XFER_QUEUED_ENTITY_GFX, [HL]
    ret  NZ
    ld   HL, wD71E_EntityGfxQueueCount
    ld   A, [HL]
    and  A, A
    ret  Z
    dec  [HL]
    ld   L, [HL]
    ld   H, $00
    ld   DE, wD71A_EntityGfxQueue
    add  HL, DE
    ld   L, [HL]
    ld   H, $00
    add  HL, HL
    add  HL, HL
    add  HL, HL
    ld   DE, .data_02_726c_EntityGfxDescriptors
    add  HL, DE
    ld   A, [HL+]
    ld   [wD71F_GfxCopy_SrcBank], A
    ld   A, [HL+]
    ld   [wD720_GfxCopy_SrcAddrLo], A
    ld   A, [HL+]
    ld   [wD721_GfxCopy_SrcAddrHi], A
    ld   A, [HL+]
    ld   [wD722_GfxCopy_DestAddrLo], A
    ld   A, [HL+]
    ld   [wD723_GfxCopy_DestAddrHi], A
    ld   A, [HL+]
    ld   [wD724_GfxCopy_SizeLo], A
    ld   A, [HL+]
    ld   [wD725_GfxCopy_SizeHi], A
    ld   HL, wD60F_GfxTransferFlags
    set  GFX_XFER_QUEUED_ENTITY_GFX, [HL]
    ret
.data_02_726c_EntityGfxDescriptors:
; Fifty-eight tile-streaming jobs, indexed by the graphics-set id in byte +0 of a row
; of data_02_743c_EntityGfxAndPaletteTable. Id $00 is the "this entity has no tiles"
; sentinel, and its record is correspondingly all zeroes - nothing ever runs it,
; because Entity_LoadGfxAndPalette only enqueues a nonzero id.
;
; Every source is in bank $11 or $12, the two entity tile banks, and every destination
; is $8200, $8400 or $8500 - so a job is always "page N of the entity tile bank into
; one of the three shared VRAM windows". Sizes run from one to four pages, which is
; the entity's whole animation: the sprite shape tables in bank 3 never change, so a
; bigger entity is a bigger copy here rather than more layout data there
    entity_gfx_descriptor $00, $0000, $0000, $0000             ; $00 the no-graphics sentinel - never transferred
    entity_gfx_descriptor $12, $4000, $8400, $0100             ; $01 ENTITY_SCREAM_TV_FALLING_PLATFORM and 5 more
    entity_gfx_descriptor $12, $4100, $8500, $0100             ; $02 ENTITY_SCREAM_TV_LANTERN
    entity_gfx_descriptor $12, $5100, $8200, $0200             ; $03 ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    entity_gfx_descriptor $12, $5300, $8200, $0200             ; $04 ENTITY_TOON_TV_MOVING_BEAR_TRAP
    entity_gfx_descriptor $12, $5500, $8200, $0200             ; $05 ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    entity_gfx_descriptor $12, $4b00, $8200, $0300             ; $06 ENTITY_TOON_TV_CACTUS
    entity_gfx_descriptor $12, $4300, $8200, $0400             ; $07 ENTITY_TOON_TV_BOWLING_BALL
    entity_gfx_descriptor $12, $4700, $8200, $0400             ; $08 ENTITY_TOON_TV_FLOWER
    entity_gfx_descriptor $12, $4e00, $8200, $0300             ; $09 ENTITY_TOON_TV_LIZARD
    entity_gfx_descriptor $12, $5d00, $8500, $0100             ; $0a ENTITY_TOON_TV_MOVING_LOG and 1 more
    entity_gfx_descriptor $12, $5b00, $8400, $0100             ; $0b ENTITY_TOON_TV_MUSHROOM
    entity_gfx_descriptor $12, $5e00, $8500, $0100             ; $0c ENTITY_TOON_TV_STATIONARY_LOG
    entity_gfx_descriptor $12, $5a00, $8400, $0100             ; $0d ENTITY_TOON_TV_SHARK
    entity_gfx_descriptor $12, $5900, $8400, $0100             ; $0e ENTITY_TOON_TV_DOMINO
    entity_gfx_descriptor $12, $5700, $8200, $0200             ; $0f ENTITY_TOON_TV_BUMBLEBEE
    entity_gfx_descriptor $12, $5f00, $8400, $0100             ; $10 ENTITY_TOON_TV_VANISHING_BLOCK and 1 more
    entity_gfx_descriptor $12, $6000, $8400, $0100             ; $11 ENTITY_UNK_36
    entity_gfx_descriptor $12, $6100, $8400, $0100             ; $12 ENTITY_PRE_HISTORY_FALLING_LAVA
    entity_gfx_descriptor $12, $6300, $8200, $0300             ; $13 ENTITY_UNK_3D and 1 more
    entity_gfx_descriptor $12, $6e00, $8400, $0200             ; $14 ENTITY_PRE_HISTORY_FIRE_PLANT
    entity_gfx_descriptor $12, $7100, $8500, $0100             ; $15 ENTITY_KUNG_FU_THEATER_TALL_JAR
    entity_gfx_descriptor $12, $7200, $8500, $0100             ; $16 ENTITY_KUNG_FU_THEATER_JAR
    entity_gfx_descriptor $12, $7300, $8200, $0300             ; $17 ENTITY_KUNG_FU_THEATER_LIZARD
    entity_gfx_descriptor $12, $7600, $8400, $0100             ; $18 ENTITY_KUNG_FU_THEATER_CANNON and 5 more
    entity_gfx_descriptor $12, $7700, $8500, $0100             ; $19 ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT and 1 more
    entity_gfx_descriptor $12, $7800, $8400, $0100             ; $1a ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    entity_gfx_descriptor $12, $7900, $8200, $0100             ; $1b ENTITY_UNK_5C and 1 more
    entity_gfx_descriptor $12, $7a00, $8500, $0100             ; $1c ENTITY_UNK_60 and 2 more
    entity_gfx_descriptor $12, $7b00, $8500, $0100             ; $1d ENTITY_KUNG_FU_THEATER_SPIKY_LOG and 2 more
    entity_gfx_descriptor $12, $6600, $8200, $0200             ; $1e ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL and 2 more
    entity_gfx_descriptor $12, $7c00, $8200, $0200             ; $1f ENTITY_UNK_51
    entity_gfx_descriptor $12, $6200, $8500, $0100             ; $20 ENTITY_PRE_HISTORY_LAVA_RAFT and 4 more
    entity_gfx_descriptor $12, $6800, $8200, $0300             ; $21 ENTITY_PRE_HISTORY_GEYSER
    entity_gfx_descriptor $12, $7000, $8500, $0100             ; $22 ENTITY_PRE_HISTORY_TRICERATOPS
    entity_gfx_descriptor $12, $5c00, $8400, $0100             ; $23 ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    entity_gfx_descriptor $12, $4200, $8500, $0100             ; $24 ENTITY_SCREAM_TV_PUSH_BLOCK and 1 more
    entity_gfx_descriptor $12, $6b00, $8200, $0300             ; $25 ENTITY_UNK_35
    entity_gfx_descriptor $11, $4000, $8500, $0100             ; $26 ENTITY_UNK_64 and 4 more
    entity_gfx_descriptor $11, $4100, $8400, $0100             ; $27 ENTITY_UNK_6C and 1 more
    entity_gfx_descriptor $11, $4200, $8200, $0200             ; $28 ENTITY_REZOPOLIS_FLAMETHROWER
    entity_gfx_descriptor $11, $4400, $8400, $0100             ; $29 ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    entity_gfx_descriptor $11, $4500, $8200, $0200             ; $2a ENTITY_REZOPOLIS_TAILSPIN_GEAR
    entity_gfx_descriptor $11, $4700, $8400, $0100             ; $2b ENTITY_UNK_6F and 1 more
    entity_gfx_descriptor $11, $4800, $8200, $0200             ; $2c ENTITY_CIRCUIT_CENTRAL_ANT
    entity_gfx_descriptor $11, $4a00, $8400, $0100             ; $2d ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    entity_gfx_descriptor $11, $4b00, $8400, $0100             ; $2e ENTITY_CIRCUIT_CENTRAL_POWER_UP
    entity_gfx_descriptor $11, $4c00, $8200, $0200             ; $2f ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT and 1 more
    entity_gfx_descriptor $11, $4e00, $8400, $0100             ; $30 ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    entity_gfx_descriptor $11, $4f00, $8500, $0100             ; $31 ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM and 2 more
    entity_gfx_descriptor $11, $5000, $8400, $0200             ; $32 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE and 6 more
    entity_gfx_descriptor $11, $5200, $8200, $0200             ; $33 ENTITY_SCREAM_TV_HEAD_GHOST
    entity_gfx_descriptor $11, $5400, $8400, $0200             ; $34 ENTITY_TOON_TV_ROCKET
    entity_gfx_descriptor $11, $5600, $8400, $0100             ; $35 ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM
    entity_gfx_descriptor $11, $5700, $8500, $0100             ; $36 unused - no entity selects this id
    entity_gfx_descriptor $11, $5800, $8400, $0100             ; $37 ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    entity_gfx_descriptor $11, $4800, $8400, $0200             ; $38 ENTITY_REZOPOLIS_ANT
    entity_gfx_descriptor $11, $5900, $8500, $0100             ; $39 ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON

data_02_743c_EntityGfxAndPaletteTable:
; Two bytes per entity id, 144 rows, read by call_02_71c0_Entity_LoadGfxAndPalette
; when a room's entities are placed.
;
;   +0  graphics-set id into .data_02_726c_EntityGfxDescriptors. $00 means the entity
;       has no tiles of its own; anything else is queued for streaming
;   +1  GBC object palette, passed to call_0b_5f57_Entity_LoadGBCPalette and ignored
;       entirely on a DMG
;
; 97 of the 144 entities stream tiles. The rest are drawn from artwork somebody else
; loaded - platforms and blocks out of the level tileset, projectiles out of their
; parent's pages - which is why they still carry a palette even with no graphics id
    db   $00, $00              ; $00 ENTITY_GEX
    db   $00, $01              ; $01 ENTITY_COLLECTIBLE_SPAWN
    db   $00, $02              ; $02 ENTITY_UNK_02
    db   $00, $06              ; $03 ENTITY_TV_BUTTON
    db   $00, $07              ; $04 ENTITY_RED_REMOTE
    db   $00, $07              ; $05 ENTITY_SILVER_REMOTE
    db   $00, $07              ; $06 ENTITY_GOLD_REMOTE
    db   $00, $00              ; $07 ENTITY_ENEMY_DEFEATED
    db   $00, $00              ; $08 ENTITY_UNK_08
    db   $01, $05              ; $09 ENTITY_SCREAM_TV_FALLING_PLATFORM
    db   $01, $04              ; $0A ENTITY_SCREAM_TV_MOVING_PLATFORM
    db   $24, $05              ; $0B ENTITY_SCREAM_TV_PUSH_BLOCK
    db   $00, $07              ; $0C ENTITY_SCREAM_TV_PUMPKIN
    db   $00, $07              ; $0D ENTITY_SCREAM_TV_FRANKIE
    db   $33, $07              ; $0E ENTITY_SCREAM_TV_HEAD_GHOST
    db   $00, $06              ; $0F ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    db   $00, $07              ; $10 ENTITY_SCREAM_TV_FLOATING_SKULL
    db   $00, $06              ; $11 ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    db   $00, $07              ; $12 ENTITY_SCREAM_TV_ZOMBIE
    db   $00, $06              ; $13 ENTITY_SCREAM_TV_ZOMBIE_HEAD
    db   $01, $03              ; $14 ENTITY_SCREAM_TV_FALLING_AXE
    db   $02, $05              ; $15 ENTITY_SCREAM_TV_LANTERN
    db   $00, $07              ; $16 ENTITY_SCREAM_TV_BAT
    db   $24, $05              ; $17 ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    db   $00, $07              ; $18 ENTITY_SCREAM_TV_DOOR_OPENING
    db   $00, $07              ; $19 ENTITY_SCREAM_TV_GHOST
    db   $01, $05              ; $1A ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    db   $01, $04              ; $1B ENTITY_SCREAM_TV_VANISHING_PLATFORM
    db   $01, $04              ; $1C ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    db   $03, $07              ; $1D ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    db   $05, $07              ; $1E ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    db   $04, $07              ; $1F ENTITY_TOON_TV_MOVING_BEAR_TRAP
    db   $0f, $07              ; $20 ENTITY_TOON_TV_BUMBLEBEE
    db   $07, $07              ; $21 ENTITY_TOON_TV_BOWLING_BALL
    db   $06, $07              ; $22 ENTITY_TOON_TV_CACTUS
    db   $0e, $05              ; $23 ENTITY_TOON_TV_DOMINO
    db   $0d, $05              ; $24 ENTITY_TOON_TV_SHARK
    db   $08, $07              ; $25 ENTITY_TOON_TV_FLOWER
    db   $00, $07              ; $26 ENTITY_TOON_TV_HUNTER
    db   $0b, $05              ; $27 ENTITY_TOON_TV_MUSHROOM
    db   $23, $05              ; $28 ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    db   $09, $07              ; $29 ENTITY_TOON_TV_LIZARD
    db   $00, $07              ; $2A ENTITY_TOON_TV_HAPPY_FACE
    db   $10, $05              ; $2B ENTITY_TOON_TV_VANISHING_BLOCK
    db   $10, $05              ; $2C ENTITY_TOON_TV_MOVING_BLOCK
    db   $0a, $04              ; $2D ENTITY_TOON_TV_MOVING_LOG
    db   $0c, $05              ; $2E ENTITY_TOON_TV_STATIONARY_LOG
    db   $00, $06              ; $2F ENTITY_TOON_TV_FLOWER_HAMMER
    db   $0a, $06              ; $30 ENTITY_TOON_TV_HUNTER_BULLET
    db   $34, $05              ; $31 ENTITY_TOON_TV_ROCKET
    db   $00, $07              ; $32 ENTITY_PRE_HISTORY_FAST_DINOSAUR
    db   $00, $07              ; $33 ENTITY_PRE_HISTORY_DRAGONFLY
    db   $00, $07              ; $34 ENTITY_PRE_HISTORY_EGG
    db   $25, $07              ; $35 ENTITY_UNK_35
    db   $11, $05              ; $36 ENTITY_UNK_36
    db   $12, $05              ; $37 ENTITY_PRE_HISTORY_FALLING_LAVA
    db   $20, $04              ; $38 ENTITY_PRE_HISTORY_LAVA_RAFT
    db   $20, $04              ; $39 ENTITY_PRE_HISTORY_MOVING_PLATFORM
    db   $20, $04              ; $3A ENTITY_UNK_3A
    db   $20, $04              ; $3B ENTITY_UNK_3B
    db   $00, $07              ; $3C ENTITY_PRE_HISTORY_PTEROSAUR
    db   $13, $07              ; $3D ENTITY_UNK_3D
    db   $13, $07              ; $3E ENTITY_PRE_HISTORY_FALLING_BOULDER
    db   $00, $00              ; $3F ENTITY_UNK_3F
    db   $1e, $07              ; $40 ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    db   $1e, $07              ; $41 ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    db   $1e, $07              ; $42 ENTITY_PRE_HISTORY_ANT
    db   $14, $05              ; $43 ENTITY_PRE_HISTORY_FIRE_PLANT
    db   $00, $04              ; $44 ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    db   $21, $07              ; $45 ENTITY_PRE_HISTORY_GEYSER
    db   $20, $04              ; $46 ENTITY_UNK_46
    db   $00, $07              ; $47 ENTITY_PRE_HISTORY_DINOSAUR
    db   $22, $07              ; $48 ENTITY_PRE_HISTORY_TRICERATOPS
    db   $00, $07              ; $49 ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    db   $00, $00              ; $4A ENTITY_UNK_4A
    db   $1a, $05              ; $4B ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    db   $18, $06              ; $4C ENTITY_KUNG_FU_THEATER_CANNON
    db   $18, $06              ; $4D ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    db   $00, $07              ; $4E ENTITY_KUNG_FU_THEATER_DRAGONFLY
    db   $19, $07              ; $4F ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    db   $00, $07              ; $50 ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    db   $1f, $07              ; $51 ENTITY_UNK_51
    db   $19, $07              ; $52 ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    db   $18, $07              ; $53 ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    db   $18, $07              ; $54 ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    db   $18, $07              ; $55 ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    db   $00, $06              ; $56 ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    db   $17, $07              ; $57 ENTITY_KUNG_FU_THEATER_LIZARD
    db   $18, $06              ; $58 ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    db   $1d, $04              ; $59 ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    db   $15, $04              ; $5A ENTITY_KUNG_FU_THEATER_TALL_JAR
    db   $16, $04              ; $5B ENTITY_KUNG_FU_THEATER_JAR
    db   $1b, $07              ; $5C ENTITY_UNK_5C
    db   $1b, $07              ; $5D ENTITY_UNK_5D
    db   $1d, $04              ; $5E ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    db   $1d, $04              ; $5F ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    db   $1c, $04              ; $60 ENTITY_UNK_60
    db   $1c, $04              ; $61 ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    db   $1c, $04              ; $62 ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    db   $00, $04              ; $63 ENTITY_UNK_63
    db   $26, $04              ; $64 ENTITY_UNK_64
    db   $26, $04              ; $65 ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    db   $26, $04              ; $66 ENTITY_REZOPOLIS_MOVING_PLATFORM
    db   $26, $04              ; $67 ENTITY_REZOPOLIS_RED_PLATFORM
    db   $26, $04              ; $68 ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    db   $29, $05              ; $69 ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    db   $2a, $07              ; $6A ENTITY_REZOPOLIS_TAILSPIN_GEAR
    db   $00, $00              ; $6B ENTITY_UNK_6B
    db   $27, $05              ; $6C ENTITY_UNK_6C
    db   $27, $05              ; $6D ENTITY_UNK_6D
    db   $00, $07              ; $6E ENTITY_REZOPOLIS_GREEN_MONSTER
    db   $2b, $05              ; $6F ENTITY_UNK_6F
    db   $2b, $05              ; $70 ENTITY_UNK_70
    db   $00, $07              ; $71 ENTITY_REZOPOLIS_PINCER
    db   $28, $07              ; $72 ENTITY_REZOPOLIS_FLAMETHROWER
    db   $00, $07              ; $73 ENTITY_REZOPOLIS_UFO
    db   $38, $05              ; $74 ENTITY_REZOPOLIS_ANT
    db   $00, $06              ; $75 ENTITY_REZOPOLIS_ANT_SPAWNER
    db   $2c, $07              ; $76 ENTITY_CIRCUIT_CENTRAL_ANT
    db   $2d, $05              ; $77 ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    db   $2e, $05              ; $78 ENTITY_CIRCUIT_CENTRAL_POWER_UP
    db   $00, $00              ; $79 ENTITY_UNK_79
    db   $2f, $07              ; $7A ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    db   $2f, $06              ; $7B ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    db   $30, $05              ; $7C ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    db   $31, $04              ; $7D ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    db   $31, $04              ; $7E ENTITY_CIRCUIT_CENTRAL_POWERED_PLAFORM
    db   $31, $04              ; $7F ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    db   $00, $07              ; $80 ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    db   $00, $07              ; $81 ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    db   $00, $07              ; $82 ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    db   $32, $05              ; $83 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    db   $32, $05              ; $84 ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    db   $32, $05              ; $85 ENTITY_CHANNEL_Z_GUN_PROJECTILE
    db   $00, $07              ; $86 ENTITY_CHANNEL_Z_REZ
    db   $32, $04              ; $87 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1
    db   $32, $04              ; $88 ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2
    db   $32, $06              ; $89 ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    db   $32, $03              ; $8A ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    db   $37, $05              ; $8B ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    db   $39, $04              ; $8C ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    db   $00, $07              ; $8D ENTITY_CHANNEL_Z_REZ_PORTAL
    db   $00, $07              ; $8E ENTITY_UNK_8E
    db   $35, $05              ; $8F ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM

INCLUDE "code/bank02_entity_action_data.asm"
