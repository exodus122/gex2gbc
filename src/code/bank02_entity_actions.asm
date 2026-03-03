; Entity Action Pointer table
data_02_4ddb:                        ;; ENTITY_COLLECTIBLE_SPAWN
    dw   call_02_51b7_EntityAction_CollectibleSpawn_Update, data_02_7cce
data_02_4ddf:                        ;; ENTITY_TV_BUTTON
    dw   call_02_51ea_EntityAction_TVButton_unk0, data_02_7945
    dw   call_02_5252_EntityAction_TVButton_unk1, data_02_794b
data_02_4de7:                        ;; ENTITY_RED_REMOTE
    dw   call_02_5253_EntityAction_RedRemote_unk0, data_02_7690
    dw   call_02_526a_EntityAction_RedRemote_unk1, data_02_769d
data_02_4def:                        ;; ENTITY_SILVER_REMOTE
    dw   call_02_5284_EntityAction_SilverRemote_unk0, data_02_769d
    dw   call_02_528d_EntityAction_SilverRemote_unk1, data_02_769d
data_02_4df7:                        ;; ENTITY_GOLD_REMOTE
    dw   call_02_528e_EntityAction_GoldRemote_unk0, data_02_76a8
    dw   call_02_5297_EntityAction_GoldRemote_unk1, data_02_769d
data_02_4dff:                        ;; ENTITY_UNK_02
    dw   call_02_52aa_EntityAction_Unk02_Update, data_02_768a
data_02_4e03:                        ;; ENTITY_PARTICLE_BURST
    dw   call_02_52ab_EntityAction_ParticleBurst_Update, data_02_7cd4
data_02_4e07:                        ;; ENTITY_UNK_08
    dw   call_02_52e7_EntityAction_Unk08_Update, data_02_76b5
data_02_4e0b:                        ;; ENTITY_SCREAM_TV_FALLING_PLATFORM
    dw   call_02_52e8_EntityAction_ScreamTVFallingPlatform_Update, data_02_7963
data_02_4e0f:                        ;; ENTITY_SCREAM_TV_MOVING_PLATFORM
    dw   call_02_5348_EntityAction_ScreamTVMovingPlatform_Update, data_02_7969
data_02_4e13:                        ;; ENTITY_SCREAM_TV_PUSH_BLOCK
    dw   call_02_5373_EntityAction_ScreamTVPushBlock_Update, data_02_796f
data_02_4e17:                        ;; ENTITY_SCREAM_TV_PUMPKIN
    dw   call_02_5373_EntityAction_Pumpkin_unk0, data_02_76b5
    dw   call_02_5399_EntityAction_Pumpkin_unk1, data_02_76bf
data_02_4e1f:                        ;; ENTITY_SCREAM_TV_FRANKIE
    dw   call_02_53aa_EntityAction_Frankie_Update, data_02_76c7
data_02_4e23:                        ;; ENTITY_SCREAM_TV_HEAD_GHOST
    dw   call_02_53ad_EntityAction_HeadGhost_unk0, data_02_7920
    dw   call_02_53d9_EntityAction_HeadGhost_unk1, data_02_792d
data_02_4e2b:                        ;; ENTITY_SCREAM_TV_HEAD_GHOST_HEAD
    dw   call_02_53e2_EntityAction_GhostHead_Update, data_02_7933
data_02_4e2f:                        ;; ENTITY_SCREAM_TV_FLOATING_SKULL
    dw   call_02_5434_EntityAction_FloatingSkull_unk0, data_02_76d0
    dw   call_02_5440_EntityAction_FloatingSkull_unk1, data_02_76d9
    dw   call_02_545b_EntityAction_FloatingSkull_unk2, data_02_76df
data_02_4e3b:                        ;; ENTITY_SCREAM_TV_FLOATING_SKULL_PROJECTILE
    dw   call_02_5464_EntityAction_FloatingSkullProjectile_unk0, data_02_7b0f
    dw   call_02_546e_EntityAction_FloatingSkullProjectile_unk1, data_02_7ce6
data_02_4e43:                        ;; ENTITY_SCREAM_TV_ZOMBIE
    dw   call_02_5480_EntityAction_Zombie_unk0, data_02_76e5
    dw   call_02_5480_EntityAction_Zombie_unk0, data_02_76ee
    dw   call_02_54b4_EntityAction_Zombie_unk2, data_02_76f7
data_02_4e4f:                        ;; ENTITY_SCREAM_TV_ZOMBIE_HEAD
    dw   call_02_54c6_EntityAction_ZombieHead_unk0, data_02_768a
    dw   call_02_54df_EntityAction_ZombieHead_unk1, data_02_768a
    dw   call_02_54fc_EntityAction_ZombieHead_unk2, data_02_768a
data_02_4e5b:                        ;; ENTITY_SCREAM_TV_FALLING_AXE
    dw   call_02_54ff_EntityAction_FallingAxe_unk0, data_02_7939
    dw   call_02_5513_EntityAction_FallingAxe_unk1, data_02_7939
    dw   call_02_552c_EntityAction_FallingAxe_unk2, data_02_793f
    dw   call_02_5535_EntityAction_FallingAxe_unk3, data_02_7939
data_02_4e6b:                        ;; ENTITY_SCREAM_TV_LANTERN
    dw   call_02_5544_EntityAction_Lantern_unk0, data_02_7951
    dw   call_02_5551_EntityAction_Lantern_unk1, data_02_7957
data_02_4e73:                        ;; ENTITY_SCREAM_TV_BAT
    dw   call_02_557c_EntityAction_Bat_Update, data_02_76fd
data_02_4e77:                        ;; ENTITY_SCREAM_TV_ORANGE_MOVING_PLATFORM
    dw   call_02_5589_EntityAction_ScreamTVOrangeMovingPlatform_Update, data_02_7975
data_02_4e7b:                        ;; ENTITY_SCREAM_TV_DOOR_OPENING
    dw   call_02_559b_EntityAction_ScreamTVDoorOpening_None, data_02_7706
    dw   call_02_559c_EntityAction_ScreamTVDoorOpening_unk1, data_02_770f
data_02_4e83:                        ;; ENTITY_SCREAM_TV_GHOST
    dw   call_02_55a3_EntityAction_Ghost_unk0, data_02_7718
    dw   call_02_55e8_EntityAction_Ghost_unk1, data_02_7722
    dw   call_02_55f1_EntityAction_Ghost_unk2, data_02_772c
    dw   call_02_5612_EntityAction_Ghost_unk3, data_02_7733
data_02_4e93:                        ;; ENTITY_SCREAM_TV_CLIMB_WALL_SUN_ENEMY
    dw   call_02_5628_EntityAction_ClimbWallSunEnemy_Update, data_02_795d
data_02_4e97:                        ;; ENTITY_SCREAM_TV_VANISHING_PLATFORM
    dw   call_02_563a_EntityAction_ScreamTVVanishingPlatform_unk0, data_02_797b
    dw   call_02_5652_EntityAction_ScreamTVVanishingPlatform_unk1, data_02_797b
    dw   call_02_56a1_EntityAction_ScreamTVVanishingPlatform_unk2, data_02_7981
data_02_4ea3:                        ;; ENTITY_SCREAM_TV_MONA_LISA_ELEVATOR
    dw   call_02_56af_EntityAction_MonaLisaElevator_Update, data_02_7987
data_02_4ea7:                        ;; ENTITY_TOON_TV_HARD_HEAD_AREA_OBJECT
    dw   call_02_56dc_EntityAction_HardHeadAreaObject_unk0, data_02_798d
    dw   call_02_576e_EntityAction_HardHeadAreaObject_unk1, data_02_7993
    dw   call_02_576e_EntityAction_HardHeadAreaObject_unk1, data_02_7999
data_02_4eb3:                        ;; ENTITY_TOON_TV_STATIONARY_BEAR_TRAP
    dw   call_02_57f3_EntityAction_StationaryBearTrap_unk0, data_02_79a6
    dw   call_02_5803_EntityAction_StationaryBearTrap_unk1, data_02_79ac
data_02_4ebb:                        ;; ENTITY_TOON_TV_MOVING_BEAR_TRAP
    dw   call_02_5812_EntityAction_MovingBearTrap_unk0, data_02_79b3
    dw   call_02_5830_EntityAction_MovingBearTrap_unk1, data_02_79b9
data_02_4ec3:                        ;; ENTITY_TOON_TV_BUMBLEBEE
    dw   call_02_5843_EntityAction_Bumblebee_unk0, data_02_799f
    dw   call_02_585e_EntityAction_Bumblebee_unk1, data_02_799f
data_02_4ecb:                        ;; ENTITY_TOON_TV_BOWLING_BALL
    dw   call_02_5871_EntityAction_BowlingBall_Update, data_02_79c5
data_02_4ecf:                        ;; ENTITY_TOON_TV_CACTUS
    dw   call_02_58d3_EntityAction_Cactus_unk0, data_02_79d6
    dw   call_02_58e8_EntityAction_Cactus_unk1, data_02_79dc
    dw   call_02_58fa_EntityAction_Cactus_unk2, data_02_79e3
data_02_4edb:                        ;; ENTITY_TOON_TV_DOMINO
    dw   call_02_590b_EntityAction_Domino_Update, data_02_79e9
data_02_4edf:                        ;; ENTITY_TOON_TV_SHARK
    dw   call_02_591c_EntityAction_Shark_Update, data_02_79ef
data_02_4ee3:                        ;; ENTITY_TOON_TV_FLOWER
    dw   call_02_592d_EntityAction_Flower_Update, data_02_79f6
    dw   call_02_592d_EntityAction_Flower_Update, data_02_79fc
    dw   call_02_592d_EntityAction_Flower_Update, data_02_7a02
data_02_4eef:                        ;; ENTITY_TOON_TV_HUNTER
    dw   call_02_5993_EntityAction_Hunter_unk0, data_02_774c
    dw   call_02_59c8_EntityAction_Hunter_unk1, data_02_7759
    dw   call_02_59d2_EntityAction_Hunter_unk2, data_02_7768
    dw   call_02_59db_EntityAction_Hunter_unk3, data_02_777c
    dw   call_02_59e4_EntityAction_Hunter_unk4, data_02_7784
    dw   call_02_59ed_EntityAction_Hunter_unk5, data_02_778a
data_02_4f07:                        ;; ENTITY_TOON_TV_MUSHROOM
    dw   call_02_5a28_EntityAction_Mushroom_Update, data_02_7a1b
data_02_4f0b:                        ;; ENTITY_UNK_28
    dw   call_02_5a73_EntityAction_Unk28_Update, data_02_7a21
data_02_4f0f:                        ;; ENTITY_TOON_TV_LIZARD
    dw   call_02_5a7d_EntityAction_Lizard_Update, data_02_7a3a
data_02_4f13:                        ;; ENTITY_TOON_TV_HAPPY_FACE
    dw   call_02_5a8c_EntityAction_HappyFace_unk0, data_02_773a
    dw   call_02_5a9a_EntityAction_HappyFace_unk1, data_02_7744
data_02_4f1b:                        ;; ENTITY_TOON_TV_VANISHING_BLOCK
    dw   call_02_5aab_EntityAction_ToonTVVanishingBlock_unk0, data_02_7a45
    dw   call_02_5aea_EntityAction_ToonTVVanishingBlock_unk1, data_02_7a45
    dw   call_02_5b39_EntityAction_ToonTVVanishingBlock_unk2, data_02_7a4b
data_02_4f27:                        ;; ENTITY_TOON_TV_MOVING_BLOCK
    dw   call_02_5b47_EntityAction_ToonTVMovingBlock_unk0, data_02_7a51
    dw   call_02_5b9d_EntityAction_ToonTVMovingBlock_unk1, data_02_7a51
data_02_4f2f:                        ;; ENTITY_TOON_TV_MOVING_LOG
    dw   call_02_5bb6_EntityAction_MovingLog_Update, data_02_7a2e
data_02_4f33:                        ;; ENTITY_TOON_TV_STATIONARY_LOG
    dw   call_02_5be1_EntityAction_StationaryLog_Update, data_02_7a34
data_02_4f37:                        ;; ENTITY_TOON_TV_FLOWER_HAMMER
    dw   call_02_596c_EntityAction_FlowerHammer_unk0, data_02_7a08
    dw   call_02_597a_EntityAction_FlowerHammer_unk1, data_02_7a0e
    dw   call_02_598c_EntityAction_FlowerHammer_unk2, data_02_7a15
data_02_4f43:                        ;; ENTITY_TOON_TV_HUNTER_BULLET
    dw   call_02_5a10_EntityAction_HunterBullet_unk0, data_02_79d0
    dw   call_02_5a1f_EntityAction_HunterBullet_unk1, data_02_79d0
data_02_4f4b:                        ;; ENTITY_TOON_TV_ROCKET
    dw   call_02_5be2_EntityAction_Rocket_unk0, data_02_7c7b
    dw   call_02_5bf7_EntityAction_Rocket_unk1, data_02_7c81
    dw   call_02_5c00_EntityAction_Rocket_unk2, data_02_7c9a
data_02_4f57:                        ;; ENTITY_PRE_HISTORY_FAST_DINOSAUR
    dw   call_02_5c08_EntityAction_FastDinosaur_Update, data_02_7790
data_02_4f5b:                        ;; ENTITY_PRE_HISTORY_DRAGONFLY
    dw   call_02_5c10_EntityAction_Dragonfly_Update, data_02_77a7
data_02_4f5f:                        ;; ENTITY_PRE_HISTORY_EGG
    dw   call_02_5c18_EntityAction_Egg_unk0, data_02_77d5
    dw   call_02_5c47_EntityAction_Egg_unk1, data_02_77e2
    dw   call_02_5c5b_EntityAction_Egg_unk2, data_02_77ea
data_02_4f6b:                        ;; ENTITY_UNK_35
    dw   call_02_5c69_EntityAction_Unk35_unk0, data_02_7a62
    dw   call_02_5c73_EntityAction_Unk35_unk1, data_02_7a68
data_02_4f73:                        ;; ENTITY_UNK_36
    dw   call_02_5c7c_EntityAction_Unk36_Update, data_02_7a57
data_02_4f77:                        ;; ENTITY_PRE_HISTORY_FALLING_LAVA
    dw   call_02_5c7d_EntityAction_FallingLava_unk0, data_02_7a73
    dw   call_02_5c9c_EntityAction_FallingLava_unk1, data_02_7a79
data_02_4f7f:                        ;; ENTITY_PRE_HISTORY_LAVA_RAFT
    dw   call_02_5ca8_EntityAction_LavaRaft_unk0, data_02_7a84
    dw   call_02_5cba_EntityAction_LavaRaft_unk1, data_02_7a8a
data_02_4f87:                        ;; ENTITY_PRE_HISTORY_MOVING_PLATFORM
    dw   call_02_5cbb_EntityAction_PreHistoryMovingPlatform_Update, data_02_7a90
data_02_4f8b:                        ;; ENTITY_UNK_3A
    dw   call_02_5ccd_EntityAction_Unk3A_Update, data_02_7a96
data_02_4f8f:                        ;; ENTITY_UNK_3B
    dw   call_02_5cce_EntityAction_Unk3B_Update, data_02_7a9c
data_02_4f93:                        ;; ENTITY_PRE_HISTORY_PTEROSAUR
    dw   call_02_5ccf_EntityAction_Pterosaur_Update, data_02_77b2
data_02_4f97:                        ;; ENTITY_UNK_3D
    dw   call_02_5d0b_EntityAction_Unk3D_Update, data_02_7aa8
data_02_4f9b:                        ;; ENTITY_PRE_HISTORY_FALLING_BOULDER
    dw   call_02_5d0c_EntityAction_FallingBoulder_unk0, data_02_7aae
    dw   call_02_5d37_EntityAction_FallingBoulder_unk1, data_02_7ab4
    dw   call_02_5d48_EntityAction_FallingBoulder_unk2, data_02_7aba
    dw   call_02_5d5b_EntityAction_FallingBoulder_unk3, data_02_7cda
data_02_4fab:                        ;; ENTITY_UNK_3F
    dw   call_02_5d6f_EntityAction_Unk3F_Update, data_02_7790
data_02_4faf:                        ;; ENTITY_PRE_HISTORY_BEETLE_HORIZONTAL
    dw   call_02_5d81_EntityAction_BeetleHorizontal_Update, data_02_7ac1
data_02_4fb3:                        ;; ENTITY_PRE_HISTORY_BEETLE_VERTICAL
    dw   call_02_5d70_EntityAction_BeetleVertical_Update, data_02_7ac8
data_02_4fb7:                        ;; ENTITY_PRE_HISTORY_ANT
    dw   call_02_5d81_EntityAction_BeetleHorizontal_Update, data_02_7acf
data_02_4fbb:                        ;; ENTITY_PRE_HISTORY_FIRE_PLANT
    dw   call_02_5d92_EntityAction_FirePlant_unk0, data_02_7aef
    dw   call_02_5db2_EntityAction_FirePlant_unk1, data_02_7af8
    dw   call_02_5dd3_EntityAction_FirePlant_unk2, data_02_7b01
data_02_4fc7:                        ;; ENTITY_PRE_HISTORY_FIRE_PLANT_PROJECTILES
    dw   call_02_5ddc_EntityAction_FirePlantProjectiles_unk0, data_02_7b08
    dw   call_02_5de6_EntityAction_FirePlantProjectiles_unk1, data_02_7ce0
data_02_4fcf:                        ;; ENTITY_PRE_HISTORY_GEYSER
    dw   call_02_5df8_EntityAction_Geyser_unk0, data_02_7ad8
    dw   call_02_5e02_EntityAction_Geyser_unk1, data_02_7ade
data_02_4fd7:                        ;; ENTITY_UNK_46
    dw   call_02_5e0b_EntityAction_Unk46_Update, data_02_7aa2
data_02_4fdb:                        ;; ENTITY_PRE_HISTORY_DINOSAUR
    dw   call_02_5e0c_EntityAction_Dinosaur_Update, data_02_77bd
