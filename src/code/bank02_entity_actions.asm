; ==================================================================
; ENTITY ACTION TABLES
;
; One table per entity type. call_02_7102_Entity_SetAction reaches them in two
; steps: data_02_4000_EntityActionJumpTable (bank02_update_entities.asm) maps an
; ENTITY_FIELD_ENTITY_ID to the table below, and the requested action id then
; indexes 4 bytes into it. So the ROWS of each table ARE the action ids, and
; every entity begins life in row $00 - Entity_SetAction is called with A = 0
; when the entity is placed.
;
; Each row is
;
;     dw <action function>, <action data block>
;
; The action function is called once a frame while that action is current, with
; wD300_CurrentEntityAddrLo pointing at the entity's slot. It is entered through
; call_00_10bd_JumpHL, so HL holds the function's own address on entry - which a
; couple of routines here accidentally depend on.
;
; The action data block is the animation, in bank02_entity_action_data.asm.
; Entity_SetAction copies its 4-byte header into the instance
; (ACTION_STATE flags, SPRITE_FLAGS, frame tick, frame count) and points
; ANIM_FRAME_LIST_PTR at the list of frame ids that follows. Two rows pointing at
; the same function with different data blocks is therefore one behaviour drawn
; two ways - see ENTITY_SCREAM_TV_ZOMBIE, whose actions $00 and $01 are the same
; walk with and without a head.
;
; A table with a single row is an entity with exactly one action, whose function
; is named _Update by convention; multi-row tables name each row for its state.
; ==================================================================

data_02_4ddb_EntityActions_CollectibleSpawn:                        ;; ENTITY_COLLECTIBLE_SPAWN
    dw   call_02_51b7_EntityAction_CollectibleSpawn_Update, data_02_7cce
data_02_4ddf_EntityActions_TVButton:                                ;; ENTITY_TV_BUTTON
    dw   call_02_51ea_EntityAction_TVButton_Ready, data_02_7945   ; action $00
    dw   call_02_5252_EntityAction_TVButton_Pressed, data_02_794b   ; action $01
data_02_4de7_EntityActions_RedRemote:                               ;; ENTITY_RED_REMOTE
    dw   call_02_5253_EntityAction_RedRemote_Dmg, data_02_7690   ; action $00
    dw   call_02_526a_EntityAction_RedRemote_Gbc, data_02_769d   ; action $01
data_02_4def_EntityActions_SilverRemote:                            ;; ENTITY_SILVER_REMOTE
    dw   call_02_5284_EntityAction_SilverRemote_Dmg, data_02_769d   ; action $00
    dw   call_02_528d_EntityAction_SilverRemote_Gbc, data_02_769d   ; action $01
data_02_4df7_EntityActions_GoldRemote:                              ;; ENTITY_GOLD_REMOTE
    dw   call_02_528e_EntityAction_GoldRemote_Dmg, data_02_76a8   ; action $00
    dw   call_02_5297_EntityAction_GoldRemote_Gbc, data_02_769d   ; action $01
data_02_4dff_EntityActions_Unk02:                                   ;; ENTITY_UNK_02
    dw   call_02_52aa_EntityAction_Unk02_Update, data_02_768a
data_02_4e03_EntityActions_ParticleBurst:                           ;; ENTITY_ENEMY_DEFEATED
    dw   call_02_52ab_EntityAction_ParticleBurst_Update, data_02_7cd4
data_02_4e07_EntityActions_Unk08:                                   ;; ENTITY_UNK_08
    dw   call_02_52e7_EntityAction_Unk08_Update, data_02_76b5

data_02_4e0b_EntityActions_ScreamTVFallingPlatform:                 ;; ENTITY_SCREAM_TV_FALLING_PLATFORM
    dw   call_02_52e8_EntityAction_ScreamTVFallingPlatform_Update, data_02_7963
data_02_4e0f_EntityActions_ScreamTVMovingPlatform:                  ;; ENTITY_SCREAM_TV_MOVING_PLATFORM
    dw   call_02_5348_EntityAction_ScreamTVMovingPlatform_Update, data_02_7969
data_02_4e13_EntityActions_ScreamTVPushBlock:                       ;; ENTITY_SCREAM_TV_PUSH_BLOCK
    dw   call_02_5373_EntityAction_ScreamTVPushBlock_Update, data_02_796f
data_02_4e17_EntityActions_ScreamTVPumpkin:                         ;; ENTITY_SCREAM_TV_PUMPKIN
    dw   call_02_538b_EntityAction_Pumpkin_Crouch, data_02_76b5   ; action $00
    dw   call_02_5399_EntityAction_Pumpkin_Hop,    data_02_76bf   ; action $01
data_02_4e1f_EntityActions_ScreamTVFrankie:                         ;; ENTITY_SCREAM_TV_FRANKIE
    dw   call_02_53aa_EntityAction_Frankie_Update, data_02_76c7
data_02_4e23_EntityActions_ScreamTVHeadGhost:                       ;; ENTITY_SCREAM_TV_HEAD_GHOST
    dw   call_02_53ad_EntityAction_HeadGhost_ThrowHead, data_02_7920   ; action $00
    dw   call_02_53d9_EntityAction_HeadGhost_Recover,   data_02_792d   ; action $01
data_02_4e2b_EntityActions_ScreamTVHeadGhostHead:                   ;; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    dw   call_02_53e2_EntityAction_GhostHead_Update, data_02_7933
data_02_4e2f_EntityActions_ScreamTVFloatingSkull:                   ;; ENTITY_SCREAM_TV_FLOATING_SKULL
    dw   call_02_5434_EntityAction_FloatingSkull_Idle,    data_02_76d0   ; action $00
    dw   call_02_5440_EntityAction_FloatingSkull_Spit,    data_02_76d9   ; action $01
    dw   call_02_545b_EntityAction_FloatingSkull_Recover, data_02_76df   ; action $02
data_02_4e3b_EntityActions_ScreamTVFloatingSkullProjectile:         ;; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    dw   call_02_5464_EntityAction_FloatingSkullProjectile_Init, data_02_7b0f   ; action $00
    dw   call_02_546e_EntityAction_FloatingSkullProjectile_Fly,  data_02_7ce6   ; action $01
data_02_4e43_EntityActions_ScreamTVZombie:                          ;; ENTITY_SCREAM_TV_ZOMBIE
    dw   call_02_5480_EntityAction_Zombie_Walk,    data_02_76e5   ; action $00
    dw   call_02_5480_EntityAction_Zombie_Walk,    data_02_76ee   ; action $01
    dw   call_02_54b4_EntityAction_Zombie_Stagger, data_02_76f7   ; action $02
data_02_4e4f_EntityActions_ScreamTVZombieHead:                      ;; ENTITY_SCREAM_TV_ZOMBIE_HEAD
    dw   call_02_54c6_EntityAction_ZombieHead_Launch,   data_02_768a   ; action $00
    dw   call_02_54df_EntityAction_ZombieHead_Bounce,   data_02_768a   ; action $01
    dw   call_02_54fc_EntityAction_ZombieHead_Grounded, data_02_768a   ; action $02
data_02_4e5b_EntityActions_ScreamTVFallingAxe:                      ;; ENTITY_SCREAM_TV_FALLING_AXE
    dw   call_02_54ff_EntityAction_FallingAxe_WaitForCue, data_02_7939   ; action $00
    dw   call_02_5513_EntityAction_FallingAxe_Fall,       data_02_7939   ; action $01
    dw   call_02_552c_EntityAction_FallingAxe_Impact,     data_02_793f   ; action $02
    dw   call_02_5535_EntityAction_FallingAxe_Retract,    data_02_7939   ; action $03
data_02_4e6b_EntityActions_ScreamTVLantern:                         ;; ENTITY_SCREAM_TV_LANTERN
    dw   call_02_5544_EntityAction_Lantern_Lit,    data_02_7951   ; action $00
    dw   call_02_5551_EntityAction_Lantern_Doused, data_02_7957   ; action $01
data_02_4e73_EntityActions_ScreamTVBat:                             ;; ENTITY_SCREAM_TV_BAT
    dw   call_02_557c_EntityAction_Bat_Update, data_02_76fd
data_02_4e77_EntityActions_ScreamTVOrangeMovingPlatform:            ;; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    dw   call_02_5589_EntityAction_ScreamTVOrangeMovingPlatform_Update, data_02_7975
data_02_4e7b_EntityActions_ScreamTVDoorOpening:                     ;; ENTITY_SCREAM_TV_DOOR_OPENING
    dw   call_02_559b_EntityAction_ScreamTVDoorOpening_Idle, data_02_7706   ; action $00
    dw   call_02_559c_EntityAction_ScreamTVDoorOpening_Open, data_02_770f   ; action $01
data_02_4e83_EntityActions_ScreamTVGhost:                           ;; ENTITY_SCREAM_TV_GHOST
    dw   call_02_55a3_EntityAction_Ghost_VanishAndRelocate, data_02_7718   ; action $00
    dw   call_02_55e8_EntityAction_Ghost_Reappear,          data_02_7722   ; action $01
    dw   call_02_55f1_EntityAction_Ghost_Dormant,           data_02_772c   ; action $02
    dw   call_02_5612_EntityAction_Ghost_Chase,             data_02_7733   ; action $03
data_02_4e93_EntityActions_ScreamTVClimbWallSunEnemy:               ;; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    dw   call_02_5628_EntityAction_ClimbWallSunEnemy_Update, data_02_795d
data_02_4e97_EntityActions_ScreamTVVanishingPlatform:               ;; ENTITY_SCREAM_TV_VANISHING_PLATFORM
    dw   call_02_563a_EntityAction_ScreamTVVanishingPlatform_WaitForCue, data_02_797b   ; action $00
    dw   call_02_5652_EntityAction_ScreamTVVanishingPlatform_BlinkOut,   data_02_797b   ; action $01
    dw   call_02_56a1_EntityAction_ScreamTVVanishingPlatform_Gone,       data_02_7981   ; action $02
data_02_4ea3_EntityActions_ScreamTVMonaLisaElevator:                ;; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    dw   call_02_56af_EntityAction_MonaLisaElevator_Update, data_02_7987

data_02_4ea7_EntityActions_ToonTVHardHeadAreaHazard:                ;; ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD
    dw   call_02_56dc_EntityAction_HardHeadAreaHazard_Aim, data_02_798d   ; action $00
    dw   call_02_576e_EntityAction_HardHeadAreaHazard_Drop, data_02_7993   ; action $01
    dw   call_02_576e_EntityAction_HardHeadAreaHazard_Drop, data_02_7999   ; action $02
data_02_4eb3_EntityActions_ToonTVStationaryBearTrap:                ;; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    dw   call_02_57f3_EntityAction_StationaryBearTrap_Wait, data_02_79a6   ; action $00
    dw   call_02_5803_EntityAction_StationaryBearTrap_Leap, data_02_79ac   ; action $01
data_02_4ebb_EntityActions_ToonTVMovingBearTrap:                    ;; ENTITY_TOON_TV_MOVING_BEAR_TRAP
    dw   call_02_5812_EntityAction_MovingBearTrap_Crouch, data_02_79b3   ; action $00
    dw   call_02_5830_EntityAction_MovingBearTrap_Hop, data_02_79b9   ; action $01
data_02_4ec3_EntityActions_ToonTVBumblebee:                         ;; ENTITY_TOON_TV_BUMBLEBEE
    dw   call_02_5843_EntityAction_Bumblebee_Cruise, data_02_799f   ; action $00
    dw   call_02_585e_EntityAction_Bumblebee_Charge, data_02_799f   ; action $01
data_02_4ecb_EntityActions_ToonTVBowlingBall:                       ;; ENTITY_TOON_TV_BOWLING_BALL
    dw   call_02_5871_EntityAction_BowlingBall_Update, data_02_79c5
data_02_4ecf_EntityActions_ToonTVCactus:                            ;; ENTITY_TOON_TV_CACTUS
    dw   call_02_58d3_EntityAction_Cactus_Dormant, data_02_79d6   ; action $00
    dw   call_02_58e8_EntityAction_Cactus_WindUp, data_02_79dc   ; action $01
    dw   call_02_58fa_EntityAction_Cactus_Leap, data_02_79e3   ; action $02
data_02_4edb_EntityActions_ToonTVDomino:                            ;; ENTITY_TOON_TV_DOMINO
    dw   call_02_590b_EntityAction_Domino_Update, data_02_79e9
data_02_4edf_EntityActions_ToonTVShark:                             ;; ENTITY_TOON_TV_SHARK
    dw   call_02_591c_EntityAction_Shark_Update, data_02_79ef
data_02_4ee3_EntityActions_ToonTVFlower:                            ;; ENTITY_TOON_TV_FLOWER
    dw   call_02_592d_EntityAction_Flower_Update, data_02_79f6   ; action $00
    dw   call_02_592d_EntityAction_Flower_Update, data_02_79fc   ; action $01
    dw   call_02_592d_EntityAction_Flower_Update, data_02_7a02   ; action $02
data_02_4eef_EntityActions_ToonTVHunter:                            ;; ENTITY_TOON_TV_HUNTER
    dw   call_02_5993_EntityAction_Hunter_Patrol, data_02_774c   ; action $00
    dw   call_02_59c8_EntityAction_Hunter_Fire, data_02_7759   ; action $01
    dw   call_02_59d2_EntityAction_Hunter_Stagger, data_02_7768   ; action $02
    dw   call_02_59db_EntityAction_Hunter_FallOver, data_02_777c   ; action $03
    dw   call_02_59e4_EntityAction_Hunter_Downed, data_02_7784   ; action $04
    dw   call_02_59ed_EntityAction_Hunter_GetUp, data_02_778a   ; action $05
data_02_4f07_EntityActions_ToonTVMushroom:                          ;; ENTITY_TOON_TV_MUSHROOM
    dw   call_02_5a28_EntityAction_Mushroom_Update, data_02_7a1b
data_02_4f0b_EntityActions_ToonTVMushroomProjectile:                ;; ENTITY_TOON_TV_MUSHROOM_PROJECTILE
    dw   call_02_5a73_EntityAction_MushroomProjectile_Update, data_02_7a21
data_02_4f0f_EntityActions_ToonTVLizard:                            ;; ENTITY_TOON_TV_LIZARD
    dw   call_02_5a7d_EntityAction_ToonTVLizard_Update, data_02_7a3a
data_02_4f13_EntityActions_ToonTVHappyFace:                         ;; ENTITY_TOON_TV_HAPPY_FACE
    dw   call_02_5a8c_EntityAction_HappyFace_Crouch, data_02_773a   ; action $00
    dw   call_02_5a9a_EntityAction_HappyFace_Hop, data_02_7744   ; action $01
data_02_4f1b_EntityActions_ToonTVVanishingBlock:                    ;; ENTITY_TOON_TV_VANISHING_BLOCK
    dw   call_02_5aab_EntityAction_ToonTVVanishingBlock_WaitForCue, data_02_7a45   ; action $00
    dw   call_02_5aea_EntityAction_ToonTVVanishingBlock_BlinkOut, data_02_7a45   ; action $01
    dw   call_02_5b39_EntityAction_ToonTVVanishingBlock_Gone, data_02_7a4b   ; action $02
data_02_4f27_EntityActions_ToonTVMovingBlock:                       ;; ENTITY_TOON_TV_MOVING_BLOCK
    dw   call_02_5b47_EntityAction_ToonTVMovingBlock_Run, data_02_7a51   ; action $00
    dw   call_02_5b9d_EntityAction_ToonTVMovingBlock_PauseAtEnd, data_02_7a51   ; action $01
data_02_4f2f_EntityActions_ToonTVMovingLog:                         ;; ENTITY_TOON_TV_MOVING_LOG
    dw   call_02_5bb6_EntityAction_MovingLog_Update, data_02_7a2e
data_02_4f33_EntityActions_ToonTVStationaryLog:                     ;; ENTITY_TOON_TV_STATIONARY_LOG
    dw   call_02_5be1_EntityAction_StationaryLog_Update, data_02_7a34
data_02_4f37_EntityActions_ToonTVFlowerHammer:                      ;; ENTITY_TOON_TV_FLOWER_HAMMER
    dw   call_02_596c_EntityAction_FlowerHammer_Hang, data_02_7a08   ; action $00
    dw   call_02_597a_EntityAction_FlowerHammer_Fall, data_02_7a0e   ; action $01
    dw   call_02_598c_EntityAction_FlowerHammer_Shatter, data_02_7a15   ; action $02
data_02_4f43_EntityActions_ToonTVHunterBullet:                      ;; ENTITY_TOON_TV_HUNTER_BULLET
    dw   call_02_5a10_EntityAction_HunterBullet_Init, data_02_79d0   ; action $00
    dw   call_02_5a1f_EntityAction_HunterBullet_Fly, data_02_79d0   ; action $01
data_02_4f4b_EntityActions_ToonTVRocket:                            ;; ENTITY_TOON_TV_ROCKET
    dw   call_02_5be2_EntityAction_Rocket_Idle, data_02_7c7b   ; action $00
    dw   call_02_5bf7_EntityAction_Rocket_Ignite, data_02_7c81   ; action $01
    dw   call_02_5c00_EntityAction_Rocket_Launch, data_02_7c9a   ; action $02

data_02_4f57_EntityActions_PreHistoryFastDinosaur:                  ;; ENTITY_PRE_HISTORY_FAST_DINOSAUR
    dw   call_02_5c08_EntityAction_FastDinosaur_Update, data_02_7790
data_02_4f5b_EntityActions_PreHistoryDragonfly:                     ;; ENTITY_PRE_HISTORY_DRAGONFLY
    dw   call_02_5c10_EntityAction_PreHistoryDragonfly_Update, data_02_77a7
data_02_4f5f_EntityActions_PreHistoryEgg:                           ;; ENTITY_PRE_HISTORY_EGG
    dw   call_02_5c18_EntityAction_Egg_Flee, data_02_77d5   ; action $00
    dw   call_02_5c47_EntityAction_Egg_Leap, data_02_77e2   ; action $01
    dw   call_02_5c5b_EntityAction_Egg_Land, data_02_77ea   ; action $02
data_02_4f6b_EntityActions_Unk35:                                   ;; ENTITY_UNK_35
    dw   call_02_5c69_EntityAction_Unk35_Dormant, data_02_7a62   ; action $00
    dw   call_02_5c73_EntityAction_Unk35_Erupt, data_02_7a68   ; action $01
data_02_4f73_EntityActions_Unk36:                                   ;; ENTITY_UNK_36
    dw   call_02_5c7c_EntityAction_Unk36_Update, data_02_7a57
data_02_4f77_EntityActions_PreHistoryFallingLava:                   ;; ENTITY_PRE_HISTORY_FALLING_LAVA
    dw   call_02_5c7d_EntityAction_FallingLava_Gather, data_02_7a73   ; action $00
    dw   call_02_5c9c_EntityAction_FallingLava_Fall, data_02_7a79   ; action $01
data_02_4f7f_EntityActions_PreHistoryLavaRaft:                      ;; ENTITY_PRE_HISTORY_LAVA_RAFT
    dw   call_02_5ca8_EntityAction_LavaRaft_Drift, data_02_7a84   ; action $00
    dw   call_02_5cba_EntityAction_LavaRaft_Moored, data_02_7a8a   ; action $01
data_02_4f87_EntityActions_PreHistoryMovingPlatform:                ;; ENTITY_PRE_HISTORY_MOVING_PLATFORM
    dw   call_02_5cbb_EntityAction_PreHistoryMovingPlatform_Update, data_02_7a90
data_02_4f8b_EntityActions_Unk3A:                                   ;; ENTITY_UNK_3A
    dw   call_02_5ccd_EntityAction_Unk3A_Update, data_02_7a96
data_02_4f8f_EntityActions_Unk3B:                                   ;; ENTITY_UNK_3B
    dw   call_02_5cce_EntityAction_Unk3B_Update, data_02_7a9c
data_02_4f93_EntityActions_PreHistoryPterosaur:                     ;; ENTITY_PRE_HISTORY_PTEROSAUR
    dw   call_02_5ccf_EntityAction_Pterosaur_Update, data_02_77b2
data_02_4f97_EntityActions_Unk3D:                                   ;; ENTITY_UNK_3D
    dw   call_02_5d0b_EntityAction_Unk3D_Update, data_02_7aa8
data_02_4f9b_EntityActions_PreHistoryFallingBoulder:                ;; ENTITY_PRE_HISTORY_FALLING_BOULDER
    dw   call_02_5d0c_EntityAction_FallingBoulder_WaitForCue, data_02_7aae   ; action $00
    dw   call_02_5d37_EntityAction_FallingBoulder_Fall, data_02_7ab4   ; action $01
    dw   call_02_5d48_EntityAction_FallingBoulder_Smash, data_02_7aba   ; action $02
    dw   call_02_5d5b_EntityAction_FallingBoulder_Shards, data_02_7cda   ; action $03
data_02_4fab_EntityActions_Unk3F:                                   ;; ENTITY_UNK_3F
    dw   call_02_5d6f_EntityAction_Unk3F_Update, data_02_7790
data_02_4faf_EntityActions_PreHistoryBeetleHorizontal:              ;; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    dw   call_02_5d81_EntityAction_BeetleHorizontal_Update, data_02_7ac1
data_02_4fb3_EntityActions_PreHistoryBeetleVertical:                ;; ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    dw   call_02_5d70_EntityAction_BeetleVertical_Update, data_02_7ac8
data_02_4fb7_EntityActions_PreHistoryAnt:                           ;; ENTITY_PRE_HISTORY_ANT
    dw   call_02_5d81_EntityAction_BeetleHorizontal_Update, data_02_7acf
data_02_4fbb_EntityActions_PreHistoryFirePlant:                     ;; ENTITY_PRE_HISTORY_FIRE_PLANT
    dw   call_02_5d92_EntityAction_FirePlant_Idle, data_02_7aef   ; action $00
    dw   call_02_5db2_EntityAction_FirePlant_Hop, data_02_7af8   ; action $01
    dw   call_02_5dd3_EntityAction_FirePlant_Recover, data_02_7b01   ; action $02
data_02_4fc7_EntityActions_PreHistoryFirePlantProjectiles:          ;; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    dw   call_02_5ddc_EntityAction_FirePlantProjectiles_Init, data_02_7b08   ; action $00
    dw   call_02_5de6_EntityAction_FirePlantProjectiles_Fly, data_02_7ce0   ; action $01
data_02_4fcf_EntityActions_PreHistoryGeyser:                        ;; ENTITY_PRE_HISTORY_GEYSER
    dw   call_02_5df8_EntityAction_Geyser_Dormant, data_02_7ad8   ; action $00
    dw   call_02_5e02_EntityAction_Geyser_Erupt, data_02_7ade   ; action $01
data_02_4fd7_EntityActions_Unk46:                                   ;; ENTITY_UNK_46
    dw   call_02_5e0b_EntityAction_Unk46_Update, data_02_7aa2
data_02_4fdb_EntityActions_PreHistoryDinosaur:                      ;; ENTITY_PRE_HISTORY_DINOSAUR
    dw   call_02_5e0c_EntityAction_Dinosaur_Update, data_02_77bd
data_02_4fdf_EntityActions_PreHistoryTriceratops:                   ;; ENTITY_PRE_HISTORY_TRICERATOPS
    dw   call_02_5e26_EntityAction_Triceratops_Update, data_02_77ca
data_02_4fe3_EntityActions_PreHistoryTriceratopsHorn:               ;; ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    dw   call_02_5e90_EntityAction_TriceratopsHorn_Update, data_02_7ae9
data_02_4fe7_EntityActions_Unk4A:                                   ;; ENTITY_UNK_4A
    dw   call_02_5e91_EntityAction_Unk4A_Update, data_02_7790

data_02_4feb_EntityActions_KungFuTheaterHangingBlade:               ;; ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    dw   call_02_5e92_EntityAction_HangingBlade_Update, data_02_7b15
data_02_4fef_EntityActions_KungFuTheaterCannon:                     ;; ENTITY_KUNG_FU_THEATER_CANNON
    dw   call_02_5ebd_EntityAction_Cannon_Update, data_02_7b1b
data_02_4ff3_EntityActions_KungFuTheaterCannonProjectile:           ;; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    dw   call_02_5ef0_EntityAction_CannonProjectile_Init, data_02_7b21   ; action $00
    dw   call_02_5efa_EntityAction_CannonProjectile_Fly, data_02_7b21   ; action $01
data_02_4ffb_EntityActions_KungFuTheaterDragonfly:                  ;; ENTITY_KUNG_FU_THEATER_DRAGONFLY
    dw   call_02_5f48_EntityAction_KungFuDragonfly_Update, data_02_77f2
data_02_4fff_EntityActions_KungFuTheaterDragonBodySegment:          ;; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    dw   call_02_5f50_EntityAction_DragonBodySegment_Update, data_02_7b27
data_02_5003_EntityActions_KungFuTheaterDragonHead:                 ;; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    dw   call_02_5f67_EntityAction_DragonHead_Update, data_02_7824
data_02_5007_EntityActions_Unk51:                                   ;; ENTITY_UNK_51
    dw   call_02_616d_EntityAction_Unk51_Update, data_02_7b2d
data_02_500b_EntityActions_KungFuTheaterDragonProjectile:           ;; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    dw   call_02_6152_EntityAction_DragonProjectile_Init, data_02_7b39   ; action $00
    dw   call_02_615f_EntityAction_DragonProjectile_Fly, data_02_7b39   ; action $01
data_02_5013_EntityActions_KungFuTheaterWalkingNinja:               ;; ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    dw   call_02_616e_EntityAction_Ninja_Ground, data_02_77fd   ; action $00
    dw   call_02_6213_EntityAction_Ninja_Slash, data_02_7806   ; action $01
    dw   call_02_621c_EntityAction_Ninja_Throw, data_02_7815   ; action $02
data_02_501f_EntityActions_KungFuTheaterJumpingNinja:               ;; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    dw   call_02_616e_EntityAction_Ninja_Ground, data_02_77fd   ; action $00
    dw   call_02_6213_EntityAction_Ninja_Slash, data_02_7806   ; action $01
    dw   call_02_621c_EntityAction_Ninja_Throw, data_02_7815   ; action $02
    dw   call_02_6235_EntityAction_Ninja_Jump, data_02_781e   ; action $03
data_02_502f_EntityActions_KungFuTheaterSamuraiBody:                ;; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    dw   call_02_624c_EntityAction_SamuraiBody_Walk, data_02_782a   ; action $00
    dw   call_02_62c3_EntityAction_SamuraiBody_Slash, data_02_7837   ; action $01
data_02_5037_EntityActions_KungFuTheaterSamuraiHead:                ;; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    dw   call_02_62db_EntityAction_SamuraiHead_Riding, data_02_7b6c   ; action $00
    dw   call_02_62fc_EntityAction_SamuraiHead_Launched, data_02_7b6c   ; action $01
    dw   call_02_6327_EntityAction_SamuraiHead_Grounded, data_02_7b72   ; action $02
data_02_5043_EntityActions_KungFuTheaterLizard:                     ;; ENTITY_KUNG_FU_THEATER_LIZARD
    dw   call_02_6335_EntityAction_KungFuLizard_Update, data_02_7b7a
data_02_5047_EntityActions_KungFuTheaterNinjaProjectile:            ;; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    dw   call_02_633d_EntityAction_NinjaProjectile_Init, data_02_7b85   ; action $00
    dw   call_02_6347_EntityAction_NinjaProjectile_Fly, data_02_7b85   ; action $01
data_02_504f_EntityActions_KungFuTheaterSpikyLog:                   ;; ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    dw   call_02_6355_EntityAction_SpikyLog_Update, data_02_7b8c
data_02_5053_EntityActions_KungFuTheaterTallJar:                    ;; ENTITY_KUNG_FU_THEATER_TALL_JAR
    dw   call_02_635d_EntityAction_Jar_Intact, data_02_7b92   ; action $00
    dw   call_02_6375_EntityAction_Jar_Shatter, data_02_7cec   ; action $01
data_02_505b_EntityActions_KungFuTheaterJar:                        ;; ENTITY_KUNG_FU_THEATER_JAR
    dw   call_02_635d_EntityAction_Jar_Intact, data_02_7b92   ; action $00
    dw   call_02_6375_EntityAction_Jar_Shatter, data_02_7cec   ; action $01
data_02_5063_EntityActions_Unk5C:                                   ;; ENTITY_UNK_5C
    dw   call_02_6387_EntityAction_Unk5C_Update, data_02_7b98
data_02_5067_EntityActions_Unk5D:                                   ;; ENTITY_UNK_5D
    dw   call_02_6388_EntityAction_KungFuVanishingPlatform_WaitForCue, data_02_7b98
data_02_506b_EntityActions_KungFuTheaterVanishingPlatform:          ;; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    dw   call_02_6388_EntityAction_KungFuVanishingPlatform_WaitForCue, data_02_7b42   ; action $00
    dw   call_02_63ac_EntityAction_KungFuVanishingPlatform_BlinkOut, data_02_7b42   ; action $01
    dw   call_02_63fb_EntityAction_KungFuVanishingPlatform_Gone, data_02_7b48   ; action $02
data_02_5077_EntityActions_KungFuTheaterMovingPlatform:             ;; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    dw   call_02_6409_EntityAction_KungFuMovingPlatform_Update, data_02_7b4e
data_02_507b_EntityActions_Unk60:                                   ;; ENTITY_UNK_60
    dw   call_02_6434_EntityAction_Unk60_Update, data_02_7b54
data_02_507f_EntityActions_KungFuTheaterMovingRaft:                 ;; ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    dw   call_02_6435_EntityAction_MovingRaft_Update, data_02_7b5a
data_02_5083_EntityActions_KungFuTheaterStationaryRaft:             ;; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    dw   call_02_6447_EntityAction_StationaryRaft_Update, data_02_7b60
data_02_5087_EntityActions_Unk63:                                   ;; ENTITY_UNK_63
    dw   call_02_6448_EntityAction_Unk63_Update, data_02_7b66