data_02_4fdf:                        ;; ENTITY_PRE_HISTORY_TRICERATOPS
    dw   call_02_5e26_EntityAction_Triceratops_Update, data_02_77ca
data_02_4fe3:                        ;; ENTITY_PRE_HISTORY_TRICERATOPS_HORN
    dw   call_02_5e90_EntityAction_TriceratopsHorn_Update, data_02_7ae9
data_02_4fe7:                        ;; ENTITY_UNK_4A
    dw   call_02_5e91_EntityAction_Unk4A_Update, data_02_7790
data_02_4feb:                        ;; ENTITY_KUNG_FU_THEATER_HANGING_BLADE
    dw   call_02_5e92_EntityAction_HangingBlade_Update, data_02_7b15
data_02_4fef:                        ;; ENTITY_KUNG_FU_THEATER_CANNON
    dw   call_02_5ebd_EntityAction_Cannon_Update, data_02_7b1b
data_02_4ff3:                        ;; ENTITY_KUNG_FU_THEATER_CANNON_PROJECTILE
    dw   call_02_5ef0_EntityAction_CannonProjectile_unk0, data_02_7b21
    dw   call_02_5efa_EntityAction_CannonProjectile_unk1, data_02_7b21
data_02_4ffb:                        ;; ENTITY_KUNG_FU_THEATER_DRAGONFLY
    dw   call_02_5f48_EntityAction_Dragonfly_Update, data_02_77f2
data_02_4fff:                        ;; ENTITY_KUNG_FU_THEATER_DRAGON_BODY_SEGMENT
    dw   call_02_5f50_EntityAction_DragonBodySegment_Update, data_02_7b27
data_02_5003:                        ;; ENTITY_KUNG_FU_THEATER_DRAGON_HEAD
    dw   call_02_5f67_EntityAction_DragonHead_Update, data_02_7824
data_02_5007:                        ;; ENTITY_UNK_51
    dw   call_02_616d_EntityAction_Unk51_Update, data_02_7b2d
data_02_500b:                        ;; ENTITY_KUNG_FU_THEATER_DRAGON_PROJECTILE
    dw   call_02_6152_EntityAction_DragonProjectile_unk0, data_02_7b39
    dw   call_02_615f_EntityAction_DragonProjectile_unk1, data_02_7b39
data_02_5013:                        ;; ENTITY_KUNG_FU_THEATER_WALKING_NINJA
    dw   call_02_616e_EntityAction_Ninja_unk0, data_02_77fd
    dw   call_02_6213_EntityAction_Ninja_unk1, data_02_7806
    dw   call_02_621c_EntityAction_Ninja_unk2, data_02_7815
data_02_501f:                        ;; ENTITY_KUNG_FU_THEATER_JUMPING_NINJA
    dw   call_02_616e_EntityAction_Ninja_unk0, data_02_77fd
    dw   call_02_6213_EntityAction_Ninja_unk1, data_02_7806
    dw   call_02_621c_EntityAction_Ninja_unk2, data_02_7815
    dw   call_02_6235_EntityAction_Ninja_Jump, data_02_781e
data_02_502f:                        ;; ENTITY_KUNG_FU_THEATER_SAMURAI_BODY
    dw   call_02_624c_EntityAction_SamuraiBody_unk0, data_02_782a
    dw   call_02_62c3_EntityAction_SamuraiBody_unk1, data_02_7837
data_02_5037:                        ;; ENTITY_KUNG_FU_THEATER_SAMURAI_HEAD
    dw   call_02_62db_EntityAction_SamuraiHead_unk0, data_02_7b6c
    dw   call_02_62fc_EntityAction_SamuraiHead_unk1, data_02_7b6c
    dw   call_02_6327_EntityAction_SamuraiHead_unk2, data_02_7b72
data_02_5043:                        ;; ENTITY_KUNG_FU_THEATER_LIZARD
    dw   call_02_6335_EntityAction_Lizard_Update, data_02_7b7a
data_02_5047:                        ;; ENTITY_KUNG_FU_THEATER_NINJA_PROJECTILE
    dw   call_02_633d_EntityAction_NinjaProjectile_unk0, data_02_7b85
    dw   call_02_6347_EntityAction_NinjaProjectile_unk1, data_02_7b85
data_02_504f:                        ;; ENTITY_KUNG_FU_THEATER_SPIKY_LOG
    dw   call_02_6355_EntityAction_SpikyLog_Update, data_02_7b8c
data_02_5053:                        ;; ENTITY_KUNG_FU_THEATER_TALL_JAR
    dw   call_02_635d_EntityAction_Jar_unk0, data_02_7b92
    dw   call_02_6375_EntityAction_Jar_unk1, data_02_7cec
data_02_505b:                        ;; ENTITY_KUNG_FU_THEATER_JAR
    dw   call_02_635d_EntityAction_Jar_unk0, data_02_7b92
    dw   call_02_6375_EntityAction_Jar_unk1, data_02_7cec
data_02_5063:                        ;; ENTITY_UNK_5C
    dw   call_02_6387_EntityAction_Unk5C_Update, data_02_7b98
data_02_5067:                        ;; ENTITY_UNK_5D
    dw   call_02_6388_EntityAction_KungFuVanishingPlatform_unk0, data_02_7b98
data_02_506b:                        ;; ENTITY_KUNG_FU_THEATER_VANISHING_PLATFORM
    dw   call_02_6388_EntityAction_KungFuVanishingPlatform_unk0, data_02_7b42
    dw   call_02_63ac_EntityAction_KungFuVanishingPlatform_unk1, data_02_7b42
    dw   call_02_63fb_EntityAction_KungFuVanishingPlatform_unk2, data_02_7b48
data_02_5077:                        ;; ENTITY_KUNG_FU_THEATER_MOVING_PLATFORM
    dw   call_02_6409_EntityAction_KungFuMovingPlatform_Update, data_02_7b4e
data_02_507b:                        ;; ENTITY_UNK_60
    dw   call_02_6434_EntityAction_Unk60_Update, data_02_7b54
data_02_507f:                        ;; ENTITY_KUNG_FU_THEATER_MOVING_RAFT
    dw   call_02_6435_EntityAction_MovingRaft_Update, data_02_7b5a
data_02_5083:                        ;; ENTITY_KUNG_FU_THEATER_STATIONARY_RAFT
    dw   call_02_6447_EntityAction_StationaryRaft_Update, data_02_7b60
data_02_5087:                        ;; ENTITY_UNK_63
    dw   call_02_6448_EntityAction_Unk63_Update, data_02_7b66
data_02_508b:                        ;; ENTITY_UNK_64
    dw   call_02_6449_EntityAction_Unk64_Update, data_02_7b98
data_02_508f:                        ;; ENTITY_REZOPOLIS_SPECIAL_MOVING_PLATFORM
    dw   call_02_644a_EntityAction_RezopolisSpecialMovingPlatform_Update, data_02_7b98
data_02_5093:                        ;; ENTITY_REZOPOLIS_MOVING_PLATFORM
    dw   call_02_649c_EntityAction_RezopolisMovingPlatform_Update, data_02_7b9e
data_02_5097:                        ;; ENTITY_REZOPOLIS_RED_PLATFORM
    dw   call_02_64ae_EntityAction_RedPlatform_Update, data_02_7ba4
data_02_509b:                        ;; ENTITY_REZOPOLIS_ACTIVATED_RED_PLATFORM
    dw   call_02_650f_EntityAction_ActivatedRedPlatform_Update, data_02_7ba4
data_02_509f:                        ;; ENTITY_REZOPOLIS_TAILSPIN_PLATFORM
    dw   call_02_655d_EntityAction_TailspinPlatform_Update, data_02_7baa
data_02_50a3:                        ;; ENTITY_REZOPOLIS_TAILSPIN_GEAR
    dw   call_02_65b7_EntityAction_TailspinGear_unk0, data_02_7bbd
    dw   call_02_65c0_EntityAction_TailspinGear_unk1, data_02_7bc3
    dw   call_02_65c9_EntityAction_TailspinGear_unk2, data_02_7bcc
    dw   call_02_65d2_EntityAction_TailspinGear_unk3, data_02_7bd5
    dw   call_02_65db_EntityAction_TailspinGear_unk4, data_02_7bde
data_02_50b7:                        ;; ENTITY_UNK_6B
    dw   call_02_6626_EntityAction_Unk6B_Update, data_02_7790
data_02_50bb:                        ;; ENTITY_UNK_6C
    dw   call_02_6627_EntityAction_Unk6C_Update, data_02_7bb0
data_02_50bf:                        ;; ENTITY_UNK_6D
    dw   call_02_6628_EntityAction_Unk6D_Update, data_02_7bb0
data_02_50c3:                        ;; ENTITY_REZOPOLIS_GREEN_MONSTER
    dw   call_02_6629_EntityAction_GreenMonster_unk0, data_02_7865
    dw   call_02_6632_EntityAction_GreenMonster_unk1, data_02_7872
    dw   call_02_6633_EntityAction_GreenMonster_unk2, data_02_7879
data_02_50cf:                        ;; ENTITY_UNK_6F
    dw   call_02_6634_EntityAction_Unk6F_Update, data_02_7bf0
data_02_50d3:                        ;; ENTITY_UNK_70
    dw   call_02_6635_EntityAction_Unk6F_Update, data_02_7bf0
data_02_50d7:                        ;; ENTITY_REZOPOLIS_PINCER
    dw   call_02_6636_EntityAction_Pincer_Update, data_02_7880
data_02_50db:                        ;; ENTITY_REZOPOLIS_FLAMETHROWER
    dw   call_02_664b_EntityAction_Flamethrower_unk0, data_02_7bb0
    dw   call_02_664c_EntityAction_Flamethrower_unk1, data_02_7bb0
data_02_50e3:                        ;; ENTITY_REZOPOLIS_UFO
    dw   call_02_664d_EntityAction_UFO_unk0, data_02_784d
    dw   call_02_666b_EntityAction_UFO_unk1, data_02_785c
data_02_50eb:                        ;; ENTITY_REZOPOLIS_ANT
    dw   call_02_66bb_EntityAction_Ant_Update, data_02_7be7
data_02_50ef:                        ;; ENTITY_REZOPOLIS_ANT_SPAWNER
    dw   call_02_666c_EntityAction_AntSpawner_Update, data_02_7c6f
data_02_50f3:                        ;; ENTITY_CIRCUIT_CENTRAL_ANT
    dw   call_02_66db_EntityAction_CircuitCentralAnt_Update, data_02_7bf0
data_02_50f7:                        ;; ENTITY_CIRCUIT_CENTRAL_CAPACITOR
    dw   call_02_66e3_EntityAction_Capacitor_unk0, data_02_7bf9
    dw   call_02_66f1_EntityAction_Capacitor_unk1, data_02_7c01
data_02_50ff:                        ;; ENTITY_CIRCUIT_CENTRAL_POWER_UP
    dw   call_02_66fd_EntityAction_PowerUp_unk0, data_02_7c07
    dw   call_02_6710_EntityAction_PowerUp_unk1, data_02_7c07
data_02_5107:                        ;; ENTITY_UNK_79
    dw   call_02_6723_EntityAction_Unk79_Update, data_02_7790
data_02_510b:                        ;; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT
    dw   call_02_6724_EntityAction_LittleRobot_unk0, data_02_7c10
    dw   call_02_676c_EntityAction_LittleRobot_unk1, data_02_7c16
data_02_5113:                        ;; ENTITY_CIRCUIT_CENTRAL_LITTLE_ROBOT_GEAR
    dw   call_02_6775_EntityAction_LittleRobotGear_Update, data_02_7c1d
data_02_5117:                        ;; ENTITY_CIRCUIT_CENTRAL_ELECTRIC_BALL
    dw   call_02_6786_EntityAction_ElectricBall_unk0, data_02_7c25
    dw   call_02_679e_EntityAction_ElectricBall_unk1, data_02_7c2b
data_02_511f:                        ;; ENTITY_CIRCUIT_CENTRAL_MOVING_PLATFORM
    dw   call_02_68c0_EntityAction_CircuitCentralMovingPlatform_Update, data_02_7c42
data_02_5123:                        ;; ENTITY_CIRCUIT_CENTRAL_POWERED_PLATFORM
    dw   call_02_696f_EntityAction_CircuitCentralPoweredPlatform_unk0, data_02_7c34
    dw   call_02_6993_EntityAction_CircuitCentralPoweredPlatform_unk1, data_02_7c3a
    dw   call_02_69c4_EntityAction_CircuitCentralPoweredPlatform_unk2, data_02_7c48
data_02_512f:                        ;; ENTITY_CIRCUIT_CENTRAL_LOWERING_PLATFORM
    dw   call_02_69d7_EntityAction_CircuitCentralLoweringPlatform_Update, data_02_7c50
data_02_5133:                        ;; ENTITY_CIRCUIT_CENTRAL_WALKER_ROBOT
    dw   call_02_6a33_EntityAction_WalkerRobot_Update, data_02_7889
data_02_5137:                        ;; ENTITY_CIRCUIT_CENTRAL_POWERED_WALKWAY
    dw   call_02_6a3b_EntityAction_PoweredWalkway_Update, data_02_7c56
data_02_513b:                        ;; ENTITY_CIRCUIT_CENTRAL_WALKWAY_ACTIVATOR
    dw   call_02_6a3c_EntityAction_WalkwayActivator_Update, data_02_7c5c
data_02_513f:                        ;; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE
    dw   call_02_6a8b_EntityAction_ArcedGunProjectile_unk0, data_02_7c62
    dw   call_02_6aac_EntityAction_ArcedGunProjectile_unk1, data_02_7c68
data_02_5147:                        ;; ENTITY_CHANNEL_Z_ARCED_GUN_PROJECTILE2
    dw   call_02_6ad3_EntityAction_ArcedGunProjectile2_unk0, data_02_7c62
    dw   call_02_6af9_EntityAction_ArcedGunProjectile2_unk1, data_02_7c68
    dw   call_02_6b30_EntityAction_ArcedGunProjectile2_unk2, data_02_7c68
    dw   call_02_6b43_EntityAction_ArcedGunProjectile2_unk3, data_02_7c68
data_02_5157:                        ;; ENTITY_CHANNEL_Z_GUN_PROJECTILE
    dw   call_02_6b6a_EntityAction_GunProjectile_unk0, data_02_7c62
    dw   call_02_6b81_EntityAction_GunProjectile_unk1, data_02_7c68
data_02_515f:                        ;; ENTITY_CHANNEL_Z_REZ
    dw   call_02_6c18_EntityAction_Rez_unk0, data_02_78a8
    dw   call_02_6c41_EntityAction_Rez_unk1, data_02_78b5
    dw   call_02_6c4a_EntityAction_Rez_unk2, data_02_78d7
    dw   call_02_6c42_EntityAction_Rez_unk3, data_02_78e4
    dw   call_02_6c82_EntityAction_Rez_unk4, data_02_78c2
    dw   call_02_6c99_EntityAction_Rez_unk5, data_02_78f1
    dw   call_02_6c99_EntityAction_Rez_unk5, data_02_78f1
    dw   call_02_6c99_EntityAction_Rez_unk5, data_02_78f1
    dw   call_02_6c99_EntityAction_Rez_unk5, data_02_78f1
    dw   call_02_6c9d_EntityAction_Rez_unk9, data_02_78fc
    dw   call_02_6ca6_EntityAction_Rez_unk10, data_02_790b
data_02_518b:                        ;; ENTITY_UNK_87
    dw   call_02_6d11_EntityAction_Unk87_Update, data_02_7c75
data_02_518f:                        ;; ENTITY_UNK_88
    dw   call_02_6d23_EntityAction_Unk88_Update, data_02_7c75
data_02_5193:                        ;; ENTITY_CHANNEL_Z_REZ_FOLLOWING_FIRE
    dw   call_02_6cca_EntityAction_RezFollowingFire_Update, data_02_7ca1
data_02_5197:                        ;; ENTITY_CHANNEL_Z_GUN_PROJECTILE_EXPLOSION
    dw   call_02_6d24_EntityAction_GunProjectileExplosion_Update, data_02_7caa
data_02_519b:                        ;; ENTITY_UNK_8B
    dw   call_02_6d5d_EntityAction_Unk8B_unk0, data_02_7cb6
    dw   call_02_6d7f_EntityAction_Unk8B_unk1, data_02_7cb6
data_02_51a3:                        ;; ENTITY_CHANNEL_Z_FINAL_BATTLE_BUTTON
    dw   call_02_6d80_EntityAction_FinalBattleButton_unk0, data_02_7cbc
    dw   call_02_6db8_EntityAction_FinalBattleButton_unk1, data_02_7cc2
data_02_51ab:                        ;; ENTITY_UNK_8D
    dw   call_02_6de3_EntityAction_Unk8D_Update, data_02_7894
data_02_51af:                        ;; ENTITY_UNK_8E
    dw   call_02_6df0_EntityAction_Unk8E_Update, data_02_791a
data_02_51b3:                        ;; ENTITY_MEDIA_DIMENSION_MOVING_PLATFORM
    dw   call_02_6df1_EntityAction_MediaDimensionMovingPlatform_Update, data_02_7cc8

call_02_51b7_EntityAction_CollectibleSpawn_Update:
    call call_00_3b8d                                  ;; 02:51b7 $cd $8d $3b
    push AF                                            ;; 02:51ba $f5
    farcall call_03_6584
    jr   NZ, .jr_02_51cc                               ;; 02:51c6 $20 $04
    pop  AF                                            ;; 02:51c8 $f1
    jp   call_00_3931                                    ;; 02:51c9 $c3 $31 $39
.jr_02_51cc:
    pop  AF                                            ;; 02:51cc $f1
    ret  NZ                                            ;; 02:51cd $c0
    ld   H, $d2                                        ;; 02:51ce $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:51d0 $fa $00 $d3
    or   A, $18                                        ;; 02:51d3 $f6 $18
    ld   L, A                                          ;; 02:51d5 $6f
    dec  [HL]                                          ;; 02:51d6 $35
    jp   Z, call_00_3931                                 ;; 02:51d7 $ca $31 $39
    ld   C, [HL]                                       ;; 02:51da $4e
    xor  A, $12                                        ;; 02:51db $ee $12
    ld   L, A                                          ;; 02:51dd $6f
    res  3, [HL]                                       ;; 02:51de $cb $9e
    ld   A, C                                          ;; 02:51e0 $79
    cp   A, $40                                        ;; 02:51e1 $fe $40
    ret  NC                                            ;; 02:51e3 $d0
    and  A, $04                                        ;; 02:51e4 $e6 $04
    ret  Z                                             ;; 02:51e6 $c8
    set  3, [HL]                                       ;; 02:51e7 $cb $de
    ret                                                ;; 02:51e9 $c9

call_02_51ea_EntityAction_TVButton_unk0:
    call call_00_3878                                  ;; 02:51ea $cd $78 $38
    ld   E, A                                          ;; 02:51ed $5f
    ld   H, $d2                                        ;; 02:51ee $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:51f0 $fa $00 $d3
    or   A, $0a                                        ;; 02:51f3 $f6 $0a
    ld   L, A                                          ;; 02:51f5 $6f
    res  3, [HL]                                       ;; 02:51f6 $cb $9e
    inc  E                                             ;; 02:51f8 $1c
    dec  E                                             ;; 02:51f9 $1d
    jr   NZ, .jr_02_5207                               ;; 02:51fa $20 $0b
    ld   A, [wD73B]                                    ;; 02:51fc $fa $3b $d7
    and  A, $1f                                        ;; 02:51ff $e6 $1f
    cp   A, $0c                                        ;; 02:5201 $fe $0c
    jr   NC, .jr_02_5207                               ;; 02:5203 $30 $02
    set  3, [HL]                                       ;; 02:5205 $cb $de
.jr_02_5207:
    call call_00_34f5                                  ;; 02:5207 $cd $f5 $34
    bit  0, B                                          ;; 02:520a $cb $40
    ret  Z                                             ;; 02:520c $c8
    call call_00_3878                                  ;; 02:520d $cd $78 $38
    ret  Z                                             ;; 02:5210 $c8
    ld   A, [wD624_CurrentLevelId]                                    ;; 02:5211 $fa $24 $d6
    and  A, A                                          ;; 02:5214 $a7
    jr   Z, .jr_02_521b                                ;; 02:5215 $28 $04
    ld   HL, wD647                                     ;; 02:5217 $21 $47 $d6
    ld   [HL], E                                       ;; 02:521a $73
.jr_02_521b:
    call call_00_34f5                                  ;; 02:521b $cd $f5 $34
    bit  0, B                                          ;; 02:521e $cb $40
    ret  Z                                             ;; 02:5220 $c8
    ld   BC, $05                                       ;; 02:5221 $01 $05 $00
    call call_00_37d8                                  ;; 02:5224 $cd $d8 $37
    ld   A, $01                                        ;; 02:5227 $3e $01
    call call_02_7102_SetEntityAction                                  ;; 02:5229 $cd $02 $71
    ld   A, [wD624_CurrentLevelId]                                    ;; 02:522c $fa $24 $d6
    and  A, A                                          ;; 02:522f $a7
    jr   NZ, .jr_02_524d                               ;; 02:5230 $20 $1b
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5232 $fa $00 $d3
    rlca                                               ;; 02:5235 $07
    rlca                                               ;; 02:5236 $07
    rlca                                               ;; 02:5237 $07
    and  A, $07                                        ;; 02:5238 $e6 $07
    ld   L, A                                          ;; 02:523a $6f
    ld   H, $00                                        ;; 02:523b $26 $00
    ld   DE, wD301                                     ;; 02:523d $11 $01 $d3
    add  HL, DE                                        ;; 02:5240 $19
    ld   A, [HL]                                       ;; 02:5241 $7e
    dec  A                                             ;; 02:5242 $3d
    srl  A                                             ;; 02:5243 $cb $3f
    ld   [wD628_MediaDimensionRespawnPoint], A                                    ;; 02:5245 $ea $28 $d6
    ld   A, $12                                        ;; 02:5248 $3e $12
    jp   call_02_4ccd                                  ;; 02:524a $c3 $cd $4c
.jr_02_524d:
    ld   A, $13                                        ;; 02:524d $3e $13
    jp   call_02_4ccd                                  ;; 02:524f $c3 $cd $4c
call_02_5252_EntityAction_TVButton_unk1:
    ret                                                ;; 02:5252 $c9

call_02_5253_EntityAction_RedRemote_unk0:
    call call_00_34ea                                  ;; 02:5253 $cd $ea $34
    call NZ, call_00_3bf4                              ;; 02:5256 $c4 $f4 $3b
    ld   HL, wD60F_HDMATransferFlags                                     ;; 02:5259 $21 $0f $d6
    bit  4, [HL]                                       ;; 02:525c $cb $66
    call Z, call_00_0634                               ;; 02:525e $cc $34 $06
    ld   A, [wD59E]                                    ;; 02:5261 $fa $9e $d5
    and  A, A                                          ;; 02:5264 $a7
    ld   A, $01                                        ;; 02:5265 $3e $01
    call NZ, call_02_7102_SetEntityAction                              ;; 02:5267 $c4 $02 $71
call_02_526a_EntityAction_RedRemote_unk1:
    call call_00_38c1                                  ;; 02:526a $cd $c1 $38
    ld   E, A                                          ;; 02:526d $5f
    ld   H, $d2                                        ;; 02:526e $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5270 $fa $00 $d3
    or   A, $0a                                        ;; 02:5273 $f6 $0a
    ld   L, A                                          ;; 02:5275 $6f
    res  3, [HL]                                       ;; 02:5276 $cb $9e
    inc  E                                             ;; 02:5278 $1c
    dec  E                                             ;; 02:5279 $1d
    ret  NZ                                            ;; 02:527a $c0
    ld   A, [wD73B]                                    ;; 02:527b $fa $3b $d7
    and  A, $01                                        ;; 02:527e $e6 $01
    ret  Z                                             ;; 02:5280 $c8
    set  3, [HL]                                       ;; 02:5281 $cb $de
    ret                                                ;; 02:5283 $c9

call_02_5284_EntityAction_SilverRemote_unk0:
    ld   a,[wD59E]
    and  a
    ld   a,$01
    call nz,call_02_7102_SetEntityAction
call_02_528d_EntityAction_SilverRemote_unk1:
    ret  

call_02_528e_EntityAction_GoldRemote_unk0:
    ld   a,[wD59E]
    and  a
    ld   a,$01
    call nz,call_02_7102_SetEntityAction
call_02_5297_EntityAction_GoldRemote_unk1:
    ld   a,[wD649_CollectibleAmount]
    and  a
    jp   nz,call_00_3931
    ld   a,[wD73B]
    and  a,$1F
    ret  nz
    ld   c,$04
    call call_00_112f
    ret  

call_02_52aa_EntityAction_Unk02_Update:
    ret  

call_02_52ab_EntityAction_ParticleBurst_Update:
    call call_00_3b8d                                  ;; 02:52ab $cd $8d $3b
    jr   Z, .jr_02_52bc                                ;; 02:52ae $28 $0c
    farcall call_03_65f9
    ret  NZ                                            ;; 02:52bb $c0
.jr_02_52bc:
    ld   C, $01                                        ;; 02:52bc $0e $01
    call call_00_37e7                                  ;; 02:52be $cd $e7 $37
    ld   H, $d2                                        ;; 02:52c1 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:52c3 $fa $00 $d3
    or   A, $18                                        ;; 02:52c6 $f6 $18
    ld   L, A                                          ;; 02:52c8 $6f
    ld   [HL], $ff                                     ;; 02:52c9 $36 $ff
    ld   A, L                                          ;; 02:52cb $7d
    xor  A, $18                                        ;; 02:52cc $ee $18
    ld   L, A                                          ;; 02:52ce $6f
    ld   [HL], $01                                     ;; 02:52cf $36 $01
    ld   A, L                                          ;; 02:52d1 $7d
    xor  A, $14                                        ;; 02:52d2 $ee $14
    ld   L, A                                          ;; 02:52d4 $6f
    ld   A, $2c                                        ;; 02:52d5 $3e $2c
    ld   [HL+], A                                      ;; 02:52d7 $22
    ld   A, $10                                        ;; 02:52d8 $3e $10
    ld   [HL+], A                                      ;; 02:52da $22
    ld   A, $01                                        ;; 02:52db $3e $01
    ld   [HL], A                                       ;; 02:52dd $77
    ld   C, $02                                        ;; 02:52de $0e $02
    call call_00_3a23                                  ;; 02:52e0 $cd $23 $3a
    xor  A, A                                          ;; 02:52e3 $af
    jp   call_02_7102_SetEntityAction                                  ;; 02:52e4 $c3 $02 $71

call_02_52e7_EntityAction_Unk08_Update:
    ret  

call_02_52e8_EntityAction_ScreamTVFallingPlatform_Update:
    call call_00_34f5
    bit  0,[hl]
    jr   nz,.jr_02_52FF
    bit  1,[hl]
    jr   nz,.jr_02_5323
    bit  0,b
    ret  z
    set  0,[hl]
    inc  l
    ld   a,$64
    ldi  [hl],a
    ldi  a,[hl]
    ld   [hl],a
    ret  
.jr_02_52FF:
    inc  l
    ld   a,[hl]
    and  a
    jr   z,.jr_02_530C
    dec  [hl]
    ret  nz
    ld   c,$27
    call call_00_112f
    ret  
.jr_02_530C:
    inc  l
    inc  l
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_531C
    dec  l
    dec  l
    ld   [hl],$FA
    dec  l
    res  0,[hl]
    set  1,[hl]
    ret  
.jr_02_531C:
    dec  [hl]
    ld   bc,$0002
    jp   call_00_37d8
.jr_02_5323:
    bit  0,b
    jr   z,.jr_02_532F
    res  1,[hl]
    set  0,[hl]
    inc  l
    ld   [hl],$00
    ret  
.jr_02_532F:
    inc  l
    ld   a,[hl]
    and  a
    jr   z,.jr_02_5336
    dec  [hl]
    ret  
.jr_02_5336:
    inc  l
    ldi  a,[hl]
    cp   [hl]
    jr   nz,.jr_02_5341
    dec  l
    dec  l
    dec  l
    ld   [hl],$00
    ret  
.jr_02_5341:
    inc  [hl]
    ld   bc,$FFFE
    jp   call_00_37d8

call_02_5348_EntityAction_ScreamTVMovingPlatform_Update:
    call call_00_34ea                                  ;; 02:5348 $cd $ea $34
    jr   Z, .jr_02_5354                                ;; 02:534b $28 $07
    ld   A, L                                          ;; 02:534d $7d
    xor  A, $10                                        ;; 02:534e $ee $10
    ld   L, A                                          ;; 02:5350 $6f
    ld   A, [HL-]                                      ;; 02:5351 $3a
    dec  L                                             ;; 02:5352 $2d
    ld   [HL], A                                       ;; 02:5353 $77
.jr_02_5354:
    ld   H, $d2                                        ;; 02:5354 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5356 $fa $00 $d3
    or   A, $1a                                        ;; 02:5359 $f6 $1a
    ld   L, A                                          ;; 02:535b $6f
    ld   A, [HL]                                       ;; 02:535c $7e
    cp   A, $ff                                        ;; 02:535d $fe $ff
    jr   Z, .jr_02_536d                                ;; 02:535f $28 $0c
    and  A, $0f                                        ;; 02:5361 $e6 $0f
    ld   L, A                                          ;; 02:5363 $6f
    ld   H, $00                                        ;; 02:5364 $26 $00
    ld   DE, wD78B                                     ;; 02:5366 $11 $8b $d7
    add  HL, DE                                        ;; 02:5369 $19
    ld   A, [HL]                                       ;; 02:536a $7e
    and  A, A                                          ;; 02:536b $a7
    ret  Z                                             ;; 02:536c $c8
.jr_02_536d:
    call call_00_3559                                  ;; 02:536d $cd $59 $35
    jp   call_00_318d                                    ;; 02:5370 $c3 $8d $31

call_02_5373_EntityAction_ScreamTVPushBlock_Update:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ldi  a,[hl]
    sub  a,$A0
    ld   a,[hl]
    sbc  a,$02
    ret  nc
    ld   hl,wD78B
    ld   a,[hl]
    and  a
    ret  nz
    ld   [hl],$02
    ret  
    
call_02_5373_EntityAction_Pumpkin_unk0:
    call call_00_3843                                  ;; 02:538b $cd $43 $38
    ret  Z                                             ;; 02:538e $c8
    ld   C, $28                                        ;; 02:538f $0e $28
    call call_00_335a                                  ;; 02:5391 $cd $5a $33
    ld   A, $01                                        ;; 02:5394 $3e $01
    jp   call_02_7102_SetEntityAction                                  ;; 02:5396 $c3 $02 $71

call_02_5399_EntityAction_Pumpkin_unk1:
    call call_00_30af                                  ;; 02:5399 $cd $af $30
    call call_00_3154                                  ;; 02:539c $cd $54 $31
    ret  C                                             ;; 02:539f $d8
    ld   C, $24                                        ;; 02:53a0 $0e $24
    call call_00_112f                                  ;; 02:53a2 $cd $2f $11
    ld   A, $00                                        ;; 02:53a5 $3e $00
    jp   call_02_7102_SetEntityAction                                  ;; 02:53a7 $c3 $02 $71

call_02_53aa_EntityAction_Frankie_Update:
    jp   call_00_3364

call_02_53ad_EntityAction_HeadGhost_unk0:
    call call_00_34ea
    jr   z,.jr_02_53C3
    ld   a,l
    xor  a,$10
    ld   l,a
    ld   c,$00
    bit  0,[hl]
    jr   z,.jr_02_53BE
    ld   c,$20
.jr_02_53BE:
    ld   a,l
    xor  a,$14
    ld   l,a
    ld   [hl],c
.jr_02_53C3:
    call call_00_3843
    ret  z
    ld   c,$00
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_53d9_EntityAction_HeadGhost_unk1:
    call call_00_3843
    ld   a,$00
    call nz,call_02_7102_SetEntityAction
    ret  

call_02_53e2_EntityAction_GhostHead_Update:
    ld   c,$01
    call call_00_3350
    call call_00_3442
    call call_00_30af
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    inc  l
    ldi  a,[hl]
    add  a,$10
    ld   c,a
    ld   a,[hl]
    adc  a,$00
    ld   b,a
    ld   a,l
    xor  a,$16
    ld   l,a
    bit  5,[hl]
    jr   z,.jr_02_5417
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   a,e
    sub  [hl]
    ld   e,a
    inc  hl
    ld   a,d
    sbc  [hl]
    ld   d,a
    inc  hl
    jr   .jr_02_5421
.jr_02_5417:
    ld   a,l
    xor  a,$03
    ld   l,a
    ldi  a,[hl]
    sub  e
    ld   e,a
    ldi  a,[hl]
    sbc  d
    ld   d,a
.jr_02_5421:
    ld   a,c
    add  e
    ld   c,a
    ld   a,b
    adc  d
    ld   b,a
    ldi  a,[hl]
    sub  c
    ld   a,[hl]
    sbc  b
    ret  c
    ld   [hl],b
    dec  l
    ld   [hl],c
    ld   c,$28
    jp   call_00_335a

call_02_5434_EntityAction_FloatingSkull_unk0:
    call call_00_3843
    ret  z
    call call_00_36bd
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5440_EntityAction_FloatingSkull_unk1:
    call call_00_3843
    ret  z
    ld   c,$34
    call call_00_112f
    ld   c,$01
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_545b_EntityAction_FloatingSkull_unk2:
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5464_EntityAction_FloatingSkullProjectile_unk0:
    ld   c,$06
    call call_00_3a23
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_546e_EntityAction_FloatingSkullProjectile_unk1:
    call call_00_3b8d
    jp   z,call_00_3931
    farcall call_03_6549
    ret  

call_02_5480_EntityAction_Zombie_unk0:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ld   [hl],$02
    inc  l
    inc  l
    ld   [hl],$01
    ld   a,l
    xor  a,$0B
    ld   l,a
    bit  0,[hl]
    jp   z,call_00_3364
    ld   a,l
    xor  a,$16
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$00
    jr   nz,.jr_02_54AF
    ld   c,$02
    farcall call_0a_7b9a_SpawnEntityRelative
.jr_02_54AF:
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_54b4_EntityAction_Zombie_unk2:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    dec  [hl]
    ret  nz
    dec  l
    res  0,[hl]
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_54c6_EntityAction_ZombieHead_unk0:
    ld   c,$28
    call call_00_335a
    ld   c,$03
    call call_00_3802
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],$00
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_54df_EntityAction_ZombieHead_unk1:
    call call_00_30af
    call call_00_3137
    ret  c
    call call_00_3817
    ld   a,$02
    jp   z,call_02_7102_SetEntityAction
    ld   l,[hl]
    ld   h,$00
    ld   de,.data_02_54f9
    add  hl,de
    ld   c,[hl]
    jp   call_00_335a
.data_02_54f9:
    db   $00, $0a, $14

call_02_54fc_EntityAction_ZombieHead_unk2:
    jp   call_00_36bd

call_02_54ff_EntityAction_FallingAxe_unk0:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   a,[wD73B]
    and  a,$7F
    cp   [hl]
    ld   a,$01
    jp   z,call_02_7102_SetEntityAction
    ret  

call_02_5513_EntityAction_FallingAxe_unk1:
    ld   bc,$0002
    call call_00_37d8
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    inc  [hl]
    inc  [hl]
    ld   a,[hl]
    cp   a,$24
    ret  nz
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_552c_EntityAction_FallingAxe_unk2:
    call call_00_3843
    ld   a,$03
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5535_EntityAction_FallingAxe_unk3:
    ld   bc,$FFFF
    call call_00_37d8
    call call_00_3817
    ld   a,$00
    jp   z,call_02_7102_SetEntityAction
    ret  