data_02_508b_EntityActions_Unk64:                                   ;; ENTITY_UNK_64
    dw   call_02_6449_EntityAction_Unk64_Update, data_02_7b98

data_02_508f_EntityActions_RezopolisSpecialMovingPlatform:          ;; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    dw   call_02_644a_EntityAction_RezopolisSpecialMovingPlatform_Update, data_02_7b98
data_02_5093_EntityActions_RezopolisMovingPlatform:                 ;; ENTITY_REZOPOLIS_MOVING_PLATFORM
    dw   call_02_649c_EntityAction_RezopolisMovingPlatform_Update, data_02_7b9e
data_02_5097_EntityActions_RezopolisRedPlatform:                    ;; ENTITY_REZOPOLIS_RED_PLATFORM
    dw   call_02_64ae_EntityAction_RedPlatform_Update, data_02_7ba4
data_02_509b_EntityActions_RezopolisActivatedRedPlatform:           ;; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    dw   call_02_650f_EntityAction_ActivatedRedPlatform_Update, data_02_7ba4
data_02_509f_EntityActions_RezopolisTailspinPlatform:               ;; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    dw   call_02_655d_EntityAction_TailspinPlatform_Update, data_02_7baa
data_02_50a3_EntityActions_RezopolisTailspinGear:                   ;; ENTITY_REZOPOLIS_TAILSPIN_GEAR
    dw   call_02_65b7_EntityAction_TailspinGear_Stopped, data_02_7bbd   ; action $00
    dw   call_02_65c0_EntityAction_TailspinGear_Slow, data_02_7bc3   ; action $01
    dw   call_02_65c9_EntityAction_TailspinGear_Medium, data_02_7bcc   ; action $02
    dw   call_02_65d2_EntityAction_TailspinGear_Fast, data_02_7bd5   ; action $03
    dw   call_02_65db_EntityAction_TailspinGear_Full, data_02_7bde   ; action $04
data_02_50b7_EntityActions_Unk6B:                                   ;; ENTITY_UNK_6B
    dw   call_02_6626_EntityAction_Unk6B_Update, data_02_7790
data_02_50bb_EntityActions_Unk6C:                                   ;; ENTITY_UNK_6C
    dw   call_02_6627_EntityAction_Unk6C_Update, data_02_7bb0
data_02_50bf_EntityActions_Unk6D:                                   ;; ENTITY_UNK_6D
    dw   call_02_6628_EntityAction_Unk6D_Update, data_02_7bb0
data_02_50c3_EntityActions_RezopolisGreenMonster:                   ;; ENTITY_REZOPOLIS_GREEN_MONSTER
    dw   call_02_6629_EntityAction_GreenMonster_Walk, data_02_7865   ; action $00
    dw   call_02_6632_EntityAction_GreenMonster_Unused1, data_02_7872   ; action $01
    dw   call_02_6633_EntityAction_GreenMonster_Unused2, data_02_7879   ; action $02
data_02_50cf_EntityActions_Unk6F:                                   ;; ENTITY_UNK_6F
    dw   call_02_6634_EntityAction_Unk6F_Update, data_02_7bf0
data_02_50d3_EntityActions_Unk70:                                   ;; ENTITY_UNK_70
    dw   call_02_6635_EntityAction_Unk70_Update, data_02_7bf0
data_02_50d7_EntityActions_RezopolisPincer:                         ;; ENTITY_REZOPOLIS_PINCER
    dw   call_02_6636_EntityAction_Pincer_Update, data_02_7880
data_02_50db_EntityActions_RezopolisFlamethrower:                   ;; ENTITY_REZOPOLIS_FLAMETHROWER
    dw   call_02_664b_EntityAction_Flamethrower_Update, data_02_7bb0   ; action $00
    dw   call_02_664c_EntityAction_Flamethrower_Unused, data_02_7bb0   ; action $01
data_02_50e3_EntityActions_RezopolisUfo:                            ;; ENTITY_REZOPOLIS_UFO
    dw   call_02_664d_EntityAction_UFO_Patrol, data_02_784d   ; action $00
    dw   call_02_666b_EntityAction_UFO_Unused, data_02_785c   ; action $01
data_02_50eb_EntityActions_RezopolisAnt:                            ;; ENTITY_REZOPOLIS_ANT
    dw   call_02_66bb_EntityAction_Ant_Update, data_02_7be7
data_02_50ef_EntityActions_RezopolisAntSpawner:                     ;; ENTITY_REZOPOLIS_ANT_SPAWNER
    dw   call_02_666c_EntityAction_AntSpawner_Update, data_02_7c6f

data_02_50f3_EntityActions_CircuitCentralAnt:                       ;; ENTITY_CIRCUIT_CENTRAL_ANT
    dw   call_02_66db_EntityAction_CircuitCentralAnt_Update, data_02_7bf0
data_02_50f7_EntityActions_CircuitCentralCapacitor:                 ;; ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    dw   call_02_66e3_EntityAction_Capacitor_Charge, data_02_7bf9   ; action $00
    dw   call_02_66f1_EntityAction_Capacitor_Hop, data_02_7c01   ; action $01
data_02_50ff_EntityActions_CircuitCentralPowerUp:                   ;; ENTITY_CIRCUIT_CENTRAL_POWER_UP
    dw   call_02_66fd_EntityAction_PowerUp_Upright, data_02_7c07   ; action $00
    dw   call_02_6710_EntityAction_PowerUp_Flipped, data_02_7c07   ; action $01
data_02_5107_EntityActions_Unk79:                                   ;; ENTITY_UNK_79
    dw   call_02_6723_EntityAction_Unk79_Update, data_02_7790
data_02_510b_EntityActions_CircuitCentralLittleRobot:               ;; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    dw   call_02_6724_EntityAction_LittleRobot_Walk, data_02_7c10   ; action $00
    dw   call_02_676c_EntityAction_LittleRobot_Turn, data_02_7c16   ; action $01
data_02_5113_EntityActions_CircuitCentralLittleRobotGear:           ;; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    dw   call_02_6775_EntityAction_LittleRobotGear_Update, data_02_7c1d
data_02_5117_EntityActions_CircuitCentralElectricBall:              ;; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    dw   call_02_6786_EntityAction_ElectricBall_WaitForCue, data_02_7c25   ; action $00
    dw   call_02_679e_EntityAction_ElectricBall_FollowPath, data_02_7c2b   ; action $01
data_02_511f_EntityActions_CircuitCentralMovingPlatform:            ;; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    dw   call_02_68c0_EntityAction_CircuitCentralMovingPlatform_Update, data_02_7c42
data_02_5123_EntityActions_CircuitCentralPoweredPlatform:           ;; ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM
    dw   call_02_696f_EntityAction_CircuitCentralPoweredPlatform_Idle, data_02_7c34   ; action $00
    dw   call_02_6993_EntityAction_CircuitCentralPoweredPlatform_Run, data_02_7c3a   ; action $01
    dw   call_02_69c4_EntityAction_CircuitCentralPoweredPlatform_PauseAtEnd, data_02_7c48   ; action $02
data_02_512f_EntityActions_CircuitCentralLoweringPlatform:          ;; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    dw   call_02_69d7_EntityAction_CircuitCentralLoweringPlatform_Update, data_02_7c50
data_02_5133_EntityActions_CircuitCentralWalkerRobot:               ;; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    dw   call_02_6a33_EntityAction_WalkerRobot_Update, data_02_7889
data_02_5137_EntityActions_CircuitCentralPoweredWalkway:            ;; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    dw   call_02_6a3b_EntityAction_PoweredWalkway_Update, data_02_7c56
data_02_513b_EntityActions_CircuitCentralWalkwayActivator:          ;; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    dw   call_02_6a3c_EntityAction_WalkwayActivator_Update, data_02_7c5c

data_02_513f_EntityActions_ChannelZArcedGunProjectile:              ;; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    dw   call_02_6a8b_EntityAction_ArcedGunProjectile_WaitForCue, data_02_7c62   ; action $00
    dw   call_02_6aac_EntityAction_ArcedGunProjectile_Arc, data_02_7c68   ; action $01
data_02_5147_EntityActions_ChannelZArcedGunProjectile2:             ;; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    dw   call_02_6ad3_EntityAction_ArcedGunProjectile2_WaitForCue, data_02_7c62   ; action $00
    dw   call_02_6af9_EntityAction_ArcedGunProjectile2_Arc, data_02_7c68   ; action $01
    dw   call_02_6b30_EntityAction_ArcedGunProjectile2_Hover, data_02_7c68   ; action $02
    dw   call_02_6b43_EntityAction_ArcedGunProjectile2_Drop, data_02_7c68   ; action $03
data_02_5157_EntityActions_ChannelZGunProjectile:                   ;; ENTITY_CHANNEL_Z_GUN_PROJECTILE
    dw   call_02_6b6a_EntityAction_GunProjectile_WaitForCue, data_02_7c62   ; action $00
    dw   call_02_6b81_EntityAction_GunProjectile_Fly, data_02_7c68   ; action $01
data_02_515f_EntityActions_ChannelZRez:                             ;; ENTITY_CHANNEL_Z_REZ
    dw   call_02_6c18_EntityAction_Rez_Intro,  data_02_78a8   ; action $00
    dw   call_02_6c41_EntityAction_Rez_Unused1,  data_02_78b5   ; action $01
    dw   call_02_6c4a_EntityAction_Rez_Chase,  data_02_78d7   ; action $02
    dw   call_02_6c42_EntityAction_Rez_Recover,  data_02_78e4   ; action $03
    dw   call_02_6c82_EntityAction_Rez_Hit,  data_02_78c2   ; action $04
    dw   call_02_6c99_EntityAction_Rez_Untouchable,  data_02_78f1   ; action $05
    dw   call_02_6c99_EntityAction_Rez_Untouchable,  data_02_78f1   ; action $06
    dw   call_02_6c99_EntityAction_Rez_Untouchable,  data_02_78f1   ; action $07
    dw   call_02_6c99_EntityAction_Rez_Untouchable,  data_02_78f1   ; action $08
    dw   call_02_6c9d_EntityAction_Rez_ButtonHit,  data_02_78fc   ; action $09
    dw   call_02_6ca6_EntityAction_Rez_Unused10, data_02_790b   ; action $0A
data_02_518b_EntityActions_ChannelZUnusedPlatform1:                 ;; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_1
    dw   call_02_6d11_EntityAction_ChannelZUnusedPlatform1_Update, data_02_7c75
data_02_518f_EntityActions_ChannelZUnusedPlatform2:                 ;; ENTITY_CHANNEL_Z_UNUSED_PLATFORM_2
    dw   call_02_6d23_EntityAction_ChannelZUnusedPlatform2_Update, data_02_7c75
data_02_5193_EntityActions_ChannelZRezFollowingFire:                ;; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    dw   call_02_6cca_EntityAction_RezFollowingFire_Update, data_02_7ca1
data_02_5197_EntityActions_ChannelZGunProjectileExplosion:          ;; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    dw   call_02_6d24_EntityAction_GunProjectileExplosion_Update, data_02_7caa
data_02_519b_EntityActions_FinalBattleButtonProjectile:             ;; ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE
    dw   call_02_6d5d_EntityAction_FinalBattleButtonProjectile_Fall, data_02_7cb6   ; action $00
    dw   call_02_6d7f_EntityAction_FinalBattleButtonProjectile_Unused, data_02_7cb6   ; action $01
data_02_51a3_EntityActions_ChannelZFinalBattleButton:               ;; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    dw   call_02_6d80_EntityAction_FinalBattleButton_Ready, data_02_7cbc   ; action $00
    dw   call_02_6db8_EntityAction_FinalBattleButton_Pressed, data_02_7cc2   ; action $01
data_02_51ab_EntityActions_ChannelZRezPortal:                       ;; ENTITY_CHANNEL_Z_REZ_PORTAL
    dw   call_02_6de3_EntityAction_RezPortal_Update, data_02_7894
data_02_51af_EntityActions_Unk8E:                                   ;; ENTITY_UNK_8E
    dw   call_02_6df0_EntityAction_Unk8E_Update, data_02_791a

data_02_51b3_EntityActions_MediaDimensionMovingPlatform:            ;; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM
    dw   call_02_6df1_EntityAction_MediaDimensionMovingPlatform_Update, data_02_7cc8

; ==================================================================
; GENERIC ENTITIES
;
; Entity ids $01-$08: the ones that are not tied to a single channel. Pickups,
; the hub's TV buttons and remotes, and the burst an enemy leaves behind.
;
; ENTITY_UNK_02 ($02) and ENTITY_UNK_08 ($08) are `ret` stubs with a real slot in
; the jump table, so the ids exist but do nothing
; ==================================================================

call_02_51b7_EntityAction_CollectibleSpawn_Update:
; One action. This entity draws itself entirely out of its particle buffer -
; data_02_7cce sets SPRITE_FLAG_EMBEDDED_SPRITE_DATA and
; call_03_6584_Particles_BuildSpriteList_Collectible emits one OAM record per
; particle whose bit 7 is set, so there is no frame list involved.
;
; Note that the builder tests particle bit 7 while Entity_TickParticles tests
; bit 0. A particle can therefore be drawn but no longer simulated, which is what
; a settled pickup is: TickParticles goes quiet, and from then on the routine is
; just a lifetime counter.
;
; The usual way to get one of these is not the entity list - it is
; call_02_52ab_EntityAction_ParticleBurst_Update below, which rewrites a spent
; defeat burst into this entity type
    call call_00_3b8d_Entity_TickParticles
    push AF
    FARCALL call_03_6584_Particles_BuildSpriteList_Collectible
    jr   NZ, .jr_02_51cc                               ; drew something
    pop  AF
    jp   call_00_3931_Entity_DeactivateSelf            ; nothing visible left
.jr_02_51cc:
    pop  AF                                            ; A/flags from TickParticles
    ret  NZ                                            ; particles still moving - not settled yet
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [HL]                                          ; lifetime, $FF when the burst created it
    jp   Z, call_00_3931_Entity_DeactivateSelf         ; timed out
    ld   C, [HL]
    xor  A, $12                                        ; $18 -> $0A SPRITE_FLAGS
    ld   L, A
    res  SPRITE_FLAG_INVISIBLE_BIT, [HL]
    ld   A, C
    cp   A, $40
    ret  NC                                            ; more than $40 left - solid
    and  A, $04                                        ; last $40 frames: 4 on, 4 off
    ret  Z
    set  SPRITE_FLAG_INVISIBLE_BIT, [HL]
    ret

; ------------------------------------------------------------------
; TV BUTTON - the pad in front of each hub television, and the exit pad inside a
; level. Two actions: $00 is the raised button and does all the work, $01 is the
; pressed pose and is a bare `ret`.
;
; call_00_3878_Entity_CheckTVButtonEnabled decides whether it is usable, and it
; asks a completely different question in each place: in the hub (level $00) it
; compares the three collection totals against three required counts carried in
; this entity's own spawn parameters, while in a level it looks up a block patch
; slot. Either way A = 0 means locked, and a locked button flickers - visible for
; 20 frames out of every 32
; ------------------------------------------------------------------

call_02_51ea_EntityAction_TVButton_Ready:
    call call_00_3878_Entity_CheckTVButtonEnabled
    ld   E, A
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    res  SPRITE_FLAG_INVISIBLE_BIT, [HL]
    inc  E
    dec  E
    jr   NZ, .jr_02_5207
    ld   A, [wD73B_VBlankFrameCounter]
    and  A, $1f
    cp   A, $0c
    jr   NC, .jr_02_5207
    set  SPRITE_FLAG_INVISIBLE_BIT, [HL]
.jr_02_5207:
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  0, B
    ret  Z                                             ; nobody on the pad
    call call_00_3878_Entity_CheckTVButtonEnabled
    ret  Z                                             ; locked
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    jr   Z, .jr_02_521b
    ld   HL, wD647_ExitTVButtonIndex
    ld   [HL], E                                       ; in a level: remember which exit was used
.jr_02_521b:
    call call_00_34f5_Entity_IsPlayerStandingOnSelf    ; asked a second time
    bit  0, B
    ret  Z
    ld   BC, $05
    call call_00_37d8_Entity_MoveY                     ; sink the pad 5px
    ld   A, $01
    call call_02_7102_Entity_SetAction                 ; pressed pose
    ld   A, [wD624_CurrentLevelId]
    and  A, A
    jr   NZ, .jr_02_524d
; In the hub, the button's position in the level's entity list is what identifies
; which television it belongs to: (list index - 1) / 2 becomes the respawn point
; Gex will come back out at
    ld   A, [wD300_CurrentEntityAddrLo]
    rlca
    rlca
    rlca
    and  A, $07
    ld   L, A
    ld   H, $00
    ld   DE, wD301_EntityListIndexesForCurrentEntities
    add  HL, DE
    ld   A, [HL]
    dec  A
    srl  A
    ld   [wD628_MediaDimensionRespawnPoint], A
    ld   A, PLAYER_ACTION_ENTER_TV
    jp   call_02_4ccd_Player_RequestAction
.jr_02_524d:
    ld   A, PLAYER_ACTION_ENTER_TV_ALT
    jp   call_02_4ccd_Player_RequestAction
call_02_5252_EntityAction_TVButton_Pressed:
; Action $01. Nothing to do - Gex is already being carried into the television by
; the player action the routine above requested
    ret

; ------------------------------------------------------------------
; THE THREE REMOTES - and the reason each of them has two actions.
;
; All three follow the same shape: action $00 is entered on spawn, checks
; wD59E_OnGBCFlag, and on a Colour Game Boy switches to action $01. Both actions
; then FALL THROUGH into a common body, so action $00 runs action $01's code as
; well and nothing is lost on a DMG.
;
; The switch is purely about artwork. Compare the frame lists:
;
;   red     action $00 -> data_02_7690 ($40-$47)   action $01 -> data_02_769d
;   silver  action $00 -> data_02_769d             action $01 -> data_02_769d
;   gold    action $00 -> data_02_76a8 ($50-$57)   action $01 -> data_02_769d
;
; On a Colour Game Boy all three end up on the SAME sprite set, $48-$4D, and are
; told apart by the CGB palette the spawn code loaded. On a DMG there are no
; palettes to tell them apart, so red and gold keep their own distinct frames -
; the artwork is doing the job the colour would have done
; ------------------------------------------------------------------

call_02_5253_EntityAction_RedRemote_Dmg:
; Action $00. Also the only place the hub's television screen image is requested:
; Remote_TriggerPaletteSwap maps this remote's entity-list index to a TV screen id
; and raises GFX_XFER_MEDIA_DIMENSION_TV. It does nothing outside the hub
    call call_00_34ea_Entity_IsFirstFrameOfAction
    call NZ, call_00_3bf4_Remote_TriggerPaletteSwap
    ld   HL, wD60F_GfxTransferFlags
    bit  GFX_XFER_MEDIA_DIMENSION_TV, [HL]
    call Z, call_00_0634_FlyPowerup_StartEntry         ; screen is up - bring the fly in
    ld   A, [wD59E_OnGBCFlag]
    and  A, A
    ld   A, $01
    call NZ, call_02_7102_Entity_SetAction             ; GBC: take the colour frames
call_02_526a_EntityAction_RedRemote_Gbc:
; Action $01, and the tail of action $00. Solid once this level's red remote has
; been earned, flickering at 30Hz while it has not
    call call_00_38c1_Entity_CheckRedRemoteProgressFlag
    ld   E, A
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    res  SPRITE_FLAG_INVISIBLE_BIT, [HL]
    inc  E
    dec  E                                             ; test E without disturbing A
    ret  NZ                                            ; earned - draw it solid
    ld   A, [wD73B_VBlankFrameCounter]
    and  A, $01
    ret  Z
    set  SPRITE_FLAG_INVISIBLE_BIT, [HL]               ; every other frame
    ret

call_02_5284_EntityAction_SilverRemote_Dmg:
; Action $00. Both silver actions point at the same frame list, so the hand-off
; below changes nothing visible - it is here to keep all three remotes the same
; shape. Everything silver does happens in
; .jr_03_????_CollisionHandler_SilverRemote, not in its action
    ld   a,[wD59E_OnGBCFlag]
    and  a
    ld   a,$01
    call nz,call_02_7102_Entity_SetAction
call_02_528d_EntityAction_SilverRemote_Gbc:
    ret

call_02_528e_EntityAction_GoldRemote_Dmg:
; Action $00. The gold remote is the bonus-level prize, so it is only allowed to
; exist once the level's collectible quota is met
    ld   a,[wD59E_OnGBCFlag]
    and  a
    ld   a,$01
    call nz,call_02_7102_Entity_SetAction
call_02_5297_EntityAction_GoldRemote_Gbc:
; Action $01, and the tail of action $00. wD649_CollectibleAmount counts DOWN to
; zero in a bonus level, so a nonzero value means there is still something left to
; collect and the remote removes itself. Once it is zero the remote stays and
; chirps twice a second to advertise where it is
    ld   a,[wD649_CollectibleAmount]
    and  a
    jp   nz,call_00_3931_Entity_DeactivateSelf
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$1F
    ret  nz
    ld   c,SFX_GOLD_REMOTE
    call call_00_112f_QueueSFX
    ret

call_02_52aa_EntityAction_Unk02_Update:
; ENTITY_UNK_02. Occupies an id and an action table but does nothing
    ret

call_02_52ab_EntityAction_ParticleBurst_Update:
; ENTITY_ENEMY_DEFEATED - the puff an enemy turns into when it is beaten, created
; by call_00_3985_Entity_ParticleBurstInit from the collision handlers.
;
; The interesting part is what happens when the puff finishes. Rather than freeing
; the slot, the routine REWRITES THE SLOT INTO A DIFFERENT ENTITY: it stores
; entity id $01 (ENTITY_COLLECTIBLE_SPAWN) over its own id, gives itself a
; $2C x $10 COLLISION_TYPE_COLLECTIBLE box and a $FF-frame lifetime, arms a small
; particle burst as the pickup's artwork, and calls Entity_SetAction $00 - which
; re-reads the jump table and comes back with the collectible's action instead.
;
; So "enemy drops a pickup" is one entity changing species in place, and
; call_02_51b7_EntityAction_CollectibleSpawn_Update takes over from the next frame
    call call_00_3b8d_Entity_TickParticles
    jr   Z, .jr_02_52bc                                ; burst finished
    FARCALL call_03_65f9_Particles_BuildSpriteList_DefeatBurst
    ret  NZ
.jr_02_52bc:
    ld   C, $01
    call call_00_37e7_Entity_SetOamAttrBase            ; OBJ palette 1
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   [HL], $ff                                     ; the pickup's lifetime
    ld   A, L
    xor  A, $18                                        ; $18 -> $00 ENTITY_ID
    ld   L, A
    ld   [HL], $01                                     ; become ENTITY_COLLECTIBLE_SPAWN
    ld   A, L
    xor  A, $14                                        ; $00 -> $14 COLLISION_WIDTH
    ld   L, A
    ld   A, $2c
    ld   [HL+], A                                      ; width
    ld   A, $10
    ld   [HL+], A                                      ; height
    ld   A, COLLISION_TYPE_COLLECTIBLE
    ld   [HL], A
    ld   C, PARTICLE_PATTERN_BURST_SMALL
    call call_00_3a23_Entity_StartParticleEffect
    xor  A, A
    jp   call_02_7102_Entity_SetAction                 ; action $00 of the NEW entity id

call_02_52e7_EntityAction_Unk08_Update:
; ENTITY_UNK_08. Another id that exists but does nothing
    ret

; ==================================================================
; SCREAM TV
;
; Entity ids $09 (ENTITY_SCREAM_TV_FALLING_PLATFORM) through $1C
; (ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR). Their action tables are the
; data_02_4e0b .. data_02_4ea3 block at the top of this file.
;
; Two conventions run through the whole set and are worth reading once rather
; than re-deriving per entity:
;
; HL WALKING. An action is entered with HL pointing wherever the last helper
; left it, and the code then walks HL up and down the $20-byte instance with
; `inc l` / `dec l` / `xor` rather than re-deriving the address. So a bare
; `inc l` is a field step. The offsets that matter here are
;   $0A SPRITE_FLAGS   $17 MISC_FLAGS      $18 MISC_TIMER_1   $19 MISC_TIMER_2
;   $1A MISC_PARAM     $1B MISC_PARAM_HI   $1C X_VELOCITY     $1E Y_VELOCITY
;
; CHILD SPAWN PARAMETERS. When one of these spawns a child through
; call_0a_7b9a_EntitySpawn_SpawnChildEntity, the child is handed the PARENT's
; position: the parent's 16-bit world X lands in the child's $18/$19 and the
; parent's 16-bit world Y in its $1A/$1B, before the per-child offset from
; .data_0a_7c92_EntityChildSpawnData is applied to the child's own $0E/$10.
; That is why the ghost head and the zombie head read timer and misc-param
; fields as coordinates - they are "where my parent was standing"
; ==================================================================

call_02_52e8_EntityAction_ScreamTVFallingPlatform_Update:
; The platform that sags under Gex and then climbs back. One action; the phase
; lives in MISC_FLAGS bits 0 and 1 instead of in the action id, so the sprite
; never changes (data_02_7963 is a single frozen frame).
;
;   neither bit   parked at the top, waiting to be stood on
;   bit 0         armed: 100-frame grace period, then sinking
;   bit 1         bottomed out: 250-frame pause, then climbing back
;
; The travel distance is not a constant - MISC_TIMER_2 holds it as a spawn
; parameter, in units of the 2px step below, and MISC_PARAM counts down through
; it on the way down and back up to it on the way up. Two entries in the same
; level can therefore sink by different amounts.
;
; Stepping back on during the climb cancels it (bit 1 -> bit 0, grace timer
; zeroed) so the platform starts sinking again immediately from wherever it is
    call call_00_34f5_Entity_IsPlayerStandingOnSelf    ; HL = $17 MISC_FLAGS, B = player is riding
    bit  0,[hl]                                        ; already sinking?
    jr   nz,.jr_02_52FF
    bit  1,[hl]                                        ; already climbing back?
    jr   nz,.jr_02_5323
    bit  0,b                                           ; parked: nothing to do until Gex steps on
    ret  z
    set  0,[hl]                                        ; arm it
    inc  l                                             ; $18 MISC_TIMER_1
    ld   a,$64
    ldi  [hl],a                                        ; grace period = 100 frames; HL = $19 MISC_TIMER_2
    ldi  a,[hl]                                        ; A = total travel; HL = $1A MISC_PARAM
    ld   [hl],a                                        ; travel remaining = total travel
    ret
.jr_02_52FF:
; Armed. Burn the grace period, creak once as it expires, then descend.
    inc  l                                             ; $18 MISC_TIMER_1
    ld   a,[hl]
    and  a
    jr   z,.jr_02_530C                                 ; grace period already spent
    dec  [hl]
    ret  nz
    ld   c,SFX_FALLING_PLATFORM                        ; the creak, on the frame it hits zero
    call call_00_112f_QueueSFX
    ret
.jr_02_530C:
    inc  l
    inc  l                                             ; $1A MISC_PARAM = travel remaining
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_531C
    dec  l
    dec  l                                             ; $18 MISC_TIMER_1
    ld   [hl],$FA                                      ; bottomed out: hold for 250 frames
    dec  l                                             ; $17 MISC_FLAGS
    res  0,[hl]
    set  1,[hl]                                        ; hand over to the climb-back phase
    ret
.jr_02_531C:
    dec  [hl]                                          ; one step of travel used
    ld   bc,$0002
    jp   call_00_37d8_Entity_MoveY                     ; sink 2px
.jr_02_5323:
; Bottomed out or climbing. Gex stepping back on restarts the sink from here.
    bit  0,b
    jr   z,.jr_02_532F
    res  1,[hl]
    set  0,[hl]
    inc  l                                             ; $18 MISC_TIMER_1
    ld   [hl],$00                                      ; no grace period on the retrigger
    ret
.jr_02_532F:
    inc  l                                             ; $18 MISC_TIMER_1
    ld   a,[hl]
    and  a
    jr   z,.jr_02_5336
    dec  [hl]                                          ; still resting at the bottom
    ret
.jr_02_5336:
    inc  l                                             ; $19 MISC_TIMER_2 = total travel
    ldi  a,[hl]                                        ; HL = $1A MISC_PARAM
    cp   [hl]                                          ; travelled back all the way?
    jr   nz,.jr_02_5341
    dec  l
    dec  l
    dec  l                                             ; $17 MISC_FLAGS
    ld   [hl],$00                                      ; back to parked
    ret
.jr_02_5341:
    inc  [hl]                                          ; one step of travel recovered
    ld   bc,$FFFE
    jp   call_00_37d8_Entity_MoveY                     ; climb 2px

; ------------------------------------------------------------------
; PATROLLING PLATFORM PROLOGUE
;
; Four of the Scream TV platforms share the same opening five instructions:
;
;     call Entity_IsFirstFrameOfAction     ; leaves HL at $09 ACTION_STATE
;     jr   z, ...
;     ld   a, l / xor $10 / ld l, a        ; $09 xor $10 = $19 MISC_TIMER_2
;     ld   a, [hl-] / dec l                ; read it, step back to $17
;     ld   [hl], a                         ; MISC_FLAGS = MISC_TIMER_2
;
; MISC_TIMER_2 is one of the spawn-parameter slots (SPAWN_PARAM_TO_TIMER_2), so
; this copies a byte straight out of the level's entity list into MISC_FLAGS on
; the platform's first frame. That byte is the patrol configuration that
; call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip then reads: bit 1 picks
; the axis and bits 7/6 the starting direction. In other words the level data,
; not the code, decides which way each copy of the platform runs
; ------------------------------------------------------------------