call_02_5544_EntityAction_Lantern_unk0:
    call call_02_555e_Lantern_Sub
    ld   a,[wD757]
    and  a
    ret  nz
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5551_EntityAction_Lantern_unk1:
    call call_02_555e_Lantern_Sub
    ld   a,[wD757]
    and  a
    ret  z
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_555e_Lantern_Sub:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    inc  [hl]
    ld   a,[hl]
    and  a,$01
    ret  nz
    bit  2,[hl]
    ret  z
    ld   bc,$0001
    bit  3,[hl]
    jp   z,call_00_37d8
    ld   bc,$FFFF
    jp   call_00_37d8

call_02_557c_EntityAction_Bat_Update:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    ld   [hl],$01
    jp   call_00_3364

call_02_5589_EntityAction_ScreamTVOrangeMovingPlatform_Update:
    call call_00_34ea
    jr   z,.jr_02_5595
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5595:
    call call_00_3559
    jp   call_00_318d

call_02_559b_EntityAction_ScreamTVDoorOpening_None:
    ret  

call_02_559c_EntityAction_ScreamTVDoorOpening_unk1:
    call call_00_3843
    call nz,call_00_3931
    ret  

call_02_55a3_EntityAction_Ghost_unk0:
    call call_00_3843
    ret  z
    ld   h,$d2
    ld   a,$20
.jr_02_55AB:
    ld   l,a
    ld   a,[hl]
    cp   a,$15
    jr   z,.jr_02_55B9
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_55AB
    jp   call_00_3910
.jr_02_55B9:
    ld   a,l
    or   a,$0E
    ld   l,a
    ld   d,h
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   e,a
    ld   bc,$0030
    ld   a,[wD20D_PlayerFacingAngle]
    bit  5,a
    jr   z,.jr_02_55D1
    ld   bc,$FFD0
.jr_02_55D1:
    ldi  a,[hl]
    add  c
    ld   [de],a
    inc  e
    ldi  a,[hl]
    adc  b
    ld   [de],a
    inc  e
    ldi  a,[hl]
    add  a,$38
    ld   [de],a
    inc  e
    ldi  a,[hl]
    adc  a,$00
    ld   [de],a
    inc  e
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_55e8_EntityAction_Ghost_unk1:
    call call_00_3843
    ret  z
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_55f1_EntityAction_Ghost_unk2:
    ld   a,[wD757]
    and  a
    jr   nz,.jr_02_5608
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   l
    ld   l,a
    bit  0,[hl]
    ret  z
    res  0,[hl]
    ld   a,$00
    jp   call_02_7102_SetEntityAction
.jr_02_5608:
    ld   c,$00
    call call_00_3350
    ld   a,$03
    jp   call_02_7102_SetEntityAction

call_02_5612_EntityAction_Ghost_unk3:
    ld   a,[wD757]
    and  a
    jr   z,.jr_02_5623
    call call_00_3531
    jr   c,.jr_02_5623
    call call_00_36bd
    jp   call_00_3251
.jr_02_5623:
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_5628_EntityAction_ClimbWallSunEnemy_Update:
    call call_00_34ea
    jr   z,.jr_02_5634
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5634:
    call call_00_3559
    jp   call_00_318d

call_02_563a_EntityAction_ScreamTVVanishingPlatform_unk0:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   l,a
    ld   a,[wD73B]
    cp   [hl]
    ret  nz
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   [hl],$40
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5652_EntityAction_ScreamTVVanishingPlatform_unk1:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    dec  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$12
    ld   l,a
    res  3,[hl]
    ld   a,c
    and  a
    jr   z,.jr_02_5687
    cp   a,$40
    ret  nc
    push hl
    srl  a
    srl  a
    srl  a
    ld   e,a
    ld   d,$00
    ld   hl,.data_02_5691
    add  hl,de
    ld   b,[hl]
    ld   a,c
    and  a,$07
    ld   e,a
    ld   hl,.data_02_5699
    add  hl,de
    ld   a,[hl]
    pop  hl
    and  b
    ret  nz
    set  3,[hl]
    ret  
.jr_02_5687:
    ld   c,$00
    call call_00_382f
    ld   a,$02
    jp   call_02_7102_SetEntityAction
.data_02_5691:
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_5699:
    db   $01, $02, $04, $08, $10, $20, $40, $80

call_02_56a1_EntityAction_ScreamTVVanishingPlatform_unk2:
    call call_00_3843
    ret  z
    ld   c,$10
    call call_00_382f
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_56af_EntityAction_MonaLisaElevator_Update:
    call call_00_34ea
    jr   z,.jr_02_56BB
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_56BB:
    ld   a,[wD78B]
    and  a
    ret  z
    call call_00_3559
    call call_00_34f5
    bit  0,[hl]
    jr   nz,.jr_02_56D9
    bit  0,b
    ret  z
    set  0,[hl]
    ld   a,[hl]
    and  a,$3F
    ld   c,a
    rlca 
    rlca 
    and  a,$C0
    or   c
    ld   [hl],a
.jr_02_56D9:
    jp   call_00_318d

call_02_56dc_EntityAction_HardHeadAreaObject_unk0:
    ld   H, $d2                                        ;; 02:56dc $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:56de $fa $00 $d3
    or   A, $10                                        ;; 02:56e1 $f6 $10
    ld   L, A                                          ;; 02:56e3 $6f
    ld   A, [wD6EF_YPositionInMap]                                    ;; 02:56e4 $fa $ef $d6
    sub  A, $18                                        ;; 02:56e7 $d6 $18
    ld   [HL+], A                                      ;; 02:56e9 $22
    ld   A, [wD6F0]                                    ;; 02:56ea $fa $f0 $d6
    sbc  A, $00                                        ;; 02:56ed $de $00
    ld   [HL], A                                       ;; 02:56ef $77
    ld   A, [wD75D_PlayerXSpeedPrev]                                    ;; 02:56f0 $fa $5d $d7
    add  A, A                                          ;; 02:56f3 $87
    ld   HL, wD20D_PlayerFacingAngle                                     ;; 02:56f4 $21 $0d $d2
    bit  5, [HL]                                       ;; 02:56f7 $cb $6e
    jr   Z, .jr_02_56fc                                ;; 02:56f9 $28 $01
    inc  A                                             ;; 02:56fb $3c
.jr_02_56fc:
    ld   L, A                                          ;; 02:56fc $6f
    ld   H, $00                                        ;; 02:56fd $26 $00
    add  HL, HL                                        ;; 02:56ff $29
    ld   DE, .data_02_575e                             ;; 02:5700 $11 $5e $57
    add  HL, DE                                        ;; 02:5703 $19
    ld   A, [wD20E_PlayerXPosition]                                    ;; 02:5704 $fa $0e $d2
    add  A, [HL]                                       ;; 02:5707 $86
    ld   C, A                                          ;; 02:5708 $4f
    inc  HL                                            ;; 02:5709 $23
    ld   A, [wD20F_PlayerXPosition]                                    ;; 02:570a $fa $0f $d2
    adc  A, [HL]                                       ;; 02:570d $8e
    ld   B, A                                          ;; 02:570e $47
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:570f $fa $00 $d3
    rrca                                               ;; 02:5712 $0f
    rrca                                               ;; 02:5713 $0f
    rrca                                               ;; 02:5714 $0f
    and  A, $1c                                        ;; 02:5715 $e6 $1c
    ld   L, A                                          ;; 02:5717 $6f
    ld   H, $00                                        ;; 02:5718 $26 $00
    ld   DE, wD309                                     ;; 02:571a $11 $09 $d3
    add  HL, DE                                        ;; 02:571d $19
    ld   D, [HL]                                       ;; 02:571e $56
    dec  D                                             ;; 02:571f $15
    inc  HL                                            ;; 02:5720 $23
    ld   E, [HL]                                       ;; 02:5721 $5e
    inc  E                                             ;; 02:5722 $1c
    ld   L, C                                          ;; 02:5723 $69
    ld   H, B                                          ;; 02:5724 $60
    add  HL, HL                                        ;; 02:5725 $29
    add  HL, HL                                        ;; 02:5726 $29
    add  HL, HL                                        ;; 02:5727 $29
    ld   A, H                                          ;; 02:5728 $7c
    cp   A, E                                          ;; 02:5729 $bb
    ret  C                                             ;; 02:572a $d8
    ld   A, D                                          ;; 02:572b $7a
    cp   A, H                                          ;; 02:572c $bc
    ret  C                                             ;; 02:572d $d8
    ld   H, $d2                                        ;; 02:572e $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5730 $fa $00 $d3
    or   A, $0e                                        ;; 02:5733 $f6 $0e
    ld   L, A                                          ;; 02:5735 $6f
    ld   [HL], C                                       ;; 02:5736 $71
    inc  L                                             ;; 02:5737 $2c
    ld   [HL], B                                       ;; 02:5738 $70
    ld   A, L                                          ;; 02:5739 $7d
    xor  A, $17                                        ;; 02:573a $ee $17
    ld   L, A                                          ;; 02:573c $6f
    ld   A, [HL]                                       ;; 02:573d $7e
    and  A, A                                          ;; 02:573e $a7
    jr   Z, .jr_02_5743                                ;; 02:573f $28 $02
    dec  [HL]                                          ;; 02:5741 $35
    ret  NZ                                            ;; 02:5742 $c0
.jr_02_5743:
    dec  L                                             ;; 02:5743 $2d
    ld   [HL], $00                                     ;; 02:5744 $36 $00
    ld   A, [wD20E_PlayerXPosition]                                    ;; 02:5746 $fa $0e $d2
    swap A                                             ;; 02:5749 $cb $37
    and  A, $03                                        ;; 02:574b $e6 $03
    ld   L, A                                          ;; 02:574d $6f
    ld   H, $00                                        ;; 02:574e $26 $00
    ld   DE, .data_02_576a                             ;; 02:5750 $11 $6a $57
    add  HL, DE                                        ;; 02:5753 $19
    ld   A, [HL]                                       ;; 02:5754 $7e
    call call_02_7102_SetEntityAction                                  ;; 02:5755 $cd $02 $71
    ld   C, $19                                        ;; 02:5758 $0e $19
    call call_00_112f                                  ;; 02:575a $cd $2f $11
    ret                                                ;; 02:575d $c9
.data_02_575e:
    db   $00, $00, $00, $00, $24, $00, $dc, $ff        ;; 02:575e ????????
    db   $48, $00, $b8, $ff                            ;; 02:5766 ????
.data_02_576a:
    db   $01, $02, $01, $02                            ;; 02:576a .??.

call_02_576e_EntityAction_HardHeadAreaObject_unk1:
    ld   H, $d2                                        ;; 02:576e $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5770 $fa $00 $d3
    or   A, $17                                        ;; 02:5773 $f6 $17
    ld   L, A                                          ;; 02:5775 $6f
    bit  0, [HL]                                       ;; 02:5776 $cb $46
    jr   NZ, .jr_02_5794                               ;; 02:5778 $20 $1a
    call call_00_30af                                  ;; 02:577a $cd $af $30
    call call_00_3154                                  ;; 02:577d $cd $54 $31
    ret  C                                             ;; 02:5780 $d8
    ld   C, $1a                                        ;; 02:5781 $0e $1a
    call call_00_112f                                  ;; 02:5783 $cd $2f $11
    ld   H, $d2                                        ;; 02:5786 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5788 $fa $00 $d3
    or   A, $17                                        ;; 02:578b $f6 $17
    ld   L, A                                          ;; 02:578d $6f
    set  0, [HL]                                       ;; 02:578e $cb $c6
    inc  L                                             ;; 02:5790 $2c
    ld   [HL], $80                                     ;; 02:5791 $36 $80
    ret                                                ;; 02:5793 $c9
.jr_02_5794:
    inc  L                                             ;; 02:5794 $2c
    dec  [HL]                                          ;; 02:5795 $35
    ld   C, [HL]                                       ;; 02:5796 $4e
    ld   A, L                                          ;; 02:5797 $7d
    xor  A, $12                                        ;; 02:5798 $ee $12
    ld   L, A                                          ;; 02:579a $6f
    res  3, [HL]                                       ;; 02:579b $cb $9e
    ld   A, C                                          ;; 02:579d $79
    and  A, A                                          ;; 02:579e $a7
    jr   Z, .jr_02_57c2                                ;; 02:579f $28 $21
    cp   A, $40                                        ;; 02:57a1 $fe $40
    ret  NC                                            ;; 02:57a3 $d0
    push HL                                            ;; 02:57a4 $e5
    srl  A                                             ;; 02:57a5 $cb $3f
    srl  A                                             ;; 02:57a7 $cb $3f
    srl  A                                             ;; 02:57a9 $cb $3f
    ld   E, A                                          ;; 02:57ab $5f
    ld   D, $00                                        ;; 02:57ac $16 $00
    ld   HL, .data_02_57e3                             ;; 02:57ae $21 $e3 $57
    add  HL, DE                                        ;; 02:57b1 $19
    ld   B, [HL]                                       ;; 02:57b2 $46
    ld   A, C                                          ;; 02:57b3 $79
    and  A, $07                                        ;; 02:57b4 $e6 $07
    ld   E, A                                          ;; 02:57b6 $5f
    ld   HL, .data_02_57eb                             ;; 02:57b7 $21 $eb $57
    add  HL, DE                                        ;; 02:57ba $19
    ld   A, [HL]                                       ;; 02:57bb $7e
    pop  HL                                            ;; 02:57bc $e1
    and  A, B                                          ;; 02:57bd $a0
    ret  NZ                                            ;; 02:57be $c0
    set  3, [HL]                                       ;; 02:57bf $cb $de
    ret                                                ;; 02:57c1 $c9
.jr_02_57c2:
    ld   A, L                                          ;; 02:57c2 $7d
    xor  A, $1a                                        ;; 02:57c3 $ee $1a
    ld   L, A                                          ;; 02:57c5 $6f
    ld   A, [wD6EF_YPositionInMap]                                    ;; 02:57c6 $fa $ef $d6
    sub  A, $18                                        ;; 02:57c9 $d6 $18
    ld   [HL+], A                                      ;; 02:57cb $22
    ld   A, [wD6F0]                                    ;; 02:57cc $fa $f0 $d6
    sbc  A, $00                                        ;; 02:57cf $de $00
    ld   [HL], A                                       ;; 02:57d1 $77
    ld   A, L                                          ;; 02:57d2 $7d
    xor  A, $09                                        ;; 02:57d3 $ee $09
    ld   L, A                                          ;; 02:57d5 $6f
    ld   A, [wD20E_PlayerXPosition]                                    ;; 02:57d6 $fa $0e $d2
    and  A, $1f                                        ;; 02:57d9 $e6 $1f
    or   A, $20                                        ;; 02:57db $f6 $20
    ld   [HL], A                                       ;; 02:57dd $77
    ld   A, $00                                        ;; 02:57de $3e $00
    jp   call_02_7102_SetEntityAction                                  ;; 02:57e0 $c3 $02 $71
.data_02_57e3:
    db   $00, $01, $11, $11, $55, $55, $55, $ff        ;; 02:57e3 ........
.data_02_57eb:
    db   $01, $02, $04, $08, $10, $20, $40, $80        ;; 02:57eb ........

call_02_57f3_EntityAction_StationaryBearTrap_unk0:
    call call_00_3817
    ret  nz
    ld   [hl],$FF
    ld   c,$24
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5803_EntityAction_StationaryBearTrap_unk1:
    call call_00_30af
    ld   bc,$0008
    call call_00_316e
    ld   a,$00
    jp   nc,call_02_7102_SetEntityAction
    ret  

call_02_5812_EntityAction_MovingBearTrap_unk0:
    call call_00_34ea
    jr   z,.jr_02_581C
    ld   c,$10
    call call_00_3350
.jr_02_581C:
    call call_00_30af
    call call_00_3154
    call call_00_3843
    ret  z
    ld   c,$24
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5830_EntityAction_MovingBearTrap_unk1:
    call call_00_30af
    call call_00_3154
    jp   c,call_00_36f7
    ld   c,$09
    call call_00_335a
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_5843_EntityAction_Bumblebee_unk0:
    ld   C, $08                                        ;; 02:5843 $0e $08
    call call_00_32e1                                  ;; 02:5845 $cd $e1 $32
    call call_00_36f7                                  ;; 02:5848 $cd $f7 $36
    ld   C, $20                                        ;; 02:584b $0e $20
    call call_00_3859                                  ;; 02:584d $cd $59 $38
    ret  NC                                            ;; 02:5850 $d0
    call call_00_36bd                                  ;; 02:5851 $cd $bd $36
    ld   C, $1d                                        ;; 02:5854 $0e $1d
    call call_00_112f                                  ;; 02:5856 $cd $2f $11
    ld   A, $01                                        ;; 02:5859 $3e $01
    jp   call_02_7102_SetEntityAction                                  ;; 02:585b $c3 $02 $71

call_02_585e_EntityAction_Bumblebee_unk1:
    ld   c,$20
    call call_00_32e1
    call call_00_36f7
    ld   c,$40
    call call_00_3859
    ret  c
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_5871_EntityAction_BowlingBall_Update:
    call call_00_30af
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    push hl
    bit  7,[hl]
    call nz,call_00_36f7
    pop  hl
    ld   l,[hl]
    res  7,l
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_58c1
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    call call_00_316e
    ret  c
    ld   c,$1A
    call call_00_112f
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    dec  [hl]
    ld   a,[hl]
    and  a,$7F
    cp   a,$7F
    ld   c,$24
    jp   nz,call_00_335a
    inc  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$08
    ld   l,a
    ld   de,$0A40
    ld   [hl],e
    inc  l
    ld   [hl],d
    ld   a,c
    and  a,$80
    add  a,$08
    ld   c,a
    jp   call_00_3802
.data_02_58c1:
    db   $80, $00, $00, $00, $c0        ;; 02:58be ????????
    db   $ff, $80, $ff, $40, $ff, $00, $ff, $c0        ;; 02:58c6 ????????
    db   $fe, $80, $fe, $40, $fe                       ;; 02:58ce ?????

call_02_58d3_EntityAction_Cactus_unk0:
    ld   C, $40                                        ;; 02:58d3 $0e $40
    call call_00_3859                                  ;; 02:58d5 $cd $59 $38
    ret  NC                                            ;; 02:58d8 $d0
    ld   A, [wD73C]                                    ;; 02:58d9 $fa $3c $d7
    and  A, $03                                        ;; 02:58dc $e6 $03
    inc  A                                             ;; 02:58de $3c
    ld   C, A                                          ;; 02:58df $4f
    call call_00_3802                                  ;; 02:58e0 $cd $02 $38
    ld   A, $01                                        ;; 02:58e3 $3e $01
    jp   call_02_7102_SetEntityAction                                  ;; 02:58e5 $c3 $02 $71

call_02_58e8_EntityAction_Cactus_unk1:
    call call_00_3843                                  ;; 02:58e8 $cd $43 $38
    ret  Z                                             ;; 02:58eb $c8
    call call_00_3817                                  ;; 02:58ec $cd $17 $38
    ret  NZ                                            ;; 02:58ef $c0
    ld   C, $34                                        ;; 02:58f0 $0e $34
    call call_00_335a                                  ;; 02:58f2 $cd $5a $33
    ld   A, $02                                        ;; 02:58f5 $3e $02
    jp   call_02_7102_SetEntityAction                                  ;; 02:58f7 $c3 $02 $71

call_02_58fa_EntityAction_Cactus_unk2:
    call call_00_30af                                  ;; 02:58fa $cd $af $30
    call call_00_3154                                  ;; 02:58fd $cd $54 $31
    ret  C                                             ;; 02:5900 $d8
    ld   C, $24                                        ;; 02:5901 $0e $24
    call call_00_112f                                  ;; 02:5903 $cd $2f $11
    ld   A, $00                                        ;; 02:5906 $3e $00
    jp   call_02_7102_SetEntityAction                                  ;; 02:5908 $c3 $02 $71

call_02_590b_EntityAction_Domino_Update:
    call call_00_30af
    call call_00_3154
    ret  c
    ld   c,$1A
    call call_00_112f
    ld   c,$40
    jp   call_00_335a

call_02_591c_EntityAction_Shark_Update:
    ld   C, $30                                        ;; 02:591c $0e $30
    call call_00_3859                                  ;; 02:591e $cd $59 $38
    ld   C, $20                                        ;; 02:5921 $0e $20
    jr   C, .jr_02_5927                                ;; 02:5923 $38 $02
    ld   C, $08                                        ;; 02:5925 $0e $08
.jr_02_5927:
    call call_00_32e1                                  ;; 02:5927 $cd $e1 $32
    jp   call_00_36f7                                  ;; 02:592a $c3 $f7 $36
call_02_592d_EntityAction_Flower_Update:
    call call_00_36bd                                  ;; 02:592d $cd $bd $36
    ld   C, $20                                        ;; 02:5930 $0e $20
    call call_00_3859                                  ;; 02:5932 $cd $59 $38
    ld   A, $02                                        ;; 02:5935 $3e $02
    jr   C, .jr_02_5944                                ;; 02:5937 $38 $0b
    ld   C, $30                                        ;; 02:5939 $0e $30
    call call_00_3859                                  ;; 02:593b $cd $59 $38
    ld   A, $01                                        ;; 02:593e $3e $01
    jr   C, .jr_02_5944                                ;; 02:5940 $38 $02
    ld   A, $00                                        ;; 02:5942 $3e $00
.jr_02_5944:
    push AF                                            ;; 02:5944 $f5
    call call_02_7102_SetEntityAction                                  ;; 02:5945 $cd $02 $71
    ld   H, $d2                                        ;; 02:5948 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:594a $fa $00 $d3
    or   A, $18                                        ;; 02:594d $f6 $18
    ld   L, A                                          ;; 02:594f $6f
    inc  [HL]                                          ;; 02:5950 $34
    dec  [HL]                                          ;; 02:5951 $35
    jr   Z, .jr_02_5955                                ;; 02:5952 $28 $01
    dec  [HL]                                          ;; 02:5954 $35
.jr_02_5955:
    pop  AF                                            ;; 02:5955 $f1
    cp   A, $02                                        ;; 02:5956 $fe $02
    ret  NZ                                            ;; 02:5958 $c0
    ld   A, [HL]                                       ;; 02:5959 $7e
    and  A, A                                          ;; 02:595a $a7
    ret  NZ                                            ;; 02:595b $c0
    ld   [HL], $3c                                     ;; 02:595c $36 $3c
    ld   C, $03                                        ;; 02:595e $0e $03
    farcall call_0a_7b9a_SpawnEntityRelative
    ret                                                ;; 02:596b $c9
call_02_596c_EntityAction_FlowerHammer_unk0:
    call call_00_3843                                  ;; 02:596c $cd $43 $38
    ret  Z                                             ;; 02:596f $c8
    ld   C, $1c                                        ;; 02:5970 $0e $1c
    call call_00_112f                                  ;; 02:5972 $cd $2f $11
    ld   A, $01                                        ;; 02:5975 $3e $01
    jp   call_02_7102_SetEntityAction                                  ;; 02:5977 $c3 $02 $71
call_02_597a_EntityAction_FlowerHammer_unk1:
    call call_00_30af                                  ;; 02:597a $cd $af $30
    call call_00_30af                                  ;; 02:597d $cd $af $30
    ld   BC, $0c                                       ;; 02:5980 $01 $0c $00
    call call_00_316e                                  ;; 02:5983 $cd $6e $31
    ld   A, $02                                        ;; 02:5986 $3e $02
    jp   NC, call_02_7102_SetEntityAction                              ;; 02:5988 $d2 $02 $71
    ret                                                ;; 02:598b $c9
call_02_598c_EntityAction_FlowerHammer_unk2:
    call call_00_3843                                  ;; 02:598c $cd $43 $38
    jp   NZ, call_00_3910                              ;; 02:598f $c2 $10 $39
    ret                                                ;; 02:5992 $c9

call_02_5993_EntityAction_Hunter_unk0:
    call call_00_34ea
    jr   z,.jr_02_599D
    ld   c,$03
    call call_00_3802
.jr_02_599D:
    ld   a,[wD73B]
    and  a,$7F
    jr   nz,.jr_02_59BE
    call call_00_36bd
    ld   c,$20
    call call_00_112f
    ld   c,$0B
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   a,$01
    jp   call_02_7102_SetEntityAction
.jr_02_59BE:
    ld   c,$08
    call call_00_32e1
    call call_00_36f7
    jr   call_02_5A00_Hunter_Sub

call_02_59c8_EntityAction_Hunter_unk1:
    call call_00_3843
    jr   z,call_02_5A00_Hunter_Sub
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_59d2_EntityAction_Hunter_unk2:
    call call_00_3843
    ld   a,$03
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_59db_EntityAction_Hunter_unk3:
    call call_00_3843
    ld   a,$04
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_59e4_EntityAction_Hunter_unk4:
    call call_00_3843
    ld   a,$05
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_59ed_EntityAction_Hunter_unk5:
    call call_00_3843
    ret  z
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    res  0,[hl]
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_5A00_Hunter_Sub:
    ld   h,$d2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    ret  z
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_5a10_EntityAction_HunterBullet_unk0:
    ld   c,$01
    call call_00_3350
    ld   c,$5A
    call call_00_3802
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5a1f_EntityAction_HunterBullet_unk1:
    call call_00_3817
    jp   z,call_00_3910
    jp   call_00_3442

call_02_5a28_EntityAction_Mushroom_Update:
    ld   H, $d2                                        ;; 02:5a28 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5a2a $fa $00 $d3
    or   A, $17                                        ;; 02:5a2d $f6 $17
    ld   L, A                                          ;; 02:5a2f $6f
    bit  0, [HL]                                       ;; 02:5a30 $cb $46
    ret  Z                                             ;; 02:5a32 $c8
    ld   HL, wD774                                     ;; 02:5a33 $21 $74 $d7
    inc  [HL]                                          ;; 02:5a36 $34
    ld   A, [HL]                                       ;; 02:5a37 $7e
    cp   A, $05                                        ;; 02:5a38 $fe $05
    jr   NZ, .jr_02_5a41                               ;; 02:5a3a $20 $05
    ld   HL, wD79A                                     ;; 02:5a3c $21 $9a $d7
    ld   [HL], $02                                     ;; 02:5a3f $36 $02
.jr_02_5a41:
    ld   C, $08                                        ;; 02:5a41 $0e $08
    farcall call_0a_7b9a_SpawnEntityRelative
    call call_00_3985                                  ;; 02:5a4e $cd $85 $39
    ld   H, $d2                                        ;; 02:5a51 $26 $d2
    ld   A, $20                                        ;; 02:5a53 $3e $20
.jr_02_5a55:
    ld   L, A                                          ;; 02:5a55 $6f
    ld   A, [HL]                                       ;; 02:5a56 $7e
    cp   A, $28                                        ;; 02:5a57 $fe $28
    jr   Z, .jr_02_5a61                                ;; 02:5a59 $28 $06
    ld   A, L                                          ;; 02:5a5b $7d
    add  A, $20                                        ;; 02:5a5c $c6 $20
    jr   NZ, .jr_02_5a55                               ;; 02:5a5e $20 $f5
    ret                                                ;; 02:5a60 $c9
.jr_02_5a61:
    ld   A, L                                          ;; 02:5a61 $7d
    or   A, $1e                                        ;; 02:5a62 $f6 $1e
    ld   L, A                                          ;; 02:5a64 $6f
    ld   [HL], $40                                     ;; 02:5a65 $36 $40
    xor  A, $16                                        ;; 02:5a67 $ee $16
    ld   L, A                                          ;; 02:5a69 $6f
    ld   A, [wD774]                                    ;; 02:5a6a $fa $74 $d7
    dec  A                                             ;; 02:5a6d $3d
    add  A, A                                          ;; 02:5a6e $87
    add  A, $40                                        ;; 02:5a6f $c6 $40
    ld   [HL], A                                       ;; 02:5a71 $77
    ret                                                ;; 02:5a72 $c9
call_02_5a73_EntityAction_Unk28_Update:
    call call_00_30af                                  ;; 02:5a73 $cd $af $30
    call call_00_3154                                  ;; 02:5a76 $cd $54 $31
    jp   NC, call_00_3910                              ;; 02:5a79 $d2 $10 $39
    ret                                                ;; 02:5a7c $c9

call_02_5a7d_EntityAction_Lizard_Update:
    ld   a,[wD73B]
    and  a,$3F
    jr   nz,.jr_02_5A84
.jr_02_5A84:
    ld   c,$14
    call call_00_32e1
    jp   call_00_36f7

call_02_5a8c_EntityAction_HappyFace_unk0:
    call call_00_3843                                  ;; 02:5a8c $cd $43 $38
    ret  Z                                             ;; 02:5a8f $c8
    ld   C, $28                                        ;; 02:5a90 $0e $28
    call call_00_335a                                  ;; 02:5a92 $cd $5a $33
    ld   A, $01                                        ;; 02:5a95 $3e $01
    jp   call_02_7102_SetEntityAction                                  ;; 02:5a97 $c3 $02 $71
call_02_5a9a_EntityAction_HappyFace_unk1:
    call call_00_30af                                  ;; 02:5a9a $cd $af $30
    call call_00_3154                                  ;; 02:5a9d $cd $54 $31
    ret  C                                             ;; 02:5aa0 $d8
    ld   C, $24                                        ;; 02:5aa1 $0e $24
    call call_00_112f                                  ;; 02:5aa3 $cd $2f $11
    ld   A, $00                                        ;; 02:5aa6 $3e $00
    jp   call_02_7102_SetEntityAction                                  ;; 02:5aa8 $c3 $02 $71

call_02_5aab_EntityAction_ToonTVVanishingBlock_unk0:
    call call_00_34ea
    jr   z,.jr_02_5AB7
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5AB7:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    jr   z,.jr_02_5AD2
    inc  l
    inc  l
    inc  l
    ld   l,[hl]
    ld   h,$00
    ld   de,wD78B
    add  hl,de
    ld   a,[hl]
    and  a
    jp   z,call_00_3910
.jr_02_5AD2:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   l,a
    ld   a,[wD73B]
    cp   [hl]
    ret  nz
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   [hl],$40
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5aea_EntityAction_ToonTVVanishingBlock_unk1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    dec  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$12
    ld   l,a
    res  3,[hl]
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
    set  3,[hl]
    ret  
.jr_02_5B1F:
    ld   c,$00
    call call_00_382f
    ld   a,$02
    jp   call_02_7102_SetEntityAction
.data_02_5b29:
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_5b31:
    db   $01, $02, $04, $08, $10, $20, $40, $80

call_02_5b39_EntityAction_ToonTVVanishingBlock_unk2:
    call call_00_3843
    ret  z
    ld   c,$08
    call call_00_382f
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_5b47_EntityAction_ToonTVMovingBlock_unk0:
    call call_00_34ea
    jr   z,.jr_02_5B53
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5B53:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ldd  a,[hl]
    cp   a,$FF
    jr   z,.jr_02_5B97
    and  a,$0F
    add  a,$8B
    ld   e,a
    ld   a,$00
    adc  a,$D7
    ld   d,a
    dec  l
    dec  l
    bit  2,[hl]
    jr   z,.jr_02_5B90
    bit  3,[hl]
    jr   z,.jr_02_5B97
    bit  0,[hl]
    jr   nz,.jr_02_5B97
    ld   a,[hl]
    and  a,$C0
    ld   c,a
    ld   a,[hl]
    rlca 
    rlca 
    and  a,$C0
    sub  c
    jr   nz,.jr_02_5B88
    ld   [de],a
    res  2,[hl]
    ret  
.jr_02_5B88:
    inc  l
    ld   [hl],$46
    ld   a,01
    jp   call_02_7102_SetEntityAction
.jr_02_5B90:
    ld   a,[de]
    and  a
    ret  z
    set  2,[hl]
    set  0,[hl]
.jr_02_5B97:
    call call_00_3559
    jp   call_00_318d

call_02_5b9d_EntityAction_ToonTVMovingBlock_unk1:
    ld   a,[wD73B]
    and  a,$07
    ret  nz
    call call_00_3817
    ret  nz
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  0,[hl]
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_5bb6_EntityAction_MovingLog_Update:
    call call_00_34ea                                  ;; 02:5bb6 $cd $ea $34
    jr   Z, .jr_02_5bc2                                ;; 02:5bb9 $28 $07
    ld   A, L                                          ;; 02:5bbb $7d
    xor  A, $10                                        ;; 02:5bbc $ee $10
    ld   L, A                                          ;; 02:5bbe $6f
    ld   A, [HL-]                                      ;; 02:5bbf $3a
    dec  L                                             ;; 02:5bc0 $2d
    ld   [HL], A                                       ;; 02:5bc1 $77
.jr_02_5bc2:
    ld   H, $d2                                        ;; 02:5bc2 $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:5bc4 $fa $00 $d3
    or   A, $1a                                        ;; 02:5bc7 $f6 $1a
    ld   L, A                                          ;; 02:5bc9 $6f
    ld   A, [HL]                                       ;; 02:5bca $7e
    cp   A, $ff                                        ;; 02:5bcb $fe $ff
    jr   Z, .jr_02_5bdb                                ;; 02:5bcd $28 $0c
    and  A, $0f                                        ;; 02:5bcf $e6 $0f
    ld   L, A                                          ;; 02:5bd1 $6f
    ld   H, $00                                        ;; 02:5bd2 $26 $00
    ld   DE, wD78B                                     ;; 02:5bd4 $11 $8b $d7
    add  HL, DE                                        ;; 02:5bd7 $19
    ld   A, [HL]                                       ;; 02:5bd8 $7e
    and  A, A                                          ;; 02:5bd9 $a7
    ret  Z                                             ;; 02:5bda $c8
.jr_02_5bdb:
    call call_00_3559                                  ;; 02:5bdb $cd $59 $35
    jp   call_00_318d                                    ;; 02:5bde $c3 $8d $31
call_02_5be1_EntityAction_StationaryLog_Update:
    ret                                                ;; 02:5be1 $c9
    
call_02_5be2_EntityAction_Rocket_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  7,[hl]
    ret  z
    ld   c,$1E
    call call_00_112f
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5bf7_EntityAction_Rocket_unk1:
    call call_00_3843
    ld   a,$02
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5c00_EntityAction_Rocket_unk2:
    ld   c,$c0
    call call_00_3316
    jp   call_00_3597

call_02_5c08_EntityAction_FastDinosaur_Update:
    ld   c,$22
    call call_00_32e1
    jp   call_00_36f7

call_02_5c10_EntityAction_Dragonfly_Update:
    ld   c,$0C
    call call_00_32e1
    jp   call_00_36f7

call_02_5c18_EntityAction_Egg_unk0:
    ld   c,$30
    call call_00_3859
    jr   c,.jr_02_5C27
    ld   c,$04
    call call_00_32e1
    jp   call_00_36f7
.jr_02_5C27:
    call call_00_36da
    ld   c,$1E
    call call_00_32e1
    call call_00_36f7
    jr   nz,.jr_02_5C3D
    ld   c,$18
    call call_00_3859
    ret  nc
    call call_00_36bd
.jr_02_5C3D:
    ld   c,$30
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5c47_EntityAction_Egg_unk1:
    ld   c,$10
    call call_00_32e1
    call call_00_36f7
    call call_00_30af
    call call_00_3154
    ld   a,$02
    jp   nc,call_02_7102_SetEntityAction
    ret  