call_02_5348_EntityAction_ScreamTVMovingPlatform_Update:
; Straight patrolling platform, optionally gated on a switch.
;
; MISC_PARAM is a wD78B_BlockPatch_SlotTable index: $FF means "no gate, always
; running", anything else is masked to a slot number and the platform stays
; frozen until that block-patch slot goes non-empty. That is how a switch
; elsewhere in the room starts a platform moving
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   Z, .jr_02_5354
    ld   A, L
    xor  A, $10                                        ; $09 -> $19 MISC_TIMER_2
    ld   L, A
    ld   A, [HL-]
    dec  L                                             ; -> $17 MISC_FLAGS
    ld   [HL], A                                       ; patrol config from the spawn record
.jr_02_5354:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   A, [HL]
    cp   A, $ff                                        ; $FF = ungated
    jr   Z, .jr_02_536d
    and  A, $0f                                        ; otherwise a block patch slot number
    ld   L, A
    ld   H, $00
    ld   DE, wD78B_BlockPatch_SlotTable
    add  HL, DE
    ld   A, [HL]
    and  A, A
    ret  Z                                             ; slot still empty - stay put
.jr_02_536d:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_5373_EntityAction_ScreamTVPushBlock_Update:
; The pushable block. It has no movement code of its own - the player pushes it
; through call_00_35d5_Entity_MoveXAndPushPlayer, driven from the collision side.
; All this action does is watch where the block has got to and fire the level
; event once it is far enough left.
;
; The threshold is the literal world X $02A0, and the event is block patch slot 0
; going from empty to $02 (triggered), which runs the tile sequence that opens
; the way on. The `and a / ret nz` guard means it only fires once, and only if
; nothing else is already using slot 0
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ldi  a,[hl]
    sub  a,$A0
    ld   a,[hl]
    sbc  a,$02                                         ; world X - $02A0
    ret  nc                                            ; not pushed far enough left yet
    ld   hl,wD78B_BlockPatch_SlotTable                 ; slot 0
    ld   a,[hl]
    and  a
    ret  nz                                            ; already triggered
    ld   [hl],$02
    ret

call_02_538b_EntityAction_Pumpkin_Crouch:
; Action $00. Squash-and-stretch wind-up: hold still until the 5-frame squash
; animation (data_02_76b5) wraps, then set an upward Y velocity and hand over to
; the hop. Nothing here moves the pumpkin - the launch is one write to YVEL.
    call call_00_3843_Entity_CheckAnimationEnded
    ret  Z
    ld   C, $28
    call call_00_335a_Entity_SetYVelocity
    ld   A, $01
    jp   call_02_7102_Entity_SetAction

call_02_5399_EntityAction_Pumpkin_Hop:
; Action $01. Airborne: gravity, then the landing test. Entity_ClampYToMaxYBound
; returns carry while the pumpkin is still above its floor, so `ret c` is "keep
; falling"; falling through means it touched down this frame, so thump and go
; back to the crouch. The pumpkin never moves horizontally
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  C
    ld   C, SFX_ENEMY_BOUNCE
    call call_00_112f_QueueSFX
    ld   A, $00
    jp   call_02_7102_Entity_SetAction

call_02_53aa_EntityAction_Frankie_Update:
; One action, one instruction: walk back and forth between the X bounds in the
; spawn record, turning to face Gex whenever he is inside them. The step size is
; whatever the spawn record put in X_VELOCITY
    jp   call_00_3364_Entity_ApproachPlayerXWithBounds

call_02_53ad_EntityAction_HeadGhost_ThrowHead:
; Action $00. The ghost that lobs its own head at you.
;
; On the first frame it takes its facing from bit 0 of MISC_TIMER_2, so the level
; data picks which way each one is aimed. After that it just waits out the 8-frame
; wind-up (data_02_7920) and, on the frame it wraps, spawns the head and drops
; into the recovery action. It never moves
    call call_00_34ea_Entity_IsFirstFrameOfAction      ; HL = $09 ACTION_STATE
    jr   z,.jr_02_53C3
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ld   c,$00                                         ; face right
    bit  0,[hl]
    jr   z,.jr_02_53BE
    ld   c,$20                                         ; face left
.jr_02_53BE:
    ld   a,l
    xor  a,$14                                         ; $19 -> $0D FACING_FLAGS
    ld   l,a
    ld   [hl],c
.jr_02_53C3:
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,SPAWN_CHILD_ENTITY_GHOST_HEAD
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_53d9_EntityAction_HeadGhost_Recover:
; Action $01. Cooldown - one frozen frame held for $2d ticks (data_02_792d), then
; straight back to the throw. So the ghost fires on a fixed cycle regardless of
; where Gex is
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    call nz,call_02_7102_Entity_SetAction
    ret

call_02_53e2_EntityAction_GhostHead_Update:
; The thrown head, and the most interesting movement code in the Scream TV set:
; it does not bounce along the ground, it bounces along a 45-degree line anchored
; to wherever its parent was standing.
;
; The child spawn handed it the parent's position (see the CHILD SPAWN PARAMETERS
; note at the top of this section):
;
;   $18/$19 MISC_TIMER_1/2      the ghost's world X when it threw
;   $1A/$1B MISC_PARAM/_HI      the ghost's world Y when it threw
;
; Each frame it flies forwards at speed 1 in its facing direction, takes gravity,
; and then compares its Y against a floor computed on the spot as
;
;   floor = thrownY + $10 + |X - thrownX|
;
; Y grows downwards, so the further the head travels the lower that floor sits and
; the further it can drop before it bounces - which is exactly the staircase it is
; thrown down. On contact it snaps to the floor and gets a fresh $28 of upward Y
; velocity, so the bounces never decay
    ld   c,$01
    call call_00_3350_Entity_SetXVelocity
    call call_00_3442_Entity_MoveXByFacingSpeed
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   e,[hl]
    inc  l
    ld   d,[hl]                                        ; DE = thrownX
    inc  l                                             ; $1A MISC_PARAM
    ldi  a,[hl]
    add  a,$10
    ld   c,a
    ld   a,[hl]
    adc  a,$00
    ld   b,a                                           ; BC = thrownY + $10
    ld   a,l
    xor  a,$16                                         ; $1B -> $0D FACING_FLAGS
    ld   l,a
    bit  5,[hl]                                        ; FACING_LEFT?
    jr   z,.jr_02_5417
    ld   a,l
    xor  a,$03                                         ; $0D -> $0E WORLD_X
    ld   l,a
    ld   a,e
    sub  [hl]
    ld   e,a
    inc  hl
    ld   a,d
    sbc  [hl]
    ld   d,a                                           ; DE = thrownX - X (travelling left)
    inc  hl                                            ; HL = $10 WORLD_Y
    jr   .jr_02_5421
.jr_02_5417:
    ld   a,l
    xor  a,$03                                         ; $0D -> $0E WORLD_X
    ld   l,a
    ldi  a,[hl]
    sub  e
    ld   e,a
    ldi  a,[hl]
    sbc  d
    ld   d,a                                           ; DE = X - thrownX (travelling right)
                                                       ; HL = $10 WORLD_Y
.jr_02_5421:
    ld   a,c
    add  e
    ld   c,a
    ld   a,b
    adc  d
    ld   b,a                                           ; BC = floor = thrownY + $10 + distance
    ldi  a,[hl]
    sub  c
    ld   a,[hl]
    sbc  b                                             ; Y - floor
    ret  c                                             ; still above it, keep falling
    ld   [hl],b
    dec  l
    ld   [hl],c                                        ; land exactly on the sloped floor
    ld   c,$28
    jp   call_00_335a_Entity_SetYVelocity               ; and bounce, at full height again

; ------------------------------------------------------------------
; FLOATING SKULL - a stationary turret on a three-action cycle, each stage
; driven purely by its own animation running out:
;
;   $00 Idle     4 slow frames (data_02_76d0, tick $4b); on the wrap it turns to
;                face Gex, which is the only aiming it does
;   $01 Spit     1 frame; on the wrap it spawns the projectile
;   $02 Recover  1 frame; on the wrap it returns to Idle
;
; The skull itself never moves and the timing is fixed, so the whole enemy is
; three "wait for the animation, then do one thing" states
; ------------------------------------------------------------------

call_02_5434_EntityAction_FloatingSkull_Idle:
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5440_EntityAction_FloatingSkull_Spit:
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,SFX_MULTI_PROJECTILE
    call call_00_112f_QueueSFX
    ld   c,SPAWN_CHILD_ENTITY_FLOATING_SKULL_PROJECTILE
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   a,$02
    jp   call_02_7102_Entity_SetAction

call_02_545b_EntityAction_FloatingSkull_Recover:
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5464_EntityAction_FloatingSkullProjectile_Init:
; Action $00, one frame long. The skull's projectile is not a sprite entity at
; all - it is a particle emitter. This arms PARTICLE_PATTERN_MULTI_PROJECTILE in
; the slot's particle buffer and immediately hands over to the update action
    ld   c,PARTICLE_PATTERN_MULTI_PROJECTILE
    call call_00_3a23_Entity_StartParticleEffect
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_546e_EntityAction_FloatingSkullProjectile_Fly:
; Action $01. Step the particles; when the last one dies (Z) the entity has
; nothing left to draw and frees its slot. Otherwise it builds its own OAM
; records from the particle buffer rather than going through the normal
; frame-list path
    call call_00_3b8d_Entity_TickParticles
    jp   z,call_00_3931_Entity_DeactivateSelf
    FARCALL call_03_6549_Particles_BuildSpriteList_SkullFire
    ret

call_02_5480_EntityAction_Zombie_Walk:
; Actions $00 AND $01 - the action table points both at this routine, and they
; differ only in their animation: $00 is the zombie with its head on
; (data_02_76e5), $01 the same walk cycle without it (data_02_76ee). The routine
; tells them apart by reading ACTION_ID back out of the instance.
;
; MISC_FLAGS bit 0 is the "Gex just hit me" flag, set by
; .jr_03_4d9a_CollisionHandler_Zombie in bank 3 along with a $3C stagger timer.
; When it is set the zombie drops its head - but only the first time, because
; only action $00 spawns the child.
;
; The `ld [hl], $02` into MISC_PARAM is the zombie's hit counter, which the same
; collision handler decrements. Since this routine rewrites it to 2 on EVERY
; frame it can never actually reach zero, so hitting the zombie itself only ever
; staggers it; the way to finish it off is to destroy the head it dropped, which
; is what .jr_03_4df4_CollisionHandler_ZombieHead does on the zombie's behalf
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   [hl],$02                                      ; hit counter, reset every frame
    inc  l
    inc  l                                             ; $1C X_VELOCITY
    ld   [hl],$01                                      ; shuffle speed
    ld   a,l
    xor  a,$0B                                         ; $1C -> $17 MISC_FLAGS
    ld   l,a
    bit  0,[hl]                                        ; hit this frame?
    jp   z,call_00_3364_Entity_ApproachPlayerXWithBounds ; no - just keep shuffling
    ld   a,l
    xor  a,$16                                         ; $17 -> $01 ACTION_ID
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$00                                         ; still the headed variant?
    jr   nz,.jr_02_54AF
    ld   c,SPAWN_CHILD_ENTITY_ZOMBIE_HEAD
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity  ; pop the head off
.jr_02_54AF:
    ld   a,$02
    jp   call_02_7102_Entity_SetAction

call_02_54b4_EntityAction_Zombie_Stagger:
; Action $02. Stand still for the $3C frames the collision handler loaded into
; MISC_TIMER_1, then clear the hit flag and resume walking as action $01 - the
; headless variant, whichever action it was hit in
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [hl]
    ret  nz
    dec  l                                             ; $17 MISC_FLAGS
    res  0,[hl]                                        ; clear the hit flag
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

; ------------------------------------------------------------------
; ZOMBIE HEAD - the head the zombie above drops when it is hit. It falls, bounces
; twice with decreasing height, then settles and watches Gex.
;
; The floor it bounces on is the one in MISC_PARAM, which for a child entity is
; the PARENT's world Y at the moment of the spawn (see the note at the top of this
; section) - so the head lands level with the zombie's feet no matter where it
; happened to be spawned above them
; ------------------------------------------------------------------

call_02_54c6_EntityAction_ZombieHead_Launch:
; Action $00, one frame. Pop upwards, load the bounce counter, and clear the
; inherited facing so the head starts drawn unflipped
    ld   c,$28
    call call_00_335a_Entity_SetYVelocity
    ld   c,$03
    call call_00_3802_Entity_SetMiscTimer              ; 3 bounces remaining
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],$00
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_54df_EntityAction_ZombieHead_Bounce:
; Action $01. Fall until it reaches the stored floor; each landing spends one of
; the three bounces and re-launches at the height that bounce number indexes out
; of the table below - $14, then $0a, then nothing, so the hops visibly die out.
; When the counter reaches 0 the head is done moving
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3137_Entity_ClampYToStoredFloor
    ret  c                                             ; carry = still in the air
    call call_00_3817_Entity_DecrementMiscTimer        ; HL = $18, A = bounces left
    ld   a,$02
    jp   z,call_02_7102_Entity_SetAction               ; out of bounces - settle
    ld   l,[hl]                                        ; index the table by bounces left
    ld   h,$00
    ld   de,.data_02_54f9
    add  hl,de
    ld   c,[hl]
    jp   call_00_335a_Entity_SetYVelocity
.data_02_54f9:
; Bounce height by remaining-bounce count: [0] is never used as a launch, [1] is
; the final little hop, [2] the first one
    db   $00, $0a, $14

call_02_54fc_EntityAction_ZombieHead_Grounded:
; Action $02. Sits where it landed and keeps turning to face Gex. Still lethal to
; touch, and still the thing that has to be destroyed to finish off the zombie
    jp   call_00_36bd_Entity_FaceTowardsPlayer

; ------------------------------------------------------------------
; FALLING AXE - a four-state loop on a fixed global cadence: drop $24 units in
; 2px steps, land, then crank back up 1px at a time.
;
; MISC_TIMER_1 is the distance counter and is shared between the fall and the
; retract: the fall counts it up to $24, the retract counts it back down to 0,
; which is why the axe always returns to exactly where it started
; ------------------------------------------------------------------

call_02_54ff_EntityAction_FallingAxe_WaitForCue:
; Action $00. Hangs frozen (data_02_7939, tick $ff) until the low 7 bits of the
; global frame counter match MISC_TIMER_2. That byte is a spawn parameter, so
; each axe in a room gets its own phase within the shared 128-frame cycle and
; they fall in sequence rather than together
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$7F                                         ; 128-frame cycle
    cp   [hl]                                          ; my phase within it
    ld   a,$01
    jp   z,call_02_7102_Entity_SetAction
    ret

call_02_5513_EntityAction_FallingAxe_Fall:
; Action $01. 2px a frame for $24 units - 18 frames, 36 pixels
    ld   bc,$0002
    call call_00_37d8_Entity_MoveY
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    inc  [hl]
    inc  [hl]                                          ; distance travelled += 2
    ld   a,[hl]
    cp   a,$24
    ret  nz
    ld   a,$02
    jp   call_02_7102_Entity_SetAction

call_02_552c_EntityAction_FallingAxe_Impact:
; Action $02. The one-frame strike pose, held for $1e ticks (data_02_793f); on the
; wrap it starts winding back up
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$03
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5535_EntityAction_FallingAxe_Retract:
; Action $03. 1px a frame, counting the same MISC_TIMER_1 back down - so the climb
; takes $24 frames, twice as long as the drop, and ends exactly at the start
; height before rejoining the wait
    ld   bc,$FFFF
    call call_00_37d8_Entity_MoveY
    call call_00_3817_Entity_DecrementMiscTimer
    ld   a,$00
    jp   z,call_02_7102_Entity_SetAction
    ret

; ------------------------------------------------------------------
; LANTERN - two actions that are purely a costume change driven by
; wD757_LanternLitFlag. Both do the same swaying movement; they differ only in
; which sprite they show and in which direction they watch the flag.
;
; The flag is not owned by the lantern's action code at all - it is written by
; .jr_03_4d8c_CollisionHandler_Lantern in bank 3, which raises it every frame the
; lantern is processed and drops it on the frame Gex is overlapping it. So it
; means "a lantern exists and Gex is not on it", and the Scream TV ghost reads
; the same byte to decide whether it is chasing and whether it can be hurt
; ------------------------------------------------------------------

call_02_5544_EntityAction_Lantern_Lit:
; Action $00, sprite $50. The normal state; drops to Doused when the flag clears
    call call_02_555e_Lantern_Sway
    ld   a,[wD757_LanternLitFlag]
    and  a
    ret  nz
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5551_EntityAction_Lantern_Doused:
; Action $01, sprite $58. Shown while Gex is at the lantern; back to Lit as soon
; as he leaves
    call call_02_555e_Lantern_Sway
    ld   a,[wD757_LanternLitFlag]
    and  a
    ret  z
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_555e_Lantern_Sway:
; Shared by both lantern actions. MISC_TIMER_1 is a free-running counter, and the
; low four bits of it are read as a little state machine rather than as a number:
;
;   bit 0   only act on every other frame, halving the speed
;   bit 2   only act on the second half of each group of four - so the lantern is
;           still for 4 counts, then moves for 4
;   bit 3   which way to move during those 4 counts
;
; The result is a 16-count cycle of "still, down 2px, still, up 2px": the lantern
; hangs and swings. Nothing else in the entity ever writes MISC_TIMER_1
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    inc  [hl]
    ld   a,[hl]
    and  a,$01
    ret  nz                                            ; every other frame only
    bit  2,[hl]
    ret  z                                             ; first half of the cycle: hang still
    ld   bc,$0001
    bit  3,[hl]
    jp   z,call_00_37d8_Entity_MoveY                   ; swing down
    ld   bc,$FFFF
    jp   call_00_37d8_Entity_MoveY                     ; swing back up

call_02_557c_EntityAction_Bat_Update:
; One action. Same patrol-and-face-Gex helper as Frankie, but the bat forces its
; own speed to 1 every frame instead of taking it from the spawn record. There is
; no vertical movement at all - the flapping is entirely in the animation
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    ld   [hl],$01
    jp   call_00_3364_Entity_ApproachPlayerXWithBounds

call_02_5589_EntityAction_ScreamTVOrangeMovingPlatform_Update:
; One action: the PATROLLING PLATFORM PROLOGUE above, then move and patrol. No
; switch gate, unlike call_02_5348 - this one runs from the moment it spawns.
; Byte for byte the same routine as call_02_5628_EntityAction_ClimbWallSunEnemy,
; which the level data configures for vertical travel instead
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5595
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_5595:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_559b_EntityAction_ScreamTVDoorOpening_Idle:
; Action $00. The closed door: a do-nothing action it sits in until something
; outside calls Entity_SetAction $01 on it
    ret

call_02_559c_EntityAction_ScreamTVDoorOpening_Open:
; Action $01. Play the opening animation once and free the slot on the last frame
; - the open doorway itself is background tiles, not this entity
    call call_00_3843_Entity_CheckAnimationEnded
    call nz,call_00_3931_Entity_DeactivateSelf
    ret

; ------------------------------------------------------------------
; SCREAM TV GHOST - four actions built around wD757_LanternLitFlag, the byte the
; lantern's collision handler raises every frame it is processed and drops on the
; frame Gex is standing at it:
;
;   $00 VanishAndRelocate  fade out, then teleport next to the lantern
;   $01 Reappear           fade back in
;   $02 Dormant            lantern flag clear - hold still, and vulnerable
;   $03 Chase              lantern flag set - walk Gex down, and untouchable
;
; The pairing with .jr_03_4dd4_CollisionHandler_Ghost in bank 3 is deliberate:
; that handler only lets an attack register while the flag is clear, which is the
; same condition that puts the ghost in Dormant. You cannot fight it while it is
; chasing you - you have to reach the lantern first
; ------------------------------------------------------------------

call_02_55a3_EntityAction_Ghost_VanishAndRelocate:
; Action $00. Waits out the fade animation, then hunts the entity slots for an
; ENTITY_SCREAM_TV_LANTERN ($15) and teleports to it: $30 pixels to one side
; depending on which way Gex is facing, and $38 below it. If no lantern is loaded
; there is nowhere to go, so the ghost frees its own slot instead
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   h,$d2
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_55AB:
    ld   l,a
    ld   a,[hl]                                        ; ENTITY_FIELD_ENTITY_ID of that slot
    cp   a,$15                                         ; ENTITY_SCREAM_TV_LANTERN
    jr   z,.jr_02_55B9
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_55AB                                ; wraps to 0 after the last slot
    jp   call_00_3910_Entity_ClearSlot                 ; no lantern in the room - despawn
.jr_02_55B9:
; HL = the lantern's WORLD_X, DE = our own. Copy X (biased) and Y (+$38) across.
    ld   a,l
    or   a,$0E
    ld   l,a                                           ; lantern $0E WORLD_X
    ld   d,h
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   e,a                                           ; our $0E WORLD_X
    ld   bc,$0030                                      ; appear to the lantern's right
    ld   a,[wD20D_Player_FacingFlags]
    bit  5,a                                           ; unless Gex is facing left
    jr   z,.jr_02_55D1
    ld   bc,$FFD0                                      ; then appear to its left
.jr_02_55D1:
    ldi  a,[hl]
    add  c
    ld   [de],a
    inc  e
    ldi  a,[hl]
    adc  b
    ld   [de],a
    inc  e                                             ; X = lantern X +/- $30
    ldi  a,[hl]
    add  a,$38
    ld   [de],a
    inc  e
    ldi  a,[hl]
    adc  a,$00
    ld   [de],a
    inc  e                                             ; Y = lantern Y + $38
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_55e8_EntityAction_Ghost_Reappear:
; Action $01. Plays the fade-in and drops into Dormant; the relocation has already
; happened, so this action exists only to keep the ghost intangible while it is
; still materialising
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   a,$02
    jp   call_02_7102_Entity_SetAction

call_02_55f1_EntityAction_Ghost_Dormant:
; Action $02. Holds still while the lantern flag is clear - which is exactly when
; .jr_03_4dd4_CollisionHandler_Ghost will let an attack land. As soon as the flag
; comes back it zeroes its speed and starts chasing.
;
; QUIRK: the "I was hit" bit this polls is NOT in this entity's own MISC_FLAGS.
; HL is not set up before the read - an action function is entered through
; call_00_10bd_JumpHL, so on entry HL is the address of the action function
; itself, here $55F1. `or l` with any slot base leaves $F1 unchanged, so the
; `bit 0, [hl]` below always reads $D2F1 - byte $11 of slot 7, the high half of
; that slot's world Y.
;
; The collision handler that is supposed to raise the bit has the mirror image of
; the same bug: it still has L = $57 left over from `ld hl, wD757`, so it writes
; to slot (own slot | 2), field $17. The two only agree when the ghost is in slot
; 2, 3, 6 or 7, and even then the read address is wrong. Both are faithful to the
; ROM - see 02:55F1 and 03:4DE5
    ld   a,[wD757_LanternLitFlag]
    and  a
    jr   nz,.jr_02_5608
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   l                                             ; L is the low byte of $55F1, not a field offset
    ld   l,a
    bit  0,[hl]                                        ; ends up reading $D2F1
    ret  z
    res  0,[hl]
    ld   a,$00
    jp   call_02_7102_Entity_SetAction
.jr_02_5608:
    ld   c,$00
    call call_00_3350_Entity_SetXVelocity               ; start the chase from a standstill
    ld   a,$03
    jp   call_02_7102_Entity_SetAction

call_02_5612_EntityAction_Ghost_Chase:
; Action $03. Faces Gex and accelerates towards him, using the momentum path
; rather than a fixed step - MISC_PARAM_HI is the top speed it ramps up to.
;
; Two things send it back to action $00 and its lantern: Gex reaching the lantern
; (the flag clearing), or the ghost drifting outside its own patrol span
    ld   a,[wD757_LanternLitFlag]
    and  a
    jr   z,.jr_02_5623                                 ; Gex is at the lantern - give up
    call call_00_3531_Entity_IsXOutsideBounds
    jr   c,.jr_02_5623                                 ; chased past its own bounds
    call call_00_36bd_Entity_FaceTowardsPlayer
    jp   call_00_3251_Entity_UpdateFacingMomentumAndMoveX
.jr_02_5623:
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_5628_EntityAction_ClimbWallSunEnemy_Update:
; One action, and instruction for instruction the same routine as
; call_02_5589_EntityAction_ScreamTVOrangeMovingPlatform_Update: read the patrol
; config out of the spawn record on the first frame, then move and patrol. What
; makes this one climb a wall rather than slide along a floor is the config byte,
; not the code
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5634
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5634:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

; ------------------------------------------------------------------
; SCREAM TV VANISHING PLATFORM - a three-action loop that blinks out from under
; Gex and comes back a second later:
;
;   $00 WaitForCue  solid, waiting for its slot in the global cycle
;   $01 BlinkOut    $40 frames of flashing, faster and faster, then it goes
;   $02 Gone        $3c frames with no sprite and no collision width
;
; The flashing is not a plain alternation - it is a dither read out of two small
; tables, so the platform is fully solid at first and then flickers at 1/2, 1/4
; and 1/8 duty before disappearing outright. That is the warning
; ------------------------------------------------------------------

call_02_563a_EntityAction_ScreamTVVanishingPlatform_WaitForCue:
; Action $00. Fires when the global frame counter matches MISC_PARAM_HI, a spawn
; parameter, so a row of these blink out one after another rather than all at
; once. Loads the $40-frame blink timer on the way through
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM_HI
    ld   a,[wD73B_VBlankFrameCounter]
    cp   [hl]                                          ; my phase in the 256-frame cycle
    ret  nz
    ld   a,l
    xor  a,$03                                         ; $1B -> $18 MISC_TIMER_1
    ld   l,a
    ld   [hl],$40                                      ; blink for $40 frames
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5652_EntityAction_ScreamTVVanishingPlatform_BlinkOut:
; Action $01. Counts MISC_TIMER_1 down from $40 and derives SPRITE_FLAG_INVISIBLE
; from it each frame, by splitting the counter into a coarse and a fine half:
;
;   timer >> 3   picks a duty pattern from .data_02_5691
;   timer & 7    picks which bit of that pattern to test in .data_02_5699
;
; $ff is every frame visible, $55 every other, $11 one in four, $01 one in eight
; and $00 none - so as the counter falls the platform flickers harder and harder.
; The bit is cleared unconditionally first, so "visible" is the default and the
; table only ever adds blanks
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$12                                         ; $18 -> $0A SPRITE_FLAGS
    ld   l,a
    res  SPRITE_FLAG_INVISIBLE_BIT,[hl]                ; visible unless the pattern says otherwise
    ld   a,c
    and  a
    jr   z,.jr_02_5687                                 ; timer ran out
    cp   a,$40
    ret  nc                                            ; guards the >> 3 table index
    push hl
    srl  a
    srl  a
    srl  a                                             ; timer >> 3 = which duty pattern
    ld   e,a
    ld   d,$00
    ld   hl,.data_02_5691
    add  hl,de
    ld   b,[hl]
    ld   a,c
    and  a,$07                                         ; timer & 7 = which bit of it
    ld   e,a
    ld   hl,.data_02_5699
    add  hl,de
    ld   a,[hl]
    pop  hl
    and  b
    ret  nz                                            ; bit set - draw this frame
    set  SPRITE_FLAG_INVISIBLE_BIT,[hl]                ; bit clear - blank this frame
    ret
.jr_02_5687:
    ld   c,$00
    call call_00_382f_Entity_SetWidth                  ; width 0 = nothing left to stand on
    ld   a,$02
    jp   call_02_7102_Entity_SetAction
.data_02_5691:
; Duty pattern by (timer >> 3), so read right to left as the timer counts down:
; solid, then 1/2, then 1/4, then 1/8, then gone
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_5699:
; Bit selector by (timer & 7)
    db   $01, $02, $04, $08, $10, $20, $40, $80

call_02_56a1_EntityAction_ScreamTVVanishingPlatform_Gone:
; Action $02. data_02_7981 draws nothing (SPRITE_FLAG_INVISIBLE) and holds for $3c
; ticks; when that wraps, the collision width goes back to $10 and the platform is
; solid again
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,$10
    call call_00_382f_Entity_SetWidth
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_56af_EntityAction_MonaLisaElevator_Update:
; One action, and the most gated platform in the level: it needs BOTH block patch
; slot 0 to have been triggered AND Gex to step on before it will run.
;
; The direction latch is the unusual part. MISC_FLAGS arrives from the spawn
; record through the PATROLLING PLATFORM PROLOGUE, and on the frame Gex first
; boards, bits 5 and 4 of it are rotated up into bits 7 and 6 - the direction bits
; Entity_PlatformPatrol_WithBoundsAndFlip actually reads. So bits 5/4 are a
; "which way do I set off" seed that only takes effect once, and bit 0 is the
; latch that stops it happening twice
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_56BB
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_56BB:
    ld   a,[wD78B_BlockPatch_SlotTable]
    and  a
    ret  z
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  0,[hl]                                        ; already started?
    jr   nz,.jr_02_56D9
    bit  0,b                                           ; no - wait for Gex to board
    ret  z
    set  0,[hl]                                        ; latch: only do this once
    ld   a,[hl]
    and  a,$3F
    ld   c,a
    rlca
    rlca
    and  a,$C0                                         ; bits 5,4 -> bits 7,6
    or   c
    ld   [hl],a                                        ; seed the patrol direction
.jr_02_56D9:
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