call_02_5c5b_EntityAction_Egg_unk2:
    ld   c,$00
    call call_00_3350
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5c69_EntityAction_Unk35_unk0:
    ld   a,[wD73B]
    and  a
    ld   a,$01
    jp   z,call_02_7102_SetEntityAction
    ret  

call_02_5c73_EntityAction_Unk35_unk1:
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5c7c_EntityAction_Unk36_Update:
    ret  

call_02_5c7d_EntityAction_FallingLava_unk0:
    call call_00_349c
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    call call_00_3817
    ret  nz
    ld   a,[wD73C]
    and  a,$3F
    or   a,$40
    ld   [hl],a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5c9c_EntityAction_FallingLava_unk1:
    call call_00_30af
    call call_00_3154
    ld   a,$00
    jp   nc,call_02_7102_SetEntityAction
    ret  

call_02_5ca8_EntityAction_LavaRaft_unk0:
    call call_00_34ea
    jr   z,.jr_02_5CB4
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5CB4:
    call call_00_3559
    jp   call_00_318d

call_02_5cba_EntityAction_LavaRaft_unk1:
    ret  

call_02_5cbb_EntityAction_PreHistoryMovingPlatform_Update:
    call call_00_34ea
    jr   z,.jr_02_5CC7
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_5CC7:
    call call_00_3559
    jp   call_00_318d

call_02_5ccd_EntityAction_Unk3A_Update:
    ret  

call_02_5cce_EntityAction_Unk3B_Update:
    ret  

call_02_5ccf_EntityAction_Pterosaur_Update:
    call call_00_30da
    jr   nc,.jr_02_5CDF
    call call_00_3345
    ld   c,$20
    bit  7,a
    jr   z,.jr_02_5D01
    jr   .jr_02_5CFF
.jr_02_5CDF:
    call call_00_380c
    jr   nz,.jr_02_5CFF
    ld   c,$30
    call call_00_3859
    jr   nc,.jr_02_5CFF
    ld   a,[wD20E_PlayerXPosition]
    and  a,$03
    inc  a
    ld   c,a
    call call_00_3802
    ld   c,$38
    call call_00_335a
    ld   c,$33
    call call_00_112f
.jr_02_5CFF:
    ld   c,$0C
.jr_02_5D01:
    call call_00_32e1
    call call_00_36f7
    call nz,call_00_3817
    ret  

call_02_5d0b_EntityAction_Unk3D_Update:
    ret  

call_02_5d0c_EntityAction_FallingBoulder_unk0:
    ld   hl,wD6EF_YPositionInMap
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    ld   de,$ffC0
    add  hl,de
    ld   e,l
    ld   d,h
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    xor  a,$09
    ld   l,a
    ld   a,[wD73B]
    and  a,$3F
    cp   [hl]
    ret  nz
    ld   c,$0F
    call call_00_3825
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5d37_EntityAction_FallingBoulder_unk1:
    call call_00_30af
    call call_00_3154
    ret  c
    ld   c,$31
    call call_00_112f
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_5d48_EntityAction_FallingBoulder_unk2:
    call call_00_3843
    ret  z
    ld   c,$13
    call call_00_3825
    ld   a,$03
    call call_02_7102_SetEntityAction
    ld   c,$04
    jp   call_00_3a23

call_02_5d5b_EntityAction_FallingBoulder_unk3:
    call call_00_3b8d
    ld   a,$00
    jp   z,call_02_7102_SetEntityAction
    farcall call_03_65b8
    ret  

call_02_5d6f_EntityAction_Unk3F_Update:
    ret  

call_02_5d70_EntityAction_BeetleVertical_Update:
    ld   c,$18
    call call_00_3859
    ld   c,$20
    jr   c,.jr_02_5D7B
    ld   c,$10
.jr_02_5D7B:
    call call_00_32e1
    jp   call_00_3760

call_02_5d81_EntityAction_BeetleHorizontal_Update:
    ld   c,$18
    call call_00_3859
    ld   c,$20
    jr   c,.jr_02_5D8C
    ld   c,$10
.jr_02_5D8C:
    call call_00_32e1
    jp   call_00_36f7

call_02_5d92_EntityAction_FirePlant_unk0:
    call call_00_3843
    ret  z
    call call_00_3817
    ret  nz
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    dec  [hl]
    ld   a,[hl]
    dec  l
    and  a,$03
    ld   [hl],a
    ld   c,$40
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5db2_EntityAction_FirePlant_unk1:
    call call_00_30af
    ld   bc,$0008
    call call_00_316e
    ret  c
    ld   c,$34
    call call_00_112f
    ld   c,$06
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   a,$02
    jp   call_02_7102_SetEntityAction

call_02_5dd3_EntityAction_FirePlant_unk2:
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5ddc_EntityAction_FirePlantProjectiles_unk0:
    ld   c,$06
    call call_00_3a23
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5de6_EntityAction_FirePlantProjectiles_unk1:
    call call_00_3b8d
    jp   z,call_00_3931
    farcall call_03_663a
    ret  

call_02_5df8_EntityAction_Geyser_unk0:
    ld   a,[wD73B]
    and  a
    ld   a,$01
    jp   z,call_02_7102_SetEntityAction
    ret  

call_02_5e02_EntityAction_Geyser_unk1:
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_5e0b_EntityAction_Unk46_Update:
    ret  

call_02_5e0c_EntityAction_Dinosaur_Update:
    ld   c,$10
    call call_00_32e1
    call call_00_36f7
    call call_00_30af
    call call_00_3154
    ret  c
    ld   c,$34
    call call_00_3859
    ld   c,$28
    call c,call_00_335a
    ret  

call_02_5e26_EntityAction_Triceratops_Update:
    call call_00_34ea
    jr   z,.jr_02_5E38
    ld   c,$07
    farcall call_0a_7b9a_SpawnEntityRelative
.jr_02_5E38:
    ld   c,$08
    call call_00_32e1
    call call_00_36f7
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
    ret  

call_02_5e91_EntityAction_Unk4A_Update:
    ret  

call_02_5e92_EntityAction_HangingBlade_Update:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_5EAF
    call call_00_30af
    call call_00_3154
    ret  c
    ld   c,$3C
    call call_00_3802
    ld   c,$01
    jp   call_00_37f8
.jr_02_5EAF:
    call call_00_3817
    ret  nz
    ld   c,$00
    call call_00_37f8
    ld   c,$40
    jp   call_00_335a

call_02_5ebd_EntityAction_Cannon_Update:
    ld   h,$D2
    data_02_5ebf:
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  7,[hl]
    ret  z
    res  7,[hl]
    ld   a,$20
.jr_02_5ECC:
    ld   l,a
    ld   a,[hl]
    cp   a,$4D
    ret  z
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_5ECC
    ld   hl,wD615
    ld   c,[hl]
    call call_00_3290
    ld   c,$0D
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   c,$30
    call call_00_112f
    ret  

call_02_5ef0_EntityAction_CannonProjectile_unk0:
    ld   c,$80
    call call_00_3802
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_5efa_EntityAction_CannonProjectile_unk1:
    call call_00_3817
    jp   z,call_00_3910
    ld   c,$02
    call call_00_3350
    call call_00_3442
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0A
    ld   l,a
    bit  5,[hl]
    ret  z
    ld   a,$20
.jr_02_5F15:
    ld   l,a
    ld   a,[hl]
    cp   a,$50
    jr   z,.jr_02_5F21
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_5F15
    ret  
.jr_02_5F21:
    ld   a,l
    or   a,$12
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$12
    ld   l,a
    ldi  a,[hl]
    sub  e
    add  a,$08
    cp   a,$10
    ret  nc
    ld   a,[hl]
    sub  d
    add  a,$08
    cp   a,$10
    ret  nc
    ld   hl,wD613
    dec  [hl]
    ld   hl,wD614
    ld   [hl],$80
    jp   call_00_3910

call_02_5f48_EntityAction_Dragonfly_Update:
    ld   c,$0C
    call call_00_32e1
    jp   call_00_36f7

call_02_5f50_EntityAction_DragonBodySegment_Update:
    ld   a,[wD614]
    and  a
    jr   z,.jr_02_5F5A
    dec  a
    ld   [wD614],a
.jr_02_5F5A:
    call call_02_613f_DragonHead_Sub2
    ld   a,[wD613]
    and  a
    jp   z,call_00_3985
    jp   call_02_6029_DragonHead_Sub1

call_02_5f67_EntityAction_DragonHead_Update:
    call call_02_613f_DragonHead_Sub2
    ld   a,[wD613]
    and  a
    jp   nz,.jr_02_5F79
    ld   a,$02
    ld   [wD78F],a
    jp   call_00_3985
.jr_02_5F79:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ldd  a,[hl]
    cp   a,$01
    jr   z,.jr_02_5F8A
    cp   a,$03
    jr   nz,.jr_02_5FA0
.jr_02_5F8A:
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_5FA0
    ld   c,$0C
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   c,$2F
    call call_00_112f
.jr_02_5FA0:
    call call_02_6029_DragonHead_Sub1
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ldd  a,[hl]
    add  a
    add  a
    add  a
    ld   c,a
    dec  c
    ld   a,[hl]
    ld   hl,.data_02_5fdf
.jr_02_5FB5:
    inc  c
    inc  hl
    cp   [hl]
    jr   nc,.jr_02_5FB5
    ld   a,c
    and  a,$1F
    ld   l,a
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_5fe9
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    ld   hl,wD588
    ld   a,c
    add  a,$73
    cp   [hl]
    ret  z
    ld   [hl],a
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],b
    ld   hl,wD60F_HDMATransferFlags
    set  1,[hl]
.data_02_5fdf:
    ret  
    db   $05, $0e, $17, $20, $32, $3b, $44        ;; 02:5fdf ????????
    db   $4d, $56
.data_02_5fe9:
    db   $00, $00, $01, $00, $02, $00        ;; 02:5fe7 ????????
    db   $03, $00, $04, $00, $05, $00, $06, $00        ;; 02:5fef ????????
    db   $07, $00, $08, $00, $07, $20, $06, $20        ;; 02:5ff7 ????????
    db   $05, $20, $04, $20, $03, $20, $02, $20        ;; 02:5fff ????????
    db   $01, $20, $00, $20, $01, $60, $02, $60        ;; 02:6007 ????????
    db   $03, $60, $04, $60, $05, $60, $06, $60        ;; 02:600f ????????
    db   $07, $60, $08, $60, $07, $40, $06, $40        ;; 02:6017 ????????
    db   $05, $40, $04, $40, $03, $40, $02, $40        ;; 02:601f ????????
    db   $01, $40
    
call_02_6029_DragonHead_Sub1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    inc  [hl]
    ld   a,[hl]
    sub  a,$52
    jr   nz,.jr_02_603D
    ld   [hl],a
    inc  l
    inc  [hl]
    res  2,[hl]
    dec  l
.jr_02_603D:
    inc  l
    ldd  a,[hl]
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_609b
    add  hl,de
    cp   a,$00
    jr   z,.jr_02_606C
    cp   a,$01
    jr   z,.jr_02_6064
    cp   a,$02
    jr   z,.jr_02_605A
    ldi  a,[hl]
    cpl  
    inc  a
    ld   c,a
    ld   e,[hl]
    jr   .jr_02_606F
.jr_02_605A:
    ldi  a,[hl]
    cpl  
    inc  a
    ld   e,a
    ld   a,[hl]
    cpl  
    inc  a
    ld   c,a
    jr   .jr_02_606F
.jr_02_6064:
    ld   c,[hl]
    inc  hl
    ld   a,[hl]
    cpl  
    inc  a
    ld   e,a
    jr   .jr_02_606F
.jr_02_606C:
    ld   e,[hl]
    inc  hl
    ld   c,[hl]
.jr_02_606F:
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
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    inc  l
    ld   [hl],c
    inc  l
    ld   [hl],b
    ret  
.data_02_609b:
    db   $00, $c6, $01, $c6        ;; 02:6097 ????????
    db   $02, $c6, $03, $c6, $04, $c6, $05, $c6        ;; 02:609f ????????
    db   $06, $c6, $07, $c6, $08, $c7, $09, $c7        ;; 02:60a7 ????????
    db   $0a, $c7, $0b, $c7, $0c, $c7, $0d, $c7        ;; 02:60af ????????
    db   $0e, $c8, $0f, $c8, $10, $c8, $11, $c9        ;; 02:60b7 ????????
    db   $12, $c9, $13, $c9, $14, $c9, $15, $ca        ;; 02:60bf ????????
    db   $16, $ca, $17, $cb, $18, $cb, $19, $cc        ;; 02:60c7 ????????
    db   $1a, $cc, $1b, $cd, $1c, $cd, $1d, $ce        ;; 02:60cf ????????
    db   $1e, $ce, $1f, $cf, $20, $cf, $21, $d0        ;; 02:60d7 ????????
    db   $22, $d1, $23, $d2, $24, $d3, $25, $d4        ;; 02:60df ????????
    db   $26, $d5, $27, $d6, $28, $d7, $29, $d8        ;; 02:60e7 ????????
    db   $2a, $d9, $2b, $da, $2c, $db, $2d, $dc        ;; 02:60ef ????????
    db   $2d, $dd, $2e, $de, $2f, $df, $30, $e0        ;; 02:60f7 ????????
    db   $30, $e1, $31, $e2, $31, $e3, $32, $e4        ;; 02:60ff ????????
    db   $32, $e5, $33, $e6, $33, $e7, $34, $e8        ;; 02:6107 ????????
    db   $34, $e9, $35, $ea, $35, $eb, $36, $ec        ;; 02:610f ????????
    db   $36, $ed, $36, $ee, $36, $ef, $37, $f0        ;; 02:6117 ????????
    db   $37, $f1, $37, $f2, $38, $f3, $38, $f4        ;; 02:611f ????????
    db   $38, $f5, $38, $f6, $38, $f7, $38, $f8        ;; 02:6127 ????????
    db   $39, $f9, $39, $fa, $39, $fb, $39, $fc        ;; 02:612f ????????
    db   $39, $fd, $39, $fe, $39, $ff, $39, $00        ;; 02:6137 ????????

call_02_613f_DragonHead_Sub2:    
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0A
    ld   l,a
    res  3,[hl]
    ld   a,[wD614]
    and  a,$02
    ret  z
    set  3,[hl]
    ret  

call_02_6152_EntityAction_DragonProjectile_unk0:
    ld   c,$80
    call call_00_3802
    call call_00_36bd
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_615f_EntityAction_DragonProjectile_unk1:
    call call_00_3817
    jp   z,call_00_3910
    ld   c,$02
    call call_00_3350
    jp   call_00_3442

call_02_616d_EntityAction_Unk51_Update:
    ret  

call_02_616e_EntityAction_Ninja_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_61BC
    bit  1,[hl]
    jr   nz,.jr_02_61E1
    bit  2,[hl]
    jr   nz,.jr_02_61FB
.jr_02_6182:
    ld   c,$14
    call call_00_3859
    jr   c,.jr_02_61AC
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$00
    ld   l,a
    ld   a,[hl]
    cp   a,$54
    jr   nz,.jr_02_61A4
    ld   c,$40
    call call_00_3859
    jr   nc,.jr_02_61CE
    ld   c,$20
    call call_00_3859
    jr   c,.jr_02_61F6
.jr_02_61A4:
    ld   c,$10
    call call_00_32e1
    jp   call_00_36f7
.jr_02_61AC:
    ld   c,$01
    call call_00_37f8
    ld   a,[wD20E_PlayerXPosition]
    and  a,$01
    add  a,$02
    ld   c,a
    call call_00_3802
.jr_02_61BC:
    call call_00_36bd
    call call_00_3817
    ld   a,$01
    jp   nz,call_02_7102_SetEntityAction
    ld   c,$00
    call call_00_37f8
    jr   .jr_02_6182
.jr_02_61CE:
    ld   c,$02
    call call_00_37f8
    ld   a,[wD20E_PlayerXPosition]
    rrca 
    rrca 
    rrca 
    and  a,$60
    or   a,$1F
    ld   c,a
    call call_00_3802
.jr_02_61E1:
    call call_00_3817
    jr   z,.jr_02_61F6
    and  a,$1F
    ld   a,$02
    jp   z,call_02_7102_SetEntityAction
    ld   c,$02
    call call_00_32e1
    call call_00_36f7
    ret  z
.jr_02_61F6:
    ld   c,$04
    call call_00_37f8
.jr_02_61FB:
    ld   c,$18
    call call_00_32e1
    call call_00_36f7
    ld   c,$20
    call call_00_3859
    ret  nc
    ld   c,$28
    call call_00_335a
    ld   a,$03
    jp   call_02_7102_SetEntityAction

call_02_6213_EntityAction_Ninja_unk1:
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_621c_EntityAction_Ninja_unk2:
    call call_00_36bd
    call call_00_3843
    ret  z
    ld   c,$04
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_6235_EntityAction_Ninja_Jump:
    call call_00_36f7
    call call_00_30af
    call call_00_3154
    ret  c
    ld   c,$00
    call call_00_37f8
    call call_00_36bd
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_624c_EntityAction_SamuraiBody_unk0:
    call call_00_34ea
    jr   z,.jr_02_625E
    ld   c,$05
    farcall call_0a_7b9a_SpawnEntityRelative
.jr_02_625E:
    ld   c,$10
    call call_00_32e1
    call call_00_36f7
    ld   c,$12
    call call_00_3859
    jr   nc,call_02_6275_SamuraiBody_Sub
    ld   a,$01
    call call_02_7102_SetEntityAction
    call call_00_36bd
call_02_6275_SamuraiBody_Sub:
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
.jr_02_6290:
    ld   l,a
    ld   a,[hl]
    cp   a,$56
    jr   z,.jr_02_629F
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_6290
    pop  af
    jp   call_00_3985
.jr_02_629F:
    ld   a,l
    or   a,$01
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$01
    jr   nz,.jr_02_62AC
    pop  af
    ret  
.jr_02_62AC:
    ld   a,l
    xor  a,$0C
    ld   l,a
    pop  af
    ld   [hl],a
    ld   a,l
    xor  a,$03
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
    ldi  [hl],a
    ret  

call_02_62c3_EntityAction_SamuraiBody_unk1:
    call call_00_3843
    ret  z
    ld   c,$12
    call call_00_3859
    ld   a,$00
    jr   nc,.jr_02_62D5
    call call_00_36bd
    ld   a,$01
.jr_02_62D5:
    call call_02_7102_SetEntityAction
    jp   call_02_6275_SamuraiBody_Sub

call_02_62db_EntityAction_SamuraiHead_unk0:
    ld   h,$D2
    ld   a,$20
.jr_02_62DF:
    ld   l,a
    ld   a,[hl]
    cp   a,$55
    jr   z,.jr_02_62EB
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_62DF
    ret  
.jr_02_62EB:
    ld   a,l
    or   a,$17
    ld   l,a
    bit  0,[hl]
    ret  z
    ld   c,$34
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_62fc_EntityAction_SamuraiHead_unk1:
    call call_00_30af
    call call_00_3154
    ret  c
    ld   a,[wD59E]
    and  a
    jr   z,.jr_02_6315
    ld   hl,.data_02_631f
    ld   de,wDA3B
    ld   bc,$0008
    call call_00_07b0_MemCopy
.jr_02_6315:
    ld   c,$19
    call call_00_3825
    ld   a,$02
    jp   call_02_7102_SetEntityAction
.data_02_631f:
    db   $00, $00, $00, $00, $96, $6e, $78, $77

call_02_6327_EntityAction_SamuraiHead_unk2:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    jp   nz,call_00_3985
    ret  

call_02_6335_EntityAction_Lizard_Update:
    ld   c,$14
    call call_00_32e1
    jp   call_00_36f7

call_02_633d_EntityAction_NinjaProjectile_unk0:
    ld   c,$ff
    call call_00_3802
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6347_EntityAction_NinjaProjectile_unk1:
    call call_00_3817
    jp   z,call_00_3910
    ld   c,$02
    call call_00_3350
    jp   call_00_3442

call_02_6355_EntityAction_SpikyLog_Update:
    ld   c,$10
    call call_00_32e1
    jp   call_00_3760

call_02_635d_EntityAction_Jar_unk0:
    call call_00_380c
    ret  z
    ld   c,$2D
    call call_00_112f
    ld   c,$00
    call call_00_3825
    ld   a,$01
    call call_02_7102_SetEntityAction
    ld   c,$05
    jp   call_00_3a23

call_02_6375_EntityAction_Jar_unk1:
    call call_00_3b8d
    jp   z,call_00_3985
    farcall call_03_6675
    ret  

call_02_6387_EntityAction_Unk5C_Update:
    ret  

call_02_6388_EntityAction_KungFuVanishingPlatform_unk0:
    call call_00_34ea
    jr   z,.jr_02_6394
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6394:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   l,a
    ld   a,[wD73B]
    cp   [hl]
    ret  nz
    ld   a,l
    xor  a,$03
    ld   l,a
    ld   [hl],$40
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_63ac_EntityAction_KungFuVanishingPlatform_unk1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    dec  [hl]
    ld   c,[hl]
    ld   a,l
    xor  a,$12
    ld   l,a
    res  3,[hl]
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
    set  3,[hl]
    ret  
.jr_02_63E1:
    ld   c,$00
    call call_00_382f
    ld   a,$02
    jp   call_02_7102_SetEntityAction
.data_02_63eb:
    db   $00, $01, $11, $11, $55, $55, $55, $ff
.data_02_63f3:
    db   $01, $02, $04, $08, $10, $20, $40, $80

call_02_63fb_EntityAction_KungFuVanishingPlatform_unk2:
    call call_00_3843
    ret  z
    ld   c,$10
    call call_00_382f
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_6409_EntityAction_KungFuMovingPlatform_Update:
    call call_00_34ea
    jr   z,.jr_02_6415
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6415:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ld   a,[hl]
    cp   a,$ff
    jr   z,.jr_02_642E
    and  a,$0F
    ld   l,a
    ld   h,$00
    ld   de,wD78B
    add  hl,de
    ld   a,[hl]
    and  a
    ret  z
.jr_02_642E:
    call call_00_3559
    jp   call_00_318d

call_02_6434_EntityAction_Unk60_Update:
    ret  

call_02_6435_EntityAction_MovingRaft_Update:
    call call_00_34ea
    jr   z,.jr_02_6441
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6441:
    call call_00_3559
    jp   call_00_318d

call_02_6447_EntityAction_StationaryRaft_Update:
    ret  

call_02_6448_EntityAction_Unk63_Update:
    ret  

call_02_6449_EntityAction_Unk64_Update:
    ret  

call_02_644a_EntityAction_RezopolisSpecialMovingPlatform_Update:
    call call_00_34ea
    jr   z,.jr_02_6456
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6456:
    ld   hl,wD210_PlayerYPosition
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   a,$0A
    jr   z,.jr_02_6484
    call call_00_34f5
    bit  0,b
    jr   nz,.jr_02_648A
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    ld   a,[hl]
    cp   a,$10
    jr   z,.jr_02_647F
    inc  [hl]
    ld   bc,$0001
    call call_00_37d8
.jr_02_647F:
    ld   a,[wD74D]
    and  a
    ret  z
.jr_02_6484:
    call call_00_3559
    jp   call_00_318d
.jr_02_648A:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    ld   a,[hl]
    and  a
    ret  z
    dec  [hl]
    ld   bc,$FFFF
    jp   call_00_37d8

call_02_649c_EntityAction_RezopolisMovingPlatform_Update:
    call call_00_34ea
    jr   z,.jr_02_64A8
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_64A8:
    call call_00_3559
    jp   call_00_318d

call_02_64ae_EntityAction_RedPlatform_Update:
    ld   c,$80
    call call_00_3290
    call call_00_34f5
    bit  1,[hl]
    jr   nz,.jr_02_64DA
    bit  0,[hl]
    jr   z,.jr_02_64E7
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    inc  l
    ld   a,[hl]
    cp   a,$0D
    jr   z,.jr_02_64D0
    inc  [hl]
    ld   bc,$0001
    jp   call_00_37d8
.jr_02_64D0:
    bit  0,b
    ret  nz
    dec  l
    ld   [hl],$f0
    dec  l
    set  1,[hl]
    ret  
.jr_02_64DA:
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
    bit  0,b
    jr   z,.jr_02_64FF
    inc  l
    inc  l
    ld   a,[hl]
    and  a
    jr   nz,.jr_02_64F8
    dec  l
    ld   [hl],$3C
    dec  l
    set  1,[hl]
    ret  
.jr_02_64F8:
    dec  l
    ld   [hl],$01
    dec  l
    ld   [hl],$01
    ret  
.jr_02_64FF:
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
    jp   call_00_37d8

call_02_650f_EntityAction_ActivatedRedPlatform_Update:
    ld   c,$80
    call call_00_3290
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    jr   z,.jr_02_654F
    bit  1,[hl]
    jr   nz,.jr_02_6544
    bit  2,[hl]
    jr   nz,.jr_02_6535
    inc  l
    dec  [hl]
    jr   nz,.jr_02_652F
    dec  l
    ld   [hl],$00
.jr_02_652F:
    ld   bc,$0001
    jp   call_00_37d8
.jr_02_6535:
    inc  l
    dec  [hl]
    jr   nz,.jr_02_653E
    ld   [hl],$f0
    dec  l
    set  1,[hl]
.jr_02_653E:
    db   01,$ff
    rst  $38
    jp   call_00_37d8
.jr_02_6544:
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$0D
    dec  l
    res  1,[hl]
    res  2,[hl]
    ret  
.jr_02_654F:
    ld   a,[wD617]
    cp   a,$40
    ret  c
    set  0,[hl]
    set  2,[hl]
    inc  l
    ld   [hl],$0D
    ret  

call_02_655d_EntityAction_TailspinPlatform_Update:
    call call_00_34f5
    bit  0,b
    jr   z,.jr_02_65A2
    ld   a,[wD201_PlayerEntity_ActionId]
    and  a,$1F
    cp   a,$0D
    jr   nz,.jr_02_65A2
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   c,h
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca 
    rrca 
    rrca 
    ld   l,a
    db   $26
    db   $00
    ld   de,wD30C
    add  hl,de
    ld   a,[hl]
    cp   c
    ret  nc
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   a,[hl]
    add  a,$01
    ldi  [hl],a
    ld   a,[hl]
    adc  a,$00
    ld   [hl],a
    ld   bc,$FFFF
    jp   call_00_37d8
.jr_02_65A2:
    ld   a,l
    xor  a,$0D
    ld   l,a
    ldd  a,[hl]
    or   [hl]
    ret  z
    ld   a,[hl]
    sub  a,$01
    ldi  [hl],a
    ld   a,[hl]
    sbc  a,$00
    ld   [hl],a
    ld   bc,$0001
    jp   call_00_37d8

call_02_65b7_EntityAction_TailspinGear_unk0:
    call call_02_6611_TailSpinGear_Sub2
    ld   c,$00
    ld   b,$01
    jr   call_02_65E2_TailSpinGear_Sub1

call_02_65c0_EntityAction_TailspinGear_unk1:
    call call_02_6611_TailSpinGear_Sub2
    ld   c,$00
    ld   b,$02
    jr   call_02_65E2_TailSpinGear_Sub1

call_02_65c9_EntityAction_TailspinGear_unk2:
    call call_02_6611_TailSpinGear_Sub2
    ld   c,$01
    ld   b,$03
    jr   call_02_65E2_TailSpinGear_Sub1

call_02_65d2_EntityAction_TailspinGear_unk3:
    call call_02_6611_TailSpinGear_Sub2
    ld   c,$02
    ld   b,$04
    jr   call_02_65E2_TailSpinGear_Sub1

call_02_65db_EntityAction_TailspinGear_unk4:
    call call_02_661B_TailSpinGear_Sub3
    ld   c,$03
    ld   b,$04
call_02_65E2_TailSpinGear_Sub1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  0,[hl]
    jr   z,.jr_02_65F4
    ld   c,b
    ld   a,b
    cp   a,$01
    jr   z,.jr_02_65fa
.jr_02_65F4:
    push bc
    call call_00_3843
    pop  bc
    ret  z
.jr_02_65fa:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$01
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   c
    ld   a,c
    ret  z
    call call_02_7102_SetEntityAction
    ld   c,$35
    call call_00_112f
    ret  

call_02_6611_TailSpinGear_Sub2:
    ld   a,[wD617]
    and  a
    ret  z
    dec  a
    ld   [wD617],a
    ret  

call_02_661B_TailSpinGear_Sub3:
    ld   a,[wD617]
    cp   a,$40
    ret  nc
    inc  a
    ld   [wD617],a
    ret  
    
call_02_6626_EntityAction_Unk6B_Update:
    ret  
    
call_02_6627_EntityAction_Unk6C_Update:
    ret  
    
call_02_6628_EntityAction_Unk6D_Update:
    ret  
    
call_02_6629_EntityAction_GreenMonster_unk0:
    ld   c,$18
    call call_00_32e1
    call call_00_36f7
    ret  
    
call_02_6632_EntityAction_GreenMonster_unk1:
    ret  
    
call_02_6633_EntityAction_GreenMonster_unk2:
    ret  
    
call_02_6634_EntityAction_Unk6F_Update:
    ret  
    
call_02_6635_EntityAction_Unk6F_Update:
    ret  
    
call_02_6636_EntityAction_Pincer_Update:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   c,$00
    bit  0,[hl]
    jr   z,.jr_02_6646
    ld   c,$40
.jr_02_6646:
    xor  a,$14
    ld   l,a
    ld   [hl],c
    ret  
    
call_02_664b_EntityAction_Flamethrower_unk0:
    ret  
    
call_02_664c_EntityAction_Flamethrower_unk1:
    ret  
    
call_02_664d_EntityAction_UFO_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_6662
    ld   c,$08
    call call_00_32e1
    call call_00_3760
    ret  
.jr_02_6662:
    ld   c,$08
    call call_00_32e1
    call call_00_36f7
    ret  
    
call_02_666b_EntityAction_UFO_unk1:
    ret  

call_02_666c_EntityAction_AntSpawner_Update:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],$20
    xor  a,$1A
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_66B4
    ld   a,[wD649_CollectibleAmount]
    and  a
    ret  z
    ld   a,[wD617]
    cp   a,$40
    ret  c
    set  0,[hl]
    inc  l
    ld   [hl],$78
    ld   c,$00
    ld   a,$20
.jr_02_6691:
    ld   l,a
    ld   a,[hl]
    cp   a,$74
    jr   nz,.jr_02_6698
    inc  c
.jr_02_6698:
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_6691
    ld   a,c
    cp   a,$02
    ret  nc
    ld   c,$0E
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   c,$06
    call call_00_112f
    ret  
.jr_02_66B4:
    inc  l
    dec  [hl]
    ret  nz
    dec  l
    res  0,[hl]
    ret  

call_02_66bb_EntityAction_Ant_Update:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   a,$19
    jr   c,.jr_02_66D3
    cp   a,$21
    jp   c,call_00_3931
.jr_02_66D3:
    ld   c,$0C
    call call_00_32e1
    jp   call_00_36f7

call_02_66db_EntityAction_CircuitCentralAnt_Update:
    ld   c,$0C
    call call_00_32e1
    jp   call_00_36f7

call_02_66e3_EntityAction_Capacitor_unk0:
    call call_00_3843
    ret  z
    ld   c,$30
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_66f1_EntityAction_Capacitor_unk1:
    call call_00_30af
    call call_00_3154
    ld   a,$00
    call nc,call_02_7102_SetEntityAction
    ret  

call_02_66fd_EntityAction_PowerUp_unk0:
    call call_00_3843
    ret  z
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],$60
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6710_EntityAction_PowerUp_unk1:
    call call_00_3843
    ret  z
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],$00
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_6723_EntityAction_Unk79_Update:
    ret  

call_02_6724_EntityAction_LittleRobot_unk0:
    call call_00_34ea
    jr   z,.jr_02_6736
    ld   c,$09
    farcall call_0a_7b9a_SpawnEntityRelative
.jr_02_6736:
    ld   c,$08
    call call_00_32e1
    call call_00_36f7
    ld   a,$01
    call nz,call_02_7102_SetEntityAction
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    xor  a,$03
    ld   l,a
    ld   c,[hl]
    ld   a,$20
.jr_02_6754:
    ld   l,a
    ld   a,[hl]
    cp   a,$7B
    jr   z,.jr_02_6760
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_6754
    ret  
.jr_02_6760:
    ld   a,l
    or   a,$0E
    ld   l,a
    ld   [hl],e
    inc  l
    ld   [hl],d
    xor  a,$03
    ld   l,a
    ld   [hl],c
    ret  

call_02_676c_EntityAction_LittleRobot_unk1:
    call call_00_3843
    ld   a,$00
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_6775_EntityAction_LittleRobotGear_Update:
    ld   h,$D2
    ld   a,$20
.jr_02_6779:
    ld   l,a
    ld   a,[hl]
    cp   a,$7A
    ret  z
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_6779
    jp   call_00_3910

call_02_6786_EntityAction_ElectricBall_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   l,a
    ld   a,[wD73B]
    cp   [hl]
    ret  nz
    dec  l
    ld   [hl],$00
    call call_02_680e_ElectricBall_Sub
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_679e_EntityAction_ElectricBall_unk1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    ld   a,[hl]
    rrca 
    rrca 
    and  a,$3C
    ld   e,a
    ld   d,$00
    ld   hl,.data_02_67ce
    add  hl,de
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    inc  hl
    push bc
    ld   c,[hl]
    inc  hl
    ld   b,[hl]
    call call_00_37d8
    pop  bc
    call call_00_37c9
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$18
    ld   l,a
    dec  [hl]
    call z,call_02_680e_ElectricBall_Sub
    ret  
.data_02_67ce:
    db   $00, $00, $00        ;; 02:67c9 ????????
    db   $00, $02, $00, $00, $00, $fe, $ff, $00        ;; 02:67d1 ????????
    db   $00, $02, $00, $00, $00, $00, $00, $fe        ;; 02:67d9 ????????
    db   $ff, $02, $00, $fe, $ff, $fe, $ff, $fe        ;; 02:67e1 ????????
    db   $ff, $02, $00, $fe, $ff, $00, $00, $02        ;; 02:67e9 ????????
    db   $00, $02, $00, $02, $00, $fe, $ff, $02        ;; 02:67f1 ????????
    db   $00, $02, $00, $02, $00, $00, $00, $02        ;; 02:67f9 ????????
    db   $00, $02, $00, $02, $00, $fe, $ff, $02        ;; 02:6801 ????????
    db   $00, $02, $00, $02, $00

call_02_680e_ElectricBall_Sub:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ld   c,[hl]
    inc  [hl]
    dec  l
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_683c
    add  hl,de
    ld   e,[hl]
    inc  hl
    ld   d,[hl]
    ld   l,c
    ld   h,$00
    add  hl,hl
    add  hl,de
    ld   d,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   e,a
    ldi  a,[hl]
    cp   a,$ff
    jp   z,call_00_3910
    ld   [de],a
    inc  e
    ld   a,[hl]
    ld   [de],a
    ret  