; ==================================================================
; TOON TV
;
; Entity ids $1D (ENTITY_TOON_TV_HARD_HEAD_AREA_HAZARD) through $31
; (ENTITY_TOON_TV_ROCKET). Action tables data_02_4ea7 .. data_02_4f4b.
;
; The HL WALKING and CHILD SPAWN PARAMETERS conventions described at the head of
; the SCREAM TV section apply here too. Three more patterns are specific to this
; set:
;
; PROXIMITY TRIGGERS. Most of Toon TV reacts to how close Gex is horizontally
; rather than to being touched. call_00_3859_Entity_CheckPlayerXProximity returns
; CARRY SET when the player is within +/- C pixels, and the enemies here use two
; different radii for entry and exit so they do not chatter on the boundary - see
; the bumblebee, which charges at $20 and gives up at $40.
;
; THE FRAME COUNTER AS A CLOCK AND AS A DIE. wD73B_VBlankFrameCounter is used
; both ways: masked and compared it is a shared phase clock (the hunter fires
; when the low 7 bits hit zero), while the low bits of the PLAYER's X position
; stand in for a random number where one is needed (the hard head hazard picks
; both its sprite and its cooldown that way).
;
; THE BLINK-OUT DITHER. call_02_576e_EntityAction_HardHeadAreaHazard_Drop and
; call_02_5aea_EntityAction_ToonTVVanishingBlock_BlinkOut each carry their own
; private copy of the two dither tables that
; call_02_5652_EntityAction_ScreamTVVanishingPlatform_BlinkOut uses. All three
; pairs are byte-for-byte identical - the routine was copied rather than shared
; ==================================================================

; ------------------------------------------------------------------
; HARD HEAD AREA HAZARD - the anvil that drops on Gex from off the top of the
; screen. Three actions, but only two routines: $01 and $02 are the same code
; with different sprites, picked at random when the drop starts.
;
; Action $00 is the aiming state and is the interesting one. The hazard parks
; itself just above the visible top of the screen every frame and tracks a
; PREDICTED landing spot rather than where Gex is now - the lead comes from
; .data_02_575e, indexed by how fast he is running and which way he faces
; ------------------------------------------------------------------

call_02_56dc_EntityAction_HardHeadAreaHazard_Aim:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   A, [wD6EF_BgMap_ScrollY]
    sub  A, $18
    ld   [HL+], A
    ld   A, [wD6EF_BgMap_ScrollY+1]
    sbc  A, $00
    ld   [HL], A                                       ; hover $18 above the top of the view
    ld   A, [wD75D_PlayerXSpeedPrev]
    add  A, A                                          ; speed * 2 ...
    ld   HL, wD20D_Player_FacingFlags
    bit  5, [HL]
    jr   Z, .jr_02_56fc
    inc  A                                             ; ... + 1 if facing left
.jr_02_56fc:
    ld   L, A
    ld   H, $00
    add  HL, HL                                        ; word-sized entries
    ld   DE, .data_02_575e
    add  HL, DE
    ld   A, [wD20E_Player_XPositionLo]
    add  A, [HL]
    ld   C, A
    inc  HL
    ld   A, [wD20F_Player_XPositionHi]
    adc  A, [HL]
    ld   B, A                                          ; BC = predicted landing X
    ld   A, [wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  A, $1c
    ld   L, A
    ld   H, $00
    ld   DE, wD309_EntityBoundingBoxXMax
    add  HL, DE
    ld   D, [HL]
    dec  D                                             ; D = XMax - 1
    inc  HL
    ld   E, [HL]
    inc  E                                             ; E = XMin + 1
    ld   L, C
    ld   H, B
    add  HL, HL
    add  HL, HL
    add  HL, HL                                        ; predicted X -> block coordinate
    ld   A, H
    cp   A, E
    ret  C                                             ; landing spot left of my span
    ld   A, D
    cp   A, H
    ret  C                                             ; landing spot right of my span
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   [HL], C
    inc  L
    ld   [HL], B                                       ; slide over the landing spot
    ld   A, L
    xor  A, $17                                        ; $0F -> $18 MISC_TIMER_1
    ld   L, A
    ld   A, [HL]
    and  A, A
    jr   Z, .jr_02_5743
    dec  [HL]
    ret  NZ                                            ; cooldown between drops
.jr_02_5743:
    dec  L                                             ; $17 MISC_FLAGS
    ld   [HL], $00                                     ; clear the landed flag
    ld   A, [wD20E_Player_XPositionLo]
    swap A
    and  A, $03                                        ; bits 4-5 of Gex's X as a 2-bit die
    ld   L, A
    ld   H, $00
    ld   DE, .data_02_576a
    add  HL, DE
    ld   A, [HL]
    call call_02_7102_Entity_SetAction                 ; action $01 or $02
    ld   C, SFX_HARD_HEAD_AREA_HAZARD
    call call_00_112f_QueueSFX
    ret
.data_02_575e:
; Signed 16-bit aim lead, indexed by (|player X speed| * 2 + facing left). So the
; hazard drops on Gex's feet when he is standing still, 36 pixels ahead of him at
; speed 1 and 72 ahead at speed 2, in whichever direction he is running
    db   $00, $00, $00, $00, $24, $00, $dc, $ff
    db   $48, $00, $b8, $ff
.data_02_576a:
; Which of the two drop actions to use. Two entries each, so it is a coin flip
    db   $01, $02, $01, $02

call_02_576e_EntityAction_HardHeadAreaHazard_Drop:
; Actions $01 AND $02 - the same routine behind two sprites (data_02_7993 and
; data_02_7999). MISC_FLAGS bit 0 splits it in half: clear means still falling,
; set means landed and lingering.
;
; On landing it loads $80 into MISC_TIMER_1 and then blinks out over those 128
; frames using the same duty-cycle dither as the vanishing platforms. When the
; timer expires it teleports back above the screen, picks a fresh $20-$3F cooldown
; out of the player's low X bits, and returns to aiming
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0, [HL]
    jr   NZ, .jr_02_5794                               ; already landed
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  C                                             ; still falling
    ld   C, SFX_FALLING_HAZARD
    call call_00_112f_QueueSFX
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0, [HL]                        ; landed
    inc  L                                             ; $18 MISC_TIMER_1
    ld   [HL], $80                                     ; 128 frames lying there
    ret
.jr_02_5794:
; Landed. Count down and fade out with the same dither the vanishing platforms use
    inc  L                                             ; $18 MISC_TIMER_1
    dec  [HL]
    ld   C, [HL]
    ld   A, L
    xor  A, $12                                        ; $18 -> $0A SPRITE_FLAGS
    ld   L, A
    res  SPRITE_FLAG_INVISIBLE_BIT, [HL]
    ld   A, C
    and  A, A
    jr   Z, .jr_02_57c2                                ; gone
    cp   A, $40
    ret  NC                                            ; first half of the linger: solid
    push HL
    srl  A
    srl  A
    srl  A                                             ; timer >> 3 = duty pattern
    ld   E, A
    ld   D, $00
    ld   HL, .data_02_57e3
    add  HL, DE
    ld   B, [HL]
    ld   A, C
    and  A, $07                                        ; timer & 7 = which bit of it
    ld   E, A
    ld   HL, .data_02_57eb
    add  HL, DE
    ld   A, [HL]
    pop  HL
    and  A, B
    ret  NZ                                            ; bit set - draw this frame
    set  SPRITE_FLAG_INVISIBLE_BIT, [HL]
    ret
.jr_02_57c2:
; Faded out. Go back above the screen and arm a fresh cooldown
    ld   A, L
    xor  A, $1a                                        ; $0A -> $10 WORLD_Y
    ld   L, A
    ld   A, [wD6EF_BgMap_ScrollY]
    sub  A, $18
    ld   [HL+], A
    ld   A, [wD6EF_BgMap_ScrollY+1]
    sbc  A, $00
    ld   [HL], A
    ld   A, L
    xor  A, $09                                        ; $11 -> $18 MISC_TIMER_1
    ld   L, A
    ld   A, [wD20E_Player_XPositionLo]
    and  A, $1f
    or   A, $20                                        ; cooldown $20-$3F, pseudo-random
    ld   [HL], A
    ld   A, $00
    jp   call_02_7102_Entity_SetAction
.data_02_57e3:
; Duty pattern by (timer >> 3) - a private copy of .data_02_5691
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_57eb:
; Bit selector by (timer & 7) - a private copy of .data_02_5699
    db   $01, $02, $04, $08, $10, $20, $40, $80

; ------------------------------------------------------------------
; BEAR TRAPS - two entities that are the same idea at different scales. Both sit
; on the floor, wait, then jump up snapping; the moving one also drifts sideways
; while it is in the air
; ------------------------------------------------------------------

call_02_57f3_EntityAction_StationaryBearTrap_Wait:
; Action $00. Sit closed until MISC_TIMER_1 runs out, then reload it with $FF and
; jump. The first wait is however long the spawn record put in the timer, every
; later one is a fixed 255 frames
    call call_00_3817_Entity_DecrementMiscTimer
    ret  nz
    ld   [hl],$FF                                      ; reload for the next cycle
    ld   c,$24
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5803_EntityAction_StationaryBearTrap_Leap:
; Action $01. In the air, snapping (data_02_79ac). The floor is taken 8 units
; BELOW the bounding box, so the trap settles slightly into the ground rather than
; resting on top of it
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    ld   bc,$0008
    call call_00_316e_Entity_ClampYToMaxYBound_Offset
    ld   a,$00
    jp   nc,call_02_7102_Entity_SetAction              ; landed
    ret

call_02_5812_EntityAction_MovingBearTrap_Crouch:
; Action $00. Closed on the ground. data_02_79b3 is a single frame held for $32
; ticks, so "the animation ended" is really just a 50-frame timer, and the trap
; jumps when it expires
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_581C
    ld   c,$10
    call call_00_3350_Entity_SetXVelocity              ; drift speed for the next hop
.jr_02_581C:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,$24
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5830_EntityAction_MovingBearTrap_Hop:
; Action $01. Airborne and snapping. Carry from the floor check means still in the
; air, and the whole horizontal movement happens on those frames - the trap only
; travels while it is off the ground. On touchdown it keeps a small $09 upward
; velocity, so the crouch action starts with a little bounce rather than a thud
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    jp   c,call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   c,$09
    call call_00_335a_Entity_SetYVelocity
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_5843_EntityAction_Bumblebee_Cruise:
; Action $00. Drifts along its patrol span at speed $08. Gex coming within $20
; pixels horizontally starts a charge - note it faces him at that moment and then
; never re-aims, so the charge is committed and can be dodged
    ld   C, $08
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   C, $20
    call call_00_3859_Entity_CheckPlayerXProximity
    ret  NC                                            ; carry = within range
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   C, SFX_BUMBLEBEE
    call call_00_112f_QueueSFX
    ld   A, $01
    jp   call_02_7102_Entity_SetAction

call_02_585e_EntityAction_Bumblebee_Charge:
; Action $01. Four times the speed, and it keeps charging until Gex is $40 away -
; twice the radius that started it. The gap between the two radii is what stops
; the bee flipping between the two actions every frame at the boundary
    ld   c,$20
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   c,$40
    call call_00_3859_Entity_CheckPlayerXProximity
    ret  c                                             ; still within $40 - keep going
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_5871_EntityAction_BowlingBall_Update:
; One action: the ball that bounces down a flight of steps and then reappears at
; the top to do it again.
;
; MISC_TIMER_1 is not a timer here - it is the step counter, and it is read in two
; halves:
;
;   bit 7      set = also roll horizontally, clear = bounce on the spot. It comes
;              from the spawn record and is preserved across every reset
;   bits 0-6   how many steps are left, and an index into .data_02_58c1 for the
;              height of the floor this bounce lands on
;
; Each bounce decrements the counter, which moves the floor one entry further down
; the table. When the count rolls past zero the ball teleports to world Y $0A40
; and rearms with 8 steps
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    push hl
    bit  7,[hl]                                        ; rolling variant?
    call nz,call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    pop  hl
    ld   l,[hl]
    res  7,l                                           ; step index
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_58c1
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]                                        ; BC = this step's floor offset
    call call_00_316e_Entity_ClampYToMaxYBound_Offset
    ret  c                                             ; still above it
    ld   c,SFX_FALLING_HAZARD
    call call_00_112f_QueueSFX
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [hl]                                          ; one step used
    ld   a,[hl]
    and  a,$7F
    cp   a,$7F                                         ; wrapped past zero?
    ld   c,$24
    jp   nz,call_00_335a_Entity_SetYVelocity           ; no - bounce to the next step
    inc  [hl]                                          ; undo the wrap
    ld   c,[hl]
    ld   a,l
    xor  a,$08                                         ; $18 -> $10 WORLD_Y
    ld   l,a
    ld   de,$0A40
    ld   [hl],e
    inc  l
    ld   [hl],d                                        ; back to the top of the flight
    ld   a,c
    and  a,$80                                         ; keep the rolling bit
    add  a,$08                                         ; 8 steps again
    ld   c,a
    jp   call_00_3802_Entity_SetMiscTimer
.data_02_58c1:
; Signed 16-bit floor offset per remaining-step count. Read from index 8 downwards
; as the ball descends: -$1C0, -$180, -$140, -$100, -$C0, -$80, -$40, 0, +$80 -
; one 64-pixel step per bounce
    db   $80, $00, $00, $00, $c0
    db   $ff, $80, $ff, $40, $ff, $00, $ff, $c0
    db   $fe, $80, $fe, $40, $fe

; ------------------------------------------------------------------
; CACTUS - a three-stage hopper. Unlike the pumpkin, which hops on a fixed cycle,
; the cactus only wakes up when Gex is within $40 pixels, and then wiggles between
; one and four times before it commits
; ------------------------------------------------------------------

call_02_58d3_EntityAction_Cactus_Dormant:
; Action $00. Still, until Gex is near. The wiggle count comes off the low two bits
; of the gameplay frame counter, so it varies from approach to approach
    ld   C, $40
    call call_00_3859_Entity_CheckPlayerXProximity
    ret  NC
    ld   A, [wD73C_GameplayFrameCounter]
    and  A, $03
    inc  A                                             ; 1 to 4 wiggles
    ld   C, A
    call call_00_3802_Entity_SetMiscTimer
    ld   A, $01
    jp   call_02_7102_Entity_SetAction

call_02_58e8_EntityAction_Cactus_WindUp:
; Action $01. One wiggle per pass of the two-frame animation; the counter runs out
; and it launches
    call call_00_3843_Entity_CheckAnimationEnded
    ret  Z
    call call_00_3817_Entity_DecrementMiscTimer
    ret  NZ
    ld   C, $34
    call call_00_335a_Entity_SetYVelocity
    ld   A, $02
    jp   call_02_7102_Entity_SetAction

call_02_58fa_EntityAction_Cactus_Leap:
; Action $02. Straight up and back down; on landing it drops all the way back to
; dormant and has to be approached again
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  C
    ld   C, SFX_ENEMY_BOUNCE
    call call_00_112f_QueueSFX
    ld   A, $00
    jp   call_02_7102_Entity_SetAction

call_02_590b_EntityAction_Domino_Update:
; One action, and the simplest bouncer in the game: fall, and on every touchdown
; set a fixed $40 upward velocity again. There is no state and no trigger - it
; bounces at a constant height forever
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  c
    ld   c,SFX_FALLING_HAZARD
    call call_00_112f_QueueSFX
    ld   c,$40
    jp   call_00_335a_Entity_SetYVelocity

call_02_591c_EntityAction_Shark_Update:
; One action. Patrols its span, but at four times the speed while Gex is within
; $30 pixels. Unlike the bumblebee there is no second radius and no separate
; action - the speed target simply changes under it, so it accelerates and slows
; smoothly through Entity_NudgeXVelocityTowardC
    ld   C, $30
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   C, $20                                        ; near: fast
    jr   C, .jr_02_5927
    ld   C, $08                                        ; far: slow
.jr_02_5927:
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

call_02_592d_EntityAction_Flower_Update:
; All three of the flower's actions point here - the action id is not a state
; machine at all, it is just "how open am I", recomputed from Gex's distance every
; single frame and written back with Entity_SetAction:
;
;   $00  more than $30 away   closed   (data_02_79f6)
;   $01  within $30           opening  (data_02_79fc)
;   $02  within $20           open     (data_02_7a02)
;
; Re-setting the action every frame would normally restart the animation, but all
; three data blocks are a single frozen frame so nothing is disturbed.
;
; Only the fully open state attacks, and only when MISC_TIMER_1 - decremented once
; a frame here rather than by the engine - has run down to zero
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   C, $20
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   A, $02
    jr   C, .jr_02_5944
    ld   C, $30
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   A, $01
    jr   C, .jr_02_5944
    ld   A, $00
.jr_02_5944:
    push AF                                            ; keep the chosen action id
    call call_02_7102_Entity_SetAction
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    inc  [HL]                                          ; test for zero without
    dec  [HL]                                          ; disturbing the value
    jr   Z, .jr_02_5955
    dec  [HL]                                          ; attack cooldown
.jr_02_5955:
    pop  AF
    cp   A, $02
    ret  NZ                                            ; only the open flower attacks
    ld   A, [HL]
    and  A, A
    ret  NZ                                            ; still cooling down
    ld   [HL], $3c                                     ; one hammer a second
    ld   C, SPAWN_CHILD_ENTITY_FLOWER_HAMMER
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ret

; ------------------------------------------------------------------
; FLOWER HAMMER - the mallet the flower above drops. Spawned $0B pixels to the
; flower's left and $04 above it, and it lives exactly one fall
; ------------------------------------------------------------------

call_02_596c_EntityAction_FlowerHammer_Hang:
; Action $00. Hangs in the air for the length of its one-frame animation, which
; gives Gex a moment to see it coming, then it lets go
    call call_00_3843_Entity_CheckAnimationEnded
    ret  Z
    ld   C, SFX_FLOWER_HAMMER
    call call_00_112f_QueueSFX
    ld   A, $01
    jp   call_02_7102_Entity_SetAction

call_02_597a_EntityAction_FlowerHammer_Fall:
; Action $01. Note the DOUBLED gravity call - two full gravity steps per frame, so
; the hammer accelerates twice as fast as anything else in the game and lands hard.
; That is deliberate, not a duplicated line: the second call reads back the
; velocity the first one just stored
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    ld   BC, $0c
    call call_00_316e_Entity_ClampYToMaxYBound_Offset
    ld   A, $02
    jp   NC, call_02_7102_Entity_SetAction             ; landed
    ret

call_02_598c_EntityAction_FlowerHammer_Shatter:
; Action $02. The impact pose, held for $1e ticks, and then the slot is freed
    call call_00_3843_Entity_CheckAnimationEnded
    jp   NZ, call_00_3910_Entity_ClearSlot
    ret

; ------------------------------------------------------------------
; HUNTER - the only Toon TV enemy with a real fight to it, and the one with the
; most actions. It takes three hits, and each one puts it through a four-stage
; knockdown before it gets up again:
;
;   $00 Patrol    walk the span; fire on the shared 128-frame clock
;   $01 Fire      the shooting animation
;   $02 Stagger   recoil          (data_02_7768, 15 frames)
;   $03 FallOver  going down      (data_02_777c)
;   $04 Downed    flat out for $b4 ticks, three seconds
;   $05 GetUp     back on its feet, and clears the hit flag
;
; MISC_FLAGS bit 0 is raised by .jr_03_4e7f_CollisionHandler_Hunter and is the
; only way into the knockdown chain. The hit COUNT lives in MISC_TIMER_1, set to 3
; on the hunter's first frame and decremented by that same collision handler; when
; it reaches zero the handler bursts the hunter instead and bumps
; wD773_HuntersDefeatedCount, which opens a block patch slot on the second kill.
;
; The handler also refuses to register anything at all while bit 0 is still set,
; so the knockdown doubles as invulnerability frames
; ------------------------------------------------------------------

call_02_5993_EntityAction_Hunter_Patrol:
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_599D
    ld   c,$03
    call call_00_3802_Entity_SetMiscTimer              ; three hits to beat
.jr_02_599D:
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$7F
    jr   nz,.jr_02_59BE                                ; fire once every 128 frames
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   c,SFX_HUNTER
    call call_00_112f_QueueSFX
    ld   c,SPAWN_CHILD_ENTITY_HUNTER_BULLET
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   a,HUNTER_ACTION_FIRE
    jp   call_02_7102_Entity_SetAction
.jr_02_59BE:
    ld   c,$08
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    jr   call_02_5a00_Hunter_CheckHitFlag

call_02_59c8_EntityAction_Hunter_Fire:
; Action $01. Plays out the 10-frame shooting animation - the bullet was already
; spawned by the patrol action. Being hit part way through still interrupts it
    call call_00_3843_Entity_CheckAnimationEnded
    jr   z,call_02_5a00_Hunter_CheckHitFlag
    ld   a,HUNTER_ACTION_PATROL
    jp   call_02_7102_Entity_SetAction

call_02_59d2_EntityAction_Hunter_Stagger:
; Actions $02-$05 are a plain chain: each waits for its own animation to run out
; and hands over to the next. Nothing else can interrupt them
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,HUNTER_ACTION_FALL_OVER
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_59db_EntityAction_Hunter_FallOver:
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,HUNTER_ACTION_DOWNED
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_59e4_EntityAction_Hunter_Downed:
; Action $04. data_02_7784 is one frame held for $b4 ticks, so this is a three
; second pause on the floor with no code doing anything
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,HUNTER_ACTION_GET_UP
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_59ed_EntityAction_Hunter_GetUp:
; Action $05. Clearing MISC_FLAGS bit 0 here is what makes the hunter vulnerable
; again, so the invulnerability lasts exactly as long as the knockdown animation
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    res  MISC_FLAGS_BIT_0,[hl]
    ld   a,HUNTER_ACTION_PATROL
    jp   call_02_7102_Entity_SetAction

call_02_5a00_Hunter_CheckHitFlag:
; Shared tail of the two "upright" actions. Reached by falling through from Patrol
; and by an explicit jump from Fire, so a hit registers on the next frame whichever
; of the two the hunter happens to be in
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    ret  z
    ld   a,HUNTER_ACTION_STAGGER
    jp   call_02_7102_Entity_SetAction

call_02_5a10_EntityAction_HunterBullet_Init:
; Action $00, one frame. Speed and a 90-frame fuse; the facing was inherited from
; the hunter when the child was spawned
    ld   c,$01
    call call_00_3350_Entity_SetXVelocity
    ld   c,$5A
    call call_00_3802_Entity_SetMiscTimer
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5a1f_EntityAction_HunterBullet_Fly:
; Action $01. Flies straight, no gravity, and frees its slot when the fuse runs out
    call call_00_3817_Entity_DecrementMiscTimer
    jp   z,call_00_3910_Entity_ClearSlot
    jp   call_00_3442_Entity_MoveXByFacingSpeed

call_02_5a28_EntityAction_Mushroom_Update:
; One action, and it does nothing at all until MISC_FLAGS bit 0 is raised by
; .jr_03_4eb4_CollisionHandler_Mushroom - i.e. until Gex attacks it. Then, in one
; frame, it destroys itself and hands out a prize.
;
; wD774_MushroomsDestroyedCount is the level's running total, and the fifth one
; opens block patch slot 15. The count also decides WHICH prize: the routine walks
; the slots for the ENTITY_TOON_TV_MUSHROOM_PROJECTILE ($28) it has just spawned
; and overwrites that child's SPRITE_ID with $40 + 2*(count-1), stepping through
; the eight icons in data_02_7a21. So each mushroom in the room pops out a
; different one
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0, [HL]
    ret  Z
    ld   HL, wD774_MushroomsDestroyedCount
    inc  [HL]
    ld   A, [HL]
    cp   A, $05
    jr   NZ, .jr_02_5a41
    ld   HL, wD79A_BlockPatch_SlotTable15
    ld   [HL], $02
.jr_02_5a41:
    ld   C, SPAWN_CHILD_ENTITY_MUSHROOM_PROJECTILE
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    call call_00_3985_Entity_ParticleBurstInit
    ld   H, $d2
    ld   A, $20
.jr_02_5a55:
    ld   L, A
    ld   A, [HL]
    cp   A, $28
    jr   Z, .jr_02_5a61
    ld   A, L
    add  A, $20
    jr   NZ, .jr_02_5a55
    ret
.jr_02_5a61:
    ld   A, L
    or   A, $1e
    ld   L, A
    ld   [HL], $40
    xor  A, $16
    ld   L, A
    ld   A, [wD774_MushroomsDestroyedCount]
    dec  A
    add  A, A
    add  A, $40
    ld   [HL], A
    ret

call_02_5a73_EntityAction_MushroomProjectile_Update:
; One action. The prize the mushroom pops out: it was given an upward velocity of
; $40 and a sprite id by its parent, and all it does is arc up and disappear when
; it hits the ground. It is scenery, not a pickup - the collision box is what
; makes it worth anything, if anything
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    jp   NC, call_00_3910_Entity_ClearSlot             ; landed
    ret

call_02_5a7d_EntityAction_ToonTVLizard_Update:
; One action: walk the patrol span at speed $14. Nothing else.
;
; DEAD CODE: the frame-counter test below branches to the instruction immediately
; after itself, so both outcomes run exactly the same code and the `and $3F` has
; no effect at all. Something was meant to happen once every 64 frames - a call
; that was removed, most likely - and the test was left behind
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$3F
    jr   nz,.jr_02_5A84                                ; jumps to the next instruction
.jr_02_5A84:
    ld   c,$14
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

call_02_5a8c_EntityAction_HappyFace_Crouch:
; The happy face is the pumpkin again, instruction for instruction: squash, launch
; at $28, fall, thump, repeat. See call_02_538b_EntityAction_Pumpkin_Crouch
    call call_00_3843_Entity_CheckAnimationEnded
    ret  Z
    ld   C, $28
    call call_00_335a_Entity_SetYVelocity
    ld   A, $01
    jp   call_02_7102_Entity_SetAction
call_02_5a9a_EntityAction_HappyFace_Hop:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  C
    ld   C, SFX_ENEMY_BOUNCE
    call call_00_112f_QueueSFX
    ld   A, $00
    jp   call_02_7102_Entity_SetAction

; ------------------------------------------------------------------
; TOON TV VANISHING BLOCK - the same three-state blink-and-vanish cycle as
; call_02_563a_EntityAction_ScreamTVVanishingPlatform_WaitForCue, down to the
; duplicated dither tables. Two things are added here:
;
;   - the platform prologue, so the block can also patrol
;   - a self-destruct: if MISC_FLAGS bit 0 is set, MISC_PARAM names a block patch
;     slot, and the block frees its own slot as soon as that slot goes empty
;
; and one thing is changed: it comes back with width $08 rather than $10
; ------------------------------------------------------------------

call_02_5aab_EntityAction_ToonTVVanishingBlock_WaitForCue:
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5AB7
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_5AB7:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   z,.jr_02_5AD2                                 ; not tied to a switch
    inc  l
    inc  l
    inc  l                                             ; $1A MISC_PARAM
    ld   l,[hl]                                        ; = block patch slot index
    ld   h,$00
    ld   de,wD78B_BlockPatch_SlotTable
    add  hl,de
    ld   a,[hl]
    and  a
    jp   z,call_00_3910_Entity_ClearSlot               ; switch cleared - remove the block
.jr_02_5AD2:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM_HI
    ld   a,[wD73B_VBlankFrameCounter]
    cp   [hl]                                          ; my phase in the 256-frame cycle
    ret  nz
    ld   a,l
    xor  a,$03                                         ; $1B -> $18 MISC_TIMER_1
    ld   l,a
    ld   [hl],$40                                      ; blink for $40 frames
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5aea_EntityAction_ToonTVVanishingBlock_BlinkOut:
; Byte for byte the Scream TV blink-out. timer >> 3 picks a duty pattern, timer & 7
; picks the bit, and the block flickers harder and harder as the count falls
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$12                                         ; $18 -> $0A SPRITE_FLAGS
    ld   l,a
    res  SPRITE_FLAG_INVISIBLE_BIT,[hl]
    ld   a,c
    and  a
    jr   z,.jr_02_5B1F
    cp   a,$40
    ret  nc
    push hl
    srl  a
    srl  a
    srl  a
    ld   e,a
    ld   d,$00
    ld   hl,.data_02_5b29
    add  hl,de
    ld   b,[hl]
    ld   a,c
    and  a,$07
    ld   e,a
    ld   hl,.data_02_5b31
    add  hl,de
    ld   a,[hl]
    pop  hl
    and  b
    ret  nz
    set  SPRITE_FLAG_INVISIBLE_BIT,[hl]
    ret
.jr_02_5B1F:
    ld   c,$00
    call call_00_382f_Entity_SetWidth                  ; nothing to stand on
    ld   a,$02
    jp   call_02_7102_Entity_SetAction
.data_02_5b29:
; Duty pattern by (timer >> 3) - a private copy of .data_02_5691
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_5b31:
; Bit selector by (timer & 7) - a private copy of .data_02_5699
    db   $01, $02, $04, $08, $10, $20, $40, $80

call_02_5b39_EntityAction_ToonTVVanishingBlock_Gone:
; Action $02. Invisible and intangible for $1e ticks, then solid again at width $08
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,$08
    call call_00_382f_Entity_SetWidth
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_5b47_EntityAction_ToonTVMovingBlock_Run:
; The switch-driven platform that runs one round trip and then shuts the switch
; off behind it. Four MISC_FLAGS bits are in play, and only the last is set here:
;
;   bit 2  armed - the switch has been thrown at least once
;   bit 3  from the spawn record: stop at each end of the run. This is also what
;          makes call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip clear bit 0
;          when the block reaches a bound
;   bit 0  currently running. Cleared by the patrol driver on arrival, set again
;          by the pause action
;   bits 5/4  the direction the block STARTED in, as a fixed copy of bits 7/6
;
; So each time the block arrives somewhere, bit 0 is clear and this routine gets
; to ask "which end am I at?" by comparing the live direction bits 7/6 against the
; recorded start direction in bits 5/4. Different means it is at the far end, so
; it pauses and comes back; the same means it has completed a round trip, at which
; point it clears the block patch slot that started it and disarms itself
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5B53
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_5B53:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ldd  a,[hl]
    cp   a,$FF
    jr   z,.jr_02_5B97                                 ; ungated - always running
    and  a,$0F
    add  a,$8B
    ld   e,a
    ld   a,$00
    adc  a,$D7
    ld   d,a                                           ; DE = wD78B_BlockPatch_SlotTable + index
    dec  l
    dec  l                                             ; $17 MISC_FLAGS
    bit  2,[hl]
    jr   z,.jr_02_5B90                                 ; not armed yet - watch the switch
    bit  3,[hl]
    jr   z,.jr_02_5B97                                 ; never stops - just keep going
    bit  0,[hl]
    jr   nz,.jr_02_5B97                                ; mid-run
    ld   a,[hl]
    and  a,$C0
    ld   c,a                                           ; C = current direction, bits 7/6
    ld   a,[hl]
    rlca
    rlca
    and  a,$C0                                         ; start direction, bits 5/4 -> 7/6
    sub  c
    jr   nz,.jr_02_5B88                                ; far end: turn round
    ld   [de],a                                        ; home again: clear the switch (A = 0)
    res  2,[hl]                                        ; and disarm
    ret
.jr_02_5B88:
    inc  l                                             ; $18 MISC_TIMER_1
    ld   [hl],$46
    ld   a,01
    jp   call_02_7102_Entity_SetAction                 ; pause before the return leg
.jr_02_5B90:
    ld   a,[de]
    and  a
    ret  z                                             ; switch not thrown
    set  2,[hl]                                        ; arm
    set  0,[hl]                                        ; and go
.jr_02_5B97:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_5b9d_EntityAction_ToonTVMovingBlock_PauseAtEnd:
; Action $01. Sits still at the end of a leg. The timer only ticks on one frame in
; eight, so the $46 loaded above is a pause of about nine seconds, not one second.
; Setting bit 0 on the way out is what lets the patrol driver move it again
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$07
    ret  nz
    call call_00_3817_Entity_DecrementMiscTimer
    ret  nz
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_5bb6_EntityAction_MovingLog_Update:
; One action, and the same routine as
; call_02_5348_EntityAction_ScreamTVMovingPlatform_Update: patrol config from the
; spawn record, an optional block patch gate in MISC_PARAM ($FF = ungated), then
; move and patrol
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   Z, .jr_02_5bc2
    ld   A, L
    xor  A, $10
    ld   L, A
    ld   A, [HL-]
    dec  L
    ld   [HL], A
.jr_02_5bc2:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   A, [HL]
    cp   A, $ff
    jr   Z, .jr_02_5bdb
    and  A, $0f
    ld   L, A
    ld   H, $00
    ld   DE, wD78B_BlockPatch_SlotTable
    add  HL, DE
    ld   A, [HL]
    and  A, A
    ret  Z
.jr_02_5bdb:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip
call_02_5be1_EntityAction_StationaryLog_Update:
; One action that does nothing at all, which is the whole point: the log is a
; static platform, and everything it does happens in its collision type. An entity
; with no behaviour still needs an action, because Entity_TickAction calls one
; unconditionally
    ret

; ------------------------------------------------------------------
; TOON TV ROCKET - the ride at the end of the channel. It cannot be triggered by
; walking into it: .jr_03_50e7_CollisionHandler_Rocket checks that fly power-up 2
; is active first, and only then raises MISC_FLAGS bit 7 and puts Gex into
; PLAYER_ACTION_RIDING_ROCKET
; ------------------------------------------------------------------

call_02_5be2_EntityAction_Rocket_Idle:
; Action $00. Sits on the pad waiting for bit 7
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_7,[hl]
    ret  z
    ld   c,SFX_ROCKET
    call call_00_112f_QueueSFX
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5bf7_EntityAction_Rocket_Ignite:
; Action $01. data_02_7c81 is 20 frames alternating between sprites $40 and $50 in
; an irregular pattern - the engine sputtering. The rocket does not move yet
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$02
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5c00_EntityAction_Rocket_Launch:
; Action $02. Ramps Y velocity towards $C0, which is -64 signed and the same
; terminal velocity gravity clamps to - so the rocket climbs at exactly the speed
; a long fall would reach, accelerating into it one unit a frame.
;
; It moves with the NoPlayerPush variant, so it does not carry Gex the way a
; platform would; the player action is what keeps him aboard
    ld   c,$c0
    call call_00_3316_Entity_NudgeYVelocityTowardC_Signed
    jp   call_00_3597_Entity_ApplyVelocityXY_Subpixel_NoPlayerPush

; ==================================================================
; PRE-HISTORY CHANNEL
;
; Entity ids $32 (ENTITY_PRE_HISTORY_FAST_DINOSAUR) through $4A
; (ENTITY_UNK_4A). Action tables data_02_4f57 .. data_02_4fe7.
;
; The HL WALKING and CHILD SPAWN PARAMETERS conventions from the head of the
; SCREAM TV section still apply. Two things are specific to this channel:
;
; THE PLAIN WALKER. Half of Pre-History is one routine with a different constant:
;
;     ld   c, <top speed>
;     call call_00_32e1_Entity_NudgeXVelocityTowardC
;     jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
;
; which accelerates to a top speed and paces its patrol span, turning at each end.
; Speeds run from $0C (dragonfly) through $10 (dinosaur, ant) to $22 (the fast
; dinosaur). It is worth knowing that the second call returns NZ ON THE FRAME THE
; ENTITY TURNS AROUND, because several entities here use that as a "I have reached
; the end of my run" event rather than tracking position themselves.
;
; ENTITY_UNK_*. Every id in this file whose name is ENTITY_UNK_nn is unreachable:
; no level's entity list in src/data/maps names one, and neither does
; .data_0a_7c92_EntityChildSpawnData. They still occupy a jump table slot, an
; action table and an animation block, and most are a bare `ret`. Two are not:
; ENTITY_UNK_35 is a complete second copy of the geyser, and ENTITY_UNK_5D points
; into the middle of the Kung Fu vanishing platform's table
; ==================================================================

call_02_5c08_EntityAction_FastDinosaur_Update:
; The plain walker at speed $22, the fastest in the channel
    ld   c,$22
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

call_02_5c10_EntityAction_PreHistoryDragonfly_Update:
; The plain walker at speed $0C. Nothing makes it fly - the hovering is entirely
; in the animation and in wherever the level placed it
    ld   c,$0C
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

; ------------------------------------------------------------------
; EGG - the only enemy in the game that runs AWAY from Gex. It ambles at speed
; $04 until he is within $30, then sprints at $1E in the opposite direction, and
; only turns and jumps at him when it has nowhere left to go
; ------------------------------------------------------------------

call_02_5c18_EntityAction_Egg_Flee:
    ld   c,$30
    call call_00_3859_Entity_CheckPlayerXProximity
    jr   c,.jr_02_5C27                                 ; Gex is close - run
    ld   c,$04
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
.jr_02_5C27:
    call call_00_36da_Entity_FaceAwayFromPlayer
    ld   c,$1E
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    jr   nz,.jr_02_5C3D                                ; NZ = hit a bound: cornered, so turn and fight
    ld   c,$18
    call call_00_3859_Entity_CheckPlayerXProximity
    ret  nc                                            ; still has room to run
    call call_00_36bd_Entity_FaceTowardsPlayer         ; caught at $18 - round on him
.jr_02_5C3D:
    ld   c,$30
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5c47_EntityAction_Egg_Leap:
; Action $01. Airborne, still steering at a reduced speed $10
    ld   c,$10
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ld   a,$02
    jp   nc,call_02_7102_Entity_SetAction              ; landed
    ret

call_02_5c5b_EntityAction_Egg_Land:
; Action $02. Dead stop for the length of the landing animation, then back to
; fleeing. Zeroing X velocity here is what stops the sprint carrying through
    ld   c,$00
    call call_00_3350_Entity_SetXVelocity
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5c69_EntityAction_Unk35_Dormant:
; ENTITY_UNK_35, and instruction for instruction the geyser at
; call_02_5df8_EntityAction_Geyser_Dormant - same two actions, same animation
; values, a separate copy of both. Since the entity id also selects the graphics
; page and the CGB palette, this was presumably a geyser that looked different.
; Nothing spawns it
    ld   a,[wD73B_VBlankFrameCounter]
    and  a
    ld   a,$01
    jp   z,call_02_7102_Entity_SetAction
    ret

call_02_5c73_EntityAction_Unk35_Erupt:
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5c7c_EntityAction_Unk36_Update:
; ENTITY_UNK_36. Does nothing, but data_02_7a57 is a real six-frame animation, so
; had anything spawned it there would have been something to look at
    ret

call_02_5c7d_EntityAction_FallingLava_Gather:
; Action $00. Pins itself to the TOP of its own bounding box every frame - so the
; drip always re-forms at the ceiling wherever the level put its span - and counts
; down to the next drop.
;
; The cooldown is re-rolled each cycle from the gameplay frame counter as
; $40 + (counter & $3F), giving 64 to 127 frames, so a row of drips does not fall
; in lockstep
    call call_00_349c_Entity_GetMinYBound
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   [hl],e
    inc  l
    ld   [hl],d                                        ; snap back to the ceiling
    call call_00_3817_Entity_DecrementMiscTimer        ; HL = $18 MISC_TIMER_1
    ret  nz
    ld   a,[wD73C_GameplayFrameCounter]
    and  a,$3F
    or   a,$40                                         ; next wait: $40-$7F frames
    ld   [hl],a
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5c9c_EntityAction_FallingLava_Fall:
; Action $01. Falls, and the moment it reaches the bottom of its span it is back
; at the ceiling next frame - there is no splash state
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ld   a,$00
    jp   nc,call_02_7102_Entity_SetAction
    ret

call_02_5ca8_EntityAction_LavaRaft_Drift:
; Action $00: the patrolling platform prologue and the shared patrol driver, with
; no switch gate. Action $01 below is a bare `ret`, i.e. a raft that has stopped
; dead; nothing in this bank ever selects it
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5CB4
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5CB4:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_5cba_EntityAction_LavaRaft_Moored:
    ret

call_02_5cbb_EntityAction_PreHistoryMovingPlatform_Update:
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5CC7
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5CC7:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_5ccd_EntityAction_Unk3A_Update:
    ret

call_02_5cce_EntityAction_Unk3B_Update:
    ret

call_02_5ccf_EntityAction_Pterosaur_Update:
; The one entity in the game that uses
; call_00_30da_Entity_ApplyGravityMoveY_WithFloorCollision instead of the usual
; call_00_30af, and the sign convention is the OPPOSITE way round because of it:
; here a positive Y velocity moves DOWN, and the per-frame "gravity" therefore
; accelerates the pterosaur UPWARDS. Left alone it floats to the top of its span
; and is pinned there with its velocity zeroed.
;
; So the shape is inverted from every other flyer: hanging at the ceiling is the
; rest state, and the $38 velocity below is a SWOOP DOWN at Gex, not a flap up.
;
; The carry from that helper is the whole state machine:
;   carry SET    somewhere in mid-air, part way through a swoop
;   carry CLEAR  just clamped to the ceiling
;
; And it can only swoop once per traverse: the cooldown timer is decremented ONLY
; on the frame Entity_MoveXByFacingMomentum_BoundsChecked reports a turn, so a
; pterosaur that has dived must walk its span to the far end before it may dive
; again
    call call_00_30da_Entity_ApplyGravityMoveY_WithFloorCollision
    jr   nc,.jr_02_5CDF                                ; clamped: hanging at the ceiling
    call call_00_3345_Entity_CheckIfYVelocityIsZero    ; A = Y velocity
    ld   c,$20
    bit  7,a
    jr   z,.jr_02_5D01                                 ; descending - fast horizontally
    jr   .jr_02_5CFF                                   ; climbing back - slow
.jr_02_5CDF:
    call call_00_380c_Entity_CheckMiscTimerZero
    jr   nz,.jr_02_5CFF                                ; still on cooldown
    ld   c,$30
    call call_00_3859_Entity_CheckPlayerXProximity
    jr   nc,.jr_02_5CFF                                ; Gex not underneath
    ld   a,[wD20E_Player_XPositionLo]
    and  a,$03
    inc  a                                             ; 1-4 turns before it may dive again
    ld   c,a
    call call_00_3802_Entity_SetMiscTimer
    ld   c,$38
    call call_00_335a_Entity_SetYVelocity              ; swoop DOWN (inverted convention)
    ld   c,SFX_PTEROSAUR
    call call_00_112f_QueueSFX
.jr_02_5CFF:
    ld   c,$0C
.jr_02_5D01:
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    call nz,call_00_3817_Entity_DecrementMiscTimer     ; only ticks when it turns around
    ret

call_02_5d0b_EntityAction_Unk3D_Update:
    ret

; ------------------------------------------------------------------
; FALLING BOULDER - four actions, and the only entity that changes its own
; COLLISION TYPE as it goes: harmless while waiting above the screen, a falling
; hazard on the way down, and a spread of dangerous shards after it lands
; ------------------------------------------------------------------

call_02_5d0c_EntityAction_FallingBoulder_WaitForCue:
; Action $00. Invisible (data_02_7aae has SPRITE_FLAG_INVISIBLE) and parked $40
; above the top of the view - recomputed every frame, so it stays off-screen no
; matter how the camera moves. Drops when the frame counter's low 6 bits match
; MISC_TIMER_1, a spawn parameter, so a line of boulders falls in sequence
    ld   hl,wD6EF_BgMap_ScrollY
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    ld   de,$ffC0
    add  hl,de                                         ; scroll Y - $40
    ld   e,l
    ld   d,h
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   [hl],e
    inc  l
    ld   [hl],d
    xor  a,$09                                         ; $11 -> $18 MISC_TIMER_1
    ld   l,a
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$3F                                         ; my phase in a 64-frame cycle
    cp   [hl]
    ret  nz
    ld   c,COLLISION_TYPE_FALLING_HAZARD
    call call_00_3825_Entity_SetCollisionType          ; only dangerous once it is falling
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5d37_EntityAction_FallingBoulder_Fall:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  c
    ld   c,SFX_FALLING_BOULDER
    call call_00_112f_QueueSFX
    ld   a,$02
    jp   call_02_7102_Entity_SetAction

call_02_5d48_EntityAction_FallingBoulder_Smash:
; Action $02. The two-frame impact. On the wrap it becomes a spread of shards:
; collision type changes again, and the particle system is armed with the pattern
; written for exactly this
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,COLLISION_TYPE_MULTI_PROJECTILE
    call call_00_3825_Entity_SetCollisionType
    ld   a,$03
    call call_02_7102_Entity_SetAction
    ld   c,PARTICLE_PATTERN_FALLING_BOULDER
    jp   call_00_3a23_Entity_StartParticleEffect

call_02_5d5b_EntityAction_FallingBoulder_Shards:
; Action $03. Runs the shards until they die out, then returns to action $00 -
; which puts the boulder back above the screen for the next cycle. It never frees
; its slot, so one boulder entity serves the room forever
    call call_00_3b8d_Entity_TickParticles
    ld   a,$00
    jp   z,call_02_7102_Entity_SetAction
    FARCALL call_03_65b8_Particles_BuildSpriteList_BoulderDebris
    ret

call_02_5d6f_EntityAction_Unk3F_Update:
    ret

; ------------------------------------------------------------------
; BEETLES AND THE ANT - the same "speed up when Gex is near" idea as the Toon TV
; shark, on two axes. All three entities share one of these two routines; only the
; animation and the patrol axis differ, and the axis is chosen by which helper the
; routine ends in rather than by any flag
; ------------------------------------------------------------------

call_02_5d70_EntityAction_BeetleVertical_Update:
; Ends in Entity_PatrolY_FacingBased, so it runs up and down instead of along
    ld   c,$18
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   c,$20                                         ; near: double speed
    jr   c,.jr_02_5D7B
    ld   c,$10
.jr_02_5D7B:
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_3760_Entity_PatrolY_FacingBased

call_02_5d81_EntityAction_BeetleHorizontal_Update:
; Serves both ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL and ENTITY_PRE_HISTORY_ANT -
; their action tables point at the same routine with different frame lists
    ld   c,$18
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   c,$20
    jr   c,.jr_02_5D8C
    ld   c,$10
.jr_02_5D8C:
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

call_02_5d92_EntityAction_FirePlant_Idle:
; Action $00. Waits out its animation and then a cooldown, and the cooldown is the
; interesting part: MISC_TIMER_2 is a free-running counter that is decremented
; once per attack, and its low two bits become the next cooldown. So the wait
; between spits cycles 3, 2, 1, 0, 3, 2, 1, 0 rather than being constant
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    call call_00_3817_Entity_DecrementMiscTimer
    ret  nz
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    dec  [hl]
    ld   a,[hl]
    dec  l                                             ; $18 MISC_TIMER_1
    and  a,$03
    ld   [hl],a                                        ; next cooldown = 0-3 animation loops
    ld   c,$40
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5db2_EntityAction_FirePlant_Hop:
; Action $01. Hops up and spits on the way DOWN - the projectiles are spawned at
; the moment it lands, not at the top of the hop
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    ld   bc,$0008
    call call_00_316e_Entity_ClampYToMaxYBound_Offset  ; floor 8 units low, so it sits in the ground
    ret  c
    ld   c,SFX_MULTI_PROJECTILE
    call call_00_112f_QueueSFX
    ld   c,SPAWN_CHILD_ENTITY_FIRE_PLANT_PROJECTILES
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   a,$02
    jp   call_02_7102_Entity_SetAction

call_02_5dd3_EntityAction_FirePlant_Recover:
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5ddc_EntityAction_FirePlantProjectiles_Init:
; The same two-action particle projectile as the Scream TV floating skull's, with
; the same pattern and a different sprite builder. Arm, then run until the last
; particle dies
    ld   c,PARTICLE_PATTERN_MULTI_PROJECTILE
    call call_00_3a23_Entity_StartParticleEffect
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5de6_EntityAction_FirePlantProjectiles_Fly:
    call call_00_3b8d_Entity_TickParticles
    jp   z,call_00_3931_Entity_DeactivateSelf
    FARCALL call_03_663a_Particles_BuildSpriteList_FirePlant
    ret

call_02_5df8_EntityAction_Geyser_Dormant:
; Action $00, drawing nothing (data_02_7ad8 is SPRITE_FLAG_INVISIBLE). Erupts when
; the global frame counter wraps to zero, so every geyser in the room goes off
; together on a 256-frame beat - there is no per-entity phase here, unlike the
; falling boulders and the vanishing platforms
    ld   a,[wD73B_VBlankFrameCounter]
    and  a
    ld   a,$01
    jp   z,call_02_7102_Entity_SetAction
    ret

call_02_5e02_EntityAction_Geyser_Erupt:
; Action $01. Six frames of spout and then straight back to invisible
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_5e0b_EntityAction_Unk46_Update:
    ret

call_02_5e0c_EntityAction_Dinosaur_Update:
; The plain walker at speed $10, plus a hop: gravity and the landing check run
; every frame, and whenever it is on the ground with Gex within $34 it launches
; again. So it bounds continuously while he is near and simply walks when he is
; not. `call c` is doing the work - the velocity is only set on frames where the
; proximity test passed
    ld   c,$10
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  c                                             ; airborne
    ld   c,$34
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   c,$28
    call c,call_00_335a_Entity_SetYVelocity            ; on the ground and Gex is near: hop
    ret

call_02_5e26_EntityAction_Triceratops_Update:
; One action, and a two-entity enemy: the triceratops spawns an
; ENTITY_PRE_HISTORY_TRICERATOPS_HORN on its first frame and then DRAGS IT ALONG
; every frame afterwards, planting it $14 pixels ahead in whatever direction the
; body faces and copying the facing across. The horn's own action is a bare `ret`
; - it is pure geometry, and the reason it exists is that it carries a different
; collision type from the body, so the tip of the horn hurts and the flank does
; not.
;
; If the horn is not in any slot the routine simply gives up for this frame; the
; body does not care
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_5E38
    ld   c,SPAWN_CHILD_ENTITY_TRICERATOPS_HORN
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
.jr_02_5E38:
    ld   c,$08
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    or   a,$0D
    ld   l,a
    ld   a,[hl]
    push af
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    inc  l
    ld   c,[hl]
    inc  l
    ld   b,[hl]
    ld   h,$D2
    ld   a,$20
.jr_02_5E5B:
    ld   l,a
    ld   a,[hl]
    cp   a,$49
    jr   z,.jr_02_5E68
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_5E5B
    pop  af
    ret
.jr_02_5E68:
    ld   a,l
    or   a,$0D
    ld   l,a
    pop  af
    ld   [hl],a
    bit  5,a
    jr   z,.jr_02_5E80
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   a,e
    sub  a,$14
    ldi  [hl],a
    ld   a,d
    sbc  a,$00
    ldi  [hl],a
    jr   .jr_02_5E8C
.jr_02_5E80:
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   a,e
    add  a,$14
    ldi  [hl],a
    ld   a,d
    adc  a,$00
    ldi  [hl],a
.jr_02_5E8C:
    ld   [hl],c
    inc  l
    ld   [hl],b
    ret

call_02_5e90_EntityAction_TriceratopsHorn_Update:
; Does nothing on purpose - see the body above, which positions it
    ret

call_02_5e91_EntityAction_Unk4A_Update:
    ret

; ==================================================================
; KUNG FU THEATER
;
; Entity ids $4B (ENTITY_KUNG_FU_THEATER_HANGING_BLADE) through $63
; (ENTITY_UNK_63). Action tables data_02_4feb .. data_02_5087.
;
; This is the most interconnected set in the file. Three things here are not
; self-contained the way the earlier channels are:
;
; A GLOBAL BOSS. The dragon is one head plus a chain of body segments, all running
; the same orbit code, and its health is not in any entity - it is
; wD613_Dragon_SegmentsRemaining in WRAM, shared by every part.
;
; A TWO-PIECE ENEMY. The samurai body carries its head as a separate entity, the
; way the triceratops carries its horn, but here the head can detach and act on
; its own, and the body dies if the head is destroyed.
;
; DAMAGE THAT COMES FROM SCENERY. The cannon is aimed by tail-spinning tile blocks
; beside it (which write wD615_Cannon_FacingDirection from
; bank00_tile_hit_scripts.asm) and fired by stomping it, and its projectile is the
; only thing in the game that does its OWN hit test against another entity rather
; than going through the bank 3 collision table
; ==================================================================

call_02_5e92_EntityAction_HangingBlade_Update:
; One action, with the phase in MISC_FLAGS bit 0: clear means falling, set means
; resting at the bottom. On landing it waits 60 frames, then fires itself back up
; at $40 and lets gravity bring it down again. So the "hanging" blade is really a
; blade that pumps up and down on a one-second cycle
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   nz,.jr_02_5EAF
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  c                                             ; still falling
    ld   c,$3C
    call call_00_3802_Entity_SetMiscTimer              ; one second at the bottom
    ld   c,$01
    jp   call_00_37f8_Entity_SetMiscFlags
.jr_02_5EAF:
    call call_00_3817_Entity_DecrementMiscTimer
    ret  nz
    ld   c,$00
    call call_00_37f8_Entity_SetMiscFlags
    ld   c,$40
    jp   call_00_335a_Entity_SetYVelocity              ; shoot back up

call_02_5ebd_EntityAction_Cannon_Update:
; One action, and it is idle until something else asks it to fire.
; .jr_03_5109_CollisionHandler_Cannon raises MISC_FLAGS bit 7 when Gex STOMPS it
; (attack alone does not count), and the barrel's direction is not the entity's -
; it is wD615_Cannon_FacingDirection, written by the tile hit scripts on the
; rotating blocks next to the cannon. So aiming and firing are two separate
; player actions on two different things.
;
; Only one shot may exist at a time: the slot scan below bails out if an
; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE ($4D) is already live. Note the bit is
; cleared BEFORE that check, so a stomp during a shot is simply lost
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_7,[hl]
    ret  z
    res  MISC_FLAGS_BIT_7,[hl]
    ld   a,ENTITY_SLOT_FIRST_NPC                       ; HL is still $D2xx
.jr_02_5ECC:
    ld   l,a
    ld   a,[hl]
    cp   a,$4D                                         ; a shot already in flight?
    ret  z
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_5ECC
    ld   hl,wD615_Cannon_FacingDirection               ; aimed by the blocks, not by the cannon
    ld   c,[hl]
    call call_00_3290_Entity_SetFacingDirection
    ld   c,SPAWN_CHILD_ENTITY_CANNON_PROJECTILE
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   c,SFX_CANNON
    call call_00_112f_QueueSFX
    ret

call_02_5ef0_EntityAction_CannonProjectile_Init:
; Action $00, one frame: a 128-frame fuse, then hand over
    ld   c,$80
    call call_00_3802_Entity_SetMiscTimer
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_5efa_EntityAction_CannonProjectile_Fly:
; Action $01, and the only entity-versus-entity hit test in the game that is
; written by hand rather than driven from the bank 3 collision table.
;
; After moving, it looks for an ENTITY_KUNG_FU_THEATER_DRAGON_HEAD ($50) and
; compares SCREEN positions - the +$08 / cp $10 idiom is a signed "within +/- 8
; pixels" test on each axis, the same bias trick
; call_00_3859_Entity_CheckPlayerXProximity uses. A hit takes one segment off
; wD613_Dragon_SegmentsRemaining and starts the shared $80-frame flash.
;
; The `bit SPRITE_FLAG_ON_SCREEN_BIT` guard above means an off-screen shot cannot
; score, so the cannon really does have to be lined up on the dragon as it passes
    call call_00_3817_Entity_DecrementMiscTimer
    jp   z,call_00_3910_Entity_ClearSlot
    ld   c,$02
    call call_00_3350_Entity_SetXVelocity
    call call_00_3442_Entity_MoveXByFacingSpeed
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    bit  SPRITE_FLAG_ON_SCREEN_BIT,[hl]
    ret  z
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_5F15:
    ld   l,a
    ld   a,[hl]
    cp   a,$50                                         ; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    jr   z,.jr_02_5F21
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_5F15
    ret
.jr_02_5F21:
    ld   a,l
    or   a,$12                                         ; the head's $12 SCREEN_X
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]                                        ; DE = head screen X, Y
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$12
    ld   l,a
    ldi  a,[hl]
    sub  e
    add  a,$08
    cp   a,$10
    ret  nc                                            ; more than 8px apart in X
    ld   a,[hl]
    sub  d
    add  a,$08
    cp   a,$10
    ret  nc                                            ; more than 8px apart in Y
    ld   hl,wD613_Dragon_SegmentsRemaining
    dec  [hl]
    ld   hl,wD614_Dragon_HitTimer
    ld   [hl],$80
    jp   call_00_3910_Entity_ClearSlot

call_02_5f48_EntityAction_KungFuDragonfly_Update:
; The plain walker at speed $0C - the same routine as the Pre-History dragonfly,
; duplicated rather than shared
    ld   c,$0C
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

; ------------------------------------------------------------------
; THE DRAGON - one ENTITY_KUNG_FU_THEATER_DRAGON_HEAD and a string of
; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT entities, all flying the same closed
; loop through call_02_6029_Dragon_StepOrbit and spaced around it by the step
; counter each was spawned with.
;
; Its health is global. wD613_Dragon_SegmentsRemaining starts at $0A and is
; decremented by the CANNON PROJECTILE, not by anything Gex does directly; when it
; reaches zero every part bursts and the head opens a block patch slot.
;
; wD614_Dragon_HitTimer is the flash after a hit, and it is ticked by the BODY
; SEGMENTS - so with N segments alive it counts down N times per frame, and the
; flash gets shorter as the dragon is whittled down
; ------------------------------------------------------------------

call_02_5f50_EntityAction_DragonBodySegment_Update:
    ld   a,[wD614_Dragon_HitTimer]
    and  a
    jr   z,.jr_02_5F5A
    dec  a
    ld   [wD614_Dragon_HitTimer],a                     ; every segment ticks the shared timer
.jr_02_5F5A:
    call call_02_613f_Dragon_UpdateHitFlash
    ld   a,[wD613_Dragon_SegmentsRemaining]
    and  a
    jp   z,call_00_3985_Entity_ParticleBurstInit       ; boss dead - this piece bursts
    jp   call_02_6029_Dragon_StepOrbit

call_02_5f67_EntityAction_DragonHead_Update:
; The head does everything the segments do, plus two jobs of its own: it breathes
; fire at two points of the loop, and it re-picks its own sprite every frame from
; where it is on the circle
    call call_02_613f_Dragon_UpdateHitFlash
    ld   a,[wD613_Dragon_SegmentsRemaining]
    and  a
    jp   nz,.jr_02_5F79
    ld   a,$02
    ld   [wD78F_BlockPatch_SlotTable4],a               ; boss beaten - open the way on
    jp   call_00_3985_Entity_ParticleBurstInit
.jr_02_5F79:
; Breathe fire at the start of quadrants 1 and 3, i.e. twice per revolution and at
; opposite points of the circle
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ldd  a,[hl]                                        ; A = quadrant; HL = $19 step counter
    cp   a,$01
    jr   z,.jr_02_5F8A
    cp   a,$03
    jr   nz,.jr_02_5FA0
.jr_02_5F8A:
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_5FA0                                ; only on step 0 of the quadrant
    ld   c,SPAWN_CHILD_ENTITY_DRAGON_PROJECTILE
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   c,SFX_DRAGON
    call call_00_112f_QueueSFX
.jr_02_5FA0:
    call call_02_6029_Dragon_StepOrbit
; Now pick the sprite for where the head is on the circle. The orbit is 4 quadrants
; of $52 steps, and this maps that to one of 32 evenly spaced ORIENTATIONS:
;
;   quadrant * 8            gives the 8-orientation block
;   position within it      comes from counting how many of the thresholds in
;                           .data_02_5fdf the step counter has passed
;
; The resulting 0-31 index reads a (graphics page, OAM flip flags) pair out of
; .data_02_5fe9. Only 9 distinct pages exist - the other 23 orientations are those
; same drawings mirrored in X, Y or both, which is why the flip byte cycles
; $00 / $20 / $60 / $40.
;
; The page is streamed rather than drawn from a frame list: the head's SPRITE_ID
; is fixed (data_02_7824) and what changes is wD588_EntityGfxSrcAddrHi, with a
; VRAM transfer requested only when the page actually changes
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ldd  a,[hl]
    add  a
    add  a
    add  a                                             ; quadrant * 8
    ld   c,a
    dec  c
    ld   a,[hl]                                        ; A = step counter
    ld   hl,.data_02_5fdf