.data_02_683c:
    db   $50, $68, $57, $68, $5e        ;; 02:6839 ????????
    db   $68, $65, $68, $70, $68, $83, $68, $8a        ;; 02:6841 ????????
    db   $68, $8d, $68, $98, $68, $9f, $68, $10        ;; 02:6849 ????????
    db   $2e, $90, $10, $10, $3c, $ff, $10, $3e        ;; 02:6851 ????????
    db   $90, $20, $10, $5c, $ff, $10, $5e, $90        ;; 02:6859 ????????
    db   $10, $10, $2c, $ff, $10, $4e, $90, $10        ;; 02:6861 ????????
    db   $10, $70, $90, $20, $10, $5c, $ff, $10        ;; 02:6869 ????????
    db   $5e, $90, $10, $10, $40, $90, $10, $10        ;; 02:6871 ????????
    db   $50, $50, $10, $10, $40, $50, $10, $10        ;; 02:6879 ????????
    db   $0c, $ff, $10, $ee, $10, $f0, $10, $8c        ;; 02:6881 ????????
    db   $ff, $10, $6a, $ff, $10, $3e, $90, $10        ;; 02:6889 ????????
    db   $10, $2c, $50, $10, $10, $20, $ff, $10        ;; 02:6891 ????????
    db   $2e, $90, $10, $10, $1c, $ff, $10, $6e        ;; 02:6899 ????????
    db   $90, $20, $10, $4c, $50, $20, $10, $54        ;; 02:68a1 ????????
    db   $90, $10, $10, $4c, $50, $10, $10, $30        ;; 02:68a9 ????????
    db   $50, $20, $10, $f0, $10, $54, $90, $10        ;; 02:68b1 ????????
    db   $10, $40, $90, $10, $10, $5c, $ff

call_02_68c0_EntityAction_CircuitCentralMovingPlatform_Update:
    call call_00_34ea
    call nz,.jr_02_68D6
    call call_00_3559
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   l,a
    dec  [hl]
    call z,.jr_02_68D6
    ret  
.jr_02_68D6:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ld   c,[hl]
    inc  [hl]
    dec  l
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_6915
    add  hl,de
    ld   e,[hl]
    inc  hl
    ld   d,[hl]
    ld   b,$00
    ld   l,c
    ld   h,b
    add  hl,hl
    add  hl,bc
    add  hl,de
    ld   d,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   e,a
    ldi  a,[hl]
    cp   a,$ff
    jr   z,.jr_02_6909
    ld   [de],a
    inc  e
.jr_02_6902:
    ldi  a,[hl]
    ld   [de],a
    inc  e
    inc  e
    ld   a,[hl]
    ld   [de],a
    ret  
.jr_02_6909:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    ld   [hl],$00
    jr   .jr_02_68D6
.data_02_6915:
    db   $1d, $69, $2a, $69        ;; 02:6911 ????????  
    db   $43, $69, $5c, $69, $e0, $10, $f0, $a0        ;; 02:6919 ????????
    db   $10, $10, $a0, $f0, $f0, $e0, $f0, $10        ;; 02:6921 ????????
    db   $ff, $80, $f0, $00, $80, $f0, $00, $80        ;; 02:6929 ????????
    db   $f0, $00, $80, $f0, $00, $80, $10, $00        ;; 02:6931 ????????
    db   $80, $10, $00, $80, $10, $00, $80, $10        ;; 02:6939 ????????
    db   $00, $ff, $e0, $f0, $00, $e0, $f0, $00        ;; 02:6941 ????????
    db   $20, $f0, $00, $80, $10, $f0, $80, $10        ;; 02:6949 ????????
    db   $f0, $e0, $10, $00, $80, $00, $10, $80        ;; 02:6951 ????????
    db   $00, $10, $ff, $e0, $f0, $f0, $e0, $10        ;; 02:6959 ????????
    db   $f0, $e0, $f0, $f0, $e0, $10, $10, $e0        ;; 02:6961 ????????
    db   $f0, $10, $e0, $10, $10, $ff

call_02_696f_EntityAction_CircuitCentralPoweredPlatform_unk0:
    call call_00_34ea
    jr   z,.jr_02_697B
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_697B:
    call call_00_34f5
    bit  0,b
    ret  z
    ld   a,[wD751]
    ld   e,a
    ld   a,[wD752]
    or   e
    ret  z
    set  2,[hl]
    set  0,[hl]
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6993_EntityAction_CircuitCentralPoweredPlatform_unk1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  3,[hl]
    jr   z,.jr_02_69BE
    bit  0,[hl]
    jr   nz,.jr_02_69BE
    ld   a,[hl]
    and  a,$c0
    ld   c,a
    ld   a,[hl]
    rlca 
    rlca 
    and  a,$c0
    sub  c
    jr   nz,.jr_02_69B6
    res  2,[hl]
    ld   a,$00
    jp   call_02_7102_SetEntityAction
.jr_02_69B6:
    inc  l
    ld   [hl],$B4
    ld   a,$02
    jp   call_02_7102_SetEntityAction
.jr_02_69BE:
    call call_00_3559
    jp   call_00_318d

call_02_69c4_EntityAction_CircuitCentralPoweredPlatform_unk2:
    call call_00_3817
    ret  nz
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    set  0,[hl]
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_69d7_EntityAction_CircuitCentralLoweringPlatform_Update:
    call call_00_34f5
    bit  1,[hl]
    jr   nz,.jr_02_69FE
    bit  0,[hl]
    jr   z,.jr_02_6A0B
    inc  l
    dec  [hl]
    ret  nz
    ld   [hl],$04
    inc  l
    ld   a,[hl]
    cp   a,$20
    jr   z,.jr_02_69F4
    inc  [hl]
    ld   bc,$0001
    jp   call_00_37d8
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
    jp   call_00_37d8

call_02_6a33_EntityAction_WalkerRobot_Update:
    ld   c,$18
    call call_00_32e1
    jp   call_00_36f7

call_02_6a3b_EntityAction_PoweredWalkway_Update:
    ret  

call_02_6a3c_EntityAction_WalkwayActivator_Update:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   l,[hl]
    dec  l
    ld   h,$00
    ld   de,wD5A3
    add  hl,de
    ld   c,$00
    ld   a,[hl]
    and  a
    jr   z,.jr_02_6A54
    ld   c,$10
.jr_02_6A54:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$14
    ld   l,a
    ld   [hl],c
    ld   hl,wD20E_PlayerXPosition
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   c,h
    ld   a,[wD300_CurrentEntityAddrLo]
    rrca 
    rrca 
    rrca 
    ld   l,a
    ld   h,$00
    ld   de,wD309
    add  hl,de
    ldi  a,[hl]
    cp   c
    ret  c
    ld   a,c
    cp   [hl]
    ret  c
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ld   a,[wD20E_PlayerXPosition]
    ldi  [hl],a
    ld   a,[wD20F_PlayerXPosition]
    ld   [hl],a
    ret  

call_02_6a8b_EntityAction_ArcedGunProjectile_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   a,[wD73B]
    and  a,$3F
    cp   [hl]
    ret  nz
    call call_02_6bcd_GunProjectile_Sub3
    ld   c,$02
    call call_00_3350
    ld   c,$30
    call call_00_335a
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6aac_EntityAction_ArcedGunProjectile_unk1:
    call call_00_3442
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_6AC4
    call call_00_30da
    jp   nc,call_02_6c03_GunProjectile_Sub
    jp   call_02_6bf8_GunProjectile_Sub2
.jr_02_6AC4:
    call call_00_30af
    ld   bc,hFFF1
    call call_00_316e
    jp   nc,call_02_6c03_GunProjectile_Sub
    jp   call_02_6bf8_GunProjectile_Sub2

call_02_6ad3_EntityAction_ArcedGunProjectile2_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   a,[wD73B]
    and  a,$3F
    cp   [hl]
    ret  nz
    call call_02_6bcd_GunProjectile_Sub3
    ld   c,$02
    call call_00_3350
    ld   c,$30
    call call_00_335a
    ld   c,$f0
    call call_00_3802
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6af9_EntityAction_ArcedGunProjectile2_unk1:
    call call_00_3442
    call call_00_3817
    jp   z,call_02_6c03_GunProjectile_Sub
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_6B17
    call call_00_30da
    jp   nc,call_02_6c03_GunProjectile_Sub
    jp   call_02_6bf8_GunProjectile_Sub2
.jr_02_6B17:
    call call_00_30af
    call call_00_3345
    bit  7,a
    ld   a,$02
    jp   nz,call_02_7102_SetEntityAction
    ld   bc,hFFF1
    call call_00_316e
    jp   nc,call_02_6c03_GunProjectile_Sub
    jp   call_02_6bf8_GunProjectile_Sub2

call_02_6b30_EntityAction_ArcedGunProjectile2_unk2:
    call call_00_3442
    call call_00_3817
    jr   z,.jr_02_6B3E
    ld   c,$08
    call call_00_3859
    ret  nc
.jr_02_6B3E:
    ld   a,$03
    jp   call_02_7102_SetEntityAction

call_02_6b43_EntityAction_ArcedGunProjectile2_unk3:
    call call_00_3442
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_6B5B
    call call_00_30da
    jp   nc,call_02_6c03_GunProjectile_Sub
    jp   call_02_6bf8_GunProjectile_Sub2
.jr_02_6B5B:
    call call_00_30af
    ld   bc,hFFF1
    call call_00_316e
    jp   nc,call_02_6c03_GunProjectile_Sub
    jp   call_02_6bf8_GunProjectile_Sub2

call_02_6b6a_EntityAction_GunProjectile_unk0:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   a,[wD73B]
    and  a,$3F
    cp   [hl]
    ret  nz
    call call_02_6bcd_GunProjectile_Sub3
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6b81_EntityAction_GunProjectile_unk1:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1A
    ld   l,a
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
    ld   de,wD30C
    add  hl,de
    ld   a,[hl]
    cp   b
    jr   z,call_02_6c03_GunProjectile_Sub
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
    ld   de,wD30B
    add  hl,de
    ld   a,[hl]
    cp   b
    jr   z,call_02_6c03_GunProjectile_Sub
    ld   c,$30
.jr_02_6bc4:
    call call_00_3316
    call call_00_3597
    jp   call_02_6bf8_GunProjectile_Sub2

call_02_6bcd_GunProjectile_Sub3:
    ld   c,$36
    call call_00_112f
    ld   c,$1E
    call call_00_3825
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1C
    ld   l,a
    xor  a
    ldi  [hl],a
    ldi  [hl],a
    ldi  [hl],a
    ld   [hl],a
    ld   a,l
    xor  a,$05
    ld   l,a
    bit  0,[hl]
    jr   nz,.jr_02_6BF2
    ld   bc,$0010
    jp   call_00_37d8
.jr_02_6BF2:
    ld   bc,hFFF0
    jp   call_00_37d8

call_02_6bf8_GunProjectile_Sub2:
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$17
    ld   l,a
    bit  7,[hl]
    ret  z
call_02_6c03_GunProjectile_Sub:
    ld   c,$37
    call call_00_112f
    ld   c,$0A
    farcall call_0a_7b9a_SpawnEntityRelative
    jp   call_00_3910

call_02_6c18_EntityAction_Rez_unk0:
    call call_00_34ea
    jr   z,.jr_02_6C38
    ld   a,$0A
    ld   [wD616],a
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0E
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   a,$73
    ld   a,$08
    jp   nc,call_02_7102_SetEntityAction
.jr_02_6C38:
    call call_00_3843
    ld   a,$02
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_6c41_EntityAction_Rez_unk1:
    ret  

call_02_6c42_EntityAction_Rez_unk3:
    call call_00_3843
    ld   a,$02
    call nz,call_02_7102_SetEntityAction
call_02_6c4a_EntityAction_Rez_unk2:
    ld   a,[wD73B]
    and  a,$03
    jr   nz,.jr_02_6C7C
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ld   e,[hl]
    inc  l
    ld   d,[hl]
    ld   a,[wD210_PlayerYPosition]
    sub  a,$08
    ld   l,a
    ld   a,[wD211_PlayerYPosition]
    sbc  a,$00
    ld   h,a
    ld   bc,$0001
    ld   a,e
    sub  l
    ld   e,a
    ld   a,d
    sbc  h
    ld   d,a
    jr   c,.jr_02_6C79
    or   e
    jr   z,.jr_02_6C7C
    ld   bc,$FFFF
.jr_02_6C79:
    call call_00_37d8
.jr_02_6C7C:
    call call_00_36bd
    jp   call_00_3251

call_02_6c82_EntityAction_Rez_unk4:
    call call_00_3843
    ret  z
    ld   a,$03
    call call_02_7102_SetEntityAction
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$1B
    ld   l,a
    ld   a,[hl]
    cp   a,$19
    ret  c
    dec  [hl]
    ret  

call_02_6c99_EntityAction_Rez_unk5:
    call call_02_6Ca7_Rez_Unk5Sub
    ret  

call_02_6c9d_EntityAction_Rez_unk9:
    call call_00_3843
    ld   a,$08
    jp   nz,call_02_7102_SetEntityAction
    ret  

call_02_6ca6_EntityAction_Rez_unk10:
    ret  

call_02_6Ca7_Rez_Unk5Sub:
    ld   hl,wD616
    bit  7,[hl]
    ret  z
    res  7,[hl]
    dec  [hl]
    ld   a,$09
    jp   nz,call_02_7102_SetEntityAction
    ld   c,$11
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   c,$37
    call call_00_112f
    jp   call_00_3985

call_02_6cca_EntityAction_RezFollowingFire_Update:
    ld   h,$D2
    ld   a,$20
.jr_02_6CCE:
    ld   l,a
    ld   a,[hl]
    cp   a,$86
    jr   z,.jr_02_6CDA
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_6CCE
    ret  
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

call_02_6d11_EntityAction_Unk87_Update:
    call call_00_34ea
    jr   z,.jr_02_6D1D
    ld   a,l
    xor  a,$10
    ld   l,a
    ldd  a,[hl]
    dec  l
    ld   [hl],a
.jr_02_6D1D:
    call call_00_3559
    jp   call_00_318d

call_02_6d23_EntityAction_Unk88_Update:
    ret  

call_02_6d24_EntityAction_GunProjectileExplosion_Update:
    call call_00_3843
    jp   nz,call_00_3910
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$07
    ld   l,a
    ld   l,[hl]
    ld   h,$00
    add  hl,hl
    ld   de,.data_02_6d4f
    add  hl,de
    ld   e,[hl]
    inc  hl
    ld   d,[hl]
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$0D
    ld   l,a
    ld   [hl],e
    xor  a,$07
    ld   l,a
    ld   a,[hl]
    res  3,a
    or   d
    ld   [hl],a
    ret  
.data_02_6d4f:
    db   $00, $00, $20, $00, $00, $00, $00, $08
    db   $20, $00, $00, $08, $00, $00

call_02_6d5d_EntityAction_Unk8B_unk0:
    call call_00_30af
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$10
    ld   l,a
    ldi  a,[hl]
    ld   h,[hl]
    ld   l,a
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ld   a,h
    cp   a,$7D
    ret  c
    ld   hl,wD616
    set  7,[hl]
    ld   c,$38
    call call_00_112f
    jp   call_00_3931

call_02_6d7f_EntityAction_Unk8B_unk1:
    ret  

call_02_6d80_EntityAction_FinalBattleButton_unk0:
    call call_00_34f5
    bit  0,b
    ret  z
    ld   a,[wD616]
    and  a,$7F
    ret  z
    ld   h,$D2
    ld   a,[wD300_CurrentEntityAddrLo]
    or   a,$19
    ld   l,a
    ld   a,[hl]
    cp   a,$01
    ld   c,$0F
    jr   z,.jr_02_6D9D
    ld   c,$10
.jr_02_6D9D:
    farcall call_0a_7b9a_SpawnEntityRelative
    ld   bc,$0005
    call call_00_37d8
    ld   c,$39
    call call_00_112f
    ld   a,$01
    jp   call_02_7102_SetEntityAction

call_02_6db8_EntityAction_FinalBattleButton_unk1:
    ld   h,$D2
    ld   a,$20
.jr_02_6DBC:
    ld   l,a
    ld   a,[hl]
    cp   a,$8C
    jr   nz,.jr_02_6DC8
    ld   a,[wD300_CurrentEntityAddrLo]
    cp   l
    jr   nz,.jr_02_6DCE
.jr_02_6DC8:
    ld   a,l
    add  a,$20
    jr   nz,.jr_02_6DBC
    ret  
.jr_02_6DCE:
    ld   a,l
    or   a,$01
    ld   l,a
    ld   a,[hl]
    and  a,$1F
    cp   a,$01
    ret  nz
    ld   bc,$FFFB
    call call_00_37d8
    ld   a,$00
    jp   call_02_7102_SetEntityAction

call_02_6de3_EntityAction_Unk8D_Update:
    call call_00_3843
    ret  z
    xor  a
    ld   [wD647],a
    ld   a,$13
    jp   call_02_4ccd

call_02_6df0_EntityAction_Unk8E_Update:
    ret  

call_02_6df1_EntityAction_MediaDimensionMovingPlatform_Update:
    call call_00_34ea                                  ;; 02:6df1 $cd $ea $34
    jr   Z, .jr_02_6dfd                                ;; 02:6df4 $28 $07
    ld   A, L                                          ;; 02:6df6 $7d
    xor  A, $10                                        ;; 02:6df7 $ee $10
    ld   L, A                                          ;; 02:6df9 $6f
    ld   A, [HL-]                                      ;; 02:6dfa $3a
    dec  L                                             ;; 02:6dfb $2d
    ld   [HL], A                                       ;; 02:6dfc $77
.jr_02_6dfd:
    ld   H, $d2                                        ;; 02:6dfd $26 $d2
    ld   A, [wD300_CurrentEntityAddrLo]                                    ;; 02:6dff $fa $00 $d3
    or   A, $1a                                        ;; 02:6e02 $f6 $1a
    ld   L, A                                          ;; 02:6e04 $6f
    ld   A, [HL]                                       ;; 02:6e05 $7e
    cp   A, $ff                                        ;; 02:6e06 $fe $ff
    jr   Z, .jr_02_6e11                                ;; 02:6e08 $28 $07
    ld   A, [wD64F]                                    ;; 02:6e0a $fa $4f $d6
    and  A, $7f                                        ;; 02:6e0d $e6 $7f
    cp   A, [HL]                                       ;; 02:6e0f $be
    ret  C                                             ;; 02:6e10 $d8
.jr_02_6e11:
    call call_00_3559                                  ;; 02:6e11 $cd $59 $35
    jp   call_00_318d                                    ;; 02:6e14 $c3 $8d $31
    