.jr_02_5FB5:
    inc  c
    inc  hl                                            ; steps past the `ret` byte first
    cp   [hl]
    jr   nc,.jr_02_5FB5                                ; count thresholds passed
    ld   a,c
    and  a,$1F                                         ; 0-31 orientation
    ld   l,a
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_5fe9
    add  hl,de
    ld   c,[hl]                                        ; graphics page 0-8
    inc  hl
    ld   b,[hl]                                        ; OAM flip flags
    ld   hl,wD588_EntityGfxSrcAddrHi
    ld   a,c
    add  a,$73                                         ; pages $73-$7B hold the head
    cp   [hl]
    ret  z                                             ; unchanged - no transfer needed
    ld   [hl],a
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],b
    ld   hl,wD60F_GfxTransferFlags
    set  GFX_XFER_ENTITY_GFX,[hl]
.data_02_5fdf:
; NOTE the label sits ON the `ret` that ends the routine above, so byte 0 of this
; "table" is the opcode $C9. The search loop compensates by doing `inc hl` before
; its first compare, so the thresholds really start at $05
    ret
    db   $05, $0e, $17, $20, $32, $3b, $44
    db   $4d, $56
.data_02_5fe9:
; 32 orientations as (graphics page, OAM attribute flags) pairs: pages 0-8 going
; one way, then the same pages back again under X flip ($20), X+Y flip ($60) and
; Y flip ($40)
    db   $00, $00, $01, $00, $02, $00
    db   $03, $00, $04, $00, $05, $00, $06, $00
    db   $07, $00, $08, $00, $07, $20, $06, $20
    db   $05, $20, $04, $20, $03, $20, $02, $20
    db   $01, $20, $00, $20, $01, $60, $02, $60
    db   $03, $60, $04, $60, $05, $60, $06, $60
    db   $07, $60, $08, $60, $07, $40, $06, $40
    db   $05, $40, $04, $40, $03, $40, $02, $40
    db   $01, $40

call_02_6029_Dragon_StepOrbit:
; Flies one step of a closed loop around a FIXED point in the map, ($0230, $04F0).
; Nothing here reads the player or the camera - the dragon's path is a constant,
; and every part of it (head and every body segment) calls this with its own step
; counter, which is what spreads them out along the curve.
;
; The loop is stored as one quarter and mirrored:
;
;   MISC_TIMER_2  step within the quarter, 0..$51, incremented here
;   MISC_PARAM    which quarter, 0..3, bumped when the step count wraps
;
; .data_02_609b holds the quarter as $52 (dx, dy) byte pairs tracing an arc of
; radius ~58 from (0, -58) round to (57, 0); the quadrant then negates dx, dy or
; both. So the whole path is a circle sampled at 328 points
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    inc  [hl]
    ld   a,[hl]
    sub  a,$52
    jr   nz,.jr_02_603D
    ld   [hl],a                                        ; wrapped: step = 0
    inc  l                                             ; $1A MISC_PARAM
    inc  [hl]
    res  2,[hl]                                        ; keep the quadrant in 0-3
    dec  l
.jr_02_603D:
    inc  l
    ldd  a,[hl]                                        ; A = quadrant; HL = $19 step
    ld   l,[hl]
    ld   h,$00
    add  hl,hl                                         ; step * 2
    ld   de,.data_02_609b
    add  hl,de
    cp   a,$00
    jr   z,.jr_02_606C
    cp   a,$01
    jr   z,.jr_02_6064
    cp   a,$02
    jr   z,.jr_02_605A
    ldi  a,[hl]                                        ; quadrant 3: -dx, +dy
    cpl
    inc  a
    ld   c,a
    ld   e,[hl]
    jr   .jr_02_606F
.jr_02_605A:
    ldi  a,[hl]                                        ; quadrant 2: -dx, -dy
    cpl
    inc  a
    ld   e,a
    ld   a,[hl]
    cpl
    inc  a
    ld   c,a
    jr   .jr_02_606F
.jr_02_6064:
    ld   c,[hl]                                        ; quadrant 1: +dx, -dy
    inc  hl
    ld   a,[hl]
    cpl
    inc  a
    ld   e,a
    jr   .jr_02_606F
.jr_02_606C:
    ld   e,[hl]                                        ; quadrant 0: +dx, +dy
    inc  hl
    ld   c,[hl]
.jr_02_606F:
; Sign-extend each offset to 16 bits and add the centre of the loop
    ld   a,e
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   d,a
    ld   hl,$0230
    add  hl,de
    ld   e,l
    ld   d,h
    ld   a,c
    cp   a,$80
    ld   a,$FF
    adc  a,$00
    ld   b,a
    ld   hl,$04F0
    add  hl,bc
    ld   c,l
    ld   b,h
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   [hl],e
    inc  l
    ld   [hl],d
    inc  l
    ld   [hl],c
    inc  l
    ld   [hl],b
    ret
.data_02_609b:
; One quarter of the orbit: $52 pairs of (dx, dy) as signed bytes, from (0, -$3A)
; to (+$39, 0). dx and dy together keep a roughly constant radius of 57-58, so
; this is a quarter circle sampled by angle rather than by x
    db   $00, $c6, $01, $c6
    db   $02, $c6, $03, $c6, $04, $c6, $05, $c6
    db   $06, $c6, $07, $c6, $08, $c7, $09, $c7
    db   $0a, $c7, $0b, $c7, $0c, $c7, $0d, $c7
    db   $0e, $c8, $0f, $c8, $10, $c8, $11, $c9
    db   $12, $c9, $13, $c9, $14, $c9, $15, $ca
    db   $16, $ca, $17, $cb, $18, $cb, $19, $cc
    db   $1a, $cc, $1b, $cd, $1c, $cd, $1d, $ce
    db   $1e, $ce, $1f, $cf, $20, $cf, $21, $d0
    db   $22, $d1, $23, $d2, $24, $d3, $25, $d4
    db   $26, $d5, $27, $d6, $28, $d7, $29, $d8
    db   $2a, $d9, $2b, $da, $2c, $db, $2d, $dc
    db   $2d, $dd, $2e, $de, $2f, $df, $30, $e0
    db   $30, $e1, $31, $e2, $31, $e3, $32, $e4
    db   $32, $e5, $33, $e6, $33, $e7, $34, $e8
    db   $34, $e9, $35, $ea, $35, $eb, $36, $ec
    db   $36, $ed, $36, $ee, $36, $ef, $37, $f0
    db   $37, $f1, $37, $f2, $38, $f3, $38, $f4
    db   $38, $f5, $38, $f6, $38, $f7, $38, $f8
    db   $39, $f9, $39, $fa, $39, $fb, $39, $fc
    db   $39, $fd, $39, $fe, $39, $ff, $39, $00

call_02_613f_Dragon_UpdateHitFlash:
; Called by every part of the dragon. Bit 1 of the shared hit timer drives
; SPRITE_FLAG_INVISIBLE, so while the timer runs the whole boss strobes on and off
; in 2-frame blocks - and because the body segments each decrement the timer once
; per frame, the flash is shorter the more of the dragon is still alive
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_SPRITE_FLAGS
    res  SPRITE_FLAG_INVISIBLE_BIT,[hl]
    ld   a,[wD614_Dragon_HitTimer]
    and  a,$02
    ret  z
    set  SPRITE_FLAG_INVISIBLE_BIT,[hl]
    ret

call_02_6152_EntityAction_DragonProjectile_Init:
; Action $00, one frame. Unlike the ninja and cannon shots, this one AIMS: it
; takes its direction from where Gex is at the moment it is breathed out, then
; flies straight
    ld   c,$80
    call call_00_3802_Entity_SetMiscTimer
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_615f_EntityAction_DragonProjectile_Fly:
    call call_00_3817_Entity_DecrementMiscTimer
    jp   z,call_00_3910_Entity_ClearSlot
    ld   c,$02
    call call_00_3350_Entity_SetXVelocity
    jp   call_00_3442_Entity_MoveXByFacingSpeed

call_02_616d_EntityAction_Unk51_Update:
    ret

; ------------------------------------------------------------------
; NINJAS - two entity ids share these routines:
; ENTITY_KUNG_FU_THEATER_WALKING_NINJA ($53) has three actions and
; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA ($54) has four, with identical rows for the
; first three. The extra row is the leap, and the code below reads its own
; ENTITY_ID to decide whether it is allowed to use it - the walking ninja has no
; action $03 to go to.
;
; Action $00 is not a state, it is the whole decision tree, and the actual state
; lives in three MISC_FLAGS bits which the first three lines dispatch on:
;
;   bit 0  attacking     stand still, face Gex, and slash 2-3 times
;   bit 1  stalking      close slowly, throwing a shuriken every 32 frames
;   bit 2  winding up    charge at speed $18 until in range, then leap
;
; Only the jumping ninja ever sets bits 1 and 2, so the walking one just paces and
; slashes
; ------------------------------------------------------------------

call_02_616e_EntityAction_Ninja_Ground:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   nz,.jr_02_61BC                                ; already attacking
    bit  MISC_FLAGS_BIT_1,[hl]
    jr   nz,.jr_02_61E1                                ; already stalking
    bit  MISC_FLAGS_BIT_2,[hl]
    jr   nz,.jr_02_61FB                                ; already winding up
.jr_02_6182:
; Idle: pace, and decide whether anything has changed
    ld   c,$14
    call call_00_3859_Entity_CheckPlayerXProximity
    jr   c,.jr_02_61AC                                 ; Gex within $14 - slash
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ENTITY_ID
    ld   a,[hl]
    cp   a,$54                                         ; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA?
    jr   nz,.jr_02_61A4                                ; walking ninja: just pace
    ld   c,$40
    call call_00_3859_Entity_CheckPlayerXProximity
    jr   nc,.jr_02_61CE                                ; Gex far away - start stalking
    ld   c,$20
    call call_00_3859_Entity_CheckPlayerXProximity
    jr   c,.jr_02_61F6                                 ; Gex within $20 - wind up to leap
.jr_02_61A4:
    ld   c,$10
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
.jr_02_61AC:
; Enter the attack: 2 or 3 slashes, the count taken from Gex's low X bit
    ld   c,$01
    call call_00_37f8_Entity_SetMiscFlags
    ld   a,[wD20E_Player_XPositionLo]
    and  a,$01
    add  a,$02
    ld   c,a
    call call_00_3802_Entity_SetMiscTimer
.jr_02_61BC:
    call call_00_36bd_Entity_FaceTowardsPlayer
    call call_00_3817_Entity_DecrementMiscTimer
    ld   a,$01
    jp   nz,call_02_7102_Entity_SetAction              ; one slash animation per count
    ld   c,$00
    call call_00_37f8_Entity_SetMiscFlags              ; done - clear every state bit
    jr   .jr_02_6182
.jr_02_61CE:
; Enter the stalk. The duration is a coarse random from Gex's X: bits 5-6 rotated
; into place, giving $1F, $3F, $5F or $7F frames
    ld   c,$02
    call call_00_37f8_Entity_SetMiscFlags
    ld   a,[wD20E_Player_XPositionLo]
    rrca
    rrca
    rrca
    and  a,$60
    or   a,$1F
    ld   c,a
    call call_00_3802_Entity_SetMiscTimer
.jr_02_61E1:
    call call_00_3817_Entity_DecrementMiscTimer
    jr   z,.jr_02_61F6                                 ; out of patience - wind up
    and  a,$1F
    ld   a,$02
    jp   z,call_02_7102_Entity_SetAction               ; every 32 frames: throw
    ld   c,$02
    call call_00_32e1_Entity_NudgeXVelocityTowardC     ; creep forward at speed 2
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ret  z
    ; NZ: ran out of room, so wind up instead of stalking further
.jr_02_61F6:
    ld   c,$04
    call call_00_37f8_Entity_SetMiscFlags
.jr_02_61FB:
; Winding up: charge at speed $18 and leap the moment Gex is within $20
    ld   c,$18
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   c,$20
    call call_00_3859_Entity_CheckPlayerXProximity
    ret  nc
    ld   c,$28
    call call_00_335a_Entity_SetYVelocity
    ld   a,$03
    jp   call_02_7102_Entity_SetAction

call_02_6213_EntityAction_Ninja_Slash:
; Action $01. One swing, then back to the decision tree - which will re-enter this
; action while the slash counter is still running
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_621c_EntityAction_Ninja_Throw:
; Action $02. Keeps tracking Gex through the wind-up and releases the shuriken on
; the last frame of the animation
    call call_00_36bd_Entity_FaceTowardsPlayer
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,SPAWN_CHILD_ENTITY_NINJA_PROJECTILE
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_6235_EntityAction_Ninja_Jump:
; Action $03, jumping ninja only. Landing clears ALL the state bits, so it comes
; down out of the leap and starts deciding again from scratch
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  c
    ld   c,$00
    call call_00_37f8_Entity_SetMiscFlags
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

; ------------------------------------------------------------------
; SAMURAI - a body and a head, spawned as two entities and glued together by
; call_02_6275_SamuraiBody_CarryHead. The head rides 9 pixels above the body until
; the body is hit, at which point it launches off and becomes a separate hazard
; that has to be destroyed on its own. Destroy the head and the body dies with it
; ------------------------------------------------------------------

call_02_624c_EntityAction_SamuraiBody_Walk:
; Action $00. Paces at speed $10 and swings when Gex is within $12. Note it falls
; THROUGH into CarryHead rather than calling it, so the head is repositioned on
; every path out of this action
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_625E
    ld   c,SPAWN_CHILD_ENTITY_SAMURAI_HEAD
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
.jr_02_625E:
    ld   c,$10
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   c,$12
    call call_00_3859_Entity_CheckPlayerXProximity
    jr   nc,call_02_6275_SamuraiBody_CarryHead
    ld   a,$01
    call call_02_7102_Entity_SetAction
    call call_00_36bd_Entity_FaceTowardsPlayer
call_02_6275_SamuraiBody_CarryHead:
; Plants the head entity on the body's shoulders: same X, 9 pixels higher, same
; facing. Two early exits matter as much as the positioning:
;
;   no ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD ($56) in any slot  ->  the body bursts.
;     Killing the head is therefore how the samurai is beaten
;   the head is in its action $01 (launched)                  ->  leave it alone,
;     it is flying under its own power now
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    or   a,$0D                                         ; $0D FACING_FLAGS (the `or $01` is redundant)
    ld   l,a
    ld   a,[hl]
    push af                                            ; my facing
    ld   a,l
    xor  a,$03                                         ; $0E WORLD_X
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]                                        ; DE = my X
    inc  l
    ld   c,[hl]
    inc  l
    ld   b,[hl]                                        ; BC = my Y
    ld   h,$D2
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_6290:
    ld   l,a
    ld   a,[hl]
    cp   a,$56                                         ; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    jr   z,.jr_02_629F
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_6290
    pop  af
    jp   call_00_3985_Entity_ParticleBurstInit         ; head is gone - so is the body
.jr_02_629F:
    ld   a,l
    or   a,$01                                         ; the head's ACTION_ID
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$01
    jr   nz,.jr_02_62AC
    pop  af
    ret                                                ; head has launched - hands off
.jr_02_62AC:
    ld   a,l
    xor  a,$0C                                         ; $01 -> $0D FACING_FLAGS
    ld   l,a
    pop  af
    ld   [hl],a                                        ; head faces the way the body does
    ld   a,l
    xor  a,$03                                         ; $0E WORLD_X
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    inc  l
    ld   a,c
    sub  a,$09
    ldi  [hl],a
    ld   a,b
    sbc  a,$00
    ldi  [hl],a                                        ; head Y = body Y - 9
    ret

call_02_62c3_EntityAction_SamuraiBody_Slash:
; Action $01. Swings once; if Gex is still within $12 when the animation ends it
; re-selects action $01 and swings again, otherwise back to walking. Ends in
; CarryHead the same way
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,$12
    call call_00_3859_Entity_CheckPlayerXProximity
    ld   a,$00
    jr   nc,.jr_02_62D5
    call call_00_36bd_Entity_FaceTowardsPlayer
    ld   a,$01                                         ; still in reach - swing again
.jr_02_62D5:
    call call_02_7102_Entity_SetAction
    jp   call_02_6275_SamuraiBody_CarryHead

call_02_62db_EntityAction_SamuraiHead_Riding:
; Action $00. Does not move itself - the body is positioning it. All it does is
; watch the BODY's MISC_FLAGS bit 0, the flag the body's collision handler raises
; when Gex hits it, and launch when it goes up
    ld   h,$D2
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_62DF:
    ld   l,a
    ld   a,[hl]
    cp   a,$55                                         ; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    jr   z,.jr_02_62EB
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_62DF
    ret                                                ; no body - just sit there
.jr_02_62EB:
    ld   a,l
    or   a,$17                                         ; the body's MISC_FLAGS
    ld   l,a
    bit  0,[hl]
    ret  z
    ld   c,$34
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_62fc_EntityAction_SamuraiHead_Launched:
; Action $01. In the air. On landing it becomes a target in its own right: it takes
; COLLISION_TYPE_SAMURAI_HEAD and, on a Colour Game Boy, RECOLOURS ITSELF by
; copying a palette straight into OBJ palette memory.
;
; QUIRK: the destination is the hardcoded wDA3B_EntityPalettes_Slot6, not this
; entity's own palette slot, so the recolour only lands on the right sprite when
; the head happens to occupy entity slot 6
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ret  c
    ld   a,[wD59E_OnGBCFlag]
    and  a
    jr   z,.jr_02_6315                                 ; DMG: no palettes to change
    ld   hl,.data_02_631f
    ld   de,wDA3B_EntityPalettes_Slot6
    ld   bc,$0008
    call call_00_07b0_MemCopy
.jr_02_6315:
    ld   c,COLLISION_TYPE_SAMURAI_HEAD
    call call_00_3825_Entity_SetCollisionType
    ld   a,$02
    jp   call_02_7102_Entity_SetAction
.data_02_631f:
; One CGB OBJ palette, four little-endian BGR555 colours: transparent, then
; $6e96 / $7778
    db   $00, $00, $00, $00, $96, $6e, $78, $77

call_02_6327_EntityAction_SamuraiHead_Grounded:
; Action $02. Sits on the ground until its own MISC_FLAGS bit 0 is raised, then
; bursts - which also kills the body, because CarryHead will not find it next frame
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    jp   nz,call_00_3985_Entity_ParticleBurstInit
    ret

call_02_6335_EntityAction_KungFuLizard_Update:
; The plain walker at speed $14. Identical to
; call_02_5a7d_EntityAction_ToonTVLizard_Update except that this copy does not
; carry that one's dead frame-counter test
    ld   c,$14
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

call_02_633d_EntityAction_NinjaProjectile_Init:
; The shuriken. A 255-frame fuse and then straight flight - no gravity, no aiming
; beyond the facing it inherited from the ninja that threw it
    ld   c,$ff
    call call_00_3802_Entity_SetMiscTimer
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6347_EntityAction_NinjaProjectile_Fly:
    call call_00_3817_Entity_DecrementMiscTimer
    jp   z,call_00_3910_Entity_ClearSlot
    ld   c,$02
    call call_00_3350_Entity_SetXVelocity
    jp   call_00_3442_Entity_MoveXByFacingSpeed

call_02_6355_EntityAction_SpikyLog_Update:
; The plain walker turned on its side: speed $10 into Entity_PatrolY_FacingBased,
; so the log rolls up and down its span instead of along
    ld   c,$10
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_3760_Entity_PatrolY_FacingBased

call_02_635d_EntityAction_Jar_Intact:
; Action $00, shared by ENTITY_KUNG_FU_THEATER_JAR and ..._TALL_JAR. Waits for
; MISC_TIMER_1 to go NON-ZERO - .jr_03_4f14_CollisionHandler_Jar writes it when
; Gex breaks the jar - and then converts itself into a burst of shards
    call call_00_380c_Entity_CheckMiscTimerZero
    ret  z
    ld   c,SFX_JAR
    call call_00_112f_QueueSFX
    ld   c,COLLISION_TYPE_NONE
    call call_00_3825_Entity_SetCollisionType          ; the shards are harmless
    ld   a,$01
    call call_02_7102_Entity_SetAction
    ld   c,PARTICLE_PATTERN_JAR_BURST
    jp   call_00_3a23_Entity_StartParticleEffect

call_02_6375_EntityAction_Jar_Shatter:
; Action $01. When the shards die out it does NOT free the slot - it calls
; Entity_ParticleBurstInit, which turns the slot into ENTITY_ENEMY_DEFEATED, which
; in turn morphs into a collectible (see
; call_02_52ab_EntityAction_ParticleBurst_Update). So a smashed jar leaves a pickup
    call call_00_3b8d_Entity_TickParticles
    jp   z,call_00_3985_Entity_ParticleBurstInit
    FARCALL call_03_6675_Particles_BuildSpriteList_JarShards
    ret

call_02_6387_EntityAction_Unk5C_Update:
    ret

call_02_6388_EntityAction_KungFuVanishingPlatform_WaitForCue:
; The FOURTH copy of the blink-and-vanish platform in this file, after the Scream
; TV, Toon TV and hard-head-hazard versions - same $40-frame fade, same two dither
; tables, copied again. This one is closest to the Scream TV original: the
; platform prologue up front, no switch gate, and it returns at width $10.
;
; ENTITY_UNK_5D also points at this routine, but its table has only one row, so an
; Entity_SetAction $01 on it would read past the end into this table's row 0.
; Nothing spawns it, so that never happens
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6394
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_6394:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM_HI
    ld   a,[wD73B_VBlankFrameCounter]
    cp   [hl]                                          ; my phase in the 256-frame cycle
    ret  nz
    ld   a,l
    xor  a,$03                                         ; $1B -> $18 MISC_TIMER_1
    ld   l,a
    ld   [hl],$40
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_63ac_EntityAction_KungFuVanishingPlatform_BlinkOut:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$12                                         ; $18 -> $0A SPRITE_FLAGS
    ld   l,a
    res  SPRITE_FLAG_INVISIBLE_BIT,[hl]
    ld   a,c
    and  a
    jr   z,.jr_02_63E1
    cp   a,$40
    ret  nc
    push hl
    srl  a
    srl  a
    srl  a
    ld   e,a
    ld   d,$00
    ld   hl,.data_02_63eb
    add  hl,de
    ld   b,[hl]
    ld   a,c
    and  a,$07
    ld   e,a
    ld   hl,.data_02_63f3
    add  hl,de
    ld   a,[hl]
    pop  hl
    and  b
    ret  nz
    set  SPRITE_FLAG_INVISIBLE_BIT,[hl]
    ret
.jr_02_63E1:
    ld   c,$00
    call call_00_382f_Entity_SetWidth
    ld   a,$02
    jp   call_02_7102_Entity_SetAction
.data_02_63eb:
; Duty pattern by (timer >> 3) - a private copy of .data_02_5691
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_63f3:
; Bit selector by (timer & 7) - a private copy of .data_02_5699
    db   $01, $02, $04, $08, $10, $20, $40, $80

call_02_63fb_EntityAction_KungFuVanishingPlatform_Gone:
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,$10
    call call_00_382f_Entity_SetWidth
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_6409_EntityAction_KungFuMovingPlatform_Update:
; The switch-gated patrolling platform again, byte for byte the same shape as
; call_02_5348_EntityAction_ScreamTVMovingPlatform_Update and
; call_02_5bb6_EntityAction_MovingLog_Update: MISC_PARAM is $FF for "always
; running", otherwise a block patch slot that has to be non-empty first
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6415
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6415:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   a,[hl]
    cp   a,$ff
    jr   z,.jr_02_642E
    and  a,$0F
    ld   l,a
    ld   h,$00
    ld   de,wD78B_BlockPatch_SlotTable
    add  hl,de
    ld   a,[hl]
    and  a
    ret  z                                             ; switch not thrown
.jr_02_642E:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_6434_EntityAction_Unk60_Update:
    ret

call_02_6435_EntityAction_MovingRaft_Update:
; Ungated patrolling platform - the prologue and the shared driver, nothing else.
; The same routine as call_02_5ca8_EntityAction_LavaRaft_Drift, and as
; call_02_5cbb_EntityAction_PreHistoryMovingPlatform_Update, and as
; call_02_5589_EntityAction_ScreamTVOrangeMovingPlatform_Update: four channels,
; four copies
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6441
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6441:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_6447_EntityAction_StationaryRaft_Update:
; A raft that never moves; it is a collision box and a sprite, and that is all
    ret

call_02_6448_EntityAction_Unk63_Update:
    ret

call_02_6449_EntityAction_Unk64_Update:
    ret

; ==================================================================
; REZOPOLIS
;
; Entity ids $65 (ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM) through $75
; (ENTITY_REZOPOLIS_ANT_SPAWNER). Action tables data_02_508f .. data_02_50ef.
;
; Rezopolis has almost no enemies - it is a channel of MACHINERY, and most of it
; is wired to one shared byte, wD617_TailSpinChargeCounter:
;
;   the TAILSPIN GEAR       is spun up by tail-spinning on it, and only at full
;                           speed does it raise the charge
;   everything else         waits for the charge to reach its maximum $40 and
;                           then does something: the activated red platform rises,
;                           the ant spawner starts producing ants
;
; So the charge is a global "the player is holding the machine at speed" signal,
; and the gear's other four speeds all drain it. Nothing else in the game reads
; it; bank00_home.asm only clears it on level entry.
;
; THE BONUS LEVEL. That whole loop is one room: entity_list_bugged_out.asm
; contains exactly three entities - an ant spawner, a tailspin gear and a gold
; remote. Spin the gear to hold the charge at $40, the spawner emits ants while
; wD649_CollectibleAmount is non-zero, and when the quota reaches zero the gold
; remote (see call_02_5297_EntityAction_GoldRemote_Gbc) stops removing itself and
; starts chirping.
;
; UNREACHABLE ACTIONS. Several entities here have action rows past $00 that are
; bare `ret`s. Nothing can select them: outside this file the only callers of
; Entity_SetAction are the spawner and the defeat burst, which both pass $00, and
; the Channel Z Rez boss, which passes $04 to itself
; ==================================================================

call_02_644a_EntityAction_RezopolisSpecialMovingPlatform_Update:
; A patrolling platform that also rides UP under the player: not ridden it settles
; down 1px a frame for up to $10 pixels, ridden it climbs back at the same rate,
; with MISC_TIMER_1 counting how far it has settled.
;
; Two of its conditions are hard-wired to one room rather than to anything
; general, which is presumably why this one is the "special" platform:
;
;   the player's BLOCK ROW $0A          skips the height logic completely and
;                                       leaves the platform simply patrolling
;   nobody standing on any entity       stops the patrol as well
;
; So it only travels while the player is aboard something, and only bobs outside
; that one row
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6456
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_6456:
    ld   hl,wD210_Player_YPositionLo
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl                                         ; player Y -> block row
    ld   a,h
    cp   a,$0A
    jr   z,.jr_02_6484                                 ; that one row: just patrol
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  0,b
    jr   nz,.jr_02_648A                                ; ridden - climb
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   a,[hl]
    cp   a,$10
    jr   z,.jr_02_647F                                 ; fully settled
    inc  [hl]
    ld   bc,$0001
    call call_00_37d8_Entity_MoveY                     ; settle 1px
.jr_02_647F:
    ld   a,[wD74D_Player_EntityStoodOnLo]
    and  a
    ret  z                                             ; player is on foot - hold still
.jr_02_6484:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip
.jr_02_648A:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    ld   a,[hl]
    and  a
    ret  z                                             ; already all the way up
    dec  [hl]
    ld   bc,$FFFF
    jp   call_00_37d8_Entity_MoveY                     ; climb 1px, and do not patrol

call_02_649c_EntityAction_RezopolisMovingPlatform_Update:
; The ordinary ungated patrolling platform - prologue, move, patrol
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_64A8
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_64A8:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

; ------------------------------------------------------------------
; RED PLATFORMS - two entities, one that responds to being STOOD ON and one that
; responds to the TAILSPIN CHARGE. Both write FACING_FLAGS = $80 every frame
; (SPRITE_FLAG bit 7 in the OAM attribute byte - the CGB VRAM bank select), and
; both keep their whole state machine in MISC_FLAGS bits 0-2 with MISC_TIMER_1 as
; a sub-tick counter and MISC_TIMER_2 as the distance travelled
; ------------------------------------------------------------------

call_02_64ae_EntityAction_RedPlatform_Update:
; Descends under the player and creeps back up when he leaves. Travel is $0D steps
; at one pixel per four frames.
;
;   flags clear   at rest. Stepping on starts a descent - or, if it is part way
;                 home, a $3C-frame pause first
;   bit 0 set     descending. At the far end, if the player has already gone, it
;                 pauses for $F0 frames
;   bit 1 set     paused. When the pause ends it TOGGLES bit 0 and clears
;                 everything else, so a pause always reverses the direction
    ld   c,$80
    call call_00_3290_Entity_SetFacingDirection
    call call_00_34f5_Entity_IsPlayerStandingOnSelf    ; HL = $17 MISC_FLAGS, B = ridden
    bit  1,[hl]
    jr   nz,.jr_02_64DA                                ; paused
    bit  0,[hl]
    jr   z,.jr_02_64E7                                 ; at rest
; Descending
    inc  l                                             ; $18 sub-tick
    dec  [hl]
    ret  nz
    ld   [hl],$04                                      ; one step every 4 frames
    inc  l                                             ; $19 travel
    ld   a,[hl]
    cp   a,$0D
    jr   z,.jr_02_64D0                                 ; fully extended
    inc  [hl]
    ld   bc,$0001
    jp   call_00_37d8_Entity_MoveY
.jr_02_64D0:
    bit  0,b
    ret  nz                                            ; still ridden - stay down
    dec  l
    ld   [hl],$f0                                      ; long pause before returning
    dec  l
    set  1,[hl]
    ret
.jr_02_64DA:
; Paused. On expiry, invert bit 0 and clear the rest - so pause always flips
; between descending and returning
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    dec  l
    ld   a,[hl]
    and  a,$01
    xor  a,$01
    ld   [hl],a
    ret
.jr_02_64E7:
; At rest. Only the player stepping on starts anything
    bit  0,b
    jr   z,.jr_02_64FF
    inc  l
    inc  l                                             ; $19 travel
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_64F8                                ; part way home - short pause first
    dec  l
    ld   [hl],$3C
    dec  l
    set  1,[hl]
    ret
.jr_02_64F8:
    dec  l
    ld   [hl],$01
    dec  l
    ld   [hl],$01                                      ; flags = bit 0 only: descend
    ret
.jr_02_64FF:
; Unridden and not extended all the way: creep back up at the same rate
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    inc  l
    ld   a,[hl]
    and  a
    ret  z                                             ; already home
    dec  [hl]
    ld   bc,$FFFF
    jp   call_00_37d8_Entity_MoveY

call_02_650f_EntityAction_ActivatedRedPlatform_Update:
; The same idea driven by the machine rather than by weight: it does nothing at
; all until wD617_TailSpinChargeCounter is at its maximum $40, and then runs one
; fixed cycle - rise $0D pixels, hold for $F0 frames, descend $0D pixels, idle.
;
; Unlike the plain red platform it moves a full pixel EVERY frame, and it never
; looks at the player again once it has started
    ld   c,$80
    call call_00_3290_Entity_SetFacingDirection
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   z,.jr_02_654F                                 ; idle
    bit  MISC_FLAGS_BIT_1,[hl]
    jr   nz,.jr_02_6544                                ; holding at the top
    bit  MISC_FLAGS_BIT_2,[hl]
    jr   nz,.jr_02_6535                                ; rising
; Descending back to the start
    inc  l
    dec  [hl]
    jr   nz,.jr_02_652F
    dec  l
    ld   [hl],$00                                      ; arrived - fully idle again
.jr_02_652F:
    ld   bc,$0001
    jp   call_00_37d8_Entity_MoveY
.jr_02_6535:
    inc  l
    dec  [hl]
    jr   nz,.jr_02_653E
    ld   [hl],$f0                                      ; reached the top - hold
    dec  l
    set  1,[hl]
.jr_02_653E:
    ld   bc,$ffff
    jp   call_00_37d8_Entity_MoveY
.jr_02_6544:
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$0D                                      ; hold over - come back down
    dec  l
    res  1,[hl]
    res  2,[hl]
    ret
.jr_02_654F:
    ld   a,[wD617_TailSpinChargeCounter]
    cp   a,$40
    ret  c                                             ; charge not full yet
    set  0,[hl]
    set  2,[hl]                                        ; activate, rising
    inc  l
    ld   [hl],$0D
    ret

call_02_655d_EntityAction_TailspinPlatform_Update:
; A platform you jack up by tail-spinning on it. It is the only entity that reads
; the PLAYER'S CURRENT ACTION directly - standing on it is not enough, the action
; has to be PLAYER_ACTION_TAIL_SPIN - and it rises one pixel per frame for as long
; as that holds.
;
; MISC_TIMER_2 / MISC_PARAM together are a 16-bit "height gained" counter, so the
; platform can remember more than 255 pixels of travel and sinks back through
; exactly the same distance when Gex stops. The rise stops at the top of the
; entity's own bounding box, compared in block coordinates
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  0,b
    jr   z,.jr_02_65A2                                 ; not ridden - sink
    ld   a,[wD201_Player_ActionId]
    and  a,PLAYER_ACTION_MASK
    cp   a,PLAYER_ACTION_TAIL_SPIN
    jr   nz,.jr_02_65A2                                ; just standing - sink
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   c,h                                           ; my block row
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    ld   l,a
    ld   h,$00
    ld   de,wD30C_EntityBoundingBoxYMin
    add  hl,de
    ld   a,[hl]
    cp   c
    ret  nc                                            ; already at the top of the span
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[hl]
    add  a,$01
    ldi  [hl],a
    ld   a,[hl]
    adc  a,$00
    ld   [hl],a                                        ; height gained += 1 (16-bit)
    ld   bc,$FFFF
    jp   call_00_37d8_Entity_MoveY
.jr_02_65A2:
    ld   a,l
    xor  a,$0D                                         ; $17 -> $1A MISC_PARAM
    ld   l,a
    ldd  a,[hl]
    or   [hl]
    ret  z                                             ; back at its resting height
    ld   a,[hl]
    sub  a,$01
    ldi  [hl],a
    ld   a,[hl]
    sbc  a,$00
    ld   [hl],a                                        ; height gained -= 1
    ld   bc,$0001
    jp   call_00_37d8_Entity_MoveY

; ------------------------------------------------------------------
; TAILSPIN GEAR - five actions that are five SPEEDS of the same spinning gear,
; distinguished only by their animation tick: $ff (stopped), then 4, 3, 2 and 1.
;
; Each action is three lines - drain or build the charge, load a "spin down"
; target in C and a "spin up" target in B, and fall into the shared selector. So
; the whole gear is a table expressed as code:
;
;   action     drains/builds   spin down to   spin up to
;   $00 Stopped    drain            $00           $01
;   $01 Slow       drain            $00           $02
;   $02 Medium     drain            $01           $03
;   $03 Fast       drain            $02           $04
;   $04 Full       BUILD            $03           $04
;
; Only the top speed raises wD617_TailSpinChargeCounter, and every other speed
; lowers it, so the charge is really a measure of how long the player has managed
; to hold the gear flat out
; ------------------------------------------------------------------

call_02_65b7_EntityAction_TailspinGear_Stopped:
    call call_02_6611_TailSpinGear_DrainCharge
    ld   c,$00
    ld   b,$01
    jr   call_02_65e2_TailSpinGear_SelectSpeed

call_02_65c0_EntityAction_TailspinGear_Slow:
    call call_02_6611_TailSpinGear_DrainCharge
    ld   c,$00
    ld   b,$02
    jr   call_02_65e2_TailSpinGear_SelectSpeed

call_02_65c9_EntityAction_TailspinGear_Medium:
    call call_02_6611_TailSpinGear_DrainCharge
    ld   c,$01
    ld   b,$03
    jr   call_02_65e2_TailSpinGear_SelectSpeed

call_02_65d2_EntityAction_TailspinGear_Fast:
    call call_02_6611_TailSpinGear_DrainCharge
    ld   c,$02
    ld   b,$04
    jr   call_02_65e2_TailSpinGear_SelectSpeed

call_02_65db_EntityAction_TailspinGear_Full:
; The only speed that feeds the charge counter
    call call_02_661b_TailSpinGear_BuildCharge
    ld   c,$03
    ld   b,$04
call_02_65e2_TailSpinGear_SelectSpeed:
; C = the speed to fall back to, B = the speed to step up to.
;
; MISC_FLAGS bit 0 is raised by .jr_03_50ac_CollisionHandler_Gear for exactly as
; long as Gex is TAIL SPINNING on the gear (interaction type $01), and cleared the
; moment he stops - so it is a live "is he on it right now" signal rather than a
; latch. With it set the gear takes B, without it C.
;
; Speeding up normally still waits for the current animation to finish, which is
; what makes the gear ramp rather than jump - except from a standstill (B = $01),
; which is special-cased to respond immediately
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   z,.jr_02_65F4
    ld   c,b                                           ; being spun - step up
    ld   a,b
    cp   a,$01
    jr   z,.jr_02_65fa                                 ; starting from stopped: no wait
.jr_02_65F4:
    push bc
    call call_00_3843_Entity_CheckAnimationEnded
    pop  bc
    ret  z                                             ; one speed change per revolution
.jr_02_65fa:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ACTION_ID
    ld   a,[hl]
    and  a,$1F
    cp   c
    ld   a,c
    ret  z                                             ; already at that speed
    call call_02_7102_Entity_SetAction
    ld   c,SFX_GEAR
    call call_00_112f_QueueSFX                         ; a clunk on every change
    ret

call_02_6611_TailSpinGear_DrainCharge:
; One unit off the shared charge, floored at zero
    ld   a,[wD617_TailSpinChargeCounter]
    and  a
    ret  z
    dec  a
    ld   [wD617_TailSpinChargeCounter],a
    ret

call_02_661b_TailSpinGear_BuildCharge:
; One unit on, capped at $40 - which is the level every consumer tests for
    ld   a,[wD617_TailSpinChargeCounter]
    cp   a,$40
    ret  nc
    inc  a
    ld   [wD617_TailSpinChargeCounter],a
    ret

call_02_6626_EntityAction_Unk6B_Update:
    ret

call_02_6627_EntityAction_Unk6C_Update:
    ret

call_02_6628_EntityAction_Unk6D_Update:
    ret

call_02_6629_EntityAction_GreenMonster_Walk:
; Action $00, the plain walker at speed $18. Actions $01 and $02 below have their
; own animations (data_02_7872 and data_02_7879) but no code anywhere selects them
    ld   c,$18
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ret

call_02_6632_EntityAction_GreenMonster_Unused1:
    ret

call_02_6633_EntityAction_GreenMonster_Unused2:
    ret

call_02_6634_EntityAction_Unk6F_Update:
    ret

call_02_6635_EntityAction_Unk70_Update:
; ENTITY_UNK_70. The label used to read _Unk6F_Update, duplicating the entry above
    ret

call_02_6636_EntityAction_Pincer_Update:
; One action and no movement at all: it just picks its orientation. Bit 0 of the
; spawn parameter MISC_TIMER_2 selects FACING_FLAGS $00 or $40, and $40 is the OAM
; Y-flip - so the level data decides whether each pincer hangs from the ceiling or
; stands on the floor, out of one set of tiles
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   c,$00
    bit  0,[hl]
    jr   z,.jr_02_6646
    ld   c,$40                                         ; OAM Y flip
.jr_02_6646:
    xor  a,$14                                         ; $19 -> $0D FACING_FLAGS
    ld   l,a
    ld   [hl],c
    ret

call_02_664b_EntityAction_Flamethrower_Update:
; Both flamethrower actions are bare `ret`s pointing at the SAME animation block,
; so the entity is purely an animated sprite and a collision box. Action $01 is
; unreachable
    ret

call_02_664c_EntityAction_Flamethrower_Unused:
    ret

call_02_664d_EntityAction_UFO_Patrol:
; One routine, two patrol axes, chosen by bit 0 of the spawn parameter
; MISC_TIMER_2 - the same "level data picks the axis" trick the pincer uses for
; its orientation. Speed $08 either way
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    bit  0,[hl]
    jr   nz,.jr_02_6662
    ld   c,$08
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_3760_Entity_PatrolY_FacingBased       ; vertical
    ret
.jr_02_6662:
    ld   c,$08
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked ; horizontal
    ret

call_02_666b_EntityAction_UFO_Unused:
    ret

call_02_666c_EntityAction_AntSpawner_Update:
; The other half of the Bugged Out bonus level. It produces ants only while BOTH
; conditions hold: there is still a collectible quota left, and the tailspin gear
; is being held at full charge. Each ant costs a $78-frame cooldown, and it will
; not let more than two exist at once.
;
; SFX_COLLECTIBLE on spawn rather than an enemy sound is the giveaway that the
; ants are the collectibles here
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],$20                                      ; always faces left
    xor  a,$1A                                         ; $0D -> $17 MISC_FLAGS
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_66B4                                ; cooling down
    ld   a,[wD649_CollectibleAmount]
    and  a
    ret  z                                             ; quota met - stop producing
    ld   a,[wD617_TailSpinChargeCounter]
    cp   a,$40
    ret  c                                             ; gear is not at full speed
    set  0,[hl]
    inc  l
    ld   [hl],$78                                      ; two seconds until the next one
    ld   c,$00
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_6691:
    ld   l,a
    ld   a,[hl]
    cp   a,$74                                         ; ENTITY_REZOPOLIS_ANT
    jr   nz,.jr_02_6698
    inc  c
.jr_02_6698:
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_6691
    ld   a,c
    cp   a,$02
    ret  nc                                            ; two already out
    ld   c,SPAWN_CHILD_ENTITY_ANT
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   c,SFX_COLLECTIBLE
    call call_00_112f_QueueSFX
    ret
.jr_02_66B4:
    inc  l
    dec  [hl]
    ret  nz
    dec  l
    res  0,[hl]
    ret

call_02_66bb_EntityAction_Ant_Update:
; The plain walker at speed $0C, plus an escape hatch: an ant that reaches block
; column $19-$20 removes itself. That is a fixed map position, not a bound from
; its spawn record, so it is the mouse hole at one end of the Bugged Out room -
; catch the ant before it gets there or the collectible is gone
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h                                           ; block column
    cp   a,$19
    jr   c,.jr_02_66D3
    cp   a,$21
    jp   c,call_00_3931_Entity_DeactivateSelf          ; reached the hole
.jr_02_66D3:
    ld   c,$0C
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

; ==================================================================
; CIRCUIT CENTRAL
;
; Entity ids $76 (ENTITY_CIRCUIT_CENTRAL_ANT) through $82
; (ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR). Action tables data_02_50f3 ..
; data_02_513b.
;
; Two ideas run through this channel that appear nowhere else in the file:
;
; SCRIPTED PATHS. Two entities move by replaying a list of steps out of ROM
; instead of by patrolling between bounds, and they do it in different formats:
;
;   ELECTRIC BALL     2-byte records (direction nibble, duration). Moves in whole
;                     pixels, and the $FF terminator DESPAWNS it
;   MOVING PLATFORM   3-byte records (duration, X velocity, Y velocity). Feeds the
;                     normal subpixel integrator, and the $FF terminator LOOPS the
;                     path from the start
;
; Both pick their path with a spawn parameter that indexes a small pointer table,
; so one entity type covers every route in the level.
;
; THE POWER-UP TIMER. wD751/wD752_Player_CircuitPowerUpTimer is the channel's
; equivalent of Rezopolis's tail spin charge: the powered platform will not start
; without it, and the powered walkway's collision handler will not energise a
; conveyor without it
; ==================================================================

call_02_66db_EntityAction_CircuitCentralAnt_Update:
; The plain walker at speed $0C - the same routine as the Rezopolis ant minus its
; mouse-hole check
    ld   c,$0C
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

call_02_66e3_EntityAction_Capacitor_Charge:
; The pumpkin's two-action hop again: build up through the animation, then launch.
; data_02_7bf9 loops its last frame, so the charge visibly pulses
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   c,$30
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_66f1_EntityAction_Capacitor_Hop:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3154_Entity_ClampYToMaxYBound
    ld   a,$00
    call nc,call_02_7102_Entity_SetAction
    ret

call_02_66fd_EntityAction_PowerUp_Upright:
; Two actions that share one animation block and differ only in the OAM attribute
; they leave behind: $00 upright, $60 flipped in both axes. Each hands to the
; other when the animation wraps, so the pick-up tumbles end over end out of four
; frames of artwork
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],$60                                      ; OAM X flip + Y flip
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6710_EntityAction_PowerUp_Flipped:
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],$00
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_6723_EntityAction_Unk79_Update:
    ret

call_02_6724_EntityAction_LittleRobot_Walk:
; Action $00, and a third variation on the carried-child pattern after the
; triceratops horn and the samurai head. The gear is spawned on the first frame
; and then pinned to the robot's exact position and facing every frame - no offset
; at all, so the two sprites are drawn on top of each other and only the gear's
; separate collision box makes it worth being an entity.
;
; The turn is animated: Entity_MoveXByFacingMomentum_BoundsChecked returns NZ on
; the frame the robot reaches a bound, and that switches to action $01
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6736
    ld   c,SPAWN_CHILD_ENTITY_LITTLE_ROBOT_GEAR
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
.jr_02_6736:
    ld   c,$08
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    call call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked
    ld   a,$01
    call nz,call_02_7102_Entity_SetAction              ; just turned around
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   e,[hl]
    inc  l
    ld   d,[hl]                                        ; DE = my X
    xor  a,$03                                         ; $0E -> $0D FACING_FLAGS
    ld   l,a
    ld   c,[hl]                                        ; C = my facing
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_6754:
    ld   l,a
    ld   a,[hl]
    cp   a,$7B                                         ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    jr   z,.jr_02_6760
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_6754
    ret                                                ; no gear - carry on regardless
.jr_02_6760:
    ld   a,l
    or   a,$0E
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d                                        ; gear X = my X
    xor  a,$03
    ld   l,a
    ld   [hl],c                                        ; gear facing = my facing
    ret

call_02_676c_EntityAction_LittleRobot_Turn:
; Action $01. Plays the turn animation, then straight back to walking
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$00
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_6775_EntityAction_LittleRobotGear_Update:
; The gear does not move itself at all - the robot positions it. Its only job is
; to notice when its robot is gone and take itself out of the slot, which is the
; mirror image of the samurai body checking for its head
    ld   h,$D2
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_6779:
    ld   l,a
    ld   a,[hl]
    cp   a,$7A                                         ; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    ret  z
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_6779
    jp   call_00_3910_Entity_ClearSlot                 ; robot destroyed - follow it

; ------------------------------------------------------------------
; ELECTRIC BALL - flies a route scripted in ROM rather than patrolling. Three
; fields carry the playback state:
;
;   MISC_TIMER_2  which route, chosen by the spawn record. Indexes the ten-entry
;                 pointer table .data_02_683c
;   MISC_PARAM    how far along that route it is
;   MISC_FLAGS    the current direction, in its HIGH NIBBLE
;   MISC_TIMER_1  frames left on the current step
;
; The direction nibble is a d-pad bitmask - bit 0 right, bit 1 left, bit 2 up,
; bit 3 down - and .data_02_67ce turns it into a velocity, with right beating left
; and down beating up when both are set
; ------------------------------------------------------------------

call_02_6786_EntityAction_ElectricBall_WaitForCue:
; Action $00. Holds still (data_02_7c25 has SPRITE_FLAG_INVISIBLE) until the frame
; counter matches MISC_PARAM_HI, then rewinds the route to step 0 and starts it
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM_HI
    ld   a,[wD73B_VBlankFrameCounter]
    cp   [hl]                                          ; my phase in the 256-frame cycle
    ret  nz
    dec  l                                             ; $1A MISC_PARAM
    ld   [hl],$00                                      ; back to the start of the route
    call call_02_680e_ElectricBall_NextPathStep
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_679e_EntityAction_ElectricBall_FollowPath:
; Action $01. Move by whatever the current direction says, and pull the next step
; when the step timer runs out. Note this moves in WHOLE PIXELS through
; Entity_MoveX / Entity_MoveY rather than through the velocity fields, so the ball
; does not accelerate and is not affected by the patrol driver at all
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    ld   a,[hl]
    rrca
    rrca
    and  a,$3C                                         ; high nibble * 4 = record offset
    ld   e,a
    ld   d,$00
    ld   hl,.data_02_67ce
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    inc  hl
    push bc                                            ; BC = dX
    ld   c,[hl]
    inc  hl
    ld   b,[hl]                                        ; BC = dY
    call call_00_37d8_Entity_MoveY
    pop  bc
    call call_00_37c9_Entity_MoveX
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_1
    dec  [hl]
    call z,call_02_680e_ElectricBall_NextPathStep
    ret
.data_02_67ce:
; The direction nibble expanded into movement: 16 records of (signed 16-bit dX,
; signed 16-bit dY), indexed by the nibble directly. Everything travels 2 pixels a
; frame, record 0 is the standstill, and the four low bits are
; BALL_PATH_RIGHT / _LEFT / _UP / _DOWN in that order.
;
; Note the table is fully populated even though the routes only ever use five of
; the sixteen entries, and that conflicting bits do not cancel - right wins over
; left, down wins over up. That is why indices $0C-$0F duplicate $08-$0B
    db   $00, $00, $00, $00                            ; $0  -        still
    db   $02, $00, $00, $00                            ; $1  R        right
    db   $fe, $ff, $00, $00                            ; $2  L        left
    db   $02, $00, $00, $00                            ; $3  L+R      right
    db   $00, $00, $fe, $ff                            ; $4  U        up
    db   $02, $00, $fe, $ff                            ; $5  R+U      right + up
    db   $fe, $ff, $fe, $ff                            ; $6  L+U      left  + up
    db   $02, $00, $fe, $ff                            ; $7  L+R+U    right + up
    db   $00, $00, $02, $00                            ; $8  D        down
    db   $02, $00, $02, $00                            ; $9  R+D      right + down
    db   $fe, $ff, $02, $00                            ; $A  L+D      left  + down
    db   $02, $00, $02, $00                            ; $B  L+R+D    right + down
    db   $00, $00, $02, $00                            ; $C  U+D      down
    db   $02, $00, $02, $00                            ; $D  R+U+D    right + down
    db   $fe, $ff, $02, $00                            ; $E  L+U+D    left  + down
    db   $02, $00, $02, $00                            ; $F  L+R+U+D  right + down

call_02_680e_ElectricBall_NextPathStep:
; Reads one 2-byte record - (direction nibble, duration) - from the route selected
; by MISC_TIMER_2 and advances the step counter. A direction byte of $FF is the
; end of the route, and the ball frees its slot rather than looping
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   c,[hl]                                        ; C = step index
    inc  [hl]                                          ; and advance it
    dec  l                                             ; $19 MISC_TIMER_2 = route id
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_683c
    add  hl,de
    ld   e,[hl]
    inc  hl
    ld   d,[hl]                                        ; DE = start of that route
    ld   l,c
    ld   h,$00
    add  hl,hl                                         ; step * 2
    add  hl,de
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_MISC_FLAGS
    ldi  a,[hl]
    cp   a,$ff
    jp   z,call_00_3910_Entity_ClearSlot               ; route finished
    ld   [de],a                                        ; MISC_FLAGS = direction
    inc  e                                             ; $18 MISC_TIMER_1
    ld   a,[hl]
    ld   [de],a                                        ; = how long to hold it
    ret
.data_02_683c:
; Ten routes, selected by the ball's MISC_TIMER_2 spawn parameter. Each is a run of
; (direction, frames) pairs terminated by BALL_PATH_END; see the BALL_PATH_*
; constants for the direction bits.
;
; Every route runs left to right, and none of them uses BALL_PATH_LEFT at all - the
; balls only ever cross the screen one way. Where a route needs to travel further
; than 255 frames in a straight line it just repeats the step, which is why route 5
; and route 9 have runs of consecutive RIGHTs
    dw   .data_02_6850_Route0
    dw   .data_02_6857_Route1
    dw   .data_02_685e_Route2
    dw   .data_02_6865_Route3
    dw   .data_02_6870_Route4
    dw   .data_02_6883_Route5
    dw   .data_02_688a_Route6
    dw   .data_02_688d_Route7
    dw   .data_02_6898_Route8
    dw   .data_02_689f_Route9

.data_02_6850_Route0:
; Straight, one dip, straight
    db   BALL_PATH_RIGHT,               $2e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $3c
    db   BALL_PATH_END

.data_02_6857_Route1:
; The same shape with a longer run in and a deeper dip
    db   BALL_PATH_RIGHT,               $3e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$20
    db   BALL_PATH_RIGHT,               $5c
    db   BALL_PATH_END

.data_02_685e_Route2:
    db   BALL_PATH_RIGHT,               $5e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $2c
    db   BALL_PATH_END

.data_02_6865_Route3:
; Two descending steps
    db   BALL_PATH_RIGHT,               $4e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $70
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$20
    db   BALL_PATH_RIGHT,               $5c
    db   BALL_PATH_END

.data_02_6870_Route4:
; Down two steps and back up two - a shallow valley
    db   BALL_PATH_RIGHT,               $5e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $40
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $50
    db   BALL_PATH_RIGHT|BALL_PATH_UP,  $10
    db   BALL_PATH_RIGHT,               $40
    db   BALL_PATH_RIGHT|BALL_PATH_UP,  $10
    db   BALL_PATH_RIGHT,               $0c
    db   BALL_PATH_END

.data_02_6883_Route5:
; Dead level all the way across. Split into three steps only because a single
; duration byte cannot hold $2CE frames
    db   BALL_PATH_RIGHT,               $ee
    db   BALL_PATH_RIGHT,               $f0
    db   BALL_PATH_RIGHT,               $8c
    db   BALL_PATH_END

.data_02_688a_Route6:
; The shortest route: one level dash
    db   BALL_PATH_RIGHT,               $6a
    db   BALL_PATH_END

.data_02_688d_Route7:
; Down one step, back up one
    db   BALL_PATH_RIGHT,               $3e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $2c
    db   BALL_PATH_RIGHT|BALL_PATH_UP,  $10
    db   BALL_PATH_RIGHT,               $20
    db   BALL_PATH_END

.data_02_6898_Route8:
    db   BALL_PATH_RIGHT,               $2e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $1c
    db   BALL_PATH_END

.data_02_689f_Route9:
; The long one - sixteen steps weaving down and up across the whole room
    db   BALL_PATH_RIGHT,               $6e
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$20
    db   BALL_PATH_RIGHT,               $4c
    db   BALL_PATH_RIGHT|BALL_PATH_UP,  $20
    db   BALL_PATH_RIGHT,               $54
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $4c
    db   BALL_PATH_RIGHT|BALL_PATH_UP,  $10
    db   BALL_PATH_RIGHT,               $30
    db   BALL_PATH_RIGHT|BALL_PATH_UP,  $20
    db   BALL_PATH_RIGHT,               $f0
    db   BALL_PATH_RIGHT,               $54
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $40
    db   BALL_PATH_RIGHT|BALL_PATH_DOWN,$10
    db   BALL_PATH_RIGHT,               $5c
    db   BALL_PATH_END

call_02_68c0_EntityAction_CircuitCentralMovingPlatform_Update:
; The other scripted-path entity, and the more capable of the two: instead of
; moving in whole pixels it writes X and Y VELOCITIES and lets
; Entity_ApplyVelocityXY_SubpixelBoth integrate them, so it can travel at
; fractional speeds and it carries the player the way any platform does.
;
;   MISC_TIMER_2  which route, from the four-entry table .data_02_6915
;   MISC_PARAM    step index within it
;   MISC_PARAM_HI frames left on this step - counted down here, not by the engine
;
; A $FF duration LOOPS the route rather than despawning, which is what makes these
; platforms run their circuit forever
    call call_00_34ea_Entity_IsFirstFrameOfAction
    call nz,.jr_02_68D6                                ; load the first step
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM_HI
    dec  [hl]
    call z,.jr_02_68D6                                 ; step expired - fetch the next
    ret
.jr_02_68D6:
; Fetch one 3-byte record: (duration, X velocity, Y velocity)
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   c,[hl]                                        ; C = step index
    inc  [hl]
    dec  l                                             ; $19 MISC_TIMER_2 = route id
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_6915
    add  hl,de
    ld   e,[hl]
    inc  hl
    ld   d,[hl]                                        ; DE = start of that route
    ld   b,$00
    ld   l,c
    ld   h,b
    add  hl,hl
    add  hl,bc                                         ; step * 3
    add  hl,de
    LOAD_OBJ_FIELD_TO_DE ENTITY_FIELD_MISC_PARAM_HI
    ldi  a,[hl]
    cp   a,$ff
    jr   z,.jr_02_6909                                 ; end of route - wrap round
    ld   [de],a                                        ; $1B = duration
    inc  e                                             ; $1C X_VELOCITY
.jr_02_6902:
    ldi  a,[hl]
    ld   [de],a
    inc  e
    inc  e                                             ; skip $1D, land on $1E
    ld   a,[hl]
    ld   [de],a                                        ; $1E Y_VELOCITY
    ret
.jr_02_6909:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   [hl],$00                                      ; rewind and take step 0
    jr   .jr_02_68D6
.data_02_6915:
; Four routes, selected by the platform's MISC_TIMER_2 spawn parameter. Each is a
; run of (frames, X velocity, Y velocity) triples terminated by PLATFORM_PATH_LOOP,
; which rewinds to step 0 rather than despawning - these platforms circle forever.
;
; The velocities go straight into the entity's velocity fields, so $10 is one pixel
; a frame right or down and $F0 one pixel a frame left or up. Every route's steps
; sum to zero on both axes, which they have to: a route that did not close would
; walk the platform off its own track a little further on every lap
    dw   .data_02_691d_Route0
    dw   .data_02_692a_Route1
    dw   .data_02_6943_Route2
    dw   .data_02_695c_Route3

.data_02_691d_Route0:
; A diamond: 224 up-right, 160 down-right, 160 up-left, 224 down-left
    db   $e0, $10, $f0                                 ; 224f  right + up
    db   $a0, $10, $10                                 ; 160f  right + down
    db   $a0, $f0, $f0                                 ; 160f  left  + up
    db   $e0, $f0, $10                                 ; 224f  left  + down
    db   PLATFORM_PATH_LOOP

.data_02_692a_Route1:
; Straight back and forth, 512 pixels each way. Split into four steps per leg only
; because a duration byte tops out at 255
    db   $80, $f0, $00                                 ; 128f  left
    db   $80, $f0, $00                                 ; 128f  left
    db   $80, $f0, $00                                 ; 128f  left
    db   $80, $f0, $00                                 ; 128f  left
    db   $80, $10, $00                                 ; 128f  right
    db   $80, $10, $00                                 ; 128f  right
    db   $80, $10, $00                                 ; 128f  right
    db   $80, $10, $00                                 ; 128f  right
    db   PLATFORM_PATH_LOOP

.data_02_6943_Route2:
; Out to the left, up and back along the top, then straight down to the start
    db   $e0, $f0, $00                                 ; 224f  left
    db   $e0, $f0, $00                                 ; 224f  left
    db   $20, $f0, $00                                 ;  32f  left
    db   $80, $10, $f0                                 ; 128f  right + up
    db   $80, $10, $f0                                 ; 128f  right + up
    db   $e0, $10, $00                                 ; 224f  right
    db   $80, $00, $10                                 ; 128f  down
    db   $80, $00, $10                                 ; 128f  down
    db   PLATFORM_PATH_LOOP

.data_02_695c_Route3:
; A zig-zag: three diagonal legs climbing, three descending, all 224 frames
    db   $e0, $f0, $f0                                 ; 224f  left  + up
    db   $e0, $10, $f0                                 ; 224f  right + up
    db   $e0, $f0, $f0                                 ; 224f  left  + up
    db   $e0, $10, $10                                 ; 224f  right + down
    db   $e0, $f0, $10                                 ; 224f  left  + down
    db   $e0, $10, $10                                 ; 224f  right + down
    db   PLATFORM_PATH_LOOP

; ------------------------------------------------------------------
; POWERED PLATFORM - the Toon TV moving block's round-trip machine again
; (call_02_5b47_EntityAction_ToonTVMovingBlock_Run), with the switch replaced by
; the Circuit Central power-up: it needs Gex aboard AND his power-up timer
; running before it will move, and it recognises a completed lap the same way, by
; comparing the live direction bits 7/6 against the starting copy in bits 5/4
; ------------------------------------------------------------------

call_02_696f_EntityAction_CircuitCentralPoweredPlatform_Idle:
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_697B
    ld   a,l
    xor  a,$10                                         ; $09 -> $19 MISC_TIMER_2
    ld   l,a
    ldd  a,[hl]
    dec  l                                             ; -> $17 MISC_FLAGS
    ld   [hl],a                                        ; patrol config from the spawn record
.jr_02_697B:
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  0,b
    ret  z                                             ; nobody aboard
    ld   a,[wD751_Player_CircuitPowerUpTimerLo]
    ld   e,a
    ld   a,[wD752_Player_CircuitPowerUpTimerHi]
    or   e
    ret  z                                             ; no power
    set  2,[hl]                                        ; armed
    set  0,[hl]                                        ; running
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6993_EntityAction_CircuitCentralPoweredPlatform_Run:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_3,[hl]
    jr   z,.jr_02_69BE                                 ; never stops - just run
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   nz,.jr_02_69BE                                ; mid-leg
    ld   a,[hl]
    and  a,$c0
    ld   c,a                                           ; C = current direction, bits 7/6
    ld   a,[hl]
    rlca
    rlca
    and  a,$c0                                         ; start direction, bits 5/4 -> 7/6
    sub  c
    jr   nz,.jr_02_69B6                                ; far end - pause and come back
    res  MISC_FLAGS_BIT_2,[hl]                         ; home again - disarm
    ld   a,$00
    jp   call_02_7102_Entity_SetAction
.jr_02_69B6:
    inc  l
    ld   [hl],$B4                                      ; three seconds at the far end
    ld   a,$02
    jp   call_02_7102_Entity_SetAction
.jr_02_69BE:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_69c4_EntityAction_CircuitCentralPoweredPlatform_PauseAtEnd:
    call call_00_3817_Entity_DecrementMiscTimer
    ret  nz
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    set  MISC_FLAGS_BIT_0,[hl]                         ; let the patrol driver move it again
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_69d7_EntityAction_CircuitCentralLoweringPlatform_Update:
; Instruction for instruction the Rezopolis red platform
; (call_02_64ae_EntityAction_RedPlatform_Update), with two differences: the travel
; is $20 steps rather than $0D, and it does not force FACING_FLAGS. Same three
; states in MISC_FLAGS bits 0 and 1, same one-pixel-per-four-frames rate, same
; "a pause always reverses the direction" trick
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  1,[hl]
    jr   nz,.jr_02_69FE                                ; paused
    bit  MISC_FLAGS_BIT_0,[hl]
    jr   z,.jr_02_6A0B                                 ; at rest
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    inc  l
    ld   a,[hl]
    cp   a,$20                                         ; fully lowered
    jr   z,.jr_02_69F4
    inc  [hl]
    ld   bc,$0001
    jp   call_00_37d8_Entity_MoveY
.jr_02_69F4:
    bit  0,b
    ret  nz
    dec  l
    ld   [hl],$f0
    dec  l
    set  1,[hl]
    ret
.jr_02_69FE:
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    dec  l
    ld   a,[hl]
    and  a,$01
    xor  a,$01
    ld   [hl],a
    ret
.jr_02_6A0B:
    bit  0,b
    jr   z,.jr_02_6A23
    inc  l
    inc  l
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_6A1C
    dec  l
    ld   [hl],$3C
    dec  l
    set  1,[hl]
    ret
.jr_02_6A1C:
    dec  l
    ld   [hl],$01
    dec  l
    ld   [hl],$01
    ret
.jr_02_6A23:
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    inc  l
    ld   a,[hl]
    and  a
    ret  z
    dec  [hl]
    ld   bc,$FFFF
    jp   call_00_37d8_Entity_MoveY

call_02_6a33_EntityAction_WalkerRobot_Update:
; The plain walker at speed $18
    ld   c,$18
    call call_00_32e1_Entity_NudgeXVelocityTowardC
    jp   call_00_36f7_Entity_MoveXByFacingMomentum_BoundsChecked

; ------------------------------------------------------------------
; THE POWERED WALKWAYS - a conveyor is three things working together, and none of
; them is the conveyor itself:
;
;   the WALKWAY entity ($81) does nothing at all in its action. Its collision
;     handler (.jr_03_5129) is what matters: touching it while the power-up timer
;     is running writes $06 into one of the three wD5A3_ConveyorState slots
;   the ANIMATED TILE code in bank03_map_tile_anim.asm reads those slots and
;     swaps the belt tiles for blank ones when the slot is empty, which is the
;     only reason a running belt looks different from a stopped one
;   the ACTIVATOR entity ($82) reads the same slot and turns itself solid or
;     intangible to match
;
; MISC_TIMER_2 is the 1-based conveyor number, and both the walkway and its
; activator carry the same one so they refer to the same slot
; ------------------------------------------------------------------

call_02_6a3b_EntityAction_PoweredWalkway_Update:
; No behaviour - see the note above; everything happens in its collision handler
    ret

call_02_6a3c_EntityAction_WalkwayActivator_Update:
; Two jobs. First, existence: its collision width becomes $10 while its conveyor
; slot is energised and 0 while it is not, so the entity is only tangible on a
; running belt.
;
; Second, and unusually, it TRACKS THE PLAYER - while Gex is inside the
; activator's X span it copies his world X onto itself every frame. So it is not
; something to stand on that moves; it is a box that follows him along the belt
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   l,[hl]
    dec  l                                             ; conveyor number, 1-based
    ld   h,$00
    ld   de,wD5A3_ConveyorState1
    add  hl,de
    ld   c,$00
    ld   a,[hl]
    and  a
    jr   z,.jr_02_6A54                                 ; belt stopped - no collision
    ld   c,$10
.jr_02_6A54:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_COLLISION_WIDTH
    ld   [hl],c
    ld   hl,wD20E_Player_XPositionLo
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   c,h                                           ; player block column
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    ld   l,a
    ld   h,$00
    ld   de,wD309_EntityBoundingBoxXMax
    add  hl,de
    ldi  a,[hl]
    cp   c
    ret  c                                             ; player past the right end
    ld   a,c
    cp   [hl]
    ret  c                                             ; player before the left end
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ld   a,[wD20E_Player_XPositionLo]
    ldi  [hl],a
    ld   a,[wD20F_Player_XPositionHi]
    ld   [hl],a                                        ; sit exactly on him
    ret

; ==================================================================
; CHANNEL Z
;
; Entity ids $83 (ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE) through $8F
; (ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM). Action tables data_02_513f ..
; data_02_51b3.
;
; THE GUNS. Three entity types share one small library of helpers below. There is
; no gun entity - each of these IS the shot, sitting invisible at the muzzle until
; its turn in a shared 64-frame cycle comes round, firing, and rebuilding itself
; at the muzzle afterwards. Bit 0 of MISC_PARAM says which way the gun points, and
; it flips three things at once: the initial nudge off the muzzle, whether gravity
; is taken from call_00_30af (falls) or call_00_30da (rises), and which end of the
; bounding box counts as the end of the shot.
;
; THE FINAL BATTLE. Rez, the two buttons, the things the buttons drop and the fire
; that trails him are five entities coordinated through one WRAM byte,
; wD616_FinalBattleButtonFlags. See the note above
; call_02_6c18_EntityAction_Rez_Intro
; ==================================================================

call_02_6a8b_EntityAction_ArcedGunProjectile_WaitForCue:
; Action $00. Every gun in the room shares a 64-frame clock and each holds its own
; slot in it in MISC_TIMER_2, so a bank of guns fires in sequence
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$3F
    cp   [hl]
    ret  nz
    call call_02_6bcd_GunProjectile_Fire
    ld   c,$02
    call call_00_3350_Entity_SetXVelocity
    ld   c,$30
    call call_00_335a_Entity_SetYVelocity
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6aac_EntityAction_ArcedGunProjectile_Arc:
; Action $01. Flies forward at a constant speed while gravity bends it, and blows
; up either when it reaches the far end of its span (carry clear from the clamp)
; or when the collision handler has flagged a hit.
;
; The two halves are mirror images. MISC_PARAM bit 0 clear is a ceiling-mounted
; gun: it uses the INVERTED gravity helper, so the shot curves upward and stops at
; the top of the span. Bit 0 set is floor-mounted and behaves normally
    call call_00_3442_Entity_MoveXByFacingSpeed
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    bit  0,[hl]
    jr   nz,.jr_02_6AC4
    call call_00_30da_Entity_ApplyGravityMoveY_WithFloorCollision
    jp   nc,call_02_6c03_GunProjectile_Explode         ; reached the ceiling
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit
.jr_02_6AC4:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    ld   bc,hFFF1                                      ; -$0F: floor a little high
    call call_00_316e_Entity_ClampYToMaxYBound_Offset
    jp   nc,call_02_6c03_GunProjectile_Explode         ; reached the floor
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit

call_02_6ad3_EntityAction_ArcedGunProjectile2_WaitForCue:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$3F
    cp   [hl]
    ret  nz
    call call_02_6bcd_GunProjectile_Fire
    ld   c,$02
    call call_00_3350_Entity_SetXVelocity
    ld   c,$30
    call call_00_335a_Entity_SetYVelocity
    ld   c,$f0
    call call_00_3802_Entity_SetMiscTimer
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6af9_EntityAction_ArcedGunProjectile2_Arc:
    call call_00_3442_Entity_MoveXByFacingSpeed
    call call_00_3817_Entity_DecrementMiscTimer
    jp   z,call_02_6c03_GunProjectile_Explode
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    bit  0,[hl]
    jr   nz,.jr_02_6B17
    call call_00_30da_Entity_ApplyGravityMoveY_WithFloorCollision
    jp   nc,call_02_6c03_GunProjectile_Explode
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit
.jr_02_6B17:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    call call_00_3345_Entity_CheckIfYVelocityIsZero
    bit  7,a
    ld   a,$02
    jp   nz,call_02_7102_Entity_SetAction
    ld   bc,hFFF1
    call call_00_316e_Entity_ClampYToMaxYBound_Offset
    jp   nc,call_02_6c03_GunProjectile_Explode
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit

call_02_6b30_EntityAction_ArcedGunProjectile2_Hover:
; Action $02, and what makes this variant different from the plain arced shot: at
; the top of its arc gravity STOPS. It sails on level while the fuse burns, and
; drops out of the sky the moment Gex passes within 8 pixels underneath - or when
; the fuse runs out, whichever comes first
    call call_00_3442_Entity_MoveXByFacingSpeed
    call call_00_3817_Entity_DecrementMiscTimer
    jr   z,.jr_02_6B3E                                 ; fuse expired
    ld   c,$08
    call call_00_3859_Entity_CheckPlayerXProximity
    ret  nc                                            ; he is not underneath yet
.jr_02_6B3E:
    ld   a,$03
    jp   call_02_7102_Entity_SetAction

call_02_6b43_EntityAction_ArcedGunProjectile2_Drop:
    call call_00_3442_Entity_MoveXByFacingSpeed
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    bit  0,[hl]
    jr   nz,.jr_02_6B5B
    call call_00_30da_Entity_ApplyGravityMoveY_WithFloorCollision
    jp   nc,call_02_6c03_GunProjectile_Explode
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit
.jr_02_6B5B:
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    ld   bc,hFFF1
    call call_00_316e_Entity_ClampYToMaxYBound_Offset
    jp   nc,call_02_6c03_GunProjectile_Explode
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit

call_02_6b6a_EntityAction_GunProjectile_WaitForCue:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$3F
    cp   [hl]
    ret  nz
    call call_02_6bcd_GunProjectile_Fire
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6b81_EntityAction_GunProjectile_Fly:
; Action $01. The straight shot: no gravity, just a Y velocity ramped towards
; $30 (up) or $D0 (down) depending on which way the gun points, and it explodes
; when its own block row reaches the matching end of its bounding box. Compared
; per BLOCK rather than per pixel, so the shot has to land exactly on that row -
; which it does, because the velocity is a whole number of pixels by then
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   c,[hl]
    xor  a,$0A
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   b,h
    bit  0,c
    jr   z,.jr_02_6baf
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   de,wD30C_EntityBoundingBoxYMin
    add  hl,de
    ld   a,[hl]
    cp   b
    jr   z,call_02_6c03_GunProjectile_Explode
    ld   c,$D0
    jr   .jr_02_6bc4
.jr_02_6baf:
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca
    rrca
    rrca
    and  a,$1C
    ld   l,a
    ld   h,$00
    ld   de,wD30B_EntityBoundingBoxYMax
    add  hl,de
    ld   a,[hl]
    cp   b
    jr   z,call_02_6c03_GunProjectile_Explode
    ld   c,$30
.jr_02_6bc4:
    call call_00_3316_Entity_NudgeYVelocityTowardC_Signed
    call call_00_3597_Entity_ApplyVelocityXY_Subpixel_NoPlayerPush
    jp   call_02_6bf8_GunProjectile_ExplodeIfHit

call_02_6bcd_GunProjectile_Fire:
; Shared by all three gun types on the frame they go off: make a noise, become
; dangerous, wipe the velocity block, and step $10 pixels clear of the muzzle in
; whichever direction MISC_PARAM bit 0 says.
;
; Note the fourth store is `ld [hl],a`, not `ldi` - so L stops at $1F, and the
; `xor $05` that follows reaches $1A MISC_PARAM. With four `ldi`s it would have
; run into the next entity slot
    ld   c,SFX_GUN_PROJECTILE
    call call_00_112f_QueueSFX
    ld   c,COLLISION_TYPE_GUN_PROJECTILE
    call call_00_3825_Entity_SetCollisionType
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_X_VELOCITY
    xor  a
    ldi  [hl],a                                        ; $1C X_VELOCITY
    ldi  [hl],a                                        ; $1D X_SUBPIXEL
    ldi  [hl],a                                        ; $1E Y_VELOCITY
    ld   [hl],a                                        ; $1F Y_SUBPIXEL - no inc
    ld   a,l
    xor  a,$05                                         ; $1F -> $1A MISC_PARAM
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_6BF2
    ld   bc,$0010
    jp   call_00_37d8_Entity_MoveY                     ; muzzle below: step down
.jr_02_6BF2:
    ld   bc,hFFF0                                      ; -$10
    jp   call_00_37d8_Entity_MoveY                     ; muzzle above: step up

call_02_6bf8_GunProjectile_ExplodeIfHit:
; MISC_FLAGS bit 7 is the collision handler's "this shot hit something" flag.
; Falls straight through into the explode path when it is set
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_FLAGS
    bit  MISC_FLAGS_BIT_7,[hl]
    ret  z
call_02_6c03_GunProjectile_Explode:
; Hands over to a separate ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION entity and
; frees this slot, so the burst outlives the shot
    ld   c,SFX_REZ_PROJECTILE
    call call_00_112f_QueueSFX
    ld   c,SPAWN_CHILD_ENTITY_GUN_PROJECTILE_EXPLOSION
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    jp   call_00_3910_Entity_ClearSlot

; ------------------------------------------------------------------
; REZ - the final boss, and the only fight in the game with two halves.
;
; wD616_FinalBattleButtonFlags carries both of them in one byte: the low seven
; bits are the number of BUTTON SLAMS still needed, which Rez himself sets to $0A
; on his first frame, and bit 7 is a one-shot "a slam just landed" pulse raised by
; call_02_6d5d_EntityAction_FinalBattleButtonProjectile_Fall.
;
;   actions $00-$04   Rez chases Gex and can be attacked directly. Each hit costs
;                     him a point of MISC_PARAM_HI, which
;                     call_00_3251_Entity_UpdateFacingMomentumAndMoveX reads as his
;                     top speed - so he gets slower as the fight goes on, down to a
;                     floor of $18
;   actions $05-$08   .jr_03_516d_CollisionHandler_Rez ignores him entirely. The
;                     only way to hurt him now is the two buttons, and every slam
;                     takes one off the counter. At zero he drops the portal out
;                     and bursts
;
; Which half the fight starts in is decided by geometry: the intro action sends
; him straight to $08 if he spawns beyond block column $73, and to the chase
; otherwise
; ------------------------------------------------------------------

call_02_6c18_EntityAction_Rez_Intro:
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6C38
    ld   a,$0A
    ld   [wD616_FinalBattleButtonFlags],a              ; ten button slams to beat him
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_X
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h                                           ; my block column
    cp   a,$73
    ld   a,$08
    jp   nc,call_02_7102_Entity_SetAction              ; far side of the arena: button phase
.jr_02_6C38:
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$02
    jp   nz,call_02_7102_Entity_SetAction              ; otherwise: chase phase
    ret

call_02_6c41_EntityAction_Rez_Unused1:
; Action $01. Nothing selects it
    ret

call_02_6c42_EntityAction_Rez_Recover:
; Action $03. Plays the get-up animation and then FALLS THROUGH into the chase
; below, so Rez is already moving again during the recovery rather than standing
; still through it
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$02
    call nz,call_02_7102_Entity_SetAction
call_02_6c4a_EntityAction_Rez_Chase:
; Action $02. Homes in on Gex on both axes, but at very different rates: X uses
; the momentum path, so he accelerates smoothly up to the top speed in
; MISC_PARAM_HI, while Y creeps one pixel every FOURTH frame towards 8 pixels
; above the player. The vertical tracking is deliberately slow enough to jump over
    ld   a,[wD73B_VBlankFrameCounter]
    and  a,$03
    jr   nz,.jr_02_6C7C                                ; vertical step only 1 frame in 4
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ld   e,[hl]
    inc  l
    ld   d,[hl]                                        ; DE = my Y
    ld   a,[wD210_Player_YPositionLo]
    sub  a,$08
    ld   l,a
    ld   a,[wD211_Player_YPositionHi]
    sbc  a,$00
    ld   h,a                                           ; HL = target Y (8 above Gex)
    ld   bc,$0001                                      ; assume: move down
    ld   a,e
    sub  l
    ld   e,a
    ld   a,d
    sbc  h
    ld   d,a                                           ; DE = my Y - target
    jr   c,.jr_02_6C79                                 ; above the target - move down
    or   e
    jr   z,.jr_02_6C7C                                 ; exactly on it - hold
    ld   bc,$FFFF                                      ; below it - move up
.jr_02_6C79:
    call call_00_37d8_Entity_MoveY
.jr_02_6C7C:
    call call_00_36bd_Entity_FaceTowardsPlayer
    jp   call_00_3251_Entity_UpdateFacingMomentumAndMoveX

call_02_6c82_EntityAction_Rez_Hit:
; Action $04. The reaction to a direct attack, and where the fight is actually
; being scored in its first half: each hit shaves one off MISC_PARAM_HI, which is
; Rez's top chase speed, with $18 as the floor. He is never killed this way - it
; only ever wears him down
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    ld   a,$03
    call call_02_7102_Entity_SetAction
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM_HI    ; top speed
    ld   a,[hl]
    cp   a,$19
    ret  c                                             ; already as slow as he gets
    dec  [hl]
    ret

call_02_6c99_EntityAction_Rez_Untouchable:
; Actions $05, $06, $07 and $08 - four identical rows sharing this routine and one
; animation. The collision handler ignores Rez completely in this range, so all he
; does is watch for a button slam
    call call_02_6ca7_Rez_CheckButtonSlam
    ret

call_02_6c9d_EntityAction_Rez_ButtonHit:
; Action $09. The flinch after a slam lands; when it finishes he goes back to $08
; and waits for the next one
    call call_00_3843_Entity_CheckAnimationEnded
    ld   a,$08
    jp   nz,call_02_7102_Entity_SetAction
    ret

call_02_6ca6_EntityAction_Rez_Unused10:
; Action $0A. The collision handler has a case for it, but no code ever selects it
    ret

call_02_6ca7_Rez_CheckButtonSlam:
; Consumes the pulse in bit 7 and takes one off the slam counter. The `dec [hl]`
; is what decides the fight: non-zero leaves him flinching, zero ends it - the
; portal is dropped where he stands and he bursts
    ld   hl,wD616_FinalBattleButtonFlags
    bit  7,[hl]
    ret  z                                             ; no slam this frame
    res  7,[hl]                                        ; consume the pulse
    dec  [hl]                                          ; one slam off the count
    ld   a,$09
    jp   nz,call_02_7102_Entity_SetAction              ; more to go - flinch
    ld   c,SPAWN_CHILD_ENTITY_REZ_PORTAL
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   c,SFX_REZ_PROJECTILE
    call call_00_112f_QueueSFX
    jp   call_00_3985_Entity_ParticleBurstInit         ; beaten

call_02_6cca_EntityAction_RezFollowingFire_Update:
; A trail of flame with no movement code of its own - it looks up Rez ($86) every
; frame and plants itself $09 pixels behind him (the side chosen by his facing) and
; $18 below. The same carried-child idea as the triceratops horn, except here the
; child does the carrying
    ld   h,$D2
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_6CCE:
    ld   l,a
    ld   a,[hl]
    cp   a,$86                                         ; ENTITY_CHANNEL_Z_REZ
    jr   z,.jr_02_6CDA
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_6CCE
    ret                                                ; no Rez - stay put
.jr_02_6CDA:
    ld   a,l
    or   a,$0D
    ld   l,a
    ld   a,[hl]
    push af
    ld   a,l
    xor  a,$03
    ld   l,a
    pop  af
    bit  5,a
    jr   nz,.jr_02_6CF3
    ldi  a,[hl]
    sub  a,$09
    ld   c,a
    ldi  a,[hl]
    sbc  a,$00
    ld   b,a
    jr   .jr_02_6CFB
.jr_02_6CF3:
    ldi  a,[hl]
    add  a,$09
    ld   c,a
    ldi  a,[hl]
    adc  a,$00
    ld   b,a
.jr_02_6CFB:
    ldi  a,[hl]
    add  a,$18
    ld   e,a
    ld   a,[hl]
    adc  a,$00
    ld   d,a
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ld   [hl],c
    inc  l
    ld   [hl],b
    inc  l
    ld   [hl],e
    inc  l
    ld   [hl],d
    ret

call_02_6d11_EntityAction_ChannelZUnusedPlatform1_Update:
; The ordinary ungated patrolling platform. Its neighbour below is a bare `ret`.
; Neither id appears in entity_list_channel_z.asm
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   z,.jr_02_6D1D
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6D1D:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip

call_02_6d23_EntityAction_ChannelZUnusedPlatform2_Update:
    ret

call_02_6d24_EntityAction_GunProjectileExplosion_Update:
; Plays once and frees its slot. What it does per frame is unusual: rather than
; drawing seven distinct frames it draws a handful of frames and REORIENTS them,
; reading the current animation index to pick an OAM flip and a visible/blank
; choice out of .data_02_6d4f. The blank entries are what make the burst flicker
    call call_00_3843_Entity_CheckAnimationEnded
    jp   nz,call_00_3910_Entity_ClearSlot
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_ANIM_FRAME_INDEX
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_6d4f
    add  hl,de
    ld   e,[hl]
    inc  hl
    ld   d,[hl]
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_FACING_FLAGS
    ld   [hl],e                                        ; OAM flip for this frame
    xor  a,$07                                         ; $0D -> $0A SPRITE_FLAGS
    ld   l,a
    ld   a,[hl]
    res  SPRITE_FLAG_INVISIBLE_BIT,a
    or   d                                             ; $08 = blank this frame
    ld   [hl],a
    ret
.data_02_6d4f:
; Per animation frame: (FACING_FLAGS, SPRITE_FLAG_INVISIBLE). $20 is an X flip and
; $08 blanks the frame outright
    db   $00, $00, $20, $00, $00, $00, $00, $08
    db   $20, $00, $00, $08, $00, $00

call_02_6d5d_EntityAction_FinalBattleButtonProjectile_Fall:
; What a button actually drops on Rez. It appears $98 above the button and $4C to
; one side (see .data_0a_7c92_EntityChildSpawnData), falls under gravity, and the
; moment it reaches block row $7D it raises the slam pulse and removes itself.
;
; That row is a fixed map coordinate, so the "hit" is not a collision test at all -
; the arena floor is where Rez has to be, and the projectile simply reaching it
; counts
    call call_00_30af_Entity_ApplyGravityAndMoveY_Clamped
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_WORLD_Y
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h                                           ; my block row
    cp   a,$7D
    ret  c                                             ; still falling
    ld   hl,wD616_FinalBattleButtonFlags
    set  7,[hl]                                        ; one slam, for Rez to consume
    ld   c,SFX_FINAL_BATTLE_BUTTON
    call call_00_112f_QueueSFX
    jp   call_00_3931_Entity_DeactivateSelf

call_02_6d7f_EntityAction_FinalBattleButtonProjectile_Unused:
    ret

call_02_6d80_EntityAction_FinalBattleButton_Ready:
; Action $00. Gex standing on the button fires it - but only while slams are still
; needed, so once Rez is beaten the buttons go dead. MISC_TIMER_2 tells the two
; buttons apart and picks which of the two child records to use, which is what
; sends their projectiles down opposite sides of the arena
    call call_00_34f5_Entity_IsPlayerStandingOnSelf
    bit  0,b
    ret  z
    ld   a,[wD616_FinalBattleButtonFlags]
    and  a,$7F                                         ; slams still required?
    ret  z
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_TIMER_2
    ld   a,[hl]
    cp   a,$01                                         ; which button am I?
    ld   c,SPAWN_CHILD_ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE_1
    jr   z,.jr_02_6D9D
    ld   c,SPAWN_CHILD_ENTITY_FINAL_BATTLE_BUTTON_PROJECTILE_2
.jr_02_6D9D:
    FARCALL call_0a_7b9a_EntitySpawn_SpawnChildEntity
    ld   bc,$0005
    call call_00_37d8_Entity_MoveY                     ; sink into the floor
    ld   c,SFX_REZ_BUTTON
    call call_00_112f_QueueSFX
    ld   a,$01
    jp   call_02_7102_Entity_SetAction

call_02_6db8_EntityAction_FinalBattleButton_Pressed:
; Action $01, and this is what makes the pair of buttons a puzzle rather than one
; button pressed twice: a pressed button will not rise again until the OTHER
; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON is also in action $01. So Gex has to run
; between the two, and the pair reset together
    ld   h,$D2
    ld   a,ENTITY_SLOT_FIRST_NPC
.jr_02_6DBC:
    ld   l,a
    ld   a,[hl]
    cp   a,$8C                                         ; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    jr   nz,.jr_02_6DC8
    ld   a,[wD300_CurrentEntityAddrLo]
    cp   l
    jr   nz,.jr_02_6DCE                                ; found the OTHER one
.jr_02_6DC8:
    ld   a,l
    add  a,ENTITY_SLOT_SIZE
    jr   nz,.jr_02_6DBC
    ret
.jr_02_6DCE:
    ld   a,l
    or   a,$01                                         ; its ACTION_ID
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$01
    ret  nz                                            ; partner still up - stay down
    ld   bc,$FFFB
    call call_00_37d8_Entity_MoveY                     ; rise back out of the floor
    ld   a,$00
    jp   call_02_7102_Entity_SetAction

call_02_6de3_EntityAction_RezPortal_Update:
; Dropped where Rez dies. When its animation finishes it ends the level: it clears
; the exit-button index and asks the player for PLAYER_ACTION_ENTER_TV_ALT, the
; same action a level's exit pad uses
    call call_00_3843_Entity_CheckAnimationEnded
    ret  z
    xor  a
    ld   [wD647_ExitTVButtonIndex],a
    ld   a,PLAYER_ACTION_ENTER_TV_ALT
    jp   call_02_4ccd_Player_RequestAction

call_02_6df0_EntityAction_Unk8E_Update:
    ret

call_02_6df1_EntityAction_MediaDimensionMovingPlatform_Update:
; The last entity in the table, and the only one that gates itself on overall game
; PROGRESS rather than on anything in the room: MISC_PARAM is a required mission
; remote count, and the platform stays frozen until wD64F_MissionRemoteTotal
; reaches it. $FF means ungated. That is how the hub opens up as the game is
; completed
    call call_00_34ea_Entity_IsFirstFrameOfAction
    jr   Z, .jr_02_6dfd
    ld   A, L
    xor  A, $10                                        ; $09 -> $19 MISC_TIMER_2
    ld   L, A
    ld   A, [HL-]
    dec  L                                             ; -> $17 MISC_FLAGS
    ld   [HL], A                                       ; patrol config from the spawn record
.jr_02_6dfd:
    LOAD_OBJ_FIELD_TO_HL ENTITY_FIELD_MISC_PARAM
    ld   A, [HL]
    cp   A, $ff
    jr   Z, .jr_02_6e11                                ; ungated
    ld   A, [wD64F_MissionRemoteTotal]
    and  A, $7f
    cp   A, [HL]
    ret  C                                             ; not enough remotes yet
.jr_02_6e11:
    call call_00_3559_Entity_ApplyVelocityXY_SubpixelBoth
    jp   call_00_318d_Entity_PlatformPatrol_WithBoundsAndFlip
    